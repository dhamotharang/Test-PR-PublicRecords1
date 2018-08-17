Import ut, std, _Validate;


NormalizeName(string s) := (string)Std.Uni.CleanAccents(Std.Str.FindReplace(Std.Str.CleanSpaces(s),'¿','?'));

fixupMsg(string msg) := If(msg[1]='\n', msg[2..], msg);

EXPORT Validate := MODULE

	EXPORT	errcodes := ENUM(
		E101 = 0x0000001,				// Invalid Record Code
		E102 = 0x0000002,				// Invalid/Missing Contributing State
		E103 = 0x0000004,				// Invalid/Missing Program Code
		E104 = 0x0000008,				// Missing Case Identifier
		E105 = 0x0000010,				// Invalid Case Identifier
		E106 = 0x0000020,				// Invalid/Missing County/Parish Code
		E107 = 0x0000040,				// Missing Client Identifier				
		E108 = 0x0000080,				// Invalid Client Identifier
		E109 = 0x0000100,				// Invalid/Missing Address Type Code			
		E110 = 0x0000200,				// Invalid/Missing Address Street 1
		E111 = 0x0000400,				// Invalid/Missing Address City
		E112 = 0x0000800,				// Invalid/Missing Address State
		E113 = 0x0001000,				// Invalid/Missing Address Zip
		E114 = 0x0002000,				// Invalid/Missing First Name
		E115 = 0x0004000,				// Invalid/Missing Last Name
		E116 = 0x0008000,				// Invalid/Missing SSN
		E117 = 0x0010000,				// Invalid/Missing SSN Type Code
		E118 = 0x0020000,				// Invalid/Missing DOB				
		E119 = 0x0040000,				// Invalid/Missing DOB Type Code
		E120 = 0x0080000,				// Invalid/Missing Eligibility Indicator Code
		E121 = 0x0100000,				// Invalid/Missing Eligibility Effective Date
		E122 = 0x0200000,				// Invalid/Missing Eligibility Period Type Code
		E123 = 0x0400000,				// Invalid/Missing Eligibility Start Date/Month
		E124 = 0x0800000,				// Invalid/Missing Eligibility End Date/Month
		E125 = 0x1000000,				// Invalid/Missing Update Type Code
		E126 = 0x2000000,				// Invalid/Missing Matched State Code
		E127 = 0x4000000,				// Invalid/Missing Matched Client Identifier
		E128 = 0x8000000,				// Missing Related Client Record
		E129 = 0x10000000				// Missing Related Case Record
	);
	
	EXPORT	getErrorMessages(unsigned8 errors) := fixupMsg(
			IF(errors & errcodes.E101<>0, '\nE101: Invalid Record Code', '')
		+ IF(errors & errcodes.E102<>0, '\nE102: Invalid/Missing Contributing State', '')
		+ IF(errors & errcodes.E103<>0, '\nE103: Invalid/Missing Program Code', '')
		+ IF(errors & errcodes.E104<>0, '\nE104: Missing Case Identifier', '')
		+ IF(errors & errcodes.E105<>0, '\nE105: Invalid Case Identifier', '')
		+ IF(errors & errcodes.E106<>0, '\nE106: Invalid/Missing County/Parish Code', '')
		+ IF(errors & errcodes.E107<>0, '\nE107: Missing Client Identifier', '')
		+ IF(errors & errcodes.E108<>0, '\nE108: Invalid Client Identifier', '')
		+ IF(errors & errcodes.E109<>0, '\nE109: Invalid/Missing Address Type Code', '')
		+ IF(errors & errcodes.E110<>0, '\nE110: Invalid/Missing Address Street', '')
		+ IF(errors & errcodes.E111<>0, '\nE111: Invalid/Missing Address City', '')
		+ IF(errors & errcodes.E112<>0, '\nE112: Invalid/Missing Address State', '')
		+ IF(errors & errcodes.E113<>0, '\nE113: Invalid/Missing Address Zip', '')
		+ IF(errors & errcodes.E114<>0, '\nE114: Invalid/Missing First Name', '')
		+ IF(errors & errcodes.E115<>0, '\nE115: Invalid/Missing Last Name', '')
		+ IF(errors & errcodes.E116<>0, '\nE116: Invalid/Missing SSN', '')
		+ IF(errors & errcodes.E117<>0, '\nE117: Invalid/Missing SSN Type Code', '')
		+ IF(errors & errcodes.E118<>0, '\nE118: Invalid/Missing DOB', '')
		+ IF(errors & errcodes.E119<>0, '\nE119: Invalid/Missing DOB Type Code', '')
		+ IF(errors & errcodes.E120<>0, '\nE120: Invalid/Missing Eligibility Indicator Code', '')
		+ IF(errors & errcodes.E121<>0, '\nE121: Invalid/Missing Eligibility Effective Date', '')
		+ IF(errors & errcodes.E122<>0, '\nE122: Invalid/Missing Eligibility Period Type Code', '')
		+ IF(errors & errcodes.E123<>0, '\nE123: Invalid/Missing Eligibility Start Date/Month', '')
		+ IF(errors & errcodes.E124<>0, '\nE124: Invalid/Missing Eligibility End Date/Month', '')
		+ IF(errors & errcodes.E125<>0, '\nE125: Invalid/Missing Update Type Code', '')
		+ IF(errors & errcodes.E126<>0, '\nE126: Invalid/Missing Matched State Code', '')
		+ IF(errors & errcodes.E127<>0, '\nE127: Invalid/Missing Matched Client Identifier', '')
		+ IF(errors & errcodes.E128<>0, '\nE128: Missing Related Client Record', '')
		+ IF(errors & errcodes.E129<>0, '\nE129: Missing Related Case Record', '')
		);
		
	EXPORT	warningcodes := ENUM(
		W101 = 0x000001,				// Invalid/Missing Race Value, Set to "U"
		W102 = 0x000002,				// Invalid/Missing Gender Value, Set to "U"
		W103 = 0x000004,				// Invalid/Missing Ethnicity Value, Set to "U"
		W104 = 0x000008,				// Invalid/Missing ABAWD Indicator, Set to "U"
		W105 = 0x000010,				// Invalid Character in Name, Changed to "?"
		W106 = 0x000020,				// Invalid Relationship Indicator, Changed to "O"
		W107 = 0x000040,				// Invalid Character in Address, Changed to "?"
		W108 = 0x000080,				// Invalid Address Category, Changed to Blank
		W109 = 0x000100,				// Invalid Monthly Allotment Value
		W110 = 0x000200,				// Invalid Historical Benefit Count
		W111 = 0x000400,				// Missing street in address
		W112 = 0x000800					// Invalid/Missing Eligibility Effective Date
	);
		
	EXPORT	getWarningMessages(unsigned4 warnings) := 
				fixupMsg(
						IF(warnings & warningCodes.W101<>0, 	'\nW101: Invalid/Missing Race Value, Set to "U"', '')
						+ IF(warnings & warningCodes.W102<>0, '\nW102: Invalid/Missing Gender Value, Set to "U"', '')
						+ IF(warnings & warningCodes.W103<>0, '\nW103: Invalid/Missing Ethnicity Value, Set to "U"', '')
						+ IF(warnings & warningCodes.W104<>0, '\nW105: Invalid/Missing ABAWD Value, Set to "U"', '')
						+ IF(warnings & warningCodes.W105<>0, '\nW105: Invalid Character in Name, Changed to "?"', '')
						+ IF(warnings & warningCodes.W106<>0, '\nW106: Invalid Relationship Indicator, Changed to "O"', '')
						+ IF(warnings & warningCodes.W107<>0, '\nW107: Invalid Character in Address, Changed to "?"', '')
						+ IF(warnings & warningCodes.W108<>0, '\nW108: Invalid Address Category, Changed to Blank', '')
						+ IF(warnings & warningCodes.W109<>0, '\nW109: Invalid Monthly Allotment Value', '')
						+ IF(warnings & warningCodes.W110<>0, '\nW110: Invalid Historical Benefit Count', '')
						+ IF(warnings & warningCodes.W111<>0, '\nW111: Missing street in address', '')
						+ IF(warnings & warningCodes.W112<>0, '\nW112: Invalid/Missing Eligibility Effective Date', '')
						);
		
	rgxBadAddress :=
			 '\\b(SAME|GENERAL.*DELIVERY|HOMELESS|DONALD LEE HOLLOWELL)\\b';
			 
	rgxValidStreet := '^[A-Z0-9.,#/&_"\' -]+$';
	shared validStreet(string street) := IF(
							TRIM(Street) = '' OR
							NOT regexfind(rgxValidStreet, NormalizeName(street), nocase),
							errcodes.E110, 0);
		
	shared IsValidDate(string date) := MAP(
						LENGTH(TRIM(date)) = 8 => _Validate.Date_New(1900, 2100).fIsValid(date),
						LENGTH(TRIM(date)) = 6 => (integer)date[1..4] BETWEEN 1900 and 2100 AND
																			(integer)date[5..6] BETWEEN 1 and 12,
						false);
		
	shared validProgramState(string2 st) := IF(st in Mod_Sets.Consortium, 0, errcodes.E102);
	shared validProgram(string1 program) := IF(program in Mod_Sets.IES_Benefit_Type, 0, errcodes.E103);
	shared boolean invalidID(string id) := id='' OR NOT REGEXFIND('^[A-Z0-9-]+$', TRIM(id), nocase);
	shared validCaseId(string caseId) := MAP(
					caseId = '' => errcodes.E104,
					invalidID(caseId) => errcodes.E105,
					0);
	shared validClientId(string clientId) := MAP(
					clientId = '' => errcodes.E106,
					invalidID(clientId) => errcodes.E108,
					0);
	shared validAddressType(string1 AddrType) := IF(AddrType in Mod_Sets.Address_Type, 0, errcodes.E109);
	shared boolean IsValidName(string name) := name<>'' and
										REGEXFIND('^[A-Z., _\'-]+$', NormalizeName(TRIM(name)), nocase);
	shared ValidFirstName(string name) := IF(IsValidName(name), 0, errcodes.E114);
	shared ValidLastName(string name) := IF(IsValidName(name), 0, errcodes.E115);
	shared ValidSsn(string9 ssn, string1 ssnType) := 
				IF(ssnType = Mod_Sets.Actual_Type AND
						NOT REGEXFIND('^\\d{9}$', TRIM(ssn)), errcodes.E116, 0);
	shared ValidSsnType(string1 ssnType) := IF(ssnType in Mod_Sets.SSN_Type, 0, errcodes.E117);
	shared ValidDob(string8 dob) := IF(dob <> '' and ut.ValidDate(dob), 0, errcodes.E118);
	shared ValidDobType(string1 dobType) := IF(dobType in Mod_Sets.Dob_Type, 0, errcodes.E119);
	shared ValidEligibilityStatus(string1 Eligibility) := IF(Eligibility in Mod_Sets.Eligible_Status, 0, errcodes.E120);
	shared ValidEligibilityDate(string8 date, string1 Eligibility) := IF(Eligibility <> 'E', 0,
												IF(date <> '' and ut.ValidDate(date), 0, errcodes.E121));
	shared ValidEligibilityPeriod(string1 period) := IF(period in Mod_Sets.Period_Type, 0, errcodes.E122);
	shared ValidStartDate(string date) := IF(IsValidDate(date), 0, errcodes.E123);
	shared ValidEndDate(string date) := IF(IsValidDate(date), 0, errcodes.E112);
	// ** Address Validation
	shared ValidCity(string city) := IF(REGEXFIND('^[A-Z29.,\' -]+$',TRIM(city), NOCASE), 0, errcodes.E111);
	shared ValidState(string2 state) := IF(state in Mod_Sets.States, 0, errcodes.E112);
	shared ValidZipCode(string zip) := MAP(
						zip[1..4]='0000' and zip[5]<>'0' => errcodes.E113,
						REGEXFIND('^(\\d{5}|\\d{9})$', TRIM(zip)) => 0,
						errcodes.E113);
	
	shared validCountyCode(string3 code, string2 st) := 
						IF(code='', errcodes.E106, 0);
	shared validMatchedProgramState(string2 st) := IF(st in Mod_Sets.Consortium, 0, errcodes.E126);
	shared validMatchedClientId(string clientId) := MAP(
					clientId = '' => errcodes.E127,
					invalidID(clientId) => errcodes.E127,
					0);
					
	shared boolean isOptionalInteger(string n) := REGEXFIND('^\\d*$', TRIM(n));
						
	shared boolean HasInvalidChar(string s) := REGEXFIND('[^ -~]+', s);
	shared string ReplaceInvalidChar(string s) := s;	//REGEXREPLACE('([^ -~])', s, '?');

	EXPORT ClientFile(Dataset(Layouts2.rClientEx) ds) := 
			PROJECT(ds, TRANSFORM(Layouts2.rClientEx,
				// error processing
					self.errors := validProgramState(left.ProgramState)
							+ validProgram(left.ProgramCode)
							+ validCaseId(left.CaseID)
							+ validClientId(left.ClientId)
							+ ValidFirstName(left.FirstName)
							+ ValidLastName(left.LastName)
							+ ValidSsn(left.ssn, left.ssnType)
							+ ValidSsnType(left.ssnType)
							+ ValidDob(left.dob)
							+ ValidDobType(left.dobType)
							+ ValidEligibilityStatus(left.Eligibility)
							//+ ValidEligibilityDate(left.EffectiveDate, left.Eligibility)
							+ ValidEligibilityPeriod(left.PeriodType)
							+ ValidStartDate(left.StartDate)
							+ ValidEndDate(left.EndDate)
							;
					self.warnings := 
								IF(HasInvalidChar(left.LastName) OR HasInvalidChar(left.FirstName), warningCodes.W105, 0)
							+ IF(left.Race = '' OR left.Race not in Mod_sets.Race, warningCodes.W101, 0)
							+ IF(left.Gender = '' OR left.Gender not in Mod_sets.Gender, warningCodes.W102, 0)
							+ IF(left.Ethnicity = '' OR left.Ethnicity not in Mod_sets.Ethnicity, warningCodes.W103, 0)
							+ IF(left.ABAWDIndicator = '', warningCodes.W104, 0)
							+ IF(left.Relationship='' OR left.Relationship IN Mod_Sets.Relationship_Type, 0, warningCodes.W106)
							+ IF(isOptionalInteger(left.MonthlyAllotment), 0, warningCodes.W107)
							+ IF(isOptionalInteger(left.HistoricalBenefitCount), 0, warningCodes.W108)
							+ IF(IsValidDate(left.EffectiveDate), 0, warningCodes.W112)
							;
					//self.LastName := IF(HasInvalidChar(left.LastName), NormalizeName(left.LastName), left.LastName);
					//self.FirstName := IF(HasInvalidChar(left.FirstName), NormalizeName(left.FirstName), left.FirstName);
					self.Race := IF(left.Race = '', 'U', left.Race);
					self.Gender := IF(left.Gender = '', 'U', left.Gender);
					self.Ethnicity := IF(left.Ethnicity = '', 'U', left.Ethnicity);
					self.ABAWDIndicator := IF(left.ABAWDIndicator = '', 'U', left.ABAWDIndicator);
					self.Relationship := IF(left.Relationship='' OR left.Relationship IN Mod_Sets.Relationship_Type, left.Relationship, 'O');

					self := LEFT;
					self := [];
				));
				
	EXPORT CaseFile(Dataset(Layouts2.rCase) ds) := 
			PROJECT(ds, TRANSFORM(Layouts2.rCaseEx,
				// error processing
					self.errors := validProgramState(left.ProgramState)
							+ validProgram(left.ProgramCode)
							+ validCaseId(left.CaseID)
							+ validCountyCode(left.CountyCode, left.ProgramState)
							;
					self.warnings := 
							IF(isOptionalInteger(left.MonthlyAllotment), 0, warningCodes.W107)
							;
					self := LEFT;
					self := [];
				));
/**
1.       If an address field is missing or corrupted, but the address cleans OK, then no error message will be issued. However, we will issue a warning message.
2.       If all the address fields are populated with “good” data (i.e., no bad characters), then there will be no error, even if the address could not be cleaned.
3.       HOMELESS and GENERAL DELIVERY addresses will not result in error or warning messages
4.       Missing street is just a warning
**/

	AddressErrors(string city, string state, string zip) :=
							ValidCity(city)
							+ ValidState(state)
							+ ValidZipCode(zip);

	EXPORT AddressFile(Dataset(Layouts2.rAddressEx) ds) := 
			PROJECT(ds, TRANSFORM(Layouts2.rAddressEx,
					err := AddressErrors(left.city, left.state, left.ZipCode);
				// error processing
					self.errors := validProgramState(left.ProgramState)
							+ validProgram(left.ProgramCode)
							+ validCaseId(left.CaseID)
							+ IF(left.ClientId='', 0, validClientId(left.ClientId))		// missing is OK
							+ IF(left.err_stat[1]='S', 0, err)		// not an error if it cleans ok
							;
					self.warnings := 
								IF(left.Street1 = '', warningCodes.W111, 0)
							+	IF(HasInvalidChar(left.Street1) OR HasInvalidChar(left.Street2), warningCodes.W107, 0)
							+ IF(left.AddressCategory='' OR left.AddressCategory IN Mod_Sets.Address_Category, 0, warningCodes.W108);
					self.Street1 := IF(HasInvalidChar(left.Street1), ReplaceInvalidChar(left.Street1), left.Street1);
					self.Street2 := IF(HasInvalidChar(left.Street2), ReplaceInvalidChar(left.Street2), left.Street2);
					self.AddressCategory := IF(left.AddressCategory IN Mod_Sets.Address_Category, left.AddressCategory, '');
					self := LEFT;
					self := [];
				));
				
	EXPORT StateContactFile(Dataset(Layouts2.rStateContact) ds) := 
				PROJECT(ds, TRANSFORM(Layouts2.rStateContactEx,
					self.errors := validProgramState(left.ProgramState)
							+ validProgram(left.ProgramCode)
							+ if(left.CaseId<>'', validCaseId(left.CaseID), 0)			// missing case id is OK
							+ if(left.ClientId<>'', validCaseId(left.ClientId), 0)	// missing Client Id is OK
							+ if(left.UpdateType in ['U','D','O'], 0, errcodes.E125);
					self.warnings := 0;
					self := LEFT;
					self := []));
							
	EXPORT ExceptionFile(Dataset(Layouts2.rException) ds) := 
				PROJECT(ds, TRANSFORM(Layouts2.rExceptionEx,
					self.errors := validProgramState(left.SourceProgramState)
							+ validProgram(left.SourceProgramCode)
							+ validClientId(left.SourceClientId)
							+ if(left.UpdateType in ['U','D'], 0, errcodes.E125)
							+ validProgramState(left.MatchedState)
							+ validProgramState(left.MatchedClientId);
					self.warnings := 0;
					self := LEFT;
					self := []));
				
	EXPORT VerifyRelatedClients(Dataset(Layouts2.rCaseEx) cases, Dataset(Layouts2.rClientEx) clients) := FUNCTION
					ca := DISTRIBUTE(cases, Hash64(ProgramCode, ProgramState, CaseId));
					cl := DISTRIBUTE(clients, Hash64(ProgramCode, ProgramState, CaseId));
					j1 := JOIN(cl, ca, left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(Layouts2.rClientex,
												self.errors := left.errors + errcodes.E129;
												self := left;),
										LEFT ONLY, LOCAL);
					j2 := JOIN(cl, ca, left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(Layouts2.rClientex,
												self := left;),
										INNER, LOCAL);
					RETURN j1 & j2;
	END;

	EXPORT VerifyRelatedAddresses(Dataset(Layouts2.rCaseEx) cases, Dataset(Layouts2.rClientEx) clients, Dataset(Layouts2.rAddressEx) addresses) := FUNCTION
					ca := DISTRIBUTE(cases, Hash64(ProgramCode, ProgramState, CaseId));
					cl := DISTRIBUTE(clients, Hash64(ProgramCode, ProgramState, ClientId));
					ad1 := DISTRIBUTE(addresses, Hash64(ProgramCode, ProgramState, CaseId));
					
													
					j1 := JOIN(ad1, ca, left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(Layouts2.rAddressEx,
												self.errors := left.errors + errcodes.E129;
												self := left;),
										LEFT ONLY, LOCAL);
					j2 := JOIN(ad1, ca, left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(Layouts2.rAddressEx,
												self := left;),
										INNER, LOCAL);
										
					ad2 := DISTRIBUTE(j1(ClientId<>''), Hash64(ProgramCode, ProgramState, ClientId));
					j3 := JOIN(ad2, cl, left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.ClientId=right.ClientId,
										TRANSFORM(Layouts2.rAddressEx,
												self.errors := left.errors + errcodes.E128;
												self := left;),
										LEFT ONLY, LOCAL);
					j4 := JOIN(ad2, cl, left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.ClientId=right.ClientId,
										TRANSFORM(Layouts2.rAddressEx,
												self := left;),
										INNER, LOCAL);
										
					return j1(ClientId='') & j2(ClientId='') & j3 & j4;
	
	END;


END;