# ------- Does the average price of avocados differ between Albany, Houston, and Seattle? ------#

# Load Libraries

library("dplyr")
library("rcompanion")
library("car")
library("IDPmisc") # For any missing data

# Load Data

library("readr")
avocados <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/avocados.csv")
View(avocados)

# Question Setup
# Does the average price of avocados differ between Albany, Houston, and Seattle?
# In order to answer this question, our x, or independent variable, will be the region, 
# which has three levels: Albany, Houston, and Seattle. Our y, or dependent variable, will be the Averageprice.

# As with all ANOVAs, the IV will be categorical, and the DV will be continuous.

# Data Wrangling
# Depending on the data, it may need some wrangling!

# Filter the Data and Remove Missing Values

# In this case, the data has many more regions than three, so we will need to filter the dataset by the regions we want:
# Albany, Houston, and Seattle.

unique(avocados$region)  # To check different regions
  
avocados1 <- na.omit(avocados %>% filter(avocados$region %in% c("Albany", "Houston", "Seattle")))

# Make AveragePrice Numeric

avocados1$AveragePrice <- as.numeric(avocados1$AveragePrice)

# Now we are all prepared to run a one-way ANOVA.

# Test Assumptions
 
# Normality
# We only need to test for the normality of the dependent variable, since the IV is categorical.

plotNormalHistogram(avocados1$AveragePrice)  # Looks slightly positively skewed.

# So, let's try to transform averageprice by square rooting or log the column.

avocados1$AveragePriceSQRT <- sqrt(avocados1$AveragePrice)
plotNormalHistogram(avocados1$AveragePriceSQRT) # This looks pretty Normal, lets try log and see.

# So that hasn't made any improvements. Try to do log it:

avocados1$AveragePriceLog <- log(avocados1$AveragePrice)

avocados2 <- NaRV.omit(avocados1) # TO remove error

plotNormalHistogram(avocados2$AveragePriceLog)

# It looks much better now.

# Homogeneity of Variance
# You can test for homogeneity of variance easily using either Bartlett's test or Fligner's Test.

# Bartlett's Test - We'll do Bartlett test because data looks normal.

bartlett.test(AveragePriceLog ~ region, data=avocados2)

# The p value (p-value = 7.543e-16)associated with this test is < .05(significant), which means we have violated the assumption of 
# homogeneity of variance.

# Sample Size
# Looking at the data, the n is 18,249, so we are fine to proceed with this assumption!

# Independence
# There is no statistical test for the assumption of independence.

# Correcting for Violations of Homogeneity of Variance
# Computing ANOVAs with Unequal Variance (Violated Homogeneity of Variance Assumption)

# If we need to correct for violating the assumption of homogeneity of variance, we can run an ANOVA that was meant to 
# correct for that violation, using a Welch's One-Way Test. To do this, you will actually create a linear model first,
# and then use the function Anova() on it.

# Here's how this will look:
  
ANOVA <- lm(AveragePriceLog ~ region, data=avocados2)
Anova(ANOVA, Type="II", white.adjust=TRUE)

# This is significant at p < .01, 2.2e-16 in our case, so we can conclude that
# there is a significant difference in AveragePrice somewhere between the three levels of our independent variable region.

# Computing Post Hocs When We've Violated the Assumption of Homogeneity of Variance

pairwise.t.test(avocados2$AveragePriceLog, avocados2$region, p.adjust="bonferroni", pool.sd = FALSE)

# Determine Means and Draw Conclusions

# Since we found a significant difference after correction, we would want to finish interpreting the results and draw some
# conclusions. 

avocadosmean <- avocados2 %>% group_by(region) %>% summarize(Mean = mean(AveragePrice))

print(avocadosmean)

## ------------- Results -------------##
# The given data was positively skewed, so after performing log, it looked normal.
# Did Bartlett's test, since the data looked normal.
# The data violated the assumption of homogeneity of variance.
# To correct for  violating the assumption of homogeneity of variance, we ran an ANOVA which showed the significant difference 
   # between the AveragePrices between different regions based on the p-value.
# Since data violated the Assumption of Homogeneity of Variance, we did bonferroni test with pool.sd = FALSE.

# The mean for corrected data is 1 Albany   1.56
#                                2 Houston  1.05
#                                3 Seattle  1.44. 
# The means are different but not significant. 
# So we can say that AveragePrice for Avocados in Albany, Houston and Seattle are pretty close, being the least in Houston.




  
  






























