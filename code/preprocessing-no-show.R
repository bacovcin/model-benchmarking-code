# Load in function for generating datasets
source('code/preprocessing.R')

# Load in the no-show data
data <- read.csv('data/no-show/No-show-Issue-Comma-300k.csv',fileEncoding = 'UTF-8')

# Create copy to convert dates
data2 <- data
data2$AppointmentRegistration <- as.numeric(as.POSIXct(data$AppointmentRegistration))
data2$ApointmentData <- as.numeric(as.POSIXct(data$ApointmentData))

# Write out processed data
dir.create('processed-data/no-show')
createNewData(data2[,!names(data) == 'Status'],data2$Status,direc='processed-data/no-show/no-show') 