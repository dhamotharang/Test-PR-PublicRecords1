﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Database_USA.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Scrubs_Database_USA,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Database_USA.Layout_Scrubs_Database_USA.Base_In_Database_USA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Database_USA.Layout_Scrubs_Database_USA.Base_In_Database_USA, THOR);
 
hygieneStats := Scrubs_Database_USA.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Database_USA.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Database_USA.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
