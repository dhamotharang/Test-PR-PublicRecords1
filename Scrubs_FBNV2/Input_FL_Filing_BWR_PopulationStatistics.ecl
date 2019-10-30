//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FBNV2.Input_FL_Filing_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_FBNV2,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FBNV2.Input_FL_Filing_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* FIC_FIL_DOC_NUM_field */,/* FIC_FIL_NAME_field */,/* FIC_FIL_DATE_field */,/* FIC_OWNER_DOC_NUM_field */,/* FIC_OWNER_NAME_field */,/* p_owner_name_field */,/* c_owner_name_field */,/* prep_addr_line1_field */,/* prep_addr_line_last_field */,/* prep_owner_addr_line1_field */,/* prep_owner_addr_line_last_field */,/* seq_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
