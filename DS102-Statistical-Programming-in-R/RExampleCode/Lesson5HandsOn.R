# Histogram using data set rivers.

View(rivers)
rr <- data.frame(rivers)
View(rr)

head(rr) # To view first 6 rows of data set rivers

hist_Riv <- ggplot(rr, aes(x = rivers))
hist_Riv + geom_histogram(breaks = seq(100, 4000, by = 250), fill = "blue", color = "deepskyblue4") +
  ggtitle("Graph of Major Rivers in North America") +
  xlab("Length of rivers (in miles)") +
  ylab("No. of rivers")
  

# Box Plot using the data set rivers

boxP_Riv <- ggplot(rr, aes(x = " ", y = rivers))
boxP_Riv + geom_boxplot() + xlab("") + ylab("Length of River(in miles)") +
  ggtitle("BoxPlot for major Rivers in North America")

# To figure out if there are outliers.
summary(rr$rivers)

var_1st_Quart <- 310
var_3rd_Quart <- 680
var_IQR <- var_3rd_Quart - var_1st_Quart
var_IQR
low_outlier <- var_1st_Quart - var_IQR * 1.5
high_outlier <- var_3rd_Quart + var_IQR * 1.5
low_outlier # Since there are no values under low_outlier -245 , it means there are no low outlier.
high_outlier # Since there are many values over high_outlier 1235, it means there are many high outlier.


# Normal Probability Plot

ggplot(rr, aes(sample = rivers)) + geom_qq() # Graph shows it's not normally distributed












  
  