//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FAA.Airmen_Cert_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_FAA,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FAA.Airmen_Cert_Layout_FAA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FAA.Airmen_Cert_Layout_FAA, THOR);
 
hygieneStats := Scrubs_FAA.Airmen_Cert_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FAA.Airmen_Cert_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FAA.Airmen_Cert_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
