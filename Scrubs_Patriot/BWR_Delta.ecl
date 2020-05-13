//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Patriot.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.11');
IMPORT Scrubs_Patriot,SALT311;
FilePrev := DATASET([], Scrubs_Patriot.Layout_Patriot);
FileNew := DATASET([], Scrubs_Patriot.Layout_Patriot);
d := Scrubs_Patriot.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
