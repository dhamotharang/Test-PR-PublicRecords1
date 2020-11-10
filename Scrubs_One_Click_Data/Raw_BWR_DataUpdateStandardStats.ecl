//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_One_Click_Data.Raw_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Scrubs_One_Click_Data,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_One_Click_Data.Raw_Layout_One_Click_Data, THOR);
dsPrev := DATASET(myprevfile, Scrubs_One_Click_Data.Raw_Layout_One_Click_Data, THOR);
 
hygieneStats := Scrubs_One_Click_Data.Raw_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_One_Click_Data.Raw_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_One_Click_Data.Raw_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
