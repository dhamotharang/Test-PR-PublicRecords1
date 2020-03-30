//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Frandx.Input_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Frandx,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Frandx.Input_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* address1_field */,/* address2_field */,/* brand_name_field */,/* city_field */,/* company_name_field */,/* exec_full_name_field */,/* franchisee_id_field */,/* fruns_field */,/* industry_field */,/* industry_type_field */,/* phone_field */,/* phone_extension_field */,/* record_id_field */,/* relationship_code_field */,/* secondary_phone_field */,/* sector_field */,/* sic_code_field */,/* state_field */,/* unit_flag_field */,/* zip_code_field */,/* zip_code4_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
