#get and put together the test data
filelist <- list("subject_test", "y_test", "x_test")
for(i in filelist) {
    filename <- i
    filepath <- paste("test/", filename, ".txt", sep ="")
    dataframe <- read.table(filepath, quote="\"", comment.char="")
    rowz <- nrow(dataframe)
    tempvector <- rep(filename, rowz)
    if(i == "x_test") {
        features <- read.table("features.txt", quote="\"", comment.char="")
        features$V2 <- gsub('-', '_', features$V2)
        features$V2 <- gsub('\\()', '', features$V2)
        colnames(dataframe)<-features[1:ncol(dataframe),"V2"]
    }
    nuframe <- cbind(dataframe, tempvector)
    if(i == "subject_test") {
        nuframe$subject <- nuframe$tempvector
    }
    if(i == "y_test") {
        nuframe$ydata <- nuframe$tempvector
    }
    assign(i, nuframe)
    colnamez <- (rep(i, ncol(nuframe)))
    rm(nuframe)
    rm(dataframe)
}

alltest <- cbind(subject_test, y_test, x_test)


#get and put together the train data
filelist <- list("subject_train", "y_train", "x_train")
for(i in filelist) {
    filename <- i
    filepath <- paste("train/", filename, ".txt", sep ="")
    dataframe <- read.table(filepath, quote="\"", comment.char="")
    rowz <- nrow(dataframe)
    tempvector <- rep(filename, rowz)
    if(i == "x_train") {
        features <- read.table("features.txt", quote="\"", comment.char="")
        features$V2 <- gsub('-', '_', features$V2)
        features$V2 <- gsub('\\()', '', features$V2)
        colnames(dataframe)<-features[1:ncol(dataframe),"V2"]
    }
    nuframe <- cbind(dataframe, tempvector)
    if(i == "subject_train") {
        nuframe$subject <- nuframe$tempvector
    }
    if(i == "y_train") {
        nuframe$ydata <- nuframe$tempvector
    }
    assign(i, nuframe)
    colnamez <- (rep(i, ncol(nuframe)))
    rm(nuframe)
    rm(dataframe)
}
alltrain <- cbind(subject_train, y_train, x_train)

#Put together the test and train data
fulldata <- rbind(alltest, alltrain)
fulldata <- fulldata[,-c(2,5)]
colnames(fulldata)[colnames(fulldata)=="V1"] <- "subjectID"
colnames(fulldata)[colnames(fulldata)=="V1.1"] <- "activity"
colnames(fulldata)[colnames(fulldata)=="subject"] <- "group"
fulldata$group <- revalue(fulldata$group, c("subject_test"="test", "subject_train"="train"))
fulldata <- fulldata[,-4]
fulldata <- fulldata[,-565]
fulldata$activity <- as.factor(fulldata$activity)
fulldata$subjectID <- as.factor(fulldata$subjectID)
fulldata$activity <- revalue(fulldata$activity, c("1"="walking", "2"="walking_upstairs", "3"="walking_downstairs", "4"="sitting", "5"="standing", "6"="laying"))

#make tidy dataframe of means for each measure by each factor

meanzdf <- ddply(fulldata, (c("subjectID", "group", "activity")), colwise(mean))
rm(alltest, alltrain, features, subject_test, subject_train, x_test, x_train, y_test, y_train, colnamez, filelist, filename, filepath, i, rowz, tempvector)