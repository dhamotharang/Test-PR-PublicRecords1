//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_xLink.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.10-PV1');
IMPORT InsuranceHeader_xLink,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, InsuranceHeader_xLink.Layout_InsuranceHeader, THOR);
dsPrev := DATASET(myprevfile, InsuranceHeader_xLink.Layout_InsuranceHeader, THOR);
 
hygieneStats := InsuranceHeader_xLink.hygiene(dsNew).StandardStats();
scrubsStats := InsuranceHeader_xLink.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), InsuranceHeader_xLink.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
