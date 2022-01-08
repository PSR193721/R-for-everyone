rm(list=ls())

################################
### Ch 8 Writing R Functions ###
################################

# Creating functions in R is super easy. The basic idea is very similar to other language. The primary difference is that in R
# a function must always be assigned to a variable when it is declared.

say.hello <- function() {
  print('Hello world!')
}

# in R the . character has no special meaning, so it can be used in variable declarations like any other character.

##############################
### 8.2 Function Arguments ###
##############################

# Like other languages, R functions can take arguments and typically will do.

hello.person <- function(name) {
  sprintf('Hello %s', name)
}

hello.person('the dude')
hello.person('Donny')
hello.person('Walter')

# adding more arguments works very much like other languages
hello.person <- function(first, last) {
  sprintf('Hello %s %s', first, last)
}

# setting arguments by position
hello.person('Gomer', 'Pile')

# setting args by name
hello.person(first='Gomer', last='Pile')
hello.person(last='Pile', first='Gomer')

# we can even call some args by position and others by name
hello.person('William', last = 'Shatner')

# or even by name and then position
hello.person(last = 'Shatner', 'Billy')

# you can even use just the first few chars of an argument name
hello.person(fir='Leonard', l='Euler')

###############################
### 8.2.1 Default Arguments ###
###############################

# Like many languages, R supports default values for arguments.
hello.person <- function(first, last='Doe') {
  sprintf('Hello %s %s', first, last)
}

hello.person('Jimmy')
hello.person('Steve', 'Prefontane')

#############################
### 8.2.2 Extra Arguments ###
#############################

# R provides an 'extra arguments' operator that can be handy for passing args through or just allowing your function
# to take an arbitrary number of arguments... like sprintf does.

hello.person('Jared', extra='Goodbye')

hello.person('Jared', 'lander', extra='Goodbye')

hello.person <- function(first, last='Doe', ...) {
  sprintf('Hello %s %s', first, last)
}

# now the function will accept the extra argument even though it does nothing with that argument.
hello.person('Jared', 'lander', extra='Goodbye')


#########################
### 8.3 Return Values ###
#########################

# There are two ways that a function can return a value in R. If the last statement outputs a value, R will return that.
# Otherwise, the return() statement can be used to explicitly return a value and exit out of the function. Having an
# explicit return statement is preferred.

double.num <- function(x) {
  x*2
}

double.num(5)

# using an explicit return statement
double.num <- function(x) {
  return (x*2)
}

double.num(10)

###################
### 8.4 do.call ###
###################

# do.call is a bit like eval in other languages where you can invoke an arbitrary function in code without referencing
# the function as an object, but rather passing a string and set of arguments to the that function via the do.call
# function.

do.call('hello.person', args = list(first='Jared', last='Lander'))

# can also pass in an object reference
do.call(hello.person, args = list(first='Jared', last='Lander'))

# this can be really useful when we want the user to invoke a specified function via a helper function.

run.this <- function(x, func=mean) {
  do.call(func, args = list(x))
}

run.this(1:10)

run.this(1:10, mean)

run.this(1:10, sum)

run.this(1:10, sd)


###############################
### Ch 9 Control Statements ###
###############################

# R provides standard control flow mechanisms and they function much the way you would expect.

x = 9

#######################
### 9.1 if and else ###
#######################

if(x > 9) {
  print('Bro')
} else if (x != 9) {
  print('Bruv')
} else {
  print('Rock on')
}

##################
### 9.2 switch ###
##################

# switch statements are a little funky in R:

use.switch <- function(x) {
  switch(x,
         "a"="first",
         "b"="second",
         "z"="last",
         "c"="third",
         "other")
}

use.switch("a")

# if we pass in a value that doesn't match any of the cases of the switch, then the default is returned.
use.switch("j")

# if we pass in a numeric value, then the switch cases are matched by position. If the position doesn't exist, the NULL is
# returned.
use.switch(1)
use.switch(5)

is.null(use.switch(6))

# note that we can use the built in R function is.null to test a variable for "nullness".

##################
### 9.3 ifelse ###
##################

# The ifelse construct in R works a lot like a ternary in other languages. One nice advantage that it has over the 
# tradition if/else flow is that it is vectorized, making for efficient processing of vectors.

# The first argument is the test, the second is the result if the test is true, and the third is returned if the test is
# false.

ifelse(1 == 1, "Yes", "No")

toTest <- c(1,1,0,1,0,1)

# here's an example of using ifelse on a vector.
ifelse(toTest == 1, TRUE, FALSE)

# we can also use the object itself in one or both or the result arguments.
ifelse(toTest == 1, toTest*3, "Zero")

# if the vector contains NA values, that will be returned
toTest[2] <- NA

ifelse(toTest == 1, "Yes", "No")

a <- c(1,1,0,1)
b <- c(2,1,0,1)

# this comparison is done element wise and a logit vector will be returned containing the results of the test for each element.
ifelse(a == 1 & b == 1, "yes", "no")

# In this case, only the first elements are compared and only a single result will be returned.
ifelse(a == 1 && b ==1, "yes", "no")

##########################
### 9.4 Compound Tests ###
##########################

# we can also do compound test, note that in the case of doube & or double |, these AND/OR statements will
# short circuit, making them efficient.
if (x > 9 && x < 23) {
  print('In the range!')
}

# Conditions can be grouped by parentheses and follow a set of rules akin to PEMDAS. AND is like multiplication and OR like
# addition.

