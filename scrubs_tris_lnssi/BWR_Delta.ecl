//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_tris_lnssi.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.11');
IMPORT scrubs_tris_lnssi,SALT311;
FilePrev := DATASET([], scrubs_tris_lnssi.Layout_tris_lnssi);
FileNew := DATASET([], scrubs_tris_lnssi.Layout_tris_lnssi);
d := scrubs_tris_lnssi.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
