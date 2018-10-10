IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, riskview;

EXPORT RVT1404_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			BOOLEAN truedid;
			STRING out_z5;
			STRING out_addr_status;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING nap_status;
			INTEGER rc_ssndod;
			INTEGER rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			INTEGER rc_phonevalflag;
			INTEGER rc_hphonevalflag;
			INTEGER rc_hriskaddrflag;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_addrvalflag;
			INTEGER rc_addrcommflag;
			STRING rc_hrisksic;
			STRING rc_hrisksicphone;
			INTEGER rc_phonetype;
			INTEGER rc_ziptypeflag;
			INTEGER combo_dobscore;
			DECIMAL4_1 hdr_source_profile;
			DECIMAL4_1 hdr_source_profile_index;
			STRING ver_sources;
			BOOLEAN addrpop;
			INTEGER ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;
			INTEGER add_input_address_score;
			BOOLEAN add_input_isbestmatch;
			INTEGER add_input_lres;
			INTEGER add_input_occ_index;
			STRING add_input_advo_vacancy;
			STRING add_input_advo_res_or_bus;
			INTEGER add_input_avm_auto_val;
			INTEGER add_input_naprop;
			BOOLEAN add_input_pop;
			INTEGER property_owned_total;
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
			INTEGER addrs_per_adl_c6;
			INTEGER adls_per_addr_c6;
			INTEGER invalid_ssns_per_adl;
			INTEGER inq_count12;
			INTEGER inq_highriskcredit_count12;
			INTEGER inq_ssnsperadl;
			STRING pb_average_dollars;
			INTEGER br_source_count;
			INTEGER infutor_nap;
			INTEGER stl_inq_count90;
			INTEGER stl_inq_count180;
			INTEGER stl_inq_count12;
			INTEGER stl_inq_count24;
			INTEGER email_count;
			INTEGER email_domain_free_count;
			INTEGER attr_addrs_last30;
			INTEGER attr_addrs_last90;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_total_number_derogs;
			INTEGER attr_num_unrel_liens30;
			INTEGER attr_num_unrel_liens90;
			INTEGER attr_num_unrel_liens180;
			INTEGER attr_num_unrel_liens12;
			INTEGER attr_num_unrel_liens24;
			INTEGER attr_num_unrel_liens36;
			INTEGER attr_num_unrel_liens60;
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
			INTEGER has_derog;
			STRING rv_4seg_riskview_5_0;
			BOOLEAN verprob_seg;
			BOOLEAN derog_seg;
			BOOLEAN owner_seg;
			BOOLEAN other_seg;
			STRING iv_rv5_unscorable;
			DECIMAL21_1 rv_c12_source_profile;
			DECIMAL21_1 rv_c12_source_profile_index;
			STRING rv_p85_phn_disconnected;
			INTEGER rv_d30_derog_count;
			STRING rv_d32_criminal_x_felony;
			INTEGER rv_c22_stl_recency;
			INTEGER rv_d33_eviction_count;
			STRING iv_d34_liens_unrel_x_rel;
			INTEGER rv_c15_ssns_per_adl;
			INTEGER rv_s66_adlperssn_count;
			INTEGER rv_l80_inp_avm_autoval;
			INTEGER rv_a46_curr_avm_autoval;
			INTEGER rv_c23_inp_addr_occ_index;
			STRING rv_a41_prop_owner;
			STRING rv_a41_prop_owner_inp_only;
			INTEGER rv_c20_email_domain_free_count;
			STRING rv_e55_college_ind;
			INTEGER rv_i60_inq_count12;
			INTEGER rv_i60_inq_hiriskcred_count12;
			INTEGER rv_l79_adls_per_addr_c6;
			INTEGER rv_a50_pb_average_dollars;
			INTEGER iv_f00_dob_score;
			INTEGER iv_f01_inp_addr_address_score;
			INTEGER iv_c13_inp_addr_lres;
			INTEGER rv_c22_stl_inq_count24;
			STRING rv_d33_eviction_recency;
			INTEGER rv_c14_addrs_5yr;
			STRING rv_e57_br_flag;
			INTEGER rv_c13_attr_addrs_recency;
			INTEGER rv_d34_attr_unrel_liens_recency;
			INTEGER rv_c12_nonderog_recency;
			STRING rv_a44_curr_add_naprop;
			INTEGER rv_c14_addrs_per_adl_c6;
			STRING rv_e57_prof_license_flag;
			INTEGER iv_i60_inq_ssns_per_adl;
			INTEGER rv_c20_email_count;
			INTEGER rv_l79_adls_per_addr_curr;
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
			REAL verprob_subscore12;
			REAL verprob_subscore13;
			REAL verprob_subscore14;
			REAL verprob_subscore15;
			REAL verprob_subscore16;
			REAL verprob_subscore17;
			REAL verprob_subscore18;
			REAL verprob_subscore19;
			REAL verprob_subscore20;
			REAL verprob_subscore21;
			REAL verprob_rawscore;
			REAL verprob_lnoddsscore;
			REAL verprob_probscore;
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
			STRING verprob_aacd_12;
			REAL verprob_dist_12;
			STRING verprob_aacd_13;
			REAL verprob_dist_13;
			STRING verprob_aacd_14;
			REAL verprob_dist_14;
			STRING verprob_aacd_15;
			REAL verprob_dist_15;
			STRING verprob_aacd_16;
			REAL verprob_dist_16;
			STRING verprob_aacd_17;
			REAL verprob_dist_17;
			STRING verprob_aacd_18;
			REAL verprob_dist_18;
			STRING verprob_aacd_19;
			REAL verprob_dist_19;
			STRING verprob_aacd_20;
			REAL verprob_dist_20;
			STRING verprob_aacd_21;
			REAL verprob_dist_21;
			REAL verprob_rcvaluel79;
			REAL verprob_rcvalued34;
			REAL verprob_rcvalued32;
			REAL verprob_rcvalued33;
			REAL verprob_rcvalued30;
			REAL verprob_rcvaluea51;
			REAL verprob_rcvaluea50;
			REAL verprob_rcvaluef01;
			REAL verprob_rcvaluef00;
			REAL verprob_rcvaluee55;
			REAL verprob_rcvaluec12;
			REAL verprob_rcvaluec15;
			REAL verprob_rcvaluel80;
			REAL verprob_rcvaluec22;
			REAL verprob_rcvaluec23;
			REAL verprob_rcvaluec20;
			REAL verprob_rcvaluea46;
			REAL verprob_rcvaluec13;
			REAL verprob_rcvaluea41;
			REAL verprob_rcvalues66;
			REAL verprob_rcvaluep85;
			REAL verprob_rcvaluei60;
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
			REAL derog_subscore12;
			REAL derog_subscore13;
			REAL derog_subscore14;
			REAL derog_subscore15;
			REAL derog_subscore16;
			REAL derog_subscore17;
			REAL derog_subscore18;
			REAL derog_subscore19;
			REAL derog_subscore20;
			REAL derog_subscore21;
			REAL derog_rawscore;
			REAL derog_lnoddsscore;
			REAL derog_probscore;
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
			STRING derog_aacd_12;
			REAL derog_dist_12;
			STRING derog_aacd_13;
			REAL derog_dist_13;
			STRING derog_aacd_14;
			REAL derog_dist_14;
			STRING derog_aacd_15;
			REAL derog_dist_15;
			STRING derog_aacd_16;
			REAL derog_dist_16;
			STRING derog_aacd_17;
			REAL derog_dist_17;
			STRING derog_aacd_18;
			REAL derog_dist_18;
			STRING derog_aacd_19;
			REAL derog_dist_19;
			STRING derog_aacd_20;
			REAL derog_dist_20;
			STRING derog_aacd_21;
			REAL derog_dist_21;
			REAL derog_rcvaluec22;
			REAL derog_rcvaluec23;
			REAL derog_rcvaluec20;
			REAL derog_rcvaluel79;
			REAL derog_rcvaluel80;
			REAL derog_rcvaluei60;
			REAL derog_rcvalued34;
			REAL derog_rcvalued32;
			REAL derog_rcvalued33;
			REAL derog_rcvaluec13;
			REAL derog_rcvaluea51;
			REAL derog_rcvaluea50;
			REAL derog_rcvalues66;
			REAL derog_rcvaluef01;
			REAL derog_rcvaluea41;
			REAL derog_rcvaluee55;
			REAL derog_rcvaluec12;
			REAL derog_rcvaluee57;
			REAL derog_rcvaluea46;
			REAL derog_rcvaluec15;
			REAL derog_rcvaluec14;
			REAL owner_subscore0;
			REAL owner_subscore1;
			REAL owner_subscore2;
			REAL owner_subscore3;
			REAL owner_subscore4;
			REAL owner_subscore5;
			REAL owner_subscore6;
			REAL owner_subscore7;
			REAL owner_subscore8;
			REAL owner_subscore9;
			REAL owner_subscore10;
			REAL owner_subscore11;
			REAL owner_subscore12;
			REAL owner_subscore13;
			REAL owner_subscore14;
			REAL owner_rawscore;
			REAL owner_lnoddsscore;
			REAL owner_probscore;
			REAL owner_dist_0;
			STRING owner_aacd_1;
			REAL owner_dist_1;
			STRING owner_aacd_2;
			REAL owner_dist_2;
			STRING owner_aacd_3;
			REAL owner_dist_3;
			STRING owner_aacd_4;
			REAL owner_dist_4;
			STRING owner_aacd_5;
			REAL owner_dist_5;
			STRING owner_aacd_6;
			REAL owner_dist_6;
			STRING owner_aacd_7;
			REAL owner_dist_7;
			STRING owner_aacd_8;
			REAL owner_dist_8;
			STRING owner_aacd_9;
			REAL owner_dist_9;
			STRING owner_aacd_10;
			REAL owner_dist_10;
			STRING owner_aacd_11;
			REAL owner_dist_11;
			STRING owner_aacd_12;
			REAL owner_dist_12;
			STRING owner_aacd_13;
			REAL owner_dist_13;
			STRING owner_aacd_14;
			REAL owner_dist_14;
			REAL owner_rcvaluea46;
			REAL owner_rcvaluef01;
			REAL owner_rcvaluel79;
			REAL owner_rcvaluec23;
			REAL owner_rcvaluel80;
			REAL owner_rcvaluec20;
			REAL owner_rcvalued30;
			REAL owner_rcvaluea51;
			REAL owner_rcvaluea50;
			REAL owner_rcvaluei60;
			REAL owner_rcvaluea41;
			REAL owner_rcvaluee55;
			REAL owner_rcvaluec12;
			REAL owner_rcvalues66;
			REAL owner_rcvaluec15;
			REAL owner_rcvaluec14;
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
			REAL other_subscore11;
			REAL other_subscore12;
			REAL other_subscore13;
			REAL other_subscore14;
			REAL other_subscore15;
			REAL other_subscore16;
			REAL other_subscore17;
			REAL other_subscore18;
			REAL other_rawscore;
			REAL other_lnoddsscore;
			REAL other_probscore;
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
			STRING other_aacd_11;
			REAL other_dist_11;
			STRING other_aacd_12;
			REAL other_dist_12;
			STRING other_aacd_13;
			REAL other_dist_13;
			STRING other_aacd_14;
			REAL other_dist_14;
			STRING other_aacd_15;
			REAL other_dist_15;
			STRING other_aacd_16;
			REAL other_dist_16;
			STRING other_aacd_17;
			REAL other_dist_17;
			STRING other_aacd_18;
			REAL other_dist_18;
			REAL other_rcvaluea46;
			REAL other_rcvaluec20;
			REAL other_rcvaluec23;
			REAL other_rcvaluel80;
			REAL other_rcvaluea41;
			REAL other_rcvaluec13;
			REAL other_rcvaluea51;
			REAL other_rcvaluea50;
			REAL other_rcvaluea44;
			REAL other_rcvaluef01;
			REAL other_rcvaluep85;
			REAL other_rcvaluec12;
			REAL other_rcvaluee55;
			REAL other_rcvaluei60;
			REAL other_rcvaluee57;
			REAL other_rcvalues66;
			REAL other_rcvaluec15;
			REAL other_rcvaluec14;
			REAL lnoddsscore;
			INTEGER score_lnodds;
			INTEGER score_lnodds_capped;
			BOOLEAN ov_ssnprior;
			BOOLEAN ov_corrections;
			INTEGER deceased;
			INTEGER rvt1404_0_0;
			STRING _rc_seg_c210;
			STRING _rc_seg_c211;
			STRING _rc_seg_c209;
			STRING _rc_seg_c212;
			STRING _rc_seg;
			STRING owner_rc1;
			STRING owner_rc2;
			STRING owner_rc3;
			STRING owner_rc4;
			STRING other_rc1;
			STRING other_rc2;
			STRING other_rc3;
			STRING other_rc4;
			STRING verprob_rc1;
			STRING verprob_rc2;
			STRING verprob_rc3;
			STRING verprob_rc4;
			STRING derog_rc1;
			STRING derog_rc2;
			STRING derog_rc3;
			STRING derog_rc4;
			STRING rc1_c214;
			STRING rc2_c215;
			STRING rc3_c216;
			STRING rc4_c217;
			STRING _rc_inq;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
			STRING4 rc5;

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
	out_z5                           := le.shell_input.z5;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := (INTEGER)le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_hriskphoneflag                := (INTEGER)le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := (INTEGER)le.iid.phonevalflag;
	rc_hphonevalflag                 := (INTEGER)le.iid.hphonevalflag;
	rc_hriskaddrflag                 := (INTEGER)le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_addrcommflag                  := (INTEGER)le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := (INTEGER)le.iid.phonetype;
	rc_ziptypeflag                   := (INTEGER)le.iid.ziptypeflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	hdr_source_profile               := le.source_profile;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := (INTEGER)le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.lres;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator	;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind	;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
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
	adls_per_ssn                     := le.SSN_Verification.adlperssn_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count90                  := le.impulse.count90;
	stl_inq_count180                 := le.impulse.count180;
	stl_inq_count12                  := le.impulse.count12;
	stl_inq_count24                  := le.impulse.count24;
	email_count                      := le.email_summary.email_ct;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
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
	felony_count                     := le.bjl.felony_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	num_dob_match_level := (integer)input_dob_match_level;
	
	nas_summary_ver := if((ssnlength > 0 and nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7] and add_input_isbestmatch), 1, 0);
	
	nap_summary_ver := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);
	
	infutor_nap_ver := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);
	
	dob_ver := if(dobpop and num_dob_match_level >= 5, 1, 0);
	
	sufficiently_verified := map(
	    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
	    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
	    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
	                                                                                                                               0);
	
	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];
	
	addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = 4 or rc_addrcommflag = 2 or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = 2 or rc_ziptypeflag = 2) or add_input_advo_vacancy = 'Y', 1, 0);
	
	phn_validation_problem := if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = 2 or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = 0 or rc_hphonevalflag = 0 or rc_phonetype = 5 or rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or rc_hphonevalflag = 3 or rc_addrcommflag = 1, 1, 0);
	
	validation_problem := if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '2225' or rc_hrisksicphone = '2225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0);
	
	tot_liens := liens_historical_unreleased_ct +
	    liens_recent_unreleased_count +
	    liens_recent_released_count +
	    liens_historical_released_count;
	
	tot_liens_w_type := liens_unrel_LT_ct +
	    liens_rel_LT_ct +
	    liens_unrel_SC_ct +
	    liens_rel_SC_ct +
	    liens_unrel_CJ_ct +
	    liens_rel_CJ_ct +
	    liens_unrel_FT_ct +
	    liens_rel_FT_ct +
	    liens_unrel_OT_ct +
	    liens_rel_OT_ct +
	    liens_unrel_ST_ct +
	    liens_rel_ST_ct +
	    liens_unrel_FC_ct +
	    liens_rel_FC_ct +
	    liens_unrel_O_ct +
	    liens_rel_O_ct;
	
	has_derog := if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0);
	
	rv_4seg_riskview_5_0 := map(
	    truedid = FALSE                                                         => '0 TRUEDID = 0',
	    not((boolean)sufficiently_verified)                                     => '1 VER/VAL PROBLEMS',
	    (boolean)sufficiently_verified and (boolean)(integer)validation_problem => '1 VER/VAL PROBLEMS',
	    has_derog = 1                                                           => '2 DEROG           ',
	    add_input_naprop = 4 or property_owned_total > 0                        => '3 OWNER           ',
	                                                                               '4 OTHER           ');
	
	verprob_seg := (rv_4seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS']);
	
	derog_seg := rv_4seg_riskview_5_0 = '2 DEROG           ';
	
	owner_seg := rv_4seg_riskview_5_0 = '3 OWNER           ';
	
	other_seg := rv_4seg_riskview_5_0 = '4 OTHER           ';
	
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');
	
	rv_c12_source_profile := if(not(truedid), NULL, ROUND(hdr_source_profile * 10)); 
	
	rv_c12_source_profile_index := if(not(truedid), NULL, hdr_source_profile_index);
	
	rv_p85_phn_disconnected := map(
	    not(hphnpop)                                                             => ' ',
	    rc_hriskphoneflag = 5 or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => '1',
	                                                                                '0');
	
	rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));
	
	rv_d32_criminal_x_felony := if(not(truedid), '', (STRING)(min(if(criminal_count = NULL, -NULL, criminal_count), 3)) + '-' + (STRING)(min(if(felony_count = NULL, -NULL, felony_count), 3)));
	
	rv_c22_stl_recency := map(
	    not(truedid)         => NULL,
	    stl_inq_count90 > 0  => 3,
	    stl_inq_count180 > 0 => 6,
	    stl_inq_count12 > 0  => 12,
	    stl_inq_count24 > 0  => 24,
	                            0);
	
	rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));
	
	iv_d34_liens_unrel_x_rel := if(not(truedid), '   ', (STRING)(min(if(liens_recent_unreleased_count + liens_historical_unreleased_ct = NULL, -NULL, liens_recent_unreleased_count + liens_historical_unreleased_ct), 3)) + '-' + (STRING)(min(if(liens_recent_released_count + liens_historical_released_count = NULL, -NULL, liens_recent_released_count + liens_historical_released_count), 2)));
	
	rv_c15_ssns_per_adl := map(
	    not(truedid)     => NULL,
	    ssns_per_adl = 0 => 1,
	                        min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999));
	
	rv_s66_adlperssn_count := map(
	    not(ssnlength > 0) => NULL,
	    adls_per_ssn = 0   => 1,
	                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));
	
	rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);
	
	rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	rv_c23_inp_addr_occ_index := if(not(add_input_pop and truedid), NULL, add_input_occ_index);
	
	rv_a41_prop_owner := map(
	    not(truedid)                                                                                   => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => '1',
	                                                                                                      '0');
	
	rv_a41_prop_owner_inp_only := map(
	    not(truedid)                                => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 => '1',
	                                                   '0');
	
	rv_c20_email_domain_free_count := if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999));
	
	rv_e55_college_ind := map(
	    not(truedid)                           => ' ',
	    (college_file_type in ['H', 'C', 'A']) => '1',
	    college_attendance                     => '1',
	                                              '0');
	
	rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));
	
	rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));
	
	rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));
	
	rv_a50_pb_average_dollars := map(
	    not(truedid)              => NULL,
	    pb_average_dollars = '' 	=> -1,
	                                 (INTEGER)pb_average_dollars);
	
	iv_f00_dob_score := if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));
	
	iv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	iv_c13_inp_addr_lres := if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999));
	
	rv_c22_stl_inq_count24 := if(not(truedid), NULL, min(if(STL_Inq_count24 = NULL, -NULL, STL_Inq_count24), 999));
	
	rv_d33_eviction_recency := map(
	    not(truedid)                                                => '  ',
	    attr_eviction_count90 > 0                                   => '03',
	    attr_eviction_count180 > 0                                  => '06',
	    attr_eviction_count12 > 0                                   => '12',
	    attr_eviction_count24 > 0 and attr_eviction_count >= 2 			=> '24',
	    attr_eviction_count24 > 0                                  	=> '25',
	    attr_eviction_count36 > 0 and attr_eviction_count >= 2 			=> '36',
	    attr_eviction_count36 > 0                                   => '37',
	    attr_eviction_count60 > 0 and attr_eviction_count >= 2 			=> '60',
	    attr_eviction_count60 > 0                                   => '61',
	    attr_eviction_count >= 2                                    => '98',
	    attr_eviction_count >= 1                                    => '99',
	                                                                   '00');
	
	rv_c14_addrs_5yr := map(
	    not(truedid)     => NULL,
	    add_curr_pop = FALSE => -1,
	                        min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));
	
	// This is simply a casting statement with some formatting options, potentially not even needed.
	// rv_e57_br_flag := if(not(truedid), ' ', put(br_source_count > 0, 1.));
	// rv_e57_br_flag := if(not(truedid), ' ', (STRING)(INTEGER)br_source_count);
	rv_e57_br_flag := if(not(truedid), ' ', IF((INTEGER)br_source_count > 0, '1', '0'));
	
	rv_c13_attr_addrs_recency := map(
	    not(truedid)      		=> NULL,
	    attr_addrs_last30 > 0 => 1,
	    attr_addrs_last90 > 0 => 3,
	    attr_addrs_last12 > 0 => 12,
	    attr_addrs_last24 > 0 => 24,
	    attr_addrs_last36 > 0 => 36,
	    addrs_5yr > 0     		=> 60,
	    addrs_10yr > 0    		=> 120,
	    addrs_15yr > 0    		=> 180,
	    addrs_per_adl > 0 		=> 999,
															0);
	
	rv_d34_attr_unrel_liens_recency := map(
	    not(truedid)                       => NULL,
	    attr_num_unrel_liens30 > 0         => 1,
	    attr_num_unrel_liens90 > 0         => 3,
	    attr_num_unrel_liens180 > 0        => 6,
	    attr_num_unrel_liens12 > 0         => 12,
	    attr_num_unrel_liens24 > 0         => 24,
	    attr_num_unrel_liens36 > 0         => 36,
	    attr_num_unrel_liens60 > 0         => 60,
	    liens_historical_unreleased_ct > 0 => 99,
	                                          0);
	
	rv_c12_nonderog_recency := map(
	    not(truedid)            	=> NULL,
	    attr_num_nonderogs90 > 0	=> 3,
	    attr_num_nonderogs180 > 0	=> 6,
	    attr_num_nonderogs12 > 0 	=> 12,
	    attr_num_nonderogs24 > 0 	=> 24,
	    attr_num_nonderogs36 > 0 	=> 36,
	    attr_num_nonderogs60 > 0 	=> 60,
	    attr_num_nonderogs >= 1 	=> 99,
																		0);
	
	// This is simply a casting statement with some formatting options, potentially not even needed.
	// rv_a44_curr_add_naprop := if(not(truedid and add_curr_pop), ' ', put(add_curr_naprop, 1.));
	rv_a44_curr_add_naprop := if(not(truedid and add_curr_pop), ' ', (STRING)(INTEGER)add_curr_naprop);
	
	rv_c14_addrs_per_adl_c6 := if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999));
	
	// This is simply a casting statement with some formatting options, potentially not even needed.
	// rv_e57_prof_license_flag := if(not(truedid), ' ', put(prof_license_flag, 1.));
	rv_e57_prof_license_flag := if(not(truedid), ' ', (STRING)(INTEGER)prof_license_flag);
	
	iv_i60_inq_ssns_per_adl := if(not(truedid), NULL, min(if(inq_ssnsperadl = NULL, -NULL, inq_ssnsperadl), 999));
	
	rv_c20_email_count := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));
	
	rv_l79_adls_per_addr_curr := if(not(addrpop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));
	
	verprob_subscore0 := map(
	    NULL < iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 1  => -0.219202,
	    1 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 5    => 0.025042,
	    5 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 10   => 0.09207,
	    10 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 19  => 0.156136,
	    19 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 90  => 0.196579,
	    90 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 149 => 0.263716,
	    149 <= iv_c13_inp_addr_lres                               => 0.273122,
	                                                                 0);
	
	verprob_subscore1 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0        => -0.092637,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 16235        => -0.711194,
	    16235 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 35204   => -0.315546,
	    35204 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 49315   => -0.202071,
	    49315 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 96323   => -0.031989,
	    96323 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 141399  => 0.093926,
	    141399 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 233546 => 0.204629,
	    233546 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 297660 => 0.39277,
	    297660 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 439875 => 0.461818,
	    439875 <= rv_a46_curr_avm_autoval                                      => 0.585982,
	                                                                              0);
	
	verprob_subscore2 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 17 => -0.082886,
	    17 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 34  => 0.29192,
	    34 <= rv_a50_pb_average_dollars                                     => 0.474421,
	                                                                           0);
	
	verprob_subscore3 := map(
	    (rv_a41_prop_owner in [' ', '1']) => 0.319334,
	    (rv_a41_prop_owner in ['0'])      => -0.071408,
	                                         0);
	
	verprob_subscore4 := map(
	    (rv_e55_college_ind in [' ', '0']) => -0.028395,
	    (rv_e55_college_ind in ['1'])      => 0.460832,
	                                          0);
	
	verprob_subscore5 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => -0.035467,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 27262        => -0.44182,
	    27262 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 44805   => -0.345686,
	    44805 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 67003   => -0.258926,
	    67003 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 95215   => -0.020019,
	    95215 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 126055  => 0.042111,
	    126055 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 192689 => 0.164164,
	    192689 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 250517 => 0.205321,
	    250517 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 379852 => 0.24898,
	    379852 <= rv_l80_inp_avm_autoval                                     => 0.49835,
	                                                                            0);
	
	verprob_subscore6 := map(
	    NULL < rv_c22_stl_recency AND rv_c22_stl_recency < 3 => 0.037371,
	    3 <= rv_c22_stl_recency AND rv_c22_stl_recency < 12  => -0.920082,
	    12 <= rv_c22_stl_recency AND rv_c22_stl_recency < 24 => -0.670623,
	    24 <= rv_c22_stl_recency                             => -0.556759,
	                                                            0);
	
	verprob_subscore7 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.084535,
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => -0.183985,
	    2 <= rv_d30_derog_count                              => -0.280509,
	                                                            0);
	
	verprob_subscore8 := map(
	    (rv_d32_criminal_x_felony in [' ', '0-0'])                                      => 0.036288,
	    (rv_d32_criminal_x_felony in ['1-0'])                                           => -0.279595,
	    (rv_d32_criminal_x_felony in ['2-0'])                                           => -0.406783,
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.743373,
	                                                                                       0);
	
	verprob_subscore9 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 0.05823,
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => -0.065343,
	    3 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 4   => -0.191471,
	    4 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 5   => -0.358419,
	    5 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 6   => -0.509139,
	    6 <= rv_c15_ssns_per_adl                               => -0.902744,
	                                                              0);
	
	verprob_subscore10 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 6 => -0.033734,
	    6 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 7   => 0.199999,
	    7 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 8   => 0.421298,
	    8 <= rv_c12_source_profile_index                                       => 0.601015,
	                                                                              0);
	
	verprob_subscore11 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.075464,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.096196,
	    3 <= rv_s66_adlperssn_count                                  => -0.172639,
	                                                                    0);
	
	verprob_subscore12 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 0.101538,
	    3 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 5   => -0.086068,
	    5 <= rv_c23_inp_addr_occ_index                                     => 0,
	                                                                          0);
	
	verprob_subscore13 := map(
	    NULL < iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 100 => -0.094848,
	    100 <= iv_f01_inp_addr_address_score                                         => 0.078236,
	                                                                                    0);
	
	verprob_subscore14 := map(
	    NULL < rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 1 => 0.053651,
	    1 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 2   => -0.019966,
	    2 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 4   => -0.180469,
	    4 <= rv_c20_email_domain_free_count                                          => -0.272762,
	                                                                                    0);
	
	verprob_subscore15 := map(
	    NULL < iv_f00_dob_score AND iv_f00_dob_score < 100 => -0.311429,
	    100 <= iv_f00_dob_score                            => 0.024976,
	                                                          0);
	
	verprob_subscore16 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.013644,
	    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.440638,
	                                                                                  0);
	
	verprob_subscore17 := map(
	    (iv_d34_liens_unrel_x_rel in [' ', '0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2']) => 0.028017,
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0', '3-1', '3-2'])                    => -0.155777,
	                                                                                            0);
	
	verprob_subscore18 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2 => 0.026542,
	    2 <= rv_l79_adls_per_addr_c6                                   => -0.172048,
	                                                                      0);
	
	verprob_subscore19 := map(
	    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 0.018518,
	    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => -0.16746,
	    2 <= rv_d33_eviction_count                                 => -0.397333,
	                                                                  0);
	
	verprob_subscore20 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.013747,
	    1 <= rv_i60_inq_count12                              => -0.168122,
	                                                            0);
	
	verprob_subscore21 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 0.005526,
	    (rv_p85_phn_disconnected in ['1'])      => -0.386907,
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
	    verprob_subscore11 +
	    verprob_subscore12 +
	    verprob_subscore13 +
	    verprob_subscore14 +
	    verprob_subscore15 +
	    verprob_subscore16 +
	    verprob_subscore17 +
	    verprob_subscore18 +
	    verprob_subscore19 +
	    verprob_subscore20 +
	    verprob_subscore21;
	
	verprob_lnoddsscore := verprob_rawscore + 0.735513;
	
	verprob_probscore := exp(verprob_lnoddsscore) / (1 + exp(verprob_lnoddsscore));
	
	verprob_aacd_0 := map(
			NULL < iv_C13_inp_addr_lres AND iv_C13_inp_addr_lres < 1  => 'C13',
	    1 <= iv_C13_inp_addr_lres AND iv_C13_inp_addr_lres < 5    => 'C13',
	    5 <= iv_C13_inp_addr_lres AND iv_C13_inp_addr_lres < 10   => 'C13',
	    10 <= iv_C13_inp_addr_lres AND iv_C13_inp_addr_lres < 19  => 'C13',
	    19 <= iv_C13_inp_addr_lres AND iv_C13_inp_addr_lres < 90  => 'C13',
	    90 <= iv_C13_inp_addr_lres AND iv_C13_inp_addr_lres < 149 => 'C13',
	    149 <= iv_C13_inp_addr_lres 															=> 'C13',
	                                                                 '');
	
	verprob_dist_0 := IF(verprob_aacd_0 <> '', verprob_subscore0 - 0.273122, 0);
	
	verprob_aacd_1 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 2610      => 'A51',
	    2610 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 16235    => 'A46',
	    16235 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 35204   => 'A46',
	    35204 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 49315   => 'A46',
	    49315 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 96323   => 'A46',
	    96323 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 141399  => 'A46',
	    141399 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 233546 => 'A46',
	    233546 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 297660 => 'A46',
	    297660 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 439875 => 'A46',
	    439875 <= rv_a46_curr_avm_autoval                                      => 'A46',
	                                                                              '');
	
	verprob_dist_1 := IF(verprob_aacd_1 <> '', verprob_subscore1 - 0.585982, 0);
	
	verprob_aacd_2 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 17 => 'A50',
	    17 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 34  => 'A50',
	    34 <= rv_a50_pb_average_dollars                                     => 'A50',
	                                                                           '');
	
	verprob_dist_2 := IF(verprob_aacd_2 <> '', verprob_subscore2 - 0.474421, 0);
	
	verprob_aacd_3 := map(
	    (rv_a41_prop_owner in [' ', '1']) => 'A41',
	    (rv_a41_prop_owner in ['0'])      => 'A41',
	                                         '');
	
	verprob_dist_3 := IF(verprob_aacd_3 <> '', verprob_subscore3 - 0.319334, 0);
	
	verprob_aacd_4 := map(
	    (rv_e55_college_ind in [' ', '0']) => 'E55',
	    (rv_e55_college_ind in ['1'])      => 'E55',
	                                          '');
	
	verprob_dist_4 := IF(verprob_aacd_4 <> '', verprob_subscore4 - 0.460832, 0);
	
	verprob_aacd_5 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 2610      => 'A51',
	    2610 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 27262    => 'L80',
	    27262 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 44805   => 'L80',
	    44805 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 67003   => 'L80',
	    67003 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 95215   => 'L80',
	    95215 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 126055  => 'L80',
	    126055 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 192689 => 'L80',
	    192689 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 250517 => 'L80',
	    250517 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 379852 => 'L80',
	    379852 <= rv_l80_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	verprob_dist_5 := IF(verprob_aacd_5 <> '', verprob_subscore5 - 0.49835, 0);
	
	verprob_aacd_6 := map(
	    NULL < rv_c22_stl_recency AND rv_c22_stl_recency < 3 => 'C22',
	    3 <= rv_c22_stl_recency AND rv_c22_stl_recency < 12  => 'C22',
	    12 <= rv_c22_stl_recency AND rv_c22_stl_recency < 24 => 'C22',
	    24 <= rv_c22_stl_recency                             => 'C22',
	                                                            '');
	
	verprob_dist_6 := IF(verprob_aacd_6 <> '', verprob_subscore6 - 0.037371, 0);
	
	verprob_aacd_7 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 'D30',
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => 'D30',
	    2 <= rv_d30_derog_count                              => 'D30',
	                                                            '');
	
	verprob_dist_7 := IF(verprob_aacd_7 <> '', verprob_subscore7 - 0.084535, 0);
	
	verprob_aacd_8 := map(
	    (rv_d32_criminal_x_felony in [' ', '0-0'])                                      => 'D32',
	    (rv_d32_criminal_x_felony in ['1-0'])                                           => 'D32',
	    (rv_d32_criminal_x_felony in ['2-0'])                                           => 'D32',
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                       '');
	
	verprob_dist_8 := IF(verprob_aacd_8 <> '', verprob_subscore8 - 0.036288, 0);
	
	verprob_aacd_9 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 'C15',
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => 'C15',
	    3 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 4   => 'C15',
	    4 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 5   => 'C15',
	    5 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 6   => 'C15',
	    6 <= rv_c15_ssns_per_adl                               => 'C15',
	                                                              '');
	
	verprob_dist_9 := IF(verprob_aacd_9 <> '', verprob_subscore9 - 0.05823, 0);
	
	verprob_aacd_10 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 6 => 'C12',
	    6 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 7   => 'C12',
	    7 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 8   => 'C12',
	    8 <= rv_c12_source_profile_index                                       => 'C12',
	                                                                              '');
	
	verprob_dist_10 := IF(verprob_aacd_10 <> '', verprob_subscore10 - 0.601015, 0);
	
	verprob_aacd_11 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	verprob_dist_11 := IF(verprob_aacd_11 <> '', verprob_subscore11 - 0.075464, 0);
	
	verprob_aacd_12 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 'C23',
	    3 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 5   => 'C23',
	    5 <= rv_c23_inp_addr_occ_index                                     => 'C23',
	                                                                          '');
	
	verprob_dist_12 := IF(verprob_aacd_12 <> '', verprob_subscore12 - 0.101538, 0);
	
	verprob_aacd_13 := map(
	    NULL < iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= iv_f01_inp_addr_address_score                                         => 'F01',
	                                                                                    '');
	
	verprob_dist_13 := IF(verprob_aacd_13 <> '', verprob_subscore13 - 0.078236, 0);
	
	verprob_aacd_14 := map(
	    NULL < rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 1 => 'C20',
	    1 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 2   => 'C20',
	    2 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 4   => 'C20',
	    4 <= rv_c20_email_domain_free_count                                          => 'C20',
	                                                                                    '');
	
	verprob_dist_14 := IF(verprob_aacd_14 <> '', verprob_subscore14 - 0.053651, 0);
	
	verprob_aacd_15 := map(
	    NULL < iv_f00_dob_score AND iv_f00_dob_score < 100 => 'F00',
	    100 <= iv_f00_dob_score                            => 'F00',
	                                                          '');
	
	verprob_dist_15 := IF(verprob_aacd_15 <> '', verprob_subscore15 - 0.024976, 0);
	
	verprob_aacd_16 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	verprob_dist_16 := IF(verprob_aacd_16 <> '', verprob_subscore16 - 0.013644, 0);
	
	verprob_aacd_17 := map(
	    (iv_d34_liens_unrel_x_rel in [' ', '0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2']) => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0', '3-1', '3-2'])                    => 'D34',
	                                                                                            '');
	
	verprob_dist_17 := IF(verprob_aacd_17 <> '', verprob_subscore17 - 0.028017, 0);
	
	verprob_aacd_18 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2 => 'L79',
	    2 <= rv_l79_adls_per_addr_c6                                   => 'L79',
	                                                                      '');
	
	verprob_dist_18 := IF(verprob_aacd_18 <> '', verprob_subscore18 - 0.026542, 0);
	
	verprob_aacd_19 := map(
	    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1 => 'D33',
	    1 <= rv_d33_eviction_count AND rv_d33_eviction_count < 2   => 'D33',
	    2 <= rv_d33_eviction_count                                 => 'D33',
	                                                                  '');
	
	verprob_dist_19 := IF(verprob_aacd_19 <> '', verprob_subscore19 - 0.018518, 0);
	
	verprob_aacd_20 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12                              => 'I60',
	                                                            '');
	
	verprob_dist_20 := IF(verprob_aacd_20 <> '', verprob_subscore20 - 0.013747, 0);
	
	verprob_aacd_21 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 'P85',
	    (rv_p85_phn_disconnected in ['1'])      => 'P85',
	                                               '');
	
	verprob_dist_21 := IF(verprob_aacd_21 <> '', verprob_subscore21 - 0.005526, 0);
	
	verprob_rcvaluel79 := (integer)(verprob_aacd_1 = 'L79') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'L79') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'L79') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'L79') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'L79') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'L79') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'L79') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'L79') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'L79') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'L79') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'L79') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'L79') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'L79') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'L79') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'L79') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'L79') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'L79') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'L79') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'L79') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'L79') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'L79') * verprob_dist_21;
	
	verprob_rcvalued34 := (integer)(verprob_aacd_1 = 'D34') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'D34') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'D34') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'D34') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'D34') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'D34') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'D34') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'D34') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'D34') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'D34') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'D34') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'D34') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'D34') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'D34') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'D34') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'D34') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'D34') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'D34') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'D34') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'D34') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'D34') * verprob_dist_21;
	
	verprob_rcvalued32 := (integer)(verprob_aacd_1 = 'D32') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'D32') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'D32') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'D32') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'D32') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'D32') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'D32') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'D32') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'D32') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'D32') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'D32') * verprob_dist_21;
	
	verprob_rcvalued33 := (integer)(verprob_aacd_1 = 'D33') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'D33') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'D33') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'D33') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'D33') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'D33') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'D33') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'D33') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'D33') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'D33') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'D33') * verprob_dist_21;
	
	verprob_rcvalued30 := (integer)(verprob_aacd_1 = 'D30') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'D30') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'D30') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'D30') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'D30') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'D30') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'D30') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'D30') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'D30') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'D30') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'D30') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'D30') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'D30') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'D30') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'D30') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'D30') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'D30') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'D30') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'D30') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'D30') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'D30') * verprob_dist_21;
	
	verprob_rcvaluea51 := (integer)(verprob_aacd_1 = 'A51') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A51') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A51') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A51') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A51') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A51') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A51') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A51') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A51') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A51') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A51') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'A51') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'A51') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'A51') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'A51') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'A51') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'A51') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'A51') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'A51') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'A51') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'A51') * verprob_dist_21;
	
	verprob_rcvaluea50 := (integer)(verprob_aacd_1 = 'A50') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'A50') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'A50') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'A50') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'A50') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'A50') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'A50') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'A50') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'A50') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'A50') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'A50') * verprob_dist_21;
	
	verprob_rcvaluef01 := (integer)(verprob_aacd_1 = 'F01') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'F01') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'F01') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'F01') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'F01') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'F01') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'F01') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'F01') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'F01') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'F01') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'F01') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'F01') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'F01') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'F01') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'F01') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'F01') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'F01') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'F01') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'F01') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'F01') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'F01') * verprob_dist_21;
	
	verprob_rcvaluef00 := (integer)(verprob_aacd_1 = 'F00') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'F00') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'F00') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'F00') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'F00') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'F00') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'F00') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'F00') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'F00') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'F00') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'F00') * verprob_dist_21;
	
	verprob_rcvaluee55 := (integer)(verprob_aacd_1 = 'E55') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'E55') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'E55') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'E55') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'E55') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'E55') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'E55') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'E55') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'E55') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'E55') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'E55') * verprob_dist_21;
	
	verprob_rcvaluec12 := (integer)(verprob_aacd_1 = 'C12') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'C12') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'C12') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'C12') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'C12') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'C12') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'C12') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'C12') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'C12') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'C12') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'C12') * verprob_dist_21;
	
	verprob_rcvaluec15 := (integer)(verprob_aacd_1 = 'C15') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C15') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C15') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C15') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C15') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C15') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C15') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C15') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C15') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C15') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C15') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C15') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'C15') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'C15') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'C15') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'C15') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'C15') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'C15') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'C15') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'C15') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'C15') * verprob_dist_21;
	
	verprob_rcvaluel80 := (integer)(verprob_aacd_1 = 'L80') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'L80') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'L80') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'L80') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'L80') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'L80') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'L80') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'L80') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'L80') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'L80') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'L80') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'L80') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'L80') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'L80') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'L80') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'L80') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'L80') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'L80') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'L80') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'L80') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'L80') * verprob_dist_21;
	
	verprob_rcvaluec22 := (integer)(verprob_aacd_1 = 'C22') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C22') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C22') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C22') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C22') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C22') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C22') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C22') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C22') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C22') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C22') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C22') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'C22') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'C22') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'C22') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'C22') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'C22') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'C22') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'C22') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'C22') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'C22') * verprob_dist_21;
	
	verprob_rcvaluec23 := (integer)(verprob_aacd_1 = 'C23') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C23') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C23') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C23') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C23') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C23') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C23') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C23') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C23') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C23') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C23') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C23') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'C23') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'C23') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'C23') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'C23') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'C23') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'C23') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'C23') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'C23') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'C23') * verprob_dist_21;
	
	verprob_rcvaluec20 := (integer)(verprob_aacd_1 = 'C20') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C20') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C20') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C20') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C20') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C20') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C20') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C20') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C20') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C20') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C20') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C20') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'C20') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'C20') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'C20') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'C20') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'C20') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'C20') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'C20') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'C20') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'C20') * verprob_dist_21;
	
	verprob_rcvaluea46 := (integer)(verprob_aacd_1 = 'A46') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A46') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A46') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A46') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A46') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A46') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A46') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A46') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A46') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A46') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A46') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'A46') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'A46') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'A46') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'A46') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'A46') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'A46') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'A46') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'A46') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'A46') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'A46') * verprob_dist_21;
	
	verprob_rcvaluec13 := 
			(integer)(verprob_aacd_0 = 'C13') * verprob_dist_0 +
			(integer)(verprob_aacd_1 = 'C13') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C13') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C13') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C13') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C13') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C13') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C13') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C13') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C13') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C13') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C13') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'C13') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'C13') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'C13') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'C13') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'C13') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'C13') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'C13') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'C13') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'C13') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'C13') * verprob_dist_21;
	
	verprob_rcvaluea41 := (integer)(verprob_aacd_1 = 'A41') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'A41') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'A41') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'A41') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'A41') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'A41') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'A41') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'A41') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'A41') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'A41') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'A41') * verprob_dist_21;
	
	verprob_rcvalues66 := (integer)(verprob_aacd_1 = 'S66') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'S66') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'S66') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'S66') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'S66') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'S66') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'S66') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'S66') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'S66') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'S66') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'S66') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'S66') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'S66') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'S66') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'S66') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'S66') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'S66') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'S66') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'S66') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'S66') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'S66') * verprob_dist_21;
	
	verprob_rcvaluep85 := (integer)(verprob_aacd_1 = 'P85') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'P85') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'P85') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'P85') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'P85') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'P85') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'P85') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'P85') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'P85') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'P85') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'P85') * verprob_dist_11 +
	    (integer)(verprob_aacd_12 = 'P85') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'P85') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'P85') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'P85') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'P85') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'P85') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'P85') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'P85') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'P85') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'P85') * verprob_dist_21;
	
	verprob_rcvaluei60 := (integer)(verprob_aacd_1 = 'I60') * verprob_dist_1 +
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
	    (integer)(verprob_aacd_12 = 'I60') * verprob_dist_12 +
	    (integer)(verprob_aacd_13 = 'I60') * verprob_dist_13 +
	    (integer)(verprob_aacd_14 = 'I60') * verprob_dist_14 +
	    (integer)(verprob_aacd_15 = 'I60') * verprob_dist_15 +
	    (integer)(verprob_aacd_16 = 'I60') * verprob_dist_16 +
	    (integer)(verprob_aacd_17 = 'I60') * verprob_dist_17 +
	    (integer)(verprob_aacd_18 = 'I60') * verprob_dist_18 +
	    (integer)(verprob_aacd_19 = 'I60') * verprob_dist_19 +
	    (integer)(verprob_aacd_20 = 'I60') * verprob_dist_20 +
	    (integer)(verprob_aacd_21 = 'I60') * verprob_dist_21;
	
	derog_subscore0 := map(
	    (rv_d32_criminal_x_felony in ['0-0'])                      => 0.08583,
	    (rv_d32_criminal_x_felony in ['1-0'])                      => -0.054122,
	    (rv_d32_criminal_x_felony in ['2-0'])                      => -0.332987,
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0']) => -0.613865,
	    (rv_d32_criminal_x_felony in ['3-1', '3-2', '3-3'])        => -0.810638,
	                                                                  0);
	
	derog_subscore1 := map(
	    (rv_a41_prop_owner in ['0']) => -0.114027,
	    (rv_a41_prop_owner in ['1']) => 0.359723,
	                                    0);
	
	derog_subscore2 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 15 => -0.078108,
	    15 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 33  => 0.061601,
	    33 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 65  => 0.194242,
	    65 <= rv_a50_pb_average_dollars                                     => 0.244448,
	                                                                           0);
	
	derog_subscore3 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 326  => -0.265292,
	    326 <= rv_c12_source_profile AND rv_c12_source_profile < 681 => -0.039141,
	    681 <= rv_c12_source_profile AND rv_c12_source_profile < 727 => 0.013983,
	    727 <= rv_c12_source_profile AND rv_c12_source_profile < 751 => 0.10727,
	    751 <= rv_c12_source_profile AND rv_c12_source_profile < 822 => 0.218226,
	    822 <= rv_c12_source_profile                                  => 0.419859,
	                                                                      0);
	
	derog_subscore4 := map(
	    NULL < iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 50 => -0.22268,
	    50 <= iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 100 => 0.061389,
	    100 <= iv_f01_inp_addr_address_score                                        => 0.096559,
	                                                                                   0);
	
	derog_subscore5 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => -0.049117,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 23286        => -0.353642,
	    23286 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 34862   => -0.265181,
	    34862 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 51303   => -0.115959,
	    51303 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 84651   => -0.057971,
	    84651 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 109460  => 0.043427,
	    109460 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 160478 => 0.122278,
	    160478 <= rv_l80_inp_avm_autoval                                     => 0.302482,
	                                                                            0);
	
	derog_subscore6 := map(
	    (rv_e55_college_ind in ['0']) => -0.02855,
	    (rv_e55_college_ind in ['1']) => 0.291491,
	                                     0);
	
	derog_subscore7 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 0.140357,
	    (iv_d34_liens_unrel_x_rel in ['1-0'])                                                         => -0.095464,
	    (iv_d34_liens_unrel_x_rel in ['2-0'])                                                         => -0.132946,
	    (iv_d34_liens_unrel_x_rel in ['3-0'])                                                         => -0.184031,
	                                                                                                     0);
	
	derog_subscore8 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 0.115849,
	    3 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 4   => -0.066312,
	    4 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 5   => -0.260735,
	    5 <= rv_c23_inp_addr_occ_index                                     => 0,
	                                                                          0);
	
	derog_subscore9 := map(
	    (rv_d33_eviction_recency in ['00'])                               => 0.061038,
	    (rv_d33_eviction_recency in ['03', '06'])                         => -0.298939,
	    (rv_d33_eviction_recency in ['12', '24', '25', '36', '37', '60']) => -0.238378,
	    (rv_d33_eviction_recency in ['61', '98', '99'])                   => -0.126215,
	                                                                         0);
	
	derog_subscore10 := map(
	    NULL < rv_c22_stl_recency AND rv_c22_stl_recency < 3 => 0.038522,
	    3 <= rv_c22_stl_recency AND rv_c22_stl_recency < 12  => -0.452825,
	    12 <= rv_c22_stl_recency AND rv_c22_stl_recency < 24 => -0.222144,
	    24 <= rv_c22_stl_recency                             => 0.001223,
	                                                            0);
	
	derog_subscore11 := map(
	    NULL < rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 1 => 0.047548,
	    1 <= rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 2   => -0.10175,
	    2 <= rv_c22_stl_inq_count24                                  => -0.454278,
	                                                                    0);
	
	derog_subscore12 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0        => -0.059636,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 52867        => -0.132175,
	    52867 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 106988  => 0.023976,
	    106988 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 304683 => 0.17066,
	    304683 <= rv_a46_curr_avm_autoval                                      => 0.222902,
	                                                                              0);
	
	derog_subscore13 := map(
	    NULL < rv_d34_attr_unrel_liens_recency AND rv_d34_attr_unrel_liens_recency < 24 => -0.074366,
	    24 <= rv_d34_attr_unrel_liens_recency AND rv_d34_attr_unrel_liens_recency < 36  => -0.004895,
	    36 <= rv_d34_attr_unrel_liens_recency AND rv_d34_attr_unrel_liens_recency < 99  => 0.075917,
	    99 <= rv_d34_attr_unrel_liens_recency                                           => 0.157226,
	                                                                                       0);
	
	derog_subscore14 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 0.053621,
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => -0.081573,
	    3 <= rv_c15_ssns_per_adl                               => -0.215006,
	                                                              0);
	
	derog_subscore15 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 0.021564,
	    1 <= rv_i60_inq_hiriskcred_count12                                         => -0.278462,
	                                                                                  0);
	
	derog_subscore16 := map(
	    (rv_e57_br_flag in ['0']) => -0.025538,
	    (rv_e57_br_flag in ['1']) => 0.22976,
	                                 0);
	
	derog_subscore17 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2 => 0.027607,
	    2 <= rv_l79_adls_per_addr_c6                                   => -0.180095,
	                                                                      0);
	
	derog_subscore18 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.05242,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.02472,
	    3 <= rv_s66_adlperssn_count                                  => -0.155933,
	                                                                    0);
	
	derog_subscore19 := map(
	    NULL < rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 2 => 0.038515,
	    2 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 3   => -0.026356,
	    3 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 4   => -0.10263,
	    4 <= rv_c20_email_domain_free_count                                          => -0.20278,
	                                                                                    0);
	
	derog_subscore20 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 0.059061,
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => 0.036624,
	    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => -0.036312,
	    6 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 7   => -0.092632,
	    7 <= rv_c14_addrs_5yr                            => -0.188829,
	                                                        0);
	
	derog_subscore21 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 3 => -0.161212,
	    3 <= rv_c13_attr_addrs_recency                                     => 0.013481,
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
	    derog_subscore11 +
	    derog_subscore12 +
	    derog_subscore13 +
	    derog_subscore14 +
	    derog_subscore15 +
	    derog_subscore16 +
	    derog_subscore17 +
	    derog_subscore18 +
	    derog_subscore19 +
	    derog_subscore20 +
	    derog_subscore21;
	
	derog_lnoddsscore := derog_rawscore + 0.447588;
	
	derog_probscore := exp(derog_lnoddsscore) / (1 + exp(derog_lnoddsscore));
	
	derog_aacd_0 := map(
			(rv_d32_criminal_x_felony in ['0-0'])                      => 'D32',
	    (rv_d32_criminal_x_felony in ['1-0'])                      => 'D32',
	    (rv_d32_criminal_x_felony in ['2-0'])                      => 'D32',
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-0']) => 'D32',
	    (rv_d32_criminal_x_felony in ['3-1', '3-2', '3-3'])        => 'D32',
	                                                                  '');
																																		
	derog_dist_0 := IF(derog_aacd_0 <> '', derog_subscore0 - 0.08583, 0);
	
	derog_aacd_1 := map(
	    (rv_a41_prop_owner in ['0']) => 'A41',
	    (rv_a41_prop_owner in ['1']) => 'A41',
	                                    '');
	
	derog_dist_1 := IF(derog_aacd_1 <> '', derog_subscore1 - 0.359723, 0);
	
	derog_aacd_2 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 15 => 'A50',
	    15 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 33  => 'A50',
	    33 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 65  => 'A50',
	    65 <= rv_a50_pb_average_dollars                                     => 'A50',
	                                                                           '');
	
	derog_dist_2 := IF(derog_aacd_2 <> '', derog_subscore2 - 0.244448, 0);
	
	derog_aacd_3 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 326  => 'C12',
	    326 <= rv_c12_source_profile AND rv_c12_source_profile < 681 => 'C12',
	    681 <= rv_c12_source_profile AND rv_c12_source_profile < 727 => 'C12',
	    727 <= rv_c12_source_profile AND rv_c12_source_profile < 751 => 'C12',
	    751 <= rv_c12_source_profile AND rv_c12_source_profile < 822 => 'C12',
	    822 <= rv_c12_source_profile                                  => 'C12',
	                                                                      '');
	
	derog_dist_3 := IF(derog_aacd_3 <> '', derog_subscore3 - 0.419859, 0);
	
	derog_aacd_4 := map(
	    NULL < iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 50 => 'F01',
	    50 <= iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= iv_f01_inp_addr_address_score                                        => 'F01',
	                                                                                   '');
	
	derog_dist_4 := IF(derog_aacd_4 <> '', derog_subscore4 - 0.096559, 0);
	
	derog_aacd_5 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 4408      => 'A51',
	    4408 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 23286    => 'L80',
	    23286 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 34862   => 'L80',
	    34862 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 51303   => 'L80',
	    51303 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 84651   => 'L80',
	    84651 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 109460  => 'L80',
	    109460 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 160478 => 'L80',
	    160478 <= rv_l80_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	derog_dist_5 := IF(derog_aacd_5 <> '', derog_subscore5 - 0.302482, 0);
	
	derog_aacd_6 := map(
	    (rv_e55_college_ind in ['0']) => 'E55',
	    (rv_e55_college_ind in ['1']) => 'E55',
	                                     '');
	
	derog_dist_6 := IF(derog_aacd_6 <> '', derog_subscore6 - 0.291491, 0);
	
	derog_aacd_7 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['1-0'])                                                         => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['2-0'])                                                         => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['3-0'])                                                         => 'D34',
	                                                                                                     '');
	
	derog_dist_7 := IF(derog_aacd_7 <> '', derog_subscore7 - 0.140357, 0);
	
	derog_aacd_8 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 'C23',
	    3 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 4   => 'C23',
	    4 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 5   => 'C23',
	    5 <= rv_c23_inp_addr_occ_index                                     => 'C23',
	                                                                          '');
	
	derog_dist_8 := IF(derog_aacd_8 <> '', derog_subscore8 - 0.115849, 0);
	
	derog_aacd_9 := map(
	    (rv_d33_eviction_recency in ['00'])                               => 'D33',
	    (rv_d33_eviction_recency in ['03', '06'])                         => 'D33',
	    (rv_d33_eviction_recency in ['12', '24', '25', '36', '37', '60']) => 'D33',
	    (rv_d33_eviction_recency in ['61', '98', '99'])                   => 'D33',
	                                                                         '');
	
	derog_dist_9 := IF(derog_aacd_9 <> '', derog_subscore9 - 0.061038, 0);
	
	derog_aacd_10 := map(
	    NULL < rv_c22_stl_recency AND rv_c22_stl_recency < 3 => 'C22',
	    3 <= rv_c22_stl_recency AND rv_c22_stl_recency < 12  => 'C22',
	    12 <= rv_c22_stl_recency AND rv_c22_stl_recency < 24 => 'C22',
	    24 <= rv_c22_stl_recency                             => 'C22',
	                                                            '');
	
	derog_dist_10 := IF(derog_aacd_10 <> '', derog_subscore10 - 0.038522, 0);
	
	derog_aacd_11 := map(
	    NULL < rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 1 => 'C22',
	    1 <= rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 2   => 'C22',
	    2 <= rv_c22_stl_inq_count24                                  => 'C22',
	                                                                    '');
	
	derog_dist_11 := IF(derog_aacd_11 <> '', derog_subscore11 - 0.047548, 0);
	
	derog_aacd_12 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1664      => 'A51',
	    1664 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 52867    => 'A46',
	    52867 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 106988  => 'A46',
	    106988 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 304683 => 'A46',
	    304683 <= rv_a46_curr_avm_autoval                                      => 'A46',
	                                                                              '');
	
	derog_dist_12 := IF(derog_aacd_12 <> '', derog_subscore12 - 0.222902, 0);
	
	derog_aacd_13 := map(
	    NULL < rv_d34_attr_unrel_liens_recency AND rv_d34_attr_unrel_liens_recency < 24 => 'D34',
	    24 <= rv_d34_attr_unrel_liens_recency AND rv_d34_attr_unrel_liens_recency < 36  => 'D34',
	    36 <= rv_d34_attr_unrel_liens_recency AND rv_d34_attr_unrel_liens_recency < 99  => 'D34',
	    99 <= rv_d34_attr_unrel_liens_recency                                           => 'D34',
	                                                                                       '');
	
	derog_dist_13 := IF(derog_aacd_13 <> '', derog_subscore13 - 0.157226, 0);
	
	derog_aacd_14 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 'C15',
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => 'C15',
	    3 <= rv_c15_ssns_per_adl                               => 'C15',
	                                                              '');
	
	derog_dist_14 := IF(derog_aacd_14 <> '', derog_subscore14 - 0.053621, 0);
	
	derog_aacd_15 := map(
	    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	derog_dist_15 := IF(derog_aacd_15 <> '', derog_subscore15 - 0.021564, 0);
	
	derog_aacd_16 := map(
	    (rv_e57_br_flag in ['0']) => 'E57',
	    (rv_e57_br_flag in ['1']) => 'E57',
	                                 '');
	
	derog_dist_16 := IF(derog_aacd_16 <> '', derog_subscore16 - 0.22976, 0);
	
	derog_aacd_17 := map(
	    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2 => 'L79',
	    2 <= rv_l79_adls_per_addr_c6                                   => 'L79',
	                                                                      '');
	
	derog_dist_17 := IF(derog_aacd_17 <> '', derog_subscore17 - 0.027607, 0);
	
	derog_aacd_18 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	derog_dist_18 := IF(derog_aacd_18 <> '', derog_subscore18 - 0.05242, 0);
	
	derog_aacd_19 := map(
	    NULL < rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 2 => 'C20',
	    2 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 3   => 'C20',
	    3 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 4   => 'C20',
	    4 <= rv_c20_email_domain_free_count                                          => 'C20',
	                                                                                    '');
	
	derog_dist_19 := IF(derog_aacd_19 <> '', derog_subscore19 - 0.038515, 0);
	
	derog_aacd_20 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2 => 'C14',
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => 'C14',
	    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => 'C14',
	    6 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 7   => 'C14',
	    7 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	derog_dist_20 := IF(derog_aacd_20 <> '', derog_subscore20 - 0.059061, 0);
	
	derog_aacd_21 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 3 => 'C13',
	    3 <= rv_c13_attr_addrs_recency                                     => 'C13',
	                                                                          '');
	
	derog_dist_21 := IF(derog_aacd_21 <> '', derog_subscore21 - 0.013481, 0);
	
	derog_rcvaluec22 := (integer)(derog_aacd_1 = 'C22') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C22') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C22') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C22') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C22') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C22') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C22') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C22') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C22') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C22') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C22') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C22') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C22') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'C22') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'C22') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'C22') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'C22') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'C22') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'C22') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'C22') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'C22') * derog_dist_21;
	
	derog_rcvaluec23 := (integer)(derog_aacd_1 = 'C23') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C23') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C23') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C23') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C23') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C23') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C23') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C23') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C23') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C23') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C23') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C23') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C23') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'C23') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'C23') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'C23') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'C23') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'C23') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'C23') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'C23') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'C23') * derog_dist_21;
	
	derog_rcvaluec20 := (integer)(derog_aacd_1 = 'C20') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C20') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C20') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C20') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C20') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C20') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C20') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C20') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C20') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C20') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C20') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C20') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C20') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'C20') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'C20') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'C20') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'C20') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'C20') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'C20') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'C20') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'C20') * derog_dist_21;
	
	derog_rcvaluel79 := (integer)(derog_aacd_1 = 'L79') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'L79') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'L79') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'L79') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'L79') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'L79') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'L79') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'L79') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'L79') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'L79') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'L79') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'L79') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'L79') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'L79') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'L79') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'L79') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'L79') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'L79') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'L79') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'L79') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'L79') * derog_dist_21;
	
	derog_rcvaluel80 := (integer)(derog_aacd_1 = 'L80') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'L80') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'L80') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'L80') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'L80') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'L80') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'L80') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'L80') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'L80') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'L80') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'L80') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'L80') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'L80') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'L80') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'L80') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'L80') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'L80') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'L80') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'L80') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'L80') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'L80') * derog_dist_21;
	
	derog_rcvaluei60 := (integer)(derog_aacd_1 = 'I60') * derog_dist_1 +
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
	    (integer)(derog_aacd_12 = 'I60') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'I60') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'I60') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'I60') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'I60') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'I60') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'I60') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'I60') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'I60') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'I60') * derog_dist_21;
	
	derog_rcvalued34 := (integer)(derog_aacd_1 = 'D34') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'D34') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'D34') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'D34') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'D34') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'D34') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'D34') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'D34') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'D34') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'D34') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'D34') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'D34') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'D34') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'D34') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'D34') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'D34') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'D34') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'D34') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'D34') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'D34') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'D34') * derog_dist_21;
	
	derog_rcvalued32 := 
			(integer)(derog_aacd_0 = 'D32') * derog_dist_0 +
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
	    (integer)(derog_aacd_12 = 'D32') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'D32') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'D32') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'D32') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'D32') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'D32') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'D32') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'D32') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'D32') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'D32') * derog_dist_21;
	
	derog_rcvalued33 := (integer)(derog_aacd_1 = 'D33') * derog_dist_1 +
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
	    (integer)(derog_aacd_12 = 'D33') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'D33') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'D33') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'D33') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'D33') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'D33') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'D33') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'D33') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'D33') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'D33') * derog_dist_21;
	
	derog_rcvaluec13 := (integer)(derog_aacd_1 = 'C13') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C13') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C13') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C13') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C13') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C13') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C13') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C13') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C13') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C13') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C13') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C13') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C13') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'C13') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'C13') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'C13') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'C13') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'C13') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'C13') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'C13') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'C13') * derog_dist_21;
	
	derog_rcvaluea51 := (integer)(derog_aacd_1 = 'A51') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A51') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A51') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A51') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A51') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A51') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A51') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A51') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A51') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A51') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'A51') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'A51') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'A51') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'A51') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'A51') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'A51') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'A51') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'A51') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'A51') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'A51') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'A51') * derog_dist_21;
	
	derog_rcvaluea50 := (integer)(derog_aacd_1 = 'A50') * derog_dist_1 +
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
	    (integer)(derog_aacd_12 = 'A50') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'A50') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'A50') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'A50') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'A50') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'A50') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'A50') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'A50') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'A50') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'A50') * derog_dist_21;
	
	derog_rcvalues66 := (integer)(derog_aacd_1 = 'S66') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'S66') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'S66') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'S66') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'S66') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'S66') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'S66') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'S66') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'S66') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'S66') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'S66') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'S66') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'S66') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'S66') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'S66') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'S66') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'S66') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'S66') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'S66') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'S66') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'S66') * derog_dist_21;
	
	derog_rcvaluef01 := (integer)(derog_aacd_1 = 'F01') * derog_dist_1 +
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
	    (integer)(derog_aacd_12 = 'F01') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'F01') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'F01') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'F01') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'F01') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'F01') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'F01') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'F01') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'F01') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'F01') * derog_dist_21;
	
	derog_rcvaluea41 := (integer)(derog_aacd_1 = 'A41') * derog_dist_1 +
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
	    (integer)(derog_aacd_12 = 'A41') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'A41') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'A41') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'A41') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'A41') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'A41') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'A41') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'A41') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'A41') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'A41') * derog_dist_21;
	
	derog_rcvaluee55 := (integer)(derog_aacd_1 = 'E55') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'E55') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'E55') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'E55') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'E55') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'E55') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'E55') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'E55') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'E55') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'E55') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'E55') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'E55') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'E55') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'E55') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'E55') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'E55') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'E55') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'E55') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'E55') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'E55') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'E55') * derog_dist_21;
	
	derog_rcvaluec12 := (integer)(derog_aacd_1 = 'C12') * derog_dist_1 +
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
	    (integer)(derog_aacd_12 = 'C12') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C12') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'C12') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'C12') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'C12') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'C12') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'C12') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'C12') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'C12') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'C12') * derog_dist_21;
	
	derog_rcvaluee57 := (integer)(derog_aacd_1 = 'E57') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'E57') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'E57') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'E57') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'E57') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'E57') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'E57') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'E57') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'E57') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'E57') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'E57') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'E57') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'E57') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'E57') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'E57') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'E57') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'E57') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'E57') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'E57') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'E57') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'E57') * derog_dist_21;
	
	derog_rcvaluea46 := (integer)(derog_aacd_1 = 'A46') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A46') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A46') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A46') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A46') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A46') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A46') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A46') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A46') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A46') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'A46') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'A46') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'A46') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'A46') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'A46') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'A46') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'A46') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'A46') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'A46') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'A46') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'A46') * derog_dist_21;
	
	derog_rcvaluec15 := (integer)(derog_aacd_1 = 'C15') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C15') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C15') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C15') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C15') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C15') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C15') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C15') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C15') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C15') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'C15') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'C15') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C15') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'C15') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'C15') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'C15') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'C15') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'C15') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'C15') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'C15') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'C15') * derog_dist_21;
	
	derog_rcvaluec14 := (integer)(derog_aacd_1 = 'C14') * derog_dist_1 +
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
	    (integer)(derog_aacd_12 = 'C14') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C14') * derog_dist_13 +
	    (integer)(derog_aacd_14 = 'C14') * derog_dist_14 +
	    (integer)(derog_aacd_15 = 'C14') * derog_dist_15 +
	    (integer)(derog_aacd_16 = 'C14') * derog_dist_16 +
	    (integer)(derog_aacd_17 = 'C14') * derog_dist_17 +
	    (integer)(derog_aacd_18 = 'C14') * derog_dist_18 +
	    (integer)(derog_aacd_19 = 'C14') * derog_dist_19 +
	    (integer)(derog_aacd_20 = 'C14') * derog_dist_20 +
	    (integer)(derog_aacd_21 = 'C14') * derog_dist_21;
	
	owner_subscore0 := map(
	    NULL < iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 20 => -0.831985,
	    20 <= iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 50  => -0.61483,
	    50 <= iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 100 => -0.044598,
	    100 <= iv_f01_inp_addr_address_score                                        => 0.134082,
	                                                                                   0);
	
	owner_subscore1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0       => -0.1573,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 25200       => -0.633681,
	    25200 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 57830  => -0.35991,
	    57830 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 92844  => -0.250764,
	    92844 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 150026 => 0.006884,
	    150026 <= rv_l80_inp_avm_autoval                                    => 0.360759,
	                                                                           0);
	
	owner_subscore2 := map(
	    NULL < iv_i60_inq_ssns_per_adl AND iv_i60_inq_ssns_per_adl < 1 => 0.084958,
	    1 <= iv_i60_inq_ssns_per_adl                                   => -0.950647,
	                                                                      0);
	
	owner_subscore3 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0        => -0.14685,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 27652        => -0.589651,
	    27652 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 57595   => -0.37241,
	    57595 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 78964   => -0.249957,
	    78964 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 92501   => -0.035587,
	    92501 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 137602  => -0.000266,
	    137602 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 196355 => 0.190166,
	    196355 <= rv_a46_curr_avm_autoval                                      => 0.339273,
	                                                                              0);
	
	owner_subscore4 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 232  => -0.495338,
	    232 <= rv_c12_source_profile AND rv_c12_source_profile < 676 => -0.178216,
	    676 <= rv_c12_source_profile AND rv_c12_source_profile < 748 => -0.026577,
	    748 <= rv_c12_source_profile AND rv_c12_source_profile < 812 => 0.136951,
	    812 <= rv_c12_source_profile                                  => 0.416786,
	                                                                      0);
	
	owner_subscore5 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 14 => -0.14612,
	    14 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 30  => 0.004365,
	    30 <= rv_a50_pb_average_dollars                                     => 0.195292,
	                                                                           0);
	
	owner_subscore6 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3 => 0.094539,
	    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4   => -0.192429,
	    4 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => -0.354741,
	    5 <= rv_l79_adls_per_addr_curr                                     => -0.597047,
	                                                                          0);
	
	owner_subscore7 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 0.099294,
	    3 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 4   => -0.154859,
	    4 <= rv_c23_inp_addr_occ_index                                     => -0.47208,
	                                                                          0);
	
	owner_subscore8 := map(
	    (rv_e55_college_ind in ['0']) => -0.042366,
	    (rv_e55_college_ind in ['1']) => 0.295711,
	                                     0);
	
	owner_subscore9 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 0.087712,
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => -0.239621,
	    3 <= rv_c15_ssns_per_adl                               => -0.440829,
	                                                              0);
	
	owner_subscore10 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.044227,
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => -0.307058,
	    2 <= rv_d30_derog_count                              => -0.694579,
	                                                            0);
	
	owner_subscore11 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1 => 0.128899,
	    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => 0.030407,
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => -0.001084,
	    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => -0.071756,
	    4 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5   => -0.144103,
	    5 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => -0.212955,
	    6 <= rv_c14_addrs_5yr                            => -0.300409,
	                                                        0);
	
	owner_subscore12 := map(
	    (rv_a41_prop_owner_inp_only in ['0']) => -0.172443,
	    (rv_a41_prop_owner_inp_only in ['1']) => 0.03921,
	                                             0);
	
	owner_subscore13 := map(
	    NULL < rv_c20_email_count AND rv_c20_email_count < 8 => 0.012901,
	    8 <= rv_c20_email_count                              => -0.612896,
	                                                            0);
	
	owner_subscore14 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.068656,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.068915,
	    3 <= rv_s66_adlperssn_count                                  => -0.140282,
	                                                                    0);
	
	owner_rawscore := owner_subscore0 +
	    owner_subscore1 +
	    owner_subscore2 +
	    owner_subscore3 +
	    owner_subscore4 +
	    owner_subscore5 +
	    owner_subscore6 +
	    owner_subscore7 +
	    owner_subscore8 +
	    owner_subscore9 +
	    owner_subscore10 +
	    owner_subscore11 +
	    owner_subscore12 +
	    owner_subscore13 +
	    owner_subscore14;
	
	owner_lnoddsscore := owner_rawscore + 2.627010;
	
	owner_probscore := exp(owner_lnoddsscore) / (1 + exp(owner_lnoddsscore));
	
	owner_aacd_0 := map(
			NULL < iv_F01_inp_addr_address_score AND iv_F01_inp_addr_address_score < 20   => 'F01',
	    20 <= iv_F01_inp_addr_address_score AND iv_F01_inp_addr_address_score < 50   	=> 'F01',
	    50 <= iv_F01_inp_addr_address_score AND iv_F01_inp_addr_address_score < 100  	=> 'F01',
	    100 <= iv_F01_inp_addr_address_score  																				=> 'F01',
																																												'');
																																						 
	owner_dist_0 := IF(owner_aacd_0 <> '', owner_subscore0 - 0.134082, 0);
	
	owner_aacd_1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1864     => 'A51',
	    1864 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 25200   => 'L80',
	    25200 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 57830  => 'L80',
	    57830 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 92844  => 'L80',
	    92844 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 150026 => 'L80',
	    150026 <= rv_l80_inp_avm_autoval                                    => 'L80',
	                                                                           '');
	
	owner_dist_1 := IF(owner_aacd_1 <> '', owner_subscore1 - 0.360759, 0);
	
	owner_aacd_2 := map(
	    NULL < iv_i60_inq_ssns_per_adl AND iv_i60_inq_ssns_per_adl < 1 => 'I60',
	    1 <= iv_i60_inq_ssns_per_adl                                   => 'I60',
	                                                                      '');
	
	owner_dist_2 := IF(owner_aacd_2 <> '', owner_subscore2 - 0.084958, 0);
	
	owner_aacd_3 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 459       => 'A51',
	    459 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 27652     => 'A46',
	    27652 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 57595   => 'A46',
	    57595 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 78964   => 'A46',
	    78964 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 92501   => 'A46',
	    92501 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 137602  => 'A46',
	    137602 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 196355 => 'A46',
	    196355 <= rv_a46_curr_avm_autoval                                      => 'A46',
	                                                                              '');
	
	owner_dist_3 := IF(owner_aacd_3 <> '', owner_subscore3 - 0.339273, 0);
	
	owner_aacd_4 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 232  => 'C12',
	    232 <= rv_c12_source_profile AND rv_c12_source_profile < 676 => 'C12',
	    676 <= rv_c12_source_profile AND rv_c12_source_profile < 748 => 'C12',
	    748 <= rv_c12_source_profile AND rv_c12_source_profile < 812 => 'C12',
	    812 <= rv_c12_source_profile                                  => 'C12',
	                                                                      '');
	
	owner_dist_4 := IF(owner_aacd_4 <> '', owner_subscore4 - 0.416786, 0);
	
	owner_aacd_5 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 14 => 'A50',
	    14 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 30  => 'A50',
	    30 <= rv_a50_pb_average_dollars                                     => 'A50',
	                                                                           '');
	
	owner_dist_5 := IF(owner_aacd_5 <> '', owner_subscore5 - 0.195292, 0);
	
	owner_aacd_6 := map(
	    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 3 => 'L79',
	    3 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 4   => 'L79',
	    4 <= rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr < 5   => 'L79',
	    5 <= rv_l79_adls_per_addr_curr                                     => 'L79',
	                                                                          '');
	
	owner_dist_6 := IF(owner_aacd_6 <> '', owner_subscore6 - 0.094539, 0);
	
	owner_aacd_7 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 'C23',
	    3 <= rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 4   => 'C23',
	    4 <= rv_c23_inp_addr_occ_index                                     => 'C23',
	                                                                          '');
	
	owner_dist_7 := IF(owner_aacd_7 <> '', owner_subscore7 - 0.099294, 0);
	
	owner_aacd_8 := map(
	    (rv_e55_college_ind in ['0']) => 'E55',
	    (rv_e55_college_ind in ['1']) => 'E55',
	                                     '');
	
	owner_dist_8 := IF(owner_aacd_8 <> '', owner_subscore8 - 0.295711, 0);
	
	owner_aacd_9 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 'C15',
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => 'C15',
	    3 <= rv_c15_ssns_per_adl                               => 'C15',
	                                                              '');
	
	owner_dist_9 := IF(owner_aacd_9 <> '', owner_subscore9 - 0.087712, 0);
	
	owner_aacd_10 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 'D30',
	    1 <= rv_d30_derog_count AND rv_d30_derog_count < 2   => 'D30',
	    2 <= rv_d30_derog_count                              => 'D30',
	                                                            '');
	
	owner_dist_10 := IF(owner_aacd_10 <> '', owner_subscore10 - 0.044227, 0);
	
	owner_aacd_11 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1 => 'C14',
	    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => 'C14',
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 3   => 'C14',
	    3 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => 'C14',
	    4 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 5   => 'C14',
	    5 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 6   => 'C14',
	    6 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	owner_dist_11 := IF(owner_aacd_11 <> '', owner_subscore11 - 0.128899, 0);
	
	owner_aacd_12 := map(
	    (rv_a41_prop_owner_inp_only in ['0']) => 'A41',
	    (rv_a41_prop_owner_inp_only in ['1']) => 'A41',
	                                             '');
	
	owner_dist_12 := IF(owner_aacd_12 <> '', owner_subscore12 - 0.03921, 0);
	
	owner_aacd_13 := map(
	    NULL < rv_c20_email_count AND rv_c20_email_count < 8 => 'C20',
	    8 <= rv_c20_email_count                              => 'C20',
	                                                            '');
	
	owner_dist_13 := IF(owner_aacd_13 <> '', owner_subscore13 - 0.012901, 0);
	
	owner_aacd_14 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	owner_dist_14 := IF(owner_aacd_14 <> '', owner_subscore14 - 0.068656, 0);
	
	owner_rcvaluea46 := (integer)(owner_aacd_1 = 'A46') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A46') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A46') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A46') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A46') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A46') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A46') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A46') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A46') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A46') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A46') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'A46') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'A46') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'A46') * owner_dist_14;
	
	owner_rcvaluef01 := 
			(integer)(owner_aacd_0 = 'F01') * owner_dist_0 +
			(integer)(owner_aacd_1 = 'F01') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'F01') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'F01') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'F01') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'F01') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'F01') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'F01') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'F01') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'F01') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'F01') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'F01') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'F01') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'F01') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'F01') * owner_dist_14;
	
	owner_rcvaluel79 := (integer)(owner_aacd_1 = 'L79') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'L79') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'L79') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'L79') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'L79') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'L79') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'L79') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'L79') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'L79') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'L79') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'L79') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'L79') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'L79') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'L79') * owner_dist_14;
	
	owner_rcvaluec23 := (integer)(owner_aacd_1 = 'C23') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C23') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C23') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C23') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C23') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C23') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C23') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C23') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C23') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C23') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C23') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'C23') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'C23') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'C23') * owner_dist_14;
	
	owner_rcvaluel80 := (integer)(owner_aacd_1 = 'L80') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'L80') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'L80') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'L80') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'L80') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'L80') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'L80') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'L80') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'L80') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'L80') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'L80') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'L80') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'L80') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'L80') * owner_dist_14;
	
	owner_rcvaluec20 := (integer)(owner_aacd_1 = 'C20') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C20') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C20') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C20') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C20') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C20') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C20') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C20') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C20') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C20') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C20') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'C20') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'C20') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'C20') * owner_dist_14;
	
	owner_rcvalued30 := (integer)(owner_aacd_1 = 'D30') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'D30') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'D30') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'D30') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'D30') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'D30') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'D30') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'D30') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'D30') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'D30') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'D30') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'D30') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'D30') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'D30') * owner_dist_14;
	
	owner_rcvaluea51 := (integer)(owner_aacd_1 = 'A51') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A51') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A51') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A51') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A51') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A51') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A51') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A51') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A51') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A51') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A51') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'A51') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'A51') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'A51') * owner_dist_14;
	
	owner_rcvaluea50 := (integer)(owner_aacd_1 = 'A50') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A50') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A50') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A50') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A50') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A50') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A50') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A50') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A50') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A50') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A50') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'A50') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'A50') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'A50') * owner_dist_14;
	
	owner_rcvaluei60 := (integer)(owner_aacd_1 = 'I60') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'I60') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'I60') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'I60') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'I60') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'I60') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'I60') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'I60') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'I60') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'I60') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'I60') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'I60') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'I60') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'I60') * owner_dist_14;
	
	owner_rcvaluea41 := (integer)(owner_aacd_1 = 'A41') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A41') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A41') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A41') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A41') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A41') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A41') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A41') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A41') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A41') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A41') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'A41') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'A41') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'A41') * owner_dist_14;
	
	owner_rcvaluee55 := (integer)(owner_aacd_1 = 'E55') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'E55') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'E55') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'E55') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'E55') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'E55') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'E55') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'E55') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'E55') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'E55') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'E55') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'E55') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'E55') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'E55') * owner_dist_14;
	
	owner_rcvaluec12 := (integer)(owner_aacd_1 = 'C12') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C12') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C12') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C12') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C12') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C12') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C12') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C12') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C12') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C12') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C12') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'C12') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'C12') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'C12') * owner_dist_14;
	
	owner_rcvalues66 := (integer)(owner_aacd_1 = 'S66') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'S66') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'S66') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'S66') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'S66') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'S66') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'S66') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'S66') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'S66') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'S66') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'S66') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'S66') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'S66') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'S66') * owner_dist_14;
	
	owner_rcvaluec15 := (integer)(owner_aacd_1 = 'C15') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C15') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C15') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C15') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C15') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C15') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C15') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C15') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C15') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C15') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C15') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'C15') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'C15') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'C15') * owner_dist_14;
	
	owner_rcvaluec14 := (integer)(owner_aacd_1 = 'C14') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C14') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C14') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C14') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C14') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C14') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C14') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C14') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C14') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C14') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C14') * owner_dist_11 +
	    (integer)(owner_aacd_12 = 'C14') * owner_dist_12 +
	    (integer)(owner_aacd_13 = 'C14') * owner_dist_13 +
	    (integer)(owner_aacd_14 = 'C14') * owner_dist_14;
	
	other_subscore0 := map(
	    NULL < iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 60 => -0.446035,
	    60 <= iv_f01_inp_addr_address_score AND iv_f01_inp_addr_address_score < 100 => 0.017942,
	    100 <= iv_f01_inp_addr_address_score                                        => 0.193858,
	                                                                                   0);
	
	other_subscore1 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => -0.109552,
	    0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 13  => -0.166883,
	    13 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 19 => -0.053493,
	    19 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 35 => 0.160044,
	    35 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 67 => 0.366699,
	    67 <= rv_a50_pb_average_dollars                                    => 0.457538,
	                                                                          0);
	
	other_subscore2 := map(
	    (rv_e55_college_ind in ['0']) => -0.049946,
	    (rv_e55_college_ind in ['1']) => 0.397692,
	                                     0);
	
	other_subscore3 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0       => -0.08685,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 41800       => -0.400118,
	    41800 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 65725  => -0.205934,
	    65725 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 111409 => 0.073685,
	    111409 <= rv_a46_curr_avm_autoval                                     => 0.303103,
	                                                                             0);
	
	other_subscore4 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0        => -0.020011,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 20697        => -0.605573,
	    20697 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 41152   => -0.321472,
	    41152 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 64981   => -0.202604,
	    64981 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 99023   => -0.096389,
	    99023 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 154121  => 0.01189,
	    154121 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 250683 => 0.20865,
	    250683 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 378448 => 0.329691,
	    378448 <= rv_l80_inp_avm_autoval                                     => 0.546485,
	                                                                            0);
	
	other_subscore5 := map(
	    NULL < iv_i60_inq_ssns_per_adl AND iv_i60_inq_ssns_per_adl < 1 => 0.054403,
	    1 <= iv_i60_inq_ssns_per_adl                                   => -0.526755,
	                                                                      0);
	
	other_subscore6 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 0.067657,
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => -0.240468,
	    3 <= rv_c15_ssns_per_adl                               => -0.538608,
	                                                              0);
	
	other_subscore7 := map(
	    (rv_a44_curr_add_naprop in ['0'])           => -0.022033,
	    (rv_a44_curr_add_naprop in ['1'])           => -0.13085,
	    (rv_a44_curr_add_naprop in ['2', '3', '4']) => 0.23951,
	                                                   0);
	
	other_subscore8 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 85   => -0.304836,
	    85 <= rv_c12_source_profile AND rv_c12_source_profile < 221  => -0.127853,
	    221 <= rv_c12_source_profile AND rv_c12_source_profile < 645 => 0.007479,
	    645 <= rv_c12_source_profile AND rv_c12_source_profile < 749 => 0.035538,
	    749 <= rv_c12_source_profile AND rv_c12_source_profile < 805 => 0.168772,
	    805 <= rv_c12_source_profile                                  => 0.387611,
	                                                                      0);
	
	other_subscore9 := map(
	    (rv_e57_br_flag in ['0']) => -0.031524,
	    (rv_e57_br_flag in ['1']) => 0.432469,
	                                 0);
	
	other_subscore10 := map(
	    NULL < rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 1 => 0.066235,
	    1 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 2   => 0.001925,
	    2 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 3   => -0.134957,
	    3 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 4   => -0.24701,
	    4 <= rv_c20_email_domain_free_count                                          => -0.352629,
	                                                                                    0);
	
	other_subscore11 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.075021,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.082897,
	    3 <= rv_s66_adlperssn_count                                  => -0.224162,
	                                                                    0);
	
	other_subscore12 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 0.091628,
	    3 <= rv_c23_inp_addr_occ_index                                     => -0.11417,
	                                                                          0);
	
	other_subscore13 := map(
	    (rv_a41_prop_owner in ['0']) => -0.015183,
	    (rv_a41_prop_owner in ['1']) => 0.491628,
	                                    0);
	
	other_subscore14 := map(
	    NULL < rv_c12_nonderog_recency AND rv_c12_nonderog_recency < 6 => 0.028452,
	    6 <= rv_c12_nonderog_recency                                   => -0.215471,
	                                                                      0);
	
	other_subscore15 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 12 => -0.132101,
	    12 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60  => -0.005861,
	    60 <= rv_c13_attr_addrs_recency                                     => 0.120283,
	                                                                           0);
	
	other_subscore16 := map(
	    (rv_e57_prof_license_flag in ['0']) => -0.015606,
	    (rv_e57_prof_license_flag in ['1']) => 0.418661,
	                                           0);
	
	other_subscore17 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 0.007531,
	    (rv_p85_phn_disconnected in ['1'])      => -0.471727,
	                                               0);
	
	other_subscore18 := map(
	    NULL < rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 1 => 0.028178,
	    1 <= rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 2   => -0.059264,
	    2 <= rv_c14_addrs_per_adl_c6                                   => -0.177157,
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
	    other_subscore10 +
	    other_subscore11 +
	    other_subscore12 +
	    other_subscore13 +
	    other_subscore14 +
	    other_subscore15 +
	    other_subscore16 +
	    other_subscore17 +
	    other_subscore18;
	
	other_lnoddsscore := other_rawscore + 1.221380;
	
	other_probscore := exp(other_lnoddsscore) / (1 + exp(other_lnoddsscore));
	
	other_aacd_0 := map(
	    NULL < iv_F01_inp_addr_address_score AND iv_F01_inp_addr_address_score < 60 => 'F01',
	    60 <= iv_F01_inp_addr_address_score AND iv_F01_inp_addr_address_score < 100 => 'F01',
	    100 <= iv_F01_inp_addr_address_score 																				=> 'F01',
																																											'');
	
	other_dist_0 := IF(other_aacd_0 <> '', other_subscore0 - 0.193858, 0);
	
	other_aacd_1 := map(
	    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 'A50',
	    0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 13  => 'A50',
	    13 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 19 => 'A50',
	    19 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 35 => 'A50',
	    35 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 67 => 'A50',
	    67 <= rv_a50_pb_average_dollars                                    => 'A50',
	                                                                          '');
	
	other_dist_1 := IF(other_aacd_1 <> '', other_subscore1 - 0.457538, 0);
	
	other_aacd_2 := map(
	    (rv_e55_college_ind in ['0']) => 'E55',
	    (rv_e55_college_ind in ['1']) => 'E55',
	                                     '');
	
	other_dist_2 := IF(other_aacd_2 <> '', other_subscore2 - 0.397692, 0);
	
	other_aacd_3 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1323     => 'A51',
	    1323 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 41800   => 'A46',
	    41800 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 65725  => 'A46',
	    65725 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 111409 => 'A46',
	    111409 <= rv_a46_curr_avm_autoval                                     => 'A46',
	                                                                             '');
	
	other_dist_3 := IF(other_aacd_3 <> '', other_subscore3 - 0.303103, 0);
	
	other_aacd_4 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 2256      => 'A51',
	    2256 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 20697    => 'L80',
	    20697 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 41152   => 'L80',
	    41152 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 64981   => 'L80',
	    64981 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 99023   => 'L80',
	    99023 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 154121  => 'L80',
	    154121 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 250683 => 'L80',
	    250683 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 378448 => 'L80',
	    378448 <= rv_l80_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	other_dist_4 := IF(other_aacd_4 <> '', other_subscore4 - 0.546485, 0);
	
	other_aacd_5 := map(
	    NULL < iv_i60_inq_ssns_per_adl AND iv_i60_inq_ssns_per_adl < 1 => 'I60',
	    1 <= iv_i60_inq_ssns_per_adl                                   => 'I60',
	                                                                      '');
	
	other_dist_5 := IF(other_aacd_5 <> '', other_subscore5 - 0.054403, 0);
	
	other_aacd_6 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 'C15',
	    2 <= rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 3   => 'C15',
	    3 <= rv_c15_ssns_per_adl                               => 'C15',
	                                                              '');
	
	other_dist_6 := IF(other_aacd_6 <> '', other_subscore6 - 0.067657, 0);
	
	other_aacd_7 := map(
	    (rv_a44_curr_add_naprop in ['0'])           => 'A44',
	    (rv_a44_curr_add_naprop in ['1'])           => 'A44',
	    (rv_a44_curr_add_naprop in ['2', '3', '4']) => 'A44',
	                                                   '');
	
	other_dist_7 := IF(other_aacd_7 <> '', other_subscore7 - 0.23951, 0);
	
	other_aacd_8 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 85   => 'C12',
	    85 <= rv_c12_source_profile AND rv_c12_source_profile < 221  => 'C12',
	    221 <= rv_c12_source_profile AND rv_c12_source_profile < 645 => 'C12',
	    645 <= rv_c12_source_profile AND rv_c12_source_profile < 749 => 'C12',
	    749 <= rv_c12_source_profile AND rv_c12_source_profile < 805 => 'C12',
	    805 <= rv_c12_source_profile                                  => 'C12',
	                                                                      '');
	
	other_dist_8 := IF(other_aacd_8 <> '', other_subscore8 - 0.387611, 0);
	
	other_aacd_9 := map(
	    (rv_e57_br_flag in ['0']) => 'E57',
	    (rv_e57_br_flag in ['1']) => 'E57',
	                                 '');
	
	other_dist_9 := IF(other_aacd_9 <> '', other_subscore9 - 0.432469, 0);
	
	other_aacd_10 := map(
	    NULL < rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 1 => 'C20',
	    1 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 2   => 'C20',
	    2 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 3   => 'C20',
	    3 <= rv_c20_email_domain_free_count AND rv_c20_email_domain_free_count < 4   => 'C20',
	    4 <= rv_c20_email_domain_free_count                                          => 'C20',
	                                                                                    '');
	
	other_dist_10 := IF(other_aacd_10 <> '', other_subscore10 - 0.066235, 0);
	
	other_aacd_11 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	other_dist_11 := IF(other_aacd_11 <> '', other_subscore11 - 0.075021, 0);
	
	other_aacd_12 := map(
	    NULL < rv_c23_inp_addr_occ_index AND rv_c23_inp_addr_occ_index < 3 => 'C23',
	    3 <= rv_c23_inp_addr_occ_index                                     => 'C23',
	                                                                          '');
	
	other_dist_12 := IF(other_aacd_12 <> '', other_subscore12 - 0.091628, 0);
	
	other_aacd_13 := map(
	    (rv_a41_prop_owner in ['0']) => 'A41',
	    (rv_a41_prop_owner in ['1']) => 'A41',
	                                    '');
	
	other_dist_13 := IF(other_aacd_13 <> '', other_subscore13 - 0.491628, 0);
	
	other_aacd_14 := map(
	    NULL < rv_c12_nonderog_recency AND rv_c12_nonderog_recency < 6 => 'C12',
	    6 <= rv_c12_nonderog_recency                                   => 'C12',
	                                                                      '');
	
	other_dist_14 := IF(other_aacd_14 <> '', other_subscore14 - 0.028452, 0);
	
	other_aacd_15 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 12 => 'C13',
	    12 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60  => 'C13',
	    60 <= rv_c13_attr_addrs_recency                                     => 'C13',
	                                                                           '');
	
	other_dist_15 := IF(other_aacd_15 <> '', other_subscore15 - 0.120283, 0);
	
	other_aacd_16 := map(
	    (rv_e57_prof_license_flag in ['0']) => 'E57',
	    (rv_e57_prof_license_flag in ['1']) => 'E57',
	                                           '');
	
	other_dist_16 := IF(other_aacd_16 <> '', other_subscore16 - 0.418661, 0);
	
	other_aacd_17 := map(
	    (rv_p85_phn_disconnected in [' ', '0']) => 'P85',
	    (rv_p85_phn_disconnected in ['1'])      => 'P85',
	                                               '');
	
	other_dist_17 := IF(other_aacd_17 <> '', other_subscore17 - 0.007531, 0);
	
	other_aacd_18 := map(
	    NULL < rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 1 => 'C14',
	    1 <= rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 2   => 'C14',
	    2 <= rv_c14_addrs_per_adl_c6                                   => 'C14',
	                                                                      '');
	
	other_dist_18 := IF(other_aacd_18 <> '', other_subscore18 - 0.028178, 0);
	
	other_rcvaluea46 := (integer)(other_aacd_1 = 'A46') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A46') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A46') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A46') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A46') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A46') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A46') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A46') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A46') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A46') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A46') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A46') * other_dist_12 +
	    (integer)(other_aacd_13 = 'A46') * other_dist_13 +
	    (integer)(other_aacd_14 = 'A46') * other_dist_14 +
	    (integer)(other_aacd_15 = 'A46') * other_dist_15 +
	    (integer)(other_aacd_16 = 'A46') * other_dist_16 +
	    (integer)(other_aacd_17 = 'A46') * other_dist_17 +
	    (integer)(other_aacd_18 = 'A46') * other_dist_18;
	
	other_rcvaluec20 := (integer)(other_aacd_1 = 'C20') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C20') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C20') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C20') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C20') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C20') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C20') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C20') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C20') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C20') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C20') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C20') * other_dist_12 +
	    (integer)(other_aacd_13 = 'C20') * other_dist_13 +
	    (integer)(other_aacd_14 = 'C20') * other_dist_14 +
	    (integer)(other_aacd_15 = 'C20') * other_dist_15 +
	    (integer)(other_aacd_16 = 'C20') * other_dist_16 +
	    (integer)(other_aacd_17 = 'C20') * other_dist_17 +
	    (integer)(other_aacd_18 = 'C20') * other_dist_18;
	
	other_rcvaluec23 := (integer)(other_aacd_1 = 'C23') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C23') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C23') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C23') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C23') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C23') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C23') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C23') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C23') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C23') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C23') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C23') * other_dist_12 +
	    (integer)(other_aacd_13 = 'C23') * other_dist_13 +
	    (integer)(other_aacd_14 = 'C23') * other_dist_14 +
	    (integer)(other_aacd_15 = 'C23') * other_dist_15 +
	    (integer)(other_aacd_16 = 'C23') * other_dist_16 +
	    (integer)(other_aacd_17 = 'C23') * other_dist_17 +
	    (integer)(other_aacd_18 = 'C23') * other_dist_18;
	
	other_rcvaluel80 := (integer)(other_aacd_1 = 'L80') * other_dist_1 +
	    (integer)(other_aacd_2 = 'L80') * other_dist_2 +
	    (integer)(other_aacd_3 = 'L80') * other_dist_3 +
	    (integer)(other_aacd_4 = 'L80') * other_dist_4 +
	    (integer)(other_aacd_5 = 'L80') * other_dist_5 +
	    (integer)(other_aacd_6 = 'L80') * other_dist_6 +
	    (integer)(other_aacd_7 = 'L80') * other_dist_7 +
	    (integer)(other_aacd_8 = 'L80') * other_dist_8 +
	    (integer)(other_aacd_9 = 'L80') * other_dist_9 +
	    (integer)(other_aacd_10 = 'L80') * other_dist_10 +
	    (integer)(other_aacd_11 = 'L80') * other_dist_11 +
	    (integer)(other_aacd_12 = 'L80') * other_dist_12 +
	    (integer)(other_aacd_13 = 'L80') * other_dist_13 +
	    (integer)(other_aacd_14 = 'L80') * other_dist_14 +
	    (integer)(other_aacd_15 = 'L80') * other_dist_15 +
	    (integer)(other_aacd_16 = 'L80') * other_dist_16 +
	    (integer)(other_aacd_17 = 'L80') * other_dist_17 +
	    (integer)(other_aacd_18 = 'L80') * other_dist_18;
	
	other_rcvaluea41 := (integer)(other_aacd_1 = 'A41') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A41') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A41') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A41') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A41') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A41') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A41') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A41') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A41') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A41') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A41') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A41') * other_dist_12 +
	    (integer)(other_aacd_13 = 'A41') * other_dist_13 +
	    (integer)(other_aacd_14 = 'A41') * other_dist_14 +
	    (integer)(other_aacd_15 = 'A41') * other_dist_15 +
	    (integer)(other_aacd_16 = 'A41') * other_dist_16 +
	    (integer)(other_aacd_17 = 'A41') * other_dist_17 +
	    (integer)(other_aacd_18 = 'A41') * other_dist_18;
	
	other_rcvaluec13 := (integer)(other_aacd_1 = 'C13') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C13') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C13') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C13') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C13') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C13') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C13') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C13') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C13') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C13') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C13') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C13') * other_dist_12 +
	    (integer)(other_aacd_13 = 'C13') * other_dist_13 +
	    (integer)(other_aacd_14 = 'C13') * other_dist_14 +
	    (integer)(other_aacd_15 = 'C13') * other_dist_15 +
	    (integer)(other_aacd_16 = 'C13') * other_dist_16 +
	    (integer)(other_aacd_17 = 'C13') * other_dist_17 +
	    (integer)(other_aacd_18 = 'C13') * other_dist_18;
	
	other_rcvaluea51 := (integer)(other_aacd_1 = 'A51') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A51') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A51') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A51') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A51') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A51') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A51') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A51') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A51') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A51') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A51') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A51') * other_dist_12 +
	    (integer)(other_aacd_13 = 'A51') * other_dist_13 +
	    (integer)(other_aacd_14 = 'A51') * other_dist_14 +
	    (integer)(other_aacd_15 = 'A51') * other_dist_15 +
	    (integer)(other_aacd_16 = 'A51') * other_dist_16 +
	    (integer)(other_aacd_17 = 'A51') * other_dist_17 +
	    (integer)(other_aacd_18 = 'A51') * other_dist_18;
	
	other_rcvaluea50 := (integer)(other_aacd_1 = 'A50') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A50') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A50') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A50') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A50') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A50') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A50') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A50') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A50') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A50') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A50') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A50') * other_dist_12 +
	    (integer)(other_aacd_13 = 'A50') * other_dist_13 +
	    (integer)(other_aacd_14 = 'A50') * other_dist_14 +
	    (integer)(other_aacd_15 = 'A50') * other_dist_15 +
	    (integer)(other_aacd_16 = 'A50') * other_dist_16 +
	    (integer)(other_aacd_17 = 'A50') * other_dist_17 +
	    (integer)(other_aacd_18 = 'A50') * other_dist_18;
	
	other_rcvaluea44 := (integer)(other_aacd_1 = 'A44') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A44') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A44') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A44') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A44') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A44') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A44') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A44') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A44') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A44') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A44') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A44') * other_dist_12 +
	    (integer)(other_aacd_13 = 'A44') * other_dist_13 +
	    (integer)(other_aacd_14 = 'A44') * other_dist_14 +
	    (integer)(other_aacd_15 = 'A44') * other_dist_15 +
	    (integer)(other_aacd_16 = 'A44') * other_dist_16 +
	    (integer)(other_aacd_17 = 'A44') * other_dist_17 +
	    (integer)(other_aacd_18 = 'A44') * other_dist_18;
	
	other_rcvaluef01 := 
			(integer)(other_aacd_0 = 'F01') * other_dist_0 +
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
	    (integer)(other_aacd_11 = 'F01') * other_dist_11 +
	    (integer)(other_aacd_12 = 'F01') * other_dist_12 +
	    (integer)(other_aacd_13 = 'F01') * other_dist_13 +
	    (integer)(other_aacd_14 = 'F01') * other_dist_14 +
	    (integer)(other_aacd_15 = 'F01') * other_dist_15 +
	    (integer)(other_aacd_16 = 'F01') * other_dist_16 +
	    (integer)(other_aacd_17 = 'F01') * other_dist_17 +
	    (integer)(other_aacd_18 = 'F01') * other_dist_18;
	
	other_rcvaluep85 := (integer)(other_aacd_1 = 'P85') * other_dist_1 +
	    (integer)(other_aacd_2 = 'P85') * other_dist_2 +
	    (integer)(other_aacd_3 = 'P85') * other_dist_3 +
	    (integer)(other_aacd_4 = 'P85') * other_dist_4 +
	    (integer)(other_aacd_5 = 'P85') * other_dist_5 +
	    (integer)(other_aacd_6 = 'P85') * other_dist_6 +
	    (integer)(other_aacd_7 = 'P85') * other_dist_7 +
	    (integer)(other_aacd_8 = 'P85') * other_dist_8 +
	    (integer)(other_aacd_9 = 'P85') * other_dist_9 +
	    (integer)(other_aacd_10 = 'P85') * other_dist_10 +
	    (integer)(other_aacd_11 = 'P85') * other_dist_11 +
	    (integer)(other_aacd_12 = 'P85') * other_dist_12 +
	    (integer)(other_aacd_13 = 'P85') * other_dist_13 +
	    (integer)(other_aacd_14 = 'P85') * other_dist_14 +
	    (integer)(other_aacd_15 = 'P85') * other_dist_15 +
	    (integer)(other_aacd_16 = 'P85') * other_dist_16 +
	    (integer)(other_aacd_17 = 'P85') * other_dist_17 +
	    (integer)(other_aacd_18 = 'P85') * other_dist_18;
	
	other_rcvaluec12 := (integer)(other_aacd_1 = 'C12') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C12') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C12') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C12') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C12') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C12') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C12') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C12') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C12') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C12') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C12') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C12') * other_dist_12 +
	    (integer)(other_aacd_13 = 'C12') * other_dist_13 +
	    (integer)(other_aacd_14 = 'C12') * other_dist_14 +
	    (integer)(other_aacd_15 = 'C12') * other_dist_15 +
	    (integer)(other_aacd_16 = 'C12') * other_dist_16 +
	    (integer)(other_aacd_17 = 'C12') * other_dist_17 +
	    (integer)(other_aacd_18 = 'C12') * other_dist_18;
	
	other_rcvaluee55 := (integer)(other_aacd_1 = 'E55') * other_dist_1 +
	    (integer)(other_aacd_2 = 'E55') * other_dist_2 +
	    (integer)(other_aacd_3 = 'E55') * other_dist_3 +
	    (integer)(other_aacd_4 = 'E55') * other_dist_4 +
	    (integer)(other_aacd_5 = 'E55') * other_dist_5 +
	    (integer)(other_aacd_6 = 'E55') * other_dist_6 +
	    (integer)(other_aacd_7 = 'E55') * other_dist_7 +
	    (integer)(other_aacd_8 = 'E55') * other_dist_8 +
	    (integer)(other_aacd_9 = 'E55') * other_dist_9 +
	    (integer)(other_aacd_10 = 'E55') * other_dist_10 +
	    (integer)(other_aacd_11 = 'E55') * other_dist_11 +
	    (integer)(other_aacd_12 = 'E55') * other_dist_12 +
	    (integer)(other_aacd_13 = 'E55') * other_dist_13 +
	    (integer)(other_aacd_14 = 'E55') * other_dist_14 +
	    (integer)(other_aacd_15 = 'E55') * other_dist_15 +
	    (integer)(other_aacd_16 = 'E55') * other_dist_16 +
	    (integer)(other_aacd_17 = 'E55') * other_dist_17 +
	    (integer)(other_aacd_18 = 'E55') * other_dist_18;
	
	other_rcvaluei60 := (integer)(other_aacd_1 = 'I60') * other_dist_1 +
	    (integer)(other_aacd_2 = 'I60') * other_dist_2 +
	    (integer)(other_aacd_3 = 'I60') * other_dist_3 +
	    (integer)(other_aacd_4 = 'I60') * other_dist_4 +
	    (integer)(other_aacd_5 = 'I60') * other_dist_5 +
	    (integer)(other_aacd_6 = 'I60') * other_dist_6 +
	    (integer)(other_aacd_7 = 'I60') * other_dist_7 +
	    (integer)(other_aacd_8 = 'I60') * other_dist_8 +
	    (integer)(other_aacd_9 = 'I60') * other_dist_9 +
	    (integer)(other_aacd_10 = 'I60') * other_dist_10 +
	    (integer)(other_aacd_11 = 'I60') * other_dist_11 +
	    (integer)(other_aacd_12 = 'I60') * other_dist_12 +
	    (integer)(other_aacd_13 = 'I60') * other_dist_13 +
	    (integer)(other_aacd_14 = 'I60') * other_dist_14 +
	    (integer)(other_aacd_15 = 'I60') * other_dist_15 +
	    (integer)(other_aacd_16 = 'I60') * other_dist_16 +
	    (integer)(other_aacd_17 = 'I60') * other_dist_17 +
	    (integer)(other_aacd_18 = 'I60') * other_dist_18;
	
	other_rcvaluee57 := (integer)(other_aacd_1 = 'E57') * other_dist_1 +
	    (integer)(other_aacd_2 = 'E57') * other_dist_2 +
	    (integer)(other_aacd_3 = 'E57') * other_dist_3 +
	    (integer)(other_aacd_4 = 'E57') * other_dist_4 +
	    (integer)(other_aacd_5 = 'E57') * other_dist_5 +
	    (integer)(other_aacd_6 = 'E57') * other_dist_6 +
	    (integer)(other_aacd_7 = 'E57') * other_dist_7 +
	    (integer)(other_aacd_8 = 'E57') * other_dist_8 +
	    (integer)(other_aacd_9 = 'E57') * other_dist_9 +
	    (integer)(other_aacd_10 = 'E57') * other_dist_10 +
	    (integer)(other_aacd_11 = 'E57') * other_dist_11 +
	    (integer)(other_aacd_12 = 'E57') * other_dist_12 +
	    (integer)(other_aacd_13 = 'E57') * other_dist_13 +
	    (integer)(other_aacd_14 = 'E57') * other_dist_14 +
	    (integer)(other_aacd_15 = 'E57') * other_dist_15 +
	    (integer)(other_aacd_16 = 'E57') * other_dist_16 +
	    (integer)(other_aacd_17 = 'E57') * other_dist_17 +
	    (integer)(other_aacd_18 = 'E57') * other_dist_18;
	
	other_rcvalues66 := (integer)(other_aacd_1 = 'S66') * other_dist_1 +
	    (integer)(other_aacd_2 = 'S66') * other_dist_2 +
	    (integer)(other_aacd_3 = 'S66') * other_dist_3 +
	    (integer)(other_aacd_4 = 'S66') * other_dist_4 +
	    (integer)(other_aacd_5 = 'S66') * other_dist_5 +
	    (integer)(other_aacd_6 = 'S66') * other_dist_6 +
	    (integer)(other_aacd_7 = 'S66') * other_dist_7 +
	    (integer)(other_aacd_8 = 'S66') * other_dist_8 +
	    (integer)(other_aacd_9 = 'S66') * other_dist_9 +
	    (integer)(other_aacd_10 = 'S66') * other_dist_10 +
	    (integer)(other_aacd_11 = 'S66') * other_dist_11 +
	    (integer)(other_aacd_12 = 'S66') * other_dist_12 +
	    (integer)(other_aacd_13 = 'S66') * other_dist_13 +
	    (integer)(other_aacd_14 = 'S66') * other_dist_14 +
	    (integer)(other_aacd_15 = 'S66') * other_dist_15 +
	    (integer)(other_aacd_16 = 'S66') * other_dist_16 +
	    (integer)(other_aacd_17 = 'S66') * other_dist_17 +
	    (integer)(other_aacd_18 = 'S66') * other_dist_18;
	
	other_rcvaluec15 := (integer)(other_aacd_1 = 'C15') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C15') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C15') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C15') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C15') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C15') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C15') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C15') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C15') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C15') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C15') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C15') * other_dist_12 +
	    (integer)(other_aacd_13 = 'C15') * other_dist_13 +
	    (integer)(other_aacd_14 = 'C15') * other_dist_14 +
	    (integer)(other_aacd_15 = 'C15') * other_dist_15 +
	    (integer)(other_aacd_16 = 'C15') * other_dist_16 +
	    (integer)(other_aacd_17 = 'C15') * other_dist_17 +
	    (integer)(other_aacd_18 = 'C15') * other_dist_18;
	
	other_rcvaluec14 := (integer)(other_aacd_1 = 'C14') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C14') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C14') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C14') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C14') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C14') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C14') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C14') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C14') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C14') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C14') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C14') * other_dist_12 +
	    (integer)(other_aacd_13 = 'C14') * other_dist_13 +
	    (integer)(other_aacd_14 = 'C14') * other_dist_14 +
	    (integer)(other_aacd_15 = 'C14') * other_dist_15 +
	    (integer)(other_aacd_16 = 'C14') * other_dist_16 +
	    (integer)(other_aacd_17 = 'C14') * other_dist_17 +
	    (integer)(other_aacd_18 = 'C14') * other_dist_18;
	
	lnoddsscore := (integer)verprob_seg * verprob_lnoddsscore +
	    (integer)derog_seg * derog_lnoddsscore +
	    (integer)owner_seg * owner_lnoddsscore +
	    (integer)other_seg * other_lnoddsscore;
	
	score_lnodds := round(40 * (lnoddsscore - ln(20)) / ln(2) + 700);
	
	score_lnodds_capped := min(900, if(max(501, score_lnodds) = NULL, -NULL, max(501, score_lnodds)));
	
	ov_ssnprior := (INTEGER)rc_ssndobflag = 1 or (INTEGER)rc_pwssndobflag = 1;
	
	ov_corrections := rc_hrisksic = '2225';
	
	deceased := map(
	    (INTEGER)rc_decsflag = 1                                               => 1,
	    (INTEGER)rc_ssndod != 0                                                => 1,
	    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
	                                                                              0);
																																								
	//*************************************************************************************//
	//                     RiskView Version 5 - RVT1404_0_0 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Lex ID Only On Input = 222 (FLAGSHIP MODELS ONLY)
	// SSNPrior OR Corrections = 680
	// Score Range: 501 - 900
	//*************************************************************************************//
	rvt1404_0_0 := map(
	    deceased > 0                                                  => 200,
	    (INTEGER)iv_rv5_unscorable = 1                                => 222,
	    lexIDOnlyOnInput = TRUE                                       => 222,
	    score_lnodds_capped > 680 and (ov_ssnprior or ov_corrections) => 680,
	                                                                     score_lnodds_capped);
	




	//*************************************************************************************//
	//                        RiskView Version 5 Reason Code Logic
	//*************************************************************************************//
	_rc_seg_c210 := map(
	    add_ec1 = 'E' and not(rc_addrvalflag = 'N') or out_z5 = ''                                                                           	 => 'L70',
	    rc_hrisksic = '2225'                                                                                                                     => 'L73',
	    rc_hrisksic = '2225'                                                                                                                     => 'P87',
	    rc_hriskaddrflag = 2 or rc_ziptypeflag = 2 or (add_input_advo_res_or_bus in ['B', 'D']) or rc_hriskaddrflag = 4 or rc_addrcommflag = 2 => 'L71',
	                                                                                                                                              'L72');
	
	_rc_seg_c211 := map(
	    rc_hriskphoneflag = 2 or rc_hphonetypeflag IN ['2', 'A'] or (telcordia_type in ['02', '56', '61']) 									=> 'P86',
	    rc_phonevalflag = 0 OR rc_hphonevalflag = 0 OR rc_phonetype = 5 OR rc_hphonetypeflag = '5' OR rc_hriskphoneflag = 6	=> 'P85',
																																																														 '');
	
	_rc_seg_c209 := map(
	    sufficiently_verified = 0                          => 'F00',
	    adls_per_ssn >= 5 or ssns_per_adl >= 4             => 'S66',
	    invalid_ssns_per_adl >= 1                          => 'S65',
	    adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 => 'L79',
	    addr_validation_problem = 1                        => _rc_seg_c210,
	    Phn_validation_problem > 0                         => _rc_seg_c211,
																														'C12');
	
	_rc_seg_c212 := map(
	    felony_count > 0 or criminal_count > 0                                                                                                                                                                                         => 'D32',
	    stl_inq_count24 > 0                                                                                                                                                                                                            => 'C22',
	    attr_eviction_count > 0                                                                                                                                                                                                        => 'D33',
	    liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 => 'D34',
	                                                                                                                                                                                                                                      'D31');
	
	_rc_seg := map(
	    VerProb_seg => _rc_seg_c209,
	    Derog_seg   => _rc_seg_c212,
	    Other_seg   => 'A41',
	                   '');
		
	ds_layout := {STRING rc, REAL value};
	
	rc_dataset_owner := DATASET([
	    {'A46', owner_rcvalueA46},
	    {'F01', owner_rcvalueF01},
	    {'L79', owner_rcvalueL79},
	    {'C23', owner_rcvalueC23},
	    {'L80', owner_rcvalueL80},
	    {'C20', owner_rcvalueC20},
	    {'D30', owner_rcvalueD30},
	    {'A51', owner_rcvalueA51},
	    {'A50', owner_rcvalueA50},
	    {'I60', owner_rcvalueI60},
	    {'A41', owner_rcvalueA41},
	    {'E55', owner_rcvalueE55},
	    {'C12', owner_rcvalueC12},
	    {'S66', owner_rcvalueS66},
	    {'C15', owner_rcvalueC15},
	    {'C14', owner_rcvalueC14}
	    ], ds_layout) (value < 0); // Reason codes are being calculated with negative values in this model
	
	rc_dataset_owner_sorted := sort(rc_dataset_owner, rc_dataset_owner.value);
	
	owner_rc1 := rc_dataset_owner_sorted[1].rc;
	owner_rc2 := rc_dataset_owner_sorted[2].rc;
	owner_rc3 := rc_dataset_owner_sorted[3].rc;
	owner_rc4 := rc_dataset_owner_sorted[4].rc;
	
	rc_dataset_other := DATASET([
	    {'A46', other_rcvalueA46},
	    {'C20', other_rcvalueC20},
	    {'C23', other_rcvalueC23},
	    {'L80', other_rcvalueL80},
	    {'A41', other_rcvalueA41},
	    {'C13', other_rcvalueC13},
	    {'A51', other_rcvalueA51},
	    {'A50', other_rcvalueA50},
	    {'A44', other_rcvalueA44},
	    {'F01', other_rcvalueF01},
	    {'P85', other_rcvalueP85},
	    {'C12', other_rcvalueC12},
	    {'E55', other_rcvalueE55},
	    {'I60', other_rcvalueI60},
	    {'E57', other_rcvalueE57},
	    {'S66', other_rcvalueS66},
	    {'C15', other_rcvalueC15},
	    {'C14', other_rcvalueC14}
	    ], ds_layout) (value < 0);
	
	rc_dataset_other_sorted := sort(rc_dataset_other, rc_dataset_other.value);
	
	other_rc1 := rc_dataset_other_sorted[1].rc;
	other_rc2 := rc_dataset_other_sorted[2].rc;
	other_rc3 := rc_dataset_other_sorted[3].rc;
	other_rc4 := rc_dataset_other_sorted[4].rc;
	
	rc_dataset_verprob := DATASET([
	    {'L79', verprob_rcvalueL79},
	    {'D34', verprob_rcvalueD34},
	    {'D32', verprob_rcvalueD32},
	    {'D33', verprob_rcvalueD33},
	    {'D30', verprob_rcvalueD30},
	    {'A51', verprob_rcvalueA51},
	    {'A50', verprob_rcvalueA50},
	    {'F01', verprob_rcvalueF01},
	    {'F00', verprob_rcvalueF00},
	    {'E55', verprob_rcvalueE55},
	    {'C12', verprob_rcvalueC12},
	    {'C15', verprob_rcvalueC15},
	    {'L80', verprob_rcvalueL80},
	    {'C22', verprob_rcvalueC22},
	    {'C23', verprob_rcvalueC23},
	    {'C20', verprob_rcvalueC20},
	    {'A46', verprob_rcvalueA46},
	    {'C13', verprob_rcvalueC13},
	    {'A41', verprob_rcvalueA41},
	    {'S66', verprob_rcvalueS66},
	    {'P85', verprob_rcvalueP85},
	    {'I60', verprob_rcvalueI60}
	    ], ds_layout) (value < 0);
	
	rc_dataset_verprob_sorted := sort(rc_dataset_verprob, rc_dataset_verprob.value);
	
	verprob_rc1 := rc_dataset_verprob_sorted[1].rc;
	verprob_rc2 := rc_dataset_verprob_sorted[2].rc;
	verprob_rc3 := rc_dataset_verprob_sorted[3].rc;
	verprob_rc4 := rc_dataset_verprob_sorted[4].rc;
	
	rc_dataset_derog := DATASET([
	    {'C22', derog_rcvalueC22},
	    {'C23', derog_rcvalueC23},
	    {'C20', derog_rcvalueC20},
	    {'L79', derog_rcvalueL79},
	    {'L80', derog_rcvalueL80},
	    {'I60', derog_rcvalueI60},
	    {'D34', derog_rcvalueD34},
	    {'D32', derog_rcvalueD32},
	    {'D33', derog_rcvalueD33},
	    {'C13', derog_rcvalueC13},
	    {'A51', derog_rcvalueA51},
	    {'A50', derog_rcvalueA50},
	    {'S66', derog_rcvalueS66},
	    {'F01', derog_rcvalueF01},
	    {'A41', derog_rcvalueA41},
	    {'E55', derog_rcvalueE55},
	    {'C12', derog_rcvalueC12},
	    {'E57', derog_rcvalueE57},
	    {'A46', derog_rcvalueA46},
	    {'C15', derog_rcvalueC15},
	    {'C14', derog_rcvalueC14}
	    ], ds_layout) (value < 0);
	
	rc_dataset_derog_sorted := sort(rc_dataset_derog, rc_dataset_derog.value);
	
	derog_rc1 := rc_dataset_derog_sorted[1].rc;
	derog_rc2 := rc_dataset_derog_sorted[2].rc;
	derog_rc3 := rc_dataset_derog_sorted[3].rc;
	derog_rc4 := rc_dataset_derog_sorted[4].rc;
	
	rc1_c214 := map(
	    verprob_seg => verprob_rc1,
	    derog_seg   => derog_rc1,
	    owner_seg   => owner_rc1,
	    other_seg   => other_rc1,
	                   _rc_seg);
	
	rc2_c215 := map(
	    VerProb_seg => verprob_rc2,
	    Derog_seg   => derog_rc2,
	    Owner_seg   => owner_rc2,
	                   other_rc2);
	
	rc3_c216 := map(
	    VerProb_seg => verprob_rc3,
	    Derog_seg   => derog_rc3,
	    Owner_seg   => owner_rc3,
	                   other_rc3);
	
	rc4_c217 := map(
	    VerProb_seg => verprob_rc4,
	    Derog_seg   => derog_rc4,
	    Owner_seg   => owner_rc4,
	                   other_rc4);
	
	rc1 := rc1_c214;
	
	rc4 := rc4_c217;
	
	rc2 := rc2_c215;
	
	rc3 := rc3_c216;
	
	_rc_inq := map(
	    verprob_seg and rv_i60_inq_count12 > 0          => 'I60',
	    derog_seg and rv_i60_inq_hiriskcred_count12 > 0 => 'I60',
	    owner_seg and iv_i60_inq_ssns_per_adl > 0       => 'I60',
	    other_seg and iv_i60_inq_ssns_per_adl > 0       => 'I60',
	                                                       '');
	
	rc5 := if(rc1 != 'I60' and rc2 != 'I60' and rc3 != 'I60' and rc4 != 'I60', _rc_inq, '');
	//*************************************************************************************//
	//                       End RiskView Version 5 Reason Code Logic
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
													RVT1404_0_0 = 200 => DATASET([{'00'}], HRILayout),
													RVT1404_0_0 = 222 => DATASET([{'00'}], HRILayout),
													RVT1404_0_0 = 900 => DATASET([{'00'}], HRILayout),
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
		SELF.truedid := truedid;
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
		SELF.combo_dobscore := combo_dobscore;
		SELF.hdr_source_profile := hdr_source_profile;
		SELF.hdr_source_profile_index := hdr_source_profile_index;
		SELF.ver_sources := ver_sources;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_isbestmatch := add_input_isbestmatch;
		SELF.add_input_lres := add_input_lres;
		SELF.add_input_occ_index := add_input_occ_index;
		SELF.add_input_advo_vacancy := add_input_advo_vacancy;
		SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
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
		SELF.addrs_per_adl_c6 := addrs_per_adl_c6;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.inq_count12 := inq_count12;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_ssnsperadl := inq_ssnsperadl;
		SELF.pb_average_dollars := pb_average_dollars;
		SELF.br_source_count := br_source_count;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count90 := stl_inq_count90;
		SELF.stl_inq_count180 := stl_inq_count180;
		SELF.stl_inq_count12 := stl_inq_count12;
		SELF.stl_inq_count24 := stl_inq_count24;
		SELF.email_count := email_count;
		SELF.email_domain_free_count := email_domain_free_count;
		SELF.attr_addrs_last30 := attr_addrs_last30;
		SELF.attr_addrs_last90 := attr_addrs_last90;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_num_unrel_liens30 := attr_num_unrel_liens30;
		SELF.attr_num_unrel_liens90 := attr_num_unrel_liens90;
		SELF.attr_num_unrel_liens180 := attr_num_unrel_liens180;
		SELF.attr_num_unrel_liens12 := attr_num_unrel_liens12;
		SELF.attr_num_unrel_liens24 := attr_num_unrel_liens24;
		SELF.attr_num_unrel_liens36 := attr_num_unrel_liens36;
		SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
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
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rv_c12_source_profile := IF(rv_c12_source_profile <> NULL, (rv_c12_source_profile / 10), NULL);
		SELF.rv_c12_source_profile_index := rv_c12_source_profile_index;
		SELF.rv_p85_phn_disconnected := rv_p85_phn_disconnected;
		SELF.rv_d30_derog_count := rv_d30_derog_count;
		SELF.rv_d32_criminal_x_felony := rv_d32_criminal_x_felony;
		SELF.rv_c22_stl_recency := rv_c22_stl_recency;
		SELF.rv_d33_eviction_count := rv_d33_eviction_count;
		SELF.iv_d34_liens_unrel_x_rel := iv_d34_liens_unrel_x_rel;
		SELF.rv_c15_ssns_per_adl := rv_c15_ssns_per_adl;
		SELF.rv_s66_adlperssn_count := rv_s66_adlperssn_count;
		SELF.rv_l80_inp_avm_autoval := rv_l80_inp_avm_autoval;
		SELF.rv_a46_curr_avm_autoval := rv_a46_curr_avm_autoval;
		SELF.rv_c23_inp_addr_occ_index := rv_c23_inp_addr_occ_index;
		SELF.rv_a41_prop_owner := rv_a41_prop_owner;
		SELF.rv_a41_prop_owner_inp_only := rv_a41_prop_owner_inp_only;
		SELF.rv_c20_email_domain_free_count := rv_c20_email_domain_free_count;
		SELF.rv_e55_college_ind := rv_e55_college_ind;
		SELF.rv_i60_inq_count12 := rv_i60_inq_count12;
		SELF.rv_i60_inq_hiriskcred_count12 := rv_i60_inq_hiriskcred_count12;
		SELF.rv_l79_adls_per_addr_c6 := rv_l79_adls_per_addr_c6;
		SELF.rv_a50_pb_average_dollars := rv_a50_pb_average_dollars;
		SELF.iv_f00_dob_score := iv_f00_dob_score;
		SELF.iv_f01_inp_addr_address_score := iv_f01_inp_addr_address_score;
		SELF.iv_c13_inp_addr_lres := iv_c13_inp_addr_lres;
		SELF.rv_c22_stl_inq_count24 := rv_c22_stl_inq_count24;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_c14_addrs_5yr := rv_c14_addrs_5yr;
		SELF.rv_e57_br_flag := rv_e57_br_flag;
		SELF.rv_c13_attr_addrs_recency := rv_c13_attr_addrs_recency;
		SELF.rv_d34_attr_unrel_liens_recency := rv_d34_attr_unrel_liens_recency;
		SELF.rv_c12_nonderog_recency := rv_c12_nonderog_recency;
		SELF.rv_a44_curr_add_naprop := rv_a44_curr_add_naprop;
		SELF.rv_c14_addrs_per_adl_c6 := rv_c14_addrs_per_adl_c6;
		SELF.rv_e57_prof_license_flag := rv_e57_prof_license_flag;
		SELF.iv_i60_inq_ssns_per_adl := iv_i60_inq_ssns_per_adl;
		SELF.rv_c20_email_count := rv_c20_email_count;
		SELF.rv_l79_adls_per_addr_curr := rv_l79_adls_per_addr_curr;
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
		SELF.verprob_subscore12 := verprob_subscore12;
		SELF.verprob_subscore13 := verprob_subscore13;
		SELF.verprob_subscore14 := verprob_subscore14;
		SELF.verprob_subscore15 := verprob_subscore15;
		SELF.verprob_subscore16 := verprob_subscore16;
		SELF.verprob_subscore17 := verprob_subscore17;
		SELF.verprob_subscore18 := verprob_subscore18;
		SELF.verprob_subscore19 := verprob_subscore19;
		SELF.verprob_subscore20 := verprob_subscore20;
		SELF.verprob_subscore21 := verprob_subscore21;
		SELF.verprob_rawscore := verprob_rawscore;
		SELF.verprob_lnoddsscore := verprob_lnoddsscore;
		SELF.verprob_probscore := verprob_probscore;
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
		SELF.verprob_aacd_12 := verprob_aacd_12;
		SELF.verprob_dist_12 := verprob_dist_12;
		SELF.verprob_aacd_13 := verprob_aacd_13;
		SELF.verprob_dist_13 := verprob_dist_13;
		SELF.verprob_aacd_14 := verprob_aacd_14;
		SELF.verprob_dist_14 := verprob_dist_14;
		SELF.verprob_aacd_15 := verprob_aacd_15;
		SELF.verprob_dist_15 := verprob_dist_15;
		SELF.verprob_aacd_16 := verprob_aacd_16;
		SELF.verprob_dist_16 := verprob_dist_16;
		SELF.verprob_aacd_17 := verprob_aacd_17;
		SELF.verprob_dist_17 := verprob_dist_17;
		SELF.verprob_aacd_18 := verprob_aacd_18;
		SELF.verprob_dist_18 := verprob_dist_18;
		SELF.verprob_aacd_19 := verprob_aacd_19;
		SELF.verprob_dist_19 := verprob_dist_19;
		SELF.verprob_aacd_20 := verprob_aacd_20;
		SELF.verprob_dist_20 := verprob_dist_20;
		SELF.verprob_aacd_21 := verprob_aacd_21;
		SELF.verprob_dist_21 := verprob_dist_21;
		SELF.verprob_rcvaluel79 := verprob_rcvaluel79;
		SELF.verprob_rcvalued34 := verprob_rcvalued34;
		SELF.verprob_rcvalued32 := verprob_rcvalued32;
		SELF.verprob_rcvalued33 := verprob_rcvalued33;
		SELF.verprob_rcvalued30 := verprob_rcvalued30;
		SELF.verprob_rcvaluea51 := verprob_rcvaluea51;
		SELF.verprob_rcvaluea50 := verprob_rcvaluea50;
		SELF.verprob_rcvaluef01 := verprob_rcvaluef01;
		SELF.verprob_rcvaluef00 := verprob_rcvaluef00;
		SELF.verprob_rcvaluee55 := verprob_rcvaluee55;
		SELF.verprob_rcvaluec12 := verprob_rcvaluec12;
		SELF.verprob_rcvaluec15 := verprob_rcvaluec15;
		SELF.verprob_rcvaluel80 := verprob_rcvaluel80;
		SELF.verprob_rcvaluec22 := verprob_rcvaluec22;
		SELF.verprob_rcvaluec23 := verprob_rcvaluec23;
		SELF.verprob_rcvaluec20 := verprob_rcvaluec20;
		SELF.verprob_rcvaluea46 := verprob_rcvaluea46;
		SELF.verprob_rcvaluec13 := verprob_rcvaluec13;
		SELF.verprob_rcvaluea41 := verprob_rcvaluea41;
		SELF.verprob_rcvalues66 := verprob_rcvalues66;
		SELF.verprob_rcvaluep85 := verprob_rcvaluep85;
		SELF.verprob_rcvaluei60 := verprob_rcvaluei60;
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
		SELF.derog_subscore12 := derog_subscore12;
		SELF.derog_subscore13 := derog_subscore13;
		SELF.derog_subscore14 := derog_subscore14;
		SELF.derog_subscore15 := derog_subscore15;
		SELF.derog_subscore16 := derog_subscore16;
		SELF.derog_subscore17 := derog_subscore17;
		SELF.derog_subscore18 := derog_subscore18;
		SELF.derog_subscore19 := derog_subscore19;
		SELF.derog_subscore20 := derog_subscore20;
		SELF.derog_subscore21 := derog_subscore21;
		SELF.derog_rawscore := derog_rawscore;
		SELF.derog_lnoddsscore := derog_lnoddsscore;
		SELF.derog_probscore := derog_probscore;
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
		SELF.derog_aacd_12 := derog_aacd_12;
		SELF.derog_dist_12 := derog_dist_12;
		SELF.derog_aacd_13 := derog_aacd_13;
		SELF.derog_dist_13 := derog_dist_13;
		SELF.derog_aacd_14 := derog_aacd_14;
		SELF.derog_dist_14 := derog_dist_14;
		SELF.derog_aacd_15 := derog_aacd_15;
		SELF.derog_dist_15 := derog_dist_15;
		SELF.derog_aacd_16 := derog_aacd_16;
		SELF.derog_dist_16 := derog_dist_16;
		SELF.derog_aacd_17 := derog_aacd_17;
		SELF.derog_dist_17 := derog_dist_17;
		SELF.derog_aacd_18 := derog_aacd_18;
		SELF.derog_dist_18 := derog_dist_18;
		SELF.derog_aacd_19 := derog_aacd_19;
		SELF.derog_dist_19 := derog_dist_19;
		SELF.derog_aacd_20 := derog_aacd_20;
		SELF.derog_dist_20 := derog_dist_20;
		SELF.derog_aacd_21 := derog_aacd_21;
		SELF.derog_dist_21 := derog_dist_21;
		SELF.derog_rcvaluec22 := derog_rcvaluec22;
		SELF.derog_rcvaluec23 := derog_rcvaluec23;
		SELF.derog_rcvaluec20 := derog_rcvaluec20;
		SELF.derog_rcvaluel79 := derog_rcvaluel79;
		SELF.derog_rcvaluel80 := derog_rcvaluel80;
		SELF.derog_rcvaluei60 := derog_rcvaluei60;
		SELF.derog_rcvalued34 := derog_rcvalued34;
		SELF.derog_rcvalued32 := derog_rcvalued32;
		SELF.derog_rcvalued33 := derog_rcvalued33;
		SELF.derog_rcvaluec13 := derog_rcvaluec13;
		SELF.derog_rcvaluea51 := derog_rcvaluea51;
		SELF.derog_rcvaluea50 := derog_rcvaluea50;
		SELF.derog_rcvalues66 := derog_rcvalues66;
		SELF.derog_rcvaluef01 := derog_rcvaluef01;
		SELF.derog_rcvaluea41 := derog_rcvaluea41;
		SELF.derog_rcvaluee55 := derog_rcvaluee55;
		SELF.derog_rcvaluec12 := derog_rcvaluec12;
		SELF.derog_rcvaluee57 := derog_rcvaluee57;
		SELF.derog_rcvaluea46 := derog_rcvaluea46;
		SELF.derog_rcvaluec15 := derog_rcvaluec15;
		SELF.derog_rcvaluec14 := derog_rcvaluec14;
		SELF.owner_subscore0 := owner_subscore0;
		SELF.owner_subscore1 := owner_subscore1;
		SELF.owner_subscore2 := owner_subscore2;
		SELF.owner_subscore3 := owner_subscore3;
		SELF.owner_subscore4 := owner_subscore4;
		SELF.owner_subscore5 := owner_subscore5;
		SELF.owner_subscore6 := owner_subscore6;
		SELF.owner_subscore7 := owner_subscore7;
		SELF.owner_subscore8 := owner_subscore8;
		SELF.owner_subscore9 := owner_subscore9;
		SELF.owner_subscore10 := owner_subscore10;
		SELF.owner_subscore11 := owner_subscore11;
		SELF.owner_subscore12 := owner_subscore12;
		SELF.owner_subscore13 := owner_subscore13;
		SELF.owner_subscore14 := owner_subscore14;
		SELF.owner_rawscore := owner_rawscore;
		SELF.owner_lnoddsscore := owner_lnoddsscore;
		SELF.owner_probscore := owner_probscore;
		SELF.owner_dist_0 := owner_dist_0;
		SELF.owner_aacd_1 := owner_aacd_1;
		SELF.owner_dist_1 := owner_dist_1;
		SELF.owner_aacd_2 := owner_aacd_2;
		SELF.owner_dist_2 := owner_dist_2;
		SELF.owner_aacd_3 := owner_aacd_3;
		SELF.owner_dist_3 := owner_dist_3;
		SELF.owner_aacd_4 := owner_aacd_4;
		SELF.owner_dist_4 := owner_dist_4;
		SELF.owner_aacd_5 := owner_aacd_5;
		SELF.owner_dist_5 := owner_dist_5;
		SELF.owner_aacd_6 := owner_aacd_6;
		SELF.owner_dist_6 := owner_dist_6;
		SELF.owner_aacd_7 := owner_aacd_7;
		SELF.owner_dist_7 := owner_dist_7;
		SELF.owner_aacd_8 := owner_aacd_8;
		SELF.owner_dist_8 := owner_dist_8;
		SELF.owner_aacd_9 := owner_aacd_9;
		SELF.owner_dist_9 := owner_dist_9;
		SELF.owner_aacd_10 := owner_aacd_10;
		SELF.owner_dist_10 := owner_dist_10;
		SELF.owner_aacd_11 := owner_aacd_11;
		SELF.owner_dist_11 := owner_dist_11;
		SELF.owner_aacd_12 := owner_aacd_12;
		SELF.owner_dist_12 := owner_dist_12;
		SELF.owner_aacd_13 := owner_aacd_13;
		SELF.owner_dist_13 := owner_dist_13;
		SELF.owner_aacd_14 := owner_aacd_14;
		SELF.owner_dist_14 := owner_dist_14;
		SELF.owner_rcvaluea46 := owner_rcvaluea46;
		SELF.owner_rcvaluef01 := owner_rcvaluef01;
		SELF.owner_rcvaluel79 := owner_rcvaluel79;
		SELF.owner_rcvaluec23 := owner_rcvaluec23;
		SELF.owner_rcvaluel80 := owner_rcvaluel80;
		SELF.owner_rcvaluec20 := owner_rcvaluec20;
		SELF.owner_rcvalued30 := owner_rcvalued30;
		SELF.owner_rcvaluea51 := owner_rcvaluea51;
		SELF.owner_rcvaluea50 := owner_rcvaluea50;
		SELF.owner_rcvaluei60 := owner_rcvaluei60;
		SELF.owner_rcvaluea41 := owner_rcvaluea41;
		SELF.owner_rcvaluee55 := owner_rcvaluee55;
		SELF.owner_rcvaluec12 := owner_rcvaluec12;
		SELF.owner_rcvalues66 := owner_rcvalues66;
		SELF.owner_rcvaluec15 := owner_rcvaluec15;
		SELF.owner_rcvaluec14 := owner_rcvaluec14;
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
		SELF.other_subscore11 := other_subscore11;
		SELF.other_subscore12 := other_subscore12;
		SELF.other_subscore13 := other_subscore13;
		SELF.other_subscore14 := other_subscore14;
		SELF.other_subscore15 := other_subscore15;
		SELF.other_subscore16 := other_subscore16;
		SELF.other_subscore17 := other_subscore17;
		SELF.other_subscore18 := other_subscore18;
		SELF.other_rawscore := other_rawscore;
		SELF.other_lnoddsscore := other_lnoddsscore;
		SELF.other_probscore := other_probscore;
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
		SELF.other_aacd_11 := other_aacd_11;
		SELF.other_dist_11 := other_dist_11;
		SELF.other_aacd_12 := other_aacd_12;
		SELF.other_dist_12 := other_dist_12;
		SELF.other_aacd_13 := other_aacd_13;
		SELF.other_dist_13 := other_dist_13;
		SELF.other_aacd_14 := other_aacd_14;
		SELF.other_dist_14 := other_dist_14;
		SELF.other_aacd_15 := other_aacd_15;
		SELF.other_dist_15 := other_dist_15;
		SELF.other_aacd_16 := other_aacd_16;
		SELF.other_dist_16 := other_dist_16;
		SELF.other_aacd_17 := other_aacd_17;
		SELF.other_dist_17 := other_dist_17;
		SELF.other_aacd_18 := other_aacd_18;
		SELF.other_dist_18 := other_dist_18;
		SELF.other_rcvaluea46 := other_rcvaluea46;
		SELF.other_rcvaluec20 := other_rcvaluec20;
		SELF.other_rcvaluec23 := other_rcvaluec23;
		SELF.other_rcvaluel80 := other_rcvaluel80;
		SELF.other_rcvaluea41 := other_rcvaluea41;
		SELF.other_rcvaluec13 := other_rcvaluec13;
		SELF.other_rcvaluea51 := other_rcvaluea51;
		SELF.other_rcvaluea50 := other_rcvaluea50;
		SELF.other_rcvaluea44 := other_rcvaluea44;
		SELF.other_rcvaluef01 := other_rcvaluef01;
		SELF.other_rcvaluep85 := other_rcvaluep85;
		SELF.other_rcvaluec12 := other_rcvaluec12;
		SELF.other_rcvaluee55 := other_rcvaluee55;
		SELF.other_rcvaluei60 := other_rcvaluei60;
		SELF.other_rcvaluee57 := other_rcvaluee57;
		SELF.other_rcvalues66 := other_rcvalues66;
		SELF.other_rcvaluec15 := other_rcvaluec15;
		SELF.other_rcvaluec14 := other_rcvaluec14;
		SELF.lnoddsscore := lnoddsscore;
		SELF.score_lnodds := score_lnodds;
		SELF.score_lnodds_capped := score_lnodds_capped;
		SELF.ov_ssnprior := ov_ssnprior;
		SELF.ov_corrections := ov_corrections;
		SELF.deceased := deceased;
		SELF.rvt1404_0_0 := rvt1404_0_0;
		SELF._rc_seg_c210 := _rc_seg_c210;
		SELF._rc_seg_c211 := _rc_seg_c211;
		SELF._rc_seg_c209 := _rc_seg_c209;
		SELF._rc_seg_c212 := _rc_seg_c212;
		SELF._rc_seg := _rc_seg;
		SELF.owner_rc1 := owner_rc1;
		SELF.owner_rc2 := owner_rc2;
		SELF.owner_rc3 := owner_rc3;
		SELF.owner_rc4 := owner_rc4;
		SELF.other_rc1 := other_rc1;
		SELF.other_rc2 := other_rc2;
		SELF.other_rc3 := other_rc3;
		SELF.other_rc4 := other_rc4;
		SELF.verprob_rc1 := verprob_rc1;
		SELF.verprob_rc2 := verprob_rc2;
		SELF.verprob_rc3 := verprob_rc3;
		SELF.verprob_rc4 := verprob_rc4;
		SELF.derog_rc1 := derog_rc1;
		SELF.derog_rc2 := derog_rc2;
		SELF.derog_rc3 := derog_rc3;
		SELF.derog_rc4 := derog_rc4;
		SELF.rc1_c214 := rc1_c214;
		SELF.rc2_c215 := rc2_c215;
		SELF.rc3_c216 := rc3_c216;
		SELF.rc4_c217 := rc4_c217;
		SELF._rc_inq := _rc_inq;

		SELF.rc1 := reasonCodes[1].hri;
		SELF.rc2 := reasonCodes[2].hri;
		SELF.rc3 := reasonCodes[3].hri;
		SELF.rc4 := reasonCodes[4].hri;
		SELF.rc5 := reasonCodes[5].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvt1404_0_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
