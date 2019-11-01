﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_NH_Event.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Scrubs_Corp2_Mapping_NH_Event,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Corp2_Mapping_NH_Event.Layout_In_NH, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Corp2_Mapping_NH_Event.Layout_In_NH, THOR);
 
hygieneStats := Scrubs_Corp2_Mapping_NH_Event.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Corp2_Mapping_NH_Event.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Corp2_Mapping_NH_Event.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
