//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DunnData_Email.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_DunnData_Email,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_DunnData_Email.Layout_DunnData_Email, THOR);
dsPrev := DATASET(myprevfile, Scrubs_DunnData_Email.Layout_DunnData_Email, THOR);
 
hygieneStats := Scrubs_DunnData_Email.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_DunnData_Email.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_DunnData_Email.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
