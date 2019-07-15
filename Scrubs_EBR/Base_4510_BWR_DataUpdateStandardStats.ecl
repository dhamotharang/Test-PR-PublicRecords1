//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_4510_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_EBR.Base_4510_Layout_EBR, THOR);
dsPrev := DATASET(myprevfile, Scrubs_EBR.Base_4510_Layout_EBR, THOR);
 
hygieneStats := Scrubs_EBR.Base_4510_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_EBR.Base_4510_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_EBR.Base_4510_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
