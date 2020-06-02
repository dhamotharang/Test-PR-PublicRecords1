//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LitigiousDebtor.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_LitigiousDebtor,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_LitigiousDebtor.Layout_LitigiousDebtor, THOR);
dsPrev := DATASET(myprevfile, Scrubs_LitigiousDebtor.Layout_LitigiousDebtor, THOR);
 
hygieneStats := Scrubs_LitigiousDebtor.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_LitigiousDebtor.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_LitigiousDebtor.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
