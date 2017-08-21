//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_InfutorCID.BWR_PopulationStatistics - Population Statistics - SALT V3.0 A21');
IMPORT Scrubs_InfutorCID,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_InfutorCID.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* orig_phone_field */,/* orig_phonetype_field */,/* orig_directindial_field */,/* orig_recordtype_field */,/* orig_firstdate_field */,/* orig_lastdate_field */,/* orig_telconame_field */,/* orig_businessname_field */,/* orig_firstname_field */,/* orig_mi_field */,/* orig_lastname_field */,/* orig_primaryhousenumber_field */,/* orig_primarypredirabbrev_field */,/* orig_primarystreetname_field */,/* orig_primarystreettype_field */,/* orig_primarypostdirabbrev_field */,/* orig_secondaryapttype_field */,/* orig_secondaryaptnbr_field */,/* orig_city_field */,/* orig_state_field */,/* orig_zip_field */,/* orig_zip4_field */,/* orig_dpbc_field */,/* orig_crte_field */,/* orig_cnty_field */,/* orig_z4type_field */,/* orig_dpv_field */,/* orig_maildeliverabilitycode_field */,/* orig_addressvalidationdate_field */,/* orig_filler1_field */,/* orig_directoryassistanceflag_field */,/* orig_telephoneconfidencescore_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
