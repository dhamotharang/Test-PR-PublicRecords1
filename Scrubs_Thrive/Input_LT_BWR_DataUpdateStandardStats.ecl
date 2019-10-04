//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Thrive.Input_LT_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Scrubs_Thrive,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Thrive.Input_LT_Layout_Thrive, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Thrive.Input_LT_Layout_Thrive, THOR);
 
hygieneStats := Scrubs_Thrive.Input_LT_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Thrive.Input_LT_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Thrive.Input_LT_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
