//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_QA_Data.Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.10.1');
IMPORT Scrubs_QA_Data,SALT310;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_QA_Data.Base_Layout_QA_Data, THOR);
dsPrev := DATASET(myprevfile, Scrubs_QA_Data.Base_Layout_QA_Data, THOR);
 
hygieneStats := Scrubs_QA_Data.Base_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_QA_Data.Base_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_QA_Data.Base_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
