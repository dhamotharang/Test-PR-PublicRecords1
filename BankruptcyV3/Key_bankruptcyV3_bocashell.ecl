import doxie, ut, bankruptcyv2, risk_indicators;

slimmerrec := RECORD
	unsigned6 did;
	BOOLEAN bankrupt := false;
	UNSIGNED4 date_last_seen := 0;
	STRING1 filing_type := '';
	STRING35 disposition := '';	
	UNSIGNED1 filing_count := 0;
	UNSIGNED1 bk_recent_count := 0;
	UNSIGNED1 bk_disposed_recent_count := 0;
	UNSIGNED1 bk_disposed_historical_count := 0;
	UNSIGNED1 bk_count30 := 0;
	UNSIGNED1 bk_count90 := 0;
	UNSIGNED1 bk_count180 := 0;
	UNSIGNED1 bk_count12 := 0;
	UNSIGNED1 bk_count24 := 0;
	UNSIGNED1 bk_count36 := 0;
	UNSIGNED1 bk_count60 := 0;	
END;


slimrec := record
	slimmerrec;
	string5    court_code;
	string7    case_num; 
END;

myGetDate := ut.getDate;
historydate := 999999;
slimrec get_bkrupt(BankruptcyV2.file_bankruptcy_search_v3 L) := transform
	self.court_code := L.court_code;
	self.case_num := L.case_number;
	self.did := (integer)L.did;
	
	// disposition and date file used to be on the main, but they're on the search file now
	self.filing_type := l.filing_type;
	self.disposition := l.disposition;
	date_last_seen := ut.max2((INTEGER)l.date_filed, (INTEGER)l.discharged);  // discharged now instead of disposed_date
	SELF.date_last_seen := date_last_seen;
	SELF.bk_disposed_recent_count := (INTEGER)(l.disposition<>'' AND ut.DaysApart(l.discharged,myGetDate)<365*2+1);
	SELF.bk_disposed_historical_count := (INTEGER)(l.disposition<>'' AND ut.DaysApart(l.discharged,myGetDate)>365*2);
	
	SELF.bk_count30 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,30, historydate);
	SELF.bk_count90 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,90, historydate);
	SELF.bk_count180 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,180, historydate);
	SELF.bk_count12 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(1), historydate);
	SELF.bk_count24 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(2), historydate);
	SELF.bk_count36 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(3), historydate);
	SELF.bk_count60 := (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(5), historydate);
	self := []
end;

w_bksearch := project(BankruptcyV2.file_bankruptcy_search_v3((integer)did != 0 and name_type='D'),			
				get_bkrupt(LEFT));

// output(w_bksearch, named('w_bksearch'));				

slimrec get_bkmain(w_bksearch Le, BankruptcyV2.file_bankruptcy_main_v3 Ri) := transform
	SELF.bankrupt := ri.case_number<>'';
 	hit := ri.case_number<>'';
	SELF.filing_count := (INTEGER)hit;
	SELF.bk_recent_count := (INTEGER)(hit AND le.disposition='');
	self := le;
end;

w_bk := join(w_bksearch, BankruptcyV2.file_bankruptcy_main_v3,
			LEFT.case_num<>'' AND LEFT.court_code<>'' AND
			left.case_num = right.case_number and
			left.court_code = right.court_code,
		   get_bkmain(LEFT,RIGHT), left outer, hash);

// output(w_bk, named('w_bk'));
		  
slimrec roll_bankrupt(w_bk le, w_bk ri) := TRANSFORM

	sameBankruptcy := le.case_num=ri.case_num AND le.court_code=ri.court_code;
	SELF.bankrupt := le.bankrupt OR ri.bankrupt;
	
	// keep the filing type and disposition together with the date that is selected 
	// instead of always selecting the left filing type and left disposition
	use_right := ri.date_last_seen > le.date_last_seen;
	SELF.date_last_seen := if(use_right, ri.date_last_seen, le.date_last_seen);
	SELF.filing_type := if(use_right, ri.filing_type, le.filing_type);
	SELF.disposition := if(use_right, ri.disposition, le.disposition);
	
	SELF.filing_count := le.filing_count + IF(sameBankruptcy,0,ri.filing_count);
	SELF.bk_recent_count := le.bk_recent_count + 
								IF(sameBankruptcy,0,ri.bk_recent_count);
	SELF.bk_disposed_recent_count := le.bk_disposed_recent_count + 
								IF(sameBankruptcy,0,ri.bk_disposed_recent_count);
	SELF.bk_disposed_historical_count := le.bk_disposed_historical_count + 
								IF(sameBankruptcy,0,ri.bk_disposed_historical_count);							
								
	SELF.bk_count30 := le.bk_count30 + IF(sameBankruptcy,0,ri.bk_count30);
	SELF.bk_count90 := le.bk_count90 + IF(sameBankruptcy,0,ri.bk_count90);
	SELF.bk_count180 := le.bk_count180 + IF(sameBankruptcy,0,ri.bk_count180);
	SELF.bk_count12 := le.bk_count12 + IF(sameBankruptcy,0,ri.bk_count12);
	SELF.bk_count24 := le.bk_count24 + IF(sameBankruptcy,0,ri.bk_count24);
	SELF.bk_count36 := le.bk_count36 + IF(sameBankruptcy,0,ri.bk_count36);
	SELF.bk_count60 := le.bk_count60 + IF(sameBankruptcy,0,ri.bk_count60);
			
	SELF := le;
END;

bankrupt_rolled := ROLLUP(SORT(distribute(w_bk, hash(did)),
					did,court_code,case_num,-date_last_seen, local),
				LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT), local);

bankrupt_slim := PROJECT(bankrupt_rolled, slimmerrec);

export Key_bankruptcyV3_bocashell := index(bankrupt_slim, {did}, {bankrupt_slim}, '~thor_data400::key::bankruptcyv3::bocashell_' + doxie.Version_SuperKey);
