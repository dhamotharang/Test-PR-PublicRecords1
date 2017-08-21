IMPORT Data_Services, Risk_Indicators, Seed_Files, UT;

baseFile := Seed_Files.File_RiskView_V5;

testSeedLayout := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.Name_First, LEFT, RIGHT)), StringLib.StringToUpperCase(TRIM(baseFile.Name_Last, LEFT, RIGHT)), TRIM(baseFile.SSN, LEFT, RIGHT), Risk_Indicators.nullstring, TRIM(baseFile.Zip5[1..5], LEFT, RIGHT), TRIM(baseFile.Home_Phone, LEFT, RIGHT), Risk_Indicators.nullstring);
	baseFile;
END;
testseedTable := TABLE(baseFile, testSeedLayout);

EXPORT Key_RiskView_V5 := INDEX(testseedTable, {TestDataTableName, HashValue}, 
																{testseedTable}, 
																// ut.foreign_dataland + 'thor_data400::key::testseed::qa::riskview_v5');
																Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::riskview_v5');