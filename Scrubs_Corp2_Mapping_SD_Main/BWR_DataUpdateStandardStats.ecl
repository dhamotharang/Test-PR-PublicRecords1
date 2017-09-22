﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_SD_Main.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_Corp2_Mapping_SD_Main,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Corp2_Mapping_SD_Main.Layout_In_File, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Corp2_Mapping_SD_Main.Layout_In_File, THOR);
 
hygieneStats := Scrubs_Corp2_Mapping_SD_Main.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Corp2_Mapping_SD_Main.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Corp2_Mapping_SD_Main.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
