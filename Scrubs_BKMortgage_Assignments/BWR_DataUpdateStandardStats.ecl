//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BKMortgage_Assignments.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_BKMortgage_Assignments,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_BKMortgage_Assignments.Layout_BKMortgage_Assignments, THOR);
dsPrev := DATASET(myprevfile, Scrubs_BKMortgage_Assignments.Layout_BKMortgage_Assignments, THOR);
 
hygieneStats := Scrubs_BKMortgage_Assignments.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_BKMortgage_Assignments.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_BKMortgage_Assignments.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
