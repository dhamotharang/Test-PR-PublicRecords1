//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_AVM.Medians_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_AVM,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_AVM.Medians_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* history_date_field */,/* fips_geo_12_field */,/* median_valuation_field */,/* history_history_date_field */,/* history_median_valuation_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
