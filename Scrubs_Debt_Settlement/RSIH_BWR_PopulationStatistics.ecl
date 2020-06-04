//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Debt_Settlement.RSIH_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_Debt_Settlement,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Debt_Settlement.RSIH_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* avdanumber_field */,/* attorneyname_field */,/* businessname_field */,/* address1_field */,/* address2_field */,/* phone_field */,/* email_field */,/* primary_range_cln_field */,/* primary_name_cln_field */,/* sec_range_cln_field */,/* zip_cln_field */,/* did_header_addr_count_field */,/* did_header_phone_count_field */,/* did_phoneplus_gongphone_count_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
