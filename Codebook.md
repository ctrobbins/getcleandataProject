---
title: "Codebook"
author: "Chris Robbins"
date: "Sunday, March 22, 2015"
output: html_document
---

## This Codebook describes the code in the "run_analysis.R" file.

### BASIC STRUCTURE
#### 2 Functions
#### - download.data() - This function downloads the UCI HAR Dataset from the web (a zip file), then unzips it into the current working directory.
#### - run.analysis() - This function takes select datasets within the UCI HAR Dataset, combines them, adds and cleans up column headings, and creates a final tidy dataset.

### download.data() function variables and function
* *url* - variable to hold the web URL for the download source
* *file* - variable to hold file name of local saved file downloaded from URL above
* function - the download.file(url, file) function is used to download the file and save it into the current working directory.
* The unzip(file) function is used to unzip the downloaded zip file into the current working directory. This particular zip file creates a "UCI HAR Dataset" subdirectory within which all the data files are stored.

### run.analysis() function variables
* *ftrs* - data table into which "features.txt" data is loaded. This table contains a list of all 561 variables measured in the experiment and stored in the X_train and X_test files.
* *cpos* - list containing the position locations in "ftrs" where the text contains either "mean" or "std". This identifies and narrows the full list of features to the ones desired for this analysis (79 variables)
* *subtrain* - a list into which the "subject_train.txt" data is loaded. Each row contains the id of the participants (subjects) who was involved with that particular set of data. It ranges from 1-30.
* *ytrain* - a list into which the "y_train.txt" data is loaded. Each row contains the id of the activity performed for that particular subject/data set. It ranges from 1-6.
* *xtrain* - a list into which the "X_train.txt" data is loaded. Each row contains the data measurements for all 561 features measured for that subject/activity combination.
* *subtest*, *ytest*, and *xtest* are the same as above, but load the "subject_test.txt", "y_test.txt", and "X_test.txt" data respectively.
* *dataraw* - a data table into which the subtrain, ytrain, xtrain, subtest, ytest, and xtest are combined.
+ Each row of the dataraw table contains the subject id, activity id, followed by the measurements of the 79 variables selected
* *activityLabels* - a list into which the "activity_labels.txt" data is loaded. Each row contains the activity number and corresponding activity name.
* *g* - intermediate table containing dataraw data grouped by activity and then subject
* *datafinal* - a data table containing the summarized tidy dataset in which each of the 79 variables is grouped by and averaged for each activity and subject combination
* *names* - a list containing the column names in the datafinal table which is then used to clean up the column names.

### run.analysis() function flow
#### print statements are used throughout function to provide visual progress indicator during processing
1. Change working directory to be within "UCI HAR Dataset" subdirectory
2. Read features.txt into ftrs
3. Find positions of "mean" or "std" in ftrs and assign to cpos
4. Read "subject_train.txt" into subtrain and rename column to "subject"
5. Read "y_train.txt" into ytrain and rename column to "activity"
6. Read "X_train.txt" into xtrain and then redefine xtrain to only include "cpos" columns
7. Repeat steps 3-5 above for test data sets (ie. y_test.txt, ytest)
8. Combine xtrain and xtest tables into single "dataraw" table with xtrain rows first, followed by xtest  9. Add column names to dataraw from selected column names in ftrs using cpos positions
10. Add subject and activity train and test data (subtrain, ytrain, subtest, ytest) to dataraw
11. Add column names "subject" and "activity" to first 2 columns of dataraw
12. Read "activity_labels.txt" into activityLabels
13. Loop through all activities and replace activity number with activity name in dataraw table
14. Factor subject and activity columns to reflect these columns contain factor data
15. Create data table "g" containing dataraw data grouped by activity and subject
16. Create "datafinal" table using "g" above and the mean of each variable column
17. Create "names" list containing column names in datafinal
18. Clean up list of names by replacing mean with Mean, std with Std, removing parenthesis and dashes, and replacing "BodyBody" with "Body"
19. Re-assign column names in datafinal to cleaned up names
20. Change working directory to be outside "UCI HAR Dataset" subdirectory
21. Write csv files for both datafinal and dataraw tables