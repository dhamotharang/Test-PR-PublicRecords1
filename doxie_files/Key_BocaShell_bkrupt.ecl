import doxie, doxie_files, bankrupt, ut;

slimmerrec :=
RECORD
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





slimrec get_bkrupt(bankrupt.File_BK_search L) := transform
	self.court_code := L.court_code;
	self.case_num := L.case_number;
	self.did := (integer)L.debtor_did;
	self := []
end;

w_bksearch := project(bankrupt.File_BK_Search((integer)debtor_did != 0),			
				get_bkrupt(LEFT));
				
myGetDate := ut.getDate;

slimrec get_bkmain(w_bksearch Le, bankrupt.File_BK_Main Ri) := transform
	SELF.bankrupt := ri.case_number<>'';
	SELF.date_last_seen := ut.max2((INTEGER)ri.date_filed, (INTEGER)ri.disposed_date);
	SELF.filing_type := ri.filing_type;
	SELF.disposition := ri.disposition;
 	hit := ri.case_number<>'';
	SELF.filing_count := (INTEGER)hit;
	SELF.bk_recent_count := (INTEGER)(hit AND ri.disposition='');
	SELF.bk_disposed_recent_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart(ri.disposed_date,myGetDate)<365*2+1);
	SELF.bk_disposed_historical_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart(ri.disposed_date,myGetDate)>365*2);
	self := le;
end;

w_bk := join(w_bksearch, bankrupt.File_BK_Main,
			LEFT.case_num<>'' AND LEFT.court_code<>'' AND
			left.case_num = right.case_number and
			left.court_code = right.court_code,
		   get_bkmain(LEFT,RIGHT), left outer, hash);
		  
slimrec roll_bankrupt(w_bk le, w_bk ri) :=
TRANSFORM
	SELF.bankrupt := le.bankrupt OR ri.bankrupt;
	
	SELF.date_last_seen := ut.max2(le.date_last_seen,ri.date_last_seen);
	SELF.filing_type := le.filing_type;
	SELF.disposition := le.disposition;
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

export Key_BocaShell_bkrupt := index(bankrupt_slim, {did}, {bankrupt_slim}, '~thor_data400::key::bankrupt::bocashell_did_' + doxie.Version_SuperKey);
