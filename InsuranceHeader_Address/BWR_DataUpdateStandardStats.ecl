//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_Address.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.3');
IMPORT InsuranceHeader_Address,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, InsuranceHeader_Address.Layout_Address_Link, THOR);
dsPrev := DATASET(myprevfile, InsuranceHeader_Address.Layout_Address_Link, THOR);
 
hygieneStats := InsuranceHeader_Address.hygiene(dsNew).StandardStats();
scrubsStats := InsuranceHeader_Address.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), InsuranceHeader_Address.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
