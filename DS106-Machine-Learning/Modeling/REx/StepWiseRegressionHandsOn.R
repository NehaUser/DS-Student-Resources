# PART1 
# Import data
library(readr)
IQ <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/IQ.csv")

View(IQ)

# Question Setup

# Create a model that will use IQ as the response variable, 
# and the other 5 columns of data as potential predictor variables. 
# It is assumed that all 5 predictors don't really belong in the model.

# Get a Baseline

# Will start by creating a function called FitAll that creates a linear model 
# of all 5 predictor variables.

FitAll <- lm(IQ ~ . , data = IQ)
summary(FitAll)

#p-val = .3835, which means it's not significant model.

# Backward Elimination

step(FitAll, direction = 'backward')

# The Final Model
# lm(formula = IQ ~ Test1 + Test2 + Test4, data = IQ) --- # Iteration 2.
# 
# We will create a new function called FitSome, which will 
# just have the terms we are interested in:
#   

FitSome = lm(formula = IQ ~ Test1 + Test2 + Test4, data = IQ)
summary(FitSome)

####
# Q1. Which model is the best? Why?

# Based on AIC, model 2 (backward elmination) is better because AIC is lower than the original model.
# But since p-val is insignificant in both the models, none of the models are good.

# Q2 .From the best model, what is the adjusted R2 value and what does it mean?

# Adjusted R-squared:  0.2158 , it means that The adjustment is a modification that is supposed to 
 # take into account the number of terms in the model.

#Q3. From the best model, how does each variable influence IQ?

# The coefficient of Test1 is (-1.965). What that means is as long as everything else is equal, 
# an increase of IQ by 1 will lead to an estimated decrease in the Test1 by about 1.96 points.
# The coefficient of Test2 is (-1.649). What that means is as long as everything else is equal, 
# an increase of IQ by 1 will lead to an estimated decrease in the Test2 by about -1.649 points.
# The coefficient of Test4 is (3.789). What that means is as long as everything else is equal, 
# an increase of IQ by 1 will lead to an estimated decrease in the Test4 by about 3.789 points.



# PART 2
# Part II: Compare Stepwise Regression Types

# Loading data
stepwiseRegression <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/stepwiseRegression.csv")

# Setup
#This data has a single response (Y) variable, and twelve predictor (X1 through X12) variables

# Get a Baseline

# Will start by creating a function called FitAllsR that creates a linear model 
# of all 12 predictor variables.

FitAllsR <- lm(Y ~ . , data = stepwiseRegression)
summary(FitAllsR)

# Multiple R-squared:  0.9999,	Adjusted R-squared:  0.9998 
# F-statistic: 6.826e+04 on 12 and 115 DF,  p-value: < 2.2e-16

#p-val = 2.2e-16, which means it's a significant model.

# Backward Elimination

step(FitAllsR, direction = 'backward')

FitSomesR = lm(Y ~ X2 + X4 + X6 + X10 + X11 + X12, data = stepwiseRegression)
summary(FitSomesR)

# Multiple R-squared:  0.9999,	Adjusted R-squared:  0.9998 
# F-statistic: 1.385e+05 on 6 and 121 DF,  p-value: < 2.2e-16


# Forward Selection

# Get a Baseline

# Will start by creating a function called FitStartsR that creates a linear model 
# of all 12 predictor variables.

FitStartsR <- lm(Y ~ 1 , data = stepwiseRegression)
summary(FitStartsR)

# Coefficients:
# Estimate Std. Error t value Pr(>|t|)    
#(Intercept)   427.61      16.03   26.68   <2e-16 ***
  ---
#Begin Forward Selection

FitAllsR <- lm(Y ~ . , data = stepwiseRegression) # function for selection of all the dependent variables.

step(FitStartsR, direction = 'forward', scope = formula(FitAllsR))

FitSomesR <- lm(formula = Y ~ X6 + X4 + X12 + X10 + X2 + X11, data = stepwiseRegression)

summary(FitSomesR)


# Hybrid

step(FitStartsR, direction = 'both', scope = formula(FitAllsR))

# All the three models and the original looks the same. The p-value is significant. and the Rsquared is 99% for all the models.
# All the three models have the same dependent variables in the Stepwise Regression.


















