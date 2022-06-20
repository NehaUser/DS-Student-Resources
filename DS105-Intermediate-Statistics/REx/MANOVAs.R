# Load Libraries
# The MANOVA function comes in the base package of R, so the libraries that you will need to load are all related to assumption
# testing. You will need the following: mvnormtest to test for multivariate normality, and car to test for homogeneity of variance.

library("mvnormtest")
library("car")
library("IDPmisc")

#Load data
library("readr")
kickstarter <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/kickstarter.csv")
View(kickstarter)

# Question Set Up
# You will be answering the following question with this data:
#   
# Does the country the project originated in influence the number of backers and the amount of money pledged?
# To answer this question, the independent variable will be the country the project originated in, country. 
# This is a categorical variable. The two dependent variables will be the number of backers (backers) and the amount pledged (pledged). These variables are both continuous.

# Data Wrangling
# Although no data wrangling is actually required for the MANOVA itself, some wrangling is required to test for assumptions.
# In order to test for multivariate normality, you will need to create a dataset containing only your two dependent variables
# that is in a matrix format, and you will need to ensure that they are numeric. Unfortunately, the test for normality can only
# handle 5,000 records, so you will also need to limit your data to 5,000 rows as well.

# Ensure Variables are Numeric
# And then check the structure of the data to see what format your dependent variables are in.

str(kickstarter$pledged)
str(kickstarter$backers)

# Both of them are currently set up as factors! Best convert them using the as.numeric() function.

kickstarter$pledged <- as.numeric(kickstarter$pledged)
kickstarter$backers <- as.numeric(kickstarter$backers)

 
# Subsetting
# Next, keep only your two dependent variabes, pledged and backers.

keeps <- c("pledged", "backers")
kickstarter1 <- kickstarter[keeps]

# Then limit the number of rows:
  
kickstarter2 <- kickstarter1[1:5000,]
# 
# Format as a Matrix
# Lastly, format the data as a matrix:
  
kickstarter3 <- as.matrix(kickstarter2)

#You are now ready to perform the assumptions test for multivariate normality on kickstarter3.

# Test Assumptions
# With the data wrangling out of the way, it is now time to test assumptions!
#   
# Sample Size
# The first assumption of MANOVAs is sample size. The rule of thumb is that you must have at least 20 cases per independent variable,
# and that there must be more cases then dependent variables in every cell. Meaning that there must be more than 2 cases for each 
# country. Happily, both of these are fulfilled with a dataset of 323,746!

# 
# Multivariate Normality
# To test for multivariate normality, you will first need to drop any missing values using the code below:
  
kickstarter4 <- na.omit(kickstarter3)
View(kickstarter4)

# Now you can use the dataset you wrangled, kickstarter4, in the Wilks-Shapiro test. You can do that with the function
# mshapiro.test() pulled from the mvnormtest library:
  
mshapiro.test(t(kickstarter4))

# You have violated the assumption of multivariate normality if the p value is significant at p < .05, so unfortunately, 
# these data do not meet the assumption for MANOVAs. However, for learning purposes, you will continue.

# Homogeneity of Variance
# You can use Levene's Test from the car library to test for homogeneity of variance on both of your dependent variables:

leveneTest(kickstarter$pledged, kickstarter$country, data=kickstarter)

# Don't forget to test for backers as well!

leveneTest(kickstarter$backers, kickstarter$country, data=kickstarter)
# 
# Unfortunately, neither variable met the assumption of homogeneity of variance, since they were both significant at p < .05. 
# You have violated the assumption of homogeneity of variance, but you will proceed for now for learning purposes.
# 
# Absence of Multicollinearity
# Typically, multicollinearity can be assessed simply by running correlations of your dependent variables with each other. 
# A general rule of thumb is that anything above approximately .7 for correlation (i.e. a strong correlation) indicates the 
# presence of multicollinearity. Check out the correlation between pledged and backers with a simple cor.test() function:

cor.test(kickstarter$pledged, kickstarter$backers, method="pearson", use="complete.obs")

# With a correlation of r = .73, the absence of multicollinearity is also failed.

# The Analysis
# 
# You will use the function manova to run a MANOVA. Go figure!
  
MANOVA <- manova(cbind(pledged, backers) ~ country, data = kickstarter)
summary(MANOVA)

# In this code, you are binding your two dependent variables together with the function cbind(), so they can be examined as one. 
# Then you are able to specify your independent variable, country, like any other ANOVA. Here are the results when you call summary:

# You have run your first MANOVA. Looks like it was significant, too - there is a significant difference in backers and the
# funds they have pledged by country.


# But which dependent variable you ask? Well, that's where the post-hocs come in.
# 
# ANOVAs as Post Hocs
# The initial post-hoc for a MANOVA is, in fact, an ANOVA. Luckily, there is code set aside to do this as a post-hoc in R, 
# so that you don't have to create your own ANOVA models. Check out the summary.aov() function in action:
  
summary.aov(MANOVA, test = "wilks") 

# Simply feed in the name of your MANOVA model. This function would work without the additional argument of test=, but 
# like post-hocs for ANOVAs, it is nice to use a correction for Type I error since you are doing so many multiple comparisons. 
# In this case, you can use the "wilks correction, specified above.

# It provides you with the appropriate output for both dependent variables with one click. As you can see here, 
# there is a significant difference in both the amount of funds pledged and the number of backers by country.









  

















