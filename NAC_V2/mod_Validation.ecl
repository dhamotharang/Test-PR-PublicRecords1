import ut, std;


//NormalizeName(string s) := (string)Std.Uni.CleanAccents(Std.Str.FindReplace(Std.Str.CleanSpaces(s),'¿','?'));

fixupMsg(string msg) := If(msg[1]='\n', msg[2..], msg);
rgxEmail := '^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$';

isAlphaChar(string1 ch) := ch BETWEEN 'A' AND 'Z';
isAlpha2(string2 s2) := isAlphaChar(s2[1]) AND isAlphaChar(s2[2]);

EXPORT mod_Validation := MODULE
	shared errcodes := Nac_V2.ValidationCodes.errcodes;
	shared warningCodes := Nac_V2.ValidationCodes.warningCodes;
	
	shared FieldCode(string severity, integer code) := nac_v2.ValidationCodes.GetFieldCode(severity,code);
	shared rErr := nac_v2.ValidationCodes.rError;
				 
	shared GetYear := Std.Date.Year(Std.Date.CurrentDate());
			
	shared IsValidDate(string date) := MAP(
						LENGTH(TRIM(date)) = 8 => Std.Date.IsValidDate((Std.Date.Date_t)date, 1900, 2100),
						LENGTH(TRIM(date)) = 6 => (integer)date[1..4] BETWEEN 1900 and 2100 AND
																			(integer)date[5..6] BETWEEN 1 and 12,
						false);
		
	shared validProgramState(string2 st, string2 state, string4 RecordCode) := IF(st not in Mod_Sets.States,	//    Consortium, 
											DATASET([{errcodes.E102, 'E', 'F', FieldCode('E',errcodes.E102), st, state, RecordCode}], rErr));
										//DATASET([{errcodes.E102, 'E', 'F', FieldCode('E',errcodes.E102), st}], rErr)); 
										//ROW({errcodes.E102, 'E', 'F', FieldCode('E',errcodes.E102), st}, rErr)); 
										//ROW({errcodes.E102, 'E', 'F', '5000', st}, rErr)); 




	shared validProgram(string1 program, string2 state, string4 RecordCode) := IF(program not in Mod_Sets.Benefit_Type,
										DATASET([{errcodes.E103, 'E', 'F', FieldCode('E',errcodes.E103), program, state, RecordCode}], rErr)); 
	

	shared boolean invalidID(string id) := id='' OR NOT REGEXFIND('^[A-Z0-9-]+$', TRIM(id), nocase);
	shared validCaseId(string caseId, string2 state, string4 RecordCode) := MAP(
					caseId = '' => DATASET([{errcodes.E104, 'E', 'F', FieldCode('E',errcodes.E104), caseId, state, RecordCode}], rErr),
					invalidID(caseId) => DATASET([{errcodes.E105, 'E', 'F', FieldCode('E',errcodes.E105), caseId, state, RecordCode}], rErr)
					);
					
	shared validClientId(string clientId, string2 state, string4 RecordCode) := MAP(
					clientId = '' => DATASET([{errcodes.E106, 'E', 'F', FieldCode('E',errcodes.E106), clientId, state, RecordCode}], rErr),
					invalidID(clientId) => DATASET([{errcodes.E107, 'E', 'F', FieldCode('E',errcodes.E107), clientId, state, RecordCode}], rErr)
					);
					
	shared validAddressType(string1 AddrType, string2 state, string4 RecordCode) := IF(AddrType not in Mod_Sets.Address_Type,  
										DATASET([{errcodes.E108, 'E', 'F', FieldCode('E',errcodes.E108), AddrType, state, RecordCode}], rErr)); 

	//shared boolean IsValidName(string name) := name<>'' and
	//									REGEXFIND('^[A-Z., _\'-]+$', NormalizeName(TRIM(name)), nocase);
	//shared ValidFirstName(string name, string2 state, string4 RecordCode) := IF(NOT IsValidName(name), 
	shared ValidFirstName(string name, string2 state, string4 RecordCode) := IF(name='', 
										DATASET([{errcodes.E109, 'E', 'F', FieldCode('E',errcodes.E109), name, state, RecordCode}], rErr)); 
	//shared ValidLastName(string name, string2 state, string4 RecordCode) := IF(NOT IsValidName(name),
	shared ValidLastName(string name, string2 state, string4 RecordCode) := IF(name='',
										DATASET([{errcodes.E110, 'E', 'F', FieldCode('E',errcodes.E110), name, state, RecordCode}], rErr)); 
	shared suffix_set := ['I','II', 'III','IV','V','VI', 'JR', 'SR'];
	
	shared ValidSsn(string9 ssn, string1 ssnType, string2 state, string4 RecordCode) := 
				IF(ssnType = Mod_Sets.Actual_Type AND NOT REGEXFIND('^\\d{9}$', TRIM(ssn)), 
										DATASET([{errcodes.E111, 'E', 'F', FieldCode('E',errcodes.E111), ssn, state, RecordCode}], rErr)
											);
	shared ValidSsnType(string1 ssnType, string2 state, string4 RecordCode) := IF(ssnType not in Mod_Sets.SSN_Type, 
										DATASET([{errcodes.E112, 'E', 'F', FieldCode('E',errcodes.E112), ssnType, state, RecordCode}], rErr));
	
	shared ValidDob(string8 dob, string2 state, string4 RecordCode) := IF(dob = '' OR NOT Std.Date.IsValidDate((Std.Date.Date_t)dob, 1900, GetYear + 1), 
										DATASET([{errcodes.E113, 'E', 'F', FieldCode('E',errcodes.E113), dob, state, RecordCode}], rErr));
	shared ValidDobType(string1 dobType, string2 state, string4 RecordCode) := IF(dobType not in Mod_Sets.Dob_Type, 
										DATASET([{errcodes.E114, 'E', 'F', FieldCode('E',errcodes.E114), dobType, state, RecordCode}], rErr));
	shared ValidEligibilityStatus(string1 Eligibility, string2 state, string4 RecordCode) := IF(Eligibility not in Mod_Sets.Eligible_Status, 
										DATASET([{errcodes.E115, 'E', 'F', FieldCode('E',errcodes.E115), Eligibility, state, RecordCode}], rErr));
	shared ValidEligibilityDate(string8 date, string1 Eligibility, string2 state, string4 RecordCode) := IF(Eligibility = 'E' AND
													(date = '' or not Std.Date.IsValidDate((Std.Date.Date_t)date, 1900, GetYear + 1)), 
													DATASET([{warningcodes.W111, 'W', 'F', FieldCode('W',warningcodes.W111), date, state, RecordCode}], rErr));

	shared ValidEligibilityPeriod(string1 period, string2 state, string4 RecordCode) := IF(period not in Mod_Sets.Period_Type, 
										DATASET([{errcodes.E116, 'E', 'F', FieldCode('E',errcodes.E116), period, state, RecordCode}], rErr));
										
	shared ValidStartDate(string date, string2 state, string4 RecordCode) := IF(NOT IsValidDate(date), 
										DATASET([{errcodes.E117, 'E', 'F', FieldCode('E',errcodes.E117), date, state, RecordCode}], rErr));
	shared ValidEndDate(string startdate, string enddate, string2 state, string4 RecordCode) := 
							IF(NOT IsValidDate(enddate)	OR 
								(IsValidDate(startdate) AND IsValidDate(enddate) AND (unsigned)enddate < (unsigned)startdate),
										DATASET([{errcodes.E118, 'E', 'F', FieldCode('E',errcodes.E118), enddate, state, RecordCode}], rErr));
	// ** Address Validation
	rgxValidStreet := '[A-Z0-9.,#/&_"\' -]+$';
	shared validStreet(string street) := 
							TRIM(Street) <> '' AND
							regexfind(rgxValidStreet, nac_v2.StandardizeName(street), nocase);
	shared ValidCity(string city) := REGEXFIND('^[A-Z29.,\' -]+$',TRIM(city), NOCASE);
	shared ValidState(string2 state) := state in ut.Set_State_Abbrev;
	shared ValidZipCode(string zip) := REGEXFIND('^(\\d{5}|\\d{9})$', TRIM(zip));	
						
	shared validMatchedProgramState(string2 st, string2 state, string4 RecordCode) := 
						IF(st NOT IN Mod_Sets.States,
							DATASET([{errcodes.E120, 'E', 'F', '2050', st, state, RecordCode}], rErr));
							
	shared validMatchedClientId(string clientId, string2 state, string4 RecordCode) := 
				IF(
					clientId = '' OR invalidID(clientId),
							DATASET([{errcodes.E121, 'E', 'F', '2051', clientId, state, RecordCode}], rErr));
									
	shared validMatchedGroupId(string4 MatchedGroupId, string2 state, string4 RecordCode) := 
				IF(
					NOT isAlpha2(MatchedGroupId[1..2]) OR NOT ut.isNumeric(MatchedGroupId[3..4]),
							DATASET([{errcodes.E124, 'E', 'F', '2052', MatchedGroupId, state, RecordCode}], rErr));
					
	shared validMatchedProgram(string1 program, string2 state, string4 RecordCode) :=  
						IF(program not in Mod_Sets.Benefit_Type, 
							DATASET([{errcodes.E126, 'E', 'F', '2053', program, state, RecordCode}], rErr));  

	shared boolean isOptionalInteger(string n) := REGEXFIND('^\\d*$', TRIM(n));
						
	shared boolean HasInvalidChar(string s) := REGEXFIND('[^ -~]+', s);
	shared string ReplaceInvalidChar(string s) := s;	//REGEXREPLACE('([^ -~])', s, '?');


	shared ValidRecordLength(BOOLEAN invalidLength, string2 state, string4 RecordCode, unsigned4 textLength) := IF(invalidLength = TRUE, 
										DATASET([{errcodes.E127, 'E', 'F', FieldCode('E',errcodes.E127), textLength, state, RecordCode}], rErr));  
	

	EXPORT ClientFile(Dataset(Layouts2.rClientEx) ds) := 
			PROJECT(ds, TRANSFORM(Layouts2.rClientEx,
				// error processing
					self.dsErrs := 
								validProgramState(left.ProgramState, left.ProgramState, left.RecordCode)
							+ validProgram(left.ProgramCode, left.ProgramState, left.RecordCode)
							+ validCaseId(left.CaseID, left.ProgramState, left.RecordCode)
							+ validClientId(left.ClientId, left.ProgramState, left.RecordCode)
							+ ValidFirstName(left.FirstName, left.ProgramState, left.RecordCode)
							+ ValidLastName(left.LastName, left.ProgramState, left.RecordCode)
							+ ValidSsn(left.ssn, left.ssnType, left.ProgramState, left.RecordCode)
							+ ValidSsnType(left.ssnType, left.ProgramState, left.RecordCode)
							+ ValidDob(left.dob, left.ProgramState, left.RecordCode)
							+ ValidDobType(left.dobType, left.ProgramState, left.RecordCode)
							+ ValidEligibilityStatus(left.Eligibility, left.ProgramState, left.RecordCode)
							+ ValidEligibilityPeriod(left.PeriodType, left.ProgramState, left.RecordCode)
							+ ValidStartDate(left.StartDate, left.ProgramState, left.RecordCode)
							+ ValidEndDate(left.StartDate, left.EndDate, left.ProgramState, left.RecordCode)
							+ ValidRecordLength(left.invalidLength,  left.ProgramState, left.RecordCode, left.textLength)
							// warnings
							+ ValidEligibilityDate(left.EffectiveDate, left.Eligibility, left.ProgramState, left.RecordCode)
							+	IF(HasInvalidChar(left.LastName), 
									DATASET([{warningCodes.W105, 'W', 'F', ValidationCodes.fcLastName, left.LastName, left.ProgramState, left.RecordCode}], rErr))
							+	IF(HasInvalidChar(left.FirstName),
									DATASET([{warningCodes.W105, 'W', 'F', ValidationCodes.fcFirstName, left.FirstName, left.ProgramState, left.RecordCode}], rErr))
							+	IF(left.MiddleName<> '' and HasInvalidChar(left.MiddleName),
									DATASET([{warningCodes.W105, 'W', 'F', ValidationCodes.fcMiddleName, left.MiddleName, left.ProgramState, left.RecordCode}], rErr))
							+	IF(left.NameSuffix<> '' and 
										Trim(STD.Str.RemoveSuffix(Std.Str.ToUpperCase(left.NameSuffix),'.')) NOT IN suffix_set,
									DATASET([{warningCodes.W105, 'W', 'F', ValidationCodes.fcSuffixName, left.NameSuffix, left.ProgramState, left.RecordCode}], rErr))

							+ IF(left.Race = '' OR left.Race not in Mod_sets.Race, 
									DATASET([{warningCodes.W101, 'W', 'F', FieldCode('W', warningCodes.W101), left.Race, left.ProgramState, left.RecordCode}], rErr))
							+ IF(left.Gender = '' OR left.Gender not in Mod_sets.Gender, 
									DATASET([{warningCodes.W102, 'W', 'F', FieldCode('W', warningCodes.W102), left.Gender, left.ProgramState, left.RecordCode}], rErr))
							+ IF(left.Ethnicity = '' OR left.Ethnicity not in Mod_sets.Ethnicity, 
									DATASET([{warningCodes.W103, 'W', 'F', FieldCode('W', warningCodes.W103), left.Ethnicity, left.ProgramState, left.RecordCode}], rErr))
							+ IF(left.ABAWDIndicator = '' OR left.ABAWDIndicator not in Mod_sets.ABAWD_Type, 
									DATASET([{warningCodes.W104, 'W', 'F', FieldCode('W', warningCodes.W104), left.ABAWDIndicator, left.ProgramState, left.RecordCode}], rErr))
							+ IF(left.Relationship<>'' AND left.Relationship NOT IN Mod_Sets.Relationship_Type, 
									DATASET([{warningCodes.W106, 'W', 'F', FieldCode('W', warningCodes.W106), left.Relationship, left.ProgramState, left.RecordCode}], rErr))
							+ IF(NOT isOptionalInteger(left.MonthlyAllotment), 
									DATASET([{warningCodes.W109, 'W', 'F', FieldCode('W', warningCodes.W109), left.MonthlyAllotment, left.ProgramState, left.RecordCode}], rErr))
							+ IF(NOT isOptionalInteger(left.HistoricalBenefitCount), 
									DATASET([{warningCodes.W110, 'W', 'F', FieldCode('W', warningCodes.W110), left.HistoricalBenefitCount, left.ProgramState, left.RecordCode}], rErr))
							+ IF(left.email <> '' AND NOT REGEXFIND(rgxEmail, TRIM(left.email), NOCASE), 
									DATASET([{warningCodes.W118, 'W', 'F', FieldCode('W', warningCodes.W118), left.email, left.ProgramState, left.RecordCode}], rErr))
							;
					self.errors := COUNT(self.dsErrs(severity='E'));
					self.warnings := COUNT(self.dsErrs(severity='W'));
					
					//self.LastName := IF(HasInvalidChar(left.LastName), NormalizeName(left.LastName), left.LastName);
					//self.FirstName := IF(HasInvalidChar(left.FirstName), NormalizeName(left.FirstName), left.FirstName);
					self.Race := IF(left.Race = '' OR left.Race not in Mod_sets.Race, 'U', left.Race);
					self.Gender := IF(left.Gender = '' OR left.Gender not in Mod_sets.Gender, 'U', left.Gender);
					self.Ethnicity := IF(left.Ethnicity = '' OR left.Ethnicity NOT IN Mod_Sets.Ethnicity, 'U', left.Ethnicity);
					self.ABAWDIndicator := IF(left.ABAWDIndicator = '' OR left.ABAWDIndicator NOT IN Mod_Sets.ABAWD_Type, 'U', left.ABAWDIndicator);
					// relationship if optional
					self.Relationship := IF(left.Relationship='' OR left.Relationship IN Mod_Sets.Relationship_Type, left.Relationship, 'O');

					self := LEFT;
					self := [];
				));
				
	EXPORT CaseFile(Dataset(Layouts2.rCaseEx) ds) := 
			PROJECT(ds, TRANSFORM(Layouts2.rCaseEx,
				// error processing
					self.dsErrs := 
							validProgramState(left.ProgramState, left.ProgramState, left.RecordCode)
							+ validProgram(left.ProgramCode, left.ProgramState, left.RecordCode)
							+ validCaseId(left.CaseID, left.ProgramState, left.RecordCode)
							+ ValidRecordLength(left.invalidLength,  left.ProgramState, left.RecordCode, left.textLength)
							// warnings
							+ IF(left.CountyCode='', 
									DATASET([{warningCodes.W117, 'W', 'F', FieldCode('W',warningCodes.W117), left.CountyCode, left.ProgramState, left.RecordCode}], rErr))

							+ IF(NOT isOptionalInteger(left.MonthlyAllotment), 
									DATASET([{warningCodes.W109, 'W', 'F', FieldCode('W', warningCodes.W109), left.MonthlyAllotment, left.ProgramState, left.RecordCode}], rErr))														
							+ IF(left.email <> '' AND NOT REGEXFIND(rgxEmail, TRIM(left.email), NOCASE), 
									DATASET([{warningCodes.W118, 'W', 'F', FieldCode('W', warningCodes.W118), TRIM(left.email), left.ProgramState, left.RecordCode}], rErr))
							;
					self.errors := COUNT(self.dsErrs(severity='E'));
					self.warnings := COUNT(self.dsErrs(severity='W'));
					self := LEFT;
					self := [];
				));
/**
1.       If an address field is missing or corrupted, but the address cleans OK, then no error message will be issued. However, we will issue a warning message.
2.       If all the address fields are populated with “good” data (i.e., no bad characters), then there will be no error, even if the address could not be cleaned.
3.       HOMELESS and GENERAL DELIVERY addresses will not result in error or warning messages
4.       Missing street is just a warning
**/
	
	boolean allowWarnings(string1 category) := category not in $.Mod_sets.Address_Category;
	EXPORT AddressFile(Dataset(Layouts2.rAddressEx) ds) := 
			PROJECT(ds, TRANSFORM(Layouts2.rAddressEx,
					self.dsErrs := 
								validProgramState(left.ProgramState, left.ProgramState, left.RecordCode)
							+ validProgram(left.ProgramCode, left.ProgramState, left.RecordCode)
							+ validCaseId(left.CaseID, left.ProgramState, left.RecordCode) 
							+ ValidRecordLength(left.invalidLength,  left.ProgramState, left.RecordCode, left.textLength)
							+ IF(left.ClientId <> '',  validClientId(left.ClientId, left.ProgramState, left.RecordCode))		// client id is optional
							+ IF(left.AddressType = '' OR left.AddressType not in NAC_V2.Mod_sets.Address_Type, 
									DATASET([{errcodes.E108, 'E', 'F', FieldCode('E', errcodes.E108), left.AddressType, left.ProgramState, left.RecordCode}], rErr))
							//+ IF(left.err_stat[1]='S' and 			// address cleaned with warnings
							//				left.err_stat[1..3] not in ['S00','S80','S01','S81'],	// ignore z4, suffix 	
							//				DATASET([{warningCodes.W114, 'W', 'R', FieldCode('W', warningCodes.W114), left.err_stat}], rErr))							
							// warnings
							+ IF(left.AddressCategory != '' AND left.AddressCategory not in NAC_V2.Mod_sets.Address_Category, 
									DATASET([{warningCodes.W108, 'W', 'F', FieldCode('W', warningCodes.W108), left.AddressCategory, left.ProgramState, left.RecordCode}], rErr))
							+ IF(allowWarnings(left.AddressCategory) AND left.err_stat[1]<>'S',
											DATASET([{warningCodes.W116, 'W', 'R', FieldCode('W', warningCodes.W116), left.err_stat, left.ProgramState, left.RecordCode}], rErr))							
							+ IF(allowWarnings(left.AddressCategory) AND NOT ValidStreet(left.Street1), 
									DATASET([{warningCodes.W112, 'W', 'F', ValidationCodes.fcStreet1, left.Street1, left.ProgramState, left.RecordCode}], rErr))
							+ IF(allowWarnings(left.AddressCategory) AND left.Street2<>'' AND NOT ValidStreet(left.Street2), 
									DATASET([{warningCodes.W112, 'W', 'F', ValidationCodes.fcStreet2, left.Street2, left.ProgramState, left.RecordCode}], rErr))
							+ IF(allowWarnings(left.AddressCategory) AND NOT ValidCity(left.City), 
									DATASET([{warningCodes.W113, 'W', 'F', FieldCode('W', warningCodes.W113), left.City, left.ProgramState, left.RecordCode}], rErr))
							+ IF(allowWarnings(left.AddressCategory) AND NOT ValidState(left.state), 
									DATASET([{warningCodes.W114, 'W', 'F', FieldCode('W', warningCodes.W114), left.state, left.ProgramState, left.RecordCode}], rErr))
							+ IF(allowWarnings(left.AddressCategory) AND NOT ValidZipCode(left.zipcode), 
									DATASET([{warningCodes.W115, 'W', 'F', FieldCode('W', warningCodes.W115), left.zip, left.ProgramState, left.RecordCode}], rErr))
							;

					self.errors := COUNT(self.dsErrs(severity='E'));
					self.warnings := COUNT(self.dsErrs(severity='W'));

					self.AddressCategory := IF(left.AddressCategory IN Mod_Sets.Address_Category, left.AddressCategory, '');
					self := LEFT;
					self := [];
				));
				
	EXPORT StateContactFile(Dataset(Layouts2.rStateContactEx) ds) := 
				PROJECT(ds, TRANSFORM(Layouts2.rStateContactEx,
					self.dsErrs := 
							validProgramState(left.ProgramState, left.ProgramState, left.RecordCode)
							+ 	ValidRecordLength(left.invalidLength,  left.ProgramState, left.RecordCode, left.textLength)
							+ validProgram(left.ProgramCode, left.ProgramState, left.RecordCode)
							+ IF(left.CaseID<>'', validCaseId(left.CaseID, left.ProgramState, left.RecordCode))
							+ IF(left.ClientId<>'', validClientId(left.ClientId, left.ProgramState, left.RecordCode))
							+ IF(left.UpdateType not in ['U','D','O'], 
											DATASET([{errCodes.E119, 'E', 'F', FieldCode('E', errCodes.E119), left.UpdateType, left.ProgramState, left.RecordCode}], rErr))							
							+ IF(left.ContactEmail <> '' AND NOT REGEXFIND(rgxEmail, TRIM(left.ContactEmail), NOCASE), 
									DATASET([{warningCodes.W118, 'W', 'F', '2042', left.ContactEmail, left.ProgramState, left.RecordCode}], rErr))
							+ IF(left.ContactName='' OR left.ContactPhone='' OR left.ContactEmail='', 
											DATASET([{errCodes.E125, 'E', 'F', FieldCode('E', errCodes.E125), '', left.ProgramState, left.RecordCode}], rErr))							
							;

					self.errors := COUNT(self.dsErrs(severity='E'));
					self.warnings := COUNT(self.dsErrs(severity='W'));
					self := LEFT;
					self := []));
							
	EXPORT ExceptionFile(Dataset(Layouts2.rExceptionEx) ds) := 
				PROJECT(ds, TRANSFORM(Layouts2.rExceptionEx,
					self.dsErrs := 
							// source fields
							validProgramState(left.SourceProgramState, left.SourceProgramState, left.RecordCode)
							+ validProgram(left.SourceProgramCode, left.SourceProgramState, left.RecordCode)
							+ validClientId(left.SourceClientId, left.SourceProgramState, left.RecordCode)
							+ ValidRecordLength(left.invalidLength,  left.SourceProgramState, left.RecordCode, left.textLength)
							// 
							// matched fields
							+ validMatchedProgramState(left.MatchedState, left.SourceProgramState, left.RecordCode)
							+ validMatchedClientId(left.MatchedClientId, left.SourceProgramState, left.RecordCode)							
							+ validMatchedGroupId(left.MatchedGroupId, left.SourceProgramState, left.RecordCode)
							+ validMatchedProgram(left.MatchedProgramCode, left.SourceProgramState, left.RecordCode)
							
							+ IF(left.UpdateType not in ['U','D'], 
											DATASET([{errCodes.E119, 'E', 'F', FieldCode('E', errCodes.E119), left.UpdateType, left.SourceProgramState, left.RecordCode}], rErr))							
							;

					self.errors := COUNT(self.dsErrs(severity='E'));
					self.warnings := COUNT(self.dsErrs(severity='W'));
					self := LEFT;
					self := []));
				
	EXPORT VerifyRelatedClients(Dataset(Layouts2.rCaseEx) cases, Dataset(Layouts2.rClientEx) clients) := FUNCTION
					ca := DISTRIBUTE(cases(errors=0), Hash32(GroupId, ProgramCode, ProgramState, CaseId));
					cl := DISTRIBUTE(clients, Hash32(GroupId, ProgramCode, ProgramState, CaseId));
					j1 := JOIN(cl, ca, left.GroupId=right.GroupId
															AND left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(Layouts2.rClientex,
												self.dsErrs := left.dsErrs + DATASET([{errcodes.E123, 'E', 'F', FieldCode('E', errcodes.E123), left.CaseId, left.ProgramState, left.RecordCode}], rErr);
												self.errors := left.errors + 1;
												self := left;),
										LEFT ONLY, LOCAL);
					j2 := JOIN(cl, ca, left.GroupId=right.GroupId
															AND left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(Layouts2.rClientex,
												self := left;),
										INNER, KEEP(1), LOCAL);
					RETURN j1 & j2;
	END;

	EXPORT VerifyRelatedAddresses(Dataset(Layouts2.rCaseEx) cases, Dataset(Layouts2.rClientEx) clients, Dataset(Layouts2.rAddressEx) addresses) := FUNCTION
					ca := DISTRIBUTE(cases(errors=0), Hash32(GroupId, ProgramCode, ProgramState, CaseId));
					cl := DISTRIBUTE(clients(errors=0), Hash32(GroupId, ProgramCode, ProgramState, CaseId, ClientId));
					ad1 := DISTRIBUTE(addresses, Hash32(GroupId, ProgramCode, ProgramState, CaseId));	// no 

					// find address records with no matching case id								
					j1 := JOIN(ad1, ca, left.GroupId=right.GroupId
															AND left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(nac_v2.Layouts2.rAddressEx,
												self.dsErrs := left.dsErrs + DATASET([{errcodes.E123, 'E', 'F', FieldCode('E', errcodes.E123), left.CaseId, left.ProgramState, left.RecordCode}], rErr);
												self.errors := left.errors + 1;
												self := left;),
										LEFT ONLY, LOCAL);
										
					j2 := JOIN(ad1, ca, left.GroupId=right.GroupId
															AND left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId,
										TRANSFORM(nac_v2.Layouts2.rAddressEx,
												self := left;),
										INNER, KEEP(1), LOCAL);
										
					// find address records with no matching client id								
					ad2 := DISTRIBUTE(j2(ClientId<>''), Hash32(GroupId, ProgramCode, ProgramState, CaseId, ClientId));
					j3 := JOIN(ad2, cl, left.GroupId=right.GroupId
															AND left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId
															AND left.ClientId=right.ClientId,
										TRANSFORM(nac_v2.Layouts2.rAddressEx,
												self.dsErrs := left.dsErrs + DATASET([{errcodes.E122, 'E', 'F', FieldCode('E', errcodes.E122), left.ClientId, left.ProgramState, left.RecordCode}], rErr);
												self.errors := left.errors + 1;
												self := left;),
										LEFT ONLY, LOCAL);
										
					j4 := JOIN(ad2, cl, left.GroupId=right.GroupId
															AND left.ProgramCode=right.ProgramCode
															AND left.ProgramState=right.ProgramState
															AND left.CaseId=right.CaseId
															AND left.ClientId=right.ClientId,
										TRANSFORM(nac_v2.Layouts2.rAddressEx,
												self := left;),
										INNER, KEEP(1), LOCAL);
										
					return j1 & j2(ClientId='') & j3 & j4;
	
	END;
	
	EXPORT ValidateRecordCode(Dataset(Layouts2.rBadRecord) ds) := 
				PROJECT(ds, TRANSFORM(Layouts2.rBadRecordEx, SKIP(left.RecordCode in Layouts2.ValidRecordCodes),
					self.dsErrs := IF(left.RecordCode not in Layouts2.ValidRecordCodes, 
											DATASET([{errCodes.E101, 'E', 'R', FieldCode('E', errCodes.E101), left.RecordCode, 'XX', left.RecordCode}], rErr));							
					self.errors := COUNT(self.dsErrs(severity='E'));
					self.warnings := COUNT(self.dsErrs(severity='W'));
					self := LEFT;
					self := []));


END;