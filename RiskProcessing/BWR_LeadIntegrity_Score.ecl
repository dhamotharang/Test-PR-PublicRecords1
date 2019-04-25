#workunit('name','Lead Integrity Score');
#option ('hthorMemoryLimit', 1000);

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
recordsToRun := 0;
eyeball := 50;

threads := 30;

roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

model :=
	// 'anmk909_0'
	'msn1106_0'   // Flagship Score
;

inputFile := '~jpyon::in::tmobile_1413_date_phone_in';
outputFile := '~tfuerstenberg::out::Lead_Integ_Score_out';

// new internal fields for debugging, set to false so they are excluded from the layout by default
include_internal_extras := false;

// Set to TRUE to run the ADL Based Boca Shell, FALSE to skip it
runADL := TRUE;

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
prii_layout := RECORD
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING HomePhone;
	STRING SSN;
	STRING DateOfBirth;
	STRING WorkPhone;
	STRING income;  
	STRING DLNumber;
	STRING DLState;
	STRING BALANCE; 
	STRING CHARGEOFFD;  
	STRING FormerName;
	STRING EMAIL;  
	STRING COMPANY;
	INTEGER historydateyyyymm;
	unsigned6 did;
END;

f := IF(recordsToRun <= 0, DATASET(inputFile, prii_layout, CSV(QUOTE('"'))), CHOOSEN(DATASET(inputFile, prii_layout, CSV(QUOTE('"'))), recordsToRun));
OUTPUT(CHOOSEN(f, eyeball), NAMED('sample_raw_input'));

// this probably isn't required, as the service should pick the appropriate boca shell version, but SOME version of attributes needs to be requested in order for the LI service to function
version := case( model,
	'anmk909_0' => 1,
	'msn1106_0' => 4,
	1
);

// Run the ADL based bocashell with that history date to append the SSN if it's missing
layout_soap_boca := RECORD
	STRING old_account_number;
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	STRING DataRestrictionMask;	
	INTEGER Version;
	INTEGER HistoryDateYYYYMM;
	BOOLEAN ADL_Based_Shell;
	unsigned6 did;
END;

layout_soap_boca transform_input_boca(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.accountnumber;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.adl_based_shell := true;
	SELF.DataRestrictionMask := '0000000000000000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	// SELF.HistoryDateYYYYMM := le.historyDateYYYYMM;
	SELF.HistoryDateYYYYMM := (Integer) le.historydateyyyymm[1..6];
	SELF.Version := version;
	SELF := le;
	SELF := [];
END;

p_f := PROJECT(f, transform_input_boca(LEFT, COUNTER));
OUTPUT(CHOOSEN(p_f, eyeball), NAMED('sample_soap_shell_input'));
OUTPUT(COUNT(p_f(ssn<>'')), NAMED('records_without_ssn_originally'));

shell_input := DISTRIBUTE(p_f(ssn=''), RANDOM());

xlayout := RECORD
	risk_indicators.Layout_Boca_Shell;
	STRING errorcode;
END;

xlayout myFail(shell_input le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.seq := (UNSIGNED)le.AccountNumber;
	SELF := le;
	SELF := [];
END;

adlappendshell := SOAPCALL(shell_input, roxieIP,
				'Risk_Indicators.Boca_Shell', {shell_input}, 
				DATASET(xlayout),
				RETRY(5), TIMEOUT(500),
				//RETRY(5), TIMEOUT(500), LITERAL,
				PARALLEL(threads), onFail(myFail(LEFT)));

appended_ssns := JOIN(shell_input, adlappendshell, (UNSIGNED)LEFT.accountnumber=RIGHT.seq,
					TRANSFORM(layout_soap_boca, SELF.ssn := RIGHT.shell_input.ssn, SELF := LEFT));
			
ita_input_temp := IF(runADL and version < 4, appended_ssns + p_f(ssn<>''), p_f);   // add back the records that already had the SSN on the customer file if TRUE, skip if FALSE

layout_soap := RECORD
	DATASET(iesp.leadintegrity.t_LeadIntegrityRequest) LeadIntegrityRequest;
	unsigned6 did;
	UNSIGNED3 HistoryDateYYYYMM;
	string FullAccountNumber;
END;



layout_soap transform_input_request(ita_input_temp le) := TRANSFORM
	u := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User, SELF.AccountNumber := le.old_account_number; SELF.DLPurpose := '0'; SELF.GLBPurpose := '5'; SELF.DataRestrictionMask := '000000000000'; SELF := []));
	o := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityOptions,
		SELF.AttributesVersionRequest := (STRING)VERSION;
		self.IncludeModels.Integrity := model,
		SELF := [])
	);
	
	n := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Name, SELF.First := le.FirstName; SELF.Middle := le.MiddleName; SELF.Last := le.LastName; SELF := []));
	a := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address, SELF.StreetAddress1 := le.StreetAddress; SELF.City := le.City; SELF.State := le.State; SELF.Zip5 := le.Zip; SELF := []));
	d := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Date, SELF.Year := (INTEGER)le.DateOfBirth[1..4]; SELF.Month := (INTEGER)le.DateOfBirth[5..6]; SELF.Day := (INTEGER)le.DateOfBirth[7..8]; SELF := []));
	s := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegritySearchBy, SELF.Seq := le.AccountNumber; 
																																											SELF.Name := n[1]; 
																																											SELF.Address := a[1]; 
																																											SELF.DOB := d[1]; 
																																											SELF.SSN := le.SSN; 
																																											SELF.HomePhone := le.HomePhone; 
																																											SELF.WorkPhone := le.WorkPhone;
																																											SELF.DriverLicenseNumber := le.DLNumber;
																																											SELF.DriverLicenseState := le.DLState;
																																											SELF := []));
	r := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.leadintegrity.t_LeadIntegrityRequest, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := []));
	SELF.LeadIntegrityRequest := r[1];
	self.did := le.did;
	SELF.HistoryDateYYYYMM := le.historyDateYYYYMM;
	SELF.FullAccountNumber := le.old_account_number;
	SELF := [];
END;

ita_input := DISTRIBUTE(PROJECT(ita_input_temp, transform_input_request(LEFT)), RANDOM());

OUTPUT(CHOOSEN(ita_input, eyeball), NAMED('ita_input'));  
OUTPUT(COUNT(ita_input (LeadIntegrityRequest[1].SearchBy.SSN <> '')), NAMED('records_without_ssn_after_appending_it')); // double check that this one has ssns


// Now run the ITA attributes
itaoutput := RECORD
	unsigned6 did;
	iesp.leadintegrity.t_LeadIntegrityResponse;
	STRING errorcode;
END;

itaoutput myFail2(ita_input le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

ita_attributes := SOAPCALL(ita_input, roxieIP,
				'Models.LeadIntegrity_Service', {ita_input}, 
				DATASET(itaoutput),
        RETRY(5), TIMEOUT(500),
       // XPATH('Models.LeadIntegrity_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail2(LEFT)));
				
OUTPUT(CHOOSEN(ita_attributes(errorcode=''), eyeball), NAMED('ITA_results'));
OUTPUT(CHOOSEN(ita_attributes(errorcode<>''), eyeball), NAMED('ITA_errors'));


layout_slimmed := RECORD
	STRING20 seq;
	STRING30 AccountNumber;
	string name;
	string3 score;
	string2 rc1;
	string2 rc2;
	string2 rc3;
	string2 rc4;
//	string2 rc5;
//	string2 rc6;
	#if(include_internal_extras)
		RiskProcessing.layout_internal_extras;
	#end
END;

final := JOIN(ita_input, ita_attributes, LEFT.LeadIntegrityRequest[1].SearchBy.Seq=RIGHT.Result.InputEcho.Seq,
	TRANSFORM(layout_slimmed,
		SELF.AccountNumber := LEFT.FullAccountNumber;
		SELF.seq := LEFT.LeadIntegrityRequest[1].SearchBy.Seq;
		self.name := right.Result.Models[1].Name;
		self.score := (string3)right.Result.Models[1].Scores[1].Value;
		self.rc1 := right.Result.Models[1].Scores[1].WarningCodeIndicators[1].WarningCode;
		self.rc2 := right.Result.Models[1].Scores[1].WarningCodeIndicators[2].WarningCode;
		self.rc3 := right.Result.Models[1].Scores[1].WarningCodeIndicators[3].WarningCode;
		self.rc4 := right.Result.Models[1].Scores[1].WarningCodeIndicators[4].WarningCode;
		//self.rc5 := right.Result.Models[1].Scores[1].WarningCodeIndicators[5].WarningCode;
		//self.rc6 := right.Result.Models[1].Scores[1].WarningCodeIndicators[6].WarningCode;
		#if(include_internal_extras)
			self.DID := right.did; 
			self.historydate := (string)left.HistoryDateYYYYMM;
			self.FNamePop := left.leadintegrityrequest[1].searchby.name.first <> '';
			self.LNamePop := left.leadintegrityrequest[1].searchby.name.last <> '';
			self.AddrPop := left.leadintegrityrequest[1].searchby.address.streetaddress1 <> '';
			self.SSNLength := (string)(length(trim(left.leadintegrityrequest[1].searchby.ssn))) ;
			self.DOBPop := left.leadintegrityrequest[1].searchby.dob.year <> 0;
			self.EmailPop := false; // not used in lead integrity
			self.IPAddrPop := false; // not used in lead integrity
			self.HPhnPop := left.leadintegrityrequest[1].searchby.homephone <> '';
		#end;
	), keep(1)
);


OUTPUT(CHOOSEN(final, eyeball), NAMED('Sample_Final_Results'));
output(final,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);