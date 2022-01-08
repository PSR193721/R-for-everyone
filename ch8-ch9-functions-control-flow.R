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


#######################
### 9.1 if and else ###
#######################


##################
### 9.2 switch ###
##################



##################
### 9.3 ifelse ###
##################



##########################
### 9.4 Compound Tests ###
##########################





