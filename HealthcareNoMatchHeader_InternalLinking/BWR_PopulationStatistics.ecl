//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_InternalLinking.BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader_InternalLinking,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  HealthcareNoMatchHeader_InternalLinking.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*SRC Field*/,/* SRC_field */,/* SSN_field */,/* DOB_field */,/* LEXID_field */,/* SUFFIX_field */,/* FNAME_field */,/* MNAME_field */,/* LNAME_field */,/* GENDER_field */,/* PRIM_NAME_field */,/* PRIM_RANGE_field */,/* SEC_RANGE_field */,/* CITY_NAME_field */,/* ST_field */,/* ZIP_field */,/* DT_FIRST_SEEN_field */,/* DT_LAST_SEEN_field */,/* MAINNAME_field */,/* ADDR1_field */,/* LOCALE_field */,/* ADDRESS_field */,/* FULLNAME_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
