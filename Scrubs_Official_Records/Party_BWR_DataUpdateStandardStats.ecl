//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Official_Records.Party_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT Scrubs_Official_Records,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Official_Records.Party_Layout_Official_Records, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Official_Records.Party_Layout_Official_Records, THOR);
 
hygieneStats := Scrubs_Official_Records.Party_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Official_Records.Party_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Official_Records.Party_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
