//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_xLink.BWR_PopulationStatistics - Population Statistics - SALT V3.11.10-PV1');
IMPORT InsuranceHeader_xLink,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  InsuranceHeader_xLink.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*SRC Field*/,/* SNAME_field */,/* FNAME_field */,/* MNAME_field */,/* LNAME_field */,/* DERIVED_GENDER_field */,/* PRIM_RANGE_field */,/* PRIM_NAME_field */,/* SEC_RANGE_field */,/* CITY_field */,/* ST_field */,/* ZIP_field */,/* SSN5_field */,/* SSN4_field */,/* DOB_field */,/* PHONE_field */,/* DL_STATE_field */,/* DL_NBR_field */,/* SRC_field */,/* SOURCE_RID_field */,/* DT_FIRST_SEEN_field */,/* DT_LAST_SEEN_field */,/* DT_EFFECTIVE_FIRST_field */,/* DT_EFFECTIVE_LAST_field */,/* MAINNAME_field */,/* FULLNAME_field */,/* ADDR1_field */,/* LOCALE_field */,/* ADDRESS_field */,/* fname2_field */,/* lname2_field */,/* VIN_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
