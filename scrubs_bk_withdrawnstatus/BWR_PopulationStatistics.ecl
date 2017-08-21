//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_bk_withdrawnstatus.BWR_PopulationStatistics - Population Statistics - SALT V3.7.0');
IMPORT scrubs_bk_withdrawnstatus,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  scrubs_bk_withdrawnstatus.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* logid_field */,/* logdate_field */,/* caseid_field */,/* defendantid_field */,/* currentchapter_field */,/* previouschapter_field */,/* conversionid_field */,/* convertdate_field */,/* currentdisposition_field */,/* dcode_field */,/* currentdispositiondate_field */,/* intseed_field */,/* pid_field */,/* tmsid_field */,/* vacateid_field */,/* vacatedate_field */,/* vacateddisposition_field */,/* vacateddispositiondate_field */,/* withdrawnid_field */,/* originalwithdrawndate_field */,/* withdrawndate_field */,/* withdrawndisposition_field */,/* withdrawndispositiondate_field */,/* originalwithdrawndispositiondate_field */,/* filedinerror_field */,/* reopendate_field */,/* lastupdateddate_field */,/* iscurrent_field */,/* __filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
