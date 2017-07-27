//This is the code to execute in a builder window
#workunit('name','Health_Facility_Services.BWR_PopulationStatistics - Population Statistics - SALT V2.9 Beta 1');
IMPORT Health_Facility_Services,SALT29;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Health_Facility_Services.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* CNAME_field */,/* CNP_NAME_field */,/* CNP_NUMBER_field */,/* CNP_STORE_NUMBER_field */,/* CNP_BTYPE_field */,/* CNP_LOWV_field */,/* PRIM_RANGE_field */,/* PRIM_NAME_field */,/* SEC_RANGE_field */,/* V_CITY_NAME_field */,/* ST_field */,/* ZIP_field */,/* TAX_ID_field */,/* FEIN_field */,/* PHONE_field */,/* LIC_STATE_field */,/* C_LIC_NBR_field */,/* DEA_NUMBER_field */,/* VENDOR_ID_field */,/* NPI_NUMBER_field */,/* CLIA_NUMBER_field */,/* MEDICARE_FACILITY_NUMBER_field */,/* BDID_field */,/* SRC_field */,/* SOURCE_RID_field */,/* ADDR1_field */,/* LOCALE_field */,/* ADDRESS_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
