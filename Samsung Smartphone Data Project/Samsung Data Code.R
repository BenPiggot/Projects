# Set working directory
setwd("~/Desktop/UCI HAR Dataset/")

# Read in "Features.txt" file and clean the variable labels with the sub function.
# This file will be used as the column labels for my new data frame.
features_df <- read.table("~/Desktop/UCI HAR Dataset/features.txt")
features <- as.character(features_df[,2])
install.packages("gsubfn")
library(gsubfn)
features <- gsub("[^[:alnum:]]","", features)
features <- gsub(pattern="mean", replacement=".mean", features)
features <- gsub(pattern="std", replacement=".std", features)

# Read in other relevant files from working directory.
# These files will provide the subject IDs, activities, and data
# for my new data frame.
subject_test_data <- read.table("./test/subject_test.txt")
subject_train_data <- read.table("./train/subject_train.txt")
xtest_data <- read.table("./test/X_test.txt")
xtrain_data <- read.table("./train/X_train.txt")
ytest_data <- read.table("./test/y_test.txt")
ytrain_data <- read.table("./train/y_train.txt")

# Bind togther the data, subject IDs, and activities for the "test"
# portion of the experiment. Then affix columns names from the "features" 
# file cleaned above.
test_data <- cbind(ytest_data, subject_test_data, xtest_data)
names(test_data) <- c("activity", "subject", features)

# Bind togther the data, subject IDs, and activities for the "train"
# portion of the experiment. Then affix columns names from "features" 
# file cleaned above.
train_data <- cbind(ytrain_data, subject_train_data, xtrain_data)
names(train_data) <-  c("activity", "subject", features)

# Bind together the "test" and "train" sub data sets into a new data frame
# called "samsung_data".
samsung_data <- rbind(test_data, train_data)

# Subset the "samsung_data" data frame using the grep function to select 
# only those columns measuring "mean" or "std" (standard deviation).
mean_data <- samsung_data[,grep("mean",colnames(samsung_data))]
std_data <- samsung_data[,grep("std",colnames(samsung_data))]

# Recreate the "subject" and activity" columns from the "samsung_data" 
# data frame that were filtered out by the grep function. 
ysubject_data <- data.frame(rbind(cbind(ytest_data, subject_test_data), 
                       cbind(ytrain_data, subject_train_data)))

# Bind the subject and activity mini data frame with the subsetted "mean"
# and "std" data frames subsetted above using the grep function. This data frame -
# temporarily titled "mean_std_data" - is the basis for my final "tidy data" data frame.
mean_std_data <- cbind(ysubject_data, mean_data, std_data)

# Rename the the first and second columns in the "mean_std_data" data frame 
names(mean_std_data)[1] <- "activity"
names(mean_std_data)[2] <- "subject"

# Provide meaningful names for the "activity" variable using the "feature_info.txt"
# file as a guide. This .txt file is found in the working directory (but is not read into R).
mean_std_data$activity[mean_std_data$activity==1] <- "walking"
mean_std_data$activity[mean_std_data$activity==2] <- "walking downstairs"
mean_std_data$activity[mean_std_data$activity==3] <- "walking upstairs"
mean_std_data$activity[mean_std_data$activity==4] <- "sitting"
mean_std_data$activity[mean_std_data$activity==5] <- "standing"
mean_std_data$activity[mean_std_data$activity==6] <- "laying"

# Re-number the mean_std_data rows to start at 1.
row.names(mean_std_data) <- 1:nrow(mean_std_data)

# Create the final "tidy.data" data frame using the aggregate function. 
tidy.data <-  aggregate(. ~ activity + subject, data=mean_std_data, mean)

# Reorder the "tidy.data" data frame's columns so that "subject" heads the first column
# variable and "acitivity" heads the second column
tidy.data <- tidy.data[,c(2,1,3:81)]

# Install xlsx package and write the "tidy.data" data frame as Excel file.
install.packages("xlsx")
library(xlsx)
write.xlsx(x = tidy.data, file = "Human Activity as Measured by Samsung Smartphone.xlsx", row.names = FALSE)



