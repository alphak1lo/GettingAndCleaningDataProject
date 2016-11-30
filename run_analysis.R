install.packages("reshape"); library(reshape)
install.packages("dplyr"); library(dplyr)

##set working directory. This will differ person-to-person
setwd("~/Personal/Coursera/Getting and Cleaning data/UCI HAR Dataset")



##1.Merge the train and test datasets

#LOAD
#bring in the test data:
subjtest <- read.table("./test/subject_test.txt")   ##testsubjects involved
xtest <- read.table("./test/X_test.txt")  ##test set
ytest <- read.table("./test/y_test.txt")  ##test labels

#bring in the train data:
subjtrain <- read.table("./train/subject_train.txt")   ##trainsubjects involved
xtrain <- read.table("./train/X_train.txt")  ##train set
ytrain <- read.table("./train/y_train.txt")  ##train labels

#bring in features txt. Prefix "t" denotes time, rather than "train" or "test"
features <- read.table("features.txt")
  ##get second column only:
features <- read.table("features.txt")[,2]  ##561 entries

#bring in the activity labels txt
actlabels <- read.table("./activity_labels.txt")
  ##actlabels <- rename(actlabels, key = V1, activitytype = V2)


#USE
##TEST
names(xtest) <- features #assign column names to xtest

##we want the subjtest in the first column, the testlabels in the second
##and the values for xtest in the remaining columns. Use cbind:
testall <- cbind(subjtest, ytest, xtest)
names(testall)[1] <- "subject"
names(testall)[2] <- "activity"

##TRAIN
names(xtrain) <- features #assign column names

##Again use cbind, and rename:
trainall <- cbind(subjtrain, ytrain, xtrain)
names(trainall)[1] <- "subject"
names(trainall)[2] <- "activity"

#Now, union the testall and trainall datasets together (rbind):
alldata <- rbind(testall, trainall)


##2.Measurements on the mean and standard deviation, for all measurements##
#features_info.txt tells us we want column names that contain "mean" or "std"
mfeatures <- grep("mean", features, value=TRUE)   ##mean fields
stdfeatures <- grep("std", features, value=TRUE)  ##std fields
mstdfeatures <- c(mfeatures, stdfeatures)         ##combine both

#choose these columns only, plus "subject" and "activity"
alldata <- alldata[,c("subject","activity",mstdfeatures)]


##3.Use descriptive activity names to name the activities in the dataset
  #ie, put activity names from "activity_labels.txt" into "activity" column
alldata$activity[alldata$activity == 1] <- "WALKING"
alldata$activity[alldata$activity == 2] <- "WALKING_UPSTAIRS"
alldata$activity[alldata$activity == 3] <- "WALKING_DOWNSTAIRS"
alldata$activity[alldata$activity == 4] <- "SITTING"
alldata$activity[alldata$activity == 5] <- "STANDING"
alldata$activity[alldata$activity == 6] <- "LAYING"


##4.Appropriately label the data set with descriptive names
  #already done. alldata[,1:2] and alldata[,563] were manually named
  #field names were taken from "features.txt" for all others


##5.creates a second, independent tidy data set with the average of each
##variable for each activity and each subject

#We want to group by subject and activity (and test/train), and then take the
#average of each column
group_subact <- group_by(alldata, subject, activity)
df <- summarize_each(group_subact, funs(mean))

##create a txt file
write.table(df, file = "mergeddata.txt", sep = "|", row.names = FALSE)