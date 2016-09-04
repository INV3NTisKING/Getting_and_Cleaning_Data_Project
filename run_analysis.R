# 1. Merge the training and test sets to create one data set.

## 1.a: setting up a directory and downloading the zip file from the website
setwd("~/r.PROJECTS/R_dir") 
if(!file.exists("./DSCourse_3_Assignment_1")) dir.create("./DSCourse_3_Assignment_1")
setwd("~/r.PROJECTS/R_dir/DSCourse_3_Assignment_1")
fileUrl <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(fileUrl, destfile = "projectData_getCleanData.zip")

## 1.b: unzip the data
unZip <- unzip("projectData_getCleanData.zip")

## 1.c: loading the data into R
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]

## 1.d: merge the "train" and "test" data
train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
all_Data <- rbind(train_data, test_data)
    
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

feature_extract <- grep(("mean\\(\\)|std\\(\\)"), features)
final_data <- all_Data[, c(1, 2, feature_extract+2)]
colnames(final_data) <- c("subject", "activity", features[feature_extract])
        
          
# 3. Use descriptive activity names to name the activities in the data set

final_data$activity <- factor(final_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
            
              
# 4. Appropriately label the data set with descriptive variable names.

names(final_data) <- gsub("\\()", "", names(final_data))
names(final_data) <- gsub("-X", "x", names(final_data))
names(final_data) <- gsub("-Y", "y", names(final_data))
names(final_data) <- gsub("-Z", "z", names(final_data))
names(final_data) <- gsub("fBodyBody", "frequencybody", names(final_data))
names(final_data) <- gsub("fBody", "frequencybody", names(final_data))
names(final_data) <- gsub("Acc", "accelerometer", names(final_data))
names(final_data) <- gsub("Gyro", "gyroscope", names(final_data))
names(final_data) <- gsub("Mag", "magnitude", names(final_data))
names(final_data) <- gsub("^t", "time", names(final_data))
names(final_data) <- gsub("-mean", "mean", names(final_data))
names(final_data) <- gsub("-std", "std", names(final_data))
names(final_data) <- tolower(names(final_data))
            
                
# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

clean_data <- final_data %>% group_by(subject, activity) %>% summarise_each(funs(mean))
            
write.table(clean_data, "Clean_Mean_Data.txt", row.names = FALSE)