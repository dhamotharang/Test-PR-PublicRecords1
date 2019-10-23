//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FCRA_Opt_Out.DID_SSN_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_FCRA_Opt_Out,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FCRA_Opt_Out.DID_SSN_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* ssn_field */,/* did_field */,/* source_flag_field */,/* julian_date_field */,/* inname_first_field */,/* inname_last_field */,/* address_field */,/* city_field */,/* state_field */,/* zip5_field */,/* did_score_field */,/* ssn_append_field */,/* permanent_flag_field */,/* opt_back_in_field */,/* date_yyyymmdd_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
