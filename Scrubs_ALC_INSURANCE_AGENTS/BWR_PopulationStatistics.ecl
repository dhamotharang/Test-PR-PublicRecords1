//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_ALC_INSURANCE_AGENTS.BWR_PopulationStatistics - Population Statistics - SALT V3.7.1');
IMPORT Scrubs_ALC_INSURANCE_AGENTS,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_ALC_INSURANCE_AGENTS.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* fname_field */,/* lname_field */,/* title_field */,/* company_field */,/* address1_field */,/* address2_field */,/* city_field */,/* state_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* bar_field */,/* gender_field */,/* country_field */,/* postal_cd_field */,/* dpv_field */,/* addr_type_field */,/* county_cd_field */,/* insurance_type_field */,/* license_type_field */,/* msa_field */,/* nielsen_county_cd_field */,/* list_id_field */,/* scno_field */,/* keycode_field */,/* custno_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
