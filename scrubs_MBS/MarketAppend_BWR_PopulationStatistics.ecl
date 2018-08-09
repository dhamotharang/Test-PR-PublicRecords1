//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.MarketAppend_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_MBS.MarketAppend_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* company_id_field */,/* app_type_field */,/* market_field */,/* sub_market_field */,/* vertical_field */,/* main_country_code_field */,/* bill_country_code_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
