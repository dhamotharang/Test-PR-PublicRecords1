//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTNKeys.party_aka_dba_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_SANCTNKeys,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_SANCTNKeys.party_aka_dba_Layout_SANCTNKeys, THOR);
dsPrev := DATASET(myprevfile, Scrubs_SANCTNKeys.party_aka_dba_Layout_SANCTNKeys, THOR);
 
hygieneStats := Scrubs_SANCTNKeys.party_aka_dba_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_SANCTNKeys.party_aka_dba_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_SANCTNKeys.party_aka_dba_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
