# OneWay in ANOVA

# Load Libraries

library("dplyr")
library("rcompanion")
library("car")
library("IDPmisc") # For any missing data

#Load Data

library("readr")
YouTubeChannels <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/YouTubeChannels.csv")
View(YouTubeChannels)

# Question Set Up

# Determine if there is a difference in the number of views (Video views) differs between all the different grade categories (Grade)
# Independent Variable - Grade Categories - x
# Dependent Variable - Video views - y

# As with all ANOVAs, the IV will be categorical, and the DV will be continuous.

# Data Wrangling
# Depending on the data that we've been given, it may need some wrangling!

# Omit null values

YouTubeChannels <- na.omit(YouTubeChannels)

# Now we are all prepared to run a one-way ANOVA.

# Test Assumptions
 
# Normality
# We only need to test for the normality of the dependent variable, since the IV is categorical.

# Plotting the normality graph
plotNormalHistogram(YouTubeChannels$'Video views')  # Looks extremely poitively skewed

# Transforming the variable using sqrt

YouTubeChannels$'Video views_SQRT' <- sqrt(YouTubeChannels$'Video views')

# Plotting the normality graph
plotNormalHistogram(YouTubeChannels$'Video views_SQRT')  # Still Looks extremely poitively skewed

# Transforming the variable using log
YouTubeChannels$'Video views_Log' <- log(YouTubeChannels$'Video views')

# Plotting the normality graph
plotNormalHistogram(YouTubeChannels$'Video views_Log')  # This look Negatively Skewed now 

# Let's stick with sqrt, as Log changed it way too far.

# # Transforming the variable SQUARE for Negatively skewed data
# YouTubeChannels$'Video views_SQR' <- (YouTubeChannels$'Video views_Log')^2
# plotNormalHistogram(YouTubeChannels$'Video views_SQR')  # Still Looks Negatively skewed
# 
# # Transforming the variable Cube for Negatively skewed data
# YouTubeChannels$'Video views_Cube' <- (YouTubeChannels$'Video views_Log')^3
# plotNormalHistogram(YouTubeChannels$'Video views_Cube')  # This looks Normally Distributed.

# Homogeneity of Variance
# Bartlett's Test

bartlett.test(YouTubeChannels$'Video views_SQRT' ~ Grade, data=YouTubeChannels)

# Since p-value < 2.2e-16, which in significant , we have violated the assumption of homogeneity of variance.

# Fligner's Test

fligner.test(YouTubeChannels$'Video views_SQRT' ~ Grade, data=YouTubeChannels)
# Since p-value < 2.2e-16, which in significant , we have violated the assumption of homogeneity of variance.

# Sample Size
# Looking at the data, the n is 4,994, so we are fine to proceed with this assumption! 

# Computing ANOVAs with Unequal Variance (Violated Homogeneity of Variance Assumption)

ANOVA <- lm(YouTubeChannels$'Video views_SQRT' ~ YouTubeChannels$Grade, data=apps)
Anova(ANOVA, Type="II", white.adjust=TRUE)

# This is significant at p < .01, 2.2e-16 in our case, so we can conclude that number of views differs significantly between all 
# the different grade categories.

# Post Hocs
# Computing Post Hocs When We've Violated the Assumption of Homogeneity of Variance

pairwise.t.test(YouTubeChannels$'Video views_SQRT', YouTubeChannels$Grade, p.adjust = "bonferroni", pool.sd = FALSE)

# Determine Means and Draw Conclusions

YouTubeChannels_Mean <- YouTubeChannels %>% group_by(YouTubeChannels$Grade) %>% summarize(Mean = mean(YouTubeChannels$'Video views'))

print(YouTubeChannels_Mean)

# All grades significantly differ from all other grades in the number of views they receive, with the higher grades
# typically getting more views. 








