//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_bank_routing.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.1');
IMPORT scrubs_bank_routing,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, scrubs_bank_routing.Layout_bank_routing.Files.base, THOR);
dsPrev := DATASET(myprevfile, scrubs_bank_routing.Layout_bank_routing.Files.base, THOR);
 
hygieneStats := scrubs_bank_routing.hygiene(dsNew).StandardStats();
scrubsStats := scrubs_bank_routing.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), scrubs_bank_routing.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
