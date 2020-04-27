//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Business_Credit.BS_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.9');
IMPORT Scrubs_Business_Credit,SALT311;
FilePrev := DATASET([], Scrubs_Business_Credit.BS_Layout_Business_Credit);
FileNew := DATASET([], Scrubs_Business_Credit.BS_Layout_Business_Credit);
d := Scrubs_Business_Credit.BS_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
