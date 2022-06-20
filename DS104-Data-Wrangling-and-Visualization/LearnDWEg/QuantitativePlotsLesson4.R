library(readr)
library(ggplot2)
library(lattice)


HR_data <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/HR_data.csv")
View(HR_data)

HRplot <- ggplot(HR_data, aes(x=satisfaction_level))
HRplot + geom_histogram(binwidth = .025, fill = "brown", color = "deepskyblue4")

#Bar chart

ggplot(HR_data, aes(salary))+ 
  geom_bar() +
  ggtitle("Frequency of Salary") +
  xlab("Salary Category") +
  ylab("Frequency")

#Bar Charts with Lattice

#install and work with a library called lattice for plotting in R.
#It is quick and easy way to plot. 
#All you really need to do is to specify your variable, using the function barchart():

barchart(HR_data$salary)

barchart(HR_data$salary, main="Frequency of Salary", 
         ylab = "Salary Category", xlab = "Frequency", col="blue")

# Stacked bar chart in R

ggplot(data=HR_data) +
  geom_bar(mapping = aes(x = sales, fill=salary)) + 
  ggtitle("Sales Categories by Salary Level") +
  xlab("Sales Category") +
  ylab("Frequency") 

# Making Bar Heights the Same

# Simply add another argument to geom_bar() called position= and set it to "fill":
ggplot(data=HR_data) +
  geom_bar(mapping = aes(x = sales, fill=salary), position = "fill") + 
  ggtitle("Sales Categories by Salary Level") +
  xlab("Sales Category") +
  ylab("Frequency") 

# Multiple Categorical Variables

#can also compare them side by side if you'd rather.
# That's also an easy fix in ggplot: just change the postion= argument to "dodge", 
# which will place your bars side by side.


ggplot(data=HR_data) +
  geom_bar(mapping = aes(x = sales, fill=salary), position = "dodge") + 
  ggtitle("Sales Categories by Salary Level") +
  xlab("Sales Category") +
  ylab("Frequency") 

# Scatter Plots

#Make a scatter plot 
USDA_nutrition <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/USDA_nutrition.csv")
View(USDA_nutrition)

scatterNutrition <- ggplot(USDA_nutrition, aes(x = fats, y = carbs, color = fiber)) +
  geom_point()
scatterNutrition

# Line Charts
# Line charts in R can be created using ggplot's geom_line() function

earthquakes <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/earthquakes.csv")
View(earthquakes)

# You can determine the data type by calling the str() function, which stands for structure
str(earthquakes)
# As you can see, this shows that M is being treated as a factor, not numeric.
# There is an easy way to fix it - just use the as.numeric() function on the data:

earthquakes$M <- as.numeric(earthquakes$M)
str(earthquakes)

#  Instead of just putting Date into the aes() function by itself, 
# the trick is to call as.Date in aes() on the Date variable and specify the format the date should take.

ggplot(earthquakes, aes(as.Date(Date, "%j-%b-%y"), M)) +
  geom_line() + 
  xlab("Date of Earthquake") + 
  ylab("Earthquake Magnitude") + 
  ggtitle("Magnitude of Earthquakes over Time")




