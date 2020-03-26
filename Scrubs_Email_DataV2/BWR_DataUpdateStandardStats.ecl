//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Email_DataV2.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.6');
IMPORT Scrubs_Email_DataV2,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Email_DataV2.Layout_Email_DataV2, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Email_DataV2.Layout_Email_DataV2, THOR);
 
hygieneStats := Scrubs_Email_DataV2.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
