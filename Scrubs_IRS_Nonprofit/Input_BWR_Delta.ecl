﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IRS_Nonprofit.Input_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.8');
IMPORT Scrubs_IRS_Nonprofit,SALT311;
FilePrev := DATASET([], Input_Layout_IRS_Nonprofit);
FileNew := DATASET([], Input_Layout_IRS_Nonprofit);
d := Scrubs_IRS_Nonprofit.Input_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
