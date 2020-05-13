//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.addresshistory_doc_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Crim.addresshistory_doc_Layout_crim, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Crim.addresshistory_doc_Layout_crim, THOR);
 
hygieneStats := Scrubs_Crim.addresshistory_doc_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Crim.addresshistory_doc_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Crim.addresshistory_doc_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
