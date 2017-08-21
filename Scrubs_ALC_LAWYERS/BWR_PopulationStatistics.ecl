//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_ALC_LAWYERS.BWR_PopulationStatistics - Population Statistics - SALT V3.2.1');
IMPORT Scrubs_ALC_LAWYERS,SALT32;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_ALC_LAWYERS.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* fname_field */,/* lname_field */,/* title_field */,/* company_field */,/* address1_field */,/* address2_field */,/* city_field */,/* state_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* bar_field */,/* gender_field */,/* country_field */,/* postal_cd_field */,/* dpv_field */,/* addr_type_field */,/* business_ind_field */,/* county_cd_field */,/* msa_field */,/* nielsen_county_cd_field */,/* number_of_lawyers_range_field */,/* practice_area_field */,/* title_cd_field */,/* phone_field */,/* list_id_field */,/* scno_field */,/* keycode_field */,/* custno_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
