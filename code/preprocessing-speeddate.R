# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the speeddate data
data <- read.csv('data/speed-date/speed-date.csv',fileEncoding = 'latin1')

# Create copy to remove id and convert a number of predictors to factors
data2 <- data[,!names(data) %in% c('iid','pid')]
data2$id <- factor(data2$id)
data2$idg <- factor(data2$idg)
data2$condtn <- factor(data2$condtn)


# Write out processed data
dir.create('processed-data/speeddate')
createNewData(data2[,!names(data2) == 'match'],data2$match,direc='processed-data/speeddate/speeddate') 

