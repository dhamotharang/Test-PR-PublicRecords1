IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, Riskview;

EXPORT RVC1609_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam ) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 // string in_ssnpop
    
   integer adl_addr;
   Integer	 sysdate;
	 Integer   seq;
   Real	 r_a44_curr_add_naprop_d;
   Integer	 r_l80_inp_avm_autoval_d;
   Integer	 r_a46_curr_avm_autoval_d;
   Integer	 r_a41_prop_owner_d;
   Integer	 k_estimated_income_d;
   Real	 r_a49_curr_avm_chg_1yr_pct_i;
   Real	 r_i60_inq_hiriskcred_recency_d;
   Real		   _in_dob;
   Real	 	   yr_in_dob;
   Real	 		 yr_in_dob_int;
   Real	 		 k_comb_age_d;
   Integer	 r_c14_addrs_10yr_i;
   Integer	 r_c12_num_nonderogs_d;
   Integer	 r_prop_owner_history_d;
   Integer	 r_e55_college_ind_d;
   Integer	 r_d30_derog_count_i;
   REAL	     k_nap_fname_verd_d;
   Real      _header_first_seen;
   Real	     r_c10_m_hdr_fs_d;
   Real	     _criminal_last_date;
   Real	     r_d32_mos_since_crim_ls_d;
   Real	     r_i60_inq_hiriskcred_count12_i;
   REAL	     r_c12_source_profile_d;
   Real	     r_i60_inq_recency_d;
   Real      r_c14_addrs_15yr_i;
   Integer	 r_a41_prop_owner_inp_only_d;
   Real	     r_c13_max_lres_d;
   Real   	 r_i60_inq_count12_i;
   Integer	 custom_adl_addr;
   Integer	 r_e57_br_source_count_d;
   Integer	 r_f03_address_match_d;
   Integer   r_l79_adls_per_addr_curr_i;
   Integer	 r_wealth_index_d;
   Real	     r_s66_adlperssn_count_i;
   Real	 r_f03_input_add_not_most_rec_i;
   Integer	 r_ever_asset_owner_d;
   Real	     r_c13_curr_addr_lres_d;
   Real	     r_d32_criminal_count_i;
   Integer	 r_a49_curr_avm_chg_1yr_i;
   Real	     r_d33_eviction_recency_d;
   Integer	 r_p88_phn_dst_to_inp_add_i;
   Real	     r_c14_addrs_5yr_i;
   Integer   r_p85_phn_disconnected_i;
   Real	     r_i60_inq_comm_count12_i;
   Integer	 r_l77_apartment_i;
   Integer	 r_d31_attr_bankruptcy_recency_d;
   Integer	 bureau_adl_eq_fseen_pos;
   String	    bureau_adl_fseen_eq;
   Integer	 _bureau_adl_fseen_eq;
   Integer	 _src_bureau_adl_fseen;
   Integer	 r_c21_m_bureau_adl_fs_d;
   Integer	 r_l79_adls_per_addr_c6_i;
   Integer	 k_nap_lname_verd_d;
   Real   	 r_i60_inq_comm_recency_d;
   Integer	 r_d31_bk_disposed_hist_count_i;
   Integer	 r_f00_dob_score_d;
   Integer	 r_e57_prof_license_flag_d;
   Integer   r_c23_inp_addr_occ_index_d;
   Integer	 r_f00_input_dob_match_level_d;
   Integer	 r_c18_invalid_addrs_per_adl_i;
   String	   r_d31_bk_chapter_n;
   Integer	 k_inf_phn_verd_d;
   Integer	 k_nap_contradictory_i;
   Real	   k_inf_contradictory_i;
   REAL	 final_score_0;
   REAL	 final_score_1;
   REAL	 final_score_2;
   REAL	 final_score_3;
   REAL	 final_score_4;
   REAL	 final_score_5;
   REAL	 final_score_6;
   REAL	 final_score_7;
   REAL	 final_score_8;
   REAL	 final_score_9;
   REAL	 final_score_10;
   REAL	 final_score_11;
   REAL	 final_score_12;
   REAL	 final_score_13;
   REAL	 final_score_14;
   REAL	 final_score_15;
   REAL	 final_score_16;
   REAL	 final_score_17;
   REAL	 final_score_18;
   REAL	 final_score_19;
   REAL	 final_score_20;
   REAL	 final_score_21;
   REAL	 final_score_22;
   REAL	 final_score_23;
   REAL	 final_score_24;
   REAL	 final_score_25;
   REAL	 final_score_26;
   REAL	 final_score_27;
   REAL	 final_score_28;
   REAL	 final_score_29;
   REAL	 final_score_30;
   REAL	 final_score_31;
   REAL	 final_score_32;
   REAL	 final_score_33;
   REAL	 final_score_34;
   REAL	 final_score_35;
   REAL	 final_score_36;
   REAL	 final_score_37;
   REAL	 final_score_38;
   REAL	 final_score_39;
   REAL	 final_score_40;
   REAL	 final_score_41;
   REAL	 final_score_42;
   REAL	 final_score_43;
   REAL	 final_score_44;
   REAL	 final_score_45;
   REAL	 final_score_46;
   REAL	 final_score_47;
   REAL	 final_score_48;
   REAL	 final_score_49;
   REAL	 final_score_50;
   REAL	 final_score_51;
   REAL	 final_score_52;
   REAL	 final_score_53;
   REAL	 final_score_54;
   REAL	 final_score_55;
   REAL	 final_score_56;
   REAL	 final_score_57;
   REAL	 final_score_58;
   REAL	 final_score_59;
   REAL	 final_score_60;
   REAL	 final_score_61;
   REAL	 final_score_62;
   REAL	 final_score_63;
   REAL	 final_score_64;
   REAL	 final_score_65;
   REAL	 final_score_66;
   REAL	 final_score_67;
   REAL	 final_score_68;
   REAL	 final_score_69;
   REAL	 final_score_70;
   REAL	 final_score_71;
   REAL	 final_score_72;
   REAL	 final_score_73;
   REAL	 final_score_74;
   REAL	 final_score_75;
   REAL	 final_score_76;
   REAL	 final_score_77;
   REAL	 final_score_78;
   REAL	 final_score_79;
   REAL	 final_score_80;
   REAL	 final_score_81;
   REAL	 final_score_82;
   REAL	 final_score_83;
   REAL	 final_score_84;
   REAL	 final_score_85;
   REAL	 final_score_86;
   REAL	 final_score_87;
   REAL	 final_score_88;
   REAL	 final_score_89;
   REAL	 final_score_90;
   REAL	 final_score_91;
   REAL	 final_score_92;
   REAL	 final_score_93;
   REAL	 final_score_94;
   REAL	 final_score;
   Boolean	 iv_rv5_deceased;
   String	 iv_rv5_unscorable;
   Real	   pbr;
   Real	   sbr;
   Real	   offset;
   Integer	 base;
   Integer	 pts;
   Real	     lgt;
   Integer	 rvc1609_1_0;
   Real	     rc1v;
   Real	     rc2v;
   Real	     rc3v;
   Real	     rc4v;
   String	 _rc_inq;
   String	 rc3;
   String	 rc4;
   String	 rc2;
   String	 rc1;
   String	 rc5;


			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end
	
	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	adl_addr                         := le.adl_shell_flags.adl_addr;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	combo_dobscore                   := le.iid.combo_dobscore;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.lres2;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_chapter                       := le.bjl.bk_chapter;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	watercraft_count                 := le.watercraft.watercraft_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));
// sysdate :=(common.sas_date('20150501')); 

r_a44_curr_add_naprop_d := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

r_l80_inp_avm_autoval_d := map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                 min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));

r_a46_curr_avm_autoval_d := map(
    not(add_curr_pop)         => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000));

r_a41_prop_owner_d := map(
    not(truedid)               => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                 0);

k_estimated_income_d := if(not(truedid), NULL, estimated_income);

r_a49_curr_avm_chg_1yr_pct_i := map(
    not(add_curr_pop)       => NULL,
    add_curr_lres < 12      => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
              NULL);

// r_i60_inq_hiriskcred_recency_d := map(
    // not(truedid)               => NULL,
    // (Boolean)inq_highRiskCredit_count01 => 1,
    // (Boolean)inq_highRiskCredit_count03 => 3,
    // (Boolean)inq_highRiskCredit_count06 => 6,
    // (Boolean)inq_highRiskCredit_count12 => 12,
    // (Boolean)inq_highRiskCredit_count24 => 24,
    // (Boolean)inq_highRiskCredit_count   => 99,
                                  // 999);
	r_i60_inq_hiriskcred_recency_d := __common__( map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                                  999));																
																	


_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

k_comb_age_d := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                   NULL);

r_c14_addrs_10yr_i := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

r_c12_num_nonderogs_d := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999));

r_prop_owner_history_d := map(
    not(truedid)                  => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                    0);

r_e55_college_ind_d := map(
    not(truedid)          => NULL,
    (college_file_type in ['H', 'C', 'A']) => 1,
    college_attendance    => 1,
            0);

r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

k_nap_fname_verd_d := (integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]);

_header_first_seen := common.sas_date((string)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                 max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

r_i60_inq_hiriskcred_count12_i := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

r_c12_source_profile_d := if(not(truedid), NULL, hdr_source_profile);

r_i60_inq_recency_d := map(
    not(truedid) => NULL,
    (Boolean)inq_count01  => 1,
    (Boolean)inq_count03  => 3,
    (Boolean)inq_count06  => 6,
    (Boolean)inq_count12  => 12,
    (Boolean)inq_count24  => 24,
    (Boolean)inq_count    => 99,
                    999);

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_a41_prop_owner_inp_only_d := map(
    not(truedid)               => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 => 1,
                 0);

r_c13_max_lres_d := if(not(truedid), NULL, max_lres);

r_i60_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

custom_adl_addr := if((adl_addr in [1, 3]), 1, adl_addr);

r_e57_br_source_count_d := if(not(truedid), NULL, br_source_count);

r_f03_address_match_d := map(
    not(truedid)               => NULL,
    add_input_isbestmatch      => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop               => 1,
    add_input_pop              => 0,
                 NULL);

r_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

r_wealth_index_d := if(not(truedid), NULL, (INTEGER) wealth_index);

r_s66_adlperssn_count_i := map(
//    not(integer)ssnlength > '') => NULL,
    not((integer)ssnlength > 0) => NULL,
    adls_per_ssn = 0   => 1,
         min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

r_f03_input_add_not_most_rec_i := if(not(truedid and add_input_pop), NULL, (integer) rc_input_addr_not_most_recent);

r_ever_asset_owner_d := map(
    not(truedid)                                        => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => 1,
                                          0);

r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

// r_a49_curr_avm_chg_1yr_i := map(
    // not(add_curr_pop)  => NULL,
    // add_curr_lres < 12 => NULL,
         // add_curr_avm_auto_val - add_curr_avm_auto_val_2);
r_a49_curr_avm_chg_1yr_i := __common__( map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL) );






r_d33_eviction_recency_d := map(
    not(truedid)             => NULL,
    (Boolean)attr_eviction_count90    => 3,
    (Boolean)attr_eviction_count180   => 6,
    (Boolean)attr_eviction_count12    => 12,
    (Boolean)attr_eviction_count24    => 24,
    (Boolean)attr_eviction_count36    => 36,
    (Boolean)attr_eviction_count60    => 60,
    (Integer)attr_eviction_count >= 1 => 99,
                                999);														
																														
																

r_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

r_p85_phn_disconnected_i := map(
    not(hphnpop)          => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
            0);

r_i60_inq_comm_count12_i := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

r_l77_apartment_i := map(
    not(addrpop)                                => NULL,
    StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '') => 1,
                                  0);

	r_d31_attr_bankruptcy_recency_d := map(
	    not(truedid)             					=> NULL,
	    (boolean)attr_bankruptcy_count30  => 1,
	    (boolean)attr_bankruptcy_count90  => 3,
	    (boolean)attr_bankruptcy_count180 => 6,
	    (boolean)attr_bankruptcy_count12  => 12,
	    (boolean)attr_bankruptcy_count24  => 24,
	    (boolean)attr_bankruptcy_count36  => 36,
	    (boolean)attr_bankruptcy_count60  => 60,
	    (boolean)bankrupt                 => 99,
	    filing_count > 0         					=> 99,
																					 0);
	

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                     min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

k_nap_lname_verd_d := (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]);

r_i60_inq_comm_recency_d := map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                                  999);

r_d31_bk_disposed_hist_count_i := if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999));

r_f00_dob_score_d := if(not(truedid and dobpop) or combo_dobscore = 255, NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));

r_e57_prof_license_flag_d := if(not(truedid), NULL, (integer)prof_license_flag);

r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

r_f00_input_dob_match_level_d := if(not(truedid and dobpop), NULL, (integer)input_dob_match_level);

r_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

// r_d31_bk_chapter_n := map(
    // not(truedid)                => '',
    // not((bk_chapter in ['7', '11', '12', '13'])) => '',
                  // trim(bk_chapter, LEFT));
r_d31_bk_chapter_n := map(
    not(truedid)                                 => '',
    not((bk_chapter) in ['7', '11', '12', '13']) => '',
                                                    trim(bk_chapter, LEFT));
									

k_inf_phn_verd_d := (integer) (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

k_nap_contradictory_i := (integer)(nap_summary in [1]);

k_inf_contradictory_i := (Integer)(infutor_nap in [1]);

   final_score_0 :=  -1.5010336250;

// Tree: 1 
final_score_1 := map(
(NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 247504) => -0.0108561006,
   (r_A46_Curr_AVM_AutoVal_d > 247504) => 0.0602389954,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0250433565,
      (r_I60_inq_recency_d > 505.5) => 0.0003823593,
      (r_I60_inq_recency_d = NULL) => -0.0078992740, -0.0108561006), -0.0066479578),
(r_A41_Prop_Owner_Inp_Only_d > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 40500) => 0.0352238643,
   (k_estimated_income_d > 40500) => 0.1080966915,
   (k_estimated_income_d = NULL) => 0.0474612074, -0.0066479578),
(r_A41_Prop_Owner_Inp_Only_d = NULL) => 0.0004867237, 0.0004867237);

// Tree: 2 
final_score_2 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 217663) => -0.0134729785,
   (r_A46_Curr_AVM_AutoVal_d > 217663) => 0.0389533066,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0104105430, -0.0094169923),
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 190795) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0465548198,
      (r_D30_Derog_Count_i > 0.5) => -0.0032670998,
      (r_D30_Derog_Count_i = NULL) => 0.0221522469, 0.0221522469),
   (r_A46_Curr_AVM_AutoVal_d > 190795) => 0.0953149879,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0186440602, -0.0094169923),
(r_A41_Prop_Owner_d = NULL) => -0.0003825078, -0.0003825078);

// Tree: 3 
final_score_3 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162.5) => -0.0353981952,
      (r_D32_Mos_Since_Crim_LS_d > 162.5) => -0.0090615594,
      (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0130210715, -0.0130210715),
   (r_A44_curr_add_naprop_d > 2.5) => 0.0217020206,
   (r_A44_curr_add_naprop_d = NULL) => -0.0086400362, -0.0086400362),
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 119027) => 0.0106930298,
   (r_L80_Inp_AVM_AutoVal_d > 119027) => 0.0672557987,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0256898261, -0.0086400362),
(r_A41_Prop_Owner_d = NULL) => 0.0004797321, 0.0004797321);

// Tree: 4 
final_score_4 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 62.45) => -0.0176928229,
   (r_C12_source_profile_d > 62.45) => 0.0023480666,
   (r_C12_source_profile_d = NULL) => -0.0092750188, -0.0092750188),
(r_A44_curr_add_naprop_d > 1.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 151284.5) => 0.0079772627,
      (r_L80_Inp_AVM_AutoVal_d > 151284.5) => 0.0603461659,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0102835219, 0.0171876804),
   (k_nap_fname_verd_d > 0.5) => 0.0589046564,
   (k_nap_fname_verd_d = NULL) => 0.0267557942, -0.0092750188),
(r_A44_curr_add_naprop_d = NULL) => -0.0006572360, -0.0006572360);

// Tree: 5 
final_score_5 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0240670018,
   (r_I60_inq_recency_d > 505.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 1.5) => 0.0170749759,
      (r_C14_addrs_10yr_i > 1.5) => -0.0097609387,
      (r_C14_addrs_10yr_i = NULL) => -0.0006734191, -0.0240670018),
   (r_I60_inq_recency_d = NULL) => -0.0085616662, -0.0085616662),
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 76576) => -0.0104061338,
   (r_A46_Curr_AVM_AutoVal_d > 76576) => 0.0394507485,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0295561529, -0.0085616662),
(r_A41_Prop_Owner_d = NULL) => -0.0000784441, -0.0000784441);

// Tree: 6 
final_score_6 := map(
(NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 0.0113599551,
   (r_C14_addrs_15yr_i > 1.5) => -0.0149586074,
   (r_C14_addrs_15yr_i = NULL) => -0.0093356703, -0.0093356703),
(r_Prop_Owner_History_d > 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => 0.0302735861,
      (k_estimated_income_d > 33500) => 0.0708333614,
      (k_estimated_income_d = NULL) => 0.0456224052, 0.0456224052),
   (r_D30_Derog_Count_i > 0.5) => 0.0097223263,
   (r_D30_Derog_Count_i = NULL) => 0.0290633282, -0.0093356703),
(r_Prop_Owner_History_d = NULL) => -0.0010290420, -0.0010290420);

// Tree: 7 
final_score_7 := map(
(NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => -0.0033042103,
   (r_I60_Inq_Count12_i > 0.5) => -0.0233703408,
   (r_I60_Inq_Count12_i = NULL) => -0.0100773739, -0.0100773739),
(r_Ever_Asset_Owner_d > 0.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0317355970,
   (r_I60_inq_hiRiskCred_recency_d > 9) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 191245) => 0.0233157280,
      (r_L80_Inp_AVM_AutoVal_d > 191245) => 0.0605684578,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0206924227, -0.0317355970),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0199763665, -0.0100773739),
(r_Ever_Asset_Owner_d = NULL) => -0.0013989140, -0.0013989140);

// Tree: 8 
final_score_8 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 125241) => -0.0156603455,
   (r_L80_Inp_AVM_AutoVal_d > 125241) => 0.0177049214,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0092563562, -0.0078394247),
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0151022135,
   (k_nap_fname_verd_d > 0.5) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 0.0139522322,
      (r_A44_curr_add_naprop_d > 2.5) => 0.0645273735,
      (r_A44_curr_add_naprop_d = NULL) => 0.0457423210, 0.0151022135),
   (k_nap_fname_verd_d = NULL) => 0.0232885017, -0.0078394247),
(r_A41_Prop_Owner_d = NULL) => -0.0005170334, -0.0005170334);

// Tree: 9 
final_score_9 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 174.5) => -0.0109540573,
   (r_C13_Curr_Addr_LRes_d > 174.5) => 0.0305277362,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0088652035, -0.0088652035),
(r_A44_curr_add_naprop_d > 1.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 25500) => -0.0048927852,
   (k_estimated_income_d > 25500) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 0.0367186726,
      (r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0201939143,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0292045413, -0.0048927852),
   (k_estimated_income_d = NULL) => 0.0179691928, -0.0088652035),
(r_A44_curr_add_naprop_d = NULL) => -0.0023345904, -0.0023345904);

// Tree: 10 
final_score_10 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 32500) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 1.5) => 0.0077687613,
   (r_C14_addrs_10yr_i > 1.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => -0.0084278359,
      (r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0332080610,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0128563076, 0.0077687613),
   (r_C14_addrs_10yr_i = NULL) => -0.0057759888, -0.0057759888),
(k_estimated_income_d > 32500) => 
   map(
   (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 6.5) => 0.0506772839,
   (r_P88_Phn_Dst_to_Inp_Add_i > 6.5) => 0.0060832587,
   (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0168774541, -0.0057759888),
(k_estimated_income_d = NULL) => -0.0019583448, -0.0019583448);

// Tree: 11 
final_score_11 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162.5) => -0.0322043252,
   (r_D32_Mos_Since_Crim_LS_d > 162.5) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 0.0029389789,
      (r_I60_Inq_Count12_i > 1.5) => -0.0244012146,
      (r_I60_Inq_Count12_i = NULL) => -0.0028242284, -0.0322043252),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0070170447, -0.0070170447),
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < custom_adl_addr and custom_adl_addr <= 1.5) => 0.0028359490,
   (custom_adl_addr > 1.5) => 0.0372097379,
   (custom_adl_addr = NULL) => 0.0230328075, -0.0070170447),
(r_A44_curr_add_naprop_d = NULL) => -0.0001673578, -0.0001673578);

// Tree: 12 
final_score_12 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 43500) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => -0.0040458038,
      (r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0339554092,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0088752881, -0.0088752881),
   (r_A44_curr_add_naprop_d > 2.5) => 
      map(
      (NULL < custom_adl_addr and custom_adl_addr <= 1.5) => -0.0009228402,
      (custom_adl_addr > 1.5) => 0.0318584822,
      (custom_adl_addr = NULL) => 0.0177324245, -0.0088752881),
   (r_A44_curr_add_naprop_d = NULL) => -0.0031606207, -0.0031606207),
(k_estimated_income_d > 43500) => 0.0566243494,
(k_estimated_income_d = NULL) => -0.0008584460, -0.0008584460);

// Tree: 13 
final_score_13 := map(
(NULL < r_wealth_index_d and r_wealth_index_d <= 1) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 0.0029760784,
   (r_C14_addrs_10yr_i > 2.5) => -0.0174699401,
   (r_C14_addrs_10yr_i = NULL) => -0.0068008550, -0.0068008550),
(r_wealth_index_d > 1) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 50500) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 58.5) => 0.0067849970,
      (k_comb_age_d > 58.5) => 0.0446664000,
      (k_comb_age_d = NULL) => 0.0141706793, 0.0141706793),
   (k_estimated_income_d > 50500) => 0.0524343331,
   (k_estimated_income_d = NULL) => 0.0193090393, -0.0068008550),
(r_wealth_index_d = NULL) => -0.0009830309, -0.0009830309);

// Tree: 14 
final_score_14 := map(
(NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 0.5) => -0.0063423167,
   (r_I60_inq_comm_count12_i > 0.5) => -0.0439984445,
   (r_I60_inq_comm_count12_i = NULL) => -0.0096084635, -0.0096084635),
(r_Prop_Owner_History_d > 0.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 189752.5) => 0.0052962273,
      (r_L80_Inp_AVM_AutoVal_d > 189752.5) => 0.0455602931,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0113917949, 0.0119851137),
   (r_E55_College_Ind_d > 0.5) => 0.0527059988,
   (r_E55_College_Ind_d = NULL) => 0.0169741886, -0.0096084635),
(r_Prop_Owner_History_d = NULL) => -0.0018596098, -0.0018596098);

// Tree: 15 
final_score_15 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 175116) => -0.0114962390,
   (r_A46_Curr_AVM_AutoVal_d > 175116) => 0.0214507144,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0058770426, -0.0059090845),
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0101314378,
   (k_nap_fname_verd_d > 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 114966.5) => 0.0016234581,
      (r_A46_Curr_AVM_AutoVal_d > 114966.5) => 0.0636794190,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0469875970, 0.0101314378),
   (k_nap_fname_verd_d = NULL) => 0.0178707329, -0.0059090845),
(r_A41_Prop_Owner_d = NULL) => -0.0002024975, -0.0002024975);

// Tree: 16 
final_score_16 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 118651) => -0.0105498892,
(r_L80_Inp_AVM_AutoVal_d > 118651) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 0.0332922562,
   (r_I60_Inq_Count12_i > 1.5) => -0.0039720644,
   (r_I60_Inq_Count12_i = NULL) => 0.0261846202, -0.0105498892),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 65.1) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0131940127,
      (r_E55_College_Ind_d > 0.5) => 0.0176762479,
      (r_E55_College_Ind_d = NULL) => -0.0088898344, -0.0088898344),
   (r_C12_source_profile_d > 65.1) => 0.0130784122,
   (r_C12_source_profile_d = NULL) => -0.0004735181, -0.0105498892), 0.0012103191);

// Tree: 17 
final_score_17 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162.5) => -0.0314355300,
   (r_D32_Mos_Since_Crim_LS_d > 162.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => -0.0073618091,
      (r_C12_Num_NonDerogs_d > 3.5) => 0.0278678477,
      (r_C12_Num_NonDerogs_d = NULL) => -0.0050181368, -0.0314355300),
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0085897352, -0.0085897352),
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0031162391,
   (k_nap_fname_verd_d > 0.5) => 0.0434469695,
   (k_nap_fname_verd_d = NULL) => 0.0129273343, -0.0085897352),
(r_A44_curr_add_naprop_d = NULL) => -0.0034895200, -0.0034895200);

// Tree: 18 
final_score_18 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 165547.5) => -0.0143332064,
      (r_L80_Inp_AVM_AutoVal_d > 165547.5) => 0.0213133561,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0095138064, -0.0088762643),
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0291342327,
   (r_C12_Num_NonDerogs_d = NULL) => -0.0062893700, -0.0062893700),
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0268444968,
   (r_F03_input_add_not_most_rec_i > 0.5) => -0.0007687406,
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0154660600, -0.0062893700),
(r_A44_curr_add_naprop_d = NULL) => -0.0011770827, -0.0011770827);

// Tree: 19 
final_score_19 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 57.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 123939.5) => -0.0150079352,
      (r_L80_Inp_AVM_AutoVal_d > 123939.5) => 0.0145936248,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0079292125, -0.0067980002),
   (r_E55_College_Ind_d > 0.5) => 0.0183448711,
   (r_E55_College_Ind_d = NULL) => -0.0037274242, -0.0037274242),
(k_comb_age_d > 57.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 0.5) => 0.0580169995,
   (r_C14_addrs_15yr_i > 0.5) => 0.0155262051,
   (r_C14_addrs_15yr_i = NULL) => 0.0257586821, -0.0037274242),
(k_comb_age_d = NULL) => -0.0055906113, -0.0009112552);

// Tree: 20 
final_score_20 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 388.5) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 2.5) => -0.0141774122,
   (r_F03_address_match_d > 2.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 132.35) => 0.0173246189,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 132.35) => -0.0314102776,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0073377047, 0.0082547471),
      (r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0260509995,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0030070932, -0.0141774122),
   (r_F03_address_match_d = NULL) => -0.0042663656, -0.0042663656),
(r_C10_M_Hdr_FS_d > 388.5) => 0.0266703766,
(r_C10_M_Hdr_FS_d = NULL) => -0.0023594330, -0.0023594330);

// Tree: 21 
final_score_21 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0248610469,
(r_I60_inq_hiRiskCred_recency_d > 9) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 128442) => -0.0054385253,
         (r_L80_Inp_AVM_AutoVal_d > 128442) => 0.0155984033,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0048951800, -0.0025353184),
      (r_E57_br_source_count_d > 0.5) => 0.0264881408,
      (r_E57_br_source_count_d = NULL) => -0.0002299192, -0.0002299192),
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0249164987,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0023493447, -0.0248610469),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0005709008, -0.0005709008);

// Tree: 22 
final_score_22 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 0.5) => -0.0012416792,
   (r_D32_criminal_count_i > 0.5) => -0.0330867428,
   (r_D32_criminal_count_i = NULL) => -0.0055619070, -0.0055619070),
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 65556) => -0.0053932792,
      (r_A46_Curr_AVM_AutoVal_d > 65556) => 0.0206707164,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0448284738, 0.0246780635),
   (r_D30_Derog_Count_i > 0.5) => -0.0013623492,
   (r_D30_Derog_Count_i = NULL) => 0.0152991013, -0.0055619070),
(r_A44_curr_add_naprop_d = NULL) => -0.0006514761, -0.0006514761);

// Tree: 23 
final_score_23 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 299770) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 388.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 123.65) => 0.0064803953,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 123.65) => -0.0291190437,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0072131918, -0.0036107944),
   (r_C10_M_Hdr_FS_d > 388.5) => 0.0423445041,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0010163365, -0.0010163365),
(r_L80_Inp_AVM_AutoVal_d > 299770) => 0.0538291649,
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => -0.0016909830,
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0276993634,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0010852425, -0.0010163365), 0.0013873301);

// Tree: 24 
final_score_24 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162.5) => -0.0309333119,
   (r_D32_Mos_Since_Crim_LS_d > 162.5) => -0.0004333284,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0047164066, -0.0047164066),
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 112.45) => 0.0088285519,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 112.45) => -0.0203792217,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0145568205, 0.0051247689),
   (k_nap_fname_verd_d > 0.5) => 0.0315705080,
   (k_nap_fname_verd_d = NULL) => 0.0116471608, -0.0047164066),
(r_A44_curr_add_naprop_d = NULL) => -0.0008377318, -0.0008377318);

// Tree: 25 
final_score_25 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 372.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0224191421,
   (r_I60_inq_hiRiskCred_recency_d > 505.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 80819) => -0.0097882693,
      (r_A46_Curr_AVM_AutoVal_d > 80819) => 0.0153724251,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => -0.0036402768,
         (r_C12_Num_NonDerogs_d > 3.5) => 0.0320605282,
         (r_C12_Num_NonDerogs_d = NULL) => -0.0008162076, -0.0097882693), -0.0224191421),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0017918185, -0.0017918185),
(r_C10_M_Hdr_FS_d > 372.5) => 0.0291155718,
(r_C10_M_Hdr_FS_d = NULL) => 0.0006003753, 0.0006003753);

// Tree: 26 
final_score_26 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 129.35) => 0.0238340159,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 129.35) => -0.0153903186,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0078800417, 0.0113612411),
(r_C14_addrs_10yr_i > 1.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => -0.0098319931,
   (k_estimated_income_d > 33500) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 0.0078431150,
      (r_A44_curr_add_naprop_d > 2.5) => 0.0419903209,
      (r_A44_curr_add_naprop_d = NULL) => 0.0189132815, -0.0098319931),
   (k_estimated_income_d = NULL) => -0.0063432355, 0.0113612411),
(r_C14_addrs_10yr_i = NULL) => -0.0003121955, -0.0003121955);

// Tree: 27 
final_score_27 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 19.5) => -0.0108590260,
   (k_comb_age_d > 19.5) => 0.0174851034,
   (k_comb_age_d = NULL) => 0.0137661928, 0.0137661928),
(r_C14_addrs_15yr_i > 1.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 51000) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 43.4) => -0.0259290446,
      (r_C12_source_profile_d > 43.4) => -0.0057785324,
      (r_C12_source_profile_d = NULL) => -0.0101713549, -0.0101713549),
   (k_estimated_income_d > 51000) => 0.0297764688,
   (k_estimated_income_d = NULL) => -0.0087591106, 0.0137661928),
(r_C14_addrs_15yr_i = NULL) => -0.0035198320, -0.0035198320);

// Tree: 28 
final_score_28 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 59.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 127361) => -0.0143124853,
   (r_L80_Inp_AVM_AutoVal_d > 127361) => 0.0101855605,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 0.0039117719,
      (r_C14_addrs_10yr_i > 2.5) => -0.0138563382,
      (r_C14_addrs_10yr_i = NULL) => -0.0048321972, -0.0143124853), -0.0051186187),
(k_comb_age_d > 59.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 166.5) => 0.0059440246,
   (r_C13_Curr_Addr_LRes_d > 166.5) => 0.0434437077,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0191439130, -0.0051186187),
(k_comb_age_d = NULL) => -0.0149166661, -0.0036147177);

// Tree: 29 
final_score_29 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => -0.0247880351,
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0235076947,
   (r_I60_inq_hiRiskCred_recency_d > 9) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 63377.5) => -0.0122208669,
      (r_L80_Inp_AVM_AutoVal_d > 63377.5) => 0.0151047246,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => -0.0004437202,
         (r_C12_Num_NonDerogs_d > 3.5) => 0.0271878896,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0021008400, -0.0122208669), -0.0235076947),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0010780896, -0.0247880351),
(r_D33_Eviction_Recency_d = NULL) => -0.0022926108, -0.0022926108);

// Tree: 30 
final_score_30 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 51000) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => -0.0180956014,
   (r_I60_inq_recency_d > 9) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 119027) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 57.5) => -0.0142013433,
         (k_comb_age_d > 57.5) => 0.0269754620,
         (k_comb_age_d = NULL) => -0.0088080259, -0.0088080259),
      (r_L80_Inp_AVM_AutoVal_d > 119027) => 0.0173557473,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0024158053, -0.0180956014),
   (r_I60_inq_recency_d = NULL) => -0.0023993583, -0.0023993583),
(k_estimated_income_d > 51000) => 0.0350376866,
(k_estimated_income_d = NULL) => -0.0012712414, -0.0012712414);

// Tree: 31 
final_score_31 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 373.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 299770) => -0.0047834640,
   (r_L80_Inp_AVM_AutoVal_d > 299770) => 0.0334367742,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 43.5) => -0.0183639742,
      (r_C13_max_lres_d > 43.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0119928648,
         (r_D30_Derog_Count_i > 0.5) => -0.0090534694,
         (r_D30_Derog_Count_i = NULL) => 0.0024381485, -0.0183639742),
      (r_C13_max_lres_d = NULL) => -0.0032377670, -0.0047834640), -0.0029771609),
(r_C10_M_Hdr_FS_d > 373.5) => 0.0228136309,
(r_C10_M_Hdr_FS_d = NULL) => -0.0010577744, -0.0010577744);

// Tree: 32 
final_score_32 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 0.0189651813,
(r_C14_addrs_10yr_i > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 80389.5) => -0.0185591874,
   (r_A46_Curr_AVM_AutoVal_d > 80389.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 279439) => 0.0041837010,
      (r_A46_Curr_AVM_AutoVal_d > 279439) => 0.0350914805,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0075727119, -0.0185591874),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0090768363,
      (r_E55_College_Ind_d > 0.5) => 0.0183945965,
      (r_E55_College_Ind_d = NULL) => -0.0052730994, -0.0185591874), 0.0189651813),
(r_C14_addrs_10yr_i = NULL) => -0.0015347920, -0.0015347920);

// Tree: 33 
final_score_33 := map(
(NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0133054636,
   (r_F03_address_match_d > 3.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 5.5) => 0.0074796124,
      (r_C14_addrs_15yr_i > 5.5) => -0.0194445125,
      (r_C14_addrs_15yr_i = NULL) => 0.0011216848, -0.0133054636),
   (r_F03_address_match_d = NULL) => -0.0051261477, -0.0051261477),
(r_Prop_Owner_History_d > 1.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 90298.5) => -0.0084606654,
   (r_A46_Curr_AVM_AutoVal_d > 90298.5) => 0.0157596695,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0197588911, -0.0051261477),
(r_Prop_Owner_History_d = NULL) => -0.0013351952, -0.0013351952);

// Tree: 34 
final_score_34 := map(
(NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 55805) => -0.0219167231,
   (r_A46_Curr_AVM_AutoVal_d > 55805) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 136.65) => 0.0117797945,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 136.65) => -0.0292684711,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0042165323, -0.0219167231),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0044351008, -0.0033766682),
(r_C12_Num_NonDerogs_d > 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 124347.5) => -0.0093342909,
   (r_A46_Curr_AVM_AutoVal_d > 124347.5) => 0.0170471290,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0346839919, -0.0033766682),
(r_C12_Num_NonDerogs_d = NULL) => -0.0012017610, -0.0012017610);

// Tree: 35 
final_score_35 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 1.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 34.5) => -0.0048771170,
   (r_C13_Curr_Addr_LRes_d > 34.5) => 0.0149864463,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0082822106, 0.0082822106),
(r_C14_addrs_10yr_i > 1.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0321525775,
   (r_I60_inq_hiRiskCred_recency_d > 505.5) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 3.5) => -0.0055978211,
      (r_wealth_index_d > 3.5) => 0.0262974990,
      (r_wealth_index_d = NULL) => -0.0033789131, -0.0321525775),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0084202639, 0.0082822106),
(r_C14_addrs_10yr_i = NULL) => -0.0025762303, -0.0025762303);

// Tree: 36 
final_score_36 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 
   map(
   (NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => -0.0024674566,
   (r_A41_Prop_Owner_d > 0.5) => 
      map(
      (NULL < r_D31_bk_disposed_hist_count_i and r_D31_bk_disposed_hist_count_i <= 0.5) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0178190690,
         (r_I60_inq_hiRiskCred_recency_d > 505.5) => 0.0207346662,
         (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0156576311, 0.0156576311),
      (r_D31_bk_disposed_hist_count_i > 0.5) => -0.0292426508,
      (r_D31_bk_disposed_hist_count_i = NULL) => 0.0108704687, -0.0024674566),
   (r_A41_Prop_Owner_d = NULL) => 0.0005902052, 0.0005902052),
(k_comb_age_d > 71.5) => 0.0492289872,
(k_comb_age_d = NULL) => 0.0096332170, 0.0019422319);


// Tree: 37 
final_score_37 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0050923438,
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 106.1001) => 0.0264341804,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 106.1001) => -0.0074329432,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0399463388, 0.0222903641),
   (r_F03_input_add_not_most_rec_i > 0.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 75.55) => -0.0130336295,
      (r_C12_source_profile_d > 75.55) => 0.0284403316,
      (r_C12_source_profile_d = NULL) => -0.0045070467, 0.0222903641),
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0109608259, -0.0050923438),
(r_A44_curr_add_naprop_d = NULL) => -0.0012921324, -0.0012921324);





// Tree: 38 
final_score_38 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 74311.5) => -0.0072932407,
      (r_L80_Inp_AVM_AutoVal_d > 74311.5) => 0.0177021226,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0016645449, 0.0020258493),
   (r_S66_adlperssn_count_i > 1.5) => -0.0102784565,
   (r_S66_adlperssn_count_i = NULL) => -0.0036718354, -0.0036718354),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 0.0092240011,
   (r_A44_curr_add_naprop_d > 1.5) => 0.0431466297,
   (r_A44_curr_add_naprop_d = NULL) => 0.0183637767, -0.0036718354),
(r_E55_College_Ind_d = NULL) => -0.0011267288, -0.0011267288);

// Tree: 39 
final_score_39 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 1.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
      map(
      (NULL < r_F00_dob_score_d and r_F00_dob_score_d <= 95.5) => -0.0151995094,
      (r_F00_dob_score_d > 95.5) => 
         map(
         (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0215757235,
         (r_I60_inq_hiRiskCred_recency_d > 9) => 0.0133359401,
         (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0101621525, -0.0151995094),
      (r_F00_dob_score_d = NULL) => -0.0046909448, 0.0054220677),
   (r_I60_Inq_Count12_i > 1.5) => -0.0116253389,
   (r_I60_Inq_Count12_i = NULL) => 0.0020344654, 0.0020344654),
(r_D32_criminal_count_i > 1.5) => -0.0299305501,
(r_D32_criminal_count_i = NULL) => -0.0001148184, -0.0001148184);

// Tree: 40 
final_score_40 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 71.5) => -0.0219738942,
(r_D32_Mos_Since_Crim_LS_d > 71.5) => 
   map(
   (NULL < r_I60_inq_comm_count12_i and r_I60_inq_comm_count12_i <= 0.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 113690) => 0.0000306560,
      (r_L80_Inp_AVM_AutoVal_d > 113690) => 0.0167339952,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_wealth_index_d and r_wealth_index_d <= 1) => -0.0002420239,
         (r_wealth_index_d > 1) => 0.0156837099,
         (r_wealth_index_d = NULL) => 0.0026888198, 0.0000306560), 0.0042939573),
   (r_I60_inq_comm_count12_i > 0.5) => -0.0231108719,
   (r_I60_inq_comm_count12_i = NULL) => 0.0022293388, -0.0219738942),
(r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0008896096, -0.0008896096);

// Tree: 41 
final_score_41 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 127477.5) => -0.0047005623,
(r_L80_Inp_AVM_AutoVal_d > 127477.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0229420139,
   (r_D30_Derog_Count_i > 1.5) => -0.0111187310,
   (r_D30_Derog_Count_i = NULL) => 0.0158054769, -0.0047005623),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 353.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0051616865,
      (r_S66_adlperssn_count_i > 1.5) => -0.0056455210,
      (r_S66_adlperssn_count_i = NULL) => -0.0053785007, -0.0053785007),
   (r_C21_M_Bureau_ADL_FS_d > 353.5) => 0.0180960849,
   (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0028425061, -0.0047005623), -0.0009467033);

// Tree: 42 
final_score_42 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
   map(
   (NULL < r_E57_prof_license_flag_d and r_E57_prof_license_flag_d <= 0.5) => 
      map(
      (NULL < custom_adl_addr and custom_adl_addr <= 1.5) => -0.0054965161,
      (custom_adl_addr > 1.5) => 
         map(
         (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 0.5) => 0.0045965522,
         (r_D31_attr_bankruptcy_recency_d > 0.5) => 0.0410349267,
         (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0068870642, -0.0054965161),
      (custom_adl_addr = NULL) => 0.0007401638, 0.0007401638),
   (r_E57_prof_license_flag_d > 0.5) => 0.0331819307,
   (r_E57_prof_license_flag_d = NULL) => 0.0017577660, 0.0017577660),
(r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0226751708,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0018538051, -0.0018538051);

// Tree: 43 
final_score_43 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0247360031,
(r_I60_inq_hiRiskCred_recency_d > 9) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 25500) => -0.0049748715,
   (k_estimated_income_d > 25500) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0174806371,
      (r_D30_Derog_Count_i > 0.5) => 
         map(
         (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 19.5) => 0.0206076286,
         (r_P88_Phn_Dst_to_Inp_Add_i > 19.5) => -0.0056362809,
         (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => -0.0094640608, 0.0174806371),
      (r_D30_Derog_Count_i = NULL) => 0.0093032360, -0.0049748715),
   (k_estimated_income_d = NULL) => 0.0029141369, -0.0247360031),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0002635328, -0.0002635328);

// Tree: 44 
final_score_44 := map(
(NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 4.5) => -0.0207660546,
(r_I60_inq_recency_d > 4.5) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 2.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 245.5) => -0.0111144058,
      (r_C13_max_lres_d > 245.5) => 0.0216922526,
      (r_C13_max_lres_d = NULL) => -0.0085894391, -0.0085894391),
   (r_F03_address_match_d > 2.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 123.6001) => 0.0101469164,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 123.6001) => -0.0229846736,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0051242002, -0.0085894391),
   (r_F03_address_match_d = NULL) => -0.0007908054, -0.0207660546),
(r_I60_inq_recency_d = NULL) => -0.0030346333, -0.0030346333);

// Tree: 45 
final_score_45 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.95) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 125244) => 0.0103922650,
   (r_L80_Inp_AVM_AutoVal_d > 125244) => 0.0292271542,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0033602661, 0.0110305085),
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.95) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 30.5) => -0.0358592692,
   (r_C13_Curr_Addr_LRes_d > 30.5) => -0.0017372041,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0101129952, 0.0110305085),
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162.5) => -0.0183782786,
   (r_D32_Mos_Since_Crim_LS_d > 162.5) => 0.0021225532,
   (r_D32_Mos_Since_Crim_LS_d = NULL) => -0.0006815297, 0.0110305085), -0.0006440770);

// Tree: 46 
final_score_46 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 84.9) => 
   map(
   (NULL < custom_adl_addr and custom_adl_addr <= 1.5) => -0.0065624670,
   (custom_adl_addr > 1.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 118588.5) => -0.0071726220,
      (r_L80_Inp_AVM_AutoVal_d > 118588.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.85) => 0.0362655537,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.85) => 0.0022296074,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0103871887, -0.0071726220),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0081242910, -0.0065624670),
   (custom_adl_addr = NULL) => -0.0007174742, -0.0007174742),
(r_C12_source_profile_d > 84.9) => 0.0346213570,
(r_C12_source_profile_d = NULL) => 0.0000015684, 0.0000015684);

// Tree: 47 
final_score_47 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
   map(
   (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => -0.0004691982,
   (r_Prop_Owner_History_d > 1.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => -0.0111183701,
      (k_estimated_income_d > 26500) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 35.5) => 0.0132233525,
         (k_comb_age_d > 35.5) => 0.0256023467,
         (k_comb_age_d = NULL) => 0.0229033626, -0.0111183701),
      (k_estimated_income_d = NULL) => 0.0168013260, -0.0004691982),
   (r_Prop_Owner_History_d = NULL) => 0.0029907611, 0.0029907611),
(r_D30_Derog_Count_i > 0.5) => -0.0085082353,
(r_D30_Derog_Count_i = NULL) => -0.0017427707, -0.0017427707);

// Tree: 48 
final_score_48 := map(
(NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 505.5) => -0.0308761428,
(r_I60_inq_comm_recency_d > 505.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0154048708,
   (r_I60_inq_hiRiskCred_recency_d > 505.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.0119592901,
      (r_D33_Eviction_Recency_d > 549) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0038925896,
         (r_E57_br_source_count_d > 0.5) => 0.0207086728,
         (r_E57_br_source_count_d = NULL) => 0.0054427595, -0.0119592901),
      (r_D33_Eviction_Recency_d = NULL) => 0.0028682825, -0.0154048708),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0002056797, -0.0308761428),
(r_I60_inq_comm_recency_d = NULL) => -0.0023126241, -0.0023126241);

// Tree: 49 
final_score_49 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0042019740,
      (r_E57_br_source_count_d > 0.5) => 0.0244001639,
      (r_E57_br_source_count_d = NULL) => 0.0058857067, 0.0058857067),
   (r_D30_Derog_Count_i > 1.5) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => -0.0175267408,
      (k_nap_fname_verd_d > 0.5) => 0.0170944270,
      (k_nap_fname_verd_d = NULL) => -0.0116563487, 0.0058857067),
   (r_D30_Derog_Count_i = NULL) => 0.0016326923, 0.0016326923),
(r_I60_Inq_Count12_i > 1.5) => -0.0132481833,
(r_I60_Inq_Count12_i = NULL) => -0.0012615534, -0.0012615534);

// Tree: 50 
final_score_50 := map(
(NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => -0.0044572245,
(r_Prop_Owner_History_d > 1.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0205181561,
         (r_L79_adls_per_addr_curr_i > 2.5) => -0.0107537554,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0076627282, 0.0076627282),
      (r_F03_input_add_not_most_rec_i > 0.5) => -0.0060302236,
      (r_F03_input_add_not_most_rec_i = NULL) => 0.0013718340, 0.0013718340),
   (k_nap_fname_verd_d > 0.5) => 0.0205117040,
   (k_nap_fname_verd_d = NULL) => 0.0066452399, -0.0044572245),
(r_Prop_Owner_History_d = NULL) => -0.0020045348, -0.0020045348);

// Tree: 51 
final_score_51 := map(
(NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 197.5) => -0.0180718100,
   (r_C10_M_Hdr_FS_d > 197.5) => 0.0016402147,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0096464109, -0.0096464109),
(r_I60_inq_recency_d > 505.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 128.8) => 0.0057052992,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 128.8) => -0.0232638909,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0029464634, 0.0021915754),
   (r_E57_br_source_count_d > 0.5) => 0.0208447595,
   (r_E57_br_source_count_d = NULL) => 0.0039008094, -0.0096464109),
(r_I60_inq_recency_d = NULL) => -0.0004744050, -0.0004744050);

// Tree: 52 
final_score_52 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 59.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 135.8) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => -0.0103097542,
      (r_A44_curr_add_naprop_d > 1.5) => 0.0092389048,
      (r_A44_curr_add_naprop_d = NULL) => -0.0018204299, -0.0018204299),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 135.8) => -0.0283999735,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 170691) => -0.0097920311,
      (r_A46_Curr_AVM_AutoVal_d > 170691) => 0.0267834759,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0015419599, -0.0018204299), -0.0030778396),
(k_comb_age_d > 59.5) => 0.0185815927,
(k_comb_age_d = NULL) => -0.0035309047, -0.0015704657);

// Tree: 53 
final_score_53 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 0.0228953080,
   (r_C14_addrs_10yr_i > 0.5) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => -0.0036401799,
      (r_P85_Phn_Disconnected_i > 0.5) => -0.0084446530,
      (r_P85_Phn_Disconnected_i = NULL) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => 0.0162270597,
         (r_S66_adlperssn_count_i > 2.5) => -0.0264295182,
         (r_S66_adlperssn_count_i = NULL) => 0.0118200449, -0.0036401799), 0.0228953080),
   (r_C14_addrs_10yr_i = NULL) => 0.0049715683, 0.0049715683),
(r_D30_Derog_Count_i > 0.5) => -0.0095727849,
(r_D30_Derog_Count_i = NULL) => -0.0009901362, -0.0009901362);

// Tree: 54 
final_score_54 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 50681) => -0.0198146841,
(r_A46_Curr_AVM_AutoVal_d > 50681) => 0.0033395614,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 49.5) => -0.0138387580,
   (r_C13_max_lres_d > 49.5) => 
      map(
      (NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162) => -0.0238723200,
      (r_D32_Mos_Since_Crim_LS_d > 162) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => 0.0095321121,
         (r_C23_inp_addr_occ_index_d > 3.5) => 0.0497529997,
         (r_C23_inp_addr_occ_index_d = NULL) => 0.0124238099, -0.0238723200),
      (r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0076480034, -0.0138387580),
   (r_C13_max_lres_d = NULL) => 0.0008391918, -0.0198146841), -0.0002830509);

// Tree: 55 
final_score_55 := map(
(NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => 0.0004159640,
      (r_F03_address_match_d > 3) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 126.9) => 0.0162863682,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 126.9) => -0.0258736156,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0167499388, 0.0004159640),
      (r_F03_address_match_d = NULL) => 0.0079844905, 0.0079844905),
   (r_I60_Inq_Count12_i > 1.5) => -0.0103944885,
   (r_I60_Inq_Count12_i = NULL) => 0.0045660594, 0.0045660594),
(r_L77_Apartment_i > 0.5) => -0.0094264274,
(r_L77_Apartment_i = NULL) => 0.0010225619, 0.0010225619);

// Tree: 56 
final_score_56 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0163204438,
(r_I60_inq_hiRiskCred_recency_d > 505.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 103.95) => 0.0106448123,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 103.95) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 0.5) => 0.0297409707,
      (r_L79_adls_per_addr_curr_i > 0.5) => -0.0159080889,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0093331215, 0.0106448123),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 157615) => -0.0085133440,
      (r_A46_Curr_AVM_AutoVal_d > 157615) => 0.0332719146,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0043755772, 0.0106448123), -0.0163204438),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0005692886, -0.0005692886);

// Tree: 57 
final_score_57 := map(
(NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => -0.0175797295,
(r_D33_Eviction_Recency_d > 79.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 377.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 187977.5) => -0.0064502488,
      (r_A46_Curr_AVM_AutoVal_d > 187977.5) => 0.0117343002,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.0011703205,
         (r_C12_Num_NonDerogs_d > 3.5) => 0.0268513638,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0034465692, -0.0064502488), 0.0004946658),
   (r_C10_M_Hdr_FS_d > 377.5) => 0.0219606607,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0019938937, -0.0175797295),
(r_D33_Eviction_Recency_d = NULL) => -0.0005250582, -0.0005250582);

// Tree: 58 
final_score_58 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 2.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 5.5) => -0.0002143755,
      (r_C14_addrs_10yr_i > 5.5) => -0.0207109616,
      (r_C14_addrs_10yr_i = NULL) => -0.0024794318, -0.0024794318),
   (r_D32_criminal_count_i > 2.5) => -0.0384719521,
   (r_D32_criminal_count_i = NULL) => -0.0040915208, -0.0040915208),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 25.5) => 0.0034160816,
   (k_comb_age_d > 25.5) => 0.0149104936,
   (k_comb_age_d = NULL) => 0.0124397322, -0.0040915208),
(r_E55_College_Ind_d = NULL) => -0.0022118452, -0.0022118452);

// Tree: 59 
final_score_59 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 359.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 58500) => -0.0023333578,
   (k_estimated_income_d > 58500) => 0.0210335059,
   (k_estimated_income_d = NULL) => -0.0017413973, -0.0017413973),
(r_C21_M_Bureau_ADL_FS_d > 359.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 63.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 175.5) => -0.0086306965,
      (r_C13_max_lres_d > 175.5) => 0.0282355921,
      (r_C13_max_lres_d = NULL) => 0.0074270426, 0.0074270426),
   (k_comb_age_d > 63.5) => 0.0417635811,
   (k_comb_age_d = NULL) => 0.0157936455, -0.0017413973),
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0000530326, 0.0000530326);

// Tree: 60 
final_score_60 := map(
(NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 34.5) => -0.0187083630,
      (k_comb_age_d > 34.5) => 0.0031876635,
      (k_comb_age_d = NULL) => -0.0083747413, -0.0083747413),
   (r_I60_inq_recency_d > 505.5) => 
      map(
      (NULL < k_nap_contradictory_i and k_nap_contradictory_i <= 0.5) => 0.0075335643,
      (k_nap_contradictory_i > 0.5) => -0.0157895585,
      (k_nap_contradictory_i = NULL) => 0.0056104689, -0.0083747413),
   (r_I60_inq_recency_d = NULL) => 0.0010258436, 0.0010258436),
(r_D32_criminal_count_i > 1.5) => -0.0298430109,
(r_D32_criminal_count_i = NULL) => -0.0011786348, -0.0011786348);

// Tree: 61 
final_score_61 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -22248.5) => 0.0447189381,
(r_A49_Curr_AVM_Chg_1yr_i > -22248.5) => 
   map(
   (NULL < k_inf_phn_verd_d and k_inf_phn_verd_d <= 0.5) => -0.0061826792,
   (k_inf_phn_verd_d > 0.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 3.5) => 0.0246561408,
      (r_C14_addrs_15yr_i > 3.5) => -0.0031566387,
      (r_C14_addrs_15yr_i = NULL) => 0.0118308131, -0.0061826792),
   (k_inf_phn_verd_d = NULL) => 0.0009074714, 0.0447189381),
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 65.15) => -0.0042381982,
   (r_C12_source_profile_d > 65.15) => 0.0088684509,
   (r_C12_source_profile_d = NULL) => 0.0005357468, 0.0447189381), 0.0015323648);

// Tree: 62 
final_score_62 := map(
(NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => -0.0017460524,
   (r_C12_Num_NonDerogs_d > 2.5) => 0.0261166259,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0118547126, 0.0118547126),
(r_C14_addrs_10yr_i > 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 89397) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0032641505,
      (r_L79_adls_per_addr_curr_i > 2.5) => -0.0246118731,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0100961199, -0.0100961199),
   (r_L80_Inp_AVM_AutoVal_d > 89397) => 0.0056245242,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0056366881, 0.0118547126),
(r_C14_addrs_10yr_i = NULL) => -0.0023043619, -0.0023043619);

// Tree: 63 
final_score_63 := map(
(NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0175167359,
   (r_I60_inq_hiRiskCred_recency_d > 9) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 127361) => -0.0037504232,
      (r_L80_Inp_AVM_AutoVal_d > 127361) => 0.0139805387,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 0.0073767312,
         (r_L79_adls_per_addr_c6_i > 1.5) => -0.0128481619,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0043996149, -0.0037504232), -0.0175167359),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0014581475, 0.0014581475),
(r_C14_addrs_5yr_i > 4.5) => -0.0390230281,
(r_C14_addrs_5yr_i = NULL) => 0.0001736720, 0.0001736720);

// Tree: 64 
final_score_64 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 259656) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 0.0163700615,
      (r_L79_adls_per_addr_curr_i > 1.5) => -0.0071031914,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0018071229, -0.0018071229),
   (r_L80_Inp_AVM_AutoVal_d > 259656) => 0.0208633706,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 71.95) => -0.0086082481,
      (r_C12_source_profile_d > 71.95) => 0.0101908412,
      (r_C12_source_profile_d = NULL) => -0.0043583804, -0.0018071229), -0.0027090597),
(r_E55_College_Ind_d > 0.5) => 0.0148497700,
(r_E55_College_Ind_d = NULL) => -0.0006144696, -0.0006144696);

// Tree: 65 
final_score_65 := map(
(NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => -0.0054887913,
(k_nap_lname_verd_d > 0.5) => 
   map(
   (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 108562.5) => -0.0142371797,
         (r_A46_Curr_AVM_AutoVal_d > 108562.5) => 0.0140279326,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0116651730, 0.0064240423),
      (r_E55_College_Ind_d > 0.5) => 0.0360659563,
      (r_E55_College_Ind_d = NULL) => 0.0111567849, 0.0111567849),
   (r_P85_Phn_Disconnected_i > 0.5) => -0.0063232939,
   (r_P85_Phn_Disconnected_i = NULL) => 0.0292034675, -0.0054887913),
(k_nap_lname_verd_d = NULL) => -0.0021741956, -0.0021741956);

// Tree: 66 
final_score_66 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 35006) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 
      map(
      (NULL < custom_adl_addr and custom_adl_addr <= 1.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 0.0095735689,
         (r_L79_adls_per_addr_curr_i > 1.5) => -0.0208112114,
         (r_L79_adls_per_addr_curr_i = NULL) => -0.0047588747, -0.0047588747),
      (custom_adl_addr > 1.5) => 0.0133702189,
      (custom_adl_addr = NULL) => 0.0048740279, 0.0048740279),
   (r_L79_adls_per_addr_curr_i > 4.5) => -0.0217962778,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0020212817, 0.0020212817),
(r_A49_Curr_AVM_Chg_1yr_i > 35006) => -0.0289086290,
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0021975779, -0.0018565433);

// Tree: 67 
final_score_67 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 83.25) => 0.0251220881,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 83.25) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => -0.0097100191,
      (r_F03_address_match_d > 3) => 0.0184228647,
      (r_F03_address_match_d = NULL) => 0.0091782528, 0.0091782528),
   (r_C14_addrs_15yr_i > 1.5) => -0.0081767185,
   (r_C14_addrs_15yr_i = NULL) => -0.0028260240, 0.0251220881),
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => -0.0017243472,
   (r_E57_br_source_count_d > 0.5) => 0.0178906209,
   (r_E57_br_source_count_d = NULL) => -0.0002150671, 0.0251220881), 0.0000002907);

// Tree: 68 
final_score_68 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162.5) => -0.0198382354,
(r_D32_Mos_Since_Crim_LS_d > 162.5) => 
   map(
   (NULL < custom_adl_addr and custom_adl_addr <= 1.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 186543) => -0.0125713797,
      (r_A46_Curr_AVM_AutoVal_d > 186543) => 0.0157930598,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0002985573, -0.0028246961),
   (custom_adl_addr > 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 30392) => 0.0152650330,
      (r_A49_Curr_AVM_Chg_1yr_i > 30392) => -0.0151130814,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0083164289, -0.0028246961),
   (custom_adl_addr = NULL) => 0.0033521762, -0.0198382354),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0001885860, 0.0001885860);

// Tree: 69 
final_score_69 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0106515788,
   (r_I60_inq_recency_d > 505.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 113717) => -0.0015651679,
      (r_L80_Inp_AVM_AutoVal_d > 113717) => 0.0244710724,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0049582821, -0.0106515788),
   (r_I60_inq_recency_d = NULL) => 0.0013074864, 0.0013074864),
(r_S66_adlperssn_count_i > 1.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0105841246,
   (r_E55_College_Ind_d > 0.5) => 0.0115509719,
   (r_E55_College_Ind_d = NULL) => -0.0081544209, 0.0013074864),
(r_S66_adlperssn_count_i = NULL) => -0.0029581119, -0.0029581119);

// Tree: 70 
final_score_70 := map(
(NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 133.05) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 4.5) => 0.0190278603,
      (r_P88_Phn_Dst_to_Inp_Add_i > 4.5) => -0.0191077887,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0049179121, 0.0044955180),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 133.05) => -0.0229027982,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0024906325, -0.0016996504),
(r_C12_Num_NonDerogs_d > 3.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0243800387,
   (r_F03_input_add_not_most_rec_i > 0.5) => -0.0008704610,
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0131688169, -0.0016996504),
(r_C12_Num_NonDerogs_d = NULL) => -0.0002166595, -0.0002166595);

// Tree: 71 
final_score_71 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 1.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
      (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 9) => -0.0261763249,
      (r_I60_inq_comm_recency_d > 9) => 0.0017470198,
      (r_I60_inq_comm_recency_d = NULL) => 0.0006615189, 0.0006615189),
   (r_E55_College_Ind_d > 0.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0042032379,
      (r_I60_inq_recency_d > 505.5) => 0.0237518283,
      (r_I60_inq_recency_d = NULL) => 0.0149052884, 0.0006615189),
   (r_E55_College_Ind_d = NULL) => 0.0023211912, 0.0023211912),
(r_I60_inq_hiRiskCred_count12_i > 1.5) => -0.0297922070,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0006107828, 0.0006107828);

// Tree: 72 
final_score_72 := map(
(NULL < k_nap_lname_verd_d and k_nap_lname_verd_d <= 0.5) => -0.0028526639,
(k_nap_lname_verd_d > 0.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 26500) => -0.0090397526,
      (k_estimated_income_d > 26500) => 
         map(
         (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 0.0204283049,
         (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0202808979,
         (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0138728777, -0.0090397526),
      (k_estimated_income_d = NULL) => 0.0047611624, 0.0047611624),
   (r_E57_br_source_count_d > 0.5) => 0.0342549297,
   (r_E57_br_source_count_d = NULL) => 0.0083757177, -0.0028526639),
(k_nap_lname_verd_d = NULL) => -0.0002191224, -0.0002191224);

// Tree: 73 
final_score_73 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 344.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 65.15) => -0.0069156149,
      (r_C12_source_profile_d > 65.15) => 0.0038069910,
      (r_C12_source_profile_d = NULL) => -0.0028079253, -0.0028079253),
   (r_E55_College_Ind_d > 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0192145311,
      (r_D30_Derog_Count_i > 1.5) => -0.0133811249,
      (r_D30_Derog_Count_i = NULL) => 0.0110656171, -0.0028079253),
   (r_E55_College_Ind_d = NULL) => -0.0011684276, -0.0011684276),
(r_C13_max_lres_d > 344.5) => 0.0275797559,
(r_C13_max_lres_d = NULL) => -0.0005718970, -0.0005718970);

// Tree: 74 
final_score_74 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 4.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 0.5) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0023739697,
      (r_E55_College_Ind_d > 0.5) => 
         map(
         (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 53.5) => 0.0001983089,
         (r_C13_Curr_Addr_LRes_d > 53.5) => 0.0368907411,
         (r_C13_Curr_Addr_LRes_d = NULL) => 0.0166503729, -0.0023739697),
      (r_E55_College_Ind_d = NULL) => -0.0003604660, -0.0003604660),
   (r_D31_attr_bankruptcy_recency_d > 0.5) => 0.0317208793,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0012925260, 0.0012925260),
(r_C14_addrs_15yr_i > 4.5) => -0.0085485212,
(r_C14_addrs_15yr_i = NULL) => -0.0019164685, -0.0019164685);

// Tree: 75 
final_score_75 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 84.9) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0198202591,
   (r_I60_inq_hiRiskCred_recency_d > 505.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 60.5) => 
         map(
         (NULL < r_F03_address_match_d and r_F03_address_match_d <= 2.5) => -0.0089164280,
         (r_F03_address_match_d > 2.5) => 0.0035422941,
         (r_F03_address_match_d = NULL) => -0.0018209972, -0.0018209972),
      (k_comb_age_d > 60.5) => 0.0063263975,
      (k_comb_age_d = NULL) => 0.0287976052, -0.0198202591),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0032452619, -0.0032452619),
(r_C12_source_profile_d > 84.9) => 0.0297310318,
(r_C12_source_profile_d = NULL) => -0.0025544177, -0.0025544177);

// Tree: 76 
final_score_76 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 139.6) => -0.0031080130,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 139.6) => -0.0277195988,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 68146.5) => -0.0163333874,
      (r_A46_Curr_AVM_AutoVal_d > 68146.5) => 0.0323904168,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0039635648,
         (r_E57_br_source_count_d > 0.5) => 0.0321069193,
         (r_E57_br_source_count_d = NULL) => 0.0060632885, -0.0163333874), 0.0071976011),
   (r_L79_adls_per_addr_c6_i > 0.5) => -0.0064103505,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0009001587, -0.0031080130), -0.0012318026);

// Tree: 77 
final_score_77 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 2.5) => -0.0067581299,
(r_F03_address_match_d > 2.5) => 
   map(
   (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -250) => 0.0246482464,
         (r_A49_Curr_AVM_Chg_1yr_i > -250) => 0.0009238665,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0100580077, 0.0094795999),
      (r_L79_adls_per_addr_curr_i > 5.5) => -0.0228510569,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0076331292, 0.0076331292),
   (r_C14_addrs_5yr_i > 4.5) => -0.0378887112,
   (r_C14_addrs_5yr_i = NULL) => 0.0059331435, -0.0067581299),
(r_F03_address_match_d = NULL) => 0.0005663887, 0.0005663887);

// Tree: 78 
final_score_78 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 320.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0205134657,
   (r_I60_inq_hiRiskCred_recency_d > 505.5) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 
         map(
         (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0013606580,
         (r_E55_College_Ind_d > 0.5) => 0.0117096979,
         (r_E55_College_Ind_d = NULL) => 0.0001563497, 0.0001563497),
      (r_C14_addrs_5yr_i > 4.5) => -0.0374330204,
      (r_C14_addrs_5yr_i = NULL) => -0.0009521597, -0.0205134657),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0039236496, -0.0039236496),
(r_C13_max_lres_d > 320.5) => 0.0288755089,
(r_C13_max_lres_d = NULL) => -0.0030467367, -0.0030467367);

// Tree: 79 
final_score_79 := map(
(NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 372.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 31456) => -0.0008265053,
   (r_A49_Curr_AVM_Chg_1yr_i > 31456) => -0.0258925171,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 89410.5) => -0.0267502460,
      (r_A46_Curr_AVM_AutoVal_d > 89410.5) => 0.0075073720,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => -0.0065637037,
         (r_C12_Num_NonDerogs_d > 2.5) => 0.0072268445,
         (r_C12_Num_NonDerogs_d = NULL) => -0.0021023663, -0.0267502460), -0.0008265053), -0.0036100573),
(r_C10_M_Hdr_FS_d > 372.5) => 0.0180761289,
(r_C10_M_Hdr_FS_d = NULL) => -0.0020440490, -0.0020440490);

// Tree: 80 
final_score_80 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 288182) => -0.0056827345,
(r_A46_Curr_AVM_AutoVal_d > 288182) => 0.0204773584,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < k_inf_contradictory_i and k_inf_contradictory_i <= 0.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0077016743,
         (r_S66_adlperssn_count_i > 1.5) => -0.0067723550,
         (r_S66_adlperssn_count_i = NULL) => 0.0012058418, 0.0012058418),
      (r_C12_Num_NonDerogs_d > 3.5) => 0.0200474813,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0027052639, 0.0027052639),
   (k_inf_contradictory_i > 0.5) => -0.0140630077,
   (k_inf_contradictory_i = NULL) => -0.0005061860, -0.0056827345), -0.0020201167);

// Tree: 81 
final_score_81 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 218436) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 74545) => -0.0134338408,
      (r_L80_Inp_AVM_AutoVal_d > 74545) => 0.0164861102,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0102631213, 0.0006859312),
   (r_S66_adlperssn_count_i > 1.5) => -0.0037732686,
   (r_S66_adlperssn_count_i = NULL) => -0.0013205931, -0.0013205931),
(r_A46_Curr_AVM_AutoVal_d > 218436) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 77.5) => 0.0006834541,
   (r_C13_max_lres_d > 77.5) => 0.0254722152,
   (r_C13_max_lres_d = NULL) => 0.0158654981, -0.0013205931),
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0019287326, -0.0006664644);

// Tree: 82 
final_score_82 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 2.5) => -0.0063307557,
(r_F03_address_match_d > 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 137.9) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 203025) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0216686787,
         (r_S66_adlperssn_count_i > 1.5) => -0.0055168567,
         (r_S66_adlperssn_count_i = NULL) => 0.0094374955, 0.0094374955),
      (r_L80_Inp_AVM_AutoVal_d > 203025) => 0.0120880079,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0099187440, 0.0099187440),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 137.9) => -0.0269255829,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0021657995, -0.0063307557),
(r_F03_address_match_d = NULL) => -0.0010707457, -0.0010707457);

// Tree: 83 
final_score_83 := map(
(NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 257515.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 95.95) => 0.0125291965,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 95.95) => -0.0056992903,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0068893149, -0.0026140107),
   (r_A46_Curr_AVM_AutoVal_d > 257515.5) => 0.0185640017,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 0.0015924745,
      (r_C12_Num_NonDerogs_d > 3.5) => 0.0254603358,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0039514303, -0.0026140107), 0.0014818812),
(r_L77_Apartment_i > 0.5) => -0.0128799319,
(r_L77_Apartment_i = NULL) => -0.0022560857, -0.0022560857);

// Tree: 84 
final_score_84 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 12.5) => -0.0355082252,
(r_C13_max_lres_d > 12.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 2.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
         map(
         (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 0.0188361771,
         (r_C14_addrs_10yr_i > 0.5) => 0.0027833541,
         (r_C14_addrs_10yr_i = NULL) => 0.0044718370, 0.0044718370),
      (r_S66_adlperssn_count_i > 1.5) => -0.0024425075,
      (r_S66_adlperssn_count_i = NULL) => 0.0013819529, 0.0013819529),
   (r_I60_inq_hiRiskCred_count12_i > 2.5) => -0.0372656142,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0003952400, -0.0355082252),
(r_C13_max_lres_d = NULL) => -0.0004287269, -0.0004287269);

// Tree: 85 
final_score_85 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => -0.0138780591,
   (r_D33_Eviction_Recency_d > 79.5) => 0.0012987864,
   (r_D33_Eviction_Recency_d = NULL) => -0.0007364862, -0.0007364862),
(r_E57_br_source_count_d > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 53.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0304921456,
      (r_D30_Derog_Count_i > 0.5) => -0.0089997062,
      (r_D30_Derog_Count_i = NULL) => 0.0119603705, 0.0119603705),
   (k_comb_age_d > 53.5) => 0.0384729687,
   (k_comb_age_d = NULL) => 0.0185885200, -0.0007364862),
(r_E57_br_source_count_d = NULL) => 0.0009025335, 0.0009025335);

// Tree: 86 
final_score_86 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -6859.5) => 0.0205251134,
(r_A49_Curr_AVM_Chg_1yr_i > -6859.5) => -0.0062148543,
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 
      map(
      (NULL < r_P88_Phn_Dst_to_Inp_Add_i and r_P88_Phn_Dst_to_Inp_Add_i <= 8.5) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 89.5) => -0.0011952455,
         (r_C13_max_lres_d > 89.5) => 0.0505864657,
         (r_C13_max_lres_d = NULL) => 0.0261835903, 0.0261835903),
      (r_P88_Phn_Dst_to_Inp_Add_i > 8.5) => 0.0033549857,
      (r_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0062511419, 0.0092649684),
   (r_L79_adls_per_addr_curr_i > 1.5) => -0.0037876529,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0020779323, 0.0205251134), 0.0009998740);

// Tree: 87 
final_score_87 := map(
(NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 65.5) => 0.0070514272,
      (k_comb_age_d > 65.5) => 0.0145974686,
      (k_comb_age_d = NULL) => 0.0073565871, 0.0073565871),
   (r_L79_adls_per_addr_curr_i > 4.5) => -0.0121430163,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0052274341, 0.0052274341),
(r_F03_input_add_not_most_rec_i > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 57.5) => -0.0104998087,
   (k_comb_age_d > 57.5) => 0.0124028322,
   (k_comb_age_d = NULL) => -0.0084084509, 0.0052274341),
(r_F03_input_add_not_most_rec_i = NULL) => -0.0003820587, -0.0003820587);

// Tree: 88 
final_score_88 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 0.0061172069,
   (r_E55_College_Ind_d > 0.5) => 0.0352919180,
   (r_E55_College_Ind_d = NULL) => 0.0087019839, 0.0087019839),
(r_C14_addrs_15yr_i > 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 96.15) => 0.0070716635,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 96.15) => -0.0112363278,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 2.5) => -0.0018446887,
      (r_wealth_index_d > 2.5) => 0.0153832663,
      (r_wealth_index_d = NULL) => -0.0001583381, 0.0070716635), 0.0087019839),
(r_C14_addrs_15yr_i = NULL) => 0.0005507240, 0.0005507240);

// Tree: 89 
final_score_89 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.0019333191,
(r_L79_adls_per_addr_c6_i > 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 123495.5) => -0.0157441383,
   (r_L80_Inp_AVM_AutoVal_d > 123495.5) => 
      map(
      (NULL < custom_adl_addr and custom_adl_addr <= 1.5) => -0.0096445769,
      (custom_adl_addr > 1.5) => 0.0251438402,
      (custom_adl_addr = NULL) => 0.0109422395, -0.0157441383),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 6.5) => -0.0061598757,
      (r_C14_addrs_10yr_i > 6.5) => -0.0447419235,
      (r_C14_addrs_10yr_i = NULL) => -0.0100484600, -0.0157441383), 0.0019333191),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0025566477, -0.0025566477);

// Tree: 90 
final_score_90 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0163704662,
   (r_I60_inq_hiRiskCred_recency_d > 505.5) => 0.0086684858,
   (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0049862870, 0.0049862870),
(r_L79_adls_per_addr_curr_i > 1.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 279439) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 370.5) => -0.0093595521,
      (r_C10_M_Hdr_FS_d > 370.5) => 0.0187323803,
      (r_C10_M_Hdr_FS_d = NULL) => -0.0072678222, -0.0072678222),
   (r_L80_Inp_AVM_AutoVal_d > 279439) => 0.0176966897,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0041125466, 0.0049862870),
(r_L79_adls_per_addr_curr_i = NULL) => -0.0006749292, -0.0006749292);

// Tree: 91 
final_score_91 := map(
(NULL < r_L77_Apartment_i and r_L77_Apartment_i <= 0.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0004978237,
   (k_nap_fname_verd_d > 0.5) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0184397503,
      (r_P85_Phn_Disconnected_i > 0.5) => -0.0059284076,
      (r_P85_Phn_Disconnected_i = NULL) => 0.0107211464, 0.0004978237),
   (k_nap_fname_verd_d = NULL) => 0.0022425968, 0.0022425968),
(r_L77_Apartment_i > 0.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0118439465,
   (r_E55_College_Ind_d > 0.5) => 0.0157797545,
   (r_E55_College_Ind_d = NULL) => -0.0080674344, 0.0022425968),
(r_L77_Apartment_i = NULL) => -0.0004377645, -0.0004377645);

// Tree: 92 
final_score_92 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 124.1001) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 376.5) => 
      map(
      (NULL < r_P85_Phn_Disconnected_i and r_P85_Phn_Disconnected_i <= 0.5) => 0.0051340122,
      (r_P85_Phn_Disconnected_i > 0.5) => -0.0278256737,
      (r_P85_Phn_Disconnected_i = NULL) => 0.0063533050, 0.0021309172),
   (r_C10_M_Hdr_FS_d > 376.5) => 0.0322250431,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0046512378, 0.0046512378),
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 124.1001) => -0.0183687665,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0015975926,
   (r_D30_Derog_Count_i > 1.5) => -0.0135170020,
   (r_D30_Derog_Count_i = NULL) => -0.0021459874, 0.0046512378), -0.0016693821);

// Tree: 93 
final_score_93 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => -0.0008535998,
      (r_C14_addrs_5yr_i > 4.5) => -0.0305293441,
      (r_C14_addrs_5yr_i = NULL) => -0.0017505996, -0.0017505996),
   (r_S66_adlperssn_count_i > 3.5) => -0.0218046665,
   (r_S66_adlperssn_count_i = NULL) => -0.0024551062, -0.0024551062),
(r_E57_br_source_count_d > 0.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 0.0215922928,
   (r_I60_Inq_Count12_i > 0.5) => -0.0097313113,
   (r_I60_Inq_Count12_i = NULL) => 0.0115658121, -0.0024551062),
(r_E57_br_source_count_d = NULL) => -0.0012577892, -0.0012577892);

// Tree: 94 
final_score_94 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0182979028,
   (r_I60_inq_hiRiskCred_recency_d > 9) => 
      map(
      (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 4.5) => 
         map(
         (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0063308762,
         (r_F03_input_add_not_most_rec_i > 0.5) => -0.0021151194,
         (r_F03_input_add_not_most_rec_i = NULL) => 0.0027630466, 0.0027630466),
      (r_C14_addrs_5yr_i > 4.5) => -0.0285729271,
      (r_C14_addrs_5yr_i = NULL) => 0.0018202206, -0.0182979028),
   (r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0002761288, 0.0053811248), 
(NULL < (integer)r_D31_bk_chapter_n and (integer)r_D31_bk_chapter_n <= 10) => 0.0053811248,
((integer)r_D31_bk_chapter_n > 10) => -0.0319311244,

	 -0.0009199343);

// Final Score Sum 

   final_score := sum(
      final_score_0, final_score_1, final_score_2, final_score_3, final_score_4, 
      final_score_5, final_score_6, final_score_7, final_score_8, final_score_9, 
      final_score_10, final_score_11, final_score_12, final_score_13, final_score_14, 
      final_score_15, final_score_16, final_score_17, final_score_18, final_score_19, 
      final_score_20, final_score_21, final_score_22, final_score_23, final_score_24, 
      final_score_25, final_score_26, final_score_27, final_score_28, final_score_29, 
      final_score_30, final_score_31, final_score_32, final_score_33, final_score_34, 
      final_score_35, final_score_36, final_score_37, final_score_38, final_score_39, 
      final_score_40, final_score_41, final_score_42, final_score_43, final_score_44, 
      final_score_45, final_score_46, final_score_47, final_score_48, final_score_49, 
      final_score_50, final_score_51, final_score_52, final_score_53, final_score_54, 
      final_score_55, final_score_56, final_score_57, final_score_58, final_score_59, 
      final_score_60, final_score_61, final_score_62, final_score_63, final_score_64, 
      final_score_65, final_score_66, final_score_67, final_score_68, final_score_69, 
      final_score_70, final_score_71, final_score_72, final_score_73, final_score_74, 
      final_score_75, final_score_76, final_score_77, final_score_78, final_score_79, 
      final_score_80, final_score_81, final_score_82, final_score_83, final_score_84, 
      final_score_85, final_score_86, final_score_87, final_score_88, final_score_89, 
      final_score_90, final_score_91, final_score_92, final_score_93, final_score_94); 


iv_rv5_deceased := rc_decsflag = '1' 
                or rc_ssndod != 0 
								or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 
								or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

pbr := 0.1842;

sbr := 0.1813;

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 700;

pts := 58;

lgt := ln(0.1842 / 0.8158);

rvc1609_1_0 := map(
    iv_rv5_deceased         => 200,
    iv_rv5_unscorable = '1' => 222,
              round(max((real)501, min(900, if(base + pts * (final_score - offset - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - offset - lgt) / ln(2))))));


rcvalued32 := if(r_d32_criminal_count_i > 0, 22, NULL);

rcvalued33 := if((r_d33_eviction_recency_d in [3, 6, 12, 24, 36, 60, 99]), 21, NULL);

rcvaluei60 := if(r_i60_inq_hiriskcred_count12_i > 0 or r_i60_inq_comm_count12_i > 0 or r_i60_inq_count12_i > 0, 20, NULL);

rcvaluel77 := if(r_l77_apartment_i = 1, 19, NULL);

rcvaluec14 := if(r_c14_addrs_10yr_i > 3 or r_c14_addrs_15yr_i > 4 or r_c14_addrs_5yr_i > 3, 18, NULL);

rcvalued30 := if(r_d30_derog_count_i > 0, 17, NULL);

rcvaluel79 := if(r_l79_adls_per_addr_curr_i > 5 or r_l79_adls_per_addr_c6_i > 0, 16, NULL);

rcvaluec20 := if(r_c21_m_bureau_adl_fs_d <= 192, 15, NULL);

rcvaluea44 := if((r_a44_curr_add_naprop_d in [0, 1, 2]), 14, NULL);

rcvaluec10 := if(r_c10_m_hdr_fs_d <= 192, 13, NULL);

rcvaluea41 := if(r_a41_prop_owner_d = 0 or r_a41_prop_owner_inp_only_d = 0, 12, NULL);

rcvaluef03 := if(r_f03_input_add_not_most_rec_i = 1, 11, NULL);

rcvaluef00 := if(r_f00_input_dob_match_level_d <= 6, 10, NULL);

rcvaluec13 := if(r_c13_max_lres_d <= 96 or r_c13_curr_addr_lres_d <= 48, 9, NULL);

rcvaluea46 := if(r_a46_curr_avm_autoval_d < 100001, 8, NULL);

rcvaluel80 := if((real)r_l80_inp_avm_autoval_d < 125001, 7, NULL);

rcvaluec12 := if(r_c12_num_nonderogs_d <= 3, 6, NULL);

rcvaluep85 := if(r_p85_phn_disconnected_i = 1, 5, NULL);

rcvalues66 := if(r_s66_adlperssn_count_i > 1, 4, NULL);

rcvaluee55 := if(r_e55_college_ind_d = 0, 3, NULL);

rcvaluee57 := if(r_e57_br_source_count_d = 0 or r_e57_prof_license_flag_d = 0, 2, NULL);

rcvaluep88 := if(r_p88_phn_dst_to_inp_add_i > 10, 1, NULL);

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

 
//*************************************************************************************//
rc_dataset_t := DATASET([
    {'A41', RCValueA41},
    {'A44', RCValueA44},
    {'A46', RCValueA46},
    {'C10', RCValueC10},
    {'C12', RCValueC12},
    {'C13', RCValueC13},
    {'C14', RCValueC14},
    {'C20', RCValueC20},
    {'D30', RCValueD30},
    {'D32', RCValueD32},
    {'D33', RCValueD33},
    {'E55', RCValueE55},
    {'E57', RCValueE57},
    {'F00', RCValueF00},
    {'F03', RCValueF03},
    {'I60', RCValueI60},
    {'L77', RCValueL77},
    {'L79', RCValueL79},
    {'L80', RCValueL80},
    {'P85', RCValueP85},
    {'P88', RCValueP88},
    {'S66', RCValueS66}
    ], ds_layout) (value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue > 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_t_sorted := sort(rc_dataset_t, -rc_dataset_t.value);

rc1_2 := rc_dataset_t_sorted[1].rc;
rc2_1 := rc_dataset_t_sorted[2].rc;
rc3_1 := rc_dataset_t_sorted[3].rc;
rc4_1 := rc_dataset_t_sorted[4].rc;
rc5_2 := '';

rc1v := rc_dataset_t_sorted[1].value;
rc2v := rc_dataset_t_sorted[2].value;
rc3v := rc_dataset_t_sorted[3].value;
rc4v := rc_dataset_t_sorted[4].value;
//*************************************************************************************//


_rc_inq := map(
    r_i60_inq_count12_i > 0            => 'I60',
    r_i60_inq_count12_i > 0            => 'I60',
    r_i60_inq_hiriskcred_count12_i > 0 => 'I60',
        '   ');

rc5_c455 := if(_rc_inq = 'I60', 'I60', ' ');

rc5_1 := if(not((rc1_2 in ['I60'])) and not((rc2_1 in ['I60'])) and not((rc3_1 in ['I60'])) and not((rc4_1 in ['I60'])), rc5_c455, rc5_2);

rc1_1 := if(rc1_2 = ' ', 'C12', rc1_2);

rc1 := if((rvc1609_1_0 in [200, 222, 900]), '', rc1_1);

rc3 := if((rvc1609_1_0 in [200, 222, 900]), '', rc3_1);

rc2 := if((rvc1609_1_0 in [200, 222, 900]), '', rc2_1);

rc4 := if((rvc1609_1_0 in [200, 222, 900]), '', rc4_1);

rc5 := if((rvc1609_1_0 in [200, 222, 900]), '', rc5_1);



//*************************************************************************************//
//     RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVC1609_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVC1609_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVC1609_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
   self.sysdate         								 := sysdate;
	 self.seq 														 := le.seq;
  
	 self.adl_addr 											   := adl_addr;
   self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
   self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
   self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
   self.r_a41_prop_owner_d               := r_a41_prop_owner_d;
   self.k_estimated_income_d             := k_estimated_income_d;
   self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
   self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
   self._in_dob        									 := _in_dob;
   self.yr_in_dob      									 := yr_in_dob;
   self.yr_in_dob_int  									 := yr_in_dob_int;
   self.k_comb_age_d    								 := k_comb_age_d;
   self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
   self.r_c12_num_nonderogs_d            := r_c12_num_nonderogs_d;
   self.r_prop_owner_history_d           := r_prop_owner_history_d;
   self.r_e55_college_ind_d              := r_e55_college_ind_d;
   self.r_d30_derog_count_i              := r_d30_derog_count_i;
   self.k_nap_fname_verd_d               := k_nap_fname_verd_d;
   self._header_first_seen               := _header_first_seen;
   self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
   self._criminal_last_date              := _criminal_last_date;
   self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
   self.r_i60_inq_hiriskcred_count12_i   := r_i60_inq_hiriskcred_count12_i;
   self.r_c12_source_profile_d           := r_c12_source_profile_d;
   self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
   self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
   self.r_a41_prop_owner_inp_only_d      := r_a41_prop_owner_inp_only_d;
   self.r_c13_max_lres_d                 := r_c13_max_lres_d;
   self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
   self.custom_adl_addr                  := custom_adl_addr;
   self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
   self.r_f03_address_match_d            := r_f03_address_match_d;
   self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
   self.r_wealth_index_d                 := r_wealth_index_d;
   self.r_s66_adlperssn_count_i          := r_s66_adlperssn_count_i;
   self.r_f03_input_add_not_most_rec_i   := r_f03_input_add_not_most_rec_i;
   self.r_ever_asset_owner_d             := r_ever_asset_owner_d;
   self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
   self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
   self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
   self.r_d33_eviction_recency_d         := r_d33_eviction_recency_d;
   self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
   self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
   self.r_p85_phn_disconnected_i         := r_p85_phn_disconnected_i;
   self.r_i60_inq_comm_count12_i         := r_i60_inq_comm_count12_i;
   self.r_l77_apartment_i                := r_l77_apartment_i;
   self.r_d31_attr_bankruptcy_recency_d  := r_d31_attr_bankruptcy_recency_d;
   self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
   self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
   self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
   self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
   self.k_nap_lname_verd_d               := k_nap_lname_verd_d;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
   self.r_d31_bk_disposed_hist_count_i   := r_d31_bk_disposed_hist_count_i;
   self.r_f00_dob_score_d                := r_f00_dob_score_d;
   self.r_e57_prof_license_flag_d        := r_e57_prof_license_flag_d;
   self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
   self.r_f00_input_dob_match_level_d    := r_f00_input_dob_match_level_d;
   self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
   self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
   self.k_inf_phn_verd_d                 := k_inf_phn_verd_d;
   self.k_nap_contradictory_i            := k_nap_contradictory_i;
   self.k_inf_contradictory_i            := k_inf_contradictory_i;
   self.final_score_0  									 := final_score_0;
   self.final_score_1   								 := final_score_1;
   self.final_score_2   								 := final_score_2;
   self.final_score_3   								 := final_score_3;
   self.final_score_4   								 := final_score_4;
   self.final_score_5   								 := final_score_5;
   self.final_score_6   								 := final_score_6;
   self.final_score_7  									 := final_score_7;
   self.final_score_8  									 := final_score_8;
   self.final_score_9  									 := final_score_9;
   self.final_score_10                   := final_score_10;
   self.final_score_11                   := final_score_11;
   self.final_score_12                   := final_score_12;
   self.final_score_13                   := final_score_13;
   self.final_score_14                   := final_score_14;
   self.final_score_15                   := final_score_15;
   self.final_score_16                   := final_score_16;
   self.final_score_17                   := final_score_17;
   self.final_score_18                   := final_score_18;
   self.final_score_19                   := final_score_19;
   self.final_score_20                   := final_score_20;
   self.final_score_21                   := final_score_21;
   self.final_score_22                   := final_score_22;
   self.final_score_23                   := final_score_23;
   self.final_score_24                   := final_score_24;
   self.final_score_25                   := final_score_25;
   self.final_score_26                   := final_score_26;
   self.final_score_27                   := final_score_27;
   self.final_score_28                   := final_score_28;
   self.final_score_29                   := final_score_29;
   self.final_score_30                   := final_score_30;
   self.final_score_31                   := final_score_31;
   self.final_score_32                   := final_score_32;
   self.final_score_33                   := final_score_33;
   self.final_score_34                   := final_score_34;
   self.final_score_35                   := final_score_35;
   self.final_score_36                   := final_score_36;
   self.final_score_37                   := final_score_37;
   self.final_score_38                   := final_score_38;
   self.final_score_39                   := final_score_39;
   self.final_score_40                   := final_score_40;
   self.final_score_41                   := final_score_41;
   self.final_score_42                   := final_score_42;
   self.final_score_43                   := final_score_43;
   self.final_score_44                   := final_score_44;
   self.final_score_45                   := final_score_45;
   self.final_score_46                   := final_score_46;
   self.final_score_47                   := final_score_47;
   self.final_score_48                   := final_score_48;
   self.final_score_49                   := final_score_49;
   self.final_score_50                   := final_score_50;
   self.final_score_51                   := final_score_51;
   self.final_score_52                   := final_score_52;
   self.final_score_53                   := final_score_53;
   self.final_score_54                   := final_score_54;
   self.final_score_55                   := final_score_55;
   self.final_score_56                   := final_score_56;
   self.final_score_57                   := final_score_57;
   self.final_score_58                   := final_score_58;
   self.final_score_59                   := final_score_59;
   self.final_score_60                   := final_score_60;
   self.final_score_61                   := final_score_61;
   self.final_score_62                   := final_score_62;
   self.final_score_63                   := final_score_63;
   self.final_score_64                   := final_score_64;
   self.final_score_65                   := final_score_65;
   self.final_score_66                   := final_score_66;
   self.final_score_67                   := final_score_67;
   self.final_score_68                   := final_score_68;
   self.final_score_69                   := final_score_69;
   self.final_score_70                   := final_score_70;
   self.final_score_71                   := final_score_71;
   self.final_score_72                   := final_score_72;
   self.final_score_73                   := final_score_73;
   self.final_score_74                   := final_score_74;
   self.final_score_75                   := final_score_75;
   self.final_score_76                   := final_score_76;
   self.final_score_77                   := final_score_77;
   self.final_score_78                   := final_score_78;
   self.final_score_79                   := final_score_79;
   self.final_score_80                   := final_score_80;
   self.final_score_81                   := final_score_81;
   self.final_score_82                   := final_score_82;
   self.final_score_83                   := final_score_83;
   self.final_score_84                   := final_score_84;
   self.final_score_85                   := final_score_85;
   self.final_score_86                   := final_score_86;
   self.final_score_87                   := final_score_87;
   self.final_score_88                   := final_score_88;
   self.final_score_89                   := final_score_89;
   self.final_score_90                   := final_score_90;
   self.final_score_91                   := final_score_91;
   self.final_score_92                   := final_score_92;
   self.final_score_93                   := final_score_93;
   self.final_score_94                   := final_score_94;
   self.final_score                      := final_score;
   self.iv_rv5_deceased                  := iv_rv5_deceased;
   self.iv_rv5_unscorable                := iv_rv5_unscorable;
   self.pbr             := pbr;
   self.sbr             := sbr;
   self.offset          := offset;
   self.base            := base;
   self.pts             := pts;
   self.lgt             := lgt;
   self.rvc1609_1_0     := rvc1609_1_0;
   self.rc1v            := rc1v;
   self.rc2v            := rc2v;
   self.rc3v            := rc3v;
   self.rc4v            := rc4v;
   self._rc_inq         := _rc_inq;
   self.rc3             := rc3;
   self.rc4             := rc4;
   self.rc2             := rc2;
   self.rc1             := rc1;
   self.rc5             := rc5;


		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvc1609_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));
	

	RETURN(model);
END;



