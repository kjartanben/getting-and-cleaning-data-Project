  #Activity labels
  act.lab <- read.table('UCI HAR Dataset/activity_labels.txt') #6 2
  #Features
  features <- read.table('UCI HAR Dataset/features.txt') #561 2

  #Test data results
  test <- read.table('UCI HAR Dataset/test/X_test.txt') #2947  561
  #Test subjects
  test.names <- read.table('UCI HAR Dataset/test/y_test.txt') #2947    1
  test.subject <- read.table('UCI HAR Dataset/test/subject_test.txt')#2947    1

  #Combined test set
  test.res <- cbind('Test',test.subject, act.lab[test.names$V1,][2],test)
  colnames(test.res) <- c('Training or Test', 'Subject', 'Activity', levels(features[,2])[features[,2]] )

  #Training set
  train <- read.table('UCI HAR Dataset/train/X_train.txt') #2947  561
  train.names <- read.table('UCI HAR Dataset/train/y_train.txt') #2947    1
  train.subject <- read.table('UCI HAR Dataset/train/subject_train.txt')#2947    1
  train.subject <- read.table('UCI HAR Dataset/train/subject_train.txt')#2947    1
  #Combined training set
  train.res <- cbind('Train',train.subject, act.lab[train.names$V1,][2],train)
  colnames(train.res) <- c('Training or Test', 'Subject','Activity', levels(features[,2])[features[,2]] )

  #Merge the training and test set
  all.res <- rbind(test.res,train.res)

  #Index for extracting the only mean and standard deviation results
  ind = which(grepl("-(mean|std)\\(\\)",names(all.res)) )

  #Extract only the mean and standard deviation results
  all.res <- all.res[,c(1:3,ind)]

  library(dplyr)
  #Create the tidy data set with the average of each variable 
  #for each activity and each subject. 
  tidy.average <-all.res[,-1] %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))



