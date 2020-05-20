//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Watercraft_Search.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Watercraft_Search,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Watercraft_Search.Layout_Watercraft_Search, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Watercraft_Search.Layout_Watercraft_Search, THOR);
 
hygieneStats := Scrubs_Watercraft_Search.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Watercraft_Search.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Watercraft_Search.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
