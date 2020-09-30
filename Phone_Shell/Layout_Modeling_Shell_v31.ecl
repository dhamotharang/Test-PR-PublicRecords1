/*
 This modeling shell is for use by the Modeling team in Minneapolis.
 SAS requires that all field names be less than 32 characters
 long, and not have any '.' (DOT) notation in the name.  Because of 
 this we must project the normal Phone Shell into this	modeling layout 
 which SAS can read in.  The corresponding Phone_Shell.To_Modeling_Shell_vX 
 is used to convert the Phone Shell to this layout.

 v11 - experian removal
 v2  - Phone_Shell_v2, uses Boca/Consumer shell 5.4 (previous versions use 4.1)
 v21 - Phone Shell v2.1, adds 10 new DID lists/counts to Sources section and 2 new MatchADL counts to Inquiries section
 v30 - Phone Shell v3.0, adds new Metadata section, reduces Boca/Consumer Shell down to just the IID items (rest of Boca Shell removed in 3.0)
 v31 - Phone Shell v3.1, adds some new PhonesPlus items and removes quite a few others that we are no longer populating
*/
IMPORT Phone_Shell, Risk_Indicators, Phones;

Layout_ph_Shell_Input_Echo_Modeling := RECORD
 STRING50  AcctNo      := '';
 STRING20  ps_in_Fname := '';
 STRING120 ps_in_StreetAddress := '';
 STRING25  ps_in_City    := '';
 STRING2   ps_in_State   := '';
 STRING9   ps_in_ZipCode := '';
 STRING8   ps_in_DOB     := '';
 STRING9   ps_SSNLength  := '';
 STRING10  in_ph10 := '';
 BOOLEAN   in_TargusGW_Enabled := FALSE;
 BOOLEAN   in_TUGW_Enabled     := FALSE;
 BOOLEAN   in_INSGW_Enabled    := FALSE;
 STRING8   in_Processing_Date  := '';
 BOOLEAN   in_Burea_Enabled    := FALSE;
END;

Layout_Subject_Level_Modeling := RECORD
 INTEGER1 Subject_SSN_Mismatch := -1;
END;

Layout_Sources_Modeling := RECORD
 STRING200 Source_List := '';
 STRING200 Source_List_Last_Seen  := '';
 STRING200 Source_List_First_Seen := '';
 STRING400 Source_Owner_All_DIDs  := '';  // starting here, new in 2.1
 STRING400 Source_List_All_Last_Seen := '';
 UNSIGNED2 Source_Count_All_DIDs  := 0;
 UNSIGNED2 Source_Count_DIDs_3yr  := 0;
 UNSIGNED2 Source_Count_DIDs_2yr  := 0;
 UNSIGNED2 Source_Count_DIDs_18mo := 0;
 UNSIGNED2 Source_Count_DIDs_12mo := 0;
 UNSIGNED2 Source_Count_DIDs_9mo  := 0;
 UNSIGNED2 Source_Count_DIDs_6mo  := 0;
 UNSIGNED2 Source_Count_DIDs_3mo  := 0; // ending here, new in 2.1
END;

Layout_Raw_ph_Characteristics_Modeling := RECORD
 UNSIGNED1 Phone_Subject_Level := 0;
 STRING1   Phone_Switch_Type   := ''; // 8 - Toll Free, C - Cell Phone, G - Pager, I - Puerto Rico/Virgin Islands, P - POTS, T - Time, U - Unknown, V - VOIP, W - Weather
 UNSIGNED1 Phone_High_Risk     := 0;
 BOOLEAN   Phone_Debt_Settlement := FALSE;
 BOOLEAN   Phone_Disconnected := FALSE;
 UNSIGNED1 Phone_Zip_Match    := 0;
 UNSIGNED1 Phone_Timezone_Match := 0;
 STRING4   Phone_Timezone       := '';
 STRING4   Address_Zipcode_Timezone := '';
 STRING30  Phone_Match_Code     := '';
 UNSIGNED2 Phone_Business_Count := 0;
 STRING35  Phone_Subject_Title  := '';
END;

Layout_phsPlus_Characteristics_Modeling := RECORD
 STRING1    PP_Type       := ''; // B - Business, R - Residential, M - Mobile, U - Unknown
 STRING20   PP_Carrier    := '';
 STRING25   PP_City       := '';
 STRING2    PP_State      := '';
 STRING1    PP_RP_Type    := '';
 STRING20   PP_RP_Carrier := '';
 STRING25   PP_RP_City    := '';
 STRING2    PP_RP_State   := '';
 UNSIGNED1  PP_Confidence := 0; // 0 = Below The Line, 11 = Above The Line
 STRING64   PP_Rules      := '0000000000000000000000000000000000000000000000000000000000000000'; // Bit string similar to Data Restriction Mask
 QSTRING100 PP_DID_Score_List := '';
 UNSIGNED1  PP_DID_Count := 0;
 QSTRING100 PP_Household_Flags := '';
 STRING50   PP_Listing_Name  := '';
 QSTRING200 PP_DateFirstSeen := '';
 QSTRING200 PP_DateLastSeen  := '';
 QSTRING200 PP_DateVendorFirstSeen  := '';
 QSTRING200 PP_DateVendorLastSeen   := '';
 STRING8    PP_Phone_LastSeenDiffDID := '';
 STRING8    PP_Phone_VendLastSeenDiffDID := '';
 QSTRING200 PP_Date_NonGLB_LastSeen := '';
 QSTRING100 PP_GLB_DPPA_fl  := '';
 QSTRING150 PP_Src_List := '';
 UNSIGNED1  PP_Src_Cnt  := 0;
 STRING25   PP_OrigListingType  := '';
 STRING25   PP_ListingType      := '';
 STRING1    PP_OrigPublishCode  := '';
 STRING1    PP_OrigPhoneType    := '';
 STRING1    PP_OrigPhoneUsage   := '';
 UNSIGNED1  PP_app_Company_Type := 0;
 UNSIGNED1  PP_Max_Orig_Conf_Score  := 0;
 UNSIGNED1  PP_Min_Orig_Conf_Score  := 0;
 UNSIGNED1  PP_Curr_Orig_Conf_Score := 0;
 STRING64   PP_EDA_Match      := '0000000000000000000000000000000000000000000000000000000000000000';
 STRING8    PP_EDA_ph_Dt      := '';
 STRING8    PP_EDA_DID_Dt     := '';
 STRING8    PP_EDA_NM_Addr_Dt := '';
 STRING64   PP_EDA_Hist_Match := '0000000000000000000000000000000000000000000000000000000000000000';
 STRING8    PP_EDA_Hist_ph_Dt      := '';
 STRING8    PP_EDA_Hist_DID_Dt     := '';
 STRING8    PP_EDA_Hist_Nm_Addr_Dt := '';
 UNSIGNED1  PP_app_fb_ph             := 8; // 8 means we don't have much info on this phone
 STRING8    PP_app_fb_ph_Dt          := '';
 UNSIGNED1  PP_app_fb_ph7_DID        := 8; // 8 means we don't have much info on this phone
 STRING8    PP_app_fb_ph7_DID_Dt     := '';
 UNSIGNED1  PP_app_fb_ph7_NM_Addr    := 8; // 8 means we don't have much info on this phone
 STRING8    PP_app_fb_ph7_NM_Addr_Dt := '';
END;

Layout_ph_fb_Modeling := RECORD
 STRING8   Phone_fb_Date   := '';
 UNSIGNED1 Phone_fb_Result := 0;
 STRING20  Phone_fb_First  := '';
 STRING20  Phone_fb_Middle := '';
 STRING20  Phone_fb_Last   := '';
 STRING8   Phone_fb_Last_RPC_Date    := '';
 STRING8   Phone_fb_RP_Date   := '';
 UNSIGNED1 Phone_fb_RP_Result := 0;
 STRING20  Phone_fb_RP_First  := '';
 STRING20  Phone_fb_RP_Middle := '';
 STRING20  Phone_fb_RP_Last   := '';
 STRING8   Phone_fb_RP_Last_RPC_Date := '';
END;

Layout_Inquiries_Modeling := RECORD
 STRING8 Inq_Num    := 0;
 STRING8 Inq_Num_06 := 0;
 STRING8 Inq_Num_Addresses    := 0;
 STRING8 Inq_Num_Addresses_06 := 0;
 STRING8 Inq_Num_ADLs    := 0;
 STRING8 Inq_Num_ADLs_06 := 0;
 STRING8 Inq_Num_MatchADL    := '';  // new in 2.1
 STRING8 Inq_Num_MatchADL_06 := '';  // new in 2.1
 STRING8 Inq_FirstSeen := 0;
 STRING8 Inq_LastSeen  := 0;
 STRING8 Inq_ADL_FirstSeen := 0;
 STRING8 Inq_ADL_LastSeen  := 0;
 STRING200 Inq_ADL_ph_Industry_List_12 := 0;
END;

Layout_Internal_Corroboration_Modeling := RECORD
 BOOLEAN  Internal_Verification    := FALSE;
 STRING8  Internal_ver_First_Seen  := '';
 STRING8  Internal_ver_Last_Seen   := '';
 STRING15 Internal_ver_Match_Types := '';
END;

Layout_EDA_Characteristics_Modeling := RECORD
 STRING1   EDA_Omit_Locality := '';
 UNSIGNED8 EDA_DID  := 0;
 UNSIGNED8 EDA_HHID := 0;
 UNSIGNED8 EDA_BDID := 0;
 STRING100 EDA_Listing_Name  := '';
 UNSIGNED3 EDA_DID_Count     := 0;
 STRING8   EDA_Dt_First_Seen := '';
 STRING8   EDA_Dt_Last_Seen  := '';
 BOOLEAN   EDA_Current_Record_fl := FALSE;
 STRING8   EDA_Deletion_Date := '';
 UNSIGNED2 EDA_Disc_Cnt6  := 0;
 UNSIGNED2 EDA_Disc_Cnt12 := 0;
 UNSIGNED2 EDA_Disc_Cnt18 := 0;
 STRING2   EDA_Pfrd_Address_Ind := '';
 UNSIGNED4 EDA_Days_In_Service  := 0;
 UNSIGNED2 EDA_Num_ph_Owners_Hist := 0;
 UNSIGNED2 EDA_Num_ph_Owners_Cur  := 0;
 UNSIGNED2 EDA_Num_phs_ind := 0;
 UNSIGNED2 EDA_Num_phs_Connected_ind  := 0;
 UNSIGNED2 EDA_Num_phs_Discon_ind     := 0;
 UNSIGNED4 EDA_Avg_Days_Connected_ind := 0;
 UNSIGNED4 EDA_Min_Days_Connected_ind := 0;
 UNSIGNED4 EDA_Max_Days_Connected_ind := 0;
 UNSIGNED4 EDA_Days_ind_First_Seen := 0;
 UNSIGNED4 EDA_Days_ind_First_Seen_w_ph := 0;
 UNSIGNED4 EDA_Days_ph_First_Seen := 0;
 BOOLEAN   EDA_Address_Match_Best := FALSE;
 UNSIGNED3 EDA_Months_Addr_Last_Seen  := 0;
 UNSIGNED4 EDA_Num_phs_Connected_Addr := 0;
 UNSIGNED4 EDA_Num_phs_Discon_Addr    := 0;
 UNSIGNED4 EDA_Num_phs_Connected_HHID := 0;
 UNSIGNED4 EDA_Num_phs_Discon_HHID := 0;
 BOOLEAN   EDA_Is_Discon_15_Days  := FALSE;
 BOOLEAN   EDA_Is_Discon_30_Days  := FALSE;
 BOOLEAN   EDA_Is_Discon_60_Days  := FALSE;
 BOOLEAN   EDA_Is_Discon_90_Days  := FALSE;
 BOOLEAN   EDA_Is_Discon_180_Days := FALSE;
 BOOLEAN   EDA_Is_Discon_360_Days := FALSE;
 BOOLEAN   EDA_Is_Current_In_Hist := FALSE;
 UNSIGNED2 EDA_Num_Interrupts_Cur := 0;
 UNSIGNED4 EDA_Avg_Days_Interrupt := 0;
 UNSIGNED4 EDA_Min_Days_Interrupt := 0;
 UNSIGNED4 EDA_Max_Days_Interrupt := 0;
 BOOLEAN   EDA_Has_Cur_Discon_15_Days  := FALSE;
 BOOLEAN   EDA_Has_Cur_Discon_30_Days  := FALSE;
 BOOLEAN   EDA_Has_Cur_Discon_60_Days  := FALSE;
 BOOLEAN   EDA_Has_Cur_Discon_90_Days  := FALSE;
 BOOLEAN   EDA_Has_Cur_Discon_180_Days := FALSE;
 BOOLEAN   EDA_Has_Cur_Discon_360_Days := FALSE;
END;

Layout_Bureau_Modeling := RECORD
 BOOLEAN Bureau_Verified := FALSE;
 STRING8 Bureau_Last_Update := '';
END;

Layout_Metadata_Modeling := RECORD
 STRING8  Meta_Most_Recent_Deact_Dt  := '';
 STRING8  Meta_Most_Recent_React_Dt  := '';
 STRING8  Meta_Most_Recent_Port_Dt   := '';
 STRING8  Meta_Most_Recent_Swap_Dt   := '';
 STRING8  Meta_Most_Recent_Active_Dt := '';
 STRING8  Meta_Most_Recent_OTP_Dt := '';
 UNSIGNED Meta_Count_OTP_30    := 0;
 UNSIGNED Meta_Count_OTP_60    := 0;
 UNSIGNED Meta_Count_OTP_90    := 0;
 UNSIGNED Meta_Count_OTP_180   := 0;
 UNSIGNED Meta_Count_OTP_365   := 0;
 UNSIGNED Meta_Count_OTP_730   := 0;
 STRING1  Meta_Serv := '';
 STRING1  Meta_Line := '';
 STRING60 Meta_Carrier_Name := '';
 STRING32 Meta_Phone_Status := '';
 STRING2  Meta_High_Risk_Indicator := '';
 STRING2  Meta_Prepaid := '';
END;

// For Phone Shell 3.0, need to cherry-pick bits out of the current edina54 modeling layout
// and unfortunately for most of it I can't just pull the sub-layouts of the sections we need
// So create new layouts to grab just what we need - inspired by edina54 modeling layout rather than using it
Layout_SubEdina54_CorrRisk := RECORD
  string50   corrssnname_sources;
  qstring200 corrssnname_firstseen;
  qstring200 corrssnname_lastseen;
  string50   corrssnaddr_sources;
  qstring200 corrssnaddr_firstseen;
  qstring200 corrssnaddr_lastseen;
  string50   corraddrname_sources;
  qstring200 corraddrname_firstseen;
  qstring200 corraddrname_lastseen;
END;

Layout_SubEdina54_InAddrVer := RECORD
  string100 addr_sources := '';
  string200 addr_sources_first_seen_date := '';
  string100 addr_sources_recordcount := '';
END;

Layout_SubEdina54_AddrVer := RECORD
  Layout_SubEdina54_InAddrVer input_address_information;
  Layout_SubEdina54_InAddrVer address_history_1;
  Layout_SubEdina54_InAddrVer address_history_2;
END;

Layout_SubEdina54_OthrAddr := RECORD // agreed a 1-field layout is weird. This is to preserve original edina structure.
  boolean address_history_advo_college_hit := false;
END;

Layout_SubEdina54_Modeling := RECORD 
 integer   bsversion; // 54 in PhoneShell v2.1+ (boca shell is not run in v3.0+ but some IID fields are put into that layout)
 string1   isFCRA; // phone shell is always false/0
 string3   cb_allowed; // EQ/EN/ALL
 string30  AccountNumber;
 unsigned4 seq; // doesn't seem very useful/always 1? maybe remove
 unsigned6 did;
 BOOLEAN   trueDID;
 string15  adlCategory;
 BOOLEAN   DIDdeceased := false;
 UNSIGNED4 DIDdeceasedDate := 0;
 integer   swappedNames;
 Risk_Indicators.Layout_Boca_Shell_Edina_v54.shell_input    shell_input; // input
 Risk_Indicators.Layout_Boca_Shell_Edina_v54.iid            iid; // potentially all/most are good here
 Risk_Indicators.Layout_Boca_Shell_Edina_v54.header_summary header_summary; // mostly good
 Layout_SubEdina54_CorrRisk corr_risk_summary;
 Layout_SubEdina54_AddrVer  address_verification;
 Layout_SubEdina54_OthrAddr other_address_info;
 Risk_Indicators.Layout_Boca_Shell_Edina_v54.hhid_Summary   hhid_summary; // most of these are good I think
 string8   input_dob_age;
 string1   dobmatchlevel; // these two might be good if dob is input?
 integer2  inferred_age;  // this seems to be calc'd from reported dob if input dob is not present
 unsigned4 reported_dob;
 STRING200 errorcode; // just in case
END;

EXPORT Layout_Modeling_Shell_v31 := RECORD
 integer psversion; // eg 30 for phone shell 3.0
 Layout_ph_Shell_Input_Echo_Modeling; 
 Layout_Subject_Level_Modeling; 
 STRING10 Gathered_Ph := '';
 Layout_Sources_Modeling;
 Layout_Raw_ph_Characteristics_Modeling;
 Layout_phsPlus_Characteristics_Modeling;
 Layout_ph_fb_Modeling;
 Layout_Inquiries_Modeling;
 Layout_Internal_Corroboration_Modeling;
 Layout_Bureau_Modeling; 
 Layout_EDA_Characteristics_Modeling;
 Layout_Metadata_Modeling;   // Metadata added in v3.0
 Layout_SubEdina54_Modeling; // Added in v3.0 to trim down since boca shell no longer runs, just passes on IID attributes
 STRING3 Phone_Model_Score := '';
END;