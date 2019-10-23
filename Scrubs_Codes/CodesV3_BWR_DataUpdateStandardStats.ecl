//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Codes.CodesV3_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_Codes,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Codes.CodesV3_Layout_Codes, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Codes.CodesV3_Layout_Codes, THOR);
 
hygieneStats := Scrubs_Codes.CodesV3_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Codes.CodesV3_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Codes.CodesV3_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
