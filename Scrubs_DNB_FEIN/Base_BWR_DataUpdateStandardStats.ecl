//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DNB_FEIN.Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_DNB_FEIN,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_DNB_FEIN.Base_Layout_DNB_FEIN, THOR);
dsPrev := DATASET(myprevfile, Scrubs_DNB_FEIN.Base_Layout_DNB_FEIN, THOR);
 
hygieneStats := Scrubs_DNB_FEIN.Base_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_DNB_FEIN.Base_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_DNB_FEIN.Base_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
