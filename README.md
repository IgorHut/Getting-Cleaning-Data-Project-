# Getting and Cleaning Data on Coursera Project 

by Igor Hut

Repo for submission of the course project for Coursera (Johns Hopkins) Getting and Cleaning Data course.

### Overview
The purpose of this project is to demonstrate the students ability to collect, work with, and clean a data set.
The final goal is to prepare tidy data that which can be used for subsequent analysis. 

Initial data set used for this project and its full description can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can, also, be found here. This is the URL used in the submitted script 'run_analysis.R']
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


### Outline of the project
These are the instructions on which the project is based.

You are asked to create a R script called run_analysis.R which performs the following steps. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Imortant when running the script

You should take care that all the data is present in the same folder, un-compressed and without names altered. The script `run_analysis.R` contains all the code needed to perform the operations described in the 5 steps above. 
The code is thoroughly commented, so I hope you won't have any problems to understand and follow its execution.
The final output of the script is the text file 'tidy_avg_act_sub.txt'.

### Code book

All the info re  the resulting data fields in tidy_avg_act_sub.txt can be found in `CodeBook.md`. 
