#!/usr/bin/env Rscript
library(caret)

createNewData <- function(origx,origy) {
  # Generate a training and test partition on data,
  # impute any NAs and create new junk predictors,
  # run full preprocessing cycle to create 4 predictor sets:
  # 1) no junk predictors, no preprocessing
  # 2) no junk predictors, preprocessing
  # 3) junk predictors, no preprocessing
  # 4) junk predictors, preprocessing
  set.seed(3456)
  
  # Create dummy variables
  newx <- data.frame(rep(NA,dim(origx)[1]))
  for (i in 1:dim(origx)[2]){
    if (is.factor(origx[,i])) {
      origx[,i]<-as.character(origx[,i])
      origx[is.na(origx[,i]),i]<-'NoData'
      origx[,i]<-factor(origx[,i])
      newx <- as.data.frame(cbind(newx,model.matrix(~origx[,i])[,-1]))
    } else {
      newx <- as.data.frame(cbind(newx,origx[,i]))
      names(newx)[dim(newx)[2]] <- names(origx)[i]
    }
  }
  newx <- newx[,-1]
  newnames <- make.names(names(newx), unique=TRUE)
  names(newx) <- newnames
  
  # Create training/test split
  trainIndex <- createDataPartition(origy, p = .8, 
                                    list = FALSE, 
                                    times = 1)
  
  # Generate junk data equal in number of columns to actual data (half continuous, half discrete)
  junkx <- rnorm(dim(newx)[1],rnorm(1,0,10),abs(rnorm(1,0,5)))
  for (i in 1:min((dim(newx)[2]/2)-1,20)){
    junkx <- as.data.frame(cbind(junkx,rnorm(dim(origx)[1],rnorm(1,0,10),abs(rnorm(1,0,5)))))
  }
  for (i in 1:min((dim(newx)[2]/2),20)){
    junkx <- as.data.frame(cbind(junkx,rbinom(dim(origx)[1],1,runif(1,min=0.05,max=0.95))))
  }
  names(junkx)<-paste0('junk',1:dim(junkx)[2])
  # Do the spliting on actual data and junk data
  origtrain.x <- newx[trainIndex,]
  junktrain <- junkx[trainIndex,]
  origtrain.y <- origy[trainIndex]
  origtest.x <- newx[-trainIndex,]
  junktest <- junkx[-trainIndex,]
  origtest.y <- origy[-trainIndex]
  
  # Impute NAs
  impMod <- preProcess(origtrain.x,method=c('medianImpute'))
  origtrain.x <- predict(impMod,origtrain.x)
  origtest.x <- predict(impMod,origtest.x)
  
  # Combine data and junk data
  newtrain.x <- as.data.frame(cbind(origtrain.x,junktrain))
  newtest.x <- as.data.frame(cbind(origtest.x,junktest))
  
  # Train preprocessing models
  preMod1 <- preProcess(origtrain.x,method=c('center','scale','nzv'))
  preMod2 <- preProcess(newtrain.x,method=c('center','scale','nzv'))
  
  # Create output datasets
  output1 <- list(train=origtrain.x,test=origtest.x)
  output2 <- list(train=predict(preMod1,origtrain.x),test=predict(preMod1,origtest.x))
  output3 <- list(train=newtrain.x,test=newtest.x)
  output4 <- list(train=predict(preMod2,newtrain.x),test=predict(preMod2,newtest.x))
  
  # rename vector in y as y
  names(origtrain.y)<-'y'
  names(origtest.y)<-'y'
  return(list(output1,output2,output3,output4,origtrain.y,origtest.y))
}
