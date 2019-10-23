//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Deed.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.0');
IMPORT Scrubs_LN_PropertyV2_Deed,SALT311;
FilePrev := DATASET([], Layout_Property_deed);
FileNew := DATASET([], Layout_Property_deed);
d := Scrubs_LN_PropertyV2_Deed.Delta(FilePrev, FileNew); // Instantiate delta module
globalStats := TRUE;
PARALLEL(OUTPUT(d.DifferenceSummary(globalStats), NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
