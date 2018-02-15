﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Phonesinfo.DeactRaw2_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.10.1');
IMPORT Scrubs_Phonesinfo,SALT310;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Phonesinfo.DeactRaw2_Layout_Phonesinfo, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Phonesinfo.DeactRaw2_Layout_Phonesinfo, THOR);
 
hygieneStats := Scrubs_Phonesinfo.DeactRaw2_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Phonesinfo.DeactRaw2_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Phonesinfo.DeactRaw2_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
