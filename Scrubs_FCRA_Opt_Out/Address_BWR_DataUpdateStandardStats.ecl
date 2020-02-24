﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FCRA_Opt_Out.Address_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.11.9');
IMPORT Scrubs_FCRA_Opt_Out,SALT311;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FCRA_Opt_Out.Address_Layout_FCRA_Opt_Out, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FCRA_Opt_Out.Address_Layout_FCRA_Opt_Out, THOR);
 
hygieneStats := Scrubs_FCRA_Opt_Out.Address_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FCRA_Opt_Out.Address_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FCRA_Opt_Out.Address_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
