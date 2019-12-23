﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CFPB.BaseFile_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_CFPB,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_CFPB.BaseFile_Layout_CFPB, THOR);
dsPrev := DATASET(myprevfile, Scrubs_CFPB.BaseFile_Layout_CFPB, THOR);
 
hygieneStats := Scrubs_CFPB.BaseFile_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_CFPB.BaseFile_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_CFPB.BaseFile_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
