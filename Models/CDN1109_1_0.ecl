IMPORT EASI, Business_Risk, ut, RiskWise, RiskWiseFCRA, Risk_Indicators;

EXPORT cdn1109_1_0 (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
										DATASET(Models.Layout_CD_CustomModelInputs) customInputs,
										BOOLEAN IBICID,
										BOOLEAN WantstoSeeBillToShipToDifferenceFlag) := FUNCTION

	MODEL_DEBUG := FALSE;
	
 /************************************************************************************
 * Build Easi census data                                                            *
 ************************************************************************************/

//saving time by using the address input rather than re-clean address
	layout_cd2iPlus := RECORD
		RiskWise.Layout_CD2I;
		string3 county := '';
		string7 geo_blk := '';
		string3 county2 := '';
		string7 geo_blk2 := '';
	END;

	layout_ineasi := record
		layout_cd2iPlus cd2i;
		recordof(EASI.Key_Easi_Census) easi;
		recordof(EASI.Key_Easi_Census) easi2;
	END;
	layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;
		layout_ineasi census;
	END;
	layout_model_in join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		SELF.bs := le;
		SELF.census.easi := ri;	
		self.census.cd2i.county := le.bill_to_out.shell_input.county;
		self.census.cd2i.state := le.bill_to_out.shell_input.st;
		self.census.cd2i.geo_blk := le.bill_to_out.shell_input.geo_blk;
		self.census.cd2i := le;
		self	:= [];
	END;	

	clam_with_bt_easi := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,
				 ATMOST(keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 RiskWise.max_atmost),keep(1));		

	layout_model_in joinEm(clam_with_bt_easi le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.census.easi2 := ri;
		self.census.cd2i.county2 := le.bs.ship_to_out.shell_input.county;
		self.census.cd2i.state := le.bs.ship_to_out.shell_input.st;
		self.census.cd2i.geo_blk2 := le.bs.ship_to_out.shell_input.geo_blk;
		self.census.cd2i := le;
		self := le;
	END;

	clam_with_easi := join(clam_with_bt_easi, Easi.Key_Easi_Census,
				keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				joinEm(left,right),
				left outer,
				ATMOST(keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				RiskWise.max_atmost),keep(1));

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			layout_model_in clam;

			/* Model Input Variables */
			STRING addrscore;
			STRING bb_line_type_header_;
			STRING bb_ship_mode_;
			REAL bb_original_total_amount_;
			INTEGER bb_item_lines_;
			STRING bb_paypal_customer_id_;
			STRING bb_cc_type_;
			STRING pf_raw_avs_code;
			STRING bb_cvv_description_;
			STRING bb_entry_type_;
			STRING tm_device_result_;
			STRING tm_browser_language_;
			STRING tm_proxy_ip_geo_;
			STRING tm_reason_code_;
			INTEGER tm_time_zone_hours_;
			STRING tm_true_ip_geo_;
			REAL tm_policy_score_;
			STRING tm_true_ip_region_;
			INTEGER firstscore;
			INTEGER lastscore;
			STRING bb_marked_for_full_name_h;
			BOOLEAN btst_relatives_in_common;
			STRING efirstscore;
			STRING elastscore;
			BOOLEAN btst_are_relatives;
			BOOLEAN drop_addr_s;
			STRING distaddraddr2;
			BOOLEAN truedid;
			STRING in_state;
			STRING out_unit_desig;
			STRING out_sec_range;
			STRING out_addr_type;
			STRING in_email_address;
			INTEGER nap_summary;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING rc_dwelltype;
			STRING rc_addrcommflag;
			STRING rc_phonetype;
			STRING ver_sources;
			STRING ver_sources_first_seen;
			STRING ver_sources_count;
			QSTRING100 ver_addr_sources;
			BOOLEAN addrpop;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_lres;
			INTEGER dist_a1toa2;
			INTEGER dist_a1toa3;
			INTEGER avg_lres;
			INTEGER max_lres;
			INTEGER addrs_5yr;
			INTEGER addrs_10yr;
			INTEGER addrs_15yr;
			INTEGER avg_mo_per_addr;
			INTEGER addr_count_ge3;
			INTEGER addr_count_ge6;
			INTEGER addr_count_ge10;
			INTEGER hist_addr_match;
			STRING telcordia_type;
			STRING gong_did_first_seen;
			STRING gong_did_last_seen;
			INTEGER gong_did_first_ct;
			INTEGER gong_did_last_ct;
			INTEGER header_first_seen;
			INTEGER header_last_seen;
			INTEGER adls_per_addr;
			INTEGER ssns_per_addr;
			INTEGER adls_per_phone;
			INTEGER adls_per_addr_c6;
			INTEGER ssns_per_addr_c6;
			INTEGER inq_count12;
			INTEGER inq_collection_count12;
			INTEGER inq_auto_count12;
			INTEGER inq_banking_count12;
			INTEGER inq_highriskcredit_count12;
			INTEGER inq_retail_count12;
			INTEGER inq_communications_count12;
			INTEGER inq_ssnsperadl;
			INTEGER inq_addrsperadl;
			INTEGER inq_adlsperaddr;
			INTEGER inq_lnamesperaddr;
			INTEGER infutor_nap;
			INTEGER email_domain_edu_count;
			INTEGER attr_addrs_last30;
			INTEGER attr_addrs_last90;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER criminal_count;
			INTEGER felony_count;
			INTEGER rel_count;
			INTEGER rel_prop_owned_count;
			INTEGER rel_incomeunder50_count;
			INTEGER rel_incomeunder75_count;
			INTEGER rel_incomeunder100_count;
			INTEGER rel_incomeover100_count;
			INTEGER rel_homeunder100_count;
			INTEGER rel_homeunder150_count;
			INTEGER rel_homeunder200_count;
			INTEGER rel_homeunder300_count;
			INTEGER rel_homeunder500_count;
			INTEGER rel_homeover500_count;
			INTEGER rel_educationunder12_count;
			INTEGER rel_educationover12_count;
			INTEGER rel_ageunder30_count;
			INTEGER rel_ageunder40_count;
			INTEGER rel_ageunder50_count;
			INTEGER rel_ageunder60_count;
			INTEGER rel_ageunder70_count;
			INTEGER rel_ageover70_count;
			INTEGER rel_vehicle_owned_count;
			STRING ams_college_code;
			STRING ams_college_type;
			BOOLEAN prof_license_flag;
			STRING addr_stability_v2;
			INTEGER archive_date;
			STRING out_unit_desig_s;
			STRING out_sec_range_s;
			STRING out_addr_type_s;
			INTEGER nas_summary_s;
			INTEGER nap_summary_s;
			STRING rc_hriskaddrflag_s;
			STRING rc_dwelltype_s;
			STRING rc_addrcommflag_s;
			STRING rc_hrisksic_s;
			BOOLEAN addrpop_s;
			STRING add1_advo_address_vacancy_s;
			STRING add1_advo_res_or_business_s;
			BOOLEAN add1_applicant_owned_s;
			BOOLEAN add1_family_owned_s;
			INTEGER add1_naprop_s;
			INTEGER add1_date_last_seen_s;
			INTEGER add1_turnover_1yr_out_s;
			INTEGER property_owned_total_s;
			INTEGER hist_addr_match_s;
			INTEGER header_first_seen_s;
			INTEGER header_last_seen_s;
			INTEGER adls_per_addr_c6_s;
			INTEGER inq_collection_count12_s;
			INTEGER inq_banking_count12_s;
			INTEGER infutor_nap_s;
			INTEGER impulse_count_s;
			STRING email_source_list_s;
			STRING C_BORN_USA;
			STRING C_INCOLLEGE;
			STRING C_LOW_ED_s;
			STRING C_MANY_CARS;
			STRING C_MED_INC;
			STRING C_POP_12_17_P;
			STRING C_POP_18_24_P;
			STRING C_POP_25_34_P;
			STRING C_POP_35_44_P;
			STRING C_POP_45_54_P;
			STRING C_POP_55_64_P;
			STRING C_POP_65_74_P;
			STRING C_POP_6_11_P;
			STRING C_POP_75_84_P;
			STRING C_POP_85P_P;
			STRING C_ROBBERY_s;
			STRING C_RURAL_P;
			STRING C_SPAN_LANG;
			STRING C_SPAN_LANG_s;
			STRING C_UNEMP_s;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			REAL in_population_bad_rate;
			REAL in_sample_bad_rate;
			REAL in_model_offset;
			REAL bt_population_bad_rate;
			REAL bt_sample_bad_rate;
			REAL bt_model_offset;
			REAL st_population_bad_rate;
			REAL st_sample_bad_rate;
			REAL st_model_offset;
			BOOLEAN addr_mismatch;
			STRING eg_segment;
			STRING pf_ship_mode;
			REAL pf_order_amount;
			INTEGER pf_num_items;
			REAL avg_pmt_amt;
			STRING pf_pmt_type;
			INTEGER avs_name_ver_1;
			INTEGER avs_addr_ver_1;
			INTEGER avs_zip5_ver_1;
			INTEGER avs_unvail_1;
			INTEGER avs_no_match_1;
			INTEGER avs_name_ver;
			BOOLEAN avs_unvail;
			BOOLEAN avs_addr_ver;
			BOOLEAN avs_no_match;
			BOOLEAN avs_zip5_ver;
			STRING pf_avs_ver_lvl;
			INTEGER pf_cid_match;
			BOOLEAN valid_tm_account;
			BOOLEAN tm_browser_not_en_f;
			BOOLEAN tm_proxy_geo_not_us_f;
			BOOLEAN tm_bad_reason_code_f;
			BOOLEAN tm_not_us_time_zone_f;
			BOOLEAN tm_true_geo_not_us_f;
			BOOLEAN tm_score_not_zero_f;
			STRING ip_state;
			INTEGER tm_problem_lvl;
			INTEGER state_match_lvl;
			BOOLEAN add_apt;
			INTEGER _header_first_seen;
			INTEGER _header_last_seen;
			INTEGER mos_header_first_seen;
			INTEGER mos_header_last_seen;
			BOOLEAN header_fst_seen_recent;
			BOOLEAN header_lst_seen_recent;
			BOOLEAN contrary_inf;
			BOOLEAN verfst_i;
			BOOLEAN verlst_i;
			BOOLEAN veradd_i;
			BOOLEAN verphn_i;
			BOOLEAN contrary_phn;
			BOOLEAN verfst_p;
			BOOLEAN verlst_p;
			BOOLEAN veradd_p;
			BOOLEAN verphn_p;
			BOOLEAN ver_add;
			BOOLEAN ver_phn;
			BOOLEAN ver_fst;
			BOOLEAN ver_lst;
			BOOLEAN vername_p;
			BOOLEAN vername_i;
			INTEGER ver_name;
			BOOLEAN no_match;
			INTEGER nap_ver_sum;
			INTEGER inf_ver_sum;
			INTEGER _gong_did_first_seen;
			INTEGER _gong_did_last_seen;
			INTEGER mos_since_gong_first_seen;
			INTEGER mos_since_gong_last_seen;
			BOOLEAN phn_last_seen_rec;
			BOOLEAN phn_first_seen_rec;
			BOOLEAN phn_pots;
			BOOLEAN phn_disconnected;
			BOOLEAN phn_inval;
			BOOLEAN phn_nonus;
			BOOLEAN phn_highrisk;
			BOOLEAN phn_notpots;
			BOOLEAN phn_cellpager;
			BOOLEAN phn_business;
			BOOLEAN phn_residential;
			BOOLEAN phn_bad_counts;
			INTEGER rel_income_100plus;
			INTEGER rel_income_75plus;
			INTEGER rel_income_50plus;
			INTEGER rel_income_25plus;
			INTEGER rel_home_500plus;
			INTEGER rel_home_300plus;
			INTEGER rel_home_200plus;
			INTEGER rel_home_150plus;
			INTEGER rel_home_100plus;
			INTEGER rel_home_50plus;
			INTEGER rel_ed_over12;
			INTEGER rel_ed_over8;
			INTEGER rel_age_over70;
			INTEGER rel_age_over60;
			INTEGER rel_age_over50;
			INTEGER rel_age_over40;
			INTEGER rel_age_over30;
			INTEGER rel_age_over20;
			BOOLEAN no_rel_prop;
			BOOLEAN no_rel_inc25;
			BOOLEAN no_rel_ed8;
			BOOLEAN no_rel_ed12;
			BOOLEAN no_rel_vehx;
			BOOLEAN no_rel_age40;
			BOOLEAN no_rel_age30;
			BOOLEAN no_rel_age20;
			REAL cen_pop_gte_85;
			REAL cen_pop_gte_75;
			REAL cen_pop_gte_65;
			REAL cen_pop_gte_55;
			REAL cen_pop_gte_45;
			REAL cen_pop_gte_35;
			REAL cen_pop_gte_25;
			REAL cen_pop_gte_18;
			REAL cen_pop_gte_12;
			REAL cen_pop_gte_6;
			INTEGER eq_date_first_seen;
			INTEGER _eq_date_first_seen;
			INTEGER eq_date_first_seen_mos;
			INTEGER eq_count;
			BOOLEAN eq_sourced;
			BOOLEAN eq_add_not_sourced;
			BOOLEAN cc_payment;
			BOOLEAN credit_sourced;
			BOOLEAN inq_coll;
			BOOLEAN inq_auto;
			BOOLEAN inq_banking;
			BOOLEAN inq_highrisk;
			BOOLEAN inq_comm;
			BOOLEAN many_inquiries;
			BOOLEAN hi_inq_adlsperaddr;
			BOOLEAN moved_1mo;
			BOOLEAN moved_3mo;
			BOOLEAN moved_1yr;
			BOOLEAN moved_2yr;
			BOOLEAN moved_3yr;
			BOOLEAN moved_5yr;
			BOOLEAN moved_10yr;
			BOOLEAN moved_15yr;
			BOOLEAN add1_lres0;
			BOOLEAN avg_lres_low;
			BOOLEAN max_lres_low;
			BOOLEAN avg_mo_per_addr_low;
			BOOLEAN addr_count_ge3_0;
			BOOLEAN addr_count_ge6_0;
			BOOLEAN addr_count_ge10_0;
			BOOLEAN hist_addr_match_0;
			BOOLEAN addr_stability_low;
			INTEGER ids_per_addr_max;
			INTEGER ids_per_addr_max_c6;
			STRING email_domain;
			STRING email_topleveldomain;
			STRING email_secondleveldomain;
			STRING _email_topleveldomain;
			STRING _email_secondleveldomain;
			INTEGER in_avg_pmt_amt;
			INTEGER in_pmt_type_x_amt_lvl_c16;
			INTEGER in_pmt_type_x_amt_lvl_c17;
			INTEGER in_pmt_type_x_amt_lvl_c18;
			INTEGER in_pmt_type_x_amt_lvl_c19;
			INTEGER in_pmt_type_x_amt_lvl_c20;
			INTEGER in_pmt_type_x_amt_lvl;
			INTEGER pf_avs_ver_lvl_num_1;
			INTEGER in_pmt_quality_index;
			REAL in_pmt_quality_index_m;
			INTEGER in_bb_entry_type_lvl;
			REAL in_bb_entry_type_lvl_m;
			BOOLEAN name_match;
			BOOLEAN pf_friends_and_family_f;
			INTEGER in_bb_fandf_lvl_c26;
			INTEGER in_bb_fandf_lvl;
			REAL in_bb_fandf_lvl_m;
			INTEGER in_nap_ver_lvl_c29;
			INTEGER in_nap_ver_lvl_c30;
			INTEGER in_nap_ver_lvl;
			REAL in_nap_ver_lvl_m;
			INTEGER in_phn_prob_lvl;
			REAL in_phn_prob_lvl_m;
			INTEGER in_inq_coll_count12_lvl;
			REAL in_inq_coll_count12_lvl_m;
			INTEGER in_inq_bank_count12_lvl;
			REAL in_inq_bank_count12_lvl_m;
			INTEGER in_inq_addrsperadl_3;
			REAL in_inq_addrsperadl_3_m;
			INTEGER in_inq_lnamesperaddr_5;
			REAL in_inq_lnamesperaddr_5_m;
			INTEGER in_email_name_lvl;
			REAL in_email_name_lvl_m;
			INTEGER in_adls_per_phone_2;
			REAL in_adls_per_phone_2_m;
			INTEGER in_ids_per_addr_max_c6_lvl;
			REAL in_ids_per_addr_max_c6_lvl_m;
			INTEGER in_rel_prob_lvl;
			REAL in_rel_prob_lvl_m;
			INTEGER in_ams_lvl;
			REAL in_ams_lvl_m;
			INTEGER in_tm_ip_problem_lvl;
			REAL in_tm_ip_problem_lvl_m;
			INTEGER in_c_span_lang_lvl;
			REAL in_c_span_lang_lvl_m;
			BOOLEAN in_bb_cc_pmt_not_credit_srcd_f;
			INTEGER in_eq_first_seen_lvl;
			REAL in_eq_first_seen_lvl_m;
			INTEGER in_dist_a1toa2_lvl;
			REAL in_dist_a1toa2_lvl_m;
			INTEGER in_dist_a1toa3_lvl;
			REAL in_dist_a1toa3_lvl_m;
			BOOLEAN in_criminal_f;
			BOOLEAN in_bb_cid_not_match_f;
			REAL in_inq_retail_count12_c;
			REAL in_inq_retail_count12_rt;
			BOOLEAN in_inq_ssnsperadl_f;
			BOOLEAN in_cen_pop_gte_18_hi_f;
			BOOLEAN in_c_med_inc_low_f;
			REAL in_log;
			INTEGER bt_bb_entry_type_lvl;
			REAL bt_bb_entry_type_lvl_m;
			INTEGER bt_bb_pmt_x_avs_lvl;
			REAL bt_bb_pmt_x_avs_lvl_m;
			BOOLEAN bt_bb_cc_pmt_not_credit_srcd_f;
			INTEGER bt_eq_first_seen_lvl;
			REAL bt_eq_first_seen_lvl_m;
			INTEGER bt_verphn_lvl_c67;
			INTEGER bt_verphn_lvl_c68;
			INTEGER bt_verphn_lvl;
			REAL bt_verphn_lvl_m;
			INTEGER bt_inq_type_lvl;
			REAL bt_inq_type_lvl_m;
			INTEGER bt_email_name_lvl;
			REAL bt_email_name_lvl_m;
			INTEGER bt_college_lvl;
			REAL bt_college_lvl_m;
			INTEGER bt_tm_ip_problem_lvl;
			REAL bt_tm_ip_problem_lvl_m;
			INTEGER bt_addr_hist_lvl;
			REAL bt_addr_hist_lvl_m;
			INTEGER bt_ids_per_addr_max_lvl_c81;
			INTEGER bt_ids_per_addr_max_lvl_c82;
			INTEGER bt_ids_per_addr_max_lvl;
			REAL bt_ids_per_addr_max_lvl_m;
			INTEGER bt_c_incollege;
			REAL bt_c_incollege_m;
			INTEGER bt_c_born_usa;
			REAL bt_c_born_usa_m;
			INTEGER bt_c_many_cars;
			REAL bt_c_many_cars_m;
			INTEGER bt_c_span_lang;
			REAL bt_c_span_lang_m;
			BOOLEAN bt_bb_cid_not_match_f;
			REAL bt_bb_avg_pmt_amt_c;
			REAL bt_bb_avg_pmt_amt_rt;
			BOOLEAN bt_bb_next_day_ship_f;
			BOOLEAN bt_adls_per_phone_f;
			REAL bt_log;
			INTEGER st_avg_pmt_amt;
			INTEGER st_pmt_type_x_amt_lvl_c94;
			INTEGER st_pmt_type_x_amt_lvl_1;
			INTEGER st_pmt_type_x_amt_lvl_c96;
			INTEGER st_pmt_type_x_amt_lvl_c97;
			INTEGER st_pmt_type_x_amt_lvl_c98;
			INTEGER st_pmt_type_x_amt_lvl_c99;
			INTEGER st_pmt_type_x_amt_lvl;
			INTEGER pf_avs_ver_lvl_num;
			INTEGER st_pmt_quality_index;
			REAL st_pmt_quality_index_m;
			INTEGER st_are_relatives_lvl;
			REAL st_are_relatives_lvl_m;
			INTEGER st_shipping_lvl;
			REAL st_shipping_lvl_m;
			BOOLEAN contrary_inf_s;
			BOOLEAN verfst_i_s;
			BOOLEAN verlst_i_s;
			BOOLEAN veradd_i_s;
			BOOLEAN verphn_i_s;
			BOOLEAN contrary_phn_s;
			BOOLEAN verfst_p_s;
			BOOLEAN verlst_p_s;
			BOOLEAN veradd_p_s;
			BOOLEAN verphn_p_s;
			BOOLEAN contrary_ssn_s;
			BOOLEAN verfst_s_s;
			BOOLEAN verlst_s_s;
			BOOLEAN veradd_s_s;
			BOOLEAN verssn_s_s;
			BOOLEAN nas_479_s_1;
			BOOLEAN nas_479_s;
			INTEGER _header_first_seen_s;
			INTEGER _header_last_seen_s;
			INTEGER mos_header_first_seen_s;
			INTEGER mos_header_last_seen_s;
			BOOLEAN header_fst_seen_recent_s;
			BOOLEAN header_lst_seen_recent_s;
			BOOLEAN ver_add_s;
			BOOLEAN ver_phn_s;
			BOOLEAN ver_fst_s;
			BOOLEAN ver_lst_s;
			BOOLEAN con_phn_s;
			INTEGER st_verphn_lvl;
			REAL st_verphn_lvl_m;
			INTEGER st_phn_prob_lvl;
			REAL st_phn_prob_lvl_m;
			BOOLEAN vacant_addr_s;
			BOOLEAN add_correction_s;
			BOOLEAN add_apt_s;
			BOOLEAN add_highrisk_s;
			BOOLEAN business_s;
			INTEGER st_addr_prob_lvl_s;
			REAL st_addr_prob_lvl_s_m;
			INTEGER st_inq_coll_combo_lvl;
			REAL st_inq_coll_combo_lvl_m;
			INTEGER st_inq_bank_combo_lvl;
			REAL st_inq_bank_combo_lvl_m;
			INTEGER st_adls_per_addr_c6_combo_lvl;
			REAL st_adls_per_addr_c6_combo_lvl_m;
			INTEGER st_email_domain_lvl;
			REAL st_email_domain_lvl_m;
			INTEGER st_efirstscore_lvl;
			REAL st_efirstscore_lvl_m;
			INTEGER _add1_date_last_seen_s;
			INTEGER mos_add1_date_last_seen_s;
			BOOLEAN seen_recently_s;
			BOOLEAN family_owned_s;
			BOOLEAN app_owned_s;
			BOOLEAN stolen_addr_s;
			BOOLEAN nothing_found_s;
			BOOLEAN property_owner_s;
			INTEGER st_naprop_lvl_s;
			REAL st_naprop_lvl_s_m;
			INTEGER st_c_low_ed_s;
			REAL st_c_low_ed_s_m;
			INTEGER st_c_unemp_s;
			REAL st_c_unemp_s_m;
			INTEGER st_c_robbery_s;
			REAL st_c_robbery_s_m;
			INTEGER st_c_span_lang_s;
			REAL st_c_span_lang_s_m;
			INTEGER st_c_rural_p;
			REAL st_c_rural_p_m;
			INTEGER st_tm_ip_problem_lvl;
			REAL st_tm_ip_problem_lvl_m;
			INTEGER st_hist_addr_match_lvl;
			REAL st_hist_addr_match_lvl_m;
			INTEGER st_distaddraddr2_lvl;
			REAL st_distaddraddr2_lvl_m;
			INTEGER st_add1_turnover_1yr_out_s_lvl;
			REAL st_add1_turnover_1yr_out_s_lvl_m;
			BOOLEAN impulse_email_s;
			BOOLEAN st_impulse_flag_s;
			REAL st_log;
			REAL d0_infutor_nap;
			REAL d0_veradd_p;
			REAL d0_c_span_lang;
			REAL d0_efirstscore;
			REAL d0_elastscore;
			REAL d0_pf_pmt_type;
			REAL d0_pf_ship_mode;
			REAL d0_avs_addr_ver;
			REAL d0_avs_zip5_ver;
			REAL d0_pf_cid_match;
			REAL d0_tm_problem_lvl;
			REAL d0_state_match_lvl;
			REAL d0_avg_pmt_amt;
			REAL d0_rawscore;
			REAL d0_log;
			INTEGER base;
			INTEGER point;
			REAL odds;
			REAL in_phat;
			INTEGER in_score;
			REAL st_phat;
			INTEGER st_score;
			REAL bt_phat;
			INTEGER bt_score;
			REAL d0_phat;
			INTEGER d0_score;
			INTEGER best_buy_refresh;
			INTEGER cdn1109_1_0;
	END;
		Layout_Debug doModel(clam_with_easi le, customInputs ri) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam_with_easi le, customInputs ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	addrscore                        := le.bs.eddo.addrscore;
	bb_line_type_header_             := ri.Line_Type_Header_;
	bb_ship_mode_                    := ri.Ship_Mode_;
	bb_original_total_amount_        := ri.Original_Total_Amount_;
	bb_item_lines_                   := ri.Item_Lines_;
	bb_paypal_customer_id_           := ri.Paypal_Email_Address_;
	bb_cc_type_                      := ri.Payment_Type_;
	pf_raw_avs_code                  := ri.AVS_Code_;
	bb_cvv_description_              := ri.CVV_Description_;
	bb_entry_type_                   := ri.Entry_Type_;
	tm_device_result_                := ri.Device_Result_;
	tm_browser_language_             := ri.Browser_Language_;
	tm_proxy_ip_geo_                 := ri.Proxy_Ip_Geo_;
	tm_reason_code_                  := ri.Reason_Code_;
	tm_time_zone_hours_              := ri.Time_Zone_Hours_;
	tm_true_ip_geo_                  := ri.True_Ip_Geo_;
	tm_policy_score_                 := ri.Policy_Score_;
	tm_true_ip_region_               := ri.True_IP_Region_;
	firstscore                       := (INTEGER)le.bs.eddo.firstscore;
	lastscore                        := (INTEGER)le.bs.eddo.lastscore;
	bb_marked_for_full_name_h        := ri.Marked_For_Full_Name_H_;
	btst_relatives_in_common         := le.bs.eddo.btst_relatives_in_common;
	efirstscore                      := le.bs.eddo.efirstscore;
	elastscore                       := le.bs.eddo.elastscore;
	btst_are_relatives               := le.bs.eddo.btst_are_relatives;
	distaddraddr2                    := le.bs.eddo.distaddraddr2;
	truedid                          := le.bs.Bill_To_Out.truedid;
	in_state                         := le.bs.Bill_To_Out.shell_input.in_state;
	out_unit_desig                   := le.bs.Bill_To_Out.shell_input.unit_desig;
	out_sec_range                    := le.bs.Bill_To_Out.shell_input.sec_range;
	out_addr_type                    := le.bs.Bill_To_Out.shell_input.addr_type;
	in_email_address                 := le.bs.Bill_To_Out.shell_input.email_address;
	nap_summary                      := le.bs.Bill_To_Out.iid.nap_summary;
	rc_hriskphoneflag                := le.bs.Bill_To_Out.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.bs.Bill_To_Out.iid.hphonetypeflag;
	rc_phonevalflag                  := le.bs.Bill_To_Out.iid.phonevalflag;
	rc_hphonevalflag                 := le.bs.Bill_To_Out.iid.hphonevalflag;
	rc_dwelltype                     := le.bs.Bill_To_Out.iid.dwelltype;
	rc_addrcommflag                  := le.bs.Bill_To_Out.iid.addrcommflag;
	rc_phonetype                     := le.bs.Bill_To_Out.iid.phonetype;
	ver_sources                      := le.bs.Bill_To_Out.header_summary.ver_sources;
	ver_sources_first_seen           := le.bs.Bill_To_Out.header_summary.ver_sources_first_seen_date;
	ver_sources_count                := le.bs.Bill_To_Out.header_summary.ver_sources_recordcount;
	ver_addr_sources                 := le.bs.Bill_To_Out.header_summary.ver_addr_sources;
	addrpop                          := le.bs.Bill_To_Out.input_validation.address;
	add1_isbestmatch                 := le.bs.Bill_To_Out.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.bs.Bill_To_Out.lres;
	dist_a1toa2                      := le.bs.Bill_To_Out.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.bs.Bill_To_Out.address_verification.distance_in_2_h2;
	avg_lres                         := le.bs.Bill_To_Out.other_address_info.avg_lres;
	max_lres                         := le.bs.Bill_To_Out.other_address_info.max_lres;
	addrs_5yr                        := le.bs.Bill_To_Out.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.bs.Bill_To_Out.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.bs.Bill_To_Out.other_address_info.addrs_last_15years;
	avg_mo_per_addr                  := le.bs.Bill_To_Out.address_history_summary.avg_mo_per_addr;
	addr_count_ge3                   := le.bs.Bill_To_Out.address_history_summary.addr_count3;
	addr_count_ge6                   := le.bs.Bill_To_Out.address_history_summary.addr_count6;
	addr_count_ge10                  := le.bs.Bill_To_Out.address_history_summary.addr_count10;
	hist_addr_match                  := le.bs.Bill_To_Out.address_history_summary.hist_addr_match;
	telcordia_type                   := le.bs.Bill_To_Out.phone_verification.telcordia_type;
	gong_did_first_seen              := le.bs.Bill_To_Out.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.bs.Bill_To_Out.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_first_ct                := le.bs.Bill_To_Out.phone_verification.gong_did.gong_did_first_ct;
	gong_did_last_ct                 := le.bs.Bill_To_Out.phone_verification.gong_did.gong_did_last_ct;
	header_first_seen                := le.bs.Bill_To_Out.ssn_verification.header_first_seen;
	header_last_seen                 := le.bs.Bill_To_Out.ssn_verification.header_last_seen;
	adls_per_addr                    := le.bs.Bill_To_Out.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.bs.Bill_To_Out.velocity_counters.ssns_per_addr;
	adls_per_phone                   := le.bs.Bill_To_Out.velocity_counters.adls_per_phone;
	adls_per_addr_c6                 := le.bs.Bill_To_Out.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.bs.Bill_To_Out.velocity_counters.ssns_per_addr_created_6months;
	inq_count12                      := le.bs.Bill_To_Out.acc_logs.inquiries.count12;
	inq_collection_count12           := le.bs.Bill_To_Out.acc_logs.collection.count12;
	inq_auto_count12                 := le.bs.Bill_To_Out.acc_logs.auto.count12;
	inq_banking_count12              := le.bs.Bill_To_Out.acc_logs.banking.count12;
	inq_highriskcredit_count12       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count12;
	inq_retail_count12               := le.bs.Bill_To_Out.acc_logs.retail.count12;
	inq_communications_count12       := le.bs.Bill_To_Out.acc_logs.communications.count12;
	inq_ssnsperadl                   := le.bs.Bill_To_Out.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.bs.Bill_To_Out.acc_logs.inquiryaddrsperadl;
	inq_adlsperaddr                  := le.bs.Bill_To_Out.acc_logs.inquiryadlsperaddr;
	inq_lnamesperaddr                := le.bs.Bill_To_Out.acc_logs.inquirylnamesperaddr;
	infutor_nap                      := le.bs.Bill_To_Out.infutor_phone.infutor_nap;
	email_domain_edu_count           := le.bs.Bill_To_Out.email_summary.email_domain_edu_ct;
	attr_addrs_last30                := le.bs.Bill_To_Out.other_address_info.addrs_last30;
	attr_addrs_last90                := le.bs.Bill_To_Out.other_address_info.addrs_last90;
	attr_addrs_last12                := le.bs.Bill_To_Out.other_address_info.addrs_last12;
	attr_addrs_last24                := le.bs.Bill_To_Out.other_address_info.addrs_last24;
	attr_addrs_last36                := le.bs.Bill_To_Out.other_address_info.addrs_last36;
	criminal_count                   := le.bs.Bill_To_Out.bjl.criminal_count;
	felony_count                     := le.bs.Bill_To_Out.bjl.felony_count;
	rel_count                        := le.bs.Bill_To_Out.relatives.relative_count;
	rel_prop_owned_count             := le.bs.Bill_To_Out.relatives.owned.relatives_property_count;
	rel_incomeunder50_count          := le.bs.Bill_To_Out.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.bs.Bill_To_Out.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.bs.Bill_To_Out.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.bs.Bill_To_Out.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.bs.Bill_To_Out.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.bs.Bill_To_Out.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.bs.Bill_To_Out.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.bs.Bill_To_Out.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.bs.Bill_To_Out.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.bs.Bill_To_Out.relatives.relative_homeover500_count;
	rel_educationunder12_count       := le.bs.Bill_To_Out.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.bs.Bill_To_Out.relatives.relative_educationover12_count;
	rel_ageunder30_count             := le.bs.Bill_To_Out.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.bs.Bill_To_Out.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.bs.Bill_To_Out.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.bs.Bill_To_Out.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.bs.Bill_To_Out.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.bs.Bill_To_Out.relatives.relative_ageover70_count;
	rel_vehicle_owned_count          := le.bs.Bill_To_Out.relatives.relative_vehicle_owned_count;
	ams_college_code                 := le.bs.Bill_To_Out.student.college_code;
	ams_college_type                 := le.bs.Bill_To_Out.student.college_type;
	prof_license_flag                := le.bs.Bill_To_Out.professional_license.professional_license_flag;
	addr_stability_v2                := le.bs.Bill_To_Out.addr_stability;
	archive_date                     := IF(le.bs.Bill_To_Out.historydate = 999999, (INTEGER)ut.GetDate[1..6], (INTEGER)le.bs.Bill_To_Out.historydate[1..6]);	
	
	// Bill To EASI Fields
	C_BORN_USA                       := le.census.easi.born_usa;
	C_INCOLLEGE                      := le.census.easi.incollege;
	C_MANY_CARS                      := le.census.easi.many_cars;
	C_MED_INC                        := le.census.easi.med_inc;
	C_POP_12_17_P                    := le.census.easi.pop_12_17_p;
	C_POP_18_24_P                    := le.census.easi.pop_18_24_p;
	C_POP_25_34_P                    := le.census.easi.pop_25_34_p;
	C_POP_35_44_P                    := le.census.easi.pop_35_44_p;
	C_POP_45_54_P                    := le.census.easi.pop_45_54_p;
	C_POP_55_64_P                    := le.census.easi.pop_55_64_p;
	C_POP_65_74_P                    := le.census.easi.pop_65_74_p;
	C_POP_6_11_P                     := le.census.easi.pop_6_11_p;
	C_POP_75_84_P                    := le.census.easi.pop_75_84_p;
	C_POP_85P_P                      := le.census.easi.pop_85p_p;
	C_RURAL_P                        := le.census.easi.rural_p;
	C_SPAN_LANG                      := le.census.easi.span_lang;
	
	// Ship To EASI Fields
	C_LOW_ED_s                       := le.census.easi2.low_ed;
	C_ROBBERY_s                      := le.census.easi2.robbery;
	C_SPAN_LANG_s                    := le.census.easi2.span_lang;
	C_UNEMP_s                        := le.census.easi2.unemp;
	
	// Ship To Fields
	out_unit_desig_s                 := le.bs.Ship_To_Out.shell_input.unit_desig;
	out_sec_range_s                  := le.bs.Ship_To_Out.shell_input.sec_range;
	out_addr_type_s                  := le.bs.Ship_To_Out.shell_input.addr_type;
	nas_summary_s                    := le.bs.Ship_To_Out.iid.nas_summary;
	nap_summary_s                    := le.bs.Ship_To_Out.iid.nap_summary;
	rc_hriskaddrflag_s               := le.bs.Ship_To_Out.iid.hriskaddrflag;
	rc_dwelltype_s                   := le.bs.Ship_To_Out.iid.dwelltype;
	rc_addrcommflag_s                := le.bs.Ship_To_Out.iid.addrcommflag;
	rc_hrisksic_s                    := le.bs.Ship_To_Out.iid.hrisksic;
	addrpop_s                        := le.bs.Ship_To_Out.input_validation.address;
	// drop_addr_s                      := le.bs.Bill_To_Out.advo_input_addr.drop_indicator in ['C','Y'];  
	drop_addr_s                      := TRIM(StringLib.StringToUpperCase(le.bs.Ship_To_Out.advo_input_addr.Drop_Indicator)) IN ['C','Y'];  
	add1_advo_address_vacancy_s      := le.bs.Ship_To_Out.advo_input_addr.address_vacancy_indicator;
	add1_advo_res_or_business_s      := le.bs.Ship_To_Out.advo_input_addr.residential_or_business_ind;
	add1_applicant_owned_s           := le.bs.Ship_To_Out.address_verification.input_address_information.applicant_owned;
	add1_family_owned_s              := le.bs.Ship_To_Out.address_verification.input_address_information.family_owned;
	add1_naprop_s                    := le.bs.Ship_To_Out.address_verification.input_address_information.naprop;
	add1_date_last_seen_s            := le.bs.Ship_To_Out.address_verification.input_address_information.date_last_seen;
	add1_turnover_1yr_out_s          := le.bs.Ship_To_Out.addr_risk_summary.turnover_1yr_out;
	property_owned_total_s           := le.bs.Ship_To_Out.address_verification.owned.property_total;
	hist_addr_match_s                := le.bs.Ship_To_Out.address_history_summary.hist_addr_match;
	header_first_seen_s              := le.bs.Ship_To_Out.ssn_verification.header_first_seen;
	header_last_seen_s               := le.bs.Ship_To_Out.ssn_verification.header_last_seen;
	adls_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_created_6months;
	inq_collection_count12_s         := le.bs.Ship_To_Out.acc_logs.collection.count12;
	inq_banking_count12_s            := le.bs.Ship_To_Out.acc_logs.banking.count12;
	infutor_nap_s                    := le.bs.Ship_To_Out.infutor_phone.infutor_nap;
	impulse_count_s                  := le.bs.Ship_To_Out.impulse.count;
	email_source_list_s              := le.bs.Ship_To_Out.email_summary.email_source_list;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	sysdate := Common.SAS_Date((STRING)(archive_date));
	
	in_population_bad_rate := (4608 / 971000);
	
	in_sample_bad_rate := (3141 / 48550);
	
	in_model_offset := ln(((1 - in_population_bad_rate) * in_sample_bad_rate) / (in_population_bad_rate * (1 - in_sample_bad_rate)));
	
	bt_population_bad_rate := (3831 / 1256000);
	
	bt_sample_bad_rate := (2538 / 62800);
	
	bt_model_offset := ln(((1 - bt_population_bad_rate) * bt_sample_bad_rate) / (bt_population_bad_rate * (1 - bt_sample_bad_rate)));
	
	st_population_bad_rate := (3156 / 362780);
	
	st_sample_bad_rate := (2265 / 18139);
	
	st_model_offset := ln(((1 - st_population_bad_rate) * st_sample_bad_rate) / (st_population_bad_rate * (1 - st_sample_bad_rate)));
	
	addr_mismatch := addrpop and addrpop_s and (integer)addrscore != 100;
	
	eg_segment := map(
	    not(truedid)                                                                => 'DID0   ',
	    not(addr_mismatch) and (bb_Line_Type_Header_ in ['SHIPTOHOME', 'DELIVERY']) => 'BILLTO ',
	    (bb_Line_Type_Header_ in ['SHIPTOHOME', 'DELIVERY'])                        => 'SHIPTO ',
	                                                                                   'INSTORE');
	
	pf_ship_mode := map(
	    bb_Ship_Mode_ = '2' => 'NEXT DAY   ',
	    bb_Ship_Mode_ = '7' => 'SECOND DAY ',
	    bb_Ship_Mode_ = 'G' => 'GROUND     ',
	                           'STANDARD');
	
	pf_order_amount := (real)bb_Original_Total_Amount_;
	
	pf_num_items := bb_Item_Lines_;
	
	avg_pmt_amt := max(pf_order_amount, (real)0) / max((integer)pf_num_items, 1);
	
	pf_pmt_type := map(
	    not(trim(bb_PayPal_Customer_ID_) = '')      => 'PAYPAL         ',
	    trim(bb_CC_Type_) = ''                      => 'GIFT CARD      ',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'AMERICANEXPRESS' => 'AMERICANEXPRESS',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'CHASECONSUMER'   => 'CHASECONSUMER  ',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'DINERS'          => 'DINERS         ',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'DISCOVER'        => 'DISCOVER       ',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'HRS'             => 'HRS            ',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'MASTERCARD'      => 'MASTERCARD     ',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'VISA'            => 'VISA           ',
	    stringlib.stringtoUpperCase(trim(bb_CC_Type_)) = 'JCB'             => 'JCB            ',
																																						'OTHER     ');
	
	avs_name_ver_1 := 0;
	
	avs_addr_ver_1 := 0;
	
	avs_zip5_ver_1 := 0;
	
	avs_unvail_1 := 0;
	
	avs_no_match_1 := 0;
	
	avs_name_ver := map(
	    pf_pmt_type = 'AMERICANEXPRESS' => (pf_raw_avs_code in ['L', 'M', 'O', 'K']),
	    pf_pmt_type = 'CHASECONSUMER'   => avs_name_ver_1,
	    pf_pmt_type = 'DISCOVER'        => avs_name_ver_1,
	    pf_pmt_type = 'VISA'            => avs_name_ver_1,
	    pf_pmt_type = 'MASTERCARD'      => avs_name_ver_1,
	    pf_pmt_type = 'HRS'             => avs_name_ver_1,
	                                       avs_name_ver_1);
	
	avs_unvail := map(
	    pf_pmt_type = 'AMERICANEXPRESS' => (pf_raw_avs_code in ['U']),
	    pf_pmt_type = 'CHASECONSUMER'   => (pf_raw_avs_code in ['IU']),
	    pf_pmt_type = 'DISCOVER'        => (pf_raw_avs_code in ['U']),
	    pf_pmt_type = 'VISA'            => (pf_raw_avs_code in ['U']),
	    pf_pmt_type = 'MASTERCARD'      => (pf_raw_avs_code in ['U']),
	    pf_pmt_type = 'HRS'             => (pf_raw_avs_code in ['U']),
	                                       (pf_raw_avs_code in ['X']));
	
	avs_addr_ver := map(
	    pf_pmt_type = 'AMERICANEXPRESS' => (pf_raw_avs_code in ['Y', 'A', 'M', 'O', 'E', 'F']),
	    pf_pmt_type = 'CHASECONSUMER'   => (pf_raw_avs_code in ['I1', 'I3', 'I5', 'I7']),
	    pf_pmt_type = 'DISCOVER'        => (pf_raw_avs_code in ['X', 'A', 'Y']),
	    pf_pmt_type = 'VISA'            => (pf_raw_avs_code in ['A', 'B', 'D', 'F', 'M', 'Y']),
	    pf_pmt_type = 'MASTERCARD'      => (pf_raw_avs_code in ['A', 'B', 'D', 'F', 'M', 'Y']),
	    pf_pmt_type = 'HRS'             => (pf_raw_avs_code in ['Y', 'A']),
	                                       (pf_raw_avs_code in ['A', 'F']));
	
	avs_no_match := map(
	    pf_pmt_type = 'AMERICANEXPRESS' => (pf_raw_avs_code in ['N', 'W']),
	    pf_pmt_type = 'CHASECONSUMER'   => (pf_raw_avs_code in ['I6', 'I8']),
	    pf_pmt_type = 'DISCOVER'        => (pf_raw_avs_code in ['N']),
	    pf_pmt_type = 'VISA'            => (pf_raw_avs_code in ['N']),
	    pf_pmt_type = 'MASTERCARD'      => (pf_raw_avs_code in ['N']),
	    pf_pmt_type = 'HRS'             => (pf_raw_avs_code in ['N']),
	                                       (pf_raw_avs_code in ['N']));
	
	avs_zip5_ver := map(
	    pf_pmt_type = 'AMERICANEXPRESS' => (pf_raw_avs_code in ['Y', 'Z', 'L', 'M', 'D', 'E']),
	    pf_pmt_type = 'CHASECONSUMER'   => (pf_raw_avs_code in ['I1', 'I2', 'I3', 'I4']),
	    pf_pmt_type = 'DISCOVER'        => (pf_raw_avs_code in ['X', 'A', 'T', 'Z']),
	    pf_pmt_type = 'VISA'            => (pf_raw_avs_code in ['D', 'F', 'M', 'P', 'Y', 'Z']),
	    pf_pmt_type = 'MASTERCARD'      => (pf_raw_avs_code in ['D', 'F', 'M', 'P', 'Y', 'Z']),
	    pf_pmt_type = 'HRS'             => (pf_raw_avs_code in ['Y', 'Z']),
	                                       (pf_raw_avs_code in ['Z', 'F']));
	
	pf_avs_ver_lvl := map(
	    pf_pmt_type = 'AMERICANEXPRESS' and (boolean)avs_name_ver => '0NM',
	    pf_pmt_type = 'PAYPAL'                                    => '7NA',
	    pf_pmt_type = 'GIFT CARD'                                 => '7NA',
	    avs_no_match                                              => '5NO',
	    avs_addr_ver and avs_zip5_ver                             => '1AZ',
	    avs_addr_ver and not(avs_zip5_ver)                        => '2AX',
	    not(avs_addr_ver) and avs_zip5_ver                        => '3XZ',
	    avs_unvail                                                => '6UN',
	                                                                 '4XX');
	
	pf_cid_match := map(
	    bb_CVV_Description_ = 'Match'    => 1,
	    bb_CVV_Description_ = 'No Match' => 0,
	                                        -1);
	
	valid_tm_account := bb_Entry_Type_ = 'WEB' and not(trim(TM_Device_Result_) = '');
	
	tm_browser_not_en_f := valid_tm_account and ((string)TM_Browser_Language_)[1..2] != 'en' and trim(TM_Browser_Language_) != '';
	
	tm_proxy_geo_not_us_f := valid_tm_account and TM_Proxy_Ip_Geo_ != 'US' and trim(TM_Proxy_Ip_Geo_) != '';
	
	tm_bad_reason_code_f := valid_tm_account and (TM_Reason_Code_ in ['Device4PerDay', 'GeoLangMismatch']) and trim(TM_Reason_Code_) != '';
	// check next line - is string conversion good
	tm_not_us_time_zone_f := valid_tm_account and not(TM_Time_Zone_Hours_ in [-8, -7, -6, -5]) and trim((string)TM_Time_Zone_Hours_) != '';
	
	tm_true_geo_not_us_f := valid_tm_account and TM_True_Ip_Geo_ != 'US' and trim(TM_True_Ip_Geo_) != '';
	
	tm_score_not_zero_f := valid_tm_account and TM_Policy_Score_ < 0;
	
	ip_state := map(
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'ALABAMA'        => 'AL',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'ALASKA'         => 'AK',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'ARIZONA'        => 'AZ',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'ARKANSAS'       => 'AR',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'CALIFORNIA'     => 'CA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'COLORADO'       => 'CO',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'CONNECTICUT'    => 'CT',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'DELAWARE'       => 'DE',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'FLORIDA'        => 'FL',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'GEORGIA'        => 'GA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'HAWAII'         => 'HI',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'IDAHO'          => 'ID',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'ILLINOIS'       => 'IL',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'INDIANA'        => 'IN',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'IOWA'           => 'IA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'KANSAS'         => 'KS',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'KENTUCKY'       => 'KY',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'LOUISIANA'      => 'LA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MAINE'          => 'ME',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MARYLAND'       => 'MD',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MASSACHUSETTS'  => 'MA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MICHIGAN'       => 'MI',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MINNESOTA'      => 'MN',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MISSISSIPPI'    => 'MS',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MISSOURI'       => 'MO',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'MONTANA'        => 'MT',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NEBRASKA'       => 'NE',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NEVADA'         => 'NV',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NEW HAMPSHIRE'  => 'NH',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NEW JERSEY'     => 'NJ',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NEW MEXICO'     => 'NM',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NEW YORK'       => 'NY',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NORTH CAROLINA' => 'NC',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'NORTH DAKOTA'   => 'ND',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'OHIO'           => 'OH',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'OKLAHOMA'       => 'OK',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'OREGON'         => 'OR',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'PENNSYLVANIA'   => 'PA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'RHODE ISLAND'   => 'RI',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'SOUTH CAROLINA' => 'SC',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'SOUTH DAKOTA'   => 'SD',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'TENNESSEE'      => 'TN',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'TEXAS'          => 'TX',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'UTAH'           => 'UT',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'VERMONT'        => 'VT',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'VIRGINIA'       => 'VA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'WASHINGTON'     => 'WA',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'WEST VIRGINIA'  => 'WV',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'WISCONSIN'      => 'WI',
	    stringlib.stringtoUpperCase(trim(TM_True_IP_Region_)) = 'WYOMING'        => 'WY',
																																								 '  ');
	
	tm_problem_lvl := map(
	    tm_bad_reason_code_f and tm_not_us_time_zone_f                                                                          => 4,
	    tm_not_us_time_zone_f and (tm_browser_not_en_f or tm_proxy_geo_not_us_f or tm_true_geo_not_us_f or tm_score_not_zero_f) => 3,
	    tm_not_us_time_zone_f                                                                                                   => 2,
	    tm_browser_not_en_f or tm_proxy_geo_not_us_f or tm_true_geo_not_us_f or tm_bad_reason_code_f                            => 1,
	                                                                                                                               0);
	
	state_match_lvl := map(
	    valid_tm_account and not(ip_state = '') and not(in_state = '') and stringlib.stringtoUpperCase(in_state) = ip_state => 1,
	    valid_tm_account and not(ip_state = '') and not(in_state = '')                                 									=> 0,
	    valid_tm_account and (ip_state = '' or in_state = '')                                          									=> -1,
																																																														 -2);
	
	add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';
	
	_header_first_seen := Common.SAS_Date((STRING)(header_first_seen));
	
	_header_last_seen := Common.SAS_Date((STRING)(header_last_seen));
	
	mos_header_first_seen := if(min(sysdate, _header_first_seen) = NULL, NULL, truncate((sysdate - _header_first_seen) / (365.25 / 12)));
	
	mos_header_last_seen := if(min(sysdate, _header_last_seen) = NULL, NULL, truncate((sysdate - _header_last_seen) / (365.25 / 12)));
	
	header_fst_seen_recent := 0 <= mos_header_first_seen AND mos_header_first_seen <= 48;
	
	header_lst_seen_recent := mos_header_last_seen <= 0;
	
	contrary_inf := (infutor_nap in [1]);
	
	verfst_i := (infutor_nap in [2, 3, 4, 8, 9, 10, 12]);
	
	verlst_i := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);
	
	veradd_i := (infutor_nap in [3, 5, 6, 8, 10, 11, 12]);
	
	verphn_i := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);
	
	contrary_phn := (nap_summary in [1]);
	
	verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);
	
	verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);
	
	veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);
	
	verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);
	
	ver_add := veradd_i or veradd_p;
	
	ver_phn := verphn_i or verphn_p;
	
	ver_fst := verfst_i or verfst_p;
	
	ver_lst := verlst_i or verlst_p;
	
	vername_p := verlst_p and verfst_p;
	
	vername_i := verlst_i and verfst_i;
	
	ver_name := map(
	    ver_lst and ver_fst => 3,
	    ver_lst             => 2,
	    ver_fst             => 1,
	                           0);
	
	no_match := not((boolean)ver_name or ver_phn or ver_add);
	
	nap_ver_sum := if(max((integer)verphn_p, (integer)veradd_p, (integer)vername_p) = NULL, NULL, sum((integer)verphn_p, (integer)veradd_p, (integer)vername_p));
	
	inf_ver_sum := if(max((integer)verphn_i, (integer)veradd_i, (integer)vername_i) = NULL, NULL, sum((integer)verphn_i, (integer)veradd_i, (integer)vername_i));
	
	_gong_did_first_seen := Common.SAS_Date((STRING)(gong_did_first_seen));
	
	_gong_did_last_seen := Common.SAS_Date((STRING)(gong_did_last_seen));
	
	mos_since_gong_first_seen := if(min(sysdate, _gong_did_first_seen) = NULL, NULL, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)));
	
	mos_since_gong_last_seen := if(min(sysdate, _gong_did_last_seen) = NULL, NULL, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)));
	
	phn_last_seen_rec := mos_since_gong_last_seen = 0;
	
	phn_first_seen_rec := 0 <= mos_since_gong_first_seen AND mos_since_gong_first_seen <= 6;
	
	phn_pots := (telcordia_type in ['00', '50', '51', '52', '54']);
	
	phn_disconnected := (integer)rc_hriskphoneflag = 5;
	
	phn_inval := (integer)rc_phonevalflag = 0 or (integer)rc_hphonevalflag = 0 or (rc_phonetype in ['5']);
	
	phn_nonus := (rc_phonetype in ['3', '4']);
	
	phn_highrisk := (integer)rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or (integer)rc_hphonevalflag = 3 or (integer)rc_addrcommflag = 1;
	
	phn_notpots := not phn_pots;
	
	phn_cellpager := (rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']);
	
	phn_business := (integer)rc_hphonevalflag = 1;
	
	phn_residential := (integer)rc_hphonevalflag = 2;
	
	phn_bad_counts := not((gong_did_first_ct in [1, 2])) and not((gong_did_last_ct in [1, 2]));
	
	rel_income_100plus := sum(0, if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count));
	
	rel_income_75plus := sum(0, if(rel_income_100plus = NULL, 0, rel_income_100plus), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count));
	
	rel_income_50plus := sum(0, if(rel_income_75plus = NULL, 0, rel_income_75plus), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count));
	
	rel_income_25plus := sum(0, if(rel_income_50plus = NULL, 0, rel_income_50plus), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count));
	
	rel_home_500plus := sum(0, if(rel_homeover500_count = NULL, 0, rel_homeover500_count));
	
	rel_home_300plus := sum(0, if(rel_home_500plus = NULL, 0, rel_home_500plus), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count));
	
	rel_home_200plus := sum(0, if(rel_home_300plus = NULL, 0, rel_home_300plus), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count));
	
	rel_home_150plus := sum(0, if(rel_home_200plus = NULL, 0, rel_home_200plus), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count));
	
	rel_home_100plus := sum(0, if(rel_home_150plus = NULL, 0, rel_home_150plus), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count));
	
	rel_home_50plus := sum(0, if(rel_home_100plus = NULL, 0, rel_home_100plus), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count));
	
	rel_ed_over12 := sum(0, if(rel_educationover12_count = NULL, 0, rel_educationover12_count));
	
	rel_ed_over8 := sum(0, if(rel_ed_over12 = NULL, 0, rel_ed_over12), if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count));
	
	rel_age_over70 := sum(0, if(rel_ageover70_count = NULL, 0, rel_ageover70_count));
	
	rel_age_over60 := sum(0, if(rel_age_over70 = NULL, 0, rel_age_over70), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count));
	
	rel_age_over50 := sum(0, if(rel_age_over60 = NULL, 0, rel_age_over60), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count));
	
	rel_age_over40 := sum(0, if(rel_age_over50 = NULL, 0, rel_age_over50), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count));
	
	rel_age_over30 := sum(0, if(rel_age_over40 = NULL, 0, rel_age_over40), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count));
	
	rel_age_over20 := sum(0, if(rel_age_over30 = NULL, 0, rel_age_over30), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count));
	
	no_rel_prop := truedid and rel_count > 0 and rel_prop_owned_count = 0;
	
	no_rel_inc25 := truedid and rel_count > 0 and rel_income_25plus = 0;
	
	no_rel_ed8 := truedid and rel_count > 0 and rel_ed_over8 = 0;
	
	no_rel_ed12 := truedid and rel_count > 0 and rel_educationover12_count = 0;
	
	no_rel_vehx := truedid and rel_count > 0 and rel_vehicle_owned_count = 0;
	
	no_rel_age40 := truedid and rel_count > 0 and rel_age_over40 = 0;
	
	no_rel_age30 := truedid and rel_count > 0 and rel_age_over30 = 0;
	
	no_rel_age20 := truedid and rel_count > 0 and rel_age_over20 = 0;
	
	cen_pop_gte_85 := (REAL)C_POP_85P_P;
	
	cen_pop_gte_75 := if(max((REAL)cen_pop_gte_85, (REAL)C_POP_75_84_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_85 = NULL, 0, (REAL)cen_pop_gte_85), if((REAL)C_POP_75_84_P = NULL, 0, (REAL)C_POP_75_84_P)));
	
	cen_pop_gte_65 := if(max((REAL)cen_pop_gte_75, (REAL)C_POP_65_74_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_75 = NULL, 0, (REAL)cen_pop_gte_75), if((REAL)C_POP_65_74_P = NULL, 0, (REAL)C_POP_65_74_P)));
	
	cen_pop_gte_55 := if(max((REAL)cen_pop_gte_65, (REAL)C_POP_55_64_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_65 = NULL, 0, (REAL)cen_pop_gte_65), if((REAL)C_POP_55_64_P = NULL, 0, (REAL)C_POP_55_64_P)));
	
	cen_pop_gte_45 := if(max((REAL)cen_pop_gte_55, (REAL)C_POP_45_54_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_55 = NULL, 0, (REAL)cen_pop_gte_55), if((REAL)C_POP_45_54_P = NULL, 0, (REAL)C_POP_45_54_P)));
	
	cen_pop_gte_35 := if(max((REAL)cen_pop_gte_45, (REAL)C_POP_35_44_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_45 = NULL, 0, (REAL)cen_pop_gte_45), if((REAL)C_POP_35_44_P = NULL, 0, (REAL)C_POP_35_44_P)));
	
	cen_pop_gte_25 := if(max((REAL)cen_pop_gte_35, (REAL)C_POP_25_34_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_35 = NULL, 0, (REAL)cen_pop_gte_35), if((REAL)C_POP_25_34_P = NULL, 0, (REAL)C_POP_25_34_P)));
	
	cen_pop_gte_18 := if(max((REAL)cen_pop_gte_25, (REAL)C_POP_18_24_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_25 = NULL, 0, (REAL)cen_pop_gte_25), if((REAL)C_POP_18_24_P = NULL, 0, (REAL)C_POP_18_24_P)));
	
	cen_pop_gte_12 := if(max((REAL)cen_pop_gte_18, (REAL)C_POP_12_17_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_18 = NULL, 0, (REAL)cen_pop_gte_18), if((REAL)C_POP_12_17_P = NULL, 0, (REAL)C_POP_12_17_P)));
	
	cen_pop_gte_6 := if(max((REAL)cen_pop_gte_12, (REAL)C_POP_6_11_P) = (REAL)NULL, NULL, sum(if((REAL)cen_pop_gte_12 = NULL, 0, (REAL)cen_pop_gte_12), if((REAL)C_POP_6_11_P = NULL, 0, (REAL)C_POP_6_11_P)));
	
	eq_date_first_seen := if(Models.Common.getw(ver_sources_first_seen, (integer)Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') = '0', NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ','));
	
	_eq_date_first_seen := Common.SAS_Date((STRING)(eq_date_first_seen));
	
	eq_date_first_seen_mos := if(min(sysdate, _eq_date_first_seen) = NULL, NULL, truncate((sysdate - _eq_date_first_seen) / (365.25 / 12)));
	
	// eq_count := max(if(max((integer)Models.Common.getw(ver_sources_count, (integer)Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')) = NULL, NULL, sum(if(Models.Common.getw(ver_sources_count, (integer)Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') = NULL, 0, Models.Common.getw(ver_sources_count, (integer)Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')))), 0);
// EQ_count = max(sum(scan(ver_sources_count ,findw(ver_sources, 'EQ', ', ', 'E'),',')),0);

	eq_count := MAX(SUM((INTEGER)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EQ', ', ', 'E'), ',')), 0);
	
	// eq_count := max(if(
				// max((integer)Models.Common.getw(ver_sources_count, (integer)Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')) = NULL, 
							// NULL, 
							// sum(if((integer)Models.Common.getw(ver_sources_count, (integer)Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') = NULL, 
								// 0, 
								// (integer)Models.Common.getw(ver_sources_count, (integer)Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ','))
					// )), 0);
					
	eq_sourced := eq_count > 0;
	
	eq_add_not_sourced := eq_sourced and addrpop and contains_i(ver_addr_sources, 'EQ') <= 0;
	
	cc_payment := not((pf_pmt_type in ['GIFT CARD', 'PAYPAL']));
	
	credit_sourced := contains_i(ver_sources, 'EQ') > 0;
	
	inq_coll := inq_collection_count12 > 0;
	
	inq_auto := inq_auto_count12 > 0;
	
	inq_banking := inq_banking_count12 > 0;
	
	inq_highrisk := inq_highriskcredit_count12 > 0;
	
	inq_comm := inq_communications_count12 > 0;
	
	many_inquiries := inq_count12 > 10;
	
	hi_inq_adlsperaddr := inq_adlsperaddr > 3;
	
	moved_1mo := attr_addrs_last30 > 0;
	
	moved_3mo := attr_addrs_last90 > 0;
	
	moved_1yr := attr_addrs_last12 > 0;
	
	moved_2yr := attr_addrs_last24 > 0;
	
	moved_3yr := attr_addrs_last36 > 0;
	
	moved_5yr := addrs_5yr > 0;
	
	moved_10yr := addrs_10yr > 0;
	
	moved_15yr := addrs_15yr > 0;
	
	add1_lres0 := add1_lres = 0;
	
	avg_lres_low := 0 <= avg_lres AND avg_lres <= 24;
	
	max_lres_low := 0 <= max_lres AND max_lres <= 24;
	
	avg_mo_per_addr_low := 1 <= avg_mo_per_addr AND avg_mo_per_addr <= 12;
	
	addr_count_ge3_0 := addr_count_ge3 = 0;
	
	addr_count_ge6_0 := addr_count_ge6 = 0;
	
	addr_count_ge10_0 := addr_count_ge10 = 0;
	
	hist_addr_match_0 := hist_addr_match = 0;
	
	addr_stability_low := (addr_stability_v2 in ['0', '1']);
	
	ids_per_addr_max := max(adls_per_addr, ssns_per_addr);
	
	ids_per_addr_max_c6 := max(adls_per_addr_c6, ssns_per_addr_c6);
	
	email_domain := TRIM(StringLib.StringToUpperCase(in_email_address [(StringLib.StringFind(in_email_address, '@', StringLib.StringFindCount(in_email_address, '@')) + 1)..]));
	
	email_topleveldomain := TRIM(email_domain [(StringLib.StringFind(email_domain, '.', StringLib.StringFindCount(email_domain, '.')) + 1)..]);
	
	email_secondleveldomain := TRIM(email_domain [1..(StringLib.StringFind(email_domain, '.', StringLib.StringFindCount(email_domain, '.')) - 1)]);
	
	_email_topleveldomain := if(TRIM(email_topleveldomain) in ['EDU', 'GOV', 'MIL', 'NET', 'ORG', 'US', 'COM', ''], email_topleveldomain, 'OTHER');
	
	_email_secondleveldomain := if(TRIM(email_secondleveldomain) in ['YAHOO', 'GMAIL', 'HOTMAIL', 'AOL', 'COMCAST', 'MSN', 'SBCGLOBAL', 'VERIZON', ''], email_secondleveldomain, 'OTHER');
	
	in_avg_pmt_amt := map(
	    avg_pmt_amt = 0    => 0,
	    avg_pmt_amt <= 10  => 10,
	    avg_pmt_amt <= 25  => 25,
	    avg_pmt_amt <= 100 => 100,
	    avg_pmt_amt <= 250 => 250,
	    avg_pmt_amt <= 500 => 500,
	                          501);
	
	in_pmt_type_x_amt_lvl_c16 := map(
	    in_avg_pmt_amt <= 25  => 0,
	    in_avg_pmt_amt <= 500 => 2,
	                             7);
	
	in_pmt_type_x_amt_lvl_c17 := map(
	    in_avg_pmt_amt <= 100 => 2,
	    in_avg_pmt_amt <= 250 => 5,
	    in_avg_pmt_amt <= 500 => 8,
	                             9);
	
	in_pmt_type_x_amt_lvl_c18 := map(
	    in_avg_pmt_amt <= 100 => 2,
	    in_avg_pmt_amt <= 250 => 4,
	    in_avg_pmt_amt <= 500 => 8,
	                             9);
	
	in_pmt_type_x_amt_lvl_c19 := map(
	    in_avg_pmt_amt <= 25  => 1,
	    in_avg_pmt_amt <= 100 => 6,
	    in_avg_pmt_amt <= 250 => 7,
	    in_avg_pmt_amt <= 500 => 8,
	                             9);
	
	in_pmt_type_x_amt_lvl_c20 := if(pf_pmt_type = 'PAYPAL', 3, -1);
	
	in_pmt_type_x_amt_lvl := map(
	    (pf_pmt_type in ['CHASECONSUMER', 'GIFT CARD', 'HRS']) => in_pmt_type_x_amt_lvl_c16,
	    in_avg_pmt_amt = 25                                    => 1,
	    in_avg_pmt_amt = 500                                   => 8,
	    in_avg_pmt_amt = 501                                   => 9,
	    (pf_pmt_type in ['DINERS', 'DISCOVER', 'MASTERCARD'])  => in_pmt_type_x_amt_lvl_c17,
	    (pf_pmt_type in ['VISA'])                              => in_pmt_type_x_amt_lvl_c18,
	    (pf_pmt_type in ['AMERICANEXPRESS'])                   => in_pmt_type_x_amt_lvl_c19,
	                                                              in_pmt_type_x_amt_lvl_c20);
	
	pf_avs_ver_lvl_num_1 := (integer)(pf_avs_ver_lvl)[1..1];
	
	in_pmt_quality_index := map(
	    (in_pmt_type_x_amt_lvl in [0, 1]) and (pf_avs_ver_lvl_num_1 in [0, 1, 2, 3, 7]) => 7,
	    (in_pmt_type_x_amt_lvl in [2]) and (pf_avs_ver_lvl_num_1 in [0, 1, 2, 3, 7])    => 6,
	    (in_pmt_type_x_amt_lvl in [4, 5, 6]) and (pf_avs_ver_lvl_num_1 in [0, 1])       => 5,
	    in_pmt_type_x_amt_lvl <= 3                                                      => 4,
	    (in_pmt_type_x_amt_lvl in [4, 5, 6]) and (pf_avs_ver_lvl_num_1 in [2, 3, 7])    => 3,
	    (in_pmt_type_x_amt_lvl in [7, 8]) and (pf_avs_ver_lvl_num_1 in [0, 1])          => 3,
	    (in_pmt_type_x_amt_lvl in [7, 8]) and (pf_avs_ver_lvl_num_1 in [2, 3, 7])       => 2,
	    in_pmt_type_x_amt_lvl <= 8 or (pf_avs_ver_lvl_num_1 in [0, 1, 2, 3, 7])         => 1,
	                                                                                       0);
	
	in_pmt_quality_index_m := map(
	    in_pmt_quality_index = 0 => 0.5418719212,
	    in_pmt_quality_index = 1 => 0.2246777164,
	    in_pmt_quality_index = 2 => 0.1210428305,
	    in_pmt_quality_index = 3 => 0.0796175138,
	    in_pmt_quality_index = 4 => 0.0537150209,
	    in_pmt_quality_index = 5 => 0.0499398872,
	    in_pmt_quality_index = 6 => 0.0225705329,
	                                0.0066409597);
	
	in_bb_entry_type_lvl := map(
	    bb_Entry_Type_ = 'KIOSK' => 3,
	    bb_Entry_Type_ = 'WEB'   => 2,
	    bb_Entry_Type_ = 'CCR'   => 0,
	                                1);
	
	in_bb_entry_type_lvl_m := map(
	    in_bb_entry_type_lvl = 0 => 0.2020781082,
	    in_bb_entry_type_lvl = 1 => 0.0702947846,
	    in_bb_entry_type_lvl = 2 => 0.052612839,
	                                0.010989011);
	
	name_match := firstscore = 100 and lastscore = 100;
	
	pf_friends_and_family_f := not(bb_Marked_For_Full_Name_H = '');
	
	in_bb_fandf_lvl_c26 := if((boolean)(integer)btst_relatives_in_common and not(name_match), 2, 1);
	
	in_bb_fandf_lvl := if(pf_friends_and_family_f, in_bb_fandf_lvl_c26, 0);
	
	in_bb_fandf_lvl_m := map(
	    in_bb_fandf_lvl = 0 => 0.046836575,
	    in_bb_fandf_lvl = 1 => 0.1464557704,
	                           0.3458646617);
	
	in_nap_ver_lvl_c29 := map(
	    nap_ver_sum = 3 and inf_ver_sum = 0 or nap_ver_sum < 3 and inf_ver_sum = 3 and not(contrary_inf) => 9,
	    nap_ver_sum = 3                                                                                  => 8,
	    nap_ver_sum > 0 and inf_ver_sum > 0                                                              => 7,
	    nap_ver_sum = 2 and inf_ver_sum = 0                                                              => 6,
	    nap_ver_sum = 1 and inf_ver_sum = 0                                                              => 6,
	    nap_ver_sum = 0 and inf_ver_sum > 0                                                              => 5,
	                                                                                                        4);
	
	in_nap_ver_lvl_c30 := map(
	    nap_ver_sum = 3 and inf_ver_sum = 0 or nap_ver_sum < 3 and inf_ver_sum = 3 and not(contrary_inf) => 6,
	    nap_ver_sum = 3                                                                                  => 5,
	    nap_ver_sum > 0 and inf_ver_sum > 0                                                              => 4,
	    nap_ver_sum = 2 and inf_ver_sum = 0                                                              => 3,
	    nap_ver_sum = 1 and inf_ver_sum = 0                                                              => 2,
	    nap_ver_sum = 0 and inf_ver_sum > 0                                                              => 1,
	                                                                                                        0);
	
	in_nap_ver_lvl := if(add1_isbestmatch, in_nap_ver_lvl_c29, in_nap_ver_lvl_c30);
	
	in_nap_ver_lvl_m := map(
	    in_nap_ver_lvl = 0 => 0.2136940917,
	    in_nap_ver_lvl = 1 => 0.1448040886,
	    in_nap_ver_lvl = 2 => 0.0992301112,
	    in_nap_ver_lvl = 3 => 0.1101083032,
	    in_nap_ver_lvl = 4 => 0.0796481217,
	    in_nap_ver_lvl = 5 => 0.054973822,
	    in_nap_ver_lvl = 6 => 0.0571428571,
	    in_nap_ver_lvl = 7 => 0.0494682565,
	    in_nap_ver_lvl = 8 => 0.0276936391,
	                          0.0297174268);
	
	in_phn_prob_lvl := map(
	    phn_nonus or phn_inval                               => 6,
	    phn_business or phn_highrisk                         => 5,
	    phn_bad_counts and not(phn_residential) and phn_pots => 5,
	    phn_bad_counts and not(phn_residential)              => 4,
	    not(phn_residential)                                 => 3,
	    phn_bad_counts                                       => 2,
	    not(phn_last_seen_rec)                               => 1,
	                                                            0);
	
	in_phn_prob_lvl_m := map(
	    in_phn_prob_lvl = 0 => 0.0292872863,
	    in_phn_prob_lvl = 1 => 0.0383883249,
	    in_phn_prob_lvl = 2 => 0.0384375649,
	    in_phn_prob_lvl = 3 => 0.0663719229,
	    in_phn_prob_lvl = 4 => 0.0808682484,
	    in_phn_prob_lvl = 5 => 0.1220005782,
	                           0.2202643172);
	
	in_inq_coll_count12_lvl := map(
	    inq_collection_count12 > 5 => 3,
	    inq_collection_count12 > 2 => 2,
	    inq_collection_count12 > 0 => 1,
	                                  0);
	
	in_inq_coll_count12_lvl_m := map(
	    in_inq_coll_count12_lvl = 0 => 0.0507377557,
	    in_inq_coll_count12_lvl = 1 => 0.073888988,
	    in_inq_coll_count12_lvl = 2 => 0.1107715814,
	                                   0.1243243243);
	
	in_inq_bank_count12_lvl := map(
	    inq_banking_count12 > 4 => 4,
	    inq_banking_count12 > 2 => 3,
	    inq_banking_count12 > 1 => 2,
	    inq_banking_count12 > 0 => 1,
	                               0);
	
	in_inq_bank_count12_lvl_m := map(
	    in_inq_bank_count12_lvl = 0 => 0.0516490643,
	    in_inq_bank_count12_lvl = 1 => 0.0806706114,
	    in_inq_bank_count12_lvl = 2 => 0.0938494168,
	    in_inq_bank_count12_lvl = 3 => 0.1911298838,
	                                   0.2352941176);
	
	in_inq_addrsperadl_3 := min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 3);
	
	in_inq_addrsperadl_3_m := map(
	    in_inq_addrsperadl_3 = 0 => 0.0496662452,
	    in_inq_addrsperadl_3 = 1 => 0.067326466,
	    in_inq_addrsperadl_3 = 2 => 0.1155994843,
	                                0.3630952381);
	
	in_inq_lnamesperaddr_5 := min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 5);
	
	in_inq_lnamesperaddr_5_m := map(
	    in_inq_lnamesperaddr_5 = 0 => 0.0518733087,
	    in_inq_lnamesperaddr_5 = 1 => 0.0552064632,
	    in_inq_lnamesperaddr_5 = 2 => 0.1006859383,
	    in_inq_lnamesperaddr_5 = 3 => 0.1721311475,
	    in_inq_lnamesperaddr_5 = 4 => 0.2441314554,
	                                  0.2490118577);
	
	in_email_name_lvl := map(
	    (integer)efirstscore = -1 or (integer)elastscore = -1 => 0,
	    (integer)efirstscore = 0 and (integer)elastscore = 0  => 1,
	    (integer)efirstscore = 1 and (integer)elastscore < 3  => 2,
	    (integer)efirstscore = 0 and (integer)elastscore < 3  => 3,
	                                           4);
	
	in_email_name_lvl_m := map(
	    in_email_name_lvl = 0 => 0.1394960934,
	    in_email_name_lvl = 1 => 0.0667816658,
	    in_email_name_lvl = 2 => 0.0332286496,
	    in_email_name_lvl = 3 => 0.0243540244,
	                             0.0214391112);
	
	in_adls_per_phone_2 := min(if(adls_per_phone = NULL, -NULL, adls_per_phone), 2);
	
	in_adls_per_phone_2_m := map(
	    in_adls_per_phone_2 = 0 => 0.0760015652,
	    in_adls_per_phone_2 = 1 => 0.0350283267,
	                               0.0272909364);
	
	in_ids_per_addr_max_c6_lvl := map(
	    ids_per_addr_max_c6 = 1 => 0,
	    ids_per_addr_max_c6 = 2 => 1,
	    ids_per_addr_max_c6 = 0 => 2,
	                               min(if(ids_per_addr_max_c6 = NULL, -NULL, ids_per_addr_max_c6), 4));
	
	in_ids_per_addr_max_c6_lvl_m := map(
	    in_ids_per_addr_max_c6_lvl = 0 => 0.0540742587,
	    in_ids_per_addr_max_c6_lvl = 1 => 0.0524857376,
	    in_ids_per_addr_max_c6_lvl = 2 => 0.0608453165,
	    in_ids_per_addr_max_c6_lvl = 3 => 0.075596817,
	                                      0.1247484909);
	
	in_rel_prob_lvl := map(
	    no_rel_ed8 or no_rel_age20  => 3,
	    no_rel_ed12 or no_rel_age30 => 2,
	    no_rel_prop                 => 1,
	                                   0);
	
	in_rel_prob_lvl_m := map(
	    in_rel_prob_lvl = 0 => 0.0515686982,
	    in_rel_prob_lvl = 1 => 0.0953885768,
	    in_rel_prob_lvl = 2 => 0.1144067797,
	                           0.1397058824);
	
	in_ams_lvl := map(
	    ams_college_type = 'P' and ams_college_code = '4' => 3,
	    ams_college_code = '4'                            => 2,
	    ams_college_code > '0'                            => 1,
	    email_domain_EDU_count > 0                      => 1,
	                                                       0);
	
	in_ams_lvl_m := map(
	    in_ams_lvl = 0 => 0.063592682,
	    in_ams_lvl = 1 => 0.0680722892,
	    in_ams_lvl = 2 => 0.0378366823,
	                      0.03125);
	
	in_tm_ip_problem_lvl := map(
	    tm_problem_lvl = 0 and state_match_lvl = 1          => 0,
	    tm_problem_lvl = 0 and state_match_lvl > -2         => 1,
	    tm_problem_lvl = 1                                  => 2,
	    tm_problem_lvl = 2 and (state_match_lvl in [-1, 1]) => 3,
	    tm_problem_lvl = 2                                  => 4,
	    tm_problem_lvl = 3 and (state_match_lvl in [-1, 1]) => 4,
	    tm_problem_lvl = 3 or state_match_lvl = -1          => 5,
	    state_match_lvl = 1                                 => 6,
	    state_match_lvl = 0                                 => 7,
	                                                           3);
	
	in_tm_ip_problem_lvl_m := map(
	    in_tm_ip_problem_lvl = 0 => 0.004077948,
	    in_tm_ip_problem_lvl = 1 => 0.0126526082,
	    in_tm_ip_problem_lvl = 2 => 0.0526793824,
	    in_tm_ip_problem_lvl = 3 => 0.1072995262,
	    in_tm_ip_problem_lvl = 4 => 0.3912639405,
	    in_tm_ip_problem_lvl = 5 => 0.593495935,
	    in_tm_ip_problem_lvl = 6 => 0.8580912863,
	                                0.9056603774);
	
	in_c_span_lang_lvl := map(
	    (real)C_SPAN_LANG >= 180 => 3,
	    (real)C_SPAN_LANG >= 120 => 2,
	    (real)C_SPAN_LANG >= 90  => 1,
	    (real)C_SPAN_LANG >= 20  => 0,
	                          1);
	
	in_c_span_lang_lvl_m := map(
	    in_c_span_lang_lvl = 0 => 0.044235604,
	    in_c_span_lang_lvl = 1 => 0.0564734154,
	    in_c_span_lang_lvl = 2 => 0.0679517798,
	                              0.1114376684);
	
	in_bb_cc_pmt_not_credit_srcd_f := cc_payment and not(credit_sourced);
	
	in_eq_first_seen_lvl := map(
	    eq_add_not_sourced             => 1,
	    eq_date_first_seen_mos > 192   => 4,
	    eq_date_first_seen_mos > 96    => 3,
	    eq_date_first_seen_mos > 48    => 2,
	    truedid                        => 1,
	    in_bb_cc_pmt_not_credit_srcd_f => 0,
	                                      0);
	
	in_eq_first_seen_lvl_m := map(
	    in_eq_first_seen_lvl = 0 => 0.3787,
	    in_eq_first_seen_lvl = 1 => 0.1370274914,
	    in_eq_first_seen_lvl = 2 => 0.1054458089,
	    in_eq_first_seen_lvl = 3 => 0.0574366247,
	                                0.0384446915);
	
	in_dist_a1toa2_lvl := map(
	    dist_a1toa2 >= 9999 => 5,
	    dist_a1toa2 >= 1226 => 4,
	    dist_a1toa2 >= 383  => 3,
	    dist_a1toa2 >= 8    => 2,
	    dist_a1toa2 >= 6    => 1,
	                           0);
	
	in_dist_a1toa2_lvl_m := map(
	    in_dist_a1toa2_lvl = 0 => 0.0668694477,
	    in_dist_a1toa2_lvl = 1 => 0.058204538,
	    in_dist_a1toa2_lvl = 2 => 0.0488706152,
	    in_dist_a1toa2_lvl = 3 => 0.0676965016,
	    in_dist_a1toa2_lvl = 4 => 0.0904414916,
	                              0.0658622423);
	
	in_dist_a1toa3_lvl := map(
	    dist_a1toa3 >= 9999 => 5,
	    dist_a1toa3 >= 816  => 4,
	    dist_a1toa3 >= 135  => 3,
	    dist_a1toa3 >= 12   => 2,
	    dist_a1toa3 >= 1    => 1,
	                           0);
	
	in_dist_a1toa3_lvl_m := map(
	    in_dist_a1toa3_lvl = 0 => 0.0556357579,
	    in_dist_a1toa3_lvl = 1 => 0.0612456299,
	    in_dist_a1toa3_lvl = 2 => 0.0491692671,
	    in_dist_a1toa3_lvl = 3 => 0.0629070691,
	    in_dist_a1toa3_lvl = 4 => 0.0847494553,
	                              0.0724766563);
	
	in_criminal_f := criminal_count > 5 or felony_count > 0;
	
	in_bb_cid_not_match_f := pf_cid_match = 0;
	
	in_inq_retail_count12_c := if(inq_retail_count12 = 0, 4.5, min(if(max(inq_retail_count12, 1) = NULL, -NULL, max(inq_retail_count12, 1)), 100));
	
	in_inq_retail_count12_rt := sqrt(in_inq_retail_count12_c);
	
	in_inq_ssnsperadl_f := inq_ssnsperadl > 1;
	
	in_cen_pop_gte_18_hi_f := cen_pop_gte_18 >= 90;
	
	in_c_med_inc_low_f :=  (real)C_MED_INC >= 1 AND (real)C_MED_INC <= 20;
	
	in_log := -14.7029901 +
	    in_pmt_quality_index_m * 8.3509360394 +
	    in_bb_entry_type_lvl_m * 10.780484833 +
	    in_bb_fandf_lvl_m * 11.681551273 +
	    in_nap_ver_lvl_m * 4.140331393 +
	    in_phn_prob_lvl_m * 2.2754335906 +
	    in_inq_coll_count12_lvl_m * 7.2350377257 +
	    in_inq_bank_count12_lvl_m * 2.7610092415 +
	    in_inq_addrsperadl_3_m * 1.7943638541 +
	    in_inq_lnamesperaddr_5_m * 4.1483033375 +
	    in_email_name_lvl_m * 14.811009708 +
	    in_adls_per_phone_2_m * 4.4308389261 +
	    in_ids_per_addr_max_c6_lvl_m * 3.8415360284 +
	    in_rel_prob_lvl_m * 3.2934943033 +
	    in_ams_lvl_m * 12.359117652 +
	    in_tm_ip_problem_lvl_m * 7.3942603459 +
	    in_c_span_lang_lvl_m * 5.5826645963 +
	    in_eq_first_seen_lvl_m * 2.0847244154 +
	    in_dist_a1toa2_lvl_m * 5.6726687654 +
	    in_dist_a1toa3_lvl_m * 5.4999010711 +
	    (integer)in_criminal_f * 0.438709511 +
	    (integer)in_bb_cid_not_match_f * 0.7525644506 +
	    in_inq_retail_count12_rt * 0.2218569849 +
	    (integer)in_inq_ssnsperadl_f * 0.5178007602 +
	    (integer)in_cen_pop_gte_18_hi_f * 0.3273749515 +
	    (integer)in_c_med_inc_low_f * 0.284586572 +
	    in_model_offset;
	
	bt_bb_entry_type_lvl := map(
	    bb_Entry_Type_ = 'KIOSK' => 3,
	    bb_Entry_Type_ = 'WEB'   => 2,
	    bb_Entry_Type_ = 'CCR'   => 0,
	                                1);
	
	bt_bb_entry_type_lvl_m := map(
	    bt_bb_entry_type_lvl = 0 => 0.0372670807,
	    bt_bb_entry_type_lvl = 1 => 0.0677570093,
	    bt_bb_entry_type_lvl = 2 => 0.0394096903,
	                                0.0013995801);
	
	bt_bb_pmt_x_avs_lvl := map(
	    (pf_pmt_type in ['CHASECONSUMER', 'HRS']) and pf_avs_ver_lvl = '1AZ'               => 9,
	    (pf_pmt_type in ['CHASECONSUMER', 'HRS']) and (pf_avs_ver_lvl in ['2AX', '3XZ'])   => 8,
	    (pf_pmt_type in ['AMERICANEXPRESS']) and (pf_avs_ver_lvl in ['1AZ', '2AX', '3XZ']) => 2,
	    (pf_pmt_type in ['PAYPAL', 'GIFT CARD'])                                           => 7,
	    (pf_pmt_type in ['VISA']) and (pf_avs_ver_lvl in ['1AZ', '2AX'])                   => 7,
	    pf_avs_ver_lvl = '2AX'                                                             => 7,
	    (pf_pmt_type in ['DINERS', 'JCB', 'MASTERCARD']) and pf_avs_ver_lvl = '1AZ'        => 6,
	    (pf_pmt_type in ['DISCOVER']) and pf_avs_ver_lvl = '1AZ'                           => 5,
	    pf_avs_ver_lvl = '3XZ'                                                             => 4,
	    pf_avs_ver_lvl = '4XX'                                                             => 3,
	    pf_avs_ver_lvl = '0NM'                                                             => 1,
	    (pf_avs_ver_lvl in ['5NO', '6UN'])                                                 => 0,
	                                                                                          6);
	
	bt_bb_pmt_x_avs_lvl_m := map(
	    bt_bb_pmt_x_avs_lvl = 0 => 0.2334123223,
	    bt_bb_pmt_x_avs_lvl = 1 => 0.1449044586,
	    bt_bb_pmt_x_avs_lvl = 2 => 0.093637455,
	    bt_bb_pmt_x_avs_lvl = 3 => 0.0766847405,
	    bt_bb_pmt_x_avs_lvl = 4 => 0.0587288817,
	    bt_bb_pmt_x_avs_lvl = 5 => 0.043320206,
	    bt_bb_pmt_x_avs_lvl = 6 => 0.028928659,
	    bt_bb_pmt_x_avs_lvl = 7 => 0.0203281823,
	    bt_bb_pmt_x_avs_lvl = 8 => 0.0134228188,
	                               0.005754386);
	
	bt_bb_cc_pmt_not_credit_srcd_f := cc_payment and not(credit_sourced);
	
	bt_eq_first_seen_lvl := map(
	    eq_add_not_sourced and cc_payment => 0,
	    eq_date_first_seen_mos > 192      => 3,
	    eq_date_first_seen_mos > 96       => 2,
	    eq_date_first_seen_mos > 48       => 1,
	                                         0);
	
	bt_eq_first_seen_lvl_m := map(
	    bt_eq_first_seen_lvl = 0 => 0.1155581261,
	    bt_eq_first_seen_lvl = 1 => 0.0880590134,
	    bt_eq_first_seen_lvl = 2 => 0.0520406615,
	                                0.0120235877);
	
	bt_verphn_lvl_c67 := map(
	    header_fst_seen_recent and no_match => 0,
	    header_fst_seen_recent              => 2,
	    no_match                            => 4,
	    not(ver_phn)                        => 5,
	                                           7);
	
	bt_verphn_lvl_c68 := map(
	    no_match or header_fst_seen_recent   => 0,
	    not(ver_phn) and ver_name < 3        => 1,
	    not(ver_phn and ver_add and ver_lst) => 3,
	                                            6);
	
	bt_verphn_lvl := if(add1_isbestmatch, bt_verphn_lvl_c67, bt_verphn_lvl_c68);
	
	bt_verphn_lvl_m := map(
	    bt_verphn_lvl = 0 => 0.1971830986,
	    bt_verphn_lvl = 1 => 0.1221238938,
	    bt_verphn_lvl = 2 => 0.0955844156,
	    bt_verphn_lvl = 3 => 0.0680317041,
	    bt_verphn_lvl = 4 => 0.04991274,
	    bt_verphn_lvl = 5 => 0.0392827915,
	    bt_verphn_lvl = 6 => 0.0295265983,
	                         0.0200186988);
	
	bt_inq_type_lvl := map(
	    many_inquiries and (inq_banking or hi_inq_adlsperaddr)             => 5,
	    many_inquiries                                                     => 4,
	    hi_inq_adlsperaddr or (inq_coll or inq_highrisk) and not(inq_auto) => 3,
	    inq_banking and not(inq_auto)                                      => 2,
	    inq_banking or inq_auto                                            => 0,
	                                                                          1);
	
	bt_inq_type_lvl_m := map(
	    bt_inq_type_lvl = 0 => 0.0155541154,
	    bt_inq_type_lvl = 1 => 0.0220175035,
	    bt_inq_type_lvl = 2 => 0.0309662776,
	    bt_inq_type_lvl = 3 => 0.0442687747,
	    bt_inq_type_lvl = 4 => 0.1711315474,
	                           0.3095838588);
	
	bt_email_name_lvl := map(
	    (integer)efirstscore > 1 or (integer)elastscore > 1 => 3,
	    (integer)efirstscore > 0 or (integer)elastscore > 0 => 2,
	    (integer)efirstscore = 0 or (integer)elastscore = 0 => 1,
	                                             0);
	
	bt_email_name_lvl_m := map(
	    bt_email_name_lvl = 0 => 0.0898366606,
	    bt_email_name_lvl = 1 => 0.0357531877,
	    bt_email_name_lvl = 2 => 0.0187613261,
	                             0.0099037329);
	
	bt_college_lvl := map(
	    ams_college_type = 'P'                                => 2,
	    (ams_college_type in ['R', 'S']) or prof_license_flag => 1,
	                                                             0);
	
	bt_college_lvl_m := map(
	    bt_college_lvl = 0 => 0.0436034713,
	    bt_college_lvl = 1 => 0.0215489307,
	                          0.012749004);
	
	bt_tm_ip_problem_lvl := map(
	    tm_problem_lvl = 0 and state_match_lvl = 1          => 0,
	    tm_problem_lvl = 0 and state_match_lvl > -2         => 1,
	    tm_problem_lvl = 1                                  => 3,
	    tm_problem_lvl = 2 and (state_match_lvl in [-1, 1]) => 4,
	    tm_problem_lvl = 2                                  => 5,
	    tm_problem_lvl = 3 or state_match_lvl = -1          => 5,
	    tm_problem_lvl = 4                                  => 6,
	                                                           2);
	
	bt_tm_ip_problem_lvl_m := map(
	    bt_tm_ip_problem_lvl = 0 => 0.0037350824,
	    bt_tm_ip_problem_lvl = 1 => 0.0072374228,
	    bt_tm_ip_problem_lvl = 2 => 0.0247247039,
	    bt_tm_ip_problem_lvl = 3 => 0.0466392318,
	    bt_tm_ip_problem_lvl = 4 => 0.1384097602,
	    bt_tm_ip_problem_lvl = 5 => 0.4899521531,
	                                0.9420174742);
	
	bt_addr_hist_lvl := map(
	    avg_mo_per_addr_low and avg_lres_low and (addr_stability_low or hist_addr_match_0) => 6,
	    hist_addr_match_0                                                                  => 5,
	    avg_mo_per_addr_low                                                                => 4,
	    addr_count_ge6_0 or max_lres_low or addr_stability_low                             => 3,
	    add1_lres0 or avg_lres_low                                                         => 2,
	    addr_count_ge10_0 and moved_2yr                                                    => 2,
	    addr_count_ge10_0 or moved_3mo                                                     => 1,
	                                                                                          0);
	
	bt_addr_hist_lvl_m := map(
	    bt_addr_hist_lvl = 0 => 0.014949229,
	    bt_addr_hist_lvl = 1 => 0.0176968453,
	    bt_addr_hist_lvl = 2 => 0.0323923068,
	    bt_addr_hist_lvl = 3 => 0.0939733046,
	    bt_addr_hist_lvl = 4 => 0.1268094962,
	    bt_addr_hist_lvl = 5 => 0.1583301993,
	                            0.2204042348);
	
	bt_ids_per_addr_max_lvl_c81 := map(
	    0 < ids_per_addr_max AND ids_per_addr_max <= 10 => 0,
	    0 < ids_per_addr_max AND ids_per_addr_max < 15  => 1,
	    0 < ids_per_addr_max AND ids_per_addr_max < 20  => 2,
	    0 < ids_per_addr_max AND ids_per_addr_max < 35  => 3,
	    0 < ids_per_addr_max AND ids_per_addr_max < 50  => 4,
	                                                       6);
	
	bt_ids_per_addr_max_lvl_c82 := map(
	    1 < ids_per_addr_max AND ids_per_addr_max < 20    => 4,
	    ids_per_addr_max > 0 and ids_per_addr_max_c6 <= 4 => 5,
	    ids_per_addr_max > 0                              => 6,
	                                                         5);
	
	bt_ids_per_addr_max_lvl := if(not(add_apt), bt_ids_per_addr_max_lvl_c81, bt_ids_per_addr_max_lvl_c82);
	
	bt_ids_per_addr_max_lvl_m := map(
	    bt_ids_per_addr_max_lvl = 0 => 0.0169260947,
	    bt_ids_per_addr_max_lvl = 1 => 0.0211716937,
	    bt_ids_per_addr_max_lvl = 2 => 0.0345864662,
	    bt_ids_per_addr_max_lvl = 3 => 0.0378787879,
	    bt_ids_per_addr_max_lvl = 4 => 0.0651391162,
	    bt_ids_per_addr_max_lvl = 5 => 0.1228452187,
	                                   0.3550042772);
	
	bt_c_incollege := map(
	    (real)C_INCOLLEGE >= 25.8 => 4,
	    (real)C_INCOLLEGE >= 9.5  => 3,
	    (real)C_INCOLLEGE >= 5.9  => 2,
	    (real)C_INCOLLEGE >= 4.4  => 1,
	                           0);
	
	bt_c_incollege_m := map(
	    bt_c_incollege = 0 => 0.0214643863,
	    bt_c_incollege = 1 => 0.0366502867,
	    bt_c_incollege = 2 => 0.0513689867,
	    bt_c_incollege = 3 => 0.0776409849,
	                          0.2022222222);
	
	bt_c_born_usa := map(
	    (real)C_BORN_USA >= 147 => 4,
	    (real)C_BORN_USA >= 73  => 3,
	    (real)C_BORN_USA >= 49  => 2,
	    (real)C_BORN_USA >= 29  => 1,
	                         0);
	
	bt_c_born_usa_m := map(
	    bt_c_born_usa = 0 => 0.1145703611,
	    bt_c_born_usa = 1 => 0.0609550131,
	    bt_c_born_usa = 2 => 0.0548041986,
	    bt_c_born_usa = 3 => 0.0210179271,
	                         0.0125676106);
	
	bt_c_many_cars := map(
	    (real)C_MANY_CARS >= 164 => 2,
	    (real)C_MANY_CARS >= 123 => 1,
	                          0);
	
	bt_c_many_cars_m := map(
	    bt_c_many_cars = 0 => 0.0537342597,
	    bt_c_many_cars = 1 => 0.0221636702,
	                          0.0141230567);
	
	bt_c_span_lang := map(
	    (real)C_SPAN_LANG >= 145 => 3,
	    (real)C_SPAN_LANG >= 105 => 2,
	    (real)C_SPAN_LANG >= 39  => 1,
	                          0);
	
	bt_c_span_lang_m := map(
	    bt_c_span_lang = 0 => 0.0193937276,
	    bt_c_span_lang = 1 => 0.0251182965,
	    bt_c_span_lang = 2 => 0.0533952029,
	                          0.0651549509);
	
	bt_bb_cid_not_match_f := pf_cid_match = 0;
	
	bt_bb_avg_pmt_amt_c := min(if(max(avg_pmt_amt, (real)1) = NULL, -NULL, max(avg_pmt_amt, (real)1)), 5000);
	
	bt_bb_avg_pmt_amt_rt := sqrt(bt_bb_avg_pmt_amt_c);
	
	bt_bb_next_day_ship_f := pf_ship_mode = 'NEXT DAY';
	
	bt_adls_per_phone_f := adls_per_phone > 0;
	
	bt_log := -14.14029796 +
	    bt_bb_entry_type_lvl_m * 34.530757925 +
	    bt_eq_first_seen_lvl_m * 4.4558650074 +
	    bt_bb_pmt_x_avs_lvl_m * 9.934032681 +
	    bt_verphn_lvl_m * 1.7491464597 +
	    bt_inq_type_lvl_m * 6.7738744301 +
	    bt_email_name_lvl_m * 20.424612811 +
	    bt_college_lvl_m * 16.126889328 +
	    bt_tm_ip_problem_lvl_m * 7.3383719633 +
	    bt_addr_hist_lvl_m * 3.773250994 +
	    bt_ids_per_addr_max_lvl_m * 3.044743943 +
	    bt_c_incollege_m * 2.7772464339 +
	    bt_c_born_usa_m * 2.5864497989 +
	    bt_c_many_cars_m * 6.2086336862 +
	    bt_c_span_lang_m * 7.3138098081 +
	    (integer)bt_bb_cid_not_match_f * 2.0786038665 +
	    bt_bb_avg_pmt_amt_rt * 0.1141639945 +
	    (integer)bt_bb_next_day_ship_f * 2.1401030024 +
	    (integer)bt_adls_per_phone_f * -0.283140643 +
	    bt_model_offset;
	
	st_avg_pmt_amt := map(
	    avg_pmt_amt = 0    => 0,
	    avg_pmt_amt <= 10  => 10,
	    avg_pmt_amt <= 25  => 25,
	    avg_pmt_amt <= 100 => 100,
	    avg_pmt_amt <= 250 => 250,
	    avg_pmt_amt <= 500 => 500,
	                          501);
	
	st_pmt_type_x_amt_lvl_c94 := map(
	    st_avg_pmt_amt <= 25  => 0,
	    st_avg_pmt_amt <= 500 => 2,
	                             7);
	
	st_pmt_type_x_amt_lvl_1 := map(
	    // (pf_pmt_type in ['CHASECONSUMER', 'GIFT CARD', 'HRS']) => st_pmt_type_x_amt_lvl_c94,
	    st_avg_pmt_amt = 25                                    => 1,
	    st_avg_pmt_amt = 500                                   => 8,
	                                                              9);
	
	st_pmt_type_x_amt_lvl_c96 := map(
	    st_avg_pmt_amt <= 100 => 2,
	    st_avg_pmt_amt <= 250 => 5,
	    st_avg_pmt_amt <= 500 => 8,
	                             9);
	
	st_pmt_type_x_amt_lvl_c97 := map(
	    st_avg_pmt_amt <= 100 => 2,
	    st_avg_pmt_amt <= 250 => 4,
	    st_avg_pmt_amt <= 500 => 8,
	                             9);
	
	st_pmt_type_x_amt_lvl_c98 := map(
	    st_avg_pmt_amt <= 25  => 1,
	    st_avg_pmt_amt <= 100 => 6,
	    st_avg_pmt_amt <= 250 => 7,
	    st_avg_pmt_amt <= 500 => 8,
	                             9);
	
	st_pmt_type_x_amt_lvl_c99 := if(pf_pmt_type = 'PAYPAL', 3, -1);
	
	// st_pmt_type_x_amt_lvl := map(
	    // (pf_pmt_type in ['CHASECONSUMER', 'GIFT CARD', 'HRS'])=> st_pmt_type_x_amt_lvl_c94,
	    // (pf_pmt_type in ['DINERS', 'DISCOVER', 'MASTERCARD']) => st_pmt_type_x_amt_lvl_c96,
	    // (pf_pmt_type in ['VISA'])                             => st_pmt_type_x_amt_lvl_c97,
	    // (pf_pmt_type in ['AMERICANEXPRESS'])                  => st_pmt_type_x_amt_lvl_c98,
	                                                             // st_pmt_type_x_amt_lvl_c99);
					
		case1 := TRIM(StringLib.StringToUpperCase(pf_pmt_type)) IN ['CHASECONSUMER', 'GIFT CARD', 'HRS'];																 
		case2 := TRIM(StringLib.StringToUpperCase(pf_pmt_type)) IN ['DINERS', 'DISCOVER', 'MASTERCARD'];																 
		case3 := TRIM(StringLib.StringToUpperCase(pf_pmt_type)) IN ['VISA'];																 
		case4 := TRIM(StringLib.StringToUpperCase(pf_pmt_type)) IN ['AMERICANEXPRESS'];																 
		case5 := TRIM(StringLib.StringToUpperCase(pf_pmt_type)) IN ['PAYPAL'];	
		
		st_pmt_type_x_amt_lvl := map(
																	case1 AND st_avg_pmt_amt <= 25		=> 0,
																	case1 AND st_avg_pmt_amt <= 500		=> 2,
																	case1 AND st_avg_pmt_amt <= 501		=> 7,
																	NOT case1 AND st_avg_pmt_amt = 25	=> 1,
																	NOT case1 AND st_avg_pmt_amt = 500=> 8,
																	NOT case1 AND st_avg_pmt_amt = 501=> 9,
																	case2 AND st_avg_pmt_amt <= 100		=> 2,
																	case2 AND st_avg_pmt_amt <= 250		=> 5,
																	case2 AND st_avg_pmt_amt <= 500		=> 8,
																	case2 AND st_avg_pmt_amt <= 501		=> 9,
																	case3 AND st_avg_pmt_amt <= 100		=> 2,
																	case3 AND st_avg_pmt_amt <= 250		=> 4,
																	case3 AND st_avg_pmt_amt <= 500		=> 8,
																	case3 AND st_avg_pmt_amt <= 501		=> 9,
																	case4 AND st_avg_pmt_amt <= 25 		=> 1,
																	case4 AND st_avg_pmt_amt <= 100 	=> 6,
																	case4 AND st_avg_pmt_amt <= 250 	=> 7,
																	case4 AND st_avg_pmt_amt <= 500 	=> 8,
																	case4 AND st_avg_pmt_amt <= 501 	=> 9,
																	case5 														=> 3,
																																			-1
																);
	
	pf_avs_ver_lvl_num := (integer)(pf_avs_ver_lvl)[1..1];
	
	st_pmt_quality_index := map(
	    st_pmt_type_x_amt_lvl = 0                                                     => 11,
	    st_pmt_type_x_amt_lvl = 1 and (pf_avs_ver_lvl_num in [0, 1, 2])               => 11,
	    st_pmt_type_x_amt_lvl = 1 and (pf_avs_ver_lvl_num in [3, 4, 7])               => 10,
	    st_pmt_type_x_amt_lvl = 2 and (pf_avs_ver_lvl_num in [0, 1, 2])               => 10,
	    st_pmt_type_x_amt_lvl = 2 and (pf_avs_ver_lvl_num in [3, 4, 7])               => 9,
	    st_pmt_type_x_amt_lvl = 3 and (pf_avs_ver_lvl_num in [0, 1, 2, 3, 4, 7])      => 8,
	    st_pmt_type_x_amt_lvl = 4 and (pf_avs_ver_lvl_num in [0, 1, 2, 3])            => 7,
	    st_pmt_type_x_amt_lvl = 5 and (pf_avs_ver_lvl_num in [0, 1, 2, 3])            => 6,
	    (st_pmt_type_x_amt_lvl in [1, 2, 3]) and (pf_avs_ver_lvl_num in [5, 6])       => 5,
	    (st_pmt_type_x_amt_lvl in [6, 7]) and (pf_avs_ver_lvl_num in [0])             => 5,
	    (st_pmt_type_x_amt_lvl in [6, 7, 8]) and (pf_avs_ver_lvl_num in [1, 2, 3])    => 4,
	    (st_pmt_type_x_amt_lvl in [4, 5, 6, 7, 8]) and (pf_avs_ver_lvl_num in [7])    => 4,
	    (st_pmt_type_x_amt_lvl in [4, 5, 6, 7]) and (pf_avs_ver_lvl_num in [4, 5, 6]) => 3,
	    (st_pmt_type_x_amt_lvl in [8]) and (pf_avs_ver_lvl_num in [0])                => 3,
	    (st_pmt_type_x_amt_lvl in [8]) and (pf_avs_ver_lvl_num in [4, 5, 6])          => 2,
	    (st_pmt_type_x_amt_lvl in [9]) and (pf_avs_ver_lvl_num in [0])                => 2,
	    (st_pmt_type_x_amt_lvl in [9]) and (pf_avs_ver_lvl_num in [1, 2, 3, 7])       => 1,
	    (st_pmt_type_x_amt_lvl in [9]) and (pf_avs_ver_lvl_num in [4, 5, 6])          => 0,
	                                                                                     4);
	
	st_pmt_quality_index_m := map(
	    st_pmt_quality_index = 0  => 0.8888888889,
	    st_pmt_quality_index = 1  => 0.5960539979,
	    st_pmt_quality_index = 2  => 0.5694444444,
	    st_pmt_quality_index = 3  => 0.3636363636,
	    st_pmt_quality_index = 4  => 0.2095337873,
	    st_pmt_quality_index = 5  => 0.1494325347,
	    st_pmt_quality_index = 6  => 0.1092124814,
	    st_pmt_quality_index = 7  => 0.0847533632,
	    st_pmt_quality_index = 8  => 0.0755813953,
	    st_pmt_quality_index = 9  => 0.0601036269,
	    st_pmt_quality_index = 10 => 0.0265188719,
	                                 0.0038714673);
	
	st_are_relatives_lvl := map(
	    btst_are_relatives       => 2,
	    btst_relatives_in_common => 1,
	                                0);
	
	st_are_relatives_lvl_m := map(
	    st_are_relatives_lvl = 0 => 0.1691519105,
	    st_are_relatives_lvl = 1 => 0.0739750446,
	                                0.0584972264);
	
	st_shipping_lvl := map(
	    pf_ship_mode = 'GROUND'     => 2,
	    pf_ship_mode = 'SECOND DAY' => 1,
	    pf_ship_mode = 'NEXT DAY'   => 0,
	                                   1);
	
	st_shipping_lvl_m := map(
	    st_shipping_lvl = 0 => 0.5564325178,
	    st_shipping_lvl = 1 => 0.1226666667,
	                           0.0789473684);
	
	contrary_inf_s := (infutor_nap_s in [1]);
	
	verfst_i_s := (infutor_nap_s in [2, 3, 4, 8, 9, 10, 12]);
	
	verlst_i_s := (infutor_nap_s in [2, 5, 7, 8, 9, 11, 12]);
	
	veradd_i_s := (infutor_nap_s in [3, 5, 6, 8, 10, 11, 12]);
	
	verphn_i_s := (infutor_nap_s in [4, 6, 7, 9, 10, 11, 12]);
	
	contrary_phn_s := (nap_summary_s in [1]);
	
	verfst_p_s := (nap_summary_s in [2, 3, 4, 8, 9, 10, 12]);
	
	verlst_p_s := (nap_summary_s in [2, 5, 7, 8, 9, 11, 12]);
	
	veradd_p_s := (nap_summary_s in [3, 5, 6, 8, 10, 11, 12]);
	
	verphn_p_s := (nap_summary_s in [4, 6, 7, 9, 10, 11, 12]);
	
	contrary_ssn_s := (nas_summary_s in [1]);
	
	verfst_s_s := (nas_summary_s in [2, 3, 4, 8, 9, 10, 12]);
	
	verlst_s_s := (nas_summary_s in [2, 5, 7, 8, 9, 11, 12]);
	
	veradd_s_s := (nas_summary_s in [3, 5, 6, 8, 10, 11, 12]);
	
	verssn_s_s := (nas_summary_s in [4, 6, 7, 9, 10, 11, 12]);
	
	nas_479_s_1 := (nas_summary_s in [4, 7, 9]);
	
	nas_479_s := (nas_summary_s in [4, 7, 9]);
	
	_header_first_seen_s := Common.SAS_Date((STRING)(header_first_seen_s));
	
	_header_last_seen_s := Common.SAS_Date((STRING)(header_last_seen_s));
	
	mos_header_first_seen_s := if(min(sysdate, _header_first_seen_s) = NULL, NULL, truncate((sysdate - _header_first_seen_s) / (365.25 / 12)));
	
	mos_header_last_seen_s := if(min(sysdate, _header_last_seen_s) = NULL, NULL, truncate((sysdate - _header_last_seen_s) / (365.25 / 12)));
	
	header_fst_seen_recent_s := 0 <= mos_header_first_seen_s AND mos_header_first_seen_s <= 48;
	
	header_lst_seen_recent_s := mos_header_last_seen_s <= 0;
	
	ver_add_s := veradd_i_s or veradd_p_s;
	
	ver_phn_s := verphn_i_s or verphn_p_s;
	
	ver_fst_s := verfst_i_s or verfst_p_s;
	
	ver_lst_s := verlst_i_s or verlst_p_s;
	
	con_phn_s := contrary_inf_s or contrary_phn_s;
	
	st_verphn_lvl := map(
	    header_fst_seen_recent                                      => 0,
	    not(ver_add_s) and no_match or not((ver_name in [0, 2, 3])) => 1,
	    not(ver_add_s) and not(ver_phn)                             => 2,
	    no_match or ver_name = 0                                    => 3,
	    not(ver_add_s) or not(ver_phn)                              => 4,
	    ver_name != 3                                               => 5,
	                                                                   6);
	
	st_verphn_lvl_m := map(
	    st_verphn_lvl = 0 => 0.3619167718,
	    st_verphn_lvl = 1 => 0.2411214953,
	    st_verphn_lvl = 2 => 0.1653905054,
	    st_verphn_lvl = 3 => 0.1155378486,
	    st_verphn_lvl = 4 => 0.094437611,
	    st_verphn_lvl = 5 => 0.0586253369,
	                         0.0368072787);
	
	st_phn_prob_lvl := map(
	    phn_inval or phn_nonus or phn_highrisk                         => 7,
	    phn_business                                                   => 6,
	    not(phn_residential) and phn_bad_counts and not(phn_cellpager) => 6,
	    not(phn_residential) and not(phn_notpots)                      => 5,
	    not(phn_residential) and phn_bad_counts                        => 4,
	    phn_bad_counts                                                 => 3,
	    phn_notpots                                                    => 2,
	    not(phn_last_seen_rec)                                         => 1,
	                                                                      0);
	
	st_phn_prob_lvl_m := map(
	    st_phn_prob_lvl = 0 => 0.0469141997,
	    st_phn_prob_lvl = 1 => 0.0623255814,
	    st_phn_prob_lvl = 2 => 0.0880553767,
	    st_phn_prob_lvl = 3 => 0.0919335706,
	    st_phn_prob_lvl = 4 => 0.1442570647,
	    st_phn_prob_lvl = 5 => 0.1753402722,
	    st_phn_prob_lvl = 6 => 0.2329545455,
	                           0.3928571429);
	
	vacant_addr_s := add1_advo_address_vacancy_s = 'Y';
	
	add_correction_s := (integer)rc_hrisksic_s = 2225;
	
	add_apt_s := StringLib.StringToUpperCase(trim((string)rc_dwelltype_s, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim((string)out_addr_type_s, LEFT, RIGHT)) = 'H' or out_unit_desig_s != ' ' or out_sec_range_s != ' ';
	
	add_highrisk_s := (integer)rc_hriskaddrflag_s = 4 or (integer)rc_addrcommflag_s = 2;
	
	business_s := add1_advo_res_or_business_s = 'B';
	
	st_addr_prob_lvl_s := map(
	    vacant_addr_s or (boolean)(integer)drop_addr_s or add_correction_s => 3,
	    add_apt_s or add_highrisk_s                                        => 2,
	    business_s                                                         => 1,
	                                                                          0);
	
	st_addr_prob_lvl_s_m := map(
	    st_addr_prob_lvl_s = 0 => 0.0686780468,
	    st_addr_prob_lvl_s = 1 => 0.1114357262,
	    st_addr_prob_lvl_s = 2 => 0.1879454286,
	                              0.4183266932);
	
	st_inq_coll_combo_lvl := map(
	    inq_collection_count12 > 2 and inq_collection_count12_s > 2 => 2,
	    inq_collection_count12 > 2                                  => 1,
	                                                                   0);
	
	st_inq_coll_combo_lvl_m := map(
	    st_inq_coll_combo_lvl = 0 => 0.0973186032,
	    st_inq_coll_combo_lvl = 1 => 0.1961389961,
	                                 0.2354014599);
	
	st_inq_bank_combo_lvl := map(
	    inq_banking_count12 > 1 or inq_banking_count12_s > 1 => 2,
	    inq_banking_count12 > 0 or inq_banking_count12_s > 0 => 1,
	                                                            0);
	
	st_inq_bank_combo_lvl_m := map(
	    st_inq_bank_combo_lvl = 0 => 0.0926541159,
	    st_inq_bank_combo_lvl = 1 => 0.1637931034,
	                                 0.2100350058);
	
	st_adls_per_addr_c6_combo_lvl := map(
	    adls_per_addr_c6 = 0 and adls_per_addr_c6_s = 0 => 4,
	    adls_per_addr_c6 > 4 or adls_per_addr_c6_s > 4  => 3,
	    adls_per_addr_c6 = 0 and adls_per_addr_c6_s > 2 => 2,
	    adls_per_addr_c6 = 1 and adls_per_addr_c6_s = 4 => 2,
	    adls_per_addr_c6 + adls_per_addr_c6_s >= 4      => 1,
	    adls_per_addr_c6 = 3 and adls_per_addr_c6_s = 0 => 1,
	                                                       0);
	
	st_adls_per_addr_c6_combo_lvl_m := map(
	    st_adls_per_addr_c6_combo_lvl = 0 => 0.0912443367,
	    st_adls_per_addr_c6_combo_lvl = 1 => 0.1144545943,
	    st_adls_per_addr_c6_combo_lvl = 2 => 0.1768115942,
	    st_adls_per_addr_c6_combo_lvl = 3 => 0.3157142857,
	                                         0.1100234926);
	
	st_email_domain_lvl := map(
	    _email_topleveldomain = 'OTHER'                                      => 5,
	     email_topleveldomain = ''                                           => 4,
	    _email_secondleveldomain = 'GMAIL'                                   => 3,
	    _email_secondleveldomain = 'OTHER' and _email_topleveldomain = 'COM' => 2,
	    (_email_secondleveldomain in ['HOTMAIL', 'YAHOO'])                   => 1,
	                                                                            0);
	
	st_email_domain_lvl_m := map(
	    st_email_domain_lvl = 0 => 0.0275543041,
	    st_email_domain_lvl = 1 => 0.0643639109,
	    st_email_domain_lvl = 2 => 0.0727626459,
	    st_email_domain_lvl = 3 => 0.153175157,
	    st_email_domain_lvl = 4 => 0.2334869432,
	                               0.6879432624);
	
	st_efirstscore_lvl := map(
	    (integer)efirstscore = 3                      				 => 4,
	    (integer)efirstscore = -1 and (integer)elastscore = -1 => 0,
	    (integer)efirstscore = 0 and (integer)elastscore = 0   => 1,
	    (integer)efirstscore = 1 and (integer)elastscore = 1   => 2,
																																3);
	
	st_efirstscore_lvl_m := map(
	    st_efirstscore_lvl = 0 => 0.2334869432,
	    st_efirstscore_lvl = 1 => 0.1359166011,
	    st_efirstscore_lvl = 2 => 0.0755451713,
	    st_efirstscore_lvl = 3 => 0.0488454707,
	                              0.0260092116);
	
	_add1_date_last_seen_s := Common.SAS_Date((STRING)(add1_date_last_seen_s));
	
	mos_add1_date_last_seen_s := if(min(sysdate, _add1_date_last_seen_s) = NULL, NULL, truncate((sysdate - _add1_date_last_seen_s) / 365.25));
	
	seen_recently_s := mos_add1_date_last_seen_s = 0;
	
	family_owned_s := add1_naprop_s = 3 or (boolean)(integer)add1_family_owned_s;
	
	app_owned_s := add1_naprop_s = 4 and (boolean)(integer)add1_applicant_owned_s and property_owned_total_s > 0;
	
	stolen_addr_s := (add1_naprop_s in [1, 2]);
	
	nothing_found_s := add1_naprop_s = 0;
	
	property_owner_s := property_owned_total_s > 0;
	
	st_naprop_lvl_s := map(
	    not(seen_recently_s) and nothing_found_s and not(property_owner_s) => 0,
	    not(seen_recently_s) and stolen_addr_s and not(property_owner_s)   => 1,
	    nothing_found_s                                                    => 2,
	    stolen_addr_s                                                      => 3,
	    not(app_owned_s) or not(family_owned_s)                            => 4,
	                                                                          5);
	
	st_naprop_lvl_s_m := map(
	    st_naprop_lvl_s = 0 => 0.2737926136,
	    st_naprop_lvl_s = 1 => 0.1653834309,
	    st_naprop_lvl_s = 2 => 0.1099252935,
	    st_naprop_lvl_s = 3 => 0.0761741123,
	    st_naprop_lvl_s = 4 => 0.0581119032,
	                           0.0331475506);
	
	st_c_low_ed_s := if((real)C_LOW_ED_s >= 19.3, 1, 0);
	
	st_c_low_ed_s_m := map((real)st_c_low_ed_s = 0 => 0.0821529745,
													      										 0.1177894801);
	
	st_c_unemp_s := map(
	    (real)C_UNEMP_s >= 3.3 => 4,
	    (real)C_UNEMP_s >= 2.8 => 3,
	    (real)C_UNEMP_s >= 2.2 => 2,
	    (real)C_UNEMP_s >= 1.4 => 1,
	                        0);
	
	st_c_unemp_s_m := map(
	    st_c_unemp_s = 0 => 0.0713452566,
	    st_c_unemp_s = 1 => 0.0810596026,
	    st_c_unemp_s = 2 => 0.091750503,
	    st_c_unemp_s = 3 => 0.1291040623,
	                        0.1571567402);
	
	st_c_robbery_s := map(
	    (real)C_ROBBERY_s >= 166 => 2,
	    (real)C_ROBBERY_s >= 135 => 1,
	                          0);
	
	st_c_robbery_s_m := map(
	    st_c_robbery_s = 0 => 0.0786709539,
	    st_c_robbery_s = 1 => 0.1527520099,
	                          0.211023622);
	
	st_c_span_lang_s := map(
	    (integer)C_SPAN_LANG_s >= 155 => 3,
	    (integer)C_SPAN_LANG_s >= 105 => 2,
	    (integer)C_SPAN_LANG_s >= 93  => 1,
	                            0);
	
	st_c_span_lang_s_m := map(
	    st_c_span_lang_s = 0 => 0.0603873038,
	    st_c_span_lang_s = 1 => 0.0942593905,
	    st_c_span_lang_s = 2 => 0.1162040026,
	                            0.2174447174);
	
	st_c_rural_p := map(
	    (real)C_RURAL_P >= 30.3 => 2,
	    (real)C_RURAL_P >= 8.0  => 1,
	                         0);
	
	st_c_rural_p_m := map(
	    st_c_rural_p = 0 => 0.1290869624,
	    st_c_rural_p = 1 => 0.0843727073,
	                        0.0574552221);
	
	st_tm_ip_problem_lvl := map(
	    tm_problem_lvl = 0 and state_match_lvl = 1          => 0,
	    tm_problem_lvl = 0 and state_match_lvl > -2         => 1,
	    tm_problem_lvl = 1                                  => 3,
	    tm_problem_lvl = 2 and (state_match_lvl in [-1, 1]) => 4,
	    tm_problem_lvl = 2                                  => 5,
	    tm_problem_lvl = 3 or state_match_lvl = -1          => 5,
	    tm_problem_lvl = 4                                  => 6,
	                                                           2);
	
	st_tm_ip_problem_lvl_m := map(
	    st_tm_ip_problem_lvl = 0 => 0.0165027234,
	    st_tm_ip_problem_lvl = 1 => 0.0406438632,
	    st_tm_ip_problem_lvl = 2 => 0.1175298805,
	    st_tm_ip_problem_lvl = 3 => 0.0819672131,
	    st_tm_ip_problem_lvl = 4 => 0.4466527197,
	    st_tm_ip_problem_lvl = 5 => 0.6498951782,
	                                0.9676870748);
	
	st_hist_addr_match_lvl := map(
	    hist_addr_match_s = -9999 and hist_addr_match = 0 => 0,
	    hist_addr_match_s = 0 and hist_addr_match = 0     => 1,
	    hist_addr_match_s = -9999 or hist_addr_match = 0  => 2,
	    hist_addr_match_s = 0 and hist_addr_match != 0    => 3,
	                                                         4);
	
	st_hist_addr_match_lvl_m := map(
	    st_hist_addr_match_lvl = 0 => 0.4929078014,
	    st_hist_addr_match_lvl = 1 => 0.3246753247,
	    st_hist_addr_match_lvl = 2 => 0.1767483697,
	    st_hist_addr_match_lvl = 3 => 0.1339013999,
	                                  0.0535662581);
	
	st_distaddraddr2_lvl := map(
	    (integer)distaddraddr2 <= 10   => 0,
	    (integer)distaddraddr2 <= 2000 => 1,
																		    2);
	
	st_distaddraddr2_lvl_m := map(
	    st_distaddraddr2_lvl = 0 => 0.0834151129,
	    st_distaddraddr2_lvl = 1 => 0.1248207885,
	                                0.1758241758);
	
	st_add1_turnover_1yr_out_s_lvl := map(
	    add1_turnover_1yr_out_s >= 444 => 3,
	    add1_turnover_1yr_out_s >= 298 => 2,
	    add1_turnover_1yr_out_s >= 142 => 1,
	                                      0);
	
	st_add1_turnover_1yr_out_s_lvl_m := map(
	    st_add1_turnover_1yr_out_s_lvl = 0 => 0.0469483568,
	    st_add1_turnover_1yr_out_s_lvl = 1 => 0.0821804667,
	    st_add1_turnover_1yr_out_s_lvl = 2 => 0.1195949644,
	                                          0.1323140253);
	
	impulse_email_s := contains_i(email_source_list_s, 'IM') > 0;
	
	st_impulse_flag_s := impulse_email_s or impulse_count_s > 0;
	
	st_log := -18.74383734 +
	    st_pmt_quality_index_m * 5.0458610514 +
	    st_are_relatives_lvl_m * 7.4418623523 +
	    st_shipping_lvl_m * 4.0150580819 +
	    st_verphn_lvl_m * 1.7267956336 +
	    st_phn_prob_lvl_m * 1.8256921237 +
	    st_addr_prob_lvl_s_m * 1.5394482525 +
	    st_inq_coll_combo_lvl_m * 4.5755453416 +
	    st_inq_bank_combo_lvl_m * 3.2717228465 +
	    st_adls_per_addr_c6_combo_lvl_m * 3.0504061834 +
	    st_email_domain_lvl_m * 2.0113519087 +
	    st_efirstscore_lvl_m * 8.901284364 +
	    st_naprop_lvl_s_m * 2.0882054256 +
	    st_c_low_ed_s_m * 19.190208659 +
	    st_c_unemp_s_m * 5.1406007034 +
	    st_c_robbery_s_m * 3.1095311174 +
	    st_c_span_lang_s_m * 2.8430567295 +
	    st_c_rural_p_m * 6.1383969236 +
	    st_tm_ip_problem_lvl_m * 6.1873920747 +
	    st_hist_addr_match_lvl_m * 1.6825100411 +
	    st_distaddraddr2_lvl_m * 14.864428735 +
	    st_add1_turnover_1yr_out_s_lvl_m * 3.6307192684 +
	    (integer)st_impulse_flag_s * 1.0570402279 +
	    st_model_offset;
	
	d0_infutor_nap := map(
	    infutor_nap = 0   => -0.053607,
	    infutor_nap <= 6  => 0.263617,
	    infutor_nap <= 12 => -0.616351,
	                         0);
	
	d0_veradd_p := map(
	    (integer)veradd_p = 0 => 0.202536,
	    (integer)veradd_p = 1 => -0.361981,
	                    0);
	
	d0_c_span_lang := map(
	    (integer)C_SPAN_LANG < 66   => -0.880440,
	    (integer)C_SPAN_LANG < 159  => 0.123512,
	    (integer)C_SPAN_LANG >= 159 => 0.303533,
	                          0);
	
	d0_efirstscore := map(
	    trim(efirstscore) = '-1' => 0.409849,
	    (integer)efirstscore = 0  => -0.186217,
	    (integer)efirstscore <= 2 => -0.371254,
	    (integer)efirstscore = 3  => -0.544233,
	                        0);
	
	d0_elastscore := map(
	    elastscore = '-1' => 0.304083,
	    (integer)elastscore = 0  => -0.068583,
	    (integer)elastscore <= 3 => -0.402785,
	                       0);
	
	d0_pf_pmt_type := map(
	    (pf_pmt_type in ['AMERICANEXPRESS'])                             => 0.405140,
	    (pf_pmt_type in ['CHASECONSUMER', 'GIFT CARD', 'HRS', 'PAYPAL']) => -0.722039,
	                                                                        0.028926);
	
	d0_pf_ship_mode := map(
	    (pf_ship_mode in ['GROUND'])      => -0.057307,
	    (pf_ship_mode in ['NEXT DAY'])    => 1.085706,
	    (pf_ship_mode in ['NOT SHIPPED']) => -0.752681,
	    (pf_ship_mode in ['SECOND DAY'])  => 0.366945,
	                                         0.000000);
	
	d0_avs_addr_ver := map(
	    (avs_addr_ver in [0]) => 0.006120,
	    (avs_addr_ver in [1]) => -0.010301,
	                             0.000000);
	
	d0_avs_zip5_ver := map(
	    (avs_zip5_ver in [0]) => 0.459965,
	    (avs_zip5_ver in [1]) => -0.573398,
	                             0.000000);
	
	d0_pf_cid_match := map(
	    (pf_cid_match in [-1]) => -0.372986,
	    (pf_cid_match in [0])  => 0.804804,
	    (pf_cid_match in [1])  => 0.118103,
	                              0.000000);
	
	d0_tm_problem_lvl := map(
	    (tm_problem_lvl in [0, 1]) => -1.762274,
	    (tm_problem_lvl in [2])    => 1.497234,
	    (tm_problem_lvl in [3])    => 2.136369,
	    (tm_problem_lvl in [4])    => 3.156152,
	                                  0.000000);
	
	d0_state_match_lvl := map(
	    (state_match_lvl in [-2]) => 1.775722,
	    (state_match_lvl in [-1]) => -1.190511,
	    (state_match_lvl in [0])  => 0.269636,
	    (state_match_lvl in [1])  => -0.328380,
	                                 0.000000);
	
	d0_avg_pmt_amt := map(
	    avg_pmt_amt < 27.48                            => -1.833919,
	    27.48 <= avg_pmt_amt AND avg_pmt_amt < 54.17   => -1.506826,
	    54.17 <= avg_pmt_amt AND avg_pmt_amt < 76.99   => -0.922215,
	    76.99 <= avg_pmt_amt AND avg_pmt_amt < 101.27  => -0.710858,
	    101.27 <= avg_pmt_amt AND avg_pmt_amt < 221.49 => -0.149812,
	    221.49 <= avg_pmt_amt AND avg_pmt_amt < 524.98 => 0.578594,
	    524.98 <= avg_pmt_amt                          => 1.497271,
	                                                      0.000000);
	
	d0_rawscore := d0_infutor_nap +
	    d0_veradd_p +
	    d0_c_span_lang +
	    d0_efirstscore +
	    d0_elastscore +
	    d0_pf_pmt_type +
	    d0_pf_ship_mode +
	    d0_avs_addr_ver +
	    d0_avs_zip5_ver +
	    d0_pf_cid_match +
	    d0_tm_problem_lvl +
	    d0_state_match_lvl +
	    d0_avg_pmt_amt;
	
	d0_log := d0_rawscore * 1.000000 + -3.147860;
	
	base := 750;
	
	point := -25;
	
	odds := 0.58 / 99.42;
	
	in_phat := exp(in_log) / (1 + exp(in_log));
	
	in_score := round(point * (ln(in_phat / (1 - in_phat)) - ln(odds)) / ln(2) + base);
	
	st_phat := exp(st_log) / (1 + exp(st_log));
	
	st_score := round(point * (ln(st_phat / (1 - st_phat)) - ln(odds)) / ln(2) + base);
	
	bt_phat := exp(bt_log) / (1 + exp(bt_log));
	
	bt_score := round(point * (ln(bt_phat / (1 - bt_phat)) - ln(odds)) / ln(2) + base);
	
	d0_phat := exp(d0_log) / (1 + exp(d0_log));
	
	d0_score := round(point * (ln(d0_phat / (1 - d0_phat)) - ln(odds)) / ln(2) + base);
	
	best_buy_refresh := map(
	    eg_segment = 'INSTORE' => in_score,
	    eg_segment = 'SHIPTO'  => st_score,
	    eg_segment = 'BILLTO'  => bt_score,
	    eg_segment = 'DID0'    => d0_score,
	                              -1);
	
	cdn1109_1_0 := max(250, min(999, if(best_buy_refresh = NULL, -NULL, best_buy_refresh)));
	

	// #warning: Make sure to put the reason code logic here

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.addrscore := addrscore;
		SELF.bb_line_type_header_ := bb_line_type_header_;
		SELF.bb_ship_mode_ := bb_ship_mode_;
		SELF.bb_original_total_amount_ := bb_original_total_amount_;
		SELF.bb_item_lines_ := bb_item_lines_;
		SELF.bb_paypal_customer_id_ := bb_paypal_customer_id_;
		SELF.bb_cc_type_ := bb_cc_type_;
		SELF.pf_raw_avs_code := pf_raw_avs_code;
		SELF.bb_cvv_description_ := bb_cvv_description_;
		SELF.bb_entry_type_ := bb_entry_type_;
		SELF.tm_device_result_ := tm_device_result_;
		SELF.tm_browser_language_ := tm_browser_language_;
		SELF.tm_proxy_ip_geo_ := tm_proxy_ip_geo_;
		SELF.tm_reason_code_ := tm_reason_code_;
		SELF.tm_time_zone_hours_ := tm_time_zone_hours_;
		SELF.tm_true_ip_geo_ := tm_true_ip_geo_;
		SELF.tm_policy_score_ := tm_policy_score_;
		SELF.tm_true_ip_region_ := tm_true_ip_region_;
		SELF.firstscore := firstscore;
		SELF.lastscore := lastscore;
		SELF.bb_marked_for_full_name_h := bb_marked_for_full_name_h;
		SELF.btst_relatives_in_common := btst_relatives_in_common;
		SELF.efirstscore := efirstscore;
		SELF.elastscore := elastscore;
		SELF.btst_are_relatives := btst_are_relatives;
		SELF.drop_addr_s := drop_addr_s;
		SELF.distaddraddr2 := distaddraddr2;
		SELF.truedid := truedid;
		SELF.in_state := in_state;
		SELF.out_unit_desig := out_unit_desig;
		SELF.out_sec_range := out_sec_range;
		SELF.out_addr_type := out_addr_type;
		SELF.in_email_address := in_email_address;
		SELF.nap_summary := nap_summary;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_phonetype := rc_phonetype;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_first_seen := ver_sources_first_seen;
		SELF.ver_sources_count := ver_sources_count;
		SELF.ver_addr_sources := ver_addr_sources;
		SELF.addrpop := addrpop;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_lres := add1_lres;
		SELF.dist_a1toa2 := dist_a1toa2;
		SELF.dist_a1toa3 := dist_a1toa3;
		SELF.avg_lres := avg_lres;
		SELF.max_lres := max_lres;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.avg_mo_per_addr := avg_mo_per_addr;
		SELF.addr_count_ge3 := addr_count_ge3;
		SELF.addr_count_ge6 := addr_count_ge6;
		SELF.addr_count_ge10 := addr_count_ge10;
		SELF.hist_addr_match := hist_addr_match;
		SELF.telcordia_type := telcordia_type;
		SELF.gong_did_first_seen := gong_did_first_seen;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.gong_did_first_ct := gong_did_first_ct;
		SELF.gong_did_last_ct := gong_did_last_ct;
		SELF.header_first_seen := header_first_seen;
		SELF.header_last_seen := header_last_seen;
		SELF.adls_per_addr := adls_per_addr;
		SELF.ssns_per_addr := ssns_per_addr;
		SELF.adls_per_phone := adls_per_phone;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.ssns_per_addr_c6 := ssns_per_addr_c6;
		SELF.inq_count12 := inq_count12;
		SELF.inq_collection_count12 := inq_collection_count12;
		SELF.inq_auto_count12 := inq_auto_count12;
		SELF.inq_banking_count12 := inq_banking_count12;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_retail_count12 := inq_retail_count12;
		SELF.inq_communications_count12 := inq_communications_count12;
		SELF.inq_ssnsperadl := inq_ssnsperadl;
		SELF.inq_addrsperadl := inq_addrsperadl;
		SELF.inq_adlsperaddr := inq_adlsperaddr;
		SELF.inq_lnamesperaddr := inq_lnamesperaddr;
		SELF.infutor_nap := infutor_nap;
		SELF.email_domain_edu_count := email_domain_edu_count;
		SELF.attr_addrs_last30 := attr_addrs_last30;
		SELF.attr_addrs_last90 := attr_addrs_last90;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.rel_count := rel_count;
		SELF.rel_prop_owned_count := rel_prop_owned_count;
		SELF.rel_incomeunder50_count := rel_incomeunder50_count;
		SELF.rel_incomeunder75_count := rel_incomeunder75_count;
		SELF.rel_incomeunder100_count := rel_incomeunder100_count;
		SELF.rel_incomeover100_count := rel_incomeover100_count;
		SELF.rel_homeunder100_count := rel_homeunder100_count;
		SELF.rel_homeunder150_count := rel_homeunder150_count;
		SELF.rel_homeunder200_count := rel_homeunder200_count;
		SELF.rel_homeunder300_count := rel_homeunder300_count;
		SELF.rel_homeunder500_count := rel_homeunder500_count;
		SELF.rel_homeover500_count := rel_homeover500_count;
		SELF.rel_educationunder12_count := rel_educationunder12_count;
		SELF.rel_educationover12_count := rel_educationover12_count;
		SELF.rel_ageunder30_count := rel_ageunder30_count;
		SELF.rel_ageunder40_count := rel_ageunder40_count;
		SELF.rel_ageunder50_count := rel_ageunder50_count;
		SELF.rel_ageunder60_count := rel_ageunder60_count;
		SELF.rel_ageunder70_count := rel_ageunder70_count;
		SELF.rel_ageover70_count := rel_ageover70_count;
		SELF.rel_vehicle_owned_count := rel_vehicle_owned_count;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_college_type := ams_college_type;
		SELF.prof_license_flag := prof_license_flag;
		SELF.addr_stability_v2 := addr_stability_v2;
		SELF.archive_date := archive_date;
		SELF.out_unit_desig_s := out_unit_desig_s;
		SELF.out_sec_range_s := out_sec_range_s;
		SELF.out_addr_type_s := out_addr_type_s;
		SELF.nas_summary_s := nas_summary_s;
		SELF.nap_summary_s := nap_summary_s;
		SELF.rc_hriskaddrflag_s := rc_hriskaddrflag_s;
		SELF.rc_dwelltype_s := rc_dwelltype_s;
		SELF.rc_addrcommflag_s := rc_addrcommflag_s;
		SELF.rc_hrisksic_s := rc_hrisksic_s;
		SELF.addrpop_s := addrpop_s;
		SELF.add1_advo_address_vacancy_s := add1_advo_address_vacancy_s;
		SELF.add1_advo_res_or_business_s := add1_advo_res_or_business_s;
		SELF.add1_applicant_owned_s := add1_applicant_owned_s;
		SELF.add1_family_owned_s := add1_family_owned_s;
		SELF.add1_naprop_s := add1_naprop_s;
		SELF.add1_date_last_seen_s := add1_date_last_seen_s;
		SELF.add1_turnover_1yr_out_s := add1_turnover_1yr_out_s;
		SELF.property_owned_total_s := property_owned_total_s;
		SELF.hist_addr_match_s := hist_addr_match_s;
		SELF.header_first_seen_s := header_first_seen_s;
		SELF.header_last_seen_s := header_last_seen_s;
		SELF.adls_per_addr_c6_s := adls_per_addr_c6_s;
		SELF.inq_collection_count12_s := inq_collection_count12_s;
		SELF.inq_banking_count12_s := inq_banking_count12_s;
		SELF.infutor_nap_s := infutor_nap_s;
		SELF.impulse_count_s := impulse_count_s;
		SELF.email_source_list_s := email_source_list_s;
		SELF.C_BORN_USA := C_BORN_USA;
		SELF.C_INCOLLEGE := C_INCOLLEGE;
		SELF.C_LOW_ED_s := C_LOW_ED_s;
		SELF.C_MANY_CARS := C_MANY_CARS;
		SELF.C_MED_INC := C_MED_INC;
		SELF.C_POP_12_17_P := C_POP_12_17_P;
		SELF.C_POP_18_24_P := C_POP_18_24_P;
		SELF.C_POP_25_34_P := C_POP_25_34_P;
		SELF.C_POP_35_44_P := C_POP_35_44_P;
		SELF.C_POP_45_54_P := C_POP_45_54_P;
		SELF.C_POP_55_64_P := C_POP_55_64_P;
		SELF.C_POP_65_74_P := C_POP_65_74_P;
		SELF.C_POP_6_11_P := C_POP_6_11_P;
		SELF.C_POP_75_84_P := C_POP_75_84_P;
		SELF.C_POP_85P_P := C_POP_85P_P;
		SELF.C_ROBBERY_s := C_ROBBERY_s;
		SELF.C_RURAL_P := C_RURAL_P;
		SELF.C_SPAN_LANG := C_SPAN_LANG;
		SELF.C_SPAN_LANG_s := C_SPAN_LANG_s;
		SELF.C_UNEMP_s := C_UNEMP_s;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.in_population_bad_rate := in_population_bad_rate;
		SELF.in_sample_bad_rate := in_sample_bad_rate;
		SELF.in_model_offset := in_model_offset;
		SELF.bt_population_bad_rate := bt_population_bad_rate;
		SELF.bt_sample_bad_rate := bt_sample_bad_rate;
		SELF.bt_model_offset := bt_model_offset;
		SELF.st_population_bad_rate := st_population_bad_rate;
		SELF.st_sample_bad_rate := st_sample_bad_rate;
		SELF.st_model_offset := st_model_offset;
		SELF.addr_mismatch := addr_mismatch;
		SELF.eg_segment := eg_segment;
		SELF.pf_ship_mode := pf_ship_mode;
		SELF.pf_order_amount := pf_order_amount;
		SELF.pf_num_items := pf_num_items;
		SELF.avg_pmt_amt := avg_pmt_amt;
		SELF.pf_pmt_type := pf_pmt_type;
		SELF.avs_name_ver_1 := avs_name_ver_1;
		SELF.avs_addr_ver_1 := avs_addr_ver_1;
		SELF.avs_zip5_ver_1 := avs_zip5_ver_1;
		SELF.avs_unvail_1 := avs_unvail_1;
		SELF.avs_no_match_1 := avs_no_match_1;
		SELF.avs_name_ver := avs_name_ver;
		SELF.avs_unvail := avs_unvail;
		SELF.avs_addr_ver := avs_addr_ver;
		SELF.avs_no_match := avs_no_match;
		SELF.avs_zip5_ver := avs_zip5_ver;
		SELF.pf_avs_ver_lvl := pf_avs_ver_lvl;
		SELF.pf_cid_match := pf_cid_match;
		SELF.valid_tm_account := valid_tm_account;
		SELF.tm_browser_not_en_f := tm_browser_not_en_f;
		SELF.tm_proxy_geo_not_us_f := tm_proxy_geo_not_us_f;
		SELF.tm_bad_reason_code_f := tm_bad_reason_code_f;
		SELF.tm_not_us_time_zone_f := tm_not_us_time_zone_f;
		SELF.tm_true_geo_not_us_f := tm_true_geo_not_us_f;
		SELF.tm_score_not_zero_f := tm_score_not_zero_f;
		SELF.ip_state := ip_state;
		SELF.tm_problem_lvl := tm_problem_lvl;
		SELF.state_match_lvl := state_match_lvl;
		SELF.add_apt := add_apt;
		SELF._header_first_seen := _header_first_seen;
		SELF._header_last_seen := _header_last_seen;
		SELF.mos_header_first_seen := mos_header_first_seen;
		SELF.mos_header_last_seen := mos_header_last_seen;
		SELF.header_fst_seen_recent := header_fst_seen_recent;
		SELF.header_lst_seen_recent := header_lst_seen_recent;
		SELF.contrary_inf := contrary_inf;
		SELF.verfst_i := verfst_i;
		SELF.verlst_i := verlst_i;
		SELF.veradd_i := veradd_i;
		SELF.verphn_i := verphn_i;
		SELF.contrary_phn := contrary_phn;
		SELF.verfst_p := verfst_p;
		SELF.verlst_p := verlst_p;
		SELF.veradd_p := veradd_p;
		SELF.verphn_p := verphn_p;
		SELF.ver_add := ver_add;
		SELF.ver_phn := ver_phn;
		SELF.ver_fst := ver_fst;
		SELF.ver_lst := ver_lst;
		SELF.vername_p := vername_p;
		SELF.vername_i := vername_i;
		SELF.ver_name := ver_name;
		SELF.no_match := no_match;
		SELF.nap_ver_sum := nap_ver_sum;
		SELF.inf_ver_sum := inf_ver_sum;
		SELF._gong_did_first_seen := _gong_did_first_seen;
		SELF._gong_did_last_seen := _gong_did_last_seen;
		SELF.mos_since_gong_first_seen := mos_since_gong_first_seen;
		SELF.mos_since_gong_last_seen := mos_since_gong_last_seen;
		SELF.phn_last_seen_rec := phn_last_seen_rec;
		SELF.phn_first_seen_rec := phn_first_seen_rec;
		SELF.phn_pots := phn_pots;
		SELF.phn_disconnected := phn_disconnected;
		SELF.phn_inval := phn_inval;
		SELF.phn_nonus := phn_nonus;
		SELF.phn_highrisk := phn_highrisk;
		SELF.phn_notpots := phn_notpots;
		SELF.phn_cellpager := phn_cellpager;
		SELF.phn_business := phn_business;
		SELF.phn_residential := phn_residential;
		SELF.phn_bad_counts := phn_bad_counts;
		SELF.rel_income_100plus := rel_income_100plus;
		SELF.rel_income_75plus := rel_income_75plus;
		SELF.rel_income_50plus := rel_income_50plus;
		SELF.rel_income_25plus := rel_income_25plus;
		SELF.rel_home_500plus := rel_home_500plus;
		SELF.rel_home_300plus := rel_home_300plus;
		SELF.rel_home_200plus := rel_home_200plus;
		SELF.rel_home_150plus := rel_home_150plus;
		SELF.rel_home_100plus := rel_home_100plus;
		SELF.rel_home_50plus := rel_home_50plus;
		SELF.rel_ed_over12 := rel_ed_over12;
		SELF.rel_ed_over8 := rel_ed_over8;
		SELF.rel_age_over70 := rel_age_over70;
		SELF.rel_age_over60 := rel_age_over60;
		SELF.rel_age_over50 := rel_age_over50;
		SELF.rel_age_over40 := rel_age_over40;
		SELF.rel_age_over30 := rel_age_over30;
		SELF.rel_age_over20 := rel_age_over20;
		SELF.no_rel_prop := no_rel_prop;
		SELF.no_rel_inc25 := no_rel_inc25;
		SELF.no_rel_ed8 := no_rel_ed8;
		SELF.no_rel_ed12 := no_rel_ed12;
		SELF.no_rel_vehx := no_rel_vehx;
		SELF.no_rel_age40 := no_rel_age40;
		SELF.no_rel_age30 := no_rel_age30;
		SELF.no_rel_age20 := no_rel_age20;
		SELF.cen_pop_gte_85 := cen_pop_gte_85;
		SELF.cen_pop_gte_75 := cen_pop_gte_75;
		SELF.cen_pop_gte_65 := cen_pop_gte_65;
		SELF.cen_pop_gte_55 := cen_pop_gte_55;
		SELF.cen_pop_gte_45 := cen_pop_gte_45;
		SELF.cen_pop_gte_35 := cen_pop_gte_35;
		SELF.cen_pop_gte_25 := cen_pop_gte_25;
		SELF.cen_pop_gte_18 := cen_pop_gte_18;
		SELF.cen_pop_gte_12 := cen_pop_gte_12;
		SELF.cen_pop_gte_6 := cen_pop_gte_6;
		SELF.eq_date_first_seen := eq_date_first_seen;
		SELF._eq_date_first_seen := _eq_date_first_seen;
		SELF.eq_date_first_seen_mos := eq_date_first_seen_mos;
		SELF.eq_count := eq_count;
		SELF.eq_sourced := eq_sourced;
		SELF.eq_add_not_sourced := eq_add_not_sourced;
		SELF.cc_payment := cc_payment;
		SELF.credit_sourced := credit_sourced;
		SELF.inq_coll := inq_coll;
		SELF.inq_auto := inq_auto;
		SELF.inq_banking := inq_banking;
		SELF.inq_highrisk := inq_highrisk;
		SELF.inq_comm := inq_comm;
		SELF.many_inquiries := many_inquiries;
		SELF.hi_inq_adlsperaddr := hi_inq_adlsperaddr;
		SELF.moved_1mo := moved_1mo;
		SELF.moved_3mo := moved_3mo;
		SELF.moved_1yr := moved_1yr;
		SELF.moved_2yr := moved_2yr;
		SELF.moved_3yr := moved_3yr;
		SELF.moved_5yr := moved_5yr;
		SELF.moved_10yr := moved_10yr;
		SELF.moved_15yr := moved_15yr;
		SELF.add1_lres0 := add1_lres0;
		SELF.avg_lres_low := avg_lres_low;
		SELF.max_lres_low := max_lres_low;
		SELF.avg_mo_per_addr_low := avg_mo_per_addr_low;
		SELF.addr_count_ge3_0 := addr_count_ge3_0;
		SELF.addr_count_ge6_0 := addr_count_ge6_0;
		SELF.addr_count_ge10_0 := addr_count_ge10_0;
		SELF.hist_addr_match_0 := hist_addr_match_0;
		SELF.addr_stability_low := addr_stability_low;
		SELF.ids_per_addr_max := ids_per_addr_max;
		SELF.ids_per_addr_max_c6 := ids_per_addr_max_c6;
		SELF.email_domain := email_domain;
		SELF.email_topleveldomain := email_topleveldomain;
		SELF.email_secondleveldomain := email_secondleveldomain;
		SELF._email_topleveldomain := _email_topleveldomain;
		SELF._email_secondleveldomain := _email_secondleveldomain;
		SELF.in_avg_pmt_amt := in_avg_pmt_amt;
		SELF.in_pmt_type_x_amt_lvl_c16 := in_pmt_type_x_amt_lvl_c16;
		SELF.in_pmt_type_x_amt_lvl_c17 := in_pmt_type_x_amt_lvl_c17;
		SELF.in_pmt_type_x_amt_lvl_c18 := in_pmt_type_x_amt_lvl_c18;
		SELF.in_pmt_type_x_amt_lvl_c19 := in_pmt_type_x_amt_lvl_c19;
		SELF.in_pmt_type_x_amt_lvl_c20 := in_pmt_type_x_amt_lvl_c20;
		SELF.in_pmt_type_x_amt_lvl := in_pmt_type_x_amt_lvl;
		SELF.pf_avs_ver_lvl_num_1 := pf_avs_ver_lvl_num_1;
		SELF.in_pmt_quality_index := in_pmt_quality_index;
		SELF.in_pmt_quality_index_m := in_pmt_quality_index_m;
		SELF.in_bb_entry_type_lvl := in_bb_entry_type_lvl;
		SELF.in_bb_entry_type_lvl_m := in_bb_entry_type_lvl_m;
		SELF.name_match := name_match;
		SELF.pf_friends_and_family_f := pf_friends_and_family_f;
		SELF.in_bb_fandf_lvl_c26 := in_bb_fandf_lvl_c26;
		SELF.in_bb_fandf_lvl := in_bb_fandf_lvl;
		SELF.in_bb_fandf_lvl_m := in_bb_fandf_lvl_m;
		SELF.in_nap_ver_lvl_c29 := in_nap_ver_lvl_c29;
		SELF.in_nap_ver_lvl_c30 := in_nap_ver_lvl_c30;
		SELF.in_nap_ver_lvl := in_nap_ver_lvl;
		SELF.in_nap_ver_lvl_m := in_nap_ver_lvl_m;
		SELF.in_phn_prob_lvl := in_phn_prob_lvl;
		SELF.in_phn_prob_lvl_m := in_phn_prob_lvl_m;
		SELF.in_inq_coll_count12_lvl := in_inq_coll_count12_lvl;
		SELF.in_inq_coll_count12_lvl_m := in_inq_coll_count12_lvl_m;
		SELF.in_inq_bank_count12_lvl := in_inq_bank_count12_lvl;
		SELF.in_inq_bank_count12_lvl_m := in_inq_bank_count12_lvl_m;
		SELF.in_inq_addrsperadl_3 := in_inq_addrsperadl_3;
		SELF.in_inq_addrsperadl_3_m := in_inq_addrsperadl_3_m;
		SELF.in_inq_lnamesperaddr_5 := in_inq_lnamesperaddr_5;
		SELF.in_inq_lnamesperaddr_5_m := in_inq_lnamesperaddr_5_m;
		SELF.in_email_name_lvl := in_email_name_lvl;
		SELF.in_email_name_lvl_m := in_email_name_lvl_m;
		SELF.in_adls_per_phone_2 := in_adls_per_phone_2;
		SELF.in_adls_per_phone_2_m := in_adls_per_phone_2_m;
		SELF.in_ids_per_addr_max_c6_lvl := in_ids_per_addr_max_c6_lvl;
		SELF.in_ids_per_addr_max_c6_lvl_m := in_ids_per_addr_max_c6_lvl_m;
		SELF.in_rel_prob_lvl := in_rel_prob_lvl;
		SELF.in_rel_prob_lvl_m := in_rel_prob_lvl_m;
		SELF.in_ams_lvl := in_ams_lvl;
		SELF.in_ams_lvl_m := in_ams_lvl_m;
		SELF.in_tm_ip_problem_lvl := in_tm_ip_problem_lvl;
		SELF.in_tm_ip_problem_lvl_m := in_tm_ip_problem_lvl_m;
		SELF.in_c_span_lang_lvl := in_c_span_lang_lvl;
		SELF.in_c_span_lang_lvl_m := in_c_span_lang_lvl_m;
		SELF.in_bb_cc_pmt_not_credit_srcd_f := in_bb_cc_pmt_not_credit_srcd_f;
		SELF.in_eq_first_seen_lvl := in_eq_first_seen_lvl;
		SELF.in_eq_first_seen_lvl_m := in_eq_first_seen_lvl_m;
		SELF.in_dist_a1toa2_lvl := in_dist_a1toa2_lvl;
		SELF.in_dist_a1toa2_lvl_m := in_dist_a1toa2_lvl_m;
		SELF.in_dist_a1toa3_lvl := in_dist_a1toa3_lvl;
		SELF.in_dist_a1toa3_lvl_m := in_dist_a1toa3_lvl_m;
		SELF.in_criminal_f := in_criminal_f;
		SELF.in_bb_cid_not_match_f := in_bb_cid_not_match_f;
		SELF.in_inq_retail_count12_c := in_inq_retail_count12_c;
		SELF.in_inq_retail_count12_rt := in_inq_retail_count12_rt;
		SELF.in_inq_ssnsperadl_f := in_inq_ssnsperadl_f;
		SELF.in_cen_pop_gte_18_hi_f := in_cen_pop_gte_18_hi_f;
		SELF.in_c_med_inc_low_f := in_c_med_inc_low_f;
		SELF.in_log := in_log;
		SELF.bt_bb_entry_type_lvl := bt_bb_entry_type_lvl;
		SELF.bt_bb_entry_type_lvl_m := bt_bb_entry_type_lvl_m;
		SELF.bt_bb_pmt_x_avs_lvl := bt_bb_pmt_x_avs_lvl;
		SELF.bt_bb_pmt_x_avs_lvl_m := bt_bb_pmt_x_avs_lvl_m;
		SELF.bt_bb_cc_pmt_not_credit_srcd_f := bt_bb_cc_pmt_not_credit_srcd_f;
		SELF.bt_eq_first_seen_lvl := bt_eq_first_seen_lvl;
		SELF.bt_eq_first_seen_lvl_m := bt_eq_first_seen_lvl_m;
		SELF.bt_verphn_lvl_c67 := bt_verphn_lvl_c67;
		SELF.bt_verphn_lvl_c68 := bt_verphn_lvl_c68;
		SELF.bt_verphn_lvl := bt_verphn_lvl;
		SELF.bt_verphn_lvl_m := bt_verphn_lvl_m;
		SELF.bt_inq_type_lvl := bt_inq_type_lvl;
		SELF.bt_inq_type_lvl_m := bt_inq_type_lvl_m;
		SELF.bt_email_name_lvl := bt_email_name_lvl;
		SELF.bt_email_name_lvl_m := bt_email_name_lvl_m;
		SELF.bt_college_lvl := bt_college_lvl;
		SELF.bt_college_lvl_m := bt_college_lvl_m;
		SELF.bt_tm_ip_problem_lvl := bt_tm_ip_problem_lvl;
		SELF.bt_tm_ip_problem_lvl_m := bt_tm_ip_problem_lvl_m;
		SELF.bt_addr_hist_lvl := bt_addr_hist_lvl;
		SELF.bt_addr_hist_lvl_m := bt_addr_hist_lvl_m;
		SELF.bt_ids_per_addr_max_lvl_c81 := bt_ids_per_addr_max_lvl_c81;
		SELF.bt_ids_per_addr_max_lvl_c82 := bt_ids_per_addr_max_lvl_c82;
		SELF.bt_ids_per_addr_max_lvl := bt_ids_per_addr_max_lvl;
		SELF.bt_ids_per_addr_max_lvl_m := bt_ids_per_addr_max_lvl_m;
		SELF.bt_c_incollege := bt_c_incollege;
		SELF.bt_c_incollege_m := bt_c_incollege_m;
		SELF.bt_c_born_usa := bt_c_born_usa;
		SELF.bt_c_born_usa_m := bt_c_born_usa_m;
		SELF.bt_c_many_cars := bt_c_many_cars;
		SELF.bt_c_many_cars_m := bt_c_many_cars_m;
		SELF.bt_c_span_lang := bt_c_span_lang;
		SELF.bt_c_span_lang_m := bt_c_span_lang_m;
		SELF.bt_bb_cid_not_match_f := bt_bb_cid_not_match_f;
		SELF.bt_bb_avg_pmt_amt_c := bt_bb_avg_pmt_amt_c;
		SELF.bt_bb_avg_pmt_amt_rt := bt_bb_avg_pmt_amt_rt;
		SELF.bt_bb_next_day_ship_f := bt_bb_next_day_ship_f;
		SELF.bt_adls_per_phone_f := bt_adls_per_phone_f;
		SELF.bt_log := bt_log;
		SELF.st_avg_pmt_amt := st_avg_pmt_amt;
		SELF.st_pmt_type_x_amt_lvl_c94 := st_pmt_type_x_amt_lvl_c94;
		SELF.st_pmt_type_x_amt_lvl_1 := st_pmt_type_x_amt_lvl_1;
		SELF.st_pmt_type_x_amt_lvl_c96 := st_pmt_type_x_amt_lvl_c96;
		SELF.st_pmt_type_x_amt_lvl_c97 := st_pmt_type_x_amt_lvl_c97;
		SELF.st_pmt_type_x_amt_lvl_c98 := st_pmt_type_x_amt_lvl_c98;
		SELF.st_pmt_type_x_amt_lvl_c99 := st_pmt_type_x_amt_lvl_c99;
		SELF.st_pmt_type_x_amt_lvl := st_pmt_type_x_amt_lvl;
		SELF.pf_avs_ver_lvl_num := pf_avs_ver_lvl_num;
		SELF.st_pmt_quality_index := st_pmt_quality_index;
		SELF.st_pmt_quality_index_m := st_pmt_quality_index_m;
		SELF.st_are_relatives_lvl := st_are_relatives_lvl;
		SELF.st_are_relatives_lvl_m := st_are_relatives_lvl_m;
		SELF.st_shipping_lvl := st_shipping_lvl;
		SELF.st_shipping_lvl_m := st_shipping_lvl_m;
		SELF.contrary_inf_s := contrary_inf_s;
		SELF.verfst_i_s := verfst_i_s;
		SELF.verlst_i_s := verlst_i_s;
		SELF.veradd_i_s := veradd_i_s;
		SELF.verphn_i_s := verphn_i_s;
		SELF.contrary_phn_s := contrary_phn_s;
		SELF.verfst_p_s := verfst_p_s;
		SELF.verlst_p_s := verlst_p_s;
		SELF.veradd_p_s := veradd_p_s;
		SELF.verphn_p_s := verphn_p_s;
		SELF.contrary_ssn_s := contrary_ssn_s;
		SELF.verfst_s_s := verfst_s_s;
		SELF.verlst_s_s := verlst_s_s;
		SELF.veradd_s_s := veradd_s_s;
		SELF.verssn_s_s := verssn_s_s;
		SELF.nas_479_s_1 := nas_479_s_1;
		SELF.nas_479_s := nas_479_s;
		SELF._header_first_seen_s := _header_first_seen_s;
		SELF._header_last_seen_s := _header_last_seen_s;
		SELF.mos_header_first_seen_s := mos_header_first_seen_s;
		SELF.mos_header_last_seen_s := mos_header_last_seen_s;
		SELF.header_fst_seen_recent_s := header_fst_seen_recent_s;
		SELF.header_lst_seen_recent_s := header_lst_seen_recent_s;
		SELF.ver_add_s := ver_add_s;
		SELF.ver_phn_s := ver_phn_s;
		SELF.ver_fst_s := ver_fst_s;
		SELF.ver_lst_s := ver_lst_s;
		SELF.con_phn_s := con_phn_s;
		SELF.st_verphn_lvl := st_verphn_lvl;
		SELF.st_verphn_lvl_m := st_verphn_lvl_m;
		SELF.st_phn_prob_lvl := st_phn_prob_lvl;
		SELF.st_phn_prob_lvl_m := st_phn_prob_lvl_m;
		SELF.vacant_addr_s := vacant_addr_s;
		SELF.add_correction_s := add_correction_s;
		SELF.add_apt_s := add_apt_s;
		SELF.add_highrisk_s := add_highrisk_s;
		SELF.business_s := business_s;
		SELF.st_addr_prob_lvl_s := st_addr_prob_lvl_s;
		SELF.st_addr_prob_lvl_s_m := st_addr_prob_lvl_s_m;
		SELF.st_inq_coll_combo_lvl := st_inq_coll_combo_lvl;
		SELF.st_inq_coll_combo_lvl_m := st_inq_coll_combo_lvl_m;
		SELF.st_inq_bank_combo_lvl := st_inq_bank_combo_lvl;
		SELF.st_inq_bank_combo_lvl_m := st_inq_bank_combo_lvl_m;
		SELF.st_adls_per_addr_c6_combo_lvl := st_adls_per_addr_c6_combo_lvl;
		SELF.st_adls_per_addr_c6_combo_lvl_m := st_adls_per_addr_c6_combo_lvl_m;
		SELF.st_email_domain_lvl := st_email_domain_lvl;
		SELF.st_email_domain_lvl_m := st_email_domain_lvl_m;
		SELF.st_efirstscore_lvl := st_efirstscore_lvl;
		SELF.st_efirstscore_lvl_m := st_efirstscore_lvl_m;
		SELF._add1_date_last_seen_s := _add1_date_last_seen_s;
		SELF.mos_add1_date_last_seen_s := mos_add1_date_last_seen_s;
		SELF.seen_recently_s := seen_recently_s;
		SELF.family_owned_s := family_owned_s;
		SELF.app_owned_s := app_owned_s;
		SELF.stolen_addr_s := stolen_addr_s;
		SELF.nothing_found_s := nothing_found_s;
		SELF.property_owner_s := property_owner_s;
		SELF.st_naprop_lvl_s := st_naprop_lvl_s;
		SELF.st_naprop_lvl_s_m := st_naprop_lvl_s_m;
		SELF.st_c_low_ed_s := st_c_low_ed_s;
		SELF.st_c_low_ed_s_m := st_c_low_ed_s_m;
		SELF.st_c_unemp_s := st_c_unemp_s;
		SELF.st_c_unemp_s_m := st_c_unemp_s_m;
		SELF.st_c_robbery_s := st_c_robbery_s;
		SELF.st_c_robbery_s_m := st_c_robbery_s_m;
		SELF.st_c_span_lang_s := st_c_span_lang_s;
		SELF.st_c_span_lang_s_m := st_c_span_lang_s_m;
		SELF.st_c_rural_p := st_c_rural_p;
		SELF.st_c_rural_p_m := st_c_rural_p_m;
		SELF.st_tm_ip_problem_lvl := st_tm_ip_problem_lvl;
		SELF.st_tm_ip_problem_lvl_m := st_tm_ip_problem_lvl_m;
		SELF.st_hist_addr_match_lvl := st_hist_addr_match_lvl;
		SELF.st_hist_addr_match_lvl_m := st_hist_addr_match_lvl_m;
		SELF.st_distaddraddr2_lvl := st_distaddraddr2_lvl;
		SELF.st_distaddraddr2_lvl_m := st_distaddraddr2_lvl_m;
		SELF.st_add1_turnover_1yr_out_s_lvl := st_add1_turnover_1yr_out_s_lvl;
		SELF.st_add1_turnover_1yr_out_s_lvl_m := st_add1_turnover_1yr_out_s_lvl_m;
		SELF.impulse_email_s := impulse_email_s;
		SELF.st_impulse_flag_s := st_impulse_flag_s;
		SELF.st_log := st_log;
		SELF.d0_infutor_nap := d0_infutor_nap;
		SELF.d0_veradd_p := d0_veradd_p;
		SELF.d0_c_span_lang := d0_c_span_lang;
		SELF.d0_efirstscore := d0_efirstscore;
		SELF.d0_elastscore := d0_elastscore;
		SELF.d0_pf_pmt_type := d0_pf_pmt_type;
		SELF.d0_pf_ship_mode := d0_pf_ship_mode;
		SELF.d0_avs_addr_ver := d0_avs_addr_ver;
		SELF.d0_avs_zip5_ver := d0_avs_zip5_ver;
		SELF.d0_pf_cid_match := d0_pf_cid_match;
		SELF.d0_tm_problem_lvl := d0_tm_problem_lvl;
		SELF.d0_state_match_lvl := d0_state_match_lvl;
		SELF.d0_avg_pmt_amt := d0_avg_pmt_amt;
		SELF.d0_rawscore := d0_rawscore;
		SELF.d0_log := d0_log;
		SELF.base := base;
		SELF.point := point;
		SELF.odds := odds;
		SELF.in_phat := in_phat;
		SELF.in_score := in_score;
		SELF.st_phat := st_phat;
		SELF.st_score := st_score;
		SELF.bt_phat := bt_phat;
		SELF.bt_score := bt_score;
		SELF.d0_phat := d0_phat;
		SELF.d0_score := d0_score;
		SELF.best_buy_refresh := best_buy_refresh;
		SELF.cdn1109_1_0 := cdn1109_1_0;

		SELF.clam := le;
	#else
		SELF.ri := [];
		
		SELF.score := (STRING3)cdn1109_1_0;
		SELF.seq := le.bs.Bill_To_Out.seq;
	#end
	END;
	
	model := JOIN(clam_with_easi, customInputs, LEFT.bs.bill_to_out.seq = (RIGHT.seq * 2), doModel(LEFT, RIGHT), LEFT OUTER);

	// need to project billto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output(clam_with_easi le) := TRANSFORM
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.socllowissue := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
		SELF.soclhighissue := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
		SELF.socsverlevel := le.bs.Bill_To_Out.iid.NAS_summary;
		SELF.nxx_type := le.bs.Bill_To_Out.phone_verification.telcordia_type;
		SELF := le.bs.Bill_To_Out.iid;
		SELF := le.bs.Bill_To_Out.shell_input;
		SELF := le.bs.bill_to_out;
	END;
	iidBT := PROJECT(clam_with_easi, into_layout_output(LEFT));

	RiskWise.Layout_IP2O fill_ip(clam_with_easi le) := TRANSFORM
		SELF.countrycode := le.bs.ip2o.countrycode[1..2];
		SELF := le.bs.ip2o;
	END;
	ipInfo := PROJECT(clam_with_easi, fill_ip(LEFT));


	Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
		SELF.seq := le.seq;
		SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, TRUE, IBICID, WantstoSeeBillToShipToDifferenceFlag);
		SELF := [];
	END;
	BTReasons := JOIN(iidBT, ipInfo, LEFT.seq = RIGHT.seq, addBTReasons(LEFT, RIGHT), LEFT OUTER);


	#if(MODEL_DEBUG)
	Layout_debug fillReasons(layout_debug le, BTreasons rt) := TRANSFORM
	#else
	Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
	SELF.ri := rt.ri;
	#end
		SELF := le;
	END;
	
	#if(MODEL_DEBUG)
	BTrecord := JOIN(model, BTReasons, LEFT.clam.bs.Bill_To_out.seq = RIGHT.seq, fillReasons(LEFT, RIGHT), LEFT OUTER);
	#else
	BTrecord := JOIN(model, BTReasons, LEFT.seq = RIGHT.seq, fillReasons(LEFT, RIGHT), LEFT OUTER);
	#end


	// need to project the shipto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output2(clam_with_easi le) := TRANSFORM
		SELF.seq := le.bs.Ship_To_Out.seq;
		SELF.socllowissue := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
		SELF.soclhighissue := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
		SELF.socsverlevel := le.bs.Ship_To_Out.iid.NAS_summary;
		SELF := le.bs.Ship_To_Out.iid;
		SELF := le.bs.Ship_To_Out.shell_input;
		SELF := le.bs.ship_to_out;
	END;
	iidST := PROJECT(clam_with_easi, into_layout_output2(LEFT));


	Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := TRANSFORM
		SELF.seq := le.seq;
		SELF.ri := RiskWise.cdReasonCodes(le, 6, rt, FALSE, IBICID, false);
		SELF := [];
	END;
	STReasons := JOIN(iidST, ipInfo, LEFT.seq=((RIGHT.seq*2)-1), addSTReasons(LEFT, RIGHT), LEFT OUTER);

	#if(MODEL_DEBUG)
		layout_debug fillReasons2(layout_debug le, STreasons rt) := TRANSFORM
	#else
		Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
		SELF.ri := le.ri + rt.ri;
	#end
		SELF := le;
	END;
	
	#if(MODEL_DEBUG)
	STRecord := JOIN(BTRecord, STReasons, ((LEFT.clam.bs.Bill_To_Out.seq*2)-1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);
	#else
	STRecord := JOIN(BTRecord, STReasons, ((LEFT.seq*2)-1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);
	#end

	RETURN(STRecord);
END;
