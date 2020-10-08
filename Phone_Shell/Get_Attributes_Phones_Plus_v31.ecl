/* ************************************************************************
 * This function gathers the Phonesplus_Characteristics attributes.		   		*
 ************************************************************************ */

IMPORT AutoKey, Data_Services, Phone_Shell, Phones, Phonesplus_v2, RiskWise, UT, STD, doxie, Suppress;

DEBUG_IGNORE_ALLOW_LIST := FALSE; // Set to TRUE if you do NOT want to filter by allow list

todays_date := STD.Date.Today();

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Phones_Plus_v31 (
    DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, 
			 UNSIGNED1 GLBPurpose, 
			 UNSIGNED1 DPPAPurpose, 
			 STRING30 IndustryClass, 
			 STRING DataRestrictionMask,
    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
			) := FUNCTION
      
  // Use the new shared source-level PhonesPlus function to get those attributes first, then below will resume
  // with the remainder from the previous rolled-up PhonesPlus keys  
  sourceLevel_Input := PROJECT(input, TRANSFORM(Phones.Layouts.SourceLevelAttributes.BatchIn,
                                      SELF.seq := left.unique_record_sequence;
                                      SELF.did := left.did;
                                      SELF.phone := left.gathered_phone));
                                      
  sourceLevel_Attributes := Phones.GetSourceLevelPhonesPlus(sourceLevel_Input, mod_access);
  
  Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getSourceLevel_Attributes(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, 
                                                                                   sourceLevel_Attributes ri) := TRANSFORM
    // insert all attributes we are grabbing from the source-level function here
    SELF.PhonesPlus_Characteristics.PhonesPlus_Rules := STD.Str.Reverse(ut.IntegerToBinaryString(ri.source_rules, FALSE));
    
    // comma-delimited lists
    SELF.PhonesPlus_Characteristics.PhonesPlus_DID_Score_List := ri.source_did_scores;
    SELF.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen := ri.source_date_first_seen;
		  SELF.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen  := ri.source_date_last_seen;
    SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen  := ri.source_date_vendor_first_reported;
		  SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen   := ri.source_date_vendor_last_reported;
		  SELF.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen := ri.source_dt_nonglb_last_seen;
    SELF.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag := TRIM(ri.source_glb_dppa_flags);
    SELF.PhonesPlus_Characteristics.PhonesPlus_Household_Flags := ri.source_household_flags;
    
    // source list info
    SELF.PhonesPlus_Characteristics.PhonesPlus_Src_List := ri.source_codes; // comma-delimited list of source codes (IQ, UT, etc)
    Src_All := STD.Str.Reverse(ut.IntegerToBinaryString(ri.source_bitmap, FALSE)); // bitmap version of list
    SELF.PhonesPlus_Characteristics.PhonesPlus_Src_All := Src_All;
    SELF.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt := STD.Str.FindCount(Src_All, '1'); // count all 1's in bitmap
    
    // Other new additions
    SELF.PhonesPlus_Characteristics.PhonesPlus_DID_Count := ri.phone_did_count;
    SELF.PhonesPlus_Characteristics.PhonesPlus_Phone_Last_Seen_Diff_DID := Phone_Shell.Common.parseDate((STRING)ri.phone_last_seen_date_diff_lexid, TRUE);
    SELF.PhonesPlus_Characteristics.PhonesPlus_Phone_Vendor_Last_Seen_Diff_DID := Phone_Shell.Common.parseDate((STRING)ri.phone_vendor_last_seen_diff_lexid, TRUE);
    
    SELF := le;
  END;
  
  getPhoneSourceLevel := JOIN(Input, sourceLevel_Attributes,
                              LEFT.Unique_Record_Sequence = RIGHT.seq AND
                               LEFT.DID = RIGHT.did AND
                               LEFT.Gathered_Phone = RIGHT.phone,
                              getSourceLevel_Attributes(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
			 
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
	 getPhoneFDID := JOIN(getPhoneSourceLevel, PhoneAutoKey, 
                       TRIM(LEFT.Gathered_Phone) NOT IN ['', '0'] AND 
                        KEYED(RIGHT.p7 = LEFT.Gathered_Phone[4..10]) AND 
                        KEYED(RIGHT.p3 = LEFT.Gathered_Phone[1..3]),
     																		getFDID(LEFT, RIGHT), KEEP(500), ATMOST(RiskWise.max_atmost));
																		
	 {unsigned4 global_sid, string pplastseen, string ppvendorlastseen, unsigned ppdid, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus} getPhonesPlusAttributes(layoutPPTemp le, Phonesplus_v2.key_phonesplus_fdid ri) := TRANSFORM
		  SELF.global_sid := ri.global_sid;
    SELF.pplastseen := Phone_Shell.Common.parseDate((STRING)ri.datelastseen, TRUE);
    SELF.ppvendorlastseen := Phone_Shell.Common.parseDate((STRING)ri.datevendorlastreported, TRUE);
    SELF.ppdid := ri.did;
		  PhonesPlusSources := ['PPFA', 'PPLA', 'PPFLA', 'PPLFA', 'PPCA', 'PPDID', 'PPTH'];

    // For PPDIDs, if we got them from the unrolled key they won't have this info populated, so we need to fill it in.
    listType := TRIM(ri.listingtype);
		  PPType := MAP(TRIM(ri.append_phone_type) = 'CELL' => 'M',
																		listType = 'R' 	           									=> 'R',
																		listType = 'B' 				           						=> 'B',
																		listType = 'RB' 	          									=> 'B',
																		listType = 'M'           											=> 'M',
																																																	        'U');		
    
    // ones that need to be filled in are marked as 'X' (note there is NO other way to get an X here)
    // else keep what we have (whether blank or normal value from gather-phones)
    SELF.PhonesPlus_Characteristics.PhonesPlus_Type := IF(le.PhonesPlus_Characteristics.PhonesPlus_Type = 'X', PPType, 
                                                          le.PhonesPlus_Characteristics.PhonesPlus_Type);
				
    // these were also given an 'X' if they were found in the unrolled key, so populate them
    // otherwise keep what we have from gather-phones
		  SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := IF(le.PhonesPlus_Characteristics.PhonesPlus_Carrier = 'X', TRIM(ri.append_ocn),
                                                             le.PhonesPlus_Characteristics.PhonesPlus_Carrier);
		  SELF.PhonesPlus_Characteristics.PhonesPlus_City    := IF(le.PhonesPlus_Characteristics.PhonesPlus_City = 'X', TRIM(ri.append_place_name),
                                                             le.PhonesPlus_Characteristics.PhonesPlus_City);
		  SELF.PhonesPlus_Characteristics.PhonesPlus_State   := IF(le.PhonesPlus_Characteristics.PhonesPlus_State = 'X', TRIM(ri.state),
                                                             le.PhonesPlus_Characteristics.PhonesPlus_State);
		
		  // Only populate the Reverse Phone attributes if we don't already have DID based PP Attributes populated
		  reversePhoneLookup := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Type) = '' AND TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Carrier) = '' AND 
                             TRIM(le.PhonesPlus_Characteristics.PhonesPlus_City) = '' AND TRIM(le.PhonesPlus_Characteristics.PhonesPlus_State) = '' AND 
                             TRIM(le.Sources.Source_List) NOT IN PhonesPlusSources, TRUE, FALSE);
														 
		  SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Type := IF(reversePhoneLookup, PPType, '');

		  SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier := IF(reversePhoneLookup, TRIM(ri.append_ocn), '');
		  SELF.PhonesPlus_Characteristics.PhonesPlus_RP_City    := IF(reversePhoneLookup, TRIM(ri.append_place_name), '');
		  SELF.PhonesPlus_Characteristics.PhonesPlus_RP_State   := IF(reversePhoneLookup, TRIM(ri.state), '');
		
		  // Gather the remainder of the Phones Plus attributes
		  SELF.PhonesPlus_Characteristics.PhonesPlus_Confidence := ri.confidencescore;
		  SELF.PhonesPlus_Characteristics.PhonesPlus_Listing_Name  := TRIM(ri.origname);
    
		  SELF.PhonesPlus_Characteristics.PhonesPlus_OrigListingType := IF(TRIM(ri.orig_listing_type) NOT IN ['R', 'RB', 'B', 'G', 'BG'], '', TRIM(ri.orig_listing_type));
		  SELF.PhonesPlus_Characteristics.PhonesPlus_ListingType := IF(TRIM(ri.listingtype) NOT IN ['R', 'RB', 'B', 'G', 'BG'], '', TRIM(ri.listingtype));
		  SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode := IF(TRIM(ri.orig_publish_code) = 'U', '', TRIM(ri.orig_publish_code));
		  SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType := TRIM(ri.orig_phone_type);
		  SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage := TRIM(ri.orig_phone_usage);
    
		  SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type := (INTEGER)ri.append_company_type;
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
		
		  SELF := le;
	 END;
	
	 withPhonesPlusTemp_unsuppressed := JOIN(getPhoneFDID, Phonesplus_v2.key_phonesplus_fdid, LEFT.FDID <> 0 AND KEYED(LEFT.FDID = RIGHT.FDID) AND
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
	
  pplayout := RECORD
    unsigned4 global_sid;
    string pplastseen;
    string ppvendorlastseen;
    unsigned ppdid;
    phone_shell.layout_phone_shell.layout_phone_shell_plus;
  END;
  withPhonesPlusTemp := Suppress.Suppress_ReturnOldLayout(withPhonesPlusTemp_unsuppressed, mod_access, 
       //Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus);
       pplayout);
	
  // Keep the most confident/recent phones plus data possible (some of these are no longer populated. FIX)
  // the date first/last seens are all the same, populated from the sourcelevel shared function so that's not really sorting on anything...
	/*withPhonesPlus := SORT(withPhonesPlusTemp, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, -PhonesPlus_Characteristics.PhonesPlus_Confidence, 
                                            -PhonesPlus_Characteristics.PhonesPlus_DateLastSeen, -PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen, 
                                            -PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen, -PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen, 
                                            //-PhonesPlus_Characteristics.PhonesPlus_Orig_LastSeen, -PhonesPlus_Characteristics.PhonesPlus_DID, 
                                           // -PhonesPlus_Characteristics.PhonesPlus_BDID, 
                                           -PhonesPlus_Characteristics.PhonesPlus_EDA_Match//, 
                                          //  PhonesPlus_Characteristics.PhonesPlus_HHID, PhonesPlus_Characteristics.PhonesPlus_CleanAID, 
                                           // -PhonesPlus_Characteristics.PhonesPlus_Current_Rec, -PhonesPlus_Characteristics.PhonesPlus_Last_Build_Date, 
                                            //-PhonesPlus_Characteristics.PhonesPlus_First_Build_Date
                                            );
*/
withPhonesPlus := SORT(withPhonesPlusTemp, Unique_Record_Sequence, Clean_Input.Seq, Gathered_Phone, -(ppdid=did), -pplastseen, -ppvendorlastseen,
                       -phonesplus_characteristics.phonesplus_datefirstseen, -phonesplus_characteristics.phonesplus_datevendorfirstseen,
                       -phonesplus_characteristics.phonesplus_eda_match);
	
	pplayout rollPhonesPlus(pplayout le, pplayout ri) := TRANSFORM
		// Since we sorted above, le. contains the most relevant data, but use ri. to fill in any missing data
		SELF.PhonesPlus_Characteristics.PhonesPlus_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Type, ri.PhonesPlus_Characteristics.PhonesPlus_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Carrier := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Carrier) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Carrier, ri.PhonesPlus_Characteristics.PhonesPlus_Carrier);
		SELF.PhonesPlus_Characteristics.PhonesPlus_City := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_City) <> '', le.PhonesPlus_Characteristics.PhonesPlus_City, ri.PhonesPlus_Characteristics.PhonesPlus_City);
		SELF.PhonesPlus_Characteristics.PhonesPlus_State := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_State) <> '', le.PhonesPlus_Characteristics.PhonesPlus_State, ri.PhonesPlus_Characteristics.PhonesPlus_State);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Type := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_Type) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_Type, ri.PhonesPlus_Characteristics.PhonesPlus_RP_Type);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier, ri.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_City := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_City) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_City, ri.PhonesPlus_Characteristics.PhonesPlus_RP_City);
		SELF.PhonesPlus_Characteristics.PhonesPlus_RP_State := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_RP_State) <> '', le.PhonesPlus_Characteristics.PhonesPlus_RP_State, ri.PhonesPlus_Characteristics.PhonesPlus_RP_State);
		// SELF.PhonesPlus_Characteristics.PhonesPlus_Confidence := IF(le.PhonesPlus_Characteristics.PhonesPlus_Confidence <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Confidence, ri.PhonesPlus_Characteristics.PhonesPlus_Confidence);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Confidence := IF(le.PhonesPlus_Characteristics.PhonesPlus_Confidence <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Confidence, 
                                                              IF(le.did = ri.ppdid, ri.PhonesPlus_Characteristics.PhonesPlus_Confidence, le.PhonesPlus_Characteristics.PhonesPlus_Confidence));
		SELF.PhonesPlus_Characteristics.PhonesPlus_Rules := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Rules) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Rules, ri.PhonesPlus_Characteristics.PhonesPlus_Rules);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Listing_Name := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Listing_Name) <> '', le.PhonesPlus_Characteristics.PhonesPlus_Listing_Name, ri.PhonesPlus_Characteristics.PhonesPlus_Listing_Name);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen, ri.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen, ri.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen);
		SELF.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag := MAP(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) <> TRIM(ri.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) AND 
                                                                   TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) IN ['G', 'D', 'B'] AND 
																																		                                	TRIM(ri.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) IN ['G', 'D', 'B'] 					 => 'B',
																																		                                TRIM(le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag) <> '' 																			 => le.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag,
																																																																																																			                                                         ri.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_All := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Src_All) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Src_All, ri.PhonesPlus_Characteristics.PhonesPlus_Src_All);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt := IF(le.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt, ri.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigListingType := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigListingType) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigListingType, ri.PhonesPlus_Characteristics.PhonesPlus_OrigListingType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_ListingType := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_ListingType) <> '', le.PhonesPlus_Characteristics.PhonesPlus_ListingType, ri.PhonesPlus_Characteristics.PhonesPlus_ListingType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType);
		SELF.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage) <> '', le.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage, ri.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage);
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type := IF(le.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type <> 0, le.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type, ri.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type);
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
		
		SELF := le;
	END;
	
	rolledPhonesPlus := ROlLUP(withPhonesPlus, LEFT.Unique_Record_Sequence = RIGHT.Unique_Record_Sequence AND LEFT.Clean_Input.Seq = RIGHT.Clean_Input.Seq AND LEFT.Gathered_Phone = RIGHT.Gathered_Phone, 
															rollPhonesPlus(LEFT, RIGHT));
	
	// Clean up inconsistencies in the phones plus attributes data
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus cleanPhonesPlusAttributes(pplayout le) := TRANSFORM
		// Blank out 0 dates so that a 0 is read as a missing in SAS
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen, '');
		SELF.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen := IF(TRIM(le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen) NOT IN ['', '0'], le.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen, '');
																																																													
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
                                                                                                                                 
		SELF := le;
	END;
	cleanedPhonesPlus := PROJECT(rolledPhonesPlus, cleanPhonesPlusAttributes(LEFT));
									
 // output(sourceLevel_Attributes,named('gatr_srcPPfunc'));
 // output(getPhoneSourceLevel,named('gatr_srcPPoutput'));
 // output(getPhoneFDID,named('gatr_FDID'));
 // output(withPhonesPlusTemp_unsuppressed,named('gatr_wPPbeforeSuppressed'));
 // output(withPhonesPlus,named('gatr_wPP'));
 // output(rolledPhonesPlus,named('gatr_rolledPP'));
 // output(withPhonesPlus(gathered_phone = '5598270214'),named('gatr_Filter'));
 // output(rolledPhonesPlus(gathered_phone = '5598270214'),named('gatr_rollFilter'));
	RETURN(cleanedPhonesPlus);
END;