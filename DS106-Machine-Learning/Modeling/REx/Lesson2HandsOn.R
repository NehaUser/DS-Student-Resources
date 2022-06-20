# Will need the following libraries to conduct logistic regression in R:

library("caret")
library("magrittr")
library("dplyr")
library("tidyr")
library("lmtest")
library("popbio")
library("e1071")
library("zoo")

# Load in Data

library(readr)
minerals <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/minerals.csv")
View(minerals)

# Question Setup

# Is the presence of antimony in a ground sample can be a good indication that 
# there is a gold deposit nearby.
# So we will do a regression where the
# predictor (IV) is the presence of antimony in a ground sample, and the response 
# variable (DV) is whether there is a gold deposit nearby.
# This is a case of a quantitative predictor variable, and a categorical response variable.

# Testing Assumptions

# 1. Appropriate Sample Size
# The first thing we need to do to test for appropriate sample size is to 
# create the logistic regression model.

mylogit <- glm(Gold ~ Antimony, data=minerals, family="binomial")
summary(mylogit)

# Predict if Gold found or Not 
# With that model created, we can make predictions about Gold found or not.
# To do this, we will use the predict() function on your logit model first:

probabilities <- predict(mylogit, type = "response")


# Then convert the probabilities to a positive and negative prediction by having anything
# above .5 (half) be positive, and anything below .5 be negative. This will be done using
# the ifelse() function on the probabilities variable you just created, and it will be assigned 
# to the minerals data set, as the column Predicted, so that we can later compare it with the 
# Gold column.

probabilities <- predict(mylogit, type = "response")
minerals$Predicted <- ifelse(probabilities > .5, "pos", "neg")

# Recode the Predicted Variable

minerals$PredictedR <- NA
minerals$PredictedR[minerals$Predicted=='pos'] <- 1
minerals$PredictedR[minerals$Predicted=='neg'] <- 0

# Convert Variables to Factors

minerals$PredictedR <- as.factor(minerals$PredictedR)
minerals$Gold <- as.factor(minerals$Gold)

#str(minerals)
# Create a Confusion Matrix
# And now you are finally ready to create a 2x2 chart, also known as a confusion matrix, 
# which will not only test our sample size out, but will also provide some information on
# the accuracy of our prediction.

conf_mat <- caret::confusionMatrix(minerals$PredictedR, minerals$Gold)
conf_mat

# If any one of these four cells in the chart is below 5, then we do not meet the 
# minimum sample size for binary logistic regression.
# Unluckily since we have a small dataset, we did not pass this assumption!

# The accuracy rate shows how accurate our predictions are. With a .844 accuracy rate, this means that
# roughly 84% of the time, the predictions are correct.

# Logit Linearity

# Now we have our model and our predictions, we can calculate the logit and then
# graph it against our predicted values.
# 
# We will need to do a little more data wrangling to properly create our logit. 
# We only want to assess the linearity of the logit with numeric variables, so using the library dplyr,
# and the select_if() function, you can select only numeric columns from the full dataset by
# specifying as the argument is.numeric.

minerals1 <- minerals %>% 
  dplyr::select_if(is.numeric)

View(minerals1)

# Then we will pull the column names to be fed into predictors using the colnames() function:

predictors <- colnames(minerals1)

#And finally we can create the logit, using tidyr's mutate() and gather() functions.
#The logit is calculated as the log of the probabilities divided by one minus the probabilities.

minerals1 <- minerals1 %>%
  mutate(logit=log(probabilities/(1-probabilities))) %>%
  gather(key= "predictors", value="predictor.value", -logit)

# With this logit in, we can graph to assess for linearity, using ggplot!
# minerals$Gold <- as.factor(minerals$Gold)

ggplot(minerals1, aes(logit, predictor.value))+
 geom_point(size=.5, alpha=.5)+
 geom_smooth(method= "loess")+
 theme_bw()+
 facet_wrap(~predictors, scales="free_y")
   

# This shows a nice strong linear relationship, so we are good to move
# on to testing the next assumption!

# Multicollinearity
# Since we only have one independent variable, we can skip this step.

# Independent Errors
# We can test for independent error by graphing the residual over the index.
 
# Graphing the Errors
# We can test this a number of ways. The first way is to graph the errors.

plot(mylogit$residuals)

# We can see a pretty even distribution of points all the way across the x axis.
# So we have met the assumption of independent errors.

# Use The Durbin-Watson Test
# Alternatively, we can use the Durbin-Watson test to see whether we have
# independence of errors. You'll use the function dwtest() out of the lmtest library:

dwtest(mylogit, alternative="two.sided")

# Since the DW value is 1.7616, which is between 1 and 3, we have
# met the assumption of independent errors through testing as well as graphing!

# Screening for Outliers
  
infl <- influence.measures(mylogit)
summary(infl) 

# Since dfb.1_ or dffit values are less than 1,
# and also  hat is less than .3 ,we don't have an outlier.


# Running Logistic Regression and Interpreting the Output
# We can now proceed to actually calling your logistic regression model and interpreting the output.

summary(mylogit)

# In this output, the first thing to check is whether the independent variable, 
# the Antimony, was a significant predictor of the amount of gold present.
# Looking in the Coefficients table under Antimony, we see that
# the p value is significant at p < .001, which is great news. This means that the
# Antimony is a significant predictor of the gold present nearby. 

# In the same line, the estimate tells us how much the independent variable influences 
# the dependent. So, for every one unit increase in Antimony, we see that the log 
# odds of presence of gold (versus not having) are increased by 1.76.

# Graphing the Logistic Model

logi.hist.plot(minerals$Antimony, minerals$Gold, boxp=FALSE, type="hist", col="gray")





























