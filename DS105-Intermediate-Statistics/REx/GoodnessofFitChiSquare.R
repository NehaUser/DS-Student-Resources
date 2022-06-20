# Goodness of Fit Chi-Squares in R
# You will use a goodness of fit Chi-Square when you are trying to compare a sample to a population.
# It is similar in concept to the single sample t-test.

# Load in Libraries
# To compute a goodness of fit Chi-Square, the only package you will need is dplyr, to count up your data.

library("dplyr")

# Load Data
library(readr)
SW_survey_renamed <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/SW_survey_renamed.csv")
View(SW_survey_renamed)
# 
# Question Set Up
# You found something online that mentioned that 90% of people are Star Wars fans, and you want to see if that holds 
# true in your own survey. In this way, you are comparing your sample (the survey) to the population at large (what you read online).

# Data Wrangling
# In order to run a goodness of fit Chi-Square, you need the observed values for folks who are fans of Star Wars,
# and for folks who are not fans of Star Wars. You can easily get those values by aggregating your data using the dplyr
# summarize() function for count (n()):
#   
SW_survey_renamed %>% group_by(FanYN) %>% summarize(count=n())
# 
# Run Analysis
# Now you are ready to set up for your analysis!
#   
# You will want to define the observed values as vectors, which you got from above:
  
observed = c(552, 284)
# 
# Next, you will define a vector of your expected values. These expected values must equal 1.
# If they don't, you end up with this error when you eventually run your Chi-Square:
# 
# Error in chisq.test(x = observed, p = expected) : 
#   probabilities must sum to 1.
# Here is how you will define your expected values. Since you are comparing to the online estimate of 90% Star Wars fans,
# you will want the Star Wars fans to come first (to match the above, which started with the number of yesses) and you will 
# change 90% to .90:

expected = c(0.90, 0.10)

# And now you are ready to run the analysis itself, with the function chisq.test(), in which you will define the argument
# of x= with your observed frequencies, and in which you will define the argument of p= with your expected frequencies:
  
chisq.test(x = observed, p = expected)

# If the p value is less than .05, than your observed and expected values differ. In this case, this means that 
# the number of Star Wars fans is not 90%. You might conclude, then, that your sample is somewhat confused compared
# to the overall population.





  



