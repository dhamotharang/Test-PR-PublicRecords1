/*
 * The following script calls the Risk_Indicators.ProviderScoring_Service
 */
#workunit('name','Provider_Scoring_XML');

IMPORT RiskWise, Risk_Indicators, iesp, ut;

/* ***********************************************
 * Options:                                      *
 *************************************************
 *  -Eyeball: Sample number of records to show   *
 *  -RecordsToRun: 0 for All, or number of recs  *
 *  -Threads: 1 through 30 parrallel threads     *
 *  -RoxieIP: Location of the Address_Shell      *
 *************************************************/
eyeball := 25;
recordsToRun := 10;
threads := 30;

// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;
roxieIP := RiskWise.shortcuts.Dev192;
 
/* ***********************************************
 * Input Options:                                *
 *************************************************
 *  -Model: HCP1206_0                            *
 *  -AllRiskIndicators: TRUE = 8 returned,       *
 *                      FALSE = 4 returned       *
 *************************************************/
Model := 'HCP1206_0';
AllRiskIndicators := TRUE;

inFile := ut.foreign_dataland + 'ashirey::in::inputwithflag';
outFile := '~bpahl::out::ProviderScoring_Model_' + Model + '_' + thorlib.wuid() + '.csv';
											
/* ***********************************************
 * Read Input File and Convert to Request Layout:*
 *************************************************/
 inputFileLayout := RECORD
	STRING Provider_Medicaid_ID := '';
	STRING Provider_Name := '';
	STRING SSN := '';
	STRING DOB := '';
	STRING Tax_ID := '';
	STRING Business_Name := '';
	STRING Address_1 := '';
	STRING Address_2 := '';
	STRING City := '';
	STRING State := '';
	STRING Zip_Code := '';
	STRING Phone := '';
	STRING License_Number := '';
	STRING Claim_Amount := '';
	STRING good_record := '';
END;
inputFileRawChoose := CHOOSEN(DATASET(inFile, inputFileLayout, CSV(HEADING(single), QUOTE('"'))), recordsToRun);
inputFileRawAll := DATASET(inFile, inputFileLayout, CSV(HEADING(single), QUOTE('"')));
rawInput := IF(recordsToRun <= 0, inputFileRawAll, inputFileRawChoose);

rawInputSequenced := PROJECT(rawInput, TRANSFORM({inputFileLayout, UNSIGNED6 seq}, SELF.seq := COUNTER; SELF := LEFT));

serviceInput := RECORD
	DATASET(iesp.providerintegrityscore.t_ProviderIntegrityScoreRequest) ProviderIntegrityRequest;
  STRING50 DataRestrictionMask := '';
  UNSIGNED3 HistoryDateYYYYMM := 0;
END;

serviceInput intoRequest(rawInputSequenced le) := TRANSFORM
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := le.Provider_Medicaid_ID; SELF.DLPurpose := '0'; SELF.GLBPurpose := '1'; SELF.DataRestrictionMask := '000000000000'; SELF := []));
	o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.providerintegrityscore.t_ProviderIntegrityScoreOption, SELF.IncludeModels.ProviderIntegrityScore := Model; SELF.IncludeModels.IncludeAllRiskIndicators := AllRiskIndicators; SELF := []));
	
	n := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, SELF.Full := le.Provider_Name; SELF := []));
	a := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, SELF.StreetAddress1 := le.Address_1; SELF.StreetAddress2 := le.Address_2; SELF.City := le.City; SELF.State := le.State; SELF.Zip5 := le.Zip_Code; SELF := []));
	d := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.DOB[1..4]; SELF.Month := (INTEGER)le.DOB[5..6]; SELF.Day := (INTEGER)le.DOB[7..8]; SELF := []));
	s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.providerintegrityscore.t_ProviderIntegrityScoreSearchBy, SELF.Seq := (STRING)le.Seq; 
																																											SELF.Name := n[1]; 
																																											SELF.Address := a[1]; 
																																											SELF.DOB := d[1]; 
																																											SELF.SSN := le.SSN; 
																																											SELF.Phone10 := le.Phone; 
																																											SELF.LicenseNumber := le.License_Number;
																																											SELF.CompanyName := le.Business_Name;
																																											SELF := []));
	r := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.providerintegrityscore.t_ProviderIntegrityScoreRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := []));
	SELF.ProviderIntegrityRequest := r[1];
	SELF := [];
END;

requestTemp := PROJECT(rawInputSequenced, intoRequest(LEFT));

request := IF(recordsToRun > 0, CHOOSEN(requestTemp, recordsToRun), requestTemp);

OUTPUT(COUNT(request), NAMED('Num_Records_On_Input'));

OUTPUT(CHOOSEN(request, eyeball), NAMED('Sample_Request'));

xlayout := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.providerintegrityscore.t_ProviderIntegrityScoreResponse;
	STRING200 errorcode;
END;

xlayout myFail(request le) := TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
	SELF := le;
	
	SELF := [];
END;

soapout := SOAPCALL(request, 
										RoxieIP, 
										'Risk_Indicators.ProviderScoring_Service', 
										{request}, 
										DATASET(xlayout), 
										PARALLEL(threads),
										onFail(myFail(LEFT)));
OUTPUT(COUNT(soapout), NAMED('Num_Records_From_SOAP'));
OUTPUT(CHOOSEN(soapout, eyeball), NAMED('Sample_Soap_Results'));
OUTPUT(soapout,, outFile, CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);