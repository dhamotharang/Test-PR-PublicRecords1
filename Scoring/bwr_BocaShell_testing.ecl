// run this script using hthor only, not the 100 way or 50 way anymore

	prii_layout := RECORD
		STRING Account;
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
		string employername;
		string historydateyyyymm;
	END;
	
	f := dataset('~thor_data100::in::test884', prii_layout, csv(quote('"')));
	
	l :=
	RECORD
		STRING old_account_number;
		Risk_Indicators.Layout_InstID_SoapCall;
	END;
	
	l t_f(f le, INTEGER c) :=
	TRANSFORM
		SELF.old_account_number := le.Account;
		SELF.AccountNumber := (STRING)c;
		SELF.FirstName := le.FirstName;
		SELF.MiddleName := le.MiddleName;
		SELF.LastName := le.LastName;
		SELF.NameSuffix := '';
		SELF.StreetAddress := le.StreetAddress;
		SELF.City := le.City;
		SELF.State := le.State;
		SELF.Zip := le.Zip;
		SELF.Country := '';
		SELF.SSN := le.Ssn;
		SELF.DateOfBirth := le.DateOfBirth;
		SELF.Age := '';
		SELF.DLNumber := le.DLNumber;
		SELF.DLState := le.DLState;
		SELF.Email := '';
		SELF.IPAddress := '';
		SELF.HomePhone := le.HomePhone;
		SELF.WorkPhone := le.WorkPhone;
		SELF.EmployerName := le.employername;
		SELF.FormerName := '';
		SELF.GLBPurpose := 1;
		SELF.DPPAPurpose := 1;
		SELF.HistoryDateYYYYMM := le.historydateyyyymm;
	END;
	
	p_f := PROJECT(f,t_f(LEFT,COUNTER));
	
	roxieIP := 'http://roxiestaging.br.seisint.com:9876';
	//roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie
	
	s_f := Risk_Indicators.BocaShell_SoapCall(PROJECT(p_f,TRANSFORM(Risk_Indicators.Layout_InstID_SoapCall,SELF := LEFT)), roxieIP);
	
	try_2 := JOIN(p_f, s_f(errorcode<>''), (unsigned)LEFT.accountnumber=RIGHT.seq, TRANSFORM(l,SELF := LEFT));
	
	s_f2 := Risk_Indicators.BocaShell_SoapCall(PROJECT(try_2,TRANSFORM(Risk_Indicators.Layout_InstID_SoapCall,SELF := LEFT)), roxieIP);
	
	s := s_f(errorcode='') + s_f2;
	
	ox :=
	RECORD
		STRING AccountNumber;
		risk_indicators.Layout_Boca_Shell_Edina;
		STRING errorcode;
	END;
	
	ox getold(s le, l ri) :=
	TRANSFORM
		SELF.AccountNumber := ri.old_account_number;
		SELF := le;
	END;
	
	j_f := JOIN(s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
	
	output(j_f,,'~thor_data50::out::bocashell_test_scroxie',CSV(QUOTE('"')),overwrite);
	output(j_f(errorcode<>''),,'~thor_data50::out::bocashell_test_scroxie_errors',CSV(QUOTE('"')),overwrite);