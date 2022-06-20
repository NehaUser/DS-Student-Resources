library("rcompanion")
library("IDPmisc")
library(readr)

anime <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/anime.csv")
View(anime)

# Visualizing Transformations

plotNormalHistogram(anime$score)
# Oh good! This one looks to be approximately normally distributed. No need to transform that.

# Transforming Positively Skewed Data

plotNormalHistogram(anime$scored_by)

# It looks to be horribly positively skewed.

# Using sqrt()
# So start with a square root transformation, by using the function sqrt() just as a mathematical operation:
  
anime$scored_bySQRT <- sqrt(anime$scored_by)
plotNormalHistogram(anime$scored_bySQRT)

# It looks better than before, but perhaps it can be better still.

# Using log()
# So make a larger transformation - you will now take the log of the scored_by variable, using the log() function:

anime$scored_byLog <- log(anime$scored_by) 

plotNormalHistogram(anime$scored_byLog)
# 
# Removing Infinite Values
# You probably got an error here:
#   
#   Error in seq.default(min(x), max(x), length = length) : 'from' must be a finite number
# 
# This is because the log transformation made a few of the numbers so small that R gave up, 
# and just gave them the value of -inf, or infinitely small. Most functions in R will not work with infinite data, 
# including this one. There is, however, a package and a line of code that can save the day.-IDPmisc

anime2 <- NaRV.omit(anime)

# The library IDPmisc contains an ability to omit missing and infinite value data, called NaRV.omit(). 
# Simply put your dataset name in as the argument. Then graph again, with the new dataset name:

plotNormalHistogram(anime2$scored_byLog)

# This one looks to be normally distributed. 
# 
# Transforming Negatively Skewed Data
# You will follow a similar process to transform negatively skewed data, but this time, 
# you will use squaring or cubing to transform your data.
# 
# The variable aired_from_year is negatively skewed:

plotNormalHistogram(anime$aired_from_year)

anime$aired_from_yearSQuare <- (anime$aired_from_year)^2

plotNormalHistogram(anime$aired_from_yearSQuare)
# 
# That looks a bit better, but not amazing. No where near normally distributed.
# 
# Cubing the Variable
# Now try cubing it:
  
anime$aired_from_yearCUBE <- anime$aired_from_year ^ 3

plotNormalHistogram(anime$aired_from_yearCUBE)
# 
# Tukey's Ladder of Power Transformation
# Wouldn't it be wonderful if there was some function that automatically transformed your data correctly,
# without all this time consuming guess work? Well, there is great news for you! There is. It's called the transformTukey function,
# which performs Tukey's Ladder of Power Transformation, and is available from the rcompanion package as well.

cruise_ship <- read_excel("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/cruise_ship.xlsx")
View(cruise_ship)

plotNormalHistogram(cruise_ship$Tonnage)

# And then you can transform it with Tukey's, where the function transformTukey() takes the argument
# data$variable and where the argument plotit= takes either TRUE to add a plot or FALSE to do without.

cruise_ship$TonnageTUK <- transformTukey(cruise_ship$Tonnage, plotit=FALSE)

# Then you can plot again to see if it made a difference:

plotNormalHistogram(cruise_ship$TonnageTUK)

# And it did! Your data is now approximately normal, and it didn't require you to do a lot of trial and error guesswork.







  
  


  
