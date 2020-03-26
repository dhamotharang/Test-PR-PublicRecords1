//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Property_Characteristics.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Property_Characteristics,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Property_Characteristics.Layout_Property_Characteristics, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Property_Characteristics.Layout_Property_Characteristics, THOR);
 
hygieneStats := Scrubs_Property_Characteristics.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Property_Characteristics.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Property_Characteristics.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
