#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

#
output <- data.frame(id=NULL,mem=NULL,time=NULL,logloss=NULL,waf1=NULL)

library(caret)

# Set random seed for reproducability
set.seed(4231)

# Fit model and extract values
getOutput <- function(trainx,trainy,testx,testy,method,id){
  ptm <- proc.time()
  # Used 10-fold cross validation repeated 10 times for parameter tuning
  ctrl <- trainControl(method = "repeatedcv",
                       repeats = 5,
                       number = 10)
  
  train <- as.data.frame(cbind(trainy,trainx))
  print(summary(train))
  mod <- train(as.formula(paste0(names(train)[1],'~.')),
                data=train,
                method = method,
                trControl = ctrl
          )
  
  pred <- predict(mod,newdata=testx,type='raw')
  predprob <- predict(mod,newdata=testx,type='prob')
  
  print(predprob)
  
  return(dataframe(id=id,mem = object_size(mod),time = proc.time()-ptm,logloss=logloss,waf1=waf1))
  
}

# Predict the glass data #1
glass.train.y <- read.csv('processed-data/glass/glass-trainy.csv')
glass.train.y$x <- factor(glass.train.y$x)
glass.test.y <- read.csv('processed-data/glass/glass-testy.csv')
glass.train.1 <- read.csv('processed-data/glass/glass-train1.csv')
glass.test.1 <- read.csv('processed-data/glass/glass-test1.csv')

getOutput(id='glass1',
          trainx = glass.train.1,
          testx = glass.test.1,
          trainy = glass.train.y,
          testy = glass.test.y,
          method='svmLinearWeights2')
