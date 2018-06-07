﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BIPV2.Ingest_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_BIPV2,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_BIPV2.Ingest_Layout_BIPV2, THOR);
dsPrev := DATASET(myprevfile, Scrubs_BIPV2.Ingest_Layout_BIPV2, THOR);
 
hygieneStats := Scrubs_BIPV2.Ingest_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_BIPV2.Ingest_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_BIPV2.Ingest_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
