//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, HealthcareNoMatchHeader.Layout_NoMatchHeader, THOR);
dsPrev := DATASET(myprevfile, HealthcareNoMatchHeader.Layout_NoMatchHeader, THOR);
 
hygieneStats := HealthcareNoMatchHeader.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
