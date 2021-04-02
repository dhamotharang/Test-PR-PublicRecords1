//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V4.4.1');
IMPORT BizLinkFull,SALT44;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, BizLinkFull.Layout_BizHead, THOR);
dsPrev := DATASET(myprevfile, BizLinkFull.Layout_BizHead, THOR);
 
hygieneStats := BizLinkFull.hygiene(dsNew).StandardStats();
scrubsStats := BizLinkFull.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), BizLinkFull.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
