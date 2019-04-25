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
	string historydateyyyymm;
END;

f := DATASET('~thor_data100::in::test884',prii_layout,csv(quote('"')));
//output(f);

l := RECORD
	STRING old_account_number;
	Risk_Indicators.Layout_InstID_SoapCall;
END;

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.accountnumber;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 1;
	SELF.GLBPurpose := 1;
	self.historydateyyyymm := '200601';
	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('CIID_Input'));

roxieIP := 'http://roxiestaging.br.seisint.com:9876'; // staging vip
//roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie
//roxieIP := 'http://10.173.193.240:9876';    //QA Roxie

s_f := risk_indicators.InstantID_SoapCall(PROJECT(p_f,TRANSFORM(Risk_Indicators.Layout_InstID_SoapCall,SELF := LEFT)), roxieIP);
try_2 := JOIN(p_f, s_f(errorcode<>''), LEFT.accountnumber=RIGHT.acctno, TRANSFORM(l,SELF := LEFT));
s_f2 := Risk_Indicators.InstantID_SoapCall(PROJECT(try_2,TRANSFORM(Risk_Indicators.Layout_InstID_SoapCall,SELF := LEFT)), roxieIP);

s := s_f(errorcode='') + s_f2;

ox :=
RECORD
	risk_indicators.Layout_InstantID_NuGen_Denorm;
	STRING errorcode;
END;

ox getold(s le, l ri) :=
TRANSFORM
	SELF.Acctno := ri.old_account_number;
	SELF := le;
END;

j_f := JOIN(s,p_f,LEFT.acctno=RIGHT.accountnumber,getold(LEFT,RIGHT));

output(j_f,,'~thor_data50::iid::customer',CSV(QUOTE('"')), overwrite);
output(j_f(errorcode<>''),,'~dvstemp::out::new_reasons_errors',CSV(QUOTE('"')), overwrite);

/*
//To Despray as a flat file

ox :=
RECORD
	risk_indicators.Layout_InstantID_NuGen_Denorm;
	STRING errorcode;
END;

d := dataset('~thor_data50::iid::customer', ox, csv(QUOTE('"')));
//output(d);

ex:= record
	risk_indicators.Layout_InstantID_NuGen_Denorm;
	string1 lf;
end;

f := project(d, transform(ex, self.lf:='\n', self:=left));

output(f,, '~thor_data50::iid::customer_flat', overwrite);

*/





