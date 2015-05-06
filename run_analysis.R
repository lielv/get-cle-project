## downloading and extracting

if (!file.exists("data")){
        dir.create("data")
}
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile=".\\data\\dataset_project.zip")
unzip (".\\data\\dataset_project.zip", exdir = ".\\data")

x_train<-read.table(".\\data\\UCI HAR Dataset\\train\\X_train.txt")
y_train<-read.table(".\\data\\UCI HAR Dataset\\train\\y_train.txt")
x_test<-read.table(".\\data\\UCI HAR Dataset\\test\\X_test.txt")
y_test<-read.table(".\\data\\UCI HAR Dataset\\test\\y_test.txt")

features<-read.table(".\\data\\UCI HAR Dataset\\features.txt")
names(features)<-c("features_id","features_name")

activity_labels<-read.table(".\\data\\UCI HAR Dataset\\activity_labels.txt")
names(activity_labels)<-c("id","activity")

subject_train<-read.table(".\\data\\UCI HAR Dataset\\train\\subject_train.txt")
subject_test<-read.table(".\\data\\UCI HAR Dataset\\test\\subject_test.txt")

# (1) merge data
x<-rbind(x_train,x_test)
names(x)<-features$features_name
y<-rbind(y_train,y_test)
names(y)<-"id"
subject<-rbind(subject_train,subject_test)
names(subject)<-"subject_id"


# (2) extract only "mean" and "standard deviation" measurements
#note - I exclude measurements with meanFreq because we asked to take only 2 measurements
#       for each measurement (also the angles - they are not mean or std measurements)
inds<-grep("mean\\(\\)|std\\(\\)",names(x),ignore.case=T)
x_ms<-x[,inds]

## (3)  naming the activities in the data set
y$ord<-1:dim(y)[1]
y_named<-merge(y,activity_labels,by.x="id",by.y="id",all=F)

#sorting y back after the shuffle that "merge" did
require(dplyr)
y_named<-arrange(y_named,ord)

## (4) labelling the data set through "features"
#already labeled (look at names(x)<-features$features_name)

## (5) aggragating the average measurements by activity and subject
table<-aggregate(x=x_ms,by=list(y_named$activity,subject$subject_id),FUN=mean)
names(table)[1:2]<-c("Activity","Subject_id")
#order by the activity and then the subject
table<-arrange(table,Activity,Subject_id)

#writing the table with tab as separator to get nicer look
write.table(table,file=".\\data\\get_data_project.txt",row.names=F, sep="\t")
