//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Risk_Indicators.KeyGrowth_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_Risk_Indicators,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Risk_Indicators.KeyGrowth_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dataset_name_field */,/* file_type_field */,/* version_field */,/* wu_field */,/* count_oldfile_field */,/* count_newfile_field */,/* count_deduped_combined_field */,/* percent_change_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
