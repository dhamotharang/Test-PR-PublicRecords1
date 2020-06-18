//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CanadianPhones.InfutorWP_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_CanadianPhones,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_CanadianPhones.InfutorWP_Layout_CanadianPhones, THOR);
dsPrev := DATASET(myprevfile, Scrubs_CanadianPhones.InfutorWP_Layout_CanadianPhones, THOR);
 
hygieneStats := Scrubs_CanadianPhones.InfutorWP_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_CanadianPhones.InfutorWP_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_CanadianPhones.InfutorWP_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
