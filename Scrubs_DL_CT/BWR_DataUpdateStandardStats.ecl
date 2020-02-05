//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_CT.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Scrubs_DL_CT,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_DL_CT.Layout_In_CT, THOR);
dsPrev := DATASET(myprevfile, Scrubs_DL_CT.Layout_In_CT, THOR);
 
hygieneStats := Scrubs_DL_CT.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_DL_CT.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_DL_CT.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
