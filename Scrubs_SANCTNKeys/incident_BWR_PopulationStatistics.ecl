//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTNKeys.incident_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_SANCTNKeys,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_SANCTNKeys.incident_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* batch_number_field */,/* incident_number_field */,/* party_number_field */,/* record_type_field */,/* order_number_field */,/* ag_code_field */,/* case_number_field */,/* incident_date_field */,/* jurisdiction_field */,/* source_document_field */,/* additional_info_field */,/* agency_field */,/* alleged_amount_field */,/* estimated_loss_field */,/* fcr_date_field */,/* ok_for_fcr_field */,/* modified_date_field */,/* load_date_field */,/* incident_text_field */,/* incident_date_clean_field */,/* fcr_date_clean_field */,/* cln_modified_date_field */,/* cln_load_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
