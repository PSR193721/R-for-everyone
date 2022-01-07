# clean out the environment before starting
rm(list=ls())

# load the ggplot2 package.
library(ggplot2)

# We'll take a really quick look at the base plotting package and then jump straight into ggplot2, the leading graphics
# package in R programming.

?diamonds

#############################
### 7.1.1 Base Histograms ###
#############################

# Histograms are great for showing the frequency in the data of a single predictor.
hist(diamonds$carat, main="Carat Histogram", xlab="Carat")

################################
### 7.1.2 Base Scatter Plots ###
################################

# we can plot two predictors against each other using a formula and a specified data source
plot(price ~ carat, data=diamonds)

# or we can just plot two arbitrary vectors of data against each other
plot(diamonds$carat, diamonds$price, main='Diamond Price v Carat', xlab='Carat', ylab='Price')

###########################
### 7.1.3 Base Boxplots ###
###########################

# Box plots are a great way to see the general spread to the values for a given predictor
boxplot(diamonds$carat)

############################################
### 7.2.1 ggplot2 Histograms & Densities ###
############################################

# We associate the data source with the ggplot function. There's more we can do with that object, but for now we
# will leave it at that. We also need to specify geometries, which are the functions that create layers of
# visualization.

ggplot(data = diamonds) + geom_histogram(aes(carat))

# now we'll look at a density plot of the same data. While histograms are counts of discrete values in the data,
# a frequency for each value, a density plot is a continuous function that describes the probability of each value
# occurring in the data. Note the fill argument, that sets the colour used to fill the plot

ggplot(data=diamonds) + geom_density(aes(carat), fill='grey50', alpha=0.3)

##################################
### 7.2.2 ggplot2 Scatterplots ###
##################################

# scatter plots are really straight-forward with ggplot2
 + geom_point()

# we can do some really neat grouping of data using an idea called facets
g <- ggplot(data=diamonds, aes(x=carat, y=price))
g + geom_point(aes(color=color))

# first, we store the ggplot object in a variable so that we can reference it more easily. Next, we use the color
# argument of the aes object to represent a factor as color, adding extra dimensions to the plot without detracting
# from the interpretability of the graph. Notice that ggplot creates a legend automatically.

# We can use facets to create a separate chart for each factor
g + geom_point(aes(color=color)) + facet_wrap(~color)

# we can also use a facet grid to create charts where two predictors are plotted against each other creating a
# multi-dimensional effect. Here we using a formula to plot cut against clarity.
g + geom_point(aes(color=color)) + facet_grid(cut~clarity)

# faceting works with other geometries too. Here's an example using histograms
ggplot(data=diamonds, aes(x=carat)) + geom_histogram() + facet_wrap(~color)

#############################################
### 7.2.3 ggplot2 Boxplots & Violin Plots ###
#############################################

# ggplot has good support for boxplots. If you're doing a box plot against all members of the population, and not
# grouping by a factor, you need to set x=1. It's just a quirk of ggplot2.
ggplot(data=diamonds, aes(y=carat, x=1)) + geom_boxplot()

# we can also use facets to make sense of our data.
ggplot(data = diamonds, aes(y=carat, x=cut)) + geom_boxplot()

# Violin plots are a derivative of box plots that convey even more information about the distribution of a population.
ggplot(diamonds, aes(y=carat, x=cut)) + geom_violin()

# we can even plot different layers of data together in the same chart
ggplot(diamonds, aes(y=carat, x=cut)) + geom_violin() + geom_point()

#################################
### 7.2.4 ggplot2 Line Graphs ###
#################################

library(lubridate)

# line plots are super easy with ggplot
ggplot(economics, aes(x=date, y=pop)) + geom_line()

# the lubridate package provides nice data formatting functions to ggplot2.
# We'll create month and year variables and store them in the economics data frame
economics$year <- year(economics$date)
economics$month <- month(economics$date, label=TRUE)

# next we'll do some old skool filtering so filter out dates older than year 2000
econ2000 <- economics[which(economics$year >= 2000), ]

#load the scales package for nice axis formatting
library(scales)

# setup the ggplot object for use with plots
g <- ggplot(econ2000, aes(x=month, y=pop))

g <- g + geom_line(aes(color=factor(year), group=year))

# give a title to the legend
g <- g + scale_color_discrete(name="Year")

# format the y-axis
g <- g + scale_y_continuous(labels = comma)

# add a title and x-axis label
g <- g + labs(title="Population Growth", x="Month", y="Population")

# now plot the graph
g

####################
### 7.2.4 Themes ###
####################
library(ggthemes)

# themes allow for using out of the box styling for charts and graphs. The ggthemes package contains a number of nice
# themes that can be very easily applied to ggplot output.

g2 <- ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=color))

# we can a couple of different themes to this data
g2 + theme_economist() + scale_colour_economist()
g2 + theme_excel() + scale_colour_excel()
g2 + theme_tufte()
g2 + theme_wsj()
