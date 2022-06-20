
class Cat:
    """This class represents a cat."""

    # 1. This is a class variable that is shared by ALL instances of the class
    sound_made = 'Meow'

    # 2. The class initialization method
    def __init__(self, name):
        """Initializer of Cat class"""
        self.name = name    #: The name of the Cat instance

    # 3. this method prints out the class variable `sound_made`
    def say_something(self):
        """Speak!"""
        print(self.name, "says", Cat.sound_made)

# 4. create two Cat instances
mittens = Cat('Mittens')
feather = Cat('Feather')

# 5. call `say_something` method on each
mittens.say_something()
feather.say_something()

# 6. change the value of the class variable
Cat.sound_made = 'Woof'

# 7. call `say_something` again for each instance after the change
mittens.say_something()
feather.say_something()

class cls_dog:
    dog_breed = "Golden Retriever"
    """Practice witha class dog"""
    def __init__(self,dog_name,dog_age):
        self.name_chk = dog_name
        self.age_chk = dog_age
    
    def dogs_info(self):
        print("The name of the dog is ", self.name_chk, " and age is ", self.age_chk)

    def dogs_language(self):
        if self.name_chk == 'TOTO':
            print(self.name_chk , " says Hello")
        else:
            print(self.name_chk , " says I am not TOTO ! ")

    @staticmethod
    def breed_dog():
        print("Dog breed is : ", cls_dog.dog_breed)


inst_toto = cls_dog("TOTO",5)
inst_mayo = cls_dog("Mayo",12)

inst_toto.dogs_info()
inst_mayo.dogs_info()

inst_mayo.dogs_language()
inst_toto.dogs_language()
print(inst_mayo.name_chk)
cls_dog.breed_dog()


#####
# 1. Define the `Student` class
class Student:
    """This models a student"""

    # 2. Class variable - array of Student instances
    students = []   #: Class var to hold all students

    # 3. Initializer for two instance properties: name and grade
    def __init__(self, name, grade):
        """Initializer of class"""
        self.name = name    #: Instance var for student name
        self.grade = grade  #: Instance var for student grade

    # 4. Instance method to display information about a student
    def display(self):
        """Instance method to display student info"""
        print("Name:", self.name, ", Grade:", self.grade)

    # 5. Class method to add a student instance to class array `students`
    @staticmethod
    def add_student(student):
        """Class method for adding a student to the class var"""
        Student.students.append(student)

    # 6. Class method to call the `display` method for all students
    @staticmethod
    def display_students():
        """Class method for printing all students"""
        for student in Student.students:
            student.display()

# 7. create an instance of `Student` and print info
bill = Student('Bill', 'Freshman')
bill.display()

# 8. create another instance of `Student` and print info
sally = Student('Sally', 'Junior')
sally.display()

# 9. add both students to student array which is a class var
#    using the class method `add_student`
Student.add_student(bill)
Student.add_student(sally)

# 10. call class method `display_students` to print info
#     for all added students
print('--------')
Student.display_students()

########
class Greeter:

    lst_ppl = []
    def __init__(self,fname,lname):
        self.fname = fname
        self.lname = lname
    
    @staticmethod
    def greet(people):
        counter_1 = 0
        for people in Greeter.lst_ppl:
            print("hello ", Greeter.lst_ppl[counter_1])
            counter_1 += 1
    
    def create_list(self):
        Greeter.lst_ppl.append(self.fname + " " + self.lname +"!")
    
    
bill = Greeter("Bill", "Barnes")
sally = Greeter("Sally", "Smith")
bill.create_list()
sally.create_list()
Greeter.greet(Greeter.lst_ppl)


### correct output 
class Greeter:
    """ This is a greeter"""

    @staticmethod
    def greet(people):
        """Static method to greet a list of people"""
        greetings = []
        for person in people:
            greeting = "Hello " + person.firstName + " " + person.lastName + "!"
            greetings.append(greeting)
        return greetings