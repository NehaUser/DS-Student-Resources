# Load Libraries
# In order to run independent Chi-Squares in R, you will need to install and load the library gmodels.

install.packages("gmodels")
library("gmodels")

# Load Data

library(readr)
SW_survey_renamed <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/SW_survey_renamed.csv")
View(SW_survey_renamed)
# 
# Question Set Up
# One of the quintessential debates in Star Wars fandom is whether you are a fan of episodes I, II, and III 
# (the newer, second trilogy of movies) or a fan of episodes IV, V, and VI (the older, beginning trilogy of movies).
# In this Chi-Square, you will determine whether age category Age influences someone's ranking of Episode I: The Phantom Menace.
# 
# Data Wrangling
# This data is already formatted correctly for an independent Chi-Square.
# 
# Testing Assumptions and Running the Analysis
# There are two assumptions associated with independent Chi-Squares. The first is that you need to have independent data.
# This is just a theoretical requirement - each person or object must be able to fit in only one cell.
# The second is that your expected frequencies must be greater than 5 for each cell. You will be able to check this second
# assumption by running your Chi-Square and asking for expected frequencies.
# 
# You will use the CrossTable() function from the gmodels library, and specify your IV followed by your DV. 
# Then you can use the argument fisher=TRUE to specify that you want to use the Fisher's Exact Test method to calculate your
# effect size for Chi-Square, and the chisq=TRUE argument is to get the results from your Chi-Square. The next argument is the one of
# two that are required to get your expected frequencies. expected=TRUE will provide the expected frequencies, but you also
# need to include format="SPSS" to get them printed out! This format mimics the output you would receive if you used the
# statistical program SPSS.
# 
# The last argument is sresid=TRUE, and this provides standardized residuals. Those will be used for determining effect sizes later.


CrossTable(SW_survey_renamed$Age, SW_survey_renamed$RankI, fisher=TRUE, chisq = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")


# The very first output provides you a guide to each individual cell. First you'll see the actual count,
 # then you will see the expected values, then the Chi-Square contribution, then Row Percent, Column Percent, Total Percent,
 #and your standardized residual.

# 
# Check Assumption of Expected Frequencies
# You will want to look in the second row in each cell to find the expected frequency. Ideally, 
# you want to have the expected value greater than 5 for each cell, but that's a pipe dream typically. 
# You are technically allowed to have 20% of your cells with 5 or less, as long as none of them are zero. Luckily, 
# you have no zeros here, and it looks like although there are some cells that have values less than five, only 6/30 have that, 
# which happens to be 20%! So you are golden, and meet the assumption for Chi-Square. You can now proceed to interpret your results!


# Interpret Results
# The results are shown at the bottom of your output, under the heading Pearson's Chi-squared test.
# If the p value is less than .05, than this analysis is significant, meaning that age does in fact make a difference 
# in how people rank Episode I.

# 
# Post Hocs
# You may be wondering HOW age influences rankings for Episode I. The way you can do this is through a post hoc analysis, 
# which will help you determine where those differences lie. With a Chi-Square, the way you will interpret your significant
# findings with a post hoc is with the standardized residual, which is located on the very bottom of the cell. 
# As a general rule, anything that has a standardized residual with an absolute value greater than or equal to two is 
# significantly different than what you expected. It is greater than expected if there is a plus sign, and it is less than 
# expected if there is a minus sign. Looking at the results above, you can see the following:
#   
#   More people who did not disclose their age ranked Episode I first than expected
# More people aged over 60 ranked Episode I first than expected
# Fewer people aged over 60 ranked Episode I fifth or sixth than expected
# More people aged 18-29 ranked Episode I fifth or sixth than expected
# Fewer people aged 30-44 ranked Episode I first than expected
# More people aged 30-44 ranked Episode I sixth than expected
# Fewer people aged 45-60 ranked Episode I sixth than expected
# Now, if you were to write this all out and present upon it at a business, you will get laughed out of the house, or even worse,
# completely ignored. So you'll need to summarize things and put them in layman's terms. Maybe something like this:
#   
#   People either loved or hated Episode I.  Those who did not disclose their age, those who were 30-44 or over 60 years old 
# were more likely to rank Episode I as their favorite. Those over 45 years old were less likely to to rank Episode I as their 
# least favorite, and those over 60 years old were less likely to rank Episode I fifth. Those in the 30-44 year old age
# group were more likely to rank Episode I last, however.
# You will only look at standardized residuals if your Chi-Square is significant overall! 
# Otherwise you may be reporting spurious data.



























