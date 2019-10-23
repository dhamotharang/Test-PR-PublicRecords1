//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_PhonesInfo,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_Layout_PhonesInfo, THOR);
dsPrev := DATASET(myprevfile, Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_Layout_PhonesInfo, THOR);
 
hygieneStats := Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_PhonesInfo.Daily_Raw_Wireline_to_Wireless_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
