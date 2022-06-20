# Part 1

# Import the libraries needed
library(readr)
library(ggplot2)
library(lattice)
library("tidyr")


#Import the power boat dataset
powerboats <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/powerboats.csv")
View(powerboats)


# Plot the Histogram

x <- ggplot(powerboats, aes(x = PowerBoatsin1000s))
x + geom_histogram(binwidth = 100 , fill = "brown", color = "deepskyblue4")

# PART 2

#Plot a Bargraph

L3P2 <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/L3P2.csv")
View(L3P2)

ggplot(L3P2, aes(Cars))+ 
  geom_bar() +
  ggtitle("Frequency of Cars") +
  xlab("Car Category") +
  ylab("Frequency")

# PART 3 

# Plot a stacked bar chart

L3Part3 <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/L3Part3.csv")
View(L3Part3)

ggplot(data = L3Part3) +
  geom_bar(mapping = aes(x = Car, fill = Location)) + 
  ggtitle("Car Categories by Location") +
  xlab("Car Category") +
  ylab("Frequency") 

# PART 4

# Scatter Plot for the following dataset 

crocodiles <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/crocodiles.csv")
View(crocodiles)

scatterCroc <- ggplot(crocodiles, aes(x = HeadLength , y = BodyLength)) +
  geom_point() + ggtitle("Head Length vs Body Length of Estuarine Crocodile")
scatterCroc



# PART 5
# create a line graph

#import the data set

L6handson <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/L6handson.csv")
View(L6handson)

# Create a date column by appending the dat, month and year columns.

L6handson$Date_HA <- ''
L6handson <- unite(L6handson, Date_HA, Month, Day, Year , sep = '-')
head(L6handson)

# Replace space with '_' for column name 'heart attack'
names(L6handson) <- gsub(" ", "_", names(L6handson))

# Line Plot

ggplot(L6handson, aes(as.Date(Date_HA, "%b-%j-%Y"), Heart_Attacks)) +
  geom_line() + 
  xlab("Date of Heart Attack") + 
  ylab("Heart Attack Frequency") + 
  ggtitle("Frequency of Heart Attack over Time")


