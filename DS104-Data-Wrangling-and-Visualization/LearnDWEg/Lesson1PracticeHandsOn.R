# Import library

library(readxl)
library("tidyr")
#Import the excel sheet

FakeNews <- read_excel("Documents/GitHub/DS-Student-Resources/DS104-Data-Wrangling-and-Visualization/LearnDWEg/FakeNews.xlsx")

View(FakeNews)

#Add a column labeled StoryType and fill it with Fake.

FakeNews$StoryType <- 'Fake'
head(FakeNews)

#Remove the when column
FakeNews_RC <- FakeNews[,2:4]
head(FakeNews_RC)

# Separate the url column out so that you can see in one column the website and in the second column the domain.
FakeNews_Split <- separate(FakeNews, url, c("Website", "Domain") , sep = "_")
head(FakeNews_Split)

# Put back together the domain column.
FakeNews_Unite <- unite(FakeNews_Split, url, Website, Domain, sep = '_')
head(FakeNews_Unite)

# Keep only 10 rows of data
FakeNews_KR <- FakeNews[1:10,]





