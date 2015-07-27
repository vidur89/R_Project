#CODE BOOK
=======================
##Variable Names<br /><br />
*1 - `filesTestData`:_ stores a list of files containing the data linked to test cases<br />
*2 - `filesTrainData`:_ stores a list of files containing the data linked to train cases<br />
*3 - `temp`:_ It is the split up list based on the "."<br />
*4 - `ans`:_ saves the extracted names of the files present in the filesTrainData variable<br />
*5 - `testNames`:_ saves the extracted names from the ans variable<br />
*6 - `trainNames`:_ saves the extracted names from the ans variable<br />
*7 - `combinedTest`:_ Stores a data set of file names that will be used in the final dataset and their original file names that would be used to extract the data.<br />
*8 - `combinedTrain`:_ Stores a data set of file names that will be used in the final dataset and their original file names that would be used to extract the data.<br />
*9 - `commonFiles`:_ stores the extracted names of the files used by both test and train data,ie. the activity name and features.<br />
*10 - `featureNameFile`:_ the extracted names of the files used by both test and train data,ie.features<br />
*11 - `labelsNameFile`:_ the extracted names of the files used by both test and train data,ie. the activity name<br />
*12 - `testData`:_ Stores the dataframe containing the mean values of the raw sensor reading for  test combned with their subject and activity name<br />
*13 - `trainData`:_  Stores the dataframe containing the mean values of the raw sensor reading for train combned with their subject and activity name<br />
*14 - `completeData`:_ Stores the merged data from the raw sensor reading combned with their subject and activity name for both test and train case<br />
*15 - `MeanDATA`:_ THe final tidy outcome as expected.<br /><br />

##Data Transformation<br />
*1 - Data is downloaded and read into and the memory using the `read.table()`<br />
*2 - The data is kept separated based on its type, ie. train and test.<br />
*3 - The names to be given to the data frame is stripped from the labels given and the file names using `grep()`<br />
*4 - `gsub()` function is used to tidy the column names by removing the unnecessary information from the feature names.<br />
*5 - We assign the names of the activity data set and subject data set  by merging the columns to the data containing the raw data reading from the sensor using `cbind()` function<br />
*6 - In the end we create a new tidy dataset with the averages for each variable (mean and std) for each acitvity and subject<br />
*7 - This `TidyDataSet.txt dataset` is uploaded to the repo <br />


