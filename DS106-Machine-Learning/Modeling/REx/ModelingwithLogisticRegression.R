# will need the following libraries to conduct logistic regression in R:

library("caret")
library("magrittr")
library("dplyr")
library("tidyr")
library("lmtest")
library("popbio")
library("e1071")

# caret and lmtest will be used to test assumptions, 
# dplyr, tidyr, and magrittr are used for data wrangling, and 
# popbio is used to graph your logistic regression model.

# Load in Data
library(readr)
baseball <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/baseball.csv")
View(baseball)

# Each baseball season, each team plays 162 regular season games. 
#Since baseball doesn't ever end in a tie, each game has a winner and a loser.
# There are 30 teams, but each game includes two teams, so there are a
# total of (162 * 30) / 2 total games played, or 2430 total games.

#Since each of the 2430 games has a winner and a loser, you have a table
# with 4860 rows of data. 

# Question Setup
#  It seems logical to assume that the more home runs a team hits in a particular game,
# the more likely they are to win. So you will do a regression where the
# predictor (IV) is the number of home runs hit by a team, and the response 
# variable (DV) is whether the team wins or loses. This is a case of a quantitative
# predictor variable, and a categorical response variable.

# Data Wrangling
# The one thing that absolutely has to be done before you can dive into logistic regression
# is the recoding of the outcome variable (DV) to zeros and ones.
# Currently, your wins and losses variable (W.L) has a W indicating a win and an L indicating a loss. 
# In R, that just won't fly - you need this outcome variable to be numeric.

# The following code will create a new wins and losses column that will re-code this variable numerically:

baseball$WinsR <- NA

names(baseball)[names(baseball) == 'W/L'] <- 'W_L' #Change column name to make it readable

baseball$WinsR[baseball$W_L=='W'] <- 1
baseball$WinsR[baseball$W_L=='L'] <- 0

View(baseball)

# Testing Assumptions

# Appropriate Sample Size
# The first thing you need to do to test for appropriate sample size is to 
# create the logistic regression model.

# Run the Base Logistic Model
# Just like with linear regression, you typically need to create a model first
# before you can ensure that it meets all the assumptions - you just won't use it yet.

names(baseball)[names(baseball) == 'HR Count'] <- 'HR_Count' #Change column name to make it readable
mylogit <- glm(WinsR ~ HR_Count, data=baseball, family="binomial")

# This code should look somewhat familiar to you, as it stems from the same one 
# as your linear regression. However, instead of just lm() you now use glm() and you need 
# to specify family= . Here you have chose binomial because you are doing
# Binomial Logistic Regression. Place your dependent variable first, the new WinsR column that you re-coded,
# and then you will add your independent variable after the tilde. baseball is the name of your dataset.

# Predict Wins and Losses
# With that model created (but not interpreted!), you can make predictions about wins and losses.
# To do this, you will use the predict() function on your logit model first:


probabilities <- predict(mylogit, type = "response")

# Then convert your probabilities to a positive and negative prediction by having anything
# above .5 (half) be positive, and anything below .5 be negative. This will be done using
# the ifelse() function on the probabilities variable you just created, and it will be assigned 
# to your baseball data set, as the column Predicted, so that you can later compare it with the 
# recoded wins and losses column.

probabilities <- predict(mylogit, type = "response")
baseball$Predicted <- ifelse(probabilities > .5, "pos", "neg")


# Recode the Predicted Variable
# Just like you recoded wins and losses, you also need to recode your new Predicted variable:

baseball$PredictedR <- NA
baseball$PredictedR[baseball$Predicted=='pos'] <- 1
baseball$PredictedR[baseball$Predicted=='neg'] <- 0
  
# Convert Variables to Factors
# The next thing you need to do is to convert the WinsR and the PredictedR columns to factors.
# This is necessary because the next line of code you will run requires these variables to be factors.
# Simply specify the dataset and call the variable before the arrow, then use the 
# function as.factor() and call the variable again.

baseball$PredictedR <- as.factor(baseball$PredictedR)
baseball$WinsR <- as.factor(baseball$WinsR)

# Create a Confusion Matrix
# And now you are finally ready to create a 2x2 chart, also known as a confusion matrix, 
# which will not only test your sample size out, but will also provide some information on
# the accuracy of our prediction. Using the caret library, you will call the
# confusionMatrix() function, specifying that you want to compare your 
# predicted values (PredictedR) to your actual data, which is the WinsR column.


conf_mat <- caret::confusionMatrix(baseball$PredictedR, baseball$WinsR)
conf_mat
# 
# The first thing you will notice is the table at the top. This is your 2x2 chart, 
#and it shows the following:
#   
#   Top left corner (Reference: 0, Prediction: 0): These are the cases that
#failed the condition and were predicted to fail the condition. In your case, 
#a loss was predicted and a loss actually happened.
# This is the number you accurately predicted as "did not happen."
# Top right corner (Reference: 1, Prediction: 0): These are the cases that were
#predicted to fail the condition, but did not actually fail. In terms of the current 
#dataset: a loss was predicted, but the team actually won.
# Bottom left corner (Reference: 0, Prediction: 1): These are the cases where a success was predicted, 
# but a failure actually happened. This means that the team was predicted to win, but they actually lost.
# Bottom right corner (Reference: 1, Prediction: 1): These are the cases were a success was predicted 
#and a success actually happened. So, the team was predicted to win and they actually won.
# This is the number you accurately predicted as "did happen."
# If any one of these four cells in the chart is below 5, then you do not meet the minimum sample
#size for binary logistic regression. Luckily, you have a large dataset, and so you pass this assumption!
#   
#   There is also some other useful information contained within the confusion matrix output, however. 
#The accuracy rate shows how accurate your predictions are. With a .639 accuracy rate, this means that
#roughly 64% of the time, your predictions are correct. If you added additional independent variables
#to your model, then perhaps this accuracy rate would go up. The confusion matrix also has information 
#on sensitivity, specificity, the positive predicted value, and the negative predicted value. 
#Although those are not statistics you will focus on now, they will come up again later when you discuss 
#receiver operator curve analyses, so it's worth getting a heads up on where they can be located in R.
# 
# Logit Linearity
# # Now you have your model and your predictions, you can calculate the logit and then
# graph it against your predicted values.
# # 
# # You will need to do a little more data wrangling to properly create your logit. 
# You only want to assess the linearity of the logit with numeric variables, so using the library dplyr,
# and the select_if() function, you can select only numeric columns from the full dataset by
# specifying as the argument is.numeric.
# # 

baseball1 <- baseball %>% 
  dplyr::select_if(is.numeric)

View(baseball1)

# Then you will pull the column names to be fed into predictors using the colnames() function:

predictors <- colnames(baseball1)

#And finally you can create the logit, using tidyr's mutate() and gather() functions.
#The logit is calculated as the log of the probabilities divided by one minus the probabilities.


baseball1 <- baseball1 %>%
  mutate(logit=log(probabilities/(1-probabilities))) %>%
  gather(key= "predictors", value="predictor.value", -logit)

# With this logit in hand, you can graph to assess for linearity, using your dear friend, ggplot!

ggplot(baseball1, aes(logit, predictor.value))+
  geom_point(size=.5, alpha=.5)+
  geom_smooth(method= "loess")+
  theme_bw()+
  facet_wrap(~predictors, scales="free_y")

# 
# This will automatically give you a graph of the logit with every numeric variable. 
# Of course, in this case, all you care about is the number of home runs,
# denoted by the upper right hand corner graph labeled HR_Count.
# Lucky for you, this shows a nice strong linear relationship, so you are good to move
# on to testing the next assumption!
#   
  

# #Multicollinearity
# The next assumption you would normally test for is multicollinearity; 
# you can't have your independent variables too closely related to each other.
# However, since you only have one independent variable, you can skip this step.
# 
# Independent Errors
# You can test for independent error by graphing the residual over your index.
# 
# Graphing the Errors
# You can test this a number of ways. The first way is to graph the errors,
# and there's a nice, easy line of code for this:
# 
# 
plot(mylogit$residuals)

# Where mylogit is the model you created, and residuals is an automatic output
# of that model that you can call.
# 
# You are looking for a pretty even distribution of points all the way across your x axis.
# You have that, so you have met the assumption of independent errors.
# 
# Use The Durbin-Watson Test
# Alternatively, you can use the Durbin-Watson test to see whether you have
# independence of errors. You'll use the function dwtest() out of the lmtest library:

dwtest(mylogit, alternative="two.sided")

# Using the alternative="two.sided" argument means that you are testing for both 
# positive and negative autocorrelation of errors.

# 
# If this test is not statistically significant (> .05), then you are automatically 
# good to go, and you have independent errors. However, if it is significant, 
# you can then look at the actual value of the Durbin-Watson test statistic.
# If it is under 1 or greater than 3, then you have violated the assumption of 
# independent errors. Since your DW value is 2.08, you are in an ok range and have
# met the assumption of independent errors through testing as well as graphing!
  
# Screening for Outliers
# To screen for outliers, you will use the influence.measures function .
#   
infl <- influence.measures(mylogit)
summary(infl) 

# You may want to consider creating your own function that will print only the rows 
# that are suspicious. Remember that if dfb.1_ or dffit values are greater than 1,
# or if hat is greater than .3 or so, you probably have an outlier than should be 
# examined and possibly removed.
# 
# 
# Running Logistic Regression and Interpreting the Output
# Having passed all your assumptions (HOOAH!), you can now proceed to actually 
# calling your logistic regression model and interpreting the output.
# 
# All you need to do is ask for the summary:

summary(mylogit)

# 
# In this output, the first thing to check is whether your independent variable, 
# the number of home runs, was a significant predictor of the number of wins and 
# losses a team had. Looking in the Coefficients table under HR_Count, you see that
# the p value is significant at p < .001, which is great news. This means that the
# number of home runs is a significant predictor of the number of wins and losses a team had. 
# The z value given next to p is the Wald Statistic, and you can think of it similarly to
# the t tests you had for individual predictors in linear regression - 
#   it's just that Wald works for categorical variables and t tests don't.
# 
# In the same line, the estimate tells you how much the independent variable influences 
# the dependent. So, for every one unit increase in home runs, you see that the log 
# odds of winning a game (versus losing) are increased by .66.
# 
# You also have a number of other components here that tell you about model fit, 
# including the deviance residuals, null and residual deviance, and the AIC.

# Graphing the Logistic Model
# Want to plot it? You can use the popbio library to do so with this code:

logi.hist.plot(baseball$HR_Count,baseball$WinsR, boxp=FALSE, type="hist", col="gray")

  









