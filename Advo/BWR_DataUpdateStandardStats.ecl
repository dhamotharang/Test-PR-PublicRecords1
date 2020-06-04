//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Advo.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Advo,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Advo.Layout_Scrubs, THOR);
dsPrev := DATASET(myprevfile, Advo.Layout_Scrubs, THOR);
 
hygieneStats := Advo.hygiene(dsNew).StandardStats();
scrubsStats := Advo.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Advo.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
