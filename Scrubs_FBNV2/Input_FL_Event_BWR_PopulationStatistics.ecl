//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_FL_Event_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.Input_FL_Event_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* EVENT_DOC_NUMBER_field */,/* EVENT_ORIG_DOC_NUMBER_field */,/* EVENT_DATE_field */,/* ACTION_OWN_NAME_field */,/* prep_old_addr_line1_field */,/* prep_old_addr_line_last_field */,/* prep_new_addr_line1_field */,/* prep_new_addr_line_last_field */,/* prep_owner_addr_line1_field */,/* prep_owner_addr_line_last_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
