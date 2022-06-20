#Load in Data
head(mtcars)

# Question Setup
# Create a model that will use mpg as the response variable, 
# and the other 10 columns of data as potential predictor variables. 
# It is assumed that all 10 predictors don't really belong in the model.

# Get a Baseline
# You will start by creating a function called FitAll that creates a linear model 
# of all 10 predictor variables. The command looks like this:

FitAll <- lm(mpg ~ . , data= mtcars)
# 
# mpg is your y, or response variable, and . means "all." Instead of saying mpg ~ ., 
# you could have listed out all 10 predictor variables, as in "mpg ~ cyl + disp + hp + drat + ...". 
# It is much easier to use the . rather than list them all out.
# 
# Then get get the model summary, using the summary() function:

summary((FitAll))
# # 
# # Although the overall p value at the bottom is significant, none of the individual predictors are,
# meaning that the model is probably not a good fit; the number of variables has just inflated the p value to 
# the point of being significant, and what the independent variables are does not really matter.
# # 
# # Once you have created a new model after backward elimination, you can compare the above model summary with 
# all 10 predictors against what R has helped determine is the best fit.
# 
# Try Backward Elimination
# The real guts of the method is in the following line of code, using the step() function and 
# specifying the argument direction='backward' to ensure you're doing backward elimination.

step(FitAll, direction = 'backward')

# The Final Model
# lm(formula = mpg ~ wt + qsec + am, data = mtcars) --- # Iteration 8th.
# 
# You can determine this by creating a new model with just those variables and then 
# looking at the summary. You will create a new function called fitsome, which will 
# just have the terms you are interested in:
#   
  
FitSome = lm(mpg ~ am + qsec + wt, data = mtcars)
summary(FitSome)
# 
# There are a few things to note here from the above output:
#   
# There are coefficients for just the three predictor variables, as well as an intercept.
# There is a multiple R2 = 0.8497. The practical interpretation of this is that the model explains 84.97% of
# the variation in the mpg variable, and there is another 15.03% of the variation that can be
# chalked up to noise or random error.
# There is an adjusted R2 = 0.8336. The adjustment is a modification that is supposed to 
# take into account the number of terms in the model. For your purpose, you are more interested in 
# the adjusted R2 than the multiple R2.
# There is an F-statistic (52.75 with 3 and 28 degrees of freedom) and a p value 
# of 0.0000000000121 (this is represented in scientific notation in R) which indicates that 
# the model is better than no model at all, because the p value is less than 0.05.
# So, have you really gained anything by doing the backward elimination? To the untrained eye,
# one might say "no gain." The R2 values are very similar, and both models are statistically significant. 
# However, to the trained eye, you have adhered to the "Principle of Parsimony"
# and come up with an equally good (maybe marginally better) model that is much simpler.
# Further, now all of your individual predictors are significant! Mission accomplished.
# 
# 
# NOTE : AIC stands for Akaike Information Criteria. It was invented by a Japanese statistician named
# Hirotugu Akaike in the 1970's. The AIC is a measure of relative quality of a model.
# However, it doesn't tell you if a model is any good or not. It simply helps you to compare 
# two or more models against each other. When comparing two models, the model with the smaller AIC is 
# generally accepted to be the better of the two models. 


  
  
