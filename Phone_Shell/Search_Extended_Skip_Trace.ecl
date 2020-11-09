/* ************************************************************************
 * This function searches Extended Skip Trace by:													*
 * - Address (Name/City/State):: Source: SX																*
 **************************************************************************
 * This code is directly adapted from progressive_phone.mac_get_type_f    *
 ************************************************************************ */

IMPORT Doxie, dx_Gong, NID, Phone_Shell, Progressive_Phone, RiskWise, UT, Watchdog, STD, Suppress;

todays_date := (string) STD.Date.Today();

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_Extended_Skip_Trace (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 PhoneRestrictionMask, STRING50 DataRestrictionMask, UNSIGNED2 sx_match_restriction_limit = 10, BOOLEAN Strict_APSX = FALSE,
          UNSIGNED2 PhoneShellVersion = 10, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

 IncludeLexIDCounts := if(PhoneShellVersion >= 21,true,false);   // LexID counts/'all' attributes added in PhoneShell version 2.1
	inputDIDSet := SET(Input, Clean_Input.DID);

	prepInput := PROJECT(Input, TRANSFORM(Progressive_Phone.Layout_Header_Seq,
																		SELF.dob := (INTEGER4)LEFT.Clean_Input.DateOfBirth;
																		SELF.phone := IF(TRIM(LEFT.Clean_Input.HomePhone) <> '', LEFT.Clean_Input.HomePhone, LEFT.Clean_Input.WorkPhone);
																		SELF.fname := LEFT.Clean_Input.FirstName;
																		SELF.mname := LEFT.Clean_Input.MiddleName;
																		SELF.lname := LEFT.Clean_Input.LastName;
																		SELF.name_suffix := LEFT.Clean_Input.SuffixName;
																		SELF.ssn := LEFT.Clean_Input.SSN;
																		SELF.prim_range := LEFT.Clean_Input.prim_range;
																		SELF.predir := LEFT.Clean_Input.predir;
																		SELF.prim_name := LEFT.Clean_Input.Prim_Name;
																		SELF.suffix := LEFT.Clean_Input.Addr_Suffix;
																		SELF.postdir := LEFT.Clean_Input.Postdir;
																		SELF.Unit_desig := LEFT.Clean_Input.unit_desig;
																		SELF.Sec_Range := LEFT.Clean_Input.Sec_Range;
																		SELF.city_name := LEFT.Clean_Input.City;
																		SELF.st := LEFT.Clean_Input.State;
																		SELF.zip := LEFT.Clean_Input.Zip5;
																		SELF.zip4 := LEFT.Clean_Input.Zip4;
																		SELF.seq := LEFT.Clean_Input.Seq;
																		SELF.did := LEFT.Clean_Input.did;
																		SELF := LEFT;
																		SELF := []));
	/* ***************************************************************
		* 						        	Get Blue Records						      			*
	  *************************************************************** */

	Progressive_Phone.Mac_Get_Blue(prepInput, blueRecords, FALSE, FALSE, FALSE, mod_access);

	sixMonths := blueRecords(src <> '' AND ut.DaysApart((string8)STD.Date.Today(), (STRING6)dt_last_seen + '15') <= 180
																			OR ut.DaysApart((string8)STD.Date.Today(), (STRING6)dt_vendor_last_reported + '15') <= 180);

	b_out_plus := RECORD
		Progressive_Phone.Layout_Progressive_Batch_Out_With_DID;
	END;

	// Rule 1 - If the input last name in the key listed_name or input first name matches the listing's last name
  key_history_address := dx_Gong.key_history_address();
	{b_out_plus, unsigned4 global_sid} by_rule_1(sixMonths le, key_history_address ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.AcctNo := (STRING)le.seq;
		SELF.Subj_First := ri.name_first;
		SELF.Subj_Middle := ri.name_middle;
		SELF.Subj_Last := ri.name_last;
		SELF.Subj_Suffix := ri.name_suffix;
		SELF.Subj_Phone10 := ri.phone10;
		SELF.Subj_Name_Dual := ri.listed_name;
		SELF.Subj_Phone_Type := '5';
		SELF.Subj_Date_First := ri.dt_first_seen[1..6];
		SELF.Subj_Date_Last := todays_date[1..6];
		SELF.Subj_Phone_Date_Last := todays_date[1..6];
		SELF.Phpl_Phones_Plus_Type := MAP(TRIM(ri.listing_type_res) <> '' => ri.listing_type_res,
																			TRIM(ri.listing_type_bus) <> '' => ri.listing_type_bus,
																																					ri.listing_type_gov);
		SELF.DID := le.DID;
		SELF.p_DID := ri.DID;
		SELF.Addr_Suffix := ri.suffix;
		SELF.Zip5 := ri.z5;
		SELF.p_name_last := ri.name_last;
		SELF.p_name_first := ri.name_first;
		SELF.sub_rule_number := 51;
		SELF := ri;
		SELF := [];
	END;
	f_rule_1_raw_unsuppressed := JOIN(sixMonths, key_history_address, KEYED(LEFT.prim_name = RIGHT.prim_name) AND
																													KEYED(LEFT.zip = RIGHT.z5) AND
																													KEYED(LEFT.prim_range = RIGHT.prim_range) AND
																													KEYED(LEFT.sec_range = RIGHT.sec_range) AND
																													KEYED(LEFT.st = RIGHT.st) AND
																													RIGHT.current_flag = TRUE AND TRIM(RIGHT.phone10) <> '' AND
																													((LENGTH(TRIM(LEFT.lname)) > 1 AND STD.Str.Find(TRIM(RIGHT.listed_name), TRIM(LEFT.lname), 1) > 0) OR
																													(LENGTH(TRIM(LEFT.fname)) > 1 AND TRIM(LEFT.fname) = TRIM(RIGHT.name_last))),
																					by_rule_1(LEFT, RIGHT), LIMIT(ut.limits.PHONE_PER_PERSON, SKIP));
	f_rule_1_raw := Suppress.Suppress_ReturnOldLayout(f_rule_1_raw_unsuppressed, mod_access, b_out_plus);
	// Keep the record with a p_did matching one of the input DIDs
	f_rule_1 := DEDUP(SORT(f_rule_1_raw, AcctNo, Subj_Phone10, -Subj_Date_Last, -Subj_Date_First, -(p_did IN inputDIDSet)),
																			 AcctNo, Subj_Phone10);

	// Rule 2 - If First Name, Last Name, City and State Match
  key_history_city_st_name := dx_Gong.key_history_city_st_name();
	{b_out_plus, unsigned4 global_sid} by_rule_2(sixMonths le, key_history_city_st_name ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.AcctNo := (STRING20)le.seq;
		SELF.Subj_First := ri.name_first;
		SELF.Subj_Middle := ri.name_middle;
		SELF.Subj_Last := ri.name_last;
		SELF.Subj_Suffix := ri.name_suffix;
		SELF.Subj_Phone10 := ri.phone10;
		SELF.Subj_Name_Dual := ri.listed_name;
		SELF.Subj_Phone_Type := '5';
		SELF.Subj_Date_First := ri.dt_first_seen[1..6];
		SELF.Subj_Date_Last := ri.dt_last_seen[1..6];
		SELF.Subj_Phone_Date_Last := ri.dt_last_seen[1..6];
		SELF.Phpl_Phones_Plus_Type := MAP(TRIM(ri.listing_type_res) <> '' => ri.listing_type_res,
																			TRIM(ri.listing_type_bus) <> '' => ri.listing_type_bus,
																																					ri.listing_type_gov);
		SELF.did := le.did;
		SELF.addr_suffix := ri.suffix;
		SELF.Zip5 := ri.z5;
		SELF.p_did := ri.did;
		SELF.p_name_last := ri.name_last;
		SELF.p_name_first := ri.name_first;
		SELF.sub_rule_number := 52;
		SELF := ri;
		SELF := [];
	END;

	f_best_city_st_raw_input := JOIN(prepInput, WatchDog.Key_Best_Name_City_State,
																										KEYED(LEFT.st = RIGHT.st) AND
																										KEYED(LEFT.city_name = RIGHT.city_name) AND
																										KEYED(LEFT.lname = RIGHT.lname) AND
																										KEYED((NID.mod_PFirstTools.PF(LEFT.fname)[1] = RIGHT.preferred_fname) OR
																													(NID.mod_PFirstTools.PF(LEFT.fname)[2] != '' AND NID.mod_PFirstTools.PF(LEFT.fname)[2] = RIGHT.preferred_fname)) AND
																										RIGHT.did_cnt_with_pref_nm > sx_match_restriction_limit,
																										TRANSFORM(Progressive_Phone.Layout_Header_Seq, SELF := LEFT), LEFT ONLY);

	f_best_city_st_raw := JOIN(sixMonths, WatchDog.Key_Best_Name_City_State,
																										KEYED(LEFT.st = RIGHT.st) AND
																										KEYED(LEFT.city_name = RIGHT.city_name) AND
																										KEYED(LEFT.lname = RIGHT.lname) AND
																										KEYED((NID.mod_PFirstTools.PF(LEFT.fname)[1] = RIGHT.preferred_fname) OR
																													(NID.mod_PFirstTools.PF(LEFT.fname)[2] != '' AND NID.mod_PFirstTools.PF(LEFT.fname)[2] = RIGHT.preferred_fname)) AND
																										RIGHT.did_cnt_with_pref_nm > sx_match_restriction_limit,
																										TRANSFORM(Progressive_Phone.Layout_Header_Seq, SELF := LEFT), LEFT ONLY);

	f_rule_2_input_unsuppressed := JOIN(IF(sx_match_restriction_limit	=	0, prepInput, f_best_city_st_raw_input), key_history_city_st_name,
																				KEYED(RIGHT.city_code IN Doxie.Make_CityCodes(LEFT.city_name).rox) AND
																				KEYED(LEFT.st = RIGHT.st) AND
																				KEYED(metaphonelib.DMetaPhone1(LEFT.lname)[1..6] = RIGHT.dph_name_last) AND
																				KEYED(LEFT.lname <> '' AND LEFT.lname = RIGHT.name_last) AND
																				KEYED(NID.mod_PFirstTools.PF(LEFT.fname)[1] = RIGHT.p_name_first OR
																							NID.mod_PFirstTools.PF(LEFT.fname)[2] <> '' AND
																							NID.mod_PFirstTools.PF(LEFT.fname)[2] = RIGHT.p_name_first) AND
																				(LEFT.did = RIGHT.did OR LEFT.did = 0 OR RIGHT.did = 0) AND
																				TRIM(RIGHT.phone10) <> '' AND TRIM(RIGHT.current_record_flag) = 'Y',
			                    by_rule_2(LEFT, RIGHT), LIMIT(5 * ut.limits.PHONE_PER_PERSON, SKIP));

	f_rule_2_input := Suppress.Suppress_ReturnOldLayout(f_rule_2_input_unsuppressed, mod_access, b_out_plus);

	f_rule_2_raw_unsuppressed := JOIN(IF(sx_match_restriction_limit	=	0, sixMonths, f_best_city_st_raw), key_history_city_st_name,
																				KEYED(RIGHT.city_code IN Doxie.Make_CityCodes(LEFT.city_name).rox) AND
																				KEYED(LEFT.st = RIGHT.st) AND
																				KEYED(metaphonelib.DMetaPhone1(LEFT.lname)[1..6] = RIGHT.dph_name_last) AND
																				KEYED(LEFT.lname <> '' AND LEFT.lname = RIGHT.name_last) AND
																				KEYED(NID.mod_PFirstTools.PF(LEFT.fname)[1] = RIGHT.p_name_first OR
																							NID.mod_PFirstTools.PF(LEFT.fname)[2] <> '' AND
																							NID.mod_PFirstTools.PF(LEFT.fname)[2] = RIGHT.p_name_first) AND
																				(LEFT.did = RIGHT.did OR LEFT.did = 0 OR RIGHT.did = 0) AND
																				TRIM(RIGHT.phone10) <> '' AND TRIM(RIGHT.current_record_flag) = 'Y',
			                    by_rule_2(LEFT, RIGHT), LIMIT(5 * ut.limits.PHONE_PER_PERSON, SKIP));

	f_rule_2_raw := Suppress.Suppress_ReturnOldLayout(f_rule_2_raw_unsuppressed, mod_access, b_out_plus);

	f_rule_2 := DEDUP(SORT(IF(EXISTS(f_rule_2_input), f_rule_2_input, f_rule_2_raw), AcctNo, Subj_Phone10, -Subj_Date_Last, -Subj_Date_First, -(p_did IN inputDIDSet)),
																																									 AcctNo, Subj_Phone10);

	// Rule 3 - If First Name initial, last name, city and state match, and the listing has no street address
	{b_out_plus, unsigned4 global_sid} by_rule_3(sixMonths le, key_history_city_st_name ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.AcctNo := (STRING20)le.seq;
		SELF.Subj_First := ri.name_first;
		SELF.Subj_Middle := ri.name_middle;
		SELF.Subj_Last := ri.name_last;
		SELF.Subj_Suffix := ri.name_suffix;
		SELF.Subj_Phone10 := ri.phone10;
		SELF.Subj_Name_Dual := ri.listed_name;
		SELF.Subj_Phone_Type := '5';
		SELF.Subj_Date_First := ri.dt_first_seen[1..6];
		SELF.Subj_Date_Last := ri.dt_last_seen[1..6];
		SELF.Subj_Phone_Date_Last := ri.dt_last_seen[1..6];
		SELF.Phpl_Phones_Plus_Type := MAP(TRIM(ri.listing_type_res) <> '' => ri.listing_type_res,
																			TRIM(ri.listing_type_bus) <> '' => ri.listing_type_bus,
																																					ri.listing_type_gov);
		SELF.did := le.did;
		SELF.p_did := ri.did;
		SELF.p_name_last := ri.name_last;
		SELF.p_name_first := ri.name_first;
		SELF.sub_rule_number := 53;
		SELF := [];
	END;

	f_rule_3_input_unsuppressed := JOIN(IF(sx_match_restriction_limit = 0, prepInput, f_best_city_st_raw_input), key_history_city_st_name,
																				KEYED(RIGHT.city_code IN doxie.Make_CityCodes(LEFT.city_name).rox) AND
																				(LEFT.st = RIGHT.st) AND
																				(metaphonelib.DMetaPhone1(LEFT.lname)[1..6] = RIGHT.dph_name_last) AND
																				(LEFT.lname <> '' AND LEFT.lname = RIGHT.name_last) AND
																				(LEFT.fname[1] = RIGHT.name_first OR LEFT.fname = RIGHT.name_first) AND
																				TRIM(RIGHT.prim_name) = '' AND TRIM(RIGHT.phone10) <> '' AND TRIM(RIGHT.current_record_flag) = 'Y',
													by_rule_3(LEFT, RIGHT), LIMIT(5 * ut.limits.PHONE_PER_PERSON, SKIP));

	f_rule_3_input := Suppress.Suppress_ReturnOldLayout(f_rule_3_input_unsuppressed, mod_access, b_out_plus);

	f_rule_3_raw_unsuppressed := JOIN(IF(sx_match_restriction_limit = 0, sixMonths, f_best_city_st_raw), key_history_city_st_name,
																				KEYED(RIGHT.city_code IN doxie.Make_CityCodes(LEFT.city_name).rox) AND
																				(LEFT.st = RIGHT.st) AND
																				(metaphonelib.DMetaPhone1(LEFT.lname)[1..6] = RIGHT.dph_name_last) AND
																				(LEFT.lname <> '' AND LEFT.lname = RIGHT.name_last) AND
																				(LEFT.fname[1] = RIGHT.name_first OR LEFT.fname = RIGHT.name_first) AND
																				TRIM(RIGHT.prim_name) = '' AND TRIM(RIGHT.phone10) <> '' AND TRIM(RIGHT.current_record_flag) = 'Y',
													by_rule_3(LEFT, RIGHT), LIMIT(5 * ut.limits.PHONE_PER_PERSON, SKIP));

	f_rule_3_raw := Suppress.Suppress_ReturnOldLayout(f_rule_3_raw_unsuppressed, mod_access, b_out_plus);

	f_rule_3 := DEDUP(SORT(IF(EXISTS(f_rule_3_input), f_rule_3_input, f_rule_3_raw), AcctNo, Subj_Phone10, -subj_date_last, -subj_date_first, -(p_did IN inputDIDSet)),
																																									 AcctNo, Subj_Phone10);

	rulesCombined := f_rule_1 + f_rule_2 + f_rule_3;
	skiptrace_all_precheck := DEDUP(SORT(rulesCombined, AcctNo, Subj_Phone10, -subj_date_last, -subj_date_first, -(p_did IN inputDIDSet)),
																							AcctNo, Subj_Phone10);

	skiptrace_all_unsuppressed := IF(strict_apsx, JOIN(skiptrace_all_precheck, dx_Gong.Key_History_phone(),
																				KEYED(LEFT.subj_phone10[4..10] = RIGHT.p7) AND
																				KEYED(LEFT.subj_phone10[1..3] = RIGHT.p3) AND
																				RIGHT.current_flag AND (LEFT.did = RIGHT.did OR RIGHT.did = 0),
																		TRANSFORM({progressive_phone.layout_progressive_batch_out_with_did, unsigned4 global_sid}, SELF.global_sid := RIGHT.global_sid, SELF := LEFT),
																		KEEP(1), ATMOST(RiskWise.max_atmost)),
															PROJECT(skiptrace_all_precheck, {progressive_phone.layout_progressive_batch_out_with_did, unsigned4 global_sid := 0}));

	skiptrace_all := Suppress.Suppress_ReturnOldLayout(skiptrace_all_unsuppressed, mod_access, progressive_phone.layout_progressive_batch_out_with_did);

	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getSkipTrace(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Progressive_Phone.layout_progressive_batch_out_with_did ri) := TRANSFORM

		SElf.Gathered_Phone := ri.subj_phone10;

		matchCode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone,
																											ri.Subj_First,						ri.Subj_Last, 						'', 													ri.Prim_Range,						 ri.Prim_Name,						 ri.Addr_Suffix,						 ri.P_City_Name,			ri.St,								ri.Zip5,						 '',												 ri.SSN,						 ri.DID, ri.subj_phone10);

		// Check the Phone Restriction Mask, only keep the phone if the mask is ok
		SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.Subj_Last), 'SX', '');

		SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_first);
		SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.subj_date_last);

		SELF.Sources.Source_Owner_Name_First := ri.subj_first;
		SELF.Sources.Source_Owner_Name_Middle := ri.subj_middle;
		SELF.Sources.Source_Owner_Name_Last := ri.subj_last;
		SELF.Sources.Source_Owner_Name_Suffix := ri.subj_suffix;
	 SELF.Sources.Source_Owner_DID := (STRING)ri.DID;

  SELF.Sources.Source_List_All_Last_Seen := if(IncludeLexIDCounts, Phone_Shell.Common.parseDate((STRING)ri.subj_date_last), '');
  SELF.Sources.Source_Owner_All_DIDs := if(IncludeLexIDCounts, (string)ri.DID, '');

		didMatch := STD.Str.Find(matchcode, 'L', 1) > 0;
		nameMatch := STD.Str.Find(matchcode, 'N', 1) > 0;
		addrMatch := STD.Str.Find(matchcode, 'A', 1) > 0;
		ssnMatch := STD.Str.Find(matchcode, 'S', 1) > 0;

		SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch => Phone_Shell.Constants.Phone_Subject_Level.Subject,
																															didMatch AND addrMatch => Phone_Shell.Constants.Phone_Subject_Level.Household,
																																												Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);

		SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch			=> 'Subject',
																															didMatch AND addrMatch			=> 'Subject at Household',
																															ssnMatch										=> 'Associate By SSN',
																															addrMatch										=> 'Associate By Address',
																																														 'Associate'
																															);

		SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchCode;

		SELF := le;
	END;
	withSkipTrace := JOIN(Input, skiptrace_all, (STRING)LEFT.Clean_Input.seq = RIGHT.AcctNo, getSkipTrace(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');

	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus get_Alls(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
   self.Sources.Source_List_All_Last_Seen := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID,
                                                   le.Sources.Source_List_All_Last_Seen,
                                                   le.Sources.Source_List_All_Last_Seen + ',' + ri.Sources.Source_List_All_Last_Seen);
   self.Sources.Source_Owner_All_DIDs := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID,
                                               le.Sources.Source_Owner_All_DIDs,
                                               le.Sources.Source_Owner_All_DIDs + ',' + ri.Sources.Source_Owner_All_DIDs);
   self := le;
 end;

 sortedSkipTrace := SORT(withSkipTrace, Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code)));

	final := if(IncludeLexIDCounts,
             ROLLUP(sortedSkipTrace,
               left.Clean_Input.seq = right.Clean_Input.seq and
               left.Gathered_Phone = right.Gathered_Phone and
               left.Sources.Source_List = right.Sources.Source_List,
               get_Alls(left,right)),
             DEDUP(sortedSkipTrace,
																		 Clean_Input.seq, Gathered_Phone, Sources.Source_List)
            );

	RETURN(final);
END;
