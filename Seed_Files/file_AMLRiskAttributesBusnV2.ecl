Import ut, AML;



EXPORT file_AMLRiskAttributesbusnV2 := DATASET('~thor_data400::base::testseed_amlriskattributesBusnV2', Seed_Files.layout_AMLRiskAttributesV2, CSV(HEADING(single), QUOTE('"')));
