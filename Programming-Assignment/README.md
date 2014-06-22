Repo for Getting and Cleaning Data Course Prog Assignment

This file describes how run_analysis.R script functions:

1.Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2.Rename the folder with "progassign". 

3.Extract the "run_analysis.R" script from the github to merging and clean the data set. 

4.Make sure the folder "progassign" and the "run_analysis.R" script are both in the current working directory. 

5.Use source("run_analysis.R") command in RStudio console to compile.

The run_analysis.R script will create the following two tidy files in the current working directory. tidy_data.txt: The file contains a data frame called cleaned_Data with 10299*68 dimension. tidy_data_with_means.txt: The file contains a data frame called result with 180*68 dimension.

Finally, use average_data <- read.table("average_data.txt") command in RStudio to read the file. As we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.

© Sridher Kaminani, 2014 All Rights reserved.
