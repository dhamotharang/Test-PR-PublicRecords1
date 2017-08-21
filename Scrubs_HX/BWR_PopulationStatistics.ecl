//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_HX.BWR_PopulationStatistics - Population Statistics - SALT V3.1.2');
IMPORT Scrubs_HX,SALT31;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_HX.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* claim_type_field */,/* claim_num_field */,/* attend_prov_id_field */,/* attend_prov_name_field */,/* billing_addr_field */,/* billing_city_field */,/* billing_npi_field */,/* billing_org_name_field */,/* billing_state_field */,/* billing_tax_id_field */,/* billing_zip_field */,/* ext_injury_diag_code_field */,/* inpatient_proc1_field */,/* inpatient_proc2_field */,/* inpatient_proc3_field */,/* operating_prov_id_field */,/* operating_prov_name_field */,/* other_diag1_field */,/* other_diag2_field */,/* other_diag3_field */,/* other_diag4_field */,/* other_diag5_field */,/* other_diag6_field */,/* other_diag7_field */,/* other_diag8_field */,/* other_proc1_field */,/* other_proc2_field */,/* other_proc3_field */,/* other_proc4_field */,/* other_proc5_field */,/* other_proc_method_code_field */,/* other_prov_id1_field */,/* other_prov_id2_field */,/* other_prov_name1_field */,/* other_prov_name2_field */,/* outpatient_proc1_field */,/* outpatient_proc2_field */,/* outpatient_proc3_field */,/* principle_diag_field */,/* principle_proc_field */,/* service_from_field */,/* service_line_field */,/* service_to_field */,/* submitted_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
