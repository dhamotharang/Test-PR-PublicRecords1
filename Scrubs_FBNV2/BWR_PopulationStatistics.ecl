//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.BWR_PopulationStatistics - Population Statistics - SALT V3.7.1');
IMPORT Scrubs_FBNV2,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* name1_field */,/* name2_field */,/* date_filed_field */,/* file_number_field */,/* prep_addr1_line1_field */,/* prep_addr1_line_last_field */,/* prep_addr2_line1_field */,/* prep_addr2_line_last_field */,/* RECORD_TYPE_field */,/* STREET_ADD1_field */,/* CITY1_field */,/* STATE1_field */,/* ZIP1_field */,/* TERM_field */,/* STREET_ADD2_field */,/* CITY2_field */,/* STATE2_field */,/* ZIP2_field */,/* FILM_CODE_field */,/* BUS_TYPE_field */,/* ANNEX_CODE_field */,/* NUM_PAGES_field */,/* EXPIRED_TERM_field */,/* INCORPORATED_field */,/* ASSUMED_NAME_field */,/* name1_title_field */,/* name1_fname_field */,/* name1_mname_field */,/* name1_lname_field */,/* name1_name_suffix_field */,/* name1_name_score_field */,/* name2_title_field */,/* name2_fname_field */,/* name2_mname_field */,/* name2_lname_field */,/* name2_name_suffix_field */,/* name2_name_score_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
