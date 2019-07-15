//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FileRelative_Monthly.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_FileRelative_Monthly,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FileRelative_Monthly.Layout_File, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FileRelative_Monthly.Layout_File, THOR);
 
hygieneStats := Scrubs_FileRelative_Monthly.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FileRelative_Monthly.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FileRelative_Monthly.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
