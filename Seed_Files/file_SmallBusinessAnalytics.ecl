IMPORT Data_Services,Seed_Files;

EXPORT file_SmallBusinessAnalytics := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_smallbusinessanalytics', Seed_Files.layout_SmallBusinessAnalytics, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);