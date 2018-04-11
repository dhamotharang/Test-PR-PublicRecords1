//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.NAC_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_FraudGov,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FraudGov.NAC_Layout_NAC, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FraudGov.NAC_Layout_NAC, THOR);
 
hygieneStats := Scrubs_FraudGov.NAC_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FraudGov.NAC_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FraudGov.NAC_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
