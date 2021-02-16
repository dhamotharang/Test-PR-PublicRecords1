IMPORT Data_Services, Seed_Files;

baseFile := Seed_Files.file_IdentityFraudNetwork;

keyRec := RECORD
	STRING32 TestDataTableName := '';
	STRING20 FirstName := '';
	STRING20 MiddleName := '';
	STRING20 LastName := '';
	STRING25 NameRiskCodes := '';
	STRING8 NameDateFirstSeen := '';
	UNSIGNED3 NameInquiryCount := 0;
	UNSIGNED2 NameInquiryCountYear := 0;
	UNSIGNED2 NameInquiryCountMonth := 0;
	UNSIGNED2 NameInquiryCountWeek := 0;
	UNSIGNED2 NameInquiryCountDay := 0;
	UNSIGNED2 NameInquiryCountHour := 0;
END;

seedRecords := PROJECT(baseFile, TRANSFORM(keyRec, SELF := LEFT));

// Only keep the records where the index fields are populated
keepRecords := seedRecords (TRIM(LastName) <> '' AND TRIM(FirstName) <> '' AND TRIM(NameRiskCodes) <> '');

EXPORT Key_IdentityFraudNetwork_Name := INDEX(keepRecords, {TestDataTableName, LastName, FirstName},
									{keepRecords},
									Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::identityfraudnetwork_name');