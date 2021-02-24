IMPORT Data_Services, Seed_Files;

baseFile := Seed_Files.file_IdentityFraudNetwork;

keyRec := RECORD
	STRING32 TestDataTableName := '';
	STRING9 SSN := '';
	STRING105 SSNRiskCodes := '';
	STRING8 SSNDateFirstSeen := '';
	UNSIGNED3 SSNInquiryCount := 0;
	UNSIGNED2 SSNInquiryCountYear := 0;
	UNSIGNED2 SSNInquiryCountMonth := 0;
	UNSIGNED2 SSNInquiryCountWeek := 0;
	UNSIGNED2 SSNInquiryCountDay := 0;
	UNSIGNED2 SSNInquiryCountHour := 0;
END;

seedRecords := PROJECT(baseFile, TRANSFORM(keyRec, SELF := LEFT));

// Only keep the records where the index fields are populated
keepRecords := seedRecords (TRIM(SSN) <> '' AND TRIM(SSNRiskCodes) <> '');

EXPORT Key_IdentityFraudNetwork_SSN := INDEX(keepRecords, {TestDataTableName, SSN},
									{keepRecords},
									Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::identityfraudnetwork_ssn');