//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_6000_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
FilePrev := DATASET([], Base_6000_Layout_EBR);
FileNew := DATASET([], Base_6000_Layout_EBR);
d := Scrubs_EBR.Base_6000_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
