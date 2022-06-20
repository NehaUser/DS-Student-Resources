#Creating a list
from audioop import reverse
from tkinter import N


my_var = "Hello, How are you?"
lst_firstlist = ["ABCDE", 1, 2.54, my_var]
print(lst_firstlist)

our_world = ['Earth', ['United States', 'Canada', 'Mexico'], [1, 2, 3]]
print(our_world)

my_tuple = ('doctor', 'nurse', 'PA')
print(my_tuple)

#tuple with one element
one_item_tuple = ('just me and still a comma',)
print(one_item_tuple)

# len to get the no. of items ina list or tuple
ls_array = ["1",3,"4",8,"9"]
print(len(ls_array))

# print the last item of the list
colors_list = ['red', 'green', 'blue', 'yellow']
print(colors_list[-1])

# print the last item of the tuple
numbers_tuple = (22, 33, 44, 55)
print(numbers_tuple[3])

# the starting list
contacts = ['1', 'Bob', 'Mary', 'Steven']
if contacts[0] == "Sally":
    contacts[1] = "Bob"
else:
    contacts[0] = "Tob"
print(contacts)

my_string = "Hello there Bob"

# splits string into list using space as the delimiter/separator
my_string_items = my_string.split()
print(my_string_items)

# but we forgot Sally!
# add 'and' and 'Sally' to the list
my_string_items.append("and")
my_string_items.append("Sally")

print(my_string_items)

#Inserting an item into a list at a specifi position

my_num_list = [1,2,3,5,7]
my_num_list.insert(3, 4)
my_num_list.insert(5,6)
my_num_list.insert(len(my_num_list),8)

#my_num_list.append(8)
print(my_num_list)

colors = ['green', 'white', 'green', 'yellw', 'yellw', 'white']
colors[3] = "yellow"
colors[4] = "yellow"
del colors[1]
colors.remove("white")
colors.append("purple")
print(colors)

rng_nums = range(12,1,-1)
print(list(rng_nums))


ls_nums = [19, 20, 45, 1, 9]
x_1 = ls_nums.sort()
print(x_1)
print(ls_nums.sort(reverse=True))

ls_nums = [19, 20, 45, 1, 9]
ls_nums.sort()
x_1 = ls_nums
print(x_1)
#Above code will work 
#OR
ls_nums = [19, 20, 45, 1, 9]
x_1 = ls_nums.sorted()
print(x_1)
#OR
ls_nums = [19, 20, 45, 1, 9]
ls_nums.sort(reverse=True)
x_1 = ls_nums
print(x_1) #Will work

#print(ls_nums.sort(reverse=True))
#.sort() is a method that only list objects inherit from 
# their parent class. sorted() is a function for sorting any 
# interable, including list. The former mutates its context list 
# in-place and returns None, while the latter returns a copy of the 
# argument object, sorted. Both take modifiers such as reverse and 
# key, etc.


numbers = [2, 6, 3, 9, 1, 10]

print("This is the original set of numbers: ")
print(numbers)

print("This is the sorted set of numbers: ")
print(sorted(numbers))

print("This is the original set of numbers again: ")
print(numbers)

all_numbers = [2, 6, 3, 9, 1, 10, 11, 41,10, 87, 9, 22]
even_num = []
odd_num = []
for num in all_numbers:
    if num % 2 == 0:
        even_num.append(num)
    else:
        odd_num.append(num)
print(even_num)
print(odd_num)

#1
colors = ['green', 'white', 'green', 'yellw', 'yellw', 'white', 'yellw']
n_index = 0
while n_index < len(colors):
    if colors[n_index] == "yellw":
        del colors[n_index]
        n_index -= 1
    n_index += 1
print(colors)

#2
colors = ['green', 'white', 'green', 'yellw', 'yellw', 'white', 'yellw']
n_index = 0
for color in colors:
    #print(color + " " + str(n_index))
    if color == "yellw":
        colors[n_index] = "yellow"
        colors.append("Black")
    n_index += 1
print(colors)   
#print(colors)

numbers = [10, 25, 50]
doubled_numbers = []
for num in numbers:
  dbl_num = num * 2
  doubled_numbers.append(dbl_num)
print(doubled_numbers)

#
everyone = ['Sally', 'Billy', 'Mary', 'Bob']
looking_for = 'Mary'

for person in everyone:
    if person == looking_for:
        break
    print("Not Found " + looking_for + "!")

print("Found " + looking_for + "! ")