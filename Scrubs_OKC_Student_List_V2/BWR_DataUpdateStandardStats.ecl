﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OKC_Student_List_V2.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_OKC_Student_List_V2,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_OKC_Student_List_V2.Layout_OKC_Student_List, THOR);
dsPrev := DATASET(myprevfile, Scrubs_OKC_Student_List_V2.Layout_OKC_Student_List, THOR);
 
hygieneStats := Scrubs_OKC_Student_List_V2.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_OKC_Student_List_V2.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_OKC_Student_List_V2.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
