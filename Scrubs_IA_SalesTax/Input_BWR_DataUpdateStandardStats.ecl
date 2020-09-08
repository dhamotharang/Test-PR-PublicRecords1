//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IA_SalesTax.Input_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.11');
IMPORT Scrubs_IA_SalesTax,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_IA_SalesTax.Input_Layout_IA_SalesTax, THOR);
dsPrev := DATASET(myprevfile, Scrubs_IA_SalesTax.Input_Layout_IA_SalesTax, THOR);
 
hygieneStats := Scrubs_IA_SalesTax.Input_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_IA_SalesTax.Input_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_IA_SalesTax.Input_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
