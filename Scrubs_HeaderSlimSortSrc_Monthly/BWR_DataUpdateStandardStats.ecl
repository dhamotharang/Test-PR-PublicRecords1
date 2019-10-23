//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_HeaderSlimSortSrc_Monthly.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_HeaderSlimSortSrc_Monthly,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_HeaderSlimSortSrc_Monthly.Layout_File, THOR);
dsPrev := DATASET(myprevfile, Scrubs_HeaderSlimSortSrc_Monthly.Layout_File, THOR);
 
hygieneStats := Scrubs_HeaderSlimSortSrc_Monthly.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_HeaderSlimSortSrc_Monthly.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_HeaderSlimSortSrc_Monthly.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
