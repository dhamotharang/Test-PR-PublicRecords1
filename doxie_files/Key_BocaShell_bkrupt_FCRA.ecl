import doxie, doxie_files, bankrupt, ut;

layout_date := RECORD
	unsigned4 date;
	STRING5 court_code;
	STRING7 case_number;
END;

slimrec := record
	unsigned6	did;
  // latest bankruptcy case (might be changed/blanked by caller due to fcra-compliance)
	unsigned4 date_last_seen;
	STRING5   court_code;
  STRING7   case_number;
	STRING1   filing_type;
	STRING35  disposition;
  // aggregation
	DATASET(layout_date)	filing_count {MAXCOUNT(100)};
	DATASET(layout_date)	bk_recent_count {MAXCOUNT(100)};
	DATASET(layout_date)	bk_disposed_recent_count {MAXCOUNT(100)};
	DATASET(layout_date)	bk_disposed_historical_count {MAXCOUNT(100)};
END;

rollup_layout := RECORD    // for tracking case in final rollup
  slimrec;
	STRING5 temp_court_code;
  STRING7 temp_case_number;
END;

slimrec get_bkrupt(bankrupt.File_BK_search L) := transform
	self.did := (integer)L.debtor_did;
	self.court_code := L.court_code;
	self.case_number := L.case_number;
	self := []
end;
w_bksearch := project(bankrupt.File_BK_Search((integer)debtor_did != 0, case_number<>'', court_code<>''), get_bkrupt(LEFT));
				
myGetDate := ut.getDate;

rollup_layout get_bkmain (slimrec Le, bankrupt.File_BK_Main Ri) := transform
	date_last_seen := ut.max2((INTEGER)ri.date_filed, (INTEGER)ri.disposed_date);
	SELF.date_last_seen := date_last_seen;
	
	SELF.filing_type := ri.filing_type;
	SELF.disposition := ri.disposition;
	
 	hit := ri.case_number<>'';
  ds_count := DATASET ([{date_last_seen, ri.court_code, ri.case_number}], layout_date);
  days_apart := ut.DaysApart (ri.disposed_date, myGetDate);
	SELF.filing_count := IF (hit, ds_count);
	SELF.bk_recent_count := IF(hit AND ri.disposition='', ds_count);
	SELF.bk_disposed_recent_count     := IF(hit AND ri.disposition<>'' AND (days_apart < 365*2+1), ds_count);
	SELF.bk_disposed_historical_count := IF(hit AND ri.disposition<>'' AND (days_apart > 365*2), ds_count);	

	SELF.temp_court_code := le.court_code;
  SELF.temp_case_number := le.case_number;
	SELF := le;
end;
w_bk := join (w_bksearch, bankrupt.File_BK_Main,
              left.case_number = right.case_number and
              left.court_code = right.court_code,
              get_bkmain(LEFT,RIGHT), left outer, hash);

rollup_layout roll_bankrupt (w_bk le, w_bk ri) := TRANSFORM
  boolean takeLeft := le.date_last_seen >= ri.date_last_seen;
	SELF.date_last_seen := IF (takeLeft, le.date_last_seen, ri.date_last_seen);
  SELF.filing_type := IF (takeLeft, le.filing_type, ri.filing_type);
	SELF.disposition := IF (takeLeft, le.disposition, ri.disposition);
	SELF.case_number := IF (takeLeft, le.case_number, ri.case_number);
	SELF.court_code  := IF (takeLeft, le.court_code, ri.court_code);

  boolean sameCase := (le.temp_court_code = ri.court_code) AND (le.temp_case_number = ri.case_number);
	SELF.filing_count := CHOOSEN(le.filing_count & IF (~sameCase,ri.filing_count),100);
	SELF.bk_recent_count := CHOOSEN(le.bk_recent_count & 	IF(~sameCase,ri.bk_recent_count),100);
	SELF.bk_disposed_recent_count := CHOOSEN(le.bk_disposed_recent_count & 	IF(~sameCase,ri.bk_disposed_recent_count),100);
	SELF.bk_disposed_historical_count := CHOOSEN(le.bk_disposed_historical_count &
								IF(~sameCase,ri.bk_disposed_historical_count),100);

	SELF.temp_court_code := IF (sameCase, le.temp_court_code, ri.temp_court_code);
  SELF.temp_case_number := IF (sameCase, le.temp_case_number, ri.temp_case_number);
	SELF := le;
END;

ds_sorted := SORT (distribute(w_bk, hash(did)), did, court_code, case_number, -date_last_seen, local);
bankrupt_rolled := ROLLUP (ds_sorted, LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT), local);

bankrupt_shrink := PROJECT (bankrupt_rolled, slimrec);

export Key_BocaShell_bkrupt_FCRA := index (bankrupt_shrink, {did}, {bankrupt_shrink},
   '~thor_data400::key::bankrupt::fcra::bocashell_did_' + doxie.Version_SuperKey);