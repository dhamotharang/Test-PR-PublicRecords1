//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Overrides.IndFlag_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_Overrides,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Overrides.IndFlag_Layout_Overrides, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Overrides.IndFlag_Layout_Overrides, THOR);
 
hygieneStats := Scrubs_Overrides.IndFlag_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Overrides.IndFlag_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Overrides.IndFlag_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
