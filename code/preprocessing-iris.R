# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the iris data
data <- read.csv('data/iris/Iris.csv',fileEncoding = 'UTF-8')

# Create copy to remove the id column
data2 <- data[,-1]

# Write out processed data
dir.create('processed-data/iris')
createNewData(data2[,!names(data2) == 'Species'],data2$Species,direc='processed-data/iris/iris') 
