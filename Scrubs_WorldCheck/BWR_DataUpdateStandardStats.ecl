//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_WorldCheck.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_WorldCheck,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_WorldCheck.Layout_WorldCheck, THOR);
dsPrev := DATASET(myprevfile, Scrubs_WorldCheck.Layout_WorldCheck, THOR);
 
hygieneStats := Scrubs_WorldCheck.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_WorldCheck.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_WorldCheck.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
