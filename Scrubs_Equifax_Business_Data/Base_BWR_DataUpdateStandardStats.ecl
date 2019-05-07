//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Equifax_Business_Data.Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_Equifax_Business_Data,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Equifax_Business_Data.Base_Layout_Equifax_Business_Data, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Equifax_Business_Data.Base_Layout_Equifax_Business_Data, THOR);
 
hygieneStats := Scrubs_Equifax_Business_Data.Base_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Equifax_Business_Data.Base_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Equifax_Business_Data.Base_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
