//WARNING: THIS KEY IS AN FCRA KEY...
import doxie, bankrupt, ut, risk_indicators, FCRA, data_services;

slimrec := record
	unsigned6	did;
	risk_indicators.Layout_Derogs BJL;
	// bk extras
	string5    court_code;
	string7    case_num; 
	// criminal extras
	string35    crim_case_num; 
	// liens extras
	STRING10 rmsid;
END;


slimrec get_bkrupt(bankrupt.File_BK_search L) := transform
	self.court_code := L.court_code;
	self.case_num := L.case_number;
	self.did := (integer)L.debtor_did;
	self := [];
end;

w_bksearch := project (bankrupt.File_BK_Search((integer)debtor_did != 0),			
                       get_bkrupt(LEFT));
				
myGetDate := ut.getDate;

slimrec get_bkmain (w_bksearch Le, bankrupt.File_BK_Main Ri) := transform
	SELF.BJL.bankrupt := ri.case_number<>'';
	SELF.BJL.date_last_seen := ut.max2((INTEGER)ri.date_filed, (INTEGER)ri.disposed_date);
	SELF.BJL.filing_type := ri.filing_type;
	SELF.BJL.disposition := ri.disposition;
 	hit := ri.case_number<>'';
	SELF.BJL.filing_count := (INTEGER)hit;
	SELF.BJL.bk_recent_count := (INTEGER)(hit AND ri.disposition='');
	SELF.BJL.bk_disposed_recent_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart(ri.date_modified,myGetDate)<365*2+1);
	SELF.BJL.bk_disposed_historical_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart(ri.date_modified,myGetDate)>365*2);
	self := le;
end;

w_bk := join (w_bksearch, bankrupt.File_BK_Main,
              LEFT.case_num<>'' AND LEFT.court_code<>'' AND
              left.case_num = right.case_number and
              left.court_code = right.court_code,
              get_bkmain(LEFT,RIGHT),
							left outer, hash);
		  
slimrec roll_bankrupt(w_bk le, w_bk ri) := TRANSFORM
	SELF.BJL.bankrupt := le.BJL.bankrupt OR ri.BJL.bankrupt;
	
	SELF.BJL.date_last_seen := ut.max2(le.BJL.date_last_seen,ri.BJL.date_last_seen);
	SELF.BJL.filing_type := le.BJL.filing_type;
	SELF.BJL.disposition := le.BJL.disposition;
	SELF.BJL.filing_count := le.BJL.filing_count + IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.BJL.filing_count);
	SELF.BJL.bk_recent_count := le.BJL.bk_recent_count + 
								IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.BJL.bk_recent_count);
	SELF.BJL.bk_disposed_recent_count := le.BJL.bk_disposed_recent_count + 
								IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.BJL.bk_disposed_recent_count);
	SELF.BJL.bk_disposed_historical_count := le.BJL.bk_disposed_historical_count + 
								IF(le.case_num=ri.case_num AND le.court_code=ri.court_code,0,ri.BJL.bk_disposed_historical_count);
	SELF := le;
END;

bankrupt_rolled := ROLLUP(SORT(distribute(w_bk, hash(did)),
                               did,court_code,case_num,-BJL.date_last_seen, local),
                          LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT), local);


slimrec get_liens(bankrupt_rolled L, bankrupt.File_Liens R) := transform
	isRecent := if (r.filing_date = '', false, ut.DaysApart(r.filing_date,myGetDate)<365*2+1);
	INTEGER rdate := (INTEGER) r.release_date; 

	self.rmsid := R.rmsid;
	SELF.BJL.liens_recent_unreleased_count     := (INTEGER)(r.rmsid<>'' AND rdate=0 AND isRecent);
	SELF.BJL.liens_historical_unreleased_count := (INTEGER)(r.rmsid<>'' AND rdate=0 AND ~isRecent);
	SELF.BJL.liens_recent_released_count       := (INTEGER)(r.rmsid<>'' AND rdate<>0 AND isRecent);
	SELF.BJL.liens_historical_released_count   := (INTEGER)(r.rmsid<>'' AND rdate<>0 AND ~isRecent);
	self.did := (if ((integer)L.did != 0, (integer)L.did, (integer)R.did));
	SELF := l;
end;

l_data := bankrupt.file_liens((integer)did != 0, ~FCRA.Restricted_Lien_Src (rmsid[1..2]));
w_liens := join (bankrupt_rolled, distribute (l_data, hash((integer)DID)),
                 left.did = (integer)right.did,
                 get_liens(LEFT,RIGHT),
                 local, full outer);

slimrec roll_liens (w_liens le, w_liens ri) := TRANSFORM
	SELF.BJL.liens_recent_unreleased_count := le.BJL.liens_recent_unreleased_count + IF(le.rmsid=ri.rmsid,0,ri.BJL.liens_recent_unreleased_count);
	SELF.BJL.liens_recent_released_count := le.BJL.liens_recent_released_count + IF(le.rmsid=ri.rmsid,0,ri.BJL.liens_recent_released_count);
	
	SELF.BJL.liens_historical_unreleased_count := le.BJL.liens_historical_unreleased_count + IF(le.rmsid=ri.rmsid,0,ri.BJL.liens_historical_unreleased_count);
	SELF.BJL.liens_historical_released_count := le.BJL.liens_historical_released_count + IF(le.rmsid=ri.rmsid,0,ri.BJL.liens_historical_released_count);

	SELF := le;
END;

liens_rolled := rollup(sort(w_liens, did, rmsid, local),LEFT.did=RIGHT.did,roll_liens(LEFT,RIGHT), local);	 

slimrec add_doc(liens_rolled le, doxie_files.File_Offenders ri) := TRANSFORM
	SELF.BJL.criminal_count := (INTEGER)((unsigned6)ri.did<>0);
	SELF.crim_case_num:= ri.case_num;
	self.did := (if ((integer)Le.did != 0, (integer)Le.did, (integer)Ri.did));
	SELF := le;
END;

doc_added := JOIN (liens_rolled, distribute(doxie_files.file_offenders((integer)did != 0), hash((integer)did)), 
                   LEFT.did=(integer)RIGHT.did, 
                   add_doc(LEFT,RIGHT), FULL OUTER, local);

slimrec roll_doc(doc_added le, doc_added ri) := TRANSFORM
	SELF.BJL.criminal_count := le.BJL.criminal_count+IF(le.crim_case_num=ri.crim_case_num,0,ri.BJL.criminal_count);
	SELF := le;
END;

doc_rolled := ROLLUP(SORT(doc_added,did,crim_case_num, local), LEFT.did=RIGHT.did, roll_doc(LEFT,RIGHT), local);

//old key name:  '~thor_data400::key::BocaShell_Derogs_DID_' + doxie.Version_SuperKey
export Key_BJL_DID_FCRA := INDEX (doc_rolled, {did}, {doc_rolled}, 
                                  data_services.data_location.prefix() + 'thor_data400::key::bankrupt::fcra::bocashell.did_' + doxie.Version_SuperKey);