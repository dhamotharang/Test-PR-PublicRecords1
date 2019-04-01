//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_infutor_narc3.raw_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.3');
IMPORT scrubs_infutor_narc3,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, scrubs_infutor_narc3.raw_Layout_infutor_narc3, THOR);
dsPrev := DATASET(myprevfile, scrubs_infutor_narc3.raw_Layout_infutor_narc3, THOR);
 
hygieneStats := scrubs_infutor_narc3.raw_hygiene(dsNew).StandardStats();
scrubsStats := scrubs_infutor_narc3.raw_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), scrubs_infutor_narc3.raw_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
