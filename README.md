# Module-3-Getting-and-Cleaning-Data-Course-Project
## Course Project for Module 3

## Objective of the Project Presentation
The presentation of this course project is geared towards the novices (like me) who have a need to see step-by-step procedures.

## Files on this Repo
1. README.md - provides a general overview on the objective of the course project and a brief description on the required script.
2. CodeBook.md - provides description and/or procedure of obtaining and storing data, checking files, setting directory, reading files, cleaning data, and creating new column names.
3. run_analysis.R - contains the script.
4. run_analysis.txt - contains the second, independent tidy data set.

## Procedure
The script, run_analysis.R, does the following below:

1. Provides preliminaries of setting working directory (i.e., change it to your working directory), clearing the global environment, loading dplyr package and setting ability to read bigger tables.
2. Downloads, stores, unzips the required datasets from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
3. Lists the datasets for an early look into the datasets.
4. Sets the working directory to where the datasets are stored (i.e., change it to your working directory where the datasets were stored).
5. Reads the test and train datasets.
6. Analyses both the test and train datasets and combining necessary variables.
7. Uses descriptive activity names from activity_labels.txt to name the activities in the data set.
8. Labels columns of the datasets with descriptive variable names from features.txt and assigning the labels "activity" and "subject" for the activity and subject columns.
9. Merges the test and train datasets, after the analyses, to create just one dataset for both.
10. Extracts only the measurements on the mean and standard deviation for each measurement in features.txt.
11. Builds the second, independent tidy data set, run_analysis.txt, which consists of the average of each variable for each activity and each subject.

To run the script:

To compile script, type source("run_analysis.R") then press enter.
To run the script, type run_analysis() then press enter.
