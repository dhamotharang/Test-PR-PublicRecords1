﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FCC.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_FCC,SALT311;
FilePrev := DATASET([], Scrubs_FCC.Layout_FCC);
FileNew := DATASET([], Scrubs_FCC.Layout_FCC);
d := Scrubs_FCC.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
