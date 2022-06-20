library(DAAG) 
library(ggplot2)
library(dplyr)
library(reshape2)
library(gapminder)

#----------------------Data Exploration Part 1 ----------------

head(gapminder)
levels(gapminder$country) # different unique countries in this column
unique(gapminder$year) #unique values in year, can't use level as it's numeric

ggplot(gapminder,aes(x= factor(year),y=pop)) + geom_boxplot()

ggplot(gapminder, aes(x = factor(year), y = pop)) + geom_boxplot() +
  scale_y_log10()

#filtering and sorting

gm.big <- gapminder %>% filter(year == 2007) %>% arrange(desc(pop))
gm.big

head(gm.big , n=15)
tail(gm.big, n= 10)

ggplot(gapminder, aes(x = factor(year), y = gdpPercap)) + geom_boxplot()

summary(gapminder)

#inter quartile range 
x <- 9325.5 - 1202.1
y <- 9325.5 + x * 1.5
y

filter(gapminder, gdpPercap > y)

ggplot(gapminder, aes(x = factor(year), y = lifeExp)) + geom_boxplot()

filter(gapminder, lifeExp < 28)
filter(gapminder, continent == "Europe", lifeExp < 53 )

#----------------------Data Exploration Part 2 ----------------

gm_Angola <- filter(gapminder, country == "Angola")

#Life expectancy in Angola

ggplot(gm_Angola) + geom_line(aes(x= year, y= lifeExp)) +
  xlab("Year") + ylab("Life Expectancy") + ggtitle("Life Expectency in Angola over the years")

ggplot(gm_Angola) + geom_line(aes(x = year, y = gdpPercap)) +
  ylab("Per Capita GDP") + ggtitle("GDP in Angola")

# Comparison between Angola, Ghana, Ethiopia, and South Africa.

gm_Africa4 <- filter(gapminder, country %in% c("Angola", "Ghana", "Ethiopia", "South Africa"))

gm_AfricaClean <- select(gm_Africa4, country, year, lifeExp, gdpPercap) #To select few columns
head(gm_AfricaClean)

# OR

gm_AfricaClean <- gapminder %>%
  filter(country %in% c("Angola", "Ghana", "Ethiopia", "South Africa")) %>%
  select(country, year, lifeExp, gdpPercap)

life_Exp <- ggplot(gm_AfricaClean) + geom_line(aes(x = year, y = lifeExp, color = country)) +
  xlab("Year") + ylab("Life Expectancy") + ggtitle(("Life Expectancy of 4 Countries")) 

GDP_4count <- ggplot(gm_AfricaClean) + geom_line(aes(x = year, y = gdpPercap, color = country)) +
  ylab("Per Capita GDP") + ggtitle("GDP in Four Countries")


#To stack the plots

library(gridExtra)

grid.arrange(life_Exp, GDP_4count, ncol = 1)


# To plot the life expectancy both as lines and as points, 
# and make the area of the points be proportional to the per capita GDP

ggplot(gm_AfricaClean, aes(x = year, y = lifeExp, color = country)) + geom_line() +
  geom_point(aes(size = gdpPercap)) +
  ylab("Life Expectancy") + ggtitle("Life Expectancy and GDP in Four Countries")

ggplot(gm_AfricaClean, aes(x = gdpPercap, y = lifeExp, color = country)) +
  geom_point(aes(alpha = year), size = 3) + geom_path() +
  scale_alpha(range = c(0.3, 1.0)) +
  xlab("Per capita GDP") + ylab("Life Expectancy")


####Data Exploration 3 ######

#To compare different countries in Africa with respect to their gdp and life expectancy

gm_Median <- gapminder %>% filter(continent == "Africa") %>%
  group_by(year) %>% summarise(life_med = median(lifeExp), gdp_med = median(gdpPercap))
gm_Median










