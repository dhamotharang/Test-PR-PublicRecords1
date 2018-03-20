//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Experian_CRDB.Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_Experian_CRDB,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Experian_CRDB.Base_Layout_Experian_CRDB, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Experian_CRDB.Base_Layout_Experian_CRDB, THOR);
 
hygieneStats := Scrubs_Experian_CRDB.Base_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Experian_CRDB.Base_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Experian_CRDB.Base_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
