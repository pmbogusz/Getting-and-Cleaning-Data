## Getting-and-Cleaning-Data

* Coursera Getting and Cleaning Data: Peer Assessments 

This project is a part of Coursera course "Getting and Cleaning Data" - Peer Assessments for week3

* Description of the oryginal experiment - source of data

Human Activity Recognition Using Smartphones Dataset

All information aobut data set in file: experiment_readme.txt
https://github.com/pmbogusz/Getting-and-Cleaning-Data/blob/master/experiment_readme.txt

## How script works

* instalation of necessery package "reshape2", loading package and setting working directory to Samsung data directory (if needed,  this line is commented)
* File with activity names and file with features (variables) names are loaded into R in to "activity" and "features" dataframes.
* Variables names are cleaned  - replace  "-" with  "." according to the syntax rules
* Files with activity codes data are loaded into R to " y_test" and " y_train" and new column "activity.name" with proper activity name using "activity" table id added 
* Sensors data are imported from files into R to " x_test" and " x_train" dataframes and columns in both sensors data tables are renamed using "features" table 
* Subjects tables with subjects codes are loaded into R in to " subject_test"  and " subject_train " dataframes
* Optional step ( but IMHO useful) adding column "session" with values  "test" for "subject_test" dataframe and "train" for "subject_train" dataframe -  his way you can keep information about origin of data (that would be lost after melting)
* Binding  information columns (subject_test, y_test) or  (subject_train, y_train) with sensor data columns (x_test) or (x_ train)
* Creating big data set by binding "test" and "training" tables
* Subsetting data by choosing column of interests, first creating vector with columns names and creating "data.small", a subset with columns of interest - first two variables describing subject and activity and all column with  name including  ".mean()" or ".std()" - for mean and standard deviation.
* creating a second independent tidy data set "data.mean " with the average of each variable for each activity and each subject by first  melting the data set using first two column in to "data.melt" and then casting data in to "data.mean" using two variables and "mean" function
* saving data to CSV file named "data_mean.txt"



## Codebook
codebook is in  CodeBook.md file
https://github.com/pmbogusz/Getting-and-Cleaning-Data/blob/master/CodeBook.md
