//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IRS_Nonprofit.Input_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_IRS_Nonprofit,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_IRS_Nonprofit.Input_Layout_IRS_Nonprofit, THOR);
dsPrev := DATASET(myprevfile, Scrubs_IRS_Nonprofit.Input_Layout_IRS_Nonprofit, THOR);
 
hygieneStats := Scrubs_IRS_Nonprofit.Input_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_IRS_Nonprofit.Input_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_IRS_Nonprofit.Input_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
