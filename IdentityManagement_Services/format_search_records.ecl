/**
This attribute transforms input header slimmed record to a required iesp layout.
Input is scattered to name, ssn e.t.c. and finally sorted by penalty.
**/

IMPORT iesp, ut, Address, doxie, AutoStandardI;


EXPORT format_search_records(DATASET(layouts.slimrec) slimmed_header_recs) := FUNCTION

// Name transform 
	layouts.NameRec_penalty name_penalt(layouts.NameRec L):= TRANSFORM
		SELF.penalty_name := doxie.FN_Tra_Penalty_Name(L.fname, L.mname, L.lname);
		SELF := L;
	END;

	iesp.share.t_Name setname(layouts.NameRec_penalty L) := TRANSFORM
		name := ROW({'',l.fname, l.mname, l.lname, l.name_suffix, l.title}, iesp.share.t_Name);
		SELF := name;
	END;

// SSN transform
	layouts.SSNRec_penalty ssn_penalt(layouts.SSNRec L):= TRANSFORM
		SELF.penalty_ssn := doxie.FN_Tra_Penalty_SSN(L.ssn);
		SELF := L;
	END;

	iesp.share.t_SSNInfo setSSN(layouts.SSNRec_penalty L) := TRANSFORM
		SELF.valid		:=	IF(L.valid_ssn IN ['G','M'] , 'Y','N');
		SELF.SSN		  :=	L.SSN;
		//Added for bug: 165034
		SELF.IssuedLocation  := L.ssn_issue_state;
		SELF.IssuedStartDate := iesp.ECL2ESP.toDate(L.ssn_issue_early_fulldate);
		SELF.IssuedEndDate   := iesp.ECL2ESP.toDate(L.ssn_issue_last_fulldate);
	END;

// DOB transform
	layouts.DOBRec_penalty DOB_penalt(layouts.DOBRec L):= TRANSFORM
		SELF.penalty_dob := doxie.FN_Tra_Penalty_dob((string)L.dob);
		SELF := L;
	END;

	iesp.share.t_Date setDOB(layouts.DOBRec_penalty L) := TRANSFORM
		DOB 	:= iesp.ECL2ESP.toDate(L.dob);
		SELF		:=	DOB;
	END;

// Address transform
	REAL weight_address (layouts.AddrRec addr) := FUNCTION //This will assign score based on addr components.
				REAL absolute_score := 
				IF(addr.prim_range != '',  2.0, 0.0) +
				IF(addr.prim_name  != '',  2.0, 0.0) + 
				// IF(addr.sec_range  != '',  1.0, 0.0) +
				IF(addr.predir     != '', 0.25, 0.0) +
				IF(addr.postdir    != '', 0.25, 0.0) +
				IF(addr.suffix     != '', 0.25, 0.0);
			RETURN MIN(absolute_score, 4.0); // Addresses with the score higher than certain threshold will get same "good enough" score.
		END;

		// tri-state: left is better, right is better, or equal.
		INTEGER CompareAddresses (layouts.AddrRec l_addr, layouts.AddrRec r_addr) := FUNCTION
			cnt_left := weight_address (l_addr);
			cnt_right := weight_address (r_addr);
			RETURN MAP(cnt_left > cnt_right => -1,
								 cnt_left < cnt_right => 1,
								 0);
    END;

	layouts.AddrRec rolladdress(layouts.AddrRec L, layouts.AddrRec R) := TRANSFORM
			ca := CompareAddresses (L, R);
			min_first := IF(R.dt_first_seen = 0 OR (L.dt_first_seen >0 AND L.dt_first_seen < R.dt_first_seen), L.dt_first_seen, R.dt_first_seen);
			SELF.dt_first_seen := CASE(ca, -1 => L.dt_first_seen, 1 => R.dt_first_seen, min_first);
			SELF.dt_last_seen := CASE(ca, -1 => L.dt_last_seen, 1 => R.dt_last_seen, MAX(L.dt_last_seen, R.dt_last_seen));
			SELF.prim_range := IF(L.prim_range <> '', L.prim_range, R.prim_range);
			SELF.prim_name := IF(L.prim_name <> '', L.prim_name, R.prim_name);
			SELF.predir := IF(L.predir <> '', L.predir, R.predir);
			SELF.suffix := IF(L.suffix <> '', L.suffix, R.suffix);
			SELF.postdir := IF(L.postdir <> '', L.postdir, R.postdir);
			SELF.unit_desig := IF(LENGTH(L.unit_desig) > LENGTH(R.unit_desig), L.unit_desig, R.unit_desig);
			SELF.sec_range := IF(L.sec_range <> '', L.sec_range, R.sec_range);
			SELF.city_name := IF(L.city_name <> '', L.city_name, R.city_name);
			SELF.st := IF(L.st <> '', L.st, R.st);
			SELF.zip := IF(L.zip <> '', L.zip, R.zip);	
			SELF.zip4 := IF(L.zip4 <> '', L.zip4, R.zip4);
			SELF.geo_blk := IF(L.zip4 <> '' AND L.geo_blk <> '', L.geo_blk, R.geo_blk);// Prefer a populated geo_block from a cleaned address(zip4)
			SELF.county_name := IF(L.county_name <> '', L.county_name, R.county_name);
			SELF := L; // dt_nonglb_last_seen
	END;

	layouts.AddrRec_penalty addr_penalt(layouts.AddrRec L):= TRANSFORM
		pen := doxie.FN_Tra_Penalty_Addr(L.predir, L.prim_range, L.prim_name, L.suffix, L.postdir, L.sec_range,
																		L.city_name, L.st, L.zip);
    progress_pen := round (log(pen-10) / log(2));
    scaled_penalty := if (pen <=10, pen, 10 + progress_pen);
		SELF.penalty_addr := scaled_penalty;
		SELF := L;
	END;

	glb_ok := AutoStandardI.InterfaceTranslator.glb_ok.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_ok.params));
	isKnowx := ut.IndustryClass.is_knowx;

	iesp.identitymanagementsearch.t_IDMSearchAddress setAddress(layouts.AddrRec_penalty L) := TRANSFORM
			SELF.DateFirstSeen := iesp.ECL2ESP.toDateYM(L.dt_first_seen),
																	DtLastSeen := MAP(~glb_ok AND ~isKnowx => L.dt_nonglb_last_seen,L.dt_last_seen <> 0 => L.dt_last_seen,0);
			SELF.DateLastSeen := iesp.ECL2ESP.toDateYM(DtLastSeen),
			addr := iesp.ECL2ESP.SetAddressEx (L.prim_name,L.prim_range, L.predir, L.postdir,
																				 L.suffix, L.unit_desig, L.sec_range,
																				 L.city_name,L.st, L.zip, L.zip4,
																				 L.county_name,
																				 '',	//Postal Code,
																				 Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.suffix, 
																																		 L.postdir, L.unit_desig, L.sec_range), //addr1
																				 '', //addr2
																				 Address.Addr2FromComponents(L.city_name, L.st, L.zip),
                                         hris := project(L.hri_address,TRANSFORM(iesp.share.t_RiskIndicator,SELF.riskcode:=LEFT.hri,
																				                 SELF.description:=LEFT.desc)));
		SELF.Address := addr;
	END;

// Phone transform
	layouts.PhoneRec_penalty Phone_penalt(layouts.PhoneRec L):= TRANSFORM
		SELF.penalty_phone := doxie.FN_Tra_Penalty_phone((STRING)L.phone);
		SELF := L;
	END;

	iesp.identitymanagementsearch.t_IdmSearchPhoneInfo setPhone(layouts.PhoneRec_penalty L):= TRANSFORM
		Phone 	:= ROW({L.phone, L.listed_name},iesp.identitymanagementsearch.t_IdmSearchPhoneInfo);
		SELF		:=	Phone;
	END;

	grouped_recs := GROUP(SORT(slimmed_header_recs, did), did);

	iesp.identitymanagementsearch.t_IDMSearchRecord doRollup(grouped_recs L, DATASET(layouts.slimrec) allRecs) := TRANSFORM

		// Slim down Header records , SORT, DEDUP each slimmed section
		slimmed_to_name  := DEDUP(SORT(PROJECT(allRecs,layouts.NameRec),lname, fname, mname), lname, fname, mname);
		slimmed_to_ssn 	 := DEDUP(SORT(PROJECT(allRecs,layouts.SSNRec), ssn), ssn)(SSN<>'');
		addr_to_rollup 	 := SORT(PROJECT(allRecs,layouts.AddrRec),prim_range, prim_name, sec_range);
		slimmed_to_addr  := ROLLUP(addr_to_rollup,rolladdress(LEFT,RIGHT), 
															ut.nneq(LEFT.zip, RIGHT.zip), 
															ut.nneq(LEFT.city_name, RIGHT.city_name), 
															ut.nneq(LEFT.st, RIGHT.st),  
															ut.nneq(LEFT.prim_name, RIGHT.prim_name), 
															ut.nneq(LEFT.prim_range, RIGHT.prim_range),
															ut.nneq(LEFT.suffix, RIGHT.suffix),
															ut.nneq(LEFT.predir, RIGHT.predir),
															ut.nneq(LEFT.postdir, RIGHT.postdir),
															ut.nneq(LEFT.sec_range, RIGHT.sec_range))((zip <> '') OR (city_name <> '' AND st <> ''));
		slimmed_to_DOB   := DEDUP(SORT(PROJECT(allRecs,layouts.DOBRec), dob), dob)(dob <>0);
		slimmed_to_phone := DEDUP(SORT(PROJECT(allRecs,layouts.PhoneRec), phone), phone)(phone <> '');

		// Add penalty
		penalize_name 	:= PROJECT(slimmed_to_name, name_penalt(LEFT));
		penalize_addr		:= PROJECT(slimmed_to_addr, addr_penalt(LEFT));
		penalize_ssn		:= PROJECT(slimmed_to_ssn, ssn_penalt(LEFT));
		penalize_dob		:= PROJECT(slimmed_to_DOB, dob_penalt(LEFT));
		penalize_phone	:= PROJECT(slimmed_to_phone, phone_penalt(LEFT));

		// SORT finally by penalty (except address)
		penalized_name 	:= SORT(penalize_name, penalty_name);
		penalized_addr 	:= SORT(penalize_addr, -dt_last_seen, -dt_first_seen);
		penalized_ssn  	:= SORT(penalize_ssn, penalty_ssn);
		penalized_dob  	:= SORT(penalize_dob, penalty_dob);
		penalized_phone	:= SORT(penalize_phone, penalty_phone);
		penalized_did		:= doxie.FN_Tra_Penalty_did((STRING)L.did);

		// Fill in columns now.
		SELF._penalty := MIN(penalized_name,penalty_name) + MIN(penalized_ssn,penalty_ssn) + MIN(penalized_addr,penalty_addr) +
										 MIN(penalized_phone,penalty_phone) + MIN(penalized_dob,penalty_dob) + MIN(penalized_did);
		SELF.SecondaryPenalty := IF(penalized_ssn[1].valid_ssn IN['G','M'], 0, 1);
		SELF.names 			:= CHOOSEN(PROJECT(penalized_name, setname(LEFT)), iesp.Constants.BPS.ROLLUP_MAX_COUNT_NAMES);
		SELF.ssns				:= CHOOSEN(PROJECT(penalized_ssn, setSSN(LEFT)), iesp.Constants.BPS.ROLLUP_MAX_COUNT_SSNS);
		SELF.DOBs				:= CHOOSEN(PROJECT(penalized_dob, setDOB(LEFT)),iesp.Constants.BPS.ROLLUP_MAX_COUNT_DATES); // ut.NNEQ_Date((LEFT.year + LEFT.Month + LEFT.DAY),(RIGHT.year + RIGHT.Month + RIGHT.DAY))),
		SELF.Addresses	:= CHOOSEN(PROJECT(penalized_addr, setAddress(LEFT)), iesp.Constants.BPS.ROLLUP_MAX_COUNT_ADDRESSES);
		SELF.phones 		:= CHOOSEN(PROJECT(penalize_phone, setPhone(LEFT)),iesp.Constants.BPS.ROLLUP_MAX_COUNT_PHONES);
		SELF.UniqueId		:= (STRING)L.did;
		SELF.DOD				:= iesp.ECL2ESP.toDate((INTEGER)L.DOD); // TODO: Do we need doxie_raw.death_raw here - dataland: W20140624-155338?
		SELF.deceased		:= IF(L.death_code IN IdentityManagement_Services.Constants.DeathCodes, 'Y' ,'N');
		SELF.gender			:= iesp.ECL2ESP.GetGender(L.title);
		SELF.weight			:= 0; // internal SALT field
		SELF.score			:= 0; // internal SALT field
		SELF.fetchcode	:= 0; // internal Header field, will be filled in later
	END;

	idm_formatted_recs := ROLLUP(grouped_recs, GROUP, doROLLUP(LEFT, ROWS(LEFT)));
	
RETURN(idm_formatted_recs);
/**
// DEBUG:
// OUTPUT(slimmed_recs,NAMED('slimmed_recs'));
// OUTPUT(grouped_recs,NAMED('grouped_recs_did'));

// Here is example(using SSN) of whats going within transform doRollup. Replicate for others to debug.
// slimmed_to_ssn := PROJECT(grouped_recs,TRANSFORM(layouts.SSNRec, SELF := LEFT ,SELF := [])); // []= ssn_issue_early, ssn_issue_last , ssn_issue_last
// penalize_ssn		:= PROJECT(slimmed_to_ssn(SSN <> ''), ssn_penalt(LEFT));
// penalized_ssn	:= SORT(DEDUP(SORT(penalize_ssn, ssn), ssn), penalty_ssn);
// penalty_by_ssn := MIN(penalized_ssn[1].penalty_ssn);

// OUTPUT(slimmed_to_ssn,NAMED('slimmed_to_ssn'));
// OUTPUT(penalize_ssn,NAMED('penalize_ssn'));
// OUTPUT(penalty_by_ssn,NAMED('penalty_by_ssn'));
**/

END;