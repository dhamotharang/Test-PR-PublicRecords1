//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_RemoteLinking.BWR_PopulationStatistics - Population Statistics - SALT V3.7.2');
IMPORT InsuranceHeader_RemoteLinking,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  InsuranceHeader_RemoteLinking.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*SRC Field*/,/* ADDRESS_field */,/* SSN_field */,/* POLICY_NUMBER_field */,/* CLAIM_NUMBER_field */,/* DL_NBR_field */,/* FULLNAME_field */,/* MAINNAME_field */,/* ADDR1_field */,/* DOB_field */,/* ZIP_field */,/* LOCALE_field */,/* PRIM_NAME_field */,/* LNAME_field */,/* PRIM_RANGE_field */,/* CITY_field */,/* FNAME_field */,/* SEC_RANGE_field */,/* MNAME_field */,/* ST_field */,/* SNAME_field */,/* GENDER_field */,/* DERIVED_GENDER_field */,/* VENDOR_ID_field */,/* BOCA_DID_field */,/* SRC_field */,/* DT_FIRST_SEEN_field */,/* DT_LAST_SEEN_field */,/* DL_STATE_field */,/* AMBEST_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
