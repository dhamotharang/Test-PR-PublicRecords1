//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_tris_lnssi.BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT scrubs_tris_lnssi,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  scrubs_tris_lnssi.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* contrib_risk_field_field */,/* contrib_risk_value_field */,/* contrib_risk_attr_field */,/* contrib_state_excl_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
