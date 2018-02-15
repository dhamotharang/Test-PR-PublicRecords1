﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.BaseFile_BWR_Delta - Finding the Delta of Two Files - SALT V3.10.1');
IMPORT Scrubs_PhonesInfo,SALT310;
FilePrev := DATASET([], BaseFile_Layout_PhonesInfo);
FileNew := DATASET([], BaseFile_Layout_PhonesInfo);
d := Scrubs_PhonesInfo.BaseFile_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
