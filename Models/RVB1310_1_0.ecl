import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVB1310_1_0(  grouped dataset(risk_indicators.Layout_Boca_Shell) clamPre, BOOLEAN isCalifornia = FALSE, BOOLEAN isFCRA = TRUE) := FUNCTION

	msa_bocashell := RECORD
		risk_indicators.Layout_Boca_Shell;
		string50 msa;
	end;

	clam := join(clamPre, Models.Key_MSA_Zip_Lookup(isFCRA), KEYED(left.shell_input.z5 = right.zip), 
							  TRANSFORM(msa_bocashell, self.msa:= right.msa, self:=left),
								left outer, keep(1));	
	
	
	RVB_DEBUG := False;

	#if(RVB_DEBUG)
		debug_layout := record
			risk_indicators.Layout_Boca_Shell clam;
			Integer sysdate                         ;
			Boolean iv_riskview_222s                ;
			Boolean ssn_deceased                    ;
			Boolean ver_src_ba                      ;
			Boolean bk_flag                         ;
			Boolean ver_src_l2                      ;
			Boolean ver_src_li                      ;
			Boolean lien_rec_unrel_flag             ;
			Boolean lien_hist_unrel_flag            ;
			Boolean lien_flag                       ;
			Integer property_owner                  ;
			Integer pk_impulse_count                ;
			Integer bs_attr_derog_flag              ;
			Integer bs_attr_eviction_flag           ;
			Integer bs_attr_derog_flag2             ;
			String segment_40                      ;
			Boolean iv_pots_phone                   ;
			Boolean iv_add_apt                      ;
			String iv_db001_bankruptcy             ;
			Integer iv_de001_eviction_recency       ;
			Integer iv_ms001_ssns_per_adl           ;
			Integer iv_in001_estimated_income       ;
			Integer bureau_addr_tn_fseen_pos        ;
			String bureau_addr_fseen_tn            ;
			Integer _bureau_addr_fseen_tn           ;
			Integer bureau_addr_ts_fseen_pos        ;
			String bureau_addr_fseen_ts            ;
			Integer _bureau_addr_fseen_ts           ;
			Integer bureau_addr_tu_fseen_pos        ;
			String bureau_addr_fseen_tu            ;
			Integer _bureau_addr_fseen_tu           ;
			Integer bureau_addr_en_fseen_pos        ;
			String bureau_addr_fseen_en            ;
			Integer _bureau_addr_fseen_en           ;
		  Integer bureau_addr_eq_fseen_pos        ;
			String bureau_addr_fseen_eq            ;
			Integer _bureau_addr_fseen_eq           ;
			Integer _src_bureau_addr_fseen          ;
			Integer iv_mos_src_bureau_addr_fseen    ;
			String iv_inp_own_prop_x_addr_naprop   ;
			Integer bst_addr_avm_auto_val           ;
			Integer bst_addr_mortgage_amount        ;
			Real iv_bst_addr_mtg_avm_pct_diff    ;
			Integer iv_bst_addr_assessed_total_val  ;
			Integer _gong_did_first_seen            ;
			Integer iv_mos_since_gong_did_fst_seen  ;
			Integer iv_ssns_per_sfd_addr            ;
			Integer iv_inq_auto_recency             ;
			Integer iv_inq_highriskcredit_count12   ;
			Integer _paw_first_seen                 ;
			Integer iv_mos_since_paw_first_seen     ;
			Boolean ver_phn_inf                     ;
			Boolean ver_phn_nap                     ;
			Integer inf_phn_ver_lvl                 ;
			Integer nap_phn_ver_lvl                 ;
			String iv_nap_phn_ver_x_inf_phn_ver    ;
			Integer _impulse_last_seen              ;
			Integer iv_mos_since_impulse_last_seen  ;
			String iv_liens_unrel_x_rel            ;
			String iv_criminal_x_felony            ;
			String iv_ams_college_tier             ;
			Integer iv_pb_total_dollars             ;
			Real drg_subscore0                   ;
			Real drg_subscore1                   ;
			Real drg_subscore2                   ;
			Real drg_subscore3                   ;
			Real drg_subscore4                   ;
			Real drg_subscore5                   ;
			Real drg_subscore6                   ;
			Real drg_subscore7                   ;
			Real drg_subscore8                   ;
			Real drg_subscore9                   ;
			Real drg_subscore10                  ;
			Real drg_subscore11                  ;
			Real drg_subscore12                  ;
			Real drg_subscore13                  ;
			Real drg_subscore14                  ;
			Real drg_subscore15                  ;
			Real drg_subscore16                  ;
			Real drg_subscore17                  ;
			Real drg_subscore18                  ;
			Real drg_subscore19                  ;
			Real drg_rawscore                    ;
			Real drg_lnoddsscore                 ;
			Real drg_probscore                   ;
			String iv_vs002_ssn_prior_dob          ;
			String iv_vp007_phn_pcs                ;
			Integer iv_va060_dist_add_in_bst        ;
			Integer _header_first_seen              ;
			Integer iv_sr001_m_hdr_fs               ;
			Integer iv_mi001_adlperssn_count        ;
			Integer _in_dob                         ;
			Real yr_in_dob                       ;
			Integer yr_in_dob_int                   ;
			Integer age_estimate                    ;
			Integer iv_ag001_age                    ;
			Integer iv_pl002_addrs_per_ssn_c6       ;
			Integer iv_inp_addr_assessed_total_val  ;
			Integer iv_max_ids_per_sfd_addr         ;
			Integer iv_pl_addrs_per_adl             ;
			Integer _infutor_first_seen             ;
			Integer iv_mos_since_infutor_first_seen ;
			Integer sum_dols                        ;
			Real pct_offline_dols                ;
			Real pct_retail_dols                 ;
			Real pct_online_dols                 ;
			String iv_pb_profile                   ;
			Real yng_subscore0                   ;
			Real yng_subscore1                   ;
			Real yng_subscore2                   ;
			Real yng_subscore3                   ;
			Real yng_subscore4                   ;
			Real yng_subscore5                   ;
			Real yng_subscore6                   ;
			Real yng_subscore7                   ;
			Real yng_subscore8                   ;
			Real yng_subscore9                   ;
			Real yng_subscore10                  ;
			Real yng_subscore11                  ;
			Real yng_subscore12                  ;
			Real yng_subscore13                  ;
			Real yng_subscore14                  ;
			Real yng_subscore15                  ;
			Real yng_subscore16                  ;
			Real yng_subscore17                  ;
			Real yng_subscore18                  ;
			Real yng_subscore19                  ;
			Real yng_subscore20                  ;
			Real yng_rawscore                    ;
			Real yng_lnoddsscore                 ;
			Real yng_probscore                   ;
			Integer iv_pv001_bst_avm_autoval        ;
			Integer iv_addr_non_phn_src_ct          ;
			Integer iv_combined_age                 ;
			String mortgage_type                   ;
			Boolean mortgage_present                ;
			String iv_inp_addr_mortgage_type       ;
			Integer iv_inp_addr_building_area       ;
			Integer prv_addr_date_first_seen        ;
			Integer iv_mos_since_prv_addr_fseen     ;
			Real iv_avg_prop_assess_purch_amt    ;
			Integer iv_dist_bst_addr_to_prv_addr    ;
			Integer iv_addrs_per_adl                ;
			Integer iv_adls_per_sfd_addr            ;
			Integer iv_inq_auto_count12             ;
			String iv_paw_dead_bus_x_active_phn    ;
			Integer iv_pb_average_dollars           ;
			Real own_subscore0                   ;
			Real own_subscore1                   ;
			Real own_subscore2                   ;
			Real own_subscore3                   ;
			Real own_subscore4                   ;
			Real own_subscore5                   ;
			Real own_subscore6                   ;
			Real own_subscore7                   ;
			Real own_subscore8                   ;
			Real own_subscore9                   ;
			Real own_subscore10                  ;
			Real own_subscore11                  ;
			Real own_subscore12                  ;
			Real own_subscore13                  ;
			Real own_subscore14                  ;
			Real own_subscore15                  ;
			Real own_subscore16                  ;
			Real own_rawscore                    ;
			Real own_lnoddsscore                 ;
			Real own_probscore                   ;
			Integer iv_dist_inp_addr_to_prv_addr    ;
			Integer _reported_dob                   ;
			Integer reported_age                    ;
			Integer _combined_age                   ;
			Boolean evidence_of_college             ;
			String evidence_of_college_flag        ;
			String iv_college_attendance_x_age     ;
			Real otr_subscore0                   ;
			Real otr_subscore1                   ;
			Real otr_subscore2                   ;
			Real otr_subscore3                   ;
			Real otr_subscore4                   ;
			Real otr_subscore5                   ;
			Real otr_subscore6                   ;
			Real otr_subscore7                   ;
			Real otr_subscore8                   ;
			Real otr_subscore9                   ;
			Real otr_subscore10                  ;
			Real otr_subscore11                  ;
			Real otr_subscore12                  ;
			Real otr_subscore13                  ;
			Real otr_subscore14                  ;
			Real otr_rawscore                    ;
			Real otr_lnoddsscore                 ;
			Real otr_probscore                   ;
			String iv_ed001_college_ind            ;
			Integer base                            ;
			Integer point                           ;
			Real odds                            ;
			Integer rvb1310_1_0                     ;
			Boolean drg_glrc36                      ;
			Boolean drg_glrc97                      ;
			Boolean drg_glrc98                      ;
			Boolean drg_glrc9a                      ;
			Boolean drg_glrc9h                      ;
			Boolean drg_glrc9i                      ;
			Boolean drg_glrc9j                      ;
			Boolean drg_glrc9p                      ;
			Boolean drg_glrc9q                      ;
			Boolean drg_glrc9r                      ;
			Boolean drg_glrc9w                      ;
			Boolean drg_glrc9y                      ;
			Boolean drg_glrcev                      ;
			Boolean drg_glrcms                      ;
			Boolean drg_glrcpv                      ;
			Boolean drg_glrcbl                      ;
			Boolean yng_glrc03                      ;
			Boolean yng_glrc36                      ;
			Boolean yng_glrc9a                      ;
			Boolean yng_glrc9i                      ;
			Boolean yng_glrc9j                      ;
			Boolean yng_glrc9l                      ;
			Boolean yng_glrc9q                      ;
			Boolean yng_glrc9r                      ;
			Boolean yng_glrc9y                      ;
			Boolean yng_glrcmi                      ;
			Boolean yng_glrcpv                      ;
			Integer yng_glrcbl                      ;
			Boolean own_glrc36                      ;
			Boolean own_glrc9d                      ;
			Boolean own_glrc9e                      ;
			Boolean own_glrc9i                      ;
			Boolean own_glrc9l                      ;
			Boolean own_glrc9q                      ;
			Boolean own_glrc9r                      ;
			Boolean own_glrc9y                      ;
			Boolean own_glrc9s                      ;
			Boolean own_glrcpv                      ;
			Integer own_glrcbl                      ;
			Boolean otr_glrc36                      ;
			Boolean otr_glrc9d                      ;
			Boolean otr_glrc9e                      ;
			Boolean otr_glrc9i                      ;
			Boolean otr_glrc9l                      ;
			Boolean otr_glrc9p                      ;
			Boolean otr_glrc9q                      ;
			Boolean otr_glrc9y                      ;
			Boolean otr_glrcms                      ;
			Boolean otr_glrcpv                      ;
			Integer otr_glrcbl                      ;
			Boolean bk                              ;
			Boolean eviction                        ;
			Boolean lien                            ;
			Boolean pdl                             ;
			Integer derogsum                        ;
			Real seg_glrc97                      ;
			Real seg_glrc98                      ;
			Boolean seg_glrc9a                      ;
			Real seg_glrc9h                      ;
			Boolean seg_glrc9r                      ;
			Real seg_glrc9w                      ;
			Real seg_glrcev                      ;
			Boolean no_addr_ver                     ;
			Boolean source_confirm_date             ;
			Integer est_inc_sum                     ;
			Real drg_glrc25                      ;
			Real drg_glrc9c                      ;
			Real drg_glrc9f                      ;
			Real yng_glrc25                      ;
			Real yng_glrc9c                      ;
			Real yng_glrc9f                      ;
			Real rcvalue25_1                     ;
			Real rcvalue25_2                     ;
			Real rcvalue25                       ;
			Real rcvalue9c_1                     ;
			Real rcvalue9c_2                     ;
			Real rcvalue9c                       ;
			Real rcvalue9f_1                     ;
			Real rcvalue9f_2                     ;
			Real rcvalue9f                       ;
			Real rcvalue03_1                     ;
			Real rcvalue03                       ;
			Real rcvalue36_1                     ;
			Real rcvalue36_2                     ;
			Real rcvalue36_3                     ;
			Real rcvalue36_4                     ;
			Real rcvalue36_5                     ;
			Real rcvalue36_6                     ;
			Real rcvalue36_7                     ;
			Real rcvalue36_8                     ;
			Real rcvalue36_9                     ;
			Real rcvalue36_10                    ;
			Real rcvalue36                       ;
			Real rcvalue97_1                     ;
			Real rcvalue97_2                     ;
			Real rcvalue97                       ;
			Real rcvalue98_1                     ;
			Real rcvalue98_2                     ;
			Real rcvalue98                       ;
			Real rcvalue9a_1                     ;
			Real rcvalue9a_2                     ;
			Real rcvalue9a_3                     ;
			Real rcvalue9a                       ;
			Real rcvalue9d_1                     ;
			Real rcvalue9d_2                     ;
			Real rcvalue9d                       ;
			Real rcvalue9e_1                     ;
			Real rcvalue9e_2                     ;
			Real rcvalue9e                       ;
			Real rcvalue9h_1                     ;
			Real rcvalue9h_2                     ;
			Real rcvalue9h                       ;
			Real rcvalue9i_1                     ;
			Real rcvalue9i_2                     ;
			Real rcvalue9i_3                     ;
			Real rcvalue9i_4                     ;
			Real rcvalue9i_5                     ;
			Real rcvalue9i                       ;
			Real rcvalue9j_1                     ;
			Real rcvalue9j_2                     ;
			Real rcvalue9j                       ;
			Real rcvalue9l_1                     ;
			Real rcvalue9l_2                     ;
			Real rcvalue9l_3                     ;
			Real rcvalue9l                       ;
			Real rcvalue9p_1                     ;
			Real rcvalue9p_2                     ;
			Real rcvalue9p                       ;
			Real rcvalue9q_1                     ;
			Real rcvalue9q_2                     ;
			Real rcvalue9q_3                     ;
			Real rcvalue9q_4                     ;
			Real rcvalue9q                       ;
			Real rcvalue9r_1                     ;
			Real rcvalue9r_2                     ;
			Real rcvalue9r_3                     ;
			Real rcvalue9r_4                     ;
			Real rcvalue9r                       ;
			Real rcvalue9s_1                     ;
			Real rcvalue9s                       ;
			Real rcvalue9w_1                     ;
			Real rcvalue9w_2                     ;
			Real rcvalue9w                       ;
			Real rcvalue9y_1                     ;
			Real rcvalue9y_2                     ;
			Real rcvalue9y_3                     ;
			Real rcvalue9y_4                     ;
			Real rcvalue9y                       ;
			Real rcvalueev_1                     ;
			Real rcvalueev_2                     ;
			Real rcvalueev                       ;
			Real rcvaluemi_1                     ;
			Real rcvaluemi                       ;
			Real rcvaluems_1                     ;
			Real rcvaluems_2                     ;
			Real rcvaluems                       ;
			Real rcvaluepv_1                     ;
			Real rcvaluepv_3                     ;
			Real rcvaluepv_2                     ;
			Real rcvaluepv_4                     ;
			Real rcvaluepv_5                     ;
			Real rcvaluepv                       ;
			Real rcvaluebl_1                     ;
			Real rcvaluebl_2                     ;
			Real rcvaluebl_3                     ;
			Real rcvaluebl_4                     ;
			Real rcvaluebl_5                     ;
			Real rcvaluebl_6                     ;
			Real rcvaluebl_7                     ;
			Real rcvaluebl_8                     ;
			Real rcvaluebl_9                     ;
			Real rcvaluebl_10                    ;
			Real rcvaluebl_11                    ;
			Real rcvaluebl_12                    ;
			Real rcvaluebl_13                    ;
			Real rcvaluebl_14                    ;
			Real rcvaluebl_15                    ;
			Real rcvaluebl_16                    ;
			Real rcvaluebl_17                    ;
			Real rcvaluebl_18                    ;
			Real rcvaluebl_19                    ;
			Real rcvaluebl                       ;
			String rc1                             ;
			String rc2                             ;
			String rc3                             ;
			String rc4                             ;
			String rc5                             ;
			String MSA_NAME                         ;


			Models.Layout_ModelOut;
		end;
		debug_layout doModel( clam le ) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end

	msa_name                         := le.msa;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcount                     := le.iid.addrcount;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_first_seen      := le.header_summary.ver_addr_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_lres                        := le.lres;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_building_area               := le.address_verification.input_address_information.building_area;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
	add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
	add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
	add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	impulse_last_seen                := le.impulse.last_seen_date;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_age                          := le.student.age;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	estimated_income                 := le.estimated_income;



NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

ssn_deceased := rc_decsflag = '1';

ver_src_ba := contains_i(StringLib.StringToUpperCase(ver_sources), 'BA') > 0;

bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

ver_src_l2 := contains_i(StringLib.StringToUpperCase(ver_sources), 'L2') > 0;

ver_src_li := contains_i(StringLib.StringToUpperCase(ver_sources), 'LI') > 0;

lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

property_owner := if(Add1_NaProp = 4 or Property_Owned_Total > 0, 1, 0);

pk_impulse_count := min(2, if(impulse_count = NULL, -NULL, impulse_count));

bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);

bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);

bs_attr_derog_flag2 := if(bs_attr_derog_flag > 0 or (integer)lien_flag > 0 or bs_attr_eviction_flag > 0 or pk_impulse_count > 0 or (integer)bk_flag > 0, 1, 0);

segment_40 := map(
    (integer)ssn_deceased = 1        => 'X 200  ',
    (integer)iv_riskview_222s = 1    => 'X 222  ',
    bs_attr_derog_flag2 = 1 => '0 Derog',
    inferred_age <= 24      => '1 Young',
    property_owner = 1      => '2 Owner',
                               '3 Other');

iv_pots_phone := (telcordia_type in ['00', '50', '51', '52', '54']);

iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

iv_db001_bankruptcy := map(
    not(truedid or ssnlength > '0')                                                                                               => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or (integer)bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                   '0 - No BK        ');

iv_de001_eviction_recency := map(
    not(truedid)                                                => NULL,
    attr_eviction_count90 >0                                       => 3,
    attr_eviction_count180 >0                                      => 6,
    attr_eviction_count12 >0                                      => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
    attr_eviction_count24 >0                                      => 25,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
    attr_eviction_count36 >0                                      => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
    attr_eviction_count60 >0                                      => 61,
    attr_eviction_count >= 2                                    => 98,
    attr_eviction_count >= 1                                    => 99,
                                                                   0);

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

bureau_addr_tn_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E');

bureau_addr_fseen_tn := if(bureau_addr_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tn_fseen_pos, ','));

_bureau_addr_fseen_tn := common.sas_date((string)(bureau_addr_fseen_tn));

bureau_addr_ts_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E');

bureau_addr_fseen_ts := if(bureau_addr_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_ts_fseen_pos, ','));

_bureau_addr_fseen_ts := common.sas_date((string)(bureau_addr_fseen_ts));

bureau_addr_tu_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E');

bureau_addr_fseen_tu := if(bureau_addr_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_tu_fseen_pos, ','));

_bureau_addr_fseen_tu := common.sas_date((string)(bureau_addr_fseen_tu));

bureau_addr_en_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E');

bureau_addr_fseen_en := if(bureau_addr_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_en_fseen_pos, ','));

_bureau_addr_fseen_en := common.sas_date((string)(bureau_addr_fseen_en));

bureau_addr_eq_fseen_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E');

bureau_addr_fseen_eq := if(bureau_addr_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Addr_sources_first_seen, bureau_addr_eq_fseen_pos, ','));

_bureau_addr_fseen_eq := common.sas_date((string)(bureau_addr_fseen_eq));

_src_bureau_addr_fseen := if(max(_bureau_addr_fseen_tn, _bureau_addr_fseen_ts, _bureau_addr_fseen_tu, _bureau_addr_fseen_en, _bureau_addr_fseen_eq) = NULL, NULL, min(if(_bureau_addr_fseen_tn = NULL, -NULL, _bureau_addr_fseen_tn), if(_bureau_addr_fseen_ts = NULL, -NULL, _bureau_addr_fseen_ts), if(_bureau_addr_fseen_tu = NULL, -NULL, _bureau_addr_fseen_tu), if(_bureau_addr_fseen_en = NULL, -NULL, _bureau_addr_fseen_en), if(_bureau_addr_fseen_eq = NULL, -NULL, _bureau_addr_fseen_eq)));

iv_mos_src_bureau_addr_fseen := map(
    not(truedid)                  => NULL,
    _src_bureau_addr_fseen = NULL => -1,
                                     if ((sysdate - _src_bureau_addr_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_addr_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_addr_fseen) / (365.25 / 12))));

iv_inp_own_prop_x_addr_naprop := map(
    not(add1_pop)            => '  ',
    property_owned_total > 0 => (string)(add1_naprop + 10),
                                '0' + (string)add1_naprop);

bst_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

bst_addr_mortgage_amount := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_mortgage_amount,
                        add2_mortgage_amount);

iv_bst_addr_mtg_avm_pct_diff := if(bst_addr_mortgage_amount <= 0 or bst_addr_avm_auto_val <= 0, NULL, bst_addr_avm_auto_val / bst_addr_mortgage_amount);

iv_bst_addr_assessed_total_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_assessed_total_value,
                        add2_assessed_total_value);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

iv_ssns_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    (string)iv_add_apt = '1' => -1,
                        ssns_per_addr);

iv_inq_auto_recency := map(
    not(truedid)     => NULL,
    inq_auto_count01 >=1 => 1,
    inq_auto_count03 >=1 => 3,
    inq_auto_count06 >=1 => 6,
    inq_auto_count12 >=1 => 12,
    inq_auto_count24 >=1 => 24,
    inq_auto_count   >=1 => 99,
                        0);

iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

_paw_first_seen := common.sas_date((string)(paw_first_seen));

iv_mos_since_paw_first_seen := map(
    not(truedid)                => NULL,
    not(_paw_first_seen = NULL) => if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12))),
                                   -1);

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
                               trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT));

_impulse_last_seen := common.sas_date((string)(impulse_last_seen));

iv_mos_since_impulse_last_seen := map(
    not(truedid)                   => NULL,
    not(_impulse_last_seen = NULL) => if ((sysdate - _impulse_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_last_seen) / (365.25 / 12)), roundup((sysdate - _impulse_last_seen) / (365.25 / 12))),
                                      -1);

iv_liens_unrel_x_rel := if(not(truedid), '   ', trim((string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT));

iv_criminal_x_felony := if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

iv_ams_college_tier := map(
    not(truedid)            => '  ',
    ams_college_tier = ' ' => '-1',
                               ams_college_tier);

iv_pb_total_dollars := map(
    not(truedid)            => NULL,
    pb_total_dollars = ' ' => -1,
                               (integer)pb_total_dollars);

drg_subscore0 := map(
    NULL < iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 0 => 0.227421,
    0 <= iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 5   => -1.287422,
    5 <= iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 12  => -0.871101,
    12 <= iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 23 => -0.701823,
    23 <= iv_mos_since_impulse_last_seen                                         => -0.536439,
                                                                                    0.000000);

drg_subscore1 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999    => -0.147099,
    19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 20000  => -0.346005,
    20000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 21000  => -0.288359,
    21000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 24000  => -0.244706,
    24000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 28000  => -0.139615,
    28000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 32000  => -0.013965,
    32000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 36000  => 0.140058,
    36000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 40000  => 0.226831,
    40000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 77000  => 0.393905,
    77000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 120000 => 0.568769,
    120000 <= iv_in001_estimated_income                                       => 0.825866,
                                                                                 0.000000);

drg_subscore2 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.070500,
    1 <= iv_inq_highriskcredit_count12                                         => -1.005878,
                                                                                  0.000000);

drg_subscore3 := map(
    NULL < iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen < 0  => -0.320604,
    0 <= iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen < 4    => -0.095579,
    4 <= iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen < 14   => 0.013451,
    14 <= iv_mos_src_bureau_addr_fseen AND iv_mos_src_bureau_addr_fseen < 218 => 0.175945,
    218 <= iv_mos_src_bureau_addr_fseen                                       => 0.360444,
                                                                                 0.000000);

drg_subscore4 := map(
    (iv_liens_unrel_x_rel in [' '])          => 0.000000,
    (iv_liens_unrel_x_rel in ['0-0'])        => 0.129726,
    (iv_liens_unrel_x_rel in ['0-1', '0-2']) => 0.254504,
    (iv_liens_unrel_x_rel in ['1-1', '1-2']) => 0.239353,
    (iv_liens_unrel_x_rel in ['2-1', '2-2']) => 0.089476,
    (iv_liens_unrel_x_rel in ['3-2'])        => -0.038124,
    (iv_liens_unrel_x_rel in ['1-0'])        => -0.067504,
    (iv_liens_unrel_x_rel in ['2-0'])        => -0.222772,
    (iv_liens_unrel_x_rel in ['3-1'])        => -0.231395,
    (iv_liens_unrel_x_rel in ['3-0'])        => -0.424999,
                                                0.000000);

drg_subscore5 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency < 1 => 0.074908,
    1 <= iv_inq_auto_recency AND iv_inq_auto_recency < 6   => -0.573558,
    6 <= iv_inq_auto_recency AND iv_inq_auto_recency < 12  => -0.482217,
    12 <= iv_inq_auto_recency                              => -0.282375,
                                                              0.000000);

drg_subscore6 := map(
    NULL < iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 0 => 0.177237,
    0 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 5   => 0.168819,
    5 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 9   => -0.011541,
    9 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 21  => -0.130361,
    21 <= iv_ssns_per_sfd_addr                               => -0.185300,
                                                                0.000000);

drg_subscore7 := map(
    (iv_criminal_x_felony in [' '])          => 0.000000,
    (iv_criminal_x_felony in ['0-0'])        => 0.009843,
    (iv_criminal_x_felony in ['1-0', '2-0']) => 0.192723,
    (iv_criminal_x_felony in ['3-0'])        => -0.138302,
    (iv_criminal_x_felony in ['1-1', '2-1']) => -0.517919,
    (iv_criminal_x_felony in ['2-2'])        => -0.632266,
    (iv_criminal_x_felony in ['3-1', '3-2']) => -0.887845,
    (iv_criminal_x_felony in ['3-3'])        => -0.893836,
                                                0.000000);

drg_subscore8 := map(
    (iv_inp_own_prop_x_addr_naprop in [''])                    => 0.000000,
    (iv_inp_own_prop_x_addr_naprop in ['01'])                   => -0.116313,
    (iv_inp_own_prop_x_addr_naprop in ['00', '02', '03', '11']) => -0.038401,
    (iv_inp_own_prop_x_addr_naprop in ['10'])                   => -0.002508,
    (iv_inp_own_prop_x_addr_naprop in ['04'])                   => 0.086239,
    (iv_inp_own_prop_x_addr_naprop in ['12', '13', '14'])       => 0.309326,
                                                                   0.000000);

drg_subscore9 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -0.098970,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1', '3-3'])        => 0.082797,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.395764,
                                                                                    0.000000);

drg_subscore10 := map(
    (iv_db001_bankruptcy in [' '])                                => -0.000000,
    (iv_db001_bankruptcy in ['1 - BK Discharged'])                => 0.044566,
    (iv_db001_bankruptcy in ['0 - No BK'])                        => 0.026168,
    (iv_db001_bankruptcy in ['2 - BK Dismissed', '3 - BK Other']) => -0.678494,
                                                                     -0.000000);

drg_subscore11 := map(
    NULL < (integer)iv_pb_total_dollars AND (integer)iv_pb_total_dollars < 1    => -0.097786,
    1 <= (integer)iv_pb_total_dollars AND (integer)iv_pb_total_dollars < 15     => -0.105352,
    15 <= (integer)iv_pb_total_dollars AND (integer)iv_pb_total_dollars < 84    => 0.022501,
    84 <= (integer)iv_pb_total_dollars AND (integer)iv_pb_total_dollars < 200   => 0.177957,
    200 <= (integer)iv_pb_total_dollars AND (integer)iv_pb_total_dollars < 1623 => 0.208589,
    1623 <= (integer)iv_pb_total_dollars                               => 0.290628,
                                                                 0.000000);

drg_subscore12 := map(
    ((string)MSA_NAME in [' '])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        => -0.000000,
    ((string)MSA_NAME in ['ANDERSON, SC', 'ASHEVILLE, NC', 'BURLINGTON, NC', 'CHARLESTON-NORTH CHARLESTON,SC', 'CHARLOTTE-GASTONIA-CONCORD,NC-SC', 'COLUMBIA, SC', 'DURHAM, NC', 'FAYETTEVILLE, NC', 'FLORENCE, SC', 'GOLDSBORO, NC', 'GREENSBORO-HIGH POINT, NC', 'GREENVILLE, NC', 'GREENVILLE-MAULDIN-EASLEY, SC', 'HICKORY-LENOIR-MORGANTON,NC', 'JACKSONVILLE, NC', 'MYRTLE BEACH-CONWAY-NORTHMYRTLE BEACH, SC', 'NC NONMETROPOLITAN AREA', 'RALEIGH-CARY, NC', 'ROCKY MOUNT, NC', 'SC NONMETROPOLITAN AREA', 'SPARTANBURG, SC']) => -0.203793,
    ((string)MSA_NAME in ['SUMTER, SC', 'VIRGINIA BEACH-NORFOLK-NEWPORT NEWS, VA-NC', 'WILMINGTON, NC', 'WINSTON-SALEM, NC'])                                                                                                                                                                                                                                                                                                                                                                                                          => -0.203793,
    ((string)MSA_NAME in ['CAPE CORAL-FORT MYERS, FL', 'DELTONA-DAYTONA BEACH-ORMONDBEACH, FL', 'FL NONMETROPOLITAN AREA', 'FORT WALTON BEACH-CRESTVIEW-DESTIN, FL', 'GAINESVILLE, FL', 'JACKSONVILLE, FL', 'LAKELAND, FL', 'MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL', 'NAPLES-MARCO ISLAND, FL', 'OCALA, FL', 'ORLANDO-KISSIMMEE, FL', 'PALM BAY-MELBOURNE-TITUSVILLE, FL', 'PALM COAST, FL', 'PANAMA CITY-LYNN HAVEN, FL', 'PENSACOLA-FERRY PASS-BRENT,FL', 'PORT ST. LUCIE, FL', 'PUNTA GORDA, FL'])                                => 0.003015,
    ((string)MSA_NAME in ['SARASOTA-BRADENTON-VENICE, FL', 'SEBASTIAN-VERO BEACH, FL', 'TALLAHASSEE, FL', 'TAMPA-ST. PETERSBURG-CLEARWATER, FL'])                                                                                                                                                                                                                                                                                                                                                                                      => 0.003015,
    ((string)MSA_NAME in ['ABILENE, TX', 'AL NONMETROPOLITAN AREA', 'ALBANY, GA', 'ALBUQUERQUE, NM', 'ALEXANDRIA, LA', 'AMARILLO, TX', 'ANNISTON-OXFORD, AL', 'AR NONMETROPOLITAN AREA', 'ATHENS-CLARK COUNTY, GA', 'ATLANTA-SANDY SPRINGS-MARIETTA, GA', 'AUBURN-OPELIKA, AL', 'AUGUSTA-RICHMOND COUNTY,GA-SC', 'AUSTIN-ROUND ROCK, TX', 'AZ NONMETROPOLITAN AREA', 'BALTIMORE-TOWSON, MD', 'BATON ROUGE, LA', 'BEAUMONT-PORT ARTHUR, TX', 'BIRMINGHAM-HOOVER, AL', 'BLACKSBURG-CHRISTIANSBURG DFORD, VA'])                           => -0.048792,
    ((string)MSA_NAME in ['BOWLING GREEN, KY', 'BROWNSVILLE-HARLINGEN, TX', 'BRUNSWICK, GA', 'CHARLESTON, WV', 'CHARLOTTESVILLE, VA', 'CHATTANOOGA, TN-GA', 'CLARKSVILLE, TN-KY', 'CLEVELAND, TN', 'COLLEGE STATION-BRYAN, TX', 'COLUMBIA, MO', 'COLUMBUS, GA-AL', 'CORPUS CHRISTI, TX', 'CUMBERLAND, MD-WV', 'DALLAS-FORT WORTH-ARLINGTON,TX', 'DALTON, GA', 'DANVILLE, VA', 'DECATUR, AL', 'DOTHAN, AL', 'DOVER, DE', 'EL PASO, TX', 'ELIZABETHTOWN, KY', 'FARMINGTON, NM'])                                                         => -0.048792,
    ((string)MSA_NAME in ['FAYETTEVILLE-SPRINGDALE-ROGERS, AR-MO', 'FLAGSTAFF, AZ', 'FLORENCE-MUSCLE SHOALS, AL', 'FORT SMITH, AR-OK', 'GA NONMETROPOLITAN AREA', 'GADSDEN, AL', 'GAINESVILLE, GA', 'GULFPORT-BILOXI, MS', 'HAGERSTOWN-MARTINSBURG, MD-WV', 'HARRISONBURG, VA', 'HATTIESBURG, MS', 'HINESVILLE-FORT STEWART,GA', 'HOT SPRINGS, AR', 'HOUMA-BAYOU CANE-THIBODAUX,LA', 'HOUSTON-SUGAR LAND-BAYTOWN,TX', 'HUNTINGTON-ASHLAND, WV-KY', 'HUNTSVILLE, AL', 'JACKSON, MS', 'JACKSON, TN'])                                    => -0.048792,
    ((string)MSA_NAME in ['JEFFERSON CITY, MO', 'JOHNSON CITY, TN', 'JONESBORO, AR', 'JOPLIN, MO', 'KANSAS CITY, MO-KS', 'KILLEEN-TEMPLE-FORT HOOD,TX', 'KINGSPORT-BRISTOL-BRISTOL, TN-VA', 'KNOXVILLE, TN', 'LA NONMETROPOLITAN AREA', 'LAFAYETTE, LA', 'LAKE CHARLES, LA', 'LAKE HAVASU CITY-KINGMAN,AZ', 'LAREDO, TX', 'LAS CRUCES, NM', 'LAWRENCE, KS', 'LAWTON, OK', 'LEXINGTON-FAYETTE, KY', 'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR', 'LONGVIEW, TX', 'LOUISVILLE/JEFFERSON COUNTY,KY-IN'])                                    => -0.048792,
    ((string)MSA_NAME in ['LUBBOCK, TX', 'LYNCHBURG, VA', 'MACON, GA', 'MANHATTAN, KS', 'MCALLEN-EDINBURG-MISSION,TX', 'MEMPHIS, TN-AR-MS', 'MIDLAND, TX', 'MOBILE, AL', 'MONROE, LA', 'MONTGOMERY, AL', 'MORGANTOWN, WV', 'MORRISTOWN, TN', 'MS NONMETROPOLITAN AREA', 'NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN', 'NEW ORLEANS-METAIRIE-KENNER,LA', 'NM NONMETROPOLITAN AREA', 'ODESSA, TX', 'OK NONMETROPOLITAN AREA', 'OKLAHOMA CITY, OK', 'OWENSBORO, KY', 'PASCAGOULA, MS'])                                                 => -0.048792,
    ((string)MSA_NAME in ['PHOENIX-MESA-SCOTTSDALE,AZ', 'PINE BLUFF, AR', 'PRESCOTT, AZ', 'RICHMOND, VA', 'ROANOKE, VA', 'ROME, GA', 'SALISBURY, MD', 'SAN ANGELO, TX', 'SAN ANTONIO, TX', 'SANTA FE, NM', 'SAVANNAH, GA', 'SHERMAN-DENISON, TX', 'SHREVEPORT-BOSSIER CITY,LA', 'SPRINGFIELD, MO', 'ST. JOSEPH, MO-KS', 'TEXARKANA, TX-TEXARKANA,AR', 'TOPEKA, KS', 'TUCSON, AZ', 'TULSA, OK', 'TUSCALOOSA, AL', 'TX NONMETROPOLITAN AREA', 'TYLER, TX', 'VA NONMETROPOLITAN AREA'])                                                   => -0.048792,
    ((string)MSA_NAME in ['VALDOSTA, GA', 'VICTORIA, TX', 'WACO, TX', 'WARNER ROBINS, GA', 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV', 'WICHITA FALLS, TX', 'WICHITA, KS', 'WINCHESTER, VA-WV', 'YUMA, AZ'])                                                                                                                                                                                                                                                                                                                       => -0.048792,
    ((string)MSA_NAME in ['BAKERSFIELD, CA', 'CHICO, CA', 'LOS ANGELES-LONG BEACH-SANTAANA, CA', 'MODESTO, CA', 'REDDING, CA', 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA', 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA', 'SALINAS, CA', 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA', 'STOCKTON, CA', 'VALLEJO-FAIRFIELD, CA', 'YUBA CITY, CA'])                                                                                                                                                                                                         => -0.011396,
    ((string)MSA_NAME in ['ALBANY-SCHENECTADY-TROY,NY', 'ALLENTOWN-BETHLEHEM-EASTON,PA-NJ', 'ATLANTIC CITY, NJ', 'BANGOR, ME', 'BARNSTABLE TOWN, MA', 'BINGHAMTON, NY', 'BOSTON-CAMBRIDGE-QUINCY,MA-NH', 'BRIDGEPORT-STAMFORD-NORWALK,CT', 'BUFFALO-NIAGARA FALLS, NY', 'BURLINGTON-SOUTH BURLINGTON,VT', 'CT NONMETROPOLITAN AREA', 'DE NONMETROPOLITAN AREA', 'ELMIRA, NY', 'GLENS FALLS, NY', 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT', 'ITHACA, NY', 'KINGSTON, NY', 'LEWISTON-AUBURN, ME', 'MA NONMETROPOLITAN AREA'])           => 0.071338,
    ((string)MSA_NAME in ['MANCHESTER-NASHUA, NH', 'MD NONMETROPOLITAN AREA', 'ME NONMETROPOLITAN AREA', 'NEW HAVEN-MILFORD, CT', 'NEW YORK-NORTHERN NEW JERSEY', 'NH NONMETROPOLITAN AREA', 'NORWICH-NEW LONDON, CT', 'NY NONMETROPOLITAN AREA', 'OCEAN CITY, NJ', 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD', 'PITTSFIELD, MA', 'PORTLAND-SOUTH PORTLAND-BIDDEFORD, ME', 'POUGHKEEPSIE-NEWBURGH-MIDDLETOWN, NY', 'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA', 'ROCHESTER, NY', 'SPRINGFIELD, MA'])                                  => 0.071338,
    ((string)MSA_NAME in ['SYRACUSE, NY', 'TRENTON-EWING, NJ', 'UTICA-ROME, NY', 'VINELAND-MILLVILLE-BRIDGETON, NJ', 'VT NONMETROPOLITAN AREA', 'WORCESTER, MA', 'YORK-NORTHERN NEW JERSEY-LONG ISLAND, NY-NJ-PA'])                                                                                                                                                                                                                                                                                                                    => 0.071338,
    ((string)MSA_NAME in ['AKRON, OH', 'AMES, IA', 'ANDERSON, IN', 'ANN ARBOR, MI', 'APPLETON, WI', 'BATTLE CREEK, MI', 'BAY CITY, MI', 'BISMARCK, ND', 'BLOOMINGTON, IN', 'BLOOMINGTON-NORMAL, IL', 'CANTON-MASSILLON, OH', 'CAPE GIRARDEAU-JACKSON, MO-IL', 'CEDAR RAPIDS, IA', 'CHAMPAIGN-URBANA, IL', 'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI', 'CINCINNATI-MIDDLETOWN, OH', 'CLEVELAND-ELYRIA-MENTOR,OH', 'COLUMBUS, IN', 'COLUMBUS, OH', 'DANVILLE, IL', 'DAVENPORT-MOLINE-ROCK ISLAND, IA-IL', 'DAYTON, OH'])                      => -0.084387,
    ((string)MSA_NAME in ['DECATUR, IL', 'DES MOINES-WEST DES MOINES,IA', 'DETROIT-WARREN-LIVONIA, MI', 'DUBUQUE, IA', 'DULUTH, MN-WI', 'EAU CLAIRE, WI', 'ELKHART-GOSHEN, IN', 'EVANSVILLE, IN-KY', 'FARGO, ND-MN', 'FLINT, MI', 'FOND DU LAC, WI', 'FORT WAYNE, IN', 'GRAND FORKS, ND-MN', 'GRAND RAPIDS-WYOMING, MI', 'GREEN BAY, WI', 'HOLLAND-GRAND HAVEN, MI', 'IA NONMETROPOLITAN AREA', 'IL NONMETROPOLITAN AREA', 'IN NONMETROPOLITAN AREA', 'INDIANAPOLIS-CARMEL, IN', 'IOWA CITY, IA', 'JACKSON, MI'])                      => -0.084387,
    ((string)MSA_NAME in ['JANESVILLE, WI', 'KALAMAZOO-PORTAGE, MI', 'KANKAKEE-BRADLEY, IL', 'KOKOMO, IN', 'KS NONMETROPOLITAN AREA', 'KY NONMETROPOLITAN AREA', 'LA CROSSE, WI-MN', 'LAFAYETTE, IN', 'LANSING-EAST LANSING, MI', 'LIMA, OH', 'LINCOLN, NE', 'MADISON, WI', 'MANKATO-NORTH MANKATO, MN', 'MANSFIELD, OH', 'MI NONMETROPOLITAN AREA', 'MICHIGAN CITY-LA PORTE, IN', 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI', 'MINNEAPOLIS-ST. PAUL-BLOOMINGTON, MN-WI', 'MN NONMETROPOLITAN AREA'])                                         => -0.084387,
    ((string)MSA_NAME in ['MO NONMETROPOLITAN AREA', 'MONROE, MI', 'MUNCIE, IN', 'MUSKEGON-NORTON SHORES, MI', 'ND NONMETROPOLITAN AREA', 'NE NONMETROPOLITAN AREA', 'NILES-BENTON HARBOR, MI', 'OH NONMETROPOLITAN AREA', 'OMAHA-COUNCIL BLUFFS, NE-IA', 'OSHKOSH-NEENAH, WI', 'PARKERSBURG-MARIETTA-VIENNA,WV-OH', 'PEORIA, IL', 'RACINE, WI', 'RAPID CITY, SD', 'ROCHESTER, MN', 'ROCKFORD, IL', 'SAGINAW-SAGINAW TOWNSHIPNORTH, MI', 'SANDUSKY, OH', 'SD NONMETROPOLITAN AREA', 'SHEBOYGAN, WI'])                                  => -0.084387,
    ((string)MSA_NAME in ['SIOUX CITY, IA-NE-SD', 'SIOUX FALLS, SD', 'SOUTH BEND-MISHAWAKA, IN-MI', 'SPRINGFIELD, IL', 'SPRINGFIELD, OH', 'ST. CLOUD, MN', 'ST. LOUIS, MO-IL', 'TERRE HAUTE, IN', 'TN NONMETROPOLITAN AREA', 'TOLEDO, OH', 'WATERLOO-CEDAR FALLS, IA', 'WAUSAU, WI', 'WEIRTON-STEUBENVILLE, WV-OH', 'WHEELING, WV-OH', 'WI NONMETROPOLITAN AREA', 'WV NONMETROPOLITAN AREA', 'YOUNGSTOWN-WARREN-BOARDMAN,OH-PA'])                                                                                                      => -0.084387,
    ((string)MSA_NAME in ['BELLINGHAM, WA', 'BOISE CITY-NAMPA, ID', 'BREMERTON-SILVERDALE, WA', 'CARSON CITY, NV', 'CASPER, WY', 'CHEYENNE, WY', 'COEUR DALENE, ID', 'EL CENTRO, CA', 'FRESNO, CA', 'HANFORD-CORCORAN, CA', 'IDAHO FALLS, ID', 'KENNEWICK-RICHLAND-PASCO,WA', 'LAS VEGAS-PARADISE, NV', 'LEWISTON, ID-WA', 'LOGAN, UT-ID', 'LONGVIEW, WA', 'MADERA, CA', 'MERCED, CA', 'MOUNT VERNON-ANACORTES, WA', 'NAPA, CA', 'NV NONMETROPOLITAN AREA', 'OGDEN-CLEARFIELD, UT', 'OLYMPIA, WA'])                                    => 0.044603,
    ((string)MSA_NAME in ['OXNARD-THOUSAND OAKS-VENTURA, CA', 'POCATELLO, ID', 'PROVO-OREM, UT', 'RENO-SPARKS, NV', 'SALT LAKE CITY, UT', 'SAN FRANCISCO-OAKLAND-FREMONT, CA', 'SAN JOSE-SUNNYVALE-SANTACLARA, CA', 'SAN LUIS OBISPO-PASO ROBLES,CA', 'SANTA BARBARA-SANTA MARIA LETA, CA', 'SANTA CRUZ-WATSONVILLE, CA', 'SANTA ROSA-PETALUMA, CA', 'SEATTLE-TACOMA-BELLEVUE,WA', 'SPOKANE, WA', 'ST. GEORGE, UT', 'UT NONMETROPOLITAN AREA', 'VISALIA-PORTERVILLE, CA'])                                                             => 0.044603,
    ((string)MSA_NAME in ['WA NONMETROPOLITAN AREA', 'WENATCHEE, WA', 'WY NONMETROPOLITAN AREA', 'YAKIMA, WA'])                                                                                                                                                                                                                                                                                                                                                                                                                        => 0.044603,
    ((string)MSA_NAME in ['ALTOONA, PA', 'ERIE, PA', 'HARRISBURG-CARLISLE, PA', 'JOHNSTOWN, PA', 'LANCASTER, PA', 'LEBANON, PA', 'PA NONMETROPOLITAN AREA', 'PITTSBURGH, PA', 'READING, PA', 'SCRANTON--WILKES-BARRE, PA', 'STATE COLLEGE, PA', 'WILLIAMSPORT, PA', 'YORK-HANOVER, PA'])                                                                                                                                                                                                                                               => 0.297949,
    ((string)MSA_NAME in ['BEND, OR', 'BILLINGS, MT', 'BOULDER, CO', 'CA NONMETROPOLITAN AREA', 'CO NONMETROPOLITAN AREA', 'COLORADO SPRINGS, CO', 'CORVALIS, OR', 'DENVER-AURORA, CO', 'EUGENE-SPRINGFIELD, OR', 'FORT COLLINS-LOVELAND, CO', 'GRAND JUNCTION, CO', 'GREAT FALLS, MT', 'GREELEY, CO', 'ID NONMETROPOLITAN AREA', 'MEDFORD, OR', 'MISSOULA, MT', 'MT NONMETROPOLITAN AREA', 'OR NONMETROPOLITAN AREA', 'PORTLAND-VANCOUVER-BEAVERTON, OR-WA', 'PUEBLO, CO', 'SALEM, OR'])                                              => 0.266916,
    ((string)MSA_NAME in ['AGUADILLA-ISABELA-SAN SEBASTIAN, PR', 'AK NONMETROPOLITAN AREA', 'ALL OTHER TERRITORIES ANDFOREIGN COUNTRIES', 'ANCHORAGE, AK', 'ARMED FORCES', 'FAIRBANKS, AK', 'GUAYAMA, PR', 'HI NONMETROPOLITAN AREA', 'HONOLULU, HI', 'MAYAGUEZ, PR', 'PONCE, PR', 'PR NONMETROPOLITAN AREA', 'SAN GERMAN-CABO ROJO, PR', 'SAN JUAN-CAGUAS-GUAYNABO,PR', 'VI NONMETROPOLITAN AREA', 'YAUCO, PR'])                                                                                                                      => 0.635964,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  -0.000000);

drg_subscore13 := map(
    NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => 0.040437,
    3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 25  => -0.358003,
    25 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 61 => -0.152137,
    61 <= iv_de001_eviction_recency                                    => 0.078115,
                                                                          0.000000);

drg_subscore14 := map(
    (iv_ams_college_tier in [' '])           => 0.000000,
    (iv_ams_college_tier in ['-1'])          => -0.022483,
    (iv_ams_college_tier in ['1'])           => 1.495571,
    (iv_ams_college_tier in ['2'])           => 0.935557,
    (iv_ams_college_tier in ['0', '3', '4']) => 0.443262,
    (iv_ams_college_tier in ['5'])           => 0.108889,
    (iv_ams_college_tier in ['6'])           => 0.086405,
                                                0.000000);

drg_subscore15 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => 0.068176,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 10  => -0.148187,
    10 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 79 => -0.092911,
    79 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 94 => 0.033619,
    94 <= iv_mos_since_gong_did_fst_seen                                         => 0.193748,
                                                                                    0.000000);

drg_subscore16 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.054036,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.048254,
    3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => -0.191390,
    5 <= iv_ms001_ssns_per_adl                                 => -0.353379,
                                                                  0.000000);

drg_subscore17 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 1         => -0.005443,
    1 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 8250        => -0.248508,
    8250 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 33880    => -0.096043,
    33880 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 105260  => 0.009434,
    105260 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 286300 => 0.064952,
    286300 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 363700 => 0.153983,
    363700 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 493370 => 0.251713,
    493370 <= iv_bst_addr_assessed_total_val                                             => 0.271364,
                                                                                            -0.000000);

drg_subscore18 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen < 0  => -0.023601,
    0 <= iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen < 41   => 0.145290,
    41 <= iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen < 124 => 0.231117,
    124 <= iv_mos_since_paw_first_seen                                      => 0.447045,
                                                                               0.000000);

drg_subscore19 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff < 0.88 => -0.141392,
    0.88 <= iv_bst_addr_mtg_avm_pct_diff                                        => 0.075353,
                                                                                   0.000000);

drg_rawscore := drg_subscore0 +
    drg_subscore1 +
    drg_subscore2 +
    drg_subscore3 +
    drg_subscore4 +
    drg_subscore5 +
    drg_subscore6 +
    drg_subscore7 +
    drg_subscore8 +
    drg_subscore9 +
    drg_subscore10 +
    drg_subscore11 +
    drg_subscore12 +
    drg_subscore13 +
    drg_subscore14 +
    drg_subscore15 +
    drg_subscore16 +
    drg_subscore17 +
    drg_subscore18 +
    drg_subscore19;

drg_lnoddsscore := drg_rawscore + 1.660718;

drg_probscore := exp(drg_lnoddsscore) / (1 + exp(drg_lnoddsscore));

iv_vs002_ssn_prior_dob := map(
    not((integer)ssnlength > 0 and dobpop)            => ' ',
    rc_ssndobflag = '1' or rc_pwssndobflag = '1' => '1',
    rc_ssndobflag = '0' or rc_pwssndobflag = '0' => '0',
                                                ' ');

iv_vp007_phn_pcs := map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => ' ',
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => '1',
                                                                                                                                                                                                                                                                                                                                                                               '0');

iv_va060_dist_add_in_bst := map(
    not(truedid)       => NULL,
    add1_isbestmatch   => 0,
    dist_a1toa2 = 9999 => NULL,
                          dist_a1toa2);

_header_first_seen := common.sas_date((string)(header_first_seen));

iv_sr001_m_hdr_fs := map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1);

iv_mi001_adlperssn_count := map(
    not((integer)ssnlength > 0)  => NULL,
    adlperssn_count = 0 => 1,
                           adlperssn_count);

_in_dob := common.sas_date1800s((string)(in_dob));

// yr_in_dob := if((string)in_dob = '', -1, (sysdate - _in_dob) / 365.25);
 // yr_in_dob := if( min(sysdate, _in_dob) = NULL , NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob := map( in_dob[1..2]='18' =>NULL,
									in_dob = '0' => NULL, 
                  in_dob = ' ' => -1,
																	(sysdate - _in_dob) / 365.25);



yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

age_estimate := map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1);

iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

iv_pl002_addrs_per_ssn_c6 := if(not((integer)ssnlength > 0), NULL, addrs_per_ssn_c6);

iv_inp_addr_assessed_total_val := if(not(add1_pop), NULL, add1_assessed_total_value);

iv_max_ids_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    (string)iv_add_apt = '1' => -1,
                        max(adls_per_addr, ssns_per_addr));

iv_pl_addrs_per_adl := if(not(truedid), NULL, pl_addrs_per_adl);

_infutor_first_seen := common.sas_date((string)(infutor_first_seen));

iv_mos_since_infutor_first_seen := map(
    not(hphnpop)                    => NULL,
    not(_infutor_first_seen = NULL) => if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))),
                                       -1);

sum_dols := if(max(pb_offline_dollars, pb_online_dollars, pb_retail_dollars) = ' ', NULL, sum(if(pb_offline_dollars = ' ', 0, (integer)pb_offline_dollars), if(pb_online_dollars = ' ', 0, (integer)pb_online_dollars), if(pb_retail_dollars = ' ', 0, (integer)pb_retail_dollars)));

pct_offline_dols := if((real)sum_dols > 0, (real)pb_offline_dollars / (real)sum_dols, -1);

pct_retail_dols := if((real)sum_dols > 0, (real)pb_retail_dollars /(real) sum_dols, -1);

pct_online_dols := if((real)sum_dols > 0, (real)pb_online_dollars / (real)sum_dols, -1);

iv_pb_profile := map(
    not(truedid)                => '                 ',
    pb_number_of_sources = ' ' => '0 No Purch Data  ',
    pct_offline_dols > .50      => '1 Offline Shopper',
    pct_online_dols > .50       => '2 Online Shopper ',
    pct_retail_dols > .50       => '3 Retail Shopper ',
                                   '4 Other');

yng_subscore0 := map(
    NULL < iv_ag001_age AND iv_ag001_age < 23 => -0.544152,
    23 <= iv_ag001_age AND iv_ag001_age < 24  => -0.052589,
    24 <= iv_ag001_age AND iv_ag001_age < 25  => 0.119791,
    25 <= iv_ag001_age                        => 0.522169,
                                                 0.000000);

yng_subscore1 := map(
    (iv_inp_own_prop_x_addr_naprop in [' '])                    => -0.000000,
    (iv_inp_own_prop_x_addr_naprop in ['01'])                   => -0.155447,
    (iv_inp_own_prop_x_addr_naprop in ['00', '02'])             => -0.091089,
    (iv_inp_own_prop_x_addr_naprop in ['10', '11', '12', '13']) => 0.182602,
    (iv_inp_own_prop_x_addr_naprop in ['03', '04'])             => 0.361516,
    (iv_inp_own_prop_x_addr_naprop in ['14'])                   => 0.437535,
                                                                   -0.000000);

yng_subscore2 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 46  => 0.163404,
    46 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 69   => 0.004531,
    69 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 106  => -0.208240,
    106 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 133 => -0.391444,
    133 <= iv_sr001_m_hdr_fs                             => -0.509621,
                                                            0.000000);

yng_subscore3 := map(
    NULL < iv_pl002_addrs_per_ssn_c6 AND iv_pl002_addrs_per_ssn_c6 < 1 => -0.054537,
    1 <= iv_pl002_addrs_per_ssn_c6                                     => 0.698601,
                                                                          0.000000);

yng_subscore4 := map(
    NULL < iv_inq_auto_recency AND iv_inq_auto_recency < 1 => 0.047039,
    1 <= iv_inq_auto_recency AND iv_inq_auto_recency < 6   => -0.940282,
    6 <= iv_inq_auto_recency                               => -0.717538,
                                                              0.000000);

yng_subscore5 := map(
    (iv_ams_college_tier in [' '])      => -0.000000,
    (iv_ams_college_tier in ['-1'])     => -0.043150,
    (iv_ams_college_tier in ['1'])      => 1.953654,
    (iv_ams_college_tier in ['2'])      => 1.304727,
    (iv_ams_college_tier in ['3'])      => 0.833166,
    (iv_ams_college_tier in ['0', '4']) => 0.275650,
    (iv_ams_college_tier in ['5', '6']) => -0.044192,
                                           -0.000000);

yng_subscore6 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0', '0-1', '1-0', '1-1', '1-3', '2-0', '2-1']) => -0.091940,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-1', '3-3'])                            => 0.107684,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                                 => 0.611127,
                                                                                                 0.000000);

yng_subscore7 := map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 1  => 0.078239,
    1 <= iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 57   => -0.314750,
    57 <= iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 723 => 0.012047,
    723 <= iv_va060_dist_add_in_bst                                   => 0.068802,
                                                                         0.000000);

yng_subscore8 := map(
    NULL < iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 0 => 0.113458,
    0 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 1   => -0.017476,
    1 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 5   => 0.245137,
    5 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 8   => 0.153992,
    8 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 18  => -0.008731,
    18 <= iv_max_ids_per_sfd_addr AND iv_max_ids_per_sfd_addr < 24 => -0.157186,
    24 <= iv_max_ids_per_sfd_addr                                  => -0.220956,
                                                                      0.000000);

yng_subscore9 := map(
    (iv_vs002_ssn_prior_dob in [' ']) => -0.445274,
    (iv_vs002_ssn_prior_dob in ['0']) => 0.032595,
    (iv_vs002_ssn_prior_dob in ['1']) => -0.801462,
                                         -0.000000);

yng_subscore10 := map(
    NULL < iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 1         => -0.001273,
    1 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 16378       => -0.271037,
    16378 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 40952   => -0.176619,
    40952 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 121364  => -0.074241,
    121364 <= iv_inp_addr_assessed_total_val AND iv_inp_addr_assessed_total_val < 327396 => 0.111281,
    327396 <= iv_inp_addr_assessed_total_val                                             => 0.287605,
                                                                                            0.000000);

yng_subscore11 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => 0.058939,
    2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 3   => -0.096095,
    3 <= iv_mi001_adlperssn_count                                    => -0.371851,
                                                                        0.000000);

yng_subscore12 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999   => -0.071098,
    19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 36000 => -0.037788,
    36000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 39000 => 0.175955,
    39000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 74000 => 0.310789,
    74000 <= iv_in001_estimated_income                                       => 0.503708,
                                                                                0.000000);

yng_subscore13 := map(
    (MSA_NAME in [' '])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             => 0.000000,
    (MSA_NAME in ['AGUADILLA-ISABELA-SAN SEBASTIAN, PR', 'ALBANY-SCHENECTADY-TROY,NY', 'ALTOONA, PA', 'ATLANTIC CITY, NJ', 'BANGOR, ME', 'BRIDGEPORT-STAMFORD-NORWALK,CT', 'BURLINGTON-SOUTH BURLINGTON,VT', 'ERIE, PA', 'FAJARDO, PR', 'GLENS FALLS, NY', 'GU NONMETROPOLITAN AREA', 'GUAYAMA, PR', 'HARRISBURG-CARLISLE, PA', 'KINGSTON, NY', 'LANCASTER, PA', 'MAYAGUEZ, PR', 'ME NONMETROPOLITAN AREA', 'OCEAN CITY, NJ', 'PONCE, PR', 'PORTLAND-SOUTH PORTLAND-BIDDEFORD, ME', 'PR NONMETROPOLITAN AREA'])     => -0.145091,
    (MSA_NAME in ['PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA', 'READING, PA', 'ROCHESTER, NY', 'SAN GERMAN-CABO ROJO, PR', 'SAN JUAN-CAGUAS-GUAYNABO,PR', 'VI NONMETROPOLITAN AREA', 'VINELAND-MILLVILLE-BRIDGETON, NJ', 'VT NONMETROPOLITAN AREA', 'YAUCO, PR'])                                                                                                                                                                                                                                                     => -0.145091,
    (MSA_NAME in ['BAKERSFIELD, CA', 'CA NONMETROPOLITAN AREA', 'CASPER, WY', 'CHEYENNE, WY', 'COEUR DALENE, ID', 'EL CENTRO, CA', 'FRESNO, CA', 'HANFORD-CORCORAN, CA', 'IDAHO FALLS, ID', 'LOGAN, UT-ID', 'MERCED, CA', 'MODESTO, CA', 'MT NONMETROPOLITAN AREA', 'NAPA, CA', 'OGDEN-CLEARFIELD, UT', 'OXNARD-THOUSAND OAKS-VENTURA, CA', 'POCATELLO, ID', 'PROVO-OREM, UT', 'RENO-SPARKS, NV', 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA', 'SALINAS, CA', 'SALT LAKE CITY, UT', 'SANTA ROSA-PETALUMA, CA'])          => -0.097399,
    (MSA_NAME in ['ST. GEORGE, UT', 'STOCKTON, CA', 'UT NONMETROPOLITAN AREA', 'VISALIA-PORTERVILLE, CA', 'WY NONMETROPOLITAN AREA'])                                                                                                                                                                                                                                                                                                                                                                               => -0.097399,
    (MSA_NAME in ['ABILENE, TX', 'AL NONMETROPOLITAN AREA', 'ALBANY, GA', 'ALBUQUERQUE, NM', 'ALEXANDRIA, LA', 'AMARILLO, TX', 'ANDERSON, SC', 'ANNISTON-OXFORD, AL', 'AR NONMETROPOLITAN AREA', 'ASHEVILLE, NC', 'ATHENS-CLARK COUNTY, GA', 'ATLANTA-SANDY SPRINGS-MARIETTA, GA', 'AUBURN-OPELIKA, AL', 'AUGUSTA-RICHMOND COUNTY,GA-SC', 'AUSTIN-ROUND ROCK, TX', 'AZ NONMETROPOLITAN AREA', 'BALTIMORE-TOWSON, MD', 'BATON ROUGE, LA', 'BEAUMONT-PORT ARTHUR, TX', 'BIRMINGHAM-HOOVER, AL'])                      => -0.086996,
    (MSA_NAME in ['BOWLING GREEN, KY', 'BROWNSVILLE-HARLINGEN, TX', 'BRUNSWICK, GA', 'BURLINGTON, NC', 'CAPE CORAL-FORT MYERS, FL', 'CARSON CITY, NV', 'CHARLESTON, WV', 'CHARLESTON-NORTH CHARLESTON,SC', 'CHARLOTTE-GASTONIA-CONCORD,NC-SC', 'CHATTANOOGA, TN-GA', 'CLARKSVILLE, TN-KY', 'CLEVELAND, TN', 'COLLEGE STATION-BRYAN, TX', 'COLUMBIA, SC', 'COLUMBUS, GA-AL', 'CORPUS CHRISTI, TX', 'CUMBERLAND, MD-WV', 'DALLAS-FORT WORTH-ARLINGTON,TX', 'DALTON, GA', 'DANVILLE, VA'])                             => -0.086996,
    (MSA_NAME in ['DE NONMETROPOLITAN AREA', 'DECATUR, AL', 'DELTONA-DAYTONA BEACH-ORMONDBEACH, FL', 'DOTHAN, AL', 'DOVER, DE', 'DURHAM, NC', 'EL PASO, TX', 'ELIZABETHTOWN, KY', 'FARMINGTON, NM', 'FAYETTEVILLE, NC', 'FL NONMETROPOLITAN AREA', 'FLAGSTAFF, AZ', 'FLORENCE, SC', 'FLORENCE-MUSCLE SHOALS, AL', 'FORT SMITH, AR-OK', 'FORT WALTON BEACH-CRESTVIEW-DESTIN, FL', 'GA NONMETROPOLITAN AREA', 'GADSDEN, AL', 'GAINESVILLE, FL', 'GAINESVILLE, GA', 'GOLDSBORO, NC'])                                  => -0.086996,
    (MSA_NAME in ['GREENSBORO-HIGH POINT, NC', 'GREENVILLE, NC', 'GREENVILLE-MAULDIN-EASLEY, SC', 'GULFPORT-BILOXI, MS', 'HAGERSTOWN-MARTINSBURG, MD-WV', 'HARRISONBURG, VA', 'HATTIESBURG, MS', 'HICKORY-LENOIR-MORGANTON,NC', 'HINESVILLE-FORT STEWART,GA', 'HOT SPRINGS, AR', 'HOUMA-BAYOU CANE-THIBODAUX,LA', 'HOUSTON-SUGAR LAND-BAYTOWN,TX', 'HUNTINGTON-ASHLAND, WV-KY', 'HUNTSVILLE, AL', 'JACKSON, MS', 'JACKSON, TN', 'JACKSONVILLE, FL', 'JACKSONVILLE, NC', 'JOHNSON CITY, TN'])                        => -0.086996,
    (MSA_NAME in ['JONESBORO, AR', 'KILLEEN-TEMPLE-FORT HOOD,TX', 'KNOXVILLE, TN', 'LA NONMETROPOLITAN AREA', 'LAFAYETTE, LA', 'LAKE CHARLES, LA', 'LAKE HAVASU CITY-KINGMAN,AZ', 'LAKELAND, FL', 'LAREDO, TX', 'LAS CRUCES, NM', 'LAS VEGAS-PARADISE, NV', 'LAWTON, OK', 'LEXINGTON-FAYETTE, KY', 'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR', 'LONGVIEW, TX', 'LUBBOCK, TX', 'LYNCHBURG, VA', 'MACON, GA', 'MCALLEN-EDINBURG-MISSION,TX', 'MD NONMETROPOLITAN AREA', 'MEMPHIS, TN-AR-MS'])                          => -0.086996,
    (MSA_NAME in ['MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL', 'MIDLAND, TX', 'MOBILE, AL', 'MONROE, LA', 'MONTGOMERY, AL', 'MORGANTOWN, WV', 'MORRISTOWN, TN', 'MS NONMETROPOLITAN AREA', 'MYRTLE BEACH-CONWAY-NORTHMYRTLE BEACH, SC', 'NAPLES-MARCO ISLAND, FL', 'NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN', 'NC NONMETROPOLITAN AREA', 'NEW ORLEANS-METAIRIE-KENNER,LA', 'NM NONMETROPOLITAN AREA', 'NV NONMETROPOLITAN AREA', 'OCALA, FL', 'ODESSA, TX', 'OK NONMETROPOLITAN AREA'])                          => -0.086996,
    (MSA_NAME in ['OKLAHOMA CITY, OK', 'ORLANDO-KISSIMMEE, FL', 'OWENSBORO, KY', 'PALM BAY-MELBOURNE-TITUSVILLE, FL', 'PALM COAST, FL', 'PANAMA CITY-LYNN HAVEN, FL', 'PASCAGOULA, MS', 'PENSACOLA-FERRY PASS-BRENT,FL', 'PHOENIX-MESA-SCOTTSDALE,AZ', 'PINE BLUFF, AR', 'PORT ST. LUCIE, FL', 'PRESCOTT, AZ', 'PUNTA GORDA, FL', 'RALEIGH-CARY, NC', 'ROANOKE, VA', 'ROCKY MOUNT, NC', 'ROME, GA', 'SALISBURY, MD', 'SAN ANGELO, TX', 'SAN ANTONIO, TX', 'SANTA FE, NM'])                                          => -0.086996,
    (MSA_NAME in ['SARASOTA-BRADENTON-VENICE, FL', 'SAVANNAH, GA', 'SC NONMETROPOLITAN AREA', 'SEBASTIAN-VERO BEACH, FL', 'SHERMAN-DENISON, TX', 'SHREVEPORT-BOSSIER CITY,LA', 'SPARTANBURG, SC', 'SUMTER, SC', 'TALLAHASSEE, FL', 'TAMPA-ST. PETERSBURG-CLEARWATER, FL', 'TEXARKANA, TX-TEXARKANA,AR', 'TN NONMETROPOLITAN AREA', 'TOPEKA, KS', 'TUCSON, AZ', 'TULSA, OK', 'TUSCALOOSA, AL', 'TX NONMETROPOLITAN AREA', 'TYLER, TX', 'VALDOSTA, GA', 'VICTORIA, TX'])                                              => -0.086996,
    (MSA_NAME in ['VIRGINIA BEACH-NORFOLK-NEWPORT NEWS, VA-NC', 'WACO, TX', 'WARNER ROBINS, GA', 'WICHITA FALLS, TX', 'WILMINGTON, NC', 'WINSTON-SALEM, NC', 'WV NONMETROPOLITAN AREA', 'YUMA, AZ'])                                                                                                                                                                                                                                                                                                                => -0.086996,
    (MSA_NAME in ['ANN ARBOR, MI', 'BATTLE CREEK, MI', 'BAY CITY, MI', 'BLOOMINGTON-NORMAL, IL', 'CAPE GIRARDEAU-JACKSON, MO-IL', 'CHAMPAIGN-URBANA, IL', 'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI', 'DANVILLE, IL', 'DECATUR, IL', 'DETROIT-WARREN-LIVONIA, MI', 'FLINT, MI', 'GRAND RAPIDS-WYOMING, MI', 'HOLLAND-GRAND HAVEN, MI', 'IN NONMETROPOLITAN AREA', 'JACKSON, MI', 'KALAMAZOO-PORTAGE, MI', 'KANKAKEE-BRADLEY, IL', 'LANSING-EAST LANSING, MI', 'MONROE, MI', 'MUSKEGON-NORTON SHORES, MI'])               => 0.027658,
    (MSA_NAME in ['NILES-BENTON HARBOR, MI', 'PEORIA, IL', 'ROCKFORD, IL', 'SAGINAW-SAGINAW TOWNSHIPNORTH, MI', 'SPRINGFIELD, IL', 'ST. LOUIS, MO-IL'])                                                                                                                                                                                                                                                                                                                                                             => 0.027658,
    (MSA_NAME in ['NEW YORK-NORTHERN NEW JERSEY', 'NY NONMETROPOLITAN AREA'])                                                                                                                                                                                                                                                                                                                                                                                                                                       => -0.025261,
    (MSA_NAME in ['AKRON, OH', 'AMES, IA', 'ANDERSON, IN', 'APPLETON, WI', 'BISMARCK, ND', 'BLOOMINGTON, IN', 'CANTON-MASSILLON, OH', 'CEDAR RAPIDS, IA', 'CINCINNATI-MIDDLETOWN, OH', 'CLEVELAND-ELYRIA-MENTOR,OH', 'COLUMBUS, IN', 'COLUMBUS, OH', 'DAVENPORT-MOLINE-ROCK ISLAND, IA-IL', 'DAYTON, OH', 'DES MOINES-WEST DES MOINES,IA', 'DUBUQUE, IA', 'DULUTH, MN-WI', 'EAU CLAIRE, WI', 'ELKHART-GOSHEN, IN', 'EVANSVILLE, IN-KY', 'FARGO, ND-MN', 'FOND DU LAC, WI', 'FORT WAYNE, IN', 'GRAND FORKS, ND-MN']) => 0.016649,
    (MSA_NAME in ['GREEN BAY, WI', 'IA NONMETROPOLITAN AREA', 'IL NONMETROPOLITAN AREA', 'INDIANAPOLIS-CARMEL, IN', 'IOWA CITY, IA', 'JANESVILLE, WI', 'KOKOMO, IN', 'KS NONMETROPOLITAN AREA', 'KY NONMETROPOLITAN AREA', 'LA CROSSE, WI-MN', 'LAFAYETTE, IN', 'LIMA, OH', 'LINCOLN, NE', 'LOUISVILLE/JEFFERSON COUNTY,KY-IN', 'MADISON, WI', 'MANKATO-NORTH MANKATO, MN', 'MANSFIELD, OH', 'MI NONMETROPOLITAN AREA', 'MICHIGAN CITY-LA PORTE, IN', 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI'])                         => 0.016649,
    (MSA_NAME in ['MINNEAPOLIS-ST. PAUL-BLOOMINGTON, MN-WI', 'MN NONMETROPOLITAN AREA', 'MO NONMETROPOLITAN AREA', 'MUNCIE, IN', 'ND NONMETROPOLITAN AREA', 'OH NONMETROPOLITAN AREA', 'OMAHA-COUNCIL BLUFFS, NE-IA', 'OSHKOSH-NEENAH, WI', 'PARKERSBURG-MARIETTA-VIENNA,WV-OH', 'RACINE, WI', 'RAPID CITY, SD', 'ROCHESTER, MN', 'SANDUSKY, OH', 'SD NONMETROPOLITAN AREA', 'SHEBOYGAN, WI', 'SIOUX CITY, IA-NE-SD', 'SIOUX FALLS, SD', 'SOUTH BEND-MISHAWAKA, IN-MI', 'SPRINGFIELD, OH'])                         => 0.016649,
    (MSA_NAME in ['ST. CLOUD, MN', 'TERRE HAUTE, IN', 'TOLEDO, OH', 'WATERLOO-CEDAR FALLS, IA', 'WAUSAU, WI', 'WEIRTON-STEUBENVILLE, WV-OH', 'WHEELING, WV-OH', 'WI NONMETROPOLITAN AREA', 'YOUNGSTOWN-WARREN-BOARDMAN,OH-PA'])                                                                                                                                                                                                                                                                                     => 0.016649,
    (MSA_NAME in ['CHICO, CA', 'LOS ANGELES-LONG BEACH-SANTAANA, CA', 'MADERA, CA', 'REDDING, CA', 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA', 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA', 'SAN FRANCISCO-OAKLAND-FREMONT, CA', 'SAN JOSE-SUNNYVALE-SANTACLARA, CA', 'SAN LUIS OBISPO-PASO ROBLES,CA', 'SANTA BARBARA-SANTA MARIA LETA, CA', 'SANTA CRUZ-WATSONVILLE, CA', 'VALLEJO-FAIRFIELD, CA', 'YUBA CITY, CA'])                                                                                                         => 0.105024,
    (MSA_NAME in ['ALLENTOWN-BETHLEHEM-EASTON,PA-NJ', 'BARNSTABLE TOWN, MA', 'BINGHAMTON, NY', 'BLACKSBURG-CHRISTIANSBURG DFORD, VA', 'BOSTON-CAMBRIDGE-QUINCY,MA-NH', 'BUFFALO-NIAGARA FALLS, NY', 'CHARLOTTESVILLE, VA', 'COLUMBIA, MO', 'CT NONMETROPOLITAN AREA', 'ELMIRA, NY', 'FAYETTEVILLE-SPRINGDALE-ROGERS, AR-MO', 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT', 'ITHACA, NY', 'JEFFERSON CITY, MO', 'JOHNSTOWN, PA', 'JOPLIN, MO', 'KANSAS CITY, MO-KS'])                                                   => 0.124167,
    (MSA_NAME in ['KINGSPORT-BRISTOL-BRISTOL, TN-VA', 'LAWRENCE, KS', 'LEBANON, PA', 'LEWISTON-AUBURN, ME', 'MA NONMETROPOLITAN AREA', 'MANCHESTER-NASHUA, NH', 'MANHATTAN, KS', 'NE NONMETROPOLITAN AREA', 'NEW HAVEN-MILFORD, CT', 'NH NONMETROPOLITAN AREA', 'NORWICH-NEW LONDON, CT', 'PA NONMETROPOLITAN AREA', 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD', 'PITTSBURGH, PA', 'PITTSFIELD, MA', 'POUGHKEEPSIE-NEWBURGH-MIDDLETOWN, NY', 'RICHMOND, VA', 'SCRANTON--WILKES-BARRE, PA', 'SPRINGFIELD, MA'])   => 0.124167,
    (MSA_NAME in ['SPRINGFIELD, MO', 'ST. JOSEPH, MO-KS', 'STATE COLLEGE, PA', 'SYRACUSE, NY', 'TRENTON-EWING, NJ', 'UTICA-ROME, NY', 'VA NONMETROPOLITAN AREA', 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV', 'WICHITA, KS', 'WILLIAMSPORT, PA', 'WINCHESTER, VA-WV', 'WORCESTER, MA', 'YORK-HANOVER, PA', 'YORK-NORTHERN NEW JERSEY-LONG ISLAND, NY-NJ-PA'])                                                                                                                                                    => 0.124167,
    (MSA_NAME in ['AK NONMETROPOLITAN AREA', 'ANCHORAGE, AK', 'ARMED FORCES', 'BELLINGHAM, WA', 'BEND, OR', 'BILLINGS, MT', 'BOISE CITY-NAMPA, ID', 'BOULDER, CO', 'BREMERTON-SILVERDALE, WA', 'CO NONMETROPOLITAN AREA', 'COLORADO SPRINGS, CO', 'CORVALIS, OR', 'DENVER-AURORA, CO', 'EUGENE-SPRINGFIELD, OR', 'FAIRBANKS, AK', 'FORT COLLINS-LOVELAND, CO', 'GRAND JUNCTION, CO', 'GREAT FALLS, MT', 'GREELEY, CO', 'HI NONMETROPOLITAN AREA', 'HONOLULU, HI', 'ID NONMETROPOLITAN AREA'])                       => 0.280577,
    (MSA_NAME in ['KENNEWICK-RICHLAND-PASCO,WA', 'LEWISTON, ID-WA', 'LONGVIEW, WA', 'MEDFORD, OR', 'MISSOULA, MT', 'MOUNT VERNON-ANACORTES, WA', 'OLYMPIA, WA', 'OR NONMETROPOLITAN AREA', 'PORTLAND-VANCOUVER-BEAVERTON, OR-WA', 'PUEBLO, CO', 'SALEM, OR', 'SEATTLE-TACOMA-BELLEVUE,WA', 'SPOKANE, WA', 'WA NONMETROPOLITAN AREA', 'WENATCHEE, WA', 'YAKIMA, WA'])                                                                                                                                                => 0.280577,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       0.000000);

yng_subscore14 := map(
    (iv_vp007_phn_pcs in [' ']) => -0.000000,
    (iv_vp007_phn_pcs in ['0']) => 0.046039,
    (iv_vp007_phn_pcs in ['1']) => -0.234872,
                                   -0.000000);

yng_subscore15 := map(
    (iv_pb_profile in [' '])                            => 0.000000,
    (iv_pb_profile in ['0 No Purch Data'])              => -0.030991,
    (iv_pb_profile in ['1 Offline Shopper', '4 Other']) => 0.075462,
    (iv_pb_profile in ['3 Retail Shopper'])             => 0.188561,
    (iv_pb_profile in ['2 Online Shopper'])             => 0.390936,
                                                           0.000000);

yng_subscore16 := map(
    NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 0 => -0.002258,
    0 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 14  => -0.208919,
    14 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 37 => -0.114851,
    37 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 60 => 0.048172,
    60 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 87 => 0.100493,
    87 <= iv_mos_since_infutor_first_seen                                          => 0.165697,
                                                                                      -0.000000);

yng_subscore17 := map(
    NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => 0.032877,
    0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 22  => -0.256435,
    22 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 32 => -0.184199,
    32 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 69 => -0.154838,
    69 <= iv_mos_since_gong_did_fst_seen                                         => -0.047827,
                                                                                    -0.000000);

yng_subscore18 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff < 0.64  => -0.249544,
    0.64 <= iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff < 1.04 => -0.093847,
    1.04 <= iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff < 1.4  => 0.072715,
    1.4 <= iv_bst_addr_mtg_avm_pct_diff                                          => 0.130402,
                                                                                    -0.000000);

yng_subscore19 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen < 0 => -0.008448,
    0 <= iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen < 24  => 0.191323,
    24 <= iv_mos_since_paw_first_seen                                      => 0.322988,
                                                                              -0.000000);

yng_subscore20 := map(
    NULL < iv_pl_addrs_per_adl AND iv_pl_addrs_per_adl < 1 => -0.004770,
    1 <= iv_pl_addrs_per_adl AND iv_pl_addrs_per_adl < 2   => 0.227775,
    2 <= iv_pl_addrs_per_adl                               => 0.332862,
                                                              -0.000000);

yng_rawscore := yng_subscore0 +
    yng_subscore1 +
    yng_subscore2 +
    yng_subscore3 +
    yng_subscore4 +
    yng_subscore5 +
    yng_subscore6 +
    yng_subscore7 +
    yng_subscore8 +
    yng_subscore9 +
    yng_subscore10 +
    yng_subscore11 +
    yng_subscore12 +
    yng_subscore13 +
    yng_subscore14 +
    yng_subscore15 +
    yng_subscore16 +
    yng_subscore17 +
    yng_subscore18 +
    yng_subscore19 +
    yng_subscore20;

yng_lnoddsscore := yng_rawscore + 2.707081;

yng_probscore := exp(yng_lnoddsscore) / (1 + exp(yng_lnoddsscore));

iv_pv001_bst_avm_autoval := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

_reported_dob_1 := common.sas_date((string)(reported_dob));

reported_age_1 := if(min(sysdate, _reported_dob_1) = NULL, NULL, truncate((sysdate - _reported_dob_1) / 365.25));

iv_combined_age := map(
    not(truedid or dobpop) => NULL,
    age > 0                => age,
    (integer)input_dob_age > 0      => (integer)input_dob_age,
    inferred_age > 0       => inferred_age,
    reported_age_1 > 0     => reported_age_1,
    (integer)ams_age > 0            => (integer)ams_age,
                              (integer)-1);

mortgage_type := add1_mortgage_type;

mortgage_present := not(((string)add1_mortgage_date in ['0', ' ']));

iv_inp_addr_mortgage_type := map(
    not(add1_pop)                                         => '               ',
    (mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
    (mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    (mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    (mortgage_type in ['U'])                              => 'Unknown        ',
    not(mortgage_type = ' ')                              => 'Other          ',
    mortgage_present                                      => 'Unknown        ',
                                                             'No Mortgage');

iv_inp_addr_building_area := if(not(add1_pop), NULL, add1_building_area);

prv_addr_date_first_seen := if(add1_isbestmatch, common.sas_date((string)(add2_date_first_seen)), common.sas_date((string)(add3_date_first_seen)));

iv_mos_since_prv_addr_fseen := map(
    not(truedid)                    => NULL,
    prv_addr_date_first_seen = NULL => -1,
                                       if ((sysdate - prv_addr_date_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - prv_addr_date_first_seen) / (365.25 / 12)), roundup((sysdate - prv_addr_date_first_seen) / (365.25 / 12))));

iv_avg_prop_assess_purch_amt := map(
    not(truedid or add1_pop)          => NULL,
    property_owned_assessed_count > 0 => property_owned_assessed_total / property_owned_assessed_count,
                                         -1);

iv_dist_bst_addr_to_prv_addr := map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a2toa3);

iv_addrs_per_adl := if(not(truedid), NULL, addrs_per_adl);

iv_adls_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    (string)iv_add_apt = '1' => -1,
                        adls_per_addr);

iv_inq_auto_count12 := if(not(truedid), NULL, inq_auto_count12);

iv_paw_dead_bus_x_active_phn := if(not(truedid), '   ', trim((string)min(if(paw_dead_business_count = NULL, -NULL, paw_dead_business_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(paw_active_phone_count = NULL, -NULL, paw_active_phone_count), 3), LEFT, RIGHT));

iv_pb_average_dollars := map(
    not(truedid)              => NULL,
    pb_average_dollars = ' ' => -1,
                                 (integer)pb_average_dollars);

own_subscore0 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 22000   => -1.663014,
    22000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 25000 => -0.980237,
    25000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 31000 => -0.381033,
    31000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 39000 => -0.090230,
    39000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 46000 => 0.211818,
    46000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 61000 => 0.280558,
    61000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 92000 => 0.362373,
    92000 <= iv_in001_estimated_income                                       => 0.667781,
                                                                                0.000000);

own_subscore1 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -0.157456,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1', '3-3'])        => -0.137986,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.481454,
                                                                                    -0.000000);

own_subscore2 := map(
    NULL < iv_combined_age AND iv_combined_age < 43 => -0.249936,
    43 <= iv_combined_age AND iv_combined_age < 47  => -0.128166,
    47 <= iv_combined_age AND iv_combined_age < 54  => 0.091230,
    54 <= iv_combined_age                           => 0.206844,
                                                       0.000000);

own_subscore3 := map(
    NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 1 => 0.054507,
    1 <= iv_inq_auto_count12                               => -1.027711,
                                                              0.000000);

own_subscore4 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl < 3 => 0.353754,
    3 <= iv_addrs_per_adl AND iv_addrs_per_adl < 4   => 0.242603,
    4 <= iv_addrs_per_adl AND iv_addrs_per_adl < 5   => 0.184479,
    5 <= iv_addrs_per_adl AND iv_addrs_per_adl < 8   => 0.052444,
    8 <= iv_addrs_per_adl AND iv_addrs_per_adl < 10  => -0.088281,
    10 <= iv_addrs_per_adl AND iv_addrs_per_adl < 14 => -0.171553,
    14 <= iv_addrs_per_adl                           => -0.385697,
                                                        0.000000);

own_subscore5 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => -0.521998,
    1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2   => -0.118949,
    2 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3   => 0.031512,
    3 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 4   => 0.169588,
    4 <= iv_addr_non_phn_src_ct                                  => 0.342905,
                                                                    0.000000);

own_subscore6 := map(
    (iv_inp_addr_mortgage_type in [' '])                                                                              => 0.000000,
    (iv_inp_addr_mortgage_type in ['Conventional'])                                                                   => 0.305277,
    (iv_inp_addr_mortgage_type in ['Unknown'])                                                                        => 0.037072,
    (iv_inp_addr_mortgage_type in ['Equity Loan'])                                                                    => -0.117460,
    (iv_inp_addr_mortgage_type in ['No Mortgage'])                                                                    => 0.082715,
    (iv_inp_addr_mortgage_type in ['Commercial', 'Government', 'High-Risk', 'Non-Traditional', 'Other', 'Piggyback']) => -0.299193,
                                                                                                                         0.000000);

own_subscore7 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 0 => 0.098921,
    0 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 5   => 0.188762,
    5 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 7   => 0.114036,
    7 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 9   => 0.037959,
    9 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 12  => -0.031398,
    12 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 16 => -0.084047,
    16 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 28 => -0.167333,
    28 <= iv_adls_per_sfd_addr                               => -0.252245,
                                                                -0.000000);

own_subscore8 := map(
    NULL < iv_inp_addr_building_area AND iv_inp_addr_building_area < 1     => -0.025416,
    1 <= iv_inp_addr_building_area AND iv_inp_addr_building_area < 1016    => -0.145055,
    1016 <= iv_inp_addr_building_area AND iv_inp_addr_building_area < 1646 => -0.067639,
    1646 <= iv_inp_addr_building_area AND iv_inp_addr_building_area < 2361 => 0.052873,
    2361 <= iv_inp_addr_building_area                                      => 0.197857,
                                                                              0.000000);

own_subscore9 := map(
    (iv_ams_college_tier in [' '])                => -0.000000,
    (iv_ams_college_tier in ['-1'])               => -0.024570,
    (iv_ams_college_tier in ['1', '2', '3'])      => 0.519173,
    (iv_ams_college_tier in ['0', '4', '5', '6']) => 0.191362,
                                                     -0.000000);

own_subscore10 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => -0.067686,
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 209912      => -0.012343,
    209912 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 459427 => 0.040364,
    459427 <= iv_pv001_bst_avm_autoval                                       => 0.313356,
                                                                                0.000000);

own_subscore11 := map(
    NULL < iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 0         => 0.055348,
    0 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 75250       => -0.171083,
    75250 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 119200  => -0.060375,
    119200 <= iv_avg_prop_assess_purch_amt AND iv_avg_prop_assess_purch_amt < 284396 => 0.009228,
    284396 <= iv_avg_prop_assess_purch_amt                                           => 0.093674,
                                                                                        0.000000);

own_subscore12 := map(
    NULL < iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr < 1 => -0.013993,
    1 <= iv_dist_bst_addr_to_prv_addr AND iv_dist_bst_addr_to_prv_addr < 39  => -0.059943,
    39 <= iv_dist_bst_addr_to_prv_addr                                       => 0.128772,
                                                                                0.000000);

own_subscore13 := map(
    (iv_paw_dead_bus_x_active_phn in [' '])                                                           => 0.000000,
    (iv_paw_dead_bus_x_active_phn in ['0-0'])                                                         => -0.005246,
    (iv_paw_dead_bus_x_active_phn in ['0-1', '0-2', '0-3', '1-2', '1-3', '2-3'])                      => 0.297600,
    (iv_paw_dead_bus_x_active_phn in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.131629,
                                                                                                         0.000000);

own_subscore14 := map(
    NULL < (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 11 => -0.068151,
    11 <= (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 21  => -0.029449,
    21 <= (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 65  => 0.028045,
    65 <= (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 81  => 0.072637,
    81 <= (integer)iv_pb_average_dollars                                 => 0.082621,
                                                                   0.000000);

own_subscore15 := map(
    NULL < iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen < 0   => -0.087288,
    0 <= iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen < 12    => -0.203769,
    12 <= iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen < 134  => -0.015508,
    134 <= iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen < 197 => 0.006478,
    197 <= iv_mos_since_prv_addr_fseen AND iv_mos_since_prv_addr_fseen < 270 => 0.073524,
    270 <= iv_mos_since_prv_addr_fseen                                       => 0.082017,
                                                                                -0.000000);

own_subscore16 := map(
    (MSA_NAME in [' '])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              => -0.000000,
    (MSA_NAME in ['BAKERSFIELD, CA', 'BEND, OR', 'CARSON CITY, NV', 'CORVALIS, OR', 'EL CENTRO, CA', 'EUGENE-SPRINGFIELD, OR', 'LAS VEGAS-PARADISE, NV', 'MADERA, CA', 'MEDFORD, OR', 'MERCED, CA', 'MODESTO, CA', 'NV NONMETROPOLITAN AREA', 'OGDEN-CLEARFIELD, UT', 'OR NONMETROPOLITAN AREA', 'PROVO-OREM, UT', 'REDDING, CA', 'RENO-SPARKS, NV', 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA', 'SALEM, OR', 'SALT LAKE CITY, UT', 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA', 'ST. GEORGE, UT', 'STOCKTON, CA'])              => -0.033163,
    (MSA_NAME in ['UT NONMETROPOLITAN AREA', 'VISALIA-PORTERVILLE, CA', 'WA NONMETROPOLITAN AREA'])                                                                                                                                                                                                                                                                                                                                                                                                                  => -0.033163,
    (MSA_NAME in ['AKRON, OH', 'AMES, IA', 'ANDERSON, IN', 'ANN ARBOR, MI', 'APPLETON, WI', 'BATTLE CREEK, MI', 'BAY CITY, MI', 'BISMARCK, ND', 'BLOOMINGTON, IN', 'CANTON-MASSILLON, OH', 'CEDAR RAPIDS, IA', 'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI', 'CINCINNATI-MIDDLETOWN, OH', 'CLEVELAND-ELYRIA-MENTOR,OH', 'COLUMBUS, IN', 'COLUMBUS, OH', 'DAVENPORT-MOLINE-ROCK ISLAND, IA-IL', 'DAYTON, OH', 'DES MOINES-WEST DES MOINES,IA', 'DETROIT-WARREN-LIVONIA, MI', 'DUBUQUE, IA'])                                 => -0.085026,
    (MSA_NAME in ['DULUTH, MN-WI', 'EAU CLAIRE, WI', 'ELKHART-GOSHEN, IN', 'EVANSVILLE, IN-KY', 'FARGO, ND-MN', 'FLINT, MI', 'FOND DU LAC, WI', 'FORT WAYNE, IN', 'GRAND FORKS, ND-MN', 'GRAND RAPIDS-WYOMING, MI', 'GREEN BAY, WI', 'HOLLAND-GRAND HAVEN, MI', 'IA NONMETROPOLITAN AREA', 'IN NONMETROPOLITAN AREA', 'INDIANAPOLIS-CARMEL, IN', 'IOWA CITY, IA', 'JACKSON, MI', 'JANESVILLE, WI', 'KALAMAZOO-PORTAGE, MI', 'KOKOMO, IN', 'LA CROSSE, WI-MN', 'LAFAYETTE, IN', 'LANSING-EAST LANSING, MI'])          => -0.085026,
    (MSA_NAME in ['LIMA, OH', 'LINCOLN, NE', 'MADISON, WI', 'MANKATO-NORTH MANKATO, MN', 'MANSFIELD, OH', 'MI NONMETROPOLITAN AREA', 'MICHIGAN CITY-LA PORTE, IN', 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI', 'MINNEAPOLIS-ST. PAUL-BLOOMINGTON, MN-WI', 'MN NONMETROPOLITAN AREA', 'MONROE, MI', 'MUNCIE, IN', 'MUSKEGON-NORTON SHORES, MI', 'ND NONMETROPOLITAN AREA', 'NE NONMETROPOLITAN AREA', 'NILES-BENTON HARBOR, MI', 'OH NONMETROPOLITAN AREA', 'OMAHA-COUNCIL BLUFFS, NE-IA', 'OSHKOSH-NEENAH, WI'])            => -0.085026,
    (MSA_NAME in ['PARKERSBURG-MARIETTA-VIENNA,WV-OH', 'RACINE, WI', 'RAPID CITY, SD', 'ROCHESTER, MN', 'SAGINAW-SAGINAW TOWNSHIPNORTH, MI', 'SANDUSKY, OH', 'SD NONMETROPOLITAN AREA', 'SHEBOYGAN, WI', 'SIOUX CITY, IA-NE-SD', 'SIOUX FALLS, SD', 'SOUTH BEND-MISHAWAKA, IN-MI', 'SPRINGFIELD, OH', 'ST. CLOUD, MN', 'TERRE HAUTE, IN', 'TOLEDO, OH', 'WATERLOO-CEDAR FALLS, IA', 'WAUSAU, WI', 'WEIRTON-STEUBENVILLE, WV-OH', 'WHEELING, WV-OH', 'WI NONMETROPOLITAN AREA', 'YOUNGSTOWN-WARREN-BOARDMAN,OH-PA'])  => -0.085026,
    (MSA_NAME in ['ABILENE, TX', 'AGUADILLA-ISABELA-SAN SEBASTIAN, PR', 'AL NONMETROPOLITAN AREA', 'ALBANY, GA', 'ALBUQUERQUE, NM', 'ALEXANDRIA, LA', 'AMARILLO, TX', 'ANDERSON, SC', 'ANNISTON-OXFORD, AL', 'AR NONMETROPOLITAN AREA', 'ASHEVILLE, NC', 'ATHENS-CLARK COUNTY, GA', 'ATLANTA-SANDY SPRINGS-MARIETTA, GA', 'AUBURN-OPELIKA, AL', 'AUGUSTA-RICHMOND COUNTY,GA-SC', 'AUSTIN-ROUND ROCK, TX', 'AZ NONMETROPOLITAN AREA', 'BATON ROUGE, LA', 'BEAUMONT-PORT ARTHUR, TX', 'BIRMINGHAM-HOOVER, AL'])        => -0.017716,
    (MSA_NAME in ['BLOOMINGTON-NORMAL, IL', 'BOWLING GREEN, KY', 'BROWNSVILLE-HARLINGEN, TX', 'BRUNSWICK, GA', 'BURLINGTON, NC', 'CAPE CORAL-FORT MYERS, FL', 'CAPE GIRARDEAU-JACKSON, MO-IL', 'CHAMPAIGN-URBANA, IL', 'CHARLESTON, WV', 'CHARLESTON-NORTH CHARLESTON,SC', 'CHARLOTTE-GASTONIA-CONCORD,NC-SC', 'CHATTANOOGA, TN-GA', 'CLARKSVILLE, TN-KY', 'CLEVELAND, TN', 'COLLEGE STATION-BRYAN, TX', 'COLUMBIA, MO', 'COLUMBIA, SC', 'COLUMBUS, GA-AL', 'CORPUS CHRISTI, TX'])                                   => -0.017716,
    (MSA_NAME in ['DALLAS-FORT WORTH-ARLINGTON,TX', 'DALTON, GA', 'DANVILLE, IL', 'DECATUR, AL', 'DECATUR, IL', 'DELTONA-DAYTONA BEACH-ORMONDBEACH, FL', 'DOTHAN, AL', 'DURHAM, NC', 'EL PASO, TX', 'ELIZABETHTOWN, KY', 'FAJARDO, PR', 'FARMINGTON, NM', 'FAYETTEVILLE, NC', 'FAYETTEVILLE-SPRINGDALE-ROGERS, AR-MO', 'FL NONMETROPOLITAN AREA', 'FLAGSTAFF, AZ', 'FLORENCE, SC', 'FLORENCE-MUSCLE SHOALS, AL', 'FORT SMITH, AR-OK', 'FORT WALTON BEACH-CRESTVIEW-DESTIN, FL', 'GA NONMETROPOLITAN AREA'])          => -0.017716,
    (MSA_NAME in ['GADSDEN, AL', 'GAINESVILLE, FL', 'GAINESVILLE, GA', 'GOLDSBORO, NC', 'GREENSBORO-HIGH POINT, NC', 'GREENVILLE, NC', 'GREENVILLE-MAULDIN-EASLEY, SC', 'GUAYAMA, PR', 'GULFPORT-BILOXI, MS', 'HATTIESBURG, MS', 'HICKORY-LENOIR-MORGANTON,NC', 'HINESVILLE-FORT STEWART,GA', 'HOT SPRINGS, AR', 'HOUMA-BAYOU CANE-THIBODAUX,LA', 'HOUSTON-SUGAR LAND-BAYTOWN,TX', 'HUNTINGTON-ASHLAND, WV-KY', 'HUNTSVILLE, AL', 'IL NONMETROPOLITAN AREA', 'JACKSON, MS', 'JACKSON, TN'])                          => -0.017716,
    (MSA_NAME in ['JACKSONVILLE, FL', 'JACKSONVILLE, NC', 'JEFFERSON CITY, MO', 'JOHNSON CITY, TN', 'JONESBORO, AR', 'JOPLIN, MO', 'KANKAKEE-BRADLEY, IL', 'KANSAS CITY, MO-KS', 'KILLEEN-TEMPLE-FORT HOOD,TX', 'KNOXVILLE, TN', 'KS NONMETROPOLITAN AREA', 'KY NONMETROPOLITAN AREA', 'LA NONMETROPOLITAN AREA', 'LAFAYETTE, LA', 'LAKE CHARLES, LA', 'LAKE HAVASU CITY-KINGMAN,AZ', 'LAKELAND, FL', 'LAREDO, TX', 'LAS CRUCES, NM', 'LAWRENCE, KS', 'LAWTON, OK', 'LEXINGTON-FAYETTE, KY'])                        => -0.017716,
    (MSA_NAME in ['LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR', 'LONGVIEW, TX', 'LOUISVILLE/JEFFERSON COUNTY,KY-IN', 'LUBBOCK, TX', 'MACON, GA', 'MANHATTAN, KS', 'MAYAGUEZ, PR', 'MCALLEN-EDINBURG-MISSION,TX', 'MEMPHIS, TN-AR-MS', 'MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL', 'MIDLAND, TX', 'MO NONMETROPOLITAN AREA', 'MOBILE, AL', 'MONROE, LA', 'MONTGOMERY, AL', 'MORGANTOWN, WV', 'MORRISTOWN, TN', 'MS NONMETROPOLITAN AREA', 'MYRTLE BEACH-CONWAY-NORTHMYRTLE BEACH, SC', 'NAPLES-MARCO ISLAND, FL'])        => -0.017716,
    (MSA_NAME in ['NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN', 'NC NONMETROPOLITAN AREA', 'NEW ORLEANS-METAIRIE-KENNER,LA', 'NM NONMETROPOLITAN AREA', 'OCALA, FL', 'ODESSA, TX', 'OK NONMETROPOLITAN AREA', 'OKLAHOMA CITY, OK', 'ORLANDO-KISSIMMEE, FL', 'OWENSBORO, KY', 'PALM BAY-MELBOURNE-TITUSVILLE, FL', 'PALM COAST, FL', 'PANAMA CITY-LYNN HAVEN, FL', 'PASCAGOULA, MS', 'PENSACOLA-FERRY PASS-BRENT,FL', 'PEORIA, IL', 'PHOENIX-MESA-SCOTTSDALE,AZ', 'PINE BLUFF, AR', 'PORT ST. LUCIE, FL'])          => -0.017716,
    (MSA_NAME in ['PR NONMETROPOLITAN AREA', 'PRESCOTT, AZ', 'PUNTA GORDA, FL', 'RALEIGH-CARY, NC', 'ROCKFORD, IL', 'ROCKY MOUNT, NC', 'ROME, GA', 'SAN ANGELO, TX', 'SAN ANTONIO, TX', 'SAN JUAN-CAGUAS-GUAYNABO,PR', 'SANTA FE, NM', 'SARASOTA-BRADENTON-VENICE, FL', 'SAVANNAH, GA', 'SC NONMETROPOLITAN AREA', 'SEBASTIAN-VERO BEACH, FL', 'SHERMAN-DENISON, TX', 'SHREVEPORT-BOSSIER CITY,LA', 'SPARTANBURG, SC', 'SPRINGFIELD, IL', 'SPRINGFIELD, MO', 'ST. JOSEPH, MO-KS', 'ST. LOUIS, MO-IL', 'SUMTER, SC']) => -0.017716,
    (MSA_NAME in ['TALLAHASSEE, FL', 'TAMPA-ST. PETERSBURG-CLEARWATER, FL', 'TEXARKANA, TX-TEXARKANA,AR', 'TN NONMETROPOLITAN AREA', 'TOPEKA, KS', 'TUCSON, AZ', 'TULSA, OK', 'TUSCALOOSA, AL', 'TX NONMETROPOLITAN AREA', 'TYLER, TX', 'VALDOSTA, GA', 'VICTORIA, TX', 'VIRGINIA BEACH-NORFOLK-NEWPORT NEWS, VA-NC', 'WACO, TX', 'WARNER ROBINS, GA', 'WICHITA FALLS, TX', 'WICHITA, KS', 'WILMINGTON, NC', 'WINSTON-SALEM, NC', 'WV NONMETROPOLITAN AREA', 'YUMA, AZ'])                                            => -0.017716,
    (MSA_NAME in ['BELLINGHAM, WA', 'BILLINGS, MT', 'BOISE CITY-NAMPA, ID', 'BOULDER, CO', 'BREMERTON-SILVERDALE, WA', 'CA NONMETROPOLITAN AREA', 'CASPER, WY', 'CHEYENNE, WY', 'CHICO, CA', 'CO NONMETROPOLITAN AREA', 'COEUR DALENE, ID', 'COLORADO SPRINGS, CO', 'DENVER-AURORA, CO', 'FORT COLLINS-LOVELAND, CO', 'FRESNO, CA', 'GRAND JUNCTION, CO', 'GREAT FALLS, MT', 'GREELEY, CO', 'HANFORD-CORCORAN, CA', 'ID NONMETROPOLITAN AREA', 'IDAHO FALLS, ID', 'KENNEWICK-RICHLAND-PASCO,WA'])                    => 0.074615,
    (MSA_NAME in ['LEWISTON, ID-WA', 'LOGAN, UT-ID', 'LONGVIEW, WA', 'LOS ANGELES-LONG BEACH-SANTAANA, CA', 'MISSOULA, MT', 'MOUNT VERNON-ANACORTES, WA', 'MT NONMETROPOLITAN AREA', 'NAPA, CA', 'OLYMPIA, WA', 'OXNARD-THOUSAND OAKS-VENTURA, CA', 'POCATELLO, ID', 'PORTLAND-VANCOUVER-BEAVERTON, OR-WA', 'PUEBLO, CO', 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA', 'SALINAS, CA', 'SAN FRANCISCO-OAKLAND-FREMONT, CA', 'SAN JOSE-SUNNYVALE-SANTACLARA, CA', 'SAN LUIS OBISPO-PASO ROBLES,CA'])                       => 0.074615,
    (MSA_NAME in ['SANTA BARBARA-SANTA MARIA LETA, CA', 'SANTA CRUZ-WATSONVILLE, CA', 'SANTA ROSA-PETALUMA, CA', 'SEATTLE-TACOMA-BELLEVUE,WA', 'SPOKANE, WA', 'VALLEJO-FAIRFIELD, CA', 'WENATCHEE, WA', 'WY NONMETROPOLITAN AREA', 'YAKIMA, WA', 'YUBA CITY, CA'])                                                                                                                                                                                                                                                   => 0.074615,
    (MSA_NAME in ['AK NONMETROPOLITAN AREA', 'ALBANY-SCHENECTADY-TROY,NY', 'ALLENTOWN-BETHLEHEM-EASTON,PA-NJ', 'ALTOONA, PA', 'ANCHORAGE, AK', 'ARMED FORCES', 'ATLANTIC CITY, NJ', 'BALTIMORE-TOWSON, MD', 'BANGOR, ME', 'BARNSTABLE TOWN, MA', 'BINGHAMTON, NY', 'BLACKSBURG-CHRISTIANSBURG DFORD, VA', 'BOSTON-CAMBRIDGE-QUINCY,MA-NH', 'BRIDGEPORT-STAMFORD-NORWALK,CT', 'BUFFALO-NIAGARA FALLS, NY', 'BURLINGTON-SOUTH BURLINGTON,VT', 'CHARLOTTESVILLE, VA', 'CT NONMETROPOLITAN AREA'])                       => 0.048343,
    (MSA_NAME in ['CUMBERLAND, MD-WV', 'DANVILLE, VA', 'DE NONMETROPOLITAN AREA', 'DOVER, DE', 'ELMIRA, NY', 'ERIE, PA', 'FAIRBANKS, AK', 'GLENS FALLS, NY', 'GU NONMETROPOLITAN AREA', 'HAGERSTOWN-MARTINSBURG, MD-WV', 'HARRISBURG-CARLISLE, PA', 'HARRISONBURG, VA', 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT', 'HI NONMETROPOLITAN AREA', 'HONOLULU, HI', 'ITHACA, NY', 'JOHNSTOWN, PA', 'KINGSPORT-BRISTOL-BRISTOL, TN-VA', 'KINGSTON, NY', 'LANCASTER, PA', 'LEBANON, PA', 'LEWISTON-AUBURN, ME'])             => 0.048343,
    (MSA_NAME in ['LYNCHBURG, VA', 'MA NONMETROPOLITAN AREA', 'MANCHESTER-NASHUA, NH', 'MD NONMETROPOLITAN AREA', 'ME NONMETROPOLITAN AREA', 'NEW HAVEN-MILFORD, CT', 'NEW YORK-NORTHERN NEW JERSEY', 'NH NONMETROPOLITAN AREA', 'NORWICH-NEW LONDON, CT', 'NY NONMETROPOLITAN AREA', 'OCEAN CITY, NJ', 'PA NONMETROPOLITAN AREA', 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD', 'PITTSBURGH, PA', 'PITTSFIELD, MA', 'PORTLAND-SOUTH PORTLAND-BIDDEFORD, ME', 'POUGHKEEPSIE-NEWBURGH-MIDDLETOWN, NY'])              => 0.048343,
    (MSA_NAME in ['PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA', 'READING, PA', 'RICHMOND, VA', 'ROANOKE, VA', 'ROCHESTER, NY', 'SALISBURY, MD', 'SCRANTON--WILKES-BARRE, PA', 'SPRINGFIELD, MA', 'STATE COLLEGE, PA', 'SYRACUSE, NY', 'TRENTON-EWING, NJ', 'UTICA-ROME, NY', 'VA NONMETROPOLITAN AREA', 'VI NONMETROPOLITAN AREA', 'VINELAND-MILLVILLE-BRIDGETON, NJ', 'VT NONMETROPOLITAN AREA', 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV', 'WILLIAMSPORT, PA', 'WINCHESTER, VA-WV', 'WORCESTER, MA'])            => 0.048343,
    (MSA_NAME in ['YORK-HANOVER, PA', 'YORK-NORTHERN NEW JERSEY-LONG ISLAND, NY-NJ-PA'])                                                                                                                                                                                                                                                                                                                                                                                                                             => 0.048343,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        -0.000000);

own_rawscore := own_subscore0 +
    own_subscore1 +
    own_subscore2 +
    own_subscore3 +
    own_subscore4 +
    own_subscore5 +
    own_subscore6 +
    own_subscore7 +
    own_subscore8 +
    own_subscore9 +
    own_subscore10 +
    own_subscore11 +
    own_subscore12 +
    own_subscore13 +
    own_subscore14 +
    own_subscore15 +
    own_subscore16;

own_lnoddsscore := own_rawscore + 3.641784;

own_probscore := exp(own_lnoddsscore) / (1 + exp(own_lnoddsscore));

iv_dist_inp_addr_to_prv_addr := map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a1toa3);

_reported_dob := common.sas_date((string)(reported_dob));

reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

_combined_age := map(
    age > 0           => age,
    (integer)input_dob_age > 0 => (integer)input_dob_age,
    inferred_age > 0  => inferred_age,
    reported_age > 0  => reported_age,
    (integer)ams_age > 0       => (integer)ams_age,
                         (integer)-1);

evidence_of_college := not(ams_college_code = ' ') or not(ams_college_type = ' ');

evidence_of_college_flag := if(evidence_of_college, 'Y', 'N');

// iv_college_attendance_x_age_1 := map(
    // not(truedid or dobpop) => '',
    // (string)_combined_age = '-1'     => '',
                              // (string)NULL);
iv_college_attendance_x_age := map(
    not(truedid or dobpop) => '',
    (string)_combined_age = '-1'     => '',
                              (string)evidence_of_college_flag + (if (min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10 >= 0, truncate(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10), roundup(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10)) * 10));

// iv_college_attendance_x_age := (string)evidence_of_college_flag + (if (min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10 >= 0, truncate(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10), roundup(min(if(_combined_age = NULL, -NULL, _combined_age), 60) / 10)) * 10);
// iv_college_attendance_x_age := (string)evidence_of_college_flag + (if (min(if(_combined_age = -1, (integer)-NULL, _combined_age), 60) / 10 >= 0, truncate(min(if(_combined_age = -1,(integer)-NULL, _combined_age), 60) / 10), roundup(min(if(_combined_age =-1, (integer)-NULL, _combined_age), 60) / 10)) * 10);


otr_subscore0 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 22000   => -0.494543,
    22000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 28000 => -0.147873,
    28000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 36000 => 0.082598,
    36000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 80000 => 0.430764,
    80000 <= iv_in001_estimated_income                                       => 0.718658,
                                                                                -0.000000);

otr_subscore1 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => -0.378941,
    1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2   => 0.071137,
    2 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3   => 0.176546,
    3 <= iv_addr_non_phn_src_ct                                  => 0.392583,
                                                                    0.000000);

otr_subscore2 := map(
    NULL < iv_inq_auto_count12 AND iv_inq_auto_count12 < 1 => 0.064618,
    1 <= iv_inq_auto_count12                               => -0.827820,
                                                              0.000000);

otr_subscore3 := map(
    NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => 0.041540,
    1 <= iv_inq_highriskcredit_count12                                         => -1.427676,
                                                                                  -0.000000);

otr_subscore4 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -0.116495,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-1', '3-3'])              => 0.020488,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                          => 0.566314,
                                                                                          0.000000);

otr_subscore5 := map(
    NULL < iv_addrs_per_adl AND iv_addrs_per_adl < 3 => 0.311438,
    3 <= iv_addrs_per_adl AND iv_addrs_per_adl < 4   => 0.170896,
    4 <= iv_addrs_per_adl AND iv_addrs_per_adl < 9   => 0.029907,
    9 <= iv_addrs_per_adl AND iv_addrs_per_adl < 11  => -0.123612,
    11 <= iv_addrs_per_adl AND iv_addrs_per_adl < 20 => -0.252317,
    20 <= iv_addrs_per_adl                           => -0.479873,
                                                        0.000000);

otr_subscore6 := map(
    NULL < iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 0 => 0.141870,
    0 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 4   => 0.280719,
    4 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 9   => 0.129785,
    9 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 15  => -0.093856,
    15 <= iv_adls_per_sfd_addr AND iv_adls_per_sfd_addr < 22 => -0.189166,
    22 <= iv_adls_per_sfd_addr                               => -0.262229,
                                                                -0.000000);

otr_subscore7 := map(
    NULL < (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 0 => -0.108139,
    0 <= (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 33  => 0.016235,
    33 <= (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 49 => 0.202449,
    49 <= (integer)iv_pb_average_dollars AND (integer)iv_pb_average_dollars < 87 => 0.224921,
    87 <= (integer)iv_pb_average_dollars                                => 0.229655,
                                                                  -0.000000);

otr_subscore8 := map(
    (MSA_NAME in [' '])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => 0.000000,
    (MSA_NAME in ['BAKERSFIELD, CA', 'BOULDER, CO', 'CHICO, CA', 'CO NONMETROPOLITAN AREA', 'COLORADO SPRINGS, CO', 'DENVER-AURORA, CO', 'EL CENTRO, CA', 'FORT COLLINS-LOVELAND, CO', 'FRESNO, CA', 'GRAND JUNCTION, CO', 'GREELEY, CO', 'HANFORD-CORCORAN, CA', 'MODESTO, CA', 'NAPA, CA', 'OGDEN-CLEARFIELD, UT', 'OXNARD-THOUSAND OAKS-VENTURA, CA', 'PROVO-OREM, UT', 'PUEBLO, CO', 'REDDING, CA', 'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA', 'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA', 'SALT LAKE CITY, UT'])             => -0.175093,
    (MSA_NAME in ['SAN LUIS OBISPO-PASO ROBLES,CA', 'SANTA CRUZ-WATSONVILLE, CA', 'ST. GEORGE, UT', 'STOCKTON, CA', 'UT NONMETROPOLITAN AREA', 'VISALIA-PORTERVILLE, CA'])                                                                                                                                                                                                                                                                                                                                                  => -0.175093,
    (MSA_NAME in ['AGUADILLA-ISABELA-SAN SEBASTIAN, PR', 'AL NONMETROPOLITAN AREA', 'ALBANY, GA', 'ALBUQUERQUE, NM', 'ALEXANDRIA, LA', 'ALL OTHER TERRITORIES ANDFOREIGN COUNTRIES', 'AMARILLO, TX', 'ANDERSON, IN', 'ANDERSON, SC', 'ANNISTON-OXFORD, AL', 'ASHEVILLE, NC', 'ATHENS-CLARK COUNTY, GA', 'ATLANTA-SANDY SPRINGS-MARIETTA, GA', 'AUBURN-OPELIKA, AL', 'AUGUSTA-RICHMOND COUNTY,GA-SC', 'AZ NONMETROPOLITAN AREA', 'BATON ROUGE, LA', 'BIRMINGHAM-HOOVER, AL', 'BLOOMINGTON, IN'])                             => -0.085745,
    (MSA_NAME in ['BLOOMINGTON-NORMAL, IL', 'BOWLING GREEN, KY', 'BROWNSVILLE-HARLINGEN, TX', 'BRUNSWICK, GA', 'BURLINGTON, NC', 'CAPE CORAL-FORT MYERS, FL', 'CAPE GIRARDEAU-JACKSON, MO-IL', 'CHAMPAIGN-URBANA, IL', 'CHARLESTON-NORTH CHARLESTON,SC', 'CHARLOTTE-GASTONIA-CONCORD,NC-SC', 'CHATTANOOGA, TN-GA', 'CLARKSVILLE, TN-KY', 'CLEVELAND, TN', 'COLLEGE STATION-BRYAN, TX', 'COLUMBIA, SC', 'COLUMBUS, GA-AL', 'COLUMBUS, IN', 'CORPUS CHRISTI, TX', 'DALTON, GA', 'DANVILLE, IL'])                              => -0.085745,
    (MSA_NAME in ['DECATUR, AL', 'DECATUR, IL', 'DELTONA-DAYTONA BEACH-ORMONDBEACH, FL', 'DOTHAN, AL', 'DURHAM, NC', 'EL PASO, TX', 'ELIZABETHTOWN, KY', 'ELKHART-GOSHEN, IN', 'EVANSVILLE, IN-KY', 'FAJARDO, PR', 'FARMINGTON, NM', 'FAYETTEVILLE, NC', 'FL NONMETROPOLITAN AREA', 'FLAGSTAFF, AZ', 'FLORENCE, SC', 'FLORENCE-MUSCLE SHOALS, AL', 'FORT WALTON BEACH-CRESTVIEW-DESTIN, FL', 'FORT WAYNE, IN', 'GA NONMETROPOLITAN AREA', 'GADSDEN, AL', 'GAINESVILLE, FL', 'GAINESVILLE, GA'])                             => -0.085745,
    (MSA_NAME in ['GOLDSBORO, NC', 'GREENSBORO-HIGH POINT, NC', 'GREENVILLE, NC', 'GREENVILLE-MAULDIN-EASLEY, SC', 'GU NONMETROPOLITAN AREA', 'GUAYAMA, PR', 'GULFPORT-BILOXI, MS', 'HATTIESBURG, MS', 'HICKORY-LENOIR-MORGANTON,NC', 'HINESVILLE-FORT STEWART,GA', 'HOUMA-BAYOU CANE-THIBODAUX,LA', 'HUNTINGTON-ASHLAND, WV-KY', 'HUNTSVILLE, AL', 'IL NONMETROPOLITAN AREA', 'IN NONMETROPOLITAN AREA', 'INDIANAPOLIS-CARMEL, IN', 'JACKSON, MS', 'JACKSON, TN', 'JACKSONVILLE, FL'])                                     => -0.085745,
    (MSA_NAME in ['JACKSONVILLE, NC', 'JOHNSON CITY, TN', 'KANKAKEE-BRADLEY, IL', 'KILLEEN-TEMPLE-FORT HOOD,TX', 'KNOXVILLE, TN', 'KOKOMO, IN', 'KS NONMETROPOLITAN AREA', 'KY NONMETROPOLITAN AREA', 'LA NONMETROPOLITAN AREA', 'LAFAYETTE, IN', 'LAFAYETTE, LA', 'LAKE CHARLES, LA', 'LAKE HAVASU CITY-KINGMAN,AZ', 'LAKELAND, FL', 'LAS CRUCES, NM', 'LAWRENCE, KS', 'LAWTON, OK', 'LEXINGTON-FAYETTE, KY', 'LOUISVILLE/JEFFERSON COUNTY,KY-IN', 'LUBBOCK, TX', 'MACON, GA', 'MANHATTAN, KS'])                           => -0.085745,
    (MSA_NAME in ['MAYAGUEZ, PR', 'MEMPHIS, TN-AR-MS', 'MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL', 'MICHIGAN CITY-LA PORTE, IN', 'MOBILE, AL', 'MONROE, LA', 'MONTGOMERY, AL', 'MORRISTOWN, TN', 'MS NONMETROPOLITAN AREA', 'MUNCIE, IN', 'MYRTLE BEACH-CONWAY-NORTHMYRTLE BEACH, SC', 'NAPLES-MARCO ISLAND, FL', 'NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN', 'NC NONMETROPOLITAN AREA', 'NEW ORLEANS-METAIRIE-KENNER,LA', 'NM NONMETROPOLITAN AREA', 'OCALA, FL', 'OK NONMETROPOLITAN AREA'])                           => -0.085745,
    (MSA_NAME in ['OKLAHOMA CITY, OK', 'ORLANDO-KISSIMMEE, FL', 'OWENSBORO, KY', 'PALM BAY-MELBOURNE-TITUSVILLE, FL', 'PALM COAST, FL', 'PANAMA CITY-LYNN HAVEN, FL', 'PASCAGOULA, MS', 'PENSACOLA-FERRY PASS-BRENT,FL', 'PEORIA, IL', 'PHOENIX-MESA-SCOTTSDALE,AZ', 'PONCE, PR', 'PORT ST. LUCIE, FL', 'PR NONMETROPOLITAN AREA', 'PRESCOTT, AZ', 'PUNTA GORDA, FL', 'RALEIGH-CARY, NC', 'ROCKFORD, IL', 'ROCKY MOUNT, NC', 'ROME, GA', 'SAN ANTONIO, TX', 'SAN GERMAN-CABO ROJO, PR'])                                    => -0.085745,
    (MSA_NAME in ['SAN JUAN-CAGUAS-GUAYNABO,PR', 'SANTA FE, NM', 'SARASOTA-BRADENTON-VENICE, FL', 'SAVANNAH, GA', 'SC NONMETROPOLITAN AREA', 'SEBASTIAN-VERO BEACH, FL', 'SHERMAN-DENISON, TX', 'SHREVEPORT-BOSSIER CITY,LA', 'SOUTH BEND-MISHAWAKA, IN-MI', 'SPARTANBURG, SC', 'SPRINGFIELD, IL', 'ST. LOUIS, MO-IL', 'SUMTER, SC', 'TALLAHASSEE, FL', 'TAMPA-ST. PETERSBURG-CLEARWATER, FL', 'TERRE HAUTE, IN', 'TEXARKANA, TX-TEXARKANA,AR', 'TN NONMETROPOLITAN AREA', 'TOPEKA, KS'])                                   => -0.085745,
    (MSA_NAME in ['TUCSON, AZ', 'TULSA, OK', 'TUSCALOOSA, AL', 'VALDOSTA, GA', 'VI NONMETROPOLITAN AREA', 'VICTORIA, TX', 'VIRGINIA BEACH-NORFOLK-NEWPORT NEWS, VA-NC', 'WARNER ROBINS, GA', 'WICHITA FALLS, TX', 'WICHITA, KS', 'WILMINGTON, NC', 'WINSTON-SALEM, NC', 'YAUCO, PR', 'YUMA, AZ'])                                                                                                                                                                                                                           => -0.085745,
    (MSA_NAME in ['ALBANY-SCHENECTADY-TROY,NY', 'BANGOR, ME', 'BINGHAMTON, NY', 'BRIDGEPORT-STAMFORD-NORWALK,CT', 'BUFFALO-NIAGARA FALLS, NY', 'BURLINGTON-SOUTH BURLINGTON,VT', 'CT NONMETROPOLITAN AREA', 'ELMIRA, NY', 'GLENS FALLS, NY', 'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT', 'ITHACA, NY', 'KINGSTON, NY', 'LEWISTON-AUBURN, ME', 'MA NONMETROPOLITAN AREA', 'ME NONMETROPOLITAN AREA', 'NEW HAVEN-MILFORD, CT', 'NORWICH-NEW LONDON, CT', 'NY NONMETROPOLITAN AREA'])                                           => -0.095778,
    (MSA_NAME in ['PORTLAND-SOUTH PORTLAND-BIDDEFORD, ME', 'POUGHKEEPSIE-NEWBURGH-MIDDLETOWN, NY', 'ROCHESTER, NY', 'SYRACUSE, NY', 'UTICA-ROME, NY', 'VT NONMETROPOLITAN AREA', 'YORK-NORTHERN NEW JERSEY-LONG ISLAND, NY-NJ-PA'])                                                                                                                                                                                                                                                                                         => -0.095778,
    (MSA_NAME in ['CA NONMETROPOLITAN AREA', 'CARSON CITY, NV', 'LAS VEGAS-PARADISE, NV', 'LOS ANGELES-LONG BEACH-SANTAANA, CA', 'MADERA, CA', 'MERCED, CA', 'NV NONMETROPOLITAN AREA', 'RENO-SPARKS, NV', 'SALINAS, CA', 'SAN DIEGO-CARLSBAD-SAN MARCOS, CA', 'SAN FRANCISCO-OAKLAND-FREMONT, CA', 'SAN JOSE-SUNNYVALE-SANTACLARA, CA', 'SANTA BARBARA-SANTA MARIA LETA, CA', 'SANTA ROSA-PETALUMA, CA', 'VALLEJO-FAIRFIELD, CA', 'YUBA CITY, CA'])                                                                        => 0.001045,
    (MSA_NAME in ['ABILENE, TX', 'AUSTIN-ROUND ROCK, TX', 'BEAUMONT-PORT ARTHUR, TX', 'DALLAS-FORT WORTH-ARLINGTON,TX', 'HOUSTON-SUGAR LAND-BAYTOWN,TX', 'LAREDO, TX', 'LONGVIEW, TX', 'MCALLEN-EDINBURG-MISSION,TX', 'MIDLAND, TX', 'ODESSA, TX', 'SAN ANGELO, TX', 'TX NONMETROPOLITAN AREA', 'TYLER, TX', 'WACO, TX'])                                                                                                                                                                                                   => 0.109048,
    (MSA_NAME in ['AKRON, OH', 'AMES, IA', 'ANN ARBOR, MI', 'APPLETON, WI', 'AR NONMETROPOLITAN AREA', 'BATTLE CREEK, MI', 'BAY CITY, MI', 'BISMARCK, ND', 'CANTON-MASSILLON, OH', 'CEDAR RAPIDS, IA', 'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI', 'CINCINNATI-MIDDLETOWN, OH', 'CLEVELAND-ELYRIA-MENTOR,OH', 'COLUMBIA, MO', 'COLUMBUS, OH', 'DAVENPORT-MOLINE-ROCK ISLAND, IA-IL', 'DAYTON, OH', 'DES MOINES-WEST DES MOINES,IA', 'DETROIT-WARREN-LIVONIA, MI', 'DUBUQUE, IA', 'DULUTH, MN-WI', 'EAU CLAIRE, WI'])             => 0.089463,
    (MSA_NAME in ['FARGO, ND-MN', 'FAYETTEVILLE-SPRINGDALE-ROGERS, AR-MO', 'FLINT, MI', 'FOND DU LAC, WI', 'FORT SMITH, AR-OK', 'GRAND FORKS, ND-MN', 'GRAND RAPIDS-WYOMING, MI', 'GREEN BAY, WI', 'HOLLAND-GRAND HAVEN, MI', 'HOT SPRINGS, AR', 'IA NONMETROPOLITAN AREA', 'IOWA CITY, IA', 'JACKSON, MI', 'JANESVILLE, WI', 'JEFFERSON CITY, MO', 'JONESBORO, AR', 'JOPLIN, MO', 'KALAMAZOO-PORTAGE, MI', 'KANSAS CITY, MO-KS', 'LA CROSSE, WI-MN', 'LANSING-EAST LANSING, MI', 'LIMA, OH', 'LINCOLN, NE'])               => 0.089463,
    (MSA_NAME in ['LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR', 'MADISON, WI', 'MANKATO-NORTH MANKATO, MN', 'MANSFIELD, OH', 'MI NONMETROPOLITAN AREA', 'MILWAUKEE-WAUKESHA-WEST ALLIS, WI', 'MINNEAPOLIS-ST. PAUL-BLOOMINGTON, MN-WI', 'MN NONMETROPOLITAN AREA', 'MO NONMETROPOLITAN AREA', 'MONROE, MI', 'MUSKEGON-NORTON SHORES, MI', 'ND NONMETROPOLITAN AREA', 'NE NONMETROPOLITAN AREA', 'NILES-BENTON HARBOR, MI', 'OH NONMETROPOLITAN AREA', 'OMAHA-COUNCIL BLUFFS, NE-IA', 'OSHKOSH-NEENAH, WI'])                    => 0.089463,
    (MSA_NAME in ['PARKERSBURG-MARIETTA-VIENNA,WV-OH', 'PINE BLUFF, AR', 'RACINE, WI', 'RAPID CITY, SD', 'ROCHESTER, MN', 'SAGINAW-SAGINAW TOWNSHIPNORTH, MI', 'SANDUSKY, OH', 'SD NONMETROPOLITAN AREA', 'SHEBOYGAN, WI', 'SIOUX CITY, IA-NE-SD', 'SIOUX FALLS, SD', 'SPRINGFIELD, MO', 'SPRINGFIELD, OH', 'ST. CLOUD, MN', 'ST. JOSEPH, MO-KS', 'TOLEDO, OH', 'WATERLOO-CEDAR FALLS, IA', 'WAUSAU, WI', 'WEIRTON-STEUBENVILLE, WV-OH', 'WHEELING, WV-OH', 'WI NONMETROPOLITAN AREA', 'YOUNGSTOWN-WARREN-BOARDMAN,OH-PA']) => 0.089463,
    (MSA_NAME in ['ALLENTOWN-BETHLEHEM-EASTON,PA-NJ', 'ALTOONA, PA', 'ATLANTIC CITY, NJ', 'BALTIMORE-TOWSON, MD', 'BARNSTABLE TOWN, MA', 'BLACKSBURG-CHRISTIANSBURG DFORD, VA', 'BOSTON-CAMBRIDGE-QUINCY,MA-NH', 'CHARLESTON, WV', 'CHARLOTTESVILLE, VA', 'CUMBERLAND, MD-WV', 'DANVILLE, VA', 'DE NONMETROPOLITAN AREA', 'DOVER, DE', 'ERIE, PA', 'HAGERSTOWN-MARTINSBURG, MD-WV', 'HARRISBURG-CARLISLE, PA', 'HARRISONBURG, VA', 'JOHNSTOWN, PA', 'KINGSPORT-BRISTOL-BRISTOL, TN-VA', 'LANCASTER, PA', 'LEBANON, PA'])    => 0.037961,
    (MSA_NAME in ['LYNCHBURG, VA', 'MANCHESTER-NASHUA, NH', 'MD NONMETROPOLITAN AREA', 'MORGANTOWN, WV', 'NEW YORK-NORTHERN NEW JERSEY', 'NH NONMETROPOLITAN AREA', 'OCEAN CITY, NJ', 'PA NONMETROPOLITAN AREA', 'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD', 'PITTSBURGH, PA', 'PITTSFIELD, MA', 'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA', 'READING, PA', 'RICHMOND, VA', 'ROANOKE, VA', 'SALISBURY, MD', 'SCRANTON--WILKES-BARRE, PA', 'SPRINGFIELD, MA', 'STATE COLLEGE, PA', 'TRENTON-EWING, NJ'])                   => 0.037961,
    (MSA_NAME in ['VA NONMETROPOLITAN AREA', 'VINELAND-MILLVILLE-BRIDGETON, NJ', 'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV', 'WILLIAMSPORT, PA', 'WINCHESTER, VA-WV', 'WORCESTER, MA', 'WV NONMETROPOLITAN AREA', 'YORK-HANOVER, PA'])                                                                                                                                                                                                                                                                                  => 0.037961,
    (MSA_NAME in ['BELLINGHAM, WA', 'BEND, OR', 'BILLINGS, MT', 'BOISE CITY-NAMPA, ID', 'BREMERTON-SILVERDALE, WA', 'CASPER, WY', 'CHEYENNE, WY', 'COEUR DALENE, ID', 'CORVALIS, OR', 'EUGENE-SPRINGFIELD, OR', 'GREAT FALLS, MT', 'ID NONMETROPOLITAN AREA', 'IDAHO FALLS, ID', 'KENNEWICK-RICHLAND-PASCO,WA', 'LEWISTON, ID-WA', 'LOGAN, UT-ID', 'LONGVIEW, WA', 'MEDFORD, OR', 'MISSOULA, MT', 'MOUNT VERNON-ANACORTES, WA', 'MT NONMETROPOLITAN AREA', 'OLYMPIA, WA', 'OR NONMETROPOLITAN AREA', 'POCATELLO, ID'])      => 0.411657,
    (MSA_NAME in ['PORTLAND-VANCOUVER-BEAVERTON, OR-WA', 'SALEM, OR', 'SEATTLE-TACOMA-BELLEVUE,WA', 'SPOKANE, WA', 'WA NONMETROPOLITAN AREA', 'WENATCHEE, WA', 'WY NONMETROPOLITAN AREA', 'YAKIMA, WA'])                                                                                                                                                                                                                                                                                                                    => 0.411657,
    (MSA_NAME in ['AK NONMETROPOLITAN AREA', 'ANCHORAGE, AK', 'ARMED FORCES', 'FAIRBANKS, AK', 'HI NONMETROPOLITAN AREA', 'HONOLULU, HI'])                                                                                                                                                                                                                                                                                                                                                                                  => 0.523233,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0.000000);

otr_subscore9 := map(
    NULL < iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 1   => -0.032246,
    1 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 37    => -0.078192,
    37 <= iv_dist_inp_addr_to_prv_addr AND iv_dist_inp_addr_to_prv_addr < 1333 => 0.126324,
    1333 <= iv_dist_inp_addr_to_prv_addr                                       => 0.187306,
                                                                                  -0.000000);

otr_subscore10 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.050240,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.106460,
    3 <= iv_ms001_ssns_per_adl                                 => -0.339267,
                                                                  0.000000);

otr_subscore11 := map(
    ((string)iv_college_attendance_x_age in ['N10', 'N20', 'N30', 'N40'])               => -0.063177,
    ((string)iv_college_attendance_x_age in ['N50'])                                    => 0.000413,
    ((string)iv_college_attendance_x_age in ['N60'])                                    => 0.136797,
    ((string)iv_college_attendance_x_age in ['Y10', 'Y20', 'Y30', 'Y40', 'Y50', 'Y60']) => 0.254036,
                                                                                   -0.000000);

otr_subscore12 := map(
    (iv_ams_college_tier in [' '])                => -0.000000,
    (iv_ams_college_tier in ['-1'])               => -0.017225,
    (iv_ams_college_tier in ['1'])                => 1.312409,
    (iv_ams_college_tier in ['2'])                => 0.691076,
    (iv_ams_college_tier in ['3'])                => 0.368140,
    (iv_ams_college_tier in ['0', '4', '5', '6']) => -0.011873,
                                                     -0.000000);

otr_subscore13 := map(
    NULL < iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen < 0 => -0.026812,
    0 <= iv_mos_since_paw_first_seen AND iv_mos_since_paw_first_seen < 64  => 0.229178,
    64 <= iv_mos_since_paw_first_seen                                      => 0.446091,
                                                                              0.000000);

otr_subscore14 := map(
    NULL < iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 1         => -0.008888,
    1 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 117916      => -0.094168,
    117916 <= iv_pv001_bst_avm_autoval AND iv_pv001_bst_avm_autoval < 564730 => 0.071186,
    564730 <= iv_pv001_bst_avm_autoval                                       => 0.277164,
                                                                                -0.000000);

otr_rawscore := otr_subscore0 +
    otr_subscore1 +
    otr_subscore2 +
    otr_subscore3 +
    otr_subscore4 +
    otr_subscore5 +
    otr_subscore6 +
    otr_subscore7 +
    otr_subscore8 +
    otr_subscore9 +
    otr_subscore10 +
    otr_subscore11 +
    otr_subscore12 +
    otr_subscore13 +
    otr_subscore14;

otr_lnoddsscore := otr_rawscore + 2.694138;

otr_probscore := exp(otr_lnoddsscore) / (1 + exp(otr_lnoddsscore));

iv_ed001_college_ind := map(
    not(truedid)                                                                                                                                                    => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or not (ams_college_tier = '') or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                                                                                                             => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                                                                                                          => '1',
                                                                                                                                                                       '0');

base := 700;

point := 40;

odds := (1 - 0.037) / 0.037;

rvb1310_1_0 := map(
    segment_40 = 'X 200  ' => 200,
    segment_40 = 'X 222  ' => 222,
    segment_40 = '0 Derog' => max(min(if(round(point * (ln(drg_probscore / (1 - drg_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(drg_probscore / (1 - drg_probscore)) - ln(odds)) / ln(2) + base)), 900), 501),
    segment_40 = '1 Young' => max(min(if(round(point * (ln(yng_probscore / (1 - yng_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(yng_probscore / (1 - yng_probscore)) - ln(odds)) / ln(2) + base)), 900), 501),
    segment_40 = '2 Owner' => max(min(if(round(point * (ln(own_probscore / (1 - own_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(own_probscore / (1 - own_probscore)) - ln(odds)) / ln(2) + base)), 900), 501),
                              max(min(if(round(point * (ln(otr_probscore / (1 - otr_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(otr_probscore / (1 - otr_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));

rc1_3 := '';

rc2_3 := '';

rc3_2 := '';

rc4_2 := '';

rc5_3 := '';

drg_glrc36 := trim(segment_40, LEFT, RIGHT) = '0 Derog';

drg_glrc97 := trim(segment_40, LEFT, RIGHT) = '0 Derog' and criminal_count > 0 or felony_count > 0;

drg_glrc98 := trim(segment_40, LEFT, RIGHT) = '0 Derog' and liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 or liens_recent_released_count > 0 or liens_historical_released_count > 0;

drg_glrc9a := trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)add1_pop = 1 and property_owned_total = 0 and add1_naprop < 4;

drg_glrc9h := trim(segment_40, LEFT, RIGHT) = '0 Derog' and impulse_count > 0;

drg_glrc9i := trim(segment_40, LEFT, RIGHT) = '0 Derog' and iv_ed001_college_ind = '0' and age < 30;

drg_glrc9j := trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1 and iv_sr001_m_hdr_fs < 240;

drg_glrc9p := trim(segment_40, LEFT, RIGHT) = '0 Derog' and inq_HighRiskCredit_count12 > 0;

drg_glrc9q := trim(segment_40, LEFT, RIGHT) = '0 Derog' and inq_auto_count12 > 0;

drg_glrc9r := trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1;

drg_glrc9w := trim(segment_40, LEFT, RIGHT) = '0 Derog' and filing_count > 0;

drg_glrc9y := trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1 and pb_total_dollars = '';

drg_glrcev := trim(segment_40, LEFT, RIGHT) = '0 Derog' and attr_eviction_count > 0;

drg_glrcms := trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1;

drg_glrcpv := trim(segment_40, LEFT, RIGHT) = '0 Derog' and 1 <= add1_assessed_total_value AND add1_assessed_total_value <= 200000 or 1 <= add2_assessed_total_value AND add2_assessed_total_value <= 200000;

drg_glrcbl := 0;

yng_glrc03 := trim(segment_40, LEFT, RIGHT) = '1 Young' and (iv_vs002_ssn_prior_dob in ['1']);

yng_glrc36 := trim(segment_40, LEFT, RIGHT) = '1 Young';

yng_glrc9a := trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)add1_pop = 1 and property_owned_total = 0 and add1_naprop < 4;

yng_glrc9i := trim(segment_40, LEFT, RIGHT) = '1 Young' and iv_ed001_college_ind = '0' and age < 30;

yng_glrc9j := trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)truedid = 1 and iv_sr001_m_hdr_fs < 240;

yng_glrc9l := trim(segment_40, LEFT, RIGHT) = '1 Young' and 0 < dist_a1toa2 AND dist_a1toa2 < 9999;

yng_glrc9q := trim(segment_40, LEFT, RIGHT) = '1 Young' and inq_auto_count12 > 0;

yng_glrc9r := trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)truedid = 1;

yng_glrc9y := trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)truedid = 1 and pb_total_dollars =' ';

yng_glrcmi := trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)ssnlength > 0;

yng_glrcpv := trim(segment_40, LEFT, RIGHT) = '1 Young' and 1 <= add1_assessed_total_value AND add1_assessed_total_value <= 200000;

yng_glrcbl := 0;

own_glrc36 := trim(segment_40, LEFT, RIGHT) = '2 Owner';

own_glrc9d := trim(segment_40, LEFT, RIGHT) = '2 Owner' and unique_addr_count > 1;

own_glrc9e := trim(segment_40, LEFT, RIGHT) = '2 Owner' and (string)add1_pop = '1';

own_glrc9i := trim(segment_40, LEFT, RIGHT) = '2 Owner' and iv_ed001_college_ind = '0' and age < 30;

own_glrc9l := trim(segment_40, LEFT, RIGHT) = '2 Owner' and 0 < dist_a1toa2 AND dist_a1toa2 < 9999 or 0 < dist_a2toa3 AND dist_a2toa3 < 9999;

own_glrc9q := trim(segment_40, LEFT, RIGHT) = '2 Owner' and inq_auto_count12 > 0;

own_glrc9r := trim(segment_40, LEFT, RIGHT) = '2 Owner' and (integer)truedid = 1;

own_glrc9y := trim(segment_40, LEFT, RIGHT) = '2 Owner' and (integer)truedid = 1 and  pb_total_dollars =' ';

own_glrc9s := trim(segment_40, LEFT, RIGHT) = '2 Owner' and not(((string)add1_mortgage_date in ['0', ' '])) and not((add1_mortgage_type in ['U', ' '])) and add1_naprop = 4;

own_glrcpv := trim(segment_40, LEFT, RIGHT) = '2 Owner' and 1 <= add1_avm_automated_valuation AND add1_avm_automated_valuation <= 200000 or 1 <= add2_avm_automated_valuation AND add2_avm_automated_valuation <= 200000;

own_glrcbl := 0;

otr_glrc36 := trim(segment_40, LEFT, RIGHT) = '3 Other';

otr_glrc9d := trim(segment_40, LEFT, RIGHT) = '3 Other' and unique_addr_count > 1;

otr_glrc9e := trim(segment_40, LEFT, RIGHT) = '3 Other' and (integer)add1_pop = 1;

otr_glrc9i := trim(segment_40, LEFT, RIGHT) = '3 Other' and iv_ed001_college_ind = '0' and age < 30;

otr_glrc9l := trim(segment_40, LEFT, RIGHT) = '3 Other' and 0 < dist_a1toa2 AND dist_a1toa2 < 9999 or 0 < dist_a1toa3 AND dist_a1toa3 < 9999;

otr_glrc9p := trim(segment_40, LEFT, RIGHT) = '3 Other' and inq_HighRiskCredit_count12 > 0;

otr_glrc9q := trim(segment_40, LEFT, RIGHT) = '3 Other' and inq_auto_count12 > 0;

otr_glrc9y := trim(segment_40, LEFT, RIGHT) = '3 Other' and (integer)truedid = 1 and  pb_total_dollars = '';

otr_glrcms := trim(segment_40, LEFT, RIGHT) = '3 Other' and (integer)truedid = 1;

otr_glrcpv := trim(segment_40, LEFT, RIGHT) = '3 Other' and 1 <= add1_avm_automated_valuation AND add1_avm_automated_valuation <= 200000;

otr_glrcbl := 0;

bk := filing_count > 0;

eviction := attr_eviction_count > 0;

lien := liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0;

pdl := impulse_count > 0;

derogsum := if(max((integer)bk, (integer)eviction, (integer)lien, (integer)pdl) = NULL, NULL, sum((integer)bk, (integer)eviction, (integer)lien, (integer)pdl));

seg_glrc97 := if(derogsum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1 and criminal_count > 0) / derogsum, 0);

seg_glrc98 := if(derogsum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1 and (liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0)) / derogsum, 0);

seg_glrc9a := trim(segment_40, LEFT, RIGHT) = '3 Other' and (integer)add1_pop = 1 and property_owned_total = 0 and add1_naprop < 4;

seg_glrc9h := if(derogsum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1 and impulse_count > 0) / derogsum, 0);

seg_glrc9r := trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)truedid = 1 and inferred_age <= 24;

seg_glrc9w := if(derogsum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1 and filing_count > 0) / derogsum, 0);

seg_glrcev := if(derogsum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)truedid = 1 and attr_eviction_count > 0) / derogsum, 0);

no_addr_ver := (nap_summary in [0, 1, 2, 4, 7, 9]) and (nas_summary in [0, 1, 2, 4, 7, 9]);
length_res := add1_lres < 60;

source_confirm_date := (integer)truedid = 1 and iv_sr001_m_hdr_fs < 240;

est_inc_sum := if(max((integer)no_addr_ver, length_res, (integer)source_confirm_date) = NULL, NULL, sum((integer)no_addr_ver, if((integer)length_res = NULL, 0, (integer)length_res), (integer)source_confirm_date));

drg_glrc25 := if(est_inc_sum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)no_addr_ver = 1) / est_inc_sum, 0);

drg_glrc9c := if(est_inc_sum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)length_res = 1) / est_inc_sum, 0);

drg_glrc9f := if(est_inc_sum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '0 Derog' and (integer)source_confirm_date = 1) / est_inc_sum, 0);

yng_glrc25 := if(est_inc_sum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)no_addr_ver = 1) / est_inc_sum, 0);

yng_glrc9c := if(est_inc_sum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)length_res = 1) / est_inc_sum, 0);

yng_glrc9f := if(est_inc_sum > 0, (integer)(trim(segment_40, LEFT, RIGHT) = '1 Young' and (integer)source_confirm_date = 1) / est_inc_sum, 0);

rcvalue25_1 := drg_glrc25 * (0.722400 - drg_subscore0);

rcvalue25_2 := yng_glrc25 * (0.494859 - yng_subscore8);

rcvalue25 := if(max(rcvalue25_1, rcvalue25_2) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1), if(rcvalue25_2 = NULL, 0, rcvalue25_2)));

rcvalue9c_1 := drg_glrc9c * (0.722400 - drg_subscore0);

rcvalue9c_2 := yng_glrc9c * (0.494859 - yng_subscore8);

rcvalue9c := if(max(rcvalue9c_1, rcvalue9c_2) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1), if(rcvalue9c_2 = NULL, 0, rcvalue9c_2)));

rcvalue9f_1 := drg_glrc9f * (0.722400 - drg_subscore0);

rcvalue9f_2 := yng_glrc9f * (0.494859 - yng_subscore8);

rcvalue9f := if(max(rcvalue9f_1, rcvalue9f_2) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1), if(rcvalue9f_2 = NULL, 0, rcvalue9f_2)));

rcvalue03_1 := (integer)yng_glrc03 * (0.040399 - yng_subscore6);

rcvalue03 := if(max(rcvalue03_1) = NULL, NULL, sum(if(rcvalue03_1 = NULL, 0, rcvalue03_1)));

rcvalue36_1 := (integer)drg_glrc36 * (0.378597 - drg_subscore5);

rcvalue36_2 := (integer)drg_glrc36 * (0.415695 - drg_subscore17);

rcvalue36_3 := (integer)yng_glrc36 * (0.633862 - yng_subscore5);

rcvalue36_4 := (integer)yng_glrc36 * (0.164723 - yng_subscore16);

rcvalue36_5 := (integer)yng_glrc36 * (0.313046 - yng_subscore19);

rcvalue36_6 := (integer)yng_glrc36 * (0.334544 - yng_subscore20);

rcvalue36_7 := (integer)own_glrc36 * (0.448054 - own_subscore1);

rcvalue36_8 := (integer)own_glrc36 * (0.291088 - own_subscore12);

rcvalue36_9 := (integer)otr_glrc36 * (0.546339 - otr_subscore1);

rcvalue36_10 := (integer)otr_glrc36 * (0.461454 - otr_subscore9);

rcvalue36 := if(max(rcvalue36_1, rcvalue36_2, rcvalue36_3, rcvalue36_4, rcvalue36_5, rcvalue36_6, rcvalue36_7, rcvalue36_8, rcvalue36_9, rcvalue36_10) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1), if(rcvalue36_2 = NULL, 0, rcvalue36_2), if(rcvalue36_3 = NULL, 0, rcvalue36_3), if(rcvalue36_4 = NULL, 0, rcvalue36_4), if(rcvalue36_5 = NULL, 0, rcvalue36_5), if(rcvalue36_6 = NULL, 0, rcvalue36_6), if(rcvalue36_7 = NULL, 0, rcvalue36_7), if(rcvalue36_8 = NULL, 0, rcvalue36_8), if(rcvalue36_9 = NULL, 0, rcvalue36_9), if(rcvalue36_10 = NULL, 0, rcvalue36_10)));

rcvalue97_1 := (integer)drg_glrc97 * (0.042718 - drg_subscore6);

rcvalue97_2 := seg_glrc97 * (3.9167 - 2.3015);

rcvalue97 := if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvalue98_1 := (integer)drg_glrc98 * (0.167730 - drg_subscore2);

rcvalue98_2 := seg_glrc98 * (3.9167 - 2.3015);

rcvalue98 := if(max(rcvalue98_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));

rcvalue9a_1 := (integer)drg_glrc9a * (0.279099 - drg_subscore4);

rcvalue9a_2 := (integer)yng_glrc9a * (0.367149 - yng_subscore2);

rcvalue9a_3 := (integer)seg_glrc9a * (3.9167 - 3.0619);

rcvalue9a := if(max(rcvalue9a_1, rcvalue9a_2, rcvalue9a_3) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2), if(rcvalue9a_3 = NULL, 0, rcvalue9a_3)));

rcvalue9d_1 := (integer)own_glrc9d * (0.315757 - own_subscore3);

rcvalue9d_2 := (integer)otr_glrc9d * (0.292185 - otr_subscore3);

rcvalue9d := if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));

rcvalue9e_1 := (integer)own_glrc9e * (0.309127 - own_subscore4);

rcvalue9e_2 := (integer)otr_glrc9e * (0.336926 - otr_subscore2);

rcvalue9e := if(max(rcvalue9e_1, rcvalue9e_2) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2)));

rcvalue9h_1 := (integer)drg_glrc9h * (0.077708 - drg_subscore1);

rcvalue9h_2 := seg_glrc9h * (3.9167 - 2.3015);

rcvalue9h := if(max(rcvalue9h_1, rcvalue9h_2) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1), if(rcvalue9h_2 = NULL, 0, rcvalue9h_2)));

rcvalue9i_1 := (integer)drg_glrc9i * (0.951630 - drg_subscore10);

rcvalue9i_2 := (integer)yng_glrc9i * (0.816791 - yng_subscore1);

rcvalue9i_3 := (integer)own_glrc9i * (0.518018 - own_subscore9);

rcvalue9i_4 := (integer)otr_glrc9i * (0.678330 - otr_subscore7);

rcvalue9i_5 := (integer)otr_glrc9i * (0.248481 - otr_subscore11);

rcvalue9i := if(max(rcvalue9i_1, rcvalue9i_2, rcvalue9i_3, rcvalue9i_4, rcvalue9i_5) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1), if(rcvalue9i_2 = NULL, 0, rcvalue9i_2), if(rcvalue9i_3 = NULL, 0, rcvalue9i_3), if(rcvalue9i_4 = NULL, 0, rcvalue9i_4), if(rcvalue9i_5 = NULL, 0, rcvalue9i_5)));

rcvalue9j_1 := (integer)drg_glrc9j * (0.279331 - drg_subscore3);

rcvalue9j_2 := (integer)yng_glrc9j * (0.025071 - yng_subscore17);

rcvalue9j := if(max(rcvalue9j_1, rcvalue9j_2) = NULL, NULL, sum(if(rcvalue9j_1 = NULL, 0, rcvalue9j_1), if(rcvalue9j_2 = NULL, 0, rcvalue9j_2)));

rcvalue9l_1 := (integer)yng_glrc9l * (0.061306 - yng_subscore11);

rcvalue9l_2 := (integer)own_glrc9l * (0.124412 - own_subscore13);

rcvalue9l_3 := (integer)otr_glrc9l * (0.196267 - otr_subscore10);

rcvalue9l := if(max(rcvalue9l_1, rcvalue9l_2, rcvalue9l_3) = NULL, NULL, sum(if(rcvalue9l_1 = NULL, 0, rcvalue9l_1), if(rcvalue9l_2 = NULL, 0, rcvalue9l_2), if(rcvalue9l_3 = NULL, 0, rcvalue9l_3)));

rcvalue9p_1 := (integer)drg_glrc9p * (0.018527 - drg_subscore11);

rcvalue9p_2 := (integer)otr_glrc9p * (0.008959 - otr_subscore12);

rcvalue9p := if(max(rcvalue9p_1, rcvalue9p_2) = NULL, NULL, sum(if(rcvalue9p_1 = NULL, 0, rcvalue9p_1), if(rcvalue9p_2 = NULL, 0, rcvalue9p_2)));

rcvalue9q_1 := (integer)drg_glrc9q * (0.027307 - drg_subscore13);

rcvalue9q_2 := (integer)yng_glrc9q * (0.021870 - yng_subscore10);

rcvalue9q_3 := (integer)own_glrc9q * (0.014526 - own_subscore7);

rcvalue9q_4 := (integer)otr_glrc9q * (0.020950 - otr_subscore8);

rcvalue9q := if(max(rcvalue9q_1, rcvalue9q_2, rcvalue9q_3, rcvalue9q_4) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1), if(rcvalue9q_2 = NULL, 0, rcvalue9q_2), if(rcvalue9q_3 = NULL, 0, rcvalue9q_3), if(rcvalue9q_4 = NULL, 0, rcvalue9q_4)));

rcvalue9r_1 := (integer)drg_glrc9r * (0.037995 - drg_subscore18);

rcvalue9r_2 := (integer)yng_glrc9r * (0.372427 - yng_subscore0);

rcvalue9r_3 := (integer)own_glrc9r * (0.182060 - own_subscore2);

rcvalue9r_4 := (integer)seg_glrc9r * (3.9167 - 3.0359);

rcvalue9r := if(max(rcvalue9r_1, rcvalue9r_2, rcvalue9r_3, rcvalue9r_4) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2), if(rcvalue9r_3 = NULL, 0, rcvalue9r_3), if(rcvalue9r_4 = NULL, 0, rcvalue9r_4)));

rcvalue9s_1 := (integer)own_glrc9s * (0.28817 - own_subscore5);

rcvalue9s := if(max(rcvalue9s_1) = NULL, NULL, sum(if(rcvalue9s_1 = NULL, 0, rcvalue9s_1)));

rcvalue9w_1 := (integer)drg_glrc9w * (0.389018 - drg_subscore12);

rcvalue9w_2 := seg_glrc9w * (3.9167 - 2.3015);

rcvalue9w := if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

rcvalue9y_1 := (integer)drg_glrc9y * (0.320309 - drg_subscore7);

rcvalue9y_2 := (integer)yng_glrc9y * (0.389284 - yng_subscore14);

rcvalue9y_3 := (integer)own_glrc9y * (0.072949 - own_subscore14);

rcvalue9y_4 := (integer)otr_glrc9y * (0.207852 - otr_subscore5);

// rcvalue9y := if(max(rcvalue9y_1, rcvalue9y_2, rcvalue9y_3, rcvalue9y_4) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1), if(rcvalue9y_2 = NULL, 0, rcvalue9y_2), if(rcvalue9y_3 = NULL, 0, rcvalue9y_3), if(rcvalue9y_4 = NULL, 0, rcvalue9y_4)));
rcvalue9y := 0;

rcvalueev_1 := (integer)drg_glrcev * (0.028275 - drg_subscore16);

rcvalueev_2 := seg_glrcev * (3.9167 - 2.3015);

rcvalueev := if(max(rcvalueev_1, rcvalueev_2) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1), if(rcvalueev_2 = NULL, 0, rcvalueev_2)));

rcvaluemi_1 := (integer)yng_glrcmi * (0.052371 - yng_subscore13);

rcvaluemi := if(max(rcvaluemi_1) = NULL, NULL, sum(if(rcvaluemi_1 = NULL, 0, rcvaluemi_1)));

rcvaluems_1 := (integer)drg_glrcms * (0.050952 - drg_subscore15);

rcvaluems_2 := (integer)otr_glrcms * (0.038084 - otr_subscore13);

rcvaluems := if(max(rcvaluems_1, rcvaluems_2) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1), if(rcvaluems_2 = NULL, 0, rcvaluems_2)));

rcvaluepv_1 := (integer)drg_glrcpv * (0.266316 - drg_subscore14);

rcvaluepv_2_1 := (integer)yng_glrcpv * (0.287786 - yng_subscore9);

rcvaluepv_3 := (integer)own_glrcpv * (0.301808 - own_subscore10);

rcvaluepv_2 := if((integer)add1_pop = 1 and property_owned_assessed_count > 0, rcvaluepv_2_1, 0);

rcvaluepv_4 := if((integer)add1_pop = 1 and property_owned_assessed_count > 0, (integer)own_glrcpv * (0.078681 - own_subscore11), NULL);

rcvaluepv_5 := (integer)otr_glrcpv * (0.275657 - otr_subscore14);

rcvaluepv := if(max(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3, rcvaluepv_4, rcvaluepv_5) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2), if(rcvaluepv_3 = NULL, 0, rcvaluepv_3), if(rcvaluepv_4 = NULL, 0, rcvaluepv_4), if(rcvaluepv_5 = NULL, 0, rcvaluepv_5)));

rcvaluebl_1 := drg_glrcbl * (0.722400 - drg_subscore0);

rcvaluebl_2 := drg_glrcbl * (0.742961 - drg_subscore8);

rcvaluebl_3 := drg_glrcbl * (0.174638 - drg_subscore9);

rcvaluebl_4 := drg_glrcbl * (0.058202 - drg_subscore19);

rcvaluebl_5 := yng_glrcbl * (0.859889 - yng_subscore3);

rcvaluebl_6 := yng_glrcbl * (0.161046 - yng_subscore4);

rcvaluebl_7 := yng_glrcbl * (0.234843 - yng_subscore7);

rcvaluebl_8 := yng_glrcbl * (0.494859 - yng_subscore8);

rcvaluebl_9 := yng_glrcbl * (0.312758 - yng_subscore12);

rcvaluebl_10 := yng_glrcbl * (0.038534 - yng_subscore15);

rcvaluebl_11 := yng_glrcbl * (0.110517 - yng_subscore18);

rcvaluebl_12 := own_glrcbl * (0.595361 - own_subscore0);

rcvaluebl_13 := own_glrcbl * (0.172493 - own_subscore6);

rcvaluebl_14 := own_glrcbl * (0.185579 - own_subscore8);

rcvaluebl_15 := own_glrcbl * (0.072979 - own_subscore15);

rcvaluebl_16 := own_glrcbl * (0.074859 - own_subscore16);

rcvaluebl_17 := otr_glrcbl * (0.669040 - otr_subscore0);

rcvaluebl_18 := otr_glrcbl * (0.273634 - otr_subscore4);

rcvaluebl_19 := otr_glrcbl * (0.598911 - otr_subscore6);

rcvaluebl := if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5, rcvaluebl_6, rcvaluebl_7, rcvaluebl_8, rcvaluebl_9, rcvaluebl_10, rcvaluebl_11, rcvaluebl_12, rcvaluebl_13, rcvaluebl_14, rcvaluebl_15, rcvaluebl_16, rcvaluebl_17, rcvaluebl_18, rcvaluebl_19) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5), if(rcvaluebl_6 = NULL, 0, rcvaluebl_6), if(rcvaluebl_7 = NULL, 0, rcvaluebl_7), if(rcvaluebl_8 = NULL, 0, rcvaluebl_8), if(rcvaluebl_9 = NULL, 0, rcvaluebl_9), if(rcvaluebl_10 = NULL, 0, rcvaluebl_10), if(rcvaluebl_11 = NULL, 0, rcvaluebl_11), if(rcvaluebl_12 = NULL, 0, rcvaluebl_12), if(rcvaluebl_13 = NULL, 0, rcvaluebl_13), if(rcvaluebl_14 = NULL, 0, rcvaluebl_14), if(rcvaluebl_15 = NULL, 0, rcvaluebl_15), if(rcvaluebl_16 = NULL, 0, rcvaluebl_16), if(rcvaluebl_17 = NULL, 0, rcvaluebl_17), if(rcvaluebl_18 = NULL, 0, rcvaluebl_18), if(rcvaluebl_19 = NULL, 0, rcvaluebl_19)));

// rc5_2 := if(((integer)drg_glrc9q > 0 or (integer)yng_glrc9q > 0 or (integer)own_glrc9q > 0 or (integer)otr_glrc9q > 0 or (integer)drg_glrc9p > 0 or (integer)otr_glrc9p > 0) and not((rc1_3 in ['9Q', '9P'])) and not((rc2_3 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])) and (rcvalue9q > 0 or rcvalue9p > 0), '9Q', rc5_3);
glrc9q_temp := ((integer)drg_glrc9q > 0 or (integer)yng_glrc9q > 0 or (integer)own_glrc9q > 0 or (integer)otr_glrc9q > 0 or (integer)drg_glrc9p > 0 or (integer)otr_glrc9p > 0) and not((rc1_3 in ['9Q', '9P'])) and not((rc2_3 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])) and (rcvalue9q > 0 or rcvalue9p > 0);

// rc1_2 := map(
    // rvb1310_1_0 = 200 => '02',
                         // '9X');

// rc4_1 := map(
    // rvb1310_1_0 = 200 => '',
                         // '');

// rc2_2 := map(
    // rvb1310_1_0 = 200 => '',
                         // '');

// rc3_1 := map(
    // rvb1310_1_0 = 200 => '',
                         // '');

// rc5_1 := map(
    // rvb1310_1_0 = 200 => '',
                         // '');

// rc1_1 := if(rc1_2 = '', '36', rc1_2);

// rc1 := if(rvb1310_1_0 = 900, (string)NULL, rc1_1);

// rc4 := if(rvb1310_1_0 = 900, '', rc4_1);

// rc2_1 := if(rvb1310_1_0 = 900, '', rc2_2);

// rc3 := if(rvb1310_1_0 = 900, '', rc3_1);

// rc5 := if(rvb1310_1_0 = 900, '', rc5_1);

// rc2 := if(rc2_1 = '' and not((rc1 in ['02', '9X', '35', '36', '91', '92', '93', '94'])), '36', rc2_1);
// rc2 := if(rc2_1 = '' and not((rc1 in ['02', '9X', '35', '36', '91', '92', '93', '94'])), '36', rc2_1);

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
		{'25', RCValue25},
		{'9C', RCValue9C},
		{'9F',RCValue9f},
	{'03',RCValue03},
	{'36',RCValue36},
	{'97',RCValue97},
	{'98',RCValue98},
	{'9A',RCValue9a},
	{'9D',RCValue9d},
	{'9E',RCValue9e},
	{'9H',RCValue9h},
	{'9I',RCValue9i},
	{'9J',RCValue9j},
	{'9L',RCValue9l},
	{'9P',RCValue9p},
	{'9Q',RCValue9q},
	{'9R',RCValue9r},
	{'9S',RCValue9s},
	{'9W',RCValue9w},
	{'9Y',RCValue9y},
	{'EV',RCValueEv},
	{'MI',RCValueMi},
	{'MS',RCValueMs},
	{'PV',RCValuePv},
	{'BL',RCValuebl}
 ], ds_layout)(value > 0);
 

	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes
	rcs_top := if(count(rcs_top4(rc != ''))=0, DATASET([{'36', NULL}], ds_layout), rcs_top4);
	
	// rcs_9q := rcs_top & if(glrc9q_temp AND  (count(rcs_top4(rc='9Q')) =0) and (count(rcs_top4(rc='9P')) =0), ROW({'9Q', NULL}, ds_layout));
	rcs_9q := rcs_top & if(glrc9q_temp AND (count(rcs_top4(rc IN ['9Q', '9P'])) =0), ROW({'9Q', NULL}, ds_layout));

	
	

	rcs_override := MAP(
											rvb1310_1_0 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvb1310_1_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
											rvb1310_1_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
												rcs_9q
										);
	
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
	rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
				SELF.hri := LEFT.rc,
				SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
			));

	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
					
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

		#if(RVB_DEBUG)
			self.clam                             := le;
			//risk_indicators.Layout_Boca_Shell clam;
			self.sysdate                          := sysdate;
			self.iv_riskview_222s                 := iv_riskview_222s;
			self.ssn_deceased                     := ssn_deceased;
			self.ver_src_ba                       := ver_src_ba;
			self.bk_flag                          := bk_flag;
			self.ver_src_l2                       := ver_src_l2;
			self.ver_src_li                       := ver_src_li;
			self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
			self.lien_flag                        := lien_flag;
			self.property_owner                   := property_owner;
			self.pk_impulse_count                 := pk_impulse_count;
			self.bs_attr_derog_flag               := bs_attr_derog_flag;
			self.bs_attr_eviction_flag            := bs_attr_eviction_flag;
			self.bs_attr_derog_flag2              := bs_attr_derog_flag2;
			self.segment_40                       := segment_40;
			self.iv_pots_phone                    := iv_pots_phone;
			self.iv_add_apt                       := iv_add_apt;
			self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
			self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
			self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
			self.iv_in001_estimated_income        := iv_in001_estimated_income;
			self.bureau_addr_tn_fseen_pos         := bureau_addr_tn_fseen_pos;
			self.bureau_addr_fseen_tn             := bureau_addr_fseen_tn;
			self._bureau_addr_fseen_tn            := _bureau_addr_fseen_tn;
			self.bureau_addr_ts_fseen_pos         := bureau_addr_ts_fseen_pos;
			self.bureau_addr_fseen_ts             := bureau_addr_fseen_ts;
			self._bureau_addr_fseen_ts            := _bureau_addr_fseen_ts;
			self.bureau_addr_tu_fseen_pos         := bureau_addr_tu_fseen_pos;
			self.bureau_addr_fseen_tu             := bureau_addr_fseen_tu;
			self._bureau_addr_fseen_tu            := _bureau_addr_fseen_tu;
			self.bureau_addr_en_fseen_pos         := bureau_addr_en_fseen_pos;
			self.bureau_addr_fseen_en             := bureau_addr_fseen_en;
			self._bureau_addr_fseen_en            := _bureau_addr_fseen_en;
			self.bureau_addr_eq_fseen_pos         := bureau_addr_eq_fseen_pos;
			self.bureau_addr_fseen_eq             := bureau_addr_fseen_eq;
			self._bureau_addr_fseen_eq            := _bureau_addr_fseen_eq;
			self._src_bureau_addr_fseen           := _src_bureau_addr_fseen;
			self.iv_mos_src_bureau_addr_fseen     := iv_mos_src_bureau_addr_fseen;
			self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
			self.bst_addr_avm_auto_val            := bst_addr_avm_auto_val;
			self.bst_addr_mortgage_amount         := bst_addr_mortgage_amount;
			self.iv_bst_addr_mtg_avm_pct_diff     := iv_bst_addr_mtg_avm_pct_diff;
			self.iv_bst_addr_assessed_total_val   := iv_bst_addr_assessed_total_val;
			self._gong_did_first_seen             := _gong_did_first_seen;
			self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
			self.iv_ssns_per_sfd_addr             := iv_ssns_per_sfd_addr;
			self.iv_inq_auto_recency              := iv_inq_auto_recency;
			self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
			self._paw_first_seen                  := _paw_first_seen;
			self.iv_mos_since_paw_first_seen      := iv_mos_since_paw_first_seen;
			self.ver_phn_inf                      := ver_phn_inf;
			self.ver_phn_nap                      := ver_phn_nap;
			self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
			self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
			self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
			self._impulse_last_seen               := _impulse_last_seen;
			self.iv_mos_since_impulse_last_seen   := iv_mos_since_impulse_last_seen;
			self.iv_liens_unrel_x_rel             := iv_liens_unrel_x_rel;
			self.iv_criminal_x_felony             := iv_criminal_x_felony;
			self.iv_ams_college_tier              := iv_ams_college_tier;
			self.iv_pb_total_dollars              := iv_pb_total_dollars;
			self.drg_subscore0                    := drg_subscore0;
			self.drg_subscore1                    := drg_subscore1;
			self.drg_subscore2                    := drg_subscore2;
			self.drg_subscore3                    := drg_subscore3;
			self.drg_subscore4                    := drg_subscore4;
			self.drg_subscore5                    := drg_subscore5;
			self.drg_subscore6                    := drg_subscore6;
			self.drg_subscore7                    := drg_subscore7;
			self.drg_subscore8                    := drg_subscore8;
			self.drg_subscore9                    := drg_subscore9;
			self.drg_subscore10                   := drg_subscore10;
			self.drg_subscore11                   := drg_subscore11;
			self.drg_subscore12                   := drg_subscore12;
			self.drg_subscore13                   := drg_subscore13;
			self.drg_subscore14                   := drg_subscore14;
			self.drg_subscore15                   := drg_subscore15;
			self.drg_subscore16                   := drg_subscore16;
			self.drg_subscore17                   := drg_subscore17;
			self.drg_subscore18                   := drg_subscore18;
			self.drg_subscore19                   := drg_subscore19;
			self.drg_rawscore                     := drg_rawscore;
			self.drg_lnoddsscore                  := drg_lnoddsscore;
			self.drg_probscore                    := drg_probscore;
			self.iv_vs002_ssn_prior_dob           := iv_vs002_ssn_prior_dob;
			self.iv_vp007_phn_pcs                 := iv_vp007_phn_pcs;
			self.iv_va060_dist_add_in_bst         := iv_va060_dist_add_in_bst;
			self._header_first_seen               := _header_first_seen;
			self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
			self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;
			self._in_dob                          := _in_dob;
			self.yr_in_dob                        := yr_in_dob;
			self.yr_in_dob_int                    := yr_in_dob_int;
			self.age_estimate                     := age_estimate;
			self.iv_ag001_age                     := iv_ag001_age;
			self.iv_pl002_addrs_per_ssn_c6        := iv_pl002_addrs_per_ssn_c6;
			self.iv_inp_addr_assessed_total_val   := iv_inp_addr_assessed_total_val;
			self.iv_max_ids_per_sfd_addr          := iv_max_ids_per_sfd_addr;
			self.iv_pl_addrs_per_adl              := iv_pl_addrs_per_adl;
			self._infutor_first_seen              := _infutor_first_seen;
			self.iv_mos_since_infutor_first_seen  := iv_mos_since_infutor_first_seen;
			self.sum_dols                         := sum_dols;
			self.pct_offline_dols                 := pct_offline_dols;
			self.pct_retail_dols                  := pct_retail_dols;
			self.pct_online_dols                  := pct_online_dols;
			self.iv_pb_profile                    := iv_pb_profile;
			self.yng_subscore0                    := yng_subscore0;
			self.yng_subscore1                    := yng_subscore1;
			self.yng_subscore2                    := yng_subscore2;
			self.yng_subscore3                    := yng_subscore3;
			self.yng_subscore4                    := yng_subscore4;
			self.yng_subscore5                    := yng_subscore5;
			self.yng_subscore6                    := yng_subscore6;
			self.yng_subscore7                    := yng_subscore7;
			self.yng_subscore8                    := yng_subscore8;
			self.yng_subscore9                    := yng_subscore9;
			self.yng_subscore10                   := yng_subscore10;
			self.yng_subscore11                   := yng_subscore11;
			self.yng_subscore12                   := yng_subscore12;
			self.yng_subscore13                   := yng_subscore13;
			self.yng_subscore14                   := yng_subscore14;
			self.yng_subscore15                   := yng_subscore15;
			self.yng_subscore16                   := yng_subscore16;
			self.yng_subscore17                   := yng_subscore17;
			self.yng_subscore18                   := yng_subscore18;
			self.yng_subscore19                   := yng_subscore19;
			self.yng_subscore20                   := yng_subscore20;
			self.yng_rawscore                     := yng_rawscore;
			self.yng_lnoddsscore                  := yng_lnoddsscore;
			self.yng_probscore                    := yng_probscore;
			self.iv_pv001_bst_avm_autoval         := iv_pv001_bst_avm_autoval;
			self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
			self.iv_combined_age                  := iv_combined_age;
			self.mortgage_type                    := mortgage_type;
			self.mortgage_present                 := mortgage_present;
			self.iv_inp_addr_mortgage_type        := iv_inp_addr_mortgage_type;
			self.iv_inp_addr_building_area        := iv_inp_addr_building_area;
			self.prv_addr_date_first_seen         := prv_addr_date_first_seen;
			self.iv_mos_since_prv_addr_fseen      := iv_mos_since_prv_addr_fseen;
			self.iv_avg_prop_assess_purch_amt     := iv_avg_prop_assess_purch_amt;
			self.iv_dist_bst_addr_to_prv_addr     := iv_dist_bst_addr_to_prv_addr;
			self.iv_addrs_per_adl                 := iv_addrs_per_adl;
			self.iv_adls_per_sfd_addr             := iv_adls_per_sfd_addr;
			self.iv_inq_auto_count12              := iv_inq_auto_count12;
			self.iv_paw_dead_bus_x_active_phn     := iv_paw_dead_bus_x_active_phn;
			self.iv_pb_average_dollars            := iv_pb_average_dollars;
			self.own_subscore0                    := own_subscore0;
			self.own_subscore1                    := own_subscore1;
			self.own_subscore2                    := own_subscore2;
			self.own_subscore3                    := own_subscore3;
			self.own_subscore4                    := own_subscore4;
			self.own_subscore5                    := own_subscore5;
			self.own_subscore6                    := own_subscore6;
			self.own_subscore7                    := own_subscore7;
			self.own_subscore8                    := own_subscore8;
			self.own_subscore9                    := own_subscore9;
			self.own_subscore10                   := own_subscore10;
			self.own_subscore11                   := own_subscore11;
			self.own_subscore12                   := own_subscore12;
			self.own_subscore13                   := own_subscore13;
			self.own_subscore14                   := own_subscore14;
			self.own_subscore15                   := own_subscore15;
			self.own_subscore16                   := own_subscore16;
			self.own_rawscore                     := own_rawscore;
			self.own_lnoddsscore                  := own_lnoddsscore;
			self.own_probscore                    := own_probscore;
			self.iv_dist_inp_addr_to_prv_addr     := iv_dist_inp_addr_to_prv_addr;
			self._reported_dob                    := _reported_dob;
			self.reported_age                     := reported_age;
			self._combined_age                    := _combined_age;
			self.evidence_of_college              := evidence_of_college;
			self.evidence_of_college_flag         := evidence_of_college_flag;
			self.iv_college_attendance_x_age      := iv_college_attendance_x_age;
			self.otr_subscore0                    := otr_subscore0;
			self.otr_subscore1                    := otr_subscore1;
			self.otr_subscore2                    := otr_subscore2;
			self.otr_subscore3                    := otr_subscore3;
			self.otr_subscore4                    := otr_subscore4;
			self.otr_subscore5                    := otr_subscore5;
			self.otr_subscore6                    := otr_subscore6;
			self.otr_subscore7                    := otr_subscore7;
			self.otr_subscore8                    := otr_subscore8;
			self.otr_subscore9                    := otr_subscore9;
			self.otr_subscore10                   := otr_subscore10;
			self.otr_subscore11                   := otr_subscore11;
			self.otr_subscore12                   := otr_subscore12;
			self.otr_subscore13                   := otr_subscore13;
			self.otr_subscore14                   := otr_subscore14;
			self.otr_rawscore                     := otr_rawscore;
			self.otr_lnoddsscore                  := otr_lnoddsscore;
			self.otr_probscore                    := otr_probscore;
			self.iv_ed001_college_ind             := iv_ed001_college_ind;
			self.base                             := base;
			self.point                            := point;
			self.odds                             := odds;
			self.rvb1310_1_0                      := rvb1310_1_0;
			self.drg_glrc36                       := drg_glrc36;
			self.drg_glrc97                       := drg_glrc97;
			self.drg_glrc98                       := drg_glrc98;
			self.drg_glrc9a                       := drg_glrc9a;
			self.drg_glrc9h                       := drg_glrc9h;
			self.drg_glrc9i                       := drg_glrc9i;
			self.drg_glrc9j                       := drg_glrc9j;
			self.drg_glrc9p                       := drg_glrc9p;
			self.drg_glrc9q                       := drg_glrc9q;
			self.drg_glrc9r                       := drg_glrc9r;
			self.drg_glrc9w                       := drg_glrc9w;
			self.drg_glrc9y                       := drg_glrc9y;
			self.drg_glrcev                       := drg_glrcev;
			self.drg_glrcms                       := drg_glrcms;
			self.drg_glrcpv                       := drg_glrcpv;
			self.drg_glrcbl                       := drg_glrcbl;
			self.yng_glrc03                       := yng_glrc03;
			self.yng_glrc36                       := yng_glrc36;
			self.yng_glrc9a                       := yng_glrc9a;
			self.yng_glrc9i                       := yng_glrc9i;
			self.yng_glrc9j                       := yng_glrc9j;
			self.yng_glrc9l                       := yng_glrc9l;
			self.yng_glrc9q                       := yng_glrc9q;
			self.yng_glrc9r                       := yng_glrc9r;
			self.yng_glrc9y                       := yng_glrc9y;
			self.yng_glrcmi                       := yng_glrcmi;
			self.yng_glrcpv                       := yng_glrcpv;
			self.yng_glrcbl                       := yng_glrcbl;
			self.own_glrc36                       := own_glrc36;
			self.own_glrc9d                       := own_glrc9d;
			self.own_glrc9e                       := own_glrc9e;
			self.own_glrc9i                       := own_glrc9i;
			self.own_glrc9l                       := own_glrc9l;
			self.own_glrc9q                       := own_glrc9q;
			self.own_glrc9r                       := own_glrc9r;
			self.own_glrc9y                       := own_glrc9y;
			self.own_glrc9s                       := own_glrc9s;
			self.own_glrcpv                       := own_glrcpv;
			self.own_glrcbl                       := own_glrcbl;
			self.otr_glrc36                       := otr_glrc36;
			self.otr_glrc9d                       := otr_glrc9d;
			self.otr_glrc9e                       := otr_glrc9e;
			self.otr_glrc9i                       := otr_glrc9i;
			self.otr_glrc9l                       := otr_glrc9l;
			self.otr_glrc9p                       := otr_glrc9p;
			self.otr_glrc9q                       := otr_glrc9q;
			self.otr_glrc9y                       := otr_glrc9y;
			self.otr_glrcms                       := otr_glrcms;
			self.otr_glrcpv                       := otr_glrcpv;
			self.otr_glrcbl                       := otr_glrcbl;
			self.bk                               := bk;
			self.eviction                         := eviction;
			self.lien                             := lien;
			self.pdl                              := pdl;
			self.derogsum                         := derogsum;
			self.seg_glrc97                       := seg_glrc97;
			self.seg_glrc98                       := seg_glrc98;
			self.seg_glrc9a                       := seg_glrc9a;
			self.seg_glrc9h                       := seg_glrc9h;
			self.seg_glrc9r                       := seg_glrc9r;
			self.seg_glrc9w                       := seg_glrc9w;
			self.seg_glrcev                       := seg_glrcev;
			self.no_addr_ver                      := no_addr_ver;
			self.source_confirm_date              := source_confirm_date;
			self.est_inc_sum                      := est_inc_sum;
			self.drg_glrc25                       := drg_glrc25;
			self.drg_glrc9c                       := drg_glrc9c;
			self.drg_glrc9f                       := drg_glrc9f;
			self.yng_glrc25                       := yng_glrc25;
			self.yng_glrc9c                       := yng_glrc9c;
			self.yng_glrc9f                       := yng_glrc9f;
			self.rcvalue25_1                      := rcvalue25_1;
			self.rcvalue25_2                      := rcvalue25_2;
			self.rcvalue25                        := rcvalue25;
			self.rcvalue9c_1                      := rcvalue9c_1;
			self.rcvalue9c_2                      := rcvalue9c_2;
			self.rcvalue9c                        := rcvalue9c;
			self.rcvalue9f_1                      := rcvalue9f_1;
			self.rcvalue9f_2                      := rcvalue9f_2;
			self.rcvalue9f                        := rcvalue9f;
			self.rcvalue03_1                      := rcvalue03_1;
			self.rcvalue03                        := rcvalue03;
			self.rcvalue36_1                      := rcvalue36_1;
			self.rcvalue36_2                      := rcvalue36_2;
			self.rcvalue36_3                      := rcvalue36_3;
			self.rcvalue36_4                      := rcvalue36_4;
			self.rcvalue36_5                      := rcvalue36_5;
			self.rcvalue36_6                      := rcvalue36_6;
			self.rcvalue36_7                      := rcvalue36_7;
			self.rcvalue36_8                      := rcvalue36_8;
			self.rcvalue36_9                      := rcvalue36_9;
			self.rcvalue36_10                     := rcvalue36_10;
			self.rcvalue36                        := rcvalue36;
			self.rcvalue97_1                      := rcvalue97_1;
			self.rcvalue97_2                      := rcvalue97_2;
			self.rcvalue97                        := rcvalue97;
			self.rcvalue98_1                      := rcvalue98_1;
			self.rcvalue98_2                      := rcvalue98_2;
			self.rcvalue98                        := rcvalue98;
			self.rcvalue9a_1                      := rcvalue9a_1;
			self.rcvalue9a_2                      := rcvalue9a_2;
			self.rcvalue9a_3                      := rcvalue9a_3;
			self.rcvalue9a                        := rcvalue9a;
			self.rcvalue9d_1                      := rcvalue9d_1;
			self.rcvalue9d_2                      := rcvalue9d_2;
			self.rcvalue9d                        := rcvalue9d;
			self.rcvalue9e_1                      := rcvalue9e_1;
			self.rcvalue9e_2                      := rcvalue9e_2;
			self.rcvalue9e                        := rcvalue9e;
			self.rcvalue9h_1                      := rcvalue9h_1;
			self.rcvalue9h_2                      := rcvalue9h_2;
			self.rcvalue9h                        := rcvalue9h;
			self.rcvalue9i_1                      := rcvalue9i_1;
			self.rcvalue9i_2                      := rcvalue9i_2;
			self.rcvalue9i_3                      := rcvalue9i_3;
			self.rcvalue9i_4                      := rcvalue9i_4;
			self.rcvalue9i_5                      := rcvalue9i_5;
			self.rcvalue9i                        := rcvalue9i;
			self.rcvalue9j_1                      := rcvalue9j_1;
			self.rcvalue9j_2                      := rcvalue9j_2;
			self.rcvalue9j                        := rcvalue9j;
			self.rcvalue9l_1                      := rcvalue9l_1;
			self.rcvalue9l_2                      := rcvalue9l_2;
			self.rcvalue9l_3                      := rcvalue9l_3;
			self.rcvalue9l                        := rcvalue9l;
			self.rcvalue9p_1                      := rcvalue9p_1;
			self.rcvalue9p_2                      := rcvalue9p_2;
			self.rcvalue9p                        := rcvalue9p;
			self.rcvalue9q_1                      := rcvalue9q_1;
			self.rcvalue9q_2                      := rcvalue9q_2;
			self.rcvalue9q_3                      := rcvalue9q_3;
			self.rcvalue9q_4                      := rcvalue9q_4;
			self.rcvalue9q                        := rcvalue9q;
			self.rcvalue9r_1                      := rcvalue9r_1;
			self.rcvalue9r_2                      := rcvalue9r_2;
			self.rcvalue9r_3                      := rcvalue9r_3;
			self.rcvalue9r_4                      := rcvalue9r_4;
			self.rcvalue9r                        := rcvalue9r;
			self.rcvalue9s_1                      := rcvalue9s_1;
			self.rcvalue9s                        := rcvalue9s;
			self.rcvalue9w_1                      := rcvalue9w_1;
			self.rcvalue9w_2                      := rcvalue9w_2;
			self.rcvalue9w                        := rcvalue9w;
			self.rcvalue9y_1                      := rcvalue9y_1;
			self.rcvalue9y_2                      := rcvalue9y_2;
			self.rcvalue9y_3                      := rcvalue9y_3;
			self.rcvalue9y_4                      := rcvalue9y_4;
			self.rcvalue9y                        := rcvalue9y;
			self.rcvalueev_1                      := rcvalueev_1;
			self.rcvalueev_2                      := rcvalueev_2;
			self.rcvalueev                        := rcvalueev;
			self.rcvaluemi_1                      := rcvaluemi_1;
			self.rcvaluemi                        := rcvaluemi;
			self.rcvaluems_1                      := rcvaluems_1;
			self.rcvaluems_2                      := rcvaluems_2;
			self.rcvaluems                        := rcvaluems;
			self.rcvaluepv_1                      := rcvaluepv_1;
			self.rcvaluepv_3                      := rcvaluepv_3;
			self.rcvaluepv_2                      := rcvaluepv_2;
			self.rcvaluepv_4                      := rcvaluepv_4;
			self.rcvaluepv_5                      := rcvaluepv_5;
			self.rcvaluepv                        := rcvaluepv;
			self.rcvaluebl_1                      := rcvaluebl_1;
			self.rcvaluebl_2                      := rcvaluebl_2;
			self.rcvaluebl_3                      := rcvaluebl_3;
			self.rcvaluebl_4                      := rcvaluebl_4;
			self.rcvaluebl_5                      := rcvaluebl_5;
			self.rcvaluebl_6                      := rcvaluebl_6;
			self.rcvaluebl_7                      := rcvaluebl_7;
			self.rcvaluebl_8                      := rcvaluebl_8;
			self.rcvaluebl_9                      := rcvaluebl_9;
			self.rcvaluebl_10                     := rcvaluebl_10;
			self.rcvaluebl_11                     := rcvaluebl_11;
			self.rcvaluebl_12                     := rcvaluebl_12;
			self.rcvaluebl_13                     := rcvaluebl_13;
			self.rcvaluebl_14                     := rcvaluebl_14;
			self.rcvaluebl_15                     := rcvaluebl_15;
			self.rcvaluebl_16                     := rcvaluebl_16;
			self.rcvaluebl_17                     := rcvaluebl_17;
			self.rcvaluebl_18                     := rcvaluebl_18;
			self.rcvaluebl_19                     := rcvaluebl_19;
			self.rcvaluebl                        := rcvaluebl;
			// self.rc1                              := rc1;
			// self.rc4                              := rc4;
			// self.rc3                              := rc3;
			// self.rc5                              := rc5;
			// self.rc2                              := rc2;			
			self.rc1                              := rcs_override[1].rc;
			self.rc2                              := rcs_override[2].rc;
			self.rc3                              := rcs_override[3].rc;
			self.rc4                              := rcs_override[4].rc;
			self.rc5                              := rcs_override[5].rc;
			self.MSA_NAME                         := MSA_NAME;

#end
		
	SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)rvb1310_1_0
										);
	END;

	model := project( clam, doModel(left) );

	return model;
END;
