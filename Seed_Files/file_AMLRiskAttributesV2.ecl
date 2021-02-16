IMPORT Data_Services, Seed_Files;


//Please rename the input file appropriately
EXPORT file_AMLRiskAttributesV2 := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_amlriskattributesV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));
