/* Oct.2016 - IPAddress length expanded to 45 characters in queries, related fields have comment: //IP-update related */
EXPORT layout_IdentityFraudNetwork := RECORD
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
	STRING30 IPAddress := '';  //IP-update related
	STRING25 NameRiskCodes := '';
	STRING8 NameDateFirstSeen := '';
	UNSIGNED3 NameInquiryCount := 0;
	UNSIGNED2 NameInquiryCountYear := 0;
	UNSIGNED2 NameInquiryCountMonth := 0;
	UNSIGNED2 NameInquiryCountWeek := 0;
	UNSIGNED2 NameInquiryCountDay := 0;
	UNSIGNED2 NameInquiryCountHour := 0;
	STRING165 AddressRiskCodes := '';
	STRING8 AddressDateFirstSeen := '';
	UNSIGNED3 AddressInquiryCount := 0;
	UNSIGNED2 AddressInquiryCountYear := 0;
	UNSIGNED2 AddressInquiryCountMonth := 0;
	UNSIGNED2 AddressInquiryCountWeek := 0;
	UNSIGNED2 AddressInquiryCountDay := 0;
	UNSIGNED2 AddressInquiryCountHour := 0;
	STRING70 PhoneRiskCodes := '';
	STRING8 PhoneDateFirstSeen := '';
	UNSIGNED3 PhoneInquiryCount := 0;
	UNSIGNED2 PhoneInquiryCountYear := 0;
	UNSIGNED2 PhoneInquiryCountMonth := 0;
	UNSIGNED2 PhoneInquiryCountWeek := 0;
	UNSIGNED2 PhoneInquiryCountDay := 0;
	UNSIGNED2 PhoneInquiryCountHour := 0;
	STRING105 SSNRiskCodes := '';
	STRING8 SSNDateFirstSeen := '';
	UNSIGNED3 SSNInquiryCount := 0;
	UNSIGNED2 SSNInquiryCountYear := 0;
	UNSIGNED2 SSNInquiryCountMonth := 0;
	UNSIGNED2 SSNInquiryCountWeek := 0;
	UNSIGNED2 SSNInquiryCountDay := 0;
	UNSIGNED2 SSNInquiryCountHour := 0;
	STRING30 EmailRiskCodes := '';
	STRING8 EmailDateFirstSeen := '';
	UNSIGNED3 EmailInquiryCount := 0;
	UNSIGNED2 EmailInquiryCountYear := 0;
	UNSIGNED2 EmailInquiryCountMonth := 0;
	UNSIGNED2 EmailInquiryCountWeek := 0;
	UNSIGNED2 EmailInquiryCountDay := 0;
	UNSIGNED2 EmailInquiryCountHour := 0;
	STRING30 IPAddressRiskCodes := '';
	STRING8 IPAddressDateFirstSeen := '';
	UNSIGNED3 IPAddressInquiryCount := 0;
	UNSIGNED2 IPAddressInquiryCountYear := 0;
	UNSIGNED2 IPAddressInquiryCountMonth := 0;
	UNSIGNED2 IPAddressInquiryCountWeek := 0;
	UNSIGNED2 IPAddressInquiryCountDay := 0;
	UNSIGNED2 IPAddressInquiryCountHour := 0;
	STRING1450 CombinationRiskCodes := '';
	STRING8 CombinationDateFirstSeen := '';
	UNSIGNED3 CombinationInquiryCount := 0;
	UNSIGNED2 CombinationInquiryCountYear := 0;
	UNSIGNED2 CombinationInquiryCountMonth := 0;
	UNSIGNED2 CombinationInquiryCountWeek := 0;
	UNSIGNED2 CombinationInquiryCountDay := 0;
	UNSIGNED2 CombinationInquiryCountHour := 0;
END;