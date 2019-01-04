﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_4020_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_4020_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* process_date_field */,/* file_number_field */,/* segment_code_field */,/* sequence_number_field */,/* orig_date_filed_ymd_field */,/* type_code_field */,/* type_description_field */,/* action_code_field */,/* action_description_field */,/* document_number_field */,/* filing_location_field */,/* liability_amount_field */,/* tax_lien_code_field */,/* tax_lien_description_field */,/* date_filed_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
