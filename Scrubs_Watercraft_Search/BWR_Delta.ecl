//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Watercraft_Search.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_Watercraft_Search,SALT311;
FilePrev := DATASET([], Scrubs_Watercraft_Search.Layout_Watercraft_Search);
FileNew := DATASET([], Scrubs_Watercraft_Search.Layout_Watercraft_Search);
d := Scrubs_Watercraft_Search.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
