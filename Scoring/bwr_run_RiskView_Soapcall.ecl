prii_layout := RECORD
string	ACCOUNT	;
string	DateTime	;
string	FirstName	;
string	LastName	;
string	StreetAddress	;
string	City	;
string	State	;
string	Zip	;
string	homePhone	;
string	SSN	;
string	DOB	;
end;

f := DATASET('~thor_data50::in::AffinityDirect-proj 232',prii_layout,csv(heading(1), quote('"')));

//f := enth(DATASET('~thor_data100::in::test884',prii_layout,csv(quote('"'))),3);
output(f, named('original_input'));

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
	boolean  IncludeAllAttributes :=False;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
end;

params := dataset([], models.Layout_Parameters);
student_params := dataset([{'isstudent','0'}], models.Layout_Parameters); // change the 1 to a 0 if the apptype is non-student

l := RECORD
	STRING old_account_number;
	layout_soap;
END;

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	self.SSN:=StringLib.StringFilterOut(le.Ssn,'-');
	self.DateOfBirth:=StringLib.StringFilterOut(le.dob,'-');
	self.HistoryDateYYYYMM :=(integer)(le.datetime[1..4]+le.datetime[6..7]);
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.IncludeAllAttributes := False;

//	self.scores := dataset([{'Models.FraudAdvisor_Service','http://certstagingvip.hpcc.risk.regn.net:9876', params}], models.Layout_Score_Chooser);
						/*
						{'Models.ThinDex_Service','http://certstagingvip.hpcc.risk.regn.net:9876', params},
						{'Models.StudentAdvisor_Service','http://certstagingvip.hpcc.risk.regn.net:9876', student_params}], models.Layout_Score_Chooser);
						*/
	// use it for FCRA RiskView
	self.scores := dataset([{'Models.RVBankCard_Service', 'http://ofcraroxievip.or.seisint.com:9876',params}], models.Layout_Score_Chooser); 
	self.gateways := dataset([{'FCRA', 'http://oroxievip.or.seisint.com:9876'}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;
p_f := project(f, t_f(left, counter));
output(p_f, named('RV_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

roxieIP := 'http://ofcraroxievip.or.seisint.com:9876'; 

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

resu := soapcall(dist_dataset, roxieIP,
				'Models.RiskView_Testing_Service', {dist_dataset}, 
				DATASET(xlayout),
				PARALLEL(30), onFail(myFail(LEFT)));
				
output(resu, named('resu'));
			
ox := RECORD
	STRING30 acctNo;
	string3 RV_score;
	string3 RV_reason;
	string3 RV_reason2;
	string3 RV_reason3;
	string3 RV_reason4;
	STRING errorcode;
END;

ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	// score fields 
	self.rv_score := l.models[1].scores[1].i;
	self.rv_reason := l.models[1].scores[1].reason_codes[1].reason_code;
	self.rv_reason2 := l.models[1].scores[1].reason_codes[2].reason_code;
	self.rv_reason3 := l.models[1].scores[1].reason_codes[3].reason_code;
	self.rv_reason4 := l.models[1].scores[1].reason_codes[4].reason_code;
	self := L;

end;

j_f := JOIN(resu,p_f,LEFT.accountnumber=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f, named('j_f'));

output(j_f,,'~thor_data50::RV::AffinityDirect-proj232',CSV(QUOTE('"')), overwrite);
//output(j_f(errorcode<>''), named('errors'));
