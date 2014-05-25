#	Script for Coursera Getting and Cleaning Data: Peer Assessments
#	pmbogusz@gmail.com
#	https://github.com/pmbogusz/Getting-and-Cleaning-Data

#	Install package (if needed)
#install.packages("reshape2")

library(reshape2)

#	set working directory to Samsung data directory (if needed)
#setwd("D:/Coursera/12. Getting and Cleaning Data/Peer Assessments/UCI HAR Dataset")


#	Read file with activity names
activity  <- read.table("activity_labels.txt", header = F, col.names=c("no", "name"))

#	Read file with features (variables) names
features  <- read.table("features.txt", header = F, col.names=c("no", "name"))

#	Clean variables names - change "-" to "."
#	In this step one can also change all names to lowercase
features$name.good <- gsub("-", ".", features$name)

#	Read data tables with activity codes
y_test <- read.table("test/y_test.txt", header = F, col.names="activity")
y_train <- read.table("train/y_train.txt", header = F, col.names="activity") 

#	adding new column "activity.name" with proper activity name using "activity" table
y_test$activity.name <- activity[y_test$activity, 2]
y_train$activity.name <- activity[y_train$activity, 2]

#	Read sensors data - takes some time :-)
x_train <- read.table("train/X_train.txt", header = F) 
x_test <- read.table("test/X_test.txt", header = F) 

#	Renaming columns in both sensors data tables
names(x_test) <- features$name.good
names(x_train) <- features$name.good

#	Read subjects tables with subjects codes
subject_test <- read.table("test/subject_test.txt", header = F, col.names="subject") 
subject_train <- read.table("train/subject_train.txt", header = F, col.names="subject") 

#	Optional, but IMHO useful - adding column "session" with values  "test" and "train"
#	this way you can keep information about origin of data (that would be lost after melting)
subject_test$session <- "test"
subject_train$session <- "train"

#	Binding   information columns (subjects, activity) with sensor data columns
test <- cbind(subject_test,y_test, x_test)
train <- cbind(subject_train,y_train, x_train)

#	Crating big data set by binding test and training tables
data <- rbind(test, train)


#	Subsetting data by choosing column of interests
#	creating vector with columns names
data.column <- names(data)

#	creating "data.small", a subset with columns of interest:
#   "subject" and "activity.name"
#	all including in name ".mean()" or ".std()"
# 	double backslash makes brackets recognizable by grepl function
#	that way columns like "meanFreq()" are ruled out 
data.small <- cbind(data[, c(1,4)], data[, grepl(".mean\\(\\)", names(data)) | grepl(".std\\(\\)", names(data))])


#	creating a second independent tidy data set with the average of each variable for each activity and each subject

#	melting the data set usind first two column
data.melt <- melt(data.small, id=names(data.small)[c(1,2)])

#	casting data with two variables and "mean" function
data.mean <- dcast(data.melt, subject + activity.name ~ variable, mean, value.var="value")

#	saving data to CSV file 
write.csv(data.mean, file = "data_mean.txt")

#	job done :-)
 