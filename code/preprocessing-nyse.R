# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the NYSE data (data1 is price data, data2 is general info on the securities)
data1 <- read.csv('data/nyse/prices.csv',fileEncoding = 'UTF-8')
data2 <- read.csv('data/nyse/securities.csv',fileEncoding = 'UTF-8')

# First, create timeseries by incorporating previous seven days' prices
data1$date<-as.Date(data1$date)

price_data <- data.frame(y=data1$close,date=as.Date(data1$date),x=data1$symbol,open=data1$open,dow=factor(weekdays(data1$date)))

# Monday (get previous workweeks values)
price_data$day1[price_data$dow=='Monday'] <- price_data$date[price_data$dow=='Monday'] - 3
price_data$day2[price_data$dow=='Monday'] <- price_data$date[price_data$dow=='Monday'] - 4
price_data$day3[price_data$dow=='Monday'] <- price_data$date[price_data$dow=='Monday'] - 5
price_data$day4[price_data$dow=='Monday'] <- price_data$date[price_data$dow=='Monday'] - 6
price_data$day5[price_data$dow=='Monday'] <- price_data$date[price_data$dow=='Monday'] - 7

# Tuesday
price_data$day1[price_data$dow=='Tuesday'] <- price_data$date[price_data$dow=='Tuesday'] - 1
price_data$day2[price_data$dow=='Tuesday'] <- price_data$date[price_data$dow=='Tuesday'] - 4
price_data$day3[price_data$dow=='Tuesday'] <- price_data$date[price_data$dow=='Tuesday'] - 5
price_data$day4[price_data$dow=='Tuesday'] <- price_data$date[price_data$dow=='Tuesday'] - 6
price_data$day5[price_data$dow=='Tuesday'] <- price_data$date[price_data$dow=='Tuesday'] - 7

# Wednesday
price_data$day1[price_data$dow=='Wednesday'] <- price_data$date[price_data$dow=='Wednesday'] - 1
price_data$day2[price_data$dow=='Wednesday'] <- price_data$date[price_data$dow=='Wednesday'] - 2
price_data$day3[price_data$dow=='Wednesday'] <- price_data$date[price_data$dow=='Wednesday'] - 5
price_data$day4[price_data$dow=='Wednesday'] <- price_data$date[price_data$dow=='Wednesday'] - 6
price_data$day5[price_data$dow=='Wednesday'] <- price_data$date[price_data$dow=='Wednesday'] - 7

# Thursday
price_data$day1[price_data$dow=='Thursday'] <- price_data$date[price_data$dow=='Thursday'] - 1
price_data$day2[price_data$dow=='Thursday'] <- price_data$date[price_data$dow=='Thursday'] - 2
price_data$day3[price_data$dow=='Thursday'] <- price_data$date[price_data$dow=='Thursday'] - 3
price_data$day4[price_data$dow=='Thursday'] <- price_data$date[price_data$dow=='Thursday'] - 6
price_data$day5[price_data$dow=='Thursday'] <- price_data$date[price_data$dow=='Thursday'] - 7

# Friday
price_data$day1[price_data$dow=='Friday'] <- price_data$date[price_data$dow=='Friday'] - 1
price_data$day2[price_data$dow=='Friday'] <- price_data$date[price_data$dow=='Friday'] - 2
price_data$day3[price_data$dow=='Friday'] <- price_data$date[price_data$dow=='Friday'] - 3
price_data$day4[price_data$dow=='Friday'] <- price_data$date[price_data$dow=='Friday'] - 4
price_data$day5[price_data$dow=='Friday'] <- price_data$date[price_data$dow=='Friday'] - 7

print('Day1')
day1 <- data.frame(day1=data1$date,x=data1$symbol,close1=data1$close,low1=data1$low,high1=data1$high,vol1=data1$volume)
price_data<-merge(price_data,day1,all.x=TRUE,all.y=FALSE,sort=FALSE)
rm(day1)
gc()

print('Day2')
day2 <- data.frame(day2=data1$date,x=data1$symbol,close2=data1$close,low2=data1$low,high2=data1$high,vol2=data1$volume)
price_data<-merge(price_data,day2,all.x=TRUE,all.y=FALSE,sort=FALSE)
rm(day2)
gc()

print('Day3')
day3 <- data.frame(day3=data1$date,x=data1$symbol,close3=data1$close,low3=data1$low,high3=data1$high,vol3=data1$volume)
price_data<-merge(price_data,day3,all.x=TRUE,all.y=FALSE,sort=FALSE)
rm(day3)
gc()

print('Day4')
day4 <- data.frame(day4=data1$date,x=data1$symbol,close4=data1$close,low4=data1$low,high4=data1$high,vol4=data1$volume)
price_data<-merge(price_data,day4,all.x=TRUE,all.y=FALSE,sort=FALSE)
rm(day4)
gc()

print('Day5')
day5 <- data.frame(day5=data1$date,x=data1$symbol,close5=data1$close,low5=data1$low,high5=data1$high,vol5=data1$volume)
price_data<-merge(price_data,day5,all.x=TRUE,all.y=FALSE,sort=FALSE)
rm(day5)
gc()

# Merge security data with price data
names(data2)[1]<-'x'
data2<-data2[,-2]
data2<-data2[,-2]
data2$Date.first.added<-as.numeric(as.POSIXct(as.Date(data2$Date.first.added,format='%Y-%m-%d')))
price_data <- merge(price_data[,!(names(price_data) %in% c('day1','day2','day3','day4','day5'))],data2,all.x=TRUE)
price_data$date <- as.numeric(as.POSIXct(as.Date(price_data$date)))
rm(data1)
rm(data2)
gc()

# Create the different datasets
dir.create('processed-data/nyse')
createNewData(price_data[,!(names(price_data) %in% c('x','y'))],price_data$y,direc='processed-data/nyse/nyse') 
