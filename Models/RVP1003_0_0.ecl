import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;


export RVP1003_0_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean PreScreenOptOut=false ) := FUNCTION

	RVP_DEBUG := false;
	
	#if(RVP_DEBUG)
	Layout_Debug := record
		integer seq;
		Boolean trueDID;
		String adl_category;
		String out_unit_desig;
		String out_sec_range;
		String out_st;
		String out_addr_type;
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		Integer did_count;
		Integer rc_dirsaddr_lastscore;
		Boolean rc_input_addr_not_most_recent;
		String rc_hriskphoneflag;
		String rc_phonevalflag;
		String rc_hphonevalflag;
		String rc_phonezipflag;
		String rc_hriskaddrflag;
		String rc_decsflag;
		String rc_ssndobflag;
		String rc_pwssndobflag;
		String rc_pwssnvalflag;
		String rc_ssnstate;
		String rc_dwelltype;
		String rc_bansflag;
		String rc_sources;
		Integer rc_numelever;
		Integer rc_phoneaddr_lnamecount;
		String rc_hrisksic;
		Integer rc_disthphoneaddr;
		String rc_ziptypeflag;
		String rc_statezipflag;
		Boolean rc_altlname1_flag;
		Boolean rc_altlname2_flag;
		Boolean rc_fnamessnmatch;
		Integer combo_dobscore;
		Integer combo_addrcount;
		Boolean rc_watchlist_flag;
		String ssnlength;
		Boolean hphnpop;
		Boolean lname_eda_sourced;
		Integer age;
		Integer add1_unit_count;
		String add1_avm_land_use;
		String add1_avm_recording_date;
		String add1_avm_sales_price;
		String add1_avm_assessed_total_value;
		String add1_avm_market_total_value;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_automated_valuation_2;
		Integer add1_avm_med_fips;
		Integer add1_avm_med_geo11;
		Integer add1_avm_med_geo12;
		Integer add1_naprop;
		Integer add1_purchase_date;
		String add1_mortgage_type;
		Integer ADD1_ASSESSED_AMOUNT;
		Integer add1_date_first_seen;
		String add1_building_area;
		Integer PROPERTY_OWNED_TOTAL;
		Integer PROPERTY_SOLD_TOTAL;
		Integer property_sold_assessed_total;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer dist_a2toa3;
		Integer addrs_10yr;
		String telcordia_type;
		Integer gong_did_phone_ct;
		Integer credit_first_seen;
		Integer addrs_per_adl;
		Integer adlPerSSN_count;
		Integer addrs_per_ssn;
		Integer adls_per_addr;
		Integer ssns_per_addr;
		Integer phones_per_addr;
		Integer adls_per_addr_c6;
		Integer ssns_per_addr_c6;
		Integer infutor_first_seen;
		Integer infutor_nap;
		Integer impulse_count;
		Integer attr_num_watercraft60;
		Integer attr_total_number_derogs;
		Integer attr_eviction_count;
		Integer attr_num_nonderogs90;
		Boolean Bankrupt;
		Integer date_last_seen;
		Integer filing_count;
		Integer bk_recent_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer liens_recent_released_count;
		Integer liens_historical_released_count;
		Integer liens_unrel_cj_last_seen;
		Integer liens_unrel_ot_total_amount;
		Integer criminal_count;
		Integer felony_count;
		Integer watercraft_count;
		String ams_college_code;
		String ams_income_level_code;
		String ams_file_type;
		Boolean prof_license_flag;
		String prof_license_category;
		String wealth_index;
		String input_dob_match_level;
		String addr_stability;
		// String archive_date;
		Integer archive_date;
		Integer sysdate;
		Real sysyear;
		Integer in_dob2;
		Real years_in_dob;
		Real months_in_dob;
		Integer add1_avm_recording_date2;
		Real years_add1_avm_recording_date;
		Real months_add1_avm_recording_date;
		Integer add1_purchase_date2;
		Real years_add1_purchase_date;
		Real months_add1_purchase_date;
		Integer add1_date_first_seen2;
		Real years_add1_date_first_seen;
		Real months_add1_date_first_seen;
		Integer credit_first_seen2;
		Real years_credit_first_seen;
		Real months_credit_first_seen;
		Integer date_last_seen2;
		Real years_date_last_seen;
		Real months_date_last_seen;
		Integer infutor_first_seen2;
		Real years_infutor_first_seen;
		Real months_infutor_first_seen;
		Integer liens_unrel_cj_last_seen2;
		Real years_liens_unrel_cj_last_seen;
		Real months_liens_unrel_cj_last_seen;
		Boolean source_tot_AK;
		Boolean source_tot_AM;
		Boolean source_tot_BA;
		Boolean source_tot_CG;
		Boolean source_tot_DA;
		Boolean source_tot_DS;
		Boolean source_tot_EB;
		Boolean source_tot_EM;
		Boolean source_tot_EQ;
		Boolean source_tot_VO;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean source_tot_P;
		Boolean source_tot_PL;
		Boolean source_tot_SL;
		Boolean source_tot_V;
		Boolean source_tot_W;
		Boolean source_tot_voter;
		Integer source_tot_total;
		String out_st_region;
		String out_st_division;
		Integer out_st_i;
		String ssnst_region;
		String uv_filetype;
		String dy_prop_ownership;
		Boolean Adl_deceased;
		Boolean rc_deceased;
		Boolean combine_deceased_flag;
		Boolean bk_flag;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean combine_lien_flag;
		Boolean attr_total_derog_flag;
		Boolean attr_eviction_flag;
		Boolean criminal_flag;
		Boolean felony_flag;
		Boolean impulse_flag;
		Boolean combine_derog_flag;
		String uv_dy_segment;
		String uv_dy_segment2_b1;
		String uv_dy_segment2_b2;
		String uv_dy_segment2_b3;
		String uv_dy_segment2;
		Integer nw_nap_i;
		Integer nd_nap_i;
		Integer ko_nap_i;
		Integer kd_nap_i;
		Boolean kw_nap_good;
		Integer kd_rc_numelever_i;
		Integer kw_rc_numelever_i;
		Boolean rc_phoneaddr_lname_flag;
		Boolean watercraft_flag;
		Integer nw_minor_pos_source_f;
		Integer nr_minor_pos_source_f;
		Integer tw_minor_pos_source_f;
		Integer to_minor_pos_source_f;
		Integer tr_minor_pos_source_f;
		Integer ko_minor_pos_source_f;
		Integer kr_minor_pos_source_f;
		Integer kd_minor_pos_source_f;
		Integer kw_minor_pos_source_f;
		Integer nd_naprop_i;
		Integer tw_naprop_i;
		Integer td_naprop_i;
		Integer kd_naprop_i;
		Boolean kw_add1_naprop_good;
		Integer no_rc_dirsaddr_lastscore_i;
		Integer to_rc_dirsaddr_lastscore_i;
		Integer kr_rc_dirsaddr_lastscore_i;
		Integer kw_rc_dirsaddr_lastscore_i;
		Integer tr_rc_dirsaddr_lastscore_i;
		Boolean phn_notpots;
		Boolean nr_phone_notpots;
		Boolean tw_phone_risk;
		Boolean to_phone_risk;
		Integer nw_years_add1_purchase_date_i;
		Integer tw_years_add1_purchase_date_i;
		Integer kw_years_add1_purchase_date_i;
		Boolean avm_hit;
		Integer nw_years_add1_avm_recording_i;
		Integer nr_years_add1_avm_recording_i;
		Integer tw_years_add1_avm_recording_i;
		Integer kw_years_add1_avm_recording_i;
		Integer add1_avm_med;
		Integer add1_avm_sales_price_i;
		Integer add1_avm_assessed_value_i;
		Integer add1_avm_market_value_i;
		Integer add1_avm_valuation_i;
		Integer add1_avm_med_i;
		Integer add1_assessed_amount_i;
		Integer add1_combine_assessed_value_i;
		Integer nw_add1_avm_sales_price_i;
		Integer nr_add1_avm_sales_price_i;
		Integer tw_add1_avm_sales_price_i;
		Integer nw_add1_assessed_value_i;
		Integer tr_add1_assessed_value_i;
		Integer nr_add1_assessed_value_i;
		Integer tw_add1_assessed_value_i;
		Integer kr_add1_assessed_value_i;
		Integer nw_add1_avm_valuation_i;
		Integer tw_add1_avm_valuation_i;
		Integer tr_add1_avm_valuation_i;
		Integer kw_add1_avm_valuation_i;
		Integer nw_add1_avm_med_i;
		Integer nr_add1_avm_med_i;
		Integer no_add1_avm_med_i;
		Integer nd_add1_avm_med_i;
		Integer tw_add1_avm_med_i;
		Integer to_add1_avm_med_i;
		Integer tr_add1_avm_med_i;
		Integer ko_ADD1_AVM_MED_i;
		Integer kr_add1_avm_med_i;
		Integer kd_add1_avm_med_i;
		Integer kw_add1_avm_med_i;
		Integer add1_building_area_i;
		Integer nw_add1_building_area_i;
		Integer nr_add1_building_area_i;
		Integer tw_add1_building_area_i;
		Integer tr_add1_building_area_i;
		Integer ko_add1_building_area_i;
		Integer kw_add1_building_area_i;
		Boolean nw_adlperssn_risk;
		Integer to_adlperssn_i;
		Integer tr_adlperssn_i;
		Integer kr_adlperssn_i;
		Integer nw_addrs_per_ssn_risk;
		Integer nr_addrs_per_ssn_i;
		Integer no_addrs_per_ssn_i;
		Integer tw_addrs_per_ssn_i;
		Integer to_addrs_per_ssn_i;
		Integer id_per_addr;
		Integer nw_id_per_addr_risk;
		Integer nr_id_per_addr_i;
		Integer no_id_per_addr_i;
		Integer nd_id_per_addr_i;
		Integer tw_id_per_addr_i;
		Integer to_id_per_addr_i;
		Integer tr_id_per_addr_i;
		Integer td_id_per_addr_i;
		Integer ko_id_per_addr_i;
		Integer kr_id_per_addr_i;
		Integer kd_id_per_addr_i;
		Integer kw_id_per_addr_i;
		Integer nw_phones_per_addr_risk;
		Integer no_phones_per_addr_i;
		Integer to_phones_per_addr_i;
		Integer ko_phones_per_addr_i;
		Integer id_per_addr_c6;
		Integer nw_id_per_addr_c6_risk;
		Integer nr_id_per_addr_c6_i;
		Integer no_id_per_addr_c6_i;
		Integer tw_id_per_addr_c6_i;
		Integer to_id_per_addr_c6_i;
		Integer tr_id_per_addr_c6_i;
		Integer td_id_per_addr_c6_i;
		Integer ko_id_per_addr_c6_i;
		Integer kr_id_per_addr_c6_i;
		Integer kd_id_per_addr_c6_i;
		Boolean nw_ams_4ycollege;
		Integer nw_ams_i;
		Integer nr_ams_i;
		Integer no_ams_i;
		Integer nd_ams_i;
		Integer tw_ams_i;
		Integer to_ams_i;
		Boolean tr_ams_good;
		Integer td_ams_i;
		Boolean ko_ams_good;
		Integer tw_ams_income_level_i;
		Integer to_ams_income_level_i;
		Integer tr_ams_income_level_i;
		Integer td_ams_income_level_i;
		Integer ko_ams_income_level_i;
		Integer kr_ams_income_level_i;
		Integer kd_ams_income_level_i;
		Integer kw_ams_income_level_i;
		String nw_out_st_region;
		String to_out_st_region;
		String tr_out_st_region;
		Integer no_out_st_region_i;
		Integer ko_out_st_region_i;
		Integer kr_out_st_region_i;
		Boolean nd_out_st_division_risk;
		Integer nw_out_st_i;
		Integer nr_out_st_i;
		Integer no_out_st_i;
		Integer nd_out_st_i;
		Integer tw_out_st_i;
		Integer to_out_st_i;
		Integer tr_out_st_i;
		Boolean td_out_st_good;
		Integer kd_out_st_i;
		Integer kw_out_st_i;
		Integer ko_out_st_i;
		Integer kr_out_st_i;
		Boolean nw_other_risk;
		Boolean nr_other_risk;
		Boolean no_other_risk;
		Boolean tw_other_risk;
		Boolean to_other_risk;
		Boolean tr_other_risk;
		Boolean td_other_risk;
		Boolean ko_other_risk;
		Boolean kr_other_risk;
		Boolean kd_other_risk;
		Integer kd_other_risk_i;
		Boolean kw_other_risk;
		Boolean no_age_risk;
		Boolean nd_age_risk;
		Boolean to_age_risk;
		Integer tr_age_i;
		Integer ko_age_i;
		Integer kr_age_i;
		Integer kd_age_i;
		Integer kw_age_i;
		Integer tw_years_add1_first_seen_i;
		Integer to_months_add1_first_seen_i;
		Integer tr_months_add1_first_seen_i;
		Real ko_months_add1_date_first_seen;
		Integer kd_months_add1_first_seen_i;
		Integer kw_months_credit_first_seen;
		Integer tw_wealth_index;
		Integer kw_wealth_index;
		Integer tw_addr_stability;
		Integer kr_addr_stability;
		Integer kd_addr_stability;
		Integer kw_addr_stability;
		Integer pk_wealth_index;
		Real pk_wealth_index_m;
		Integer wealth_index_cm;
		Boolean add_apt;
		Integer adl_category_ord;
		Integer pk_bk_level;
		Integer rc_valid_bus_phone;
		Integer rc_valid_res_phone;
		Integer age_rcd;
		Integer add1_mortgage_type_ord;
		Real prof_license_category_ord;
		Integer pk_attr_total_number_derogs;
		Integer pk_attr_total_number_derogs_2;
		Integer pk_attr_num_nonderogs90;
		Integer pk_attr_num_nonderogs90_2;
		Integer pk_derog_total;
		Integer pk_derog_total_m;
		Integer add1_avm_automated_valuation_rcd;
		Integer add1_avm_automated_val_2_rcd;
		Integer pk_liens_unrel_ot_total_amount;
		Integer attr_num_watercraft60_cap;
		Integer combo_addrcount_cap;
		Integer gong_did_phone_ct_cap;
		Integer ams_college_code_mis;
		Integer ams_college_code_cm;
		Integer ams_income_level_code_cm;
		Integer unit5;
		Integer pk_dist_a1toa2;
		Integer pk_dist_a1toa3;
		Integer pk_dist_a2toa3;
		Integer pk_rc_disthphoneaddr;
		Real pk_dist_a1toa2_m;
		Real pk_dist_a1toa3_m;
		Real pk_dist_a2toa3_m;
		Real pk_rc_disthphoneaddr_m;
		Real Dist_mod;
		Integer pk_yr_date_last_seen;
		Integer pk_bk_yr_date_last_seen;
		Real pk_bk_yr_date_last_seen_m1;
		Integer pk_yr_liens_unrel_cj_last_seen;
		Integer pk2_yr_liens_unrel_cj_last_seen;
		Real predicted_inc_high;
		Real predicted_inc_low;
		Real pred_inc;
		Integer estimated_income;
		Integer nw_estimated_income_i;
		Integer nr_estimated_income_i;
		Integer nd_estimated_income_i;
		Integer td_estimated_income_i;
		Real ko_estimated_income;
		Integer kr_estimated_income_i;
		Real kd_estimated_income;
		Real nw_nap_i_m;
		Real ko_nap_i_m;
		Real kd_nap_i_m;
		Real no_rc_dirsaddr_lastscore_i_m;
		Real to_rc_dirsaddr_lastscore_i_m;
		Real kw_rc_dirsaddr_lastscore_i_m;
		Real kr_rc_dirsaddr_lastscore_i_m;
		Real nd_naprop_i_m;
		Real tw_naprop_i_m;
		Real td_naprop_i_m;
		Real kd_naprop_i_m;
		Real kw_rc_numelever_i_m;
		Real kd_rc_numelever_i_m;
		Real tw_ams_income_level_i_m;
		Real to_ams_income_level_i_m;
		Real tr_ams_income_level_i_m;
		Real td_ams_income_level_i_m;
		Real kw_ams_income_level_i_m;
		Real kr_ams_income_level_i_m;
		Real ko_ams_income_level_i_m;
		Real kd_ams_income_level_i_m;
		Real nw_ams_i_m;
		Real nr_ams_i_m;
		Real no_ams_i_m;
		Real nd_ams_i_m;
		Real tw_ams_i_m;
		Real to_ams_i_m;
		Real td_ams_i_m;
		Real nw_add1_assessed_value_i_m;
		Real nr_add1_assessed_value_i_m;
		Real tw_add1_assessed_value_i_m;
		Real tr_add1_assessed_value_i_m;
		Real kr_add1_assessed_value_i_m;
		Real nr_add1_avm_med_i_m;
		Real no_add1_avm_med_i_m;
		Real nd_add1_avm_med_i_m;
		Real tw_add1_avm_med_i_m;
		Real to_add1_avm_med_i_m;
		Real tr_add1_avm_med_i_m;
		Real kw_add1_avm_med_i_m;
		Real kr_add1_avm_med_i_m;
		Real ko_add1_avm_med_i_m;
		Real kd_add1_avm_med_i_m;
		Real nw_add1_avm_sales_price_i_m;
		Real nr_add1_avm_sales_price_i_m;
		Real tw_add1_avm_sales_price_i_m;
		Real nw_add1_avm_valuation_i_m;
		Real tw_add1_avm_valuation_i_m;
		Real tr_add1_avm_valuation_i_m;
		Real kw_add1_avm_valuation_i_m;
		Real nw_add1_building_area_i_m;
		Real nr_add1_building_area_i_m;
		Real tw_add1_building_area_i_m;
		Real tr_add1_building_area_i_m;
		Real kw_add1_building_area_i_m;
		Real ko_add1_building_area_i_m;
		Real nw_years_add1_avm_recording_i_m;
		Real nr_years_add1_avm_recording_i_m;
		Real tw_years_add1_avm_recording_i_m;
		Real kw_years_add1_avm_recording_i_m;
		Real nw_years_add1_purchase_date_i_m;
		Real tw_years_add1_purchase_date_i_m;
		Real kw_years_add1_purchase_date_i_m;
		Real nw_addrs_per_ssn_risk_m;
		Real nr_addrs_per_ssn_i_m;
		Real no_addrs_per_ssn_i_m;
		Real tw_addrs_per_ssn_i_m;
		Real to_addrs_per_ssn_i_m;
		Real to_adlperssn_i_m;
		Real tr_adlperssn_i_m;
		Real kr_adlperssn_i_m;
		Real nw_id_per_addr_risk_m;
		Real nr_id_per_addr_i_m;
		Real no_id_per_addr_i_m;
		Real nd_id_per_addr_i_m;
		Real tw_id_per_addr_i_m;
		Real to_id_per_addr_i_m;
		Real tr_id_per_addr_i_m;
		Real td_id_per_addr_i_m;
		Real kw_id_per_addr_i_m;
		Real kr_id_per_addr_i_m;
		Real ko_id_per_addr_i_m;
		Real kd_id_per_addr_i_m;
		Real nw_id_per_addr_c6_risk_m;
		Real nr_id_per_addr_c6_i_m;
		Real no_id_per_addr_c6_i_m;
		Real tw_id_per_addr_c6_i_m;
		Real to_id_per_addr_c6_i_m;
		Real tr_id_per_addr_c6_i_m;
		Real td_id_per_addr_c6_i_m;
		Real kr_id_per_addr_c6_i_m;
		Real ko_id_per_addr_c6_i_m;
		Real kd_id_per_addr_c6_i_m;
		Real nw_phones_per_addr_risk_m;
		Real no_phones_per_addr_i_m;
		Real to_phones_per_addr_i_m;
		Real ko_phones_per_addr_i_m;
		Real tw_years_add1_first_seen_i_m;
		Real to_months_add1_first_seen_i_m;
		Real tr_months_add1_first_seen_i_m;
		Real kd_months_add1_first_seen_i_m;
		Real tw_addr_stability_m;
		Real kw_addr_stability_m;
		Real kr_addr_stability_m;
		Real kd_addr_stability_m;
		Real tr_age_i_m;
		Real kw_age_i_m;
		Real kr_age_i_m;
		Real ko_age_i_m;
		Real kd_age_i_m;
		Real kw_months_credit_first_seen_m;
		Real nw_estimated_income_i_m;
		Real nr_estimated_income_i_m;
		Real nd_estimated_income_i_m;
		Real td_estimated_income_i_m;
		Real kr_estimated_income_i_m;
		Real kd_other_risk_i_m;
		Real nw_out_st_region_m;
		Real nw_out_st_i_m;
		Real nr_out_st_i_m;
		Real no_out_st_region_i_m;
		Real no_out_st_i_m;
		Real nd_out_st_i_m;
		Real tw_out_st_i_m;
		Real tw_wealth_index_m;
		Real to_out_st_region_m;
		Real to_out_st_i_m;
		Real tr_out_st_region_m;
		Real tr_out_st_i_m;
		Real kw_out_st_i_m;
		Real kw_wealth_index_m;
		Real kr_out_st_region_i_m;
		Real kr_out_st_i_m;
		Real ko_out_st_region_i_m;
		Real ko_out_st_i_m;
		Real kd_out_st_i_m;
		Real logit;
		Real phat;
		Integer thick_renter01_score;
		Integer thick_derog03_score;
		Integer thin_derog01_score;
		Integer thick_owner01_score;
		Integer nohit_derog01d_score;
		Integer nohit_owner05d_score;
		Integer nohit_renter02d_score;
		Integer thin_owner03_score;
		Integer thick_other04_score;
		Integer nohit_other06d_score;
		Integer thin_other03_score;
		Integer thin_renter03_score;
		Integer RVP1003_raw;
		Boolean uv_rv20_content;
		Boolean uv_gong_sourced;
		Boolean uv_EQ_only;
		Boolean uv_RVP1003_content;
		Integer rvp1003;
		Boolean ov_ssndead;
		Boolean ov_ssnprior;
		Boolean ov_criminal_flag;
		Boolean ov_corrections;
		Boolean ov_impulse;
		Integer rvp1003_cap;
	end;
	
	layout_debug doModel( clam le ) := TRANSFORM
	#else
	Models.Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end
	
		
		truedid                          := le.truedid;
		adl_category                     := le.adlcategory;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_st                           := le.shell_input.st;
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		did_count                        := le.iid.didcount;
		rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
		rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_hriskaddrflag                 := le.iid.hriskaddrflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_ssnstate                      := le.iid.soclstate;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_numelever                     := le.iid.numelever;
		rc_phoneaddr_lnamecount          := le.iid.phoneaddr_lastcount;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_ziptypeflag                   := le.iid.ziptypeflag;
		rc_statezipflag                  := le.iid.statezipflag;
		rc_altlname1_flag                := le.iid.altlastpop;
		rc_altlname2_flag                := le.iid.altlast2pop;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_addrcount                  := le.iid.combo_addrcount;
		rc_watchlist_flag                := le.iid.watchlisthit;
		ssnlength                        := le.input_validation.ssn_length;
		hphnpop                          := le.input_validation.homephone;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		age                              := le.name_verification.age;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_recording_date          := le.avm.input_address_information.avm_recording_date;
		add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_purchase_date               := le.address_verification.input_address_information.purchase_date;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_building_area               := (string)le.address_verification.input_address_information.building_area;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		credit_first_seen                := le.ssn_verification.credit_first_seen;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		attr_num_watercraft60            := le.watercraft.watercraft_count60;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_college_code                 := le.student.college_code;
		ams_income_level_code            := le.student.income_level_code;
		ams_file_type                    := le.student.file_type;
		prof_license_flag                := le.professional_license.professional_license_flag;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := le.dobmatchlevel;
		addr_stability                   := le.mobility_indicator;
		// archive_date                     := if(le.historydate=999999, ut.getdate[1..6], (string6)le.historydate);
		archive_date                     := le.historydate;



















		NULL := -999999999;


		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(common.readDate(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'))),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																			   NULL);

		sysyear :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => year(common.sas_date(common.readDate(if(le.historydate=999999, ut.getdate, (string6)le.historydate+'01')))),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (real)(trim((string)archive_date, LEFT))[1..4],
																			   NULL);

		in_dob2 := common.sas_date(common.readDate(in_dob));

		years_in_dob := if(NULL in [sysdate,in_dob2], NULL, (sysdate - in_dob2) / 365.25);

		months_in_dob := if(NULL in [sysdate,in_dob2], NULL, (sysdate - in_dob2) / 30.5);

		add1_avm_recording_date2 := common.sas_date(common.readDate(add1_avm_recording_date));

		years_add1_avm_recording_date := if(NULL in [sysdate,add1_avm_recording_date2], NULL, (sysdate - add1_avm_recording_date2) / 365.25);

		months_add1_avm_recording_date := if(NULL in [sysdate,add1_avm_recording_date2], NULL, (sysdate - add1_avm_recording_date2) / 30.5);

		add1_purchase_date2 := common.sas_date(common.readDate((string)add1_purchase_date));

		years_add1_purchase_date := if(NULL in [sysdate,add1_purchase_date2], NULL, (sysdate - add1_purchase_date2) / 365.25);

		months_add1_purchase_date := if(NULL in [sysdate,add1_purchase_date2], NULL, (sysdate - add1_purchase_date2) / 30.5);

		add1_date_first_seen2 := common.sas_date(common.readDate((string)add1_date_first_seen));

		years_add1_date_first_seen := if(NULL in [sysdate,add1_date_first_seen2], NULL, (sysdate - add1_date_first_seen2) / 365.25);

		months_add1_date_first_seen := if(NULL in [sysdate,add1_date_first_seen2], NULL, (sysdate - add1_date_first_seen2) / 30.5);

		credit_first_seen2 := common.sas_date(common.readDate((string)credit_first_seen));

		years_credit_first_seen := if(NULL in [sysdate,credit_first_seen2], NULL, (sysdate - credit_first_seen2) / 365.25);

		months_credit_first_seen := if(NULL in [sysdate,credit_first_seen2], NULL, (sysdate - credit_first_seen2) / 30.5);

		date_last_seen2 := common.sas_date(common.readDate((string)date_last_seen));

		years_date_last_seen := if(NULL in [sysdate,date_last_seen2], NULL, (sysdate - date_last_seen2) / 365.25);

		months_date_last_seen := if(NULL in [sysdate,date_last_seen2], NULL, (sysdate - date_last_seen2) / 30.5);

		infutor_first_seen2 := common.sas_date(common.readDate((string)infutor_first_seen));

		years_infutor_first_seen := if(NULL in [sysdate,infutor_first_seen2], NULL, (sysdate - infutor_first_seen2) / 365.25);

		months_infutor_first_seen := if(NULL in [sysdate,infutor_first_seen2], NULL, (sysdate - infutor_first_seen2) / 30.5);

		liens_unrel_cj_last_seen2 := common.sas_date(common.readDate((string)liens_unrel_cj_last_seen));

		years_liens_unrel_cj_last_seen := if(NULL in [sysdate,liens_unrel_cj_last_seen2], NULL, (sysdate - liens_unrel_cj_last_seen2) / 365.25);

		months_liens_unrel_cj_last_seen := if(NULL in [sysdate,liens_unrel_cj_last_seen2], NULL, (sysdate - liens_unrel_cj_last_seen2) / 30.5);

		Common.findw(rc_sources, 'AK', ' ,', 'I', source_tot_AK, 'bool'); // source_tot_AK := 
		Common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool'); // source_tot_AM := 
		Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool'); // source_tot_BA := 
		Common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool'); // source_tot_CG := 
		Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool'); // source_tot_DA := 
		Common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool'); // source_tot_DS := 
		Common.findw(rc_sources, 'EB', ' ,', 'I', source_tot_EB, 'bool'); // source_tot_EB := 
		Common.findw(rc_sources, 'EM', ' ,', 'I', source_tot_EM, 'bool'); // source_tot_EM := 
		Common.findw(rc_sources, 'EQ', ' ,', 'I', source_tot_EQ, 'bool'); // source_tot_EQ := 
		Common.findw(rc_sources, 'VO', ' ,', 'I', source_tot_VO, 'bool'); // source_tot_VO := 
		Common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool'); // source_tot_L2 := 
		Common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool'); // source_tot_LI := 
		Common.findw(rc_sources, 'P',  ' ,', 'I', source_tot_P,  'bool'); // source_tot_P  := 
		Common.findw(rc_sources, 'PL', ' ,', 'I', source_tot_PL, 'bool'); // source_tot_PL := 
		Common.findw(rc_sources, 'SL', ' ,', 'I', source_tot_SL, 'bool'); // source_tot_SL := 
		Common.findw(rc_sources, 'V',  ' ,', 'I', source_tot_V,  'bool'); // source_tot_V  := 
		Common.findw(rc_sources, 'W',  ' ,', 'I', source_tot_W,  'bool'); // source_tot_W  := 

		source_tot_voter := (source_tot_EM or source_tot_VO);

		// # warning:  engineer intervention needed -- function countw not implemented
		source_tot_total := common.countw(rc_sources, ' ,');

		out_st_region :=  map(out_st in ['IL', 'IN', 'MI', 'OH', 'WI', 'IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD']                               => '1-Midwest',
							  out_st in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT']                                                 => '2-Northeast',
							  out_st in ['AL', 'KY', 'MS', 'TN', 'DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV', 'AR', 'LA', 'OK', 'TX'] => '3-South',
							  out_st in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY', 'AK', 'CA', 'HI', 'OR', 'WA']                         => '4-West',
							  out_st in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI']                                                       => '5-Island',
							  out_st in ['AA', 'AE', 'AP']                                                                                     => '6-Armed Forces',
																																				  'other');

		out_st_division :=  map(out_st in ['IL', 'IN', 'MI', 'OH', 'WI']                         => '1-East North Central',
								out_st in ['IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD']             => '2-West North Central',
								out_st in ['NJ', 'NY', 'PA']                                     => '3-Middle Atlantic',
								out_st in ['CT', 'MA', 'ME', 'NH', 'RI', 'VT']                   => '4-New England',
								out_st in ['AL', 'KY', 'MS', 'TN']                               => '5-East South Central',
								out_st in ['DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV'] => '6-South Atlantic',
								out_st in ['AR', 'LA', 'OK', 'TX']                               => '7-West South Central',
								out_st in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY']       => '8-Mountain',
								out_st in ['AK', 'CA', 'HI', 'OR', 'WA']                         => '9-Pacific',
								out_st in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI']       => 'x-Island',
								out_st in ['AA', 'AE', 'AP']                                     => 'x-Armed Forces',
																									'other');

		out_st_i :=  map(out_st = 'AK' => 1,
						 out_st = 'AL' => 2,
						 out_st = 'AR' => 1,
						 out_st = 'AZ' => 4,
						 out_st = 'CA' => 2,
						 out_st = 'CO' => 2,
						 out_st = 'CT' => 2,
						 out_st = 'DC' => 2,
						 out_st = 'DE' => 2,
						 out_st = 'FL' => 3,
						 out_st = 'GA' => 3,
						 out_st = 'HI' => 2,
						 out_st = 'IA' => 1,
						 out_st = 'ID' => 1,
						 out_st = 'IL' => 2,
						 out_st = 'IN' => 3,
						 out_st = 'KS' => 1,
						 out_st = 'KY' => 2,
						 out_st = 'LA' => 3,
						 out_st = 'MA' => 3,
						 out_st = 'MD' => 3,
						 out_st = 'ME' => 1,
						 out_st = 'MI' => 4,
						 out_st = 'MN' => 1,
						 out_st = 'MO' => 3,
						 out_st = 'MS' => 3,
						 out_st = 'MT' => 1,
						 out_st = 'NC' => 2,
						 out_st = 'ND' => 1,
						 out_st = 'NE' => 2,
						 out_st = 'NH' => 2,
						 out_st = 'NJ' => 3,
						 out_st = 'NM' => 3,
						 out_st = 'NV' => 4,
						 out_st = 'NY' => 3,
						 out_st = 'OH' => 3,
						 out_st = 'OK' => 2,
						 out_st = 'OR' => 2,
						 out_st = 'PA' => 3,
						 out_st = 'RI' => 2,
						 out_st = 'SC' => 3,
						 out_st = 'SD' => 3,
						 out_st = 'TN' => 3,
						 out_st = 'TX' => 3,
						 out_st = 'UT' => 1,
						 out_st = 'VA' => 2,
						 out_st = 'VT' => 1,
						 out_st = 'WA' => 3,
						 out_st = 'WI' => 1,
						 out_st = 'WV' => 1,
						 out_st = 'WY' => 1,
										  3);

		ssnst_region :=  map(rc_ssnstate in ['IL', 'IN', 'MI', 'OH', 'WI', 'IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD']                               => '1-Midwest',
							 rc_ssnstate in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT']                                                 => '2-Northeast',
							 rc_ssnstate in ['AL', 'KY', 'MS', 'TN', 'DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV', 'AR', 'LA', 'OK', 'TX'] => '3-South',
							 rc_ssnstate in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY', 'AK', 'CA', 'HI', 'OR', 'WA']                         => '4-West',
							 rc_ssnstate in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI']                                                       => '5-Island',
							 rc_ssnstate in ['AA', 'AE', 'AP']                                                                                     => '6-Armed Forces',
																																					  'other');

		uv_filetype :=  map(months_credit_first_seen <= 0  => '1-nohit',
							months_credit_first_seen <= 18 => '2-thin',
																	   '3-thick');

		dy_prop_ownership :=  map((uv_filetype = '3-thick') and ((add1_naprop = 4) or (property_owned_total > 0))                                                                  => 'owner',
								  (uv_filetype != '3-thick') and ((add1_naprop >= 3) or (property_owned_total > 0))                                                                => 'owner',
								  (trim(StringLib.StringToUpperCase(out_addr_type), LEFT, RIGHT) = 'H') or ((add1_naprop = 1) or ((add1_unit_count > 3) or (phones_per_addr > 2))) => 'renter',
																																													  'other');

		Adl_deceased := (adl_category = '1 DEAD');

		rc_deceased := ((integer)rc_decsflag = 1);


		combine_deceased_flag := (Adl_deceased or (rc_deceased or source_tot_DS));

		bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);

		lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);

		combine_lien_flag := (source_tot_L2 or (source_tot_LI or (lien_rec_unrel_flag or lien_hist_unrel_flag)));

		attr_total_derog_flag := (attr_total_number_derogs > 0);

		attr_eviction_flag := (attr_eviction_count > 0);

		criminal_flag := (criminal_count > 0);

		felony_flag := (felony_count > 0);

		impulse_flag := (impulse_count > 0);

		combine_derog_flag := (combine_deceased_flag or (bk_flag or (combine_lien_flag or (attr_total_derog_flag or (attr_eviction_flag or (criminal_flag or felony_flag))))));

		uv_dy_segment :=  map((integer)combine_derog_flag = 1 => 'derog',
							  dy_prop_ownership = 'owner'     => 'owner',
							  dy_prop_ownership = 'renter'    => 'renter',
																'other');
		
		uv_dy_segment2_b1 := map(uv_dy_segment = 'derog'  => '1d-nohit-derog',
								 uv_dy_segment = 'owner'  => '1a-nohit-owner',
								 uv_dy_segment = 'renter' => '1c-nohit-renter',
															 '1b-nohit-other');

		uv_dy_segment2_b2 := map(uv_dy_segment = 'derog'  => '2d-thin-derog',
								 uv_dy_segment = 'owner'  => '2a-thin-owner',
								 uv_dy_segment = 'renter' => '2c-thin-renter',
															 '2b-thin-other');

		uv_dy_segment2_b3 := map(uv_dy_segment = 'derog'  => '3d-thick-derog',
								 uv_dy_segment = 'owner'  => '3a-thick-owner',
								 uv_dy_segment = 'renter' => '3c-thick-renter',
															 '3b-thick-other');

		uv_dy_segment2 := map(uv_filetype = '1-nohit' => uv_dy_segment2_b1,
							  uv_filetype = '2-thin'  => uv_dy_segment2_b2,
														 uv_dy_segment2_b3);

		nw_nap_i :=  map(nap_summary in [11, 12]                      => 1,
						 (nap_summary = 0) and ((integer)hphnpop = 0) => 3,
						 (nap_summary = 0) and ((integer)hphnpop = 1) => 4,
						 nap_summary = 1                              => 4,
																		 2);

		nd_nap_i :=  map(nap_summary in [11, 12] => 1,
						 nap_summary in [0, 1]   => 3,
													2);

		ko_nap_i := nd_nap_i;

		kd_nap_i := nd_nap_i;

		kw_nap_good := ((nap_summary in [11, 12]) and (infutor_nap = 0));

		kd_rc_numelever_i := min(6, if(max(4, rc_numelever) = NULL, -NULL, max(4, rc_numelever)));

		kw_rc_numelever_i := min(6, if(max(2, rc_numelever) = NULL, -NULL, max(2, rc_numelever)));

		rc_phoneaddr_lname_flag := (rc_phoneaddr_lnamecount > 0);

		watercraft_flag := (watercraft_count > 0);

		nw_minor_pos_source_f := max((integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_W, (integer)(integer)watercraft_flag, (integer)(integer)prof_license_flag);

		nr_minor_pos_source_f := max((integer)source_tot_AK, (integer)(integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_P, (integer)(integer)source_tot_W, (integer)(integer)watercraft_flag, (integer)(integer)source_tot_PL, (integer)(integer)prof_license_flag);

		tw_minor_pos_source_f := max((integer)source_tot_AK, (integer)(integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_P, (integer)(integer)source_tot_W, (integer)(integer)watercraft_flag, (integer)(integer)source_tot_PL, (integer)(integer)prof_license_flag);

		to_minor_pos_source_f := max((integer)source_tot_AK, (integer)(integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_P, (integer)(integer)source_tot_W, (integer)(integer)watercraft_flag, (integer)(integer)source_tot_PL, (integer)(integer)prof_license_flag);

		tr_minor_pos_source_f := max((integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_P, (integer)(integer)watercraft_flag, (integer)(integer)source_tot_PL, (integer)(integer)prof_license_flag);

		ko_minor_pos_source_f := max((integer)source_tot_AK, (integer)(integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_P, (integer)(integer)source_tot_W, (integer)(integer)watercraft_flag, (integer)(integer)source_tot_PL, (integer)(integer)prof_license_flag);

		kr_minor_pos_source_f := ko_minor_pos_source_f;

		kd_minor_pos_source_f := max((integer)source_tot_AK, (integer)(integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_P, (integer)(integer)source_tot_W, (integer)(integer)watercraft_flag, (integer)(integer)prof_license_flag);

		kw_minor_pos_source_f := max((integer)source_tot_AM, (integer)(integer)source_tot_EB, (integer)(integer)source_tot_W, (integer)(integer)watercraft_flag, (integer)(integer)source_tot_PL, (integer)(integer)prof_license_flag);

		nd_naprop_i :=  map(add1_naprop = 4 => 1,
							add1_naprop = 3 => 2,
											   3);

		tw_naprop_i :=  map(add1_naprop = 4 => 1,
							add1_naprop = 3 => 1,
							add1_naprop = 0 => 2,
											   3);

		td_naprop_i :=  map(add1_naprop = 4 => 1,
							add1_naprop = 3 => 2,
							add1_naprop = 2 => 3,
							add1_naprop = 0 => 3,
											   4);

		kd_naprop_i :=  map(add1_naprop = 4 => 1,
							add1_naprop = 3 => 2,
							add1_naprop = 2 => 3,
							add1_naprop = 0 => 3,
											   4);

		kw_add1_naprop_good := (add1_naprop = 4);

		no_rc_dirsaddr_lastscore_i :=  map(rc_dirsaddr_lastscore = 100 => 1,
										   rc_dirsaddr_lastscore = 255 => 2,
																		  3);

		to_rc_dirsaddr_lastscore_i := no_rc_dirsaddr_lastscore_i;

		kr_rc_dirsaddr_lastscore_i := no_rc_dirsaddr_lastscore_i;

		kw_rc_dirsaddr_lastscore_i := no_rc_dirsaddr_lastscore_i;

		tr_rc_dirsaddr_lastscore_i :=  map(rc_dirsaddr_lastscore = 100 => 0,
										   rc_dirsaddr_lastscore = 255 => 0,
																		  1);

		phn_notpots := (hphnpop and not((telcordia_type in ['00', '50', '51', '52', '54'])));

		nr_phone_notpots := (((integer)phn_notpots = 1) or (((integer)rc_hphonevalflag = 4) or (rc_hriskphoneflag in ['1', '2', '3'])));
		// nr_phone_notpots := ( (integer)phn_notpots=1 or (integer)rc_hphonevalflag = 4  or (integer)rc_hriskphoneflag in [1,2,3] );

		tw_phone_risk := (((integer)phn_notpots = 1) or ((rc_hphonevalflag in ['1', '3', '4', '5']) or ((rc_hriskphoneflag in ['1', '2', '3', '4', '5', '6']) or ((integer)rc_phonezipflag = 1))));

		to_phone_risk := (((integer)phn_notpots = 1) or ((rc_hphonevalflag in ['1', '3', '4', '5']) or ((rc_hriskphoneflag in ['1', '2', '3', '4', '5', '6']) or ((integer)rc_phonezipflag = 1))));

		nw_years_add1_purchase_date_i :=  map(years_add1_purchase_date = NULL         => -1,
											  years_add1_purchase_date <= 3  => 4,
											  years_add1_purchase_date <= 10 => 3,
											  years_add1_purchase_date <= 20 => 2,
																						 1);

		tw_years_add1_purchase_date_i :=  map(years_add1_purchase_date = NULL         => -1,
											  years_add1_purchase_date <= 2  => 4,
											  years_add1_purchase_date <= 10 => 3,
											  years_add1_purchase_date <= 20 => 2,
											  years_add1_purchase_date <= 30 => 1,
																						 -2);

		kw_years_add1_purchase_date_i :=  map(years_add1_purchase_date = NULL         => -1,
											  years_add1_purchase_date <= 0.5         => 8,
											  years_add1_purchase_date <= 1.5         => 7,
											  years_add1_purchase_date <= 2  => 6,
											  years_add1_purchase_date <= 2.5         => 5,
											  years_add1_purchase_date <= 8  => 4,
											  years_add1_purchase_date <= 10 => 3,
											  years_add1_purchase_date <= 20 => 2,
																						 1);

		avm_hit := ((integer)add1_avm_land_use > 0);

		nw_years_add1_avm_recording_i :=  map((integer)avm_hit = 0                         => -2,
											  years_add1_avm_recording_date = NULL         => -1,
											  years_add1_avm_recording_date <= 2  => 5,
											  years_add1_avm_recording_date <= 3  => 4,
											  years_add1_avm_recording_date <= 5  => 3,
											  years_add1_avm_recording_date <= 10 => 2,
																							  1);

		nr_years_add1_avm_recording_i :=  map((integer)avm_hit = 0                         => -2,
											  years_add1_avm_recording_date = NULL         => -1,
											  years_add1_avm_recording_date <= 2  => 5,
											  years_add1_avm_recording_date <= 3  => 4,
											  years_add1_avm_recording_date <= 5  => 3,
											  years_add1_avm_recording_date <= 10 => 2,
											  years_add1_avm_recording_date <= 20 => 1,
																							  -3);

		tw_years_add1_avm_recording_i := nw_years_add1_avm_recording_i;

		kw_years_add1_avm_recording_i :=  map((integer)avm_hit = 0                         => -2,
											  years_add1_avm_recording_date = NULL         => -1,
											  years_add1_avm_recording_date <= 2  => 6,
											  years_add1_avm_recording_date <= 2.5         => 5,
											  years_add1_avm_recording_date <= 3  => 4,
											  years_add1_avm_recording_date <= 10 => 3,
											  years_add1_avm_recording_date <= 20 => 2,
																							  1);

		add1_avm_med :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
													   add1_avm_med_fips);

		add1_avm_sales_price_i :=  map(trim(add1_avm_sales_price) = '' => -2,
									   (integer)add1_avm_sales_price = 0 => -1,
										min(1000000, 20000*(roundup((real)add1_avm_sales_price/20000))));

		add1_avm_assessed_value_i :=  map(trim(add1_avm_assessed_total_value) = '' => -2,
										  (integer)add1_avm_assessed_total_value = 0 => -1,
																						min(1000000, if((20000 * if (((real)add1_avm_assessed_total_value / 20000) >= 0, roundup(((real)add1_avm_assessed_total_value / 20000)), truncate(((real)add1_avm_assessed_total_value / 20000)))) = NULL, -NULL, (20000 * if (((real)add1_avm_assessed_total_value / 20000) >= 0, roundup(((real)add1_avm_assessed_total_value / 20000)), truncate(((real)add1_avm_assessed_total_value / 20000)))))));

		add1_avm_market_value_i :=  map(trim(add1_avm_market_total_value) = '' => -2,
										(integer)add1_avm_market_total_value = 0 => -1,
																					min(1000000, if((20000 * if (((real)add1_avm_market_total_value / 20000) >= 0, roundup(((real)add1_avm_market_total_value / 20000)), truncate(((real)add1_avm_market_total_value / 20000)))) = NULL, -NULL, (20000 * if (((real)add1_avm_market_total_value / 20000) >= 0, roundup(((real)add1_avm_market_total_value / 20000)), truncate(((real)add1_avm_market_total_value / 20000)))))));

		add1_avm_valuation_i :=  map((real)add1_avm_automated_valuation = NULL => -2,
									 add1_avm_automated_valuation = 0          => -1,
																				  min(1000000, if((20000 * if ((add1_avm_automated_valuation / 20000) >= 0, roundup((add1_avm_automated_valuation / 20000)), truncate((add1_avm_automated_valuation / 20000)))) = NULL, -NULL, (20000 * if ((add1_avm_automated_valuation / 20000) >= 0, roundup((add1_avm_automated_valuation / 20000)), truncate((add1_avm_automated_valuation / 20000)))))));

		add1_avm_med_i :=  map((real)add1_avm_med = NULL => -2,
							   add1_avm_med = 0          => -1,
															min(1000000, if((20000 * if ((add1_avm_med / 20000) >= 0, roundup((add1_avm_med / 20000)), truncate((add1_avm_med / 20000)))) = NULL, -NULL, (20000 * if ((add1_avm_med / 20000) >= 0, roundup((add1_avm_med / 20000)), truncate((add1_avm_med / 20000)))))));

		add1_assessed_amount_i :=  map((real)add1_assessed_amount = NULL => -2,
									   add1_assessed_amount = 0          => -1,
																			min(1000000, if((20000 * if ((add1_assessed_amount / 20000) >= 0, roundup((add1_assessed_amount / 20000)), truncate((add1_assessed_amount / 20000)))) = NULL, -NULL, (20000 * if ((add1_assessed_amount / 20000) >= 0, roundup((add1_assessed_amount / 20000)), truncate((add1_assessed_amount / 20000)))))));

		add1_combine_assessed_value_i :=  if(add1_assessed_amount_i < 0, add1_avm_assessed_value_i, add1_assessed_amount_i);

		nw_add1_avm_sales_price_i :=  map(add1_avm_sales_price_i = -2      => -2,
										  add1_avm_sales_price_i <= 80000  => 80000,
										  add1_avm_sales_price_i <= 100000 => 100000,
										  add1_avm_sales_price_i <= 140000 => 140000,
										  add1_avm_sales_price_i <= 180000 => 180000,
										  add1_avm_sales_price_i <= 300000 => 300000,
																			  300001);

		nr_add1_avm_sales_price_i :=  map(add1_avm_sales_price_i = -2      => -2,
										  add1_avm_sales_price_i <= 20000  => 20000,
										  add1_avm_sales_price_i <= 40000  => 40000,
										  add1_avm_sales_price_i <= 60000  => 60000,
										  add1_avm_sales_price_i <= 100000 => 100000,
										  add1_avm_sales_price_i <= 120000 => 120000,
										  add1_avm_sales_price_i <= 160000 => 160000,
										  add1_avm_sales_price_i <= 220000 => 220000,
										  add1_avm_sales_price_i <= 300000 => 300000,
																			  300001);

		tw_add1_avm_sales_price_i :=  map(add1_avm_sales_price_i = -2      => -2,
										  add1_avm_sales_price_i <= 100000 => 100000,
										  add1_avm_sales_price_i <= 120000 => 120000,
										  add1_avm_sales_price_i <= 160000 => 160000,
										  add1_avm_sales_price_i <= 260000 => 260000,
																			  260001);

		nw_add1_assessed_value_i :=  map(add1_combine_assessed_value_i < 0       => -1,
										 add1_combine_assessed_value_i <= 20000  => 20000,
										 add1_combine_assessed_value_i <= 60000  => 60000,
										 add1_combine_assessed_value_i <= 120000 => 120000,
										 add1_combine_assessed_value_i <= 160000 => 160000,
										 add1_combine_assessed_value_i <= 200000 => 200000,
										 add1_combine_assessed_value_i <= 240000 => 240000,
										 add1_combine_assessed_value_i <= 300000 => 300000,
										 add1_combine_assessed_value_i <= 400000 => 400000,
										 add1_combine_assessed_value_i <= 500000 => 500000,
																					500001);

		tr_add1_assessed_value_i := nw_add1_assessed_value_i;

		nr_add1_assessed_value_i :=  map(add1_combine_assessed_value_i < 0       => -1,
										 add1_combine_assessed_value_i <= 60000  => 60000,
										 add1_combine_assessed_value_i <= 100000 => 100000,
										 add1_combine_assessed_value_i <= 140000 => 140000,
										 add1_combine_assessed_value_i <= 160000 => 160000,
										 add1_combine_assessed_value_i <= 200000 => 200000,
										 add1_combine_assessed_value_i <= 240000 => 240000,
										 add1_combine_assessed_value_i <= 500000 => 500000,
																					500001);

		tw_add1_assessed_value_i :=  map(add1_combine_assessed_value_i < 0       => -1,
										 add1_combine_assessed_value_i <= 60000  => 60000,
										 add1_combine_assessed_value_i <= 80000  => 80000,
										 add1_combine_assessed_value_i <= 100000 => 100000,
										 add1_combine_assessed_value_i <= 120000 => 120000,
										 add1_combine_assessed_value_i <= 200000 => 200000,
										 add1_combine_assessed_value_i <= 300000 => 300000,
										 add1_combine_assessed_value_i <= 400000 => 400000,
										 add1_combine_assessed_value_i <= 500000 => 500000,
																					500001);

		kr_add1_assessed_value_i :=  map(add1_combine_assessed_value_i < 0       => -1,
										 add1_combine_assessed_value_i <= 20000  => 20000,
										 add1_combine_assessed_value_i <= 60000  => 60000,
										 add1_combine_assessed_value_i <= 120000 => 120000,
										 add1_combine_assessed_value_i <= 240000 => 240000,
										 add1_combine_assessed_value_i <= 400000 => 400000,
										 add1_combine_assessed_value_i <= 500000 => 500000,
																					500001);

		nw_add1_avm_valuation_i :=  map(add1_avm_valuation_i < 0       => -1,
										add1_avm_valuation_i <= 40000  => 40000,
										add1_avm_valuation_i <= 60000  => 60000,
										add1_avm_valuation_i <= 80000  => 80000,
										add1_avm_valuation_i <= 100000 => 100000,
										add1_avm_valuation_i <= 120000 => 120000,
										add1_avm_valuation_i <= 180000 => 180000,
										add1_avm_valuation_i <= 260000 => 260000,
										add1_avm_valuation_i <= 500000 => 500000,
																		  500001);

		tw_add1_avm_valuation_i :=  map(add1_avm_valuation_i < 0       => -1,
										add1_avm_valuation_i <= 20000  => 20000,
										add1_avm_valuation_i <= 40000  => 40000,
										add1_avm_valuation_i <= 60000  => 60000,
										add1_avm_valuation_i <= 80000  => 80000,
										add1_avm_valuation_i <= 100000 => 100000,
										add1_avm_valuation_i <= 120000 => 120000,
										add1_avm_valuation_i <= 140000 => 140000,
										add1_avm_valuation_i <= 260000 => 260000,
										add1_avm_valuation_i <= 500000 => 500000,
										add1_avm_valuation_i <= 600000 => 600000,
																		  600001);

		tr_add1_avm_valuation_i :=  map(add1_avm_valuation_i < 0       => -1,
										add1_avm_valuation_i <= 40000  => 40000,
										add1_avm_valuation_i <= 60000  => 60000,
										add1_avm_valuation_i <= 80000  => 80000,
										add1_avm_valuation_i <= 100000 => 100000,
										add1_avm_valuation_i <= 120000 => 120000,
										add1_avm_valuation_i <= 140000 => 140000,
										add1_avm_valuation_i <= 160000 => 160000,
										add1_avm_valuation_i <= 180000 => 180000,
										add1_avm_valuation_i <= 200000 => 200000,
										add1_avm_valuation_i <= 220000 => 220000,
										add1_avm_valuation_i <= 500000 => 500000,
										add1_avm_valuation_i <= 860000 => 860000,
																		  860001);

		kw_add1_avm_valuation_i :=  map(add1_avm_valuation_i < 0       => -1,
										add1_avm_valuation_i <= 40000  => 40000,
										add1_avm_valuation_i <= 100000 => 100000,
										add1_avm_valuation_i <= 600000 => 600000,
																		  600001);

		nw_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 20000  => 20000,
								  add1_avm_med_i <= 40000  => 40000,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 80000  => 80000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 120000 => 120000,
								  add1_avm_med_i <= 140000 => 140000,
								  add1_avm_med_i <= 300000 => 300000,
								  add1_avm_med_i <= 700000 => 700000,
															  700001);

		nr_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 80000  => 80000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 120000 => 120000,
								  add1_avm_med_i <= 200000 => 200000,
								  add1_avm_med_i <= 280000 => 280000,
								  add1_avm_med_i <= 500000 => 500000,
								  add1_avm_med_i <= 600000 => 600000,
															  600001);

		no_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 40000  => 40000,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 80000  => 80000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 300000 => 300000,
								  add1_avm_med_i <= 500000 => 500000,
															  500001);

		nd_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 200000 => 200000,
															  200001);

		tw_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 20000  => 20000,
								  add1_avm_med_i <= 40000  => 40000,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 80000  => 80000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 120000 => 120000,
								  add1_avm_med_i <= 200000 => 200000,
								  add1_avm_med_i <= 500000 => 500000,
								  add1_avm_med_i <= 640000 => 640000,
															  640001);

		to_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 20000  => 20000,
								  add1_avm_med_i <= 40000  => 40000,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 120000 => 120000,
								  add1_avm_med_i <= 500000 => 500000,
															  500001);

		tr_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 20000  => 20000,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 80000  => 80000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 220000 => 220000,
								  add1_avm_med_i <= 280000 => 280000,
								  add1_avm_med_i <= 500000 => 500000,
								  add1_avm_med_i <= 600000 => 600000,
								  add1_avm_med_i <= 760000 => 760000,
															  760001);

		ko_ADD1_AVM_MED_i := nw_add1_avm_med_i;

		kr_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 20000  => 20000,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 80000  => 80000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 500000 => 500000,
								  add1_avm_med_i <= 600000 => 600000,
								  add1_avm_med_i <= 760000 => 760000,
															  760001);

		kd_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 60000  => 60000,
								  add1_avm_med_i <= 80000  => 80000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 200000 => 200000,
								  add1_avm_med_i <= 280000 => 280000,
								  add1_avm_med_i <= 500000 => 500000,
								  add1_avm_med_i <= 600000 => 600000,
															  600001);

		kw_add1_avm_med_i :=  map(add1_avm_med_i < 0       => -1,
								  add1_avm_med_i <= 20000  => 20000,
								  add1_avm_med_i <= 100000 => 100000,
								  add1_avm_med_i <= 700000 => 700000,
															  700001);

		add1_building_area_i :=  if((integer)add1_building_area <= 0, -1, min(100000, if((1000 * if (((real)add1_building_area / 1000) >= 0, roundup(((real)add1_building_area / 1000)), truncate(((real)add1_building_area / 1000)))) = NULL, -NULL, (1000 * if (((real)add1_building_area / 1000) >= 0, roundup(((real)add1_building_area / 1000)), truncate(((real)add1_building_area / 1000)))))));

		nw_add1_building_area_i :=  map((integer)add1_building_area = 0      => 4,
										(integer)add1_building_area <= 1000  => 5,
										(integer)add1_building_area <= 2000  => 4,
										(integer)add1_building_area <= 3000  => 3,
										(integer)add1_building_area <= 4000  => 2,
										(integer)add1_building_area <= 10000 => 1,
																				4);

		nr_add1_building_area_i :=  map((integer)add1_building_area = 0      => -1,
										(integer)add1_building_area <= 1000  => 4,
										(integer)add1_building_area <= 2000  => 3,
										(integer)add1_building_area <= 3000  => 2,
										(integer)add1_building_area <= 10000 => 1,
																				-1);

		tw_add1_building_area_i :=  map((integer)add1_building_area = 0      => -1,
										(integer)add1_building_area <= 1000  => 6,
										(integer)add1_building_area <= 2000  => 5,
										(integer)add1_building_area <= 3000  => 4,
										(integer)add1_building_area <= 4000  => 3,
										(integer)add1_building_area <= 5000  => 2,
										(integer)add1_building_area <= 10000 => 1,
																				-1);

		tr_add1_building_area_i := nw_add1_building_area_i;

		ko_add1_building_area_i := tw_add1_building_area_i;

		kw_add1_building_area_i :=  map((integer)add1_building_area = 0      => -1,
										(integer)add1_building_area <= 1000  => 4,
										(integer)add1_building_area <= 2000  => 3,
										(integer)add1_building_area <= 10000 => 2,
																				1);

		nw_adlperssn_risk := (adlperssn_count > 1);

		to_adlperssn_i :=  map(adlperssn_count = 0 => 1,
							   adlperssn_count = 1 => 1,
							   adlperssn_count = 2 => 2,
							   adlperssn_count = 3 => 3,
													  4);

		tr_adlperssn_i := to_adlperssn_i;

		kr_adlperssn_i := to_adlperssn_i;

		nw_addrs_per_ssn_risk :=  map(addrs_per_ssn = 1 => 1,
									  addrs_per_ssn = 0 => 2,
									  addrs_per_ssn = 2 => 3,
														   4);

		nr_addrs_per_ssn_i :=  map(addrs_per_ssn = 0  => 1,
								   addrs_per_ssn = 1  => 2,
								   addrs_per_ssn = 2  => 3,
								   addrs_per_ssn = 3  => 4,
								   addrs_per_ssn <= 6 => 5,
														 6);

		no_addrs_per_ssn_i :=  map(addrs_per_ssn = 0 => 1,
								   addrs_per_ssn = 1 => 1,
								   addrs_per_ssn = 2 => 2,
								   addrs_per_ssn = 3 => 3,
								   addrs_per_ssn = 4 => 4,
														5);

		tw_addrs_per_ssn_i :=  map(addrs_per_ssn = 0 => 1,
								   addrs_per_ssn = 1 => 1,
								   addrs_per_ssn = 2 => 2,
								   addrs_per_ssn = 3 => 3,
								   addrs_per_ssn = 4 => 4,
														5);

		to_addrs_per_ssn_i :=  map(addrs_per_ssn = 0  => 1,
								   addrs_per_ssn = 1  => 1,
								   addrs_per_ssn = 2  => 2,
								   addrs_per_ssn = 3  => 3,
								   addrs_per_ssn <= 6 => 4,
														 5);

		id_per_addr := min(20, if(max(adls_per_addr, ssns_per_addr) = NULL, -NULL, max(adls_per_addr, ssns_per_addr)));

		nw_id_per_addr_risk :=  map(id_per_addr = 0          => 9,
									id_per_addr in [3, 4, 5] => 1,
									id_per_addr in [1, 2, 6] => 2,
									id_per_addr <= 7         => 3,
									id_per_addr <= 8         => 4,
									id_per_addr <= 9         => 5,
									id_per_addr <= 10        => 6,
									id_per_addr <= 11        => 7,
									id_per_addr <= 12        => 8,
									id_per_addr <= 16        => 9,
									id_per_addr <= 19        => 10,
																11);

		nr_id_per_addr_i :=  map(id_per_addr = 0   => -1,
								 id_per_addr <= 2  => 5,
								 id_per_addr = 3   => 1,
								 id_per_addr = 4   => 2,
								 id_per_addr = 5   => 3,
								 id_per_addr <= 7  => 4,
								 id_per_addr <= 8  => 5,
								 id_per_addr <= 9  => 6,
								 id_per_addr <= 10 => 7,
								 id_per_addr <= 12 => 8,
								 id_per_addr <= 13 => 9,
								 id_per_addr <= 17 => 10,
													  11);

		no_id_per_addr_i :=  map(id_per_addr = 0   => -1,
								 id_per_addr = 1   => 5,
								 id_per_addr = 2   => 2,
								 id_per_addr <= 4  => 1,
								 id_per_addr <= 6  => 3,
								 id_per_addr <= 7  => 4,
								 id_per_addr <= 8  => 6,
								 id_per_addr <= 10 => 7,
								 id_per_addr <= 11 => 8,
								 id_per_addr <= 12 => 9,
								 id_per_addr <= 14 => 10,
													  11);

		nd_id_per_addr_i :=  map(id_per_addr = 0   => 4,
								 id_per_addr <= 2  => 2,
								 id_per_addr <= 5  => 1,
								 id_per_addr <= 10 => 3,
													  4);

		tw_id_per_addr_i :=  map(id_per_addr = 0   => 5,
								 id_per_addr = 1   => 5,
								 id_per_addr = 2   => 3,
								 id_per_addr <= 4  => 1,
								 id_per_addr <= 6  => 2,
								 id_per_addr <= 7  => 3,
								 id_per_addr <= 8  => 4,
								 id_per_addr <= 10 => 5,
								 id_per_addr <= 11 => 6,
								 id_per_addr <= 12 => 7,
								 id_per_addr <= 16 => 8,
													  9);

		to_id_per_addr_i :=  map(id_per_addr = 0   => 2,
								 id_per_addr = 1   => 5,
								 id_per_addr = 2   => 3,
								 id_per_addr <= 4  => 1,
								 id_per_addr <= 6  => 2,
								 id_per_addr <= 8  => 4,
								 id_per_addr <= 12 => 5,
													  6);

		tr_id_per_addr_i :=  map(id_per_addr = 0   => -1,
								 id_per_addr = 1   => 4,
								 id_per_addr = 2   => 4,
								 id_per_addr = 3   => 2,
								 id_per_addr = 4   => 1,
								 id_per_addr = 5   => 3,
								 id_per_addr = 6   => 5,
								 id_per_addr = 7   => 6,
								 id_per_addr = 8   => 7,
								 id_per_addr <= 11 => 8,
								 id_per_addr <= 14 => 9,
													  10);

		td_id_per_addr_i :=  map(id_per_addr = 0   => 3,
								 id_per_addr = 1   => 4,
								 id_per_addr = 2   => 3,
								 id_per_addr <= 6  => 1,
								 id_per_addr <= 12 => 2,
													  5);

		ko_id_per_addr_i :=  map(id_per_addr = 0   => 4,
								 id_per_addr = 1   => 4,
								 id_per_addr <= 5  => 1,
								 id_per_addr <= 7  => 2,
								 id_per_addr <= 8  => 3,
								 id_per_addr <= 11 => 4,
								 id_per_addr <= 16 => 5,
													  6);

		kr_id_per_addr_i :=  map(id_per_addr = 0   => 2,
								 id_per_addr = 1   => 4,
								 id_per_addr <= 4  => 1,
								 id_per_addr <= 8  => 2,
								 id_per_addr <= 9  => 3,
								 id_per_addr <= 13 => 4,
													  5);

		kd_id_per_addr_i :=  map(id_per_addr = 0   => 5,
								 id_per_addr = 1   => 4,
								 id_per_addr <= 3  => 1,
								 id_per_addr <= 8  => 2,
								 id_per_addr <= 10 => 3,
								 id_per_addr <= 12 => 4,
								 id_per_addr <= 15 => 5,
													  6);

		kw_id_per_addr_i :=  map(id_per_addr = 0   => 5,
								 id_per_addr = 1   => 4,
								 id_per_addr <= 3  => 2,
								 id_per_addr <= 5  => 1,
								 id_per_addr <= 8  => 3,
								 id_per_addr <= 10 => 4,
								 id_per_addr <= 14 => 5,
								 id_per_addr <= 18 => 6,
													  7);

		nw_phones_per_addr_risk :=  map(phones_per_addr = 1 => 1,
										phones_per_addr = 0 => 2,
										phones_per_addr = 2 => 2,
															   3);

		no_phones_per_addr_i :=  map(phones_per_addr = 1 => 1,
									 phones_per_addr = 0 => 2,
															3);

		to_phones_per_addr_i := no_phones_per_addr_i;

		ko_phones_per_addr_i := no_phones_per_addr_i;

		id_per_addr_c6 := min(20, if(max(adls_per_addr_c6, ssns_per_addr_c6) = NULL, -NULL, max(adls_per_addr_c6, ssns_per_addr_c6)));

		nw_id_per_addr_c6_risk :=  map(id_per_addr_c6 = 1 => 1,
									   id_per_addr_c6 = 0 => 2,
									   id_per_addr_c6 = 2 => 2,
									   id_per_addr_c6 = 3 => 3,
															 4);

		nr_id_per_addr_c6_i :=  map(id_per_addr_c6 = 1 => 1,
									id_per_addr_c6 = 0 => 2,
									id_per_addr_c6 = 2 => 2,
									id_per_addr_c6 = 3 => 3,
									id_per_addr_c6 = 4 => 4,
														  5);

		no_id_per_addr_c6_i :=  map(id_per_addr_c6 = 1 => 1,
									id_per_addr_c6 = 0 => 2,
									id_per_addr_c6 = 2 => 3,
									id_per_addr_c6 = 3 => 4,
														  5);

		tw_id_per_addr_c6_i :=  map(id_per_addr_c6 = 0  => 1,
									id_per_addr_c6 = 1  => 2,
									id_per_addr_c6 = 2  => 3,
									id_per_addr_c6 <= 4 => 4,
														   5);

		to_id_per_addr_c6_i :=  map(id_per_addr_c6 = 0 => 1,
									id_per_addr_c6 = 1 => 2,
									id_per_addr_c6 = 2 => 3,
									id_per_addr_c6 = 3 => 4,
									id_per_addr_c6 = 4 => 5,
														  6);

		tr_id_per_addr_c6_i :=  map(id_per_addr_c6 = 0  => 1,
									id_per_addr_c6 = 1  => 2,
									id_per_addr_c6 = 2  => 3,
									id_per_addr_c6 = 3  => 4,
									id_per_addr_c6 = 4  => 5,
									id_per_addr_c6 <= 6 => 6,
														   7);

		td_id_per_addr_c6_i :=  map(id_per_addr_c6 = 0 => 1,
									id_per_addr_c6 = 1 => 2,
									id_per_addr_c6 = 2 => 3,
									id_per_addr_c6 = 3 => 4,
														  5);

		ko_id_per_addr_c6_i := td_id_per_addr_c6_i;

		kr_id_per_addr_c6_i :=  map(id_per_addr_c6 = 0 => 1,
									id_per_addr_c6 = 1 => 2,
									id_per_addr_c6 = 2 => 2,
									id_per_addr_c6 = 3 => 3,
														  4);

		kd_id_per_addr_c6_i := kr_id_per_addr_c6_i;

		nw_ams_4ycollege := ((integer)ams_college_code = 4);

		nw_ams_i :=  map(source_tot_SL and (ams_college_code in ['1', '4']) => 1,
						 source_tot_SL or ((integer)ams_college_code > 0)   => 2,
																			   3);

		nr_ams_i := nw_ams_i;

		no_ams_i :=  map(ams_college_code in ['1', '4']                   => 1,
						 source_tot_SL or ((integer)ams_college_code > 0) => 2,
																			 3);

		nd_ams_i := no_ams_i;

		tw_ams_i := no_ams_i;

		to_ams_i := no_ams_i;

		tr_ams_good := (((integer)source_tot_SL = 1) and (ams_college_code in ['1', '4']));

		td_ams_i := no_ams_i;

		ko_ams_good := (ams_college_code in ['1', '4']);

		tw_ams_income_level_i :=  map(ams_income_level_code = 'A' => 6,
									  ams_income_level_code = 'B' => 9,
									  ams_income_level_code = 'C' => 9,
									  ams_income_level_code = 'D' => 8,
									  ams_income_level_code = 'E' => 7,
									  ams_income_level_code = 'F' => 6,
									  ams_income_level_code = 'G' => 5,
									  ams_income_level_code = 'H' => 4,
									  ams_income_level_code = 'I' => 3,
									  ams_income_level_code = 'J' => 2,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		to_ams_income_level_i :=  map(ams_income_level_code = 'A' => 6,
									  ams_income_level_code = 'B' => 6,
									  ams_income_level_code = 'C' => 5,
									  ams_income_level_code = 'D' => 4,
									  ams_income_level_code = 'E' => 3,
									  ams_income_level_code = 'F' => 3,
									  ams_income_level_code = 'G' => 3,
									  ams_income_level_code = 'H' => 3,
									  ams_income_level_code = 'I' => 3,
									  ams_income_level_code = 'J' => 2,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		tr_ams_income_level_i :=  map(ams_income_level_code = 'A' => 8,
									  ams_income_level_code = 'B' => 8,
									  ams_income_level_code = 'C' => 7,
									  ams_income_level_code = 'D' => 6,
									  ams_income_level_code = 'E' => 5,
									  ams_income_level_code = 'F' => 4,
									  ams_income_level_code = 'G' => 3,
									  ams_income_level_code = 'H' => 2,
									  ams_income_level_code = 'I' => 2,
									  ams_income_level_code = 'J' => 2,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		td_ams_income_level_i :=  map(ams_income_level_code = 'A' => 6,
									  ams_income_level_code = 'B' => 6,
									  ams_income_level_code = 'C' => 5,
									  ams_income_level_code = 'D' => 4,
									  ams_income_level_code = 'E' => 3,
									  ams_income_level_code = 'F' => 3,
									  ams_income_level_code = 'G' => 3,
									  ams_income_level_code = 'H' => 3,
									  ams_income_level_code = 'I' => 3,
									  ams_income_level_code = 'J' => 2,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		ko_ams_income_level_i :=  map(ams_income_level_code = 'A' => 7,
									  ams_income_level_code = 'B' => 7,
									  ams_income_level_code = 'C' => 6,
									  ams_income_level_code = 'D' => 5,
									  ams_income_level_code = 'E' => 5,
									  ams_income_level_code = 'F' => 4,
									  ams_income_level_code = 'G' => 3,
									  ams_income_level_code = 'H' => 2,
									  ams_income_level_code = 'I' => 2,
									  ams_income_level_code = 'J' => 2,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		kr_ams_income_level_i :=  map(ams_income_level_code = 'A' => 6,
									  ams_income_level_code = 'B' => 6,
									  ams_income_level_code = 'C' => 6,
									  ams_income_level_code = 'D' => 5,
									  ams_income_level_code = 'E' => 4,
									  ams_income_level_code = 'F' => 4,
									  ams_income_level_code = 'G' => 3,
									  ams_income_level_code = 'H' => 3,
									  ams_income_level_code = 'I' => 3,
									  ams_income_level_code = 'J' => 2,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		kd_ams_income_level_i :=  map(ams_income_level_code = 'A' => 6,
									  ams_income_level_code = 'B' => 6,
									  ams_income_level_code = 'C' => 5,
									  ams_income_level_code = 'D' => 4,
									  ams_income_level_code = 'E' => 3,
									  ams_income_level_code = 'F' => 2,
									  ams_income_level_code = 'G' => 2,
									  ams_income_level_code = 'H' => 2,
									  ams_income_level_code = 'I' => 1,
									  ams_income_level_code = 'J' => 1,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		kw_ams_income_level_i :=  map(ams_income_level_code = 'A' => 9,
									  ams_income_level_code = 'B' => 9,
									  ams_income_level_code = 'C' => 8,
									  ams_income_level_code = 'D' => 7,
									  ams_income_level_code = 'E' => 6,
									  ams_income_level_code = 'F' => 5,
									  ams_income_level_code = 'G' => 4,
									  ams_income_level_code = 'H' => 3,
									  ams_income_level_code = 'I' => 2,
									  ams_income_level_code = 'J' => 2,
									  ams_income_level_code = 'K' => 1,
																	 -1);

		nw_out_st_region := out_st_region;

		to_out_st_region := out_st_region;

		tr_out_st_region := out_st_region;

		no_out_st_region_i :=  map(out_st_region = '1-Midwest'   => 1,
								   out_st_region = '2-Northeast' => 1,
								   out_st_region = '4-West'      => 2,
																	3);

		ko_out_st_region_i := no_out_st_region_i;

		kr_out_st_region_i := no_out_st_region_i;

		nd_out_st_division_risk := (out_st_division in ['3-Middle Atlantic', '4-New England']);

		nw_out_st_i := min(3, if(out_st_i = NULL, -NULL, out_st_i));

		nr_out_st_i := min(3, if(out_st_i = NULL, -NULL, out_st_i));

		no_out_st_i := min(3, if(out_st_i = NULL, -NULL, out_st_i));

		nd_out_st_i := out_st_i;

		tw_out_st_i :=  map(out_st_i = 1 => 1,
							out_st_i = 2 => 2,
							out_st_i = 3 => 2,
											3);

		to_out_st_i := out_st_i;

		tr_out_st_i := out_st_i;

		td_out_st_good := (out_st_i = 1);

		kd_out_st_i := tw_out_st_i;

		kw_out_st_i := tw_out_st_i;

		ko_out_st_i := out_st_i;

		kr_out_st_i := out_st_i;

		nw_other_risk := ((StringLib.StringToUpperCase(out_addr_type) != 'S') or (((integer)rc_hriskaddrflag > 0) or (((integer)rc_input_addr_not_most_recent = 1) or ((rc_ziptypeflag in ['1', '2', '5']) or (((integer)rc_statezipflag = 1) or (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_decsflag = 1) or (((integer)rc_pwssndobflag = 1) or (((integer)rc_pwssnvalflag = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((did_count != 1) or ((liens_recent_released_count > 0) or ((liens_historical_released_count > 0) or (impulse_count > 0))))))))))))))));

		nr_other_risk := (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_decsflag = 1) or (((integer)rc_pwssnvalflag = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((liens_recent_released_count > 0) or ((liens_historical_released_count > 0) or (impulse_count > 0)))))))));

		no_other_risk := (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_pwssndobflag = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((did_count != 1) or ((liens_recent_released_count > 0) or ((years_infutor_first_seen > 0) or (impulse_count > 0)))))))));

		tw_other_risk := (((integer)rc_hriskaddrflag > 0) or (((integer)rc_input_addr_not_most_recent = 1) or ((rc_ziptypeflag in ['1', '2', '5']) or (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_pwssndobflag = 1) or (((integer)rc_pwssnvalflag = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((liens_recent_released_count > 0) or ((years_infutor_first_seen > 0) or (impulse_count > 0))))))))))));

		to_other_risk := (((integer)rc_input_addr_not_most_recent = 1) or (((integer)rc_altlname1_flag = 1) or (((integer)rc_decsflag = 1) or (((integer)rc_pwssndobflag = 1) or ((ssnst_region = '5-Island') or ((liens_historical_released_count > 0) or ((years_infutor_first_seen > 0) or (impulse_count > 0))))))));

		tr_other_risk := (((integer)rc_input_addr_not_most_recent = 1) or (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or ((ssnst_region = '5-Island') or ((liens_recent_released_count > 0) or ((years_infutor_first_seen > 0) or (impulse_count > 0)))))));

		td_other_risk := (((integer)rc_input_addr_not_most_recent = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((did_count != 1) or ((liens_recent_released_count > 0) or ((years_infutor_first_seen > 0) or (impulse_count > 0)))))));

		ko_other_risk := ((StringLib.StringToUpperCase(adl_category) != '8 CORE') or ((did_count != 1) or (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_pwssnvalflag = 1) or ((ssnst_region = '5-Island') or ((liens_recent_released_count > 0) or ((liens_historical_released_count > 0) or (impulse_count > 0)))))))));

		kr_other_risk := ((StringLib.StringToUpperCase(adl_category) != '8 CORE') or (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_pwssndobflag = 1) or (((integer)rc_pwssnvalflag = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((did_count != 1) or ((liens_recent_released_count > 0) or (impulse_count > 0))))))))));

		kd_other_risk := ((StringLib.StringToUpperCase(out_addr_type) != 'S') or (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_decsflag = 1) or (((integer)rc_pwssnvalflag = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((did_count != 1) or ((liens_recent_released_count > 0) or ((liens_historical_released_count > 0) or ((impulse_count > 0) or (attr_eviction_flag or (criminal_flag or felony_flag)))))))))))));

		kd_other_risk_i := if(max((integer)attr_total_derog_flag, (integer)kd_other_risk) = NULL, NULL, sum((integer)attr_total_derog_flag, (integer)kd_other_risk));

		kw_other_risk := (((integer)source_tot_P = 0) or ((StringLib.StringToUpperCase(adl_category) != '8 CORE') or ((StringLib.StringToUpperCase(out_addr_type) != 'S') or (((integer)rc_input_addr_not_most_recent = 1) or (((integer)rc_altlname1_flag = 1) or (((integer)rc_altlname2_flag = 1) or (((integer)rc_pwssndobflag = 1) or ((ssnst_region = '5-Island') or (((integer)rc_watchlist_flag = 1) or ((did_count != 1) or ((liens_historical_released_count > 0) or (impulse_count > 0))))))))))));

		no_age_risk := (age <= 35);

		nd_age_risk := (years_in_dob < 55);

		to_age_risk := (age < 25);

		tr_age_i :=  map(age = 0   => -1,
						 age <= 20 => 6,
						 age <= 21 => 5,
						 age <= 22 => 4,
						 age <= 23 => 3,
						 age <= 35 => 2,
									  1);

		ko_age_i :=  map(age = 0   => -1,
						 age <= 21 => 7,
						 age <= 23 => 6,
						 age <= 25 => 5,
						 age <= 40 => 4,
						 age <= 50 => 3,
						 age <= 55 => 2,
									  1);

		kr_age_i :=  map(age <= 22 => 8,
						 age <= 24 => 7,
						 age <= 26 => 6,
						 age <= 48 => 5,
						 age <= 52 => 4,
						 age <= 57 => 3,
						 age <= 61 => 2,
									  1);

		kd_age_i :=  map(age <= 25 => 25,
						 age <= 30 => 30,
						 age <= 35 => 35,
						 age <= 45 => 45,
						 age <= 50 => 50,
						 age <= 55 => 55,
						 age <= 60 => 60,
									  61);

		kw_age_i :=  map(age <= 27 => 27,
						 age <= 31 => 31,
						 age <= 35 => 35,
						 age <= 39 => 39,
						 age <= 47 => 47,
						 age <= 52 => 52,
						 age <= 59 => 59,
									  60);

		tw_years_add1_first_seen_i :=  map(years_add1_date_first_seen = NULL        => 4,
										   years_add1_date_first_seen <= 0.5        => 3,
										   years_add1_date_first_seen <= 2 => 2,
										   years_add1_date_first_seen <= 5 => 1,
																					   -1);

		to_months_add1_first_seen_i :=  map(months_add1_date_first_seen = NULL        => 4,
											months_add1_date_first_seen < 4  => 4,
											months_add1_date_first_seen < 12 => 3,
											months_add1_date_first_seen < 24 => 2,
																						 1);

		tr_months_add1_first_seen_i :=  map(months_add1_date_first_seen = NULL        => 4,
											months_add1_date_first_seen < 4  => 5,
											months_add1_date_first_seen < 6  => 4,
											months_add1_date_first_seen < 12 => 3,
											months_add1_date_first_seen < 24 => 2,
																						 1);

		ko_months_add1_date_first_seen :=  if(months_add1_date_first_seen = NULL, ln(6), ln(min(240, if(max((real)6, months_add1_date_first_seen) = NULL, -NULL, max((real)6, months_add1_date_first_seen)))));

		kd_months_add1_first_seen_i :=  map(months_add1_date_first_seen = NULL         => -1,
											months_add1_date_first_seen < 4   => 4,
											months_add1_date_first_seen < 9   => 9,
											months_add1_date_first_seen < 20  => 20,
											months_add1_date_first_seen < 46  => 46,
											months_add1_date_first_seen < 94  => 94,
											months_add1_date_first_seen < 180 => 180,
											months_add1_date_first_seen < 240 => 240,
																						  241);

		kw_months_credit_first_seen :=  map(months_credit_first_seen <= 69  => 69,
											months_credit_first_seen <= 96  => 96,
											months_credit_first_seen <= 123 => 123,
											months_credit_first_seen <= 148 => 148,
											months_credit_first_seen <= 169 => 169,
											months_credit_first_seen <= 190 => 190,
											months_credit_first_seen <= 208 => 208,
											months_credit_first_seen <= 238 => 238,
											months_credit_first_seen <= 276 => 276,
																						277);

		tw_wealth_index :=  map((integer)wealth_index = 0  => -1,
								(integer)wealth_index <= 3 => (integer)wealth_index,
								(integer)wealth_index <= 5 => 4,
															  5);

		kw_wealth_index :=  if((integer)wealth_index = 0, -1, min(5, if(max(2, (integer)wealth_index) = NULL, -NULL, max(2, (integer)wealth_index))));

		tw_addr_stability :=  if((integer)addr_stability = 0, -1, min(3, if(trim(addr_stability) = '', -NULL, (integer)addr_stability)));

		kr_addr_stability :=  map((integer)addr_stability = 0 => 5,
								  (integer)addr_stability = 1 => 4,
								  (integer)addr_stability = 2 => 4,
								  (integer)addr_stability = 3 => 4,
								  (integer)addr_stability = 4 => 3,
								  (integer)addr_stability = 5 => 2,
																 1);

		kd_addr_stability :=  map((integer)addr_stability = 0 => 3,
								  (integer)addr_stability = 1 => 4,
								  (integer)addr_stability = 2 => 4,
								  (integer)addr_stability = 3 => 4,
								  (integer)addr_stability = 4 => 3,
								  (integer)addr_stability = 5 => 2,
																 1);

		kw_addr_stability :=  map((integer)addr_stability = 0 => -1,
								  (integer)addr_stability = 1 => 4,
								  (integer)addr_stability = 2 => 3,
								  (integer)addr_stability = 3 => 3,
								  (integer)addr_stability = 4 => 3,
								  (integer)addr_stability = 5 => 2,
																 1);

		pk_wealth_index :=  map((integer)wealth_index <= 2 => 0,
								(integer)wealth_index <= 3 => 1,
								(integer)wealth_index <= 4 => 2,
								(integer)wealth_index <= 5 => 3,
															  4);

		pk_wealth_index_m :=  map(pk_wealth_index = 0 => 39116.676936,
								  pk_wealth_index = 1 => 43449.700792,
								  pk_wealth_index = 2 => 57061.910522,
								  pk_wealth_index = 3 => 82122.972447,
														 134020.49977);

		wealth_index_cm :=  map((integer)wealth_index = 0 => 35766,
								(integer)wealth_index = 1 => 32220,
								(integer)wealth_index = 2 => 35991,
								(integer)wealth_index = 3 => 39789,
								(integer)wealth_index = 4 => 46630,
								(integer)wealth_index = 5 => 52993,
								(integer)wealth_index = 6 => 55911,
															 43256);

		add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

		adl_category_ord := (integer)(adl_category = '1 DEAD');

		pk_bk_level :=  map(bankrupt             => 2,
							(integer)bk_flag = 1 => 1,
													0);

		rc_valid_bus_phone :=  if((integer)rc_phonevalflag = 1, 1, 0);

		rc_valid_res_phone :=  if((integer)rc_phonevalflag = 2, 1, 0);

		age_rcd :=  map(age < 18 => 35,
						age > 60 => 35,
									age);

		add1_mortgage_type_ord :=  map(add1_mortgage_type in ['FHA']              => 1,
									   add1_mortgage_type in ['', ' ']            => 2,
									   add1_mortgage_type in ['2', 'E', 'N', 'U'] => 4,
																					 3);

		prof_license_category_ord :=  map(prof_license_category = '0'        => 1,
										  prof_license_category in ['', ' '] => 1.5,
																				(real)prof_license_category);

		pk_attr_total_number_derogs := attr_total_number_derogs;

		pk_attr_total_number_derogs_2 :=  if(pk_attr_total_number_derogs > 3, 3, pk_attr_total_number_derogs);

		pk_attr_num_nonderogs90 := attr_num_nonderogs90;

		pk_attr_num_nonderogs90_2 :=  if(pk_attr_num_nonderogs90 > 4, 4, pk_attr_num_nonderogs90);

		pk_derog_total :=  if(pk_attr_total_number_derogs_2 > 0, pk_attr_total_number_derogs_2, (-1 * pk_attr_num_nonderogs90_2));

		pk_derog_total_m :=  map(pk_derog_total <= -4 => 51961,
								 pk_derog_total <= -3 => 49033,
								 pk_derog_total <= -2 => 45551,
								 pk_derog_total <= -1 => 40287,
								 pk_derog_total <= 0  => 42406,
								 pk_derog_total <= 1  => 40550,
								 pk_derog_total <= 2  => 38539,
								 pk_derog_total <= 3  => 37345,
														 43256);

		add1_avm_automated_valuation_rcd :=  if(add1_avm_automated_valuation = 0, 150000, add1_avm_automated_valuation);

		add1_avm_automated_val_2_rcd :=  if(add1_avm_automated_valuation_2 = 0, 150000, add1_avm_automated_valuation_2);

		pk_liens_unrel_ot_total_amount :=  map(liens_unrel_ot_total_amount <= 0     => -1,
											   liens_unrel_ot_total_amount <= 10000 => 0,
																					   1);

		attr_num_watercraft60_cap :=  if(attr_num_watercraft60 > 2, 2, attr_num_watercraft60);

		combo_addrcount_cap :=  if(combo_addrcount > 6, 6, combo_addrcount);

		gong_did_phone_ct_cap :=  if(gong_did_phone_ct > 5, 5, gong_did_phone_ct);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		ams_college_code_mis := (integer)(trim(ams_college_code)='');

		ams_college_code_cm :=  map((integer)ams_college_code = 2 => 38463,
									(integer)ams_college_code = 4 => 49756,
																	 43256);

		ams_income_level_code_cm :=  map(ams_income_level_code in ['A', 'B', 'C'] => 38285,
										 ams_income_level_code = 'D'              => 39525,
										 ams_income_level_code = 'E'              => 42426,
										 ams_income_level_code = 'F'              => 44337,
										 ams_income_level_code = 'G'              => 46648,
										 ams_income_level_code = 'H'              => 48231,
										 ams_income_level_code = 'I'              => 49622,
										 ams_income_level_code = 'J'              => 52149,
										 ams_income_level_code = 'K'              => 53457,
																					 43095);

		unit5 :=  if(add1_unit_count = 0, 4, min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5));

		pk_dist_a1toa2 :=  map(dist_a1toa2 = 9999 => -1,
							   dist_a1toa2 <= 0   => 0,
							   dist_a1toa2 <= 9   => 1,
													 2);

		pk_dist_a1toa3 :=  map(dist_a1toa3 = 9999 => -1,
							   dist_a1toa3 <= 0   => 0,
							   dist_a1toa3 <= 30  => 1,
													 2);

		pk_dist_a2toa3 :=  map(dist_a2toa3 = 9999 => -1,
							   dist_a2toa3 <= 0   => 0,
							   dist_a2toa3 <= 9   => 1,
							   dist_a2toa3 <= 35  => 2,
													 3);

		pk_rc_disthphoneaddr :=  map(rc_disthphoneaddr = 9999 => 0,
									 rc_disthphoneaddr <= 3   => 0,
									 rc_disthphoneaddr <= 6   => 1,
									 rc_disthphoneaddr <= 12  => 2,
																 3);

		pk_dist_a1toa2_m :=  map(pk_dist_a1toa2 = -1 => 47044.838402,
								 pk_dist_a1toa2 = 0  => 56779.152604,
								 pk_dist_a1toa2 = 1  => 64372.446403,
														67159.04343);

		pk_dist_a1toa3_m :=  map(pk_dist_a1toa3 = -1 => 45641.502319,
								 pk_dist_a1toa3 = 0  => 57276.981937,
								 pk_dist_a1toa3 = 1  => 64982.162906,
														68001.554009);

		pk_dist_a2toa3_m :=  map(pk_dist_a2toa3 = -1 => 46484.736644,
								 pk_dist_a2toa3 = 0  => 56957.192413,
								 pk_dist_a2toa3 = 1  => 62973.959269,
								 pk_dist_a2toa3 = 2  => 65191.442627,
														70153.886806);

		pk_rc_disthphoneaddr_m :=  map(pk_rc_disthphoneaddr = 0 => 62474.417978,
									   pk_rc_disthphoneaddr = 1 => 63733.738308,
									   pk_rc_disthphoneaddr = 2 => 68541.171909,
																   83512.402545);

		Dist_mod := 53000 +
			(pk_dist_a1toa2 * 2742.75338) +
			(pk_dist_a1toa3 * 2773.73056) +
			(pk_dist_a2toa3 * 2915.40756) +
			(pk_rc_disthphoneaddr * 4620.15356);

		pk_yr_date_last_seen := if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen));

		pk_bk_yr_date_last_seen :=  map((real)pk_yr_date_last_seen = NULL => -1,
										(real)pk_yr_date_last_seen >= 9   => 9,
																			 pk_yr_date_last_seen);

		pk_bk_yr_date_last_seen_m1 :=  map(pk_bk_yr_date_last_seen = -1 => 65447.971203,
										   pk_bk_yr_date_last_seen = 1  => 37195.924959,
										   pk_bk_yr_date_last_seen = 2  => 40666.992447,
										   pk_bk_yr_date_last_seen = 3  => 42965.336207,
										   pk_bk_yr_date_last_seen = 4  => 44669.167255,
										   pk_bk_yr_date_last_seen = 5  => 47563.390744,
										   pk_bk_yr_date_last_seen = 6  => 47917.954038,
										   pk_bk_yr_date_last_seen = 7  => 49396.154083,
										   pk_bk_yr_date_last_seen = 8  => 50099.973169,
										   pk_bk_yr_date_last_seen = 9  => 52557.404007,
																		   65447.971203);

		pk_yr_liens_unrel_cj_last_seen := if (years_liens_unrel_cj_last_seen >= 0, roundup(years_liens_unrel_cj_last_seen), truncate(years_liens_unrel_cj_last_seen));

		pk2_yr_liens_unrel_cj_last_seen :=  map((real)pk_yr_liens_unrel_cj_last_seen <= NULL => -1,
												pk_yr_liens_unrel_cj_last_seen <= 3          => 2,
												pk_yr_liens_unrel_cj_last_seen <= 5          => 1,
																								0);

		predicted_inc_high := -28552 +
			(pk_wealth_index_m * 0.51667) +
			((integer)source_tot_DA * 88499) +
			(add1_avm_med * 0.05448) +
			(prof_license_category_ord * 8167.93208) +
			(addrs_per_adl * 855.48025) +
			(pk_derog_total_m * 0.27963) +
			(add1_avm_automated_valuation_rcd * 0.01557) +
			(property_sold_assessed_total * 0.02413) +
			(attr_num_watercraft60_cap * 10490) +
			(age_rcd * 324.98302) +
			(combo_addrcount_cap * -2218.70449) +
			((integer)add_apt * -6810.8463) +
			((integer)source_tot_CG * 28047) +
			((integer)source_tot_W * 6718.13655) +
			(gong_did_phone_ct * 1414.7842) +
			(add1_mortgage_type_ord * 1825.91813) +
			((integer)source_tot_AM * 17169) +
			(rc_valid_bus_phone * 11042) +
			(pk_liens_unrel_ot_total_amount * 7931.02954) +
			(add1_avm_automated_val_2_rcd * 0.00826) +
			(ams_college_code_mis * -5323.07783) +
			(pk_bk_level * -1970.64639);

		predicted_inc_low := -45923 +
			(unit5 * -832.87755) +
			(wealth_index_cm * 0.58264) +
			(pk_derog_total_m * 0.09997) +
			(add1_avm_automated_valuation_rcd * 0.045) +
			(addrs_per_adl * 545.9244) +
			((integer)source_tot_W * 5334.71282) +
			(prof_license_category_ord * 5952.85069) +
			((integer)source_tot_P * 2443.25461) +
			(Dist_mod * 0.14399) +
			(pk_bk_yr_date_last_seen_m1 * 0.09757) +
			(adl_category_ord * -6304.92099) +
			((integer)rc_fnamessnmatch * 1785.49733) +
			(add1_mortgage_type_ord * 859.15454) +
			(pk2_yr_liens_unrel_cj_last_seen * -803.19148) +
			(ams_college_code_cm * 0.23431) +
			(attr_num_watercraft60_cap * 6294.24356) +
			(rc_valid_res_phone * -2008.73124) +
			(ams_income_level_code_cm * 0.08691) +
			(addrs_10yr * -375.39614) +
			(gong_did_phone_ct_cap * 630.52863) +
			((integer)source_tot_AM * 12757) +
			((integer)lname_eda_sourced * 1462.6333);

		pred_inc :=  if((integer)predicted_inc_high < 60000, (predicted_inc_low - 2000), (predicted_inc_high - 2000));

		estimated_income :=  map(pred_inc < 20000  => 19999,
								 pred_inc > 250000 => 250999,
															   round(pred_inc/1000)*1000);

		nw_estimated_income_i :=  map(pred_inc <= 19700 => 9,
									  pred_inc <= 21350 => 8,
									  pred_inc <= 22660 => 7,
									  pred_inc <= 23410 => 6,
									  pred_inc <= 24290 => 5,
									  pred_inc <= 25020 => 4,
									  pred_inc <= 27280 => 3,
									  pred_inc <= 33320 => 2,
																	1);

		nr_estimated_income_i :=  map(pred_inc <= 17460 => 7,
									  pred_inc <= 19340 => 6,
									  pred_inc <= 21210 => 5,
									  pred_inc <= 22670 => 4,
									  pred_inc <= 31380 => 3,
									  pred_inc <= 59860 => 2,
																	1);

		nd_estimated_income_i :=  map(pred_inc <= 18060 => 5,
									  pred_inc <= 21210 => 4,
									  pred_inc <= 24850 => 3,
									  pred_inc <= 36050 => 2,
																	1);

		td_estimated_income_i :=  map(estimated_income <= 24000 => 24000,
									  estimated_income <= 38000 => 38000,
																   38001);

		ko_estimated_income := ln(min(50000, if(estimated_income = NULL, -NULL, estimated_income)));

		kr_estimated_income_i :=  map(estimated_income <= 20000 => 20000,
									  estimated_income <= 22000 => 22000,
									  estimated_income <= 23000 => 23000,
									  estimated_income <= 26000 => 26000,
									  estimated_income <= 35000 => 35000,
									  estimated_income <= 77000 => 77000,
																			77001);

		kd_estimated_income := ln(min(40000, if(estimated_income = NULL, -NULL, estimated_income)));

		nw_nap_i_m :=  map(nw_nap_i = 1 => 0.0354791514,
						   nw_nap_i = 2 => 0.0402211335,
						   nw_nap_i = 3 => 0.0643172339,
						   nw_nap_i = 4 => 0.0954954955,
										   0.0454092314);

		ko_nap_i_m :=  map(ko_nap_i = 1 => 0.0143995098,
						   ko_nap_i = 2 => 0.0339582217,
						   ko_nap_i = 3 => 0.0579572145,
										   0.0400722815);

		kd_nap_i_m :=  map(kd_nap_i = 1 => 0.0498229641,
						   kd_nap_i = 2 => 0.0723047127,
						   kd_nap_i = 3 => 0.1168667618,
										   0.0888497828);

		no_rc_dirsaddr_lastscore_i_m :=  map(no_rc_dirsaddr_lastscore_i = 1 => 0.0585020399,
											 no_rc_dirsaddr_lastscore_i = 2 => 0.0879910982,
											 no_rc_dirsaddr_lastscore_i = 3 => 0.1465464234,
																			   0.0846952932);

		to_rc_dirsaddr_lastscore_i_m :=  map(to_rc_dirsaddr_lastscore_i = 1 => 0.1096899225,
											 to_rc_dirsaddr_lastscore_i = 2 => 0.1441236645,
											 to_rc_dirsaddr_lastscore_i = 3 => 0.1921749137,
																			   0.1435126764);

		kw_rc_dirsaddr_lastscore_i_m :=  map(kw_rc_dirsaddr_lastscore_i = 1 => 0.0124852812,
											 kw_rc_dirsaddr_lastscore_i = 2 => 0.0212282032,
											 kw_rc_dirsaddr_lastscore_i = 3 => 0.030558951,
																			   0.0168450144);

		kr_rc_dirsaddr_lastscore_i_m :=  map(kr_rc_dirsaddr_lastscore_i = 1 => 0.0528358853,
											 kr_rc_dirsaddr_lastscore_i = 2 => 0.0737260571,
											 kr_rc_dirsaddr_lastscore_i = 3 => 0.0964670796,
																			   0.0738567382);

		nd_naprop_i_m :=  map(nd_naprop_i = 1 => 0.0809248555,
							  nd_naprop_i = 2 => 0.1715265866,
							  nd_naprop_i = 3 => 0.285198556,
												 0.2431761787);

		tw_naprop_i_m :=  map(tw_naprop_i = 1 => 0.0805067989,
							  tw_naprop_i = 2 => 0.096185738,
							  tw_naprop_i = 3 => 0.1377410468,
												 0.0809599472);

		td_naprop_i_m :=  map(td_naprop_i = 1 => 0.1379310345,
							  td_naprop_i = 2 => 0.2200598802,
							  td_naprop_i = 3 => 0.2861292665,
							  td_naprop_i = 4 => 0.3541944075,
												 0.2826236264);

		kd_naprop_i_m :=  map(kd_naprop_i = 1 => 0.0454962392,
							  kd_naprop_i = 2 => 0.0995975855,
							  kd_naprop_i = 3 => 0.1142503609,
							  kd_naprop_i = 4 => 0.138592233,
												 0.0888497828);

		kw_rc_numelever_i_m :=  map(kw_rc_numelever_i = 2 => 0.0878859857,
									kw_rc_numelever_i = 3 => 0.0472491909,
									kw_rc_numelever_i = 4 => 0.0412979351,
									kw_rc_numelever_i = 5 => 0.0153787807,
									kw_rc_numelever_i = 6 => 0.010099833,
															 0.0168450144);

		kd_rc_numelever_i_m :=  map(kd_rc_numelever_i = 4 => 0.1736005228,
									kd_rc_numelever_i = 5 => 0.0779398631,
									kd_rc_numelever_i = 6 => 0.0501691094,
															 0.0888497828);

		tw_ams_income_level_i_m :=  map(tw_ams_income_level_i = -1 => 0.0875485072,
										tw_ams_income_level_i = 1  => 0.028928659,
										tw_ams_income_level_i = 2  => 0.0339409177,
										tw_ams_income_level_i = 3  => 0.0446753247,
										tw_ams_income_level_i = 4  => 0.054041983,
										tw_ams_income_level_i = 5  => 0.0648610121,
										tw_ams_income_level_i = 6  => 0.07072,
										tw_ams_income_level_i = 7  => 0.0955806783,
										tw_ams_income_level_i = 8  => 0.1060157791,
										tw_ams_income_level_i = 9  => 0.156448203,
																	  0.0809599472);

		to_ams_income_level_i_m :=  map(to_ams_income_level_i = -1 => 0.1504357711,
										to_ams_income_level_i = 1  => 0.0453514739,
										to_ams_income_level_i = 2  => 0.0600858369,
										to_ams_income_level_i = 3  => 0.1054407423,
										to_ams_income_level_i = 4  => 0.1303611738,
										to_ams_income_level_i = 5  => 0.1902017291,
										to_ams_income_level_i = 6  => 0.2851405622,
																	  0.1435126764);

		tr_ams_income_level_i_m :=  map(tr_ams_income_level_i = -1 => 0.1637056608,
										tr_ams_income_level_i = 1  => 0.0798165138,
										tr_ams_income_level_i = 2  => 0.115008881,
										tr_ams_income_level_i = 3  => 0.1329521086,
										tr_ams_income_level_i = 4  => 0.1649595687,
										tr_ams_income_level_i = 5  => 0.1687526975,
										tr_ams_income_level_i = 6  => 0.2222769837,
										tr_ams_income_level_i = 7  => 0.2477360931,
										tr_ams_income_level_i = 8  => 0.2841091493,
																	  0.1648916636);

		td_ams_income_level_i_m :=  map(td_ams_income_level_i = -1 => 0.2931937173,
										td_ams_income_level_i = 1  => 0.1034482759,
										td_ams_income_level_i = 2  => 0.1666666667,
										td_ams_income_level_i = 3  => 0.2165242165,
										td_ams_income_level_i = 4  => 0.2962962963,
										td_ams_income_level_i = 5  => 0.3493975904,
										td_ams_income_level_i = 6  => 0.5217391304,
																	  0.2826236264);

		kw_ams_income_level_i_m :=  map(kw_ams_income_level_i = -1 => 0.0164686583,
										kw_ams_income_level_i = 1  => 0.0079901659,
										kw_ams_income_level_i = 2  => 0.0132404181,
										kw_ams_income_level_i = 3  => 0.0162513543,
										kw_ams_income_level_i = 4  => 0.0173310225,
										kw_ams_income_level_i = 5  => 0.0215219062,
										kw_ams_income_level_i = 6  => 0.0223988439,
										kw_ams_income_level_i = 7  => 0.0332326284,
										kw_ams_income_level_i = 8  => 0.0400696864,
										kw_ams_income_level_i = 9  => 0.0551724138,
																	  0.0168450144);

		kr_ams_income_level_i_m :=  map(kr_ams_income_level_i = -1 => 0.076179912,
										kr_ams_income_level_i = 1  => 0.0321811681,
										kr_ams_income_level_i = 2  => 0.0359477124,
										kr_ams_income_level_i = 3  => 0.0429982568,
										kr_ams_income_level_i = 4  => 0.0626213592,
										kr_ams_income_level_i = 5  => 0.0951871658,
										kr_ams_income_level_i = 6  => 0.1221374046,
																	  0.0738567382);

		ko_ams_income_level_i_m :=  map(ko_ams_income_level_i = -1 => 0.0409003134,
										ko_ams_income_level_i = 1  => 0.0121028744,
										ko_ams_income_level_i = 2  => 0.0249867092,
										ko_ams_income_level_i = 3  => 0.0311614731,
										ko_ams_income_level_i = 4  => 0.0370931113,
										ko_ams_income_level_i = 5  => 0.0454856361,
										ko_ams_income_level_i = 6  => 0.0821325648,
										ko_ams_income_level_i = 7  => 0.0869565217,
																	  0.0400722815);

		kd_ams_income_level_i_m :=  map(kd_ams_income_level_i = -1 => 0.0866702115,
										kd_ams_income_level_i = 1  => 0.0461538462,
										kd_ams_income_level_i = 2  => 0.0935350757,
										kd_ams_income_level_i = 3  => 0.131840796,
										kd_ams_income_level_i = 4  => 0.1374269006,
										kd_ams_income_level_i = 5  => 0.186770428,
										kd_ams_income_level_i = 6  => 0.2236842105,
																	  0.0888497828);

		nw_ams_i_m :=  map(nw_ams_i = 1 => 0.0111870261,
						   nw_ams_i = 2 => 0.0479953809,
						   nw_ams_i = 3 => 0.0552042429,
										   0.0454092314);

		nr_ams_i_m :=  map(nr_ams_i = 1 => 0.0335128665,
						   nr_ams_i = 2 => 0.1447878272,
						   nr_ams_i = 3 => 0.1480408103,
										   0.1393020235);

		no_ams_i_m :=  map(no_ams_i = 1 => 0.0236028215,
						   no_ams_i = 2 => 0.0777777778,
						   no_ams_i = 3 => 0.1006392487,
										   0.0846952932);

		nd_ams_i_m :=  map(nd_ams_i = 1 => 0.0547945205,
						   nd_ams_i = 2 => 0.2129436326,
						   nd_ams_i = 3 => 0.258306538,
										   0.2431761787);

		tw_ams_i_m :=  map(tw_ams_i = 1 => 0.023713129,
						   tw_ams_i = 2 => 0.0757450102,
						   tw_ams_i = 3 => 0.0927138028,
										   0.0809599472);

		to_ams_i_m :=  map(to_ams_i = 1 => 0.0413683373,
						   to_ams_i = 2 => 0.1335107873,
						   to_ams_i = 3 => 0.1565276015,
										   0.1435126764);

		td_ams_i_m :=  map(td_ams_i = 1 => 0.0238095238,
						   td_ams_i = 2 => 0.2595155709,
						   td_ams_i = 3 => 0.2982222222,
										   0.2826236264);

		nw_add1_assessed_value_i_m :=  map(nw_add1_assessed_value_i = -1     => 0.0439735424,
										   nw_add1_assessed_value_i = 20000  => 0.1165158371,
										   nw_add1_assessed_value_i = 60000  => 0.0948453608,
										   nw_add1_assessed_value_i = 120000 => 0.06887382,
										   nw_add1_assessed_value_i = 160000 => 0.0438225502,
										   nw_add1_assessed_value_i = 200000 => 0.0383268082,
										   nw_add1_assessed_value_i = 240000 => 0.0331238544,
										   nw_add1_assessed_value_i = 300000 => 0.0274949084,
										   nw_add1_assessed_value_i = 400000 => 0.0246417571,
										   nw_add1_assessed_value_i = 500000 => 0.0243902439,
										   nw_add1_assessed_value_i = 500001 => 0.0221060138,
																				0.0454092314);

		nr_add1_assessed_value_i_m :=  map(nr_add1_assessed_value_i = -1     => 0.130386599,
										   nr_add1_assessed_value_i = 60000  => 0.2068965517,
										   nr_add1_assessed_value_i = 100000 => 0.1850046425,
										   nr_add1_assessed_value_i = 140000 => 0.1520348093,
										   nr_add1_assessed_value_i = 160000 => 0.1397295557,
										   nr_add1_assessed_value_i = 200000 => 0.1253955696,
										   nr_add1_assessed_value_i = 240000 => 0.1105499439,
										   nr_add1_assessed_value_i = 500000 => 0.0933946286,
										   nr_add1_assessed_value_i = 500001 => 0.0862552595,
																				0.1393020235);

		tw_add1_assessed_value_i_m :=  map(tw_add1_assessed_value_i = -1     => 0.0781317262,
										   tw_add1_assessed_value_i = 60000  => 0.132331556,
										   tw_add1_assessed_value_i = 80000  => 0.1170830912,
										   tw_add1_assessed_value_i = 100000 => 0.10591133,
										   tw_add1_assessed_value_i = 120000 => 0.1005230839,
										   tw_add1_assessed_value_i = 200000 => 0.0786202408,
										   tw_add1_assessed_value_i = 300000 => 0.0655998585,
										   tw_add1_assessed_value_i = 400000 => 0.0577130529,
										   tw_add1_assessed_value_i = 500000 => 0.0508250825,
										   tw_add1_assessed_value_i = 500001 => 0.0383858268,
																				0.0809599472);

		tr_add1_assessed_value_i_m :=  map(tr_add1_assessed_value_i = -1     => 0.1482177964,
										   tr_add1_assessed_value_i = 20000  => 0.2670623145,
										   tr_add1_assessed_value_i = 60000  => 0.2503483511,
										   tr_add1_assessed_value_i = 120000 => 0.2236674678,
										   tr_add1_assessed_value_i = 160000 => 0.1923076923,
										   tr_add1_assessed_value_i = 200000 => 0.1722090261,
										   tr_add1_assessed_value_i = 240000 => 0.1526872964,
										   tr_add1_assessed_value_i = 300000 => 0.1474192351,
										   tr_add1_assessed_value_i = 400000 => 0.1403169695,
										   tr_add1_assessed_value_i = 500000 => 0.1387163561,
										   tr_add1_assessed_value_i = 500001 => 0.125895213,
																				0.1648916636);

		kr_add1_assessed_value_i_m :=  map(kr_add1_assessed_value_i = -1     => 0.0675113205,
										   kr_add1_assessed_value_i = 20000  => 0.1129326047,
										   kr_add1_assessed_value_i = 60000  => 0.1063829787,
										   kr_add1_assessed_value_i = 120000 => 0.1041958042,
										   kr_add1_assessed_value_i = 240000 => 0.078521382,
										   kr_add1_assessed_value_i = 400000 => 0.0656614786,
										   kr_add1_assessed_value_i = 500000 => 0.0610412926,
										   kr_add1_assessed_value_i = 500001 => 0.0588812561,
																				0.0738567382);

		nr_add1_avm_med_i_m :=  map(nr_add1_avm_med_i = -1     => 0.0891483908,
									nr_add1_avm_med_i = 60000  => 0.243877199,
									nr_add1_avm_med_i = 80000  => 0.2136815006,
									nr_add1_avm_med_i = 100000 => 0.1681711802,
									nr_add1_avm_med_i = 120000 => 0.1589814178,
									nr_add1_avm_med_i = 200000 => 0.1399232246,
									nr_add1_avm_med_i = 280000 => 0.1383921379,
									nr_add1_avm_med_i = 500000 => 0.1281488329,
									nr_add1_avm_med_i = 600000 => 0.0994535519,
									nr_add1_avm_med_i = 600001 => 0.0779904306,
																  0.1393020235);

		no_add1_avm_med_i_m :=  map(no_add1_avm_med_i = -1     => 0.0642101001,
									no_add1_avm_med_i = 40000  => 0.2225274725,
									no_add1_avm_med_i = 60000  => 0.1478537361,
									no_add1_avm_med_i = 80000  => 0.1300602929,
									no_add1_avm_med_i = 100000 => 0.1258169935,
									no_add1_avm_med_i = 300000 => 0.1094052765,
									no_add1_avm_med_i = 500000 => 0.094376212,
									no_add1_avm_med_i = 500001 => 0.0537974684,
																  0.0846952932);

		nd_add1_avm_med_i_m :=  map(nd_add1_avm_med_i = -1     => 0.1844919786,
									nd_add1_avm_med_i = 60000  => 0.3710691824,
									nd_add1_avm_med_i = 200000 => 0.2186335404,
									nd_add1_avm_med_i = 200001 => 0.262962963,
																  0.2431761787);

		tw_add1_avm_med_i_m :=  map(tw_add1_avm_med_i = -1     => 0.0763376384,
									tw_add1_avm_med_i = 20000  => 0.2230769231,
									tw_add1_avm_med_i = 40000  => 0.1932624113,
									tw_add1_avm_med_i = 60000  => 0.1685761047,
									tw_add1_avm_med_i = 80000  => 0.1280233528,
									tw_add1_avm_med_i = 100000 => 0.1129800063,
									tw_add1_avm_med_i = 120000 => 0.1047388261,
									tw_add1_avm_med_i = 200000 => 0.0811361694,
									tw_add1_avm_med_i = 500000 => 0.0722904508,
									tw_add1_avm_med_i = 640000 => 0.066,
									tw_add1_avm_med_i = 640001 => 0.0348412475,
																  0.0809599472);

		to_add1_avm_med_i_m :=  map(to_add1_avm_med_i = -1     => 0.128500291,
									to_add1_avm_med_i = 20000  => 0.3225806452,
									to_add1_avm_med_i = 40000  => 0.2552083333,
									to_add1_avm_med_i = 60000  => 0.2156626506,
									to_add1_avm_med_i = 120000 => 0.1872500588,
									to_add1_avm_med_i = 500000 => 0.1450168919,
									to_add1_avm_med_i = 500001 => 0.1015701668,
																  0.1435126764);

		tr_add1_avm_med_i_m :=  map(tr_add1_avm_med_i = -1     => 0.1457545981,
									tr_add1_avm_med_i = 20000  => 0.2929292929,
									tr_add1_avm_med_i = 60000  => 0.2749018208,
									tr_add1_avm_med_i = 80000  => 0.2380782918,
									tr_add1_avm_med_i = 100000 => 0.2200598802,
									tr_add1_avm_med_i = 220000 => 0.1807796028,
									tr_add1_avm_med_i = 280000 => 0.1675702938,
									tr_add1_avm_med_i = 500000 => 0.1547758285,
									tr_add1_avm_med_i = 600000 => 0.1249793354,
									tr_add1_avm_med_i = 760000 => 0.1069465267,
									tr_add1_avm_med_i = 760001 => 0.0858196447,
																  0.1648916636);

		kw_add1_avm_med_i_m :=  map(kw_add1_avm_med_i = -1     => 0.0128553064,
									kw_add1_avm_med_i = 20000  => 0.0609756098,
									kw_add1_avm_med_i = 100000 => 0.023375289,
									kw_add1_avm_med_i = 700000 => 0.0167917848,
									kw_add1_avm_med_i = 700001 => 0.0118918919,
																  0.0168450144);

		kr_add1_avm_med_i_m :=  map(kr_add1_avm_med_i = -1     => 0.0448859455,
									kr_add1_avm_med_i = 20000  => 0.1525423729,
									kr_add1_avm_med_i = 60000  => 0.131822863,
									kr_add1_avm_med_i = 80000  => 0.1151346332,
									kr_add1_avm_med_i = 100000 => 0.1110271903,
									kr_add1_avm_med_i = 500000 => 0.0805152979,
									kr_add1_avm_med_i = 600000 => 0.0657943925,
									kr_add1_avm_med_i = 760000 => 0.0589717742,
									kr_add1_avm_med_i = 760001 => 0.033021464,
																  0.0738567382);

		ko_add1_avm_med_i_m :=  map(ko_ADD1_AVM_MED_i = -1     => 0.029434954,
									ko_ADD1_AVM_MED_i = 20000  => 0.14,
									ko_ADD1_AVM_MED_i = 40000  => 0.0888157895,
									ko_ADD1_AVM_MED_i = 60000  => 0.0674157303,
									ko_ADD1_AVM_MED_i = 80000  => 0.0644666155,
									ko_ADD1_AVM_MED_i = 100000 => 0.0578718108,
									ko_ADD1_AVM_MED_i = 120000 => 0.0538599641,
									ko_ADD1_AVM_MED_i = 140000 => 0.0495656617,
									ko_ADD1_AVM_MED_i = 300000 => 0.0441503441,
									ko_ADD1_AVM_MED_i = 700000 => 0.0413579415,
									ko_ADD1_AVM_MED_i = 700001 => 0.018268467,
																  0.0400722815);

		kd_add1_avm_med_i_m :=  map(kd_add1_avm_med_i = -1     => 0.0892558028,
									kd_add1_avm_med_i = 60000  => 0.1578378378,
									kd_add1_avm_med_i = 80000  => 0.1231380338,
									kd_add1_avm_med_i = 100000 => 0.1033022862,
									kd_add1_avm_med_i = 200000 => 0.0944498539,
									kd_add1_avm_med_i = 280000 => 0.0824439701,
									kd_add1_avm_med_i = 500000 => 0.0799671593,
									kd_add1_avm_med_i = 600000 => 0.0791208791,
									kd_add1_avm_med_i = 600001 => 0.0594831789,
																  0.0888497828);

		nw_add1_avm_sales_price_i_m :=  map(nw_add1_avm_sales_price_i = -2     => 0.0434447045,
											nw_add1_avm_sales_price_i = 80000  => 0.0659863946,
											nw_add1_avm_sales_price_i = 100000 => 0.0542879622,
											nw_add1_avm_sales_price_i = 140000 => 0.046564452,
											nw_add1_avm_sales_price_i = 180000 => 0.0393518519,
											nw_add1_avm_sales_price_i = 300000 => 0.0348934143,
											nw_add1_avm_sales_price_i = 300001 => 0.034298441,
																				  0.0454092314);

		nr_add1_avm_sales_price_i_m :=  map(nr_add1_avm_sales_price_i = -2     => 0.1329130549,
											nr_add1_avm_sales_price_i = 20000  => 0.279109589,
											nr_add1_avm_sales_price_i = 40000  => 0.2304394427,
											nr_add1_avm_sales_price_i = 60000  => 0.2039848197,
											nr_add1_avm_sales_price_i = 100000 => 0.1805772231,
											nr_add1_avm_sales_price_i = 120000 => 0.1561938959,
											nr_add1_avm_sales_price_i = 160000 => 0.1363211951,
											nr_add1_avm_sales_price_i = 220000 => 0.1179104478,
											nr_add1_avm_sales_price_i = 300000 => 0.1107974594,
											nr_add1_avm_sales_price_i = 300001 => 0.1086300543,
																				  0.1393020235);

		tw_add1_avm_sales_price_i_m :=  map(tw_add1_avm_sales_price_i = -2     => 0.0799364564,
											tw_add1_avm_sales_price_i = 100000 => 0.1051166966,
											tw_add1_avm_sales_price_i = 120000 => 0.0941792021,
											tw_add1_avm_sales_price_i = 160000 => 0.0811157422,
											tw_add1_avm_sales_price_i = 260000 => 0.0679341783,
											tw_add1_avm_sales_price_i = 260001 => 0.0597713098,
																				  0.0809599472);

		nw_add1_avm_valuation_i_m :=  map(nw_add1_avm_valuation_i = -1     => 0.041589989,
										  nw_add1_avm_valuation_i = 40000  => 0.1279187817,
										  nw_add1_avm_valuation_i = 60000  => 0.1203143894,
										  nw_add1_avm_valuation_i = 80000  => 0.1112852665,
										  nw_add1_avm_valuation_i = 100000 => 0.0838142347,
										  nw_add1_avm_valuation_i = 120000 => 0.0569386246,
										  nw_add1_avm_valuation_i = 180000 => 0.04334456,
										  nw_add1_avm_valuation_i = 260000 => 0.0381371206,
										  nw_add1_avm_valuation_i = 500000 => 0.0315937941,
										  nw_add1_avm_valuation_i = 500001 => 0.0241171404,
																			  0.0454092314);

		tw_add1_avm_valuation_i_m :=  map(tw_add1_avm_valuation_i = -1     => 0.0808689024,
										  tw_add1_avm_valuation_i = 20000  => 0.2202380952,
										  tw_add1_avm_valuation_i = 40000  => 0.186770428,
										  tw_add1_avm_valuation_i = 60000  => 0.1804222649,
										  tw_add1_avm_valuation_i = 80000  => 0.1292442497,
										  tw_add1_avm_valuation_i = 100000 => 0.1290992113,
										  tw_add1_avm_valuation_i = 120000 => 0.1022855002,
										  tw_add1_avm_valuation_i = 140000 => 0.0976855003,
										  tw_add1_avm_valuation_i = 260000 => 0.079045954,
										  tw_add1_avm_valuation_i = 500000 => 0.0691705254,
										  tw_add1_avm_valuation_i = 600000 => 0.0675317016,
										  tw_add1_avm_valuation_i = 600001 => 0.0403823644,
																			  0.0809599472);

		tr_add1_avm_valuation_i_m :=  map(tr_add1_avm_valuation_i = -1     => 0.1502867076,
										  tr_add1_avm_valuation_i = 40000  => 0.3381642512,
										  tr_add1_avm_valuation_i = 60000  => 0.2953904045,
										  tr_add1_avm_valuation_i = 80000  => 0.2858225929,
										  tr_add1_avm_valuation_i = 100000 => 0.2394736842,
										  tr_add1_avm_valuation_i = 120000 => 0.2219887955,
										  tr_add1_avm_valuation_i = 140000 => 0.216,
										  tr_add1_avm_valuation_i = 160000 => 0.2111398964,
										  tr_add1_avm_valuation_i = 180000 => 0.1947029349,
										  tr_add1_avm_valuation_i = 200000 => 0.1938223938,
										  tr_add1_avm_valuation_i = 220000 => 0.1828138163,
										  tr_add1_avm_valuation_i = 500000 => 0.1669194397,
										  tr_add1_avm_valuation_i = 860000 => 0.1334729129,
										  tr_add1_avm_valuation_i = 860001 => 0.0720588235,
																			  0.1648916636);

		kw_add1_avm_valuation_i_m :=  map(kw_add1_avm_valuation_i = -1     => 0.0156382405,
										  kw_add1_avm_valuation_i = 40000  => 0.0286168521,
										  kw_add1_avm_valuation_i = 100000 => 0.0253034355,
										  kw_add1_avm_valuation_i = 600000 => 0.0173701332,
										  kw_add1_avm_valuation_i = 600001 => 0.0109206525,
																			  0.0168450144);

		nw_add1_building_area_i_m :=  map(nw_add1_building_area_i = 1 => 0.0185504745,
										  nw_add1_building_area_i = 2 => 0.0255700326,
										  nw_add1_building_area_i = 3 => 0.0299994941,
										  nw_add1_building_area_i = 4 => 0.0516160747,
										  nw_add1_building_area_i = 5 => 0.1034051859,
																		 0.0454092314);

		nr_add1_building_area_i_m :=  map(nr_add1_building_area_i = -1 => 0.1288276721,
										  nr_add1_building_area_i = 1  => 0.0943113772,
										  nr_add1_building_area_i = 2  => 0.117036434,
										  nr_add1_building_area_i = 3  => 0.1603683709,
										  nr_add1_building_area_i = 4  => 0.219889065,
																		  0.1393020235);

		tw_add1_building_area_i_m :=  map(tw_add1_building_area_i = -1 => 0.0725188382,
										  tw_add1_building_area_i = 1  => 0.0244399185,
										  tw_add1_building_area_i = 2  => 0.0418367347,
										  tw_add1_building_area_i = 3  => 0.0448172258,
										  tw_add1_building_area_i = 4  => 0.0574405374,
										  tw_add1_building_area_i = 5  => 0.0977930393,
										  tw_add1_building_area_i = 6  => 0.1483931947,
																		  0.0809599472);

		tr_add1_building_area_i_m :=  map(tr_add1_building_area_i = 1 => 0.1353383459,
										  tr_add1_building_area_i = 2 => 0.1362189688,
										  tr_add1_building_area_i = 3 => 0.1553738318,
										  tr_add1_building_area_i = 4 => 0.1629823121,
										  tr_add1_building_area_i = 5 => 0.2351149266,
																		 0.1648916636);

		kw_add1_building_area_i_m :=  map(kw_add1_building_area_i = -1 => 0.0156377433,
										  kw_add1_building_area_i = 1  => 0.0132013201,
										  kw_add1_building_area_i = 2  => 0.0118841297,
										  kw_add1_building_area_i = 3  => 0.0206307954,
										  kw_add1_building_area_i = 4  => 0.0270639694,
																		  0.0168450144);

		ko_add1_building_area_i_m :=  map(ko_add1_building_area_i = -1 => 0.0395797884,
										  ko_add1_building_area_i = 1  => 0.0074074074,
										  ko_add1_building_area_i = 2  => 0.0205479452,
										  ko_add1_building_area_i = 3  => 0.0222437137,
										  ko_add1_building_area_i = 4  => 0.0293963255,
										  ko_add1_building_area_i = 5  => 0.0469393004,
										  ko_add1_building_area_i = 6  => 0.0735632184,
																		  0.0400722815);

		nw_years_add1_avm_recording_i_m :=  map(nw_years_add1_avm_recording_i = -2 => 0.041589989,
												nw_years_add1_avm_recording_i = -1 => 0.0432090395,
												nw_years_add1_avm_recording_i = 1  => 0.0359448517,
												nw_years_add1_avm_recording_i = 2  => 0.0492712294,
												nw_years_add1_avm_recording_i = 3  => 0.0575676706,
												nw_years_add1_avm_recording_i = 4  => 0.0674915636,
												nw_years_add1_avm_recording_i = 5  => 0.0828343313,
																					  0.0454092314);

		nr_years_add1_avm_recording_i_m :=  map(nr_years_add1_avm_recording_i = -3 => 0.2181372549,
												nr_years_add1_avm_recording_i = -2 => 0.126534639,
												nr_years_add1_avm_recording_i = -1 => 0.1567858893,
												nr_years_add1_avm_recording_i = 1  => 0.1338057524,
												nr_years_add1_avm_recording_i = 2  => 0.1426318161,
												nr_years_add1_avm_recording_i = 3  => 0.1581964081,
												nr_years_add1_avm_recording_i = 4  => 0.1680981595,
												nr_years_add1_avm_recording_i = 5  => 0.1734128675,
																					  0.1393020235);

		tw_years_add1_avm_recording_i_m :=  map(tw_years_add1_avm_recording_i = -2 => 0.0808689024,
												tw_years_add1_avm_recording_i = -1 => 0.0766004263,
												tw_years_add1_avm_recording_i = 1  => 0.0639200657,
												tw_years_add1_avm_recording_i = 2  => 0.0854642766,
												tw_years_add1_avm_recording_i = 3  => 0.0932923522,
												tw_years_add1_avm_recording_i = 4  => 0.0981552384,
												tw_years_add1_avm_recording_i = 5  => 0.1145002346,
																					  0.0809599472);

		kw_years_add1_avm_recording_i_m :=  map(kw_years_add1_avm_recording_i = -2 => 0.0156382405,
												kw_years_add1_avm_recording_i = -1 => 0.0120465711,
												kw_years_add1_avm_recording_i = 1  => 0.0078895464,
												kw_years_add1_avm_recording_i = 2  => 0.010969307,
												kw_years_add1_avm_recording_i = 3  => 0.0187477574,
												kw_years_add1_avm_recording_i = 4  => 0.0236949278,
												kw_years_add1_avm_recording_i = 5  => 0.0296684119,
												kw_years_add1_avm_recording_i = 6  => 0.0305916306,
																					  0.0168450144);

		nw_years_add1_purchase_date_i_m :=  map(nw_years_add1_purchase_date_i = -1 => 0.0319902106,
												nw_years_add1_purchase_date_i = 1  => 0.0323185988,
												nw_years_add1_purchase_date_i = 2  => 0.0371548117,
												nw_years_add1_purchase_date_i = 3  => 0.0462815501,
												nw_years_add1_purchase_date_i = 4  => 0.0590577568,
																					  0.0454092314);

		tw_years_add1_purchase_date_i_m :=  map(tw_years_add1_purchase_date_i = -2 => 0.1237113402,
												tw_years_add1_purchase_date_i = -1 => 0.0641891892,
												tw_years_add1_purchase_date_i = 1  => 0.0551230146,
												tw_years_add1_purchase_date_i = 2  => 0.0569184681,
												tw_years_add1_purchase_date_i = 3  => 0.0863575907,
												tw_years_add1_purchase_date_i = 4  => 0.0991037251,
																					  0.0809599472);

		kw_years_add1_purchase_date_i_m :=  map(kw_years_add1_purchase_date_i = -1 => 0.0142187341,
												kw_years_add1_purchase_date_i = 1  => 0.0056148231,
												kw_years_add1_purchase_date_i = 2  => 0.0076676696,
												kw_years_add1_purchase_date_i = 3  => 0.0112306972,
												kw_years_add1_purchase_date_i = 4  => 0.0119196989,
												kw_years_add1_purchase_date_i = 5  => 0.0151554743,
												kw_years_add1_purchase_date_i = 6  => 0.0221764613,
												kw_years_add1_purchase_date_i = 7  => 0.0295786368,
												kw_years_add1_purchase_date_i = 8  => 0.0317156528,
																					  0.0168450144);

		nw_addrs_per_ssn_risk_m :=  map(nw_addrs_per_ssn_risk = 1 => 0.0342611043,
										nw_addrs_per_ssn_risk = 2 => 0.0397881153,
										nw_addrs_per_ssn_risk = 3 => 0.0588235294,
										nw_addrs_per_ssn_risk = 4 => 0.0749537623,
																	 0.0454092314);

		nr_addrs_per_ssn_i_m :=  map(nr_addrs_per_ssn_i = 1 => 0.116970278,
									 nr_addrs_per_ssn_i = 2 => 0.1237121832,
									 nr_addrs_per_ssn_i = 3 => 0.1575919865,
									 nr_addrs_per_ssn_i = 4 => 0.1646935933,
									 nr_addrs_per_ssn_i = 5 => 0.1736782902,
									 nr_addrs_per_ssn_i = 6 => 0.1924290221,
															   0.1393020235);

		no_addrs_per_ssn_i_m :=  map(no_addrs_per_ssn_i = 1 => 0.0655085247,
									 no_addrs_per_ssn_i = 2 => 0.1054385965,
									 no_addrs_per_ssn_i = 3 => 0.122463261,
									 no_addrs_per_ssn_i = 4 => 0.1351963746,
									 no_addrs_per_ssn_i = 5 => 0.1437847866,
															   0.0846952932);

		tw_addrs_per_ssn_i_m :=  map(tw_addrs_per_ssn_i = 1 => 0.0573183883,
									 tw_addrs_per_ssn_i = 2 => 0.0893392968,
									 tw_addrs_per_ssn_i = 3 => 0.103033419,
									 tw_addrs_per_ssn_i = 4 => 0.1147227533,
									 tw_addrs_per_ssn_i = 5 => 0.1312250996,
															   0.0809599472);

		to_addrs_per_ssn_i_m :=  map(to_addrs_per_ssn_i = 1 => 0.1058956065,
									 to_addrs_per_ssn_i = 2 => 0.1482736708,
									 to_addrs_per_ssn_i = 3 => 0.1582840237,
									 to_addrs_per_ssn_i = 4 => 0.1720384507,
									 to_addrs_per_ssn_i = 5 => 0.2010638298,
															   0.1435126764);

		to_adlperssn_i_m :=  map(to_adlperssn_i = 1 => 0.1338855144,
								 to_adlperssn_i = 2 => 0.1721518987,
								 to_adlperssn_i = 3 => 0.196969697,
								 to_adlperssn_i = 4 => 0.2222222222,
													   0.1435126764);

		tr_adlperssn_i_m :=  map(tr_adlperssn_i = 1 => 0.1493021849,
								 tr_adlperssn_i = 2 => 0.2168386997,
								 tr_adlperssn_i = 3 => 0.2603201348,
								 tr_adlperssn_i = 4 => 0.2668393782,
													   0.1648916636);

		kr_adlperssn_i_m :=  map(kr_adlperssn_i = 1 => 0.0685098517,
								 kr_adlperssn_i = 2 => 0.0858912595,
								 kr_adlperssn_i = 3 => 0.0985527223,
								 kr_adlperssn_i = 4 => 0.1019955654,
													   0.0738567382);

		nw_id_per_addr_risk_m :=  map(nw_id_per_addr_risk = 1  => 0.0266091627,
									  nw_id_per_addr_risk = 2  => 0.0349586852,
									  nw_id_per_addr_risk = 3  => 0.0387066321,
									  nw_id_per_addr_risk = 4  => 0.0447357751,
									  nw_id_per_addr_risk = 5  => 0.0471682164,
									  nw_id_per_addr_risk = 6  => 0.0524152107,
									  nw_id_per_addr_risk = 7  => 0.0615465544,
									  nw_id_per_addr_risk = 8  => 0.0667104831,
									  nw_id_per_addr_risk = 9  => 0.0731845957,
									  nw_id_per_addr_risk = 10 => 0.1015417331,
									  nw_id_per_addr_risk = 11 => 0.1200356983,
																  0.0454092314);

		nr_id_per_addr_i_m :=  map(nr_id_per_addr_i = -1 => 0.131651557,
								   nr_id_per_addr_i = 1  => 0.0797392177,
								   nr_id_per_addr_i = 2  => 0.083303151,
								   nr_id_per_addr_i = 3  => 0.1006549466,
								   nr_id_per_addr_i = 4  => 0.1109574836,
								   nr_id_per_addr_i = 5  => 0.1169988277,
								   nr_id_per_addr_i = 6  => 0.1385064664,
								   nr_id_per_addr_i = 7  => 0.1614349776,
								   nr_id_per_addr_i = 8  => 0.1620469083,
								   nr_id_per_addr_i = 9  => 0.1675094817,
								   nr_id_per_addr_i = 10 => 0.191626409,
								   nr_id_per_addr_i = 11 => 0.1962331839,
															0.1393020235);

		no_id_per_addr_i_m :=  map(no_id_per_addr_i = -1 => 0.0978848992,
								   no_id_per_addr_i = 1  => 0.0489849956,
								   no_id_per_addr_i = 2  => 0.0540906018,
								   no_id_per_addr_i = 3  => 0.0614747571,
								   no_id_per_addr_i = 4  => 0.0659544821,
								   no_id_per_addr_i = 5  => 0.0716234652,
								   no_id_per_addr_i = 6  => 0.0989876265,
								   no_id_per_addr_i = 7  => 0.1107026144,
								   no_id_per_addr_i = 8  => 0.1188118812,
								   no_id_per_addr_i = 9  => 0.1268011527,
								   no_id_per_addr_i = 10 => 0.1524896266,
								   no_id_per_addr_i = 11 => 0.1833855799,
															0.0846952932);

		nd_id_per_addr_i_m :=  map(nd_id_per_addr_i = 1 => 0.1718377088,
								   nd_id_per_addr_i = 2 => 0.1933333333,
								   nd_id_per_addr_i = 3 => 0.2141756549,
								   nd_id_per_addr_i = 4 => 0.29,
														   0.2431761787);

		tw_id_per_addr_i_m :=  map(tw_id_per_addr_i = 1 => 0.0509366449,
								   tw_id_per_addr_i = 2 => 0.0537437487,
								   tw_id_per_addr_i = 3 => 0.0646075375,
								   tw_id_per_addr_i = 4 => 0.075613079,
								   tw_id_per_addr_i = 5 => 0.0855630414,
								   tw_id_per_addr_i = 6 => 0.0993489952,
								   tw_id_per_addr_i = 7 => 0.1050932568,
								   tw_id_per_addr_i = 8 => 0.1173016328,
								   tw_id_per_addr_i = 9 => 0.1411580595,
														   0.0809599472);

		to_id_per_addr_i_m :=  map(to_id_per_addr_i = 1 => 0.0976676385,
								   to_id_per_addr_i = 2 => 0.1158205248,
								   to_id_per_addr_i = 3 => 0.1201117318,
								   to_id_per_addr_i = 4 => 0.1353216663,
								   to_id_per_addr_i = 5 => 0.1627125346,
								   to_id_per_addr_i = 6 => 0.1979332273,
														   0.1435126764);

		tr_id_per_addr_i_m :=  map(tr_id_per_addr_i = -1 => 0.1310861423,
								   tr_id_per_addr_i = 1  => 0.1239830784,
								   tr_id_per_addr_i = 2  => 0.132524708,
								   tr_id_per_addr_i = 3  => 0.1336366221,
								   tr_id_per_addr_i = 4  => 0.1445722861,
								   tr_id_per_addr_i = 5  => 0.1512605042,
								   tr_id_per_addr_i = 6  => 0.1548196015,
								   tr_id_per_addr_i = 7  => 0.1736429922,
								   tr_id_per_addr_i = 8  => 0.183633955,
								   tr_id_per_addr_i = 9  => 0.1935611558,
								   tr_id_per_addr_i = 10 => 0.2102718321,
															0.1648916636);

		td_id_per_addr_i_m :=  map(td_id_per_addr_i = 1 => 0.2240853659,
								   td_id_per_addr_i = 2 => 0.2658682635,
								   td_id_per_addr_i = 3 => 0.2742537313,
								   td_id_per_addr_i = 4 => 0.345323741,
								   td_id_per_addr_i = 5 => 0.3471849866,
														   0.2826236264);

		kw_id_per_addr_i_m :=  map(kw_id_per_addr_i = 1 => 0.0105695831,
								   kw_id_per_addr_i = 2 => 0.0114560456,
								   kw_id_per_addr_i = 3 => 0.0142579391,
								   kw_id_per_addr_i = 4 => 0.0180236172,
								   kw_id_per_addr_i = 5 => 0.024165421,
								   kw_id_per_addr_i = 6 => 0.0337711069,
								   kw_id_per_addr_i = 7 => 0.0466367713,
														   0.0168450144);

		kr_id_per_addr_i_m :=  map(kr_id_per_addr_i = 1 => 0.0409586057,
								   kr_id_per_addr_i = 2 => 0.0636283446,
								   kr_id_per_addr_i = 3 => 0.077852349,
								   kr_id_per_addr_i = 4 => 0.0911468813,
								   kr_id_per_addr_i = 5 => 0.109496865,
														   0.0738567382);

		ko_id_per_addr_i_m :=  map(ko_id_per_addr_i = 1 => 0.0245413534,
								   ko_id_per_addr_i = 2 => 0.033543264,
								   ko_id_per_addr_i = 3 => 0.0448250729,
								   ko_id_per_addr_i = 4 => 0.0493510005,
								   ko_id_per_addr_i = 5 => 0.0660377358,
								   ko_id_per_addr_i = 6 => 0.0819901892,
														   0.0400722815);

		kd_id_per_addr_i_m :=  map(kd_id_per_addr_i = 1 => 0.0490114174,
								   kd_id_per_addr_i = 2 => 0.067100651,
								   kd_id_per_addr_i = 3 => 0.0864594498,
								   kd_id_per_addr_i = 4 => 0.0998636673,
								   kd_id_per_addr_i = 5 => 0.124464487,
								   kd_id_per_addr_i = 6 => 0.1484480432,
														   0.0888497828);

		nw_id_per_addr_c6_risk_m :=  map(nw_id_per_addr_c6_risk = 1 => 0.0377099549,
										 nw_id_per_addr_c6_risk = 2 => 0.0542325743,
										 nw_id_per_addr_c6_risk = 3 => 0.0899100899,
										 nw_id_per_addr_c6_risk = 4 => 0.0953101362,
																	   0.0454092314);

		nr_id_per_addr_c6_i_m :=  map(nr_id_per_addr_c6_i = 1 => 0.1244736998,
									  nr_id_per_addr_c6_i = 2 => 0.141328788,
									  nr_id_per_addr_c6_i = 3 => 0.1913784936,
									  nr_id_per_addr_c6_i = 4 => 0.2,
									  nr_id_per_addr_c6_i = 5 => 0.2260869565,
																 0.1393020235);

		no_id_per_addr_c6_i_m :=  map(no_id_per_addr_c6_i = 1 => 0.0719740634,
									  no_id_per_addr_c6_i = 2 => 0.0857017927,
									  no_id_per_addr_c6_i = 3 => 0.1110056926,
									  no_id_per_addr_c6_i = 4 => 0.1592356688,
									  no_id_per_addr_c6_i = 5 => 0.1649484536,
																 0.0846952932);

		tw_id_per_addr_c6_i_m :=  map(tw_id_per_addr_c6_i = 1 => 0.0626017278,
									  tw_id_per_addr_c6_i = 2 => 0.0864117168,
									  tw_id_per_addr_c6_i = 3 => 0.1154889365,
									  tw_id_per_addr_c6_i = 4 => 0.1428571429,
									  tw_id_per_addr_c6_i = 5 => 0.1801075269,
																 0.0809599472);

		to_id_per_addr_c6_i_m :=  map(to_id_per_addr_c6_i = 1 => 0.1113350476,
									  to_id_per_addr_c6_i = 2 => 0.1505517796,
									  to_id_per_addr_c6_i = 3 => 0.1890794224,
									  to_id_per_addr_c6_i = 4 => 0.2005457026,
									  to_id_per_addr_c6_i = 5 => 0.2204408818,
									  to_id_per_addr_c6_i = 6 => 0.2506265664,
																 0.1435126764);

		tr_id_per_addr_c6_i_m :=  map(tr_id_per_addr_c6_i = 1 => 0.1348216513,
									  tr_id_per_addr_c6_i = 2 => 0.1817340026,
									  tr_id_per_addr_c6_i = 3 => 0.2053554228,
									  tr_id_per_addr_c6_i = 4 => 0.2147666068,
									  tr_id_per_addr_c6_i = 5 => 0.2183544304,
									  tr_id_per_addr_c6_i = 6 => 0.2291296625,
									  tr_id_per_addr_c6_i = 7 => 0.2530120482,
																 0.1648916636);

		td_id_per_addr_c6_i_m :=  map(td_id_per_addr_c6_i = 1 => 0.2681003584,
									  td_id_per_addr_c6_i = 2 => 0.2773480663,
									  td_id_per_addr_c6_i = 3 => 0.2820512821,
									  td_id_per_addr_c6_i = 4 => 0.3529411765,
									  td_id_per_addr_c6_i = 5 => 0.4466019417,
																 0.2826236264);

		kr_id_per_addr_c6_i_m :=  map(kr_id_per_addr_c6_i = 1 => 0.0624239117,
									  kr_id_per_addr_c6_i = 2 => 0.0939708481,
									  kr_id_per_addr_c6_i = 3 => 0.1082125604,
									  kr_id_per_addr_c6_i = 4 => 0.1539589443,
																 0.0738567382);

		ko_id_per_addr_c6_i_m :=  map(ko_id_per_addr_c6_i = 1 => 0.0319628512,
									  ko_id_per_addr_c6_i = 2 => 0.0540129327,
									  ko_id_per_addr_c6_i = 3 => 0.0666666667,
									  ko_id_per_addr_c6_i = 4 => 0.0989810771,
									  ko_id_per_addr_c6_i = 5 => 0.1067961165,
																 0.0400722815);

		kd_id_per_addr_c6_i_m :=  map(kd_id_per_addr_c6_i = 1 => 0.0761914826,
									  kd_id_per_addr_c6_i = 2 => 0.1139806666,
									  kd_id_per_addr_c6_i = 3 => 0.1534391534,
									  kd_id_per_addr_c6_i = 4 => 0.1901408451,
																 0.0888497828);

		nw_phones_per_addr_risk_m :=  map(nw_phones_per_addr_risk = 1 => 0.0394896719,
										  nw_phones_per_addr_risk = 2 => 0.0563135985,
										  nw_phones_per_addr_risk = 3 => 0.0631127451,
																		 0.0454092314);

		no_phones_per_addr_i_m :=  map(no_phones_per_addr_i = 1 => 0.0738300161,
									   no_phones_per_addr_i = 2 => 0.0938506244,
									   no_phones_per_addr_i = 3 => 0.1078028747,
																   0.0846952932);

		to_phones_per_addr_i_m :=  map(to_phones_per_addr_i = 1 => 0.1281699299,
									   to_phones_per_addr_i = 2 => 0.1503759398,
									   to_phones_per_addr_i = 3 => 0.1802990325,
																   0.1435126764);

		ko_phones_per_addr_i_m :=  map(ko_phones_per_addr_i = 1 => 0.0313938887,
									   ko_phones_per_addr_i = 2 => 0.0486925158,
									   ko_phones_per_addr_i = 3 => 0.0554174067,
																   0.0400722815);

		tw_years_add1_first_seen_i_m :=  map(tw_years_add1_first_seen_i = -1 => 0.0762942779,
											 tw_years_add1_first_seen_i = 1  => 0.0505434783,
											 tw_years_add1_first_seen_i = 2  => 0.0711305518,
											 tw_years_add1_first_seen_i = 3  => 0.1053400083,
											 tw_years_add1_first_seen_i = 4  => 0.1188251001,
																				0.0809599472);

		to_months_add1_first_seen_i_m :=  map(to_months_add1_first_seen_i = 1 => 0.0592105263,
											  to_months_add1_first_seen_i = 2 => 0.1250175193,
											  to_months_add1_first_seen_i = 3 => 0.1328609389,
											  to_months_add1_first_seen_i = 4 => 0.1791952895,
																				 0.1435126764);

		tr_months_add1_first_seen_i_m :=  map(tr_months_add1_first_seen_i = 1 => 0.1178529755,
											  tr_months_add1_first_seen_i = 2 => 0.1448453268,
											  tr_months_add1_first_seen_i = 3 => 0.1455554331,
											  tr_months_add1_first_seen_i = 4 => 0.1755761091,
											  tr_months_add1_first_seen_i = 5 => 0.1968404561,
																				 0.1648916636);

		kd_months_add1_first_seen_i_m :=  map(kd_months_add1_first_seen_i = -1  => 0.1917808219,
											  kd_months_add1_first_seen_i = 4   => 0.1920808762,
											  kd_months_add1_first_seen_i = 9   => 0.1408987053,
											  kd_months_add1_first_seen_i = 20  => 0.1199850019,
											  kd_months_add1_first_seen_i = 46  => 0.0971062342,
											  kd_months_add1_first_seen_i = 94  => 0.0711766592,
											  kd_months_add1_first_seen_i = 180 => 0.0614705383,
											  kd_months_add1_first_seen_i = 240 => 0.0436170213,
											  kd_months_add1_first_seen_i = 241 => 0.0410858401,
																				   0.0888497828);

		tw_addr_stability_m :=  map(tw_addr_stability = -1 => 0.0930232558,
									tw_addr_stability = 1  => 0.1408094435,
									tw_addr_stability = 2  => 0.10286891,
									tw_addr_stability = 3  => 0.0666042374,
															  0.0809599472);

		kw_addr_stability_m :=  map(kw_addr_stability = -1 => 0.024911032,
									kw_addr_stability = 1  => 0.0082096621,
									kw_addr_stability = 2  => 0.013242597,
									kw_addr_stability = 3  => 0.0209741522,
									kw_addr_stability = 4  => 0.0466830467,
															  0.0168450144);

		kr_addr_stability_m :=  map(kr_addr_stability = 1 => 0.0288484848,
									kr_addr_stability = 2 => 0.0557484174,
									kr_addr_stability = 3 => 0.0689109806,
									kr_addr_stability = 4 => 0.0926711084,
									kr_addr_stability = 5 => 0.1095238095,
															 0.0738567382);

		kd_addr_stability_m :=  map(kd_addr_stability = 1 => 0.0408163265,
									kd_addr_stability = 2 => 0.0701785089,
									kd_addr_stability = 3 => 0.0892116183,
									kd_addr_stability = 4 => 0.1237953304,
															 0.0888497828);

		tr_age_i_m :=  map(tr_age_i = -1 => 0.1588895646,
						   tr_age_i = 1  => 0.104793757,
						   tr_age_i = 2  => 0.1395848246,
						   tr_age_i = 3  => 0.1759213759,
						   tr_age_i = 4  => 0.1867547239,
						   tr_age_i = 5  => 0.2089456869,
						   tr_age_i = 6  => 0.2699564586,
											0.1648916636);

		kw_age_i_m :=  map(kw_age_i = 27 => 0.0568050081,
						   kw_age_i = 31 => 0.031964657,
						   kw_age_i = 35 => 0.0267072952,
						   kw_age_i = 39 => 0.0240358501,
						   kw_age_i = 47 => 0.0175905888,
						   kw_age_i = 52 => 0.013241565,
						   kw_age_i = 59 => 0.0097011797,
						   kw_age_i = 60 => 0.0068038319,
											0.0168450144);

		kr_age_i_m :=  map(kr_age_i = 1 => 0.0256731371,
						   kr_age_i = 2 => 0.032597266,
						   kr_age_i = 3 => 0.0442286947,
						   kr_age_i = 4 => 0.0479616307,
						   kr_age_i = 5 => 0.0561904762,
						   kr_age_i = 6 => 0.0637849236,
						   kr_age_i = 7 => 0.1049868766,
						   kr_age_i = 8 => 0.118263188,
										   0.0738567382);

		ko_age_i_m :=  map(ko_age_i = -1 => 0.0823836331,
						   ko_age_i = 1  => 0.0105987612,
						   ko_age_i = 2  => 0.016280526,
						   ko_age_i = 3  => 0.0273133587,
						   ko_age_i = 4  => 0.0380169535,
						   ko_age_i = 5  => 0.0473594549,
						   ko_age_i = 6  => 0.0578063241,
						   ko_age_i = 7  => 0.0886792453,
											0.0400722815);

		kd_age_i_m :=  map(kd_age_i = 25 => 0.2052067381,
						   kd_age_i = 30 => 0.1735880399,
						   kd_age_i = 35 => 0.1418439716,
						   kd_age_i = 45 => 0.104682374,
						   kd_age_i = 50 => 0.0794595832,
						   kd_age_i = 55 => 0.0645078386,
						   kd_age_i = 60 => 0.0506289308,
						   kd_age_i = 61 => 0.0379901961,
											0.0888497828);

		kw_months_credit_first_seen_m :=  map(kw_months_credit_first_seen = 69  => 0.0501373626,
											  kw_months_credit_first_seen = 96  => 0.0365881033,
											  kw_months_credit_first_seen = 123 => 0.0307191064,
											  kw_months_credit_first_seen = 148 => 0.0256058528,
											  kw_months_credit_first_seen = 169 => 0.0245789713,
											  kw_months_credit_first_seen = 190 => 0.0197323656,
											  kw_months_credit_first_seen = 208 => 0.0187336969,
											  kw_months_credit_first_seen = 238 => 0.0126696154,
											  kw_months_credit_first_seen = 276 => 0.0098490611,
											  kw_months_credit_first_seen = 277 => 0.0085410772,
																				   0.0168450144);

		nw_estimated_income_i_m :=  map(nw_estimated_income_i = 1 => 0.0283868278,
										nw_estimated_income_i = 2 => 0.0355996642,
										nw_estimated_income_i = 3 => 0.0404699739,
										nw_estimated_income_i = 4 => 0.0438247012,
										nw_estimated_income_i = 5 => 0.0565895372,
										nw_estimated_income_i = 6 => 0.0607358871,
										nw_estimated_income_i = 7 => 0.0736842105,
										nw_estimated_income_i = 8 => 0.0795482445,
										nw_estimated_income_i = 9 => 0.1217703349,
																	 0.0454092314);

		nr_estimated_income_i_m :=  map(nr_estimated_income_i = 1 => 0.086574655,
										nr_estimated_income_i = 2 => 0.107389575,
										nr_estimated_income_i = 3 => 0.1201263732,
										nr_estimated_income_i = 4 => 0.1212844435,
										nr_estimated_income_i = 5 => 0.1452474691,
										nr_estimated_income_i = 6 => 0.1633157811,
										nr_estimated_income_i = 7 => 0.2587939698,
																	 0.1393020235);

		nd_estimated_income_i_m :=  map(nd_estimated_income_i = 1 => 0.1666666667,
										nd_estimated_income_i = 2 => 0.1842105263,
										nd_estimated_income_i = 3 => 0.2144177449,
										nd_estimated_income_i = 4 => 0.2640264026,
										nd_estimated_income_i = 5 => 0.3275563258,
																	 0.2431761787);

		td_estimated_income_i_m :=  map(td_estimated_income_i = 24000 => 0.3106628242,
										td_estimated_income_i = 38000 => 0.2556561086,
										td_estimated_income_i = 38001 => 0.1979522184,
																		 0.2826236264);

		kr_estimated_income_i_m :=  map(kr_estimated_income_i = 20000 => 0.1232708269,
										kr_estimated_income_i = 22000 => 0.1054577082,
										kr_estimated_income_i = 23000 => 0.0939294504,
										kr_estimated_income_i = 26000 => 0.074028755,
										kr_estimated_income_i = 35000 => 0.0581572642,
										kr_estimated_income_i = 77000 => 0.0536854324,
										kr_estimated_income_i = 77001 => 0.0307328605,
																		 0.0738567382);

		kd_other_risk_i_m :=  map(kd_other_risk_i = 0 => 0.0488744677,
								  kd_other_risk_i = 1 => 0.0826010545,
								  kd_other_risk_i = 2 => 0.1427024425,
														 0.0888497828);

		nw_out_st_region_m :=  map(nw_out_st_region = '1-Midwest '   => 0.0361538957,
								   nw_out_st_region = '2-Northeast ' => 0.0319596994,
								   nw_out_st_region = '3-South '     => 0.0599877784,
								   nw_out_st_region = '4-West '      => 0.0481108642,
																		0.0454092314);

		nw_out_st_i_m :=  map(nw_out_st_i = 1 => 0.0240823635,
							  nw_out_st_i = 2 => 0.045139436,
							  nw_out_st_i = 3 => 0.0496949489,
												 0.0454092314);

		nr_out_st_i_m :=  map(nr_out_st_i = 1 => 0.0706871868,
							  nr_out_st_i = 2 => 0.1249135973,
							  nr_out_st_i = 3 => 0.1558255004,
												 0.1393020235);

		no_out_st_region_i_m :=  map(no_out_st_region_i = 1 => 0.0717173034,
									 no_out_st_region_i = 2 => 0.0813820674,
									 no_out_st_region_i = 3 => 0.1043591898,
															   0.0846952932);

		no_out_st_i_m :=  map(no_out_st_i = 1 => 0.0516906335,
							  no_out_st_i = 2 => 0.0760125499,
							  no_out_st_i = 3 => 0.1059910943,
												 0.0846952932);

		nd_out_st_i_m :=  map(nd_out_st_i = 1 => 0.1162790698,
							  nd_out_st_i = 2 => 0.1958997722,
							  nd_out_st_i = 3 => 0.2685576343,
							  nd_out_st_i = 4 => 0.2990654206,
												 0.2431761787);

		tw_out_st_i_m :=  map(tw_out_st_i = 1 => 0.0628195763,
							  tw_out_st_i = 2 => 0.0806979856,
							  tw_out_st_i = 3 => 0.1066606661,
												 0.0809599472);

		tw_wealth_index_m :=  map(tw_wealth_index = -1 => 0.0748042911,
								  tw_wealth_index = 1  => 0.1399153738,
								  tw_wealth_index = 2  => 0.11876912,
								  tw_wealth_index = 3  => 0.0838976378,
								  tw_wealth_index = 4  => 0.0615133877,
								  tw_wealth_index = 5  => 0.0489690722,
														  0.0809599472);

		to_out_st_region_m :=  map(to_out_st_region = '1-Midwest '   => 0.1161703977,
								   to_out_st_region = '2-Northeast ' => 0.1091573816,
								   to_out_st_region = '3-South '     => 0.1718967157,
								   to_out_st_region = '4-West '      => 0.1532554791,
																		0.1435126764);

		to_out_st_i_m :=  map(to_out_st_i = 1 => 0.1053589484,
							  to_out_st_i = 2 => 0.1458371793,
							  to_out_st_i = 3 => 0.1484186314,
							  to_out_st_i = 4 => 0.189523249,
												 0.1435126764);

		tr_out_st_region_m :=  map(tr_out_st_region = '1-Midwest '   => 0.1597121306,
								   tr_out_st_region = '2-Northeast ' => 0.1446653658,
								   tr_out_st_region = '3-South '     => 0.1829654294,
								   tr_out_st_region = '4-West '      => 0.1657716224,
																		0.1648916636);

		tr_out_st_i_m :=  map(tr_out_st_i = 1 => 0.1272668913,
							  tr_out_st_i = 2 => 0.1614748887,
							  tr_out_st_i = 3 => 0.1671883276,
							  tr_out_st_i = 4 => 0.2165433759,
												 0.1648916636);

		kw_out_st_i_m :=  map(kw_out_st_i = 1 => 0.0093132994,
							  kw_out_st_i = 2 => 0.0171012553,
							  kw_out_st_i = 3 => 0.023495793,
												 0.0168450144);

		kw_wealth_index_m :=  map(kw_wealth_index = -1 => 0.0115822339,
								  kw_wealth_index = 2  => 0.0238611714,
								  kw_wealth_index = 3  => 0.0216131169,
								  kw_wealth_index = 4  => 0.0172626895,
								  kw_wealth_index = 5  => 0.0156447748,
														  0.0168450144);

		kr_out_st_region_i_m :=  map(kr_out_st_region_i = 1 => 0.059600863,
									 kr_out_st_region_i = 2 => 0.0818527919,
									 kr_out_st_region_i = 3 => 0.0870366777,
															   0.0738567382);

		kr_out_st_i_m :=  map(kr_out_st_i = 1 => 0.0381313131,
							  kr_out_st_i = 2 => 0.0752475248,
							  kr_out_st_i = 3 => 0.0775440457,
							  kr_out_st_i = 4 => 0.1140635126,
												 0.0738567382);

		ko_out_st_region_i_m :=  map(ko_out_st_region_i = 1 => 0.0293884035,
									 ko_out_st_region_i = 2 => 0.0467865677,
									 ko_out_st_region_i = 3 => 0.0488487056,
															   0.0400722815);

		ko_out_st_i_m :=  map(ko_out_st_i = 1 => 0.0242337847,
							  ko_out_st_i = 2 => 0.041244901,
							  ko_out_st_i = 3 => 0.0421647249,
							  ko_out_st_i = 4 => 0.0540897098,
												 0.0400722815);

		kd_out_st_i_m :=  map(kd_out_st_i = 1 => 0.068907563,
							  kd_out_st_i = 2 => 0.0899838379,
							  kd_out_st_i = 3 => 0.1038327526,
												 0.0888497828);

		base := 700;

		odds := (1 / 20);

		point := -40;

		logit :=  map(uv_dy_segment2 = '1d-nohit-derog'  => -8.023375685 +
			(nd_naprop_i_m * 4.7790257403) +
			(nd_add1_avm_med_i_m * 3.325888294) +
			(nd_id_per_addr_i_m * 2.7707337631) +
			(nd_ams_i_m * 5.6873962168) +
			((integer)nd_out_st_division_risk * 0.2481463297) +
			(nd_out_st_i_m * 3.6872541684) +
			((integer)nd_age_risk * 0.9930529294) +
			((integer)attr_total_derog_flag * 0.2798291919) +
			((integer)felony_flag * 0.4758181274) +
			((integer)impulse_flag * 1.3939671064) +
			(nd_estimated_income_i_m * 2.0059853917),
					  uv_dy_segment2 = '1a-nohit-owner'  => -10.26483835 +
			(nw_nap_i_m * 6.1873636705) +
			(nw_ams_i_m * 29.887420594) +
			(nw_minor_pos_source_f * -0.367884794) +
			(nw_years_add1_purchase_date_i_m * 11.351108975) +
			(nw_years_add1_avm_recording_i_m * 8.1996964689) +
			(nw_add1_avm_sales_price_i_m * 6.6528733773) +
			(nw_add1_assessed_value_i_m * 7.9969582429) +
			(nw_add1_avm_valuation_i_m * 5.0152300449) +
			(nw_addrs_per_ssn_risk_m * 14.796511796) +
			(nw_id_per_addr_risk_m * 11.071008278) +
			(nw_phones_per_addr_risk_m * 4.4184467128) +
			(nw_id_per_addr_c6_risk_m * 7.9515088677) +
			(nw_add1_building_area_i_m * 7.1221329299) +
			(nw_out_st_region_m * 12.724551355) +
			(nw_out_st_i_m * 13.278972239) +
			((integer)nw_other_risk * 0.4297735827) +
			(nw_estimated_income_i_m * 3.9855019882),
					  uv_dy_segment2 = '1c-nohit-renter' => -8.688142802 +
			(nr_minor_pos_source_f * -0.993290431) +
			((integer)nr_phone_notpots * 0.3936671082) +
			(nr_years_add1_avm_recording_i_m * 1.8776403081) +
			(nr_add1_avm_sales_price_i_m * 1.5811540439) +
			(nr_add1_assessed_value_i_m * 1.9923241866) +
			(nr_add1_avm_med_i_m * 3.9210973959) +
			(nr_add1_building_area_i_m * 1.8878062257) +
			((integer)nw_adlperssn_risk * 0.1478158091) +
			(nr_addrs_per_ssn_i_m * 4.6677637221) +
			(nr_id_per_addr_i_m * 6.0263690201) +
			(nr_id_per_addr_c6_i_m * 4.0504277834) +
			(nr_ams_i_m * 12.738801163) +
			((integer)nr_other_risk * 0.5392693214) +
			(nr_out_st_i_m * 6.1979885551) +
			(nr_estimated_income_i_m * 3.0810333467),
					  uv_dy_segment2 = '1b-nohit-other'  => -9.062712292 +
			(nr_minor_pos_source_f * -0.553109556) +
			(no_rc_dirsaddr_lastscore_i_m * 6.4398633162) +
			(no_add1_avm_med_i_m * 6.3768081041) +
			(no_addrs_per_ssn_i_m * 7.6894738793) +
			(no_id_per_addr_i_m * 6.6144749838) +
			(no_phones_per_addr_i_m * 7.0041414928) +
			(no_id_per_addr_c6_i_m * 2.9193406974) +
			(no_ams_i_m * 14.47992829) +
			(no_out_st_region_i_m * 7.2580496382) +
			(no_out_st_i_m * 6.4295960937) +
			((integer)no_other_risk * 0.6681937365) +
			((integer)no_age_risk * 0.9086925137),
					  uv_dy_segment2 = '2d-thin-derog'   => -7.907529785 +
			(td_naprop_i_m * 3.9604912581) +
			(td_id_per_addr_i_m * 3.3785885486) +
			(td_id_per_addr_c6_i_m * 2.9476378181) +
			(td_ams_i_m * 6.2403146478) +
			(td_ams_income_level_i_m * 2.7309880257) +
			((integer)td_out_st_good * -0.351548616) +
			((integer)td_other_risk * 0.3831964747) +
			(td_estimated_income_i_m * 3.5193707925) +
			((integer)attr_total_derog_flag * 0.4456441367) +
			((integer)felony_flag * 0.395090061),
					  uv_dy_segment2 = '2a-thin-owner'   => -10.46718836 +
			((integer)rc_phoneaddr_lname_flag * -0.117029697) +
			(tw_minor_pos_source_f * -0.493039001) +
			((integer)source_tot_voter * -0.176237257) +
			(tw_naprop_i_m * 5.8451443259) +
			((integer)tw_phone_risk * 0.6343151213) +
			(tw_years_add1_purchase_date_i_m * 7.9740868837) +
			(tw_years_add1_avm_recording_i_m * 4.8932723603) +
			(tw_add1_avm_sales_price_i_m * 5.2273664803) +
			(tw_add1_assessed_value_i_m * 4.0814513175) +
			(tw_add1_avm_valuation_i_m * 1.7776331301) +
			(tw_add1_avm_med_i_m * 5.8204015175) +
			(tw_add1_building_area_i_m * 4.9813904725) +
			(tw_addrs_per_ssn_i_m * 7.5905882424) +
			(tw_id_per_addr_i_m * 8.0040896021) +
			(tw_id_per_addr_c6_i_m * 4.2498604811) +
			(tw_ams_i_m * 13.696461718) +
			(tw_ams_income_level_i_m * 4.5701560793) +
			(tw_out_st_i_m * 8.2306032588) +
			((integer)tw_other_risk * 0.4772754346) +
			(tw_years_add1_first_seen_i_m * 4.7134099997) +
			(tw_wealth_index_m * 2.9357059624) +
			(tw_addr_stability_m * 2.5389702448),
					  uv_dy_segment2 = '2c-thin-renter'  => -9.19654924 +
			((integer)rc_phoneaddr_lname_flag * -0.075878717) +
			(tr_minor_pos_source_f * -0.744613222) +
			((integer)to_phone_risk * 0.41923297) +
			(tr_add1_avm_valuation_i_m * 1.1310242453) +
			(tr_add1_assessed_value_i_m * 1.5139136216) +
			(tr_add1_avm_med_i_m * 4.5716466164) +
			(tr_add1_building_area_i_m * 2.0946835571) +
			(tr_adlperssn_i_m * 4.9019118319) +
			(tr_id_per_addr_i_m * 4.371293636) +
			(tr_id_per_addr_c6_i_m * 2.4847481247) +
			((integer)tr_ams_good * -1.344263741) +
			(tr_ams_income_level_i_m * 4.7820247542) +
			(tr_out_st_region_m * 3.0942464616) +
			(tr_out_st_i_m * 5.1299360912) +
			((integer)tr_other_risk * 0.4529400635) +
			(tr_age_i_m * 5.5379969335) +
			(tr_months_add1_first_seen_i_m * 5.6986941411),
					  uv_dy_segment2 = '2b-thin-other'   => -10.49020349 +
			(to_minor_pos_source_f * -0.67084276) +
			(to_rc_dirsaddr_lastscore_i_m * 4.044709841) +
			((integer)to_phone_risk * 0.3681317815) +
			(to_add1_avm_med_i_m * 6.2094777911) +
			(to_adlperssn_i_m * 2.5155948889) +
			(to_addrs_per_ssn_i_m * 3.1150994982) +
			(to_id_per_addr_i_m * 4.4130013733) +
			(to_phones_per_addr_i_m * 4.196905553) +
			(to_id_per_addr_c6_i_m * 3.5120408235) +
			(to_ams_i_m * 8.0493372953) +
			(to_ams_income_level_i_m * 4.1990201514) +
			(to_out_st_region_m * 6.3935622027) +
			(to_out_st_i_m * 6.1139239973) +
			((integer)to_other_risk * 0.5052249906) +
			((integer)to_age_risk * 0.4090893288) +
			(to_months_add1_first_seen_i_m * 3.7519733204),
					  uv_dy_segment2 = '3d-thick-derog'  => -1.886948446 +
			(kd_nap_i_m * 3.120165081) +
			(kd_rc_numelever_i_m * 1.3116344017) +
			(kd_minor_pos_source_f * -0.485014039) +
			((integer)source_tot_voter * -0.21845672) +
			(kd_naprop_i_m * 2.2178276817) +
			(kd_add1_avm_med_i_m * 5.8872318375) +
			(kd_id_per_addr_i_m * 5.5202723549) +
			(kd_id_per_addr_c6_i_m * 4.4638716931) +
			((integer)ko_ams_good * -1.072247798) +
			(kd_ams_income_level_i_m * 4.4420935717) +
			(kd_out_st_i_m * 15.575948449) +
			(kd_other_risk_i_m * 4.6693893985) +
			(kd_age_i_m * 2.9314116265) +
			(kd_months_add1_first_seen_i_m * 2.9303271059) +
			(kd_addr_stability_m * 6.202400463) +
			(kd_estimated_income * -0.537067341),
					  uv_dy_segment2 = '3a-thick-owner'  => -9.6269867 +
			((integer)kw_nap_good * -0.375448619) +
			(kw_rc_numelever_i_m * 10.297271986) +
			(kw_minor_pos_source_f * -0.165351416) +
			((integer)source_tot_voter * -0.242136592) +
			((integer)kw_add1_naprop_good * -0.246872175) +
			(kw_rc_dirsaddr_lastscore_i_m * 8.6908835451) +
			(kw_years_add1_purchase_date_i_m * 37.339646064) +
			(kw_years_add1_avm_recording_i_m * 8.6908976504) +
			(kw_add1_avm_valuation_i_m * 26.881331006) +
			(kw_add1_avm_med_i_m * 20.72359962) +
			(kw_add1_building_area_i_m * 19.770925921) +
			(kw_id_per_addr_i_m * 21.85962503) +
			((integer)ko_ams_good * -0.750466322) +
			(kw_ams_income_level_i_m * 24.640580652) +
			(kw_out_st_i_m * 56.929285446) +
			((integer)kw_other_risk * 0.3413767732) +
			(kw_age_i_m * 8.3798220075) +
			(kw_months_credit_first_seen_m * 11.421605906) +
			(kw_wealth_index_m * 45.306974983) +
			(kw_addr_stability_m * 26.252986697),
					  uv_dy_segment2 = '3c-thick-renter' => -9.59373367 +
			(kr_minor_pos_source_f * -0.678098891) +
			((integer)source_tot_voter * -0.177217985) +
			(kr_rc_dirsaddr_lastscore_i_m * 5.9104961425) +
			(kr_add1_assessed_value_i_m * 5.6540118298) +
			(kr_add1_avm_med_i_m * 7.3492677423) +
			(kr_adlperssn_i_m * 11.087408843) +
			(kr_id_per_addr_i_m * 7.5938284504) +
			(kr_id_per_addr_c6_i_m * 6.0903493032) +
			((integer)ko_ams_good * -1.059690961) +
			(kr_ams_income_level_i_m * 9.3016853521) +
			(kr_out_st_region_i_m * 7.5522751042) +
			(kr_out_st_i_m * 9.9546867184) +
			((integer)kr_other_risk * 0.5025499034) +
			(kr_age_i_m * 6.2501365569) +
			(kr_addr_stability_m * 10.430688629) +
			(kr_estimated_income_i_m * 7.2035539422),
															1.5217400255 +
			(ko_nap_i_m * 10.564004105) +
			(ko_minor_pos_source_f * -0.603716586) +
			(ko_add1_avm_med_i_m * 12.165229251) +
			(ko_add1_building_area_i_m * 11.913895677) +
			(ko_id_per_addr_i_m * 11.140714705) +
			(ko_phones_per_addr_i_m * 10.496083226) +
			(ko_id_per_addr_c6_i_m * 5.2337865458) +
			((integer)ko_ams_good * -0.963244222) +
			(ko_ams_income_level_i_m * 14.27554437) +
			(ko_out_st_region_i_m * 18.765390711) +
			(ko_out_st_i_m * 24.61439962) +
			((integer)ko_other_risk * 0.5874918508) +
			(ko_age_i_m * 11.495181579) +
			(ko_months_add1_date_first_seen * -0.232709271) +
			(ko_estimated_income * -0.896563684));
			
			
		phat :=  map(uv_dy_segment2 = '1d-nohit-derog'  => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '1a-nohit-owner'  => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '1c-nohit-renter' => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '1b-nohit-other'  => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '2d-thin-derog'   => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '2a-thin-owner'   => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '2c-thin-renter'  => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '2b-thin-other'   => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '3d-thick-derog'  => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '3a-thick-owner'  => (exp(logit) / (1 + exp(logit))),
					 uv_dy_segment2 = '3c-thick-renter' => (exp(logit) / (1 + exp(logit))),
														   (exp(logit) / (1 + exp(logit))));


		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		thick_renter01_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									 uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									 uv_dy_segment2 = '1c-nohit-renter' => NULL,
									 uv_dy_segment2 = '1b-nohit-other'  => NULL,
									 uv_dy_segment2 = '2d-thin-derog'   => NULL,
									 uv_dy_segment2 = '2a-thin-owner'   => NULL,
									 uv_dy_segment2 = '2c-thin-renter'  => NULL,
									 uv_dy_segment2 = '2b-thin-other'   => NULL,
									 uv_dy_segment2 = '3d-thick-derog'  => NULL,
									 uv_dy_segment2 = '3a-thick-owner'  => NULL,
									 uv_dy_segment2 = '3c-thick-renter' => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
																		   NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		thick_derog03_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									uv_dy_segment2 = '1c-nohit-renter' => NULL,
									uv_dy_segment2 = '1b-nohit-other'  => NULL,
									uv_dy_segment2 = '2d-thin-derog'   => NULL,
									uv_dy_segment2 = '2a-thin-owner'   => NULL,
									uv_dy_segment2 = '2c-thin-renter'  => NULL,
									uv_dy_segment2 = '2b-thin-other'   => NULL,
									uv_dy_segment2 = '3d-thick-derog'  => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
									uv_dy_segment2 = '3a-thick-owner'  => NULL,
									uv_dy_segment2 = '3c-thick-renter' => NULL,
																		  NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		thin_derog01_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
								   uv_dy_segment2 = '1a-nohit-owner'  => NULL,
								   uv_dy_segment2 = '1c-nohit-renter' => NULL,
								   uv_dy_segment2 = '1b-nohit-other'  => NULL,
								   uv_dy_segment2 = '2d-thin-derog'   => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
								   uv_dy_segment2 = '2a-thin-owner'   => NULL,
								   uv_dy_segment2 = '2c-thin-renter'  => NULL,
								   uv_dy_segment2 = '2b-thin-other'   => NULL,
								   uv_dy_segment2 = '3d-thick-derog'  => NULL,
								   uv_dy_segment2 = '3a-thick-owner'  => NULL,
								   uv_dy_segment2 = '3c-thick-renter' => NULL,
																		 NULL);



		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		thick_owner01_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									uv_dy_segment2 = '1c-nohit-renter' => NULL,
									uv_dy_segment2 = '1b-nohit-other'  => NULL,
									uv_dy_segment2 = '2d-thin-derog'   => NULL,
									uv_dy_segment2 = '2a-thin-owner'   => NULL,
									uv_dy_segment2 = '2c-thin-renter'  => NULL,
									uv_dy_segment2 = '2b-thin-other'   => NULL,
									uv_dy_segment2 = '3d-thick-derog'  => NULL,
									uv_dy_segment2 = '3a-thick-owner'  => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
									uv_dy_segment2 = '3c-thick-renter' => NULL,
																		  NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		nohit_derog01d_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
									 uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									 uv_dy_segment2 = '1c-nohit-renter' => NULL,
									 uv_dy_segment2 = '1b-nohit-other'  => NULL,
									 uv_dy_segment2 = '2d-thin-derog'   => NULL,
									 uv_dy_segment2 = '2a-thin-owner'   => NULL,
									 uv_dy_segment2 = '2c-thin-renter'  => NULL,
									 uv_dy_segment2 = '2b-thin-other'   => NULL,
									 uv_dy_segment2 = '3d-thick-derog'  => NULL,
									 uv_dy_segment2 = '3a-thick-owner'  => NULL,
									 uv_dy_segment2 = '3c-thick-renter' => NULL,
																		   NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		nohit_owner05d_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									 uv_dy_segment2 = '1a-nohit-owner'  => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
									 uv_dy_segment2 = '1c-nohit-renter' => NULL,
									 uv_dy_segment2 = '1b-nohit-other'  => NULL,
									 uv_dy_segment2 = '2d-thin-derog'   => NULL,
									 uv_dy_segment2 = '2a-thin-owner'   => NULL,
									 uv_dy_segment2 = '2c-thin-renter'  => NULL,
									 uv_dy_segment2 = '2b-thin-other'   => NULL,
									 uv_dy_segment2 = '3d-thick-derog'  => NULL,
									 uv_dy_segment2 = '3a-thick-owner'  => NULL,
									 uv_dy_segment2 = '3c-thick-renter' => NULL,
																		   NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		nohit_renter02d_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									  uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									  uv_dy_segment2 = '1c-nohit-renter' => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
									  uv_dy_segment2 = '1b-nohit-other'  => NULL,
									  uv_dy_segment2 = '2d-thin-derog'   => NULL,
									  uv_dy_segment2 = '2a-thin-owner'   => NULL,
									  uv_dy_segment2 = '2c-thin-renter'  => NULL,
									  uv_dy_segment2 = '2b-thin-other'   => NULL,
									  uv_dy_segment2 = '3d-thick-derog'  => NULL,
									  uv_dy_segment2 = '3a-thick-owner'  => NULL,
									  uv_dy_segment2 = '3c-thick-renter' => NULL,
																			NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		thin_owner03_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
								   uv_dy_segment2 = '1a-nohit-owner'  => NULL,
								   uv_dy_segment2 = '1c-nohit-renter' => NULL,
								   uv_dy_segment2 = '1b-nohit-other'  => NULL,
								   uv_dy_segment2 = '2d-thin-derog'   => NULL,
								   uv_dy_segment2 = '2a-thin-owner'   => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
								   uv_dy_segment2 = '2c-thin-renter'  => NULL,
								   uv_dy_segment2 = '2b-thin-other'   => NULL,
								   uv_dy_segment2 = '3d-thick-derog'  => NULL,
								   uv_dy_segment2 = '3a-thick-owner'  => NULL,
								   uv_dy_segment2 = '3c-thick-renter' => NULL,
																		 NULL);

		thick_other04_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									uv_dy_segment2 = '1c-nohit-renter' => NULL,
									uv_dy_segment2 = '1b-nohit-other'  => NULL,
									uv_dy_segment2 = '2d-thin-derog'   => NULL,
									uv_dy_segment2 = '2a-thin-owner'   => NULL,
									uv_dy_segment2 = '2c-thin-renter'  => NULL,
									uv_dy_segment2 = '2b-thin-other'   => NULL,
									uv_dy_segment2 = '3d-thick-derog'  => NULL,
									uv_dy_segment2 = '3a-thick-owner'  => NULL,
									uv_dy_segment2 = '3c-thick-renter' => NULL,
																		  round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)));

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		nohit_other06d_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									 uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									 uv_dy_segment2 = '1c-nohit-renter' => NULL,
									 uv_dy_segment2 = '1b-nohit-other'  => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
									 uv_dy_segment2 = '2d-thin-derog'   => NULL,
									 uv_dy_segment2 = '2a-thin-owner'   => NULL,
									 uv_dy_segment2 = '2c-thin-renter'  => NULL,
									 uv_dy_segment2 = '2b-thin-other'   => NULL,
									 uv_dy_segment2 = '3d-thick-derog'  => NULL,
									 uv_dy_segment2 = '3a-thick-owner'  => NULL,
									 uv_dy_segment2 = '3c-thick-renter' => NULL,
																		   NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		thin_other03_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
								   uv_dy_segment2 = '1a-nohit-owner'  => NULL,
								   uv_dy_segment2 = '1c-nohit-renter' => NULL,
								   uv_dy_segment2 = '1b-nohit-other'  => NULL,
								   uv_dy_segment2 = '2d-thin-derog'   => NULL,
								   uv_dy_segment2 = '2a-thin-owner'   => NULL,
								   uv_dy_segment2 = '2c-thin-renter'  => NULL,
								   uv_dy_segment2 = '2b-thin-other'   => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
								   uv_dy_segment2 = '3d-thick-derog'  => NULL,
								   uv_dy_segment2 = '3a-thick-owner'  => NULL,
								   uv_dy_segment2 = '3c-thick-renter' => NULL,
																		 NULL);

		// # warning:  engineer intervention needed -- attribute not assigned in this clause
		thin_renter03_score :=  map(uv_dy_segment2 = '1d-nohit-derog'  => NULL,
									uv_dy_segment2 = '1a-nohit-owner'  => NULL,
									uv_dy_segment2 = '1c-nohit-renter' => NULL,
									uv_dy_segment2 = '1b-nohit-other'  => NULL,
									uv_dy_segment2 = '2d-thin-derog'   => NULL,
									uv_dy_segment2 = '2a-thin-owner'   => NULL,
									uv_dy_segment2 = '2c-thin-renter'  => round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base)),
									uv_dy_segment2 = '2b-thin-other'   => NULL,
									uv_dy_segment2 = '3d-thick-derog'  => NULL,
									uv_dy_segment2 = '3a-thick-owner'  => NULL,
									uv_dy_segment2 = '3c-thick-renter' => NULL,
																		  NULL);

		RVP1003_raw := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));

		uv_rv20_content := ((nas_summary > 4) or ((nap_summary > 4) or (add1_naprop > 2)));

		uv_gong_sourced := (nap_summary in [2, 3, 5, 6, 7, 8, 9, 10, 11, 12]);

		uv_EQ_only := (((integer)source_tot_EQ = 1) and (((integer)source_tot_total = 1) and ((integer)uv_gong_sourced = 0)));

		// uv_RVP1003_content := ((uv_rv20_content or (uv_gong_sourced or (source_tot_EM or (source_tot_VO or (source_tot_P or (source_tot_V or ((add1_naprop > 2) or (prof_license_flag or (((real)add1_avm_land_use != NULL) or ((trim(ams_file_type, LEFT, RIGHT) != '') or ((criminal_count > 0) or ((liens_historical_unreleased_ct > 0) or (source_tot_L2 or (bankrupt or (source_tot_EB or (source_tot_W or ((watercraft_count > 0) or ((if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0) or (((90 <= combo_dobscore) AND (combo_dobscore <= 100)) or (((integer)input_dob_match_level >= 7) or (((integer)combine_lien_flag > 0) or ((criminal_count > 0) or (((integer)bk_flag > 0) or (((integer)rc_decsflag = 1) or (((integer)source_tot_DS = 1) or truedid))))))))))))))))))))))))) and ((integer)uv_EQ_only = 0));
		uv_RVP1003_content := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

		ov_ssndead := (((integer)ssnlength > 0) and ((integer)rc_decsflag = 1));
		ov_ssnprior := (((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1));
		ov_criminal_flag := (criminal_count > 0);
		ov_corrections := ((integer)rc_hrisksic = 2225);
		ov_impulse := (impulse_count > 0);

		rvp1003_cap :=  map(
			(integer)uv_RVP1003_content = 1 or PreScreenOptOut => 222,
			(ov_ssndead or ov_ssnprior or ov_criminal_flag or ov_corrections or ov_impulse) and rvp1003_raw > 700 => 700,
			max(501, min(900, rvp1003_raw ))
		);
		#IF(RVP_DEBUG)
			self.seq := le.seq;
			self.truedid := truedid;
			self.adl_category := adl_category;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_st := out_st;
			self.out_addr_type := out_addr_type;
			self.in_dob := in_dob;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.did_count := did_count;
			self.rc_dirsaddr_lastscore := rc_dirsaddr_lastscore;
			self.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_hriskaddrflag := rc_hriskaddrflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssndobflag := rc_ssndobflag;
			self.rc_pwssndobflag := rc_pwssndobflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_ssnstate := rc_ssnstate;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_sources := rc_sources;
			self.rc_numelever := rc_numelever;
			self.rc_phoneaddr_lnamecount := rc_phoneaddr_lnamecount;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_ziptypeflag := rc_ziptypeflag;
			self.rc_statezipflag := rc_statezipflag;
			self.rc_altlname1_flag := rc_altlname1_flag;
			self.rc_altlname2_flag := rc_altlname2_flag;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_dobscore := combo_dobscore;
			self.combo_addrcount := combo_addrcount;
			self.rc_watchlist_flag := rc_watchlist_flag;
			self.ssnlength := ssnlength;
			self.hphnpop := hphnpop;
			self.lname_eda_sourced := lname_eda_sourced;
			self.age := age;
			self.add1_unit_count := add1_unit_count;
			self.add1_avm_land_use := add1_avm_land_use;
			self.add1_avm_recording_date := add1_avm_recording_date;
			self.add1_avm_sales_price := add1_avm_sales_price;
			self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
			self.add1_avm_market_total_value := add1_avm_market_total_value;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_naprop := add1_naprop;
			self.add1_purchase_date := add1_purchase_date;
			self.add1_mortgage_type := add1_mortgage_type;
			self.add1_assessed_amount := add1_assessed_amount;
			self.add1_date_first_seen := add1_date_first_seen;
			self.add1_building_area := add1_building_area;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.addrs_10yr := addrs_10yr;
			self.telcordia_type := telcordia_type;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.credit_first_seen := credit_first_seen;
			self.addrs_per_adl := addrs_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.addrs_per_ssn := addrs_per_ssn;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.infutor_first_seen := infutor_first_seen;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.attr_num_watercraft60 := attr_num_watercraft60;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.bankrupt := bankrupt;
			self.date_last_seen := date_last_seen;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_recent_released_count := liens_recent_released_count;
			self.liens_historical_released_count := liens_historical_released_count;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.watercraft_count := watercraft_count;
			self.ams_college_code := ams_college_code;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_file_type := ams_file_type;
			self.prof_license_flag := prof_license_flag;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.addr_stability := addr_stability;
			self.archive_date := archive_date;
			self.sysdate := sysdate;
			self.sysyear := sysyear;
			self.in_dob2 := in_dob2;
			self.years_in_dob := years_in_dob;
			self.months_in_dob := months_in_dob;
			self.add1_avm_recording_date2 := add1_avm_recording_date2;
			self.years_add1_avm_recording_date := years_add1_avm_recording_date;
			self.months_add1_avm_recording_date := months_add1_avm_recording_date;
			self.add1_purchase_date2 := add1_purchase_date2;
			self.years_add1_purchase_date := years_add1_purchase_date;
			self.months_add1_purchase_date := months_add1_purchase_date;
			self.add1_date_first_seen2 := add1_date_first_seen2;
			self.years_add1_date_first_seen := years_add1_date_first_seen;
			self.months_add1_date_first_seen := months_add1_date_first_seen;
			self.credit_first_seen2 := credit_first_seen2;
			self.years_credit_first_seen := years_credit_first_seen;
			self.months_credit_first_seen := months_credit_first_seen;
			self.date_last_seen2 := date_last_seen2;
			self.years_date_last_seen := years_date_last_seen;
			self.months_date_last_seen := months_date_last_seen;
			self.infutor_first_seen2 := infutor_first_seen2;
			self.years_infutor_first_seen := years_infutor_first_seen;
			self.months_infutor_first_seen := months_infutor_first_seen;
			self.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
			self.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
			self.months_liens_unrel_cj_last_seen := months_liens_unrel_cj_last_seen;
			self.source_tot_AK := source_tot_AK;
			self.source_tot_AM := source_tot_AM;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_DS := source_tot_DS;
			self.source_tot_EB := source_tot_EB;
			self.source_tot_EM := source_tot_EM;
			self.source_tot_EQ := source_tot_EQ;
			self.source_tot_VO := source_tot_VO;
			self.source_tot_L2 := source_tot_L2;
			self.source_tot_LI := source_tot_LI;
			self.source_tot_P := source_tot_P;
			self.source_tot_PL := source_tot_PL;
			self.source_tot_SL := source_tot_SL;
			self.source_tot_V := source_tot_V;
			self.source_tot_W := source_tot_W;
			self.source_tot_voter := source_tot_voter;
			self.source_tot_total := source_tot_total;
			self.out_st_region := out_st_region;
			self.out_st_division := out_st_division;
			self.out_st_i := out_st_i;
			self.ssnst_region := ssnst_region;
			self.uv_filetype := uv_filetype;
			self.dy_prop_ownership := dy_prop_ownership;
			self.Adl_deceased := Adl_deceased;
			self.rc_deceased := rc_deceased;
			self.combine_deceased_flag := combine_deceased_flag;
			self.bk_flag := bk_flag;
			self.lien_rec_unrel_flag := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag := lien_hist_unrel_flag;
			self.combine_lien_flag := combine_lien_flag;
			self.attr_total_derog_flag := attr_total_derog_flag;
			self.attr_eviction_flag := attr_eviction_flag;
			self.criminal_flag := criminal_flag;
			self.felony_flag := felony_flag;
			self.impulse_flag := impulse_flag;
			self.combine_derog_flag := combine_derog_flag;
			self.uv_dy_segment := uv_dy_segment;
			self.uv_dy_segment2_b1 := uv_dy_segment2_b1;
			self.uv_dy_segment2_b2 := uv_dy_segment2_b2;
			self.uv_dy_segment2_b3 := uv_dy_segment2_b3;
			self.uv_dy_segment2 := uv_dy_segment2;
			self.nw_nap_i := nw_nap_i;
			self.nd_nap_i := nd_nap_i;
			self.ko_nap_i := ko_nap_i;
			self.kd_nap_i := kd_nap_i;
			self.kw_nap_good := kw_nap_good;
			self.kd_rc_numelever_i := kd_rc_numelever_i;
			self.kw_rc_numelever_i := kw_rc_numelever_i;
			self.rc_phoneaddr_lname_flag := rc_phoneaddr_lname_flag;
			self.watercraft_flag := watercraft_flag;
			self.nw_minor_pos_source_f := nw_minor_pos_source_f;
			self.nr_minor_pos_source_f := nr_minor_pos_source_f;
			self.tw_minor_pos_source_f := tw_minor_pos_source_f;
			self.to_minor_pos_source_f := to_minor_pos_source_f;
			self.tr_minor_pos_source_f := tr_minor_pos_source_f;
			self.ko_minor_pos_source_f := ko_minor_pos_source_f;
			self.kr_minor_pos_source_f := kr_minor_pos_source_f;
			self.kd_minor_pos_source_f := kd_minor_pos_source_f;
			self.kw_minor_pos_source_f := kw_minor_pos_source_f;
			self.nd_naprop_i := nd_naprop_i;
			self.tw_naprop_i := tw_naprop_i;
			self.td_naprop_i := td_naprop_i;
			self.kd_naprop_i := kd_naprop_i;
			self.kw_add1_naprop_good := kw_add1_naprop_good;
			self.no_rc_dirsaddr_lastscore_i := no_rc_dirsaddr_lastscore_i;
			self.to_rc_dirsaddr_lastscore_i := to_rc_dirsaddr_lastscore_i;
			self.kr_rc_dirsaddr_lastscore_i := kr_rc_dirsaddr_lastscore_i;
			self.kw_rc_dirsaddr_lastscore_i := kw_rc_dirsaddr_lastscore_i;
			self.tr_rc_dirsaddr_lastscore_i := tr_rc_dirsaddr_lastscore_i;
			self.phn_notpots := phn_notpots;
			self.nr_phone_notpots := nr_phone_notpots;
			self.tw_phone_risk := tw_phone_risk;
			self.to_phone_risk := to_phone_risk;
			self.nw_years_add1_purchase_date_i := nw_years_add1_purchase_date_i;
			self.tw_years_add1_purchase_date_i := tw_years_add1_purchase_date_i;
			self.kw_years_add1_purchase_date_i := kw_years_add1_purchase_date_i;
			self.avm_hit := avm_hit;
			self.nw_years_add1_avm_recording_i := nw_years_add1_avm_recording_i;
			self.nr_years_add1_avm_recording_i := nr_years_add1_avm_recording_i;
			self.tw_years_add1_avm_recording_i := tw_years_add1_avm_recording_i;
			self.kw_years_add1_avm_recording_i := kw_years_add1_avm_recording_i;
			self.add1_avm_med := add1_avm_med;
			self.add1_avm_sales_price_i := add1_avm_sales_price_i;
			self.add1_avm_assessed_value_i := add1_avm_assessed_value_i;
			self.add1_avm_market_value_i := add1_avm_market_value_i;
			self.add1_avm_valuation_i := add1_avm_valuation_i;
			self.add1_avm_med_i := add1_avm_med_i;
			self.add1_assessed_amount_i := add1_assessed_amount_i;
			self.add1_combine_assessed_value_i := add1_combine_assessed_value_i;
			self.nw_add1_avm_sales_price_i := nw_add1_avm_sales_price_i;
			self.nr_add1_avm_sales_price_i := nr_add1_avm_sales_price_i;
			self.tw_add1_avm_sales_price_i := tw_add1_avm_sales_price_i;
			self.nw_add1_assessed_value_i := nw_add1_assessed_value_i;
			self.tr_add1_assessed_value_i := tr_add1_assessed_value_i;
			self.nr_add1_assessed_value_i := nr_add1_assessed_value_i;
			self.tw_add1_assessed_value_i := tw_add1_assessed_value_i;
			self.kr_add1_assessed_value_i := kr_add1_assessed_value_i;
			self.nw_add1_avm_valuation_i := nw_add1_avm_valuation_i;
			self.tw_add1_avm_valuation_i := tw_add1_avm_valuation_i;
			self.tr_add1_avm_valuation_i := tr_add1_avm_valuation_i;
			self.kw_add1_avm_valuation_i := kw_add1_avm_valuation_i;
			self.nw_add1_avm_med_i := nw_add1_avm_med_i;
			self.nr_add1_avm_med_i := nr_add1_avm_med_i;
			self.no_add1_avm_med_i := no_add1_avm_med_i;
			self.nd_add1_avm_med_i := nd_add1_avm_med_i;
			self.tw_add1_avm_med_i := tw_add1_avm_med_i;
			self.to_add1_avm_med_i := to_add1_avm_med_i;
			self.tr_add1_avm_med_i := tr_add1_avm_med_i;
			self.ko_ADD1_AVM_MED_i := ko_ADD1_AVM_MED_i;
			self.kr_add1_avm_med_i := kr_add1_avm_med_i;
			self.kd_add1_avm_med_i := kd_add1_avm_med_i;
			self.kw_add1_avm_med_i := kw_add1_avm_med_i;
			self.add1_building_area_i := add1_building_area_i;
			self.nw_add1_building_area_i := nw_add1_building_area_i;
			self.nr_add1_building_area_i := nr_add1_building_area_i;
			self.tw_add1_building_area_i := tw_add1_building_area_i;
			self.tr_add1_building_area_i := tr_add1_building_area_i;
			self.ko_add1_building_area_i := ko_add1_building_area_i;
			self.kw_add1_building_area_i := kw_add1_building_area_i;
			self.nw_adlperssn_risk := nw_adlperssn_risk;
			self.to_adlperssn_i := to_adlperssn_i;
			self.tr_adlperssn_i := tr_adlperssn_i;
			self.kr_adlperssn_i := kr_adlperssn_i;
			self.nw_addrs_per_ssn_risk := nw_addrs_per_ssn_risk;
			self.nr_addrs_per_ssn_i := nr_addrs_per_ssn_i;
			self.no_addrs_per_ssn_i := no_addrs_per_ssn_i;
			self.tw_addrs_per_ssn_i := tw_addrs_per_ssn_i;
			self.to_addrs_per_ssn_i := to_addrs_per_ssn_i;
			self.id_per_addr := id_per_addr;
			self.nw_id_per_addr_risk := nw_id_per_addr_risk;
			self.nr_id_per_addr_i := nr_id_per_addr_i;
			self.no_id_per_addr_i := no_id_per_addr_i;
			self.nd_id_per_addr_i := nd_id_per_addr_i;
			self.tw_id_per_addr_i := tw_id_per_addr_i;
			self.to_id_per_addr_i := to_id_per_addr_i;
			self.tr_id_per_addr_i := tr_id_per_addr_i;
			self.td_id_per_addr_i := td_id_per_addr_i;
			self.ko_id_per_addr_i := ko_id_per_addr_i;
			self.kr_id_per_addr_i := kr_id_per_addr_i;
			self.kd_id_per_addr_i := kd_id_per_addr_i;
			self.kw_id_per_addr_i := kw_id_per_addr_i;
			self.nw_phones_per_addr_risk := nw_phones_per_addr_risk;
			self.no_phones_per_addr_i := no_phones_per_addr_i;
			self.to_phones_per_addr_i := to_phones_per_addr_i;
			self.ko_phones_per_addr_i := ko_phones_per_addr_i;
			self.id_per_addr_c6 := id_per_addr_c6;
			self.nw_id_per_addr_c6_risk := nw_id_per_addr_c6_risk;
			self.nr_id_per_addr_c6_i := nr_id_per_addr_c6_i;
			self.no_id_per_addr_c6_i := no_id_per_addr_c6_i;
			self.tw_id_per_addr_c6_i := tw_id_per_addr_c6_i;
			self.to_id_per_addr_c6_i := to_id_per_addr_c6_i;
			self.tr_id_per_addr_c6_i := tr_id_per_addr_c6_i;
			self.td_id_per_addr_c6_i := td_id_per_addr_c6_i;
			self.ko_id_per_addr_c6_i := ko_id_per_addr_c6_i;
			self.kr_id_per_addr_c6_i := kr_id_per_addr_c6_i;
			self.kd_id_per_addr_c6_i := kd_id_per_addr_c6_i;
			self.nw_ams_4ycollege := nw_ams_4ycollege;
			self.nw_ams_i := nw_ams_i;
			self.nr_ams_i := nr_ams_i;
			self.no_ams_i := no_ams_i;
			self.nd_ams_i := nd_ams_i;
			self.tw_ams_i := tw_ams_i;
			self.to_ams_i := to_ams_i;
			self.tr_ams_good := tr_ams_good;
			self.td_ams_i := td_ams_i;
			self.ko_ams_good := ko_ams_good;
			self.tw_ams_income_level_i := tw_ams_income_level_i;
			self.to_ams_income_level_i := to_ams_income_level_i;
			self.tr_ams_income_level_i := tr_ams_income_level_i;
			self.td_ams_income_level_i := td_ams_income_level_i;
			self.ko_ams_income_level_i := ko_ams_income_level_i;
			self.kr_ams_income_level_i := kr_ams_income_level_i;
			self.kd_ams_income_level_i := kd_ams_income_level_i;
			self.kw_ams_income_level_i := kw_ams_income_level_i;
			self.nw_out_st_region := nw_out_st_region;
			self.to_out_st_region := to_out_st_region;
			self.tr_out_st_region := tr_out_st_region;
			self.no_out_st_region_i := no_out_st_region_i;
			self.ko_out_st_region_i := ko_out_st_region_i;
			self.kr_out_st_region_i := kr_out_st_region_i;
			self.nd_out_st_division_risk := nd_out_st_division_risk;
			self.nw_out_st_i := nw_out_st_i;
			self.nr_out_st_i := nr_out_st_i;
			self.no_out_st_i := no_out_st_i;
			self.nd_out_st_i := nd_out_st_i;
			self.tw_out_st_i := tw_out_st_i;
			self.to_out_st_i := to_out_st_i;
			self.tr_out_st_i := tr_out_st_i;
			self.td_out_st_good := td_out_st_good;
			self.kd_out_st_i := kd_out_st_i;
			self.kw_out_st_i := kw_out_st_i;
			self.ko_out_st_i := ko_out_st_i;
			self.kr_out_st_i := kr_out_st_i;
			self.nw_other_risk := nw_other_risk;
			self.nr_other_risk := nr_other_risk;
			self.no_other_risk := no_other_risk;
			self.tw_other_risk := tw_other_risk;
			self.to_other_risk := to_other_risk;
			self.tr_other_risk := tr_other_risk;
			self.td_other_risk := td_other_risk;
			self.ko_other_risk := ko_other_risk;
			self.kr_other_risk := kr_other_risk;
			self.kd_other_risk := kd_other_risk;
			self.kd_other_risk_i := kd_other_risk_i;
			self.kw_other_risk := kw_other_risk;
			self.no_age_risk := no_age_risk;
			self.nd_age_risk := nd_age_risk;
			self.to_age_risk := to_age_risk;
			self.tr_age_i := tr_age_i;
			self.ko_age_i := ko_age_i;
			self.kr_age_i := kr_age_i;
			self.kd_age_i := kd_age_i;
			self.kw_age_i := kw_age_i;
			self.tw_years_add1_first_seen_i := tw_years_add1_first_seen_i;
			self.to_months_add1_first_seen_i := to_months_add1_first_seen_i;
			self.tr_months_add1_first_seen_i := tr_months_add1_first_seen_i;
			self.ko_months_add1_date_first_seen := ko_months_add1_date_first_seen;
			self.kd_months_add1_first_seen_i := kd_months_add1_first_seen_i;
			self.kw_months_credit_first_seen := kw_months_credit_first_seen;
			self.tw_wealth_index := tw_wealth_index;
			self.kw_wealth_index := kw_wealth_index;
			self.tw_addr_stability := tw_addr_stability;
			self.kr_addr_stability := kr_addr_stability;
			self.kd_addr_stability := kd_addr_stability;
			self.kw_addr_stability := kw_addr_stability;
			self.pk_wealth_index := pk_wealth_index;
			self.pk_wealth_index_m := pk_wealth_index_m;
			self.wealth_index_cm := wealth_index_cm;
			self.add_apt := add_apt;
			self.adl_category_ord := adl_category_ord;
			self.pk_bk_level := pk_bk_level;
			self.rc_valid_bus_phone := rc_valid_bus_phone;
			self.rc_valid_res_phone := rc_valid_res_phone;
			self.age_rcd := age_rcd;
			self.add1_mortgage_type_ord := add1_mortgage_type_ord;
			self.prof_license_category_ord := prof_license_category_ord;
			self.pk_attr_total_number_derogs := pk_attr_total_number_derogs;
			self.pk_attr_total_number_derogs_2 := pk_attr_total_number_derogs_2;
			self.pk_attr_num_nonderogs90 := pk_attr_num_nonderogs90;
			self.pk_attr_num_nonderogs90_2 := pk_attr_num_nonderogs90_2;
			self.pk_derog_total := pk_derog_total;
			self.pk_derog_total_m := pk_derog_total_m;
			self.add1_avm_automated_valuation_rcd := add1_avm_automated_valuation_rcd;
			self.add1_avm_automated_val_2_rcd := add1_avm_automated_val_2_rcd;
			self.pk_liens_unrel_ot_total_amount := pk_liens_unrel_ot_total_amount;
			self.attr_num_watercraft60_cap := attr_num_watercraft60_cap;
			self.combo_addrcount_cap := combo_addrcount_cap;
			self.gong_did_phone_ct_cap := gong_did_phone_ct_cap;
			self.ams_college_code_mis := ams_college_code_mis;
			self.ams_college_code_cm := ams_college_code_cm;
			self.ams_income_level_code_cm := ams_income_level_code_cm;
			self.unit5 := unit5;
			self.pk_dist_a1toa2 := pk_dist_a1toa2;
			self.pk_dist_a1toa3 := pk_dist_a1toa3;
			self.pk_dist_a2toa3 := pk_dist_a2toa3;
			self.pk_rc_disthphoneaddr := pk_rc_disthphoneaddr;
			self.pk_dist_a1toa2_m := pk_dist_a1toa2_m;
			self.pk_dist_a1toa3_m := pk_dist_a1toa3_m;
			self.pk_dist_a2toa3_m := pk_dist_a2toa3_m;
			self.pk_rc_disthphoneaddr_m := pk_rc_disthphoneaddr_m;
			self.Dist_mod := Dist_mod;
			self.pk_yr_date_last_seen := pk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen := pk_bk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen_m1 := pk_bk_yr_date_last_seen_m1;
			self.pk_yr_liens_unrel_cj_last_seen := pk_yr_liens_unrel_cj_last_seen;
			self.pk2_yr_liens_unrel_cj_last_seen := pk2_yr_liens_unrel_cj_last_seen;
			self.predicted_inc_high := predicted_inc_high;
			self.predicted_inc_low := predicted_inc_low;
			self.pred_inc := pred_inc;
			self.estimated_income := estimated_income;
			self.nw_estimated_income_i := nw_estimated_income_i;
			self.nr_estimated_income_i := nr_estimated_income_i;
			self.nd_estimated_income_i := nd_estimated_income_i;
			self.td_estimated_income_i := td_estimated_income_i;
			self.ko_estimated_income := ko_estimated_income;
			self.kr_estimated_income_i := kr_estimated_income_i;
			self.kd_estimated_income := kd_estimated_income;
			self.nw_nap_i_m := nw_nap_i_m;
			self.ko_nap_i_m := ko_nap_i_m;
			self.kd_nap_i_m := kd_nap_i_m;
			self.no_rc_dirsaddr_lastscore_i_m := no_rc_dirsaddr_lastscore_i_m;
			self.to_rc_dirsaddr_lastscore_i_m := to_rc_dirsaddr_lastscore_i_m;
			self.kw_rc_dirsaddr_lastscore_i_m := kw_rc_dirsaddr_lastscore_i_m;
			self.kr_rc_dirsaddr_lastscore_i_m := kr_rc_dirsaddr_lastscore_i_m;
			self.nd_naprop_i_m := nd_naprop_i_m;
			self.tw_naprop_i_m := tw_naprop_i_m;
			self.td_naprop_i_m := td_naprop_i_m;
			self.kd_naprop_i_m := kd_naprop_i_m;
			self.kw_rc_numelever_i_m := kw_rc_numelever_i_m;
			self.kd_rc_numelever_i_m := kd_rc_numelever_i_m;
			self.tw_ams_income_level_i_m := tw_ams_income_level_i_m;
			self.to_ams_income_level_i_m := to_ams_income_level_i_m;
			self.tr_ams_income_level_i_m := tr_ams_income_level_i_m;
			self.td_ams_income_level_i_m := td_ams_income_level_i_m;
			self.kw_ams_income_level_i_m := kw_ams_income_level_i_m;
			self.kr_ams_income_level_i_m := kr_ams_income_level_i_m;
			self.ko_ams_income_level_i_m := ko_ams_income_level_i_m;
			self.kd_ams_income_level_i_m := kd_ams_income_level_i_m;
			self.nw_ams_i_m := nw_ams_i_m;
			self.nr_ams_i_m := nr_ams_i_m;
			self.no_ams_i_m := no_ams_i_m;
			self.nd_ams_i_m := nd_ams_i_m;
			self.tw_ams_i_m := tw_ams_i_m;
			self.to_ams_i_m := to_ams_i_m;
			self.td_ams_i_m := td_ams_i_m;
			self.nw_add1_assessed_value_i_m := nw_add1_assessed_value_i_m;
			self.nr_add1_assessed_value_i_m := nr_add1_assessed_value_i_m;
			self.tw_add1_assessed_value_i_m := tw_add1_assessed_value_i_m;
			self.tr_add1_assessed_value_i_m := tr_add1_assessed_value_i_m;
			self.kr_add1_assessed_value_i_m := kr_add1_assessed_value_i_m;
			self.nr_add1_avm_med_i_m := nr_add1_avm_med_i_m;
			self.no_add1_avm_med_i_m := no_add1_avm_med_i_m;
			self.nd_add1_avm_med_i_m := nd_add1_avm_med_i_m;
			self.tw_add1_avm_med_i_m := tw_add1_avm_med_i_m;
			self.to_add1_avm_med_i_m := to_add1_avm_med_i_m;
			self.tr_add1_avm_med_i_m := tr_add1_avm_med_i_m;
			self.kw_add1_avm_med_i_m := kw_add1_avm_med_i_m;
			self.kr_add1_avm_med_i_m := kr_add1_avm_med_i_m;
			self.ko_add1_avm_med_i_m := ko_add1_avm_med_i_m;
			self.kd_add1_avm_med_i_m := kd_add1_avm_med_i_m;
			self.nw_add1_avm_sales_price_i_m := nw_add1_avm_sales_price_i_m;
			self.nr_add1_avm_sales_price_i_m := nr_add1_avm_sales_price_i_m;
			self.tw_add1_avm_sales_price_i_m := tw_add1_avm_sales_price_i_m;
			self.nw_add1_avm_valuation_i_m := nw_add1_avm_valuation_i_m;
			self.tw_add1_avm_valuation_i_m := tw_add1_avm_valuation_i_m;
			self.tr_add1_avm_valuation_i_m := tr_add1_avm_valuation_i_m;
			self.kw_add1_avm_valuation_i_m := kw_add1_avm_valuation_i_m;
			self.nw_add1_building_area_i_m := nw_add1_building_area_i_m;
			self.nr_add1_building_area_i_m := nr_add1_building_area_i_m;
			self.tw_add1_building_area_i_m := tw_add1_building_area_i_m;
			self.tr_add1_building_area_i_m := tr_add1_building_area_i_m;
			self.kw_add1_building_area_i_m := kw_add1_building_area_i_m;
			self.ko_add1_building_area_i_m := ko_add1_building_area_i_m;
			self.nw_years_add1_avm_recording_i_m := nw_years_add1_avm_recording_i_m;
			self.nr_years_add1_avm_recording_i_m := nr_years_add1_avm_recording_i_m;
			self.tw_years_add1_avm_recording_i_m := tw_years_add1_avm_recording_i_m;
			self.kw_years_add1_avm_recording_i_m := kw_years_add1_avm_recording_i_m;
			self.nw_years_add1_purchase_date_i_m := nw_years_add1_purchase_date_i_m;
			self.tw_years_add1_purchase_date_i_m := tw_years_add1_purchase_date_i_m;
			self.kw_years_add1_purchase_date_i_m := kw_years_add1_purchase_date_i_m;
			self.nw_addrs_per_ssn_risk_m := nw_addrs_per_ssn_risk_m;
			self.nr_addrs_per_ssn_i_m := nr_addrs_per_ssn_i_m;
			self.no_addrs_per_ssn_i_m := no_addrs_per_ssn_i_m;
			self.tw_addrs_per_ssn_i_m := tw_addrs_per_ssn_i_m;
			self.to_addrs_per_ssn_i_m := to_addrs_per_ssn_i_m;
			self.to_adlperssn_i_m := to_adlperssn_i_m;
			self.tr_adlperssn_i_m := tr_adlperssn_i_m;
			self.kr_adlperssn_i_m := kr_adlperssn_i_m;
			self.nw_id_per_addr_risk_m := nw_id_per_addr_risk_m;
			self.nr_id_per_addr_i_m := nr_id_per_addr_i_m;
			self.no_id_per_addr_i_m := no_id_per_addr_i_m;
			self.nd_id_per_addr_i_m := nd_id_per_addr_i_m;
			self.tw_id_per_addr_i_m := tw_id_per_addr_i_m;
			self.to_id_per_addr_i_m := to_id_per_addr_i_m;
			self.tr_id_per_addr_i_m := tr_id_per_addr_i_m;
			self.td_id_per_addr_i_m := td_id_per_addr_i_m;
			self.kw_id_per_addr_i_m := kw_id_per_addr_i_m;
			self.kr_id_per_addr_i_m := kr_id_per_addr_i_m;
			self.ko_id_per_addr_i_m := ko_id_per_addr_i_m;
			self.kd_id_per_addr_i_m := kd_id_per_addr_i_m;
			self.nw_id_per_addr_c6_risk_m := nw_id_per_addr_c6_risk_m;
			self.nr_id_per_addr_c6_i_m := nr_id_per_addr_c6_i_m;
			self.no_id_per_addr_c6_i_m := no_id_per_addr_c6_i_m;
			self.tw_id_per_addr_c6_i_m := tw_id_per_addr_c6_i_m;
			self.to_id_per_addr_c6_i_m := to_id_per_addr_c6_i_m;
			self.tr_id_per_addr_c6_i_m := tr_id_per_addr_c6_i_m;
			self.td_id_per_addr_c6_i_m := td_id_per_addr_c6_i_m;
			self.kr_id_per_addr_c6_i_m := kr_id_per_addr_c6_i_m;
			self.ko_id_per_addr_c6_i_m := ko_id_per_addr_c6_i_m;
			self.kd_id_per_addr_c6_i_m := kd_id_per_addr_c6_i_m;
			self.nw_phones_per_addr_risk_m := nw_phones_per_addr_risk_m;
			self.no_phones_per_addr_i_m := no_phones_per_addr_i_m;
			self.to_phones_per_addr_i_m := to_phones_per_addr_i_m;
			self.ko_phones_per_addr_i_m := ko_phones_per_addr_i_m;
			self.tw_years_add1_first_seen_i_m := tw_years_add1_first_seen_i_m;
			self.to_months_add1_first_seen_i_m := to_months_add1_first_seen_i_m;
			self.tr_months_add1_first_seen_i_m := tr_months_add1_first_seen_i_m;
			self.kd_months_add1_first_seen_i_m := kd_months_add1_first_seen_i_m;
			self.tw_addr_stability_m := tw_addr_stability_m;
			self.kw_addr_stability_m := kw_addr_stability_m;
			self.kr_addr_stability_m := kr_addr_stability_m;
			self.kd_addr_stability_m := kd_addr_stability_m;
			self.tr_age_i_m := tr_age_i_m;
			self.kw_age_i_m := kw_age_i_m;
			self.kr_age_i_m := kr_age_i_m;
			self.ko_age_i_m := ko_age_i_m;
			self.kd_age_i_m := kd_age_i_m;
			self.kw_months_credit_first_seen_m := kw_months_credit_first_seen_m;
			self.nw_estimated_income_i_m := nw_estimated_income_i_m;
			self.nr_estimated_income_i_m := nr_estimated_income_i_m;
			self.nd_estimated_income_i_m := nd_estimated_income_i_m;
			self.td_estimated_income_i_m := td_estimated_income_i_m;
			self.kr_estimated_income_i_m := kr_estimated_income_i_m;
			self.kd_other_risk_i_m := kd_other_risk_i_m;
			self.nw_out_st_region_m := nw_out_st_region_m;
			self.nw_out_st_i_m := nw_out_st_i_m;
			self.nr_out_st_i_m := nr_out_st_i_m;
			self.no_out_st_region_i_m := no_out_st_region_i_m;
			self.no_out_st_i_m := no_out_st_i_m;
			self.nd_out_st_i_m := nd_out_st_i_m;
			self.tw_out_st_i_m := tw_out_st_i_m;
			self.tw_wealth_index_m := tw_wealth_index_m;
			self.to_out_st_region_m := to_out_st_region_m;
			self.to_out_st_i_m := to_out_st_i_m;
			self.tr_out_st_region_m := tr_out_st_region_m;
			self.tr_out_st_i_m := tr_out_st_i_m;
			self.kw_out_st_i_m := kw_out_st_i_m;
			self.kw_wealth_index_m := kw_wealth_index_m;
			self.kr_out_st_region_i_m := kr_out_st_region_i_m;
			self.kr_out_st_i_m := kr_out_st_i_m;
			self.ko_out_st_region_i_m := ko_out_st_region_i_m;
			self.ko_out_st_i_m := ko_out_st_i_m;
			self.kd_out_st_i_m := kd_out_st_i_m;
			self.logit := logit;
			self.phat := phat;
			self.thick_renter01_score := thick_renter01_score;
			self.thick_derog03_score := thick_derog03_score;
			self.thin_derog01_score := thin_derog01_score;
			self.thick_owner01_score := thick_owner01_score;
			self.nohit_derog01d_score := nohit_derog01d_score;
			self.nohit_owner05d_score := nohit_owner05d_score;
			self.nohit_renter02d_score := nohit_renter02d_score;
			self.thin_owner03_score := thin_owner03_score;
			self.thick_other04_score := thick_other04_score;
			self.nohit_other06d_score := nohit_other06d_score;
			self.thin_other03_score := thin_other03_score;
			self.thin_renter03_score := thin_renter03_score;
			self.RVP1003_raw := RVP1003_raw;
			self.uv_rv20_content := uv_rv20_content;
			self.uv_gong_sourced := uv_gong_sourced;
			self.uv_EQ_only := uv_EQ_only;
			self.uv_RVP1003_content := uv_RVP1003_content;
			self.rvp1003 := NULL; // removed for 222 logic fix during validation
			self.ov_ssndead := ov_ssndead;
			self.ov_ssnprior := ov_ssnprior;
			self.ov_criminal_flag := ov_criminal_flag;
			self.ov_corrections := ov_corrections;
			self.ov_impulse := ov_impulse;
			self.rvp1003_cap := rvp1003_cap;
		#else
			self.seq := le.seq;
			self.score := (string3)rvp1003_cap;

			r := riskwise.reasons( le, PreScreenOptOut:=PreScreenOptOut );
			self.ri := if( r.rc95, r.makeRC('95')); // per Mike Woodberry, this model's reason code list is exclusively rc95
		#end
	end;

	model := project( clam, doModel(left) );
	return model;
end;