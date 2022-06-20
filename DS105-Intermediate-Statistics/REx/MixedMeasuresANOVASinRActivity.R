# A mixed measure ANOVA includes both a within and a between subject variable

# LOad libraries
# 
# Mixed measures ANOVAs come as part of the base package in R, so the only libraries you will need to load in are rcompanion 
# because you'll use it to check for the assumption of normality, and car if you need to run an ANOVA that will correct for a 
# violation of homogeneity of variance.

library("rcompanion")
library("car")
library("dplyr") # to look at the means


# Load Data
library(readr)
breakfast <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/breakfast.csv")
View(breakfast)

# Question Setup
# With this data, you will answer the question:
  
# Determine whether weight loss changes from baseline to follow up based upon whether or not a person eats breakfast in the morning.

# In order to answer this question, our first x, or independent variable, will be the 'Treatment Group' of whether they ate 
# breakfast in the morning or not. our second x will be time, whether it was baseline or follow up. our y, or dependent variable, 
# will be weight or Baseling Body Mass. As with all ANOVAs, the IV will be categorical, and the DV will be continuous.


# Data Wrangling

# Removing Extra Rows

# We can run the NaRV.omit() function and clean up any missing data, which should remove everything we're not interested in,
# or can just subset our data. In this case, we'll subset the data to only include the rows we want:

breakfast1 <- breakfast[1:33,]

# Reshaping the Data
# The other thing that needs to be done with our data is to reshape it, from width-wise to long-wise, so that we can run the ANOVA.
# The code to reshape only takes the variables that we want to flip and anything we want to hold constant, so we will need to 
# subset our data again to include only the columns we are interested in:

keeps <- c("Participant Code", "Treatment Group", "Age (y)", "Sex", "Height (m)", "Baseline Body Mass (kg)", "Follow-Up Body Mass (kg)")
breakfast2 <- breakfast1[keeps]

# Now comes the actual reshaping! We will need to do this for both the baseline and the follow up data. 
# Basically, we are going to keep the first five columns that don't change by timepoint, and then add to that new columns 
# of repdat and contrasts. The repdat column will hold the actual data from the baseline section, and the contrasts column will
# hold the information that says it was from the baseline timepoint.

breakfast3 <- breakfast2[,1:5]
breakfast3$repdat <- breakfast2$'Baseline Body Mass (kg)'
breakfast3$contrasts <- "T1"

# We will do the same thing with our follow-up data:

breakfast4 <- breakfast2[,1:5]
breakfast4$repdat <- breakfast2$'Follow-Up Body Mass (kg)'
breakfast4$contrasts <- "T2"

# Once we have both of those, then we need to rbind() them back together into one whole dataset:

breakfast5 <- rbind(breakfast3, breakfast4)

# Testing Assumptions
# The assumptions for a mixed measure ANOVA are the same as the ones you learned for a repeated measures ANOVA. 

# Normality
# You only need to test for the normality of the dependent variable, but you need to do it at both timepoints.
# So scoot on back to breakfast2, which is the dataset you truncated but had not yet reshaped.

plotNormalHistogram(breakfast2$'Baseline Body Mass (kg)')

#  Looks pretty normal and you'll take it, no transformation necessary!

# Try the follow-up data:

plotNormalHistogram(breakfast2$'Follow-Up Body Mass (kg)')

# And result! Another one normal enough to use without transformation! Yes, it may be a little platykurtic, 
# but it's centered in the middle, so count your blessings and go with it!
# 
# Homogeneity of Variance
# In this case, we are looking to see if Body Mass changed over time based on the condition (eating breakfast or skipping breakfast) the patient was
# placed in. So, a Levene's Test can be used instead to check for homogeneity of variance, using the function from the car library,
# leveneTest(). Here we will specify the variable information you are testing. Your y variable will go first, separated by a
# tilde and followed by your x variable and an asterisk, then your time variable. The time variable is contrasts, and remember 
# that it represents time 1 (baseline) or time 2 (follow up). Altogether, you can read this code as a sentence like this: 
# "Body weight by treatment group over time."

                   
leveneTest(breakfast5$repdat ~ breakfast5$`Treatment Group`*breakfast5$contrasts, data=breakfast5)

# Just like the other tests for homogeneity of variance, you want Levene's test to be non-significant 
# in order to pass this assumption. And lo and behold, it is! No need for correction!

# Correcting for Violations of Homogeneity of Variance
# If you had violated the assumption of homogeneity of variance, you could correct for it by running a BoxCox transformation 
# on your data, or by running a more robust ANOVA, that can handle a violation of this assumption.

# 
# Sample Size
# A mixed measures ANOVA requires a sample size of at least 20 per independent variable or time factor. 
# In this case, you only have one independent variable, and you also have a factor of time. So, you need 40 cases.
# You are a few cases short of this requirement, clocking in at only n = 33, but for learning purposes, you will proceed. 
# However, typically if you did not have a large enough sample size, you would either want to simplify your model 
# (remove either the IV or the time variable), choose a different analysis, or run a procedure called bootstrapping which
# would re-sample your data until you had a larger n.
# 
# Mixed Measures ANOVAs Analysis in R
# Alright! You've done all the prep work, now it's time for the fun!
#   
# Analysis
# You will continue to use the aov() function, but add some additional arguments to it to make it mixed measures.


RManova1 <- aov(repdat~(`Treatment Group`*contrasts)+Error(`Participant Code`/(contrasts)), breakfast5)
summary(RManova1)

# So what's happening here is that you are calling the aov() function on the interaction between all of your data factors. 
# First, you are saying that you want to see the repeated data of resting metabolic rate by your time factor (from baseline 
# to follow-up). That's this part: repdat~(Treatment.Group*contrasts. Next, you are adding in your error term, which is specified 
# in this model by the command Error(). In the error term, you are placing your subject identifier (which matches the pre
# and the post data together), and you also note that it needs to be done for both time factor groups as well. That's what 
# this part of the code is doing: +Error(Participant.Code/(contrasts). Finish it all off by specifying the dataset at the 
# end and you are good to go. Call summary() on the results:
# 
# This output is looking a little crazypants, compared to some of the previous output, so let's break it down! First of all,
# the only information you really need to pay attention to is in the last two columns: the F value and the associated p value.
# 
# The first row is the treatment group (skipping breakfast or eating breakfast) and looks at cweight by treatment group,
# regardless of the time point. It's basically a one-way ANOVA.
# 
# Same thing with the second row! But instead of treatment group, you have time as your one-way factor. This row is just 
# looking at change in weight from time point one to time point 2, regardless of what treatment group 
# the subjects were in.
# 
# The third row, however, focuses on the interaction between those two things. This is where the two-way design part comes in.
# This line is called the interaction effect. It looks at change in the weight over time by treatment group.
# 
# Unfortunately, absolutely nothing is significant here. There was no significant difference in resting metabolic rate between
# those who ate breakfast and those who didn't, there was no significant difference in resting metabolic rate between baseline and follow up, and there was no significant interaction between these factors.

# Post Hocs
# After finding such a load of bupkis above, so no need to worry about post hocs here!
  
  







