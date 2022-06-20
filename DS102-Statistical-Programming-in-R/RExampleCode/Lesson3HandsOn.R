#Program to calculate diameter of a sphere

# diam() function to calculate diameter
diam <- function(sphWeight){
  (2/2.54)*(sphWeight/(.92*(4/3) * pi ))^(1/3)
}

# for loop to print the diameter of the sphere for the given vector
vec.weight <- c(0.96, 1.51, 2.17, 3.85, 4.45, 6.02)

for(Wt in vec.weight){
  diamVal = diam(Wt)
  cat("The diameter of sphere is: ", diamVal, " for sphere weight: ",Wt, "\n")
}

