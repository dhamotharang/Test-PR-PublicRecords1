﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Assessor.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_LN_PropertyV2_Assessor,SALT311;
FilePrev := DATASET([], Scrubs_LN_PropertyV2_Assessor.Layout_Property_Assessor);
FileNew := DATASET([], Scrubs_LN_PropertyV2_Assessor.Layout_Property_Assessor);
d := Scrubs_LN_PropertyV2_Assessor.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
