﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','_Scrubs_VendorSrc_Base.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.6');
IMPORT _Scrubs_VendorSrc_Base,SALT311;
FilePrev := DATASET([], Layout_Base);
FileNew := DATASET([], Layout_Base);
d := _Scrubs_VendorSrc_Base.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
