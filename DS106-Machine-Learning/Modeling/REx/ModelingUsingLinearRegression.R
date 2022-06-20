install.packages("car")
install.packages("caret")
install.packages("gvlma")
install.packages("predictmeans")
install.packages("e1071")
install.packages("lmtest")


library("car")
library("caret")
library("gvlma")
library("predictmeans")
library("e1071")
library("lmtest")

library(readr)
manatees <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/manatees.csv")
View(manatees)

# Do the number of powerboats registered in Florida impact the number of manatees 
# killed there by powerboats each year?


# Test Assumptions
# 1. Testing for Linearity

# /* Before conducting a regression analysis, it is important to first create a scatterplot
# and visually examine the data. You can only use linear regression when the two variables show a "linear" shape.
# If the data look like a random scattering of points, curved, or any other strange shape, there is no linear 
# relationship in the data, and so it's not appropriate to run linear regression. Start by looking at the scatterplot,
# to determine whether you have a linear relationship between your two variables.*/ #

scatter.smooth(x=manatees$PowerBoats, y=manatees$ManateeDeaths, main="Manatee Deaths by Power Boats") 
# SHOWS there is a linear relationship between the number of power boats and the number of manatee deaths.


# 2. Testing for Homoscedasticity

# Create the Linear Model
# In order to do this, you first need to create the basic regression model, 
# because you will be able to run a whole bunch of tests once you have it, 
#including the test for homoscedasticity. Here is the code to create a linear model:#

lmMod <- lm(ManateeDeaths~PowerBoats, data=manatees)
# Put your dependent variable first, in this case, ManateeDeaths, and then a tilde (~) to mean 
# "by" and then specify your independent variable. Lastly, specify the dataset with the data= command.

# Test for Homoscedasticity
# So you now have a model created, but you don't actually want to test a hypothesis yet.
# You want to see if this model is robust enough to use for analysis, which means it needs to 
# meet all of our assumptions. You can create some graphs that will allow you to test for homoscedasticity using this code:

par(mfrow=c(2,2))
plot(lmMod)

# The top left graph shows the fitted values against the residuals, 
# while the bottom left shows the fitted values against the standardized residuals. 
# Both of these graphs should show random points with a flat red line, straight across, if they are 
# homoscedastic and thus meeting the assumptions that allow you to complete linear regression

# you can also test for homoscedasticity with the Breush-Pagan test or the Non-Constant Variance (NCV) test.
# Here's the code for the Breush-Pagan test:

lmtest::bptest(lmMod)
#  we have a p value of .004. Since this is less than .05, it means it is significant, and having a 
# significant Breush-Pagan test means that you unfortunately have heteroscedasticity.

# Similarly, here's the code for the NCV test:
car::ncvTest(lmMod)

#You get a p value of .005, shown below. The same rules apply as for your Breush-Pagan test,
# so since this is significant, you have a third indicator that the data is heteroscedastic, 
# and you have not met the assumption of homoscedasticity.

# Correcting for Homoscedasticity Violations

# The first thing to try is to transform your dependent variable. 
# You'll use a Box-Cox transformation, to try and make your data more normal.
# You can run the following code from the caret library:

distBCMod1 <- caret::BoxCoxTrans(manatees$ManateeDeaths)
print(distBCMod1)

# But this by itself is not incredibly helpful, though it can be nice to summary statistics 
# on your transformed dependent variable. In order to re-test your transformed variable, you need to bind
# it to the current dataset, using the function cbind():

manatees <- cbind(manatees, dist_newM=predict(distBCMod1, manatees$ManateeDeaths))

# You use the cbind() function to tack on the new variable, which has been named dist_newM, 
# which is filled with the predicted data from the Box-Cox transformation you did above (distBCMod1).

# Then it's just a simple matter of creating a new linear model using your transformed dependent variable, 
# and testing it once more with either the Breush-Pagan test or the NCV test, like so:

lmMod_bc2 <- lm(dist_newM~PowerBoats, data=manatees)
lmtest::bptest(lmMod_bc2)

# You'll notice that the results are still significant.
# So you are STILL violating the assumption of homoscedasticity, which is a bummer.

# and just for the purposes of learning, you'll continue on with the regression even though you have violated the assumption of homoscedasticity.

# 3. Testing for Homogeneity of Variance

# Above, you were able to generate plots for testing homoscedasticity by looking at your residuals. 
# These plots also provide useful information about homogeneity of variance, or how evenly your data is distributed. 
# All you need to do is to see whether your data forms a nice box, or whether it is cone shaped at either end. 
# In this case, the residual plots you generated above (repeated here for your convenience) show no cone, 
# so you have passed the assumption of homogeneity of variance.

# The GVLMA Library for Assumptions # it's sometimes accurate depending on the data so cant rely on it all the time
gvlma(lmMod_bc2)


# Screening for Outliers

# You will need to test for all three types of outliers: distance, leverage, and influential points.

# Testing for Outliers in X Space

# You will start by screening for outliers in x space. You can do this by looking at Cook's Distance values.
# To do this, you'll use the predictmeans library. Just run your regression model through the function CookD.
# It will generate a plot that highlights anything that is an outlier in x space.

CookD(lmMod, group=NULL, plot=TRUE, idn=3, newwd=TRUE) # So cases numbered 24, 26, and 29 are all outliers in x space.

# You can also look at leverage values. Anything that has a leverage value of 
# between .2 and .5 is a moderate problem, and anything over .5 is a major problem.

# To test for leverage, you will use the ```hat`` function and then plot it:

lev = hat(model.matrix(lmMod))
plot(lev)

# You can probably guess that you don't have anything over .2 by looking at this chart,
# but it's good to know for sure. You can check with the code below, which will provide you with 
# a list of data points with leverage over .2.

manatees[lev>.2,]

#In this case, this is the only output you get out, and the lack of numbers tells out that you 
# have no outliers with a leverage over .2, like you suspected in your chart.
#Therefore, you can conclude that you have no outliers in x space.

# Testing for Outliers in y Space

# This is typically done using something called the studentized deleted residual, 
# or sometimes just shortened to the studentized residual. This is similar to your regular residual, 
# or error term, which you have already learned, but instead of calculating standard error with all of the residuals, 
# you calculate it based on n - 1. This means that you have deleted one residual, which is where the name comes from.

#There is a simple line of code coming from the car library for the outlierTest function that will
# provide you with information about the studentized deleted residual:

car::outlierTest(lmMod)

# This particular code tests for the very furthest outlier. If the Bonferroni p value is significant
# (i.e. less than .05), then it is likely that you have at least one outlier. You can also look at the 
# column for rstudent, which is the raw studentized deleted residual. If this value is over 2.5 or 3ish, 
 # you have a problem with outliers in the y space. Here your value is 2.6, so it could be considered an outlier,
# but since your Bonferroni p value is not significant, you'll leave it be. You have no outliers in y space.


# Testing for Outliers in x and y Space
# To test for influential values, or outliers in both x and y space, there are two metrics to look at: 
# DFFITS and DFBETAS.

# They are readily available with the function influence.measures for your model. Check it out!

summary(influence.measures(lmMod))

# The column named dfb.1_ is for DFBETAS, and the one named dffit is for DFFITS. If a DFFITS or DFBETAS 
# value is greater 1, you most likely have a problem with outliers that are influential. Luckily in this case, 
# there are no values greater than 1 for these three points, so you have no influential outliers in your data.


# Interpreting Output

summary(lmMod_bc2)

# The first thing to look at in this output is the very bottom line, which reads F-Statistic. 
# This tells you the F Statistic for the overall model as well as the p value for the overall model. 
# The larger the F statistic, the more likely it is to be significant, and with a whopping 286,
# you would expect p to be significant. Lo and behold, it is at p < .001.

# So what is the practical interpretation of the slope not being equal to zero? 
# It means there is sufficient evidence to lead us to believe that the number of registered power
# boats in Florida somehow influences the manatee deaths in Florida.

# Your decision rule is to reject the null hypothesis, since the p value is less than .05. 
# There is sufficient evidence to suggest that there is a linear relationship between the number of
# powerboats registered in Florida and the number of manatees killed by powerboats. This conclusion fits our intuition.
# If there are more boats on the water, it seems plausible that this may be related to the number of manatees killed.




















































