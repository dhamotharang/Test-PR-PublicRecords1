//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Credit_Unions.Base_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.1');
IMPORT Scrubs_Credit_Unions,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Credit_Unions.Base_Layout_Credit_Unions, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Credit_Unions.Base_Layout_Credit_Unions, THOR);
 
hygieneStats := Scrubs_Credit_Unions.Base_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Credit_Unions.Base_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Credit_Unions.Base_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
