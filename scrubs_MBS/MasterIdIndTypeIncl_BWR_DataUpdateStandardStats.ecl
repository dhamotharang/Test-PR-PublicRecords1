//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.MasterIdIndTypeIncl_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_MBS.MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl, THOR);
dsPrev := DATASET(myprevfile, Scrubs_MBS.MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl, THOR);
 
hygieneStats := Scrubs_MBS.MasterIdIndTypeIncl_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_MBS.MasterIdIndTypeIncl_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_MBS.MasterIdIndTypeIncl_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
