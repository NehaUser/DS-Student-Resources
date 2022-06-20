# One Proportion Testing
# One proportion testing is used when you want to see whether the proportion of two things are similar.

# As an example, you have an Easter basket full of candy, which is filled with both jellybeans and chocolate eggs. 
# A random sample of 43 pieces of candy are taken from the Easter basket. There are 15 jellybeans and 28 chocolate 
# eggs in the sample. You can use the function prop.test() to determine the probability that there are the same number 
# of jellybeans as there are chocolates, meaning the proportion of jelly beans and chocolate eggs is equal to 0.5. 
# To do this, you will use the argument x= to put in the number of jellybeans, and then the argument n= to specify the sample size. 
# You can also use the argument alternative= to specify whether you want a one-tailed or two-tailed test.
# You will use the value “two.sided” for a two-tailed test since we want to determine if jellybeans and chocolates are equal 
# or not equal. If you want to do a one-tailed test, you can use the values “greater” or “less”.

prop.test(x = 15, n = 43, p = 0.5, alternative = "two.sided", correct = FALSE)
# 
# The p value is .03, which means that the proportion of jelly beans to chocolate eggs is not equal, since it is
# different than .5 (half). If you're wondering what the proportion of jelly beans is to the whole, 
# it is found in the bottom on the sample estimates:section: .34. This means that your Easter basket contains
# about 35% jelly beans and about 65% chocolate eggs. Hopefully you like chocolate!





