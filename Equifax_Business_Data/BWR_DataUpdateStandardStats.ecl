//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Equifax_Business_Data.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Equifax_Business_Data,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Equifax_Business_Data.Layout_Base, THOR);
dsPrev := DATASET(myprevfile, Equifax_Business_Data.Layout_Base, THOR);
 
hygieneStats := Equifax_Business_Data.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
