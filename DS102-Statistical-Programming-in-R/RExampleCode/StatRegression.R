library(DAAG) 
library(ggplot2)
library(dplyr)
library(reshape2)

data("USArrests")
View(USArrests)
#Create linear regression. 
regressionModel <- lm(Assault ~ UrbanPop, USArrests)
summary(regressionModel)
# Since F-Statistic p-value> .05, overall model is NOT significant

#Make a scatter plot 
graphAssaults <- ggplot(USArrests, aes(x=UrbanPop, y= Assault )) +
geom_point() + geom_smooth(method = lm, se = FALSE)
graphAssaults
# example for no correlation
graphMurder <- ggplot(USArrests, aes(x=UrbanPop, y= Murder )) +
  geom_point() + geom_smooth(method = lm, se = FALSE)
graphMurder # graph shows there's no correlation since the points are scattered and line is flat.

# 2nd example of positive correlation
View(faithful)
ggplot(faithful, aes(x= eruptions, y= waiting))+ 
  geom_point() + geom_smooth(method= lm, se = FALSE, color="goldenrod2") + xlab("Eruption time") + ylab("Waiting time")+
  ggtitle("Old Faithful Eruption time vs Waiting time") #it shows the waiting time is correlated with eruption time.

#3rd example of -ive correlation

d <- ggplot(mtcars, aes(x = disp, y = mpg))
d + geom_point() + geom_smooth(method=lm, se=FALSE)

####Correlation

cor.test(mtcars$hp, mtcars$cyl, method = "pearson", use = "complete.obs")

library("PerformanceAnalytics") # to make correlation matrix

mtcars_quant <- mtcars[, c(1,2,3,4,5,6,7)] #subset with all the rows and only 1-7 columns
chart.Correlation(mtcars_quant, method = "pearson", histogram = FALSE) #creates the matrix

#To plot visually appealing plot 

library("corrplot")

corr_matrix <- cor(mtcars_quant) # to create a matrix for corrplot to use 
corr_matrix

corrplot(corr_matrix, type = "upper", sig.level = .01, insig = "blank", order="hclust")

#calculating linear regression, ex 2
head(cars)
lreg_cars <- lm(dist ~ speed, cars)
summary(lreg_cars)

#to calculate the stopping distance in the above eg for a speed of 21miles perhr

# y = mx + b
# y = Value under intercept(speed in this case) * x + intercept

y = 3.93 * 21 - 17.58
# y = 64.95
# so the model predicts that a car going 21 miles per hour will require 64.99 feet to stop
#create the scatter plot with a best fit line
d <- ggplot(cars, aes(x = speed, y = dist))
d + geom_point() + geom_smooth(method=lm, se=FALSE)














