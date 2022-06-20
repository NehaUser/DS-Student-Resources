#PART 1

# Create a class named Stadium
class Stadium:
    """This is Stadium"""

# initialize
    def __init__(self,name,city_state,capacity):
        """Initializing the values"""
        self.name = name                #
        self.city_state = city_state    #
        self.capacity = capacity        #

# Another method in the class
    def describe_stadium(self):
        """to print a description of the arena"""
        print("The ", self.name, "is located in ", self.city_state, "and holds ", self.capacity, "fans.")


#Create a new instance of the Stadium class named stadium1.
stadium1 = Stadium("Mercedes Benz Arena","Atlanta, GA", "70,000")

#stadium1 should call the describe_stadium method.
stadium1.describe_stadium()

#PART 2

#Add two more methods to the Stadium class:
#sport_played - This method should accept one argument that specifies 
# the sport that is played
#seats_available - This method should accept one argument that 
# specifies how many seats are available



# Create a class named Stadium
class Stadium:
    """This is Stadium"""

# initialize
    def __init__(self,name,city_state,capacity):
        """Initializing the values"""
        self.name = name                #
        self.city_state = city_state    #
        self.capacity = capacity        #

# Another method in the class
    def describe_stadium(self):
        """to print a description of the arena"""
        print("The ", self.name, "is located in ", self.city_state, "and holds ", self.capacity, "fans.")

# Method to tell what sport_played
    @staticmethod
    def sport_played(sport_name):
        """This method tells what sport is played"""
        print("The following sport is mainly played in this stadium: ", sport_name)

# Method  to tell how many seats are available
    @staticmethod
    def seats_available(avail_seats):
        """available seats """     
        print("There are ", avail_seats, " seats still available for tonight's game.")


#Create a new instance of the Stadium class named stadium1.
stadium1 = Stadium("Mercedes Benz Arena","Atlanta, GA", "70,000")


#stadium1 should call the describe_stadium method.
stadium1.describe_stadium();
stadium1.sport_played("Football")
stadium1.seats_available("15000")


