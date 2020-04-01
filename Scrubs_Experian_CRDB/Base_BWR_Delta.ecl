//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Experian_CRDB.Base_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_Experian_CRDB,SALT311;
FilePrev := DATASET([], Scrubs_Experian_CRDB.Base_Layout_Experian_CRDB);
FileNew := DATASET([], Scrubs_Experian_CRDB.Base_Layout_Experian_CRDB);
d := Scrubs_Experian_CRDB.Base_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
