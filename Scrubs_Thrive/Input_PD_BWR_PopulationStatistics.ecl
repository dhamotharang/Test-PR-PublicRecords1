//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Thrive.Input_PD_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_Thrive,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Thrive.Input_PD_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* orig_fname_field */,/* orig_mname_field */,/* orig_lname_field */,/* orig_addr_field */,/* orig_city_field */,/* orig_state_field */,/* orig_zip5_field */,/* orig_zip4_field */,/* phone_home_field */,/* phone_cell_field */,/* phone_work_field */,/* email_field */,/* dob_field */,/* employer_field */,/* dt_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
