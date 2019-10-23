//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Cortera_Tradeline.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Cortera_Tradeline,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name

// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Cortera_Tradeline.Layout_Tradeline, THOR);
dsPrev := DATASET(myprevfile, Cortera_Tradeline.Layout_Tradeline, THOR);

hygieneStats := Cortera_Tradeline.hygiene(dsNew).StandardStats();
scrubsStats := Cortera_Tradeline.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Cortera_Tradeline.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
