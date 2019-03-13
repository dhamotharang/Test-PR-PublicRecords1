//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_LGID3.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.3');
IMPORT BIPV2_LGID3,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, BIPV2_LGID3.Layout_LGID3, THOR);
dsPrev := DATASET(myprevfile, BIPV2_LGID3.Layout_LGID3, THOR);
 
hygieneStats := BIPV2_LGID3.hygiene(dsNew).StandardStats();
scrubsStats := BIPV2_LGID3.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), BIPV2_LGID3.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
