//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_AVM.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_AVM,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_AVM.Layout_AVM, THOR);
dsPrev := DATASET(myprevfile, Scrubs_AVM.Layout_AVM, THOR);
 
hygieneStats := Scrubs_AVM.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_AVM.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_AVM.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
