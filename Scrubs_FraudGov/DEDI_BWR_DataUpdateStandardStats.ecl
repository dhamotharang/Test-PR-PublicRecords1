//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.DEDI_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_FraudGov,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FraudGov.DEDI_Layout_DEDI, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FraudGov.DEDI_Layout_DEDI, THOR);
hygieneStats := Scrubs_FraudGov.DEDI_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FraudGov.DEDI_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FraudGov.DEDI_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
