#Function to calculate 11 table

fn11table <- function(nomult){
  (nomult * 11)
}

fn11table(2)

#Vectors

vec_manual <- c(2,5,7,1)
vec_asc <- 5:9
vec_desc <- 11:3

#For loops

for (n in 1:6){
  
  cat("Square of", n, " is ", n^2, "\n")
  
}

#
for (n in vec_manual){
  
  cat("Square of", n, " is ", n^2, "\n")
  
}


# Creating a function and for loop to convert temperature from degree F to degree C

fToc <- function(Tinf){
  (Tinf - 32) * 5 / 9
}

tempInF <- c(-20, 10, 20, 40, 35)
for(x in tempInF){
  cat(x, " in degree Celcius is" , fToc(x) ,"\n")
}




