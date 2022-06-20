# Load Libraries
# Repeated measures ANOVAs come as part of the base package in R, so the only libraries you will need to load in are
# rcompanion because you'll use it to check for the assumption of normality, car if you need to run an ANOVA that will 
# correct for a violation of homogeneity of variance, and fastR2, which is used for some data wrangling to get your data 
# in the right shape for repeated measures ANOVAs.
install.packages("fastR2")

library("rcompanion")
library("fastR2")
library("car")

# Load Data

library(readr)
breakfast <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/breakfast.csv")
View(breakfast)
# 
# Question Setup
# With this data, you will answer the question:
# 
# Overall, regardless of whether participants ate breakfast or not, did people in this study show improvement in their 
# resting metabolic rate?   
# In order to answer this question, your x, or independent variable, will be the time factor - baseline or follow-up. 
# Your y, or dependent variable, will be the change in resting metabolic rate from baseline to follow-up. As with all ANOVAs, 
# the IV will be categorical, and the DV will be continuous.
# 
# Data Wrangling
# Depending on the data that you're working with, it may need some wrangling!

# Removing Extra Rows

# you can run the NaRV.omit() function and clean up any missing data, which should remove everything you're not interested in,
# or you can just subset your data. In this case, you'll subset the data to only include the rows you want:
  
breakfast1 <- breakfast[1:33,]

# Reshaping the Data
# The other thing that needs to be done with your data is to reshape it, from width-wise to long-wise, so that you can run the ANOVA.
# The code to reshape only takes the variables that you want to flip and anything you want to hold constant, so you will need to 
# subset your data again to include only the columns you are interested in:
  
keeps <- c("Participant Code", "Treatment Group", "Age (y)", "Sex", "Height (m)", "Baseline Resting Metabolic Rate (kcal/d)", "Follow-Up Resting Metabolic Rate (kcal/d)")
breakfast2 <- breakfast1[keeps]

# 
# First you can create a vector of the names of the columns you do want to keep. Participant.Code, Treatment.Group, Age..y., Sex, 
# and Height..m. are all constants, meaning that they are not changing as you measure over time. You don't have a time one and a 
# time two measurement. You also want to keep the one change over time variable you are interested at both time points, which is 
# the the resting metabolic rate. After you've created the vector to keep, you can then apply that to your truncated dataset.

# Now comes the actual reshaping! You will need to do this for both the baseline and the follow up data. 
# Basically, you are going to keep the first five columns that don't change by timepoint, and then add to that new columns 
# of repdat and contrasts. The repdat column will hold the actual data from the baseline section, and the contrasts column will
# hold the information that says it was from the baseline timepoint.

breakfast3 <- breakfast2[,1:5]
breakfast3$repdat <- breakfast2$'Baseline Resting Metabolic Rate (kcal/d)'
breakfast3$contrasts <- "T1"

# You will do the same thing with your follow-up data:
  
breakfast4 <- breakfast2[,1:5]
breakfast4$repdat <- breakfast2$'Follow-Up Resting Metabolic Rate (kcal/d)'
breakfast4$contrasts <- "T2"

# Once you have both of those, then you need to rbind() them back together into one whole dataset:
  
breakfast5 <- rbind(breakfast3, breakfast4)

# Now you are all prepared to run a repeated measures ANOVA, data shaping wise.
# 
# Testing Assumptions
# The assumptions for a repeated measure ANOVA are the same as the ones you learned for a one-way between subjects ANOVA, 
# with the addition of the assumption of sphericity. Recall that sphericity is the idea that things that occur closer together 
# in time or space may be more related than things that occur farther away in time or space. You'll need to test for that unequal 
# relationship between time points and correct for it if sphericity is present.
# 
# Remember that if the assumptions are not met for ANOVA, but you proceeded anyway, you run the risk of biasing your results.
# 
# Normality
# You only need to test for the normality of the dependent variable, but you need to do it at both timepoints.
# So scoot on back to breakfast2, which is the dataset you truncated but had not yet reshaped.

plotNormalHistogram(breakfast2$'Baseline Resting Metabolic Rate (kcal/d)')

# Hoozah! Looks pretty normal and you'll take it, no transformation necessary!

# Try the follow-up data:
  
plotNormalHistogram(breakfast2$'Follow-Up Resting Metabolic Rate (kcal/d)')

# And result! Another one normal enough to use without transformation! Yes, it may be a little platykurtic, 
# but it's centered in the middle, so count your blessings and go with it!
# 
# Homogeneity of Variance
# The tests you learned for homogeneity of variance for one-way ANOVAs will not work for repeated measures if you need to 
# include any other information. In this case, you are not just looking for whether the resting metabolic rate increased over time,
# you are looking to see if it changed over time based on the condition (eating breakfast or skipping breakfast) the patient was
# placed in. So, a Levene's Test can be used instead to check for homogeneity of variance, using the function from the car library,
# leveneTest(). Here you will specify the variable information you are testing. Your y variable will go first, separated by a
# tilde and followed by your x variable and an asterisk, then your time variable. The time variable is contrasts, and remember 
# that it represents time 1 (baseline) or time 2 (follow up). Altogether, you can read this code as a sentence like this: 
# "Resting metabolic rate by treatment group over time."
#                       
leveneTest(breakfast5$repdat ~ breakfast5$`Treatment Group`*breakfast5$contrasts, data=breakfast5)

# Just like the other tests for homogeneity of variance, you want Levene's test to be non-significant 
# in order to pass this assumption. And lo and behold, it is! No need for correction!

# Correcting for Violations of Homogeneity of Variance
# If you had violated the assumption of homogeneity of variance, you could correct for it by running a BoxCox transformation 
# on your data, or by running a more robust ANOVA, that can handle a violation of this assumption.
# 
# Sample Size
# A repeated measures ANOVA requires a sample size of at least 20 per independent variable. You have that, 
# so this assumption has been met.
# 
# Sphericity
# The only way to test for sphericity in R is to take a multivariate approach and make it work for an ANOVA. 
# At this time, that is a bit too complex, but it may be covered later.

# Repeated Measures ANOVAs Analysis in R
# Alright! You've done all the prep work, now it's time for the fun!
#   
#   Analysis
# You will continue to use the aov() function, but add some additional arguments to it to make it repeated measures.

RManova <- aov(repdat~contrasts+Error(breakfast5$`Participant Code`), breakfast5)

summary(RManova)
# 
# So what's happening here is that you are calling the aov() function on your repeated data of metabolic rate by your
# timepoint, and then adding in an error term, which is what makes this a repeated measure - you are telling it that it 
# should be looking within each participant, which is what ths part of the code does: Error(Participant.Code). 
# Finish it all off by specifying the dataset at the end and you are good to go. Call summary() on the results:
# 
# Under the Error:Within table (since this is a within subjects ANOVA, after all), the you will find your F value and 
# the associated p value. Looks like there is not a significant effect of time on resting metabolic rate.
# 
# Post Hocs
# The overall test wasn't significant, so no need to worry about post hocs.









  
  
















