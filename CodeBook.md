# Code Book

This code book:

1. Provides and overview of the final Course Project for "Getting and Cleaning Data".
2. Summarizes the resulting data fields in "tidy_data.txt".

## Overview

### Source Data
A full description of the data used in this project is here [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project is here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Script Analysis

The R script, run_analysis.R does the following:

1. Downloads required files if they do not exist.
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set.
5. Appropriately labels the data set with descriptive variable names. 
6. From the data set in step 5, I create a second, independent tidy data set entitled "tidy_data.txt", with the average of each variable for each activity and each subject.

## Summary


* x_train, x_test, y_train, y_test, subject_train and subject_test contain all the train, test, and subject data from the downloaded file.
* merged the x_train and x_test data into x_df.
* merged the y_train and y_test data into y_df.
* merged the subject_train and subject_test data into subject_df.
* activity_labels contain the correct names for the y_df data.frame.
* features contain the correct names for the x_df data.frame.
* required_features contain a subset of filtered features of type 'means' and 'std'.
* tidy up column names of features correcting '-mean' with 'Mean', '-std' with 'STD'.
* corrected columns names for x_df, y_df, and subject_df.
* full_data_metrics contains merged by column values of subject_df, y_df, and x_df.
* created tidy_data data.frame using ddply of full_data_metrics, by SubjectID and Activity, executing an inline function for colMeans against columns 3 through 68.  This approach provides the means of the unique columns, by SubjectID, by Activity.
* sorted tidy_data by SubjectID and Activity.
* Last step. Generate tidy_data.txt from the tidy_data data.frame

### Identifiers

* "SubjectID" - The ID of the test subject.
* "Activity"  - The type of activity performed when the measurement was obtained.

### Measurements

* "tBodyAccMeanX"
* "tBodyAccMeanY"
* "tBodyAccMeanZ"
* "tBodyAccStdX"
* "tBodyAccStdY"
* "tBodyAccStdZ"
* "tGravityAccMeanX"
* "tGravityAccMeanY"
* "tGravityAccMeanZ"
* "tGravityAccStdX"
* "tGravityAccStdY"
* "tGravityAccStdZ"
* "tBodyAccJerkMeanX"
* "tBodyAccJerkMeanY"
* "tBodyAccJerkMeanZ"
* "tBodyAccJerkStdX"
* "tBodyAccJerkStdY"
* "tBodyAccJerkStdZ"
* "tBodyGyroMeanX"
* "tBodyGyroMeanY"
* "tBodyGyroMeanZ"
* "tBodyGyroStdX"
* "tBodyGyroStdY"
* "tBodyGyroStdZ"
* "tBodyGyroJerkMeanX"
* "tBodyGyroJerkMeanY"
* "tBodyGyroJerkMeanZ"
* "tBodyGyroJerkStdX"
* "tBodyGyroJerkStdY"
* "tBodyGyroJerkStdZ"
* "tBodyAccMagMean"
* "tBodyAccMagStd"
* "tGravityAccMagMean"
* "tGravityAccMagStd"
* "tBodyAccJerkMagMean"
* "tBodyAccJerkMagStd"
* "tBodyGyroMagMean"
* "tBodyGyroMagStd"
* "tBodyGyroJerkMagMean"
* "tBodyGyroJerkMagStd"
* "fBodyAccMeanX"
* "fBodyAccMeanY"
* "fBodyAccMeanZ"
* "fBodyAccStdX"
* "fBodyAccStdY"
* "fBodyAccStdZ"
* "fBodyAccMeanFreqX"
* "fBodyAccMeanFreqY"
* "fBodyAccMeanFreqZ"
* "fBodyAccJerkMeanX"
* "fBodyAccJerkMeanY"
* "fBodyAccJerkMeanZ"
* "fBodyAccJerkStdX"
* "fBodyAccJerkStdY"
* "fBodyAccJerkStdZ"
* "fBodyAccJerkMeanFreqX"
* "fBodyAccJerkMeanFreqY"
* "fBodyAccJerkMeanFreqZ"
* "fBodyGyroMeanX"
* "fBodyGyroMeanY"
* "fBodyGyroMeanZ"
* "fBodyGyroStdX"
* "fBodyGyroStdY"
* "fBodyGyroStdZ"
* "fBodyGyroMeanFreqX"
* "fBodyGyroMeanFreqY"
* "fBodyGyroMeanFreqZ"
* "fBodyAccMagMean"
* "fBodyAccMagStd"
* "fBodyAccMagMeanFreq"
* "fBodyBodyAccJerkMagMean"
* "fBodyBodyAccJerkMagStd"
* "fBodyBodyAccJerkMagMeanFreq"
* "fBodyBodyGyroMagMean"
* "fBodyBodyGyroMagStd"
* "fBodyBodyGyroMagMeanFreq"
* "fBodyBodyGyroJerkMagMean"
* "fBodyBodyGyroJerkMagStd"
* "fBodyBodyGyroJerkMagMeanFreq"

### Activity Labels

* "WALKING" (Value = "1"): The Subject was walking during the test.
* "WALKING_UPSTAIRS" (Value = "2"): The Subject was walking up a staircase during the test.
* "WALKING_DOWNSTAIRS" (Value = "3"): The Subject was walking down a staircase during the test.
* "SITTING" (Value = "4"): The Subject was sitting during the test.
* "STANDING" (Value = "5"): The Subject was standing during the test.
* "LAYING" (Value = "6"): Ths Subject was laying down during the test.

