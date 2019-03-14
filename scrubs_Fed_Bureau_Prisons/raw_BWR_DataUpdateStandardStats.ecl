//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_Fed_Bureau_Prisons.raw_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.3');
IMPORT scrubs_Fed_Bureau_Prisons,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, scrubs_Fed_Bureau_Prisons.raw_Layout_Fed_Bureau_Prisons, THOR);
dsPrev := DATASET(myprevfile, scrubs_Fed_Bureau_Prisons.raw_Layout_Fed_Bureau_Prisons, THOR);
 
hygieneStats := scrubs_Fed_Bureau_Prisons.raw_hygiene(dsNew).StandardStats();
scrubsStats := scrubs_Fed_Bureau_Prisons.raw_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), scrubs_Fed_Bureau_Prisons.raw_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
