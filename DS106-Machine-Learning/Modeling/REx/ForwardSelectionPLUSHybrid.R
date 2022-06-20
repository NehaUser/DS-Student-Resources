#Load in Data
head(mtcars)

# Create the Original Model

fitstart = lm(mpg ~ 1, data = mtcars)
# 
# In this function, the part where it says mpg ~ 1, tells the model to start without any predictors;
# the 1 part forces the model to simply use the average mpg for the dataset as the predicted value of mpg. 
# It is often called the naive model, meaning that it is a model where you assume all future mpg fuel 
# ratings are simply equal to the mean of the historical fuel ratings.
# 
# Then run a summary for this model:
#   
  
summary(fitstart)
# 
# Notice that the estimate for the intercept is 20.091, which is simply the 
# average mpg for the 28 vehicles in the original mtcars dataset. 
# This is a model, but it is a poor one, even though it is significant.

#Begin Forward Selection

# At this point, you will use the step() function to complete forward selection.
# R needs some instruction about which variables are potential predictors. 
# This is called the scope of the stepwise approach. You could either spell out 
# the entire scope of the potential model as follows:
  
step(fitstart, direction = 'forward', scope = (~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb))

# Or you can utilize the fact that the FitAll model was defined before when you
# did the backward elimination approach, and simplify the command as follows:

FitAll <- lm(mpg ~ . , data= mtcars) # function for selection of all the dependent variables.
  
step(fitstart, direction = 'forward', scope = (formula(FitAll)))

# In either case, direction = 'forward' specifies that you are doing forward 
# selection, and the argument scope= specifies the model that step() is moving towards.

# Fourth Iteration
# Now, with a model including wt, cyl, and hp, you are done.
# There is no point in adding any more terms, because according to the table, 
# the AIC will actually increase if you do.

# Examine the Final Model
FitSome1 <- lm(formula = mpg ~ wt + cyl + hp, data = mtcars)
summary(FitSome1)

# When you did the backward elimination model, you compared the initial model 
# (all ten predictors) with the optimized model, and concluded that the models are
# similar as far as R2 is concerned, so the model with just 3 predictors seems 
# preferable based upon simplicity alone. For the forward selection model, 
# there really is no starting point sort of model. You just used the average mpg 
# to get a starting point without any predictor variables.
# 
# Nonetheless, take a look at the specifics of the forward selection model shown above:
#   
#   The multiple R2 = 0.8431. The practical interpretation of this is that the model
# explains 84.31% of the variation in the mpg variable, and there is another 
# 15.69% of the variation that can be chalked up to noise or random error.
# There is an adjusted R2 = 0.8263. The "adjustment" is a modification that is 
# supposed to take into account the number of terms in the model. For your purposes,
# you are more interested in the adjusted R2 than the multiple R2.
# There is an F-statistic (50.17 with 3 and 28 degrees of freedom) and a p value 
# of 0.00000000002184 (this is represented in scientific notation in R) which 
# indicates that the model is better than no model at all, because the p value is less than 0.05.
# The R2 for the backward elimination model and the forward selection model are similar.
# So, which one is better? One could argue that the AIC for the backward elimination model 
# is slightly lower, so it must be better. But for all practical purposes, they are essentially the same. 
# However, did you notice the terms in the predictor model are not the same? 
#   That is actually a pretty common result. The truth is that in many cases, 
# there might not just be a single 'best' model that is far superior to the 'second best' model, 
# but there might be a cluster of models that are essentially equally good.


# Hybrid Stepwise - Forward and Backward Selection

# You will use the step() function again, but this time, utilize direction="both" as an argument, 
# to specify the hybrid stepwise approach:
  
step(fitstart, direction="both", scope=formula(FitAll))
# 
# Fourth Iteration
# With the fourth iteration, the model suggests that having wt, cyl, and hp as 
# predictors is better than any other model with another single predictor added, 
# and better than any other model with one of those predictors removed. The iterative 
# process has stabilized, and you have the same model as you did when you did the 
# forward selection approach.
# 
# Hierarchical Regression
# In hierarchical regression, you get to pick the variables that are being added or removed next, which allows you to make statements about how much variance is added "over and above" other variables. This approach can be quite useful especially when answering stakeholder questions about what variables are most important.








