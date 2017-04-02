# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the speeddate data
data <- read.csv('data/speed-date/speed-date.csv',fileEncoding = 'latin1')

# Create copy to remove id and convert a number of predictors to factors
data2 <- data[,!names(data) %in% c('iid','pid')]
data2$id <- factor(data2$id)
data2$idg <- factor(data2$idg)
data2$condtn <- factor(data2$condtn)

# Create the different datasets
output <- createNewData(data2[,!names(data2) == 'match'],data2$match) 

# Write out processed data
dir.create('processed-data/speeddate')
write.csv(output[[1]][['train']], file = 'processed-data/speeddate/speeddate-train1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['train']], file = 'processed-data/speeddate/speeddate-train2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['train']], file = 'processed-data/speeddate/speeddate-train3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['train']], file = 'processed-data/speeddate/speeddate-train4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[1]][['test']], file = 'processed-data/speeddate/speeddate-test1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['test']], file = 'processed-data/speeddate/speeddate-test2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['test']], file = 'processed-data/speeddate/speeddate-test3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['test']], file = 'processed-data/speeddate/speeddate-test4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[5]],file = 'processed-data/speeddate/speeddate-trainy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[6]],file = 'processed-data/speeddate/speeddate-testy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
