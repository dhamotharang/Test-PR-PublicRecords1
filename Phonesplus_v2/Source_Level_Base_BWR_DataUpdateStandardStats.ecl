//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','PhonesPlus_V2.Source_Level_Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT PhonesPlus_V2,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, PhonesPlus_V2.Source_Level_Base_Layout_Source_Level_Base, THOR);
dsPrev := DATASET(myprevfile, PhonesPlus_V2.Source_Level_Base_Layout_Source_Level_Base, THOR);
 
hygieneStats := PhonesPlus_V2.Source_Level_Base_hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
