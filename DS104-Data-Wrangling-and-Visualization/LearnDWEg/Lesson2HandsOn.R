# include library
library("readr")

#import the csv file 
airbnb_test_users <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/airbnb_test_users.csv")

View(airbnb_test_users)

# Q1. What is the average age of those who use each web browser type?

# Use aggregate function to calculate mean of age groupby first_browser

Avg_Age <- aggregate(age~first_browser, airbnb_test_users, mean)
View(Avg_Age)

# Q2. What is the total signup_flow for each device?

# Use aggregate function to calculate sum of signup_flow groupby first_device_type
Sum_Signup <- aggregate(signup_flow~first_device_type, airbnb_test_users, sum)
View(Sum_Signup)

# They would also like you to perform the following tasks:
# 1. They need the country information from the airbnb_sample_submission dataset included in the airbnb_test_users file.

#import the airbnb_sample_submission csv file
airbnb_sample_submission <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/airbnb_sample_submission.csv")
View(airbnb_sample_submission)

# To include country information, we need to join/ merge the two data sets based on the id

airnbnb_w_country <- merge(airbnb_test_users, airbnb_sample_submission, by=c("id"))
View(airnbnb_w_country)

# 2. Add additional users to the test file from the airbnb_users dataset.

#import the airbnb_users csv file
airbnb_users <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/airbnb_users.csv")
View(airbnb_users)

# To add users from the above file, in the test file
airnbnb_w_country <- rbind(airnbnb_w_country, airbnb_users) # This gives and error because the Column name 'country' is different in the two datasets.
                                                      # airbnb_users has Column name country_destination, while
                                                      # airnbnb_w_country has Column name country.


# Rename the column name, 'country' of test file to 'country_destination'
names(airnbnb_w_country)[names(airnbnb_w_country) == "country"] <- "country_destination"
View(airnbnb_w_country)

# Now performing the rbind function
airnbnb_w_country <- rbind(airnbnb_w_country, airbnb_users)
head(airnbnb_w_country)













