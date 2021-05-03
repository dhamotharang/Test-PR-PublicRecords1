//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Govdata.Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Scrubs_Govdata,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Govdata.Base_Layout_SEC_BrokerDealer, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Govdata.Base_Layout_SEC_BrokerDealer, THOR);
 
hygieneStats := Scrubs_Govdata.Base_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Govdata.Base_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Govdata.Base_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
