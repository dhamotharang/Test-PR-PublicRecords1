import ut, BankruptcyV2, doxie,dops;

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

myGetDate := ut.getDate;

rollup_layout get_bkrupt_search(BankruptcyV2.file_bankruptcy_search_v3 L) := transform
	self.did := (integer)L.did;
	self.court_code := L.court_code;
	self.case_number := L.case_number;

	date_last_seen := ut.max2((INTEGER)L.date_filed, (INTEGER)L.discharged);
	SELF.date_last_seen := date_last_seen;
	
	SELF.filing_type := L.filing_type;
	SELF.disposition := L.disposition;
	
 	hit := L.case_number<>'';
  ds_count := DATASET ([{L.date_filed, L.court_code, L.case_number}], layout_date);
  days_apart := ut.DaysApart (L.discharged, myGetDate);
	SELF.filing_count := IF (hit, ds_count);
	SELF.bk_recent_count := IF(hit AND L.disposition='', ds_count);
	SELF.bk_disposed_recent_count     := IF(hit AND L.disposition<>'' AND (days_apart < 365*2+1), ds_count);
	SELF.bk_disposed_historical_count := IF(hit AND L.disposition<>'' AND (days_apart > 365*2), ds_count);	
	
	SELF.temp_court_code := l.court_code;
  SELF.temp_case_number := l.case_number;
end;

w_bk := project(BankruptcyV2.file_bankruptcy_search_v3((integer)did != 0 and name_type='D' and case_number<>'' and court_code<>''), get_bkrupt_search(left));
FCRATest:=w_bk(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(true));
				
rollup_layout roll_bankrupt (FCRATest le, FCRATest ri) := TRANSFORM
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

ds_sorted := SORT (distribute(FCRATest, hash(did)), did, court_code, case_number, -date_last_seen, local);
bankrupt_rolled := ROLLUP (ds_sorted, LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT), local);

bankrupt_slim := PROJECT (bankrupt_rolled, slimrec);

export Key_bankruptcyV3_FCRA_bocashell := index (bankrupt_slim, {did}, {bankrupt_slim},
		'~thor_data400::key::bankruptcyv3::fcra::bocashell_' + doxie.Version_SuperKey);