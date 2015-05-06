# Getting and Cleaning Data Course's Project

The script contains several steps:
1. Getting the data and organize it
	* Download the zip file
	* Extract it
	* Read the relevant files into R
2. Merge the train and the test data - simply by rbind, and set the names of the columns
3. Extract only "mean" and "standard deviation" measurements - using grep on the names of x
	* Note that I took only the names than contain the strings "mean()" and "std()"
4. Labelling the data set was done on (2)
5. Aggregate the average of the measurements by activity and subject
	* Also setting the right columns' names and writing the table to a text file (I used the tab separator to get nicer look) 