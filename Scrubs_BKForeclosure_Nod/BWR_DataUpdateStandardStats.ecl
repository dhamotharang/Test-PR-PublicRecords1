﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BKForeclosure_Nod.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_BKForeclosure_Nod,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_BKForeclosure_Nod.Layout_BKForeclosure_Nod, THOR);
dsPrev := DATASET(myprevfile, Scrubs_BKForeclosure_Nod.Layout_BKForeclosure_Nod, THOR);
 
hygieneStats := Scrubs_BKForeclosure_Nod.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_BKForeclosure_Nod.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_BKForeclosure_Nod.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
