//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Insurance_Cert.Cert_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Insurance_Cert,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Insurance_Cert.Cert_Layout_Insurance_Cert, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Insurance_Cert.Cert_Layout_Insurance_Cert, THOR);
 
hygieneStats := Scrubs_Insurance_Cert.Cert_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Insurance_Cert.Cert_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Insurance_Cert.Cert_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
