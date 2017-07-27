EXPORT ValidationCodes := MODULE

	export rError := RECORD
		integer		errCode;
		string1		Severity;				// error or warning
		string1		Level;				// file/record/field
		string4		fieldCode;
		string		badValue;
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
	
	EXPORT dsErrorCodes := DATASET([
		{Nac_V2.errcodes.E101,'E101','R','3001','Invalid Record Code'},
		{Nac_V2.errcodes.E102,'E102','F','2001','Invalid/Missing Contributing State'},
		{Nac_V2.errcodes.E103,'E103','F','2002','Invalid/Missing Program Code'},
		{Nac_V2.errcodes.E104,'E104','F','2004','Missing Case Identifier'},
		{Nac_V2.errcodes.E105,'E105','F','2003','Invalid Case Identifier'},
		{Nac_V2.errcodes.E106,'E106','F','2006','Invalid/Missing County/Parish Code'},
		{Nac_V2.errcodes.E107,'E107','F','2011','Missing Client Identifier'},				
		{Nac_V2.errcodes.E108,'E108','F','2011','Invalid Client Identifier'},
		{Nac_V2.errcodes.E109,'E109','F','2037','Invalid/Missing Address Type Code'},			
		{Nac_V2.errcodes.E110,'E110','F','2032','Invalid/Missing Address Street 1'},
		{Nac_V2.errcodes.E111,'E111','F','2034','Invalid/Missing Address City'},
		{Nac_V2.errcodes.E112,'E112','F','2035','Invalid/Missing Address State'},
		{Nac_V2.errcodes.E113,'E113','F','2036','Invalid/Missing Address Zip'},
		{Nac_V2.errcodes.E114,'E114','F','2013','Invalid/Missing First Name'},
		{Nac_V2.errcodes.E115,'E115','F','2012','Invalid/Missing Last Name'},
		{Nac_V2.errcodes.E116,'E116','F','2019','Invalid/Missing SSN'},
		{Nac_V2.errcodes.E117,'E117','F','2020','Invalid/Missing SSN Type Code'},
		{Nac_V2.errcodes.E118,'E118','F','2021','Invalid/Missing DOB'},				
		{Nac_V2.errcodes.E119,'E119','F','2022','Invalid/Missing DOB Type Code'},
		{Nac_V2.errcodes.E120,'E120','F','2021','Invalid/Missing Eligibility Indicator Code'},
		{Nac_V2.errcodes.E121,'E121','F','2024','Invalid/Missing Eligibility Effective Date'},
		{Nac_V2.errcodes.E122,'E122','F','2025','Invalid/Missing Eligibility Period Type Code'},
		{Nac_V2.errcodes.E123,'E123','F','2026','Invalid/Missing Eligibility Start Date/Month'},
		{Nac_V2.errcodes.E124,'E124','F','2027','Invalid/Missing Eligibility End Date/Month'},
		{Nac_V2.errcodes.E125,'E125','R','3002','Invalid/Missing Update Type Code'},
		{Nac_V2.errcodes.E126,'E126','F','2050','Invalid/Missing Matched State Code'},
		{Nac_V2.errcodes.E127,'E127','F','2051','Invalid/Missing Matched Client Identifier'},
		{Nac_V2.errcodes.E128,'E128','R','3004','Missing Related Client Record'},
		{Nac_V2.errcodes.E129,'E129','R','3003','Missing Related Case Record'}
	], rCodeTable);

	EXPORT dsWarningCodes := DATASET([
		{Nac_V2.warningcodes.W101,'W101','F','2017','Invalid/Missing Race Value, Set to "U"'},
		{Nac_V2.warningcodes.W102,'W102','F','2016','Invalid/Missing Gender Value, Set to "U"'},
		{Nac_V2.warningcodes.W103,'W103','F','2018','Invalid/Missing Ethnicity Value, Set to "U"'},
		{Nac_V2.warningcodes.W104,'W104','F','2038','Invalid/Missing ABAWD Indicator, Set to "U"'},
		{Nac_V2.warningcodes.W105,'W105','R','2003','Invalid Character in Name, Changed to "?"'},
		{Nac_V2.warningcodes.W106,'W106','F','2029','Invalid Relationship Indicator, Changed to "O"'},
		{Nac_V2.warningcodes.W107,'W107','R','2011','Invalid Character in Address, Changed to "?" '},				
		{Nac_V2.warningcodes.W108,'W108','F','2038','Invalid Address Category, Changed to Blank'},
		{Nac_V2.warningcodes.W109,'W109','F','2005','Invalid Monthly Allotment Value '},
		{Nac_V2.warningcodes.W110,'W110','F','2031','Invalid Historical Benefit Count'},
		{Nac_V2.warningcodes.W111,'W111','F','2032','Missing street in address'},				
		{Nac_V2.warningcodes.W112,'W112','F','2024','Invalid/Missing Eligibility Effective Date'},
		{Nac_V2.warningcodes.W113,'W113','R','3005','Invalid Postal Address'},
		{Nac_V2.warningcodes.W114,'W114','R','3005','Postal Address cleaned with warnings'}
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
		{'2015',	'Matched Client Identifier'},
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
