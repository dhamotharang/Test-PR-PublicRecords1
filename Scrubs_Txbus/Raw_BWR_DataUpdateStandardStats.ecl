//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Txbus.Raw_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.1');
IMPORT Scrubs_Txbus,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Txbus.Raw_Layout_Txbus, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Txbus.Raw_Layout_Txbus, THOR);
 
hygieneStats := Scrubs_Txbus.Raw_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Txbus.Raw_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Txbus.Raw_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
