//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_NH_Main.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.8');
IMPORT Scrubs_Corp2_Mapping_NH_Main,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Corp2_Mapping_NH_Main.Layout_In_NH, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Corp2_Mapping_NH_Main.Layout_In_NH, THOR);
 
hygieneStats := Scrubs_Corp2_Mapping_NH_Main.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Corp2_Mapping_NH_Main.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Corp2_Mapping_NH_Main.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
