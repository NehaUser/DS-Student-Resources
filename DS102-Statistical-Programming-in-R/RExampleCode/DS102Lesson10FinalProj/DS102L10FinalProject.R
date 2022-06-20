# Use the Cigarette data set in the Ecdat package. 
install.packages("Ecdat")
library(Ecdat)

#Calling other libraries needed.
library(DAAG) 
library(ggplot2)
library(dplyr)
library(reshape2)

#TASK-1 Create a boxplot of the average number of packs per capita by state.
#Which states have the highest number of packs? Which have the lowest?

#View(Cigarette)

head(Cigarette)

# Box Plot for average number of packs per capita(packpc) by state(state).
ggplot(Cigarette, aes(x = state, y = packpc), group_by(state), color = state) +
  geom_boxplot() + xlab("State") + ylab("Average Packs of Cigarettes per Capita") +
  ggtitle("Average number of Cigarette packs per capita by State")

# State that has the highest number of packs
cig_High <- Cigarette %>% group_by(state) %>% arrange(desc(packpc))
cig_High

#AS we can see New Hampshire(NH) uses the maximum number of packs per capita

# State that has the lowest number of packs
cig_Low <- Cigarette %>% group_by(state) %>% arrange(packpc) # OR tail(cig_High)
cig_Low

#AS we can see Utah(UT) uses the minimum number of packs per capita

#TASK-2 Find the median over all the states of the number of packs per capita for each year. 
#Plot this median value for the years from 1985 to 1995. 
#What can you say about cigarette usage in these years?

#Calculate the median for each year
ds_MedPackYear <- Cigarette %>% group_by(year) %>% summarise(med_packYear = median(packpc)) 

#Plot the median for years 1985 to 1995
ds_filterYr = ds_MedPackYear %>% filter(year %in% (1985:1995)) # To filter the years

ggplot(ds_filterYr,aes(x = year, y = med_packYear)) +
  geom_point() +geom_line() + ylab(("Median over all the states of the no. of packs per capita")) +
  xlab("Years(1985 - 1995)") + ggtitle("Median for years 1985 to 1995")

#The plot shows the usage of cigarette has consistently dropped from 1985 to 1995


#TASK- 3 and 4 Create a scatter plot of price per pack(avgprs) vs number of packs per capita(packpc)
#for all states and years.

ggplot(Cigarette, aes(x= avgprs, y= packpc)) + geom_point() + geom_smooth(method = lm) 

#Are the price and the per capita packs positively correlated, negatively correlated, or uncorrelated?
#Explain why your answer would be expected.

#The plot shows that it's price per pack and number of packs are signifiacntly correlated 
#and negatively correlated, since the line goes from top to bottom.

# To check the correlation using formula
cor.test(Cigarette$avgprs, Cigarette$packpc, method = "pearson", use="complete.obs")

#This also shows that the price per pack and number of packs are signifiacntly 
# correlated since p-val is significantly less than .05
# and negatively correlated, since cor coeficient is -.6 
#that implies a negative (downhill sloping) relationship.

#TASK - 5 Change your scatter plot to show the points for each year in a different color. 
 #Does the relationship between the two variable change over time?

ggplot(Cigarette, aes(x= avgprs, y= packpc, color = year)) + geom_point() + geom_smooth(method = lm) 

#The plot shows that in earlier years, average price per pack was low and use of cigarette package per capita was high while
# in later years the consumption when down when price increased.

# TASK - 6 Do a linear regression for these two variables. 
# How much variability does the line explain?

lr_linreg <- lm(Cigarette$packpc~Cigarette$avgprs)
summary(lr_linreg)

#Variability = Adjusted R-squared; in this case it's .3415, so we can say 34% variability, the line represents.


#TASK- 7 Create an adjusted price for each row, then re-do your scatter plot and 
# linear regression using this adjusted price.
#Adjust the price of a pack of cigarettes for inflation by 
#dividing the avgprs variable by the cpi variable

newDF_Cig <- mutate(Cigarette, cigInf_pr = avgprs/cpi) #To add a new column for inflated price

#Scatter Plot using the new price
ggplot(newDF_Cig, aes(x=cigInf_pr, y =packpc, color = year)) + geom_point() + 
  geom_smooth(method = lm) + xlab("Inflated Price") + ylab("Average Cigarette Usage per Capita") +
  ggtitle("Inflated Price vs Usage of Cigarette per Capita Over the years")

#Linear Regression
lr_linregNew <- lm(newDF_Cig$packpc ~ newDF_Cig$cigInf_pr)
summary(lr_linregNew)

#TASK - 8 Create a data frame with just the rows from 1985. 
#Create a second data frame with just the rows from 1995. 
#Then, from each of these data frames, get a vector of the number of packs per capita. 
#Use a paired t-test to see if the number of packs per capita in 1995 was significantly different 
#than the number of packs per capita in 1985.

df_Cig85 <- Cigarette %>% filter(year == 1985) #Data frame with year 1985 only
df_Cig95 <- Cigarette %>% filter(year == 1995) #Data frame with year 1995 only

# Doing a paired t-test 
t.test(df_Cig85$packpc, df_Cig95$packpc, paired = TRUE)

#Since p-value(<2.2e-16) is much less than .05, it implies that number of packs per capita in 1995 
#was significantly different than the number of packs per capita in 1985.


#TASK 9 - If any question, analyse.
#Just wanted to see the scatter plot of usage of cigarette vs states over the years.
  
ggplot(Cigarette, aes(x= state, y= packpc, color = year)) + 
  geom_point() + geom_smooth(method = lm, se = FALSE, formula = y~x)  
















  