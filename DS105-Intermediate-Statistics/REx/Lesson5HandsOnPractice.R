# Load Libraries

install.packages("fastR2")

library("rcompanion")
library("fastR2")
library("car")

# Load Data

library("readr")
honey <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/honey.csv")
View(honey)
# 
# Question Setup

# Determine whether honey production totalprod has changed over the years.

# In order to answer this question,x , or independent variable, will be the time (year). 
# Your y, or dependent variable, will be the change in total production over the years. As with all ANOVAs, 
# the IV will be categorical, and the DV will be continuous.
# 
# Data Wrangling
# It may need some wrangling!

# Converting categorical variable in factor.

honey$year <- as.character(honey$year)

honey$year <- as.factor(honey$year)

View(honey)

# Now you are all prepared to run a repeated measures ANOVA, data shaping wise.
# 
 
# Normality
# You only need to test for the normality of the dependent variable.

plotNormalHistogram(honey$totalprod)

# Looks positively skewed, trying sqrt

honey$totalprodSQRT <- sqrt(honey$totalprod)

plotNormalHistogram(honey$totalprodSQRT)

# Still positively skewed, try log
honey$totalprodLOG <- log(honey$totalprod)

plotNormalHistogram(honey$totalprodLOG)

# Looks normal.

# Homogeneity of Variance

leveneTest(totalprodLOG ~ year, data=honey)
                      
# Clears the assumption of homogenity of variance for normally distributed variable.
#  No need for correction!

# Sample Size
# A repeated measures ANOVA requires a sample size of at least 20 per independent variable. You have that, 
# so this assumption has been met.

# Repeated Measures ANOVAs Analysis in R
# Alright! You've done all the prep work, now it's time for the fun!
#   
#   Analysis
# You will continue to use the aov() function, but add some additional arguments to it to make it repeated measures.

RManova <- aov(totalprodLOG~year+Error(state), honey)

summary(RManova)

# Under the Error:Within table (since this is a within subjects ANOVA, after all), the you will find your F value and 
# the associated p value. Looks like there is a significant effect of time on totalprod.

# Post hoc
honeymean <- honey %>% group_by(year) %>% summarize(Mean = mean(totalprod))

### ------ Although there's not much difference in the totalprod ovre the years, 
###       We can see that 2010 has the maximum production, and 2012 the least. ---- ##









  
  
















