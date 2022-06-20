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

        