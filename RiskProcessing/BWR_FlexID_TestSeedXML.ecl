#workunit('name','FlexID XML TestSeed Process');
#option ('hthorMemoryLimit', 1000);
IMPORT iesp, Models, Risk_Indicators, RiskWise, Seed_Files, UT;

/* *************************************************************
****************************************************************
**                     -= OPTIONS =-                          **
****************************************************************
************************************************************** */
// Name of the output file
outputFile := '~bpahl::out::FlexID_Seeds.csv';

// Username and password needed to log into the ESP and request test seeds
espUsername := 'randytestseeds';
espPassword := 'w3r1co$$';

// Number of records to run through the service (0 means run them all)
keepRecords := 0;

// Test seed dataset name - this will likely be blank 99% of the time
datasetName := '';

// Number of days to keep the output file on Thor before it is automatically deleted
expireDays := 30;

// IP address of the ESP Flex ID is deployed to
// espIPAddress := '10.176.68.145:7507';
espIPAddress := 'lnproxy.seisint.com:9006';

// Number of parallel soap calls to make to the ESP - Probably only need 1 or 2
parallelSoapThreads := 1;

// Number of sample records to see in each of the outputs
eyeball := 30;

/* *************************************************************
****************************************************************
**                    -= MAIN CODE =-                         **
****************************************************************
************************************************************** */
// espIP := 'https://randytestseeds:w3r1co$$@10.176.68.145:7507/WsIdentity/?ver_=1.72';
espIP := 'https://' + espUsername + ':' + espPassword + '@' + espIPAddress + '/WsIdentity/?ver_=1.72';

OUTPUT(espIP, NAMED('ESP_IP_Address'));

FlexIDTestSeeds := Seed_Files.Key_FlexID;
InstantIDTestSeeds := Seed_Files.Key_InstantID;

inputLayout := RECORD
	STRING Seq := '';
	STRING AccountNumber := '';
	STRING FirstName := '';
	STRING LastName := '';
	STRING Zip := '';
	STRING SSN := '';
	STRING HomePhone := '';
END;

inputLayout getFlexInputs(FlexIDTestSeeds le, INTEGER c) := TRANSFORM
	SELF.Seq := (STRING)c;
	SELF.AccountNumber := le.acctno;
	SELF.FirstName := le.fname;
	SELF.LastName := le.lname;
	SELF.Zip := le.zipcode;
	SELF.SSN := le.ssn;
	SELF.HomePhone := le.phone10;
END;

inputLayout getInstantIDInputs(InstantIDTestSeeds le, INTEGER c) := TRANSFORM
	SELF.Seq := (STRING)c;
	SELF.AccountNumber := le.acctno;
	SELF.FirstName := le.fname;
	SELF.LastName := le.lname;
	SELF.Zip := le.zipcode;
	SELF.SSN := le.ssn;
	SELF.HomePhone := le.phone10;
END;

inputFlex := PROJECT(FlexIDTestSeeds (dataset_name = datasetName), getFlexInputs(LEFT, COUNTER));
inputIID := PROJECT(InstantIDTestSeeds (dataset_name = datasetName), getInstantIDInputs(LEFT, COUNTER));

// Get all possible combinations of test seeds
inputTemp := DEDUP(SORT(inputFlex + inputIID, RECORD), AccountNumber, FirstName, LastName, Zip, SSN, HomePhone);

input := IF(keepRecords > 0, CHOOSEN(inputTemp, keepRecords), inputTemp);

OUTPUT(CHOOSEN(input, eyeball), NAMED('Sample_Inputs'));

iesp.flexid.t_FlexIDRequest intoSoap(input le) := TRANSFORM

								SELF.user.queryid := le.AccountNumber;
								SELF.user.AccountNumber := le.AccountNumber;
								SELF.user.GLBPurpose := (STRING)RiskWise.permittedUse.fraudGLBA; 
								SELF.user.DLPurpose := (STRING)RiskWise.permittedUse.fraudDPPA; 
								SELF.user.DataRestrictionMask := '000000000000';
								SELF.user.TestDataEnabled := TRUE;
								SELF.user.TestDataTableName := datasetName;
							 							 
								SELF.options.WatchLists := DATASET([], iesp.share.t_StringArrayItem); 
								SELF.options.UseDOBFilter := FALSE; 
								SELF.options.DOBRadius := 0; 
								SELF.options.IncludeMSOverride := FALSE; 
								SELF.options.DisallowTargusEID3220 := TRUE; 
								SELF.options.PoBoxCompliance := FALSE; 
								SELF.options.RequireExactMatch.LastName := FALSE;
								SELF.options.RequireExactMatch.FirstName := FALSE; 
								SELF.options.RequireExactMatch.FirstNameAllowNickname := FALSE; 
								SELF.options.RequireExactMatch.HomePhone := FALSE; 
								SELF.options.RequireExactmatch.SSN := FALSE; 
								SELF.options.IncludeAllRiskIndicators := TRUE; 
								SELF.options.IncludeVerifiedElementSummary := TRUE; 
								SELF.options.IncludeDLVerification := TRUE;
								SELF.options.DOBMatch.MatchType := 'FuzzyCCYYMMDD';
								SELF.options.DOBMatch.MatchYearRadius := 0; 
								
								SELF.searchby.Seq := le.Seq;
								SELF.searchby.Name.Full := ''; 
								SELF.searchby.Name.First := le.FirstName; 
								SELF.searchby.Name.Middle := ''; 
								SELF.searchby.Name.Last := le.LastName; 
								SELF.searchby.Name.Suffix := '';
								SELF.searchby.Name.Prefix := ''; 
								SELF.searchby.Address.StreetNumber := ''; 
								SELF.searchby.Address.StreetPreDirection := ''; 
								SELF.searchby.Address.StreetName := ''; 
								SELF.searchby.Address.StreetSuffix := ''; 
								SELF.searchby.Address.StreetPostDirection := ''; 
								SELF.searchby.Address.UnitDesignation := ''; 
								SELF.searchby.Address.UnitNumber := ''; 
								SELF.searchby.Address.StreetAddress1 := ''; 
								SELF.searchby.Address.StreetAddress2 := ''; 
								SELF.searchby.Address.City := ''; 
								SELF.searchby.Address.State := ''; 
								SELF.searchby.Address.Zip5 := le.Zip; 
								SELF.searchby.Address.Zip4 := ''; 
								SELF.searchby.Address.County := ''; 
								SELF.searchby.Address.PostalCode := ''; 
								SELF.searchby.Address.StateCityZip := ''; 
								SELF.searchby.DOB.Year := 0; 
								SELF.searchby.DOB.Month := 0;
								SELF.searchby.DOB.Day := 0; 
								SELF.searchby.Age := 0; 
								SELF.searchby.SSN := le.SSN; 
								SELF.searchby.SSNLast4 := ''; 
								SELF.searchby.DriverLicenseNumber := ''; 
								SELF.searchby.DriverLicenseState := ''; 
								SELF.searchby.IPAddress := ''; 
								SELF.searchby.HomePhone := le.HomePhone; 
								SELF.searchby.WorkPhone := ''; 
								SELF.searchby.Passport.MachineReadableLine1 := '';
								SELF.searchby.Passport.MachineReadableLine2 := '';
								SELF.searchby.Gender := '';
								self := [];
END;

distributedInput := DISTRIBUTE(input, RANDOM());

errorRec := RECORD  
	STRING  Source   := XMLTEXT('faultactor'); // ECL or ESP
	INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
	STRING  Location := '';
	STRING  Message  := XMLTEXT('faultstring');
END;

iesp.flexid.t_FlexIDResponseEx myFail(input L) := TRANSFORM                 
	soapmsg := XMLDECODE(FAILMESSAGE('soapresponse'));
	ds := DATASET([soapmsg], {STRING line});
	parsedSoapResponse := PARSE(ds, line, errorRec, XML('soap:Envelope/soap:Body/soap:Fault'));
                                
	// if there is additional exception information in the soap packet...put it into the exceptions block
	SELF.response._Header.Exceptions := if( REGEXFIND('^<', soapmsg), PROJECT(parsedSoapResponse,iesp.share.t_WsException), DATASET([],iesp.share.t_WsException));;

	SELF.response._Header.Status  := FAILCODE; // these will just contain the high level HTTP error mesg info
	SELF.response._Header.Message := FAILMESSAGE; 

	SELF := L;
	SELF := [];
END;

soapResult := SOAPCALL(
												distributedInput, 
												espIP, 
												'FlexID', 
												iesp.flexid.t_FlexIDRequest, 
												intoSoap(LEFT),
												DATASET(iesp.flexid.t_FlexIDResponseEx),
												PARALLEL(parallelSoapThreads), 
												XPATH('FlexIDResponseEx'),
												TRIM,
												onFail(myFail(LEFT))
											);

OUTPUT(CHOOSEN(soapResult, eyeball), NAMED('Sample_Soap_Result'));

t_FlexIDSearchBy := record
	string30 Seq {xpath('Seq')};//hidden[ecldev]
	iesp.share.t_Name Name {xpath('Name')};
	iesp.share.t_Address Address {xpath('Address')};
	iesp.share.t_Date DOB {xpath('DOB')};
	unsigned1 Age {xpath('Age')};
	string9 SSN {xpath('SSN')};
	string4 SSNLast4 {xpath('SSNLast4')};
	string DriverLicenseNumber {xpath('DriverLicenseNumber')};
	string2 DriverLicenseState {xpath('DriverLicenseState')};
	string IPAddress {xpath('IPAddress')};
	string10 HomePhone {xpath('HomePhone')};
	string10 WorkPhone {xpath('WorkPhone')};
	iesp.instantid.t_Passport Passport {xpath('Passport')};
	string6 Gender {xpath('Gender')};
end;
		
t_FlexIDModels := record
	string12 FraudPointModel {xpath('FraudPointModel')};
	dataset(iesp.instantid.t_ModelRequest) ModelRequests {xpath('ModelRequests/ModelRequest'), MAXCOUNT(5)};
end;
		
t_RequireExactMatchFlexID := record
	boolean LastName {xpath('LastName')};
	boolean FirstName {xpath('FirstName')};
	boolean FirstNameAllowNickname {xpath('FirstNameAllowNickname')};
	boolean Address {xpath('Address')};
	boolean HomePhone {xpath('HomePhone')};
	boolean SSN {xpath('SSN')};
	boolean DOB {xpath('DOB')};
	boolean DriverLicense {xpath('DriverLicense')};
end;
		
t_FlexIDOption := record (iesp.share.t_BaseOption)
	dataset(iesp.share.t_StringArrayItem) WatchLists {xpath('WatchLists/WatchList'), MAXCOUNT(iesp.Constants.MaxCountWatchLists)};
	boolean UseDOBFilter {xpath('UseDOBFilter')};
	integer2 DOBRadius {xpath('DOBRadius')};
	boolean IncludeMSOverride {xpath('IncludeMSOverride')};
	boolean DisallowTargusEID3220 {xpath('DisallowTargusEID3220')};//hidden[internal]
	boolean PoBoxCompliance {xpath('PoBoxCompliance')};
	t_RequireExactMatchFlexID RequireExactMatch {xpath('RequireExactMatch')};
	boolean IncludeAllRiskIndicators {xpath('IncludeAllRiskIndicators')};
	boolean IncludeVerifiedElementSummary {xpath('IncludeVerifiedElementSummary')};
	boolean IncludeDLVerification {xpath('IncludeDLVerification')};
	iesp.instantid.t_DOBMatchOptions DOBMatch {xpath('DOBMatch')};
end;
		
t_ValidElementSummary := record
	boolean SSNValid {xpath('SSNValid')};
	boolean SSNDeceased {xpath('SSNDeceased')};
	string1 DLValid {xpath('DLValid')};
	boolean PassportValid {xpath('PassportValid')};
end;
		
t_VerifiedElementSummary := record
	string1 FirstName {xpath('FirstName')};
	string1 LastName {xpath('LastName')};
	string1 StreetAddress {xpath('StreetAddress')};
	string1 City {xpath('City')};
	string1 State {xpath('State')};
	string1 Zip {xpath('Zip')};
	string1 HomePhone {xpath('HomePhone')};
	boolean DOB {xpath('DOB')};
	string1 DOBMatchLevel {xpath('DOBMatchLevel')};
	string1 SSN {xpath('SSN')};
	string1 DL {xpath('DL')};
end;
		
t_FlexIDResult := record
	t_FlexIDSearchBy InputEcho {xpath('InputEcho')};
	iesp.instantid.t_NameAddressPhone NameAddressPhone {xpath('NameAddressPhone')};
	t_VerifiedElementSummary VerifiedElementSummary {xpath('VerifiedElementSummary')};
	t_ValidElementSummary ValidElementSummary {xpath('ValidElementSummary')};
	unsigned1 NameAddressSSNSummary {xpath('NameAddressSSNSummary')};
	unsigned1 ComprehensiveVerificationIndex {xpath('ComprehensiveVerificationIndex')};
end;

t_FlexIDResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	t_FlexIDResult Result {xpath('Result')};
end;
		
t_FlexIDResponseEx := record
	t_FlexIDResponse response {xpath('response')};
end;

cleanResponse := RECORD
	t_FlexIDResponseEx;
	STRING4 RiskCode1 := '';
	STRING150 RiskCodeDescription1 := '';
	STRING4 RiskCode2 := '';
	STRING150 RiskCodeDescription2 := '';
	STRING4 RiskCode3 := '';
	STRING150 RiskCodeDescription3 := '';
	STRING4 RiskCode4 := '';
	STRING150 RiskCodeDescription4 := '';
	STRING4 RiskCode5 := '';
	STRING150 RiskCodeDescription5 := '';
	STRING4 RiskCode6 := '';
	STRING150 RiskCodeDescription6 := '';
END;

cleanResponse cleanSoap(iesp.flexid.t_FlexIDResponseEx le) := TRANSFORM
	SELF.RiskCode1 := le.Response.Result.CVIHighRiskIndicators[1].RiskCode;
	SELF.RiskCodeDescription1 := le.Response.Result.CVIHighRiskIndicators[1].Description;
	SELF.RiskCode2 := le.Response.Result.CVIHighRiskIndicators[2].RiskCode;
	SELF.RiskCodeDescription2 := le.Response.Result.CVIHighRiskIndicators[2].Description;
	SELF.RiskCode3 := le.Response.Result.CVIHighRiskIndicators[3].RiskCode;
	SELF.RiskCodeDescription3 := le.Response.Result.CVIHighRiskIndicators[3].Description;
	SELF.RiskCode4 := le.Response.Result.CVIHighRiskIndicators[4].RiskCode;
	SELF.RiskCodeDescription4 := le.Response.Result.CVIHighRiskIndicators[4].Description;
	SELF.RiskCode5 := le.Response.Result.CVIHighRiskIndicators[5].RiskCode;
	SELF.RiskCodeDescription5 := le.Response.Result.CVIHighRiskIndicators[5].Description;
	SELF.RiskCode6 := le.Response.Result.CVIHighRiskIndicators[6].RiskCode;
	SELF.RiskCodeDescription6 := le.Response.Result.CVIHighRiskIndicators[6].Description;
	
	SELF := le;
END;

soapClean := PROJECT(soapResult, cleanSoap(LEFT));

OUTPUT(CHOOSEN(soapClean, eyeball), NAMED('Sample_Clean_Soap_Result'));
OUTPUT(soapClean,, outputFile, CSV(HEADING(single), QUOTE('"')), EXPIRE(expireDays), OVERWRITE);