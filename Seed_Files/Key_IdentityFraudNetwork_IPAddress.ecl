/* Oct.2016 - IPAddress length expanded to 45 characters in queries */
IMPORT Data_Services, Seed_Files;

baseFile := Seed_Files.file_IdentityFraudNetwork;

keyRec := RECORD
	STRING32 TestDataTableName := '';
	STRING30 IPAddress := '';
	STRING30 IPAddressRiskCodes := '';
	STRING8 IPAddressDateFirstSeen := '';
	UNSIGNED3 IPAddressInquiryCount := 0;
	UNSIGNED2 IPAddressInquiryCountYear := 0;
	UNSIGNED2 IPAddressInquiryCountMonth := 0;
	UNSIGNED2 IPAddressInquiryCountWeek := 0;
	UNSIGNED2 IPAddressInquiryCountDay := 0;
	UNSIGNED2 IPAddressInquiryCountHour := 0;
END;

seedRecords := PROJECT(baseFile, TRANSFORM(keyRec, SELF := LEFT));

// Only keep the records where the index fields are populated
keepRecords := seedRecords (TRIM(IPAddress) <> '' AND TRIM(IPAddressRiskCodes) <> '');

EXPORT Key_IdentityFraudNetwork_IPAddress := INDEX(keepRecords, {TestDataTableName, IPAddress},
									{keepRecords},
									Data_Services.Data_location.Prefix('TestSeeds') + 'thor_data400::key::testseed::qa::identityfraudnetwork_ipaddress');