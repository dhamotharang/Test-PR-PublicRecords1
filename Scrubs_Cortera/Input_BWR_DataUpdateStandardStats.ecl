//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Cortera.Input_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_Cortera,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Cortera.Input_Layout_Cortera, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Cortera.Input_Layout_Cortera, THOR);
 
hygieneStats := Scrubs_Cortera.Input_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Cortera.Input_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Cortera.Input_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
