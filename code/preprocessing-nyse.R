# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the NYSE data (data1 is price data, data2 is general info on the securities)
data1 <- read.csv('data/nyse/prices.csv',fileEncoding = 'UTF-8')
data2 <- read.csv('data/nyse/securities.csv',fileEncoding = 'UTF-8')

# First, create timeseries by incorporating previous seven days' prices
data1$date<-as.Date(data1$date)
price_data <- data.frame(y=data1$close,date=as.Date(data1$date),x=data1$symbol,open=data1$open)
price_data$day1 <- price_data$date - 1
price_data$day2 <- price_data$date - 2
price_data$day3 <- price_data$date - 3
price_data$day4 <- price_data$date - 4
price_data$day5 <- price_data$date - 5
price_data$day6 <- price_data$date - 6
price_data$day7 <- price_data$date - 7
price_data <- head(price_data,1000)

day1 <- data.frame(day1=data1$date,x=data1$symbol,close1=data1$close,low1=data1$low,high1=data1$high,vol1=data1$volume)
price_data2<-merge(price_data,day1,all.x=TRUE,all.y=FALSE,sort=FALSE)

day2 <- data.frame(day2=data1$date,x=data1$symbol,close2=data1$close,low2=data1$low,high2=data1$high,vol2=data1$volume)
price_data3<-merge(price_data2,day2,all.x=TRUE,all.y=FALSE,sort=FALSE)

day3 <- data.frame(day3=data1$date,x=data1$symbol,close3=data1$close,low3=data1$low,high3=data1$high,vol3=data1$volume)
price_data4<-merge(price_data3,day3,all.x=TRUE,all.y=FALSE,sort=FALSE)

day4 <- data.frame(day4=data1$date,x=data1$symbol,close4=data1$close,low4=data1$low,high4=data1$high,vol4=data1$volume)
price_data5<-merge(price_data4,day4,all.x=TRUE,all.y=FALSE,sort=FALSE)

day5 <- data.frame(day5=data1$date,x=data1$symbol,close5=data1$close,low5=data1$low,high5=data1$high,vol5=data1$volume)
price_data6<-merge(price_data5,day5,all.x=TRUE,all.y=FALSE,sort=FALSE)

day6 <- data.frame(day6=data1$date,x=data1$symbol,close6=data1$close,low6=data1$low,high6=data1$high,vol6=data1$volume)
price_data7<-merge(price_data6,day6,all.x=TRUE,all.y=FALSE,sort=FALSE)

day7 <- data.frame(day7=data1$date,x=data1$symbol,close7=data1$close,low7=data1$low,high7=data1$high,vol7=data1$volume)
price_data8<-merge(price_data7,day7,all.x=TRUE,all.y=FALSE,sort=FALSE)

# Merge security data with price data
names(data2)[1]<-'x'
data2<-data2[,-2]
data2<-data2[,-2]
data2$Date.first.added<-as.numeric(as.POSIXct(as.Date(data2$Date.first.added,format='%Y-%m-%d')))
price_data9 <- merge(price_data8[,!names(data2) %in% c('day1','day2','day3','day4','day5','day6','day7')],data2,all.x=TRUE)
# Create the different datasets
output <- createNewData(price_data9[,!names(price_data9) == 'y'],price_data9$y) 

# Write out processed data
dir.create('processed-data/nyse')
write.csv(output[[1]][['train']], file = 'processed-data/nyse/nyse-train1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['train']], file = 'processed-data/nyse/nyse-train2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['train']], file = 'processed-data/nyse/nyse-train3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['train']], file = 'processed-data/nyse/nyse-train4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[1]][['test']], file = 'processed-data/nyse/nyse-test1.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[2]][['test']], file = 'processed-data/nyse/nyse-test2.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[3]][['test']], file = 'processed-data/nyse/nyse-test3.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[4]][['test']], file = 'processed-data/nyse/nyse-test4.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[5]],file = 'processed-data/nyse/nyse-trainy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
write.csv(output[[6]],file = 'processed-data/nyse/nyse-testy.csv',row.names=FALSE,fileEncoding = 'UTF-8')
