library(dplyr)

download.data <- function () {
  url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  file = "UCI HAR Dataset.zip"
  download.file(url,destfile=file)
  unzip(file)
}

run.analysis <- function() {
  ##set working directory equal to extracted zip file directory from download.data function
  setwd("./UCI HAR Dataset")
  
  print("identifying columns with mean or std in column name")
  ## Read in features table and find where "mean" or "std" exist
  ## Find all cases of mean excluding last 7 columns with "Mean" as no data exists
  ftrs <- read.table("features.txt")
  cpos <- grep("mean|std",ftrs$V2)

## Read Training Data
  print("reading training subject table")
  ## Read list of subjects (30 total subjects) and rename column to "subject"
  subtrain <- read.table("./train/subject_train.txt")
  subtrain <- rename(subtrain,subject=V1)

  print("reading training activity table")
  ## Read list of activitys (6 activities) and rename column to "activity"
  ytrain <- read.table("./train/y_train.txt")
  ytrain <- rename(ytrain,activity=V1)

  print("reading training dataset")
  ## Read primary dataset and select only columns that have "mean" or "std"
  xtrain <- read.table("./train/X_train.txt")
  xtrain <- select(xtrain,cpos)
## End Read of Training Data

## Read Test Data
  ## Repeat above 3 data reads for test data sets
  print("reading test subject table")
  subtest <- read.table("./test/subject_test.txt")
  subtest <- rename(subtest,subject=V1)

  print("reading test activity table")
  ytest <- read.table("./test/y_test.txt")
  ytest <- rename(ytest,activity=V1)

  print("reading test dataset")
  xtest <- read.table("./test/X_test.txt")
  xtest <- select(xtest,cpos)
## End Read of Test Data

  print("combining training tables into single table")
  ## create raw data file by row and column binding the various datasets

  ## combine X train and test datasets
  dataraw <- rbind(xtrain,xtest)
  ## add column names
  colnames(dataraw) <- ftrs[cpos,2]
  
  ## combine subject and y train and test datasets with X datasets
  dataraw <- cbind(rbind(subtrain,subtest),rbind(ytrain,ytest),dataraw)

  ## rename columns for subject and activity
  names(dataraw)[1:2] <- c("subject","activity")

  print("replacing activity numbers with name")
  ## replace activity numbers with corresponding activity name
  activityLabels <- read.table("activity_labels.txt")
  for(i in 1:nrow(activityLabels)) {
    dataraw$activity[dataraw$activity == i] <- as.character(activityLabels[i,2])
  }

  ## factorize subject and activity columns
  factor(dataraw$subject)
  factor(dataraw$activity)

  ## create tidy dataset with average of each variable, grouped by activity/subject
  g <- group_by(dataraw, activity, subject)
  datafinal <- summarise_each(g, funs(mean))
  
  ## Cleanup column names in tidy dataset (datafinal)
  names <- names(datafinal)
  names <- gsub("[-]mean","Mean",names) ## Replace -mean with Mean
  names <- gsub("[-]std","Std",names) ## Replace -std with Std
  names <- gsub("[()-]","",names) ## Remove the parenthesis and dash
  names <- gsub("BodyBody","Body",names)  ## Replace BodyBody with Body
  names(datafinal) <- names
  
  ## write raw data and tidy dataset files back
  setwd("..")
  write.csv(dataraw, file="dataraw.txt", row.names=FALSE, quote=FALSE)
  write.csv(datafinal, file="datafinal.txt", row.names=FALSE, quote=FALSE)
  
  print("Finished. Two files (dataraw.txt and datafinal.txt) saved in csv format.")
}
