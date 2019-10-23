//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_RealSource.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.2');
IMPORT Scrubs_RealSource,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_RealSource.Layout_RealSource, THOR);
dsPrev := DATASET(myprevfile, Scrubs_RealSource.Layout_RealSource, THOR);
 
hygieneStats := Scrubs_RealSource.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_RealSource.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_RealSource.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
