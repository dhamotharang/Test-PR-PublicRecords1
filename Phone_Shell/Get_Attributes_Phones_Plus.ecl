/* ************************************************************************
 * This function gathers the Phonesplus_Characteristics attributes.				*
 ************************************************************************ */

IMPORT AutoKey, Data_Services, Phone_Shell, Phones, Phonesplus_v2, RiskWise, UT, STD;

DEBUG_IGNORE_ALLOW_LIST := FALSE; // Set to TRUE if you do NOT want to filter by allow list

todays_date := STD.Date.Today();

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Phones_Plus (
       DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, 
			 UNSIGNED1 GLBPurpose, 
			 UNSIGNED1 DPPAPurpose, 
			 STRING30 IndustryClass, 
			 STRING DataRestrictionMask
			 ) := FUNCTION
			 
	/* ***********************************************************************
	 *  Since we are using autokeys to reduce the Roxie file size we need to *
	 * do two key lookups to get the data.                                   *
	 *************************************************************************/
	PhoneAutoKey := AutoKey.Key_Phone(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_');
	
	layoutPPTemp := RECORD
		UNSIGNED8 fdid := 0; // Fake DID - used to search the full phones plus payload
		Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus;
	END;
	layoutPPTemp getFDID(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, PhoneAutoKey ri) := TRANSFORM
		SELF.fdid := ri.did;
		SELF := le;
	END;
	getPhoneFDID := JOIN(Input, PhoneAutoKey, TRIM(LEFT.Gathered_Phone) NOT IN ['', '0'] AND KEYED(RIGHT.p7 = LEFT.Gathered_Phone[4..10]) AND KEYED(RIGHT.p3 = LEFT.Gathered_Phone[1..3]),
																		getFDID(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
																		
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getPhonesPlusAttributes(layoutPPTemp le, Phonesplus_v2.key_phonesplus_fdid ri) := TRANSFORM
		PhonesPlusSources := ['PPFA', 'PPLA', 'PPFLA', 'PPLFA', 'PPCA', 'PPDID', 'PPTH'];
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := MAP(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Type) <> ''	=> le.PhonesPlus_Characteristics.PhonesPlus_Type,
																													 TRIM(le.Sources.Source_List) IN PhonesPlusSources					=> 'U',
																																																													'');
																																																													
		SELF.PhonesPlus_Characteristics.PhonesPlus_Source := CASE(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Source),
																														'AY' => 'ALLOY',
																														'01' => 'CELL',
																														'02' => 'CELL',
																														'05' => 'CELL',
																														'GO' => 'GONG',
																														'HD' => 'HEADER',
																														'IB' => 'IBEHAVIOR',
																														'IC' => 'INFUTOR',
																														'IR' => 'INFUTOR',
																														'IQ' => 'INQUIRY',
																														'IO' => 'INTRADO',
																														'PN' => 'PCNSR',
																														'WP' => 'TARGUS',
																														'TM' => 'THRIVE',
																														'T$' => 'THRIVE',
																														'WO' => 'WIRED',
																														'WR' => 'WIRED',
																														'' 	 => '',
																																		'OTHER');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := le.PhonesPlus_Characteristics.PhonesPlus_Carrier;
		SELF.PhonesPlus_Characteristics.PhonesPlus_City := le.PhonesPlus_Characteristics.PhonesPlus_City;
		SELF.PhonesPlus_Characteristics.PhonesPlus_State := le.PhonesPlus_Characteristics.PhonesPlus_State;
		
		// Only populate the Reverse Phone attributes if we don't already have DID based PP Attributes populated
		reversePhoneLookup := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Type) = '' AND TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Source) = '' AND
														 TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Carrier) = '' AND TRIM(le.PhonesPlus_Characteristics.PhonesPlus_City) = '' AND
														 TRIM(le.PhonesPlus_Characteristics.PhonesPlus_State) = '' AND TRIM(le.Sources.Source_List) NOT IN PhonesPlusSources, TRUE, FALSE);
														 
		listType := TRIM(ri.listingtype);
		RPType := MAP(TRIM(ri.append_phone_type) = 'CELL' 	=> 'M',
										listType = 'R' 											=> 'R',
										listType = 'B' 											=> 'B',
										listType = 'RB' 										=> 'B',
										listType = 'M' 											=> 'M',
																													 'U');
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Type := IF(reversePhoneLookup, RPType, '');
		rpSource := CASE(TRIM(ri.Vendor),
																														'AY' => 'ALLOY',
																														'01' => 'CELL',
																														'02' => 'CELL',
																														'05' => 'CELL',
																														'GO' => 'GONG',
																														'HD' => 'HEADER',
																														'IB' => 'IBEHAVIOR',
																														'IC' => 'INFUTOR',
																														'IR' => 'INFUTOR',
																														'IQ' => 'INQUIRY',
																														'IO' => 'INTRADO',
																														'PN' => 'PCNSR',
																														'WP' => 'TARGUS',
																														'TM' => 'THRIVE',
																														'T$' => 'THRIVE',
																														'WO' => 'WIRED',
																														'WR' => 'WIRED',
																														'' 	 => '',
																																		'OTHER');
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Source := IF(reversePhoneLookup, rpSource, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier := IF(reversePhoneLookup, TRIM(ri.append_ocn), '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_City := IF(reversePhoneLookup, TRIM(ri.append_place_name), '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_State := IF(reversePhoneLookup, TRIM(ri.state), '');
		
		// Gather the remainder of the Phones Plus attributes
		SELF.PhonesPlus_Characteristics.PhonesPlus_Confidence := ri.confidencescore;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Rules := STD.Str.Reverse(ut.IntegerToBinaryString(ri.rules, FALSE));
		SELF.PhonesPlus_Characteristics.PhonesPlus_DID := ri.DID;
		SELF.PhonesPlus_Characteristics.PhonesPlus_DID_Score := (INTEGER)ri.did_score;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Listing_Name := TRIM(ri.origname);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen := Phone_Shell.Common.parseDate((STRING)ri.datefirstseen, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen := Phone_Shell.Common.parseDate((STRING)ri.datelastseen, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen := Phone_Shell.Common.parseDate((STRING)ri.datevendorfirstreported, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen := Phone_Shell.Common.parseDate((STRING)ri.datevendorlastreported, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen := Phone_Shell.Common.parseDate((STRING)ri.dt_nonglb_last_seen, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag := TRIM(ri.glb_dppa_flag);
		SELF.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All := TRIM(ri.glb_dppa_all);
  #if(not DEBUG_IGNORE_ALLOW_LIST)
  // 'mask' the key src_all field to only have a 1 in the allowed sources, use bitwise AND with the allowed mask
  Src_All_Masked := ri.src_all & ut.BinaryStringToInteger(Phone_Shell.Constants.PhonesPlus_AllowedSourcesMask);
  // now we need to check and see if our filtered src_all actually changed from the original
  src_chgd := not(src_all_masked = ri.src_all);
  // and if it did, we need to update what we use for Vendor and Src to match the new src_all
  // vendor was updated (in PhonesPlus_Characteristics.PhonesPlus_Source) in the Search_PhonesPlus function
  // so now we just need to update Src here.
  first_src := Phone_Shell.Common.PhonePlusFirstSource(src_all_masked);
  adjusted_src := if(src_chgd,
                     if(le.PhonesPlus_Characteristics.PhonesPlus_Source = 'HD', phonesplus_v2.translation_codes.fGet_all_sources(first_src), ''),
                     ri.src);
  #else
  Src_All_Masked := ri.src_all;
  adjusted_src := ri.src;
  #end
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src := TRIM(adjusted_src);
		Src_All := STD.Str.Reverse(ut.IntegerToBinaryString(Src_All_Masked, FALSE));
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_All := Src_All;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt := StringLib.StringFindCount(Src_All, '1');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_Rule := STD.Str.Reverse(ut.IntegerToBinaryString(ri.src_rule, FALSE));
		SELF.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf := ri.append_avg_source_conf;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Max_Source_Conf := ri.append_max_source_conf;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf := ri.append_min_source_conf;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf := ri.append_total_source_conf;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen := Phone_Shell.Common.parseDate((STRING)ri.orig_dt_last_seen, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DID_Type := TRIM(ri.did_type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigName := TRIM(ri.origname);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Address1 := TRIM(ri.address1);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Address2 := TRIM(ri.address2);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Address3 := TRIM(ri.address3);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigCity := TRIM(ri.origcity);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigState := TRIM(ri.origstate);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigZip := TRIM(ri.origzip[1..5]);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhone := TRIM(ri.orig_phone);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Dob := TRIM(ri.dob);
		dobAge := IF((INTEGER)ri.dob > 0, ut.Age((UNSIGNED)ri.dob, todays_date), 0);
		// Attempt to populate the age if we have a dob
		SELF.PhonesPlus_Characteristics.PhonesPlus_AgeGroup := MAP(dobAge BETWEEN 16 AND 17			=> '16',
																															 dobAge BETWEEN 18 AND 20			=> '18',
																															 dobAge BETWEEN 21 AND 30			=> '21',
																															 dobAge BETWEEN 31 AND 40			=> '31',
																															 dobAge BETWEEN 41 AND 50			=> '41',
																															 dobAge >= 51									=> '51',
																																															 ''
																																);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Gender := TRIM(ri.gender);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Email := TRIM(ri.email);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigListingType := IF(TRIM(ri.orig_listing_type) NOT IN ['R', 'RB', 'B', 'G', 'BG'], '', TRIM(ri.orig_listing_type));
		SELF.PhonesPlus_Characteristics.PhonesPlus_ListingType := IF(TRIM(ri.listingtype) NOT IN ['R', 'RB', 'B', 'G', 'BG'], '', TRIM(ri.listingtype));
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode := IF(TRIM(ri.orig_publish_code) = 'U', '', TRIM(ri.orig_publish_code));
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType := TRIM(ri.orig_phone_type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage := TRIM(ri.orig_phone_usage);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Company := TRIM(ri.company);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate := TRIM((STRING)ri.orig_phone_reg_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierCode := TRIM(ri.orig_carrier_code);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierName := TRIM(ri.orig_carrier_name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore := IF(TRIM(ri.orig_conf_score) = '', 1, MIN((INTEGER)ri.orig_conf_score, 5)); // Range of 1 to 5
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigRecType := ri.orig_rec_type;
		SELF.PhonesPlus_Characteristics.PhonesPlus_BDID := ri.bdid;
		SELF.PhonesPlus_Characteristics.PhonesPlus_BDID_Score := ri.bdid_score;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT := Phone_Shell.Common.parseDate((STRING)ri.append_npa_effective_dt, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT := Phone_Shell.Common.parseDate((STRING)ri.append_npa_last_change_dt, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Dialable_Ind := (INTEGER)ri.append_dialable_ind;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Place_Name := TRIM(ri.append_place_name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Portability_Indicator := (INTEGER)ri.append_portability_indicator;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code := IF(TRIM(ri.append_prior_area_code) IN ['', '0'], '', TRIM(ri.append_prior_area_code));
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match := STD.Str.Reverse(ut.IntegerToBinaryString(ri.append_nonpublished_match, FALSE));
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_OCN := TRIM(ri.append_ocn);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Time_Zone := TRIM(ri.append_time_zone);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type := TRIM(ri.append_nxx_type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_COCType := IF(TRIM(ri.append_coctype) = 'VOI', 'EOC', TRIM(ri.append_coctype));
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_SCC := TRIM(ri.append_scc);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type := TRIM(ri.append_phone_type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type := (INTEGER)ri.append_company_type;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Use := IF(TRIM(ri.append_phone_use) IN ['P', 'B'], TRIM(ri.append_phone_use), 'O');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Agreg_Listing_Type := TRIM(ri.agreg_listing_type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score := MIN(ri.max_orig_conf_score, 5);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score := MIN(ri.min_orig_conf_score, 5);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score := MIN(ri.cur_orig_conf_score, 5);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Match := STD.Str.Reverse(ut.IntegerToBinaryString(ri.eda_match, FALSE));
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt := TRIM((STRING)ri.eda_phone_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt := TRIM((STRING)ri.eda_did_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt := TRIM((STRING)ri.eda_nm_addr_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match := STD.Str.Reverse(ut.IntegerToBinaryString(ri.eda_hist_match, FALSE));
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt := TRIM((STRING)ri.eda_hist_phone_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt := TRIM((STRING)ri.eda_hist_did_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt := TRIM((STRING)ri.eda_hist_nm_addr_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone := IF((INTEGER)ri.append_feedback_phone = 0, 8, (INTEGER)ri.append_feedback_phone);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt := TRIM((STRING)ri.append_feedback_phone_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID := IF((INTEGER)ri.append_feedback_phone7_did = 0, 8, (INTEGER)ri.append_feedback_phone7_did);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt := TRIM((STRING)ri.append_feedback_phone7_did_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr := IF((INTEGER)ri.append_feedback_phone7_nm_addr = 0, 8, (INTEGER)ri.append_feedback_phone7_nm_addr);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt := TRIM((STRING)ri.append_feedback_phone7_nm_addr_dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match := STD.Str.Reverse(ut.IntegerToBinaryString(ri.append_ported_match, FALSE));
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Seen_Once_Ind := ri.append_seen_once_ind;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt := ri.append_indiv_phone_cnt;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag := ri.append_indiv_has_active_eda_phone_flag;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Latest_Phone_Owner_Flag := ri.append_latest_phone_owner_flag;
		SELF.PhonesPlus_Characteristics.PhonesPlus_HHID := ri.hhid;
		SELF.PhonesPlus_Characteristics.PhonesPlus_HHID_Score := ri.hhid_score;
		// SELF.PhonesPlus_Characteristics.PhonesPlus_Phone7_HHID_Key := ri.phone7_hhid_key;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag := ri.append_best_addr_match_flag;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Best_NM_Match_Flag := ri.append_best_nm_match_flag;
		SELF.PhonesPlus_Characteristics.PhonesPlus_RawAID := ri.rawaid;
		SELF.PhonesPlus_Characteristics.PhonesPlus_CleanAID := ri.cleanaid;
		SELF.PhonesPlus_Characteristics.PhonesPlus_Current_Rec := ri.current_rec;
		SELF.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date := Phone_Shell.Common.parseDate((STRING)ri.first_build_date, TRUE);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date := Phone_Shell.Common.parseDate((STRING)ri.last_build_date, TRUE);

		SELF := le;
	END;
	
	withPhonesPlusTemp := JOIN(getPhoneFDID, Phonesplus_v2.key_phonesplus_fdid, LEFT.FDID <> 0 AND KEYED(LEFT.FDID = RIGHT.FDID) AND
																													Phones.Functions.IsPhoneRestricted(RIGHT.origstate, 
																																														 GLBPurpose, 
																																														 DPPAPurpose, 
																																														 IndustryClass,
																																														 ,
																																														 RIGHT.datefirstseen,
																																														 RIGHT.dt_nonglb_last_seen,
																																														 RIGHT.rules,
																																														 RIGHT.src_all,
																																														 DataRestrictionMask
																																														 ) = FALSE
                             #if(not DEBUG_IGNORE_ALLOW_LIST)                          
                                 AND Phone_Shell.Common.PhonesPlusSourceAllowed(RIGHT.src_all)
                             #end
                                               , 
																										getPhonesPlusAttributes(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	
	// Keep the most confident/recent phones plus data possible
	withPhonesPlus := SORT(withPhonesPlusTemp, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, -PhonesPlus_Characteristics.PhonesPlus_Confidence, -PhonesPlus_Characteristics.PhonesPlus_DateLastSeen, -PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen, -PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen, -PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen, -PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen, -PhonesPlus_Characteristics.PhonesPlus_DID, -PhonesPlus_Characteristics.PhonesPlus_BDID, -PhonesPlus_Characteristics.PhonesPlus_EDA_Match, PhonesPlus_Characteristics.PhonesPlus_HHID, PhonesPlus_Characteristics.PhonesPlus_CleanAID, -PhonesPlus_Characteristics.PhonesPlus_Current_Rec, -PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date, -PhonesPlus_Characteristics.PhonesPlus_First_Build_Date);
	
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus rollPhonesPlus(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
		// Since we sorted above, le. contains the most relevant data, but use ri. to fill in any missing data
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Type, ri.PhonesPlus_Characteristics.PhonesPlus_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Source := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Source) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Source, ri.PhonesPlus_Characteristics.PhonesPlus_Source);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Carrier) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Carrier, ri.PhonesPlus_Characteristics.PhonesPlus_Carrier);
		SELF.PhonesPlus_Characteristics.PhonesPlus_City := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_City) <> '', le.PhonesPlus_Characteristics.PhonesPlus_City, ri.PhonesPlus_Characteristics.PhonesPlus_City);
		SELF.PhonesPlus_Characteristics.PhonesPlus_State := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_State) <> '', le.PhonesPlus_Characteristics.PhonesPlus_State, ri.PhonesPlus_Characteristics.PhonesPlus_State);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_Type, ri.PhonesPlus_Characteristics.PhonesPlus_RP_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Source := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_Source) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_Source, ri.PhonesPlus_Characteristics.PhonesPlus_RP_Source);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier, ri.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_City := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_City) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_City, ri.PhonesPlus_Characteristics.PhonesPlus_RP_City);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_State := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_State) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_State, ri.PhonesPlus_Characteristics.PhonesPlus_RP_State);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Confidence := IF(le.PhonesPlus_Characteristics.PhonesPlus_Confidence <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Confidence, ri.PhonesPlus_Characteristics.PhonesPlus_Confidence);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Rules := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Rules) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Rules, ri.PhonesPlus_Characteristics.PhonesPlus_Rules);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DID := IF(le.PhonesPlus_Characteristics.PhonesPlus_DID <> 0, le.PhonesPlus_Characteristics.PhonesPlus_DID, ri.PhonesPlus_Characteristics.PhonesPlus_DID);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DID_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_DID_Score <> 0, le.PhonesPlus_Characteristics.PhonesPlus_DID_Score, ri.PhonesPlus_Characteristics.PhonesPlus_DID_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Listing_Name := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Listing_Name) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Listing_Name, ri.PhonesPlus_Characteristics.PhonesPlus_Listing_Name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen, ri.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag := MAP(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) <> TRIM(ri.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) AND 
																																			TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) IN ['G', 'D', 'B'] AND 
																																			TRIM(ri.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) IN ['G', 'D', 'B'] 																									=> 'B',
																																		TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) <> '' 																																	=> le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag,
																																																																																																					 ri.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag);
		SELF.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All) <> '', le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All, ri.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_All);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Src) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Src, ri.PhonesPlus_Characteristics.PhonesPlus_Src);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_All := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Src_All) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Src_All, ri.PhonesPlus_Characteristics.PhonesPlus_Src_All);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt := IF(le.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt, ri.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_Rule := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Src_Rule) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Src_Rule, ri.PhonesPlus_Characteristics.PhonesPlus_Src_Rule);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf := IF(le.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf <> 0.0, le.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf, ri.PhonesPlus_Characteristics.PhonesPlus_Avg_Source_Conf);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Max_Source_Conf := IF(le.PhonesPlus_Characteristics.PhonesPlus_Max_Source_Conf <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Max_Source_Conf, ri.PhonesPlus_Characteristics.PhonesPlus_Max_Source_Conf);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf := IF(le.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf, ri.PhonesPlus_Characteristics.PhonesPlus_Min_Source_Conf);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf := IF(le.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf, ri.PhonesPlus_Characteristics.PhonesPlus_Total_Source_Conf);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen, ri.PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DID_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DID_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_DID_Type, ri.PhonesPlus_Characteristics.PhonesPlus_DID_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigName := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigName) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigName, ri.PhonesPlus_Characteristics.PhonesPlus_OrigName);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Address1 := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Address1) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Address1, ri.PhonesPlus_Characteristics.PhonesPlus_Address1);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Address2 := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Address2) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Address2, ri.PhonesPlus_Characteristics.PhonesPlus_Address2);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Address3 := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Address3) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Address3, ri.PhonesPlus_Characteristics.PhonesPlus_Address3);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigCity := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigCity) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigCity, ri.PhonesPlus_Characteristics.PhonesPlus_OrigCity);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigState := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigState) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigState, ri.PhonesPlus_Characteristics.PhonesPlus_OrigState);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigZip := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigZip) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigZip, ri.PhonesPlus_Characteristics.PhonesPlus_OrigZip);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhone := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPhone) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigPhone, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPhone);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Dob := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Dob) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Dob, ri.PhonesPlus_Characteristics.PhonesPlus_Dob);
		SELF.PhonesPlus_Characteristics.PhonesPlus_AgeGroup := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_AgeGroup) <> '', le.PhonesPlus_Characteristics.PhonesPlus_AgeGroup, ri.PhonesPlus_Characteristics.PhonesPlus_AgeGroup);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Gender := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Gender) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Gender, ri.PhonesPlus_Characteristics.PhonesPlus_Gender);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Email := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Email) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Email, ri.PhonesPlus_Characteristics.PhonesPlus_Email);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigListingType := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigListingType) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigListingType, ri.PhonesPlus_Characteristics.PhonesPlus_OrigListingType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_ListingType := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_ListingType) <> '', le.PhonesPlus_Characteristics.PhonesPlus_ListingType, ri.PhonesPlus_Characteristics.PhonesPlus_ListingType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Company := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Company) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Company, ri.PhonesPlus_Characteristics.PhonesPlus_Company);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierCode := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierCode) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierCode, ri.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierCode);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierName := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierName) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierName, ri.PhonesPlus_Characteristics.PhonesPlus_OrigCarrierName);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore := IF(le.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore <> 0, le.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore, ri.PhonesPlus_Characteristics.PhonesPlus_OrigConfScore);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigRecType := IF(le.PhonesPlus_Characteristics.PhonesPlus_OrigRecType <> 0, le.PhonesPlus_Characteristics.PhonesPlus_OrigRecType, ri.PhonesPlus_Characteristics.PhonesPlus_OrigRecType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_BDID := IF(le.PhonesPlus_Characteristics.PhonesPlus_BDID <> 0, le.PhonesPlus_Characteristics.PhonesPlus_BDID, ri.PhonesPlus_Characteristics.PhonesPlus_BDID);
		SELF.PhonesPlus_Characteristics.PhonesPlus_BDID_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_BDID_Score <> 0, le.PhonesPlus_Characteristics.PhonesPlus_BDID_Score, ri.PhonesPlus_Characteristics.PhonesPlus_BDID_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT, ri.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT, ri.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Last_Change_DT);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Dialable_Ind := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Dialable_Ind <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Append_Dialable_Ind, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Dialable_Ind);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Place_Name := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Place_Name) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_Place_Name, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Place_Name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Portability_Indicator := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Portability_Indicator <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Append_Portability_Indicator, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Portability_Indicator);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match, ri.PhonesPlus_Characteristics.PhonesPlus_Append_NonPublished_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_OCN := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_OCN) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_OCN, ri.PhonesPlus_Characteristics.PhonesPlus_Append_OCN);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Time_Zone := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Time_Zone) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_Time_Zone, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Time_Zone);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type, ri.PhonesPlus_Characteristics.PhonesPlus_Append_NXX_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_COCType := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_COCType) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_COCType, ri.PhonesPlus_Characteristics.PhonesPlus_Append_COCType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_SCC := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_SCC) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_SCC, ri.PhonesPlus_Characteristics.PhonesPlus_Append_SCC);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Use := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Use) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Use, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Phone_Use);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Agreg_Listing_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Agreg_Listing_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Agreg_Listing_Type, ri.PhonesPlus_Characteristics.PhonesPlus_Agreg_Listing_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score, ri.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score, ri.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score, ri.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Match) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Match, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone NOT IN [0, 8], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID NOT IN [0, 8], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr NOT IN [0, 8], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Ported_Match);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Seen_Once_Ind := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Seen_Once_Ind <> FALSE, le.PhonesPlus_Characteristics.PhonesPlus_Append_Seen_Once_Ind, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Seen_Once_Ind);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Phone_Cnt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag <> FALSE, le.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Latest_Phone_Owner_Flag := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Latest_Phone_Owner_Flag <> FALSE, le.PhonesPlus_Characteristics.PhonesPlus_Append_Latest_Phone_Owner_Flag, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Latest_Phone_Owner_Flag);
		SELF.PhonesPlus_Characteristics.PhonesPlus_HHID := IF(le.PhonesPlus_Characteristics.PhonesPlus_HHID <> 0, le.PhonesPlus_Characteristics.PhonesPlus_HHID, ri.PhonesPlus_Characteristics.PhonesPlus_HHID);
		SELF.PhonesPlus_Characteristics.PhonesPlus_HHID_Score := IF(le.PhonesPlus_Characteristics.PhonesPlus_HHID_Score <> 0, le.PhonesPlus_Characteristics.PhonesPlus_HHID_Score, ri.PhonesPlus_Characteristics.PhonesPlus_HHID_Score);
		// SELF.PhonesPlus_Characteristics.PhonesPlus_Phone7_HHID_Key := IF(TRIM((STRING)le.PhonesPlus_Characteristics.PhonesPlus_Phone7_HHID_Key) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Phone7_HHID_Key, ri.PhonesPlus_Characteristics.PhonesPlus_Phone7_HHID_Key);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag <> FALSE, le.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Best_Addr_Match_Flag);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Best_NM_Match_Flag := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Best_NM_Match_Flag <> FALSE, le.PhonesPlus_Characteristics.PhonesPlus_Append_Best_NM_Match_Flag, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Best_NM_Match_Flag);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RawAID := IF(le.PhonesPlus_Characteristics.PhonesPlus_RawAID <> 0, le.PhonesPlus_Characteristics.PhonesPlus_RawAID, ri.PhonesPlus_Characteristics.PhonesPlus_RawAID);
		SELF.PhonesPlus_Characteristics.PhonesPlus_CleanAID := IF(le.PhonesPlus_Characteristics.PhonesPlus_CleanAID <> 0, le.PhonesPlus_Characteristics.PhonesPlus_CleanAID, ri.PhonesPlus_Characteristics.PhonesPlus_CleanAID);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Current_Rec := IF(le.PhonesPlus_Characteristics.PhonesPlus_Current_Rec <> FALSE, le.PhonesPlus_Characteristics.PhonesPlus_Current_Rec, ri.PhonesPlus_Characteristics.PhonesPlus_Current_Rec);
		SELF.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date, ri.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date, ri.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date);
		
		SELF := le;
	END;
	
	rolledPhonesPlus := ROlLUP(withPhonesPlus, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone, 
															rollPhonesPlus(LEFT, RIGHT));
	
	// Clean up inconsistencies in the phones plus attributes data
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanPhonesPlusAttributes(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		// Blank out 0 dates so that a 0 is read as a missing in SAS
		SELF.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_First_Build_Date, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_NPA_Effective_DT, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneRegDate, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code := IF((INTEGER)le.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code = 0, '', le.PhonesPlus_Characteristics.PhonesPlus_Append_Prior_Area_Code);
																																																													
		// Blank out invalid Dates Of Birth (Future years, invalid months, invalid number of days, or if the date isn't able to calculate an age)
		cleanedDOB := IF((INTEGER)(le.PhonesPlus_Characteristics.PhonesPlus_Dob[1..4]) NOT BETWEEN 1850 AND STD.Date.Year(todays_date) OR 
										 (INTEGER)(le.PhonesPlus_Characteristics.PhonesPlus_Dob[5..6]) NOT BETWEEN 1 AND 12 OR
										 (INTEGER)(le.PhonesPlus_Characteristics.PhonesPlus_Dob[7..8]) NOT BETWEEN 1 AND ut.Month_Days((INTEGER)(le.PhonesPlus_Characteristics.PhonesPlus_Dob[1..6])) OR
										 TRIM(le.PhonesPlus_Characteristics.PhonesPlus_AgeGroup) = '',
									'', le.PhonesPlus_Characteristics.PhonesPlus_Dob);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Dob := cleanedDOB;
		
		// If the DOB isn't valid and populated we shouldn't be able to determine the age group
		SELF.PhonesPlus_Characteristics.PhonesPlus_AgeGroup := IF(TRIM(cleanedDOB) = '', '', le.PhonesPlus_Characteristics.PhonesPlus_AgeGroup);
		
		// Make sure the bitmap is correct
		setDidDateBit := (INTEGER)le.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt <> 0;
		setNameAddrBit := (INTEGER)le.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt <> 0;
		eda_match := le.PhonesPlus_Characteristics.PhonesPlus_EDA_Match;
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Match := MAP(setDidDateBit = TRUE AND setNameAddrBit = TRUE	=> eda_match[1..2] + '1' + eda_match[4] + '1' + eda_match[6..], // Set both the DID and Name/Addr Match Bits
																																setDidDateBit = TRUE AND setNameAddrBit = FALSE	=> eda_match[1..2] + '1' + eda_match[4..], // Set the DID Match Bit
																																setDidDateBit = FALSE AND setNameAddrBit = TRUE	=> eda_match[1..4] + '1' + eda_match[6..], // Set the Addr Name Match Bit
																																																									 eda_match);
		setDidDateBitHist := (INTEGER)le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt <> 0;
		setNameAddrBitHist := (INTEGER)le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt <> 0;
		eda_matchHist := le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match;
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match := MAP(setDidDateBitHist = TRUE AND setNameAddrBitHist = TRUE		=> eda_matchHist[1..2] + '1' + eda_matchHist[4] + '1' + eda_matchHist[6..], // Set both the DID and Name/Addr Match Bits
																																		 setDidDateBitHist = TRUE AND setNameAddrBitHist = FALSE	=> eda_matchHist[1..2] + '1' + eda_matchHist[4..], // Set the DID Match Bit
																																		 setDidDateBitHist = FALSE AND setNameAddrBitHist = TRUE	=> eda_matchHist[1..4] + '1' + eda_matchHist[6..], // Set the Addr Name Match Bit
																																																																 eda_matchHist);
		// Blank out DID's with no DID-Types
		SELF.PhonesPlus_Characteristics.PhonesPlus_DID := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DID_Type) = '', 0, le.PhonesPlus_Characteristics.PhonesPlus_DID);
		
		SELF := le;
	END;
	cleanedPhonesPlus := PROJECT(rolledPhonesPlus, cleanPhonesPlusAttributes(LEFT));
									
 // output(getPhoneFDID,named('gatr_FDID'));
 // output(withPhonesPlus,named('gatr_wPP'));
 // output(rolledPhonesPlus,named('gatr_rolledPP'));
 // output(withPhonesPlus(gathered_phone = '5598270214'),named('gatr_Filter'));
 // output(rolledPhonesPlus(gathered_phone = '5598270214'),named('gatr_rollFilter'));
	RETURN(cleanedPhonesPlus);
END;