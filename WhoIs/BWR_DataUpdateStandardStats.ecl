//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','WhoIs.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT WhoIs,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, WhoIs.Layout_WhoIs, THOR);
dsPrev := DATASET(myprevfile, WhoIs.Layout_WhoIs, THOR);
 
hygieneStats := WhoIs.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
