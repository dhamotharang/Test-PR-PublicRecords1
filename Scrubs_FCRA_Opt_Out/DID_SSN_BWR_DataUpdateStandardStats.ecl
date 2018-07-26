//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FCRA_Opt_Out.DID_SSN_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.0');
IMPORT Scrubs_FCRA_Opt_Out,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FCRA_Opt_Out.DID_SSN_Layout_FCRA_Opt_Out, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FCRA_Opt_Out.DID_SSN_Layout_FCRA_Opt_Out, THOR);
 
hygieneStats := Scrubs_FCRA_Opt_Out.DID_SSN_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FCRA_Opt_Out.DID_SSN_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FCRA_Opt_Out.DID_SSN_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
