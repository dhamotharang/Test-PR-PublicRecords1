//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.RelatedActivity_Raw_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_OSHAIR.RelatedActivity_Raw_Layout_RelatedActivity_Raw_In_OSHAIR, THOR);
dsPrev := DATASET(myprevfile, Scrubs_OSHAIR.RelatedActivity_Raw_Layout_RelatedActivity_Raw_In_OSHAIR, THOR);
 
hygieneStats := Scrubs_OSHAIR.RelatedActivity_Raw_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_OSHAIR.RelatedActivity_Raw_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_OSHAIR.RelatedActivity_Raw_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
