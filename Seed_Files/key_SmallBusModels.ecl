IMPORT Data_Services, Seed_Files, STD;

baseFile := Seed_Files.file_SmallBusModels;

appendHashValue := RECORD
	DATA16 HashValue := Seed_Files.Hash_InstantID(STD.Str.ToUpperCase(TRIM(baseFile.authrepfirst)), 
																								STD.Str.ToUpperCase(TRIM(baseFile.authreplast)), 
																								'', 
																								TRIM(baseFile.fein), 
																								TRIM(baseFile.cmpyzip5), 
																								TRIM(baseFile.cmpyphone), 
																								STD.Str.ToUpperCase(TRIM(baseFile.companyname)));
	baseFile;
END;

withHashValue := TABLE(baseFile, appendHashValue);

EXPORT key_SmallBusModels := INDEX(withHashValue, {tablename, HashValue},
																	{withHashValue},
																	Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::testseed::qa::smallbusmodels');