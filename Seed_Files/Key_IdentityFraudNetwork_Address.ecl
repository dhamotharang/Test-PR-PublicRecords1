IMPORT Data_Services, Seed_Files;

baseFile := Seed_Files.file_IdentityFraudNetwork;

keyRec := RECORD
	STRING32 TestDataTableName := '';
	STRING120 StreetAddress1 := '';
	STRING25 City := '';
	STRING2 State := '';
	STRING5 Zip5 := '';
	STRING165 AddressRiskCodes := '';
	STRING8 AddressDateFirstSeen := '';
	UNSIGNED3 AddressInquiryCount := 0;
	UNSIGNED2 AddressInquiryCountYear := 0;
	UNSIGNED2 AddressInquiryCountMonth := 0;
	UNSIGNED2 AddressInquiryCountWeek := 0;
	UNSIGNED2 AddressInquiryCountDay := 0;
	UNSIGNED2 AddressInquiryCountHour := 0;
END;

seedRecords := PROJECT(baseFile, TRANSFORM(keyRec, SELF := LEFT));

// Only keep the records where the index fields are populated
keepRecords := seedRecords (TRIM(StreetAddress1) <> '' AND TRIM(Zip5) <> '' AND TRIM(AddressRiskCodes) <> '');

EXPORT Key_IdentityFraudNetwork_Address := INDEX(keepRecords, {TestDataTableName, StreetAddress1, Zip5},
									{keepRecords},
									Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::identityfraudnetwork_address');