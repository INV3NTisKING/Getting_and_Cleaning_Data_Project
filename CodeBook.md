==========================================
Getting and Cleaning Data Project Overview
==========================================

# 1. Merge the training and test sets to create one data set.

setwd() was used to set up a directory followed by an if statement to create a file, if not already existing, followed by setwd() to reset the file path. 

Next, a fileUrl <- was created to carry out downloading the zip file from the website using download.file(). I unpacked the download using unzip().

I then loaded the following .txt files into R, which came from unzipping the downloaded file. 
- "X_train.txt"
- "train.txt"
- "subject_train.txt""
- "X_test.txt""
- "y_test.txt""
- "subject_test.txt""
- "activity_labels.txt""
- "features.txt"

Lastly I merged the "train" data using cbind() and the "test" data usnig cbind(). Then used rbind() to merge the binded "train" and "test" datas. 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

To set up "final_data <-" grep() was used to extract the "mean" and "std", followed by setting the column names. 

# 3. Use descriptive activity names to name the activities in the data set

Next I used factors() replacing numbers, which referenced a specific activity name, with that name.

# 4. Appropriately label the data set with descriptive variable names.

Next I cleaned up the titles in accordance to our lectures using gsub(). Also used tolower() to make sure everything was lower cased.

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To calculate the means of the activities I used the dplyr package. This allowed me use group_by() to group the variables with the activities then summarise them cleanly using summarise_each().
            
Lastly write.table() was use to create my "Clean_Mean_Data.txt", minus the row name as they were unnecessary.   
           

=================
Data Dictionary
=================

Activity Names

- 1.WALKING
- 2.WALKING_UPSTAIRS
- 3.WALKING_DOWNSTAIRS
- 4.SITTING
- 5.STANDING
- 6.LAYING


Variables of each feature vector

'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- 1.timebodyaccelerometer XYZ
- 2.timegravityacclerometer XYZ
- 3.timeBodyacclerometerjerk XYZ
- 4.timeBodygyroscopeXYZ
- 5.timeBodygyroscopejerk XYZ
- 6.timeBodyacclerometermagnitude 
- 7.timeGravityacclerometermagnitude 
- 8.timeBodyacclerometerjerkmagnitude 
- 9.timeBodygyroscopemagnitude 
- 10.timeBodygyroscopejerkmagnitude 
- 11.frequencybodyacclerometer XYZ
- 12.frequencybodyacclerometerjerk XYZ
- 13.frequencybodygyroscope XYZ
- 14.frequencybodyacclerometermagnitude 
- 15.frequencybodyacclerometerjerkmagnitude 
- 16.frequencybodygyroscopemagnitude 
- 17.frequencybodygyroscopejerkmagnitude 


The set of variables that were estimated from these signals are: 

- 1.mean: Mean value
- 2.std: Standard deviation

