# Load Libraries

library("mvnormtest")
library("car")
library("IDPmisc")
library("readr")

#Load data

heartAttacks <- read_csv("Documents/GitHub/DS-Student-Resources/DS105-Intermediate-Statistics/REx/heartAttacks.csv")
View(heartAttacks)

# Question Set Up
# WE will be answering the following question with this data:
#  
# How does gender (sex) influence some of the heart attack predictors like resting blood pressure (trestbps) and cholesterol(chol)?

# To answer this question, the independent variable will be the gender, (sex). 
# This is a categorical variable. The two dependent variables will be resting blood pressure (trestbps) and cholesterol(chol).
# These variables are both continuous.

# Data Wrangling
# Although no data wrangling is actually required for the MANOVA itself, some wrangling is required to test for assumptions.
# In order to test for multivariate normality, we will need to create a dataset containing only your two dependent variables
# that is in a matrix format, and we will need to ensure that they are numeric. 
# will also need to limit our data to 5,000 rows as well.

# Ensure Variables are Numeric

str(heartAttacks$trestbps)
str(heartAttacks$chol)

# Both of them are currently numeric! 
 
# Subsetting

# Next, keep only the two dependent variabes, trestbps and chol.

keeps <- c("trestbps", "chol")
heartAttacks1 <- heartAttacks[keeps]

# Then limit the number of rows:
  
# We have 303 rows, so this step isn't needed.


# Format as a Matrix
# Lastly, format the data as a matrix:
  
heartAttacks2 <- as.matrix(heartAttacks1)

#We are now ready to perform the assumptions test for multivariate normality on heartAttacks2.

# Test Assumptions

# Sample Size

# The first assumption of MANOVAs is sample size. The rule of thumb is that you must have at least 20 cases per independent variable,
# and that there must be more cases than dependent variables in every cell. Meaning that there must be more than 2 cases for each 
# sex. Both of these are fulfilled with a dataset of 303!

# Multivariate Normality

# To test for multivariate normality, we will first need to drop any missing values using the code below:
  
heartAttacks3 <- na.omit(heartAttacks2)
View(heartAttacks2)

# Now we can use the dataset in the Wilks-Shapiro test. 

mshapiro.test(t(heartAttacks3))

# We have violated the assumption of multivariate normality since the p value is significant at p < .05 ,(3.93e-09).
# So unfortunately, these data do not meet the assumption for MANOVAs. 

# Homogeneity of Variance

# We can use Levene's Test from the car library to test for homogeneity of variance on both of our dependent variables:

# Test for trestbps : 

leveneTest(heartAttacks$trestbps, heartAttacks$sex, data=heartAttacks)

# At p- val = .245, trestbps met the assumption of homogeneity of variance. 

# Test for chol : 

leveneTest(heartAttacks$chol, heartAttacks$sex, data=heartAttacks)
 
# Unfortunately, chol variable didn't meet the assumption of homogeneity of variance, at p< .05 (.0008 in this case).

# Absence of Multicollinearity

# Checking out the correlation between trestbps and chol with a simple cor.test() function:

cor.test(heartAttacks$trestbps, heartAttacks$chol, method="pearson", use="complete.obs")

# With a correlation of r = .123, we have an absence of multicollinearity.

# The Analysis

# We will use the function manova to run a MANOVA.
  
MANOVA <- manova(cbind(trestbps, chol) ~ sex, data = heartAttacks)
summary(MANOVA)

# Looks like it is significant at p-val = .002 - which means, there is a significant difference in resting blood pressure and the
# cholestrol level on what sex it's tested.

# ANOVAs as Post Hocs

summary.aov(MANOVA, test = "wilks") 

# As we can see here, 
# there is a significant difference in the amount of cholestrol by sex. (p = .0005)
# there is not a significant difference in resting blood pressure by sex. (p = .3247)

#### ------------------CONCLUSION ------------------- #### 

# The gender significantly influences the heart attack predictor of Cholestrol level; 
# while it doesn't play much influence on the heart attack predictor of Resting Blood Pressure. 

### -------------------------------------------------### 








  

















