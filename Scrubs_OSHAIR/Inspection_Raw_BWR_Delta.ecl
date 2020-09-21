//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.Inspection_Raw_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
FilePrev := DATASET([], Inspection_Raw_Layout_Inspection_Raw_In_OSHAIR);
FileNew := DATASET([], Inspection_Raw_Layout_Inspection_Raw_In_OSHAIR);
d := Scrubs_OSHAIR.Inspection_Raw_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
