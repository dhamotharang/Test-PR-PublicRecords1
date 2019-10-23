//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Inql_fcra_Riskwise.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_Inql_fcra_Riskwise,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Inql_fcra_Riskwise.Layout_FILE, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Inql_fcra_Riskwise.Layout_FILE, THOR);
 
hygieneStats := Scrubs_Inql_fcra_Riskwise.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Inql_fcra_Riskwise.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Inql_fcra_Riskwise.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
