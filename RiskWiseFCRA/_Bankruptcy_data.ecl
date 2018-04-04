EXPORT _Bankruptcy_data(in_dids, flag_file, bankruptcy_search_o, bankruptcy_o, bankruptcy_courts_o=[], history_date_=999999, bankruptcy_withdraws_o=[]) := MACRO

  IMPORT BankruptcyV3, BankruptcyV2, FCRA, riskwise, STD;

	layout_bankruptcy   := RECORDOF (bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing);
	layout_bkr_search   := RECORDOF (BankruptcyV2.layout_bankruptcy_search_v3);

	// get corrected record_id and pointers to corrections file. Used for both bk_search & bk_main
	bankrupt_cccn := SET (flag_file (file_id = FCRA.FILE_ID.BANKRUPTCY), record_id);
	bankrupt_ffid := SET (flag_file (file_id = FCRA.FILE_ID.BANKRUPTCY), flag_file_id);
	
	MAX_OVERRIDE_LIMIT_ := FCRA.compliance.MAX_OVERRIDE_LIMIT;
	todaysdate_ := (string) STD.Date.Today();
	isFCRA_ := true;
	
// -------------  BANKRUPTCY SEARCH  -------------
	
  layout_bankruptcy_slim := RECORD
		unsigned6 did;
	  string5  court_code;
	  string7  case_num; 
		string50 tmsid := '';
  END;	

  bankrupt_slim := JOIN (in_dids, BankruptcyV3.key_bankruptcyV3_did(isFCRA_),
                         left.did<>0 and 
												 keyed(Left.did=Right.did),
                         transform(layout_bankruptcy_slim, 
																		self.did := right.did;
																		self.court_code := right.court_code;
																		self.case_num := right.case_number;
																		self.tmsid := right.tmsid;),
																		KEEP(10),atmost(riskwise.max_atmost));
	layout_bkr_search_temp := RECORD
		layout_bkr_search;
		boolean inputIsDebtor;
	END;
	
  // get good records													 
	bankrupt_search_temp := JOIN (bankrupt_slim, BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA_),
																Left.case_num<>'' AND Left.court_code<>'' AND left.tmsid<>'' and 
																keyed (Left.tmsid = Right.tmsid) and 
																(trim (Right.tmsid) + trim(Right.name_type) + trim(right.did) NOT IN bankrupt_cccn) AND
																(unsigned)(Right.date_filed[1..6]) < history_date_, 
																TRANSFORM (layout_bkr_search_temp, SELF.inputIsDebtor := if(left.did=(unsigned6)right.did and right.name_type='D',true, false), SELF := Right),
																LEFT OUTER, atmost(riskwise.max_atmost), keep(100));
																
	flagged_group := dedup(sort(bankrupt_search_temp, tmsid, court_code, case_number, -inputIsDebtor),tmsid, court_code, case_number);		
	
	bankrupt_search1 := join(bankrupt_search_temp, flagged_group, left.tmsid=right.tmsid and left.court_code=right.court_code and left.case_number=right.case_number and right.inputIsDebtor,
													TRANSFORM(layout_bkr_search, SELF:=LEFT));	
	
	bankrupt_search := sort(bankrupt_search1, -date_last_seen,-date_first_seen);			
  //get corrections
  ds_override_s := fcra.key_override_bkv3_search_ffid (keyed (flag_file_id IN bankrupt_ffid));	

  // adjust layouts
  bk_search_correct :=  PROJECT (CHOOSEN (ds_override_s, MAX_OVERRIDE_LIMIT_), layout_bkr_search);
  bk_all := bk_search_correct + bankrupt_search;
	
	// filter by FCRA date; debtor records now being returned (bug 68174)
  bk_search_filtered := bk_all( FCRA.bankrupt_is_ok (todaysdate_, date_filed)); //it filters for records within the past 10 years
	
	bankruptcy_search_o := sort(bk_search_filtered, -date_last_seen, -date_first_seen);

// -------------  BANKRUPTCY  -------------

	// dedup the bankruptcy TMSIDs before joining to the main file
	bk_all_deduped := dedup(sort(bankruptcy_search_o(name_type='D'), tmsid, court_code, case_number),tmsid, court_code, case_number);
  
  // Get good records
  bankruptcy := JOIN (bk_all_deduped, BankruptcyV3.key_bankruptcyV3_main_full(isFCRA_),
                      Left.case_number<>'' AND Left.court_code<>'' AND left.tmsid<>'' and 
                      keyed (Left.tmsid = Right.tmsid) and
                      (TRIM (Right.court_code) + Right.case_number NOT IN bankrupt_cccn) AND
                      (unsigned)(Right.date_filed[1..6]) < history_date_, 
                      TRANSFORM (layout_bankruptcy, SELF := Right),
                      LEFT OUTER, atmost(riskwise.max_atmost), keep(100));

  //get corrections
  ds_override_m := fcra.key_override_bkv3_main_ffid (keyed (flag_file_id IN bankrupt_ffid));
	ds_bk_new := PROJECT (CHOOSEN (ds_override_m, MAX_OVERRIDE_LIMIT_), layout_bankruptcy);

  // filtering by fcra-date
  bk_filtered := (ds_bk_new + bankruptcy) (FCRA.bankrupt_is_ok (todaysdate_, date_filed));

	bankruptcy_o := sort(bk_filtered,  -date_last_seen, -date_first_seen);

// -------------  BANKRUPTCY COURTS  -------------

	bk_courts := dedup(sort(bankruptcy_search_o(name_type='D'),court_code),court_code);
	bankruptcy_courts_o := join(bk_courts, BankruptcyV3.key_bankruptcyV3_courts,keyed(left.court_code = right.moxie_court),transform(right), atmost(riskwise.max_atmost));

// -------------  BANKRUPTCY WITHDRAW  -------------

	bk_withdraws := dedup(sort(bankruptcy_search_o(name_type='D'),tmsid,caseID,DefendantID),tmsid,caseID,DefendantID);
	bankruptcy_withdraws_o := join(bk_withdraws, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,isFCRA_),
															keyed(left.tmsid = right.tmsid and left.caseID = right.caseID  and left.DefendantID = right.DefendantID),
															transform(right), atmost(riskwise.max_atmost));
	
// output(bankrupt_slim,named('bankrupt_slim'));
// output(bankrupt_search_temp,named('bankrupt_search_temp'));	
// output(flagged_group,named('bk_flagged_group'));	
// output(bankrupt_search1,named('bankrupt_search1'));	
// output(ds_override_s,named('bankrupt_search_ds_override'));
// output(bk_search_correct,named('bk_search_correct'));	
// output(bk_all,named('bk_all'));	
// output(bk_search_filtered,named('bk_search_filtered'));
// output(bankruptcy_search_o,named('bankruptcy_search_o'));

// output(flag_file,named('bk_ffile'));
// ff_bk:=flag_file(file_id = FCRA.FILE_ID.BANKRUPTCY);
// output(ff_bk,named('ff_bk'));
// output(bk_all_deduped,named('bk_all_deduped'));
// output(bankruptcy,named('bk_bankruptcy'));
// output(ds_override_m,named('bk_ds_override_m'));	
// output(ds_bk_new,named('ds_bk_new'));
// output(bk_filtered,named('bk_filtered'));	

ENDMACRO;
