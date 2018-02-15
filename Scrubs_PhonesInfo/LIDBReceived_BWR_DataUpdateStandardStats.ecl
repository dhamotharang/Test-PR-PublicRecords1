﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.LIDBReceived_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.10.1');
IMPORT Scrubs_PhonesInfo,SALT310;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_PhonesInfo.LIDBReceived_Layout_PhonesInfo, THOR);
dsPrev := DATASET(myprevfile, Scrubs_PhonesInfo.LIDBReceived_Layout_PhonesInfo, THOR);
 
hygieneStats := Scrubs_PhonesInfo.LIDBReceived_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_PhonesInfo.LIDBReceived_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_PhonesInfo.LIDBReceived_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
