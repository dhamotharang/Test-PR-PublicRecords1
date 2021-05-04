#workunit('name','Fraudpoint-score-rcodes');
#option ('hthorMemoryLimit', 1000)
#option ('linkCountedRows', false) 

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

threads := 25;

roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

inputFile := '~nmontpetit::in::etrade_boca_input';
outputFile := '~tfuerstenberg::out::Fraudpoint_test';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
prii_layout := RECORD
     string ACCOUNT;
     string FirstName;
     string MiddleName;
     string LastName;
     string StreetAddress;
     string CITY;
     string STATE;
     string ZIP;
     string HomePhone;
     string SSN;
     string DateOfBirth;
     string WorkPhone;
     string INCOME;
     string DLNumber;
     string DLState;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERName;
     string EMAIL;
     string EmployerName;
     integer HistoryDateYYYYMM;
end;

f := IF(recordsToRun <= 0, DATASET(inputFile, prii_layout, csv(quote('"'))),
                            CHOOSEN(DATASET(inputFile, prii_layout, CSV(QUOTE('"'))), recordsToRun));

output(CHOOSEN(f, eyeball), named('sample_original_input'));


Layout_Attributes_In := RECORD
	string name;
END;

layout_soap := record
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
	string model;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	string DataRestrictionMask;		
	integer HistoryDateYYYYMM;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
		boolean ExcludeIbehavior;  // temporary field until end of July 2017
end;


params := dataset([], models.Layout_Parameters);

layout_old_acct := RECORD
	STRING old_account_number;
	layout_soap;
END;


layout_old_acct into_fdInput(f le, INTEGER c) := TRANSFORM
self.ExcludeIbehavior := true;  // set this back to false if they would like to include this data for their test

	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;

	self.HistoryDateYYYYMM:= le.historydateyyyymm;
	self.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	
	self.model := 'fp3710_0';	// set to blank if you don't want the new model
	//self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;
fdInput := project(f, into_fdInput(left, counter));
output(CHOOSEN(fdInput, eyeball), named('Sample_FD_Input'));


dist_dataset := DISTRIBUTE(PROJECT(fdInput,TRANSFORM(layout_soap,SELF := LEFT)), RANDOM());


Layout_FPScores := record
	Models.Layout_Model;
	string errorcode;
end;


Layout_FPScores myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;


resu := SOAPCALL(dist_dataset, roxieIP,
				'Models.FraudAdvisor_Service', {dist_dataset}, 
				DATASET(Layout_FPScores),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH('Models.FraudAdvisor_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
output(CHOOSEN(resu, eyeball), named('sample_result'));

			
fd_attributes_norm := RECORD
	string30 AccountNumber;
//	string description;
	
	string3 FP_score;
	string3 FP_reason;
	string3 FP_reason2;
	string3 FP_reason3;
	string3 FP_reason4;
	string3 FP_reason5;
	string3 FP_reason6;
	
//	string6 history_date;
//	string10 errorcode;
END;


fd_attributes_norm normit(resu L, fdInput R) := transform
	self.AccountNumber := r.old_account_number;
//	self.description := l.description;
	
	self.fp_score := l.scores[1].i;
	self.fp_reason := l.scores[1].reason_codes[1].reason_code;
	self.fp_reason2 := l.scores[1].reason_codes[2].reason_code;
	self.fp_reason3 := l.scores[1].reason_codes[3].reason_code;
	self.fp_reason4 := l.scores[1].reason_codes[4].reason_code;
	self.fp_reason5 := l.scores[1].reason_codes[5].reason_code;
	self.fp_reason6 := l.scores[1].reason_codes[6].reason_code;
	
//	self.history_date := (string)r.HistoryDateYYYYMM;
	
	self := l;
	self := [];
end;
normed := JOIN(resu, fdInput,LEFT.accountnumber=RIGHT.accountnumber, normit(LEFT,RIGHT));

output(CHOOSEN(normed, eyeball), NAMED('Sample_Normalized'));
output(normed,, outputFile, CSV(heading(single), quote('"')), overwrite);