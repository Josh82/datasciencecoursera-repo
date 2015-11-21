      # Set working directory
setwd("//america/youngj/Desktop/Coursera/UCI HAR Dataset")

      # Read in Features table
Features <- read.table("features.txt")

      # Read in Test data files, relabel and merge
  TrainSet <- read.table("./train/X_train.txt")
  cols <-Features[,2]
  colnames(TrainSet)<-cols
  TrainSubject<- read.table("./train/subject_train.txt")
  colnames(TrainSubject)<-"Participant"
  TrainSetLabel <- read.table("./train/y_train.txt")
  colnames(TrainSetLabel)<-"Activity"
  Trainactpart <- cbind(TrainSetLabel, TrainSubject)   
  Traincombined<- cbind(Trainactpart, TrainSet)

      #Read in Test data files, relabel and merge
  TestSet <- read.table("./test/X_test.txt")
  cols <-Features[,2]
  colnames(TestSet)<-cols
  TestSetLabel <- read.table("./test/y_test.txt")
  colnames(TestSetLabel)<-"Activity"
  TestSubject<- read.table("./test/subject_test.txt")
  colnames(TestSubject)<-"Participant" 
  Testactpart <- cbind(TestSetLabel, TestSubject)   
  Testcombined<- cbind(Testactpart, TestSet)

    #Combine Training and data fils and convert activity from number to description
mergedData <- rbind(Traincombined, Testcombined)
      mergedData$Activity[mergedData$Activity=="1"]<-"Walking"
      mergedData$Activity[mergedData$Activity=="2"]<-"Walking_Upstairs"
      mergedData$Activity[mergedData$Activity=="3"]<-"Walking_downstairs"
      mergedData$Activity[mergedData$Activity=="4"]<-"Sitting"
      mergedData$Activity[mergedData$Activity=="5"]<-"Standing"
      mergedData$Activity[mergedData$Activity=="6"]<-"Laying"

# Completion of Step One: Merges the training and the test sets to create one data set
# ...and Step ThreeUses descriptive activity names to name the activities in the data set
    
    #Extract all columns with mean and standard deviation calcualtions

mergedDataMeanSTD <- mergedData[grep("Activity|Participant|*mean*|*std*|*Mean*", colnames(mergedData))]

# Completion of Step Two: Extracts only the measurements on the mean and standard deviation for each measurement

# Appropriately labels the data set with descriptive variable names

  names(mergedDataMeanSTD)<-gsub("t", "Time", names(mergedDataMeanSTD))
  names(mergedDataMeanSTD)<-gsub("Acc", "Accelorate", names(mergedDataMeanSTD))
  names(mergedDataMeanSTD)<-gsub("Gyro", "Angular_Velocity", names(mergedDataMeanSTD))
  names(mergedDataMeanSTD)<-gsub("f", "Frequency", names(mergedDataMeanSTD))
  names(mergedDataMeanSTD)<-gsub("graviTimey", "Gravity", names(mergedDataMeanSTD))
  names(mergedDataMeanSTD)<-gsub("AcTimeiviTimey", "Activity", names(mergedDataMeanSTD))
  names(mergedDataMeanSTD)<-gsub("ParTimeicipanTime", "Participant", names(mergedDataMeanSTD))

write.table(mergedDataMeanSTD, file = "Tidy_Human Activity Recognition Dataset.txt")

Tidy1Data<- read.table("./Tidy_Human Activity Recognition Dataset.txt")
Tidy1Data<- as.data.frame(Tidy1Data)

library(dplyr) 

Tidy2Data<-Tidy1Data %>% group_by(Activity,Participant) %>% summarise_each(funs(mean),-Participant)
write.table(Tidy2Data, file = "Tidy_Human Activity Recognition Dataset Mean.txt", row.name=FALSE)
