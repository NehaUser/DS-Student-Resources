# Analyzing bank loan data.

# Load Packages
library("readr")
library("gmodels")
library("tidyr")
library("dplyr")



# Load Data

loans <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/loans.csv")
View(loans)

# Part I
# Please answer the following question.
# Does the term of the loan influence loan status? If so, how?

# We need to do Independent Chi-Square test because we need to check how one variable influence the other.

# Data Wrangling
# This data is already formatted correctly for an independent Chi-Square.

# Testing Assumptions and Running the Analysis
# There are two assumptions associated with independent Chi-Squares. The first is that we need to have independent data.
# The second is that our expected frequencies must be greater than 5 for each cell. 

CrossTable(loans$term, loans$loan_status, fisher=TRUE, chisq = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")

# The results show the value of p < .05, 0 in this case so it means, the loan term influences the status of loan.
# Looking at the standardized residual, which is located on the very bottom of the cell, we can see 
# the loan is Fully Paid for a loan term of 36 months compared to 60 months.

# ----- PART 1 Conclusion - The loan term influences the status of loan.
# -----                     The loan is most likely Fully Paid for a loan term of 36 months compared to 60 months. --- #


# Part II
# Please answer the following question.
# How has the ability to own a home changed after 2009?

# We will use McNemar Chi-Square test since we are looking the variable change for different periods of time.

# Data Wrangling
head()
str(loans) # check the structure of the data.

# Date is not in Date Format, we need to change it.

loans$DateR <- as.Date(loans$Date, format="%m/%d/%Y")   # Reformatting to a Date

# Separating the Pieces of the Date Variable because we just need year.
# Once this is done, we will want to separate this out, so that we can look at and recode the Year column individually.

loans1 <- separate(loans, DateR, c("Year", "Month", "Day"), sep="-")
head(loans1)

# Recoding to before or after 2009

loans1$YearR <- NA
loans1$YearR[loans1$Year <= 2009] <- 0
loans1$YearR[loans1$Year > 2009] <- 1


# Recoding home_ownership for Owned or Rented

loans1$home_ownershipR <- NA
loans1$home_ownershipR[loans1$home_ownership == 'RENT'] <- 0
loans1$home_ownershipR[loans1$home_ownership == 'OWN'] <- 1

# Test Assumptions and Run Analyses
CrossTable(loans1$YearR, loans1$home_ownershipR, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")

# Check Assumption of Expected Frequencies
# In order to meet the assumption for the McNemar Chi-Square, we need to have at least 5 expected per cell. 
# With the lowest expected value being in the five hundresa, we have definitely met this assumption!

# Interpret Results
# The p value = 0 , which is less than .05 for McNemar's Chi-squared test, so this test is significant.
# This means that the ability to own a home has changed after 2009. 

# We find that none of your standardized residuals are over 2. This means that this test is not really significant after all.
# Looking at the row total percentages, we see how the ownership before 2009 are at 18%, and after 2009 are 82%.
# So the ability to own a home has drastically improved after 2009.

# ----- PART 2 Conclusion - The ability to own a home has drastically improved after 2009. ----- #



# Part III
# Please answer the following question.

# The news just ran a story that only 15% of homes are fully paid for in America, and that another 10% have given up on paying
# it back, so the bank has "charged off" the loan. Does it seem likely that the data for this hands on came from 
# the larger population of America?

# WE are going to use Goodness of Fit Chi-Squares because we are trying to compare a sample to a population.


# Data Wrangling

# In order to run a goodness of fit Chi-Square, we need the observed values for homes that are fully paid,
# and the homes for which the loans have been charged off or not paid for.
 
loans %>% group_by(loan_status) %>% summarize(count=n()) 

# Charged off = 3282
# Fully Paid = 18173
# Current = 502

# Run Analysis

# We need to define the observed values as vectors, which we got from above:

observed = c(18173, 3282, 502)

# Next, we will define a vector of our expected values. These expected values must equal 1.

expected = c(0.15, 0.10, 0.75)

# Run the analyses

chisq.test(x = observed, p = expected)

# Since the p-value < .05, the observed and expected values differ, which means that our sample is not same as what the population says.

# ----- PART 3 Conclusion - It seems that the data for this hands on didn't come from the larger population of America.  ----- # 










  







