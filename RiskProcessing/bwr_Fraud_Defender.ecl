#workunit('name','Consumer Fraud Defender Process');
#option ('hthorMemoryLimit', 1000)


import models, risk_indicators;

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
	string DLNumber;
	string DLState;
	string BALANCE; 
	string CHARGEOFFD;  
	string FormerName;
	string EMAIL;  
	string COMPANY;
	integer historydateyyyymm;
END;

f := DATASET('~jpyon::in::sand_4491_f_s_in',prii_layout,csv(quote('"')));
// f := choosen(DATASET('~tfuerstenberg::in::cbe_699_frauddef_in',prii_layout,csv(quote('"'))),5);

output(f);

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
	string DataRestrictionMask;		
	integer HistoryDateYYYYMM := '';
	string neutral_gateway := '';
	dataset(Models.Layout_Score_Chooser) scores;
end;

l := RECORD
	STRING old_account_number;
	layout_soap;
END;

parms := dataset ([],models.Layout_Parameters);

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.accountnumber;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;
	self.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products	
//	self.historydateyyyymm := '200601';
	self.scores := dataset([{'Models.FraudAdvisor_Service','http://roxiethorvip.hpcc.risk.regn.net:9856',parms}], models.Layout_Score_Chooser);
	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('CIID_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

roxieIP := 'http://roxiethorvip.hpcc.risk.regn.net:9856'; // roxiebatch

xlayout := RECORD
	(risk_indicators.Layout_InstandID_NuGen)
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'risk_indicators.InstantID', {dist_dataset}, 
				DATASET(xlayout),
				PARALLEL(30), onFail(myFail(LEFT)));
				
ox := RECORD
	STRING30 acctNo;

//	output the extra model score and reason code
	string3 score1;
	string3 score2;
	string3 score3;

	string3 reason;
	string3 reason2;
	string3 reason3;
	string3 reason4;
//	STRING errorcode;
END;

ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	
	// score fields  Note: score[1] equals a 0-999 score range
	// score fields  Note: score[2] equals a 010-050 score range
	// score fields  Note: score[3] equals a 10-90 score range *** Use as Default ***

	self.score1 := l.models.scores[1].i;
	self.score2 := l.models.scores[2].i;
	self.score3 := l.models.scores[3].i;
	self.reason := l.models.scores[3].reason_codes[1].reason_code;
	self.reason2 := l.models.scores[3].reason_codes[2].reason_code;
	self.reason3 := l.models.scores[3].reason_codes[3].reason_code;
	self.reason4 := l.models.scores[3].reason_codes[4].reason_code;
	self := L;

end;

j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f);
output(j_f,,'~jpyon::out::sand_4491_junk',CSV(heading(single), quote('"')), overwrite);
//output(j_f(errorcode<>''),,'~tfuerstenberg::out::avon_contract_fd_errors',CSV(QUOTE('"')), overwrite);
