min= 5
max = 10
n =10


runif(n,min,max)
# 
# where n is the quantity of numbers to be generated, min is the minimum value,
# and max is the maximum value. The min and max arguments default to 0 and 1, 
# so if you just want a uniform random variable between 0 and 1 you can omit the other two arguments.

# In R, there are several functions that will generate random normally distributed variables. 
# One simple function is rnorm(), which has the arguments of sample size, mean, and standard deviation. 

# rnorm(n, mean, sd)

x = rnorm(20, 35, 7)
y = rnorm(20, 30, 8)
print(x)
print(y)

z = x *y 
print(z)









