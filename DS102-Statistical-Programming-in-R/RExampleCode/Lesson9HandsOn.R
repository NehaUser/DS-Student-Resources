#Include the libraries
library(DAAG) 
library(ggplot2)
library(dplyr)
library(reshape2)
library(gapminder)

# To check the countries in the database gapminder
levels(gapminder$country)
unique(gapminder$year)

#Choose 5 countries of choice
#Data set to include only data from 5 chosen countries
gmind_5Count <- gapminder %>% filter(country %in% c("India", "United States", "Australia", "China", "Mexico"))
gmind_5Count #Data set of 5 countries.

gmind_5Count %>% filter(year == 1952) %>% arrange(desc(gdpPercap)) # Highest GDP per Capita
 #USA has highest GDP per Capita in year 1952 
# China has the lowest.

gmind_5Count %>% filter(year == 2007) %>% arrange(desc(gdpPercap)) # Highest GDP per Capita
#USA has highest GDP per Capita in year 2007 
# India has the lowest.

#Creating a line plot for life expectancy of these 5 countries over the years
ggplot(gmind_5Count) + geom_line(aes(x = year, y= lifeExp, color = country)) +
  xlab("Year") + ylab("Life Expectancy") + ggtitle("Life Expectancy of 5 Countries over the years")

#Compute the median of life Expectancy for each year for 5 selected Countries
gm_5CMed <- gmind_5Count %>% group_by(year) %>% summarise(med_lExp5 = median(lifeExp))
gm_5CMed

#Compute the median of life Expectancy for each year for gapminder dataset
gm_FullMed <- gapminder %>% group_by(year) %>% summarise(med_lExp = median(lifeExp))
gm_FullMed

meddiff <- gm_5CMed$med_lExp5 > gm_FullMed$med_lExp




