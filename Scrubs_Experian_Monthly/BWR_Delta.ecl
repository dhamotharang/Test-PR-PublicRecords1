//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Experian_Monthly.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.11');
IMPORT Scrubs_Experian_Monthly,SALT311;
FilePrev := DATASET([], Scrubs_Experian_Monthly.Layout_File);
FileNew := DATASET([], Scrubs_Experian_Monthly.Layout_File);
d := Scrubs_Experian_Monthly.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
