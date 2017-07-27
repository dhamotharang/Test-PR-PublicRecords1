export Layout_Profile_Risk_model := record
unsigned3 zip := 0;
qstring28 prim_name := '';
qstring10 prim_range := '';
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
unsigned4 dt_first_seen_min := 0;   // min for all base records
unsigned4 dt_last_seen_max := 0;    // max for all base records
unsigned4 dt_vendor_first_reported_min := 0; // min for all base records
unsigned4 dt_first_seen_Y := 0; // min for a current YP record
unsigned4 dt_last_seen_Y := 0; // max for a current YP record
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
unsigned4 dt_first_seen_BM := 0;// min for a BBB member record
unsigned4 dt_last_seen_BM := 0;// max for a BBB member record
unsigned4 dt_first_seen_BN := 0;// min for a BBB non-member record
unsigned4 dt_last_seen_BN := 0;// max for a BBB non-member record
unsigned4 dt_first_seen_IA := 0;// min for a InfoUSA record
unsigned4 dt_last_seen_IA := 0;// max for a InfoUSA record
unsigned4 dt_first_seen_DC := 0;// min for a DCA record
unsigned4 dt_last_seen_DC := 0;// max for a DCA record
unsigned4 dt_first_seen_EB := 0;// min for a Experian Business Header record
unsigned4 dt_last_seen_EB := 0;// max for a Experian Business Header record
// Gong indicators
string1 gong_current_record_flag := 'N';  
unsigned4 gong_deletion_date := 0;
unsigned2 gong_disc_cnt6 := 0;
unsigned2 gong_disc_cnt12 := 0;
unsigned2 gong_disc_cnt18 := 0;
// source record counts
unsigned3 cnt_base := 0; // base record count
unsigned2 cnt_AE := 0; // Experian Vehicles
unsigned2 cnt_AF := 0; // ATF Firearms and Explosives
unsigned2 cnt_AT := 0; // Accurint Trade Show
unsigned2 cnt_AW := 0; // Watercraft
unsigned2 cnt_B  := 0; // Bankruptcy
unsigned2 cnt_BM := 0; // BBBB Members
unsigned2 cnt_BN := 0; // BBB Non-Members
unsigned2 cnt_BR := 0; // Business Registration
unsigned2 cnt_C  := 0; // Corporate
unsigned2 cnt_CU := 0; // Credit Unions
unsigned2 cnt_D  := 0; // Dun & Bradstreet
unsigned2 cnt_DC := 0; // DCA - Directory of Corporate Affiliations
unsigned2 cnt_DE := 0; // DEA
unsigned2 cnt_E  := 0; // Edgar
unsigned2 cnt_EB := 0; // Experian Business Header
unsigned2 cnt_ED := 0; // Employee Directories
unsigned2 cnt_F  := 0; // Fictitious Business Names
unsigned2 cnt_FA := 0; // FAA Aircraft Registrations
unsigned2 cnt_FC := 0; // FCC Radio Licenses
unsigned2 cnt_FD := 0; // FDIC
unsigned2 cnt_FF := 0; // Florida FBN
unsigned2 cnt_FN := 0; // Florida Non-Profit
unsigned2 cnt_GB := 0; // Gong Business
unsigned2 cnt_GG := 0; // Gong Government
unsigned2 cnt_I  := 0; // IRS 5500
unsigned2 cnt_IA := 0; // INFOUSA ABIUS(USABIZ)
unsigned2 cnt_ID := 0; // INFOUSA DEAD COMPANIES
unsigned2 cnt_IF := 0; // INFOUSA FBNS
unsigned2 cnt_II := 0; // INFOUSA IDEXEC
unsigned2 cnt_IN := 0; // IRS Non-Profit
unsigned2 cnt_LJ := 0; // Liens and Judgments
unsigned2 cnt_LB := 0; // Lobbyists
unsigned2 cnt_LP := 0; // LN Property
unsigned2 cnt_MD := 0; // Medical Information Directory
unsigned2 cnt_MV := 0; // Motor Vehicles
unsigned2 cnt_PL := 0; // Professional Licenses
unsigned2 cnt_PR := 0; // Property File
unsigned2 cnt_SB := 0; // SEC Broker/Dealer
unsigned2 cnt_SK := 0; // SK&A Medical Professionals
unsigned2 cnt_ST := 0; // State Sales Tax
unsigned3 cnt_U  := 0; // UCC
unsigned2 cnt_V  := 0; // Vickers
unsigned2 cnt_W  := 0; // Domain Registrations (WHOIS)
unsigned2 cnt_WC := 0; // State Workers Comp
unsigned2 cnt_WT := 0; // Wither and Die
unsigned2 cnt_Y  := 0; // Yellow Pages
unsigned1 PRScore := 0;
unsigned4 PRScore_date := 0;
unsigned1 busreg_flag := 0;
unsigned1 corp_flag := 0;
unsigned1 dnb_flag := 0;
unsigned1 irs5500_flag := 0;
unsigned1 st_flag := 0;
unsigned1 ucc_flag := 0;
unsigned1 yp_flag := 0;
unsigned1 tier1srcs := 0;
unsigned1 t1scr5 := 0;
unsigned1 currphn := 0;
unsigned1 currcorp := 0;
unsigned1 currbr := 0;
unsigned1 currdnb := 0;
unsigned1 currucc := 0;
unsigned1 curry := 0;
unsigned1 currt1cnt := 0;
unsigned1 currt1src4 := 0;
unsigned2 year_lj := 0;
unsigned1 lj := 0;
unsigned1 ustic := 0;
unsigned1 t1x := 0;
unsigned2 OFAC_cnt := 0;
end;