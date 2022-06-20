# Load Libraries
# ANOVAs come as part of the base package in R, so the only libraries you will need to load in are dplyr because you'll 
# need it for some data wrangling, rcompanion because you'll use it to check for the assumption of normality, 
# and car if you need to run an ANOVA that will correct for a violation of homogeneity of variance.

library("dplyr")
library("rcompanion")
library("car")
library("IDPmisc") # For any missing data

# Load Data

library("readr")
NEWgoogleplaystore <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/NEWgoogleplaystore.csv")
View(NEWgoogleplaystore)

# Question Setup
# With this data, you will answer the question:
# Is there a difference in price among the three app categories of beauty, food and drink, and photography? 
# In order to answer this question, your x, or independent variable, will be the app categories, 
# which has three levels: beauty, food and drink, and photography. Your y, or dependent variable, will be the price.
# As with all ANOVAs, the IV will be categorical, and the DV will be continuous.

# Data Wrangling
# Depending on the data that you've been given, it may need some wrangling!

# Filter the Data and Remove Missing Values
# In this case, the data has many more categories than three, so you will need to filter the dataset by the categories you want:
# beauty, food and drink, and photography.

unique(NEWgoogleplaystore$Category)
apps <- na.omit(NEWgoogleplaystore %>% filter(NEWgoogleplaystore$Category %in% c("BEAUTY", "FOOD_AND_DRINK", "PHOTOGRAPHY")))

# Make Price Numeric
# You will also need to make your dependent variable, price, numeric, so that you can test for some of your assumptions:
  
apps$Price <- as.numeric(apps$Price)

# Now you are all prepared to run a one-way ANOVA.

# 
# Test Assumptions
# Before you go any further, it's important to test for assumptions. If the assumptions are not met for ANOVA,
# but you proceeded anyway, you run the risk of biasing your results.
# 
# Normality
# You only need to test for the normality of the dependent variable, since the IV is categorical.

plotNormalHistogram(apps$Price)  # Looks positively skewed.

# Looks like that isn't normal in any way - it is very highly positively skewed. So, you'll try to transform price by square 
# rooting or cube rooting the column.

apps$PriceSQRT <- sqrt(apps$Price)
plotNormalHistogram(apps$PriceSQRT)

# So that hasn't made any improvements. Try to do log it:

apps$PriceLog <- log(apps$Price)

apps1 <- NaRV.omit(apps) # TO remove error

plotNormalHistogram(apps1$PriceLog)

# It looks much better now.

# ANOVA is somewhat tolerant of violations of normality when you have a large sample size. 
# Your other option would be to run another analysis that did not require normality.

# Homogeneity of Variance
# You can test for homogeneity of variance easily using either Bartlett's test or Fligner's Test.
# Bartlett's test is for when your data is normally distributed, and Fligner's test is for when your data is non-parametric.
# No matter which test you are using, you are looking for a non-significant test.
# The null hypothesis for both of these is that the data has equal variance, so you'd like to have a p value of > .05.
# You have already determined your data is not normally distributed, so ordinarily you would just perform Fligner's test, 
# but just for learning purposes, you'll try both here.


# Bartlett's Test
# To do Bartlett's test, use the function bartlett.test(), with the argument of the y data separated by a tilde, 
# followed by the x data. Then there's an argument data=, which is where you will specify the name of your dataset.

bartlett.test(PriceLog ~ Category, data=apps1)

# The p value associated with this test is > .05(non-significant), which means you have succeeded the assumption of homogeneity of variance.

# 
# Here is the output:
# 
# Bartlett test of homogeneity of variances
# bartlett.test(Price ~ Category, data=apps)

# data:  Price by Category
# Bartlett's K-squared = Inf, df = 2, p-value < 2.2e-16
# The p value associated with this test is < .05, which means that unfortunately, you have violated the assumption of homogeneity of variance.

# Fligner's Test
# To perform Fligner's test, use the function fligner.test(), with the argument of the y data separated by a tilde,
# followed by the x data. Then there's an argument data=, which is where you will specify the name of your dataset.

fligner.test(PriceLog ~ Category, data=apps1)

# The p value is still > .05(non-significant), which means you have succeeded the assumption of homogeneity of variance.


# Here is the output:
# 
# Fligner-Killeen test of homogeneity of variances
# fligner.test(Price ~ Category, data=apps)
# data:  Price by Category
# Fligner-Killeen:med chi-squared = 4.878, df = 2, p-value = 0.08725
# Although this test is less significant than Bartlett's, because you have run the correct test for your data,
# the p value is still < .05, which means you have violated the assumption of homogeneity of variance.

# Correcting for Violations of Homogeneity of Variance
# There are two ways that you can correct for a violation of homogeneity of variance. 
# The first is the BoxCox transformation of your data, and the second is running a slightly different type of ANOVA,
# one that was created specifically to handle this violation. That test is called the Welch One-Way Test, 
# and you'll learn about this ANOVA option.
# 
# Sample Size
# An ANOVA requires a sample size of at least 20 per independent variable. In this case, you only have one independent variable, 
# so as long as you have at least 20 cases, you are fine. Looking at the data, the n is 515, so you are fine to proceed 
# with this assumption!
# Independence
# There is no statistical test for the assumption of independence.

# Computing ANOVAs with Equal Variance (Met Homogeneity of Variance Assumption)
# In this case, your data met this assumption, so this is the appropriate ANOVA to compute.

# Below is the code to run a one-way ANOVA in R. You can give your ANOVA a name; this one is named appsANOVA. 
# Then you want to use the function aov(). The argument for this function is your y variable, which is continuous, 
# followed by a tilde and then your x variable, which is categorical. Remember that the tilde reads as "by," 
# so you can think of this as analyzing price by category.

appsANOVA <- aov(apps1$PriceLog ~ apps1$Category)

# Here is an example of the summary() function:
  
summary(appsANOVA)

# The first row of the output has the Df, or degrees of freedom. The row for your category is calculated as 1 - # of Levels, 
# so that is always a good gut check. Next, you have rows for the Sum Sq and Mean Sq; these are just some of the calculations that
# went into getting your F-value, which is the test statistic for an ANOVA. The real meat that you want to pay attention to is 
# the F value itself and the associated p-value next to it. Like anything else, if this value is less than .05, the test was 
# significant. If you ever need a reminder of that, you can look at the star and Signif. codes down at the bottom. 
# The p value is above 0.05 and there's no star next it, so the test is not significant.

# Computing ANOVAs with Unequal Variance (Violated Homogeneity of Variance Assumption)
# If you need to correct for violating the assumption of homogeneity of variance, you can run an ANOVA that was meant to 
# correct for that violation, using a Welch's One-Way Test. To do this, you will actually create a linear model first,
# and then use the function Anova() on it.

# Fun Fact!
# The distribution and statistics behind regression and ANOVAs are the same! However, they way you use and conceptualize them 
# is very different.
# 
# Here's how this will look:
  
ANOVA <- lm(Price ~ Category, data=apps)
Anova(ANOVA, Type="II", white.adjust=TRUE)

# First, create and name a linear model that uses the same set up as the ANOVA with equal variance. 
# Then, call the Anova() function on that named model, include the argument of Type= and set it to "II" because this 
# is a between subjects ANOVA, and then use the argument white.adjust=TRUE. This last part, setting white.adjust= to TRUE, 
# is what makes this ANOVA appropriate when you have unequal variance.
# 
# It provides a little less information in terms of the math behind calculating the F statistic, but really,
# all the information you need to interpret the data is there. This is significant at p < .01, so you can conclude that
# there is a significant difference in price somewhere between the three levels of your independent variable.
# 
# Post Hocs
# Now the problem with an ANOVA is that you have multiple groups. When you found significance with a t-test, you were able to just
# look at the means and you knew where the significant differences lie. You knew what was higher, and what was lower.
# But with an ANOVA, you can't just look at the means right away, because the F and associated p value just let you know that there
 #is a difference between at least set of the three categories. In your example, the mean prices could be different between the 
 #beauty and food and drink category, the beauty and photography category, the food and drink and photography category, or some
 # combination of those three!
# 
# That's where post hocs come in. They are specifically designed to test all the pairs between your data, which is why they are
# also often known as pairwise comparisons. This is done with t-tests. But the inherent problem with using multiple t-tests is 
# that the more analyses you run, the more you increase your chances of Type I error. So you're more likely to find something 
# significant when it really isn't. So, typically a post hoc will apply a correction, or adjustment, so that the t-tests become 
# more stringent, and you are therefore correcting for doing multiple t-tests by applying stricter criteria. That way your 
# Type I error doesn't run rampant!
# 
# There are many different corrections you can apply. But the most common ones you'll hear about are Tukey, Bonferroni, Holm, 
# and Scheffe. All named by after the people who came up with them, by the way. These three are in order of how much correction
# they apply, with Tukey applying the least correction and Scheffe applying the most. Unfortunately, R does not compute Tukey 
# and Scheffe automatically, so you'll stick to exploring the difference between no correction at all, and a Bonferroni correction.

# Computing Post Hocs with No Adjustment
# Here is the code for computing a post hoc in R:
  
pairwise.t.test(apps$Price, apps$Category, p.adjust="none")

# Use the pairwise.t.test() function, with the arguments of the two variables you are crossing, and the argument p.adjust=. 
# To show you why a correction is necessary, you will start out with a value of "none", which means that no correction is being 
# made for Type I error. 
# What is presented in the matrix above is the p-values for each t-test between the pairs of the levels of your 
# independent variable. Reading this, you can see that there was not a significant difference in price between any of 
# the pairs of apps.

# Computing Post Hocs with Bonferroni Adjustment
# You may be pretty pleased with finding a significant difference in price between app categories. But guess what?
# That difference may not really exist, because by running three t-tests, you may have increased your Type I error.
# So, better to typically stick with some form of correction, like Bonferroni. It is relatively "mild," but gets the job done!
  
pairwise.t.test(apps$Price, apps$Category, p.adjust="bonferroni")

# Gasp! You find that your findings are even less significant. Notice the comparison between food and drink and beauty apps.
# Since a p-value can only be between 0 and 1, that's the end of line; as non-significant as something gets. 
# This has just demonstrated why it's important to always, always, apply a correction to your post hocs!

# Computing Post Hocs When You've Violated the Assumption of Homogeneity of Variance
# There is an easy solution to computing post hocs when you have violated the assumption of homogeneity of variance.
# You'll use the same codes as above, but include the argument pool.sd = FALSE at the end. Like this:
  
pairwise.t.test(apps$Price, apps$Category, p.adjust="bonferroni", pool.sd = FALSE)

# This provides a very similar output, the only difference being that is was calculated with non-pooled standard deviations,
# as noted at the top.
# As you can see, once you've corrected for this assumption, your results have changed and your pairwise comparison between
# both photography and beauty apps is significant.

# Determine Means and Draw Conclusions
# If you had found a significant difference after correction, you would want to then finish interpreting the results and draw some
# conclusions. To do that, you need to examine the means! Again, dplyr nicely comes to the rescue.

appsMeans <- apps %>% group_by(Category) %>% summarize(Mean = mean(Price))

print(appsMeans)

# The post-hoc tests for this data that meets the assumption of homogeneity of variance did not result in any significant 
# differences between apps. Looking at these means, it makes sense that the differences are very small!



  
  






























