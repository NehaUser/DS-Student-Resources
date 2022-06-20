#Heat Maps
library(readr)
library(scales)
install.packages("treemap") # Tree maps
install.packages("vcd") # Mosaic plot
library(vcd)
library(treemap)

stockdata <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/stockdata.csv")
View(stockdata)

#In order to create heat maps in R, you can use the function heatmap() from base R.
#In order to use the heatmap function, you must have your data formatted as a matrix, 
#and all of your data must be numeric.

# Remove the Date column

stockdata1 <- stockdata[,2:11]

# Then use the function as.matrix()
# to reformat the data as a matrix, rather than as a data frame:

stockdata2 <- as.matrix(stockdata1)

# run the heatmap() function:

heatmap(stockdata2)

# In order to create tree maps in R, you will need to install and load two different 
# libraries: treemap and scales. Then use the treemap() function,
datascience_posts <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/datascience_posts.csv")
View(datascience_posts)
treemap(datascience_posts, index=c("category"), vSize="views", type="index")

# Mosaic plots
# Mosaic plots can be made in R with the library vcd

# In order to make use of the function mosaic(),
# you will need to have your data formatted as a table. 
# In order to do that, you will first use the attach() function, 
# and then will use the table() function, like this:

defects <- read_csv("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/defects.csv")
View(defects) 

attach(defects)
defects2 <- table(Region, Defect)
defects2

mosaic(defects2, shade=TRUE, legend=TRUE)






