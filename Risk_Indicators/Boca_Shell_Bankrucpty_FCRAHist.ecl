import _Control, doxie_files, ut, doxie, fcra, riskwise, bankruptcyv3, Risk_Indicators;
onThor := _Control.Environment.OnThor;

EXPORT Boca_Shell_Bankrucpty_FCRAHist (	integer bsVersion, unsigned8 BSOptions=0,
	GROUPED DATASET(Risk_Indicators.layouts.layout_derogs_input) ids) := FUNCTION
																				
	bans_did := BankruptcyV3.key_bankruptcyV3_did(true);
	bans_Withdrawn_Status := BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,TRUE);	
	bans_search := BankruptcyV3.key_bankruptcyv3_search_full_bip(true);

	insurance_fcra_filter :=  (BSOptions & Risk_Indicators.iid_constants.BSOptions.InsuranceFCRAMode) > 0;

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process := RECORD
			Risk_Indicators.layouts.layout_derogs_input;
			Risk_Indicators.Layout_Derogs BJL;
			Risk_Indicators.Layouts.Layout_Liens Liens;
	END;

	Risk_Indicators.Layouts_Derog_Info.layout_extended add_bankrupt (layouts.layout_derogs_input le, bans_did ri) := TRANSFORM
		self.bk_tmsid := ri.tmsid;
		SELF.court_code := ri.court_code;
		SELF.case_num := ri.case_number;
		SELF := le;
		SELF := [];
	END;

	bankrupt_added_roxie := JOIN (ids, bans_did ,LEFT.did=RIGHT.did, add_bankrupt(LEFT,RIGHT), 
		atmost(riskwise.max_atmost), 
		LEFT OUTER, KEEP(10));
	
	bankrupt_added_thor_did := JOIN (distribute(ids(did<>0), hash64(did)), 
		distribute(pull(bans_did), hash64(did)) ,
		LEFT.did=RIGHT.did, 
		add_bankrupt(LEFT,RIGHT), 
		atmost(riskwise.max_atmost), 
		LEFT OUTER, KEEP(10), LOCAL);
	bankrupt_added_thor := group(sort(project(ids(did=0), transform(Risk_Indicators.Layouts_Derog_Info.layout_extended, self := left, self := [])) + 
													bankrupt_added_thor_did, did, LOCAL), did, LOCAL);
													
#IF(onThor)
	bankrupt_added := bankrupt_added_thor;
#ELSE
	bankrupt_added := bankrupt_added_roxie;
#END

	Risk_Indicators.Layouts_Derog_Info.layout_extended getWithdrawnCheck(bankrupt_added le, bans_Withdrawn_Status ri) := TRANSFORM
		// blank out the TMSID if found on withdrawn key so the next join doesn't hit the search file
		// per the requirements document, we only want to remove the withdrawn bankruptcy on version 3.0 and higher
		self.bk_tmsid := if(ri.tmsid<>'' and bsversion >= 3, '', le.bk_tmsid);
		self := le;
	END;
	
	bankrupt_added_after_withdrawn_check_roxie := JOIN (bankrupt_added, bans_Withdrawn_Status,
							LEFT.bk_tmsid<>'' AND
							keyed(LEFT.bk_tmsid = RIGHT.tmsid) AND
							(unsigned)right.did=left.did and
							(unsigned)(RIGHT.WithdrawnDispositionDate[1..6]) < left.historydate ,									
							getWithDrawnCheck(LEFT,RIGHT), 
							left outer, atmost(riskwise.max_atmost), keep(1)
							);	

	bankrupt_added_after_withdrawn_check_thor := JOIN (distribute(bankrupt_added(bk_tmsid<>''), hash64(bk_tmsid)), 
							distribute(pull(bans_Withdrawn_Status), hash64(tmsid)),
							LEFT.bk_tmsid = RIGHT.tmsid AND
							(unsigned)right.did=left.did AND
							(unsigned)(RIGHT.WithdrawnDispositionDate[1..6]) < left.historydate, 									
							getWithdrawnCheck(LEFT, RIGHT), 
							left outer, atmost(LEFT.bk_tmsid = RIGHT.tmsid, riskwise.max_atmost), keep(1), LOCAL) +
							bankrupt_added(bk_tmsid='');
							
	#IF(onThor)
		bankrupt_added_after_withdrawn_check := group(sort(bankrupt_added_after_withdrawn_check_thor, seq),seq);
	#ELSE
		bankrupt_added_after_withdrawn_check := bankrupt_added_after_withdrawn_check_roxie;
	#END
							
	Risk_Indicators.Layouts_Derog_Info.layout_extended get_bankrupt_FCRA (Risk_Indicators.Layouts_Derog_Info.layout_extended le, bans_search ri) := TRANSFORM
		myGetDate := Risk_Indicators.iid_constants.myGetDate(le.historydate);
		SELF.BJL.bankrupt := ri.case_number<>'';
		date_last_seen := if(bsversion<50,  max((INTEGER)ri.date_filed, if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0)),(INTEGER) ri.date_filed);//only use the disposed date if not in the future
		SELF.BJL.date_last_seen := date_last_seen;
		SELF.BJL.filing_type := ri.filing_type;
		SELF.BJL.disposition := ri.disposition;
		hit := ri.case_number<>'';
		SELF.BJL.filing_count := (INTEGER)hit;
		SELF.BJL.filing_count120 := if(hit, (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(10), le.historydate), 0);
		SELF.BJL.bk_recent_count := (INTEGER)(hit AND ri.disposition='');
		date_disp := if(bsversion<50, (INTEGER) ri.discharged, date_last_seen);
		SELF.BJL.bk_disposed_recent_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp,myGetDate)<365*2+1);// we are potentially counting some dispositions in the future but not others depending on the dates
		SELF.BJL.bk_disposed_historical_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp,myGetDate)>365*2);
		SELF.BJL.bk_disposed_historical_cnt120 := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp,myGetDate)>365*2 AND 
																							 risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_disp,ut.DaysInNYears(10), le.historydate));

		SELF.BJL.bk_dismissed_recent_count := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string) date_disp,myGetDate)<365*2+1);
		SELF.BJL.bk_dismissed_historical_count := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string) date_disp,myGetDate)>365*2);
		SELF.BJL.bk_dismissed_historical_cnt120 := (INTEGER)(StringLib.StringToUpperCase(ri.disposition)='DISMISSED' AND ut.DaysApart((string) date_disp,myGetDate)>365*2 AND
																								risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_disp,ut.DaysInNYears(10), le.historydate));
		
		SELF.BJL.bk_count30 := (integer)Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)SELF.BJL.date_last_seen,30);
		SELF.BJL.bk_count90 := (integer)Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)SELF.BJL.date_last_seen,90);
		SELF.BJL.bk_count180 := (integer)Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)SELF.BJL.date_last_seen,180);
		SELF.BJL.bk_count12 := (integer)Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)SELF.BJL.date_last_seen,ut.DaysInNYears(1));
		SELF.BJL.bk_count24 := (integer)Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)SELF.BJL.date_last_seen,ut.DaysInNYears(2));
		SELF.BJL.bk_count36 := (integer)Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)SELF.BJL.date_last_seen,ut.DaysInNYears(3));
		SELF.BJL.bk_count60 := (integer)Risk_Indicators.iid_constants.checkingDays(myGetDate,(STRING8)SELF.BJL.date_last_seen,ut.DaysInNYears(5));
		SELF.BJL.bk_chapter := ri.chapter;
		SELF.bk_disp_date := max((INTEGER)ri.date_filed, 
				if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0));
		//these new fields for BS 5.3 are populated in the next join - default here
		SELF.BJL.bk_count12_6mos := 0;
		SELF.BJL.bk_count12_12mos := 0;
		SELF.BJL.bk_count12_24mos := 0;
		SELF := le;
	END;

	bankrupt_full_roxie := JOIN (bankrupt_added_after_withdrawn_check, bans_search,
							LEFT.bk_tmsid<>'' AND
							keyed(LEFT.bk_tmsid = RIGHT.tmsid) AND
							right.name_type='D' and
						 (unsigned)right.did=left.did and
						 (unsigned)(RIGHT.date_filed[1..6]) < left.historydate and
							if(insurance_fcra_filter and right.chapter in ['7','13'],
								FCRA.bankrupt_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter, insurance_fcra_filter),
								FCRA.bankrupt_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter)),
							get_bankrupt_FCRA (LEFT,RIGHT),
							LEFT OUTER, ATMOST(Riskwise.max_atmost), keep(100));

	bankrupt_full_thor_tmsid := JOIN (distribute(bankrupt_added_after_withdrawn_check(bk_tmsid <> ''), hash64(bk_tmsid)), 
							distribute(pull(bans_search(name_type='D')), hash64(tmsid)),
						 LEFT.bk_tmsid = RIGHT.tmsid AND
						 (unsigned)right.did=left.did and
						 (unsigned)(RIGHT.date_filed[1..6]) < left.historydate and
							if(insurance_fcra_filter and right.chapter in ['7','13'],
								FCRA.bankrupt_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter, insurance_fcra_filter),
								FCRA.bankrupt_is_ok(Risk_Indicators.iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter)),
							get_bankrupt_FCRA (LEFT,RIGHT),
							LEFT OUTER, keep(100), LOCAL);
	bankrupt_full_thor := group(sort(bankrupt_added_after_withdrawn_check(bk_tmsid = '') + bankrupt_full_thor_tmsid, seq), seq);

	#IF(onThor)
		bankrupt_full := bankrupt_full_thor;
	#ELSE
		bankrupt_full := bankrupt_full_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_extended roll_bankrupt(Risk_Indicators.Layouts_Derog_Info.layout_extended le, Risk_Indicators.Layouts_Derog_Info.layout_extended ri) := TRANSFORM
		sameBankruptcy := le.case_num=ri.case_num AND le.court_code=ri.court_code;
		SELF.BJL.bankrupt := le.BJL.bankrupt OR ri.BJL.bankrupt;
		boolean takeLeft := le.bjl.date_last_seen >= ri.bjl.date_last_seen;
		
		SELF.BJL.date_last_seen :=  IF (takeLeft, le.bjl.date_last_seen, ri.bjl.date_last_seen);
		SELF.BJL.filing_type := IF (takeLeft, le.bjl.filing_type, ri.bjl.filing_type);//le.BJL.filing_type;
		SELF.BJL.disposition := IF (takeLeft, le.bjl.disposition, ri.bjl.disposition);//le.BJL.disposition;
		SELF.BJL.bk_chapter :=  IF (takeLeft, le.BJL.bk_chapter, ri.bjl.bk_chapter);
		
		SELF.BJL.filing_count := le.BJL.filing_count + IF(sameBankruptcy,0,ri.BJL.filing_count);
		SELF.BJL.filing_count120 := le.BJL.filing_count120 + IF(sameBankruptcy,0,ri.BJL.filing_count120);
		SELF.BJL.bk_recent_count := le.BJL.bk_recent_count + 
									IF(sameBankruptcy,0,ri.BJL.bk_recent_count);
		SELF.BJL.bk_disposed_recent_count := le.BJL.bk_disposed_recent_count + 
									IF(sameBankruptcy,0,ri.BJL.bk_disposed_recent_count);
		SELF.BJL.bk_disposed_historical_count := le.BJL.bk_disposed_historical_count + 
									IF(sameBankruptcy,0,ri.BJL.bk_disposed_historical_count);
		SELF.BJL.bk_disposed_historical_cnt120 := le.BJL.bk_disposed_historical_cnt120 + 
									IF(sameBankruptcy, 0, ri.BJL.bk_disposed_historical_cnt120);
		SELF.BJL.bk_dismissed_recent_count := le.BJL.bk_dismissed_recent_count + 
									IF(sameBankruptcy,0,ri.BJL.bk_dismissed_recent_count);
		SELF.BJL.bk_dismissed_historical_count := le.BJL.bk_dismissed_historical_count + 
									IF(sameBankruptcy,0,ri.BJL.bk_dismissed_historical_count);
		SELF.BJL.bk_dismissed_historical_cnt120 := le.BJL.bk_dismissed_historical_cnt120 + 
									IF(sameBankruptcy, 0, ri.BJL.bk_dismissed_historical_cnt120);
									
		SELF.BJL.bk_count30 := le.BJL.bk_count30 + IF(sameBankruptcy,0,ri.BJL.bk_count30);
		SELF.BJL.bk_count90 := le.BJL.bk_count90 + IF(sameBankruptcy,0,ri.BJL.bk_count90);
		SELF.BJL.bk_count180 := le.BJL.bk_count180 + IF(sameBankruptcy,0,ri.BJL.bk_count180);
		SELF.BJL.bk_count12 := le.BJL.bk_count12 + IF(sameBankruptcy,0,ri.BJL.bk_count12);
		SELF.BJL.bk_count24 := le.BJL.bk_count24 + IF(sameBankruptcy,0,ri.BJL.bk_count24);
		SELF.BJL.bk_count36 := le.BJL.bk_count36 + IF(sameBankruptcy,0,ri.BJL.bk_count36);
		SELF.BJL.bk_count60 := le.BJL.bk_count60 + IF(sameBankruptcy,0,ri.BJL.bk_count60);
		SELF.BJL.bk_count12_6mos := le.BJL.bk_count12_6mos + IF(sameBankruptcy and le.BJL.bk_count12_6mos <> 0,0,ri.BJL.bk_count12_6mos);
		SELF.BJL.bk_count12_12mos := le.BJL.bk_count12_12mos + IF(sameBankruptcy and le.BJL.bk_count12_12mos <> 0,0,ri.BJL.bk_count12_12mos);
		SELF.BJL.bk_count12_24mos := le.BJL.bk_count12_24mos + IF(sameBankruptcy and le.BJL.bk_count12_24mos <> 0,0,ri.BJL.bk_count12_24mos);
		self.case_num := ri.case_num;
		self.court_code := ri.court_code;
		SELF := le;
	END;

	bankrupt_rolled_tmp := ROLLUP(SORT(bankrupt_full,did,court_code,case_num,-BJL.date_last_seen), LEFT.seq = RIGHT.seq and LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT));
	//have to sort by desc disp_date so can keep track of the most recent disp

	bankrupt_disp := DEDUP(SORT(bankrupt_full, seq, did,-bk_disp_date,  -BJL.date_last_seen), seq, did);
	bankrupt_rolled_disp := JOIN(bankrupt_rolled_tmp, bankrupt_disp,
		LEFT.seq = RIGHT.seq and LEFT.did = RIGHT.did,
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_extended, 
			SELF.BJL.date_last_seen := RIGHT.BJL.date_last_seen;
			SELF.BJL.filing_type := RIGHT.BJL.filing_type;
			SELF.BJL.disposition := RIGHT.BJL.disposition;
			SELF.case_num := RIGHT.case_num;
			SELF.court_code := RIGHT.court_code;
			SELF.BJL.bk_chapter := RIGHT.BJL.bk_chapter;
			SELF := LEFT),
		LEFT OUTER);
		
//For BS 5.3 - do process over again using history date + 2 years in order to populate the new offset count12 fields
	Risk_Indicators.Layouts_Derog_Info.layout_extended get_bankrupt_FCRA_offset (Risk_Indicators.Layouts_Derog_Info.layout_extended le, bans_search ri) := TRANSFORM
		myGetDate 			:= iid_constants.myGetDate(le.historydate);
		hit := ri.case_number<>'';
		
		SELF.BJL.bankrupt := false;
		date_last_seen := if(bsversion<50,  max((INTEGER)ri.date_filed, if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0)),(INTEGER) ri.date_filed);//only use the disposed date if not in the future
		SELF.BJL.date_last_seen := date_last_seen;
		SELF.BJL.filing_type := '';
		SELF.BJL.disposition := '';
		SELF.BJL.filing_count := 0;
		SELF.BJL.filing_count120 := 0;
		SELF.BJL.bk_recent_count := 0;
		SELF.BJL.bk_disposed_recent_count := 0;// we are potentially counting some dispositions in the future but not others depending on the dates
		SELF.BJL.bk_disposed_historical_count := 0;
		SELF.BJL.bk_disposed_historical_cnt120 := 0;
		SELF.BJL.bk_dismissed_recent_count := 0;
		SELF.BJL.bk_dismissed_historical_count := 0;
		SELF.BJL.bk_dismissed_historical_cnt120 := 0;
 		SELF.BJL.bk_count30 := 0;
		SELF.BJL.bk_count90 := 0;
		SELF.BJL.bk_count180 := 0;
		SELF.BJL.bk_count12 := 0;
		SELF.BJL.bk_count24 := 0;
		SELF.BJL.bk_count36 := 0;
		SELF.BJL.bk_count60 := 0;
		SELF.BJL.bk_chapter := '';
		SELF.bk_disp_date := 0;
		SELF.BJL.bk_count12_6mos := if(le.archive_date_6mo = '99999999', -1, (integer)Risk_Indicators.iid_constants.checkingDays(le.archive_date_6mo,ri.date_filed,ut.DaysInNYears(1)));
		SELF.BJL.bk_count12_12mos := if(le.archive_date_12mo = '99999999', -1, (integer)Risk_Indicators.iid_constants.checkingDays(le.archive_date_12mo,ri.date_filed,ut.DaysInNYears(1)));
		SELF.BJL.bk_count12_24mos := if(le.archive_date_24mo = '99999999', -1, (integer)Risk_Indicators.iid_constants.checkingDays(le.archive_date_24mo,ri.date_filed,ut.DaysInNYears(1)));
		SELF := le;
	END;

	bankrupt_full_offset_roxie := JOIN (bankrupt_added, bans_search,
							LEFT.bk_tmsid<>'' AND
							keyed(LEFT.bk_tmsid = RIGHT.tmsid) AND
							right.name_type='D' and
						 (unsigned)right.did=left.did and
						 (unsigned)(RIGHT.date_filed[1..6]) < (left.historydate + 200) and
							if(insurance_fcra_filter and right.chapter in ['7','13'],
								FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter, insurance_fcra_filter),
								FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter)),
							get_bankrupt_FCRA_offset (LEFT,RIGHT),
							LEFT OUTER, ATMOST(Riskwise.max_atmost), keep(100));

	bankrupt_full_offset_thor := JOIN (distribute(bankrupt_added(bk_tmsid<>''), hash64(bk_tmsid)), 
              distribute(pull(bans_search), hash64(tmsid)),
							(LEFT.bk_tmsid = RIGHT.tmsid) AND
							right.name_type='D' and
						 (unsigned)right.did=left.did and
						 (unsigned)(RIGHT.date_filed[1..6]) < (left.historydate + 200) and
							if(insurance_fcra_filter and right.chapter in ['7','13'],
								FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter, insurance_fcra_filter),
								FCRA.bankrupt_is_ok(iid_constants.myGetDate(left.historydate), right.date_filed, left.insurance_bk_filter)),
							get_bankrupt_FCRA_offset (LEFT,RIGHT),
							LEFT OUTER, ATMOST(LEFT.bk_tmsid = RIGHT.tmsid, Riskwise.max_atmost), keep(100), LOCAL) +
              bankrupt_added(bk_tmsid='');
                
   #if(onThor)
      bankrupt_full_offset := bankrupt_full_offset_thor;
   #else
      bankrupt_full_offset := bankrupt_full_offset_roxie;
   #end
              
              
	Risk_Indicators.Layouts_Derog_Info.layout_extended roll_bankrupt_offset(Risk_Indicators.Layouts_Derog_Info.layout_extended le, Risk_Indicators.Layouts_Derog_Info.layout_extended ri) := TRANSFORM
		sameBankruptcy := le.case_num=ri.case_num AND le.court_code=ri.court_code;
		boolean takeLeft := le.bjl.date_last_seen >= ri.bjl.date_last_seen;
		SELF.BJL.date_last_seen :=  IF (takeLeft, le.bjl.date_last_seen, ri.bjl.date_last_seen);
		SELF.BJL.bk_count12_6mos := if(le.archive_date_6mo = '99999999', -1, le.BJL.bk_count12_6mos + IF(sameBankruptcy,0,ri.BJL.bk_count12_6mos));
		SELF.BJL.bk_count12_12mos := if(le.archive_date_12mo = '99999999', -1, le.BJL.bk_count12_12mos + IF(sameBankruptcy,0,ri.BJL.bk_count12_12mos));
		SELF.BJL.bk_count12_24mos := if(le.archive_date_24mo = '99999999', -1, le.BJL.bk_count12_24mos + IF(sameBankruptcy,0,ri.BJL.bk_count12_24mos));
		SELF := le;
	END;

	bankrupt_rolled_offset := ROLLUP(SORT(bankrupt_full_offset,did,court_code,case_num,-BJL.date_last_seen), LEFT.seq = RIGHT.seq and LEFT.did=RIGHT.did, roll_bankrupt_offset(LEFT,RIGHT));

	bankrupt_with_offset := JOIN(bankrupt_rolled_disp, bankrupt_rolled_offset,
		LEFT.seq = RIGHT.seq and LEFT.did = RIGHT.did,
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_extended, 
		SELF.BJL.bk_count12_6mos := RIGHT.BJL.bk_count12_6mos;
		SELF.BJL.bk_count12_12mos := RIGHT.BJL.bk_count12_12mos;
		SELF.BJL.bk_count12_24mos := RIGHT.BJL.bk_count12_24mos;
		SELF := LEFT),
		LEFT OUTER);

	bankrupt_rolled := map(bsVersion < 50			=> group(bankrupt_rolled_tmp, seq), 
												 bsVersion < 53			=> group(bankrupt_rolled_disp, seq),
																							 group(bankrupt_with_offset, seq));

	// output(ids, named('BK_input'));
	// output(bankrupt_full, named('bankrupt_full'));
	// output(bankrupt_rolled_tmp, named('bankrupt_rolled_tmp'));	
	// output(bankrupt_disp, named('bankrupt_disp'));	
	// output(bankrupt_rolled_disp, named('bankrupt_rolled_disp'));	
	// output(bankrupt_full_offset, named('bankrupt_full_offset'));	
	// output(bankrupt_rolled_offset, named('bankrupt_rolled_offset'));	
	// output(bankrupt_with_offset, named('bankrupt_with_offset'));	
	// output(bankrupt_rolled, named('bankrupt_rolled'));	
	
	RETURN bankrupt_rolled;
	
END;
		