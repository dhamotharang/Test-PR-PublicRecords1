//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.SourceGcExclusion_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_MBS.SourceGcExclusion_Layout_SourceGcExclusion, THOR);
dsPrev := DATASET(myprevfile, Scrubs_MBS.SourceGcExclusion_Layout_SourceGcExclusion, THOR);
 
hygieneStats := Scrubs_MBS.SourceGcExclusion_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_MBS.SourceGcExclusion_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_MBS.SourceGcExclusion_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
