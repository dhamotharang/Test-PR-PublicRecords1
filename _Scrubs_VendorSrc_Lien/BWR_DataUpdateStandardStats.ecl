﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','_Scrubs_VendorSrc_Lien.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT _Scrubs_VendorSrc_Lien,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, _Scrubs_VendorSrc_Lien.Layout_Lien, THOR);
dsPrev := DATASET(myprevfile, _Scrubs_VendorSrc_Lien.Layout_Lien, THOR);
 
hygieneStats := _Scrubs_VendorSrc_Lien.hygiene(dsNew).StandardStats();
scrubsStats := _Scrubs_VendorSrc_Lien.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), _Scrubs_VendorSrc_Lien.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
