Default generated readme file for ComputeDatasetDelta
Compares differences between two files

Compute Dataset Delta ReadMe

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin computes the differences between two files and returns a dataset of the differences.
This plugin takes in 2 input dataset, ideally with roughly the same layout as the goal is to compare the differences in the values of the fields, 
and the fields from each input dataset to do the comparison on.

===========================================================
                      What to Input
===========================================================

dsInput1 is the input dataset from the older run
JoinFields1 - Join Columns from dsInput1 - are the fields from dsInput1 to use to decide if we should be comparing the fields between a record from dsInput1 with dsInput2.
FieldsToIgnore1 - Columns to ignore - are the fields to ignore when doing the field by field comparison

dsInput2 is the input dataset from the newer run 
JoinFields2 - Join Columns from dsInput2 - are the fields from dsInput2 to use to decide if we should be comparing the fields between a record from dsInput1 with dsInput2.

JoinFields1 and JoinFields2 should be the same!
FieldsToIgnore1 should list any fields whose values we don't want to compare between dsInput1 and dsInput2. For example, if there is a date field that we know alwayds changes
between two runs we would not want to make a comparison on that field as it would always change between dsInput1 and dsInput2.

===========================================================
                      Outputs
===========================================================
There are two possible outputs for this.

dsOutput contains the full record sets from dsInput1 and dsInput2 as well as a child dataset of the fields that are different between the records from dsInput1 and dsInput2.

dsSkinny is a skinnier normalized version of dsOutput which contains the Join Columns from dsInput1, the name of the field with different values and its value from dsInput1 and dsInput2.

===========================================================
                      Disclaimer
===========================================================
Only records that had a difference will be returned. 
Any records in dsInput2 that were not in dsInput1 will not be returned (and vice versa).

Currently HIPIE does not support declaring dsOutput so that HIPIE knows about the full records from dsInput1 and dsInput2 as nested records.
dsOutput has the following record structure  
  LOCAL rDiffValues := RECORD
    STRING Field;
    STRING OldValue;
    STRING NewValue;
    INTEGER IsDifferent;
  END;
  
  LOCAL rDiff := RECORD
    Join Fields from dsInput1;
    RECORDOF(dOld) Old;
    RECORDOF(dNew) New;
    DATASET(rDiffValues) Differences;
  END;

but HIPIE only knows about
  LOCAL rDiff := RECORD
    Join Fields from dsInput1;
    DATASET(rDiffValues) Differences;
  END;

This is not an issue for using this plugin to create an output for use in a dashboard.