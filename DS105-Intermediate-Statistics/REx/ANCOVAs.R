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
# Controlling for students' research participation in undergrad, does the rating of the students' 
# undergraduate university impact their chance of admittance into graduate school? 
#   
# For this question, the covariate is students' research participation in undergrad (Research), 
# since that is what you are controlling. The IV is the categorical variable, rated 1-5, of students' 
# undergraduate university (University.Rating), and the DV is the chance of admittance into graduate school (Chance.of.Admit).

# Data Wrangling
# With this particular dataset, there is very little data wrangling required. All that is necessary is to ensure that all 
# categorical variables are factors, not integers, since the data type will throw off the code for getting adjusted means 
# and post hocs later (the ANCOVA itself will take the data in any data type).
# 
# Ensure the IV is a Factor
# You can see what format the data is in for your IV by using the str() function:
  
str(graduate_admissions$`University Rating`)

# Note that the output shows it is an integer! That can easily be converted:
  
graduate_admissions$`University Rating` <- as.factor(graduate_admissions$`University Rating`)

# Ensure the CV is a Factor
# Covariates can either be categorical or continuous. Either is perfectly acceptable. However, if you do use a categorical CV,
# like Research is, it needs to be formatted as factor data, not as an integer. You can test and fix this just like the IV:
  
str(graduate_admissions$Research)
# Note that the output shows it is an integer! That can easily be converted:

graduate_admissions$Research <- as.factor(graduate_admissions$Research)

graduate_admissions <- NaRV.omit(graduate_admissions)

# You have now completed all data wrangling activities for this particular ANCOVA!

# Testing Assumptions
# 
# The assumptions for an ANCOVA are similar to those for your basic ANOVAs. However, one assumption is added -
# the assumption of homogeneity of regression slopes, which tests for whether the predictor variable (DV) and the covariate are
# independent of each other. This is because you are controlling for the presence of the covariate, not determining whether it has
# an effect on your DV. If the covariate is related in any way to your DV, then most likely it should be an independent variable, 
# not a covariate, because it is explaining some variance in your model.

# Normality
# Take a look at the normality of your continuous variable, Chance of Admit.

plotNormalHistogram(graduate_admissions$`Chance of Admit`)

# It could probably be a little more normal, though it's not too bad. Try a square transformation:

graduate_admissions$`Chance of AdmitSQR` <- (graduate_admissions$`Chance of Admit`) ^ 2

plotNormalHistogram(graduate_admissions$`Chance of AdmitSQR`)

# Your data now meets the assumption of normality.
# 
# Homogeneity of Variance
# To test for homogeneity of variance, you will run Levene's Test. Unfortunately, however, Levene's test will not take into 
# account any categorical covariates (though they are perfectly valid). So you'll include the model as best you can without it:

leveneTest(`Chance of AdmitSQR`~`University Rating`, data=graduate_admissions)

# Unfortunately, this test is significant, which means that you have violated the assumption of homogeneity of variance. 
# You will learn how to correct for this violation on the next page.

# Homogeneity of Regression Slopes
# In order to test for homogeneity of regression slopes, you can run a one-way ANOVA, with your covariate as the IV and the DV 
# you were planning to use for your ANCOVA. If the F test is non-significant, then you are good to go!
   
# Here is the basic ANOVA information:
  
Homogeneity_RegrSlp = lm(`Chance of AdmitSQR`~Research, data=graduate_admissions)
anova(Homogeneity_RegrSlp)

# As you can see, the results of this ANOVA are saved into an object called Homogeneity_RegrSlp. Then you can use the lm() function
# to create your linear model. The dependent variable will remain the same as the one you plan to use in your ANCOVA - 
# Chance.of.AdmitSQR. And the covariate you're planning to use in the ANCOVA will be the IV - Research. Specify the dataset 
# with the argument data= and away you run! To get an ANOVA summary table out of this analysis, just call the anova function on 
# your saved object.

# Here are the results:
# Unfortunately, since the p value is significant, your data does not meet the assumption of homogeneity of regression slopes. 
# That means that whether someone does research or not actually does have an impact on their chance of admittance to graduate school, 
# and that you should NOT use Research as a covariate, but rather include it as a second independent variable in the model.
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
  
ANCOVA = lm(`Chance of Admit`~Research + UniversityRating*Research, data=graduate_admissions)
anova(ANCOVA)

# The lm() function specifies that this is a linear model. Then you'll input your y variable, or DV, first. In this case, 
# since you are predicting a student's chance of admission into graduate school, your DV is Chance.of.Admit.
# What follows immediately after the tilde is a mash-up of things. There are a couple important things to note:
#   
#   The covariate(s) ALWAYS has to come first!! This is because the variables are taken in order in this case, and you want
# the effects of the covariate to be parsed out first.
# 
# The plus sign adds in additional covariates or independent variables.
# 
# The asterisk creates what is called an interaction term. It looks at the effects of one thing BY another thing. 
# Sometimes, you will find effects when looking at an interaction term that were invisible even if you had both variables 
# together in the model, so it's typically a best practice to always include an interaction term if you are going to have
# more than one IV or CV in your model (basically, anything that is not a one-way ANOVA).
# 
# So this model is looking at the chance of admittance to graduate school, holding whether students have done research constant,
# by University Rating, and examining how University Rating interacts with Research. It's possible, for instance, that only 
# when a school is rated very well or very poorly that it impacts whether students' research matters.

# Once you have all your terms in place, you can call the ANCOVA with the anova() function, where you put the name of your
# model in as an argument. 


# This ANCOVA table should look somewhat familiar to you, as it follows the same format as other ANOVA variations. Looking at it, 
# you can see that there is a significant effect of the covariate, Research, and a significant effect of the independent variable,
# University.Rating, on a student's chance of admission to graduate school. In addition, there is an interaction between Research 
# and University.Rating, indicating that those things combined also form a significant pattern that predicts admission to graduate 
# school.
# 
# When You've Failed Homogeneity of Variance
# If you failed the assumption of homogeneity of variance, not to fear! There is a quick and easy additional line you can add to
# the base model. Instead of running the anova() function, you can instead run the Anova() function. Catch the difference there? 
#   The function that corrects for a violation of homogeneity of variance has a capital "A," whereas the "regular" summary function 
# doesn't. If it helps, think of the big "A" as standing for "assumption," so when you've violated the assumption, head for that!
#   
#   Here is what using the big A Anova() function looks like:
  
Anova(ANCOVA, Type="I", white.adjust=TRUE)

# Just put in the name of your model you created above (ANCOVA), and then specify the type of ANOVA you want. 
# The Type= argument refers to how the ANOVA is calculated, in terms of its sum of squares (noted as Sum Sq in your R output).
# Whenever you have an interaction effect, you will always want Type="I", but here are all the types and what they are used for. 
# To be honest, if you have a pretty basic and well-balanced design (relatively equal sample sizes in each of the groups), 
# then it doesn't matter which one you select typically.
# # 
# Types of ANOVAs for Type= Argument:
# 
# Type I: This is automatically used when you use the aov() function you were taught in earlier lessons. The sum of squares are
# taken sequentially, which means that they are calculated in the order in which they are listed in the model.
# 
# Type II: This type of ANOVA examines the effects of all the main effects, but ignores any interaction effects. So it is not
# suitable if you have more than one IV or CV in your model and want to determine how they interact.
# 
# Type III: This is used only when you want to look at only some sums of squares effects. Basically, you can examine only the
# effects you specify by changing the options for contrasts. You can think of contrasts as built-in, planned post hocs.
# Specifying them in advance and being specific as to what you are looking for means that you have less Type I error, but they 
# can be a pain to use. Hence they will not be covered in this course!
# 
# Remember from previous lessons that the white.adjust=TRUE argument is what corrects for the violation of homogeneity of variance,
# so it is crucial to include.

  
# Everything remains significant, even after you've corrected for a violation of homogeneity of variance.

# Post Hocs
# But where do the differences lie? To answer those questions, you need to follow up with a post hoc. For an ANCOVA, 
# you will still run a post hoc with the Tukey's correction, but you will need to do so using functions from the multcomp package 
# instead because you now need to handle the covariate and interaction effects. You will do this using the glht() function:
str(graduate_admissions)

postHocs <- glht(ANCOVA, linfct = mcp(UniversityRating="Tukey"))
summary(postHocs)


# The independent variable will go in the second second of parentheses before the equals sign. linfct=mcp is standard code that 
# you will use routinely.
# 
# Looking in the Pr(>|t|) column shows the p values associated with each of these pairwise t-tests. It looks like there was a
# significant difference between a university rated "1" and all other university ratings, a university rated "2" and all 
# other university ratings, but no differences between universities rated "3," "4," or"5." What was higher between those 
# differences that were significant? Well, to determine that, you will need to examine the means.

# Determine Means and Draw Conclusions
# Because you included a covariate in your model, it is important to look at adjusted means, rather than the raw means.
# The means are adjusted by controlling for your covariate. This may sound needlessly complicated to you, but never fear - 
# the effects package makes it easy!
  
adjMeans <- effect("UniversityRating", ANCOVA)
adjMeans
# 
# Just call the effect() function, then put your IV in quotes and specify the model that it came from. When you run the name you 
# gave the object, you will get this output:
#   
# So with these means, you can see here that a student who attended undergrad in a university rated a 1 has a significantly 
# lower chance of being accepted (56%) when compared to all other university rating levels.
# A student who attended undergrad in a university rated a 2 also has a significantly lower chance of being accepted (63%) 
# than anyone who attended a school that was rated a 3, 4, or 5. However, attending a school rated a 3, 4, or 5 did not 
# significantly improve your odds of being accepted to graduate school.
# 
# Drawing an overall conclusion from this data, you might say something like "as long as you attended a medium or better
# rated university for undergraduate, you have relatively good odds of being accepted to graduate school, but students who 
# attended a poorly rated university are much less likely to be accepted, when controlling for the effects of having participated
# in research in undergrad."
# 















  
  



