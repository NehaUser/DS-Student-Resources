# PART 1
list_of_names = ["Kurt", "David", "Katherine"]
for name in list_of_names:
    print("Where is " + name + " today ?")

# PART 2
my_favorite_cars = ["Merc", "Camry", "BMW"]
my_favorite_flowers = ["Daisy", "Tulip", "Rose", "Sunflower"]
my_favorite_animals = ["Dog", "Cat", "Rabbit", "Tiger"]
my_favorite_things = my_favorite_cars + my_favorite_flowers + my_favorite_animals
my_fav_list = []
for my_fav in my_favorite_things:
    if len(my_fav) % 2 == 0:
        print(my_fav)
        my_fav_list.append(my_fav)

print("My favorite items are : " + str(my_fav_list))

# PART 3
number_range = list(range(1,21))
print(number_range)
for num in number_range:
    if num % 3 == 0 and num % 5 == 0:
        print("ZipZap")
    elif num % 3 == 0 and num % 5 != 0:
        print("Zip")
    elif num % 3 != 0 and num % 5 == 0:
        print("Zap")
    else:
        print(num)


x = 0

while x <= 5:
    if x < 2:
        print("less than 2")
    if x > 3:
        print("greater than 3")
    elif x == 5:
        print("5")
    
    x += 1



