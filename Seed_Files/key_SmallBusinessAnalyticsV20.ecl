IMPORT Data_Services, Seed_Files, STD;

baseFile := Seed_Files.file_SmallBusinessAnalyticsV20;

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
// export key_SmallBusinessAnalyticsV20 := withHashValue;
export key_SmallBusinessAnalyticsV20 := index(withHashValue, {TestDataTableName, HashValue},
																	{withHashValue},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::smallbusinessanalyticsv20');
																	// '~thor_data400::key::testseed::qa::smallbusinessanalyticsv20');
