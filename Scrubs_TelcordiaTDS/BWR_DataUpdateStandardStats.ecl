//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_TelcordiaTDS.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.0');
IMPORT Scrubs_TelcordiaTDS,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_TelcordiaTDS.Layout_TelcordiaTDS, THOR);
dsPrev := DATASET(myprevfile, Scrubs_TelcordiaTDS.Layout_TelcordiaTDS, THOR);
 
hygieneStats := Scrubs_TelcordiaTDS.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_TelcordiaTDS.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_TelcordiaTDS.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
