//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.In_Port_Daily_BWR_Delta - Finding the Delta of Two Files - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
FilePrev := DATASET([], In_Port_Daily_Layout_PhonesInfo);
FileNew := DATASET([], In_Port_Daily_Layout_PhonesInfo);
d := Scrubs_PhonesInfo.In_Port_Daily_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
