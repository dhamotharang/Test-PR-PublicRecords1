/* Version 30
   This function takes in the Phone Shell and converts it into a layout that the Modeling team can use.
   SAS has limits to field names and lengths, so this is why we must convert the layout specially for them.
 */
IMPORT Phone_Shell, Risk_Indicators, RiskWise, UT;

EXPORT Phone_Shell.Layout_Modeling_Shell_v31 To_Modeling_Shell_v31(DATASET(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout) Shell, STRING50 DataRestrictionMask) := FUNCTION
 Phone_Shell.Layout_Modeling_Shell_v31 toShell(Phone_Shell.Layout_Phone_Shell.Phone_Shell_Layout le) := TRANSFORM
  isFCRA := FALSE; // The Phone Shell is Non-FCRA Only
		
  // Phone Shell Fields
  self.psversion := 31; // phone shell version 3.1
  SELF.AcctNo    := le.Phone_Shell.Input_Echo.AcctNo;
  SELF.AccountNumber := le.Phone_Shell.Input_Echo.AcctNo;
  SELF.ps_in_Fname   := le.Phone_Shell.Input_Echo.in_Fname;
  SELF.ps_in_StreetAddress := le.Phone_Shell.Input_Echo.in_StreetAddress;
  SELF.ps_in_City    := le.Phone_Shell.Input_Echo.in_City;
  SELF.ps_in_State   := le.Phone_Shell.Input_Echo.in_State;
  SELF.ps_in_ZipCode := le.Phone_Shell.Input_Echo.in_ZipCode;
  SELF.ps_in_DOB     := le.Phone_Shell.Input_Echo.in_DOB;
  SELF.ps_SSNLength  := (string) length(trim(le.Phone_Shell.Input_Echo.in_SSN));
  SELF.in_ph10 := le.Phone_Shell.Input_Echo.in_Phone10;
  SELF.in_TargusGW_Enabled  := le.Phone_Shell.Input_Echo.in_TargusGW_Enabled;
  SELF.in_TUGW_Enabled      := le.Phone_Shell.Input_Echo.in_TUGW_Enabled;
  SELF.in_InsGW_Enabled     := le.Phone_Shell.Input_Echo.in_InsGW_Enabled;
  SELF.in_Processing_Date   := le.Phone_Shell.Input_Echo.in_Processing_Date;
  SELF.in_Burea_Enabled     := le.Phone_Shell.Input_Echo.in_Burea_Enabled;
  SELF.Subject_SSN_Mismatch := le.Phone_Shell.Subject_Level.Subject_SSN_Mismatch;
  SELF.Gathered_Ph := le.Phone_Shell.Gathered_Phone;

  SELF.Source_List := le.Phone_Shell.Sources.Source_List;
  SELF.Source_List_Last_Seen  := le.Phone_Shell.Sources.Source_List_Last_Seen;
  SELF.Source_List_First_Seen := le.Phone_Shell.Sources.Source_List_First_Seen;
  SELF.Source_Owner_All_DIDs  := le.Phone_Shell.Sources.Source_Owner_All_DIDs;
  SELF.Source_List_All_Last_Seen := le.Phone_Shell.Sources.Source_List_All_Last_Seen;
  SELF.Source_Count_All_DIDs  := le.Phone_Shell.Sources.Source_Count_All_DIDs;
  SELF.Source_Count_DIDs_3yr  := le.Phone_Shell.Sources.Source_Count_DIDs_3yr;
  SELF.Source_Count_DIDs_2yr  := le.Phone_Shell.Sources.Source_Count_DIDs_2yr;
  SELF.Source_Count_DIDs_18mo := le.Phone_Shell.Sources.Source_Count_DIDs_18mo;
  SELF.Source_Count_DIDs_12mo := le.Phone_Shell.Sources.Source_Count_DIDs_12mo;
  SELF.Source_Count_DIDs_9mo  := le.Phone_Shell.Sources.Source_Count_DIDs_9mo;
  SELF.Source_Count_DIDs_6mo  := le.Phone_Shell.Sources.Source_Count_DIDs_6mo;
  SELF.Source_Count_DIDs_3mo  := le.Phone_Shell.Sources.Source_Count_DIDs_3mo;

  SELF.Phone_Subject_Level := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Subject_Level;
  SELF.Phone_Subject_Title := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Subject_Title;
  SELF.Phone_Switch_Type := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Switch_Type;
  SELF.Phone_High_Risk   := le.Phone_Shell.Raw_Phone_Characteristics.Phone_High_Risk;
  SELF.Phone_Debt_Settlement := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Debt_Settlement;
  SELF.Phone_Disconnected    := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Disconnected;
  SELF.Phone_Zip_Match       := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Zip_Match;
  SELF.Phone_Timezone_Match  := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Timezone_Match;
  SELF.Phone_Timezone        := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Timezone;
  SELF.Address_Zipcode_Timezone := le.Phone_Shell.Raw_Phone_Characteristics.Address_Zipcode_Timezone;
  SELF.Phone_Match_Code     := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Match_Code;
  SELF.Phone_Business_Count := le.Phone_Shell.Raw_Phone_Characteristics.Phone_Business_Count;

  SELF.PP_Type    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Type;
  SELF.PP_Carrier := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Carrier;
  SELF.PP_City    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_City;
  SELF.PP_State   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_State;
  SELF.PP_RP_Type    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Type;
  SELF.PP_RP_Carrier := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_Carrier;
  SELF.PP_RP_City    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_City;
  SELF.PP_RP_State   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_RP_State;
  SELF.PP_Confidence := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Confidence;
  SELF.PP_Rules := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Rules;
  SELF.PP_DID_Score_List := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Score_List;
  SELF.PP_DID_Count := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DID_Count;
  SELF.PP_Household_Flags := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Household_Flags;
  SELF.PP_Listing_Name  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Listing_Name;
  SELF.PP_DateFirstSeen := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateFirstSeen;
  SELF.PP_DateLastSeen  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateLastSeen;
  SELF.PP_DateVendorFirstSeen := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorFirstSeen;
  SELF.PP_DateVendorLastSeen  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_DateVendorLastSeen;
  SELF.PP_Phone_LastSeenDiffDID := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Phone_Last_Seen_Diff_DID;
  SELF.PP_Phone_VendLastSeenDiffDID := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Phone_Vendor_Last_Seen_Diff_DID;
  SELF.PP_Date_NonGLB_LastSeen := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Date_NonGLB_LastSeen;
  SELF.PP_GLB_DPPA_fl := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_GLB_DPPA_Flag;
  SELF.PP_Src_List := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_List;
  SELF.PP_Src_Cnt  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Src_Cnt;
  SELF.PP_OrigListingType  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigListingType;
  SELF.PP_ListingType      := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_ListingType;
  SELF.PP_OrigPublishCode  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPublishCode;
  SELF.PP_OrigPhoneType    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneType;
  SELF.PP_OrigPhoneUsage   := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_OrigPhoneUsage;
  SELF.PP_app_Company_Type := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Company_Type;
  SELF.PP_Max_Orig_Conf_Score  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Max_Orig_Conf_Score;
  SELF.PP_Min_Orig_Conf_Score  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Min_Orig_Conf_Score;
  SELF.PP_Curr_Orig_Conf_Score := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Curr_Orig_Conf_Score;
  SELF.PP_EDA_Match  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Match;
  SELF.PP_EDA_ph_Dt  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Phone_Dt;
  SELF.PP_EDA_DID_Dt := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_DID_Dt;
  SELF.PP_EDA_NM_Addr_Dt  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_NM_Addr_Dt;
  SELF.PP_EDA_Hist_Match  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Match;
  SELF.PP_EDA_Hist_ph_Dt  := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Phone_Dt;
  SELF.PP_EDA_Hist_DID_Dt := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_DID_Dt;
  SELF.PP_EDA_Hist_Nm_Addr_Dt := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_EDA_Hist_Nm_Addr_Dt;
  SELF.PP_app_fb_ph    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone;
  SELF.PP_app_fb_ph_Dt := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone_Dt;
  SELF.PP_app_fb_ph7_DID    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID;
  SELF.PP_app_fb_ph7_DID_Dt := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_DID_Dt;
  SELF.PP_app_fb_ph7_NM_Addr    := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr;
  SELF.PP_app_fb_ph7_NM_Addr_Dt := le.Phone_Shell.PhonesPlus_Characteristics.PhonesPlus_Append_Feedback_Phone7_NM_Addr_Dt;

  SELF.Phone_fb_Date   := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Date;
  SELF.Phone_fb_Result := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Result;
  SELF.Phone_fb_First  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_First;
  SELF.Phone_fb_Middle := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Middle;
  SELF.Phone_fb_Last   := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Last;
  SELF.Phone_fb_Last_RPC_Date := le.Phone_Shell.Phone_Feedback.Phone_Feedback_Last_RPC_Date;
  SELF.Phone_fb_RP_Date       := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Date;
  SELF.Phone_fb_RP_Result := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Result;
  SELF.Phone_fb_RP_First  := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_First;
  SELF.Phone_fb_RP_Middle := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Middle;
  SELF.Phone_fb_RP_Last   := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Last;
  SELF.Phone_fb_RP_Last_RPC_Date := le.Phone_Shell.Phone_Feedback.Phone_Feedback_RP_Last_RPC_Date;

  SELF.Inq_Num    := le.Phone_Shell.Inquiries.Inq_Num;
  SELF.Inq_Num_06 := le.Phone_Shell.Inquiries.Inq_Num_06;
  SELF.Inq_Num_Addresses    := le.Phone_Shell.Inquiries.Inq_Num_Addresses;
  SELF.Inq_Num_Addresses_06 := le.Phone_Shell.Inquiries.Inq_Num_Addresses_06;
  SELF.Inq_Num_ADLs    := le.Phone_Shell.Inquiries.Inq_Num_ADLs;
  SELF.Inq_Num_ADLs_06 := le.Phone_Shell.Inquiries.Inq_Num_ADLs_06;
  SELF.Inq_Num_MatchADL    := le.Phone_Shell.Inquiries.Inq_Num_MatchADL;
  SELF.Inq_Num_MatchADL_06 := le.Phone_Shell.Inquiries.Inq_Num_MatchADL_06;
  SELF.Inq_FirstSeen := le.Phone_Shell.Inquiries.Inq_FirstSeen;
  SELF.Inq_LastSeen  := le.Phone_Shell.Inquiries.Inq_LastSeen;
  SELF.Inq_ADL_FirstSeen := le.Phone_Shell.Inquiries.Inq_ADL_FirstSeen;
  SELF.Inq_ADL_LastSeen  := le.Phone_Shell.Inquiries.Inq_ADL_LastSeen;
  SELF.Inq_ADL_ph_Industry_List_12 := le.Phone_Shell.Inquiries.Inq_ADL_Phone_Industry_List_12;

  SELF.Internal_Verification    := le.Phone_Shell.Internal_Corroboration.Internal_Verification;
  SELF.Internal_ver_First_Seen  := le.Phone_Shell.Internal_Corroboration.Internal_Verification_First_Seen;
  SELF.Internal_ver_Last_Seen   := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Last_Seen;
  SELF.Internal_ver_Match_Types := le.Phone_Shell.Internal_Corroboration.Internal_Verification_Match_Types;

  SELF.Bureau_Verified    := le.Phone_Shell.Bureau.Bureau_Verified;
  SELF.Bureau_Last_Update := le.Phone_Shell.Bureau.Bureau_Last_Update;

  SELF.EDA_Omit_Locality := le.Phone_Shell.EDA_Characteristics.EDA_Omit_Locality;
  SELF.EDA_DID  := le.Phone_Shell.EDA_Characteristics.EDA_DID;
  SELF.EDA_HHID := le.Phone_Shell.EDA_Characteristics.EDA_HHID;
  SELF.EDA_BDID := le.Phone_Shell.EDA_Characteristics.EDA_BDID;
  SELF.EDA_Listing_Name  := le.Phone_Shell.EDA_Characteristics.EDA_Listing_Name;
  SELF.EDA_DID_Count     := le.Phone_Shell.EDA_Characteristics.EDA_DID_Count;
  SELF.EDA_Dt_First_Seen := le.Phone_Shell.EDA_Characteristics.EDA_Dt_First_Seen;
  SELF.EDA_Dt_Last_Seen  := le.Phone_Shell.EDA_Characteristics.EDA_Dt_Last_Seen;
  SELF.EDA_Current_Record_fl := le.Phone_Shell.EDA_Characteristics.EDA_Current_Record_Flag;
  SELF.EDA_Deletion_Date := le.Phone_Shell.EDA_Characteristics.EDA_Deletion_Date;
  SELF.EDA_Disc_Cnt6  := le.Phone_Shell.EDA_Characteristics.EDA_Disc_Cnt6;
  SELF.EDA_Disc_Cnt12 := le.Phone_Shell.EDA_Characteristics.EDA_Disc_Cnt12;
  SELF.EDA_Disc_Cnt18 := le.Phone_Shell.EDA_Characteristics.EDA_Disc_Cnt18;
  SELF.EDA_Pfrd_Address_Ind := le.Phone_Shell.EDA_Characteristics.EDA_Pfrd_Address_Ind;
  SELF.EDA_Days_In_Service  := le.Phone_Shell.EDA_Characteristics.EDA_Days_In_Service;
  SELF.EDA_Num_ph_Owners_Hist := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phone_Owners_Hist;
  SELF.EDA_Num_ph_Owners_Cur  := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phone_Owners_Cur;
  SELF.EDA_Num_phs_ind := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Indiv;
  SELF.EDA_Num_phs_Connected_ind  := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_Indiv;
  SELF.EDA_Num_phs_Discon_ind     := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Discon_Indiv;
  SELF.EDA_Avg_Days_Connected_ind := le.Phone_Shell.EDA_Characteristics.EDA_Avg_Days_Connected_Indiv;
  SELF.EDA_Min_Days_Connected_ind := le.Phone_Shell.EDA_Characteristics.EDA_Min_Days_Connected_Indiv;
  SELF.EDA_Max_Days_Connected_ind := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Connected_Indiv;
  SELF.EDA_Days_ind_First_Seen      := le.Phone_Shell.EDA_Characteristics.EDA_Days_Indiv_First_Seen;
  SELF.EDA_Days_ind_First_Seen_w_ph := le.Phone_Shell.EDA_Characteristics.EDA_Days_Indiv_First_Seen_With_Phone;
  SELF.EDA_Days_ph_First_Seen := le.Phone_Shell.EDA_Characteristics.EDA_Days_Phone_First_Seen;
  SELF.EDA_Address_Match_Best := le.Phone_Shell.EDA_Characteristics.EDA_Address_Match_Best;
  SELF.EDA_Months_Addr_Last_Seen  := le.Phone_Shell.EDA_Characteristics.EDA_Months_Addr_Last_Seen;
  SELF.EDA_Num_phs_Connected_Addr := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_Addr;
  SELF.EDA_Num_phs_Discon_Addr    := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Discon_Addr;
  SELF.EDA_Num_phs_Connected_HHID := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Connected_HHID;
  SELF.EDA_Num_phs_Discon_HHID    := le.Phone_Shell.EDA_Characteristics.EDA_Num_Phones_Discon_HHID;
  SELF.EDA_Is_Discon_15_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_15_Days;
  SELF.EDA_Is_Discon_30_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_30_Days;
  SELF.EDA_Is_Discon_60_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_60_Days;
  SELF.EDA_Is_Discon_90_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_90_Days;
  SELF.EDA_Is_Discon_180_Days := le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_180_Days;
  SELF.EDA_Is_Discon_360_Days := le.Phone_Shell.EDA_Characteristics.EDA_Is_Discon_360_Days;
  SELF.EDA_Is_Current_In_Hist := le.Phone_Shell.EDA_Characteristics.EDA_Is_Current_In_Hist;
  SELF.EDA_Num_Interrupts_Cur := le.Phone_Shell.EDA_Characteristics.EDA_Num_Interrupts_Cur;
  SELF.EDA_Avg_Days_Interrupt := le.Phone_Shell.EDA_Characteristics.EDA_Avg_Days_Interrupt;
  SELF.EDA_Min_Days_Interrupt := le.Phone_Shell.EDA_Characteristics.EDA_Min_Days_Interrupt;
  SELF.EDA_Max_Days_Interrupt := le.Phone_Shell.EDA_Characteristics.EDA_Max_Days_Interrupt;
  SELF.EDA_Has_Cur_Discon_15_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_15_Days;
  SELF.EDA_Has_Cur_Discon_30_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_30_Days;
  SELF.EDA_Has_Cur_Discon_60_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_60_Days;
  SELF.EDA_Has_Cur_Discon_90_Days  := le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_90_Days;
  SELF.EDA_Has_Cur_Discon_180_Days := le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_180_Days;
  SELF.EDA_Has_Cur_Discon_360_Days := le.Phone_Shell.EDA_Characteristics.EDA_Has_Cur_Discon_360_Days;

  SELF.Meta_Most_Recent_Deact_Dt  := le.Phone_Shell.Metadata.Meta_Most_Recent_Deact_Dt;
  SELF.Meta_Most_Recent_React_Dt  := le.Phone_Shell.Metadata.Meta_Most_Recent_React_Dt;
  SELF.Meta_Most_Recent_Port_Dt   := le.Phone_Shell.Metadata.Meta_Most_Recent_Port_Dt;
  SELF.Meta_Most_Recent_Swap_Dt   := le.Phone_Shell.Metadata.Meta_Most_Recent_Swap_Dt;
  SELF.Meta_Most_Recent_Active_Dt := le.Phone_Shell.Metadata.Meta_Most_Recent_Active_Dt;
  SELF.Meta_Most_Recent_OTP_Dt    := le.Phone_Shell.Metadata.Meta_Most_Recent_OTP_Dt;
  SELF.Meta_Count_OTP_30  := le.Phone_Shell.Metadata.Meta_Count_OTP_30;
  SELF.Meta_Count_OTP_60  := le.Phone_Shell.Metadata.Meta_Count_OTP_60;
  SELF.Meta_Count_OTP_90  := le.Phone_Shell.Metadata.Meta_Count_OTP_90;
  SELF.Meta_Count_OTP_180 := le.Phone_Shell.Metadata.Meta_Count_OTP_180;
  SELF.Meta_Count_OTP_365 := le.Phone_Shell.Metadata.Meta_Count_OTP_365;
  SELF.Meta_Count_OTP_730 := le.Phone_Shell.Metadata.Meta_Count_OTP_730;
  SELF.Meta_Serv := le.Phone_Shell.Metadata.Meta_Serv;
  SELF.Meta_Line := le.Phone_Shell.Metadata.Meta_Line;
  SELF.Meta_Carrier_Name := le.Phone_Shell.Metadata.Meta_Carrier_Name;
  SELF.Meta_Phone_Status := le.Phone_Shell.Metadata.Meta_Phone_Status;
  SELF.Meta_High_Risk_Indicator := le.Phone_Shell.Metadata.Meta_High_Risk_Indicator;
  SELF.Meta_Prepaid := le.Phone_Shell.Metadata.Meta_Prepaid;
 
  SELF.Phone_Model_Score := le.Phone_Shell.Phone_Model_Score;
 
  // Boca Shell v5.4 Fields (only want the fields we're populating with the IID content)
  self.bsversion := 54; // we're not actually running the boca shell at all, but we're populating 5.4-equivalent fields
 
  self.address_verification.input_address_information.addr_sources := le.boca_shell.address_sources_summary.input_addr_sources;
  self.address_verification.input_address_information.addr_sources_first_seen_date := le.boca_shell.address_sources_summary.input_addr_sources_first_seen_date;
  self.address_verification.input_address_information.addr_sources_recordcount := le.boca_shell.address_sources_summary.input_addr_sources_recordcount;
 
  self.address_verification.Address_History_1.addr_sources := le.boca_shell.address_sources_summary.current_addr_sources;
  self.address_verification.Address_History_1.addr_sources_first_seen_date := le.boca_shell.address_sources_summary.current_addr_sources_first_seen_date;
  self.address_verification.Address_History_1.addr_sources_recordcount := le.boca_shell.address_sources_summary.current_addr_sources_recordcount;
 
  self.address_verification.Address_History_2.addr_sources := le.boca_shell.address_sources_summary.previous_addr_sources;
  self.address_verification.Address_History_2.addr_sources_first_seen_date := le.boca_shell.address_sources_summary.previous_addr_sources_first_seen_date;
  self.address_verification.Address_History_2.addr_sources_recordcount := le.boca_shell.address_sources_summary.previous_addr_sources_recordcount;	
// end of shell 5.0 new content	

  self.iid.socllowissue  := (unsigned)le.boca_shell.iid.socllowissue;
  self.iid.soclhighissue := (unsigned)le.boca_shell.iid.soclhighissue;
 
  // new shell 2.5 fields
  self.isFCRA := if(isFCRA,'1','0');
  ////////////
 
  //// new shell 3.0 fields
  self.cb_allowed := map(dataRestrictionMask[6] <> '1' 
                           and dataRestrictionMask[8] <> '1' 
                           and dataRestrictionMask[10] <> '1' => 'ALL',
                         dataRestrictionMask[8] <> '1'        => 'EQ',
                         dataRestrictionMask[6] <> '1'        => 'EN',
                         dataRestrictionMask[10] <> '1'       => 'TN',
                                                                 'NONE'); // this should not happen

  self.input_dob_age := le.boca_shell.shell_input.age;	
 
  self.Other_Address_Info.address_history_advo_college_hit := le.boca_shell.address_history_summary.address_history_advo_college_hit;	
 
  // blank these out for 5.0 FCRA shell	
  self.iid.areacodesplitdate := if(isFCRA, 0, (unsigned)le.boca_shell.iid.areacodesplitdate);
  self.iid.areacodesplitflag := if(isFCRA, '', le.boca_shell.iid.areacodesplitflag);		
  self.iid.drlcvalflag       := if(isFCRA, '', le.boca_shell.iid.drlcvalflag);
  self.iid.name_addr_phone   := if(isFCRA, '', le.boca_shell.iid.name_addr_phone);
  self.iid.DIDCount := if(isFCRA, 0, le.boca_shell.iid.didcount);
  self.iid.DID2     := if(isFCRA, 0, le.boca_shell.iid.did2);	
  self.iid.DID3     := if(isFCRA, 0, le.boca_shell.iid.did3);
  
  self.iid.altlastPop  := if(isFCRA, false, le.boca_shell.iid.altlastPop);
  self.iid.altlast2Pop := if(isFCRA, false, le.boca_shell.iid.altlast2Pop);
 
  // new for 5.2	
  self.DIDdeceased     := le.boca_shell.iid.diddeceased;
  self.DIDdeceasedDate := le.boca_shell.iid.DIDdeceasedDate;

  //New for 5.3
  self.corr_risk_summary.corrssnname_sources   := le.boca_shell.header_summary.corrssnname_sources;
  self.corr_risk_summary.corrssnname_firstseen := le.boca_shell.header_summary.corrssnname_firstseen;
  self.corr_risk_summary.corrssnname_lastseen  := le.boca_shell.header_summary.corrssnname_lastseen;
  // self.corr_risk_summary.corrssnname_source_cnt := le.boca_shell.header_summary.corrssnname_source_cnt;
  self.corr_risk_summary.corrssnaddr_sources   := le.boca_shell.header_summary.corrssnaddr_sources;
  self.corr_risk_summary.corrssnaddr_firstseen := le.boca_shell.header_summary.corrssnaddr_firstseen;
  self.corr_risk_summary.corrssnaddr_lastseen  := le.boca_shell.header_summary.corrssnaddr_lastseen;
  // self.corr_risk_summary.corrssnaddr_source_cnt := le.boca_shell.header_summary.corrssnaddr_source_cnt;
  self.corr_risk_summary.corraddrname_sources   := le.boca_shell.header_summary.corraddrname_sources;
  self.corr_risk_summary.corraddrname_firstseen := le.boca_shell.header_summary.corraddrname_firstseen;
  self.corr_risk_summary.corraddrname_lastseen  := le.boca_shell.header_summary.corraddrname_lastseen;
  // self.corr_risk_summary.corraddrname_source_cnt := le.boca_shell.header_summary.corraddrname_source_cnt;

  self.swappedNames := le.boca_shell.iid.swappedNames;

  SELF := le.Boca_Shell; // All remaining fields should be normal Boca Shell names
  SELF := [];
 END; 

 result := PROJECT(Shell, toShell(LEFT));
 
 RETURN result;
END;