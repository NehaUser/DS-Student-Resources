# We will be determining which type of mold-removal solution works better:
# just bleaching objects, or bleaching them and scrubbing them down thoroughly out of 10,000 trials. 
# Based on the priors you created, the mold-removal solutions have a 90% chance of working.

# No. of trials 
trials <-10000


# alpha and beta are based on the priors we created. Since we thought that 
# old-removal solutions have a 90% chance of working,  9 becomes our alpha.
# beta, the event we don't care about, or not chance of working, would be 1. (10 - 1)


alpha <- 9
beta <- 1

# We'll use rbeta() for both mold-removal solution types.
# A is just bleaching objects, and B is bleaching them and scrubbing them down thoroughly. 
# The variable samplesA calculates the probability of the data we collected happening. 
# The first argument it uses is the number of trials we want to simulate this over, and the second is the number
# mold-removing solution with just bleaching them plus the prior of alpha. The third argument is the number of 
# mold-removing solution with bleaching and scrubbing them down thoroughly plus the prior of beta. 

# We will follow the same flow for samplesB.

samplesA <- rbeta(trials, 27 +alpha, 39 + beta)
samplesB <- rbeta(trials, 10 +alpha, 45 + beta)

# Lastly, we can figure out if B is better by seeing the percentage of the trials in which B came back greater than A. 
# we are basically just adding up with the sum() function every time that samplesB was greater than samplesA out 
# of the total number of trials.

Bsuperior <- sum(samplesB > samplesA) / trials
print(Bsuperior)

# Bsuperior = .01

# This shows that 99% of the times the Bleaching method alone is effecient for Mold-Removal.





