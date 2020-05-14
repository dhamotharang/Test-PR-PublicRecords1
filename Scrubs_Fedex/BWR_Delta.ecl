//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Fedex.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_Fedex,SALT311;
FilePrev := DATASET([], Scrubs_Fedex.Layout_Fedex);
FileNew := DATASET([], Scrubs_Fedex.Layout_Fedex);
d := Scrubs_Fedex.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
