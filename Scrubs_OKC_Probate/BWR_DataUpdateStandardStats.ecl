//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OKC_Probate.BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.8.2');
IMPORT Scrubs_OKC_Probate,SALT38;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name

// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_OKC_Probate.Layout_OKC_Probate_Profile, THOR);
dsPrev := DATASET(myprevfile, Scrubs_OKC_Probate.Layout_OKC_Probate_Profile, THOR);

hygieneStats := Scrubs_OKC_Probate.hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_OKC_Probate.Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_OKC_Probate.Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
