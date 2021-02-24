IMPORT Data_Services, Seed_Files;

EXPORT file_OS := DATASET( Data_Services.Data_location.Prefix('NONAMEGIVEN') + '~thor_data400::base::testseed_OS', Seed_Files.Layout_OS, CSV(QUOTE('"'), HEADING(1)) );