library(reshape2)

filename <-'dataset.zip'

if(!file.exists(filename)){
        Url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
        download.file(url = Url, destfile = filename)
}

if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

featureslabel <- read.table("UCI HAR Dataset/features.txt")
featureslabel$V2 <- as.character(featureslabel$V2)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

Sublabels <- grep(pattern = "mean|std", x = activitylabels)

featureslabelsSub <- featureslabel[Sublabels,2]
featureslabelsSub <- gsub(pattern = "mean", replacement = "Mean", x = featureslabelsSub)
featureslabelsSub <- gsub(pattern = "std", replacement = "Std", x = featureslabelsSub)
featureslabelsSub <- gsub(pattern = "-", replacement = "", x = featureslabelsSub)
featureslabelsSub <- gsub(pattern = "[()]", replacement = "", x = featureslabelsSub)

train <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("UCI HAR Dataset/train/x_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
xtrain <- xtrain[Sublabels]
trainbind <- cbind(train, ytrain, xtrain)


test <- read.table("UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("UCI HAR Dataset/test/x_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
xtest <- xtest[Sublabels]
testbind <- cbind(test, ytest, xtest)

testtrain <- rbind(testbind, trainbind)
colnames(testtrain) <- c("subject", "activity", featureslabelsSub)
testtrain$activity <- factor(testtrain$activity, levels = activityLabels[,1], labels = activityLabels[,2])
testtrain$subject <- as.factor(testtrain$subject)
melt <- melt(data = testtrain, id.vars = c("subject", "activity"))
mean <- dcast(melt, subject + activity ~ variable, mean)
write.table(mean, "tidy.txt", row.names = FALSE, quote = FALSE)
