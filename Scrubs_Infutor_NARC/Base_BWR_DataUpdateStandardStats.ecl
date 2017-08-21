//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Infutor_NARC.Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_Infutor_NARC,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Infutor_NARC.Base_Layout_Infutor_NARC, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Infutor_NARC.Base_Layout_Infutor_NARC, THOR);
 
hygieneStats := Scrubs_Infutor_NARC.Base_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Infutor_NARC.Base_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Infutor_NARC.Base_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
