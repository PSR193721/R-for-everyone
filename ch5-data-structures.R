#######################
##### DATA FRAMES #####
#######################

# Create some vectors. Note, a vector is a 1D data structure where all elements are of the same type
x <- 1:10
y <- -4:5
q <- c("Hockey", "Football", "Baseball", "Curling", "Rugby", "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")

# create a data frame from the vectors that we have already defined. The vectors become the columns
# we can specify names for the columns like below. If we don't set column names, then R will use the vector names
theDF <- data.frame(First=x,Second=y,Sport=q)

class(theDF$Sport)

View(theDF)

# get dimensional info from the data frame.
nrow(theDF)
ncol(theDF)
dim(theDF)

# print out the column and row names.
names(theDF)
names(theDF)[3]
rownames(theDF)

# we can assign row indexes if we don't want to use the default values.
rownames(theDF) <- c("One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")
rownames(theDF)

# this will revert the row indices to the default.
rownames(theDF) <- NULL

# print the first rows
head(theDF)
head(theDF, n=7)

# print the last rows
tail(theDF)
tail(theDF, n=7)

# get the type of the variable
class(theDF)

# get a single column from the data frame by name
theDF$Sport

# get a single value from the data frame.
theDF[3,2]

# we can use vectors to select more than one row or column at a time
theDF[3, 2:3]

theDF[c(3,5), 2]

# since we're returning more than one column we get the column names with this call.
theDF[c(3,5), 2:3]

# get all rows, 3rd column
theDF[,3]

# get all rows and columns 2 & 3
theDF[,2:3]

# to get columns by name, use a character vector
theDF[, c("First", "Sport")]

# To get a column as a vector, access the column in the following ways:
theDF[, "Sport"]
class(theDF[,"Sport"])

theDF[["Sport"]]
class(theDF[["Sport"]])

# This approach returns a data frame
theDF["Sport"]
class(theDF["Sport"])

# this works too
theDF[,"Sport", drop=FALSE]
class(theDF[,"Sport", drop=FALSE])

# or...
theDF[, 3, drop=FALSE]
class(theDF[, 3, drop=FALSE])

#######################
######## LISTS ########
#######################

# Lists are container class that allows you to store a collection of arbitrary of objects.

# a list of 3 numerics
list(1,2,3)

# a list with a single vector
list(c(1,2,3))

# a list with two vectors
list3 <- list(c(1,2,3), 3:7)

# a list with a data frame and a vector
list(theDF, 1:10)

# and a last example:
list5 <- list(theDF, 1:10, list3)

# create an empty list with 4 elements
emptyList <- vector(mode = "list", length = 4)

# you can set the value of a list element by referencing its index
emptyList[3] = 14

# and we can add a new element by addressing a list index that does not exist
emptyList[5] = "R is the bomb"

# this creates all of the elements up to the 9th. The new elements will be NULL except the 9th which gets the value 42.
emptyList[9] <- 42 

emptyList["My Element"] <- "Goat 543"
emptyList["Mammy Doe Swoo"] <- 613

# in general, it's best to initialize a list with a size and the fill. Repeated append operations are computationally
# expensive, and so it should only be used sparingly.

#######################
###### MATRICES #######
#######################

# Matrices are much like data frames. They are two dimensional sets of values. All the data contained in a matrix
# must be of the same type. The typical data type is numeric.



