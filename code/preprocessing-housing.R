# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the housing data
data <- read.csv('data/kc_house/kc_house_data.csv',fileEncoding = 'UTF-8')

# Create copy to store a numeric copy of the date information and remove the id column
data2 <- data[,-1]
data2$date <- as.numeric(as.POSIXct(as.Date(sapply(strsplit(as.character(data$date),'T'),'[[',1),"%Y%m%d")))

# Write out processed data
dir.create('processed-data/housing')
createNewData(data2[,!names(data2) == 'price'],data2$price,direc='processed-data/housing/housing') 