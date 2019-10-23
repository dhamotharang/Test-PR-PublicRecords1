﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.ColValDesc_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.8');
IMPORT Scrubs_MBS,SALT311;
FilePrev := DATASET([], ColValDesc_Layout_ColValDesc);
FileNew := DATASET([], ColValDesc_Layout_ColValDesc);
d := Scrubs_MBS.ColValDesc_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
