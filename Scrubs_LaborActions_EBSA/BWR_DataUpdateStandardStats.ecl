//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LaborActions_EBSA.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_LaborActions_EBSA,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_LaborActions_EBSA.Layout_LaborActions_EBSA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_LaborActions_EBSA.Layout_LaborActions_EBSA, THOR);
 
hygieneStats := Scrubs_LaborActions_EBSA.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_LaborActions_EBSA.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_LaborActions_EBSA.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
