# A mixed measure ANOVA includes both a within and a between subject variable

# Load libraries
# 
# Mixed measures ANOVAs come as part of the base package in R, so the only libraries you will need to load in are rcompanion 
# because you'll use it to check for the assumption of normality, and car if you need to run an ANOVA that will correct for a 
# violation of homogeneity of variance.

library("rcompanion")
library("car")
library("dplyr") # to look at the means
library("IDPmisc")


# Load Data

library("readr")
suicide <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/suicide.csv")
View(suicide)

# Question Setup
# With this data, you will answer the question:

# We will determine whether generation has any influence on suicide rates (suicides/100k pop) over the years (year),
# with country being the repeated variable.

# In order to answer this question, our first x, or independent variable, will be the generation. 
# Our second x will be time. Our y, or dependent variable, 
# will be suicide rates(suicides/100k pop). As with all ANOVAs, the IV will be categorical, and the DV will be continuous

# Testing Assumptions
# The assumptions for a mixed measure ANOVA are the same as the ones you learned for a repeated measures ANOVA. 

# Normality
# You only need to test for the normality of the dependent variable, but you need to do it at both timepoints.

plotNormalHistogram(suicide$`suicides/100k pop`)

# Try SQRT

suicide$`suicides/100k popSQRT` <- sqrt(suicide$`suicides/100k pop`)
plotNormalHistogram(suicide$`suicides/100k popSQRT`) # Better but try log

# Try Log


suicide$`suicides/100k popLOG` <- log(suicide$`suicides/100k pop`)
# Delete nulls/ infinite

suicide1 <- NaRV.omit(suicide)
plotNormalHistogram(suicide1$`suicides/100k popLOG`) 

#Let's use this, best in all 3

### Homogeneity of Variance

leveneTest(suicide1$`suicides/100k popLOG` ~ generation, data=suicide1)

# Since p-value < .05, it failed the test of variance of homogeniety

# Sample size -we have more than enough data

## Run the analysis

suicide1$year <- as.factor(suicide1$year) 
RManova <- aov(suicide1$`suicides/100k popLOG`~(generation*year)+Error(country/year), suicide1)
summary(RManova)

# Looks like there is effect of generation on suicide, and an interaction to how the year has affected the generation.

# Post hocs

pairwise.t.test(suicide1$`suicides/100k popLOG`, suicide1$generation, p.adjust="bonferroni")

# Looks like there is a significant difference in suicide rates among ALL the generations

## Determine Means and Draw Conclusions


suicideMeans <- suicide1 %>% group_by(generation, year) %>% summarize(Mean = mean(`suicides/100k popLOG`))

View(suicideMeans)


# Generation Z is the least likely to commit suicide. They were born mid 90's to early 2000s.
# The GI generation is the most likely. They were born 1901-1924. 
# we can see that these differ over time as well - looks like the GI generation as do millenials just keeps 
# rising in terms of suicide rates, while others like gen z and gen x are staying steady. 

