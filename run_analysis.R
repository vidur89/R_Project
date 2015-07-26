library(dplyr)
library(plyr)
library(data.table)

#function to get the name of the files to be used as labels
nameExtract<-function(dataSet){
      temp<-unlist(strsplit(dataSet,"/|[.]"))
      ans<-temp[length(temp)-1]
      ans
}

#function to load the data into individual data tables
dataForm<-function(dataSet,value){
      print(dataSet[2])
      
      if(value==1)
            testData<<-cbind(testData,read.table(paste("./data/accelerometer/",dataSet[2],sep=""),sep="\n",colClasses = "numeric",col.names=dataSet[1]))
      #            testData[,dataSet[1]:=as.list(fread(paste("./data/accelerometer/",dataSet[2],sep=""),sep="\n",colClasses = "numeric"))]
      
      else if(value==2)
            trainData<<-cbind(trainData,read.table(paste("./data/accelerometer/",dataSet[2],sep=""),sep="\n",colClasses = "numeric",col.names=dataSet[1]))
      #                  trainData[,dataSet[1]:=as.list(fread(paste("./data/accelerometer/",dataSet[2],sep=""),sep="\n",colClasses = c("numeric")))]
}

reshapeData<-function(dataSet){
      reshape(mergedData,direction="long", idvar="subject_train",varying=list(dataSet,gsub("train",replacement = "test",dataSet,fixed=T)))
}

Fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!exists("./data/accelerometer.zip")){
      download.file(Fileurl,method="curl",destfile = "./data/accelerometer.zip")
      if(!exists("./data/accelerometer"))
            unzip(zipfile="./data/accelerometer.zip",exdir="./data/accelerometer")
}
filesTestData<-list.files('./data/accelerometer',recursive = T,pattern=c("test"))
filesTestData<-filesTestData[(length(filesTestData)-2):length(filesTestData)]
filesTrainData<-list.files('./data/accelerometer',recursive = T,pattern=c("train"))
filesTrainData<-filesTrainData[(length(filesTrainData)-2):length(filesTrainData)]
testNames<-unlist(lapply(filesTestData, nameExtract))
trainNames<-unlist(lapply(filesTrainData, nameExtract))
combinedTest<-cbind(testNames,filesTestData)
combinedTrain<-cbind(trainNames,filesTrainData)
commonFiles<-list.files('./data/accelerometer',recursive = T,pattern=c("txt"))
featureNameFile<-read.table(commonFiles[grep("features.txt",commonFiles)],sep="",col.names=c("index","feature"),colClasses = "character")
labelsNameFile<-read.table(commonFiles[grep("labels",commonFiles)],sep="",col.names=c("index","labels"),colClasses = "character")
#creating  data.frame with first value because we cannot append columns to an empty data table
testData<-read.table(paste("./data/accelerometer/",combinedTest[,2][combinedTest[,1]=="X_test"] ,sep=""),sep="",header=F)# sep="" means any length of space

trainData<-read.table(paste("./data/accelerometer/",combinedTrain[,2][combinedTrain[,1]=="X_train"] ,sep=""),sep="",header = F)# sep="" means any length of space

setnames(testData,featureNameFile$feature)
setnames(trainData,featureNameFile$feature)

#method using datatable and fread for speed
w<-apply(combinedTest[2:nrow(combinedTest),],1,FUN=dataForm,value=1)
w<-apply(combinedTrain[2:nrow(combinedTrain),],1,FUN=dataForm,value=2)
w<-NULL

trainData<-plyr::rename(trainData,replace=c("subject_train"="subject", "y_train"="activity"))
#x <- rename(x, replace=c("d" = "c"))
testData<-plyr::rename(testData,replace=c("subject_test"="subject", "y_test"="activity"))
completeData<-rbind(trainData,testData)
completeData<-transform(completeData,activity=as.factor(activity))
levels(completeData$activity)<-c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')
completeData<-arrange(completeData,subject)
aggy <- aggregate(completeData,by = list(completeData$subject, completeData$activity), FUN = mean)
write.table(aggy,file="./data/TideySet.txt",row.names = F)
