IMPORT Data_Services, Seed_Files;

baseFile := Seed_Files.file_IdentityFraudNetwork;

keyRec := RECORD
	STRING32 TestDataTableName := '';
	STRING100 Email := '';
	STRING30 EmailRiskCodes := '';
	STRING8 EmailDateFirstSeen := '';
	UNSIGNED3 EmailInquiryCount := 0;
	UNSIGNED2 EmailInquiryCountYear := 0;
	UNSIGNED2 EmailInquiryCountMonth := 0;
	UNSIGNED2 EmailInquiryCountWeek := 0;
	UNSIGNED2 EmailInquiryCountDay := 0;
	UNSIGNED2 EmailInquiryCountHour := 0;
END;

seedRecords := PROJECT(baseFile, TRANSFORM(keyRec, SELF := LEFT));

// Only keep the records where the index fields are populated
keepRecords := seedRecords (TRIM(Email) <> '' AND TRIM(EmailRiskCodes) <> '');

EXPORT Key_IdentityFraudNetwork_Email := INDEX(keepRecords, {TestDataTableName, Email},
									{keepRecords},
									Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::identityfraudnetwork_email');