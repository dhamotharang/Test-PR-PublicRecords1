//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_InternalLinking.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader_InternalLinking,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, HealthcareNoMatchHeader_InternalLinking.Layout_HEADER, THOR);
dsPrev := DATASET(myprevfile, HealthcareNoMatchHeader_InternalLinking.Layout_HEADER, THOR);
 
hygieneStats := HealthcareNoMatchHeader_InternalLinking.hygiene(dsNew).StandardStats();
scrubsStats := HealthcareNoMatchHeader_InternalLinking.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), HealthcareNoMatchHeader_InternalLinking.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
