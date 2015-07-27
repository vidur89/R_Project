#CODE BOOK
##Variable Names
filesTestData: stores a list of files containing the data linked to test cases
filesTrainData: stores a list of files containing the data linked to train cases
temp: It is the split up list based on the "."
ans: saves the extracted names of the files present in the filesTrainData variable
testNames: saves the extracted names from the ans variable
trainNames: saves the extracted names from the ans variable
combinedTest: Stores a data set of file names that will be used in the final dataset and their original file names that would be used to extract the data.
combinedTrain: Stores a data set of file names that will be used in the final dataset and their original file names that would be used to extract the data.
commonFiles: stores the extracted names of the files used by both test and train data,ie. the activity name and features.
featureNameFile: the extracted names of the files used by both test and train data,ie.features
labelsNameFile: the extracted names of the files used by both test and train data,ie. the activity name
testData: Stores the dataframe containing the mean values of the raw sensor reading for  test combned with their subject and activity name
trainData:  Stores the dataframe containing the mean values of the raw sensor reading for train combned with their subject and activity name
completeData: Stores the merged data from the raw sensor reading combned with their subject and activity name for both test and train case
MeanDATA: THe final tidy outcome as expected.
