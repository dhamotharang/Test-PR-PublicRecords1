﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BBB2.raw_Member_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.7');
IMPORT Scrubs_BBB2,SALT311;
FilePrev := DATASET([], raw_Member_Layout_BBB2);
FileNew := DATASET([], raw_Member_Layout_BBB2);
d := Scrubs_BBB2.raw_Member_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
