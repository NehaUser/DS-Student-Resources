# Lesson 10 HandsOn in R

# Load Libraries

library("gmodels")
library("tidyr")
library("dplyr")
library("rcompanion")
library("car")
library("IDPmisc") # For any missing data

# Scenario 1 : # We have to know that 28 of the 94 claimants are not nearly as “disabled” as their diagnosis suggests, 
# and the hypothetical level of fraud is 16%.

# One proportion z-test - since we are just comparing one thing to whole and it has one categorical component.

prop.test(x = 28, n = 94, p = 0.16, alternative = "two.sided", correct = FALSE)

# since p-val = .0003, the claimants are nearly as 'disabled' as the diagnosis suggests and level of fraud is different than 16%

# ------------ Scenario 1 Conclusion ---------------------- #
# The claimants are nearly as 'disabled' as the diagnosis suggests and level of fraud is different than 16%
# --------------------------------------------------------- #

#  Scenario 2 : # Medical researchers are trying to understand if four topical antiseptics are being used in the same ratio 
# at three different clinics in town. 

library(readr)

df2 <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/FinalHandsOn/antiseptics.csv")
View(antiseptics)

df2.expanded <- df2[rep(row.names(df2), df2$`Number of applications`), 1:2]

CrossTable(df2.expanded$Clinic, df2.expanded$`Antiseptic Type`, fisher=TRUE, chisq = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")

# Since the p-val > .05, the test is not significant and we can say that the four topical antiseptics are
# used in the sameratio at the 3 clinics.

# ------------ Scenario 2 Conclusion ---------------------- #
# The four topical antiseptics are used in the same ratio at the 3 clinics in town.
# --------------------------------------------------------- #


## Scenario 3 - A financial institution is interested in the savings practices of different demographic groups and want to advertise accordingly..

df3 <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/FinalHandsOn/savings.csv")
View(df3)

df3.reformat <- gather(df3, key="Group", value="Price")

df3.reformat <- na.omit(df3.reformat)

# Plotting the normality graph
plotNormalHistogram(df3.reformat$Price)  # Looks pretty normal

# Homogeneity of Variance
# Bartlett's Test

bartlett.test(Price ~ Group, data=df3.reformat)

# Since p-value < .05, which in significant , we have violated the assumption of homogeneity of variance.

# Sample Size
# Looking at the data, the n is 222, so we are fine to proceed with this assumption! 

# Computing ANOVAs with Unequal Variance (Violated Homogeneity of Variance Assumption)

ANOVA <- lm(Price ~ Group, data=df3.reformat)
Anova(ANOVA, Type="II", white.adjust=TRUE)

# since p-val < .05, there should be a difference in average savings per group or demographics.

# ------------ Scenario 3 Conclusion ---------------------- #
# There's a difference in average savings per group or demographics. But the posthocs show no difference using bonferroni.
# --------------------------------------------------------- #


#Scenario 4
# The local school board conducted a poll to gauge public sentiment about a school bond. They asked respondents if 
# they favored or opposed a bond in the upcoming election.
#
# With school age children and favorable - 374
# With school age children and unfavorable - 129
# Without school age children and favorable - 171
# Without school age children and unfavorable - 74

# TwoProportion z testing

prop.test(x = c(374, 171), n = c(374 + 129, 171 + 74),
          alternative = "two.sided")

# p-value = 0.2194, we can say that there's not much difference between the respondents who favors or oppose the bond.

# ------------ Scenario 4 Conclusion ---------------------- #
# There's not much difference between the respondents who favors or oppose the bond.
# --------------------------------------------------------- #






