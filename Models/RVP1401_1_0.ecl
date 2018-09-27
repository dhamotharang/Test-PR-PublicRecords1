//DM Services 4359	- ADL FCRA 4.1 Modeling Shell   

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview ;

export RVP1401_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

  RVP_DEBUG := 	FALSE;

  #if(RVP_DEBUG)
    layout_debug := record
		 integer sysdate                         ;
		 boolean derog_flag                      ;
		 string rv_derog_segment                ;
		 boolean iv_add_apt                      ;
		 string iv_db001_bankruptcy             ;
		 boolean email_src_im                    ;
		 integer iv_ds001_impulse_count          ;
		 integer iv_ms001_ssns_per_adl           ;
		 integer iv_pv001_bst_avm_autoval        ;
		 string iv_ed001_college_ind            ;
		 integer prop_adl_p_count_pos            ;
		 integer prop_adl_count_p                ;
		 integer _src_prop_adl_count             ;
		 integer iv_src_property_adl_count       ;
		 string iv_bst_own_prop_x_addr_naprop   ;
		 integer iv_prv_addr_avm_auto_val        ;
		 integer iv_gong_did_phone_ct            ;
		 integer iv_max_ids_per_sfd_addr         ;
		 boolean ver_phn_inf                     ;
		 boolean ver_phn_nap                     ;
		 integer inf_phn_ver_lvl                 ;
		 integer nap_phn_ver_lvl                 ;
		 string iv_nap_phn_ver_x_inf_phn_ver    ;
		 integer iv_liens_unrel_cj_ct            ;
		 integer iv_liens_unrel_sc_ct            ;
		 integer iv_prof_license_flag            ;
		 integer sum_dols                        ;
		 real pct_offline_dols                ;
		 real pct_retail_dols                 ;
		 real pct_online_dols                 ;
		 string iv_pb_profile                   ;
		 integer bureau_adl_vo_fseen_pos         ;
		 string bureau_adl_fseen_vo             ;
		 integer _bureau_adl_fseen_vo            ;
		 integer _src_bureau_adl_fseen           ;
		 integer mth_ver_src_fdate_vo            ;
		 integer bureau_adl_vo_lseen_pos         ;
		 string bureau_adl_lseen_vo             ;
		 integer _bureau_adl_lseen_vo            ;
		 integer mth_ver_src_ldate_vo            ;
		 boolean mth_ver_src_fdate_vo60          ;
		 boolean mth_ver_src_ldate_vo0           ;
		 integer bureau_adl_w_lseen_pos          ;
		 string bureau_adl_lseen_w              ;
		 integer _bureau_adl_lseen_w             ;
		 integer mth_ver_src_ldate_w             ;
		 boolean mth_ver_src_ldate_w0            ;
		 integer bureau_adl_wp_lseen_pos         ;
		 string bureau_adl_lseen_wp             ;
		 integer _bureau_adl_lseen_wp            ;
		 integer _src_bureau_adl_lseen           ;
		 integer mth_ver_src_ldate_wp            ;
		 boolean mth_ver_src_ldate_wp0           ;
		 integer _paw_first_seen                 ;
		 integer mth_paw_first_seen              ;
		 integer mth_paw_first_seen2             ;
		 boolean ver_src_am                      ;
		 boolean ver_src_e1                      ;
		 boolean ver_src_e2                      ;
		 boolean ver_src_e3                      ;
		 boolean ver_src_pl                      ;
		 boolean ver_src_w                       ;
		 boolean paw_dead_business_count_gt3     ;
		 boolean paw_active_phone_count_0        ;
		 integer _infutor_first_seen             ;
		 integer mth_infutor_first_seen          ;
		 integer _infutor_last_seen              ;
		 integer mth_infutor_last_seen           ;
		 integer infutor_i                       ;
		 real infutor_im                      ;
		 integer white_pages_adl_wp_fseen_pos    ;
		 string white_pages_adl_fseen_wp        ;
		 integer _white_pages_adl_fseen_wp       ;
		 integer _src_white_pages_adl_fseen      ;
		 integer iv_sr001_m_wp_adl_fs            ;
		 integer src_m_wp_adl_fs                 ;
		 integer _header_first_seen              ;
		 integer iv_sr001_m_hdr_fs               ;
		 integer src_m_hdr_fs                    ;
		 real source_mod6                     ;
		 real iv_sr001_source_profile         ;
		 integer iv_sr001_source_profile_index   ;
		 integer iv_pl002_addrs_15yr             ;
		 string iv_inp_own_prop_x_addr_naprop   ;
		 string mortgage_type                   ;
		 boolean mortgage_present                ;
		 string iv_bst_addr_mortgage_type       ;
		 real iv_avg_prop_assess_purch_amt    ;
		 integer iv_max_lres                     ;
		 integer _gong_did_first_seen            ;
		 integer iv_mos_since_gong_did_fst_seen  ;
		 integer iv_inq_auto_count12             ;
		 integer iv_inq_highriskcredit_count12   ;
		 integer iv_inq_communications_count12   ;
		 string iv_prof_license_category        ;
		 string iv_pb_order_freq                ;
		 real rsp0_subscore0                  ;
		 real rsp0_subscore1                  ;
		 real rsp0_subscore2                  ;
		 real rsp0_subscore3                  ;
		 real rsp0_subscore4                  ;
		 real rsp0_subscore5                  ;
		 real rsp0_subscore6                  ;
		 real rsp0_subscore7                  ;
		 real rsp0_subscore8                  ;
		 real rsp0_subscore9                  ;
		 real rsp0_subscore10                 ;
		 real rsp0_subscore11                 ;
		 real rsp0_subscore12                 ;
		 real rsp0_subscore13                 ;
		 real rsp0_subscore14                 ;
		 real rsp0_rawscore                   ;
		 real rsp0_lnoddsscore                ;
		 real rsp0_probscore                  ;
		 real rsp1_subscore0                  ;
		 real rsp1_subscore1                  ;
		 real rsp1_subscore2                  ;
		 real rsp1_subscore3                  ;
		 real rsp1_subscore4                  ;
		 real rsp1_subscore5                  ;
		 real rsp1_subscore6                  ;
		 real rsp1_subscore7                  ;
		 real rsp1_subscore8                  ;
		 real rsp1_subscore9                  ;
		 real rsp1_subscore10                 ;
		 real rsp1_subscore11                 ;
		 real rsp1_subscore12                 ;
		 real rsp1_subscore13                 ;
		 real rsp1_subscore14                 ;
		 real rsp1_subscore15                 ;
		 real rsp1_subscore16                 ;
		 real rsp1_subscore17                 ;
		 real rsp1_subscore18                 ;
		 real rsp1_subscore19                 ;
		 real rsp1_subscore20                 ;
		 real rsp1_subscore21                 ;
		 real rsp1_rawscore                   ;
		 real rsp1_lnoddsscore                ;
		 real rsp1_probscore                  ;
		 boolean ssn_deceased                    ;
		 boolean rv_20_content                   ;
		 boolean eda_sourced                     ;
		 boolean eq_only                         ;
		 boolean rv_prescreen_content            ;
		 real probscore                       ;
		 integer base                            ;
		 integer pts                             ;
		 real odds                            ;
		 integer rvp1401_1_0                     ;
		 models.layout_modelout;
		 risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end	
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
	add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	max_lres                         := le.other_address_info.max_lres;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_communications_count12       := le.acc_logs.communications.count12;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	prof_license_flag                := le.professional_license.professional_license_flag;
	prof_license_category            := le.professional_license.plcategory;
	input_dob_match_level            := le.dobmatchlevel;

	NULL := -999999999;


	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	derog_flag := (rc_bansflag in ['1', '2']) or 
		bankrupt or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',')  or 
		filing_count > 0 or 
		bk_recent_count > 0 or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',')  OR
		liens_recent_unreleased_count > 0 or 
		liens_historical_unreleased_ct > 0 or 
		attr_total_number_derogs > 0 or 
		attr_eviction_count > 0 or
		criminal_count > 0 or 
		felony_count > 0 or 
		impulse_count > 0;

	rv_derog_segment := if(derog_flag, '0 Derog   ', '1 NonDerog');

	iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '');

	iv_db001_bankruptcy := map(
			not(truedid or (integer) ssnlength > 0)                                                                                               => '                 ',
			(disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
			(disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
			(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
																																																																		 '0 - No BK        ');

	email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

	iv_ds001_impulse_count := map(
			not(truedid)                           => NULL,
			impulse_count = 0 and email_src_im 		 => 1,
																								impulse_count);

	iv_ms001_ssns_per_adl := map(
			not(truedid)     => NULL,
			ssns_per_adl = 0 => 1,
													ssns_per_adl);

	iv_pv001_bst_avm_autoval := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add1_avm_automated_valuation,
													add2_avm_automated_valuation);

	iv_ed001_college_ind := map(
			not(truedid)                                                       => ' ',
			not(ams_college_code = '') or not(ams_college_type = '') or
			(integer)ams_college_tier > 0 or 
			not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
			ams_file_type = 'M'                                               => '0',
			not(ams_class = '') or not(ams_income_level_code = '')            => '1',
																																				'0');

	prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

	prop_adl_count_p := if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ','));

	_src_prop_adl_count := max(prop_adl_count_p, (real)0);

	iv_src_property_adl_count := map(
			not(truedid)               => NULL,
			_src_prop_adl_count = NULL => -1,
																		_src_prop_adl_count);

	iv_bst_own_prop_x_addr_naprop_c11 := if(property_owned_total > 0, (string) (add1_naprop + 10), ('0'+(string) add1_naprop)[-2..]); //('0'+(string) add1_naprop)[-2..]);

	iv_bst_own_prop_x_addr_naprop_c12 := if(property_owned_total > 0, (string) (add2_naprop + 10), ('0'+(string) add2_naprop)[-2..]); //('0'+(string) add1_naprop)[-2..]);
	
	iv_bst_own_prop_x_addr_naprop := map(
			not(truedid)     => ' ',
			add1_isbestmatch =>  iv_bst_own_prop_x_addr_naprop_c11,
													 iv_bst_own_prop_x_addr_naprop_c12);

	iv_prv_addr_avm_auto_val := map(
			not(truedid)     => NULL,
			add1_isbestmatch => add2_avm_automated_valuation,
													add3_avm_automated_valuation);

	iv_gong_did_phone_ct := if(not(truedid), NULL, gong_did_phone_ct);

	iv_max_ids_per_sfd_addr := map(
			not(add1_pop)    => NULL,
			iv_add_apt 			 => -1,
													max(adls_per_addr, ssns_per_addr));

	ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

	ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

	inf_phn_ver_lvl := map(
			ver_phn_inf     => 3,
			infutor_nap = 1 => 1,
			infutor_nap = 0 => 0,
												 2);

	nap_phn_ver_lvl := map(
			ver_phn_nap     => 3,
			nap_summary = 1 => 1,
			nap_summary = 0 => 0,
												 2);

	iv_nap_phn_ver_x_inf_phn_ver := map(
			not(addrpop or hphnpop) => '   ',
			not(hphnpop)            => ' -1',
																 trim((string) nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) inf_phn_ver_lvl, LEFT, RIGHT));

	iv_liens_unrel_cj_ct := if(not(truedid), NULL, liens_unrel_CJ_ct);

	iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

	iv_prof_license_flag := if(not(truedid), NULL, (integer) prof_license_flag);

//set '' to NULL and leave values that are 0 to still be 0
	pb_offline_dollars_tmp := if(pb_offline_dollars = '', NULL, (real) pb_offline_dollars);
	pb_online_dollars_tmp := if(pb_online_dollars = '', NULL, (real) pb_online_dollars);
	pb_retail_dollars_tmp := if(pb_retail_dollars = '', NULL, (real) pb_retail_dollars);

	sum_dols := (integer) if(max(pb_offline_dollars_tmp, pb_online_dollars_tmp, pb_retail_dollars_tmp) = NULL, 
				NULL, 
				sum(if(pb_offline_dollars_tmp = NULL, 0, pb_offline_dollars_tmp), 
						if(pb_online_dollars_tmp = NULL, 0, pb_online_dollars_tmp), 
						if(pb_retail_dollars_tmp = NULL, 0, pb_retail_dollars_tmp)
				));
				
	pct_offline_dols := if(sum_dols > 0, (real) pb_offline_dollars_tmp / sum_dols, -1);

	pct_retail_dols := if(sum_dols > 0, (real) pb_retail_dollars_tmp / sum_dols, -1);

	pct_online_dols := if(sum_dols > 0, (real) pb_online_dollars_tmp / sum_dols, -1);
	
	iv_pb_profile := map(
			not(truedid)                => '                 ',
			//(integer) pb_number_of_sources = NULL  => '0 No Purch Data  ',
			pb_number_of_sources = ''  => '0 No Purch Data  ',
			//(REAL) pct_offline_dols = -1.0 and (REAL) pct_online_dols = -1.0 and (REAL) pct_retail_dols = -1.0 => '0 No Purch Data  ',
			pct_offline_dols > .50      => '1 Offline Shopper',
			pct_online_dols > .50       => '2 Online Shopper ',
			pct_retail_dols > .50       => '3 Retail Shopper ',
																		 '4 Other');

	_header_first_seen_1 := common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs_1 := map(
			not(truedid)                     => NULL,
			not(_header_first_seen_1 = NULL) => if ((sysdate - _header_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_1) / (365.25 / 12)), roundup((sysdate - _header_first_seen_1) / (365.25 / 12))),
																					-1);

	bureau_adl_vo_fseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_fseen_vo := if(bureau_adl_vo_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_vo_fseen_pos, ','));

	_bureau_adl_fseen_vo := common.sas_date((string)(bureau_adl_fseen_vo));

	_src_bureau_adl_fseen := _bureau_adl_fseen_vo;

	mth_ver_src_fdate_vo := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_fseen = NULL => -1,
																			if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))));

	bureau_adl_vo_lseen_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

	bureau_adl_lseen_vo := if(bureau_adl_vo_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_vo_lseen_pos, ','));

	_bureau_adl_lseen_vo := common.sas_date((string)(bureau_adl_lseen_vo));

	_src_bureau_adl_lseen_2 := _bureau_adl_lseen_vo;

	mth_ver_src_ldate_vo := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_2 = NULL => -1,
																				if ((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_2) / (365.25 / 12))));

	mth_ver_src_fdate_vo60 := mth_ver_src_fdate_vo > 60;

	mth_ver_src_ldate_vo0 := mth_ver_src_ldate_vo = 0;

	bureau_adl_w_lseen_pos := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E');

	bureau_adl_lseen_w := if(bureau_adl_w_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_w_lseen_pos, ','));

	_bureau_adl_lseen_w := common.sas_date((string)(bureau_adl_lseen_w));

	_src_bureau_adl_lseen_1 := _bureau_adl_lseen_w;

	mth_ver_src_ldate_w := map(
			not(truedid)                   => NULL,
			_src_bureau_adl_lseen_1 = NULL => -1,
																				if ((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen_1) / (365.25 / 12))));

	mth_ver_src_ldate_w0 := mth_ver_src_ldate_w = 0;

	bureau_adl_wp_lseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

	bureau_adl_lseen_wp := if(bureau_adl_wp_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, bureau_adl_wp_lseen_pos, ','));

	_bureau_adl_lseen_wp := common.sas_date((string)(bureau_adl_lseen_wp));

	_src_bureau_adl_lseen := _bureau_adl_lseen_wp;

	mth_ver_src_ldate_wp := map(
			not(truedid)                 => NULL,
			_src_bureau_adl_lseen = NULL => -1,
																			if ((sysdate - _src_bureau_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_lseen) / (365.25 / 12))));

	mth_ver_src_ldate_wp0 := mth_ver_src_ldate_wp = 0;

	_paw_first_seen := common.sas_date((string)(PAW_first_seen));

	mth_paw_first_seen := map(
			not(truedid)           => NULL,
			_paw_first_seen = NULL => -1,
																if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))));

	mth_paw_first_seen2 := if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen)));

	ver_src_am := Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0;

	ver_src_e1 := Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0;

	ver_src_e2 := Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0;

	ver_src_e3 := Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0;

	ver_src_pl := Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0;

	ver_src_w := Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0;

	paw_dead_business_count_gt3 := paw_dead_business_count > 3;

	paw_active_phone_count_0 := paw_active_phone_count <= 0;

	_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

	mth_infutor_first_seen := map(
			not(truedid)               => NULL,
			_infutor_first_seen = NULL => NULL,
																		if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))));

	_infutor_last_seen := common.sas_date((string)(infutor_last_seen));

	mth_infutor_last_seen := map(
			not(truedid)              => NULL,
			_infutor_last_seen = NULL => NULL,
																	 if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12))));

	infutor_i := map(
			infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
			infutor_nap = 12                                                                 => 4,
			infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
			infutor_nap = 11                                                                 => 5,
			infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
			infutor_nap >= 7                                                                 => 7,
			(infutor_nap in [1, 6])                                                          => 8,
			(infutor_nap in [0])                                                             => 2,
																																													7);

	infutor_im := map(
			infutor_i = 1 => 7.77,
			infutor_i = 2 => 8.06,
			infutor_i = 3 => 8.38,
			infutor_i = 4 => 8.96,
			infutor_i = 5 => 9.35,
			infutor_i = 6 => 10.19,
			infutor_i = 7 => 13.13,
			infutor_i = 8 => 14.77,
											 9.03);

	white_pages_adl_wp_fseen_pos := Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E');

	white_pages_adl_fseen_wp := if(white_pages_adl_wp_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, white_pages_adl_wp_fseen_pos, ','));

	_white_pages_adl_fseen_wp := common.sas_date((string)(white_pages_adl_fseen_wp));

	_src_white_pages_adl_fseen := _white_pages_adl_fseen_wp;

	iv_sr001_m_wp_adl_fs := map(
			not(truedid)                      => NULL,
			_src_white_pages_adl_fseen = NULL => -1,
																					 if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12))));

	src_m_wp_adl_fs := map(
			iv_sr001_m_wp_adl_fs = NULL => -1,
			iv_sr001_m_wp_adl_fs = -1   => 10,
			iv_sr001_m_wp_adl_fs >= 24  => 24,
																		 iv_sr001_m_wp_adl_fs);

	_header_first_seen := common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs := map(
			not(truedid)                   => NULL,
			not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
																				-1);

	src_m_hdr_fs := map(
			iv_sr001_m_hdr_fs = NULL => 15,
			iv_sr001_m_hdr_fs = -1   => 40,
			iv_sr001_m_hdr_fs >= 260 => 260,
																	iv_sr001_m_hdr_fs);

	source_mod6_1 := -2.350792319 +
			(integer)ver_src_am * -0.611853123 +
			(integer)ver_src_e1 * -0.208450798 +
			(integer)ver_src_e2 * -0.23159296 +
			(integer)ver_src_e3 * -0.415443106 +
			(integer)ver_src_pl * -0.275168358 +
			(integer)mth_ver_src_fdate_vo60 * -0.119660071 +
			(integer)mth_ver_src_ldate_vo0 * -0.322346162 +
			(integer)ver_src_w * -0.232332713 +
			(integer)mth_ver_src_ldate_w0 * -0.371580672 +
			(integer)mth_ver_src_ldate_wp0 * -0.149556634 +
			mth_paw_first_seen2 * -0.002615342 +
			(integer)paw_dead_business_count_gt3 * 1.3423068152 +
			(integer)paw_active_phone_count_0 * 0.3754685927 +
			infutor_im * 0.061827139 +
			src_m_wp_adl_fs * -0.006650973 +
			src_m_hdr_fs * -0.004903484;

	source_mod6 := exp(source_mod6_1) / (1 + exp(source_mod6_1));

	source_temp := round(500 * source_mod6/0.1) * 0.1;
	iv_sr001_source_profile := if(not(truedid), NULL, max((real)0, round((100 - source_temp) * 10) / 10));

	iv_sr001_source_profile_index := map(
			not(truedid)                  => -1,
			iv_sr001_source_profile <= 9  => 0,
			iv_sr001_source_profile <= 18 => 1,
			iv_sr001_source_profile <= 23 => 2,
			iv_sr001_source_profile <= 35 => 3,
			iv_sr001_source_profile <= 60 => 4,
			iv_sr001_source_profile <= 72 => 5,
			iv_sr001_source_profile <= 79 => 6,
			iv_sr001_source_profile <= 82 => 7,
			iv_sr001_source_profile <= 86 => 8,
																			 9);

	iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

	iv_inp_own_prop_x_addr_naprop := map(
			not(add1_pop)            => '  ',
			property_owned_total > 0 => (string) (add1_naprop + 10),
																	('0'+(string)add1_naprop)[-2..]);

	mortgage_type := if(add1_isbestmatch, add1_mortgage_type, add2_mortgage_type);

	mortgage_present := if(add1_isbestmatch, not((add1_mortgage_date in [0])), not((add2_mortgage_date in [0])));

	iv_bst_addr_mortgage_type := map(
			not(truedid)                                          => '               ',
			(mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
			(mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
			(mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
			(mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
			(mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
			(mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
			(mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
			(mortgage_type in ['U'])                              => 'Unknown        ',
			not(mortgage_type = '')                             => 'Other          ',
			mortgage_present                                      => 'Unknown        ',
																															 'No Mortgage');

	iv_avg_prop_assess_purch_amt := map(
			not(truedid or add1_pop)          => NULL,
			property_owned_assessed_count > 0 => property_owned_assessed_total / property_owned_assessed_count,
																					 -1);

	iv_max_lres := if(not(truedid), NULL, max_lres);

	_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

	iv_mos_since_gong_did_fst_seen := map(
			not(truedid)                     => NULL,
			not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
																					-1);

	iv_inq_auto_count12 := if(not(truedid), NULL, inq_auto_count12);

	iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

	iv_inq_communications_count12 := if(not(truedid), NULL, inq_communications_count12);

	iv_prof_license_category := map(
			not(truedid)                 => '  ',
			prof_license_category = '' => '-1',
																			prof_license_category);

	iv_pb_order_freq := map(
			not(truedid)                     => '                ',
			pb_number_of_sources = ''        => '0 No Purch Data ',
			(integer) pb_average_days_bt_orders = NULL OR (integer) pb_average_days_bt_orders < 0 OR TRIM((STRING) pb_average_days_bt_orders) = ''=> '1 Cant Calculate',
			(integer) pb_average_days_bt_orders <= 7   => '2 Weekly        ',
			(integer) pb_average_days_bt_orders <= 30  => '3 Monthly       ',
			(integer) pb_average_days_bt_orders <= 60  => '4 Semi-monthly  ',
			(integer) pb_average_days_bt_orders <= 90  => '5 Quarterly     ',
			(integer) pb_average_days_bt_orders <= 180 => '6 Semi-yearly   ',
			(integer) pb_average_days_bt_orders <= 365 => '7 Yearly        ',
																					'8 Rarely        ');

	rsp0_subscore0 := map(
			NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.374641,
			1 <= iv_src_property_adl_count AND iv_src_property_adl_count < 2   => -0.112847,
			2 <= iv_src_property_adl_count                                     => 0.231300,
																																						-0.000000);

	rsp0_subscore1 := map(
			(iv_pb_profile in [' '])                 => 0.000000,
			(iv_pb_profile in ['0 No Purch Data'])   => -0.011161,
			(iv_pb_profile in ['1 Offline Shopper']) => -0.157680,
			(iv_pb_profile in ['2 Online Shopper'])  => 0.251921,
			(iv_pb_profile in ['3 Retail Shopper'])  => 0.396983,
			(iv_pb_profile in ['4 Other'])           => 0.342132,
																									0.000000);

	rsp0_subscore2 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => -0.060474,
			1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 52000       => -0.311812,
			52000 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 85816   => -0.223712,
			85816 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 138898  => 0.214942,
			138898 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 208017 => 0.355413,
			208017 <= iv_pv001_bst_avm_autoval                                       => 0.361045,
																																									0.000000);

	rsp0_subscore3 := map(
			(iv_bst_own_prop_x_addr_naprop in [' '])              => -0.000000,
			(iv_bst_own_prop_x_addr_naprop in ['00'])             => -0.271169,
			(iv_bst_own_prop_x_addr_naprop in ['01'])             => -0.066684,
			(iv_bst_own_prop_x_addr_naprop in ['02', '03', '10']) => 0.005256,
			(iv_bst_own_prop_x_addr_naprop in ['11', '12', '13']) => 0.153339,
			(iv_bst_own_prop_x_addr_naprop in ['04', '14'])       => 0.175578,
																															 -0.000000);

	rsp0_subscore4 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.103754,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.055983,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 4   => -0.296044,
			4 <= iv_ms001_ssns_per_adl                                 => -0.499371,
																																		-0.000000);

	rsp0_subscore5 := map(
			NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 0 => 0.123616,
			0 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 6   => 0.210763,
			6 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 10  => 0.010587,
			10 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 17 => -0.047924,
			17 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 23 => -0.166205,
			23 <= iv_max_ids_per_sfd_addr                                  => -0.274086,
																																				0.000000);

	rsp0_subscore6 := map(
			NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.037761,
			1 <= iv_ds001_impulse_count                                  => -0.690225,
																																			0.000000);

	rsp0_subscore7 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in [' '])                                      => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '1-3', '2-1', '3-1']) => -0.154817,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-3', '2-0', '2-3', '3-3'])        => -0.032571,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.280636,
																																											0.000000);

	rsp0_subscore8 := map(
			NULL < iv_liens_unrel_cj_ct AND iv_liens_unrel_cj_ct < 1 => 0.090277,
			1 <= iv_liens_unrel_cj_ct AND iv_liens_unrel_cj_ct < 2   => -0.133681,
			2 <= iv_liens_unrel_cj_ct                                => -0.316818,
																																	-0.000000);

	rsp0_subscore9 := map(
			NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 2 => 0.072147,
			2 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 3   => -0.038392,
			3 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 4   => -0.173581,
			4 <= iv_gong_did_phone_ct                                => -0.475198,
																																	-0.000000);

	rsp0_subscore10 := map(
			(iv_db001_bankruptcy in [' '])                 => 0.000000,
			(iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.395177,
			(iv_db001_bankruptcy in ['0 - No BK'])         => -0.079361,
			(iv_db001_bankruptcy in ['3 - BK Other'])      => 0.100994,
			(iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.181762,
																												0.000000);

	rsp0_subscore11 := map(
			NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.052992,
			1 <= iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 2   => -0.251028,
			2 <= iv_liens_unrel_sc_ct                                => -0.517730,
																																	-0.000000);

	rsp0_subscore12 := map(
			(iv_ed001_college_ind in [' ']) => 0.000000,
			(iv_ed001_college_ind in ['0']) => -0.033774,
			(iv_ed001_college_ind in ['1']) => 0.521945,
																				 0.000000);

	rsp0_subscore13 := map(
			NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1        => -0.012776,
			1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 93000      => -0.139566,
			93000 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 194339 => 0.015007,
			194339 <= iv_prv_addr_avm_auto_val                                      => 0.340186,
																																								 0.000000);

	rsp0_subscore14 := map(
			((string) iv_prof_license_flag in [' ']) => 0.000000,
			((string) iv_prof_license_flag in ['0']) => -0.031013,
			((string) iv_prof_license_flag in ['1']) => 0.304354,
																				 0.000000);

	rsp0_rawscore := rsp0_subscore0 +
			rsp0_subscore1 +
			rsp0_subscore2 +
			rsp0_subscore3 +
			rsp0_subscore4 +
			rsp0_subscore5 +
			rsp0_subscore6 +
			rsp0_subscore7 +
			rsp0_subscore8 +
			rsp0_subscore9 +
			rsp0_subscore10 +
			rsp0_subscore11 +
			rsp0_subscore12 +
			rsp0_subscore13 +
			rsp0_subscore14;

	rsp0_lnoddsscore := rsp0_rawscore + 4.427087;

	rsp0_probscore := exp(rsp0_lnoddsscore) / (1 + exp(rsp0_lnoddsscore));

	rsp1_subscore0 := map(
			(iv_pb_profile in [' '])                 => -0.000000,
			(iv_pb_profile in ['0 No Purch Data'])   => -0.020738,
			(iv_pb_profile in ['1 Offline Shopper']) => -0.169089,
			(iv_pb_profile in ['2 Online Shopper'])  => 0.367802,
			(iv_pb_profile in ['3 Retail Shopper'])  => 0.464972,
			(iv_pb_profile in ['4 Other'])           => 0.689615,
																									-0.000000);

	rsp1_subscore1 := map(
			NULL < iv_src_property_adl_count AND iv_src_property_adl_count < 1 => -0.256619,
			1 <= iv_src_property_adl_count                                     => 0.223955,
																																						-0.000000);

	rsp1_subscore2 := map(
			NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 1   => 0.000000,
			1 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 127   => 0.623908,
			127 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 156 => 0.568066,
			156 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 200 => 0.238743,
			200 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 235 => 0.023450,
			235 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 289 => -0.147880,
			289 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 309 => -0.161255,
			309 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 364 => -0.064214,
			364 <= iv_sr001_m_hdr_fs                             => -0.003443,
																															0.000000);

	rsp1_subscore3 := map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0   => 0.149352,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 63    => -0.354125,
			63 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 98   => -0.088284,
			98 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 103  => 0.068037,
			103 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 132 => 0.148474,
			132 <= iv_mos_since_gong_did_fst_seen                                          => 0.355540,
																																												-0.000000);

	rsp1_subscore4 := map(
			(iv_inp_own_prop_x_addr_naprop in [' '])                          => 0.000000,
			(iv_inp_own_prop_x_addr_naprop in ['00'])                         => -0.200730,
			(iv_inp_own_prop_x_addr_naprop in ['01'])                         => -0.043561,
			(iv_inp_own_prop_x_addr_naprop in ['02'])                         => -0.015931,
			(iv_inp_own_prop_x_addr_naprop in ['03', '10', '11', '12', '13']) => 0.181811,
			(iv_inp_own_prop_x_addr_naprop in ['04', '14'])                   => 0.185136,
																																					 0.000000);

	rsp1_subscore5 := map(
			NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 1 => 0.050682,
			1 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 2   => 0.098644,
			2 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 3   => -0.090075,
			3 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 4   => -0.296488,
			4 <= iv_gong_did_phone_ct                                => -0.776746,
																																	0.000000);

	rsp1_subscore6 := map(
			(iv_ed001_college_ind in [' ']) => -0.000000,
			(iv_ed001_college_ind in ['0']) => -0.039316,
			(iv_ed001_college_ind in ['1']) => 0.788042,
																				 -0.000000);

	rsp1_subscore7 := map(
			NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 0 => 0.072549,
			0 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 4   => 0.162761,
			4 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 8   => 0.133516,
			8 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 14  => -0.022806,
			14 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 24 => -0.163031,
			24 <= iv_max_ids_per_sfd_addr                                  => -0.323235,
																																				-0.000000);

	rsp1_subscore8 := map(
			NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 68750     => -0.079193,
			68750 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 104295  => 0.156854,
			104295 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 184357 => 0.160789,
			184357 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 216622 => 0.261676,
			216622 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 507407 => 0.340955,
			507407 <= iv_pv001_bst_avm_autoval                                       => 0.537040,
																																									-0.000000);

	rsp1_subscore9 := map(
			NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 1         => -0.051115,
			1 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 27061       => -0.255096,
			27061 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 83019   => -0.096019,
			83019 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 100906  => 0.081483,
			100906 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 117644 => 0.197516,
			117644 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 186170 => 0.263444,
			186170 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 389976 => 0.283681,
			389976 <= iv_prv_addr_avm_auto_val                                       => 0.523054,
																																									-0.000000);

	rsp1_subscore10 := map(
			NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 2 => 0.219275,
			2 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 3   => 0.140014,
			3 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 4   => 0.062289,
			4 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 6   => -0.072504,
			6 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 9   => -0.117578,
			9 <= iv_pl002_addrs_15yr                               => -0.119635,
																																-0.000000);

	rsp1_subscore11 := map(
			NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 0        => 0.010967,
			0 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 30534      => -0.436785,
			30534 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 66680  => -0.167143,
			66680 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 99600  => -0.047000,
			99600 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 142084 => 0.143985,
			142084 <= iv_avg_prop_assess_purch_amt                                          => 0.228356,
																																												 0.000000);

	rsp1_subscore12 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.058023,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.156634,
			3 <= iv_ms001_ssns_per_adl                                 => -0.320884,
																																		-0.000000);

	rsp1_subscore13 := map(
			NULL < iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 0 => 0.000000,
			0 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 7   => -0.037137,
			7 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 8   => 0.224298,
			8 <= iv_sr001_source_profile_index AND iv_sr001_source_profile_index < 9   => 0.268955,
			9 <= iv_sr001_source_profile_index                                         => 0.489564,
																																										0.000000);

	rsp1_subscore14 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in [' '])                                      => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['1-3', '3-1'])                             => -0.155328,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-1', '3-3'])                      => -0.070580,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-3', '1-0', '2-0', '2-1', '2-3']) => -0.031893,
			(iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.179969,
																																											0.000000);

	rsp1_subscore15 := map(
			NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.015456,
			1 <= iv_inq_highriskcredit_count12                                         => -0.691873,
																																										0.000000);

	rsp1_subscore16 := map(
			NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 1 => 0.014897,
			1 <= iv_inq_auto_count12                               => -0.529471,
																																0.000000);

	rsp1_subscore17 := map(
			(iv_bst_addr_mortgage_type in [' '])                                                                           => -0.000000,
			(iv_bst_addr_mortgage_type in ['No Mortgage'])                                                                 => 0.002443,
			(iv_bst_addr_mortgage_type in ['Commercial', 'High-Risk', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => -0.064837,
			(iv_bst_addr_mortgage_type in ['Government'])                                                                  => 0.032706,
			(iv_bst_addr_mortgage_type in ['Equity Loan'])                                                                 => 0.159957,
			(iv_bst_addr_mortgage_type in ['Conventional'])                                                                => 0.311414,
																																																												-0.000000);

	rsp1_subscore18 := map(
			NULL < iv_max_lres AND iv_max_lres < 44  => 0.134514,
			44 <= iv_max_lres AND iv_max_lres < 132  => 0.054492,
			132 <= iv_max_lres AND iv_max_lres < 154 => -0.128764,
			154 <= iv_max_lres AND iv_max_lres < 198 => -0.107613,
			198 <= iv_max_lres AND iv_max_lres < 233 => -0.023745,
			233 <= iv_max_lres AND iv_max_lres < 343 => 0.048532,
			343 <= iv_max_lres                       => 0.053337,
																									0.000000);

	rsp1_subscore19 := map(
			(iv_prof_license_category in [' '])                => 0.000000,
			(iv_prof_license_category in ['-1'])               => -0.013373,
			(iv_prof_license_category in ['0', '1'])           => -0.047432,
			(iv_prof_license_category in ['2', '3', '4', '5']) => 0.440070,
																														0.000000);

	rsp1_subscore20 := map(
			NULL < iv_inq_communications_count12 AND iv_inq_communications_count12 < 1 => 0.007605,
			1 <= iv_inq_communications_count12                                         => -0.584205,
																																										0.000000);

	rsp1_subscore21 := map(
			(iv_pb_order_freq in [' '])                                       => -0.000000,
			(iv_pb_order_freq in ['0 No Purch Data'])                         => -0.027674,
			(iv_pb_order_freq in ['1 Cant Calculate'])                        => -0.064318,
			(iv_pb_order_freq in ['2 Weekly', '3 Monthly', '4 Semi-monthly']) => -0.026764,
			(iv_pb_order_freq in ['5 Quarterly', '6 Semi-yearly'])            => 0.030722,
			(iv_pb_order_freq in ['7 Yearly', '8 Rarely'])                    => 0.121895,
																																					 -0.000000);

	rsp1_rawscore := rsp1_subscore0 +
			rsp1_subscore1 +
			rsp1_subscore2 +
			rsp1_subscore3 +
			rsp1_subscore4 +
			rsp1_subscore5 +
			rsp1_subscore6 +
			rsp1_subscore7 +
			rsp1_subscore8 +
			rsp1_subscore9 +
			rsp1_subscore10 +
			rsp1_subscore11 +
			rsp1_subscore12 +
			rsp1_subscore13 +
			rsp1_subscore14 +
			rsp1_subscore15 +
			rsp1_subscore16 +
			rsp1_subscore17 +
			rsp1_subscore18 +
			rsp1_subscore19 +
			rsp1_subscore20 +
			rsp1_subscore21;

	rsp1_lnoddsscore := rsp1_rawscore + 4.718069;

	rsp1_probscore := exp(rsp1_lnoddsscore) / (1 + exp(rsp1_lnoddsscore));

	ssn_deceased := rc_decsflag = '1' or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') ;

	rv_20_content := nas_summary > 4 or nap_summary > 4 or add1_naprop > 2;

	eda_sourced := (nap_summary in [2, 3, 5, 6, 7, 8, 9, 10, 11, 12]);

	eq_only := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EQ', ',')  and Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ',') = 1 and not(eda_sourced);

	rv_prescreen_content := (rv_20_content or eda_sourced or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EM', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'VO', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'V', ',') or 
		add1_naprop > 2 or prof_license_flag or add1_avm_land_use != '' or 
		trim(ams_file_type, LEFT, RIGHT) != '' or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'EB', ',') or 
		indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'W', ',') or
		watercraft_count > 0 or 
		if(max(property_owned_total, property_sold_total) = NULL, NULL,
			sum(if(property_owned_total = NULL, 0, property_owned_total), 
				if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 
				90 <= combo_dobscore AND combo_dobscore <= 100 or 
				input_dob_match_level >= '7' or 
				indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') or
				indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') or 
				liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 or
				criminal_count > 0 or (rc_bansflag in ['1', '2']) or 
				indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') or
				bankrupt or filing_count > 0 or bk_recent_count > 0 or rc_decsflag ='1' or 
				indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or 
				truedid) and not(eq_only) and truedid;

	probscore := map(
			rv_derog_segment = '0 Derog' => rsp0_probscore,
																			rsp1_probscore);

	base := 700;

	pts := 40;

	odds := (1 - .0092) / .0092;

	rvp1401_1_0 := map(
			ssn_deceased              => 200,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
																	min(if(max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 501)), 900));

//Intermediate variables
	#if(RVP_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;                                                  
		self.derog_flag                       := derog_flag;                                               
		self.rv_derog_segment                 := rv_derog_segment;                                         
		self.iv_add_apt                       := iv_add_apt;                                               
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;                                      
		self.email_src_im                     := email_src_im;                                             
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;                                   
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;                                    
		self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;                                 
		self.iv_ed001_college_ind             := iv_ed001_college_ind;                                     
		self.prop_adl_p_count_pos             := prop_adl_p_count_pos;                                     
		self.prop_adl_count_p                 := prop_adl_count_p;                                         
		self._src_prop_adl_count              := _src_prop_adl_count;                                      
		self.iv_src_property_adl_count        := iv_src_property_adl_count;                                
		self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;                            
		self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;                                 
		self.iv_gong_did_phone_ct             := iv_gong_did_phone_ct;                                     
		self.iv_max_ids_per_sfd_addr          := iv_max_ids_per_sfd_addr;                                  
		self.ver_phn_inf                      := ver_phn_inf;                                              
		self.ver_phn_nap                      := ver_phn_nap;                                              
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;                                          
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;                                          
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;                             
		self.iv_liens_unrel_cj_ct             := iv_liens_unrel_cj_ct;                                     
		self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;                                     
		self.iv_prof_license_flag             := iv_prof_license_flag;                                     
		self.sum_dols                         := sum_dols;                                                 
		self.pct_offline_dols                 := pct_offline_dols;                                         
		self.pct_retail_dols                  := pct_retail_dols;                                          
		self.pct_online_dols                  := pct_online_dols;                                          
		self.iv_pb_profile                    := iv_pb_profile;                                            
		self.bureau_adl_vo_fseen_pos          := bureau_adl_vo_fseen_pos;                                  
		self.bureau_adl_fseen_vo              := bureau_adl_fseen_vo;                                      
		self._bureau_adl_fseen_vo             := _bureau_adl_fseen_vo;                                     
		self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;                                    
		self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;                                     
		self.bureau_adl_vo_lseen_pos          := bureau_adl_vo_lseen_pos;                                  
		self.bureau_adl_lseen_vo              := bureau_adl_lseen_vo;                                      
		self._bureau_adl_lseen_vo             := _bureau_adl_lseen_vo;                                     
		self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;                                     
		self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;                                   
		self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;                                    
		self.bureau_adl_w_lseen_pos           := bureau_adl_w_lseen_pos;                                   
		self.bureau_adl_lseen_w               := bureau_adl_lseen_w;                                       
		self._bureau_adl_lseen_w              := _bureau_adl_lseen_w;                                      
		self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;                                      
		self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;                                     
		self.bureau_adl_wp_lseen_pos          := bureau_adl_wp_lseen_pos;                                  
		self.bureau_adl_lseen_wp              := bureau_adl_lseen_wp;                                      
		self._bureau_adl_lseen_wp             := _bureau_adl_lseen_wp;                                     
		self._src_bureau_adl_lseen            := _src_bureau_adl_lseen;                                    
		self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;                                     
		self.mth_ver_src_ldate_wp0            := mth_ver_src_ldate_wp0;                                    
		self._paw_first_seen                  := _paw_first_seen;                                          
		self.mth_paw_first_seen               := mth_paw_first_seen;                                       
		self.mth_paw_first_seen2              := mth_paw_first_seen2;                                      
		self.ver_src_am                       := ver_src_am;                                               
		self.ver_src_e1                       := ver_src_e1;                                               
		self.ver_src_e2                       := ver_src_e2;                                               
		self.ver_src_e3                       := ver_src_e3;                                               
		self.ver_src_pl                       := ver_src_pl;                                               
		self.ver_src_w                        := ver_src_w;                                                
		self.paw_dead_business_count_gt3      := paw_dead_business_count_gt3;                              
		self.paw_active_phone_count_0         := paw_active_phone_count_0;                                 
		self._infutor_first_seen              := _infutor_first_seen;                                      
		self.mth_infutor_first_seen           := mth_infutor_first_seen;                                   
		self._infutor_last_seen               := _infutor_last_seen;                                       
		self.mth_infutor_last_seen            := mth_infutor_last_seen;                                    
		self.infutor_i                        := infutor_i;                                                
		self.infutor_im                       := infutor_im;                                               
		self.white_pages_adl_wp_fseen_pos     := white_pages_adl_wp_fseen_pos;                             
		self.white_pages_adl_fseen_wp         := white_pages_adl_fseen_wp;                                 
		self._white_pages_adl_fseen_wp        := _white_pages_adl_fseen_wp;                                
		self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;                               
		self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;                                     
		self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;                                          
		self._header_first_seen               := _header_first_seen;                                       
		self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;                                        
		self.src_m_hdr_fs                     := src_m_hdr_fs;                                             
		self.source_mod6                      := source_mod6;                                              
		self.iv_sr001_source_profile          := iv_sr001_source_profile;                                  
		self.iv_sr001_source_profile_index    := iv_sr001_source_profile_index;                            
		self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;                                      
		self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;                            
		self.mortgage_type                    := mortgage_type;                                            
		self.mortgage_present                 := mortgage_present;                                         
		self.iv_bst_addr_mortgage_type        := iv_bst_addr_mortgage_type;                                
		self.iv_avg_prop_assess_purch_amt     := iv_avg_prop_assess_purch_amt;                             
		self.iv_max_lres                      := iv_max_lres;                                              
		self._gong_did_first_seen             := _gong_did_first_seen;                                     
		self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;                           
		self.iv_inq_auto_count12              := iv_inq_auto_count12;                                      
		self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;                            
		self.iv_inq_communications_count12    := iv_inq_communications_count12;                            
		self.iv_prof_license_category         := iv_prof_license_category;                                 
		self.iv_pb_order_freq                 := iv_pb_order_freq;                                         
		self.rsp0_subscore0                   := rsp0_subscore0;                                           
		self.rsp0_subscore1                   := rsp0_subscore1;                                           
		self.rsp0_subscore2                   := rsp0_subscore2;                                           
		self.rsp0_subscore3                   := rsp0_subscore3;                                           
		self.rsp0_subscore4                   := rsp0_subscore4;                                           
		self.rsp0_subscore5                   := rsp0_subscore5;                                           
		self.rsp0_subscore6                   := rsp0_subscore6;                                           
		self.rsp0_subscore7                   := rsp0_subscore7;                                           
		self.rsp0_subscore8                   := rsp0_subscore8;                                           
		self.rsp0_subscore9                   := rsp0_subscore9;                                           
		self.rsp0_subscore10                  := rsp0_subscore10;                                          
		self.rsp0_subscore11                  := rsp0_subscore11;                                          
		self.rsp0_subscore12                  := rsp0_subscore12;                                          
		self.rsp0_subscore13                  := rsp0_subscore13;                                          
		self.rsp0_subscore14                  := rsp0_subscore14;                                          
		self.rsp0_rawscore                    := rsp0_rawscore;                                            
		self.rsp0_lnoddsscore                 := rsp0_lnoddsscore;                                         
		self.rsp0_probscore                   := rsp0_probscore;                                           
		self.rsp1_subscore0                   := rsp1_subscore0;                                           
		self.rsp1_subscore1                   := rsp1_subscore1;                                           
		self.rsp1_subscore2                   := rsp1_subscore2;                                           
		self.rsp1_subscore3                   := rsp1_subscore3;                                           
		self.rsp1_subscore4                   := rsp1_subscore4;                                           
		self.rsp1_subscore5                   := rsp1_subscore5;                                           
		self.rsp1_subscore6                   := rsp1_subscore6;                                           
		self.rsp1_subscore7                   := rsp1_subscore7;                                           
		self.rsp1_subscore8                   := rsp1_subscore8;                                           
		self.rsp1_subscore9                   := rsp1_subscore9;                                           
		self.rsp1_subscore10                  := rsp1_subscore10;                                          
		self.rsp1_subscore11                  := rsp1_subscore11;                                          
		self.rsp1_subscore12                  := rsp1_subscore12;                                          
		self.rsp1_subscore13                  := rsp1_subscore13;                                          
		self.rsp1_subscore14                  := rsp1_subscore14;                                          
		self.rsp1_subscore15                  := rsp1_subscore15;                                          
		self.rsp1_subscore16                  := rsp1_subscore16;                                          
		self.rsp1_subscore17                  := rsp1_subscore17;                                          
		self.rsp1_subscore18                  := rsp1_subscore18;                                          
		self.rsp1_subscore19                  := rsp1_subscore19;                                          
		self.rsp1_subscore20                  := rsp1_subscore20;                                          
		self.rsp1_subscore21                  := rsp1_subscore21;                                          
		self.rsp1_rawscore                    := rsp1_rawscore;                                            
		self.rsp1_lnoddsscore                 := rsp1_lnoddsscore;                                         
		self.rsp1_probscore                   := rsp1_probscore;                                           
		self.ssn_deceased                     := ssn_deceased;                                             
		self.rv_20_content                    := rv_20_content;                                            
		self.eda_sourced                      := eda_sourced;                                              
		self.eq_only                          := eq_only;                                                  
		self.rv_prescreen_content             := rv_prescreen_content;                                     
		self.probscore                        := probscore;                                                
		self.base                             := base;                                                     
		self.pts                              := pts;                                                      
		self.odds                             := odds;                                                     
		self.rvp1401_1_0                      := rvp1401_1_0;                                              

	#end
	self.seq := le.seq;
	PrescreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
	self.score := if( risk_indicators.rcset.isCode95(PreScreenOptOut), '222', (string3)rvp1401_1_0 );
	self.ri := if( risk_indicators.rcset.isCode95(PreScreenOptOut), DATASET([{'95', risk_indicators.getHRIDesc('95')}],risk_indicators.Layout_Desc) );

END;

		model := project( clam, doModel(left) );

		return model;
END;