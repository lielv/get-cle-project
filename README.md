## Getting and Cleaning Data Course's Project

The script contains several steps:
* Getting the data and organize it
	* Download the zip file
	* Extract it
	* Read the relevant files into R
* Merge the train and the test data - simply by "rbind" function, and set the names of the columns
* Extract only "mean" and "standard deviation" measurements - using "grep" function on the names of x
	* Note that I took only the names than contain the strings "mean()" and "std()"
* Labelling the data set was done on the merge part
* Aggregate the average of the measurements by activity and subject (using "aggregate" function)
	* Also setting the right names to the columns and writing the table to a text file (I used the tab separator to get nicer look) 