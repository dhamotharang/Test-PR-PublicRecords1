//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_FL_Filing_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
FilePrev := DATASET([], Input_FL_Filing_Layout_FBNV2);
FileNew := DATASET([], Input_FL_Filing_Layout_FBNV2);
d := Scrubs_FBNV2.Input_FL_Filing_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
