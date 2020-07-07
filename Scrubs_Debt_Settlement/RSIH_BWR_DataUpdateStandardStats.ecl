//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Debt_Settlement.RSIH_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Scrubs_Debt_Settlement,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Debt_Settlement.RSIH_Layout_Debt_Settlement, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Debt_Settlement.RSIH_Layout_Debt_Settlement, THOR);
 
hygieneStats := Scrubs_Debt_Settlement.RSIH_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Debt_Settlement.RSIH_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Debt_Settlement.RSIH_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
