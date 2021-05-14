//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OneKey.InputA_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_OneKey,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_OneKey.InputA_Layout_OneKey, THOR);
dsPrev := DATASET(myprevfile, Scrubs_OneKey.InputA_Layout_OneKey, THOR);
 
hygieneStats := Scrubs_OneKey.InputA_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_OneKey.InputA_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_OneKey.InputA_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
