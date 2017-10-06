//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_UCCV2.TH_Party_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_UCCV2,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_UCCV2.TH_Party_Layout_UCCV2, THOR);
dsPrev := DATASET(myprevfile, Scrubs_UCCV2.TH_Party_Layout_UCCV2, THOR);
 
hygieneStats := Scrubs_UCCV2.TH_Party_hygiene(dsNew).StandardStats();
allStats := hygieneStats;
OUTPUT(allStats,, mystatsfile);
