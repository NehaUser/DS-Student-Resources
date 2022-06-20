# Learning Dictionaries
# To make an empty dictionary
dict_add = {}
dict_personal = {'Name':'John', 'Age' : 20, 'Occupation' : 'Doctor'}
print(dict_personal)

# dict() function
dict_add = dict(Name ='John', Age = 20, Occupation = 'Doctor', Address = "1234 Las Vegas, CA")
print(dict_add)

#One more way to use dict()
dict_add = dict([(1,'John'), (2,20), (3, 'Doctor')])
print(dict_add)

print([dict_add[2]])
print(dict_add.keys())
print(dict_add.values())
print(dict_add.items())

#.get()

x = dict_add.get('1', "Used a different dictionary! ")
x = dict_add.get(1, "Used a different dictionary! ")

print("My name is : " , x)
#Adding a new key value
#dictionary_name[key] = value

dict_add['emp_Id'] = 102
print(dict_add)

#To update
dict_add['emp_Id'] = 101
print(dict_add)
#To delete
del dict_add['emp_Id']
print(dict_add)

#del deleted the entire dictionary if the key is 
# not mentioned
contact = {
    'first_name': 'Andrew',
    'last_name': 'Stefanik',
}

# deletes the entire dictionary
del contact
print(contact)

#Iteration
#For

user = {'name': 'Andrew', 'email': 'andrew@email.com', 'username': 'andrewUser'}

for key, value in user.items():
    print("Key : ", key , "\tValue : ", value)


#for value in user.items():
   # print("Value : ", value )

#for key in user.items():
   # print("Key : ", key )

for key, value in user.items():
    print("Key : ", key)

    for key in user.keys():
        print("Key =", key, "\tValue =", user[key])
    for value in user.values():
        print("Value = ", value)

for key in user:
    print("Key =", key, "\tValue =", user[key])

for key in user:
    print("Key =", key, "\tValue =", user[key])


# A list of Dictionaries

contact_0 = {'Name': 'Neha', 'Age':'10', 'City': 'Nashville'}
contact_1 = {'Name': 'Ayan', 'Age':'15', 'City': 'South Bound Brook'}
contact_2 = {'Name': 'Adam', 'Age':'12', 'City': 'Milpitas'}

lst_Contacts = [contact_0, contact_1 ,contact_2]
print(lst_Contacts)

for contact in lst_Contacts:
    print(contact)

#A Dictionary with Dictionaries

job_description0 = {'Position':'Teacher', 'School':'Tara High', 'Salary': 100000}

contact_0['Job_Details'] = job_description0
print(contact_0)

people = {
    'person1': {
        'name': 'Sally Sue',
        'city': 'Phoenix'
    },
    'person2': {
        'name': 'Billy Bob',
        'city': 'Scottsdale'
    },
    'person3': {
        'name': 'Rover',
        'city': 'Zappa'
    }
}

greetings = []
for key, value in people.items():
    temp_var = str.format("Hi {} from {} ",value['name'], value['city'])
    greetings.append(temp_var)
print(greetings)



