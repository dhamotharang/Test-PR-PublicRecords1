IMPORT Business_Risk_BIP, Data_Services, UT;

baseFile := Seed_Files.file_SmallBusinessAnalytics;

appendHashValue := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_FName)), 
																								StringLib.StringToUpperCase(TRIM(baseFile.Authorized_Rep_1_LName)), 
																								'', 
																								TRIM(baseFile.FEIN), 
																								TRIM(baseFile.Company_ZIP5), 
																								TRIM(baseFile.Bus_Phone), 
																								StringLib.StringToUpperCase(TRIM(baseFile.Company_Name)));
	baseFile;
END;

withHashValue := TABLE(baseFile, appendHashValue);

export key_SmallBusinessAnalytics := index(withHashValue, {TestDataTableName, HashValue},
																	{withHashValue},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::smallbusinessanalytics');
																	// UT.foreign_dataland + 'thor_data400::key::testseed::qa::smallbusinessanalytics');