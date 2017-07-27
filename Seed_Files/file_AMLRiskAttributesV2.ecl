Import ut, AML;


//Please rename the input file appropriately
EXPORT file_AMLRiskAttributesV2 := DATASET('~thor_data400::base::testseed_amlriskattributesV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));
