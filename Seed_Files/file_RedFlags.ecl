IMPORT Data_Services,Seed_Files;
EXPORT file_RedFlags := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_redflags',Seed_Files.Layout_RedFlags,CSV(HEADING(1)));