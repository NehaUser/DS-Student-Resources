library(DAAG) 
library(ggplot2)
library(dplyr)
library(reshape2)
View(greatLakes)

erie <- greatLakes[,1]
#erie.ds <- as.data.frame(erie)
huron <- greatLakes[,2]
df_greatLakes <- data.frame(erie, huron) #create a data frame of the vectors

t.test(df_greatLakes$erie, df_greatLakes$huron, alternative = "two.sided", var.equal = FALSE)

##THIS
df_greatLakes$X <- 1:nrow(df_greatLakes) # create a new column with the index numbers
ggL <- melt(df_greatLakes , id = 'X')

ggplot(ggL) + geom_boxplot(aes(x = variable, y = value))

#####OR
ggl2 <- melt(df_greatLakes, measure.vars = c("erie", "huron"))
ggplot(ggl2) + geom_boxplot(aes(x = variable, y = value))

