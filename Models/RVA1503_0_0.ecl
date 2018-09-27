/*2016-04-05T22:00:09Z (laure fischer)
changed reason code S69 to S65.
*/

IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, std, riskview;

EXPORT RVA1503_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			/* Model Input Variables */
			STRING15 model_name; 
			unsigned4 seq;
			BOOLEAN truedid;
			STRING5 out_z5;
			STRING out_addr_status;
			INTEGER1 nas_summary;
			INTEGER nap_summary;
			INTEGER rc_ssndod;
			STRING1 rc_hriskphoneflag;
			STRING1 rc_hphonetypeflag;
			STRING1 rc_phonevalflag;
			STRING1 rc_hphonevalflag;
			STRING1 rc_pwphonezipflag;
			STRING1 rc_hriskaddrflag;
			STRING1 rc_decsflag;
			STRING1 rc_ssndobflag;
			STRING1 rc_pwssndobflag;
			STRING rc_addrvalflag;
			STRING1 rc_addrcommflag;
			STRING6 rc_hrisksic;
			STRING6 rc_hrisksicphone;
			STRING rc_phonetype;
			STRING1 rc_ziptypeflag;
			DECIMAL4_1 hdr_source_profile;
			DECIMAL4_1 hdr_source_profile_index;
			STRING ver_sources;
			STRING ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;
			INTEGER add_input_address_score;
			BOOLEAN add_input_isbestmatch;
			BOOLEAN add_input_owned_not_occ;
			INTEGER add_input_occ_index;
			STRING add_input_advo_vacancy;
			STRING add_input_advo_res_or_bus;
			INTEGER add_input_avm_auto_val;
			INTEGER add_input_naprop;
			BOOLEAN add_input_pop;
			INTEGER property_owned_total;
			BOOLEAN add_curr_isbestmatch;
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
			INTEGER inq_count;
			INTEGER inq_count01;
			INTEGER inq_count03;
			INTEGER inq_count06;
			INTEGER inq_count12;
			INTEGER inq_count24;
			INTEGER inq_auto_count;
			INTEGER inq_auto_count01;
			INTEGER inq_auto_count03;
			INTEGER inq_auto_count06;
			INTEGER inq_auto_count12;
			INTEGER inq_auto_count24;
			INTEGER inq_banking_count03;
			INTEGER inq_communications_count03;
			INTEGER inq_mortgage_count03;
			INTEGER inq_retail_count03;
			STRING pb_average_dollars;
			STRING pb_total_dollars;
			INTEGER infutor_nap;
			INTEGER stl_inq_count12;
			unsigned1 attr_addrs_last30;
			unsigned1 attr_addrs_last90;
			unsigned1 attr_addrs_last12;
			unsigned1 attr_addrs_last24;
			unsigned1 attr_addrs_last36;
			INTEGER attr_num_aircraft;
			INTEGER attr_eviction_count;
			INTEGER attr_eviction_count90;
			INTEGER attr_eviction_count180;
			INTEGER attr_eviction_count12;
			INTEGER attr_eviction_count24;
			INTEGER attr_eviction_count36;
			INTEGER attr_eviction_count60;
			INTEGER attr_num_nonderogs;
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
			INTEGER watercraft_count;
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
			INTEGER phn_validation_problem;
			INTEGER validation_problem;
			INTEGER tot_liens;
			INTEGER tot_liens_w_type;
		  INTEGER has_derog;
			STRING18 rv_4seg_riskview_5_0;
			BOOLEAN verprob_seg;
			BOOLEAN derog_seg;
			BOOLEAN owner_seg;
			BOOLEAN other_seg;
			INTEGER sysdate;
			
//  RiskView indicator variables
			STRING iv_rv5_unscorable;
			STRING rv_f00_addr_not_ver_w_ssn;
			STRING rv_p85_phn_not_issued;
			INTEGER rv_d32_criminal_count;
			INTEGER rv_c21_stl_inq_count12;
			STRING rv_d33_eviction_recency;
			INTEGER rv_c12_num_nonderogs;
			DECIMAL21_1 rv_c12_source_profile;
			DECIMAL21_1 rv_c12_source_profile_index;
			STRING26 rv_f03_address_match;
			INTEGER rv_l80_inp_avm_autoval;
			INTEGER rv_c14_addrs_10yr;
			STRING rv_c22_inp_addr_occ_index;
			STRING rv_a44_prop_owner_inp_only;
			STRING rv_e55_college_ind;
			INTEGER rv_i60_inq_auto_count12;
			INTEGER rv_c13_attr_addrs_recency;
			INTEGER rv_a50_pb_average_dollars;
			STRING iv_d34_liens_unrel_x_rel;
			INTEGER rv_a47_curr_avm_autoval;
			STRING rv_c22_inp_addr_owned_not_occ;
			STRING rv_a43_rec_vehx_level;
			integer rv_i60_inq_auto_recency;
			INTEGER rv_i60_inq_count12;
			REAL   rv_a50_pb_total_dollars;
			INTEGER rv_f01_inp_addr_address_score;
			INTEGER rv_c14_addrs_5yr;
			INTEGER rv_i60_credit_seeking;
			INTEGER rv_i60_inq_recency;
			STRING rv_a41_prop_owner;
			INTEGER _header_first_seen;
			INTEGER rv_c10_m_hdr_fs;
			INTEGER rv_c14_addrs_15yr;
			INTEGER _criminal_last_date;
			INTEGER rv_d32_mos_since_crim_ls;
			INTEGER rv_d33_eviction_count;
			
//  Verprob Segment variables
			REAL   v_subscore0;
			REAL   v_subscore1;
			REAL   v_subscore2;
			REAL   v_subscore3;
			REAL   v_subscore4;
			REAL   v_subscore5;
			REAL   v_subscore6;
			REAL   v_subscore7;
		  REAL   v_subscore8;
			REAL   v_subscore9;
			REAL   v_subscore10;
			REAL   v_subscore11;
			REAL   v_subscore12;
			REAL   v_subscore13;
			REAL   v_subscore14;
			REAL   v_subscore15;
			REAL v_rawscore;
			REAL v_lnoddsscore;
			REAL v_probscore;
			STRING v_aacd_0;
			REAL v_dist_0;
			STRING v_aacd_1;
			REAL v_dist_1;
			STRING v_aacd_2;
			REAL v_dist_2;
			STRING v_aacd_3;
			REAL v_dist_3;
			STRING v_aacd_4;
			REAL v_dist_4;
			STRING v_aacd_5;
			REAL v_dist_5;
			STRING v_aacd_6;
			REAL v_dist_6;
			STRING v_aacd_7;
			REAL v_dist_7;
			STRING v_aacd_8;
			REAL v_dist_8;
			STRING v_aacd_9;
			REAL v_dist_9;
			STRING v_aacd_10;
			REAL v_dist_10;
			STRING v_aacd_11;
			REAL v_dist_11;
			STRING v_aacd_12;
			REAL v_dist_12;
			STRING v_aacd_13;
			REAL v_dist_13;
			STRING v_aacd_14;
			REAL v_dist_14;
			STRING v_aacd_15;
			REAL v_dist_15;
			
//  Derog Segment variables
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
			STRING d_aacd_5;
			REAL d_dist_5;
			STRING d_aacd_6;
			REAL d_dist_6;
			STRING d_aacd_7;
			REAL d_dist_7;
			STRING d_aacd_8;
			REAL d_dist_8;
			STRING d_aacd_9;
			REAL d_dist_9;
			STRING d_aacd_10;
			REAL d_dist_10;
			STRING d_aacd_11;
			REAL d_dist_11;
			
//  PropOwner Segment variables
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
			REAL p_subscore12;
			REAL p_rawscore;
			REAL p_lnoddsscore;
			REAL p_probscore;
			STRING p_aacd_0;
			REAL p_dist_0;
			STRING p_aacd_1_1;
			REAL p_dist_1_1;
			STRING p_aacd_2;
			REAL p_dist_2;
			STRING p_aacd_3;
			REAL p_dist_3;
			STRING p_aacd_4;
			REAL p_dist_4;
			STRING p_aacd_5;
			REAL p_dist_5;
			STRING p_aacd_6;
			REAL p_dist_6;
			STRING p_aacd_7;
			REAL p_dist_7_1;
			REAL p_dist_7;
			REAL p_dist_1;
			STRING p_aacd_1;
			STRING p_aacd_8;
			REAL p_dist_8;
			STRING p_aacd_9;
			REAL p_dist_9;
			STRING p_aacd_10;
			REAL p_dist_10;
			STRING p_aacd_11;
			REAL p_dist_11;
			STRING p_aacd_12;
			REAL p_dist_12;
			
//  Other Segment variables
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
			REAL o_dist_3;
			STRING o_aacd_4;
			REAL o_dist_4;
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
			
			INTEGER base;
			INTEGER points;
			INTEGER odds;
			REAL lnoddsscore;
			INTEGER score_lnodds;
			INTEGER score_lnodds_capped;
			BOOLEAN ov_ssnprior;
			BOOLEAN ov_corrections;
			INTEGER deceased;
			INTEGER _ov_pts_lost_c150_b3;
			REAL _ov_pts_lost_raw;
			
			INTEGER rva1503_0_2;         //   The score is returned in this variable
			
			STRING _rc_seg_c153;
			STRING _rc_seg_c154;
			STRING _rc_seg_c152;
			STRING _rc_seg_c155;
			STRING _rc_seg;
			REAL v_dist_16;
			STRING v_aacd_16;
			REAL v_rcvaluec22;
			REAL v_rcvaluec21;
			REAL v_rcvaluel80;
			REAL v_rcvaluea50;
			REAL v_rcvaluel73;
			REAL v_rcvalued32;
			REAL v_rcvalued33;
			REAL v_rcvaluep85;
			REAL v_rcvaluec13;
			REAL v_rcvaluea44;
			REAL v_rcvaluei60;
			REAL v_rcvaluef00;
			REAL v_rcvaluef03;
			REAL v_rcvalueS65;
			REAL v_rcvaluee55;
			REAL v_rcvaluec12;
			REAL v_rcvaluec14;
			REAL d_dist_12;
			STRING d_aacd_12;
			REAL d_rcvaluec21;
			REAL d_rcvaluel73;
			REAL d_rcvalueS65;
			REAL d_rcvalued32;
			REAL d_rcvalued33;
			REAL d_rcvaluea50;
			REAL d_rcvaluef01;
			REAL d_rcvaluef03;
			REAL d_rcvaluea41;
			REAL d_rcvaluec13;
			REAL d_rcvaluei60;
			REAL d_rcvaluec10;
			REAL d_rcvaluec14;
			REAL p_dist_13;
			STRING p_aacd_13;
			REAL p_rcvaluec22;
			REAL p_rcvaluec21;
			REAL p_rcvaluel80;
			REAL p_rcvaluel73;
			REAL p_rcvaluee55;
			REAL p_rcvaluea50;
			REAL p_rcvaluea44;
			REAL p_rcvaluei60;
			REAL p_rcvaluea43;
			REAL p_rcvaluef03;
			REAL p_rcvalueS65;
			REAL p_rcvaluec13;
			REAL p_rcvaluec12;
			REAL p_rcvaluea47;
			REAL p_rcvalued34;
			REAL o_dist_10;
			STRING o_aacd_10;
			REAL o_rcvaluec13;
			REAL o_rcvaluel80;
			REAL o_rcvaluel73;
			REAL o_rcvaluea50;
			REAL o_rcvaluei60;
			REAL o_rcvaluef01;
			REAL o_rcvaluef03;
			REAL o_rcvalueS65;
			REAL o_rcvaluee55;
			REAL o_rcvaluec12;
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
			STRING rc3_2;
			STRING rc2_2;
			STRING rc1_3;
			STRING rc4_2;
			STRING rc1_2;
			STRING _rc_inq;
			STRING rc5_c164;
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
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
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
	hdr_source_profile               := le.source_profile;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator	;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind	;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
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
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_retail_count03               := le.acc_logs.retail.count03;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count12                  := le.impulse.count12;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
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
	watercraft_count                 := le.watercraft.watercraft_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
//====================================================================
//===   Determine if this consumer has been sufficiently verified   ===
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
													 or (boolean)(integer)phn_validation_problem 
													 or rc_ssndobflag = '1' 
													 or rc_pwssndobflag = '1', 1, 0);
													 
	
	tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
	             sum(if(liens_historical_unreleased_ct   = NULL, 0, liens_historical_unreleased_ct), 
							     if(liens_recent_unreleased_count    = NULL, 0, liens_recent_unreleased_count), 
									 if(liens_recent_released_count      = NULL, 0, liens_recent_released_count), 
									 if(liens_historical_released_count  = NULL, 0, liens_historical_released_count)));
	
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
												sum(if(liens_unrel_LT_ct  = NULL, 0, liens_unrel_LT_ct), 
												    if(liens_rel_LT_ct    = NULL, 0, liens_rel_LT_ct), 
														if(liens_unrel_SC_ct  = NULL, 0, liens_unrel_SC_ct), 
														if(liens_rel_SC_ct    = NULL, 0, liens_rel_SC_ct), 
														if(liens_unrel_CJ_ct  = NULL, 0, liens_unrel_CJ_ct), 
														if(liens_rel_CJ_ct    = NULL, 0, liens_rel_CJ_ct), 
														if(liens_unrel_FT_ct  = NULL, 0, liens_unrel_FT_ct), 
														if(liens_rel_FT_ct    = NULL, 0, liens_rel_FT_ct), 
														if(liens_unrel_OT_ct  = NULL, 0, liens_unrel_OT_ct), 
														if(liens_rel_OT_ct    = NULL, 0, liens_rel_OT_ct), 
														if(liens_unrel_ST_ct  = NULL, 0, liens_unrel_ST_ct), 
														if(liens_rel_ST_ct    = NULL, 0, liens_rel_ST_ct), 
														if(liens_unrel_FC_ct  = NULL, 0, liens_unrel_FC_ct), 
														if(liens_rel_FC_ct    = NULL, 0, liens_rel_FC_ct), 
														if(liens_unrel_O_ct   = NULL, 0, liens_unrel_O_ct), 
														if(liens_rel_O_ct     = NULL, 0, liens_rel_O_ct)));
														
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
	    not(truedid)                                                            => '0 TRUEDID = 0     ',
	    not((boolean)sufficiently_verified)                                     => '1 VER/VAL PROBLEMS',
	    (boolean)sufficiently_verified and (boolean)(integer)validation_problem => '1 VER/VAL PROBLEMS',
	    (boolean)has_derog                                                      => '2 DEROG           ',
	    add_input_naprop = 4 or property_owned_total > 0                        => '3 OWNER           ',
	                                                                               '4 OTHER           ');
	
	verprob_seg := (rv_4seg_riskview_5_0[1] in ['0', '1']);
	derog_seg := rv_4seg_riskview_5_0[1] = '2';
	owner_seg := rv_4seg_riskview_5_0[1] = '3';
	other_seg := rv_4seg_riskview_5_0[1] = '4';
	
//========================================================================================  
//===   for round 1 validation set the sysdate to the same value seen in the validation file
//        sysdate := common.sas_date('20150501');	 
//===   for round 2 validation set the sysdate to the archive date
//========================================================================================  	
       sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));
  	
//==============================================================
//=             Based on the information collected above       =
//=             Set the Risk View indicators for this          =
//=             consumer.                                      =
//==============================================================		
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');
	
	rv_f00_addr_not_ver_w_ssn := if(not(truedid and (integer)ssnlength > 0), ' ', (String)(Integer)(nas_summary in [4, 7, 9]));
	
	rv_p85_phn_not_issued := map(
	    not(hphnpop)                 => ' ',
	    (rc_pwphonezipflag in ['4']) => '1',
	                                    '0');
	
	rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));
	
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
	
	rv_c12_source_profile := if(not(truedid), NULL, hdr_source_profile);
	
	rv_c12_source_profile_index := if(not(truedid), NULL, hdr_source_profile_index);
	
	rv_f03_address_match := map(
	    not(truedid)                                => '                          ',
	    add_input_isbestmatch                       => '4 INPUT=CURR              ',
	    not(add_input_pop) and add_curr_isbestmatch => '3 CURRAVAIL + NOINPUTPOP  ',
	    add_input_pop and add_curr_isbestmatch      => '2 CURRAVAIL + INPUTNOTCURR',
	    add_curr_pop                                => '1 CURR ONHDRONLY          ',
	    add_input_pop                               => '0 INPUTPOP NOHISTAVAIL    ',
	                                                   '');
	
	rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);
	
	rv_c14_addrs_10yr := map(
	    not(truedid)                                   => NULL,
	    not(add_curr_pop)                              => -1,
	        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));
	
//rv_c22_inp_addr_occ_index := if(not(add_input_pop and truedid), NULL, add_input_occ_index);
	rv_c22_inp_addr_occ_index := if(not(add_input_pop and truedid), ' ', (String)(Integer)add_input_occ_index);
	
	rv_a44_prop_owner_inp_only := map(
	    not(truedid)                                => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 => '1',
	                                                   '0');
	
	rv_e55_college_ind := map(
	    not(truedid)                           => ' ',
	    (college_file_type in ['H', 'C', 'A']) => '1',
	    college_attendance                     => '1',
	                                              '0');
	
	rv_i60_inq_auto_count12 := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));
	
	rv_c13_attr_addrs_recency := map(
	    not(truedid)                      => NULL,
	    (boolean)attr_addrs_last30        => 1,
	    (boolean)attr_addrs_last90        => 3,
	    (boolean)attr_addrs_last12        => 12,
	    (boolean)attr_addrs_last24        => 24,
	    (boolean)attr_addrs_last36        => 36,
	    (boolean)addrs_5yr                => 60,
	    (boolean)addrs_10yr               => 120,
	    (boolean)addrs_15yr               => 180,
	    addrs_per_adl > 0                 => 999,
	                                         0);
	
	rv_a50_pb_average_dollars := map(
	    not(truedid)                      => NULL,
	    pb_average_dollars = ''           => -1,
	                                      // (integer)pb_average_dollars);
	                                      -1);  // reason code edit for iBehavior removal
	
 	
	iv_d34_liens_unrel_x_rel := if(not(truedid), '   ', 
	                 trim((String)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, 
									                  sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
																		    if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, 
																				if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL,     
																				sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count),  
																				    if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) 
									+ trim('-', LEFT, RIGHT) 
	               + trim((string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL,  
								                    sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count),   
																		if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, 
																		if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL,      
																		sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count),      
																		    if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));

	
	rv_a47_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
  rv_c22_inp_addr_owned_not_occ := if(not(add_input_pop and truedid), ' ', (String)(Integer)add_input_owned_not_occ);

	
	rv_a43_rec_vehx_level := map(
	    not(truedid)                                   => '  ',
	    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
	    attr_num_aircraft > 0                          => 'AO',
	    watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((String)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
	                                                      'XX');
																												
	rv_i60_inq_auto_recency := map(
	    not(truedid)                                   => NULL,
	    (boolean)inq_auto_count01                      => 1,
	    (boolean)inq_auto_count03                      => 3,
	    (boolean)inq_auto_count06                      => 6,
	    (boolean)inq_auto_count12                      => 12,
	    (boolean)inq_auto_count24                      => 24,
	    (boolean)inq_auto_count                        => 99,
	                                                       0);
	
	rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));
	
	rv_a50_pb_total_dollars := map(
	    not(truedid)            => NULL,
	    pb_total_dollars = ''   => -1,
	                               // (REAL)pb_total_dollars);
	                               -1);  // reason code edit for iBehavior removal
	
	rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	rv_c14_addrs_5yr := map(
	    not(truedid)            => NULL,
	    not(add_curr_pop)       => -1,
	                               min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));
	
	rv_i60_credit_seeking := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));
	
	rv_i60_inq_recency := map(
	    not(truedid)                    => NULL,
	    (boolean)inq_count01            => 1,
	    (boolean)inq_count03            => 3,
	    (boolean)inq_count06            => 6,
	    (boolean)inq_count12            => 12,
	    (boolean)inq_count24            => 24,
	    (boolean)inq_count              => 99,
	                                       0);
	
	rv_a41_prop_owner := map(
	    not(truedid)                                                                                   => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => '1',
	                                                                                                      '0');
	
	_header_first_seen := Common.SAS_Date((STRING)(header_first_seen));
	
	rv_c10_m_hdr_fs := map(
	    not(truedid)              => NULL,
	    _header_first_seen = NULL => -1,
	                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));
	
	rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));
	
	_criminal_last_date := Common.SAS_Date((STRING)(criminal_last_date));
	
	rv_d32_mos_since_crim_ls := map(
	    not(truedid)               => NULL,
	    _criminal_last_date = NULL => -1,
	                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));
	
	rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the verprob seqment                  =
//==============================================================	
	
	v_subscore0 := map(
	    (rv_f00_addr_not_ver_w_ssn in [' ', '0']) => 0.064081,
	    (rv_f00_addr_not_ver_w_ssn in ['1'])      => -0.13197,
	                                                 0);
	
	v_subscore1 := map(
	    (rv_p85_phn_not_issued in [' ', '0']) => 0.03125,
	    (rv_p85_phn_not_issued in ['1'])      => -0.630301,
	                                             0);
	
	v_subscore2 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 0.012492,
	    1 <= rv_d32_criminal_count                                 => -0.382846,
	                                                                  0);
	
	v_subscore3 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 0.015678,
	    1 <= rv_c21_stl_inq_count12                                  => -0.193717,
	                                                                    0);
	
	v_subscore4 := map(
	    (rv_d33_eviction_recency in [' ', '00'])              => 0.051367,
	    (rv_d33_eviction_recency in ['03', '06', '12'])       => -0.560436,
	    (rv_d33_eviction_recency in ['24', '25', '36', '37']) => -0.393184,
	    (rv_d33_eviction_recency in ['60', '61', '98', '99']) => -0.098119,
	                                                             0);
	
	v_subscore5 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => -0.090996,
	    2 <= rv_c12_num_nonderogs                                => 0.114993,
	                                                                0);
	
	v_subscore6 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 34.2  => -0.066829,
	    34.2 <= rv_c12_source_profile AND rv_c12_source_profile < 48.9 => -0.035732,
	    48.9 <= rv_c12_source_profile AND rv_c12_source_profile < 60.1 => -0.027253,
	    60.1 <= rv_c12_source_profile                                  => 0.115184,
	                                                                      0);
	
	v_subscore7 := map(
	    (rv_f03_address_match in [' ', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])  => 0.088597,
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => -0.074758,
	                                                                                    0);
	
	v_subscore8 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0       => 0.014948,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 30850       => -0.235319,
	    30850 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 149845 => -0.070944,
	    149845 <= rv_l80_inp_avm_autoval                                    => 0.121302,
	    not add_input_pop                                                   => 0.121302,
	                                                                           0);
	
	v_subscore9 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2 => 0.04757,
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 6   => -0.005788,
	    6 <= rv_c14_addrs_10yr                             => -0.084639,
	                                                          0);
	
	v_subscore10 := map(
    (rv_c22_inp_addr_occ_index in [' ', '0', '1'])      => 0.062987,
    (rv_c22_inp_addr_occ_index in ['3'])                => 0.008335,
    (rv_c22_inp_addr_occ_index in ['4'])                => -0.141484,
    (rv_c22_inp_addr_occ_index in ['5', '6', '7', '8']) => 0,
                                                           0);
	
	v_subscore11 := map(
	    (rv_a44_prop_owner_inp_only in [' ', '1']) => 0.22274,
	    (rv_a44_prop_owner_inp_only in ['0'])      => -0.043427,
	                                                  0);
	
	v_subscore12 := map(
	    (rv_e55_college_ind in [' ', '1']) => 0.171382,
	    (rv_e55_college_ind in ['0'])      => -0.015736,
	                                          0);
	
	v_subscore13 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 0.033765,
	    1 <= rv_i60_inq_auto_count12                                   => -0.297438,
	                                                                      0);
	
	v_subscore14 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 3  => -0.058825,
	    3 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60   => -0.040834,
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 0.026657,
	    120 <= rv_c13_attr_addrs_recency                                    => 0.146868,
	                                                                           0);
	
	v_subscore15 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => -0.022788,
	    0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 29  => -0.010342,
	    29 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 72 => 0.045085,
	    72 <= rv_a50_pb_average_dollars                                    => 0.147098,
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
	    v_subscore15;
	
	v_lnoddsscore := v_rawscore + 1.904537;
	
	v_probscore := exp(v_lnoddsscore) / (1 + exp(v_lnoddsscore));
	
	v_aacd_0 := map(
	    (rv_f00_addr_not_ver_w_ssn in [' ', '0']) => 'F00',
	    (rv_f00_addr_not_ver_w_ssn in ['1'])      => 'F00',
	                                                 '');
	
	v_dist_0 := v_subscore0 - 0.064081;
	
	v_aacd_1 := map(
	    (rv_p85_phn_not_issued in [' ', '0']) => 'P85',
	    (rv_p85_phn_not_issued in ['1'])      => 'P85',
	                                             '');
	
	v_dist_1 := v_subscore1 - 0.03125;
	
	v_aacd_2 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 'D32',
	    1 <= rv_d32_criminal_count                                 => 'D32',
	                                                                  'C12');
	
	v_dist_2 := v_subscore2 - 0.012492;
	
	v_aacd_3 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count12                                  => 'C21',
	                                                                    'C12');
	
	v_dist_3 := v_subscore3 - 0.015678;
	
	v_aacd_4 := map(
	    (rv_d33_eviction_recency in [' ', '00'])              => 'D33',
	    (rv_d33_eviction_recency in ['03', '06', '12'])       => 'D33',
	    (rv_d33_eviction_recency in ['24', '25', '36', '37']) => 'D33',
	    (rv_d33_eviction_recency in ['60', '61', '98', '99']) => 'D33',
	                                                             '');
	
	v_dist_4 := v_subscore4 - 0.051367;
	
	v_aacd_5 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => 'C12',
	    2 <= rv_c12_num_nonderogs                                => 'C12',
	                                                                'C12');
	
	v_dist_5 := v_subscore5 - 0.114993;
	
	v_aacd_6 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 34.2  => 'C12',
	    34.2 <= rv_c12_source_profile AND rv_c12_source_profile < 48.9 => 'C12',
	    48.9 <= rv_c12_source_profile AND rv_c12_source_profile < 60.1 => 'C12',
	    60.1 <= rv_c12_source_profile                                  => 'C12',
	                                                                      'C12');
	
	v_dist_6 := v_subscore6 - 0.115184;
	
	v_aacd_7 := map(
	    (rv_f03_address_match in [' ', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])  => 'F03',
	    (rv_f03_address_match in ['1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	                                                                                    '');
	
	v_dist_7 := v_subscore7 - 0.088597;
	
	v_aacd_8 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0       => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 30850       => 'L80',
	    30850 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 149845 => 'L80',
	    149845 <= rv_l80_inp_avm_autoval                                    => 'L80',
	                                                                           '');
	
	v_dist_8 := v_subscore8 - 0.121302;
	
	v_aacd_9 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2 => 'C14',
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 6   => 'C14',
	    6 <= rv_c14_addrs_10yr                             => 'C14',
	                                                          'C12');
	
	v_dist_9 := v_subscore9 - 0.04757;
	
	v_aacd_10 := map(
	    (rv_c22_inp_addr_occ_index in [' ', '0', '1'])      => 'C22',
	    (rv_c22_inp_addr_occ_index in ['3'])                => 'C22',
	    (rv_c22_inp_addr_occ_index in ['4'])                => 'C22',
	    (rv_c22_inp_addr_occ_index in ['5', '6', '7', '8']) => 'C22',
	                                                           '');
	
	v_dist_10 := v_subscore10 - 0.062987;
	
	v_aacd_11 := map(
	    (rv_a44_prop_owner_inp_only in [' ', '1']) => 'A44',
	    (rv_a44_prop_owner_inp_only in ['0'])      => 'A44',
	                                                  '');
	
	v_dist_11 := v_subscore11 - 0.22274;
	
	v_aacd_12 := map(
	    (rv_e55_college_ind in [' ', '1']) => 'E55',
	    (rv_e55_college_ind in ['0'])      => 'E55',
	                                          '');
	
	v_dist_12 := v_subscore12 - 0.171382;
	
	v_aacd_13 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_auto_count12                                   => 'I60',
	                                                                      'C12');
	
	v_dist_13 := v_subscore13 - 0.033765;
	
	v_aacd_14 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 3  => 'C13',
	    3 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60   => 'C13',
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 'C13',
	    120 <= rv_c13_attr_addrs_recency                                    => 'C13',
	                                                                           'C12');
	
	v_dist_14 := v_subscore14 - 0.146868;
	
	v_aacd_15 := 'C12';  // reason code edit for iBehavior removal
	// map(
	    // NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 29  => 'A50',
	    // 29 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 72 => 'A50',
	    // 72 <= rv_a50_pb_average_dollars                                    => 'A50',
	                                                                          // 'C12');
	
	v_dist_15 := if(rv_a50_pb_average_dollars=null, v_subscore15 - 0.147098, 0);
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the derog seqment                    =
//==============================================================	
	
	d_subscore0 := map(
	    (rv_a41_prop_owner in ['0']) => -0.039254,
	    (rv_a41_prop_owner in ['1']) => 0.063196,
	                                    0);
	
	d_subscore1 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => -0.029571,
	    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 88  => 0.04259,
	    88 <= rv_a50_pb_total_dollars                                  => 0.033772,
	                                                                      0);
	
	d_subscore2 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 104 => -0.317935,
	    104 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 165 => -0.107397,
	    165 <= rv_c10_m_hdr_fs                           => 0.058236,
	                                                        0);
	
	d_subscore3 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 1 => 0,
	    1 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24  => -0.150704,
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 36 => -0.021924,
	    36 <= rv_c13_attr_addrs_recency                                    => 0.102053,
	                                                                          0);
	
	d_subscore4 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 0.122259,
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 5   => 0.019868,
	    5 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 9   => -0.032306,
	    9 <= rv_c14_addrs_15yr                             => -0.129957,
	                                                          0);
	
	d_subscore5 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 0.025175,
	    1 <= rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 2   => -0.053547,
	    2 <= rv_c21_stl_inq_count12                                  => -0.272967,
	                                                                    0);
	
	d_subscore6 := map(
	    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 0.029903,
	    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 40  => -0.43495,
	    40 <= rv_d32_mos_since_crim_ls                                   => -0.180438,
	                                                                        0);
	
	d_subscore7 := map(
	    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 0.071332,
	    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => -0.062596,
	    2 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => -0.108204,
	    3 <= rv_d33_eviction_count                                 => -0.28844,
	                                                                  0);
	
	d_subscore8 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => -0.144391,
	    100 <= rv_f01_inp_addr_address_score                                         => 0.063879,
	    not(truedid)                                                                 => 0,
	    not add_input_pop                                                            => 0.063879,
	                                                                                    0);
	
	d_subscore9 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR']) => 0.073301,
	    (rv_f03_address_match in ['2 CURRAVAIL + INPUTNOTCURR'])                                                             => -0.089982,
	                                                                                                                            0);
	
	d_subscore10 := map(
	    NULL < rv_i60_credit_seeking AND rv_i60_credit_seeking < 1 => 0.015421,
	    1 <= rv_i60_credit_seeking                                 => -0.210471,
	                                                                  0);
	
	d_subscore11 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.041647,
	    1 <= rv_i60_inq_count12                              => -0.20811,
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
	    d_subscore11;
	
	d_lnoddsscore := d_rawscore + 1.943278;
	
	d_probscore := exp(d_lnoddsscore) / (1 + exp(d_lnoddsscore));
	
	d_aacd_0 := map(
	    (rv_a41_prop_owner in ['0']) => 'A41',
	    (rv_a41_prop_owner in ['1']) => 'A41',
	                                    '');
	
	d_dist_0 := d_subscore0 - 0.063196;
	
	d_aacd_1 := '';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 88  => 'A50',
	    // 88 <= rv_a50_pb_total_dollars                                  => 'A50',
	                                                                      // '');
	
	d_dist_1 := if(rv_a50_pb_total_dollars=null, d_subscore1 - 0.04259, 0);
	
	d_aacd_2 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 104 => 'C10',
	    104 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 165 => 'C10',
	    165 <= rv_c10_m_hdr_fs                           => 'C10',
	                                                        '');
	
	d_dist_2 := d_subscore2 - 0.058236;
	
	d_aacd_3 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 1 => 'C13',
	    1 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24  => 'C13',
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 36 => 'C13',
	    36 <= rv_c13_attr_addrs_recency                                    => 'C13',
	                                                                          '');
	
	d_dist_3 := d_subscore3 - 0.102053;
	
	d_aacd_4 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 'C14',
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 5   => 'C14',
	    5 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 9   => 'C14',
	    9 <= rv_c14_addrs_15yr                             => 'C14',
	                                                          '');
	
	d_dist_4 := d_subscore4 - 0.122259;
	
	d_aacd_5 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 2   => 'C21',
	    2 <= rv_c21_stl_inq_count12                                  => 'C21',
	                                                                    '');
	
	d_dist_5 := d_subscore5 - 0.025175;
	
	d_aacd_6 := map(
	    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 'D32',
	    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 40  => 'D32',
	    40 <= rv_d32_mos_since_crim_ls                                   => 'D32',
	                                                                        '');
	
	d_dist_6 := d_subscore6 - 0.029903;
	
	d_aacd_7 := map(
	    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 'D33',
	    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => 'D33',
	    2 <= rv_d33_eviction_count AND rv_d33_eviction_count < 3   => 'D33',
	    3 <= rv_d33_eviction_count                                 => 'D33',
	                                                                  '');
	
	d_dist_7 := d_subscore7 - 0.071332;
	
	d_aacd_8 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                         => 'F01',
			not(truedid)                                                                 => 'C12',
			                                                                                 ''); 																																										 
//                                                               if(truedid = 0, 'C12', ''));
	
	d_dist_8 := d_subscore8 - 0.063879;
	
	d_aacd_9 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR']) => 'F03',
	    (rv_f03_address_match in ['2 CURRAVAIL + INPUTNOTCURR'])                                                             => 'F03',
	                                                                                                                            '');
	
	d_dist_9 := d_subscore9 - 0.073301;
	
	d_aacd_10 := map(
	    NULL < rv_i60_credit_seeking AND rv_i60_credit_seeking < 1 => 'I60',
	    1 <= rv_i60_credit_seeking                                 => 'I60',
	                                                                  '');
	
	d_dist_10 := d_subscore10 - 0.015421;
	
	d_aacd_11 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12                              => 'I60',
	                                                            '');
	
	d_dist_11 := d_subscore11 - 0.041647;
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the propowner seqment                =
//==============================================================	
	
	p_subscore0 := map(
	    NULL < rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 1 => 0.062023,
	    1 <= rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 6   => -0.758563,
	    6 <= rv_i60_inq_auto_recency                                   => -0.41046,
	                                                                      0);
	
	p_subscore1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => -0.030144,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 96528        => -0.196868,
	    96528 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 136182  => -0.109077,
	    136182 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 216300 => 0.066464,
	    216300 <= rv_l80_inp_avm_autoval                                     => 0.357242,
	    not add_input_pop                                                    => 0.357242,
	                                                                            0);
	
	p_subscore2 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => -0.111907,
	    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 236 => 0.022047,
	    236 <= rv_a50_pb_total_dollars                                 => 0.163668,
	                                                                      0);
	
	p_subscore3 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR']) => 0.083907,
	    (rv_f03_address_match in ['2 CURRAVAIL + INPUTNOTCURR'])                                                             => -0.231177,
	                                                                                                                            0);
	
	p_subscore4 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 1   => 0.084893,
	    1 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24    => -0.191229,
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120  => -0.080133,
	    120 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 999 => 0.059567,
	    999 <= rv_c13_attr_addrs_recency                                     => 0.210281,
	                                                                            0);
	
	p_subscore5 := map(
	    (rv_e55_college_ind in ['0']) => -0.019403,
	    (rv_e55_college_ind in ['1']) => 0.136388,
	                                     0);
	
	p_subscore6 := map(
	    (rv_a44_prop_owner_inp_only in ['0']) => -0.157722,
	    (rv_a44_prop_owner_inp_only in ['1']) => 0.048137,
	                                             0);
	
	p_subscore7 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0        => -0.000769,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 114543       => -0.114414,
	    114543 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 128578 => -0.045662,
	    128578 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 216523 => 0.070418,
	    216523 <= rv_a47_curr_avm_autoval                                      => 0.124646,
	                                                                              0);
	
	p_subscore8 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                  => 0.017936,
	    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => -0.18591,
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0'])                                    => -0.353879,
	                                                                                              0);
	
	p_subscore9 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 0.012145,
	    1 <= rv_c21_stl_inq_count12                                  => -0.30026,
	                                                                    0);
	
	p_subscore10 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 6 => -0.059092,
	    6 <= rv_c12_source_profile_index                                       => 0.055525,
	                                                                              0);
	 
	p_subscore11 := map(
	    (rv_c22_inp_addr_owned_not_occ in [' ', '0'])              => 0.009145,
	    (rv_c22_inp_addr_owned_not_occ in ['1'])                   => -0.229574,
	                                                               0);
	
	p_subscore12 := map(
	    (rv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 0.161314,
	    (rv_a43_rec_vehx_level in ['XX'])                         => -0.009449,
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
	    p_subscore11 +
	    p_subscore12;
	
	p_lnoddsscore := p_rawscore + 2.894158;
	
	p_probscore := exp(p_lnoddsscore) / (1 + exp(p_lnoddsscore));
	
	p_aacd_0 := map(
	    NULL < rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 1 => 'I60',
	    1 <= rv_i60_inq_auto_recency AND rv_i60_inq_auto_recency < 6   => 'I60',
	    6 <= rv_i60_inq_auto_recency                                   => 'I60',
	                                                                      '');
	
	p_dist_0 := p_subscore0 - 0.062023;
	
	p_aacd_1_1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 96528        => 'L80',
	    96528 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 136182  => 'L80',
	    136182 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 216300 => 'L80',
	    216300 <= rv_l80_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	p_dist_1_1 := p_subscore1 - 0.357242;
	
	p_aacd_2 := '';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 236 => 'A50',
	    // 236 <= rv_a50_pb_total_dollars                                 => 'A50',
	                                                                      // '');
	
	p_dist_2 := if(rv_a50_pb_total_dollars=null, p_subscore2 - 0.163668, 0);  // reason code edit for iBehavior removal
	
	p_aacd_3 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR']) => 'F03',
	    (rv_f03_address_match in ['2 CURRAVAIL + INPUTNOTCURR'])                                                             => 'F03',
	                                                                                                                            '');
	
	p_dist_3 := p_subscore3 - 0.083907;
	
	p_aacd_4 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 1   => 'C13',
	    1 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 24    => 'C13',
	    24 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120  => 'C13',
	    120 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 999 => 'C13',
	    999 <= rv_c13_attr_addrs_recency                                     => 'C13',
	                                                                            '');
	
	p_dist_4 := p_subscore4 - 0.210281;
	
	p_aacd_5 := map(
	    (rv_e55_college_ind in ['0']) => 'E55',
	    (rv_e55_college_ind in ['1']) => 'E55',
	                                     '');
	
	p_dist_5 := p_subscore5 - 0.136388;
	
	p_aacd_6 := map(
	    (rv_a44_prop_owner_inp_only in ['0']) => 'A44',
	    (rv_a44_prop_owner_inp_only in ['1']) => 'A44',
	                                             '');
	
	p_dist_6 := p_subscore6 - 0.048137;
	
	p_aacd_7 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0        => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 114543       => 'A47',
	    114543 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 128578 => 'A47',
	    128578 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 216523 => 'A47',
	    216523 <= rv_a47_curr_avm_autoval                                      => 'A47',
	                                                                              '');
	
	p_dist_7_1 := p_subscore7 - 0.124646;
	
	p_dist_7 := if(p_dist_7_1 != 0, if(max(p_dist_7_1, p_dist_1_1) = NULL, NULL, sum(if(p_dist_7_1 = NULL, 0, p_dist_7_1), if(p_dist_1_1 = NULL, 0, p_dist_1_1))), p_dist_7_1);
	
	p_dist_1 := if(p_dist_7_1 != 0, 0, p_dist_1_1);
	
	p_aacd_1 := if(p_dist_7_1 != 0, '', p_aacd_1_1);
	
	p_aacd_8 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                  => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0'])                                    => 'D34',
	                                                                                              '');
	
	p_dist_8 := p_subscore8 - 0.017936;
	
	p_aacd_9 := map(
	    NULL < rv_c21_stl_inq_count12 AND rv_c21_stl_inq_count12 < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count12                                  => 'C21',
	                                                                    '');
	
	p_dist_9 := p_subscore9 - 0.012145;
	
	p_aacd_10 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 6 => 'C12',
	    6 <= rv_c12_source_profile_index                                       => 'C12',
	                                                                              '');
	
	p_dist_10 := p_subscore10 - 0.055525;
	
	p_aacd_11 := map(
	    (rv_c22_inp_addr_owned_not_occ in [' ', '0']) => 'C22',
	    (rv_c22_inp_addr_owned_not_occ in ['1'])      => 'C22',
	                                                     '');
	
	p_dist_11 := p_subscore11 - 0.009145;
	
	p_aacd_12 := map(
	    (rv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 'A43',
	    (rv_a43_rec_vehx_level in ['XX'])                         => 'A43',
	                                                                 '');
	
	p_dist_12 := p_subscore12 - 0.161314;
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the other seqment                    =
//==============================================================		
	
	o_subscore0 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => -0.077227,
	    0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 61  => -0.01257,
	    61 <= rv_a50_pb_total_dollars                                  => 0.180642,
	                                                                      0);
	
	o_subscore1 := map(
	    (rv_e55_college_ind in [' ', '1']) => 0.280783,
	    (rv_e55_college_ind in ['0'])      => -0.035653,
	                                          0);
	
	o_subscore2 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 34.2 => -0.237062,
	    34.2 <= rv_c12_source_profile AND rv_c12_source_profile < 65  => -0.04903,
	    65 <= rv_c12_source_profile                                   => 0.120444,
	                                                                     0);
	
	o_subscore3 := map(
	    (rv_f03_address_match in [' ', '1 CURR ONHDRONLY', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR']) => 0.092808,
	    (rv_f03_address_match in ['2 CURRAVAIL + INPUTNOTCURR'])                                        => -0.129369,
	                                                                                                       0);
	
	o_subscore4 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60 => -0.058568,
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => -0.032803,
	    120 <= rv_c13_attr_addrs_recency                                    => 0.143884,
	                                                                           0);
	
	o_subscore5 := map(
	    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 1 => 0.026623,       // all the zeros fall here
	    1 <= rv_i60_inq_recency AND rv_i60_inq_recency < 3   => -0.276052,      // all the 1 and 2's (there are no 2's) 
	    3 <= rv_i60_inq_recency                              => -0.194258,      //  all the 3's
	                                                            0);             //  all 6, 12, 24, 99's and the nulls
	
	o_subscore6 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 20 => -0.136238,
	    20 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50  => -0.153681,
	    50 <= rv_f01_inp_addr_address_score                                         => 0.044102,
	    not(truedid)                                                                => 0,
	    not add_input_pop                                                           => 0.044102,
	                                                                                   0);
	
	o_subscore7 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0       => -0.015603,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 59529       => -0.125988,
	    59529 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 149845 => 0.02261,
	    149845 <= rv_l80_inp_avm_autoval                                    => 0.117165,
	    not add_input_pop                                                   => 0.117165,
	                                                                           0);
	
	o_subscore8 := map(
	    NULL < rv_i60_credit_seeking AND rv_i60_credit_seeking < 1 => 0.013133,
	    1 <= rv_i60_credit_seeking                                 => -0.26113,
	                                                                  0);
	
	o_subscore9 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 0.040218,
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => -0.044321,
	    4 <= rv_c14_addrs_5yr                            => -0.097248,
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
	    o_subscore9;
	
	o_lnoddsscore := o_rawscore + 2.265403;
	
	o_probscore := exp(o_lnoddsscore) / (1 + exp(o_lnoddsscore));
	
	o_aacd_0 := '';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 0 => 'A50',
	    // 0 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 61  => 'A50',
	    // 61 <= rv_a50_pb_total_dollars                                  => 'A50',
	                                                                      // '');
	
	o_dist_0 := if(rv_a50_pb_total_dollars=null, o_subscore0 - 0.180642, 0);  // reason code edit for iBehavior removal
	
	o_aacd_1 := map(
	    (rv_e55_college_ind in [' ', '1']) => 'E55',
	    (rv_e55_college_ind in ['0'])      => 'E55',
	                                          '');
	
	o_dist_1 := o_subscore1 - 0.280783;
	
	o_aacd_2 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 34.2 => 'C12',
	    34.2 <= rv_c12_source_profile AND rv_c12_source_profile < 65  => 'C12',
	    65 <= rv_c12_source_profile                                   => 'C12',
	                                                                     '');
	
	o_dist_2 := o_subscore2 - 0.120444;
	
	o_aacd_3 := map(
	    (rv_f03_address_match in [' ', '1 CURR ONHDRONLY', '3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR']) => 'F03',
	    (rv_f03_address_match in ['2 CURRAVAIL + INPUTNOTCURR'])                                        => 'F03',
	                                                                                                       '');
	
	o_dist_3 := o_subscore3 - 0.092808;
	
	o_aacd_4 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60 => 'C13',
	    60 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 120 => 'C13',
	    120 <= rv_c13_attr_addrs_recency                                    => 'C13',
	                                                                           '');
	
	o_dist_4 := o_subscore4 - 0.143884;
	
	o_aacd_5 := map(
	    NULL < rv_i60_inq_recency AND rv_i60_inq_recency < 1 => 'I60',
	    1 <= rv_i60_inq_recency AND rv_i60_inq_recency < 3   => 'I60',
	    3 <= rv_i60_inq_recency                              => 'I60',
	                                                            '');
	
	o_dist_5 := o_subscore5 - 0.026623;
	
	o_aacd_6 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 20 => 'F01',
	    20 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 50  => 'F01',
	    50 <= rv_f01_inp_addr_address_score                                         => 'F01',
			not(truedid)                                                                => 'C12',
			                                                                                '');	
//                                                              if(truedid = 0, 'C12', ''));
	
	o_dist_6 := o_subscore6 - 0.044102;
	
	o_aacd_7 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0       => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 59529       => 'L80',
	    59529 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 149845 => 'L80',
	    149845 <= rv_l80_inp_avm_autoval                                    => 'L80',
	                                                                           '');
	
	o_dist_7 := o_subscore7 - 0.117165;
	
	o_aacd_8 := map(
	    NULL < rv_i60_credit_seeking AND rv_i60_credit_seeking < 1 => 'I60',
	    1 <= rv_i60_credit_seeking                                 => 'I60',
	                                                                  '');
	
	o_dist_8 := o_subscore8 - 0.013133;
	
	o_aacd_9 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 'C14',
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => 'C14',
	    4 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	o_dist_9 := o_subscore9 - 0.040218;
	
	base := 750;
	points := 50;
	odds := 20;
	
	lnoddsscore := if(max((integer)verprob_seg * v_lnoddsscore, (integer)derog_seg * d_lnoddsscore, (integer)owner_seg * p_lnoddsscore, (integer)other_seg * o_lnoddsscore) = NULL, NULL, sum(if((integer)verprob_seg * v_lnoddsscore = NULL, 0, (integer)verprob_seg * v_lnoddsscore), if((integer)derog_seg * d_lnoddsscore = NULL, 0, (integer)derog_seg * d_lnoddsscore), if((integer)owner_seg * p_lnoddsscore = NULL, 0, (integer)owner_seg * p_lnoddsscore), if((integer)other_seg * o_lnoddsscore = NULL, 0, (integer)other_seg * o_lnoddsscore)));
	
	score_lnodds := round(points * (lnoddsscore - ln(odds)) / ln(2) + base);
	
	score_lnodds_capped := min(900, if(max(501, score_lnodds) = NULL, -NULL, max(501, score_lnodds)));
	
	ov_ssnprior := rc_ssndobflag = '1' or rc_pwssndobflag = '1';
	
	ov_corrections := (INTEGER)rc_hrisksic = 2225;

//==============================================================
//=             Some logic for high risk phones               =
//=             and high risk addresses                       =
//=             Additional logic for deceased                 =
//==============================================================	
	
	deceased := map(
	    rc_decsflag = '1'                                                      => 1,
	    rc_ssndod != 0                                                         => 1,
	    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
	    rc_decsflag = '0'                                                      => 0,
	                                                                              NULL);
	
	_ov_pts_lost_c150_b3 := 550 - score_lnodds_capped;
	
	_ov_pts_lost_raw := map(
	    deceased > 0                                                  => NULL,
	    iv_rv5_unscorable = '1'                                       => NULL,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections) => ln(2) * _ov_pts_lost_c150_b3 / points,
	                                                                     0);
	
	rva1503_0_2 := map(
	    deceased > 0                                                  => 200,
	    iv_rv5_unscorable = '1'                                       => 222,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections) => 550,
	                                                                     score_lnodds_capped);
	
	_rc_seg_c153 := map(
	    add_ec1 = 'E' and not(rc_addrvalflag = 'N') or out_z5 = ''       => 'L70',
	    rc_hrisksic = '2225'                                             => 'L73',
	    rc_hrisksicphone = '2225'                                        => 'P87',
	    rc_hriskaddrflag = '2' 
			  or rc_ziptypeflag = '2' 
				or (add_input_advo_res_or_bus in ['B', 'D']) 
				or rc_hriskaddrflag = '4' 
				or rc_addrcommflag = '2'                                       => 'L71',
	                                                                        'L72');
	
	_rc_seg_c154 := map(
	    rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_hphonetypeflag = 'A' => 'P86',
	                                                                                                                             'P85');
	
	_rc_seg_c152 := map(
	    sufficiently_verified = 0                          => 'F00',
	    adls_per_ssn >= 5 or ssns_per_adl >= 4             => 'S66',
	    invalid_ssns_per_adl >= 1                          => 'S65',
	    rc_ssndobflag = '1'                                => 'S65',
	    rc_pwssndobflag = '1'                              => 'S65',
	    adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 => 'L79',
	    addr_validation_problem = 1                        => _rc_seg_c153,
	    (Boolean)Phn_Validation_Problem                    => _rc_seg_c154,
	                                                          'C12');
	
	_rc_seg_c155 := map(
	    felony_count > 0 or criminal_count > 0            => 'D32',
	    stl_inq_count12 > 0                               => 'C21',
	    attr_eviction_count > 0                           => 'D33',
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
	    VerProb_seg => _rc_seg_c152,
	    Derog_seg   => _rc_seg_c155,
	    Other_seg   => 'A41',
	                   '');
//=========================================================
//==  start calculating the RC values for verprob segment =
//=========================================================			
	
	v_dist_16 := _ov_pts_lost_raw;
	
	v_aacd_16 := map(
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
	    (integer)(v_aacd_16 = 'C22') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'C21') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'L80') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'A50') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'L73') * v_dist_16;
	
	v_rcvalued32 := (integer)(v_aacd_0 = 'D32') * v_dist_0 +
	    (integer)(v_aacd_1 = 'D32') * v_dist_1 +
	    (integer)(v_aacd_2 = 'D32') * v_dist_2 +
	    (integer)(v_aacd_3 = 'D32') * v_dist_3 +
	    (integer)(v_aacd_4 = 'D32') * v_dist_4 +
	    (integer)(v_aacd_5 = 'D32') * v_dist_5 +
	    (integer)(v_aacd_6 = 'D32') * v_dist_6 +
	    (integer)(v_aacd_7 = 'D32') * v_dist_7 +
	    (integer)(v_aacd_8 = 'D32') * v_dist_8 +
	    (integer)(v_aacd_9 = 'D32') * v_dist_9 +
	    (integer)(v_aacd_10 = 'D32') * v_dist_10 +
	    (integer)(v_aacd_11 = 'D32') * v_dist_11 +
	    (integer)(v_aacd_12 = 'D32') * v_dist_12 +
	    (integer)(v_aacd_13 = 'D32') * v_dist_13 +
	    (integer)(v_aacd_14 = 'D32') * v_dist_14 +
	    (integer)(v_aacd_15 = 'D32') * v_dist_15 +
	    (integer)(v_aacd_16 = 'D32') * v_dist_16;
	
	v_rcvalued33 := (integer)(v_aacd_0 = 'D33') * v_dist_0 +
	    (integer)(v_aacd_1 = 'D33') * v_dist_1 +
	    (integer)(v_aacd_2 = 'D33') * v_dist_2 +
	    (integer)(v_aacd_3 = 'D33') * v_dist_3 +
	    (integer)(v_aacd_4 = 'D33') * v_dist_4 +
	    (integer)(v_aacd_5 = 'D33') * v_dist_5 +
	    (integer)(v_aacd_6 = 'D33') * v_dist_6 +
	    (integer)(v_aacd_7 = 'D33') * v_dist_7 +
	    (integer)(v_aacd_8 = 'D33') * v_dist_8 +
	    (integer)(v_aacd_9 = 'D33') * v_dist_9 +
	    (integer)(v_aacd_10 = 'D33') * v_dist_10 +
	    (integer)(v_aacd_11 = 'D33') * v_dist_11 +
	    (integer)(v_aacd_12 = 'D33') * v_dist_12 +
	    (integer)(v_aacd_13 = 'D33') * v_dist_13 +
	    (integer)(v_aacd_14 = 'D33') * v_dist_14 +
	    (integer)(v_aacd_15 = 'D33') * v_dist_15 +
	    (integer)(v_aacd_16 = 'D33') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'P85') * v_dist_16;
	
	v_rcvaluec13 := (integer)(v_aacd_0 = 'C13') * v_dist_0 +
	    (integer)(v_aacd_1 = 'C13') * v_dist_1 +
	    (integer)(v_aacd_2 = 'C13') * v_dist_2 +
	    (integer)(v_aacd_3 = 'C13') * v_dist_3 +
	    (integer)(v_aacd_4 = 'C13') * v_dist_4 +
	    (integer)(v_aacd_5 = 'C13') * v_dist_5 +
	    (integer)(v_aacd_6 = 'C13') * v_dist_6 +
	    (integer)(v_aacd_7 = 'C13') * v_dist_7 +
	    (integer)(v_aacd_8 = 'C13') * v_dist_8 +
	    (integer)(v_aacd_9 = 'C13') * v_dist_9 +
	    (integer)(v_aacd_10 = 'C13') * v_dist_10 +
	    (integer)(v_aacd_11 = 'C13') * v_dist_11 +
	    (integer)(v_aacd_12 = 'C13') * v_dist_12 +
	    (integer)(v_aacd_13 = 'C13') * v_dist_13 +
	    (integer)(v_aacd_14 = 'C13') * v_dist_14 +
	    (integer)(v_aacd_15 = 'C13') * v_dist_15 +
	    (integer)(v_aacd_16 = 'C13') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'A44') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'I60') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'F00') * v_dist_16;
	
	v_rcvaluef03 := (integer)(v_aacd_0 = 'F03') * v_dist_0 +
	    (integer)(v_aacd_1 = 'F03') * v_dist_1 +
	    (integer)(v_aacd_2 = 'F03') * v_dist_2 +
	    (integer)(v_aacd_3 = 'F03') * v_dist_3 +
	    (integer)(v_aacd_4 = 'F03') * v_dist_4 +
	    (integer)(v_aacd_5 = 'F03') * v_dist_5 +
	    (integer)(v_aacd_6 = 'F03') * v_dist_6 +
	    (integer)(v_aacd_7 = 'F03') * v_dist_7 +
	    (integer)(v_aacd_8 = 'F03') * v_dist_8 +
	    (integer)(v_aacd_9 = 'F03') * v_dist_9 +
	    (integer)(v_aacd_10 = 'F03') * v_dist_10 +
	    (integer)(v_aacd_11 = 'F03') * v_dist_11 +
	    (integer)(v_aacd_12 = 'F03') * v_dist_12 +
	    (integer)(v_aacd_13 = 'F03') * v_dist_13 +
	    (integer)(v_aacd_14 = 'F03') * v_dist_14 +
	    (integer)(v_aacd_15 = 'F03') * v_dist_15 +
	    (integer)(v_aacd_16 = 'F03') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'S65') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'E55') * v_dist_16;
	
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
	    (integer)(v_aacd_16 = 'C12') * v_dist_16;
	
	v_rcvaluec14 := (integer)(v_aacd_0 = 'C14') * v_dist_0 +
	    (integer)(v_aacd_1 = 'C14') * v_dist_1 +
	    (integer)(v_aacd_2 = 'C14') * v_dist_2 +
	    (integer)(v_aacd_3 = 'C14') * v_dist_3 +
	    (integer)(v_aacd_4 = 'C14') * v_dist_4 +
	    (integer)(v_aacd_5 = 'C14') * v_dist_5 +
	    (integer)(v_aacd_6 = 'C14') * v_dist_6 +
	    (integer)(v_aacd_7 = 'C14') * v_dist_7 +
	    (integer)(v_aacd_8 = 'C14') * v_dist_8 +
	    (integer)(v_aacd_9 = 'C14') * v_dist_9 +
	    (integer)(v_aacd_10 = 'C14') * v_dist_10 +
	    (integer)(v_aacd_11 = 'C14') * v_dist_11 +
	    (integer)(v_aacd_12 = 'C14') * v_dist_12 +
	    (integer)(v_aacd_13 = 'C14') * v_dist_13 +
	    (integer)(v_aacd_14 = 'C14') * v_dist_14 +
	    (integer)(v_aacd_15 = 'C14') * v_dist_15 +
	    (integer)(v_aacd_16 = 'C14') * v_dist_16;

//=========================================================
//==  start calculating the RC values for derog segment   =
//=========================================================
	
	d_dist_12 := _ov_pts_lost_raw;
	
	d_aacd_12 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                  '');
	
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
	    (integer)(d_aacd_12 = 'C21') * d_dist_12;
	
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
	    (integer)(d_aacd_12 = 'L73') * d_dist_12;
	
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
	    (integer)(d_aacd_12 = 'S65') * d_dist_12;


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
	    (integer)(d_aacd_12 = 'C12') * d_dist_12;
	
	d_rcvalued32 := (integer)(d_aacd_0 = 'D32') * d_dist_0 +
	    (integer)(d_aacd_1 = 'D32') * d_dist_1 +
	    (integer)(d_aacd_2 = 'D32') * d_dist_2 +
	    (integer)(d_aacd_3 = 'D32') * d_dist_3 +
	    (integer)(d_aacd_4 = 'D32') * d_dist_4 +
	    (integer)(d_aacd_5 = 'D32') * d_dist_5 +
	    (integer)(d_aacd_6 = 'D32') * d_dist_6 +
	    (integer)(d_aacd_7 = 'D32') * d_dist_7 +
	    (integer)(d_aacd_8 = 'D32') * d_dist_8 +
	    (integer)(d_aacd_9 = 'D32') * d_dist_9 +
	    (integer)(d_aacd_10 = 'D32') * d_dist_10 +
	    (integer)(d_aacd_11 = 'D32') * d_dist_11 +
	    (integer)(d_aacd_12 = 'D32') * d_dist_12;
	
	d_rcvalued33 := (integer)(d_aacd_0 = 'D33') * d_dist_0 +
	    (integer)(d_aacd_1 = 'D33') * d_dist_1 +
	    (integer)(d_aacd_2 = 'D33') * d_dist_2 +
	    (integer)(d_aacd_3 = 'D33') * d_dist_3 +
	    (integer)(d_aacd_4 = 'D33') * d_dist_4 +
	    (integer)(d_aacd_5 = 'D33') * d_dist_5 +
	    (integer)(d_aacd_6 = 'D33') * d_dist_6 +
	    (integer)(d_aacd_7 = 'D33') * d_dist_7 +
	    (integer)(d_aacd_8 = 'D33') * d_dist_8 +
	    (integer)(d_aacd_9 = 'D33') * d_dist_9 +
	    (integer)(d_aacd_10 = 'D33') * d_dist_10 +
	    (integer)(d_aacd_11 = 'D33') * d_dist_11 +
	    (integer)(d_aacd_12 = 'D33') * d_dist_12;
	
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
	    (integer)(d_aacd_12 = 'A50') * d_dist_12;
	
	d_rcvaluef01 := (integer)(d_aacd_0 = 'F01') * d_dist_0 +
	    (integer)(d_aacd_1 = 'F01') * d_dist_1 +
	    (integer)(d_aacd_2 = 'F01') * d_dist_2 +
	    (integer)(d_aacd_3 = 'F01') * d_dist_3 +
	    (integer)(d_aacd_4 = 'F01') * d_dist_4 +
	    (integer)(d_aacd_5 = 'F01') * d_dist_5 +
	    (integer)(d_aacd_6 = 'F01') * d_dist_6 +
	    (integer)(d_aacd_7 = 'F01') * d_dist_7 +
	    (integer)(d_aacd_8 = 'F01') * d_dist_8 +
	    (integer)(d_aacd_9 = 'F01') * d_dist_9 +
	    (integer)(d_aacd_10 = 'F01') * d_dist_10 +
	    (integer)(d_aacd_11 = 'F01') * d_dist_11 +
	    (integer)(d_aacd_12 = 'F01') * d_dist_12;
	
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
	    (integer)(d_aacd_12 = 'F03') * d_dist_12;
	
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
	    (integer)(d_aacd_12 = 'A41') * d_dist_12;
	
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
	    (integer)(d_aacd_12 = 'C13') * d_dist_12;
	
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
	    (integer)(d_aacd_12 = 'I60') * d_dist_12;
	
	d_rcvaluec10 := (integer)(d_aacd_0 = 'C10') * d_dist_0 +
	    (integer)(d_aacd_1 = 'C10') * d_dist_1 +
	    (integer)(d_aacd_2 = 'C10') * d_dist_2 +
	    (integer)(d_aacd_3 = 'C10') * d_dist_3 +
	    (integer)(d_aacd_4 = 'C10') * d_dist_4 +
	    (integer)(d_aacd_5 = 'C10') * d_dist_5 +
	    (integer)(d_aacd_6 = 'C10') * d_dist_6 +
	    (integer)(d_aacd_7 = 'C10') * d_dist_7 +
	    (integer)(d_aacd_8 = 'C10') * d_dist_8 +
	    (integer)(d_aacd_9 = 'C10') * d_dist_9 +
	    (integer)(d_aacd_10 = 'C10') * d_dist_10 +
	    (integer)(d_aacd_11 = 'C10') * d_dist_11 +
	    (integer)(d_aacd_12 = 'C10') * d_dist_12;
	
	d_rcvaluec14 := (integer)(d_aacd_0 = 'C14') * d_dist_0 +
	    (integer)(d_aacd_1 = 'C14') * d_dist_1 +
	    (integer)(d_aacd_2 = 'C14') * d_dist_2 +
	    (integer)(d_aacd_3 = 'C14') * d_dist_3 +
	    (integer)(d_aacd_4 = 'C14') * d_dist_4 +
	    (integer)(d_aacd_5 = 'C14') * d_dist_5 +
	    (integer)(d_aacd_6 = 'C14') * d_dist_6 +
	    (integer)(d_aacd_7 = 'C14') * d_dist_7 +
	    (integer)(d_aacd_8 = 'C14') * d_dist_8 +
	    (integer)(d_aacd_9 = 'C14') * d_dist_9 +
	    (integer)(d_aacd_10 = 'C14') * d_dist_10 +
	    (integer)(d_aacd_11 = 'C14') * d_dist_11 +
	    (integer)(d_aacd_12 = 'C14') * d_dist_12;
	
//=========================================================
//==  start calculating the RC values for propowner segment =
//=========================================================		
	
	p_dist_13 := _ov_pts_lost_raw;
	
	p_aacd_13 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                  '');
	
	p_rcvaluec22 := (integer)(p_aacd_0 = 'C22') * p_dist_0 +
	    (integer)(p_aacd_1 = 'C22') * p_dist_1 +
	    (integer)(p_aacd_2 = 'C22') * p_dist_2 +
	    (integer)(p_aacd_3 = 'C22') * p_dist_3 +
	    (integer)(p_aacd_4 = 'C22') * p_dist_4 +
	    (integer)(p_aacd_5 = 'C22') * p_dist_5 +
	    (integer)(p_aacd_6 = 'C22') * p_dist_6 +
	    (integer)(p_aacd_7 = 'C22') * p_dist_7 +
	    (integer)(p_aacd_8 = 'C22') * p_dist_8 +
	    (integer)(p_aacd_9 = 'C22') * p_dist_9 +
	    (integer)(p_aacd_10 = 'C22') * p_dist_10 +
	    (integer)(p_aacd_11 = 'C22') * p_dist_11 +
	    (integer)(p_aacd_12 = 'C22') * p_dist_12 +
	    (integer)(p_aacd_13 = 'C22') * p_dist_13;
	
	p_rcvaluec21 := (integer)(p_aacd_0 = 'C21') * p_dist_0 +
	    (integer)(p_aacd_1 = 'C21') * p_dist_1 +
	    (integer)(p_aacd_2 = 'C21') * p_dist_2 +
	    (integer)(p_aacd_3 = 'C21') * p_dist_3 +
	    (integer)(p_aacd_4 = 'C21') * p_dist_4 +
	    (integer)(p_aacd_5 = 'C21') * p_dist_5 +
	    (integer)(p_aacd_6 = 'C21') * p_dist_6 +
	    (integer)(p_aacd_7 = 'C21') * p_dist_7 +
	    (integer)(p_aacd_8 = 'C21') * p_dist_8 +
	    (integer)(p_aacd_9 = 'C21') * p_dist_9 +
	    (integer)(p_aacd_10 = 'C21') * p_dist_10 +
	    (integer)(p_aacd_11 = 'C21') * p_dist_11 +
	    (integer)(p_aacd_12 = 'C21') * p_dist_12 +
	    (integer)(p_aacd_13 = 'C21') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'L80') * p_dist_12 +
	    (integer)(p_aacd_13 = 'L80') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'L73') * p_dist_12 +
	    (integer)(p_aacd_13 = 'L73') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'E55') * p_dist_12 +
	    (integer)(p_aacd_13 = 'E55') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'A50') * p_dist_12 +
	    (integer)(p_aacd_13 = 'A50') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'A44') * p_dist_12 +
	    (integer)(p_aacd_13 = 'A44') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'I60') * p_dist_12 +
	    (integer)(p_aacd_13 = 'I60') * p_dist_13;
	
	p_rcvaluea43 := (integer)(p_aacd_0 = 'A43') * p_dist_0 +
	    (integer)(p_aacd_1 = 'A43') * p_dist_1 +
	    (integer)(p_aacd_2 = 'A43') * p_dist_2 +
	    (integer)(p_aacd_3 = 'A43') * p_dist_3 +
	    (integer)(p_aacd_4 = 'A43') * p_dist_4 +
	    (integer)(p_aacd_5 = 'A43') * p_dist_5 +
	    (integer)(p_aacd_6 = 'A43') * p_dist_6 +
	    (integer)(p_aacd_7 = 'A43') * p_dist_7 +
	    (integer)(p_aacd_8 = 'A43') * p_dist_8 +
	    (integer)(p_aacd_9 = 'A43') * p_dist_9 +
	    (integer)(p_aacd_10 = 'A43') * p_dist_10 +
	    (integer)(p_aacd_11 = 'A43') * p_dist_11 +
	    (integer)(p_aacd_12 = 'A43') * p_dist_12 +
	    (integer)(p_aacd_13 = 'A43') * p_dist_13;
	
	p_rcvaluef03 := (integer)(p_aacd_0 = 'F03') * p_dist_0 +
	    (integer)(p_aacd_1 = 'F03') * p_dist_1 +
	    (integer)(p_aacd_2 = 'F03') * p_dist_2 +
	    (integer)(p_aacd_3 = 'F03') * p_dist_3 +
	    (integer)(p_aacd_4 = 'F03') * p_dist_4 +
	    (integer)(p_aacd_5 = 'F03') * p_dist_5 +
	    (integer)(p_aacd_6 = 'F03') * p_dist_6 +
	    (integer)(p_aacd_7 = 'F03') * p_dist_7 +
	    (integer)(p_aacd_8 = 'F03') * p_dist_8 +
	    (integer)(p_aacd_9 = 'F03') * p_dist_9 +
	    (integer)(p_aacd_10 = 'F03') * p_dist_10 +
	    (integer)(p_aacd_11 = 'F03') * p_dist_11 +
	    (integer)(p_aacd_12 = 'F03') * p_dist_12 +
	    (integer)(p_aacd_13 = 'F03') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'S65') * p_dist_12 +
	    (integer)(p_aacd_13 = 'S65') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'C13') * p_dist_12 +
	    (integer)(p_aacd_13 = 'C13') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'C12') * p_dist_12 +
	    (integer)(p_aacd_13 = 'C12') * p_dist_13;
	
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
	    (integer)(p_aacd_12 = 'A47') * p_dist_12 +
	    (integer)(p_aacd_13 = 'A47') * p_dist_13;
	
	p_rcvalued34 := 
	    (integer)(p_aacd_0 = 'D34') * p_dist_0 +
	    (integer)(p_aacd_1 = 'D34') * p_dist_1 +
	    (integer)(p_aacd_2 = 'D34') * p_dist_2 +
	    (integer)(p_aacd_3 = 'D34') * p_dist_3 +
	    (integer)(p_aacd_4 = 'D34') * p_dist_4 +
	    (integer)(p_aacd_5 = 'D34') * p_dist_5 +
	    (integer)(p_aacd_6 = 'D34') * p_dist_6 +
	    (integer)(p_aacd_7 = 'D34') * p_dist_7 +
	    (integer)(p_aacd_8 = 'D34') * p_dist_8 +
	    (integer)(p_aacd_9 = 'D34') * p_dist_9 +
	    (integer)(p_aacd_10 = 'D34') * p_dist_10 +
	    (integer)(p_aacd_11 = 'D34') * p_dist_11 +
	    (integer)(p_aacd_12 = 'D34') * p_dist_12 +
	    (integer)(p_aacd_13 = 'D34') * p_dist_13;
	
//=========================================================
//==  start calculating the RC values for other segment   =
//=========================================================		
	
	o_dist_10 := _ov_pts_lost_raw;
	
	o_aacd_10 := map(
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
	    (integer)(o_aacd_10 = 'C13') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'L80') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'L73') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'A50') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'I60') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'F01') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'F03') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'S65') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'E55') * o_dist_10;
	
	o_rcvaluec12 := 
	    (integer)(o_aacd_0 = 'C12') * o_dist_0 +
	    (integer)(o_aacd_1 = 'C12') * o_dist_1 +
	    (integer)(o_aacd_2 = 'C12') * o_dist_2 +
	    (integer)(o_aacd_3 = 'C12') * o_dist_3 +
	    (integer)(o_aacd_4 = 'C12') * o_dist_4 +
	    (integer)(o_aacd_5 = 'C12') * o_dist_5 +
	    (integer)(o_aacd_6 = 'C12') * o_dist_6 +
	    (integer)(o_aacd_7 = 'C12') * o_dist_7 +
	    (integer)(o_aacd_8 = 'C12') * o_dist_8 +
	    (integer)(o_aacd_9 = 'C12') * o_dist_9 +
	    (integer)(o_aacd_10 = 'C12') * o_dist_10;
	
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
	    (integer)(o_aacd_10 = 'C14') * o_dist_10;
	
	
	
	//*************************************************************************************//
	//  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	 
//=======================
//===   PropOwner     ===
//=======================
	rc_dataset_p := DATASET([
	    {'C22', p_rcvalueC22},
	    {'C21', p_rcvalueC21},
	    {'L80', p_rcvalueL80},
	    {'L73', p_rcvalueL73},
	    {'E55', p_rcvalueE55},
	    {'A50', p_rcvalueA50},
	    {'A44', p_rcvalueA44},
	    {'I60', p_rcvalueI60},
	    {'A43', p_rcvalueA43},
	    {'F03', p_rcvalueF03},
	    {'S65', p_rcvalueS65},
	    {'C13', p_rcvalueC13},
	    {'C12', p_rcvalueC12},
	    {'A47', p_rcvalueA47},
	    {'D34', p_rcvalueD34}
	    ], ds_layout)(value < 0);
	
	rc_dataset_p_sorted := sort(rc_dataset_p, rc_dataset_p.value);
	
	p_rc1 := rc_dataset_p_sorted[1].rc;
	p_rc2 := rc_dataset_p_sorted[2].rc;
	p_rc3 := rc_dataset_p_sorted[3].rc;
	p_rc4 := rc_dataset_p_sorted[4].rc;
	
	p_vl1 := rc_dataset_p_sorted[1].value;
	p_vl2 := rc_dataset_p_sorted[2].value;
	p_vl3 := rc_dataset_p_sorted[3].value;
	p_vl4 := rc_dataset_p_sorted[4].value;
	 
	
	 
//===================
//===  Derog      ===
//===================
	rc_dataset_d := DATASET([
	    {'C21', d_rcvalueC21},
	    {'L73', d_rcvalueL73},
	    {'S65', d_rcvalueS65},
	    {'C12', d_rcvalueC12},         //added the missing C12
	    {'D32', d_rcvalueD32},
	    {'D33', d_rcvalueD33},
	    // {'A50', d_rcvalueA50},
	    {'F01', d_rcvalueF01},
	    {'F03', d_rcvalueF03},
	    {'A41', d_rcvalueA41},
	    {'C13', d_rcvalueC13},
	    {'I60', d_rcvalueI60},
	    {'C10', d_rcvalueC10},
	    {'C14', d_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	rc_dataset_d_sorted := sort(rc_dataset_d, rc_dataset_d.value);
	
	d_rc1 := rc_dataset_d_sorted[1].rc;
	d_rc2 := rc_dataset_d_sorted[2].rc;
	d_rc3 := rc_dataset_d_sorted[3].rc;
	d_rc4 := rc_dataset_d_sorted[4].rc;
	
	d_vl1 := rc_dataset_d_sorted[1].value;
	d_vl2 := rc_dataset_d_sorted[2].value;
	d_vl3 := rc_dataset_d_sorted[3].value;
	d_vl4 := rc_dataset_d_sorted[4].value;
	 
	 
//===================
//===   Other     ===
//===================
	rc_dataset_o := DATASET([
	    {'C13', o_rcvalueC13},
	    {'L80', o_rcvalueL80},
	    {'L73', o_rcvalueL73},
	    {'A50', o_rcvalueA50},
	    {'I60', o_rcvalueI60},
	    {'F01', o_rcvalueF01},
	    {'F03', o_rcvalueF03},
	    {'S65', o_rcvalueS65},
	    {'C12', o_rcvalueC12},
	    {'E55', o_rcvalueE55},
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
	 
	
	 
//====================
//===   VerProb    ===
//====================
	rc_dataset_v := DATASET([
	    {'C22', v_rcvalueC22},
	    {'C21', v_rcvalueC21},
	    {'L80', v_rcvalueL80},
	    {'A50', v_rcvalueA50},
	    {'L73', v_rcvalueL73},
	    {'D32', v_rcvalueD32},
	    {'D33', v_rcvalueD33},
	    {'P85', v_rcvalueP85},
	    {'C13', v_rcvalueC13},
	    {'A44', v_rcvalueA44},
	    {'I60', v_rcvalueI60},
	    {'F00', v_rcvalueF00},
	    {'F03', v_rcvalueF03},
	    {'S65', v_rcvalueS65},
	    {'E55', v_rcvalueE55},
	    {'C12', v_rcvalueC12},
	    {'C14', v_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	
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
	
	
	rc3_2 := map(
	    VerProb_seg => v_rc3,
	    Derog_seg   => d_rc3,
	    Owner_seg   => p_rc3,
	                   o_rc3);
	
	rc2_2 := map(
	    VerProb_seg => v_rc2,
	    Derog_seg   => d_rc2,
	    Owner_seg   => p_rc2,
	                   o_rc2);
	
	rc1_3 := map(
	    VerProb_seg => v_rc1,
	    Derog_seg   => d_rc1,
	    Owner_seg   => p_rc1,
	                   o_rc1);
	
	rc4_2 := map(
	    VerProb_seg => v_rc4,
	    Derog_seg   => d_rc4,
	    Owner_seg   => p_rc4,
	                   o_rc4);
	
	rc1_2 := if(trim(rc1_3, ALL) = ' ', _rc_seg, rc1_3);
	
	
//=======================================================================
//==   Populate the _rc_inq field to be used if there are no other reason
//==   codes populated.
//==   but based on segment this consumer falls into
//=======================================================================		
	
	_rc_inq := map(
	    verprob_seg and rv_i60_inq_auto_count12 > 0 => 'I60',
	    derog_seg and rv_i60_inq_count12 > 0        => 'I60',
	    owner_seg and rv_i60_inq_auto_recency > 0   => 'I60',
	    other_seg and rv_i60_inq_recency > 0        => 'I60',
	                                                   '');
	
	rc5_c164 := map(
	    trim(trim((string)rc1_2, LEFT), LEFT, RIGHT) = '' => ' ',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => ' ',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => ' ',
	    trim(trim(rc4_2, LEFT), LEFT, RIGHT) = ''         => ' ',
	                                                         _rc_inq);
	
	
	
	rc5_1 := if(rc1_2 != 'I60' and rc2_2 != 'I60' and rc3_2 != 'I60' and rc4_2 != 'I60', rc5_c164, ' ');
	
	
	rc3 := if((rva1503_0_2 in [200, 222]), ' ', rc3_2);
	
	rc2 := if((rva1503_0_2 in [200, 222]), ' ', rc2_2);
	
	rc5 := if((rva1503_0_2 in [200, 222]), ' ', rc5_1);
	
	rc1 := if((rva1503_0_2 in [200, 222]), ' ', rc1_2);
	
	rc4 := if((rva1503_0_2 in [200, 222]), ' ', rc4_2);
	


	//*************************************************************************************//
	//                     RiskView Version 5 - RVA1503_0 Score Overrides
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
													rva1503_0_2 = 200 => DATASET([{'00'}], HRILayout),
													rva1503_0_2 = 222 => DATASET([{'00'}], HRILayout),
													rva1503_0_2 = 900 => DATASET([{'00'}], HRILayout),
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
		SELF.seq     := seq;
		SELF.out_z5 := out_z5;
		SELF.out_addr_status := out_addr_status;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_pwphonezipflag := rc_pwphonezipflag;
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
		SELF.hdr_source_profile := hdr_source_profile;
		SELF.hdr_source_profile_index := hdr_source_profile_index;
		SELF.ver_sources := ver_sources;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_isbestmatch := add_input_isbestmatch;
		SELF.add_input_owned_not_occ := add_input_owned_not_occ;
		SELF.add_input_occ_index := add_input_occ_index;
		SELF.add_input_advo_vacancy := add_input_advo_vacancy;
		SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.add_curr_isbestmatch := add_curr_isbestmatch;
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
		SELF.inq_count := inq_count;
		SELF.inq_count01 := inq_count01;
		SELF.inq_count03 := inq_count03;
		SELF.inq_count06 := inq_count06;
		SELF.inq_count12 := inq_count12;
		SELF.inq_count24 := inq_count24;
		SELF.inq_auto_count := inq_auto_count;
		SELF.inq_auto_count01 := inq_auto_count01;
		SELF.inq_auto_count03 := inq_auto_count03;
		SELF.inq_auto_count06 := inq_auto_count06;
		SELF.inq_auto_count12 := inq_auto_count12;
		SELF.inq_auto_count24 := inq_auto_count24;
		SELF.inq_banking_count03 := inq_banking_count03;
		SELF.inq_communications_count03 := inq_communications_count03;
		SELF.inq_mortgage_count03 := inq_mortgage_count03;
		SELF.inq_retail_count03 := inq_retail_count03;
		SELF.pb_average_dollars := pb_average_dollars;
		SELF.pb_total_dollars := pb_total_dollars;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count12 := stl_inq_count12;
		SELF.attr_addrs_last30 := attr_addrs_last30;
		SELF.attr_addrs_last90 := attr_addrs_last90;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_num_aircraft := attr_num_aircraft;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
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
		SELF.watercraft_count := watercraft_count;
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
		SELF.owner_seg := owner_seg;
		SELF.other_seg := other_seg;
		SELF.sysdate := sysdate;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rv_f00_addr_not_ver_w_ssn := rv_f00_addr_not_ver_w_ssn;
		SELF.rv_p85_phn_not_issued := rv_p85_phn_not_issued;
		SELF.rv_d32_criminal_count := rv_d32_criminal_count;
		SELF.rv_c21_stl_inq_count12 := rv_c21_stl_inq_count12;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_c12_num_nonderogs := rv_c12_num_nonderogs;
		SELF.rv_c12_source_profile := rv_c12_source_profile;
		SELF.rv_c12_source_profile_index := rv_c12_source_profile_index;
		SELF.rv_f03_address_match := rv_f03_address_match;
		SELF.rv_l80_inp_avm_autoval := rv_l80_inp_avm_autoval;
		SELF.rv_c14_addrs_10yr := rv_c14_addrs_10yr;
		SELF.rv_c22_inp_addr_occ_index := rv_c22_inp_addr_occ_index;
		SELF.rv_a44_prop_owner_inp_only := rv_a44_prop_owner_inp_only;
		SELF.rv_e55_college_ind := rv_e55_college_ind;
		SELF.rv_i60_inq_auto_count12 := rv_i60_inq_auto_count12;
		SELF.rv_c13_attr_addrs_recency := rv_c13_attr_addrs_recency;
		SELF.rv_a50_pb_average_dollars := rv_a50_pb_average_dollars;
		SELF.iv_d34_liens_unrel_x_rel := iv_d34_liens_unrel_x_rel;
		SELF.rv_a47_curr_avm_autoval := rv_a47_curr_avm_autoval;
		SELF.rv_c22_inp_addr_owned_not_occ := rv_c22_inp_addr_owned_not_occ;
		SELF.rv_a43_rec_vehx_level := rv_a43_rec_vehx_level;
		SELF.rv_i60_inq_auto_recency := rv_i60_inq_auto_recency;
		SELF.rv_i60_inq_count12 := rv_i60_inq_count12;
		SELF.rv_a50_pb_total_dollars := rv_a50_pb_total_dollars;
		SELF.rv_f01_inp_addr_address_score := rv_f01_inp_addr_address_score;
		SELF.rv_c14_addrs_5yr := rv_c14_addrs_5yr;
		SELF.rv_i60_credit_seeking := rv_i60_credit_seeking;
		SELF.rv_i60_inq_recency := rv_i60_inq_recency;
		SELF.rv_a41_prop_owner := rv_a41_prop_owner;
		SELF._header_first_seen := _header_first_seen;
		SELF.rv_c10_m_hdr_fs := rv_c10_m_hdr_fs;
		SELF.rv_c14_addrs_15yr := rv_c14_addrs_15yr;
		SELF._criminal_last_date := _criminal_last_date;
		SELF.rv_d32_mos_since_crim_ls := rv_d32_mos_since_crim_ls;
		SELF.rv_d33_eviction_count := rv_d33_eviction_count;
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
		SELF.v_rawscore := v_rawscore;
		SELF.v_lnoddsscore := v_lnoddsscore;
		SELF.v_probscore := v_probscore;
		SELF.v_aacd_0 := v_aacd_0;
		SELF.v_dist_0 := v_dist_0;
		SELF.v_aacd_1 := v_aacd_1;
		SELF.v_dist_1 := v_dist_1;
		SELF.v_aacd_2 := v_aacd_2;
		SELF.v_dist_2 := v_dist_2;
		SELF.v_aacd_3 := v_aacd_3;
		SELF.v_dist_3 := v_dist_3;
		SELF.v_aacd_4 := v_aacd_4;
		SELF.v_dist_4 := v_dist_4;
		SELF.v_aacd_5 := v_aacd_5;
		SELF.v_dist_5 := v_dist_5;
		SELF.v_aacd_6 := v_aacd_6;
		SELF.v_dist_6 := v_dist_6;
		SELF.v_aacd_7 := v_aacd_7;
		SELF.v_dist_7 := v_dist_7;
		SELF.v_aacd_8 := v_aacd_8;
		SELF.v_dist_8 := v_dist_8;
		SELF.v_aacd_9 := v_aacd_9;
		SELF.v_dist_9 := v_dist_9;
		SELF.v_aacd_10 := v_aacd_10;
		SELF.v_dist_10 := v_dist_10;
		SELF.v_aacd_11 := v_aacd_11;
		SELF.v_dist_11 := v_dist_11;
		SELF.v_aacd_12 := v_aacd_12;
		SELF.v_dist_12 := v_dist_12;
		SELF.v_aacd_13 := v_aacd_13;
		SELF.v_dist_13 := v_dist_13;
		SELF.v_aacd_14 := v_aacd_14;
		SELF.v_dist_14 := v_dist_14;
		SELF.v_aacd_15 := v_aacd_15;
		SELF.v_dist_15 := v_dist_15;
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
		SELF.d_aacd_5 := d_aacd_5;
		SELF.d_dist_5 := d_dist_5;
		SELF.d_aacd_6 := d_aacd_6;
		SELF.d_dist_6 := d_dist_6;
		SELF.d_aacd_7 := d_aacd_7;
		SELF.d_dist_7 := d_dist_7;
		SELF.d_aacd_8 := d_aacd_8;
		SELF.d_dist_8 := d_dist_8;
		SELF.d_aacd_9 := d_aacd_9;
		SELF.d_dist_9 := d_dist_9;
		SELF.d_aacd_10 := d_aacd_10;
		SELF.d_dist_10 := d_dist_10;
		SELF.d_aacd_11 := d_aacd_11;
		SELF.d_dist_11 := d_dist_11;
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
		SELF.p_subscore12 := p_subscore12;
		SELF.p_rawscore := p_rawscore;
		SELF.p_lnoddsscore := p_lnoddsscore;
		SELF.p_probscore := p_probscore;
		SELF.p_aacd_0 := p_aacd_0;
		SELF.p_dist_0 := p_dist_0;
		SELF.p_aacd_1_1 := p_aacd_1_1;
		SELF.p_dist_1_1 := p_dist_1_1;
		SELF.p_aacd_2 := p_aacd_2;
		SELF.p_dist_2 := p_dist_2;
		SELF.p_aacd_3 := p_aacd_3;
		SELF.p_dist_3 := p_dist_3;
		SELF.p_aacd_4 := p_aacd_4;
		SELF.p_dist_4 := p_dist_4;
		SELF.p_aacd_5 := p_aacd_5;
		SELF.p_dist_5 := p_dist_5;
		SELF.p_aacd_6 := p_aacd_6;
		SELF.p_dist_6 := p_dist_6;
		SELF.p_aacd_7 := p_aacd_7;
		SELF.p_dist_7_1 := p_dist_7_1;
		SELF.p_dist_7 := p_dist_7;
		SELF.p_dist_1 := p_dist_1;
		SELF.p_aacd_1 := p_aacd_1;
		SELF.p_aacd_8 := p_aacd_8;
		SELF.p_dist_8 := p_dist_8;
		SELF.p_aacd_9 := p_aacd_9;
		SELF.p_dist_9 := p_dist_9;
		SELF.p_aacd_10 := p_aacd_10;
		SELF.p_dist_10 := p_dist_10;
		SELF.p_aacd_11 := p_aacd_11;
		SELF.p_dist_11 := p_dist_11;
		SELF.p_aacd_12 := p_aacd_12;
		SELF.p_dist_12 := p_dist_12;
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
		SELF.o_dist_3 := o_dist_3;
		SELF.o_aacd_4 := o_aacd_4;
		SELF.o_dist_4 := o_dist_4;
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
		SELF.base := base;
		SELF.points := points;
		SELF.odds := odds;
		SELF.lnoddsscore := lnoddsscore;
		SELF.score_lnodds := score_lnodds;
		SELF.score_lnodds_capped := score_lnodds_capped;
		SELF.ov_ssnprior := ov_ssnprior;
		SELF.ov_corrections := ov_corrections;
		SELF.deceased := deceased;
		SELF._ov_pts_lost_c150_b3 := _ov_pts_lost_c150_b3;
		SELF._ov_pts_lost_raw := _ov_pts_lost_raw;
		SELF.rva1503_0_2 := rva1503_0_2;
		SELF._rc_seg_c153 := _rc_seg_c153;
		SELF._rc_seg_c154 := _rc_seg_c154;
		SELF._rc_seg_c152 := _rc_seg_c152;
		SELF._rc_seg_c155 := _rc_seg_c155;
		SELF._rc_seg := _rc_seg;
		SELF.v_dist_16 := v_dist_16;
		SELF.v_aacd_16 := v_aacd_16;
		SELF.v_rcvaluec22 := v_rcvaluec22;
		SELF.v_rcvaluec21 := v_rcvaluec21;
		SELF.v_rcvaluel80 := v_rcvaluel80;
		SELF.v_rcvaluea50 := v_rcvaluea50;
		SELF.v_rcvaluel73 := v_rcvaluel73;
		SELF.v_rcvalued32 := v_rcvalued32;
		SELF.v_rcvalued33 := v_rcvalued33;
		SELF.v_rcvaluep85 := v_rcvaluep85;
		SELF.v_rcvaluec13 := v_rcvaluec13;
		SELF.v_rcvaluea44 := v_rcvaluea44;
		SELF.v_rcvaluei60 := v_rcvaluei60;
		SELF.v_rcvaluef00 := v_rcvaluef00;
		SELF.v_rcvaluef03 := v_rcvaluef03;
		SELF.v_rcvalueS65 := v_rcvalueS65;
		SELF.v_rcvaluee55 := v_rcvaluee55;
		SELF.v_rcvaluec12 := v_rcvaluec12;
		SELF.v_rcvaluec14 := v_rcvaluec14;
		SELF.d_dist_12 := d_dist_12;
		SELF.d_aacd_12 := d_aacd_12;
		SELF.d_rcvaluec21 := d_rcvaluec21;
		SELF.d_rcvaluel73 := d_rcvaluel73;
		SELF.d_rcvalueS65 := d_rcvalueS65;
		SELF.d_rcvalued32 := d_rcvalued32;
		SELF.d_rcvalued33 := d_rcvalued33;
		SELF.d_rcvaluea50 := d_rcvaluea50;
		SELF.d_rcvaluef01 := d_rcvaluef01;
		SELF.d_rcvaluef03 := d_rcvaluef03;
		SELF.d_rcvaluea41 := d_rcvaluea41;
		SELF.d_rcvaluec13 := d_rcvaluec13;
		SELF.d_rcvaluei60 := d_rcvaluei60;
		SELF.d_rcvaluec10 := d_rcvaluec10;
		SELF.d_rcvaluec14 := d_rcvaluec14;
		SELF.p_dist_13 := p_dist_13;
		SELF.p_aacd_13 := p_aacd_13;
		SELF.p_rcvaluec22 := p_rcvaluec22;
		SELF.p_rcvaluec21 := p_rcvaluec21;
		SELF.p_rcvaluel80 := p_rcvaluel80;
		SELF.p_rcvaluel73 := p_rcvaluel73;
		SELF.p_rcvaluee55 := p_rcvaluee55;
		SELF.p_rcvaluea50 := p_rcvaluea50;
		SELF.p_rcvaluea44 := p_rcvaluea44;
		SELF.p_rcvaluei60 := p_rcvaluei60;
		SELF.p_rcvaluea43 := p_rcvaluea43;
		SELF.p_rcvaluef03 := p_rcvaluef03;
		SELF.p_rcvalueS65 := p_rcvalueS65;
		SELF.p_rcvaluec13 := p_rcvaluec13;
		SELF.p_rcvaluec12 := p_rcvaluec12;
		SELF.p_rcvaluea47 := p_rcvaluea47;
		SELF.p_rcvalued34 := p_rcvalued34;
		SELF.o_dist_10 := o_dist_10;
		SELF.o_aacd_10 := o_aacd_10;
		SELF.o_rcvaluec13 := o_rcvaluec13;
		SELF.o_rcvaluel80 := o_rcvaluel80;
		SELF.o_rcvaluel73 := o_rcvaluel73;
		SELF.o_rcvaluea50 := o_rcvaluea50;
		SELF.o_rcvaluei60 := o_rcvaluei60;
		SELF.o_rcvaluef01 := o_rcvaluef01;
		SELF.o_rcvaluef03 := o_rcvaluef03;
		SELF.o_rcvalueS65 := o_rcvalueS65;
		SELF.o_rcvaluee55 := o_rcvaluee55;
		SELF.o_rcvaluec12 := o_rcvaluec12;
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
		SELF.rc3_2 := rc3_2;
		SELF.rc2_2 := rc2_2;
		SELF.rc1_3 := rc1_3;
		SELF.rc4_2 := rc4_2;
		SELF.rc1_2 := rc1_2;
		SELF._rc_inq := _rc_inq;
		SELF.rc5_c164 := rc5_c164;
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
		SELF.score := (STRING3)rva1503_0_2;
		SELF.model_name := 'RVA1503_DEBUG'; 
		

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rva1503_0_2;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
