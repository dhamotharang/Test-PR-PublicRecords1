//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.Moxie_DOC_Offenses_Dev_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Crim.Moxie_DOC_Offenses_Dev_Layout_crim, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Crim.Moxie_DOC_Offenses_Dev_Layout_crim, THOR);
 
hygieneStats := Scrubs_Crim.Moxie_DOC_Offenses_Dev_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Crim.Moxie_DOC_Offenses_Dev_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Crim.Moxie_DOC_Offenses_Dev_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
