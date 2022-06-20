import sys
import keyword
import math
import random

print("Python version : " + sys.version)

print("Interpreter location : " + sys.executable)


print(keyword.iskeyword('def')) # to checvk if "def" is a keyword

print("Nearest up integer for 4.5 is: " , math.ceil(4.5))
print("Nearest down integer for 4.5 is: " , math.floor(4.5))

# compute 5^10 using `pow`
print("5 to the power of 10 = ", math.pow(5, 10))

print("Square root of 90 is" , math.sqrt(90))

# random.random() - Produces a single floating-point number between 0 and 1.0.
print("A random float between 0 - 1.0: ", random.random())

numbers = random.sample(range(1, 49), 7) 
# The first argument given is the range from 1 to 49. The second argument is how many numbers you
#  want to be returned from that range.
print(numbers)

import numpy as np

x = np.array([1,2,3])
print(x)

x = np.array([[1, 2, 3], [4, 5, 6]])
print(x)

# Above, the number of dimensions was determined by the input you provided. 
# An ndarray is mutable, so you can add values to it. 
# If you need to start with an empty or initial array, but you know how many dimensions will be needed, 
# you can specify it at creation. You simply need to add another parameter to the initializer of the array, 
# assigning ndmin to the minimum number of dimensions:

x= np.array([12,15,13], ndmin= 2)
print(x)




