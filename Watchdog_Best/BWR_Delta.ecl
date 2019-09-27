//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Watchdog_best.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.7');
IMPORT Watchdog_best,SALT311;
FilePrev := DATASET([], Layout_Hdr);
FileNew := DATASET([], Layout_Hdr);
d := Watchdog_best.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
