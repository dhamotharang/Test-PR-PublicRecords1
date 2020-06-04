//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_ExternalLinking.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader_ExternalLinking,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, HealthcareNoMatchHeader_ExternalLinking.Layout_HEADER, THOR);
dsPrev := DATASET(myprevfile, HealthcareNoMatchHeader_ExternalLinking.Layout_HEADER, THOR);
 
hygieneStats := HealthcareNoMatchHeader_ExternalLinking.hygiene(dsNew).StandardStats();
scrubsStats := HealthcareNoMatchHeader_ExternalLinking.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), HealthcareNoMatchHeader_ExternalLinking.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
