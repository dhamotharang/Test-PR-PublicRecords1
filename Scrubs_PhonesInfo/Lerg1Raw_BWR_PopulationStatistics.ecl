//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.Lerg1Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhonesInfo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesInfo.Lerg1Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* ocn_field */,/* ocn_name_field */,/* ocn_abbr_name_field */,/* ocn_state_field */,/* category_field */,/* overall_ocn_field */,/* filler1_field */,/* filler2_field */,/* last_name_field */,/* first_name_field */,/* middle_initial_field */,/* company_name_field */,/* title_field */,/* address1_field */,/* address2_field */,/* floor_field */,/* room_field */,/* city_field */,/* state_field */,/* postal_code_field */,/* phone_field */,/* target_ocn_field */,/* overall_target_ocn_field */,/* rural_lec_indicator_field */,/* small_ilec_indicator_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
