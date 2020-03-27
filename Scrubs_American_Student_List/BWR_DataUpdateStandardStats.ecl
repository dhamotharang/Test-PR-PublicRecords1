//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_American_Student_List.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_American_Student_List,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_American_Student_List.Layout_American_Student_List, THOR);
dsPrev := DATASET(myprevfile, Scrubs_American_Student_List.Layout_American_Student_List, THOR);
 
hygieneStats := Scrubs_American_Student_List.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_American_Student_List.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_American_Student_List.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
