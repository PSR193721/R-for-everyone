####################################
### Data Manipulation with Dplyr ###
####################################

library(tidyverse)

##############
### select ###
##############

# select works much like the select statement of a SQL query

diamonds %>% select(cut, price, color)

diamonds %>% select(c(cut, price, color))

# we can also use a variety of helper functions in dplyr in conjunction with select

diamonds %>% select(one_of('cut', 'price', 'color'))

diamonds %>% select(starts_with('c'))

diamonds %>%  select(ends_with('e'))

diamonds %>%  select(contains('l'))

# we can even use regular expressions to select columns
diamonds %>% select(matches('r.+t'))

# columns can be removed by use of the '-' operator
diamonds %>% select(-carat, -price)
diamonds %>% select(-c(carat, price))

##############
### filter ###
##############

# filter allows us to include or exclude rows of data
diamonds %>% filter(cut == 'Ideal')

# we can use all of the typical comparison operations and an IN function as well
diamonds %>% filter(cut %in% c('Ideal', 'Good'))

diamonds %>% filter(price >= 1000)

# we can do compound conditions with the &, |, and comma (,). The comma is equivalent to &.
diamonds %>% filter(carat > 2 & price < 14000)
diamonds %>% filter(carat < 1 | carat > 5)

#############
### slice ###
#############

# slice is just a way to extract rows based on their position in the data frame/tibble rather than their properties
diamonds %>% slice(1:5)

diamonds %>% slice(c(1:5, 8, 15:20))

# we can also exclude rows by using the - operator
diamonds %>% slice(-3)


##############
### mutate ###
##############

# mutate lets us add new columns to a tbl or modify an existing one.
diamonds %>% select(price, carat) %>% mutate(Ratio = price/carat)

# we can carry out multiple manipulations at once and we we can use the value of one new column in the computation
# of others
diamonds %>% select(price, carat) %>% mutate(Ratio = price/carat, Double=Ratio*2)

##################
### summaraise ###
##################

# summarize is the replacement for aggregate. It performs aggregate function operations, returning a single value
diamonds %>% summarise(mean(price))

# we can do multiple aggreations simultaneously
diamonds %>% summarise(AvgPrice=mean(price),
                       MedianPrice=median(price),
                       AvgCarat = mean(carat))

################
### group_by ###
################

# summarise really comes into its own when used in conjunction with the group_by function that works very similarly to the 
# way group by works in SQL.

diamonds %>% group_by(cut) %>% summarise(AvgPrice=mean(price))

# we can still do more than one aggregate function at once.
diamonds %>% group_by(cut) %>% summarise(AgePrice=mean(price), SumCarat = sum(carat))

# we can do multiple groupings as well
diamonds %>% group_by(cut, color) %>% summarise(AvgPrice=mean(price), SumCarat = sum(carat))

###############
### arrange ###
###############

# arrange is like the ORDER BY clause of a SQL statement. It's fast and easy to work with.
diamonds %>% 
  group_by(cut, color) %>% 
  summarise(AvgPrice=mean(price), SumCarat = sum(carat)) %>% 
  arrange(AvgPrice)

diamonds %>% 
  group_by(cut, color) %>% 
  summarise(AvgPrice=mean(price), SumCarat = sum(carat)) %>% 
  arrange(desc(AvgPrice))

##########
### do ###
##########

# do allows you to call arbitrary and custom functions on your data.

################
## databases ###
################

# dplyr can also be used with databases. Not surprisingly, the performance won't match that of an in memory
# data frame or tbl, but when dealing with very large amounts of data, that would be possible anyways and so
# the database option is a good one.