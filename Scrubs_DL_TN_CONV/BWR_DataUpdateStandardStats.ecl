//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_TN_CONV.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_DL_TN_CONV,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_DL_TN_CONV.Layout_In_tn_conv, THOR);
dsPrev := DATASET(myprevfile, Scrubs_DL_TN_CONV.Layout_In_tn_conv, THOR);
 
hygieneStats := Scrubs_DL_TN_CONV.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_DL_TN_CONV.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_DL_TN_CONV.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
