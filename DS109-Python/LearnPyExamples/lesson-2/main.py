from dataclasses import replace


my_message = "Hello"

my_other_message = "how are you?"

# concatenate the above variables with a comma in between
my_final_message = my_message + ", " + my_other_message + "\t I am good !!"

print(my_final_message)

s_Day = "Monday"
s_Month = "February"
s_Year = "2022"
s_Date = 7

print("Today is : \t" + s_Day + " the " + s_Month + str(s_Date) + s_Year)

#string formatting

my_msg = str.format("Today is {} {} ,{} !!", s_Month , s_Date, s_Year)
print(my_msg)

x = my_msg.lower()
print(x)

y = x.replace("today is", "Yesterday was")
print(y)

my_msg = "Hello , This is America !! "
print(my_msg.split(","))


print(-10 // 2)

my_name = "Sally"
your_name = "Billy"
some_name = "Sally"

print(my_name == your_name)
print(my_name != your_name)
print(some_name == my_name)

print("---")

my_name = "Joe"   # uppercase j
some_name = "joe" # lowercase j

print(my_name == some_name)
print(my_name.upper() == some_name.upper())


print("Can he watch the movie ? : ", p.replace("False", "No"))

person_age = 20
is_old_enough = person_age >= 18

must_leave = not is_old_enough
print(must_leave)

#Consider an example where someone can watch a movie if:
#they are at least 18 years of age, and they have at least $15
#OR, they are a friend and have at least $5
#they must NOT have any food, regardless of the above

int_age = 20
fl_money = 20

hav_friend = False

hav_food = True

can_watch = hav_food and ((int_age >= 18 and fl_money >= 15) or (hav_friend and fl_money >= 5)) 
p = str(can_watch).replace("False" , "No")
p = p.replace("True" , "Yes")

print("Can he watch movie ? ", p)

if int_age >= 30 :
    print("\t Yay")
    print("\t I can watch the movie !!")
elif int_age == 20 :
    print("\t Yes I am 20 ")
else : 
    print("Oh no I'll have to wait !! ")




