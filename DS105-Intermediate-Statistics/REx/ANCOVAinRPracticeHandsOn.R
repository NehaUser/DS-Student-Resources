# Load Libraries

library("rcompanion")
library("car")
library("effects")
library("multcomp")
library("IDPmisc")

# Load Data

library("readr")
cellPhone <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/cellPhone.csv")
View(cellPhone)

# Question Set Up

# How does the presence or absence of an international phone plan (International Plan) influence the use of 
# nighttime minutes (Night.Mins), holding whether or not the client has a voicemail plan (vMail.Plan) constant?


# For this question, the covariate is whether or not the client has a voicemail plan(vMail Plan), 
# since that is what we are controlling. The IV is the categorical variable, presence or absence of an international
# phone plan (International Plan), and the DV is  the use of nighttime minutes (Night.Mins)

# Data Wrangling
# With this particular dataset, there is very little data wrangling required. All that is necessary is to ensure that all 
# categorical variables are factors, not integers, since the data type will throw off the code for getting adjusted means 
# and post hocs later (the ANCOVA itself will take the data in any data type).
# 
# Ensure the IV is a Factor

# We can see what format the data is in for your IV by using the str() function:
  
str(cellPhone$`International Plan`)
cellPhone$`International Plan` <- as.factor(cellPhone$`International Plan`)

# Ensure the CV is a Factor
# Covariates can either be categorical or continuous. Either is perfectly acceptable. 

cellPhone$`vMail Plan` <- as.factor(cellPhone$`vMail Plan`)

# Removing null vals

cellPhone <- NaRV.omit(cellPhone)

# You have now completed all data wrangling activities for this particular ANCOVA!

# Testing Assumptions

# Normality
# Take a look at the normality of your continuous variable.

plotNormalHistogram(cellPhone$`Night Mins`)

# It's perfectly normal.
# Our data meets the assumption of normality.


# Homogeneity of Variance
# To test for homogeneity of variance, we will run Levene's Test. Unfortunately, however, Levene's test will not take into 
# account any categorical covariates (though they are perfectly valid). So you'll include the model as best you can without it:

leveneTest(`Night Mins`~`International Plan`, data=cellPhone)

# Results were not significant, so the assumption is met!

# Homogeneity of Regression Slopes
# In order to test for homogeneity of regression slopes, you can run a one-way ANOVA, with your covariate as the IV and the DV 
# you were planning to use for your ANCOVA. If the F test is non-significant, then you are good to go!
   
# Here is the basic ANOVA information:
# lm(Night.Mins~vMail.Plan, data=cellPhone)
  
Homogeneity_RegrSlp <- lm(`Night Mins` ~ `vMail Plan`,  data=cellPhone)

anova(Homogeneity_RegrSlp)

# This assumption was met as well! 


# Sample Size
# The last assumption for ANCOVAs is sample size. There has to be at least 20 cases for every IV or CV. Since you will have one IV
# and one CV, you will need at least 40 rows of data. In this case, you have 4000 cases, so this assumption is more than adequately
# met!

# It is now time to run  ANCOVA at last!
  
# Running the Analysis
# You will run an ANCOVA using the same linear model format that you have used for regressions, 
# but playing with the model terms some. Here is the initial code needed for your ANCOVA:

ANCOVA = lm(`Night Mins`~`vMail Plan` + `International Plan`*`vMail Plan`, data=cellPhone)
anova(ANCOVA)

# Whether a client has an international plan or not does not influence the number of night minutes he or she uses,
# even holding whether they have a voice mail plan constant.

