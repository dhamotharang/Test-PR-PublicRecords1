﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Business_Credit.BS_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Business_Credit,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Business_Credit.BS_Layout_Business_Credit, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Business_Credit.BS_Layout_Business_Credit, THOR);
 
hygieneStats := Scrubs_Business_Credit.BS_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Business_Credit.BS_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Business_Credit.BS_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
