# Load libraries

library("rcompanion")
library("IDPmisc")
library("readr")

# Load Data
Seattle_ParksnRec <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/Seattle_ParksnRec.csv")
View(Seattle_ParksnRec)

# TO DO : Assess the skew of the distribution and then transform it if necessary for the following variables:
#   
#   # of trips Fall
#   # of participants Fall
#   # of trips per Year
#   # participants per Year
#   increase/decrease of prior year
#   Average # people per trip



## ---  1. # of trips Fall  ---  ##

# Plot Histogram
plotNormalHistogram(Seattle_ParksnRec$'# of trips Fall') # Looks positively skewed.

# Perfom transformation by sqrt
Seattle_ParksnRec$'# of trips Fall_Sqrt' <- sqrt(Seattle_ParksnRec$'# of trips Fall')

# Plot Histogram 
plotNormalHistogram(Seattle_ParksnRec$'# of trips Fall_Sqrt') # Still looks positively skewed.

# Perfom transformation by log function
Seattle_ParksnRec$'# of trips Fall_log' <- log(Seattle_ParksnRec$'# of trips Fall')

# Dropping all the infinite values 
Seattle_ParksnRec1 <- NaRV.omit(Seattle_ParksnRec)

#Plot Histogram
plotNormalHistogram(Seattle_ParksnRec1$'# of trips Fall_log') # Now it looks perfect normally distributed.

## --- '# of trips Fall_Sqrt' Variable looked Positvely skewed, performing the log function helped in making it normal. --- ##


## ---  2. # of participants Fall  ---  ##

# Plot Histogram
plotNormalHistogram(Seattle_ParksnRec$'# of participants Fall') # Looks as close to normal as possible, but a slight positively skewed.

# Perfom transformation by sqrt
Seattle_ParksnRec$'# of participants Fall_Sqrt' <- sqrt(Seattle_ParksnRec$'# of participants Fall')

# Plot Histogram 
plotNormalHistogram(Seattle_ParksnRec$'# of participants Fall_Sqrt') # Looks Normal now.

## --- '# of participants Fall_Sqrt' Variable looked very slight Positvely skewed, performing the sqrt function normalised it. --- ##


## ---  3. # of trips per year  ---  ##

# Plot Histogram
plotNormalHistogram(Seattle_ParksnRec$'# of trips per year') # Looks positively skewed.

# Perfom transformation by sqrt
Seattle_ParksnRec$'# of trips per year_Sqrt' <- sqrt(Seattle_ParksnRec$'# of trips per year')

# Plot Histogram 
plotNormalHistogram(Seattle_ParksnRec$'# of trips per year_Sqrt') # Looks slightly positively skewed still.

# Perfom transformation by log function
Seattle_ParksnRec$'# of trips per year_log' <- log(Seattle_ParksnRec$'# of trips per year')

# Dropping all the infinite values 
Seattle_ParksnRec1 <- NaRV.omit(Seattle_ParksnRec)

#Plot Histogram
plotNormalHistogram(Seattle_ParksnRec1$'# of trips per year_log') # Now it looks perfect normally distributed.

## --- '# of trips per year' Variable looked Positvely skewed, performing the log function normalised it. --- ##


## ---  4. # participants per year  ---  ##

# Plot Histogram
plotNormalHistogram(Seattle_ParksnRec$'# participants per year') # Looks slightly positively skewed.

# Perfom transformation by sqrt
Seattle_ParksnRec$'# participants per year_Sqrt' <- sqrt(Seattle_ParksnRec$'# participants per year')

# Plot Histogram 
plotNormalHistogram(Seattle_ParksnRec$'# participants per year_Sqrt') # Now it looks perfect normally distributed.

## --- '# participants per year' Variable looked Positvely skewed, performing the sqrt function normalised it. --- ##


## ---  5. increase/decrease of prior year  ---  ##

# Plot Histogram
plotNormalHistogram(Seattle_ParksnRec$'increase/decrease of prior year') # Looks slightly negatively skewed.

# Perfom transformation by square
Seattle_ParksnRec$'increase/decrease of prior year_Square' <- (Seattle_ParksnRec$'increase/decrease of prior year') ^ 2

# Plot Histogram 
plotNormalHistogram(Seattle_ParksnRec$'increase/decrease of prior year_Square') # This makes it even worse, and original looks more normal.

## --- 'increase/decrease of prior year' Variable is most normal in it's original data; performing transformation made it skewed. --- ##


## ---  6. Average # people per trip  ---  ##

# Plot Histogram
plotNormalHistogram(Seattle_ParksnRec$'Average # people per trip') # Looks normal but slightly positively skewed.

# Perfom transformation by sqrt
Seattle_ParksnRec$'Average # people per trip_Sqrt' <- sqrt(Seattle_ParksnRec$'Average # people per trip')

# Plot Histogram 
plotNormalHistogram(Seattle_ParksnRec$'Average # people per trip_Sqrt') # Looks as normal as possible.

## --- 'Average # people per trip' Variable looked slightly positvely skewed, performing the sqrt function normalised it even more. --- ##






























