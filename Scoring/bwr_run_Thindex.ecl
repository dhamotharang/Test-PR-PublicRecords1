import RiskProcessing;
prii_layout := RECORD
string	lastname	;
string	FirstName;	
string	StreetAddress	;
string	CITY	;
string	STate	;
string	ZIP	;
string	sosc	;
string	HomePHONE	;
string	EMPLOYERname	;
string	workPHONE	;
string	BAL	;
string loandate;
string	CK 	;
string	STORE	;
END;
f := DATASET('~thor_data50::in::checkngo',prii_layout,csv(heading(1),quote('"')));
output(f);

RiskProcessing.Layout_Thindex_Soapcall t_f(f le, INTEGER c) := TRANSFORM
    SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 1;
	SELF.GLBPurpose := 1;
	self.ssn:=le.sosc[1..3]+le.sosc[5..6]+le.sosc[8..11];
	self.historydateyyyymm := (integer)(le.loandate[1..4]+le.loandate[6..7]);
	SELF := le;
	self := [];
end;
p_f := project(f, t_f(left, counter));
output(p_f, named('soap_In'));


roxieIP := 'http://roxiestaging.br.seisint.com:9876'; // staging vip


s_f := RiskProcessing.ThinDex_Soapcall(p_f, roxieIP);
//try_2 := JOIN(p_f, s_f(errorcode<>''), LEFT.accountnumber=RIGHT.acctno, TRANSFORM(l,SELF := LEFT));
//s_f2 := Risk_Indicators.InstantID_SoapCall(PROJECT(try_2,TRANSFORM(Risk_Indicators.Layout_InstID_SoapCall,SELF := LEFT)), roxieIP);

s := s_f(errorcode='');

output(s);
output(s,,'~thor_data50::thindex::checkngo',CSV(QUOTE('"')), overwrite);


/*
//To Despray as a flat file

ox :=
RECORD
	risk_indicators.Layout_InstantID_NuGen_Denorm;
	STRING errorcode;
END;

d := dataset('~thor_data50::iid_fd::checkngo', ox, csv(QUOTE('"')));
//output(d);

ex:= record
	risk_indicators.Layout_InstantID_NuGen_Denorm;
	string1 lf;
end;

f := project(d, transform(ex, self.lf:='\n', self:=left));

output(f,, '~thor_data400::iid_fd::checkngo_flat', overwrite);

*/
