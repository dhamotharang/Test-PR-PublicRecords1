import Business_Header_SS;

s := Business_Risk.Layout_SIC_Code;

export Layout_Profile_Output := record
Layout_Profile_Input;
// Best Information
Business_Header_SS.Layout_Best_Append;
//  BDID stats
//  Business Quality Indicator Score and Counts
UNSIGNED4 bdid_per_addr := 0;
UNSIGNED4 apts := 0;
UNSIGNED4 ppl := 0;
UNSIGNED4 r_phone_per_addr := 0;
UNSIGNED4 b_phone_per_addr := 0;
UNSIGNED4 dnb_emps := 0;
UNSIGNED4 irs5500_emps := 0;
UNSIGNED4 domainss := 0;
UNSIGNED1 sources := 0;
UNSIGNED1 company_name_score := 0;
UNSIGNED1 combined_score := 0;
UNSIGNED4 gong_yp_cnt := 0;
UNSIGNED4 current_corp_cnt := 0;
// SIC Codes
dataset(s) siccodes;
//  BDID source record dates and counts
unsigned4 dt_first_seen_min := 0;   // min for all base records
unsigned4 dt_last_seen_max := 0;    // max for all base records
unsigned4 dt_vendor_first_reported_min := 0; // min for all base records
unsigned4 dt_first_seen_Y := 0;// min for a current YP record
unsigned4 dt_last_seen_Y := 0;// max for a current YP record
unsigned4 dt_first_seen_G := 0;// min for a current Gong record
unsigned4 dt_last_seen_G := 0;// max for a current Gong record
unsigned4 dt_first_seen_C := 0;// min for a Corporate record
unsigned4 dt_last_seen_C := 0;// max for a Corporate record
unsigned4 dt_first_seen_BR := 0;// min for a Business Registration record
unsigned4 dt_last_seen_BR := 0;// max for a Business Registration record
unsigned4 dt_first_seen_UCC := 0;// min for a UCC record
unsigned4 dt_last_seen_UCC := 0;// max for a UCC record
unsigned4 dt_first_seen_D := 0;// min for a D&B record
unsigned4 dt_last_seen_D := 0;// max for a D&B record
unsigned4 dt_first_seen_I := 0;// min for a IRS5500 record
unsigned4 dt_last_seen_I := 0;// max for a IRS5500 record
unsigned4 dt_first_seen_ST := 0;// min for a Sales Tax record
unsigned4 dt_last_seen_ST := 0;// max for a Sales Tax record
unsigned4 dt_last_seen_B := 0;// max for a Bankruptcy record
unsigned4 dt_last_seen_LJ := 0;// max for a Liens Judgment record
// Gong indicators
string1 gong_current_record_flag := 'N';  
unsigned4 gong_deletion_date := 0;
unsigned2 gong_disc_cnt6 := 0;
unsigned2 gong_disc_cnt12 := 0;
unsigned2 gong_disc_cnt18 := 0;
unsigned3 cnt_base := 0; // base record count
unsigned2 cnt_AT := 0; // Accurint Trade Show
unsigned2 cnt_B  := 0; // Bankruptcy
unsigned2 cnt_BR := 0; // Business Registration
unsigned2 cnt_C  := 0; // Corporate
unsigned2 cnt_CU := 0; // Credit Unions
unsigned2 cnt_D  := 0; // Dun & Bradstreet
unsigned2 cnt_DE := 0; // DEA
unsigned2 cnt_E  := 0; // Edgar
unsigned2 cnt_ED := 0; // Employee Directories
unsigned2 cnt_F  := 0; // Fictitious Business Names
unsigned2 cnt_FA := 0; // FAA Aircraft Registrations
unsigned2 cnt_FD := 0; // FDIC
unsigned2 cnt_FF := 0; // Florida FBN
unsigned2 cnt_FN := 0; // Florida Non-Profit
unsigned2 cnt_GB := 0; // Gong Business
unsigned2 cnt_GG := 0; // Gong Government
unsigned2 cnt_I  := 0; // IRS 5500
unsigned2 cnt_IN := 0; // IRS Non-Profit
unsigned2 cnt_LJ := 0; // Liens and Judgments
unsigned2 cnt_ME := 0; // IRS MEWA
unsigned2 cnt_MV := 0; // Motor Vehicles
unsigned2 cnt_PL := 0; // Professional Licenses
unsigned2 cnt_PR := 0; // Property File
unsigned2 cnt_SB := 0; // SEC Broker/Dealer
unsigned2 cnt_SK := 0; // SK&A Medical Professionals
unsigned2 cnt_ST := 0; // State Sales Tax
unsigned2 cnt_U  := 0; // UCC
unsigned2 cnt_V  := 0; // Vickers
unsigned2 cnt_W  := 0; // Domain Registrations (WHOIS)
unsigned2 cnt_WC := 0; // State Workers Comp
unsigned2 cnt_WT := 0; // Wither and Die
unsigned2 cnt_Y  := 0; // Yellow Pages
// Property Data and Stats
//   Property 1
string60 Name_Owner_1 := '';
string60 Name_Owner_2 := '';
string40 land_usage := '';
string11 Total_Value := '';
string4 Year_Built := '';
//  Property 2+ Stats
unsigned2 additional_property_cnt := 0;
unsigned4 additional_property_value := 0;
// Vehicle Data
unsigned2 vehicle_cnt := 0;
// High Risk Data
unsigned2 OFAC_cnt := 0;
unsigned2 hri_address_cnt := 0;
// Principal Data
unsigned2 principal_cnt := 0;
unsigned2 principal_criminal_cnt := 0;
unsigned2 principal_sex_ffender_cnt := 0;
unsigned2 principal_bk_cnt := 0;
unsigned2 principal_OFAC_cnt := 0;
unsigned2 principal_hri_ssn_cnt := 0;
unsigned2 principal_lj_cnt := 0;
unsigned2 principal_property_cnt := 0;
unsigned4 principal_property_value := 0;
end;