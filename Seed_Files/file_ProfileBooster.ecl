IMPORT Data_Services, Seed_Files;

EXPORT file_ProfileBooster := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN') + '~thor_data400::base::testseed_profilebooster', Seed_Files.layout_ProfileBooster, CSV(HEADING(single), QUOTE('"')), OPT);