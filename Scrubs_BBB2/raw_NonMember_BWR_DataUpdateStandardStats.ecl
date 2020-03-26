//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_BBB2.raw_NonMember_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.7');
IMPORT Scrubs_BBB2,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_BBB2.raw_NonMember_Layout_BBB2, THOR);
dsPrev := DATASET(myprevfile, Scrubs_BBB2.raw_NonMember_Layout_BBB2, THOR);
 
hygieneStats := Scrubs_BBB2.raw_NonMember_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_BBB2.raw_NonMember_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_BBB2.raw_NonMember_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
