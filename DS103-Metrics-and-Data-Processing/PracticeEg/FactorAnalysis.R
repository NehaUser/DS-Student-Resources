# Load Libraries
library("corpcor")
library("GPArotation")
library("psych")
library("IDPmisc")

library(plyr)

library(readr)

# Import Data


financialWB <- read_csv("Documents/GitHub/DS-Student-Resources/DS103-Metrics-and-Data-Processing/PracticeEg/financialWB.csv")
View(financialWB)

# Question Setup
# 
# With the data above, you will be determining how a set of questions from the financial wellbeing survey hang together 
# and whether there are any subscales. To do this, you will perform factor analysis. In factor analysis, there is 
# no x or y variables - you are simply seeing how variables fit together.

# Data Wrangling
# The function you'll use in R for factor analysis does not allow you to specify variables, so you'll need to trim
# your data to only the variables you are interested in looking at to begin with. In order to subset, take a look at
# the data and identify the columns you want to keep. In this case, you want the items that start with FWB.
# 
# They are contained in columns numbered 8-17. With the below code, you will only have those columns in your new dataset
# to use:

financialWB1 <- financialWB[, 8:17]
# 
# Test Assumptions
# Now that you have the columns you'll be examining in the factor analysis, you'll need to test the assumptions for them!
#   You will be looking at sample size and how well the variables relate to each other.

# Sample Size
# Sample size should ideally be 300 or more. Luckily, there are 6,394 rows here, so you have met this assumption!
 
nrow(financialWB1)

# Absence of Multicollinearity
# Next, you will test for the absence of multicollinearity. The first way to do this is with a correlation matrix. 
# You can use the function cor() to do that:

financialWBmatrix <- cor(financialWB1)

View(round(financialWBmatrix, 2)) # The 2 in the code indicates the number of decimal places 


# In it, you want to look at only half the matrix (remember that the top and bottom halves along the diagonal 
# are mirror image of each other). As you go down the columns, starting to look only after the 1.0 on the diagonal, 
# look for any correlations that are higher than .9. This would indicate really high multicollinearity,
# and if there's an item that has a correlation of .9, you will most likely want to remove that item. 
# A quick scan indicates that there is nothing above .9 here and you are good to go.

# Some Relationship between Survey Items
# You will also want to look at the correlation matrix to ensure that correlations aren't too low, 
# since factor analysis requires some relationship between the variables. Look for any variable that
# correlates with more than one variable lower than .3. Again, this doesn't seem to be a problem in the 
# matrix above, so you are good to go!
#   
  
# Bartlett's Test
# To double check your findings from the correlation matrix, you can also run Bartlett's test with this simple line:
#   
  
cortest.bartlett(financialWB1)

# First, you will get a warning in red that R was not square, finding R from data. That can be ignored; 
# it is just acknowledging that you fed in raw data instead of a matrix, which is perfectly fine.
# 
# Next, you will see a Chi-Square value (chisq) and a p value. You want this test to be significant, 
# and if it is, this means that you have suitable correlations (not too high, not too low) to proceed 
# with a factor analysis.

# If the p-value from Bartlett’s Test of Sphericity is lower than our chosen significance level 
# (common choices are 0.10, 0.05, and 0.01), then our dataset is suitable for 
# a data reduction technique.


# Check your Determinants
# If you want further proof that you are good to proceed forward, you can also check the determinants, 
# which is basically another measure of how variables relate to each other.
# You'll do this by using the function det():

det(financialWBmatrix)

# It takes the argument of the correlation matrix you had created a few steps earlier, and produces this output:
  
# 
# If this value is greater than .00001 , then again, you have a sufficient relation between your variables
# to proceed with a factor analysis. With all ways to test - correlation matrix, Bartlett's test,
# and determinants - you are good to go! 


# Factor Analysis in R
# Now that you know your data has met the assumptions for factor analysis, you can hop right into the good stuff!
  
  
# Initial Pass to Determine Approximate Number of Factors
# The first thing you will do is to run a basic principal components analysis (fancy term for factor analysis)
# with as many factors as you have survey items in your factor analysis, and without any rotation. 
# You'll use the function principal(), with the arguments of the trimmed dataset, the argument 
# nfactors= for the number of factors you want to use, and the argument rotate="none" to indicate that
# you are not rotating your factors yet.

pcModel1 <- principal(financialWB1, nfactors = 10, rotate = "none")
pcModel1
# 
# Because you asked for ten factors, R has tried to break down your data into ten factors.
# You see then along the top matrix labeled as PC1, PC2, etc. and you can also see them in the bottom matrix. 
# What you are really looking at here on the first pass is the SS loadings column on the bottom, 
# which contains something called eigenvalues. The larger the eigenvalue, the more likely that the factor is important. 
# Typically there is a cutoff of 1, so if you see a factor with an eigenvalue of > 1,
# chances are it's something real to examine.
# 
# Examine the Scree Plot
# For those of you who are visual, you can also check out the scree plot, accessibly by the command below.
# You are plotting the eigenvalues generated by your model, and the argument type="b" 
# shows both a line and points on the same graph.

plot(pcModel1$values, type="b")

# 
# What you are looking for on this graph is when the plot seems to break or shear off.
# The name "scree plot" comes from the geology world, where scree means falling rocks off a cliff. 
# In this case, you can see that there is quite a jump down between 1 and 2, and another not-quite-so-large
# jump down between 2 and 3. The rest really seem to trail off after that. This info, along with examining
# the eigenvalues, tells us that probably there are two factors. So you can now test that assumption,
# to see if the model fit improves with two factors.
# 
# Second Pass to Test the Suspected Number of Factors
# Now, you'll run similar code again, but this time, you will change nfactors= to 2 instead of 10:

pcModel2 <- principal(financialWB1, nfactors = 2, rotate = "none")


# Examining Residuals to Determine Model Fit
# You don't really need to even examine the output right now, but you will use the new model generated,
# pcModel2, to examine model fit through the residuals. The basic idea behind this test is that the model
# fits your data very well if there is very little difference between the correlation matrix and the 
# loadings generated through your model. The difference between them is known as the residual.
# A general rule of thumb is that you have good model fit if the percentage of large residuals (over .05)
# is less than 50%. In order to make all this easier, you will go through a series of steps. The first line 
# creates your residuals, using the factor.residuals() function. The argument it takes are your correlation matrix
# and the loadings from your most recent factor analysis model.

residuals <- factor.residuals(financialWBmatrix, pcModel2$loadings)
# 
# The second line formats the residuals as a matrix using the function as.matrix(), and keeps only the top half 
# (remember, the top triangle and bottom triangle mirror each other), using the function upper.tri().

residuals <- as.matrix(residuals[upper.tri(residuals)])
# 
# The next line will find only the large residuals values and put them in a new variable named largeResid.
# This uses the abs() function to take the absolute value, and qualifies a large residual as > .05:

largeResid <- abs(residuals) > .05

# Then you can find the number of residuals that are large by using the sum() function:

sum(largeResid)
# 
# And lastly, you can get the percentage of residuals that are large as compared to the total number of rows,
# by using the sum() function on largeResid divided by the number of rows in the residuals you generated,
# using the nrow() function.

sum(largeResid/nrow(residuals))

# When you go through this, you find that the final output is:

# [1] 0.3777778

# Meaning that 37% of residuals are large. This is under 50%, so having only two factors is a pretty good model
# fit for the data.
# 
# Rotate the Factors to Determine Where Each Survey Item Fits
# You will now play around with rotating the factors, to see where each survey item fits. 
# You will mostly likely try multiple rotations, and you may even try them with different numbers of 
# factors as well if you think the results above may point to a few different numbers.

# Oblique Rotation
# You will now run your model a third time, but using the argument rotate="oblimin". 
# Oblimin is the most commonly used type of oblique rotation, and you'll start with it because it's 
# assumed that these survey items are conceptually related to each other. They are, after all, all about 
# financial well-being. Keep the number of factors as two (nfactors=2), because an examination of 
# residuals showed that it was a good fit for the data.

pcModel3 <- principal(financialWB1, nfactors = 2, rotate = "oblimin")
pcModel3


# You now have access to what is called a pattern matrix, and the print outs in the columns
# TC1 and TC2 tell you how well each item fits into that factor. The values can range from 0 to 1,
# and the larger the value, the better the fit. 
# If you want to examine the output all at once, it can be handy to put it into a spreadsheet or print it out 
# and highlight the values that load highly. What is meant by loading highly? Your exact cutoff will determine
# # how your data looks, but generally anything above .3 - .4 loads on that factor ok. Take a look at the excel.
# The first factor has high loadings for items FWB1_3, FWB1_5, FWB1_6, FWB2_1, FWB2_3, and FWB2_4. 
# The second factor has high loadings for items FWB1_1, FWB1_2, FWB1_4, and FWB2_2.
# 
# Luckily this is pretty cut and dry in ths example, but sometimes you will find that things load relatively
# highly on more than one factor and you have to make the best decision you can. There is a lot of 
# subjective judgement in factor analysis.
# 
# When you examine the actual items and what the questions are asking you find that factor 1, TC1,
# is all about the negative side of financial well being - not having enough money or not being
# in control of your finances. The second factor, TC2, looks like it is the opposite -
#   about being good with money management.
# 
# Now that process wasn't too bad with a small number of factors and a small number of survey items,
# but what if you had more? Then it would become a much larger task and a bit of a pain. 
# Happily, the psych package swoops in to save the day and make your life easier! The line of code
# below will print out only the loadings that are higher than .3, and sorts them from largest to smallest.

print.psych(pcModel3, cut = .3, sort=TRUE)

# From this, easily you can see that your suspicions were right, and you basically get the exact same results.

# Orthogonal Rotation
# You can also try this out with a type of orthogonal rotation. Varimax roation is the most common orthogonal
# rotation, so give it a shake. Although it is theoretically less likely that orthogonal rotation will provide 
# the best fit, because it assumes your survey items are not related to each other, it's still not a
# bad thing to try out:

pcModel4 <- principal(financialWB1, nfactors = 2, rotate = "varimax")
print.psych(pcModel4, cut=.3, sort=TRUE)
# 
# When you run the psych function that makes things easier to view, you can see that results 
# are very similar in terms of where items fit on the factors, but that some items now load on both factors, 
# though they still have one dominant factor. For instance, take a look at FWB1_3 below:
# it loads better on RC1, with a value of .76, but also loads onto RC2 with a value of -.31. 
# Obviously, you'd want to keep it on RC2 because it loads better, but there is the possibility of other options.
# The same thing has happened with many of the other items as well.
# 
# If examining the factor loadings doesn't give you information about the model fit for this second rotation, 
# you can go through process of checking the residuals again. In this case, the fact that items load on
# more than one factor is proof enough that the oblique rotation of oblimin worked much better than the
# orthogonal rotation of varimax.

# CALCULATING RELAIABILITY

# Load Libraries
# The only library you will need to calculate reliability in R is psych. 
# This contains the function alpha() which is used for all the things!
  
library("psych")

# Load in Data
# You will use the same data as you did for factor analysis.

#Question Setup
# Really, the main question you are answering here is:
#   
#   Is my survey reliable? Does it measure the same thing every time?
#   You are hoping that the answer will be "yes" to avoid many tears.

# Data Wrangling
# There are two data wrangling tasks you will need to perform. First, you'll need to subset your data.
# You will want one dataframe for each scale you unearthed in your factor analysis.
# You may also need to reverse code your data if you have any items that are "negative." 
# For instance, in this survey, there are items that are the opposite of financial well being - things like
# "Because of my money situation...I will never have the things I want in life." It's important that when you
# look at the reliability of a scale, all the items are facing the same direction (all trending positively
# or all trending negatively). Since you will often have "reversed" items in a survey to try and catch your
# respondents unaware and give away fewer clues as to what you are measuring, you'll just need to do some
# wrangling afterwards to resolve this issue.

# Subsetting your Data
# Your first task will be to make a dataframe for each factor you discovered in factor analysis.
# You found two - one for "good" financial well being, and a second for "bad" financial well being.
# To make it easy, you can subset each of these out of financialWB1 that you used for factor analysis by
# feeding in a vector of column numbers you want to keep for each:
  
goodFWB <- financialWB1[, c(1,2,4,8)]
badFWB <- financialWB1[, c(3,5,6,7,9,10)]

#Remember that keeping the format [, in front means that you are retaining all rows of your data.

# Reverse Coding Items
# Next, you'll reverse code all the items that are "negative." In this case, discerning them is easy -
# they are all on the badFWB scale. The reverse coding process is very similar to any other recoding you've done in R, 
# but it specifies that you are changing the values to be a mirror image of each other. So, if the respondent reported 
# a 1 for the question, it should be changed to a 5, if they reported a 2 it should change to a 4, and so on. 
# Take a look at the code for the rest:
#   
  

financialWB1$FWB1_3r <- NA
financialWB1$FWB1_3r[financialWB1$FWB1_3 == 1] <- 5
financialWB1$FWB1_3r[financialWB1$FWB1_3 == 2] <- 4
financialWB1$FWB1_3r[financialWB1$FWB1_3 == 3] <- 3
financialWB1$FWB1_3r[financialWB1$FWB1_3 == 4] <- 2
financialWB1$FWB1_3r[financialWB1$FWB1_3 == 5] <- 1

financialWB1$FWB1_5r <- NA
financialWB1$FWB1_5r[financialWB1$FWB1_5 == 1] <- 5
financialWB1$FWB1_5r[financialWB1$FWB1_5 == 2] <- 4
financialWB1$FWB1_5r[financialWB1$FWB1_5 == 3] <- 3
financialWB1$FWB1_5r[financialWB1$FWB1_5 == 4] <- 2
financialWB1$FWB1_5r[financialWB1$FWB1_5 == 5] <- 1

financialWB1$FWB1_6r <- NA
financialWB1$FWB1_6r[financialWB1$FWB1_6 == 1] <- 5
financialWB1$FWB1_6r[financialWB1$FWB1_6 == 2] <- 4
financialWB1$FWB1_6r[financialWB1$FWB1_6 == 3] <- 3
financialWB1$FWB1_6r[financialWB1$FWB1_6 == 4] <- 2
financialWB1$FWB1_6r[financialWB1$FWB1_6 == 5] <- 1

financialWB1$FWB2_1r <- NA
financialWB1$FWB2_1r[financialWB1$FWB2_1 == 1] <- 5
financialWB1$FWB2_1r[financialWB1$FWB2_1 == 2] <- 4
financialWB1$FWB2_1r[financialWB1$FWB2_1 == 3] <- 3
financialWB1$FWB2_1r[financialWB1$FWB2_1 == 4] <- 2
financialWB1$FWB2_1r[financialWB1$FWB2_1 == 5] <- 1

financialWB1$FWB2_3r <- NA
financialWB1$FWB2_3r[financialWB1$FWB2_3 == 1] <- 5
financialWB1$FWB2_3r[financialWB1$FWB2_3 == 2] <- 4
financialWB1$FWB2_3r[financialWB1$FWB2_3 == 3] <- 3
financialWB1$FWB2_3r[financialWB1$FWB2_3 == 4] <- 2
financialWB1$FWB2_3r[financialWB1$FWB2_3 == 5] <- 1

financialWB1$FWB2_4r <- NA
financialWB1$FWB2_4r[financialWB1$FWB2_4 == 1] <- 5
financialWB1$FWB2_4r[financialWB1$FWB2_4 == 2] <- 4
financialWB1$FWB2_4r[financialWB1$FWB2_4 == 3] <- 3
financialWB1$FWB2_4r[financialWB1$FWB2_4 == 4] <- 2
financialWB1$FWB2_4r[financialWB1$FWB2_4 == 5] <- 1

# 
# As you can see, you need to do this for every item that is reversed. It can be a little tedious, 
# but once you've got the first one going, it can save time and increase efficiency if you copy and
# paste and then change the item numbers. Luckily, the column names in this dataset are ideally setup for just that!
# 
# Dropping the Old (Non-Recoded) Items
# Once you have completed all your reverse coding, you'll want to drop out the old items that were negative
# and not reverse-coded. You can use the same subsetting algorithm as before, and just keep the original
# positive data and your newly reverse-coded negative data:
  
financialWB2 <- financialWB1[, c(1,2,4,8,11,12,13,14,15,16)]

# And with that, you are now ready to get your reliability on!

# Test Assumptions
# Made you sweat! Guess what? There are no assumptions for testing reliability in R! 
# Breathe a sigh of relief and proceed to the next step!
# 
# Calculating Reliability in R
# Now that you've done all the prep work, running the actual reliability function is blindingly easy.
# Just make use of alpha() and place as the sole argument the data frame that contains your data! 
# You will want to do this for each subscale and for your data as a whole:

alpha(goodFWB)
alpha(badFWB)
alpha(financialWB2)
  
  
#   
# Interpret Output for Inter-Rater Reliability
# The first thing you'll need to look at for inter-rater reliability is Chronbach's alpha, which shows up on 
# your R output as raw_alpha. Lucky for you, you don't actually have to collect the same survey from people twice 
# to get a sense for inter-rater reliability (though it is an option, if you want to be thorough!).
# Chronbach's alpha does something called split-half reliability, which randomly splits the data in half for each
# person every possible way and then finds the correlation between them and takes the average, which is what
# R reports in raw_alpha. Typically, you want a Chronbach's alpha score of approximately .8 to have good reliability,
# however, it is based on the number of items in the scale or subscale, so interpreting it can be a little bit subjective.
# Only have three items in your subscale? Then maybe a Chronbach's alpha score of about .7 is ok. Have 30 items 
# in your scale? Then .8 may not be looking so hot. The hard and fast rule, however,
# is that anything under .7 is probably not good reliability.
# 
# You will notice that the raw_alpha score for goodFWB is alpha = .88, so the scale at first blush has pretty 
# good reliability.

# Increasing your Reliability
# You may be able to increase your scale's reliability by dropping one or more items, because it doesn't play
# nice with the others. This information is found in the Reliability if an item is dropped table in your R output. 
# If the raw_alpha score in that table for any of the items listed in the row is higher than the overall 
# Chronbach's alpha, you saw above, than you may want to try removing that item and see how the factor analysis 
# plays out as well.
# 
# 
# Interpret Output for Inter-Item Reliability
# Determining how nicely each item plays with each other is the realm of inter-item reliability, 
# and this information can be found both in the Item statistics and the Non missing response frequency for 
# each item sections. Under Item statistics, you see first raw.r. This is the correlation of the item with 
# the scale as a whole. But there's one big problem with raw.r: it correlates the item with the scale in its entirety,
# including the item itself. So often correlations are auto-inflated, and you don't really want to use this statistic. 
# The solution is shown in the r.drop column. Here, it has removed the item in question from the scale as a whole, 
# to avoid increasing the correlation value unduly. This r.drop column contains what is called the corrected 
# item-total correlation or sometimes called the item-rest correlation, because it is the correlation of the 
# item with "the rest" of the scale. You are looking for all of these r.drop values to be above .3, 
# and if you find one that isn't, you may want to play around with removing that item, both for reliability
# and validity analysis.
# 
# In the Non missing response frequency table, you will find the percentage of people who gave each response 
# option for each item. The idea here is just to make sure that everyone is not answering all one way for any 
# particular item. It should be relatively evenly distributed, or at the very least, not clumped up! There's a 
# pretty good chance that something is wrong with your question if absolutely everyone is answering the question 
# the same way!
#   
# Interpret Output for the Other 2 Sets of Data
# You've now walked through how to interpret the alpha() results for the subscale goodFWB.
# Without walking through every step, you'll now go through the other two.
# 
# Interpreting the Bad Financial Well Being Subscale
# The overall Chronbach's alpha is .87, which is good and suggests that this scale is reliable.
# Looking at the Reliability if an item is dropped table, it looks like there is no one item that, if-dropped,
# would improve the overall reliability. Inter-item reliability is also good, with corrected-item totals of
# approximately .6 or greater. So the items go together well. And no one item is having respondents all 
# answer the same way, as evidenced by the Non missing response frequency table. Overall, this subscale 
# has good inter-rater and inter-item reliability!

# Interpreting the Financial Well Being Scale as a Whole
# Although some folks think that you can skip this step, it is generally idea to examine the reliability 
# of your scale as a whole, not just look at the reliability of the subscales. Looking at the scale as a
# whole can provide one more great "gut check" on your data. You expect that whether broken up into subgroups or not,
# that the items on your scale should all measure similar things.
# 
# Here are the results of running alpha() on the entirety of the financial well being scale:

# Overall Chronbach's alpha is excellent - a raw_alpha score of .92! Further, the removal of not one item 
# will better that reliability, which is keen. All items seem to correlate well with each other, 
# as the corrected-item totals shown in r.drop are all approximately .6, a moderate correlation. 
# Further, the response frequencies seem to be decently spread out for each item, which also lends 
# reliability to your data.

# Draw Conclusions about Your Scale
# After examining the financial wellbeing scale as a whole and examining its subscales, 
# your conclusion is that this is a very reliable survey! The person who created it should be proud 
# that they are measuring the same thing over and over again!
#   
  
  

                                  
                                  
































