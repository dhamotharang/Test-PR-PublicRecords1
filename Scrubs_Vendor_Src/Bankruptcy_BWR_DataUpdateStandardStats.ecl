//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Vendor_Src.Bankruptcy_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_Vendor_Src,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Vendor_Src.Bankruptcy_Layout_Vendor_Src, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Vendor_Src.Bankruptcy_Layout_Vendor_Src, THOR);
 
hygieneStats := Scrubs_Vendor_Src.Bankruptcy_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Vendor_Src.Bankruptcy_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Vendor_Src.Bankruptcy_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
