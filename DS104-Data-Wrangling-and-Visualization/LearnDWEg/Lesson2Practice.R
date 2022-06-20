library("readxl")
tea <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/tea.xlsx")
View(tea)

#Rows to columns
tea_transposed <- t(tea)
View(tea_transposed)

class(tea_transposed)

# turn into a data frame using the function as.data.frame():

tea1 <- as.data.frame(tea_transposed)
View(tea1)

#to rename them, 
#you could use the gsub() function within the names() function to do so. 

names(tea1) <- gsub("V", "Year", names(tea1))



## Lesson 2 activity : Data tansformation - Energy excel file
library(readxl)
energy <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/energy.xlsx")
View(energy)

#To transpose rows in columns
energy_trans <- t(energy)
View(energy_trans)

# convert the matrix format to data set 
energy1 <- as.data.frame(energy_trans)

#Change the column names 

names(energy1) <- gsub("V" , "hello" , names(energy1))
View(energy1)


# Joining data sets in R
# Joining, or merging, will add variables to your dataset, as long as there is at least one variable in common between the two datasets.
# Example: Two data sets : performances, judgesAspectsUnique
# These data sets have the variable name performance_id in common, which acts as a unique key for the data.
 
# combine the datasets by merge() function and common id with by= 

performances <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/performances.xlsx")
View(performances)
judgesAspectsUnique <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/judgesAspectsUnique.xlsx")
View(judgesAspectsUnique)

PerformjudgesAspects <- merge(performances, judgesAspectsUnique, by=c("performance_id"))
View(PerformjudgesAspects)

# For all data outer join and not inner join

IceSkating2 <- merge(performances, judgesAspectsUnique, by=c("performance_id"), all=TRUE)
View(IceSkating2)

# Merge with Different ID Column Names
# The by.x is for your initial dataset, and the by.y is for your second dataset.

IceSkating2 <- merge(performances, judgesAspectsUnique, by.x=c("performance_id"), by.y=c("id_performance"))

# When Columns are Named the Same, but Contain Different Data?

#
 # You ended up with two columns named scores_of_panel, one in each dataset, 
#and so R automatically added on .x or .y to inform you from which dataset that column originated. 
# In this case, x will always be the dataset you listed first in the merge, and y will always be the second dataset you listed in the merge.

# Appending Data sets
# Column names should be the same and their type should be same in both the data sets
# The function is rbind() in R

muscles1 <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/muscles1.xlsx")
View(muscles1)

muscles2 <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/muscles2.xlsx")
View(muscles2)

muscles3 <- rbind(muscles1, muscles2)
head(muscles3)


#Lesson2 Practice Handson on Merge/ Append

ZikaColombia <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/ZikaColombia.xlsx")
View(ZikaColombia)

ZikaUS <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/ZikaUS.xlsx")
View(ZikaUS)

# Append the data sets together

ZikaUSCol <- rbind(ZikaColombia, ZikaUS)

View(ZikaUSCol)


