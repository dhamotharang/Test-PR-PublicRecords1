//This is the code to execute in a builder window
#workunit('name','Health_Provider_Services.BWR_PopulationStatistics - Population Statistics - SALT V2.8 Gold SR1');
IMPORT Health_Provider_Services,SALT28;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Health_Provider_Services.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* FNAME_field */,/* MNAME_field */,/* LNAME_field */,/* SNAME_field */,/* GENDER_field */,/* PRIM_RANGE_field */,/* PRIM_NAME_field */,/* SEC_RANGE_field */,/* V_CITY_NAME_field */,/* ST_field */,/* ZIP_field */,/* SSN_field */,/* DOB_field */,/* PHONE_field */,/* LIC_STATE_field */,/* C_LIC_NBR_field */,/* TAX_ID_field */,/* DEA_NUMBER_field */,/* VENDOR_ID_field */,/* NPI_NUMBER_field */,/* UPIN_field */,/* DID_field */,/* BDID_field */,/* SRC_field */,/* SOURCE_RID_field */,/* MAINNAME_field */,/* FULLNAME_field */,/* ADDR1_field */,/* LOCALE_field */,/* ADDRESS_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
