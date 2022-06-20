# McNemar Chi-Squares
# The McNemar Chi-Square is used when you are trying to look at something over time, and have only two timepoints; 
# maybe a pre and a post. The timepoints are your independent variable. You are also limited to two levels of your 
# dependent variable. You can think of a McNemar Chi-Square like a dependent t-test for categorical data.
# 
# Load in Libraries
# In order to complete McNemar Chi-Squares in R, the only libraries you will need are gmodels to conduct the Chi-Square,
# and tidyr to do some data wrangling (though you might not always need to wrangle your data).

library("gmodels")
library("tidyr")

# Load in Data

library(readr)
bakery_sales <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/bakery_sales.csv")
View(bakery_sales)

# Question Set Up
# You will be answering the following question:
#   
# Do the sales of coffee change from the beginning of the month to the end of the month?
# 
# Data Wrangling
# Looking at your data, you will find that you only have a single Date variable, and that you only have a single Item variable.
# Date is not broken up yet into the beginning and the end of the month, and Item is not broken into coffee or other.
# So, you will need to do a bit of recoding!
#   
# Check the Structure of Your Data
# First, it's always a good idea to check the structure of your data. You can use the str() function to do so:

str(bakery_sales)
# 
# The first thing that you should notice here is that your Date column is not formatted as a date, and you will need to do
# that before going farther.
# 
# Reformatting to a Date
# Reformatting to a date can be done with the function as.Date():
#   
bakery_sales$DateR <- as.Date(bakery_sales$Date, format="%m/%d/%Y")

# You can specify that this be a new variable by putting a new name at the front before the <-, 
# and then you'll use the function as.Date(). Specify the original variable you are formatting as a date, 
# and then you'll need to use the argument format= to specify how the date has come in. Remember that the format needs to 
# match the data exactly. The %m is for a decimal month, the %d is for a decimal day, and the %Y is for a four-digit year. 
# You will notice that they are all separated by a / because that is how the data are separated in the orginal column.
# 
# Separating the Pieces of the Date Variable
# Once that is done, you will want to separate this out, so that you can look at and recode the Day column individually.
# You'll utilize the separate() function from the tidyr package:

bakery_sales1 <- separate(bakery_sales, DateR, c("Year", "Month", "Day"), sep="-")

# And the result is that you now have month, day, and year, all split out in your dataset.
# 
# Recoding to Beginning or End of Month
# Now that you have Day separated from the pack, you can see to the recoding:
  
bakery_sales1$DayR <- NA
bakery_sales1$DayR[bakery_sales1$Day <= 15] <- 0
bakery_sales1$DayR[bakery_sales1$Day > 15] <- 1

# This code first opens up a new variable named DayR, and then splits the content in half. 
# Anything that is on the 15th of the month or earlier is recoded as a zero, while anything on the 16th of the month or 
# later will be recoded as a one.

# Recoding to Coffee or Other
# The last recode you have left to undertake is to recode the Item variable from listing every single item out to 
# recoding into the discrete categories of coffee or not coffee. Below, you'll find code that creates a new variable
# named CoffeeSales and fills it with a 1 for anything that is Coffee and fills it with a 0 for anything that is not coffee.

bakery_sales1$CoffeeSales <- NA
bakery_sales1$CoffeeSales[bakery_sales1$Item  == 'Coffee'] <- 1
bakery_sales1$CoffeeSales[bakery_sales1$Item  != 'Coffee'] <- 0

# And with that, you are now ready to launch into your assumption testing and analysis!
#   
# Test Assumptions and Run Analyses
# The assumptions for a McNemar Chi-Square is the same as for an independent Chi-Square: you need to have at least 5 
# expected observations in each cell. And just like the independent Chi-Square, in R, you will need to run the entire 
# analysis first and then check the assumption. All the code is nearly the same, too, except that you will add in the argument 
# of mcnemar=TRUE. Take a look:
  
CrossTable(bakery_sales1$DayR, bakery_sales1$CoffeeSales, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")

# Check Assumption of Expected Frequencies
# In order to meet the assumption for the McNemar Chi-Square, you will need to have at least 5 expected per cell. 
# With the lowest expected value being in the two thousands, you have definitely met this assumption!
#   
#   Interpret Results
# You will start by looking at the p value for McNemar's Chi-squared test. It doesn't usually matter whether you look
# at the original or the one with the continuity correction - they are usually pretty close. If the p value is less than .05,
# then this test is significant. This means that on this occasion, there is a difference in coffee sales from the beginning 
# to the end of the month.
# 
# Post Hocs
# What does that difference actually look like? Well that's a matter for post hocs, and again, like the independent Chi-Square,
# you will examine the standardized residuals. Anything with an absolute value of 2 (can be positive or negative) differs from
# expected. However, looking at your post hocs (which have been corrected to account for the possibility of Type I error), you 
# find that none of your standardized residuals are over 2. This means that this test was not really significant after all. 
# A good litmus test for this is to look at your row total percentages. See how sales at the beginning of the month are at 52%,
# and sales at the end of the month are 48%? Do the sales of coffee change from the beginning of the month to the end of the month?
# Although these are technically different, they're pretty darn close, and the test has decided that they are similar enough that 
# it is not significant.
# 



  
  
  
  
  
  
  
  