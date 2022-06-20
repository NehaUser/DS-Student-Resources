# Inbuilt data set nhtemp
View(nhtemp)

#create vectors for temperatures for first 25 years and last 25 years

first25 <- nhtemp[1:25]
last25 <- nhtemp[36:60]

#create a dataframe using the above vectors
df_nhtemp <- data.frame(first25, last25)

# Dependent ttest to see if these two vectors have the same meanornot.
t.test(df_nhtemp$first25, df_nhtemp$last25, paired = TRUE)

#Since, the p-value < .05, the null hypotheses is rejected. 
#There's a significant difference between the means of two vectors

mean(df_nhtemp$first25)
mean(df_nhtemp$last25) # It implies that the temperature in the last 25 years was more than the first 25 years.

ss_plotbox <- melt(df_nhtemp, measure.vars = c("first25", "last25"))

ggplot(ss_plotbox) + geom_boxplot(aes(x = variable, y = value)) + 
  xlab("Value") + ylab("Temperature")
