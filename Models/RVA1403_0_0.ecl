IMPORT Models, UT, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT RVA1403_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			UNSIGNED4 seq;
			DECIMAL4_1 source_profile;
			BOOLEAN truedid;
			STRING out_unit_desig;
			STRING out_sec_range;
			STRING out_z5;
			STRING out_addr_type;
			STRING out_addr_status;
			INTEGER nas_summary;
			INTEGER nap_summary;
			INTEGER rc_ssndod;
			BOOLEAN rc_input_addr_not_most_recent;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING rc_pwphonezipflag;
			INTEGER rc_hriskaddrflag;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_addrvalflag;
			STRING rc_dwelltype;
			STRING rc_addrcommflag;
			STRING rc_hrisksic;
			STRING rc_hrisksicphone;
			STRING rc_phonetype;
			STRING rc_ziptypeflag;
			STRING ver_sources;
			STRING ver_sources_first_seen;
			BOOLEAN addrpop;
			INTEGER ssnlength;
			BOOLEAN dobpop;
			INTEGER hphnpop;
			INTEGER add_input_address_score;
			INTEGER add_input_isbestmatch;
			INTEGER add_input_lres;
			STRING add_input_advo_vacancy;
			STRING add_input_advo_res_or_bus;
			INTEGER add_input_avm_auto_val;
			INTEGER add_input_naprop;
			BOOLEAN add_input_pop;
			INTEGER property_owned_total;
			INTEGER add_curr_isbestmatch;
			INTEGER add_curr_lres;
			INTEGER add_curr_avm_auto_val;
			INTEGER add_curr_naprop;
			BOOLEAN add_curr_pop;
			INTEGER add_prev_lres;
			INTEGER add_prev_naprop;
			BOOLEAN add_prev_pop;
			INTEGER avg_lres;
			INTEGER max_lres;
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
			INTEGER addrs_per_adl_c6;
			INTEGER adls_per_addr_c6;
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
			INTEGER inq_highriskcredit_count12;
			INTEGER inq_mortgage_count03;
			INTEGER inq_retail_count03;
			INTEGER inq_phonesperadl;
			STRING pb_average_dollars;
			STRING pb_total_dollars;
			STRING pb_total_orders;
			INTEGER br_first_seen;
			INTEGER br_source_count;
			INTEGER infutor_nap;
			INTEGER stl_inq_count90;
			INTEGER stl_inq_count180;
			INTEGER stl_inq_count12;
			INTEGER stl_inq_count24;
			INTEGER email_domain_free_count;
			INTEGER attr_addrs_last30;
			INTEGER attr_addrs_last90;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_num_aircraft;
			INTEGER attr_eviction_count;
			INTEGER attr_eviction_count90;
			INTEGER attr_eviction_count180;
			INTEGER attr_eviction_count12;
			INTEGER attr_eviction_count24;
			INTEGER attr_eviction_count36;
			INTEGER attr_eviction_count60;
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
			BOOLEAN prof_license_flag;
			INTEGER input_dob_match_level;

			/* Model Intermediate Variables */
			BOOLEAN iv_add_apt;
			INTEGER nas_summary_ver2;
			INTEGER nap_summary_ver;
			INTEGER infutor_nap_ver;
			INTEGER dobver;
			INTEGER sufficiently_verified;
			BOOLEAN adls_per_ssn_ge5;
			BOOLEAN ssns_per_adl_ge4;
			BOOLEAN invalid_ssns_per_adl_ge1;
			BOOLEAN adls_per_addr_curr_ge8;
			BOOLEAN ssns_per_addr_curr_ge7;
			BOOLEAN hrisksic_addr;
			BOOLEAN hrisksic_phn;
			STRING add_ec1;
			INTEGER addr_validation_problem;
			INTEGER phn_validation_problem;
			REAL validation_problem;
			INTEGER lj_landlordtenant_ct;
			INTEGER lj_smallclaims_ct;
			INTEGER lj_court_ct;
			INTEGER lj_tax_ct;
			INTEGER lj_foreclosure_ct;
			INTEGER lj_other_ct;
			INTEGER lj_total_ct;
			INTEGER lj_no_type_ct;
			BOOLEAN lj_flag;
			INTEGER derog_severity;
			STRING seg_ver_derog_owner;
			BOOLEAN vervalprob_seg;
			BOOLEAN derog_seg;
			BOOLEAN owner_seg;
			BOOLEAN other_seg;
			INTEGER _br_first_seen;
			INTEGER iv_mos_since_br_first_seen;
			INTEGER iv_br_source_count;
			INTEGER bureau_adl_eq_fseen_pos;
			STRING bureau_adl_fseen_eq;
			INTEGER _bureau_adl_fseen_eq;
			INTEGER _src_bureau_adl_fseen;
			INTEGER rv_c21_m_bureau_adl_fs;
			INTEGER rv_a42_prop_owner;
			INTEGER _criminal_last_date;
			INTEGER rv_d32_mos_since_crim_ls;
			INTEGER rv_d33_eviction_recency;
			INTEGER rv_c22_stl_inq_count12;
			INTEGER rv_c22_stl_inq_count24;
			STRING rv_c22_stl_recency;
			INTEGER rv_s66_adlperssn_count;
			INTEGER rv_c14_addrs_per_adl_c6;
			INTEGER rv_a42_prop_owner_inp_only;
			STRING rv_e55_college_ind_shell5;
			STRING iv_f07_input_add_not_most_rec;
			STRING iv_l77_dwelltype;
			INTEGER iv_c13_inp_addr_lres;
			INTEGER iv_c14_addrs_10yr;
			INTEGER iv_i60_credit_seeking;
			INTEGER iv_i60_inq_auto_recency;
			STRING iv_a43_rec_vehx_level;
			INTEGER iv_d33_eviction_count_1;
			INTEGER iv_d34_unrel_liens_ct;
			STRING iv_d34_liens_unrel_x_rel;
			STRING iv_d32_criminal_x_felony;
			STRING iv_e57_prof_license_flag;
			INTEGER iv_a50_pb_total_dollars;
			STRING rv_p85_phn_not_issued;
			INTEGER _header_first_seen;
			INTEGER rv_c10_m_hdr_fs;
			DECIMAL4_1 rv_c12_source_profile;
			INTEGER rv_a47_inp_avm_autoval;
			INTEGER iv_f02_inp_addr_address_score;
			INTEGER iv_c13_prv_addr_lres;
			INTEGER iv_i60_inq_recency;
			INTEGER iv_d33_eviction_count;
			INTEGER rv_c15_ssns_per_adl;
			INTEGER rv_c13_curr_addr_lres;
			INTEGER rv_i60_inq_count12;
			INTEGER iv_f07_address_match_1;
			STRING iv_f07_address_match;
			INTEGER iv_c13_avg_lres;
			INTEGER iv_c14_addrs_5yr;
			INTEGER iv_l79_adls_per_addr_c6;
			INTEGER iv_i60_inq_hiriskcred_count12;
			INTEGER iv_i60_inq_phones_per_adl;
			INTEGER iv_c20_email_domain_free_count;
			INTEGER iv_c13_attr_addrs_recency;
			INTEGER iv_a50_pb_average_dollars;
			INTEGER iv_a50_pb_total_orders;
			STRING rv_l77_apartment;
			INTEGER rv_a46_curr_avm_autoval;
			STRING iv_a44_cur_add_naprop;
			INTEGER iv_c13_max_lres;
			INTEGER iv_l79_adls_per_apt_addr_c6;
			INTEGER iv_i60_inq_auto_count12;
			REAL verprob_subscore1;
			STRING verprob_aacd1;
			REAL verprob_distance1;
			STRING verprob_aacd2;
			REAL verprob_subscore2;
			REAL verprob_distance2;
			REAL verprob_subscore3;
			STRING verprob_aacd3;
			REAL verprob_distance3;
			STRING verprob_aacd4;
			REAL verprob_subscore4;
			REAL verprob_distance4;
			REAL verprob_subscore5;
			STRING verprob_aacd5;
			REAL verprob_distance5;
			STRING verprob_aacd6;
			REAL verprob_subscore6;
			REAL verprob_distance6;
			REAL verprob_subscore7;
			STRING verprob_aacd7;
			REAL verprob_distance7;
			REAL verprob_subscore8;
			STRING verprob_aacd8;
			REAL verprob_distance8;
			REAL verprob_subscore9;
			STRING verprob_aacd9;
			REAL verprob_distance9;
			REAL verprob_subscore10;
			STRING verprob_aacd10;
			REAL verprob_distance10;
			REAL verprob_subscore11;
			STRING verprob_aacd11;
			REAL verprob_distance11;
			STRING verprob_aacd12;
			REAL verprob_subscore12;
			REAL verprob_distance12;
			REAL verprob_subscore13;
			STRING verprob_aacd13;
			REAL verprob_distance13;
			REAL verprob_subscore14;
			STRING verprob_aacd14;
			REAL verprob_distance14;
			STRING verprob_aacd15;
			REAL verprob_subscore15;
			REAL verprob_distance15;
			REAL verprob_subscore16;
			STRING verprob_aacd16;
			REAL verprob_distance16;
			STRING verprob_aacd17;
			REAL verprob_subscore17;
			REAL verprob_distance17;
			REAL verprob_rcvaluea41;
			REAL verprob_rcvaluea50;
			REAL verprob_rcvaluec10;
			REAL verprob_rcvaluec12;
			REAL verprob_rcvaluec13;
			REAL verprob_rcvaluec14;
			REAL verprob_rcvaluec22;
			REAL verprob_rcvalued32;
			REAL verprob_rcvalued33;
			REAL verprob_rcvalued34;
			REAL verprob_rcvaluee55;
			REAL verprob_rcvaluee57;
			REAL verprob_rcvaluef01;
			REAL verprob_rcvaluei60;
			REAL verprob_rcvaluel00;
			REAL verprob_rcvaluel80;
			REAL verprob_rcvaluep85;
			REAL verprob_rawscore;
			REAL verprob_lnoddsscore;
			STRING derog_aacd1;
			REAL derog_subscore1;
			REAL derog_distance1;
			STRING derog_aacd2;
			REAL derog_subscore2;
			REAL derog_distance2;
			STRING derog_aacd3;
			REAL derog_subscore3;
			REAL derog_distance3;
			STRING derog_aacd4;
			REAL derog_subscore4;
			REAL derog_distance4;
			REAL derog_subscore5;
			STRING derog_aacd5;
			REAL derog_distance5;
			REAL derog_subscore6;
			STRING derog_aacd6;
			REAL derog_distance6;
			STRING derog_aacd7;
			REAL derog_subscore7;
			REAL derog_distance7;
			REAL derog_subscore8;
			STRING derog_aacd8;
			REAL derog_distance8;
			STRING derog_aacd9;
			REAL derog_subscore9;
			REAL derog_distance9;
			STRING derog_aacd10;
			REAL derog_subscore10;
			REAL derog_distance10;
			REAL derog_subscore11;
			STRING derog_aacd11;
			REAL derog_distance11;
			REAL derog_subscore12;
			STRING derog_aacd12;
			REAL derog_distance12;
			STRING derog_aacd13;
			REAL derog_subscore13;
			REAL derog_distance13;
			REAL derog_subscore14;
			STRING derog_aacd14;
			REAL derog_distance14;
			STRING derog_aacd15;
			REAL derog_subscore15;
			REAL derog_distance15;
			REAL derog_subscore16;
			STRING derog_aacd16;
			REAL derog_distance16;
			STRING derog_aacd17;
			REAL derog_subscore17;
			REAL derog_distance17;
			REAL derog_subscore18;
			STRING derog_aacd18;
			REAL derog_distance18;
			REAL derog_subscore19;
			STRING derog_aacd19;
			REAL derog_distance19;
			REAL derog_subscore20;
			STRING derog_aacd20;
			REAL derog_distance20;
			REAL derog_subscore21;
			STRING derog_aacd21;
			REAL derog_distance21;
			REAL derog_subscore22;
			STRING derog_aacd22;
			REAL derog_distance22;
			STRING derog_aacd23;
			REAL derog_subscore23;
			REAL derog_distance23;
			REAL derog_subscore24;
			STRING derog_aacd24;
			REAL derog_distance24;
			REAL derog_rcvaluea41;
			REAL derog_rcvaluea43;
			REAL derog_rcvaluea50;
			REAL derog_rcvaluec13;
			REAL derog_rcvaluec14;
			REAL derog_rcvaluec21;
			REAL derog_rcvaluec22;
			REAL derog_rcvalued32;
			REAL derog_rcvalued33;
			REAL derog_rcvalued34;
			REAL derog_rcvaluee55;
			REAL derog_rcvaluee57;
			REAL derog_rcvaluef03;
			REAL derog_rcvaluei60;
			REAL derog_rcvaluel77;
			REAL derog_rcvalues66;
			REAL derog_rawscore;
			REAL derog_lnoddsscore;
			STRING owner_aacd1;
			REAL owner_subscore1;
			REAL owner_distance1;
			STRING owner_aacd2;
			REAL owner_subscore2;
			REAL owner_distance2;
			STRING owner_aacd3;
			REAL owner_subscore3;
			REAL owner_distance3;
			REAL owner_subscore4;
			STRING owner_aacd4;
			REAL owner_distance4;
			REAL owner_subscore5;
			STRING owner_aacd5;
			REAL owner_distance5;
			REAL owner_subscore6;
			STRING owner_aacd6;
			REAL owner_distance6;
			REAL owner_subscore7;
			STRING owner_aacd7;
			REAL owner_distance7;
			REAL owner_subscore8;
			STRING owner_aacd8;
			REAL owner_distance8;
			REAL owner_subscore9;
			STRING owner_aacd9;
			REAL owner_distance9;
			STRING owner_aacd10;
			REAL owner_subscore10;
			REAL owner_distance10;
			REAL owner_subscore11;
			STRING owner_aacd11;
			REAL owner_distance11;
			STRING owner_aacd12;
			REAL owner_subscore12;
			REAL owner_distance12;
			REAL owner_subscore13;
			STRING owner_aacd13;
			REAL owner_distance13;
			REAL owner_subscore14;
			STRING owner_aacd14;
			REAL owner_distance14;
			REAL owner_subscore15;
			STRING owner_aacd15;
			REAL owner_distance15;
			REAL owner_subscore16;
			STRING owner_aacd16;
			REAL owner_distance16;
			REAL owner_subscore17;
			STRING owner_aacd17;
			REAL owner_distance17;
			REAL owner_subscore18;
			STRING owner_aacd18;
			REAL owner_distance18;
			STRING owner_aacd19;
			REAL owner_subscore19;
			REAL owner_distance19;
			STRING owner_aacd20;
			REAL owner_subscore20;
			REAL owner_distance20;
			REAL owner_subscore21;
			STRING owner_aacd21;
			REAL owner_distance21;
			STRING owner_aacd22;
			REAL owner_subscore22;
			REAL owner_distance22;
			REAL owner_subscore23;
			STRING owner_aacd23;
			REAL owner_distance23;
			REAL owner_subscore24;
			STRING owner_aacd24;
			REAL owner_distance24;
			STRING owner_aacd25;
			REAL owner_subscore25;
			REAL owner_distance25;
			REAL owner_subscore26;
			STRING owner_aacd26;
			REAL owner_distance26;
			STRING owner_aacd27;
			REAL owner_subscore27;
			REAL owner_distance27;
			REAL owner_subscore28;
			STRING owner_aacd28;
			REAL owner_distance28;
			STRING owner_aacd29;
			REAL owner_subscore29;
			REAL owner_distance29;
			REAL owner_rcvaluea43;
			REAL owner_rcvaluea44;
			REAL owner_rcvaluea46;
			REAL owner_rcvaluea50;
			REAL owner_rcvaluea51;
			REAL owner_rcvaluec10;
			REAL owner_rcvaluec12;
			REAL owner_rcvaluec13;
			REAL owner_rcvaluec14;
			REAL owner_rcvaluec15;
			REAL owner_rcvaluec21;
			REAL owner_rcvalued34;
			REAL owner_rcvaluee55;
			REAL owner_rcvaluee57;
			REAL owner_rcvaluef01;
			REAL owner_rcvaluef03;
			REAL owner_rcvaluei60;
			REAL owner_rcvaluel77;
			REAL owner_rcvaluel79;
			REAL owner_rcvaluel80;
			REAL owner_rcvalues66;
			REAL owner_rawscore;
			REAL owner_lnoddsscore;
			REAL other_subscore1;
			STRING other_aacd1;
			REAL other_distance1;
			STRING other_aacd2;
			REAL other_subscore2;
			REAL other_distance2;
			STRING other_aacd3;
			REAL other_subscore3;
			REAL other_distance3;
			REAL other_subscore4;
			STRING other_aacd4;
			REAL other_distance4;
			STRING other_aacd5;
			REAL other_subscore5;
			REAL other_distance5;
			REAL other_subscore6;
			STRING other_aacd6;
			REAL other_distance6;
			REAL other_subscore7;
			STRING other_aacd7;
			REAL other_distance7;
			REAL other_subscore8;
			STRING other_aacd8;
			REAL other_distance8;
			REAL other_subscore9;
			STRING other_aacd9;
			REAL other_distance9;
			REAL other_subscore10;
			STRING other_aacd10;
			REAL other_distance10;
			REAL other_subscore11;
			STRING other_aacd11;
			REAL other_distance11;
			STRING other_aacd12;
			REAL other_subscore12;
			REAL other_distance12;
			STRING other_aacd13;
			REAL other_subscore13;
			REAL other_distance13;
			STRING other_aacd14;
			REAL other_subscore14;
			REAL other_distance14;
			REAL other_subscore15;
			STRING other_aacd15;
			REAL other_distance15;
			STRING other_aacd16;
			REAL other_subscore16;
			REAL other_distance16;
			REAL other_subscore17;
			STRING other_aacd17;
			REAL other_distance17;
			REAL other_subscore18;
			STRING other_aacd18;
			REAL other_distance18;
			STRING other_aacd19;
			REAL other_subscore19;
			REAL other_distance19;
			STRING other_aacd20;
			REAL other_subscore20;
			REAL other_distance20;
			REAL other_subscore21;
			STRING other_aacd21;
			REAL other_distance21;
			REAL other_subscore22;
			STRING other_aacd22;
			REAL other_distance22;
			STRING other_aacd23;
			REAL other_subscore23;
			REAL other_distance23;
			REAL other_subscore24;
			STRING other_aacd24;
			REAL other_distance24;
			STRING other_aacd25;
			REAL other_subscore25;
			REAL other_distance25;
			REAL other_subscore26;
			STRING other_aacd26;
			REAL other_distance26;
			REAL other_subscore27;
			STRING other_aacd27;
			REAL other_distance27;
			REAL other_rcvaluea43;
			REAL other_rcvaluea50;
			REAL other_rcvaluea51;
			REAL other_rcvaluec10;
			REAL other_rcvaluec12;
			REAL other_rcvaluec13;
			REAL other_rcvaluec14;
			REAL other_rcvaluec15;
			REAL other_rcvaluec20;
			REAL other_rcvaluec21;
			REAL other_rcvaluee55;
			REAL other_rcvaluee57;
			REAL other_rcvaluef01;
			REAL other_rcvaluef03;
			REAL other_rcvaluei60;
			REAL other_rcvaluel79;
			REAL other_rcvaluel80;
			REAL other_rcvalues66;
			REAL other_rawscore;
			REAL other_lnoddsscore;
			REAL lnoddsscore;
			INTEGER score_lnodds;
			INTEGER score_lnodds_capped;
			BOOLEAN ov_ssnprior;
			BOOLEAN ov_corrections;
			BOOLEAN unscorable;
			INTEGER deceased;
			INTEGER rva1403_0_0;
			STRING verprob_rc1;
			STRING verprob_rc2;
			STRING verprob_rc3;
			STRING verprob_rc4;
			STRING derog_rc1;
			STRING derog_rc2;
			STRING derog_rc3;
			STRING derog_rc4;
			STRING owner_rc1;
			STRING owner_rc2;
			STRING owner_rc3;
			STRING owner_rc4;
			STRING other_rc1;
			STRING other_rc2;
			STRING other_rc3;
			STRING other_rc4;
			STRING rc1_1;
			STRING _rc_seg_c267;
			STRING _rc_seg_c268;
			STRING _rc_seg_c266;
			STRING _rc_seg_c269;
			STRING _rc_seg;
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
	source_profile                   := le.source_profile;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_z5                           := le.shell_input.z5;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := (INTEGER)le.iid.nas_summary;
	nap_summary                      := (INTEGER)le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_hriskaddrflag                 := (INTEGER)le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := (INTEGER)le.input_validation.ssn_length;
	dobpop                           := (BOOLEAN)(INTEGER)le.input_validation.dateofbirth;
	hphnpop                          := (INTEGER)le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := (INTEGER)le.address_verification.input_address_information.isbestmatch;
	add_input_lres                   := le.lres;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator	;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind	;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := (INTEGER)le.address_verification.address_history_1.isbestmatch;
	add_curr_lres                    := le.lres2;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_lres                    := le.lres3;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	add_prev_pop                     := le.addrPop3;
	avg_lres                         := le.other_address_info.avg_lres;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlperssn_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
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
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	br_first_seen                    := le.employment.first_seen_date;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count90                  := le.impulse.count90;
	stl_inq_count180                 := le.impulse.count180;
	stl_inq_count12                  := le.impulse.count12;
	stl_inq_count24                  := le.impulse.count24;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
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
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_match_level            := (INTEGER)le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	sysdate := common.sas_date(if(le.historydate=999999, (string)std.date.today(), IF(LENGTH((STRING)le.historydate) = 6, ((string)le.historydate)[1..6]+'01', ((STRING)le.historydate)[1..8])));
	
	iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != '' or out_sec_range != '';
	
	nas_summary_ver2 := map(
	    ssnlength = 0                                            => -2,
	    (nas_summary in [8, 9, 10, 11, 12])                      => 1,
	    (nas_summary in [2, 4, 7]) and add_input_isbestmatch = 1 => 1,
	                                                                0);
	
	nap_summary_ver := if(hphnpop = 0, -2, (INTEGER)(nap_summary in [9, 10, 11, 12]));
	
	infutor_nap_ver := if(hphnpop = 0, -2, (INTEGER)(infutor_nap in [9, 10, 11, 12]));
	
	dobver := map(
	    not(dobpop)                => -2,
	    input_dob_match_level = 8  => 1,
	    input_dob_match_level >= 5 => 0,
	                                  -1);
	
	sufficiently_verified := map(
	    nas_summary_ver2 = 1 and (nap_summary_ver = 1 or infutor_nap_ver = 1) => 1,
	    nas_summary_ver2 = 1 and dobver != -1                                 => 1,
	    (nap_summary_ver = 1 or infutor_nap_ver = 1) and dobver != -1         => 1,
	                                                                             0);
	
	adls_per_ssn_ge5 := adls_per_ssn >= 5;
	
	ssns_per_adl_ge4 := ssns_per_adl >= 4;
	
	invalid_ssns_per_adl_ge1 := invalid_ssns_per_adl >= 1;
	
	adls_per_addr_curr_ge8 := adls_per_addr_curr >= 8;
	
	ssns_per_addr_curr_ge7 := ssns_per_addr_curr >= 7;
	
	hrisksic_addr := rc_hrisksic = '2225';
	
	hrisksic_phn := rc_hrisksicphone = '2225';
	
	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];
	
	addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = 4 or (INTEGER)rc_addrcommflag = 2 or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and ((INTEGER)rc_hriskaddrflag = 2 or (INTEGER)rc_ziptypeflag = 2) or add_input_advo_vacancy = 'Y', 1, 0);
	
	phn_validation_problem := if(rc_hphonetypeflag = 'A' or (INTEGER)rc_hriskphoneflag = 2 or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or (INTEGER)rc_phonevalflag = 0 or (INTEGER)rc_hphonevalflag = 0 or (INTEGER)rc_phonetype = 5 or (INTEGER)rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or (INTEGER)rc_hphonevalflag = 3 or (INTEGER)rc_addrcommflag = 1, 1, 0);
	
	validation_problem := max((real)adls_per_ssn_ge5, (integer)(real)ssns_per_adl_ge4, (integer)(real)invalid_ssns_per_adl_ge1, (integer)(real)adls_per_addr_curr_ge8, (integer)(real)ssns_per_addr_curr_ge7, (integer)(real)hrisksic_addr, (integer)(real)hrisksic_phn, addr_validation_problem, phn_validation_problem);
	
	lj_landlordtenant_ct := if(max(liens_unrel_LT_ct, liens_rel_LT_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct)));
	
	lj_smallclaims_ct := if(max(liens_unrel_SC_ct, liens_rel_SC_ct) = NULL, NULL, sum(if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct)));
	
	lj_court_ct := if(max(liens_unrel_CJ_ct, liens_rel_CJ_ct) = NULL, NULL, sum(if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct)));
	
	lj_tax_ct := if(max(liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct) = NULL, NULL, sum(if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct)));
	
	lj_foreclosure_ct := if(max(liens_unrel_FC_ct, liens_rel_FC_ct) = NULL, NULL, sum(if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct)));
	
	lj_other_ct := if(max(liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct)));
	
	lj_total_ct := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));
	
	lj_no_type_ct := lj_total_ct - if(max(lj_landlordtenant_ct, lj_smallclaims_ct, lj_court_ct, lj_tax_ct, lj_foreclosure_ct, lj_other_ct) = NULL, NULL, sum(if(lj_landlordtenant_ct = NULL, 0, lj_landlordtenant_ct), if(lj_smallclaims_ct = NULL, 0, lj_smallclaims_ct), if(lj_court_ct = NULL, 0, lj_court_ct), if(lj_tax_ct = NULL, 0, lj_tax_ct), if(lj_foreclosure_ct = NULL, 0, lj_foreclosure_ct), if(lj_other_ct = NULL, 0, lj_other_ct)));
	
	lj_flag := attr_eviction_count > 0 or lj_court_ct > 0 or lj_smallclaims_ct > 0 or lj_foreclosure_ct > 0 or lj_other_ct > 0 or lj_no_type_ct > 0;
	
	derog_severity := map(
	    felony_count > 0 or criminal_count > 0                                                                                                                                                                                                  => 4,
	    stl_inq_count24 > 0                                                                                                                                                                                                                     => 3,
	    (INTEGER)lj_flag > 0                                                                                                                                                                                                                             => 2,
	    if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => 1,
	                                                                                                                                                                                                                                               0);
	
	seg_ver_derog_owner := map(
	    (INTEGER)truedid = 0                                                             => '1 - TrueDid0 Ver/ValProb',
	    sufficiently_verified = 0                                                        => '1 - TrueDid0 Ver/ValProb',
	    sufficiently_verified = 1 and validation_problem = 1                             => '1 - TrueDid0 Ver/ValProb',
	    sufficiently_verified = 1 and derog_severity > 0                                 => '2 - Derog               ',
	    sufficiently_verified = 1 and (add_input_naprop = 4 or Property_Owned_Total > 0) => '3 - Owner               ',
	                                                                                        '4 - Other               ');
	
	vervalprob_seg := not((boolean)(INTEGER)sufficiently_verified) or (boolean)(integer)validation_problem or not(truedid);
	
	derog_seg := not(vervalprob_seg) and derog_severity > 0;
	
	owner_seg := not(vervalprob_seg or derog_seg) and (add_input_naprop = 4 or Property_Owned_Total > 0);
	
	other_seg := not(vervalprob_seg or derog_seg or owner_seg);
	
	_br_first_seen := Common.SAS_Date((STRING)(br_first_seen));
	
	iv_mos_since_br_first_seen := map(
	    not(truedid)               => NULL,
	    not(_br_first_seen = NULL) => if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))),
	                                  -1);
	
	iv_br_source_count := if(not(truedid), NULL, br_source_count);
	
	bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');
	
	bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));
	
	_bureau_adl_fseen_eq := Common.SAS_Date((STRING)(bureau_adl_fseen_eq));
	
	_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);
	
	rv_c21_m_bureau_adl_fs := map(
	    not(truedid)                   => NULL,
	    _src_bureau_adl_fseen = 999999 => -1,
	                                      if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));
	
	rv_a42_prop_owner := if(not(truedid), NULL, (INTEGER)(add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or Property_Owned_Total > 0));
	
	_criminal_last_date := Common.SAS_Date((STRING)(criminal_last_date));
	
	rv_d32_mos_since_crim_ls := map(
	    not(truedid)               => NULL,
	    _criminal_last_date = NULL => -1,
	                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));
	
	rv_d33_eviction_recency := map(
	    not(truedid)                                                => NULL,
	    attr_eviction_count90 > 0                                   => 3,
	    attr_eviction_count180 > 0                                  => 6,
	    attr_eviction_count12 > 0                                   => 12,
	    attr_eviction_count24 > 0 and attr_eviction_count >= 2 			=> 24,
	    attr_eviction_count24 > 0                                   => 25,
	    attr_eviction_count36 > 0 and attr_eviction_count >= 2 			=> 36,
	    attr_eviction_count36 > 0                                   => 37,
	    attr_eviction_count60 > 0 and attr_eviction_count >= 2 			=> 60,
	    attr_eviction_count60 > 0                                   => 61,
	    attr_eviction_count >= 2                                    => 98,
	    attr_eviction_count >= 1                                    => 99,
	                                                                   0);
	
	rv_c22_stl_inq_count12 := if(not(truedid), NULL, STL_Inq_count12);
	
	rv_c22_stl_inq_count24 := if(not(truedid), NULL, STL_Inq_count24);
	
	rv_c22_stl_recency := map(
	    not(truedid)         => '  ',
	    stl_inq_count90 > 0  => '3 ',
	    stl_inq_count180 > 0 => '6 ',
	    stl_inq_count12 > 0  => '12',
	    stl_inq_count24 > 0  => '24',
	                            '0 ');
	
	rv_s66_adlperssn_count := map(
	    not(ssnlength > 0) => NULL,
	    adls_per_ssn = 0   => 1,
	                          adls_per_ssn);
	
	rv_c14_addrs_per_adl_c6 := if(not(truedid), NULL, addrs_per_adl_c6);
	
	rv_a42_prop_owner_inp_only := if(not(truedid), NULL, (INTEGER)(add_input_naprop = 4 or property_owned_total > 0));
	
	rv_e55_college_ind_shell5 := map(
	    not(truedid)                           => ' ',
	    (college_file_type in ['H', 'C', 'A']) => '1',
	    college_attendance                     => '1',
	                                              '0');
	
	iv_f07_input_add_not_most_rec := if(not(truedid and add_input_pop), '', (STRING)(INTEGER)rc_input_addr_not_most_recent);
	
	iv_l77_dwelltype := map(
	    not(add_input_pop)  		=> '   ',
	    TRIM(rc_dwelltype) = '' => 'SFD',
	    rc_dwelltype = 'A'  		=> 'MFD',
	    rc_dwelltype = 'E'  		=> 'POB',
	    rc_dwelltype = 'R'  		=> 'RR ',
	    rc_dwelltype = 'S'  		=> 'GEN',
																'   ');
	
	iv_c13_inp_addr_lres := if(not(add_input_pop and truedid), NULL, add_input_lres);
	
	iv_c14_addrs_10yr := map(
	    not(truedid)     			=> NULL,
	    add_curr_pop = FALSE	=> -1,
															addrs_10yr);
	
	iv_i60_credit_seeking := if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))))));
	
	iv_i60_inq_auto_recency := map(
	    not(truedid)     		 => NULL,
	    inq_auto_count01 > 0 => 1,
	    inq_auto_count03 > 0 => 3,
	    inq_auto_count06 > 0 => 6,
	    inq_auto_count12 > 0 => 12,
	    inq_auto_count24 > 0 => 24,
	    inq_auto_count > 0   => 99,
															0);
	
	iv_a43_rec_vehx_level := map(
	    not(truedid)                                   => '  ',
	    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
	    attr_num_aircraft > 0                          => 'AO',
	    watercraft_count > 0                           => 'W' + (STRING)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3),
	                                                      'XX');
	
	iv_d33_eviction_count_1 := if(not(truedid), NULL, attr_eviction_count);
	
	iv_d34_unrel_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));
	
	iv_d34_liens_unrel_x_rel := if(not(truedid), '', (STRING)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3) + '-' + (STRING)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2));
	
	iv_d32_criminal_x_felony := if(not(truedid), '', (STRING)min(if(criminal_count = NULL, -NULL, criminal_count), 3) + '-' + (STRING)min(if(felony_count = NULL, -NULL, felony_count), 3));
	
	iv_e57_prof_license_flag := if(not(truedid), '', (STRING)(INTEGER)prof_license_flag);
	
	iv_a50_pb_total_dollars := map(
	    not(truedid)            => NULL,
	    pb_total_dollars = ''   => -1,
	                               (INTEGER)pb_total_dollars);
	
	rv_p85_phn_not_issued := map(
	    // not(hphnpop)                 => ' ',
	    hphnpop = 0                  => ' ',
	    (rc_pwphonezipflag in ['4']) => '1',
	                                    '0');
	
	_header_first_seen := Common.SAS_Date((STRING)(header_first_seen));
	
	rv_c10_m_hdr_fs := map(
	    not(truedid)                   => NULL,
	    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
	                                      -1);
	
	rv_c12_source_profile := Source_Profile;
	
	rv_a47_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);
	
	iv_f02_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, add_input_address_score);
	
	iv_c13_prv_addr_lres := if(not(truedid and add_prev_pop), NULL, add_prev_lres);
	
	iv_i60_inq_recency := map(
	    not(truedid) 		 => NULL,
	    inq_count01 > 0  => 1,
	    inq_count03 > 0  => 3,
	    inq_count06 > 0  => 6,
	    inq_count12 > 0  => 12,
	    inq_count24 > 0  => 24,
	    inq_count > 0    => 99,
													0);
	
	iv_d33_eviction_count := if(not(truedid), NULL, attr_eviction_count);
	
	rv_c15_ssns_per_adl := map(
	    not(truedid)     => NULL,
	    ssns_per_adl = 0 => 1,
	                        ssns_per_adl);
	
	rv_c13_curr_addr_lres := if(not(truedid), NULL, add_curr_lres);
	
	rv_i60_inq_count12 := if(not(truedid), NULL, inq_count12);
	
	iv_f07_address_match_1 := if(not(truedid), NULL, NULL);
	
	iv_f07_address_match := map(
	    add_input_isbestmatch = 1                   		=> '4 Input=Curr',
	    not(add_input_pop) and add_curr_isbestmatch = 1 => '3 CurrAvail + NoInputPop',
	    add_input_pop and add_curr_isbestmatch = 1  		=> '2 CurrAvail + InputNotCurr',
	    add_curr_pop                                		=> '1 Curr OnHdrOnly',
	    add_input_pop                               		=> '0 InputPop NoHistAvail',
																												 ' ');
	
	iv_c13_avg_lres := if(not(truedid), NULL, avg_lres);
	
	iv_c14_addrs_5yr := map(
	    not(truedid)     => NULL,
	    add_curr_pop = FALSE => -1,
	                        addrs_5yr);
	
	iv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, adls_per_addr_c6);
	
	iv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);
	
	iv_i60_inq_phones_per_adl := if(not(truedid), NULL, inq_phonesperadl);
	
	iv_c20_email_domain_free_count := if(not(truedid), NULL, email_domain_free_count);
	
	iv_c13_attr_addrs_recency := map(
	    not(truedid)      		=> NULL,
	    attr_addrs_last30 > 0 => 1,
	    attr_addrs_last90 > 0 => 3,
	    attr_addrs_last12 > 0 => 12,
	    attr_addrs_last24 > 0 => 24,
	    attr_addrs_last36 > 0 => 36,
	    addrs_5yr > 0         => 60,
	    addrs_10yr > 0        => 120,
	    addrs_15yr > 0        => 180,
	    addrs_per_adl > 0 		=> 999,
															0);
	
	iv_a50_pb_average_dollars := map(
	    not(truedid)              => NULL,
	    pb_average_dollars = ''		=> -1,
	                                 (INTEGER)pb_average_dollars);
	
	iv_a50_pb_total_orders := map(
	    not(truedid)           => NULL,
	    pb_total_orders = '' 	 => -1,
	                              (INTEGER)pb_total_orders);
	
	rv_l77_apartment := map(
	    not(addrpop)                                                                                                                                                                                         	=> ' ',
	    StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '') 			=> '1',
																																																																																																							 '0');
	
	rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	iv_a44_cur_add_naprop := if(not(truedid and add_curr_pop), '', (STRING)(INTEGER)add_curr_naprop);
	
	iv_c13_max_lres := if(not(truedid), NULL, max_lres);
	
	iv_l79_adls_per_apt_addr_c6 := map(
	    not(addrpop)     		=> NULL,
	    iv_add_apt = FALSE	=> -1,
														adls_per_addr_c6);
	
	iv_i60_inq_auto_count12 := if(not(truedid), NULL, inq_auto_count12);
	
	
	verprob_subscore1 := map(
	    NULL < iv_i60_inq_recency AND iv_i60_inq_recency < 1 => 0.150627,
	    1 <= iv_i60_inq_recency AND iv_i60_inq_recency < 3   => -0.560158,
	    3 <= iv_i60_inq_recency                              => 0.145037,
	                                                            0.000000);
	
	verprob_aacd1 := map(
	    NULL < iv_i60_inq_recency AND iv_i60_inq_recency < 1 => 'I60',
	    1 <= iv_i60_inq_recency AND iv_i60_inq_recency < 3   => 'I60',
	    3 <= iv_i60_inq_recency                              => 'I60',
	                                                            '');
	
	verprob_distance1 := if(verprob_aacd1 = '', 0, verprob_subscore1 - 0.150627);
	
	verprob_aacd2 := map(
	    NULL < iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 20 => 'F01',
	    20 <= iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 50  => 'F01',
	    50 <= iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 255 => 'F01',
	    255 <= iv_f02_inp_addr_address_score                                        => 'F01',
	                                                                                   '');
	
	verprob_subscore2 := map(
	    NULL < iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 20 => -0.272509,
	    20 <= iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 50  => -0.130408,
	    50 <= iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 255 => 0.119059,
	    255 <= iv_f02_inp_addr_address_score                                        => 0.000000,
	                                                                                   0.000000);
	
	verprob_distance2 := if(verprob_aacd2 = '', 0, verprob_subscore2 - 0.119059);
	
	verprob_subscore3 := map(
	    (rv_p85_phn_not_issued in [' ']) => 0.000000,
	    (rv_p85_phn_not_issued in ['0']) => 0.029807,
	    (rv_p85_phn_not_issued in ['1']) => -0.673091,
	                                        0.000000);
	
	verprob_aacd3 := map(
	    (rv_p85_phn_not_issued in [' ']) => 'P85',
	    (rv_p85_phn_not_issued in ['0']) => 'P85',
	    (rv_p85_phn_not_issued in ['1']) => 'P85',
	                                        '');
	
	verprob_distance3 := if(verprob_aacd3 = '', 0, verprob_subscore3 - 0.029807);
	
	verprob_aacd4 := map(
	    (iv_d34_liens_unrel_x_rel in [' '])                                                    => '',
	    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                  => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0'])                                           => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['3-0'])                                                  => 'D34',
	                                                                                              '');
	
	verprob_subscore4 := map(
	    (iv_d34_liens_unrel_x_rel in [' '])                                                    => 0.000000,
	    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                  => 0.070548,
	    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => -0.009017,
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0'])                                           => -0.202860,
	    (iv_d34_liens_unrel_x_rel in ['3-0'])                                                  => -0.411822,
	                                                                                              0.000000);
	
	verprob_distance4 := if(verprob_aacd4 = '', 0, verprob_subscore4 - 0.070548);
	
	verprob_subscore5 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 0  => -0.085976,
	    0 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 81   => 0.082723,
	    81 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 162 => 0.208702,
	    162 <= iv_a50_pb_total_dollars                                  => 0.269598,
	                                                                       -0.000000);
	
	verprob_aacd5 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 0  => 'A50',
	    0 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 81   => 'A50',
	    81 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 162 => 'A50',
	    162 <= iv_a50_pb_total_dollars                                  => 'A50',
	                                                                       '');
	
	verprob_distance5 := if(verprob_aacd5 = '', 0, verprob_subscore5 - 0.269598);
	
	verprob_aacd6 := map(
	    NULL < rv_a42_prop_owner AND rv_a42_prop_owner < 1 => 'A41',
	    1 <= rv_a42_prop_owner                             => 'A41',
	                                                          '');
	
	verprob_subscore6 := map(
	    NULL < rv_a42_prop_owner AND rv_a42_prop_owner < 1 => -0.063556,
	    1 <= rv_a42_prop_owner                             => 0.201989,
	                                                          0.000000);
	
	verprob_distance6 := if(verprob_aacd6 = '', 0, verprob_subscore6 - 0.201989);
	
	verprob_subscore7 := map(
	    (rv_e55_college_ind_shell5 in [' ']) => -0.000000,
	    (rv_e55_college_ind_shell5 in ['0']) => -0.016895,
	    (rv_e55_college_ind_shell5 in ['1']) => 0.216448,
	                                            -0.000000);
	
	verprob_aacd7 := map(
	    (rv_e55_college_ind_shell5 in [' ']) => '',
	    (rv_e55_college_ind_shell5 in ['0']) => 'E55',
	    (rv_e55_college_ind_shell5 in ['1']) => 'E55',
	                                            '');
	
	verprob_distance7 := if(verprob_aacd7 = '', 0, verprob_subscore7 - 0.216448);
	
	verprob_subscore8 := map(
	    NULL < iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 3 => 0.094775,
	    3 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 6   => -0.031047,
	    6 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 9   => -0.065541,
	    9 <= iv_c14_addrs_10yr                             => -0.340845,
	                                                          0.000000);
	
	verprob_aacd8 := map(
	    NULL < iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 3 => 'C14',
	    3 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 6   => 'C14',
	    6 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 9   => 'C14',
	    9 <= iv_c14_addrs_10yr                             => 'C14',
	                                                          '');
	
	verprob_distance8 := if(verprob_aacd8 = '', 0, verprob_subscore8 - 0.094775);
	
	verprob_subscore9 := map(
	    NULL < iv_c13_prv_addr_lres AND iv_c13_prv_addr_lres < 8 => -0.137685,
	    8 <= iv_c13_prv_addr_lres AND iv_c13_prv_addr_lres < 87  => 0.042287,
	    87 <= iv_c13_prv_addr_lres                               => 0.114960,
	                                                                0.000000);
	
	verprob_aacd9 := map(
	    NULL < iv_c13_prv_addr_lres AND iv_c13_prv_addr_lres < 8 => 'C13',
	    8 <= iv_c13_prv_addr_lres AND iv_c13_prv_addr_lres < 87  => 'C13',
	    87 <= iv_c13_prv_addr_lres                               => 'C13',
	                                                                '');
	
	verprob_distance9 := if(verprob_aacd9 = '', 0, verprob_subscore9 - 0.114960);
	
	verprob_subscore10 := map(
	    NULL < iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 6 => -0.085880,
	    6 <= iv_c13_inp_addr_lres                                => 0.076881,
	                                                                0.000000);
	
	verprob_aacd10 := map(
	    NULL < iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 6 => 'C13',
	    6 <= iv_c13_inp_addr_lres                                => 'C13',
	                                                                '');
	
	verprob_distance10 := if(verprob_aacd10 = '', 0, verprob_subscore10 - 0.076881);
	
	verprob_subscore11 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 49 => -0.070601,
	    49 <= rv_c12_source_profile AND rv_c12_source_profile < 60  => -0.027270,
	    60 <= rv_c12_source_profile                                 => 0.111282,
	                                                                   0.000000);
	
	verprob_aacd11 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 49 => 'C12',
	    49 <= rv_c12_source_profile AND rv_c12_source_profile < 60  => 'C12',
	    60 <= rv_c12_source_profile                                 => 'C12',
	                                                                   '');
	
	verprob_distance11 := if(verprob_aacd11 = '', 0, verprob_subscore11 - 0.111282);
	
	verprob_aacd12 := map(
	    NULL < rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 1 => 'C22',
	    1 <= rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 2   => 'C22',
	    2 <= rv_c22_stl_inq_count24                                  => 'C22',
	                                                                    '');
	
	verprob_subscore12 := map(
	    NULL < rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 1 => 0.015736,
	    1 <= rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 2   => -0.179258,
	    2 <= rv_c22_stl_inq_count24                                  => -0.481540,
	                                                                    0.000000);
	
	verprob_distance12 := if(verprob_aacd12 = '', 0, verprob_subscore12 - 0.015736);
	
	verprob_subscore13 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 71 => -0.111217,
	    71 <= rv_c10_m_hdr_fs                           => 0.036116,
	                                                       0.000000);
	
	verprob_aacd13 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 71 => 'C10',
	    71 <= rv_c10_m_hdr_fs                           => 'C10',
	                                                       '');
	
	verprob_distance13 := if(verprob_aacd13 = '', 0, verprob_subscore13 - 0.036116);
	
	verprob_subscore14 := map(
	    (iv_d32_criminal_x_felony in [' '])                                                           => 0.000000,
	    (iv_d32_criminal_x_felony in ['0-0'])                                                         => 0.010910,
	    (iv_d32_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.313913,
	                                                                                                     0.000000);
	
	verprob_aacd14 := map(
	    (iv_d32_criminal_x_felony in [' '])                                                           => '',
	    (iv_d32_criminal_x_felony in ['0-0'])                                                         => 'D32',
	    (iv_d32_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                                     '');
	
	verprob_distance14 := if(verprob_aacd14 = '', 0, verprob_subscore14 - 0.010910);
	
	verprob_aacd15 := map(
	    NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval <= 0     	=> 'A51',
	    0 < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 89323   		=> 'L80',
	    // NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 3243     => 'A51',
	    // 3243 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 89323   => 'L80',
	    89323 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 212652 => 'L80',
	    212652 <= rv_a47_inp_avm_autoval                                    => 'L80',
	                                                                           '');
	
	verprob_subscore15 := map(
	    NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval <= 0     	=> 0.000000,
	    0 < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 89323   		=> -0.111621,
	    89323 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 212652 => 0.027055,
	    212652 <= rv_a47_inp_avm_autoval                                    => 0.132072,
	                                                                           0.000000);
	
	verprob_distance15 := if(verprob_aacd15 = '', 0, verprob_subscore15 - 0.132072);
	
	verprob_subscore16 := map(
	    NULL < iv_d33_eviction_count AND iv_d33_eviction_count < 1 => 0.013861,
	    1 <= iv_d33_eviction_count                                 => -0.154639,
	                                                                  0.000000);
	
	verprob_aacd16 := map(
	    NULL < iv_d33_eviction_count AND iv_d33_eviction_count < 1 => 'D33',
	    1 <= iv_d33_eviction_count                                 => 'D33',
	                                                                  '');
	
	verprob_distance16 := if(verprob_aacd16 = '', 0, verprob_subscore16 - 0.013861);
	
	verprob_aacd17 := map(
	    NULL < iv_mos_since_br_first_seen AND iv_mos_since_br_first_seen < 0 => 'E57',
	    0 <= iv_mos_since_br_first_seen                                      => 'E57',
	                                                                            '');
	
	verprob_subscore17 := map(
	    NULL < iv_mos_since_br_first_seen AND iv_mos_since_br_first_seen < 0 => -0.012781,
	    0 <= iv_mos_since_br_first_seen                                      => 0.165047,
	                                                                            -0.000000);
	
	verprob_distance17 := if(verprob_aacd17 = '', 0, verprob_subscore17 - 0.165047);
	
	verprob_rcvaluea41 := (integer)(verprob_aacd1 = 'A41') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'A41') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'A41') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'A41') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'A41') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'A41') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'A41') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'A41') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'A41') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'A41') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'A41') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'A41') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'A41') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'A41') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'A41') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'A41') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'A41') * verprob_distance17;
	
	verprob_rcvaluea50 := (integer)(verprob_aacd1 = 'A50') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'A50') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'A50') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'A50') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'A50') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'A50') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'A50') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'A50') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'A50') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'A50') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'A50') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'A50') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'A50') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'A50') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'A50') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'A50') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'A50') * verprob_distance17;
	
	verprob_rcvaluec10 := (integer)(verprob_aacd1 = 'C10') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'C10') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'C10') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'C10') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'C10') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'C10') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'C10') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'C10') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'C10') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'C10') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'C10') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'C10') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'C10') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'C10') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'C10') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'C10') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'C10') * verprob_distance17;
	
	verprob_rcvaluec12 := (integer)(verprob_aacd1 = 'C12') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'C12') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'C12') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'C12') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'C12') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'C12') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'C12') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'C12') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'C12') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'C12') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'C12') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'C12') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'C12') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'C12') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'C12') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'C12') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'C12') * verprob_distance17;
	
	verprob_rcvaluec13 := (integer)(verprob_aacd1 = 'C13') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'C13') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'C13') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'C13') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'C13') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'C13') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'C13') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'C13') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'C13') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'C13') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'C13') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'C13') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'C13') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'C13') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'C13') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'C13') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'C13') * verprob_distance17;
	
	verprob_rcvaluec14 := (integer)(verprob_aacd1 = 'C14') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'C14') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'C14') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'C14') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'C14') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'C14') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'C14') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'C14') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'C14') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'C14') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'C14') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'C14') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'C14') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'C14') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'C14') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'C14') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'C14') * verprob_distance17;
	
	verprob_rcvaluec22 := (integer)(verprob_aacd1 = 'C22') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'C22') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'C22') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'C22') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'C22') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'C22') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'C22') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'C22') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'C22') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'C22') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'C22') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'C22') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'C22') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'C22') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'C22') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'C22') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'C22') * verprob_distance17;
	
	verprob_rcvalued32 := (integer)(verprob_aacd1 = 'D32') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'D32') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'D32') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'D32') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'D32') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'D32') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'D32') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'D32') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'D32') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'D32') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'D32') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'D32') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'D32') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'D32') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'D32') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'D32') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'D32') * verprob_distance17;
	
	verprob_rcvalued33 := (integer)(verprob_aacd1 = 'D33') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'D33') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'D33') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'D33') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'D33') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'D33') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'D33') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'D33') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'D33') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'D33') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'D33') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'D33') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'D33') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'D33') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'D33') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'D33') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'D33') * verprob_distance17;
	
	verprob_rcvalued34 := (integer)(verprob_aacd1 = 'D34') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'D34') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'D34') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'D34') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'D34') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'D34') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'D34') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'D34') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'D34') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'D34') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'D34') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'D34') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'D34') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'D34') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'D34') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'D34') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'D34') * verprob_distance17;
	
	verprob_rcvaluee55 := (integer)(verprob_aacd1 = 'E55') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'E55') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'E55') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'E55') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'E55') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'E55') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'E55') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'E55') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'E55') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'E55') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'E55') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'E55') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'E55') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'E55') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'E55') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'E55') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'E55') * verprob_distance17;
	
	verprob_rcvaluee57 := (integer)(verprob_aacd1 = 'E57') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'E57') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'E57') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'E57') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'E57') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'E57') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'E57') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'E57') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'E57') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'E57') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'E57') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'E57') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'E57') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'E57') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'E57') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'E57') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'E57') * verprob_distance17;
	
	verprob_rcvaluef01 := (integer)(verprob_aacd1 = 'F01') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'F01') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'F01') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'F01') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'F01') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'F01') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'F01') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'F01') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'F01') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'F01') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'F01') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'F01') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'F01') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'F01') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'F01') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'F01') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'F01') * verprob_distance17;
	
	verprob_rcvaluei60 := (integer)(verprob_aacd1 = 'I60') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'I60') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'I60') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'I60') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'I60') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'I60') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'I60') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'I60') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'I60') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'I60') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'I60') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'I60') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'I60') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'I60') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'I60') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'I60') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'I60') * verprob_distance17;
	
	verprob_rcvaluel00 := (integer)(verprob_aacd1 = 'A51') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'A51') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'A51') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'A51') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'A51') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'A51') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'A51') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'A51') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'A51') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'A51') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'A51') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'A51') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'A51') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'A51') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'A51') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'A51') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'A51') * verprob_distance17;
	
	verprob_rcvaluel80 := (integer)(verprob_aacd1 = 'L80') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'L80') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'L80') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'L80') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'L80') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'L80') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'L80') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'L80') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'L80') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'L80') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'L80') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'L80') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'L80') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'L80') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'L80') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'L80') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'L80') * verprob_distance17;
	
	verprob_rcvaluep85 := (integer)(verprob_aacd1 = 'P85') * verprob_distance1 +
	    (integer)(verprob_aacd2 = 'P85') * verprob_distance2 +
	    (integer)(verprob_aacd3 = 'P85') * verprob_distance3 +
	    (integer)(verprob_aacd4 = 'P85') * verprob_distance4 +
	    (integer)(verprob_aacd5 = 'P85') * verprob_distance5 +
	    (integer)(verprob_aacd6 = 'P85') * verprob_distance6 +
	    (integer)(verprob_aacd7 = 'P85') * verprob_distance7 +
	    (integer)(verprob_aacd8 = 'P85') * verprob_distance8 +
	    (integer)(verprob_aacd9 = 'P85') * verprob_distance9 +
	    (integer)(verprob_aacd10 = 'P85') * verprob_distance10 +
	    (integer)(verprob_aacd11 = 'P85') * verprob_distance11 +
	    (integer)(verprob_aacd12 = 'P85') * verprob_distance12 +
	    (integer)(verprob_aacd13 = 'P85') * verprob_distance13 +
	    (integer)(verprob_aacd14 = 'P85') * verprob_distance14 +
	    (integer)(verprob_aacd15 = 'P85') * verprob_distance15 +
	    (integer)(verprob_aacd16 = 'P85') * verprob_distance16 +
	    (integer)(verprob_aacd17 = 'P85') * verprob_distance17;
	
	verprob_rawscore := verprob_subscore1 +
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
	    verprob_subscore17;
	
	verprob_lnoddsscore := verprob_rawscore + 1.934517;
	
	derog_aacd1 := map(
	    NULL < iv_i60_credit_seeking AND iv_i60_credit_seeking < 1 => 'I60',
	    1 <= iv_i60_credit_seeking                                 => 'I60',
	                                                                  '');
	
	derog_subscore1 := map(
	    NULL < iv_i60_credit_seeking AND iv_i60_credit_seeking < 1 => 0.181668,
	    1 <= iv_i60_credit_seeking                                 => -0.471716,
	                                                                  0.000000);
	
	derog_distance1 := if(derog_aacd1 = '', 0, derog_subscore1 - 0.181668);
	
	derog_aacd2 := map(
	    NULL < rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 86  => 'C21',
	    86 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 171  => 'C21',
	    171 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 271 => 'C21',
	    271 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 328 => 'C21',
	    328 <= rv_c21_m_bureau_adl_fs                                  => 'C21',
	                                                                      '');
	
	derog_subscore2 := map(
	    NULL < rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 86  => -0.520421,
	    86 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 171  => -0.122983,
	    171 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 271 => -0.005177,
	    271 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 328 => 0.138456,
	    328 <= rv_c21_m_bureau_adl_fs                                  => 0.342411,
	                                                                      0.000000);
	
	derog_distance2 := if(derog_aacd2 = '', 0, derog_subscore2 - 0.342411);
	
	derog_aacd3 := map(
	    NULL < iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 1  => 'C13',
	    1 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 13   => 'C13',
	    13 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 69  => 'C13',
	    69 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 207 => 'C13',
	    207 <= iv_c13_inp_addr_lres                               => 'C13',
	                                                                 '');
	
	derog_subscore3 := map(
	    NULL < iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 1  => -0.205980,
	    1 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 13   => -0.027425,
	    13 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 69  => 0.101897,
	    69 <= iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 207 => 0.117724,
	    207 <= iv_c13_inp_addr_lres                               => 0.144410,
	                                                                 0.000000);
	
	derog_distance3 := if(derog_aacd3 = '', 0, derog_subscore3 - 0.144410);
	
	derog_aacd4 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 48  => 'A50',
	    48 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 120  => 'A50',
	    120 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 876 => 'A50',
	    876 <= iv_a50_pb_total_dollars                                   => 'A50',
	                                                                        '');
	
	derog_subscore4 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 48  => -0.050560,
	    48 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 120  => 0.044102,
	    120 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 876 => 0.127986,
	    876 <= iv_a50_pb_total_dollars                                   => 0.213319,
	                                                                        -0.000000);
	
	derog_distance4 := if(derog_aacd4 = '', 0, derog_subscore4 - 0.213319);
	
	derog_subscore5 := map(
	    NULL < iv_d33_eviction_count AND iv_d33_eviction_count < 1 => 0.035910,
	    1 <= iv_d33_eviction_count AND iv_d33_eviction_count < 2   => -0.103661,
	    2 <= iv_d33_eviction_count                                 => -0.242149,
	                                                                  -0.000000);
	
	derog_aacd5 := map(
	    NULL < iv_d33_eviction_count AND iv_d33_eviction_count < 1 => 'D33',
	    1 <= iv_d33_eviction_count AND iv_d33_eviction_count < 2   => 'D33',
	    2 <= iv_d33_eviction_count                                 => 'D33',
	                                                                  '');
	
	derog_distance5 := if(derog_aacd5 = '', 0, derog_subscore5 - 0.035910);
	
	derog_subscore6 := map(
	    NULL < iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 1 => 0.046610,
	    1 <= iv_i60_inq_auto_recency                                   => -0.093669,
	                                                                      0.000000);
	
	derog_aacd6 := map(
	    NULL < iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 1 => 'I60',
	    1 <= iv_i60_inq_auto_recency                                   => 'I60',
	                                                                      '');
	
	derog_distance6 := if(derog_aacd6 = '', 0, derog_subscore6 - 0.046610);
	
	derog_aacd7 := map(
	    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency < 3 => 'D33',
	    3 <= rv_d33_eviction_recency AND rv_d33_eviction_recency < 25  => 'D33',
	    25 <= rv_d33_eviction_recency AND rv_d33_eviction_recency < 61 => 'D33',
	    61 <= rv_d33_eviction_recency                                  => 'D33',
	                                                                      '');
	
	derog_subscore7 := map(
	    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency < 3 => 0.026563,
	    3 <= rv_d33_eviction_recency AND rv_d33_eviction_recency < 25  => -0.253468,
	    25 <= rv_d33_eviction_recency AND rv_d33_eviction_recency < 61 => -0.090757,
	    61 <= rv_d33_eviction_recency                                  => -0.020749,
	                                                                      -0.000000);
	
	derog_distance7 := if(derog_aacd7 = '', 0, derog_subscore7 - 0.026563);
	
	derog_subscore8 := map(
	    NULL < rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 1 => 0.019258,
	    1 <= rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 2   => -0.051122,
	    2 <= rv_c22_stl_inq_count24                                  => -0.312617,
	                                                                    -0.000000);
	
	derog_aacd8 := map(
	    NULL < rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 1 => 'C22',
	    1 <= rv_c22_stl_inq_count24 AND rv_c22_stl_inq_count24 < 2   => 'C22',
	    2 <= rv_c22_stl_inq_count24                                  => 'C22',
	                                                                    '');
	
	derog_distance8 := if(derog_aacd8 = '', 0, derog_subscore8 - 0.019258);
	
	derog_aacd9 := map(
	    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 'D32',
	    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 28  => 'D32',
	    28 <= rv_d32_mos_since_crim_ls                                   => 'D32',
	                                                                        '');
	
	derog_subscore9 := map(
	    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 0 => 0.013808,
	    0 <= rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls < 28  => -0.323727,
	    28 <= rv_d32_mos_since_crim_ls                                   => -0.039679,
	                                                                        0.000000);
	
	derog_distance9 := if(derog_aacd9 = '', 0, derog_subscore9 - 0.013808);
	
	derog_aacd10 := map(
	    NULL < iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 0 => 'C14',
	    0 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 2   => 'C14',
	    2 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 5   => 'C14',
	    5 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 8   => 'C14',
	    8 <= iv_c14_addrs_10yr                             => 'C14',
	                                                          '');
	
	derog_subscore10 := map(
	    NULL < iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 0 => 0.000000,
	    0 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 2   => 0.128884,
	    2 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 5   => 0.011241,
	    5 <= iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 8   => -0.037531,
	    8 <= iv_c14_addrs_10yr                             => -0.091232,
	                                                          0.000000);
	
	derog_distance10 := if(derog_aacd10 = '', 0, derog_subscore10 - 0.128884);
	
	derog_subscore11 := map(
	    (iv_d32_criminal_x_felony in ['0-0'])                                    => 0.016400,
	    (iv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => -0.130741,
	    (iv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.240499,
	                                                                                0.000000);
	
	derog_aacd11 := map(
	    (iv_d32_criminal_x_felony in ['0-0'])                                    => 'D32',
	    (iv_d32_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => 'D32',
	    (iv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                '');
	
	derog_distance11 := if(derog_aacd11 = '', 0, derog_subscore11 - 0.016400);
	
	derog_subscore12 := map(
	    NULL < rv_a42_prop_owner_inp_only AND rv_a42_prop_owner_inp_only < 1 => -0.032949,
	    1 <= rv_a42_prop_owner_inp_only                                      => 0.074063,
	                                                                            0.000000);
	
	derog_aacd12 := map(
	    NULL < rv_a42_prop_owner_inp_only AND rv_a42_prop_owner_inp_only < 1 => 'A41',
	    1 <= rv_a42_prop_owner_inp_only                                      => 'A41',
	                                                                            '');
	
	derog_distance12 := if(derog_aacd12 = '', 0, derog_subscore12 - 0.074063);
	
	derog_aacd13 := map(
	    (iv_f07_input_add_not_most_rec in [' ', '0']) => 'F03',
	    (iv_f07_input_add_not_most_rec in ['1'])      => 'F03',
	                                                     '');
	
	derog_subscore13 := map(
	    (iv_f07_input_add_not_most_rec in [' ', '0']) => 0.018075,
	    (iv_f07_input_add_not_most_rec in ['1'])      => -0.114597,
	                                                     0.000000);
	
	derog_distance13 := if(derog_aacd13 = '', 0, derog_subscore13 - 0.018075);
	
	derog_subscore14 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 0.053683,
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0'])                                           => -0.037676,
	                                                                                                     0.000000);
	
	derog_aacd14 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-1', '2-2', '3-1', '3-2']) => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['1-0', '2-0', '3-0'])                                           => 'D34',
	                                                                                                     '');
	
	derog_distance14 := if(derog_aacd14 = '', 0, derog_subscore14 - 0.053683);
	
	derog_aacd15 := map(
	    NULL < rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 1 => 'C14',
	    1 <= rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 2   => 'C14',
	    2 <= rv_c14_addrs_per_adl_c6                                   => 'C14',
	                                                                      '');
	
	derog_subscore15 := map(
	    NULL < rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 1 => 0.029154,
	    1 <= rv_c14_addrs_per_adl_c6 AND rv_c14_addrs_per_adl_c6 < 2   => -0.035838,
	    2 <= rv_c14_addrs_per_adl_c6                                   => -0.112509,
	                                                                      0.000000);
	
	derog_distance15 := if(derog_aacd15 = '', 0, derog_subscore15 - 0.029154);
	
	derog_subscore16 := map(
	    (rv_e55_college_ind_shell5 in ['0']) => -0.005687,
	    (rv_e55_college_ind_shell5 in ['1']) => 0.060526,
	                                            0.000000);
	
	derog_aacd16 := map(
	    (rv_e55_college_ind_shell5 in ['0']) => 'E55',
	    (rv_e55_college_ind_shell5 in ['1']) => 'E55',
	                                            '');
	
	derog_distance16 := if(derog_aacd16 = '', 0, derog_subscore16 - 0.060526);
	
	derog_aacd17 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	derog_subscore17 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.037151,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.020341,
	    3 <= rv_s66_adlperssn_count                                  => -0.077846,
	                                                                    0.000000);
	
	derog_distance17 := if(derog_aacd17 = '', 0, derog_subscore17 - 0.037151);
	
	derog_subscore18 := map(
	    (rv_c22_stl_recency in ['0'])                  => 0.016769,
	    (rv_c22_stl_recency in ['12', '24', '3', '6']) => -0.085919,
	                                                      0.000000);
	
	derog_aacd18 := map(
	    (rv_c22_stl_recency in ['0'])                  => 'C22',
	    (rv_c22_stl_recency in ['12', '24', '3', '6']) => 'C22',
	                                                      '');
	
	derog_distance18 := if(derog_aacd18 = '', 0, derog_subscore18 - 0.016769);
	
	derog_subscore19 := map(
	    NULL < iv_d34_unrel_liens_ct AND iv_d34_unrel_liens_ct < 4 => 0.012473,
	    4 <= iv_d34_unrel_liens_ct                                 => -0.097109,
	                                                                  -0.000000);
	
	derog_aacd19 := map(
	    NULL < iv_d34_unrel_liens_ct AND iv_d34_unrel_liens_ct < 4 => 'D34',
	    4 <= iv_d34_unrel_liens_ct                                 => 'D34',
	                                                                  '');
	
	derog_distance19 := if(derog_aacd19 = '', 0, derog_subscore19 - 0.012473);
	
	derog_subscore20 := map(
	    NULL < rv_a42_prop_owner AND rv_a42_prop_owner < 1 => -0.017824,
	    1 <= rv_a42_prop_owner                             => 0.033968,
	                                                          0.000000);
	
	derog_aacd20 := map(
	    NULL < rv_a42_prop_owner AND rv_a42_prop_owner < 1 => 'A41',
	    1 <= rv_a42_prop_owner                             => 'A41',
	                                                          '');
	
	derog_distance20 := if(derog_aacd20 = '', 0, derog_subscore20 - 0.033968);
	
	derog_subscore21 := map(
	    (iv_l77_dwelltype in [' ', 'GEN', 'POB', 'RR', 'SFD']) => 0.010954,
	    (iv_l77_dwelltype in ['MFD'])                          => -0.049524,
	                                                              0.000000);
	
	derog_aacd21 := map(
	    (iv_l77_dwelltype in [' ', 'GEN', 'POB', 'RR', 'SFD']) => 'L77',
	    (iv_l77_dwelltype in ['MFD'])                          => 'L77',
	                                                              '');
	
	derog_distance21 := if(derog_aacd21 = '', 0, derog_subscore21 - 0.010954);
	
	derog_subscore22 := map(
	    (iv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 0.130051,
	    (iv_a43_rec_vehx_level in ['XX'])                         => -0.003591,
	                                                                 -0.000000);
	
	derog_aacd22 := map(
	    (iv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 'A43',
	    (iv_a43_rec_vehx_level in ['XX'])                         => 'A43',
	                                                                 '');
	
	derog_distance22 := if(derog_aacd22 = '', 0, derog_subscore22 - 0.130051);
	
	derog_aacd23 := map(
	    (iv_e57_prof_license_flag in ['0']) => 'E57',
	    (iv_e57_prof_license_flag in ['1']) => 'E57',
	                                           '');
	
	derog_subscore23 := map(
	    (iv_e57_prof_license_flag in ['0']) => -0.004998,
	    (iv_e57_prof_license_flag in ['1']) => 0.074668,
	                                           0.000000);
	
	derog_distance23 := if(derog_aacd23 = '', 0, derog_subscore23 - 0.074668);
	
	derog_subscore24 := map(
	    NULL < rv_c22_stl_inq_count12 AND rv_c22_stl_inq_count12 < 1 => 0.004843,
	    1 <= rv_c22_stl_inq_count12                                  => -0.060955,
	                                                                    0.000000);
	
	derog_aacd24 := map(
	    NULL < rv_c22_stl_inq_count12 AND rv_c22_stl_inq_count12 < 1 => 'C22',
	    1 <= rv_c22_stl_inq_count12                                  => 'C22',
	                                                                    '');
	
	derog_distance24 := if(derog_aacd24 = '', 0, derog_subscore24 - 0.004843);
	
	derog_rcvaluea41 := (integer)(derog_aacd1 = 'A41') * derog_distance1 +
	    (integer)(derog_aacd2 = 'A41') * derog_distance2 +
	    (integer)(derog_aacd3 = 'A41') * derog_distance3 +
	    (integer)(derog_aacd4 = 'A41') * derog_distance4 +
	    (integer)(derog_aacd5 = 'A41') * derog_distance5 +
	    (integer)(derog_aacd6 = 'A41') * derog_distance6 +
	    (integer)(derog_aacd7 = 'A41') * derog_distance7 +
	    (integer)(derog_aacd8 = 'A41') * derog_distance8 +
	    (integer)(derog_aacd9 = 'A41') * derog_distance9 +
	    (integer)(derog_aacd10 = 'A41') * derog_distance10 +
	    (integer)(derog_aacd11 = 'A41') * derog_distance11 +
	    (integer)(derog_aacd12 = 'A41') * derog_distance12 +
	    (integer)(derog_aacd13 = 'A41') * derog_distance13 +
	    (integer)(derog_aacd14 = 'A41') * derog_distance14 +
	    (integer)(derog_aacd15 = 'A41') * derog_distance15 +
	    (integer)(derog_aacd16 = 'A41') * derog_distance16 +
	    (integer)(derog_aacd17 = 'A41') * derog_distance17 +
	    (integer)(derog_aacd18 = 'A41') * derog_distance18 +
	    (integer)(derog_aacd19 = 'A41') * derog_distance19 +
	    (integer)(derog_aacd20 = 'A41') * derog_distance20 +
	    (integer)(derog_aacd21 = 'A41') * derog_distance21 +
	    (integer)(derog_aacd22 = 'A41') * derog_distance22 +
	    (integer)(derog_aacd23 = 'A41') * derog_distance23 +
	    (integer)(derog_aacd24 = 'A41') * derog_distance24;
	
	derog_rcvaluea43 := (integer)(derog_aacd1 = 'A43') * derog_distance1 +
	    (integer)(derog_aacd2 = 'A43') * derog_distance2 +
	    (integer)(derog_aacd3 = 'A43') * derog_distance3 +
	    (integer)(derog_aacd4 = 'A43') * derog_distance4 +
	    (integer)(derog_aacd5 = 'A43') * derog_distance5 +
	    (integer)(derog_aacd6 = 'A43') * derog_distance6 +
	    (integer)(derog_aacd7 = 'A43') * derog_distance7 +
	    (integer)(derog_aacd8 = 'A43') * derog_distance8 +
	    (integer)(derog_aacd9 = 'A43') * derog_distance9 +
	    (integer)(derog_aacd10 = 'A43') * derog_distance10 +
	    (integer)(derog_aacd11 = 'A43') * derog_distance11 +
	    (integer)(derog_aacd12 = 'A43') * derog_distance12 +
	    (integer)(derog_aacd13 = 'A43') * derog_distance13 +
	    (integer)(derog_aacd14 = 'A43') * derog_distance14 +
	    (integer)(derog_aacd15 = 'A43') * derog_distance15 +
	    (integer)(derog_aacd16 = 'A43') * derog_distance16 +
	    (integer)(derog_aacd17 = 'A43') * derog_distance17 +
	    (integer)(derog_aacd18 = 'A43') * derog_distance18 +
	    (integer)(derog_aacd19 = 'A43') * derog_distance19 +
	    (integer)(derog_aacd20 = 'A43') * derog_distance20 +
	    (integer)(derog_aacd21 = 'A43') * derog_distance21 +
	    (integer)(derog_aacd22 = 'A43') * derog_distance22 +
	    (integer)(derog_aacd23 = 'A43') * derog_distance23 +
	    (integer)(derog_aacd24 = 'A43') * derog_distance24;
	
	derog_rcvaluea50 := (integer)(derog_aacd1 = 'A50') * derog_distance1 +
	    (integer)(derog_aacd2 = 'A50') * derog_distance2 +
	    (integer)(derog_aacd3 = 'A50') * derog_distance3 +
	    (integer)(derog_aacd4 = 'A50') * derog_distance4 +
	    (integer)(derog_aacd5 = 'A50') * derog_distance5 +
	    (integer)(derog_aacd6 = 'A50') * derog_distance6 +
	    (integer)(derog_aacd7 = 'A50') * derog_distance7 +
	    (integer)(derog_aacd8 = 'A50') * derog_distance8 +
	    (integer)(derog_aacd9 = 'A50') * derog_distance9 +
	    (integer)(derog_aacd10 = 'A50') * derog_distance10 +
	    (integer)(derog_aacd11 = 'A50') * derog_distance11 +
	    (integer)(derog_aacd12 = 'A50') * derog_distance12 +
	    (integer)(derog_aacd13 = 'A50') * derog_distance13 +
	    (integer)(derog_aacd14 = 'A50') * derog_distance14 +
	    (integer)(derog_aacd15 = 'A50') * derog_distance15 +
	    (integer)(derog_aacd16 = 'A50') * derog_distance16 +
	    (integer)(derog_aacd17 = 'A50') * derog_distance17 +
	    (integer)(derog_aacd18 = 'A50') * derog_distance18 +
	    (integer)(derog_aacd19 = 'A50') * derog_distance19 +
	    (integer)(derog_aacd20 = 'A50') * derog_distance20 +
	    (integer)(derog_aacd21 = 'A50') * derog_distance21 +
	    (integer)(derog_aacd22 = 'A50') * derog_distance22 +
	    (integer)(derog_aacd23 = 'A50') * derog_distance23 +
	    (integer)(derog_aacd24 = 'A50') * derog_distance24;
	
	derog_rcvaluec13 := (integer)(derog_aacd1 = 'C13') * derog_distance1 +
	    (integer)(derog_aacd2 = 'C13') * derog_distance2 +
	    (integer)(derog_aacd3 = 'C13') * derog_distance3 +
	    (integer)(derog_aacd4 = 'C13') * derog_distance4 +
	    (integer)(derog_aacd5 = 'C13') * derog_distance5 +
	    (integer)(derog_aacd6 = 'C13') * derog_distance6 +
	    (integer)(derog_aacd7 = 'C13') * derog_distance7 +
	    (integer)(derog_aacd8 = 'C13') * derog_distance8 +
	    (integer)(derog_aacd9 = 'C13') * derog_distance9 +
	    (integer)(derog_aacd10 = 'C13') * derog_distance10 +
	    (integer)(derog_aacd11 = 'C13') * derog_distance11 +
	    (integer)(derog_aacd12 = 'C13') * derog_distance12 +
	    (integer)(derog_aacd13 = 'C13') * derog_distance13 +
	    (integer)(derog_aacd14 = 'C13') * derog_distance14 +
	    (integer)(derog_aacd15 = 'C13') * derog_distance15 +
	    (integer)(derog_aacd16 = 'C13') * derog_distance16 +
	    (integer)(derog_aacd17 = 'C13') * derog_distance17 +
	    (integer)(derog_aacd18 = 'C13') * derog_distance18 +
	    (integer)(derog_aacd19 = 'C13') * derog_distance19 +
	    (integer)(derog_aacd20 = 'C13') * derog_distance20 +
	    (integer)(derog_aacd21 = 'C13') * derog_distance21 +
	    (integer)(derog_aacd22 = 'C13') * derog_distance22 +
	    (integer)(derog_aacd23 = 'C13') * derog_distance23 +
	    (integer)(derog_aacd24 = 'C13') * derog_distance24;
	
	derog_rcvaluec14 := (integer)(derog_aacd1 = 'C14') * derog_distance1 +
	    (integer)(derog_aacd2 = 'C14') * derog_distance2 +
	    (integer)(derog_aacd3 = 'C14') * derog_distance3 +
	    (integer)(derog_aacd4 = 'C14') * derog_distance4 +
	    (integer)(derog_aacd5 = 'C14') * derog_distance5 +
	    (integer)(derog_aacd6 = 'C14') * derog_distance6 +
	    (integer)(derog_aacd7 = 'C14') * derog_distance7 +
	    (integer)(derog_aacd8 = 'C14') * derog_distance8 +
	    (integer)(derog_aacd9 = 'C14') * derog_distance9 +
	    (integer)(derog_aacd10 = 'C14') * derog_distance10 +
	    (integer)(derog_aacd11 = 'C14') * derog_distance11 +
	    (integer)(derog_aacd12 = 'C14') * derog_distance12 +
	    (integer)(derog_aacd13 = 'C14') * derog_distance13 +
	    (integer)(derog_aacd14 = 'C14') * derog_distance14 +
	    (integer)(derog_aacd15 = 'C14') * derog_distance15 +
	    (integer)(derog_aacd16 = 'C14') * derog_distance16 +
	    (integer)(derog_aacd17 = 'C14') * derog_distance17 +
	    (integer)(derog_aacd18 = 'C14') * derog_distance18 +
	    (integer)(derog_aacd19 = 'C14') * derog_distance19 +
	    (integer)(derog_aacd20 = 'C14') * derog_distance20 +
	    (integer)(derog_aacd21 = 'C14') * derog_distance21 +
	    (integer)(derog_aacd22 = 'C14') * derog_distance22 +
	    (integer)(derog_aacd23 = 'C14') * derog_distance23 +
	    (integer)(derog_aacd24 = 'C14') * derog_distance24;
	
	derog_rcvaluec21 := (integer)(derog_aacd1 = 'C21') * derog_distance1 +
	    (integer)(derog_aacd2 = 'C21') * derog_distance2 +
	    (integer)(derog_aacd3 = 'C21') * derog_distance3 +
	    (integer)(derog_aacd4 = 'C21') * derog_distance4 +
	    (integer)(derog_aacd5 = 'C21') * derog_distance5 +
	    (integer)(derog_aacd6 = 'C21') * derog_distance6 +
	    (integer)(derog_aacd7 = 'C21') * derog_distance7 +
	    (integer)(derog_aacd8 = 'C21') * derog_distance8 +
	    (integer)(derog_aacd9 = 'C21') * derog_distance9 +
	    (integer)(derog_aacd10 = 'C21') * derog_distance10 +
	    (integer)(derog_aacd11 = 'C21') * derog_distance11 +
	    (integer)(derog_aacd12 = 'C21') * derog_distance12 +
	    (integer)(derog_aacd13 = 'C21') * derog_distance13 +
	    (integer)(derog_aacd14 = 'C21') * derog_distance14 +
	    (integer)(derog_aacd15 = 'C21') * derog_distance15 +
	    (integer)(derog_aacd16 = 'C21') * derog_distance16 +
	    (integer)(derog_aacd17 = 'C21') * derog_distance17 +
	    (integer)(derog_aacd18 = 'C21') * derog_distance18 +
	    (integer)(derog_aacd19 = 'C21') * derog_distance19 +
	    (integer)(derog_aacd20 = 'C21') * derog_distance20 +
	    (integer)(derog_aacd21 = 'C21') * derog_distance21 +
	    (integer)(derog_aacd22 = 'C21') * derog_distance22 +
	    (integer)(derog_aacd23 = 'C21') * derog_distance23 +
	    (integer)(derog_aacd24 = 'C21') * derog_distance24;
	
	derog_rcvaluec22 := (integer)(derog_aacd1 = 'C22') * derog_distance1 +
	    (integer)(derog_aacd2 = 'C22') * derog_distance2 +
	    (integer)(derog_aacd3 = 'C22') * derog_distance3 +
	    (integer)(derog_aacd4 = 'C22') * derog_distance4 +
	    (integer)(derog_aacd5 = 'C22') * derog_distance5 +
	    (integer)(derog_aacd6 = 'C22') * derog_distance6 +
	    (integer)(derog_aacd7 = 'C22') * derog_distance7 +
	    (integer)(derog_aacd8 = 'C22') * derog_distance8 +
	    (integer)(derog_aacd9 = 'C22') * derog_distance9 +
	    (integer)(derog_aacd10 = 'C22') * derog_distance10 +
	    (integer)(derog_aacd11 = 'C22') * derog_distance11 +
	    (integer)(derog_aacd12 = 'C22') * derog_distance12 +
	    (integer)(derog_aacd13 = 'C22') * derog_distance13 +
	    (integer)(derog_aacd14 = 'C22') * derog_distance14 +
	    (integer)(derog_aacd15 = 'C22') * derog_distance15 +
	    (integer)(derog_aacd16 = 'C22') * derog_distance16 +
	    (integer)(derog_aacd17 = 'C22') * derog_distance17 +
	    (integer)(derog_aacd18 = 'C22') * derog_distance18 +
	    (integer)(derog_aacd19 = 'C22') * derog_distance19 +
	    (integer)(derog_aacd20 = 'C22') * derog_distance20 +
	    (integer)(derog_aacd21 = 'C22') * derog_distance21 +
	    (integer)(derog_aacd22 = 'C22') * derog_distance22 +
	    (integer)(derog_aacd23 = 'C22') * derog_distance23 +
	    (integer)(derog_aacd24 = 'C22') * derog_distance24;
	
	derog_rcvalued32 := (integer)(derog_aacd1 = 'D32') * derog_distance1 +
	    (integer)(derog_aacd2 = 'D32') * derog_distance2 +
	    (integer)(derog_aacd3 = 'D32') * derog_distance3 +
	    (integer)(derog_aacd4 = 'D32') * derog_distance4 +
	    (integer)(derog_aacd5 = 'D32') * derog_distance5 +
	    (integer)(derog_aacd6 = 'D32') * derog_distance6 +
	    (integer)(derog_aacd7 = 'D32') * derog_distance7 +
	    (integer)(derog_aacd8 = 'D32') * derog_distance8 +
	    (integer)(derog_aacd9 = 'D32') * derog_distance9 +
	    (integer)(derog_aacd10 = 'D32') * derog_distance10 +
	    (integer)(derog_aacd11 = 'D32') * derog_distance11 +
	    (integer)(derog_aacd12 = 'D32') * derog_distance12 +
	    (integer)(derog_aacd13 = 'D32') * derog_distance13 +
	    (integer)(derog_aacd14 = 'D32') * derog_distance14 +
	    (integer)(derog_aacd15 = 'D32') * derog_distance15 +
	    (integer)(derog_aacd16 = 'D32') * derog_distance16 +
	    (integer)(derog_aacd17 = 'D32') * derog_distance17 +
	    (integer)(derog_aacd18 = 'D32') * derog_distance18 +
	    (integer)(derog_aacd19 = 'D32') * derog_distance19 +
	    (integer)(derog_aacd20 = 'D32') * derog_distance20 +
	    (integer)(derog_aacd21 = 'D32') * derog_distance21 +
	    (integer)(derog_aacd22 = 'D32') * derog_distance22 +
	    (integer)(derog_aacd23 = 'D32') * derog_distance23 +
	    (integer)(derog_aacd24 = 'D32') * derog_distance24;
	
	derog_rcvalued33 := (integer)(derog_aacd1 = 'D33') * derog_distance1 +
	    (integer)(derog_aacd2 = 'D33') * derog_distance2 +
	    (integer)(derog_aacd3 = 'D33') * derog_distance3 +
	    (integer)(derog_aacd4 = 'D33') * derog_distance4 +
	    (integer)(derog_aacd5 = 'D33') * derog_distance5 +
	    (integer)(derog_aacd6 = 'D33') * derog_distance6 +
	    (integer)(derog_aacd7 = 'D33') * derog_distance7 +
	    (integer)(derog_aacd8 = 'D33') * derog_distance8 +
	    (integer)(derog_aacd9 = 'D33') * derog_distance9 +
	    (integer)(derog_aacd10 = 'D33') * derog_distance10 +
	    (integer)(derog_aacd11 = 'D33') * derog_distance11 +
	    (integer)(derog_aacd12 = 'D33') * derog_distance12 +
	    (integer)(derog_aacd13 = 'D33') * derog_distance13 +
	    (integer)(derog_aacd14 = 'D33') * derog_distance14 +
	    (integer)(derog_aacd15 = 'D33') * derog_distance15 +
	    (integer)(derog_aacd16 = 'D33') * derog_distance16 +
	    (integer)(derog_aacd17 = 'D33') * derog_distance17 +
	    (integer)(derog_aacd18 = 'D33') * derog_distance18 +
	    (integer)(derog_aacd19 = 'D33') * derog_distance19 +
	    (integer)(derog_aacd20 = 'D33') * derog_distance20 +
	    (integer)(derog_aacd21 = 'D33') * derog_distance21 +
	    (integer)(derog_aacd22 = 'D33') * derog_distance22 +
	    (integer)(derog_aacd23 = 'D33') * derog_distance23 +
	    (integer)(derog_aacd24 = 'D33') * derog_distance24;
	
	derog_rcvalued34 := (integer)(derog_aacd1 = 'D34') * derog_distance1 +
	    (integer)(derog_aacd2 = 'D34') * derog_distance2 +
	    (integer)(derog_aacd3 = 'D34') * derog_distance3 +
	    (integer)(derog_aacd4 = 'D34') * derog_distance4 +
	    (integer)(derog_aacd5 = 'D34') * derog_distance5 +
	    (integer)(derog_aacd6 = 'D34') * derog_distance6 +
	    (integer)(derog_aacd7 = 'D34') * derog_distance7 +
	    (integer)(derog_aacd8 = 'D34') * derog_distance8 +
	    (integer)(derog_aacd9 = 'D34') * derog_distance9 +
	    (integer)(derog_aacd10 = 'D34') * derog_distance10 +
	    (integer)(derog_aacd11 = 'D34') * derog_distance11 +
	    (integer)(derog_aacd12 = 'D34') * derog_distance12 +
	    (integer)(derog_aacd13 = 'D34') * derog_distance13 +
	    (integer)(derog_aacd14 = 'D34') * derog_distance14 +
	    (integer)(derog_aacd15 = 'D34') * derog_distance15 +
	    (integer)(derog_aacd16 = 'D34') * derog_distance16 +
	    (integer)(derog_aacd17 = 'D34') * derog_distance17 +
	    (integer)(derog_aacd18 = 'D34') * derog_distance18 +
	    (integer)(derog_aacd19 = 'D34') * derog_distance19 +
	    (integer)(derog_aacd20 = 'D34') * derog_distance20 +
	    (integer)(derog_aacd21 = 'D34') * derog_distance21 +
	    (integer)(derog_aacd22 = 'D34') * derog_distance22 +
	    (integer)(derog_aacd23 = 'D34') * derog_distance23 +
	    (integer)(derog_aacd24 = 'D34') * derog_distance24;
	
	derog_rcvaluee55 := (integer)(derog_aacd1 = 'E55') * derog_distance1 +
	    (integer)(derog_aacd2 = 'E55') * derog_distance2 +
	    (integer)(derog_aacd3 = 'E55') * derog_distance3 +
	    (integer)(derog_aacd4 = 'E55') * derog_distance4 +
	    (integer)(derog_aacd5 = 'E55') * derog_distance5 +
	    (integer)(derog_aacd6 = 'E55') * derog_distance6 +
	    (integer)(derog_aacd7 = 'E55') * derog_distance7 +
	    (integer)(derog_aacd8 = 'E55') * derog_distance8 +
	    (integer)(derog_aacd9 = 'E55') * derog_distance9 +
	    (integer)(derog_aacd10 = 'E55') * derog_distance10 +
	    (integer)(derog_aacd11 = 'E55') * derog_distance11 +
	    (integer)(derog_aacd12 = 'E55') * derog_distance12 +
	    (integer)(derog_aacd13 = 'E55') * derog_distance13 +
	    (integer)(derog_aacd14 = 'E55') * derog_distance14 +
	    (integer)(derog_aacd15 = 'E55') * derog_distance15 +
	    (integer)(derog_aacd16 = 'E55') * derog_distance16 +
	    (integer)(derog_aacd17 = 'E55') * derog_distance17 +
	    (integer)(derog_aacd18 = 'E55') * derog_distance18 +
	    (integer)(derog_aacd19 = 'E55') * derog_distance19 +
	    (integer)(derog_aacd20 = 'E55') * derog_distance20 +
	    (integer)(derog_aacd21 = 'E55') * derog_distance21 +
	    (integer)(derog_aacd22 = 'E55') * derog_distance22 +
	    (integer)(derog_aacd23 = 'E55') * derog_distance23 +
	    (integer)(derog_aacd24 = 'E55') * derog_distance24;
	
	derog_rcvaluee57 := (integer)(derog_aacd1 = 'E57') * derog_distance1 +
	    (integer)(derog_aacd2 = 'E57') * derog_distance2 +
	    (integer)(derog_aacd3 = 'E57') * derog_distance3 +
	    (integer)(derog_aacd4 = 'E57') * derog_distance4 +
	    (integer)(derog_aacd5 = 'E57') * derog_distance5 +
	    (integer)(derog_aacd6 = 'E57') * derog_distance6 +
	    (integer)(derog_aacd7 = 'E57') * derog_distance7 +
	    (integer)(derog_aacd8 = 'E57') * derog_distance8 +
	    (integer)(derog_aacd9 = 'E57') * derog_distance9 +
	    (integer)(derog_aacd10 = 'E57') * derog_distance10 +
	    (integer)(derog_aacd11 = 'E57') * derog_distance11 +
	    (integer)(derog_aacd12 = 'E57') * derog_distance12 +
	    (integer)(derog_aacd13 = 'E57') * derog_distance13 +
	    (integer)(derog_aacd14 = 'E57') * derog_distance14 +
	    (integer)(derog_aacd15 = 'E57') * derog_distance15 +
	    (integer)(derog_aacd16 = 'E57') * derog_distance16 +
	    (integer)(derog_aacd17 = 'E57') * derog_distance17 +
	    (integer)(derog_aacd18 = 'E57') * derog_distance18 +
	    (integer)(derog_aacd19 = 'E57') * derog_distance19 +
	    (integer)(derog_aacd20 = 'E57') * derog_distance20 +
	    (integer)(derog_aacd21 = 'E57') * derog_distance21 +
	    (integer)(derog_aacd22 = 'E57') * derog_distance22 +
	    (integer)(derog_aacd23 = 'E57') * derog_distance23 +
	    (integer)(derog_aacd24 = 'E57') * derog_distance24;
	
	derog_rcvaluef03 := (integer)(derog_aacd1 = 'F03') * derog_distance1 +
	    (integer)(derog_aacd2 = 'F03') * derog_distance2 +
	    (integer)(derog_aacd3 = 'F03') * derog_distance3 +
	    (integer)(derog_aacd4 = 'F03') * derog_distance4 +
	    (integer)(derog_aacd5 = 'F03') * derog_distance5 +
	    (integer)(derog_aacd6 = 'F03') * derog_distance6 +
	    (integer)(derog_aacd7 = 'F03') * derog_distance7 +
	    (integer)(derog_aacd8 = 'F03') * derog_distance8 +
	    (integer)(derog_aacd9 = 'F03') * derog_distance9 +
	    (integer)(derog_aacd10 = 'F03') * derog_distance10 +
	    (integer)(derog_aacd11 = 'F03') * derog_distance11 +
	    (integer)(derog_aacd12 = 'F03') * derog_distance12 +
	    (integer)(derog_aacd13 = 'F03') * derog_distance13 +
	    (integer)(derog_aacd14 = 'F03') * derog_distance14 +
	    (integer)(derog_aacd15 = 'F03') * derog_distance15 +
	    (integer)(derog_aacd16 = 'F03') * derog_distance16 +
	    (integer)(derog_aacd17 = 'F03') * derog_distance17 +
	    (integer)(derog_aacd18 = 'F03') * derog_distance18 +
	    (integer)(derog_aacd19 = 'F03') * derog_distance19 +
	    (integer)(derog_aacd20 = 'F03') * derog_distance20 +
	    (integer)(derog_aacd21 = 'F03') * derog_distance21 +
	    (integer)(derog_aacd22 = 'F03') * derog_distance22 +
	    (integer)(derog_aacd23 = 'F03') * derog_distance23 +
	    (integer)(derog_aacd24 = 'F03') * derog_distance24;
	
	derog_rcvaluei60 := (integer)(derog_aacd1 = 'I60') * derog_distance1 +
	    (integer)(derog_aacd2 = 'I60') * derog_distance2 +
	    (integer)(derog_aacd3 = 'I60') * derog_distance3 +
	    (integer)(derog_aacd4 = 'I60') * derog_distance4 +
	    (integer)(derog_aacd5 = 'I60') * derog_distance5 +
	    (integer)(derog_aacd6 = 'I60') * derog_distance6 +
	    (integer)(derog_aacd7 = 'I60') * derog_distance7 +
	    (integer)(derog_aacd8 = 'I60') * derog_distance8 +
	    (integer)(derog_aacd9 = 'I60') * derog_distance9 +
	    (integer)(derog_aacd10 = 'I60') * derog_distance10 +
	    (integer)(derog_aacd11 = 'I60') * derog_distance11 +
	    (integer)(derog_aacd12 = 'I60') * derog_distance12 +
	    (integer)(derog_aacd13 = 'I60') * derog_distance13 +
	    (integer)(derog_aacd14 = 'I60') * derog_distance14 +
	    (integer)(derog_aacd15 = 'I60') * derog_distance15 +
	    (integer)(derog_aacd16 = 'I60') * derog_distance16 +
	    (integer)(derog_aacd17 = 'I60') * derog_distance17 +
	    (integer)(derog_aacd18 = 'I60') * derog_distance18 +
	    (integer)(derog_aacd19 = 'I60') * derog_distance19 +
	    (integer)(derog_aacd20 = 'I60') * derog_distance20 +
	    (integer)(derog_aacd21 = 'I60') * derog_distance21 +
	    (integer)(derog_aacd22 = 'I60') * derog_distance22 +
	    (integer)(derog_aacd23 = 'I60') * derog_distance23 +
	    (integer)(derog_aacd24 = 'I60') * derog_distance24;
	
	derog_rcvaluel77 := (integer)(derog_aacd1 = 'L77') * derog_distance1 +
	    (integer)(derog_aacd2 = 'L77') * derog_distance2 +
	    (integer)(derog_aacd3 = 'L77') * derog_distance3 +
	    (integer)(derog_aacd4 = 'L77') * derog_distance4 +
	    (integer)(derog_aacd5 = 'L77') * derog_distance5 +
	    (integer)(derog_aacd6 = 'L77') * derog_distance6 +
	    (integer)(derog_aacd7 = 'L77') * derog_distance7 +
	    (integer)(derog_aacd8 = 'L77') * derog_distance8 +
	    (integer)(derog_aacd9 = 'L77') * derog_distance9 +
	    (integer)(derog_aacd10 = 'L77') * derog_distance10 +
	    (integer)(derog_aacd11 = 'L77') * derog_distance11 +
	    (integer)(derog_aacd12 = 'L77') * derog_distance12 +
	    (integer)(derog_aacd13 = 'L77') * derog_distance13 +
	    (integer)(derog_aacd14 = 'L77') * derog_distance14 +
	    (integer)(derog_aacd15 = 'L77') * derog_distance15 +
	    (integer)(derog_aacd16 = 'L77') * derog_distance16 +
	    (integer)(derog_aacd17 = 'L77') * derog_distance17 +
	    (integer)(derog_aacd18 = 'L77') * derog_distance18 +
	    (integer)(derog_aacd19 = 'L77') * derog_distance19 +
	    (integer)(derog_aacd20 = 'L77') * derog_distance20 +
	    (integer)(derog_aacd21 = 'L77') * derog_distance21 +
	    (integer)(derog_aacd22 = 'L77') * derog_distance22 +
	    (integer)(derog_aacd23 = 'L77') * derog_distance23 +
	    (integer)(derog_aacd24 = 'L77') * derog_distance24;
	
	derog_rcvalues66 := (integer)(derog_aacd1 = 'S66') * derog_distance1 +
	    (integer)(derog_aacd2 = 'S66') * derog_distance2 +
	    (integer)(derog_aacd3 = 'S66') * derog_distance3 +
	    (integer)(derog_aacd4 = 'S66') * derog_distance4 +
	    (integer)(derog_aacd5 = 'S66') * derog_distance5 +
	    (integer)(derog_aacd6 = 'S66') * derog_distance6 +
	    (integer)(derog_aacd7 = 'S66') * derog_distance7 +
	    (integer)(derog_aacd8 = 'S66') * derog_distance8 +
	    (integer)(derog_aacd9 = 'S66') * derog_distance9 +
	    (integer)(derog_aacd10 = 'S66') * derog_distance10 +
	    (integer)(derog_aacd11 = 'S66') * derog_distance11 +
	    (integer)(derog_aacd12 = 'S66') * derog_distance12 +
	    (integer)(derog_aacd13 = 'S66') * derog_distance13 +
	    (integer)(derog_aacd14 = 'S66') * derog_distance14 +
	    (integer)(derog_aacd15 = 'S66') * derog_distance15 +
	    (integer)(derog_aacd16 = 'S66') * derog_distance16 +
	    (integer)(derog_aacd17 = 'S66') * derog_distance17 +
	    (integer)(derog_aacd18 = 'S66') * derog_distance18 +
	    (integer)(derog_aacd19 = 'S66') * derog_distance19 +
	    (integer)(derog_aacd20 = 'S66') * derog_distance20 +
	    (integer)(derog_aacd21 = 'S66') * derog_distance21 +
	    (integer)(derog_aacd22 = 'S66') * derog_distance22 +
	    (integer)(derog_aacd23 = 'S66') * derog_distance23 +
	    (integer)(derog_aacd24 = 'S66') * derog_distance24;
	
	derog_rawscore := derog_subscore1 +
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
	    derog_subscore21 +
	    derog_subscore22 +
	    derog_subscore23 +
	    derog_subscore24;
	
	derog_lnoddsscore := derog_rawscore + 1.963140;
	
	owner_aacd1 := map(
	    NULL < iv_i60_credit_seeking AND iv_i60_credit_seeking < 1 => 'I60',
	    1 <= iv_i60_credit_seeking AND iv_i60_credit_seeking < 2   => 'I60',
	    2 <= iv_i60_credit_seeking                                 => 'I60',
	                                                                  '');
	
	owner_subscore1 := map(
	    NULL < iv_i60_credit_seeking AND iv_i60_credit_seeking < 1 => 0.147467,
	    1 <= iv_i60_credit_seeking AND iv_i60_credit_seeking < 2   => -0.351949,
	    2 <= iv_i60_credit_seeking                                 => -0.386186,
	                                                                  0.000000);
	
	owner_distance1 := if(owner_aacd1 = '', 0, owner_subscore1 - 0.147467);
	
	owner_aacd2 := map(
	    // NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 2936      => 'A51',
	    NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval <= 0     	 => 'A51',
	    // 2936 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 75297    => 'L80',
	    0 < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 75297    		 => 'L80',
	    75297 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 129735  => 'L80',
	    129735 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 202918 => 'L80',
	    202918 <= rv_a47_inp_avm_autoval                                     => 'L80',
	                                                                            '');
	
	owner_subscore2 := map(
	    NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval <= 0      		=> -0.037724,
	    0 < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 75297   			=> -0.128802,
	    75297 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 129735  	=> -0.105098,
	    129735 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 202918 	=> 0.011276,
	    202918 <= rv_a47_inp_avm_autoval                                     	=> 0.231830,
	                                                                             0.000000);
	
	owner_distance2 := if(owner_aacd2 = '', 0, owner_subscore2 - 0.231830);
	
	owner_aacd3 := map(
	    NULL < iv_i60_inq_phones_per_adl AND iv_i60_inq_phones_per_adl < 1 => 'I60',
	    1 <= iv_i60_inq_phones_per_adl AND iv_i60_inq_phones_per_adl < 2   => 'I60',
	    2 <= iv_i60_inq_phones_per_adl                                     => 'I60',
	                                                                          '');
	
	owner_subscore3 := map(
	    NULL < iv_i60_inq_phones_per_adl AND iv_i60_inq_phones_per_adl < 1 => 0.070306,
	    1 <= iv_i60_inq_phones_per_adl AND iv_i60_inq_phones_per_adl < 2   => -0.134450,
	    2 <= iv_i60_inq_phones_per_adl                                     => -0.235927,
	                                                                          0.000000);
	
	owner_distance3 := if(owner_aacd3 = '', 0, owner_subscore3 - 0.070306);
	
	owner_subscore4 := map(
	    (rv_e55_college_ind_shell5 in ['0']) => -0.020868,
	    (rv_e55_college_ind_shell5 in ['1']) => 0.154647,
	                                            0.000000);
	
	owner_aacd4 := map(
	    (rv_e55_college_ind_shell5 in ['0']) => 'E55',
	    (rv_e55_college_ind_shell5 in ['1']) => 'E55',
	                                            '');
	
	owner_distance4 := if(owner_aacd4 = '', 0, owner_subscore4 - 0.154647);
	
	owner_subscore5 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.056908,
	    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => -0.053220,
	    2 <= rv_i60_inq_count12                              => -0.190660,
	                                                            0.000000);
	
	owner_aacd5 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12 AND rv_i60_inq_count12 < 2   => 'I60',
	    2 <= rv_i60_inq_count12                              => 'I60',
	                                                            '');
	
	owner_distance5 := if(owner_aacd5 = '', 0, owner_subscore5 - 0.056908);
	
	owner_subscore6 := map(
	    (iv_f07_address_match in ['0 InputPop NoHistAvail', '2 CurrAvail + InputNotCurr'])         => -0.196538,
	    (iv_f07_address_match in ['1 Curr OnHdrOnly', '3 CurrAvail + NoInputPop', '4 Input=Curr']) => 0.040631,
	                                                                                                  0.000000);
	
	owner_aacd6 := map(
	    (iv_f07_address_match in ['0 InputPop NoHistAvail', '2 CurrAvail + InputNotCurr'])         => 'F03',
	    (iv_f07_address_match in ['1 Curr OnHdrOnly', '3 CurrAvail + NoInputPop', '4 Input=Curr']) => 'F03',
	                                                                                                  '');
	
	owner_distance6 := if(owner_aacd6 = '', 0, owner_subscore6 - 0.040631);
	
	owner_subscore7 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0     	=> -0.000365,
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 81275   		=> -0.189231,
	    81275 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 105334 => -0.085261,
	    105334 <= rv_a46_curr_avm_autoval                                     => 0.068230,
	                                                                             0.000000);
	
	owner_aacd7 := map(
	    // NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 2936     => 'A51',
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval <= 0     	=> 'A51',
	    // 2936 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 81275   => 'A46',
	    0 < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 81275   		=> 'A46',
	    81275 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 105334 => 'A46',
	    105334 <= rv_a46_curr_avm_autoval                                     => 'A46',
	                                                                             '');
	
	owner_distance7 := if(owner_aacd7 = '', 0, owner_subscore7 - 0.068230);
	
	owner_subscore8 := map(
	    NULL < iv_a50_pb_total_orders AND iv_a50_pb_total_orders < 2 => -0.063358,
	    2 <= iv_a50_pb_total_orders AND iv_a50_pb_total_orders < 5   => 0.062189,
	    5 <= iv_a50_pb_total_orders                                  => 0.109345,
	                                                                    0.000000);
	
	owner_aacd8 := map(
	    NULL < iv_a50_pb_total_orders AND iv_a50_pb_total_orders < 2 => 'A50',
	    2 <= iv_a50_pb_total_orders AND iv_a50_pb_total_orders < 5   => 'A50',
	    5 <= iv_a50_pb_total_orders                                  => 'A50',
	                                                                    '');
	
	owner_distance8 := if(owner_aacd8 = '', 0, owner_subscore8 - 0.109345);
	
	owner_subscore9 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 0.039617,
	    2 <= rv_c15_ssns_per_adl                               => -0.122651,
	                                                              0.000000);
	
	owner_aacd9 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 'C15',
	    2 <= rv_c15_ssns_per_adl                               => 'C15',
	                                                              '');
	
	owner_distance9 := if(owner_aacd9 = '', 0, owner_subscore9 - 0.039617);
	
	owner_aacd10 := map(
	    NULL < iv_c13_max_lres AND iv_c13_max_lres < 145 => 'C13',
	    145 <= iv_c13_max_lres AND iv_c13_max_lres < 270 => 'C13',
	    270 <= iv_c13_max_lres                           => 'C13',
	                                                        '');
	
	owner_subscore10 := map(
	    NULL < iv_c13_max_lres AND iv_c13_max_lres < 145 => -0.050341,
	    145 <= iv_c13_max_lres AND iv_c13_max_lres < 270 => 0.060428,
	    270 <= iv_c13_max_lres                           => 0.124073,
	                                                        -0.000000);
	
	owner_distance10 := if(owner_aacd10 = '', 0, owner_subscore10 - 0.124073);
	
	owner_subscore11 := map(
	    NULL < iv_br_source_count AND iv_br_source_count < 1 => -0.025257,
	    1 <= iv_br_source_count                              => 0.122823,
	                                                            -0.000000);
	
	owner_aacd11 := map(
	    NULL < iv_br_source_count AND iv_br_source_count < 1 => 'E57',
	    1 <= iv_br_source_count                              => 'E57',
	                                                            '');
	
	owner_distance11 := if(owner_aacd11 = '', 0, owner_subscore11 - 0.122823);
	
	owner_aacd12 := map(
	    NULL < iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 1 => 'I60',
	    1 <= iv_i60_inq_auto_recency                                   => 'I60',
	                                                                      '');
	
	owner_subscore12 := map(
	    NULL < iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 1 => 0.026746,
	    1 <= iv_i60_inq_auto_recency                                   => -0.058071,
	                                                                      -0.000000);
	
	owner_distance12 := if(owner_aacd12 = '', 0, owner_subscore12 - 0.026746);
	
	owner_subscore13 := map(
	    (rv_l77_apartment in [' ']) => 0.000000,
	    (rv_l77_apartment in ['0']) => 0.012987,
	    (rv_l77_apartment in ['1']) => -0.175110,
	                                   0.000000);
	
	owner_aacd13 := map(
	    (rv_l77_apartment in [' ']) => 'L77',
	    (rv_l77_apartment in ['0']) => 'L77',
	    (rv_l77_apartment in ['1']) => 'L77',
	                                   '');
	
	owner_distance13 := if(owner_aacd13 = '', 0, owner_subscore13 - 0.012987);
	
	owner_subscore14 := map(
	    NULL < iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 34 => -0.031387,
	    34 <= iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 79  => 0.014407,
	    79 <= iv_a50_pb_average_dollars                                     => 0.079340,
	                                                                           -0.000000);
	
	owner_aacd14 := map(
	    NULL < iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 34 => 'A50',
	    34 <= iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 79  => 'A50',
	    79 <= iv_a50_pb_average_dollars                                     => 'A50',
	                                                                           '');
	
	owner_distance14 := if(owner_aacd14 = '', 0, owner_subscore14 - 0.079340);
	
	owner_subscore15 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 0   => -0.037815,
	    0 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 218   => 0.001385,
	    218 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 898 => 0.046808,
	    898 <= iv_a50_pb_total_dollars                                   => 0.073528,
	                                                                        0.000000);
	
	owner_aacd15 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 0   => 'A50',
	    0 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 218   => 'A50',
	    218 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 898 => 'A50',
	    898 <= iv_a50_pb_total_dollars                                   => 'A50',
	                                                                        '');
	
	owner_distance15 := if(owner_aacd15 = '', 0, owner_subscore15 - 0.073528);
	
	owner_subscore16 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3 => 0.017880,
	    3 <= rv_s66_adlperssn_count                                  => -0.110752,
	                                                                    -0.000000);
	
	owner_aacd16 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3 => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	owner_distance16 := if(owner_aacd16 = '', 0, owner_subscore16 - 0.017880);
	
	owner_subscore17 := map(
	    (iv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 0.159148,
	    (iv_a43_rec_vehx_level in ['XX'])                         => -0.009183,
	                                                                 -0.000000);
	
	owner_aacd17 := map(
	    (iv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 'A43',
	    (iv_a43_rec_vehx_level in ['XX'])                         => 'A43',
	                                                                 '');
	
	owner_distance17 := if(owner_aacd17 = '', 0, owner_subscore17 - 0.159148);
	
	owner_subscore18 := map(
	    NULL < iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 60 => -0.132124,
	    60 <= iv_f02_inp_addr_address_score                                         => 0.009482,
	                                                                                   0.000000);
	
	owner_aacd18 := map(
	    NULL < iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 60 => 'F01',
	    60 <= iv_f02_inp_addr_address_score                                         => 'F01',
	                                                                                   '');
	
	owner_distance18 := if(owner_aacd18 = '', 0, owner_subscore18 - 0.009482);
	
	owner_aacd19 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 83 => 'C12',
	    83 <= rv_c12_source_profile                                 => 'C12',
	                                                                   '');
	
	owner_subscore19 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 83 => -0.010603,
	    83 <= rv_c12_source_profile                                 => 0.127121,
	                                                                   0.000000);
	
	owner_distance19 := if(owner_aacd19 = '', 0, owner_subscore19 - 0.127121);
	
	owner_aacd20 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                                       => 'D34',
	    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => 'D34',
	                                                                                                                   '');
	
	owner_subscore20 := map(
	    (iv_d34_liens_unrel_x_rel in ['0-0'])                                                                       => 0.009209,
	    (iv_d34_liens_unrel_x_rel in ['0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => -0.146272,
	                                                                                                                   0.000000);
	
	owner_distance20 := if(owner_aacd20 = '', 0, owner_subscore20 - 0.009209);
	
	owner_subscore21 := map(
	    NULL < iv_i60_inq_hiriskcred_count12 AND iv_i60_inq_hiriskcred_count12 < 1 => 0.004351,
	    1 <= iv_i60_inq_hiriskcred_count12                                         => -0.321655,
	                                                                                  0.000000);
	
	owner_aacd21 := map(
	    NULL < iv_i60_inq_hiriskcred_count12 AND iv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= iv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	owner_distance21 := if(owner_aacd21 = '', 0, owner_subscore21 - 0.004351);
	
	owner_aacd22 := map(
	    NULL < iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 2 => 'C14',
	    2 <= iv_c14_addrs_10yr                             => 'C14',
	                                                          '');
	
	owner_subscore22 := map(
	    NULL < iv_c14_addrs_10yr AND iv_c14_addrs_10yr < 2 => 0.056037,
	    2 <= iv_c14_addrs_10yr                             => -0.020727,
	                                                          0.000000);
	
	owner_distance22 := if(owner_aacd22 = '', 0, owner_subscore22 - 0.056037);
	
	owner_subscore23 := map(
	    NULL < iv_l79_adls_per_apt_addr_c6 AND iv_l79_adls_per_apt_addr_c6 < 1 => 0.003375,
	    1 <= iv_l79_adls_per_apt_addr_c6                                       => -0.248527,
	                                                                              -0.000000);
	
	owner_aacd23 := map(
	    NULL < iv_l79_adls_per_apt_addr_c6 AND iv_l79_adls_per_apt_addr_c6 < 1 => 'L79',
	    1 <= iv_l79_adls_per_apt_addr_c6                                       => 'L79',
	                                                                              '');
	
	owner_distance23 := if(owner_aacd23 = '', 0, owner_subscore23 - 0.003375);
	
	owner_subscore24 := map(
	    NULL < rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 1   => 0.000000,
	    1 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 286   => -0.019810,
	    286 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 317 => 0.011056,
	    317 <= rv_c21_m_bureau_adl_fs                                  => 0.042999,
	                                                                      0.000000);
	
	owner_aacd24 := map(
	    NULL < rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 1   => 'C21',
	    1 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 286   => 'C21',
	    286 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 317 => 'C21',
	    317 <= rv_c21_m_bureau_adl_fs                                  => 'C21',
	                                                                      '');
	
	owner_distance24 := if(owner_aacd24 = '', 0, owner_subscore24 - 0.042999);
	
	owner_aacd25 := map(
	    NULL < iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 1 => 'C14',
	    1 <= iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 2   => 'C14',
	    2 <= iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 3   => 'C14',
	    3 <= iv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	owner_subscore25 := map(
	    NULL < iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 1 => 0.029659,
	    1 <= iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 2   => 0.016578,
	    2 <= iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 3   => -0.019128,
	    3 <= iv_c14_addrs_5yr                            => -0.037743,
	                                                        -0.000000);
	
	owner_distance25 := if(owner_aacd25 = '', 0, owner_subscore25 - 0.029659);
	
	owner_subscore26 := map(
	    NULL < iv_i60_inq_auto_count12 AND iv_i60_inq_auto_count12 < 4 => 0.004618,
	    4 <= iv_i60_inq_auto_count12                                   => -0.115682,
	                                                                      -0.000000);
	
	owner_aacd26 := map(
	    NULL < iv_i60_inq_auto_count12 AND iv_i60_inq_auto_count12 < 4 => 'I60',
	    4 <= iv_i60_inq_auto_count12                                   => 'I60',
	                                                                      '');
	
	owner_distance26 := if(owner_aacd26 = '', 0, owner_subscore26 - 0.004618);
	
	owner_aacd27 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 95 => 'C10',
	    95 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 217 => 'C10',
	    217 <= rv_c10_m_hdr_fs                          => 'C10',
	                                                       '');
	
	owner_subscore27 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 95 => -0.146592,
	    95 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 217 => -0.007710,
	    217 <= rv_c10_m_hdr_fs                          => 0.008459,
	                                                       0.000000);
	
	owner_distance27 := if(owner_aacd27 = '', 0, owner_subscore27 - 0.008459);
	
	owner_subscore28 := map(
	    NULL < iv_l79_adls_per_addr_c6 AND iv_l79_adls_per_addr_c6 < 1 => 0.015832,
	    1 <= iv_l79_adls_per_addr_c6                                   => -0.035850,
	                                                                      0.000000);
	
	owner_aacd28 := map(
	    NULL < iv_l79_adls_per_addr_c6 AND iv_l79_adls_per_addr_c6 < 1 => 'L79',
	    1 <= iv_l79_adls_per_addr_c6                                   => 'L79',
	                                                                      '');
	
	owner_distance28 := if(owner_aacd28 = '', 0, owner_subscore28 - 0.015832);
	
	owner_aacd29 := map(
	    (iv_a44_cur_add_naprop in [''])           	=> 'A44',
	    (iv_a44_cur_add_naprop in ['0', '1'])      	=> 'A44',
	    (iv_a44_cur_add_naprop in ['2', '3', '4']) 	=> 'A44',
																										 '');
	
	owner_subscore29 := map(
	    (iv_a44_cur_add_naprop in [''])           	=> 0.000000,
	    (iv_a44_cur_add_naprop in ['0', '1'])     	=> -0.018942,
	    (iv_a44_cur_add_naprop in ['2', '3', '4']) 	=> 0.004454,
																										 0.000000);
	
	owner_distance29 := if(owner_aacd29 = '', 0, owner_subscore29 - 0.004454);
	
	// owner_rcvaluea51 := (integer)(owner_aacd1 = 'A51') * owner_distance1 +
	    // (integer)(owner_aacd2 = 'A51') * owner_distance2 +
	    // (integer)(owner_aacd3 = 'A51') * owner_distance3 +
	    // (integer)(owner_aacd4 = 'A51') * owner_distance4 +
	    // (integer)(owner_aacd5 = 'A51') * owner_distance5 +
	    // (integer)(owner_aacd6 = 'A51') * owner_distance6 +
	    // (integer)(owner_aacd7 = 'A51') * owner_distance7 +
	    // (integer)(owner_aacd8 = 'A51') * owner_distance8 +
	    // (integer)(owner_aacd9 = 'A51') * owner_distance9 +
	    // (integer)(owner_aacd10 = 'A51') * owner_distance10 +
	    // (integer)(owner_aacd11 = 'A51') * owner_distance11 +
	    // (integer)(owner_aacd12 = 'A51') * owner_distance12 +
	    // (integer)(owner_aacd13 = 'A51') * owner_distance13 +
	    // (integer)(owner_aacd14 = 'A51') * owner_distance14 +
	    // (integer)(owner_aacd15 = 'A51') * owner_distance15 +
	    // (integer)(owner_aacd16 = 'A51') * owner_distance16 +
	    // (integer)(owner_aacd17 = 'A51') * owner_distance17 +
	    // (integer)(owner_aacd18 = 'A51') * owner_distance18 +
	    // (integer)(owner_aacd19 = 'A51') * owner_distance19 +
	    // (integer)(owner_aacd20 = 'A51') * owner_distance20 +
	    // (integer)(owner_aacd21 = 'A51') * owner_distance21 +
	    // (integer)(owner_aacd22 = 'A51') * owner_distance22 +
	    // (integer)(owner_aacd23 = 'A51') * owner_distance23 +
	    // (integer)(owner_aacd24 = 'A51') * owner_distance24 +
	    // (integer)(owner_aacd25 = 'A51') * owner_distance25 +
	    // (integer)(owner_aacd26 = 'A51') * owner_distance26 +
	    // (integer)(owner_aacd27 = 'A51') * owner_distance27 +
	    // (integer)(owner_aacd28 = 'A51') * owner_distance28 +
	    // (integer)(owner_aacd29 = 'A51') * owner_distance29;
	
	owner_rcvaluea43 := (integer)(owner_aacd1 = 'A43') * owner_distance1 +
	    (integer)(owner_aacd2 = 'A43') * owner_distance2 +
	    (integer)(owner_aacd3 = 'A43') * owner_distance3 +
	    (integer)(owner_aacd4 = 'A43') * owner_distance4 +
	    (integer)(owner_aacd5 = 'A43') * owner_distance5 +
	    (integer)(owner_aacd6 = 'A43') * owner_distance6 +
	    (integer)(owner_aacd7 = 'A43') * owner_distance7 +
	    (integer)(owner_aacd8 = 'A43') * owner_distance8 +
	    (integer)(owner_aacd9 = 'A43') * owner_distance9 +
	    (integer)(owner_aacd10 = 'A43') * owner_distance10 +
	    (integer)(owner_aacd11 = 'A43') * owner_distance11 +
	    (integer)(owner_aacd12 = 'A43') * owner_distance12 +
	    (integer)(owner_aacd13 = 'A43') * owner_distance13 +
	    (integer)(owner_aacd14 = 'A43') * owner_distance14 +
	    (integer)(owner_aacd15 = 'A43') * owner_distance15 +
	    (integer)(owner_aacd16 = 'A43') * owner_distance16 +
	    (integer)(owner_aacd17 = 'A43') * owner_distance17 +
	    (integer)(owner_aacd18 = 'A43') * owner_distance18 +
	    (integer)(owner_aacd19 = 'A43') * owner_distance19 +
	    (integer)(owner_aacd20 = 'A43') * owner_distance20 +
	    (integer)(owner_aacd21 = 'A43') * owner_distance21 +
	    (integer)(owner_aacd22 = 'A43') * owner_distance22 +
	    (integer)(owner_aacd23 = 'A43') * owner_distance23 +
	    (integer)(owner_aacd24 = 'A43') * owner_distance24 +
	    (integer)(owner_aacd25 = 'A43') * owner_distance25 +
	    (integer)(owner_aacd26 = 'A43') * owner_distance26 +
	    (integer)(owner_aacd27 = 'A43') * owner_distance27 +
	    (integer)(owner_aacd28 = 'A43') * owner_distance28 +
	    (integer)(owner_aacd29 = 'A43') * owner_distance29;
	
	owner_rcvaluea44 := (integer)(owner_aacd1 = 'A44') * owner_distance1 +
	    (integer)(owner_aacd2 = 'A44') * owner_distance2 +
	    (integer)(owner_aacd3 = 'A44') * owner_distance3 +
	    (integer)(owner_aacd4 = 'A44') * owner_distance4 +
	    (integer)(owner_aacd5 = 'A44') * owner_distance5 +
	    (integer)(owner_aacd6 = 'A44') * owner_distance6 +
	    (integer)(owner_aacd7 = 'A44') * owner_distance7 +
	    (integer)(owner_aacd8 = 'A44') * owner_distance8 +
	    (integer)(owner_aacd9 = 'A44') * owner_distance9 +
	    (integer)(owner_aacd10 = 'A44') * owner_distance10 +
	    (integer)(owner_aacd11 = 'A44') * owner_distance11 +
	    (integer)(owner_aacd12 = 'A44') * owner_distance12 +
	    (integer)(owner_aacd13 = 'A44') * owner_distance13 +
	    (integer)(owner_aacd14 = 'A44') * owner_distance14 +
	    (integer)(owner_aacd15 = 'A44') * owner_distance15 +
	    (integer)(owner_aacd16 = 'A44') * owner_distance16 +
	    (integer)(owner_aacd17 = 'A44') * owner_distance17 +
	    (integer)(owner_aacd18 = 'A44') * owner_distance18 +
	    (integer)(owner_aacd19 = 'A44') * owner_distance19 +
	    (integer)(owner_aacd20 = 'A44') * owner_distance20 +
	    (integer)(owner_aacd21 = 'A44') * owner_distance21 +
	    (integer)(owner_aacd22 = 'A44') * owner_distance22 +
	    (integer)(owner_aacd23 = 'A44') * owner_distance23 +
	    (integer)(owner_aacd24 = 'A44') * owner_distance24 +
	    (integer)(owner_aacd25 = 'A44') * owner_distance25 +
	    (integer)(owner_aacd26 = 'A44') * owner_distance26 +
	    (integer)(owner_aacd27 = 'A44') * owner_distance27 +
	    (integer)(owner_aacd28 = 'A44') * owner_distance28 +
	    (integer)(owner_aacd29 = 'A44') * owner_distance29;
	
	owner_rcvaluea46 := (integer)(owner_aacd1 = 'A46') * owner_distance1 +
	    (integer)(owner_aacd2 = 'A46') * owner_distance2 +
	    (integer)(owner_aacd3 = 'A46') * owner_distance3 +
	    (integer)(owner_aacd4 = 'A46') * owner_distance4 +
	    (integer)(owner_aacd5 = 'A46') * owner_distance5 +
	    (integer)(owner_aacd6 = 'A46') * owner_distance6 +
	    (integer)(owner_aacd7 = 'A46') * owner_distance7 +
	    (integer)(owner_aacd8 = 'A46') * owner_distance8 +
	    (integer)(owner_aacd9 = 'A46') * owner_distance9 +
	    (integer)(owner_aacd10 = 'A46') * owner_distance10 +
	    (integer)(owner_aacd11 = 'A46') * owner_distance11 +
	    (integer)(owner_aacd12 = 'A46') * owner_distance12 +
	    (integer)(owner_aacd13 = 'A46') * owner_distance13 +
	    (integer)(owner_aacd14 = 'A46') * owner_distance14 +
	    (integer)(owner_aacd15 = 'A46') * owner_distance15 +
	    (integer)(owner_aacd16 = 'A46') * owner_distance16 +
	    (integer)(owner_aacd17 = 'A46') * owner_distance17 +
	    (integer)(owner_aacd18 = 'A46') * owner_distance18 +
	    (integer)(owner_aacd19 = 'A46') * owner_distance19 +
	    (integer)(owner_aacd20 = 'A46') * owner_distance20 +
	    (integer)(owner_aacd21 = 'A46') * owner_distance21 +
	    (integer)(owner_aacd22 = 'A46') * owner_distance22 +
	    (integer)(owner_aacd23 = 'A46') * owner_distance23 +
	    (integer)(owner_aacd24 = 'A46') * owner_distance24 +
	    (integer)(owner_aacd25 = 'A46') * owner_distance25 +
	    (integer)(owner_aacd26 = 'A46') * owner_distance26 +
	    (integer)(owner_aacd27 = 'A46') * owner_distance27 +
	    (integer)(owner_aacd28 = 'A46') * owner_distance28 +
	    (integer)(owner_aacd29 = 'A46') * owner_distance29;
	
	owner_rcvaluea50 := (integer)(owner_aacd1 = 'A50') * owner_distance1 +
	    (integer)(owner_aacd2 = 'A50') * owner_distance2 +
	    (integer)(owner_aacd3 = 'A50') * owner_distance3 +
	    (integer)(owner_aacd4 = 'A50') * owner_distance4 +
	    (integer)(owner_aacd5 = 'A50') * owner_distance5 +
	    (integer)(owner_aacd6 = 'A50') * owner_distance6 +
	    (integer)(owner_aacd7 = 'A50') * owner_distance7 +
	    (integer)(owner_aacd8 = 'A50') * owner_distance8 +
	    (integer)(owner_aacd9 = 'A50') * owner_distance9 +
	    (integer)(owner_aacd10 = 'A50') * owner_distance10 +
	    (integer)(owner_aacd11 = 'A50') * owner_distance11 +
	    (integer)(owner_aacd12 = 'A50') * owner_distance12 +
	    (integer)(owner_aacd13 = 'A50') * owner_distance13 +
	    (integer)(owner_aacd14 = 'A50') * owner_distance14 +
	    (integer)(owner_aacd15 = 'A50') * owner_distance15 +
	    (integer)(owner_aacd16 = 'A50') * owner_distance16 +
	    (integer)(owner_aacd17 = 'A50') * owner_distance17 +
	    (integer)(owner_aacd18 = 'A50') * owner_distance18 +
	    (integer)(owner_aacd19 = 'A50') * owner_distance19 +
	    (integer)(owner_aacd20 = 'A50') * owner_distance20 +
	    (integer)(owner_aacd21 = 'A50') * owner_distance21 +
	    (integer)(owner_aacd22 = 'A50') * owner_distance22 +
	    (integer)(owner_aacd23 = 'A50') * owner_distance23 +
	    (integer)(owner_aacd24 = 'A50') * owner_distance24 +
	    (integer)(owner_aacd25 = 'A50') * owner_distance25 +
	    (integer)(owner_aacd26 = 'A50') * owner_distance26 +
	    (integer)(owner_aacd27 = 'A50') * owner_distance27 +
	    (integer)(owner_aacd28 = 'A50') * owner_distance28 +
	    (integer)(owner_aacd29 = 'A50') * owner_distance29;
	
	owner_rcvaluea51 := (integer)(owner_aacd1 = 'A51') * owner_distance1 +
	    (integer)(owner_aacd2 = 'A51') * owner_distance2 +
	    (integer)(owner_aacd3 = 'A51') * owner_distance3 +
	    (integer)(owner_aacd4 = 'A51') * owner_distance4 +
	    (integer)(owner_aacd5 = 'A51') * owner_distance5 +
	    (integer)(owner_aacd6 = 'A51') * owner_distance6 +
	    (integer)(owner_aacd7 = 'A51') * owner_distance7 +
	    (integer)(owner_aacd8 = 'A51') * owner_distance8 +
	    (integer)(owner_aacd9 = 'A51') * owner_distance9 +
	    (integer)(owner_aacd10 = 'A51') * owner_distance10 +
	    (integer)(owner_aacd11 = 'A51') * owner_distance11 +
	    (integer)(owner_aacd12 = 'A51') * owner_distance12 +
	    (integer)(owner_aacd13 = 'A51') * owner_distance13 +
	    (integer)(owner_aacd14 = 'A51') * owner_distance14 +
	    (integer)(owner_aacd15 = 'A51') * owner_distance15 +
	    (integer)(owner_aacd16 = 'A51') * owner_distance16 +
	    (integer)(owner_aacd17 = 'A51') * owner_distance17 +
	    (integer)(owner_aacd18 = 'A51') * owner_distance18 +
	    (integer)(owner_aacd19 = 'A51') * owner_distance19 +
	    (integer)(owner_aacd20 = 'A51') * owner_distance20 +
	    (integer)(owner_aacd21 = 'A51') * owner_distance21 +
	    (integer)(owner_aacd22 = 'A51') * owner_distance22 +
	    (integer)(owner_aacd23 = 'A51') * owner_distance23 +
	    (integer)(owner_aacd24 = 'A51') * owner_distance24 +
	    (integer)(owner_aacd25 = 'A51') * owner_distance25 +
	    (integer)(owner_aacd26 = 'A51') * owner_distance26 +
	    (integer)(owner_aacd27 = 'A51') * owner_distance27 +
	    (integer)(owner_aacd28 = 'A51') * owner_distance28 +
	    (integer)(owner_aacd29 = 'A51') * owner_distance29;
	
	owner_rcvaluec10 := (integer)(owner_aacd1 = 'C10') * owner_distance1 +
	    (integer)(owner_aacd2 = 'C10') * owner_distance2 +
	    (integer)(owner_aacd3 = 'C10') * owner_distance3 +
	    (integer)(owner_aacd4 = 'C10') * owner_distance4 +
	    (integer)(owner_aacd5 = 'C10') * owner_distance5 +
	    (integer)(owner_aacd6 = 'C10') * owner_distance6 +
	    (integer)(owner_aacd7 = 'C10') * owner_distance7 +
	    (integer)(owner_aacd8 = 'C10') * owner_distance8 +
	    (integer)(owner_aacd9 = 'C10') * owner_distance9 +
	    (integer)(owner_aacd10 = 'C10') * owner_distance10 +
	    (integer)(owner_aacd11 = 'C10') * owner_distance11 +
	    (integer)(owner_aacd12 = 'C10') * owner_distance12 +
	    (integer)(owner_aacd13 = 'C10') * owner_distance13 +
	    (integer)(owner_aacd14 = 'C10') * owner_distance14 +
	    (integer)(owner_aacd15 = 'C10') * owner_distance15 +
	    (integer)(owner_aacd16 = 'C10') * owner_distance16 +
	    (integer)(owner_aacd17 = 'C10') * owner_distance17 +
	    (integer)(owner_aacd18 = 'C10') * owner_distance18 +
	    (integer)(owner_aacd19 = 'C10') * owner_distance19 +
	    (integer)(owner_aacd20 = 'C10') * owner_distance20 +
	    (integer)(owner_aacd21 = 'C10') * owner_distance21 +
	    (integer)(owner_aacd22 = 'C10') * owner_distance22 +
	    (integer)(owner_aacd23 = 'C10') * owner_distance23 +
	    (integer)(owner_aacd24 = 'C10') * owner_distance24 +
	    (integer)(owner_aacd25 = 'C10') * owner_distance25 +
	    (integer)(owner_aacd26 = 'C10') * owner_distance26 +
	    (integer)(owner_aacd27 = 'C10') * owner_distance27 +
	    (integer)(owner_aacd28 = 'C10') * owner_distance28 +
	    (integer)(owner_aacd29 = 'C10') * owner_distance29;
	
	owner_rcvaluec12 := (integer)(owner_aacd1 = 'C12') * owner_distance1 +
	    (integer)(owner_aacd2 = 'C12') * owner_distance2 +
	    (integer)(owner_aacd3 = 'C12') * owner_distance3 +
	    (integer)(owner_aacd4 = 'C12') * owner_distance4 +
	    (integer)(owner_aacd5 = 'C12') * owner_distance5 +
	    (integer)(owner_aacd6 = 'C12') * owner_distance6 +
	    (integer)(owner_aacd7 = 'C12') * owner_distance7 +
	    (integer)(owner_aacd8 = 'C12') * owner_distance8 +
	    (integer)(owner_aacd9 = 'C12') * owner_distance9 +
	    (integer)(owner_aacd10 = 'C12') * owner_distance10 +
	    (integer)(owner_aacd11 = 'C12') * owner_distance11 +
	    (integer)(owner_aacd12 = 'C12') * owner_distance12 +
	    (integer)(owner_aacd13 = 'C12') * owner_distance13 +
	    (integer)(owner_aacd14 = 'C12') * owner_distance14 +
	    (integer)(owner_aacd15 = 'C12') * owner_distance15 +
	    (integer)(owner_aacd16 = 'C12') * owner_distance16 +
	    (integer)(owner_aacd17 = 'C12') * owner_distance17 +
	    (integer)(owner_aacd18 = 'C12') * owner_distance18 +
	    (integer)(owner_aacd19 = 'C12') * owner_distance19 +
	    (integer)(owner_aacd20 = 'C12') * owner_distance20 +
	    (integer)(owner_aacd21 = 'C12') * owner_distance21 +
	    (integer)(owner_aacd22 = 'C12') * owner_distance22 +
	    (integer)(owner_aacd23 = 'C12') * owner_distance23 +
	    (integer)(owner_aacd24 = 'C12') * owner_distance24 +
	    (integer)(owner_aacd25 = 'C12') * owner_distance25 +
	    (integer)(owner_aacd26 = 'C12') * owner_distance26 +
	    (integer)(owner_aacd27 = 'C12') * owner_distance27 +
	    (integer)(owner_aacd28 = 'C12') * owner_distance28 +
	    (integer)(owner_aacd29 = 'C12') * owner_distance29;
	
	owner_rcvaluec13 := (integer)(owner_aacd1 = 'C13') * owner_distance1 +
	    (integer)(owner_aacd2 = 'C13') * owner_distance2 +
	    (integer)(owner_aacd3 = 'C13') * owner_distance3 +
	    (integer)(owner_aacd4 = 'C13') * owner_distance4 +
	    (integer)(owner_aacd5 = 'C13') * owner_distance5 +
	    (integer)(owner_aacd6 = 'C13') * owner_distance6 +
	    (integer)(owner_aacd7 = 'C13') * owner_distance7 +
	    (integer)(owner_aacd8 = 'C13') * owner_distance8 +
	    (integer)(owner_aacd9 = 'C13') * owner_distance9 +
	    (integer)(owner_aacd10 = 'C13') * owner_distance10 +
	    (integer)(owner_aacd11 = 'C13') * owner_distance11 +
	    (integer)(owner_aacd12 = 'C13') * owner_distance12 +
	    (integer)(owner_aacd13 = 'C13') * owner_distance13 +
	    (integer)(owner_aacd14 = 'C13') * owner_distance14 +
	    (integer)(owner_aacd15 = 'C13') * owner_distance15 +
	    (integer)(owner_aacd16 = 'C13') * owner_distance16 +
	    (integer)(owner_aacd17 = 'C13') * owner_distance17 +
	    (integer)(owner_aacd18 = 'C13') * owner_distance18 +
	    (integer)(owner_aacd19 = 'C13') * owner_distance19 +
	    (integer)(owner_aacd20 = 'C13') * owner_distance20 +
	    (integer)(owner_aacd21 = 'C13') * owner_distance21 +
	    (integer)(owner_aacd22 = 'C13') * owner_distance22 +
	    (integer)(owner_aacd23 = 'C13') * owner_distance23 +
	    (integer)(owner_aacd24 = 'C13') * owner_distance24 +
	    (integer)(owner_aacd25 = 'C13') * owner_distance25 +
	    (integer)(owner_aacd26 = 'C13') * owner_distance26 +
	    (integer)(owner_aacd27 = 'C13') * owner_distance27 +
	    (integer)(owner_aacd28 = 'C13') * owner_distance28 +
	    (integer)(owner_aacd29 = 'C13') * owner_distance29;
	
	owner_rcvaluec14 := (integer)(owner_aacd1 = 'C14') * owner_distance1 +
	    (integer)(owner_aacd2 = 'C14') * owner_distance2 +
	    (integer)(owner_aacd3 = 'C14') * owner_distance3 +
	    (integer)(owner_aacd4 = 'C14') * owner_distance4 +
	    (integer)(owner_aacd5 = 'C14') * owner_distance5 +
	    (integer)(owner_aacd6 = 'C14') * owner_distance6 +
	    (integer)(owner_aacd7 = 'C14') * owner_distance7 +
	    (integer)(owner_aacd8 = 'C14') * owner_distance8 +
	    (integer)(owner_aacd9 = 'C14') * owner_distance9 +
	    (integer)(owner_aacd10 = 'C14') * owner_distance10 +
	    (integer)(owner_aacd11 = 'C14') * owner_distance11 +
	    (integer)(owner_aacd12 = 'C14') * owner_distance12 +
	    (integer)(owner_aacd13 = 'C14') * owner_distance13 +
	    (integer)(owner_aacd14 = 'C14') * owner_distance14 +
	    (integer)(owner_aacd15 = 'C14') * owner_distance15 +
	    (integer)(owner_aacd16 = 'C14') * owner_distance16 +
	    (integer)(owner_aacd17 = 'C14') * owner_distance17 +
	    (integer)(owner_aacd18 = 'C14') * owner_distance18 +
	    (integer)(owner_aacd19 = 'C14') * owner_distance19 +
	    (integer)(owner_aacd20 = 'C14') * owner_distance20 +
	    (integer)(owner_aacd21 = 'C14') * owner_distance21 +
	    (integer)(owner_aacd22 = 'C14') * owner_distance22 +
	    (integer)(owner_aacd23 = 'C14') * owner_distance23 +
	    (integer)(owner_aacd24 = 'C14') * owner_distance24 +
	    (integer)(owner_aacd25 = 'C14') * owner_distance25 +
	    (integer)(owner_aacd26 = 'C14') * owner_distance26 +
	    (integer)(owner_aacd27 = 'C14') * owner_distance27 +
	    (integer)(owner_aacd28 = 'C14') * owner_distance28 +
	    (integer)(owner_aacd29 = 'C14') * owner_distance29;
	
	owner_rcvaluec15 := (integer)(owner_aacd1 = 'C15') * owner_distance1 +
	    (integer)(owner_aacd2 = 'C15') * owner_distance2 +
	    (integer)(owner_aacd3 = 'C15') * owner_distance3 +
	    (integer)(owner_aacd4 = 'C15') * owner_distance4 +
	    (integer)(owner_aacd5 = 'C15') * owner_distance5 +
	    (integer)(owner_aacd6 = 'C15') * owner_distance6 +
	    (integer)(owner_aacd7 = 'C15') * owner_distance7 +
	    (integer)(owner_aacd8 = 'C15') * owner_distance8 +
	    (integer)(owner_aacd9 = 'C15') * owner_distance9 +
	    (integer)(owner_aacd10 = 'C15') * owner_distance10 +
	    (integer)(owner_aacd11 = 'C15') * owner_distance11 +
	    (integer)(owner_aacd12 = 'C15') * owner_distance12 +
	    (integer)(owner_aacd13 = 'C15') * owner_distance13 +
	    (integer)(owner_aacd14 = 'C15') * owner_distance14 +
	    (integer)(owner_aacd15 = 'C15') * owner_distance15 +
	    (integer)(owner_aacd16 = 'C15') * owner_distance16 +
	    (integer)(owner_aacd17 = 'C15') * owner_distance17 +
	    (integer)(owner_aacd18 = 'C15') * owner_distance18 +
	    (integer)(owner_aacd19 = 'C15') * owner_distance19 +
	    (integer)(owner_aacd20 = 'C15') * owner_distance20 +
	    (integer)(owner_aacd21 = 'C15') * owner_distance21 +
	    (integer)(owner_aacd22 = 'C15') * owner_distance22 +
	    (integer)(owner_aacd23 = 'C15') * owner_distance23 +
	    (integer)(owner_aacd24 = 'C15') * owner_distance24 +
	    (integer)(owner_aacd25 = 'C15') * owner_distance25 +
	    (integer)(owner_aacd26 = 'C15') * owner_distance26 +
	    (integer)(owner_aacd27 = 'C15') * owner_distance27 +
	    (integer)(owner_aacd28 = 'C15') * owner_distance28 +
	    (integer)(owner_aacd29 = 'C15') * owner_distance29;
	
	owner_rcvaluec21 := (integer)(owner_aacd1 = 'C21') * owner_distance1 +
	    (integer)(owner_aacd2 = 'C21') * owner_distance2 +
	    (integer)(owner_aacd3 = 'C21') * owner_distance3 +
	    (integer)(owner_aacd4 = 'C21') * owner_distance4 +
	    (integer)(owner_aacd5 = 'C21') * owner_distance5 +
	    (integer)(owner_aacd6 = 'C21') * owner_distance6 +
	    (integer)(owner_aacd7 = 'C21') * owner_distance7 +
	    (integer)(owner_aacd8 = 'C21') * owner_distance8 +
	    (integer)(owner_aacd9 = 'C21') * owner_distance9 +
	    (integer)(owner_aacd10 = 'C21') * owner_distance10 +
	    (integer)(owner_aacd11 = 'C21') * owner_distance11 +
	    (integer)(owner_aacd12 = 'C21') * owner_distance12 +
	    (integer)(owner_aacd13 = 'C21') * owner_distance13 +
	    (integer)(owner_aacd14 = 'C21') * owner_distance14 +
	    (integer)(owner_aacd15 = 'C21') * owner_distance15 +
	    (integer)(owner_aacd16 = 'C21') * owner_distance16 +
	    (integer)(owner_aacd17 = 'C21') * owner_distance17 +
	    (integer)(owner_aacd18 = 'C21') * owner_distance18 +
	    (integer)(owner_aacd19 = 'C21') * owner_distance19 +
	    (integer)(owner_aacd20 = 'C21') * owner_distance20 +
	    (integer)(owner_aacd21 = 'C21') * owner_distance21 +
	    (integer)(owner_aacd22 = 'C21') * owner_distance22 +
	    (integer)(owner_aacd23 = 'C21') * owner_distance23 +
	    (integer)(owner_aacd24 = 'C21') * owner_distance24 +
	    (integer)(owner_aacd25 = 'C21') * owner_distance25 +
	    (integer)(owner_aacd26 = 'C21') * owner_distance26 +
	    (integer)(owner_aacd27 = 'C21') * owner_distance27 +
	    (integer)(owner_aacd28 = 'C21') * owner_distance28 +
	    (integer)(owner_aacd29 = 'C21') * owner_distance29;
	
	owner_rcvalued34 := (integer)(owner_aacd1 = 'D34') * owner_distance1 +
	    (integer)(owner_aacd2 = 'D34') * owner_distance2 +
	    (integer)(owner_aacd3 = 'D34') * owner_distance3 +
	    (integer)(owner_aacd4 = 'D34') * owner_distance4 +
	    (integer)(owner_aacd5 = 'D34') * owner_distance5 +
	    (integer)(owner_aacd6 = 'D34') * owner_distance6 +
	    (integer)(owner_aacd7 = 'D34') * owner_distance7 +
	    (integer)(owner_aacd8 = 'D34') * owner_distance8 +
	    (integer)(owner_aacd9 = 'D34') * owner_distance9 +
	    (integer)(owner_aacd10 = 'D34') * owner_distance10 +
	    (integer)(owner_aacd11 = 'D34') * owner_distance11 +
	    (integer)(owner_aacd12 = 'D34') * owner_distance12 +
	    (integer)(owner_aacd13 = 'D34') * owner_distance13 +
	    (integer)(owner_aacd14 = 'D34') * owner_distance14 +
	    (integer)(owner_aacd15 = 'D34') * owner_distance15 +
	    (integer)(owner_aacd16 = 'D34') * owner_distance16 +
	    (integer)(owner_aacd17 = 'D34') * owner_distance17 +
	    (integer)(owner_aacd18 = 'D34') * owner_distance18 +
	    (integer)(owner_aacd19 = 'D34') * owner_distance19 +
	    (integer)(owner_aacd20 = 'D34') * owner_distance20 +
	    (integer)(owner_aacd21 = 'D34') * owner_distance21 +
	    (integer)(owner_aacd22 = 'D34') * owner_distance22 +
	    (integer)(owner_aacd23 = 'D34') * owner_distance23 +
	    (integer)(owner_aacd24 = 'D34') * owner_distance24 +
	    (integer)(owner_aacd25 = 'D34') * owner_distance25 +
	    (integer)(owner_aacd26 = 'D34') * owner_distance26 +
	    (integer)(owner_aacd27 = 'D34') * owner_distance27 +
	    (integer)(owner_aacd28 = 'D34') * owner_distance28 +
	    (integer)(owner_aacd29 = 'D34') * owner_distance29;
	
	owner_rcvaluee55 := (integer)(owner_aacd1 = 'E55') * owner_distance1 +
	    (integer)(owner_aacd2 = 'E55') * owner_distance2 +
	    (integer)(owner_aacd3 = 'E55') * owner_distance3 +
	    (integer)(owner_aacd4 = 'E55') * owner_distance4 +
	    (integer)(owner_aacd5 = 'E55') * owner_distance5 +
	    (integer)(owner_aacd6 = 'E55') * owner_distance6 +
	    (integer)(owner_aacd7 = 'E55') * owner_distance7 +
	    (integer)(owner_aacd8 = 'E55') * owner_distance8 +
	    (integer)(owner_aacd9 = 'E55') * owner_distance9 +
	    (integer)(owner_aacd10 = 'E55') * owner_distance10 +
	    (integer)(owner_aacd11 = 'E55') * owner_distance11 +
	    (integer)(owner_aacd12 = 'E55') * owner_distance12 +
	    (integer)(owner_aacd13 = 'E55') * owner_distance13 +
	    (integer)(owner_aacd14 = 'E55') * owner_distance14 +
	    (integer)(owner_aacd15 = 'E55') * owner_distance15 +
	    (integer)(owner_aacd16 = 'E55') * owner_distance16 +
	    (integer)(owner_aacd17 = 'E55') * owner_distance17 +
	    (integer)(owner_aacd18 = 'E55') * owner_distance18 +
	    (integer)(owner_aacd19 = 'E55') * owner_distance19 +
	    (integer)(owner_aacd20 = 'E55') * owner_distance20 +
	    (integer)(owner_aacd21 = 'E55') * owner_distance21 +
	    (integer)(owner_aacd22 = 'E55') * owner_distance22 +
	    (integer)(owner_aacd23 = 'E55') * owner_distance23 +
	    (integer)(owner_aacd24 = 'E55') * owner_distance24 +
	    (integer)(owner_aacd25 = 'E55') * owner_distance25 +
	    (integer)(owner_aacd26 = 'E55') * owner_distance26 +
	    (integer)(owner_aacd27 = 'E55') * owner_distance27 +
	    (integer)(owner_aacd28 = 'E55') * owner_distance28 +
	    (integer)(owner_aacd29 = 'E55') * owner_distance29;
	
	owner_rcvaluee57 := (integer)(owner_aacd1 = 'E57') * owner_distance1 +
	    (integer)(owner_aacd2 = 'E57') * owner_distance2 +
	    (integer)(owner_aacd3 = 'E57') * owner_distance3 +
	    (integer)(owner_aacd4 = 'E57') * owner_distance4 +
	    (integer)(owner_aacd5 = 'E57') * owner_distance5 +
	    (integer)(owner_aacd6 = 'E57') * owner_distance6 +
	    (integer)(owner_aacd7 = 'E57') * owner_distance7 +
	    (integer)(owner_aacd8 = 'E57') * owner_distance8 +
	    (integer)(owner_aacd9 = 'E57') * owner_distance9 +
	    (integer)(owner_aacd10 = 'E57') * owner_distance10 +
	    (integer)(owner_aacd11 = 'E57') * owner_distance11 +
	    (integer)(owner_aacd12 = 'E57') * owner_distance12 +
	    (integer)(owner_aacd13 = 'E57') * owner_distance13 +
	    (integer)(owner_aacd14 = 'E57') * owner_distance14 +
	    (integer)(owner_aacd15 = 'E57') * owner_distance15 +
	    (integer)(owner_aacd16 = 'E57') * owner_distance16 +
	    (integer)(owner_aacd17 = 'E57') * owner_distance17 +
	    (integer)(owner_aacd18 = 'E57') * owner_distance18 +
	    (integer)(owner_aacd19 = 'E57') * owner_distance19 +
	    (integer)(owner_aacd20 = 'E57') * owner_distance20 +
	    (integer)(owner_aacd21 = 'E57') * owner_distance21 +
	    (integer)(owner_aacd22 = 'E57') * owner_distance22 +
	    (integer)(owner_aacd23 = 'E57') * owner_distance23 +
	    (integer)(owner_aacd24 = 'E57') * owner_distance24 +
	    (integer)(owner_aacd25 = 'E57') * owner_distance25 +
	    (integer)(owner_aacd26 = 'E57') * owner_distance26 +
	    (integer)(owner_aacd27 = 'E57') * owner_distance27 +
	    (integer)(owner_aacd28 = 'E57') * owner_distance28 +
	    (integer)(owner_aacd29 = 'E57') * owner_distance29;
	
	owner_rcvaluef01 := (integer)(owner_aacd1 = 'F01') * owner_distance1 +
	    (integer)(owner_aacd2 = 'F01') * owner_distance2 +
	    (integer)(owner_aacd3 = 'F01') * owner_distance3 +
	    (integer)(owner_aacd4 = 'F01') * owner_distance4 +
	    (integer)(owner_aacd5 = 'F01') * owner_distance5 +
	    (integer)(owner_aacd6 = 'F01') * owner_distance6 +
	    (integer)(owner_aacd7 = 'F01') * owner_distance7 +
	    (integer)(owner_aacd8 = 'F01') * owner_distance8 +
	    (integer)(owner_aacd9 = 'F01') * owner_distance9 +
	    (integer)(owner_aacd10 = 'F01') * owner_distance10 +
	    (integer)(owner_aacd11 = 'F01') * owner_distance11 +
	    (integer)(owner_aacd12 = 'F01') * owner_distance12 +
	    (integer)(owner_aacd13 = 'F01') * owner_distance13 +
	    (integer)(owner_aacd14 = 'F01') * owner_distance14 +
	    (integer)(owner_aacd15 = 'F01') * owner_distance15 +
	    (integer)(owner_aacd16 = 'F01') * owner_distance16 +
	    (integer)(owner_aacd17 = 'F01') * owner_distance17 +
	    (integer)(owner_aacd18 = 'F01') * owner_distance18 +
	    (integer)(owner_aacd19 = 'F01') * owner_distance19 +
	    (integer)(owner_aacd20 = 'F01') * owner_distance20 +
	    (integer)(owner_aacd21 = 'F01') * owner_distance21 +
	    (integer)(owner_aacd22 = 'F01') * owner_distance22 +
	    (integer)(owner_aacd23 = 'F01') * owner_distance23 +
	    (integer)(owner_aacd24 = 'F01') * owner_distance24 +
	    (integer)(owner_aacd25 = 'F01') * owner_distance25 +
	    (integer)(owner_aacd26 = 'F01') * owner_distance26 +
	    (integer)(owner_aacd27 = 'F01') * owner_distance27 +
	    (integer)(owner_aacd28 = 'F01') * owner_distance28 +
	    (integer)(owner_aacd29 = 'F01') * owner_distance29;
	
	owner_rcvaluef03 := (integer)(owner_aacd1 = 'F03') * owner_distance1 +
	    (integer)(owner_aacd2 = 'F03') * owner_distance2 +
	    (integer)(owner_aacd3 = 'F03') * owner_distance3 +
	    (integer)(owner_aacd4 = 'F03') * owner_distance4 +
	    (integer)(owner_aacd5 = 'F03') * owner_distance5 +
	    (integer)(owner_aacd6 = 'F03') * owner_distance6 +
	    (integer)(owner_aacd7 = 'F03') * owner_distance7 +
	    (integer)(owner_aacd8 = 'F03') * owner_distance8 +
	    (integer)(owner_aacd9 = 'F03') * owner_distance9 +
	    (integer)(owner_aacd10 = 'F03') * owner_distance10 +
	    (integer)(owner_aacd11 = 'F03') * owner_distance11 +
	    (integer)(owner_aacd12 = 'F03') * owner_distance12 +
	    (integer)(owner_aacd13 = 'F03') * owner_distance13 +
	    (integer)(owner_aacd14 = 'F03') * owner_distance14 +
	    (integer)(owner_aacd15 = 'F03') * owner_distance15 +
	    (integer)(owner_aacd16 = 'F03') * owner_distance16 +
	    (integer)(owner_aacd17 = 'F03') * owner_distance17 +
	    (integer)(owner_aacd18 = 'F03') * owner_distance18 +
	    (integer)(owner_aacd19 = 'F03') * owner_distance19 +
	    (integer)(owner_aacd20 = 'F03') * owner_distance20 +
	    (integer)(owner_aacd21 = 'F03') * owner_distance21 +
	    (integer)(owner_aacd22 = 'F03') * owner_distance22 +
	    (integer)(owner_aacd23 = 'F03') * owner_distance23 +
	    (integer)(owner_aacd24 = 'F03') * owner_distance24 +
	    (integer)(owner_aacd25 = 'F03') * owner_distance25 +
	    (integer)(owner_aacd26 = 'F03') * owner_distance26 +
	    (integer)(owner_aacd27 = 'F03') * owner_distance27 +
	    (integer)(owner_aacd28 = 'F03') * owner_distance28 +
	    (integer)(owner_aacd29 = 'F03') * owner_distance29;
	
	owner_rcvaluei60 := (integer)(owner_aacd1 = 'I60') * owner_distance1 +
	    (integer)(owner_aacd2 = 'I60') * owner_distance2 +
	    (integer)(owner_aacd3 = 'I60') * owner_distance3 +
	    (integer)(owner_aacd4 = 'I60') * owner_distance4 +
	    (integer)(owner_aacd5 = 'I60') * owner_distance5 +
	    (integer)(owner_aacd6 = 'I60') * owner_distance6 +
	    (integer)(owner_aacd7 = 'I60') * owner_distance7 +
	    (integer)(owner_aacd8 = 'I60') * owner_distance8 +
	    (integer)(owner_aacd9 = 'I60') * owner_distance9 +
	    (integer)(owner_aacd10 = 'I60') * owner_distance10 +
	    (integer)(owner_aacd11 = 'I60') * owner_distance11 +
	    (integer)(owner_aacd12 = 'I60') * owner_distance12 +
	    (integer)(owner_aacd13 = 'I60') * owner_distance13 +
	    (integer)(owner_aacd14 = 'I60') * owner_distance14 +
	    (integer)(owner_aacd15 = 'I60') * owner_distance15 +
	    (integer)(owner_aacd16 = 'I60') * owner_distance16 +
	    (integer)(owner_aacd17 = 'I60') * owner_distance17 +
	    (integer)(owner_aacd18 = 'I60') * owner_distance18 +
	    (integer)(owner_aacd19 = 'I60') * owner_distance19 +
	    (integer)(owner_aacd20 = 'I60') * owner_distance20 +
	    (integer)(owner_aacd21 = 'I60') * owner_distance21 +
	    (integer)(owner_aacd22 = 'I60') * owner_distance22 +
	    (integer)(owner_aacd23 = 'I60') * owner_distance23 +
	    (integer)(owner_aacd24 = 'I60') * owner_distance24 +
	    (integer)(owner_aacd25 = 'I60') * owner_distance25 +
	    (integer)(owner_aacd26 = 'I60') * owner_distance26 +
	    (integer)(owner_aacd27 = 'I60') * owner_distance27 +
	    (integer)(owner_aacd28 = 'I60') * owner_distance28 +
	    (integer)(owner_aacd29 = 'I60') * owner_distance29;
	
	owner_rcvaluel77 := (integer)(owner_aacd1 = 'L77') * owner_distance1 +
	    (integer)(owner_aacd2 = 'L77') * owner_distance2 +
	    (integer)(owner_aacd3 = 'L77') * owner_distance3 +
	    (integer)(owner_aacd4 = 'L77') * owner_distance4 +
	    (integer)(owner_aacd5 = 'L77') * owner_distance5 +
	    (integer)(owner_aacd6 = 'L77') * owner_distance6 +
	    (integer)(owner_aacd7 = 'L77') * owner_distance7 +
	    (integer)(owner_aacd8 = 'L77') * owner_distance8 +
	    (integer)(owner_aacd9 = 'L77') * owner_distance9 +
	    (integer)(owner_aacd10 = 'L77') * owner_distance10 +
	    (integer)(owner_aacd11 = 'L77') * owner_distance11 +
	    (integer)(owner_aacd12 = 'L77') * owner_distance12 +
	    (integer)(owner_aacd13 = 'L77') * owner_distance13 +
	    (integer)(owner_aacd14 = 'L77') * owner_distance14 +
	    (integer)(owner_aacd15 = 'L77') * owner_distance15 +
	    (integer)(owner_aacd16 = 'L77') * owner_distance16 +
	    (integer)(owner_aacd17 = 'L77') * owner_distance17 +
	    (integer)(owner_aacd18 = 'L77') * owner_distance18 +
	    (integer)(owner_aacd19 = 'L77') * owner_distance19 +
	    (integer)(owner_aacd20 = 'L77') * owner_distance20 +
	    (integer)(owner_aacd21 = 'L77') * owner_distance21 +
	    (integer)(owner_aacd22 = 'L77') * owner_distance22 +
	    (integer)(owner_aacd23 = 'L77') * owner_distance23 +
	    (integer)(owner_aacd24 = 'L77') * owner_distance24 +
	    (integer)(owner_aacd25 = 'L77') * owner_distance25 +
	    (integer)(owner_aacd26 = 'L77') * owner_distance26 +
	    (integer)(owner_aacd27 = 'L77') * owner_distance27 +
	    (integer)(owner_aacd28 = 'L77') * owner_distance28 +
	    (integer)(owner_aacd29 = 'L77') * owner_distance29;
	
	owner_rcvaluel79 := (integer)(owner_aacd1 = 'L79') * owner_distance1 +
	    (integer)(owner_aacd2 = 'L79') * owner_distance2 +
	    (integer)(owner_aacd3 = 'L79') * owner_distance3 +
	    (integer)(owner_aacd4 = 'L79') * owner_distance4 +
	    (integer)(owner_aacd5 = 'L79') * owner_distance5 +
	    (integer)(owner_aacd6 = 'L79') * owner_distance6 +
	    (integer)(owner_aacd7 = 'L79') * owner_distance7 +
	    (integer)(owner_aacd8 = 'L79') * owner_distance8 +
	    (integer)(owner_aacd9 = 'L79') * owner_distance9 +
	    (integer)(owner_aacd10 = 'L79') * owner_distance10 +
	    (integer)(owner_aacd11 = 'L79') * owner_distance11 +
	    (integer)(owner_aacd12 = 'L79') * owner_distance12 +
	    (integer)(owner_aacd13 = 'L79') * owner_distance13 +
	    (integer)(owner_aacd14 = 'L79') * owner_distance14 +
	    (integer)(owner_aacd15 = 'L79') * owner_distance15 +
	    (integer)(owner_aacd16 = 'L79') * owner_distance16 +
	    (integer)(owner_aacd17 = 'L79') * owner_distance17 +
	    (integer)(owner_aacd18 = 'L79') * owner_distance18 +
	    (integer)(owner_aacd19 = 'L79') * owner_distance19 +
	    (integer)(owner_aacd20 = 'L79') * owner_distance20 +
	    (integer)(owner_aacd21 = 'L79') * owner_distance21 +
	    (integer)(owner_aacd22 = 'L79') * owner_distance22 +
	    (integer)(owner_aacd23 = 'L79') * owner_distance23 +
	    (integer)(owner_aacd24 = 'L79') * owner_distance24 +
	    (integer)(owner_aacd25 = 'L79') * owner_distance25 +
	    (integer)(owner_aacd26 = 'L79') * owner_distance26 +
	    (integer)(owner_aacd27 = 'L79') * owner_distance27 +
	    (integer)(owner_aacd28 = 'L79') * owner_distance28 +
	    (integer)(owner_aacd29 = 'L79') * owner_distance29;
	
	owner_rcvaluel80 := (integer)(owner_aacd1 = 'L80') * owner_distance1 +
	    (integer)(owner_aacd2 = 'L80') * owner_distance2 +
	    (integer)(owner_aacd3 = 'L80') * owner_distance3 +
	    (integer)(owner_aacd4 = 'L80') * owner_distance4 +
	    (integer)(owner_aacd5 = 'L80') * owner_distance5 +
	    (integer)(owner_aacd6 = 'L80') * owner_distance6 +
	    (integer)(owner_aacd7 = 'L80') * owner_distance7 +
	    (integer)(owner_aacd8 = 'L80') * owner_distance8 +
	    (integer)(owner_aacd9 = 'L80') * owner_distance9 +
	    (integer)(owner_aacd10 = 'L80') * owner_distance10 +
	    (integer)(owner_aacd11 = 'L80') * owner_distance11 +
	    (integer)(owner_aacd12 = 'L80') * owner_distance12 +
	    (integer)(owner_aacd13 = 'L80') * owner_distance13 +
	    (integer)(owner_aacd14 = 'L80') * owner_distance14 +
	    (integer)(owner_aacd15 = 'L80') * owner_distance15 +
	    (integer)(owner_aacd16 = 'L80') * owner_distance16 +
	    (integer)(owner_aacd17 = 'L80') * owner_distance17 +
	    (integer)(owner_aacd18 = 'L80') * owner_distance18 +
	    (integer)(owner_aacd19 = 'L80') * owner_distance19 +
	    (integer)(owner_aacd20 = 'L80') * owner_distance20 +
	    (integer)(owner_aacd21 = 'L80') * owner_distance21 +
	    (integer)(owner_aacd22 = 'L80') * owner_distance22 +
	    (integer)(owner_aacd23 = 'L80') * owner_distance23 +
	    (integer)(owner_aacd24 = 'L80') * owner_distance24 +
	    (integer)(owner_aacd25 = 'L80') * owner_distance25 +
	    (integer)(owner_aacd26 = 'L80') * owner_distance26 +
	    (integer)(owner_aacd27 = 'L80') * owner_distance27 +
	    (integer)(owner_aacd28 = 'L80') * owner_distance28 +
	    (integer)(owner_aacd29 = 'L80') * owner_distance29;
	
	owner_rcvalues66 := (integer)(owner_aacd1 = 'S66') * owner_distance1 +
	    (integer)(owner_aacd2 = 'S66') * owner_distance2 +
	    (integer)(owner_aacd3 = 'S66') * owner_distance3 +
	    (integer)(owner_aacd4 = 'S66') * owner_distance4 +
	    (integer)(owner_aacd5 = 'S66') * owner_distance5 +
	    (integer)(owner_aacd6 = 'S66') * owner_distance6 +
	    (integer)(owner_aacd7 = 'S66') * owner_distance7 +
	    (integer)(owner_aacd8 = 'S66') * owner_distance8 +
	    (integer)(owner_aacd9 = 'S66') * owner_distance9 +
	    (integer)(owner_aacd10 = 'S66') * owner_distance10 +
	    (integer)(owner_aacd11 = 'S66') * owner_distance11 +
	    (integer)(owner_aacd12 = 'S66') * owner_distance12 +
	    (integer)(owner_aacd13 = 'S66') * owner_distance13 +
	    (integer)(owner_aacd14 = 'S66') * owner_distance14 +
	    (integer)(owner_aacd15 = 'S66') * owner_distance15 +
	    (integer)(owner_aacd16 = 'S66') * owner_distance16 +
	    (integer)(owner_aacd17 = 'S66') * owner_distance17 +
	    (integer)(owner_aacd18 = 'S66') * owner_distance18 +
	    (integer)(owner_aacd19 = 'S66') * owner_distance19 +
	    (integer)(owner_aacd20 = 'S66') * owner_distance20 +
	    (integer)(owner_aacd21 = 'S66') * owner_distance21 +
	    (integer)(owner_aacd22 = 'S66') * owner_distance22 +
	    (integer)(owner_aacd23 = 'S66') * owner_distance23 +
	    (integer)(owner_aacd24 = 'S66') * owner_distance24 +
	    (integer)(owner_aacd25 = 'S66') * owner_distance25 +
	    (integer)(owner_aacd26 = 'S66') * owner_distance26 +
	    (integer)(owner_aacd27 = 'S66') * owner_distance27 +
	    (integer)(owner_aacd28 = 'S66') * owner_distance28 +
	    (integer)(owner_aacd29 = 'S66') * owner_distance29;
	
	owner_rawscore := owner_subscore1 +
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
	    owner_subscore14 +
	    owner_subscore15 +
	    owner_subscore16 +
	    owner_subscore17 +
	    owner_subscore18 +
	    owner_subscore19 +
	    owner_subscore20 +
	    owner_subscore21 +
	    owner_subscore22 +
	    owner_subscore23 +
	    owner_subscore24 +
	    owner_subscore25 +
	    owner_subscore26 +
	    owner_subscore27 +
	    owner_subscore28 +
	    owner_subscore29;
	
	owner_lnoddsscore := owner_rawscore + 2.928817;
	
	other_subscore1 := map(
	    NULL < iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 1 => 0.086892,
	    1 <= iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 3   => -0.260553,
	    3 <= iv_i60_inq_auto_recency                                   => 0.072540,
	                                                                      0.000000);
	
	other_aacd1 := map(
	    NULL < iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 1 => 'I60',
	    1 <= iv_i60_inq_auto_recency AND iv_i60_inq_auto_recency < 3   => 'I60',
	    3 <= iv_i60_inq_auto_recency                                   => 'I60',
	                                                                      '');
	
	other_distance1 := if(other_aacd1 = '', 0, other_subscore1 - 0.086892);
	
	other_aacd2 := map(
	    NULL < iv_i60_credit_seeking AND iv_i60_credit_seeking < 1 => 'I60',
	    1 <= iv_i60_credit_seeking                                 => 'I60',
	                                                                  '');
	
	other_subscore2 := map(
	    NULL < iv_i60_credit_seeking AND iv_i60_credit_seeking < 1 => 0.076456,
	    1 <= iv_i60_credit_seeking                                 => -0.217737,
	                                                                  0.000000);
	
	other_distance2 := if(other_aacd2 = '', 0, other_subscore2 - 0.076456);
	
	other_aacd3 := map(
	    (rv_e55_college_ind_shell5 in ['0']) => 'E55',
	    (rv_e55_college_ind_shell5 in ['1']) => 'E55',
	                                            '');
	
	other_subscore3 := map(
	    (rv_e55_college_ind_shell5 in ['0']) => -0.024413,
	    (rv_e55_college_ind_shell5 in ['1']) => 0.194427,
	                                            0.000000);
	
	other_distance3 := if(other_aacd3 = '', 0, other_subscore3 - 0.194427);
	
	other_subscore4 := map(
	    NULL < rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 0   => 0.000000,
	    0 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 52    => -0.263065,
	    52 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 161  => -0.052473,
	    161 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 246 => -0.031544,
	    246 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 298 => 0.066433,
	    298 <= rv_c21_m_bureau_adl_fs                                  => 0.153570,
	                                                                      0.000000);
	
	other_aacd4 := map(
	    NULL < rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 0   => 'C21',
	    0 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 52    => 'C21',
	    52 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 161  => 'C21',
	    161 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 246 => 'C21',
	    246 <= rv_c21_m_bureau_adl_fs AND rv_c21_m_bureau_adl_fs < 298 => 'C21',
	    298 <= rv_c21_m_bureau_adl_fs                                  => 'C21',
	                                                                      '');
	
	other_distance4 := if(other_aacd4 = '', 0, other_subscore4 - 0.153570);
	
	other_aacd5 := map(
	    (iv_f07_address_match in ['0 InputPop NoHistAvail', '1 Curr OnHdrOnly', '2 CurrAvail + InputNotCurr']) => 'F03',
	    (iv_f07_address_match in ['3 CurrAvail + NoInputPop', '4 Input=Curr'])                                 => 'F03',
	                                                                                                              '');
	
	other_subscore5 := map(
	    (iv_f07_address_match in ['0 InputPop NoHistAvail', '1 Curr OnHdrOnly', '2 CurrAvail + InputNotCurr']) => -0.130507,
	    (iv_f07_address_match in ['3 CurrAvail + NoInputPop', '4 Input=Curr'])                                 => 0.076499,
	                                                                                                              0.000000);
	
	other_distance5 := if(other_aacd5 = '', 0, other_subscore5 - 0.076499);
	
	other_subscore6 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 0.049009,
	    2 <= rv_c15_ssns_per_adl                               => -0.143801,
	                                                              0.000000);
	
	other_aacd6 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 'C15',
	    2 <= rv_c15_ssns_per_adl                               => 'C15',
	                                                              '');
	
	other_distance6 := if(other_aacd6 = '', 0, other_subscore6 - 0.049009);
	
	other_subscore7 := map(
	    NULL < iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 17 => -0.060951,
	    17 <= iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 119 => 0.098219,
	    119 <= iv_a50_pb_average_dollars                                    => 0.161471,
	                                                                           0.000000);
	
	other_aacd7 := map(
	    NULL < iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 17 => 'A50',
	    17 <= iv_a50_pb_average_dollars AND iv_a50_pb_average_dollars < 119 => 'A50',
	    119 <= iv_a50_pb_average_dollars                                    => 'A50',
	                                                                           '');
	
	other_distance7 := if(other_aacd7 = '', 0, other_subscore7 - 0.161471);
	
	other_subscore8 := map(
	    NULL < iv_i60_inq_hiriskcred_count12 AND iv_i60_inq_hiriskcred_count12 < 1 => 0.012146,
	    1 <= iv_i60_inq_hiriskcred_count12                                         => -0.451189,
	                                                                                  -0.000000);
	
	other_aacd8 := map(
	    NULL < iv_i60_inq_hiriskcred_count12 AND iv_i60_inq_hiriskcred_count12 < 1 => 'I60',
	    1 <= iv_i60_inq_hiriskcred_count12                                         => 'I60',
	                                                                                  '');
	
	other_distance8 := if(other_aacd8 = '', 0, other_subscore8 - 0.012146);
	
	other_subscore9 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 86  => -0.142661,
	    86 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 249  => 0.003307,
	    249 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 329 => 0.032325,
	    329 <= rv_c10_m_hdr_fs                           => 0.105978,
	                                                        0.000000);
	
	other_aacd9 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 86  => 'C10',
	    86 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 249  => 'C10',
	    249 <= rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 329 => 'C10',
	    329 <= rv_c10_m_hdr_fs                           => 'C10',
	                                                        '');
	
	other_distance9 := if(other_aacd9 = '', 0, other_subscore9 - 0.105978);
	
	other_subscore10 := map(
	    NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval <= 0   	=> 0.000000,
	    0 < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 69105 		=> -0.169954,
	    69105 <= rv_a47_inp_avm_autoval                                   => 0.049252,
	                                                                         0.000000);
	
	other_aacd10 := map(
	    // NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 3551   => 'A51',
	    NULL < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval <= 0   	=> 'A51',
	    // 3551 <= rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 69105 => 'L80',
	    0 < rv_a47_inp_avm_autoval AND rv_a47_inp_avm_autoval < 69105 		=> 'L80',
	    69105 <= rv_a47_inp_avm_autoval                                   => 'L80',
	                                                                         '');
	
	other_distance10 := if(other_aacd10 = '', 0, other_subscore10 - 0.049252);
	
	other_subscore11 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 0.035554,
	    1 <= rv_i60_inq_count12                              => -0.083249,
	                                                            0.000000);
	
	other_aacd11 := map(
	    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 1 => 'I60',
	    1 <= rv_i60_inq_count12                              => 'I60',
	                                                            '');
	
	other_distance11 := if(other_aacd11 = '', 0, other_subscore11 - 0.035554);
	
	other_aacd12 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	other_subscore12 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.040410,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.032397,
	    3 <= rv_s66_adlperssn_count                                  => -0.093581,
	                                                                    0.000000);
	
	other_distance12 := if(other_aacd12 = '', 0, other_subscore12 - 0.040410);
	
	other_aacd13 := map(
	    NULL < iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 40 => 'F01',
	    40 <= iv_f02_inp_addr_address_score                                         => 'F01',
	                                                                                   '');
	
	other_subscore13 := map(
	    NULL < iv_f02_inp_addr_address_score AND iv_f02_inp_addr_address_score < 40 => -0.092005,
	    40 <= iv_f02_inp_addr_address_score                                         => 0.027492,
	                                                                                   -0.000000);
	
	other_distance13 := if(other_aacd13 = '', 0, other_subscore13 - 0.027492);
	
	other_aacd14 := map(
	    NULL < iv_c13_attr_addrs_recency AND iv_c13_attr_addrs_recency < 12 => 'C13',
	    12 <= iv_c13_attr_addrs_recency AND iv_c13_attr_addrs_recency < 24  => 'C13',
	    24 <= iv_c13_attr_addrs_recency AND iv_c13_attr_addrs_recency < 120 => 'C13',
	    120 <= iv_c13_attr_addrs_recency                                    => 'C13',
	                                                                           '');
	
	other_subscore14 := map(
	    NULL < iv_c13_attr_addrs_recency AND iv_c13_attr_addrs_recency < 12 => -0.067872,
	    12 <= iv_c13_attr_addrs_recency AND iv_c13_attr_addrs_recency < 24  => -0.032468,
	    24 <= iv_c13_attr_addrs_recency AND iv_c13_attr_addrs_recency < 120 => 0.020028,
	    120 <= iv_c13_attr_addrs_recency                                    => 0.095994,
	                                                                           0.000000);
	
	other_distance14 := if(other_aacd14 = '', 0, other_subscore14 - 0.095994);
	
	other_subscore15 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 0 => -0.008505,
	    0 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 19  => -0.173114,
	    19 <= iv_a50_pb_total_dollars                                  => 0.034909,
	                                                                      -0.000000);
	
	other_aacd15 := map(
	    NULL < iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 0 => 'A50',
	    0 <= iv_a50_pb_total_dollars AND iv_a50_pb_total_dollars < 19  => 'A50',
	    19 <= iv_a50_pb_total_dollars                                  => 'A50',
	                                                                      '');
	
	other_distance15 := if(other_aacd15 = '', 0, other_subscore15 - 0.034909);
	
	other_aacd16 := map(
	    NULL < iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 3 => 'C13',
	    3 <= iv_c13_inp_addr_lres                                => 'C13',
	                                                                '');
	
	other_subscore16 := map(
	    NULL < iv_c13_inp_addr_lres AND iv_c13_inp_addr_lres < 3 => -0.060833,
	    3 <= iv_c13_inp_addr_lres                                => 0.027931,
	                                                                0.000000);
	
	other_distance16 := if(other_aacd16 = '', 0, other_subscore16 - 0.027931);
	
	other_subscore17 := map(
	    (iv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 0.281396,
	    (iv_a43_rec_vehx_level in ['XX'])                         => -0.005825,
	                                                                 0.000000);
	
	other_aacd17 := map(
	    (iv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 'A43',
	    (iv_a43_rec_vehx_level in ['XX'])                         => 'A43',
	                                                                 '');
	
	other_distance17 := if(other_aacd17 = '', 0, other_subscore17 - 0.281396);
	
	other_subscore18 := map(
	    NULL < iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 4 => 0.013550,
	    4 <= iv_c14_addrs_5yr                            => -0.073098,
	                                                        0.000000);
	
	other_aacd18 := map(
	    NULL < iv_c14_addrs_5yr AND iv_c14_addrs_5yr < 4 => 'C14',
	    4 <= iv_c14_addrs_5yr                            => 'C14',
	                                                        '');
	
	other_distance18 := if(other_aacd18 = '', 0, other_subscore18 - 0.013550);
	
	other_aacd19 := map(
	    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 4 => 'C13',
	    4 <= rv_c13_curr_addr_lres                                 => 'C13',
	                                                                  '');
	
	other_subscore19 := map(
	    NULL < rv_c13_curr_addr_lres AND rv_c13_curr_addr_lres < 4 => -0.082666,
	    4 <= rv_c13_curr_addr_lres                                 => 0.010713,
	                                                                  0.000000);
	
	other_distance19 := if(other_aacd19 = '', 0, other_subscore19 - 0.010713);
	
	other_aacd20 := map(
	    NULL < iv_a50_pb_total_orders AND iv_a50_pb_total_orders < 1 => 'A50',
	    1 <= iv_a50_pb_total_orders                                  => 'A50',
	                                                                    '');
	
	other_subscore20 := map(
	    NULL < iv_a50_pb_total_orders AND iv_a50_pb_total_orders < 1 => -0.025217,
	    1 <= iv_a50_pb_total_orders                                  => 0.033770,
	                                                                    0.000000);
	
	other_distance20 := if(other_aacd20 = '', 0, other_subscore20 - 0.033770);
	
	other_subscore21 := map(
	    NULL < iv_i60_inq_phones_per_adl AND iv_i60_inq_phones_per_adl < 2 => 0.005445,
	    2 <= iv_i60_inq_phones_per_adl                                     => -0.135903,
	                                                                          -0.000000);
	
	other_aacd21 := map(
	    NULL < iv_i60_inq_phones_per_adl AND iv_i60_inq_phones_per_adl < 2 => 'I60',
	    2 <= iv_i60_inq_phones_per_adl                                     => 'I60',
	                                                                          '');
	
	other_distance21 := if(other_aacd21 = '', 0, other_subscore21 - 0.005445);
	
	other_subscore22 := map(
	    (iv_e57_prof_license_flag in ['0']) => -0.006481,
	    (iv_e57_prof_license_flag in ['1']) => 0.112475,
	                                           0.000000);
	
	other_aacd22 := map(
	    (iv_e57_prof_license_flag in ['0']) => 'E57',
	    (iv_e57_prof_license_flag in ['1']) => 'E57',
	                                           '');
	
	other_distance22 := if(other_aacd22 = '', 0, other_subscore22 - 0.112475);
	
	other_aacd23 := map(
	    NULL < iv_br_source_count AND iv_br_source_count < 1 => 'E57',
	    1 <= iv_br_source_count                              => 'E57',
	                                                            '');
	
	other_subscore23 := map(
	    NULL < iv_br_source_count AND iv_br_source_count < 1 => -0.006519,
	    1 <= iv_br_source_count                              => 0.065954,
	                                                            -0.000000);
	
	other_distance23 := if(other_aacd23 = '', 0, other_subscore23 - 0.065954);
	
	other_subscore24 := map(
	    NULL < iv_c20_email_domain_free_count AND iv_c20_email_domain_free_count < 1 => 0.016662,
	    1 <= iv_c20_email_domain_free_count                                          => -0.020987,
	                                                                                    0.000000);
	
	other_aacd24 := map(
	    NULL < iv_c20_email_domain_free_count AND iv_c20_email_domain_free_count < 1 => 'C20',
	    1 <= iv_c20_email_domain_free_count                                          => 'C20',
	                                                                                    '');
	
	other_distance24 := if(other_aacd24 = '', 0, other_subscore24 - 0.016662);
	
	other_aacd25 := map(
	    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 5 => 'C13',
	    5 <= iv_c13_avg_lres                           => 'C13',
	                                                      '');
	
	other_subscore25 := map(
	    NULL < iv_c13_avg_lres AND iv_c13_avg_lres < 5 => -0.103819,
	    5 <= iv_c13_avg_lres                           => 0.003325,
	                                                      -0.000000);
	
	other_distance25 := if(other_aacd25 = '', 0, other_subscore25 - 0.003325);
	
	other_subscore26 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 15 => -0.090180,
	    15 <= rv_c12_source_profile AND rv_c12_source_profile < 34  => -0.023633,
	    34 <= rv_c12_source_profile AND rv_c12_source_profile < 64  => -0.001488,
	    64 <= rv_c12_source_profile                                 => 0.010388,
	                                                                   0.000000);
	
	other_aacd26 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 15 => 'C12',
	    15 <= rv_c12_source_profile AND rv_c12_source_profile < 34  => 'C12',
	    34 <= rv_c12_source_profile AND rv_c12_source_profile < 64  => 'C12',
	    64 <= rv_c12_source_profile                                 => 'C12',
	                                                                   '');
	
	other_distance26 := if(other_aacd26 = '', 0, other_subscore26 - 0.010388);
	
	other_subscore27 := map(
	    NULL < iv_l79_adls_per_addr_c6 AND iv_l79_adls_per_addr_c6 < 1 => 0.009828,
	    1 <= iv_l79_adls_per_addr_c6                                   => -0.019334,
	                                                                      0.000000);
	
	other_aacd27 := map(
	    NULL < iv_l79_adls_per_addr_c6 AND iv_l79_adls_per_addr_c6 < 1 => 'L79',
	    1 <= iv_l79_adls_per_addr_c6                                   => 'L79',
	                                                                      '');
	
	other_distance27 := if(other_aacd27 = '', 0, other_subscore27 - 0.009828);
	
	other_rcvaluea43 := (integer)(other_aacd1 = 'A43') * other_distance1 +
	    (integer)(other_aacd2 = 'A43') * other_distance2 +
	    (integer)(other_aacd3 = 'A43') * other_distance3 +
	    (integer)(other_aacd4 = 'A43') * other_distance4 +
	    (integer)(other_aacd5 = 'A43') * other_distance5 +
	    (integer)(other_aacd6 = 'A43') * other_distance6 +
	    (integer)(other_aacd7 = 'A43') * other_distance7 +
	    (integer)(other_aacd8 = 'A43') * other_distance8 +
	    (integer)(other_aacd9 = 'A43') * other_distance9 +
	    (integer)(other_aacd10 = 'A43') * other_distance10 +
	    (integer)(other_aacd11 = 'A43') * other_distance11 +
	    (integer)(other_aacd12 = 'A43') * other_distance12 +
	    (integer)(other_aacd13 = 'A43') * other_distance13 +
	    (integer)(other_aacd14 = 'A43') * other_distance14 +
	    (integer)(other_aacd15 = 'A43') * other_distance15 +
	    (integer)(other_aacd16 = 'A43') * other_distance16 +
	    (integer)(other_aacd17 = 'A43') * other_distance17 +
	    (integer)(other_aacd18 = 'A43') * other_distance18 +
	    (integer)(other_aacd19 = 'A43') * other_distance19 +
	    (integer)(other_aacd20 = 'A43') * other_distance20 +
	    (integer)(other_aacd21 = 'A43') * other_distance21 +
	    (integer)(other_aacd22 = 'A43') * other_distance22 +
	    (integer)(other_aacd23 = 'A43') * other_distance23 +
	    (integer)(other_aacd24 = 'A43') * other_distance24 +
	    (integer)(other_aacd25 = 'A43') * other_distance25 +
	    (integer)(other_aacd26 = 'A43') * other_distance26 +
	    (integer)(other_aacd27 = 'A43') * other_distance27;
	
	other_rcvaluea50 := (integer)(other_aacd1 = 'A50') * other_distance1 +
	    (integer)(other_aacd2 = 'A50') * other_distance2 +
	    (integer)(other_aacd3 = 'A50') * other_distance3 +
	    (integer)(other_aacd4 = 'A50') * other_distance4 +
	    (integer)(other_aacd5 = 'A50') * other_distance5 +
	    (integer)(other_aacd6 = 'A50') * other_distance6 +
	    (integer)(other_aacd7 = 'A50') * other_distance7 +
	    (integer)(other_aacd8 = 'A50') * other_distance8 +
	    (integer)(other_aacd9 = 'A50') * other_distance9 +
	    (integer)(other_aacd10 = 'A50') * other_distance10 +
	    (integer)(other_aacd11 = 'A50') * other_distance11 +
	    (integer)(other_aacd12 = 'A50') * other_distance12 +
	    (integer)(other_aacd13 = 'A50') * other_distance13 +
	    (integer)(other_aacd14 = 'A50') * other_distance14 +
	    (integer)(other_aacd15 = 'A50') * other_distance15 +
	    (integer)(other_aacd16 = 'A50') * other_distance16 +
	    (integer)(other_aacd17 = 'A50') * other_distance17 +
	    (integer)(other_aacd18 = 'A50') * other_distance18 +
	    (integer)(other_aacd19 = 'A50') * other_distance19 +
	    (integer)(other_aacd20 = 'A50') * other_distance20 +
	    (integer)(other_aacd21 = 'A50') * other_distance21 +
	    (integer)(other_aacd22 = 'A50') * other_distance22 +
	    (integer)(other_aacd23 = 'A50') * other_distance23 +
	    (integer)(other_aacd24 = 'A50') * other_distance24 +
	    (integer)(other_aacd25 = 'A50') * other_distance25 +
	    (integer)(other_aacd26 = 'A50') * other_distance26 +
	    (integer)(other_aacd27 = 'A50') * other_distance27;
	
	other_rcvaluea51 := (integer)(other_aacd1 = 'A51') * other_distance1 +
	    (integer)(other_aacd2 = 'A51') * other_distance2 +
	    (integer)(other_aacd3 = 'A51') * other_distance3 +
	    (integer)(other_aacd4 = 'A51') * other_distance4 +
	    (integer)(other_aacd5 = 'A51') * other_distance5 +
	    (integer)(other_aacd6 = 'A51') * other_distance6 +
	    (integer)(other_aacd7 = 'A51') * other_distance7 +
	    (integer)(other_aacd8 = 'A51') * other_distance8 +
	    (integer)(other_aacd9 = 'A51') * other_distance9 +
	    (integer)(other_aacd10 = 'A51') * other_distance10 +
	    (integer)(other_aacd11 = 'A51') * other_distance11 +
	    (integer)(other_aacd12 = 'A51') * other_distance12 +
	    (integer)(other_aacd13 = 'A51') * other_distance13 +
	    (integer)(other_aacd14 = 'A51') * other_distance14 +
	    (integer)(other_aacd15 = 'A51') * other_distance15 +
	    (integer)(other_aacd16 = 'A51') * other_distance16 +
	    (integer)(other_aacd17 = 'A51') * other_distance17 +
	    (integer)(other_aacd18 = 'A51') * other_distance18 +
	    (integer)(other_aacd19 = 'A51') * other_distance19 +
	    (integer)(other_aacd20 = 'A51') * other_distance20 +
	    (integer)(other_aacd21 = 'A51') * other_distance21 +
	    (integer)(other_aacd22 = 'A51') * other_distance22 +
	    (integer)(other_aacd23 = 'A51') * other_distance23 +
	    (integer)(other_aacd24 = 'A51') * other_distance24 +
	    (integer)(other_aacd25 = 'A51') * other_distance25 +
	    (integer)(other_aacd26 = 'A51') * other_distance26 +
	    (integer)(other_aacd27 = 'A51') * other_distance27;
	
	other_rcvaluec10 := (integer)(other_aacd1 = 'C10') * other_distance1 +
	    (integer)(other_aacd2 = 'C10') * other_distance2 +
	    (integer)(other_aacd3 = 'C10') * other_distance3 +
	    (integer)(other_aacd4 = 'C10') * other_distance4 +
	    (integer)(other_aacd5 = 'C10') * other_distance5 +
	    (integer)(other_aacd6 = 'C10') * other_distance6 +
	    (integer)(other_aacd7 = 'C10') * other_distance7 +
	    (integer)(other_aacd8 = 'C10') * other_distance8 +
	    (integer)(other_aacd9 = 'C10') * other_distance9 +
	    (integer)(other_aacd10 = 'C10') * other_distance10 +
	    (integer)(other_aacd11 = 'C10') * other_distance11 +
	    (integer)(other_aacd12 = 'C10') * other_distance12 +
	    (integer)(other_aacd13 = 'C10') * other_distance13 +
	    (integer)(other_aacd14 = 'C10') * other_distance14 +
	    (integer)(other_aacd15 = 'C10') * other_distance15 +
	    (integer)(other_aacd16 = 'C10') * other_distance16 +
	    (integer)(other_aacd17 = 'C10') * other_distance17 +
	    (integer)(other_aacd18 = 'C10') * other_distance18 +
	    (integer)(other_aacd19 = 'C10') * other_distance19 +
	    (integer)(other_aacd20 = 'C10') * other_distance20 +
	    (integer)(other_aacd21 = 'C10') * other_distance21 +
	    (integer)(other_aacd22 = 'C10') * other_distance22 +
	    (integer)(other_aacd23 = 'C10') * other_distance23 +
	    (integer)(other_aacd24 = 'C10') * other_distance24 +
	    (integer)(other_aacd25 = 'C10') * other_distance25 +
	    (integer)(other_aacd26 = 'C10') * other_distance26 +
	    (integer)(other_aacd27 = 'C10') * other_distance27;
	
	other_rcvaluec12 := (integer)(other_aacd1 = 'C12') * other_distance1 +
	    (integer)(other_aacd2 = 'C12') * other_distance2 +
	    (integer)(other_aacd3 = 'C12') * other_distance3 +
	    (integer)(other_aacd4 = 'C12') * other_distance4 +
	    (integer)(other_aacd5 = 'C12') * other_distance5 +
	    (integer)(other_aacd6 = 'C12') * other_distance6 +
	    (integer)(other_aacd7 = 'C12') * other_distance7 +
	    (integer)(other_aacd8 = 'C12') * other_distance8 +
	    (integer)(other_aacd9 = 'C12') * other_distance9 +
	    (integer)(other_aacd10 = 'C12') * other_distance10 +
	    (integer)(other_aacd11 = 'C12') * other_distance11 +
	    (integer)(other_aacd12 = 'C12') * other_distance12 +
	    (integer)(other_aacd13 = 'C12') * other_distance13 +
	    (integer)(other_aacd14 = 'C12') * other_distance14 +
	    (integer)(other_aacd15 = 'C12') * other_distance15 +
	    (integer)(other_aacd16 = 'C12') * other_distance16 +
	    (integer)(other_aacd17 = 'C12') * other_distance17 +
	    (integer)(other_aacd18 = 'C12') * other_distance18 +
	    (integer)(other_aacd19 = 'C12') * other_distance19 +
	    (integer)(other_aacd20 = 'C12') * other_distance20 +
	    (integer)(other_aacd21 = 'C12') * other_distance21 +
	    (integer)(other_aacd22 = 'C12') * other_distance22 +
	    (integer)(other_aacd23 = 'C12') * other_distance23 +
	    (integer)(other_aacd24 = 'C12') * other_distance24 +
	    (integer)(other_aacd25 = 'C12') * other_distance25 +
	    (integer)(other_aacd26 = 'C12') * other_distance26 +
	    (integer)(other_aacd27 = 'C12') * other_distance27;
	
	other_rcvaluec13 := (integer)(other_aacd1 = 'C13') * other_distance1 +
	    (integer)(other_aacd2 = 'C13') * other_distance2 +
	    (integer)(other_aacd3 = 'C13') * other_distance3 +
	    (integer)(other_aacd4 = 'C13') * other_distance4 +
	    (integer)(other_aacd5 = 'C13') * other_distance5 +
	    (integer)(other_aacd6 = 'C13') * other_distance6 +
	    (integer)(other_aacd7 = 'C13') * other_distance7 +
	    (integer)(other_aacd8 = 'C13') * other_distance8 +
	    (integer)(other_aacd9 = 'C13') * other_distance9 +
	    (integer)(other_aacd10 = 'C13') * other_distance10 +
	    (integer)(other_aacd11 = 'C13') * other_distance11 +
	    (integer)(other_aacd12 = 'C13') * other_distance12 +
	    (integer)(other_aacd13 = 'C13') * other_distance13 +
	    (integer)(other_aacd14 = 'C13') * other_distance14 +
	    (integer)(other_aacd15 = 'C13') * other_distance15 +
	    (integer)(other_aacd16 = 'C13') * other_distance16 +
	    (integer)(other_aacd17 = 'C13') * other_distance17 +
	    (integer)(other_aacd18 = 'C13') * other_distance18 +
	    (integer)(other_aacd19 = 'C13') * other_distance19 +
	    (integer)(other_aacd20 = 'C13') * other_distance20 +
	    (integer)(other_aacd21 = 'C13') * other_distance21 +
	    (integer)(other_aacd22 = 'C13') * other_distance22 +
	    (integer)(other_aacd23 = 'C13') * other_distance23 +
	    (integer)(other_aacd24 = 'C13') * other_distance24 +
	    (integer)(other_aacd25 = 'C13') * other_distance25 +
	    (integer)(other_aacd26 = 'C13') * other_distance26 +
	    (integer)(other_aacd27 = 'C13') * other_distance27;
	
	other_rcvaluec14 := (integer)(other_aacd1 = 'C14') * other_distance1 +
	    (integer)(other_aacd2 = 'C14') * other_distance2 +
	    (integer)(other_aacd3 = 'C14') * other_distance3 +
	    (integer)(other_aacd4 = 'C14') * other_distance4 +
	    (integer)(other_aacd5 = 'C14') * other_distance5 +
	    (integer)(other_aacd6 = 'C14') * other_distance6 +
	    (integer)(other_aacd7 = 'C14') * other_distance7 +
	    (integer)(other_aacd8 = 'C14') * other_distance8 +
	    (integer)(other_aacd9 = 'C14') * other_distance9 +
	    (integer)(other_aacd10 = 'C14') * other_distance10 +
	    (integer)(other_aacd11 = 'C14') * other_distance11 +
	    (integer)(other_aacd12 = 'C14') * other_distance12 +
	    (integer)(other_aacd13 = 'C14') * other_distance13 +
	    (integer)(other_aacd14 = 'C14') * other_distance14 +
	    (integer)(other_aacd15 = 'C14') * other_distance15 +
	    (integer)(other_aacd16 = 'C14') * other_distance16 +
	    (integer)(other_aacd17 = 'C14') * other_distance17 +
	    (integer)(other_aacd18 = 'C14') * other_distance18 +
	    (integer)(other_aacd19 = 'C14') * other_distance19 +
	    (integer)(other_aacd20 = 'C14') * other_distance20 +
	    (integer)(other_aacd21 = 'C14') * other_distance21 +
	    (integer)(other_aacd22 = 'C14') * other_distance22 +
	    (integer)(other_aacd23 = 'C14') * other_distance23 +
	    (integer)(other_aacd24 = 'C14') * other_distance24 +
	    (integer)(other_aacd25 = 'C14') * other_distance25 +
	    (integer)(other_aacd26 = 'C14') * other_distance26 +
	    (integer)(other_aacd27 = 'C14') * other_distance27;
	
	other_rcvaluec15 := (integer)(other_aacd1 = 'C15') * other_distance1 +
	    (integer)(other_aacd2 = 'C15') * other_distance2 +
	    (integer)(other_aacd3 = 'C15') * other_distance3 +
	    (integer)(other_aacd4 = 'C15') * other_distance4 +
	    (integer)(other_aacd5 = 'C15') * other_distance5 +
	    (integer)(other_aacd6 = 'C15') * other_distance6 +
	    (integer)(other_aacd7 = 'C15') * other_distance7 +
	    (integer)(other_aacd8 = 'C15') * other_distance8 +
	    (integer)(other_aacd9 = 'C15') * other_distance9 +
	    (integer)(other_aacd10 = 'C15') * other_distance10 +
	    (integer)(other_aacd11 = 'C15') * other_distance11 +
	    (integer)(other_aacd12 = 'C15') * other_distance12 +
	    (integer)(other_aacd13 = 'C15') * other_distance13 +
	    (integer)(other_aacd14 = 'C15') * other_distance14 +
	    (integer)(other_aacd15 = 'C15') * other_distance15 +
	    (integer)(other_aacd16 = 'C15') * other_distance16 +
	    (integer)(other_aacd17 = 'C15') * other_distance17 +
	    (integer)(other_aacd18 = 'C15') * other_distance18 +
	    (integer)(other_aacd19 = 'C15') * other_distance19 +
	    (integer)(other_aacd20 = 'C15') * other_distance20 +
	    (integer)(other_aacd21 = 'C15') * other_distance21 +
	    (integer)(other_aacd22 = 'C15') * other_distance22 +
	    (integer)(other_aacd23 = 'C15') * other_distance23 +
	    (integer)(other_aacd24 = 'C15') * other_distance24 +
	    (integer)(other_aacd25 = 'C15') * other_distance25 +
	    (integer)(other_aacd26 = 'C15') * other_distance26 +
	    (integer)(other_aacd27 = 'C15') * other_distance27;
	
	other_rcvaluec20 := (integer)(other_aacd1 = 'C20') * other_distance1 +
	    (integer)(other_aacd2 = 'C20') * other_distance2 +
	    (integer)(other_aacd3 = 'C20') * other_distance3 +
	    (integer)(other_aacd4 = 'C20') * other_distance4 +
	    (integer)(other_aacd5 = 'C20') * other_distance5 +
	    (integer)(other_aacd6 = 'C20') * other_distance6 +
	    (integer)(other_aacd7 = 'C20') * other_distance7 +
	    (integer)(other_aacd8 = 'C20') * other_distance8 +
	    (integer)(other_aacd9 = 'C20') * other_distance9 +
	    (integer)(other_aacd10 = 'C20') * other_distance10 +
	    (integer)(other_aacd11 = 'C20') * other_distance11 +
	    (integer)(other_aacd12 = 'C20') * other_distance12 +
	    (integer)(other_aacd13 = 'C20') * other_distance13 +
	    (integer)(other_aacd14 = 'C20') * other_distance14 +
	    (integer)(other_aacd15 = 'C20') * other_distance15 +
	    (integer)(other_aacd16 = 'C20') * other_distance16 +
	    (integer)(other_aacd17 = 'C20') * other_distance17 +
	    (integer)(other_aacd18 = 'C20') * other_distance18 +
	    (integer)(other_aacd19 = 'C20') * other_distance19 +
	    (integer)(other_aacd20 = 'C20') * other_distance20 +
	    (integer)(other_aacd21 = 'C20') * other_distance21 +
	    (integer)(other_aacd22 = 'C20') * other_distance22 +
	    (integer)(other_aacd23 = 'C20') * other_distance23 +
	    (integer)(other_aacd24 = 'C20') * other_distance24 +
	    (integer)(other_aacd25 = 'C20') * other_distance25 +
	    (integer)(other_aacd26 = 'C20') * other_distance26 +
	    (integer)(other_aacd27 = 'C20') * other_distance27;
	
	other_rcvaluec21 := (integer)(other_aacd1 = 'C21') * other_distance1 +
	    (integer)(other_aacd2 = 'C21') * other_distance2 +
	    (integer)(other_aacd3 = 'C21') * other_distance3 +
	    (integer)(other_aacd4 = 'C21') * other_distance4 +
	    (integer)(other_aacd5 = 'C21') * other_distance5 +
	    (integer)(other_aacd6 = 'C21') * other_distance6 +
	    (integer)(other_aacd7 = 'C21') * other_distance7 +
	    (integer)(other_aacd8 = 'C21') * other_distance8 +
	    (integer)(other_aacd9 = 'C21') * other_distance9 +
	    (integer)(other_aacd10 = 'C21') * other_distance10 +
	    (integer)(other_aacd11 = 'C21') * other_distance11 +
	    (integer)(other_aacd12 = 'C21') * other_distance12 +
	    (integer)(other_aacd13 = 'C21') * other_distance13 +
	    (integer)(other_aacd14 = 'C21') * other_distance14 +
	    (integer)(other_aacd15 = 'C21') * other_distance15 +
	    (integer)(other_aacd16 = 'C21') * other_distance16 +
	    (integer)(other_aacd17 = 'C21') * other_distance17 +
	    (integer)(other_aacd18 = 'C21') * other_distance18 +
	    (integer)(other_aacd19 = 'C21') * other_distance19 +
	    (integer)(other_aacd20 = 'C21') * other_distance20 +
	    (integer)(other_aacd21 = 'C21') * other_distance21 +
	    (integer)(other_aacd22 = 'C21') * other_distance22 +
	    (integer)(other_aacd23 = 'C21') * other_distance23 +
	    (integer)(other_aacd24 = 'C21') * other_distance24 +
	    (integer)(other_aacd25 = 'C21') * other_distance25 +
	    (integer)(other_aacd26 = 'C21') * other_distance26 +
	    (integer)(other_aacd27 = 'C21') * other_distance27;
	
	other_rcvaluee55 := (integer)(other_aacd1 = 'E55') * other_distance1 +
	    (integer)(other_aacd2 = 'E55') * other_distance2 +
	    (integer)(other_aacd3 = 'E55') * other_distance3 +
	    (integer)(other_aacd4 = 'E55') * other_distance4 +
	    (integer)(other_aacd5 = 'E55') * other_distance5 +
	    (integer)(other_aacd6 = 'E55') * other_distance6 +
	    (integer)(other_aacd7 = 'E55') * other_distance7 +
	    (integer)(other_aacd8 = 'E55') * other_distance8 +
	    (integer)(other_aacd9 = 'E55') * other_distance9 +
	    (integer)(other_aacd10 = 'E55') * other_distance10 +
	    (integer)(other_aacd11 = 'E55') * other_distance11 +
	    (integer)(other_aacd12 = 'E55') * other_distance12 +
	    (integer)(other_aacd13 = 'E55') * other_distance13 +
	    (integer)(other_aacd14 = 'E55') * other_distance14 +
	    (integer)(other_aacd15 = 'E55') * other_distance15 +
	    (integer)(other_aacd16 = 'E55') * other_distance16 +
	    (integer)(other_aacd17 = 'E55') * other_distance17 +
	    (integer)(other_aacd18 = 'E55') * other_distance18 +
	    (integer)(other_aacd19 = 'E55') * other_distance19 +
	    (integer)(other_aacd20 = 'E55') * other_distance20 +
	    (integer)(other_aacd21 = 'E55') * other_distance21 +
	    (integer)(other_aacd22 = 'E55') * other_distance22 +
	    (integer)(other_aacd23 = 'E55') * other_distance23 +
	    (integer)(other_aacd24 = 'E55') * other_distance24 +
	    (integer)(other_aacd25 = 'E55') * other_distance25 +
	    (integer)(other_aacd26 = 'E55') * other_distance26 +
	    (integer)(other_aacd27 = 'E55') * other_distance27;
	
	other_rcvaluee57 := (integer)(other_aacd1 = 'E57') * other_distance1 +
	    (integer)(other_aacd2 = 'E57') * other_distance2 +
	    (integer)(other_aacd3 = 'E57') * other_distance3 +
	    (integer)(other_aacd4 = 'E57') * other_distance4 +
	    (integer)(other_aacd5 = 'E57') * other_distance5 +
	    (integer)(other_aacd6 = 'E57') * other_distance6 +
	    (integer)(other_aacd7 = 'E57') * other_distance7 +
	    (integer)(other_aacd8 = 'E57') * other_distance8 +
	    (integer)(other_aacd9 = 'E57') * other_distance9 +
	    (integer)(other_aacd10 = 'E57') * other_distance10 +
	    (integer)(other_aacd11 = 'E57') * other_distance11 +
	    (integer)(other_aacd12 = 'E57') * other_distance12 +
	    (integer)(other_aacd13 = 'E57') * other_distance13 +
	    (integer)(other_aacd14 = 'E57') * other_distance14 +
	    (integer)(other_aacd15 = 'E57') * other_distance15 +
	    (integer)(other_aacd16 = 'E57') * other_distance16 +
	    (integer)(other_aacd17 = 'E57') * other_distance17 +
	    (integer)(other_aacd18 = 'E57') * other_distance18 +
	    (integer)(other_aacd19 = 'E57') * other_distance19 +
	    (integer)(other_aacd20 = 'E57') * other_distance20 +
	    (integer)(other_aacd21 = 'E57') * other_distance21 +
	    (integer)(other_aacd22 = 'E57') * other_distance22 +
	    (integer)(other_aacd23 = 'E57') * other_distance23 +
	    (integer)(other_aacd24 = 'E57') * other_distance24 +
	    (integer)(other_aacd25 = 'E57') * other_distance25 +
	    (integer)(other_aacd26 = 'E57') * other_distance26 +
	    (integer)(other_aacd27 = 'E57') * other_distance27;
	
	other_rcvaluef01 := (integer)(other_aacd1 = 'F01') * other_distance1 +
	    (integer)(other_aacd2 = 'F01') * other_distance2 +
	    (integer)(other_aacd3 = 'F01') * other_distance3 +
	    (integer)(other_aacd4 = 'F01') * other_distance4 +
	    (integer)(other_aacd5 = 'F01') * other_distance5 +
	    (integer)(other_aacd6 = 'F01') * other_distance6 +
	    (integer)(other_aacd7 = 'F01') * other_distance7 +
	    (integer)(other_aacd8 = 'F01') * other_distance8 +
	    (integer)(other_aacd9 = 'F01') * other_distance9 +
	    (integer)(other_aacd10 = 'F01') * other_distance10 +
	    (integer)(other_aacd11 = 'F01') * other_distance11 +
	    (integer)(other_aacd12 = 'F01') * other_distance12 +
	    (integer)(other_aacd13 = 'F01') * other_distance13 +
	    (integer)(other_aacd14 = 'F01') * other_distance14 +
	    (integer)(other_aacd15 = 'F01') * other_distance15 +
	    (integer)(other_aacd16 = 'F01') * other_distance16 +
	    (integer)(other_aacd17 = 'F01') * other_distance17 +
	    (integer)(other_aacd18 = 'F01') * other_distance18 +
	    (integer)(other_aacd19 = 'F01') * other_distance19 +
	    (integer)(other_aacd20 = 'F01') * other_distance20 +
	    (integer)(other_aacd21 = 'F01') * other_distance21 +
	    (integer)(other_aacd22 = 'F01') * other_distance22 +
	    (integer)(other_aacd23 = 'F01') * other_distance23 +
	    (integer)(other_aacd24 = 'F01') * other_distance24 +
	    (integer)(other_aacd25 = 'F01') * other_distance25 +
	    (integer)(other_aacd26 = 'F01') * other_distance26 +
	    (integer)(other_aacd27 = 'F01') * other_distance27;
	
	other_rcvaluef03 := (integer)(other_aacd1 = 'F03') * other_distance1 +
	    (integer)(other_aacd2 = 'F03') * other_distance2 +
	    (integer)(other_aacd3 = 'F03') * other_distance3 +
	    (integer)(other_aacd4 = 'F03') * other_distance4 +
	    (integer)(other_aacd5 = 'F03') * other_distance5 +
	    (integer)(other_aacd6 = 'F03') * other_distance6 +
	    (integer)(other_aacd7 = 'F03') * other_distance7 +
	    (integer)(other_aacd8 = 'F03') * other_distance8 +
	    (integer)(other_aacd9 = 'F03') * other_distance9 +
	    (integer)(other_aacd10 = 'F03') * other_distance10 +
	    (integer)(other_aacd11 = 'F03') * other_distance11 +
	    (integer)(other_aacd12 = 'F03') * other_distance12 +
	    (integer)(other_aacd13 = 'F03') * other_distance13 +
	    (integer)(other_aacd14 = 'F03') * other_distance14 +
	    (integer)(other_aacd15 = 'F03') * other_distance15 +
	    (integer)(other_aacd16 = 'F03') * other_distance16 +
	    (integer)(other_aacd17 = 'F03') * other_distance17 +
	    (integer)(other_aacd18 = 'F03') * other_distance18 +
	    (integer)(other_aacd19 = 'F03') * other_distance19 +
	    (integer)(other_aacd20 = 'F03') * other_distance20 +
	    (integer)(other_aacd21 = 'F03') * other_distance21 +
	    (integer)(other_aacd22 = 'F03') * other_distance22 +
	    (integer)(other_aacd23 = 'F03') * other_distance23 +
	    (integer)(other_aacd24 = 'F03') * other_distance24 +
	    (integer)(other_aacd25 = 'F03') * other_distance25 +
	    (integer)(other_aacd26 = 'F03') * other_distance26 +
	    (integer)(other_aacd27 = 'F03') * other_distance27;
	
	other_rcvaluei60 := (integer)(other_aacd1 = 'I60') * other_distance1 +
	    (integer)(other_aacd2 = 'I60') * other_distance2 +
	    (integer)(other_aacd3 = 'I60') * other_distance3 +
	    (integer)(other_aacd4 = 'I60') * other_distance4 +
	    (integer)(other_aacd5 = 'I60') * other_distance5 +
	    (integer)(other_aacd6 = 'I60') * other_distance6 +
	    (integer)(other_aacd7 = 'I60') * other_distance7 +
	    (integer)(other_aacd8 = 'I60') * other_distance8 +
	    (integer)(other_aacd9 = 'I60') * other_distance9 +
	    (integer)(other_aacd10 = 'I60') * other_distance10 +
	    (integer)(other_aacd11 = 'I60') * other_distance11 +
	    (integer)(other_aacd12 = 'I60') * other_distance12 +
	    (integer)(other_aacd13 = 'I60') * other_distance13 +
	    (integer)(other_aacd14 = 'I60') * other_distance14 +
	    (integer)(other_aacd15 = 'I60') * other_distance15 +
	    (integer)(other_aacd16 = 'I60') * other_distance16 +
	    (integer)(other_aacd17 = 'I60') * other_distance17 +
	    (integer)(other_aacd18 = 'I60') * other_distance18 +
	    (integer)(other_aacd19 = 'I60') * other_distance19 +
	    (integer)(other_aacd20 = 'I60') * other_distance20 +
	    (integer)(other_aacd21 = 'I60') * other_distance21 +
	    (integer)(other_aacd22 = 'I60') * other_distance22 +
	    (integer)(other_aacd23 = 'I60') * other_distance23 +
	    (integer)(other_aacd24 = 'I60') * other_distance24 +
	    (integer)(other_aacd25 = 'I60') * other_distance25 +
	    (integer)(other_aacd26 = 'I60') * other_distance26 +
	    (integer)(other_aacd27 = 'I60') * other_distance27;
	
	other_rcvaluel79 := (integer)(other_aacd1 = 'L79') * other_distance1 +
	    (integer)(other_aacd2 = 'L79') * other_distance2 +
	    (integer)(other_aacd3 = 'L79') * other_distance3 +
	    (integer)(other_aacd4 = 'L79') * other_distance4 +
	    (integer)(other_aacd5 = 'L79') * other_distance5 +
	    (integer)(other_aacd6 = 'L79') * other_distance6 +
	    (integer)(other_aacd7 = 'L79') * other_distance7 +
	    (integer)(other_aacd8 = 'L79') * other_distance8 +
	    (integer)(other_aacd9 = 'L79') * other_distance9 +
	    (integer)(other_aacd10 = 'L79') * other_distance10 +
	    (integer)(other_aacd11 = 'L79') * other_distance11 +
	    (integer)(other_aacd12 = 'L79') * other_distance12 +
	    (integer)(other_aacd13 = 'L79') * other_distance13 +
	    (integer)(other_aacd14 = 'L79') * other_distance14 +
	    (integer)(other_aacd15 = 'L79') * other_distance15 +
	    (integer)(other_aacd16 = 'L79') * other_distance16 +
	    (integer)(other_aacd17 = 'L79') * other_distance17 +
	    (integer)(other_aacd18 = 'L79') * other_distance18 +
	    (integer)(other_aacd19 = 'L79') * other_distance19 +
	    (integer)(other_aacd20 = 'L79') * other_distance20 +
	    (integer)(other_aacd21 = 'L79') * other_distance21 +
	    (integer)(other_aacd22 = 'L79') * other_distance22 +
	    (integer)(other_aacd23 = 'L79') * other_distance23 +
	    (integer)(other_aacd24 = 'L79') * other_distance24 +
	    (integer)(other_aacd25 = 'L79') * other_distance25 +
	    (integer)(other_aacd26 = 'L79') * other_distance26 +
	    (integer)(other_aacd27 = 'L79') * other_distance27;
	
	other_rcvaluel80 := (integer)(other_aacd1 = 'L80') * other_distance1 +
	    (integer)(other_aacd2 = 'L80') * other_distance2 +
	    (integer)(other_aacd3 = 'L80') * other_distance3 +
	    (integer)(other_aacd4 = 'L80') * other_distance4 +
	    (integer)(other_aacd5 = 'L80') * other_distance5 +
	    (integer)(other_aacd6 = 'L80') * other_distance6 +
	    (integer)(other_aacd7 = 'L80') * other_distance7 +
	    (integer)(other_aacd8 = 'L80') * other_distance8 +
	    (integer)(other_aacd9 = 'L80') * other_distance9 +
	    (integer)(other_aacd10 = 'L80') * other_distance10 +
	    (integer)(other_aacd11 = 'L80') * other_distance11 +
	    (integer)(other_aacd12 = 'L80') * other_distance12 +
	    (integer)(other_aacd13 = 'L80') * other_distance13 +
	    (integer)(other_aacd14 = 'L80') * other_distance14 +
	    (integer)(other_aacd15 = 'L80') * other_distance15 +
	    (integer)(other_aacd16 = 'L80') * other_distance16 +
	    (integer)(other_aacd17 = 'L80') * other_distance17 +
	    (integer)(other_aacd18 = 'L80') * other_distance18 +
	    (integer)(other_aacd19 = 'L80') * other_distance19 +
	    (integer)(other_aacd20 = 'L80') * other_distance20 +
	    (integer)(other_aacd21 = 'L80') * other_distance21 +
	    (integer)(other_aacd22 = 'L80') * other_distance22 +
	    (integer)(other_aacd23 = 'L80') * other_distance23 +
	    (integer)(other_aacd24 = 'L80') * other_distance24 +
	    (integer)(other_aacd25 = 'L80') * other_distance25 +
	    (integer)(other_aacd26 = 'L80') * other_distance26 +
	    (integer)(other_aacd27 = 'L80') * other_distance27;
	
	other_rcvalues66 := (integer)(other_aacd1 = 'S66') * other_distance1 +
	    (integer)(other_aacd2 = 'S66') * other_distance2 +
	    (integer)(other_aacd3 = 'S66') * other_distance3 +
	    (integer)(other_aacd4 = 'S66') * other_distance4 +
	    (integer)(other_aacd5 = 'S66') * other_distance5 +
	    (integer)(other_aacd6 = 'S66') * other_distance6 +
	    (integer)(other_aacd7 = 'S66') * other_distance7 +
	    (integer)(other_aacd8 = 'S66') * other_distance8 +
	    (integer)(other_aacd9 = 'S66') * other_distance9 +
	    (integer)(other_aacd10 = 'S66') * other_distance10 +
	    (integer)(other_aacd11 = 'S66') * other_distance11 +
	    (integer)(other_aacd12 = 'S66') * other_distance12 +
	    (integer)(other_aacd13 = 'S66') * other_distance13 +
	    (integer)(other_aacd14 = 'S66') * other_distance14 +
	    (integer)(other_aacd15 = 'S66') * other_distance15 +
	    (integer)(other_aacd16 = 'S66') * other_distance16 +
	    (integer)(other_aacd17 = 'S66') * other_distance17 +
	    (integer)(other_aacd18 = 'S66') * other_distance18 +
	    (integer)(other_aacd19 = 'S66') * other_distance19 +
	    (integer)(other_aacd20 = 'S66') * other_distance20 +
	    (integer)(other_aacd21 = 'S66') * other_distance21 +
	    (integer)(other_aacd22 = 'S66') * other_distance22 +
	    (integer)(other_aacd23 = 'S66') * other_distance23 +
	    (integer)(other_aacd24 = 'S66') * other_distance24 +
	    (integer)(other_aacd25 = 'S66') * other_distance25 +
	    (integer)(other_aacd26 = 'S66') * other_distance26 +
	    (integer)(other_aacd27 = 'S66') * other_distance27;
	
	other_rawscore := other_subscore1 +
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
	    other_subscore18 +
	    other_subscore19 +
	    other_subscore20 +
	    other_subscore21 +
	    other_subscore22 +
	    other_subscore23 +
	    other_subscore24 +
	    other_subscore25 +
	    other_subscore26 +
	    other_subscore27;
	
	other_lnoddsscore := other_rawscore + 2.295003;
	
	lnoddsscore := if(max((integer)vervalprob_seg * verprob_lnoddsscore, (integer)derog_seg * derog_lnoddsscore, (integer)owner_seg * owner_lnoddsscore, (integer)other_seg * other_lnoddsscore) = NULL, NULL, sum(if((integer)vervalprob_seg * verprob_lnoddsscore = NULL, 0, (integer)vervalprob_seg * verprob_lnoddsscore), if((integer)derog_seg * derog_lnoddsscore = NULL, 0, (integer)derog_seg * derog_lnoddsscore), if((integer)owner_seg * owner_lnoddsscore = NULL, 0, (integer)owner_seg * owner_lnoddsscore), if((integer)other_seg * other_lnoddsscore = NULL, 0, (integer)other_seg * other_lnoddsscore)));
	
	score_lnodds := round(40 * (lnoddsscore - ln(20)) / ln(2) + 700);
	
	score_lnodds_capped := min(900, if(max(501, score_lnodds) = NULL, -NULL, max(501, score_lnodds)));
	
	ov_ssnprior := rc_ssndobflag = '1' or rc_pwssndobflag = '1';
	
	ov_corrections := rc_hrisksic = '2225';
	
	unscorable := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);
	
	deceased := map(
	    rc_decsflag = '1'                                                      => 1,
	    rc_ssndod != 0                                                         => 1,
	    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
	                                                                              0);
	
	//*************************************************************************************//
	//                     RiskView Version 5 - RVA1403_0_0 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Lex ID Only On Input = 222 (FLAGSHIP MODELS ONLY)
	// SSNPrior OR Corrections = 680
	// Score Range: 501 - 900
	//*************************************************************************************//
	rva1403_0_0 := map(
	    deceased > 0                                                  => 200,
	    unscorable                                                    => 222,
			lexIDOnlyOnInput																							=> 222,
	    score_lnodds_capped > 680 and (ov_ssnprior or ov_corrections) => 680,
	                                                                     score_lnodds_capped);
	

	//*************************************************************************************//
	//                        RiskView Version 5 Reason Code Logic
	//*************************************************************************************//
	ds_layout := {STRING rc, REAL value};
	
	rc_dataset_verprob := DATASET([
	    {'A41', ABS(verprob_rcvalueA41)},
	    {'A50', ABS(verprob_rcvalueA50)},
	    {'C10', ABS(verprob_rcvalueC10)},
	    {'C12', ABS(verprob_rcvalueC12)},
	    {'C13', ABS(verprob_rcvalueC13)},
	    {'C14', ABS(verprob_rcvalueC14)},
	    {'C22', ABS(verprob_rcvalueC22)},
	    {'D32', ABS(verprob_rcvalueD32)},
	    {'D33', ABS(verprob_rcvalueD33)},
	    {'D34', ABS(verprob_rcvalueD34)},
	    {'E55', ABS(verprob_rcvalueE55)},
	    {'E57', ABS(verprob_rcvalueE57)},
	    {'F01', ABS(verprob_rcvalueF01)},
	    {'I60', ABS(verprob_rcvalueI60)},
	    {'A51', ABS(verprob_rcvalueL00)},
	    {'L80', ABS(verprob_rcvalueL80)},
	    {'P85', ABS(verprob_rcvalueP85)}
	    ], ds_layout) (value > 0);

	rc_dataset_verprob_sorted := sort(rc_dataset_verprob, -rc_dataset_verprob.value);
	
	verprob_rc1 := rc_dataset_verprob_sorted[1].rc;
	verprob_rc2 := rc_dataset_verprob_sorted[2].rc;
	verprob_rc3 := rc_dataset_verprob_sorted[3].rc;
	verprob_rc4 := rc_dataset_verprob_sorted[4].rc;

	rc_dataset_derog := DATASET([
	    {'A41', ABS(derog_rcvalueA41)},
	    {'A43', ABS(derog_rcvalueA43)},
	    {'A50', ABS(derog_rcvalueA50)},
	    {'C13', ABS(derog_rcvalueC13)},
	    {'C14', ABS(derog_rcvalueC14)},
	    {'C21', ABS(derog_rcvalueC21)},
	    {'C22', ABS(derog_rcvalueC22)},
	    {'D32', ABS(derog_rcvalueD32)},
	    {'D33', ABS(derog_rcvalueD33)},
	    {'D34', ABS(derog_rcvalueD34)},
	    {'E55', ABS(derog_rcvalueE55)},
	    {'E57', ABS(derog_rcvalueE57)},
	    {'F03', ABS(derog_rcvalueF03)},
	    {'I60', ABS(derog_rcvalueI60)},
	    {'L77', ABS(derog_rcvalueL77)},
	    {'S66', ABS(derog_rcvalueS66)}
	    ], ds_layout) (value > 0);

	rc_dataset_derog_sorted := sort(rc_dataset_derog, -rc_dataset_derog.value);
	
	derog_rc1 := rc_dataset_derog_sorted[1].rc;
	derog_rc2 := rc_dataset_derog_sorted[2].rc;
	derog_rc3 := rc_dataset_derog_sorted[3].rc;
	derog_rc4 := rc_dataset_derog_sorted[4].rc;

	rc_dataset_owner := DATASET([
	    // {'A51', owner_rcvalueA51},
	    {'A43', ABS(owner_rcvalueA43)},
	    {'A44', ABS(owner_rcvalueA44)},
	    {'A46', ABS(owner_rcvalueA46)},
	    {'A50', ABS(owner_rcvalueA50)},
	    {'A51', ABS(owner_rcvalueA51)},
	    {'C10', ABS(owner_rcvalueC10)},
	    {'C12', ABS(owner_rcvalueC12)},
	    {'C13', ABS(owner_rcvalueC13)},
	    {'C14', ABS(owner_rcvalueC14)},
	    {'C15', ABS(owner_rcvalueC15)},
	    {'C21', ABS(owner_rcvalueC21)},
	    {'D34', ABS(owner_rcvalueD34)},
	    {'E55', ABS(owner_rcvalueE55)},
	    {'E57', ABS(owner_rcvalueE57)},
	    {'F01', ABS(owner_rcvalueF01)},
	    {'F03', ABS(owner_rcvalueF03)},
	    {'I60', ABS(owner_rcvalueI60)},
	    {'L77', ABS(owner_rcvalueL77)},
	    {'L79', ABS(owner_rcvalueL79)},
	    {'L80', ABS(owner_rcvalueL80)},
	    {'S66', ABS(owner_rcvalueS66)}
	    ], ds_layout) (value > 0);

	rc_dataset_owner_sorted := sort(rc_dataset_owner, -rc_dataset_owner.value);
	
	owner_rc1 := rc_dataset_owner_sorted[1].rc;
	owner_rc2 := rc_dataset_owner_sorted[2].rc;
	owner_rc3 := rc_dataset_owner_sorted[3].rc;
	owner_rc4 := rc_dataset_owner_sorted[4].rc;

	rc_dataset_other := DATASET([
	    {'A43', ABS(other_rcvalueA43)},
	    {'A50', ABS(other_rcvalueA50)},
	    {'A51', ABS(other_rcvalueA51)},
	    {'C10', ABS(other_rcvalueC10)},
	    {'C12', ABS(other_rcvalueC12)},
	    {'C13', ABS(other_rcvalueC13)},
	    {'C14', ABS(other_rcvalueC14)},
	    {'C15', ABS(other_rcvalueC15)},
	    {'C20', ABS(other_rcvalueC20)},
	    {'C21', ABS(other_rcvalueC21)},
	    {'E55', ABS(other_rcvalueE55)},
	    {'E57', ABS(other_rcvalueE57)},
	    {'F01', ABS(other_rcvalueF01)},
	    {'F03', ABS(other_rcvalueF03)},
	    {'I60', ABS(other_rcvalueI60)},
	    {'L79', ABS(other_rcvalueL79)},
	    {'L80', ABS(other_rcvalueL80)},
	    {'S66', ABS(other_rcvalueS66)}
	    ], ds_layout) (value > 0);
	
	rc_dataset_other_sorted := sort(rc_dataset_other, -rc_dataset_other.value);
	
	other_rc1 := rc_dataset_other_sorted[1].rc;
	other_rc2 := rc_dataset_other_sorted[2].rc;
	other_rc3 := rc_dataset_other_sorted[3].rc;
	other_rc4 := rc_dataset_other_sorted[4].rc;
	
	rc1_1 := map(
	    VerValProb_seg => verprob_rc1,
	    Derog_seg      => derog_rc1,
	    Owner_seg      => owner_rc1,
	                      other_rc1);
	
	rc2 := map(
	    VerValProb_seg => verprob_rc2,
	    Derog_seg      => derog_rc2,
	    Owner_seg      => owner_rc2,
	                      other_rc2);
	
	rc3 := map(
	    VerValProb_seg => verprob_rc3,
	    Derog_seg      => derog_rc3,
	    Owner_seg      => owner_rc3,
	                      other_rc3);
	
	rc4 := map(
	    VerValProb_seg => verprob_rc4,
	    Derog_seg      => derog_rc4,
	    Owner_seg      => owner_rc4,
	                      other_rc4);
	
	_rc_seg_c267 := map(
	    add_ec1 = 'E' and not(rc_addrvalflag = 'N') or out_z5 = ''                                                                           	 			=> 'L70',
	    hrisksic_addr                                                                                                                          			=> 'L73',
	    hrisksic_phn                                                                                                                           			=> 'P87',
	    rc_hriskaddrflag = 2 or rc_ziptypeflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or rc_hriskaddrflag = 4 or rc_addrcommflag = '2' 	=> 'L71',
																																																																										 'L72');
	
	_rc_seg_c268 := map(
	    rc_hriskphoneflag = '2' or rc_hphonetypeflag IN ['2', 'A'] or (telcordia_type in ['02', '56', '61'])												=> 'P86',
			rc_phonevalflag = '0' OR rc_hphonevalflag = '0' OR rc_phonetype = '5' OR rc_hphonetypeflag = '5' OR rc_hriskphoneflag = '6'	=> 'P85',
																																																																		 '');
	
	_rc_seg_c266 := map(
	    not((boolean)(INTEGER)sufficiently_verified)     => 'F00',
	    adls_per_ssn_ge5 or ssns_per_adl_ge4             => 'S66',
	    invalid_ssns_per_adl_ge1                         => 'S65',
	    adls_per_addr_curr_ge8 or ssns_per_addr_curr_ge7 => 'L79',
	    Addr_Validation_Problem > 0                      => _rc_seg_c267,
	    Phn_Validation_Problem > 0                       => _rc_seg_c268,
																													'C12');
	
	_rc_seg_c269 := map(
	    derog_severity = 4                             => 'D32',
	    derog_severity = 3                             => 'C22',
	    derog_severity = 2 and attr_eviction_count > 0 => 'D33',
	    derog_severity = 2                             => 'D34',
	                                                      'D31');
	
	_rc_seg := map(
	    seg_ver_derog_owner = '1 - TrueDid0 Ver/ValProb' => _rc_seg_c266,
	    seg_ver_derog_owner = '2 - Derog               ' => _rc_seg_c269,
	    seg_ver_derog_owner = '4 - Other               ' => 'A41',
																													'');
	
	_rc_inq := map(
	    seg_ver_derog_owner = '1 - TrueDid0 Ver/ValProb' and iv_i60_inq_recency > 0                                    => 'I60',
	    seg_ver_derog_owner = '2 - Derog               ' and iv_i60_credit_seeking > 0 and iv_i60_inq_auto_recency > 0 => 'I60',
	    seg_ver_derog_owner = '3 - Owner               ' and rv_i60_inq_count12 > 0                                    => 'I60',
	    seg_ver_derog_owner = '4 - Other               ' and rv_i60_inq_count12 > 0                                    => 'I60',
																																																												'');
	
	rc1 := if(trim(rc1_1, ALL) = '', _rc_seg, rc1_1);
	
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
														// In Version 5 200 and 222 scores will not return reason codes, they will instead return alert codes
														rva1403_0_0 = 200 => DATASET([{'00'}], HRILayout),
														rva1403_0_0 = 222 => DATASET([{'00'}], HRILayout),
														rva1403_0_0 = 900 => DATASET([{'00'}], HRILayout),
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
		SELF.seq := le.seq;
		SELF.source_profile := source_profile;
		SELF.truedid := truedid;
		SELF.out_unit_desig := out_unit_desig;
		SELF.out_sec_range := out_sec_range;
		SELF.out_z5 := out_z5;
		SELF.out_addr_type := out_addr_type;
		SELF.out_addr_status := out_addr_status;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
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
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_hrisksic := rc_hrisksic;
		SELF.rc_hrisksicphone := rc_hrisksicphone;
		SELF.rc_phonetype := rc_phonetype;
		SELF.rc_ziptypeflag := rc_ziptypeflag;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_first_seen := ver_sources_first_seen;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_isbestmatch := add_input_isbestmatch;
		SELF.add_input_lres := add_input_lres;
		SELF.add_input_advo_vacancy := add_input_advo_vacancy;
		SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.add_curr_isbestmatch := add_curr_isbestmatch;
		SELF.add_curr_lres := add_curr_lres;
		SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
		SELF.add_curr_naprop := add_curr_naprop;
		SELF.add_curr_pop := add_curr_pop;
		SELF.add_prev_lres := add_prev_lres;
		SELF.add_prev_naprop := add_prev_naprop;
		SELF.add_prev_pop := add_prev_pop;
		SELF.avg_lres := avg_lres;
		SELF.max_lres := max_lres;
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
		SELF.addrs_per_adl_c6 := addrs_per_adl_c6;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
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
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_mortgage_count03 := inq_mortgage_count03;
		SELF.inq_retail_count03 := inq_retail_count03;
		SELF.inq_phonesperadl := inq_phonesperadl;
		SELF.pb_average_dollars := pb_average_dollars;
		SELF.pb_total_dollars := pb_total_dollars;
		SELF.pb_total_orders := pb_total_orders;
		SELF.br_first_seen := br_first_seen;
		SELF.br_source_count := br_source_count;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count90 := stl_inq_count90;
		SELF.stl_inq_count180 := stl_inq_count180;
		SELF.stl_inq_count12 := stl_inq_count12;
		SELF.stl_inq_count24 := stl_inq_count24;
		SELF.email_domain_free_count := email_domain_free_count;
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
		SELF.prof_license_flag := prof_license_flag;
		SELF.input_dob_match_level := input_dob_match_level;

		/* Model Intermediate Variables */
		SELF.iv_add_apt := iv_add_apt;
		SELF.nas_summary_ver2 := nas_summary_ver2;
		SELF.nap_summary_ver := nap_summary_ver;
		SELF.infutor_nap_ver := infutor_nap_ver;
		SELF.dobver := dobver;
		SELF.sufficiently_verified := sufficiently_verified;
		SELF.adls_per_ssn_ge5 := adls_per_ssn_ge5;
		SELF.ssns_per_adl_ge4 := ssns_per_adl_ge4;
		SELF.invalid_ssns_per_adl_ge1 := invalid_ssns_per_adl_ge1;
		SELF.adls_per_addr_curr_ge8 := adls_per_addr_curr_ge8;
		SELF.ssns_per_addr_curr_ge7 := ssns_per_addr_curr_ge7;
		SELF.hrisksic_addr := hrisksic_addr;
		SELF.hrisksic_phn := hrisksic_phn;
		SELF.add_ec1 := add_ec1;
		SELF.addr_validation_problem := addr_validation_problem;
		SELF.phn_validation_problem := phn_validation_problem;
		SELF.validation_problem := validation_problem;
		SELF.lj_landlordtenant_ct := lj_landlordtenant_ct;
		SELF.lj_smallclaims_ct := lj_smallclaims_ct;
		SELF.lj_court_ct := lj_court_ct;
		SELF.lj_tax_ct := lj_tax_ct;
		SELF.lj_foreclosure_ct := lj_foreclosure_ct;
		SELF.lj_other_ct := lj_other_ct;
		SELF.lj_total_ct := lj_total_ct;
		SELF.lj_no_type_ct := lj_no_type_ct;
		SELF.lj_flag := lj_flag;
		SELF.derog_severity := derog_severity;
		SELF.seg_ver_derog_owner := seg_ver_derog_owner;
		SELF.vervalprob_seg := vervalprob_seg;
		SELF.derog_seg := derog_seg;
		SELF.owner_seg := owner_seg;
		SELF.other_seg := other_seg;
		SELF._br_first_seen := _br_first_seen;
		SELF.iv_mos_since_br_first_seen := iv_mos_since_br_first_seen;
		SELF.iv_br_source_count := iv_br_source_count;
		SELF.bureau_adl_eq_fseen_pos := bureau_adl_eq_fseen_pos;
		SELF.bureau_adl_fseen_eq := bureau_adl_fseen_eq;
		SELF._bureau_adl_fseen_eq := _bureau_adl_fseen_eq;
		SELF._src_bureau_adl_fseen := _src_bureau_adl_fseen;
		SELF.rv_c21_m_bureau_adl_fs := rv_c21_m_bureau_adl_fs;
		SELF.rv_a42_prop_owner := rv_a42_prop_owner;
		SELF._criminal_last_date := _criminal_last_date;
		SELF.rv_d32_mos_since_crim_ls := rv_d32_mos_since_crim_ls;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_c22_stl_inq_count12 := rv_c22_stl_inq_count12;
		SELF.rv_c22_stl_inq_count24 := rv_c22_stl_inq_count24;
		SELF.rv_c22_stl_recency := rv_c22_stl_recency;
		SELF.rv_s66_adlperssn_count := rv_s66_adlperssn_count;
		SELF.rv_c14_addrs_per_adl_c6 := rv_c14_addrs_per_adl_c6;
		SELF.rv_a42_prop_owner_inp_only := rv_a42_prop_owner_inp_only;
		SELF.rv_e55_college_ind_shell5 := rv_e55_college_ind_shell5;
		SELF.iv_f07_input_add_not_most_rec := iv_f07_input_add_not_most_rec;
		SELF.iv_l77_dwelltype := iv_l77_dwelltype;
		SELF.iv_c13_inp_addr_lres := iv_c13_inp_addr_lres;
		SELF.iv_c14_addrs_10yr := iv_c14_addrs_10yr;
		SELF.iv_i60_credit_seeking := iv_i60_credit_seeking;
		SELF.iv_i60_inq_auto_recency := iv_i60_inq_auto_recency;
		SELF.iv_a43_rec_vehx_level := iv_a43_rec_vehx_level;
		SELF.iv_d33_eviction_count_1 := iv_d33_eviction_count_1;
		SELF.iv_d34_unrel_liens_ct := iv_d34_unrel_liens_ct;
		SELF.iv_d34_liens_unrel_x_rel := iv_d34_liens_unrel_x_rel;
		SELF.iv_d32_criminal_x_felony := iv_d32_criminal_x_felony;
		SELF.iv_e57_prof_license_flag := iv_e57_prof_license_flag;
		SELF.iv_a50_pb_total_dollars := iv_a50_pb_total_dollars;
		SELF.rv_p85_phn_not_issued := rv_p85_phn_not_issued;
		SELF._header_first_seen := _header_first_seen;
		SELF.rv_c10_m_hdr_fs := rv_c10_m_hdr_fs;
		SELF.rv_c12_source_profile := rv_c12_source_profile;
		SELF.rv_a47_inp_avm_autoval := rv_a47_inp_avm_autoval;
		SELF.iv_f02_inp_addr_address_score := iv_f02_inp_addr_address_score;
		SELF.iv_c13_prv_addr_lres := iv_c13_prv_addr_lres;
		SELF.iv_i60_inq_recency := iv_i60_inq_recency;
		SELF.iv_d33_eviction_count := iv_d33_eviction_count;
		SELF.rv_c15_ssns_per_adl := rv_c15_ssns_per_adl;
		SELF.rv_c13_curr_addr_lres := rv_c13_curr_addr_lres;
		SELF.rv_i60_inq_count12 := rv_i60_inq_count12;
		SELF.iv_f07_address_match_1 := iv_f07_address_match_1;
		SELF.iv_f07_address_match := iv_f07_address_match;
		SELF.iv_c13_avg_lres := iv_c13_avg_lres;
		SELF.iv_c14_addrs_5yr := iv_c14_addrs_5yr;
		SELF.iv_l79_adls_per_addr_c6 := iv_l79_adls_per_addr_c6;
		SELF.iv_i60_inq_hiriskcred_count12 := iv_i60_inq_hiriskcred_count12;
		SELF.iv_i60_inq_phones_per_adl := iv_i60_inq_phones_per_adl;
		SELF.iv_c20_email_domain_free_count := iv_c20_email_domain_free_count;
		SELF.iv_c13_attr_addrs_recency := iv_c13_attr_addrs_recency;
		SELF.iv_a50_pb_average_dollars := iv_a50_pb_average_dollars;
		SELF.iv_a50_pb_total_orders := iv_a50_pb_total_orders;
		SELF.rv_l77_apartment := rv_l77_apartment;
		SELF.rv_a46_curr_avm_autoval := rv_a46_curr_avm_autoval;
		SELF.iv_a44_cur_add_naprop := iv_a44_cur_add_naprop;
		SELF.iv_c13_max_lres := iv_c13_max_lres;
		SELF.iv_l79_adls_per_apt_addr_c6 := iv_l79_adls_per_apt_addr_c6;
		SELF.iv_i60_inq_auto_count12 := iv_i60_inq_auto_count12;
		SELF.verprob_subscore1 := verprob_subscore1;
		SELF.verprob_aacd1 := verprob_aacd1;
		SELF.verprob_distance1 := verprob_distance1;
		SELF.verprob_aacd2 := verprob_aacd2;
		SELF.verprob_subscore2 := verprob_subscore2;
		SELF.verprob_distance2 := verprob_distance2;
		SELF.verprob_subscore3 := verprob_subscore3;
		SELF.verprob_aacd3 := verprob_aacd3;
		SELF.verprob_distance3 := verprob_distance3;
		SELF.verprob_aacd4 := verprob_aacd4;
		SELF.verprob_subscore4 := verprob_subscore4;
		SELF.verprob_distance4 := verprob_distance4;
		SELF.verprob_subscore5 := verprob_subscore5;
		SELF.verprob_aacd5 := verprob_aacd5;
		SELF.verprob_distance5 := verprob_distance5;
		SELF.verprob_aacd6 := verprob_aacd6;
		SELF.verprob_subscore6 := verprob_subscore6;
		SELF.verprob_distance6 := verprob_distance6;
		SELF.verprob_subscore7 := verprob_subscore7;
		SELF.verprob_aacd7 := verprob_aacd7;
		SELF.verprob_distance7 := verprob_distance7;
		SELF.verprob_subscore8 := verprob_subscore8;
		SELF.verprob_aacd8 := verprob_aacd8;
		SELF.verprob_distance8 := verprob_distance8;
		SELF.verprob_subscore9 := verprob_subscore9;
		SELF.verprob_aacd9 := verprob_aacd9;
		SELF.verprob_distance9 := verprob_distance9;
		SELF.verprob_subscore10 := verprob_subscore10;
		SELF.verprob_aacd10 := verprob_aacd10;
		SELF.verprob_distance10 := verprob_distance10;
		SELF.verprob_subscore11 := verprob_subscore11;
		SELF.verprob_aacd11 := verprob_aacd11;
		SELF.verprob_distance11 := verprob_distance11;
		SELF.verprob_aacd12 := verprob_aacd12;
		SELF.verprob_subscore12 := verprob_subscore12;
		SELF.verprob_distance12 := verprob_distance12;
		SELF.verprob_subscore13 := verprob_subscore13;
		SELF.verprob_aacd13 := verprob_aacd13;
		SELF.verprob_distance13 := verprob_distance13;
		SELF.verprob_subscore14 := verprob_subscore14;
		SELF.verprob_aacd14 := verprob_aacd14;
		SELF.verprob_distance14 := verprob_distance14;
		SELF.verprob_aacd15 := verprob_aacd15;
		SELF.verprob_subscore15 := verprob_subscore15;
		SELF.verprob_distance15 := verprob_distance15;
		SELF.verprob_subscore16 := verprob_subscore16;
		SELF.verprob_aacd16 := verprob_aacd16;
		SELF.verprob_distance16 := verprob_distance16;
		SELF.verprob_aacd17 := verprob_aacd17;
		SELF.verprob_subscore17 := verprob_subscore17;
		SELF.verprob_distance17 := verprob_distance17;
		SELF.verprob_rcvaluea41 := verprob_rcvaluea41;
		SELF.verprob_rcvaluea50 := verprob_rcvaluea50;
		SELF.verprob_rcvaluec10 := verprob_rcvaluec10;
		SELF.verprob_rcvaluec12 := verprob_rcvaluec12;
		SELF.verprob_rcvaluec13 := verprob_rcvaluec13;
		SELF.verprob_rcvaluec14 := verprob_rcvaluec14;
		SELF.verprob_rcvaluec22 := verprob_rcvaluec22;
		SELF.verprob_rcvalued32 := verprob_rcvalued32;
		SELF.verprob_rcvalued33 := verprob_rcvalued33;
		SELF.verprob_rcvalued34 := verprob_rcvalued34;
		SELF.verprob_rcvaluee55 := verprob_rcvaluee55;
		SELF.verprob_rcvaluee57 := verprob_rcvaluee57;
		SELF.verprob_rcvaluef01 := verprob_rcvaluef01;
		SELF.verprob_rcvaluei60 := verprob_rcvaluei60;
		SELF.verprob_rcvaluel00 := verprob_rcvaluel00;
		SELF.verprob_rcvaluel80 := verprob_rcvaluel80;
		SELF.verprob_rcvaluep85 := verprob_rcvaluep85;
		SELF.verprob_rawscore := verprob_rawscore;
		SELF.verprob_lnoddsscore := verprob_lnoddsscore;
		SELF.derog_aacd1 := derog_aacd1;
		SELF.derog_subscore1 := derog_subscore1;
		SELF.derog_distance1 := derog_distance1;
		SELF.derog_aacd2 := derog_aacd2;
		SELF.derog_subscore2 := derog_subscore2;
		SELF.derog_distance2 := derog_distance2;
		SELF.derog_aacd3 := derog_aacd3;
		SELF.derog_subscore3 := derog_subscore3;
		SELF.derog_distance3 := derog_distance3;
		SELF.derog_aacd4 := derog_aacd4;
		SELF.derog_subscore4 := derog_subscore4;
		SELF.derog_distance4 := derog_distance4;
		SELF.derog_subscore5 := derog_subscore5;
		SELF.derog_aacd5 := derog_aacd5;
		SELF.derog_distance5 := derog_distance5;
		SELF.derog_subscore6 := derog_subscore6;
		SELF.derog_aacd6 := derog_aacd6;
		SELF.derog_distance6 := derog_distance6;
		SELF.derog_aacd7 := derog_aacd7;
		SELF.derog_subscore7 := derog_subscore7;
		SELF.derog_distance7 := derog_distance7;
		SELF.derog_subscore8 := derog_subscore8;
		SELF.derog_aacd8 := derog_aacd8;
		SELF.derog_distance8 := derog_distance8;
		SELF.derog_aacd9 := derog_aacd9;
		SELF.derog_subscore9 := derog_subscore9;
		SELF.derog_distance9 := derog_distance9;
		SELF.derog_aacd10 := derog_aacd10;
		SELF.derog_subscore10 := derog_subscore10;
		SELF.derog_distance10 := derog_distance10;
		SELF.derog_subscore11 := derog_subscore11;
		SELF.derog_aacd11 := derog_aacd11;
		SELF.derog_distance11 := derog_distance11;
		SELF.derog_subscore12 := derog_subscore12;
		SELF.derog_aacd12 := derog_aacd12;
		SELF.derog_distance12 := derog_distance12;
		SELF.derog_aacd13 := derog_aacd13;
		SELF.derog_subscore13 := derog_subscore13;
		SELF.derog_distance13 := derog_distance13;
		SELF.derog_subscore14 := derog_subscore14;
		SELF.derog_aacd14 := derog_aacd14;
		SELF.derog_distance14 := derog_distance14;
		SELF.derog_aacd15 := derog_aacd15;
		SELF.derog_subscore15 := derog_subscore15;
		SELF.derog_distance15 := derog_distance15;
		SELF.derog_subscore16 := derog_subscore16;
		SELF.derog_aacd16 := derog_aacd16;
		SELF.derog_distance16 := derog_distance16;
		SELF.derog_aacd17 := derog_aacd17;
		SELF.derog_subscore17 := derog_subscore17;
		SELF.derog_distance17 := derog_distance17;
		SELF.derog_subscore18 := derog_subscore18;
		SELF.derog_aacd18 := derog_aacd18;
		SELF.derog_distance18 := derog_distance18;
		SELF.derog_subscore19 := derog_subscore19;
		SELF.derog_aacd19 := derog_aacd19;
		SELF.derog_distance19 := derog_distance19;
		SELF.derog_subscore20 := derog_subscore20;
		SELF.derog_aacd20 := derog_aacd20;
		SELF.derog_distance20 := derog_distance20;
		SELF.derog_subscore21 := derog_subscore21;
		SELF.derog_aacd21 := derog_aacd21;
		SELF.derog_distance21 := derog_distance21;
		SELF.derog_subscore22 := derog_subscore22;
		SELF.derog_aacd22 := derog_aacd22;
		SELF.derog_distance22 := derog_distance22;
		SELF.derog_aacd23 := derog_aacd23;
		SELF.derog_subscore23 := derog_subscore23;
		SELF.derog_distance23 := derog_distance23;
		SELF.derog_subscore24 := derog_subscore24;
		SELF.derog_aacd24 := derog_aacd24;
		SELF.derog_distance24 := derog_distance24;
		SELF.derog_rcvaluea41 := derog_rcvaluea41;
		SELF.derog_rcvaluea43 := derog_rcvaluea43;
		SELF.derog_rcvaluea50 := derog_rcvaluea50;
		SELF.derog_rcvaluec13 := derog_rcvaluec13;
		SELF.derog_rcvaluec14 := derog_rcvaluec14;
		SELF.derog_rcvaluec21 := derog_rcvaluec21;
		SELF.derog_rcvaluec22 := derog_rcvaluec22;
		SELF.derog_rcvalued32 := derog_rcvalued32;
		SELF.derog_rcvalued33 := derog_rcvalued33;
		SELF.derog_rcvalued34 := derog_rcvalued34;
		SELF.derog_rcvaluee55 := derog_rcvaluee55;
		SELF.derog_rcvaluee57 := derog_rcvaluee57;
		SELF.derog_rcvaluef03 := derog_rcvaluef03;
		SELF.derog_rcvaluei60 := derog_rcvaluei60;
		SELF.derog_rcvaluel77 := derog_rcvaluel77;
		SELF.derog_rcvalues66 := derog_rcvalues66;
		SELF.derog_rawscore := derog_rawscore;
		SELF.derog_lnoddsscore := derog_lnoddsscore;
		SELF.owner_aacd1 := owner_aacd1;
		SELF.owner_subscore1 := owner_subscore1;
		SELF.owner_distance1 := owner_distance1;
		SELF.owner_aacd2 := owner_aacd2;
		SELF.owner_subscore2 := owner_subscore2;
		SELF.owner_distance2 := owner_distance2;
		SELF.owner_aacd3 := owner_aacd3;
		SELF.owner_subscore3 := owner_subscore3;
		SELF.owner_distance3 := owner_distance3;
		SELF.owner_subscore4 := owner_subscore4;
		SELF.owner_aacd4 := owner_aacd4;
		SELF.owner_distance4 := owner_distance4;
		SELF.owner_subscore5 := owner_subscore5;
		SELF.owner_aacd5 := owner_aacd5;
		SELF.owner_distance5 := owner_distance5;
		SELF.owner_subscore6 := owner_subscore6;
		SELF.owner_aacd6 := owner_aacd6;
		SELF.owner_distance6 := owner_distance6;
		SELF.owner_subscore7 := owner_subscore7;
		SELF.owner_aacd7 := owner_aacd7;
		SELF.owner_distance7 := owner_distance7;
		SELF.owner_subscore8 := owner_subscore8;
		SELF.owner_aacd8 := owner_aacd8;
		SELF.owner_distance8 := owner_distance8;
		SELF.owner_subscore9 := owner_subscore9;
		SELF.owner_aacd9 := owner_aacd9;
		SELF.owner_distance9 := owner_distance9;
		SELF.owner_aacd10 := owner_aacd10;
		SELF.owner_subscore10 := owner_subscore10;
		SELF.owner_distance10 := owner_distance10;
		SELF.owner_subscore11 := owner_subscore11;
		SELF.owner_aacd11 := owner_aacd11;
		SELF.owner_distance11 := owner_distance11;
		SELF.owner_aacd12 := owner_aacd12;
		SELF.owner_subscore12 := owner_subscore12;
		SELF.owner_distance12 := owner_distance12;
		SELF.owner_subscore13 := owner_subscore13;
		SELF.owner_aacd13 := owner_aacd13;
		SELF.owner_distance13 := owner_distance13;
		SELF.owner_subscore14 := owner_subscore14;
		SELF.owner_aacd14 := owner_aacd14;
		SELF.owner_distance14 := owner_distance14;
		SELF.owner_subscore15 := owner_subscore15;
		SELF.owner_aacd15 := owner_aacd15;
		SELF.owner_distance15 := owner_distance15;
		SELF.owner_subscore16 := owner_subscore16;
		SELF.owner_aacd16 := owner_aacd16;
		SELF.owner_distance16 := owner_distance16;
		SELF.owner_subscore17 := owner_subscore17;
		SELF.owner_aacd17 := owner_aacd17;
		SELF.owner_distance17 := owner_distance17;
		SELF.owner_subscore18 := owner_subscore18;
		SELF.owner_aacd18 := owner_aacd18;
		SELF.owner_distance18 := owner_distance18;
		SELF.owner_aacd19 := owner_aacd19;
		SELF.owner_subscore19 := owner_subscore19;
		SELF.owner_distance19 := owner_distance19;
		SELF.owner_aacd20 := owner_aacd20;
		SELF.owner_subscore20 := owner_subscore20;
		SELF.owner_distance20 := owner_distance20;
		SELF.owner_subscore21 := owner_subscore21;
		SELF.owner_aacd21 := owner_aacd21;
		SELF.owner_distance21 := owner_distance21;
		SELF.owner_aacd22 := owner_aacd22;
		SELF.owner_subscore22 := owner_subscore22;
		SELF.owner_distance22 := owner_distance22;
		SELF.owner_subscore23 := owner_subscore23;
		SELF.owner_aacd23 := owner_aacd23;
		SELF.owner_distance23 := owner_distance23;
		SELF.owner_subscore24 := owner_subscore24;
		SELF.owner_aacd24 := owner_aacd24;
		SELF.owner_distance24 := owner_distance24;
		SELF.owner_aacd25 := owner_aacd25;
		SELF.owner_subscore25 := owner_subscore25;
		SELF.owner_distance25 := owner_distance25;
		SELF.owner_subscore26 := owner_subscore26;
		SELF.owner_aacd26 := owner_aacd26;
		SELF.owner_distance26 := owner_distance26;
		SELF.owner_aacd27 := owner_aacd27;
		SELF.owner_subscore27 := owner_subscore27;
		SELF.owner_distance27 := owner_distance27;
		SELF.owner_subscore28 := owner_subscore28;
		SELF.owner_aacd28 := owner_aacd28;
		SELF.owner_distance28 := owner_distance28;
		SELF.owner_aacd29 := owner_aacd29;
		SELF.owner_subscore29 := owner_subscore29;
		SELF.owner_distance29 := owner_distance29;
		// SELF.owner_rcvaluea51 := owner_rcvaluea51;
		SELF.owner_rcvaluea43 := owner_rcvaluea43;
		SELF.owner_rcvaluea44 := owner_rcvaluea44;
		SELF.owner_rcvaluea46 := owner_rcvaluea46;
		SELF.owner_rcvaluea50 := owner_rcvaluea50;
		SELF.owner_rcvaluea51 := owner_rcvaluea51;
		SELF.owner_rcvaluec10 := owner_rcvaluec10;
		SELF.owner_rcvaluec12 := owner_rcvaluec12;
		SELF.owner_rcvaluec13 := owner_rcvaluec13;
		SELF.owner_rcvaluec14 := owner_rcvaluec14;
		SELF.owner_rcvaluec15 := owner_rcvaluec15;
		SELF.owner_rcvaluec21 := owner_rcvaluec21;
		SELF.owner_rcvalued34 := owner_rcvalued34;
		SELF.owner_rcvaluee55 := owner_rcvaluee55;
		SELF.owner_rcvaluee57 := owner_rcvaluee57;
		SELF.owner_rcvaluef01 := owner_rcvaluef01;
		SELF.owner_rcvaluef03 := owner_rcvaluef03;
		SELF.owner_rcvaluei60 := owner_rcvaluei60;
		SELF.owner_rcvaluel77 := owner_rcvaluel77;
		SELF.owner_rcvaluel79 := owner_rcvaluel79;
		SELF.owner_rcvaluel80 := owner_rcvaluel80;
		SELF.owner_rcvalues66 := owner_rcvalues66;
		SELF.owner_rawscore := owner_rawscore;
		SELF.owner_lnoddsscore := owner_lnoddsscore;
		SELF.other_subscore1 := other_subscore1;
		SELF.other_aacd1 := other_aacd1;
		SELF.other_distance1 := other_distance1;
		SELF.other_aacd2 := other_aacd2;
		SELF.other_subscore2 := other_subscore2;
		SELF.other_distance2 := other_distance2;
		SELF.other_aacd3 := other_aacd3;
		SELF.other_subscore3 := other_subscore3;
		SELF.other_distance3 := other_distance3;
		SELF.other_subscore4 := other_subscore4;
		SELF.other_aacd4 := other_aacd4;
		SELF.other_distance4 := other_distance4;
		SELF.other_aacd5 := other_aacd5;
		SELF.other_subscore5 := other_subscore5;
		SELF.other_distance5 := other_distance5;
		SELF.other_subscore6 := other_subscore6;
		SELF.other_aacd6 := other_aacd6;
		SELF.other_distance6 := other_distance6;
		SELF.other_subscore7 := other_subscore7;
		SELF.other_aacd7 := other_aacd7;
		SELF.other_distance7 := other_distance7;
		SELF.other_subscore8 := other_subscore8;
		SELF.other_aacd8 := other_aacd8;
		SELF.other_distance8 := other_distance8;
		SELF.other_subscore9 := other_subscore9;
		SELF.other_aacd9 := other_aacd9;
		SELF.other_distance9 := other_distance9;
		SELF.other_subscore10 := other_subscore10;
		SELF.other_aacd10 := other_aacd10;
		SELF.other_distance10 := other_distance10;
		SELF.other_subscore11 := other_subscore11;
		SELF.other_aacd11 := other_aacd11;
		SELF.other_distance11 := other_distance11;
		SELF.other_aacd12 := other_aacd12;
		SELF.other_subscore12 := other_subscore12;
		SELF.other_distance12 := other_distance12;
		SELF.other_aacd13 := other_aacd13;
		SELF.other_subscore13 := other_subscore13;
		SELF.other_distance13 := other_distance13;
		SELF.other_aacd14 := other_aacd14;
		SELF.other_subscore14 := other_subscore14;
		SELF.other_distance14 := other_distance14;
		SELF.other_subscore15 := other_subscore15;
		SELF.other_aacd15 := other_aacd15;
		SELF.other_distance15 := other_distance15;
		SELF.other_aacd16 := other_aacd16;
		SELF.other_subscore16 := other_subscore16;
		SELF.other_distance16 := other_distance16;
		SELF.other_subscore17 := other_subscore17;
		SELF.other_aacd17 := other_aacd17;
		SELF.other_distance17 := other_distance17;
		SELF.other_subscore18 := other_subscore18;
		SELF.other_aacd18 := other_aacd18;
		SELF.other_distance18 := other_distance18;
		SELF.other_aacd19 := other_aacd19;
		SELF.other_subscore19 := other_subscore19;
		SELF.other_distance19 := other_distance19;
		SELF.other_aacd20 := other_aacd20;
		SELF.other_subscore20 := other_subscore20;
		SELF.other_distance20 := other_distance20;
		SELF.other_subscore21 := other_subscore21;
		SELF.other_aacd21 := other_aacd21;
		SELF.other_distance21 := other_distance21;
		SELF.other_subscore22 := other_subscore22;
		SELF.other_aacd22 := other_aacd22;
		SELF.other_distance22 := other_distance22;
		SELF.other_aacd23 := other_aacd23;
		SELF.other_subscore23 := other_subscore23;
		SELF.other_distance23 := other_distance23;
		SELF.other_subscore24 := other_subscore24;
		SELF.other_aacd24 := other_aacd24;
		SELF.other_distance24 := other_distance24;
		SELF.other_aacd25 := other_aacd25;
		SELF.other_subscore25 := other_subscore25;
		SELF.other_distance25 := other_distance25;
		SELF.other_subscore26 := other_subscore26;
		SELF.other_aacd26 := other_aacd26;
		SELF.other_distance26 := other_distance26;
		SELF.other_subscore27 := other_subscore27;
		SELF.other_aacd27 := other_aacd27;
		SELF.other_distance27 := other_distance27;
		SELF.other_rcvaluea43 := other_rcvaluea43;
		SELF.other_rcvaluea50 := other_rcvaluea50;
		SELF.other_rcvaluea51 := other_rcvaluea51;
		SELF.other_rcvaluec10 := other_rcvaluec10;
		SELF.other_rcvaluec12 := other_rcvaluec12;
		SELF.other_rcvaluec13 := other_rcvaluec13;
		SELF.other_rcvaluec14 := other_rcvaluec14;
		SELF.other_rcvaluec15 := other_rcvaluec15;
		SELF.other_rcvaluec20 := other_rcvaluec20;
		SELF.other_rcvaluec21 := other_rcvaluec21;
		SELF.other_rcvaluee55 := other_rcvaluee55;
		SELF.other_rcvaluee57 := other_rcvaluee57;
		SELF.other_rcvaluef01 := other_rcvaluef01;
		SELF.other_rcvaluef03 := other_rcvaluef03;
		SELF.other_rcvaluei60 := other_rcvaluei60;
		SELF.other_rcvaluel79 := other_rcvaluel79;
		SELF.other_rcvaluel80 := other_rcvaluel80;
		SELF.other_rcvalues66 := other_rcvalues66;
		SELF.other_rawscore := other_rawscore;
		SELF.other_lnoddsscore := other_lnoddsscore;
		SELF.lnoddsscore := lnoddsscore;
		SELF.score_lnodds := score_lnodds;
		SELF.score_lnodds_capped := score_lnodds_capped;
		SELF.ov_ssnprior := ov_ssnprior;
		SELF.ov_corrections := ov_corrections;
		SELF.unscorable := unscorable;
		SELF.deceased := deceased;
		SELF.rva1403_0_0 := rva1403_0_0;
		SELF.verprob_rc1 := verprob_rc1;
		SELF.verprob_rc2 := verprob_rc2;
		SELF.verprob_rc3 := verprob_rc3;
		SELF.verprob_rc4 := verprob_rc4;
		SELF.derog_rc1 := derog_rc1;
		SELF.derog_rc2 := derog_rc2;
		SELF.derog_rc3 := derog_rc3;
		SELF.derog_rc4 := derog_rc4;
		SELF.owner_rc1 := owner_rc1;
		SELF.owner_rc2 := owner_rc2;
		SELF.owner_rc3 := owner_rc3;
		SELF.owner_rc4 := owner_rc4;
		SELF.other_rc1 := other_rc1;
		SELF.other_rc2 := other_rc2;
		SELF.other_rc3 := other_rc3;
		SELF.other_rc4 := other_rc4;
		SELF.rc1_1 := rc1_1;
		SELF._rc_seg_c267 := _rc_seg_c267;
		SELF._rc_seg_c268 := _rc_seg_c268;
		SELF._rc_seg_c266 := _rc_seg_c266;
		SELF._rc_seg_c269 := _rc_seg_c269;
		SELF._rc_seg := _rc_seg;
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
		SELF.score := (STRING3)rva1403_0_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;