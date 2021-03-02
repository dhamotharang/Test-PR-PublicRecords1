IMPORT Data_Services,Seed_Files;

EXPORT file_VerificationOfOccupancy := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_verificationofoccupancy', Seed_Files.layout_VerificationOfOccupancy, CSV(HEADING(single), QUOTE('"')), OPT);