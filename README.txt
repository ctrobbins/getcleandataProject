## OVERVIEW
## The purpose of this analysis is to develop a tidy dataset of a subset of data from the "Human Activity Recognition using Smartphone" dataset. This dataset was based on experiments with 30 volunteers doing 6 activities WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone on their waist. Accelerometer and gyroscopic data was captured by the phone. This site has more specific information about the experiment details: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This analysis results in a tidy dataset ("datafinal.csv") that, for each Activity and Subject (test participant), averages each of 79 different measures. These measures were a subset of the smartphone readings that were either the mean or standard deviation of the measured variables.

## USAGE
There are 2 primary functions within the run.analysis.R file.
To use do the following:
Copy run.analysis.R file into your local R working directory
In R type "Source('run.analysis.R')" to load the file
Note the file uses the dplyr package. This package will need to be installed via "install.packages('dplyr')" if not already installed in your local R instance.
Type "download.data()" to download the zipped data file and unzip it into a subdirectory of your working directory. Note the zip file is ~60 MB and may take several minutes depending on your internet speed.
Type "run.analysis()" to create the tiny dataset "datafinal.csv" in your working directory. The function will print out progress activities as it completes each step.
The intermediate file "dataraw.csv" is also saved to your working directory and contains the raw data before being grouped and averaged by Activity and Subject.

## ADDITIONAL INFORMATION
The "Codebook.md" file contains a detailed description of the "run.analysis.R" script.


