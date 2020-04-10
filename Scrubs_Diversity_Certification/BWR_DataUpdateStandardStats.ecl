﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Diversity_Certification.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Diversity_Certification,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Diversity_Certification.Layout_Diversity_Certification, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Diversity_Certification.Layout_Diversity_Certification, THOR);
 
hygieneStats := Scrubs_Diversity_Certification.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Diversity_Certification.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Diversity_Certification.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
