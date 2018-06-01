//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CityStateZip.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.0');
IMPORT Scrubs_CityStateZip,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_CityStateZip.Layout_CityStateZip, THOR);
dsPrev := DATASET(myprevfile, Scrubs_CityStateZip.Layout_CityStateZip, THOR);
 
hygieneStats := Scrubs_CityStateZip.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_CityStateZip.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_CityStateZip.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
