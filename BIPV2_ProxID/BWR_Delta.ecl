//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.3');
IMPORT BIPV2_ProxID,SALT311;
FilePrev := DATASET([], Layout_DOT_Base);
FileNew := DATASET([], Layout_DOT_Base);
d := BIPV2_ProxID.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
