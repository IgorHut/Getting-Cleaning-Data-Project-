# Initial steps
#######################################################################################################################

# Package "plyr" will be nedeed, so we will load it at the begiging

library('plyr')


# Create the "data" directory, if needed, and download Human Activity Recognition Using Smartphones Data Set 
# from the UC Irvine Machine Learning Repository.

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/UCI_HAR_Dataset.zip",mode='wb') # mode shuld be set to "wb" as .zip is a binary format, if you use mac or work on linux system add method="curl" 

# The dataset file can be unziped manualy or as follows
unzip(zipfile="./data/UCI_HAR_Dataset.zip",exdir="./data")

# All the data files now reside in the "UCI HAR Dataset" sub-directory, so will make our life easer by setting it as working directory
setwd("~/GitHub/Getting_Cleaning_Data_Project/data/UCI HAR Dataset")


# Read the raw data into variables 
###################################################################################################################

trainingSet <- read.table("./train/X_train.txt")
traingLabels <- read.table("./train/y_train.txt")

testSet <- read.table("./test/X_test.txt")
testLabels <- read.table("./test/y_test.txt")

subjectTrain <- read.table("./train/subject_train.txt")
subjectTest <- read.table("./test/subject_test.txt")


######################################################################################################################
# Step 1.
# Create the requested data set - first concatenate the data tables by rows, then concatenate by columns to get the data frame "dataSet" containing all the data we need. 
# Give the appropriate names to the variables.
######################################################################################################################
   
# Create data set with all features (train+test)
featuresData <- rbind(trainingSet, testSet)

# Create labels data set (train+test)
labelsData <- rbind(traingLabels, testLabels)

# Create 'subject' data set
subjectData <- rbind(subjectTrain, subjectTest)

# Give the appropriate names to the variables
names(subjectData)<-c("subject")
names(labelsData)<- c("activityType")
featuresNames <- read.table("features.txt")
names(featuresData)<- featuresNames$V2

# Concatenate by columns to get the data frame "dataSet" containing all the data we need
dataSet <- cbind(featuresData, subjectData, labelsData)


######################################################################################################################
# Step 2.
# Extract only the measurements on the mean and standard deviation for each measurement
######################################################################################################################

# Extract only columns with mean() or std() in their names
meanStdFeatures<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]


# Subseting the dataSet with adequate names
subNames<-c(as.character(meanStdFeatures), "subject", "activityType" )
dataSet<-subset(dataSet,select=subNames)

########################################################################################################################
# Step 3.
# Use descriptive activity names to name the activities in the data set
#########################################################################################################################

activityLabels <- read.table("activity_labels.txt")

dataSet$activityType<-activityLabels[dataSet$activityType,2]

#########################################################################################################################
# Step 4.
# Appropriately label the data set with descriptive variable names
##########################################################################################################################

names(dataSet)<-gsub("Acc", "Acceleration", names(dataSet))
names(dataSet)<-gsub("Gyro", "AngularSpeed", names(dataSet))
names(dataSet)<-gsub("Mag", "Magnitude", names(dataSet))
names(dataSet)<-gsub("BodyBody", "Body", names(dataSet))
names(dataSet)<-gsub("^t", "timeDomain", names(dataSet))
names(dataSet)<-gsub("^f", "frequencyDomain", names(dataSet))
names(dataSet)<-gsub('-mean', 'Mean', names(dataSet))
names(dataSet)<- gsub('-std', 'Std', names(dataSet))
names(dataSet) <- gsub('[-()]', '', names(dataSet))


###########################################################################################################################
# Step 5. 
# From the data set in step 4, create a second, independent tidy data set with the average of each variable for each 
# activity and each subject.
############################################################################################################################
tidyData = ddply(dataSet, c("subject","activityType"), numcolwise(mean))
write.table(tidyData, file = "tidy_avg_act_sub.txt",row.name=FALSE)



