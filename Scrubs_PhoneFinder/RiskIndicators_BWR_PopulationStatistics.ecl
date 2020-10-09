//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhoneFinder.RiskIndicators_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhoneFinder,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhoneFinder.RiskIndicators_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* transaction_id_field */,/* phone_id_field */,/* sequence_number_field */,/* date_added_field */,/* risk_indicator_id_field */,/* risk_indicator_level_field */,/* risk_indicator_text_field */,/* risk_indicator_category_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
