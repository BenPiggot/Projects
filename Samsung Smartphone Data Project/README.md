#Background
The run_analysis.R script reads data from the "Human Activity Recognition Using Smartphones Dataset Version 1.0" and produces a new dataset which may be used for further analysis. The "Human Activity Recognition Data Set" is stored from the University of California at Irvine machine learning library and accessed from the url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This folder downloaded from this url contained 30 data files. 

The data in the "Human Activity Recognition Using Smartphones Dataset Version 1.0" have been taken from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, "WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz data were captured. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The data from the 

#Data Files Used in run_analysis.R
Of the 30 files in the data library, the run_analysis script makes use of the seven files listed below:
* 'features.txt': List of measured variables
* "subject_test.txt": IDs of training subjects
*	"X_test.txt": Test data set
*	"y_test.txt": Test activity labels
* "subject_train.txt': IDs of training subjects
*	"X_train.txt': Training data set
*	"y_train.txt": Training activity labels

#Summary of run_analyis.R script:
The run_analysis.R script merges data from the seven .txt files and produces a new data set which may be used for further analysis.
* First it sets the working directory to "~/Desktop/UCI HAR Dataset/"
*	It then reads in the "features.txt" file and installs the gsubfn library. Using the gsub function, it then cleans this file and saves it as character vector titled "features". This vector will be used to label the variables used in the new tidy data set.
*	Next, the script reads in and saves as vectors or data frames the other six .txt files listed above.
* The three "test" files are then appended together using cbind as a new data frame. This data frame is then labeled using the "features" vector. This same process is then applied to the three "train" files.
* The "test" and "train" data frames are then merged together using the rbind function into one large data frame, "samsung_data".
* Using the grep function, all the columns with mean and std values are extracted.
* The "subject" and "activity" label columns filtered by the grep function used above are then merged together into a two column data frame
* This two column data frame is then attached to the columns with mean and std values
* The numbers in the activity column are then re-named so that their meaning is clearer (e.g. "1 becomes "walking", etc.). The rows in the data frame are then renumbered to start at 1 for clarity purposes aas well
* Using the aggregate function, a new data frame that takes the mean of each unique combination of the 30 experimental subjects and the 6 activities they performed is created. This data frama, "tidy.data", has 180 rows and 81 columns
* Finally, the tidy.data data frame is written as a .txt file and saved in the "~/Desktop/UCI HAR Dataset/". Note that the table produced by the by the newly written "tidy_data.txt" file is best viewed in RStudio or R, not a .txt editor.

