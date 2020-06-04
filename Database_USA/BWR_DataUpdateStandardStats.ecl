//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Database_USA.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Database_USA,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Database_USA.Layout_Base, THOR);
dsPrev := DATASET(myprevfile, Database_USA.Layout_Base, THOR);
 
hygieneStats := Database_USA.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
