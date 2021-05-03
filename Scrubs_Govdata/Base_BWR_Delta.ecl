//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Govdata.Base_BWR_Delta - Finding the Delta of Two Files - SALT V3.11.7');
IMPORT Scrubs_Govdata,SALT311;
FilePrev := DATASET([], Base_Layout_SEC_BrokerDealer);
FileNew := DATASET([], Base_Layout_SEC_BrokerDealer);
d := Scrubs_Govdata.Base_Delta(FilePrev, FileNew); // Instantiate delta module
PARALLEL(OUTPUT(d.DifferenceSummary, NAMED('Summary'), ALL),
         // The below outputs some of the differences; you may wish to send this to a file for investigation
         OUTPUT(d.Differences, NAMED('SomeDifferences')),
         // Standard layout statistics
         OUTPUT(d.StandardStats(), NAMED('StandardStats'), ALL));
