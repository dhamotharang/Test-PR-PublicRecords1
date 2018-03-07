#workunit('name','FCRA-RiskView Payment Score 4.0');
#option ('hthorMemoryLimit', 1000);


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

f := DATASET('~tfuerstenberg::in::worldomni_2902_inwof_recov201009_in',prii_layout,csv(quote('"')));
// f := choosen(DATASET('~tfuerstenberg::in::worldomni_2902_inwof_recov200912_in',prii_layout,csv(quote('"'))),20);

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
paramsP := dataset([{'Custom', 'rvc1112_0'}], models.Layout_Parameters);	// payment score


l := RECORD
	STRING old_account_number;
	layout_soap;
END;

fcraroxieIP := 'http://fcrabatch.sc.seisint.com:9876'; 

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.Attributes := False;
	SELF.HistoryDateYYYYMM := (Integer) le.historydateyyyymm[1..6];	

	self.scores := dataset([{'', fcraroxieIP,paramsP}], models.Layout_Score_Chooser);

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
				PARALLEL(30), onFail(myFail(LEFT)));
				
output(resu, named('resu'));
			
ox := RECORD
	STRING30 acctNo;
	string3 RV_score_payment;
	string3 RV_payment_reason;
	string3 RV_payment_reason2;
	string3 RV_payment_reason3;
	string3 RV_payment_reason4;
	string3 RV_payment_reason5;	

END;

ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	// score fields 
	
	pymtModel1 := l.models[1].scores(description='Payment');
	pymtModel2 := l.models[2].scores(description='Payment');
	pymtModel3 := l.models[3].scores(description='Payment');
	pymtModel4 := l.models[4].scores(description='Payment');
	pymtModel5 := l.models[5].scores(description='Payment');
	pymtModel6 := l.models[6].scores(description='Payment');

									
	self.rv_score_payment := map( pymtModel1[1].i <> '' => pymtModel1[1].i,
								pymtModel2[1].i <> '' => pymtModel2[1].i,
								pymtModel3[1].i <> '' => pymtModel3[1].i,
								pymtModel4[1].i <> '' => pymtModel4[1].i,
								pymtModel5[1].i <> '' => pymtModel5[1].i,
								pymtModel6[1].i <> '' => pymtModel6[1].i,
								'');
	self.rv_payment_reason := map(pymtModel1[1].i <> '' => pymtModel1[1].reason_codes[1].reason_code,
								pymtModel2[1].i <> '' => pymtModel2[1].reason_codes[1].reason_code,
								pymtModel3[1].i <> '' => pymtModel3[1].reason_codes[1].reason_code,
								pymtModel4[1].i <> '' => pymtModel4[1].reason_codes[1].reason_code,
								pymtModel5[1].i <> '' => pymtModel5[1].reason_codes[1].reason_code,
								pymtModel6[1].i <> '' => pymtModel6[1].reason_codes[1].reason_code,
								'');
	self.rv_payment_reason2 := map(pymtModel1[1].i <> '' => pymtModel1[1].reason_codes[2].reason_code,
								pymtModel2[1].i <> '' => pymtModel2[1].reason_codes[2].reason_code,
								pymtModel3[1].i <> '' => pymtModel3[1].reason_codes[2].reason_code,
								pymtModel4[1].i <> '' => pymtModel4[1].reason_codes[2].reason_code,
								pymtModel5[1].i <> '' => pymtModel5[1].reason_codes[2].reason_code,
								pymtModel6[1].i <> '' => pymtModel6[1].reason_codes[2].reason_code,
								'');
	self.rv_payment_reason3 := map(pymtModel1[1].i <> '' => pymtModel1[1].reason_codes[3].reason_code,
								pymtModel2[1].i <> '' => pymtModel2[1].reason_codes[3].reason_code,
								pymtModel3[1].i <> '' => pymtModel3[1].reason_codes[3].reason_code,
								pymtModel4[1].i <> '' => pymtModel4[1].reason_codes[3].reason_code,
								pymtModel5[1].i <> '' => pymtModel5[1].reason_codes[3].reason_code,
								pymtModel6[1].i <> '' => pymtModel6[1].reason_codes[3].reason_code,
								'');
	self.rv_payment_reason4 := map(pymtModel1[1].i <> '' => pymtModel1[1].reason_codes[4].reason_code,
								pymtModel2[1].i <> '' => pymtModel2[1].reason_codes[4].reason_code,
								pymtModel3[1].i <> '' => pymtModel3[1].reason_codes[4].reason_code,
								pymtModel4[1].i <> '' => pymtModel4[1].reason_codes[4].reason_code,
								pymtModel5[1].i <> '' => pymtModel5[1].reason_codes[4].reason_code,
								pymtModel6[1].i <> '' => pymtModel6[1].reason_codes[4].reason_code,
								'');							
	self.rv_payment_reason5 := map(pymtModel1[1].i <> '' => pymtModel1[1].reason_codes[5].reason_code,
								pymtModel2[1].i <> '' => pymtModel2[1].reason_codes[5].reason_code,
								pymtModel3[1].i <> '' => pymtModel3[1].reason_codes[5].reason_code,
								pymtModel4[1].i <> '' => pymtModel4[1].reason_codes[5].reason_code,
								pymtModel5[1].i <> '' => pymtModel5[1].reason_codes[5].reason_code,
								pymtModel6[1].i <> '' => pymtModel6[1].reason_codes[5].reason_code,
								'');							
								
	
	self := L;
self := [];
end;

j_f := JOIN(resu,p_f,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f, named('j_f'));

output(j_f,,'~tfuerstenberg::out::rvpayment_score',CSV(heading(single), quote('"')), overwrite);
//output(j_f(errorcode<>''),,'~jpyon::out::sprint_1522_rvmoney_error',CSV(QUOTE('"')), overwrite);
