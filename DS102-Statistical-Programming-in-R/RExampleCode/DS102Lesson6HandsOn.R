
# From the mtcars data frame, create a box plot of miles per gallon (the mpg variable) 
#grouped by the number of cylinders in the engine (the cyl variable). Also, use the summarize() 
#and group_by() functions to compute how many cars have four cylinders, 
#how many have six, and how many have eight.

View(mtcars)
#Import libraries
library("ggplot2")
library("dplyr")

#Making the box plot
ggplot(mtcars, aes(x = cyl, y = mpg)) + 
  geom_boxplot(aes(group = cyl))

#Summarizing the data based on the different cylinders
mtcars %>% group_by(cyl) %>% summarize(count = n())