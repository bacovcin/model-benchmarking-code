#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
args <- 'glmnet'
output <- data.frame(id=NULL,mem=NULL,time=NULL,r2=NULL,mae=NULL)

library(caret)

# Set random seed for reproducability
set.seed(4231)

# Fit model and extract values
getOutput <- function(trainx,trainy,testx,testy,method,id){
  ptm <- Sys.time()
  # Used 10-fold cross validation repeated 10 times for parameter tuning
  ctrl <- trainControl(method = "repeatedcv",
                       repeats = 2,
                       number = 2,
                       verboseIter=1)
  
  mod <- train(trainx,trainy[,1],
                method = method,
                trControl = ctrl
          )
  
  pred <- predict(mod,testx)
  
  errors <- testy[,1] - pred
  meany <- mean(testy[,1])
  r2cur <- 1 - (sum(errors^2)/sum((testy[,1]-meany)^2))
  
  maecur <- median(abs(errors))
  
  return(data.frame(id=id,mem = as.numeric(object.size(mod)),time = as.numeric(Sys.time()-ptm),
                    r2=r2cur,mae=maecur))
}

# Get the housing results
housing.train.y <- read.csv('processed-data/housing/housing-trainy.csv')
housing.test.y <- read.csv('processed-data/housing/housing-testy.csv')

# Get the housing dataset 1 independent variables
housing.train.1 <- read.csv('processed-data/housing/housing-train1.csv')
housing.test.1 <- read.csv('processed-data/housing/housing-test1.csv')

# Predict using housing dataset 1
print("Predicting housing #1")
output<-getOutput(id='housing1',
                  trainx = housing.train.1,
                  testx = housing.test.1,
                  trainy = housing.train.y,
                  testy = housing.test.y,
                  method=as.character(args[1]))
rm(housing.train.1)
rm(housing.test.1)
gc()

# Get the housing dataset 2 independent variables
housing.train.2 <- read.csv('processed-data/housing/housing-train2.csv')
housing.test.2 <- read.csv('processed-data/housing/housing-test2.csv')

# Predict using housing dataset 2
print("Predicting housing #2")
output<-rbind(output,getOutput(id='housing2',
          trainx = housing.train.2,
          testx = housing.test.2,
          trainy = housing.train.y,
          testy = housing.test.y,
          method=args[1]))
rm(housing.train.2)
rm(housing.test.2)
gc()

# Get the housing dataset 3 independent variables
housing.train.3 <- read.csv('processed-data/housing/housing-train3.csv')
housing.test.3 <- read.csv('processed-data/housing/housing-test3.csv')

# Predict using housing dataset 3
print("Predicting housing #3")
output<-rbind(output,getOutput(id='housing3',
          trainx = housing.train.3,
          testx = housing.test.3,
          trainy = housing.train.y,
          testy = housing.test.y,
          method=args[1]))
rm(housing.train.3)
rm(housing.test.3)
gc()

# Get the housing dataset 4 independent variables
housing.train.4 <- read.csv('processed-data/housing/housing-train4.csv')
housing.test.4 <- read.csv('processed-data/housing/housing-test4.csv')

# Predict using housing dataset 4
print("Predicting housing #4")
output<-rbind(output,getOutput(id='housing4',
          trainx = housing.train.4,
          testx = housing.test.4,
          trainy = housing.train.y,
          testy = housing.test.y,
          method=args[1]))
rm(housing.train.4)
rm(housing.test.4)
gc()

# Remove housing datasets
rm(housing.train.y)
rm(housing.test.y)

# Get the nyse results
nyse.train.y <- read.csv('processed-data/nyse/nyse-trainy.csv')
nyse.test.y <- read.csv('processed-data/nyse/nyse-testy.csv')

# Get the nyse dataset 1 independent variables
nyse.train.1 <- read.csv('processed-data/nyse/nyse-train1.csv')
nyse.test.1 <- read.csv('processed-data/nyse/nyse-test1.csv')

# Predict using nyse dataset 1
print("Predicting NYSE #1")
output<-getOutput(id='nyse1',
                  trainx = nyse.train.1,
                  testx = nyse.test.1,
                  trainy = nyse.train.y,
                  testy = nyse.test.y,
                  method=args[1])
rm(nyse.train.1)
rm(nyse.test.1)
gc()

# Get the nyse dataset 2 independent variables
nyse.train.2 <- read.csv('processed-data/nyse/nyse-train2.csv')
nyse.test.2 <- read.csv('processed-data/nyse/nyse-test2.csv')

# Predict using nyse dataset 2
print("Predicting NYSE #2")
output<-rbind(output,getOutput(id='nyse2',
                               trainx = nyse.train.2,
                               testx = nyse.test.2,
                               trainy = nyse.train.y,
                               testy = nyse.test.y,
                               method=args[1]))
rm(nyse.train.2)
rm(nyse.test.2)
gc()

# Get the nyse dataset 3 independent variables
nyse.train.3 <- read.csv('processed-data/nyse/nyse-train3.csv')
nyse.test.3 <- read.csv('processed-data/nyse/nyse-test3.csv')

# Predict using nyse dataset 3
print("Predicting NYSE #3")
output<-rbind(output,getOutput(id='nyse3',
                               trainx = nyse.train.3,
                               testx = nyse.test.3,
                               trainy = nyse.train.y,
                               testy = nyse.test.y,
                               method=args[1]))
rm(nyse.train.3)
rm(nyse.test.3)
gc()

# Get the nyse dataset 4 independent variables
nyse.train.4 <- read.csv('processed-data/nyse/nyse-train4.csv')
nyse.test.4 <- read.csv('processed-data/nyse/nyse-test4.csv')

# Predict using nyse dataset 4
print("Predicting NYSE #4")
output<-rbind(output,getOutput(id='nyse4',
                               trainx = nyse.train.4,
                               testx = nyse.test.4,
                               trainy = nyse.train.y,
                               testy = nyse.test.y,
                               method=args[1]))
rm(nyse.train.4)
rm(nyse.test.4)
gc()

# Remove housing datasets
rm(nyse.train.y)
rm(nyse.test.y)

print(output)
outputdir <- paste0('results/',args[1],'-R',sep='')
dir.create('results')
dir.create(outputdir)
write.csv(output,file=paste0(outputdir,'/results.csv'))
