//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Search.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_LN_PropertyV2_Search,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_LN_PropertyV2_Search.Layout_LN_PropertyV2_Search, THOR);
dsPrev := DATASET(myprevfile, Scrubs_LN_PropertyV2_Search.Layout_LN_PropertyV2_Search, THOR);
 
hygieneStats := Scrubs_LN_PropertyV2_Search.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_LN_PropertyV2_Search.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_LN_PropertyV2_Search.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
