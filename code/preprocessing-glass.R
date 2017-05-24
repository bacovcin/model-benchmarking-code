# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the glass data
data <- read.csv('data/glass/glass.csv',fileEncoding = 'UTF-8')

# Write out processed data
dir.create('processed-data/glass')
createNewData(data[,!names(data) == 'Type'],data$Type,direc='processed-data/glass/glass') 
