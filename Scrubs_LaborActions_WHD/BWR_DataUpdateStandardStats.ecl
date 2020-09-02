//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LaborActions_WHD.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_LaborActions_WHD,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_LaborActions_WHD.Layout_LaborActions_WHD, THOR);
dsPrev := DATASET(myprevfile, Scrubs_LaborActions_WHD.Layout_LaborActions_WHD, THOR);
 
hygieneStats := Scrubs_LaborActions_WHD.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_LaborActions_WHD.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_LaborActions_WHD.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
