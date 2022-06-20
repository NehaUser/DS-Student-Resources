# Load Library

library("ggplot2")

#Loading data

library(readr)
bluegill_fish <- read_csv("Documents/GitHub/DS-Student-Resources/DS106-Machine-Learning/Modeling/REx/bluegill_fish.csv")

# Question Setup
# The question you will be answering is: Does the age of the bluegill fish influence their length?

# Graph a Quadratic Relationship
# Graph it against a best-fit quadratic line to see if your data really was quadratic in nature.

quadPlot <- ggplot(bluegill_fish, aes(x = age, y=length)) + geom_point() + 
  stat_smooth(method = "lm", formula = y ~x + I(x^2), size =1)
quadPlot

# You will use bluegill_fish as your dataset, specify age as your x= variable, 
# and specify length as your y= variable. Then you can add dots with geom_point(), 
# and add a best fit line with stat_smooth(). As arguments, you will add method="lm", 
# then write out the quadratic formula, which is y ~ x + I(x^2).

# Looks like a quadratic line is a pretty good fit for the data!

# Model the Quadratic Relationship
# Now that you are sure you have a quadratic relationship, you can go ahead and model it! 
# You will need to square the x term, however, first. In this example, your x is age. 
# Simply square it like this and save it as its own variable, Agesq:

Agesq <- bluegill_fish$age^2

# Then you're ready to dust off that favorite tool of yours, lm(). 
# This time, however, you'll use specify a slightly more sophisticated model so that 
# you can make it quadratic in nature! You'll do the y, which is length, by the x, which is age,
# and then add in the Agesq variable that you created above.

quadModel <- lm(bluegill_fish$length~bluegill_fish$age+Agesq)
summary(quadModel)

# Looking at the overall F-statistic shown on the bottom and associated p-value,
# this quadratic model is significant! 
# This means that age is a significant quadratic predictor of bluegill fish length.





  
  










  