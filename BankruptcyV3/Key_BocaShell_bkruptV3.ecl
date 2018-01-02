import doxie, ut, bankruptcyv2, data_services;

slimmerrec := RECORD
	unsigned6	did;
	BOOLEAN bankrupt;
	UNSIGNED4 date_last_seen;
	STRING1 filing_type;
	STRING35 disposition;
	UNSIGNED1 filing_count;
	UNSIGNED1 bk_recent_count;
	UNSIGNED1 bk_disposed_recent_count;
	UNSIGNED1 bk_disposed_historical_count;
END;


slimrec := record
	slimmerrec;
	string5    court_code;
	string7    case_num; 
END;

myGetDate := ut.getDate;

slimrec get_bkrupt(BankruptcyV2.file_bankruptcy_search_v3 L) := transform
	self.court_code := L.court_code;
	self.case_num := L.case_number;
	self.did := (integer)L.did;
	
	// disposition and date file used to be on the main, but they're on the search file now
	self.filing_type := l.filing_type;
	self.disposition := l.disposition;
	SELF.date_last_seen := ut.max2((INTEGER)l.date_filed, (INTEGER)l.discharged);  // discharged now instead of disposed_date
	SELF.bk_disposed_recent_count := (INTEGER)(l.disposition<>'' AND ut.DaysApart(l.discharged,myGetDate)<365*2+1);
	SELF.bk_disposed_historical_count := (INTEGER)(l.disposition<>'' AND ut.DaysApart(l.discharged,myGetDate)>365*2);
	self := []
end;

w_bksearch := project(BankruptcyV2.file_bankruptcy_search_v3((integer)did != 0 and name_type='D'),			
				get_bkrupt(LEFT));
				

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
		  
slimrec roll_bankrupt(w_bk le, w_bk ri) :=
TRANSFORM
	SELF.bankrupt := le.bankrupt OR ri.bankrupt;
	
	// keep the filing type and disposition together with the date that is selected 
	// instead of always selecting the left filing type and left disposition
	use_right := ri.date_last_seen > le.date_last_seen;
	SELF.date_last_seen := if(use_right, ri.date_last_seen, le.date_last_seen);
	SELF.filing_type := if(use_right, ri.filing_type, le.filing_type);
	SELF.disposition := if(use_right, ri.disposition, le.disposition);
	
	SELF.filing_count := le.filing_count + IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.filing_count);
	SELF.bk_recent_count := le.bk_recent_count + 
								IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.bk_recent_count);
	SELF.bk_disposed_recent_count := le.bk_disposed_recent_count + 
								IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.bk_disposed_recent_count);
	SELF.bk_disposed_historical_count := le.bk_disposed_historical_count + 
								IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.bk_disposed_historical_count);
	SELF := le;
END;

bankrupt_rolled := ROLLUP(SORT(distribute(w_bk, hash(did)),
					did,court_code,case_num,-date_last_seen, local),
				LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT), local);

bankrupt_slim := PROJECT(bankrupt_rolled, slimmerrec);

export Key_BocaShell_bkruptV3 := index(bankrupt_slim, {did}, {bankrupt_slim}, data_services.data_location.prefix('bankruptcyv3') + 'thor_data400::key::bankruptcyv3::bocashell_did_' + doxie.Version_SuperKey);
