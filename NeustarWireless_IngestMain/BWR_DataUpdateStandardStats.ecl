//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless_IngestMain.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.4');
IMPORT NeustarWireless_IngestMain,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, NeustarWireless_IngestMain.Layout_File_Base, THOR);
dsPrev := DATASET(myprevfile, NeustarWireless_IngestMain.Layout_File_Base, THOR);
 
hygieneStats := NeustarWireless_IngestMain.hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
