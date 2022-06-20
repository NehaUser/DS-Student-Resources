#Loading libraries
library("ggplot2")

# Loading data

library(readr)
nonlinear <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/nonlinear.csv")
View(nonlinear)

# PART 1. Create a scatterplot of the data with the Y variable on the vertical axis, 
# and the X variable on the horizontal axis.

# 1. To check if Quadratic for Columns X1, Y1

# Graph a Quadratic Relationship
# Graph it against a best-fit quadratic line to see if your data really was quadratic in nature.

quadPlotX1Y1 <- ggplot(nonlinear, aes(x = X1, y = Y1)) + geom_point() + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), size =1)
quadPlotX1Y1

# 2. To check if Quadratic for Columns X2, Y2

quadPlotX2Y2 <- ggplot(nonlinear, aes(x = X2, y = Y2)) + geom_point() + 
  stat_smooth(method = "lm", formula = y ~ x + I(x^2), size =1)
quadPlotX2Y2

# Eyeballing the two graphs, they both look Quadratic as well as Exponential.

# 3. To check if Exponential for Columns X1, Y1

exMod1 <- lm(log(nonlinear$Y1)~nonlinear$X1)
summary(exMod1)

# 4. To check if Exponential for Columns X2, Y2

exMod2 <- lm(log(nonlinear$Y2)~nonlinear$X2)
summary(exMod2)

# The F-statistic p-value is quite significant too in both the models, 
# so it's hard to make the difference.

# So just looking at the graphs, it's hard to differentiate which X,Y value pairs best fit
# quadratic relationship or Exponential relationship.

# PART 2:
# Using eyeball analysis, make a guess about what type of model will work best for the dataset. 
# You can add the best fit quadratic line as well to determine if it's a good fit.

# Just because more points fall on the best fit line in X2,Y2 value pairs, I'll model it as having Quadratic relation.
# And X1,Y1 pair as exponential.

# PART3: 
# Using the chosen model from step 2, complete the steps to perform the analysis that were listed in the lesson.

# The analysis of X1, Y1 as Exponential.

exMod1 <- lm(log(nonlinear$Y1)~nonlinear$X1)
summary(exMod1)

# Looking at the Estimate column, with 1 unit increase in X1, the Y1 will decrease 9%. 
# Also p-value is significant thus with Y1 shows exponential changes with X1.


# The analysis of X2, Y2 as Quadratic.

X2sq <- nonlinear$X2^2

quadModel2 <- lm(nonlinear$Y2~nonlinear$X2+X2sq)
summary(quadModel2)

# Looking at the overall F-statistic shown on the bottom and associated p-value,
# this quadratic model is significant! 
# This means that X2 is a significant quadratic predictor of Y2.


