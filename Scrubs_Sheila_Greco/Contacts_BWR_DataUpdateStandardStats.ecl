//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Sheila_Greco.Contacts_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_Sheila_Greco,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_Sheila_Greco.Contacts_Layout_Sheila_Greco, THOR);
dsPrev := DATASET(myprevfile, Scrubs_Sheila_Greco.Contacts_Layout_Sheila_Greco, THOR);
 
hygieneStats := Scrubs_Sheila_Greco.Contacts_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_Sheila_Greco.Contacts_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_Sheila_Greco.Contacts_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
