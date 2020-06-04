//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Database_USA.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.8');
IMPORT Scrubs_Database_USA,SALT311;
FilePrev := DATASET([], Layout_Scrubs_Database_USA.Base_In_Database_USA);
FileNew := DATASET([], Layout_Scrubs_Database_USA.Base_In_Database_USA);
d := Scrubs_Database_USA.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
