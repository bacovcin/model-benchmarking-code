# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the iris data
data <- read.csv('data/iris/Iris.csv',fileEncoding = 'UTF-8')

# Create copy to remove the id column
data2 <- data[,-1]

# Create the different datasets
output <- createNewData(data2[,!names(data2) == 'Species'],data2$Species) 

# Write out processed data
dir.create('processed-data/iris')
write.csv(output[[1]][['train']], file = 'processed-data/iris/iris-train1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['train']], file = 'processed-data/iris/iris-train2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['train']], file = 'processed-data/iris/iris-train3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['train']], file = 'processed-data/iris/iris-train4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[1]][['test']], file = 'processed-data/iris/iris-test1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['test']], file = 'processed-data/iris/iris-test2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['test']], file = 'processed-data/iris/iris-test3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['test']], file = 'processed-data/iris/iris-test4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[5]],file = 'processed-data/iris/iris-trainy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[6]],file = 'processed-data/iris/iris-testy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
