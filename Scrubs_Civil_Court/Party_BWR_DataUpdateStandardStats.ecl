//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Civil_Court.Party_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_Civil_Court,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Civil_Court.Party_Layout_Civil_Court, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Civil_Court.Party_Layout_Civil_Court, THOR);
 
hygieneStats := Scrubs_Civil_Court.Party_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Civil_Court.Party_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Civil_Court.Party_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
