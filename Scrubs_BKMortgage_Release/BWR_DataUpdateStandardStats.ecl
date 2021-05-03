//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BKMortgage_Release.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_BKMortgage_Release,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_BKMortgage_Release.Layout_BKMortgage_Release, THOR);
dsPrev := DATASET(myprevfile, Scrubs_BKMortgage_Release.Layout_BKMortgage_Release, THOR);
 
hygieneStats := Scrubs_BKMortgage_Release.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_BKMortgage_Release.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_BKMortgage_Release.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
