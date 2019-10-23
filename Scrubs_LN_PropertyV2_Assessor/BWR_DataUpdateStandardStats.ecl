//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Assessor.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.0');
IMPORT Scrubs_LN_PropertyV2_Assessor,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_LN_PropertyV2_Assessor.Layout_Property_Assessor, THOR);
dsPrev := DATASET(myprevfile, Scrubs_LN_PropertyV2_Assessor.Layout_Property_Assessor, THOR);
 
hygieneStats := Scrubs_LN_PropertyV2_Assessor.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_LN_PropertyV2_Assessor.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_LN_PropertyV2_Assessor.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
