//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OPM.raw_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Scrubs_OPM,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_OPM.raw_Layout_OPM, THOR);
dsPrev := DATASET(myprevfile, Scrubs_OPM.raw_Layout_OPM, THOR);
 
hygieneStats := Scrubs_OPM.raw_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_OPM.raw_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_OPM.raw_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
