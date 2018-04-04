//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Certegy.raw_file_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_Certegy,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Certegy.raw_file_Layout_Certegy, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Certegy.raw_file_Layout_Certegy, THOR);
 
hygieneStats := Scrubs_Certegy.raw_file_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Certegy.raw_file_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Certegy.raw_file_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
