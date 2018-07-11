#link to the data on the web
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#downloads the data to the current working directory
download.file(dataURL, "./data.zip")

#unzips the file to the current directory
unzip("./data.zip")

#starts the dplyr package to work with the data more easily
library(dplyr)

#loads the test data into three data frames
test_activity <- read.table("./UCI Har Dataset/test/y_test.txt")
test_subject <- read.table("./UCI Har Dataset/test/subject_test.txt")
test_meas <- read.table("./UCI Har Dataset/test/X_test.txt")

#loads the train data into three data frames
train_activity <- read.table("./UCI Har Dataset/train/y_train.txt")
train_subject <- read.table("./UCI Har Dataset/train/subject_train.txt")
train_meas <- read.table("./UCI Har Dataset/train/X_train.txt")

#combines the test data and the train data into one table each
test_data <- cbind(test_subject, test_activity, test_meas)
train_data <- cbind(train_subject, train_activity, train_meas)

#merges the data sets into one data table using rbind
full_data <- rbind(test_data, train_data)

#indexes the mean and std columns from the train data set and adds 2 because I added two columns to the full set
index_vector <- 2 + c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)

#subsets the data to only include the subject, activity name, mean and std columns
sub_data <- full_data[,c(1,2,index_vector)]

#arranges the data by subject then by activity number
sub_data <- arrange(sub_data, sub_data[,1], sub_data[,2])

#vector containing the activity names
activity_name <- c("Walking", "Walking_Up", "Walking_Down", "Sitting", "Standing", "Laying")

#converts activity number in second column to activity name according to activity_name vector just specified
sub_data[,2] <- activity_name[sub_data[,2]]

#brings in the features.txt file so I can index the columns
measurement_names <- read.table("./UCI HAR Dataset/features.txt")

#subsets to just the column with the measurement names with the mean and std information
measurement_names <- as.character(measurement_names[index_vector-2,2])

#series of commands that convert the names into more readable titles
measurement_names <- tolower(measurement_names)
measurement_names <- sub("t", "time.", measurement_names)
measurement_names <- sub("f", "frequency.", measurement_names)
measurement_names <- gsub("-", ".", measurement_names)
measurement_names <- gsub("\\()", "", measurement_names)
#this next line is necessary because of the way I coded the first "sub" where the first instance of t is replaced
measurement_names <- sub("stime.d", "std", measurement_names)

#makes vector of all column names
column_names <- c("subject", "activity.name", measurement_names)

#names all the columns in the sub_data dataset
colnames(sub_data) <- column_names

#groups the data by subject and by activity yielding 180 groups
group_data <- group_by(sub_data, subject, activity.name)

#gets the mean of each variable in each group
means_data <- summarize_all(group_data, mean)

#writes the table to a file called tidydata.txt in the working directory
write.table(means_data, "./tidydata.txt", row.name=FALSE)