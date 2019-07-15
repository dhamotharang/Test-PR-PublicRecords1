//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_Address.BWR_Delta - Finding the Delta of Two Files - SALT V3.11.3');
IMPORT InsuranceHeader_Address,SALT311;
FilePrev := DATASET([], Layout_Address_Link);
FileNew := DATASET([], Layout_Address_Link);
d := InsuranceHeader_Address.Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
