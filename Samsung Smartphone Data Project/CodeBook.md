#Background
tidy_data.txt summarizes data compiled from Human Activity Recognition Using Smartphones Dataset Version 1.0 (HAR), which can be found in the University of California at Irvine machine learning library. The HAR data set is a summary of the an experiment carried out with a group of 30 volunteers aged 18-49 who performed six activities: walking, walking upstairs, walking downstairs, sitting, standing, laying whike wearing a Samsung Galaxy smarthpone. The experimental subjects were randomly partitioned into "test" and "training" groups; 30% of the subjects were placed in the "test" group and 70% were placed in the "training"" group.Using the smartphone's embedded accelerometer and gyroscope, the researchers measured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. In total, summary statistics for 561 unique motions were measured.

tidy_data.txt is a file with 81 columns and 180 rows. It takes the mean of 79 of the motion measurements noted above. The rows represent the 180 unique combinations of 30 human subjects performing 6 physical activites. The columns include variables for the 30 human subjects and 6 physical activities, as well as 79 variables which measuring the mean of some of the motions measured by the Samsung smartphone.

# Transformations
The tidy_data.txt data set described above was obtained by perfoming a range of transformations onn the original HAR data set. These included:
* Re-formatting the names used to the describe the motions measuresd in the original HAR files to make them more legible.
* Re-naming the activity labels to make these labels more descriptive.
* Merging the "test" and "training" data from the original HAR files into one large data frame.
* Subsetting this large data frame to extract only mean and standard deviation summary statistics 
* Aggregating this subsetted data frame to create a mean of each motion summary statistics for each unique subject/activity combintation.
* Saving and storing this aggregated data as a new data frame in a .xlsx file

# Variable Descriptions
* subject - ID number for 30 subjects who participated in the experiment
* activity - the six activities each subject performed, including: "walking", "walking upstairs", "walking downstairs", "sitting", "standing", and "laying"
* mean and standard deviation summary statistics for 79 subject motions measured by the Samsung Galaxy smartphone including:
  * tBodyAcc in directions X, Y, and Z
  *	tGravityAcc in directions X, Y, and Z
  * tBodyAccJerk in directions X, Y, and Z
  * tBodyGyro in directions X, Y, and Z
  * tBodyGyroJerk in directions X, Y, and Z
  * tBodyAccMag 
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
  * fBodyAcc in directions X, Y, and Z
  * fBodyAccFreq in directions X, Y, and Z
  * fBodyAccJerk in directions X, Y, and Z
  * fBodyAccJerkFreq in directions X, Y, and Z
  * fBodyGyro in directions X, Y, and Z
  * fBodyGyroFreq in directions X, Y, and Z
  * fBodyAccMag 
  * fBodyAccMagFreq
  * fBodyAccJerkMag
  * fBodyAccJerkMagFreq
  * fBodyGyroMag
  * fBodyGyroMagFreq
  * fBodyGyroJerkMag
  * fBodyGyroJerkMagFreq
 









