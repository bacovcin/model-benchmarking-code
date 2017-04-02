# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the housing data
data <- read.csv('data/kc_house/kc_house_data.csv',fileEncoding = 'UTF-8')

# Create copy to store a numeric copy of the date information and remove the id column
data2 <- data[,-1]
data2$date <- as.numeric(as.POSIXct(as.Date(sapply(strsplit(as.character(data$date),'T'),'[[',1),"%Y%m%d")))

# Create the different datasets
output <- createNewData(data2[,!names(data2) == 'price'],data2$price) 

# Write out processed data
dir.create('processed-data/housing')
write.csv(output[[1]][['train']], file = 'processed-data/housing/housing-train1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['train']], file = 'processed-data/housing/housing-train2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['train']], file = 'processed-data/housing/housing-train3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['train']], file = 'processed-data/housing/housing-train4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[1]][['test']], file = 'processed-data/housing/housing-test1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['test']], file = 'processed-data/housing/housing-test2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['test']], file = 'processed-data/housing/housing-test3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['test']], file = 'processed-data/housing/housing-test4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[5]],file = 'processed-data/housing/housing-trainy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[6]],file = 'processed-data/housing/housing-testy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
