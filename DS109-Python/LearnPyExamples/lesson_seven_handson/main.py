#PART 1

import datetime
todays_date = datetime.datetime.now()
print(todays_date)
current_time = datetime.datetime.now().time()
print(current_time)


#PART 2

poem_string = "Tiny little secrets \n"
poem_string += " Get buried in the dirt,\n"
poem_string += " And if they were dug up,\n"
poem_string += " Someone would probably get hurt."

#Create and open a new file object named poem.txt in write mode.
#This variable name should be poem_file

with open("poem.txt", "w") as poem_file:
    poem_file.write(poem_string)
    print('\nFile Now Closed?:', poem_file.closed)
    poem_file.close()

# Re-open the poem.txt file in read mode.
#This variable name should be poem_file
#Read the contents of the file and print to the console.
#Close the file once again.
with open("poem.txt", "r") as poem_file:
    print(poem_file.read())
    poem_file.close()
    print('\nFile Now Closed?:', poem_file.closed)




