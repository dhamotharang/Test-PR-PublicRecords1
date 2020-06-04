//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_UCCV2.IL_Main_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_UCCV2,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_UCCV2.IL_Main_Layout_UCCV2, THOR);
dsPrev := DATASET(myprevfile, Scrubs_UCCV2.IL_Main_Layout_UCCV2, THOR);
 
hygieneStats := Scrubs_UCCV2.IL_Main_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_UCCV2.IL_Main_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_UCCV2.IL_Main_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
