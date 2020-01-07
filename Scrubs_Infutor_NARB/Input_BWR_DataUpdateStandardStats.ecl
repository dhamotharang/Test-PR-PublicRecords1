//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Infutor_NARB.Input_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_Infutor_NARB,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Infutor_NARB.Input_Layout_Infutor_NARB, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Infutor_NARB.Input_Layout_Infutor_NARB, THOR);
 
hygieneStats := Scrubs_Infutor_NARB.Input_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Infutor_NARB.Input_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Infutor_NARB.Input_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
