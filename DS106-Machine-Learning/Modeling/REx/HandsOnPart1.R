#DSO106 Modeling L1 Practice Hands-on

# Importing packages for Linear Regression

install.packages("car")
install.packages("caret")
install.packages("gvlma")
install.packages("predictmeans")
install.packages("e1071")
install.packages("lmtest")


library("car")
library("caret")
library("gvlma")
library("predictmeans")
library("e1071")
library("lmtest")

# Uploading the data set
library(readr)
heights <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/heights.csv")
View(heights)


# To check if bodies morning height is the predictor of the night height.

# Test Assumptions
# 1. Testing for Linearity

scatter.smooth(x=heights$AM_Height, y=heights$PM_Height, main="Night height based on morning height") 

# The graph shows there is a linear relationship between the night height and the morning height.

# 2. Testing for Homoscedasticity

# Create the Linear Model
lmMod <- lm(PM_Height~AM_Height, data=heights)

#if this model is robust enough to use for analysis
par(mfrow=c(2,2))
plot(lmMod)

# It looks like the top left curves and the bottom left graph has a dip, 
# so the assumption of homoscedasticity may not be met.

# Also test for homoscedasticity with the Breush-Pagan test or the Non-Constant Variance (NCV) test.

lmtest::bptest(lmMod)

# Since the p-value is .64, and greater than .05. It shows it is insignificant and thus linear .

car::ncvTest(lmMod)

# Since the p-value is .64, and greater than .05. It shows it is insignificant and thus linear .


# 3. Testing for Homogeneity of Variance

# Looking at the graphs from the last assumption, 
# this may not have been passed. 

# Doing the GVLMA test

gvlma(lmMod)

# This shows the assumptions are acceptable.


# Screening for Outliers

# Testing for Outliers in X Space

# Cook's Distance values
CookD(lmMod, group=NULL, plot=TRUE, idn=3)

# So cases numbered 3, 4, and 12 are all outliers in x space.

# To test for leverage, we will use the ```hat`` function and then plot it:

lev = hat(model.matrix(lmMod))
plot(lev)

heights[lev>.2,]

# Going by leverage values, only 3 is really an issue


# Testing for Outliers in y Space
car::outlierTest(lmMod)

# Since Bonferroni p < .05. it's significant.. thus atleast 1 outelier

# Testing for Outliers in x and y Space
# To test for influential values, or outliers in both x and y space, there are two metrics to look at: 
# DFFITS and DFBETAS.

summary(influence.measures(lmMod))

# Looks like the values are 3, 11 and 37 as outeliers


# Creating a new model without outliers to test against the model with outliers

heightsNew <- heights[c(1,2,5,6,7,8,9,10,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,38,39,40,41),]
lmModNew = lm(PM_Height~AM_Height, data=heightsNew)

# Look at the model summaries of each model
summary(influence.measures(lmMod))

# Looks like morning height is a significant predictor of evening height
# and explains 99% of the variance in evening height.

summary(influence.measures(lmModNew))

# Very similar results with the model with no outliers,
# so it's fine to keep and use the original model with all the data!





