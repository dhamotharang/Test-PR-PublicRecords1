IMPORT Data_Services,Seed_Files;

EXPORT file_SmallBusinessAnalyticsV20 := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_smallbusinessanalyticsv20', Seed_Files.layout_SmallBusinessAnalyticsv20, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
