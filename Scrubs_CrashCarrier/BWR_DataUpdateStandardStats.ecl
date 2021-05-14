//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CrashCarrier.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Scrubs_CrashCarrier,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_CrashCarrier.Layout_In_CrashCarrier, THOR);
dsPrev := DATASET(myprevfile, Scrubs_CrashCarrier.Layout_In_CrashCarrier, THOR);
 
hygieneStats := Scrubs_CrashCarrier.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_CrashCarrier.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_CrashCarrier.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
