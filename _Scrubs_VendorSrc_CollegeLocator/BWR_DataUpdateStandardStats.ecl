//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','_Scrubs_VendorSrc_CollegeLocator.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT _Scrubs_VendorSrc_CollegeLocator,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, _Scrubs_VendorSrc_CollegeLocator.Layout_CollegeLocator, THOR);
dsPrev := DATASET(myprevfile, _Scrubs_VendorSrc_CollegeLocator.Layout_CollegeLocator, THOR);
 
hygieneStats := _Scrubs_VendorSrc_CollegeLocator.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
