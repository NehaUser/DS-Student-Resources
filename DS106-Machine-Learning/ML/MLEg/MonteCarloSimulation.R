# Monte carlo simulation is a way to simulate the results of something by re-sampling the data you already have. 
# It's based off a little bit of data, but to get the best results, you may want a lot more rows than you have. 
# So use monte carlo simulation to expand things.
# 
# The function to do this is rbeta() function, which samples from the probability density function for a binomial 
# distribution. Remember that the binomial distribution is one in which you only have two outcomes. 
# For instance, a) did eat the whole cupcake or b) did not eat the whole cupcake.
# 
# There are two components of the beta distribution that you'll need to define as variables, in addition to the number
# of trials you intend to use:
# 
# alpha: How many times an event happens that you care about
# beta: How many times an event happens that you don't care about
# First, assign some variables in R. You'll need a variable to hold onto the priors and the number of 
# trials you want to extend this to. Although you can choose any number of trials you want, here, you'll use 10,000.
# 


trials <-10000

# alpha and beta are based on the priors you created. Since you thought that about 80% of people would finish
# eating a cupcake, 8 becomes your alpha. beta, the event you don't care about, or not finishing a cupcake, would be 2.
# This is because of the "not" rule of probability. You've only got two potential options - people either will finish
# eating their cupcake or they won't - so the probability of not eating is one minus the probability of eating. 
# Since you are doing this out of 10, that means 10-8 = 2, and 2 becomes your beta.

alpha <- 8
beta <- 2
# 
# Now, you are all set up to use rbeta() at last! You'll use it for both frosting types.
# Remember that A was your old, tried-and-true cream cheese frosting recipe, and B was the new one. 
# The variable samplesA calculates the probability of the data you collected happening. 
# The first argument it uses is the number of trials you want to simulate this over, and the second is the number
# of people who ate all of the cupcake with frosting A plus the prior of alpha. The third argument is the number of 
# people who did not eat frosting A plus the prior of beta. You are basically comparing your guess with reality here.
# 
# You will follow the same flow for samplesB.

samplesA <- rbeta(trials, 95+alpha, 22 + beta)
samplesB <- rbeta(trials, 73+alpha, 46 + beta)

# Lastly, you can figure out if B is better by seeing the percentage of the trials in which B came back greater than A. 
# You are basically just adding up with the sum() function every time that samplesB was greater than samplesA out 
# of the total number of trials.

Bsuperior <- sum(samplesB > samplesA) / trials
# 
# The end result is 0. Wow! Your initial suspicions were right! There is definitely a clear case to stick with
# your original frosting, because in no situations out of 10,000 did people ever eat the whole cupcake more times
# with frosting B, your new recipe!
  
  













