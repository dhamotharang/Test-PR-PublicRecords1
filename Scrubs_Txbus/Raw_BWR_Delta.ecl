//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Txbus.Raw_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.1');
IMPORT Scrubs_Txbus,SALT311;
FilePrev := DATASET([], Raw_Layout_Txbus);
FileNew := DATASET([], Raw_Layout_Txbus);
d := Scrubs_Txbus.Raw_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
