=========================================
Coursera Getting and Cleaning Data Project
README
Justin Markunas
August 20th, 2015
=========================================


For additional information regarding the data of this project, see the Code Book.

A single script was used to tidy the data. A description of the script is shown below. This follows the code book closely with additional information on how particular transformations were performed.


Transformation of data to a more compact, tidy dataset:

This process was performed in 5 main steps:

1. Merge the training and the test sets to create one data set.

   Training and test data were loaded by the script from x_train.txt and x_test.txt files, respectively. The two were then vertically concatenated to produce a single 10299 by 561 data frame ('total'). A header, read in from the features.txt file, was then added to the data frame to describe each measurement.
   The activities types corresponding to the rows of the measured data were loaded from y_train.txt and y_test.txt. The two were vertically concatenated to produce a single 10299 by 1 data frame ('actTotal'). A header to the column, "ActivityNum" was then added.	

2. Extract only the measurements on the mean and standard deviation for each measurement. 

   The grepl function was used on the header of the measurement data frame to reduce the number of variable to those that only contained the words 'mean' or 'std' in them. [Mm]ean and [Ss]td were searched in case some variable were uppercase. The resulting data frame was reduced to 86 columns from 561 ('selected').
	
3. Use descriptive activity names to name the activities in the data set.

   A second column was added to the activity type data frame. Prior to this transformation, the data frame had 1 column corresponding to the activity type. The second column contained a description of each activity type. This was accomplished by using a For loop over all 10299 rows of the data frame to assign the following descriptions: 'walking' for every 1, 'walking upstairs' for every 2, 'walking downstairs' for every 3, 'sitting' for every 4, 'standing' for every 5, and 'laying' for every 6. 
   Upon adding the activity description, 'actTotal' and 'selected' horizontally concatenated with activity number and type consisting the first two columns of the data frame 'selected.' This brought the size of the data frame to 10299 by 88.
 
4. Appropriately labeled the data set with descriptive variable names.

   This step took place with the addition of header in part 1 above.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.

   The subject numbers for each measurement, read in from subject_train.txt and subject_test.txt, with vertically concatenated and then horizontally merged to the 'selected' data frame as the first column. This produced a new data frame, 'tidy1' consisting of 10299 rows and 89 columns.
   Means for each activity type for each subject were calculated for all 86 variables. The results were placed in the 'tidy2' data frame, consisting of 180 rows and 89 columns. Means for each of the 180 rows were calculated by using 2 For loops. The first of these iterated over all 30 subjects and the second over the 6 activities. The tidy data frame was subsetted down using these two indices with the mean calculated on the remaining data.This data was then inputted to the 'tidy2' data frame.


   Lastly, the data from tidy2 were outputted to the .txt file 'run_analysis.txt'
	

