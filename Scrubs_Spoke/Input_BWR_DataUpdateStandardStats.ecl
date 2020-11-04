//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Spoke.Input_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_Spoke,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Spoke.Input_Layout_Spoke, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Spoke.Input_Layout_Spoke, THOR);
 
hygieneStats := Scrubs_Spoke.Input_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Spoke.Input_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Spoke.Input_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
