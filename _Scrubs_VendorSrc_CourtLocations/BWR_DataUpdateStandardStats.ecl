//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','_Scrubs_VendorSrc_CourtLocations.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT _Scrubs_VendorSrc_CourtLocations,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, _Scrubs_VendorSrc_CourtLocations.Layout_CourtLocations, THOR);
dsPrev := DATASET(myprevfile, _Scrubs_VendorSrc_CourtLocations.Layout_CourtLocations, THOR);
 
hygieneStats := _Scrubs_VendorSrc_CourtLocations.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
