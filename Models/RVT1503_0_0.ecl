/*2016-04-05T22:35:08Z (laure fischer)
fixed the reason code S69 to S65
*/

IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, std, riskview;

EXPORT RVT1503_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			STRING15 model_name; 
			unsigned4 seq;
			BOOLEAN truedid;
			STRING out_z5;
			STRING out_addr_status;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING nap_status;
			INTEGER rc_ssndod;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING rc_hriskaddrflag;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_addrvalflag;
			STRING rc_addrcommflag;
			STRING rc_hrisksic;
			STRING rc_hrisksicphone;
			STRING rc_phonetype;
			STRING rc_ziptypeflag;
			INTEGER combo_ssnscore;
			INTEGER combo_dobscore;
			DECIMAL4_1 hdr_source_profile;
			STRING ver_sources;
			STRING ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;
			INTEGER add_input_address_score;
			BOOLEAN add_input_isbestmatch;
			INTEGER add_input_occ_index;
			STRING add_input_advo_vacancy;
			STRING add_input_advo_res_or_bus;
			INTEGER add_input_avm_auto_val;
			INTEGER add_input_naprop;
			BOOLEAN add_input_pop;
			INTEGER property_owned_total;
			BOOLEAN add_curr_isbestmatch;
			INTEGER add_curr_occ_index;
			INTEGER add_curr_avm_auto_val;
			INTEGER add_curr_naprop;
			BOOLEAN add_curr_pop;
			INTEGER add_prev_naprop;
			INTEGER addrs_5yr;
			INTEGER addrs_10yr;
			INTEGER addrs_15yr;
			STRING telcordia_type;
			INTEGER header_first_seen;
			INTEGER ssns_per_adl;
			INTEGER addrs_per_adl;
			INTEGER adls_per_ssn;
			INTEGER adls_per_addr_curr;
			INTEGER ssns_per_addr_curr;
			INTEGER invalid_ssns_per_adl;
			INTEGER invalid_addrs_per_adl;
			INTEGER inq_count12;
			INTEGER inq_highriskcredit_count12;
			STRING pb_average_dollars;
			INTEGER br_source_count;
			INTEGER infutor_nap;
			INTEGER stl_inq_count12;
			INTEGER attr_addrs_last30;
			INTEGER attr_addrs_last90;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_total_number_derogs;
			INTEGER attr_eviction_count;
			INTEGER attr_eviction_count90;
			INTEGER attr_eviction_count180;
			INTEGER attr_eviction_count12;
			INTEGER attr_eviction_count24;
			INTEGER attr_eviction_count36;
			INTEGER attr_eviction_count60;
			INTEGER attr_num_nonderogs;
			INTEGER attr_num_nonderogs90;
			INTEGER attr_num_nonderogs180;
			INTEGER attr_num_nonderogs12;
			INTEGER attr_num_nonderogs24;
			INTEGER attr_num_nonderogs36;
			INTEGER attr_num_nonderogs60;
			INTEGER bk_dismissed_recent_count;
			INTEGER bk_dismissed_historical_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_recent_released_count;
			INTEGER liens_historical_released_count;
			INTEGER liens_unrel_cj_ct;
			INTEGER liens_rel_cj_ct;
			INTEGER liens_unrel_ft_ct;
			INTEGER liens_rel_ft_ct;
			INTEGER liens_unrel_fc_ct;
			INTEGER liens_rel_fc_ct;
			INTEGER liens_unrel_lt_ct;
			INTEGER liens_rel_lt_ct;
			INTEGER liens_unrel_o_ct;
			INTEGER liens_rel_o_ct;
			INTEGER liens_unrel_ot_ct;
			INTEGER liens_rel_ot_ct;
			INTEGER liens_unrel_sc_ct;
			INTEGER liens_rel_sc_ct;
			INTEGER liens_unrel_st_ct;
			INTEGER liens_rel_st_ct;
			INTEGER criminal_count;
			INTEGER criminal_last_date;
			INTEGER felony_count;
			STRING college_file_type;
			BOOLEAN college_attendance;
			BOOLEAN prof_license_flag;
			STRING input_dob_match_level;

			/* Model Intermediate Variables */
			INTEGER num_dob_match_level;
			INTEGER nas_summary_ver;
			INTEGER nap_summary_ver;
			INTEGER infutor_nap_ver;
			INTEGER dob_ver;
			INTEGER sufficiently_verified;
			STRING add_ec1;
			INTEGER addr_validation_problem;
			INTEGER phn_validation_problem;
			INTEGER validation_problem;
			INTEGER tot_liens;
			INTEGER tot_liens_w_type;
			integer has_derog;
			STRING18 rv_4seg_riskview_5_0;
			BOOLEAN verprob_seg;
			BOOLEAN derog_seg;
			BOOLEAN owner_seg;
			BOOLEAN other_seg;
			INTEGER sysdate;
			STRING iv_rv5_unscorable;
			STRING rv_f00_addr_not_ver_w_ssn;
			STRING rv_p85_phn_disconnected;
			INTEGER rv_f00_ssn_score;
			INTEGER rv_f00_dob_score;
			INTEGER rv_f01_inp_addr_address_score;
			STRING rv_f00_input_dob_match_level;
			INTEGER rv_d30_derog_count;
			STRING iv_d34_liens_unrel_x_rel;
			INTEGER rv_d32_felony_count;
			STRING rv_d32_criminal_x_felony;
			INTEGER _criminal_last_date;
			INTEGER rv_d32_mos_since_crim_ls;
			INTEGER rv_c21_stl_inq_count12;
			STRING rv_d33_eviction_recency;
			INTEGER rv_c12_num_nonderogs;
			INTEGER _header_first_seen;
			INTEGER rv_c10_m_hdr_fs;
			INTEGER rv_c12_nonderog_recency;
			DECIMAL21_1 rv_c12_source_profile;
			INTEGER rv_s66_adlperssn_count;
			STRING26 rv_f03_address_match;
			INTEGER rv_a44_curr_add_naprop;
			INTEGER rv_l80_inp_avm_autoval;
			INTEGER rv_a46_curr_avm_autoval;
			INTEGER rv_c22_inp_addr_occ_index;
			INTEGER rv_f04_curr_add_occ_index;
			INTEGER rv_c14_addrs_5yr;
			STRING rv_a41_prop_owner;
			STRING rv_e55_college_ind;
			INTEGER rv_e57_prof_license_br_flag;
			INTEGER rv_i60_inq_count12;
			INTEGER rv_i60_inq_hiriskcred_count12;
			INTEGER rv_c18_invalid_addrs_per_adl;
			INTEGER rv_c13_attr_addrs_recency;
			INTEGER rv_a50_pb_average_dollars;
			REAL v_subscore0;
			REAL v_subscore1;
			REAL v_subscore2;
			REAL v_subscore3;
			REAL v_subscore4;
			REAL v_subscore5;
			REAL v_subscore6;
			REAL v_subscore7;
			REAL v_subscore8;
			REAL v_subscore9;
			REAL v_subscore10;
			REAL v_subscore11;
			REAL v_subscore12;
			REAL v_subscore13;
			REAL v_subscore14;
			REAL v_subscore15;
			REAL v_subscore16;
			REAL v_subscore17;
			REAL v_subscore18;
			REAL v_subscore19;
			REAL v_rawscore;
			REAL v_lnoddsscore;
			REAL v_probscore;
			STRING v_aacd_0;
			REAL v_dist_0;
			STRING v_aacd_1;
			REAL v_dist_1;
			STRING v_aacd_2;
			REAL v_dist_2_1;
			STRING v_aacd_3_1;
			REAL v_dist_3_1;
			REAL v_dist_3;
			STRING v_aacd_3;
			REAL v_dist_2;
			STRING v_aacd_4;
			REAL v_dist_4;
			STRING v_aacd_5;
			REAL v_dist_5;
			STRING v_aacd_6;
			REAL v_dist_6_1;
			STRING v_aacd_7;
			REAL v_dist_7;
			STRING v_aacd_8;
			REAL v_dist_8;
			STRING v_aacd_9;
			REAL v_dist_9;
			STRING v_aacd_10;
			REAL v_dist_10;
			STRING v_aacd_11;
			REAL v_dist_11_1;
			REAL v_dist_6;
			REAL v_dist_11;
			STRING v_aacd_12;
			REAL v_dist_12;
			STRING v_aacd_13;
			REAL v_dist_13;
			STRING v_aacd_14;
			REAL v_dist_14;
			STRING v_aacd_15;
			REAL v_dist_15;
			STRING v_aacd_16;
			REAL v_dist_16;
			STRING v_aacd_17;
			REAL v_dist_17;
			STRING v_aacd_18;
			REAL v_dist_18;
			STRING v_aacd_19;
			REAL v_dist_19;
			REAL d_subscore0;
			REAL d_subscore1;
			REAL d_subscore2;
			REAL d_subscore3;
			REAL d_subscore4;
			REAL d_subscore5;
			REAL d_subscore6;
			REAL d_subscore7;
			REAL d_subscore8;
			REAL d_subscore9;
			REAL d_subscore10;
			REAL d_subscore11;
			REAL d_subscore12;
			REAL d_subscore13;
			REAL d_subscore14;
			REAL d_subscore15;
			REAL d_subscore16;
			REAL d_subscore17;
			REAL d_subscore18;
			REAL d_subscore19;
			REAL d_subscore20;
			REAL d_subscore21;
			REAL d_rawscore;
			REAL d_lnoddsscore;
			REAL d_probscore;
			STRING d_aacd_0;
			REAL d_dist_0;
			STRING d_aacd_1;
			REAL d_dist_1;
			STRING d_aacd_2;
			REAL d_dist_2;
			STRING d_aacd_3;
			REAL d_dist_3;
			STRING d_aacd_4;
			REAL d_dist_4;
			STRING d_aacd_5_1;
			REAL d_dist_5_1;
			STRING d_aacd_6;
			REAL d_dist_6;
			STRING d_aacd_7;
			REAL d_dist_7_1;
			REAL d_dist_7;
			REAL d_dist_5;
			STRING d_aacd_5;
			STRING d_aacd_8;
			REAL d_dist_8;
			STRING d_aacd_9;
			REAL d_dist_9;
			STRING d_aacd_10;
			REAL d_dist_10;
			STRING d_aacd_11;
			REAL d_dist_11;
			STRING d_aacd_12;
			REAL d_dist_12;
			STRING d_aacd_13;
			REAL d_dist_13;
			STRING d_aacd_14;
			REAL d_dist_14;
			STRING d_aacd_15;
			REAL d_dist_15;
			STRING d_aacd_16;
			REAL d_dist_16;
			STRING d_aacd_17;
			REAL d_dist_17;
			STRING d_aacd_18;
			REAL d_dist_18;
			STRING d_aacd_19;
			REAL d_dist_19;
			STRING d_aacd_20;
			REAL d_dist_20;
			STRING d_aacd_21;
			REAL d_dist_21;
			REAL p_subscore0;
			REAL p_subscore1;
			REAL p_subscore2;
			REAL p_subscore3;
			REAL p_subscore4;
			REAL p_subscore5;
			REAL p_subscore6;
			REAL p_subscore7;
			REAL p_subscore8;
			REAL p_subscore9;
			REAL p_subscore10;
			REAL p_subscore11;
			REAL p_rawscore;
			REAL p_lnoddsscore;
			REAL p_probscore;
			STRING p_aacd_0;
			REAL p_dist_0;
			STRING p_aacd_1;
			REAL p_dist_1;
			STRING p_aacd_2;
			REAL p_dist_2;
			STRING p_aacd_3;
			REAL p_dist_3;
			STRING p_aacd_4;
			REAL p_dist_4;
			STRING p_aacd_5;
			REAL p_dist_5;
			STRING p_aacd_6_1;
			REAL p_dist_6_1;
			STRING p_aacd_7;
			REAL p_dist_7_1;
			REAL p_dist_6;
			STRING p_aacd_6;
			REAL p_dist_7;
			STRING p_aacd_8;
			REAL p_dist_8;
			STRING p_aacd_9;
			REAL p_dist_9;
			STRING p_aacd_10;
			REAL p_dist_10;
			STRING p_aacd_11;
			REAL p_dist_11;
			REAL o_subscore0;
			REAL o_subscore1;
			REAL o_subscore2;
			REAL o_subscore3;
			REAL o_subscore4;
			REAL o_subscore5;
			REAL o_subscore6;
			REAL o_subscore7;
			REAL o_subscore8;
			REAL o_subscore9;
			REAL o_subscore10;
			REAL o_subscore11;
			REAL o_subscore12;
			REAL o_subscore13;
			REAL o_subscore14;
			REAL o_subscore15;
			REAL o_subscore16;
			REAL o_subscore17;
			REAL o_subscore18;
			REAL o_subscore19;
			REAL o_rawscore;
			REAL o_lnoddsscore;
			REAL o_probscore;
			STRING o_aacd_0;
			REAL o_dist_0;
			STRING o_aacd_1;
			REAL o_dist_1;
			STRING o_aacd_2;
			REAL o_dist_2;
			STRING o_aacd_3;
			REAL o_dist_3_1;
			STRING o_aacd_4_1;
			REAL o_dist_4_1;
			STRING o_aacd_4;
			REAL o_dist_4;
			REAL o_dist_3;
			STRING o_aacd_5;
			REAL o_dist_5;
			STRING o_aacd_6;
			REAL o_dist_6;
			STRING o_aacd_7;
			REAL o_dist_7;
			STRING o_aacd_8;
			REAL o_dist_8;
			STRING o_aacd_9;
			REAL o_dist_9;
			STRING o_aacd_10;
			REAL o_dist_10;
			STRING o_aacd_11;
			REAL o_dist_11;
			STRING o_aacd_12;
			REAL o_dist_12;
			STRING o_aacd_13;
			REAL o_dist_13;
			STRING o_aacd_14;
			REAL o_dist_14;
			STRING o_aacd_15;
			REAL o_dist_15;
			STRING o_aacd_16;
			REAL o_dist_16;
			STRING o_aacd_17;
			REAL o_dist_17;
			STRING o_aacd_18;
			REAL o_dist_18;
			STRING o_aacd_19;
			REAL o_dist_19;
			INTEGER base;
			INTEGER points;
			INTEGER odds;
			REAL lnoddsscore;
			INTEGER score_lnodds;
			INTEGER score_lnodds_capped;
			BOOLEAN ov_ssnprior;
			BOOLEAN ov_corrections;
			INTEGER deceased;
			INTEGER _ov_pts_lost_c200_b3;
			REAL _ov_pts_lost_raw;
			
	// the score that is returned
			INTEGER rvt1503_0_1;
			
			STRING _rc_seg_c203;
			STRING _rc_seg_c204;
			STRING _rc_seg_c202;
			STRING _rc_seg_c205;
			STRING _rc_seg;
			REAL v_dist_20;
			STRING v_aacd_20;
			REAL v_rcvaluec22;
			REAL v_rcvaluec21;
			REAL v_rcvaluel80;
			REAL v_rcvaluea50;
			REAL v_rcvaluei60;
			REAL v_rcvalueS65;
			REAL v_rcvaluep85;
			REAL v_rcvalued30;
			REAL v_rcvaluea47;
			REAL v_rcvaluea44;
			REAL v_rcvaluef04;
			REAL v_rcvaluef01;
			REAL v_rcvaluef00;
			REAL v_rcvaluea41;
			REAL v_rcvaluee55;
			REAL v_rcvaluec12;
			REAL v_rcvaluee57;
			REAL v_rcvalues66;
			REAL v_rcvaluel73;
			REAL d_dist_22;
			STRING d_aacd_22;
			REAL d_rcvaluec13;
			REAL d_rcvaluec21;
			REAL d_rcvaluel80;
			REAL d_rcvaluel73;
			REAL d_rcvalueS65;
			REAL d_rcvaluep85;
			REAL d_rcvalued30;
			REAL d_rcvaluea50;
			REAL d_rcvaluea44;
			REAL d_rcvaluei60;
			REAL d_rcvaluef00;
			REAL d_rcvaluef03;
			REAL d_rcvaluea41;
			REAL d_rcvaluee55;
			REAL d_rcvaluec12;
			REAL d_rcvaluea47;
			REAL d_rcvalues66;
			REAL d_rcvaluee57;
			REAL p_dist_12;
			STRING p_aacd_12;
			REAL p_rcvaluec13;
			REAL p_rcvaluel80;
			REAL p_rcvaluea50;
			REAL p_rcvaluei60;
			REAL p_rcvaluee55;
			REAL p_rcvalueS65;
			REAL p_rcvalued30;
			REAL p_rcvaluea47;
			REAL p_rcvaluea44;
			REAL p_rcvaluef01;
			REAL p_rcvaluel73;
			REAL p_rcvalues66;
			REAL p_rcvaluec12;
			REAL o_dist_20;
			STRING o_aacd_20;
			REAL o_rcvaluec13;
			REAL o_rcvaluel80;
			REAL o_rcvaluel73;
			REAL o_rcvalued34;
			REAL o_rcvaluea41;
			REAL o_rcvaluea50;
			REAL o_rcvaluea44;
			REAL o_rcvaluec18;
			REAL o_rcvaluef01;
			REAL o_rcvaluef00;
			REAL o_rcvaluef03;
			REAL o_rcvaluec12;
			REAL o_rcvaluee55;
			REAL o_rcvaluei60;
			REAL o_rcvaluea47;
			REAL o_rcvaluec10;
			REAL o_rcvalues66;
			REAL o_rcvaluee57;
			REAL o_rcvalueS65;
			REAL o_rcvaluec14;
			 
			STRING p_rc1;
			STRING p_rc2;
			STRING p_rc3;
			STRING p_rc4;
			REAL p_vl1;
			REAL p_vl2;
			REAL p_vl3;
			REAL p_vl4;
		 
			STRING d_rc1;
			STRING d_rc2;
			STRING d_rc3;
			STRING d_rc4;
			REAL d_vl1;
			REAL d_vl2;
			REAL d_vl3;
			REAL d_vl4;
	 
			STRING o_rc1;
			STRING o_rc2;
			STRING o_rc3;
			STRING o_rc4;
			REAL o_vl1;
			REAL o_vl2;
			REAL o_vl3;
			REAL o_vl4;
			 
			STRING v_rc1;
			STRING v_rc2;
			STRING v_rc3;
			STRING v_rc4;
			REAL v_vl1;
			REAL v_vl2;
			REAL v_vl3;
			REAL v_vl4;
			STRING rc4_2;
			STRING rc3_2;
			STRING rc1_3;
			STRING rc2_2;
			STRING rc1_2;
			STRING _rc_inq;
			STRING rc5_c214;
			STRING rc5_1;
			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING  rc4;
			STRING4 rc5;
			Models.Layout_ModelOut; 
			Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	seq                              := le.seq;
	out_z5                           := le.shell_input.z5;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.ssn_verification.adlperssn_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count12                  := le.impulse.count12;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
	attr_num_nonderogs12             := le.source_verification.num_nonderogs12;
	attr_num_nonderogs24             := le.source_verification.num_nonderogs24;
	attr_num_nonderogs36             := le.source_verification.num_nonderogs36;
	attr_num_nonderogs60             := le.source_verification.num_nonderogs60;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	liens_recent_unreleased_count    := le.BJL.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.BJL.liens_historical_unreleased_count;
	liens_recent_released_count      := le.BJL.liens_recent_released_count;
	liens_historical_released_count  := le.BJL.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
	liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
	liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
	liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_rel_st_ct                  := le.liens.liens_released_suits.count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
//==============================================================
//=             Start populating/setting the                   =
//=             intermediate variables and risk indicators     =
//==============================================================

	NULL := -999999999;
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	
//====================================================================
//===   Determine if this consumer has been sufficiently verified   ===
//====================================================================	
	num_dob_match_level := (integer)input_dob_match_level;
	nas_summary_ver     := if((integer)ssnlength > 0 and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0);
	nap_summary_ver     := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);
	infutor_nap_ver     := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);
	dob_ver             := if(dobpop and num_dob_match_level >= 5, 1, 0);
	
	sufficiently_verified := map(
	    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
	    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
	    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
	                                                                                                                               0);

//====================================================================
//===   Determine if this consumer has any address problems        ===
//====================================================================		
	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];
	
	addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') 
	                              or rc_hriskaddrflag = '4' 
																or rc_addrcommflag = '2' 
																or (add_input_advo_res_or_bus in ['B', 'D']) 
																or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') 
																or add_input_advo_vacancy = 'Y', 1, 0);

//====================================================================
//===   Determine if this consumer has any phone problems          ===
//====================================================================	
	phn_validation_problem := if(rc_hphonetypeflag = 'A' 
	                             or rc_hriskphoneflag = '2' 
															 or rc_hphonetypeflag = '2' 
															 or (telcordia_type in ['02', '56', '61']) 
															 or rc_phonevalflag = '0' 
															 or rc_hphonevalflag = '0' 
															 or rc_phonetype = '5' 
															 or rc_hriskphoneflag = '6' 
															 or rc_hphonetypeflag = '5' 
															 or rc_hphonevalflag = '3' 
															 or rc_addrcommflag = '1', 1, 0);

//====================================================================
//===   Determine if this consumer has any validation problems     ===
//====================================================================	
	validation_problem := if(adls_per_ssn >= 5 
	                         or ssns_per_adl >= 4 
													 or invalid_ssns_per_adl >= 1 
													 or adls_per_addr_curr >= 8 
													 or ssns_per_addr_curr >= 7 
													 or rc_hrisksic = '2225' 
													 or rc_hrisksicphone = '2225' 
													 or (boolean)(integer)addr_validation_problem 
													 or (boolean)(integer)phn_validation_problem 
													 or rc_ssndobflag = '1' 
													 or rc_pwssndobflag = '1', 1, 0);
	
//====================================================================
//===   Determine if this consumer has any liens                   ===
//====================================================================		
	tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
							 sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), 
							 if(liens_recent_unreleased_count      = NULL, 0, liens_recent_unreleased_count), 
							 if(liens_recent_released_count        = NULL, 0, liens_recent_released_count), 
							 if(liens_historical_released_count    = NULL, 0, liens_historical_released_count)));
	
	tot_liens_w_type := if(max(liens_unrel_LT_ct, liens_rel_LT_ct, 
	                           liens_unrel_SC_ct, liens_rel_SC_ct, 
														 liens_unrel_CJ_ct, liens_rel_CJ_ct, 
														 liens_unrel_FT_ct, liens_rel_FT_ct,  
														 liens_unrel_OT_ct, liens_rel_OT_ct, 
														 liens_unrel_ST_ct, liens_rel_ST_ct, 
														 liens_unrel_FC_ct, liens_rel_FC_ct, 
														 liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, 
	                    sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), 
											    if(liens_rel_LT_ct       = NULL, 0, liens_rel_LT_ct), 
											    if(liens_unrel_SC_ct     = NULL, 0, liens_unrel_SC_ct),  
											    if(liens_rel_SC_ct       = NULL, 0, liens_rel_SC_ct), 
											    if(liens_unrel_CJ_ct     = NULL, 0, liens_unrel_CJ_ct), 
											    if(liens_rel_CJ_ct       = NULL, 0, liens_rel_CJ_ct), 
											    if(liens_unrel_FT_ct     = NULL, 0, liens_unrel_FT_ct), 
											    if(liens_rel_FT_ct       = NULL, 0, liens_rel_FT_ct), 
											    if(liens_unrel_OT_ct     = NULL, 0, liens_unrel_OT_ct), 
											    if(liens_rel_OT_ct       = NULL, 0, liens_rel_OT_ct), 
											    if(liens_unrel_ST_ct     = NULL, 0, liens_unrel_ST_ct), 
											    if(liens_rel_ST_ct       = NULL, 0, liens_rel_ST_ct), 
											    if(liens_unrel_FC_ct     = NULL, 0, liens_unrel_FC_ct), 
											    if(liens_rel_FC_ct       = NULL, 0, liens_rel_FC_ct), 
											    if(liens_unrel_O_ct      = NULL, 0, liens_unrel_O_ct), 
											    if(liens_rel_O_ct        = NULL, 0, liens_rel_O_ct)));

//========================================================
//===   Determine if this consumer has any derog       ===
//========================================================	
	has_derog := if(felony_count > 0 
	               or criminal_count > 0 
								 or stl_inq_count12 > 0 
								 or attr_eviction_count > 0 
								 or liens_unrel_CJ_ct > 0 
								 or liens_rel_CJ_ct > 0 
								 or liens_unrel_SC_ct > 0 
								 or liens_rel_SC_ct > 0 
								 or liens_unrel_FC_ct > 0 
								 or liens_rel_FC_ct > 0 
								 or liens_unrel_O_ct > 0 
								 or liens_rel_O_ct > 0 
								 or tot_liens - tot_liens_w_type > 0 
								 or bk_dismissed_recent_count > 0 
								 or bk_dismissed_historical_count > 0, 1, 0);

//========================================================
//===   Determine the segment this DID falls into      ===
//========================================================	
	rv_4seg_riskview_5_0 := map(
	    not truedid                                                             => '0 TRUEDID = 0     ',
	    not((boolean)sufficiently_verified)                                     => '1 VER/VAL PROBLEMS',
	    (boolean)sufficiently_verified and (boolean)(integer)validation_problem => '1 VER/VAL PROBLEMS',
	    (boolean)has_derog                                                      => '2 DEROG           ',
	    add_input_naprop = 4 or property_owned_total > 0                        => '3 OWNER           ',
	                                                                               '4 OTHER           ');
	
	verprob_seg := (rv_4seg_riskview_5_0[1] in ['0', '1']);
	derog_seg   := rv_4seg_riskview_5_0[1] = '2';
	owner_seg   := rv_4seg_riskview_5_0[1] = '3';
	other_seg   := rv_4seg_riskview_5_0[1] = '4';
	
//========================================================================================  
//===   for round 1 validation set the sysdate to the same value seen in the validation file 
//===    // sysdate := common.sas_date('20150501');
//===   for round 2 validation set the sysdate to the value from the history date from the input file
//========================================================================================  	
sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));
  	
	
//==============================================================
//=             Based on the information collected above       =
//=             Set the Risk View indicators for this          =
//=             consumer.  These are all of the components     =
//=             That go into the score for this model          =
//==============================================================		
	
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');
	
	rv_f00_addr_not_ver_w_ssn := if(not(truedid and (integer)ssnlength > 0), ' ', (String)(Integer)(nas_summary in [4, 7, 9]));
	
	rv_p85_phn_disconnected := map(
	    not(hphnpop)                                                                => ' ',
	    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D'  => '1',
	                                                                                   '0');
	
	rv_f00_ssn_score := if(not(truedid and (integer)ssnlength > 0), NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999));
	
	rv_f00_dob_score := if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));
	
	rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	rv_f00_input_dob_match_level := if(not(truedid and dobpop), ' ', input_dob_match_level);
	
	rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));
	
	iv_d34_liens_unrel_x_rel := if(not(truedid), '   ', 
	                 trim((string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL,     sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) 
									+ trim('-', LEFT, RIGHT) 
								 + trim((string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL,  sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count),     if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL,    sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count),     if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));
	
	
	rv_d32_felony_count := if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999));
	
	rv_d32_criminal_x_felony := if(not(truedid), '', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));
	
	_criminal_last_date := Common.SAS_Date((STRING)(criminal_last_date));
	
	rv_d32_mos_since_crim_ls := map(
	    not(truedid)               => NULL,
	    _criminal_last_date = NULL => -1,
	                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));
	
	rv_c21_stl_inq_count12 := if(not(truedid), NULL, min(if(STL_Inq_count12 = NULL, -NULL, STL_Inq_count12), 999));
	
	rv_d33_eviction_recency := map(
	    not(truedid)                                                         => '  ',
	    (boolean)attr_eviction_count90                                       => '03',
	    (boolean)attr_eviction_count180                                      => '06',
	    (boolean)attr_eviction_count12                                       => '12',
	    (boolean)attr_eviction_count24 and attr_eviction_count >= 2          => '24',
	    (boolean)attr_eviction_count24                                       => '25',
	    (boolean)attr_eviction_count36 and attr_eviction_count >= 2          => '36',
	    (boolean)attr_eviction_count36                                       => '37',
	    (boolean)attr_eviction_count60 and attr_eviction_count >= 2          => '60',
	    (boolean)attr_eviction_count60                                       => '61',
	    attr_eviction_count >= 2                                             => '98',
	    attr_eviction_count >= 1                                             => '99',
	                                                                            '00');
	
	rv_c12_num_nonderogs := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4));
	
	_header_first_seen := Common.SAS_Date((STRING)(header_first_seen));
	
	rv_c10_m_hdr_fs := map(
	    not(truedid)              => NULL,
	    _header_first_seen = NULL => -1,
	                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));
	
	rv_c12_nonderog_recency := map(
	    not(truedid)                     => NULL,
	    (boolean)attr_num_nonderogs90    => 3,
	    (boolean)attr_num_nonderogs180   => 6,
	    (boolean)attr_num_nonderogs12    => 12,
	    (boolean)attr_num_nonderogs24    => 24,
	    (boolean)attr_num_nonderogs36    => 36,
	    (boolean)attr_num_nonderogs60    => 60,
	    attr_num_nonderogs >= 1          => 99,
	                                        0);
	
	rv_c12_source_profile := if(not(truedid), NULL, hdr_source_profile);
	
	rv_s66_adlperssn_count := map(
	    not((integer)ssnlength > 0) => NULL,
	    adls_per_ssn = 0   => 1,
	                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));
	
	rv_f03_address_match := map(
	    not(truedid)                                => '                          ',
	    add_input_isbestmatch                       => '4 INPUT=CURR              ',
	    not(add_input_pop) and add_curr_isbestmatch => '3 CURRAVAIL + NOINPUTPOP  ',
	    add_input_pop and add_curr_isbestmatch      => '2 CURRAVAIL + INPUTNOTCURR',
	    add_curr_pop                                => '1 CURR ONHDRONLY          ',
	    add_input_pop                               => '0 INPUTPOP NOHISTAVAIL    ',
	                                                   '');
	
	rv_a44_curr_add_naprop := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);
	
	rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);
	
	rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	rv_c22_inp_addr_occ_index := if(not(add_input_pop and truedid), NULL, add_input_occ_index);
	
	rv_f04_curr_add_occ_index := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);
	
	rv_c14_addrs_5yr := map(
	    not(truedid)             => NULL,
	    not add_curr_pop         => -1,
	                               min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));
	
	rv_a41_prop_owner := map(
	    not(truedid)                                                                                   => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => '1',
	                                                                                                      '0');
	
	rv_e55_college_ind := map(
	    not(truedid)                           => ' ',
	    (college_file_type in ['H', 'C', 'A']) => '1',
	    college_attendance                     => '1',
	                                              '0');
	
//	rv_e57_prof_license_br_flag := if(not(truedid), NULL, if(max(integer)((integer)prof_license_flag, br_source_count) = NULL, NULL, sum((integer)prof_license_flag, if(br_source_count = NULL, 0, br_source_count))) > 0);
    rv_e57_prof_license_br_flag := if(not(truedid), NULL, (integer)(((integer)prof_license_flag + (integer)br_source_count) > 0));	
	
	
	rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));
	
	rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));
	
	rv_c18_invalid_addrs_per_adl := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));
	
	rv_c13_attr_addrs_recency := map(
	    not(truedid)      => NULL,
	    (boolean)attr_addrs_last30  => 1,
	    (boolean)attr_addrs_last90  => 3,
	    (boolean)attr_addrs_last12  => 12,
	    (boolean)attr_addrs_last24  => 24,
	    (boolean)attr_addrs_last36  => 36,
	    (boolean)addrs_5yr          => 60,
	    (boolean)addrs_10yr         => 120,
	    (boolean)addrs_15yr         => 180,
	    addrs_per_adl > 0           => 999,
	                                   0);
	
	rv_a50_pb_average_dollars := map(
	    not(truedid)              => NULL,
	    pb_average_dollars = ''   => -1,
	                                 // (integer)pb_average_dollars);
	                                 -1);  // reason code edit for iBehavior removal
																	 
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the verprob seqment                  =
//==============================================================

	
	v_subscore0 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.131672,
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => -0.318426,
	    2 <= rv_d30_derog_count AND rv_d30_derog_count < 3   => -0.469558,
	    3 <= rv_d30_derog_count                              => -0.569908,
	                                                            0);
	
	v_subscore1 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50  => -0.284335,
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100  => 0.01494,
	    100 <= rv_f01_inp_addr_address_score                                         => 0.196058,
	    not truedid                                                                  => 0,
	    not add_input_pop                                                            => 0.196058,
	                                                                                    0);
	
	v_subscore2 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0       => -0.099907,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 23608       => -0.479149,
	    23608 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 35461  => -0.24671,
	    35461 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 51492  => -0.163516,
	    51492 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 95840  => -0.001727,
	    95840 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 137402 => 0.087209,
	    137402 <= rv_a46_curr_avm_autoval                                     => 0.348024,
	                                                                             0);
	
	v_subscore3 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => -0.040452,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 42834        => -0.396506,
	    42834 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 93037   => -0.156034,
	    93037 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 188813  => 0.107633,
	    188813 <= rv_l80_inp_avm_autoval                                     => 0.368356,
	    not add_input_pop                                                    => 0.368356,
	                                                                           0);
	
	v_subscore4 := map(
	    (rv_a41_prop_owner in [' ', '1']) => 0.314569,
	    (rv_a41_prop_owner in ['0'])      => -0.074247,
	                                         0);
	
	v_subscore5 := map(
	    NULL < (integer)rv_a50_pb_average_dollars AND (integer)rv_a50_pb_average_dollars < 0   => -0.038362,
	      0 <= (integer)rv_a50_pb_average_dollars AND (integer)rv_a50_pb_average_dollars < 16  => -0.196099,
	     16 <= (integer)rv_a50_pb_average_dollars AND (integer)rv_a50_pb_average_dollars < 32  => 0.047937,
	     32 <= (integer)rv_a50_pb_average_dollars AND (integer)rv_a50_pb_average_dollars < 66  => 0.323963,
	     66 <= (integer)rv_a50_pb_average_dollars                                              => 0.345224,
	                                                                                              0);
	
	v_subscore6 := map(
	    (rv_f04_curr_add_occ_index in [NULL, 0])  => -0.540168,
	    (rv_f04_curr_add_occ_index in [1])        => 0.100683,
	    (rv_f04_curr_add_occ_index in [3])        => -0.084242,
	                                                 0);
	
	v_subscore7 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 1 => -0.051195,
	    1 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2   => -0.09787,
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => 0.144617,
	    3 <= rv_c12_num_nonderogs                                => 0.312466,
	                                                                0);
	
	v_subscore8 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 0.019291,
	    1 <= rv_c21_stl_inq_count12                                  => -1.045972,
	                                                                    0);
	
	v_subscore9 := map(
	    (rv_e55_college_ind in [' ', '0']) => -0.019814,
	    (rv_e55_college_ind in ['1'])      => 0.314511,
	                                          0);
	
	v_subscore10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2          => 0.093951,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3            => -0.111329,
	    3 <= rv_s66_adlperssn_count                                           => -0.234197,
	    not((integer)ssnlength > 0)                                           => 0.093951,
	                                                                    0);
	
	v_subscore11 := map(
	    (rv_c22_inp_addr_occ_index in [NULL, 0, 1])       => 0.088294,
	    (rv_c22_inp_addr_occ_index in [3])                => 0.007657,
	    (rv_c22_inp_addr_occ_index in [4])                => -0.170862,
	    (rv_c22_inp_addr_occ_index in [5, 6, 7, 8])       => 0.029063,
	                                                         0);
	
	v_subscore12 := map(
	    (rv_f00_input_dob_match_level in [' ', '0', '8'])                     => 0.037858,
	    (rv_f00_input_dob_match_level in ['1', '2', '3', '4', '5', '6', '7']) => -0.337249,
	                                                                             0);
	
	v_subscore13 := map(
	    (rv_d32_criminal_x_felony in [' ', '0-0'])                                      => 0.02942,
	    (rv_d32_criminal_x_felony in ['1-0', '2-0'])                                    => -0.252823,
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.626073,
	                                                                                       0);
	
	v_subscore14 := map( 
	    (rv_e57_prof_license_br_flag in [NULL, 0])      => -0.01931,
	    (rv_e57_prof_license_br_flag in [1])            => 0.238076,
	                                                       0);
	
	v_subscore15 := map(
	    (rv_a44_curr_add_naprop in [0])              => 0.055299,
	    (rv_a44_curr_add_naprop in [1])              => -0.133147,
	    (rv_a44_curr_add_naprop in [2])              => -0.051893,
	    (rv_a44_curr_add_naprop in [NULL, 3, 4])     => 0.092975,
	                                                    0);
	
	v_subscore16 := map(
	    (rv_d33_eviction_recency in [' ', '00'])                          => 0.020762,
	    (rv_d33_eviction_recency in ['03', '06', '12', '24', '25', '36']) => -0.352398,
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99'])       => -0.054543,
	                                                                         0);
	
	v_subscore17 := map(
	    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 100       => -0.516739,
	    100 <= rv_f00_ssn_score                                  => 0.012279,
	    not truedid                                              => 0,
	    (integer)ssnlength <= 0                                  => 0.012279,
	                                                                0);
	
	v_subscore18 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.017979,
	    1 <= rv_i60_inq_count12                              => -0.267871,
	                                                            0);
	
	v_subscore19 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 0.005696,
	    (rv_p85_phn_disconnected in ['1'])      => -0.413529,
	                                               0);
	
	v_rawscore := v_subscore0 +
	    v_subscore1 +
	    v_subscore2 +
	    v_subscore3 +
	    v_subscore4 +
	    v_subscore5 +
	    v_subscore6 +
	    v_subscore7 +
	    v_subscore8 +
	    v_subscore9 +
	    v_subscore10 +
	    v_subscore11 +
	    v_subscore12 +
	    v_subscore13 +
	    v_subscore14 +
	    v_subscore15 +
	    v_subscore16 +
	    v_subscore17 +
	    v_subscore18 +
	    v_subscore19;
	
	v_lnoddsscore := v_rawscore + 0.751401;
	
	v_probscore := exp(v_lnoddsscore) / (1 + exp(v_lnoddsscore));
	
	v_aacd_0 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 'D30',
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => 'D30',
	    2 <= rv_d30_derog_count AND rv_d30_derog_count < 3   => 'D30',
	    3 <= rv_d30_derog_count                              => 'D30',
	                                                            'C12');
	
	v_dist_0 := v_subscore0 - 0.131672;
	
	v_aacd_1 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => 'F01',
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                        => 'F01',
			not truedid                                                                 => 'C12',
	                                                                                   '');
	
	v_dist_1 := v_subscore1 - 0.196058;
	
	v_aacd_2 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0       => 'A47',
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 23608       => 'A47',
	    23608 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 35461  => 'A47',
	    35461 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 51492  => 'A47',
	    51492 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 95840  => 'A47',
	    95840 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 137402 => 'A47',
	    137402 <= rv_a46_curr_avm_autoval                                     => 'A47',
	                                                                             'C12');
	
	v_dist_2_1 := v_subscore2 - 0.348024;
	
	v_aacd_3_1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0       => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 42834       => 'L80',
	    42834 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 93037  => 'L80',
	    93037 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 188813 => 'L80',
	    188813 <= rv_l80_inp_avm_autoval                                    => 'L80',
	                                                                           '');
	
	v_dist_3_1 := v_subscore3 - 0.368356;
	
	v_dist_3 := if(v_dist_2_1 != 0, 0, v_dist_3_1);
	
	v_aacd_3 := if(v_dist_2_1 != 0, '', v_aacd_3_1);
	
	v_dist_2 := if(v_dist_2_1 != 0, if(max(v_dist_2_1, v_dist_3_1) = NULL, NULL, sum(if(v_dist_2_1 = NULL, 0, v_dist_2_1), if(v_dist_3_1 = NULL, 0, v_dist_3_1))), v_dist_2_1);
	
	v_aacd_4 := map(
	    (rv_a41_prop_owner in [' ', '1']) => 'A41',
	    (rv_a41_prop_owner in ['0'])      => 'A41',
	                                         '');
	
	v_dist_4 := v_subscore4 - 0.314569;
	
	v_aacd_5 := 'C12';
	// map(
	    // NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 16  => 'A50',
	    // 16 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 32 => 'A50',
	    // 32 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 66 => 'A50',
	    // 66 <= rv_a50_pb_average_dollars                                    => 'A50',
	                                                                          // 'C12');
	
	v_dist_5 := if(RV_A50_PB_AVERAGE_DOLLARS=NULL, v_subscore5 - 0.345224, 0);
	
	v_aacd_6 := map(
	    (rv_f04_curr_add_occ_index in [NULL, 0]) => if(not truedid, 'C12', if(not add_curr_pop, 'A42', 'F04')),
	    (rv_f04_curr_add_occ_index in [1])       => 'F04',
	    (rv_f04_curr_add_occ_index in [3])       => 'F04',
	                                                 '');
	
	v_dist_6_1 := v_subscore6 - 0.100683;
	
	v_aacd_7 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 1 => 'C12',
	    1 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2   => 'C12',
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => 'C12',
	    3 <= rv_c12_num_nonderogs                                => 'C12',
	                                                                'C12');
	
	v_dist_7 := v_subscore7 - 0.312466;
	
	v_aacd_8 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count12                                  => 'C21',
	                                                                    'C12');
	
	v_dist_8 := v_subscore8 - 0.019291;
	
	v_aacd_9 := map(
	    (rv_e55_college_ind in [' ', '0']) => if(not truedid, 'C12', 'E55'),
	    (rv_e55_college_ind in ['1'])      => 'E55',
	                                          '');
	
	v_dist_9 := v_subscore9 - 0.314511;
	
	v_aacd_10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	v_dist_10 := v_subscore10 - 0.093951;
	
	v_aacd_11 := map(
	    (rv_c22_inp_addr_occ_index in [NULL, 0, 1])       => 'C22',
	    (rv_c22_inp_addr_occ_index in [3])                => 'C22',
	    (rv_c22_inp_addr_occ_index in [4])                => 'C22',
	    (rv_c22_inp_addr_occ_index in [5, 6, 7, 8])       => 'C22',
	                                                         '');
	
	v_dist_11_1 := v_subscore11 - 0.088294;
	
	v_dist_6 := if(v_dist_11_1 != 0 and v_dist_6_1 != 0, if(max(v_dist_6_1, v_dist_11_1) = NULL, NULL, sum(if(v_dist_6_1 = NULL, 0, v_dist_6_1), if(v_dist_11_1 = NULL, 0, v_dist_11_1))), v_dist_6_1);
	
	v_dist_11 := if(v_dist_11_1 != 0 and v_dist_6_1 != 0, 0, v_dist_11_1);
	
	v_aacd_12 := map(
	    (rv_f00_input_dob_match_level in [' ', '0', '8'])                     => 'F00',
	    (rv_f00_input_dob_match_level in ['1', '2', '3', '4', '5', '6', '7']) => 'F00',
	                                                                             '');
	
	v_dist_12 := v_subscore12 - 0.037858;
	
	v_aacd_13 := map(
	    (rv_d32_criminal_x_felony in [' ', '0-0'])                                      => 'D30',
	    (rv_d32_criminal_x_felony in ['1-0', '2-0'])                                    => 'D30',
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 'D30',
	                                                                                       '');
	
	v_dist_13 := v_subscore13 - 0.02942;
	
	v_aacd_14 := map(
	    (rv_e57_prof_license_br_flag in [NULL, 0]) => if(not truedid, 'C12', 'E57'),
	    (rv_e57_prof_license_br_flag in [1])       => 'E57',
	                                                   '');
	
	v_dist_14 := v_subscore14 - 0.238076;
	
	v_aacd_15 := map(
	    (rv_a44_curr_add_naprop in [0])           => 'A44',
	    (rv_a44_curr_add_naprop in [1])           => 'A44',
	    (rv_a44_curr_add_naprop in [2])           => 'A44',
	    (rv_a44_curr_add_naprop in [NULL, 3, 4])  => 'A44',
	                                                 '');
	
	v_dist_15 := v_subscore15 - 0.092975;
	
	v_aacd_16 := map(
	    (rv_d33_eviction_recency in [' ', '00'])                          => 'D30',
	    (rv_d33_eviction_recency in ['03', '06', '12', '24', '25', '36']) => 'D30',
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99'])       => 'D30',
	                                                                         '');
	
	v_dist_16 := v_subscore16 - 0.020762;
	
	v_aacd_17 := map(
	    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 100 => 'F00',
	    100 <= rv_f00_ssn_score                            => 'F00',
	                                                          if(not truedid, 'C12', ''));
	
	v_dist_17 := v_subscore17 - 0.012279;
	
	v_aacd_18 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12                              => 'I60',
	                                                            'C12');
	
	v_dist_18 := v_subscore18 - 0.017979;
	
	v_aacd_19 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 'P85',
	    (rv_p85_phn_disconnected in ['1'])      => 'P85',
	                                               '');
	
	v_dist_19 := v_subscore19 - 0.005696;

//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the derog seqment                    =
//==============================================================
	d_subscore0 := map(
	    (rv_a41_prop_owner in ['0']) => -0.122131,
	    (rv_a41_prop_owner in ['1']) => 0.339224,
	                                    0);
	
	d_subscore1 := map(
	    (rv_f00_addr_not_ver_w_ssn in [' ', '0']) => 0.126617,
	    (rv_f00_addr_not_ver_w_ssn in ['1'])      => -0.302477,
	                                                 0);
	
	d_subscore2 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 0.046792,
	    1 <= rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 2   => -0.483902,
	    2 <= rv_c21_stl_inq_count12                                  => -0.781697,
	                                                                    0);
	
	d_subscore3 := map(
	    (rv_d33_eviction_recency in ['00'])                         => 0.087983,
	    (rv_d33_eviction_recency in ['03', '06'])                   => -0.385908,
	    (rv_d33_eviction_recency in ['12', '24'])                   => -0.214776,
	    (rv_d33_eviction_recency in ['25', '36'])                   => -0.204647,
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => -0.074771,
	                                                                   0);
	
	d_subscore4 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => -0.033908,
	    0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 18  => -0.154445,
	    18 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 33 => -0.042954,
	    33 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 66 => 0.14894,
	    66 <= rv_a50_pb_average_dollars                                    => 0.202962,
	                                                                          0);
	
	d_subscore5 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => -0.04642,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 26401        => -0.271868,
	    26401 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 59833   => -0.144425,
	    59833 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 81436   => -0.048107,
	    81436 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 104673  => 0.014791,
	    104673 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 157556 => 0.137452,
	    157556 <= rv_l80_inp_avm_autoval                                     => 0.280297,
	    not add_input_pop                                                    => 0.280297,
	                                                                            0);
	
	d_subscore6 := map(
	    (rv_e55_college_ind in ['0']) => -0.023014,
	    (rv_e55_college_ind in ['1']) => 0.225231,
	                                     0);
	
	d_subscore7 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0        => -0.054074,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 44400        => -0.174648,
	    44400 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 81866   => -0.001377,
	    81866 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 106220  => 0.061593,
	    106220 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 237971 => 0.159886,
	    237971 <= rv_a46_curr_avm_autoval                                      => 0.229527,
	                                                                              0);
	
	d_subscore8 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 12 => -0.243324,
	    12 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24  => -0.056239,
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60  => -0.002311,
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 0.039132,
	    120 <= rv_c13_attr_addrs_recency                                    => 0.140467,
	                                                                           0);
	
	d_subscore9 := map(
	    (rv_e57_prof_license_br_flag in [0])    => -0.032873,
	    (rv_e57_prof_license_br_flag in [1])    => 0.204929,
	                                               0);
	
	d_subscore10 := map(
	    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 100          => -0.61094,
	    100 <= rv_f00_ssn_score                                     => 0.012135,
	    not truedid                                                 => 0,
	    (integer)ssnlength <= 0                                     => 0.012135,
	                                                                   0);
	
	d_subscore11 := map(
	    not(truedid)                                                   => 0,
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 19.2  => -0.363892,
	    19.2 <= rv_c12_source_profile AND rv_c12_source_profile < 45.5 => -0.05042,
	    45.5 <= rv_c12_source_profile AND rv_c12_source_profile < 63.9 => -0.012919,
	    63.9 <= rv_c12_source_profile AND rv_c12_source_profile < 82.3 => 0.07067,
	    82.3 <= rv_c12_source_profile                                  => 0.231598,
	                                                                      0);
	
	d_subscore12 := map(
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => -0.087484,
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])       => 0.08945,
	                                                                                    0);
	
	d_subscore13 := map(
	    NULL < rv_d32_felony_count AND rv_d32_felony_count < 1 => 0.021582,
	    1 <= rv_d32_felony_count                               => -0.340758,
	                                                              0);
	
	d_subscore14 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.022093,
	    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.292044,
	                                                                                  0);
	
	d_subscore15 := map(
	    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0    => 0.02714,
	    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 28     => -0.259523,
	    28 <= rv_d32_mos_since_crim_ls                                      => -0.011629,
	                                                                        0);
	
	d_subscore16 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3          => 0.029308,
	    3 <= rv_s66_adlperssn_count                                           => -0.17859,
	    not((integer)ssnlength > 0)                                           => 0.029308,
	                                                                             0);
	
	d_subscore17 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 3 => 0.035856,
	    3 <= rv_d30_derog_count AND rv_d30_derog_count < 5   => -0.020554,
	    5 <= rv_d30_derog_count                              => -0.176362,
	                                                            0);
	
	d_subscore18 := map(
	    (rv_a44_curr_add_naprop in [0])           => 0.018098,
	    (rv_a44_curr_add_naprop in [1])           => -0.070155,
	    (rv_a44_curr_add_naprop in [2, 3, 4])     => 0.071518,
	                                                 0);
	
	d_subscore19 := map(
	    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0'])               => 0.01362,
	    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.237234,
	                                                                                0);
	
	d_subscore20 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 0.005545,
	    (rv_p85_phn_disconnected in ['1'])      => -0.324656,
	                                               0);
	
	d_subscore21 := map(
	    NULL < rv_f00_dob_score AND rv_f00_dob_score < 100 => -0.164093,
	    100 <= rv_f00_dob_score                            => 0.009587,
	    not truedid                                        => 0,
	    not dobpop                                         => 0.009587,
	                                                          0);
	
	d_rawscore := d_subscore0 +
	    d_subscore1 +
	    d_subscore2 +
	    d_subscore3 +
	    d_subscore4 +
	    d_subscore5 +
	    d_subscore6 +
	    d_subscore7 +
	    d_subscore8 +
	    d_subscore9 +
	    d_subscore10 +
	    d_subscore11 +
	    d_subscore12 +
	    d_subscore13 +
	    d_subscore14 +
	    d_subscore15 +
	    d_subscore16 +
	    d_subscore17 +
	    d_subscore18 +
	    d_subscore19 +
	    d_subscore20 +
	    d_subscore21;
	
	d_lnoddsscore := d_rawscore + 0.407892;
	
	d_probscore := exp(d_lnoddsscore) / (1 + exp(d_lnoddsscore));
	
	d_aacd_0 := map(
	    (rv_a41_prop_owner in ['0']) => 'A41',
	    (rv_a41_prop_owner in ['1']) => 'A41',
	                                    '');
	
	d_dist_0 := d_subscore0 - 0.339224;
	
	d_aacd_1 := map(
	    (rv_f00_addr_not_ver_w_ssn in [' ', '0']) => 'F00',
	    (rv_f00_addr_not_ver_w_ssn in ['1'])      => 'F00',
	                                                 '');
	
	d_dist_1 := d_subscore1 - 0.126617;
	
	d_aacd_2 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 2   => 'C21',
	    2 <= rv_c21_stl_inq_count12                                  => 'C21',
	                                                                    '');
	
	d_dist_2 := d_subscore2 - 0.046792;
	
	d_aacd_3 := map(
	    (rv_d33_eviction_recency in ['00'])                         => 'D30',
	    (rv_d33_eviction_recency in ['03', '06'])                   => 'D30',
	    (rv_d33_eviction_recency in ['12', '24'])                   => 'D30',
	    (rv_d33_eviction_recency in ['25', '36'])                   => 'D30',
	    (rv_d33_eviction_recency in ['37', '60', '61', '98', '99']) => 'D30',
	                                                                   '');
	
	d_dist_3 := d_subscore3 - 0.087983;
	
	d_aacd_4 := '';
	// map(
	    // NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 18  => 'A50',
	    // 18 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 33 => 'A50',
	    // 33 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 66 => 'A50',
	    // 66 <= rv_a50_pb_average_dollars                                    => 'A50',
	                                                                          // '');
	
	d_dist_4 := IF(RV_A50_PB_AVERAGE_DOLLARS=NULL, d_subscore4 - 0.202962, 0);
	
	d_aacd_5_1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 26401        => 'L80',
	    26401 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 59833   => 'L80',
	    59833 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 81436   => 'L80',
	    81436 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 104673  => 'L80',
	    104673 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 157556 => 'L80',
	    157556 <= rv_l80_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	d_dist_5_1 := d_subscore5 - 0.280297;
	
	d_aacd_6 := map(
	    (rv_e55_college_ind in ['0']) => 'E55',
	    (rv_e55_college_ind in ['1']) => 'E55',
	                                     '');
	
	d_dist_6 := d_subscore6 - 0.225231;
	
	d_aacd_7 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0        => 'A47',
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 44400        => 'A47',
	    44400 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 81866   => 'A47',
	    81866 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 106220  => 'A47',
	    106220 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 237971 => 'A47',
	    237971 <= rv_a46_curr_avm_autoval                                      => 'A47',
	                                                                              '');
	
	d_dist_7_1 := d_subscore7 - 0.229527;
	
	d_dist_7 := if(d_dist_7_1 != 0, if(max(d_dist_7_1, d_dist_5_1) = NULL, NULL, sum(if(d_dist_7_1 = NULL, 0, d_dist_7_1), if(d_dist_5_1 = NULL, 0, d_dist_5_1))), d_dist_7_1);
	
	d_dist_5 := if(d_dist_7_1 != 0, 0, d_dist_5_1);
	
	d_aacd_5 := if(d_dist_7_1 != 0, '', d_aacd_5_1);
	
	d_aacd_8 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 12 => 'C13',
	    12 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24  => 'C13',
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60  => 'C13',
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 'C13',
	    120 <= rv_c13_attr_addrs_recency                                    => 'C13',
	                                                                           '');
	
	d_dist_8 := d_subscore8 - 0.140467;
	
	d_aacd_9 := map(
	    (rv_e57_prof_license_br_flag in [0]) => 'E57',
	    (rv_e57_prof_license_br_flag in [1]) => 'E57',
	                                            '');
	
	d_dist_9 := d_subscore9 - 0.204929;
	
	d_aacd_10 := map(
	    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 100 => 'F00',
	    100 <= rv_f00_ssn_score                            => 'F00',
	                                                          if(not truedid, 'C12', ''));
	
	d_dist_10 := d_subscore10 - 0.012135;
	
	d_aacd_11 := map(
	    not(truedid)                                                   => '',
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 19.2  => 'C12',
	    19.2 <= rv_c12_source_profile AND rv_c12_source_profile < 45.5 => 'C12',
	    45.5 <= rv_c12_source_profile AND rv_c12_source_profile < 63.9 => 'C12',
	    63.9 <= rv_c12_source_profile AND rv_c12_source_profile < 82.3 => 'C12',
	    82.3 <= rv_c12_source_profile                                  => 'C12',
	                                                                      '');
	
	d_dist_11 := d_subscore11 - 0.231598;
	
	d_aacd_12 := map(
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])       => 'F03',
	                                                                                    '');
	
	d_dist_12 := d_subscore12 - 0.08945;
	
	d_aacd_13 := map(
	    NULL < rv_d32_felony_count AND rv_d32_felony_count < 1 => 'D30',
	    1 <= rv_d32_felony_count                               => 'D30',
	                                                              '');
	
	d_dist_13 := d_subscore13 - 0.021582;
	
	d_aacd_14 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	d_dist_14 := d_subscore14 - 0.022093;
	
	d_aacd_15 := map(
	    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 'D30',
	    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 28  => 'D30',
	    28 <= rv_d32_mos_since_crim_ls                                   => 'D30',
	                                                                        '');
	
	d_dist_15 := d_subscore15 - 0.02714;
	
	d_aacd_16 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3 => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	d_dist_16 := d_subscore16 - 0.029308;
	
	d_aacd_17 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 3 => 'D30',
	    3 <= rv_d30_derog_count AND rv_d30_derog_count < 5   => 'D30',
	    5 <= rv_d30_derog_count                              => 'D30',
	                                                            '');
	
	d_dist_17 := d_subscore17 - 0.035856;
	
	d_aacd_18 := map(
	    (rv_a44_curr_add_naprop in [0])           => 'A44',
	    (rv_a44_curr_add_naprop in [1])           => 'A44',
	    (rv_a44_curr_add_naprop in [2, 3, 4])     => 'A44',
	    not truedid                               => 'C12', 
			not add_curr_pop                          => 'A42', 
			                                             '');
	
	d_dist_18 := d_subscore18 - 0.071518;
	
	d_aacd_19 := map(
	    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0'])               => 'D30',
	    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 'D30',
	                                                                                '');
	
	d_dist_19 := d_subscore19 - 0.01362;
	
	d_aacd_20 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 'P85',
	    (rv_p85_phn_disconnected in ['1'])      => 'P85',
	                                               '');
	
	d_dist_20 := d_subscore20 - 0.005545;
	
	d_aacd_21 := map(
	    NULL < rv_f00_dob_score AND rv_f00_dob_score < 100 => 'F00',
	    100 <= rv_f00_dob_score                            => 'F00',
			not truedid                                        => 'C12',
	                                                          '');
	
	d_dist_21 := d_subscore21 - 0.009587;
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the propown seqment                  =
//==============================================================
	
	p_subscore0 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => -1.05575,
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => -0.109516,
	    100 <= rv_f01_inp_addr_address_score                                        => 0.174748,
	    not truedid                                                                 => 0,
	    not add_input_pop                                                           => 0.174748,
	                                                                                   0);
	
	p_subscore1 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.055067,
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => -0.398725,
	    2 <= rv_d30_derog_count                              => -0.815758,
	                                                            0);
	
	p_subscore2 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => -0.409649,
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => -0.042276,
	    3 <= rv_c12_num_nonderogs                                => 0.053284,
	                                                                0);
	
	p_subscore3 := map(
	    not(truedid)                                                      => 0,
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 18.7     => -0.481105,
	    18.7 <= rv_c12_source_profile AND rv_c12_source_profile < 36.9    => -0.113415,
	    36.9 <= rv_c12_source_profile AND rv_c12_source_profile < 64.1    => -0.021414,
	    64.1 <= rv_c12_source_profile AND rv_c12_source_profile < 84.8    => 0.023663,
	    84.8 <= rv_c12_source_profile                                     => 0.285882,
	                                                                         0);
	
	p_subscore4 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2      => 0.084136,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3        => -0.070061,
	    3 <= rv_s66_adlperssn_count                                       => -0.200492,
	    not((integer)ssnlength > 0)                                       => 0.084136,
	                                                                         0);
	
	p_subscore5 := map(
	    (rv_a44_curr_add_naprop in [0])         => -0.04439,
	    (rv_a44_curr_add_naprop in [1, 2])      => -0.33535,
	    (rv_a44_curr_add_naprop in [3])         => -0.134727,
	    (rv_a44_curr_add_naprop in [NULL, 4])   => 0.09184,
	                                               0);
	
	p_subscore6 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => -0.176954,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 27589        => -0.665333,
	    27589 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 63405   => -0.449619,
	    63405 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 81235   => -0.297983,
	    81235 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 97786   => -0.183351,
	    97786 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 113846  => -0.042496,
	    113846 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 145325 => 0.086564,
	    145325 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 206104 => 0.335107,
	    206104 <= rv_l80_inp_avm_autoval                                     => 0.467758,
	    not add_input_pop                                                    => 0.467758,
	                                                                            0);
	
	p_subscore7 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0        => -0.182612,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 32621        => -0.481266,
	    32621 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 59759   => -0.224587,
	    59759 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 92244   => -0.08929,
	    92244 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 138700  => 0.026888,
	    138700 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 328545 => 0.262151,
	    328545 <= rv_a46_curr_avm_autoval                                      => 0.39609,
	                                                                              0);
	
	p_subscore8 := map(
	    (rv_e55_college_ind in ['0']) => -0.047962,
	    (rv_e55_college_ind in ['1']) => 0.324108,
	                                     0);
	
	p_subscore9 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.064254,
	    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => -0.849048,
	    2 <= rv_i60_inq_count12                              => -1.028228,
	                                                            0);
	
	p_subscore10 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24 => -0.189698,
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => -0.063467,
	    120 <= rv_c13_attr_addrs_recency                                    => 0.109832,
	                                                                           0);
	
	p_subscore11 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => -0.156467,
	    0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 15  => -0.160191,
	    15 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 34 => -0.010911,
	    34 <= rv_a50_pb_average_dollars                                    => 0.231868,
	                                                                          0);
	
	p_rawscore := p_subscore0 +
	    p_subscore1 +
	    p_subscore2 +
	    p_subscore3 +
	    p_subscore4 +
	    p_subscore5 +
	    p_subscore6 +
	    p_subscore7 +
	    p_subscore8 +
	    p_subscore9 +
	    p_subscore10 +
	    p_subscore11;
	
	p_lnoddsscore := p_rawscore + 2.558405;
	
	p_probscore := exp(p_lnoddsscore) / (1 + exp(p_lnoddsscore));
	
	p_aacd_0 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50    => 'F01',
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100    => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                           => 'F01',
	    not truedid                                                                    => 'C12',
																																										    '');
	
	p_dist_0 := p_subscore0 - 0.174748;
	
	p_aacd_1 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 'D30',
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => 'D30',
	    2 <= rv_d30_derog_count                              => 'D30',
	                                                            '');
	
	p_dist_1 := p_subscore1 - 0.055067;
	
	p_aacd_2 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => 'C12',
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => 'C12',
	    3 <= rv_c12_num_nonderogs                                => 'C12',
	                                                                '');
	
	p_dist_2 := p_subscore2 - 0.053284;
	
	p_aacd_3 := map(
	    not(truedid)                                                   => '',
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 18.7  => 'C12',
	    18.7 <= rv_c12_source_profile AND rv_c12_source_profile < 36.9 => 'C12',
	    36.9 <= rv_c12_source_profile AND rv_c12_source_profile < 64.1 => 'C12',
	    64.1 <= rv_c12_source_profile AND rv_c12_source_profile < 84.8 => 'C12',
	    84.8 <= rv_c12_source_profile                                  => 'C12',
	                                                                      '');
	
	p_dist_3 := p_subscore3 - 0.285882;
	
	p_aacd_4 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	p_dist_4 := p_subscore4 - 0.084136;
	
	p_aacd_5 := map(
	    (rv_a44_curr_add_naprop in [0])         => 'A44',
	    (rv_a44_curr_add_naprop in [1, 2])      => 'A44',
	    (rv_a44_curr_add_naprop in [3])         => 'A44',
	    (rv_a44_curr_add_naprop in [NULL, 4])   => 'A44',
	                                               '');
	
	p_dist_5 := p_subscore5 - 0.09184;
	
	p_aacd_6_1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 27589        => 'L80',
	    27589 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 63405   => 'L80',
	    63405 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 81235   => 'L80',
	    81235 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 97786   => 'L80',
	    97786 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 113846  => 'L80',
	    113846 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 145325 => 'L80',
	    145325 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 206104 => 'L80',
	    206104 <= rv_l80_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	p_dist_6_1 := p_subscore6 - 0.467758;
	
	p_aacd_7 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0        => 'A47',
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 32621        => 'A47',
	    32621 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 59759   => 'A47',
	    59759 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 92244   => 'A47',
	    92244 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 138700  => 'A47',
	    138700 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 328545 => 'A47',
	    328545 <= rv_a46_curr_avm_autoval                                      => 'A47',
	                                                                              '');
	
	p_dist_7_1 := p_subscore7 - 0.39609;
	
	p_dist_6 := if(p_dist_7_1 != 0, 0, p_dist_6_1);
	
	p_aacd_6 := if(p_dist_7_1 != 0, '', p_aacd_6_1);
	
	p_dist_7 := if(p_dist_7_1 != 0, if(max(p_dist_7_1, p_dist_6_1) = NULL, NULL, sum(if(p_dist_7_1 = NULL, 0, p_dist_7_1), if(p_dist_6_1 = NULL, 0, p_dist_6_1))), p_dist_7_1);
	
	p_aacd_8 := map(
	    (rv_e55_college_ind in ['0']) => 'E55',
	    (rv_e55_college_ind in ['1']) => 'E55',
	                                     '');
	
	p_dist_8 := p_subscore8 - 0.324108;
	
	p_aacd_9 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => 'I60',
	    2 <= rv_i60_inq_count12                              => 'I60',
	                                                            '');
	
	p_dist_9 := p_subscore9 - 0.064254;
	
	p_aacd_10 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24 => 'C13',
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 'C13',
	    120 <= rv_c13_attr_addrs_recency                                    => 'C13',
	                                                                           '');
	
	p_dist_10 := p_subscore10 - 0.109832;
	
	p_aacd_11 := '';
	// map(
	    // NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 15  => 'A50',
	    // 15 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 34 => 'A50',
	    // 34 <= rv_a50_pb_average_dollars                                    => 'A50',
	                                                                          // '');
	
	p_dist_11 := IF(RV_A50_PB_AVERAGE_DOLLARS=NULL, p_subscore11 - 0.231868, 0);
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the other seqment                    =
//==============================================================	
	
	o_subscore0 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => -0.452592,
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => -0.006396,
	    100 <= rv_f01_inp_addr_address_score                                        => 0.193278,
	    not truedid                                                                 => 0,
	    not add_input_pop                                                           => 0.193278,
	                                                                                   0);
	
	o_subscore1 := map(
	    (rv_e55_college_ind in ['0']) => -0.05314,
	    (rv_e55_college_ind in ['1']) => 0.393179,
	                                     0);
	
	o_subscore2 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => -0.070241,
	    0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 15  => -0.292015,
	    15 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 20 => -0.046102,
	    20 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 41 => 0.1357,
	    41 <= rv_a50_pb_average_dollars                                    => 0.358596,
	                                                                          0);
	
	o_subscore3 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0       => -0.102718,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 29847       => -0.432871,
	    29847 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 44959  => -0.204088,
	    44959 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 62957  => -0.157251,
	    62957 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 99024  => -0.024567,
	    99024 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 193780 => 0.215769,
	    193780 <= rv_a46_curr_avm_autoval                                     => 0.491708,
	                                                                             0);
	
	o_subscore4 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0          => -0.005764,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 24394          => -0.59486,
	    24394 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 69258     => -0.320621,
	    69258 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 135535    => -0.026715,
	    135535 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 376216   => 0.239425,
	    376216 <= rv_l80_inp_avm_autoval                                       => 0.535202,
	    not add_input_pop                                                      => 0.535202,
	                                                                            0);
	
	o_subscore5 := map(
	    (rv_a44_curr_add_naprop in [0])             => 0.027216,
	    (rv_a44_curr_add_naprop in [1])             => -0.160415,
	    (rv_a44_curr_add_naprop in [2])             => 0.012982,
	    (rv_a44_curr_add_naprop in [NULL, 3, 4])    => 0.226622,
	                                                   0);
	
	o_subscore6 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.023293,
	    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.915294,
	                                                                                  0);
	
	o_subscore7 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => -0.062342,
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => -0.074286,
	    3 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4   => 0.254368,
	    4 <= rv_c12_num_nonderogs                                => 0.39828,
	                                                                0);
	
	o_subscore8 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => -0.137517,
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])                                 => 0.123712,
	                                                                                                              0);
	
	o_subscore9 := map(
	    (rv_e57_prof_license_br_flag in [0])      => -0.040182,
	    (rv_e57_prof_license_br_flag in [1])      => 0.403078,
	                                                 0);
	
	o_subscore10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2          => 0.086301,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3            => -0.111866,
	    3 <= rv_s66_adlperssn_count                                           => -0.21345,
	    not((integer)ssnlength > 0)                                           => 0.086301,
	                                                                             0);
	
	o_subscore11 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.028422,
	    1 <= rv_i60_inq_count12                              => -0.398926,
	                                                            0);
	
	o_subscore12 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 28 => -0.205264,
	    28 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 50  => -0.046338,
	    50 <= rv_c10_m_hdr_fs                           => 0.033219,
	                                                       0);
	
	o_subscore13 := map(
	    (rv_a41_prop_owner in ['0']) => -0.014568,
	    (rv_a41_prop_owner in ['1']) => 0.348035,
	                                    0);
	
	o_subscore14 := map(
	    NULL < rv_c12_nonderog_recency AND rv_c12_nonderog_recency < 6 => 0.011228,
	    6 <= rv_c12_nonderog_recency                                   => -0.345436,
	                                                                      0);
	
	o_subscore15 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 3  => -0.037362,
	    3 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60   => -0.041607,
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => -0.000332,
	    120 <= rv_c13_attr_addrs_recency                                    => 0.117035,
	                                                                           0);
	
	o_subscore16 := map(
	    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 100          => -0.515791,
	    100 <= rv_f00_ssn_score                                     => 0.006714,
	    not truedid                                                 => 0,
	    (integer)ssnlength <= 0                                     => 0.006714,
	                                                                   0);
	
	o_subscore17 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 0.049859,
	    2 <= rv_c14_addrs_5yr                            => -0.074738,
	                                                        0);
	
	o_subscore18 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 0.008433,
	    (iv_d34_liens_unrel_x_rel in ['1-0'])                                                         => -0.451744,
	    (iv_d34_liens_unrel_x_rel in ['2-0', '3-0'])                                                  => -0.287422,
	                                                                                                     0);
	
	o_subscore19 := map(
	    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1 => 0.033815,
	    1 <= rv_c18_invalid_addrs_per_adl                                        => -0.076497,
	                                                                                0);
	
	o_rawscore := o_subscore0 +
	    o_subscore1 +
	    o_subscore2 +
	    o_subscore3 +
	    o_subscore4 +
	    o_subscore5 +
	    o_subscore6 +
	    o_subscore7 +
	    o_subscore8 +
	    o_subscore9 +
	    o_subscore10 +
	    o_subscore11 +
	    o_subscore12 +
	    o_subscore13 +
	    o_subscore14 +
	    o_subscore15 +
	    o_subscore16 +
	    o_subscore17 +
	    o_subscore18 +
	    o_subscore19;
	
	o_lnoddsscore := o_rawscore + 1.180717;
	
	o_probscore := exp(o_lnoddsscore) / (1 + exp(o_lnoddsscore));
	
	o_aacd_0 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => 'F01',
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                        => 'F01',
	    not truedid                                                                 => 'C12', 
			                                                                               '');
	
	o_dist_0 := o_subscore0 - 0.193278;
	
	o_aacd_1 := map(
	    (rv_e55_college_ind in ['0']) => 'E55',
	    (rv_e55_college_ind in ['1']) => 'E55',
	                                     '');
	
	o_dist_1 := o_subscore1 - 0.393179;
	
	o_aacd_2 := '';
	// map(
	    // NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 15  => 'A50',
	    // 15 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 20 => 'A50',
	    // 20 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 41 => 'A50',
	    // 41 <= rv_a50_pb_average_dollars                                    => 'A50',
	                                                                          // '');
	
	o_dist_2 := IF(RV_A50_PB_AVERAGE_DOLLARS=NULL, o_subscore2 - 0.358596, 0);
	
	o_aacd_3 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0       => 'A47',
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 29847       => 'A47',
	    29847 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 44959  => 'A47',
	    44959 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 62957  => 'A47',
	    62957 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 99024  => 'A47',
	    99024 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 193780 => 'A47',
	    193780 <= rv_a46_curr_avm_autoval                                     => 'A47',
	                                                                             '');
	
	o_dist_3_1 := o_subscore3 - 0.491708;
	
	o_aacd_4_1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 24394        => 'L80',
	    24394 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 69258   => 'L80',
	    69258 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 135535  => 'L80',
	    135535 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 376216 => 'L80',
	    376216 <= rv_l80_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	o_dist_4_1 := o_subscore4 - 0.535202;
	
	o_aacd_4 := if(o_dist_3_1 != 0, '', o_aacd_4_1);
	
	o_dist_4 := if(o_dist_3_1 != 0, 0, o_dist_4_1);
	
	o_dist_3 := if(o_dist_3_1 != 0, if(max(o_dist_3_1, o_dist_4_1) = NULL, NULL, sum(if(o_dist_3_1 = NULL, 0, o_dist_3_1), if(o_dist_4_1 = NULL, 0, o_dist_4_1))), o_dist_3_1);
	
	o_aacd_5 := map(
	    (rv_a44_curr_add_naprop in [0])             => 'A44',
	    (rv_a44_curr_add_naprop in [1])             => 'A44',
	    (rv_a44_curr_add_naprop in [2])             => 'A44',
	    (rv_a44_curr_add_naprop in [NULL, 3, 4])    => 'A44',
	                                                   '');
	
	o_dist_5 := o_subscore5 - 0.226622;
	
	o_aacd_6 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1   => 'I60',
	    1 <= rv_i60_inq_hiriskcred_count12                                           => 'I60',
	                                                                                    '');
	
	o_dist_6 := o_subscore6 - 0.023293;
	
	o_aacd_7 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => 'C12',
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => 'C12',
	    3 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4   => 'C12',
	    4 <= rv_c12_num_nonderogs                                => 'C12',
	                                                                '');
	
	o_dist_7 := o_subscore7 - 0.39828;
	
	o_aacd_8 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])                                 => 'F03',
	                                                                                                              '');
	
	o_dist_8 := o_subscore8 - 0.123712;
	
	o_aacd_9 := map(
	    (rv_e57_prof_license_br_flag in [0])    => 'E57',
	    (rv_e57_prof_license_br_flag in [1])    => 'E57',
	                                                 '');
	
	o_dist_9 := o_subscore9 - 0.403078;
	
	o_aacd_10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	o_dist_10 := o_subscore10 - 0.086301;
	
	o_aacd_11 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12                              => 'I60',
	                                                            '');
	
	o_dist_11 := o_subscore11 - 0.028422;
	
	o_aacd_12 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 28 => 'C10',
	    28 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 50  => 'C10',
	    50 <= rv_c10_m_hdr_fs                           => 'C10',
	                                                       '');
	
	o_dist_12 := o_subscore12 - 0.033219;
	
	o_aacd_13 := map(
	    (rv_a41_prop_owner in ['0']) => 'A41',
	    (rv_a41_prop_owner in ['1']) => 'A41',
	                                    '');
	
	o_dist_13 := o_subscore13 - 0.348035;
	
	o_aacd_14 := map(
	    NULL < rv_c12_nonderog_recency AND rv_c12_nonderog_recency < 6 => 'C12',
	    6 <= rv_c12_nonderog_recency                                   => 'C12',
	                                                                      '');
	
	o_dist_14 := o_subscore14 - 0.011228;
	
	o_aacd_15 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 3  => 'C13',
	    3 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60   => 'C13',
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 'C13',
	    120 <= rv_c13_attr_addrs_recency                                    => 'C13',
	                                                                           '');
	
	o_dist_15 := o_subscore15 - 0.117035;
	
	o_aacd_16 := map(
	    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 100                   => 'F00',
	    100 <= rv_f00_ssn_score                                              => 'F00',
	    not truedid                                                          => 'C12', 
			                                                                        '');
	
	o_dist_16 := o_subscore16 - 0.006714;
	
	o_aacd_17 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 'C14',
	    2 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	o_dist_17 := o_subscore17 - 0.049859;
	
	o_aacd_18 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['1-0'])                                                         => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['2-0', '3-0'])                                                  => 'D34',
	                                                                                                     '');
	
	o_dist_18 := o_subscore18 - 0.008433;
	
	o_aacd_19 := map(
	    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1 => 'C18',
	    1 <= rv_c18_invalid_addrs_per_adl                                        => 'C18',
	                                                                                '');
	
	o_dist_19 := o_subscore19 - 0.033815;
	
	base   := 750;
	points := 50;
	odds   := 20;
	
	lnoddsscore := if(max((integer)verprob_seg * v_lnoddsscore, (integer)derog_seg * d_lnoddsscore, (integer)owner_seg * p_lnoddsscore, (integer)other_seg * o_lnoddsscore) = NULL, NULL, sum(if((integer)verprob_seg * v_lnoddsscore = NULL, 0, (integer)verprob_seg * v_lnoddsscore), if((integer)derog_seg * d_lnoddsscore = NULL, 0, (integer)derog_seg * d_lnoddsscore), if((integer)owner_seg * p_lnoddsscore = NULL, 0, (integer)owner_seg * p_lnoddsscore), if((integer)other_seg * o_lnoddsscore = NULL, 0, (integer)other_seg * o_lnoddsscore)));
	
	score_lnodds := round(points * (lnoddsscore - ln(odds)) / ln(2) + base);
	
	score_lnodds_capped := min(900, if(max(501, score_lnodds) = NULL, -NULL, max(501, score_lnodds)));
	
	ov_ssnprior := rc_ssndobflag = '1' or rc_pwssndobflag = '1';
	
	ov_corrections := rc_hrisksic = '2225';
	
//==============================================================
//=             Some logic for high risk phones               =
//=             and high risk addresses                       =
//=             Additional logic for deceased                 =
//==============================================================
	
	deceased := map(
	    rc_decsflag = '1'                                    => 1,
	    rc_ssndod != 0                                       => 1,
	    contains_i(ver_sources, 'DE') > 0 
			or contains_i(ver_sources, 'DS') > 0                 => 2,
	    rc_decsflag = '0'                                    => 0,
	                                                            NULL);
	
	_ov_pts_lost_c200_b3 := 550 - score_lnodds_capped;
	
	_ov_pts_lost_raw := map(
	    deceased > 0                                                   => NULL,
	    iv_rv5_unscorable = '1'                                        => NULL,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections)  => ln(2) * _ov_pts_lost_c200_b3 / points,
	                                                                      0);
	
	rvt1503_0_1 := map(
	    deceased > 0                                                    => 200,
	    iv_rv5_unscorable = '1'                                         => 222,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections)   => 550,
	                                                                       score_lnodds_capped);
	
	_rc_seg_c203 := map(
	    add_ec1 = 'E' and not(rc_addrvalflag = 'N') or out_z5 = ''      => 'L70',
	    rc_hrisksic = '2225'                                            => 'L73',
	    rc_hrisksicphone = '2225'                                       => 'P87',
	    rc_hriskaddrflag = '2' 
			   or rc_ziptypeflag = '2' 
			   or (add_input_advo_res_or_bus in ['B', 'D']) 
				 or rc_hriskaddrflag = '4' 
				 or rc_addrcommflag = '2'                                     => 'L71',
			add_input_advo_Vacancy = 'Y'                                    => 'L72',
	                                                                       '');
	
	_rc_seg_c204 := map(
	    rc_hriskphoneflag = '2' 
			  or rc_hphonetypeflag = '2' 
				or (telcordia_type in ['02', '56', '61'])  
				or rc_hphonetypeflag = 'A'                        => 'P86',
	                                                           'P85');
	
	_rc_seg_c202 := map(
	     not(boolean)sufficiently_verified                     => 'F00',
	    adls_per_ssn >= 5 or ssns_per_adl >= 4                 => 'S66',
	    invalid_ssns_per_adl >= 1                              => 'S65',
	    rc_ssndobflag = '1'                                    => 'S65',
	    rc_pwssndobflag = '1'                                  => 'S65',
	    adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7     => 'L79',
	    (boolean)(integer)addr_validation_problem              => _rc_seg_c203,
	    (boolean)Phn_Validation_Problem                        => _rc_seg_c204,
	                                                             'C12');
	
	_rc_seg_c205 := map(
	    felony_count > 0 or criminal_count > 0        => 'D32',
	    stl_inq_count12 > 0                           => 'C21',
	    attr_eviction_count > 0                       => 'D33',
	    liens_unrel_CJ_ct > 0 
			   or liens_rel_CJ_ct > 0 
				 or liens_unrel_SC_ct > 0 
				 or liens_rel_SC_ct > 0 
				 or liens_unrel_FC_ct > 0 
				 or liens_rel_FC_ct > 0 
				 or liens_unrel_O_ct > 0 
				 or liens_rel_O_ct > 0 
				 or tot_liens - tot_liens_w_type > 0        => 'D34',
	                                                     'D31');
	
	_rc_seg := map(
	    VerProb_seg => _rc_seg_c202,
	    Derog_seg   => _rc_seg_c205,
	    Other_seg   => 'A41',
	                   '');
										 
//=========================================================
//==  start calculating the RC values for verprob segment =
//=========================================================										 
	
	v_dist_20 := _ov_pts_lost_raw;
	
	v_aacd_20 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                  '');
												
	v_rcvaluec22 := (integer)(v_aacd_0 = 'C22') * v_dist_0 +
	    (integer)(v_aacd_1 = 'C22') * v_dist_1 +
	    (integer)(v_aacd_2 = 'C22') * v_dist_2 +
	    (integer)(v_aacd_3 = 'C22') * v_dist_3 +
	    (integer)(v_aacd_4 = 'C22') * v_dist_4 +
	    (integer)(v_aacd_5 = 'C22') * v_dist_5 +
	    (integer)(v_aacd_6 = 'C22') * v_dist_6 +
	    (integer)(v_aacd_7 = 'C22') * v_dist_7 +
	    (integer)(v_aacd_8 = 'C22') * v_dist_8 +
	    (integer)(v_aacd_9 = 'C22') * v_dist_9 +
	    (integer)(v_aacd_10 = 'C22') * v_dist_10 +
	    (integer)(v_aacd_11 = 'C22') * v_dist_11 +
	    (integer)(v_aacd_12 = 'C22') * v_dist_12 +
	    (integer)(v_aacd_13 = 'C22') * v_dist_13 +
	    (integer)(v_aacd_14 = 'C22') * v_dist_14 +
	    (integer)(v_aacd_15 = 'C22') * v_dist_15 +
	    (integer)(v_aacd_16 = 'C22') * v_dist_16 +
	    (integer)(v_aacd_17 = 'C22') * v_dist_17 +
	    (integer)(v_aacd_18 = 'C22') * v_dist_18 +
	    (integer)(v_aacd_19 = 'C22') * v_dist_19 +
	    (integer)(v_aacd_20 = 'C22') * v_dist_20;
	
	v_rcvaluec21 := (integer)(v_aacd_0 = 'C21') * v_dist_0 +
	    (integer)(v_aacd_1 = 'C21') * v_dist_1 +
	    (integer)(v_aacd_2 = 'C21') * v_dist_2 +
	    (integer)(v_aacd_3 = 'C21') * v_dist_3 +
	    (integer)(v_aacd_4 = 'C21') * v_dist_4 +
	    (integer)(v_aacd_5 = 'C21') * v_dist_5 +
	    (integer)(v_aacd_6 = 'C21') * v_dist_6 +
	    (integer)(v_aacd_7 = 'C21') * v_dist_7 +
	    (integer)(v_aacd_8 = 'C21') * v_dist_8 +
	    (integer)(v_aacd_9 = 'C21') * v_dist_9 +
	    (integer)(v_aacd_10 = 'C21') * v_dist_10 +
	    (integer)(v_aacd_11 = 'C21') * v_dist_11 +
	    (integer)(v_aacd_12 = 'C21') * v_dist_12 +
	    (integer)(v_aacd_13 = 'C21') * v_dist_13 +
	    (integer)(v_aacd_14 = 'C21') * v_dist_14 +
	    (integer)(v_aacd_15 = 'C21') * v_dist_15 +
	    (integer)(v_aacd_16 = 'C21') * v_dist_16 +
	    (integer)(v_aacd_17 = 'C21') * v_dist_17 +
	    (integer)(v_aacd_18 = 'C21') * v_dist_18 +
	    (integer)(v_aacd_19 = 'C21') * v_dist_19 +
	    (integer)(v_aacd_20 = 'C21') * v_dist_20;
	
	v_rcvaluel80 := (integer)(v_aacd_0 = 'L80') * v_dist_0 +
	    (integer)(v_aacd_1 = 'L80') * v_dist_1 +
	    (integer)(v_aacd_2 = 'L80') * v_dist_2 +
	    (integer)(v_aacd_3 = 'L80') * v_dist_3 +
	    (integer)(v_aacd_4 = 'L80') * v_dist_4 +
	    (integer)(v_aacd_5 = 'L80') * v_dist_5 +
	    (integer)(v_aacd_6 = 'L80') * v_dist_6 +
	    (integer)(v_aacd_7 = 'L80') * v_dist_7 +
	    (integer)(v_aacd_8 = 'L80') * v_dist_8 +
	    (integer)(v_aacd_9 = 'L80') * v_dist_9 +
	    (integer)(v_aacd_10 = 'L80') * v_dist_10 +
	    (integer)(v_aacd_11 = 'L80') * v_dist_11 +
	    (integer)(v_aacd_12 = 'L80') * v_dist_12 +
	    (integer)(v_aacd_13 = 'L80') * v_dist_13 +
	    (integer)(v_aacd_14 = 'L80') * v_dist_14 +
	    (integer)(v_aacd_15 = 'L80') * v_dist_15 +
	    (integer)(v_aacd_16 = 'L80') * v_dist_16 +
	    (integer)(v_aacd_17 = 'L80') * v_dist_17 +
	    (integer)(v_aacd_18 = 'L80') * v_dist_18 +
	    (integer)(v_aacd_19 = 'L80') * v_dist_19 +
	    (integer)(v_aacd_20 = 'L80') * v_dist_20;
	
	v_rcvaluea50 := (integer)(v_aacd_0 = 'A50') * v_dist_0 +
	    (integer)(v_aacd_1 = 'A50') * v_dist_1 +
	    (integer)(v_aacd_2 = 'A50') * v_dist_2 +
	    (integer)(v_aacd_3 = 'A50') * v_dist_3 +
	    (integer)(v_aacd_4 = 'A50') * v_dist_4 +
	    (integer)(v_aacd_5 = 'A50') * v_dist_5 +
	    (integer)(v_aacd_6 = 'A50') * v_dist_6 +
	    (integer)(v_aacd_7 = 'A50') * v_dist_7 +
	    (integer)(v_aacd_8 = 'A50') * v_dist_8 +
	    (integer)(v_aacd_9 = 'A50') * v_dist_9 +
	    (integer)(v_aacd_10 = 'A50') * v_dist_10 +
	    (integer)(v_aacd_11 = 'A50') * v_dist_11 +
	    (integer)(v_aacd_12 = 'A50') * v_dist_12 +
	    (integer)(v_aacd_13 = 'A50') * v_dist_13 +
	    (integer)(v_aacd_14 = 'A50') * v_dist_14 +
	    (integer)(v_aacd_15 = 'A50') * v_dist_15 +
	    (integer)(v_aacd_16 = 'A50') * v_dist_16 +
	    (integer)(v_aacd_17 = 'A50') * v_dist_17 +
	    (integer)(v_aacd_18 = 'A50') * v_dist_18 +
	    (integer)(v_aacd_19 = 'A50') * v_dist_19 +
	    (integer)(v_aacd_20 = 'A50') * v_dist_20;
	
	v_rcvaluei60 := (integer)(v_aacd_0 = 'I60') * v_dist_0 +
	    (integer)(v_aacd_1 = 'I60') * v_dist_1 +
	    (integer)(v_aacd_2 = 'I60') * v_dist_2 +
	    (integer)(v_aacd_3 = 'I60') * v_dist_3 +
	    (integer)(v_aacd_4 = 'I60') * v_dist_4 +
	    (integer)(v_aacd_5 = 'I60') * v_dist_5 +
	    (integer)(v_aacd_6 = 'I60') * v_dist_6 +
	    (integer)(v_aacd_7 = 'I60') * v_dist_7 +
	    (integer)(v_aacd_8 = 'I60') * v_dist_8 +
	    (integer)(v_aacd_9 = 'I60') * v_dist_9 +
	    (integer)(v_aacd_10 = 'I60') * v_dist_10 +
	    (integer)(v_aacd_11 = 'I60') * v_dist_11 +
	    (integer)(v_aacd_12 = 'I60') * v_dist_12 +
	    (integer)(v_aacd_13 = 'I60') * v_dist_13 +
	    (integer)(v_aacd_14 = 'I60') * v_dist_14 +
	    (integer)(v_aacd_15 = 'I60') * v_dist_15 +
	    (integer)(v_aacd_16 = 'I60') * v_dist_16 +
	    (integer)(v_aacd_17 = 'I60') * v_dist_17 +
	    (integer)(v_aacd_18 = 'I60') * v_dist_18 +
	    (integer)(v_aacd_19 = 'I60') * v_dist_19 +
	    (integer)(v_aacd_20 = 'I60') * v_dist_20;
	
	v_rcvalueS65 := (integer)(v_aacd_0 = 'S65') * v_dist_0 +
	    (integer)(v_aacd_1 = 'S65') * v_dist_1 +
	    (integer)(v_aacd_2 = 'S65') * v_dist_2 +
	    (integer)(v_aacd_3 = 'S65') * v_dist_3 +
	    (integer)(v_aacd_4 = 'S65') * v_dist_4 +
	    (integer)(v_aacd_5 = 'S65') * v_dist_5 +
	    (integer)(v_aacd_6 = 'S65') * v_dist_6 +
	    (integer)(v_aacd_7 = 'S65') * v_dist_7 +
	    (integer)(v_aacd_8 = 'S65') * v_dist_8 +
	    (integer)(v_aacd_9 = 'S65') * v_dist_9 +
	    (integer)(v_aacd_10 = 'S65') * v_dist_10 +
	    (integer)(v_aacd_11 = 'S65') * v_dist_11 +
	    (integer)(v_aacd_12 = 'S65') * v_dist_12 +
	    (integer)(v_aacd_13 = 'S65') * v_dist_13 +
	    (integer)(v_aacd_14 = 'S65') * v_dist_14 +
	    (integer)(v_aacd_15 = 'S65') * v_dist_15 +
	    (integer)(v_aacd_16 = 'S65') * v_dist_16 +
	    (integer)(v_aacd_17 = 'S65') * v_dist_17 +
	    (integer)(v_aacd_18 = 'S65') * v_dist_18 +
	    (integer)(v_aacd_19 = 'S65') * v_dist_19 +
	    (integer)(v_aacd_20 = 'S65') * v_dist_20;
	
	v_rcvaluep85 := (integer)(v_aacd_0 = 'P85') * v_dist_0 +
	    (integer)(v_aacd_1 = 'P85') * v_dist_1 +
	    (integer)(v_aacd_2 = 'P85') * v_dist_2 +
	    (integer)(v_aacd_3 = 'P85') * v_dist_3 +
	    (integer)(v_aacd_4 = 'P85') * v_dist_4 +
	    (integer)(v_aacd_5 = 'P85') * v_dist_5 +
	    (integer)(v_aacd_6 = 'P85') * v_dist_6 +
	    (integer)(v_aacd_7 = 'P85') * v_dist_7 +
	    (integer)(v_aacd_8 = 'P85') * v_dist_8 +
	    (integer)(v_aacd_9 = 'P85') * v_dist_9 +
	    (integer)(v_aacd_10 = 'P85') * v_dist_10 +
	    (integer)(v_aacd_11 = 'P85') * v_dist_11 +
	    (integer)(v_aacd_12 = 'P85') * v_dist_12 +
	    (integer)(v_aacd_13 = 'P85') * v_dist_13 +
	    (integer)(v_aacd_14 = 'P85') * v_dist_14 +
	    (integer)(v_aacd_15 = 'P85') * v_dist_15 +
	    (integer)(v_aacd_16 = 'P85') * v_dist_16 +
	    (integer)(v_aacd_17 = 'P85') * v_dist_17 +
	    (integer)(v_aacd_18 = 'P85') * v_dist_18 +
	    (integer)(v_aacd_19 = 'P85') * v_dist_19 +
	    (integer)(v_aacd_20 = 'P85') * v_dist_20;
	
	v_rcvalued30 := (integer)(v_aacd_0 = 'D30') * v_dist_0 +
	    (integer)(v_aacd_1 = 'D30') * v_dist_1 +
	    (integer)(v_aacd_2 = 'D30') * v_dist_2 +
	    (integer)(v_aacd_3 = 'D30') * v_dist_3 +
	    (integer)(v_aacd_4 = 'D30') * v_dist_4 +
	    (integer)(v_aacd_5 = 'D30') * v_dist_5 +
	    (integer)(v_aacd_6 = 'D30') * v_dist_6 +
	    (integer)(v_aacd_7 = 'D30') * v_dist_7 +
	    (integer)(v_aacd_8 = 'D30') * v_dist_8 +
	    (integer)(v_aacd_9 = 'D30') * v_dist_9 +
	    (integer)(v_aacd_10 = 'D30') * v_dist_10 +
	    (integer)(v_aacd_11 = 'D30') * v_dist_11 +
	    (integer)(v_aacd_12 = 'D30') * v_dist_12 +
	    (integer)(v_aacd_13 = 'D30') * v_dist_13 +
	    (integer)(v_aacd_14 = 'D30') * v_dist_14 +
	    (integer)(v_aacd_15 = 'D30') * v_dist_15 +
	    (integer)(v_aacd_16 = 'D30') * v_dist_16 +
	    (integer)(v_aacd_17 = 'D30') * v_dist_17 +
	    (integer)(v_aacd_18 = 'D30') * v_dist_18 +
	    (integer)(v_aacd_19 = 'D30') * v_dist_19 +
	    (integer)(v_aacd_20 = 'D30') * v_dist_20;
	
	
v_rcvalueA42 := (integer)(v_aacd_0 = 'A42') * v_dist_0 +
         (integer)(v_aacd_1 = 'A42') * v_dist_1 +
         (integer)(v_aacd_2 = 'A42') * v_dist_2 +
         (integer)(v_aacd_3 = 'A42') * v_dist_3 +
         (integer)(v_aacd_4 = 'A42') * v_dist_4 +
         (integer)(v_aacd_5 = 'A42') * v_dist_5 +
         (integer)(v_aacd_6 = 'A42') * v_dist_6 +
         (integer)(v_aacd_7 = 'A42') * v_dist_7 +
         (integer)(v_aacd_8 = 'A42') * v_dist_8 +
         (integer)(v_aacd_9 = 'A42') * v_dist_9 +
         (integer)(v_aacd_10 = 'A42') * v_dist_10 +
         (integer)(v_aacd_11 = 'A42') * v_dist_11 +
         (integer)(v_aacd_12 = 'A42') * v_dist_12 +
         (integer)(v_aacd_13 = 'A42') * v_dist_13 +
         (integer)(v_aacd_14 = 'A42') * v_dist_14 +
         (integer)(v_aacd_15 = 'A42') * v_dist_15 +
         (integer)(v_aacd_16 = 'A42') * v_dist_16 +
         (integer)(v_aacd_17 = 'A42') * v_dist_17 +
         (integer)(v_aacd_18 = 'A42') * v_dist_18 +
         (integer)(v_aacd_19 = 'A42') * v_dist_19 +
         (integer)(v_aacd_20 = 'A42') * v_dist_20;
	
	
	v_rcvaluea47 := (integer)(v_aacd_0 = 'A47') * v_dist_0 +
	    (integer)(v_aacd_1 = 'A47') * v_dist_1 +
	    (integer)(v_aacd_2 = 'A47') * v_dist_2 +
	    (integer)(v_aacd_3 = 'A47') * v_dist_3 +
	    (integer)(v_aacd_4 = 'A47') * v_dist_4 +
	    (integer)(v_aacd_5 = 'A47') * v_dist_5 +
	    (integer)(v_aacd_6 = 'A47') * v_dist_6 +
	    (integer)(v_aacd_7 = 'A47') * v_dist_7 +
	    (integer)(v_aacd_8 = 'A47') * v_dist_8 +
	    (integer)(v_aacd_9 = 'A47') * v_dist_9 +
	    (integer)(v_aacd_10 = 'A47') * v_dist_10 +
	    (integer)(v_aacd_11 = 'A47') * v_dist_11 +
	    (integer)(v_aacd_12 = 'A47') * v_dist_12 +
	    (integer)(v_aacd_13 = 'A47') * v_dist_13 +
	    (integer)(v_aacd_14 = 'A47') * v_dist_14 +
	    (integer)(v_aacd_15 = 'A47') * v_dist_15 +
	    (integer)(v_aacd_16 = 'A47') * v_dist_16 +
	    (integer)(v_aacd_17 = 'A47') * v_dist_17 +
	    (integer)(v_aacd_18 = 'A47') * v_dist_18 +
	    (integer)(v_aacd_19 = 'A47') * v_dist_19 +
	    (integer)(v_aacd_20 = 'A47') * v_dist_20;
	
	v_rcvaluea44 := (integer)(v_aacd_0 = 'A44') * v_dist_0 +
	    (integer)(v_aacd_1 = 'A44') * v_dist_1 +
	    (integer)(v_aacd_2 = 'A44') * v_dist_2 +
	    (integer)(v_aacd_3 = 'A44') * v_dist_3 +
	    (integer)(v_aacd_4 = 'A44') * v_dist_4 +
	    (integer)(v_aacd_5 = 'A44') * v_dist_5 +
	    (integer)(v_aacd_6 = 'A44') * v_dist_6 +
	    (integer)(v_aacd_7 = 'A44') * v_dist_7 +
	    (integer)(v_aacd_8 = 'A44') * v_dist_8 +
	    (integer)(v_aacd_9 = 'A44') * v_dist_9 +
	    (integer)(v_aacd_10 = 'A44') * v_dist_10 +
	    (integer)(v_aacd_11 = 'A44') * v_dist_11 +
	    (integer)(v_aacd_12 = 'A44') * v_dist_12 +
	    (integer)(v_aacd_13 = 'A44') * v_dist_13 +
	    (integer)(v_aacd_14 = 'A44') * v_dist_14 +
	    (integer)(v_aacd_15 = 'A44') * v_dist_15 +
	    (integer)(v_aacd_16 = 'A44') * v_dist_16 +
	    (integer)(v_aacd_17 = 'A44') * v_dist_17 +
	    (integer)(v_aacd_18 = 'A44') * v_dist_18 +
	    (integer)(v_aacd_19 = 'A44') * v_dist_19 +
	    (integer)(v_aacd_20 = 'A44') * v_dist_20;
	
	v_rcvaluef04 := (integer)(v_aacd_0 = 'F04') * v_dist_0 +
	    (integer)(v_aacd_1 = 'F04') * v_dist_1 +
	    (integer)(v_aacd_2 = 'F04') * v_dist_2 +
	    (integer)(v_aacd_3 = 'F04') * v_dist_3 +
	    (integer)(v_aacd_4 = 'F04') * v_dist_4 +
	    (integer)(v_aacd_5 = 'F04') * v_dist_5 +
	    (integer)(v_aacd_6 = 'F04') * v_dist_6 +
	    (integer)(v_aacd_7 = 'F04') * v_dist_7 +
	    (integer)(v_aacd_8 = 'F04') * v_dist_8 +
	    (integer)(v_aacd_9 = 'F04') * v_dist_9 +
	    (integer)(v_aacd_10 = 'F04') * v_dist_10 +
	    (integer)(v_aacd_11 = 'F04') * v_dist_11 +
	    (integer)(v_aacd_12 = 'F04') * v_dist_12 +
	    (integer)(v_aacd_13 = 'F04') * v_dist_13 +
	    (integer)(v_aacd_14 = 'F04') * v_dist_14 +
	    (integer)(v_aacd_15 = 'F04') * v_dist_15 +
	    (integer)(v_aacd_16 = 'F04') * v_dist_16 +
	    (integer)(v_aacd_17 = 'F04') * v_dist_17 +
	    (integer)(v_aacd_18 = 'F04') * v_dist_18 +
	    (integer)(v_aacd_19 = 'F04') * v_dist_19 +
	    (integer)(v_aacd_20 = 'F04') * v_dist_20;
	
	v_rcvaluef01 := (integer)(v_aacd_0 = 'F01') * v_dist_0 +
	    (integer)(v_aacd_1 = 'F01') * v_dist_1 +
	    (integer)(v_aacd_2 = 'F01') * v_dist_2 +
	    (integer)(v_aacd_3 = 'F01') * v_dist_3 +
	    (integer)(v_aacd_4 = 'F01') * v_dist_4 +
	    (integer)(v_aacd_5 = 'F01') * v_dist_5 +
	    (integer)(v_aacd_6 = 'F01') * v_dist_6 +
	    (integer)(v_aacd_7 = 'F01') * v_dist_7 +
	    (integer)(v_aacd_8 = 'F01') * v_dist_8 +
	    (integer)(v_aacd_9 = 'F01') * v_dist_9 +
	    (integer)(v_aacd_10 = 'F01') * v_dist_10 +
	    (integer)(v_aacd_11 = 'F01') * v_dist_11 +
	    (integer)(v_aacd_12 = 'F01') * v_dist_12 +
	    (integer)(v_aacd_13 = 'F01') * v_dist_13 +
	    (integer)(v_aacd_14 = 'F01') * v_dist_14 +
	    (integer)(v_aacd_15 = 'F01') * v_dist_15 +
	    (integer)(v_aacd_16 = 'F01') * v_dist_16 +
	    (integer)(v_aacd_17 = 'F01') * v_dist_17 +
	    (integer)(v_aacd_18 = 'F01') * v_dist_18 +
	    (integer)(v_aacd_19 = 'F01') * v_dist_19 +
	    (integer)(v_aacd_20 = 'F01') * v_dist_20;
	
	v_rcvaluef00 := (integer)(v_aacd_0 = 'F00') * v_dist_0 +
	    (integer)(v_aacd_1 = 'F00') * v_dist_1 +
	    (integer)(v_aacd_2 = 'F00') * v_dist_2 +
	    (integer)(v_aacd_3 = 'F00') * v_dist_3 +
	    (integer)(v_aacd_4 = 'F00') * v_dist_4 +
	    (integer)(v_aacd_5 = 'F00') * v_dist_5 +
	    (integer)(v_aacd_6 = 'F00') * v_dist_6 +
	    (integer)(v_aacd_7 = 'F00') * v_dist_7 +
	    (integer)(v_aacd_8 = 'F00') * v_dist_8 +
	    (integer)(v_aacd_9 = 'F00') * v_dist_9 +
	    (integer)(v_aacd_10 = 'F00') * v_dist_10 +
	    (integer)(v_aacd_11 = 'F00') * v_dist_11 +
	    (integer)(v_aacd_12 = 'F00') * v_dist_12 +
	    (integer)(v_aacd_13 = 'F00') * v_dist_13 +
	    (integer)(v_aacd_14 = 'F00') * v_dist_14 +
	    (integer)(v_aacd_15 = 'F00') * v_dist_15 +
	    (integer)(v_aacd_16 = 'F00') * v_dist_16 +
	    (integer)(v_aacd_17 = 'F00') * v_dist_17 +
	    (integer)(v_aacd_18 = 'F00') * v_dist_18 +
	    (integer)(v_aacd_19 = 'F00') * v_dist_19 +
	    (integer)(v_aacd_20 = 'F00') * v_dist_20;
	
	v_rcvaluea41 := (integer)(v_aacd_0 = 'A41') * v_dist_0 +
	    (integer)(v_aacd_1 = 'A41') * v_dist_1 +
	    (integer)(v_aacd_2 = 'A41') * v_dist_2 +
	    (integer)(v_aacd_3 = 'A41') * v_dist_3 +
	    (integer)(v_aacd_4 = 'A41') * v_dist_4 +
	    (integer)(v_aacd_5 = 'A41') * v_dist_5 +
	    (integer)(v_aacd_6 = 'A41') * v_dist_6 +
	    (integer)(v_aacd_7 = 'A41') * v_dist_7 +
	    (integer)(v_aacd_8 = 'A41') * v_dist_8 +
	    (integer)(v_aacd_9 = 'A41') * v_dist_9 +
	    (integer)(v_aacd_10 = 'A41') * v_dist_10 +
	    (integer)(v_aacd_11 = 'A41') * v_dist_11 +
	    (integer)(v_aacd_12 = 'A41') * v_dist_12 +
	    (integer)(v_aacd_13 = 'A41') * v_dist_13 +
	    (integer)(v_aacd_14 = 'A41') * v_dist_14 +
	    (integer)(v_aacd_15 = 'A41') * v_dist_15 +
	    (integer)(v_aacd_16 = 'A41') * v_dist_16 +
	    (integer)(v_aacd_17 = 'A41') * v_dist_17 +
	    (integer)(v_aacd_18 = 'A41') * v_dist_18 +
	    (integer)(v_aacd_19 = 'A41') * v_dist_19 +
	    (integer)(v_aacd_20 = 'A41') * v_dist_20;
	
	v_rcvaluee55 := (integer)(v_aacd_0 = 'E55') * v_dist_0 +
	    (integer)(v_aacd_1 = 'E55') * v_dist_1 +
	    (integer)(v_aacd_2 = 'E55') * v_dist_2 +
	    (integer)(v_aacd_3 = 'E55') * v_dist_3 +
	    (integer)(v_aacd_4 = 'E55') * v_dist_4 +
	    (integer)(v_aacd_5 = 'E55') * v_dist_5 +
	    (integer)(v_aacd_6 = 'E55') * v_dist_6 +
	    (integer)(v_aacd_7 = 'E55') * v_dist_7 +
	    (integer)(v_aacd_8 = 'E55') * v_dist_8 +
	    (integer)(v_aacd_9 = 'E55') * v_dist_9 +
	    (integer)(v_aacd_10 = 'E55') * v_dist_10 +
	    (integer)(v_aacd_11 = 'E55') * v_dist_11 +
	    (integer)(v_aacd_12 = 'E55') * v_dist_12 +
	    (integer)(v_aacd_13 = 'E55') * v_dist_13 +
	    (integer)(v_aacd_14 = 'E55') * v_dist_14 +
	    (integer)(v_aacd_15 = 'E55') * v_dist_15 +
	    (integer)(v_aacd_16 = 'E55') * v_dist_16 +
	    (integer)(v_aacd_17 = 'E55') * v_dist_17 +
	    (integer)(v_aacd_18 = 'E55') * v_dist_18 +
	    (integer)(v_aacd_19 = 'E55') * v_dist_19 +
	    (integer)(v_aacd_20 = 'E55') * v_dist_20;
	
	v_rcvaluec12 := (integer)(v_aacd_0 = 'C12') * v_dist_0 +
	    (integer)(v_aacd_1 = 'C12') * v_dist_1 +
	    (integer)(v_aacd_2 = 'C12') * v_dist_2 +
	    (integer)(v_aacd_3 = 'C12') * v_dist_3 +
	    (integer)(v_aacd_4 = 'C12') * v_dist_4 +
	    (integer)(v_aacd_5 = 'C12') * v_dist_5 +
	    (integer)(v_aacd_6 = 'C12') * v_dist_6 +
	    (integer)(v_aacd_7 = 'C12') * v_dist_7 +
	    (integer)(v_aacd_8 = 'C12') * v_dist_8 +
	    (integer)(v_aacd_9 = 'C12') * v_dist_9 +
	    (integer)(v_aacd_10 = 'C12') * v_dist_10 +
	    (integer)(v_aacd_11 = 'C12') * v_dist_11 +
	    (integer)(v_aacd_12 = 'C12') * v_dist_12 +
	    (integer)(v_aacd_13 = 'C12') * v_dist_13 +
	    (integer)(v_aacd_14 = 'C12') * v_dist_14 +
	    (integer)(v_aacd_15 = 'C12') * v_dist_15 +
	    (integer)(v_aacd_16 = 'C12') * v_dist_16 +
	    (integer)(v_aacd_17 = 'C12') * v_dist_17 +
	    (integer)(v_aacd_18 = 'C12') * v_dist_18 +
	    (integer)(v_aacd_19 = 'C12') * v_dist_19 +
	    (integer)(v_aacd_20 = 'C12') * v_dist_20;
	
	v_rcvaluee57 := (integer)(v_aacd_0 = 'E57') * v_dist_0 +
	    (integer)(v_aacd_1 = 'E57') * v_dist_1 +
	    (integer)(v_aacd_2 = 'E57') * v_dist_2 +
	    (integer)(v_aacd_3 = 'E57') * v_dist_3 +
	    (integer)(v_aacd_4 = 'E57') * v_dist_4 +
	    (integer)(v_aacd_5 = 'E57') * v_dist_5 +
	    (integer)(v_aacd_6 = 'E57') * v_dist_6 +
	    (integer)(v_aacd_7 = 'E57') * v_dist_7 +
	    (integer)(v_aacd_8 = 'E57') * v_dist_8 +
	    (integer)(v_aacd_9 = 'E57') * v_dist_9 +
	    (integer)(v_aacd_10 = 'E57') * v_dist_10 +
	    (integer)(v_aacd_11 = 'E57') * v_dist_11 +
	    (integer)(v_aacd_12 = 'E57') * v_dist_12 +
	    (integer)(v_aacd_13 = 'E57') * v_dist_13 +
	    (integer)(v_aacd_14 = 'E57') * v_dist_14 +
	    (integer)(v_aacd_15 = 'E57') * v_dist_15 +
	    (integer)(v_aacd_16 = 'E57') * v_dist_16 +
	    (integer)(v_aacd_17 = 'E57') * v_dist_17 +
	    (integer)(v_aacd_18 = 'E57') * v_dist_18 +
	    (integer)(v_aacd_19 = 'E57') * v_dist_19 +
	    (integer)(v_aacd_20 = 'E57') * v_dist_20;
	
	v_rcvalues66 := (integer)(v_aacd_0 = 'S66') * v_dist_0 +
	    (integer)(v_aacd_1 = 'S66') * v_dist_1 +
	    (integer)(v_aacd_2 = 'S66') * v_dist_2 +
	    (integer)(v_aacd_3 = 'S66') * v_dist_3 +
	    (integer)(v_aacd_4 = 'S66') * v_dist_4 +
	    (integer)(v_aacd_5 = 'S66') * v_dist_5 +
	    (integer)(v_aacd_6 = 'S66') * v_dist_6 +
	    (integer)(v_aacd_7 = 'S66') * v_dist_7 +
	    (integer)(v_aacd_8 = 'S66') * v_dist_8 +
	    (integer)(v_aacd_9 = 'S66') * v_dist_9 +
	    (integer)(v_aacd_10 = 'S66') * v_dist_10 +
	    (integer)(v_aacd_11 = 'S66') * v_dist_11 +
	    (integer)(v_aacd_12 = 'S66') * v_dist_12 +
	    (integer)(v_aacd_13 = 'S66') * v_dist_13 +
	    (integer)(v_aacd_14 = 'S66') * v_dist_14 +
	    (integer)(v_aacd_15 = 'S66') * v_dist_15 +
	    (integer)(v_aacd_16 = 'S66') * v_dist_16 +
	    (integer)(v_aacd_17 = 'S66') * v_dist_17 +
	    (integer)(v_aacd_18 = 'S66') * v_dist_18 +
	    (integer)(v_aacd_19 = 'S66') * v_dist_19 +
	    (integer)(v_aacd_20 = 'S66') * v_dist_20;
	
	v_rcvaluel73 := (integer)(v_aacd_0 = 'L73') * v_dist_0 +
	    (integer)(v_aacd_1 = 'L73') * v_dist_1 +
	    (integer)(v_aacd_2 = 'L73') * v_dist_2 +
	    (integer)(v_aacd_3 = 'L73') * v_dist_3 +
	    (integer)(v_aacd_4 = 'L73') * v_dist_4 +
	    (integer)(v_aacd_5 = 'L73') * v_dist_5 +
	    (integer)(v_aacd_6 = 'L73') * v_dist_6 +
	    (integer)(v_aacd_7 = 'L73') * v_dist_7 +
	    (integer)(v_aacd_8 = 'L73') * v_dist_8 +
	    (integer)(v_aacd_9 = 'L73') * v_dist_9 +
	    (integer)(v_aacd_10 = 'L73') * v_dist_10 +
	    (integer)(v_aacd_11 = 'L73') * v_dist_11 +
	    (integer)(v_aacd_12 = 'L73') * v_dist_12 +
	    (integer)(v_aacd_13 = 'L73') * v_dist_13 +
	    (integer)(v_aacd_14 = 'L73') * v_dist_14 +
	    (integer)(v_aacd_15 = 'L73') * v_dist_15 +
	    (integer)(v_aacd_16 = 'L73') * v_dist_16 +
	    (integer)(v_aacd_17 = 'L73') * v_dist_17 +
	    (integer)(v_aacd_18 = 'L73') * v_dist_18 +
	    (integer)(v_aacd_19 = 'L73') * v_dist_19 +
	    (integer)(v_aacd_20 = 'L73') * v_dist_20;


//=========================================================
//==  start calculating the RC values for derog segment   =
//=========================================================
	
	d_dist_22 := _ov_pts_lost_raw;
	
	d_aacd_22 := map(
	    ov_corrections => 'L73',
	   	ov_ssnprior    => 'S65',
			                  '');
	
	d_rcvaluec13 := (integer)(d_aacd_0 = 'C13') * d_dist_0 +
	    (integer)(d_aacd_1 = 'C13') * d_dist_1 +
	    (integer)(d_aacd_2 = 'C13') * d_dist_2 +
	    (integer)(d_aacd_3 = 'C13') * d_dist_3 +
	    (integer)(d_aacd_4 = 'C13') * d_dist_4 +
	    (integer)(d_aacd_5 = 'C13') * d_dist_5 +
	    (integer)(d_aacd_6 = 'C13') * d_dist_6 +
	    (integer)(d_aacd_7 = 'C13') * d_dist_7 +
	    (integer)(d_aacd_8 = 'C13') * d_dist_8 +
	    (integer)(d_aacd_9 = 'C13') * d_dist_9 +
	    (integer)(d_aacd_10 = 'C13') * d_dist_10 +
	    (integer)(d_aacd_11 = 'C13') * d_dist_11 +
	    (integer)(d_aacd_12 = 'C13') * d_dist_12 +
	    (integer)(d_aacd_13 = 'C13') * d_dist_13 +
	    (integer)(d_aacd_14 = 'C13') * d_dist_14 +
	    (integer)(d_aacd_15 = 'C13') * d_dist_15 +
	    (integer)(d_aacd_16 = 'C13') * d_dist_16 +
	    (integer)(d_aacd_17 = 'C13') * d_dist_17 +
	    (integer)(d_aacd_18 = 'C13') * d_dist_18 +
	    (integer)(d_aacd_19 = 'C13') * d_dist_19 +
	    (integer)(d_aacd_20 = 'C13') * d_dist_20 +
	    (integer)(d_aacd_21 = 'C13') * d_dist_21 +
	    (integer)(d_aacd_22 = 'C13') * d_dist_22;
	
	d_rcvaluec21 := (integer)(d_aacd_0 = 'C21') * d_dist_0 +
	    (integer)(d_aacd_1 = 'C21') * d_dist_1 +
	    (integer)(d_aacd_2 = 'C21') * d_dist_2 +
	    (integer)(d_aacd_3 = 'C21') * d_dist_3 +
	    (integer)(d_aacd_4 = 'C21') * d_dist_4 +
	    (integer)(d_aacd_5 = 'C21') * d_dist_5 +
	    (integer)(d_aacd_6 = 'C21') * d_dist_6 +
	    (integer)(d_aacd_7 = 'C21') * d_dist_7 +
	    (integer)(d_aacd_8 = 'C21') * d_dist_8 +
	    (integer)(d_aacd_9 = 'C21') * d_dist_9 +
	    (integer)(d_aacd_10 = 'C21') * d_dist_10 +
	    (integer)(d_aacd_11 = 'C21') * d_dist_11 +
	    (integer)(d_aacd_12 = 'C21') * d_dist_12 +
	    (integer)(d_aacd_13 = 'C21') * d_dist_13 +
	    (integer)(d_aacd_14 = 'C21') * d_dist_14 +
	    (integer)(d_aacd_15 = 'C21') * d_dist_15 +
	    (integer)(d_aacd_16 = 'C21') * d_dist_16 +
	    (integer)(d_aacd_17 = 'C21') * d_dist_17 +
	    (integer)(d_aacd_18 = 'C21') * d_dist_18 +
	    (integer)(d_aacd_19 = 'C21') * d_dist_19 +
	    (integer)(d_aacd_20 = 'C21') * d_dist_20 +
	    (integer)(d_aacd_21 = 'C21') * d_dist_21 +
	    (integer)(d_aacd_22 = 'C21') * d_dist_22;
	
	d_rcvaluel80 := (integer)(d_aacd_0 = 'L80') * d_dist_0 +
	    (integer)(d_aacd_1 = 'L80') * d_dist_1 +
	    (integer)(d_aacd_2 = 'L80') * d_dist_2 +
	    (integer)(d_aacd_3 = 'L80') * d_dist_3 +
	    (integer)(d_aacd_4 = 'L80') * d_dist_4 +
	    (integer)(d_aacd_5 = 'L80') * d_dist_5 +
	    (integer)(d_aacd_6 = 'L80') * d_dist_6 +
	    (integer)(d_aacd_7 = 'L80') * d_dist_7 +
	    (integer)(d_aacd_8 = 'L80') * d_dist_8 +
	    (integer)(d_aacd_9 = 'L80') * d_dist_9 +
	    (integer)(d_aacd_10 = 'L80') * d_dist_10 +
	    (integer)(d_aacd_11 = 'L80') * d_dist_11 +
	    (integer)(d_aacd_12 = 'L80') * d_dist_12 +
	    (integer)(d_aacd_13 = 'L80') * d_dist_13 +
	    (integer)(d_aacd_14 = 'L80') * d_dist_14 +
	    (integer)(d_aacd_15 = 'L80') * d_dist_15 +
	    (integer)(d_aacd_16 = 'L80') * d_dist_16 +
	    (integer)(d_aacd_17 = 'L80') * d_dist_17 +
	    (integer)(d_aacd_18 = 'L80') * d_dist_18 +
	    (integer)(d_aacd_19 = 'L80') * d_dist_19 +
	    (integer)(d_aacd_20 = 'L80') * d_dist_20 +
	    (integer)(d_aacd_21 = 'L80') * d_dist_21 +
	    (integer)(d_aacd_22 = 'L80') * d_dist_22;
	
	d_rcvaluel73 := (integer)(d_aacd_0 = 'L73') * d_dist_0 +
	    (integer)(d_aacd_1 = 'L73') * d_dist_1 +
	    (integer)(d_aacd_2 = 'L73') * d_dist_2 +
	    (integer)(d_aacd_3 = 'L73') * d_dist_3 +
	    (integer)(d_aacd_4 = 'L73') * d_dist_4 +
	    (integer)(d_aacd_5 = 'L73') * d_dist_5 +
	    (integer)(d_aacd_6 = 'L73') * d_dist_6 +
	    (integer)(d_aacd_7 = 'L73') * d_dist_7 +
	    (integer)(d_aacd_8 = 'L73') * d_dist_8 +
	    (integer)(d_aacd_9 = 'L73') * d_dist_9 +
	    (integer)(d_aacd_10 = 'L73') * d_dist_10 +
	    (integer)(d_aacd_11 = 'L73') * d_dist_11 +
	    (integer)(d_aacd_12 = 'L73') * d_dist_12 +
	    (integer)(d_aacd_13 = 'L73') * d_dist_13 +
	    (integer)(d_aacd_14 = 'L73') * d_dist_14 +
	    (integer)(d_aacd_15 = 'L73') * d_dist_15 +
	    (integer)(d_aacd_16 = 'L73') * d_dist_16 +
	    (integer)(d_aacd_17 = 'L73') * d_dist_17 +
	    (integer)(d_aacd_18 = 'L73') * d_dist_18 +
	    (integer)(d_aacd_19 = 'L73') * d_dist_19 +
	    (integer)(d_aacd_20 = 'L73') * d_dist_20 +
	    (integer)(d_aacd_21 = 'L73') * d_dist_21 +
	    (integer)(d_aacd_22 = 'L73') * d_dist_22;
	
	d_rcvalueS65 := (integer)(d_aacd_0 = 'S65') * d_dist_0 +
	    (integer)(d_aacd_1 = 'S65') * d_dist_1 +
	    (integer)(d_aacd_2 = 'S65') * d_dist_2 +
	    (integer)(d_aacd_3 = 'S65') * d_dist_3 +
	    (integer)(d_aacd_4 = 'S65') * d_dist_4 +
	    (integer)(d_aacd_5 = 'S65') * d_dist_5 +
	    (integer)(d_aacd_6 = 'S65') * d_dist_6 +
	    (integer)(d_aacd_7 = 'S65') * d_dist_7 +
	    (integer)(d_aacd_8 = 'S65') * d_dist_8 +
	    (integer)(d_aacd_9 = 'S65') * d_dist_9 +
	    (integer)(d_aacd_10 = 'S65') * d_dist_10 +
	    (integer)(d_aacd_11 = 'S65') * d_dist_11 +
	    (integer)(d_aacd_12 = 'S65') * d_dist_12 +
	    (integer)(d_aacd_13 = 'S65') * d_dist_13 +
	    (integer)(d_aacd_14 = 'S65') * d_dist_14 +
	    (integer)(d_aacd_15 = 'S65') * d_dist_15 +
	    (integer)(d_aacd_16 = 'S65') * d_dist_16 +
	    (integer)(d_aacd_17 = 'S65') * d_dist_17 +
	    (integer)(d_aacd_18 = 'S65') * d_dist_18 +
	    (integer)(d_aacd_19 = 'S65') * d_dist_19 +
	    (integer)(d_aacd_20 = 'S65') * d_dist_20 +
	    (integer)(d_aacd_21 = 'S65') * d_dist_21 +
	    (integer)(d_aacd_22 = 'S65') * d_dist_22;
	
	d_rcvaluep85 := (integer)(d_aacd_0 = 'P85') * d_dist_0 +
	    (integer)(d_aacd_1 = 'P85') * d_dist_1 +
	    (integer)(d_aacd_2 = 'P85') * d_dist_2 +
	    (integer)(d_aacd_3 = 'P85') * d_dist_3 +
	    (integer)(d_aacd_4 = 'P85') * d_dist_4 +
	    (integer)(d_aacd_5 = 'P85') * d_dist_5 +
	    (integer)(d_aacd_6 = 'P85') * d_dist_6 +
	    (integer)(d_aacd_7 = 'P85') * d_dist_7 +
	    (integer)(d_aacd_8 = 'P85') * d_dist_8 +
	    (integer)(d_aacd_9 = 'P85') * d_dist_9 +
	    (integer)(d_aacd_10 = 'P85') * d_dist_10 +
	    (integer)(d_aacd_11 = 'P85') * d_dist_11 +
	    (integer)(d_aacd_12 = 'P85') * d_dist_12 +
	    (integer)(d_aacd_13 = 'P85') * d_dist_13 +
	    (integer)(d_aacd_14 = 'P85') * d_dist_14 +
	    (integer)(d_aacd_15 = 'P85') * d_dist_15 +
	    (integer)(d_aacd_16 = 'P85') * d_dist_16 +
	    (integer)(d_aacd_17 = 'P85') * d_dist_17 +
	    (integer)(d_aacd_18 = 'P85') * d_dist_18 +
	    (integer)(d_aacd_19 = 'P85') * d_dist_19 +
	    (integer)(d_aacd_20 = 'P85') * d_dist_20 +
	    (integer)(d_aacd_21 = 'P85') * d_dist_21 +
	    (integer)(d_aacd_22 = 'P85') * d_dist_22;
	
	d_rcvalued30 := (integer)(d_aacd_0 = 'D30') * d_dist_0 +
	    (integer)(d_aacd_1 = 'D30') * d_dist_1 +
	    (integer)(d_aacd_2 = 'D30') * d_dist_2 +
	    (integer)(d_aacd_3 = 'D30') * d_dist_3 +
	    (integer)(d_aacd_4 = 'D30') * d_dist_4 +
	    (integer)(d_aacd_5 = 'D30') * d_dist_5 +
	    (integer)(d_aacd_6 = 'D30') * d_dist_6 +
	    (integer)(d_aacd_7 = 'D30') * d_dist_7 +
	    (integer)(d_aacd_8 = 'D30') * d_dist_8 +
	    (integer)(d_aacd_9 = 'D30') * d_dist_9 +
	    (integer)(d_aacd_10 = 'D30') * d_dist_10 +
	    (integer)(d_aacd_11 = 'D30') * d_dist_11 +
	    (integer)(d_aacd_12 = 'D30') * d_dist_12 +
	    (integer)(d_aacd_13 = 'D30') * d_dist_13 +
	    (integer)(d_aacd_14 = 'D30') * d_dist_14 +
	    (integer)(d_aacd_15 = 'D30') * d_dist_15 +
	    (integer)(d_aacd_16 = 'D30') * d_dist_16 +
	    (integer)(d_aacd_17 = 'D30') * d_dist_17 +
	    (integer)(d_aacd_18 = 'D30') * d_dist_18 +
	    (integer)(d_aacd_19 = 'D30') * d_dist_19 +
	    (integer)(d_aacd_20 = 'D30') * d_dist_20 +
	    (integer)(d_aacd_21 = 'D30') * d_dist_21 +
	    (integer)(d_aacd_22 = 'D30') * d_dist_22;
	
	d_rcvaluea50 := (integer)(d_aacd_0 = 'A50') * d_dist_0 +
	    (integer)(d_aacd_1 = 'A50') * d_dist_1 +
	    (integer)(d_aacd_2 = 'A50') * d_dist_2 +
	    (integer)(d_aacd_3 = 'A50') * d_dist_3 +
	    (integer)(d_aacd_4 = 'A50') * d_dist_4 +
	    (integer)(d_aacd_5 = 'A50') * d_dist_5 +
	    (integer)(d_aacd_6 = 'A50') * d_dist_6 +
	    (integer)(d_aacd_7 = 'A50') * d_dist_7 +
	    (integer)(d_aacd_8 = 'A50') * d_dist_8 +
	    (integer)(d_aacd_9 = 'A50') * d_dist_9 +
	    (integer)(d_aacd_10 = 'A50') * d_dist_10 +
	    (integer)(d_aacd_11 = 'A50') * d_dist_11 +
	    (integer)(d_aacd_12 = 'A50') * d_dist_12 +
	    (integer)(d_aacd_13 = 'A50') * d_dist_13 +
	    (integer)(d_aacd_14 = 'A50') * d_dist_14 +
	    (integer)(d_aacd_15 = 'A50') * d_dist_15 +
	    (integer)(d_aacd_16 = 'A50') * d_dist_16 +
	    (integer)(d_aacd_17 = 'A50') * d_dist_17 +
	    (integer)(d_aacd_18 = 'A50') * d_dist_18 +
	    (integer)(d_aacd_19 = 'A50') * d_dist_19 +
	    (integer)(d_aacd_20 = 'A50') * d_dist_20 +
	    (integer)(d_aacd_21 = 'A50') * d_dist_21 +
	    (integer)(d_aacd_22 = 'A50') * d_dist_22;
	
	d_rcvaluea44 := (integer)(d_aacd_0 = 'A44') * d_dist_0 +
	    (integer)(d_aacd_1 = 'A44') * d_dist_1 +
	    (integer)(d_aacd_2 = 'A44') * d_dist_2 +
	    (integer)(d_aacd_3 = 'A44') * d_dist_3 +
	    (integer)(d_aacd_4 = 'A44') * d_dist_4 +
	    (integer)(d_aacd_5 = 'A44') * d_dist_5 +
	    (integer)(d_aacd_6 = 'A44') * d_dist_6 +
	    (integer)(d_aacd_7 = 'A44') * d_dist_7 +
	    (integer)(d_aacd_8 = 'A44') * d_dist_8 +
	    (integer)(d_aacd_9 = 'A44') * d_dist_9 +
	    (integer)(d_aacd_10 = 'A44') * d_dist_10 +
	    (integer)(d_aacd_11 = 'A44') * d_dist_11 +
	    (integer)(d_aacd_12 = 'A44') * d_dist_12 +
	    (integer)(d_aacd_13 = 'A44') * d_dist_13 +
	    (integer)(d_aacd_14 = 'A44') * d_dist_14 +
	    (integer)(d_aacd_15 = 'A44') * d_dist_15 +
	    (integer)(d_aacd_16 = 'A44') * d_dist_16 +
	    (integer)(d_aacd_17 = 'A44') * d_dist_17 +
	    (integer)(d_aacd_18 = 'A44') * d_dist_18 +
	    (integer)(d_aacd_19 = 'A44') * d_dist_19 +
	    (integer)(d_aacd_20 = 'A44') * d_dist_20 +
	    (integer)(d_aacd_21 = 'A44') * d_dist_21 +
	    (integer)(d_aacd_22 = 'A44') * d_dist_22;
	
	d_rcvaluei60 := (integer)(d_aacd_0 = 'I60') * d_dist_0 +
	    (integer)(d_aacd_1 = 'I60') * d_dist_1 +
	    (integer)(d_aacd_2 = 'I60') * d_dist_2 +
	    (integer)(d_aacd_3 = 'I60') * d_dist_3 +
	    (integer)(d_aacd_4 = 'I60') * d_dist_4 +
	    (integer)(d_aacd_5 = 'I60') * d_dist_5 +
	    (integer)(d_aacd_6 = 'I60') * d_dist_6 +
	    (integer)(d_aacd_7 = 'I60') * d_dist_7 +
	    (integer)(d_aacd_8 = 'I60') * d_dist_8 +
	    (integer)(d_aacd_9 = 'I60') * d_dist_9 +
	    (integer)(d_aacd_10 = 'I60') * d_dist_10 +
	    (integer)(d_aacd_11 = 'I60') * d_dist_11 +
	    (integer)(d_aacd_12 = 'I60') * d_dist_12 +
	    (integer)(d_aacd_13 = 'I60') * d_dist_13 +
	    (integer)(d_aacd_14 = 'I60') * d_dist_14 +
	    (integer)(d_aacd_15 = 'I60') * d_dist_15 +
	    (integer)(d_aacd_16 = 'I60') * d_dist_16 +
	    (integer)(d_aacd_17 = 'I60') * d_dist_17 +
	    (integer)(d_aacd_18 = 'I60') * d_dist_18 +
	    (integer)(d_aacd_19 = 'I60') * d_dist_19 +
	    (integer)(d_aacd_20 = 'I60') * d_dist_20 +
	    (integer)(d_aacd_21 = 'I60') * d_dist_21 +
	    (integer)(d_aacd_22 = 'I60') * d_dist_22;
	
	d_rcvaluef00 := (integer)(d_aacd_0 = 'F00') * d_dist_0 +
	    (integer)(d_aacd_1 = 'F00') * d_dist_1 +
	    (integer)(d_aacd_2 = 'F00') * d_dist_2 +
	    (integer)(d_aacd_3 = 'F00') * d_dist_3 +
	    (integer)(d_aacd_4 = 'F00') * d_dist_4 +
	    (integer)(d_aacd_5 = 'F00') * d_dist_5 +
	    (integer)(d_aacd_6 = 'F00') * d_dist_6 +
	    (integer)(d_aacd_7 = 'F00') * d_dist_7 +
	    (integer)(d_aacd_8 = 'F00') * d_dist_8 +
	    (integer)(d_aacd_9 = 'F00') * d_dist_9 +
	    (integer)(d_aacd_10 = 'F00') * d_dist_10 +
	    (integer)(d_aacd_11 = 'F00') * d_dist_11 +
	    (integer)(d_aacd_12 = 'F00') * d_dist_12 +
	    (integer)(d_aacd_13 = 'F00') * d_dist_13 +
	    (integer)(d_aacd_14 = 'F00') * d_dist_14 +
	    (integer)(d_aacd_15 = 'F00') * d_dist_15 +
	    (integer)(d_aacd_16 = 'F00') * d_dist_16 +
	    (integer)(d_aacd_17 = 'F00') * d_dist_17 +
	    (integer)(d_aacd_18 = 'F00') * d_dist_18 +
	    (integer)(d_aacd_19 = 'F00') * d_dist_19 +
	    (integer)(d_aacd_20 = 'F00') * d_dist_20 +
	    (integer)(d_aacd_21 = 'F00') * d_dist_21 +
	    (integer)(d_aacd_22 = 'F00') * d_dist_22;
	
	d_rcvaluef03 := (integer)(d_aacd_0 = 'F03') * d_dist_0 +
	    (integer)(d_aacd_1 = 'F03') * d_dist_1 +
	    (integer)(d_aacd_2 = 'F03') * d_dist_2 +
	    (integer)(d_aacd_3 = 'F03') * d_dist_3 +
	    (integer)(d_aacd_4 = 'F03') * d_dist_4 +
	    (integer)(d_aacd_5 = 'F03') * d_dist_5 +
	    (integer)(d_aacd_6 = 'F03') * d_dist_6 +
	    (integer)(d_aacd_7 = 'F03') * d_dist_7 +
	    (integer)(d_aacd_8 = 'F03') * d_dist_8 +
	    (integer)(d_aacd_9 = 'F03') * d_dist_9 +
	    (integer)(d_aacd_10 = 'F03') * d_dist_10 +
	    (integer)(d_aacd_11 = 'F03') * d_dist_11 +
	    (integer)(d_aacd_12 = 'F03') * d_dist_12 +
	    (integer)(d_aacd_13 = 'F03') * d_dist_13 +
	    (integer)(d_aacd_14 = 'F03') * d_dist_14 +
	    (integer)(d_aacd_15 = 'F03') * d_dist_15 +
	    (integer)(d_aacd_16 = 'F03') * d_dist_16 +
	    (integer)(d_aacd_17 = 'F03') * d_dist_17 +
	    (integer)(d_aacd_18 = 'F03') * d_dist_18 +
	    (integer)(d_aacd_19 = 'F03') * d_dist_19 +
	    (integer)(d_aacd_20 = 'F03') * d_dist_20 +
	    (integer)(d_aacd_21 = 'F03') * d_dist_21 +
	    (integer)(d_aacd_22 = 'F03') * d_dist_22;
	
	d_rcvaluea41 := (integer)(d_aacd_0 = 'A41') * d_dist_0 +
	    (integer)(d_aacd_1 = 'A41') * d_dist_1 +
	    (integer)(d_aacd_2 = 'A41') * d_dist_2 +
	    (integer)(d_aacd_3 = 'A41') * d_dist_3 +
	    (integer)(d_aacd_4 = 'A41') * d_dist_4 +
	    (integer)(d_aacd_5 = 'A41') * d_dist_5 +
	    (integer)(d_aacd_6 = 'A41') * d_dist_6 +
	    (integer)(d_aacd_7 = 'A41') * d_dist_7 +
	    (integer)(d_aacd_8 = 'A41') * d_dist_8 +
	    (integer)(d_aacd_9 = 'A41') * d_dist_9 +
	    (integer)(d_aacd_10 = 'A41') * d_dist_10 +
	    (integer)(d_aacd_11 = 'A41') * d_dist_11 +
	    (integer)(d_aacd_12 = 'A41') * d_dist_12 +
	    (integer)(d_aacd_13 = 'A41') * d_dist_13 +
	    (integer)(d_aacd_14 = 'A41') * d_dist_14 +
	    (integer)(d_aacd_15 = 'A41') * d_dist_15 +
	    (integer)(d_aacd_16 = 'A41') * d_dist_16 +
	    (integer)(d_aacd_17 = 'A41') * d_dist_17 +
	    (integer)(d_aacd_18 = 'A41') * d_dist_18 +
	    (integer)(d_aacd_19 = 'A41') * d_dist_19 +
	    (integer)(d_aacd_20 = 'A41') * d_dist_20 +
	    (integer)(d_aacd_21 = 'A41') * d_dist_21 +
	    (integer)(d_aacd_22 = 'A41') * d_dist_22;
	
	d_rcvaluee55 := (integer)(d_aacd_0 = 'E55') * d_dist_0 +
	    (integer)(d_aacd_1 = 'E55') * d_dist_1 +
	    (integer)(d_aacd_2 = 'E55') * d_dist_2 +
	    (integer)(d_aacd_3 = 'E55') * d_dist_3 +
	    (integer)(d_aacd_4 = 'E55') * d_dist_4 +
	    (integer)(d_aacd_5 = 'E55') * d_dist_5 +
	    (integer)(d_aacd_6 = 'E55') * d_dist_6 +
	    (integer)(d_aacd_7 = 'E55') * d_dist_7 +
	    (integer)(d_aacd_8 = 'E55') * d_dist_8 +
	    (integer)(d_aacd_9 = 'E55') * d_dist_9 +
	    (integer)(d_aacd_10 = 'E55') * d_dist_10 +
	    (integer)(d_aacd_11 = 'E55') * d_dist_11 +
	    (integer)(d_aacd_12 = 'E55') * d_dist_12 +
	    (integer)(d_aacd_13 = 'E55') * d_dist_13 +
	    (integer)(d_aacd_14 = 'E55') * d_dist_14 +
	    (integer)(d_aacd_15 = 'E55') * d_dist_15 +
	    (integer)(d_aacd_16 = 'E55') * d_dist_16 +
	    (integer)(d_aacd_17 = 'E55') * d_dist_17 +
	    (integer)(d_aacd_18 = 'E55') * d_dist_18 +
	    (integer)(d_aacd_19 = 'E55') * d_dist_19 +
	    (integer)(d_aacd_20 = 'E55') * d_dist_20 +
	    (integer)(d_aacd_21 = 'E55') * d_dist_21 +
	    (integer)(d_aacd_22 = 'E55') * d_dist_22;
	
	d_rcvaluec12 := (integer)(d_aacd_0 = 'C12') * d_dist_0 +
	    (integer)(d_aacd_1 = 'C12') * d_dist_1 +
	    (integer)(d_aacd_2 = 'C12') * d_dist_2 +
	    (integer)(d_aacd_3 = 'C12') * d_dist_3 +
	    (integer)(d_aacd_4 = 'C12') * d_dist_4 +
	    (integer)(d_aacd_5 = 'C12') * d_dist_5 +
	    (integer)(d_aacd_6 = 'C12') * d_dist_6 +
	    (integer)(d_aacd_7 = 'C12') * d_dist_7 +
	    (integer)(d_aacd_8 = 'C12') * d_dist_8 +
	    (integer)(d_aacd_9 = 'C12') * d_dist_9 +
	    (integer)(d_aacd_10 = 'C12') * d_dist_10 +
	    (integer)(d_aacd_11 = 'C12') * d_dist_11 +
	    (integer)(d_aacd_12 = 'C12') * d_dist_12 +
	    (integer)(d_aacd_13 = 'C12') * d_dist_13 +
	    (integer)(d_aacd_14 = 'C12') * d_dist_14 +
	    (integer)(d_aacd_15 = 'C12') * d_dist_15 +
	    (integer)(d_aacd_16 = 'C12') * d_dist_16 +
	    (integer)(d_aacd_17 = 'C12') * d_dist_17 +
	    (integer)(d_aacd_18 = 'C12') * d_dist_18 +
	    (integer)(d_aacd_19 = 'C12') * d_dist_19 +
	    (integer)(d_aacd_20 = 'C12') * d_dist_20 +
	    (integer)(d_aacd_21 = 'C12') * d_dist_21 +
	    (integer)(d_aacd_22 = 'C12') * d_dist_22;
	
	d_rcvaluea47 := (integer)(d_aacd_0 = 'A47') * d_dist_0 +
	    (integer)(d_aacd_1 = 'A47') * d_dist_1 +
	    (integer)(d_aacd_2 = 'A47') * d_dist_2 +
	    (integer)(d_aacd_3 = 'A47') * d_dist_3 +
	    (integer)(d_aacd_4 = 'A47') * d_dist_4 +
	    (integer)(d_aacd_5 = 'A47') * d_dist_5 +
	    (integer)(d_aacd_6 = 'A47') * d_dist_6 +
	    (integer)(d_aacd_7 = 'A47') * d_dist_7 +
	    (integer)(d_aacd_8 = 'A47') * d_dist_8 +
	    (integer)(d_aacd_9 = 'A47') * d_dist_9 +
	    (integer)(d_aacd_10 = 'A47') * d_dist_10 +
	    (integer)(d_aacd_11 = 'A47') * d_dist_11 +
	    (integer)(d_aacd_12 = 'A47') * d_dist_12 +
	    (integer)(d_aacd_13 = 'A47') * d_dist_13 +
	    (integer)(d_aacd_14 = 'A47') * d_dist_14 +
	    (integer)(d_aacd_15 = 'A47') * d_dist_15 +
	    (integer)(d_aacd_16 = 'A47') * d_dist_16 +
	    (integer)(d_aacd_17 = 'A47') * d_dist_17 +
	    (integer)(d_aacd_18 = 'A47') * d_dist_18 +
	    (integer)(d_aacd_19 = 'A47') * d_dist_19 +
	    (integer)(d_aacd_20 = 'A47') * d_dist_20 +
	    (integer)(d_aacd_21 = 'A47') * d_dist_21 +
	    (integer)(d_aacd_22 = 'A47') * d_dist_22;
	
	d_rcvalues66 := (integer)(d_aacd_0 = 'S66') * d_dist_0 +
	    (integer)(d_aacd_1 = 'S66') * d_dist_1 +
	    (integer)(d_aacd_2 = 'S66') * d_dist_2 +
	    (integer)(d_aacd_3 = 'S66') * d_dist_3 +
	    (integer)(d_aacd_4 = 'S66') * d_dist_4 +
	    (integer)(d_aacd_5 = 'S66') * d_dist_5 +
	    (integer)(d_aacd_6 = 'S66') * d_dist_6 +
	    (integer)(d_aacd_7 = 'S66') * d_dist_7 +
	    (integer)(d_aacd_8 = 'S66') * d_dist_8 +
	    (integer)(d_aacd_9 = 'S66') * d_dist_9 +
	    (integer)(d_aacd_10 = 'S66') * d_dist_10 +
	    (integer)(d_aacd_11 = 'S66') * d_dist_11 +
	    (integer)(d_aacd_12 = 'S66') * d_dist_12 +
	    (integer)(d_aacd_13 = 'S66') * d_dist_13 +
	    (integer)(d_aacd_14 = 'S66') * d_dist_14 +
	    (integer)(d_aacd_15 = 'S66') * d_dist_15 +
	    (integer)(d_aacd_16 = 'S66') * d_dist_16 +
	    (integer)(d_aacd_17 = 'S66') * d_dist_17 +
	    (integer)(d_aacd_18 = 'S66') * d_dist_18 +
	    (integer)(d_aacd_19 = 'S66') * d_dist_19 +
	    (integer)(d_aacd_20 = 'S66') * d_dist_20 +
	    (integer)(d_aacd_21 = 'S66') * d_dist_21 +
	    (integer)(d_aacd_22 = 'S66') * d_dist_22;
	
	d_rcvaluee57 := (integer)(d_aacd_0 = 'E57') * d_dist_0 +
	    (integer)(d_aacd_1 = 'E57') * d_dist_1 +
	    (integer)(d_aacd_2 = 'E57') * d_dist_2 +
	    (integer)(d_aacd_3 = 'E57') * d_dist_3 +
	    (integer)(d_aacd_4 = 'E57') * d_dist_4 +
	    (integer)(d_aacd_5 = 'E57') * d_dist_5 +
	    (integer)(d_aacd_6 = 'E57') * d_dist_6 +
	    (integer)(d_aacd_7 = 'E57') * d_dist_7 +
	    (integer)(d_aacd_8 = 'E57') * d_dist_8 +
	    (integer)(d_aacd_9 = 'E57') * d_dist_9 +
	    (integer)(d_aacd_10 = 'E57') * d_dist_10 +
	    (integer)(d_aacd_11 = 'E57') * d_dist_11 +
	    (integer)(d_aacd_12 = 'E57') * d_dist_12 +
	    (integer)(d_aacd_13 = 'E57') * d_dist_13 +
	    (integer)(d_aacd_14 = 'E57') * d_dist_14 +
	    (integer)(d_aacd_15 = 'E57') * d_dist_15 +
	    (integer)(d_aacd_16 = 'E57') * d_dist_16 +
	    (integer)(d_aacd_17 = 'E57') * d_dist_17 +
	    (integer)(d_aacd_18 = 'E57') * d_dist_18 +
	    (integer)(d_aacd_19 = 'E57') * d_dist_19 +
	    (integer)(d_aacd_20 = 'E57') * d_dist_20 +
	    (integer)(d_aacd_21 = 'E57') * d_dist_21 +
	    (integer)(d_aacd_22 = 'E57') * d_dist_22;
	
	
//=========================================================
//==  start calculating the RC values for propowner segment =
//=========================================================	
	
	p_dist_12 := _ov_pts_lost_raw;
	
	p_aacd_12 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                  '');
	
	p_rcvaluec13 := (integer)(p_aacd_0 = 'C13') * p_dist_0 +
	    (integer)(p_aacd_1 = 'C13') * p_dist_1 +
	    (integer)(p_aacd_2 = 'C13') * p_dist_2 +
	    (integer)(p_aacd_3 = 'C13') * p_dist_3 +
	    (integer)(p_aacd_4 = 'C13') * p_dist_4 +
	    (integer)(p_aacd_5 = 'C13') * p_dist_5 +
	    (integer)(p_aacd_6 = 'C13') * p_dist_6 +
	    (integer)(p_aacd_7 = 'C13') * p_dist_7 +
	    (integer)(p_aacd_8 = 'C13') * p_dist_8 +
	    (integer)(p_aacd_9 = 'C13') * p_dist_9 +
	    (integer)(p_aacd_10 = 'C13') * p_dist_10 +
	    (integer)(p_aacd_11 = 'C13') * p_dist_11 +
	    (integer)(p_aacd_12 = 'C13') * p_dist_12;
	
	p_rcvaluel80 := (integer)(p_aacd_0 = 'L80') * p_dist_0 +
	    (integer)(p_aacd_1 = 'L80') * p_dist_1 +
	    (integer)(p_aacd_2 = 'L80') * p_dist_2 +
	    (integer)(p_aacd_3 = 'L80') * p_dist_3 +
	    (integer)(p_aacd_4 = 'L80') * p_dist_4 +
	    (integer)(p_aacd_5 = 'L80') * p_dist_5 +
	    (integer)(p_aacd_6 = 'L80') * p_dist_6 +
	    (integer)(p_aacd_7 = 'L80') * p_dist_7 +
	    (integer)(p_aacd_8 = 'L80') * p_dist_8 +
	    (integer)(p_aacd_9 = 'L80') * p_dist_9 +
	    (integer)(p_aacd_10 = 'L80') * p_dist_10 +
	    (integer)(p_aacd_11 = 'L80') * p_dist_11 +
	    (integer)(p_aacd_12 = 'L80') * p_dist_12;
	
	p_rcvaluea50 := (integer)(p_aacd_0 = 'A50') * p_dist_0 +
	    (integer)(p_aacd_1 = 'A50') * p_dist_1 +
	    (integer)(p_aacd_2 = 'A50') * p_dist_2 +
	    (integer)(p_aacd_3 = 'A50') * p_dist_3 +
	    (integer)(p_aacd_4 = 'A50') * p_dist_4 +
	    (integer)(p_aacd_5 = 'A50') * p_dist_5 +
	    (integer)(p_aacd_6 = 'A50') * p_dist_6 +
	    (integer)(p_aacd_7 = 'A50') * p_dist_7 +
	    (integer)(p_aacd_8 = 'A50') * p_dist_8 +
	    (integer)(p_aacd_9 = 'A50') * p_dist_9 +
	    (integer)(p_aacd_10 = 'A50') * p_dist_10 +
	    (integer)(p_aacd_11 = 'A50') * p_dist_11 +
	    (integer)(p_aacd_12 = 'A50') * p_dist_12;
	
	p_rcvaluei60 := (integer)(p_aacd_0 = 'I60') * p_dist_0 +
	    (integer)(p_aacd_1 = 'I60') * p_dist_1 +
	    (integer)(p_aacd_2 = 'I60') * p_dist_2 +
	    (integer)(p_aacd_3 = 'I60') * p_dist_3 +
	    (integer)(p_aacd_4 = 'I60') * p_dist_4 +
	    (integer)(p_aacd_5 = 'I60') * p_dist_5 +
	    (integer)(p_aacd_6 = 'I60') * p_dist_6 +
	    (integer)(p_aacd_7 = 'I60') * p_dist_7 +
	    (integer)(p_aacd_8 = 'I60') * p_dist_8 +
	    (integer)(p_aacd_9 = 'I60') * p_dist_9 +
	    (integer)(p_aacd_10 = 'I60') * p_dist_10 +
	    (integer)(p_aacd_11 = 'I60') * p_dist_11 +
	    (integer)(p_aacd_12 = 'I60') * p_dist_12;
	
	p_rcvaluee55 := (integer)(p_aacd_0 = 'E55') * p_dist_0 +
	    (integer)(p_aacd_1 = 'E55') * p_dist_1 +
	    (integer)(p_aacd_2 = 'E55') * p_dist_2 +
	    (integer)(p_aacd_3 = 'E55') * p_dist_3 +
	    (integer)(p_aacd_4 = 'E55') * p_dist_4 +
	    (integer)(p_aacd_5 = 'E55') * p_dist_5 +
	    (integer)(p_aacd_6 = 'E55') * p_dist_6 +
	    (integer)(p_aacd_7 = 'E55') * p_dist_7 +
	    (integer)(p_aacd_8 = 'E55') * p_dist_8 +
	    (integer)(p_aacd_9 = 'E55') * p_dist_9 +
	    (integer)(p_aacd_10 = 'E55') * p_dist_10 +
	    (integer)(p_aacd_11 = 'E55') * p_dist_11 +
	    (integer)(p_aacd_12 = 'E55') * p_dist_12;
	
	p_rcvalueS65 := (integer)(p_aacd_0 = 'S65') * p_dist_0 +
	    (integer)(p_aacd_1 = 'S65') * p_dist_1 +
	    (integer)(p_aacd_2 = 'S65') * p_dist_2 +
	    (integer)(p_aacd_3 = 'S65') * p_dist_3 +
	    (integer)(p_aacd_4 = 'S65') * p_dist_4 +
	    (integer)(p_aacd_5 = 'S65') * p_dist_5 +
	    (integer)(p_aacd_6 = 'S65') * p_dist_6 +
	    (integer)(p_aacd_7 = 'S65') * p_dist_7 +
	    (integer)(p_aacd_8 = 'S65') * p_dist_8 +
	    (integer)(p_aacd_9 = 'S65') * p_dist_9 +
	    (integer)(p_aacd_10 = 'S65') * p_dist_10 +
	    (integer)(p_aacd_11 = 'S65') * p_dist_11 +
	    (integer)(p_aacd_12 = 'S65') * p_dist_12;
	
	p_rcvalued30 := (integer)(p_aacd_0 = 'D30') * p_dist_0 +
	    (integer)(p_aacd_1 = 'D30') * p_dist_1 +
	    (integer)(p_aacd_2 = 'D30') * p_dist_2 +
	    (integer)(p_aacd_3 = 'D30') * p_dist_3 +
	    (integer)(p_aacd_4 = 'D30') * p_dist_4 +
	    (integer)(p_aacd_5 = 'D30') * p_dist_5 +
	    (integer)(p_aacd_6 = 'D30') * p_dist_6 +
	    (integer)(p_aacd_7 = 'D30') * p_dist_7 +
	    (integer)(p_aacd_8 = 'D30') * p_dist_8 +
	    (integer)(p_aacd_9 = 'D30') * p_dist_9 +
	    (integer)(p_aacd_10 = 'D30') * p_dist_10 +
	    (integer)(p_aacd_11 = 'D30') * p_dist_11 +
	    (integer)(p_aacd_12 = 'D30') * p_dist_12;
	
	p_rcvaluea47 := (integer)(p_aacd_0 = 'A47') * p_dist_0 +
	    (integer)(p_aacd_1 = 'A47') * p_dist_1 +
	    (integer)(p_aacd_2 = 'A47') * p_dist_2 +
	    (integer)(p_aacd_3 = 'A47') * p_dist_3 +
	    (integer)(p_aacd_4 = 'A47') * p_dist_4 +
	    (integer)(p_aacd_5 = 'A47') * p_dist_5 +
	    (integer)(p_aacd_6 = 'A47') * p_dist_6 +
	    (integer)(p_aacd_7 = 'A47') * p_dist_7 +
	    (integer)(p_aacd_8 = 'A47') * p_dist_8 +
	    (integer)(p_aacd_9 = 'A47') * p_dist_9 +
	    (integer)(p_aacd_10 = 'A47') * p_dist_10 +
	    (integer)(p_aacd_11 = 'A47') * p_dist_11 +
	    (integer)(p_aacd_12 = 'A47') * p_dist_12;
	
	p_rcvaluea44 := (integer)(p_aacd_0 = 'A44') * p_dist_0 +
	    (integer)(p_aacd_1 = 'A44') * p_dist_1 +
	    (integer)(p_aacd_2 = 'A44') * p_dist_2 +
	    (integer)(p_aacd_3 = 'A44') * p_dist_3 +
	    (integer)(p_aacd_4 = 'A44') * p_dist_4 +
	    (integer)(p_aacd_5 = 'A44') * p_dist_5 +
	    (integer)(p_aacd_6 = 'A44') * p_dist_6 +
	    (integer)(p_aacd_7 = 'A44') * p_dist_7 +
	    (integer)(p_aacd_8 = 'A44') * p_dist_8 +
	    (integer)(p_aacd_9 = 'A44') * p_dist_9 +
	    (integer)(p_aacd_10 = 'A44') * p_dist_10 +
	    (integer)(p_aacd_11 = 'A44') * p_dist_11 +
	    (integer)(p_aacd_12 = 'A44') * p_dist_12;
	
	p_rcvaluef01 := (integer)(p_aacd_0 = 'F01') * p_dist_0 +
	    (integer)(p_aacd_1 = 'F01') * p_dist_1 +
	    (integer)(p_aacd_2 = 'F01') * p_dist_2 +
	    (integer)(p_aacd_3 = 'F01') * p_dist_3 +
	    (integer)(p_aacd_4 = 'F01') * p_dist_4 +
	    (integer)(p_aacd_5 = 'F01') * p_dist_5 +
	    (integer)(p_aacd_6 = 'F01') * p_dist_6 +
	    (integer)(p_aacd_7 = 'F01') * p_dist_7 +
	    (integer)(p_aacd_8 = 'F01') * p_dist_8 +
	    (integer)(p_aacd_9 = 'F01') * p_dist_9 +
	    (integer)(p_aacd_10 = 'F01') * p_dist_10 +
	    (integer)(p_aacd_11 = 'F01') * p_dist_11 +
	    (integer)(p_aacd_12 = 'F01') * p_dist_12;
	
	p_rcvaluel73 := (integer)(p_aacd_0 = 'L73') * p_dist_0 +
	    (integer)(p_aacd_1 = 'L73') * p_dist_1 +
	    (integer)(p_aacd_2 = 'L73') * p_dist_2 +
	    (integer)(p_aacd_3 = 'L73') * p_dist_3 +
	    (integer)(p_aacd_4 = 'L73') * p_dist_4 +
	    (integer)(p_aacd_5 = 'L73') * p_dist_5 +
	    (integer)(p_aacd_6 = 'L73') * p_dist_6 +
	    (integer)(p_aacd_7 = 'L73') * p_dist_7 +
	    (integer)(p_aacd_8 = 'L73') * p_dist_8 +
	    (integer)(p_aacd_9 = 'L73') * p_dist_9 +
	    (integer)(p_aacd_10 = 'L73') * p_dist_10 +
	    (integer)(p_aacd_11 = 'L73') * p_dist_11 +
	    (integer)(p_aacd_12 = 'L73') * p_dist_12;
	
	p_rcvalues66 := (integer)(p_aacd_0 = 'S66') * p_dist_0 +
	    (integer)(p_aacd_1 = 'S66') * p_dist_1 +
	    (integer)(p_aacd_2 = 'S66') * p_dist_2 +
	    (integer)(p_aacd_3 = 'S66') * p_dist_3 +
	    (integer)(p_aacd_4 = 'S66') * p_dist_4 +
	    (integer)(p_aacd_5 = 'S66') * p_dist_5 +
	    (integer)(p_aacd_6 = 'S66') * p_dist_6 +
	    (integer)(p_aacd_7 = 'S66') * p_dist_7 +
	    (integer)(p_aacd_8 = 'S66') * p_dist_8 +
	    (integer)(p_aacd_9 = 'S66') * p_dist_9 +
	    (integer)(p_aacd_10 = 'S66') * p_dist_10 +
	    (integer)(p_aacd_11 = 'S66') * p_dist_11 +
	    (integer)(p_aacd_12 = 'S66') * p_dist_12;
	
	p_rcvaluec12 := (integer)(p_aacd_0 = 'C12') * p_dist_0 +
	    (integer)(p_aacd_1 = 'C12') * p_dist_1 +
	    (integer)(p_aacd_2 = 'C12') * p_dist_2 +
	    (integer)(p_aacd_3 = 'C12') * p_dist_3 +
	    (integer)(p_aacd_4 = 'C12') * p_dist_4 +
	    (integer)(p_aacd_5 = 'C12') * p_dist_5 +
	    (integer)(p_aacd_6 = 'C12') * p_dist_6 +
	    (integer)(p_aacd_7 = 'C12') * p_dist_7 +
	    (integer)(p_aacd_8 = 'C12') * p_dist_8 +
	    (integer)(p_aacd_9 = 'C12') * p_dist_9 +
	    (integer)(p_aacd_10 = 'C12') * p_dist_10 +
	    (integer)(p_aacd_11 = 'C12') * p_dist_11 +
	    (integer)(p_aacd_12 = 'C12') * p_dist_12;
	
	
//=========================================================
//==  start calculating the RC values for other segment   =
//=========================================================	
	
	o_dist_20 := _ov_pts_lost_raw;
	
	o_aacd_20 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                  '');
	
	o_rcvaluec13 := (integer)(o_aacd_0 = 'C13') * o_dist_0 +
	    (integer)(o_aacd_1 = 'C13') * o_dist_1 +
	    (integer)(o_aacd_2 = 'C13') * o_dist_2 +
	    (integer)(o_aacd_3 = 'C13') * o_dist_3 +
	    (integer)(o_aacd_4 = 'C13') * o_dist_4 +
	    (integer)(o_aacd_5 = 'C13') * o_dist_5 +
	    (integer)(o_aacd_6 = 'C13') * o_dist_6 +
	    (integer)(o_aacd_7 = 'C13') * o_dist_7 +
	    (integer)(o_aacd_8 = 'C13') * o_dist_8 +
	    (integer)(o_aacd_9 = 'C13') * o_dist_9 +
	    (integer)(o_aacd_10 = 'C13') * o_dist_10 +
	    (integer)(o_aacd_11 = 'C13') * o_dist_11 +
	    (integer)(o_aacd_12 = 'C13') * o_dist_12 +
	    (integer)(o_aacd_13 = 'C13') * o_dist_13 +
	    (integer)(o_aacd_14 = 'C13') * o_dist_14 +
	    (integer)(o_aacd_15 = 'C13') * o_dist_15 +
	    (integer)(o_aacd_16 = 'C13') * o_dist_16 +
	    (integer)(o_aacd_17 = 'C13') * o_dist_17 +
	    (integer)(o_aacd_18 = 'C13') * o_dist_18 +
	    (integer)(o_aacd_19 = 'C13') * o_dist_19 +
	    (integer)(o_aacd_20 = 'C13') * o_dist_20;
	
	o_rcvaluel80 := (integer)(o_aacd_0 = 'L80') * o_dist_0 +
	    (integer)(o_aacd_1 = 'L80') * o_dist_1 +
	    (integer)(o_aacd_2 = 'L80') * o_dist_2 +
	    (integer)(o_aacd_3 = 'L80') * o_dist_3 +
	    (integer)(o_aacd_4 = 'L80') * o_dist_4 +
	    (integer)(o_aacd_5 = 'L80') * o_dist_5 +
	    (integer)(o_aacd_6 = 'L80') * o_dist_6 +
	    (integer)(o_aacd_7 = 'L80') * o_dist_7 +
	    (integer)(o_aacd_8 = 'L80') * o_dist_8 +
	    (integer)(o_aacd_9 = 'L80') * o_dist_9 +
	    (integer)(o_aacd_10 = 'L80') * o_dist_10 +
	    (integer)(o_aacd_11 = 'L80') * o_dist_11 +
	    (integer)(o_aacd_12 = 'L80') * o_dist_12 +
	    (integer)(o_aacd_13 = 'L80') * o_dist_13 +
	    (integer)(o_aacd_14 = 'L80') * o_dist_14 +
	    (integer)(o_aacd_15 = 'L80') * o_dist_15 +
	    (integer)(o_aacd_16 = 'L80') * o_dist_16 +
	    (integer)(o_aacd_17 = 'L80') * o_dist_17 +
	    (integer)(o_aacd_18 = 'L80') * o_dist_18 +
	    (integer)(o_aacd_19 = 'L80') * o_dist_19 +
	    (integer)(o_aacd_20 = 'L80') * o_dist_20;
	
	o_rcvaluel73 := (integer)(o_aacd_0 = 'L73') * o_dist_0 +
	    (integer)(o_aacd_1 = 'L73') * o_dist_1 +
	    (integer)(o_aacd_2 = 'L73') * o_dist_2 +
	    (integer)(o_aacd_3 = 'L73') * o_dist_3 +
	    (integer)(o_aacd_4 = 'L73') * o_dist_4 +
	    (integer)(o_aacd_5 = 'L73') * o_dist_5 +
	    (integer)(o_aacd_6 = 'L73') * o_dist_6 +
	    (integer)(o_aacd_7 = 'L73') * o_dist_7 +
	    (integer)(o_aacd_8 = 'L73') * o_dist_8 +
	    (integer)(o_aacd_9 = 'L73') * o_dist_9 +
	    (integer)(o_aacd_10 = 'L73') * o_dist_10 +
	    (integer)(o_aacd_11 = 'L73') * o_dist_11 +
	    (integer)(o_aacd_12 = 'L73') * o_dist_12 +
	    (integer)(o_aacd_13 = 'L73') * o_dist_13 +
	    (integer)(o_aacd_14 = 'L73') * o_dist_14 +
	    (integer)(o_aacd_15 = 'L73') * o_dist_15 +
	    (integer)(o_aacd_16 = 'L73') * o_dist_16 +
	    (integer)(o_aacd_17 = 'L73') * o_dist_17 +
	    (integer)(o_aacd_18 = 'L73') * o_dist_18 +
	    (integer)(o_aacd_19 = 'L73') * o_dist_19 +
	    (integer)(o_aacd_20 = 'L73') * o_dist_20;
	
	o_rcvalued34 := (integer)(o_aacd_0 = 'D34') * o_dist_0 +
	    (integer)(o_aacd_1 = 'D34') * o_dist_1 +
	    (integer)(o_aacd_2 = 'D34') * o_dist_2 +
	    (integer)(o_aacd_3 = 'D34') * o_dist_3 +
	    (integer)(o_aacd_4 = 'D34') * o_dist_4 +
	    (integer)(o_aacd_5 = 'D34') * o_dist_5 +
	    (integer)(o_aacd_6 = 'D34') * o_dist_6 +
	    (integer)(o_aacd_7 = 'D34') * o_dist_7 +
	    (integer)(o_aacd_8 = 'D34') * o_dist_8 +
	    (integer)(o_aacd_9 = 'D34') * o_dist_9 +
	    (integer)(o_aacd_10 = 'D34') * o_dist_10 +
	    (integer)(o_aacd_11 = 'D34') * o_dist_11 +
	    (integer)(o_aacd_12 = 'D34') * o_dist_12 +
	    (integer)(o_aacd_13 = 'D34') * o_dist_13 +
	    (integer)(o_aacd_14 = 'D34') * o_dist_14 +
	    (integer)(o_aacd_15 = 'D34') * o_dist_15 +
	    (integer)(o_aacd_16 = 'D34') * o_dist_16 +
	    (integer)(o_aacd_17 = 'D34') * o_dist_17 +
	    (integer)(o_aacd_18 = 'D34') * o_dist_18 +
	    (integer)(o_aacd_19 = 'D34') * o_dist_19 +
	    (integer)(o_aacd_20 = 'D34') * o_dist_20;
	
	o_rcvaluea41 := (integer)(o_aacd_0 = 'A41') * o_dist_0 +
	    (integer)(o_aacd_1 = 'A41') * o_dist_1 +
	    (integer)(o_aacd_2 = 'A41') * o_dist_2 +
	    (integer)(o_aacd_3 = 'A41') * o_dist_3 +
	    (integer)(o_aacd_4 = 'A41') * o_dist_4 +
	    (integer)(o_aacd_5 = 'A41') * o_dist_5 +
	    (integer)(o_aacd_6 = 'A41') * o_dist_6 +
	    (integer)(o_aacd_7 = 'A41') * o_dist_7 +
	    (integer)(o_aacd_8 = 'A41') * o_dist_8 +
	    (integer)(o_aacd_9 = 'A41') * o_dist_9 +
	    (integer)(o_aacd_10 = 'A41') * o_dist_10 +
	    (integer)(o_aacd_11 = 'A41') * o_dist_11 +
	    (integer)(o_aacd_12 = 'A41') * o_dist_12 +
	    (integer)(o_aacd_13 = 'A41') * o_dist_13 +
	    (integer)(o_aacd_14 = 'A41') * o_dist_14 +
	    (integer)(o_aacd_15 = 'A41') * o_dist_15 +
	    (integer)(o_aacd_16 = 'A41') * o_dist_16 +
	    (integer)(o_aacd_17 = 'A41') * o_dist_17 +
	    (integer)(o_aacd_18 = 'A41') * o_dist_18 +
	    (integer)(o_aacd_19 = 'A41') * o_dist_19 +
	    (integer)(o_aacd_20 = 'A41') * o_dist_20;
	
	o_rcvaluea50 := (integer)(o_aacd_0 = 'A50') * o_dist_0 +
	    (integer)(o_aacd_1 = 'A50') * o_dist_1 +
	    (integer)(o_aacd_2 = 'A50') * o_dist_2 +
	    (integer)(o_aacd_3 = 'A50') * o_dist_3 +
	    (integer)(o_aacd_4 = 'A50') * o_dist_4 +
	    (integer)(o_aacd_5 = 'A50') * o_dist_5 +
	    (integer)(o_aacd_6 = 'A50') * o_dist_6 +
	    (integer)(o_aacd_7 = 'A50') * o_dist_7 +
	    (integer)(o_aacd_8 = 'A50') * o_dist_8 +
	    (integer)(o_aacd_9 = 'A50') * o_dist_9 +
	    (integer)(o_aacd_10 = 'A50') * o_dist_10 +
	    (integer)(o_aacd_11 = 'A50') * o_dist_11 +
	    (integer)(o_aacd_12 = 'A50') * o_dist_12 +
	    (integer)(o_aacd_13 = 'A50') * o_dist_13 +
	    (integer)(o_aacd_14 = 'A50') * o_dist_14 +
	    (integer)(o_aacd_15 = 'A50') * o_dist_15 +
	    (integer)(o_aacd_16 = 'A50') * o_dist_16 +
	    (integer)(o_aacd_17 = 'A50') * o_dist_17 +
	    (integer)(o_aacd_18 = 'A50') * o_dist_18 +
	    (integer)(o_aacd_19 = 'A50') * o_dist_19 +
	    (integer)(o_aacd_20 = 'A50') * o_dist_20;
	
	o_rcvaluea44 := (integer)(o_aacd_0 = 'A44') * o_dist_0 +
	    (integer)(o_aacd_1 = 'A44') * o_dist_1 +
	    (integer)(o_aacd_2 = 'A44') * o_dist_2 +
	    (integer)(o_aacd_3 = 'A44') * o_dist_3 +
	    (integer)(o_aacd_4 = 'A44') * o_dist_4 +
	    (integer)(o_aacd_5 = 'A44') * o_dist_5 +
	    (integer)(o_aacd_6 = 'A44') * o_dist_6 +
	    (integer)(o_aacd_7 = 'A44') * o_dist_7 +
	    (integer)(o_aacd_8 = 'A44') * o_dist_8 +
	    (integer)(o_aacd_9 = 'A44') * o_dist_9 +
	    (integer)(o_aacd_10 = 'A44') * o_dist_10 +
	    (integer)(o_aacd_11 = 'A44') * o_dist_11 +
	    (integer)(o_aacd_12 = 'A44') * o_dist_12 +
	    (integer)(o_aacd_13 = 'A44') * o_dist_13 +
	    (integer)(o_aacd_14 = 'A44') * o_dist_14 +
	    (integer)(o_aacd_15 = 'A44') * o_dist_15 +
	    (integer)(o_aacd_16 = 'A44') * o_dist_16 +
	    (integer)(o_aacd_17 = 'A44') * o_dist_17 +
	    (integer)(o_aacd_18 = 'A44') * o_dist_18 +
	    (integer)(o_aacd_19 = 'A44') * o_dist_19 +
	    (integer)(o_aacd_20 = 'A44') * o_dist_20;
	
	o_rcvaluec18 := (integer)(o_aacd_0 = 'C18') * o_dist_0 +
	    (integer)(o_aacd_1 = 'C18') * o_dist_1 +
	    (integer)(o_aacd_2 = 'C18') * o_dist_2 +
	    (integer)(o_aacd_3 = 'C18') * o_dist_3 +
	    (integer)(o_aacd_4 = 'C18') * o_dist_4 +
	    (integer)(o_aacd_5 = 'C18') * o_dist_5 +
	    (integer)(o_aacd_6 = 'C18') * o_dist_6 +
	    (integer)(o_aacd_7 = 'C18') * o_dist_7 +
	    (integer)(o_aacd_8 = 'C18') * o_dist_8 +
	    (integer)(o_aacd_9 = 'C18') * o_dist_9 +
	    (integer)(o_aacd_10 = 'C18') * o_dist_10 +
	    (integer)(o_aacd_11 = 'C18') * o_dist_11 +
	    (integer)(o_aacd_12 = 'C18') * o_dist_12 +
	    (integer)(o_aacd_13 = 'C18') * o_dist_13 +
	    (integer)(o_aacd_14 = 'C18') * o_dist_14 +
	    (integer)(o_aacd_15 = 'C18') * o_dist_15 +
	    (integer)(o_aacd_16 = 'C18') * o_dist_16 +
	    (integer)(o_aacd_17 = 'C18') * o_dist_17 +
	    (integer)(o_aacd_18 = 'C18') * o_dist_18 +
	    (integer)(o_aacd_19 = 'C18') * o_dist_19 +
	    (integer)(o_aacd_20 = 'C18') * o_dist_20;
	
	o_rcvaluef01 := (integer)(o_aacd_0 = 'F01') * o_dist_0 +
	    (integer)(o_aacd_1 = 'F01') * o_dist_1 +
	    (integer)(o_aacd_2 = 'F01') * o_dist_2 +
	    (integer)(o_aacd_3 = 'F01') * o_dist_3 +
	    (integer)(o_aacd_4 = 'F01') * o_dist_4 +
	    (integer)(o_aacd_5 = 'F01') * o_dist_5 +
	    (integer)(o_aacd_6 = 'F01') * o_dist_6 +
	    (integer)(o_aacd_7 = 'F01') * o_dist_7 +
	    (integer)(o_aacd_8 = 'F01') * o_dist_8 +
	    (integer)(o_aacd_9 = 'F01') * o_dist_9 +
	    (integer)(o_aacd_10 = 'F01') * o_dist_10 +
	    (integer)(o_aacd_11 = 'F01') * o_dist_11 +
	    (integer)(o_aacd_12 = 'F01') * o_dist_12 +
	    (integer)(o_aacd_13 = 'F01') * o_dist_13 +
	    (integer)(o_aacd_14 = 'F01') * o_dist_14 +
	    (integer)(o_aacd_15 = 'F01') * o_dist_15 +
	    (integer)(o_aacd_16 = 'F01') * o_dist_16 +
	    (integer)(o_aacd_17 = 'F01') * o_dist_17 +
	    (integer)(o_aacd_18 = 'F01') * o_dist_18 +
	    (integer)(o_aacd_19 = 'F01') * o_dist_19 +
	    (integer)(o_aacd_20 = 'F01') * o_dist_20;
	
	o_rcvaluef00 := (integer)(o_aacd_0 = 'F00') * o_dist_0 +
	    (integer)(o_aacd_1 = 'F00') * o_dist_1 +
	    (integer)(o_aacd_2 = 'F00') * o_dist_2 +
	    (integer)(o_aacd_3 = 'F00') * o_dist_3 +
	    (integer)(o_aacd_4 = 'F00') * o_dist_4 +
	    (integer)(o_aacd_5 = 'F00') * o_dist_5 +
	    (integer)(o_aacd_6 = 'F00') * o_dist_6 +
	    (integer)(o_aacd_7 = 'F00') * o_dist_7 +
	    (integer)(o_aacd_8 = 'F00') * o_dist_8 +
	    (integer)(o_aacd_9 = 'F00') * o_dist_9 +
	    (integer)(o_aacd_10 = 'F00') * o_dist_10 +
	    (integer)(o_aacd_11 = 'F00') * o_dist_11 +
	    (integer)(o_aacd_12 = 'F00') * o_dist_12 +
	    (integer)(o_aacd_13 = 'F00') * o_dist_13 +
	    (integer)(o_aacd_14 = 'F00') * o_dist_14 +
	    (integer)(o_aacd_15 = 'F00') * o_dist_15 +
	    (integer)(o_aacd_16 = 'F00') * o_dist_16 +
	    (integer)(o_aacd_17 = 'F00') * o_dist_17 +
	    (integer)(o_aacd_18 = 'F00') * o_dist_18 +
	    (integer)(o_aacd_19 = 'F00') * o_dist_19 +
	    (integer)(o_aacd_20 = 'F00') * o_dist_20;
	
	o_rcvaluef03 := (integer)(o_aacd_0 = 'F03') * o_dist_0 +
	    (integer)(o_aacd_1 = 'F03') * o_dist_1 +
	    (integer)(o_aacd_2 = 'F03') * o_dist_2 +
	    (integer)(o_aacd_3 = 'F03') * o_dist_3 +
	    (integer)(o_aacd_4 = 'F03') * o_dist_4 +
	    (integer)(o_aacd_5 = 'F03') * o_dist_5 +
	    (integer)(o_aacd_6 = 'F03') * o_dist_6 +
	    (integer)(o_aacd_7 = 'F03') * o_dist_7 +
	    (integer)(o_aacd_8 = 'F03') * o_dist_8 +
	    (integer)(o_aacd_9 = 'F03') * o_dist_9 +
	    (integer)(o_aacd_10 = 'F03') * o_dist_10 +
	    (integer)(o_aacd_11 = 'F03') * o_dist_11 +
	    (integer)(o_aacd_12 = 'F03') * o_dist_12 +
	    (integer)(o_aacd_13 = 'F03') * o_dist_13 +
	    (integer)(o_aacd_14 = 'F03') * o_dist_14 +
	    (integer)(o_aacd_15 = 'F03') * o_dist_15 +
	    (integer)(o_aacd_16 = 'F03') * o_dist_16 +
	    (integer)(o_aacd_17 = 'F03') * o_dist_17 +
	    (integer)(o_aacd_18 = 'F03') * o_dist_18 +
	    (integer)(o_aacd_19 = 'F03') * o_dist_19 +
	    (integer)(o_aacd_20 = 'F03') * o_dist_20;
	
	o_rcvaluec12 := (integer)(o_aacd_0 = 'C12') * o_dist_0 +
	    (integer)(o_aacd_1 = 'C12') * o_dist_1 +
	    (integer)(o_aacd_2 = 'C12') * o_dist_2 +
	    (integer)(o_aacd_3 = 'C12') * o_dist_3 +
	    (integer)(o_aacd_4 = 'C12') * o_dist_4 +
	    (integer)(o_aacd_5 = 'C12') * o_dist_5 +
	    (integer)(o_aacd_6 = 'C12') * o_dist_6 +
	    (integer)(o_aacd_7 = 'C12') * o_dist_7 +
	    (integer)(o_aacd_8 = 'C12') * o_dist_8 +
	    (integer)(o_aacd_9 = 'C12') * o_dist_9 +
	    (integer)(o_aacd_10 = 'C12') * o_dist_10 +
	    (integer)(o_aacd_11 = 'C12') * o_dist_11 +
	    (integer)(o_aacd_12 = 'C12') * o_dist_12 +
	    (integer)(o_aacd_13 = 'C12') * o_dist_13 +
	    (integer)(o_aacd_14 = 'C12') * o_dist_14 +
	    (integer)(o_aacd_15 = 'C12') * o_dist_15 +
	    (integer)(o_aacd_16 = 'C12') * o_dist_16 +
	    (integer)(o_aacd_17 = 'C12') * o_dist_17 +
	    (integer)(o_aacd_18 = 'C12') * o_dist_18 +
	    (integer)(o_aacd_19 = 'C12') * o_dist_19 +
	    (integer)(o_aacd_20 = 'C12') * o_dist_20;
	
	o_rcvaluee55 := (integer)(o_aacd_0 = 'E55') * o_dist_0 +
	    (integer)(o_aacd_1 = 'E55') * o_dist_1 +
	    (integer)(o_aacd_2 = 'E55') * o_dist_2 +
	    (integer)(o_aacd_3 = 'E55') * o_dist_3 +
	    (integer)(o_aacd_4 = 'E55') * o_dist_4 +
	    (integer)(o_aacd_5 = 'E55') * o_dist_5 +
	    (integer)(o_aacd_6 = 'E55') * o_dist_6 +
	    (integer)(o_aacd_7 = 'E55') * o_dist_7 +
	    (integer)(o_aacd_8 = 'E55') * o_dist_8 +
	    (integer)(o_aacd_9 = 'E55') * o_dist_9 +
	    (integer)(o_aacd_10 = 'E55') * o_dist_10 +
	    (integer)(o_aacd_11 = 'E55') * o_dist_11 +
	    (integer)(o_aacd_12 = 'E55') * o_dist_12 +
	    (integer)(o_aacd_13 = 'E55') * o_dist_13 +
	    (integer)(o_aacd_14 = 'E55') * o_dist_14 +
	    (integer)(o_aacd_15 = 'E55') * o_dist_15 +
	    (integer)(o_aacd_16 = 'E55') * o_dist_16 +
	    (integer)(o_aacd_17 = 'E55') * o_dist_17 +
	    (integer)(o_aacd_18 = 'E55') * o_dist_18 +
	    (integer)(o_aacd_19 = 'E55') * o_dist_19 +
	    (integer)(o_aacd_20 = 'E55') * o_dist_20;
	
	o_rcvaluei60 := (integer)(o_aacd_0 = 'I60') * o_dist_0 +
	    (integer)(o_aacd_1 = 'I60') * o_dist_1 +
	    (integer)(o_aacd_2 = 'I60') * o_dist_2 +
	    (integer)(o_aacd_3 = 'I60') * o_dist_3 +
	    (integer)(o_aacd_4 = 'I60') * o_dist_4 +
	    (integer)(o_aacd_5 = 'I60') * o_dist_5 +
	    (integer)(o_aacd_6 = 'I60') * o_dist_6 +
	    (integer)(o_aacd_7 = 'I60') * o_dist_7 +
	    (integer)(o_aacd_8 = 'I60') * o_dist_8 +
	    (integer)(o_aacd_9 = 'I60') * o_dist_9 +
	    (integer)(o_aacd_10 = 'I60') * o_dist_10 +
	    (integer)(o_aacd_11 = 'I60') * o_dist_11 +
	    (integer)(o_aacd_12 = 'I60') * o_dist_12 +
	    (integer)(o_aacd_13 = 'I60') * o_dist_13 +
	    (integer)(o_aacd_14 = 'I60') * o_dist_14 +
	    (integer)(o_aacd_15 = 'I60') * o_dist_15 +
	    (integer)(o_aacd_16 = 'I60') * o_dist_16 +
	    (integer)(o_aacd_17 = 'I60') * o_dist_17 +
	    (integer)(o_aacd_18 = 'I60') * o_dist_18 +
	    (integer)(o_aacd_19 = 'I60') * o_dist_19 +
	    (integer)(o_aacd_20 = 'I60') * o_dist_20;
	
	o_rcvaluea47 := (integer)(o_aacd_0 = 'A47') * o_dist_0 +
	    (integer)(o_aacd_1 = 'A47') * o_dist_1 +
	    (integer)(o_aacd_2 = 'A47') * o_dist_2 +
	    (integer)(o_aacd_3 = 'A47') * o_dist_3 +
	    (integer)(o_aacd_4 = 'A47') * o_dist_4 +
	    (integer)(o_aacd_5 = 'A47') * o_dist_5 +
	    (integer)(o_aacd_6 = 'A47') * o_dist_6 +
	    (integer)(o_aacd_7 = 'A47') * o_dist_7 +
	    (integer)(o_aacd_8 = 'A47') * o_dist_8 +
	    (integer)(o_aacd_9 = 'A47') * o_dist_9 +
	    (integer)(o_aacd_10 = 'A47') * o_dist_10 +
	    (integer)(o_aacd_11 = 'A47') * o_dist_11 +
	    (integer)(o_aacd_12 = 'A47') * o_dist_12 +
	    (integer)(o_aacd_13 = 'A47') * o_dist_13 +
	    (integer)(o_aacd_14 = 'A47') * o_dist_14 +
	    (integer)(o_aacd_15 = 'A47') * o_dist_15 +
	    (integer)(o_aacd_16 = 'A47') * o_dist_16 +
	    (integer)(o_aacd_17 = 'A47') * o_dist_17 +
	    (integer)(o_aacd_18 = 'A47') * o_dist_18 +
	    (integer)(o_aacd_19 = 'A47') * o_dist_19 +
	    (integer)(o_aacd_20 = 'A47') * o_dist_20;
	
	o_rcvaluec10 := (integer)(o_aacd_0 = 'C10') * o_dist_0 +
	    (integer)(o_aacd_1 = 'C10') * o_dist_1 +
	    (integer)(o_aacd_2 = 'C10') * o_dist_2 +
	    (integer)(o_aacd_3 = 'C10') * o_dist_3 +
	    (integer)(o_aacd_4 = 'C10') * o_dist_4 +
	    (integer)(o_aacd_5 = 'C10') * o_dist_5 +
	    (integer)(o_aacd_6 = 'C10') * o_dist_6 +
	    (integer)(o_aacd_7 = 'C10') * o_dist_7 +
	    (integer)(o_aacd_8 = 'C10') * o_dist_8 +
	    (integer)(o_aacd_9 = 'C10') * o_dist_9 +
	    (integer)(o_aacd_10 = 'C10') * o_dist_10 +
	    (integer)(o_aacd_11 = 'C10') * o_dist_11 +
	    (integer)(o_aacd_12 = 'C10') * o_dist_12 +
	    (integer)(o_aacd_13 = 'C10') * o_dist_13 +
	    (integer)(o_aacd_14 = 'C10') * o_dist_14 +
	    (integer)(o_aacd_15 = 'C10') * o_dist_15 +
	    (integer)(o_aacd_16 = 'C10') * o_dist_16 +
	    (integer)(o_aacd_17 = 'C10') * o_dist_17 +
	    (integer)(o_aacd_18 = 'C10') * o_dist_18 +
	    (integer)(o_aacd_19 = 'C10') * o_dist_19 +
	    (integer)(o_aacd_20 = 'C10') * o_dist_20;
	
	o_rcvalues66 := (integer)(o_aacd_0 = 'S66') * o_dist_0 +
	    (integer)(o_aacd_1 = 'S66') * o_dist_1 +
	    (integer)(o_aacd_2 = 'S66') * o_dist_2 +
	    (integer)(o_aacd_3 = 'S66') * o_dist_3 +
	    (integer)(o_aacd_4 = 'S66') * o_dist_4 +
	    (integer)(o_aacd_5 = 'S66') * o_dist_5 +
	    (integer)(o_aacd_6 = 'S66') * o_dist_6 +
	    (integer)(o_aacd_7 = 'S66') * o_dist_7 +
	    (integer)(o_aacd_8 = 'S66') * o_dist_8 +
	    (integer)(o_aacd_9 = 'S66') * o_dist_9 +
	    (integer)(o_aacd_10 = 'S66') * o_dist_10 +
	    (integer)(o_aacd_11 = 'S66') * o_dist_11 +
	    (integer)(o_aacd_12 = 'S66') * o_dist_12 +
	    (integer)(o_aacd_13 = 'S66') * o_dist_13 +
	    (integer)(o_aacd_14 = 'S66') * o_dist_14 +
	    (integer)(o_aacd_15 = 'S66') * o_dist_15 +
	    (integer)(o_aacd_16 = 'S66') * o_dist_16 +
	    (integer)(o_aacd_17 = 'S66') * o_dist_17 +
	    (integer)(o_aacd_18 = 'S66') * o_dist_18 +
	    (integer)(o_aacd_19 = 'S66') * o_dist_19 +
	    (integer)(o_aacd_20 = 'S66') * o_dist_20;
	
	o_rcvaluee57 := (integer)(o_aacd_0 = 'E57') * o_dist_0 +
	    (integer)(o_aacd_1 = 'E57') * o_dist_1 +
	    (integer)(o_aacd_2 = 'E57') * o_dist_2 +
	    (integer)(o_aacd_3 = 'E57') * o_dist_3 +
	    (integer)(o_aacd_4 = 'E57') * o_dist_4 +
	    (integer)(o_aacd_5 = 'E57') * o_dist_5 +
	    (integer)(o_aacd_6 = 'E57') * o_dist_6 +
	    (integer)(o_aacd_7 = 'E57') * o_dist_7 +
	    (integer)(o_aacd_8 = 'E57') * o_dist_8 +
	    (integer)(o_aacd_9 = 'E57') * o_dist_9 +
	    (integer)(o_aacd_10 = 'E57') * o_dist_10 +
	    (integer)(o_aacd_11 = 'E57') * o_dist_11 +
	    (integer)(o_aacd_12 = 'E57') * o_dist_12 +
	    (integer)(o_aacd_13 = 'E57') * o_dist_13 +
	    (integer)(o_aacd_14 = 'E57') * o_dist_14 +
	    (integer)(o_aacd_15 = 'E57') * o_dist_15 +
	    (integer)(o_aacd_16 = 'E57') * o_dist_16 +
	    (integer)(o_aacd_17 = 'E57') * o_dist_17 +
	    (integer)(o_aacd_18 = 'E57') * o_dist_18 +
	    (integer)(o_aacd_19 = 'E57') * o_dist_19 +
	    (integer)(o_aacd_20 = 'E57') * o_dist_20;
	
	o_rcvalueS65 := (integer)(o_aacd_0 = 'S65') * o_dist_0 +
	    (integer)(o_aacd_1 = 'S65') * o_dist_1 +
	    (integer)(o_aacd_2 = 'S65') * o_dist_2 +
	    (integer)(o_aacd_3 = 'S65') * o_dist_3 +
	    (integer)(o_aacd_4 = 'S65') * o_dist_4 +
	    (integer)(o_aacd_5 = 'S65') * o_dist_5 +
	    (integer)(o_aacd_6 = 'S65') * o_dist_6 +
	    (integer)(o_aacd_7 = 'S65') * o_dist_7 +
	    (integer)(o_aacd_8 = 'S65') * o_dist_8 +
	    (integer)(o_aacd_9 = 'S65') * o_dist_9 +
	    (integer)(o_aacd_10 = 'S65') * o_dist_10 +
	    (integer)(o_aacd_11 = 'S65') * o_dist_11 +
	    (integer)(o_aacd_12 = 'S65') * o_dist_12 +
	    (integer)(o_aacd_13 = 'S65') * o_dist_13 +
	    (integer)(o_aacd_14 = 'S65') * o_dist_14 +
	    (integer)(o_aacd_15 = 'S65') * o_dist_15 +
	    (integer)(o_aacd_16 = 'S65') * o_dist_16 +
	    (integer)(o_aacd_17 = 'S65') * o_dist_17 +
	    (integer)(o_aacd_18 = 'S65') * o_dist_18 +
	    (integer)(o_aacd_19 = 'S65') * o_dist_19 +
	    (integer)(o_aacd_20 = 'S65') * o_dist_20;
	
	o_rcvaluec14 := (integer)(o_aacd_0 = 'C14') * o_dist_0 +
	    (integer)(o_aacd_1 = 'C14') * o_dist_1 +
	    (integer)(o_aacd_2 = 'C14') * o_dist_2 +
	    (integer)(o_aacd_3 = 'C14') * o_dist_3 +
	    (integer)(o_aacd_4 = 'C14') * o_dist_4 +
	    (integer)(o_aacd_5 = 'C14') * o_dist_5 +
	    (integer)(o_aacd_6 = 'C14') * o_dist_6 +
	    (integer)(o_aacd_7 = 'C14') * o_dist_7 +
	    (integer)(o_aacd_8 = 'C14') * o_dist_8 +
	    (integer)(o_aacd_9 = 'C14') * o_dist_9 +
	    (integer)(o_aacd_10 = 'C14') * o_dist_10 +
	    (integer)(o_aacd_11 = 'C14') * o_dist_11 +
	    (integer)(o_aacd_12 = 'C14') * o_dist_12 +
	    (integer)(o_aacd_13 = 'C14') * o_dist_13 +
	    (integer)(o_aacd_14 = 'C14') * o_dist_14 +
	    (integer)(o_aacd_15 = 'C14') * o_dist_15 +
	    (integer)(o_aacd_16 = 'C14') * o_dist_16 +
	    (integer)(o_aacd_17 = 'C14') * o_dist_17 +
	    (integer)(o_aacd_18 = 'C14') * o_dist_18 +
	    (integer)(o_aacd_19 = 'C14') * o_dist_19 +
	    (integer)(o_aacd_20 = 'C14') * o_dist_20;
	
	//*************************************************************************************//
	//                        RiskView Version 5 Reason Code Logic
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	 
//=======================
//===   PropOwner     ===
//======================= 
	rc_dataset_p := DATASET([
	    {'C13', p_rcvalueC13},
	    {'L80', p_rcvalueL80},
	    {'A50', p_rcvalueA50},
	    {'I60', p_rcvalueI60},
	    {'E55', p_rcvalueE55},
	    {'S65', p_rcvalueS65},
	    {'D30', p_rcvalueD30},
	    {'A47', p_rcvalueA47},
	    {'A44', p_rcvalueA44},
	    {'F01', p_rcvalueF01},
	    {'L73', p_rcvalueL73},
	    {'S66', p_rcvalueS66},
	    {'C12', p_rcvalueC12}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  
	//*************************************************************************************//
	rc_dataset_p_sorted := sort(rc_dataset_p, rc_dataset_p.value);
	
	p_rc1 := rc_dataset_p_sorted[1].rc;
	p_rc2 := rc_dataset_p_sorted[2].rc;
	p_rc3 := rc_dataset_p_sorted[3].rc;
	p_rc4 := rc_dataset_p_sorted[4].rc;
	
	p_vl1 := rc_dataset_p_sorted[1].value;
	p_vl2 := rc_dataset_p_sorted[2].value;
	p_vl3 := rc_dataset_p_sorted[3].value;
	p_vl4 := rc_dataset_p_sorted[4].value;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_d := DATASET([
	    {'C13', d_rcvalueC13},
	    {'C21', d_rcvalueC21},
	    {'L80', d_rcvalueL80},
	    {'L73', d_rcvalueL73},
	    {'S65', d_rcvalueS65},
	    {'P85', d_rcvalueP85},
	    {'D30', d_rcvalueD30},
	    {'A50', d_rcvalueA50},
	    {'A44', d_rcvalueA44},
	    {'I60', d_rcvalueI60},
	    {'F00', d_rcvalueF00},
	    {'F03', d_rcvalueF03},
	    {'A41', d_rcvalueA41},
	    {'E55', d_rcvalueE55},
	    {'C12', d_rcvalueC12},
	    {'A47', d_rcvalueA47},
	    {'S66', d_rcvalueS66},
	    {'E57', d_rcvalueE57}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.   
	//*************************************************************************************//
	rc_dataset_d_sorted := sort(rc_dataset_d, rc_dataset_d.value);
	
	d_rc1 := rc_dataset_d_sorted[1].rc;
	d_rc2 := rc_dataset_d_sorted[2].rc;
	d_rc3 := rc_dataset_d_sorted[3].rc;
	d_rc4 := rc_dataset_d_sorted[4].rc;
	
	d_vl1 := rc_dataset_d_sorted[1].value;
	d_vl2 := rc_dataset_d_sorted[2].value;
	d_vl3 := rc_dataset_d_sorted[3].value;
	d_vl4 := rc_dataset_d_sorted[4].value;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_o := DATASET([
	    {'C13', o_rcvalueC13},
	    {'L80', o_rcvalueL80},
	    {'L73', o_rcvalueL73},
	    {'D34', o_rcvalueD34},
	    {'A41', o_rcvalueA41},
	    {'A50', o_rcvalueA50},
	    {'A44', o_rcvalueA44},
	    {'C18', o_rcvalueC18},
	    {'F01', o_rcvalueF01},
	    {'F00', o_rcvalueF00},
	    {'F03', o_rcvalueF03},
	    {'C12', o_rcvalueC12},
	    {'E55', o_rcvalueE55},
	    {'I60', o_rcvalueI60},
	    {'A47', o_rcvalueA47},
	    {'C10', o_rcvalueC10},
	    {'S66', o_rcvalueS66},
	    {'E57', o_rcvalueE57},
	    {'S65', o_rcvalueS65},
	    {'C14', o_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.   
	//*************************************************************************************//
	rc_dataset_o_sorted := sort(rc_dataset_o, rc_dataset_o.value);
	
	o_rc1 := rc_dataset_o_sorted[1].rc;
	o_rc2 := rc_dataset_o_sorted[2].rc;
	o_rc3 := rc_dataset_o_sorted[3].rc;
	o_rc4 := rc_dataset_o_sorted[4].rc;
	
	o_vl1 := rc_dataset_o_sorted[1].value;
	o_vl2 := rc_dataset_o_sorted[2].value;
	o_vl3 := rc_dataset_o_sorted[3].value;
	o_vl4 := rc_dataset_o_sorted[4].value;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_v := DATASET([
	    {'C22', v_rcvalueC22},
	    {'C21', v_rcvalueC21},
	    {'L80', v_rcvalueL80},
	    {'A50', v_rcvalueA50},
	    {'I60', v_rcvalueI60},
	    {'S65', v_rcvalueS65},
	    {'P85', v_rcvalueP85},
	    {'D30', v_rcvalueD30},
	    {'A47', v_rcvalueA47},
	    {'A44', v_rcvalueA44},
	    {'F04', v_rcvalueF04},
			{'A42', v_rcvalueA42},
	    {'F01', v_rcvalueF01},
	    {'F00', v_rcvalueF00},
	    {'A41', v_rcvalueA41},
	    {'E55', v_rcvalueE55},
	    {'C12', v_rcvalueC12},
	    {'E57', v_rcvalueE57},
	    {'S66', v_rcvalueS66},
	    {'L73', v_rcvalueL73}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_v_sorted := sort(rc_dataset_v, rc_dataset_v.value);
	
	v_rc1 := rc_dataset_v_sorted[1].rc;
	v_rc2 := rc_dataset_v_sorted[2].rc;
	v_rc3 := rc_dataset_v_sorted[3].rc;
	v_rc4 := rc_dataset_v_sorted[4].rc;
	
	v_vl1 := rc_dataset_v_sorted[1].value;
	v_vl2 := rc_dataset_v_sorted[2].value;
	v_vl3 := rc_dataset_v_sorted[3].value;
	v_vl4 := rc_dataset_v_sorted[4].value;
	//*************************************************************************************//
	
	
	
	//=======================================================================
	//==   After calculating the reason codes and scores for each segment 
	//==   Choose the reason code based on segment this consumer falls into
	//=======================================================================
	
	rc4_2 := map(
	    VerProb_seg => v_rc4,
	    Derog_seg   => d_rc4,
	    Owner_seg   => p_rc4,
	                   o_rc4);
	
	rc3_2 := map(
	    VerProb_seg => v_rc3,
	    Derog_seg   => d_rc3,
	    Owner_seg   => p_rc3,
	                   o_rc3);
	
	rc1_3 := map(
	    VerProb_seg => v_rc1,
	    Derog_seg   => d_rc1,
	    Owner_seg   => p_rc1,
	                   o_rc1);
	
	rc2_2 := map(
	    VerProb_seg => v_rc2,
	    Derog_seg   => d_rc2,
	    Owner_seg   => p_rc2,
	                   o_rc2);
	
	rc1_2 := if(trim(rc1_3, ALL) = '', _rc_seg, rc1_3);


//=======================================================================
//==   Populate the _rc_inq field to be used if there are no other reason
//===
//=======================================================================	
	_rc_inq := map(
	    verprob_seg and rv_i60_inq_count12 > 0          => 'I60',
	    derog_seg and rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
	    owner_seg and rv_i60_inq_count12 > 0            => 'I60',
	    other_seg and rv_i60_inq_count12 > 0            => 'I60',
	                                                       '');
	
	
	
	rc5_c214 := map(
	    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => '',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = ''         => '',
	                                                         _rc_inq);
	

	
	rc5_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc5_c214, '');
	
	
	//===================================================
	//== This is the final override to the reason code ==
	//===================================================
	
	rc4 := if((rvt1503_0_1 in [200, 222]), '', rc4_2);
	
	rc5 := if((rvt1503_0_1 in [200, 222]), '', rc5_1);
	
	rc3 := if((rvt1503_0_1 in [200, 222]), '', rc3_2);
	
	rc1 := if((rvt1503_0_1 in [200, 222]), '', rc1_2);
	
	rc2 := if((rvt1503_0_1 in [200, 222]), '', rc2_2);


//*************************************************************************************//
//                     RiskView Version 5 - RVT1503_0 Score Overrides
//*************************************************************************************//
// Deceased = 200
// Unscorable = 222
// Lex ID Only On Input = 222 (FLAGSHIP MODELS ONLY)
// SSNPrior OR Corrections = 550
// Score Range: 501 - 900
//*************************************************************************************//

//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVT1503_0_1 = 200 => DATASET([{'00'}], HRILayout),
													RVT1503_0_1 = 222 => DATASET([{'00'}], HRILayout),
													RVT1503_0_1 = 900 => DATASET([{'00'}], HRILayout),
																							DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);

// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5);    // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.seq     := seq;
		SELF.out_z5 := out_z5;
		SELF.out_addr_status := out_addr_status;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.nap_status := nap_status;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_hriskaddrflag := rc_hriskaddrflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_pwssndobflag := rc_pwssndobflag;
		SELF.rc_addrvalflag := rc_addrvalflag;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_hrisksic := rc_hrisksic;
		SELF.rc_hrisksicphone := rc_hrisksicphone;
		SELF.rc_phonetype := rc_phonetype;
		SELF.rc_ziptypeflag := rc_ziptypeflag;
		SELF.combo_ssnscore := combo_ssnscore;
		SELF.combo_dobscore := combo_dobscore;
		SELF.hdr_source_profile := hdr_source_profile;
		SELF.ver_sources := ver_sources;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_isbestmatch := add_input_isbestmatch;
		SELF.add_input_occ_index := add_input_occ_index;
		SELF.add_input_advo_vacancy := add_input_advo_vacancy;
		SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.add_curr_isbestmatch := add_curr_isbestmatch;
		SELF.add_curr_occ_index := add_curr_occ_index;
		SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
		SELF.add_curr_naprop := add_curr_naprop;
		SELF.add_curr_pop := add_curr_pop;
		SELF.add_prev_naprop := add_prev_naprop;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.telcordia_type := telcordia_type;
		SELF.header_first_seen := header_first_seen;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.adls_per_ssn := adls_per_ssn;
		SELF.adls_per_addr_curr := adls_per_addr_curr;
		SELF.ssns_per_addr_curr := ssns_per_addr_curr;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.invalid_addrs_per_adl := invalid_addrs_per_adl;
		SELF.inq_count12 := inq_count12;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.pb_average_dollars := pb_average_dollars;
		SELF.br_source_count := br_source_count;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count12 := stl_inq_count12;
		SELF.attr_addrs_last30 := attr_addrs_last30;
		SELF.attr_addrs_last90 := attr_addrs_last90;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.attr_num_nonderogs90 := attr_num_nonderogs90;
		SELF.attr_num_nonderogs180 := attr_num_nonderogs180;
		SELF.attr_num_nonderogs12 := attr_num_nonderogs12;
		SELF.attr_num_nonderogs24 := attr_num_nonderogs24;
		SELF.attr_num_nonderogs36 := attr_num_nonderogs36;
		SELF.attr_num_nonderogs60 := attr_num_nonderogs60;
		SELF.bk_dismissed_recent_count := bk_dismissed_recent_count;
		SELF.bk_dismissed_historical_count := bk_dismissed_historical_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_recent_released_count := liens_recent_released_count;
		SELF.liens_historical_released_count := liens_historical_released_count;
		SELF.liens_unrel_cj_ct := liens_unrel_cj_ct;
		SELF.liens_rel_cj_ct := liens_rel_cj_ct;
		SELF.liens_unrel_ft_ct := liens_unrel_ft_ct;
		SELF.liens_rel_ft_ct := liens_rel_ft_ct;
		SELF.liens_unrel_fc_ct := liens_unrel_fc_ct;
		SELF.liens_rel_fc_ct := liens_rel_fc_ct;
		SELF.liens_unrel_lt_ct := liens_unrel_lt_ct;
		SELF.liens_rel_lt_ct := liens_rel_lt_ct;
		SELF.liens_unrel_o_ct := liens_unrel_o_ct;
		SELF.liens_rel_o_ct := liens_rel_o_ct;
		SELF.liens_unrel_ot_ct := liens_unrel_ot_ct;
		SELF.liens_rel_ot_ct := liens_rel_ot_ct;
		SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
		SELF.liens_rel_sc_ct := liens_rel_sc_ct;
		SELF.liens_unrel_st_ct := liens_unrel_st_ct;
		SELF.liens_rel_st_ct := liens_rel_st_ct;
		SELF.criminal_count := criminal_count;
		SELF.criminal_last_date := criminal_last_date;
		SELF.felony_count := felony_count;
		SELF.college_file_type := college_file_type;
		SELF.college_attendance := college_attendance;
		SELF.prof_license_flag := prof_license_flag;
		SELF.input_dob_match_level := input_dob_match_level;

		/* Model Intermediate Variables */
 
		SELF.num_dob_match_level := num_dob_match_level;
		SELF.nas_summary_ver := nas_summary_ver;
		SELF.nap_summary_ver := nap_summary_ver;
		SELF.infutor_nap_ver := infutor_nap_ver;
		SELF.dob_ver := dob_ver;
		SELF.sufficiently_verified := sufficiently_verified;
		SELF.add_ec1 := add_ec1;
		SELF.addr_validation_problem := addr_validation_problem;
		SELF.phn_validation_problem := phn_validation_problem;
		SELF.validation_problem := validation_problem;
		SELF.tot_liens := tot_liens;
		SELF.tot_liens_w_type := tot_liens_w_type;
		SELF.has_derog := has_derog;
		SELF.rv_4seg_riskview_5_0 := rv_4seg_riskview_5_0;
		SELF.verprob_seg := verprob_seg;
		SELF.derog_seg := derog_seg;
		SELF.owner_seg := owner_seg;
		SELF.other_seg := other_seg;
		SELF.sysdate := sysdate;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rv_f00_addr_not_ver_w_ssn := rv_f00_addr_not_ver_w_ssn;
		SELF.rv_p85_phn_disconnected := rv_p85_phn_disconnected;
		SELF.rv_f00_ssn_score := rv_f00_ssn_score;
		SELF.rv_f00_dob_score := rv_f00_dob_score;
		SELF.rv_f01_inp_addr_address_score := rv_f01_inp_addr_address_score;
		SELF.rv_f00_input_dob_match_level := rv_f00_input_dob_match_level;
		SELF.rv_d30_derog_count := rv_d30_derog_count;
		SELF.iv_d34_liens_unrel_x_rel := iv_d34_liens_unrel_x_rel;
		SELF.rv_d32_felony_count := rv_d32_felony_count;
		SELF.rv_d32_criminal_x_felony := rv_d32_criminal_x_felony;
		SELF._criminal_last_date := _criminal_last_date;
		SELF.rv_d32_mos_since_crim_ls := rv_d32_mos_since_crim_ls;
		SELF.rv_c21_stl_inq_count12 := rv_c21_stl_inq_count12;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_c12_num_nonderogs := rv_c12_num_nonderogs;
		SELF._header_first_seen := _header_first_seen;
		SELF.rv_c10_m_hdr_fs := rv_c10_m_hdr_fs;
		SELF.rv_c12_nonderog_recency := rv_c12_nonderog_recency;
		SELF.rv_c12_source_profile := rv_c12_source_profile;
		SELF.rv_s66_adlperssn_count := rv_s66_adlperssn_count;
		SELF.rv_f03_address_match := rv_f03_address_match;
		SELF.rv_a44_curr_add_naprop := rv_a44_curr_add_naprop;
		SELF.rv_l80_inp_avm_autoval := rv_l80_inp_avm_autoval;
		SELF.rv_a46_curr_avm_autoval := rv_a46_curr_avm_autoval;
		SELF.rv_c22_inp_addr_occ_index := rv_c22_inp_addr_occ_index;
		SELF.rv_f04_curr_add_occ_index := rv_f04_curr_add_occ_index;
		SELF.rv_c14_addrs_5yr := rv_c14_addrs_5yr;
		SELF.rv_a41_prop_owner := rv_a41_prop_owner;
		SELF.rv_e55_college_ind := rv_e55_college_ind;
		SELF.rv_e57_prof_license_br_flag := rv_e57_prof_license_br_flag;
		SELF.rv_i60_inq_count12 := rv_i60_inq_count12;
		SELF.rv_i60_inq_hiriskcred_count12 := rv_i60_inq_hiriskcred_count12;
		SELF.rv_c18_invalid_addrs_per_adl := rv_c18_invalid_addrs_per_adl;
		SELF.rv_c13_attr_addrs_recency := rv_c13_attr_addrs_recency;
		SELF.rv_a50_pb_average_dollars := rv_a50_pb_average_dollars;
		SELF.v_subscore0 := v_subscore0;
		SELF.v_subscore1 := v_subscore1;
		SELF.v_subscore2 := v_subscore2;
		SELF.v_subscore3 := v_subscore3;
		SELF.v_subscore4 := v_subscore4;
		SELF.v_subscore5 := v_subscore5;
		SELF.v_subscore6 := v_subscore6;
		SELF.v_subscore7 := v_subscore7;
		SELF.v_subscore8 := v_subscore8;
		SELF.v_subscore9 := v_subscore9;
		SELF.v_subscore10 := v_subscore10;
		SELF.v_subscore11 := v_subscore11;
		SELF.v_subscore12 := v_subscore12;
		SELF.v_subscore13 := v_subscore13;
		SELF.v_subscore14 := v_subscore14;
		SELF.v_subscore15 := v_subscore15;
		SELF.v_subscore16 := v_subscore16;
		SELF.v_subscore17 := v_subscore17;
		SELF.v_subscore18 := v_subscore18;
		SELF.v_subscore19 := v_subscore19;
		SELF.v_rawscore := v_rawscore;
		SELF.v_lnoddsscore := v_lnoddsscore;
		SELF.v_probscore := v_probscore;
		SELF.v_aacd_0 := v_aacd_0;
		SELF.v_dist_0 := v_dist_0;
		SELF.v_aacd_1 := v_aacd_1;
		SELF.v_dist_1 := v_dist_1;
		SELF.v_aacd_2 := v_aacd_2;
		SELF.v_dist_2_1 := v_dist_2_1;
		SELF.v_aacd_3_1 := v_aacd_3_1;
		SELF.v_dist_3_1 := v_dist_3_1;
		SELF.v_dist_3 := v_dist_3;
		SELF.v_aacd_3 := v_aacd_3;
		SELF.v_dist_2 := v_dist_2;
		SELF.v_aacd_4 := v_aacd_4;
		SELF.v_dist_4 := v_dist_4;
		SELF.v_aacd_5 := v_aacd_5;
		SELF.v_dist_5 := v_dist_5;
		SELF.v_aacd_6 := v_aacd_6;
		SELF.v_dist_6_1 := v_dist_6_1;
		SELF.v_aacd_7 := v_aacd_7;
		SELF.v_dist_7 := v_dist_7;
		SELF.v_aacd_8 := v_aacd_8;
		SELF.v_dist_8 := v_dist_8;
		SELF.v_aacd_9 := v_aacd_9;
		SELF.v_dist_9 := v_dist_9;
		SELF.v_aacd_10 := v_aacd_10;
		SELF.v_dist_10 := v_dist_10;
		SELF.v_aacd_11 := v_aacd_11;
		SELF.v_dist_11_1 := v_dist_11_1;
		SELF.v_dist_6 := v_dist_6;
		SELF.v_dist_11 := v_dist_11;
		SELF.v_aacd_12 := v_aacd_12;
		SELF.v_dist_12 := v_dist_12;
		SELF.v_aacd_13 := v_aacd_13;
		SELF.v_dist_13 := v_dist_13;
		SELF.v_aacd_14 := v_aacd_14;
		SELF.v_dist_14 := v_dist_14;
		SELF.v_aacd_15 := v_aacd_15;
		SELF.v_dist_15 := v_dist_15;
		SELF.v_aacd_16 := v_aacd_16;
		SELF.v_dist_16 := v_dist_16;
		SELF.v_aacd_17 := v_aacd_17;
		SELF.v_dist_17 := v_dist_17;
		SELF.v_aacd_18 := v_aacd_18;
		SELF.v_dist_18 := v_dist_18;
		SELF.v_aacd_19 := v_aacd_19;
		SELF.v_dist_19 := v_dist_19;
		SELF.d_subscore0 := d_subscore0;
		SELF.d_subscore1 := d_subscore1;
		SELF.d_subscore2 := d_subscore2;
		SELF.d_subscore3 := d_subscore3;
		SELF.d_subscore4 := d_subscore4;
		SELF.d_subscore5 := d_subscore5;
		SELF.d_subscore6 := d_subscore6;
		SELF.d_subscore7 := d_subscore7;
		SELF.d_subscore8 := d_subscore8;
		SELF.d_subscore9 := d_subscore9;
		SELF.d_subscore10 := d_subscore10;
		SELF.d_subscore11 := d_subscore11;
		SELF.d_subscore12 := d_subscore12;
		SELF.d_subscore13 := d_subscore13;
		SELF.d_subscore14 := d_subscore14;
		SELF.d_subscore15 := d_subscore15;
		SELF.d_subscore16 := d_subscore16;
		SELF.d_subscore17 := d_subscore17;
		SELF.d_subscore18 := d_subscore18;
		SELF.d_subscore19 := d_subscore19;
		SELF.d_subscore20 := d_subscore20;
		SELF.d_subscore21 := d_subscore21;
		SELF.d_rawscore := d_rawscore;
		SELF.d_lnoddsscore := d_lnoddsscore;
		SELF.d_probscore := d_probscore;
		SELF.d_aacd_0 := d_aacd_0;
		SELF.d_dist_0 := d_dist_0;
		SELF.d_aacd_1 := d_aacd_1;
		SELF.d_dist_1 := d_dist_1;
		SELF.d_aacd_2 := d_aacd_2;
		SELF.d_dist_2 := d_dist_2;
		SELF.d_aacd_3 := d_aacd_3;
		SELF.d_dist_3 := d_dist_3;
		SELF.d_aacd_4 := d_aacd_4;
		SELF.d_dist_4 := d_dist_4;
		SELF.d_aacd_5_1 := d_aacd_5_1;
		SELF.d_dist_5_1 := d_dist_5_1;
		SELF.d_aacd_6 := d_aacd_6;
		SELF.d_dist_6 := d_dist_6;
		SELF.d_aacd_7 := d_aacd_7;
		SELF.d_dist_7_1 := d_dist_7_1;
		SELF.d_dist_7 := d_dist_7;
		SELF.d_dist_5 := d_dist_5;
		SELF.d_aacd_5 := d_aacd_5;
		SELF.d_aacd_8 := d_aacd_8;
		SELF.d_dist_8 := d_dist_8;
		SELF.d_aacd_9 := d_aacd_9;
		SELF.d_dist_9 := d_dist_9;
		SELF.d_aacd_10 := d_aacd_10;
		SELF.d_dist_10 := d_dist_10;
		SELF.d_aacd_11 := d_aacd_11;
		SELF.d_dist_11 := d_dist_11;
		SELF.d_aacd_12 := d_aacd_12;
		SELF.d_dist_12 := d_dist_12;
		SELF.d_aacd_13 := d_aacd_13;
		SELF.d_dist_13 := d_dist_13;
		SELF.d_aacd_14 := d_aacd_14;
		SELF.d_dist_14 := d_dist_14;
		SELF.d_aacd_15 := d_aacd_15;
		SELF.d_dist_15 := d_dist_15;
		SELF.d_aacd_16 := d_aacd_16;
		SELF.d_dist_16 := d_dist_16;
		SELF.d_aacd_17 := d_aacd_17;
		SELF.d_dist_17 := d_dist_17;
		SELF.d_aacd_18 := d_aacd_18;
		SELF.d_dist_18 := d_dist_18;
		SELF.d_aacd_19 := d_aacd_19;
		SELF.d_dist_19 := d_dist_19;
		SELF.d_aacd_20 := d_aacd_20;
		SELF.d_dist_20 := d_dist_20;
		SELF.d_aacd_21 := d_aacd_21;
		SELF.d_dist_21 := d_dist_21;
		SELF.p_subscore0 := p_subscore0;
		SELF.p_subscore1 := p_subscore1;
		SELF.p_subscore2 := p_subscore2;
		SELF.p_subscore3 := p_subscore3;
		SELF.p_subscore4 := p_subscore4;
		SELF.p_subscore5 := p_subscore5;
		SELF.p_subscore6 := p_subscore6;
		SELF.p_subscore7 := p_subscore7;
		SELF.p_subscore8 := p_subscore8;
		SELF.p_subscore9 := p_subscore9;
		SELF.p_subscore10 := p_subscore10;
		SELF.p_subscore11 := p_subscore11;
		SELF.p_rawscore := p_rawscore;
		SELF.p_lnoddsscore := p_lnoddsscore;
		SELF.p_probscore := p_probscore;
		SELF.p_aacd_0 := p_aacd_0;
		SELF.p_dist_0 := p_dist_0;
		SELF.p_aacd_1 := p_aacd_1;
		SELF.p_dist_1 := p_dist_1;
		SELF.p_aacd_2 := p_aacd_2;
		SELF.p_dist_2 := p_dist_2;
		SELF.p_aacd_3 := p_aacd_3;
		SELF.p_dist_3 := p_dist_3;
		SELF.p_aacd_4 := p_aacd_4;
		SELF.p_dist_4 := p_dist_4;
		SELF.p_aacd_5 := p_aacd_5;
		SELF.p_dist_5 := p_dist_5;
		SELF.p_aacd_6_1 := p_aacd_6_1;
		SELF.p_dist_6_1 := p_dist_6_1;
		SELF.p_aacd_7 := p_aacd_7;
		SELF.p_dist_7_1 := p_dist_7_1;
		SELF.p_dist_6 := p_dist_6;
		SELF.p_aacd_6 := p_aacd_6;
		SELF.p_dist_7 := p_dist_7;
		SELF.p_aacd_8 := p_aacd_8;
		SELF.p_dist_8 := p_dist_8;
		SELF.p_aacd_9 := p_aacd_9;
		SELF.p_dist_9 := p_dist_9;
		SELF.p_aacd_10 := p_aacd_10;
		SELF.p_dist_10 := p_dist_10;
		SELF.p_aacd_11 := p_aacd_11;
		SELF.p_dist_11 := p_dist_11;
		SELF.o_subscore0 := o_subscore0;
		SELF.o_subscore1 := o_subscore1;
		SELF.o_subscore2 := o_subscore2;
		SELF.o_subscore3 := o_subscore3;
		SELF.o_subscore4 := o_subscore4;
		SELF.o_subscore5 := o_subscore5;
		SELF.o_subscore6 := o_subscore6;
		SELF.o_subscore7 := o_subscore7;
		SELF.o_subscore8 := o_subscore8;
		SELF.o_subscore9 := o_subscore9;
		SELF.o_subscore10 := o_subscore10;
		SELF.o_subscore11 := o_subscore11;
		SELF.o_subscore12 := o_subscore12;
		SELF.o_subscore13 := o_subscore13;
		SELF.o_subscore14 := o_subscore14;
		SELF.o_subscore15 := o_subscore15;
		SELF.o_subscore16 := o_subscore16;
		SELF.o_subscore17 := o_subscore17;
		SELF.o_subscore18 := o_subscore18;
		SELF.o_subscore19 := o_subscore19;
		SELF.o_rawscore := o_rawscore;
		SELF.o_lnoddsscore := o_lnoddsscore;
		SELF.o_probscore := o_probscore;
		SELF.o_aacd_0 := o_aacd_0;
		SELF.o_dist_0 := o_dist_0;
		SELF.o_aacd_1 := o_aacd_1;
		SELF.o_dist_1 := o_dist_1;
		SELF.o_aacd_2 := o_aacd_2;
		SELF.o_dist_2 := o_dist_2;
		SELF.o_aacd_3 := o_aacd_3;
		SELF.o_dist_3_1 := o_dist_3_1;
		SELF.o_aacd_4_1 := o_aacd_4_1;
		SELF.o_dist_4_1 := o_dist_4_1;
		SELF.o_aacd_4 := o_aacd_4;
		SELF.o_dist_4 := o_dist_4;
		SELF.o_dist_3 := o_dist_3;
		SELF.o_aacd_5 := o_aacd_5;
		SELF.o_dist_5 := o_dist_5;
		SELF.o_aacd_6 := o_aacd_6;
		SELF.o_dist_6 := o_dist_6;
		SELF.o_aacd_7 := o_aacd_7;
		SELF.o_dist_7 := o_dist_7;
		SELF.o_aacd_8 := o_aacd_8;
		SELF.o_dist_8 := o_dist_8;
		SELF.o_aacd_9 := o_aacd_9;
		SELF.o_dist_9 := o_dist_9;
		SELF.o_aacd_10 := o_aacd_10;
		SELF.o_dist_10 := o_dist_10;
		SELF.o_aacd_11 := o_aacd_11;
		SELF.o_dist_11 := o_dist_11;
		SELF.o_aacd_12 := o_aacd_12;
		SELF.o_dist_12 := o_dist_12;
		SELF.o_aacd_13 := o_aacd_13;
		SELF.o_dist_13 := o_dist_13;
		SELF.o_aacd_14 := o_aacd_14;
		SELF.o_dist_14 := o_dist_14;
		SELF.o_aacd_15 := o_aacd_15;
		SELF.o_dist_15 := o_dist_15;
		SELF.o_aacd_16 := o_aacd_16;
		SELF.o_dist_16 := o_dist_16;
		SELF.o_aacd_17 := o_aacd_17;
		SELF.o_dist_17 := o_dist_17;
		SELF.o_aacd_18 := o_aacd_18;
		SELF.o_dist_18 := o_dist_18;
		SELF.o_aacd_19 := o_aacd_19;
		SELF.o_dist_19 := o_dist_19;
		SELF.base := base;
		SELF.points := points;
		SELF.odds := odds;
		SELF.lnoddsscore := lnoddsscore;
		SELF.score_lnodds := score_lnodds;
		SELF.score_lnodds_capped := score_lnodds_capped;
		SELF.ov_ssnprior := ov_ssnprior;
		SELF.ov_corrections := ov_corrections;
		SELF.deceased := deceased;
		SELF._ov_pts_lost_c200_b3 := _ov_pts_lost_c200_b3;
		SELF._ov_pts_lost_raw := _ov_pts_lost_raw;
		SELF.rvt1503_0_1 := rvt1503_0_1;
		SELF._rc_seg_c203 := _rc_seg_c203;
		SELF._rc_seg_c204 := _rc_seg_c204;
		SELF._rc_seg_c202 := _rc_seg_c202;
		SELF._rc_seg_c205 := _rc_seg_c205;
		SELF._rc_seg := _rc_seg;
		SELF.v_dist_20 := v_dist_20;
		SELF.v_aacd_20 := v_aacd_20;
		SELF.v_rcvaluec22 := v_rcvaluec22;
		SELF.v_rcvaluec21 := v_rcvaluec21;
		SELF.v_rcvaluel80 := v_rcvaluel80;
		SELF.v_rcvaluea50 := v_rcvaluea50;
		SELF.v_rcvaluei60 := v_rcvaluei60;
		SELF.v_rcvalueS65 := v_rcvalueS65;
		SELF.v_rcvaluep85 := v_rcvaluep85;
		SELF.v_rcvalued30 := v_rcvalued30;
		SELF.v_rcvaluea47 := v_rcvaluea47;
		SELF.v_rcvaluea44 := v_rcvaluea44;
		SELF.v_rcvaluef04 := v_rcvaluef04;
		SELF.v_rcvaluef01 := v_rcvaluef01;
		SELF.v_rcvaluef00 := v_rcvaluef00;
		SELF.v_rcvaluea41 := v_rcvaluea41;
		SELF.v_rcvaluee55 := v_rcvaluee55;
		SELF.v_rcvaluec12 := v_rcvaluec12;
		SELF.v_rcvaluee57 := v_rcvaluee57;
		SELF.v_rcvalues66 := v_rcvalues66;
		SELF.v_rcvaluel73 := v_rcvaluel73;
		SELF.d_dist_22 := d_dist_22;
		SELF.d_aacd_22 := d_aacd_22;
		SELF.d_rcvaluec13 := d_rcvaluec13;
		SELF.d_rcvaluec21 := d_rcvaluec21;
		SELF.d_rcvaluel80 := d_rcvaluel80;
		SELF.d_rcvaluel73 := d_rcvaluel73;
		SELF.d_rcvalueS65 := d_rcvalueS65;
		SELF.d_rcvaluep85 := d_rcvaluep85;
		SELF.d_rcvalued30 := d_rcvalued30;
		SELF.d_rcvaluea50 := d_rcvaluea50;
		SELF.d_rcvaluea44 := d_rcvaluea44;
		SELF.d_rcvaluei60 := d_rcvaluei60;
		SELF.d_rcvaluef00 := d_rcvaluef00;
		SELF.d_rcvaluef03 := d_rcvaluef03;
		SELF.d_rcvaluea41 := d_rcvaluea41;
		SELF.d_rcvaluee55 := d_rcvaluee55;
		SELF.d_rcvaluec12 := d_rcvaluec12;
		SELF.d_rcvaluea47 := d_rcvaluea47;
		SELF.d_rcvalues66 := d_rcvalues66;
		SELF.d_rcvaluee57 := d_rcvaluee57;
		SELF.p_dist_12 := p_dist_12;
		SELF.p_aacd_12 := p_aacd_12;
		SELF.p_rcvaluec13 := p_rcvaluec13;
		SELF.p_rcvaluel80 := p_rcvaluel80;
		SELF.p_rcvaluea50 := p_rcvaluea50;
		SELF.p_rcvaluei60 := p_rcvaluei60;
		SELF.p_rcvaluee55 := p_rcvaluee55;
		SELF.p_rcvalueS65 := p_rcvalueS65;
		SELF.p_rcvalued30 := p_rcvalued30;
		SELF.p_rcvaluea47 := p_rcvaluea47;
		SELF.p_rcvaluea44 := p_rcvaluea44;
		SELF.p_rcvaluef01 := p_rcvaluef01;
		SELF.p_rcvaluel73 := p_rcvaluel73;
		SELF.p_rcvalues66 := p_rcvalues66;
		SELF.p_rcvaluec12 := p_rcvaluec12;
		SELF.o_dist_20 := o_dist_20;
		SELF.o_aacd_20 := o_aacd_20;
		SELF.o_rcvaluec13 := o_rcvaluec13;
		SELF.o_rcvaluel80 := o_rcvaluel80;
		SELF.o_rcvaluel73 := o_rcvaluel73;
		SELF.o_rcvalued34 := o_rcvalued34;
		SELF.o_rcvaluea41 := o_rcvaluea41;
		SELF.o_rcvaluea50 := o_rcvaluea50;
		SELF.o_rcvaluea44 := o_rcvaluea44;
		SELF.o_rcvaluec18 := o_rcvaluec18;
		SELF.o_rcvaluef01 := o_rcvaluef01;
		SELF.o_rcvaluef00 := o_rcvaluef00;
		SELF.o_rcvaluef03 := o_rcvaluef03;
		SELF.o_rcvaluec12 := o_rcvaluec12;
		SELF.o_rcvaluee55 := o_rcvaluee55;
		SELF.o_rcvaluei60 := o_rcvaluei60;
		SELF.o_rcvaluea47 := o_rcvaluea47;
		SELF.o_rcvaluec10 := o_rcvaluec10;
		SELF.o_rcvalues66 := o_rcvalues66;
		SELF.o_rcvaluee57 := o_rcvaluee57;
		SELF.o_rcvalueS65 := o_rcvalueS65;
		SELF.o_rcvaluec14 := o_rcvaluec14;
	 
		SELF.p_rc1 := p_rc1;
		SELF.p_rc2 := p_rc2;
		SELF.p_rc3 := p_rc3;
		SELF.p_rc4 := p_rc4;
		SELF.p_vl1 := p_vl1;
		SELF.p_vl2 := p_vl2;
		SELF.p_vl3 := p_vl3;
		SELF.p_vl4 := p_vl4;
 
		SELF.d_rc1 := d_rc1;
		SELF.d_rc2 := d_rc2;
		SELF.d_rc3 := d_rc3;
		SELF.d_rc4 := d_rc4;
		SELF.d_vl1 := d_vl1;
		SELF.d_vl2 := d_vl2;
		SELF.d_vl3 := d_vl3;
		SELF.d_vl4 := d_vl4;
 
		SELF.o_rc1 := o_rc1;
		SELF.o_rc2 := o_rc2;
		SELF.o_rc3 := o_rc3;
		SELF.o_rc4 := o_rc4;
		SELF.o_vl1 := o_vl1;
		SELF.o_vl2 := o_vl2;
		SELF.o_vl3 := o_vl3;
		SELF.o_vl4 := o_vl4;
	 
		SELF.v_rc1 := v_rc1;
		SELF.v_rc2 := v_rc2;
		SELF.v_rc3 := v_rc3;
		SELF.v_rc4 := v_rc4;
		SELF.v_vl1 := v_vl1;
		SELF.v_vl2 := v_vl2;
		SELF.v_vl3 := v_vl3;
		SELF.v_vl4 := v_vl4;
		SELF.rc4_2 := rc4_2;
		SELF.rc3_2 := rc3_2;
		SELF.rc1_3 := rc1_3;
		SELF.rc2_2 := rc2_2;
		SELF.rc1_2 := rc1_2;
		SELF._rc_inq := _rc_inq;
		
		SELF.rc5_c214 := rc5_c214;
		
		SELF.rc5_1 := rc5_1;

		SELF.rc1 := reasonCodes[1].hri;
		SELF.rc2 := reasonCodes[2].hri;
		SELF.rc3 := reasonCodes[3].hri;
		SELF.rc4 := reasonCodes[4].hri;
		SELF.rc5 := reasonCodes[5].hri;
		
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)RVT1503_0_1;
		SELF.model_name := 'RVT1503_DEBUG'; 

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)RVT1503_0_1;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
