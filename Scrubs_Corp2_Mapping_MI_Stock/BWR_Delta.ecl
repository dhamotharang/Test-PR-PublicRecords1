//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_MI_Stock.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.1');
IMPORT Scrubs_Corp2_Mapping_MI_Stock,SALT311;
FilePrev := DATASET([], Layout_In_MI);
FileNew := DATASET([], Layout_In_MI);
d := Scrubs_Corp2_Mapping_MI_Stock.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
