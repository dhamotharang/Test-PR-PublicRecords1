IMPORT Data_Services, Seed_Files;

EXPORT File_OSAttributes := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN') + '~thor_data400::base::testseed_osattributes', Seed_Files.Layout_OSAttributes, CSV(MAXLENGTH(20000),HEADING(1)));