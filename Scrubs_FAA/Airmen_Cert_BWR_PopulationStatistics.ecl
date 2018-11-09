//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FAA.Airmen_Cert_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_FAA,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FAA.Airmen_Cert_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* date_first_seen_field */,/* date_last_seen_field */,/* current_flag_field */,/* letter_field */,/* unique_id_field */,/* rec_type_field */,/* cer_type_field */,/* cer_type_mapped_field */,/* cer_level_field */,/* cer_level_mapped_field */,/* cer_exp_date_field */,/* ratings_field */,/* filler_field */,/* lfcr_field */,/* persistent_record_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
