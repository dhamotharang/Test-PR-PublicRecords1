//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.PhonesTypeMain_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_PhonesInfo,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_PhonesInfo.PhonesTypeMain_Layout_PhonesInfo, THOR);
dsPrev := DATASET(myprevfile, Scrubs_PhonesInfo.PhonesTypeMain_Layout_PhonesInfo, THOR);
 
hygieneStats := Scrubs_PhonesInfo.PhonesTypeMain_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_PhonesInfo.PhonesTypeMain_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_PhonesInfo.PhonesTypeMain_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
