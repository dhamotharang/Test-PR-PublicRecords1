//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IDA.RawInput_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_IDA,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name

// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_IDA.RawInput_Layout_IDA, THOR);
dsPrev := DATASET(myprevfile, Scrubs_IDA.RawInput_Layout_IDA, THOR);

hygieneStats := Scrubs_IDA.RawInput_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_IDA.RawInput_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_IDA.RawInput_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
