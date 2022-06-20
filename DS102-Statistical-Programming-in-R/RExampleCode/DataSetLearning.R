View(ToothGrowth)

ToothGrowth[(3:5),]  #Will display rows3to5
ToothGrowth[(3), c(1,2,3)] #will display row 3 and all 3 columns
head(ToothGrowth) #top 6 records
tail(ToothGrowth) #bottom 6 records

ToothGrowth[which(ToothGrowth$dose == 1), c(1,2,3)] #selecting rows with a condition


View(mtcars)
help("mtcars") #To get more information about what each of the columns in the data set represents.

colnames(mtcars) #To see the column names
summary(mtcars)

#Import a CSV file

# my_pets <- read.csv("Pets.csv")

#Import a .xlsx file

library(readxl)
my_petsExcel <- read_excel("Pets.xlsx")
View(my_petsExcel)


#Data Manipulation
#install.packages("dplyr")
library("dplyr")
my_pets <- read.csv("PetsCSV.csv")
View(my_pets)
#Filtering
filter(my_pets, Animal == "Goat")
filter(my_pets, Animal %in% c("Goat", "Cat"))
filter(my_pets, Animal == "Goat", Weight >35 )
filter(my_pets, Animal != "Gold Fish")

#Arranging
arrange(my_pets, Age)
arrange(my_pets,desc(Age))
my_pets %>% filter(Animal == "Goat") %>% arrange(Age)

mutate(my_pets, Weight_kg = Weight/2.20462)
my_pets %>% group_by(Animal) %>% summarise(mean_Age = mean(Age))

# Graphing group data

head(morley)
morley[10:25, ]

ggplot(morley, aes(x = Expt, y= Speed)) + geom_boxplot(aes(group = Expt))
morley %>% group_by(Expt) %>% summarise(Avg_Spd = mean(Speed))
