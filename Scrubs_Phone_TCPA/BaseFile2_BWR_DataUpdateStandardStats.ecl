//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Phone_TCPA.BaseFile2_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_Phone_TCPA,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Phone_TCPA.BaseFile2_Layout_Phone_TCPA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Phone_TCPA.BaseFile2_Layout_Phone_TCPA, THOR);
 
hygieneStats := Scrubs_Phone_TCPA.BaseFile2_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Phone_TCPA.BaseFile2_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Phone_TCPA.BaseFile2_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
