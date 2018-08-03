import _Control, doxie_files, FCRA, ut, BankruptcyV3, riskwise, Risk_Indicators, STD;
onThor := _Control.Environment.OnThor;

EXPORT Boca_Shell_Bankruptcy_FCRA(integer bsVersion, unsigned8 BSOptions=0, 
				GROUPED DATASET(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus) w_corrections) := function

  todaysdate := (string) risk_indicators.iid_constants.todaydate;
	insurance_fcra_filter :=  (BSOptions & Risk_Indicators.iid_constants.BSOptions.InsuranceFCRAMode) > 0;

	bans_did := BankruptcyV3.key_bankruptcyV3_did(true);
	bans_Withdrawn_Status := BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,TRUE);	
	bans_search := BankruptcyV3.key_bankruptcyv3_search_full_bip(true);

	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus add_bankrupt (Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, 
		bans_did ri) := TRANSFORM
		// blank out the bk IDs on corrections so we don't pull back the regular roxie data
		correction_exists := (TRIM (ri.court_code) + ri.case_number IN le.bankrupt_correct_cccn) or ri.case_number in set(le.bk_corrections, case_number);
		self.bk_tmsid := if(correction_exists, '', ri.tmsid);
		SELF.court_code := if(correction_exists, '', ri.court_code);
		SELF.case_num := if(correction_exists, '', ri.case_number);
		SELF := le;
		SELF := [];
	END;

	bankrupt_added_roxie := JOIN (w_corrections, bans_did,
		left.did<>0 and keyed(LEFT.did=RIGHT.did), add_bankrupt(LEFT,RIGHT), 
		atmost(riskwise.max_atmost), left OUTER, KEEP(10));

	bankrupt_added_thor_did := JOIN (distribute(w_corrections(did<>0), hash64(did)), 
		distribute(pull(bans_did), hash64(did)),
		LEFT.did=RIGHT.did, add_bankrupt(LEFT,RIGHT), 
		atmost(riskwise.max_atmost), left OUTER, KEEP(10), LOCAL);
	bankrupt_added_thor := group(sort(w_corrections(did=0) + bankrupt_added_thor_did, did, LOCAL), did, LOCAL);

	#IF(onThor)
		bankrupt_added := bankrupt_added_thor;
	#ELSE
		bankrupt_added := bankrupt_added_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus getWithdrawnCheck(bankrupt_added le, bans_Withdrawn_Status ri) := TRANSFORM
		// blank out the TMSID if found on withdrawn key so the next join doesn't hit the search file
		// per the requirements document, we only want to remove the withdrawn bankruptcy on version 3.0 and higher
		self.bk_tmsid := if(ri.tmsid<>'' and bsversion >= 3, '', le.bk_tmsid);
		self := le;
	END;
	
	bankrupt_added_after_withdrawn_check_roxie := JOIN (bankrupt_added, bans_Withdrawn_Status,
							LEFT.bk_tmsid<>'' AND
							keyed(LEFT.bk_tmsid = RIGHT.tmsid) AND
							(unsigned)right.did=left.did, 									
							getWithdrawnCheck(LEFT, RIGHT), 
							left outer, atmost(riskwise.max_atmost), keep(1));

	bankrupt_added_after_withdrawn_check_thor := JOIN (distribute(bankrupt_added(bk_tmsid<>''), hash64(bk_tmsid)), 
							distribute(pull(bans_Withdrawn_Status), hash64(tmsid)),
							LEFT.bk_tmsid = RIGHT.tmsid AND
							(unsigned)right.did=left.did, 									
							getWithdrawnCheck(LEFT, RIGHT), 
							left outer, atmost(riskwise.max_atmost), keep(1), LOCAL) +
							bankrupt_added(bk_tmsid='');
							
	#IF(onThor)
		bankrupt_added_after_withdrawn_check := group(sort(bankrupt_added_after_withdrawn_check_thor, seq),seq);
	#ELSE
		bankrupt_added_after_withdrawn_check := bankrupt_added_after_withdrawn_check_roxie;
	#END
  
	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus get_bankrupt_FCRA (Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, 
		bans_search ri) := TRANSFORM
		myGetDate := iid_constants.myGetDate(le.historydate);
		SELF.BJL.bankrupt := ri.case_number<>'';
		date_last_seen := if(bsversion<50, MAX((INTEGER)ri.date_filed, if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0)), (INTEGER) ri.date_filed);//only use the disposed date if not in the future
		SELF.BJL.date_last_seen := date_last_seen;
		SELF.BJL.filing_type := ri.filing_type;
		SELF.BJL.disposition := ri.disposition;
		hit := ri.case_number<>'';
		SELF.BJL.filing_count := (INTEGER)hit;
		SELF.BJL.filing_count120 := if(hit, (integer)risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)date_last_seen,ut.DaysInNYears(10), le.historydate), 0);
		SELF.BJL.bk_recent_count := (INTEGER)(hit AND ri.disposition='');
		date_disp := if(bsversion<50, (INTEGER) ri.discharged, date_last_seen);

		SELF.BJL.bk_disposed_recent_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp, myGetDate)<365*2+1);// we are potentially counting some dispositions in the future but not others depending on the dates
		SELF.BJL.bk_disposed_historical_count := (INTEGER)(ri.disposition<>'' AND ut.DaysApart((string) date_disp, myGetDate)>365*2);
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
		SELF.bk_chapters := dataset([{ri.chapter}], risk_indicators.Layouts_Derog_Info.layout_bk_chapter);
		SELF.bk_disp_date := MAX((INTEGER)ri.date_filed, 
				if((INTEGER)ri.discharged[1..6] < le.historydate, (INTEGER)ri.discharged, 0));
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
  
	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus roll_bankrupt(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le, 
		Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus ri) := TRANSFORM
		sameBankruptcy := le.case_num=ri.case_num AND le.court_code=ri.court_code;

		SELF.BJL.bankrupt := le.BJL.bankrupt OR ri.BJL.bankrupt;
		
		boolean takeLeft := le.bjl.date_last_seen >= ri.bjl.date_last_seen;
		SELF.bjl.date_last_seen := IF (takeLeft, le.bjl.date_last_seen, ri.bjl.date_last_seen);
		SELF.bjl.filing_type := IF (takeLeft, le.bjl.filing_type, ri.bjl.filing_type);
		SELF.bjl.disposition := IF (takeLeft, le.bjl.disposition, ri.bjl.disposition);
		SELF.BJL.bk_chapter :=  IF (takeLeft, le.BJL.bk_chapter, ri.bjl.bk_chapter);
		SELF.bk_chapters :=  le.bk_chapters + ri.bk_chapters;  

		SELF.BJL.filing_count := le.BJL.filing_count + IF(sameBankruptcy,0,ri.BJL.filing_count);
		SELF.BJL.filing_count120 := le.BJL.filing_count120 + IF(sameBankruptcy, 0, ri.BJL.filing_count120);
			
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

		self.case_num := ri.case_num;
		self.court_code := ri.court_code; 
		SELF := le;
	END;

	w_bk_tmp := ROLLUP(SORT(bankrupt_full,did,court_code,case_num,-BJL.date_last_seen), LEFT.did=RIGHT.did, roll_bankrupt(LEFT,RIGHT));

	//have to sort by desc disp_date so can keep track of the most recent disp
	w_bk_disp := DEDUP(SORT(bankrupt_full, seq, did,-bk_disp_date,  -BJL.date_last_seen), seq, did);
	w_bk_rolled_disp := JOIN(w_bk_tmp, w_bk_disp,
		LEFT.seq = RIGHT.seq and LEFT.did = RIGHT.did,
		TRANSFORM(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus, 
			SELF.BJL.date_last_seen := RIGHT.BJL.date_last_seen;
			SELF.BJL.filing_type := RIGHT.BJL.filing_type;
			SELF.BJL.disposition := RIGHT.BJL.disposition;
			SELF.case_num := RIGHT.case_num;
			SELF.court_code := RIGHT.court_code;
			SELF.BJL.bk_chapter := RIGHT.BJL.bk_chapter;
      self.bk_chapters := dedup(left.bk_chapters);
			SELF := LEFT),
		LEFT OUTER);
	w_bk := if(bsVersion < 50, w_bk_tmp, group(w_bk_rolled_disp, seq));


	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus correct_bk(Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus le) :=	TRANSFORM
	// choose between current or correction as latest bankruptcy; if same date, then we can choose
	// between preserving "type", "disposition" or override "supremacy" (former implemented).
			last_corr := le.bk_corrections[1]; //latest correction, they're already sorted by date.
			last_seen_corr := MAX((INTEGER) last_corr.date_filed, (INTEGER)last_corr.disposed_date);
			boolean takeCorrection := (last_seen_corr > le.BJL.date_last_seen);

			SELF.BJL.bankrupt := IF (takeCorrection, TRUE, le.BJL.bankrupt);
			SELF.BJL.date_last_seen:= IF (takeCorrection, last_seen_corr, le.BJL.date_last_seen);
			SELF.BJL.filing_type := IF (takeCorrection, last_corr.filing_type, le.BJL.filing_type);
			SELF.BJL.disposition := IF (takeCorrection, last_corr.disposition, le.BJL.disposition);

			// add aggregates from corrections
			SELF.BJL.filing_count    := le.BJL.filing_count    + COUNT(le.bk_corrections);
			SELF.BJL.filing_count120 := le.BJL.filing_count120 + COUNT(le.bk_corrections);	
			SELF.BJL.bk_recent_count := le.BJL.bk_recent_count + COUNT (le.bk_corrections (disposition=''));
			SELF.BJL.bk_disposed_recent_count     := le.BJL.bk_disposed_recent_count + 
																							 COUNT(le.bk_corrections (disposition<>'' AND (ut.DaysApart(disposed_date,todaysdate)<365*2+1)));
			SELF.BJL.bk_disposed_historical_count := le.BJL.bk_disposed_historical_count + 
																							 COUNT(le.bk_corrections(disposition<>'' AND (ut.DaysApart(disposed_date,todaysdate)>365*2)));
			SELF.BJL.bk_disposed_historical_cnt120 := le.BJL.bk_disposed_historical_cnt120 + 
																							 COUNT(le.bk_corrections(disposition<>'' AND (ut.DaysApart(disposed_date,todaysdate)>365*2)));
			SELF.BJL.bk_dismissed_recent_count     := le.BJL.bk_dismissed_recent_count + 
																							 COUNT(le.bk_corrections (StringLib.StringToUpperCase(disposition)='DISMISSED' AND (ut.DaysApart(disposed_date,todaysdate)<365*2+1)));
			SELF.BJL.bk_dismissed_historical_count := le.BJL.bk_dismissed_historical_count + 
																							 COUNT(le.bk_corrections(StringLib.StringToUpperCase(disposition)='DISMISSED' AND (ut.DaysApart(disposed_date,todaysdate)>365*2)));
			SELF.BJL.bk_dismissed_historical_cnt120 := le.BJL.bk_dismissed_historical_cnt120 + 
																							 COUNT(le.bk_corrections(StringLib.StringToUpperCase(disposition)='DISMISSED' AND (ut.DaysApart(disposed_date,todaysdate)>365*2)));
			self.BJL.bk_chapter := IF (takeCorrection, last_corr.chapter, le.BJL.bk_chapter);	
			self := le;
		END;
		w_bk_correct := PROJECT(w_bk, correct_bk(LEFT));
		    
		RETURN w_bk_correct;
END;
		
