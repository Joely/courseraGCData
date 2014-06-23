#read in datasets from locally saved files
train_subject<-read.table("UCI-HAR/train/subject_train.txt")
train_x<-read.table("UCI-HAR/train/X_train.txt")
train_y<-read.table("UCI-HAR/train/y_train.txt")

test_subject<-read.table("UCI-HAR/test/subject_test.txt")
test_x<-read.table("UCI-HAR/test/X_test.txt")
test_y<-read.table("UCI-HAR/test/y_test.txt")

#combine training and test datasets
combined_subject<-rbind(train_subject,test_subject)
combined_x<-rbind(train_x,test_x)
combined_y<-rbind(train_y,test_y)

#Add variable name to Subject data
names(combined_subject)<-"subjectNumber"

#add variable names to X data
  #Read feature names in from text file
features_list<-read.table("UCI-HAR/features.txt")
  #Assign features to column names of X data (column 2 holds the feature names, column one is just a count)
names(combined_x)<-features_list[,2]

#Add variable name to Y
names(combined_y)<-"activityCode"

#combine y value with the X dataset - i.e. add the activity type in a new column on right had side of existing data in X
all_data<-cbind(combined_subject, combined_y, combined_x)

#Add human readable activity names to the dataset
  #Read activity labels in from text file
activities<-read.table("UCI-HAR/activity_labels.txt",  col.names=c("activityCode","activityName"))
  #Merge 'all_data' with activities list, effectively adding a new column with a human readable value equivalent to current numerical value
  #merge would match on activityCode automaticaly, but I do it explicitly for readability and to avoid accidents
all_data<-merge(activities, all_data[,], by.x = "activityCode", by.y = "activityCode", sort=FALSE)

#Select subset of columns
#get activity column numbers
activity_columns<-c(which(colnames(all_data)=="activityCode"),which(colnames(all_data)=="activityName"))

#get subject_number column number
subject_column<-which(colnames(all_data)=="subjectNumber")

#Extract data that is related to either Mean or Standard Deviation
#find Fields with text "std" or "mean" in them
std_columns<-grep("std",names(all_data), ignore.case=TRUE)
mean_columns<-grep("mean",names(all_data), ignore.case=TRUE)

#Combine to get a sorted unique list of all column numbers to keep
keep_columns <- sort(unique(c(activity_columns, subject_column, mean_columns,std_columns)))

#create subset datset using columns selected above
subset_data <- all_data[,keep_columns]

#create summary/tidy dataset, calculating the mean for every value for each combination of activity and subject
subset_summary<-aggregate(subset_data[,4:ncol(subset_data)], by=list(subset_data$activityName, subset_data$subjectNumber), mean)

#label activity and subject headings in summary/tidy dataset
names(subset_summary)[1:2]<-c("activityName", "subjectNumber")

#Export summary/tidy dataset to text file in UCI-HAR directory
write.table(subset_summary, "UCI-HAR/tidyData.txt", sep = " ")