﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IRS5500.Raw_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Scrubs_IRS5500,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_IRS5500.Raw_Layout_IRS5500, THOR);
dsPrev := DATASET(myprevfile, Scrubs_IRS5500.Raw_Layout_IRS5500, THOR);
 
hygieneStats := Scrubs_IRS5500.Raw_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_IRS5500.Raw_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_IRS5500.Raw_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
