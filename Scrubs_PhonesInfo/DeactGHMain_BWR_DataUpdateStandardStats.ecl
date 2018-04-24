//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.DeactGHMain_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.10.0');
IMPORT Scrubs_PhonesInfo,SALT310;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name

// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_PhonesInfo.DeactGHMain_Layout_PhonesInfo, THOR);
dsPrev := DATASET(myprevfile, Scrubs_PhonesInfo.DeactGHMain_Layout_PhonesInfo, THOR);

hygieneStats := Scrubs_PhonesInfo.DeactGHMain_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_PhonesInfo.DeactGHMain_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_PhonesInfo.DeactGHMain_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
