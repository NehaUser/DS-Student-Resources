#Create three functions that each accept three parameters.

#The first function should be named sum_function and should return the sum 
# of all numbers (add them all together)
#The second function should be named product_function and should return 
# the product of all numbers (multiply them all together)
#The third function should be named average_function and should return the 
# average of all numbers

#1rst function
def sum_function(x,y,z):
    """Calculate sum of three numbers"""
    return (x+y+z)

print(sum_function(4,5,6))

#2nd function

def product_function(x,y,z):
    """Calculate product of three numbers"""
    return (x*y*z)

print(product_function(4,5,6))

#3rd function

def average_function(x,y,z):
    """Calculate average of three numbers"""
    return (x+y+z)/3

print(average_function(4,5,6))

# PART 2
#Create three lambda functions that do the same thing 
# as the functions in step 1. Assign each lambda function the following variables:
#add_numbers
#multiply_numbers
#average_numbers
#Print and call the above functions

# 1st

add_numbers = lambda x,y,z:x+y+z
print(add_numbers(4,5,6))

multiply_numbers = lambda x,y,z:x*y*z
print(multiply_numbers(4,5,6))

average_numbers = lambda x,y,z: (x+y+z)/3
print(average_numbers(4,5,6))

# PART 3

list_one = [4, 6, 88, 24] 
list_two = [17, 34, 9, 5]
list_three = [63, 20, 98, 4]

average_maker = lambda x,y,z : (x+y+z)/3
map_results = map(average_maker, list_one, list_two, list_three)
print(list(map_results))