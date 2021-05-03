//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Voters.In_Reg_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_Voters,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Voters.In_Reg_Layout_Voters, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Voters.In_Reg_Layout_Voters, THOR);
 
hygieneStats := Scrubs_Voters.In_Reg_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Voters.In_Reg_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Voters.In_Reg_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
