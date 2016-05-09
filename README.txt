This repository contains code to fullfill the requirments for the "Getting and Cleaning Data" class on Coursera.

The original data "UCI HAR Dataset" is the folder I downloaded and extracted from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R is an R script which collects the data from the test and train folders, and organizes it into a tidy dataset (the data in the "Inertial Signals" folder is not used, but is included). The activity labels (origingally numbers) are changed to descriptive names (walking, lying, etc)

After running the script from the top level of the "UCI HAR Dataset" folder, you will be left with two data frames:
fulldata is a dataframe containing all 561 features (described in the codebook.txt) in tidy form
meanzdf is a dataframe containing the means for each combination of subjectID (1-3), group (test or train), and activity (six different activities)