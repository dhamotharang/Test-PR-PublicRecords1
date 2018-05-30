//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_TelcordiaTPM.BWR_PopulationStatistics - Population Statistics - SALT V3.11.0');
IMPORT Scrubs_TelcordiaTPM,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_TelcordiaTPM.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* npa_field */,/* nxx_field */,/* tb_field */,/* city_field */,/* st_field */,/* ocn_field */,/* company_type_field */,/* nxx_type_field */,/* dial_ind_field */,/* point_id_field */,/* lf_field */,/* zip_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
