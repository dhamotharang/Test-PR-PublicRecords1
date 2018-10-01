import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVG1103_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean xmlPreScreenOptOut ) := FUNCTION

	RVG_DEBUG := false;

	#if(RVG_DEBUG)
	debug_layout := record
		risk_indicators.Layout_Boca_Shell clam;
		Boolean trueDID;
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String NAP_Status;
		Integer did2_criminal_count;
		Integer did2_liens_hist_unrel_count;
		Boolean rc_non_us_ssn;
		String rc_hriskphoneflag;
		String rc_hphonetypeflag;
		String rc_hphonevalflag;
		String rc_phonezipflag;
		String rc_pwphonezipflag;
		String rc_decsflag;
		String rc_ssndobflag;
		String rc_pwssndobflag;
		String rc_ssnvalflag;
		String rc_pwssnvalflag;
		String rc_areacodesplitflag;
		String rc_addrvalflag;
		String rc_bansflag;
		Integer rc_ssncount;
		Boolean rc_ssnmiskeyflag;
		Boolean rc_addrmiskeyflag;
		String rc_addrcommflag;
		String rc_hrisksic;
		String rc_phonetype;
		String rc_cityzipflag;
		Integer combo_dobscore;
		Integer combo_fnamecount;
		Integer combo_dobcount;
		qstring100 ver_sources;
		qstring100 ver_sources_NAS;
		qstring200 ver_sources_first_seen;
		qstring100 ver_ssn_sources;
		String ssnlength;
		Integer Age;
		Boolean add1_house_number_match;
		Boolean add1_isbestmatch;
		String add1_advo_address_vacancy;
		String add1_advo_throw_back;
		String add1_advo_res_or_business;
		String add1_avm_land_use;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_med_fips;
		Integer add1_avm_med_geo11;
		Integer add1_avm_med_geo12;
		Integer add1_source_count;
		Integer add1_naprop;
		Integer property_owned_total;
		Integer property_sold_total;
		String add2_avm_land_use;
		Integer add2_avm_automated_valuation;
		Integer add2_avm_med_fips;
		Integer add2_avm_med_geo11;
		Integer add2_avm_med_geo12;
		Integer add2_source_count;
		Integer add2_naprop;
		Integer add3_naprop;
		Boolean addrs_prison_history;
		Boolean addr_hist_advo_college;
		String telcordia_type;
		Integer recent_disconnects;
		Integer gong_did_phone_ct;
		Integer gong_did_first_ct;
		Integer gong_did_last_ct;
		Integer header_first_seen;
		Integer ssns_per_adl;
		Integer adlPerSSN_count;
		Integer adls_per_addr;
		Integer ssns_per_addr;
		Integer adls_per_phone;
		Integer ssns_per_adl_c6;
		Integer phones_per_adl_c6;
		Integer lnames_per_adl_c6;
		Integer adls_per_ssn_c6;
		Integer addrs_per_ssn_c6;
		Integer adls_per_addr_c6;
		Integer phones_per_addr_c6;
		Integer adls_per_phone_c6;
		String inq_last_log_date;
		Integer inq_count01;
		Integer inq_count03;
		Integer inq_count06;
		Integer inq_count12;
		Integer inq_communications_count12;
		Integer inq_peraddr;
		Integer inq_adlsperaddr;
		Integer inq_ssnsperaddr;
		Integer inq_perphone;
		Integer inq_adlsperphone;
		Integer infutor_nap;
		Integer impulse_count;
		Integer impulse_last_seen;
		Integer impulse_count30;
		qstring50 email_source_list;
		Integer attr_felonies36;
		Integer attr_num_unrel_liens30;
		Integer attr_num_unrel_liens180;
		Integer attr_num_unrel_liens12;
		Integer attr_num_unrel_liens60;
		Integer attr_bankruptcy_count36;
		Integer attr_eviction_count;
		Integer attr_date_last_eviction;
		Integer attr_eviction_count30;
		Integer attr_num_nonderogs180;
		Boolean Bankrupt;
		String disposition;
		Integer filing_count;
		Integer bk_recent_count;
		Integer bk_disposed_recent_count;
		Integer bk_disposed_historical_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer liens_unrel_cj_ct;
		Integer liens_unrel_cj_last_seen;
		Integer liens_unrel_lt_ct;
		Integer liens_unrel_lt_last_seen;
		Integer liens_unrel_sc_ct;
		Integer liens_unrel_sc_last_seen;
		Integer criminal_count;
		Integer criminal_last_date;
		Integer felony_count;
		Integer felony_last_date;
		Integer watercraft_count;
		String ams_age;
		String ams_college_code;
		String ams_college_tier;
		String prof_license_category;
		String input_dob_match_level;
		Integer inferred_age;
		Integer reported_dob;
		Integer archive_date;
		Integer sysdate;
		Integer ver_src_ba_pos;
		Boolean ver_src_ba;
		Integer ver_src_ds_pos;
		Boolean ver_src_ds;
		Integer ver_src_en_pos;
		Real ver_src_nas_en;
		String ver_src_fdate_en;
		Integer ver_src_fdate_en2;
		Real mth_ver_src_fdate_en;
		Integer ver_src_eq_pos;
		Real ver_src_nas_eq;
		String ver_src_fdate_eq;
		Integer ver_src_fdate_eq2;
		Real mth_ver_src_fdate_eq;
		Integer ver_src_l2_pos;
		Boolean ver_src_l2;
		Integer ver_src_li_pos;
		Boolean ver_src_li;
		Integer ver_src_p_pos;
		Boolean ver_src_p;
		Real ver_src_nas_p;
		Integer ver_src_ts_pos;
		String ver_src_fdate_ts;
		Integer ver_src_fdate_ts2;
		Real mth_ver_src_fdate_ts;
		Integer ver_ssn_src_l2_pos;
		Boolean ver_ssn_src_l2;
		Integer ver_ssn_src_mw_pos;
		Boolean ver_ssn_src_mw;
		Integer email_src_im_pos;
		Boolean email_src_im;
		Boolean _felony_f;
		Boolean _crime_f;
		Boolean _attr_unrel_lien_f;
		Boolean _lien_hist_unrel_f;
		Boolean _attr_eviction_f;
		Boolean _impluse_f;
		Boolean _ssn_deceased_f;
		Boolean _derog_new_f;
		Integer in_dob2;
		Real yr_in_dob;
		Integer _age;
		Boolean _prop_owner;
		String _rvg40_segment;
		Boolean _add_highriskcom;
		Boolean _add_invalid;
		Boolean _add_miskey;
		Boolean _add_zipcitymismatch;
		Boolean _add_advo_vacant;
		Boolean _add_advo_throwback;
		Boolean _add_risk;
		Boolean sy_add_risk;
		Integer add1_avm_med;
		Integer _add1_avm;
		Real sd_add1_avm_log;
		Integer sy_add1_avm_new;
		Real sy_add1_avm_new_ym;
		Real sw_add1_avm_log;
		Real so_add1_avm_log;
		Integer add2_avm_med;
		Integer _add2_avm;
		String _add1_avm_class;
		String _add2_avm_class;
		String _econtrajectory;
		Integer sd_econtrj;
		Real sd_econtrj_m;
		Boolean _phn_notpots;
		Boolean _phn_recent_disconnect;
		Boolean _phn_areacodesplit;
		Boolean sd_phn_risk;
		Boolean sw_phn_risk;
		Integer sw_phn_x;
		Real sw_phn_x_wm;
		Boolean so_phn_risk;
		Boolean _ssn_risk;
		Boolean sw_ssn_risk;
		Real sd_age_log;
		Real sy_age_log;
		Integer reported_dob2;
		Real yr_reported_dob;
		Real _dob_adlage_diff;
		Real _dob_amsage_diff;
		Real _dob_reportedage_diff;
		Boolean _dob_adlage_diffge2;
		Boolean _dob_amsage_diffge2;
		Boolean _dob_reportedage_diffge2;
		Boolean _dob_diffge2;
		Boolean _dob_diff;
		Integer so_age;
		Real so_age_om;
		Boolean _derog_bk_gt1_in36m;
		Boolean _derog_bk_filing_gt3;
		Boolean _derog_bk_disposed_gt1_in24m;
		Boolean _derog_bk_disposed_gt3;
		Boolean _derog_bk_bad;
		Integer _lien_unrel_mon;
		Integer _lien_unrel_mon2;
		Real _lien_unrel_mon2_m;
		Integer _lien_cj_unrel_ct;
		Integer liens_unrel_cj_last_seen2;
		Real mth_liens_unrel_cj_last_seen;
		Boolean _lien_cj_unrel_lseen;
		Integer _lien_cj_unrel_x;
		Real _lien_cj_unrel_x_m;
		Integer _lien_lt_unrel_ct;
		Integer liens_unrel_lt_last_seen2;
		Real mth_liens_unrel_lt_last_seen;
		Integer _lien_lt_unrel_lseen;
		Integer _lien_lt_unrel_x;
		Real _lien_lt_unrel_x_m;
		Integer _lien_sc_unrel_ct;
		Integer liens_unrel_sc_last_seen2;
		Real mth_liens_unrel_sc_last_seen;
		Integer _lien_sc_unrel_lseen;
		Integer _lien_sc_unrel_x;
		Real _lien_sc_unrel_x_m;
		Integer _eviction_ct;
		Integer attr_date_last_eviction2;
		Real mth_attr_date_last_eviction;
		Integer _eviction_lseen;
		Integer _eviction_x;
		Real _eviction_x_m;
		Integer _criminal_ct;
		Integer _felony_ct;
		Integer _criminal_x;
		Integer criminal_last_date2;
		Real mth_criminal_last_date;
		Integer felony_last_date2;
		Real mth_felony_last_date;
		Integer _criminal_lseen;
		Integer _felony_lseen;
		Real _criminal_x2;
		Real _criminal_x3;
		Real _criminal_x4;
		Real _criminal_x5;
		Real _criminal_x5_m;
		Integer _impulse_ct;
		Integer impulse_last_seen2;
		Real mth_impulse_last_seen;
		Integer _impulse_lseen;
		Real _impulse_x;
		Real _impulse_x2;
		Real _impulse_x3;
		Real _impulse_x3_m;
		Integer sd_combo_dobcount;
		Real sd_combo_dobcount_m;
		Integer sy_combo_dobcount;
		Real sy_combo_dobcount_ym;
		Integer so_combo_dobcount;
		Real so_combo_dobcount_om;
		Integer sd_nap_i;
		Real sd_nap_i_m;
		Integer sy_nap_i;
		Real sy_nap_i_ym;
		Integer sw_nap_i;
		Real sw_nap_i_wm;
		Integer so_nap_i;
		Real so_nap_i_om;
		Integer header_first_seen2;
		Real mth_header_first_seen;
		Integer sy_mth_header_fseen;
		Real sy_mth_header_fseen_ym;
		Real ver_src_nas_cb;
		Integer sd_ver_src_nas_cb_i;
		Real sd_ver_src_nas_cb_i_m;
		Integer sy_ver_src_nas_cb_i;
		Real sy_ver_src_nas_cb_i_ym;
		Integer so_ver_src_nas_cb_i;
		Real so_ver_src_nas_cb_i_om;
		Real mth_ver_src_fdate_cb;
		Integer sw_ver_src_fdate_cb;
		Real sw_ver_src_fdate_cb_wm;
		Integer _age_fseen_cb;
		Integer so_mth_on_cb;
		Integer so_mth_on_cb_i;
		Real so_mth_on_cb_i_om;
		Integer sd_ver_src_nas_p;
		Integer sd_ver_p_x;
		Real sd_ver_p_x_m;
		Integer sy_ver_p_x;
		Real sy_ver_p_x_ym;
		Integer sw_ver_p_x;
		Real sw_ver_p_x_wm;
		Integer so_ver_src_nas_p;
		Integer so_ver_p_x;
		Real so_ver_p_x_om;
		Integer sd_ver_src_fdate_ts;
		Real sd_ver_src_fdate_ts_m;
		Integer sw_ver_src_fdate_ts;
		Real sw_ver_src_fdate_ts_wm;
		Real sw_ver_src_fdate_ts_om;
		Integer sd_gong_did_phone_ct;
		Real sd_gong_did_phone_ct_m;
		Integer so_gong_did_phone_ct;
		Real so_gong_did_phone_ct_om;
		Integer sd_gong_did_first_ct;
		Real sd_gong_did_first_ct_m;
		Integer sy_gong_did_last_ct;
		Real sy_gong_did_last_ct_ym;
		Integer sw_gong_did_first_ct;
		Integer sw_gong_did_last_ct;
		Integer sw_gong_did_fl_ct;
		Real sw_gong_did_fl_ct_wm;
		Real sd_gong_did_first_ct_om;
		Integer sd_combo_fnamecount;
		Real sd_combo_fnamecount_m;
		Integer sw_combo_fnamecount;
		Real sw_combo_fnamecount_wm;
		Real sd_combo_fnamecount_om;
		Boolean _add2_naprop34;
		Boolean _add3_naprop34;
		Boolean _add23_naprop34;
		Integer sd_add2_source_count;
		Real sd_add2_source_count_m;
		Integer sd_add1_source_count;
		Real sd_add1_source_count_om;
		Integer so_add2_source_count;
		Real so_add2_source_count_om;
		Integer sd_ver_ssn_cnt;
		Real sd_ver_ssn_cnt_m;
		Boolean sd_ams_good;
		Boolean sd_pl_ams_good;
		Integer sy_ams_tier;
		Integer sy_amspl_tier;
		Real sy_amspl_tier_ym;
		Boolean sw_ams_good;
		Boolean sw_pl_ams;
		Integer so_ams_x;
		Real so_ams_x_om;
		Boolean sd_pl_good;
		Integer sd_infutor_nap;
		Real sd_infutor_nap_m;
		Boolean sy_infutor_nap16;
		Integer so_infutor_nap;
		Real so_infutor_nap_om;
		Integer sd_attr_num_nonderogs180;
		Real sd_attr_num_nonderogs180_m;
		Integer so_property_sold;
		Integer so_prop_x;
		Real so_prop_x_om;
		Integer sd_ssns_per_adl;
		Real sd_ssns_per_adl_m;
		Integer sd_adlperssn_count;
		Real sd_adlperssn_count_m;
		Integer sd_ssns_per_addr;
		Real sd_ssns_per_addr_m;
		Integer sd_ssns_per_adl_c6;
		Real sd_ssns_per_adl_c6_m;
		Integer sd_phones_per_adl_c6;
		Real sd_phones_per_adl_c6_m;
		Integer sd_addrs_per_ssn_c6;
		Real sd_addrs_per_ssn_c6_m;
		Integer sd_adls_per_addr_c6;
		Real sd_adls_per_addr_c6_m;
		Integer sy_ssns_per_adl;
		Real sy_ssns_per_adl_ym;
		Integer sy_adlperssn_count;
		Real sy_adlperssn_count_ym;
		Integer sy_addrs_per_ssn_c6;
		Real sy_addrs_per_ssn_c6_ym;
		Integer sy_phones_per_adl_c6;
		Integer sy_lnames_per_adl_c6;
		Integer sy_adls_per_ssn_c6;
		Boolean sy_adls_per_addr_c6;
		Boolean sy_phones_per_addr_c6;
		Boolean sy_adls_per_phone_c6;
		Boolean sy_velocity_c6;
		Integer sw_ssns_per_adl;
		Real sw_ssns_per_adl_wm;
		Integer sw_adlperssn_count;
		Real sw_adlperssn_count_wm;
		Integer sw_adls_per_addr;
		Real sw_adls_per_addr_wm;
		Integer sw_ssns_per_adl_c6;
		Real sw_ssns_per_adl_c6_wm;
		Integer sw_phones_per_adl_c6;
		Real sw_phones_per_adl_c6_wm;
		Integer sw_addrs_per_ssn_c6;
		Real sw_addrs_per_ssn_c6_wm;
		Integer sw_adls_per_addr_c6;
		Real sw_adls_per_addr_c6_wm;
		Integer so_ssns_per_adl;
		Real so_ssns_per_adl_om;
		Integer so_adlperssn_ct;
		Real so_adlperssn_ct_om;
		Integer so_adls_per_phone;
		Real so_adls_per_phone_om;
		Integer so_phones_per_adl_c6;
		Real so_phones_per_adl_c6_om;
		Integer so_lnames_per_adl_c6;
		Real so_lnames_per_adl_c6_om;
		Integer so_addrs_per_ssn_c6;
		Real so_addrs_per_ssn_c6_om;
		Integer so_adls_per_addr_c6;
		Real so_adls_per_addr_c6_om;
		Integer sd_inq_count12;
		Integer inq_last_log_date2;
		Real mth_inq_last_log_date;
		Integer sd_inq_count12_2;
		Real sd_inq_count12_2_m;
		Integer sd_inq_communications_count12;
		Real sd_inq_communications_count12_m;
		Integer sd_inq_adlsperaddr;
		Real sd_inq_adlsperaddr_m;
		Integer sy_inq_count12;
		Real sy_inq_count12_ym;
		Integer sy_inq_peraddr;
		Integer sw_inq_count12;
		Integer sw_inq_count03;
		Integer sw_inq_ct_x;
		Real sw_inq_ct_x_wm;
		Integer sw_inq_peraddr;
		Real sw_inq_peraddr_wm;
		Integer sw_inq_perphone;
		Real sw_inq_perphone_wm;
		Integer so_inq_count12;
		Integer so_inq_count06;
		Integer so_inq_count01;
		Integer so_inq_x;
		Integer so_inq_x2;
		Real so_inq_x2_om;
		Integer so_inq_ssnsperaddr;
		Real so_inq_ssnsperaddr_om;
		Integer so_inq_adlsperphone;
		Real so_inq_adlsperphone_om;
		Real sd17;
		Real sy10;
		Real sw07;
		Real logit;
		Real so10;
		Real phat;
		Integer Base;
		Real odds;
		Integer point;
		Integer rvg1103_raw;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Boolean lien_flag;
		Boolean bk_flag;
		Boolean ssn_deceased;
		Boolean scored_222s;
		Integer rvg1103_cap;
		Integer rvg1103_cap2;
		Integer rvg1103_cap3;
		Integer rvg1103;
		
		
		string rc_dwelltype;
		// string add1_advo_mixed_address_usage;
		// string rc_phonevalflag;
		Boolean addrPop;
		Boolean dobpop;
		Integer combo_lnamecount;
		Integer combo_addrcount;
		Integer combo_ssncount;
		Integer combo_hphonecount;
		String add1_avm_assessed_total_value;
		Boolean add1_applicant_owned;
		Boolean add1_family_owned;
		Boolean add2_applicant_owned;
		Boolean add3_applicant_owned;
		Boolean add2_family_owned;
		Boolean add3_family_owned;
		Boolean add1_eda_sourced;
		Integer add1_assessed_total_value;
		Integer attr_addrs_last12;
		Integer property_ambig_total;
		Boolean glrc03;
		Boolean glrc07;
		Boolean glrc20;
		Boolean glrc25;
		Boolean glrc28;
		Boolean glrc97;
		Boolean glrc98;
		Boolean glrc99;
		Boolean glrc9a;
		Boolean glrc9d;
		Integer glrc9e;
		Boolean glrc9g;
		Boolean glrc9h;
		Integer glrc9i;
		Boolean glrc9j;
		Boolean glrc9o;
		Boolean glrc9q;
		Boolean glrcev;
		Boolean glrcmi;
		Boolean glrcms;
		// Integer aptflag_1;
		Integer aptflag;
		Integer add1_econval;
		Integer add1_aptval;
		String add1_econcode;
		Integer glrcpv;
		Integer glrc9r;
		Boolean glrc9t;
		Boolean glrc9u;
		Boolean glrc9v;
		Boolean glrc9w;
		String rc1_4;
		Integer rc1v;
		String rc2_1;
		Integer rc2v;
		String rc3_1;
		Integer rc3v;
		String rc4_1;
		Integer rc4v;
		String rc5_2;
		Integer rcsegderog;
		Integer rcsegyoung;
		Integer rcsegowner;
		Integer rcsegother;
		Real rcvalue03_1;
		Real rcvalue03;
		Real rcvalue07_1;
		Real rcvalue07;
		Real rcvalue20_1;
		Real rcvalue20_2;
		Real rcvalue20_3;
		Real rcvalue20_4;
		Real rcvalue20_5;
		Real rcvalue20_6;
		Real rcvalue20_7;
		Real rcvalue20_8;
		Real rcvalue20;
		Real rcvalue25_1;
		Real rcvalue25;
		Real rcvalue28_1;
		Real rcvalue28_2;
		Real rcvalue28_3;
		Real rcvalue28;
		Real rcvalue97_1;
		Real rcvalue97_2;
		Real rcvalue97;
		Real rcvalue98_1;
		Real rcvalue98_2;
		Real rcvalue98_3;
		Real rcvalue98_4;
		Real rcvalue98_5;
		Real rcvalue98_6;
		Real rcvalue98_7;
		Real rcvalue98_8;
		Real rcvalue98;
		Real rcvalue99_1;
		Real rcvalue99_2;
		Real rcvalue99_3;
		Real rcvalue99;
		Real rcvalue9a_1;
		Real rcvalue9a_2;
		Real rcvalue9a_3;
		Real rcvalue9a;
		Real rcvalue9d_1;
		Real rcvalue9d_2;
		Real rcvalue9d_3;
		Real rcvalue9d_4;
		Real rcvalue9d;
		Real rcvalue9e_1;
		Real rcvalue9e_2;
		Real rcvalue9e_3;
		Real rcvalue9e_4;
		Real rcvalue9e_5;
		Real rcvalue9e_6;
		Real rcvalue9e_7;
		Real rcvalue9e_8;
		Real rcvalue9e_9;
		Real rcvalue9e_10;
		Real rcvalue9e_11;
		Real rcvalue9e;
		Real rcvalue9g_1;
		Real rcvalue9g_2;
		Real rcvalue9g_3;
		Real rcvalue9g_4;
		Real rcvalue9g;
		Real rcvalue9h_1;
		Real rcvalue9h_2;
		Real rcvalue9h;
		Real rcvalue9i_1;
		Real rcvalue9i;
		Real rcvalue9j_1;
		Real rcvalue9j;
		Real rcvalue9o_1;
		Real rcvalue9o_2;
		Real rcvalue9o_3;
		Real rcvalue9o_4;
		Real rcvalue9o_5;
		Real rcvalue9o_6;
		Real rcvalue9o;
		Real rcvalue9q_1;
		Real rcvalue9q_2;
		Real rcvalue9q_3;
		Real rcvalue9q_4;
		Real rcvalue9q_5;
		Real rcvalue9q_6;
		Real rcvalue9q_7;
		Real rcvalue9q_8;
		Real rcvalue9q_9;
		Real rcvalue9q_10;
		Real rcvalue9q_11;
		Real rcvalue9q;
		Real rcvalue9r_1;
		Real rcvalue9r_2;
		Real rcvalue9r_3;
		Real rcvalue9r_4;
		Real rcvalue9r_5;
		Real rcvalue9r;
		Real rcvalue9t_1;
		Real rcvalue9t_2;
		Real rcvalue9t_3;
		Real rcvalue9t;
		Real rcvalue9u_1;
		Real rcvalue9u_2;
		Real rcvalue9u;
		Real rcvalue9v_1;
		Real rcvalue9v_2;
		Real rcvalue9v;
		Real rcvalue9w_1;
		Real rcvalue9w;
		Real rcvalueev_1;
		Real rcvalueev_2;
		Real rcvalueev;
		Real rcvaluemi_1;
		Real rcvaluemi_2;
		Real rcvaluemi_3;
		Real rcvaluemi_4;
		Real rcvaluemi;
		Real rcvaluems_1;
		Real rcvaluems_2;
		Real rcvaluems_3;
		Real rcvaluems_4;
		Real rcvaluems_5;
		Real rcvaluems_6;
		Real rcvaluems;
		Real rcvaluepv_1;
		Real rcvaluepv_2;
		Real rcvaluepv_3;
		Real rcvaluepv_4;
		Real rcvaluepv_5;
		Real rcvaluepv;

		string2 rc1 := '';
		string2 rc2 := '';
		string2 rc3 := '';
		string2 rc4 := '';
		string2 rc5 := '';
		
		real rc1_val := 0;
		real rc2_val := 0;
		real rc3_val := 0;
		real rc4_val := 0;
		real rc5_val := 0;
		models.layout_modelout;
	end;
	debug_layout doModel( clam le ) := TRANSFORM
	#else
	models.layout_modelout doModel( clam le ) := TRANSFORM
	#end
		


		truedid                          := le.truedid;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_status                       := le.iid.nap_status;
		did2_criminal_count              := le.iid.did2_criminal_count;
		did2_liens_hist_unrel_count      := le.iid.did2_liens_historical_unreleased_count;
		rc_non_us_ssn                    := le.iid.non_us_ssn;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnvalflag                    := le.iid.socsvalflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_areacodesplitflag             := le.iid.areacodesplitflag;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_bansflag                      := le.iid.bansflag;
		rc_ssncount                      := le.iid.socscount;
		rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
		rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
		rc_addrcommflag                  := le.iid.addrcommflag;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_phonetype                     := le.iid.phonetype;
		rc_cityzipflag                   := le.iid.cityzipflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_fnamecount                 := le.iid.combo_firstcount;
		combo_dobcount                   := le.iid.combo_dobcount;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_nas                  := le.header_summary.ver_sources_nas;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
		ssnlength                        := le.input_validation.ssn_length;
		age                              := le.name_verification.age;
		add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
		add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_source_count                := le.address_verification.input_address_information.source_count;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
		add2_source_count                := le.address_verification.address_history_1.source_count;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		addrs_prison_history             := le.other_address_info.isprison;
		addr_hist_advo_college           := le.address_history_summary.address_history_advo_college_hit;
		telcordia_type                   := le.phone_verification.telcordia_type;
		recent_disconnects               := le.phone_verification.recent_disconnects;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		lnames_per_adl_c6                := le.velocity_counters.lnames_per_adl180;
		adls_per_ssn_c6                  := le.velocity_counters.adls_per_ssn_created_6months;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
		inq_last_log_date                := le.acc_logs.last_log_date;
		inq_count01                      := le.acc_logs.inquiries.count01;
		inq_count03                      := le.acc_logs.inquiries.count03;
		inq_count06                      := le.acc_logs.inquiries.count06;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_communications_count12       := le.acc_logs.communications.count12;
		inq_peraddr                      := le.acc_logs.inquiryperaddr;
		inq_adlsperaddr                  := le.acc_logs.inquiryadlsperaddr;
		inq_ssnsperaddr                  := le.acc_logs.inquiryssnsperaddr;
		inq_perphone                     := le.acc_logs.inquiryperphone;
		inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		impulse_last_seen                := le.impulse.last_seen_date;
		impulse_count30                  := le.impulse.count30;
		email_source_list                := le.email_summary.email_source_list;
		attr_felonies36                  := le.bjl.criminal_count36;
		attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
		attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
		attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
		attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
		attr_bankruptcy_count36          := le.bjl.bk_count36;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		attr_eviction_count30            := le.bjl.eviction_count30;
		attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_lt_last_seen         := le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		liens_unrel_sc_last_seen         := le.liens.liens_unreleased_small_claims.most_recent_filing_date;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		felony_last_date                 := le.bjl.last_felony_date;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_age                          := le.student.age;
		ams_college_code                 := le.student.college_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		archive_date                     := le.historydate;


		rc_dwelltype                  := le.iid.dwelltype;
		// add1_advo_mixed_address_usage := le.advo_input_addr.mixed_address_usage;
		// rc_phonevalflag               := le.iid.phonevalflag;

		NULL := -999999999;


		sysdate := map(
			trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), le.historydate+'01')),
			length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], '1') - ut.DaysSince1900('1960', '1', '1')),
																   NULL);
		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		
		ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

		ver_src_ba := ver_src_ba_pos > 0;

		ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

		ver_src_ds := ver_src_ds_pos > 0;

		ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie');

		ver_src_nas_en := if(ver_src_en_pos > 0, (real)Models.Common.getw(ver_sources_NAS, ver_src_en_pos), 0);

		ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

		ver_src_fdate_en2 := common.sas_date((string)(ver_src_fdate_en));

		mth_ver_src_fdate_en := if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, (sysdate - ver_src_fdate_en2) / 30.5);

		ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

		ver_src_nas_eq := if(ver_src_eq_pos > 0, (real)Models.Common.getw(ver_sources_NAS, ver_src_eq_pos), 0);

		ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

		ver_src_fdate_eq2 := common.sas_date((string)(ver_src_fdate_eq));

		mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

		ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

		ver_src_l2 := ver_src_l2_pos > 0;

		ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie');

		ver_src_li := ver_src_li_pos > 0;

		ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

		ver_src_p := ver_src_p_pos > 0;

		ver_src_nas_p := if(ver_src_p_pos > 0, (real)Models.Common.getw(ver_sources_NAS, ver_src_p_pos), 0);

		ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ' ,', 'ie');

		ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

		ver_src_fdate_ts2 := common.sas_date((string)(ver_src_fdate_ts));

		mth_ver_src_fdate_ts := if(min(sysdate, ver_src_fdate_ts2) = NULL, NULL, (sysdate - ver_src_fdate_ts2) / 30.5);

		ver_ssn_src_l2_pos := Models.Common.findw_cpp(ver_ssn_sources, 'L2' , ' ,', 'ie');

		ver_ssn_src_l2 := ver_ssn_src_l2_pos > 0;

		ver_ssn_src_mw_pos := Models.Common.findw_cpp(ver_ssn_sources, 'MW' , ' ,', 'ie');

		ver_ssn_src_mw := ver_ssn_src_mw_pos > 0;

		email_src_im_pos := Models.Common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie');

		email_src_im := email_src_im_pos > 0;

		_felony_f := felony_count > 0;

		_crime_f := criminal_count > 0;

		_attr_unrel_lien_f := attr_num_unrel_liens60 > 0;

		_lien_hist_unrel_f := liens_historical_unreleased_ct > 0;

		_attr_eviction_f := attr_eviction_count > 0;

		_impluse_f := impulse_count > 0;

		_ssn_deceased_f := rc_decsflag = '1' or Models.Common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie') > 0;

		_derog_new_f := _crime_f or _felony_f or (integer)contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') > 0 or _attr_unrel_lien_f or _lien_hist_unrel_f or _attr_eviction_f or _impluse_f or _ssn_deceased_f;

		in_dob2 := common.sas_date((string)(in_dob));

		yr_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 365.25);

		_age := if(yr_in_dob > 0, round(yr_in_dob), round(inferred_age));
		// _age := map(
			// yr_in_dob = NULL => NULL,
			// yr_in_dob > 0 => round(yr_in_dob),
			// round(inferred_age)
		// );

		_prop_owner := Add1_NaProp = 4 or Property_Owned_Total > 0;

		_rvg40_segment := map(
			_derog_new_f => '1 derog',
			_age <= 25   => '2 young',
			_prop_owner  => '3 owner',
							'4 other');

		_add_highriskcom := (integer)rc_addrcommflag > 0 or StringLib.StringToUpperCase(add1_advo_res_or_business) = 'B';

		_add_invalid := StringLib.StringToUpperCase(rc_addrvalflag) != 'V';

		_add_miskey := (integer)rc_addrmiskeyflag > 0;

		_add_zipcitymismatch := (integer)rc_cityzipflag > 0;

		_add_advo_vacant := StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y';

		_add_advo_throwback := StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y';

		_add_risk := _add_highriskcom or addrs_prison_history or _add_invalid or _add_miskey or _add_zipcitymismatch or _add_advo_vacant or _add_advo_throwback;

		sy_add_risk := _add_highriskcom or addrs_prison_history or _add_invalid or _add_miskey or _add_advo_vacant or _add_advo_throwback;

		add1_avm_med := map(
			ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
			ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
									  ADD1_AVM_MED_FIPS);

		_add1_avm := map(
			add1_avm_automated_valuation > 0 => add1_avm_automated_valuation,
			add1_avm_med > 0                 => add1_avm_med,
												0);

		sd_add1_avm_log := if(_add1_avm = 0, ln(130000), ln(min(600000, if(max(50000, _add1_avm) = NULL, -NULL, max(50000, _add1_avm)))));

		sy_add1_avm_new := map(
			_add1_avm <= 0      => -1,
			_add1_avm <= 32990  => 11,
			_add1_avm <= 47966  => 10,
			_add1_avm <= 78400  => 9,
			_add1_avm <= 107927 => 8,
			_add1_avm <= 130169 => 7,
			_add1_avm <= 158938 => 6,
			_add1_avm <= 198985 => 5,
			_add1_avm <= 309824 => 4,
			_add1_avm <= 379900 => 3,
			_add1_avm <= 499471 => 2,
								   1);

		sy_add1_avm_new_ym := map(
			sy_add1_avm_new = -1 => 0.3364642737,
			sy_add1_avm_new = 1  => 0.2764227642,
			sy_add1_avm_new = 2  => 0.2884353741,
			sy_add1_avm_new = 3  => 0.2926174497,
			sy_add1_avm_new = 4  => 0.3102040816,
			sy_add1_avm_new = 5  => 0.3238289206,
			sy_add1_avm_new = 6  => 0.344874406,
			sy_add1_avm_new = 7  => 0.3525423729,
			sy_add1_avm_new = 8  => 0.3857982813,
			sy_add1_avm_new = 9  => 0.4034296029,
			sy_add1_avm_new = 10 => 0.4182561308,
			sy_add1_avm_new = 11 => 0.4346049046,
									0.3498306998);

		sw_add1_avm_log := if(_add1_avm = 0, ln(90000), ln(min(500000, if(max(50000, _add1_avm) = NULL, -NULL, max(50000, _add1_avm)))));

		so_add1_avm_log := if(_add1_avm = 0, ln(120000), ln(min(500000, if(max(60000, _add1_avm) = NULL, -NULL, max(60000, _add1_avm)))));

		add2_avm_med := map(
			add2_AVM_MED_GEO12 > 0 => add2_AVM_MED_GEO12,
			add2_AVM_MED_GEO11 > 0 => add2_AVM_MED_GEO11,
									  add2_AVM_MED_FIPS);

		_add2_avm := map(
			add2_avm_automated_valuation > 0 => add2_avm_automated_valuation,
			add2_avm_med > 0                 => add2_avm_med,
												0);

		_add1_avm_class_c86 := map(
			_add1_avm > 400000 => 'A',
			_add1_avm > 200000 => 'B',
			_add1_avm > 100000 => 'C',
			_add1_avm > 50000  => 'D',
								  'E');

		_add1_avm_class_c87 := map(
			_add1_avm > 400000 => 'A',
			_add1_avm > 300000 => 'B',
			_add1_avm > 200000 => 'C',
			_add1_avm > 100000 => 'D',
			_add1_avm > 50000  => 'E',
			_add1_avm > 0      => 'F',
								  'U');

		_add1_avm_class := if(add1_avm_land_use = '1', _add1_avm_class_c86, _add1_avm_class_c87);

		_add2_avm_class_c89 := map(
			_add2_avm > 400000 => 'A',
			_add2_avm > 200000 => 'B',
			_add2_avm > 100000 => 'C',
			_add2_avm > 50000  => 'D',
								  'E');

		_add2_avm_class_c90 := map(
			_add2_avm > 400000 => 'A',
			_add2_avm > 300000 => 'B',
			_add2_avm > 200000 => 'C',
			_add2_avm > 100000 => 'D',
			_add2_avm > 50000  => 'E',
			_add2_avm > 0      => 'F',
								  'U');

		_add2_avm_class := if(add2_avm_land_use = '1', _add2_avm_class_c89, _add2_avm_class_c90);

		_econtrajectory := trim(_add2_avm_class, LEFT, RIGHT) + trim(_add1_avm_class, LEFT, RIGHT);

		sd_econtrj := map(
			_econtrajectory = 'AA' => 1,
			_econtrajectory = 'BA' => 1,
			_econtrajectory = 'AB' => 1,
			_econtrajectory = 'BB' => 2,
			_econtrajectory = 'AC' => 2,
			_econtrajectory = 'BC' => 2,
			_econtrajectory = 'AD' => 2,
			_econtrajectory = 'BD' => 3,
			_econtrajectory = 'AE' => 3,
			_econtrajectory = 'BE' => 3,
			_econtrajectory = 'AF' => 4,
			_econtrajectory = 'BF' => 4,
			_econtrajectory = 'AU' => 1,
			_econtrajectory = 'BU' => 2,
			_econtrajectory = 'CA' => 1,
			_econtrajectory = 'DA' => 2,
			_econtrajectory = 'CB' => 2,
			_econtrajectory = 'DB' => 2,
			_econtrajectory = 'CC' => 2,
			_econtrajectory = 'DC' => 2,
			_econtrajectory = 'CD' => 3,
			_econtrajectory = 'DD' => 3,
			_econtrajectory = 'CE' => 3,
			_econtrajectory = 'DE' => 4,
			_econtrajectory = 'CF' => 4,
			_econtrajectory = 'DF' => 5,
			_econtrajectory = 'CU' => 3,
			_econtrajectory = 'DU' => 3,
			_econtrajectory = 'EA' => 2,
			_econtrajectory = 'FA' => 2,
			_econtrajectory = 'EB' => 2,
			_econtrajectory = 'FB' => 3,
			_econtrajectory = 'EC' => 3,
			_econtrajectory = 'FC' => 3,
			_econtrajectory = 'ED' => 4,
			_econtrajectory = 'FD' => 4,
			_econtrajectory = 'EE' => 5,
			_econtrajectory = 'FE' => 5,
			_econtrajectory = 'EF' => 5,
			_econtrajectory = 'FF' => 6,
			_econtrajectory = 'EU' => 4,
			_econtrajectory = 'FU' => 5,
			_econtrajectory = 'UA' => 2,
			_econtrajectory = 'UB' => 3,
			_econtrajectory = 'UC' => 3,
			_econtrajectory = 'UD' => 4,
			_econtrajectory = 'UE' => 5,
			_econtrajectory = 'UF' => 6,
									  -1);

		sd_econtrj_m := map(
			sd_econtrj = -1 => 0.349039584,
			sd_econtrj = 1  => 0.2738756948,
			sd_econtrj = 2  => 0.3134198054,
			sd_econtrj = 3  => 0.358783746,
			sd_econtrj = 4  => 0.3985860323,
			sd_econtrj = 5  => 0.4446835988,
			sd_econtrj = 6  => 0.4860392968,
							   0.3614663257);

		_phn_notpots := ((rc_hriskphoneflag in ['1', '2', '3', '4']) or (StringLib.StringToUpperCase(rc_hphonetypeflag) in ['1', '2', '3', '6', '7', '9', 'A', 'U'])) and telcordia_type != '00';

		_phn_recent_disconnect := recent_disconnects > 0;

		_phn_areacodesplit := StringLib.StringToUpperCase(rc_areacodesplitflag) = 'Y';

		sd_phn_risk := rc_hriskphoneflag = '5' or (integer)_phn_recent_disconnect = 1 or StringLib.StringToUpperCase(nap_status) = 'D' or _phn_areacodesplit;

		sw_phn_risk := (rc_hriskphoneflag in ['5', '6']) or (rc_hphonetypeflag in ['5', 'A']) or rc_hphonevalflag = '3' or rc_phonezipflag = '1';

		sw_phn_x := map(
			StringLib.StringToUpperCase(nap_status) = 'C' and (integer)sw_phn_risk = 0 and (integer)_phn_notpots = 0 => 1,
			StringLib.StringToUpperCase(nap_status) = 'C' and (integer)sw_phn_risk = 0 and (integer)_phn_notpots = 1 => 2,
			(integer)sw_phn_risk = 0 and (integer)_phn_notpots = 0                                                   => 1,
			(integer)sw_phn_risk = 0 and (integer)_phn_notpots = 1                                                   => 3,
																														4);

		sw_phn_x_wm := map(
			sw_phn_x = 1 => 0.1491928485,
			sw_phn_x = 2 => 0.1750547046,
			sw_phn_x = 3 => 0.1916678125,
			sw_phn_x = 4 => 0.2250639386,
							0.1702257723);

		so_phn_risk := StringLib.StringToUpperCase(nap_status) = 'D' or recent_disconnects > 0 or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or (rc_hphonevalflag in ['0', '1', '3']) or (rc_pwphonezipflag in ['1', '2', '4']) or rc_phonetype = '3';

		_ssn_risk := (integer)rc_non_us_ssn = 1 or rc_ssndobflag = (string)1 or rc_pwssndobflag = '1' or rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3', '4']) or (integer)rc_ssnmiskeyflag = 1;

		sw_ssn_risk := rc_ssndobflag = '1' or rc_pwssndobflag = '1';

		// sd_age_log := if(yr_in_dob > 0, ln(min(if(max(yr_in_dob, (real)18) = NULL, -NULL, max(yr_in_dob, (real)18)), 66)), ln(min(if(max(inferred_age, 18) = NULL, -NULL, max(inferred_age, 18)), 66)));
		sd_age_log := map(
			// yr_in_dob = NULL => // ??
			yr_in_dob > 0    => ln(min(max(yr_in_dob, 18), 66)),
			ln(min(max(inferred_age, 18), 62))
		);
     // if yr_in_dob>0 then sd_age_log = log(min(max(yr_in_dob,18),66));
     // else sd_age_log = log(min(max(inferred_age,18),66));


		// sy_age_log := if(_age = NULL, ln(18), ln(max((real)18, _age)));
		sy_age_log := if(_age = NULL, ln(18), ln(min(max((real)18, _age), 62)));

		reported_dob2 := common.sas_date((string)(reported_dob));

		yr_reported_dob := if(min(sysdate, reported_dob2) = NULL, NULL, (sysdate - reported_dob2) / 365.25);

		_dob_adlage_diff := if(yr_in_dob > 0 and age > 0, yr_in_dob - age, NULL);

		_dob_amsage_diff := if(yr_in_dob > 0 and ams_age > (string)0, yr_in_dob - (real)ams_age, NULL);

		_dob_reportedage_diff := if(yr_in_dob > 0 and yr_reported_dob > 0, yr_in_dob - yr_reported_dob, NULL);

		_dob_adlage_diffge2 := _dob_adlage_diff != NULL and abs(_dob_adlage_diff) >= 2;

		_dob_amsage_diffge2 := _dob_amsage_diff != NULL and abs(_dob_amsage_diff) >= 2;

		_dob_reportedage_diffge2 := _dob_reportedage_diff != NULL and abs(_dob_reportedage_diff) >= 2;

		_dob_diffge2 := _dob_adlage_diffge2 or _dob_amsage_diffge2 or _dob_reportedage_diffge2;

		_dob_diff := combo_dobscore != 100 or (integer)_dob_diffge2 = 1;

		so_age := map(
			_age <= 30 => 7,
			_age <= 30 => 6,
			_age <= 35 => 5,
			_age <= 44 => 4,
			_age <= 56 => 3,
			_age <= 61 => 2,
							1);

		so_age_om := map(
			so_age = 1 => 0.2016563147,
			so_age = 2 => 0.2192780338,
			so_age = 3 => 0.2436910037,
			so_age = 4 => 0.2699115044,
			so_age = 5 => 0.2808034376,
			so_age = 7 => 0.2954666262,
						  0.2675244268);

		_derog_bk_gt1_in36m := attr_bankruptcy_count36 > 1;

		_derog_bk_filing_gt3 := filing_count > 3;

		_derog_bk_disposed_gt1_in24m := bk_disposed_recent_count > 1;

		_derog_bk_disposed_gt3 := bk_disposed_historical_count > 3;

		_derog_bk_bad := _derog_bk_gt1_in36m or _derog_bk_filing_gt3 or _derog_bk_disposed_gt1_in24m or _derog_bk_disposed_gt3;

		_lien_unrel_mon := map(
			attr_num_unrel_liens30 > 1  => 4,
			attr_num_unrel_liens180 > 1 => 3,
			attr_num_unrel_liens12 > 1  => 2,
			attr_num_unrel_liens60 > 2  => 1,
										   0);

		_lien_unrel_mon2 := if(did2_liens_hist_unrel_count > 0, 4, _lien_unrel_mon);

		_lien_unrel_mon2_m := map(
			_lien_unrel_mon2 = 0 => 0.3520119117,
			_lien_unrel_mon2 = 1 => 0.3865645256,
			_lien_unrel_mon2 = 2 => 0.4126530612,
			_lien_unrel_mon2 = 3 => 0.4430719656,
			_lien_unrel_mon2 = 4 => 0.5454545455,
									0.3614663257);

		_lien_cj_unrel_ct := min(8, max(3, liens_unrel_CJ_ct));

		liens_unrel_cj_last_seen2 := common.sas_date((string)(liens_unrel_cj_last_seen));

		mth_liens_unrel_cj_last_seen := if(min(sysdate, liens_unrel_cj_last_seen2) = NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 30.5);

		_lien_cj_unrel_lseen := 0 <= mth_liens_unrel_cj_last_seen AND mth_liens_unrel_cj_last_seen <= 6;

		_lien_cj_unrel_x := map(
			_lien_cj_unrel_ct = 3 and (integer)_lien_cj_unrel_lseen = 0 => 1,
			_lien_cj_unrel_ct = 3 and (integer)_lien_cj_unrel_lseen = 1 => 2,
			_lien_cj_unrel_ct = 4 and (integer)_lien_cj_unrel_lseen = 0 => 3,
			_lien_cj_unrel_ct = 5 and (integer)_lien_cj_unrel_lseen = 0 => 3,
			_lien_cj_unrel_ct = 4 and (integer)_lien_cj_unrel_lseen = 1 => 4,
			_lien_cj_unrel_ct = 6 and (integer)_lien_cj_unrel_lseen = 0 => 5,
			_lien_cj_unrel_ct = 7 and (integer)_lien_cj_unrel_lseen = 0 => 5,
			_lien_cj_unrel_ct = 5 and (integer)_lien_cj_unrel_lseen = 1 => 6,
			_lien_cj_unrel_ct = 6 and (integer)_lien_cj_unrel_lseen = 1 => 6,
			_lien_cj_unrel_ct = 8 and (integer)_lien_cj_unrel_lseen = 0 => 6,
																		   7);

		_lien_cj_unrel_x_m := map(
			_lien_cj_unrel_x = 1 => 0.3534090332,
			_lien_cj_unrel_x = 2 => 0.3852345906,
			_lien_cj_unrel_x = 3 => 0.4137618832,
			_lien_cj_unrel_x = 4 => 0.4326086957,
			_lien_cj_unrel_x = 5 => 0.4564254062,
			_lien_cj_unrel_x = 6 => 0.4809575626,
			_lien_cj_unrel_x = 7 => 0.5152439024,
									0.3614663257);

		_lien_lt_unrel_ct := min(4, if(max(0, liens_unrel_LT_ct) = NULL, -NULL, max(0, liens_unrel_LT_ct)));

		liens_unrel_lt_last_seen2 := common.sas_date((string)(liens_unrel_lt_last_seen));

		mth_liens_unrel_lt_last_seen := if(min(sysdate, liens_unrel_lt_last_seen2) = NULL, NULL, (sysdate - liens_unrel_lt_last_seen2) / 30.5);

		_lien_lt_unrel_lseen := map(
			mth_liens_unrel_lt_last_seen < 0  => 0,
			mth_liens_unrel_lt_last_seen < 12 => 4,
			mth_liens_unrel_lt_last_seen < 36 => 3,
			mth_liens_unrel_lt_last_seen < 60 => 2,
												 1);

		_lien_lt_unrel_x := map(
			_lien_lt_unrel_ct = 0 or _lien_lt_unrel_lseen = 0  => 1,
			_lien_lt_unrel_ct = 1 and _lien_lt_unrel_lseen = 1 => 2,
			_lien_lt_unrel_ct = 1 and _lien_lt_unrel_lseen = 2 => 2,
			_lien_lt_unrel_ct = 2 and _lien_lt_unrel_lseen = 1 => 2,
			_lien_lt_unrel_ct = 2 and _lien_lt_unrel_lseen = 2 => 2,
			_lien_lt_unrel_ct = 1 and _lien_lt_unrel_lseen = 3 => 3,
			_lien_lt_unrel_ct = 1 and _lien_lt_unrel_lseen = 4 => 4,
			_lien_lt_unrel_ct = 2 and _lien_lt_unrel_lseen = 3 => 5,
			_lien_lt_unrel_ct = 3 and _lien_lt_unrel_lseen = 1 => 5,
			_lien_lt_unrel_ct = 3 and _lien_lt_unrel_lseen = 2 => 5,
			_lien_lt_unrel_ct = 3 and _lien_lt_unrel_lseen = 3 => 5,
			_lien_lt_unrel_ct = 3 and _lien_lt_unrel_lseen = 3 => 5,
			_lien_lt_unrel_ct = 4 and _lien_lt_unrel_lseen = 1 => 5,
			_lien_lt_unrel_ct = 4 and _lien_lt_unrel_lseen = 2 => 5,
																  6);

		_lien_lt_unrel_x_m := map(
			_lien_lt_unrel_x = 1 => 0.3516557157,
			_lien_lt_unrel_x = 2 => 0.42076326,
			_lien_lt_unrel_x = 3 => 0.4400241109,
			_lien_lt_unrel_x = 4 => 0.4537487829,
			_lien_lt_unrel_x = 5 => 0.5017667845,
			_lien_lt_unrel_x = 6 => 0.5826771654,
									0.3614663257);

		_lien_sc_unrel_ct := min(5, if(max(1, liens_unrel_SC_ct) = NULL, -NULL, max(1, liens_unrel_SC_ct)));

		liens_unrel_sc_last_seen2 := common.sas_date((string)(liens_unrel_sc_last_seen));

		mth_liens_unrel_sc_last_seen := if(min(sysdate, liens_unrel_sc_last_seen2) = NULL, NULL, (sysdate - liens_unrel_sc_last_seen2) / 30.5);

		_lien_sc_unrel_lseen := map(
			mth_liens_unrel_sc_last_seen < 0  => 0,
			mth_liens_unrel_sc_last_seen < 6  => 3,
			mth_liens_unrel_sc_last_seen < 12 => 2,
												 1);

		_lien_sc_unrel_x := map(
			_lien_sc_unrel_ct = 1 or _lien_sc_unrel_lseen = 0  => 1,
			_lien_sc_unrel_ct = 2                              => 2,
			_lien_sc_unrel_ct = 3 and _lien_sc_unrel_lseen = 1 => 2,
			_lien_sc_unrel_ct = 4 and _lien_sc_unrel_lseen = 1 => 2,
			_lien_sc_unrel_ct = 3 and _lien_sc_unrel_lseen = 2 => 3,
			_lien_sc_unrel_ct = 3 and _lien_sc_unrel_lseen = 3 => 3,
			_lien_sc_unrel_ct = 4 and _lien_sc_unrel_lseen = 2 => 3,
			_lien_sc_unrel_ct = 5 and _lien_sc_unrel_lseen = 1 => 3,
			_lien_sc_unrel_ct = 5 and _lien_sc_unrel_lseen = 2 => 3,
																  4);

		_lien_sc_unrel_x_m := map(
			_lien_sc_unrel_x = 1 => 0.3587127034,
			_lien_sc_unrel_x = 2 => 0.3811206461,
			_lien_sc_unrel_x = 3 => 0.4451871658,
			_lien_sc_unrel_x = 4 => 0.5162790698,
									0.3614663257);

		_eviction_ct := min(4, if(max(0, attr_eviction_count) = NULL, -NULL, max(0, attr_eviction_count)));

		attr_date_last_eviction2 := common.sas_date((string)(attr_date_last_eviction));

		mth_attr_date_last_eviction := if(min(sysdate, attr_date_last_eviction2) = NULL, NULL, (sysdate - attr_date_last_eviction2) / 30.5);

		_eviction_lseen := map(
			mth_attr_date_last_eviction < 0  => 0,
			mth_attr_date_last_eviction < 6  => 5,
			mth_attr_date_last_eviction < 12 => 4,
			mth_attr_date_last_eviction < 24 => 3,
			mth_attr_date_last_eviction < 36 => 2,
												1);

		_eviction_x_1 := map(
			_eviction_lseen = 0                      => 1,
			_eviction_lseen = 1 and _eviction_ct = 0 => 2,
			_eviction_lseen = 1 and _eviction_ct = 1 => 2,
			_eviction_lseen = 2 and _eviction_ct = 0 => 2,
			_eviction_lseen = 2 and _eviction_ct = 1 => 2,
			_eviction_lseen = 1 and _eviction_ct = 2 => 3,
			_eviction_lseen = 1 and _eviction_ct = 3 => 3,
			_eviction_lseen = 2 and _eviction_ct = 2 => 3,
			_eviction_lseen = 3 and _eviction_ct = 0 => 3,
			_eviction_lseen = 3 and _eviction_ct = 1 => 3,
			_eviction_lseen = 1 and _eviction_ct = 4 => 4,
			_eviction_lseen = 3 and _eviction_ct = 2 => 4,
			_eviction_lseen = 4 and _eviction_ct = 0 => 4,
			_eviction_lseen = 4 and _eviction_ct = 1 => 4,
			_eviction_lseen = 4 and _eviction_ct = 2 => 4,
			_eviction_lseen = 5 and _eviction_ct = 0 => 4,
			_eviction_lseen = 5 and _eviction_ct = 1 => 4,
			_eviction_lseen = 2 and _eviction_ct = 3 => 5,
			_eviction_lseen = 2 and _eviction_ct = 4 => 5,
			_eviction_lseen = 3 and _eviction_ct = 3 => 5,
			_eviction_lseen = 3 and _eviction_ct = 4 => 5,
			_eviction_lseen = 4 and _eviction_ct = 3 => 5,
			_eviction_lseen = 5 and _eviction_ct = 2 => 5,
			_eviction_lseen = 5 and _eviction_ct = 3 => 5,
														6);

		_eviction_x := if(attr_eviction_count30 > 0, 6, _eviction_x_1);

		_eviction_x_m := map(
			_eviction_x = 1 => 0.331674485,
			_eviction_x = 2 => 0.3871706758,
			_eviction_x = 3 => 0.4084167594,
			_eviction_x = 4 => 0.4622739018,
			_eviction_x = 5 => 0.4921575462,
			_eviction_x = 6 => 0.5499081445,
							   0.3614663257);

		_criminal_ct := min(4, if(max(0, criminal_count) = NULL, -NULL, max(0, criminal_count)));

		_felony_ct := min(3, if(max(0, felony_count) = NULL, -NULL, max(0, felony_count)));

		_criminal_x := map(
			_criminal_ct = 0                    => 1,
			_criminal_ct = 1 and _felony_ct = 0 => 2,
			_criminal_ct = 2 and _felony_ct = 0 => 2,
			_criminal_ct = 3 and _felony_ct = 0 => 2,
			_criminal_ct = 1 and _felony_ct = 1 => 3,
			_criminal_ct = 2 and _felony_ct = 1 => 3,
			_criminal_ct = 3 and _felony_ct = 1 => 3,
			_criminal_ct = 4 and _felony_ct = 0 => 3,
			_criminal_ct = 4 and _felony_ct = 1 => 4,
			_felony_ct = 2                      => 4,
												   5);

		criminal_last_date2 := common.sas_date((string)(criminal_last_date));

		mth_criminal_last_date := if(min(sysdate, criminal_last_date2) = NULL, NULL, (sysdate - criminal_last_date2) / 30.5);

		felony_last_date2 := common.sas_date((string)(felony_last_date));

		mth_felony_last_date := if(min(sysdate, felony_last_date2) = NULL, NULL, (sysdate - felony_last_date2) / 30.5);

		_criminal_lseen := map(
			mth_criminal_last_date < 0  => 0,
			mth_criminal_last_date < 6  => 4,
			mth_criminal_last_date < 12 => 3,
			mth_criminal_last_date < 60 => 2,
										   1);

		_felony_lseen := map(
			mth_felony_last_date < 0  => 0,
			mth_felony_last_date < 6  => 4,
			mth_felony_last_date < 12 => 3,
			mth_felony_last_date < 60 => 2,
										 1);

		_criminal_x2 := map(
			_criminal_x = 3 and _felony_lseen = 4  => 4.5,
			_criminal_x = 4 and _felony_lseen >= 3 => 5,
													  _criminal_x);

		_criminal_x3 := map(
			_criminal_x2 = 3 and _criminal_lseen = 4 => 4.5,
			_criminal_x2 = 4 and _criminal_lseen = 4 => 4.5,
														_criminal_x2);

		_criminal_x4 := if(_criminal_x3 = 5 and attr_felonies36 >= 2, 6, _criminal_x3);

		_criminal_x5 := if(_criminal_x4 < 4 and did2_criminal_count > 0, 4, _criminal_x4);

		_criminal_x5_m := map(
			_criminal_x5 = 1   => 0.3485839135,
			_criminal_x5 = 2   => 0.4188953488,
			_criminal_x5 = 3   => 0.5249056604,
			_criminal_x5 = 4   => 0.5601503759,
			_criminal_x5 = 4.5 => 0.6393442623,
			_criminal_x5 = 5   => 0.6470588235,
			_criminal_x5 = 6   => 0.8269230769,
								  0.3614663257);

		_impulse_ct := min(3, if(max(0, impulse_count) = NULL, -NULL, max(0, impulse_count)));

		impulse_last_seen2 := common.sas_date((string)(impulse_last_seen));

		mth_impulse_last_seen := if(min(sysdate, impulse_last_seen2) = NULL, NULL, (sysdate - impulse_last_seen2) / 30.5);

		_impulse_lseen := map(
			mth_impulse_last_seen < 0 => 0,
			mth_impulse_last_seen < 6 => 2,
										 1);

		_impulse_x := if(_impulse_ct = 1 and _impulse_lseen = 2, 1.5, _impulse_ct);

		_impulse_x2 := map(
			_impulse_x = 1.5 and impulse_count30 >= 1 => 2,
			_impulse_x = 2 and impulse_count30 = 1    => 3,
			_impulse_x = 2 and impulse_count30 >= 2   => 4,
			_impulse_x = 3 and impulse_count30 >= 2   => 4,
														 _impulse_x);

		_impulse_x3 := if(_impulse_x2 = 0 and (integer)email_src_im = 1, 0.5, _impulse_x2);

		_impulse_x3_m := map(
			_impulse_x3 = 0   => 0.3247356256,
			_impulse_x3 = 0.5 => 0.4128787879,
			_impulse_x3 = 1   => 0.4454887218,
			_impulse_x3 = 1.5 => 0.4427071179,
			_impulse_x3 = 2   => 0.4956772334,
			_impulse_x3 = 3   => 0.5620347395,
			_impulse_x3 = 4   => 0.5914285714,
								 0.3614663257);

		sd_combo_dobcount := if((combo_dobcount in [1, 2]), 1, min(10, if(combo_dobcount = NULL, -NULL, combo_dobcount)));

		sd_combo_dobcount_m := map(
			sd_combo_dobcount = 0  => 0.4673140281,
			sd_combo_dobcount = 1  => 0.4077978914,
			sd_combo_dobcount = 3  => 0.3852387483,
			sd_combo_dobcount = 4  => 0.374394322,
			sd_combo_dobcount = 5  => 0.344456873,
			sd_combo_dobcount = 6  => 0.3163806828,
			sd_combo_dobcount = 7  => 0.3062283737,
			sd_combo_dobcount = 8  => 0.285021225,
			sd_combo_dobcount = 9  => 0.2794117647,
			sd_combo_dobcount = 10 => 0.2666666667,
									  0.3614663257);

		sy_combo_dobcount := if((combo_dobcount in [1, 2, 3, 4]), 1, min(6, if(combo_dobcount = NULL, -NULL, combo_dobcount)));

		sy_combo_dobcount_ym := map(
			sy_combo_dobcount = 0 => 0.35996459,
			sy_combo_dobcount = 1 => 0.3431696769,
			sy_combo_dobcount = 5 => 0.3317901235,
			sy_combo_dobcount = 6 => 0.1907514451,
									 0.3498306998);

		so_combo_dobcount := min(6, if(combo_dobcount = NULL, -NULL, combo_dobcount));

		so_combo_dobcount_om := map(
			so_combo_dobcount = 0 => 0.3252961962,
			so_combo_dobcount = 1 => 0.2925511386,
			so_combo_dobcount = 2 => 0.2778544061,
			so_combo_dobcount = 3 => 0.2742880726,
			so_combo_dobcount = 4 => 0.2546822349,
			so_combo_dobcount = 5 => 0.2463662791,
			so_combo_dobcount = 6 => 0.2343277129,
									 0.2675244268);

		sd_nap_i := map(
			nap_summary = 0  => 4,
			nap_summary = 1  => 6,
			nap_summary = 2  => 3,
			nap_summary = 3  => 3,
			nap_summary = 4  => 4,
			nap_summary = 5  => 3,
			nap_summary = 6  => 5,
			nap_summary = 7  => 4,
			nap_summary = 8  => 3,
			nap_summary = 9  => 1,
			nap_summary = 10 => 3,
			nap_summary = 11 => 2,
								1);

		sd_nap_i_m := map(
			sd_nap_i = 1 => 0.3046767538,
			sd_nap_i = 2 => 0.3281993839,
			sd_nap_i = 3 => 0.360559925,
			sd_nap_i = 4 => 0.372274921,
			sd_nap_i = 5 => 0.4307795699,
			sd_nap_i = 6 => 0.4426934097,
							0.3614663257);

		sy_nap_i := map(
			nap_summary = 1         => 4,
			nap_summary = 6         => 3,
			(nap_summary in [4, 7]) => 2,
									   1);

		sy_nap_i_ym := map(
			sy_nap_i = 1 => 0.3430567472,
			sy_nap_i = 2 => 0.3811320755,
			sy_nap_i = 3 => 0.4224464061,
			sy_nap_i = 4 => 0.4796511628,
							0.3498306998);

		sw_nap_i := map(
			nap_summary = 0  => 4,
			nap_summary = 1  => 6,
			nap_summary = 2  => 3,
			nap_summary = 3  => 3,
			nap_summary = 4  => 3,
			nap_summary = 5  => 3,
			nap_summary = 6  => 5,
			nap_summary = 7  => 3,
			nap_summary = 8  => 3,
			nap_summary = 9  => 1,
			nap_summary = 10 => 3,
			nap_summary = 11 => 2,
								1);

		sw_nap_i_wm := map(
			sw_nap_i = 1 => 0.1394015409,
			sw_nap_i = 2 => 0.1517754868,
			sw_nap_i = 3 => 0.1741706161,
			sw_nap_i = 4 => 0.182831545,
			sw_nap_i = 5 => 0.2298245614,
			sw_nap_i = 6 => 0.2482758621,
							0.1702257723);

		so_nap_i := map(
			nap_summary = 0  => 3,
			nap_summary = 1  => 5,
			nap_summary = 2  => 3,
			nap_summary = 3  => 3,
			nap_summary = 4  => 3,
			nap_summary = 5  => 3,
			nap_summary = 6  => 4,
			nap_summary = 7  => 3,
			nap_summary = 8  => 3,
			nap_summary = 9  => 1,
			nap_summary = 10 => 3,
			nap_summary = 11 => 2,
								1);

		so_nap_i_om := map(
			so_nap_i = 1 => 0.2292027153,
			so_nap_i = 2 => 0.26201373,
			so_nap_i = 3 => 0.2686175792,
			so_nap_i = 4 => 0.3280334728,
			so_nap_i = 5 => 0.380859375,
							0.2675244268);

		header_first_seen2 := common.sas_date((string)(header_first_seen));

		mth_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 30.5);

		sy_mth_header_fseen := map(
			mth_header_first_seen = NULL     => -1,
			mth_header_first_seen <= 18.918  => 5,
			mth_header_first_seen <= 43.869  => 4,
			mth_header_first_seen <= 58.918  => 3,
			mth_header_first_seen <= 79.836  => 2,
			mth_header_first_seen <= 84.82   => 1,
			mth_header_first_seen <= 91.836  => -2,
			mth_header_first_seen <= 117.803 => -3,
												-4);

		sy_mth_header_fseen_ym := map(
			sy_mth_header_fseen = -4 => 0.4238636364,
			sy_mth_header_fseen = -3 => 0.3771428571,
			sy_mth_header_fseen = -2 => 0.3103850642,
			sy_mth_header_fseen = -1 => 0.4301075269,
			sy_mth_header_fseen = 1  => 0.2930513595,
			sy_mth_header_fseen = 2  => 0.3165933812,
			sy_mth_header_fseen = 3  => 0.3313373253,
			sy_mth_header_fseen = 4  => 0.3739543296,
			sy_mth_header_fseen = 5  => 0.4022646007,
										0.3498306998);

		ver_src_nas_cb := map(
			ver_src_nas_eq > 0 => ver_src_nas_eq,
			ver_src_nas_en > 0 => ver_src_nas_en,
								  0);

		sd_ver_src_nas_cb_i := map(
			ver_src_nas_cb = 0  => 3,
			ver_src_nas_cb = 1  => 4,
			ver_src_nas_cb = 2  => 2,
			ver_src_nas_cb = 3  => 2,
			ver_src_nas_cb = 4  => 2,
			ver_src_nas_cb = 5  => 2,
			ver_src_nas_cb = 6  => 2,
			ver_src_nas_cb = 7  => 2,
			ver_src_nas_cb = 8  => 2,
			ver_src_nas_cb = 9  => 2,
			ver_src_nas_cb = 10 => 1,
			ver_src_nas_cb = 11 => 1,
								   1);

		sd_ver_src_nas_cb_i_m := map(
			sd_ver_src_nas_cb_i = 1 => 0.3282418691,
			sd_ver_src_nas_cb_i = 2 => 0.4383068887,
			sd_ver_src_nas_cb_i = 3 => 0.472,
			sd_ver_src_nas_cb_i = 4 => 0.7894736842,
									   0.3614663257);

		sy_ver_src_nas_cb_i := sd_ver_src_nas_cb_i;

		sy_ver_src_nas_cb_i_ym := map(
			sy_ver_src_nas_cb_i = 1 => 0.3213799365,
			sy_ver_src_nas_cb_i = 2 => 0.3956935559,
			sy_ver_src_nas_cb_i = 3 => 0.4129692833,
			sy_ver_src_nas_cb_i = 4 => 0.6666666667,
									   0.3498306998);

		so_ver_src_nas_cb_i := map(
			ver_src_nas_cb <= 1 => 3,
			ver_src_nas_cb <= 9 => 2,
								   1);

		so_ver_src_nas_cb_i_om := map(
			so_ver_src_nas_cb_i = 1 => 0.2374965912,
			so_ver_src_nas_cb_i = 2 => 0.3399889838,
			so_ver_src_nas_cb_i = 3 => 0.366598778,
									   0.2675244268);

		mth_ver_src_fdate_cb := map(
			mth_ver_src_fdate_eq >= 0 => mth_ver_src_fdate_eq,
			mth_ver_src_fdate_en >= 0 => mth_ver_src_fdate_en,
										 NULL);

		sw_ver_src_fdate_cb := map(
			mth_ver_src_fdate_cb = NULL => -1,
			mth_ver_src_fdate_cb <= 60  => 8,
			mth_ver_src_fdate_cb <= 125 => 7,
			mth_ver_src_fdate_cb <= 220 => 6,
			mth_ver_src_fdate_cb <= 240 => 5,
			mth_ver_src_fdate_cb <= 273 => 4,
			mth_ver_src_fdate_cb <= 288 => 3,
			mth_ver_src_fdate_cb <= 303 => 2,
										   1);

		sw_ver_src_fdate_cb_wm := map(
			sw_ver_src_fdate_cb = -1 => 0.2068965517,
			sw_ver_src_fdate_cb = 1  => 0.1314756672,
			sw_ver_src_fdate_cb = 2  => 0.1344359627,
			sw_ver_src_fdate_cb = 3  => 0.1606409203,
			sw_ver_src_fdate_cb = 4  => 0.1670221843,
			sw_ver_src_fdate_cb = 5  => 0.1737616099,
			sw_ver_src_fdate_cb = 6  => 0.1885179153,
			sw_ver_src_fdate_cb = 7  => 0.1973515592,
			sw_ver_src_fdate_cb = 8  => 0.2673267327,
										0.1702257723);

		_age_fseen_cb := if(_age > 0 and mth_ver_src_fdate_cb > 0, _age - round(mth_ver_src_fdate_cb / 12), NULL);

		so_mth_on_cb := map(
			_age_fseen_cb < 0  => -2,
			_age_fseen_cb < 18 => -1,
								  round(mth_ver_src_fdate_cb));

		so_mth_on_cb_i := map(
			so_mth_on_cb = -2   => -2,
			so_mth_on_cb = -1   => -1,
			so_mth_on_cb <= 84  => 9,
			so_mth_on_cb <= 115 => 8,
			so_mth_on_cb <= 162 => 7,
			so_mth_on_cb <= 232 => 6,
			so_mth_on_cb <= 254 => 5,
			so_mth_on_cb <= 268 => 4,
			so_mth_on_cb <= 280 => 3,
			so_mth_on_cb <= 307 => 2,
								   1);

		so_mth_on_cb_i_om := map(
			so_mth_on_cb_i = -2 => 0.3624454148,
			so_mth_on_cb_i = -1 => 0.319391635,
			so_mth_on_cb_i = 1  => 0.1948105437,
			so_mth_on_cb_i = 2  => 0.2062937063,
			so_mth_on_cb_i = 3  => 0.2199741713,
			so_mth_on_cb_i = 4  => 0.2399349329,
			so_mth_on_cb_i = 5  => 0.2484669063,
			so_mth_on_cb_i = 6  => 0.2764015645,
			so_mth_on_cb_i = 7  => 0.2843837318,
			so_mth_on_cb_i = 8  => 0.2880984952,
			so_mth_on_cb_i = 9  => 0.3229895105,
								   0.2675244268);

		sd_ver_src_nas_p := map(
			ver_src_nas_p = 0 and (integer)ver_src_p = 0 => 4,
			ver_src_nas_p = 0                            => 3,
			ver_src_nas_p < 5                            => 2,
															1);

		sd_ver_p_x := map(
			sd_ver_src_nas_p = 1                     => 1,
			sd_ver_src_nas_p = 2 and add1_naprop = 4 => 1,
			sd_ver_src_nas_p = 2 and add1_naprop = 3 => 2,
			sd_ver_src_nas_p = 3 and add1_naprop = 3 => 2,
			sd_ver_src_nas_p = 3 and add1_naprop = 4 => 2,
			sd_ver_src_nas_p = 2                     => 3,
			sd_ver_src_nas_p = 3 and add1_naprop = 2 => 3,
			sd_ver_src_nas_p = 4 and add1_naprop = 4 => 3,
			sd_ver_src_nas_p = 3                     => 4,
			sd_ver_src_nas_p = 4 and add1_naprop = 3 => 4,
			sd_ver_src_nas_p = 4 and add1_naprop = 0 => 5,
			sd_ver_src_nas_p = 4 and add1_naprop = 2 => 5,
														6);

		sd_ver_p_x_m := map(
			sd_ver_p_x = 1 => 0.235857363,
			sd_ver_p_x = 2 => 0.2883895131,
			sd_ver_p_x = 3 => 0.304062026,
			sd_ver_p_x = 4 => 0.3638010872,
			sd_ver_p_x = 5 => 0.4013333333,
			sd_ver_p_x = 6 => 0.4149458133,
							  0.3614663257);

		sy_ver_p_x := map(
			add1_naprop = 4 and (integer)ver_src_p = 1 => 1,
			(add1_naprop in [3, 4])                    => 2,
			(integer)ver_src_p = 1                     => 3,
														  4);

		sy_ver_p_x_ym := map(
			sy_ver_p_x = 1 => 0.2370820669,
			sy_ver_p_x = 2 => 0.3081695967,
			sy_ver_p_x = 3 => 0.3117206983,
			sy_ver_p_x = 4 => 0.3621264817,
							  0.3498306998);

		sw_ver_p_x := map(
			add1_naprop = 4 and ver_src_nas_p > 0 => 1,
			add1_naprop = 4                       => 2,
			ver_src_nas_p > 0                     => 3,
													 4);

		sw_ver_p_x_wm := map(
			sw_ver_p_x = 1 => 0.143245213,
			sw_ver_p_x = 2 => 0.1866081229,
			sw_ver_p_x = 3 => 0.2146430196,
			sw_ver_p_x = 4 => 0.2524366472,
							  0.1702257723);

		so_ver_src_nas_p := map(
			ver_src_nas_p = 0 and (integer)ver_src_p = 0 => 3,
			ver_src_nas_p = 0                            => 2,
			ver_src_nas_p < 5                            => 2,
															1);

		so_ver_p_x := map(
			so_ver_src_nas_p = 1                     => 1,
			so_ver_src_nas_p = 2 and add1_naprop > 1 => 2,
			so_ver_src_nas_p = 2                     => 3,
			so_ver_src_nas_p = 3 and add1_naprop > 1 => 4,
			so_ver_src_nas_p = 3 and add1_naprop = 0 => 5,
														6);

		so_ver_p_x_om := map(
			so_ver_p_x = 1 => 0.175308642,
			so_ver_p_x = 2 => 0.17752443,
			so_ver_p_x = 3 => 0.2114545137,
			so_ver_p_x = 4 => 0.2644203312,
			so_ver_p_x = 5 => 0.275219553,
			so_ver_p_x = 6 => 0.2857387043,
							  0.2675244268);

		sd_ver_src_fdate_ts := map(
			mth_ver_src_fdate_ts = NULL => -1,
			mth_ver_src_fdate_ts <= 24  => 7,
			mth_ver_src_fdate_ts <= 36  => 6,
			mth_ver_src_fdate_ts <= 60  => 5,
			mth_ver_src_fdate_ts <= 120 => 4,
			mth_ver_src_fdate_ts <= 180 => 3,
			mth_ver_src_fdate_ts <= 240 => 2,
										   1);

		sd_ver_src_fdate_ts_m := map(
			sd_ver_src_fdate_ts = -1 => 0.3756881984,
			sd_ver_src_fdate_ts = 1  => 0.1976190476,
			sd_ver_src_fdate_ts = 2  => 0.3009708738,
			sd_ver_src_fdate_ts = 3  => 0.348997996,
			sd_ver_src_fdate_ts = 4  => 0.3521986971,
			sd_ver_src_fdate_ts = 5  => 0.3946133442,
			sd_ver_src_fdate_ts = 6  => 0.4072543618,
			sd_ver_src_fdate_ts = 7  => 0.4115616911,
										0.3614663257);

		sw_ver_src_fdate_ts := map(
			mth_ver_src_fdate_ts = NULL => 5,
			mth_ver_src_fdate_ts <= 36  => 5,
			mth_ver_src_fdate_ts <= 120 => 4,
			mth_ver_src_fdate_ts <= 180 => 3,
			mth_ver_src_fdate_ts <= 240 => 2,
										   1);

		sw_ver_src_fdate_ts_wm := map(
			sw_ver_src_fdate_ts = 1 => 0.1305732484,
			sw_ver_src_fdate_ts = 2 => 0.1352331606,
			sw_ver_src_fdate_ts = 3 => 0.1623086303,
			sw_ver_src_fdate_ts = 4 => 0.1729559748,
			sw_ver_src_fdate_ts = 5 => 0.1843797498,
									   0.1702257723);

		sw_ver_src_fdate_ts_om := map(
			sw_ver_src_fdate_ts = 1 => 0.1522491349,
			sw_ver_src_fdate_ts = 2 => 0.2307417974,
			sw_ver_src_fdate_ts = 3 => 0.2586588588,
			sw_ver_src_fdate_ts = 4 => 0.260267398,
			sw_ver_src_fdate_ts = 5 => 0.2858428314,
									   0.2675244268);

		sd_gong_did_phone_ct := map(
			gong_did_phone_ct <= 1 => 1,
			gong_did_phone_ct <= 2 => 2,
			gong_did_phone_ct <= 3 => 3,
			gong_did_phone_ct <= 4 => 4,
			gong_did_phone_ct <= 6 => 5,
			gong_did_phone_ct <= 9 => 6,
									  7);

		sd_gong_did_phone_ct_m := map(
			sd_gong_did_phone_ct = 1 => 0.3392008192,
			sd_gong_did_phone_ct = 2 => 0.3557940607,
			sd_gong_did_phone_ct = 3 => 0.3940272543,
			sd_gong_did_phone_ct = 4 => 0.4275899973,
			sd_gong_did_phone_ct = 5 => 0.4602194787,
			sd_gong_did_phone_ct = 6 => 0.5385405961,
			sd_gong_did_phone_ct = 7 => 0.6532663317,
										0.3614663257);

		so_gong_did_phone_ct := min(6, if(max(1, gong_did_phone_ct) = NULL, -NULL, max(1, gong_did_phone_ct)));

		so_gong_did_phone_ct_om := map(
			so_gong_did_phone_ct = 1 => 0.2562289754,
			so_gong_did_phone_ct = 2 => 0.2687654176,
			so_gong_did_phone_ct = 3 => 0.271590089,
			so_gong_did_phone_ct = 4 => 0.3442136499,
			so_gong_did_phone_ct = 5 => 0.3583333333,
			so_gong_did_phone_ct = 6 => 0.4,
										0.2675244268);

		sd_gong_did_first_ct := min(5, if(max(1, gong_did_first_ct) = NULL, -NULL, max(1, gong_did_first_ct)));

		sd_gong_did_first_ct_m := map(
			sd_gong_did_first_ct = 1 => 0.353585014,
			sd_gong_did_first_ct = 2 => 0.3840898456,
			sd_gong_did_first_ct = 3 => 0.4715099715,
			sd_gong_did_first_ct = 4 => 0.5580110497,
			sd_gong_did_first_ct = 5 => 0.59375,
										0.3614663257);

		sy_gong_did_last_ct := min(3, if(max(0, gong_did_last_ct) = NULL, -NULL, max(0, gong_did_last_ct)));

		sy_gong_did_last_ct_ym := map(
			sy_gong_did_last_ct = 0 => 0.3281463748,
			sy_gong_did_last_ct = 1 => 0.3894774645,
			sy_gong_did_last_ct = 2 => 0.4117647059,
			sy_gong_did_last_ct = 3 => 0.5666666667,
									   0.3498306998);

		sw_gong_did_first_ct := if(gong_did_first_ct = 0, -1, min(3, if(gong_did_first_ct = NULL, -NULL, gong_did_first_ct)));

		sw_gong_did_last_ct := if(gong_did_last_ct = 0, -1, min(3, if(gong_did_last_ct = NULL, -NULL, gong_did_last_ct)));

		sw_gong_did_fl_ct := map(
			sw_gong_did_first_ct = -1 or sw_gong_did_last_ct = -1 => -1,
			sw_gong_did_last_ct = 1 and sw_gong_did_first_ct = 1  => 1,
			sw_gong_did_last_ct = 1 and sw_gong_did_first_ct = 2  => 2,
			sw_gong_did_last_ct = 2 and sw_gong_did_first_ct = 1  => 3,
			sw_gong_did_last_ct = 3                               => 5,
																	 4);

		sw_gong_did_fl_ct_wm := map(
			sw_gong_did_fl_ct = -1 => 0.1723221267,
			sw_gong_did_fl_ct = 1  => 0.1643428571,
			sw_gong_did_fl_ct = 2  => 0.1677322302,
			sw_gong_did_fl_ct = 3  => 0.1770134228,
			sw_gong_did_fl_ct = 4  => 0.2132796781,
			sw_gong_did_fl_ct = 5  => 0.2832369942,
									  0.1702257723);

		sd_gong_did_first_ct_om := map(
			sd_gong_did_first_ct = 1 => 0.2632261817,
			sd_gong_did_first_ct = 2 => 0.2860371267,
			sd_gong_did_first_ct = 3 => 0.3578500707,
			sd_gong_did_first_ct = 4 => 0.4084507042,
			sd_gong_did_first_ct = 5 => 0.6666666667,
										0.2675244268);

		sd_combo_fnamecount := min(9, if(max(1, combo_fnamecount) = NULL, -NULL, max(1, combo_fnamecount)));

		sd_combo_fnamecount_m := map(
			sd_combo_fnamecount = 1 => 0.5377516779,
			sd_combo_fnamecount = 2 => 0.4575943244,
			sd_combo_fnamecount = 3 => 0.4074688797,
			sd_combo_fnamecount = 4 => 0.3799239435,
			sd_combo_fnamecount = 5 => 0.3639166824,
			sd_combo_fnamecount = 6 => 0.3307074452,
			sd_combo_fnamecount = 7 => 0.3056949323,
			sd_combo_fnamecount = 8 => 0.2978158205,
			sd_combo_fnamecount = 9 => 0.247008547,
									   0.3614663257);

		sw_combo_fnamecount := min(6, if(max(2, combo_fnamecount) = NULL, -NULL, max(2, combo_fnamecount)));

		sw_combo_fnamecount_wm := map(
			sw_combo_fnamecount = 2 => 0.2288828338,
			sw_combo_fnamecount = 3 => 0.2003610108,
			sw_combo_fnamecount = 4 => 0.1753134457,
			sw_combo_fnamecount = 5 => 0.168320052,
			sw_combo_fnamecount = 6 => 0.1589753075,
									   0.1702257723);

		sd_combo_fnamecount_om := map(
			sd_combo_fnamecount = 1 => 0.3427265804,
			sd_combo_fnamecount = 2 => 0.2931738623,
			sd_combo_fnamecount = 3 => 0.2753523548,
			sd_combo_fnamecount = 4 => 0.2665480977,
			sd_combo_fnamecount = 5 => 0.2504836575,
			sd_combo_fnamecount = 6 => 0.2370471367,
			sd_combo_fnamecount = 7 => 0.2255340288,
			sd_combo_fnamecount = 8 => 0.2138939671,
			sd_combo_fnamecount = 9 => 0.15,
									   0.2675244268);

		_add2_naprop34 := (add2_naprop in [3, 4]);

		_add3_naprop34 := (add3_naprop in [3, 4]);

		_add23_naprop34 := (integer)_add2_naprop34 = 1 or (integer)_add3_naprop34 = 1;

		sd_add2_source_count := map(
			add2_source_count = 0  => 6,
			add2_source_count = 1  => 5,
			add2_source_count <= 4 => 4,
			add2_source_count <= 5 => 3,
			add2_source_count <= 6 => 2,
									  1);

		sd_add2_source_count_m := map(
			sd_add2_source_count = 1 => 0.2444196429,
			sd_add2_source_count = 2 => 0.3077873918,
			sd_add2_source_count = 3 => 0.3375882672,
			sd_add2_source_count = 4 => 0.3539679465,
			sd_add2_source_count = 5 => 0.3887126819,
			sd_add2_source_count = 6 => 0.4334828102,
										0.3614663257);

		sd_add1_source_count := min(7, if(max(0, add1_source_count) = NULL, -NULL, max(0, add1_source_count)));

		sd_add1_source_count_om := map(
			sd_add1_source_count = 0 => 0.3417836499,
			sd_add1_source_count = 1 => 0.2610749186,
			sd_add1_source_count = 2 => 0.2528235416,
			sd_add1_source_count = 3 => 0.2434561626,
			sd_add1_source_count = 4 => 0.2327672328,
			sd_add1_source_count = 5 => 0.2,
			sd_add1_source_count = 6 => 0.1854934602,
			sd_add1_source_count = 7 => 0.1577287066,
										0.2675244268);

		so_add2_source_count := map(
			add2_source_count = 0  => 6,
			add2_source_count = 1  => 5,
			add2_source_count <= 3 => 4,
			add2_source_count <= 4 => 3,
			add2_source_count <= 5 => 2,
									  1);

		so_add2_source_count_om := map(
			so_add2_source_count = 1 => 0.2111913357,
			so_add2_source_count = 2 => 0.2379333787,
			so_add2_source_count = 3 => 0.2454249185,
			so_add2_source_count = 4 => 0.2546803387,
			so_add2_source_count = 5 => 0.29170659,
			so_add2_source_count = 6 => 0.3020193152,
										0.2675244268);

		sd_ver_ssn_cnt := if(rc_ssncount = 5 and ((integer)ver_ssn_src_l2 = 1 or (integer)ver_ssn_src_mw = 1), 0, min(3, if(max(0, rc_ssncount) = NULL, -NULL, max(0, rc_ssncount))));

		sd_ver_ssn_cnt_m := map(
			sd_ver_ssn_cnt = 0 => 0.5434298441,
			sd_ver_ssn_cnt = 1 => 0.4501525124,
			sd_ver_ssn_cnt = 2 => 0.3618992997,
			sd_ver_ssn_cnt = 3 => 0.3068775853,
								  0.3614663257);

		sd_pl_good_1 := (integer)prof_license_category > 1;

		sd_ams_good := (ams_college_code in ['1', '4']) and '0' <= ams_college_tier AND ams_college_tier <= '4' or addr_hist_advo_college;

		sd_pl_ams_good := (integer)sd_pl_good_1 = 1 or (integer)sd_ams_good = 1;

		sy_ams_tier := map(
			(integer)ams_college_tier between 1 and 3 => 1,
			(integer)ams_college_tier between 4 and 5 => 2,
			// (string)1 <= ams_college_tier AND ams_college_tier <= (string)3 => 1,
			// (string)4 <= ams_college_tier AND ams_college_tier <= (string)5 => 2,
			ams_college_tier = '0'                                    => 2,
			ams_college_tier = '6'                                    => 3,
																	   4);

		sy_amspl_tier := if(prof_license_category > '0', 1, sy_ams_tier);

		sy_amspl_tier_ym := map(
			sy_amspl_tier = 1 => 0.2256699577,
			sy_amspl_tier = 2 => 0.3073463268,
			sy_amspl_tier = 3 => 0.3496240602,
			sy_amspl_tier = 4 => 0.3593925388,
								 0.3498306998);

		sw_ams_good := (ams_college_code in ['1', '4']) and ams_college_tier between '0' and '4';

		sw_pl_ams := (integer)sw_ams_good = 1 or prof_license_category > (string)1;

		so_ams_x := map(
			ams_college_code = '1' or ams_college_tier between '0' and '3' => 1,
			ams_college_code = '4' and ams_college_tier = '4'                                   => 2,
			ams_college_code = '4'                                                                    => 3,
			ams_college_code = '2'                                                                    => 4,
																											   -1);

		so_ams_x_om := map(
			so_ams_x = -1 => 0.2723063071,
			so_ams_x = 1  => 0.1532125206,
			so_ams_x = 2  => 0.1873622337,
			so_ams_x = 3  => 0.2217514124,
			so_ams_x = 4  => 0.3001138952,
							 0.2675244268);

		sd_pl_good := prof_license_category > '1';

		sd_infutor_nap := map(
			(infutor_nap in [1, 6]) => 3,
			infutor_nap = 12        => 1,
									   2);

		sd_infutor_nap_m := map(
			sd_infutor_nap = 1 => 0.3349677916,
			sd_infutor_nap = 2 => 0.3534227611,
			sd_infutor_nap = 3 => 0.400393976,
								  0.3614663257);

		sy_infutor_nap16 := (infutor_nap in [1, 6]);

		so_infutor_nap := map(
			infutor_nap = 12        => 1,
			(infutor_nap in [1, 6]) => 3,
									   2);

		so_infutor_nap_om := map(
			so_infutor_nap = 1 => 0.255754818,
			so_infutor_nap = 2 => 0.2592445692,
			so_infutor_nap = 3 => 0.2989420303,
								  0.2675244268);

		sd_attr_num_nonderogs180 := min(6, max(0, attr_num_nonderogs180));

		sd_attr_num_nonderogs180_m := map(
			sd_attr_num_nonderogs180 = 0 => 0.4894366197,
			sd_attr_num_nonderogs180 = 1 => 0.395686534,
			sd_attr_num_nonderogs180 = 2 => 0.3512790566,
			sd_attr_num_nonderogs180 = 3 => 0.3288394828,
			sd_attr_num_nonderogs180 = 4 => 0.2830188679,
			sd_attr_num_nonderogs180 = 5 => 0.2618181818,
			sd_attr_num_nonderogs180 = 6 => 0.1176470588,
											0.3614663257);

		so_property_sold := min(2, if(property_sold_total = NULL, -NULL, property_sold_total));

		so_prop_x := map(
			so_property_sold = 0 and watercraft_count > 0 => 2,
			so_property_sold = 2                          => 1,
			so_property_sold = 1                          => 2,
															 3);

		so_prop_x_om := map(
			so_prop_x = 1 => 0.1616314199,
			so_prop_x = 2 => 0.1987212276,
			so_prop_x = 3 => 0.2747224757,
							 0.2675244268);

		sd_ssns_per_adl := if(ssns_per_adl = 0, 5, min(6, if(ssns_per_adl = NULL, -NULL, ssns_per_adl)));

		sd_ssns_per_adl_m := map(
			sd_ssns_per_adl = 1 => 0.3476693156,
			sd_ssns_per_adl = 2 => 0.363449692,
			sd_ssns_per_adl = 3 => 0.3981664569,
			sd_ssns_per_adl = 4 => 0.4368641532,
			sd_ssns_per_adl = 5 => 0.5223420647,
			sd_ssns_per_adl = 6 => 0.6034482759,
								   0.3614663257);

		sd_adlperssn_count := if(adlperssn_count = 0, 6, min(7, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		sd_adlperssn_count_m := map(
			sd_adlperssn_count = 1 => 0.3504653593,
			sd_adlperssn_count = 2 => 0.3723540567,
			sd_adlperssn_count = 3 => 0.3843914863,
			sd_adlperssn_count = 4 => 0.403187251,
			sd_adlperssn_count = 5 => 0.4227129338,
			sd_adlperssn_count = 6 => 0.4913793103,
			sd_adlperssn_count = 7 => 0.5352112676,
									  0.3614663257);

		sd_ssns_per_addr := map(
			ssns_per_addr = 0  => 5,
			ssns_per_addr = 1  => 4,
			ssns_per_addr = 2  => 1,
			ssns_per_addr <= 4 => 2,
			ssns_per_addr < 10 => 3,
								  4);

		sd_ssns_per_addr_m := map(
			sd_ssns_per_addr = 1 => 0.2981867025,
			sd_ssns_per_addr = 2 => 0.3117807073,
			sd_ssns_per_addr = 3 => 0.3257959131,
			sd_ssns_per_addr = 4 => 0.3714780419,
			sd_ssns_per_addr = 5 => 0.4011118833,
									0.3614663257);

		sd_ssns_per_adl_c6 := min(2, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6));

		sd_ssns_per_adl_c6_m := map(
			sd_ssns_per_adl_c6 = 0 => 0.3521005895,
			sd_ssns_per_adl_c6 = 1 => 0.3649551587,
			sd_ssns_per_adl_c6 = 2 => 0.4222340994,
									  0.3614663257);

		sd_phones_per_adl_c6 := min(3, if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6));

		sd_phones_per_adl_c6_m := map(
			sd_phones_per_adl_c6 = 0 => 0.3585334758,
			sd_phones_per_adl_c6 = 1 => 0.3724776712,
			sd_phones_per_adl_c6 = 2 => 0.4357476636,
			sd_phones_per_adl_c6 = 3 => 0.4626865672,
										0.3614663257);

		sd_addrs_per_ssn_c6 := min(3, if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6));

		sd_addrs_per_ssn_c6_m := map(
			sd_addrs_per_ssn_c6 = 0 => 0.3327546407,
			sd_addrs_per_ssn_c6 = 1 => 0.4444938491,
			sd_addrs_per_ssn_c6 = 2 => 0.5401945725,
			sd_addrs_per_ssn_c6 = 3 => 0.5705882353,
									   0.3614663257);

		sd_adls_per_addr_c6 := min(6, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		sd_adls_per_addr_c6_m := map(
			sd_adls_per_addr_c6 = 0 => 0.3490342879,
			sd_adls_per_addr_c6 = 1 => 0.3725789334,
			sd_adls_per_addr_c6 = 2 => 0.3912353128,
			sd_adls_per_addr_c6 = 3 => 0.4012615235,
			sd_adls_per_addr_c6 = 4 => 0.4428969359,
			sd_adls_per_addr_c6 = 5 => 0.4727272727,
			sd_adls_per_addr_c6 = 6 => 0.5423728814,
									   0.3614663257);

		sy_ssns_per_adl := map(
			ssns_per_adl = 1 => 1,
			ssns_per_adl = 0 => 2,
								3);

		sy_ssns_per_adl_ym := map(
			sy_ssns_per_adl = 1 => 0.3412853604,
			sy_ssns_per_adl = 2 => 0.3844086022,
			sy_ssns_per_adl = 3 => 0.408773679,
								   0.3498306998);

		sy_adlperssn_count := if(adlperssn_count = 0, 2, min(3, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		sy_adlperssn_count_ym := map(
			sy_adlperssn_count = 1 => 0.3400678715,
			sy_adlperssn_count = 2 => 0.3701171875,
			sy_adlperssn_count = 3 => 0.3924449108,
									  0.3498306998);

		sy_addrs_per_ssn_c6 := min(2, if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6));

		sy_addrs_per_ssn_c6_ym := map(
			sy_addrs_per_ssn_c6 = 0 => 0.3273242541,
			sy_addrs_per_ssn_c6 = 1 => 0.3907206783,
			sy_addrs_per_ssn_c6 = 2 => 0.495460441,
									   0.3498306998);

		sy_phones_per_adl_c6 := min(1, if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6));

		sy_lnames_per_adl_c6 := min(1, if(lnames_per_adl_c6 = NULL, -NULL, lnames_per_adl_c6));

		sy_adls_per_ssn_c6 := min(1, if(adls_per_ssn_c6 = NULL, -NULL, adls_per_ssn_c6));

		sy_adls_per_addr_c6 := adls_per_addr_c6 > 4;

		sy_phones_per_addr_c6 := phones_per_addr_c6 > 5;

		sy_adls_per_phone_c6 := adls_per_phone_c6 > 0;

		sy_velocity_c6 := sy_phones_per_adl_c6 = 1 or sy_lnames_per_adl_c6 = 1 or sy_adls_per_ssn_c6 = 1 or (integer)sy_adls_per_addr_c6 = 1 or (integer)sy_phones_per_addr_c6 = 1 or (integer)sy_adls_per_phone_c6 = 1;

		sw_ssns_per_adl := if(ssns_per_adl = 0, 3, min(4, if(ssns_per_adl = NULL, -NULL, ssns_per_adl)));

		sw_ssns_per_adl_wm := map(
			sw_ssns_per_adl = 1 => 0.1610888522,
			sw_ssns_per_adl = 2 => 0.1796778191,
			sw_ssns_per_adl = 3 => 0.2105263158,
			sw_ssns_per_adl = 4 => 0.2643171806,
								   0.1702257723);

		sw_adlperssn_count := if(adlperssn_count = 0, 4, min(4, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		sw_adlperssn_count_wm := map(
			sw_adlperssn_count = 1 => 0.1641770869,
			sw_adlperssn_count = 2 => 0.1726568006,
			sw_adlperssn_count = 3 => 0.1834908006,
			sw_adlperssn_count = 4 => 0.2417582418,
									  0.1702257723);

		sw_adls_per_addr := map(
			adls_per_addr = 2 => 1,
			adls_per_addr = 0 => 3,
								 2);

		sw_adls_per_addr_wm := map(
			sw_adls_per_addr = 1 => 0.1189358372,
			sw_adls_per_addr = 2 => 0.1675415362,
			sw_adls_per_addr = 3 => 0.2188376754,
									0.1702257723);

		sw_ssns_per_adl_c6 := min(2, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6));

		sw_ssns_per_adl_c6_wm := map(
			sw_ssns_per_adl_c6 = 0 => 0.1556028107,
			sw_ssns_per_adl_c6 = 1 => 0.1795565577,
			sw_ssns_per_adl_c6 = 2 => 0.2517985612,
									  0.1702257723);

		sw_phones_per_adl_c6 := min(2, if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6));

		sw_phones_per_adl_c6_wm := map(
			sw_phones_per_adl_c6 = 0 => 0.1667642467,
			sw_phones_per_adl_c6 = 1 => 0.1871485944,
			sw_phones_per_adl_c6 = 2 => 0.1954397394,
										0.1702257723);

		sw_addrs_per_ssn_c6 := min(2, if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6));

		sw_addrs_per_ssn_c6_wm := map(
			sw_addrs_per_ssn_c6 = 0 => 0.1617397681,
			sw_addrs_per_ssn_c6 = 1 => 0.2303030303,
			sw_addrs_per_ssn_c6 = 2 => 0.3196721311,
									   0.1702257723);

		sw_adls_per_addr_c6 := min(4, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		sw_adls_per_addr_c6_wm := map(
			sw_adls_per_addr_c6 = 0 => 0.1595352791,
			sw_adls_per_addr_c6 = 1 => 0.1951113051,
			sw_adls_per_addr_c6 = 2 => 0.1934703748,
			sw_adls_per_addr_c6 = 3 => 0.2142857143,
			sw_adls_per_addr_c6 = 4 => 0.2488038278,
									   0.1702257723);

		so_ssns_per_adl := map(
			ssns_per_adl = 0  => -1,
			ssns_per_adl <= 1 => 1,
			ssns_per_adl <= 2 => 2,
			ssns_per_adl <= 3 => 3,
			ssns_per_adl <= 5 => 4,
								 5);

		so_ssns_per_adl_om := map(
			so_ssns_per_adl = -1 => 0.3795454545,
			so_ssns_per_adl = 1  => 0.2520001092,
			so_ssns_per_adl = 2  => 0.2914661237,
			so_ssns_per_adl = 3  => 0.3056163384,
			so_ssns_per_adl = 4  => 0.3982869379,
			so_ssns_per_adl = 5  => 0.5070422535,
									0.2675244268);

		so_adlperssn_ct := map(
			adlperssn_count = 0  => -1,
			adlperssn_count <= 1 => 1,
			adlperssn_count <= 2 => 2,
			adlperssn_count <= 5 => 3,
									4);

		so_adlperssn_ct_om := map(
			so_adlperssn_ct = -1 => 0.375,
			so_adlperssn_ct = 1  => 0.2561744861,
			so_adlperssn_ct = 2  => 0.2780889165,
			so_adlperssn_ct = 3  => 0.2994094488,
			so_adlperssn_ct = 4  => 0.4787878788,
									0.2675244268);

		so_adls_per_phone := min(5, if(max(0, adls_per_phone) = NULL, -NULL, max(0, adls_per_phone)));

		so_adls_per_phone_om := map(
			so_adls_per_phone = 0 => 0.2670481767,
			so_adls_per_phone = 1 => 0.2626601324,
			so_adls_per_phone = 2 => 0.2930107527,
			so_adls_per_phone = 3 => 0.3087557604,
			so_adls_per_phone = 4 => 0.4444444444,
			so_adls_per_phone = 5 => 0.75,
									 0.2675244268);

		so_phones_per_adl_c6 := min(4, if(max(0, phones_per_adl_c6) = NULL, -NULL, max(0, phones_per_adl_c6)));

		so_phones_per_adl_c6_om := map(
			so_phones_per_adl_c6 = 0 => 0.2654376231,
			so_phones_per_adl_c6 = 1 => 0.2768779886,
			so_phones_per_adl_c6 = 2 => 0.3246187364,
			so_phones_per_adl_c6 = 3 => 0.380952381,
			so_phones_per_adl_c6 = 4 => 0.6,
										0.2675244268);

		so_lnames_per_adl_c6 := min(2, if(max(0, (integer)lnames_per_adl_c6) = NULL, -NULL, max(0, (integer)lnames_per_adl_c6)));

		so_lnames_per_adl_c6_om := map(
			so_lnames_per_adl_c6 = 0 => 0.2672883901,
			so_lnames_per_adl_c6 = 1 => 0.2703232125,
			so_lnames_per_adl_c6 = 2 => 0.4423076923,
										0.2675244268);

		so_addrs_per_ssn_c6 := min(2, if(max(0, addrs_per_ssn_c6) = NULL, -NULL, max(0, addrs_per_ssn_c6)));

		so_addrs_per_ssn_c6_om := map(
			so_addrs_per_ssn_c6 = 0 => 0.2495837456,
			so_addrs_per_ssn_c6 = 1 => 0.3258888889,
			so_addrs_per_ssn_c6 = 2 => 0.442926045,
									   0.2675244268);

		so_adls_per_addr_c6 := min(4, if(max(0, adls_per_addr_c6) = NULL, -NULL, max(0, adls_per_addr_c6)));

		so_adls_per_addr_c6_om := map(
			so_adls_per_addr_c6 = 0 => 0.2554340185,
			so_adls_per_addr_c6 = 1 => 0.2887181561,
			so_adls_per_addr_c6 = 2 => 0.2930043124,
			so_adls_per_addr_c6 = 3 => 0.3077469794,
			so_adls_per_addr_c6 = 4 => 0.3559322034,
									   0.2675244268);

		sd_inq_count12 := min(4, Inq_count12);

		inq_last_log_date2 := common.sas_date((string)(Inq_last_log_date));

		mth_inq_last_log_date := if(min(sysdate, inq_last_log_date2) = NULL, NULL, (sysdate - inq_last_log_date2) / 30.5);

		sd_inq_count12_2 := if(sd_inq_count12 > 2 and 0 <= mth_inq_last_log_date AND mth_inq_last_log_date <= 1, 3, min(2, sd_inq_count12));

		sd_inq_count12_2_m := map(
			sd_inq_count12_2 = 0 => 0.3224417784,
			sd_inq_count12_2 = 1 => 0.3893519306,
			sd_inq_count12_2 = 2 => 0.440679593,
			sd_inq_count12_2 = 3 => 0.5125448029,
									0.3614663257);

		sd_inq_communications_count12 := min(2, Inq_Communications_count12);

		sd_inq_communications_count12_m := map(
			sd_inq_communications_count12 = 0 => 0.3575075212,
			sd_inq_communications_count12 = 1 => 0.4629725531,
			sd_inq_communications_count12 = 2 => 0.5847750865,
												 0.3614663257);

		sd_inq_adlsperaddr := min(3, Inq_ADLsPerAddr);

		sd_inq_adlsperaddr_m := map(
			sd_inq_adlsperaddr = 0 => 0.3376725838,
			sd_inq_adlsperaddr = 1 => 0.3898028305,
			sd_inq_adlsperaddr = 2 => 0.4114528102,
			sd_inq_adlsperaddr = 3 => 0.440966976,
									  0.3614663257);

		sy_inq_count12 := if(Inq_Communications_count12 > 0, 3, min(3, Inq_count12));

		sy_inq_count12_ym := map(
			sy_inq_count12 = 0 => 0.3285714286,
			sy_inq_count12 = 1 => 0.3792390405,
			sy_inq_count12 = 2 => 0.4250960307,
			sy_inq_count12 = 3 => 0.475020475,
								  0.3498306998);

		sy_inq_peraddr := min(1, Inq_PerAddr);

		sw_inq_count12 := min(4, Inq_count12);

		sw_inq_count03 := min(2, Inq_count03);

		sw_inq_ct_x := if(sw_inq_count03 > 1, 4, sw_inq_count12);

		sw_inq_ct_x_wm := map(
			sw_inq_ct_x = 0 => 0.1500786576,
			sw_inq_ct_x = 1 => 0.2256891851,
			sw_inq_ct_x = 2 => 0.2250608273,
			sw_inq_ct_x = 3 => 0.2432432432,
			sw_inq_ct_x = 4 => 0.2965009208,
							   0.1702257723);

		sw_inq_peraddr := min(3, Inq_PerAddr);

		sw_inq_peraddr_wm := map(
			sw_inq_peraddr = 0 => 0.1505847953,
			sw_inq_peraddr = 1 => 0.2029530201,
			sw_inq_peraddr = 2 => 0.2400835073,
			sw_inq_peraddr = 3 => 0.25,
								  0.1702257723);

		sw_inq_perphone := min(4, Inq_PerPhone);

		sw_inq_perphone_wm := map(
			sw_inq_perphone = 0 => 0.1560956333,
			sw_inq_perphone = 1 => 0.2225402504,
			sw_inq_perphone = 2 => 0.2457337884,
			sw_inq_perphone = 3 => 0.2870090634,
			sw_inq_perphone = 4 => 0.2906574394,
								   0.1702257723);

		so_inq_count12 := min(3,Inq_count12);

		so_inq_count06 := min(3,Inq_count06);

		so_inq_count01 := min(2,Inq_count01);

		so_inq_x := map(
			so_inq_count12 = 1 and so_inq_count06 >= 1 => 2,
			so_inq_count12 = 2 and so_inq_count06 >= 1 => 3,
			so_inq_count12 = 3 and so_inq_count06 >= 2 => 4,
														  so_inq_count12);

		so_inq_x2 := if(so_inq_x = 3 and so_inq_count01 >= 2, 4, so_inq_x);

		so_inq_x2_om := map(
			so_inq_x2 = 0 => 0.2432666334,
			so_inq_x2 = 1 => 0.2924449401,
			so_inq_x2 = 2 => 0.3299867399,
			so_inq_x2 = 3 => 0.356619066,
			so_inq_x2 = 4 => 0.3986647592,
							 0.2675244268);

		so_inq_ssnsperaddr := min(2, Inq_SSNsPerAddr);

		so_inq_ssnsperaddr_om := map(
			so_inq_ssnsperaddr = 0 => 0.2467939664,
			so_inq_ssnsperaddr = 1 => 0.298328161,
			so_inq_ssnsperaddr = 2 => 0.335239911,
									  0.2675244268);

		so_inq_adlsperphone := min(3, Inq_ADLsPerPhone);

		so_inq_adlsperphone_om := map(
			so_inq_adlsperphone = 0 => 0.2549933422,
			so_inq_adlsperphone = 1 => 0.3116064938,
			so_inq_adlsperphone = 2 => 0.3586278586,
			so_inq_adlsperphone = 3 => 0.4503631961,
									   0.2675244268);

		logit_3 := -18.02836643 +
			sd_add1_avm_log * -0.091778074 +
			sd_econtrj_m * 2.1538694848 +
			(integer)_phn_recent_disconnect * 0.1868975867 +
			(integer)_ssn_risk * 0.3567252031 +
			sd_age_log * -0.483125747 +
			sd_combo_dobcount_m * 0.8837085075 +
			(integer)_derog_bk_bad * 0.3987974479 +
			_lien_unrel_mon2_m * 0.9166861858 +
			_lien_cj_unrel_x_m * 0.9336765768 +
			_lien_lt_unrel_x_m * 0.7144274822 +
			_lien_sc_unrel_x_m * 4.0315324689 +
			_eviction_x_m * 2.4401794982 +
			_criminal_x5_m * 3.2691967551 +
			_impulse_x3_m * 3.389903457 +
			sd_nap_i_m * 2.1038814027 +
			sd_ver_src_nas_cb_i_m * 1.6370196337 +
			sd_ver_p_x_m * 1.468955431 +
			sd_ver_src_fdate_ts_m * 0.959339834 +
			sd_gong_did_phone_ct_m * 2.185622162 +
			sd_gong_did_first_ct_m * 0.8837940062 +
			sd_attr_num_nonderogs180_m * 0.7253798595 +
			sd_combo_fnamecount_m * 0.601764927 +
			(integer)add1_isbestmatch * -0.087662877 +
			sd_add2_source_count_m * 1.921625414 +
			sd_ver_ssn_cnt_m * 0.4288028978 +
			(integer)sd_pl_ams_good * -0.307473196 +
			sd_infutor_nap_m * 0.9822766325 +
			sd_ssns_per_adl_m * 3.184524308 +
			sd_adlperssn_count_m * 2.9892843753 +
			sd_ssns_per_addr_m * 0.9930120508 +
			sd_ssns_per_adl_c6_m * 3.6769731045 +
			sd_phones_per_adl_c6_m * 2.190921203 +
			sd_addrs_per_ssn_c6_m * 2.0441653187 +
			sd_adls_per_addr_c6_m * 2.3727436289 +
			sd_inq_count12_2_m * 2.2080538011 +
			sd_inq_communications_count12_m * 1.5983486434 +
			sd_inq_adlsperaddr_m * 2.2603586714;

		sd17 := exp(logit_3) / (1 + exp(logit_3));

		logit_2 := -8.689601184 +
			(integer)sy_add_risk * 0.1761469993 +
			sy_add1_avm_new_ym * 3.5614850218 +
			(integer)sd_phn_risk * 0.1720522292 +
			sy_age_log * -1.367691547 +
			sy_combo_dobcount_ym * 3.6592636975 +
			sy_nap_i_ym * 1.5699542938 +
			sy_ver_src_nas_cb_i_ym * 2.8178003128 +
			sy_ver_p_x_ym * 1.6857197104 +
			(integer)ver_src_l2 * 0.4743159344 +
			sy_gong_did_last_ct_ym * 3.6834360214 +
			sy_mth_header_fseen_ym * 1.7918505941 +
			(integer)_add23_naprop34 * -0.092063454 +
			sy_amspl_tier_ym * 3.386562644 +
			(integer)sy_infutor_nap16 * 0.1095807346 +
			sy_ssns_per_adl_ym * 2.9814627177 +
			sy_adlperssn_count_ym * 3.0159856654 +
			sy_addrs_per_ssn_c6_ym * 3.1560722515 +
			(integer)sy_velocity_c6 * 0.1985547223 +
			sy_inq_count12_ym * 3.399450931 +
			sy_inq_peraddr * 0.1479391785;

		sy10 := exp(logit_2) / (1 + exp(logit_2));

		logit_1 := -9.741123303 +
			(integer)_add_risk * 0.1521178222 +
			sw_add1_avm_log * -0.231343837 +
			sw_phn_x_wm * 3.4659657073 +
			(integer)sw_ssn_risk * 1.1358459362 +
			(integer)_dob_diff * 0.1708811157 +
			sw_nap_i_wm * 2.6756714202 +
			sw_ver_src_fdate_cb_wm * 4.6989787614 +
			sw_ver_p_x_wm * 2.418775093 +
			sw_ver_src_fdate_ts_wm * 4.0789351083 +
			(integer)ver_src_l2 * 0.1171316298 +
			sw_gong_did_fl_ct_wm * 4.5980573314 +
			sw_combo_fnamecount_wm * 2.9980960065 +
			(integer)add1_house_number_match * -0.293608256 +
			(integer)add1_isbestmatch * -0.101676312 +
			(integer)sw_pl_ams * -0.367571217 +
			(integer)sy_infutor_nap16 * 0.1251488103 +
			sw_ssns_per_adl_wm * 4.3572086192 +
			sw_adlperssn_count_wm * 4.0537153998 +
			sw_adls_per_addr_wm * 1.9998680709 +
			sw_ssns_per_adl_c6_wm * 3.8063887596 +
			sw_phones_per_adl_c6_wm * 9.5375798448 +
			sw_addrs_per_ssn_c6_wm * 3.7378071032 +
			sw_adls_per_addr_c6_wm * 4.0634822758 +
			sw_inq_ct_x_wm * 3.923276563 +
			sw_inq_peraddr_wm * 2.3821619577 +
			sw_inq_perphone_wm * 2.2529132392;

		sw07 := exp(logit_1) / (1 + exp(logit_1));

		logit := -14.64487621 +
			so_add1_avm_log * -0.312839031 +
			(integer)_phn_notpots * 0.0707678574 +
			(integer)so_phn_risk * 0.1544515908 +
			(integer)_ssn_risk * 0.2504643862 +
			so_age_om * 2.3017293859 +
			so_combo_dobcount_om * 2.0471460888 +
			(integer)ver_src_l2 * 0.1739795062 +
			so_prop_x_om * 1.822206539 +
			so_nap_i_om * 2.917510168 +
			so_ver_src_nas_cb_i_om * 2.1490813086 +
			so_mth_on_cb_i_om * 2.4347813624 +
			so_ver_p_x_om * 1.7602660335 +
			sw_ver_src_fdate_ts_om * 1.6406351835 +
			so_gong_did_phone_ct_om * 3.5718061441 +
			sd_gong_did_first_ct_om * 1.6295741482 +
			sd_combo_fnamecount_om * 1.4782457769 +
			(integer)add1_isbestmatch * -0.065646332 +
			sd_add1_source_count_om * 1.3725307785 +
			so_add2_source_count_om * 2.2898753197 +
			so_ams_x_om * 4.8643682603 +
			(integer)sd_pl_good * -0.312873904 +
			so_infutor_nap_om * 2.0407450417 +
			so_ssns_per_adl_om * 3.1130517927 +
			so_adlperssn_ct_om * 3.0776147376 +
			so_adls_per_phone_om * 2.4937209036 +
			so_phones_per_adl_c6_om * 3.7622471078 +
			so_lnames_per_adl_c6_om * 3.7783082775 +
			so_addrs_per_ssn_c6_om * 2.8725355744 +
			so_adls_per_addr_c6_om * 3.0146313628 +
			so_inq_x2_om * 3.6475358813 +
			so_inq_ssnsperaddr_om * 2.8221510122 +
			so_inq_adlsperphone_om * 1.5104968432;

		so10 := exp(logit) / (1 + exp(logit));

		phat := map(
			_rvg40_segment = '1 derog' => sd17,
			_rvg40_segment = '2 young' => sy10,
			_rvg40_segment = '3 owner' => sw07,
										  so10);

		base := 700;

		odds := 1 / 20;

		point := -40;

		rvg1103_raw := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

		ov_ssndead := (unsigned1)ssnlength > 0 and rc_decsflag = '1';

		ov_ssnprior := rc_ssndobflag = '1' or rc_pwssndobflag = '1';

		ov_criminal_flag := criminal_count > 0;

		ov_corrections := rc_hrisksic = '2225';

		ov_impulse := impulse_count > 0;

		lien_flag := (integer)ver_src_l2 = 1 or (integer)ver_src_li = 1 or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)ver_src_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		ssn_deceased := rc_decsflag = (string)1 or (integer)ver_src_ds = 1;

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid;

		rvg1103_cap := min(900, if(max(501, rvg1103_raw) = NULL, -NULL, max(501, rvg1103_raw)));

		rvg1103_cap2 := if(rvg1103_cap > 610 and (ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse), 610, rvg1103_cap);

		rvg1103_cap3 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvg1103_cap2);

		rvg1103 := if(ssn_deceased, 200, rvg1103_cap3);




		// reason codes
		// NULL := -999999999;
		// addrpop                          := le.addrpop;
		addrpop                          := le.input_validation.Address;
fnamepop                          := le.input_validation.firstname;
lnamepop                          := le.input_validation.lastname;
hphnpop														:= le.input_validation.homephone;
		dobpop                           := le.input_validation.dateofbirth;
		combo_lnamecount                 := le.iid.combo_lastcount;
		combo_addrcount                  := le.iid.combo_addrcount;
		combo_ssncount                   := le.iid.combo_ssncount;
		combo_hphonecount                   := le.iid.combo_hphonecount;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		property_ambig_total             := le.address_verification.ambiguous.property_total;


		glrc03 := (integer)ssnlength>0 and rc_ssndobflag = (string)1;

		glrc07 := (integer)hphnpop>0 and rc_hriskphoneflag = (string)5;

		glrc20 := ((integer)fnamepop>0 or (integer)lnamepop>0 or (integer)addrpop>0 or (integer)hphnpop>0) 
								and (combo_lnamecount = 0 or combo_addrcount = 0 or combo_hphonecount = 0 or combo_ssncount > 0);

		glrc25 := addrpop and combo_addrcount = 0;

		glrc28 := (integer)dobpop > 0 and combo_dobcount = 0;

		glrc97 := criminal_count > 0;

		glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

		glrc99 := (integer)addrpop>0 and (integer)add1_isbestmatch = 0;

		glrc9a := (add1_naprop < 2 or add2_naprop < 2 or add3_naprop < 2) and (integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 0 and (integer)add2_applicant_owned = 0 and (integer)add2_family_owned = 0 and (integer)add3_applicant_owned = 0 and (integer)add3_family_owned = 0 and property_owned_total = 0 and property_sold_total = 0 and property_ambig_total = 0;

		glrc9d := attr_addrs_last12 > 1;

		glrc9e := if((integer)addrpop>0,  1, 0) ;

		glrc9g := (integer)dobpop>0 and _age <= 35;

		glrc9h := impulse_count > 0;

		glrc9i := 0;

		glrc9j := mth_header_first_seen < 60;

		glrc9o := (integer)addrpop>0 and (integer)add1_eda_sourced = 0;

		glrc9q := Inq_count12 > 0;

		glrcev := attr_eviction_count > 0;

		glrcmi := (integer)ssnlength>0 and adlperssn_count >= 3;

		glrcms := ssns_per_adl >= 3;

		// aptflag_1 := 0;

		// aptflag := if(trim(trim(rc_dwelltype, LEFT), LEFT, RIGHT) = 'A', 1, aptflag_1);
		aptflag := if(rc_dwelltype = 'A', 1, 0);

		add1_econval := map(
			aptflag = 0 and add1_avm_automated_valuation > 0 => add1_avm_automated_valuation,
			aptflag = 0 and add1_assessed_total_value > 0    => add1_assessed_total_value,
			aptflag = 0 and add1_avm_med_geo12 > 0           => add1_avm_med_geo12,
			aptflag = 0 and add1_avm_med_geo11 > 0           => add1_avm_med_geo11,
			aptflag = 0 and add1_avm_med_fips > 0            => add1_avm_med_fips,
																NULL);

		add1_aptval := map(
			aptflag = 1 and add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
			aptflag = 1 and add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
			aptflag = 1 and add1_avm_med_fips > 0  => add1_avm_med_fips,
													  NULL);

		add1_econcode := map(
			aptflag = 0 and add1_econval > 650000 => 'A',
			aptflag = 0 and add1_econval > 450000 => 'B',
			aptflag = 0 and add1_econval > 250000 => 'C',
			aptflag = 0 and add1_econval > 125000 => 'D',
			aptflag = 0 and add1_econval > 75000  => 'E',
			aptflag = 0 and add1_econval > 0      => 'F',
			aptflag = 1 and add1_aptval > 1000000 => 'C',
			aptflag = 1 and add1_aptval > 500000  => 'D',
			aptflag = 1 and add1_aptval > 175000  => 'E',
			aptflag = 1 and add1_aptval > 0       => 'F',
													 'U');

		glrcpv := if((integer)addrpop>0 and add1_econcode = 'F', 1, 0);

		glrc9r := 1;

		glrc9t := (integer)hphnpop>0 and (
		(integer)_phn_recent_disconnect = 1 or StringLib.StringToUpperCase(nap_status) = 'D' or (rc_hriskphoneflag in ['5', '6']) or (rc_hphonetypeflag in ['5', 'A']) or rc_hphonevalflag = (string)3 or rc_phonezipflag = (string)1 or (boolean)(integer)_phn_notpots
			);

		glrc9u := (integer)addrpop>0 and (
		(boolean)(integer)_add_highriskcom or addrs_prison_history or (boolean)(integer)_add_invalid or (boolean)(integer)_add_zipcitymismatch or (boolean)(integer)_add_advo_vacant or (boolean)(integer)_add_advo_throwback
			);
	
		glrc9v := (integer)ssnlength>0 and (
		(integer)rc_non_us_ssn = 1 or rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1 or rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3', '4'])
			);
		glrc9w := (integer)bankrupt > 0;

		rc1_4 := '';

		rc1v := 0;

		rc2_1 := '';

		rc2v := 0;

		rc3_1 := '';

		rc3v := 0;

		rc4_1 := '';

		rc4v := 0;

		rc5_2 := '';

		rcsegderog := if((string)_rvg40_segment = '1 derog', 1, 0);
		rcsegyoung := if((string)_rvg40_segment = '2 young', 1, 0);
		rcsegowner := if((string)_rvg40_segment = '3 owner', 1, 0);
		rcsegother := if((string)_rvg40_segment = '4 other', 1, 0);

		rcvalue03_1 := rcsegowner * 1.1358459362 * ((integer)sw_ssn_risk - 0.00099094);

		rcvalue03 := (integer)glrc03 * sum(rcvalue03_1);

		rcvalue07_1 := rcsegderog * 0.1868975867 * ((integer)_phn_recent_disconnect - 0.0768930803);

		rcvalue07 := (integer)glrc07 * sum(rcvalue07_1);

		rcvalue20_1 := rcsegderog * 2.1038814027 * (sd_nap_i_m - 0.3614763126);

		rcvalue20_2 := rcsegderog * 0.9822766325 * (sd_infutor_nap_m - 0.3614057442);

		rcvalue20_3 := rcsegother * 2.917510168 * (so_nap_i_om - 0.2675254676);

		rcvalue20_4 := rcsegother * 2.0407450417 * (so_infutor_nap_om - 0.2675426514);

		rcvalue20_5 := rcsegowner * 2.6756714202 * (sw_nap_i_wm - 0.1702729102);

		rcvalue20_6 := rcsegowner * 0.1251488103 * ((integer)sy_infutor_nap16 - 0.176585504);

		rcvalue20_7 := rcsegyoung * 1.5699542938 * (sy_nap_i_ym - 0.3497800203);

		rcvalue20_8 := rcsegyoung * 0.1095807346 * ((integer)sy_infutor_nap16 - 0.2463932884);

		rcvalue20 := (integer)glrc20 * sum(rcvalue20_1, rcvalue20_2, rcvalue20_3, rcvalue20_4, rcvalue20_5, rcvalue20_6, rcvalue20_7, rcvalue20_8);

		rcvalue25_1 := rcsegowner * -0.293608256 * ((integer)add1_house_number_match - 0.8936296716);

		rcvalue25 := (integer)glrc25 * sum(rcvalue25_1);

		rcvalue28_1 := rcsegderog * 0.8837085075 * (sd_combo_dobcount_m - 0.3614220536);

		rcvalue28_2 := rcsegother * 2.0471460888 * (so_combo_dobcount_om - 0.2676127491);

		rcvalue28_3 := rcsegowner * 0.1708811157 * ((integer)_dob_diff - 0.1221404304);

		rcvalue28 := (integer)glrc28 * sum(rcvalue28_1, rcvalue28_2, rcvalue28_3);

		rcvalue97_1 := (integer)(criminal_count > 0 or felony_count > 0) * rcsegderog * (-0.574514425 - -0.873804572);

		rcvalue97_2 := rcsegderog * 3.2691967551 * (_criminal_x5_m - 0.361586938);

		rcvalue97 := (integer)glrc97 * sum(rcvalue97_1, rcvalue97_2);

		rcvalue98_1 := (integer)(attr_num_unrel_liens60 > 0 or liens_historical_unreleased_ct > 0) * rcsegderog * (-0.574514425 - -0.873804572);

		rcvalue98_2 := rcsegderog * 0.9166861858 * (_lien_unrel_mon2_m - 0.3614720088);

		rcvalue98_3 := rcsegderog * 0.9336765768 * (_lien_CJ_unrel_x_m - 0.3614631026);

		rcvalue98_4 := rcsegderog * 0.7144274822 * (_lien_LT_unrel_x_m - 0.3615640461);

		rcvalue98_5 := rcsegderog * 4.0315324689 * (_lien_SC_unrel_x_m - 0.3614804094);

		rcvalue98_6 := rcsegother * 0.1739795062 * ((integer)ver_src_L2 - 0.2228747317);

		rcvalue98_7 := rcsegowner * 0.1171316298 * ((integer)ver_src_L2 - 0.2220554926);

		rcvalue98_8 := rcsegyoung * 0.4743159344 * ((integer)ver_src_L2 - 0.008507135);

		rcvalue98 := (integer)glrc98 * sum(rcvalue98_1, rcvalue98_2, rcvalue98_3, rcvalue98_4, rcvalue98_5, rcvalue98_6, rcvalue98_7, rcvalue98_8);

		rcvalue99_1 := rcsegderog * -0.087662877 * ((integer)add1_isbestmatch - 0.568196045);

		rcvalue99_2 := rcsegother * -0.065646332 * ((integer)add1_isbestmatch - 0.5786318902);

		rcvalue99_3 := rcsegowner * -0.101676312 * ((integer)add1_isbestmatch - 0.7107870895);

		rcvalue99 := (integer)glrc99 * sum(rcvalue99_1, rcvalue99_2, rcvalue99_3);

		rcvalue9a_1 := rcsegderog * 1.468955431 * (sd_ver_p_x_m - 0.3611836182);

		rcvalue9a_2 := rcsegother * 1.7602660335 * (so_ver_p_x_om - 0.267521167);

		rcvalue9a_3 := rcsegowner * 2.418775093 * (sw_ver_p_x_wm - 0.1703070941);

		rcvalue9a := (integer)glrc9a * sum(rcvalue9a_1, rcvalue9a_2, rcvalue9a_3);

		rcvalue9d_1 := rcsegderog * 2.0441653187 * (sd_addrs_per_ssn_c6_m - 0.361481103);

		rcvalue9d_2 := rcsegother * 2.8725355744 * (so_addrs_per_ssn_c6_om - 0.2675350294);

		rcvalue9d_3 := rcsegowner * 3.7378071032 * (sw_addrs_per_ssn_c6_wm - 0.1701670398);

		rcvalue9d_4 := rcsegyoung * 3.1560722515 * (sy_addrs_per_ssn_c6_ym - 0.3494536515);

		rcvalue9d := (integer)glrc9d * sum(rcvalue9d_1, rcvalue9d_2, rcvalue9d_3, rcvalue9d_4);

		rcvalue9e_1 := rcsegderog * 1.6370196337 * (sd_ver_src_nas_CB_i_m - 0.3613508309);

		rcvalue9e_2 := rcsegderog * 0.7253798595 * (sd_attr_num_nonderogs180_m - 0.3614394908);

		rcvalue9e_3 := rcsegderog * 0.601764927 * (sd_combo_fnamecount_m - 0.361437954);

		rcvalue9e_4 := rcsegderog * 1.921625414 * (sd_add2_source_count_m - 0.36147512);

		rcvalue9e_5 := rcsegderog * 0.4288028978 * (sd_ver_ssn_cnt_m - 0.3614092722);

		rcvalue9e_6 := rcsegother * 2.1490813086 * (so_ver_src_nas_CB_i_om - 0.2676366028);

		rcvalue9e_7 := rcsegother * 1.4782457769 * (sd_combo_fnamecount_om - 0.2676155091);

		rcvalue9e_8 := rcsegother * 1.3725307785 * (sd_add1_source_count_om - 0.2677084683);

		rcvalue9e_9 := rcsegother * 2.2898753197 * (so_add2_source_count_om - 0.2675536936);

		rcvalue9e_10 := rcsegowner * 2.9980960065 * (sw_combo_fnamecount_wm - 0.1702557228);

		rcvalue9e_11 := rcsegyoung * 2.8178003128 * (sy_ver_src_nas_CB_i_ym - 0.3496115624);

		rcvalue9e := glrc9e * sum(rcvalue9e_1, rcvalue9e_2, rcvalue9e_3, rcvalue9e_4, rcvalue9e_5, rcvalue9e_6, rcvalue9e_7, rcvalue9e_8, rcvalue9e_9, rcvalue9e_10, rcvalue9e_11);

		rcvalue9g_1 := rcsegderog * -0.483125747 * (sd_age_log - 3.6415789129);

		rcvalue9g_2 := rcsegother * 2.3017293859 * (so_age_om - 0.2675480298);

		rcvalue9g_3 := rcsegyoung * (-0.622107965 - -0.873804572);

		rcvalue9g_4 := rcsegyoung * -1.367691547 * (sy_age_log - 3.1049105627);

		rcvalue9g := (integer)glrc9g * sum(rcvalue9g_1, rcvalue9g_2, rcvalue9g_3, rcvalue9g_4);

		rcvalue9h_1 := (integer)(impulse_count > 0) * rcsegderog * (-0.574514425 - -0.873804572);

		rcvalue9h_2 := rcsegderog * 3.389903457 * (_impulse_x3_m - 0.3614188585);

		rcvalue9h := (integer)glrc9h * sum(rcvalue9h_1, rcvalue9h_2);

		rcvalue9i_1 := rcsegother * 4.8643682603 * (so_ams_x_om - 0.2675328133);

		rcvalue9i := glrc9i * sum(rcvalue9i_1);

		rcvalue9j_1 := rcsegyoung * 1.7918505941 * (sy_mth_header_fseen_ym - 0.3499824183);

		rcvalue9j := (integer)glrc9j * sum(rcvalue9j_1);

		rcvalue9o_1 := rcsegderog * 2.185622162 * (sd_gong_did_phone_ct_m - 0.3613842061);

		rcvalue9o_2 := rcsegderog * 0.8837940062 * (sd_gong_did_first_ct_m - 0.3614502494);

		rcvalue9o_3 := rcsegother * 3.5718061441 * (so_gong_did_phone_ct_om - 0.267553891);

		rcvalue9o_4 := rcsegother * 1.6295741482 * (sd_gong_did_first_ct_om - 0.2675474402);

		rcvalue9o_5 := rcsegowner * 4.5980573314 * (sw_gong_did_fl_ct_wm - 0.1702093107);

		rcvalue9o_6 := rcsegyoung * 3.6834360214 * (sy_gong_did_last_ct_ym - 0.3496875698);

		rcvalue9o := (integer)glrc9o * sum(rcvalue9o_1, rcvalue9o_2, rcvalue9o_3, rcvalue9o_4, rcvalue9o_5, rcvalue9o_6);

		rcvalue9q_1 := rcsegderog * 2.2080538011 * (sd_Inq_count12_2_m - 0.3613289082);

		rcvalue9q_2 := rcsegderog * 1.5983486434 * (sd_Inq_Communications_count12_m - 0.3614352322);

		rcvalue9q_3 := rcsegderog * 2.2603586714 * (sd_Inq_ADLsPerAddr_m - 0.3613987176);

		rcvalue9q_4 := rcsegother * 3.6475358813 * (so_Inq_x2_om - 0.2674610237);

		rcvalue9q_5 := rcsegother * 2.8221510122 * (so_Inq_SSNsPerAddr_om - 0.2673680406);

		rcvalue9q_6 := rcsegother * 1.5104968432 * (so_Inq_ADLsPerPhone_om - 0.2673687864);

		rcvalue9q_7 := rcsegowner * 3.923276563 * (sw_inq_ct_x_wm - 0.1701987593);

		rcvalue9q_8 := rcsegowner * 2.3821619577 * (sw_Inq_PerAddr_wm - 0.1702118864);

		rcvalue9q_9 := rcsegowner * 2.2529132392 * (sw_Inq_PerPhone_wm - 0.1701886128);

		rcvalue9q_10 := rcsegyoung * 3.399450931 * (sy_Inq_count12_ym - 0.3500618143);

		rcvalue9q_11 := rcsegyoung * 0.1479391785 * (sy_Inq_PerAddr - 0.310451623);

		rcvalue9q := (integer)glrc9q * sum(rcvalue9q_1, rcvalue9q_2, rcvalue9q_3, rcvalue9q_4, rcvalue9q_5, rcvalue9q_6, rcvalue9q_7, rcvalue9q_8, rcvalue9q_9, rcvalue9q_10, rcvalue9q_11);

		rcvalue9r_1 := rcsegderog * 0.959339834 * (sd_ver_src_fdate_TS_m - 0.3613595172);

		rcvalue9r_2 := rcsegother * 2.4347813624 * (so_mth_on_CB_i_om - 0.2675070627);

		rcvalue9r_3 := rcsegother * 1.6406351835 * (sw_ver_src_fdate_TS_om - 0.2675881159);

		rcvalue9r_4 := rcsegowner * 4.6989787614 * (sw_ver_src_fdate_CB_wm - 0.170166985);

		rcvalue9r_5 := rcsegowner * 4.0789351083 * (sw_ver_src_fdate_TS_wm - 0.1702264277);

		rcvalue9r := glrc9r * sum(rcvalue9r_1, rcvalue9r_2, rcvalue9r_3, rcvalue9r_4, rcvalue9r_5);

		rcvalue9t_1 := rcsegother * 0.1544515908 * ((integer)so_phn_risk - 0.1217042647);

		rcvalue9t_2 := rcsegowner * 3.4659657073 * (sw_phn_x_wm - 0.1703357382);

		rcvalue9t_3 := rcsegyoung * 0.1720522292 * ((integer)sd_phn_risk - 0.1345068214);

		rcvalue9t := (integer)glrc9t * sum(rcvalue9t_1, rcvalue9t_2, rcvalue9t_3);

		rcvalue9u_1 := rcsegowner * 0.1521178222 * ((integer)_add_risk - 0.0891562854);

		rcvalue9u_2 := rcsegyoung * 0.1761469993 * ((integer)sy_add_risk - 0.1247843814);

		rcvalue9u := (integer)glrc9u * sum(rcvalue9u_1, rcvalue9u_2);

		rcvalue9v_1 := rcsegderog * 0.3567252031 * ((integer)_ssn_risk - 0.0095641733);

		rcvalue9v_2 := rcsegother * 0.2504643862 * ((integer)_ssn_risk - 0.0088156278);

		rcvalue9v := (integer)glrc9v * sum(rcvalue9v_1, rcvalue9v_2);          

		rcvalue9w_0 := if(stringlib.stringfind(StringLib.StringToUpperCase(disposition), 'DISMISS', 1) > 0, 1, 0) * (RCSegderog ) * ( 1 *(-0.574514425  - (-0.873804572 )) );
		rcvalue9w_1 := rcsegderog * 0.3987974479 * ((integer)_derog_bk_bad - 0.0168296613);

		// rcvalue9w := (integer)glrc9w * sum(rcvalue9w_1);  // this is what it was
		rcvalue9w := (integer)glrc9w * max(RCValue9W_0, rcvalue9w_1);

		rcvalueev_1 := (integer)(attr_eviction_count > 0) * rcsegderog * (-0.574514425 - -0.873804572);

		rcvalueev_2 := rcsegderog * 2.4401794982 * (_eviction_x_m - 0.361550628);

		rcvalueev := (integer)glrcev * sum(rcvalueev_1, rcvalueev_2);

		rcvaluemi_1 := rcsegderog * 2.9892843753 * (sd_adlperssn_count_m - 0.3614661799);

		rcvaluemi_2 := rcsegother * 3.0776147376 * (so_adlperssn_ct_om - 0.2674588816);

		rcvaluemi_3 := rcsegowner * 4.0537153998 * (sw_adlperssn_count_wm - 0.1703095247);

		rcvaluemi_4 := rcsegyoung * 3.0159856654 * (sy_adlperssn_count_ym - 0.3497592474);

		rcvaluemi := (integer)glrcmi * sum(rcvaluemi_1, rcvaluemi_2, rcvaluemi_3, rcvaluemi_4);

		rcvaluems_1 := rcsegderog * 3.184524308 * (sd_ssns_per_adl_m - 0.3615358448);

		rcvaluems_2 := rcsegderog * 3.6769731045 * (sd_ssns_per_adl_c6_m - 0.3614850943);

		rcvaluems_3 := rcsegother * 3.1130517927 * (so_ssns_per_adl_om - 0.2675199367);

		rcvaluems_4 := rcsegowner * 4.3572086192 * (sw_ssns_per_adl_wm - 0.1701154783);

		rcvaluems_5 := rcsegowner * 3.8063887596 * (sw_ssns_per_adl_c6_wm - 0.1702263114);

		rcvaluems_6 := rcsegyoung * 2.9814627177 * (sy_ssns_per_adl_ym - 0.3497600366);

		rcvaluems := (integer)glrcms * sum(rcvaluems_1, rcvaluems_2, rcvaluems_3, rcvaluems_4, rcvaluems_5, rcvaluems_6);

		rcvaluepv_1 := rcsegderog * -0.091778074 * (sd_add1_avm_log - 11.755171726);

		rcvaluepv_2 := rcsegderog * 2.1538694848 * (sd_EconTrj_m - 0.3615076133);

		rcvaluepv_3 := rcsegother * -0.312839031 * (so_add1_avm_log - 11.870211983);

		rcvaluepv_4 := rcsegowner * -0.231343837 * (sw_add1_avm_log - 11.754883875);

		rcvaluepv_5 := rcsegyoung * 3.5614850218 * (sy_add1_avm_new_ym - 0.3499021523);

		rcvaluepv := glrcpv * sum(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3, rcvaluepv_4, rcvaluepv_5);

		ds_layout := {STRING rc, REAL value};
		rc_dataset := DATASET([
			{'03', rcvalue03},
			{'07', rcvalue07},
			{'20', rcvalue20},
			{'25', rcvalue25},
			{'28', rcvalue28},
			{'97', rcvalue97},
			{'98', rcvalue98},
			{'99', rcvalue99},
			{'9A', rcvalue9a},
			{'9D', rcvalue9d},
			{'9E', rcvalue9e},
			{'9G', rcvalue9g},
			{'9H', rcvalue9h},
			{'9I', rcvalue9i},
			{'9J', rcvalue9j},
			{'9O', rcvalue9o},
			{'9Q', rcvalue9q},
			{'9R', rcvalue9r},
			{'9T', rcvalue9t},
			{'9U', rcvalue9u},
			{'9V', rcvalue9v},
			{'9W', rcvalue9w},
			{'EV', rcvalueev},
			{'MI', rcvaluemi},
			{'MS', rcvaluems},
			{'PV', rcvaluepv}
			], ds_layout)( value > 0 );

		rcs_top4 := choosen( sort(rc_dataset,-value), 4 );

		rcs_9q := rcs_top4 &
			if( glrc9q
				and 0 = count(rcs_top4(rc='9Q'))
				and 
				(
					_rvg40_segment = '1 derog' and ( sd_Inq_count12_2 > 0 or sd_Inq_Communications_count12 > 0)
					or _rvg40_segment = '2 young' and sy_Inq_count12 > 0
					or _rvg40_segment = '3 owner' and sw_inq_ct_x > 0
					or _rvg40_segment = '4 other' and so_Inq_x2 > 0
				),
				dataset( [{'9Q',NULL}], ds_layout )
			)
		;
		
		rcs_override := map(
			rvg1103 = 200 => dataset( [{'02', NULL}], ds_layout ),
			rvg1103 = 222 => dataset( [{'9X', NULL}], ds_layout ),
			
			GLRC9G and _rvg40_segment = '2 young' and 0 = count(rcs_9q) => dataset( [{'9G', NULL}], ds_layout ),
			GLRC9A and _rvg40_segment = '4 other' and 0 = count(rcs_9q) => dataset( [{'9A', NULL}], ds_layout ),
			0 = count(rcs_9q) => dataset( [{'36', NULL}], ds_layout ),
			rcs_9q
		);



		#if(RVG_DEBUG)
			self.truedid := truedid;
			self.in_dob := in_dob;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_status := nap_status;
			self.did2_criminal_count := did2_criminal_count;
			self.did2_liens_hist_unrel_count := did2_liens_hist_unrel_count;
			self.rc_non_us_ssn := rc_non_us_ssn;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_ssnvalflag := rc_ssnvalflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_areacodesplitflag := rc_areacodesplitflag;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_bansflag := rc_bansflag;
			self.rc_ssncount := rc_ssncount;
			self.rc_ssnmiskeyflag := rc_ssnmiskeyflag;
			self.rc_addrmiskeyflag := rc_addrmiskeyflag;
			self.rc_addrcommflag := rc_addrcommflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_phonetype := rc_phonetype;
			self.rc_cityzipflag := rc_cityzipflag;
			self.combo_dobscore := combo_dobscore;
			self.combo_fnamecount := combo_fnamecount;
			self.combo_dobcount := combo_dobcount;
			self.ver_sources := ver_sources;
			self.ver_sources_nas := ver_sources_nas;
			self.ver_sources_first_seen := ver_sources_first_seen;
			self.ver_ssn_sources := ver_ssn_sources;
			self.ssnlength := ssnlength;
			self.age := age;
			self.add1_house_number_match := add1_house_number_match;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_advo_address_vacancy := add1_advo_address_vacancy;
			self.add1_advo_throw_back := add1_advo_throw_back;
			self.add1_advo_res_or_business := add1_advo_res_or_business;
			self.add1_avm_land_use := add1_avm_land_use;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_source_count := add1_source_count;
			self.add1_naprop := add1_naprop;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.add2_avm_land_use := add2_avm_land_use;
			self.add2_avm_automated_valuation := add2_avm_automated_valuation;
			self.add2_avm_med_fips := add2_avm_med_fips;
			self.add2_avm_med_geo11 := add2_avm_med_geo11;
			self.add2_avm_med_geo12 := add2_avm_med_geo12;
			self.add2_source_count := add2_source_count;
			self.add2_naprop := add2_naprop;
			self.add3_naprop := add3_naprop;
			self.addrs_prison_history := addrs_prison_history;
			self.addr_hist_advo_college := addr_hist_advo_college;
			self.telcordia_type := telcordia_type;
			self.recent_disconnects := recent_disconnects;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.gong_did_first_ct := gong_did_first_ct;
			self.gong_did_last_ct := gong_did_last_ct;
			self.header_first_seen := header_first_seen;
			self.ssns_per_adl := ssns_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.phones_per_adl_c6 := phones_per_adl_c6;
			self.lnames_per_adl_c6 := lnames_per_adl_c6;
			self.adls_per_ssn_c6 := adls_per_ssn_c6;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.phones_per_addr_c6 := phones_per_addr_c6;
			self.adls_per_phone_c6 := adls_per_phone_c6;
			self.inq_last_log_date := inq_last_log_date;
			self.inq_count01 := inq_count01;
			self.inq_count03 := inq_count03;
			self.inq_count06 := inq_count06;
			self.inq_count12 := inq_count12;
			self.inq_communications_count12 := inq_communications_count12;
			self.inq_peraddr := inq_peraddr;
			self.inq_adlsperaddr := inq_adlsperaddr;
			self.inq_ssnsperaddr := inq_ssnsperaddr;
			self.inq_perphone := inq_perphone;
			self.inq_adlsperphone := inq_adlsperphone;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.impulse_last_seen := impulse_last_seen;
			self.impulse_count30 := impulse_count30;
			self.email_source_list := email_source_list;
			self.attr_felonies36 := attr_felonies36;
			self.attr_num_unrel_liens30 := attr_num_unrel_liens30;
			self.attr_num_unrel_liens180 := attr_num_unrel_liens180;
			self.attr_num_unrel_liens12 := attr_num_unrel_liens12;
			self.attr_num_unrel_liens60 := attr_num_unrel_liens60;
			self.attr_bankruptcy_count36 := attr_bankruptcy_count36;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_date_last_eviction := attr_date_last_eviction;
			self.attr_eviction_count30 := attr_eviction_count30;
			self.attr_num_nonderogs180 := attr_num_nonderogs180;
			self.bankrupt := bankrupt;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.bk_disposed_recent_count := bk_disposed_recent_count;
			self.bk_disposed_historical_count := bk_disposed_historical_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_unrel_lt_last_seen := liens_unrel_lt_last_seen;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.liens_unrel_sc_last_seen := liens_unrel_sc_last_seen;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.felony_count := felony_count;
			self.felony_last_date := felony_last_date;
			self.watercraft_count := watercraft_count;
			self.ams_age := ams_age;
			self.ams_college_code := ams_college_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.reported_dob := reported_dob;
			self.archive_date := archive_date;
			self.sysdate                          := sysdate;
			self.ver_src_ba_pos                   := ver_src_ba_pos;
			self.ver_src_ba                       := ver_src_ba;
			self.ver_src_ds_pos                   := ver_src_ds_pos;
			self.ver_src_ds                       := ver_src_ds;
			self.ver_src_en_pos                   := ver_src_en_pos;
			self.ver_src_nas_en                   := ver_src_nas_en;
			self.ver_src_fdate_en                 := ver_src_fdate_en;
			self.ver_src_fdate_en2                := ver_src_fdate_en2;
			self.mth_ver_src_fdate_en             := mth_ver_src_fdate_en;
			self.ver_src_eq_pos                   := ver_src_eq_pos;
			self.ver_src_nas_eq                   := ver_src_nas_eq;
			self.ver_src_fdate_eq                 := ver_src_fdate_eq;
			self.ver_src_fdate_eq2                := ver_src_fdate_eq2;
			self.mth_ver_src_fdate_eq             := mth_ver_src_fdate_eq;
			self.ver_src_l2_pos                   := ver_src_l2_pos;
			self.ver_src_l2                       := ver_src_l2;
			self.ver_src_li_pos                   := ver_src_li_pos;
			self.ver_src_li                       := ver_src_li;
			self.ver_src_p_pos                    := ver_src_p_pos;
			self.ver_src_p                        := ver_src_p;
			self.ver_src_nas_p                    := ver_src_nas_p;
			self.ver_src_ts_pos                   := ver_src_ts_pos;
			self.ver_src_fdate_ts                 := ver_src_fdate_ts;
			self.ver_src_fdate_ts2                := ver_src_fdate_ts2;
			self.mth_ver_src_fdate_ts             := mth_ver_src_fdate_ts;
			self.ver_ssn_src_l2_pos               := ver_ssn_src_l2_pos;
			self.ver_ssn_src_l2                   := ver_ssn_src_l2;
			self.ver_ssn_src_mw_pos               := ver_ssn_src_mw_pos;
			self.ver_ssn_src_mw                   := ver_ssn_src_mw;
			self.email_src_im_pos                 := email_src_im_pos;
			self.email_src_im                     := email_src_im;
			self._felony_f                        := _felony_f;
			self._crime_f                         := _crime_f;
			self._attr_unrel_lien_f               := _attr_unrel_lien_f;
			self._lien_hist_unrel_f               := _lien_hist_unrel_f;
			self._attr_eviction_f                 := _attr_eviction_f;
			self._impluse_f                       := _impluse_f;
			self._ssn_deceased_f                  := _ssn_deceased_f;
			self._derog_new_f                     := _derog_new_f;
			self.in_dob2                          := in_dob2;
			self.yr_in_dob                        := yr_in_dob;
			self._age                             := _age;
			self._prop_owner                      := _prop_owner;
			self._rvg40_segment                   := _rvg40_segment;
			self._add_highriskcom                 := _add_highriskcom;
			self._add_invalid                     := _add_invalid;
			self._add_miskey                      := _add_miskey;
			self._add_zipcitymismatch             := _add_zipcitymismatch;
			self._add_advo_vacant                 := _add_advo_vacant;
			self._add_advo_throwback              := _add_advo_throwback;
			self._add_risk                        := _add_risk;
			self.sy_add_risk                      := sy_add_risk;
			self.add1_avm_med                     := add1_avm_med;
			self._add1_avm                        := _add1_avm;
			self.sd_add1_avm_log                  := sd_add1_avm_log;
			self.sy_add1_avm_new                  := sy_add1_avm_new;
			self.sy_add1_avm_new_ym               := sy_add1_avm_new_ym;
			self.sw_add1_avm_log                  := sw_add1_avm_log;
			self.so_add1_avm_log                  := so_add1_avm_log;
			self.add2_avm_med                     := add2_avm_med;
			self._add2_avm                        := _add2_avm;
			self._add1_avm_class                  := _add1_avm_class;
			self._add2_avm_class                  := _add2_avm_class;
			self._econtrajectory                  := _econtrajectory;
			self.sd_econtrj                       := sd_econtrj;
			self.sd_econtrj_m                     := sd_econtrj_m;
			self._phn_notpots                     := _phn_notpots;
			self._phn_recent_disconnect           := _phn_recent_disconnect;
			self._phn_areacodesplit               := _phn_areacodesplit;
			self.sd_phn_risk                      := sd_phn_risk;
			self.sw_phn_risk                      := sw_phn_risk;
			self.sw_phn_x                         := sw_phn_x;
			self.sw_phn_x_wm                      := sw_phn_x_wm;
			self.so_phn_risk                      := so_phn_risk;
			self._ssn_risk                        := _ssn_risk;
			self.sw_ssn_risk                      := sw_ssn_risk;
			self.sd_age_log                       := sd_age_log;
			self.sy_age_log                       := sy_age_log;
			self.reported_dob2                    := reported_dob2;
			self.yr_reported_dob                  := yr_reported_dob;
			self._dob_adlage_diff                 := _dob_adlage_diff;
			self._dob_amsage_diff                 := _dob_amsage_diff;
			self._dob_reportedage_diff            := _dob_reportedage_diff;
			self._dob_adlage_diffge2              := _dob_adlage_diffge2;
			self._dob_amsage_diffge2              := _dob_amsage_diffge2;
			self._dob_reportedage_diffge2         := _dob_reportedage_diffge2;
			self._dob_diffge2                     := _dob_diffge2;
			self._dob_diff                        := _dob_diff;
			self.so_age                           := so_age;
			self.so_age_om                        := so_age_om;
			self._derog_bk_gt1_in36m              := _derog_bk_gt1_in36m;
			self._derog_bk_filing_gt3             := _derog_bk_filing_gt3;
			self._derog_bk_disposed_gt1_in24m     := _derog_bk_disposed_gt1_in24m;
			self._derog_bk_disposed_gt3           := _derog_bk_disposed_gt3;
			self._derog_bk_bad                    := _derog_bk_bad;
			self._lien_unrel_mon                  := _lien_unrel_mon;
			self._lien_unrel_mon2                 := _lien_unrel_mon2;
			self._lien_unrel_mon2_m               := _lien_unrel_mon2_m;
			self._lien_cj_unrel_ct                := _lien_cj_unrel_ct;
			self.liens_unrel_cj_last_seen2        := liens_unrel_cj_last_seen2;
			self.mth_liens_unrel_cj_last_seen     := mth_liens_unrel_cj_last_seen;
			self._lien_cj_unrel_lseen             := _lien_cj_unrel_lseen;
			self._lien_cj_unrel_x                 := _lien_cj_unrel_x;
			self._lien_cj_unrel_x_m               := _lien_cj_unrel_x_m;
			self._lien_lt_unrel_ct                := _lien_lt_unrel_ct;
			self.liens_unrel_lt_last_seen2        := liens_unrel_lt_last_seen2;
			self.mth_liens_unrel_lt_last_seen     := mth_liens_unrel_lt_last_seen;
			self._lien_lt_unrel_lseen             := _lien_lt_unrel_lseen;
			self._lien_lt_unrel_x                 := _lien_lt_unrel_x;
			self._lien_lt_unrel_x_m               := _lien_lt_unrel_x_m;
			self._lien_sc_unrel_ct                := _lien_sc_unrel_ct;
			self.liens_unrel_sc_last_seen2        := liens_unrel_sc_last_seen2;
			self.mth_liens_unrel_sc_last_seen     := mth_liens_unrel_sc_last_seen;
			self._lien_sc_unrel_lseen             := _lien_sc_unrel_lseen;
			self._lien_sc_unrel_x                 := _lien_sc_unrel_x;
			self._lien_sc_unrel_x_m               := _lien_sc_unrel_x_m;
			self._eviction_ct                     := _eviction_ct;
			self.attr_date_last_eviction2         := attr_date_last_eviction2;
			self.mth_attr_date_last_eviction      := mth_attr_date_last_eviction;
			self._eviction_lseen                  := _eviction_lseen;
			self._eviction_x                      := _eviction_x;
			self._eviction_x_m                    := _eviction_x_m;
			self._criminal_ct                     := _criminal_ct;
			self._felony_ct                       := _felony_ct;
			self._criminal_x                      := _criminal_x;
			self.criminal_last_date2              := criminal_last_date2;
			self.mth_criminal_last_date           := mth_criminal_last_date;
			self.felony_last_date2                := felony_last_date2;
			self.mth_felony_last_date             := mth_felony_last_date;
			self._criminal_lseen                  := _criminal_lseen;
			self._felony_lseen                    := _felony_lseen;
			self._criminal_x2                     := _criminal_x2;
			self._criminal_x3                     := _criminal_x3;
			self._criminal_x4                     := _criminal_x4;
			self._criminal_x5                     := _criminal_x5;
			self._criminal_x5_m                   := _criminal_x5_m;
			self._impulse_ct                      := _impulse_ct;
			self.impulse_last_seen2               := impulse_last_seen2;
			self.mth_impulse_last_seen            := mth_impulse_last_seen;
			self._impulse_lseen                   := _impulse_lseen;
			self._impulse_x                       := _impulse_x;
			self._impulse_x2                      := _impulse_x2;
			self._impulse_x3                      := _impulse_x3;
			self._impulse_x3_m                    := _impulse_x3_m;
			self.sd_combo_dobcount                := sd_combo_dobcount;
			self.sd_combo_dobcount_m              := sd_combo_dobcount_m;
			self.sy_combo_dobcount                := sy_combo_dobcount;
			self.sy_combo_dobcount_ym             := sy_combo_dobcount_ym;
			self.so_combo_dobcount                := so_combo_dobcount;
			self.so_combo_dobcount_om             := so_combo_dobcount_om;
			self.sd_nap_i                         := sd_nap_i;
			self.sd_nap_i_m                       := sd_nap_i_m;
			self.sy_nap_i                         := sy_nap_i;
			self.sy_nap_i_ym                      := sy_nap_i_ym;
			self.sw_nap_i                         := sw_nap_i;
			self.sw_nap_i_wm                      := sw_nap_i_wm;
			self.so_nap_i                         := so_nap_i;
			self.so_nap_i_om                      := so_nap_i_om;
			self.header_first_seen2               := header_first_seen2;
			self.mth_header_first_seen            := mth_header_first_seen;
			self.sy_mth_header_fseen              := sy_mth_header_fseen;
			self.sy_mth_header_fseen_ym           := sy_mth_header_fseen_ym;
			self.ver_src_nas_cb                   := ver_src_nas_cb;
			self.sd_ver_src_nas_cb_i              := sd_ver_src_nas_cb_i;
			self.sd_ver_src_nas_cb_i_m            := sd_ver_src_nas_cb_i_m;
			self.sy_ver_src_nas_cb_i              := sy_ver_src_nas_cb_i;
			self.sy_ver_src_nas_cb_i_ym           := sy_ver_src_nas_cb_i_ym;
			self.so_ver_src_nas_cb_i              := so_ver_src_nas_cb_i;
			self.so_ver_src_nas_cb_i_om           := so_ver_src_nas_cb_i_om;
			self.mth_ver_src_fdate_cb             := mth_ver_src_fdate_cb;
			self.sw_ver_src_fdate_cb              := sw_ver_src_fdate_cb;
			self.sw_ver_src_fdate_cb_wm           := sw_ver_src_fdate_cb_wm;
			self._age_fseen_cb                    := _age_fseen_cb;
			self.so_mth_on_cb                     := so_mth_on_cb;
			self.so_mth_on_cb_i                   := so_mth_on_cb_i;
			self.so_mth_on_cb_i_om                := so_mth_on_cb_i_om;
			self.sd_ver_src_nas_p                 := sd_ver_src_nas_p;
			self.sd_ver_p_x                       := sd_ver_p_x;
			self.sd_ver_p_x_m                     := sd_ver_p_x_m;
			self.sy_ver_p_x                       := sy_ver_p_x;
			self.sy_ver_p_x_ym                    := sy_ver_p_x_ym;
			self.sw_ver_p_x                       := sw_ver_p_x;
			self.sw_ver_p_x_wm                    := sw_ver_p_x_wm;
			self.so_ver_src_nas_p                 := so_ver_src_nas_p;
			self.so_ver_p_x                       := so_ver_p_x;
			self.so_ver_p_x_om                    := so_ver_p_x_om;
			self.sd_ver_src_fdate_ts              := sd_ver_src_fdate_ts;
			self.sd_ver_src_fdate_ts_m            := sd_ver_src_fdate_ts_m;
			self.sw_ver_src_fdate_ts              := sw_ver_src_fdate_ts;
			self.sw_ver_src_fdate_ts_wm           := sw_ver_src_fdate_ts_wm;
			self.sw_ver_src_fdate_ts_om           := sw_ver_src_fdate_ts_om;
			self.sd_gong_did_phone_ct             := sd_gong_did_phone_ct;
			self.sd_gong_did_phone_ct_m           := sd_gong_did_phone_ct_m;
			self.so_gong_did_phone_ct             := so_gong_did_phone_ct;
			self.so_gong_did_phone_ct_om          := so_gong_did_phone_ct_om;
			self.sd_gong_did_first_ct             := sd_gong_did_first_ct;
			self.sd_gong_did_first_ct_m           := sd_gong_did_first_ct_m;
			self.sy_gong_did_last_ct              := sy_gong_did_last_ct;
			self.sy_gong_did_last_ct_ym           := sy_gong_did_last_ct_ym;
			self.sw_gong_did_first_ct             := sw_gong_did_first_ct;
			self.sw_gong_did_last_ct              := sw_gong_did_last_ct;
			self.sw_gong_did_fl_ct                := sw_gong_did_fl_ct;
			self.sw_gong_did_fl_ct_wm             := sw_gong_did_fl_ct_wm;
			self.sd_gong_did_first_ct_om          := sd_gong_did_first_ct_om;
			self.sd_combo_fnamecount              := sd_combo_fnamecount;
			self.sd_combo_fnamecount_m            := sd_combo_fnamecount_m;
			self.sw_combo_fnamecount              := sw_combo_fnamecount;
			self.sw_combo_fnamecount_wm           := sw_combo_fnamecount_wm;
			self.sd_combo_fnamecount_om           := sd_combo_fnamecount_om;
			self._add2_naprop34                   := _add2_naprop34;
			self._add3_naprop34                   := _add3_naprop34;
			self._add23_naprop34                  := _add23_naprop34;
			self.sd_add2_source_count             := sd_add2_source_count;
			self.sd_add2_source_count_m           := sd_add2_source_count_m;
			self.sd_add1_source_count             := sd_add1_source_count;
			self.sd_add1_source_count_om          := sd_add1_source_count_om;
			self.so_add2_source_count             := so_add2_source_count;
			self.so_add2_source_count_om          := so_add2_source_count_om;
			self.sd_ver_ssn_cnt                   := sd_ver_ssn_cnt;
			self.sd_ver_ssn_cnt_m                 := sd_ver_ssn_cnt_m;
			self.sd_ams_good                      := sd_ams_good;
			self.sd_pl_ams_good                   := sd_pl_ams_good;
			self.sy_ams_tier                      := sy_ams_tier;
			self.sy_amspl_tier                    := sy_amspl_tier;
			self.sy_amspl_tier_ym                 := sy_amspl_tier_ym;
			self.sw_ams_good                      := sw_ams_good;
			self.sw_pl_ams                        := sw_pl_ams;
			self.so_ams_x                         := so_ams_x;
			self.so_ams_x_om                      := so_ams_x_om;
			self.sd_pl_good                       := sd_pl_good;
			self.sd_infutor_nap                   := sd_infutor_nap;
			self.sd_infutor_nap_m                 := sd_infutor_nap_m;
			self.sy_infutor_nap16                 := sy_infutor_nap16;
			self.so_infutor_nap                   := so_infutor_nap;
			self.so_infutor_nap_om                := so_infutor_nap_om;
			self.sd_attr_num_nonderogs180         := sd_attr_num_nonderogs180;
			self.sd_attr_num_nonderogs180_m       := sd_attr_num_nonderogs180_m;
			self.so_property_sold                 := so_property_sold;
			self.so_prop_x                        := so_prop_x;
			self.so_prop_x_om                     := so_prop_x_om;
			self.sd_ssns_per_adl                  := sd_ssns_per_adl;
			self.sd_ssns_per_adl_m                := sd_ssns_per_adl_m;
			self.sd_adlperssn_count               := sd_adlperssn_count;
			self.sd_adlperssn_count_m             := sd_adlperssn_count_m;
			self.sd_ssns_per_addr                 := sd_ssns_per_addr;
			self.sd_ssns_per_addr_m               := sd_ssns_per_addr_m;
			self.sd_ssns_per_adl_c6               := sd_ssns_per_adl_c6;
			self.sd_ssns_per_adl_c6_m             := sd_ssns_per_adl_c6_m;
			self.sd_phones_per_adl_c6             := sd_phones_per_adl_c6;
			self.sd_phones_per_adl_c6_m           := sd_phones_per_adl_c6_m;
			self.sd_addrs_per_ssn_c6              := sd_addrs_per_ssn_c6;
			self.sd_addrs_per_ssn_c6_m            := sd_addrs_per_ssn_c6_m;
			self.sd_adls_per_addr_c6              := sd_adls_per_addr_c6;
			self.sd_adls_per_addr_c6_m            := sd_adls_per_addr_c6_m;
			self.sy_ssns_per_adl                  := sy_ssns_per_adl;
			self.sy_ssns_per_adl_ym               := sy_ssns_per_adl_ym;
			self.sy_adlperssn_count               := sy_adlperssn_count;
			self.sy_adlperssn_count_ym            := sy_adlperssn_count_ym;
			self.sy_addrs_per_ssn_c6              := sy_addrs_per_ssn_c6;
			self.sy_addrs_per_ssn_c6_ym           := sy_addrs_per_ssn_c6_ym;
			self.sy_phones_per_adl_c6             := sy_phones_per_adl_c6;
			self.sy_lnames_per_adl_c6             := sy_lnames_per_adl_c6;
			self.sy_adls_per_ssn_c6               := sy_adls_per_ssn_c6;
			self.sy_adls_per_addr_c6              := sy_adls_per_addr_c6;
			self.sy_phones_per_addr_c6            := sy_phones_per_addr_c6;
			self.sy_adls_per_phone_c6             := sy_adls_per_phone_c6;
			self.sy_velocity_c6                   := sy_velocity_c6;
			self.sw_ssns_per_adl                  := sw_ssns_per_adl;
			self.sw_ssns_per_adl_wm               := sw_ssns_per_adl_wm;
			self.sw_adlperssn_count               := sw_adlperssn_count;
			self.sw_adlperssn_count_wm            := sw_adlperssn_count_wm;
			self.sw_adls_per_addr                 := sw_adls_per_addr;
			self.sw_adls_per_addr_wm              := sw_adls_per_addr_wm;
			self.sw_ssns_per_adl_c6               := sw_ssns_per_adl_c6;
			self.sw_ssns_per_adl_c6_wm            := sw_ssns_per_adl_c6_wm;
			self.sw_phones_per_adl_c6             := sw_phones_per_adl_c6;
			self.sw_phones_per_adl_c6_wm          := sw_phones_per_adl_c6_wm;
			self.sw_addrs_per_ssn_c6              := sw_addrs_per_ssn_c6;
			self.sw_addrs_per_ssn_c6_wm           := sw_addrs_per_ssn_c6_wm;
			self.sw_adls_per_addr_c6              := sw_adls_per_addr_c6;
			self.sw_adls_per_addr_c6_wm           := sw_adls_per_addr_c6_wm;
			self.so_ssns_per_adl                  := so_ssns_per_adl;
			self.so_ssns_per_adl_om               := so_ssns_per_adl_om;
			self.so_adlperssn_ct                  := so_adlperssn_ct;
			self.so_adlperssn_ct_om               := so_adlperssn_ct_om;
			self.so_adls_per_phone                := so_adls_per_phone;
			self.so_adls_per_phone_om             := so_adls_per_phone_om;
			self.so_phones_per_adl_c6             := so_phones_per_adl_c6;
			self.so_phones_per_adl_c6_om          := so_phones_per_adl_c6_om;
			self.so_lnames_per_adl_c6             := so_lnames_per_adl_c6;
			self.so_lnames_per_adl_c6_om          := so_lnames_per_adl_c6_om;
			self.so_addrs_per_ssn_c6              := so_addrs_per_ssn_c6;
			self.so_addrs_per_ssn_c6_om           := so_addrs_per_ssn_c6_om;
			self.so_adls_per_addr_c6              := so_adls_per_addr_c6;
			self.so_adls_per_addr_c6_om           := so_adls_per_addr_c6_om;
			self.sd_inq_count12                   := sd_inq_count12;
			self.inq_last_log_date2               := inq_last_log_date2;
			self.mth_inq_last_log_date            := mth_inq_last_log_date;
			self.sd_inq_count12_2                 := sd_inq_count12_2;
			self.sd_inq_count12_2_m               := sd_inq_count12_2_m;
			self.sd_inq_communications_count12    := sd_inq_communications_count12;
			self.sd_inq_communications_count12_m  := sd_inq_communications_count12_m;
			self.sd_inq_adlsperaddr               := sd_inq_adlsperaddr;
			self.sd_inq_adlsperaddr_m             := sd_inq_adlsperaddr_m;
			self.sy_inq_count12                   := sy_inq_count12;
			self.sy_inq_count12_ym                := sy_inq_count12_ym;
			self.sy_inq_peraddr                   := sy_inq_peraddr;
			self.sw_inq_count12                   := sw_inq_count12;
			self.sw_inq_count03                   := sw_inq_count03;
			self.sw_inq_ct_x                      := sw_inq_ct_x;
			self.sw_inq_ct_x_wm                   := sw_inq_ct_x_wm;
			self.sw_inq_peraddr                   := sw_inq_peraddr;
			self.sw_inq_peraddr_wm                := sw_inq_peraddr_wm;
			self.sw_inq_perphone                  := sw_inq_perphone;
			self.sw_inq_perphone_wm               := sw_inq_perphone_wm;
			self.so_inq_count12                   := so_inq_count12;
			self.so_inq_count06                   := so_inq_count06;
			self.so_inq_count01                   := so_inq_count01;
			self.so_inq_x                         := so_inq_x;
			self.so_inq_x2                        := so_inq_x2;
			self.so_inq_x2_om                     := so_inq_x2_om;
			self.so_inq_ssnsperaddr               := so_inq_ssnsperaddr;
			self.so_inq_ssnsperaddr_om            := so_inq_ssnsperaddr_om;
			self.so_inq_adlsperphone              := so_inq_adlsperphone;
			self.so_inq_adlsperphone_om           := so_inq_adlsperphone_om;
			self.sd17                             := sd17;
			self.sy10                             := sy10;
			self.sw07                             := sw07;
			self.logit                            := logit;
			self.so10                             := so10;
			self.phat                             := phat;
			self.base                             := base;
			self.odds                             := odds;
			self.point                            := point;
			self.rvg1103_raw                      := rvg1103_raw;
			self.ov_ssndead                       := ov_ssndead;
			self.ov_ssnprior                      := ov_ssnprior;
			self.ov_criminal_flag                 := ov_criminal_flag;
			self.ov_corrections                   := ov_corrections;
			self.ov_impulse                       := ov_impulse;
			self.lien_flag                        := lien_flag;
			self.bk_flag                          := bk_flag;
			self.ssn_deceased                     := ssn_deceased;
			self.scored_222s                      := scored_222s;
			self.rvg1103_cap                      := rvg1103_cap;
			self.rvg1103_cap2                     := rvg1103_cap2;
			self.rvg1103_cap3                     := rvg1103_cap3;
			self.rvg1103                          := rvg1103;


			self.rc_dwelltype                  := rc_dwelltype;
			// self.add1_advo_mixed_address_usage := add1_advo_mixed_address_usage;
			// self.rc_phonevalflag               := rc_phonevalflag;

			self.addrpop := addrpop;
			self.dobpop := dobpop;
			self.combo_lnamecount := combo_lnamecount;
			self.combo_addrcount := combo_addrcount;
			self.combo_ssncount := combo_ssncount;
			self.combo_hphonecount := combo_hphonecount;
			self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add2_applicant_owned := add2_applicant_owned;
			self.add3_applicant_owned := add3_applicant_owned;
			self.add2_family_owned := add2_family_owned;
			self.add3_family_owned := add3_family_owned;
			self.add1_eda_sourced := add1_eda_sourced;
			self.add1_assessed_total_value := add1_assessed_total_value;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.property_ambig_total := property_ambig_total;
			self.glrc03 := glrc03;
			self.glrc07 := glrc07;
			self.glrc20 := glrc20;
			self.glrc25 := glrc25;
			self.glrc28 := glrc28;
			self.glrc97 := glrc97;
			self.glrc98 := glrc98;
			self.glrc99 := glrc99;
			self.glrc9a := glrc9a;
			self.glrc9d := glrc9d;
			self.glrc9e := glrc9e;
			self.glrc9g := glrc9g;
			self.glrc9h := glrc9h;
			self.glrc9i := glrc9i;
			self.glrc9j := glrc9j;
			self.glrc9o := glrc9o;
			self.glrc9q := glrc9q;
			self.glrcev := glrcev;
			self.glrcmi := glrcmi;
			self.glrcms := glrcms;
			// self.aptflag_1 := aptflag_1;
			self.aptflag := aptflag;
			self.add1_econval := add1_econval;
			self.add1_aptval := add1_aptval;
			self.add1_econcode := add1_econcode;
			self.glrcpv := glrcpv;
			self.glrc9r := glrc9r;
			self.glrc9t := glrc9t;
			self.glrc9u := glrc9u;
			self.glrc9v := glrc9v;
			self.glrc9w := glrc9w;
			self.rc1_4 := rc1_4;
			self.rc1v := rc1v;
			self.rc2_1 := rc2_1;
			self.rc2v := rc2v;
			self.rc3_1 := rc3_1;
			self.rc3v := rc3v;
			self.rc4_1 := rc4_1;
			self.rc4v := rc4v;
			self.rc5_2 := rc5_2;
			self.rcsegderog := rcsegderog;
			self.rcsegyoung := rcsegyoung;
			self.rcsegowner := rcsegowner;
			self.rcsegother := rcsegother;
			self.rcvalue03_1 := rcvalue03_1;
			self.rcvalue03 := rcvalue03;
			self.rcvalue07_1 := rcvalue07_1;
			self.rcvalue07 := rcvalue07;
			self.rcvalue20_1 := rcvalue20_1;
			self.rcvalue20_2 := rcvalue20_2;
			self.rcvalue20_3 := rcvalue20_3;
			self.rcvalue20_4 := rcvalue20_4;
			self.rcvalue20_5 := rcvalue20_5;
			self.rcvalue20_6 := rcvalue20_6;
			self.rcvalue20_7 := rcvalue20_7;
			self.rcvalue20_8 := rcvalue20_8;
			self.rcvalue20 := rcvalue20;
			self.rcvalue25_1 := rcvalue25_1;
			self.rcvalue25 := rcvalue25;
			self.rcvalue28_1 := rcvalue28_1;
			self.rcvalue28_2 := rcvalue28_2;
			self.rcvalue28_3 := rcvalue28_3;
			self.rcvalue28 := rcvalue28;
			self.rcvalue97_1 := rcvalue97_1;
			self.rcvalue97_2 := rcvalue97_2;
			self.rcvalue97 := rcvalue97;
			self.rcvalue98_1 := rcvalue98_1;
			self.rcvalue98_2 := rcvalue98_2;
			self.rcvalue98_3 := rcvalue98_3;
			self.rcvalue98_4 := rcvalue98_4;
			self.rcvalue98_5 := rcvalue98_5;
			self.rcvalue98_6 := rcvalue98_6;
			self.rcvalue98_7 := rcvalue98_7;
			self.rcvalue98_8 := rcvalue98_8;
			self.rcvalue98 := rcvalue98;
			self.rcvalue99_1 := rcvalue99_1;
			self.rcvalue99_2 := rcvalue99_2;
			self.rcvalue99_3 := rcvalue99_3;
			self.rcvalue99 := rcvalue99;
			self.rcvalue9a_1 := rcvalue9a_1;
			self.rcvalue9a_2 := rcvalue9a_2;
			self.rcvalue9a_3 := rcvalue9a_3;
			self.rcvalue9a := rcvalue9a;
			self.rcvalue9d_1 := rcvalue9d_1;
			self.rcvalue9d_2 := rcvalue9d_2;
			self.rcvalue9d_3 := rcvalue9d_3;
			self.rcvalue9d_4 := rcvalue9d_4;
			self.rcvalue9d := rcvalue9d;
			self.rcvalue9e_1 := rcvalue9e_1;
			self.rcvalue9e_2 := rcvalue9e_2;
			self.rcvalue9e_3 := rcvalue9e_3;
			self.rcvalue9e_4 := rcvalue9e_4;
			self.rcvalue9e_5 := rcvalue9e_5;
			self.rcvalue9e_6 := rcvalue9e_6;
			self.rcvalue9e_7 := rcvalue9e_7;
			self.rcvalue9e_8 := rcvalue9e_8;
			self.rcvalue9e_9 := rcvalue9e_9;
			self.rcvalue9e_10 := rcvalue9e_10;
			self.rcvalue9e_11 := rcvalue9e_11;
			self.rcvalue9e := rcvalue9e;
			self.rcvalue9g_1 := rcvalue9g_1;
			self.rcvalue9g_2 := rcvalue9g_2;
			self.rcvalue9g_3 := rcvalue9g_3;
			self.rcvalue9g_4 := rcvalue9g_4;
			self.rcvalue9g := rcvalue9g;
			self.rcvalue9h_1 := rcvalue9h_1;
			self.rcvalue9h_2 := rcvalue9h_2;
			self.rcvalue9h := rcvalue9h;
			self.rcvalue9i_1 := rcvalue9i_1;
			self.rcvalue9i := rcvalue9i;
			self.rcvalue9j_1 := rcvalue9j_1;
			self.rcvalue9j := rcvalue9j;
			self.rcvalue9o_1 := rcvalue9o_1;
			self.rcvalue9o_2 := rcvalue9o_2;
			self.rcvalue9o_3 := rcvalue9o_3;
			self.rcvalue9o_4 := rcvalue9o_4;
			self.rcvalue9o_5 := rcvalue9o_5;
			self.rcvalue9o_6 := rcvalue9o_6;
			self.rcvalue9o := rcvalue9o;
			self.rcvalue9q_1 := rcvalue9q_1;
			self.rcvalue9q_2 := rcvalue9q_2;
			self.rcvalue9q_3 := rcvalue9q_3;
			self.rcvalue9q_4 := rcvalue9q_4;
			self.rcvalue9q_5 := rcvalue9q_5;
			self.rcvalue9q_6 := rcvalue9q_6;
			self.rcvalue9q_7 := rcvalue9q_7;
			self.rcvalue9q_8 := rcvalue9q_8;
			self.rcvalue9q_9 := rcvalue9q_9;
			self.rcvalue9q_10 := rcvalue9q_10;
			self.rcvalue9q_11 := rcvalue9q_11;
			self.rcvalue9q := rcvalue9q;
			self.rcvalue9r_1 := rcvalue9r_1;
			self.rcvalue9r_2 := rcvalue9r_2;
			self.rcvalue9r_3 := rcvalue9r_3;
			self.rcvalue9r_4 := rcvalue9r_4;
			self.rcvalue9r_5 := rcvalue9r_5;
			self.rcvalue9r := rcvalue9r;
			self.rcvalue9t_1 := rcvalue9t_1;
			self.rcvalue9t_2 := rcvalue9t_2;
			self.rcvalue9t_3 := rcvalue9t_3;
			self.rcvalue9t := rcvalue9t;
			self.rcvalue9u_1 := rcvalue9u_1;
			self.rcvalue9u_2 := rcvalue9u_2;
			self.rcvalue9u := rcvalue9u;
			self.rcvalue9v_1 := rcvalue9v_1;
			self.rcvalue9v_2 := rcvalue9v_2;
			self.rcvalue9v := rcvalue9v;
			self.rcvalue9w_1 := rcvalue9w_1;
			self.rcvalue9w := rcvalue9w;
			self.rcvalueev_1 := rcvalueev_1;
			self.rcvalueev_2 := rcvalueev_2;
			self.rcvalueev := rcvalueev;
			self.rcvaluemi_1 := rcvaluemi_1;
			self.rcvaluemi_2 := rcvaluemi_2;
			self.rcvaluemi_3 := rcvaluemi_3;
			self.rcvaluemi_4 := rcvaluemi_4;
			self.rcvaluemi := rcvaluemi;
			self.rcvaluems_1 := rcvaluems_1;
			self.rcvaluems_2 := rcvaluems_2;
			self.rcvaluems_3 := rcvaluems_3;
			self.rcvaluems_4 := rcvaluems_4;
			self.rcvaluems_5 := rcvaluems_5;
			self.rcvaluems_6 := rcvaluems_6;
			self.rcvaluems := rcvaluems;
			self.rcvaluepv_1 := rcvaluepv_1;
			self.rcvaluepv_2 := rcvaluepv_2;
			self.rcvaluepv_3 := rcvaluepv_3;
			self.rcvaluepv_4 := rcvaluepv_4;
			self.rcvaluepv_5 := rcvaluepv_5;
			self.rcvaluepv := rcvaluepv;

			self.rc1 := rcs_override[1].rc;
			self.rc2 := rcs_override[2].rc;
			self.rc3 := rcs_override[3].rc;
			self.rc4 := rcs_override[4].rc;
			self.rc5 := rcs_override[5].rc;
			
			self.rc1_val := rcs_override[1].value;
			self.rc2_val := rcs_override[2].value;
			self.rc3_val := rcs_override[3].value;
			self.rc4_val := rcs_override[4].value;
			self.rc5_val := rcs_override[5].value;
			
			self.clam := le;
		#end

		self.seq := le.seq;


		riTemp := riskwisefcra.corrReasonCodes( le.consumerflags, 4 );
		rcs_final := project( rcs_override, transform( risk_indicators.Layout_Desc,
			self.hri := left.rc,
			self.desc := risk_indicators.getHRIDesc(left.rc)
		));

		inCalif := isCalifornia and (
			(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
			+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
			+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		PrescreenOptOut := xmlPrescreenOptOut or risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
		ri := map(
			riTemp[1].hri <> '00' => riTemp,
			risk_indicators.rcSet.isCode95(PreScreenOptOut) => DATASET([{'95',risk_indicators.getHRIDesc('95')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			inCalif => DATASET([{'35',risk_indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			rcs_final
		);
		zeros := dataset( [ {'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc);
		self.ri := choosen( ri & zeros, 5 );

		self.score := map(
			riTemp[1].hri in ['91','92','93','94'] => (string3)((integer)riTemp[1].hri + 10),
			risk_indicators.rcSet.isCode95(PreScreenOptOut) => '222',
			self.ri[1].hri='35' => '100',
			(string3)rvg1103
		);

	END;

	model := project( clam, doModel(LEFT) );
	return model;

END;
