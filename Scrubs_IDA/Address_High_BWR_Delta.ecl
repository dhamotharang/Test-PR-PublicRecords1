//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IDA.Address_High_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.11');
IMPORT Scrubs_IDA,SALT311;
FilePrev := DATASET([], Scrubs_IDA.Address_High_Layout_IDA);
FileNew := DATASET([], Scrubs_IDA.Address_High_Layout_IDA);
d := Scrubs_IDA.Address_High_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
