#workunit('name','FCRA-RiskView Process-Retail');
#option ('hthorMemoryLimit', 1000)


import models, Risk_Indicators;

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

f := DATASET('~jpyon::in::think_1184_f_s_in',prii_layout,csv(quote('"')));
//f := choosen(dataset('~jpyon::in::think_1184_f_s_in',prii_layout, csv(quote('"'))),5);

output(f, named('original_input'));
output(count(f));

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
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM := 999999;
	boolean Attributes :=False;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
end;

// params := dataset([], models.Layout_Parameters);

paramsA := dataset([{'Custom', 'rva711_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
paramsB := dataset([{'Custom', 'rvb711_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
paramsR := dataset([{'Custom', 'rvr711_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
paramsT := dataset([{'Custom', 'rvt711_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below
paramsM := dataset([{'Custom', 'rvg812_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below   //add

// current possible models available as of 7/25/2008
	// version 2 riskview
		// rvb711_0 - bankcard
		// rva711_0 - auto
		// rvt711_0 - telecom
		// rvr711_0 - retail
	// Custom retail models 
		// rvr803_1	- retail		 
	// Custom auto models 
		// aid605_1	- auto
		// aid607_0 - auto
		// rva707_0 - subprime auto





l := RECORD
	STRING old_account_number;
	layout_soap;
END;


fcraroxieIP := 'http://fcrathorvip.hpcc.risk.regn.net:9876'; 


l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.Attributes := False;
	
// use it for FCRA RiskView	
	// if you only want to run one, pick the one you want
	// self.scores := dataset([{'Models.RVMoney_Service', fcraroxieIP, paramsA}], models.Layout_Score_Chooser); 
	// self.scores := dataset([{'Models.RVBankCard_Service', fcraroxieIP,paramsB}], models.Layout_Score_Chooser); 
	// self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsR}], models.Layout_Score_Chooser);
	// self.scores := dataset([{'Models.RVTelecom_Service', fcraroxieIP,paramsT}], models.Layout_Score_Chooser);

	// use this for all 5 scores
	self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, paramsA},{'Models.RVBankCard_Service', fcraroxieIP,paramsB},
							{'Models.RVRetail_Service', fcraroxieIP,paramsR},{'Models.RVTelecom_Service', fcraroxieIP,paramsT},
							{'Models.RVMoney_Service', fcraroxieIP,paramsM}  ], models.Layout_Score_Chooser); 
 
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;
p_f := project(f, t_f(left, counter));
output(p_f, named('RV_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

xlayout := RECORD
	STRING30 AccountNumber;
	DATASET(Models.Layout_Model) models;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, fcraroxieIP,
				'Models.RiskView_Testing_Service', {dist_dataset}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(25), onFail(myFail(LEFT)));
				
output(resu, named('resu'));
			
ox := RECORD
	STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_score_bank;
	string3 RV_score_retail;
	string3 RV_score_telecom;
	string3 RV_score_money;   //add	
	string3 RV_reason;
	string3 RV_reason2;
	string3 RV_reason3;
	string3 RV_reason4;
//	STRING errorcode;
END;

ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	// score fields 
	self.rv_score_auto := l.models[1].scores[1].i;
	self.rv_score_bank := l.models[2].scores[1].i;
	self.rv_score_retail := l.models[3].scores[1].i;
	self.rv_score_telecom := l.models[4].scores[1].i;
	self.rv_score_money := l.models[5].scores[1].i;          //add 
	self.rv_reason := l.models[1].scores[1].reason_codes[1].reason_code;
	self.rv_reason2 := l.models[1].scores[1].reason_codes[2].reason_code;
	self.rv_reason3 := l.models[1].scores[1].reason_codes[3].reason_code;
	self.rv_reason4 := l.models[1].scores[1].reason_codes[4].reason_code;
	self := L;

end;

j_f := JOIN(resu,p_f,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f, named('j_f'));

output(j_f,,'~jpyon::out::think_1184_rv_rvg812_out',CSV(heading(single), quote('"')), overwrite);
//output(j_f(errorcode<>''),,'~tfuerstenberg::out::macys_rvretail_error',CSV(QUOTE('"')), overwrite);