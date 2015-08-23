#read in data 

#Data downloaded and unzipped from the link: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

setwd("L:/justin.markunas/Desktop/Rprograms/Coursera/GettingandCleaningData/project")
train <- read.table("X_train.txt")  #read in training data (defaults are fine)
test <- read.table("X_test.txt")  #read in test data (defaults are fine)
measurements <- read.table("features.txt",stringsAsFactors = FALSE) #read in measurement names (header of data)
actTrain <- read.table("y_train.txt") #read in activity numbers for each training measurement
actTest <- read.table("y_test.txt")   #read in activity numbers for each test measurement
subjTrain <- read.table("subject_train.txt") #read in subject numbers from training data
subjTest <- read.table("subject_test.txt") #read in subject numbers from test data


#1. Merge the training and the test sets to create one data set
#Merge data and activities

total <- rbind(train, test) #vertically merge training and test data
actTotal <- rbind(actTrain,actTest) #vertically merge activities

#Add header to total, listing each type of measurement

names(total) <- measurements$V2   #places header across total
names(actTotal) <- c("ActivityNum") #Places header on activity type

#2. Extract only the measurements on the mean and standard deviation for each measurement. 

selected <- total[,grepl("[Mm]ean|[Ss]td", names(total))]  #reduces data to columns with either 'mean' or 'std in them
#includes both upper and lowercase instances

#3. Use descriptive activity names to name the activities in the data set.

actTotal$Activity<-c(0)   #add new column to dataframe containing the activity name
for (i in 1:10299) {
  if (actTotal[i,1]==1) {actTotal[i,2]="Walking"}
  else if (actTotal[i,1]==2) {actTotal[i,2]="Walking_Upstairs"}
  else if (actTotal[i,1]==3) {actTotal[i,2]="Walking_Downstairs"} #places descriptive names with each activity number
  else if (actTotal[i,1]==4) {actTotal[i,2]="Sitting"}
  else if (actTotal[i,1]==5) {actTotal[i,2]="Standing"}
  else if (actTotal[i,1]==6) {actTotal[i,2]="Laying"}
}
selected<- cbind(actTotal,selected) #adds the activity names to the beginning of the data frame


#4 Appropriately labeled the data set with descriptive variable names.

#This was taken care in Part 1 with the addition of the header  to the data. The names give a description of
#the measurement taken.

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.



subjectTotal <- rbind(subjTrain,subjTest) #vertically merge subject values
names(subjectTotal) <- c("Subject") #Places header on subject
tidy1 <- cbind(subjectTotal,selected) #create first tidy data frame with all observations

tidy2 <- tidy1[1:180,]  #Create a second tidy frame from the first to hold mean values
tidy2[,1] <- rep(1:30, each=6) #place subject number into data frame
tidy2[,2] <-c(1:6) #place activity type into data frame (recycling)
tidy2[,3] <-c("Walking","Walking_Upstairs", "Walking_Downstairs","Sitting","Standing","Laying") 
    #place activity name into data frame (recycling)

#Getting means of each activity and subject:
for (i in 1:30) {
  for (j in 1:6) {
    meanGen <- subset(tidy1,tidy1[,1]==i & tidy1[,2]==j) #subset to desired data
    means <- apply(meanGen[,4:89],2,mean) #gets column means for all measurements
    tidy2[j+6*(i-1),4:89] <- means   #place column mean values into new tidy data frame
  }
}
write.table(tidy2,"run_analysis.txt",row.name = FALSE) #write to a text file, space separated
