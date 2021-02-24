IMPORT Data_Services, Seed_Files;

baseFile := Seed_Files.file_IdentityFraudNetwork;

keyRec := RECORD
	STRING32 TestDataTableName := '';
	STRING10 Phone10 := '';
	STRING70 PhoneRiskCodes := '';
	STRING8 PhoneDateFirstSeen := '';
	UNSIGNED3 PhoneInquiryCount := 0;
	UNSIGNED2 PhoneInquiryCountYear := 0;
	UNSIGNED2 PhoneInquiryCountMonth := 0;
	UNSIGNED2 PhoneInquiryCountWeek := 0;
	UNSIGNED2 PhoneInquiryCountDay := 0;
	UNSIGNED2 PhoneInquiryCountHour := 0;
END;

seedRecords := PROJECT(baseFile, TRANSFORM(keyRec, SELF := LEFT));

// Only keep the records where the index fields are populated
keepRecords := seedRecords (TRIM(Phone10) <> '' AND TRIM(PhoneRiskCodes) <> '');

EXPORT Key_IdentityFraudNetwork_Phone := INDEX(keepRecords, {TestDataTableName, Phone10},
									{keepRecords},
									Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::identityfraudnetwork_phone');