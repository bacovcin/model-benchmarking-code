# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the glass data
data <- read.csv('data/glass/glass.csv',fileEncoding = 'UTF-8')

# Create the different datasets
output <- createNewData(data[,!names(data) == 'Type'],data$Type) 

# Write out processed data
dir.create('processed-data/glass')
write.csv(output[[1]][['train']], file = 'processed-data/glass/glass-train1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['train']], file = 'processed-data/glass/glass-train2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['train']], file = 'processed-data/glass/glass-train3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['train']], file = 'processed-data/glass/glass-train4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[1]][['test']], file = 'processed-data/glass/glass-test1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['test']], file = 'processed-data/glass/glass-test2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['test']], file = 'processed-data/glass/glass-test3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['test']], file = 'processed-data/glass/glass-test4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[5]],file = 'processed-data/glass/glass-trainy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[6]],file = 'processed-data/glass/glass-testy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
