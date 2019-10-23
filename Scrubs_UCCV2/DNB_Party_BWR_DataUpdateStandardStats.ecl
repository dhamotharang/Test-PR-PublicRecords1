//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_UCCV2.DNB_Party_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_UCCV2,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_UCCV2.DNB_Party_Layout_UCCV2, THOR);
dsPrev := DATASET(myprevfile, Scrubs_UCCV2.DNB_Party_Layout_UCCV2, THOR);
 
hygieneStats := Scrubs_UCCV2.DNB_Party_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_UCCV2.DNB_Party_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_UCCV2.DNB_Party_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
