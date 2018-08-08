//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.IndType_BWR_Delta - Finding the Delta of Two Files - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
FilePrev := DATASET([], IndType_Layout_IndType);
FileNew := DATASET([], IndType_Layout_IndType);
d := Scrubs_MBS.IndType_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
