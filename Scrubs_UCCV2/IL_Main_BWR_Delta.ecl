﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_UCCV2.IL_Main_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.4');
IMPORT Scrubs_UCCV2,SALT311;
FilePrev := DATASET([], IL_Main_Layout_UCCV2);
FileNew := DATASET([], IL_Main_Layout_UCCV2);
d := Scrubs_UCCV2.IL_Main_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
