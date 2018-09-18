/* ************************************************************************
 * This function searches for the raw data used within the following      *
 * functions.  We gather all of the data once so that we don't search the *
 * same key multiple times for performance reasons.  Searched by DID.     *
 * ** This is adapted from Progressive_Phone.Mac_Get_Type_E ************* *
 * - Phone_Shell.Search_CoResident																				*
 * - Phone_Shell.Search_Parent																						*
 * - Phone_Shell.Search_RelativeCloseProximity														*
 * - Phone_Shell.Search_Spouse																						*
 ************************************************************************ */

IMPORT Doxie, Doxie_Raw, DIDVille, Header_Quick, Header, Gong, Utilfile, MDR, Phone_Shell, Progressive_Phone, Risk_Indicators, RiskWise, UT, Person_Models, NID, AutoStandardI,STD;

EXPORT Phone_Shell.Layouts.Layout_Parent_Spouse_Relative_RawData Search_Parent_Spouse_Relative_RawData (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, UNSIGNED1 GLBPurpose, UNSIGNED1 DPPAPurpose, STRING50 DataRestrictionMask) := FUNCTION
	 /* ***************************************************************
		* 							Get Relatives and Their Titles									*
	  *************************************************************** */
	Doxie_RAW.Layout_RelativeRawBatchInput prepRelatives(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.Input.Seq := le.Clean_Input.seq;
		SELF.seq := le.Clean_Input.seq;
		SELF.Input.DID := le.DID;
		SELF.Input.GLB_Purpose := GLBPurpose;
		SELF.Input.DPPA_Purpose := DPPAPurpose;
		
		// Set Search Options
		SELF.Input.LN_Branded_Value := TRUE;
		SELF.Input.Include_Relatives_Val := TRUE;
		SELF.Input.Include_Associates_Val := TRUE;
		SELF.Input.Relative_Depth := 1;
		
		SELF := [];
	END;
	prepRelativeAppend := GROUP(SORT(PROJECT(input, prepRelatives(LEFT)), seq), seq);
	
	withRelativeAppend := Doxie_Raw.Relative_Raw_Batch(prepRelativeAppend) (person2 <> 0);
	
	relativeAppendSorted := SORT(UNGROUP(withRelativeAppend), Input.seq, Depth, P2_Sort, P3_Sort, P4_Sort);
	
	Phone_Shell.Layouts.layout_Relative_With_Rank getRelativeRank(Phone_Shell.Layouts.Layout_Relatives le, UNSIGNED8 cnt) := TRANSFORM
		SELF.Rel_Rank := cnt;
		SELF := le;
	END;
	
	relativeMatchWithTitle := PROJECT(relativeAppendSorted, getRelativeRank(LEFT, COUNTER));

	DIDVille.Layout_Did_OutBatch getRelativeDID(relativeMatchWithTitle le) := TRANSFORM
		SELF.seq := le.seq;
		SELF.did := le.person2;
		SELF := [];
	END;
	
	withRelativeDid := PROJECT(relativeMatchWithTitle, getRelativeDID(LEFT));

	 /* ***************************************************************
		* 						        	Get Blue Records						      			*
	  *************************************************************** */
	// inputmod := AutoStandardI.GlobalModule();
	// industry_class_value :=  AutoStandardI.InterfaceTranslator.industry_class_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.industry_class_value.params)); 
	// dppa_ok := AutoStandardI.InterfaceTranslator.dppa_ok.val(project(inputmod,AutoStandardI.InterfaceTranslator.dppa_ok.params)); 
	// DPPA_Purpose := AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(project(inputmod,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));
	// probation_override_value := AutoStandardI.InterfaceTranslator.probation_override_value.val(project(inputmod,AutoStandardI.InterfaceTranslator.probation_override_value.params)); 
	// no_scrub := AutoStandardI.InterfaceTranslator.no_scrub.val(project(inputmod,AutoStandardI.InterfaceTranslator.no_scrub.params)); 
	// glb_ok := AutoStandardI.InterfaceTranslator.glb_ok.val(project(inputmod,AutoStandardI.InterfaceTranslator.glb_ok.params)); 
	// Progressive_Phone.Mac_Get_Blue(withRelativeDid, blueRecords, FALSE, FALSE, FALSE, DataRestrictionMask);

  // why input GLB, DPPA are not used?
		
  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
    EXPORT string DataRestrictionMask := ^.DataRestrictionMask;
  END;
  glb_ok := mod_access.isValidGLB();
  dppa_ok := mod_access.isValidDPPA();
		
	Progressive_Phone.Mac_Get_Blue(withRelativeDid, blueRecords, FALSE, FALSE, FALSE, mod_access);
	
	sixMonths := blueRecords(src <> '' AND ut.DaysApart(StringLib.GetDateYYYYMMDD(), (STRING6)dt_last_seen + '15') <= 180
																			OR ut.DaysApart(StringLib.GetDateYYYYMMDD(), (STRING6)dt_vendor_last_reported + '15') <= 180);

	 /* ***************************************************************
		* 							Get Gong Data by Address and DID								*
	  *************************************************************** */
	Phone_Shell.Layouts.layoutWithCohabitDid byAddressLastName(sixMonths le, Gong.Key_History_Address ri) := TRANSFORM
		SELF.AcctNo := IF(ri.phone10 = '', SKIP, (STRING20)le.seq);
		SELF.subj_first := le.fname;
		SELF.subj_middle := le.mname;
		SELF.subj_last := le.lname;
		SELF.subj_suffix := le.name_suffix;
		SELF.subj_phone10 := ri.phone10;
		SELF.subj_name_dual := ri.listed_name;
		SELF.subj_phone_type := '4';
		SELF.subj_date_first := (STRING8)le.dt_first_seen;
		SELF.subj_date_last := (STRING8)le.dt_last_seen;
		SELF.subj_phone_date_last := (STRING8)StringLib.GetDateYYYYMMDD();
		SELF.phpl_phones_plus_type := MAP(ri.listing_type_res <> '' => ri.listing_type_res,
																			ri.listing_type_bus <> '' => ri.listing_type_bus,
																																	 ri.listing_type_gov);
		SELF.DID := le.DID;
		SELF.Addr_Suffix := ri.Suffix;
		SELF.Zip5 := ri.z5;
		SELF.P_DID := ri.DID;
		SELF.P_Name_Last := ri.name_last;
		SELF.P_Name_First := ri.name_first;
		SELF.sub_rule_number := 41;
		SELF.DateOfBirth := (STRING8)le.dob;
		SELF.SSN := le.ssn;
		SELF := ri;
		SELF := [];
	END;
	
	byAddrLName := JOIN(sixMonths, Gong.Key_History_Address,
																				KEYED(LEFT.prim_name = RIGHT.prim_name AND LEFT.Zip = RIGHT.z5 AND
																				LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.st = RIGHT.st) AND
																				RIGHT.current_flag = TRUE AND RIGHT.phone10 <> '' AND
																				(LEFT.lname = RIGHT.name_last OR LEFT.fname = RIGHT.name_first AND
																				(StringLib.EditDistance(LEFT.lname, RIGHT.name_last) < 2 OR
																				LENGTH(TRIM(LEFT.lname)) > 5 AND
																				StringLib.EditDistance(LEFT.lname, RIGHT.name_last) < 3)) AND
																				(LEFT.sec_range = '' OR LEFT.sec_range = RIGHT.sec_range OR LEFT.unit_desig = 'LOT' OR
																				NID.mod_PFirstTools.PFLeqPFR(LEFT.fname, RIGHT.name_first) OR LEFT.fname[1] = RIGHT.name_first),
																				byAddressLastName(LEFT, RIGHT), LIMIT(UT.Limits.PHONE_PER_PERSON, SKIP));
																				
	Phone_Shell.Layouts.layoutWithCohabitDid byDID(DIDVille.Layout_Did_OutBatch le, Gong.key_did ri) := TRANSFORM
		SELF.AcctNo := (STRING20)le.seq;
		SELF.Subj_First := ri.name_first;
		SELF.Subj_Middle := ri.name_middle;
		SELF.Subj_Last := ri.name_last;
		SELF.Subj_Suffix := ri.name_suffix;
		SELF.Subj_Phone10 := ri.Phone10;
		SELF.Subj_Name_Dual := ri.listed_name;
		SELF.Subj_Phone_Type := '4';
		SELF.Subj_Date_First := (STRING8)ri.filedate[1..8];
		SELF.Subj_Date_Last := (STRING8)StringLib.GetDateYYYYMMDD();
		SELF.Subj_Phone_Date_Last := (STRING8)StringLib.GetDateYYYYMMDD();
		SELF.Phpl_Phones_Plus_Type := MAP(ri.listing_type_res <> '' => ri.listing_type_res,
																			ri.listing_type_bus <> '' => ri.listing_type_bus,
																																	 ri.listing_type_gov);
		SELF.did := le.did;
		SELF.addr_suffix := ri.suffix;
		SELF.zip5 := ri.z5;
		SELF.p_did := ri.did;
		SELF.p_name_last := ri.name_last;
		SELF.p_name_first := ri.name_first;
		SELF.sub_rule_number := 42;
		SELF := ri;
		SELF := le;
		SELF := [];
	END;
	
	outputByDID := JOIN(withRelativeDID, Gong.key_did, LEFT.DID <> 0 AND KEYED(LEFT.did = RIGHT.l_did) AND RIGHT.phone10 <> '', byDID(LEFT, RIGHT), LIMIT(UT.Limits.PHONE_PER_PERSON, SKIP));
	
	outputReady := DEDUP(SORT((byAddrLName + outputByDID), RECORD), RECORD);
	
	 /* ***************************************************************
		* 							Determine Relationship to Subject								*
	  *************************************************************** */
	Phone_Shell.Layouts.layoutWithCohabitDid getRecentCohabit(Phone_Shell.Layouts.layoutWithCohabitDid le, Phone_Shell.Layouts.layout_Relative_With_Rank ri) := TRANSFORM
		SELF.recent_cohabit := ri.recent_cohabit;
		SELF.rel_rank := ri.rel_rank;
		SELF.same_lname := ri.same_lname;
		SELF.rel_prim_range := ri.rel_prim_range;
		phone_type := MAP( ri.TitleNo IN Header.relative_titles.set_Spouse => '41',
											 ri.TitleNo IN Header.relative_titles.set_Parent => '42',
											 ri.isRelative = FALSE													 => '44',
																																					'43');
		SELF.subj_phone_type := phone_type;
		SELF.sub_rule_number := MAP(phone_type = '41' AND le.sub_rule_number = 41 => 41,
																phone_type = '41' AND le.sub_rule_number = 42 => 42,
																phone_type = '42' AND le.sub_rule_number = 41 => 43,
																phone_type = '42' AND le.sub_rule_number = 42 => 44,
																phone_type = '43' AND le.sub_rule_number = 41 => 45,
																phone_type = '43' AND le.sub_rule_number = 42 => 46,
																phone_type = '44' AND le.sub_rule_number = 41 => 47,
																phone_type = '44' AND le.sub_rule_number = 42 => 48,
																																								 le.sub_rule_number);
		SELF.TitleNo := ri.TitleNo;
		SELF.subj_phone_relationship := IF(ri.TitleNo <> 0, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(ri.TitleNo) 
																			                                     + IF(ri.TitleNo = Header.relative_titles.num_associate,' '+Header.translateRelativePrimrange(ri.rel_prim_range),'')
																			                                     ),
																											  IF(ri.isRelative = FALSE, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(Header.relative_titles.num_associate) + ' ' + Header.translateRelativePrimrange(ri.rel_prim_range)),
																																					 Header.relative_titles.fn_get_str_title(Header.relative_titles.num_relative)));
		SELF := le;
		SELF := ri;
	END;
	outputWithCohabit := JOIN(outputReady, relativeMatchWithTitle, (UNSIGNED)LEFT.AcctNo = RIGHT.seq AND LEFT.did = RIGHT.person2,
																			getRecentCohabit(LEFT, RIGHT), LEFT OUTER, KEEP(1)) (Subj_Phone_Type <> '4');

	sortedOutput := SORT(outputWithCohabit (TRIM(subj_phone10) NOT IN ['', '0']), AcctNo, Subj_Phone10, ((INTEGER)Subj_Phone_Type), -((INTEGER)Subj_Date_Last), -((INTEGER)Subj_Date_First), -((INTEGER)Recent_Cohabit), -((INTEGER)DateOfBirth), -((INTEGER)SSN), -Prim_Range, -Prim_Name, -Addr_Suffix, -P_City_Name, -St, -Zip5, -Subj_Last, -Subj_First, -P_Name_Last, -P_Name_First, -Subj_Middle, -Subj_Suffix, -Subj_Name_Dual, DID, P_DID); // Need to sort on a bunch of fields to make this deterministic
	dedupedOutput := DEDUP(sortedOutput, AcctNo, Subj_Phone10);
	
	final := PROJECT(dedupedOutput, TRANSFORM(Phone_Shell.Layouts.Layout_Parent_Spouse_Relative_RawData,
																						SELF.sort_order_internal := IF(LEFT.subj_phone_type = '43', LEFT.rel_rank, LEFT.sort_order_internal);
																						SELF := LEFT));

	 /* ***************************************************************
		*      DEBUGGING SECTION -- COMMENT OUT FOR PRODUCTION		    	*
	  *************************************************************** */
	 // OUTPUT(CHOOSEN(withRelativeAppend, 100), NAMED('withRelativeAppend'));
	 // OUTPUT(CHOOSEN(withRelativeDid, 100), NAMED('raw_withRelativeDid'));
	 // OUTPUT(CHOOSEN(blueRecords, 100), NAMED('raw_blueRecords'));
	 // OUTPUT(CHOOSEN(sixMonths, 100), NAMED('raw_sixMonths'));
	 // OUTPUT(CHOOSEN(byAddrLName, 100), NAMED('raw_byAddrLName'));
	 // OUTPUT(CHOOSEN(outputByDID, 100), NAMED('raw_outputByDID'));
	 // OUTPUT(CHOOSEN(outputReady, 100), NAMED('raw_outputReady'));
	 // OUTPUT(CHOOSEN(outputWithCohabit, 100), NAMED('raw_outputWithCohabit'));
	 // OUTPUT(CHOOSEN(sortedOutput, 100), NAMED('raw_sortedOutput'));
	 // OUTPUT(CHOOSEN(dedupedOutput, 100), NAMED('raw_dedupedOutput'));
	 // OUTPUT(CHOOSEN(final, 100), NAMED('raw_final'));

	 /* ***************************************************************
		* 									Return Final Result 												*
	  *************************************************************** */
	RETURN(final);
END;