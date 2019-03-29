Append New Data Indicator ReadMe

===========================================================
                      Plugin Type
===========================================================
This is an APPEND plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin takes in 2 input dataset, ideally with roughly the same layout as one input dataset should be from a previous composition run 
and the other from the current composition run, and the fields from each input dataset to do the comparison on.
The plugin returns the new dataset with an additional flag indicating whether the record from the current composition run were 
in the previous run or not.
The output layout of the combined dataset inherits from the first input dataset and a new appended field to indicate if the records was seen
before.

===========================================================
                      What to Input
===========================================================

dsNewRun is the input dataset from the current composition run that we want to append the new indicator flag for.
JoinFields1 are the fields from dsNewRun to use to determine if a record was present in the previous composition run.

dsOldRun is the input dataset from the previous composition run that we want to use to determine if a record from dsNewRun
is a new record
JoinFields2 are the fields from dsOldRun to use to determine if a record was present in the previous composition run.

Prefix the prefix to be added to avoid field name confilicts on the NewFlag.

===========================================================
                      Outputs
===========================================================

The output of this will be the input record layout of dsNewRun along with a NewFlag column to indicate whether records were 
present in the dsOldRun dataset.
