//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_TelcordiaTPM.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.0');
IMPORT Scrubs_TelcordiaTPM,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_TelcordiaTPM.Layout_TelcordiaTPM, THOR);
dsPrev := DATASET(myprevfile, Scrubs_TelcordiaTPM.Layout_TelcordiaTPM, THOR);
 
hygieneStats := Scrubs_TelcordiaTPM.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_TelcordiaTPM.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_TelcordiaTPM.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
