 
# STEP 1.Merges the training and the test sets to create one data set.

# Reading train data into R
train_data=read.table("./progassign/train/X_train.txt")
train_label=read.table("./progassign/train/y_train.txt")
train_subject = read.table("./progassign/train/subject_train.txt")

# Reading test data into R
test_data=read.table("./progassign/test/X_test.txt")
test_label=read.table("./progassign/test/y_test.txt")
test_subject=read.table("./progassign/test/subject_test.txt")

# Merginig both test and train data
merged_data = rbind(train_data,test_data)
merged_label = rbind(train_label,test_label)
merged_subject = rbind(train_subject,test_subject)


# STEP 2: Extracts only the measurements on the mean and standard deviation 
#         for each measurement. 
features = read.table("./progassign/features.txt")
mean_stddev_indices = grep("mean\\(\\)|std\\(\\)", features[, 2])
merged_data = merged_data[,mean_stddev_indices]

# remove "()" from new colum
names(merged_data) <- gsub("\\(\\)", "", features[mean_stddev_indices, 2]) 
# capitalize M
names(merged_data) <- gsub("mean", "Mean", names(merged_data))
# capitalize S
names(merged_data) <- gsub("std", "Std", names(merged_data))
# remove "-" in column names
names(merged_data) <- gsub("-", "", names(merged_data)) 

# STEP 3: Uses descriptive activity names to name the activities in the data set
activity <- read.table("./progassign/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activity_label <- activity[merged_label[, 1], 2]
merged_label[, 1] <- activity_label
names(merged_label) <- "activity"


# STEP 4: Appropriately labels the data set with descriptive variable names. 
names(merged_subject) <- "subject"
cleaned_data <- cbind(merged_subject, merged_label, merged_data)
write.table(cleaned_data, "tidy_data.txt") 

# STEP 5: Creates a second, independent tidy data set with the average of each 
#         variable for each activity and each subject. 
subject_length = length(table(merged_subject))
activity_length = dim(activity)[1]
column_length = dim(cleaned_data)[2]

result = matrix(NA, nrow=subject_length*activity_length, ncol=column_length) 
result = as.data.frame(result)
colnames(result) = colnames(cleaned_data)

row = 1
for(i in 1:subject_length) {
        for(j in 1:activity_length) {
                result[row, 1] <- sort(unique(merged_subject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == cleaned_data$subject
                bool2 <- activity[j, 2] == cleaned_data$activity
                result[row, 3:column_length] <- colMeans(cleaned_data[bool1&bool2, 3:column_length])
                row <- row + 1
        }
}
head(result)
write.table(result, "tidy_data_with_means.txt") # write out the 2nd dataset
