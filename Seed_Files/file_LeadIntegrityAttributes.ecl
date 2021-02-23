IMPORT Data_Services,Seed_Files;

EXPORT file_LeadIntegrityAttributes := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN') + '~thor_data400::base::testseed_leadintegrityattributes', Seed_Files.Layout_LeadIntegrityAttributes, CSV(HEADING(single), QUOTE('"'), MAXLENGTH(32768)));