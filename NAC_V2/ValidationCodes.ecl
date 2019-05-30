EXPORT ValidationCodes := MODULE

	EXPORT	errcodes := ENUM(
		E101 = 101,				// Invalid Record Code
		E102 = 102,				// Invalid/Missing Contributing State
		E103 = 103,				// Invalid/Missing Program Code
		E104 = 104,				// Missing Case Identifier
		E105 = 105,				// Invalid Case Identifier
		E106 = 106,				// Missing Client Identifier				
		E107 = 107,				// Invalid Client Identifier
		E108 = 108,				// Invalid/Missing Address Type Code			
		E109 = 109,				// Invalid/Missing First Name
		E110 = 110,				// Invalid/Missing Last Name
		E111 = 111,				// Invalid/Missing SSN
		E112 = 112,				// Invalid/Missing SSN Type Code
		E113 = 113,				// Invalid/Missing DOB				
		E114 = 114,				// Invalid/Missing DOB Type Code
		E115 = 115,				// Invalid/Missing Eligibility Indicator Code
		E116 = 116,				// Invalid/Missing Eligibility Effective Date
		E117 = 117,				// Invalid/Missing Eligibility Period Type Code
		E118 = 118,				// Invalid/Missing Eligibility Start Date/Month
		E119 = 119,				// Invalid/Missing Eligibility End Date/Month
		E120 = 120,				// Invalid/Missing Update Type Code
		E121 = 121,				// Invalid/Missing Matched State Code
		E122 = 122,				// Invalid/Missing Matched Client Identifier
		E123 = 123,				// Missing Related Client Record
		E124 = 124,				// Missing Related Case Record
		E125 = 125				// Invalid/Missing Matched Group Id
	);


	export rError := RECORD
		integer		errCode;
		string1		Severity;				// error or warning
		string1		Level;				// file/record/field
		string4		fieldCode;
		string32	badValue;
	  string2		state := '';
		string4		RecordCode := '';
	END;

	shared rCodeTable := RECORD
		integer		errCode;
		string4		textValue;
		string1		Level;
		string4		fieldCode;
		string50	msg;
	END;
	
	EXPORT fcLastName := '2012';
	EXPORT fcFirstName := '2013';
	EXPORT fcMiddleName := '2014';
	EXPORT fcSuffixName := '2015';
	EXPORT fcStreet1 := '2032';
	EXPORT fcStreet2 := '2033';
	
	EXPORT dsErrorCodes := DATASET([
		{errcodes.E101,'E101','R','3001','Invalid Record Code'},
		{errcodes.E102,'E102','F','2001','Invalid/Missing Contributing State'},
		{errcodes.E103,'E103','F','2002','Invalid/Missing Program Code'},
		{errcodes.E104,'E104','F','2004','Missing Case Identifier'},
		{errcodes.E105,'E105','F','2003','Invalid Case Identifier'},
		{errcodes.E106,'E106','F','2011','Missing Client Identifier'},				
		{errcodes.E107,'E107','F','2011','Invalid Client Identifier'},
		{errcodes.E108,'E108','F','2037','Invalid/Missing Address Type Code'},			
		{errcodes.E109,'E109','F','2013','Invalid/Missing First Name'},
		{errcodes.E110,'E110','F','2012','Invalid/Missing Last Name'},
		{errcodes.E111,'E111','F','2019','Invalid/Missing SSN'},
		{errcodes.E112,'E112','F','2020','Invalid/Missing SSN Type Code'},
		{errcodes.E113,'E113','F','2021','Invalid/Missing DOB'},				
		{errcodes.E114,'E114','F','2022','Invalid/Missing DOB Type Code'},
		{errcodes.E115,'E115','F','2023','Invalid/Missing Eligibility Indicator Code'},
		{errcodes.E116,'E116','F','2025','Invalid/Missing Eligibility Period Type Code'},
		{errcodes.E117,'E117','F','2026','Invalid/Missing Eligibility Start Date/Month'},
		{errcodes.E118,'E118','F','2027','Invalid/Missing Eligibility End Date/Month'},
		{errcodes.E119,'E119','R','3002','Invalid/Missing Update Type Code'},
		{errcodes.E120,'E120','F','2050','Invalid/Missing Matched State Code'},
		{errcodes.E121,'E121','F','2051','Invalid/Missing Matched Client Identifier'},
		{errcodes.E122,'E122','R','3004','Missing Related Client Record'},
		{errcodes.E123,'E123','R','3003','Missing Related Case Record'},
		{errcodes.E124,'E124','F','2052','Invalid/Missing Matched Group Id'}
	], rCodeTable);

	EXPORT warningcodes := ENUM(
			W101 = 101,				// Invalid/Missing Race Value, Set to "U"
			W102 = 102,				// Invalid/Missing Gender Value, Set to "U"
			W103 = 103,				// Invalid/Missing Ethnicity Value, Set to "U"
			W104 = 104,				// Invalid/Missing ABAWD Indicator, Set to "U"
			W105 = 105,				// Invalid Character in Name, Changed to "?"
			W106 = 106,				// Invalid Relationship Indicator, Changed to "O"
			W107 = 107,				// Invalid Character in Address, Changed to "?"
			W108 = 108,				// Invalid Address Category, Changed to Blank
			W109 = 109,				// Invalid Monthly Allotment Value
			W110 = 110,				// Invalid Historical Benefit Count
			W111 = 111,				// Invalid/Missing Eligibility Effective Date
			W112 = 112,				// Invalid/Missing street address
			W113 = 113,				// Invalid/Missing Address City
			W114 = 114,				// Invalid/Missing Address State
			W115 = 115,				// Invalid/Missing Address Zip
			W116 = 116,				// Invalid Postal Address
			W117 = 117,				// Invalid/Missing County/Parish Code
			W118 = 118				// Invalid Email Address
		);


	EXPORT dsWarningCodes := DATASET([
		{warningcodes.W101,'W101','F','2017','Invalid/Missing Race Value, Set to "U"'},
		{warningcodes.W102,'W102','F','2016','Invalid/Missing Gender Value, Set to "U"'},
		{warningcodes.W103,'W103','F','2018','Invalid/Missing Ethnicity Value, Set to "U"'},
		{warningcodes.W104,'W104','F','2030','Invalid/Missing ABAWD Indicator, Set to "U"'},
		{warningcodes.W105,'W105','R','2003','Invalid Character in Name, Changed to "?"'},
		{warningcodes.W106,'W106','F','2029','Invalid Relationship Indicator, Changed to "O"'},
		{warningcodes.W107,'W107','R','2011','Invalid Character in Address, Changed to "?" '},				
		{warningcodes.W108,'W108','F','2038','Invalid Address Category, Changed to Blank'},
		{warningcodes.W109,'W109','F','2005','Invalid Monthly Allotment Value '},
		{warningcodes.W110,'W110','F','2031','Invalid Historical Benefit Count'},
		{warningcodes.W111,'W111','F','2024','Invalid/Missing Eligibility Effective Date'},
		{warningcodes.W112,'W112','F','2032','Invalid/Missing Address Street'},
		{warningcodes.W113,'W113','F','2034','Invalid/Missing Address City'},
		{warningcodes.W114,'W114','F','2035','Invalid/Missing Address State'},
		{warningcodes.W115,'W115','F','2036','Invalid/Missing Address Zip'},
		{warningcodes.W116,'W116','R','3005','Invalid Postal Address'},
		{warningcodes.W117,'W117','F','2006','Invalid/Missing County/Parish Code'},
		{warningcodes.W118,'W118','F','2010','Invalid Email Address'}
	], rCodeTable);
	
	EXPORT dsFieldNames := DATASET([
		{'1001',	'File Name'},
		{'1002',	'File Accepted'},
		{'1003',	'Total Records'},
		{'1004',	'Accepted Records'},
		{'1005',	'Rejected Records'},
		{'1098',	'Warnings'},
		{'1099',	'Errors'},
		{'2001',	'Program State'},
		{'2002',	'Program Code'},
		{'2003',	'Case_Benefit_Month'},
		{'2004',	'Case_Identifier'},
		{'2005',	'MonthlyAllotment'},
		{'2006',	'County_Parish_Code'},
		{'2007',	'County_Parish_Name'},
		{'2008',	'Phone_1'},
		{'2009',	'Phone_2'},
		{'2010',	'Email'},
		{'2011',	'Client_Identifier'},
		{fcLastName,	'Client_Last_Name'},
		{fcFirstName,	'Client_First_Name'},
		{fcMiddleName,	'Client_Middle_Name'},
		{fcSuffixName,	'Client Name Suffix'},
		{'2016',	'Client_Gender'},
		{'2017',	'Client_Race'},
		{'2018',	'Client_Ethnicity'},
		{'2019',	'Client_SSN'},
		{'2020',	'Client_SSN_Type_Indicator'},
		{'2021',	'Client_DOB'},
		{'2022',	'Client_DOB_Type_Indicator'},
		{'2023',	'Client_Eligible_Status_Indicator'},
		{'2024',	'Client_Eligible_Status_Date'},
		{'2025',	'Period Type'},
		{'2026',	'Start Date'},
		{'2027',	'End Date'},
		{'2028',	'HHIndicator'},
		{'2029',	'Relationship'},
		{'2030',	'ABAWDIndicator'},
		{'2031',	'Historical Benefit Count'},
		{'2032',	'Street 1'},
		{'2033',	'Street 2'},
		{'2034',	'City'},
		{'2035',	'State'},
		{'2036',	'Zip Code'},
		{'2037',	'Address Type'},
		{'2038',	'Address Category'},
		{'2039',	'State_Contact_Name'},
		{'2040',	'State_Contact_Phone'},
		{'2041',	'State_Contact_Phone_Extension'},
		{'2042',	'State_Contact_Email'},
		{'2050',	'Matched State Code'},
		{'2051',	'Matched Client Identifier'},
		{'2052',	'Matched GroupId'},
		{'3001',	'Invalid Record Code'},
		{'3002',	'Invalid Update Type'},
		{'3003',	'Missing Related Case Record'},
		{'3004',	'Missing Related Client Record'},
		{'3005',	'Postal Address'}
		
	], {string4 FieldCode, string32 FieldName});
	
	export dErrCodeToFieldCode :=  DICTIONARY(dsErrorCodes, {errCode=>fieldCode});
	export dWarnCodeToFieldCode :=  DICTIONARY(dsWarningCodes, {errCode=>fieldCode});	
	export GetFieldCode(string Severity, integer code) := IF(Severity='E',dErrCodeToFieldCode[code].fieldCode,dWarnCodeToFieldCode[code].fieldCode);
	
	export dErrCodeToMsg :=  DICTIONARY(dsErrorCodes, {errCode=>msg});
	export dWarnCodeToMsg :=  DICTIONARY(dsWarningCodes, {errCode=>msg});
	export GetErrorMsg(string Severity, integer code) := IF(Severity='E',dErrCodeToMsg[code].msg,dWarnCodeToMsg[code].msg);

	export dErrCodeToText :=  DICTIONARY(dsErrorCodes, {errCode=>textValue});
	export dWarnCodeToText :=  DICTIONARY(dsWarningCodes, {errCode=>textValue});
	export GetErrorText(string Severity, integer code) := IF(Severity='E',dErrCodeToText[code].textValue,dWarnCodeToText[code].textValue);
	
	export dFieldCodeToName :=  DICTIONARY(dsFieldNames, {FieldCode=>FieldName});
	export GetFieldName(string code) := dFieldCodeToName[code].FieldName;
END;
