IMPORT Data_Services, Seed_Files, STD;

baseFile := Seed_Files.file_SmallBusinessAnalytics;

appendHashValue := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(STD.Str.ToUpperCase(TRIM(baseFile.Authorized_Rep_1_FName)), 
																								STD.Str.ToUpperCase(TRIM(baseFile.Authorized_Rep_1_LName)), 
																								'', 
																								TRIM(baseFile.FEIN), 
																								TRIM(baseFile.Company_ZIP5), 
																								TRIM(baseFile.Bus_Phone), 
																								STD.Str.ToUpperCase(TRIM(baseFile.Company_Name)));
	baseFile;
END;

withHashValue := TABLE(baseFile, appendHashValue);

EXPORT key_SmallBusinessAnalytics := INDEX(withHashValue, {TestDataTableName, HashValue},
																	{withHashValue},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::smallbusinessanalytics');