//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.InquiryLogs_BWR_DataUpdateStandardStats - Data Update Standard Stats - SALT V3.9.0');
IMPORT Scrubs_FraudGov,SALT39;
mynewfile := ''; // THOR file containing new data
myprevfile := ''; // THOR file containing previous data (can be empty)
mystatsfile := ''; // output file name
 
// New and (optionally) previous versions of data
dsNew := DATASET(mynewfile, Scrubs_FraudGov.InquiryLogs_Layout_InquiryLogs, THOR);
dsPrev := DATASET(myprevfile, Scrubs_FraudGov.InquiryLogs_Layout_InquiryLogs, THOR);
 
hygieneStats := Scrubs_FraudGov.InquiryLogs_hygiene(dsNew).StandardStats();
scrubsStats := Scrubs_FraudGov.InquiryLogs_Scrubs.StandardStats(dsNew);
deltaStats := IF(TRIM(myprevfile) > '' AND EXISTS(dsPrev), Scrubs_FraudGov.InquiryLogs_Delta(dsPrev, dsNew).StandardStats());
allStats := hygieneStats & scrubsStats & deltaStats;
OUTPUT(allStats,, mystatsfile);
