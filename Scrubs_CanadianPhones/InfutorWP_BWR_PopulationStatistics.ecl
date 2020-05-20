//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CanadianPhones.InfutorWP_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_CanadianPhones,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_CanadianPhones.InfutorWP_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* can_phone_field */,/* can_title_field */,/* can_fname_field */,/* can_lname_field */,/* can_suffix_field */,/* can_address1_field */,/* can_house_field */,/* can_predir_field */,/* can_street_field */,/* can_strtype_field */,/* can_postdir_field */,/* can_apttype_field */,/* can_aptnbr_field */,/* can_city_field */,/* can_province_field */,/* can_postalcd_field */,/* can_lang_field */,/* can_rectype_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
