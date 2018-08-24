//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Deed.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.0');
IMPORT Scrubs_LN_PropertyV2_Deed,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_LN_PropertyV2_Deed.Layout_Property_deed, THOR);
dsPrev := DATASET(myprevfile, Scrubs_LN_PropertyV2_Deed.Layout_Property_deed, THOR);
 
hygieneStats := Scrubs_LN_PropertyV2_Deed.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_LN_PropertyV2_Deed.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_LN_PropertyV2_Deed.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
