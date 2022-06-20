vec1 <- c(5,10,3,9,8)
vec2 <- seq(2,6, by = 2)
vec2[2]
vec2 <- seq(1,10, length.out = 5)

100:1
#[1],[20],[39] are the index of first element in the line.

#calculations on vactors

vec3 <- vec1 * 2
vec3
vec4 <- vec1 / vec2 
vec4

length(vec4)

#logical operators on vectors
vec_greater_than1 <- vec4[vec4 > 1]
vec_smaller_than1 <- vec4[vec4 <= 1]

library(datasets)

View(faithful)

eruptions.time <- faithful$eruptions
mean(eruptions.time)
median(eruptions.time)
min(eruptions.time)
max(eruptions.time)
var(eruptions.time)
sd(eruptions.time)

summary(eruptions.time)
length(eruptions.time)

sort(eruptions.time)
sort(eruptions.time, decreasing = TRUE)

wait.times <- faithful$waiting

max(wait.times)

#installing packages
install.packages("datasets")
install.packages("readxl") 
install.packages("dplyr") 
install.packages("PerformanceAnalytics")
install.packages("corrplot") 
install.packages("gapminder")
install.packages("gridextra")
install.packages("Ecdat")
install.packages("corpcor")
install.packages("GPArotation")
install.packages("psych")
install.packages("IDPmisc")
install.packages("lattice") 
install.packages("treetop")
install.packages("scales")
install.packages("rcompanion")
install.packages("gmodels")
install.packages("car")
install.packages("caret")
install.packages("gvlma")
install.packages("predictmeans")
install.packages("caret")
install.packages("magrittr")
install.packages("tidyr")
install.packages("lmtest")
install.packages("popbio")
install.packages("e1071")
install.packages("data.table")
install.packages("effects")
install.packages("multcomp")
install.packages("mvnormtest")








