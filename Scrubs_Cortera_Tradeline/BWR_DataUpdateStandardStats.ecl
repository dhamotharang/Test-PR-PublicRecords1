//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Cortera_Tradeline.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_Cortera_Tradeline,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name

// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Cortera_Tradeline.Layout_Cortera_Tradeline, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Cortera_Tradeline.Layout_Cortera_Tradeline, THOR);

hygieneStats := Scrubs_Cortera_Tradeline.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Cortera_Tradeline.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Cortera_Tradeline.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
