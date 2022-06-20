
#Part 1
#Create two dictionaries to represent information about two pets. 
# Each dictionary should contain the following information (different for each pet):

#Pet's Name (This should be the name of your dictionary)
#Type of Pet
#Color
#Nickname
#Owner's Name

Coco = {
    'Type' : 'Golden Retriever',
    'Color' : 'Golden White',
    'NickName' : 'Coke',
    'Owner' : 'Aari'
}
print(Coco)

Rusty = {
    'Type' : 'Airdale Terrier',
    'Color' : 'Rust Brown',
    'NickName' : 'Rustay',
    'Owner' : 'Ira'
}
print(Rusty)

# Iterate over each dictionary, printing each key-value pair on one line. 

# Print key value pair for Coco 
for key, value in Coco.items():
    print(key, ": ", value)

# Print key value pair for Rusty 
for key, value in Rusty.items():
    print(key, ": ", value)


# PART 2
# Creating dictionaries
england = {'Capital': 'London'}
france = {'Capital': 'Paris'}
belgium = {'Capital': 'Brussels'}

#Given the above dictionaries, add the following information to each dictionary:
#Population
#The population of England is 53.01 million
#The population of France is 66.9 million
#The population of Belgium is 11.35 million
#Interesting Fact
#Top Language Spoken by Locals

england['Population'] = '53.01 million'
england['Interesting Fact'] = 'England is mostly flat'
england['Top Local Language'] = 'English'
print(england)

france['Population'] = '66.9 million'
france['Interesting Fact'] = 'France is the largest country in the EU and sometimes called the hexagon'
france['Top Local Language'] = 'French'
print(france)

belgium['Population'] = '11.35 million'
belgium['Interesting Fact'] = 'There is no Belgian Language'
belgium['Top Local Language'] = 'Dutch'
print(belgium)

# Once you have added the necessary information into the dictionaries, 
# loop through each one and print out all key-value pairs.

# Key-Value Pair for England
for key, value in england.items():
    print(key, ": ", value)

# Key-Value Pair for france
for key, value in france.items():
    print(key, ": ", value)

# Key-Value Pair for Belgium
for key, value in belgium.items():
    print(key, ": ", value)

# PART 3

#Create a dictionary for a pizza order

pizza_order = {
    'Customer Name' : 'Jason',
    'Pizza Size' : 'Medium',
    'Crust Type' : 'Thin Crust',
    'Toppings' :{
        'Top1' : 'Onion',
        'Top2' : 'Pepper',
        'Top3' : 'Jalapeno',
        'Top4' : 'Pineapple',
        'Top5' : 'Extra Cheese'
    }
}

#Next, print out the customer's order:
#Thank them for their order using their name
#Print out what they're ordering
#Print out the list of toppings (minimum 3)

customer_order = str.format("Thank you for your order {}.\nYou are ordering {}, {} pizza with the following toppings: {}, {}, {}.",
pizza_order.get('Customer Name'), pizza_order.get('Pizza Size'),pizza_order.get('Crust Type'), 
pizza_order['Toppings'].get('Top1'), pizza_order['Toppings'].get('Top3'), pizza_order['Toppings'].get('Top5'))

print(customer_order)