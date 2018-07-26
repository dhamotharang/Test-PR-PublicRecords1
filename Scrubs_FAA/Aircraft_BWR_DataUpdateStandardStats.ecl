//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FAA.Aircraft_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.2');
IMPORT Scrubs_FAA,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FAA.Aircraft_Layout_FAA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FAA.Aircraft_Layout_FAA, THOR);
 
hygieneStats := Scrubs_FAA.Aircraft_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FAA.Aircraft_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FAA.Aircraft_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
