# Load Libraries
# There are several libraries you will need to load in order to complete the ANCOVA process. rcompanion, as you know by now,
# is for assessing normality with easy, best-fit histograms. The car library is both for assessing homogeneity of variance
# and for dealing with violations of said assumption. The effects library will assist you in the creation of means adjusted
# by your covariate, and the multcomp package is for conducting post hocs for ANCOVAs.

library("rcompanion")
library("car")
library("effects")
library("multcomp")
library("IDPmisc")

# Load Data

library("readr")
graduate_admissions <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/graduate_admissions.csv")
View(graduate_admissions)

# Question Set Up
# You will answer the following question with your ANCOVA:
#   
# Does University Rating significantly predict your college GPA when holding TOEFL score constant?

# For this question, the covariate is students' TOEFL score (TOEFL Score), 
# since that is what you are controlling. The IV is the categorical variable, rated 1-5, of students' 
# undergraduate university (University Rating), and the DV is the college GPA (CGPA).

# Data Wrangling
# With this particular dataset, there is very little data wrangling required. All that is necessary is to ensure that all 
# categorical variables are factors, not integers, since the data type will throw off the code for getting adjusted means 
# and post hocs later (the ANCOVA itself will take the data in any data type).

graduate_admissions$UnivRating <- NA

# Ensure the IV is a Factor
graduate_admissions$UnivRating <- as.factor(graduate_admissions$`University Rating`)

# You have now completed all data wrangling activities for this particular ANCOVA!

# Testing Assumptions
# 
# The assumptions for an ANCOVA are similar to those for your basic ANOVAs. However, one assumption is added -
# the assumption of homogeneity of regression slopes, which tests for whether the predictor variable (DV) and the covariate are
# independent of each other. This is because you are controlling for the presence of the covariate, not determining whether it has
# an effect on your DV. If the covariate is related in any way to your DV, then most likely it should be an independent variable, 
# not a covariate, because it is explaining some variance in your model.

# Normality
# Normality - Need to examine both GPA and TOEFL score
# Take a look at the normality of your continuous variable, CGPA.

plotNormalHistogram(graduate_admissions$`CGPA`)

# It could probably be a little more normal, though it's not too bad. Try a square transformation:

graduate_admissions$CGPASQR <- (graduate_admissions$CGPA) ^ 2

plotNormalHistogram(graduate_admissions$CGPASQR)

plotNormalHistogram(graduate_admissions$`TOEFL Score`)
# It could probably be a little more normal, though it's not too bad. Try a square transformation:

graduate_admissions$`TOEFLSQR` <- (graduate_admissions$`TOEFL Score`) ^ 2

plotNormalHistogram(graduate_admissions$`TOEFLSQR`)

# Your data now meets the assumption of normality.
# 

# Homogeneity of Variance
# To test for homogeneity of variance, you will run Levene's Test. Unfortunately, however, Levene's test will not take into 
# account any categorical covariates (though they are perfectly valid). So you'll include the model as best you can without it:

leveneTest(CGPASQR~UnivRating, data=graduate_admissions)

# Results were not significant, so the assumption is met!

# Homogeneity of Regression Slopes
# In order to test for homogeneity of regression slopes, you can run a one-way ANOVA, with your covariate as the IV and the DV 
# you were planning to use for your ANCOVA. If the F test is non-significant, then you are good to go!
   
# Here is the basic ANOVA information:

### Homogeneity of Regression Slopes

Homogeneity_RegrSlp = lm(CGPA~`TOEFL Score`, data=graduate_admissions)
anova(Homogeneity_RegrSlp)

# As you can see, the results of this ANOVA are saved into an object called Homogeneity_RegrSlp. Then you can use the lm() function
# to create your linear model. The dependent variable will remain the same as the one you plan to use in your ANCOVA - 
# Chance.of.AdmitSQR. And the covariate you're planning to use in the ANCOVA will be the IV - Research. Specify the dataset 
# with the argument data= and away you run! To get an ANOVA summary table out of this analysis, just call the anova function on 
# your saved object.

# Here are the results:
# Unfortunately, since the p value is significant, your data does not meet the assumption of homogeneity of regression slopes. 
# However, for the purposes of learning, you will just continue on.
# 
# Sample Size
# The last assumption for ANCOVAs is sample size. There has to be at least 20 cases for every IV or CV. Since you will have one IV
# and one CV, you will need at least 40 rows of data. In this case, you have 400 cases, so this assumption is more than adequately
# met!


# It is now time to run your ANCOVA at last!
  
# Running the Analysis
# You will run an ANCOVA using the same linear model format that you have used for regressions, 
# but playing with the model terms some. Here is the initial code needed for your ANCOVA:


ANCOVA = lm(CGPA~`TOEFL Score` + UnivRating*`TOEFL Score`, data=graduate_admissions)
anova(ANCOVA)

# Significant interaction between TOEFL score and University Rating, but there is a significant impact on university rating and on TOEFL score by itself.

## Post Hocs

postHocs <- glht(ANCOVA,linfct=mcp(UnivRating = "Tukey"))
summary(postHocs)

# No group significantly differs from any other group.

## Examine Adjusted Means

adjMeans <- effect("UnivRating", ANCOVA)
adjMeans

# Looking at the means confirms conclusion above - all of these have a college GPA that is about the same.

