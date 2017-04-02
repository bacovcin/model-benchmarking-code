#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

#
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
  
  train <- as.data.frame(cbind(trainy,trainx))

  mod <- train(as.formula(paste0(names(train)[1],'~.')),
                data=train,
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

# Predict the glass data #1
housing.train.y <- read.csv('processed-data/housing/housing-trainy.csv')
housing.test.y <- read.csv('processed-data/housing/housing-testy.csv')

housing.train.1 <- read.csv('processed-data/housing/housing-train1.csv')
housing.test.1 <- read.csv('processed-data/housing/housing-test1.csv')

output<-getOutput(id='housing1',
                  trainx = housing.train.1,
                  testx = housing.test.1,
                  trainy = housing.train.y,
                  testy = housing.test.y,
                  method='glmnet')

housing.train.2 <- read.csv('processed-data/housing/housing-train2.csv')
housing.test.2 <- read.csv('processed-data/housing/housing-test2.csv')

output<-rbind(output,getOutput(id='housing2',
          trainx = housing.train.2,
          testx = housing.test.2,
          trainy = housing.train.y,
          testy = housing.test.y,
          method='glmnet'))

housing.train.3 <- read.csv('processed-data/housing/housing-train3.csv')
housing.test.3 <- read.csv('processed-data/housing/housing-test3.csv')

output<-rbind(output,getOutput(id='housing3',
          trainx = housing.train.3,
          testx = housing.test.3,
          trainy = housing.train.y,
          testy = housing.test.y,
          method='glmnet'))

housing.train.4 <- read.csv('processed-data/housing/housing-train4.csv')
housing.test.4 <- read.csv('processed-data/housing/housing-test4.csv')

output<-rbind(output,getOutput(id='housing4',
          trainx = housing.train.4,
          testx = housing.test.4,
          trainy = housing.train.y,
          testy = housing.test.y,
          method='glmnet'))

print(output)

