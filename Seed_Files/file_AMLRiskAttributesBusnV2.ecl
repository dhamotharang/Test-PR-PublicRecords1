IMPORT Data_Services, Seed_Files;



EXPORT file_AMLRiskAttributesbusnV2 := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_amlriskattributesBusnV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));
