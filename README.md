# Coursera_Project
Final project for the Coursera Getting and Cleaning data course



This is the course project for the Getting and Cleaning data Coursera course. Included is the The run_analysis.r code that does the following:
1) Downloads the dataset if it doesn't already exist in the directory.
2) Reads the subject and activity information, and the test and training datasets
3) Subsets the test and training datasets to only include variables that have standard deviation or mean information.
4) Merges the activity and subject columns for each dataset.
5) Merges the test and training datasets together
6) Transforms the subject and activity columns into factor variables.
7) Creates a tidy dataset that contains the mean value of each varibale for each combination of subject and activity.
8) writes the file into the working directory (tidy.txt)

