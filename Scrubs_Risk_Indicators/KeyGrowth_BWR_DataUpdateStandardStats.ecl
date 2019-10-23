//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Risk_Indicators.KeyGrowth_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_Risk_Indicators,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Risk_Indicators.KeyGrowth_Layout_Risk_Indicators, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Risk_Indicators.KeyGrowth_Layout_Risk_Indicators, THOR);
 
hygieneStats := Scrubs_Risk_Indicators.KeyGrowth_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Risk_Indicators.KeyGrowth_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Risk_Indicators.KeyGrowth_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
