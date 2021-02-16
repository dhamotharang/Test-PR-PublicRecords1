IMPORT Data_Services,Seed_Files;

EXPORT file_FlexID := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_flexid', Seed_Files.Layout_FlexID, CSV(HEADING(1)));