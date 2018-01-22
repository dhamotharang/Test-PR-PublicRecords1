



#workunit('name','Fraudpoint-score-rcodes');
#option ('hthorMemoryLimit', 1000);
#option ('linkCountedRows', false) ;

import ut, Risk_Indicators, riskwise, models, RiskProcessing;

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

threads := 1;

// roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
roxieIP := RiskWise.shortcuts.Dev196 ;//dev196

infile_name_25000     := '~nmontpetit::in::ge_cap_100302_pii'; 
infile_name_300000     := '~nmontpetit::out::coaf_121212_attributes_stability::sample_input_4_201212'; 

inputFile := ut.foreign_prod + infile_name_25000;

outputFile := '~nkoubsky::out::nonFcra_FPScores_v2_dev196_'  + thorlib.wuid();

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
layout_input := RECORD
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

f := IF(recordsToRun <= 0, DATASET( inputFile, layout_input, csv(quote('"'))),
                            CHOOSEN(DATASET(inputFile, layout_input, CSV(QUOTE('"'))), ALL));

// output(CHOOSEN(f, eyeball), named('fps_original_input'));


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
	boolean IncludeRiskIndices;  // turns on the 6 fp indices that go with the model
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	string DataRestrictionMask;		
	integer HistoryDateYYYYMM;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
end;


params := dataset([], models.Layout_Parameters);

layout_old_acct := RECORD
	STRING old_account_number;
	layout_soap;
END;


layout_old_acct into_fdInput(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;

	self.HistoryDateYYYYMM:= le.historydateyyyymm;
	self.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	
	// self.model := 'fp3710_0';	// set to blank if you don't want the new model
	
	self.model := 'fp1109_0';  // 
		//self.model := 'fp1109_9';  // fp1109_9 is the same model as fp1109_0, but includes criminal risk indicators
	self.IncludeRiskIndices := true;
	
	//self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;
fdInput := project(f, into_fdInput(left, counter));
// output(CHOOSEN(fdInput, eyeball), named('fps_Sample_FD_Input'));


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
        RETRY(3), TIMEOUT(120), LITERAL,
        XPATH('Models.FraudAdvisor_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(1), onFail(myFail(LEFT)));
				
// output(CHOOSEN(resu, eyeball), named('fps_sample_result'));

			
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

// output(CHOOSEN(normed, eyeball), NAMED('fps_Sample_Normalized'));
  
// op_despray := FileServices.DeSpray('~sghatti::out::nonFcra_FPScores_v2_' + ut.GetDate,'10.48.72.175', 'G:\\Scoring Project\\landing\\'+ 'nonFcra_FPScores_v2_' + ut.GetDate  + '_' + ut.getTime() + '.csv',,,,TRUE);

// sequential(op_final, op_despray);



EXPORT FPScores_Dev196 := output(normed,, outputFile, CSV(heading(single), quote('"')));
