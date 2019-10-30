﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_FL_Filing_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FBNV2.Input_FL_Filing_Layout_FBNV2, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FBNV2.Input_FL_Filing_Layout_FBNV2, THOR);
 
hygieneStats := Scrubs_FBNV2.Input_FL_Filing_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FBNV2.Input_FL_Filing_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FBNV2.Input_FL_Filing_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
