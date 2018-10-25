Join Dataset ReadMe

===========================================================
                      Plugin Type
===========================================================
This is a JOIN plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin joins two datasets to create a new output dataset comprised of the join output of the two datasets.
The output layout of the combined dataset inherits from the first input dataset and a select group of fields from the second dataset.

===========================================================
                      What to Input
===========================================================

This plugin will take the first dataset that was input (dsInput1) and the selected fields from the second dataset (AppendFields from dsInput2) and use the combination as the layout for the appended dataset.

dsInput1 is the input dataset.
JoinFields1 are the fields to use in the JOIN statement from dsInput1

dsInput2 is the input dataset to add to dsInput1 projected in the same format as dsInput1 with the fields specified under AppendFields
JoinFields2 are the fields to use in the JOIN statement from dsInput2
AppendFields the fields from dsInput2 to append to the layout of dsInput1 to form the output layout. You should not add fields that are already included in the layout of dsInput1. 
This is optional.

JoinType is a list of the type of JOINs you wish to generate. The default is an Inner JOIN.

When specifying JoinFields1 and JoinFields2 select the same amount of fields and select them in the order they should be matched up.
For instance if you have in dsInput1 firstname and lastname and in dsInput2 fname and lname and you wish the JOIN statement to be LEFT.firstname=RIGHT.fname AND LEFT.lastname=RIGHT.lname, then you should first select firstname then select last name in dsInput1, then you should first select fname then select lname in dsInput2.

KeepOption specifies the maximum number of matching records (n) to generate into the result set. If omitted, all matches are kept. 
This is useful where there may be many matching pairs and you need to limit the number in the result set. 
KEEP is only supported for Inner and Left Outer JOINs. Using it with any other JOIN types will result in an ECL error

KeepValue the maximum number of matching records to generate into the result set. The default when KeepOption is set to True is 1.

===========================================================
                      Outputs
===========================================================

The output of this will be the join dataset of dsInput1 and dsInput2 based on the criteria specified by JoinFields1 and JoinFields2.