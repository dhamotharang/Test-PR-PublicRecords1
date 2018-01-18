IMPORT Business_Risk_BIP, Data_Services;

baseFile := Seed_Files.file_SmallBusModels;

appendHashValue := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(baseFile.authrepfirst)), 
																								StringLib.StringToUpperCase(TRIM(baseFile.authreplast)), 
																								'', 
																								TRIM(baseFile.fein), 
																								TRIM(baseFile.cmpyzip5), 
																								TRIM(baseFile.cmpyphone), 
																								StringLib.StringToUpperCase(TRIM(baseFile.companyname)));
	baseFile;
END;

withHashValue := TABLE(baseFile, appendHashValue);

export key_SmallBusModels := index(withHashValue, {tablename, HashValue},
																	{withHashValue},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::smallbusmodels');
																	// Data_Services.foreign_dataland + 'thor_data400::key::testseed::qa::smallbusmodels');