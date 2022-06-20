# A retailer wants to create a simulation to predict the profit on the sales of a certain tool she carries. 
# She knows the profit is a function of several factors, for which she has historical data:
# 
# Units Sold: Normal distribution, with a mean of 26 units and a standard deviation of 5.7 units.
# 
# Price: Discrete distribution. 55% of the time the price is 38 dollars, 30% of the time the price is 41.50 dollars, 
# and 15% of the time is 36.25 dollars.
# 
# Cost: Uniform distribution, with a max of 33.72 dollars and a min of 26.88 dollars.
# 
# Resource Factor: Normal distribution, with a mean of 3 and a standard deviation of 1.2.
# 
# The function for profit is as follows:
#   
#   Profit = (RF * (Units sold) * (Price)) - ((0.2) * (RF) * (Units sold) * (Cost)) + $320
# 
# Create a simulation that has 100 rows of monthly profits. Once you have completed this simulation exercise, 
# prepare a report stating what you did, what you learned, and your results. 
# You have the option to complete your simulation in either R, Python or Excel. Then submit it for grading.
# 


# For Units sold, we need normal distribution.
# rnorm(n, mean, sd)

UnitsSold <- rnorm(100, 26, 5.7)
print(UnitsSold)

# For Price we need Discrete distribution.

VectorDummy <- c(runif(100))          # Generating avector of 100 numbers between 0 and 1
new_value <- 0                        # Creating new value based on the condition
my_vec_price <- c()
for(i in VectorDummy) { 
  if(i<.15){
    new_value <- 36.25
  } else if(i<.45){
    new_value <- 41.5
  } else if (i < 1){
    new_value <- 38
  } 
  
  my_vec_price <- c(my_vec_price, new_value)    # Appending new value to the Price vector
}

print(my_vec_price)


# For Cost: Uniform distribution, with a max of 33.72 dollars and a min of 26.88 dollars.

Cost <- runif(100,26.88,33.72)
print(Cost)

# For Resource Factor: Normal distribution, with a mean of 3 and a standard deviation of 1.2.

Res_Factor <- rnorm(100, 3, 1.2)
print(Res_Factor)

# Calculating the Profit Using the given formula

Profit <- (Res_Factor * UnitsSold * my_vec_price) - (0.2 * Res_Factor * UnitsSold * Cost) + 320
print(Profit)



# Plot the bar chart 
barplot(Profit,ylab="Profit",col="blue",
        main="Profit chart")

