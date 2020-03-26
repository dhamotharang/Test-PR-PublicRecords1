//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SKA.Base_Verified_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_SKA,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_SKA.Base_Verified_Layout_SKA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_SKA.Base_Verified_Layout_SKA, THOR);
 
hygieneStats := Scrubs_SKA.Base_Verified_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_SKA.Base_Verified_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_SKA.Base_Verified_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
