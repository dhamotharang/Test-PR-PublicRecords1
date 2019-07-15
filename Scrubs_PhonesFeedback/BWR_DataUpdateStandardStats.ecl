//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesFeedback.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_PhonesFeedback,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_PhonesFeedback.Layout_PhonesFeedback, THOR);
dsPrev := DATASET(myprevfile, Scrubs_PhonesFeedback.Layout_PhonesFeedback, THOR);
 
hygieneStats := Scrubs_PhonesFeedback.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_PhonesFeedback.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_PhonesFeedback.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
