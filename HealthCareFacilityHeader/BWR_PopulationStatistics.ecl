//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  HealthCareFacilityHeader.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*SRC Field*/,/* UPIN_field */,/* NPI_NUMBER_field */,/* DEA_NUMBER_field */,/* CLIA_NUMBER_field */,/* MEDICARE_FACILITY_NUMBER_field */,/* NCPDP_NUMBER_field */,/* TAX_ID_field */,/* FEIN_field */,/* C_LIC_NBR_field */,/* SRC_field */,/* CNAME_field */,/* CNP_NAME_field */,/* CNP_NUMBER_field */,/* CNP_STORE_NUMBER_field */,/* CNP_BTYPE_field */,/* CNP_LOWV_field */,/* CNP_TRANSLATED_field */,/* CNP_CLASSID_field */,/* ADDRESS_ID_field */,/* ADDRESS_CLASSIFICATION_field */,/* PRIM_RANGE_field */,/* PRIM_NAME_field */,/* SEC_RANGE_field */,/* ST_field */,/* V_CITY_NAME_field */,/* ZIP_field */,/* PHONE_field */,/* FAX_field */,/* TAXONOMY_field */,/* TAXONOMY_CODE_field */,/* MEDICAID_NUMBER_field */,/* VENDOR_ID_field */,/* FAC_NAME_field */,/* ADDR1_field */,/* LOCALE_field */,/* ADDRESS_field */,/* LIC_STATE_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
