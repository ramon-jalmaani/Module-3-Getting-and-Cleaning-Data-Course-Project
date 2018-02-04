#Preliminaries

setwd("C:/Users/user/Ramon/Module 3 Getting and Cleaning Data")

ls()
rm(list=ls())

#load dplyr package
library(dplyr)

#Use options(width=n) to read bigger tables
options(width=100)

#Downloading and storing data
#Creating Directory
if(!file.exists("./data"))	{
  dir.create("./data")
}
#Point and download zip
dataseturl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## change url accordingly
download.file(dataseturl, destfile="./data/ucihardata.zip") 
#unzip file
unzip("./data/ucihardata.zip", files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, exdir = 
        "ProgAssignmentW4data", unzip = "internal",setTimes = FALSE)

#Checking files
list.files("./ProgAssignmentW4data/UCI HAR Dataset", all.files = TRUE, full.names = FALSE)
list.files("./ProgAssignmentW4data/UCI HAR Dataset/test", all.files = TRUE, full.names = FALSE)
list.files("./ProgAssignmentW4data/UCI HAR Dataset/test/Inertial Signals", all.files = TRUE, full.names 
           = FALSE)
list.files("./ProgAssignmentW4data/UCI HAR Dataset/train", all.files = TRUE, full.names = FALSE)
list.files("./ProgAssignmentW4data/UCI HAR Dataset/train/Inertial Signals", all.files = TRUE, 
           full.names = FALSE)

#Setting directory to where dataset is located
setwd("C:/Users/user/Ramon/Module 3 Getting and Cleaning Data/ProgAssignmentW4data/UCI HAR Dataset")
list.files()

#Reading files

activity_labels <- read.table("activity_labels.txt", header = FALSE, quote="\"")
activity_labels

features <- read.table("features.txt", header = FALSE, quote="\"")
features

subject_test <- read.table("test/subject_test.txt", header = FALSE, quote="\"")
subject_test
x_test <- read.table("test/X_test.txt", header = FALSE, quote="\"")
x_test
y_test <- read.table("test/y_test.txt", header = FALSE, quote="\"")
y_test      

subject_train <- read.table("train/subject_train.txt", header = FALSE, quote="\"")
subject_train
x_train <- read.table("train/X_train.txt", header = FALSE, quote="\"")
x_train
y_train <- read.table("train/y_train.txt", header = FALSE, quote="\"")
y_train

#Analysis of test data

#Assigning variable names to activity_labels, except "V1"
colnames(activity_labels)<- c("V1","activity")
activity_labels

#Column binding subject_test and y_test into test 
testsubject <- rename(subject_test, subject=V1)
test <- cbind(y_test, testsubject)

#Merging activity_labels and test (i.e., subject_test and y_test) into test1
test1 <- merge(test, activity_labels, by=("V1"))

#Assigning names to x_test from features
colnames(x_test)<- features[,2]

#Combining test1 and x_test (i.e., combining y_test, activity labels, x_test)
test2 <- cbind(test1,x_test)

#Eliminating the first column from test2 (in compliance with using descriptive activity names), 
#as data for "V1" is already in descriptive (text) form under "activity"
test3 <- test2[,-1]

#Extracting measurements with mean and std only
test4 <- select(test3, contains("subject"), contains("activity"), contains("mean"), contains("std"))

#Analysis of train data

#Assigning variable names to activity_labels, except "V1"
colnames(activity_labels)<- c("V1","activity")
activity_labels

#Column binding subject_train and y_train into train 
trainsubject <- rename(subject_train, subject=V1)
train <- cbind(y_train, trainsubject)

#Merging activity_labels and train (i.e., subject_train and y_train) into train1
train1 <- merge(train, activity_labels, by=("V1"))

#Assigning names to x_train from features
colnames(x_train) <- features[,2]

#Combining train1 and x_train (i.e., combining y_train, activity labels, x_train)
train2 <- cbind(train1,x_train)

#Eliminating the first column from train2 (in compliance with using descriptive activity names), 
#as data for "V1" is already in descriptive (text) form under "activity"
train3 <- train2[,-1]

#Extracting measurements with mean and std only
train4 <- select(train3, contains("subject"), contains("activity"), contains("mean"), contains("std"))

#Rbinding test data and train data

combined_data <- rbind(test4, train4)

#Summarizing the combined datasets

run_analysis <- (combined_data%>%
                   group_by(subject,activity) %>%
                   summarise_all(funs(mean)))

print(run_analysis)

#Creating a second, independent tidy data set

write.table(run_analysis,"./run_analysis.txt",sep=" ",row.name=FALSE)