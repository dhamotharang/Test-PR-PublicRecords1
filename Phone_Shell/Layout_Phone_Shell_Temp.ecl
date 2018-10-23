// This is a static layout for us to use RiskWise.shortcuts.validation_phone_shell95k_41
IMPORT IESP, Phone_Shell, Progressive_Phone, Risk_Indicators, RiskWise, UT;

EXPORT Layout_Phone_Shell_Temp := MODULE

EXPORT Layout_Boca_Shell_Plus := RECORD
	Risk_Indicators.Layout_Boca_Shell;
END;
EXPORT Layout_Dedup_Hist_Phone := RECORD
		STRING20 acctno := '';
		STRING10 phone10 := '';
END;

EXPORT Input := RECORD
	UNSIGNED4 seq := 0;
	STRING50 AcctNo := '';
	UNSIGNED6 DID := 0;
	STRING120 FullName := '';
	STRING20 NamePrefix := '';
	STRING20 FirstName := '';
	STRING20 MiddleName := '';
	STRING20 LastName := '';
	STRING5 TitleName := '';
	STRING5 SuffixName := '';
	STRING120 StreetAddress1 := '';
	STRING120 StreetAddress2 := '';
	STRING25 City := '';
	STRING2 State := '';
	STRING9 Zip := '';
	
	STRING10 Prim_Range := '';
	STRING2 Predir := '';
	STRING28 Prim_Name := '';
	STRING4 Addr_Suffix := '';
	STRING2 Postdir := '';
	STRING10 Unit_Desig := '';
	STRING8 Sec_Range := '';
	STRING5 Zip5 := '';
	STRING4 Zip4 := '';
	STRING10 Lat := '';
	STRING11 Long := '';
	STRING3 County := '';
	STRING7 Geo_Block := '';
	STRING1 Addr_Type := '';
	STRING4 Addr_Status := '';
	
	STRING9 SSN := '';
	STRING8 DateOfBirth := '';
	STRING3 Age := '';
	
	STRING10 HomePhone := '';
	STRING10 WorkPhone := '';
	
	BOOLEAN ExperianGatewayEnabled := FALSE;
	BOOLEAN TargusGatewayEnabled := FALSE;
	BOOLEAN TransUnionGatewayEnabled := FALSE;
	BOOLEAN InsuranceGatewayEnabled := FALSE;
	DATASET(Layout_Dedup_Hist_Phone) InputPhoneList := DATASET([],Layout_Dedup_Hist_Phone);
END;

EXPORT Layout_Phone_Shell_Input_Echo := RECORD
	UNSIGNED4	seq											:= 0; // This should match the seq in the Boca Shell, record for record
	UNSIGNED6 LexID										:= 0;
	STRING50	AcctNo									:= '';
	STRING20	in_FName								:= '';
	STRING20	in_MName								:= '';
	STRING20	in_LName								:= '';
	STRING5		in_SName								:= '';
	STRING120	in_StreetAddress				:= '';
	STRING25	in_City									:= '';
	STRING2		in_State								:= '';
	STRING9		in_ZipCode							:= '';
	STRING8		in_DOB									:= '';
	STRING9		in_SSN									:= '';
	STRING10	in_Phone10							:= '';
	STRING10	in_WPhone10							:= '';
	BOOLEAN		in_EXPGW_Enabled				:= FALSE;
	BOOLEAN		in_TargusGW_Enabled			:= FALSE;
	BOOLEAN		in_TUGW_Enabled					:= FALSE;
	BOOLEAN		in_INSGW_Enabled				:= FALSE;
	STRING8		in_Processing_Date			:= '';
	BOOLEAN  in_Burea_Enabled				 := FALSE;
END;

EXPORT Layout_Subject_Level := RECORD
	INTEGER1 Subject_SSN_Mismatch 						:= -1;
	UNSIGNED1 Experian_Num_Duplicate 					:= 0;
	UNSIGNED1 Experian_Num_Insufficient_Score	:= 0;
END;

EXPORT Layout_Sources := RECORD
	STRING200 Source_List								:= '';
	STRING200 Source_Owner_DID        	:= '';
	STRING200 Source_Owner_Name_Prefix	:= '';
	STRING200 Source_Owner_Name_First   := '';
	STRING200 Source_Owner_Name_Middle	:= '';
	STRING200 Source_Owner_Name_Last		:= '';
	STRING200 Source_Owner_Name_Suffix	:= '';
	STRING200 Source_List_Last_Seen			:= '';
	STRING200 Source_List_First_Seen		:= '';
END;

EXPORT Layout_Raw_Phone_Characteristics := RECORD
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

EXPORT Layout_PhonesPlus_Characteristics := RECORD
	STRING1 PhonesPlus_Type := ''; // B - Business, R - Residential, M - Mobile, U - Unknown
	STRING10 PhonesPlus_Source := '';
	STRING20 PhonesPlus_Carrier := '';
	STRING25 PhonesPlus_City := '';
	STRING2 PhonesPlus_State := '';
	STRING1 PhonesPlus_RP_Type := '';
	STRING10 PhonesPlus_RP_Source := '';
	STRING20 PhonesPlus_RP_Carrier := '';
	STRING25 PhonesPlus_RP_City := '';
	STRING2 PhonesPlus_RP_State := '';
	UNSIGNED1 PhonesPlus_Confidence := 0; // 0 = Below The Line, 11 = Above The Line
	STRING64 PhonesPlus_Rules := '0000000000000000000000000000000000000000000000000000000000000000'; // Bit string similar to Data Restriction Mask
	UNSIGNED8 PhonesPlus_DID := 0;
	UNSIGNED1 PhonesPlus_DID_Score := 0;
	STRING50 PhonesPlus_Listing_Name := '';
	STRING8 PhonesPlus_DateFirstSeen := '';
	STRING8 PhonesPlus_DateLastSeen := '';
	STRING8 PhonesPlus_DateVendorFirstSeen := '';
	STRING8 PhonesPlus_DateVendorLastSeen := '';
	STRING8 PhonesPlus_Date_NonGLB_LastSeen := '';
	STRING1 PhonesPlus_GLB_DPPA_Flag := '';
	STRING50 PhonesPlus_GLB_DPPA_All := '';
	STRING2 PhonesPlus_Src := '';
	STRING64 PhonesPlus_Src_All := '0000000000000000000000000000000000000000000000000000000000000000';
	UNSIGNED1 PhonesPlus_Src_Cnt := 0;
	STRING64 PhonesPlus_Src_Rule := '0000000000000000000000000000000000000000000000000000000000000000';
	DECIMAL4_2 PhonesPlus_Avg_Source_Conf := 0.00;
	UNSIGNED1 PhonesPlus_Max_Source_Conf := 5; // 5 indicates lowest confidence score
	UNSIGNED1 PhonesPlus_Min_Source_Conf := 5; // 5 indicates lowest confidence score
	UNSIGNED2 PhonesPlus_Total_Source_Conf := 5; // 5 indicates lowest confidence score
	STRING8 PhonesPlus_Orig_LastSeen := '';
	STRING10 PhonesPlus_DID_Type := '';
	STRING20 PhonesPlus_OrigName := '';
	STRING120 PhonesPlus_Address1 := '';
	STRING120 PhonesPlus_Address2 := '';
	STRING120 PhonesPlus_Address3 := '';
	STRING25 PhonesPlus_OrigCity := '';
	STRING2 PhonesPlus_OrigState := '';
	STRING9 PhonesPlus_OrigZip := '';
	STRING10 PhonesPlus_OrigPhone := '';
	STRING8 PhonesPlus_Dob := '';
	STRING3 PhonesPlus_AgeGroup := '';
	STRING1 PhonesPlus_Gender := '';
	STRING50 PhonesPlus_Email := '';
	STRING25 PhonesPlus_OrigListingType := '';
	STRING25 PhonesPlus_ListingType := '';
	STRING1 PhonesPlus_OrigPublishCode := '';
	STRING1 PhonesPlus_OrigPhoneType := '';
	STRING1 PhonesPlus_OrigPhoneUsage := '';
	STRING100 PhonesPlus_Company := '';
	STRING8 PhonesPlus_OrigPhoneRegDate := '';
	STRING20 PhonesPlus_OrigCarrierCode := '';
	STRING20 PhonesPlus_OrigCarrierName := '';
	UNSIGNED1 PhonesPlus_OrigConfScore := 5; // 5 means we don't know much about the phone
	UNSIGNED1 PhonesPlus_OrigRecType := 0;
	UNSIGNED8 PhonesPlus_BDID := 0;
	UNSIGNED2 PhonesPlus_BDID_Score := 0;
	STRING8 PhonesPlus_Append_NPA_Effective_DT := '';
	STRING8 PhonesPlus_Append_NPA_Last_Change_DT := '';
	UNSIGNED1 PhonesPlus_Append_Dialable_Ind := 0;
	STRING50 PhonesPlus_Append_Place_Name := '';
	UNSIGNED1 PhonesPlus_Append_Portability_Indicator := 0;
	STRING100 PhonesPlus_Append_Prior_Area_Code := '';
	STRING64 PhonesPlus_Append_NonPublished_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	STRING20 PhonesPlus_Append_OCN := '';
	STRING1 PhonesPlus_Append_Time_Zone := '';
	STRING3 PhonesPlus_Append_NXX_Type := '';
	STRING5 PhonesPlus_Append_COCType := '';
	STRING1 PhonesPlus_Append_SCC := '';
	STRING30 PhonesPlus_Append_Phone_Type := '';
	UNSIGNED1 PhonesPlus_Append_Company_Type := 0;
	STRING1 PhonesPlus_Append_Phone_Use := '';
	STRING500 PhonesPlus_Agreg_Listing_Type := '';
	UNSIGNED1 PhonesPlus_Max_Orig_Conf_Score := 0;
	UNSIGNED1 PhonesPlus_Min_Orig_Conf_Score := 0;
	UNSIGNED1 PhonesPlus_Curr_Orig_Conf_Score := 0;
	STRING64 PhonesPlus_EDA_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	STRING8 PhonesPlus_EDA_Phone_Dt := '';
	STRING8 PhonesPlus_EDA_DID_Dt := '';
	STRING8 PhonesPlus_EDA_NM_Addr_Dt := '';
	STRING64 PhonesPlus_EDA_Hist_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	STRING8 PhonesPlus_EDA_Hist_Phone_Dt := '';
	STRING8 PhonesPlus_EDA_Hist_DID_Dt := '';
	STRING8 PhonesPlus_EDA_Hist_Nm_Addr_Dt := '';
	UNSIGNED1 PhonesPlus_Append_Feedback_Phone := 8; // 8 means we don't have much info on this phone
	STRING8 PhonesPlus_Append_Feedback_Phone_Dt := '';
	UNSIGNED1 PhonesPlus_Append_Feedback_Phone7_DID := 8; // 8 means we don't have much info on this phone
	STRING8 PhonesPlus_Append_Feedback_Phone7_DID_Dt := '';
	UNSIGNED1 PhonesPlus_Append_Feedback_Phone7_NM_Addr := 8; // 8 means we don't have much info on this phone
	STRING8 PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt := '';
	STRING64 PhonesPlus_Append_Ported_Match := '0000000000000000000000000000000000000000000000000000000000000000';
	BOOLEAN PhonesPlus_Append_Seen_Once_Ind := FALSE;
	UNSIGNED2 PhonesPlus_Append_Indiv_Phone_Cnt := 0;
	BOOLEAN PhonesPlus_Append_Indiv_Has_Active_EDA_Phone_Flag := FALSE;
	BOOLEAN PhonesPlus_Append_Latest_Phone_Owner_Flag := FALSE;
	UNSIGNED8 PhonesPlus_HHID := 0;
	UNSIGNED2 PhonesPlus_HHID_Score := 0;
	BOOLEAN PhonesPlus_Append_Best_Addr_Match_Flag := FALSE;
	BOOLEAN PhonesPlus_Append_Best_NM_Match_Flag := FALSE;
	UNSIGNED8 PhonesPlus_RawAID := 0;
	UNSIGNED8 PhonesPlus_CleanAID := 0;
	BOOLEAN PhonesPlus_Current_Rec := FALSE;
	STRING8 PhonesPlus_First_Build_Date := '';
	STRING8 PhonesPlus_Last_Build_Date := '';
END;

EXPORT Layout_Phone_Feedback := RECORD
	STRING8 Phone_Feedback_Date := '';
	UNSIGNED1 Phone_Feedback_Result := 9; // 9 means we have no information on the phone
	STRING20 Phone_Feedback_First := '';
	STRING20 Phone_Feedback_Middle := '';
	STRING20 Phone_Feedback_Last := '';
	STRING8 Phone_Feedback_Last_RPC_Date := '';
	STRING8 Phone_Feedback_RP_Date := '';
	UNSIGNED1 Phone_Feedback_RP_Result := 9; // 9 means we have no information on the phone
	STRING20 Phone_Feedback_RP_First := '';
	STRING20 Phone_Feedback_RP_Middle := '';
	STRING20 Phone_Feedback_RP_Last := '';
	STRING8 Phone_Feedback_RP_Last_RPC_Date := '';
END;

EXPORT Layout_Inquiries := RECORD
	STRING8 Inq_Num := '';
	STRING8 Inq_Num_06 := '';
	STRING8 Inq_Num_Addresses := '';
	STRING8 Inq_Num_Addresses_06 := '';
	STRING8 Inq_Num_ADLs := '';
	STRING8 Inq_Num_ADLs_06 := '';
	STRING8 Inq_FirstSeen := '';
	STRING8 Inq_LastSeen := '';
	STRING8 Inq_ADL_FirstSeen := '';
	STRING8 Inq_ADL_LastSeen := '';
	STRING200 Inq_ADL_Phone_Industry_List_12 := '';
END;

EXPORT Layout_Internal_Corroboration := RECORD
	BOOLEAN Internal_Verification := FALSE;
	STRING8 Internal_Verification_First_Seen := '';
	STRING8 Internal_Verification_Last_Seen := '';
	STRING15 Internal_Verification_Match_Types := '';
END;

EXPORT Layout_Experian_File_One_Verification := RECORD
	BOOLEAN Experian_Verified := FALSE;
	STRING1 Experian_Type := '';
	STRING1 Experian_Source := '';
	STRING8 Experian_Last_Update := '';
	STRING3 Experian_Phone_Score_V1 := '';
END;

EXPORT Layout_EDA_Characteristics := RECORD
	STRING1 EDA_Omit_Locality := '';
	UNSIGNED8 EDA_DID := 0;
	UNSIGNED8 EDA_HHID := 0;
	UNSIGNED8 EDA_BDID := 0;
	STRING100 EDA_Listing_Name := '';
	UNSIGNED3 EDA_DID_Count := 0;
	STRING8 EDA_Dt_First_Seen := '';
	STRING8 EDA_Dt_Last_Seen := '';
	BOOLEAN EDA_Current_Record_Flag := FALSE;
	STRING8 EDA_Deletion_Date := '';
	UNSIGNED2 EDA_Disc_Cnt6 := 0;
	UNSIGNED2 EDA_Disc_Cnt12 := 0;
	UNSIGNED2 EDA_Disc_Cnt18 := 0;
	STRING2 EDA_Pfrd_Address_Ind := '';
	UNSIGNED4 EDA_Days_In_Service := 0;
	UNSIGNED2 EDA_Num_Phone_Owners_Hist := 0;
	UNSIGNED2 EDA_Num_Phone_Owners_Cur := 0;
	UNSIGNED2 EDA_Num_Phones_Indiv := 0;
	UNSIGNED2 EDA_Num_Phones_Connected_Indiv := 0;
	UNSIGNED2 EDA_Num_Phones_Discon_Indiv := 0;
	UNSIGNED4 EDA_Avg_Days_Connected_Indiv := 0;
	UNSIGNED4 EDA_Min_Days_Connected_Indiv := 0;
	UNSIGNED4 EDA_Max_Days_Connected_Indiv := 0;
	UNSIGNED4 EDA_Days_Indiv_First_Seen := 0;
	UNSIGNED4 EDA_Days_Indiv_First_Seen_With_Phone := 0;
	UNSIGNED4 EDA_Days_Phone_First_Seen := 0;
	BOOLEAN EDA_Address_Match_Best := FALSE;
	UNSIGNED3 EDA_Months_Addr_Last_Seen := 0;
	UNSIGNED4 EDA_Num_Phones_Connected_Addr := 0;
	UNSIGNED4 EDA_Num_Phones_Discon_Addr := 0;
	UNSIGNED4 EDA_Num_Phones_Connected_HHID := 0;
	UNSIGNED4 EDA_Num_Phones_Discon_HHID := 0;
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

EXPORT Layout_Royalties := RECORD
	UNSIGNED1 Metronet_Royalty := 0; // Experian Gateway Called
	UNSIGNED1 TargusComprehensive_Royalty := 0; // Targus Gateway Called
	UNSIGNED1 QSentCIS_Royalty := 0; // Trans Union Gateway Called
	UNSIGNED1 LastResortPhones_Royalty := 0; // Phones Plus Phones Of Last Resort Used
	UNSIGNED1 EFXDataMart_Royalty := 0; //Equifax 
END;

EXPORT Layout_Bureau := RECORD
	BOOLEAN Bureau_Verified := FALSE;
	STRING8 Bureau_Last_Update := '';
END;

EXPORT Layout_Phone_Shell_Plus := RECORD
	UNSIGNED8 Unique_Record_Sequence 			:= 0; // This is internal, used to help keep the individual records straightened out
	UNSIGNED8 DID													:= 0;
	Input																	Raw_Input;		// This field is removed from the final layout below
	Input																	Clean_Input;	// This field is removed from the final layout below
	Layout_Phone_Shell_Input_Echo 				Input_Echo;
	Layout_Subject_Level 									Subject_Level;
	STRING10 Gathered_Phone								:= '';
	STRING3 Phone_Model_Score							:= '';
	Layout_Sources												Sources;
	Layout_Raw_Phone_Characteristics			Raw_Phone_Characteristics;
	Layout_PhonesPlus_Characteristics			PhonesPlus_Characteristics;
	Layout_Phone_Feedback									Phone_Feedback;
	Layout_Inquiries											Inquiries;
	Layout_Internal_Corroboration					Internal_Corroboration;
	Layout_Experian_File_One_Verification	Experian_File_One_Verification;
	Layout_EDA_Characteristics						EDA_Characteristics;
	Layout_Royalties											Royalties;
	Layout_Bureau												Bureau;	
	Layout_Boca_Shell_Plus								Clam;					// This field is removed from the final layout below
END;

EXPORT Phone_Shell_Layout := RECORD
	Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - consumerstatements - bk_chapters Boca_Shell;
END;

END;