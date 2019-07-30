﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareNoMatchHeader_Ingest.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT HealthCareNoMatchHeader_Ingest,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, HealthCareNoMatchHeader_Ingest.Layout_Base, THOR);
dsPrev := DATASET(myprevfile, HealthCareNoMatchHeader_Ingest.Layout_Base, THOR);
 
hygieneStats := HealthCareNoMatchHeader_Ingest.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
