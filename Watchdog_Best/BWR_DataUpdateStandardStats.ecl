//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Watchdog_best.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Watchdog_best,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name

// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Watchdog_best.Layout_Hdr, THOR);
dsPrev := DATASET(myprevfile, Watchdog_best.Layout_Hdr, THOR);

hygieneStats := Watchdog_best.hygiene(dsNew).StandardStats();
scrubsStats := Watchdog_best.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Watchdog_best.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
