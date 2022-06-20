# Old Faithful eruption times

eruptions.times <- faithful$eruptions
short <- eruptions.times[eruptions.times <= 3] # eruptions less than equal to 3 minutes
long <- eruptions.times[eruptions.times > 3] # eruptions greater than 3 minutes

# How many elements are in the vector short?
length(short)

# How many elements are in the vector long?
length(long)

# Mean and sd of short

mean(short)
sd(short)
# Mean and sd of long
mean(long)
sd(long)
