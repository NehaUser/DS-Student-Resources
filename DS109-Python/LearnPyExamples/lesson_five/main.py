# Learning functions
#When defining a function, the first thing you need is the appropriate Python keyword: def. 
# This keyword tells the Python interpreter that what follows is a function.
from audioop import avg


def greeting():
    """This function prints a greeting"""
    print("Hello!")

greeting()

#The first line of code of the function is called a docstring eg above:     """This function prints a greeting"""

def addition(x, y =3):
    """Additing two numbers"""
    print("Sum of ", x , "and ", y , " is ", x+y)

addition(1,2)
addition(3)

def addition(step_size=3,value=6):
    """Additing two numbers"""
    print("Sum of ", value , "and ", step_size , " is ", value + step_size)

addition()
addition(7)

# REturning data through functions
sum_num = sum(10,17)
print ("The sum is : ", sum_num)
def sum(x, y):
    """ Addition of numbers"""
    return x + y

def greeting():
    """This function prints a greeting"""
    print("Hello!")
    return 5

print(greeting())

# The user variable is in global scope
user = "Andrew Jones"

def the_user():
    """Return the value of global variable user"""
    # The global variable user is returned
    user = "Local Variable"
    return user

print(the_user())
print("The global variable" , user)

# create lambda function and assign to variable `my_lambda`
my_lambda = lambda x, y : x + y

# print the results of calling the lambda function
print(my_lambda(4, 5))

# return true false using lambda
var_lambda = lambda x : x<6
print(var_lambda(3))


# Use lambda, map and list functions
lst_num = [2,4,6,9]

lambda_square = lambda x:x*x
mapped_var = map(lambda_square, lst_num)
output_lst = list(mapped_var)

print(output_lst)

# second example 

# declare two lists of integers
list_a = [1, 2, 3, 4, 5]
list_b = [11, 12, 13, 14, 15]

# call `map` with a lambda function that sums two numbers
# the first number comes from `list_a`, the second comes from `list_b`
map_results = map(lambda val_a, val_b: val_a + val_b, list_a, list_b)

# print results (converting map result to list within print statement)
print(list(map_results))


#######

# declare two lists of integers
list_a = [1, 2, 3, 4, 5]
list_b = [11, 12, 13, 14, 15]


lmbda_f = lambda val_a, val_b: val_a + val_b
map_results = map(lmbda_f, list_a, list_b)

# print results (converting map result to list within print statement)
print(list(map_results))
 
 # filter() function

lst_num = [1,2,3,4,5,6,7,8,10]

is_true = lambda x : x%2 == 0
fil_lst = filter(is_true, lst_num)
results_lst = list(fil_lst)
print(results_lst)

# Activity
numbers = [[1,2,3],[4,5,6]]
av_num = []
for x in numbers:
    lst_avg = sum(x)/len(x)
    av_num.append(lst_avg)
print(av_num) 


numbers = [[1,2,3],[4,5,6]]

fn_average = lambda x:sum(x)/len(x)
map_avg = map(fn_average,numbers)


averages = list(map_avg)
print(averages)

list_a = [4, 6, 8, 9, 10]
list_b = [3, 3, 1, 11, 15]
lmb_prod = lambda a,b:a*b
products = map(lmb_prod,list_a,list_b)

print(list(products))