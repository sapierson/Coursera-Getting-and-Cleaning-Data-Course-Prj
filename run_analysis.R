# Program Name: run_analysis.R
# Author: Shawne A. Pierson
# Date: February 17, 2017
#
# The purpose of this program is to demonstrate my ability to collect, work with, and clean a data set.
# The goal is to prepare tidy data that can be used for later analysis. I will be graded by my peers on a
# series of yes/no questions related to the project. I am required to submit the following:
#
# 1) a tidy data set as described below
# 2) a link to a Github repository with my script for performing the analysis
# 3) a code book that describes the variables, the data, and any transformations or work that I performed
#    to clean up the data called CodeBook.md.
#
# I should also include a README.md in the repo with my scripts.
#
# Execution steps:
#
# 1. Download required files if they do not exist.
# 2. Merge the training and the test sets to create one data set.
# 3. Extract only the measurements on the mean and standard deviation for each measurement. 
# 4. Use descriptive activity names to name the activities in the data set.
# 5. Appropriately label the data set with descriptive variable names. 
# 6. From the data set in step 4, I create a second, independent tidy data set entitled "tidy_data.txt", with the
#    average of each variable for each subject and activity.


    # Clean up workspace
    rm(list=ls())

    library(RCurl)
    library(plyr)
    
    # Setup working directory and data directory
    main_dir <- "C:/Users/maxim/Documents/Coursera/Getting and Cleansing Data/Course Project/Coursera-Getting-and-Cleaning-Data-Course-Prj"
    sub_dir <- "data"
    work_dir <- "UCI HAR Dataset"
    tidy_dataFilename <- c("tidy_data.txt")
    targetFileName <- c("./get_metrics_dataset.zip")                            # Download file name
    
    # Check for the existance of the data directory.  If the directory does not exist, then create it!
    if (file.exists(sub_dir)){
        setwd(file.path(main_dir, sub_dir))
    } else {
        dir.create(file.path(main_dir, sub_dir))
        setwd(file.path(main_dir, sub_dir))
        
    }
    
    # Check for the existance of our targetFilename
    if (!file.exists(targetFileName)) {
        
        # Setup download variables
        fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileurl, destfile <- targetFileName)
        
        ddfile <- c("get_metrics_dataset.zip_dd.txt")                              # Download date file
    
        # write download date file for tracking purposes
        fileConn <- file(ddfile)
        writeLines(date(), fileConn)
        close(fileConn)
        
        # If our "UCI HAR Dataset" directory does not exist, then unzip the targetFileName
        if (!file.exists(work_dir)) {
            unzip(targetFileName)
        }
    }
    
    # Set current directory to extracted data folder
    setwd(file.path(paste0(main_dir, "/", sub_dir), work_dir))
    
    
    # Read training data into a data.frame
    #
    x_train <- read.table("./train/X_train.txt")
    y_train <- read.table("./train/Y_train.txt")
    subject_train <- read.table("./train/subject_train.txt")
    
    # Read testing data into a data.frame
    #
    x_test <- read.table("./test/X_test.txt")
    y_test <- read.table("./test/Y_test.txt")
    subject_test <- read.table("./test/subject_test.txt")
    
    # Merge the data.frame information
    #
    
    x_df <- rbind(x_train, x_test)
    y_df <- rbind(y_train, y_test)
    subject_df <- rbind(subject_train, subject_test)
    
    
    # Load activity labels and features
    #
    activity_labels <- read.table("./activity_labels.txt")
    activity_labels[,2] <- as.character(activity_labels[,2])
    features <- read.table("./features.txt")
    features[,2] <- as.character(features[,2])
    
    # Extract only the information needed based upon mean and std
    #
    
    required_features <- grep("-(mean|std)\\(\\)", features[, 2])
    
    # tidy -mean, -std, to 'Mean' and 'Std'
    #
    
    features[,2] <- gsub('-mean', 'Mean', features[,2])
    features[,2] <- gsub('-std', 'Std', features[,2])
    features[,2] <- gsub('[-()]', '', features[,2])
    
    x_df <- x_df[, required_features]
    y_df[, 1] <- activity_labels[y_df[, 1], 2]
    
    # Fix the column names
    names(x_df) <- features[required_features, 2]
    names(y_df) <- c("Activity")
    names(subject_df) <- c("SubjectID")
    
    # Combine all metrics into a single
    full_data_metrics <- cbind(subject_df, y_df, x_df)
    
    # Generate tidy_data data.frame spliting the full_data_metrics by SubjectID and Activity, executing an inline function for colMeans
    # against columns 3 through 68.
    tidy_data <- ddply(full_data_metrics, .(SubjectID, Activity), function(x) colMeans(x[, 3:68]))
    tidy_data <- tidy_data[order(tidy_data$SubjectID, tidy_data$Activity),]
    
    # Set working directory back to main_dir
    setwd(main_dir)

    # Now write the tiny_data file.
    #
    write.table(tidy_data, file = tidy_dataFilename, row.names = FALSE)
    
