
IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT;

EXPORT RVG1502_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

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
			INTEGER hdr_source_profile_index;
			STRING ver_sources;
			STRING ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;
			INTEGER add_input_address_score;
			BOOLEAN add_input_isbestmatch;
			STRING add_input_advo_vacancy;
			STRING add_input_advo_res_or_bus;
			INTEGER add_input_naprop;
			BOOLEAN add_input_pop;
			INTEGER property_owned_total;
			BOOLEAN add_curr_isbestmatch;
			INTEGER add_curr_occ_index;
			STRING add_curr_advo_res_or_bus;
			INTEGER add_curr_avm_auto_val;
			INTEGER add_curr_naprop;
			BOOLEAN add_curr_pop;
			INTEGER add_prev_naprop;
			INTEGER addrs_5yr;
			INTEGER addrs_10yr;
			INTEGER addrs_15yr;
			STRING telcordia_type;
			INTEGER ssns_per_adl;
			INTEGER addrs_per_adl;
			INTEGER adls_per_ssn;
			INTEGER adls_per_addr_curr;
			INTEGER ssns_per_addr_curr;
			INTEGER invalid_ssns_per_adl;
			INTEGER inq_count12;
			INTEGER inq_auto_count;
			INTEGER inq_auto_count01;
			INTEGER inq_auto_count03;
			INTEGER inq_auto_count06;
			INTEGER inq_auto_count12;
			INTEGER inq_auto_count24;
			INTEGER inq_communications_count12;
			INTEGER inq_highriskcredit_count;
			INTEGER inq_highriskcredit_count01;
			INTEGER inq_highriskcredit_count03;
			INTEGER inq_highriskcredit_count06;
			INTEGER inq_highriskcredit_count12;
			INTEGER inq_highriskcredit_count24;
			STRING pb_total_dollars;
			INTEGER infutor_nap;
			INTEGER stl_inq_count90;
			INTEGER stl_inq_count180;
			INTEGER stl_inq_count12;
			INTEGER attr_addrs_last30;
			INTEGER attr_addrs_last90;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_num_unrel_liens30;
			INTEGER attr_num_unrel_liens90;
			INTEGER attr_num_unrel_liens180;
			INTEGER attr_num_unrel_liens12;
			INTEGER attr_num_unrel_liens24;
			INTEGER attr_num_unrel_liens36;
			INTEGER attr_num_unrel_liens60;
			INTEGER attr_num_rel_liens30;
			INTEGER attr_num_rel_liens90;
			INTEGER attr_num_rel_liens180;
			INTEGER attr_num_rel_liens12;
			INTEGER attr_num_rel_liens24;
			INTEGER attr_num_rel_liens36;
			INTEGER attr_num_rel_liens60;
			INTEGER attr_eviction_count;
			INTEGER attr_eviction_count90;
			INTEGER attr_eviction_count180;
			INTEGER attr_eviction_count12;
			INTEGER attr_eviction_count24;
			INTEGER attr_eviction_count36;
			INTEGER attr_eviction_count60;
			INTEGER filing_count;
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
			INTEGER felony_count;
			STRING college_file_type;
			BOOLEAN college_attendance;
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
			boolean phn_validation_problem;
			INTEGER validation_problem;
			INTEGER tot_liens;
			INTEGER tot_liens_w_type;
			INTEGER has_derog;
			STRING18 rv_4seg_riskview_5_0;
			BOOLEAN verprob_seg;
			BOOLEAN derog_seg;
			BOOLEAN propowner_seg;
			BOOLEAN other_seg;
			INTEGER sysdate;
//  RiskView Indicator variables
			STRING iv_rv5_unscorable;
			STRING rv_a41_prop_owner;
			integer rv_a47_curr_avm_autoval;
			integer rv_a50_pb_total_dollars;
			INTEGER rv_c12_source_profile_index;
			INTEGER rv_c13_attr_addrs_recency;
			INTEGER rv_c14_addrs_5yr;
			INTEGER rv_c14_addrs_10yr;
			INTEGER rv_c14_addrs_15yr;
			INTEGER rv_c21_stl_inq_count12;
			INTEGER rv_c21_stl_recency;
			INTEGER rv_d31_bk_filing_count;
			STRING rv_d32_criminal_x_felony;
			INTEGER rv_d32_criminal_count;
			STRING rv_d33_eviction_recency;
			INTEGER rv_d34_attr_liens_recency;
			STRING rv_e55_college_ind;
			integer rv_f00_addr_not_ver_w_ssn;
			INTEGER rv_f01_inp_addr_address_score;
			STRING26 rv_f03_address_match;
			INTEGER rv_f04_curr_add_occ_index;
			INTEGER rv_i60_inq_count12;
			INTEGER rv_i60_inq_hiriskcred_count12;
			INTEGER rv_i60_inq_comm_count12;
			INTEGER rv_i60_inq_auto_count12;
			INTEGER rv_i60_inq_auto_recency;
			INTEGER rv_i60_inq_hiriskcred_recency;
			INTEGER rv_s66_adlperssn_count;
			STRING rv_l71_add_curr_business;
// verprob seqment variables
			REAL verprob_subscore0;
			REAL verprob_subscore1;
			REAL verprob_subscore2;
			REAL verprob_subscore3;
			REAL verprob_subscore4;
			REAL verprob_subscore5;
			REAL verprob_subscore6;
			REAL verprob_subscore7;
			REAL verprob_subscore8;
			REAL verprob_subscore9;
			REAL verprob_subscore10;
			REAL verprob_subscore11;
			REAL verprob_rawscore;
			REAL verprob_lnoddsscore;
			REAL verprob_probscore;
			STRING verprob_aacd_0;
			REAL verprob_dist_0;
			STRING verprob_aacd_1;
			REAL verprob_dist_1;
			STRING verprob_aacd_2;
			REAL verprob_dist_2;
			STRING verprob_aacd_3;
			REAL verprob_dist_3;
			STRING verprob_aacd_4;
			REAL verprob_dist_4;
			STRING verprob_aacd_5;
			REAL verprob_dist_5;
			STRING verprob_aacd_6;
			REAL verprob_dist_6;
			STRING verprob_aacd_7;
			REAL verprob_dist_7;
			STRING verprob_aacd_8;
			REAL verprob_dist_8;
			STRING verprob_aacd_9;
			REAL verprob_dist_9;
			STRING verprob_aacd_10;
			REAL verprob_dist_10;
			STRING verprob_aacd_11;
			REAL verprob_dist_11;
// derog segment variables
			REAL derog_subscore0;
			REAL derog_subscore1;
			REAL derog_subscore2;
			REAL derog_subscore3;
			REAL derog_subscore4;
			REAL derog_subscore5;
			REAL derog_subscore6;
			REAL derog_subscore7;
			REAL derog_subscore8;
			REAL derog_subscore9;
			REAL derog_subscore10;
			REAL derog_subscore11;
			REAL derog_rawscore;
			REAL derog_lnoddsscore;
			REAL derog_probscore;
			STRING derog_aacd_0;
			REAL derog_dist_0;
			STRING derog_aacd_1;
			REAL derog_dist_1;
			STRING derog_aacd_2;
			REAL derog_dist_2;
			STRING derog_aacd_3;
			REAL derog_dist_3;
			STRING derog_aacd_4;
			REAL derog_dist_4;
			STRING derog_aacd_5;
			REAL derog_dist_5;
			STRING derog_aacd_6;
			REAL derog_dist_6;
			STRING derog_aacd_7;
			REAL derog_dist_7;
			STRING derog_aacd_8;
			REAL derog_dist_8;
			STRING derog_aacd_9;
			REAL derog_dist_9;
			STRING derog_aacd_10;
			REAL derog_dist_10;
			STRING derog_aacd_11;
			REAL derog_dist_11;
//  propowner segment variables
			REAL propowner_subscore0;
			REAL propowner_subscore1;
			REAL propowner_subscore2;
			REAL propowner_subscore3;
			REAL propowner_subscore4;
			REAL propowner_subscore5;
			REAL propowner_subscore6;
			REAL propowner_subscore7;
			REAL propowner_subscore8;
			REAL propowner_rawscore;
			REAL propowner_lnoddsscore;
			REAL propowner_probscore;
			STRING propowner_aacd_0;
			REAL propowner_dist_0;
			STRING propowner_aacd_1;
			REAL propowner_dist_1;
			STRING propowner_aacd_2;
			REAL propowner_dist_2;
			STRING propowner_aacd_3;
			REAL propowner_dist_3;
			STRING propowner_aacd_4;
			REAL propowner_dist_4;
			STRING propowner_aacd_5;
			REAL propowner_dist_5;
			STRING propowner_aacd_6;
			REAL propowner_dist_6;
			STRING propowner_aacd_7;
			REAL propowner_dist_7;
			STRING propowner_aacd_8;
			REAL propowner_dist_8;
// other segment variables
			REAL other_subscore0;
			REAL other_subscore1;
			REAL other_subscore2;
			REAL other_subscore3;
			REAL other_subscore4;
			REAL other_subscore5;
			REAL other_subscore6;
			REAL other_subscore7;
			REAL other_subscore8;
			REAL other_subscore9;
			REAL other_subscore10;
			REAL other_rawscore;
			REAL other_lnoddsscore;
			REAL other_probscore;
			STRING other_aacd_0;
			REAL other_dist_0;
			STRING other_aacd_1;
			REAL other_dist_1;
			STRING other_aacd_2;
			REAL other_dist_2;
			STRING other_aacd_3;
			REAL other_dist_3;
			STRING other_aacd_4;
			REAL other_dist_4;
			STRING other_aacd_5;
			REAL other_dist_5;
			STRING other_aacd_6;
			REAL other_dist_6;
			STRING other_aacd_7;
			REAL other_dist_7;
			STRING other_aacd_8;
			REAL other_dist_8;
			STRING other_aacd_9;
			REAL other_dist_9;
			STRING other_aacd_10;
			REAL other_dist_10;
			
			INTEGER base;
			INTEGER points;
			INTEGER odds;
			REAL lnoddsscore;
			INTEGER score_lnodds;
			INTEGER score_lnodds_capped;
			BOOLEAN ov_ssnprior;
			BOOLEAN ov_corrections;
			INTEGER deceased;
			INTEGER _ov_pts_lost_c132_b3;
			
			INTEGER rvg1502_0_1;          //  This is the score return by this model
			
			REAL _ov_pts_lost_raw;
			REAL verprob_dist_12;
			STRING verprob_aacd_12;
			REAL verprob_rcvaluec21;
			REAL verprob_rcvaluef04;
			REAL verprob_rcvaluea50;
			REAL verprob_rcvaluel73;
			REAL verprob_rcvalueS65;
			REAL verprob_rcvalued32;
			REAL verprob_rcvalued33;
			REAL verprob_rcvaluea47;
			REAL verprob_rcvaluei60;
			REAL verprob_rcvaluef00;
			REAL verprob_rcvaluea41;
			REAL verprob_rcvaluee55;
			REAL verprob_rcvaluec12;
			REAL verprob_rcvaluec14;
			REAL derog_dist_12;
			STRING derog_aacd_12;
			REAL derog_rcvaluec21;
			REAL derog_rcvaluea50;
			REAL derog_rcvaluei60;
			REAL derog_rcvalueS65;
			REAL derog_rcvalued32;
			REAL derog_rcvalued33;
			REAL derog_rcvalued31;
			REAL derog_rcvaluea47;
			REAL derog_rcvaluef01;
			REAL derog_rcvaluea41;
			REAL derog_rcvaluec12;
			REAL derog_rcvaluel73;
			REAL derog_rcvaluec14;
			REAL propowner_dist_9;
			STRING propowner_aacd_9;
			REAL propowner_rcvaluea50;
			REAL propowner_rcvaluel73;
			REAL propowner_rcvalued34;
			REAL propowner_rcvaluea47;
			REAL propowner_rcvaluei60;
			REAL propowner_rcvaluef00;
			REAL propowner_rcvaluef03;
			REAL propowner_rcvalueS65;
			REAL propowner_rcvalues66;
			REAL propowner_rcvaluec14;
			REAL other_dist_11;
			STRING other_aacd_11;
			REAL other_rcvaluea47;
			REAL other_rcvaluei60;
			REAL other_rcvaluel71;
			REAL other_rcvaluea50;
			REAL other_rcvaluef01;
			REAL other_rcvaluef03;
			REAL other_rcvaluea41;
			REAL other_rcvaluec13;
			REAL other_rcvaluec12;
			REAL other_rcvaluel73;
			REAL other_rcvalueS65;
			REAL other_rcvaluec14;
		 
			STRING propowner_rc1;
			STRING propowner_rc2;
			STRING propowner_rc3;
			STRING propowner_rc4;
			REAL propowner_vl1;
			REAL propowner_vl2;
			REAL propowner_vl3;
			REAL propowner_vl4;
			STRING other_rc1;
			STRING other_rc2;
			STRING other_rc3;
			STRING other_rc4;
			REAL other_vl1;
			REAL other_vl2;
			REAL other_vl3;
			REAL other_vl4;
			STRING verprob_rc1;
			STRING verprob_rc2;
			STRING verprob_rc3;
			STRING verprob_rc4;
			REAL verprob_vl1;
			REAL verprob_vl2;
			REAL verprob_vl3;
			REAL verprob_vl4;
			STRING derog_rc1;
			STRING derog_rc2;
			STRING derog_rc3;
			STRING derog_rc4;
			REAL derog_vl1;
			REAL derog_vl2;
			REAL derog_vl3;
			REAL derog_vl4;
			STRING _rc_seg_c139;
			STRING _rc_seg_c140;
			STRING _rc_seg_c138;
			STRING _rc_seg_c141;
			STRING _rc_seg;
			STRING rc1_3;
			STRING rc4_2;
			STRING rc2_2;
			STRING rc3_2;
			STRING rc1_2;
			STRING _rc_inq;
			STRING rc5_c146;

			STRING rc5_1;
			 
			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
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
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_advo_res_or_bus         := le.advo_addr_hist1.Residential_or_Business_Ind;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.ssn_verification.adlperssn_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count90                  := le.impulse.count90;
	stl_inq_count180                 := le.impulse.count180;
	stl_inq_count12                  := le.impulse.count12;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_num_rel_liens30             := le.bjl.liens_released_count30;
	attr_num_rel_liens90             := le.bjl.liens_released_count90;
	attr_num_rel_liens180            := le.bjl.liens_released_count180;
	attr_num_rel_liens12             := le.bjl.liens_released_count12;
	attr_num_rel_liens24             := le.bjl.liens_released_count24;
	attr_num_rel_liens36             := le.bjl.liens_released_count36;
	attr_num_rel_liens60             := le.bjl.liens_released_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	filing_count                     := le.bjl.filing_count;
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
	felony_count                     := le.bjl.felony_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	
//====================================================================
//===   Determine if this consumer has any sufficiently verified   ===
//====================================================================		
	num_dob_match_level := (integer)input_dob_match_level;
	nas_summary_ver := if((integer)ssnlength > 0 and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0);
	nap_summary_ver := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);
	infutor_nap_ver := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);
	dob_ver := if(dobpop and num_dob_match_level >= 5, 1, 0);
	
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
													 or (INTEGER)rc_hrisksic = 2225 
													 or (INTEGER)rc_hrisksicphone = 2225 
													 or (boolean)(integer)addr_validation_problem 
													 or (boolean)phn_validation_problem 
													 or rc_ssndobflag = '1' 
													 or rc_pwssndobflag = '1', 1, 0);
													 
													 
//====================================================================
//===   Determine if this consumer has any liens                   ===
//====================================================================			
	tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
	             sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), 
							     if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
							     if(liens_recent_released_count = NULL, 0, liens_recent_released_count), 
							     if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));
	
	tot_liens_w_type := if(max(liens_unrel_LT_ct, 
	                           liens_rel_LT_ct, 
														 liens_unrel_SC_ct, 
														 liens_rel_SC_ct, 
														 liens_unrel_CJ_ct, 
														 liens_rel_CJ_ct, 
														 liens_unrel_FT_ct, 
														 liens_rel_FT_ct, 
														 liens_unrel_OT_ct, 
														 liens_rel_OT_ct, 
														 liens_unrel_ST_ct, 
														 liens_rel_ST_ct, 
														 liens_unrel_FC_ct, 
														 liens_rel_FC_ct, 
														 liens_unrel_O_ct, 
														 liens_rel_O_ct) = NULL, NULL, 
												sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), 
												    if(liens_rel_LT_ct   = NULL, 0, liens_rel_LT_ct), 
														if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), 
														if(liens_rel_SC_ct   = NULL, 0, liens_rel_SC_ct), 
														if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), 
														if(liens_rel_CJ_ct   = NULL, 0, liens_rel_CJ_ct), 
														if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), 
														if(liens_rel_FT_ct   = NULL, 0, liens_rel_FT_ct), 
														if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), 
														if(liens_rel_OT_ct   = NULL, 0, liens_rel_OT_ct), 
														if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), 
														if(liens_rel_ST_ct   = NULL, 0, liens_rel_ST_ct), 
														if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), 
														if(liens_rel_FC_ct   = NULL, 0, liens_rel_FC_ct), 
														if(liens_unrel_O_ct  = NULL, 0, liens_unrel_O_ct), 
														if(liens_rel_O_ct    = NULL, 0, liens_rel_O_ct)));
	
	
	
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
	derog_seg := rv_4seg_riskview_5_0[1] = '2';
	propowner_seg := rv_4seg_riskview_5_0[1] = '3';
	other_seg := rv_4seg_riskview_5_0[1] = '4';
	
//========================================================================================  
//===   for round 1 validation hardcode the sysdate to the same value seen in the validation file
//          sysdate := common.sas_date('20150501');	 
//===   for round 2 validation set the sysdate to the archive date
//========================================================================================  	
       sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
 	
//==============================================================
//=             Based on the information collected above       =
//=             Set the Risk View indicators for this          =
//=             consumer.                                      =
//==============================================================		
	
  
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) , '1', '0');
	
	rv_a41_prop_owner := map(
	    not(truedid)                                                                                   => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => '1',
	                                                                                                      '0');
	
	rv_a47_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	rv_a50_pb_total_dollars := map(
	    not(truedid)            => NULL,
	    pb_total_dollars = ''   => -1,
	                              // (integer)pb_total_dollars);
	                              -1);  // reason code edit for iBehavior removal
	
	rv_c12_source_profile_index := if(not(truedid), NULL, hdr_source_profile_index);
	
	rv_c13_attr_addrs_recency := map(
	    not(truedid)               => NULL,
	    (boolean)attr_addrs_last30 => 1,
	    (boolean)attr_addrs_last90 => 3,
	    (boolean)attr_addrs_last12 => 12,
	    (boolean)attr_addrs_last24 => 24,
	    (boolean)attr_addrs_last36 => 36,
	    (boolean)addrs_5yr         => 60,
	    (boolean)addrs_10yr        => 120,
	    (boolean)addrs_15yr        => 180,
	    addrs_per_adl > 0          => 999,
	                                  0);
	
	rv_c14_addrs_5yr := map(
	    not(truedid)          => NULL,
	    not(add_curr_pop)     => -1,
	                             min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));
	
	rv_c14_addrs_10yr := map(
	    not(truedid)        => NULL,
	    not(add_curr_pop)   => -1,
	                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));
	
	rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));
	
	rv_c21_stl_inq_count12 := if(not(truedid), NULL, min(if(STL_Inq_count12 = NULL, -NULL, STL_Inq_count12), 999));
	
	rv_c21_stl_recency := map(
	    not(truedid)         => NULL,
	    stl_inq_count90 > 0  => 3,
	    stl_inq_count180 > 0 => 6,
	    stl_inq_count12 > 0  => 12,
	                            0);
	
	rv_d31_bk_filing_count := if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999));
	
//rv_d32_criminal_x_felony := if(not(truedid), '', trim(min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim(min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));
  rv_d32_criminal_x_felony := if(not(truedid), '', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

	
	rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));
	
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
	
	rv_d34_attr_liens_recency := map(
	    not(truedid)                                                              => NULL,
	    (boolean)attr_num_rel_liens30 or (boolean)attr_num_unrel_liens30          => 1,
	    (boolean)attr_num_rel_liens90 or (boolean)attr_num_unrel_liens90          => 3,
	    (boolean)attr_num_rel_liens180 or (boolean)attr_num_unrel_liens180        => 6,
	    (boolean)attr_num_rel_liens12 or (boolean)attr_num_unrel_liens12          => 12,
	    (boolean)attr_num_rel_liens24 or (boolean)attr_num_unrel_liens24          => 24,
	    (boolean)attr_num_rel_liens36 or (boolean)attr_num_unrel_liens36          => 36,
	    (boolean)attr_num_rel_liens60 or (boolean)attr_num_unrel_liens60          => 60,
	    liens_historical_released_count > 0 or liens_historical_unreleased_ct > 0 => 99,
	                                                                                 0);
	
	rv_e55_college_ind := map(
	    not(truedid)                           => ' ',
	    (college_file_type in ['H', 'C', 'A']) => '1',
	    college_attendance                     => '1',
	                                              '0');
	
	rv_f00_addr_not_ver_w_ssn := if(not(truedid and (integer)ssnlength > 0), NULL, (integer)(nas_summary in [4, 7, 9]));
	
	rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	rv_f03_address_match := map(
	    not(truedid)                                => '                          ',
	    add_input_isbestmatch                       => '4 INPUT=CURR              ',
	    not(add_input_pop) and add_curr_isbestmatch => '3 CURRAVAIL + NOINPUTPOP  ',
	    add_input_pop and add_curr_isbestmatch      => '2 CURRAVAIL + INPUTNOTCURR',
	    add_curr_pop                                => '1 CURR ONHDRONLY          ',
	    add_input_pop                               => '0 INPUTPOP NOHISTAVAIL    ',
	                                                   '');
	
	rv_f04_curr_add_occ_index := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);
	
	rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));
	
	rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));
	
	rv_i60_inq_comm_count12 := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));
	
	rv_i60_inq_auto_count12 := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));
	
	rv_i60_inq_auto_recency := map(
	    not(truedid)     => NULL,
	    (boolean)inq_auto_count01      => 1,
	    (boolean)inq_auto_count03      => 3,
	    (boolean)inq_auto_count06      => 6,
	    (boolean)inq_auto_count12      => 12,
	    (boolean)inq_auto_count24      => 24,
	    (boolean)inq_auto_count        => 99,
	                                      0);
	
	rv_i60_inq_hiriskcred_recency := map(
	    not(truedid)                             => NULL,
	    (boolean)inq_highRiskCredit_count01      => 1,
	    (boolean)inq_highRiskCredit_count03      => 3,
	    (boolean)inq_highRiskCredit_count06      => 6,
	    (boolean)inq_highRiskCredit_count12      => 12,
	    (boolean)inq_highRiskCredit_count24      => 24,
	    (boolean)inq_highRiskCredit_count        => 99,
	                                                0);
	
	rv_s66_adlperssn_count := map(
	    not((integer)ssnlength > 0) => NULL,
	    adls_per_ssn = 0   => 1,
	                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));
	
	rv_l71_add_curr_business := map(
	    not(add_curr_pop)                                                       => ' ',
	    (trim(trim(add_curr_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => '1',
	                                                                               '0');
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the verprob seqment                  =
//==============================================================	
	
	verprob_subscore0 := map(
	    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn < 1          => 0.074056,
	    1 <= rv_f00_addr_not_ver_w_ssn                                              => -0.172853,
	    not truedid                                                                 => 0,
	    not((integer)ssnlength > 0)                                                 => 0.074056,
	                                                                                   0);
	
	verprob_subscore1 := map(
	    (rv_d32_criminal_x_felony in [' ', '0-0'])                                                    => 0.038613,
	    (rv_d32_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.550064,
	                                                                                                     0);
	
	verprob_subscore2 := map(
	    NULL < rv_c21_stl_recency AND rv_c21_stl_recency < 3 => 0.045941,
	    3 <= rv_c21_stl_recency                              => -0.537709,
	                                                            0);
	 
	verprob_subscore3 := map(
	    not truedid                                                                          => 0,
	    NULL < (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 3     => 0.08209,
	    3 <= (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 36      => -0.647515,
	    36 <= (integer)rv_d33_eviction_recency                                               => -0.405317,
	                                                                                            0);
	
	verprob_subscore4 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => -0.040802,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 62587       => -0.069145,
	    62587 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 105431 => 0.011677,
	    105431 <= rv_a47_curr_avm_autoval                                     => 0.142778,
	                                                                             0);
	
	verprob_subscore5 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 0.084972,
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 6   => -0.010415,
	    6 <= rv_c14_addrs_15yr                             => -0.053478,
	                                                          0);
	
	verprob_subscore6 := map(
	    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 3    => 0.07029,
	    3 <= rv_f04_curr_add_occ_index                                        => -0.124366,
	                                                                             0);
	
	verprob_subscore7 := map(
	    not(truedid)                                                            => 0,
	    NULL < (integer)rv_a41_prop_owner AND (integer)rv_a41_prop_owner < 1    => -0.078599,
	    1 <= (integer)rv_a41_prop_owner                                         => 0.306277,
	                                                                               0);
	
	verprob_subscore8 := map(
	    not(truedid)                                                          => 0,
	    rv_e55_college_ind = '0'                                              => -0.020151,
	    rv_e55_college_ind = '1'                                              => 0.171739,
	                                                                             0);
	
	verprob_subscore9 := map(
	    NULL < rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 1 => 0.024557,
	    1 <= rv_i60_inq_auto_recency                                   => -0.160631,
	                                                                      0);
	
	verprob_subscore10 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.048964,
	    1 <= rv_i60_inq_hiriskcred_recency                                         => -0.339632,
	                                                                                  0);
	
	verprob_subscore11 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 16 => -0.057435,
	    16 <= rv_a50_pb_total_dollars                                   => 0.135897,
	                                                                       0);
	
	verprob_rawscore := verprob_subscore0 +
	    verprob_subscore1 +
	    verprob_subscore2 +
	    verprob_subscore3 +
	    verprob_subscore4 +
	    verprob_subscore5 +
	    verprob_subscore6 +
	    verprob_subscore7 +
	    verprob_subscore8 +
	    verprob_subscore9 +
	    verprob_subscore10 +
	    verprob_subscore11;
	
	verprob_lnoddsscore := verprob_rawscore + 0.573879;
	
	verprob_probscore := exp(verprob_lnoddsscore) / (1 + exp(verprob_lnoddsscore));
	
	verprob_aacd_0 := map(
	    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn < 1 => 'F00',
	    1 <= rv_f00_addr_not_ver_w_ssn                                     => 'F00',
			not truedid                                                        => 'C12',
	                                                                          '');
	
	verprob_dist_0 := verprob_subscore0 - 0.074056;
	
	verprob_aacd_1 := map(
	    (rv_d32_criminal_x_felony in [' ', '0-0'])                                                    => 'D32',
	    (rv_d32_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                                     '');
	
	verprob_dist_1 := verprob_subscore1 - 0.038613;
	
	verprob_aacd_2 := map(
	    NULL < rv_c21_stl_recency AND rv_c21_stl_recency < 3    => 'C21',
	    3 <= rv_c21_stl_recency                                 => 'C21',
	                                                               'C12');
	
	verprob_dist_2 := verprob_subscore2 - 0.045941;
	
	verprob_aacd_3 := map(
	    not truedid                                                                           => 'C12',
	    NULL < (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 3      => 'D33',
	    3 <= (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 36       => 'D33',
	    36 <= (integer)rv_d33_eviction_recency                                                => 'D33',
	                                                                                             'C12');
	
	verprob_dist_3 := verprob_subscore3 - 0.08209;
	
	verprob_aacd_4 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 62587       => 'A47',
	    62587 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 105431 => 'A47',
	    105431 <= rv_a47_curr_avm_autoval                                     => 'A47',
	                                                                             'C12');
	
	verprob_dist_4 := verprob_subscore4 - 0.142778;
	
	verprob_aacd_5 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 'C14',
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 6   => 'C14',
	    6 <= rv_c14_addrs_15yr                             => 'C14',
	                                                          'C12');
	
	verprob_dist_5 := verprob_subscore5 - 0.084972;
	
	verprob_aacd_6 := map(
	    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 3   => 'F04',
	    3 <= rv_f04_curr_add_occ_index                                       => 'F04',
			not truedid                                                          => 'C12',
			not add_curr_pop                                                     => 'F04', 
			                                                                        '');                                                                        
	
	verprob_dist_6 := verprob_subscore6 - 0.07029;
	
	verprob_aacd_7 := map(
	    not truedid                                                           => 'C12',
	    NULL < (integer)rv_a41_prop_owner AND (integer)rv_a41_prop_owner < 1  => 'A41',
	    1 <= (integer)rv_a41_prop_owner                                       => 'A41',
	                                                                             'C12');
	
	verprob_dist_7 := verprob_subscore7 - 0.306277;
	
	verprob_aacd_8 := map(
	    not truedid                                      => 'C12',
	    rv_e55_college_ind = '0'                         => 'E55',
	    rv_e55_college_ind = '1'                         => 'E55',
	                                                        'C12');
	
	verprob_dist_8 := verprob_subscore8 - 0.171739;
	
	verprob_aacd_9 := map(
	    NULL < rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 1   => 'I60',
	    1 <= rv_i60_inq_auto_recency                                     => 'I60',
	                                                                        'C12');
	
	verprob_dist_9 := verprob_subscore9 - 0.024557;
	
	verprob_aacd_10 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1   => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency                                           => 'I60',
	                                                                                    'C12');
	
	verprob_dist_10 := verprob_subscore10 - 0.048964;
	
	verprob_aacd_11 := 'C12';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 16 => 'A50',
	    // 16 <= rv_a50_pb_total_dollars                                   => 'A50',
	                                                                       // 'C12');
	
	verprob_dist_11 := IF(RV_A50_PB_TOTAL_DOLLARS=NULL, verprob_subscore11 - 0.135897, 0);
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the derog seqment                    =
//==============================================================		
	
	derog_subscore0 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => -0.232636,
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 0.003788,
	    100 <= rv_f01_inp_addr_address_score                                        => 0.040323,
	    not truedid                                                                 => 0,
	    not add_input_pop                                                           => 0.040323,
	                                                                                   0);
	
	derog_subscore1 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 0.038643,
	    1 <= rv_d32_criminal_count AND rv_d32_criminal_count < 2   => -0.235107,
	    2 <= rv_d32_criminal_count AND rv_d32_criminal_count < 3   => -0.335045,
	    3 <= rv_d32_criminal_count                                 => -0.809381,
	                                                                  0);
	
	derog_subscore2 := map(
	    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count < 2 => 0.011936,
	    2 <= rv_d31_bk_filing_count                                  => -0.454849,
	                                                                    0);
	
	derog_subscore3 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 0.086191,
	    1 <= rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 2   => -0.333593,
	    2 <= rv_c21_stl_inq_count12                                  => -0.501977,
	                                                                    0);
	
	derog_subscore4 := map(
	    not truedid                                                                         => 0,
	    NULL < (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 3    => 0.058355,
	    3 <=   (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 12   => -0.495169,
	    12 <=  (integer)rv_d33_eviction_recency                                             => -0.131432,
	                                                                                           0);
	
	derog_subscore5 := map(
	    NULL < (integer)rv_c12_source_profile_index AND (integer)rv_c12_source_profile_index < 4   => -0.101133,
	    4 <=   (integer)rv_c12_source_profile_index AND (integer)rv_c12_source_profile_index < 5   => -0.072006,
	    5 <=   (integer)rv_c12_source_profile_index AND (integer)rv_c12_source_profile_index < 6   => 0.003092,
	    6 <=   (integer)rv_c12_source_profile_index AND (integer)rv_c12_source_profile_index < 8   => 0.052199,
	    8 <=   (integer)rv_c12_source_profile_index AND (integer)rv_c12_source_profile_index < 9   => 0.138048,
	    9 <=   (integer)rv_c12_source_profile_index                                                => 0.205393,
	                                                                                                  0);
	
	derog_subscore6 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0  => 0.020753,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 114240 => -0.094481,
	    114240 <= rv_a47_curr_avm_autoval                                => 0.054445,
	                                                                        0);
	
	derog_subscore7 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 0.061115,
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => -0.014593,
	    4 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => -0.197353,
	    6 <= rv_c14_addrs_5yr                            => -0.607615,
	                                                        0);
	
	derog_subscore8 := map(
	    not truedid                                                             => 0,
	    NULL < (integer)rv_a41_prop_owner AND (integer)rv_a41_prop_owner < 1    => -0.127207,
	    1 <=   (integer)rv_a41_prop_owner                                       => 0.191209,
	                                                                               0);
	
	derog_subscore9 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.056574,
	    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.1982,
	                                                                                  0);
	
	derog_subscore10 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 0.008484,
	    1 <= rv_i60_inq_comm_count12                                   => -1.040936,
	                                                                      0);
	
	derog_subscore11 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0   => -0.047731,
	    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 154   => -0.030834,
	    154 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 402 => 0.088306,
	    402 <= rv_a50_pb_total_dollars                                   => 0.146603,
	                                                                        0);
	
	derog_rawscore := derog_subscore0 +
	    derog_subscore1 +
	    derog_subscore2 +
	    derog_subscore3 +
	    derog_subscore4 +
	    derog_subscore5 +
	    derog_subscore6 +
	    derog_subscore7 +
	    derog_subscore8 +
	    derog_subscore9 +
	    derog_subscore10 +
	    derog_subscore11;
	
	derog_lnoddsscore := derog_rawscore + 0.540239;
	
	derog_probscore := exp(derog_lnoddsscore) / (1 + exp(derog_lnoddsscore));
	
	derog_aacd_0 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => 'F01',
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                        => 'F01',
			not truedid                                                                 => 'C12',
	                                                                                   '');
	
	derog_dist_0 := derog_subscore0 - 0.040323;
	
	derog_aacd_1 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 'D32',
	    1 <= rv_d32_criminal_count AND rv_d32_criminal_count < 2   => 'D32',
	    2 <= rv_d32_criminal_count AND rv_d32_criminal_count < 3   => 'D32',
	    3 <= rv_d32_criminal_count                                 => 'D32',
	                                                                  '');
	
	derog_dist_1 := derog_subscore1 - 0.038643;
	
	derog_aacd_2 := map(
	    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count < 2 => 'D31',
	    2 <= rv_d31_bk_filing_count                                  => 'D31',
	                                                                    '');
	
	derog_dist_2 := derog_subscore2 - 0.011936;
	
	derog_aacd_3 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 2   => 'C21',
	    2 <= rv_c21_stl_inq_count12                                  => 'C21',
	                                                                    '');
	
	derog_dist_3 := derog_subscore3 - 0.086191;
	
	derog_aacd_4 := map(
	    not truedid                                                                         => '',
	    NULL < (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 3    => 'D33',
	    3 <=   (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 12   => 'D33',
	    12 <=  (integer)rv_d33_eviction_recency                                             => 'D33',
	                                                                                           '');
	
	derog_dist_4 := derog_subscore4 - 0.058355;
	
	derog_aacd_5 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 4 => 'C12',
	    4 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 5   => 'C12',
	    5 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 6   => 'C12',
	    6 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 8   => 'C12',
	    8 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 9   => 'C12',
	    9 <= rv_c12_source_profile_index                                       => 'C12',
	                                                                              '');
	
	derog_dist_5 := derog_subscore5 - 0.205393;
	
	derog_aacd_6 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0  => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 114240 => 'A47',
	    114240 <= rv_a47_curr_avm_autoval                                => 'A47',
	                                                                        '');
	
	derog_dist_6 := derog_subscore6 - 0.054445;
	
	derog_aacd_7 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 'C14',
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => 'C14',
	    4 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => 'C14',
	    6 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	derog_dist_7 := derog_subscore7 - 0.061115;
	
	derog_aacd_8 := map(
	    not truedid                                                            => '',
	    NULL < (integer)rv_a41_prop_owner AND (integer)rv_a41_prop_owner < 1   => 'A41',
	    1 <= (integer)rv_a41_prop_owner                                        => 'A41',
	                                                                              '');
	
	derog_dist_8 := derog_subscore8 - 0.191209;
	
	derog_aacd_9 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	derog_dist_9 := derog_subscore9 - 0.056574;
	
	derog_aacd_10 := map(
	    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_comm_count12                                   => 'I60',
	                                                                      '');
	
	derog_dist_10 := derog_subscore10 - 0.008484;
	
	derog_aacd_11 := '';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0   => 'A50',
	    // 0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 154   => 'A50',
	    // 154 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 402 => 'A50',
	    // 402 <= rv_a50_pb_total_dollars                                   => 'A50',
	                                                                        // '');
	
	derog_dist_11 := IF(RV_A50_PB_TOTAL_DOLLARS=NULL, derog_subscore11 - 0.146603, 0);
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the propowner seqment                =
//==============================================================		
	
	propowner_subscore0 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0      => -0.049878,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 62558      => -0.181021,
	    62558 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 99299 => -0.081538,
	    99299 <= rv_a47_curr_avm_autoval                                     => 0.121556,
	                                                                            0);
	
	propowner_subscore1 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 119 => -0.007342,
	    119 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 918 => 0.006217,
	    918 <= rv_a50_pb_total_dollars                                   => 0.024265,
	                                                                        0);
	
	propowner_subscore2 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2 => 0.06536,
	    2 <= rv_c14_addrs_10yr                             => -0.061937,
	                                                          0);
	
	propowner_subscore3 := map(
	    NULL < rv_d34_attr_liens_recency AND rv_d34_attr_liens_recency < 1 => 0.019353,
	    1 <= rv_d34_attr_liens_recency                                     => -0.26657,
	                                                                          0);
	
	propowner_subscore4 := map(
	    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn < 1    => 0.019129,
	    1 <= rv_f00_addr_not_ver_w_ssn                                        => -0.327953,
	    not truedid                                                           => 0,
	    not((integer)ssnlength > 0)                                           => 0.019129,
	                                                                             0);
	
	propowner_subscore5 := map(
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR'])  => -0.070842,
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])        =>  0.024785,
	                                                                                      0);
	
	propowner_subscore6 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.062526,
	    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => -0.232199,
	    3 <= rv_i60_inq_count12                              => -0.594426,
	                                                            0);
	
	propowner_subscore7 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.065746,
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => -0.424566,
	    3 <= rv_i60_inq_hiriskcred_recency                                         => -0.259092,
	                                                                                  0);
	
	propowner_subscore8 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.038037,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.016137,
	    3 <= rv_s66_adlperssn_count                                  => -0.102959,
	    not((integer)ssnlength > 0)                                  => 0.038037,
	                                                                    0);
	
	propowner_rawscore := propowner_subscore0 +
	    propowner_subscore1 +
	    propowner_subscore2 +
	    propowner_subscore3 +
	    propowner_subscore4 +
	    propowner_subscore5 +
	    propowner_subscore6 +
	    propowner_subscore7 +
	    propowner_subscore8;
	
	propowner_lnoddsscore := propowner_rawscore + 1.340462;
	
	propowner_probscore := exp(propowner_lnoddsscore) / (1 + exp(propowner_lnoddsscore));
	
	propowner_aacd_0 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0      => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 62558      => 'A47',
	    62558 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 99299 => 'A47',
	    99299 <= rv_a47_curr_avm_autoval                                     => 'A47',
	                                                                            '');
	
	propowner_dist_0 := propowner_subscore0 - 0.121556;
	
	propowner_aacd_1 := '';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 119 => 'A50',
	    // 119 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 918 => 'A50',
	    // 918 <= rv_a50_pb_total_dollars                                   => 'A50',
	                                                                        // '');
	
	propowner_dist_1 := IF(RV_A50_PB_TOTAL_DOLLARS=NULL, propowner_subscore1 - 0.024265, 0);
	
	propowner_aacd_2 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2 => 'C14',
	    2 <= rv_c14_addrs_10yr                             => 'C14',
	                                                          '');
	
	propowner_dist_2 := propowner_subscore2 - 0.06536;
	
	propowner_aacd_3 := map(
	    NULL < rv_d34_attr_liens_recency AND rv_d34_attr_liens_recency < 1 => 'D34',
	    1 <= rv_d34_attr_liens_recency                                     => 'D34',
	                                                                          '');
	
	propowner_dist_3 := propowner_subscore3 - 0.019353;
	
	propowner_aacd_4 := map(
	    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn < 1 => 'F00',
	    1 <= rv_f00_addr_not_ver_w_ssn                                     => 'F00',
			not truedid                                                        => 'C12',
	                                                                          '');
	
	propowner_dist_4 := propowner_subscore4 - 0.019129;
	
	propowner_aacd_5 := map(
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])       => 'F03',
	                                                                                    '');
	
	propowner_dist_5 := propowner_subscore5 - 0.024785;
	
	propowner_aacd_6 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 3   => 'I60',
	    3 <= rv_i60_inq_count12                              => 'I60',
	                                                            '');
	
	propowner_dist_6 := propowner_subscore6 - 0.062526;
	
	propowner_aacd_7 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => 'I60',
	    3 <= rv_i60_inq_hiriskcred_recency                                         => 'I60',
	                                                                                  '');
	
	propowner_dist_7 := propowner_subscore7 - 0.065746;
	
	propowner_aacd_8 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	propowner_dist_8 := propowner_subscore8 - 0.038037;
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the other seqment                    =
//==============================================================		
	
	other_subscore0 := map(
	    not truedid                                                            => 0,
	    NULL < (integer)rv_a41_prop_owner AND (integer)rv_a41_prop_owner < 1   => -0.015855,
	    1 <= (integer)rv_a41_prop_owner                                        => 0.226313,
	                                                                              0);
	
	other_subscore1 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => 0.012014,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 83640       => -0.202035,
	    83640 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 156960 => -0.040013,
	    156960 <= rv_a47_curr_avm_autoval                                     => 0.196531,
	                                                                             0);
	
	other_subscore2 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 32 => -0.080811,
	    32 <= rv_a50_pb_total_dollars                                   => 0.117002,
	                                                                       0);
	
	other_subscore3 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 3 => -0.059129,
	    3 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 4   => -0.05581,
	    4 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 6   => -0.011895,
	    6 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 8   => 0.022401,
	    8 <= rv_c12_source_profile_index                                       => 0.189181,
	                                                                              0);
	
	other_subscore4 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60 => -0.035543,
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 0.000016,
	    120 <= rv_c13_attr_addrs_recency                                    => 0.067363,
	                                                                           0);
	
	other_subscore5 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 0.021925,
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => -0.007544,
	    4 <= rv_c14_addrs_5yr                            => -0.121268,
	                                                        0);
	
	other_subscore6 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => -0.17855,
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 0.007489,
	    100 <= rv_f01_inp_addr_address_score                                        => 0.035482,
	    not truedid                                                                 => 0,
	    not add_input_pop                                                           => 0.035482,
	                                                                                   0);
	
	other_subscore7 := map(
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => -0.041847,
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])       => 0.025247,
	                                                                                    0);
	
	other_subscore8 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 0.032824,
	    1 <= rv_i60_inq_auto_count12                                   => -0.223376,
	                                                                      0);
	
	other_subscore9 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.054422,
	    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.329991,
	                                                                                  0);
																																										
	
	other_subscore10 := map(
			not add_curr_pop                                                                     => 0,
	    NULL < (integer)rv_l71_add_curr_business AND (integer)rv_l71_add_curr_business < 1   => 0.00271,
	    1 <=   (integer)rv_l71_add_curr_business                                             => -0.352345,
	                                                                                            0);
	
	other_rawscore := other_subscore0 +
	    other_subscore1 +
	    other_subscore2 +
	    other_subscore3 +
	    other_subscore4 +
	    other_subscore5 +
	    other_subscore6 +
	    other_subscore7 +
	    other_subscore8 +
	    other_subscore9 +
	    other_subscore10;
	
	other_lnoddsscore := other_rawscore + 0.930604;
	
	other_probscore := exp(other_lnoddsscore) / (1 + exp(other_lnoddsscore));
	
	other_aacd_0 := map(
	    not truedid                                                            => '',
	    NULL < (integer)rv_a41_prop_owner AND (integer)rv_a41_prop_owner < 1   => 'A41',
	    1 <=   (integer)rv_a41_prop_owner                                      => 'A41',
	                                                                              '');
	
	other_dist_0 := other_subscore0 - 0.226313;
	
	other_aacd_1 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 83640       => 'A47',
	    83640 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 156960 => 'A47',
	    156960 <= rv_a47_curr_avm_autoval                                     => 'A47',
	                                                                             '');
	
	other_dist_1 := other_subscore1 - 0.196531;
	
	other_aacd_2 := '';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 32 => 'A50',
	    // 32 <= rv_a50_pb_total_dollars                                   => 'A50',
	                                                                       // '');
	
	other_dist_2 := IF(RV_A50_PB_TOTAL_DOLLARS=NULL, other_subscore2 - 0.117002, 0);
	
	other_aacd_3 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 3 => 'C12',
	    3 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 4   => 'C12',
	    4 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 6   => 'C12',
	    6 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 8   => 'C12',
	    8 <= rv_c12_source_profile_index                                       => 'C12',
	                                                                              '');
	
	other_dist_3 := other_subscore3 - 0.189181;
	
	other_aacd_4 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60 => 'C13',
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 'C13',
	    120 <= rv_c13_attr_addrs_recency                                    => 'C13',
	                                                                           '');
	
	other_dist_4 := other_subscore4 - 0.067363;
	
	other_aacd_5 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 'C14',
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => 'C14',
	    4 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	other_dist_5 := other_subscore5 - 0.021925;
	
	other_aacd_6 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50 => 'F01',
	    50 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                        => 'F01',
			not truedid                                                                 => 'C12',
	                                                                                   '');
	
	other_dist_6 := other_subscore6 - 0.035482;
	
	other_aacd_7 := map(
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])       => 'F03',
	                                                                                    '');
	
	other_dist_7 := other_subscore7 - 0.025247;
	
	other_aacd_8 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_auto_count12                                   => 'I60',
	                                                                      '');
	
	other_dist_8 := other_subscore8 - 0.032824;
	
	other_aacd_9 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	other_dist_9 := other_subscore9 - 0.054422;
	
	other_aacd_10 := map(
	    not add_curr_pop                                                                    => 'F04',
	    NULL < (integer)rv_l71_add_curr_business AND (integer)rv_l71_add_curr_business < 1  => 'L71',
	    1 <=   (integer)rv_l71_add_curr_business                                            => 'L71',
	                                                                                           '');
	
	other_dist_10 := other_subscore10 - 0.00271;
	
	base := 750;
	points := 50;
	odds := 20;
	
	lnoddsscore := if(max((integer)verprob_seg * verprob_lnoddsscore, (integer)derog_seg * derog_lnoddsscore, (integer)propowner_seg * propowner_lnoddsscore, (integer)other_seg * other_lnoddsscore) = NULL, NULL, sum(if((integer)verprob_seg * verprob_lnoddsscore = NULL, 0, (integer)verprob_seg * verprob_lnoddsscore), if((integer)derog_seg * derog_lnoddsscore = NULL, 0, (integer)derog_seg * derog_lnoddsscore), if((integer)propowner_seg * propowner_lnoddsscore = NULL, 0, (integer)propowner_seg * propowner_lnoddsscore), if((integer)other_seg * other_lnoddsscore = NULL, 0, (integer)other_seg * other_lnoddsscore)));
	
	score_lnodds := round(points * (lnoddsscore - ln(odds)) / ln(2) + base);
	
	score_lnodds_capped := min(900, if(max(501, score_lnodds) = NULL, -NULL, max(501, score_lnodds)));
	
	ov_ssnprior := rc_ssndobflag = '1' or rc_pwssndobflag = '1';
	
	ov_corrections := rc_hrisksic = '2225';
	
//==============================================================
//=             Additional logic for deceased                  =
//==============================================================	
	
	deceased := map(
	    rc_decsflag = '1'                                                        => 1,
	    rc_ssndod != 0                                                           => 1,
	    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0   => 2,
			rc_decsflag = '0'                                                        => 0,
	                                                                                NULL);
	
	_ov_pts_lost_c132_b3 := 550 - score_lnodds_capped;
	
	rvg1502_0_1 := map(
	    deceased > 0                                                  => 200,
	    iv_rv5_unscorable = '1'                                       => 222,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections) => 550,
	                                                                     score_lnodds_capped);
	
	_ov_pts_lost_raw := map(
	    deceased > 0                                                  => NULL,
	    iv_rv5_unscorable = '1'                                       => NULL,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections) => ln(2) * _ov_pts_lost_c132_b3 / points,
	                                                                     0);
	
//=========================================================
//==  start calculating the RC values for verprob segment =
//=========================================================	
	
	verprob_dist_12 := _ov_pts_lost_raw;
	
	verprob_aacd_12 := map(
	    ov_corrections  => 'L73',
	    ov_ssnprior     => 'S65',
			                   '');
	
	verprob_rcvaluec21 := (integer)(verprob_aacd_0 = 'C21') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'C21') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C21') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C21') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C21') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C21') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C21') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C21') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C21') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C21') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C21') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C21') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C21') * verprob_dist_12;
	
	verprob_rcvaluef04 := (integer)(verprob_aacd_0 = 'F04') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'F04') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'F04') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'F04') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'F04') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'F04') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'F04') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'F04') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'F04') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'F04') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'F04') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'F04') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'F04') * verprob_dist_12;
	
	verprob_rcvaluea50 := (integer)(verprob_aacd_0 = 'A50') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'A50') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A50') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A50') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A50') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A50') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A50') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A50') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A50') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A50') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A50') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A50') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'A50') * verprob_dist_12;
	
	verprob_rcvaluel73 := (integer)(verprob_aacd_0 = 'L73') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'L73') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'L73') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'L73') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'L73') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'L73') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'L73') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'L73') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'L73') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'L73') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'L73') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'L73') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'L73') * verprob_dist_12;
	
	verprob_rcvalueS65 := (integer)(verprob_aacd_0 = 'S65') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'S65') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'S65') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'S65') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'S65') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'S65') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'S65') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'S65') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'S65') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'S65') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'S65') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'S65') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'S65') * verprob_dist_12;
	
	verprob_rcvalued32 := (integer)(verprob_aacd_0 = 'D32') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'D32') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'D32') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'D32') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'D32') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'D32') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'D32') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'D32') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'D32') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'D32') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'D32') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'D32') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'D32') * verprob_dist_12;
	
	verprob_rcvalued33 := (integer)(verprob_aacd_0 = 'D33') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'D33') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'D33') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'D33') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'D33') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'D33') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'D33') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'D33') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'D33') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'D33') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'D33') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'D33') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'D33') * verprob_dist_12;
	
	verprob_rcvaluea47 := (integer)(verprob_aacd_0 = 'A47') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'A47') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A47') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A47') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A47') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A47') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A47') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A47') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A47') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A47') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A47') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A47') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'A47') * verprob_dist_12;
	
	verprob_rcvaluei60 := (integer)(verprob_aacd_0 = 'I60') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'I60') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'I60') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'I60') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'I60') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'I60') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'I60') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'I60') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'I60') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'I60') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'I60') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'I60') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'I60') * verprob_dist_12;
	
	verprob_rcvaluef00 := (integer)(verprob_aacd_0 = 'F00') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'F00') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'F00') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'F00') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'F00') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'F00') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'F00') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'F00') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'F00') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'F00') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'F00') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'F00') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'F00') * verprob_dist_12;
	
	verprob_rcvaluea41 := (integer)(verprob_aacd_0 = 'A41') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'A41') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A41') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A41') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A41') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A41') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A41') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A41') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A41') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A41') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A41') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A41') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'A41') * verprob_dist_12;
	
	verprob_rcvaluee55 := (integer)(verprob_aacd_0 = 'E55') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'E55') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'E55') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'E55') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'E55') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'E55') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'E55') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'E55') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'E55') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'E55') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'E55') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'E55') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'E55') * verprob_dist_12;
	
	verprob_rcvaluec12 := (integer)(verprob_aacd_0 = 'C12') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'C12') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C12') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C12') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C12') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C12') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C12') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C12') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C12') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C12') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C12') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C12') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C12') * verprob_dist_12;
	
	verprob_rcvaluec14 := (integer)(verprob_aacd_0 = 'C14') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'C14') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C14') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C14') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C14') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C14') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C14') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C14') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C14') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C14') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C14') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C14') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C14') * verprob_dist_12;
	
//=========================================================
//==  start calculating the RC values for derog segment   =
//=========================================================	
	
	derog_dist_12 := _ov_pts_lost_raw;
	
	derog_aacd_12 := map(
	    ov_corrections  => 'L73',
	    ov_ssnprior     => 'S65',
			                   '');
	
	derog_rcvaluec21 := (integer)(derog_aacd_0 = 'C21') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'C21') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C21') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C21') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C21') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C21') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C21') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C21') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C21') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C21') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C21') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C21') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C21') * derog_dist_12;
	
	derog_rcvaluea50 := (integer)(derog_aacd_0 = 'A50') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'A50') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A50') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A50') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A50') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A50') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A50') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A50') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A50') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A50') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A50') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'A50') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'A50') * derog_dist_12;
	
	derog_rcvaluei60 := (integer)(derog_aacd_0 = 'I60') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'I60') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'I60') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'I60') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'I60') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'I60') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'I60') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'I60') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'I60') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'I60') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'I60') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'I60') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'I60') * derog_dist_12;
	
	derog_rcvalueS65 := (integer)(derog_aacd_0 = 'S65') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'S65') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'S65') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'S65') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'S65') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'S65') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'S65') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'S65') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'S65') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'S65') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'S65') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'S65') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'S65') * derog_dist_12;
	
	derog_rcvalued32 := (integer)(derog_aacd_0 = 'D32') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'D32') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'D32') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'D32') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'D32') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'D32') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'D32') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'D32') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'D32') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'D32') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'D32') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'D32') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'D32') * derog_dist_12;
	
	derog_rcvalued33 := (integer)(derog_aacd_0 = 'D33') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'D33') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'D33') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'D33') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'D33') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'D33') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'D33') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'D33') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'D33') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'D33') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'D33') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'D33') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'D33') * derog_dist_12;
	
	derog_rcvalued31 := (integer)(derog_aacd_0 = 'D31') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'D31') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'D31') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'D31') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'D31') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'D31') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'D31') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'D31') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'D31') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'D31') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'D31') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'D31') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'D31') * derog_dist_12;
	
	derog_rcvaluea47 := (integer)(derog_aacd_0 = 'A47') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'A47') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A47') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A47') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A47') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A47') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A47') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A47') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A47') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A47') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A47') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'A47') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'A47') * derog_dist_12;
	
	derog_rcvaluef01 := (integer)(derog_aacd_0 = 'F01') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'F01') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'F01') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'F01') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'F01') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'F01') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'F01') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'F01') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'F01') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'F01') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'F01') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'F01') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'F01') * derog_dist_12;
	
	derog_rcvaluea41 := (integer)(derog_aacd_0 = 'A41') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'A41') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A41') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A41') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A41') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A41') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A41') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A41') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A41') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A41') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A41') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'A41') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'A41') * derog_dist_12;
	
	derog_rcvaluec12 := (integer)(derog_aacd_0 = 'C12') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'C12') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C12') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C12') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C12') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C12') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C12') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C12') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C12') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C12') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C12') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C12') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C12') * derog_dist_12;
	
	derog_rcvaluel73 := (integer)(derog_aacd_0 = 'L73') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'L73') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'L73') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'L73') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'L73') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'L73') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'L73') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'L73') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'L73') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'L73') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'L73') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'L73') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'L73') * derog_dist_12;
	
	derog_rcvaluec14 := (integer)(derog_aacd_0 = 'C14') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'C14') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C14') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C14') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C14') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C14') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C14') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C14') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C14') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C14') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C14') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C14') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C14') * derog_dist_12;
	
//=========================================================
//==  start calculating the RC values for propowner segment =
//=========================================================		
	
	propowner_dist_9 := _ov_pts_lost_raw;
	
	propowner_aacd_9 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                  '');
	
	propowner_rcvaluea50 := (integer)(propowner_aacd_0 = 'A50') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'A50') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'A50') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'A50') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'A50') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'A50') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'A50') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'A50') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'A50') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'A50') * propowner_dist_9;
	
	propowner_rcvaluel73 := (integer)(propowner_aacd_0 = 'L73') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'L73') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'L73') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'L73') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'L73') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'L73') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'L73') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'L73') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'L73') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'L73') * propowner_dist_9;
	
	propowner_rcvalued34 := (integer)(propowner_aacd_0 = 'D34') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'D34') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'D34') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'D34') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'D34') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'D34') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'D34') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'D34') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'D34') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'D34') * propowner_dist_9;
	
	propowner_rcvaluea47 := (integer)(propowner_aacd_0 = 'A47') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'A47') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'A47') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'A47') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'A47') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'A47') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'A47') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'A47') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'A47') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'A47') * propowner_dist_9;
	
	propowner_rcvaluei60 := (integer)(propowner_aacd_0 = 'I60') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'I60') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'I60') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'I60') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'I60') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'I60') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'I60') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'I60') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'I60') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'I60') * propowner_dist_9;
	
	propowner_rcvaluef00 := (integer)(propowner_aacd_0 = 'F00') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'F00') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'F00') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'F00') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'F00') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'F00') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'F00') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'F00') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'F00') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'F00') * propowner_dist_9;
	
	propowner_rcvaluef03 := (integer)(propowner_aacd_0 = 'F03') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'F03') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'F03') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'F03') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'F03') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'F03') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'F03') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'F03') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'F03') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'F03') * propowner_dist_9;
	
	propowner_rcvalueS65 := (integer)(propowner_aacd_0 = 'S65') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'S65') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'S65') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'S65') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'S65') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'S65') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'S65') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'S65') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'S65') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'S65') * propowner_dist_9;
	
propowner_rcvalueC12 := (integer)(propowner_aacd_0 = 'C12') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'C12') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'C12') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'C12') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'C12') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'C12') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'C12') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'C12') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'C12') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'C12') * propowner_dist_9;	
	
	
	propowner_rcvalues66 := (integer)(propowner_aacd_0 = 'S66') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'S66') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'S66') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'S66') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'S66') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'S66') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'S66') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'S66') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'S66') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'S66') * propowner_dist_9;
	
	propowner_rcvaluec14 := (integer)(propowner_aacd_0 = 'C14') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'C14') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'C14') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'C14') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'C14') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'C14') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'C14') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'C14') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'C14') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'C14') * propowner_dist_9;
	
//=========================================================
//==  start calculating the RC values for other segment   =
//=========================================================		
	
	other_dist_11 := _ov_pts_lost_raw;
	
	other_aacd_11 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                  '');
	
	other_rcvaluea47 := (integer)(other_aacd_0 = 'A47') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A47') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A47') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A47') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A47') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A47') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A47') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A47') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A47') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A47') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A47') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A47') * other_dist_11;
	
	other_rcvaluei60 := (integer)(other_aacd_0 = 'I60') * other_dist_0 +
	    (integer)(other_aacd_1 = 'I60') * other_dist_1 +
	    (integer)(other_aacd_2 = 'I60') * other_dist_2 +
	    (integer)(other_aacd_3 = 'I60') * other_dist_3 +
	    (integer)(other_aacd_4 = 'I60') * other_dist_4 +
	    (integer)(other_aacd_5 = 'I60') * other_dist_5 +
	    (integer)(other_aacd_6 = 'I60') * other_dist_6 +
	    (integer)(other_aacd_7 = 'I60') * other_dist_7 +
	    (integer)(other_aacd_8 = 'I60') * other_dist_8 +
	    (integer)(other_aacd_9 = 'I60') * other_dist_9 +
	    (integer)(other_aacd_10 = 'I60') * other_dist_10 +
	    (integer)(other_aacd_11 = 'I60') * other_dist_11;
	
	other_rcvaluel71 := (integer)(other_aacd_0 = 'L71') * other_dist_0 +
	    (integer)(other_aacd_1 = 'L71') * other_dist_1 +
	    (integer)(other_aacd_2 = 'L71') * other_dist_2 +
	    (integer)(other_aacd_3 = 'L71') * other_dist_3 +
	    (integer)(other_aacd_4 = 'L71') * other_dist_4 +
	    (integer)(other_aacd_5 = 'L71') * other_dist_5 +
	    (integer)(other_aacd_6 = 'L71') * other_dist_6 +
	    (integer)(other_aacd_7 = 'L71') * other_dist_7 +
	    (integer)(other_aacd_8 = 'L71') * other_dist_8 +
	    (integer)(other_aacd_9 = 'L71') * other_dist_9 +
	    (integer)(other_aacd_10 = 'L71') * other_dist_10 +
	    (integer)(other_aacd_11 = 'L71') * other_dist_11;
	
	other_rcvaluea50 := (integer)(other_aacd_0 = 'A50') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A50') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A50') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A50') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A50') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A50') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A50') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A50') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A50') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A50') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A50') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A50') * other_dist_11;
	
	other_rcvaluef01 := (integer)(other_aacd_0 = 'F01') * other_dist_0 +
	    (integer)(other_aacd_1 = 'F01') * other_dist_1 +
	    (integer)(other_aacd_2 = 'F01') * other_dist_2 +
	    (integer)(other_aacd_3 = 'F01') * other_dist_3 +
	    (integer)(other_aacd_4 = 'F01') * other_dist_4 +
	    (integer)(other_aacd_5 = 'F01') * other_dist_5 +
	    (integer)(other_aacd_6 = 'F01') * other_dist_6 +
	    (integer)(other_aacd_7 = 'F01') * other_dist_7 +
	    (integer)(other_aacd_8 = 'F01') * other_dist_8 +
	    (integer)(other_aacd_9 = 'F01') * other_dist_9 +
	    (integer)(other_aacd_10 = 'F01') * other_dist_10 +
	    (integer)(other_aacd_11 = 'F01') * other_dist_11;
	
	other_rcvaluef03 := (integer)(other_aacd_0 = 'F03') * other_dist_0 +
	    (integer)(other_aacd_1 = 'F03') * other_dist_1 +
	    (integer)(other_aacd_2 = 'F03') * other_dist_2 +
	    (integer)(other_aacd_3 = 'F03') * other_dist_3 +
	    (integer)(other_aacd_4 = 'F03') * other_dist_4 +
	    (integer)(other_aacd_5 = 'F03') * other_dist_5 +
	    (integer)(other_aacd_6 = 'F03') * other_dist_6 +
	    (integer)(other_aacd_7 = 'F03') * other_dist_7 +
	    (integer)(other_aacd_8 = 'F03') * other_dist_8 +
	    (integer)(other_aacd_9 = 'F03') * other_dist_9 +
	    (integer)(other_aacd_10 = 'F03') * other_dist_10 +
	    (integer)(other_aacd_11 = 'F03') * other_dist_11;
	
other_rcvaluef04 := (integer)(other_aacd_0 = 'F04') * other_dist_0 +
	    (integer)(other_aacd_1 = 'F04') * other_dist_1 +
	    (integer)(other_aacd_2 = 'F04') * other_dist_2 +
	    (integer)(other_aacd_3 = 'F04') * other_dist_3 +
	    (integer)(other_aacd_4 = 'F04') * other_dist_4 +
	    (integer)(other_aacd_5 = 'F04') * other_dist_5 +
	    (integer)(other_aacd_6 = 'F04') * other_dist_6 +
	    (integer)(other_aacd_7 = 'F04') * other_dist_7 +
	    (integer)(other_aacd_8 = 'F04') * other_dist_8 +
	    (integer)(other_aacd_9 = 'F04') * other_dist_9 +
	    (integer)(other_aacd_10 = 'F04') * other_dist_10 +
	    (integer)(other_aacd_11 = 'F04') * other_dist_11;	
	
	
	other_rcvaluea41 := (integer)(other_aacd_0 = 'A41') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A41') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A41') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A41') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A41') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A41') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A41') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A41') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A41') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A41') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A41') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A41') * other_dist_11;
	
	other_rcvaluec13 := (integer)(other_aacd_0 = 'C13') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C13') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C13') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C13') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C13') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C13') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C13') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C13') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C13') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C13') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C13') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C13') * other_dist_11;
	
	other_rcvaluec12 := (integer)(other_aacd_0 = 'C12') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C12') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C12') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C12') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C12') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C12') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C12') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C12') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C12') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C12') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C12') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C12') * other_dist_11;
	
	other_rcvaluel73 := (integer)(other_aacd_0 = 'L73') * other_dist_0 +
	    (integer)(other_aacd_1 = 'L73') * other_dist_1 +
	    (integer)(other_aacd_2 = 'L73') * other_dist_2 +
	    (integer)(other_aacd_3 = 'L73') * other_dist_3 +
	    (integer)(other_aacd_4 = 'L73') * other_dist_4 +
	    (integer)(other_aacd_5 = 'L73') * other_dist_5 +
	    (integer)(other_aacd_6 = 'L73') * other_dist_6 +
	    (integer)(other_aacd_7 = 'L73') * other_dist_7 +
	    (integer)(other_aacd_8 = 'L73') * other_dist_8 +
	    (integer)(other_aacd_9 = 'L73') * other_dist_9 +
	    (integer)(other_aacd_10 = 'L73') * other_dist_10 +
	    (integer)(other_aacd_11 = 'L73') * other_dist_11;
	
	other_rcvalueS65 := (integer)(other_aacd_0 = 'S65') * other_dist_0 +
	    (integer)(other_aacd_1 = 'S65') * other_dist_1 +
	    (integer)(other_aacd_2 = 'S65') * other_dist_2 +
	    (integer)(other_aacd_3 = 'S65') * other_dist_3 +
	    (integer)(other_aacd_4 = 'S65') * other_dist_4 +
	    (integer)(other_aacd_5 = 'S65') * other_dist_5 +
	    (integer)(other_aacd_6 = 'S65') * other_dist_6 +
	    (integer)(other_aacd_7 = 'S65') * other_dist_7 +
	    (integer)(other_aacd_8 = 'S65') * other_dist_8 +
	    (integer)(other_aacd_9 = 'S65') * other_dist_9 +
	    (integer)(other_aacd_10 = 'S65') * other_dist_10 +
	    (integer)(other_aacd_11 = 'S65') * other_dist_11;
	
	other_rcvaluec14 := (integer)(other_aacd_0 = 'C14') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C14') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C14') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C14') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C14') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C14') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C14') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C14') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C14') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C14') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C14') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C14') * other_dist_11;
	
	
//*************************************************************************************//
	//  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	
//======================
//===  PROPOWNER     ===
//======================
	rc_dataset_propowner := DATASET([
	    {'A50', propowner_rcvalueA50},
	    {'L73', propowner_rcvalueL73},
	    {'D34', propowner_rcvalueD34},
	    {'A47', propowner_rcvalueA47},
	    {'I60', propowner_rcvalueI60},
	    {'F00', propowner_rcvalueF00},
	    {'F03', propowner_rcvalueF03},
	    {'S65', propowner_rcvalueS65},
			{'C12', propowner_rcvalueC12},
	    {'S66', propowner_rcvalueS66},
	    {'C14', propowner_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  
	//*************************************************************************************//
	rc_dataset_propowner_sorted := sort(rc_dataset_propowner, rc_dataset_propowner.value);
	
	propowner_rc1 := rc_dataset_propowner_sorted[1].rc;
	propowner_rc2 := rc_dataset_propowner_sorted[2].rc;
	propowner_rc3 := rc_dataset_propowner_sorted[3].rc;
	propowner_rc4 := rc_dataset_propowner_sorted[4].rc;
	
	propowner_vl1 := rc_dataset_propowner_sorted[1].value;
	propowner_vl2 := rc_dataset_propowner_sorted[2].value;
	propowner_vl3 := rc_dataset_propowner_sorted[3].value;
	propowner_vl4 := rc_dataset_propowner_sorted[4].value;
	//*************************************************************************************//
	
	 
//======================
//===  OTHER         ===
//======================
	rc_dataset_other := DATASET([
	    {'A47', other_rcvalueA47},
	    {'I60', other_rcvalueI60},
	    {'L71', other_rcvalueL71},
	    {'A50', other_rcvalueA50},
	    {'F01', other_rcvalueF01},
	    {'F03', other_rcvalueF03},
	    {'F04', other_rcvalueF04},             // added missing value for F04
	    {'A41', other_rcvalueA41},
	    {'C13', other_rcvalueC13},
	    {'C12', other_rcvalueC12},
	    {'L73', other_rcvalueL73},
	    {'S65', other_rcvalueS65},
	    {'C14', other_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  
	//*************************************************************************************//
	rc_dataset_other_sorted := sort(rc_dataset_other, rc_dataset_other.value);
	
	other_rc1 := rc_dataset_other_sorted[1].rc;
	other_rc2 := rc_dataset_other_sorted[2].rc;
	other_rc3 := rc_dataset_other_sorted[3].rc;
	other_rc4 := rc_dataset_other_sorted[4].rc;
	
	other_vl1 := rc_dataset_other_sorted[1].value;
	other_vl2 := rc_dataset_other_sorted[2].value;
	other_vl3 := rc_dataset_other_sorted[3].value;
	other_vl4 := rc_dataset_other_sorted[4].value;
	//*************************************************************************************//
	
	 
//======================
//===  VERPROB       ===
//======================
	rc_dataset_verprob := DATASET([
	    {'C21', verprob_rcvalueC21},
	    {'F04', verprob_rcvalueF04},
	    {'A50', verprob_rcvalueA50},
	    {'L73', verprob_rcvalueL73},
	    {'S65', verprob_rcvalueS65},
	    {'D32', verprob_rcvalueD32},
	    {'D33', verprob_rcvalueD33},
	    {'A47', verprob_rcvalueA47},
	    {'I60', verprob_rcvalueI60},
	    {'F00', verprob_rcvalueF00},
	    {'A41', verprob_rcvalueA41},
	    {'E55', verprob_rcvalueE55},
	    {'C12', verprob_rcvalueC12},
	    {'C14', verprob_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  
	//*************************************************************************************//
	rc_dataset_verprob_sorted := sort(rc_dataset_verprob, rc_dataset_verprob.value);
	
	verprob_rc1 := rc_dataset_verprob_sorted[1].rc;
	verprob_rc2 := rc_dataset_verprob_sorted[2].rc;
	verprob_rc3 := rc_dataset_verprob_sorted[3].rc;
	verprob_rc4 := rc_dataset_verprob_sorted[4].rc;
	
	verprob_vl1 := rc_dataset_verprob_sorted[1].value;
	verprob_vl2 := rc_dataset_verprob_sorted[2].value;
	verprob_vl3 := rc_dataset_verprob_sorted[3].value;
	verprob_vl4 := rc_dataset_verprob_sorted[4].value;
	//*************************************************************************************//
	
	 
//======================
//===  DEROG         ===
//======================
	rc_dataset_derog := DATASET([
	    {'C21', derog_rcvalueC21},
	    {'A50', derog_rcvalueA50},
	    {'I60', derog_rcvalueI60},
	    {'S65', derog_rcvalueS65},
	    {'D32', derog_rcvalueD32},
	    {'D33', derog_rcvalueD33},
	    {'D31', derog_rcvalueD31},
	    {'A47', derog_rcvalueA47},
	    {'F01', derog_rcvalueF01},
	    {'A41', derog_rcvalueA41},
	    {'C12', derog_rcvalueC12},
	    {'L73', derog_rcvalueL73},
	    {'C14', derog_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  
	//*************************************************************************************//
	rc_dataset_derog_sorted := sort(rc_dataset_derog, rc_dataset_derog.value);
	
	derog_rc1 := rc_dataset_derog_sorted[1].rc;
	derog_rc2 := rc_dataset_derog_sorted[2].rc;
	derog_rc3 := rc_dataset_derog_sorted[3].rc;
	derog_rc4 := rc_dataset_derog_sorted[4].rc;
	
	derog_vl1 := rc_dataset_derog_sorted[1].value;
	derog_vl2 := rc_dataset_derog_sorted[2].value;
	derog_vl3 := rc_dataset_derog_sorted[3].value;
	derog_vl4 := rc_dataset_derog_sorted[4].value;
	//*************************************************************************************//
	
	_rc_seg_c139 := map(
	    add_ec1 = 'E' and not(rc_addrvalflag = 'N') or out_z5 = ' '                => 'L70',
	    rc_hrisksic = '2225'                                                       => 'L73',
	    rc_hrisksicphone = '2225'                                                  => 'P87',
	    rc_hriskaddrflag = '2' or rc_ziptypeflag   = '2' 
			                       or (add_input_advo_res_or_bus in ['B', 'D']) 
														 or rc_hriskaddrflag = '4' 
														 or rc_addrcommflag  = '2'                           => 'L71',
	                                                                                  'L72');
	
	_rc_seg_c140 := map(
	    rc_hriskphoneflag = '2' 
			or rc_hphonetypeflag = '2' 
			or (telcordia_type in ['02', '56', '61']) 
			or rc_hphonetypeflag = 'A'                         => 'P86',
	                                                          'P85');
	
	_rc_seg_c138 := map(
	    not((boolean)sufficiently_verified)                => 'F00',
	    adls_per_ssn >= 5 or ssns_per_adl >= 4             => 'S66',
	    invalid_ssns_per_adl >= 1                          => 'S65',
	    rc_ssndobflag = '1'                                => 'S65',
	    rc_pwssndobflag = '1'                              => 'S65',
	    adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 => 'L79',
	    addr_validation_problem = 1                        => _rc_seg_c139,
	    (boolean)Phn_Validation_Problem                    => _rc_seg_c140,
	                                                          'C12');
	
	_rc_seg_c141 := map(
	    felony_count > 0 or criminal_count > 0             => 'D32',
	    stl_inq_count12 > 0                                => 'C21',
	    attr_eviction_count > 0                            => 'D33',
	    liens_unrel_CJ_ct > 0 
			   or liens_rel_CJ_ct > 0 
			   or liens_unrel_SC_ct > 0 
			   or liens_rel_SC_ct > 0 
			   or liens_unrel_FC_ct > 0 
			   or liens_rel_FC_ct > 0 
			   or liens_unrel_O_ct > 0 
			   or liens_rel_O_ct > 0 
			   or tot_liens - tot_liens_w_type > 0             => 'D34',
	                                                          'D31');
	
	_rc_seg := map(
	    VerProb_seg => _rc_seg_c138,
	    Derog_seg   => _rc_seg_c141,
	    Other_seg   => 'A41',
	                   '');
	
	rc1_3 := map(
	    VerProb_seg   => verprob_rc1,
	    Derog_seg     => derog_rc1,
	    PropOwner_seg => propowner_rc1,
	                     other_rc1);
	
	rc4_2 := map(
	    VerProb_seg   => verprob_rc4,
	    Derog_seg     => derog_rc4,
	    PropOwner_seg => propowner_rc4,
	                     other_rc4);
	
	rc2_2 := map(
	    VerProb_seg   => verprob_rc2,
	    Derog_seg     => derog_rc2,
	    PropOwner_seg => propowner_rc2,
	                     other_rc2);
	
	rc3_2 := map(
	    VerProb_seg   => verprob_rc3,
	    Derog_seg     => derog_rc3,
	    PropOwner_seg => propowner_rc3,
	                     other_rc3);
	
	rc1_2 := if(trim(rc1_3, ALL) = ' ', _rc_seg, rc1_3);
	
	
//=======================================================================
//==   Populate the _rc_inq field to be used if there are no other reason
//==   codes populated.
//==   but based on segment this consumer falls into
//=======================================================================
	
	_rc_inq := map(
	    verprob_seg and rv_i60_inq_auto_recency > 0       => 'I60',
	    verprob_seg and rv_i60_inq_hiriskcred_recency > 0 => 'I60',
	    derog_seg and rv_i60_inq_hiriskcred_count12 > 0   => 'I60',
	    derog_seg and rv_i60_inq_comm_count12 > 0         => 'I60',
	    propowner_seg and rv_i60_inq_count12 > 0          => 'I60',
	    other_seg and rv_i60_inq_auto_count12 > 0         => 'I60',
	    other_seg and rv_i60_inq_hiriskcred_count12 > 0   => 'I60',
	                                                         '');
	
	rc5_c146 := map(
	    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => ' ',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => ' ',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => ' ',
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = ''         => ' ',
	                                                         _rc_inq);
	

	
	rc5_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc5_c146, ' ');
	
	rc2 := if((rvg1502_0_1 in [200, 222]), ' ', rc2_2);
	
	rc3 := if((rvg1502_0_1 in [200, 222]), ' ', rc3_2);
	
	rc4 := if((rvg1502_0_1 in [200, 222]), ' ', rc4_2);
	
	rc1 := if((rvg1502_0_1 in [200, 222]), ' ', rc1_2);
	
	rc5 := if((rvg1502_0_1 in [200, 222]), ' ', rc5_1);
	


	//*************************************************************************************//
	//                     RiskView Version 5 - RVG1502_0 Score Overrides
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
													RVG1502_0_1 = 200 => DATASET([{'00'}], HRILayout),
													RVG1502_0_1 = 222 => DATASET([{'00'}], HRILayout),
													RVG1502_0_1 = 900 => DATASET([{'00'}], HRILayout),
																					  	DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.seq := seq;
		SELF.out_z5 := out_z5;
		SELF.out_addr_status := out_addr_status;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
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
		SELF.hdr_source_profile_index := hdr_source_profile_index;
		SELF.ver_sources := ver_sources;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_isbestmatch := add_input_isbestmatch;
		SELF.add_input_advo_vacancy := add_input_advo_vacancy;
		SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.add_curr_isbestmatch := add_curr_isbestmatch;
		SELF.add_curr_occ_index := add_curr_occ_index;
		SELF.add_curr_advo_res_or_bus := add_curr_advo_res_or_bus;
		SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
		SELF.add_curr_naprop := add_curr_naprop;
		SELF.add_curr_pop := add_curr_pop;
		SELF.add_prev_naprop := add_prev_naprop;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.telcordia_type := telcordia_type;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.adls_per_ssn := adls_per_ssn;
		SELF.adls_per_addr_curr := adls_per_addr_curr;
		SELF.ssns_per_addr_curr := ssns_per_addr_curr;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.inq_count12 := inq_count12;
		SELF.inq_auto_count := inq_auto_count;
		SELF.inq_auto_count01 := inq_auto_count01;
		SELF.inq_auto_count03 := inq_auto_count03;
		SELF.inq_auto_count06 := inq_auto_count06;
		SELF.inq_auto_count12 := inq_auto_count12;
		SELF.inq_auto_count24 := inq_auto_count24;
		SELF.inq_communications_count12 := inq_communications_count12;
		SELF.inq_highriskcredit_count := inq_highriskcredit_count;
		SELF.inq_highriskcredit_count01 := inq_highriskcredit_count01;
		SELF.inq_highriskcredit_count03 := inq_highriskcredit_count03;
		SELF.inq_highriskcredit_count06 := inq_highriskcredit_count06;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
		SELF.pb_total_dollars := pb_total_dollars;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count90 := stl_inq_count90;
		SELF.stl_inq_count180 := stl_inq_count180;
		SELF.stl_inq_count12 := stl_inq_count12;
		SELF.attr_addrs_last30 := attr_addrs_last30;
		SELF.attr_addrs_last90 := attr_addrs_last90;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_num_unrel_liens30 := attr_num_unrel_liens30;
		SELF.attr_num_unrel_liens90 := attr_num_unrel_liens90;
		SELF.attr_num_unrel_liens180 := attr_num_unrel_liens180;
		SELF.attr_num_unrel_liens12 := attr_num_unrel_liens12;
		SELF.attr_num_unrel_liens24 := attr_num_unrel_liens24;
		SELF.attr_num_unrel_liens36 := attr_num_unrel_liens36;
		SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
		SELF.attr_num_rel_liens30 := attr_num_rel_liens30;
		SELF.attr_num_rel_liens90 := attr_num_rel_liens90;
		SELF.attr_num_rel_liens180 := attr_num_rel_liens180;
		SELF.attr_num_rel_liens12 := attr_num_rel_liens12;
		SELF.attr_num_rel_liens24 := attr_num_rel_liens24;
		SELF.attr_num_rel_liens36 := attr_num_rel_liens36;
		SELF.attr_num_rel_liens60 := attr_num_rel_liens60;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.filing_count := filing_count;
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
		SELF.felony_count := felony_count;
		SELF.college_file_type := college_file_type;
		SELF.college_attendance := college_attendance;
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
		SELF.propowner_seg := propowner_seg;
		SELF.other_seg := other_seg;
		SELF.sysdate := sysdate;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rv_a41_prop_owner := rv_a41_prop_owner;
		SELF.rv_a47_curr_avm_autoval := rv_a47_curr_avm_autoval;
		SELF.rv_a50_pb_total_dollars := rv_a50_pb_total_dollars;
		SELF.rv_c12_source_profile_index := rv_c12_source_profile_index;
		SELF.rv_c13_attr_addrs_recency := rv_c13_attr_addrs_recency;
		SELF.rv_c14_addrs_5yr := rv_c14_addrs_5yr;
		SELF.rv_c14_addrs_10yr := rv_c14_addrs_10yr;
		SELF.rv_c14_addrs_15yr := rv_c14_addrs_15yr;
		SELF.rv_c21_stl_inq_count12 := rv_c21_stl_inq_count12;
		SELF.rv_c21_stl_recency := rv_c21_stl_recency;
		SELF.rv_d31_bk_filing_count := rv_d31_bk_filing_count;
		SELF.rv_d32_criminal_x_felony := rv_d32_criminal_x_felony;
		SELF.rv_d32_criminal_count := rv_d32_criminal_count;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_d34_attr_liens_recency := rv_d34_attr_liens_recency;
		SELF.rv_e55_college_ind := rv_e55_college_ind;
		SELF.rv_f00_addr_not_ver_w_ssn := rv_f00_addr_not_ver_w_ssn;
		SELF.rv_f01_inp_addr_address_score := rv_f01_inp_addr_address_score;
		SELF.rv_f03_address_match := rv_f03_address_match;
		SELF.rv_f04_curr_add_occ_index := rv_f04_curr_add_occ_index;
		SELF.rv_i60_inq_count12 := rv_i60_inq_count12;
		SELF.rv_i60_inq_hiriskcred_count12 := rv_i60_inq_hiriskcred_count12;
		SELF.rv_i60_inq_comm_count12 := rv_i60_inq_comm_count12;
		SELF.rv_i60_inq_auto_count12 := rv_i60_inq_auto_count12;
		SELF.rv_i60_inq_auto_recency := rv_i60_inq_auto_recency;
		SELF.rv_i60_inq_hiriskcred_recency := rv_i60_inq_hiriskcred_recency;
		SELF.rv_s66_adlperssn_count := rv_s66_adlperssn_count;
		SELF.rv_l71_add_curr_business := rv_l71_add_curr_business;
		SELF.verprob_subscore0 := verprob_subscore0;
		SELF.verprob_subscore1 := verprob_subscore1;
		SELF.verprob_subscore2 := verprob_subscore2;
		SELF.verprob_subscore3 := verprob_subscore3;
		SELF.verprob_subscore4 := verprob_subscore4;
		SELF.verprob_subscore5 := verprob_subscore5;
		SELF.verprob_subscore6 := verprob_subscore6;
		SELF.verprob_subscore7 := verprob_subscore7;
		SELF.verprob_subscore8 := verprob_subscore8;
		SELF.verprob_subscore9 := verprob_subscore9;
		SELF.verprob_subscore10 := verprob_subscore10;
		SELF.verprob_subscore11 := verprob_subscore11;
		SELF.verprob_rawscore := verprob_rawscore;
		SELF.verprob_lnoddsscore := verprob_lnoddsscore;
		SELF.verprob_probscore := verprob_probscore;
		SELF.verprob_aacd_0 := verprob_aacd_0;
		SELF.verprob_dist_0 := verprob_dist_0;
		SELF.verprob_aacd_1 := verprob_aacd_1;
		SELF.verprob_dist_1 := verprob_dist_1;
		SELF.verprob_aacd_2 := verprob_aacd_2;
		SELF.verprob_dist_2 := verprob_dist_2;
		SELF.verprob_aacd_3 := verprob_aacd_3;
		SELF.verprob_dist_3 := verprob_dist_3;
		SELF.verprob_aacd_4 := verprob_aacd_4;
		SELF.verprob_dist_4 := verprob_dist_4;
		SELF.verprob_aacd_5 := verprob_aacd_5;
		SELF.verprob_dist_5 := verprob_dist_5;
		SELF.verprob_aacd_6 := verprob_aacd_6;
		SELF.verprob_dist_6 := verprob_dist_6;
		SELF.verprob_aacd_7 := verprob_aacd_7;
		SELF.verprob_dist_7 := verprob_dist_7;
		SELF.verprob_aacd_8 := verprob_aacd_8;
		SELF.verprob_dist_8 := verprob_dist_8;
		SELF.verprob_aacd_9 := verprob_aacd_9;
		SELF.verprob_dist_9 := verprob_dist_9;
		SELF.verprob_aacd_10 := verprob_aacd_10;
		SELF.verprob_dist_10 := verprob_dist_10;
		SELF.verprob_aacd_11 := verprob_aacd_11;
		SELF.verprob_dist_11 := verprob_dist_11;
		SELF.derog_subscore0 := derog_subscore0;
		SELF.derog_subscore1 := derog_subscore1;
		SELF.derog_subscore2 := derog_subscore2;
		SELF.derog_subscore3 := derog_subscore3;
		SELF.derog_subscore4 := derog_subscore4;
		SELF.derog_subscore5 := derog_subscore5;
		SELF.derog_subscore6 := derog_subscore6;
		SELF.derog_subscore7 := derog_subscore7;
		SELF.derog_subscore8 := derog_subscore8;
		SELF.derog_subscore9 := derog_subscore9;
		SELF.derog_subscore10 := derog_subscore10;
		SELF.derog_subscore11 := derog_subscore11;
		SELF.derog_rawscore := derog_rawscore;
		SELF.derog_lnoddsscore := derog_lnoddsscore;
		SELF.derog_probscore := derog_probscore;
		SELF.derog_aacd_0 := derog_aacd_0;
		SELF.derog_dist_0 := derog_dist_0;
		SELF.derog_aacd_1 := derog_aacd_1;
		SELF.derog_dist_1 := derog_dist_1;
		SELF.derog_aacd_2 := derog_aacd_2;
		SELF.derog_dist_2 := derog_dist_2;
		SELF.derog_aacd_3 := derog_aacd_3;
		SELF.derog_dist_3 := derog_dist_3;
		SELF.derog_aacd_4 := derog_aacd_4;
		SELF.derog_dist_4 := derog_dist_4;
		SELF.derog_aacd_5 := derog_aacd_5;
		SELF.derog_dist_5 := derog_dist_5;
		SELF.derog_aacd_6 := derog_aacd_6;
		SELF.derog_dist_6 := derog_dist_6;
		SELF.derog_aacd_7 := derog_aacd_7;
		SELF.derog_dist_7 := derog_dist_7;
		SELF.derog_aacd_8 := derog_aacd_8;
		SELF.derog_dist_8 := derog_dist_8;
		SELF.derog_aacd_9 := derog_aacd_9;
		SELF.derog_dist_9 := derog_dist_9;
		SELF.derog_aacd_10 := derog_aacd_10;
		SELF.derog_dist_10 := derog_dist_10;
		SELF.derog_aacd_11 := derog_aacd_11;
		SELF.derog_dist_11 := derog_dist_11;
		SELF.propowner_subscore0 := propowner_subscore0;
		SELF.propowner_subscore1 := propowner_subscore1;
		SELF.propowner_subscore2 := propowner_subscore2;
		SELF.propowner_subscore3 := propowner_subscore3;
		SELF.propowner_subscore4 := propowner_subscore4;
		SELF.propowner_subscore5 := propowner_subscore5;
		SELF.propowner_subscore6 := propowner_subscore6;
		SELF.propowner_subscore7 := propowner_subscore7;
		SELF.propowner_subscore8 := propowner_subscore8;
		SELF.propowner_rawscore := propowner_rawscore;
		SELF.propowner_lnoddsscore := propowner_lnoddsscore;
		SELF.propowner_probscore := propowner_probscore;
		SELF.propowner_aacd_0 := propowner_aacd_0;
		SELF.propowner_dist_0 := propowner_dist_0;
		SELF.propowner_aacd_1 := propowner_aacd_1;
		SELF.propowner_dist_1 := propowner_dist_1;
		SELF.propowner_aacd_2 := propowner_aacd_2;
		SELF.propowner_dist_2 := propowner_dist_2;
		SELF.propowner_aacd_3 := propowner_aacd_3;
		SELF.propowner_dist_3 := propowner_dist_3;
		SELF.propowner_aacd_4 := propowner_aacd_4;
		SELF.propowner_dist_4 := propowner_dist_4;
		SELF.propowner_aacd_5 := propowner_aacd_5;
		SELF.propowner_dist_5 := propowner_dist_5;
		SELF.propowner_aacd_6 := propowner_aacd_6;
		SELF.propowner_dist_6 := propowner_dist_6;
		SELF.propowner_aacd_7 := propowner_aacd_7;
		SELF.propowner_dist_7 := propowner_dist_7;
		SELF.propowner_aacd_8 := propowner_aacd_8;
		SELF.propowner_dist_8 := propowner_dist_8;
		SELF.other_subscore0 := other_subscore0;
		SELF.other_subscore1 := other_subscore1;
		SELF.other_subscore2 := other_subscore2;
		SELF.other_subscore3 := other_subscore3;
		SELF.other_subscore4 := other_subscore4;
		SELF.other_subscore5 := other_subscore5;
		SELF.other_subscore6 := other_subscore6;
		SELF.other_subscore7 := other_subscore7;
		SELF.other_subscore8 := other_subscore8;
		SELF.other_subscore9 := other_subscore9;
		SELF.other_subscore10 := other_subscore10;
		SELF.other_rawscore := other_rawscore;
		SELF.other_lnoddsscore := other_lnoddsscore;
		SELF.other_probscore := other_probscore;
		SELF.other_aacd_0 := other_aacd_0;
		SELF.other_dist_0 := other_dist_0;
		SELF.other_aacd_1 := other_aacd_1;
		SELF.other_dist_1 := other_dist_1;
		SELF.other_aacd_2 := other_aacd_2;
		SELF.other_dist_2 := other_dist_2;
		SELF.other_aacd_3 := other_aacd_3;
		SELF.other_dist_3 := other_dist_3;
		SELF.other_aacd_4 := other_aacd_4;
		SELF.other_dist_4 := other_dist_4;
		SELF.other_aacd_5 := other_aacd_5;
		SELF.other_dist_5 := other_dist_5;
		SELF.other_aacd_6 := other_aacd_6;
		SELF.other_dist_6 := other_dist_6;
		SELF.other_aacd_7 := other_aacd_7;
		SELF.other_dist_7 := other_dist_7;
		SELF.other_aacd_8 := other_aacd_8;
		SELF.other_dist_8 := other_dist_8;
		SELF.other_aacd_9 := other_aacd_9;
		SELF.other_dist_9 := other_dist_9;
		SELF.other_aacd_10 := other_aacd_10;
		SELF.other_dist_10 := other_dist_10;
		SELF.base := base;
		SELF.points := points;
		SELF.odds := odds;
		SELF.lnoddsscore := lnoddsscore;
		SELF.score_lnodds := score_lnodds;
		SELF.score_lnodds_capped := score_lnodds_capped;
		SELF.ov_ssnprior := ov_ssnprior;
		SELF.ov_corrections := ov_corrections;
		SELF.deceased := deceased;
		SELF._ov_pts_lost_c132_b3 := _ov_pts_lost_c132_b3;
		SELF.rvg1502_0_1 := rvg1502_0_1;
		SELF._ov_pts_lost_raw := _ov_pts_lost_raw;
		SELF.verprob_dist_12 := verprob_dist_12;
		SELF.verprob_aacd_12 := verprob_aacd_12;
		SELF.verprob_rcvaluec21 := verprob_rcvaluec21;
		SELF.verprob_rcvaluef04 := verprob_rcvaluef04;
		SELF.verprob_rcvaluea50 := verprob_rcvaluea50;
		SELF.verprob_rcvaluel73 := verprob_rcvaluel73;
		SELF.verprob_rcvalueS65 := verprob_rcvalueS65;
		SELF.verprob_rcvalued32 := verprob_rcvalued32;
		SELF.verprob_rcvalued33 := verprob_rcvalued33;
		SELF.verprob_rcvaluea47 := verprob_rcvaluea47;
		SELF.verprob_rcvaluei60 := verprob_rcvaluei60;
		SELF.verprob_rcvaluef00 := verprob_rcvaluef00;
		SELF.verprob_rcvaluea41 := verprob_rcvaluea41;
		SELF.verprob_rcvaluee55 := verprob_rcvaluee55;
		SELF.verprob_rcvaluec12 := verprob_rcvaluec12;
		SELF.verprob_rcvaluec14 := verprob_rcvaluec14;
		SELF.derog_dist_12 := derog_dist_12;
		SELF.derog_aacd_12 := derog_aacd_12;
		SELF.derog_rcvaluec21 := derog_rcvaluec21;
		SELF.derog_rcvaluea50 := derog_rcvaluea50;
		SELF.derog_rcvaluei60 := derog_rcvaluei60;
		SELF.derog_rcvalueS65 := derog_rcvalueS65;
		SELF.derog_rcvalued32 := derog_rcvalued32;
		SELF.derog_rcvalued33 := derog_rcvalued33;
		SELF.derog_rcvalued31 := derog_rcvalued31;
		SELF.derog_rcvaluea47 := derog_rcvaluea47;
		SELF.derog_rcvaluef01 := derog_rcvaluef01;
		SELF.derog_rcvaluea41 := derog_rcvaluea41;
		SELF.derog_rcvaluec12 := derog_rcvaluec12;
		SELF.derog_rcvaluel73 := derog_rcvaluel73;
		SELF.derog_rcvaluec14 := derog_rcvaluec14;
		SELF.propowner_dist_9 := propowner_dist_9;
		SELF.propowner_aacd_9 := propowner_aacd_9;
		SELF.propowner_rcvaluea50 := propowner_rcvaluea50;
		SELF.propowner_rcvaluel73 := propowner_rcvaluel73;
		SELF.propowner_rcvalued34 := propowner_rcvalued34;
		SELF.propowner_rcvaluea47 := propowner_rcvaluea47;
		SELF.propowner_rcvaluei60 := propowner_rcvaluei60;
		SELF.propowner_rcvaluef00 := propowner_rcvaluef00;
		SELF.propowner_rcvaluef03 := propowner_rcvaluef03;
		SELF.propowner_rcvalueS65 := propowner_rcvalueS65;
		SELF.propowner_rcvalues66 := propowner_rcvalues66;
		SELF.propowner_rcvaluec14 := propowner_rcvaluec14;
		SELF.other_dist_11 := other_dist_11;
		SELF.other_aacd_11 := other_aacd_11;
		SELF.other_rcvaluea47 := other_rcvaluea47;
		SELF.other_rcvaluei60 := other_rcvaluei60;
		SELF.other_rcvaluel71 := other_rcvaluel71;
		SELF.other_rcvaluea50 := other_rcvaluea50;
		SELF.other_rcvaluef01 := other_rcvaluef01;
		SELF.other_rcvaluef03 := other_rcvaluef03;
		SELF.other_rcvaluea41 := other_rcvaluea41;
		SELF.other_rcvaluec13 := other_rcvaluec13;
		SELF.other_rcvaluec12 := other_rcvaluec12;
		SELF.other_rcvaluel73 := other_rcvaluel73;
		SELF.other_rcvalueS65 := other_rcvalueS65;
		SELF.other_rcvaluec14 := other_rcvaluec14;
		 
		SELF.propowner_rc1 := propowner_rc1;
		SELF.propowner_rc2 := propowner_rc2;
		SELF.propowner_rc3 := propowner_rc3;
		SELF.propowner_rc4 := propowner_rc4;
		SELF.propowner_vl1 := propowner_vl1;
		SELF.propowner_vl2 := propowner_vl2;
		SELF.propowner_vl3 := propowner_vl3;
		SELF.propowner_vl4 := propowner_vl4;
		 
		SELF.other_rc1 := other_rc1;
		SELF.other_rc2 := other_rc2;
		SELF.other_rc3 := other_rc3;
		SELF.other_rc4 := other_rc4;
		SELF.other_vl1 := other_vl1;
		SELF.other_vl2 := other_vl2;
		SELF.other_vl3 := other_vl3;
		SELF.other_vl4 := other_vl4;
		 
		SELF.verprob_rc1 := verprob_rc1;
		SELF.verprob_rc2 := verprob_rc2;
		SELF.verprob_rc3 := verprob_rc3;
		SELF.verprob_rc4 := verprob_rc4;
		SELF.verprob_vl1 := verprob_vl1;
		SELF.verprob_vl2 := verprob_vl2;
		SELF.verprob_vl3 := verprob_vl3;
		SELF.verprob_vl4 := verprob_vl4;
		 
		SELF.derog_rc1 := derog_rc1;
		SELF.derog_rc2 := derog_rc2;
		SELF.derog_rc3 := derog_rc3;
		SELF.derog_rc4 := derog_rc4;
		SELF.derog_vl1 := derog_vl1;
		SELF.derog_vl2 := derog_vl2;
		SELF.derog_vl3 := derog_vl3;
		SELF.derog_vl4 := derog_vl4;
		SELF._rc_seg_c139 := _rc_seg_c139;
		SELF._rc_seg_c140 := _rc_seg_c140;
		SELF._rc_seg_c138 := _rc_seg_c138;
		SELF._rc_seg_c141 := _rc_seg_c141;
		SELF._rc_seg := _rc_seg;
		SELF.rc1_3 := rc1_3;
		SELF.rc4_2 := rc4_2;
		SELF.rc2_2 := rc2_2;
		SELF.rc3_2 := rc3_2;
		SELF.rc1_2 := rc1_2;
		SELF._rc_inq := _rc_inq;
		SELF.rc5_c146 := rc5_c146;
		
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
		SELF.score := (STRING3)rvg1502_0_1;
		SELF.model_name := 'RVG1502_DEBUG'; 
		

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1502_0_1;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
