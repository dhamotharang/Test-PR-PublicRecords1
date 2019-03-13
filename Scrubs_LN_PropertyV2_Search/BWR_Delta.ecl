//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Search.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.4');
IMPORT Scrubs_LN_PropertyV2_Search,SALT311;
FilePrev := DATASET([], Layout_LN_PropertyV2_Search);
FileNew := DATASET([], Layout_LN_PropertyV2_Search);
d := Scrubs_LN_PropertyV2_Search.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
