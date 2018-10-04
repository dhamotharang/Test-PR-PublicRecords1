/*
	This modeling shell is for use by the Modeling team in Minneapolis for version 2.
 SAS requires that all field names be less than 32 characters
	long, and not have any '.' (DOT) notation in the name.  Because of this we must project the normal Phone Shell into this
	modeling layout which SAS can read in.  Phone_Shell.To_Modeling_Shell_v2 is used to convert the Phone Shell to this layout.

 v11 - experian removal
 v2  - Phone_Shell_v2, uses Boca/Consumer shell 5.4 (previous versions use 4.1)
*/
IMPORT Phone_Shell, Risk_Indicators;

Layout_ph_Shell_Input_Echo_Modeling := RECORD
	STRING50 AcctNo 									:= '';
	STRING20	ps_in_Fname							:= '';
	STRING120	ps_in_StreetAddress			:= '';
	STRING25	ps_in_City							:= '';
	STRING2		ps_in_State							:= '';
	STRING9		ps_in_ZipCode						:= '';
	STRING8		ps_in_DOB   						:= '';
	STRING9 	ps_SSNLength						:= '';
	STRING10	in_ph10									:= '';
	BOOLEAN		in_TargusGW_Enabled			:= FALSE;
	BOOLEAN		in_TUGW_Enabled					:= FALSE;
	BOOLEAN		in_INSGW_Enabled				:= FALSE;
	STRING8		in_Processing_Date			:= '';
	BOOLEAN  in_Burea_Enabled 				:= FALSE;
END;

Layout_Subject_Level_Modeling := RECORD
	INTEGER1 Subject_SSN_Mismatch 				:= -1;
END;

Layout_Sources_Modeling := RECORD
	STRING200 Source_List							:= '';
	STRING200 Source_List_Last_Seen		:= '';
	STRING200 Source_List_First_Seen	:= '';
END;

Layout_Raw_ph_Characteristics_Modeling := RECORD
	UNSIGNED1 Phone_Subject_Level := 0;
	STRING1 Phone_Switch_Type := ''; // 8 - Toll Free, C - Cell Phone, G - Pager, I - Puerto Rico/Virgin Islands, P - POTS, T - Time, U - Unknown, V - VOIP, W - Weather
	UNSIGNED1 Phone_High_Risk := 0;
	BOOLEAN Phone_Debt_Settlement := FALSE;
	BOOLEAN Phone_Disconnected := FALSE;
	UNSIGNED1 Phone_Zip_Match := 0;
	UNSIGNED1 Phone_Timezone_Match := 0;
	STRING4 Phone_Timezone := '';
	STRING4 Address_Zipcode_Timezone := '';
	STRING30 Phone_Match_Code := '';
	UNSIGNED2 Phone_Business_Count := 0;
	STRING35 Phone_Subject_Title := '';
END;

Layout_phsPlus_Characteristics_Modeling := RECORD
	STRING1 PP_Type := ''; // B - Business, R - Residential, M - Mobile, U - Unknown
	STRING10 PP_Source := '';
	STRING20 PP_Carrier := '';
	STRING25 PP_City := '';
	STRING2 PP_State := '';
	STRING1 PP_RP_Type := '';
	STRING10 PP_RP_Source := '';
	STRING20 PP_RP_Carrier := '';
	STRING25 PP_RP_City := '';
	STRING2 PP_RP_State := '';
	UNSIGNED1 PP_Confidence := 0; // 0 = Below The Line, 11 = Above The Line
	STRING64 PP_Rules := '0000000000000000000000000000000000000000000000000000000000000000'; // Bit string similar to Data Restriction Mask
	UNSIGNED8 PP_DID := 0;
	UNSIGNED1 PP_DID_Score := 0;
	STRING50 PP_Listing_Name := '';
	STRING8 PP_DateFirstSeen := '';
	STRING8 PP_DateLastSeen := '';
	STRING8 PP_DateVendorFirstSeen := '';
	STRING8 PP_DateVendorLastSeen := '';
	STRING8 PP_Date_NonGLB_LastSeen := '';
	STRING1 PP_GLB_DPPA_fl := '';
	STRING50 PP_GLB_DPPA_All := '';
	STRING2 PP_Src := '';
	STRING64 PP_Src_All := '0000000000000000000000000000000000000000000000000000000000000000';
	UNSIGNED1 PP_Src_Cnt := 0;
	STRING64 PP_Src_Rule := '0000000000000000000000000000000000000000000000000000000000000000';
	DECIMAL4_2 PP_Avg_Source_Conf := 0.00;
	UNSIGNED1 PP_Max_Source_Conf := 5; // 5 indicates lowest confidence score
	UNSIGNED1 PP_Min_Source_Conf := 5; // 5 indicates lowest confidence score
	UNSIGNED2 PP_Total_Source_Conf := 5; // 5 indicates lowest confidence score
	STRING8 PP_Orig_LastSeen := '';
	STRING10 PP_DID_Type := '';
	STRING20 PP_OrigName := '';
	STRING120 PP_Address1 := '';
	STRING120 PP_Address2 := '';
	STRING120 PP_Address3 := '';
	STRING25 PP_OrigCity := '';
	STRING2 PP_OrigState := '';
	STRING9 PP_OrigZip := '';
	STRING10 PP_OrigPhone := '';
	STRING8 PP_Dob := '';
	STRING3 PP_AgeGroup := '';
	STRING1 PP_Gender := '';
	STRING50 PP_Email := '';
	STRING25 PP_OrigListingType := '';
	STRING25 PP_ListingType := '';
	STRING1 PP_OrigPublishCode := '';
	STRING1 PP_OrigPhoneType := '';
	STRING1 PP_OrigPhoneUsage := '';
	STRING100 PP_Company := '';
	STRING8 PP_OrigPhoneRegDate := '';
	STRING20 PP_OrigCarrierCode := '';
	STRING20 PP_OrigCarrierName := '';
	UNSIGNED1 PP_OrigConfScore := 5; // 5 means we don't know much about the phone
	UNSIGNED1 PP_OrigRecType := 0;
	UNSIGNED8 PP_BDID := 0;
	UNSIGNED2 PP_BDID_Score := 0;
	STRING8 PP_app_NPA_Effective_DT := '';
	STRING8 PP_app_NPA_Last_Change_DT := '';
	UNSIGNED1 PP_app_Dialable_Ind := 0;
	STRING50 PP_app_Place_Name := '';
	UNSIGNED1 PP_app_Portability_Indicator := 0;
	STRING100 PP_app_Prior_Area_Code := '';
	STRING64 PP_app_NonPublished_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	STRING20 PP_app_OCN := '';
	STRING1 PP_app_Time_Zone := '';
	STRING3 PP_app_NXX_Type := '';
	STRING5 PP_app_COCType := '';
	STRING1 PP_app_SCC := '';
	STRING30 PP_app_ph_Type := '';
	UNSIGNED1 PP_app_Company_Type := 0;
	STRING1 PP_app_ph_Use := '';
	STRING500 PP_Agreg_Listing_Type := '';
	UNSIGNED1 PP_Max_Orig_Conf_Score := 0;
	UNSIGNED1 PP_Min_Orig_Conf_Score := 0;
	UNSIGNED1 PP_Curr_Orig_Conf_Score := 0;
	STRING64 PP_EDA_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	STRING8 PP_EDA_ph_Dt := '';
	STRING8 PP_EDA_DID_Dt := '';
	STRING8 PP_EDA_NM_Addr_Dt := '';
	STRING64 PP_EDA_Hist_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	STRING8 PP_EDA_Hist_ph_Dt := '';
	STRING8 PP_EDA_Hist_DID_Dt := '';
	STRING8 PP_EDA_Hist_Nm_Addr_Dt := '';
	UNSIGNED1 PP_app_fb_ph := 8; // 8 means we don't have much info on this phone
	STRING8 PP_app_fb_ph_Dt := '';
	UNSIGNED1 PP_app_fb_ph7_DID := 8; // 8 means we don't have much info on this phone
	STRING8 PP_app_fb_ph7_DID_Dt := '';
	UNSIGNED1 PP_app_fb_ph7_NM_Addr := 8; // 8 means we don't have much info on this phone
	STRING8 PP_app_fb_ph7_NM_Addr_Dt := '';
	STRING64 PP_app_Ported_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	BOOLEAN PP_app_Seen_Once_Ind := FALSE;
	UNSIGNED2 PP_app_ind_ph_Cnt := 0;
	BOOLEAN PP_app_ind_Has_actv_EDA_ph_fl := FALSE;
	BOOLEAN PP_app_Latest_ph_Owner_fl := FALSE;
	UNSIGNED8 PP_HHID := 0;
	UNSIGNED2 PP_HHID_Score := 0;
	BOOLEAN PP_app_Best_Addr_Match_fl := FALSE;
	BOOLEAN PP_app_Best_NM_Match_fl := FALSE;
	UNSIGNED8 PP_RawAID := 0;
	UNSIGNED8 PP_CleanAID := 0;
	BOOLEAN PP_Current_Rec := FALSE;
	STRING8 PP_First_Build_Date := '';
	STRING8 PP_Last_Build_Date := '';
END;

Layout_ph_fb_Modeling := RECORD
	STRING8 Phone_fb_Date := '';
	UNSIGNED1 Phone_fb_Result := 0;
	STRING20 Phone_fb_First := '';
	STRING20 Phone_fb_Middle := '';
	STRING20 Phone_fb_Last := '';
	STRING8 Phone_fb_Last_RPC_Date := '';
	STRING8 Phone_fb_RP_Date := '';
	UNSIGNED1 Phone_fb_RP_Result := 0;
	STRING20 Phone_fb_RP_First := '';
	STRING20 Phone_fb_RP_Middle := '';
	STRING20 Phone_fb_RP_Last := '';
	STRING8 Phone_fb_RP_Last_RPC_Date := '';
END;

Layout_Inquiries_Modeling := RECORD
	STRING8 Inq_Num := 0;
	STRING8 Inq_Num_06 := 0;
	STRING8 Inq_Num_Addresses := 0;
	STRING8 Inq_Num_Addresses_06 := 0;
	STRING8 Inq_Num_ADLs := 0;
	STRING8 Inq_Num_ADLs_06 := 0;
	STRING8 Inq_FirstSeen := 0;
	STRING8 Inq_LastSeen := 0;
	STRING8 Inq_ADL_FirstSeen := 0;
	STRING8 Inq_ADL_LastSeen := 0;
	STRING200 Inq_ADL_ph_Industry_List_12 := 0;
END;

Layout_Internal_Corroboration_Modeling := RECORD
	BOOLEAN Internal_Verification := FALSE;
	STRING8 Internal_ver_First_Seen := '';
	STRING8 Internal_ver_Last_Seen := '';
	STRING15 Internal_ver_Match_Types := '';
END;

Layout_EDA_Characteristics_Modeling := RECORD
	STRING1 EDA_Omit_Locality := '';
	UNSIGNED8 EDA_DID := 0;
	UNSIGNED8 EDA_HHID := 0;
	UNSIGNED8 EDA_BDID := 0;
	STRING100 EDA_Listing_Name := '';
	UNSIGNED3 EDA_DID_Count := 0;
	STRING8 EDA_Dt_First_Seen := '';
	STRING8 EDA_Dt_Last_Seen := '';
	BOOLEAN EDA_Current_Record_fl := FALSE;
	STRING8 EDA_Deletion_Date := '';
	UNSIGNED2 EDA_Disc_Cnt6 := 0;
	UNSIGNED2 EDA_Disc_Cnt12 := 0;
	UNSIGNED2 EDA_Disc_Cnt18 := 0;
	STRING2 EDA_Pfrd_Address_Ind := '';
	UNSIGNED4 EDA_Days_In_Service := 0;
	UNSIGNED2 EDA_Num_ph_Owners_Hist := 0;
	UNSIGNED2 EDA_Num_ph_Owners_Cur := 0;
	UNSIGNED2 EDA_Num_phs_ind := 0;
	UNSIGNED2 EDA_Num_phs_Connected_ind := 0;
	UNSIGNED2 EDA_Num_phs_Discon_ind := 0;
	UNSIGNED4 EDA_Avg_Days_Connected_ind := 0;
	UNSIGNED4 EDA_Min_Days_Connected_ind := 0;
	UNSIGNED4 EDA_Max_Days_Connected_ind := 0;
	UNSIGNED4 EDA_Days_ind_First_Seen := 0;
	UNSIGNED4 EDA_Days_ind_First_Seen_w_ph := 0;
	UNSIGNED4 EDA_Days_ph_First_Seen := 0;
	BOOLEAN EDA_Address_Match_Best := FALSE;
	UNSIGNED3 EDA_Months_Addr_Last_Seen := 0;
	UNSIGNED4 EDA_Num_phs_Connected_Addr := 0;
	UNSIGNED4 EDA_Num_phs_Discon_Addr := 0;
	UNSIGNED4 EDA_Num_phs_Connected_HHID := 0;
	UNSIGNED4 EDA_Num_phs_Discon_HHID := 0;
	BOOLEAN EDA_Is_Discon_15_Days := FALSE;
	BOOLEAN EDA_Is_Discon_30_Days := FALSE;
	BOOLEAN EDA_Is_Discon_60_Days := FALSE;
	BOOLEAN EDA_Is_Discon_90_Days := FALSE;
	BOOLEAN EDA_Is_Discon_180_Days := FALSE;
	BOOLEAN EDA_Is_Discon_360_Days := FALSE;
	BOOLEAN EDA_Is_Current_In_Hist := FALSE;
	UNSIGNED2 EDA_Num_Interrupts_Cur := 0;
	UNSIGNED4 EDA_Avg_Days_Interrupt := 0;
	UNSIGNED4 EDA_Min_Days_Interrupt := 0;
	UNSIGNED4 EDA_Max_Days_Interrupt := 0;
	BOOLEAN EDA_Has_Cur_Discon_15_Days := FALSE;
	BOOLEAN EDA_Has_Cur_Discon_30_Days := FALSE;
	BOOLEAN EDA_Has_Cur_Discon_60_Days := FALSE;
	BOOLEAN EDA_Has_Cur_Discon_90_Days := FALSE;
	BOOLEAN EDA_Has_Cur_Discon_180_Days := FALSE;
	BOOLEAN EDA_Has_Cur_Discon_360_Days := FALSE;
END;

Layout_Bureau_Modeling := RECORD
	BOOLEAN Bureau_Verified := FALSE;
	STRING8 Bureau_Last_Update := '';
END;

EXPORT Layout_Modeling_Shell_v2 := RECORD
	Layout_ph_Shell_Input_Echo_Modeling; //modified for v11
	Layout_Subject_Level_Modeling; //modified for v11
	STRING10 Gathered_Ph := '';
	Layout_Sources_Modeling;
	Layout_Raw_ph_Characteristics_Modeling;
	Layout_phsPlus_Characteristics_Modeling;
	Layout_ph_fb_Modeling;
	Layout_Inquiries_Modeling;
	Layout_Internal_Corroboration_Modeling;
	Layout_Bureau_Modeling; //new in v11
	Layout_EDA_Characteristics_Modeling;
	Risk_Indicators.Layout_Boca_Shell_Edina_v54; // Boca Shell v5.4 Fields
	STRING3 Phone_Model_Score := '';
END;