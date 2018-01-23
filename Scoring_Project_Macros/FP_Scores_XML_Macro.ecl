EXPORT FP_Scores_XML_Macro (roxie_ip,Gateway, Thread, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun):= functionmacro

import ut, Risk_Indicators, riskwise, models, RiskProcessing;

include_internal_extras := true;

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry;
integer timeout := timeout;
integer threads := Thread;

String roxieIP := roxie_ip ; 
gateways := Gateway;
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;


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




f := IF(no_of_records <= 0, DATASET(  infile_name, layout_input, thor),
                            CHOOSEN(DATASET(infile_name, layout_input, thor), no_of_records));
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
        RETRY(retry), TIMEOUT(timeout), LITERAL,
        XPATH('Models.FraudAdvisor_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
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
op_final :=  output(normed,, outfile_name, thor,compressed, overwrite);

return op_final;

endmacro;