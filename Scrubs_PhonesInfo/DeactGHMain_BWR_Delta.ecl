//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.DeactGHMain_BWR_Delta - Finding the Delta of Two Files - SALT V3.10.0');
IMPORT Scrubs_PhonesInfo,SALT310;
FilePrev := DATASET([], DeactGHMain_Layout_PhonesInfo);
FileNew := DATASET([], DeactGHMain_Layout_PhonesInfo);
d := Scrubs_PhonesInfo.DeactGHMain_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
