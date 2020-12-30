//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Database_USA.Input_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_Database_USA,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Database_USA.Input_Layout_Database_USA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Database_USA.Input_Layout_Database_USA, THOR);
 
hygieneStats := Scrubs_Database_USA.Input_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Database_USA.Input_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Database_USA.Input_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
