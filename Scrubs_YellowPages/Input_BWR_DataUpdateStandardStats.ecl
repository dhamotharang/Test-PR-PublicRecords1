//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_YellowPages.Input_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_YellowPages,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_YellowPages.Input_Layout_YellowPages, THOR);
dsPrev := DATASET(myprevfile, Scrubs_YellowPages.Input_Layout_YellowPages, THOR);
 
hygieneStats := Scrubs_YellowPages.Input_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_YellowPages.Input_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_YellowPages.Input_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
