//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_ConsumerStatement.DataFileNonFCRA_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_ConsumerStatement,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_ConsumerStatement.DataFileNonFCRA_Layout_ConsumerStatement, THOR);
dsPrev := DATASET(myprevfile, Scrubs_ConsumerStatement.DataFileNonFCRA_Layout_ConsumerStatement, THOR);
 
hygieneStats := Scrubs_ConsumerStatement.DataFileNonFCRA_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_ConsumerStatement.DataFileNonFCRA_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_ConsumerStatement.DataFileNonFCRA_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
