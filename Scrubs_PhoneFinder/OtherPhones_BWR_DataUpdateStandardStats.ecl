﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhoneFinder.OtherPhones_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_PhoneFinder,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_PhoneFinder.OtherPhones_Layout_PhoneFinder, THOR);
dsPrev := DATASET(myprevfile, Scrubs_PhoneFinder.OtherPhones_Layout_PhoneFinder, THOR);
 
hygieneStats := Scrubs_PhoneFinder.OtherPhones_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_PhoneFinder.OtherPhones_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_PhoneFinder.OtherPhones_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
