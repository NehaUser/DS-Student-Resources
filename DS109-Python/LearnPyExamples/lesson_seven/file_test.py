"""
file = open('example.txt', 'w')

print("File Name: ", file.name)
print("Open in " , file.mode, " Mode")
#print("File path : ", )

#define a function that allows you to determine if a file is open or closed.
def status(file):
    if(file.closed == True):
        return "Closed"
    else:
        return "Open"

print(status(file))

#Close the file
file.close()

print("File is : ", status(file)) """
"""
story = "Once there was a princess\n"
story += "who lived in a jungle far far away.\n"
story += "One day she saw a light approaching her."

file = open("story.txt", "w")
file.write(story)
file.close()

file = open("story.txt", "r")
for line in file:
    print(line)

#OR 

story_txt = file.read()
print(story_txt)


file.close()

moretext = "\nAnd she got scared.\n"
moretext += "But she got scared but couldn't run; she froze."
file = open("story.txt", "a")
file.write(moretext)
file.close()

file = open("story.txt", "r")

#for line in file:
#   print(line)
    
story_txt = file.read()
print(story_txt)

file.close()"""

new_text = 'Python was conceived in the late 1990s by Guido van Rossum'
with open('updating.txt', 'w') as file:
    file.write(new_text)
    print('\nFile Now Closed?:', file.closed)

with open('updating.txt', 'r+') as file:
    print(file.read())
    print('\nFile Now Closed?:', file.closed)
    print('\nPosition In File Now:', file.tell())
    position = file.seek(33)
    print('Position In File Now:', file.tell())
    file.write('1980s')
    file.seek(0)
    new_text = file.read()
    print('\nString:', new_text)





