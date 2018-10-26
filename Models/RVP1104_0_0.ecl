import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVP1104_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean xmlPreScreenOptOut ) := FUNCTION

	RVP_DEBUG := false;

	#if(RVP_DEBUG)
		debug_layout := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String out_unit_desig;
			String out_sec_range;
			String out_st;
			String out_addr_type;
			Integer nas_summary;
			Integer nap_summary;
			String nap_type;
			String nap_status;
			Integer did_count;
			Integer did2_criminal_count;
			Integer did2_felony_count;
			Integer did2_liens_recent_unrel_count;
			Integer did2_liens_recent_rel_count;
			Integer rc_dirsaddr_lastscore;
			Boolean rc_input_addr_not_most_recent;
			String rc_hriskphoneflag;
			String rc_hphonetypeflag;
			String rc_phonevalflag;
			String rc_hphonevalflag;
			String rc_pwphonezipflag;
			String rc_hriskaddrflag;
			String rc_decsflag;
			String rc_ssndobflag;
			String rc_pwssndobflag;
			String rc_pwssnvalflag;
			Integer rc_ssnlowissue;
			String rc_ssnstate;
			String rc_addrvalflag;
			String rc_dwelltype;
			String rc_bansflag;
			Integer rc_addrcount;
			Integer rc_numelever;
			Integer rc_phoneaddrcount;
			Boolean rc_addrmiskeyflag;
			String rc_addrcommflag;
			String rc_hrisksic;
			String rc_ziptypeflag;
			String rc_cityzipflag;
			Boolean rc_altlname1_flag;
			Boolean rc_altlname2_flag;
			Integer combo_addrscore;
			Integer combo_dobscore;
			Boolean rc_watchlist_flag;
			qstring100 ver_sources;
			qstring100 ver_sources_NAS;
			qstring200 ver_sources_first_seen;
			String ssnlength;
			Integer Age;
			Boolean add1_isbestmatch;
			String add1_advo_address_vacancy;
			String add1_advo_throw_back;
			String add1_advo_drop;
			String add1_avm_land_use;
			String add1_avm_assessed_total_value;
			String add1_avm_market_total_value;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Integer add1_source_count;
			Boolean add1_family_owned;
			Integer add1_naprop;
			Integer add1_purchase_date;
			String add1_mortgage_type;
			String add1_financing_type;
			Integer add1_date_first_seen;
			String add1_building_area;
			String add1_no_of_stories;
			String add1_no_of_baths;
			String add1_no_of_partial_baths;
			Integer property_owned_total;
			Integer property_sold_total;
			Integer dist_a1toa2;
			Integer dist_a1toa3;
			String add2_addr_type;
			String add2_advo_address_vacancy;
			String add2_advo_college;
			String add2_avm_land_use;
			String add2_avm_sales_price;
			String add2_avm_market_total_value;
			Integer add2_avm_automated_valuation;
			Integer add2_avm_med_fips;
			Integer add2_avm_med_geo11;
			Integer add2_avm_med_geo12;
			String add2_mortgage_type;
			String add2_financing_type;
			String add3_addr_type;
			Integer add3_avm_automated_valuation;
			String add3_mortgage_type;
			String add3_financing_type;
			Integer add3_market_total_value;
			Integer add3_assessed_total_value;
			Integer avg_lres;
			Integer addrs_15yr;
			Integer unique_addr_count;
			Integer avg_mo_per_addr;
			Boolean addr_hist_advo_college;
			String telcordia_type;
			String gong_did_first_seen;
			Integer namePerSSN_count;
			Integer header_first_seen;
			Integer ssns_per_adl;
			Integer addrs_per_adl;
			Integer adlPerSSN_count;
			Integer addrs_per_ssn;
			Integer adls_per_addr;
			Integer ssns_per_addr;
			Integer phones_per_addr;
			Integer ssns_per_adl_c6;
			Integer addrs_per_adl_c6;
			Integer addrs_per_ssn_c6;
			Integer adls_per_addr_c6;
			Integer ssns_per_addr_c6;
			Integer phones_per_addr_c6;
			Integer inq_count01;
			Integer inq_count03;
			Integer inq_count12;
			Integer inq_banking_count12;
			Integer inq_highriskcredit_count12;
			Integer inq_communications_count12;
			Integer inq_peradl;
			Integer inq_ssnsperadl;
			Integer inq_addrsperadl;
			Integer inq_phonesperadl;
			Integer inq_perssn;
			Integer inq_lnamesperssn;
			Integer inq_peraddr;
			Integer inq_lnamesperaddr;
			Integer inq_adlsperphone;
			Integer paw_business_count;
			Integer paw_active_phone_count;
			Integer infutor_nap;
			Integer impulse_count;
			Integer email_count;
			Integer email_domain_free_count;
			Integer email_domain_edu_count;
			Integer email_domain_corp_count;
			qstring50 email_source_list;
			Integer attr_addrs_last30;
			Integer attr_addrs_last90;
			Integer attr_addrs_last24;
			Integer attr_num_aircraft;
			Integer attr_total_number_derogs;
			Integer attr_num_rel_liens12;
			Integer attr_bankruptcy_count36;
			Integer attr_eviction_count;
			Integer attr_date_last_eviction;
			Integer attr_num_nonderogs;
			Integer attr_num_nonderogs30;
			Integer attr_num_nonderogs180;
			Boolean Bankrupt;
			String disposition;
			Integer filing_count;
			Integer bk_recent_count;
			Integer bk_disposed_recent_count;
			Integer bk_disposed_historical_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_recent_released_count;
			Integer liens_historical_released_count;
			String liens_last_unrel_date;
			Integer liens_rel_cj_ct;
			Integer liens_unrel_lt_ct;
			Integer liens_unrel_o_ct;
			Integer criminal_count;
			Integer criminal_last_date;
			Integer felony_count;
			Integer watercraft_count;
			String ams_age;
			String ams_class;
			String ams_college_code;
			String ams_college_type;
			String ams_income_level_code;
			String ams_file_type;
			String ams_college_tier;
			Boolean prof_license_flag;
			String wealth_index;
			String input_dob_match_level;
			Integer inferred_age;
			String addr_stability_v2;
			Integer estimated_income;
			Integer archive_date;

			Integer sysdate;
			Integer header_first_seen2;
			Real mth_header_first_seen;
			Integer add1_date_first_seen2;
			Real mth_add1_date_first_seen;
			Integer rc_ssnlowissue2;
			Real mth_rc_ssnlowissue;
			Integer liens_last_unrel_date2;
			Real mth_liens_last_unrel_date;
			Integer attr_date_last_eviction2;
			Real mth_attr_date_last_eviction;
			Integer criminal_last_date2;
			Real mth_criminal_last_date;
			Integer gong_did_first_seen2;
			Real mth_gong_did_first_seen;
			Integer add1_purchase_date2;
			Real mth_add1_purchase_date;
			Integer mth_header_first_seen2;
			Integer mth_rc_ssnlowissue2;
			Integer mth_add1_date_first_seen2;
			Integer mth_gong_did_first_seen2;
			Integer ver_src_cnt;
			Integer ver_src_ak_pos;
			Boolean ver_src_ak;
			Real ver_src_nas_ak;
			Integer ver_src_am_pos;
			Boolean ver_src_am;
			Integer ver_src_ar_pos;
			Boolean ver_src_ar;
			Integer ver_src_ba_pos;
			Boolean ver_src_ba;
			Integer ver_src_ds_pos;
			Boolean ver_src_ds;
			Integer ver_src_eb_pos;
			Boolean ver_src_eb;
			Integer ver_src_em_pos;
			Boolean ver_src_em;
			Real ver_src_nas_em;
			Integer ver_src_e1_pos;
			Boolean ver_src_e1;
			Real ver_src_nas_e1;
			Integer ver_src_e2_pos;
			Boolean ver_src_e2;
			Real ver_src_nas_e2;
			Integer ver_src_e3_pos;
			Boolean ver_src_e3;
			Integer ver_src_e4_pos;
			Boolean ver_src_e4;
			Real ver_src_nas_e4;
			Integer ver_src_eq_pos;
			Boolean ver_src_eq;
			String ver_src_fdate_eq;
			Integer ver_src_fdate_eq2;
			Real mth_ver_src_fdate_eq;
			Integer ver_src_l2_pos;
			Boolean ver_src_l2;
			Integer ver_src_li_pos;
			Boolean ver_src_li;
			Integer ver_src_mw_pos;
			Boolean ver_src_mw;
			Integer ver_src_p_pos;
			Boolean ver_src_p;
			Integer ver_src_pl_pos;
			Boolean ver_src_pl;
			Integer ver_src_v_pos;
			Boolean ver_src_v;
			Integer ver_src_vo_pos;
			Boolean ver_src_vo;
			Real ver_src_nas_vo;
			Integer ver_src_w_pos;
			Boolean ver_src_w;
			Integer ver_src_wp_pos;
			Real ver_src_nas_wp;
			Integer mth_ver_src_fdate_eq2;
			Integer age_on_eq;
			Integer email_src_im_pos;
			Boolean email_src_im;
			Boolean add_apt;
			Boolean add2_apt;
			Boolean add3_apt;
			Integer add1_building_area2;
			Integer add1_avm_med;
			Integer add2_avm_med;
			Real add1_avm_to_med_ratio;
			Integer _add1_avm;
			Integer _add2_avm;
			String _add1_avm_class;
			String _add2_avm_class;
			String _econtrajectory;
			Integer _econtrj;
			Boolean prop_owned_flag;
			Boolean prop_sold_flag;
			Integer id_per_addr_diff;
			Integer id_per_addr_c6_diff;
			Boolean s1_bk_bad;
			Integer s1_attr_num_rel_liens12;
			Integer s1_mth_liens_last_unrel;
			Real s1_mth_liens_last_unrel_m;
			Integer s1_liens_rel_cj;
			Real s1_liens_rel_cj_m;
			Integer s1_liens_unrel_lt;
			Integer s1_liens_unrel_o;
			Integer s1_attr_eviction;
			Real s1_attr_eviction_m;
			Integer s1_mth_attr_last_eviction;
			Real s1_mth_attr_last_eviction_m;
			Integer s1_felony;
			Real s1_felony_m;
			Integer s1_mth_last_criminal;
			Real s1_mth_last_criminal_m;
			Integer s1_impulse;
			Real s1_impulse_m;
			Boolean s1_did2_derog;
			Integer s1_derog_ratio;
			Real s1_derog_ratio_lvl;
			Real s1_derog_ratio_lvl_m;
			Real s1derog3;
			Integer s1_mth_rc_ssnlowissue;
			Real s1_mth_rc_ssnlowissue_m;
			Boolean s1_add_risk;
			Boolean s1_phone_risk;
			Integer s1_mth_add1;
			Real s1_mth_add1_m;
			Integer s1_avg_lres;
			Real s1_avg_lres_m;
			Integer s1_avg_mo_per_addr;
			Real s1_avg_mo_per_addr_m;
			Integer s1_addrs_per_ssn_c6;
			Real s1_addrs_per_ssn_c6_m;
			Integer s1_addr_stability_v2;
			Real s1_addr_stability_v2_m;
			Real s1mobility1;
			Integer s1_mth_gong_did;
			Real s1_mth_gong_did_m;
			Integer s1_rc_dirsaddr_lastscore;
			Real s1_rc_dirsaddr_lastscore_m;
			Integer s1_add1_source_count;
			Real s1_add1_source_count_m;
			Integer s1_prop_owner;
			Real s1_prop_owner_m;
			Integer s1_rc_numelever;
			Real s1_rc_numelever_m;
			Boolean s1_mortgage_risky;
			Boolean s1_ams_class_gr;
			Boolean s1_ams_class_sr;
			Integer s1_ams_college_type;
			Real s1_ams_college_type_m;
			Boolean s1_ams_college_code;
			Integer s1_ams_income_level;
			Real s1_ams_income_level_m;
			Real s1ams1;
			Integer s1_ssns_per_adl_c6;
			Real s1_ssns_per_adl_c6_m;
			Integer s1_adls_per_addr;
			Real s1_adls_per_addr_m;
			Integer s1_id_per_addr_diff;
			Real s1_id_per_addr_diff_m;
			Integer s1_adls_per_addr_c6;
			Real s1_adls_per_addr_c6_m;
			Integer s1_phones_per_addr_c6;
			Real s1_phones_per_addr_c6_m;
			Integer s1_estimated_income;
			Real s1_estimated_income_m;
			Integer s1_state;
			Real s1_state_m;
			Integer s1_inq_banking_count12;
			Real s1_inq_banking_count12_m;
			Integer s1_inq_ssnsperadl;
			Real s1_inq_ssnsperadl_m;
			Integer s1_inq_perssn;
			Real s1_inq_perssn_m;
			Integer s1_inq_peraddr;
			Real s1_inq_peraddr_m;
			Real s1inq2;
			Real s103;
			Boolean s2_add_risk;
			Boolean s2_phone_risk;
			Integer s2_addrs_per_ssn;
			Real s2_addrs_per_ssn_m;
			Boolean s2_infutor;
			Integer s2_rc_dirsaddr_lastscore;
			Real s2_rc_dirsaddr_lastscore_m;
			Integer s2_naprop;
			Real s2_naprop_m;
			Integer s2_add1_assessedvalue;
			Real s2_add1_assessedvalue_m;
			Integer s2_add1_avm_med;
			Real s2_add1_avm_med_m;
			Integer s2_buildingarea;
			Real s2_buildingarea_m;
			Boolean s2_add1_2story;
			Integer s2_econtrj;
			Real s2_econtrj_m;
			Boolean s2_mortgage_risky;
			Integer s2_adls_per_addr;
			Real s2_adls_per_addr_m;
			Integer s2_adls_per_addr_c6;
			Real s2_adls_per_addr_c6_m;
			Integer s2_phones_per_addr;
			Real s2_phones_per_addr_m;
			Integer s2_estimated_income;
			Real s2_estimated_income_m;
			Integer s2_inq_peraddr;
			Real s2_inq_peraddr_m;
			Boolean s2_other_risk;
			Real s204;
			Boolean s3_phone_risk;
			Integer s3_avg_lres;
			Real s3_avg_lres_m;
			Integer s3_addrs_per_adl;
			Real s3_addrs_per_adl_m;
			Integer s3_addrs_per_ssn;
			Real s3_addrs_per_ssn_m;
			Integer s3_unique_addr_count;
			Real s3_unique_addr_count_m;
			Integer s3_attr_addrs_last30;
			Real s3_attr_addrs_last30_m;
			Real s3mobility2;
			Integer s3_mth_gong_did;
			Real s3_mth_gong_did_m;
			Integer s3_rc_dirsaddr_lastscore;
			Real s3_rc_dirsaddr_lastscore_m;
			Integer s3_add1_source_count;
			Real s3_add1_source_count_m;
			Integer s3_naprop;
			Real s3_naprop_m;
			Integer s3_minor_src_ver;
			Integer s3_minor_src_ver_i;
			Real s3_minor_src_ver_i_m;
			Integer s3_add1_assessedvalue;
			Real s3_add1_assessedvalue_m;
			Integer s3_add1_avm;
			Real s3_add1_avm_m;
			Integer s3_add2_salesprice;
			Real s3_add2_salesprice_m;
			Integer s3_add2_avm;
			Real s3_add2_avm_m;
			Integer s3_add3_assessedvalue;
			Real s3_add3_assessedvalue_m;
			Integer s3_add3_avm;
			Real s3_add3_avm_m;
			Integer s3_add1_avm_med;
			Real s3_add1_avm_med_m;
			Integer s3_buildingarea;
			Real s3_buildingarea_m;
			Integer s3_add1_avm_to_med_ratio;
			Real s3_add1_avm_to_med_ratio_m;
			Boolean s3_add1_bath_36;
			Boolean s3_add1_no_of_partial_baths;
			Real s3avm1;
			Boolean s3_mortgage_risky;
			Integer s3_econtrj;
			Real s3_econtrj_m;
			Boolean s3_ams_class_high;
			Integer s3_ams_college_tier;
			Real s3_ams_college_tier_m;
			Integer s3_ams_income_level;
			Real s3_ams_income_level_m;
			Real s3ams2;
			Integer s3_adlperssn;
			Real s3_adlperssn_m;
			Integer s3_adls_per_addr;
			Real s3_adls_per_addr_m;
			Integer s3_id_per_addr_diff;
			Real s3_id_per_addr_diff_m;
			Integer s3_adls_per_addr_c6;
			Real s3_adls_per_addr_c6_m;
			Integer s3_phones_per_addr_c6;
			Real s3_phones_per_addr_c6_m;
			Integer s3_estimated_income;
			Real s3_estimated_income_m;
			Integer s3_inq_count12;
			Real s3_inq_count12_m;
			Integer s3_inq_peraddr;
			Real s3_inq_peraddr_m;
			Integer s3_state;
			Real s3_state_m;
			Boolean s3_other_risk;
			Boolean s3_other_good;
			Boolean s3_dist_a1toa2_1to10;
			Boolean s3_dist_a1toa3_1to10;
			Real s301;
			Integer s4_age;
			Real s4_age_m;
			Boolean s4_phone_risk;
			Integer s4_avg_lres;
			Real s4_avg_lres_m;
			Integer s4_avg_mo_per_addr;
			Real s4_avg_mo_per_addr_m;
			Integer s4_addrs_per_ssn;
			Real s4_addrs_per_ssn_m;
			Integer s4_addr_stability_v2;
			Real s4_addr_stability_v2_m;
			Integer s4_addrs_15yr;
			Real s4_addrs_15yr_m;
			Boolean s4_unique_addr_count;
			Integer s4_attr_addrs_last24;
			Real s4_attr_addrs_last24_m;
			Real s4mobility2;
			Integer s4_mth_gong_did;
			Real s4_mth_gong_did_m;
			Integer s4_rc_dirsaddr_lastscore;
			Real s4_rc_dirsaddr_lastscore_m;
			Integer s4_rc_phoneaddrcount;
			Boolean s4_combo_addrscore100;
			Integer s4_naprop;
			Real s4_naprop_m;
			Integer s4_minor_src_ver;
			Integer s4_minor_src_ver_i;
			Real s4_minor_src_ver_i_m;
			Integer s4_add1_assessedvalue;
			Real s4_add1_assessedvalue_m;
			Integer s4_add1_marketvalue;
			Real s4_add1_marketvalue_m;
			Integer s4_add1_avm;
			Real s4_add1_avm_m;
			Integer s4_add2_salesprice;
			Real s4_add2_salesprice_m;
			Integer s4_add2_avm;
			Real s4_add2_avm_m;
			Integer s4_add3_assessedvalue;
			Integer s4_add3_marketvalue;
			Integer s4_add3_avm;
			Real s4_add3_assessedvalue_m;
			Real s4_add3_marketvalue_m;
			Real s4_add3_avm_m;
			Integer s4_add1_avm_med;
			Real s4_add1_avm_med_m;
			Integer s4_add1_avm_to_med_ratio;
			Real s4_add1_avm_to_med_ratio_m;
			Integer s4_buildingarea;
			Real s4_buildingarea_m;
			Boolean s4_add1_no_of_partial_baths;
			Real s4avm1;
			Boolean s4_mortgage_risky;
			Boolean s4_ams_class;
			Integer s4_ams_college_tier;
			Integer s4_ams_income_level;
			Real s4_ams_college_tier_m;
			Real s4_ams_income_level_m;
			Real s4ams2;
			Integer s4_adlperssn;
			Real s4_adlperssn_m;
			Integer s4_adls_per_addr;
			Real s4_adls_per_addr_m;
			Integer s4_id_per_addr_diff;
			Real s4_id_per_addr_diff_m;
			Integer s4_adls_per_addr_c6;
			Real s4_adls_per_addr_c6_m;
			Integer s4_estimated_income;
			Real s4_estimated_income_m;
			Integer s4_inq_peraddr;
			Boolean s4_other_risk;
			Boolean s4_other_good;
			Real s404;
			Integer s5_minor_src_ver;
			Integer s5_minor_src_ver_i;
			Real s5_minor_src_ver_i_m;
			Boolean s5_phone_risk;
			Integer s5_add1_assessedvalue;
			Integer s5_add1_marketvalue;
			Integer s5_add1_avm;
			Integer s5_add2_salesprice;
			Real s5_add1_assessedvalue_m;
			Real s5_add1_marketvalue_m;
			Real s5_add1_avm_m;
			Real s5_add2_salesprice_m;
			Integer s5_add2_avm;
			Real s5_add2_avm_m;
			Integer s5_add3_assessedvalue;
			Integer s5_add3_marketvalue;
			Integer s5_add3_avm;
			Integer s5_add1_avm_med;
			Integer s5_buildingarea;
			Real s5_add3_assessedvalue_m;
			Real s5_add3_marketvalue_m;
			Real s5_add3_avm_m;
			Real s5_add1_avm_med_m;
			Real s5_buildingarea_m;
			Boolean s5_add1_2story;
			Boolean s5_add1_bath_37;
			Real s5avm02;
			Boolean s5_mortgage_risky;
			Integer s5_ssns_per_addr;
			Real s5_ssns_per_addr_m;
			Integer s5_id_per_addr_diff;
			Real s5_id_per_addr_diff_m;
			Integer s5_ssns_per_addr_c6;
			Integer s5_id_per_addr_c6_diff;
			Real s5_ssns_per_addr_c6_m;
			Real s5_id_per_addr_c6_diff_m;
			Boolean s5_ams_age_lt20;
			Integer s5_ams_income_level;
			Integer s5_ams_college_tier;
			Real s5_ams_income_level_m;
			Real s5_ams_college_tier_m;
			Real s5ams2;
			Integer s5_state;
			Real s5_state_m;
			Boolean s5_other_risk;
			Integer s5_rc_dirsaddr_lastscore;
			Real s5_rc_dirsaddr_lastscore_m;
			Integer s5_mth_add1;
			Real s5_mth_add1_m;
			Integer s5_addrs_per_ssn;
			Integer s5_addrs_per_adl;
			Real s5_addrs_per_ssn_m;
			Real s5_addrs_per_adl_m;
			Integer s5_addr_stability_v2;
			Real s5_addr_stability_v2_m;
			Integer s5_attr_addrs_last90;
			Real s5_attr_addrs_last90_m;
			Integer s5_addrs_per_adl_c6;
			Real s5_addrs_per_adl_c6_m;
			Real s5mobility3;
			Integer s5_phones_per_addr;
			Real s5_phones_per_addr_m;
			Boolean s5_add_risk;
			Boolean s5_other_good;
			Boolean nap_summary_1;
			Integer s5_inq_count01;
			Integer s5_inq_count03;
			Real s5_inq_count01_m;
			Real s5_inq_count03_m;
			Integer s5_inq_communications_count12;
			Real s5_inq_communications_count12_m;
			Integer s5_inq_phonesperadl;
			Real s5_inq_phonesperadl_m;
			Integer s5_inq_lnamesperssn;
			Real s5_inq_lnamesperssn_m;
			Integer s5_inq_peraddr;
			Real s5_inq_peraddr_m;
			Integer s5_inq_adlsperphone;
			Real s5_inq_adlsperphone_m;
			Real s5inq2;
			Integer s5_email_count;
			Real s5_email_count_m;
			Integer s5_econtrj;
			Real s5_econtrj_m;
			Boolean s5_dist_a1toa2_1to10;
			Boolean s5_dist_a1toa3_1to10;
			Integer s5_mth_header_first_seen;
			Real s5_mth_header_first_seen_m;
			Integer s5_attr_num_nonderogs180;
			Real s5_attr_num_nonderogs180_m;
			Integer s5_naprop;
			Real s5_naprop_m;
			Integer s5_adlperssn_count;
			Real s5_adlperssn_count_m;
			Integer s5_ssns_per_adl_c6;
			Real s5_ssns_per_adl_c6_m;
			Integer s5_estimated_income;
			Integer s5_wealth_index;
			Real s5_estimated_income_m;
			Real s5_wealth_index_m;
			Real s502c;
			Boolean s6_add_phone_risk;
			Integer s6_addrs_per_ssn;
			Real s6_addrs_per_ssn_m;
			Integer s6_attr_addrs_last24;
			Real s6_attr_addrs_last24_m;
			Integer s6_mth_header_first_seen;
			Real s6_mth_header_first_seen_m;
			Integer s6_rc_addrcount;
			Real s6_rc_addrcount_m;
			Integer s6_add2_marketvalue;
			Real s6_add2_marketvalue_m;
			Integer s6_add3_marketvalue;
			Real s6_add3_marketvalue_m;
			Integer s6_buildingarea;
			Real s6_buildingarea_m;
			Boolean s6_mortgage_risky;
			Integer s6_ams_college_tier;
			Integer s6_ams_income_level;
			Real s6_ams_college_tier_m;
			Real s6_ams_income_level_m;
			Boolean s6_adls_per_addr;
			Integer s6_adls_per_addr_c6;
			Real s6_adls_per_addr_c6_m;
			Integer s6_estimated_income;
			Real s6_estimated_income_m;
			Integer s6_inq_count12;
			Integer s6_inq_peraddr;
			Real s6_inq_count12_m;
			Real s6_inq_peraddr_m;
			Integer s6_state;
			Real s6_state_m;
			Real s603;
			Integer s7_age;
			Real s7_age_m;
			Boolean s7_phone_risk;
			Integer s7_avg_lres;
			Real s7_avg_lres_m;
			Integer s7_avg_mo_per_addr;
			Real s7_avg_mo_per_addr_m;
			Integer s7_addrs_per_ssn_c6;
			Real s7_addrs_per_ssn_c6_m;
			Integer s7_attr_addrs_last90;
			Real s7_attr_addrs_last90_m;
			Boolean s7_age_on_eq;
			Integer s7_mth_gong_did;
			Real s7_mth_gong_did_m;
			Integer s7_attr_num_nonderogs30;
			Real s7_attr_num_nonderogs30_m;
			Integer s7_rc_dirsaddr_lastscore;
			Real s7_rc_dirsaddr_lastscore_m;
			Integer s7_prop_owner;
			Real s7_prop_owner_m;
			Integer s7_rc_numelever;
			Real s7_rc_numelever_m;
			Integer s7_add2_avm;
			Real s7_add2_avm_m;
			Integer s7_add3_marketvalue;
			Integer s7_add3_avm;
			Real s7_add3_marketvalue_m;
			Real s7_add3_avm_m;
			Integer s7_add1_avm_med;
			Real s7_add1_avm_med_m;
			Boolean s7_add1_2story;
			Boolean s7_mortgage_risky;
			Integer s7_ams_college_tier;
			Integer s7_ams_income_level;
			Real s7_ams_college_tier_m;
			Real s7_ams_income_level_m;
			Boolean s7_ams_class_gr;
			Integer s7_ssns_per_adl;
			Real s7_ssns_per_adl_m;
			Integer s7_adlperssn;
			Real s7_adlperssn_m;
			Integer s7_ssns_per_adl_c6;
			Real s7_ssns_per_adl_c6_m;
			Integer s7_adls_per_addr;
			Real s7_adls_per_addr_m;
			Integer s7_adls_per_addr_c6;
			Real s7_adls_per_addr_c6_m;
			Integer s7_phones_per_addr_c6;
			Real s7_phones_per_addr_c6_m;
			Integer s7_estimated_income;
			Integer s7_wealth_index;
			Real s7_estimated_income_m;
			Real s7_wealth_index_m;
			Integer s7_inq_count12;
			Integer s7_inq_peraddr;
			Real s7_inq_count12_m;
			Real s7_inq_peraddr_m;
			Boolean s7_other_risk;
			Boolean s7_add_risk;
			Integer s7_other_risk2;
			Real s7_other_risk2_m;
			Boolean s7_other_good;
			Integer s7_email_domain_free;
			Real s7_email_domain_free_m;
			Real s705;
			Integer s8_age;
			Real s8_age_m;
			Integer s8_mth_rc_ssnlowissue;
			Real s8_mth_rc_ssnlowissue_m;
			Boolean s8_add_risk;
			Integer s8_mth_add1;
			Real s8_avg_lres;
			Real s8_mth_add1_m;
			Real s8_avg_lres_m;
			Integer s8_avg_mo_per_addr;
			Real s8_avg_mo_per_addr_m;
			Integer s8_addrs_per_ssn;
			Real s8_addrs_per_ssn_m;
			Integer s8_addrs_per_ssn_c6;
			Real s8_addrs_per_ssn_c6_m;
			Integer s8_addr_stability_v2;
			Real s8_addr_stability_v2_m;
			Integer s8_attr_addrs_last90;
			Real s8_attr_addrs_last90_m;
			Real s8mobility2;
			Integer s8_nap;
			Real s8_nap_m;
			Real s8_mth_eq;
			Real s8_mth_eq_m;
			Integer s8_mth_gong_did;
			Real s8_mth_gong_did_m;
			Integer s8_attr_num_nonderogs30;
			Real s8_attr_num_nonderogs30_m;
			Integer s8_prop_owner;
			Real s8_prop_owner_m;
			Integer s8_minor_src_ver;
			Integer s8_minor_src_ver_i;
			Boolean s8_pl;
			Real s8_minor_src_ver_i_m;
			Integer s8_add2_marketvalue;
			Real s8_add2_marketvalue_m;
			Integer s8_add3_marketvalue;
			Real s8_add3_marketvalue_m;
			Integer s8_add1_avm_med;
			Integer s8_add1_avm_to_med_ratio;
			Integer s8_buildingarea;
			Real s8_add1_avm_med_m;
			Real s8_add1_avm_to_med_ratio_m;
			Real s8_buildingarea_m;
			Boolean s8_add1_2story;
			Boolean s8_add1_no_of_partial_baths;
			Real s8avm2;
			Boolean s8_mortgage_risky;
			Integer s8_econtrj;
			Real s8_econtrj_m;
			Integer s8_mth_add1_purchase_date;
			Real s8_mth_add1_purchase_date_m;
			Boolean s8_ams_age_le31;
			Integer s8_ams_college_tier;
			Integer s8_ams_income_level;
			Real s8_ams_college_tier_m;
			Real s8_ams_income_level_m;
			Real s8ams1;
			Integer s8_ssns_per_adl;
			Real s8_ssns_per_adl_m;
			Integer s8_adlperssn;
			Real s8_adlperssn_m;
			Integer s8_ssns_per_adl_c6;
			Real s8_ssns_per_adl_c6_m;
			Integer s8_adls_per_addr;
			Real s8_adls_per_addr_m;
			Integer s8_id_per_addr_diff;
			Real s8_id_per_addr_diff_m;
			Integer s8_adls_per_addr_c6;
			Real s8_adls_per_addr_c6_m;
			Integer s8_phones_per_addr_c6;
			Real s8_phones_per_addr_c6_m;
			Boolean s8_nameperssn_count;
			Integer s8_wealth_index;
			Real s8_wealth_index_m;
			Integer s8_inq_peradl;
			Real s8_inq_peradl_m;
			Integer s8_inq_addrsperadl;
			Integer s8_inq_lnamesperaddr;
			Real s8_inq_lnamesperaddr_m;
			Real s8inq2;
			Integer s8_state2;
			Real s8_state2_m;
			Real s803;
			Boolean uv_derog;
			Integer uv_eq_type;
			Boolean uv_propowner;
			String uv_segment;
			Real logit;
			Real phat;
			Integer Base;
			Real odds;
			Integer point;
			Integer rvp1104_raw;
			Boolean ov_ssndead;
			Boolean ov_ssnprior;
			Boolean ov_criminal_flag;
			Boolean ov_corrections;
			Boolean ov_impulse;
			Boolean ov_condition;
			Integer rvp1104_cap;
			Boolean uv_rv20_content;
			Boolean uv_gong_sourced;
			Boolean uv_eq_only;
			Boolean uv_rvp1003_content;
			Integer rvp1104;
			models.Layout_ModelOut;
		end;
		debug_layout doModel( clam le ) := TRANSFORM
	#else
		models.layout_modelout doModel( clam le ) := TRANSFORM
	#end
	
		truedid                          := le.truedid;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_st                           := le.shell_input.st;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_type                         := le.iid.nap_type;
		nap_status                       := le.iid.nap_status;
		did_count                        := le.iid.didcount;
		did2_criminal_count              := le.iid.did2_criminal_count;
		did2_felony_count                := le.iid.did2_felony_count;
		did2_liens_recent_unrel_count    := le.iid.did2_liens_recent_unreleased_count;
		did2_liens_recent_rel_count      := le.iid.did2_liens_recent_released_count;
		rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
		rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_hriskaddrflag                 := le.iid.hriskaddrflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
		rc_ssnstate                      := le.iid.soclstate;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_addrcount                     := le.iid.addrcount;
		rc_numelever                     := le.iid.numelever;
		rc_phoneaddrcount                := le.iid.phoneaddrcount;
		rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
		rc_addrcommflag                  := le.iid.addrcommflag;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_ziptypeflag                   := le.iid.ziptypeflag;
		rc_cityzipflag                   := le.iid.cityzipflag;
		rc_altlname1_flag                := le.iid.altlastpop;
		rc_altlname2_flag                := le.iid.altlast2pop;
		combo_addrscore                  := le.iid.combo_addrscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		rc_watchlist_flag                := le.iid.watchlisthit;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_nas                  := le.header_summary.ver_sources_nas;
		ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
		ssnlength                        := le.input_validation.ssn_length;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
		add1_advo_drop                   := le.advo_input_addr.drop_indicator;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_source_count                := le.address_verification.input_address_information.source_count;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_purchase_date               := le.address_verification.input_address_information.purchase_date;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_building_area               := (string)le.address_verification.input_address_information.building_area;
		add1_no_of_stories               := (string)le.address_verification.input_address_information.no_of_stories;
		add1_no_of_baths                 := (string)le.address_verification.input_address_information.no_of_baths;
		add1_no_of_partial_baths         := (string)le.address_verification.input_address_information.no_of_partial_baths;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add2_addr_type                   := le.address_verification.addr_type2;
		add2_advo_address_vacancy        := le.advo_addr_hist1.address_vacancy_indicator;
		add2_advo_college                := le.advo_addr_hist1.college_indicator;
		add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
		add2_avm_sales_price             := le.avm.address_history_1.avm_sales_price;
		add2_avm_market_total_value      := le.avm.address_history_1.avm_market_total_value;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
		add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
		add2_financing_type              := le.address_verification.address_history_1.type_financing;
		add3_addr_type                   := le.address_verification.addr_type3;
		add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
		add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
		add3_financing_type              := le.address_verification.address_history_2.type_financing;
		add3_market_total_value          := le.address_verification.address_history_2.assessed_amount;
		add3_assessed_total_value        := le.address_verification.address_history_2.assessed_total_value;
		avg_lres                         := le.other_address_info.avg_lres;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		unique_addr_count                := le.address_history_summary.unique_addr_cnt;
		avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
		addr_hist_advo_college           := le.address_history_summary.address_history_advo_college_hit;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		nameperssn_count                 := le.ssn_verification.nameperssn_count;
		header_first_seen                := le.ssn_verification.header_first_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		inq_count01                      := le.acc_logs.inquiries.count01;
		inq_count03                      := le.acc_logs.inquiries.count03;
		inq_count12                      := le.acc_logs.inquiries.count12;
		inq_banking_count12              := le.acc_logs.banking.count12;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		inq_communications_count12       := le.acc_logs.communications.count12;
		inq_peradl                       := le.acc_logs.inquiryperadl;
		inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
		inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
		inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
		inq_perssn                       := le.acc_logs.inquiryperssn;
		inq_lnamesperssn                 := le.acc_logs.inquirylnamesperssn;
		inq_peraddr                      := le.acc_logs.inquiryperaddr;
		inq_lnamesperaddr                := le.acc_logs.inquirylnamesperaddr;
		inq_adlsperphone                 := le.acc_logs.inquiryadlsperphone;
		paw_business_count               := le.employment.business_ct;
		paw_active_phone_count           := le.employment.business_active_phone_ct;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_count                      := le.email_summary.email_ct;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_domain_edu_count           := le.email_summary.email_domain_edu_ct;
		email_domain_corp_count          := le.email_summary.email_domain_corp_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_addrs_last30                := le.other_address_info.addrs_last30;
		attr_addrs_last90                := le.other_address_info.addrs_last90;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_num_rel_liens12             := le.bjl.liens_released_count12;
		attr_bankruptcy_count36          := le.bjl.bk_count36;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		attr_num_nonderogs30             := le.source_verification.num_nonderogs30;
		attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		liens_last_unrel_date            := le.bjl.last_liens_unreleased_date;
		liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_age                          := le.student.age;
		ams_class                        := le.student.class;
		ams_college_code                 := le.student.college_code;
		ams_college_type                 := le.student.college_type;
		ams_income_level_code            := le.student.income_level_code;
		ams_file_type                    := le.student.file_type;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		addr_stability_v2                := le.addr_stability;
		estimated_income                 := le.estimated_income;
		archive_date                     := le.historydate;





		NULL := -999999999;

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		
		// what do we do about the date here?
		sysdate := map(
			trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, ((STRING8)Std.Date.Today())[1..6] + '01', (string6)le.historydate+'01')),
			length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																   NULL);

		header_first_seen2 := models.common.sas_date((string)(header_first_seen));

		mth_header_first_seen := if(min(sysdate, header_first_seen2) = NULL, NULL, (sysdate - header_first_seen2) / 30.5);

		add1_date_first_seen2 := models.common.sas_date((string)(add1_date_first_seen));

		mth_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, (sysdate - add1_date_first_seen2) / 30.5);

		rc_ssnlowissue2 := models.common.sas_date((string)(rc_ssnlowissue));

		mth_rc_ssnlowissue := if(min(sysdate, rc_ssnlowissue2) = NULL, NULL, (sysdate - rc_ssnlowissue2) / 30.5);

		liens_last_unrel_date2 := models.common.sas_date((string)(liens_last_unrel_date));

		mth_liens_last_unrel_date := if(min(sysdate, liens_last_unrel_date2) = NULL, NULL, (sysdate - liens_last_unrel_date2) / 30.5);

		attr_date_last_eviction2 := models.common.sas_date((string)(attr_date_last_eviction));

		mth_attr_date_last_eviction := if(min(sysdate, attr_date_last_eviction2) = NULL, NULL, (sysdate - attr_date_last_eviction2) / 30.5);

		criminal_last_date2 := models.common.sas_date((string)(criminal_last_date));

		mth_criminal_last_date := if(min(sysdate, criminal_last_date2) = NULL, NULL, (sysdate - criminal_last_date2) / 30.5);

		gong_did_first_seen2 := models.common.sas_date((string)(gong_did_first_seen));

		mth_gong_did_first_seen := if(min(sysdate, gong_did_first_seen2) = NULL, NULL, (sysdate - gong_did_first_seen2) / 30.5);

		add1_purchase_date2 := models.common.sas_date((string)(add1_purchase_date));

		mth_add1_purchase_date := if(min(sysdate, add1_purchase_date2) = NULL, NULL, (sysdate - add1_purchase_date2) / 30.5);

		mth_header_first_seen2 := if (mth_header_first_seen >= 0, roundup(mth_header_first_seen), truncate(mth_header_first_seen));

		mth_rc_ssnlowissue2 := if (mth_rc_ssnlowissue >= 0, roundup(mth_rc_ssnlowissue), truncate(mth_rc_ssnlowissue));

		mth_add1_date_first_seen2 := if (mth_add1_date_first_seen >= 0, roundup(mth_add1_date_first_seen), truncate(mth_add1_date_first_seen));

		mth_gong_did_first_seen2 := if (mth_gong_did_first_seen >= 0, roundup(mth_gong_did_first_seen), truncate(mth_gong_did_first_seen));

		ver_src_cnt := models.common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

		ver_src_ak_pos := models.common.findw_cpp(ver_sources, 'AK' , ' ,', 'ie');

		ver_src_ak := ver_src_ak_pos > 0;

		ver_src_nas_ak := if(ver_src_ak_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_ak_pos), 0);

		ver_src_am_pos := models.common.findw_cpp(ver_sources, 'AM' , ' ,', 'ie');

		ver_src_am := ver_src_am_pos > 0;

		ver_src_ar_pos := models.common.findw_cpp(ver_sources, 'AR' , ' ,', 'ie');

		ver_src_ar := ver_src_ar_pos > 0;

		ver_src_ba_pos := models.common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie');

		ver_src_ba := ver_src_ba_pos > 0;

		ver_src_ds_pos := models.common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie');

		ver_src_ds := ver_src_ds_pos > 0;

		ver_src_eb_pos := models.common.findw_cpp(ver_sources, 'EB' , ' ,', 'ie');

		ver_src_eb := ver_src_eb_pos > 0;

		ver_src_em_pos := models.common.findw_cpp(ver_sources, 'EM' , ' ,', 'ie');

		ver_src_em := ver_src_em_pos > 0;

		ver_src_nas_em := if(ver_src_em_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_em_pos), 0);

		ver_src_e1_pos := models.common.findw_cpp(ver_sources, 'E1' , ' ,', 'ie');

		ver_src_e1 := ver_src_e1_pos > 0;

		ver_src_nas_e1 := if(ver_src_e1_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_e1_pos), 0);

		ver_src_e2_pos := models.common.findw_cpp(ver_sources, 'E2' , ' ,', 'ie');

		ver_src_e2 := ver_src_e2_pos > 0;

		ver_src_nas_e2 := if(ver_src_e2_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_e2_pos), 0);

		ver_src_e3_pos := models.common.findw_cpp(ver_sources, 'E3' , ' ,', 'ie');

		ver_src_e3 := ver_src_e3_pos > 0;

		ver_src_e4_pos := models.common.findw_cpp(ver_sources, 'E4' , ' ,', 'ie');

		ver_src_e4 := ver_src_e4_pos > 0;

		ver_src_nas_e4 := if(ver_src_e4_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_e4_pos), 0);

		ver_src_eq_pos := models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie');

		ver_src_eq := ver_src_eq_pos > 0;

		ver_src_fdate_eq := if(ver_src_eq_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

		ver_src_fdate_eq2 := models.common.sas_date((string)(ver_src_fdate_eq));

		mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

		ver_src_l2_pos := models.common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie');

		ver_src_l2 := ver_src_l2_pos > 0;

		ver_src_li_pos := models.common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie');

		ver_src_li := ver_src_li_pos > 0;

		ver_src_mw_pos := models.common.findw_cpp(ver_sources, 'MW' , ' ,', 'ie');

		ver_src_mw := ver_src_mw_pos > 0;

		ver_src_p_pos := models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');

		ver_src_p := ver_src_p_pos > 0;

		ver_src_pl_pos := models.common.findw_cpp(ver_sources, 'PL' , ' ,', 'ie');

		ver_src_pl := ver_src_pl_pos > 0;

		ver_src_v_pos := models.common.findw_cpp(ver_sources, 'V' , ' ,', 'ie');

		ver_src_v := ver_src_v_pos > 0;

		ver_src_vo_pos := models.common.findw_cpp(ver_sources, 'VO' , ' ,', 'ie');

		ver_src_vo := ver_src_vo_pos > 0;

		ver_src_nas_vo := if(ver_src_vo_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_vo_pos), 0);

		ver_src_w_pos := models.common.findw_cpp(ver_sources, 'W' , ' ,', 'ie');

		ver_src_w := ver_src_w_pos > 0;

		ver_src_wp_pos := models.common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie');

		ver_src_nas_wp := if(ver_src_wp_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_wp_pos), 0);

		mth_ver_src_fdate_eq2 := if (mth_ver_src_fdate_eq >= 0, roundup(mth_ver_src_fdate_eq), truncate(mth_ver_src_fdate_eq));

		age_on_eq := if(age > 0 and mth_ver_src_fdate_eq >= 0, age - truncate(mth_ver_src_fdate_eq / 12), NULL);

		email_src_im_pos := models.common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie');

		email_src_im := email_src_im_pos > 0;

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		add2_apt := StringLib.StringToUpperCase(add2_addr_type) = 'H';

		add3_apt := StringLib.StringToUpperCase(add3_addr_type) = 'H';

		add1_building_area2 := if(add1_building_area = (string)0, NULL, (unsigned)add1_building_area);

		add1_avm_med := map(
			ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
			ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
									  ADD1_AVM_MED_FIPS);

		add2_avm_med := map(
			add2_AVM_MED_GEO12 > 0 => add2_AVM_MED_GEO12,
			add2_AVM_MED_GEO11 > 0 => add2_AVM_MED_GEO11,
									  add2_AVM_MED_FIPS);

		add1_avm_to_med_ratio := if(add1_avm_automated_valuation > 0 and add1_avm_med > 0, add1_avm_automated_valuation / add1_avm_med, NULL);

		_add1_avm := map(
			add1_avm_automated_valuation > 0 => add1_avm_automated_valuation,
			add1_avm_med > 0                 => add1_avm_med,
												0);

		_add2_avm := map(
			add2_avm_automated_valuation > 0 => add2_avm_automated_valuation,
			add2_avm_med > 0                 => add2_avm_med,
												0);

		_add1_avm_class_c166 := map(
			_add1_avm > 400000 => 'A',
			_add1_avm > 200000 => 'B',
			_add1_avm > 100000 => 'C',
			_add1_avm > 50000  => 'D',
								  'E');

		_add1_avm_class_c167 := map(
			_add1_avm > 400000 => 'A',
			_add1_avm > 300000 => 'B',
			_add1_avm > 200000 => 'C',
			_add1_avm > 100000 => 'D',
			_add1_avm > 50000  => 'E',
			_add1_avm > 0      => 'F',
								  'U');

		_add1_avm_class := if(add1_avm_land_use = (string)1, _add1_avm_class_c166, _add1_avm_class_c167);

		_add2_avm_class_c169 := map(
			_add2_avm > 400000 => 'A',
			_add2_avm > 200000 => 'B',
			_add2_avm > 100000 => 'C',
			_add2_avm > 50000  => 'D',
								  'E');

		_add2_avm_class_c170 := map(
			_add2_avm > 400000 => 'A',
			_add2_avm > 300000 => 'B',
			_add2_avm > 200000 => 'C',
			_add2_avm > 100000 => 'D',
			_add2_avm > 50000  => 'E',
			_add2_avm > 0      => 'F',
								  'U');

		_add2_avm_class := if(add2_avm_land_use = (string)1, _add2_avm_class_c169, _add2_avm_class_c170);

		_econtrajectory := trim(_add2_avm_class, LEFT, RIGHT) + trim(_add1_avm_class, LEFT, RIGHT);

		_econtrj := map(
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

		prop_owned_flag := property_owned_total > 0;

		prop_sold_flag := property_sold_total > 0;

		id_per_addr_diff := adls_per_addr - ssns_per_addr;

		id_per_addr_c6_diff := adls_per_addr_c6 - ssns_per_addr_c6;

		s1_bk_bad := attr_bankruptcy_count36 > 1 or (integer)contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') > 0 or filing_count > 1 or bk_disposed_recent_count > 1 or bk_disposed_historical_count > 1;

		s1_attr_num_rel_liens12 := min(1, if(attr_num_rel_liens12 = NULL, -NULL, attr_num_rel_liens12));

		s1_mth_liens_last_unrel := map(
			mth_liens_last_unrel_date <= 0  => -1,
			mth_liens_last_unrel_date <= 3  => 9,
			mth_liens_last_unrel_date <= 6  => 8,
			mth_liens_last_unrel_date <= 12 => 7,
			mth_liens_last_unrel_date <= 24 => 6,
			mth_liens_last_unrel_date <= 36 => 5,
			mth_liens_last_unrel_date <= 48 => 4,
			mth_liens_last_unrel_date <= 60 => 3,
			mth_liens_last_unrel_date <= 72 => 2,
											   1);

		s1_mth_liens_last_unrel_m := map(
			s1_mth_liens_last_unrel = -1 => 0.1566669267,
			s1_mth_liens_last_unrel = 1  => 0.114628821,
			s1_mth_liens_last_unrel = 2  => 0.1177083333,
			s1_mth_liens_last_unrel = 3  => 0.1342412451,
			s1_mth_liens_last_unrel = 4  => 0.1485507246,
			s1_mth_liens_last_unrel = 5  => 0.1567944251,
			s1_mth_liens_last_unrel = 6  => 0.1678272981,
			s1_mth_liens_last_unrel = 7  => 0.2159672467,
			s1_mth_liens_last_unrel = 8  => 0.2503816794,
			s1_mth_liens_last_unrel = 9  => 0.2636612022,
											0.1597282452);

		s1_liens_rel_cj := min(3, if(liens_rel_CJ_ct = NULL, -NULL, liens_rel_CJ_ct));

		s1_liens_rel_cj_m := map(
			s1_liens_rel_cj = 0 => 0.1570854179,
			s1_liens_rel_cj = 1 => 0.181122449,
			s1_liens_rel_cj = 2 => 0.2605633803,
			s1_liens_rel_cj = 3 => 0.3121019108,
								   0.1597282452);

		s1_liens_unrel_lt := min(1, if(liens_unrel_LT_ct = NULL, -NULL, liens_unrel_LT_ct));

		s1_liens_unrel_o := min(1, if(liens_unrel_O_ct = NULL, -NULL, liens_unrel_O_ct));

		s1_attr_eviction := min(2, if(attr_eviction_count = NULL, -NULL, attr_eviction_count));

		s1_attr_eviction_m := map(
			s1_attr_eviction = 0 => 0.152963194,
			s1_attr_eviction = 1 => 0.2270676692,
			s1_attr_eviction = 2 => 0.2658333333,
									0.1597282452);

		s1_mth_attr_last_eviction := map(
			mth_attr_date_last_eviction <= 0  => -1,
			mth_attr_date_last_eviction <= 12 => 4,
			mth_attr_date_last_eviction <= 36 => 3,
			mth_attr_date_last_eviction <= 60 => 2,
												 1);

		s1_mth_attr_last_eviction_m := map(
			s1_mth_attr_last_eviction = -1 => 0.1529558571,
			s1_mth_attr_last_eviction = 1  => 0.162,
			s1_mth_attr_last_eviction = 2  => 0.2192816635,
			s1_mth_attr_last_eviction = 3  => 0.2363112392,
			s1_mth_attr_last_eviction = 4  => 0.3214285714,
											  0.1597282452);

		s1_felony := min(2, if(felony_count = NULL, -NULL, felony_count));

		s1_felony_m := map(
			s1_felony = 0 => 0.1548251209,
			s1_felony = 1 => 0.3400537634,
			s1_felony = 2 => 0.3868613139,
							 0.1597282452);

		s1_mth_last_criminal := map(
			mth_criminal_last_date <= 0  => -1,
			mth_criminal_last_date <= 12 => 5,
			mth_criminal_last_date <= 24 => 4,
			mth_criminal_last_date <= 36 => 3,
			mth_criminal_last_date <= 60 => 2,
											1);

		s1_mth_last_criminal_m := map(
			s1_mth_last_criminal = -1 => 0.14951558,
			s1_mth_last_criminal = 1  => 0.1838649156,
			s1_mth_last_criminal = 2  => 0.1938461538,
			s1_mth_last_criminal = 3  => 0.225433526,
			s1_mth_last_criminal = 4  => 0.2623941959,
			s1_mth_last_criminal = 5  => 0.2644135189,
										 0.1597282452);

		s1_impulse := min(2, if(impulse_count = NULL, -NULL, impulse_count));

		s1_impulse_m := map(
			s1_impulse = 0 => 0.1164066631,
			s1_impulse = 1 => 0.4565217391,
			s1_impulse = 2 => 0.5141509434,
							  0.1597282452);

		s1_did2_derog := did2_criminal_count > 0 or did2_felony_count > 0 or did2_liens_recent_unrel_count > 0 or did2_liens_recent_rel_count > 0;

		s1_derog_ratio_c183 := if(attr_total_number_derogs = 0, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10) * 10 + 100, if (attr_total_number_derogs * 100 / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) / 10 >= 0, roundup(attr_total_number_derogs * 100 / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) / 10), truncate(attr_total_number_derogs * 100 / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) / 10)) * 10);

		s1_derog_ratio := if(if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) > 0, s1_derog_ratio_c183, 100);

		s1_derog_ratio_lvl_1 := map(
			s1_derog_ratio = 110  => 0,
			s1_derog_ratio = 120  => 1,
			s1_derog_ratio >= 130 => 2,
									 s1_derog_ratio / 10 + 1);

		s1_derog_ratio_lvl := min(7, if(s1_derog_ratio_lvl_1 = NULL, -NULL, s1_derog_ratio_lvl_1));

		s1_derog_ratio_lvl_m := map(
			s1_derog_ratio_lvl = 0 => 0.3117149449,
			s1_derog_ratio_lvl = 1 => 0.1935832733,
			s1_derog_ratio_lvl = 2 => 0.0621032767,
			s1_derog_ratio_lvl = 3 => 0.085084572,
			s1_derog_ratio_lvl = 4 => 0.1292984869,
			s1_derog_ratio_lvl = 5 => 0.1721854305,
			s1_derog_ratio_lvl = 6 => 0.2394641362,
			s1_derog_ratio_lvl = 7 => 0.2644880174,
									  0.1597282452);

		s1derog3 := -7.704373636 +
			(integer)s1_bk_bad * 0.6858152353 +
			s1_attr_num_rel_liens12 * 0.2805929343 +
			s1_mth_liens_last_unrel_m * 3.9681136775 +
			s1_liens_rel_cj_m * 5.0303027509 +
			s1_liens_unrel_lt * 0.2294743421 +
			s1_liens_unrel_o * 0.5356458002 +
			s1_attr_eviction_m * 3.1169845884 +
			s1_mth_attr_last_eviction_m * 2.6899476335 +
			s1_felony_m * 3.7823187049 +
			s1_mth_last_criminal_m * 7.7403997407 +
			s1_impulse_m * 5.3668823508 +
			(integer)s1_did2_derog * 1.2242258911 +
			s1_derog_ratio_lvl_m * 4.3341601993;

		s1_mth_rc_ssnlowissue := map(
			mth_rc_ssnlowissue2 <= 0   => -1,
			mth_rc_ssnlowissue2 <= 221 => 13,
			mth_rc_ssnlowissue2 <= 233 => 12,
			mth_rc_ssnlowissue2 <= 245 => 11,
			mth_rc_ssnlowissue2 <= 269 => 10,
			mth_rc_ssnlowissue2 <= 293 => 9,
			mth_rc_ssnlowissue2 <= 329 => 8,
			mth_rc_ssnlowissue2 <= 389 => 7,
			mth_rc_ssnlowissue2 <= 401 => 6,
			mth_rc_ssnlowissue2 <= 437 => 5,
			mth_rc_ssnlowissue2 <= 460 => 4,
			mth_rc_ssnlowissue2 <= 484 => 3,
			mth_rc_ssnlowissue2 <= 520 => 2,
										  1);

		s1_mth_rc_ssnlowissue_m := map(
			s1_mth_rc_ssnlowissue = -1 => 0.1695435366,
			s1_mth_rc_ssnlowissue = 1  => 0.0396101855,
			s1_mth_rc_ssnlowissue = 2  => 0.0493562232,
			s1_mth_rc_ssnlowissue = 3  => 0.0554290053,
			s1_mth_rc_ssnlowissue = 4  => 0.0671267252,
			s1_mth_rc_ssnlowissue = 5  => 0.0824227287,
			s1_mth_rc_ssnlowissue = 6  => 0.0870786517,
			s1_mth_rc_ssnlowissue = 7  => 0.1170682731,
			s1_mth_rc_ssnlowissue = 8  => 0.1262226362,
			s1_mth_rc_ssnlowissue = 9  => 0.1520833333,
			s1_mth_rc_ssnlowissue = 10 => 0.2180059524,
			s1_mth_rc_ssnlowissue = 11 => 0.2470069313,
			s1_mth_rc_ssnlowissue = 12 => 0.3047619048,
			s1_mth_rc_ssnlowissue = 13 => 0.3135635222,
										  0.1597282452);

		s1_add_risk := (rc_hriskaddrflag in ['2', '4']) or StringLib.StringToUpperCase(rc_addrvalflag) = 'N' or rc_addrcommflag > (string)0 or rc_cityzipflag > (string)0 or StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add2_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y';

		s1_phone_risk := (rc_hriskphoneflag in ['3', '6']) or (rc_hphonetypeflag in ['3', '5']) or rc_hphonevalflag = (string)3;

		s1_mth_add1 := map(
			mth_add1_date_first_seen2 <= 0   => -1,
			mth_add1_date_first_seen2 <= 2   => 13,
			mth_add1_date_first_seen2 <= 6   => 12,
			mth_add1_date_first_seen2 <= 8   => 11,
			mth_add1_date_first_seen2 <= 15  => 10,
			mth_add1_date_first_seen2 <= 19  => 9,
			mth_add1_date_first_seen2 <= 32  => 8,
			mth_add1_date_first_seen2 <= 39  => 7,
			mth_add1_date_first_seen2 <= 73  => 6,
			mth_add1_date_first_seen2 <= 99  => 5,
			mth_add1_date_first_seen2 <= 156 => 4,
			mth_add1_date_first_seen2 <= 190 => 3,
			mth_add1_date_first_seen2 <= 240 => 2,
												1);

		s1_mth_add1_m := map(
			s1_mth_add1 = -1 => 0.3094867807,
			s1_mth_add1 = 1  => 0.0401814647,
			s1_mth_add1 = 2  => 0.0435914118,
			s1_mth_add1 = 3  => 0.0651315789,
			s1_mth_add1 = 4  => 0.0739856802,
			s1_mth_add1 = 5  => 0.0897519582,
			s1_mth_add1 = 6  => 0.0915615485,
			s1_mth_add1 = 7  => 0.1215505913,
			s1_mth_add1 = 8  => 0.1223832528,
			s1_mth_add1 = 9  => 0.1963267891,
			s1_mth_add1 = 10 => 0.2367534456,
			s1_mth_add1 = 11 => 0.2675044883,
			s1_mth_add1 = 12 => 0.3415819708,
			s1_mth_add1 = 13 => 0.3425468904,
								0.1597282452);

		s1_avg_lres := map(
			avg_lres <= 0   => -1,
			avg_lres <= 5   => 18,
			avg_lres <= 9   => 17,
			avg_lres <= 14  => 16,
			avg_lres <= 20  => 15,
			avg_lres <= 28  => 14,
			avg_lres <= 36  => 13,
			avg_lres <= 42  => 12,
			avg_lres <= 55  => 11,
			avg_lres <= 62  => 10,
			avg_lres <= 69  => 9,
			avg_lres <= 77  => 8,
			avg_lres <= 85  => 7,
			avg_lres <= 94  => 6,
			avg_lres <= 116 => 5,
			avg_lres <= 131 => 4,
			avg_lres <= 150 => 3,
			avg_lres <= 186 => 2,
							   1);

		s1_avg_lres_m := map(
			s1_avg_lres = -1 => 0.3372902169,
			s1_avg_lres = 1  => 0.0432060113,
			s1_avg_lres = 2  => 0.0462211118,
			s1_avg_lres = 3  => 0.0613650595,
			s1_avg_lres = 4  => 0.0633456335,
			s1_avg_lres = 5  => 0.0713379835,
			s1_avg_lres = 6  => 0.0740506329,
			s1_avg_lres = 7  => 0.0902348578,
			s1_avg_lres = 8  => 0.1029994341,
			s1_avg_lres = 9  => 0.104505632,
			s1_avg_lres = 10 => 0.104715248,
			s1_avg_lres = 11 => 0.1304623179,
			s1_avg_lres = 12 => 0.1356155365,
			s1_avg_lres = 13 => 0.1515850144,
			s1_avg_lres = 14 => 0.1641887524,
			s1_avg_lres = 15 => 0.2657657658,
			s1_avg_lres = 16 => 0.3074696005,
			s1_avg_lres = 17 => 0.3716497915,
			s1_avg_lres = 18 => 0.4433768016,
								0.1597282452);

		s1_avg_mo_per_addr := map(
			avg_mo_per_addr <= 0   => -1,
			avg_mo_per_addr <= 5   => 15,
			avg_mo_per_addr <= 9   => 14,
			avg_mo_per_addr <= 14  => 13,
			avg_mo_per_addr <= 19  => 12,
			avg_mo_per_addr <= 23  => 11,
			avg_mo_per_addr <= 31  => 10,
			avg_mo_per_addr <= 35  => 9,
			avg_mo_per_addr <= 38  => 8,
			avg_mo_per_addr <= 42  => 7,
			avg_mo_per_addr <= 47  => 6,
			avg_mo_per_addr <= 71  => 5,
			avg_mo_per_addr <= 80  => 4,
			avg_mo_per_addr <= 94  => 3,
			avg_mo_per_addr <= 147 => 2,
									  1);

		s1_avg_mo_per_addr_m := map(
			s1_avg_mo_per_addr = -1 => 0.3380782918,
			s1_avg_mo_per_addr = 1  => 0.0685714286,
			s1_avg_mo_per_addr = 2  => 0.0788653367,
			s1_avg_mo_per_addr = 3  => 0.0824108241,
			s1_avg_mo_per_addr = 4  => 0.0885182809,
			s1_avg_mo_per_addr = 5  => 0.0847029077,
			s1_avg_mo_per_addr = 6  => 0.0944017563,
			s1_avg_mo_per_addr = 7  => 0.1021984551,
			s1_avg_mo_per_addr = 8  => 0.1094127112,
			s1_avg_mo_per_addr = 9  => 0.1263641585,
			s1_avg_mo_per_addr = 10 => 0.1234966266,
			s1_avg_mo_per_addr = 11 => 0.1372110365,
			s1_avg_mo_per_addr = 12 => 0.2228132388,
			s1_avg_mo_per_addr = 13 => 0.2898648649,
			s1_avg_mo_per_addr = 14 => 0.3814102564,
			s1_avg_mo_per_addr = 15 => 0.4431438127,
									   0.1597282452);

		s1_addrs_per_ssn_c6 := min(2, if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6));

		s1_addrs_per_ssn_c6_m := map(
			s1_addrs_per_ssn_c6 = 0 => 0.1434905539,
			s1_addrs_per_ssn_c6 = 1 => 0.2991343379,
			s1_addrs_per_ssn_c6 = 2 => 0.3631123919,
									   0.1597282452);

		s1_addr_stability_v2 := max(0, min(6, if((integer1)addr_stability_v2 = NULL, -NULL, (integer1)addr_stability_v2)));

		s1_addr_stability_v2_m := map(
			s1_addr_stability_v2 = 0 => 0.3726618705,
			s1_addr_stability_v2 = 1 => 0.3011615044,
			s1_addr_stability_v2 = 2 => 0.2241758242,
			s1_addr_stability_v2 = 3 => 0.1586750789,
			s1_addr_stability_v2 = 4 => 0.1240167803,
			s1_addr_stability_v2 = 5 => 0.0934879821,
			s1_addr_stability_v2 = 6 => 0.0629152406,
										0.1597282452);

		s1mobility1 := -3.68369025 +
			s1_mth_add1_m * 2.8342245391 +
			s1_avg_lres_m * 1.5515224562 +
			s1_avg_mo_per_addr_m * 1.706025368 +
			s1_addrs_per_ssn_c6_m * 3.0482476731 +
			s1_addr_stability_v2_m * 2.0582182746;

		s1_mth_gong_did := map(
			mth_gong_did_first_seen2 <= 0  => -1,
			mth_gong_did_first_seen2 <= 8  => 7,
			mth_gong_did_first_seen2 <= 16 => 6,
			mth_gong_did_first_seen2 <= 27 => 5,
			mth_gong_did_first_seen2 <= 76 => 4,
			mth_gong_did_first_seen2 <= 85 => 3,
			mth_gong_did_first_seen2 <= 87 => 2,
											  1);

		s1_mth_gong_did_m := map(
			s1_mth_gong_did = -1 => 0.2210519981,
			s1_mth_gong_did = 1  => 0.0541082164,
			s1_mth_gong_did = 2  => 0.0728110599,
			s1_mth_gong_did = 3  => 0.0686215236,
			s1_mth_gong_did = 4  => 0.0912608836,
			s1_mth_gong_did = 5  => 0.1566920566,
			s1_mth_gong_did = 6  => 0.2033149171,
			s1_mth_gong_did = 7  => 0.3022988506,
									0.1597282452);

		s1_rc_dirsaddr_lastscore := map(
			rc_dirsaddr_lastscore = 255 => -1,
			rc_dirsaddr_lastscore < 50  => 3,
			rc_dirsaddr_lastscore < 100 => 2,
										   1);

		s1_rc_dirsaddr_lastscore_m := map(
			s1_rc_dirsaddr_lastscore = -1 => 0.1717011129,
			s1_rc_dirsaddr_lastscore = 1  => 0.1155642814,
			s1_rc_dirsaddr_lastscore = 2  => 0.1479028698,
			s1_rc_dirsaddr_lastscore = 3  => 0.2482468443,
											 0.1597282452);

		s1_add1_source_count := min(7, if(add1_source_count = NULL, -NULL, add1_source_count));

		s1_add1_source_count_m := map(
			s1_add1_source_count = 0 => 0.2897053196,
			s1_add1_source_count = 1 => 0.2572909916,
			s1_add1_source_count = 2 => 0.1874264802,
			s1_add1_source_count = 3 => 0.1246290801,
			s1_add1_source_count = 4 => 0.067178881,
			s1_add1_source_count = 5 => 0.046429715,
			s1_add1_source_count = 6 => 0.0354358611,
			s1_add1_source_count = 7 => 0.025083612,
										0.1597282452);

		s1_prop_owner := map(
			add1_naprop = 4 and prop_owned_flag and add1_family_owned                          => 0,
			add1_naprop = 4 and prop_owned_flag                                                => 1,
			add1_naprop = 4 or (add1_naprop in [3, 0]) and (prop_owned_flag or prop_sold_flag) => 2,
			add1_naprop = 3 or prop_owned_flag or prop_sold_flag                               => 3,
			add1_naprop = 2                                                                    => 3,
			add1_naprop = 0                                                                    => 4,
																								  5);

		s1_prop_owner_m := map(
			s1_prop_owner = 0 => 0.0460269214,
			s1_prop_owner = 1 => 0.0598341232,
			s1_prop_owner = 2 => 0.0658274325,
			s1_prop_owner = 3 => 0.1836937116,
			s1_prop_owner = 4 => 0.2298205154,
			s1_prop_owner = 5 => 0.2803943045,
								 0.1597282452);

		s1_rc_numelever := max(4, min(6, if(rc_numelever = NULL, -NULL, rc_numelever)));

		s1_rc_numelever_m := map(
			s1_rc_numelever = 4 => 0.28113581,
			s1_rc_numelever = 5 => 0.0953247226,
			s1_rc_numelever = 6 => 0.0523876687,
								   0.1597282452);

		s1_mortgage_risky := StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add1_mortgage_type) in ['1', '2', 'G', 'H', 'J', 'N', 'R', 'U', 'VA', 'Z']) or (StringLib.StringToUpperCase(add1_mortgage_type) in ['FHA', 'S']);

		s1_ams_class_gr := StringLib.StringToUpperCase(ams_class) = 'GR';

		s1_ams_class_sr := StringLib.StringToUpperCase(ams_class) = 'SR';

		s1_ams_college_type := map(
			(StringLib.StringToUpperCase(ams_college_type) in ['P', 'R']) => 1,
			(StringLib.StringToUpperCase(ams_college_type) in ['S'])      => 2,
																			 3);

		s1_ams_college_type_m := map(
			s1_ams_college_type = 1 => 0.0837438424,
			s1_ams_college_type = 2 => 0.1381278539,
			s1_ams_college_type = 3 => 0.1613605025,
									   0.1597282452);

		s1_ams_college_code := (ams_college_code in ['1', '4']);

		s1_ams_income_level := map(
			StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
																		-1);

		s1_ams_income_level_m := map(
			s1_ams_income_level = -1 => 0.1451900034,
			s1_ams_income_level = 1  => 0.1196388262,
			s1_ams_income_level = 2  => 0.1476793249,
			s1_ams_income_level = 3  => 0.1703056769,
			s1_ams_income_level = 5  => 0.2116488925,
			s1_ams_income_level = 6  => 0.2655991165,
			s1_ams_income_level = 7  => 0.3254847645,
			s1_ams_income_level = 8  => 0.4022988506,
										0.1597282452);

		s1ams1 := -4.306739329 +
			(integer)s1_ams_class_gr * -2.724335481 +
			(integer)s1_ams_class_sr * -1.042671358 +
			s1_ams_college_type_m * 9.4617732025 +
			(integer)s1_ams_college_code * -0.614415625 +
			s1_ams_income_level_m * 7.0973019409;

		s1_ssns_per_adl_c6 := min(2, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6));

		s1_ssns_per_adl_c6_m := map(
			s1_ssns_per_adl_c6 = 0 => 0.1470249712,
			s1_ssns_per_adl_c6 = 1 => 0.1742333871,
			s1_ssns_per_adl_c6 = 2 => 0.2921348315,
									  0.1597282452);

		s1_adls_per_addr := map(
			adls_per_addr = 0   => -2,
			adls_per_addr = 1   => -1,
			adls_per_addr <= 5  => 1,
			adls_per_addr <= 8  => 2,
			adls_per_addr <= 14 => 3,
			adls_per_addr <= 20 => 4,
								   5);

		s1_adls_per_addr_m := map(
			s1_adls_per_addr = -2 => 0.2169765166,
			s1_adls_per_addr = -1 => 0.1866783523,
			s1_adls_per_addr = 1  => 0.1024495677,
			s1_adls_per_addr = 2  => 0.1234396671,
			s1_adls_per_addr = 3  => 0.1433670434,
			s1_adls_per_addr = 4  => 0.1917711043,
			s1_adls_per_addr = 5  => 0.2453346604,
									 0.1597282452);

		s1_id_per_addr_diff := if(id_per_addr_diff < 0, -1, min(10, if(id_per_addr_diff = NULL, -NULL, id_per_addr_diff)));

		s1_id_per_addr_diff_m := map(
			s1_id_per_addr_diff = -1 => 0.1338448423,
			s1_id_per_addr_diff = 0  => 0.1575056861,
			s1_id_per_addr_diff = 1  => 0.11880216,
			s1_id_per_addr_diff = 2  => 0.1380559469,
			s1_id_per_addr_diff = 3  => 0.1474829932,
			s1_id_per_addr_diff = 4  => 0.1711208616,
			s1_id_per_addr_diff = 5  => 0.2029673591,
			s1_id_per_addr_diff = 6  => 0.2167101828,
			s1_id_per_addr_diff = 7  => 0.235443038,
			s1_id_per_addr_diff = 8  => 0.2623574144,
			s1_id_per_addr_diff = 9  => 0.2734177215,
			s1_id_per_addr_diff = 10 => 0.2835538752,
										0.1597282452);

		s1_adls_per_addr_c6 := min(7, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		s1_adls_per_addr_c6_m := map(
			s1_adls_per_addr_c6 = 0 => 0.1301742919,
			s1_adls_per_addr_c6 = 1 => 0.1852307692,
			s1_adls_per_addr_c6 = 2 => 0.1971335177,
			s1_adls_per_addr_c6 = 3 => 0.2553045859,
			s1_adls_per_addr_c6 = 4 => 0.2647619048,
			s1_adls_per_addr_c6 = 5 => 0.2842105263,
			s1_adls_per_addr_c6 = 6 => 0.3,
			s1_adls_per_addr_c6 = 7 => 0.4107142857,
									   0.1597282452);

		s1_phones_per_addr_c6 := min(3, if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6));

		s1_phones_per_addr_c6_m := map(
			s1_phones_per_addr_c6 = 0 => 0.1471825063,
			s1_phones_per_addr_c6 = 1 => 0.2030578118,
			s1_phones_per_addr_c6 = 2 => 0.253411306,
			s1_phones_per_addr_c6 = 3 => 0.2553444181,
										 0.1597282452);

		s1_estimated_income := map(
			estimated_income <= 0     => -1,
			estimated_income <= 21000 => 14,
			estimated_income <= 23000 => 13,
			estimated_income <= 24000 => 12,
			estimated_income <= 25000 => 11,
			estimated_income <= 26000 => 10,
			estimated_income <= 27000 => 9,
			estimated_income <= 29000 => 8,
			estimated_income <= 30000 => 7,
			estimated_income <= 32000 => 6,
			estimated_income <= 35000 => 5,
			estimated_income <= 41000 => 4,
			estimated_income <= 67000 => 3,
			estimated_income <= 77000 => 2,
										 1);

		s1_estimated_income_m := map(
			s1_estimated_income = -1 => 0.2516411379,
			s1_estimated_income = 1  => 0.0547904192,
			s1_estimated_income = 2  => 0.0792682927,
			s1_estimated_income = 3  => 0.0763718264,
			s1_estimated_income = 4  => 0.092597506,
			s1_estimated_income = 5  => 0.0997652582,
			s1_estimated_income = 6  => 0.1253904507,
			s1_estimated_income = 7  => 0.1312551272,
			s1_estimated_income = 8  => 0.1565693431,
			s1_estimated_income = 9  => 0.206634416,
			s1_estimated_income = 10 => 0.2319622387,
			s1_estimated_income = 11 => 0.251312336,
			s1_estimated_income = 12 => 0.26802622,
			s1_estimated_income = 13 => 0.3071841453,
			s1_estimated_income = 14 => 0.3423799582,
										0.1597282452);

		s1_state := map(
			out_st = 'AE' => 1,
			out_st = 'AS' => 1,
			out_st = 'GU' => 1,
			out_st = 'ND' => 1,
			out_st = 'IA' => 1,
			out_st = 'AK' => 1,
			out_st = 'WY' => 1,
			out_st = 'MT' => 1,
			out_st = 'WV' => 1,
			out_st = 'SD' => 1,
			out_st = 'NJ' => 2,
			out_st = 'NV' => 2,
			out_st = 'KS' => 2,
			out_st = 'PA' => 2,
			out_st = 'NM' => 2,
			out_st = 'NH' => 2,
			out_st = 'ID' => 2,
			out_st = 'PR' => 3,
			out_st = 'OR' => 3,
			out_st = 'UT' => 3,
			out_st = 'VT' => 3,
			out_st = 'HI' => 3,
			out_st = 'VA' => 3,
			out_st = 'NE' => 3,
			out_st = 'CO' => 3,
			out_st = 'WI' => 3,
			out_st = 'CT' => 3,
			out_st = 'ME' => 3,
			out_st = 'CA' => 3,
			out_st = 'IN' => 4,
			out_st = 'WA' => 4,
			out_st = 'AL' => 4,
			out_st = 'MA' => 4,
			out_st = 'KY' => 4,
			out_st = 'AR' => 4,
			out_st = 'OK' => 4,
			out_st = 'MS' => 4,
			out_st = 'GA' => 4,
			out_st = 'MN' => 4,
			out_st = 'OH' => 5,
			out_st = 'TN' => 5,
			out_st = 'NC' => 5,
			out_st = 'MO' => 5,
			out_st = 'AZ' => 5,
			out_st = 'MD' => 5,
			out_st = 'IL' => 5,
			out_st = 'RI' => 5,
			out_st = 'NY' => 5,
			out_st = 'DE' => 5,
			out_st = 'FL' => 6,
			out_st = 'SC' => 6,
			out_st = 'TX' => 6,
			out_st = 'LA' => 6,
			out_st = 'MI' => 6,
			out_st = 'DC' => 6,
			out_st = 'VI' => 6,
							 -1);

		s1_state_m := map(
			s1_state = 1 => 0.0788043478,
			s1_state = 2 => 0.1091556673,
			s1_state = 3 => 0.1342621913,
			s1_state = 4 => 0.1531514928,
			s1_state = 5 => 0.1787475087,
			s1_state = 6 => 0.2169584069,
							0.1597282452);

		s1_inq_banking_count12 := min(2, if(Inq_Banking_count12 = NULL, -NULL, Inq_Banking_count12));

		s1_inq_banking_count12_m := map(
			s1_inq_banking_count12 = 0 => 0.1492680874,
			s1_inq_banking_count12 = 1 => 0.4023614896,
			s1_inq_banking_count12 = 2 => 0.5272727273,
										  0.1597282452);

		s1_inq_ssnsperadl := min(2, if(Inq_SSNsPerADL = NULL, -NULL, Inq_SSNsPerADL));

		s1_inq_ssnsperadl_m := map(
			s1_inq_ssnsperadl = 0 => 0.1476813751,
			s1_inq_ssnsperadl = 1 => 0.3950920245,
			s1_inq_ssnsperadl = 2 => 0.5806451613,
									 0.1597282452);

		s1_inq_perssn := min(3, if(Inq_PerSSN = NULL, -NULL, Inq_PerSSN));

		s1_inq_perssn_m := map(
			s1_inq_perssn = 0 => 0.1492937385,
			s1_inq_perssn = 1 => 0.393570808,
			s1_inq_perssn = 2 => 0.4519774011,
			s1_inq_perssn = 3 => 0.593220339,
								 0.1597282452);

		s1_inq_peraddr := min(3, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr));

		s1_inq_peraddr_m := map(
			s1_inq_peraddr = 0 => 0.1438204352,
			s1_inq_peraddr = 1 => 0.3291470434,
			s1_inq_peraddr = 2 => 0.425,
			s1_inq_peraddr = 3 => 0.4837398374,
								  0.1597282452);

		s1inq2 := -2.948424369 +
			s1_inq_banking_count12_m * 1.3119561596 +
			s1_inq_ssnsperadl_m * 1.1590009277 +
			s1_inq_perssn_m * 1.3925876181 +
			s1_inq_peraddr_m * 3.9389178844;

		s103 := -2.882142122 +
			s1derog3 * 0.5023854185 +
			s1_mth_rc_ssnlowissue_m * 0.748234074 +
			(integer)s1_add_risk * 0.1718048152 +
			(integer)s1_phone_risk * 0.3779644631 +
			s1mobility1 * 0.1481373895 +
			s1_mth_gong_did_m * 1.1616230215 +
			s1_rc_dirsaddr_lastscore_m * 1.3129058433 +
			s1_add1_source_count_m * 0.9122022644 +
			s1_prop_owner_m * 1.8013942076 +
			(integer)ver_src_p * -0.163920249 +
			s1_rc_numelever_m * 0.5108770299 +
			(integer)s1_mortgage_risky * 0.3034661384 +
			s1ams1 * 0.4014435725 +
			s1_ssns_per_adl_c6_m * 5.0137300643 +
			s1_adls_per_addr_m * 1.417419633 +
			s1_id_per_addr_diff_m * 1.2053378207 +
			s1_adls_per_addr_c6_m * 2.3915287985 +
			s1_phones_per_addr_c6_m * 1.8315731123 +
			s1_estimated_income_m * 1.3976547833 +
			s1inq2 * 0.4520928347 +
			s1_state_m * 2.5237400117;

		s2_add_risk := StringLib.StringToUpperCase(rc_addrvalflag) != 'V' or StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y' or StringLib.StringToUpperCase(add1_advo_drop) = 'Y';

		s2_phone_risk := (rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonevalflag in ['0', '1', '4']) or (rc_pwphonezipflag in ['1', '4']) or (telcordia_type in ['04', '65']) or StringLib.StringToUpperCase(nap_status) = 'D';

		s2_addrs_per_ssn := min(4, if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn));

		s2_addrs_per_ssn_m := map(
			s2_addrs_per_ssn = 0 => 0.0648689901,
			s2_addrs_per_ssn = 1 => 0.0541066563,
			s2_addrs_per_ssn = 2 => 0.09375,
			s2_addrs_per_ssn = 3 => 0.1094420601,
			s2_addrs_per_ssn = 4 => 0.1285956007,
									0.0648936676);

		s2_infutor := infutor_nap > 0;

		s2_rc_dirsaddr_lastscore := map(
			rc_dirsaddr_lastscore < 50  => 3,
			rc_dirsaddr_lastscore < 90  => 2,
			rc_dirsaddr_lastscore < 100 => 1,
			rc_dirsaddr_lastscore = 100 => 0,
										   -1);

		s2_rc_dirsaddr_lastscore_m := map(
			s2_rc_dirsaddr_lastscore = -1 => 0.0831989681,
			s2_rc_dirsaddr_lastscore = 0  => 0.0448014721,
			s2_rc_dirsaddr_lastscore = 1  => 0.0796460177,
			s2_rc_dirsaddr_lastscore = 2  => 0.1005586592,
			s2_rc_dirsaddr_lastscore = 3  => 0.1306148455,
											 0.0648936676);

		s2_naprop := map(
			add1_naprop = 4 => 1,
			add1_naprop = 3 => 1,
			add1_naprop = 0 => 2,
			add1_naprop = 2 => 3,
							   3);

		s2_naprop_m := map(
			s2_naprop = 1 => 0.0409259125,
			s2_naprop = 2 => 0.0729247479,
			s2_naprop = 3 => 0.1313304721,
							 0.0648936676);

		s2_add1_assessedvalue := map(
			(integer)add1_avm_assessed_total_value <= 0      => -1,
			(integer)add1_avm_assessed_total_value <= 24495  => 7,
			(integer)add1_avm_assessed_total_value <= 32580  => 6,
			(integer)add1_avm_assessed_total_value <= 41005  => 5,
			(integer)add1_avm_assessed_total_value <= 93100  => 4,
			(integer)add1_avm_assessed_total_value <= 105400 => 3,
			(integer)add1_avm_assessed_total_value <= 248200 => 2,
															   1);

		s2_add1_assessedvalue_m := map(
			s2_add1_assessedvalue = -1 => 0.0635057782,
			s2_add1_assessedvalue = 1  => 0.0391378332,
			s2_add1_assessedvalue = 2  => 0.0518707483,
			s2_add1_assessedvalue = 3  => 0.0595238095,
			s2_add1_assessedvalue = 4  => 0.0677245679,
			s2_add1_assessedvalue = 5  => 0.0867346939,
			s2_add1_assessedvalue = 6  => 0.0952380952,
			s2_add1_assessedvalue = 7  => 0.1215986395,
										  0.0648936676);

		s2_add1_avm_med := map(
			add1_avm_med <= 0      => -1,
			add1_avm_med <= 63984  => 7,
			add1_avm_med <= 81500  => 6,
			add1_avm_med <= 96000  => 5,
			add1_avm_med <= 377000 => 4,
			add1_avm_med <= 440500 => 3,
			add1_avm_med <= 568500 => 2,
									  1);

		s2_add1_avm_med_m := map(
			s2_add1_avm_med = -1 => 0.0365546218,
			s2_add1_avm_med = 1  => 0.0557939914,
			s2_add1_avm_med = 2  => 0.063304721,
			s2_add1_avm_med = 3  => 0.0675965665,
			s2_add1_avm_med = 4  => 0.0578632741,
			s2_add1_avm_med = 5  => 0.0987124464,
			s2_add1_avm_med = 6  => 0.1122994652,
			s2_add1_avm_med = 7  => 0.1627155172,
									0.0648936676);

		s2_buildingarea := map(
			(integer)add1_building_area <= 0    => -1,
			(integer)add1_building_area <= 1043 => 10,
			(integer)add1_building_area <= 1209 => 9,
			(integer)add1_building_area <= 1372 => 8,
			(integer)add1_building_area <= 1539 => 7,
			(integer)add1_building_area <= 1721 => 6,
			(integer)add1_building_area <= 1920 => 5,
			(integer)add1_building_area <= 2150 => 4,
			(integer)add1_building_area <= 2452 => 3,
			(integer)add1_building_area <= 2958 => 2,
												  1);

		s2_buildingarea_m := map(
			s2_buildingarea = -1 => 0.0575579771,
			s2_buildingarea = 1  => 0.0310469314,
			s2_buildingarea = 2  => 0.0324675325,
			s2_buildingarea = 3  => 0.0375722543,
			s2_buildingarea = 4  => 0.0433839479,
			s2_buildingarea = 5  => 0.0681981335,
			s2_buildingarea = 6  => 0.0684931507,
			s2_buildingarea = 7  => 0.0794223827,
			s2_buildingarea = 8  => 0.0950323974,
			s2_buildingarea = 9  => 0.0988455988,
			s2_buildingarea = 10 => 0.1323210412,
									0.0648936676);

		s2_add1_2story := add1_no_of_stories = (string)2;

		s2_econtrj := if(_econtrj = -1, -1, max(2, min(5, if(_econtrj = NULL, -NULL, _econtrj))));

		s2_econtrj_m := map(
			s2_econtrj = -1 => 0.0366470093,
			s2_econtrj = 2  => 0.0522540984,
			s2_econtrj = 3  => 0.0571738737,
			s2_econtrj = 4  => 0.0973949082,
			s2_econtrj = 5  => 0.126848249,
							   0.0648936676);

		s2_mortgage_risky := StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add1_mortgage_type) in ['1', '2', 'G', 'J', 'N', 'U']) or (StringLib.StringToUpperCase(add1_mortgage_type) in ['FHA', 'H', 'S']);

		s2_adls_per_addr := map(
			adls_per_addr = 0   => -2,
			adls_per_addr = 1   => -1,
			adls_per_addr <= 9  => 1,
			adls_per_addr <= 15 => 2,
			adls_per_addr <= 20 => 3,
								   4);

		s2_adls_per_addr_m := map(
			s2_adls_per_addr = -2 => 0.1318181818,
			s2_adls_per_addr = -1 => 0.0613496933,
			s2_adls_per_addr = 1  => 0.0361334675,
			s2_adls_per_addr = 2  => 0.072156543,
			s2_adls_per_addr = 3  => 0.1227735369,
			s2_adls_per_addr = 4  => 0.161452514,
									 0.0648936676);

		s2_adls_per_addr_c6 := min(5, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		s2_adls_per_addr_c6_m := map(
			s2_adls_per_addr_c6 = 0 => 0.0527448012,
			s2_adls_per_addr_c6 = 1 => 0.0721608833,
			s2_adls_per_addr_c6 = 2 => 0.0796420582,
			s2_adls_per_addr_c6 = 3 => 0.1292875989,
			s2_adls_per_addr_c6 = 4 => 0.1466165414,
			s2_adls_per_addr_c6 = 5 => 0.1532846715,
									   0.0648936676);

		s2_phones_per_addr := min(4, if(phones_per_addr = NULL, -NULL, phones_per_addr));

		s2_phones_per_addr_m := map(
			s2_phones_per_addr = 0 => 0.077316152,
			s2_phones_per_addr = 1 => 0.0505178452,
			s2_phones_per_addr = 2 => 0.0972644377,
			s2_phones_per_addr = 3 => 0.1129476584,
			s2_phones_per_addr = 4 => 0.1381578947,
									  0.0648936676);

		s2_estimated_income := map(
			estimated_income <= 0     => -1,
			estimated_income <= 19999 => 8,
			estimated_income <= 20000 => 7,
			estimated_income <= 21000 => 6,
			estimated_income <= 22000 => 5,
			estimated_income <= 28000 => 4,
			estimated_income <= 30000 => 3,
			estimated_income <= 36000 => 2,
										 1);

		s2_estimated_income_m := map(
			s2_estimated_income = -1 => 0.1409090909,
			s2_estimated_income = 1  => 0.0244835501,
			s2_estimated_income = 2  => 0.030867222,
			s2_estimated_income = 3  => 0.0359195402,
			s2_estimated_income = 4  => 0.0438176782,
			s2_estimated_income = 5  => 0.0596107056,
			s2_estimated_income = 6  => 0.0860103627,
			s2_estimated_income = 7  => 0.1056751468,
			s2_estimated_income = 8  => 0.1312849162,
										0.0648936676);

		s2_inq_peraddr := min(2, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr));

		s2_inq_peraddr_m := map(
			s2_inq_peraddr = 0 => 0.0599258344,
			s2_inq_peraddr = 1 => 0.1745068285,
			s2_inq_peraddr = 2 => 0.2740740741,
								  0.0648936676);

		s2_other_risk := did_count != 1 or (rc_ssnstate in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'GS']) or (integer)rc_altlname1_flag = 1 or (integer)rc_altlname2_flag = 1 or email_count > 2 or (integer)rc_watchlist_flag = 1 or Inq_count12 > 0;

		s204 := -6.756208815 +
			(integer)s2_add_risk * 0.4975101094 +
			(integer)s2_phone_risk * 0.4264374617 +
			s2_addrs_per_ssn_m * 8.064754192 +
			(integer)s2_infutor * 0.4443758157 +
			s2_rc_dirsaddr_lastscore_m * 2.6331377538 +
			s2_naprop_m * 4.1945096121 +
			s2_add1_assessedvalue_m * 3.1994316575 +
			s2_add1_avm_med_m * 3.3697830489 +
			s2_buildingarea_m * 5.3498740687 +
			(integer)s2_add1_2story * -0.25252399 +
			s2_econtrj_m * 4.7496524817 +
			(integer)s2_mortgage_risky * 0.4792205346 +
			s2_adls_per_addr_m * 6.215317836 +
			s2_adls_per_addr_c6_m * 5.6724367476 +
			s2_phones_per_addr_m * 5.0213739189 +
			s2_estimated_income_m * 3.9695433575 +
			s2_inq_peraddr_m * 5.5134000041 +
			(integer)s2_other_risk * 0.2668165968;

		s3_phone_risk := (rc_hphonevalflag in ['4', '5']) or (rc_phonevalflag in ['1', '3']) or (telcordia_type in ['04', '50', '51', '52']) or (rc_hriskphoneflag in ['1', '2', '3', '4', '5', '6']) or StringLib.StringToUpperCase(nap_status) = 'D';

		s3_avg_lres := map(
			avg_lres <= 0  => -1,
			avg_lres <= 16 => 6,
			avg_lres <= 26 => 4,
			avg_lres <= 29 => 3,
			avg_lres <= 45 => 2,
							  1);

		s3_avg_lres_m := map(
			s3_avg_lres = -1 => 0.0573725978,
			s3_avg_lres = 1  => 0.043062201,
			s3_avg_lres = 2  => 0.0544692737,
			s3_avg_lres = 3  => 0.0558882236,
			s3_avg_lres = 4  => 0.064702788,
			s3_avg_lres = 6  => 0.0852844701,
								0.0609453272);

		s3_addrs_per_adl := min(7, if(addrs_per_adl = NULL, -NULL, addrs_per_adl));

		s3_addrs_per_adl_m := map(
			s3_addrs_per_adl = 1 => 0.0375144996,
			s3_addrs_per_adl = 2 => 0.0756167718,
			s3_addrs_per_adl = 3 => 0.1030349158,
			s3_addrs_per_adl = 4 => 0.1118577075,
			s3_addrs_per_adl = 5 => 0.1423001949,
			s3_addrs_per_adl = 6 => 0.1612903226,
			s3_addrs_per_adl = 7 => 0.1666666667,
									0.0609453272);

		s3_addrs_per_ssn := min(8, if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn));

		s3_addrs_per_ssn_m := map(
			s3_addrs_per_ssn = 0 => 0.0513554886,
			s3_addrs_per_ssn = 1 => 0.0355292738,
			s3_addrs_per_ssn = 2 => 0.0656465187,
			s3_addrs_per_ssn = 3 => 0.088485464,
			s3_addrs_per_ssn = 4 => 0.1086495404,
			s3_addrs_per_ssn = 5 => 0.1181598063,
			s3_addrs_per_ssn = 6 => 0.1183035714,
			s3_addrs_per_ssn = 7 => 0.1398416887,
			s3_addrs_per_ssn = 8 => 0.1408450704,
									0.0609453272);

		s3_unique_addr_count := min(3, if(unique_addr_count = NULL, -NULL, unique_addr_count));

		s3_unique_addr_count_m := map(
			s3_unique_addr_count = 0 => 0.0974116337,
			s3_unique_addr_count = 1 => 0.050515601,
			s3_unique_addr_count = 2 => 0.0842166121,
			s3_unique_addr_count = 3 => 0.0948275862,
										0.0609453272);

		s3_attr_addrs_last30 := min(1, if(attr_addrs_last30 = NULL, -NULL, attr_addrs_last30));

		s3_attr_addrs_last30_m := map(
			s3_attr_addrs_last30 = 0 => 0.0603748307,
			s3_attr_addrs_last30 = 1 => 0.1002004008,
										0.0609453272);

		s3mobility2 := -5.670985534 +
			s3_avg_lres_m * 16.550571567 +
			s3_addrs_per_adl_m * 9.5212629129 +
			s3_addrs_per_ssn_m * 7.6058956376 +
			s3_unique_addr_count_m * 5.2823309191 +
			s3_attr_addrs_last30_m * 7.2980383078;

		s3_mth_gong_did := map(
			mth_gong_did_first_seen2 <= 0  => -1,
			mth_gong_did_first_seen2 <= 5  => 12,
			mth_gong_did_first_seen2 <= 7  => 11,
			mth_gong_did_first_seen2 <= 9  => 10,
			mth_gong_did_first_seen2 <= 24 => 9,
			mth_gong_did_first_seen2 <= 30 => 8,
			mth_gong_did_first_seen2 <= 43 => 7,
			mth_gong_did_first_seen2 <= 54 => 6,
			mth_gong_did_first_seen2 <= 56 => 5,
			mth_gong_did_first_seen2 <= 76 => 4,
			mth_gong_did_first_seen2 <= 86 => 3,
			mth_gong_did_first_seen2 <= 87 => 2,
											  1);

		s3_mth_gong_did_m := map(
			s3_mth_gong_did = -1 => 0.056908311,
			s3_mth_gong_did = 1  => 0.0377358491,
			s3_mth_gong_did = 2  => 0.0595238095,
			s3_mth_gong_did = 3  => 0.0487804878,
			s3_mth_gong_did = 4  => 0.0594059406,
			s3_mth_gong_did = 5  => 0.0887850467,
			s3_mth_gong_did = 6  => 0.0792682927,
			s3_mth_gong_did = 7  => 0.0928433269,
			s3_mth_gong_did = 8  => 0.1447963801,
			s3_mth_gong_did = 9  => 0.141347424,
			s3_mth_gong_did = 10 => 0.1659574468,
			s3_mth_gong_did = 11 => 0.256281407,
			s3_mth_gong_did = 12 => 0.2485436893,
									0.0609453272);

		s3_rc_dirsaddr_lastscore := map(
			rc_dirsaddr_lastscore = 255 => -1,
			rc_dirsaddr_lastscore = 100 => 1,
			rc_dirsaddr_lastscore >= 70 => 2,
										   3);

		s3_rc_dirsaddr_lastscore_m := map(
			s3_rc_dirsaddr_lastscore = -1 => 0.0773904039,
			s3_rc_dirsaddr_lastscore = 1  => 0.0425981942,
			s3_rc_dirsaddr_lastscore = 2  => 0.0718050066,
			s3_rc_dirsaddr_lastscore = 3  => 0.1178715067,
											 0.0609453272);

		s3_add1_source_count := min(2, if(add1_source_count = NULL, -NULL, add1_source_count));

		s3_add1_source_count_m := map(
			s3_add1_source_count = 0 => 0.1147331416,
			s3_add1_source_count = 1 => 0.0892022209,
			s3_add1_source_count = 2 => 0.0463970396,
										0.0609453272);

		s3_naprop := map(
			add1_naprop = 4 => 1,
			add1_naprop = 3 => 1,
			add1_naprop = 2 => 3,
			add1_naprop = 0 => 2,
							   3);

		s3_naprop_m := map(
			s3_naprop = 1 => 0.0366508766,
			s3_naprop = 2 => 0.0833010961,
			s3_naprop = 3 => 0.110034078,
							 0.0609453272);

		s3_minor_src_ver := max((integer)ver_src_ak, (integer)ver_src_am, (integer)ver_src_eb, (integer)ver_src_nas_e1 > 5, (integer)ver_src_e3, (integer)ver_src_pl, (integer)ver_src_w, (integer)watercraft_count > 0, (integer)prof_license_flag, (integer)attr_num_aircraft > 0);

		s3_minor_src_ver_i := map(
			s3_minor_src_ver > 0                                                                                  => 0,
			ver_src_nas_e2 > 5 or ver_src_nas_e4 > 5 or ver_src_p or ver_src_nas_vo > 5 or PAW_Business_count > 0 => 1,
																													 2);

		s3_minor_src_ver_i_m := map(
			s3_minor_src_ver_i = 0 => 0.0331695332,
			s3_minor_src_ver_i = 1 => 0.044056669,
			s3_minor_src_ver_i = 2 => 0.0636403587,
									  0.0609453272);

		s3_add1_assessedvalue := map(
			(integer)add1_avm_assessed_total_value <= 0      => -1,
			(integer)add1_avm_assessed_total_value <= 18230  => 11,
			(integer)add1_avm_assessed_total_value <= 28520  => 10,
			(integer)add1_avm_assessed_total_value <= 89875  => 9,
			(integer)add1_avm_assessed_total_value <= 115885 => 8,
			(integer)add1_avm_assessed_total_value <= 130955 => 7,
			(integer)add1_avm_assessed_total_value <= 146650 => 6,
			(integer)add1_avm_assessed_total_value <= 248820 => 5,
			(integer)add1_avm_assessed_total_value <= 291085 => 4,
			(integer)add1_avm_assessed_total_value <= 348449 => 3,
			(integer)add1_avm_assessed_total_value <= 446851 => 2,
															   1);

		s3_add1_assessedvalue_m := map(
			s3_add1_assessedvalue = -1 => 0.0688590116,
			s3_add1_assessedvalue = 1  => 0.0160565189,
			s3_add1_assessedvalue = 2  => 0.0205523443,
			s3_add1_assessedvalue = 3  => 0.0269749518,
			s3_add1_assessedvalue = 4  => 0.0385356455,
			s3_add1_assessedvalue = 5  => 0.0394990366,
			s3_add1_assessedvalue = 6  => 0.0455712452,
			s3_add1_assessedvalue = 7  => 0.053915276,
			s3_add1_assessedvalue = 8  => 0.0562158689,
			s3_add1_assessedvalue = 9  => 0.0611218155,
			s3_add1_assessedvalue = 10 => 0.0860629416,
			s3_add1_assessedvalue = 11 => 0.098265896,
										  0.0609453272);

		s3_add1_avm := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 60456  => 15,
			add1_avm_automated_valuation <= 81566  => 14,
			add1_avm_automated_valuation <= 96823  => 13,
			add1_avm_automated_valuation <= 111399 => 12,
			add1_avm_automated_valuation <= 125643 => 11,
			add1_avm_automated_valuation <= 140000 => 10,
			add1_avm_automated_valuation <= 168657 => 9,
			add1_avm_automated_valuation <= 183977 => 8,
			add1_avm_automated_valuation <= 219947 => 7,
			add1_avm_automated_valuation <= 240167 => 6,
			add1_avm_automated_valuation <= 286947 => 5,
			add1_avm_automated_valuation <= 317335 => 4,
			add1_avm_automated_valuation <= 353016 => 3,
			add1_avm_automated_valuation <= 593783 => 2,
													  1);

		s3_add1_avm_m := map(
			s3_add1_avm = -1 => 0.0687380721,
			s3_add1_avm = 1  => 0.0271356784,
			s3_add1_avm = 2  => 0.02680067,
			s3_add1_avm = 3  => 0.0346733668,
			s3_add1_avm = 4  => 0.0391959799,
			s3_add1_avm = 5  => 0.0414468726,
			s3_add1_avm = 6  => 0.0422110553,
			s3_add1_avm = 7  => 0.0439698492,
			s3_add1_avm = 8  => 0.0522613065,
			s3_add1_avm = 9  => 0.0521148036,
			s3_add1_avm = 10 => 0.0550275138,
			s3_add1_avm = 11 => 0.0628140704,
			s3_add1_avm = 12 => 0.0733668342,
			s3_add1_avm = 13 => 0.0899497487,
			s3_add1_avm = 14 => 0.1216080402,
			s3_add1_avm = 15 => 0.148241206,
								0.0609453272);

		s3_add2_salesprice := map(
			(integer)add2_avm_sales_price <= 0      => -1,
			(integer)add2_avm_sales_price <= 24500  => 9,
			(integer)add2_avm_sales_price <= 75000  => 8,
			(integer)add2_avm_sales_price <= 92000  => 7,
			(integer)add2_avm_sales_price <= 115000 => 6,
			(integer)add2_avm_sales_price <= 163900 => 5,
			(integer)add2_avm_sales_price <= 201500 => 4,
			(integer)add2_avm_sales_price <= 269999 => 3,
			(integer)add2_avm_sales_price <= 428000 => 2,
													  1);

		s3_add2_salesprice_m := map(
			s3_add2_salesprice = -1 => 0.0580805695,
			s3_add2_salesprice = 1  => 0.0422077922,
			s3_add2_salesprice = 2  => 0.0664505673,
			s3_add2_salesprice = 3  => 0.0614886731,
			s3_add2_salesprice = 4  => 0.0696920583,
			s3_add2_salesprice = 5  => 0.0704918033,
			s3_add2_salesprice = 6  => 0.0988835726,
			s3_add2_salesprice = 7  => 0.1198003328,
			s3_add2_salesprice = 8  => 0.1229050279,
			s3_add2_salesprice = 9  => 0.1580645161,
									   0.0609453272);

		s3_add2_avm := map(
			add2_avm_automated_valuation <= 0      => -1,
			add2_avm_automated_valuation <= 46750  => 10,
			add2_avm_automated_valuation <= 64900  => 9,
			add2_avm_automated_valuation <= 90204  => 8,
			add2_avm_automated_valuation <= 115174 => 7,
			add2_avm_automated_valuation <= 275444 => 6,
			add2_avm_automated_valuation <= 313558 => 5,
			add2_avm_automated_valuation <= 361000 => 4,
			add2_avm_automated_valuation <= 429900 => 3,
			add2_avm_automated_valuation <= 572400 => 2,
													  1);

		s3_add2_avm_m := map(
			s3_add2_avm = -1 => 0.0556548464,
			s3_add2_avm = 1  => 0.0510204082,
			s3_add2_avm = 2  => 0.0612244898,
			s3_add2_avm = 3  => 0.0653061224,
			s3_add2_avm = 4  => 0.0693877551,
			s3_add2_avm = 5  => 0.0775510204,
			s3_add2_avm = 6  => 0.0798185941,
			s3_add2_avm = 7  => 0.112244898,
			s3_add2_avm = 8  => 0.1402439024,
			s3_add2_avm = 9  => 0.1522633745,
			s3_add2_avm = 10 => 0.1653061224,
								0.0609453272);

		s3_add3_assessedvalue := map(
			add3_assessed_total_value <= 0      => -1,
			add3_assessed_total_value <= 47945  => 6,
			add3_assessed_total_value <= 94230  => 5,
			add3_assessed_total_value <= 122900 => 4,
			add3_assessed_total_value <= 215100 => 3,
			add3_assessed_total_value <= 352076 => 2,
												   1);

		s3_add3_assessedvalue_m := map(
			s3_add3_assessedvalue = -1 => 0.0571657375,
			s3_add3_assessedvalue = 1  => 0.0655391121,
			s3_add3_assessedvalue = 2  => 0.0949367089,
			s3_add3_assessedvalue = 3  => 0.0950369588,
			s3_add3_assessedvalue = 4  => 0.111814346,
			s3_add3_assessedvalue = 5  => 0.1235480465,
			s3_add3_assessedvalue = 6  => 0.1394366197,
										  0.0609453272);

		s3_add3_avm := map(
			add3_avm_automated_valuation <= 0      => -1,
			add3_avm_automated_valuation <= 59845  => 8,
			add3_avm_automated_valuation <= 109559 => 7,
			add3_avm_automated_valuation <= 131991 => 6,
			add3_avm_automated_valuation <= 191575 => 5,
			add3_avm_automated_valuation <= 235714 => 4,
			add3_avm_automated_valuation <= 299900 => 3,
			add3_avm_automated_valuation <= 405847 => 2,
													  1);

		s3_add3_avm_m := map(
			s3_add3_avm = -1 => 0.0571840388,
			s3_add3_avm = 1  => 0.0771276596,
			s3_add3_avm = 2  => 0.0928381963,
			s3_add3_avm = 3  => 0.1093333333,
			s3_add3_avm = 4  => 0.1143617021,
			s3_add3_avm = 5  => 0.1103723404,
			s3_add3_avm = 6  => 0.1356382979,
			s3_add3_avm = 7  => 0.1551724138,
			s3_add3_avm = 8  => 0.2091152815,
								0.0609453272);

		s3_add1_avm_med := map(
			add1_avm_med <= 0      => -1,
			add1_avm_med <= 58432  => 13,
			add1_avm_med <= 76200  => 12,
			add1_avm_med <= 89837  => 11,
			add1_avm_med <= 102225 => 10,
			add1_avm_med <= 114944 => 9,
			add1_avm_med <= 126062 => 8,
			add1_avm_med <= 138006 => 7,
			add1_avm_med <= 161771 => 6,
			add1_avm_med <= 230000 => 5,
			add1_avm_med <= 279922 => 4,
			add1_avm_med <= 316358 => 3,
			add1_avm_med <= 356700 => 2,
									  1);

		s3_add1_avm_med_m := map(
			s3_add1_avm_med = -1 => 0.0502062793,
			s3_add1_avm_med = 1  => 0.0426300578,
			s3_add1_avm_med = 2  => 0.0472924188,
			s3_add1_avm_med = 3  => 0.0476878613,
			s3_add1_avm_med = 4  => 0.0502439906,
			s3_add1_avm_med = 5  => 0.052089916,
			s3_add1_avm_med = 6  => 0.0577930287,
			s3_add1_avm_med = 7  => 0.059588299,
			s3_add1_avm_med = 8  => 0.0639219935,
			s3_add1_avm_med = 9  => 0.0740874593,
			s3_add1_avm_med = 10 => 0.0812861272,
			s3_add1_avm_med = 11 => 0.0916967509,
			s3_add1_avm_med = 12 => 0.1159682081,
			s3_add1_avm_med = 13 => 0.1405346821,
									0.0609453272);

		s3_buildingarea := map(
			(integer)add1_building_area <= 0    => -1,
			(integer)add1_building_area <= 1100 => 10,
			(integer)add1_building_area <= 1295 => 9,
			(integer)add1_building_area <= 1470 => 8,
			(integer)add1_building_area <= 1653 => 7,
			(integer)add1_building_area <= 1854 => 6,
			(integer)add1_building_area <= 2065 => 5,
			(integer)add1_building_area <= 2312 => 4,
			(integer)add1_building_area <= 2627 => 3,
			(integer)add1_building_area <= 3169 => 2,
												  1);

		s3_buildingarea_m := map(
			s3_buildingarea = -1 => 0.0667110473,
			s3_buildingarea = 1  => 0.0308701993,
			s3_buildingarea = 2  => 0.0323522257,
			s3_buildingarea = 3  => 0.0343316289,
			s3_buildingarea = 4  => 0.0352112676,
			s3_buildingarea = 5  => 0.0469586375,
			s3_buildingarea = 6  => 0.0546116505,
			s3_buildingarea = 7  => 0.0649477013,
			s3_buildingarea = 8  => 0.0756730536,
			s3_buildingarea = 9  => 0.0817272505,
			s3_buildingarea = 10 => 0.1127582017,
									0.0609453272);

		s3_add1_avm_to_med_ratio := map(
			add1_avm_to_med_ratio = NULL  => -1,
			add1_avm_to_med_ratio <= 0.50 => 7,
			add1_avm_to_med_ratio <= 0.75 => 6,
			add1_avm_to_med_ratio <= 1    => 5,
			add1_avm_to_med_ratio <= 1.25 => 4,
											 1);

		s3_add1_avm_to_med_ratio_m := map(
			s3_add1_avm_to_med_ratio = -1 => 0.0686933547,
			s3_add1_avm_to_med_ratio = 1  => 0.0384159589,
			s3_add1_avm_to_med_ratio = 4  => 0.0504485164,
			s3_add1_avm_to_med_ratio = 5  => 0.0652057314,
			s3_add1_avm_to_med_ratio = 6  => 0.0778885197,
			s3_add1_avm_to_med_ratio = 7  => 0.0989272944,
											 0.0609453272);

		// s3_add1_bath_36 := (string)3 <= add1_no_of_baths AND add1_no_of_baths <= (string)6;
		s3_add1_bath_36 := (integer)add1_no_of_baths BETWEEN 3 AND 6;

		s3_add1_no_of_partial_baths := add1_no_of_partial_baths > (string)0;

		s3avm1 := -5.933499524 +
			s3_add1_assessedvalue_m * 5.9141970339 +
			s3_add1_avm_m * 2.803804839 +
			s3_add2_salesprice_m * 5.1582229488 +
			s3_add2_avm_m * 4.9668978474 +
			s3_add3_assessedvalue_m * 4.9628945705 +
			s3_add3_avm_m * 5.1744421763 +
			s3_add1_avm_med_m * 7.384558633 +
			s3_buildingarea_m * 8.3735495212 +
			s3_add1_avm_to_med_ratio_m * 6.7697199734 +
			(integer)s3_add1_bath_36 * -0.267116894 +
			(integer)s3_add1_no_of_partial_baths * -0.377255226;

		s3_mortgage_risky := StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add1_mortgage_type) in ['1', '2', 'G', 'H', 'N', 'R', 'U']) or (StringLib.StringToUpperCase(add1_mortgage_type) in ['FHA', 'S']) or (StringLib.StringToUpperCase(add2_mortgage_type) in ['FHA', 'H']) or StringLib.StringToUpperCase(add2_financing_type) = 'ADJ' or (StringLib.StringToUpperCase(add3_mortgage_type) in ['FHA', 'H']) or StringLib.StringToUpperCase(add3_financing_type) = 'ADJ';

		s3_econtrj := if(_econtrj = -1, -1, max(3, min(5, if(_econtrj = NULL, -NULL, _econtrj))));

		s3_econtrj_m := map(
			s3_econtrj = -1 => 0.0489651691,
			s3_econtrj = 3  => 0.0554411185,
			s3_econtrj = 4  => 0.0844115061,
			s3_econtrj = 5  => 0.1103151862,
							   0.0609453272);

		s3_ams_class_high := (StringLib.StringToUpperCase(ams_class) in ['GR', 'SR', 'JR']);

		s3_ams_college_tier := map(
			ams_college_tier = (string)0 => 4,
			ams_college_tier = (string)1 => 1,
			ams_college_tier = (string)2 => 2,
			ams_college_tier = (string)3 => 3,
			ams_college_tier = (string)4 => 4,
			ams_college_tier = (string)5 => 5,
			ams_college_tier = (string)6 => 6,
											-1);

		s3_ams_college_tier_m := map(
			s3_ams_college_tier = -1 => 0.0937331496,
			s3_ams_college_tier = 1  => 0,
			s3_ams_college_tier = 2  => 0.0049358342,
			s3_ams_college_tier = 3  => 0.00967708,
			s3_ams_college_tier = 4  => 0.0240954812,
			s3_ams_college_tier = 5  => 0.0525435074,
			s3_ams_college_tier = 6  => 0.0935162095,
										0.0609453272);

		s3_ams_income_level := map(
			StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 10,
			StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 10,
			StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 4,
			StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
																		-1);

		s3_ams_income_level_m := map(
			s3_ams_income_level = -1 => 0.0860976519,
			s3_ams_income_level = 1  => 0.021066108,
			s3_ams_income_level = 2  => 0.0302267003,
			s3_ams_income_level = 3  => 0.0350836964,
			s3_ams_income_level = 4  => 0.03737646,
			s3_ams_income_level = 5  => 0.0488346282,
			s3_ams_income_level = 6  => 0.0545302013,
			s3_ams_income_level = 7  => 0.0696879008,
			s3_ams_income_level = 8  => 0.0828220859,
			s3_ams_income_level = 9  => 0.1214689266,
			s3_ams_income_level = 10 => 0.1674311927,
										0.0609453272);

		s3ams2 := -4.754787896 +
			(integer)s3_ams_class_high * -1.392238956 +
			s3_ams_college_tier_m * 17.745547368 +
			s3_ams_income_level_m * 11.763401624;

		s3_adlperssn := max(1, min(4, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		s3_adlperssn_m := map(
			s3_adlperssn = 1 => 0.0578012657,
			s3_adlperssn = 2 => 0.0795397699,
			s3_adlperssn = 3 => 0.0876048462,
			s3_adlperssn = 4 => 0.1134453782,
								0.0609453272);

		s3_adls_per_addr := map(
			adls_per_addr = 0   => -3,
			adls_per_addr = 1   => -2,
			adls_per_addr = 2   => -1,
			adls_per_addr <= 6  => 1,
			adls_per_addr <= 9  => 2,
			adls_per_addr <= 15 => 3,
			adls_per_addr <= 20 => 4,
								   5);

		s3_adls_per_addr_m := map(
			s3_adls_per_addr = -3 => 0.1086280057,
			s3_adls_per_addr = -2 => 0.0909090909,
			s3_adls_per_addr = -1 => 0.0559006211,
			s3_adls_per_addr = 1  => 0.0330452948,
			s3_adls_per_addr = 2  => 0.0435418256,
			s3_adls_per_addr = 3  => 0.0632456852,
			s3_adls_per_addr = 4  => 0.098387389,
			s3_adls_per_addr = 5  => 0.1477477477,
									 0.0609453272);

		s3_id_per_addr_diff := map(
			id_per_addr_diff <= -1 => -1,
			id_per_addr_diff <= 2  => 1,
									  min(9, if(id_per_addr_diff = NULL, -NULL, id_per_addr_diff)));

		s3_id_per_addr_diff_m := map(
			s3_id_per_addr_diff = -1 => 0.0988593156,
			s3_id_per_addr_diff = 1  => 0.0498558119,
			s3_id_per_addr_diff = 3  => 0.0510290148,
			s3_id_per_addr_diff = 4  => 0.0609665428,
			s3_id_per_addr_diff = 5  => 0.0677797655,
			s3_id_per_addr_diff = 6  => 0.0959322034,
			s3_id_per_addr_diff = 7  => 0.1089855072,
			s3_id_per_addr_diff = 8  => 0.1244522349,
			s3_id_per_addr_diff = 9  => 0.1496097138,
										0.0609453272);

		s3_adls_per_addr_c6_1 := min(6, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		s3_adls_per_addr_c6 := if(s3_adls_per_addr_c6_1 = 3, 2, s3_adls_per_addr_c6_1);

		s3_adls_per_addr_c6_m := map(
			s3_adls_per_addr_c6 = 0 => 0.0538880805,
			s3_adls_per_addr_c6 = 1 => 0.0663167939,
			s3_adls_per_addr_c6 = 2 => 0.0749885688,
			s3_adls_per_addr_c6 = 4 => 0.0841121495,
			s3_adls_per_addr_c6 = 5 => 0.0866873065,
			s3_adls_per_addr_c6 = 6 => 0.1503759398,
									   0.0609453272);

		s3_phones_per_addr_c6 := min(2, if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6));

		s3_phones_per_addr_c6_m := map(
			s3_phones_per_addr_c6 = 0 => 0.0564350413,
			s3_phones_per_addr_c6 = 1 => 0.0800273598,
			s3_phones_per_addr_c6 = 2 => 0.1492146597,
										 0.0609453272);

		s3_estimated_income := map(
			estimated_income <= 0     => -1,
			estimated_income <= 19999 => 14,
			estimated_income <= 21000 => 13,
			estimated_income <= 22000 => 12,
			estimated_income <= 23000 => 11,
			estimated_income <= 24000 => 10,
			estimated_income <= 26000 => 9,
			estimated_income <= 27000 => 8,
			estimated_income <= 28000 => 7,
			estimated_income <= 29000 => 6,
			estimated_income <= 34000 => 5,
			estimated_income <= 37000 => 4,
			estimated_income <= 41000 => 3,
			estimated_income <= 58000 => 2,
										 1);

		s3_estimated_income_m := map(
			s3_estimated_income = -1 => 0.0871997368,
			s3_estimated_income = 1  => 0.0250237567,
			s3_estimated_income = 2  => 0.0255911889,
			s3_estimated_income = 3  => 0.0294530154,
			s3_estimated_income = 4  => 0.0319976077,
			s3_estimated_income = 5  => 0.0382885134,
			s3_estimated_income = 6  => 0.04659271,
			s3_estimated_income = 7  => 0.0515463918,
			s3_estimated_income = 8  => 0.0567579505,
			s3_estimated_income = 9  => 0.0576385542,
			s3_estimated_income = 10 => 0.0715340789,
			s3_estimated_income = 11 => 0.0805412371,
			s3_estimated_income = 12 => 0.0876833845,
			s3_estimated_income = 13 => 0.1108331248,
			s3_estimated_income = 14 => 0.1468559838,
										0.0609453272);

		s3_inq_count12 := min(2, if(Inq_count12 = NULL, -NULL, Inq_count12));

		s3_inq_count12_m := map(
			s3_inq_count12 = 0 => 0.0598001848,
			s3_inq_count12 = 1 => 0.2466843501,
			s3_inq_count12 = 2 => 0.3928571429,
								  0.0609453272);

		s3_inq_peraddr := min(2, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr));

		s3_inq_peraddr_m := map(
			s3_inq_peraddr = 0 => 0.0567535704,
			s3_inq_peraddr = 1 => 0.1557788945,
			s3_inq_peraddr = 2 => 0.2165605096,
								  0.0609453272);

		s3_state := map(
			out_st = ''   => 4,
			out_st = 'PR' => 6,
			out_st = 'DC' => 6,
			out_st = 'SD' => 6,
			out_st = 'NV' => 6,
			out_st = 'NM' => 6,
			out_st = 'AZ' => 6,
			out_st = 'FL' => 6,
			out_st = 'MS' => 6,
			out_st = 'IN' => 6,
			out_st = 'LA' => 6,
			out_st = 'RI' => 6,
			out_st = 'NY' => 4,
			out_st = 'PA' => 4,
			out_st = 'CA' => 4,
			out_st = 'NJ' => 4,
			out_st = 'HI' => 5,
			out_st = 'TX' => 5,
			out_st = 'GA' => 4,
			out_st = 'WA' => 4,
			out_st = 'DE' => 4,
			out_st = 'NC' => 4,
			out_st = 'KS' => 5,
			out_st = 'MD' => 4,
			out_st = 'MO' => 5,
			out_st = 'OK' => 5,
			out_st = 'OR' => 4,
			out_st = 'SC' => 5,
			out_st = 'MI' => 4,
			out_st = 'AL' => 5,
			out_st = 'IL' => 4,
			out_st = 'MT' => 4,
			out_st = 'NH' => 4,
			out_st = 'VA' => 4,
			out_st = 'VT' => 4,
			out_st = 'KY' => 4,
			out_st = 'CO' => 3,
			out_st = 'ID' => 3,
			out_st = 'AR' => 3,
			out_st = 'MA' => 3,
			out_st = 'TN' => 3,
			out_st = 'OH' => 3,
			out_st = 'WV' => 2,
			out_st = 'AK' => 2,
			out_st = 'ME' => 2,
			out_st = 'NE' => 2,
			out_st = 'CT' => 2,
			out_st = 'UT' => 2,
			out_st = 'IA' => 2,
			out_st = 'WY' => 1,
			out_st = 'MN' => 1,
			out_st = 'WI' => 1,
			out_st = 'ND' => 1,
			out_st = 'GU' => 6,
			out_st = 'VI' => 1,
							 -1);

		s3_state_m := map(
			s3_state = 1 => 0.0271094942,
			s3_state = 2 => 0.0377170226,
			s3_state = 3 => 0.0469143577,
			s3_state = 4 => 0.0672367342,
			s3_state = 5 => 0.0756111427,
			s3_state = 6 => 0.1001088139,
							0.0609453272);

		s3_other_risk := (integer)rc_input_addr_not_most_recent = 1 or (rc_ssnstate in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'GS']) or infutor_nap > 0 or ver_src_mw or email_src_im or nap_summary = 1 or did_count > 1 or rc_pwssndobflag = (string)1 or (rc_pwssnvalflag in ['1']) or (integer)rc_watchlist_flag = 1;

		s3_other_good := addr_hist_advo_college or StringLib.StringToUpperCase(add2_advo_college) = 'Y' or email_domain_EDU_count > 0 or PAW_active_phone_count > 0;

		s3_dist_a1toa2_1to10 := 0 < dist_a1toa2 AND dist_a1toa2 <= 10;

		s3_dist_a1toa3_1to10 := 0 < dist_a1toa3 AND dist_a1toa3 <= 10;

		s301 := -3.554983669 +
			(integer)s3_phone_risk * 0.2353916558 +
			s3mobility2 * 0.4014127319 +
			s3_mth_gong_did_m * 2.4203914152 +
			s3_rc_dirsaddr_lastscore_m * 5.0052436587 +
			s3_add1_source_count_m * 2.4122080945 +
			(integer)add1_isbestmatch * -0.124052978 +
			s3_naprop_m * 3.2559042558 +
			s3_minor_src_ver * -0.337004157 +
			s3_minor_src_ver_i_m * 20.565116742 +
			s3avm1 * 0.2815230263 +
			(integer)s3_mortgage_risky * 0.3432942968 +
			s3_econtrj_m * 2.1037989743 +
			s3ams2 * 0.7345048269 +
			s3_adlperssn_m * 4.2221299846 +
			s3_adls_per_addr_m * 3.7155134814 +
			s3_id_per_addr_diff_m * 2.4502796735 +
			s3_adls_per_addr_c6_m * 5.2783119722 +
			s3_phones_per_addr_c6_m * 1.7111939785 +
			s3_estimated_income_m * 3.599885593 +
			s3_inq_count12_m * 3.6650133434 +
			s3_inq_peraddr_m * 3.8522427778 +
			s3_state_m * 9.3062827046 +
			(integer)s3_other_risk * 0.1022866034 +
			(integer)s3_other_good * -0.463784682 +
			(integer)s3_dist_a1toa2_1to10 * 0.2048113846 +
			(integer)s3_dist_a1toa3_1to10 * 0.1824235312;

		s4_age := map(
			age <= 0  => -1,
			age <= 17 => 9,
			age <= 18 => 8,
			age <= 19 => 7,
			age <= 20 => 6,
			age <= 50 => 3,
			age <= 60 => 2,
						 1);

		s4_age_m := map(
			s4_age = -1 => 0.0796793965,
			s4_age = 1  => 0.0355731225,
			s4_age = 2  => 0.0513595166,
			s4_age = 3  => 0.0634867874,
			s4_age = 6  => 0.0747953712,
			s4_age = 7  => 0.0787201625,
			s4_age = 8  => 0.0824332007,
			s4_age = 9  => 0.0964912281,
						   0.0745986065);

		s4_phone_risk := (rc_hriskphoneflag in ['3', '5']) or StringLib.StringToUpperCase(nap_status) = 'D';

		s4_avg_lres := map(
			avg_lres <= 0  => -1,
			avg_lres <= 1  => 10,
			avg_lres <= 16 => 9,
			avg_lres <= 18 => 8,
			avg_lres <= 20 => 7,
			avg_lres <= 27 => 6,
			avg_lres <= 30 => 5,
			avg_lres <= 34 => 4,
			avg_lres <= 44 => 3,
			avg_lres <= 55 => 2,
							  1);

		s4_avg_lres_m := map(
			s4_avg_lres = -1 => 0.0711233211,
			s4_avg_lres = 1  => 0.0330082521,
			s4_avg_lres = 2  => 0.0403100775,
			s4_avg_lres = 3  => 0.0465444288,
			s4_avg_lres = 4  => 0.0517482517,
			s4_avg_lres = 5  => 0.06,
			s4_avg_lres = 6  => 0.056122449,
			s4_avg_lres = 7  => 0.0683012259,
			s4_avg_lres = 8  => 0.096723869,
			s4_avg_lres = 9  => 0.0991103481,
			s4_avg_lres = 10 => 0.1440443213,
								0.0745986065);

		s4_avg_mo_per_addr := map(
			avg_mo_per_addr <= 0  => -1,
			avg_mo_per_addr <= 2  => 6,
			avg_mo_per_addr <= 11 => 5,
			avg_mo_per_addr <= 28 => 4,
			avg_mo_per_addr <= 39 => 3,
			avg_mo_per_addr <= 67 => 2,
									 1);

		s4_avg_mo_per_addr_m := map(
			s4_avg_mo_per_addr = -1 => 0.0773523052,
			s4_avg_mo_per_addr = 1  => 0.0393641181,
			s4_avg_mo_per_addr = 2  => 0.0438066465,
			s4_avg_mo_per_addr = 3  => 0.0483870968,
			s4_avg_mo_per_addr = 4  => 0.0628654971,
			s4_avg_mo_per_addr = 5  => 0.0858416945,
			s4_avg_mo_per_addr = 6  => 0.1179516686,
									   0.0745986065);

		s4_addrs_per_ssn := min(5, if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn));

		s4_addrs_per_ssn_m := map(
			s4_addrs_per_ssn = 0 => 0.0646720368,
			s4_addrs_per_ssn = 1 => 0.0519372077,
			s4_addrs_per_ssn = 2 => 0.0779352227,
			s4_addrs_per_ssn = 3 => 0.0884437596,
			s4_addrs_per_ssn = 4 => 0.1144475921,
			s4_addrs_per_ssn = 5 => 0.1252808989,
									0.0745986065);

		s4_addr_stability_v2 := if(addr_stability_v2 = '0', 0, max(2, min(4, if(addr_stability_v2 = '', -NULL, (integer)addr_stability_v2))));

		s4_addr_stability_v2_m := map(
			s4_addr_stability_v2 = 0 => 0.0809716599,
			s4_addr_stability_v2 = 2 => 0.0768217735,
			s4_addr_stability_v2 = 3 => 0.0574400724,
			s4_addr_stability_v2 = 4 => 0.0286666667,
										0.0745986065);

		s4_addrs_15yr := min(2, if(addrs_15yr = NULL, -NULL, addrs_15yr));

		s4_addrs_15yr_m := map(
			s4_addrs_15yr = 0 => 0.0678937507,
			s4_addrs_15yr = 1 => 0.0759242083,
			s4_addrs_15yr = 2 => 0.0928157073,
								 0.0745986065);

		s4_unique_addr_count := unique_addr_count = 0;

		s4_attr_addrs_last24 := min(2, if(attr_addrs_last24 = NULL, -NULL, attr_addrs_last24));

		s4_attr_addrs_last24_m := map(
			s4_attr_addrs_last24 = 0 => 0.064038687,
			s4_attr_addrs_last24 = 1 => 0.0830883624,
			s4_attr_addrs_last24 = 2 => 0.1130653266,
										0.0745986065);

		s4mobility2 := -6.475943604 +
			s4_avg_lres_m * 8.6893119727 +
			s4_avg_mo_per_addr_m * 6.8514332478 +
			s4_addrs_per_ssn_m * 10.973781572 +
			s4_addr_stability_v2_m * 8.4138592027 +
			s4_addrs_15yr_m * 13.328485347 +
			(integer)s4_unique_addr_count * 0.4914851584 +
			s4_attr_addrs_last24_m * 2.7180698095;

		s4_mth_gong_did := map(
			mth_gong_did_first_seen2 <= 0  => -1,
			mth_gong_did_first_seen2 <= 3  => 12,
			mth_gong_did_first_seen2 <= 5  => 11,
			mth_gong_did_first_seen2 <= 6  => 10,
			mth_gong_did_first_seen2 <= 8  => 9,
			mth_gong_did_first_seen2 <= 13 => 8,
			mth_gong_did_first_seen2 <= 23 => 7,
			mth_gong_did_first_seen2 <= 29 => 6,
			mth_gong_did_first_seen2 <= 50 => 5,
			mth_gong_did_first_seen2 <= 64 => 4,
			mth_gong_did_first_seen2 <= 76 => 3,
			mth_gong_did_first_seen2 <= 86 => 2,
											  1);

		s4_mth_gong_did_m := map(
			s4_mth_gong_did = -1 => 0.0659654531,
			s4_mth_gong_did = 1  => 0.0555555556,
			s4_mth_gong_did = 2  => 0.0582750583,
			s4_mth_gong_did = 3  => 0.072815534,
			s4_mth_gong_did = 4  => 0.0827423168,
			s4_mth_gong_did = 5  => 0.0792682927,
			s4_mth_gong_did = 6  => 0.1004784689,
			s4_mth_gong_did = 7  => 0.1194029851,
			s4_mth_gong_did = 8  => 0.1417069243,
			s4_mth_gong_did = 9  => 0.1752136752,
			s4_mth_gong_did = 10 => 0.2032085561,
			s4_mth_gong_did = 11 => 0.2131147541,
			s4_mth_gong_did = 12 => 0.2372881356,
									0.0745986065);

		s4_rc_dirsaddr_lastscore := map(
			rc_dirsaddr_lastscore = 255 => -1,
			rc_dirsaddr_lastscore < 50  => 3,
			rc_dirsaddr_lastscore < 100 => 2,
										   1);

		s4_rc_dirsaddr_lastscore_m := map(
			s4_rc_dirsaddr_lastscore = -1 => 0.0808176526,
			s4_rc_dirsaddr_lastscore = 1  => 0.0570816026,
			s4_rc_dirsaddr_lastscore = 2  => 0.0782918149,
			s4_rc_dirsaddr_lastscore = 3  => 0.1350127371,
											 0.0745986065);

		s4_rc_phoneaddrcount := min(1, if(rc_phoneaddrcount = NULL, -NULL, rc_phoneaddrcount));

		s4_combo_addrscore100 := combo_addrscore = 100;

		s4_naprop := map(
			add1_naprop = 4 => 1,
			add1_naprop = 3 => 1,
			add1_naprop = 2 => 3,
			add1_naprop = 0 => 2,
							   3);

		s4_naprop_m := map(
			s4_naprop = 1 => 0.0433253622,
			s4_naprop = 2 => 0.0980339708,
			s4_naprop = 3 => 0.1317632081,
							 0.0745986065);

		s4_minor_src_ver := max((integer)ver_src_nas_ak > 5, (integer)ver_src_am, (integer)ver_src_ar, (integer)ver_src_eb, (integer)ver_src_nas_e1 > 5, (integer)ver_src_nas_e2 > 5, (integer)ver_src_e3, (integer)ver_src_pl, (integer)ver_src_w, (integer)watercraft_count > 0, (integer)prof_license_flag, (integer)attr_num_aircraft > 0);

		s4_minor_src_ver_i := map(
			s4_minor_src_ver > 0            => 0,
			ver_src_p or ver_src_nas_vo > 5 => 1,
											   2);

		s4_minor_src_ver_i_m := map(
			s4_minor_src_ver_i = 0 => 0.035339064,
			s4_minor_src_ver_i = 1 => 0.0729862475,
			s4_minor_src_ver_i = 2 => 0.078387458,
									  0.0745986065);

		s4_add1_assessedvalue := map(
			(integer)add1_avm_assessed_total_value <= 0      => -1,
			(integer)add1_avm_assessed_total_value <= 13510  => 6,
			(integer)add1_avm_assessed_total_value <= 38390  => 5,
			(integer)add1_avm_assessed_total_value <= 57966  => 4,
			(integer)add1_avm_assessed_total_value <= 86630  => 3,
			(integer)add1_avm_assessed_total_value <= 227145 => 2,
															   1);

		s4_add1_assessedvalue_m := map(
			s4_add1_assessedvalue = -1 => 0.0837138508,
			s4_add1_assessedvalue = 1  => 0.037184595,
			s4_add1_assessedvalue = 2  => 0.048052605,
			s4_add1_assessedvalue = 3  => 0.0595870206,
			s4_add1_assessedvalue = 4  => 0.0814159292,
			s4_add1_assessedvalue = 5  => 0.1008849558,
			s4_add1_assessedvalue = 6  => 0.1187943262,
										  0.0745986065);

		s4_add1_marketvalue := map(
			(integer)add1_avm_market_total_value <= 0      => -1,
			(integer)add1_avm_market_total_value <= 44250  => 8,
			(integer)add1_avm_market_total_value <= 61962  => 7,
			(integer)add1_avm_market_total_value <= 74900  => 6,
			(integer)add1_avm_market_total_value <= 108410 => 5,
			(integer)add1_avm_market_total_value <= 119200 => 4,
			(integer)add1_avm_market_total_value <= 178582 => 3,
			(integer)add1_avm_market_total_value <= 446100 => 2,
															 1);

		s4_add1_marketvalue_m := map(
			s4_add1_marketvalue = -1 => 0.076382127,
			s4_add1_marketvalue = 1  => 0.0227272727,
			s4_add1_marketvalue = 2  => 0.0389329488,
			s4_add1_marketvalue = 3  => 0.0449722082,
			s4_add1_marketvalue = 4  => 0.0730478589,
			s4_add1_marketvalue = 5  => 0.1061499579,
			s4_add1_marketvalue = 6  => 0.1486146096,
			s4_add1_marketvalue = 7  => 0.1515151515,
			s4_add1_marketvalue = 8  => 0.196969697,
										0.0745986065);

		s4_add1_avm := map(
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 58615  => 9,
			add1_avm_automated_valuation <= 80670  => 8,
			add1_avm_automated_valuation <= 99918  => 7,
			add1_avm_automated_valuation <= 117883 => 6,
			add1_avm_automated_valuation <= 253126 => 5,
			add1_avm_automated_valuation <= 310244 => 4,
			add1_avm_automated_valuation <= 390638 => 3,
			add1_avm_automated_valuation <= 529508 => 2,
													  1);

		s4_add1_avm_m := map(
			s4_add1_avm = -1 => 0.0843469274,
			s4_add1_avm = 1  => 0.0375994215,
			s4_add1_avm = 2  => 0.0477223427,
			s4_add1_avm = 3  => 0.0469992769,
			s4_add1_avm = 4  => 0.0484454085,
			s4_add1_avm = 5  => 0.0513376717,
			s4_add1_avm = 6  => 0.0911722142,
			s4_add1_avm = 7  => 0.1184971098,
			s4_add1_avm = 8  => 0.1562952243,
			s4_add1_avm = 9  => 0.1765557164,
								0.0745986065);

		s4_add2_salesprice := map(
			(integer)add2_avm_sales_price <= 0      => -1,
			(integer)add2_avm_sales_price <= 39500  => 8,
			(integer)add2_avm_sales_price <= 53000  => 7,
			(integer)add2_avm_sales_price <= 65000  => 6,
			(integer)add2_avm_sales_price <= 87500  => 5,
			(integer)add2_avm_sales_price <= 122880 => 4,
			(integer)add2_avm_sales_price <= 225000 => 3,
			(integer)add2_avm_sales_price <= 508400 => 2,
													  1);

		s4_add2_salesprice_m := map(
			s4_add2_salesprice = -1 => 0.0717970582,
			s4_add2_salesprice = 1  => 0.0544217687,
			s4_add2_salesprice = 2  => 0.0578231293,
			s4_add2_salesprice = 3  => 0.0751964085,
			s4_add2_salesprice = 4  => 0.1047835991,
			s4_add2_salesprice = 5  => 0.1134020619,
			s4_add2_salesprice = 6  => 0.1315789474,
			s4_add2_salesprice = 7  => 0.1337579618,
			s4_add2_salesprice = 8  => 0.1979166667,
									   0.0745986065);

		s4_add2_avm := map(
			add2_avm_automated_valuation <= 0      => -1,
			add2_avm_automated_valuation <= 47219  => 8,
			add2_avm_automated_valuation <= 66069  => 7,
			add2_avm_automated_valuation <= 81591  => 6,
			add2_avm_automated_valuation <= 109769 => 5,
			add2_avm_automated_valuation <= 181832 => 4,
			add2_avm_automated_valuation <= 253703 => 3,
			add2_avm_automated_valuation <= 658227 => 2,
													  1);

		s4_add2_avm_m := map(
			s4_add2_avm = -1 => 0.0696032433,
			s4_add2_avm = 1  => 0.036036036,
			s4_add2_avm = 2  => 0.0822737472,
			s4_add2_avm = 3  => 0.0837070254,
			s4_add2_avm = 4  => 0.0816876122,
			s4_add2_avm = 5  => 0.1146067416,
			s4_add2_avm = 6  => 0.1659192825,
			s4_add2_avm = 7  => 0.1928251121,
			s4_add2_avm = 8  => 0.2072072072,
								0.0745986065);

		s4_add3_assessedvalue := map(
			add3_assessed_total_value <= 0      => -1,
			add3_assessed_total_value <= 23690  => 6,
			add3_assessed_total_value <= 38200  => 5,
			add3_assessed_total_value <= 58542  => 4,
			add3_assessed_total_value <= 79648  => 3,
			add3_assessed_total_value <= 107050 => 2,
												   1);

		s4_add3_marketvalue := map(
			add3_market_total_value <= 0      => -1,
			add3_market_total_value <= 41552  => 5,
			add3_market_total_value <= 66052  => 4,
			add3_market_total_value <= 87634  => 3,
			add3_market_total_value <= 160300 => 2,
												 1);

		s4_add3_avm := map(
			add3_avm_automated_valuation <= 0      => -1,
			add3_avm_automated_valuation <= 62056  => 6,
			add3_avm_automated_valuation <= 91462  => 5,
			add3_avm_automated_valuation <= 213638 => 4,
			add3_avm_automated_valuation <= 263042 => 3,
			add3_avm_automated_valuation <= 469353 => 2,
													  1);

		s4_add3_assessedvalue_m := map(
			s4_add3_assessedvalue = -1 => 0.0705382202,
			s4_add3_assessedvalue = 1  => 0.0848623853,
			s4_add3_assessedvalue = 2  => 0.0963302752,
			s4_add3_assessedvalue = 3  => 0.1232876712,
			s4_add3_assessedvalue = 4  => 0.1244239631,
			s4_add3_assessedvalue = 5  => 0.1689497717,
			s4_add3_assessedvalue = 6  => 0.1724137931,
										  0.0745986065);

		s4_add3_marketvalue_m := map(
			s4_add3_marketvalue = -1 => 0.0713479068,
			s4_add3_marketvalue = 1  => 0.0696594427,
			s4_add3_marketvalue = 2  => 0.1136363636,
			s4_add3_marketvalue = 3  => 0.1666666667,
			s4_add3_marketvalue = 4  => 0.2049689441,
			s4_add3_marketvalue = 5  => 0.2546583851,
										0.0745986065);

		s4_add3_avm_m := map(
			s4_add3_avm = -1 => 0.071225534,
			s4_add3_avm = 1  => 0.0786516854,
			s4_add3_avm = 2  => 0.0758426966,
			s4_add3_avm = 3  => 0.094972067,
			s4_add3_avm = 4  => 0.095371669,
			s4_add3_avm = 5  => 0.2078651685,
			s4_add3_avm = 6  => 0.297752809,
								0.0745986065);

		s4_add1_avm_med := map(
			add1_avm_med <= 0      => -1,
			add1_avm_med <= 59489  => 8,
			add1_avm_med <= 78365  => 7,
			add1_avm_med <= 94000  => 6,
			add1_avm_med <= 109285 => 5,
			add1_avm_med <= 427509 => 4,
			add1_avm_med <= 502303 => 3,
			add1_avm_med <= 621366 => 2,
									  1);

		s4_add1_avm_med_m := map(
			s4_add1_avm_med = -1 => 0.0547252242,
			s4_add1_avm_med = 1  => 0.0516772439,
			s4_add1_avm_med = 2  => 0.0661831369,
			s4_add1_avm_med = 3  => 0.0770625567,
			s4_add1_avm_med = 4  => 0.0662482566,
			s4_add1_avm_med = 5  => 0.0924062214,
			s4_add1_avm_med = 6  => 0.1089108911,
			s4_add1_avm_med = 7  => 0.1356238698,
			s4_add1_avm_med = 8  => 0.1772727273,
									0.0745986065);

		s4_add1_avm_to_med_ratio := map(
			add1_avm_to_med_ratio = NULL  => -1,
			add1_avm_to_med_ratio <= 0.50 => 7,
			add1_avm_to_med_ratio <= 0.75 => 6,
			add1_avm_to_med_ratio <= 1    => 5,
			add1_avm_to_med_ratio <= 1.25 => 4,
			add1_avm_to_med_ratio <= 1.50 => 3,
											 1);

		s4_add1_avm_to_med_ratio_m := map(
			s4_add1_avm_to_med_ratio = -1 => 0.0843201144,
			s4_add1_avm_to_med_ratio = 1  => 0.0419452888,
			s4_add1_avm_to_med_ratio = 3  => 0.055393586,
			s4_add1_avm_to_med_ratio = 4  => 0.0572329878,
			s4_add1_avm_to_med_ratio = 5  => 0.079835569,
			s4_add1_avm_to_med_ratio = 6  => 0.084729064,
			s4_add1_avm_to_med_ratio = 7  => 0.0923076923,
											 0.0745986065);

		s4_buildingarea := map(
			(integer)add1_building_area <= 0    => -1,
			(integer)add1_building_area <= 1040 => 9,
			(integer)add1_building_area <= 1223 => 8,
			(integer)add1_building_area <= 1392 => 7,
			(integer)add1_building_area <= 1568 => 6,
			(integer)add1_building_area <= 1775 => 5,
			(integer)add1_building_area <= 1995 => 4,
			(integer)add1_building_area <= 2263 => 3,
			(integer)add1_building_area <= 3195 => 2,
												  1);

		s4_buildingarea_m := map(
			s4_buildingarea = -1 => 0.0814306865,
			s4_buildingarea = 1  => 0.0383198231,
			s4_buildingarea = 2  => 0.0371870398,
			s4_buildingarea = 3  => 0.0530191458,
			s4_buildingarea = 4  => 0.056576047,
			s4_buildingarea = 5  => 0.0581222057,
			s4_buildingarea = 6  => 0.0835777126,
			s4_buildingarea = 7  => 0.0888399413,
			s4_buildingarea = 8  => 0.103115727,
			s4_buildingarea = 9  => 0.1250914411,
									0.0745986065);

		s4_add1_no_of_partial_baths := add1_no_of_partial_baths > (string)0;

		s4avm1 := -5.952823825 +
			s4_add1_assessedvalue_m * 4.856961705 +
			s4_add1_marketvalue_m * 2.5103420504 +
			s4_add1_avm_m * 1.8900252378 +
			s4_add2_salesprice_m * 4.1972788163 +
			s4_add2_avm_m * 3.2496714275 +
			s4_add3_assessedvalue_m * 2.9161860939 +
			s4_add3_marketvalue_m * 2.6522969626 +
			s4_add3_avm_m * 2.8684877063 +
			s4_add1_avm_med_m * 5.7901368296 +
			s4_add1_avm_to_med_ratio_m * 7.4990942468 +
			s4_buildingarea_m * 6.7098074331 +
			(integer)s4_add1_no_of_partial_baths * -0.496426001;

		s4_mortgage_risky := StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add1_mortgage_type) in ['1', 'G', 'N', 'R', 'U', 'VA']) or (StringLib.StringToUpperCase(add1_mortgage_type) in ['FHA', 'H', 'S']) or (StringLib.StringToUpperCase(add2_mortgage_type) in ['FHA', 'G', 'H', 'S']) or StringLib.StringToUpperCase(add2_financing_type) = 'ADJ' or (StringLib.StringToUpperCase(add3_mortgage_type) in ['FHA', 'G', 'H']) or StringLib.StringToUpperCase(add3_financing_type) = 'ADJ';

		s4_ams_class := (StringLib.StringToUpperCase(ams_class) in ['GR', 'SR']);

		s4_ams_college_tier := map(
			ams_college_tier = (string)0 => 3,
			ams_college_tier = (string)1 => 1,
			ams_college_tier = (string)2 => 2,
			ams_college_tier = (string)3 => 3,
			ams_college_tier = (string)4 => 4,
			ams_college_tier = (string)5 => 5,
			ams_college_tier = (string)6 => 6,
											-1);

		s4_ams_income_level := map(
			StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 4,
			StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
																		-1);

		s4_ams_college_tier_m := map(
			s4_ams_college_tier = -1 => 0.093058242,
			s4_ams_college_tier = 1  => 0.0074626866,
			s4_ams_college_tier = 2  => 0.0113924051,
			s4_ams_college_tier = 3  => 0.0159471023,
			s4_ams_college_tier = 4  => 0.0225225225,
			s4_ams_college_tier = 5  => 0.0545994065,
			s4_ams_college_tier = 6  => 0.0809061489,
										0.0745986065);

		s4_ams_income_level_m := map(
			s4_ams_income_level = -1 => 0.0880076598,
			s4_ams_income_level = 1  => 0.0239608802,
			s4_ams_income_level = 2  => 0.0389776358,
			s4_ams_income_level = 3  => 0.0443645084,
			s4_ams_income_level = 4  => 0.0538617886,
			s4_ams_income_level = 5  => 0.0702439024,
			s4_ams_income_level = 6  => 0.0917378917,
			s4_ams_income_level = 7  => 0.1546184739,
			s4_ams_income_level = 8  => 0.216730038,
										0.0745986065);

		s4ams2 := -4.634710387 +
			(integer)s4_ams_class * -1.530576139 +
			s4_ams_college_tier_m * 16.13975881 +
			s4_ams_income_level_m * 10.229111044;

		s4_adlperssn := max(1, min(3, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		s4_adlperssn_m := map(
			s4_adlperssn = 1 => 0.0691056911,
			s4_adlperssn = 2 => 0.0985264374,
			s4_adlperssn = 3 => 0.1226765799,
								0.0745986065);

		s4_adls_per_addr := map(
			adls_per_addr <= 1                        => 3,
			adls_per_addr >= 10                       => 3,
			adls_per_addr = 4                         => 0,
			3 <= adls_per_addr AND adls_per_addr <= 6 => 1,
														 2);

		s4_adls_per_addr_m := map(
			s4_adls_per_addr = 0 => 0.0368421053,
			s4_adls_per_addr = 1 => 0.0423061787,
			s4_adls_per_addr = 2 => 0.0542412977,
			s4_adls_per_addr = 3 => 0.1009771987,
									0.0745986065);

		s4_id_per_addr_diff_1 := if(id_per_addr_diff <= 0, -1, min(8, if(id_per_addr_diff = NULL, -NULL, id_per_addr_diff)));

		s4_id_per_addr_diff := if(s4_id_per_addr_diff_1 = 5, 4, s4_id_per_addr_diff_1);

		s4_id_per_addr_diff_m := map(
			s4_id_per_addr_diff = -1 => 0.0943015633,
			s4_id_per_addr_diff = 1  => 0.0493576741,
			s4_id_per_addr_diff = 2  => 0.05,
			s4_id_per_addr_diff = 3  => 0.0583647799,
			s4_id_per_addr_diff = 4  => 0.0751054852,
			s4_id_per_addr_diff = 6  => 0.1079967024,
			s4_id_per_addr_diff = 7  => 0.1238223419,
			s4_id_per_addr_diff = 8  => 0.1442762535,
										0.0745986065);

		s4_adls_per_addr_c6_1 := min(6, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		s4_adls_per_addr_c6 := if(s4_adls_per_addr_c6_1 = 4, 3, s4_adls_per_addr_c6_1);

		s4_adls_per_addr_c6_m := map(
			s4_adls_per_addr_c6 = 0 => 0.0682523268,
			s4_adls_per_addr_c6 = 1 => 0.0708573032,
			s4_adls_per_addr_c6 = 2 => 0.0827029753,
			s4_adls_per_addr_c6 = 3 => 0.0889453621,
			s4_adls_per_addr_c6 = 5 => 0.1674008811,
			s4_adls_per_addr_c6 = 6 => 0.1987179487,
									   0.0745986065);

		s4_estimated_income := map(
			estimated_income <= 0     => -1,
			estimated_income <= 19999 => 11,
			estimated_income <= 20000 => 10,
			estimated_income <= 21000 => 9,
			estimated_income <= 23000 => 8,
			estimated_income <= 26000 => 7,
			estimated_income <= 27000 => 6,
			estimated_income <= 28000 => 5,
			estimated_income <= 29000 => 4,
			estimated_income <= 35000 => 3,
			estimated_income <= 45000 => 2,
										 1);

		s4_estimated_income_m := map(
			s4_estimated_income = -1 => 0.1103360812,
			s4_estimated_income = 1  => 0.0405186386,
			s4_estimated_income = 2  => 0.0421845574,
			s4_estimated_income = 3  => 0.0448179272,
			s4_estimated_income = 4  => 0.0536044362,
			s4_estimated_income = 5  => 0.0537634409,
			s4_estimated_income = 6  => 0.0635135135,
			s4_estimated_income = 7  => 0.0780019212,
			s4_estimated_income = 8  => 0.0907952411,
			s4_estimated_income = 9  => 0.1206322795,
			s4_estimated_income = 10 => 0.1317365269,
			s4_estimated_income = 11 => 0.1549395878,
										0.0745986065);

		s4_inq_peraddr := min(1, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr));

		s4_other_risk := did_count != 1 or (rc_pwssnvalflag in ['1']) or (rc_ssnstate in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'GS']) or (integer)rc_altlname1_flag = 1 or (integer)rc_altlname2_flag = 1 or liens_recent_released_count > 0 or liens_historical_released_count > 0 or (integer)email_src_im > 0 or email_domain_Free_count > 0 or 0 < dist_a1toa2 AND dist_a1toa2 <= 5 or 0 < dist_a1toa3 AND dist_a1toa3 <= 10;

		s4_other_good := addr_hist_advo_college or email_domain_EDU_count > 0 or PAW_active_phone_count > 0;

		s404 := -3.471549797 +
			s4_age_m * 14.300848992 +
			(integer)s4_phone_risk * 0.4243008235 +
			s4mobility2 * 0.5096817555 +
			s4_mth_gong_did_m * 3.6588248987 +
			s4_rc_dirsaddr_lastscore_m * 5.3992566768 +
			s4_rc_phoneaddrcount * -0.481058588 +
			(integer)s4_combo_addrscore100 * -0.133777724 +
			s4_naprop_m * 2.7263247326 +
			s4_minor_src_ver_i_m * 18.968529098 +
			s4avm1 * 0.4736751243 +
			(integer)s4_mortgage_risky * 0.3618482779 +
			s4ams2 * 0.6965613329 +
			s4_adlperssn_m * 3.4114375845 +
			s4_adls_per_addr_m * 4.4836256779 +
			s4_id_per_addr_diff_m * 3.1416732332 +
			s4_adls_per_addr_c6_m * 6.1349594992 +
			s4_estimated_income_m * 4.3898291371 +
			s4_inq_peraddr * 0.5794969744 +
			(integer)s4_other_risk * 0.4639561652 +
			(integer)s4_other_good * -1.086704316;

		s5_minor_src_ver := max((integer)ver_src_ak, (integer)ver_src_am, (integer)ver_src_ar, (integer)ver_src_eb, (integer)ver_src_e3, (integer)ver_src_pl, (integer)ver_src_w, (integer)watercraft_count > 0, (integer)prof_license_flag, (integer)attr_num_aircraft > 0);

		s5_minor_src_ver_i := map(
			s5_minor_src_ver > 0                                                                                                      => 0,
			ver_src_nas_em > 5 or ver_src_e1 or ver_src_e2 or ver_src_e4 or ver_src_p or ver_src_nas_vo > 5 or PAW_Business_count > 0 => 1,
																																		 2);

		s5_minor_src_ver_i_m := map(
			s5_minor_src_ver_i = 0 => 0.0643060643,
			s5_minor_src_ver_i = 1 => 0.0926154069,
			s5_minor_src_ver_i = 2 => 0.129163459,
									  0.1250927692);

		s5_phone_risk := (rc_hphonevalflag in ['0', '1', '5']) or (rc_hriskphoneflag in ['1', '2', '3', '4', '5', '6']) or StringLib.StringToUpperCase(nap_status) = 'D';

		s5_add1_assessedvalue := map(
			add_apt                                         => -2,
			(integer)add1_avm_assessed_total_value <= 0      => -1,
			(integer)add1_avm_assessed_total_value <= 11514  => 14,
			(integer)add1_avm_assessed_total_value <= 17890  => 13,
			(integer)add1_avm_assessed_total_value <= 49600  => 12,
			(integer)add1_avm_assessed_total_value <= 62215  => 11,
			(integer)add1_avm_assessed_total_value <= 75316  => 10,
			(integer)add1_avm_assessed_total_value <= 88509  => 9,
			(integer)add1_avm_assessed_total_value <= 102990 => 8,
			(integer)add1_avm_assessed_total_value <= 117847 => 7,
			(integer)add1_avm_assessed_total_value <= 171080 => 6,
			(integer)add1_avm_assessed_total_value <= 220500 => 5,
			(integer)add1_avm_assessed_total_value <= 254870 => 4,
			(integer)add1_avm_assessed_total_value <= 363000 => 3,
			(integer)add1_avm_assessed_total_value <= 477634 => 2,
															   1);

		s5_add1_marketvalue := map(
			add_apt                                       => -2,
			(integer)add1_avm_market_total_value <= 0      => -1,
			(integer)add1_avm_market_total_value <= 45200  => 17,
			(integer)add1_avm_market_total_value <= 62200  => 16,
			(integer)add1_avm_market_total_value <= 74912  => 15,
			(integer)add1_avm_market_total_value <= 86530  => 14,
			(integer)add1_avm_market_total_value <= 97000  => 13,
			(integer)add1_avm_market_total_value <= 107470 => 12,
			(integer)add1_avm_market_total_value <= 117667 => 11,
			(integer)add1_avm_market_total_value <= 128453 => 10,
			(integer)add1_avm_market_total_value <= 150800 => 9,
			(integer)add1_avm_market_total_value <= 163490 => 8,
			(integer)add1_avm_market_total_value <= 177748 => 7,
			(integer)add1_avm_market_total_value <= 211330 => 6,
			(integer)add1_avm_market_total_value <= 232260 => 5,
			(integer)add1_avm_market_total_value <= 258880 => 4,
			(integer)add1_avm_market_total_value <= 345570 => 3,
			(integer)add1_avm_market_total_value <= 441490 => 2,
															 1);

		s5_add1_avm := map(
			add_apt                                => -2,
			add1_avm_automated_valuation <= 0      => -1,
			add1_avm_automated_valuation <= 65000  => 13,
			add1_avm_automated_valuation <= 89240  => 12,
			add1_avm_automated_valuation <= 109649 => 11,
			add1_avm_automated_valuation <= 129228 => 10,
			add1_avm_automated_valuation <= 147500 => 9,
			add1_avm_automated_valuation <= 205645 => 8,
			add1_avm_automated_valuation <= 250000 => 7,
			add1_avm_automated_valuation <= 304499 => 6,
			add1_avm_automated_valuation <= 408925 => 5,
			add1_avm_automated_valuation <= 514958 => 4,
			add1_avm_automated_valuation <= 590611 => 3,
			add1_avm_automated_valuation <= 727863 => 2,
													  1);

		s5_add2_salesprice := map(
			add2_apt                               => -2,
			(integer)add2_avm_sales_price <= 0      => -1,
			(integer)add2_avm_sales_price <= 29000  => 10,
			(integer)add2_avm_sales_price <= 46500  => 9,
			(integer)add2_avm_sales_price <= 84999  => 8,
			(integer)add2_avm_sales_price <= 109797 => 7,
			(integer)add2_avm_sales_price <= 132900 => 6,
			(integer)add2_avm_sales_price <= 145200 => 5,
			(integer)add2_avm_sales_price <= 331900 => 4,
			(integer)add2_avm_sales_price <= 400000 => 3,
			(integer)add2_avm_sales_price <= 525000 => 2,
													  1);

		s5_add1_assessedvalue_m := map(
			s5_add1_assessedvalue = -2 => 0.1382904448,
			s5_add1_assessedvalue = -1 => 0.1271263256,
			s5_add1_assessedvalue = 1  => 0.0628511236,
			s5_add1_assessedvalue = 2  => 0.0771408351,
			s5_add1_assessedvalue = 3  => 0.0813666784,
			s5_add1_assessedvalue = 4  => 0.0926897517,
			s5_add1_assessedvalue = 5  => 0.0981670779,
			s5_add1_assessedvalue = 6  => 0.1064727955,
			s5_add1_assessedvalue = 7  => 0.1134380454,
			s5_add1_assessedvalue = 8  => 0.1149947571,
			s5_add1_assessedvalue = 9  => 0.1222416813,
			s5_add1_assessedvalue = 10 => 0.1253511236,
			s5_add1_assessedvalue = 11 => 0.1363475804,
			s5_add1_assessedvalue = 12 => 0.132212951,
			s5_add1_assessedvalue = 13 => 0.1573114051,
			s5_add1_assessedvalue = 14 => 0.1933381608,
										  0.1250927692);

		s5_add1_marketvalue_m := map(
			s5_add1_marketvalue = -2 => 0.1382904448,
			s5_add1_marketvalue = -1 => 0.1203846892,
			s5_add1_marketvalue = 1  => 0.0497973364,
			s5_add1_marketvalue = 2  => 0.0690655833,
			s5_add1_marketvalue = 3  => 0.0768563999,
			s5_add1_marketvalue = 4  => 0.0886442642,
			s5_add1_marketvalue = 5  => 0.0902817711,
			s5_add1_marketvalue = 6  => 0.0939849624,
			s5_add1_marketvalue = 7  => 0.1016753322,
			s5_add1_marketvalue = 8  => 0.1107184923,
			s5_add1_marketvalue = 9  => 0.1100729927,
			s5_add1_marketvalue = 10 => 0.1222222222,
			s5_add1_marketvalue = 11 => 0.1324811156,
			s5_add1_marketvalue = 12 => 0.1381924198,
			s5_add1_marketvalue = 13 => 0.1558891455,
			s5_add1_marketvalue = 14 => 0.1631578947,
			s5_add1_marketvalue = 15 => 0.1892371378,
			s5_add1_marketvalue = 16 => 0.2183840749,
			s5_add1_marketvalue = 17 => 0.2522468544,
										0.1250927692);

		s5_add1_avm_m := map(
			s5_add1_avm = -2 => 0.1382904448,
			s5_add1_avm = -1 => 0.1263759608,
			s5_add1_avm = 1  => 0.0474186308,
			s5_add1_avm = 2  => 0.0716467648,
			s5_add1_avm = 3  => 0.094672923,
			s5_add1_avm = 4  => 0.1010384507,
			s5_add1_avm = 5  => 0.0986681673,
			s5_add1_avm = 6  => 0.1016328829,
			s5_add1_avm = 7  => 0.1129123203,
			s5_add1_avm = 8  => 0.1165048544,
			s5_add1_avm = 9  => 0.1270780502,
			s5_add1_avm = 10 => 0.1303370787,
			s5_add1_avm = 11 => 0.1589385475,
			s5_add1_avm = 12 => 0.1753794266,
			s5_add1_avm = 13 => 0.250413679,
								0.1250927692);

		s5_add2_salesprice_m := map(
			s5_add2_salesprice = -2 => 0.1351574403,
			s5_add2_salesprice = -1 => 0.1168446343,
			s5_add2_salesprice = 1  => 0.1072589382,
			s5_add2_salesprice = 2  => 0.1255102041,
			s5_add2_salesprice = 3  => 0.1285266458,
			s5_add2_salesprice = 4  => 0.1345002992,
			s5_add2_salesprice = 5  => 0.1673511294,
			s5_add2_salesprice = 6  => 0.1596244131,
			s5_add2_salesprice = 7  => 0.1726990693,
			s5_add2_salesprice = 8  => 0.1879646018,
			s5_add2_salesprice = 9  => 0.2178828366,
			s5_add2_salesprice = 10 => 0.2186234818,
									   0.1250927692);

		s5_add2_avm := map(
			add2_apt                               => -2,
			add2_avm_automated_valuation <= 0      => -1,
			add2_avm_automated_valuation <= 53326  => 12,
			add2_avm_automated_valuation <= 75937  => 11,
			add2_avm_automated_valuation <= 94494  => 10,
			add2_avm_automated_valuation <= 112194 => 9,
			add2_avm_automated_valuation <= 128999 => 8,
			add2_avm_automated_valuation <= 185000 => 7,
			add2_avm_automated_valuation <= 350381 => 6,
			add2_avm_automated_valuation <= 389950 => 5,
			add2_avm_automated_valuation <= 494894 => 4,
			add2_avm_automated_valuation <= 574853 => 3,
			add2_avm_automated_valuation <= 709487 => 2,
													  1);

		s5_add2_avm_m := map(
			s5_add2_avm = -2 => 0.1351574403,
			s5_add2_avm = -1 => 0.1139620477,
			s5_add2_avm = 1  => 0.0675168792,
			s5_add2_avm = 2  => 0.1056034483,
			s5_add2_avm = 3  => 0.1281112738,
			s5_add2_avm = 4  => 0.1400073883,
			s5_add2_avm = 5  => 0.136329588,
			s5_add2_avm = 6  => 0.1530867283,
			s5_add2_avm = 7  => 0.1563212567,
			s5_add2_avm = 8  => 0.1705882353,
			s5_add2_avm = 9  => 0.1782831988,
			s5_add2_avm = 10 => 0.2046783626,
			s5_add2_avm = 11 => 0.2243125904,
			s5_add2_avm = 12 => 0.2443636364,
								0.1250927692);

		s5_add3_assessedvalue := map(
			add3_apt                            => -2,
			add3_assessed_total_value <= 0      => -1,
			add3_assessed_total_value <= 13011  => 6,
			add3_assessed_total_value <= 44983  => 5,
			add3_assessed_total_value <= 70220  => 4,
			add3_assessed_total_value <= 269700 => 3,
			add3_assessed_total_value <= 433813 => 2,
												   1);

		s5_add3_marketvalue := map(
			add3_apt                          => -2,
			add3_market_total_value <= 0      => -1,
			add3_market_total_value <= 42729  => 8,
			add3_market_total_value <= 70168  => 7,
			add3_market_total_value <= 94755  => 6,
			add3_market_total_value <= 119440 => 5,
			add3_market_total_value <= 146100 => 4,
			add3_market_total_value <= 178000 => 3,
			add3_market_total_value <= 290261 => 2,
												 1);

		s5_add3_avm := map(
			add3_apt                               => -2,
			add3_avm_automated_valuation <= 0      => -1,
			add3_avm_automated_valuation <= 75308  => 7,
			add3_avm_automated_valuation <= 110250 => 6,
			add3_avm_automated_valuation <= 143018 => 5,
			add3_avm_automated_valuation <= 267248 => 4,
			add3_avm_automated_valuation <= 419440 => 3,
			add3_avm_automated_valuation <= 557000 => 2,
													  1);

		s5_add1_avm_med := map(
			add_apt                => -2,
			add1_avm_med <= 0      => -1,
			add1_avm_med <= 86150  => 7,
			add1_avm_med <= 122410 => 6,
			add1_avm_med <= 154475 => 5,
			add1_avm_med <= 192681 => 4,
			add1_avm_med <= 447334 => 3,
			add1_avm_med <= 574993 => 2,
									  1);

		s5_buildingarea := map(
			add1_building_area2 <= 0     => -1,
			add1_building_area2 <= 1000  => 5,
			add1_building_area2 <= 2000  => 4,
			add1_building_area2 <= 3000  => 3,
			add1_building_area2 <= 5000  => 1,
			add1_building_area2 <= 10000 => 2,
											-1);

		s5_add3_assessedvalue_m := map(
			s5_add3_assessedvalue = -2 => 0.1348783648,
			s5_add3_assessedvalue = -1 => 0.1179772574,
			s5_add3_assessedvalue = 1  => 0.1207697412,
			s5_add3_assessedvalue = 2  => 0.1414141414,
			s5_add3_assessedvalue = 3  => 0.15,
			s5_add3_assessedvalue = 4  => 0.1762730834,
			s5_add3_assessedvalue = 5  => 0.1918941274,
			s5_add3_assessedvalue = 6  => 0.208452313,
										  0.1250927692);

		s5_add3_marketvalue_m := map(
			s5_add3_marketvalue = -2 => 0.1348783648,
			s5_add3_marketvalue = -1 => 0.1195121392,
			s5_add3_marketvalue = 1  => 0.119138756,
			s5_add3_marketvalue = 2  => 0.1373134328,
			s5_add3_marketvalue = 3  => 0.1598609904,
			s5_add3_marketvalue = 4  => 0.1710069444,
			s5_add3_marketvalue = 5  => 0.1712328767,
			s5_add3_marketvalue = 6  => 0.1979166667,
			s5_add3_marketvalue = 7  => 0.2271157168,
			s5_add3_marketvalue = 8  => 0.2684444444,
										0.1250927692);

		s5_add3_avm_m := map(
			s5_add3_avm = -2 => 0.1348783648,
			s5_add3_avm = -1 => 0.1185806633,
			s5_add3_avm = 1  => 0.1070441989,
			s5_add3_avm = 2  => 0.1422680412,
			s5_add3_avm = 3  => 0.1457756233,
			s5_add3_avm = 4  => 0.1647031103,
			s5_add3_avm = 5  => 0.1837725381,
			s5_add3_avm = 6  => 0.1927546138,
			s5_add3_avm = 7  => 0.2722972973,
								0.1250927692);

		s5_add1_avm_med_m := map(
			s5_add1_avm_med = -2 => 0.1382904448,
			s5_add1_avm_med = -1 => 0.1152138456,
			s5_add1_avm_med = 1  => 0.0659496513,
			s5_add1_avm_med = 2  => 0.1002535146,
			s5_add1_avm_med = 3  => 0.1114252828,
			s5_add1_avm_med = 4  => 0.1210323067,
			s5_add1_avm_med = 5  => 0.1225621592,
			s5_add1_avm_med = 6  => 0.1433272395,
			s5_add1_avm_med = 7  => 0.1972944483,
									0.1250927692);

		s5_buildingarea_m := map(
			s5_buildingarea = -1 => 0.1293560543,
			s5_buildingarea = 1  => 0.0590078329,
			s5_buildingarea = 2  => 0.078125,
			s5_buildingarea = 3  => 0.0827976059,
			s5_buildingarea = 4  => 0.134429172,
			s5_buildingarea = 5  => 0.1864699419,
									0.1250927692);

		s5_add1_2story := add1_no_of_stories = (string)2;

		s5_add1_bath_37 := (string)3 <= add1_no_of_baths AND add1_no_of_baths <= (string)7;

		s5avm02 := -5.458463312 +
			s5_add1_assessedvalue_m * 1.4236170791 +
			s5_add1_marketvalue_m * 1.4572360651 +
			s5_add1_avm_m * 2.2639592098 +
			s5_add2_salesprice_m * 2.6255788608 +
			s5_add2_avm_m * 3.8229363728 +
			s5_add3_assessedvalue_m * 2.0799906826 +
			s5_add3_marketvalue_m * 2.1716165021 +
			s5_add3_avm_m * 2.4286232451 +
			s5_add1_avm_med_m * 3.6308955464 +
			s5_buildingarea_m * 6.0154514479 +
			(integer)s5_add1_2story * -0.135805629 +
			(integer)s5_add1_bath_37 * -0.139906429;

		s5_mortgage_risky := StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add1_mortgage_type) in ['1', '2', 'G', 'H', 'J', 'N', 'R', 'U', 'Z']) or (StringLib.StringToUpperCase(add1_mortgage_type) in ['FHA', 'S']) or (StringLib.StringToUpperCase(add2_mortgage_type) in ['FHA', 'H', 'S']) or (StringLib.StringToUpperCase(add3_mortgage_type) in ['FHA']);

		s5_ssns_per_addr := if(ssns_per_addr <= 11, min(10, if(ssns_per_addr = NULL, -NULL, ssns_per_addr)), min(17, if(ssns_per_addr = NULL, -NULL, ssns_per_addr)));

		s5_ssns_per_addr_m := map(
			s5_ssns_per_addr = 0  => 0.1256003256,
			s5_ssns_per_addr = 1  => 0.145175516,
			s5_ssns_per_addr = 2  => 0.1219008264,
			s5_ssns_per_addr = 3  => 0.0841289347,
			s5_ssns_per_addr = 4  => 0.084907936,
			s5_ssns_per_addr = 5  => 0.0894169525,
			s5_ssns_per_addr = 6  => 0.0940224159,
			s5_ssns_per_addr = 7  => 0.1041891494,
			s5_ssns_per_addr = 8  => 0.1114104084,
			s5_ssns_per_addr = 9  => 0.120491999,
			s5_ssns_per_addr = 10 => 0.136908703,
			s5_ssns_per_addr = 12 => 0.1468387579,
			s5_ssns_per_addr = 13 => 0.1486996644,
			s5_ssns_per_addr = 14 => 0.1567996037,
			s5_ssns_per_addr = 15 => 0.1685714286,
			s5_ssns_per_addr = 16 => 0.1763317599,
			s5_ssns_per_addr = 17 => 0.1821663557,
									 0.1250927692);

		s5_id_per_addr_diff := map(
			id_per_addr_diff <= -3 => -3,
			id_per_addr_diff <= -2 => -2,
			id_per_addr_diff <= 1  => 1,
			id_per_addr_diff <= 6  => id_per_addr_diff,
			id_per_addr_diff <= 9  => 9,
									  10);

		s5_id_per_addr_diff_m := map(
			s5_id_per_addr_diff = -3 => 0.2168674699,
			s5_id_per_addr_diff = -2 => 0.1438746439,
			s5_id_per_addr_diff = 1  => 0.1065870472,
			s5_id_per_addr_diff = 2  => 0.1165507401,
			s5_id_per_addr_diff = 3  => 0.1264880044,
			s5_id_per_addr_diff = 4  => 0.1502697842,
			s5_id_per_addr_diff = 5  => 0.1593953057,
			s5_id_per_addr_diff = 6  => 0.174066106,
			s5_id_per_addr_diff = 9  => 0.1917152104,
			s5_id_per_addr_diff = 10 => 0.2114520227,
										0.1250927692);

		s5_ssns_per_addr_c6 := if(ssns_per_addr_c6 <= 9, min(4, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6)), 5);

		s5_id_per_addr_c6_diff := map(
			id_per_addr_c6_diff <= -2 => -2,
			id_per_addr_c6_diff <= 3  => min(1, if(id_per_addr_c6_diff = NULL, -NULL, id_per_addr_c6_diff)),
			id_per_addr_c6_diff <= 7  => 2,
										 3);

		s5_ssns_per_addr_c6_m := map(
			s5_ssns_per_addr_c6 = 0 => 0.1027344577,
			s5_ssns_per_addr_c6 = 1 => 0.1381410318,
			s5_ssns_per_addr_c6 = 2 => 0.1766891427,
			s5_ssns_per_addr_c6 = 3 => 0.2060879369,
			s5_ssns_per_addr_c6 = 4 => 0.2100591716,
			s5_ssns_per_addr_c6 = 5 => 0.2962962963,
									   0.1250927692);

		s5_id_per_addr_c6_diff_m := map(
			s5_id_per_addr_c6_diff = -2 => 0.2631578947,
			s5_id_per_addr_c6_diff = -1 => 0.2117420597,
			s5_id_per_addr_c6_diff = 0  => 0.1192951298,
			s5_id_per_addr_c6_diff = 1  => 0.1399466471,
			s5_id_per_addr_c6_diff = 2  => 0.171641791,
			s5_id_per_addr_c6_diff = 3  => 0.2380952381,
										   0.1250927692);

		s5_ams_age_lt20 := (string)0 < ams_age AND ams_age <= (string)20;

		s5_ams_income_level := map(
			StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 10,
			StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 10,
			StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 4,
			StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
																		-1);

		s5_ams_college_tier := map(
			ams_college_tier = (string)0 => 4,
			ams_college_tier = (string)1 => 1,
			ams_college_tier = (string)2 => 2,
			ams_college_tier = (string)3 => 3,
			ams_college_tier = (string)4 => 4,
			ams_college_tier = (string)5 => 5,
			ams_college_tier = (string)6 => 6,
											-1);

		s5_ams_income_level_m := map(
			s5_ams_income_level = -1 => 0.1384663705,
			s5_ams_income_level = 1  => 0.0367014046,
			s5_ams_income_level = 2  => 0.0499824006,
			s5_ams_income_level = 3  => 0.060072646,
			s5_ams_income_level = 4  => 0.0674259681,
			s5_ams_income_level = 5  => 0.0788458312,
			s5_ams_income_level = 6  => 0.0894564327,
			s5_ams_income_level = 7  => 0.1094621869,
			s5_ams_income_level = 8  => 0.1372693727,
			s5_ams_income_level = 9  => 0.1796039153,
			s5_ams_income_level = 10 => 0.233256351,
										0.1250927692);

		s5_ams_college_tier_m := map(
			s5_ams_college_tier = -1 => 0.1385166808,
			s5_ams_college_tier = 1  => 0.0066079295,
			s5_ams_college_tier = 2  => 0.013024602,
			s5_ams_college_tier = 3  => 0.0288476293,
			s5_ams_college_tier = 4  => 0.0396146899,
			s5_ams_college_tier = 5  => 0.088772846,
			s5_ams_college_tier = 6  => 0.1214689266,
										0.1250927692);

		s5ams2 := -4.473438759 +
			(integer)s5_ams_age_lt20 * 0.1634790153 +
			s5_ams_income_level_m * 7.5750298599 +
			s5_ams_college_tier_m * 11.840001325;

		s5_state := map(
			out_st = 'ND' => 1,
			out_st = 'SD' => 1,
			out_st = 'NH' => 1,
			out_st = 'VT' => 1,
			out_st = 'MN' => 2,
			out_st = 'ME' => 2,
			out_st = 'WI' => 2,
			out_st = 'CT' => 2,
			out_st = 'KS' => 2,
			out_st = 'IA' => 2,
			out_st = 'NE' => 2,
			out_st = 'MT' => 3,
			out_st = 'PA' => 3,
			out_st = 'NJ' => 3,
			out_st = 'AK' => 3,
			out_st = 'UT' => 3,
			out_st = 'MA' => 3,
			out_st = 'WA' => 4,
			out_st = 'OR' => 4,
			out_st = 'IN' => 4,
			out_st = 'VA' => 4,
			out_st = 'NY' => 4,
			out_st = 'OH' => 4,
			out_st = 'IL' => 4,
			out_st = 'HI' => 4,
			out_st = 'KY' => 4,
			out_st = 'MO' => 4,
			out_st = 'ID' => 4,
			out_st = 'CO' => 4,
			out_st = 'MD' => 4,
			out_st = 'RI' => 4,
			out_st = 'OK' => 4,
			out_st = 'DE' => 4,
			out_st = 'CA' => 4,
			out_st = 'WY' => 5,
			out_st = 'NC' => 5,
			out_st = 'TX' => 5,
			out_st = 'WV' => 5,
			out_st = 'MI' => 5,
			out_st = 'TN' => 5,
			out_st = 'AL' => 6,
			out_st = 'LA' => 6,
			out_st = 'GA' => 6,
			out_st = 'NM' => 6,
			out_st = 'FL' => 6,
			out_st = 'SC' => 6,
			out_st = 'AR' => 6,
			out_st = 'MS' => 6,
			out_st = 'NV' => 6,
			out_st = 'DC' => 6,
			out_st = 'AZ' => 6,
							 -1);

		s5_state_m := map(
			s5_state = -1 => 0.0985337243,
			s5_state = 1  => 0.0649409628,
			s5_state = 2  => 0.0853677869,
			s5_state = 3  => 0.0965467278,
			s5_state = 4  => 0.1214673404,
			s5_state = 5  => 0.1446061644,
			s5_state = 6  => 0.1643459076,
							 0.1250927692);

		s5_other_risk := (integer)rc_input_addr_not_most_recent = 1 or (integer)rc_altlname1_flag = 1 or (integer)rc_altlname2_flag = 1 or (rc_ssnstate in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'GS']) or liens_historical_released_count > 0 or infutor_nap > 0 or ver_src_mw or email_src_im or Inq_HighRiskCredit_count12 > 0;

		s5_rc_dirsaddr_lastscore := map(
			rc_dirsaddr_lastscore = 255 => -1,
			rc_dirsaddr_lastscore < 50  => 3,
			rc_dirsaddr_lastscore < 100 => 2,
										   1);

		s5_rc_dirsaddr_lastscore_m := map(
			s5_rc_dirsaddr_lastscore = -1 => 0.1322827816,
			s5_rc_dirsaddr_lastscore = 1  => 0.0899754727,
			s5_rc_dirsaddr_lastscore = 2  => 0.1315628192,
			s5_rc_dirsaddr_lastscore = 3  => 0.1783092733,
											 0.1250927692);

		s5_mth_add1 := map(
			mth_add1_date_first_seen2 = NULL => -1,
			mth_add1_date_first_seen2 <= 2   => 9,
			mth_add1_date_first_seen2 <= 4   => 8,
			mth_add1_date_first_seen2 <= 5   => 7,
			mth_add1_date_first_seen2 <= 6   => 6,
			mth_add1_date_first_seen2 <= 7   => 5,
			mth_add1_date_first_seen2 <= 17  => 4,
			mth_add1_date_first_seen2 <= 22  => 3,
			mth_add1_date_first_seen2 <= 48  => 2,
												1);

		s5_mth_add1_m := map(
			s5_mth_add1 = -1 => 0.1500272777,
			s5_mth_add1 = 1  => 0.0581113801,
			s5_mth_add1 = 2  => 0.0758364312,
			s5_mth_add1 = 3  => 0.0971266088,
			s5_mth_add1 = 4  => 0.1061527894,
			s5_mth_add1 = 5  => 0.1225440921,
			s5_mth_add1 = 6  => 0.1393952165,
			s5_mth_add1 = 7  => 0.1494951688,
			s5_mth_add1 = 8  => 0.1619714458,
			s5_mth_add1 = 9  => 0.1676784847,
								0.1250927692);

		s5_addrs_per_ssn := max(1, min(9, if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn)));

		s5_addrs_per_adl := max(1, min(3, if(addrs_per_adl = NULL, -NULL, addrs_per_adl)));

		s5_addrs_per_ssn_m := map(
			s5_addrs_per_ssn = 1 => 0.0859440364,
			s5_addrs_per_ssn = 2 => 0.1129699678,
			s5_addrs_per_ssn = 3 => 0.1345001275,
			s5_addrs_per_ssn = 4 => 0.152761959,
			s5_addrs_per_ssn = 5 => 0.1637209302,
			s5_addrs_per_ssn = 6 => 0.1666901309,
			s5_addrs_per_ssn = 7 => 0.1755319149,
			s5_addrs_per_ssn = 8 => 0.1890212325,
			s5_addrs_per_ssn = 9 => 0.1962992759,
									0.1250927692);

		s5_addrs_per_adl_m := map(
			s5_addrs_per_adl = 1 => 0.0913417121,
			s5_addrs_per_adl = 2 => 0.1328369124,
			s5_addrs_per_adl = 3 => 0.151298948,
									0.1250927692);

		s5_addr_stability_v2 := max(0, min(5, if(addr_stability_v2 = '', -NULL, (integer)addr_stability_v2)));

		s5_addr_stability_v2_m := map(
			s5_addr_stability_v2 = 0 => 0.1461655552,
			s5_addr_stability_v2 = 1 => 0.1168293562,
			s5_addr_stability_v2 = 2 => 0.1104828186,
			s5_addr_stability_v2 = 3 => 0.0938485804,
			s5_addr_stability_v2 = 4 => 0.0794871795,
			s5_addr_stability_v2 = 5 => 0.0580645161,
										0.1250927692);

		s5_attr_addrs_last90 := min(4, if(attr_addrs_last90 = NULL, -NULL, attr_addrs_last90));

		s5_attr_addrs_last90_m := map(
			s5_attr_addrs_last90 = 0 => 0.1100093691,
			s5_attr_addrs_last90 = 1 => 0.1586829719,
			s5_attr_addrs_last90 = 2 => 0.1978542127,
			s5_attr_addrs_last90 = 3 => 0.2055555556,
			s5_attr_addrs_last90 = 4 => 0.2666666667,
										0.1250927692);

		s5_addrs_per_adl_c6 := min(3, if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6));

		s5_addrs_per_adl_c6_m := map(
			s5_addrs_per_adl_c6 = 0 => 0.1005393854,
			s5_addrs_per_adl_c6 = 1 => 0.1431239074,
			s5_addrs_per_adl_c6 = 2 => 0.1798456548,
			s5_addrs_per_adl_c6 = 3 => 0.1870187019,
									   0.1250927692);

		s5mobility3 := -4.997241549 +
			s5_mth_add1_m * 4.1130824187 +
			s5_addrs_per_ssn_m * 6.7788536533 +
			s5_addrs_per_adl_m * 1.3824858826 +
			s5_addr_stability_v2_m * 5.5294811745 +
			s5_attr_addrs_last90_m * 2.5938722257 +
			s5_addrs_per_adl_c6_m * 3.5880218595;

		s5_phones_per_addr := map(
			phones_per_addr = 1 => 1,
			phones_per_addr = 0 => 2,
								   3);

		s5_phones_per_addr_m := map(
			s5_phones_per_addr = 1 => 0.107459475,
			s5_phones_per_addr = 2 => 0.1321827072,
			s5_phones_per_addr = 3 => 0.1446636318,
									  0.1250927692);

		s5_add_risk := StringLib.StringToUpperCase(rc_addrvalflag) != 'V' or rc_ziptypeflag = (string)5 or StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add2_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y';

		s5_other_good := addr_hist_advo_college or email_domain_EDU_count > 0 or PAW_active_phone_count > 0;

		nap_summary_1 := (nap_summary in [1, 6]);

		s5_inq_count01 := min(2, if(Inq_count01 = NULL, -NULL, Inq_count01));

		s5_inq_count03 := min(3, if(Inq_count03 = NULL, -NULL, Inq_count03));

		s5_inq_count01_m := map(
			s5_inq_count01 = 0 => 0.1222482903,
			s5_inq_count01 = 1 => 0.281881804,
			s5_inq_count01 = 2 => 0.3842364532,
								  0.1250927692);

		s5_inq_count03_m := map(
			s5_inq_count03 = 0 => 0.119748516,
			s5_inq_count03 = 1 => 0.2453262787,
			s5_inq_count03 = 2 => 0.323630137,
			s5_inq_count03 = 3 => 0.4695652174,
								  0.1250927692);

		s5_inq_communications_count12 := min(1, if(Inq_Communications_count12 = NULL, -NULL, Inq_Communications_count12));

		s5_inq_communications_count12_m := map(
			s5_inq_communications_count12 = 0 => 0.1239701553,
			s5_inq_communications_count12 = 1 => 0.307,
												 0.1250927692);

		s5_inq_phonesperadl := min(2, if(Inq_PhonesPerADL = NULL, -NULL, Inq_PhonesPerADL));

		s5_inq_phonesperadl_m := map(
			s5_inq_phonesperadl = 0 => 0.117697754,
			s5_inq_phonesperadl = 1 => 0.2097720994,
			s5_inq_phonesperadl = 2 => 0.3453355155,
									   0.1250927692);

		s5_inq_lnamesperssn := min(1, if(Inq_LNamesPerSSN = NULL, -NULL, Inq_LNamesPerSSN));

		s5_inq_lnamesperssn_m := map(
			s5_inq_lnamesperssn = 0 => 0.1176233755,
			s5_inq_lnamesperssn = 1 => 0.2232437121,
									   0.1250927692);

		s5_inq_peraddr := min(3, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr));

		s5_inq_peraddr_m := map(
			s5_inq_peraddr = 0 => 0.113922836,
			s5_inq_peraddr = 1 => 0.2018404908,
			s5_inq_peraddr = 2 => 0.2647854658,
			s5_inq_peraddr = 3 => 0.301650165,
								  0.1250927692);

		s5_inq_adlsperphone := min(1, if(Inq_ADLsPerPhone = NULL, -NULL, Inq_ADLsPerPhone));

		s5_inq_adlsperphone_m := map(
			s5_inq_adlsperphone = 0 => 0.1243364412,
			s5_inq_adlsperphone = 1 => 0.3120243531,
									   0.1250927692);

		s5inq2 := -3.876680176 +
			s5_inq_count01_m * 1.072053287 +
			s5_inq_count03_m * 1.6447391062 +
			s5_inq_communications_count12_m * 2.0598318251 +
			s5_inq_phonesperadl_m * 1.3114174384 +
			s5_inq_lnamesperssn_m * 0.9015844565 +
			s5_inq_peraddr_m * 5.1541956821 +
			s5_inq_adlsperphone_m * 3.0698858742;

		s5_email_count := min(4, if(email_count = NULL, -NULL, email_count));

		s5_email_count_m := map(
			s5_email_count = 0 => 0.1208729634,
			s5_email_count = 1 => 0.1454219031,
			s5_email_count = 2 => 0.1604412133,
			s5_email_count = 3 => 0.1694417238,
			s5_email_count = 4 => 0.1869369369,
								  0.1250927692);

		s5_econtrj := if(_econtrj = -1, -1, max(3, min(6, if(_econtrj = NULL, -NULL, _econtrj))));

		s5_econtrj_m := map(
			s5_econtrj = -1 => 0.1210663074,
			s5_econtrj = 3  => 0.1169990743,
			s5_econtrj = 4  => 0.1561878642,
			s5_econtrj = 5  => 0.1903711394,
			s5_econtrj = 6  => 0.2033450704,
							   0.1250927692);

		s5_dist_a1toa2_1to10 := 0 < dist_a1toa2 AND dist_a1toa2 <= 10;

		s5_dist_a1toa3_1to10 := 0 < dist_a1toa3 AND dist_a1toa3 <= 10;

		s5_mth_header_first_seen := map(
			mth_header_first_seen < 6   => 4,
			mth_header_first_seen < 24  => 3,
			mth_header_first_seen < 120 => 2,
										   1);

		s5_mth_header_first_seen_m := map(
			s5_mth_header_first_seen = 1 => 0.05,
			s5_mth_header_first_seen = 2 => 0.0966481596,
			s5_mth_header_first_seen = 3 => 0.1149160269,
			s5_mth_header_first_seen = 4 => 0.1551324693,
											0.1250927692);

		s5_attr_num_nonderogs180 := min(4, if(attr_num_nonderogs180 = NULL, -NULL, attr_num_nonderogs180));

		s5_attr_num_nonderogs180_m := map(
			s5_attr_num_nonderogs180 = 0 => 0.1804158283,
			s5_attr_num_nonderogs180 = 1 => 0.1249632545,
			s5_attr_num_nonderogs180 = 2 => 0.1237628975,
			s5_attr_num_nonderogs180 = 3 => 0.1136127468,
			s5_attr_num_nonderogs180 = 4 => 0.09375,
											0.1250927692);

		s5_naprop := map(
			add1_naprop >= 3 => 1,
			add1_naprop = 0  => 2,
								3);

		s5_naprop_m := map(
			s5_naprop = 1 => 0.0746727178,
			s5_naprop = 2 => 0.139590191,
			s5_naprop = 3 => 0.1716679288,
							 0.1250927692);

		s5_adlperssn_count := max(1, min(4, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		s5_adlperssn_count_m := map(
			s5_adlperssn_count = 1 => 0.114893285,
			s5_adlperssn_count = 2 => 0.154087275,
			s5_adlperssn_count = 3 => 0.1910441924,
			s5_adlperssn_count = 4 => 0.2307137707,
									  0.1250927692);

		s5_ssns_per_adl_c6 := min(3, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6));

		s5_ssns_per_adl_c6_m := map(
			s5_ssns_per_adl_c6 = 0 => 0.1004950805,
			s5_ssns_per_adl_c6 = 1 => 0.1475235935,
			s5_ssns_per_adl_c6 = 2 => 0.2226787182,
			s5_ssns_per_adl_c6 = 3 => 0.3043478261,
									  0.1250927692);

		s5_estimated_income := map(
			estimated_income <= 0     => -1,
			estimated_income <= 20000 => 15,
			estimated_income <= 22000 => 14,
			estimated_income <= 23000 => 13,
			estimated_income <= 24000 => 12,
			estimated_income <= 26000 => 11,
			estimated_income <= 27000 => 10,
			estimated_income <= 30000 => 9,
			estimated_income <= 40000 => 7,
			estimated_income <= 50000 => 6,
			estimated_income <= 60000 => 5,
			estimated_income <= 70000 => 4,
			estimated_income <= 80000 => 3,
			estimated_income <= 90000 => 2,
										 1);

		s5_wealth_index := min(4, if(wealth_index = '', -NULL, (integer)wealth_index));

		s5_estimated_income_m := map(
			s5_estimated_income = -1 => 0.1105263158,
			s5_estimated_income = 1  => 0.0438917337,
			s5_estimated_income = 2  => 0.0572519084,
			s5_estimated_income = 3  => 0.0592804579,
			s5_estimated_income = 4  => 0.0755653613,
			s5_estimated_income = 5  => 0.0813875917,
			s5_estimated_income = 6  => 0.0842618384,
			s5_estimated_income = 7  => 0.0999812909,
			s5_estimated_income = 9  => 0.1143312802,
			s5_estimated_income = 10 => 0.1256952169,
			s5_estimated_income = 11 => 0.1333333333,
			s5_estimated_income = 12 => 0.1387693632,
			s5_estimated_income = 13 => 0.1514352211,
			s5_estimated_income = 14 => 0.1543025251,
			s5_estimated_income = 15 => 0.1633416459,
										0.1250927692);

		s5_wealth_index_m := map(
			s5_wealth_index = 0 => 0.1281682599,
			s5_wealth_index = 1 => 0.1984470659,
			s5_wealth_index = 2 => 0.1689774697,
			s5_wealth_index = 3 => 0.1136141747,
			s5_wealth_index = 4 => 0.0874324777,
								   0.1250927692);

		s502c := -6.659280748 +
			s5_minor_src_ver_i_m * 5.2004062309 +
			(integer)s5_phone_risk * 0.4155075799 +
			s5avm02 * 0.4012694898 +
			(integer)s5_mortgage_risky * 0.3404866804 +
			s5_ssns_per_addr_m * 2.3121997995 +
			s5_id_per_addr_diff_m * 3.8170158013 +
			s5_ssns_per_addr_c6_m * 2.6330584344 +
			s5_id_per_addr_c6_diff_m * 3.3297768077 +
			s5ams2 * 0.7131521148 +
			s5_state_m * 6.0711130746 +
			(integer)s5_other_risk * 0.0662605072 +
			s5_rc_dirsaddr_lastscore_m * 2.3107015151 +
			s5mobility3 * 0.1971052669 +
			s5_phones_per_addr_m * 1.8034960037 +
			(integer)s5_add_risk * 0.19908208 +
			(integer)s5_other_good * -0.727151195 +
			(integer)nap_summary_1 * 0.5786509728 +
			s5inq2 * 0.6644938044 +
			s5_email_count_m * 12.431111945 +
			s5_econtrj_m * 3.1524783561 +
			(integer)s5_dist_a1toa2_1to10 * 0.1785108154 +
			(integer)s5_dist_a1toa3_1to10 * 0.1460146608 +
			s5_mth_header_first_seen_m * 2.5235480524 +
			s5_attr_num_nonderogs180_m * 5.842012583 +
			(integer)add1_isbestmatch * -0.057305749 +
			s5_naprop_m * 3.4992992744 +
			s5_adlperssn_count_m * 5.6835241672 +
			s5_ssns_per_adl_c6_m * 1.4451828186 +
			s5_estimated_income_m * 3.4836763181 +
			s5_wealth_index_m * 1.3704005382;

		s6_add_phone_risk := StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add2_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y' or StringLib.StringToUpperCase(nap_status) = 'D';

		s6_addrs_per_ssn := max(1, min(5, if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn)));

		s6_addrs_per_ssn_m := map(
			s6_addrs_per_ssn = 1 => 0.0645675568,
			s6_addrs_per_ssn = 2 => 0.0789719626,
			s6_addrs_per_ssn = 3 => 0.0816921955,
			s6_addrs_per_ssn = 4 => 0.1201044386,
			s6_addrs_per_ssn = 5 => 0.1360332295,
									0.0859465738);

		s6_attr_addrs_last24 := max(1, min(4, if(attr_addrs_last24 = NULL, -NULL, attr_addrs_last24)));

		s6_attr_addrs_last24_m := map(
			s6_attr_addrs_last24 = 1 => 0.0826227023,
			s6_attr_addrs_last24 = 2 => 0.0837957825,
			s6_attr_addrs_last24 = 3 => 0.0945179584,
			s6_attr_addrs_last24 = 4 => 0.2056737589,
										0.0859465738);

		s6_mth_header_first_seen := map(
			mth_header_first_seen2 <= 0 => -1,
			mth_header_first_seen2 <= 5 => 4,
			mth_header_first_seen2 <= 6 => 3,
			mth_header_first_seen2 <= 7 => 2,
										   1);

		s6_mth_header_first_seen_m := map(
			s6_mth_header_first_seen = 1 => 0.0796846167,
			s6_mth_header_first_seen = 2 => 0.1085858586,
			s6_mth_header_first_seen = 3 => 0.1223776224,
			s6_mth_header_first_seen = 4 => 0.1021699819,
											0.0859465738);

		s6_rc_addrcount := min(3, if(rc_addrcount = NULL, -NULL, rc_addrcount));

		s6_rc_addrcount_m := map(
			s6_rc_addrcount = 0 => 0.1470588235,
			s6_rc_addrcount = 1 => 0.0912934845,
			s6_rc_addrcount = 2 => 0.074875208,
			s6_rc_addrcount = 3 => 0.0482374768,
								   0.0859465738);

		s6_add2_marketvalue := map(
			(integer)add2_avm_market_total_value <= 0      => -1,
			(integer)add2_avm_market_total_value <= 47600  => 5,
			(integer)add2_avm_market_total_value <= 127700 => 4,
			(integer)add2_avm_market_total_value <= 179375 => 3,
			(integer)add2_avm_market_total_value <= 412000 => 2,
															 1);

		s6_add2_marketvalue_m := map(
			s6_add2_marketvalue = -1 => 0.080337651,
			s6_add2_marketvalue = 1  => 0.023255814,
			s6_add2_marketvalue = 2  => 0.0636363636,
			s6_add2_marketvalue = 3  => 0.1477272727,
			s6_add2_marketvalue = 4  => 0.1477272727,
			s6_add2_marketvalue = 5  => 0.2413793103,
										0.0859465738);

		s6_add3_marketvalue := map(
			add3_market_total_value <= 0      => -1,
			add3_market_total_value <= 66100  => 5,
			add3_market_total_value <= 89090  => 4,
			add3_market_total_value <= 298250 => 3,
			add3_market_total_value <= 490000 => 2,
												 1);

		s6_add3_marketvalue_m := map(
			s6_add3_marketvalue = -1 => 0.0821801751,
			s6_add3_marketvalue = 1  => 0.0303030303,
			s6_add3_marketvalue = 2  => 0.0895522388,
			s6_add3_marketvalue = 3  => 0.1047904192,
			s6_add3_marketvalue = 4  => 0.1791044776,
			s6_add3_marketvalue = 5  => 0.2180451128,
										0.0859465738);

		s6_buildingarea := map(
			(integer)add1_building_area <= 0    => -1,
			(integer)add1_building_area <= 1032 => 6,
			(integer)add1_building_area <= 1464 => 5,
			(integer)add1_building_area <= 2069 => 4,
			(integer)add1_building_area <= 2384 => 3,
			(integer)add1_building_area <= 2882 => 2,
												  1);

		s6_buildingarea_m := map(
			s6_buildingarea = -1 => 0.0820361801,
			s6_buildingarea = 1  => 0.0372439479,
			s6_buildingarea = 2  => 0.0484171322,
			s6_buildingarea = 3  => 0.0686456401,
			s6_buildingarea = 4  => 0.0820895522,
			s6_buildingarea = 5  => 0.1098696462,
			s6_buildingarea = 6  => 0.1462962963,
									0.0859465738);

		s6_mortgage_risky := StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' or StringLib.StringToUpperCase(add2_financing_type) = 'ADJ' or StringLib.StringToUpperCase(add3_financing_type) = 'ADJ';

		s6_ams_college_tier := map(
			ams_college_tier = (string)0 => 4,
			ams_college_tier = (string)1 => 1,
			ams_college_tier = (string)2 => 2,
			ams_college_tier = (string)3 => 3,
			ams_college_tier = (string)4 => 4,
			ams_college_tier = (string)5 => 5,
			ams_college_tier = (string)6 => 5,
											-1);

		s6_ams_income_level := map(
			StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 4,
			StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
																		-1);

		s6_ams_college_tier_m := map(
			s6_ams_college_tier = -1 => 0.0907654747,
			s6_ams_college_tier = 1  => 0,
			s6_ams_college_tier = 2  => 0.0126582278,
			s6_ams_college_tier = 3  => 0.025,
			s6_ams_college_tier = 4  => 0.0333333333,
			s6_ams_college_tier = 5  => 0.0848214286,
										0.0859465738);

		s6_ams_income_level_m := map(
			s6_ams_income_level = -1 => 0.087414966,
			s6_ams_income_level = 1  => 0.0398550725,
			s6_ams_income_level = 2  => 0.04,
			s6_ams_income_level = 3  => 0.0551724138,
			s6_ams_income_level = 4  => 0.0695187166,
			s6_ams_income_level = 5  => 0.0789473684,
			s6_ams_income_level = 6  => 0.0853432282,
			s6_ams_income_level = 7  => 0.100456621,
			s6_ams_income_level = 8  => 0.1869918699,
			s6_ams_income_level = 9  => 0.2222222222,
										0.0859465738);

		s6_adls_per_addr := adls_per_addr >= 10;

		s6_adls_per_addr_c6 := min(5, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		s6_adls_per_addr_c6_m := map(
			s6_adls_per_addr_c6 = 0 => 0.0741284404,
			s6_adls_per_addr_c6 = 1 => 0.0821974391,
			s6_adls_per_addr_c6 = 2 => 0.086335826,
			s6_adls_per_addr_c6 = 3 => 0.1162790698,
			s6_adls_per_addr_c6 = 4 => 0.1241134752,
			s6_adls_per_addr_c6 = 5 => 0.1419753086,
									   0.0859465738);

		s6_estimated_income := map(
			estimated_income <= 0     => -1,
			estimated_income <= 22000 => 9,
			estimated_income <= 27000 => 8,
			estimated_income <= 29000 => 7,
			estimated_income <= 30000 => 6,
			estimated_income <= 35000 => 5,
			estimated_income <= 42000 => 4,
			estimated_income <= 48000 => 3,
			estimated_income <= 78000 => 2,
										 1);

		s6_estimated_income_m := map(
			s6_estimated_income = -1 => 0,
			s6_estimated_income = 1  => 0.0472440945,
			s6_estimated_income = 2  => 0.0552677029,
			s6_estimated_income = 3  => 0.0651558074,
			s6_estimated_income = 4  => 0.0813953488,
			s6_estimated_income = 5  => 0.0787956438,
			s6_estimated_income = 6  => 0.1013071895,
			s6_estimated_income = 7  => 0.111747851,
			s6_estimated_income = 8  => 0.109223301,
			s6_estimated_income = 9  => 0.1275362319,
										0.0859465738);

		s6_inq_count12 := min(2, if(Inq_count12 = NULL, -NULL, Inq_count12));

		s6_inq_peraddr := min(2, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr));

		s6_inq_count12_m := map(
			s6_inq_count12 = 0 => 0.0802323973,
			s6_inq_count12 = 1 => 0.1517241379,
			s6_inq_count12 = 2 => 0.2352941176,
								  0.0859465738);

		s6_inq_peraddr_m := map(
			s6_inq_peraddr = 0 => 0.078966056,
			s6_inq_peraddr = 1 => 0.1329690346,
			s6_inq_peraddr = 2 => 0.2327044025,
								  0.0859465738);

		s6_state := map(
			out_st = 'AE' => 1,
			out_st = 'AP' => 1,
			out_st = 'DC' => 1,
			out_st = 'IA' => 1,
			out_st = 'MT' => 1,
			out_st = 'ND' => 1,
			out_st = 'NE' => 1,
			out_st = 'NH' => 1,
			out_st = 'NM' => 1,
			out_st = 'PR' => 4,
			out_st = 'RI' => 4,
			out_st = 'SD' => 1,
			out_st = 'VT' => 1,
			out_st = 'WY' => 1,
			out_st = 'MA' => 1,
			out_st = 'NC' => 1,
			out_st = 'UT' => 1,
			out_st = 'CT' => 2,
			out_st = 'WV' => 2,
			out_st = 'PA' => 2,
			out_st = 'NY' => 2,
			out_st = 'VA' => 2,
			out_st = 'WA' => 2,
			out_st = 'KS' => 3,
			out_st = 'IN' => 3,
			out_st = 'OR' => 3,
			out_st = 'NJ' => 3,
			out_st = 'SC' => 3,
			out_st = 'MD' => 3,
			out_st = 'MN' => 3,
			out_st = 'AK' => 4,
			out_st = 'IL' => 4,
			out_st = 'CO' => 4,
			out_st = 'KY' => 4,
			out_st = 'WI' => 4,
			out_st = 'OH' => 5,
			out_st = 'TN' => 5,
			out_st = 'MO' => 5,
			out_st = 'FL' => 5,
			out_st = 'LA' => 5,
			out_st = 'ME' => 5,
			out_st = 'AR' => 5,
			out_st = 'GA' => 5,
			out_st = 'CA' => 5,
			out_st = 'NV' => 5,
			out_st = 'MI' => 5,
			out_st = 'TX' => 6,
			out_st = 'AZ' => 6,
			out_st = 'DE' => 6,
			out_st = 'AL' => 6,
			out_st = 'MS' => 6,
			out_st = 'OK' => 6,
			out_st = 'ID' => 6,
			out_st = 'HI' => 6,
							 -1);

		s6_state_m := map(
			s6_state = 1 => 0.0277777778,
			s6_state = 2 => 0.050154321,
			s6_state = 3 => 0.0743455497,
			s6_state = 4 => 0.0816,
			s6_state = 5 => 0.1027823241,
			s6_state = 6 => 0.1227197347,
							0.0859465738);

		s603 := -11.98760781 +
			(integer)s6_add_phone_risk * 0.7975487106 +
			s6_addrs_per_ssn_m * 5.8328792369 +
			s6_attr_addrs_last24_m * 6.7339108241 +
			s6_mth_header_first_seen_m * 9.1468042693 +
			s6_rc_addrcount_m * 9.8451767138 +
			(integer)add1_isbestmatch * -0.200001029 +
			s6_add2_marketvalue_m * 5.7874597852 +
			s6_add3_marketvalue_m * 3.6205171668 +
			s6_buildingarea_m * 7.833049187 +
			(integer)s6_mortgage_risky * 0.3866060123 +
			s6_ams_college_tier_m * 18.162911864 +
			s6_ams_income_level_m * 5.7482517424 +
			(integer)s6_adls_per_addr * 0.3656385088 +
			s6_adls_per_addr_c6_m * 5.8828227563 +
			s6_estimated_income_m * 9.4821781157 +
			s6_inq_count12_m * 4.1044576023 +
			s6_inq_peraddr_m * 4.1560429608 +
			s6_state_m * 10.924036441;

		s7_age := map(
			age <= 0  => -1,
			age <= 18 => 5,
			age <= 19 => 4,
			age <= 20 => 3,
			age <= 21 => 2,
						 1);

		s7_age_m := map(
			s7_age = -1 => 0.0984538317,
			s7_age = 1  => 0.0442935878,
			s7_age = 2  => 0.0710362505,
			s7_age = 3  => 0.0804289544,
			s7_age = 4  => 0.1123978202,
			s7_age = 5  => 0.1427378965,
						   0.070023387);

		s7_phone_risk := rc_hriskphoneflag = (string)6 or (rc_hphonetypeflag in ['2', '5']) or rc_hphonevalflag = (string)3 or rc_pwphonezipflag = (string)2 or StringLib.StringToUpperCase(nap_status) = 'D';

		s7_avg_lres := map(
			avg_lres <= 0  => -1,
			avg_lres <= 8  => 9,
			avg_lres <= 11 => 8,
			avg_lres <= 14 => 7,
			avg_lres <= 26 => 6,
			avg_lres <= 29 => 5,
			avg_lres <= 37 => 4,
			avg_lres <= 69 => 3,
			avg_lres <= 82 => 2,
							  1);

		s7_avg_lres_m := map(
			s7_avg_lres = -1 => 0.2181818182,
			s7_avg_lres = 1  => 0.0534923339,
			s7_avg_lres = 2  => 0.0552978951,
			s7_avg_lres = 3  => 0.0507221058,
			s7_avg_lres = 4  => 0.0567052496,
			s7_avg_lres = 5  => 0.0626092021,
			s7_avg_lres = 6  => 0.0740740741,
			s7_avg_lres = 7  => 0.1015075377,
			s7_avg_lres = 8  => 0.1146048821,
			s7_avg_lres = 9  => 0.1526172672,
								0.070023387);

		s7_avg_mo_per_addr := map(
			avg_mo_per_addr <= 0 => -1,
			avg_mo_per_addr <= 6 => 2,
									1);

		s7_avg_mo_per_addr_m := map(
			s7_avg_mo_per_addr = -1 => 0.0730730731,
			s7_avg_mo_per_addr = 1  => 0.0670731707,
			s7_avg_mo_per_addr = 2  => 0.1549071618,
									   0.070023387);

		s7_addrs_per_ssn_c6 := min(2, if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6));

		s7_addrs_per_ssn_c6_m := map(
			s7_addrs_per_ssn_c6 = 0 => 0.0646487076,
			s7_addrs_per_ssn_c6 = 1 => 0.1100683951,
			s7_addrs_per_ssn_c6 = 2 => 0.1159695817,
									   0.070023387);

		s7_attr_addrs_last90 := min(3, if(attr_addrs_last90 = NULL, -NULL, attr_addrs_last90));

		s7_attr_addrs_last90_m := map(
			s7_attr_addrs_last90 = 0 => 0.0647359104,
			s7_attr_addrs_last90 = 1 => 0.0970873786,
			s7_attr_addrs_last90 = 2 => 0.087790111,
			s7_attr_addrs_last90 = 3 => 0.1503759398,
										0.070023387);

		s7_age_on_eq := age_on_eq != NULL and age_on_eq < 15;

		s7_mth_gong_did := map(
			mth_gong_did_first_seen2 <= 0  => -1,
			mth_gong_did_first_seen2 <= 6  => 10,
			mth_gong_did_first_seen2 <= 12 => 9,
			mth_gong_did_first_seen2 <= 18 => 8,
			mth_gong_did_first_seen2 <= 43 => 7,
			mth_gong_did_first_seen2 <= 50 => 6,
			mth_gong_did_first_seen2 <= 56 => 5,
			mth_gong_did_first_seen2 <= 65 => 4,
			mth_gong_did_first_seen2 <= 70 => 3,
			mth_gong_did_first_seen2 <= 84 => 2,
											  1);

		s7_mth_gong_did_m := map(
			s7_mth_gong_did = -1 => 0.074930009,
			s7_mth_gong_did = 1  => 0.0414507772,
			s7_mth_gong_did = 2  => 0.0397745067,
			s7_mth_gong_did = 3  => 0.0495780591,
			s7_mth_gong_did = 4  => 0.0506117909,
			s7_mth_gong_did = 5  => 0.0485553772,
			s7_mth_gong_did = 6  => 0.0564692982,
			s7_mth_gong_did = 7  => 0.0664031621,
			s7_mth_gong_did = 8  => 0.0894632207,
			s7_mth_gong_did = 9  => 0.0983118173,
			s7_mth_gong_did = 10 => 0.136627907,
									0.070023387);

		s7_attr_num_nonderogs30 := min(3, if(attr_num_nonderogs30 = NULL, -NULL, attr_num_nonderogs30));

		s7_attr_num_nonderogs30_m := map(
			s7_attr_num_nonderogs30 = 0 => 0.1732065002,
			s7_attr_num_nonderogs30 = 1 => 0.0745117082,
			s7_attr_num_nonderogs30 = 2 => 0.0504950495,
			s7_attr_num_nonderogs30 = 3 => 0.0359647139,
										   0.070023387);

		s7_rc_dirsaddr_lastscore := map(
			rc_dirsaddr_lastscore = 255 => -1,
			rc_dirsaddr_lastscore < 60  => 3,
			rc_dirsaddr_lastscore < 100 => 2,
										   1);

		s7_rc_dirsaddr_lastscore_m := map(
			s7_rc_dirsaddr_lastscore = -1 => 0.0750231034,
			s7_rc_dirsaddr_lastscore = 1  => 0.0507387159,
			s7_rc_dirsaddr_lastscore = 2  => 0.0659793814,
			s7_rc_dirsaddr_lastscore = 3  => 0.0991820041,
											 0.070023387);

		s7_prop_owner := map(
			add1_naprop = 4 and prop_owned_flag                                                => 1,
			add1_naprop = 4 or (add1_naprop in [3, 0]) and (prop_owned_flag or prop_sold_flag) => 2,
			add1_naprop = 3 or prop_owned_flag or prop_sold_flag                               => 3,
			add1_naprop = 2                                                                    => 4,
			add1_naprop = 0                                                                    => 5,
																								  6);

		s7_prop_owner_m := map(
			s7_prop_owner = 1 => 0.0382152007,
			s7_prop_owner = 2 => 0.0457142857,
			s7_prop_owner = 3 => 0.0468374133,
			s7_prop_owner = 4 => 0.0638002774,
			s7_prop_owner = 5 => 0.0865191147,
			s7_prop_owner = 6 => 0.1047802551,
								 0.070023387);

		s7_rc_numelever := max(3, min(6, if(rc_numelever = NULL, -NULL, rc_numelever)));

		s7_rc_numelever_m := map(
			s7_rc_numelever = 3 => 0.1268507403,
			s7_rc_numelever = 4 => 0.0852149598,
			s7_rc_numelever = 5 => 0.0424411988,
			s7_rc_numelever = 6 => 0.0303819444,
								   0.070023387);

		s7_add2_avm := map(
			add2_avm_automated_valuation <= 0      => -1,
			add2_avm_automated_valuation <= 60267  => 7,
			add2_avm_automated_valuation <= 84000  => 6,
			add2_avm_automated_valuation <= 396744 => 5,
			add2_avm_automated_valuation <= 507000 => 4,
			add2_avm_automated_valuation <= 590000 => 3,
			add2_avm_automated_valuation <= 725000 => 2,
													  1);

		s7_add2_avm_m := map(
			s7_add2_avm = -1 => 0.0703208817,
			s7_add2_avm = 1  => 0.0397660819,
			s7_add2_avm = 2  => 0.049122807,
			s7_add2_avm = 3  => 0.0673635308,
			s7_add2_avm = 4  => 0.0740956826,
			s7_add2_avm = 5  => 0.0654398564,
			s7_add2_avm = 6  => 0.0944055944,
			s7_add2_avm = 7  => 0.1365227538,
								0.070023387);

		s7_add3_marketvalue := map(
			add3_market_total_value <= 0      => -1,
			add3_market_total_value <= 48855  => 7,
			add3_market_total_value <= 77880  => 6,
			add3_market_total_value <= 103470 => 5,
			add3_market_total_value <= 128066 => 4,
			add3_market_total_value <= 233474 => 3,
			add3_market_total_value <= 508600 => 2,
												 1);

		s7_add3_avm := map(
			add3_avm_automated_valuation <= 0      => -1,
			add3_avm_automated_valuation <= 80000  => 5,
			add3_avm_automated_valuation <= 117500 => 4,
			add3_avm_automated_valuation <= 278017 => 3,
			add3_avm_automated_valuation <= 440251 => 2,
													  1);

		s7_add3_marketvalue_m := map(
			s7_add3_marketvalue = -1 => 0.0691453463,
			s7_add3_marketvalue = 1  => 0.0551351351,
			s7_add3_marketvalue = 2  => 0.0610480821,
			s7_add3_marketvalue = 3  => 0.0576161325,
			s7_add3_marketvalue = 4  => 0.0691891892,
			s7_add3_marketvalue = 5  => 0.0862998921,
			s7_add3_marketvalue = 6  => 0.1090712743,
			s7_add3_marketvalue = 7  => 0.132034632,
										0.070023387);

		s7_add3_avm_m := map(
			s7_add3_avm = -1 => 0.0688838189,
			s7_add3_avm = 1  => 0.0620771986,
			s7_add3_avm = 2  => 0.068814638,
			s7_add3_avm = 3  => 0.0662422916,
			s7_add3_avm = 4  => 0.0804780876,
			s7_add3_avm = 5  => 0.1342335187,
								0.070023387);

		s7_add1_avm_med := map(
			add1_avm_med <= 0      => -1,
			add1_avm_med <= 68785  => 8,
			add1_avm_med <= 89894  => 7,
			add1_avm_med <= 107980 => 6,
			add1_avm_med <= 406937 => 5,
			add1_avm_med <= 455492 => 4,
			add1_avm_med <= 518687 => 3,
			add1_avm_med <= 719952 => 2,
									  1);

		s7_add1_avm_med_m := map(
			s7_add1_avm_med = -1 => 0.0676599081,
			s7_add1_avm_med = 1  => 0.0402275498,
			s7_add1_avm_med = 2  => 0.0586921202,
			s7_add1_avm_med = 3  => 0.0650406504,
			s7_add1_avm_med = 4  => 0.068264933,
			s7_add1_avm_med = 5  => 0.0673754063,
			s7_add1_avm_med = 6  => 0.0855636659,
			s7_add1_avm_med = 7  => 0.1030130293,
			s7_add1_avm_med = 8  => 0.1210889882,
									0.070023387);

		s7_add1_2story := add1_no_of_stories = (string)2;

		s7_mortgage_risky := (StringLib.StringToUpperCase(add1_mortgage_type) in ['H', 'S']);

		s7_ams_college_tier := map(
			ams_college_tier = (string)0 => 3,
			ams_college_tier = (string)1 => 1,
			ams_college_tier = (string)2 => 1,
			ams_college_tier = (string)3 => 3,
			ams_college_tier = (string)4 => 4,
			ams_college_tier = (string)5 => 5,
			ams_college_tier = (string)6 => 6,
											-1);

		s7_ams_income_level := map(
			StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 10,
			StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 10,
			StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 8,
			StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 4,
			StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 2,
			StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
																		-1);

		s7_ams_college_tier_m := map(
			s7_ams_college_tier = -1 => 0.0821042496,
			s7_ams_college_tier = 1  => 0.0093994778,
			s7_ams_college_tier = 3  => 0.0132544379,
			s7_ams_college_tier = 4  => 0.0296180826,
			s7_ams_college_tier = 5  => 0.0421052632,
			s7_ams_college_tier = 6  => 0.0794701987,
										0.070023387);

		s7_ams_income_level_m := map(
			s7_ams_income_level = -1 => 0.0840163357,
			s7_ams_income_level = 1  => 0.0169491525,
			s7_ams_income_level = 2  => 0.0263752826,
			s7_ams_income_level = 3  => 0.0295040804,
			s7_ams_income_level = 4  => 0.0338983051,
			s7_ams_income_level = 5  => 0.0342793955,
			s7_ams_income_level = 6  => 0.0475594493,
			s7_ams_income_level = 7  => 0.0540540541,
			s7_ams_income_level = 8  => 0.071866485,
			s7_ams_income_level = 9  => 0.1090573013,
			s7_ams_income_level = 10 => 0.1292517007,
										0.070023387);

		s7_ams_class_gr := StringLib.StringToUpperCase(ams_class) = 'GR';

		s7_ssns_per_adl := if(ssns_per_adl = 0, 2, min(4, if(ssns_per_adl = NULL, -NULL, ssns_per_adl)));

		s7_ssns_per_adl_m := map(
			s7_ssns_per_adl = 1 => 0.0652354262,
			s7_ssns_per_adl = 2 => 0.0930142303,
			s7_ssns_per_adl = 3 => 0.1251461988,
			s7_ssns_per_adl = 4 => 0.1506849315,
								   0.070023387);

		s7_adlperssn := if(adlperssn_count = 0, 3, min(4, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		s7_adlperssn_m := map(
			s7_adlperssn = 1 => 0.0642635947,
			s7_adlperssn = 2 => 0.0785340314,
			s7_adlperssn = 3 => 0.0872058533,
			s7_adlperssn = 4 => 0.1319942611,
								0.070023387);

		s7_ssns_per_adl_c6 := min(3, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6));

		s7_ssns_per_adl_c6_m := map(
			s7_ssns_per_adl_c6 = 0 => 0.0644633508,
			s7_ssns_per_adl_c6 = 1 => 0.0775281964,
			s7_ssns_per_adl_c6 = 2 => 0.1850828729,
			s7_ssns_per_adl_c6 = 3 => 0.3125,
									  0.070023387);

		s7_adls_per_addr := map(
			adls_per_addr = 0   => -2,
			adls_per_addr = 1   => -1,
			adls_per_addr <= 6  => 1,
			adls_per_addr <= 9  => 2,
			adls_per_addr <= 15 => 3,
			adls_per_addr <= 20 => 4,
								   5);

		s7_adls_per_addr_m := map(
			s7_adls_per_addr = -2 => 0.0780190739,
			s7_adls_per_addr = -1 => 0.0906062625,
			s7_adls_per_addr = 1  => 0.0444767241,
			s7_adls_per_addr = 2  => 0.0561967425,
			s7_adls_per_addr = 3  => 0.0681303947,
			s7_adls_per_addr = 4  => 0.0858237548,
			s7_adls_per_addr = 5  => 0.1177302957,
									 0.070023387);

		s7_adls_per_addr_c6_1 := min(5, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		s7_adls_per_addr_c6 := if(s7_adls_per_addr_c6_1 = 4, 3, s7_adls_per_addr_c6_1);

		s7_adls_per_addr_c6_m := map(
			s7_adls_per_addr_c6 = 0 => 0.0612334415,
			s7_adls_per_addr_c6 = 1 => 0.0780042164,
			s7_adls_per_addr_c6 = 2 => 0.0795107034,
			s7_adls_per_addr_c6 = 3 => 0.0954219526,
			s7_adls_per_addr_c6 = 5 => 0.1328244275,
									   0.070023387);

		s7_phones_per_addr_c6 := min(4, if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6));

		s7_phones_per_addr_c6_m := map(
			s7_phones_per_addr_c6 = 0 => 0.0653796545,
			s7_phones_per_addr_c6 = 1 => 0.0882433921,
			s7_phones_per_addr_c6 = 2 => 0.0895045285,
			s7_phones_per_addr_c6 = 3 => 0.0964285714,
			s7_phones_per_addr_c6 = 4 => 0.1025056948,
										 0.070023387);

		s7_estimated_income := map(
			estimated_income <= 0     => -1,
			estimated_income <= 20000 => 13,
			estimated_income <= 22000 => 12,
			estimated_income <= 23000 => 11,
			estimated_income <= 24000 => 10,
			estimated_income <= 25000 => 9,
			estimated_income <= 26000 => 8,
			estimated_income <= 27000 => 7,
			estimated_income <= 28000 => 6,
			estimated_income <= 29000 => 5,
			estimated_income <= 31000 => 4,
			estimated_income <= 63000 => 3,
			estimated_income <= 73000 => 2,
										 1);

		s7_wealth_index := max(0, min(6, if(wealth_index = '', -NULL, (integer)wealth_index)));

		s7_estimated_income_m := map(
			s7_estimated_income = -1 => 0.105734767,
			s7_estimated_income = 1  => 0.037037037,
			s7_estimated_income = 2  => 0.0374953131,
			s7_estimated_income = 3  => 0.0477199242,
			s7_estimated_income = 4  => 0.0516789712,
			s7_estimated_income = 5  => 0.0548898338,
			s7_estimated_income = 6  => 0.0692871419,
			s7_estimated_income = 7  => 0.0776526378,
			s7_estimated_income = 8  => 0.0871404399,
			s7_estimated_income = 9  => 0.0894941634,
			s7_estimated_income = 10 => 0.0905089409,
			s7_estimated_income = 11 => 0.1009720916,
			s7_estimated_income = 12 => 0.1124859393,
			s7_estimated_income = 13 => 0.1374795417,
										0.070023387);

		s7_wealth_index_m := map(
			s7_wealth_index = 0 => 0.0768627451,
			s7_wealth_index = 1 => 0.1343949045,
			s7_wealth_index = 2 => 0.1013686912,
			s7_wealth_index = 3 => 0.0630028329,
			s7_wealth_index = 4 => 0.044122677,
			s7_wealth_index = 5 => 0.0382822903,
			s7_wealth_index = 6 => 0.036437247,
								   0.070023387);

		s7_inq_count12 := min(3, if(Inq_count12 = NULL, -NULL, Inq_count12));

		s7_inq_peraddr := min(3, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr));

		s7_inq_count12_m := map(
			s7_inq_count12 = 0 => 0.0658475444,
			s7_inq_count12 = 1 => 0.2229679344,
			s7_inq_count12 = 2 => 0.25,
			s7_inq_count12 = 3 => 0.3103448276,
								  0.070023387);

		s7_inq_peraddr_m := map(
			s7_inq_peraddr = 0 => 0.0646479255,
			s7_inq_peraddr = 1 => 0.1587015329,
			s7_inq_peraddr = 2 => 0.2278481013,
			s7_inq_peraddr = 3 => 0.2410714286,
								  0.070023387);

		s7_other_risk := did_count > 1 or (rc_pwssnvalflag in ['1']) or (rc_ssnstate in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'GS']) or (integer)rc_altlname1_flag = 1 or (integer)rc_altlname2_flag = 1 or liens_recent_released_count > 0 or liens_historical_released_count > 0 or email_src_im or did2_liens_recent_unrel_count > 0 or did2_liens_recent_rel_count > 0;

		s7_add_risk := StringLib.StringToUpperCase(rc_addrvalflag) != 'V' or (integer)rc_addrmiskeyflag > 0 or rc_ziptypeflag = (string)5 or StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add2_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y';

		s7_other_risk2 := map(
			(integer)s7_other_risk = 0 and (integer)s7_add_risk = 0 => 1,
			(integer)s7_other_risk = 1 and (integer)s7_add_risk = 0 => 2,
			(integer)s7_other_risk = 0 and (integer)s7_add_risk = 1 => 3,
																	   4);

		s7_other_risk2_m := map(
			s7_other_risk2 = 1 => 0.0651453316,
			s7_other_risk2 = 2 => 0.1062271062,
			s7_other_risk2 = 3 => 0.1176255038,
			s7_other_risk2 = 4 => 0.1397379913,
								  0.070023387);

		s7_other_good := addr_hist_advo_college or email_domain_EDU_count > 0 or email_domain_Corp_count > 0 or PAW_active_phone_count > 0;

		s7_email_domain_free := min(3, if(email_domain_Free_count = NULL, -NULL, email_domain_Free_count));

		s7_email_domain_free_m := map(
			s7_email_domain_free = 0 => 0.069166115,
			s7_email_domain_free = 1 => 0.0708546384,
			s7_email_domain_free = 2 => 0.0852514919,
			s7_email_domain_free = 3 => 0.1378091873,
										0.070023387);

		s705 := -13.74884194 +
			s7_age_m * 4.0736105413 +
			(integer)s7_phone_risk * 0.3940333221 +
			s7_avg_lres_m * 2.2459498818 +
			s7_avg_mo_per_addr_m * 4.4290163359 +
			s7_addrs_per_ssn_c6_m * 9.8744507097 +
			s7_attr_addrs_last90_m * 5.5281389245 +
			(integer)s7_age_on_eq * 0.5662761333 +
			s7_mth_gong_did_m * 5.6560815894 +
			s7_attr_num_nonderogs30_m * 5.3442684471 +
			s7_rc_dirsaddr_lastscore_m * 5.1914016991 +
			s7_prop_owner_m * 4.3279845596 +
			(integer)ver_src_p * -0.151324631 +
			s7_rc_numelever_m * 2.3408636348 +
			s7_add2_avm_m * 6.6045462452 +
			s7_add3_marketvalue_m * 4.9274939006 +
			s7_add3_avm_m * 4.8966794283 +
			s7_add1_avm_med_m * 6.6414769695 +
			(integer)s7_add1_2story * -0.180818032 +
			(integer)s7_mortgage_risky * 0.6907402908 +
			s7_ams_college_tier_m * 15.126912863 +
			s7_ams_income_level_m * 5.9549126047 +
			(integer)s7_ams_class_gr * -1.106158407 +
			s7_ssns_per_adl_m * 6.8907195547 +
			s7_adlperssn_m * 4.8731300153 +
			s7_ssns_per_adl_c6_m * 3.2330344641 +
			s7_adls_per_addr_m * 7.099393427 +
			s7_adls_per_addr_c6_m * 4.867042656 +
			s7_phones_per_addr_c6_m * 3.9719532842 +
			s7_estimated_income_m * 3.2558465694 +
			s7_wealth_index_m * 2.5161253665 +
			s7_inq_count12_m * 4.4578873705 +
			s7_inq_peraddr_m * 4.1868060035 +
			s7_other_risk2_m * 4.5310909318 +
			(integer)s7_other_good * -1.076326945 +
			s7_email_domain_free_m * 11.942805721;

		s8_age := map(
			age <= 31 => -1,
			age <= 35 => 8,
			age <= 37 => 7,
			age <= 39 => 6,
			age <= 44 => 5,
			age <= 45 => 4,
			age <= 49 => 3,
			age <= 56 => 2,
						 1);

		s8_age_m := map(
			s8_age = -1 => 0.0981038747,
			s8_age = 1  => 0.0095676036,
			s8_age = 2  => 0.0139965637,
			s8_age = 3  => 0.0182797128,
			s8_age = 4  => 0.0213533001,
			s8_age = 5  => 0.0227341253,
			s8_age = 6  => 0.0255821581,
			s8_age = 7  => 0.0316884755,
			s8_age = 8  => 0.0324390016,
						   0.0202730547);

		s8_mth_rc_ssnlowissue := map(
			mth_rc_ssnlowissue2 <= 0   => -1,
			mth_rc_ssnlowissue2 <= 24  => 14,
			mth_rc_ssnlowissue2 <= 60  => 13,
			mth_rc_ssnlowissue2 <= 120 => 12,
			mth_rc_ssnlowissue2 <= 245 => 11,
			mth_rc_ssnlowissue2 <= 377 => 10,
			mth_rc_ssnlowissue2 <= 389 => 9,
			mth_rc_ssnlowissue2 <= 401 => 8,
			mth_rc_ssnlowissue2 <= 425 => 7,
			mth_rc_ssnlowissue2 <= 449 => 6,
			mth_rc_ssnlowissue2 <= 460 => 5,
			mth_rc_ssnlowissue2 <= 484 => 4,
			mth_rc_ssnlowissue2 <= 496 => 3,
			mth_rc_ssnlowissue2 <= 508 => 2,
										  1);

		s8_mth_rc_ssnlowissue_m := map(
			s8_mth_rc_ssnlowissue = -1 => 0.0485898743,
			s8_mth_rc_ssnlowissue = 1  => 0.0085720439,
			s8_mth_rc_ssnlowissue = 2  => 0.0115653577,
			s8_mth_rc_ssnlowissue = 3  => 0.012173472,
			s8_mth_rc_ssnlowissue = 4  => 0.0123658106,
			s8_mth_rc_ssnlowissue = 5  => 0.0125430398,
			s8_mth_rc_ssnlowissue = 6  => 0.0156947966,
			s8_mth_rc_ssnlowissue = 7  => 0.0193528249,
			s8_mth_rc_ssnlowissue = 8  => 0.021183924,
			s8_mth_rc_ssnlowissue = 9  => 0.0213718705,
			s8_mth_rc_ssnlowissue = 10 => 0.0239852399,
			s8_mth_rc_ssnlowissue = 11 => 0.0412249706,
			s8_mth_rc_ssnlowissue = 12 => 0.0488917862,
			s8_mth_rc_ssnlowissue = 13 => 0.0716723549,
			s8_mth_rc_ssnlowissue = 14 => 0.1124031008,
										  0.0202730547);

		s8_add_risk := StringLib.StringToUpperCase(rc_addrvalflag) != 'V' or rc_ziptypeflag = (string)5 or StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add2_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y';

		s8_mth_add1 := map(
			mth_add1_date_first_seen2 = NULL => -1,
			mth_add1_date_first_seen2 <= 9   => 13,
			mth_add1_date_first_seen2 <= 17  => 12,
			mth_add1_date_first_seen2 <= 26  => 11,
			mth_add1_date_first_seen2 <= 35  => 10,
			mth_add1_date_first_seen2 <= 89  => 9,
			mth_add1_date_first_seen2 <= 100 => 8,
			mth_add1_date_first_seen2 <= 140 => 7,
			mth_add1_date_first_seen2 <= 174 => 6,
			mth_add1_date_first_seen2 <= 194 => 5,
			mth_add1_date_first_seen2 <= 218 => 4,
			mth_add1_date_first_seen2 <= 248 => 3,
			mth_add1_date_first_seen2 <= 287 => 2,
												1);

		s8_avg_lres := map(
			avg_lres <= 0   => -1,
			avg_lres <= 6   => 16,
			avg_lres <= 12  => 15,
			avg_lres <= 25  => 14,
			avg_lres <= 36  => 13,
			avg_lres <= 45  => 12,
			avg_lres <= 59  => 11,
			avg_lres <= 66  => 10,
			avg_lres <= 85  => 8,
			avg_lres <= 92  => 7,
			avg_lres <= 100 => 6,
			avg_lres <= 126 => 5,
			avg_lres <= 150 => 4,
			avg_lres <= 194 => 3,
			avg_lres <= 241 => 2,
			avg_lres <= 360 => 1.2,
			avg_lres <= 600 => 1.1,
							   1);

		s8_mth_add1_m := map(
			s8_mth_add1 = -1 => 0.0666666667,
			s8_mth_add1 = 1  => 0.0056891173,
			s8_mth_add1 = 2  => 0.0069279854,
			s8_mth_add1 = 3  => 0.0082827167,
			s8_mth_add1 = 4  => 0.0116948209,
			s8_mth_add1 = 5  => 0.0137879635,
			s8_mth_add1 = 6  => 0.0135209713,
			s8_mth_add1 = 7  => 0.0139328304,
			s8_mth_add1 = 8  => 0.0163179113,
			s8_mth_add1 = 9  => 0.0202628697,
			s8_mth_add1 = 10 => 0.0275850104,
			s8_mth_add1 = 11 => 0.0303193398,
			s8_mth_add1 = 12 => 0.0381441408,
			s8_mth_add1 = 13 => 0.055229809,
								0.0202730547);

		s8_avg_lres_m := map(
			s8_avg_lres = -1  => 0.1682242991,
			s8_avg_lres = 1   => 0,
			s8_avg_lres = 1.1 => 0.0056577086,
			s8_avg_lres = 1.2 => 0.0084623323,
			s8_avg_lres = 2   => 0.0086664308,
			s8_avg_lres = 3   => 0.0101418058,
			s8_avg_lres = 4   => 0.0110919174,
			s8_avg_lres = 5   => 0.0144656742,
			s8_avg_lres = 6   => 0.0160261652,
			s8_avg_lres = 7   => 0.0185742084,
			s8_avg_lres = 8   => 0.0197633356,
			s8_avg_lres = 10  => 0.0204331121,
			s8_avg_lres = 11  => 0.0263424519,
			s8_avg_lres = 12  => 0.0355438539,
			s8_avg_lres = 13  => 0.0384410037,
			s8_avg_lres = 14  => 0.0491253295,
			s8_avg_lres = 15  => 0.0873460246,
			s8_avg_lres = 16  => 0.1146496815,
								 0.0202730547);

		s8_avg_mo_per_addr := map(
			avg_mo_per_addr <= 0   => -1,
			avg_mo_per_addr <= 21  => 12,
			avg_mo_per_addr <= 26  => 11,
			avg_mo_per_addr <= 31  => 10,
			avg_mo_per_addr <= 44  => 9,
			avg_mo_per_addr <= 49  => 8,
			avg_mo_per_addr <= 58  => 7,
			avg_mo_per_addr <= 105 => 6,
			avg_mo_per_addr <= 122 => 5,
			avg_mo_per_addr <= 138 => 4,
			avg_mo_per_addr <= 169 => 3,
			avg_mo_per_addr <= 234 => 2,
									  1);

		s8_avg_mo_per_addr_m := map(
			s8_avg_mo_per_addr = -1 => 0.0824175824,
			s8_avg_mo_per_addr = 1  => 0.0075363359,
			s8_avg_mo_per_addr = 2  => 0.0118258377,
			s8_avg_mo_per_addr = 3  => 0.011872639,
			s8_avg_mo_per_addr = 4  => 0.0124190065,
			s8_avg_mo_per_addr = 5  => 0.012568306,
			s8_avg_mo_per_addr = 6  => 0.016303879,
			s8_avg_mo_per_addr = 7  => 0.0197620059,
			s8_avg_mo_per_addr = 8  => 0.0213178295,
			s8_avg_mo_per_addr = 9  => 0.0230182032,
			s8_avg_mo_per_addr = 10 => 0.0281999325,
			s8_avg_mo_per_addr = 11 => 0.0350236356,
			s8_avg_mo_per_addr = 12 => 0.0569253082,
									   0.0202730547);

		s8_addrs_per_ssn := map(
			addrs_per_ssn = 0 => -1,
			addrs_per_ssn < 7 => 1,
								 2);

		s8_addrs_per_ssn_m := map(
			s8_addrs_per_ssn = -1 => 0.0456140351,
			s8_addrs_per_ssn = 1  => 0.0173763306,
			s8_addrs_per_ssn = 2  => 0.022640156,
									 0.0202730547);

		s8_addrs_per_ssn_c6 := min(2, if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6));

		s8_addrs_per_ssn_c6_m := map(
			s8_addrs_per_ssn_c6 = 0 => 0.018940099,
			s8_addrs_per_ssn_c6 = 1 => 0.0514649682,
			s8_addrs_per_ssn_c6 = 2 => 0.1011673152,
									   0.0202730547);

		s8_addr_stability_v2_1 := max(0, min(6, if(addr_stability_v2 = '', -NULL, (integer)addr_stability_v2)));

		s8_addr_stability_v2 := if(s8_addr_stability_v2_1 = 2, 1, s8_addr_stability_v2_1);

		s8_addr_stability_v2_m := map(
			s8_addr_stability_v2 = 0 => 0.0741839763,
			s8_addr_stability_v2 = 1 => 0.0491553797,
			s8_addr_stability_v2 = 3 => 0.0327249022,
			s8_addr_stability_v2 = 4 => 0.0266548985,
			s8_addr_stability_v2 = 5 => 0.024135898,
			s8_addr_stability_v2 = 6 => 0.0117095617,
										0.0202730547);

		s8_attr_addrs_last90 := min(3, if(attr_addrs_last90 = NULL, -NULL, attr_addrs_last90));

		s8_attr_addrs_last90_m := map(
			s8_attr_addrs_last90 = 0 => 0.0182717434,
			s8_attr_addrs_last90 = 1 => 0.0366226812,
			s8_attr_addrs_last90 = 2 => 0.0412556054,
			s8_attr_addrs_last90 = 3 => 0.0523255814,
										0.0202730547);

		s8mobility2 := -6.018960551 +
			s8_mth_add1_m * 18.496514603 +
			s8_avg_lres_m * 9.3710627798 +
			s8_avg_mo_per_addr_m * 13.209251401 +
			s8_addrs_per_ssn_m * 12.378902549 +
			s8_addrs_per_ssn_c6_m * 19.935627654 +
			s8_addr_stability_v2_m * 12.199382101 +
			s8_attr_addrs_last90_m * 10.044688316;

		s8_nap := map(
			(nap_summary in [11, 12]) and infutor_nap = 0 => 1,
			(nap_summary in [0, 1]) and nap_type != ''    => 3,
			(nap_summary in [0, 1])                       => 4,
															 2);

		s8_nap_m := map(
			s8_nap = 1 => 0.0061541167,
			s8_nap = 2 => 0.017403848,
			s8_nap = 3 => 0.0236359065,
			s8_nap = 4 => 0.03489737,
						  0.0202730547);

		s8_mth_eq := map(
			mth_ver_src_fdate_eq2 <= 0   => -1,
			mth_ver_src_fdate_eq2 <= 60  => 13,
			mth_ver_src_fdate_eq2 <= 109 => 12,
			mth_ver_src_fdate_eq2 <= 147 => 11,
			mth_ver_src_fdate_eq2 <= 167 => 10,
			mth_ver_src_fdate_eq2 <= 185 => 9,
			mth_ver_src_fdate_eq2 <= 199 => 8,
			mth_ver_src_fdate_eq2 <= 217 => 7,
			mth_ver_src_fdate_eq2 <= 232 => 6,
			mth_ver_src_fdate_eq2 <= 237 => 5,
			mth_ver_src_fdate_eq2 <= 272 => 3,
			mth_ver_src_fdate_eq2 <= 293 => 2,
			mth_ver_src_fdate_eq2 <= 360 => 1.5,
											1);

		s8_mth_eq_m := map(
			s8_mth_eq = 1   => 0.0076857387,
			s8_mth_eq = 1.5 => 0.0082304527,
			s8_mth_eq = 2   => 0.0114305068,
			s8_mth_eq = 3   => 0.0120320856,
			s8_mth_eq = 5   => 0.0181818182,
			s8_mth_eq = 6   => 0.0202470136,
			s8_mth_eq = 7   => 0.0213690371,
			s8_mth_eq = 8   => 0.030974217,
			s8_mth_eq = 9   => 0.0340762571,
			s8_mth_eq = 10  => 0.0370502316,
			s8_mth_eq = 11  => 0.0395398994,
			s8_mth_eq = 12  => 0.050948625,
			s8_mth_eq = 13  => 0.0838183935,
							   0.0202730547);

		s8_mth_gong_did := map(
			mth_gong_did_first_seen2 <= 0  => -1,
			mth_gong_did_first_seen2 <= 6  => 6,
			mth_gong_did_first_seen2 <= 24 => 5,
			mth_gong_did_first_seen2 <= 36 => 4,
			mth_gong_did_first_seen2 <= 76 => 3,
											  1);

		s8_mth_gong_did_m := map(
			s8_mth_gong_did = -1 => 0.0244972951,
			s8_mth_gong_did = 1  => 0.0132795169,
			s8_mth_gong_did = 3  => 0.0179455446,
			s8_mth_gong_did = 4  => 0.0267206478,
			s8_mth_gong_did = 5  => 0.0318894499,
			s8_mth_gong_did = 6  => 0.0679916318,
									0.0202730547);

		s8_attr_num_nonderogs30 := min(6, if(attr_num_nonderogs30 = NULL, -NULL, attr_num_nonderogs30));

		s8_attr_num_nonderogs30_m := map(
			s8_attr_num_nonderogs30 = 0 => 0.1279212792,
			s8_attr_num_nonderogs30 = 1 => 0.0334998826,
			s8_attr_num_nonderogs30 = 2 => 0.0175186607,
			s8_attr_num_nonderogs30 = 3 => 0.0120244784,
			s8_attr_num_nonderogs30 = 4 => 0.0081375358,
			s8_attr_num_nonderogs30 = 5 => 0.00569981,
			s8_attr_num_nonderogs30 = 6 => 0,
										   0.0202730547);

		s8_prop_owner := map(
			add1_naprop = 4 and prop_owned_flag and add1_family_owned                          => 0,
			add1_naprop = 4 and prop_owned_flag                                                => 1,
			add1_naprop = 4 or (add1_naprop in [3, 0]) and (prop_owned_flag or prop_sold_flag) => 2,
			add1_naprop = 3 or prop_owned_flag or prop_sold_flag                               => 3,
			add1_naprop = 2                                                                    => 4,
			add1_naprop = 0                                                                    => 5,
																								  6);

		s8_prop_owner_m := map(
			s8_prop_owner = 0 => 0.0103020264,
			s8_prop_owner = 1 => 0.0163064088,
			s8_prop_owner = 2 => 0.0162298705,
			s8_prop_owner = 3 => 0.0243316967,
			s8_prop_owner = 4 => 0.0291173794,
			s8_prop_owner = 5 => 0.0367793777,
			s8_prop_owner = 6 => 0.0503313126,
								 0.0202730547);

		s8_minor_src_ver := max((integer)ver_src_ak, (integer)ver_src_am, (integer)ver_src_ar, (integer)ver_src_eb, (integer)ver_src_nas_e1 > 5, (integer)ver_src_e3 > 5, (integer)watercraft_count > 0, (integer)attr_num_aircraft > 0);

		s8_minor_src_ver_i := map(
			s8_minor_src_ver > 0                                                                                           => 0,
			ver_src_e1 or ver_src_e2 or ver_src_e3 or ver_src_p or ver_src_nas_vo >= 5 or ver_src_w or ver_src_nas_wp >= 5 => 1,
																															  2);

		s8_pl := ver_src_pl or prof_license_flag;

		s8_minor_src_ver_i_m := map(
			s8_minor_src_ver_i = 0 => 0.0084365937,
			s8_minor_src_ver_i = 1 => 0.0148874033,
			s8_minor_src_ver_i = 2 => 0.0545720913,
									  0.0202730547);

		s8_add2_marketvalue := map(
			(integer)add2_avm_market_total_value <= 0      => -1,
			(integer)add2_avm_market_total_value <= 99706  => 5,
			(integer)add2_avm_market_total_value <= 137948 => 4,
			(integer)add2_avm_market_total_value <= 325700 => 3,
			(integer)add2_avm_market_total_value <= 422300 => 2,
															 1);

		s8_add2_marketvalue_m := map(
			s8_add2_marketvalue = -1 => 0.0206390263,
			s8_add2_marketvalue = 1  => 0.0086767896,
			s8_add2_marketvalue = 2  => 0.0173347779,
			s8_add2_marketvalue = 3  => 0.0161202926,
			s8_add2_marketvalue = 4  => 0.0157181572,
			s8_add2_marketvalue = 5  => 0.0251083815,
										0.0202730547);

		s8_add3_marketvalue := map(
			add3_market_total_value <= 0      => -1,
			add3_market_total_value <= 86475  => 4,
			add3_market_total_value <= 247400 => 3,
			add3_market_total_value <= 530700 => 2,
												 1);

		s8_add3_marketvalue_m := map(
			s8_add3_marketvalue = -1 => 0.0207616067,
			s8_add3_marketvalue = 1  => 0.0106424911,
			s8_add3_marketvalue = 2  => 0.0159731808,
			s8_add3_marketvalue = 3  => 0.0179782369,
			s8_add3_marketvalue = 4  => 0.0268191678,
										0.0202730547);

		s8_add1_avm_med := map(
			add1_avm_med <= 0      => -1,
			add1_avm_med <= 50000  => 7,
			add1_avm_med <= 94999  => 6,
			add1_avm_med <= 604794 => 3,
			add1_avm_med <= 752500 => 2,
									  1);

		s8_add1_avm_to_med_ratio := map(
			add1_avm_to_med_ratio = NULL  => -1,
			add1_avm_to_med_ratio <= 0.25 => 8,
			add1_avm_to_med_ratio <= 0.50 => 7,
			add1_avm_to_med_ratio <= 0.75 => 6,
			add1_avm_to_med_ratio <= 1    => 5,
			add1_avm_to_med_ratio <= 1.25 => 4,
											 1);

		s8_buildingarea := map(
			(integer)add1_building_area <= 0    => -1,
			(integer)add1_building_area <= 500  => 7,
			(integer)add1_building_area <= 1267 => 6,
			(integer)add1_building_area <= 1434 => 5,
			(integer)add1_building_area <= 1604 => 4,
			(integer)add1_building_area <= 1785 => 3,
			(integer)add1_building_area <= 3104 => 2,
												  1);

		s8_add1_avm_med_m := map(
			s8_add1_avm_med = -1 => 0.0162209332,
			s8_add1_avm_med = 1  => 0.0128065987,
			s8_add1_avm_med = 2  => 0.0184622068,
			s8_add1_avm_med = 3  => 0.0204186778,
			s8_add1_avm_med = 6  => 0.0290598291,
			s8_add1_avm_med = 7  => 0.048315321,
									0.0202730547);

		s8_add1_avm_to_med_ratio_m := map(
			s8_add1_avm_to_med_ratio = -1 => 0.0239783111,
			s8_add1_avm_to_med_ratio = 1  => 0.0110951305,
			s8_add1_avm_to_med_ratio = 4  => 0.017177853,
			s8_add1_avm_to_med_ratio = 5  => 0.0191296031,
			s8_add1_avm_to_med_ratio = 6  => 0.0232204861,
			s8_add1_avm_to_med_ratio = 7  => 0.03125,
			s8_add1_avm_to_med_ratio = 8  => 0.0421052632,
											 0.0202730547);

		s8_buildingarea_m := map(
			s8_buildingarea = -1 => 0.0229600428,
			s8_buildingarea = 1  => 0.0101406608,
			s8_buildingarea = 2  => 0.0127156759,
			s8_buildingarea = 3  => 0.0173571312,
			s8_buildingarea = 4  => 0.0210612245,
			s8_buildingarea = 5  => 0.0212279556,
			s8_buildingarea = 6  => 0.0296662546,
			s8_buildingarea = 7  => 0.0714285714,
									0.0202730547);

		s8_add1_2story := add1_no_of_stories = (string)2;

		s8_add1_no_of_partial_baths := add1_no_of_partial_baths > (string)0;

		s8avm2 := -7.067056897 +
			s8_add2_marketvalue_m * 29.092601458 +
			s8_add3_marketvalue_m * 29.055801976 +
			s8_add1_avm_med_m * 34.285794905 +
			s8_add1_avm_to_med_ratio_m * 36.816184301 +
			s8_buildingarea_m * 28.120156532 +
			(integer)s8_add1_2story * -0.172919901 +
			(integer)s8_add1_no_of_partial_baths * -0.478727741;

		s8_mortgage_risky := StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add1_mortgage_type) in ['1', '2', 'G', 'H', 'J', 'N', 'R', 'U', 'VA', 'Z']) or (StringLib.StringToUpperCase(add1_mortgage_type) in ['FHA', 'S']) or (StringLib.StringToUpperCase(add2_mortgage_type) in ['FHA']) or StringLib.StringToUpperCase(add2_financing_type) = 'ADJ' or (StringLib.StringToUpperCase(add3_mortgage_type) in ['FHA', 'H']) or StringLib.StringToUpperCase(add3_financing_type) = 'ADJ';

		s8_econtrj := if(_econtrj = -1, -1, max(2, min(6, if(_econtrj = NULL, -NULL, _econtrj))));

		s8_econtrj_m := map(
			s8_econtrj = -1 => 0.0167035748,
			s8_econtrj = 2  => 0.0190040681,
			s8_econtrj = 3  => 0.0217647059,
			s8_econtrj = 4  => 0.0284679089,
			s8_econtrj = 5  => 0.0368150685,
			s8_econtrj = 6  => 0.0385438972,
							   0.0202730547);

		s8_mth_add1_purchase_date := map(
			mth_add1_purchase_date <= 0 => -1,
			mth_add1_purchase_date < 12 => 4,
			mth_add1_purchase_date < 24 => 3,
			mth_add1_purchase_date < 36 => 2,
										   1);

		s8_mth_add1_purchase_date_m := map(
			s8_mth_add1_purchase_date = -1 => 0.0241123665,
			s8_mth_add1_purchase_date = 1  => 0.0126606249,
			s8_mth_add1_purchase_date = 2  => 0.0170063612,
			s8_mth_add1_purchase_date = 3  => 0.0226657645,
			s8_mth_add1_purchase_date = 4  => 0.0292682927,
											  0.0202730547);

		s8_ams_age_le31 := (string)0 < ams_age AND ams_age <= (string)31;

		s8_ams_college_tier := map(
			ams_college_tier = (string)0 => 4,
			ams_college_tier = (string)1 => 1,
			ams_college_tier = (string)2 => 1,
			ams_college_tier = (string)3 => 3,
			ams_college_tier = (string)4 => 4,
			ams_college_tier = (string)5 => 4,
			ams_college_tier = (string)6 => 6,
											-1);

		s8_ams_income_level := map(
			StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 9,
			StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 7,
			StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 6,
			StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 5,
			StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 4,
			StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 3,
			StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 1,
			StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
																		-1);

		s8_ams_college_tier_m := map(
			s8_ams_college_tier = -1 => 0.0208515824,
			s8_ams_college_tier = 1  => 0.0058072009,
			s8_ams_college_tier = 3  => 0.0089757128,
			s8_ams_college_tier = 4  => 0.0113977205,
			s8_ams_college_tier = 6  => 0.025540275,
										0.0202730547);

		s8_ams_income_level_m := map(
			s8_ams_income_level = -1 => 0.0204862005,
			s8_ams_income_level = 1  => 0.0093141406,
			s8_ams_income_level = 3  => 0.0097087379,
			s8_ams_income_level = 4  => 0.0112820513,
			s8_ams_income_level = 5  => 0.0157024793,
			s8_ams_income_level = 6  => 0.0197322058,
			s8_ams_income_level = 7  => 0.023608769,
			s8_ams_income_level = 9  => 0.04,
										0.0202730547);

		s8ams1 := -6.186238555 +
			(integer)s8_ams_age_le31 * 1.4711540459 +
			s8_ams_college_tier_m * 68.299819493 +
			s8_ams_income_level_m * 44.149193952;

		s8_ssns_per_adl := if(ssns_per_adl = 0, 2, min(4, if(ssns_per_adl = NULL, -NULL, ssns_per_adl)));

		s8_ssns_per_adl_m := map(
			s8_ssns_per_adl = 1 => 0.0181574555,
			s8_ssns_per_adl = 2 => 0.0254883158,
			s8_ssns_per_adl = 3 => 0.0344605475,
			s8_ssns_per_adl = 4 => 0.080620155,
								   0.0202730547);

		s8_adlperssn := if(adlperssn_count = 0, 4, min(4, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

		s8_adlperssn_m := map(
			s8_adlperssn = 1 => 0.0173067906,
			s8_adlperssn = 2 => 0.0215289681,
			s8_adlperssn = 3 => 0.0301430754,
			s8_adlperssn = 4 => 0.0409836066,
								0.0202730547);

		s8_ssns_per_adl_c6 := min(2, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6));

		s8_ssns_per_adl_c6_m := map(
			s8_ssns_per_adl_c6 = 0 => 0.0174061562,
			s8_ssns_per_adl_c6 = 1 => 0.0265545475,
			s8_ssns_per_adl_c6 = 2 => 0.1010928962,
									  0.0202730547);

		s8_adls_per_addr := map(
			adls_per_addr = 0   => -2,
			adls_per_addr = 1   => -1,
			adls_per_addr <= 6  => 1,
			adls_per_addr <= 9  => 2,
			adls_per_addr <= 15 => 3,
			adls_per_addr <= 20 => 4,
								   5);

		s8_adls_per_addr_m := map(
			s8_adls_per_addr = -2 => 0.0425686474,
			s8_adls_per_addr = -1 => 0.0279461279,
			s8_adls_per_addr = 1  => 0.0123038516,
			s8_adls_per_addr = 2  => 0.0146869837,
			s8_adls_per_addr = 3  => 0.0216469945,
			s8_adls_per_addr = 4  => 0.0314855876,
			s8_adls_per_addr = 5  => 0.0509901762,
									 0.0202730547);

		s8_id_per_addr_diff := map(
			id_per_addr_diff <= -2 => -1,
			id_per_addr_diff <= 2  => 1,
									  min(9, if(id_per_addr_diff = NULL, -NULL, id_per_addr_diff)));

		s8_id_per_addr_diff_m := map(
			s8_id_per_addr_diff = -1 => 0.0250896057,
			s8_id_per_addr_diff = 1  => 0.0172459474,
			s8_id_per_addr_diff = 3  => 0.0208728653,
			s8_id_per_addr_diff = 4  => 0.0233468896,
			s8_id_per_addr_diff = 5  => 0.0311053985,
			s8_id_per_addr_diff = 6  => 0.039638087,
			s8_id_per_addr_diff = 7  => 0.0403968816,
			s8_id_per_addr_diff = 8  => 0.0525087515,
			s8_id_per_addr_diff = 9  => 0.0627366144,
										0.0202730547);

		s8_adls_per_addr_c6 := min(5, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6));

		s8_adls_per_addr_c6_m := map(
			s8_adls_per_addr_c6 = 0 => 0.0172091891,
			s8_adls_per_addr_c6 = 1 => 0.0239410681,
			s8_adls_per_addr_c6 = 2 => 0.0244857091,
			s8_adls_per_addr_c6 = 3 => 0.0370994941,
			s8_adls_per_addr_c6 = 4 => 0.0495540139,
			s8_adls_per_addr_c6 = 5 => 0.0593047035,
									   0.0202730547);

		s8_phones_per_addr_c6 := min(4, if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6));

		s8_phones_per_addr_c6_m := map(
			s8_phones_per_addr_c6 = 0 => 0.0180730843,
			s8_phones_per_addr_c6 = 1 => 0.0308714342,
			s8_phones_per_addr_c6 = 2 => 0.0528580209,
			s8_phones_per_addr_c6 = 3 => 0.0616113744,
			s8_phones_per_addr_c6 = 4 => 0.0655226209,
										 0.0202730547);

		s8_nameperssn_count := nameperssn_count > 0;

		s8_wealth_index := min(5, if(wealth_index = '', -NULL, (integer)wealth_index));

		s8_wealth_index_m := map(
			s8_wealth_index = 0 => 0.0257589089,
			s8_wealth_index = 1 => 0.078685259,
			s8_wealth_index = 2 => 0.0264550265,
			s8_wealth_index = 3 => 0.0200365747,
			s8_wealth_index = 4 => 0.0149151548,
			s8_wealth_index = 5 => 0.0120754442,
								   0.0202730547);

		s8_inq_peradl := min(2, if(Inq_PerADL = NULL, -NULL, Inq_PerADL));

		s8_inq_peradl_m := map(
			s8_inq_peradl = 0 => 0.0195765766,
			s8_inq_peradl = 1 => 0.1275862069,
			s8_inq_peradl = 2 => 0.347826087,
								 0.0202730547);

		s8_inq_addrsperadl := min(1, if(Inq_AddrsPerADL = NULL, -NULL, Inq_AddrsPerADL));

		s8_inq_lnamesperaddr := min(2, if(Inq_LNamesPerAddr = NULL, -NULL, Inq_LNamesPerAddr));

		s8_inq_lnamesperaddr_m := map(
			s8_inq_lnamesperaddr = 0 => 0.0192256781,
			s8_inq_lnamesperaddr = 1 => 0.0719054956,
			s8_inq_lnamesperaddr = 2 => 0.1231884058,
										0.0202730547);

		s8inq2 := -4.385388315 +
			s8_inq_peradl_m * 5.6991025262 +
			s8_inq_addrsperadl * 0.7864131288 +
			s8_inq_lnamesperaddr_m * 17.383927167;

		s8_state2 := map(
			out_st = 'AA' => 1,
			out_st = 'AE' => 1,
			out_st = 'AS' => 1,
			out_st = 'FM' => 1,
			out_st = 'MP' => 1,
			out_st = 'SD' => 1,
			out_st = 'NE' => 1,
			out_st = 'ND' => 1,
			out_st = 'MT' => 1,
			out_st = 'WI' => 1,
			out_st = 'PA' => 2,
			out_st = 'NH' => 2,
			out_st = 'VA' => 2,
			out_st = 'IA' => 2,
			out_st = 'WY' => 2,
			out_st = 'KS' => 2,
			out_st = 'CO' => 2,
			out_st = 'NJ' => 2,
			out_st = 'UT' => 2,
			out_st = 'MN' => 2,
			out_st = 'DE' => 2,
			out_st = 'MO' => 3,
			out_st = 'OH' => 3,
			out_st = 'NM' => 3,
			out_st = 'IN' => 3,
			out_st = 'CT' => 3,
			out_st = 'WA' => 3,
			out_st = 'ID' => 3,
			out_st = 'OK' => 3,
			out_st = 'IL' => 3,
			out_st = 'AK' => 4,
			out_st = 'AL' => 4,
			out_st = 'MS' => 4,
			out_st = 'NC' => 4,
			out_st = 'OR' => 4,
			out_st = 'AR' => 4,
			out_st = 'MA' => 4,
			out_st = 'KY' => 4,
			out_st = 'MD' => 4,
			out_st = 'WV' => 4,
			out_st = 'NY' => 4,
			out_st = 'GA' => 5,
			out_st = 'VT' => 5,
			out_st = 'ME' => 5,
			out_st = 'RI' => 5,
			out_st = 'TN' => 5,
			out_st = 'MI' => 5,
			out_st = 'TX' => 5,
			out_st = 'LA' => 5,
			out_st = 'HI' => 5,
			out_st = 'AZ' => 5,
			out_st = 'GU' => 5,
			out_st = 'SC' => 5,
			out_st = 'CA' => 5,
			out_st = 'PR' => 6,
			out_st = 'NV' => 6,
			out_st = 'FL' => 6,
			out_st = 'DC' => 6,
			out_st = 'VI' => 6,
			out_st = 'PW' => 6,
							 -1);

		s8_state2_m := map(
			s8_state2 = 1 => 0.0045574478,
			s8_state2 = 2 => 0.0108066581,
			s8_state2 = 3 => 0.0147066155,
			s8_state2 = 4 => 0.0185791383,
			s8_state2 = 5 => 0.0266826726,
			s8_state2 = 6 => 0.0394706292,
							 0.0202730547);

		s803 := -1.418036629 +
			s8_age_m * 6.6919216936 +
			s8_mth_rc_ssnlowissue_m * 4.2914637286 +
			(integer)s8_add_risk * 0.4427927442 +
			s8mobility2 * 0.3887298193 +
			s8_nap_m * 15.059477819 +
			s8_mth_eq_m * 5.3991727891 +
			s8_mth_gong_did_m * 14.770132599 +
			s8_attr_num_nonderogs30_m * 4.9610030606 +
			s8_prop_owner_m * 8.719536289 +
			s8_minor_src_ver_i_m * 9.5861597547 +
			(integer)s8_pl * -0.429039607 +
			s8avm2 * 0.4884051483 +
			(integer)s8_mortgage_risky * 0.4691519969 +
			s8_econtrj_m * 10.996097708 +
			s8_mth_add1_purchase_date_m * 20.14180172 +
			s8ams1 * 0.4558491649 +
			s8_ssns_per_adl_m * 16.30070249 +
			s8_adlperssn_m * 7.3716574963 +
			s8_ssns_per_adl_c6_m * 5.8084505928 +
			s8_adls_per_addr_m * 6.232840329 +
			s8_id_per_addr_diff_m * 9.4980809456 +
			s8_adls_per_addr_c6_m * 8.5111677425 +
			s8_phones_per_addr_c6_m * 8.1168072271 +
			(integer)s8_nameperssn_count * 0.2587717329 +
			s8_wealth_index_m * 10.096773965 +
			s8inq2 * 0.4792010682 +
			s8_state2_m * 33.302180328;

		uv_derog := (rc_bansflag in ['1', '2']) or bankrupt or (integer)ver_src_ba = 1 or filing_count > 0 or bk_recent_count > 0 or ver_src_l2 or ver_src_li or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 or attr_total_number_derogs > 0 or attr_eviction_count > 0 or criminal_count > 0 or felony_count > 0 or impulse_count > 0;

		uv_eq_type := map(
			mth_ver_src_fdate_eq <= 0  => 0,
			mth_ver_src_fdate_eq <= 18 => 1,
										  2);

		uv_propowner := Add1_NaProp = 4 or Property_Owned_Total > 0;

		uv_segment := map(
			UV_derog                                                               => 'S1-derog',
			(integer)truedid = 0                                                   => 'S2-notTrueDid',
			truedid and uv_eq_type = 0 and 0 < inferred_age AND inferred_age <= 18 => 'S3-nofileYoung',
			truedid and uv_eq_type = 0                                             => 'S4-nofileOlder',
			truedid and uv_eq_type = 1 and (integer)uv_propowner = 0               => 'S5-thinOther',
			truedid and uv_eq_type = 1 and (integer)uv_propowner = 1               => 'S6-thinOwner',
			truedid and uv_eq_type = 2 and inferred_age <= 31                      => 'S7-thickYoung',
																				  'S8-thickOlder');

		logit := map(
			uv_segment = 'S1-derog'       => s103,
			uv_segment = 'S2-notTrueDid'  => s204,
			uv_segment = 'S3-nofileYoung' => s301,
			uv_segment = 'S4-nofileOlder' => s404,
			uv_segment = 'S5-thinOther'   => s502c,
			uv_segment = 'S6-thinOwner'   => s603,
			uv_segment = 'S7-thickYoung'  => s705,
											 s803);

		phat := exp(logit) / (1 + exp(logit));

		base := 700;

		odds := 1 / 20;

		point := -40;

		rvp1104_raw := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

		rvp1104_cap_1 := max(501, min(900, if(rvp1104_raw = NULL, -NULL, rvp1104_raw)));

		ov_ssndead := ssnlength > (string)0 and rc_decsflag = (string)1;

		ov_ssnprior := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;

		ov_criminal_flag := criminal_count > 0;

		ov_corrections := rc_hrisksic = (string)2225;

		ov_impulse := impulse_count > 0;

		ov_condition := ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse;

		rvp1104_cap := if(ov_condition, min(700, if(rvp1104_cap_1 = NULL, -NULL, rvp1104_cap_1)), rvp1104_cap_1);

		uv_rv20_content := nas_summary > 4 or nap_summary > 4 or add1_naprop > 2;

		uv_gong_sourced := (nap_summary in [2, 3, 5, 6, 7, 8, 9, 10, 11, 12]);

		uv_eq_only := (integer)ver_src_eq = 1 and ver_src_cnt = 1 and (integer)uv_gong_sourced = 0;

		uv_RVP1003_content := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);    

		rvp1104 := map(rc_decsflag='1'  or  ver_src_ds	=> 200,  //add 200 logic for deceased - 2012/11/12
									(integer)uv_rvp1003_content = 1 	=> 222,
									 rvp1104_cap);



		#if(RVP_DEBUG)
			self.clam := le;
			self.truedid := truedid;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_st := out_st;
			self.out_addr_type := out_addr_type;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.nap_type := nap_type;
			self.nap_status := nap_status;
			self.did_count := did_count;
			self.did2_criminal_count := did2_criminal_count;
			self.did2_felony_count := did2_felony_count;
			self.did2_liens_recent_unrel_count := did2_liens_recent_unrel_count;
			self.did2_liens_recent_rel_count := did2_liens_recent_rel_count;
			self.rc_dirsaddr_lastscore := rc_dirsaddr_lastscore;
			self.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_hriskaddrflag := rc_hriskaddrflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_ssnlowissue := rc_ssnlowissue;
			self.rc_ssnstate := rc_ssnstate;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_addrcount := rc_addrcount;
			self.rc_numelever := rc_numelever;
			self.rc_phoneaddrcount := rc_phoneaddrcount;
			self.rc_addrmiskeyflag := rc_addrmiskeyflag;
			self.rc_addrcommflag := rc_addrcommflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_ziptypeflag := rc_ziptypeflag;
			self.rc_cityzipflag := rc_cityzipflag;
			self.rc_altlname1_flag := rc_altlname1_flag;
			self.rc_altlname2_flag := rc_altlname2_flag;
			self.combo_addrscore := combo_addrscore;
			self.combo_dobscore := combo_dobscore;
			self.rc_watchlist_flag := rc_watchlist_flag;
			self.ver_sources := ver_sources;
			self.ver_sources_nas := ver_sources_nas;
			self.ver_sources_first_seen := ver_sources_first_seen;
			self.ssnlength := ssnlength;
			self.age := age;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_advo_address_vacancy := add1_advo_address_vacancy;
			self.add1_advo_throw_back := add1_advo_throw_back;
			self.add1_advo_drop := add1_advo_drop;
			self.add1_avm_land_use := add1_avm_land_use;
			self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
			self.add1_avm_market_total_value := add1_avm_market_total_value;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_source_count := add1_source_count;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_purchase_date := add1_purchase_date;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_financing_type := add1_financing_type;
			self.add1_date_first_seen := add1_date_first_seen;
			self.add1_building_area := add1_building_area;
			self.add1_no_of_stories := add1_no_of_stories;
			self.add1_no_of_baths := add1_no_of_baths;
			self.add1_no_of_partial_baths := add1_no_of_partial_baths;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.add2_addr_type := add2_addr_type;
			self.add2_advo_address_vacancy := add2_advo_address_vacancy;
			self.add2_advo_college := add2_advo_college;
			self.add2_avm_land_use := add2_avm_land_use;
			self.add2_avm_sales_price := add2_avm_sales_price;
			self.add2_avm_market_total_value := add2_avm_market_total_value;
			self.add2_avm_automated_valuation := add2_avm_automated_valuation;
			self.add2_avm_med_fips := add2_avm_med_fips;
			self.add2_avm_med_geo11 := add2_avm_med_geo11;
			self.add2_avm_med_geo12 := add2_avm_med_geo12;
			self.add2_mortgage_type := add2_mortgage_type;
			self.add2_financing_type := add2_financing_type;
			self.add3_addr_type := add3_addr_type;
			self.add3_avm_automated_valuation := add3_avm_automated_valuation;
			self.add3_mortgage_type := add3_mortgage_type;
			self.add3_financing_type := add3_financing_type;
			self.add3_market_total_value := add3_market_total_value;
			self.add3_assessed_total_value := add3_assessed_total_value;
			self.avg_lres := avg_lres;
			self.addrs_15yr := addrs_15yr;
			self.unique_addr_count := unique_addr_count;
			self.avg_mo_per_addr := avg_mo_per_addr;
			self.addr_hist_advo_college := addr_hist_advo_college;
			self.telcordia_type := telcordia_type;
			self.gong_did_first_seen := gong_did_first_seen;
			self.nameperssn_count := nameperssn_count;
			self.header_first_seen := header_first_seen;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.addrs_per_ssn := addrs_per_ssn;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.addrs_per_adl_c6 := addrs_per_adl_c6;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.phones_per_addr_c6 := phones_per_addr_c6;
			self.inq_count01 := inq_count01;
			self.inq_count03 := inq_count03;
			self.inq_count12 := inq_count12;
			self.inq_banking_count12 := inq_banking_count12;
			self.inq_highriskcredit_count12 := inq_highriskcredit_count12;
			self.inq_communications_count12 := inq_communications_count12;
			self.inq_peradl := inq_peradl;
			self.inq_ssnsperadl := inq_ssnsperadl;
			self.inq_addrsperadl := inq_addrsperadl;
			self.inq_phonesperadl := inq_phonesperadl;
			self.inq_perssn := inq_perssn;
			self.inq_lnamesperssn := inq_lnamesperssn;
			self.inq_peraddr := inq_peraddr;
			self.inq_lnamesperaddr := inq_lnamesperaddr;
			self.inq_adlsperphone := inq_adlsperphone;
			self.paw_business_count := paw_business_count;
			self.paw_active_phone_count := paw_active_phone_count;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.email_count := email_count;
			self.email_domain_free_count := email_domain_free_count;
			self.email_domain_edu_count := email_domain_edu_count;
			self.email_domain_corp_count := email_domain_corp_count;
			self.email_source_list := email_source_list;
			self.attr_addrs_last30 := attr_addrs_last30;
			self.attr_addrs_last90 := attr_addrs_last90;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_num_aircraft := attr_num_aircraft;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_num_rel_liens12 := attr_num_rel_liens12;
			self.attr_bankruptcy_count36 := attr_bankruptcy_count36;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_date_last_eviction := attr_date_last_eviction;
			self.attr_num_nonderogs := attr_num_nonderogs;
			self.attr_num_nonderogs30 := attr_num_nonderogs30;
			self.attr_num_nonderogs180 := attr_num_nonderogs180;
			self.bankrupt := bankrupt;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.bk_disposed_recent_count := bk_disposed_recent_count;
			self.bk_disposed_historical_count := bk_disposed_historical_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_recent_released_count := liens_recent_released_count;
			self.liens_historical_released_count := liens_historical_released_count;
			self.liens_last_unrel_date := liens_last_unrel_date;
			self.liens_rel_cj_ct := liens_rel_cj_ct;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_unrel_o_ct := liens_unrel_o_ct;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.felony_count := felony_count;
			self.watercraft_count := watercraft_count;
			self.ams_age := ams_age;
			self.ams_class := ams_class;
			self.ams_college_code := ams_college_code;
			self.ams_college_type := ams_college_type;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_file_type := ams_file_type;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_flag := prof_license_flag;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.addr_stability_v2 := addr_stability_v2;
			self.estimated_income := estimated_income;
			self.archive_date := archive_date;

			self.sysdate                          := sysdate;
			self.header_first_seen2               := header_first_seen2;
			self.mth_header_first_seen            := mth_header_first_seen;
			self.add1_date_first_seen2            := add1_date_first_seen2;
			self.mth_add1_date_first_seen         := mth_add1_date_first_seen;
			self.rc_ssnlowissue2                  := rc_ssnlowissue2;
			self.mth_rc_ssnlowissue               := mth_rc_ssnlowissue;
			self.liens_last_unrel_date2           := liens_last_unrel_date2;
			self.mth_liens_last_unrel_date        := mth_liens_last_unrel_date;
			self.attr_date_last_eviction2         := attr_date_last_eviction2;
			self.mth_attr_date_last_eviction      := mth_attr_date_last_eviction;
			self.criminal_last_date2              := criminal_last_date2;
			self.mth_criminal_last_date           := mth_criminal_last_date;
			self.gong_did_first_seen2             := gong_did_first_seen2;
			self.mth_gong_did_first_seen          := mth_gong_did_first_seen;
			self.add1_purchase_date2              := add1_purchase_date2;
			self.mth_add1_purchase_date           := mth_add1_purchase_date;
			self.mth_header_first_seen2           := mth_header_first_seen2;
			self.mth_rc_ssnlowissue2              := mth_rc_ssnlowissue2;
			self.mth_add1_date_first_seen2        := mth_add1_date_first_seen2;
			self.mth_gong_did_first_seen2         := mth_gong_did_first_seen2;
			self.ver_src_cnt                      := ver_src_cnt;
			self.ver_src_ak_pos                   := ver_src_ak_pos;
			self.ver_src_ak                       := ver_src_ak;
			self.ver_src_nas_ak                   := ver_src_nas_ak;
			self.ver_src_am_pos                   := ver_src_am_pos;
			self.ver_src_am                       := ver_src_am;
			self.ver_src_ar_pos                   := ver_src_ar_pos;
			self.ver_src_ar                       := ver_src_ar;
			self.ver_src_ba_pos                   := ver_src_ba_pos;
			self.ver_src_ba                       := ver_src_ba;
			self.ver_src_ds_pos                   := ver_src_ds_pos;
			self.ver_src_ds                       := ver_src_ds;
			self.ver_src_eb_pos                   := ver_src_eb_pos;
			self.ver_src_eb                       := ver_src_eb;
			self.ver_src_em_pos                   := ver_src_em_pos;
			self.ver_src_em                       := ver_src_em;
			self.ver_src_nas_em                   := ver_src_nas_em;
			self.ver_src_e1_pos                   := ver_src_e1_pos;
			self.ver_src_e1                       := ver_src_e1;
			self.ver_src_nas_e1                   := ver_src_nas_e1;
			self.ver_src_e2_pos                   := ver_src_e2_pos;
			self.ver_src_e2                       := ver_src_e2;
			self.ver_src_nas_e2                   := ver_src_nas_e2;
			self.ver_src_e3_pos                   := ver_src_e3_pos;
			self.ver_src_e3                       := ver_src_e3;
			self.ver_src_e4_pos                   := ver_src_e4_pos;
			self.ver_src_e4                       := ver_src_e4;
			self.ver_src_nas_e4                   := ver_src_nas_e4;
			self.ver_src_eq_pos                   := ver_src_eq_pos;
			self.ver_src_eq                       := ver_src_eq;
			self.ver_src_fdate_eq                 := ver_src_fdate_eq;
			self.ver_src_fdate_eq2                := ver_src_fdate_eq2;
			self.mth_ver_src_fdate_eq             := mth_ver_src_fdate_eq;
			self.ver_src_l2_pos                   := ver_src_l2_pos;
			self.ver_src_l2                       := ver_src_l2;
			self.ver_src_li_pos                   := ver_src_li_pos;
			self.ver_src_li                       := ver_src_li;
			self.ver_src_mw_pos                   := ver_src_mw_pos;
			self.ver_src_mw                       := ver_src_mw;
			self.ver_src_p_pos                    := ver_src_p_pos;
			self.ver_src_p                        := ver_src_p;
			self.ver_src_pl_pos                   := ver_src_pl_pos;
			self.ver_src_pl                       := ver_src_pl;
			self.ver_src_v_pos                    := ver_src_v_pos;
			self.ver_src_v                        := ver_src_v;
			self.ver_src_vo_pos                   := ver_src_vo_pos;
			self.ver_src_vo                       := ver_src_vo;
			self.ver_src_nas_vo                   := ver_src_nas_vo;
			self.ver_src_w_pos                    := ver_src_w_pos;
			self.ver_src_w                        := ver_src_w;
			self.ver_src_wp_pos                   := ver_src_wp_pos;
			self.ver_src_nas_wp                   := ver_src_nas_wp;
			self.mth_ver_src_fdate_eq2            := mth_ver_src_fdate_eq2;
			self.age_on_eq                        := age_on_eq;
			self.email_src_im_pos                 := email_src_im_pos;
			self.email_src_im                     := email_src_im;
			self.add_apt                          := add_apt;
			self.add2_apt                         := add2_apt;
			self.add3_apt                         := add3_apt;
			self.add1_building_area2              := add1_building_area2;
			self.add1_avm_med                     := add1_avm_med;
			self.add2_avm_med                     := add2_avm_med;
			self.add1_avm_to_med_ratio            := add1_avm_to_med_ratio;
			self._add1_avm                        := _add1_avm;
			self._add2_avm                        := _add2_avm;
			self._add1_avm_class                  := _add1_avm_class;
			self._add2_avm_class                  := _add2_avm_class;
			self._econtrajectory                  := _econtrajectory;
			self._econtrj                         := _econtrj;
			self.prop_owned_flag                  := prop_owned_flag;
			self.prop_sold_flag                   := prop_sold_flag;
			self.id_per_addr_diff                 := id_per_addr_diff;
			self.id_per_addr_c6_diff              := id_per_addr_c6_diff;
			self.s1_bk_bad                        := s1_bk_bad;
			self.s1_attr_num_rel_liens12          := s1_attr_num_rel_liens12;
			self.s1_mth_liens_last_unrel          := s1_mth_liens_last_unrel;
			self.s1_mth_liens_last_unrel_m        := s1_mth_liens_last_unrel_m;
			self.s1_liens_rel_cj                  := s1_liens_rel_cj;
			self.s1_liens_rel_cj_m                := s1_liens_rel_cj_m;
			self.s1_liens_unrel_lt                := s1_liens_unrel_lt;
			self.s1_liens_unrel_o                 := s1_liens_unrel_o;
			self.s1_attr_eviction                 := s1_attr_eviction;
			self.s1_attr_eviction_m               := s1_attr_eviction_m;
			self.s1_mth_attr_last_eviction        := s1_mth_attr_last_eviction;
			self.s1_mth_attr_last_eviction_m      := s1_mth_attr_last_eviction_m;
			self.s1_felony                        := s1_felony;
			self.s1_felony_m                      := s1_felony_m;
			self.s1_mth_last_criminal             := s1_mth_last_criminal;
			self.s1_mth_last_criminal_m           := s1_mth_last_criminal_m;
			self.s1_impulse                       := s1_impulse;
			self.s1_impulse_m                     := s1_impulse_m;
			self.s1_did2_derog                    := s1_did2_derog;
			self.s1_derog_ratio                   := s1_derog_ratio;
			self.s1_derog_ratio_lvl               := s1_derog_ratio_lvl;
			self.s1_derog_ratio_lvl_m             := s1_derog_ratio_lvl_m;
			self.s1derog3                         := s1derog3;
			self.s1_mth_rc_ssnlowissue            := s1_mth_rc_ssnlowissue;
			self.s1_mth_rc_ssnlowissue_m          := s1_mth_rc_ssnlowissue_m;
			self.s1_add_risk                      := s1_add_risk;
			self.s1_phone_risk                    := s1_phone_risk;
			self.s1_mth_add1                      := s1_mth_add1;
			self.s1_mth_add1_m                    := s1_mth_add1_m;
			self.s1_avg_lres                      := s1_avg_lres;
			self.s1_avg_lres_m                    := s1_avg_lres_m;
			self.s1_avg_mo_per_addr               := s1_avg_mo_per_addr;
			self.s1_avg_mo_per_addr_m             := s1_avg_mo_per_addr_m;
			self.s1_addrs_per_ssn_c6              := s1_addrs_per_ssn_c6;
			self.s1_addrs_per_ssn_c6_m            := s1_addrs_per_ssn_c6_m;
			self.s1_addr_stability_v2             := s1_addr_stability_v2;
			self.s1_addr_stability_v2_m           := s1_addr_stability_v2_m;
			self.s1mobility1                      := s1mobility1;
			self.s1_mth_gong_did                  := s1_mth_gong_did;
			self.s1_mth_gong_did_m                := s1_mth_gong_did_m;
			self.s1_rc_dirsaddr_lastscore         := s1_rc_dirsaddr_lastscore;
			self.s1_rc_dirsaddr_lastscore_m       := s1_rc_dirsaddr_lastscore_m;
			self.s1_add1_source_count             := s1_add1_source_count;
			self.s1_add1_source_count_m           := s1_add1_source_count_m;
			self.s1_prop_owner                    := s1_prop_owner;
			self.s1_prop_owner_m                  := s1_prop_owner_m;
			self.s1_rc_numelever                  := s1_rc_numelever;
			self.s1_rc_numelever_m                := s1_rc_numelever_m;
			self.s1_mortgage_risky                := s1_mortgage_risky;
			self.s1_ams_class_gr                  := s1_ams_class_gr;
			self.s1_ams_class_sr                  := s1_ams_class_sr;
			self.s1_ams_college_type              := s1_ams_college_type;
			self.s1_ams_college_type_m            := s1_ams_college_type_m;
			self.s1_ams_college_code              := s1_ams_college_code;
			self.s1_ams_income_level              := s1_ams_income_level;
			self.s1_ams_income_level_m            := s1_ams_income_level_m;
			self.s1ams1                           := s1ams1;
			self.s1_ssns_per_adl_c6               := s1_ssns_per_adl_c6;
			self.s1_ssns_per_adl_c6_m             := s1_ssns_per_adl_c6_m;
			self.s1_adls_per_addr                 := s1_adls_per_addr;
			self.s1_adls_per_addr_m               := s1_adls_per_addr_m;
			self.s1_id_per_addr_diff              := s1_id_per_addr_diff;
			self.s1_id_per_addr_diff_m            := s1_id_per_addr_diff_m;
			self.s1_adls_per_addr_c6              := s1_adls_per_addr_c6;
			self.s1_adls_per_addr_c6_m            := s1_adls_per_addr_c6_m;
			self.s1_phones_per_addr_c6            := s1_phones_per_addr_c6;
			self.s1_phones_per_addr_c6_m          := s1_phones_per_addr_c6_m;
			self.s1_estimated_income              := s1_estimated_income;
			self.s1_estimated_income_m            := s1_estimated_income_m;
			self.s1_state                         := s1_state;
			self.s1_state_m                       := s1_state_m;
			self.s1_inq_banking_count12           := s1_inq_banking_count12;
			self.s1_inq_banking_count12_m         := s1_inq_banking_count12_m;
			self.s1_inq_ssnsperadl                := s1_inq_ssnsperadl;
			self.s1_inq_ssnsperadl_m              := s1_inq_ssnsperadl_m;
			self.s1_inq_perssn                    := s1_inq_perssn;
			self.s1_inq_perssn_m                  := s1_inq_perssn_m;
			self.s1_inq_peraddr                   := s1_inq_peraddr;
			self.s1_inq_peraddr_m                 := s1_inq_peraddr_m;
			self.s1inq2                           := s1inq2;
			self.s103                             := s103;
			self.s2_add_risk                      := s2_add_risk;
			self.s2_phone_risk                    := s2_phone_risk;
			self.s2_addrs_per_ssn                 := s2_addrs_per_ssn;
			self.s2_addrs_per_ssn_m               := s2_addrs_per_ssn_m;
			self.s2_infutor                       := s2_infutor;
			self.s2_rc_dirsaddr_lastscore         := s2_rc_dirsaddr_lastscore;
			self.s2_rc_dirsaddr_lastscore_m       := s2_rc_dirsaddr_lastscore_m;
			self.s2_naprop                        := s2_naprop;
			self.s2_naprop_m                      := s2_naprop_m;
			self.s2_add1_assessedvalue            := s2_add1_assessedvalue;
			self.s2_add1_assessedvalue_m          := s2_add1_assessedvalue_m;
			self.s2_add1_avm_med                  := s2_add1_avm_med;
			self.s2_add1_avm_med_m                := s2_add1_avm_med_m;
			self.s2_buildingarea                  := s2_buildingarea;
			self.s2_buildingarea_m                := s2_buildingarea_m;
			self.s2_add1_2story                   := s2_add1_2story;
			self.s2_econtrj                       := s2_econtrj;
			self.s2_econtrj_m                     := s2_econtrj_m;
			self.s2_mortgage_risky                := s2_mortgage_risky;
			self.s2_adls_per_addr                 := s2_adls_per_addr;
			self.s2_adls_per_addr_m               := s2_adls_per_addr_m;
			self.s2_adls_per_addr_c6              := s2_adls_per_addr_c6;
			self.s2_adls_per_addr_c6_m            := s2_adls_per_addr_c6_m;
			self.s2_phones_per_addr               := s2_phones_per_addr;
			self.s2_phones_per_addr_m             := s2_phones_per_addr_m;
			self.s2_estimated_income              := s2_estimated_income;
			self.s2_estimated_income_m            := s2_estimated_income_m;
			self.s2_inq_peraddr                   := s2_inq_peraddr;
			self.s2_inq_peraddr_m                 := s2_inq_peraddr_m;
			self.s2_other_risk                    := s2_other_risk;
			self.s204                             := s204;
			self.s3_phone_risk                    := s3_phone_risk;
			self.s3_avg_lres                      := s3_avg_lres;
			self.s3_avg_lres_m                    := s3_avg_lres_m;
			self.s3_addrs_per_adl                 := s3_addrs_per_adl;
			self.s3_addrs_per_adl_m               := s3_addrs_per_adl_m;
			self.s3_addrs_per_ssn                 := s3_addrs_per_ssn;
			self.s3_addrs_per_ssn_m               := s3_addrs_per_ssn_m;
			self.s3_unique_addr_count             := s3_unique_addr_count;
			self.s3_unique_addr_count_m           := s3_unique_addr_count_m;
			self.s3_attr_addrs_last30             := s3_attr_addrs_last30;
			self.s3_attr_addrs_last30_m           := s3_attr_addrs_last30_m;
			self.s3mobility2                      := s3mobility2;
			self.s3_mth_gong_did                  := s3_mth_gong_did;
			self.s3_mth_gong_did_m                := s3_mth_gong_did_m;
			self.s3_rc_dirsaddr_lastscore         := s3_rc_dirsaddr_lastscore;
			self.s3_rc_dirsaddr_lastscore_m       := s3_rc_dirsaddr_lastscore_m;
			self.s3_add1_source_count             := s3_add1_source_count;
			self.s3_add1_source_count_m           := s3_add1_source_count_m;
			self.s3_naprop                        := s3_naprop;
			self.s3_naprop_m                      := s3_naprop_m;
			self.s3_minor_src_ver                 := s3_minor_src_ver;
			self.s3_minor_src_ver_i               := s3_minor_src_ver_i;
			self.s3_minor_src_ver_i_m             := s3_minor_src_ver_i_m;
			self.s3_add1_assessedvalue            := s3_add1_assessedvalue;
			self.s3_add1_assessedvalue_m          := s3_add1_assessedvalue_m;
			self.s3_add1_avm                      := s3_add1_avm;
			self.s3_add1_avm_m                    := s3_add1_avm_m;
			self.s3_add2_salesprice               := s3_add2_salesprice;
			self.s3_add2_salesprice_m             := s3_add2_salesprice_m;
			self.s3_add2_avm                      := s3_add2_avm;
			self.s3_add2_avm_m                    := s3_add2_avm_m;
			self.s3_add3_assessedvalue            := s3_add3_assessedvalue;
			self.s3_add3_assessedvalue_m          := s3_add3_assessedvalue_m;
			self.s3_add3_avm                      := s3_add3_avm;
			self.s3_add3_avm_m                    := s3_add3_avm_m;
			self.s3_add1_avm_med                  := s3_add1_avm_med;
			self.s3_add1_avm_med_m                := s3_add1_avm_med_m;
			self.s3_buildingarea                  := s3_buildingarea;
			self.s3_buildingarea_m                := s3_buildingarea_m;
			self.s3_add1_avm_to_med_ratio         := s3_add1_avm_to_med_ratio;
			self.s3_add1_avm_to_med_ratio_m       := s3_add1_avm_to_med_ratio_m;
			self.s3_add1_bath_36                  := s3_add1_bath_36;
			self.s3_add1_no_of_partial_baths      := s3_add1_no_of_partial_baths;
			self.s3avm1                           := s3avm1;
			self.s3_mortgage_risky                := s3_mortgage_risky;
			self.s3_econtrj                       := s3_econtrj;
			self.s3_econtrj_m                     := s3_econtrj_m;
			self.s3_ams_class_high                := s3_ams_class_high;
			self.s3_ams_college_tier              := s3_ams_college_tier;
			self.s3_ams_college_tier_m            := s3_ams_college_tier_m;
			self.s3_ams_income_level              := s3_ams_income_level;
			self.s3_ams_income_level_m            := s3_ams_income_level_m;
			self.s3ams2                           := s3ams2;
			self.s3_adlperssn                     := s3_adlperssn;
			self.s3_adlperssn_m                   := s3_adlperssn_m;
			self.s3_adls_per_addr                 := s3_adls_per_addr;
			self.s3_adls_per_addr_m               := s3_adls_per_addr_m;
			self.s3_id_per_addr_diff              := s3_id_per_addr_diff;
			self.s3_id_per_addr_diff_m            := s3_id_per_addr_diff_m;
			self.s3_adls_per_addr_c6              := s3_adls_per_addr_c6;
			self.s3_adls_per_addr_c6_m            := s3_adls_per_addr_c6_m;
			self.s3_phones_per_addr_c6            := s3_phones_per_addr_c6;
			self.s3_phones_per_addr_c6_m          := s3_phones_per_addr_c6_m;
			self.s3_estimated_income              := s3_estimated_income;
			self.s3_estimated_income_m            := s3_estimated_income_m;
			self.s3_inq_count12                   := s3_inq_count12;
			self.s3_inq_count12_m                 := s3_inq_count12_m;
			self.s3_inq_peraddr                   := s3_inq_peraddr;
			self.s3_inq_peraddr_m                 := s3_inq_peraddr_m;
			self.s3_state                         := s3_state;
			self.s3_state_m                       := s3_state_m;
			self.s3_other_risk                    := s3_other_risk;
			self.s3_other_good                    := s3_other_good;
			self.s3_dist_a1toa2_1to10             := s3_dist_a1toa2_1to10;
			self.s3_dist_a1toa3_1to10             := s3_dist_a1toa3_1to10;
			self.s301                             := s301;
			self.s4_age                           := s4_age;
			self.s4_age_m                         := s4_age_m;
			self.s4_phone_risk                    := s4_phone_risk;
			self.s4_avg_lres                      := s4_avg_lres;
			self.s4_avg_lres_m                    := s4_avg_lres_m;
			self.s4_avg_mo_per_addr               := s4_avg_mo_per_addr;
			self.s4_avg_mo_per_addr_m             := s4_avg_mo_per_addr_m;
			self.s4_addrs_per_ssn                 := s4_addrs_per_ssn;
			self.s4_addrs_per_ssn_m               := s4_addrs_per_ssn_m;
			self.s4_addr_stability_v2             := s4_addr_stability_v2;
			self.s4_addr_stability_v2_m           := s4_addr_stability_v2_m;
			self.s4_addrs_15yr                    := s4_addrs_15yr;
			self.s4_addrs_15yr_m                  := s4_addrs_15yr_m;
			self.s4_unique_addr_count             := s4_unique_addr_count;
			self.s4_attr_addrs_last24             := s4_attr_addrs_last24;
			self.s4_attr_addrs_last24_m           := s4_attr_addrs_last24_m;
			self.s4mobility2                      := s4mobility2;
			self.s4_mth_gong_did                  := s4_mth_gong_did;
			self.s4_mth_gong_did_m                := s4_mth_gong_did_m;
			self.s4_rc_dirsaddr_lastscore         := s4_rc_dirsaddr_lastscore;
			self.s4_rc_dirsaddr_lastscore_m       := s4_rc_dirsaddr_lastscore_m;
			self.s4_rc_phoneaddrcount             := s4_rc_phoneaddrcount;
			self.s4_combo_addrscore100            := s4_combo_addrscore100;
			self.s4_naprop                        := s4_naprop;
			self.s4_naprop_m                      := s4_naprop_m;
			self.s4_minor_src_ver                 := s4_minor_src_ver;
			self.s4_minor_src_ver_i               := s4_minor_src_ver_i;
			self.s4_minor_src_ver_i_m             := s4_minor_src_ver_i_m;
			self.s4_add1_assessedvalue            := s4_add1_assessedvalue;
			self.s4_add1_assessedvalue_m          := s4_add1_assessedvalue_m;
			self.s4_add1_marketvalue              := s4_add1_marketvalue;
			self.s4_add1_marketvalue_m            := s4_add1_marketvalue_m;
			self.s4_add1_avm                      := s4_add1_avm;
			self.s4_add1_avm_m                    := s4_add1_avm_m;
			self.s4_add2_salesprice               := s4_add2_salesprice;
			self.s4_add2_salesprice_m             := s4_add2_salesprice_m;
			self.s4_add2_avm                      := s4_add2_avm;
			self.s4_add2_avm_m                    := s4_add2_avm_m;
			self.s4_add3_assessedvalue            := s4_add3_assessedvalue;
			self.s4_add3_marketvalue              := s4_add3_marketvalue;
			self.s4_add3_avm                      := s4_add3_avm;
			self.s4_add3_assessedvalue_m          := s4_add3_assessedvalue_m;
			self.s4_add3_marketvalue_m            := s4_add3_marketvalue_m;
			self.s4_add3_avm_m                    := s4_add3_avm_m;
			self.s4_add1_avm_med                  := s4_add1_avm_med;
			self.s4_add1_avm_med_m                := s4_add1_avm_med_m;
			self.s4_add1_avm_to_med_ratio         := s4_add1_avm_to_med_ratio;
			self.s4_add1_avm_to_med_ratio_m       := s4_add1_avm_to_med_ratio_m;
			self.s4_buildingarea                  := s4_buildingarea;
			self.s4_buildingarea_m                := s4_buildingarea_m;
			self.s4_add1_no_of_partial_baths      := s4_add1_no_of_partial_baths;
			self.s4avm1                           := s4avm1;
			self.s4_mortgage_risky                := s4_mortgage_risky;
			self.s4_ams_class                     := s4_ams_class;
			self.s4_ams_college_tier              := s4_ams_college_tier;
			self.s4_ams_income_level              := s4_ams_income_level;
			self.s4_ams_college_tier_m            := s4_ams_college_tier_m;
			self.s4_ams_income_level_m            := s4_ams_income_level_m;
			self.s4ams2                           := s4ams2;
			self.s4_adlperssn                     := s4_adlperssn;
			self.s4_adlperssn_m                   := s4_adlperssn_m;
			self.s4_adls_per_addr                 := s4_adls_per_addr;
			self.s4_adls_per_addr_m               := s4_adls_per_addr_m;
			self.s4_id_per_addr_diff              := s4_id_per_addr_diff;
			self.s4_id_per_addr_diff_m            := s4_id_per_addr_diff_m;
			self.s4_adls_per_addr_c6              := s4_adls_per_addr_c6;
			self.s4_adls_per_addr_c6_m            := s4_adls_per_addr_c6_m;
			self.s4_estimated_income              := s4_estimated_income;
			self.s4_estimated_income_m            := s4_estimated_income_m;
			self.s4_inq_peraddr                   := s4_inq_peraddr;
			self.s4_other_risk                    := s4_other_risk;
			self.s4_other_good                    := s4_other_good;
			self.s404                             := s404;
			self.s5_minor_src_ver                 := s5_minor_src_ver;
			self.s5_minor_src_ver_i               := s5_minor_src_ver_i;
			self.s5_minor_src_ver_i_m             := s5_minor_src_ver_i_m;
			self.s5_phone_risk                    := s5_phone_risk;
			self.s5_add1_assessedvalue            := s5_add1_assessedvalue;
			self.s5_add1_marketvalue              := s5_add1_marketvalue;
			self.s5_add1_avm                      := s5_add1_avm;
			self.s5_add2_salesprice               := s5_add2_salesprice;
			self.s5_add1_assessedvalue_m          := s5_add1_assessedvalue_m;
			self.s5_add1_marketvalue_m            := s5_add1_marketvalue_m;
			self.s5_add1_avm_m                    := s5_add1_avm_m;
			self.s5_add2_salesprice_m             := s5_add2_salesprice_m;
			self.s5_add2_avm                      := s5_add2_avm;
			self.s5_add2_avm_m                    := s5_add2_avm_m;
			self.s5_add3_assessedvalue            := s5_add3_assessedvalue;
			self.s5_add3_marketvalue              := s5_add3_marketvalue;
			self.s5_add3_avm                      := s5_add3_avm;
			self.s5_add1_avm_med                  := s5_add1_avm_med;
			self.s5_buildingarea                  := s5_buildingarea;
			self.s5_add3_assessedvalue_m          := s5_add3_assessedvalue_m;
			self.s5_add3_marketvalue_m            := s5_add3_marketvalue_m;
			self.s5_add3_avm_m                    := s5_add3_avm_m;
			self.s5_add1_avm_med_m                := s5_add1_avm_med_m;
			self.s5_buildingarea_m                := s5_buildingarea_m;
			self.s5_add1_2story                   := s5_add1_2story;
			self.s5_add1_bath_37                  := s5_add1_bath_37;
			self.s5avm02                          := s5avm02;
			self.s5_mortgage_risky                := s5_mortgage_risky;
			self.s5_ssns_per_addr                 := s5_ssns_per_addr;
			self.s5_ssns_per_addr_m               := s5_ssns_per_addr_m;
			self.s5_id_per_addr_diff              := s5_id_per_addr_diff;
			self.s5_id_per_addr_diff_m            := s5_id_per_addr_diff_m;
			self.s5_ssns_per_addr_c6              := s5_ssns_per_addr_c6;
			self.s5_id_per_addr_c6_diff           := s5_id_per_addr_c6_diff;
			self.s5_ssns_per_addr_c6_m            := s5_ssns_per_addr_c6_m;
			self.s5_id_per_addr_c6_diff_m         := s5_id_per_addr_c6_diff_m;
			self.s5_ams_age_lt20                  := s5_ams_age_lt20;
			self.s5_ams_income_level              := s5_ams_income_level;
			self.s5_ams_college_tier              := s5_ams_college_tier;
			self.s5_ams_income_level_m            := s5_ams_income_level_m;
			self.s5_ams_college_tier_m            := s5_ams_college_tier_m;
			self.s5ams2                           := s5ams2;
			self.s5_state                         := s5_state;
			self.s5_state_m                       := s5_state_m;
			self.s5_other_risk                    := s5_other_risk;
			self.s5_rc_dirsaddr_lastscore         := s5_rc_dirsaddr_lastscore;
			self.s5_rc_dirsaddr_lastscore_m       := s5_rc_dirsaddr_lastscore_m;
			self.s5_mth_add1                      := s5_mth_add1;
			self.s5_mth_add1_m                    := s5_mth_add1_m;
			self.s5_addrs_per_ssn                 := s5_addrs_per_ssn;
			self.s5_addrs_per_adl                 := s5_addrs_per_adl;
			self.s5_addrs_per_ssn_m               := s5_addrs_per_ssn_m;
			self.s5_addrs_per_adl_m               := s5_addrs_per_adl_m;
			self.s5_addr_stability_v2             := s5_addr_stability_v2;
			self.s5_addr_stability_v2_m           := s5_addr_stability_v2_m;
			self.s5_attr_addrs_last90             := s5_attr_addrs_last90;
			self.s5_attr_addrs_last90_m           := s5_attr_addrs_last90_m;
			self.s5_addrs_per_adl_c6              := s5_addrs_per_adl_c6;
			self.s5_addrs_per_adl_c6_m            := s5_addrs_per_adl_c6_m;
			self.s5mobility3                      := s5mobility3;
			self.s5_phones_per_addr               := s5_phones_per_addr;
			self.s5_phones_per_addr_m             := s5_phones_per_addr_m;
			self.s5_add_risk                      := s5_add_risk;
			self.s5_other_good                    := s5_other_good;
			self.nap_summary_1                    := nap_summary_1;
			self.s5_inq_count01                   := s5_inq_count01;
			self.s5_inq_count03                   := s5_inq_count03;
			self.s5_inq_count01_m                 := s5_inq_count01_m;
			self.s5_inq_count03_m                 := s5_inq_count03_m;
			self.s5_inq_communications_count12    := s5_inq_communications_count12;
			self.s5_inq_communications_count12_m  := s5_inq_communications_count12_m;
			self.s5_inq_phonesperadl              := s5_inq_phonesperadl;
			self.s5_inq_phonesperadl_m            := s5_inq_phonesperadl_m;
			self.s5_inq_lnamesperssn              := s5_inq_lnamesperssn;
			self.s5_inq_lnamesperssn_m            := s5_inq_lnamesperssn_m;
			self.s5_inq_peraddr                   := s5_inq_peraddr;
			self.s5_inq_peraddr_m                 := s5_inq_peraddr_m;
			self.s5_inq_adlsperphone              := s5_inq_adlsperphone;
			self.s5_inq_adlsperphone_m            := s5_inq_adlsperphone_m;
			self.s5inq2                           := s5inq2;
			self.s5_email_count                   := s5_email_count;
			self.s5_email_count_m                 := s5_email_count_m;
			self.s5_econtrj                       := s5_econtrj;
			self.s5_econtrj_m                     := s5_econtrj_m;
			self.s5_dist_a1toa2_1to10             := s5_dist_a1toa2_1to10;
			self.s5_dist_a1toa3_1to10             := s5_dist_a1toa3_1to10;
			self.s5_mth_header_first_seen         := s5_mth_header_first_seen;
			self.s5_mth_header_first_seen_m       := s5_mth_header_first_seen_m;
			self.s5_attr_num_nonderogs180         := s5_attr_num_nonderogs180;
			self.s5_attr_num_nonderogs180_m       := s5_attr_num_nonderogs180_m;
			self.s5_naprop                        := s5_naprop;
			self.s5_naprop_m                      := s5_naprop_m;
			self.s5_adlperssn_count               := s5_adlperssn_count;
			self.s5_adlperssn_count_m             := s5_adlperssn_count_m;
			self.s5_ssns_per_adl_c6               := s5_ssns_per_adl_c6;
			self.s5_ssns_per_adl_c6_m             := s5_ssns_per_adl_c6_m;
			self.s5_estimated_income              := s5_estimated_income;
			self.s5_wealth_index                  := s5_wealth_index;
			self.s5_estimated_income_m            := s5_estimated_income_m;
			self.s5_wealth_index_m                := s5_wealth_index_m;
			self.s502c                            := s502c;
			self.s6_add_phone_risk                := s6_add_phone_risk;
			self.s6_addrs_per_ssn                 := s6_addrs_per_ssn;
			self.s6_addrs_per_ssn_m               := s6_addrs_per_ssn_m;
			self.s6_attr_addrs_last24             := s6_attr_addrs_last24;
			self.s6_attr_addrs_last24_m           := s6_attr_addrs_last24_m;
			self.s6_mth_header_first_seen         := s6_mth_header_first_seen;
			self.s6_mth_header_first_seen_m       := s6_mth_header_first_seen_m;
			self.s6_rc_addrcount                  := s6_rc_addrcount;
			self.s6_rc_addrcount_m                := s6_rc_addrcount_m;
			self.s6_add2_marketvalue              := s6_add2_marketvalue;
			self.s6_add2_marketvalue_m            := s6_add2_marketvalue_m;
			self.s6_add3_marketvalue              := s6_add3_marketvalue;
			self.s6_add3_marketvalue_m            := s6_add3_marketvalue_m;
			self.s6_buildingarea                  := s6_buildingarea;
			self.s6_buildingarea_m                := s6_buildingarea_m;
			self.s6_mortgage_risky                := s6_mortgage_risky;
			self.s6_ams_college_tier              := s6_ams_college_tier;
			self.s6_ams_income_level              := s6_ams_income_level;
			self.s6_ams_college_tier_m            := s6_ams_college_tier_m;
			self.s6_ams_income_level_m            := s6_ams_income_level_m;
			self.s6_adls_per_addr                 := s6_adls_per_addr;
			self.s6_adls_per_addr_c6              := s6_adls_per_addr_c6;
			self.s6_adls_per_addr_c6_m            := s6_adls_per_addr_c6_m;
			self.s6_estimated_income              := s6_estimated_income;
			self.s6_estimated_income_m            := s6_estimated_income_m;
			self.s6_inq_count12                   := s6_inq_count12;
			self.s6_inq_peraddr                   := s6_inq_peraddr;
			self.s6_inq_count12_m                 := s6_inq_count12_m;
			self.s6_inq_peraddr_m                 := s6_inq_peraddr_m;
			self.s6_state                         := s6_state;
			self.s6_state_m                       := s6_state_m;
			self.s603                             := s603;
			self.s7_age                           := s7_age;
			self.s7_age_m                         := s7_age_m;
			self.s7_phone_risk                    := s7_phone_risk;
			self.s7_avg_lres                      := s7_avg_lres;
			self.s7_avg_lres_m                    := s7_avg_lres_m;
			self.s7_avg_mo_per_addr               := s7_avg_mo_per_addr;
			self.s7_avg_mo_per_addr_m             := s7_avg_mo_per_addr_m;
			self.s7_addrs_per_ssn_c6              := s7_addrs_per_ssn_c6;
			self.s7_addrs_per_ssn_c6_m            := s7_addrs_per_ssn_c6_m;
			self.s7_attr_addrs_last90             := s7_attr_addrs_last90;
			self.s7_attr_addrs_last90_m           := s7_attr_addrs_last90_m;
			self.s7_age_on_eq                     := s7_age_on_eq;
			self.s7_mth_gong_did                  := s7_mth_gong_did;
			self.s7_mth_gong_did_m                := s7_mth_gong_did_m;
			self.s7_attr_num_nonderogs30          := s7_attr_num_nonderogs30;
			self.s7_attr_num_nonderogs30_m        := s7_attr_num_nonderogs30_m;
			self.s7_rc_dirsaddr_lastscore         := s7_rc_dirsaddr_lastscore;
			self.s7_rc_dirsaddr_lastscore_m       := s7_rc_dirsaddr_lastscore_m;
			self.s7_prop_owner                    := s7_prop_owner;
			self.s7_prop_owner_m                  := s7_prop_owner_m;
			self.s7_rc_numelever                  := s7_rc_numelever;
			self.s7_rc_numelever_m                := s7_rc_numelever_m;
			self.s7_add2_avm                      := s7_add2_avm;
			self.s7_add2_avm_m                    := s7_add2_avm_m;
			self.s7_add3_marketvalue              := s7_add3_marketvalue;
			self.s7_add3_avm                      := s7_add3_avm;
			self.s7_add3_marketvalue_m            := s7_add3_marketvalue_m;
			self.s7_add3_avm_m                    := s7_add3_avm_m;
			self.s7_add1_avm_med                  := s7_add1_avm_med;
			self.s7_add1_avm_med_m                := s7_add1_avm_med_m;
			self.s7_add1_2story                   := s7_add1_2story;
			self.s7_mortgage_risky                := s7_mortgage_risky;
			self.s7_ams_college_tier              := s7_ams_college_tier;
			self.s7_ams_income_level              := s7_ams_income_level;
			self.s7_ams_college_tier_m            := s7_ams_college_tier_m;
			self.s7_ams_income_level_m            := s7_ams_income_level_m;
			self.s7_ams_class_gr                  := s7_ams_class_gr;
			self.s7_ssns_per_adl                  := s7_ssns_per_adl;
			self.s7_ssns_per_adl_m                := s7_ssns_per_adl_m;
			self.s7_adlperssn                     := s7_adlperssn;
			self.s7_adlperssn_m                   := s7_adlperssn_m;
			self.s7_ssns_per_adl_c6               := s7_ssns_per_adl_c6;
			self.s7_ssns_per_adl_c6_m             := s7_ssns_per_adl_c6_m;
			self.s7_adls_per_addr                 := s7_adls_per_addr;
			self.s7_adls_per_addr_m               := s7_adls_per_addr_m;
			self.s7_adls_per_addr_c6              := s7_adls_per_addr_c6;
			self.s7_adls_per_addr_c6_m            := s7_adls_per_addr_c6_m;
			self.s7_phones_per_addr_c6            := s7_phones_per_addr_c6;
			self.s7_phones_per_addr_c6_m          := s7_phones_per_addr_c6_m;
			self.s7_estimated_income              := s7_estimated_income;
			self.s7_wealth_index                  := s7_wealth_index;
			self.s7_estimated_income_m            := s7_estimated_income_m;
			self.s7_wealth_index_m                := s7_wealth_index_m;
			self.s7_inq_count12                   := s7_inq_count12;
			self.s7_inq_peraddr                   := s7_inq_peraddr;
			self.s7_inq_count12_m                 := s7_inq_count12_m;
			self.s7_inq_peraddr_m                 := s7_inq_peraddr_m;
			self.s7_other_risk                    := s7_other_risk;
			self.s7_add_risk                      := s7_add_risk;
			self.s7_other_risk2                   := s7_other_risk2;
			self.s7_other_risk2_m                 := s7_other_risk2_m;
			self.s7_other_good                    := s7_other_good;
			self.s7_email_domain_free             := s7_email_domain_free;
			self.s7_email_domain_free_m           := s7_email_domain_free_m;
			self.s705                             := s705;
			self.s8_age                           := s8_age;
			self.s8_age_m                         := s8_age_m;
			self.s8_mth_rc_ssnlowissue            := s8_mth_rc_ssnlowissue;
			self.s8_mth_rc_ssnlowissue_m          := s8_mth_rc_ssnlowissue_m;
			self.s8_add_risk                      := s8_add_risk;
			self.s8_mth_add1                      := s8_mth_add1;
			self.s8_avg_lres                      := s8_avg_lres;
			self.s8_mth_add1_m                    := s8_mth_add1_m;
			self.s8_avg_lres_m                    := s8_avg_lres_m;
			self.s8_avg_mo_per_addr               := s8_avg_mo_per_addr;
			self.s8_avg_mo_per_addr_m             := s8_avg_mo_per_addr_m;
			self.s8_addrs_per_ssn                 := s8_addrs_per_ssn;
			self.s8_addrs_per_ssn_m               := s8_addrs_per_ssn_m;
			self.s8_addrs_per_ssn_c6              := s8_addrs_per_ssn_c6;
			self.s8_addrs_per_ssn_c6_m            := s8_addrs_per_ssn_c6_m;
			self.s8_addr_stability_v2             := s8_addr_stability_v2;
			self.s8_addr_stability_v2_m           := s8_addr_stability_v2_m;
			self.s8_attr_addrs_last90             := s8_attr_addrs_last90;
			self.s8_attr_addrs_last90_m           := s8_attr_addrs_last90_m;
			self.s8mobility2                      := s8mobility2;
			self.s8_nap                           := s8_nap;
			self.s8_nap_m                         := s8_nap_m;
			self.s8_mth_eq                        := s8_mth_eq;
			self.s8_mth_eq_m                      := s8_mth_eq_m;
			self.s8_mth_gong_did                  := s8_mth_gong_did;
			self.s8_mth_gong_did_m                := s8_mth_gong_did_m;
			self.s8_attr_num_nonderogs30          := s8_attr_num_nonderogs30;
			self.s8_attr_num_nonderogs30_m        := s8_attr_num_nonderogs30_m;
			self.s8_prop_owner                    := s8_prop_owner;
			self.s8_prop_owner_m                  := s8_prop_owner_m;
			self.s8_minor_src_ver                 := s8_minor_src_ver;
			self.s8_minor_src_ver_i               := s8_minor_src_ver_i;
			self.s8_pl                            := s8_pl;
			self.s8_minor_src_ver_i_m             := s8_minor_src_ver_i_m;
			self.s8_add2_marketvalue              := s8_add2_marketvalue;
			self.s8_add2_marketvalue_m            := s8_add2_marketvalue_m;
			self.s8_add3_marketvalue              := s8_add3_marketvalue;
			self.s8_add3_marketvalue_m            := s8_add3_marketvalue_m;
			self.s8_add1_avm_med                  := s8_add1_avm_med;
			self.s8_add1_avm_to_med_ratio         := s8_add1_avm_to_med_ratio;
			self.s8_buildingarea                  := s8_buildingarea;
			self.s8_add1_avm_med_m                := s8_add1_avm_med_m;
			self.s8_add1_avm_to_med_ratio_m       := s8_add1_avm_to_med_ratio_m;
			self.s8_buildingarea_m                := s8_buildingarea_m;
			self.s8_add1_2story                   := s8_add1_2story;
			self.s8_add1_no_of_partial_baths      := s8_add1_no_of_partial_baths;
			self.s8avm2                           := s8avm2;
			self.s8_mortgage_risky                := s8_mortgage_risky;
			self.s8_econtrj                       := s8_econtrj;
			self.s8_econtrj_m                     := s8_econtrj_m;
			self.s8_mth_add1_purchase_date        := s8_mth_add1_purchase_date;
			self.s8_mth_add1_purchase_date_m      := s8_mth_add1_purchase_date_m;
			self.s8_ams_age_le31                  := s8_ams_age_le31;
			self.s8_ams_college_tier              := s8_ams_college_tier;
			self.s8_ams_income_level              := s8_ams_income_level;
			self.s8_ams_college_tier_m            := s8_ams_college_tier_m;
			self.s8_ams_income_level_m            := s8_ams_income_level_m;
			self.s8ams1                           := s8ams1;
			self.s8_ssns_per_adl                  := s8_ssns_per_adl;
			self.s8_ssns_per_adl_m                := s8_ssns_per_adl_m;
			self.s8_adlperssn                     := s8_adlperssn;
			self.s8_adlperssn_m                   := s8_adlperssn_m;
			self.s8_ssns_per_adl_c6               := s8_ssns_per_adl_c6;
			self.s8_ssns_per_adl_c6_m             := s8_ssns_per_adl_c6_m;
			self.s8_adls_per_addr                 := s8_adls_per_addr;
			self.s8_adls_per_addr_m               := s8_adls_per_addr_m;
			self.s8_id_per_addr_diff              := s8_id_per_addr_diff;
			self.s8_id_per_addr_diff_m            := s8_id_per_addr_diff_m;
			self.s8_adls_per_addr_c6              := s8_adls_per_addr_c6;
			self.s8_adls_per_addr_c6_m            := s8_adls_per_addr_c6_m;
			self.s8_phones_per_addr_c6            := s8_phones_per_addr_c6;
			self.s8_phones_per_addr_c6_m          := s8_phones_per_addr_c6_m;
			self.s8_nameperssn_count              := s8_nameperssn_count;
			self.s8_wealth_index                  := s8_wealth_index;
			self.s8_wealth_index_m                := s8_wealth_index_m;
			self.s8_inq_peradl                    := s8_inq_peradl;
			self.s8_inq_peradl_m                  := s8_inq_peradl_m;
			self.s8_inq_addrsperadl               := s8_inq_addrsperadl;
			self.s8_inq_lnamesperaddr             := s8_inq_lnamesperaddr;
			self.s8_inq_lnamesperaddr_m           := s8_inq_lnamesperaddr_m;
			self.s8inq2                           := s8inq2;
			self.s8_state2                        := s8_state2;
			self.s8_state2_m                      := s8_state2_m;
			self.s803                             := s803;
			self.uv_derog                         := uv_derog;
			self.uv_eq_type                       := uv_eq_type;
			self.uv_propowner                     := uv_propowner;
			self.uv_segment                       := uv_segment;
			self.logit                            := logit;
			self.phat                             := phat;
			self.base                             := base;
			self.odds                             := odds;
			self.point                            := point;
			self.rvp1104_raw                      := rvp1104_raw;
			self.ov_ssndead                       := ov_ssndead;
			self.ov_ssnprior                      := ov_ssnprior;
			self.ov_criminal_flag                 := ov_criminal_flag;
			self.ov_corrections                   := ov_corrections;
			self.ov_impulse                       := ov_impulse;
			self.ov_condition                     := ov_condition;
			self.rvp1104_cap                      := rvp1104_cap;
			self.uv_rv20_content                  := uv_rv20_content;
			self.uv_gong_sourced                  := uv_gong_sourced;
			self.uv_eq_only                       := uv_eq_only;
			self.uv_rvp1003_content               := uv_rvp1003_content;
			self.rvp1104                          := rvp1104;
		#end

		self.seq := le.seq;
		PrescreenOptOut := xmlPrescreenOptOut or risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
		self.score := if( risk_indicators.rcset.isCode95(PreScreenOptOut), '222', (string3)rvp1104 );
		self.ri := if( risk_indicators.rcset.isCode95(PreScreenOptOut), DATASET([{'95', risk_indicators.getHRIDesc('95')}],risk_indicators.Layout_Desc) );
	end;
	
	model := project( clam, doModel(left) );
	return model;
end;