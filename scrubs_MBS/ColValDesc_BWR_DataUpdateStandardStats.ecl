//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.ColValDesc_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_MBS.ColValDesc_Layout_ColValDesc, THOR);
dsPrev := DATASET(myprevfile, Scrubs_MBS.ColValDesc_Layout_ColValDesc, THOR);
 
hygieneStats := Scrubs_MBS.ColValDesc_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_MBS.ColValDesc_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_MBS.ColValDesc_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
