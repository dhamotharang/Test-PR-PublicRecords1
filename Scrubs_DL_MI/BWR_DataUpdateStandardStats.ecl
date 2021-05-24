//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_MI.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Scrubs_DL_MI,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_DL_MI.Layout_In_MI, THOR);
dsPrev := DATASET(myprevfile, Scrubs_DL_MI.Layout_In_MI, THOR);
 
hygieneStats := Scrubs_DL_MI.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_DL_MI.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_DL_MI.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
