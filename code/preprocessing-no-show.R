# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the no-show data
data <- read.csv('data/no-show/No-show-Issue-Comma-300k.csv',fileEncoding = 'UTF-8')

# Create copy to convert dates
data2 <- data
data2$AppointmentRegistration <- as.numeric(as.POSIXct(data$AppointmentRegistration))
data2$ApointmentData <- as.numeric(as.POSIXct(data$ApointmentData))

# Create the different datasets
output <- createNewData(data2[,!names(data) == 'Status'],data2$Status) 

# Write out processed data
dir.create('processed-data/no-show')
write.csv(output[[1]][['train']], file = 'processed-data/no-show/no-show-train1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['train']], file = 'processed-data/no-show/no-show-train2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['train']], file = 'processed-data/no-show/no-show-train3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['train']], file = 'processed-data/no-show/no-show-train4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[1]][['test']], file = 'processed-data/no-show/no-show-test1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['test']], file = 'processed-data/no-show/no-show-test2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['test']], file = 'processed-data/no-show/no-show-test3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['test']], file = 'processed-data/no-show/no-show-test4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[5]],file = 'processed-data/no-show/no-show-trainy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[6]],file = 'processed-data/no-show/no-show-testy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
