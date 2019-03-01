//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Best_Proxid.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT BIPV2_Best_Proxid,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_Best_Proxid.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source_for_votes Field*/,/* dt_first_seen_field */,/* dt_last_seen_field */,/* source_for_votes_field */,/* company_name_field */,/* company_fein_field */,/* company_phone_field */,/* company_url_field */,/* duns_number_field */,/* company_sic_code1_field */,/* company_naics_code1_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* fips_state_field */,/* fips_county_field */,/* address_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
