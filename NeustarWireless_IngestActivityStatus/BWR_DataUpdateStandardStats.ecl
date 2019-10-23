//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless_IngestActivityStatus.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT NeustarWireless_IngestActivityStatus,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, NeustarWireless_IngestActivityStatus.Layout_NeustarWireless.Files.Base.Activity_Status, THOR);
dsPrev := DATASET(myprevfile, NeustarWireless_IngestActivityStatus.Layout_NeustarWireless.Files.Base.Activity_Status, THOR);
 
hygieneStats := NeustarWireless_IngestActivityStatus.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
