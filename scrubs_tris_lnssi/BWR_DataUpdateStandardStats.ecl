//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_tris_lnssi.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT scrubs_tris_lnssi,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name

// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, scrubs_tris_lnssi.Layout_tris_lnssi, THOR);
dsPrev := DATASET(myprevfile, scrubs_tris_lnssi.Layout_tris_lnssi, THOR);

hygieneStats := scrubs_tris_lnssi.hygiene(dsNew).StandardStats();
scrubsStats := scrubs_tris_lnssi.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), scrubs_tris_lnssi.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
