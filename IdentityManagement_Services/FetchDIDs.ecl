/**
This attribute executes joins using input criteria to fetch DIDs/Identity.
Dids from all joins are combined. This also handles error codes/On Fail.
**/

IMPORT IdentityManagement_Services, AutoHeaderV2, doxie, dx_header, ut, NID, AutoStandardI, DriversV2;

EXPORT FetchDIDs(DATASET(IdentityManagement_Services.layouts.layout_cleaner) in_criteria) := FUNCTION
	// ====== Add Common Code Here- all at one place only: ======= //

	cleaned_inputs := PROJECT(in_criteria,TRANSFORM(IdentityManagement_Services.layouts.layout_cleaner, SELF.tdob.Fuzzy_DOB := FALSE, SELF := LEFT));
  _row := cleaned_inputs[1];

	// main search components -SSN, name, address, dob, phone.
	_ssn 				:= _row.tssn.ssn;
  _lname 			:= _row.tname.lname;
  _fname 			:= _row.tname.fname;	
  _mname 			:= _row.tname.mname;	
  _dob 				:= _row.tdob.dob;
	_phone 			:= _row.tphone.phone10;
	_dph_lname	:= metaphonelib.DMetaPhone1(_lname)[1..6];

	// addr components:
	_state			:= _row.taddress.state;
	_zip5				:= _row.taddress.zip5;
	_city				:= _row.taddress.city;
	_prim_range := _row.taddress.prim_range;
	_prim_name 	:= _row.taddress.prim_name;
	_sec_range	:= _row.taddress.sec_range;
	_prim_range_set		:= _row.taddress.prim_range_set;
	_zip_set_zip_set	:= _row.taddress.zip_set;
  // extended zips: zips by city/state may be appended; note that zip codes are prepended with zeros, if needed.
  all_zips := _zip_set_zip_set + if (_state <> '' and _city <>'', ut.ZipsWithinCity(_state,_city), []);
  extended_zips := SET(PROJECT(DATASET(all_zips, {INTEGER4 zip}), TRANSFORM({STRING5 zip},SELF.zip := INTFORMAT(LEFT.zip, 5, 1))), zip);

	// set of Name components:
	_lname_set	:= _row.tname.lname_set;
	_fname_set	:= _row.tname.fname_set;

	// driver license components:
	_dlnumber := _row.tdl.dl_num;
	_dlstate	 := _row.tdl.dl_st;
	
  // implementation for joins: saving fail, skip, not found conditions
   AutoHeaderV2.layouts.search_out seterrors(integer key_hit, integer err_code) := TRANSFORM
			SELF.did := 0;
			SELF.fetch_hit := Key_hit;
			SELF.index_hit := 0;
			SELF.status := IF(err_code = 203, AutoHeaderV2.Constants.STATUS._FAIL, AutoHeaderV2.Constants.STATUS._NOT_FOUND);
			SELF.err_code := err_code; // too many records (203) OR No_DATA (0)
   END;	

	not_found_in_key(integer key_hit, integer err_code) := FUNCTION
		not_found	:= DATASET([seterrors(key_hit,err_code)]);
	RETURN not_found;
	END;

  // =============================== by SSN ===============================

	// Modified logic from AutoHeaderV2.fetch_SSN for IDM service
  i_ssn := dx_header.key_ssn();
	
	INTEGER MAX_DIDS_PER_SSNS := Constants.MAX_DIDS_PER_SSNS; //100.Deliberately much lower than in the library search
	BOOLEAN is_full_ssn := LENGTH(TRIM(_ssn))= 9;
	BOOLEAN is_fuzzy := is_full_ssn AND _row.tssn.fuzzy_ssn;
	BOOLEAN do_partial_ssn := is_full_ssn and _lname <> '';
	BOOLEAN is_ssn5 := LENGTH(TRIM(_ssn))= 5;
	BOOLEAN is_ssn4 := LENGTH(TRIM(_ssn))= 4;
	_ssn4						:= if(is_ssn4, TRIM(_ssn), TRIM(_ssn[6..9]));
	_ssn5						:= if(is_ssn5, TRIM(_ssn), TRIM(_ssn[1..5]));

  ds_header_non_fuzzy := i_ssn (KEYED(s1=_ssn[1]), KEYED(s2=_ssn[2]), KEYED(s3=_ssn[3]),
																KEYED(s4=_ssn[4]), KEYED(s5=_ssn[5]), KEYED(s6=_ssn[6]),
																KEYED(s7=_ssn[7]), KEYED(s8=_ssn[8]), KEYED(s9=_ssn[9]));

  ds_header_fuzzy :=
		LIMIT (i_ssn (WILD(s1),					KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),WILD (s2),        KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),WILD(s3),         KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),WILD(s4),         KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),WILD(s5),         KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),WILD(s6),         KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),WILD(s7),         KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),WILD(s8),         KEYED(s9=_ssn[9])), MAX_DIDS_PER_SSNS, SKIP) +
    LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8])), MAX_DIDS_PER_SSNS, SKIP);
	
	ds_header_transposition :=
		LIMIT (i_ssn (KEYED(s1=_ssn[2]),KEYED(s2=_ssn[1]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP) +
		LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[3]),KEYED(s3=_ssn[2]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP) +
		LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[4]),KEYED(s4=_ssn[3]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP) +
		LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[5]),KEYED(s5=_ssn[4]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP) +
		LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[6]),KEYED(s6=_ssn[5]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP) +
		LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[7]),KEYED(s7=_ssn[6]),KEYED(s8=_ssn[8]),KEYED(s9=_ssn[9]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP) +
		LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[8]),KEYED(s8=_ssn[7]),KEYED(s9=_ssn[9]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP) +
		LIMIT (i_ssn (KEYED(s1=_ssn[1]),KEYED(s2=_ssn[2]),KEYED(s3=_ssn[3]),KEYED(s4=_ssn[4]),KEYED(s5=_ssn[5]),KEYED(s6=_ssn[6]),KEYED(s7=_ssn[7]),KEYED(s8=_ssn[9]),KEYED(s9=_ssn[8]),(dph_lname = _dph_lname)), MAX_DIDS_PER_SSNS, SKIP);
	
  //TODO:Join Condition - Do we need to add lastname match to the index read condition - If yes in all SSN Joins?

  // choose and dedup
  perfect_SSN := DEDUP(LIMIT(PROJECT(ds_header_non_fuzzy,
																		TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.SSN)),
															MAX_DIDS_PER_SSNS, ONFAIL(seterrors(AutoHeaderV2.Constants.FetchHit.SSN, 203))),did, all);

  fuzzy_SSN := PROJECT(DEDUP(ds_header_fuzzy,did, all),TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.SSN));

	transposition_SSN := PROJECT(DEDUP(ds_header_transposition,did, all), TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.SSN_TRANSPOSITION));
	
	// Partial SSN Search
	// We now always want to perform Partial SSN search with Full SSN as well
	SSN4 := DEDUP(LIMIT(PROJECT(dx_header.key_SSN4()(KEYED(ssn4 = _ssn4) AND
																										KEYED(_lname = '' OR (lname IN _lname_set))),
																										TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.SSN_PARTIAL)),
											MAX_DIDS_PER_SSNS, ONFAIL(SetErrors(AutoHeaderV2.Constants.FetchHit.SSN_PARTIAL, 203))),did, all);

	SSN5 := DEDUP(LIMIT(PROJECT(dx_header.key_SSN5()(KEYED(ssn5 = _ssn5) AND
																										KEYED(_lname = '' OR (lname IN _lname_set))),
																										TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.SSN_PARTIAL)),
											MAX_DIDS_PER_SSNS, ONFAIL(SetErrors(AutoHeaderV2.Constants.FetchHit.SSN_PARTIAL, 203))),did,all);

	dids_by_ssn_not_found := not_found_in_key(AutoHeaderV2.Constants.FetchHit.SSN, 0);

	dids_by_ssn_found := MAP(is_fuzzy => fuzzy_SSN // AllowSSNTypos
													,is_full_ssn => perfect_SSN
													,is_ssn5 => SSN5
													,is_ssn4 => SSN4
													,DATASET([], AutoHeaderV2.layouts.search_out)) 
											+ if(do_partial_ssn, transposition_SSN + SSN5 + SSN4);
										
	dids_by_ssn := IF(COUNT(dids_by_ssn_found) <= 0, dids_by_ssn_not_found, dids_by_ssn_found); // IF (true, Status = 2(_NOT_FOUND), records found or 203)

  // ============================== by Name ===============================

	// Modified logic from AutoHeaderV2.fetch_name for IDM service
	Name_Hdr_Key := dx_header.key_name();

	temp_lname_trailing_value := _lname != '' AND _fname = '' AND _mname = '';
	temp_fname_trailing_value := _lname != '' AND _fname != '' AND _mname = '';

	IdentityManagement_Services.MAC_lname_fname(Name_Hdr_Key,lname_fil_2,fname_fil_2);

	dids_by_name_found := DEDUP(LIMIT(PROJECT(Name_Hdr_Key( //Limit= 100
																						KEYED(dph_lname=(string6)metaphonelib.DMetaPhone1(_lname)),
																						KEYED(lname_fil_2),
																						KEYED(NID.mod_PFirstTools.SubLinPFR(pfname,_fname) OR LENGTH(TRIM(_fname))<2),
																						WILD(fname),
																						WILD(minit),
																						(_row.tname.nicknames OR fname_fil_2),
																						_mname ='' OR (string1)_mname[1] = minit),
																						TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.NAME)),
																		Constants.MAX_DIDS_PER_NAMES, ONFAIL(SetErrors(AutoHeaderV2.Constants.FetchHit.NAME, 203))),did, all);

	dids_by_name_not_found := not_found_in_key(AutoHeaderV2.Constants.FetchHit.NAME, 0);

	dids_by_name := IF(COUNT(dids_by_name_found) <= 0, dids_by_name_not_found, dids_by_name_found); // IF (true, Status = 2(_NOT_FOUND), records found or 203)

  // =============================== by DOB ===============================

	// Modified logic from AutoHeaderV2.fetch_DOBName for IDM service
  DOB_Hdr_Key := dx_header.key_DOBName();
	IdentityManagement_Services.MAC_lname_fname(DOB_Hdr_Key,lname_fil,fname_fil);

	UNSIGNED8 todays_date 	:= (UNSIGNED8)Stringlib.getDateYYYYMMDD();
	temp_yob_val_low  			:= _row.tdob.dob_low div 10000;
	temp_yob_val_high 			:= _row.tdob.dob_high div 10000;
	temp_dob_val_low_true 	:= temp_yob_val_low * 10000 + (todays_date % 10000);
	temp_dob_val_high_true 	:= temp_yob_val_high * 10000 + (todays_date % 10000);
	UNSIGNED8 temp_mob_val 	:= IF(_dob != 0, (_dob div 100) % 100,0);
	UNSIGNED8 temp_day_val	:= IF(_dob != 0, _dob % 100,0);

	// We need only Fuzzy DOB JOIN logic
	dids_by_dob_found := DEDUP(LIMIT(PROJECT(DOB_Hdr_Key( //Limit= 100
																					KEYED(yob BETWEEN temp_yob_val_low AND temp_yob_val_high) AND
																					KEYED(dph_lname = (string6)metaphonelib.DMetaPhone1(_lname)) AND
																					KEYED(_row.tname.phonetic  OR lname_fil) AND
																					KEYED(NID.mod_PFirstTools.SubLinPFR(DOB_Hdr_Key.pfname,_fname)) AND
																					KEYED(_row.tname.nicknames OR fname_fil) AND
																					KEYED(temp_mob_val = 0 OR mob = temp_mob_val OR (_row.tdob.Fuzzy_DOB AND mob = 0)) AND
																					KEYED(temp_day_val = 0 OR day = temp_day_val OR (_row.tdob.Fuzzy_DOB AND day = 0)) AND
																					// for age range filtering only (bypass this for a dob search)
																					(_dob <> 0 OR (temp_dob_val_low_true <= MAP(dob % 10000 = 0 => dob + 9999,
																																											dob % 100   = 0 => dob + 99,
																																											dob) AND
																					temp_dob_val_high_true >= _dob))),
																					TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.DOBNAME)),
																		Constants.MAX_DIDS_PER_DOBS, ONFAIL(SetErrors(AutoHeaderV2.Constants.FetchHit.DOBNAME, 203))), did, all);

	dids_by_dob_not_found := not_found_in_key(AutoHeaderV2.Constants.FetchHit.DOBNAME, 0);

	dids_by_dob := IF(COUNT(dids_by_dob_found) <= 0, dids_by_dob_not_found, dids_by_dob_found); // IF (true, Status = 2(_NOT_FOUND), records found or 203)



  // =============================== by DOB-fname ===============================
  DOB_fname_hdr_key := 	dx_header.key_DOB_pfname();

	// We need only Fuzzy DOB JOIN logic
  dobfname_fetch := PROJECT (DOB_fname_hdr_key (
                               keyed (NID.mod_PFirstTools.R2inPFL_FirstTwo (_fname, pf2)) AND
                               keyed (dob between _row.tdob.dob_low and _row.tdob.dob_high) AND
                               keyed (NID.mod_PFirstTools.SubLinPFR (pfname,_fname)) AND
                               keyed (st = _state) AND // OR temp_state_value=''
                               keyed (zip IN extended_zips)),
                             transform (AutoHeaderV2.layouts.search_out, 
                                        Self.did := Left.did, Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.DOBFNAME));

//TODO: is dedup needed?
  dids_by_dobfname_found := DEDUP (LIMIT (dobfname_fetch, Constants.MAX_DIDS_PER_DOBS, ONFAIL (SetErrors (AutoHeaderV2.Constants.FetchHit.DOBFNAME, 203))), did, all);

	dids_by_dobfname_not_found := not_found_in_key(AutoHeaderV2.Constants.FetchHit.DOBFNAME, 0);

	dids_by_dobfname := IF(COUNT(dids_by_dobfname_found) > 0, dids_by_dobfname_found, dids_by_dobfname_not_found); // IF (true, Status = 2(_NOT_FOUND), records found or 203)



  // ============================== by Phone ==============================

	// Modified logic from AutoHeaderV2.fetch_phone for IDM service
	is_phone10 := LENGTH(TRIM(_phone))=10;

	// TODO : Join Condition - Do we need (NAME + PHONE) OR only PHONE
	dids_by_phone_found := DEDUP(LIMIT(PROJECT(dx_header.key_phone()(_phone<>'', //Limit= 100
																							KEYED (p7=IF(is_phone10, _phone[4..10], (STRING7)_phone)),
																							KEYED (~is_phone10 OR p3=_phone[1..3])),
																							TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.PHONE)),
																			Constants.MAX_DIDS_PER_PHONES, ONFAIL(SetErrors(AutoHeaderV2.Constants.FetchHit.PHONE, 203))), did, all);

	dids_by_phone_not_found := not_found_in_key(AutoHeaderV2.Constants.FetchHit.PHONE, 0);

	dids_by_phone := IF(COUNT(dids_by_phone_found) <= 0, dids_by_phone_not_found, dids_by_phone_found); // IF (true, Status = 2(_NOT_FOUND), records found or 203)

  // ========================= by Address-State ===========================

	// Modified logic from AutoHeaderV2.fetch_StName for IDM Service
	State_Hdr_Key := dx_header.key_StFnameLname();

	IdentityManagement_Services.MAC_lname_fname(State_Hdr_Key,lname_fil_3,fname_fil_3);

	dids_by_stnm_found := DEDUP(LIMIT(PROJECT(State_Hdr_Key( //Limit= 100
																						KEYED(st = _state),
																						KEYED(dph_lname = (string6)metaphonelib.DMetaPhone1(_lname)),
																						KEYED(lname_fil_3 OR _row.tname.phonetic),
																						KEYED(NID.mod_PFirstTools.SubLinPFR(State_Hdr_Key.pfname,_fname) OR LENGTH(TRIM(_fname))<2),
																						KEYED(fname_fil_3 OR _row.tname.nicknames),
																						s4 = (UNSIGNED)_ssn4 OR NOT is_full_ssn,
																						nofold(s4 = (UNSIGNED2)_ssn[1..4] OR LENGTH(TRIM(_ssn))<>4)),
																						TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.STNAME)),
																		Constants.MAX_DIDS_PER_ADDRS, ONFAIL(SetErrors(AutoHeaderV2.Constants.FetchHit.STNAME, 203))),did, all);

	dids_by_stnm_not_found := not_found_in_key(AutoHeaderV2.Constants.FetchHit.STNAME, 0);

	dids_by_stnm := IF(COUNT(dids_by_stnm_found) <= 0, dids_by_stnm_not_found, dids_by_stnm_found); // IF (true, Status = 2(_NOT_FOUND), records found or 203)

  // ====================== by Address-Addr Components ====================

 // Modified logic from AutoHeaderV2.fetch_address for IDM Service
	Addr_Hdr_Key := dx_header.key_address();

	temp_city_zip_value := ziplib.CityToZip5(_state, _city);
	STRING sec_range_pattern := AutoHeaderV2.Functions.GetSecrangeAtomPattern (_sec_range); // regex pattern for type 2 fuzzy secrange search
	srange := AutoStandardI.Constants.SECRANGE;

	dids_by_addr_found := DEDUP(LIMIT(PROJECT(Addr_Hdr_Key( //Limit= 100
																						KEYED(prim_name = _prim_name),
																						KEYED(prim_range = _prim_range OR (_row.taddress._range AND
																									(prim_range IN _prim_range_set))),
																						KEYED(st = _state),
																						KEYED(city_code IN doxie.Make_CityCodes(_city).rox OR _city = ''),
																						KEYED(extended_zips = [] OR zip IN extended_zips),
																						KEYED((_sec_range = '') OR
																									(_row.taddress.sec_range_fuzziness = srange.EXACT AND _sec_range = sec_range) OR
																									(_row.taddress.sec_range_fuzziness = srange.EXACT_OR_BLANK AND ut.NNEQ(_sec_range, sec_range)) OR
																									(_row.taddress.sec_range_fuzziness = srange.INCLUDES_ATOM)),
																									(_row.taddress.sec_range_fuzziness != srange.INCLUDES_ATOM OR REGEXFIND(sec_range_pattern, sec_range)) AND // this is a post-filter (vs. keyed condition above)
																									_row.taddress.state_prev_1 = '' OR ut.bit_test(states,ut.St2Code(_row.taddress.state_prev_1)),
																									_row.taddress.state_prev_1 = '' OR ut.bit_test(states,ut.St2Code(_row.taddress.state_prev_1)),
																						// fuzzy search: phonetics
																						KEYED(_lname = '' OR _row.tname.allow_leading_name_match OR dph_lname=metaphonelib.DMetaPhone1(_lname)[1..6]),
																						KEYED(_lname = '' OR (lname IN _lname_set) OR (_row.tname.allow_leading_name_match AND LENGTH(TRIM(_lname)) >= 3 AND
																						lname[1..LENGTH(TRIM(_lname))] = _lname) OR (_row.tname.phonetic AND (~_row.tname.phonetic_distance OR (lname IN _row.tname.lname_set_phonetic))))),
																						TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.STREET)),
																			Constants.MAX_DIDS_PER_ADDRS, ONFAIL(SetErrors(AutoHeaderV2.Constants.FetchHit.STREET, 203))),did,all);

	dids_by_addr_not_found := not_found_in_key(AutoHeaderV2.Constants.FetchHit.STREET, 0);

	dids_by_addr := IF(COUNT(dids_by_addr_found) <= 0, dids_by_addr_not_found, dids_by_addr_found); // IF (true, Status = 2(_NOT_FOUND), records found or 203)




  // ========================== by Driver License =========================
	// CASE5: Fetch dids from Driver License Key
	DL_Key := DriversV2.Key_DL_Number;

	fetched_dls := LIMIT(DL_Key(KEYED(s_dl = _DLNumber)), Constants.MAX_DL_RECORDS, KEYED, SKIP); // Limit = 500
  ds_filtered := DEDUP(fetched_dls(did >0 AND ut.NNEQ (orig_state, _DLState) OR ut.NNEQ (state, _DLState)), did, all);

	dids_by_DL := PROJECT(ds_filtered,TRANSFORM(AutoHeaderV2.layouts.search_out, SELF.did := LEFT.did, SELF.fetch_hit := AutoHeaderV2.Constants.FetchHit.DL));
	
  // ========================== All Search ENDS ===========================

  // combine all together (this may introduce duplicates):
  all_dids := IF(_ssn != '', dids_by_ssn) +
							IF(_lname != '', dids_by_name) +
              IF(_dob != 0 AND _lname != '', dids_by_dob) +
              IF(_dob != 0 AND _fname != '', dids_by_dobfname) +
              IF(_phone != '', dids_by_phone) +
							IF(_state != '' AND _lname != '', dids_by_stnm) +
							IF(_prim_name != '' AND _prim_range != '' AND _state != '', dids_by_Addr) +
							IF(_dlnumber != '' AND _dlstate != '' , dids_by_DL); // TODO : Is condition correct or do we need some more/less condition?

  res := ROLLUP (SORT (all_dids(did !=0), did, fetch_hit, index_hit),
                            LEFT.did = RIGHT.did,
                           TRANSFORM(AutoHeaderV2.layouts.search_out,
                                      SELF.seq			 	:= LEFT.seq,
																			SELF.did 			 	:= LEFT.did,
                                      SELF.index_hit	:= LEFT.index_hit | RIGHT.index_hit,
                                      SELF.fetch_hit 	:= LEFT.fetch_hit | RIGHT.fetch_hit)) + all_dids(did=0);

// OUTPUT(in_criteria[1],NAMED('in_criteria'));
// OUTPUT(dids_by_ssn,NAMED('dids_by_ssn'));
// OUTPUT(dids_by_phone,NAMED('dids_by_phone'));
// OUTPUT(dids_by_dob,NAMED('dids_by_dob'));
// OUTPUT(dids_by_name,NAMED('dids_by_name'));
// OUTPUT(dids_by_stnm,NAMED('dids_by_stnm'));
// OUTPUT(dids_by_addr,NAMED('dids_by_addr'));
// OUTPUT(cleaned_inputs,NAMED('cleaned_inputs'));
// OUTPUT(extended_zips,NAMED('extended_zips'));
  RETURN res;
END;