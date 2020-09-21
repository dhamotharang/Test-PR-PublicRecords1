﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.GenDutyStd_Raw_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
FilePrev := DATASET([], GenDutyStd_Raw_Layout_GenDutyStd_Raw_In_OSHAIR);
FileNew := DATASET([], GenDutyStd_Raw_Layout_GenDutyStd_Raw_In_OSHAIR);
d := Scrubs_OSHAIR.GenDutyStd_Raw_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
