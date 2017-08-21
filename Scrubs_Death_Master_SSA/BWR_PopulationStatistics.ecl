//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Death_Master_SSA.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Beta 2');
IMPORT Scrubs_Death_Master_SSA,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Death_Master_SSA.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*rec_type Field*/,/* filedate_field */,/* rec_type_field */,/* rec_type_orig_field */,/* ssn_field */,/* lname_field */,/* name_suffix_field */,/* fname_field */,/* mname_field */,/* vorp_code_field */,/* dod8_field */,/* dob8_field */,/* st_country_code_field */,/* zip_lastres_field */,/* zip_lastpayment_field */,/* state_field */,/* fipscounty_field */,/* clean_title_field */,/* clean_fname_field */,/* clean_mname_field */,/* clean_lname_field */,/* clean_name_suffix_field */,/* clean_name_score_field */,/* crlf_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
