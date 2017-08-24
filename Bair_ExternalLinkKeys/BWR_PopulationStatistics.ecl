//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Bair_ExternalLinkKeys.BWR_PopulationStatistics - Population Statistics - SALT V3.3.0');
IMPORT Bair_ExternalLinkKeys,SALT33;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Bair_ExternalLinkKeys.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* NAME_SUFFIX_field */,/* FNAME_field */,/* MNAME_field */,/* LNAME_field */,/* PRIM_RANGE_field */,/* PRIM_NAME_field */,/* SEC_RANGE_field */,/* P_CITY_NAME_field */,/* ST_field */,/* ZIP_field */,/* DOB_field */,/* PHONE_field */,/* DL_ST_field */,/* DL_field */,/* LEXID_field */,/* POSSIBLE_SSN_field */,/* CRIME_field */,/* NAME_TYPE_field */,/* CLEAN_GENDER_field */,/* CLASS_CODE_field */,/* DT_FIRST_SEEN_field */,/* DT_LAST_SEEN_field */,/* DATA_PROVIDER_ORI_field */,/* VIN_field */,/* PLATE_field */,/* LATITUDE_field */,/* LONGITUDE_field */,/* SEARCH_ADDR1_field */,/* SEARCH_ADDR2_field */,/* MAINNAME_field */,/* FULLNAME_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
