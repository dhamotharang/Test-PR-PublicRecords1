//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Credit_Unions.Base_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.1');
IMPORT Scrubs_Credit_Unions,SALT311;
FilePrev := DATASET([], Base_Layout_Credit_Unions);
FileNew := DATASET([], Base_Layout_Credit_Unions);
d := Scrubs_Credit_Unions.Base_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
