//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Anchor.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.2');
IMPORT Scrubs_Anchor,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Anchor.Layout_Anchor, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Anchor.Layout_Anchor, THOR);
 
hygieneStats := Scrubs_Anchor.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Anchor.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Anchor.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
