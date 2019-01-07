//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','NeustarWireless_IngestActivityStatus.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT NeustarWireless_IngestActivityStatus,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  NeustarWireless_IngestActivityStatus.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* phone_field */,/* activity_status_field */,/* raw_file_name_field */,/* rcid_field */,/* source_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* date_vendor_first_reported_field */,/* date_vendor_last_reported_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
