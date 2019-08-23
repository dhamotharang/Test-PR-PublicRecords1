﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Infogroup.BWR_PopulationStatistics - Population Statistics - SALT V3.7.1');
IMPORT Scrubs_Infogroup,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Infogroup.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* occupation_id_field */,/* first_name_field */,/* middle_name_field */,/* last_name_field */,/* suffix_field */,/* address_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_type_field */,/* unit_number_field */,/* city_field */,/* state_field */,/* zip_field */,/* zip4_field */,/* bar_field */,/* ace_rec_type_field */,/* cart_field */,/* census_state_code_field */,/* census_county_code_field */,/* county_code_desc_field */,/* census_tract_field */,/* census_block_group_field */,/* match_code_field */,/* latitude_field */,/* longitude_field */,/* mail_score_field */,/* residential_business_ind_field */,/* employer_name_field */,/* family_id_field */,/* individual_id_field */,/* abi_number_field */,/* industry_title_field */,/* occupation_title_field */,/* specialty_title_field */,/* sic_code_field */,/* naics_group_field */,/* license_state_field */,/* license_id_field */,/* license_number_field */,/* exp_date_field */,/* status_code_field */,/* effective_date_field */,/* add_date_field */,/* change_date_field */,/* year_licensed_field */,/* carriage_return_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
