//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DunnData_Email.BWR_PopulationStatistics - Population Statistics - SALT V3.11.6');
IMPORT Scrubs_DunnData_Email,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DunnData_Email.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dtmatch_field */,/* email_field */,/* name_full_field */,/* address1_field */,/* address2_field */,/* city_field */,/* state_field */,/* zip5_field */,/* zip_ext_field */,/* ipaddr_field */,/* datestamp_field */,/* url_field */,/* lastdate_field */,/* em_src_cnt_field */,/* num_emails_field */,/* num_indiv_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
