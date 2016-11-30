##READ ME

#Stage zero
Install the required packages, load libraries and set our working directory (will vary person-to-person)

#Stage one
Merge the "train" and "test" datasets
* Load the test and train datasets
* Load the features.txt file, which contains the variable names
* Load the activity_labels.txts file, which contains the lookup for activity description
* Form a single data set for test, and a single data set for train
* Rename columns in test and train datasets
* Combine (union) into a single data set, called alldata


#Stage two
* Form a vector containing the fields we want to select (mean and std columns)
* Select only these fields from alldata, and overwrite


#Stage three
We have already re-named the columns in alldata, but we need to make the activity labels easier to understand for someone not familiar with the data. We replace the numbers with text descriptions here.


#Stage four
We acknowledge that we have already completed the fourth point of the assignment


Stage five
Create our data set output:
* Create a group_by condition on our data set, which groups by the "subject" and "activity" columns
* Take the mean of every other column in our data, grouped by "subject" and "activity" columns
* Write this to a txt file called "mergeddata.txt", using the "|" symbol as the separator