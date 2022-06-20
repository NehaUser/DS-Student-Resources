# PART 1
# Create a program that will concatenate string variables together to form your birthday.
# 1. Create three variables named day, month and year
# 2. Concatenate each of these variables to create your full birthday.

str_day = "1st"
str_month = "January"
str_year = "2000"

# 3. Assign the concatenation to a fourth variable named my_birthday.
# 4. Finally, print the variable my_birthday to see if you have the format identical to the one in the example below:
# For example, if your birthday is on November 11th of 1991, then the format/output should be November 11, 1991

my_birthday = str.format("My birthday is on {} {}, {}", str_month, str_day, str_year)
print(my_birthday)

# PART 2

# Concatenate the variables first, second, third, and fourth and set this concatenation to the variable final:
# Print the final variable, but all words should be uppercase.

first = "happy"
second = "birthday"
third = "to"
fourth = "you"

final = first + " " + second + " " + third + " " + fourth
print(str.upper(final))

# PART 3
# Finally, add code to your program that determines if the given age allows the attendee to see the movie, 
# printing out a specific message based on the age. There should be four possible outputs:
# If under the age of 10, print Not permitted
# If under the age of 15, print Permitted with a parent
# If under the age of 18, print Permitted with anyone over 18
# If 18 or over, print Permitted to attend alone

int_age = 15
if int_age < 10:
    print("Not Permitted")
elif int_age < 15:
    print("Permitted with a Parent")
elif int_age < 18:
    print("Permitted with anyone over 18")
elif int_age >= 18:
    print("Permitted to attend alone")


