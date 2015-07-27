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
      if(value==1)
            testData<<-cbind(testData,read.table(paste("./data/accelerometer/",dataSet[2],sep=""),sep="\n",colClasses = "numeric",col.names=gsub('_test', '',dataSet[1])))
      else if(value==2)
            trainData<<-cbind(trainData,read.table(paste("./data/accelerometer/",dataSet[2],sep=""),sep="\n",colClasses = "numeric",col.names=gsub('_train', '',dataSet[1])))
}
#reshapeData<-function(dataSet){
 #     reshape(mergedData,direction="long", idvar="subject_train",varying=list(dataSet,gsub("train",replacement = "test",dataSet,fixed=T)))
#}

#downloading the file and unziping it
Fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!exists("./data/accelerometer.zip")){
      download.file(Fileurl,method="curl",destfile = "./data/accelerometer.zip")
      if(!exists("./data/accelerometer"))
            unzip(zipfile="./data/accelerometer.zip",exdir="./data/accelerometer")
}
#extracting the data from the files into data frames
#extracting the names of the files and forming a table for easier use
filesTestData<-list.files('./data/accelerometer',recursive = T,pattern=c("test"))
filesTestData<-filesTestData[(length(filesTestData)-2):length(filesTestData)]
filesTrainData<-list.files('./data/accelerometer',recursive = T,pattern=c("train"))
filesTrainData<-filesTrainData[(length(filesTrainData)-2):length(filesTrainData)]
testNames<-unlist(lapply(filesTestData, nameExtract))
trainNames<-unlist(lapply(filesTrainData, nameExtract))
combinedTest<-cbind(testNames,filesTestData)
combinedTrain<-cbind(trainNames,filesTrainData)
#Extracting the files common to both test and train data sets
commonFiles<-list.files('./data/accelerometer',recursive = T,pattern=c("txt"))
featureNameFile<-read.table(commonFiles[grep("features.txt",commonFiles)],sep="",col.names=c("index","feature"),colClasses = "character")
labelsNameFile<-read.table(commonFiles[grep("labels",commonFiles)],sep="",col.names=c("index","labels"),colClasses = "character")
#creating  data.frame with first value because we cannot append columns to an empty data frames
testData<-read.table(paste("./data/accelerometer/",combinedTest[,2][combinedTest[,1]=="X_test"] ,sep=""),sep="",header=F)# sep="" means any length of space
trainData<-read.table(paste("./data/accelerometer/",combinedTrain[,2][combinedTrain[,1]=="X_train"] ,sep=""),sep="",header = F)# sep="" means any length of space

#cleaning the names of features before assigning
featureNameFile$feature = gsub('-mean', 'Mean', featureNameFile$feature)  # Replace `-mean' by `Mean'
featureNameFile$feature = gsub('-std', 'Std', featureNameFile$feature) # Replace `-std' by 'Std'
featureNameFile$feature = gsub('[-()]', '', featureNameFile$feature) # Remove the parenthesis and dashes

temp<-grep("Mean|Std",featureNameFile$feature)

#substituting the names
setnames(testData,featureNameFile$feature)
setnames(trainData,featureNameFile$feature)
testData<-testData[temp]
trainData<-trainData[temp]
#adding the other files containing subject and activity to the dataframe
w<-apply(combinedTest[2:nrow(combinedTest),],1,FUN=dataForm,value=1)
w<-apply(combinedTrain[2:nrow(combinedTrain),],1,FUN=dataForm,value=2)
w<-NULL

completeData<-rbind(trainData,testData)

MeanDATA <- ddply(completeData, .(subject, y), function(x) colMeans(x[,1:(ncol(completeData)-2)]))
MeanDATA<-transform(MeanDATA,y=as.factor(y))
levels(MeanDATA$y)<-c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')
write.table(MeanDATA,file="./R_Project/TidyDataSet.txt",row.names = F)
