//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BKForeclosure_Reo.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_BKForeclosure_Reo,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_BKForeclosure_Reo.Layout_BKForeclosure_Reo, THOR);
dsPrev := DATASET(myprevfile, Scrubs_BKForeclosure_Reo.Layout_BKForeclosure_Reo, THOR);
 
hygieneStats := Scrubs_BKForeclosure_Reo.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_BKForeclosure_Reo.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_BKForeclosure_Reo.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
