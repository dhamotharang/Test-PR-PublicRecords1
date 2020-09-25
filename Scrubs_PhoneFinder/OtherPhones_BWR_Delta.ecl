//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhoneFinder.OtherPhones_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.11');
IMPORT Scrubs_PhoneFinder,SALT311;
FilePrev := DATASET([], Scrubs_PhoneFinder.OtherPhones_Layout_PhoneFinder);
FileNew := DATASET([], Scrubs_PhoneFinder.OtherPhones_Layout_PhoneFinder);
d := Scrubs_PhoneFinder.OtherPhones_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
