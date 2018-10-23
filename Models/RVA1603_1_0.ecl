IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVA1603_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Input Variables */
			UNSIGNED seq;
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
			INTEGER add_input_lres;
			INTEGER add_input_occ_index;
			STRING add_input_advo_vacancy;
			STRING add_input_advo_res_or_bus;
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
			INTEGER ssns_per_adl;
			INTEGER addrs_per_adl;
			INTEGER adls_per_ssn;
			INTEGER adls_per_addr_curr;
			INTEGER ssns_per_addr_curr;
			INTEGER invalid_ssns_per_adl;
			INTEGER inq_auto_count12;
			INTEGER inq_communications_count;
			INTEGER inq_communications_count01;
			INTEGER inq_communications_count03;
			INTEGER inq_communications_count06;
			INTEGER inq_communications_count12;
			INTEGER inq_communications_count24;
			INTEGER inq_highriskcredit_count;
			INTEGER inq_highriskcredit_count01;
			INTEGER inq_highriskcredit_count03;
			INTEGER inq_highriskcredit_count06;
			INTEGER inq_highriskcredit_count12;
			INTEGER inq_highriskcredit_count24;
			INTEGER inq_phonesperadl;
			INTEGER pb_total_orders;
			INTEGER br_source_count;
			INTEGER infutor_nap;
			INTEGER stl_inq_count;
			INTEGER stl_inq_count24;
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
			INTEGER felony_count;
			INTEGER watercraft_count;
			BOOLEAN prof_license_flag;
			STRING input_dob_match_level;

			/* Model Intermediate Variables */
			//STRING NULL;
			INTEGER sysdate;
			STRING iv_rv5_unscorable_1;
			INTEGER rv_d32_criminal_count;
			INTEGER rv_c21_stl_inq_count;
			STRING rv_d33_eviction_recency;
			INTEGER rv_c12_source_profile_index;
			INTEGER rv_s66_adlperssn_count;
			STRING rv_f03_address_match;
			INTEGER rv_c14_addrs_10yr;
			STRING rv_a41_a42_prop_owner_history;
			INTEGER rv_e57_prof_license_br_flag;
			INTEGER rv_i60_inq_hiriskcred_recency;
			INTEGER rv_i60_inq_comm_recency;
			INTEGER rv_a50_pb_total_orders;
			INTEGER rv_c13_inp_addr_lres;
			INTEGER rv_i62_inq_phones_per_adl;
			STRING rv_d32_criminal_x_felony;
			INTEGER rv_a46_curr_avm_autoval;
			INTEGER rv_c22_inp_addr_occ_index;
			INTEGER rv_c13_attr_addrs_recency;
			INTEGER rv_f01_inp_addr_address_score;
			INTEGER rv_c12_num_nonderogs;
			INTEGER rv_c15_ssns_per_adl;
			INTEGER rv_c14_addrs_5yr;
			STRING rv_a43_rec_vehx_level;
			INTEGER rv_i60_inq_auto_count12;
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
			STRING derog_aacd_12;
			REAL derog_dist_12;
			STRING derog_aacd_13;
			REAL derog_dist_13;
			REAL derog_rcvaluec21;
			REAL derog_rcvaluei62;
			REAL derog_rcvaluei60;
			REAL derog_rcvalued32;
			REAL derog_rcvalued33;
			REAL derog_rcvaluea50;
			REAL derog_rcvaluea42;
			REAL derog_rcvaluef03;
			REAL derog_rcvaluea41;
			REAL derog_rcvaluec13;
			REAL derog_rcvaluec12;
			REAL derog_rcvaluee57;
			REAL derog_rcvalues66;
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
			REAL owner_rawscore;
			REAL owner_lnoddsscore;
			REAL owner_probscore;
			STRING owner_aacd_0;
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
			REAL owner_rcvaluea46;
			REAL owner_rcvaluei62;
			REAL owner_rcvaluea51;
			REAL owner_rcvaluea50;
			REAL owner_rcvaluef01;
			REAL owner_rcvaluea43;
			REAL owner_rcvaluef03;
			REAL owner_rcvaluec12;
			REAL owner_rcvaluec13;
			REAL owner_rcvaluei60;
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
			STRING other_aacd_11;
			REAL other_dist_11;
			REAL other_rcvaluec22;
			REAL other_rcvaluea46;
			REAL other_rcvaluec21;
			REAL other_rcvaluei62;
			REAL other_rcvalued32;
			REAL other_rcvalued33;
			REAL other_rcvaluea51;
			REAL other_rcvalues66;
			REAL other_rcvaluei60;
			REAL other_rcvaluef03;
			REAL other_rcvaluea41;
			REAL other_rcvaluec13;
			STRING owner_rc2;
			STRING owner_rc3;
			STRING owner_rc4;
			STRING other_rc2;
			STRING other_rc3;
			STRING other_rc4;
			STRING derog_rc2;
			STRING derog_rc3;
			STRING derog_rc4;
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
			STRING custom_segment;
			BOOLEAN iv_rv5_deceased;
			STRING iv_rv5_unscorable;
			INTEGER base;
			REAL odds;
			INTEGER pts;
			REAL lnoddsscore;
			INTEGER rva1603_1_0;
			STRING rc4_3;
			STRING _rc_inq;
			STRING rc1_c122;
			STRING rc1_1;
			STRING rc1_2;
			STRING rc1_3;
			STRING derog_rc1;
			STRING owner_rc1;
			STRING other_rc1;
			STRING rc2_2;
			STRING rc3_2;
			STRING rc4_2;
			STRING rc2_c122;			
			STRING rc3_c122;
			STRING rc4_c122;
			STRING rc5_c122;
			STRING rc2_1;
			STRING rc3_1;
			STRING rc4_1;
			STRING rc5_1;
			STRING rc1;
			STRING rc2;
			STRING rc3;
			STRING rc4;
			STRING rc5;

			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	seq															 := le.seq;
	truedid                          := le.truedid;
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
	add_input_lres                   := le.lres;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
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
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlperssn_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_auto_count12                 := le.acc_logs.auto.count12;
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
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	pb_total_orders                  := (INTEGER)le.ibehavior.total_number_of_orders;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	stl_inq_count24                  := le.impulse.count24;
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
	watercraft_count                 := le.watercraft.watercraft_count;
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
	
	sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
	
	iv_rv5_unscorable_1 := if(riskview.constants.noscore(nas_summary,nap_summary, add_input_naprop, le.truedid), '1', '0');
	
	rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));
	
	rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));
	
	rv_d33_eviction_recency := map(
	    not(truedid)                                                				 => '',
	    (boolean)attr_eviction_count90                                       => '03',
	    (boolean)attr_eviction_count180                                      => '06',
	    (boolean)attr_eviction_count12                                       => '12',
	    (boolean)attr_eviction_count24 and (integer)attr_eviction_count >= 2 => '24',
	    (boolean)attr_eviction_count24                                       => '25',
	    (boolean)attr_eviction_count36 and (integer)attr_eviction_count >= 2 => '36',
	    (boolean)attr_eviction_count36                                       => '37',
	    (boolean)attr_eviction_count60 and (integer)attr_eviction_count >= 2 => '60',
	    (boolean)attr_eviction_count60                                       => '61',
	    (integer)attr_eviction_count >= 2                                    => '98',
	    (integer)attr_eviction_count >= 1                                    => '99',
																																						'00');
	
	rv_c12_source_profile_index := if(not(truedid), NULL, hdr_source_profile_index);
	
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
	
	rv_c14_addrs_10yr := map(
	    not(truedid)     => NULL,
	    (integer)add_curr_pop = 0 => -1,
	                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));
	
	rv_a41_a42_prop_owner_history := map(
	    not(truedid)                                                                     => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
	    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
	                                                                                        'NEVER');
																	
	rv_e57_prof_license_br_flag := if(not(truedid), NULL, 
																	(INTEGER)(sum(prof_license_flag, br_source_count) > 0));
	
	rv_i60_inq_hiriskcred_recency := map(
	    not(truedid)               => NULL,
	    (boolean)inq_highRiskCredit_count01 => 1,
	    (boolean)inq_highRiskCredit_count03 => 3,
	    (boolean)inq_highRiskCredit_count06 => 6,
	    (boolean)inq_highRiskCredit_count12 => 12,
	    (boolean)inq_highRiskCredit_count24 => 24,
	    (boolean)inq_highRiskCredit_count   => 99,
	                                  0);
	
	rv_i60_inq_comm_recency := map(
	    not(truedid)               => NULL,
	    (boolean)inq_communications_count01 => 1,
	    (boolean)inq_communications_count03 => 3,
	    (boolean)inq_communications_count06 => 6,
	    (boolean)inq_communications_count12 => 12,
	    (boolean)inq_communications_count24 => 24,
	    (boolean)inq_communications_count   => 99,
	                                  0);
	
	rv_a50_pb_total_orders := map(
	    not(truedid)        => NULL,
	    pb_total_orders = 0 => -1,
													pb_total_orders);
	
	rv_c13_inp_addr_lres := if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999));
	
	rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));
	
	rv_d32_criminal_x_felony := if(not(truedid), '', 
															(string)(min(if(criminal_count = NULL, -NULL, criminal_count), 3)) + '-' +
															(string)(min(if(felony_count = NULL, -NULL, felony_count), 3)));
	
	rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	rv_c22_inp_addr_occ_index := if(not(add_input_pop and truedid), NULL, add_input_occ_index);
	
	rv_c13_attr_addrs_recency := map(
	    not(truedid)      => NULL,
	    (boolean)attr_addrs_last30 => 1,
	    (boolean)attr_addrs_last90 => 3,
	    (boolean)attr_addrs_last12 => 12,
	    (boolean)attr_addrs_last24 => 24,
	    (boolean)attr_addrs_last36 => 36,
	    (boolean)addrs_5yr         => 60,
	    (boolean)addrs_10yr        => 120,
	    (boolean)addrs_15yr        => 180,
	    addrs_per_adl > 0 				 => 999,
																		0);
	
	rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	rv_c12_num_nonderogs := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4));
	
	rv_c15_ssns_per_adl := map(
	    not(truedid)     => NULL,
	    ssns_per_adl = 0 => 1,
	                        min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 999));
	
	rv_c14_addrs_5yr := map(
	    not(truedid)     			=> NULL,
	    add_curr_pop = false 	=> -1,
															 min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));
	
	rv_a43_rec_vehx_level := map(
	    not(truedid)                                   => '',
	    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
	    attr_num_aircraft > 0                          => 'AO',
	    watercraft_count > 0                           => 'W' + (string)(min(if(watercraft_count = 0, -NULL, watercraft_count), 3)),
	                                                      'XX');
	
	rv_i60_inq_auto_count12 := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));
	
	derog_subscore0 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => -0.182301,
	    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 0.137823,
	                                                                                                                                          0);
	
	derog_subscore1 := map(
	    (rv_d33_eviction_recency in ['00'])                         => 0.10617,
	    (rv_d33_eviction_recency in ['03'])                         => -0.46348,
	    (rv_d33_eviction_recency in ['06'])                         => -0.254928,
	    (rv_d33_eviction_recency in ['12'])                         => -0.185244,
	    (rv_d33_eviction_recency in ['24', '25', '36', '37', '60']) => -0.151276,
	    (rv_d33_eviction_recency in ['61', '98'])                   => -0.048081,
	    (rv_d33_eviction_recency in ['99'])                         => -0.016283,
	                                                                   0);
	
	derog_subscore2 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.040381,
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => -0.067218,
	    2 <= rv_c21_stl_inq_count                                => -0.360923,
	                                                                0);
	
	derog_subscore3 := map(
	    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 7 => -0.096313,
	    7 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 13  => -0.046795,
	    13 <= rv_c13_inp_addr_lres                               => 0.093064,
	                                                                0);
	
	derog_subscore4 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 0 => 0,
	    0 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1   => 0.273496,
	    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 0.107466,
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => 0.03542,
	    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => -0.007622,
	    5 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 7   => -0.049903,
	    7 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 9   => -0.08727,
	    9 <= rv_c14_addrs_10yr                             => -0.155542,
	                                                          0);
	
	derog_subscore5 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 0.033148,
	    1 <= rv_d32_criminal_count AND rv_d32_criminal_count < 3   => -0.118112,
	    3 <= rv_d32_criminal_count AND rv_d32_criminal_count < 7   => -0.308313,
	    7 <= rv_d32_criminal_count                                 => -0.498103,
	                                                                  0);
	
	derog_subscore6 := map(
	    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => 0.111959,
	    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 0.080768,
	    (rv_a41_a42_prop_owner_history in ['NEVER'])      => -0.052608,
	                                                         0);
	
	derog_subscore7 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.052364,
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.033298,
	    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.073684,
	    3 <= rv_i62_inq_phones_per_adl                                     => -0.28785,
	                                                                          0);
	
	derog_subscore8 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => -0.047723,
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 12  => 0.060064,
	    12 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 21 => 0.092949,
	    21 <= rv_a50_pb_total_orders                                 => 0.144494,
	                                                                    0);
	
	derog_subscore9 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 1 => 0,
	    1 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 5   => -0.048223,
	    5 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 6   => 0.008915,
	    6 <= rv_c12_source_profile_index                                       => 0.06736,
	                                                                              0);
	
	derog_subscore10 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.014708,
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => -0.215402,
	    3 <= rv_i60_inq_hiriskcred_recency                                         => -0.104818,
	                                                                                  0);
	
	derog_subscore11 := map(
	    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 0.008754,
	    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => -0.268337,
	    6 <= rv_i60_inq_comm_recency                                   => -0.097654,
	                                                                      0);
	
	derog_subscore12 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.028855,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.028271,
	    3 <= rv_s66_adlperssn_count                                  => -0.06088,
	                                                                    0);
	
	derog_subscore13 := map(
	    ((string)rv_e57_prof_license_br_flag in ['0']) => -0.013076,
	    ((string)rv_e57_prof_license_br_flag in ['1']) => 0.060958,
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
	    derog_subscore13;
	
	derog_lnoddsscore := derog_rawscore + 1.761324;
	
	derog_probscore := exp(derog_lnoddsscore) / (1 + exp(derog_lnoddsscore));
	
	derog_aacd_0 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => 'F03',
	    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 'F03',
	                                                                                                                                          '');
	
	derog_dist_0 := derog_subscore0 - 0.137823;
	
	derog_aacd_1 := map(
	    (rv_d33_eviction_recency in ['00'])                         => 'D33',
	    (rv_d33_eviction_recency in ['03'])                         => 'D33',
	    (rv_d33_eviction_recency in ['06'])                         => 'D33',
	    (rv_d33_eviction_recency in ['12'])                         => 'D33',
	    (rv_d33_eviction_recency in ['24', '25', '36', '37', '60']) => 'D33',
	    (rv_d33_eviction_recency in ['61', '98'])                   => 'D33',
	    (rv_d33_eviction_recency in ['99'])                         => 'D33',
	                                                                   '');
	
	derog_dist_1 := derog_subscore1 - 0.10617;
	
	derog_aacd_2 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => 'C21',
	    2 <= rv_c21_stl_inq_count                                => 'C21',
	                                                                '');
	
	derog_dist_2 := derog_subscore2 - 0.040381;
	
	derog_aacd_3 := map(
	    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 7 => 'C13',
	    7 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 13  => 'C13',
	    13 <= rv_c13_inp_addr_lres                               => 'C13',
	                                                                '');
	
	derog_dist_3 := derog_subscore3 - 0.093064;
	
	derog_aacd_4 := map(
	    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 0 => 'C13',
	    0 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 1   => 'C14',
	    1 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 2   => 'C14',
	    2 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 3   => 'C14',
	    3 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 5   => 'C14',
	    5 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 7   => 'C14',
	    7 <= rv_c14_addrs_10yr AND rv_c14_addrs_10yr < 9   => 'C14',
	    9 <= rv_c14_addrs_10yr                             => 'C14',
	                                                          'C13');
	
	derog_dist_4 := derog_subscore4 - 0.273496;
	
	derog_aacd_5 := map(
	    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 1 => 'D32',
	    1 <= rv_d32_criminal_count AND rv_d32_criminal_count < 3   => 'D32',
	    3 <= rv_d32_criminal_count AND rv_d32_criminal_count < 7   => 'D32',
	    7 <= rv_d32_criminal_count                                 => 'D32',
	                                                                  '');
	
	derog_dist_5 := derog_subscore5 - 0.033148;
	
	derog_aacd_6 := map(
	    (rv_a41_a42_prop_owner_history in ['CURRENT'])    => '',
	    (rv_a41_a42_prop_owner_history in ['HISTORICAL']) => 'A42',
	    (rv_a41_a42_prop_owner_history in ['NEVER'])      => 'A41',
	                                                         '');
	
	derog_dist_6 := derog_subscore6 - 0.111959;
	
	derog_aacd_7 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
	    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
	    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
	                                                                          '');
	
	derog_dist_7 := derog_subscore7 - 0.052364;
	
	derog_aacd_8 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => 'A50',
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 12  => 'A50',
	    12 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 21 => 'A50',
	    21 <= rv_a50_pb_total_orders                                 => 'A50',
	                                                                    '');
	
	// derog_dist_8 := derog_subscore8 - 0.144494;
	derog_dist_8 := 0;  // ibehavior reason code edit
	
	derog_aacd_9 := map(
	    NULL < rv_c12_source_profile_index AND rv_c12_source_profile_index < 1 => '',
	    1 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 5   => 'C12',
	    5 <= rv_c12_source_profile_index AND rv_c12_source_profile_index < 6   => 'C12',
	    6 <= rv_c12_source_profile_index                                       => 'C12',
	                                                                              '');
	
	derog_dist_9 := derog_subscore9 - 0.06736;
	
	derog_aacd_10 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => 'I60',
	    3 <= rv_i60_inq_hiriskcred_recency                                         => 'I60',
	                                                                                  '');
	
	derog_dist_10 := derog_subscore10 - 0.014708;
	
	derog_aacd_11 := map(
	    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 1 => 'I60',
	    1 <= rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 6   => 'I60',
	    6 <= rv_i60_inq_comm_recency                                   => 'I60',
	                                                                      '');
	
	derog_dist_11 := derog_subscore11 - 0.008754;
	
	derog_aacd_12 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	derog_dist_12 := derog_subscore12 - 0.028855;
	
	derog_aacd_13 := map(
	    ((string)rv_e57_prof_license_br_flag in ['0']) => 'E57',
	    ((string)rv_e57_prof_license_br_flag in ['1']) => 'E57',
	                                              '');
	
	derog_dist_13 := derog_subscore13 - 0.060958;
	
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
	    (integer)(derog_aacd_12 = 'C21') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C21') * derog_dist_13;
	
	derog_rcvaluei62 := (integer)(derog_aacd_0 = 'I62') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'I62') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'I62') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'I62') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'I62') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'I62') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'I62') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'I62') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'I62') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'I62') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'I62') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'I62') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'I62') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'I62') * derog_dist_13;
	
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
	    (integer)(derog_aacd_12 = 'I60') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'I60') * derog_dist_13;
	
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
	    (integer)(derog_aacd_12 = 'D32') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'D32') * derog_dist_13;
	
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
	    (integer)(derog_aacd_12 = 'D33') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'D33') * derog_dist_13;
	
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
	    (integer)(derog_aacd_12 = 'A50') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'A50') * derog_dist_13;
	
	derog_rcvaluea42 := (integer)(derog_aacd_0 = 'A42') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'A42') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A42') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A42') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A42') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A42') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A42') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A42') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A42') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A42') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A42') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'A42') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'A42') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'A42') * derog_dist_13;
	
	derog_rcvaluef03 := (integer)(derog_aacd_0 = 'F03') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'F03') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'F03') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'F03') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'F03') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'F03') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'F03') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'F03') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'F03') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'F03') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'F03') * derog_dist_10 +
	    (integer)(derog_aacd_11 = 'F03') * derog_dist_11 +
	    (integer)(derog_aacd_12 = 'F03') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'F03') * derog_dist_13;
	
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
	    (integer)(derog_aacd_12 = 'A41') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'A41') * derog_dist_13;
	
	derog_rcvaluec13 := (integer)(derog_aacd_0 = 'C13') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'C13') * derog_dist_1 +
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
	    (integer)(derog_aacd_13 = 'C13') * derog_dist_13;
	
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
	    (integer)(derog_aacd_12 = 'C12') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C12') * derog_dist_13;
	
	derog_rcvaluee57 := (integer)(derog_aacd_0 = 'E57') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'E57') * derog_dist_1 +
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
	    (integer)(derog_aacd_13 = 'E57') * derog_dist_13;
	
	derog_rcvalues66 := (integer)(derog_aacd_0 = 'S66') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'S66') * derog_dist_1 +
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
	    (integer)(derog_aacd_13 = 'S66') * derog_dist_13;
	
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
	    (integer)(derog_aacd_12 = 'C14') * derog_dist_12 +
	    (integer)(derog_aacd_13 = 'C14') * derog_dist_13;
	
	owner_subscore0 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => -0.248025,
	    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 0.098079,
	                                                                                                                                          0);
	
	owner_subscore1 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.029398,
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => -0.584701,
	    12 <= rv_i60_inq_hiriskcred_recency                                        => -0.358597,
	                                                                                  0);
	
	owner_subscore2 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 2 => 0.03533,
	    2 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 3   => -0.268702,
	    3 <= rv_i60_inq_auto_count12                                   => -0.401831,
	                                                                      0);
	
	owner_subscore3 := map(
	    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 5 => -0.112958,
	    5 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 127 => -0.029599,
	    127 <= rv_c13_inp_addr_lres                              => 0.163845,
	                                                                0);
	
	owner_subscore4 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1 => 0.105924,
	    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => -0.044537,
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => -0.085779,
	    4 <= rv_c14_addrs_5yr                            => -0.140728,
	                                                        0);
	
	owner_subscore5 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 80 => -0.200115,
	    80 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 90  => -0.1025,
	    90 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 0.038126,
	    255 <= rv_f01_inp_addr_address_score                                        => 0,
	                                                                                   0);
	
	owner_subscore6 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 0.019798,
	    2 <= rv_c15_ssns_per_adl                               => -0.382372,
	                                                              0);
	
	owner_subscore7 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.060943,
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.109098,
	    3 <= rv_i62_inq_phones_per_adl                                     => -0.162859,
	                                                                          0);
	
	owner_subscore8 := map(
	    (rv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 0.518901,
	    (rv_a43_rec_vehx_level in ['XX'])                         => -0.012713,
	                                                                 0);
	
	owner_subscore9 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1        => 0,
	    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 44320      => -0.25806,
	    44320 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 69864  => -0.082354,
	    69864 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 171000 => 0.016449,
	    171000 <= rv_a46_curr_avm_autoval                                     => 0.083478,
	                                                                             0);
	
	owner_subscore10 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => -0.253659,
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4   => 0.001275,
	    4 <= rv_c12_num_nonderogs                                => 0.062528,
	                                                                0);
	
	owner_subscore11 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => -0.044228,
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 0.037729,
	    2 <= rv_a50_pb_total_orders                                  => 0.056441,
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
	    owner_subscore11;
	
	owner_lnoddsscore := owner_rawscore + 2.620257;
	
	owner_probscore := exp(owner_lnoddsscore) / (1 + exp(owner_lnoddsscore));
	
	owner_aacd_0 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => 'F03',
	    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 'F03',
	                                                                                                                                          '');
	
	owner_dist_0 := owner_subscore0 - 0.098079;
	
	owner_aacd_1 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => 'I60',
	    12 <= rv_i60_inq_hiriskcred_recency                                        => 'I60',
	                                                                                  '');
	
	owner_dist_1 := owner_subscore1 - 0.029398;
	
	owner_aacd_2 := map(
	    NULL < rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 2 => 'I60',
	    2 <= rv_i60_inq_auto_count12 AND rv_i60_inq_auto_count12 < 3   => 'I60',
	    3 <= rv_i60_inq_auto_count12                                   => 'I60',
	                                                                      '');
	
	owner_dist_2 := owner_subscore2 - 0.03533;
	
	owner_aacd_3 := map(
	    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 5 => 'C13',
	    5 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 127 => 'C13',
	    127 <= rv_c13_inp_addr_lres                              => 'C13',
	                                                                '');
	
	owner_dist_3 := owner_subscore3 - 0.163845;
	
	owner_aacd_4 := map(
	    NULL < rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 1 => 'C14',
	    1 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 2   => 'C14',
	    2 <= rv_c14_addrs_5yr AND rv_c14_addrs_5yr < 4   => 'C14',
	    4 <= rv_c14_addrs_5yr                            => 'C14',
	                                                        'C13');
	
	owner_dist_4 := owner_subscore4 - 0.105924;
	
	owner_aacd_5 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 80 => 'F01',
	    80 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 90  => 'F01',
	    90 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 'F01',
	    255 <= rv_f01_inp_addr_address_score                                        => '',
	                                                                                   '');
	
	owner_dist_5 := owner_subscore5 - 0.038126;
	
	owner_aacd_6 := map(
	    NULL < rv_c15_ssns_per_adl AND rv_c15_ssns_per_adl < 2 => 'C15',
	    2 <= rv_c15_ssns_per_adl                               => 'C15',
	                                                              '');
	
	owner_dist_6 := owner_subscore6 - 0.019798;
	
	owner_aacd_7 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
	    3 <= rv_i62_inq_phones_per_adl                                     => 'I62',
	                                                                          '');
	
	owner_dist_7 := owner_subscore7 - 0.060943;
	
	owner_aacd_8 := map(
	    (rv_a43_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 'A43',
	    (rv_a43_rec_vehx_level in ['XX'])                         => 'A43',
	                                                                 '');
	
	owner_dist_8 := owner_subscore8 - 0.518901;
	
	owner_aacd_9 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1        => 'A51',
	    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 44320      => 'A46',
	    44320 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 69864  => 'A46',
	    69864 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 171000 => 'A46',
	    171000 <= rv_a46_curr_avm_autoval                                     => 'A46',
	                                                                             '');
	
	owner_dist_9 := owner_subscore9 - 0.083478;
	
	owner_aacd_10 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => 'C12',
	    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4   => 'C12',
	    4 <= rv_c12_num_nonderogs                                => 'C12',
	                                                                '');
	
	owner_dist_10 := owner_subscore10 - 0.062528;
	
	owner_aacd_11 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => 'A50',
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 'A50',
	    2 <= rv_a50_pb_total_orders                                  => 'A50',
	                                                                    '');
	
	// owner_dist_11 := owner_subscore11 - 0.056441;
	owner_dist_11 := 0;
	
	owner_rcvaluea46 := (integer)(owner_aacd_0 = 'A46') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'A46') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A46') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A46') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A46') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A46') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A46') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A46') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A46') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A46') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A46') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A46') * owner_dist_11;
	
	owner_rcvaluei62 := (integer)(owner_aacd_0 = 'I62') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'I62') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'I62') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'I62') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'I62') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'I62') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'I62') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'I62') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'I62') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'I62') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'I62') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'I62') * owner_dist_11;
	
	owner_rcvaluea51 := (integer)(owner_aacd_0 = 'A51') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'A51') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A51') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A51') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A51') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A51') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A51') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A51') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A51') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A51') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A51') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A51') * owner_dist_11;
	
	owner_rcvaluea50 := (integer)(owner_aacd_0 = 'A50') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'A50') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A50') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A50') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A50') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A50') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A50') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A50') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A50') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A50') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A50') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A50') * owner_dist_11;
	
	owner_rcvaluef01 := (integer)(owner_aacd_0 = 'F01') * owner_dist_0 +
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
	    (integer)(owner_aacd_11 = 'F01') * owner_dist_11;
	
	owner_rcvaluea43 := (integer)(owner_aacd_0 = 'A43') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'A43') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'A43') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'A43') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'A43') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'A43') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'A43') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'A43') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'A43') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'A43') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'A43') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'A43') * owner_dist_11;
	
	owner_rcvaluef03 := (integer)(owner_aacd_0 = 'F03') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'F03') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'F03') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'F03') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'F03') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'F03') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'F03') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'F03') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'F03') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'F03') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'F03') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'F03') * owner_dist_11;
	
	owner_rcvaluec12 := (integer)(owner_aacd_0 = 'C12') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'C12') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C12') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C12') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C12') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C12') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C12') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C12') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C12') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C12') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C12') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C12') * owner_dist_11;
	
	owner_rcvaluec13 := (integer)(owner_aacd_0 = 'C13') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'C13') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C13') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C13') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C13') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C13') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C13') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C13') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C13') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C13') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C13') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C13') * owner_dist_11;
	
	owner_rcvaluei60 := (integer)(owner_aacd_0 = 'I60') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'I60') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'I60') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'I60') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'I60') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'I60') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'I60') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'I60') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'I60') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'I60') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'I60') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'I60') * owner_dist_11;
	
	owner_rcvaluec15 := (integer)(owner_aacd_0 = 'C15') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'C15') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C15') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C15') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C15') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C15') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C15') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C15') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C15') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C15') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C15') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C15') * owner_dist_11;
	
	owner_rcvaluec14 := (integer)(owner_aacd_0 = 'C14') * owner_dist_0 +
	    (integer)(owner_aacd_1 = 'C14') * owner_dist_1 +
	    (integer)(owner_aacd_2 = 'C14') * owner_dist_2 +
	    (integer)(owner_aacd_3 = 'C14') * owner_dist_3 +
	    (integer)(owner_aacd_4 = 'C14') * owner_dist_4 +
	    (integer)(owner_aacd_5 = 'C14') * owner_dist_5 +
	    (integer)(owner_aacd_6 = 'C14') * owner_dist_6 +
	    (integer)(owner_aacd_7 = 'C14') * owner_dist_7 +
	    (integer)(owner_aacd_8 = 'C14') * owner_dist_8 +
	    (integer)(owner_aacd_9 = 'C14') * owner_dist_9 +
	    (integer)(owner_aacd_10 = 'C14') * owner_dist_10 +
	    (integer)(owner_aacd_11 = 'C14') * owner_dist_11;
	
	other_subscore0 := map(
	    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 7 => -0.119265,
	    7 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 18  => 0.097096,
	    18 <= rv_c13_inp_addr_lres                               => 0.130038,
	                                                                0);
	
	other_subscore1 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 0.064125,
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => -0.038332,
	    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.247944,
	    3 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => -0.464311,
	    4 <= rv_i62_inq_phones_per_adl                                     => -0.745605,
	                                                                          0);
	
	other_subscore2 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.029699,
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => -0.518698,
	    3 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => -0.464442,
	    12 <= rv_i60_inq_hiriskcred_recency                                        => -0.259052,
	                                                                                  0);
	
	other_subscore3 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.026437,
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => -0.262262,
	    2 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => -0.586794,
	    3 <= rv_c21_stl_inq_count                                => -0.646748,
	                                                                0);
	
	other_subscore4 := map(
	    (rv_d33_eviction_recency in [''])                                                  => 0,
	    (rv_d33_eviction_recency in ['00'])                                                 => 0.024785,
	    (rv_d33_eviction_recency in ['03', '06'])                                           => -0.650876,
	    (rv_d33_eviction_recency in ['12', '24', '25', '36', '37', '60', '61', '98', '99']) => -0.350914,
	                                                                                           0);
	
	other_subscore5 := map(
	    (rv_f03_address_match in [''])                                                                                                    => 0,
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => -0.106313,
	    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 0.086774,
	                                                                                                                                          0);
	
	other_subscore6 := map(
	    (rv_d32_criminal_x_felony in [''])                                                                                => 0,
	    (rv_d32_criminal_x_felony in ['0-0'])                                                                              => 0.01444,
	    (rv_d32_criminal_x_felony in ['1-0', '2-0'])                                                                       => -0.354807,
	    (rv_d32_criminal_x_felony in ['3-0'])                                                                              => -0.474259,
	    (rv_d32_criminal_x_felony in ['0-1', '0-2', '0-3', '1-2', '1-3', '2-3', '1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.688451,
	                                                                                                                          0);
	
	other_subscore7 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 36 => -0.075111,
	    36 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60  => 0.044464,
	    60 <= rv_c13_attr_addrs_recency                                     => 0.128045,
	                                                                           0);
	
	other_subscore8 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1        => 0,
	    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 42330      => -0.282624,
	    42330 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 63798  => -0.055326,
	    63798 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 91770  => -0.034919,
	    91770 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 181600 => 0.007435,
	    181600 <= rv_a46_curr_avm_autoval                                     => 0.11257,
	                                                                             0);
	
	other_subscore9 := map(
	    ((string)rv_c22_inp_addr_occ_index in [''])                               => 0,
	    ((string)rv_c22_inp_addr_occ_index in ['0'])                               => 0,
	    ((string)rv_c22_inp_addr_occ_index in ['1'])                               => 0.053524,
	    ((string)rv_c22_inp_addr_occ_index in ['2', '3', '4', '5', '6', '7', '8']) => -0.09137,
	                                                                          0);
	
	other_subscore10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.050233,
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.032609,
	    3 <= rv_s66_adlperssn_count                                  => -0.131739,
	                                                                    0);
	
	other_subscore11 := map(
	    (rv_a41_a42_prop_owner_history in [''])                     => 0,
	    (rv_a41_a42_prop_owner_history in ['CURRENT', 'HISTORICAL']) => 0.165819,
	    (rv_a41_a42_prop_owner_history in ['NEVER'])                 => -0.027065,
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
	    other_subscore11;
	
	other_lnoddsscore := other_rawscore + 2.007686;
	
	other_probscore := exp(other_lnoddsscore) / (1 + exp(other_lnoddsscore));
	
	other_aacd_0 := map(
	    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 7 => 'C13',
	    7 <= rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres < 18  => 'C13',
	    18 <= rv_c13_inp_addr_lres                               => 'C13',
	                                                                '');
	
	other_dist_0 := other_subscore0 - 0.130038;
	
	other_aacd_1 := map(
	    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 1 => 'I62',
	    1 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2   => 'I62',
	    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
	    3 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => 'I62',
	    4 <= rv_i62_inq_phones_per_adl                                     => 'I62',
	                                                                          '');
	
	other_dist_1 := other_subscore1 - 0.064125;
	
	other_aacd_2 := map(
	    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
	    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => 'I60',
	    3 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 12  => 'I60',
	    12 <= rv_i60_inq_hiriskcred_recency                                        => 'I60',
	                                                                                  '');
	
	other_dist_2 := other_subscore2 - 0.029699;
	
	other_aacd_3 := map(
	    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
	    1 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 2   => 'C21',
	    2 <= rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 3   => 'C21',
	    3 <= rv_c21_stl_inq_count                                => 'C21',
	                                                                '');
	
	other_dist_3 := other_subscore3 - 0.026437;
	
	other_aacd_4 := map(
	    (rv_d33_eviction_recency in [''])                                                  => '',
	    (rv_d33_eviction_recency in ['00'])                                                 => 'D33',
	    (rv_d33_eviction_recency in ['03', '06'])                                           => 'D33',
	    (rv_d33_eviction_recency in ['12', '24', '25', '36', '37', '60', '61', '98', '99']) => 'D33',
	                                                                                           '');
	
	other_dist_4 := other_subscore4 - 0.024785;
	
	other_aacd_5 := map(
	    (rv_f03_address_match in [''])                                                                                                    => '',
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => 'F03',
	    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 'F03',
	                                                                                                                                          '');
	
	other_dist_5 := other_subscore5 - 0.086774;
	
	other_aacd_6 := map(
	    (rv_d32_criminal_x_felony in [''])                                                                                => '',
	    (rv_d32_criminal_x_felony in ['0-0'])                                                                              => 'D32',
	    (rv_d32_criminal_x_felony in ['1-0', '2-0'])                                                                       => 'D32',
	    (rv_d32_criminal_x_felony in ['3-0'])                                                                              => 'D32',
	    (rv_d32_criminal_x_felony in ['0-1', '0-2', '0-3', '1-2', '1-3', '2-3', '1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
	                                                                                                                          '');
	
	other_dist_6 := other_subscore6 - 0.01444;
	
	other_aacd_7 := map(
	    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 36 => 'C13',
	    36 <= rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 60  => 'C13',
	    60 <= rv_c13_attr_addrs_recency                                     => 'C13',
	                                                                           '');
	
	other_dist_7 := other_subscore7 - 0.128045;
	
	other_aacd_8 := map(
	    NULL < rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 1        => 'A51',
	    1 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 42330      => 'A46',
	    42330 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 63798  => 'A46',
	    63798 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 91770  => 'A46',
	    91770 <= rv_a46_curr_avm_autoval AND rv_a46_curr_avm_autoval < 181600 => 'A46',
	    181600 <= rv_a46_curr_avm_autoval                                     => 'A46',
	                                                                             '');
	
	other_dist_8 := other_subscore8 - 0.11257;
	
	other_aacd_9 := map(
	    ((string)rv_c22_inp_addr_occ_index in [''])                          => '',
	    ((string)rv_c22_inp_addr_occ_index in ['0'])                          => '',
	    ((string)rv_c22_inp_addr_occ_index in ['1'])                          => 'C22',
	    ((string)rv_c22_inp_addr_occ_index in ['3', '4', '5', '6', '7', '8']) => 'C22',
	                                                                     '');
	
	other_dist_9 := other_subscore9 - 0.053524;
	
	other_aacd_10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
	    3 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	other_dist_10 := other_subscore10 - 0.050233;
	
	other_aacd_11 := map(
	    (rv_a41_a42_prop_owner_history in [''])                     => '',
	    (rv_a41_a42_prop_owner_history in ['CURRENT', 'HISTORICAL']) => 'A41',
	    (rv_a41_a42_prop_owner_history in ['NEVER'])                 => 'A41',
	                                                                    '');
	
	other_dist_11 := other_subscore11 - 0.165819;
	
	other_rcvaluec22 := (integer)(other_aacd_0 = 'C22') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C22') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C22') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C22') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C22') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C22') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C22') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C22') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C22') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C22') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C22') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C22') * other_dist_11;
	
	other_rcvaluea46 := (integer)(other_aacd_0 = 'A46') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A46') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A46') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A46') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A46') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A46') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A46') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A46') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A46') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A46') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A46') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A46') * other_dist_11;
	
	other_rcvaluec21 := (integer)(other_aacd_0 = 'C21') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C21') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C21') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C21') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C21') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C21') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C21') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C21') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C21') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C21') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C21') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C21') * other_dist_11;
	
	other_rcvaluei62 := (integer)(other_aacd_0 = 'I62') * other_dist_0 +
	    (integer)(other_aacd_1 = 'I62') * other_dist_1 +
	    (integer)(other_aacd_2 = 'I62') * other_dist_2 +
	    (integer)(other_aacd_3 = 'I62') * other_dist_3 +
	    (integer)(other_aacd_4 = 'I62') * other_dist_4 +
	    (integer)(other_aacd_5 = 'I62') * other_dist_5 +
	    (integer)(other_aacd_6 = 'I62') * other_dist_6 +
	    (integer)(other_aacd_7 = 'I62') * other_dist_7 +
	    (integer)(other_aacd_8 = 'I62') * other_dist_8 +
	    (integer)(other_aacd_9 = 'I62') * other_dist_9 +
	    (integer)(other_aacd_10 = 'I62') * other_dist_10 +
	    (integer)(other_aacd_11 = 'I62') * other_dist_11;
	
	other_rcvalued32 := (integer)(other_aacd_0 = 'D32') * other_dist_0 +
	    (integer)(other_aacd_1 = 'D32') * other_dist_1 +
	    (integer)(other_aacd_2 = 'D32') * other_dist_2 +
	    (integer)(other_aacd_3 = 'D32') * other_dist_3 +
	    (integer)(other_aacd_4 = 'D32') * other_dist_4 +
	    (integer)(other_aacd_5 = 'D32') * other_dist_5 +
	    (integer)(other_aacd_6 = 'D32') * other_dist_6 +
	    (integer)(other_aacd_7 = 'D32') * other_dist_7 +
	    (integer)(other_aacd_8 = 'D32') * other_dist_8 +
	    (integer)(other_aacd_9 = 'D32') * other_dist_9 +
	    (integer)(other_aacd_10 = 'D32') * other_dist_10 +
	    (integer)(other_aacd_11 = 'D32') * other_dist_11;
	
	other_rcvalued33 := (integer)(other_aacd_0 = 'D33') * other_dist_0 +
	    (integer)(other_aacd_1 = 'D33') * other_dist_1 +
	    (integer)(other_aacd_2 = 'D33') * other_dist_2 +
	    (integer)(other_aacd_3 = 'D33') * other_dist_3 +
	    (integer)(other_aacd_4 = 'D33') * other_dist_4 +
	    (integer)(other_aacd_5 = 'D33') * other_dist_5 +
	    (integer)(other_aacd_6 = 'D33') * other_dist_6 +
	    (integer)(other_aacd_7 = 'D33') * other_dist_7 +
	    (integer)(other_aacd_8 = 'D33') * other_dist_8 +
	    (integer)(other_aacd_9 = 'D33') * other_dist_9 +
	    (integer)(other_aacd_10 = 'D33') * other_dist_10 +
	    (integer)(other_aacd_11 = 'D33') * other_dist_11;
	
	other_rcvaluea51 := (integer)(other_aacd_0 = 'A51') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A51') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A51') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A51') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A51') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A51') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A51') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A51') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A51') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A51') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A51') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A51') * other_dist_11;
	
	other_rcvalues66 := (integer)(other_aacd_0 = 'S66') * other_dist_0 +
	    (integer)(other_aacd_1 = 'S66') * other_dist_1 +
	    (integer)(other_aacd_2 = 'S66') * other_dist_2 +
	    (integer)(other_aacd_3 = 'S66') * other_dist_3 +
	    (integer)(other_aacd_4 = 'S66') * other_dist_4 +
	    (integer)(other_aacd_5 = 'S66') * other_dist_5 +
	    (integer)(other_aacd_6 = 'S66') * other_dist_6 +
	    (integer)(other_aacd_7 = 'S66') * other_dist_7 +
	    (integer)(other_aacd_8 = 'S66') * other_dist_8 +
	    (integer)(other_aacd_9 = 'S66') * other_dist_9 +
	    (integer)(other_aacd_10 = 'S66') * other_dist_10 +
	    (integer)(other_aacd_11 = 'S66') * other_dist_11;
	
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
	
	
	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	
	
	 
	//*************************************************************************************//
	rc_dataset_owner := DATASET([
	    {'A46', owner_rcvalueA46},
	    {'I62', owner_rcvalueI62},
	    {'A51', owner_rcvalueA51},
	    {'A50', owner_rcvalueA50},
	    {'F01', owner_rcvalueF01},
	    {'A43', owner_rcvalueA43},
	    {'F03', owner_rcvalueF03},
	    {'C12', owner_rcvalueC12},
	    {'C13', owner_rcvalueC13},
	    {'I60', owner_rcvalueI60},
	    {'C15', owner_rcvalueC15},
	    {'C14', owner_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_owner_sorted := sort(rc_dataset_owner, rc_dataset_owner.value);
	
	owner_rc1 := rc_dataset_owner_sorted[1].rc;
	owner_rc2 := rc_dataset_owner_sorted[2].rc;
	owner_rc3 := rc_dataset_owner_sorted[3].rc;
	owner_rc4 := rc_dataset_owner_sorted[4].rc;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_other := DATASET([
	    {'C22', other_rcvalueC22},
	    {'A46', other_rcvalueA46},
	    {'C21', other_rcvalueC21},
	    {'I62', other_rcvalueI62},
	    {'D32', other_rcvalueD32},
	    {'D33', other_rcvalueD33},
	    {'A51', other_rcvalueA51},
	    {'S66', other_rcvalueS66},
	    {'I60', other_rcvalueI60},
	    {'F03', other_rcvalueF03},
	    {'A41', other_rcvalueA41},
	    {'C13', other_rcvalueC13}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_other_sorted := sort(rc_dataset_other, rc_dataset_other.value);
	
	other_rc1 := rc_dataset_other_sorted[1].rc;
	other_rc2 := rc_dataset_other_sorted[2].rc;
	other_rc3 := rc_dataset_other_sorted[3].rc;
	other_rc4 := rc_dataset_other_sorted[4].rc;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_derog := DATASET([
	    {'C21', derog_rcvalueC21},
	    {'I62', derog_rcvalueI62},
	    {'I60', derog_rcvalueI60},
	    {'D32', derog_rcvalueD32},
	    {'D33', derog_rcvalueD33},
	    {'A50', derog_rcvalueA50},
	    {'A42', derog_rcvalueA42},
	    {'F03', derog_rcvalueF03},
	    {'A41', derog_rcvalueA41},
	    {'C13', derog_rcvalueC13},
	    {'C12', derog_rcvalueC12},
	    {'E57', derog_rcvalueE57},
	    {'S66', derog_rcvalueS66},
	    {'C14', derog_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
	//   implementation of this to the Engineer
	//*************************************************************************************//
	rc_dataset_derog_sorted := sort(rc_dataset_derog, rc_dataset_derog.value);
	
	derog_rc1 := rc_dataset_derog_sorted[1].rc;
	derog_rc2 := rc_dataset_derog_sorted[2].rc;
	derog_rc3 := rc_dataset_derog_sorted[3].rc;
	derog_rc4 := rc_dataset_derog_sorted[4].rc;
	//*************************************************************************************//
	
	
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
	
	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];
	
	addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or 
																rc_hriskaddrflag = '4' or 
																rc_addrcommflag = '2' or 
																add_input_advo_res_or_bus in ['B', 'D'] or 
																not(out_z5 = '') and (rc_hriskaddrflag = '2' or 
																			rc_ziptypeflag = '2') or 
																add_input_advo_vacancy = 'Y',
																1, 0);
	
	phn_validation_problem := if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0);
	
	validation_problem := if(adls_per_ssn >= 5 or 
													 ssns_per_adl >= 4 or 
													 invalid_ssns_per_adl >= 1 or 
													 adls_per_addr_curr >= 8 or 
													 ssns_per_addr_curr >= 7 or 
													 rc_hrisksic = '2225' or 
													 rc_hrisksicphone = '2225' or 
													 (boolean)addr_validation_problem or 
													 (boolean)phn_validation_problem,
													 1, 0);
	
	tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));
	
	tot_liens_w_type := if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct)));
	
	has_derog := if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0);
	
	rv_4seg_riskview_5_0 := map(
	    not(truedid)                                                   				  => '0 TRUEDID = 0     ',
	    not((boolean)sufficiently_verified)                                     => '1 VER/VAL PROBLEMS',
	    (boolean)sufficiently_verified and (boolean)validation_problem				  => '1 VER/VAL PROBLEMS',
	    (boolean)has_derog                                                      => '2 DEROG           ',
	    add_input_naprop = 4 or property_owned_total > 0                        => '3 OWNER           ',
	                                                                               '4 OTHER           ');
	
	custom_segment := map(
	    (string)rv_4seg_riskview_5_0 = '2 DEROG           ' => 'Derog',
	    (string)rv_4seg_riskview_5_0 = '3 OWNER           ' => 'Owner',
																														 'Other');
	
	iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or (integer)(indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',')) > 0 or (integer)(indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',')) > 0;
	
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');
	
	base := 700;
	
	odds := (1 - 0.1151) / 0.1151;
	
	pts := 40;
	
	lnoddsscore := map(
	    custom_segment = 'Derog' => derog_lnoddsscore,
	    custom_segment = 'Owner' => owner_lnoddsscore,
	                                other_lnoddsscore);
	
	rva1603_1_0 := map(
	    iv_rv5_deceased		      => 200,
	    iv_rv5_unscorable = '1' => 222,
	                               min(if(max(round(pts * (lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));
	
	rc1_3 := map(
	    custom_segment = 'Derog' => derog_rc1,
	    custom_segment = 'Owner' => owner_rc1,
	                                other_rc1);
																	
	rc4_3 := map(
	    custom_segment = 'Derog' => derog_rc4,
	    custom_segment = 'Owner' => owner_rc4,
	                                other_rc4);
	
	rc2_2 := map(
	    custom_segment = 'Derog' => derog_rc2,
	    custom_segment = 'Owner' => owner_rc2,
	                                other_rc2);
	
	rc3_2 := map(
	    custom_segment = 'Derog' => derog_rc3,
	    custom_segment = 'Owner' => owner_rc3,
	                                other_rc3);
	
	rc4_2 := other_rc4;
	
	_rc_inq := map(
	    custom_segment = 'Derog' and rv_i60_inq_hiriskcred_recency > 0                  => 'I60',
	    custom_segment = 'Derog' and rv_i60_inq_comm_recency > 0                        => 'I60',
	    custom_segment = 'Derog' and rv_i62_inq_phones_per_adl > 0 											=> 'I62',
	    custom_segment = 'Owner' and rv_i60_inq_hiriskcred_recency > 0                  => 'I60',
	    custom_segment = 'Owner' and rv_i60_inq_auto_count12 > 0                        => 'I60',
	    custom_segment = 'Owner' and rv_i62_inq_phones_per_adl > 0 											=> 'I62',
	    custom_segment = 'Other' and rv_i60_inq_hiriskcred_recency > 0                  => 'I60',
	    custom_segment = 'Other' and rv_i62_inq_phones_per_adl > 0 											=> 'I62',
	                                                                                       '');

	rc3_c122 := map(
	    trim(trim(rc1_3, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => _rc_inq,
	    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
	                                                         '');

	rc2_c122 := map(
	    trim(trim(rc1_3, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => _rc_inq,
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
	                                                         '');
	
	rc5_c122 := map(
	    trim(trim(rc1_3, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
	                                                         _rc_inq);
	
	rc4_c122 := map(
	    trim(trim(rc1_3, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => _rc_inq,
	                                                         '');
	
	rc1_c122 := map(
	    trim(trim(rc1_3, LEFT), LEFT, RIGHT) = ''         => _rc_inq,
	    trim(trim(rc2_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim(rc3_2, LEFT), LEFT, RIGHT) = ''         => '',
	    trim(trim((string)rc4_2, LEFT), LEFT, RIGHT) = '' => '',
	                                                         '');
	
	rc1_2 := if(rc1_c122 != '' and rc1_3 not in ['I60','I62'] and rc2_2 not in ['I60','I62'] and rc3_2 not in ['I60','I62'] and rc4_2 not in ['I60','I62'], rc1_c122, rc1_3);

	rc2_1 := if(rc2_c122 != '' and rc1_3 not in ['I60','I62'] and rc2_2 not in ['I60','I62'] and rc3_2 not in ['I60','I62'] and rc4_2 not in ['I60','I62'], rc2_c122, rc2_2);

	rc3_1 := if(rc3_c122 != '' and rc1_3 not in ['I60','I62'] and rc2_2 not in ['I60','I62'] and rc3_2 not in ['I60','I62'] and rc4_2 not in ['I60','I62'], rc3_c122, rc3_2);

	rc4_1 := if(rc4_c122 != '' and rc1_3 not in ['I60','I62'] and rc2_2 not in ['I60','I62'] and rc3_2 not in ['I60','I62'] and rc4_2 not in ['I60','I62'], rc4_c122, rc4_2);

	rc5_1 := if(rc5_c122 != '' and rc1_3 not in ['I60','I62'] and rc2_2 not in ['I60','I62'] and rc3_2 not in ['I60','I62'] and rc4_2 not in ['I60','I62'], rc5_c122, '');

	rc1_1 := map(trim(rc1_2, LEFT, RIGHT) = '' and custom_segment = 'Derog' => 'D30',
							trim(rc1_2, LEFT, RIGHT) = '' and custom_segment = 'Other'  => 'A41',
																																						 rc1_2);
	
	rc1 := if((rva1603_1_0 in [200, 222]), '', rc1_1);

	rc2 := if((rva1603_1_0 in [200, 222]), '', rc2_1);

	rc3 := if((rva1603_1_0 in [200, 222]), '', rc3_1);

	rc4 := if((rva1603_1_0 in [200, 222]), '', rc4_1);

	rc5 := if((rva1603_1_0 in [200, 222]), '', rc5_1);
	
//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1603_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1603_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1603_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
		SELF.seq := seq;
		SELF.truedid := truedid;
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
		SELF.add_input_lres := add_input_lres;
		SELF.add_input_occ_index := add_input_occ_index;
		SELF.add_input_advo_vacancy := add_input_advo_vacancy;
		SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
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
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.adls_per_ssn := adls_per_ssn;
		SELF.adls_per_addr_curr := adls_per_addr_curr;
		SELF.ssns_per_addr_curr := ssns_per_addr_curr;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.inq_auto_count12 := inq_auto_count12;
		SELF.inq_communications_count := inq_communications_count;
		SELF.inq_communications_count01 := inq_communications_count01;
		SELF.inq_communications_count03 := inq_communications_count03;
		SELF.inq_communications_count06 := inq_communications_count06;
		SELF.inq_communications_count12 := inq_communications_count12;
		SELF.inq_communications_count24 := inq_communications_count24;
		SELF.inq_highriskcredit_count := inq_highriskcredit_count;
		SELF.inq_highriskcredit_count01 := inq_highriskcredit_count01;
		SELF.inq_highriskcredit_count03 := inq_highriskcredit_count03;
		SELF.inq_highriskcredit_count06 := inq_highriskcredit_count06;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
		SELF.inq_phonesperadl := inq_phonesperadl;
		SELF.pb_total_orders := pb_total_orders;
		SELF.br_source_count := br_source_count;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count := stl_inq_count;
		SELF.stl_inq_count24 := stl_inq_count24;
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
		SELF.felony_count := felony_count;
		SELF.watercraft_count := watercraft_count;
		SELF.prof_license_flag := prof_license_flag;
		SELF.input_dob_match_level := input_dob_match_level;
		
		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.iv_rv5_unscorable_1 := iv_rv5_unscorable_1;
		SELF.rv_d32_criminal_count := rv_d32_criminal_count;
		SELF.rv_c21_stl_inq_count := rv_c21_stl_inq_count;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_c12_source_profile_index := rv_c12_source_profile_index;
		SELF.rv_s66_adlperssn_count := rv_s66_adlperssn_count;
		SELF.rv_f03_address_match := rv_f03_address_match;
		SELF.rv_c14_addrs_10yr := rv_c14_addrs_10yr;
		SELF.rv_a41_a42_prop_owner_history := rv_a41_a42_prop_owner_history;
		SELF.rv_e57_prof_license_br_flag := rv_e57_prof_license_br_flag;
		SELF.rv_i60_inq_hiriskcred_recency := rv_i60_inq_hiriskcred_recency;
		SELF.rv_i60_inq_comm_recency := rv_i60_inq_comm_recency;
		SELF.rv_a50_pb_total_orders := rv_a50_pb_total_orders;
		SELF.rv_c13_inp_addr_lres := rv_c13_inp_addr_lres;
		SELF.rv_i62_inq_phones_per_adl := rv_i62_inq_phones_per_adl;
		SELF.rv_d32_criminal_x_felony := rv_d32_criminal_x_felony;
		SELF.rv_a46_curr_avm_autoval := rv_a46_curr_avm_autoval;
		SELF.rv_c22_inp_addr_occ_index := rv_c22_inp_addr_occ_index;
		SELF.rv_c13_attr_addrs_recency := rv_c13_attr_addrs_recency;
		SELF.rv_f01_inp_addr_address_score := rv_f01_inp_addr_address_score;
		SELF.rv_c12_num_nonderogs := rv_c12_num_nonderogs;
		SELF.rv_c15_ssns_per_adl := rv_c15_ssns_per_adl;
		SELF.rv_c14_addrs_5yr := rv_c14_addrs_5yr;
		SELF.rv_a43_rec_vehx_level := rv_a43_rec_vehx_level;
		SELF.rv_i60_inq_auto_count12 := rv_i60_inq_auto_count12;
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
		SELF.derog_aacd_12 := derog_aacd_12;
		SELF.derog_dist_12 := derog_dist_12;
		SELF.derog_aacd_13 := derog_aacd_13;
		SELF.derog_dist_13 := derog_dist_13;
		SELF.derog_rcvaluec21 := derog_rcvaluec21;
		SELF.derog_rcvaluei62 := derog_rcvaluei62;
		SELF.derog_rcvaluei60 := derog_rcvaluei60;
		SELF.derog_rcvalued32 := derog_rcvalued32;
		SELF.derog_rcvalued33 := derog_rcvalued33;
		SELF.derog_rcvaluea50 := derog_rcvaluea50;
		SELF.derog_rcvaluea42 := derog_rcvaluea42;
		SELF.derog_rcvaluef03 := derog_rcvaluef03;
		SELF.derog_rcvaluea41 := derog_rcvaluea41;
		SELF.derog_rcvaluec13 := derog_rcvaluec13;
		SELF.derog_rcvaluec12 := derog_rcvaluec12;
		SELF.derog_rcvaluee57 := derog_rcvaluee57;
		SELF.derog_rcvalues66 := derog_rcvalues66;
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
		SELF.owner_rawscore := owner_rawscore;
		SELF.owner_lnoddsscore := owner_lnoddsscore;
		SELF.owner_probscore := owner_probscore;
		SELF.owner_aacd_0 := owner_aacd_0;
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
		SELF.owner_rcvaluea46 := owner_rcvaluea46;
		SELF.owner_rcvaluei62 := owner_rcvaluei62;
		SELF.owner_rcvaluea51 := owner_rcvaluea51;
		SELF.owner_rcvaluea50 := owner_rcvaluea50;
		SELF.owner_rcvaluef01 := owner_rcvaluef01;
		SELF.owner_rcvaluea43 := owner_rcvaluea43;
		SELF.owner_rcvaluef03 := owner_rcvaluef03;
		SELF.owner_rcvaluec12 := owner_rcvaluec12;
		SELF.owner_rcvaluec13 := owner_rcvaluec13;
		SELF.owner_rcvaluei60 := owner_rcvaluei60;
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
		SELF.other_aacd_11 := other_aacd_11;
		SELF.other_dist_11 := other_dist_11;
		SELF.other_rcvaluec22 := other_rcvaluec22;
		SELF.other_rcvaluea46 := other_rcvaluea46;
		SELF.other_rcvaluec21 := other_rcvaluec21;
		SELF.other_rcvaluei62 := other_rcvaluei62;
		SELF.other_rcvalued32 := other_rcvalued32;
		SELF.other_rcvalued33 := other_rcvalued33;
		SELF.other_rcvaluea51 := other_rcvaluea51;
		SELF.other_rcvalues66 := other_rcvalues66;
		SELF.other_rcvaluei60 := other_rcvaluei60;
		SELF.other_rcvaluef03 := other_rcvaluef03;
		SELF.other_rcvaluea41 := other_rcvaluea41;
		SELF.other_rcvaluec13 := other_rcvaluec13;
		SELF.owner_rc1 := owner_rc1;
		SELF.owner_rc2 := owner_rc2;
		SELF.owner_rc3 := owner_rc3;
		SELF.owner_rc4 := owner_rc4;
		SELF.other_rc1 := other_rc1;
		SELF.other_rc2 := other_rc2;
		SELF.other_rc3 := other_rc3;
		SELF.other_rc4 := other_rc4;
		SELF.derog_rc1 := derog_rc1;
		SELF.derog_rc2 := derog_rc2;
		SELF.derog_rc3 := derog_rc3;
		SELF.derog_rc4 := derog_rc4;
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
		SELF.custom_segment := custom_segment;
		SELF.iv_rv5_deceased := iv_rv5_deceased;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.base := base;
		SELF.odds := odds;
		SELF.pts := pts;
		SELF.lnoddsscore := lnoddsscore;
		SELF.rva1603_1_0 := rva1603_1_0;
		SELF._rc_inq := _rc_inq;
		SELF.rc1_3 := rc1_3;
		SELF.rc1_2 := rc1_2;
		SELF.rc1_1 := rc1_1;
		SELF.rc1_c122 := rc1_c122;
		SELF.rc4_3 := rc4_3;
		SELF.rc2_2 := rc2_2;
		SELF.rc3_2 := rc3_2;
		SELF.rc4_2 := rc4_2;
		SELF.rc2_c122 := rc2_c122;
		SELF.rc3_c122 := rc3_c122;
		SELF.rc4_c122 := rc4_c122;
		SELF.rc5_c122 := rc5_c122;
		SELF.rc2_1 := rc2_1;
		SELF.rc3_1 := rc3_1;
		SELF.rc4_1 := rc4_1;
		SELF.rc5_1 := rc5_1;
		SELF.rc1 := rc1;
		SELF.rc2 := rc2;
		SELF.rc3 := rc3;
		SELF.rc4 := rc4;
		SELF.rc5 := rc5;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rva1603_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
