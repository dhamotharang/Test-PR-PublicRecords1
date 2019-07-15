//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Inql_Nfcra_IDM.BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_Inql_Nfcra_IDM,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Inql_Nfcra_IDM.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* orig_transaction_id_field */,/* orig_dateadded_field */,/* orig_billingid_field */,/* orig_function_name_field */,/* orig_adl_field */,/* orig_fname_field */,/* orig_lname_field */,/* orig_mname_field */,/* orig_ssn_field */,/* orig_address_field */,/* orig_city_field */,/* orig_state_field */,/* orig_zip_field */,/* orig_phone_field */,/* orig_dob_field */,/* orig_dln_field */,/* orig_dln_st_field */,/* orig_glb_field */,/* orig_dppa_field */,/* orig_fcra_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
