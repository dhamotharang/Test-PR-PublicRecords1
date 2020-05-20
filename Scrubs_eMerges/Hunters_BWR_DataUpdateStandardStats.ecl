//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_eMerges.Hunters_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_eMerges,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_eMerges.Hunters_Layout_eMerges, THOR);
dsPrev := DATASET(myprevfile, Scrubs_eMerges.Hunters_Layout_eMerges, THOR);
 
hygieneStats := Scrubs_eMerges.Hunters_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_eMerges.Hunters_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_eMerges.Hunters_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
