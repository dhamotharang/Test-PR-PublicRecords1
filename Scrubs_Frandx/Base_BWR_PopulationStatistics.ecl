//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Frandx.Base_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Frandx,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Frandx.Base_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* ace_aid_field */,/* address1_field */,/* brand_name_field */,/* chk_digit_field */,/* city_field */,/* clean_phone_field */,/* clean_secondary_phone_field */,/* company_name_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* err_stat_field */,/* fips_county_field */,/* fips_state_field */,/* franchisee_id_field */,/* fruns_field */,/* f_units_field */,/* industry_field */,/* industry_type_field */,/* p_city_name_field */,/* phone_field */,/* phone_extension_field */,/* prim_name_field */,/* record_id_field */,/* record_type_field */,/* relationship_code_field */,/* relationship_code_exp_field */,/* secondary_phone_field */,/* sector_field */,/* sic_code_field */,/* state_field */,/* unit_flag_field */,/* unit_flag_exp_field */,/* v_city_name_field */,/* zip_code_field */,/* zip_code4_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
