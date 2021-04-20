#workunit('name','OFAC Process');
#option ('hthorMemoryLimit', 1000)


import Models, risk_indicators;

prii_layout := RECORD
	STRING AccountNumber;
	STRING UnParsedFullName;
	string EmployerName;
END;

f1 := DATASET('~tfuerstenberg::in::keybank_2363_test_in',prii_layout,csv(quote('"')));
f := project(f1, transform(prii_layout, 
		self.unparsedfullname := if(left.unparsedfullname='', left.employername, left.unparsedfullname);
		self.employername := if(left.employername='', left.unparsedfullname, left.employername);
		self := left));
		
// f := choosen(DATASET('~tfuerstenberg::in::acc_750_in',prii_layout,csv(quote('"'))),5);

output(f);

layout_soap := record
	STRING AccountNumber;
	// STRING FirstName;
	// STRING LastName;
	STRING UnParsedFullName;
	STRING EmployerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	string DataRestrictionMask;
	integer HistoryDateYYYYMM;
	string neutral_gateway := '';	
	dataset(Models.Layout_Score_Chooser) scores;
	
	boolean OfacOnly;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
	boolean PoBoxCompliance;
	boolean IncludeMSoverride;
	boolean IncludeDLVerification;
	string44 PassportUpperLine;
	string44 PassportLowerLine;
	string6 Gender;
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
	
// 	self.DataRestrictionMask := '00000100';  // restricts experian from use
//  self.DataRestrictionMask := '00000001';  // to restrict Equifax from use
	self.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products
	
	self.OfacOnly := false;
	self.OFACversion := 3;
	self.IncludeOfac := true;
	self.IncludeAdditionalWatchLists := false;
	self.GlobalWatchlistThreshold := 0.88;
	self.PoBoxCompliance := false;
	self.IncludeMSoverride := false;
	self.IncludeDLVerification := false;
	self.PassportUpperLine := '';
	self.PassportLowerLine := '';
	self.Gender := '';
	
	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('OFAC_Input'));

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
	STRING UnParsedFullName;
	STRING EmployerName;

//	field 61-59 watchlists
	STRING60  Watchlist_Table;
	// STRING120 Watchlist_Program;
	STRING10  Watchlist_Record_Number;
	STRING20  Watchlist_fname;
	STRING20  Watchlist_lname;
	// STRING65  Watchlist_address;
	// STRING25  Watchlist_city;
	// STRING2   Watchlist_state;
	// STRING5   Watchlist_zip;
	STRING30  Watchlist_country;
	STRING200 Watchlist_Entity_Name;
	
END;

ox normit(resu L, p_f R) := transform
	SELF.Acctno := R.old_account_number;
	SELF.Watchlist_country := l.watchlists[1].watchlist_contry;
	self.UnParsedFullName :=r.unparsedfullname;
	self.EmployerName := r.employername;

	self := L;

end;

j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(j_f);
output(j_f,,'~tfuerstenberg::out::Keybank_2363_testsample_ofac_88_out2',CSV(heading(single), quote('"')), overwrite);
