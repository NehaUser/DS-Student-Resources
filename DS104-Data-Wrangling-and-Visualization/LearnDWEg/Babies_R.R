
library(readxl)

babies <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/babies.xlsx")
View(babies)

# To create a new column
babies$Footprint = " "

#To rename a column name
# Call names function, change parentphonenum to phone.
names(babies)[names(babies) == 'ParentPhoneNumber'] <- "Phone"
View(babies)
head(babies)

#Combining Columns in R

#In R, this function is called unite, and it is contained within the tidyr package
install.packages("tidyr")
library("tidyr")

babies2 <- unite(babies, Address, StreetAddress, City, Zipcode, sep = "/")
View(babies2)

babies1 <- separate(babies2, Address, c("StreetAddress", "City", "Zipcode"), sep = "/")
View(babies1)

# Subsetting using Indexes

babies3 <- babies[1:3, 1:8] # take rows from  1 to 3 and columns 5 to 8
head(babies3)


# Subsetting using column names
# create a new vector, in this case, called Keeps
Keeps <- c("Name"," Birthday", "City")
babies4 <- babies[Keeps]

