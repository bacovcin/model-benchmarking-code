#!/usr/bin/env Rscript
library(caret)

createNewData <- function(origx,origy,direc) {
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
  rm(newnames)
  rm(origx)
  gc()
  
  # Create training/test split
  trainIndex <- createDataPartition(origy, p = .8, 
                                    list = FALSE, 
                                    times = 1)
 
  # rename vector in y as y
  origtrain.y <- origy[trainIndex]
  origtest.y <- origy[-trainIndex]
  names(origtrain.y)<-'y'
  names(origtest.y)<-'y'

  # Write and delete the y-values
  print('Saving the Y-values...')
  write.csv(origtrain.y,file = paste0(direc,'-trainy.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  write.csv(origtest.y,file = paste0(direc,'-testy.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  rm(origy)
  rm(origtrain.y)
  rm(origtest.y)
  gc()

  origtrain.x <- newx[trainIndex,]
  origtest.x <- newx[-trainIndex,]
  cols <- dim(newx)[2]
  rows <- dim(newx)[1]
  rm(newx)
  gc()
  
  # Generate junk data equal in number of columns to actual data (half continuous, half discrete)
  junkx <- rnorm(rows,rnorm(1,0,10),abs(rnorm(1,0,5)))
  for (i in 1:min((cols/2)-1,20)){
    junkx <- as.data.frame(cbind(junkx,rnorm(rows,rnorm(1,0,10),abs(rnorm(1,0,5)))))
  }
  for (i in 1:min((cols/2),20)){
    junkx <- as.data.frame(cbind(junkx,rbinom(rows,1,runif(1,min=0.05,max=0.95))))
  }
  names(junkx)<-paste0('junk',1:dim(junkx)[2])

  # Do the spliting on actual data and junk data
  junktrain <- junkx[trainIndex,]
  junktest <- junkx[-trainIndex,]
  rm(junkx)
  gc()
  
  # Impute NAs
  impMod <- preProcess(origtrain.x,method=c('medianImpute'))
  origtrain.x <- predict(impMod,origtrain.x)
  origtest.x <- predict(impMod,origtest.x)
  rm(impMod)
  gc()
  print('Saving the first dataset...')
  write.csv(origtrain.x, file = paste0(direc,'-train1.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  write.csv(origtest.x, file = paste0(direc,'-test1.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  preMod1 <- preProcess(origtrain.x,method=c('center','scale','nzv'))
  print('Saving the second dataset...')
  write.csv(predict(preMod1,origtrain.x), file = paste0(direc,'-train2.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  write.csv(predict(preMod1,origtest.x), file = paste0(direc,'-test2.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  rm(preMod1)
  gc()
  
  # Combine data and junk data
  newtrain.x <- as.data.frame(cbind(origtrain.x,junktrain))
  rm(junktrain)
  rm(origtrain.x)
  gc()
  newtest.x <- as.data.frame(cbind(origtest.x,junktest))
  rm(junktest)
  rm(origtest.x)
  gc()
  
  # Save last two datasets
  print('Saving the third dataset...')
  write.csv(newtrain.x, file = paste0(direc,'-train3.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  write.csv(newtest.x, file = paste0(direc,'-test3.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  
  # Train preprocessing models
  preMod2 <- preProcess(newtrain.x,method=c('center','scale','nzv'))
  print('Saving the final dataset...')
  write.csv(predict(preMod2,newtrain.x), file = paste0(direc,'-train4.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  write.csv(predict(preMod2,newtest.x), file = paste0(direc,'-test4.csv'),row.names=FALSE,fileEncoding = 'UTF-8')
  rm(newtrain.x)
  rm(newtest.x)
  rm(preMod2)
  gc()
}
