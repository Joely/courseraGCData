courseraGCData
==============

Repo for Getting and Cleanng Data coure in Cousera Daa Science stream


The code in file run_analysis.R
- Reads in the six relevant files (two subject files, two X files and two y files)

- Combines the two subject datasets
- Combines the two train datasets
- Combines the two test datasets

- Adds relevant names to each variable. For the vaiables in X the code retrives the vaiabe names from the file "features.txt"

- combines subject dataset, y dataset and X dataset

- Adds new column to give human readable version of activity code (eg. 1 = Walking). These values are retrieved from "activity_labels.txt"

- Selects a subset of data, icluding columns for subject ID, activity ID, activity name and any value coumn with the text "mean()" or "std()" in it

- Creates a tidy dataset, calculating the mean of each variable for each combination of activity and subject

- Exports the tidy dataset to "tidyData.txt"