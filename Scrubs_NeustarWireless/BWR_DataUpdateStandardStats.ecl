//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_NeustarWireless.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_NeustarWireless,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_NeustarWireless.Layout_NeustarWireless, THOR);
dsPrev := DATASET(myprevfile, Scrubs_NeustarWireless.Layout_NeustarWireless, THOR);
 
hygieneStats := Scrubs_NeustarWireless.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_NeustarWireless.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_NeustarWireless.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
