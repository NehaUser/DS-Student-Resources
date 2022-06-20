# use the mtcars data frame to examine the effect that engine horsepower (hp) 
# and vehicle weight (wt), measured in thousands of pounds) 
# have on the time necessary to travel one quarter mile from a standing start (qsec).
# 
# Create a scatter plot with a trend line where the horizontal axis is engine horsepower 
# and the vertical axis is quarter mile time. What is the relationship between time and 
# engine horsepower: positively correlated, negatively correlated, or uncorrelated?
#   
#   Compute the linear regression for time and engine horsepower. 
# What is the equation of the line? What is the R-squared value? Is this what you would expect?
#   
#   Create a scatter plot with a trend line where the 
# horizontal axis is vehicle weight and the vertical axis is 
# quarter mile time. What is this relationship: positively correlated, negatively correlated, 
# or uncorrelated?
#   
#   Compute the linear regression fothese two variables. What is the equation of the line? 
#   What is the R-squared value? Is this what you would expect?
#   
#   Create a report (MS Powerpoint or equivalent) that shows your results and the code you used to generate the results. Please include your interpretation of the data 
# included and answer all the questions posed above.

# Include Libraries
library(DAAG) 
library(ggplot2)
library(dplyr)
library(reshape2)
library("PerformanceAnalytics") # to make correlation matrix
library("corrplot")

head(mtcars)
mtcars_dset <- mtcars[, c(4, 6, 7)]

#Create scatter plot where x axis is engine horsepower and y axis is quarter mile time.
mtcars_lReg <- lm(qsec ~ hp, mtcars_dset)

mtcars_lRegPlot <- ggplot(mtcars_lReg, aes(x= hp, y = qsec)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)
mtcars_lRegPlot
# The graph is negatively correlated because the dots show a trend from top to bottom.

summary(mtcars_lReg)
# R-squared value is .485, which means that horsepower explains 49% of the variance in the 
#quarter mile time.
# Linear Regression Equation 
# y = - .02x + 20.56

# Conclusion : More the horse power of engine, faster the car will move

#Scatter Plot for horizontal axis is vehicle weight and the vertical axis is 
# quarter mile time

mtcars_Plot <- ggplot(mtcars_dset, aes(x= wt, y = qsec)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)
mtcars_Plot

# The graph is uncorelated since the line falls flat
#linear regression
mtcars_lReg <- lm(qsec ~ wt, mtcars_dset)
summary(mtcars_lReg)

# The R-squared value os -0.0 it means there's no affect in variance of movement by the weight of vehicle.

#Linear Regression equation
# y = -.31x + 18.87
#Conclusion - I thought that if a car was heavier, it would be slower off the start but 
#it looks weights have no effect.



