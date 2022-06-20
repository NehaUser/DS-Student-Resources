# 
library("readr")
Eating_Habits <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/Eating_Habits.csv")
View(Eating_Habits)
Eating_Habits1 <- Eating_Habits

# Recode Activity into a new variable called JunkFood. 
# Anything that you would consider junk food, recode as a 1. Everything else should be recoded as a zero.

unique(Eating_Habits$Activity)

Eating_Habits$JunkFood <- NA

Eating_Habits$JunkFood[Eating_Habits$Activity == "Eating fruit"] <- 1
Eating_Habits$JunkFood[Eating_Habits$Activity == "Eating peanuts"] <- 1
Eating_Habits$JunkFood[Eating_Habits$Activity == "Eating raw vegetables"] <- 1
Eating_Habits$JunkFood[Eating_Habits$Activity == "Eating whole wheat or rye bread"] <- 1
Eating_Habits$JunkFood[Eating_Habits$Activity == "Drinking whole milk"] <- 1
Eating_Habits$JunkFood[Eating_Habits$Activity == "Drinking coffee"] <- 1
Eating_Habits$JunkFood[Eating_Habits$Activity == "Drinking low fat milk"] <- 1
Eating_Habits$JunkFood[Eating_Habits$Activity == "Eating candy, chocolate bars"] <- 0
Eating_Habits$JunkFood[Eating_Habits$Activity == "Eating french fries"] <- 0
Eating_Habits$JunkFood[Eating_Habits$Activity == "Drinking soft drinks, cola or other drinks with sugar"] <- 0
Eating_Habits$JunkFood[Eating_Habits$Activity == "Drinking potato chips, crisps"] <- 0
Eating_Habits$JunkFood[Eating_Habits$Activity == "Eating hamburgers, hot dogs or sausages"] <- 0

# Recode Sex from text to numbers in the same variable

Eating_Habits1$Sex[Eating_Habits1$Sex == "Males"] <- 0
Eating_Habits1$Sex[Eating_Habits1$Sex == "Females"] <- 1

View(Eating_Habits1)

# To dummy code the frequency variable:

library("psych")

Eating_Habits1 <- dummy.code(Eating_Habits$Frequency)
Eating_Habits2 <- data.frame(Eating_Habits, Eating_Habits1)

View(Eating_Habits2)




