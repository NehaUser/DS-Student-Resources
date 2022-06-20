# Load libraries

library("rcompanion")
library("IDPmisc")
library("readr")

# Load Data

cruise_ship <- read_excel("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/cruise_ship.xlsx")
View(cruise_ship)

# determine whether each continuous variable is positively skewed, negatively skewed, or normally distributed. 
# Then perform the correct transformations to get as close to the normal distribution as possible for each variable.

colnames(cruise_ship)

# plot histograms for each continuous variable

plotNormalHistogram(cruise_ship$YearBlt) # negatively skewed
plotNormalHistogram(cruise_ship$Tonnage) # positively skewed
plotNormalHistogram(cruise_ship$passngrs) # positvely skewed
plotNormalHistogram(cruise_ship$Length) # negatively skewed
plotNormalHistogram(cruise_ship$Cabins) # positvely skewed
plotNormalHistogram(cruise_ship$Crew) # postively skewed
plotNormalHistogram(cruise_ship$PassSpcR) # positively skeewd
plotNormalHistogram(cruise_ship$outcab) # positively skeewd

# Transforming the positive skewed variables first by calculating sqrt

cruise_ship$TonnageSQRT <- sqrt(cruise_ship$Tonnage)

# Histogram
plotNormalHistogram(cruise_ship$TonnageSQRT) # Looks normal

cruise_ship$passngrsSQRT <- sqrt(cruise_ship$passngrs)

# Histogram
plotNormalHistogram(cruise_ship$passngrsSQRT) # Looks normal

cruise_ship$CabinsSQRT <- sqrt(cruise_ship$Cabins)

# Histogram
plotNormalHistogram(cruise_ship$CabinsSQRT) # Looks normal

cruise_ship$CrewSQRT <- sqrt(cruise_ship$Crew)

# Histogram
plotNormalHistogram(cruise_ship$CrewSQRT) # Looks normal

cruise_ship$PassSpcRSQRT <- sqrt(cruise_ship$PassSpcR)

# Histogram
plotNormalHistogram(cruise_ship$PassSpcRSQRT) # Looks normal

cruise_ship$outcabSQRT <- sqrt(cruise_ship$outcab)

# Histogram
plotNormalHistogram(cruise_ship$outcabSQRT) # Looks normal


# Transforming the negative skewed variables first by calculating square

cruise_ship$YearBltSQR <- cruise_ship$YearBlt ^ 2

# Histogram
plotNormalHistogram(cruise_ship$YearBltSQR) # doesnt look normal, should try cube



cruise_ship$YearBltCube <- cruise_ship$YearBlt ^ 3

# Histogram
plotNormalHistogram(cruise_ship$YearBltCube) # doesnt look normal, should try cube




cruise_ship$LengthSQR <- cruise_ship$Length ^ 2

# Histogram
plotNormalHistogram(cruise_ship$LengthSQR) # looks normal









