# Load Data

library(readr)
bacteria <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/bacteria.csv")
View(bacteria)

# Question Setup
# You are trying to answer the question of how does much does bacteria grow over time.
# You will examine the change in Count, your y variable, over time Period, your x variable.

#Exponential Modeling
# As with quadratic modeling, you will start by using the lm() function.
# However, you will need to take the log of the y variable using the log() function:

exMod <- lm(log(bacteria$Count)~bacteria$Period)
summary(exMod)

# By looking at the bottom F-statistic and associated p-value,
# you see that this model is significant! That means that this particular bacteria 
# does demonstrate exponential growth over time. 
# Looking at the Estimate column, you can see that for every one additional time b in, 
# the bacteria has increased by 16%!

  














