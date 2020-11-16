﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Spoke.Input_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.11');
IMPORT Scrubs_Spoke,SALT311;
FilePrev := DATASET([], Scrubs_Spoke.Input_Layout_Spoke);
FileNew := DATASET([], Scrubs_Spoke.Input_Layout_Spoke);
d := Scrubs_Spoke.Input_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
