//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BIPV2.Ingest_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.4');
IMPORT Scrubs_BIPV2,SALT311;
FilePrev := DATASET([], Ingest_Layout_BIPV2);
FileNew := DATASET([], Ingest_Layout_BIPV2);
d := Scrubs_BIPV2.Ingest_Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
