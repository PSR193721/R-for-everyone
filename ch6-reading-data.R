# start by clearning the environment.
rm(list=ls())

#########################
### Reading CSV Files ###
#########################

# There are a couple of standard ways of reading CSV files.

theUrl <- "https://www.jaredlander.com/data/TomatoFirst.csv"
# load the data into a data frame.
tomato <- read.table(theUrl, sep = ",", header = TRUE)

head(tomato)
class(tomato)

# the stringsAsFactors argument can be really useful when you don't want to have strings automatically converted to factors.
# This is especially good to know about when attempting to load very large data sets. These days the default seems to be FALSE
# instead of TRUE.
tomato <- read.table(theUrl, sep = ",", header = TRUE, stringsAsFactors = FALSE)

#########################
### 6.1.1 read_delim  ###
#########################
library(readr)
# For very large data sets, read.table can be pretty slow. There are much faster alternatives from the readr package, we have
# read_delim. This method returns a tibble instead of a data frame. readr and tibbles are part of the "tidyverse" and work well
# with dplyr and other tidyverse packages.
tomato <- read_delim(file=theUrl, delim = ",")
class(tomato)
head(tomato)

# The readr package contains some other handy functions: read_csv, read_csv2, and read_tsv which have the separators predefined:
# commas(,), semicolons (;), and tabs (\t) respectively.

#########################
###  6.2 Excel Data   ###
#########################
library(readxl)
# R has a very useful library for reading Excel files (readxl), which is a very common file format for data storage. This is
# another tidyverse package.

download.file(url="https://www.jaredlander.com/data/ExcelExample.xlsx", 
              destfile = "data/ExcelExample.xlsx", method = "curl")

# once downloaded, we can check what sheets are in the document.
excel_sheets('data/ExcelExample.xlsx')

# now we can read a sheet into a data frame.
tomatoXL <- read_excel('data/ExcelExample.xlsx')

# we can also specify which sheet to read. By default the first sheet is read in.
wineXL <- read_excel('data/ExcelExample.xlsx', sheet = 2)
head(wineXL)

# we can also specify the sheet by name.
wineXL <- read_excel('data/ExcelExample.xlsx', sheet = "Wine")
head(wineXL)

####################################
###  6.3 Reading From Databases  ###
####################################
library(RSQLite)
# R provides a number of different connection libraries for different database include a generic ODBC library. Here, we'll
# use the SQLite driver to connect to a local SQLite database.

download.file(url='https://www.jaredlander.com/data/diamonds.db', destfile = 'data/diamonds.db', method = "curl")

# First we have to setup the driver we'll use to make the connection
drv <- dbDriver('SQLite')

# Now we have to setup the connection object that we'll use to "talk" to the database.
conn <- dbConnect(drv, 'data/diamonds.db')

# we can explore the database with the following functions
dbListTables(conn)

dbListFields(conn, name = "diamonds")
dbListFields(conn, name = "DiamondColors")

# We can run queries against the database with the dbGetQuery function. A data frame is returned.
diamondsTable <- dbGetQuery(conn, 'SELECT * FROM diamonds', stringsAsFactors=FALSE)

# we can perform queries of arbitrary complexity.
longQuery <- 'SELECT * FROM diamonds, DiamondColors WHERE diamonds.color = DiamondColors.Color'
diamondsJoin <- dbGetQuery(conn, longQuery, stringsAsFactors=FALSE)

# It's good form to close the DB Connection when done with it.
dbDisconnect(conn)

##########################
### 6.5 R Binary Files ###
##########################

# R can serialize objects and variables to files for sharing or persisting data or the state of a script after running it. 
# The files are compatible with all operating systems so they are easy to share.

save(tomato, file='data/tomato.rdata')
rm(tomato)
head(tomato)

# we don't need to set an object to the results of the call to load. It will restore the variable or variables stored in the
# file to the environment. Since we can save more than one variable or object with save, we don't need to explicitly assign
# variables with the call to load().
load('data/tomato.rdata')

# now we'll save a few objects in an Rdata file
n <- 20
r <- 1:10
w <- data.frame(n, r)

save(n,r,w, file='data/multiple.rdata')

rm(n,r,w)

load('data/multiple.rdata')

# we can also use the saveRDS and readRDS functions. These functions can only serialize a single variable or object and the
# name of the variable is not stored so a new assignment must be done when calling readRDS.
smallVector <- c(1,5,4)
saveRDS(smallVector, file='data/thisObject.rds')
thatVect <- readRDS('data/thisObject.rds')

# check that the two vectors are the same.
identical(smallVector, thatVect)

#######################################
### 6.7 Extract Data From Web Sites ###
#######################################
library(rvest)

# There are a number of tools available for scraping data from web sites. The rvest library, part of the tidyverse, is a
# robust set of functions for performing these scrape operations.

ribalta <- read_html('https://www.jaredlander.com/data/ribalta.html')

# we can match elements by tags or classes and have full use of pipes
ribalta %>% html_nodes('.street')

# we can extract text from an element with the html_text function.
ribalta %>% html_nodes('.street') %>% html_text()

# and we can match elements by id and extract attribute data as well.
ribalta %>% html_nodes('#longitude') %>% html_attr('value')

# we can extract data from tables with html_table and the magrittr extract2 functions
ribalta %>% 
  html_nodes('table.food-items') %>% 
  magrittr::extract2(5) %>% 
  html_table()

#############################
### 6.8 Reading JSON Data ###
#############################
library(jsonlite)