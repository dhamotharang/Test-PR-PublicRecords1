//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Inql_Nfcra_Bridger.BWR_Delta - Finding the Delta of Two Files - SALT V3.9.0');
IMPORT Scrubs_Inql_Nfcra_Bridger,SALT39;
FilePrev := DATASET([], Layout_File);
FileNew := DATASET([], Layout_File);
d := Scrubs_Inql_Nfcra_Bridger.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
