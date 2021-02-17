/* Oct.2016 - IPAddress length expanded to 45 characters in queries */
IMPORT Data_Services, Seed_Files;

baseFile := Seed_Files.file_IdentityFraudNetwork;

keyRec := RECORD
	STRING32 TestDataTableName := '';
	STRING20 FirstName := '';
	STRING20 MiddleName := '';
	STRING20 LastName := '';
	STRING120 StreetAddress1 := '';
	STRING25 City := '';
	STRING2 State := '';
	STRING5 Zip5 := '';
	STRING10 Phone10 := '';
	STRING9 SSN := '';
	STRING100 Email := '';
	STRING30 IPAddress := '';
	STRING1450 CombinationRiskCodes := '';
	STRING8 CombinationDateFirstSeen := '';
	UNSIGNED3 CombinationInquiryCount := 0;
	UNSIGNED2 CombinationInquiryCountYear := 0;
	UNSIGNED2 CombinationInquiryCountMonth := 0;
	UNSIGNED2 CombinationInquiryCountWeek := 0;
	UNSIGNED2 CombinationInquiryCountDay := 0;
	UNSIGNED2 CombinationInquiryCountHour := 0;
END;

seedRecords := PROJECT(baseFile, TRANSFORM(keyRec, SELF := LEFT));

// Only keep the records where the index fields are populated
keepRecords := seedRecords (TRIM(CombinationRiskCodes) <> '');

EXPORT Key_IdentityFraudNetwork_Combination := INDEX(keepRecords, {TestDataTableName, LastName, FirstName, StreetAddress1, Zip5, Phone10, SSN, Email, IPAddress},
									{keepRecords},
									Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::identityfraudnetwork_combination');