IMPORT Risk_Indicators, RiskWise, RiskWiseFCRA, ut, std, riskview;
	
EXPORT RVA1007_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	Layout_ModelOut_ivars := record
		Layout_ModelOut;
		dataset(Models.Layout_Score) ivars;
	END;
	
RVA_DEBUG := FALSE;

#if(RVA_DEBUG)
layout_debug := RECORD
	UNSIGNED seq;
	STRING adl_category;
	STRING out_addr_type;
	STRING in_dob;
	INTEGER nas_summary;
	INTEGER nap_summary;
	UNSIGNED did_count;
	STRING rc_hriskphoneflag;
	STRING rc_hphonetypeflag;
	STRING rc_phonevalflag;
	STRING rc_hphonevalflag;
	STRING rc_decsflag;
	STRING rc_ssnvalflag;
	STRING rc_pwssnvalflag;
	STRING rc_ssnlowissue;
	STRING rc_addrvalflag;
	STRING rc_dwelltype;
	STRING rc_bansflag;
	STRING rc_sources;
	STRING rc_addrcommflag;
	STRING rc_phonetype;
	STRING rc_ziptypeflag;
	STRING rc_cityzipflag;
	UNSIGNED combo_ssnscore;
	BOOLEAN dobpop;
	BOOLEAN add1_isbestmatch;
	UNSIGNED add1_unit_count;
	INTEGER add1_avm_automated_valuation;
	INTEGER add1_avm_med_fips;
	BOOLEAN add1_applicant_owned;
	BOOLEAN add1_occupant_owned;
	BOOLEAN add1_family_owned;
	UNSIGNED add1_naprop;
	STRING add1_financing_type;
	UNSIGNED add1_date_first_seen;
	UNSIGNED property_owned_total;
	UNSIGNED property_owned_assessed_total;
	UNSIGNED property_owned_assessed_count;
	UNSIGNED property_sold_purchase_total;
	UNSIGNED property_sold_purchase_count;
	UNSIGNED prop1_sale_price;
	UNSIGNED prop1_prev_purchase_price;
	UNSIGNED prop2_sale_price;
	UNSIGNED prop2_prev_purchase_price;
	INTEGER dist_a1toa2;
	BOOLEAN add2_isbestmatch;
	BOOLEAN add2_applicant_owned;
	BOOLEAN add2_occupant_owned;
	BOOLEAN add2_family_owned;
	BOOLEAN add3_isbestmatch;
	UNSIGNED addrs_5yr;
	BOOLEAN addrs_prison_history;
	STRING telcordia_type;
	STRING gong_did_first_seen;
	STRING gong_did_last_seen;
	UNSIGNED gong_did_first_ct;
	UNSIGNED gong_did_last_ct;
	UNSIGNED ssns_per_adl;
	UNSIGNED adls_per_addr;
	UNSIGNED ssns_per_adl_c6;
	UNSIGNED adls_per_addr_c6;
	UNSIGNED ssns_per_addr_c6;
	UNSIGNED vo_addrs_per_adl;
	UNSIGNED infutor_nap;
	UNSIGNED impulse_count;
	UNSIGNED impulse_last_seen;
	UNSIGNED attr_addrs_last12;
	UNSIGNED attr_addrs_last36;
	UNSIGNED attr_num_purchase60;
	UNSIGNED attr_num_sold60;
	UNSIGNED attr_num_watercraft60;
	UNSIGNED attr_num_aircraft;
	UNSIGNED attr_total_number_derogs;
	UNSIGNED attr_eviction_count;
	UNSIGNED attr_date_last_eviction;
	UNSIGNED attr_eviction_count12;
	UNSIGNED attr_num_nonderogs;
	UNSIGNED attr_num_nonderogs90;
	UNSIGNED attr_num_nonderogs12;
	UNSIGNED attr_num_nonderogs36;
	BOOLEAN bankrupt;
	STRING filing_type;
	STRING disposition;
	UNSIGNED filing_count;
	UNSIGNED bk_recent_count;
	UNSIGNED liens_recent_released_count;
	UNSIGNED liens_historical_released_count;
	UNSIGNED liens_recent_unreleased_count;
	UNSIGNED liens_historical_unreleased_count;
	UNSIGNED liens_unrel_cj_ct;
	UNSIGNED liens_unrel_cj_last_seen;
	UNSIGNED liens_rel_cj_ct;
	UNSIGNED liens_unrel_lt_ct;
	UNSIGNED liens_unrel_lt_last_seen;
	UNSIGNED liens_unrel_o_ct;
	UNSIGNED liens_rel_o_ct;
	UNSIGNED liens_unrel_ot_ct;
	UNSIGNED liens_unrel_ot_last_seen;
	UNSIGNED liens_rel_ot_ct;
	UNSIGNED liens_unrel_sc_ct;
	UNSIGNED liens_unrel_sc_last_seen;
	UNSIGNED liens_unrel_sc_total_amount;
	UNSIGNED criminal_count;
	UNSIGNED criminal_last_date;
	UNSIGNED felony_count;
	UNSIGNED watercraft_count;
	STRING ams_college_code;
	STRING ams_college_tier;
	BOOLEAN prof_license_flag;
	STRING prof_license_category;
	STRING input_dob_age;
	STRING input_dob_match_level;
	STRING addr_stability;
	INTEGER sysdate;
	BOOLEAN source_tot_L2;
	BOOLEAN source_tot_LI;
	BOOLEAN lien_rec_unrel_flag;
	BOOLEAN lien_hist_unrel_flag;
	BOOLEAN lien_flag;
	INTEGER pk_impulse_count;
	INTEGER pk_impulse_count_2;
	BOOLEAN source_tot_BA;
	BOOLEAN bk_flag;
	INTEGER pk_adl_cat_deceased;
	BOOLEAN source_tot_DS;
	BOOLEAN ssn_deceased;
	STRING bs_own_rent;
	INTEGER bs_attr_derog_flag;
	INTEGER bs_attr_eviction_flag;
	INTEGER bs_attr_derog_flag2;
	STRING pk_Segment;
	STRING pk_segment_2;
	INTEGER pk_impulse_count_3;
	INTEGER pk_impulse_count_4;
	INTEGER pk_attr_total_number_derogs;
	INTEGER pk_attr_total_number_derogs_2;
	INTEGER pk_attr_num_nonderogs90;
	INTEGER pk_attr_num_nonderogs90_2;
	INTEGER pk_attr_num_nonderogs90_b;
	INTEGER pk_adl_cat_deceased_2;
	INTEGER bs_attr_derog_flag_2;
	INTEGER bs_attr_eviction_flag_2;
	INTEGER bs_attr_derog_flag2_2;
	INTEGER pk_own_flag;
	STRING pk_segment3;
	INTEGER _gong_did_first_seen;
	INTEGER _gong_did_last_seen;
	INTEGER _criminal_last_date;
	INTEGER _attr_date_last_eviction;
	INTEGER _liens_unrel_cj_last_seen;
	INTEGER _liens_unrel_sc_last_seen;
	INTEGER _in_dob;
	INTEGER _rc_ssnlowissue;
	INTEGER _impulse_last_seen;
	INTEGER _liens_unrel_sc_last_seen_2;
	INTEGER _liens_unrel_ot_last_seen;
	INTEGER _liens_unrel_lt_last_seen;
	INTEGER _liens_unrel_cj_last_seen_2;
	INTEGER add1_first_seen;
	INTEGER yrs_since_gong_first_seen;
	INTEGER mos_since_gong_first_seen;
	INTEGER mos_since_gong_last_seen;
	INTEGER mos_since_crim_last_seen;
	INTEGER mos_attr_date_last_eviction;
	INTEGER mos_unrel_sc_last_seen;
	INTEGER mos_unrel_ot_last_seen;
	INTEGER mos_unrel_lt_last_seen;
	INTEGER mos_unrel_cj_last_seen;
	INTEGER mos_since_imp_last_seen;
	INTEGER mos_since_add1_first_seen;
	INTEGER mod1_property_lvl;
	BOOLEAN mod1_prof_license;
	INTEGER mod1_dist_a1toa2;
	REAL mod1_dist_a1toa2_rt;
	INTEGER mod1_gong_first_seen_lvl;
	INTEGER mod1_addrs_5yr;
	INTEGER mod1_best_match_lvl;
	BOOLEAN add_apt;
	INTEGER mod1_ssns_per_addr_lvl;
	INTEGER mod1_attr_num_nonderogs_6;
	BOOLEAN mod1_ADJ_loan;
	BOOLEAN phn_last_seen_rec;
	BOOLEAN phn_first_seen_rec;
	BOOLEAN phn_pots;
	BOOLEAN phn_disconnected;
	BOOLEAN phn_inval;
	BOOLEAN phn_nonUs;
	BOOLEAN phn_highrisk;
	BOOLEAN phn_notpots;
	BOOLEAN phn_cellpager;
	BOOLEAN phn_business;
	BOOLEAN phn_residential;
	BOOLEAN infutor_0;
	BOOLEAN infutor_1;
	BOOLEAN contrary_phn;
	BOOLEAN verfst_p;
	BOOLEAN verlst_p;
	BOOLEAN veradd_p;
	BOOLEAN verphn_p;
	BOOLEAN ver_nap6;
	INTEGER ver_phncount;
	INTEGER infutor_lvl;
	INTEGER nap_lvl;
	BOOLEAN core_adl;
	BOOLEAN single_did;
	INTEGER low_issue_dob_diff;
	BOOLEAN mod1_gong_name_hi_counts;
	INTEGER mod1_derog_ratio;
	INTEGER mod1_derog_ratio2;
	INTEGER fips_diff;
	BOOLEAN invalid_addr;
	BOOLEAN not_reg_zip;
	BOOLEAN _reg_zip;
	BOOLEAN zip_city_mismatch;
	INTEGER mod1_addr_prob_lvl;
	INTEGER liens_released_ct_10;
	INTEGER mod1_lien_rel_lvl;
	INTEGER seg0_addr_stability_combo;
	REAL seg0_addr_stability_combo_m0;
	INTEGER seg0_phn_prob_combo;
	REAL seg0_phn_prob_combo_m0;
	INTEGER seg0_nap_lvl_combo;
	REAL seg0_nap_lvl_combo_m0;
	INTEGER seg0_adls_per_addr_combo;
	REAL seg0_adls_per_addr_combo_m0;
	INTEGER seg0_gong_first_seen_combo;
	REAL seg0_gong_first_seen_combo_rt;
	INTEGER seg0_criminal_lvl;
	REAL seg0_criminal_lvl_m0;
	INTEGER seg0_bk_lvl;
	REAL seg0_bk_lvl_m0;
	INTEGER seg0_eviction_lvl;
	REAL seg0_eviction_lvl_m0;
	INTEGER seg0_ams_college_code;
	REAL seg0_ams_college_code_m0;
	INTEGER seg0_vo_addrs_per_adl_lvl;
	REAL seg0_vo_addrs_per_adl_lvl_m0;
	INTEGER seg0_age_lvl_b1;
	INTEGER seg0_age_lvl;
	REAL seg0_age_lvl_m0;
	INTEGER seg0_age_lvl_2;
	INTEGER liens_unrel_cj_lvl;
	INTEGER seg0_liens_cj_lvl;
	REAL seg0_liens_cj_lvl_m0;
	INTEGER seg0_liens_sc_lvl;
	REAL seg0_liens_sc_lvl_m0;
	INTEGER seg0_adl_lvl;
	REAL seg0_adl_lvl_m0;
	INTEGER seg0_fips_diff;
	REAL seg0_fips_diff_m0;
	INTEGER seg0_attr_prop_turnover;
	REAL seg0_attr_prop_turnover_m0;
	REAL mod1_property_lvl_m0;
	BOOLEAN seg0_rec_vehx_flag;
	INTEGER seg0_low_issue_dob_diff;
	REAL seg0_low_issue_dob_diff_lg;
	REAL SANT_LOG_SEG0;
	INTEGER seg1_addrs_last_combo;
	INTEGER seg1_addr_stability_combo;
	REAL seg1_addr_stability_combo_m1;
	INTEGER seg1_attr_eviction_combo;
	REAL seg1_attr_eviction_combo_m1;
	INTEGER seg1_phn_prob_combo;
	REAL seg1_phn_prob_combo_m1;
	INTEGER seg1_ssns_per_adl_combo;
	REAL seg1_ssns_per_adl_combo_m1;
	INTEGER seg1_nap_lvl_combo;
	REAL seg1_nap_lvl_combo_m1;
	INTEGER criminal_lvl;
	INTEGER seg1_criminal_combo;
	INTEGER seg1_criminal_combo_2;
	REAL seg1_criminal_combo_m1;
	INTEGER seg1_unrel_sc_combo;
	REAL seg1_unrel_sc_combo_m1;
	INTEGER seg1_unrel_ot_combo;
	REAL seg1_unrel_ot_combo_m1;
	INTEGER seg1_unrel_lt_combo;
	REAL seg1_unrel_lt_combo_m1;
	INTEGER seg1_unrel_cj_combo;
	REAL seg1_unrel_cj_combo_m1;
	INTEGER seg1_bk_lvl;
	REAL seg1_bk_lvl_m1;
	REAL prop1_sale_price_a;
	REAL prop2_sale_price_a;
	STRING prop1_sale_profit;
	STRING prop2_sale_profit;
	INTEGER seg1_prop_sale_history;
	REAL seg1_prop_sale_history_m1;
	INTEGER seg1_ams_college_code;
	REAL seg1_ams_college_code_m1;
	INTEGER seg1_vo_addrs_per_adl_lvl;
	REAL seg1_vo_addrs_per_adl_lvl_m1;
	INTEGER seg1_age_lvl_b1;
	INTEGER seg1_age_lvl;
	REAL seg1_age_lvl_m1;
	INTEGER seg1_adl_lvl;
	REAL seg1_adl_lvl_m1;
	INTEGER seg1_fips_diff;
	REAL seg1_fips_diff_m1;
	REAL mod1_gong_first_seen_lvl_m1;
	REAL mod1_addrs_5yr_m1;
	REAL mod1_best_match_lvl_m1;
	REAL mod1_ssns_per_addr_lvl_m1;
	REAL mod1_attr_num_nonderogs_6_m1;
	INTEGER seg1_add1_first_seen_mos;
	REAL seg1_add1_first_seen_mos_lg;
	REAL SANT_LOG_SEG1;
	INTEGER seg2_phn_prob_combox;
	REAL seg2_phn_prob_combox_m2;
	INTEGER seg2_nap_level_combox;
	REAL seg2_nap_level_combox_m2;
	INTEGER seg2_attr_addrs_combox;
	INTEGER seg2_addr_stability_combox;
	REAL seg2_addr_stability_combox_m2;
	INTEGER adls_per_addr_c6_5;
	INTEGER seg2_adls_per_addr_combo;
	REAL seg2_adls_per_addr_combo_m2;
	INTEGER seg2_prof_license_combo;
	REAL seg2_prof_license_combo_m2;
	INTEGER seg2_ams_college_combo;
	REAL seg2_ams_college_combo_m2;
	STRING curr_owner_lvl;
	STRING prev_owner_lvl;
	INTEGER seg2_curr_prev_owner_combo;
	REAL seg2_curr_prev_owner_combo_m2;
	INTEGER seg2_vo_addrs_per_adl_lvl;
	REAL seg2_vo_addrs_per_adl_lvl_m2;
	INTEGER seg2_age_lvl_b1;
	INTEGER seg2_age_lvl;
	REAL seg2_age_lvl_m2;
	INTEGER seg2_ssn_prob;
	REAL seg2_ssn_prob_m2;
	INTEGER seg2_fips_diff;
	REAL seg2_fips_diff_m2;
	INTEGER seg2_attr_prop_turnover;
	REAL seg2_attr_prop_turnover_m2;
	INTEGER mod1_phn_prob;
	REAL mod1_phn_prob_m2;
	BOOLEAN seg2_veradd_s_flag;
	REAL seg2_avg_prop_assessed_val;
	REAL seg2_avg_prop_assessed_val_rt;
	INTEGER seg2_low_issue_dob_diff;
	REAL mod1_derog_ratio2_m2;
	REAL SANT_LOG_SEG2;
	INTEGER seg3_nap_combox;
	REAL seg3_nap_combox_m3;
	INTEGER seg3_attr_addrs_combox;
	INTEGER seg3_addr_stability_combox;
	REAL seg3_addr_stability_combox_m3;
	INTEGER seg3_ams_college_combox;
	REAL seg3_ams_college_combox_m3;
	INTEGER seg3_adls_per_addr_combox;
	REAL seg3_adls_per_addr_combox_m3;
	INTEGER seg3_curr_prev_owner_combox;
	REAL seg3_curr_prev_owner_combox_m3;
	INTEGER seg3_ssns_per_addr_c6X;
	REAL seg3_ssns_per_addr_c6x_m3;
	INTEGER seg3_nonderog_combox;
	INTEGER seg3_nonderog_combox2;
	REAL seg3_nonderog_combox2_m3;
	REAL seg3_low_issue_dob_diffX;
	INTEGER seg3_prof_license_combo;
	REAL seg3_prof_license_combo_m3;
	INTEGER seg3_gong_first_seen_combo;
	REAL seg3_gong_first_seen_combo_lg;
	INTEGER seg3_age_lvl_b1;
	INTEGER seg3_age_lvl;
	REAL seg3_age_lvl_m3;
	INTEGER seg3_fips_diff;
	REAL seg3_fips_diff_m3;
	REAL mod1_phn_prob_m3;
	REAL mod1_addr_prob_lvl_m3;
	REAL mod1_best_match_lvl_m3;
	REAL mod1_lien_rel_lvl_m3;
	REAL seg3_avg_prop_assessed_val;
	REAL seg3_avg_prop_assessed_val_lg;
	REAL seg3_avg_prop_assessed_val_rt;
	REAL seg3_avg_prop_sold_val;
	BOOLEAN seg3_rec_vehx_flag;
	BOOLEAN seg3_liens_o_flag;
	REAL SANT_LOG_SEG3;
	INTEGER base;
	INTEGER point;
	REAL odds;
	REAL phat;
	INTEGER SANT_SEG;
	INTEGER SANT_SEGMENT_MODEL;
	INTEGER RVA1007_2_0;
	INTEGER var01;
	STRING var02;
	INTEGER var03;
	BOOLEAN var04;
	BOOLEAN var05;
	INTEGER var06;
	INTEGER var07;
	BOOLEAN var08;
	INTEGER var09;
	INTEGER var10;
	BOOLEAN var11;
	INTEGER var12;
	INTEGER var13;
	INTEGER var14;
	INTEGER var15;
	INTEGER var16;
	INTEGER var17;
	INTEGER var18;
	INTEGER var19;
	INTEGER var20;
	INTEGER var21;
	INTEGER var22;
	INTEGER var23;
	BOOLEAN var24;
	INTEGER var25;
	INTEGER var26;
	INTEGER var27;
	INTEGER var28;
	INTEGER var29;
	INTEGER var30;
	INTEGER var31;
	INTEGER var32;
	BOOLEAN var33;
	INTEGER var34;
	BOOLEAN var35;
	INTEGER var36;
	INTEGER var37;
	INTEGER var38;
	INTEGER var39;
	INTEGER var40;
	INTEGER var41;
	INTEGER var42;
	INTEGER var43;
	STRING Score;
END;

	layout_debug doModel( clam le ) := TRANSFORM
#else
	Layout_ModelOut_ivars doModel( clam le ) := TRANSFORM 
#end
	
/* ***********************************************************
	*                  Input Variables                         *
	************************************************************ */
	adl_category                     				:= le.adlcategory;
	out_addr_type                    				:= le.shell_input.addr_type;
	in_dob                           				:= le.shell_input.dob;
	nas_summary                      				:= le.iid.nas_summary;
	nap_summary                      				:= le.iid.nap_summary;
	did_count                        				:= le.iid.didcount;
	rc_hriskphoneflag                				:= le.iid.hriskphoneflag;
	rc_hphonetypeflag                				:= le.iid.hphonetypeflag;
	rc_phonevalflag                  				:= le.iid.phonevalflag;
	rc_hphonevalflag                 				:= le.iid.hphonevalflag;
	rc_decsflag                      				:= le.iid.decsflag;
	rc_ssnvalflag                    				:= le.iid.socsvalflag;
	rc_pwssnvalflag                  				:= le.iid.pwsocsvalflag;
	rc_ssnlowissue                   				:= (unsigned)le.iid.socllowissue;
	rc_addrvalflag                   				:= le.iid.addrvalflag;
	rc_dwelltype                     				:= le.iid.dwelltype;
	rc_bansflag                      				:= le.iid.bansflag;
	rc_sources                       				:= le.iid.sources;
	rc_addrcommflag                  				:= le.iid.addrcommflag;
	rc_phonetype                     				:= le.iid.phonetype;
	rc_ziptypeflag                   				:= le.iid.ziptypeflag;
	rc_cityzipflag                   				:= le.iid.cityzipflag;
	combo_ssnscore                   				:= le.iid.combo_ssnscore;
	dobpop                           				:= le.input_validation.dateofbirth;
	add1_isbestmatch                 				:= le.address_verification.input_address_information.isbestmatch;
	add1_unit_count                  				:= le.address_verification.input_address_information.unit_count;
	add1_avm_automated_valuation     				:= (integer)le.avm.input_address_information.avm_automated_valuation;
	add1_avm_med_fips                				:= (integer)le.avm.input_address_information.avm_median_fips_level;
	add1_applicant_owned             				:= le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              				:= le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                				:= le.address_verification.input_address_information.family_owned;
	add1_naprop                      				:= le.address_verification.input_address_information.naprop;
	add1_financing_type           					:= le.address_verification.input_address_information.type_financing;
	add1_date_first_seen             				:= le.address_verification.input_address_information.date_first_seen;
	property_owned_total             				:= le.address_verification.owned.property_total;
	property_owned_assessed_total    				:= le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    				:= le.address_verification.owned.property_owned_assessed_count;
	property_sold_purchase_total     				:= le.address_verification.sold.property_owned_purchase_total;
	property_sold_purchase_count     				:= le.address_verification.sold.property_owned_purchase_count;
	prop1_sale_price                 				:= le.address_verification.recent_property_sales.sale_price1;
	prop1_prev_purchase_price        				:= le.address_verification.recent_property_sales.prev_purch_price1;
	prop2_sale_price                 				:= le.address_verification.recent_property_sales.sale_price2;
	prop2_prev_purchase_price        				:= le.address_verification.recent_property_sales.prev_purch_price2;
	dist_a1toa2                      				:= le.address_verification.distance_in_2_h1;
	add2_isbestmatch                 				:= le.address_verification.address_history_1.isbestmatch;
	add2_applicant_owned             				:= le.address_verification.address_history_1.applicant_owned;
	add2_occupant_owned              				:= le.address_verification.address_history_1.occupant_owned;
	add2_family_owned                				:= le.address_verification.address_history_1.family_owned;
	add3_isbestmatch                 				:= le.address_verification.address_history_2.isbestmatch;
	addrs_5yr                        				:= le.other_address_info.addrs_last_5years;
	addrs_prison_history             				:= le.other_address_info.isprison;
	telcordia_type                   				:= le.phone_verification.telcordia_type;
	gong_did_first_seen              				:= le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               				:= le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_first_ct                				:= le.phone_verification.gong_did.gong_did_first_ct;
	gong_did_last_ct                 				:= le.phone_verification.gong_did.gong_did_last_ct;
	ssns_per_adl                     				:= le.velocity_counters.ssns_per_adl;
	adls_per_addr                    				:= le.velocity_counters.adls_per_addr;
	ssns_per_adl_c6                  				:= le.velocity_counters.ssns_per_adl_created_6months;
	adls_per_addr_c6                 				:= le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 				:= le.velocity_counters.ssns_per_addr_created_6months;
	vo_addrs_per_adl                 				:= le.velocity_counters.vo_addrs_per_adl;
	infutor_nap                      				:= le.infutor_phone.infutor_nap;
	impulse_count                    				:= le.impulse.count;
	impulse_last_seen                				:= le.impulse.last_seen_date;
	attr_addrs_last12                				:= le.other_address_info.addrs_last12;
	attr_addrs_last36                				:= le.other_address_info.addrs_last36;
	attr_num_purchase60              				:= le.other_address_info.num_purchase60;
	attr_num_sold60                  				:= le.other_address_info.num_sold60;
	attr_num_watercraft60            				:= le.watercraft.watercraft_count60;
	attr_num_aircraft                				:= le.aircraft.aircraft_count;
	attr_total_number_derogs         				:= le.total_number_derogs;
	attr_eviction_count              				:= le.bjl.eviction_count;
	attr_date_last_eviction          				:= le.bjl.last_eviction_date;
	attr_eviction_count12            				:= le.bjl.eviction_count12;
	attr_num_nonderogs               				:= le.source_verification.num_nonderogs;
	attr_num_nonderogs90             				:= le.source_verification.num_nonderogs90;
	attr_num_nonderogs12             				:= le.source_verification.num_nonderogs12;
	attr_num_nonderogs36             				:= le.source_verification.num_nonderogs36;
	bankrupt                         				:= le.bjl.bankrupt;
	filing_type                      				:= le.bjl.filing_type;
	disposition                      				:= le.bjl.disposition;
	filing_count                     				:= le.bjl.filing_count;
	bk_recent_count                  				:= le.bjl.bk_recent_count;
	liens_recent_released_count      				:= le.bjl.liens_recent_released_count;
	liens_historical_released_count  				:= le.bjl.liens_historical_released_count;
	liens_recent_unreleased_count      			:= le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_count  			:= le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_ct                				:= le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_cj_last_seen         				:= le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_rel_cj_ct                  				:= le.liens.liens_released_civil_judgment.count;
	liens_unrel_lt_ct                				:= le.liens.liens_unreleased_landlord_tenant.count;
	liens_unrel_lt_last_seen         				:= le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
	liens_unrel_o_ct												:= le.liens.liens_unreleased_other_lj.count;
	liens_rel_o_ct                   				:= le.liens.liens_released_other_lj.count;
	liens_unrel_ot_ct                				:= le.liens.liens_unreleased_other_tax.count;
	liens_unrel_ot_last_seen         				:= le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_rel_ot_ct                  				:= le.liens.liens_released_other_tax.count;
	liens_unrel_sc_ct                				:= le.liens.liens_unreleased_small_claims.count;
	liens_unrel_sc_last_seen         				:= le.liens.liens_unreleased_small_claims.most_recent_filing_date;
	liens_unrel_sc_total_amount      				:= le.liens.liens_unreleased_small_claims.total_amount;
	criminal_count                   				:= le.bjl.criminal_count;
	criminal_last_date               				:= le.bjl.last_criminal_date;
	felony_count                     				:= le.bjl.felony_count;
	watercraft_count                 				:= le.watercraft.watercraft_count;
	ams_college_code                 				:= le.student.college_code;
	ams_college_tier                 				:= le.student.college_tier;
	prof_license_flag                				:= le.professional_license.professional_license_flag;
	prof_license_category            				:= le.professional_license.plcategory;
	input_dob_age                    				:= le.shell_input.age;
	input_dob_match_level            				:= le.dobmatchlevel;
	addr_stability                   				:= le.mobility_indicator;

	seq																			:= le.seq;

/* ***********************************************************
	*                     Generated ECL                        *
	************************************************************ */
NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

Common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool');

Common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool');

lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);

lien_hist_unrel_flag := (liens_historical_unreleased_count > 0);

lien_flag := (((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or ((boolean)(integer)lien_rec_unrel_flag or (boolean)(integer)lien_hist_unrel_flag)));

pk_impulse_count := impulse_count;

pk_impulse_count_2 :=  if(pk_impulse_count > 2, 2, pk_impulse_count);

Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool');

bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

pk_adl_cat_deceased :=  if(trim(trim(adl_category, LEFT), LEFT, RIGHT) = '1 DEAD', 1, 0);

Common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool');

ssn_deceased := (((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1));

bs_own_rent :=  map((add1_naprop = 4) or (property_owned_total > 0)                                                      => '1 Owner ',
                    (trim(trim(out_addr_type, LEFT), LEFT, RIGHT) = 'H') or ((add1_naprop = 1) or (add1_unit_count > 3)) => '2 Renter',
                                                                                                                            '3 Other ');

bs_attr_derog_flag :=  if(attr_total_number_derogs > 0, 1, 0);

bs_attr_eviction_flag :=  if(attr_eviction_count > 0, 1, 0);

bs_attr_derog_flag2 :=  if((bs_attr_derog_flag > 0) or (((integer)lien_flag > 0) or ((bs_attr_eviction_flag > 0) or ((pk_impulse_count_2 > 0) or (((integer)bk_flag > 0) or ((pk_adl_cat_deceased > 0) or ((integer)ssn_deceased > 0)))))), 1, 0);

pk_Segment := '        ';

pk_segment_2 :=  if(bs_attr_derog_flag2 = 1, '0 Derog ', bs_own_rent);

pk_impulse_count_3 := impulse_count;

pk_impulse_count_4 :=  if(pk_impulse_count_3 > 2, 2, pk_impulse_count_3);

pk_attr_total_number_derogs := attr_total_number_derogs;

pk_attr_total_number_derogs_2 :=  if(pk_attr_total_number_derogs > 3, 3, pk_attr_total_number_derogs);

pk_attr_num_nonderogs90 := attr_num_nonderogs90;

pk_attr_num_nonderogs90_2 :=  if(pk_attr_num_nonderogs90 > 4, 4, pk_attr_num_nonderogs90);

pk_attr_num_nonderogs90_b := ((10 * (integer)add1_isbestmatch) + pk_attr_num_nonderogs90_2);

pk_adl_cat_deceased_2 :=  if(trim(trim(adl_category, LEFT), LEFT, RIGHT) = '1 DEAD', 1, 0);

bs_attr_derog_flag_2 :=  if(attr_total_number_derogs > 0, 1, 0);

bs_attr_eviction_flag_2 :=  if(attr_eviction_count > 0, 1, 0);

bs_attr_derog_flag2_2 :=  if((bs_attr_derog_flag_2 > 0) or (((integer)lien_flag > 0) or ((bs_attr_eviction_flag_2 > 0) or ((pk_impulse_count_4 > 0) or (((integer)bk_flag > 0) or ((pk_adl_cat_deceased_2 > 0) or ((integer)ssn_deceased > 0)))))), 1, 0);

pk_own_flag :=  if((add1_naprop in [3, 4]) or (property_owned_total > 0), 1, 0);

pk_segment3 :=  map((bs_attr_derog_flag2_2 = 1) and (pk_own_flag = 1) => '0 Derog-Owner      ',
                    bs_attr_derog_flag2_2 = 1                         => '1 Derog-Other      ',
                    pk_own_flag = 1                                   => '2 Non-Derog-Owner  ',
                                                                         '3 Non-Derog-Other  ');

_gong_did_first_seen := IF(TRIM(gong_did_first_seen)='', -NULL, common.sas_date(gong_did_first_seen));

_gong_did_last_seen := IF(TRIM(gong_did_last_seen)='', -NULL, common.sas_date(gong_did_last_seen));

_criminal_last_date := IF(criminal_last_date=0, -NULL, common.sas_date((STRING)criminal_last_date));

_attr_date_last_eviction := IF(attr_date_last_eviction=0, -NULL, common.sas_date((STRING)attr_date_last_eviction));

_liens_unrel_cj_last_seen := IF(liens_unrel_cj_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_cj_last_seen));

_liens_unrel_sc_last_seen := IF(liens_unrel_sc_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_sc_last_seen));

_in_dob := IF(TRIM(in_dob)='' OR in_dob='0' OR (unsigned)in_dob[1..4] < 1900, -NULL, common.sas_date(in_dob));

_rc_ssnlowissue := IF(rc_ssnlowissue=0, NULL, common.sas_date((STRING)rc_ssnlowissue));

_impulse_last_seen := IF(impulse_last_seen=0, -NULL, common.sas_date((STRING)impulse_last_seen));

_liens_unrel_sc_last_seen_2 := IF(liens_unrel_sc_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_sc_last_seen));

_liens_unrel_ot_last_seen := IF(liens_unrel_ot_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_ot_last_seen));

_liens_unrel_lt_last_seen := IF(liens_unrel_lt_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_lt_last_seen));

_liens_unrel_cj_last_seen_2 := IF(liens_unrel_cj_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_cj_last_seen));

add1_first_seen := IF(add1_date_first_seen=0, -NULL, common.sas_date((STRING)add1_date_first_seen));

yrs_since_gong_first_seen := truncate(((sysdate - _gong_did_first_seen) / 365.25));

mos_since_gong_first_seen := truncate(((sysdate - _gong_did_first_seen) / (365.25 / 12)));

mos_since_gong_last_seen := truncate(((sysdate - _gong_did_last_seen) / (365.25 / 12)));

mos_since_crim_last_seen := truncate(((sysdate - _criminal_last_date) / (365.25 / 12)));

mos_attr_date_last_eviction := truncate(((sysdate - _attr_date_last_eviction) / (365.25 / 30)));

mos_unrel_sc_last_seen := truncate(((sysdate - _liens_unrel_sc_last_seen_2) / (365.25 / 12)));

mos_unrel_ot_last_seen := truncate(((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)));

mos_unrel_lt_last_seen := truncate(((sysdate - _liens_unrel_lt_last_seen) / (365.25 / 12)));

mos_unrel_cj_last_seen := truncate(((sysdate - _liens_unrel_cj_last_seen_2) / (365.25 / 12)));

mos_since_imp_last_seen := truncate(((sysdate - _impulse_last_seen) / (365.25 / 12)));

mos_since_add1_first_seen := truncate(((sysdate - add1_first_seen) / (365.25 / 12)));

mod1_property_lvl :=  if(watercraft_count > 0, 2, min(if(property_owned_total = NULL, -NULL, property_owned_total), 3));

mod1_prof_license := prof_license_flag;

mod1_dist_a1toa2 :=  map(dist_a1toa2 = 0    => 100,
                         dist_a1toa2 > 5000 => 1,
                                               min(if(max((dist_a1toa2 + 1), 1) = NULL, -NULL, max((dist_a1toa2 + 1), 1)), 5000));

mod1_dist_a1toa2_rt := sqrt(mod1_dist_a1toa2);

mod1_gong_first_seen_lvl :=  map(yrs_since_gong_first_seen > 7  => 3,
                                 yrs_since_gong_first_seen > 4  => 2,
                                 yrs_since_gong_first_seen > 1  => 1,
                                 yrs_since_gong_first_seen >= 0 => 0,
                                                                   2);

mod1_addrs_5yr := min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 6);

mod1_best_match_lvl :=  map(add1_isbestmatch => 2,
                            add2_isbestmatch => 1,
                            add3_isbestmatch => 0,
                                                -1);

add_apt := (rc_dwelltype = 'A');

mod1_ssns_per_addr_lvl :=  map(ssns_per_addr_c6 > 4                                           => 4,
                               ssns_per_addr_c6 > 2                                           => 3,
                               (ssns_per_addr_c6 = 2) or ((ssns_per_addr_c6 = 1) and add_apt) => 2,
                               ssns_per_addr_c6 = 1                                           => 1,
                                                                                                 0);

mod1_attr_num_nonderogs_6 := min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 6);

mod1_ADJ_loan := (add1_financing_type = 'ADJ');

phn_last_seen_rec := (mos_since_gong_last_seen = 0);

phn_first_seen_rec := ((0 <= mos_since_gong_first_seen) AND (mos_since_gong_first_seen <= 6));

phn_pots := (telcordia_type in ['00', '50', '51', '52', '54']);

phn_disconnected := ((integer)rc_hriskphoneflag = 5);

phn_inval := (((integer)rc_phonevalflag = 0) or (((integer)rc_hphonevalflag = 0) or (rc_phonetype in ['5'])));

phn_nonUs := (rc_phonetype in ['3', '4']);

phn_highrisk := (((integer)rc_hriskphoneflag = 6) or ((rc_hphonetypeflag = '5') or (((integer)rc_hphonevalflag = 3) or ((integer)rc_addrcommflag = 1))));

phn_notpots := (telcordia_type not in ['00', '50', '51', '52', '54']);

phn_cellpager := ((rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']));

phn_business := ((integer)rc_hphonevalflag = 1);

phn_residential := ((integer)rc_hphonevalflag = 2);

infutor_0 := (infutor_nap in [0]);

infutor_1 := (infutor_nap = 1);

contrary_phn := (nap_summary in [1]);

verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

ver_nap6 := (nap_summary in [6]);

ver_phncount := if(max((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p) = NULL, NULL, sum((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p));

infutor_lvl :=  map(infutor_nap = 0 => 0,
                    infutor_nap = 1 => 1,
                                       2);

nap_lvl :=  map(nap_summary = 12                   => 12,
                verphn_p                           => 3,
                veradd_p or (verlst_p or verfst_p) => 2,
                contrary_phn                       => 1,
                                                      0);

core_adl := ((adl_category)[1..1] = '8');

single_did := (did_count = 1);

low_issue_dob_diff := max(truncate(((_rc_ssnlowissue - _in_dob) / 365.25)), 0);

mod1_gong_name_hi_counts := ((gong_did_first_ct > 2) or (gong_did_last_ct > 2));

mod1_derog_ratio :=  if(attr_total_number_derogs > 0, truncate(min(if((attr_num_nonderogs / attr_total_number_derogs) = NULL, -NULL, (attr_num_nonderogs / attr_total_number_derogs)), 6)), -1);

mod1_derog_ratio2 :=  if(mod1_derog_ratio = -1, (min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 5) + 1), mod1_derog_ratio);

fips_diff := (add1_avm_automated_valuation - add1_avm_med_fips);

invalid_addr := (rc_addrvalflag in ['M', 'N']);

not_reg_zip := ((integer)rc_ziptypeflag != 0);

_reg_zip := ((integer)rc_ziptypeflag = 0);

zip_city_mismatch := ((integer)rc_cityzipflag = 1);

mod1_addr_prob_lvl :=  map(((invalid_addr and not((boolean)(integer)_reg_zip)) or (not((boolean)(integer)_reg_zip) or addrs_prison_history)) => 3,
                           ((integer)rc_ziptypeflag = 0) and ((rc_addrvalflag = 'V') and zip_city_mismatch) => 2,
                           invalid_addr                                                                     => 1,
                                                                                                               0);

liens_released_ct_10 := min(if(if(max(liens_historical_released_count, liens_recent_released_count) = NULL, NULL, sum(if(liens_historical_released_count = NULL, 0, liens_historical_released_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count))) = NULL, -NULL, if(max(liens_historical_released_count, liens_recent_released_count) = NULL, NULL, sum(if(liens_historical_released_count = NULL, 0, liens_historical_released_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count)))), 10);

mod1_lien_rel_lvl :=  map(liens_rel_ot_ct > 1                                  => 0,
                          (liens_rel_ot_ct > 0) and (liens_released_ct_10 < 4) => 0,
                          liens_released_ct_10 > 3                             => 4,
                          liens_released_ct_10 > 1                             => 3,
                          liens_released_ct_10 > 0                             => 2,
                                                                                  1);

seg0_addr_stability_combo :=  map(((integer)addr_stability = 6) and (addrs_5yr = 0) => 0,
                                  ((integer)addr_stability = 6) and (addrs_5yr > 0) => 1,
                                  ((integer)addr_stability = 5) and (addrs_5yr = 0) => 2,
                                  ((integer)addr_stability = 5) and (addrs_5yr > 0) => 3,
                                  ((integer)addr_stability > 1) and (addrs_5yr = 0) => 4,
                                  ((integer)addr_stability > 2) and (addrs_5yr > 0) => 4,
                                  ((integer)addr_stability = 2) and (addrs_5yr > 0) => 5,
                                  ((integer)addr_stability = 0) and (addrs_5yr = 0) => 5,
                                  ((integer)addr_stability = 1) and (addrs_5yr < 2) => 8,
                                                                                       7);

seg0_addr_stability_combo_m0 :=  map(seg0_addr_stability_combo = 0 => 0.0866331658,
                                     seg0_addr_stability_combo = 1 => 0.1097099622,
                                     seg0_addr_stability_combo = 2 => 0.1153395785,
                                     seg0_addr_stability_combo = 3 => 0.1314900154,
                                     seg0_addr_stability_combo = 4 => 0.1419550843,
                                     seg0_addr_stability_combo = 5 => 0.1618945678,
                                     seg0_addr_stability_combo = 7 => 0.2078454333,
                                                                      0.2544303797);

seg0_phn_prob_combo :=  map(phn_first_seen_rec and (phn_notpots or (phn_disconnected or (phn_inval or (phn_cellpager or infutor_1)))) => 10,
                            phn_notpots and (infutor_0 and (phn_cellpager and not(phn_last_seen_rec)))                                => 9,
                            infutor_1 and (phn_residential or phn_business)                                                           => 10,
                            phn_cellpager and (infutor_1 and not(phn_last_seen_rec))                                                  => 8,
                            infutor_1 or (phn_first_seen_rec or phn_inval)                                                            => 7,
                            phn_notpots and (phn_cellpager and (not(phn_residential) and infutor_0))                                  => 7,
                            not(infutor_0) and (not(phn_last_seen_rec) and phn_residential)                                           => 6,
                            (not(infutor_0) and phn_residential) or phn_business                                                      => 5,
                            not(infutor_0) and not(phn_last_seen_rec)                                                                 => 4,
                            (not(infutor_0) or not(phn_residential)) and not(phn_last_seen_rec)                                       => 3,
                            not(infutor_0)                                                                                            => 2,
                            not(phn_last_seen_rec) or not(phn_residential)                                                            => 1,
                                                                                                                                         0);

seg0_phn_prob_combo_m0 :=  map(seg0_phn_prob_combo = 0 => 0.0984175994,
                               seg0_phn_prob_combo = 1 => 0.116328575,
                               seg0_phn_prob_combo = 2 => 0.1244225439,
                               seg0_phn_prob_combo = 3 => 0.1316941731,
                               seg0_phn_prob_combo = 4 => 0.1472392638,
                               seg0_phn_prob_combo = 5 => 0.1635578245,
                               seg0_phn_prob_combo = 6 => 0.1639954207,
                               seg0_phn_prob_combo = 7 => 0.1722451081,
                               seg0_phn_prob_combo = 8 => 0.166001994,
                               seg0_phn_prob_combo = 9 => 0.1930809636,
                                                          0.2115621156);

seg0_nap_lvl_combo :=  map((nap_lvl = 12) and (infutor_lvl = 0)          => 8,
                           (nap_lvl = 3) and (infutor_lvl = 0)           => 7,
                           (nap_lvl = 2) and (infutor_lvl = 2)           => 6,
                           (nap_lvl = 2) and (infutor_lvl = 0)           => 5,
                           (nap_lvl < 2) and (infutor_lvl = 2)           => 5,
                           (nap_lvl = 12) and (infutor_lvl = 2)          => 4,
                           (nap_lvl = 0) and (infutor_lvl = 1)           => 2,
                           (nap_lvl = 0) and (infutor_lvl = 0)           => 1,
                           (nap_lvl in [1, 3, 12]) and (infutor_lvl = 1) => 0,
                                                                            3);

seg0_nap_lvl_combo_m0 :=  map(seg0_nap_lvl_combo = 0 => 0.2215422277,
                              seg0_nap_lvl_combo = 1 => 0.1849474116,
                              seg0_nap_lvl_combo = 2 => 0.1714975845,
                              seg0_nap_lvl_combo = 3 => 0.1769637325,
                              seg0_nap_lvl_combo = 4 => 0.1698989347,
                              seg0_nap_lvl_combo = 5 => 0.1474619529,
                              seg0_nap_lvl_combo = 6 => 0.1293542074,
                              seg0_nap_lvl_combo = 7 => 0.1077474892,
                                                        0.0952570745);

seg0_adls_per_addr_combo :=  map(((1 < adls_per_addr) AND (adls_per_addr < 10)) and (adls_per_addr_c6 = 0)   => 0,
                                 ((0 < adls_per_addr) AND (adls_per_addr < 15)) and (adls_per_addr_c6 = 0)   => 1,
                                 ((2 < adls_per_addr) AND (adls_per_addr < 6)) and (adls_per_addr_c6 = 1)    => 1,
                                 ((1 < adls_per_addr) AND (adls_per_addr < 10)) and (adls_per_addr_c6 = 2)   => 2,
                                 (adls_per_addr = 2) and (adls_per_addr_c6 = 1)                              => 2,
                                 ((15 <= adls_per_addr) AND (adls_per_addr < 40)) and (adls_per_addr_c6 = 0) => 3,
                                 ((5 < adls_per_addr) AND (adls_per_addr < 30)) and (adls_per_addr_c6 = 1)   => 3,
                                 (adls_per_addr > 4) and (adls_per_addr_c6 > 2)                              => 5,
                                 adls_per_addr >= 20                                                         => 5,
                                                                                                                4);

seg0_adls_per_addr_combo_m0 :=  map(seg0_adls_per_addr_combo = 0 => 0.1237790319,
                                    seg0_adls_per_addr_combo = 1 => 0.1381528732,
                                    seg0_adls_per_addr_combo = 2 => 0.1554889472,
                                    seg0_adls_per_addr_combo = 3 => 0.1576407507,
                                    seg0_adls_per_addr_combo = 4 => 0.1751836224,
                                                                    0.1881848499);

// seg0_gong_first_seen_combo :=  map(missing(mos_since_gong_first_seen) => 36,
seg0_gong_first_seen_combo :=  map(mos_since_gong_first_seen < 0 => 36,
                                   mos_since_gong_first_seen = 0      => 1,
                                                                         min(if(max(mos_since_gong_first_seen, 1) = NULL, -NULL, max(mos_since_gong_first_seen, 1)), 500));

seg0_gong_first_seen_combo_rt := sqrt(seg0_gong_first_seen_combo);

seg0_criminal_lvl :=  map(((0 <= mos_since_crim_last_seen) AND (mos_since_crim_last_seen <= 24)) or (felony_count > 0) => 3,
                          (0 <= mos_since_crim_last_seen) AND (mos_since_crim_last_seen <= 48)                         => 2,
                          criminal_count > 0                                                                           => 1,
                                                                                                                          0);

seg0_criminal_lvl_m0 :=  map(seg0_criminal_lvl = 0 => 0.1429500902,
                             seg0_criminal_lvl = 1 => 0.1612483745,
                             seg0_criminal_lvl = 2 => 0.1886051081,
                                                      0.2054263566);

// seg0_bk_lvl :=  map((filing_count > 2) or ((impulse_count > 0) or (bankrupt and (missing(filing_type) and missing(disposition)))) => 2,
seg0_bk_lvl :=  map((filing_count > 2) or ((impulse_count > 0) or (bankrupt and (trim(filing_type)='' and trim(disposition)=''))) => 2,
                    bankrupt and (StringLib.StringToUpperCase(disposition) = 'DISMISSED')                                                      => 1,
                                                                                                                                     0);

seg0_bk_lvl_m0 :=  map(seg0_bk_lvl = 0 => 0.1401032115,
                       seg0_bk_lvl = 1 => 0.1947214076,
                                          0.2512896094);

seg0_eviction_lvl :=  map((0 <= mos_attr_date_last_eviction) AND (mos_attr_date_last_eviction <= 48) => 2,
                          attr_eviction_count > 0                                                    => 1,
                                                                                                        0);

seg0_eviction_lvl_m0 :=  map(seg0_eviction_lvl = 0 => 0.1404818099,
                             seg0_eviction_lvl = 1 => 0.2036005144,
                                                      0.2719594595);

//                               not(missing(ams_college_code)) => 1,
seg0_ams_college_code :=  map((integer)ams_college_code = 4  => 2,
                              not(trim(ams_college_code)='') => 1,
                                                                0);

seg0_ams_college_code_m0 :=  map(seg0_ams_college_code = 0 => 0.1464856162,
                                 seg0_ams_college_code = 1 => 0.1369863014,
                                                              0.1099389228);

seg0_vo_addrs_per_adl_lvl :=  if(vo_addrs_per_adl = 0, 3, (min(if(vo_addrs_per_adl = NULL, -NULL, vo_addrs_per_adl), 4) - 1));

seg0_vo_addrs_per_adl_lvl_m0 :=  map(seg0_vo_addrs_per_adl_lvl = 0 => 0.1247404331,
                                     seg0_vo_addrs_per_adl_lvl = 1 => 0.1340355975,
                                     seg0_vo_addrs_per_adl_lvl = 2 => 0.1416666667,
                                                                      0.1563786008);

seg0_age_lvl_b1 := map((integer)input_dob_match_level = 0                               => 0,
                       (integer)input_dob_match_level != 8                              => 1,
                       (55 < (integer)input_dob_age) AND ((integer)input_dob_age <= 65) => 5,
                       (45 < (integer)input_dob_age) AND ((integer)input_dob_age <= 55) => 4,
                       (35 < (integer)input_dob_age) AND ((integer)input_dob_age <= 45) => 3,
                                                                                           2);

seg0_age_lvl := if(dobpop, seg0_age_lvl_b1, -1);

seg0_age_lvl_m0 :=  map(seg0_age_lvl = 0 => 0.2183544304,
                        seg0_age_lvl = 1 => 0.1661600811,
                        seg0_age_lvl = 2 => 0.1624370218,
                        seg0_age_lvl = 3 => 0.1458492976,
                        seg0_age_lvl = 4 => 0.1274957902,
                        seg0_age_lvl = 5 => 0.1261953552,
                                            0.14830);

seg0_age_lvl_2 :=  map(seg0_age_lvl = 0 => seg0_age_lvl,
                       seg0_age_lvl = 1 => seg0_age_lvl,
                       seg0_age_lvl = 2 => seg0_age_lvl,
                       seg0_age_lvl = 3 => seg0_age_lvl,
                       seg0_age_lvl = 4 => seg0_age_lvl,
                       seg0_age_lvl = 5 => seg0_age_lvl,
                                           .14830);

liens_unrel_cj_lvl :=  map(((0 <= mos_unrel_cj_last_seen) AND (mos_unrel_cj_last_seen <= 12)) or ((mos_unrel_cj_last_seen <= 24) and (liens_unrel_cj_ct >= 3)) => 2,
                           liens_unrel_cj_ct > 0                                                                                                               => 1,
                                                                                                                                                                  0);

seg0_liens_cj_lvl :=  map(liens_unrel_cj_lvl = 2                             => 3,
                          (liens_unrel_cj_lvl = 1) and (liens_rel_cj_ct < 2) => 2,
                          (liens_unrel_cj_lvl = 0) and (liens_rel_cj_ct = 0) => 0,
                                                                                1);

seg0_liens_cj_lvl_m0 :=  map(seg0_liens_cj_lvl = 0 => 0.1396545778,
                             seg0_liens_cj_lvl = 1 => 0.135501355,
                             seg0_liens_cj_lvl = 2 => 0.161902415,
                                                      0.1802780191);

seg0_liens_sc_lvl :=  map((0 <= mos_unrel_sc_last_seen) AND (mos_unrel_sc_last_seen <= 24) => 2,
                          liens_unrel_sc_ct > 0                                            => 1,
                                                                                              0);

seg0_liens_sc_lvl_m0 :=  map(seg0_liens_sc_lvl = 0 => 0.1423988477,
                             seg0_liens_sc_lvl = 1 => 0.1690563521,
                                                      0.1859030837);

seg0_adl_lvl :=  map(core_adl and single_did => 0,
                     not(single_did)         => 1,
                                                2);

seg0_adl_lvl_m0 :=  map(seg0_adl_lvl = 0 => 0.1418365462,
                        seg0_adl_lvl = 1 => 0.1678200692,
                                            0.3553223388);

seg0_fips_diff :=  map((fips_diff <= (integer)-200000) or (fips_diff >= (integer)500000) => 0,
                       (fips_diff <= (integer)-50000) or (fips_diff = (integer)0)        => 1,
                       (fips_diff < (integer)0) or (fips_diff > (integer)200000)         => 2,
                                                                          3);

seg0_fips_diff_m0 :=  map(seg0_fips_diff = 0 => 0.1728999413,
                          seg0_fips_diff = 1 => 0.1492689067,
                          seg0_fips_diff = 2 => 0.1413362394,
                                                0.1297081363);

seg0_attr_prop_turnover :=  map((attr_num_purchase60 in [1, 2]) and (attr_num_sold60 = 0) => 0,
                                (attr_num_purchase60 in [1, 2]) and (attr_num_sold60 = 1) => 1,
                                (attr_num_purchase60 = 0) and (attr_num_sold60 = 0)       => 2,
                                (attr_num_purchase60 = 0) and (attr_num_sold60 = 1)       => 3,
                                                                                             4);

seg0_attr_prop_turnover_m0 :=  map(seg0_attr_prop_turnover = 0 => 0.1501555283,
                                   seg0_attr_prop_turnover = 1 => 0.1518891688,
                                   seg0_attr_prop_turnover = 2 => 0.1342560208,
                                   seg0_attr_prop_turnover = 3 => 0.1586250394,
                                                                  0.166771952);

mod1_property_lvl_m0 :=  map(mod1_property_lvl = 0 => 0.15334805,
                             mod1_property_lvl = 1 => 0.1422399055,
                             mod1_property_lvl = 2 => 0.1475593372,
                                                      0.1491739553);

seg0_rec_vehx_flag := ((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0));

seg0_low_issue_dob_diff :=  if(low_issue_dob_diff > 18, (0 - min(low_issue_dob_diff, 50) + 51), (low_issue_dob_diff + 33));

seg0_low_issue_dob_diff_lg := ln(seg0_low_issue_dob_diff);

SANT_LOG_SEG0 := -11.960088 +
    (seg0_addr_stability_combo_m0 * 5.3902660704) +
    (seg0_phn_prob_combo_m0 * 3.1359107969) +
    (seg0_nap_lvl_combo_m0 * 4.0494814271) +
    (seg0_adls_per_addr_combo_m0 * 3.2514347869) +
    (seg0_gong_first_seen_combo_rt * -0.025627292) +
    (seg0_criminal_lvl_m0 * 4.9709349603) +
    (seg0_bk_lvl_m0 * 6.7739447791) +
    (seg0_eviction_lvl_m0 * 3.7948721494) +
    (seg0_ams_college_code_m0 * 8.5311395048) +
    (seg0_vo_addrs_per_adl_lvl_m0 * 5.1656246318) +
    (seg0_age_lvl_m0 * 3.6846958657) +
    (seg0_liens_cj_lvl_m0 * 4.3242433615) +
    (seg0_liens_sc_lvl_m0 * 5.7576210386) +
    (seg0_adl_lvl_m0 * 5.7074290052) +
    (seg0_fips_diff_m0 * 2.7752175212) +
    (seg0_attr_prop_turnover_m0 * 3.5399324298) +
    (mod1_property_lvl_m0 * 7.6137438198) +
    ((integer)seg0_rec_vehx_flag * -0.175000255) +
    (seg0_low_issue_dob_diff_lg * -0.277648515) +
    ((integer)mod1_ADJ_loan * 0.1242081888) +
    ((integer)mod1_prof_license * -0.179123764) +
    (mod1_dist_a1toa2_rt * -0.006065024);

seg1_addrs_last_combo :=  map((attr_addrs_last12 = 0) and (attr_addrs_last36 = 0)  => 0,
                              (attr_addrs_last12 = 0) and (attr_addrs_last36 = 1)  => 1,
                              (attr_addrs_last12 = 0) and (attr_addrs_last36 < 5)  => 2,
                              (attr_addrs_last12 = 0) and (attr_addrs_last36 >= 5) => 3,
                              (attr_addrs_last12 = 1) and (attr_addrs_last36 < 4)  => 3,
                              (attr_addrs_last12 = 1) and (attr_addrs_last36 = 4)  => 4,
                              (attr_addrs_last12 > 1) and (attr_addrs_last36 < 4)  => 4,
                                                                                      5);

seg1_addr_stability_combo :=  map((seg1_addrs_last_combo in [0, 1]) and ((integer)addr_stability = 6)    => 8,
                                  (seg1_addrs_last_combo = 1) and ((integer)addr_stability = 5)          => 7,
                                  (seg1_addrs_last_combo > 3) and ((integer)addr_stability > 4)          => 7,
                                  (seg1_addrs_last_combo = 5) and ((integer)addr_stability = 4)          => 7,
                                  (seg1_addrs_last_combo in [0, 1, 3]) and ((integer)addr_stability = 4) => 6,
                                  (seg1_addrs_last_combo = 0) and ((integer)addr_stability = 5)          => 5,
                                  (seg1_addrs_last_combo = 2) and ((integer)addr_stability = 4)          => 5,
                                  (seg1_addrs_last_combo = 4) and ((integer)addr_stability = 3)          => 5,
                                  (seg1_addrs_last_combo = 1) and ((integer)addr_stability = 0)          => 5,
                                  (seg1_addrs_last_combo = 5) and ((integer)addr_stability = 3)          => 3,
                                  (integer)addr_stability = 2                                            => 3,
                                  (seg1_addrs_last_combo in [2, 3]) and (addr_stability in ['0', '1'])   => 2,
                                  (seg1_addrs_last_combo = 1) and ((integer)addr_stability = 1)          => 2,
                                  (seg1_addrs_last_combo in [4, 5]) and ((integer)addr_stability = 1)    => 1,
                                  (seg1_addrs_last_combo in [4, 5]) and ((integer)addr_stability = 0)    => 0,
                                  (seg1_addrs_last_combo = 0) and ((integer)addr_stability = 1)          => 0,
                                                                                                            4);

seg1_addr_stability_combo_m1 :=  map(seg1_addr_stability_combo = 0 => 0.2271505376,
                                     seg1_addr_stability_combo = 1 => 0.2183098592,
                                     seg1_addr_stability_combo = 2 => 0.2131458967,
                                     seg1_addr_stability_combo = 3 => 0.1851110877,
                                     seg1_addr_stability_combo = 4 => 0.15941021,
                                     seg1_addr_stability_combo = 5 => 0.1496651612,
                                     seg1_addr_stability_combo = 6 => 0.129972752,
                                     seg1_addr_stability_combo = 7 => 0.1273809524,
                                                                      0.1264071295);

seg1_attr_eviction_combo :=  map((attr_eviction_count12 = 1) and (attr_eviction_count = 1) => 4,
                                 (attr_eviction_count12 > 0) and (attr_eviction_count > 0) => 3,
                                 attr_eviction_count > 3                                   => 2,
                                 attr_eviction_count > 0                                   => 1,
                                                                                              0);

seg1_attr_eviction_combo_m1 :=  map(seg1_attr_eviction_combo = 0 => 0.1609102174,
                                    seg1_attr_eviction_combo = 1 => 0.2118705911,
                                    seg1_attr_eviction_combo = 2 => 0.2325976231,
                                    seg1_attr_eviction_combo = 3 => 0.3229398664,
                                                                    0.3322683706);

seg1_phn_prob_combo :=  map(phn_first_seen_rec or phn_nonUs                                                           => 6,
                            infutor_0 and (phn_cellpager and not(phn_last_seen_rec))                                  => 5,
                            infutor_1 and phn_residential                                                             => 5,
                            infutor_1                                                                                 => 4,
                            phn_cellpager and infutor_0                                                               => 3,
                            not(infutor_0) and (phn_residential and not(phn_last_seen_rec))                           => 3,
                            phn_cellpager or (phn_disconnected and not(infutor_0))                                    => 2,
                            (not(phn_residential) and not(phn_last_seen_rec)) or (not(infutor_0) and phn_residential) => 1,
                                                                                                                         0);

seg1_phn_prob_combo_m1 :=  map(seg1_phn_prob_combo = 0 => 0.1289985052,
                               seg1_phn_prob_combo = 1 => 0.1546607948,
                               seg1_phn_prob_combo = 2 => 0.1693535765,
                               seg1_phn_prob_combo = 3 => 0.1894371941,
                               seg1_phn_prob_combo = 4 => 0.191848058,
                               seg1_phn_prob_combo = 5 => 0.2077973876,
                                                          0.2212581345);

seg1_ssns_per_adl_combo :=  map((ssns_per_adl_c6 = 0) and (ssns_per_adl in [1, 2]) => 0,
                                (ssns_per_adl_c6 = 0) and (ssns_per_adl in [0, 3]) => 1,
                                (ssns_per_adl_c6 = 0) and (ssns_per_adl = 4)       => 2,
                                (ssns_per_adl_c6 = 1) and (ssns_per_adl = 1)       => 2,
                                (ssns_per_adl_c6 in [1, 2]) and (ssns_per_adl = 2) => 3,
                                (ssns_per_adl_c6 = 1) and (ssns_per_adl in [3, 4]) => 4,
                                (ssns_per_adl_c6 = 0) and (ssns_per_adl in [5, 6]) => 4,
                                                                                      5);

seg1_ssns_per_adl_combo_m1 :=  map(seg1_ssns_per_adl_combo = 0 => 0.1548182187,
                                   seg1_ssns_per_adl_combo = 1 => 0.1772030651,
                                   seg1_ssns_per_adl_combo = 2 => 0.1820286758,
                                   seg1_ssns_per_adl_combo = 3 => 0.1968165197,
                                   seg1_ssns_per_adl_combo = 4 => 0.2084690554,
                                                                  0.2347629797);

seg1_nap_lvl_combo :=  map((nap_lvl = 12) and (infutor_lvl = 0)          => 5,
                           (nap_lvl = 3) and (infutor_lvl = 0)           => 4,
                           (nap_lvl < 3) and (infutor_lvl = 2)           => 4,
                           (nap_lvl = 12) and (infutor_lvl = 2)          => 3,
                           (nap_lvl = 2) and (infutor_lvl = 0)           => 2,
                           (nap_lvl = 0) and (infutor_lvl = 1)           => 2,
                           (nap_lvl in [1, 3, 12]) and (infutor_lvl = 1) => 0,
                                                                            1);

seg1_nap_lvl_combo_m1 :=  map(seg1_nap_lvl_combo = 0 => 0.2204724409,
                              seg1_nap_lvl_combo = 1 => 0.1948368794,
                              seg1_nap_lvl_combo = 2 => 0.1874832125,
                              seg1_nap_lvl_combo = 3 => 0.1687301026,
                              seg1_nap_lvl_combo = 4 => 0.1442371551,
                                                        0.109610984);

criminal_lvl :=  map(((0 <= mos_since_crim_last_seen) AND (mos_since_crim_last_seen <= 12)) or (mos_since_imp_last_seen > 0) => 4,
                     (12 < mos_since_crim_last_seen) AND (mos_since_crim_last_seen <= 24)                                    => 3,
                     (24 < mos_since_crim_last_seen) AND (mos_since_crim_last_seen <= 48)                                    => 2,
                     mos_since_crim_last_seen >= 0                                                                           => 1,
                                                                                                                                0);

seg1_criminal_combo :=  map(((criminal_lvl > 2) AND (criminal_count > 1)) OR ((criminal_count = 0) AND (criminal_lvl = 4)) 		=> 3,
														(criminal_lvl = 1) OR ((criminal_count = 1) AND (criminal_lvl = 2))																=> 1,
														(criminal_lvl > 0) AND (criminal_count > 0)																												=> 2,
                                                                                                                                 0);

seg1_criminal_combo_2 :=  map(((criminal_lvl > 2) and (criminal_count > 1)) or ((criminal_count = 0) and (criminal_lvl = 4)) => 3,
                              (criminal_lvl = 1) or ((criminal_count = 1) and (criminal_lvl = 2))                            => 1,
                              (criminal_lvl > 0) and (criminal_count > 0)                                                    => 2,
                                                                                                                                0);

seg1_criminal_combo_m1 :=  map(seg1_criminal_combo_2 = 0 => 0.1641488499,
                               seg1_criminal_combo_2 = 1 => 0.2116004296,
                               seg1_criminal_combo_2 = 2 => 0.2624378109,
                                                            0.3206349206);

seg1_unrel_sc_combo :=  map((0 <= mos_unrel_sc_last_seen) AND (mos_unrel_sc_last_seen <= 12)            => 3,
                            (0 < liens_unrel_sc_total_amount) AND (liens_unrel_sc_total_amount <= 5000) => 2,
                            liens_unrel_sc_ct > 0                                                       => 1,
                                                                                                           0);

seg1_unrel_sc_combo_m1 :=  map(seg1_unrel_sc_combo = 0 => 0.1652699149,
                               seg1_unrel_sc_combo = 1 => 0.1784841076,
                               seg1_unrel_sc_combo = 2 => 0.1899056844,
                                                          0.2557781202);

seg1_unrel_ot_combo :=  map((0 <= mos_unrel_ot_last_seen) AND (mos_unrel_ot_last_seen <= 24) => 2,
                            mos_unrel_ot_last_seen >= 0                                      => 1,
                                                                                                0);

seg1_unrel_ot_combo_m1 :=  map(seg1_unrel_ot_combo = 0 => 0.1680907356,
                               seg1_unrel_ot_combo = 1 => 0.1610169492,
                                                          0.1922304086);

seg1_unrel_lt_combo :=  map(((0 <= mos_unrel_lt_last_seen) AND (mos_unrel_lt_last_seen <= 12)) or (liens_unrel_lt_ct > 2) => 2,
                            mos_unrel_lt_last_seen >= 0                                                                   => 1,
                                                                                                                             0);

seg1_unrel_lt_combo_m1 :=  map(seg1_unrel_lt_combo = 0 => 0.1654335356,
                               seg1_unrel_lt_combo = 1 => 0.2272727273,
                                                          0.3684210526);

seg1_unrel_cj_combo :=  map((0 <= mos_unrel_cj_last_seen) AND (mos_unrel_cj_last_seen <= 6)  => 3,
                            (0 <= mos_unrel_cj_last_seen) AND (mos_unrel_cj_last_seen <= 24) => 2,
                            mos_unrel_cj_last_seen >= 0                                      => 1,
                                                                                                0);

seg1_unrel_cj_combo_m1 :=  map(seg1_unrel_cj_combo = 0 => 0.1601435275,
                               seg1_unrel_cj_combo = 1 => 0.1805305755,
                               seg1_unrel_cj_combo = 2 => 0.197225573,
                                                          0.2398576512);

// seg1_bk_lvl :=  map((filing_count > 2) or ((impulse_count > 0) or (bankrupt and (missing(filing_type) and missing(disposition)))) => 2,
seg1_bk_lvl :=  map((filing_count > 2) or ((impulse_count > 0) or (bankrupt and (trim(filing_type)='' and trim(disposition)=''))) => 2,
                    bankrupt and (StringLib.StringToUpperCase(disposition) = 'DISMISSED')                                                      => 1,
                                                                                                                                     0);

seg1_bk_lvl_m1 :=  map(seg1_bk_lvl = 0 => 0.1647879877,
                       seg1_bk_lvl = 1 => 0.2213114754,
                                          0.2577413479);

prop1_sale_price_a :=  if(prop1_prev_purchase_price > 0, ((prop1_sale_price / prop1_prev_purchase_price) * 100), - 999);

prop2_sale_price_a :=  if(prop2_prev_purchase_price > 0, ((prop2_sale_price / prop2_prev_purchase_price) * 100), - 999);

prop1_sale_profit :=  map(((real)-999 < prop1_sale_price_a) AND (prop1_sale_price_a < (real)75)  => 'NEGATIVE',
                          ((real)75 <= prop1_sale_price_a) AND (prop1_sale_price_a <= (real)125) => 'NEUTRAL ',
                          prop1_sale_price_a > (real)125                                   => 'POSITIVE',
                                                                                        'NO SALE');

prop2_sale_profit :=  map(((real)-999 < prop2_sale_price_a) AND (prop2_sale_price_a < (real)75)  => 'NEGATIVE',
                          ((real)75 <= prop2_sale_price_a) AND (prop2_sale_price_a <= (real)125) => 'NEUTRAL ',
                          prop2_sale_price_a > (real)125                                   => 'POSITIVE',
                                                                                        'NO SALE');

seg1_prop_sale_history :=  map(prop2_sale_profit in ['NEGATIVE', 'POSITIVE']                        => 0,
                               (prop2_sale_profit = 'NO SALE') and (prop1_sale_profit = 'NEGATIVE') => 1,
                               (prop2_sale_profit = 'NO SALE') and (prop1_sale_profit = 'POSITIVE') => 2,
                                                                                                       3);

seg1_prop_sale_history_m1 :=  map(seg1_prop_sale_history = 0 => 0.2463768116,
                                  seg1_prop_sale_history = 1 => 0.2011385199,
                                  seg1_prop_sale_history = 2 => 0.1874105866,
                                                                0.1675341843);

//                               not(missing(ams_college_code)) => 1,
seg1_ams_college_code :=  map((integer)ams_college_code = 4  => 2,
                              not(trim(ams_college_code)='') => 1,
                                                                0);

seg1_ams_college_code_m1 :=  map(seg1_ams_college_code = 0 => 0.1705913467,
                                 seg1_ams_college_code = 1 => 0.1389236546,
                                                              0.1261918116);

seg1_vo_addrs_per_adl_lvl :=  if(vo_addrs_per_adl = 0, 3, (min(if(vo_addrs_per_adl = NULL, -NULL, vo_addrs_per_adl), 4) - 1));

seg1_vo_addrs_per_adl_lvl_m1 :=  map(seg1_vo_addrs_per_adl_lvl = 0 => 0.1511130137,
                                     seg1_vo_addrs_per_adl_lvl = 1 => 0.1579174768,
                                     seg1_vo_addrs_per_adl_lvl = 2 => 0.1353846154,
                                                                      0.1758546885);

seg1_age_lvl_b1 := map((integer)input_dob_match_level = 0                               => 0,
                       (integer)input_dob_match_level != 8                              => 1,
                       (55 < (integer)input_dob_age) AND ((integer)input_dob_age <= 65) => 5,
                       (45 < (integer)input_dob_age) AND ((integer)input_dob_age <= 55) => 4,
                       (35 < (integer)input_dob_age) AND ((integer)input_dob_age <= 45) => 3,
                                                                                           2);

seg1_age_lvl := if(dobpop, seg1_age_lvl_b1, -1);

seg1_age_lvl_m1 :=  map(seg1_age_lvl = 0 => 0.233785822,
                        seg1_age_lvl = 1 => 0.1909481952,
                        seg1_age_lvl = 2 => 0.1755233494,
                        seg1_age_lvl = 3 => 0.171008967,
                        seg1_age_lvl = 4 => 0.1528245417,
                        seg1_age_lvl = 5 => 0.140455416,
                                            .14830);

seg1_adl_lvl :=  map(core_adl and single_did => 0,
                     not(single_did)         => 1,
                                                2);

seg1_adl_lvl_m1 :=  map(seg1_adl_lvl = 0 => 0.1648563744,
                        seg1_adl_lvl = 1 => 0.189516129,
                                            0.4259259259);

seg1_fips_diff :=  map((fips_diff <= (integer)-200000) or (fips_diff >= (integer)500000) => 0,
                       (fips_diff <= (integer)-50000) or (fips_diff = (integer)0)        => 1,
                       (fips_diff < (integer)0) or (fips_diff > (integer)200000)         => 2,
                                                                          3);

seg1_fips_diff_m1 :=  map(seg1_fips_diff = 0 => 0.1681263568,
                          seg1_fips_diff = 1 => 0.1705599642,
                          seg1_fips_diff = 2 => 0.1740607514,
                                                0.1516261038);

mod1_gong_first_seen_lvl_m1 :=  map(mod1_gong_first_seen_lvl = 0 => 0.1982594506,
                                    mod1_gong_first_seen_lvl = 1 => 0.165129228,
                                    mod1_gong_first_seen_lvl = 2 => 0.1673483194,
                                                                    0.1489493201);

mod1_addrs_5yr_m1 :=  map(mod1_addrs_5yr = 0 => 0.1492669363,
                          mod1_addrs_5yr = 1 => 0.1582359464,
                          mod1_addrs_5yr = 2 => 0.1716623759,
                          mod1_addrs_5yr = 3 => 0.1739495798,
                          mod1_addrs_5yr = 4 => 0.1820374838,
                          mod1_addrs_5yr = 5 => 0.1852230167,
                                                0.1947761194);

mod1_best_match_lvl_m1 :=  map(mod1_best_match_lvl = -1 => 0.186965812,
                               mod1_best_match_lvl = 0  => 0.2092307692,
                               mod1_best_match_lvl = 1  => 0.2028748045,
                                                           0.1539874835);

mod1_ssns_per_addr_lvl_m1 :=  map(mod1_ssns_per_addr_lvl = 0 => 0.159536773,
                                  mod1_ssns_per_addr_lvl = 1 => 0.1808030113,
                                  mod1_ssns_per_addr_lvl = 2 => 0.1892655367,
                                  mod1_ssns_per_addr_lvl = 3 => 0.2106068332,
                                                                0.2793522267);

mod1_attr_num_nonderogs_6_m1 :=  map(mod1_attr_num_nonderogs_6 = 0 => 0.1538461538,
                                     mod1_attr_num_nonderogs_6 = 1 => 0.1874844798,
                                     mod1_attr_num_nonderogs_6 = 2 => 0.1726756318,
                                     mod1_attr_num_nonderogs_6 = 3 => 0.1571992587,
                                     mod1_attr_num_nonderogs_6 = 4 => 0.1492693111,
                                     mod1_attr_num_nonderogs_6 = 5 => 0.1488912355,
                                                                      0.1383928571);

// seg1_add1_first_seen_mos :=  if(missing(mos_since_add1_first_seen), 1, min(if(max(mos_since_add1_first_seen, 1) = NULL, -NULL, max(mos_since_add1_first_seen, 1)), 500));
seg1_add1_first_seen_mos :=  if(mos_since_add1_first_seen=NULL, 1, min(if(max(mos_since_add1_first_seen, 1) = NULL, -NULL, max(mos_since_add1_first_seen, 1)), 500));

seg1_add1_first_seen_mos_lg := ln(seg1_add1_first_seen_mos);

SANT_LOG_SEG1 := -17.18723545 +
    (seg1_addr_stability_combo_m1 * 4.9312066223) +
    (seg1_attr_eviction_combo_m1 * 3.0242452776) +
    (seg1_phn_prob_combo_m1 * 3.2992540275) +
    (seg1_ssns_per_adl_combo_m1 * 2.5843863082) +
    (seg1_nap_lvl_combo_m1 * 3.3607492802) +
    (seg1_criminal_combo_m1 * 4.7443749158) +
    (seg1_unrel_sc_combo_m1 * 5.4968292764) +
    (seg1_unrel_ot_combo_m1 * 6.6468500229) +
    (seg1_unrel_lt_combo_m1 * 2.2492460988) +
    (seg1_unrel_cj_combo_m1 * 3.6823483635) +
    (seg1_bk_lvl_m1 * 7.008929558) +
    (seg1_prop_sale_history_m1 * 6.4895119766) +
    (seg1_ams_college_code_m1 * 8.2729967732) +
    (seg1_vo_addrs_per_adl_lvl_m1 * 4.797156095) +
    (seg1_age_lvl_m1 * 3.6872568302) +
    (seg1_adl_lvl_m1 * 5.2275524504) +
    (seg1_fips_diff_m1 * 7.3625812668) +
    (mod1_gong_first_seen_lvl_m1 * 4.334157802) +
    (mod1_addrs_5yr_m1 * -4.316713187) +
    (mod1_best_match_lvl_m1 * 3.8334652697) +
    (mod1_ssns_per_addr_lvl_m1 * 3.356253208) +
    (mod1_attr_num_nonderogs_6_m1 * 2.7458999445) +
    (seg1_add1_first_seen_mos_lg * -0.022080334) +
    (mod1_dist_a1toa2_rt * -0.004981193);

seg2_phn_prob_combox :=  map((phn_cellpager and not(phn_last_seen_rec)) or phn_first_seen_rec                                                                                                                                         => 4,
                             phn_cellpager or ((phn_business and not(phn_last_seen_rec)) or ((phn_highrisk and not(phn_last_seen_rec)) or ((phn_inval and not(phn_last_seen_rec)) or (phn_disconnected and not(phn_last_seen_rec))))) => 3,
                             not(phn_last_seen_rec) or phn_business                                                                                                                                                                   => 2,
                             phn_residential or phn_disconnected                                                                                                                                                                      => 1,
                                                                                                                                                                                                                                         0);

seg2_phn_prob_combox_m2 :=  map(seg2_phn_prob_combox = 0 => 0.0832395951,
                                seg2_phn_prob_combox = 1 => 0.1014896837,
                                seg2_phn_prob_combox = 2 => 0.1251168297,
                                seg2_phn_prob_combox = 3 => 0.1420876672,
                                                            0.1618118264);

seg2_nap_level_combox :=  map((nap_lvl = 12) and (infutor_lvl = 0) => 6,
                              (nap_lvl = 3) and (infutor_lvl = 0)  => 5,
                              (nap_lvl = 2) and (infutor_lvl = 2)  => 4,
                              (nap_lvl = 12) and (infutor_lvl = 2) => 3,
                              (nap_lvl = 0) and (infutor_lvl = 2)  => 3,
                              (nap_lvl < 3) and (infutor_lvl = 0)  => 2,
                              (nap_lvl = 2) and (infutor_lvl = 1)  => 2,
                              (nap_lvl = 3) and (infutor_lvl = 2)  => 1,
                              nap_lvl in [0, 12]                   => 1,
                                                                      0);

seg2_nap_level_combox_m2 :=  map(seg2_nap_level_combox = 0 => 0.214532872,
                                 seg2_nap_level_combox = 1 => 0.1660085295,
                                 seg2_nap_level_combox = 2 => 0.1550584997,
                                 seg2_nap_level_combox = 3 => 0.1291871249,
                                 seg2_nap_level_combox = 4 => 0.1181183237,
                                 seg2_nap_level_combox = 5 => 0.098240866,
                                                              0.0768310514);

seg2_attr_addrs_combox :=  map((attr_addrs_last36 = 0) and (attr_addrs_last12 = 0) => 0,
                               (attr_addrs_last36 = 1) and (attr_addrs_last12 = 0) => 1,
                               (attr_addrs_last36 < 5) and (attr_addrs_last12 = 0) => 2,
                               (attr_addrs_last36 < 6) and (attr_addrs_last12 = 0) => 3,
                               (attr_addrs_last36 < 4) and (attr_addrs_last12 = 1) => 3,
                               (attr_addrs_last36 < 8) and (attr_addrs_last12 < 2) => 4,
                               (attr_addrs_last36 < 6) and (attr_addrs_last12 < 4) => 4,
                                                                                      5);

seg2_addr_stability_combox :=  map(((integer)addr_stability = 6) and (seg2_attr_addrs_combox < 4)        => 8,
                                   (addr_stability in ['2', '3', '5']) and (seg2_attr_addrs_combox = 0)  => 7,
                                   ((integer)addr_stability = 0) and (seg2_attr_addrs_combox in [1, 2])  => 7,
                                   (addr_stability in ['4', '5']) and (seg2_attr_addrs_combox in [1, 2]) => 6,
                                   ((integer)addr_stability = 4) and (seg2_attr_addrs_combox = 0)        => 5,
                                   (addr_stability in ['2', '3']) and (seg2_attr_addrs_combox in [1, 2]) => 4,
                                   (addr_stability in ['4', '5']) and (seg2_attr_addrs_combox = 3)       => 4,
                                   ((integer)addr_stability > 2) and (seg2_attr_addrs_combox = 4)        => 3,
                                   (addr_stability in ['2', '3']) and (seg2_attr_addrs_combox = 3)       => 3,
                                   ((integer)addr_stability = 0) and (seg2_attr_addrs_combox = 0)        => 3,
                                   ((integer)addr_stability = 1) and (seg2_attr_addrs_combox = 3)        => 1,
                                   seg2_attr_addrs_combox = 5                                            => 0,
                                                                                                            2);

seg2_addr_stability_combox_m2 :=  map(seg2_addr_stability_combox = 0 => 0.2358078603,
                                      seg2_addr_stability_combox = 1 => 0.2009373169,
                                      seg2_addr_stability_combox = 2 => 0.1881188119,
                                      seg2_addr_stability_combox = 3 => 0.1481850818,
                                      seg2_addr_stability_combox = 4 => 0.1386215865,
                                      seg2_addr_stability_combox = 5 => 0.1281568036,
                                      seg2_addr_stability_combox = 6 => 0.1220346715,
                                      seg2_addr_stability_combox = 7 => 0.1141106644,
                                                                        0.0865184536);

adls_per_addr_c6_5 := min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 5);

seg2_adls_per_addr_combo :=  map((adls_per_addr = 4) and (adls_per_addr_c6_5 = 0)                            => 0,
                                 (adls_per_addr in [5, 6]) and (adls_per_addr_c6_5 = 0)                      => 1,
                                 ((1 < adls_per_addr) AND (adls_per_addr < 10)) and (adls_per_addr_c6_5 = 0) => 2,
                                 (adls_per_addr = 0) and (adls_per_addr_c6_5 = 0)                            => 4,
                                 (adls_per_addr > 9) and (adls_per_addr_c6_5 in [1, 2])                      => 4,
                                 (adls_per_addr > 7) and (adls_per_addr_c6_5 = 2)                            => 4,
                                 (adls_per_addr > 6) and (adls_per_addr_c6_5 > 2)                            => 5,
                                                                                                                3);

seg2_adls_per_addr_combo_m2 :=  map(seg2_adls_per_addr_combo = 0 => 0.1014957265,
                                    seg2_adls_per_addr_combo = 1 => 0.1066474509,
                                    seg2_adls_per_addr_combo = 2 => 0.1037760304,
                                    seg2_adls_per_addr_combo = 3 => 0.1321110812,
                                    seg2_adls_per_addr_combo = 4 => 0.160398436,
                                                                    0.2058319039);

seg2_prof_license_combo :=  map((integer)prof_license_category = 5  => 4,
                                prof_license_category in ['3', '4'] => 3,
                                (integer)prof_license_category = 1  => 0,
                                                                       1);

seg2_prof_license_combo_m2 :=  map(seg2_prof_license_combo = 0 => 0.1529209622,
                                   seg2_prof_license_combo = 1 => 0.1296142335,
                                   seg2_prof_license_combo = 3 => 0.1067761807,
                                                                  0.0434782609);

                               // not(missing(ams_college_code)) and (ams_college_tier in ['1', '2', '3']) => 2,
                               // not(missing(ams_college_code))                                           => 1,
seg2_ams_college_combo :=  map(((integer)ams_college_code = 4) and (ams_college_tier in ['1', '2'])     => 3,
                               (integer)ams_college_code = 4                                            => 2,
                               not(trim(ams_college_code)='') and (ams_college_tier in ['1', '2', '3']) => 2,
                               not(trim(ams_college_code)='')                                           => 1,
                                                                                                           0);

seg2_ams_college_combo_m2 :=  map(seg2_ams_college_combo = 0 => 0.1326922659,
                                  seg2_ams_college_combo = 1 => 0.1149425287,
                                  seg2_ams_college_combo = 2 => 0.072265625,
                                                                0.0684210526);

curr_owner_lvl :=  map(add1_applicant_owned => 'APP',
                       add1_family_owned    => 'FAM',
                       add1_occupant_owned  => 'OCC',
                                               'ELS');

prev_owner_lvl :=  map(add2_applicant_owned => 'APP',
                       add2_family_owned    => 'FAM',
                       add2_occupant_owned  => 'OCC',
                                               'ELS');

seg2_curr_prev_owner_combo :=  map((curr_owner_lvl = 'APP') and (prev_owner_lvl = 'APP')           => 6,
                                   (curr_owner_lvl = 'APP') and (prev_owner_lvl in ['ELS', 'OCC']) => 5,
                                   (curr_owner_lvl = 'APP') and (prev_owner_lvl = 'FAM')           => 4,
                                   (curr_owner_lvl = 'OCC') and (prev_owner_lvl = 'ELS')           => 3,
                                   curr_owner_lvl = 'FAM'                                          => 3,
                                   (curr_owner_lvl = 'ELS') and (prev_owner_lvl = 'ELS')           => 2,
                                   (curr_owner_lvl = 'ELS') and (prev_owner_lvl in ['APP', 'FAM']) => 1,
                                   (curr_owner_lvl = 'OCC') and (prev_owner_lvl = 'FAM')           => 1,
                                                                                                      0);

seg2_curr_prev_owner_combo_m2 :=  map(seg2_curr_prev_owner_combo = 0 => 0.1673764906,
                                      seg2_curr_prev_owner_combo = 1 => 0.1634230872,
                                      seg2_curr_prev_owner_combo = 2 => 0.1426207809,
                                      seg2_curr_prev_owner_combo = 3 => 0.1465080414,
                                      seg2_curr_prev_owner_combo = 4 => 0.1185691318,
                                      seg2_curr_prev_owner_combo = 5 => 0.1150933672,
                                                                        0.1175418994);

seg2_vo_addrs_per_adl_lvl :=  if(vo_addrs_per_adl = 0, 3, (min(if(vo_addrs_per_adl = NULL, -NULL, vo_addrs_per_adl), 4) - 1));

seg2_vo_addrs_per_adl_lvl_m2 :=  map(seg2_vo_addrs_per_adl_lvl = 0 => 0.1075694625,
                                     seg2_vo_addrs_per_adl_lvl = 1 => 0.1071494211,
                                     seg2_vo_addrs_per_adl_lvl = 2 => 0.1176999102,
                                                                      0.1449326345);

seg2_age_lvl_b1 := map((integer)input_dob_match_level = 0                               => 0,
                       (integer)input_dob_match_level != 8                              => 1,
                       (55 < (integer)input_dob_age) AND ((integer)input_dob_age <= 65) => 5,
                       (45 < (integer)input_dob_age) AND ((integer)input_dob_age <= 55) => 4,
                       (35 < (integer)input_dob_age) AND ((integer)input_dob_age <= 45) => 3,
                                                                                           2);

seg2_age_lvl := if(dobpop, seg2_age_lvl_b1, -1);

seg2_age_lvl_m2 :=  map(seg2_age_lvl = 0 => 0.1916521739,
                        seg2_age_lvl = 1 => 0.1525679758,
                        seg2_age_lvl = 2 => 0.1376666058,
                        seg2_age_lvl = 3 => 0.1199235944,
                        seg2_age_lvl = 4 => 0.1043057051,
                        seg2_age_lvl = 5 => 0.1026504942,
                                            .14830);

seg2_ssn_prob :=  map(((combo_ssnscore != 100) or (((integer)rc_ssnvalflag = 1) or (boolean)(integer)rc_decsflag)) => 2,
                      (integer)rc_pwssnvalflag = 5 => 1,
                                                      0);

seg2_ssn_prob_m2 :=  map(seg2_ssn_prob = 0 => 0.1205291901,
                         seg2_ssn_prob = 1 => 0.1565860878,
                                              0.1627906977);

seg2_fips_diff :=  map((fips_diff <= (integer)-200000) or (fips_diff >= (integer)500000) => 0,
                       (fips_diff <= (integer)-50000) or (fips_diff = (integer)0)        => 1,
                       (fips_diff < (integer)0) or (fips_diff > (integer)200000)         => 2,
                                                                          3);

seg2_fips_diff_m2 :=  map(seg2_fips_diff = 0 => 0.1653153153,
                          seg2_fips_diff = 1 => 0.1371247254,
                          seg2_fips_diff = 2 => 0.1227671576,
                                                0.1087744171);

seg2_attr_prop_turnover :=  map((attr_num_purchase60 in [1, 2]) and (attr_num_sold60 = 0) => 0,
                                (attr_num_purchase60 in [1, 2]) and (attr_num_sold60 = 1) => 1,
                                (attr_num_purchase60 = 0) and (attr_num_sold60 = 0)       => 2,
                                (attr_num_purchase60 = 0) and (attr_num_sold60 = 1)       => 3,
                                                                                             4);

seg2_attr_prop_turnover_m2 :=  map(seg2_attr_prop_turnover = 0 => 0.1352230058,
                                   seg2_attr_prop_turnover = 1 => 0.1275330992,
                                   seg2_attr_prop_turnover = 2 => 0.1168775568,
                                   seg2_attr_prop_turnover = 3 => 0.1564885496,
                                                                  0.1637107776);

mod1_phn_prob :=  map(phn_nonUs or (phn_highrisk or (phn_disconnected or (phn_inval or (phn_notpots and not(phn_cellpager))))) => 4,
                      (phn_notpots and (infutor_nap = 0)) or ((phn_pots and (infutor_nap in [1, 2])) or phn_business)          => 3,
                      phn_residential and (infutor_nap = 0)                                                                    => 0,
                      phn_residential                                                                                          => 2,
                                                                                                                                  1);

mod1_phn_prob_m2 :=  map(mod1_phn_prob = 0 => 0.0925398039,
                         mod1_phn_prob = 1 => 0.1263380468,
                         mod1_phn_prob = 2 => 0.1434003259,
                         mod1_phn_prob = 3 => 0.1700091996,
                                              0.1305998481);

seg2_veradd_s_flag := (nas_summary in [3, 5, 6, 8, 10, 11, 12]);

seg2_avg_prop_assessed_val :=  if(property_owned_assessed_count > 0, min(if(max((property_owned_assessed_total / property_owned_assessed_count), (real)25000) = NULL, -NULL, max((property_owned_assessed_total / property_owned_assessed_count), (real)25000)), 1000000), 25000);

seg2_avg_prop_assessed_val_rt := sqrt(seg2_avg_prop_assessed_val);

seg2_low_issue_dob_diff :=  if(low_issue_dob_diff > 18, (0 - min(low_issue_dob_diff, 50) + 51), (low_issue_dob_diff + 33));

mod1_derog_ratio2_m2 :=  map(mod1_derog_ratio2 = 1 => 0.1926605505,
                             mod1_derog_ratio2 = 2 => 0.169984285,
                             mod1_derog_ratio2 = 3 => 0.1544862518,
                             mod1_derog_ratio2 = 4 => 0.1257114266,
                             mod1_derog_ratio2 = 5 => 0.1104048177,
                                                      0.1050020115);

SANT_LOG_SEG2 := -9.06430621 +
    (seg2_phn_prob_combox_m2 * 2.4128304401) +
    (seg2_nap_level_combox_m2 * 4.467718473) +
    (seg2_addr_stability_combox_m2 * 5.300467386) +
    (seg2_adls_per_addr_combo_m2 * 3.3594998778) +
    (seg2_prof_license_combo_m2 * 7.8594185426) +
    (seg2_ams_college_combo_m2 * 9.1022610286) +
    (seg2_curr_prev_owner_combo_m2 * 2.2005663485) +
    (seg2_vo_addrs_per_adl_lvl_m2 * 2.5887424437) +
    (seg2_age_lvl_m2 * 2.5165149325) +
    (seg2_ssn_prob_m2 * 4.191505214) +
    (seg2_fips_diff_m2 * 3.5101343822) +
    (seg2_attr_prop_turnover_m2 * 6.2526177976) +
    (mod1_phn_prob_m2 * 2.3204846662) +
    ((integer)seg2_veradd_s_flag * -0.152850497) +
    (seg2_avg_prop_assessed_val_rt * -0.000279205) +
    (seg2_low_issue_dob_diff * -0.006890555) +
    ((integer)mod1_ADJ_loan * 0.1993479252) +
    ((integer)mod1_gong_name_hi_counts * 0.3145204933) +
    (mod1_dist_a1toa2 * -0.000173348) +
    (mod1_derog_ratio2_m2 * 2.5194426315);

seg3_nap_combox :=  map((nap_lvl = 12) and (infutor_lvl = 0) => 8,
                        (nap_lvl = 3) and (infutor_lvl = 0)  => 7,
                        (nap_lvl = 2) and (infutor_lvl = 2)  => 6,
                        (nap_lvl = 2) and (infutor_lvl = 1)  => 4,
                        (nap_lvl = 12) and (infutor_lvl = 2) => 3,
                        (nap_lvl = 3) and (infutor_lvl = 2)  => 2,
                        (nap_lvl = 0) and (infutor_lvl < 2)  => 2,
                        (nap_lvl = 1) and (infutor_lvl = 0)  => 1,
                        (nap_lvl = 3) and (infutor_lvl = 1)  => 0,
                        (nap_lvl = 1) and (infutor_lvl > 0)  => 0,
                                                                5);

seg3_nap_combox_m3 :=  map(seg3_nap_combox = 0 => 0.2417177914,
                           seg3_nap_combox = 1 => 0.1893129771,
                           seg3_nap_combox = 2 => 0.1760392278,
                           seg3_nap_combox = 3 => 0.1623699683,
                           seg3_nap_combox = 4 => 0.1509433962,
                           seg3_nap_combox = 5 => 0.1459536289,
                           seg3_nap_combox = 6 => 0.1318458418,
                           seg3_nap_combox = 7 => 0.1195406299,
                                                  0.0922231859);

seg3_attr_addrs_combox :=  map((attr_addrs_last36 < 2) and (attr_addrs_last12 = 0) => 0,
                               (attr_addrs_last36 = 2) and (attr_addrs_last12 = 0) => 1,
                               attr_addrs_last12 = 0                               => 2,
                               (attr_addrs_last36 > 3) and (attr_addrs_last12 > 1) => 4,
                                                                                      3);

seg3_addr_stability_combox :=  map(((integer)addr_stability = 6) and (seg3_attr_addrs_combox < 2)       => 6,
                                   ((integer)addr_stability = 5) and (seg3_attr_addrs_combox = 1)       => 6,
                                   ((integer)addr_stability = 4) and (seg3_attr_addrs_combox = 0)       => 6,
                                   ((integer)addr_stability = 4) and (seg3_attr_addrs_combox = 2)       => 6,
                                   ((integer)addr_stability = 3) and (seg3_attr_addrs_combox < 2)       => 5,
                                   ((integer)addr_stability = 4) and (seg3_attr_addrs_combox = 1)       => 5,
                                   ((integer)addr_stability = 2) and (seg3_attr_addrs_combox in [0, 1]) => 3,
                                   ((integer)addr_stability = 3) and (seg3_attr_addrs_combox = 2)       => 3,
                                   ((integer)addr_stability = 2) and (seg3_attr_addrs_combox in [2, 3]) => 2,
                                   ((integer)addr_stability = 1) and (seg3_attr_addrs_combox = 2)       => 2,
                                   ((integer)addr_stability = 0) and (seg3_attr_addrs_combox = 3)       => 2,
                                   (integer)addr_stability = 1                                          => 1,
                                   ((integer)addr_stability = 0) and (seg3_attr_addrs_combox = 0)       => 0,
                                   ((integer)addr_stability = 0) and (seg3_attr_addrs_combox = 4)       => 0,
                                                                                                           5);

seg3_addr_stability_combox_m3 :=  map(seg3_addr_stability_combox = 0 => 0.1971388695,
                                      seg3_addr_stability_combox = 1 => 0.1861768369,
                                      seg3_addr_stability_combox = 2 => 0.1727014554,
                                      seg3_addr_stability_combox = 3 => 0.1614824619,
                                      seg3_addr_stability_combox = 5 => 0.1403012517,
                                                                        0.1150406086);

seg3_ams_college_combox :=  map(ams_college_tier in ['1', '2'] => 4,
                                ams_college_tier in ['3', '4'] => 3,
                                (integer)ams_college_code = 4  => 2,
                                (integer)ams_college_code > 0  => 1,
                                                                  0);

seg3_ams_college_combox_m3 :=  map(seg3_ams_college_combox = 0 => 0.1607707095,
                                   seg3_ams_college_combox = 1 => 0.1184798808,
                                   seg3_ams_college_combox = 2 => 0.0970042796,
                                   seg3_ams_college_combox = 3 => 0.0913801225,
                                                                  0.0562770563);

seg3_adls_per_addr_combox :=  map((adls_per_addr = 4) and (adls_per_addr_c6 = 0)                            => 0,
                                  ((2 < adls_per_addr) AND (adls_per_addr < 10)) and (adls_per_addr_c6 = 0) => 1,
                                  (adls_per_addr = 2) and (adls_per_addr_c6 in [1, 2])                      => 1,
                                  (adls_per_addr = 4) and (adls_per_addr_c6 = 1)                            => 1,
                                  ((1 < adls_per_addr) AND (adls_per_addr < 25)) and (adls_per_addr_c6 = 0) => 2,
                                  adls_per_addr < 2                                                         => 4,
                                  (adls_per_addr < 45) and (adls_per_addr_c6 = 0)                           => 3,
                                  (adls_per_addr < 10) and (adls_per_addr_c6 < 3)                           => 3,
                                  adls_per_addr < 4                                                         => 3,
                                  (adls_per_addr < 30) and (adls_per_addr_c6 < 3)                           => 5,
                                  (adls_per_addr < 35) and (adls_per_addr_c6 = 1)                           => 5,
                                                                                                               6);

seg3_adls_per_addr_combox_m3 :=  map(seg3_adls_per_addr_combox = 0 => 0.1105263158,
                                     seg3_adls_per_addr_combox = 1 => 0.1312129503,
                                     seg3_adls_per_addr_combox = 2 => 0.1395514418,
                                     seg3_adls_per_addr_combox = 3 => 0.1545811295,
                                     seg3_adls_per_addr_combox = 4 => 0.1659864813,
                                     seg3_adls_per_addr_combox = 5 => 0.1718359547,
                                                                      0.2074159907);

seg3_curr_prev_owner_combox :=  map(prev_owner_lvl = 'APP'                                 => 0,
                                    (curr_owner_lvl = 'OCC') and (prev_owner_lvl = 'ELS')  => 3,
                                    (curr_owner_lvl = 'ELS') and (prev_owner_lvl != 'OCC') => 2,
                                                                                              1);

seg3_curr_prev_owner_combox_m3 :=  map(seg3_curr_prev_owner_combox = 0 => 0.2025316456,
                                       seg3_curr_prev_owner_combox = 1 => 0.1656993072,
                                       seg3_curr_prev_owner_combox = 2 => 0.152879902,
                                                                          0.1458691417);

seg3_ssns_per_addr_c6X := min(if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6), 4);

seg3_ssns_per_addr_c6x_m3 :=  map(seg3_ssns_per_addr_c6X = 0 => 0.1485854438,
                                  seg3_ssns_per_addr_c6X = 1 => 0.1604819277,
                                  seg3_ssns_per_addr_c6X = 2 => 0.1756525982,
                                  seg3_ssns_per_addr_c6X = 3 => 0.1943641618,
                                                                0.2218091698);

seg3_nonderog_combox :=  map((attr_num_nonderogs12 > 1) and (attr_num_nonderogs36 > 2) => 3,
                             attr_num_nonderogs36 > 1                                  => 2,
                             attr_num_nonderogs12 > 0                                  => 1,
                                                                                          0);

seg3_nonderog_combox2 :=  map((seg3_nonderog_combox = 3) and (attr_num_nonderogs > 4) => 6,
                              (seg3_nonderog_combox = 2) and (attr_num_nonderogs > 4) => 5,
                              (seg3_nonderog_combox = 3) and (attr_num_nonderogs = 4) => 5,
                              (seg3_nonderog_combox = 1) and (attr_num_nonderogs = 3) => 5,
                              (seg3_nonderog_combox = 2) and (attr_num_nonderogs = 4) => 4,
                              (seg3_nonderog_combox = 3) and (attr_num_nonderogs = 3) => 4,
                              (seg3_nonderog_combox = 1) and (attr_num_nonderogs > 3) => 3,
                              (seg3_nonderog_combox = 2) and (attr_num_nonderogs = 3) => 3,
                              (seg3_nonderog_combox = 1) and (attr_num_nonderogs = 2) => 2,
                              (seg3_nonderog_combox = 2) and (attr_num_nonderogs = 2) => 1,
                                                                                         0);

seg3_nonderog_combox2_m3 :=  map(seg3_nonderog_combox2 = 0 => 0.1771095509,
                                 seg3_nonderog_combox2 = 1 => 0.1625333465,
                                 seg3_nonderog_combox2 = 2 => 0.1564771976,
                                 seg3_nonderog_combox2 = 3 => 0.1411219434,
                                 seg3_nonderog_combox2 = 4 => 0.1363887355,
                                 seg3_nonderog_combox2 = 5 => 0.1243274404,
                                                              0.1161853593);

seg3_low_issue_dob_diffX := min(if(max((real)abs((10 - low_issue_dob_diff)), .01) = NULL, -NULL, max((real)abs((10 - low_issue_dob_diff)), .01)), 40);

seg3_prof_license_combo :=  map((integer)prof_license_category = 5  => 4,
                                prof_license_category in ['3', '4'] => 3,
                                (integer)prof_license_category = 1  => 0,
                                                                       1);

seg3_prof_license_combo_m3 :=  map(seg3_prof_license_combo = 0 => 0.1675257732,
                                   seg3_prof_license_combo = 1 => 0.1559928145,
                                   seg3_prof_license_combo = 3 => 0.115942029,
                                                                  0.0747663551);

// seg3_gong_first_seen_combo :=  map(missing(mos_since_gong_first_seen) => 36,
seg3_gong_first_seen_combo :=  map(mos_since_gong_first_seen<0 => 36,
                                   mos_since_gong_first_seen = 0      => 48,
                                                                         min(if(max(mos_since_gong_first_seen, 1) = NULL, -NULL, max(mos_since_gong_first_seen, 1)), 500));

seg3_gong_first_seen_combo_lg := ln(seg3_gong_first_seen_combo);

seg3_age_lvl_b1 := map((integer)input_dob_match_level = 0                               => 0,
                       (integer)input_dob_match_level != 8                              => 1,
                       (55 < (integer)input_dob_age) AND ((integer)input_dob_age <= 65) => 5,
                       (45 < (integer)input_dob_age) AND ((integer)input_dob_age <= 55) => 4,
                       (35 < (integer)input_dob_age) AND ((integer)input_dob_age <= 45) => 3,
                                                                                           2);

seg3_age_lvl := if(dobpop, seg3_age_lvl_b1, -1);

seg3_age_lvl_m3 :=  map(seg3_age_lvl = 0 => 0.1803656729,
                        seg3_age_lvl = 1 => 0.1785842616,
                        seg3_age_lvl = 2 => 0.149758685,
                        seg3_age_lvl = 3 => 0.1496645848,
                        seg3_age_lvl = 4 => 0.1396945255,
                        seg3_age_lvl = 5 => 0.1448223156,
                                            .14830);

seg3_fips_diff :=  map((fips_diff <= -200000) or (fips_diff >= 500000) => 0,
                       (fips_diff <= -50000) or (fips_diff = 0)        => 1,
                       (fips_diff < 0) or (fips_diff > 200000)         => 2,
                                                                          3);

seg3_fips_diff_m3 :=  map(seg3_fips_diff = 0 => 0.170418698,
                          seg3_fips_diff = 1 => 0.1517321536,
                          seg3_fips_diff = 2 => 0.1469909834,
                                                0.1371629543);

mod1_phn_prob_m3 :=  map(mod1_phn_prob = 0 => 0.1186100549,
                         mod1_phn_prob = 1 => 0.1483434669,
                         mod1_phn_prob = 2 => 0.1652054324,
                         mod1_phn_prob = 3 => 0.180928937,
                                              0.1570717839);

mod1_addr_prob_lvl_m3 :=  map(mod1_addr_prob_lvl = 0 => 0.1497706258,
                              mod1_addr_prob_lvl = 1 => 0.1783463815,
                              mod1_addr_prob_lvl = 2 => 0.1744548287,
                                                        0.213028169);

mod1_best_match_lvl_m3 :=  map(mod1_best_match_lvl = -1 => 0.1761102603,
                               mod1_best_match_lvl = 0  => 0.1967871486,
                               mod1_best_match_lvl = 1  => 0.1868043985,
                                                           0.1389741073);

mod1_lien_rel_lvl_m3 :=  map(mod1_lien_rel_lvl = 0 => 0.2941176471,
                             mod1_lien_rel_lvl = 1 => 0.1552943078,
                             mod1_lien_rel_lvl = 2 => 0.1206896552,
                             mod1_lien_rel_lvl = 3 =>	0.2,
																											0.14830);

seg3_avg_prop_assessed_val :=  if(property_owned_assessed_count > 0, min(if(max((property_owned_assessed_total / property_owned_assessed_count), (real)25000) = NULL, -NULL, max((property_owned_assessed_total / property_owned_assessed_count), (real)25000)), 1000000), 25000);

seg3_avg_prop_assessed_val_lg := ln(seg3_avg_prop_assessed_val);

seg3_avg_prop_assessed_val_rt := sqrt(seg3_avg_prop_assessed_val);

seg3_avg_prop_sold_val :=  if(property_sold_purchase_count > 0, max(abs((165000 - min(if(max((property_sold_purchase_total / property_sold_purchase_count), (real)1) = NULL, -NULL, max((property_sold_purchase_total / property_sold_purchase_count), (real)1)), 1000000))), 1), 1);

seg3_rec_vehx_flag := ((attr_num_watercraft60 > 0) or (attr_num_aircraft > 0));

seg3_liens_o_flag := ((liens_unrel_o_ct > 0) or (liens_rel_o_ct > 0));

SANT_LOG_SEG3 := -10.95661819 +
    (seg3_nap_combox_m3 * 4.7798315024) +
    (seg3_addr_stability_combox_m3 * 4.981236085) +
    (seg3_ams_college_combox_m3 * 7.9472745461) +
    (seg3_adls_per_addr_combox_m3 * 2.1560578522) +
    (seg3_curr_prev_owner_combox_m3 * 6.3199444736) +
    (seg3_ssns_per_addr_c6x_m3 * 3.8528860825) +
    (seg3_nonderog_combox2_m3 * 2.7047731622) +
    (seg3_low_issue_dob_diffX * 0.0117883896) +
    (seg3_prof_license_combo_m3 * 6.1720818486) +
    (seg3_gong_first_seen_combo_lg * -0.08004789) +
    (seg3_age_lvl_m3 * 2.0986017384) +
    (seg3_fips_diff_m3 * 2.9509566883) +
    (mod1_phn_prob_m3 * 2.4657246624) +
    (mod1_addr_prob_lvl_m3 * 3.0384621597) +
    (mod1_best_match_lvl_m3 * 4.415125446) +
    (mod1_lien_rel_lvl_m3 * 7.1058854548) +
    (seg3_avg_prop_sold_val * 1.0526441E-6) +
    ((integer)seg3_rec_vehx_flag * -0.336248484) +
    ((integer)seg3_liens_o_flag * 2.1791862833) +
    ((integer)mod1_gong_name_hi_counts * 0.2619501436) +
    (mod1_dist_a1toa2_rt * -0.005304456);

base := 750;

point := -40;

odds := (1 / 21);

phat :=  map((pk_segment3)[1..1] = '0' => (exp(SANT_LOG_SEG0) / (1 + exp(SANT_LOG_SEG0))),
             (pk_segment3)[1..1] = '1' => (exp(SANT_LOG_SEG1) / (1 + exp(SANT_LOG_SEG1))),
             (pk_segment3)[1..1] = '2' => (exp(SANT_LOG_SEG2) / (1 + exp(SANT_LOG_SEG2))),
                                          (exp(SANT_LOG_SEG3) / (1 + exp(SANT_LOG_SEG3))));

SANT_SEG := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));

SANT_SEGMENT_MODEL := max(501, min(900, if(SANT_SEG = NULL, -NULL, SANT_SEG)));

RVA1007_2_0 := SANT_SEGMENT_MODEL;

var01 :=  map((integer)input_dob_age <= 0  => 0,
              (integer)input_dob_age <= 18 => 18,
              (integer)input_dob_age <= 25 => 25,
              (integer)input_dob_age <= 35 => 35,
              (integer)input_dob_age <= 45 => 45,
              (integer)input_dob_age <= 55 => 55,
              (integer)input_dob_age <= 65 => 65,
                                              100);

var02 := addr_stability;

var03 := min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 5);

var04 := IF(phn_last_seen_rec, '1', '0');

var05 := IF(phn_pots, '1', '0');

var06 := infutor_lvl;

var07 := nap_lvl;

var08 := IF(seg2_veradd_s_flag, '1', '0');

var09 := min(if(adls_per_addr = NULL, -NULL, adls_per_addr), 40);

var10 := min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 5);

var11 := IF(prof_license_flag, '1', '0');

var12 := seg1_ams_college_code;

var13 := IF(yrs_since_gong_first_seen < 0, -1, yrs_since_gong_first_seen);

var14 := min(if((if ((fips_diff / 10000) >= 0, truncate((fips_diff / 10000)), roundup((fips_diff / 10000))) * 10000) = NULL, -NULL, (if ((fips_diff / 10000) >= 0, truncate((fips_diff / 10000)), roundup((fips_diff / 10000))) * 10000)), 1000000);

var15 := min(if(felony_count = NULL, -NULL, felony_count), 3);

var16 := min(if(criminal_count = NULL, -NULL, criminal_count), 5);

var17 := seg0_bk_lvl;

var18 := seg1_attr_eviction_combo;

var19 := seg0_adl_lvl;

var20 := seg0_vo_addrs_per_adl_lvl;

var21 := seg1_ssns_per_adl_combo;

var22 := mod1_ssns_per_addr_lvl;

var23 := seg2_ssn_prob;

var24 := IF(mod1_gong_name_hi_counts, '1', '0');

var25 := max(min(if(low_issue_dob_diff = NULL, -NULL, low_issue_dob_diff), 30), 0);

var26 := min(if(liens_unrel_sc_ct = NULL, -NULL, liens_unrel_sc_ct), 5);

var27 := min(if(liens_unrel_cj_ct = NULL, -NULL, liens_unrel_cj_ct), 5);

var28 := min(if(liens_unrel_ot_ct = NULL, -NULL, liens_unrel_ot_ct), 5);

var29 := min(if(liens_unrel_lt_ct = NULL, -NULL, liens_unrel_lt_ct), 5);

var30 := mod1_best_match_lvl;

var31 := min(if(attr_num_purchase60 = NULL, -NULL, attr_num_purchase60), 5);

var32 := min(if(attr_num_sold60 = NULL, -NULL, attr_num_sold60), 5);

var33 := IF(mod1_ADJ_loan, '1', '0');

var34 := truncate(ln(mod1_dist_a1toa2));

var35 := IF(seg0_rec_vehx_flag, '1', '0');

var36 := mod1_derog_ratio;

var37 := (if ((seg2_avg_prop_assessed_val / 10000) >= 0, truncate((seg2_avg_prop_assessed_val / 10000)), roundup((seg2_avg_prop_assessed_val / 10000))) * 10000);

var38 := mod1_lien_rel_lvl;

var39 := mod1_addr_prob_lvl;

var40 := (if ((seg3_avg_prop_sold_val / 10000) >= 0, truncate((seg3_avg_prop_sold_val / 10000)), roundup((seg3_avg_prop_sold_val / 10000))) * 10000);

var41 := mod1_property_lvl;

var42 := seg1_prop_sale_history;

var43 := (if ((seg1_add1_first_seen_mos / 12) >= 0, truncate((seg1_add1_first_seen_mos / 12)), roundup((seg1_add1_first_seen_mos / 12))) * 12);

temp_ivars := dataset( [
			{var01,                        	 'AutoRVA10072_IV01', '-1', [] },
			{var02,                        	 'AutoRVA10072_IV02', '-1', [] },
			{var03,                     	   'AutoRVA10072_IV03', '-1', [] },
			{var04,          								 'AutoRVA10072_IV04', '-1', [] },
			{var05,                  				 'AutoRVA10072_IV05', '-1', [] },
			{var06,               					 'AutoRVA10072_IV06', '-1', [] },
			{var07,                					 'AutoRVA10072_IV07', '-1', [] },
			{var08,         								 'AutoRVA10072_IV08', '-1', [] },
			{var09,                 				 'AutoRVA10072_IV09', '-1', [] },
			{var10,          								 'AutoRVA10072_IV10', '-1', [] },
			{var11,   											 'AutoRVA10072_IV11', '-1', [] },
			{var12,                        	 'AutoRVA10072_IV12', '-1', [] },
			{var13,              						 'AutoRVA10072_IV13', '-1', [] },
			{var14,  												 'AutoRVA10072_IV14', '-1', [] },
			{var15,                 				 'AutoRVA10072_IV15', '-1', [] },
			{var16,                    			 'AutoRVA10072_IV16', '-1', [] },
			{var17,                   			 'AutoRVA10072_IV17', '-1', [] },
			{var18,                     		 'AutoRVA10072_IV18', '-1', [] },
			{var19,                        	 'AutoRVA10072_IV19', '-1', [] },
			{var20,                        	 'AutoRVA10072_IV20', '-1', [] },
			{var21,                        	 'AutoRVA10072_IV21', '-1', [] },
			{var22,                        	 'AutoRVA10072_IV22', '-1', [] },
			{var23,                        	 'AutoRVA10072_IV23', '-1', [] },
			{var24,                        	 'AutoRVA10072_IV24', '-1', [] },
			{var25,                        	 'AutoRVA10072_IV25', '-1', [] },
			{var26,                       	 'AutoRVA10072_IV26', '-1', [] },
			{var27,                    		   'AutoRVA10072_IV27', '-1', [] },
			{var28,               					 'AutoRVA10072_IV28', '-1', [] },
			{var29,                        	 'AutoRVA10072_IV29', '-1', [] },
			{var30,                     		 'AutoRVA10072_IV30', '-1', [] },
			{var31,                     		 'AutoRVA10072_IV31', '-1', [] },
			{var32,                					 'AutoRVA10072_IV32', '-1', [] },
			{var33,                        	 'AutoRVA10072_IV33', '-1', [] },
			{var34,                					 'AutoRVA10072_IV34', '-1', [] },
			{var35,                  				 'AutoRVA10072_IV35', '-1', [] },
			{var36,                        	 'AutoRVA10072_IV36', '-1', [] },
			{var37,                        	 'AutoRVA10072_IV37', '-1', [] },
			{var38,                        	 'AutoRVA10072_IV38', '-1', [] },
			{var39,                  				 'AutoRVA10072_IV39', '-1', [] },
			{var40,                        	 'AutoRVA10072_IV40', '-1', [] },
			{var41,                        	 'AutoRVA10072_IV41', '-1', [] },
			{var42,                        	 'AutoRVA10072_IV42', '-1', [] },
			{var43,                					 'AutoRVA10072_IV43', '-1', [] }
			], Models.Layout_Score
);


// /* ***********************************************************
	// *                   Reason Codes                           *
	// ************************************************************ */
riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

boolean PreScreenOptOut := FALSE;
temp_ri := map(
	riTemp[1].hri <> '00' => riTemp,
	RiskWise.rv3autoReasonCodes(le, 4, inCalif, PreScreenOptOut)
);

temp_score := map
(
	riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
	le.rhode_island_insufficient_verification or 
  riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid)
  => '222',
	temp_ri[1].hri='35' => '000',
	intformat(rva1007_2_0,3,1)
);


#if(RVA_DEBUG)
	self.seq := seq;
	self.adl_category := adl_category;
	self.out_addr_type := out_addr_type;
	self.in_dob := in_dob;
	self.nas_summary := nas_summary;
	self.nap_summary := nap_summary;
	self.did_count := did_count;
	self.rc_hriskphoneflag := rc_hriskphoneflag;
	self.rc_hphonetypeflag := rc_hphonetypeflag;
	self.rc_phonevalflag := rc_phonevalflag;
	self.rc_hphonevalflag := rc_hphonevalflag;
	self.rc_decsflag := rc_decsflag;
	self.rc_ssnvalflag := rc_ssnvalflag;
	self.rc_pwssnvalflag := rc_pwssnvalflag;
	self.rc_ssnlowissue := (STRING)rc_ssnlowissue;
	self.rc_addrvalflag := rc_addrvalflag;
	self.rc_dwelltype := rc_dwelltype;
	self.rc_bansflag := rc_bansflag;
	self.rc_sources := rc_sources;
	self.rc_addrcommflag := rc_addrcommflag;
	self.rc_phonetype := rc_phonetype;
	self.rc_ziptypeflag := rc_ziptypeflag;
	self.rc_cityzipflag := rc_cityzipflag;
	self.combo_ssnscore := combo_ssnscore;
	self.dobpop := dobpop;
	self.add1_isbestmatch := add1_isbestmatch;
	self.add1_unit_count := add1_unit_count;
	self.add1_avm_automated_valuation := add1_avm_automated_valuation;
	self.add1_avm_med_fips := add1_avm_med_fips;
	self.add1_applicant_owned := add1_applicant_owned;
	self.add1_occupant_owned := add1_occupant_owned;
	self.add1_family_owned := add1_family_owned;
	self.add1_naprop := add1_naprop;
	self.add1_financing_type := add1_financing_type;
	self.add1_date_first_seen := add1_date_first_seen;
	self.property_owned_total := property_owned_total;
	self.property_owned_assessed_total := property_owned_assessed_total;
	self.property_owned_assessed_count := property_owned_assessed_count;
	self.property_sold_purchase_total := property_sold_purchase_total;
	self.property_sold_purchase_count := property_sold_purchase_count;
	self.prop1_sale_price := prop1_sale_price;
	self.prop1_prev_purchase_price := prop1_prev_purchase_price;
	self.prop2_sale_price := prop2_sale_price;
	self.prop2_prev_purchase_price := prop2_prev_purchase_price;
	self.dist_a1toa2 := dist_a1toa2;
	self.add2_isbestmatch := add2_isbestmatch;
	self.add2_applicant_owned := add2_applicant_owned;
	self.add2_occupant_owned := add2_occupant_owned;
	self.add2_family_owned := add2_family_owned;
	self.add3_isbestmatch := add3_isbestmatch;
	self.addrs_5yr := addrs_5yr;
	self.addrs_prison_history := addrs_prison_history;
	self.telcordia_type := telcordia_type;
	self.gong_did_first_seen := gong_did_first_seen;
	self.gong_did_last_seen := gong_did_last_seen;
	self.gong_did_first_ct := gong_did_first_ct;
	self.gong_did_last_ct := gong_did_last_ct;
	self.ssns_per_adl := ssns_per_adl;
	self.adls_per_addr := adls_per_addr;
	self.ssns_per_adl_c6 := ssns_per_adl_c6;
	self.adls_per_addr_c6 := adls_per_addr_c6;
	self.ssns_per_addr_c6 := ssns_per_addr_c6;
	self.vo_addrs_per_adl := vo_addrs_per_adl;
	self.infutor_nap := infutor_nap;
	self.impulse_count := impulse_count;
	self.impulse_last_seen := impulse_last_seen;
	self.attr_addrs_last12 := attr_addrs_last12;
	self.attr_addrs_last36 := attr_addrs_last36;
	self.attr_num_purchase60 := attr_num_purchase60;
	self.attr_num_sold60 := attr_num_sold60;
	self.attr_num_watercraft60 := attr_num_watercraft60;
	self.attr_num_aircraft := attr_num_aircraft;
	self.attr_total_number_derogs := attr_total_number_derogs;
	self.attr_eviction_count := attr_eviction_count;
	self.attr_date_last_eviction := attr_date_last_eviction;
	self.attr_eviction_count12 := attr_eviction_count12;
	self.attr_num_nonderogs := attr_num_nonderogs;
	self.attr_num_nonderogs90 := attr_num_nonderogs90;
	self.attr_num_nonderogs12 := attr_num_nonderogs12;
	self.attr_num_nonderogs36 := attr_num_nonderogs36;
	self.bankrupt := bankrupt;
	self.filing_type := filing_type;
	self.disposition := disposition;
	self.filing_count := filing_count;
	self.bk_recent_count := bk_recent_count;
	self.liens_recent_released_count := liens_recent_released_count;
	self.liens_historical_released_count := liens_historical_released_count;
	self.liens_recent_unreleased_count := liens_recent_unreleased_count;
	self.liens_historical_unreleased_count := liens_historical_unreleased_count;
	self.liens_unrel_cj_ct := liens_unrel_cj_ct;
	self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
	self.liens_rel_cj_ct := liens_rel_cj_ct;
	self.liens_unrel_lt_ct := liens_unrel_lt_ct;
	self.liens_unrel_lt_last_seen := liens_unrel_lt_last_seen;
	self.liens_unrel_o_ct := liens_unrel_o_ct;
	self.liens_rel_o_ct := liens_rel_o_ct;
	self.liens_unrel_ot_ct := liens_unrel_ot_ct;
	self.liens_unrel_ot_last_seen := liens_unrel_ot_last_seen;
	self.liens_rel_ot_ct := liens_rel_ot_ct;
	self.liens_unrel_sc_ct := liens_unrel_sc_ct;
	self.liens_unrel_sc_last_seen := liens_unrel_sc_last_seen;
	self.liens_unrel_sc_total_amount := liens_unrel_sc_total_amount;
	self.criminal_count := criminal_count;
	self.criminal_last_date := criminal_count;
	self.felony_count := felony_count;
	self.watercraft_count := watercraft_count;
	self.ams_college_code := ams_college_code;
	self.ams_college_tier := ams_college_tier;
	self.prof_license_flag := prof_license_flag;
	self.prof_license_category := prof_license_category;
	self.input_dob_age := input_dob_age;
	self.input_dob_match_level := input_dob_match_level;
	self.addr_stability := addr_stability;
	self.sysdate := sysdate;
	self.source_tot_L2 := source_tot_L2;
	self.source_tot_LI := source_tot_LI;
	self.lien_rec_unrel_flag := lien_rec_unrel_flag;
	self.lien_hist_unrel_flag := lien_hist_unrel_flag;
	self.lien_flag := lien_flag;
	self.pk_impulse_count := pk_impulse_count;
	self.pk_impulse_count_2 := pk_impulse_count_2;
	self.source_tot_BA := source_tot_BA;
	self.bk_flag := bk_flag;
	self.pk_adl_cat_deceased := pk_adl_cat_deceased;
	self.source_tot_DS := source_tot_DS;
	self.ssn_deceased := ssn_deceased;
	self.bs_own_rent := bs_own_rent;
	self.bs_attr_derog_flag := bs_attr_derog_flag;
	self.bs_attr_eviction_flag := bs_attr_eviction_flag;
	self.bs_attr_derog_flag2 := bs_attr_derog_flag2;
	self.pk_Segment := pk_Segment;
	self.pk_segment_2 := pk_segment_2;
	self.pk_impulse_count_3 := pk_impulse_count_3;
	self.pk_impulse_count_4 := pk_impulse_count_4;
	self.pk_attr_total_number_derogs := pk_attr_total_number_derogs;
	self.pk_attr_total_number_derogs_2 := pk_attr_total_number_derogs_2;
	self.pk_attr_num_nonderogs90 := pk_attr_num_nonderogs90;
	self.pk_attr_num_nonderogs90_2 := pk_attr_num_nonderogs90_2;
	self.pk_attr_num_nonderogs90_b := pk_attr_num_nonderogs90_b;
	self.pk_adl_cat_deceased_2 := pk_adl_cat_deceased_2;
	self.bs_attr_derog_flag_2 := bs_attr_derog_flag_2;
	self.bs_attr_eviction_flag_2 := bs_attr_eviction_flag_2;
	self.bs_attr_derog_flag2_2 := bs_attr_derog_flag2_2;
	self.pk_own_flag := pk_own_flag;
	self.pk_segment3 := pk_segment3;
	self._gong_did_first_seen := _gong_did_first_seen;
	self._gong_did_last_seen := _gong_did_last_seen;
	self._criminal_last_date := _criminal_last_date;
	self._attr_date_last_eviction := _attr_date_last_eviction;
	self._liens_unrel_cj_last_seen := _liens_unrel_cj_last_seen;
	self._liens_unrel_sc_last_seen := _liens_unrel_sc_last_seen;
	self._in_dob := _in_dob;
	self._rc_ssnlowissue := _rc_ssnlowissue;
	self._impulse_last_seen := _impulse_last_seen;
	self._liens_unrel_sc_last_seen_2 := _liens_unrel_sc_last_seen_2;
	self._liens_unrel_ot_last_seen := _liens_unrel_ot_last_seen;
	self._liens_unrel_lt_last_seen := _liens_unrel_lt_last_seen;
	self._liens_unrel_cj_last_seen_2 := _liens_unrel_cj_last_seen_2;
	self.add1_first_seen := add1_first_seen;
	self.yrs_since_gong_first_seen := yrs_since_gong_first_seen;
	self.mos_since_gong_first_seen := mos_since_gong_first_seen;
	self.mos_since_gong_last_seen := mos_since_gong_last_seen;
	self.mos_since_crim_last_seen := mos_since_crim_last_seen;
	self.mos_attr_date_last_eviction := mos_attr_date_last_eviction;
	self.mos_unrel_sc_last_seen := mos_unrel_sc_last_seen;
	self.mos_unrel_ot_last_seen := mos_unrel_ot_last_seen;
	self.mos_unrel_lt_last_seen := mos_unrel_lt_last_seen;
	self.mos_unrel_cj_last_seen := mos_unrel_cj_last_seen;
	self.mos_since_imp_last_seen := mos_since_imp_last_seen;
	self.mos_since_add1_first_seen := mos_since_add1_first_seen;
	self.mod1_property_lvl := mod1_property_lvl;
	self.mod1_prof_license := mod1_prof_license;
	self.mod1_dist_a1toa2 := mod1_dist_a1toa2;
	self.mod1_dist_a1toa2_rt := mod1_dist_a1toa2_rt;
	self.mod1_gong_first_seen_lvl := mod1_gong_first_seen_lvl;
	self.mod1_addrs_5yr := mod1_addrs_5yr;
	self.mod1_best_match_lvl := mod1_best_match_lvl;
	self.add_apt := add_apt;
	self.mod1_ssns_per_addr_lvl := mod1_ssns_per_addr_lvl;
	self.mod1_attr_num_nonderogs_6 := mod1_attr_num_nonderogs_6;
	self.mod1_ADJ_loan := mod1_ADJ_loan;
	self.phn_last_seen_rec := phn_last_seen_rec;
	self.phn_first_seen_rec := phn_first_seen_rec;
	self.phn_pots := phn_pots;
	self.phn_disconnected := phn_disconnected;
	self.phn_inval := phn_inval;
	self.phn_nonUs := phn_nonUs;
	self.phn_highrisk := phn_highrisk;
	self.phn_notpots := phn_notpots;
	self.phn_cellpager := phn_cellpager;
	self.phn_business := phn_business;
	self.phn_residential := phn_residential;
	self.infutor_0 := infutor_0;
	self.infutor_1 := infutor_1;
	self.contrary_phn := contrary_phn;
	self.verfst_p := verfst_p;
	self.verlst_p := verlst_p;
	self.veradd_p := veradd_p;
	self.verphn_p := verphn_p;
	self.ver_nap6 := ver_nap6;
	self.ver_phncount := ver_phncount;
	self.infutor_lvl := infutor_lvl;
	self.nap_lvl := nap_lvl;
	self.core_adl := core_adl ;
	self.single_did := single_did;
	self.low_issue_dob_diff := low_issue_dob_diff;
	self.mod1_gong_name_hi_counts := mod1_gong_name_hi_counts;
	self.mod1_derog_ratio := mod1_derog_ratio;
	self.mod1_derog_ratio2 := mod1_derog_ratio2;
	self.fips_diff := fips_diff;
	self.invalid_addr := invalid_addr;
	self.not_reg_zip := not_reg_zip;
	self._reg_zip := _reg_zip;
	self.zip_city_mismatch := zip_city_mismatch;
	self.mod1_addr_prob_lvl := mod1_addr_prob_lvl;
	self.liens_released_ct_10 := liens_released_ct_10;
	self.mod1_lien_rel_lvl := mod1_lien_rel_lvl;
	self.seg0_addr_stability_combo := seg0_addr_stability_combo;
	self.seg0_addr_stability_combo_m0 := seg0_addr_stability_combo_m0;
	self.seg0_phn_prob_combo := seg0_phn_prob_combo;
	self.seg0_phn_prob_combo_m0 := seg0_phn_prob_combo_m0;
	self.seg0_nap_lvl_combo := seg0_nap_lvl_combo;
	self.seg0_nap_lvl_combo_m0 := seg0_nap_lvl_combo_m0;
	self.seg0_adls_per_addr_combo := seg0_adls_per_addr_combo;
	self.seg0_adls_per_addr_combo_m0 := seg0_adls_per_addr_combo_m0;
	self.seg0_gong_first_seen_combo := seg0_gong_first_seen_combo;
	self.seg0_gong_first_seen_combo_rt := seg0_gong_first_seen_combo_rt;
	self.seg0_criminal_lvl := seg0_criminal_lvl;
	self.seg0_criminal_lvl_m0 := seg0_criminal_lvl_m0;
	self.seg0_bk_lvl := seg0_bk_lvl;
	self.seg0_bk_lvl_m0 := seg0_bk_lvl_m0;
	self.seg0_eviction_lvl := seg0_eviction_lvl;
	self.seg0_eviction_lvl_m0 := seg0_eviction_lvl_m0;
	self.seg0_ams_college_code := seg0_ams_college_code;
	self.seg0_ams_college_code_m0 := seg0_ams_college_code_m0;
	self.seg0_vo_addrs_per_adl_lvl := seg0_vo_addrs_per_adl_lvl;
	self.seg0_vo_addrs_per_adl_lvl_m0 := seg0_vo_addrs_per_adl_lvl_m0;
	self.seg0_age_lvl_b1 := seg0_age_lvl_b1;
	self.seg0_age_lvl := seg0_age_lvl;
	self.seg0_age_lvl_m0 := seg0_age_lvl_m0;
	self.seg0_age_lvl_2 := seg0_age_lvl_2;
	self.liens_unrel_cj_lvl := liens_unrel_cj_lvl;
	self.seg0_liens_cj_lvl := seg0_liens_cj_lvl;
	self.seg0_liens_cj_lvl_m0 := seg0_liens_cj_lvl_m0;
	self.seg0_liens_sc_lvl := seg0_liens_sc_lvl;
	self.seg0_liens_sc_lvl_m0 := seg0_liens_sc_lvl_m0;
	self.seg0_adl_lvl := seg0_adl_lvl;
	self.seg0_adl_lvl_m0 := seg0_adl_lvl_m0;
	self.seg0_fips_diff := seg0_fips_diff;
	self.seg0_fips_diff_m0 := seg0_fips_diff_m0;
	self.seg0_attr_prop_turnover := seg0_attr_prop_turnover;
	self.seg0_attr_prop_turnover_m0 := seg0_attr_prop_turnover_m0;
	self.mod1_property_lvl_m0 := mod1_property_lvl_m0;
	self.seg0_rec_vehx_flag := seg0_rec_vehx_flag;
	self.seg0_low_issue_dob_diff := seg0_low_issue_dob_diff;
	self.seg0_low_issue_dob_diff_lg := seg0_low_issue_dob_diff_lg;
	self.SANT_LOG_SEG0 := SANT_LOG_SEG0;
	self.seg1_addrs_last_combo := seg1_addrs_last_combo;
	self.seg1_addr_stability_combo := seg1_addr_stability_combo;
	self.seg1_addr_stability_combo_m1 := seg1_addr_stability_combo_m1;
	self.seg1_attr_eviction_combo := seg1_attr_eviction_combo;
	self.seg1_attr_eviction_combo_m1 := seg1_attr_eviction_combo_m1;
	self.seg1_phn_prob_combo := seg1_phn_prob_combo;
	self.seg1_phn_prob_combo_m1 := seg1_phn_prob_combo_m1;
	self.seg1_ssns_per_adl_combo := seg1_ssns_per_adl_combo;
	self.seg1_ssns_per_adl_combo_m1 := seg1_ssns_per_adl_combo_m1;
	self.seg1_nap_lvl_combo := seg1_nap_lvl_combo;
	self.seg1_nap_lvl_combo_m1 := seg1_nap_lvl_combo_m1;
	self.criminal_lvl := criminal_lvl;
	self.seg1_criminal_combo := seg1_criminal_combo;
	self.seg1_criminal_combo_2 := seg1_criminal_combo_2;
	self.seg1_criminal_combo_m1 := seg1_criminal_combo_m1;
	self.seg1_unrel_sc_combo := seg1_unrel_sc_combo;
	self.seg1_unrel_sc_combo_m1 := seg1_unrel_sc_combo_m1;
	self.seg1_unrel_ot_combo := seg1_unrel_ot_combo;
	self.seg1_unrel_ot_combo_m1 := seg1_unrel_ot_combo_m1;
	self.seg1_unrel_lt_combo := seg1_unrel_lt_combo;
	self.seg1_unrel_lt_combo_m1 := seg1_unrel_lt_combo_m1;
	self.seg1_unrel_cj_combo := seg1_unrel_cj_combo;
	self.seg1_unrel_cj_combo_m1 := seg1_unrel_cj_combo_m1;
	self.seg1_bk_lvl := seg1_bk_lvl;
	self.seg1_bk_lvl_m1 := seg1_bk_lvl_m1;
	self.prop1_sale_price_a := prop1_sale_price_a;
	self.prop2_sale_price_a := prop2_sale_price_a;
	self.prop1_sale_profit := prop1_sale_profit;
	self.prop2_sale_profit := prop2_sale_profit;
	self.seg1_prop_sale_history := seg1_prop_sale_history;
	self.seg1_prop_sale_history_m1 := seg1_prop_sale_history_m1;
	self.seg1_ams_college_code := seg1_ams_college_code;
	self.seg1_ams_college_code_m1 := seg1_ams_college_code_m1;
	self.seg1_vo_addrs_per_adl_lvl := seg1_vo_addrs_per_adl_lvl;
	self.seg1_vo_addrs_per_adl_lvl_m1 := seg1_vo_addrs_per_adl_lvl_m1;
	self.seg1_age_lvl_b1 := seg1_age_lvl_b1;
	self.seg1_age_lvl := seg1_age_lvl;
	self.seg1_age_lvl_m1 := seg1_age_lvl_m1;
	self.seg1_adl_lvl := seg1_adl_lvl;
	self.seg1_adl_lvl_m1 := seg1_adl_lvl_m1;
	self.seg1_fips_diff := seg1_fips_diff;
	self.seg1_fips_diff_m1 := seg1_fips_diff_m1;
	self.mod1_gong_first_seen_lvl_m1 := mod1_gong_first_seen_lvl_m1;
	self.mod1_addrs_5yr_m1 := mod1_addrs_5yr_m1;
	self.mod1_best_match_lvl_m1 := mod1_best_match_lvl_m1;
	self.mod1_ssns_per_addr_lvl_m1 := mod1_ssns_per_addr_lvl_m1;
	self.mod1_attr_num_nonderogs_6_m1 := mod1_attr_num_nonderogs_6_m1;
	self.seg1_add1_first_seen_mos := seg1_add1_first_seen_mos;
	self.seg1_add1_first_seen_mos_lg := seg1_add1_first_seen_mos_lg;
	self.SANT_LOG_SEG1 := SANT_LOG_SEG1;
	self.seg2_phn_prob_combox := seg2_phn_prob_combox;
	self.seg2_phn_prob_combox_m2 := seg2_phn_prob_combox_m2;
	self.seg2_nap_level_combox := seg2_nap_level_combox;
	self.seg2_nap_level_combox_m2 := seg2_nap_level_combox_m2;
	self.seg2_attr_addrs_combox := seg2_attr_addrs_combox;
	self.seg2_addr_stability_combox := seg2_addr_stability_combox;
	self.seg2_addr_stability_combox_m2 := seg2_addr_stability_combox_m2;
	self.adls_per_addr_c6_5 := adls_per_addr_c6_5;
	self.seg2_adls_per_addr_combo := seg2_adls_per_addr_combo;
	self.seg2_adls_per_addr_combo_m2 := seg2_adls_per_addr_combo_m2;
	self.seg2_prof_license_combo := seg2_prof_license_combo;
	self.seg2_prof_license_combo_m2 := seg2_prof_license_combo_m2;
	self.seg2_ams_college_combo := seg2_ams_college_combo;
	self.seg2_ams_college_combo_m2 := seg2_ams_college_combo_m2;
	self.curr_owner_lvl := curr_owner_lvl;
	self.prev_owner_lvl := prev_owner_lvl;
	self.seg2_curr_prev_owner_combo := seg2_curr_prev_owner_combo;
	self.seg2_curr_prev_owner_combo_m2 := seg2_curr_prev_owner_combo_m2;
	self.seg2_vo_addrs_per_adl_lvl := seg2_vo_addrs_per_adl_lvl;
	self.seg2_vo_addrs_per_adl_lvl_m2 := seg2_vo_addrs_per_adl_lvl_m2;
	self.seg2_age_lvl_b1 := seg2_age_lvl_b1;
	self.seg2_age_lvl := seg2_age_lvl;
	self.seg2_age_lvl_m2 := seg2_age_lvl_m2;
	self.seg2_ssn_prob := seg2_ssn_prob;
	self.seg2_ssn_prob_m2 := seg2_ssn_prob_m2;
	self.seg2_fips_diff := seg2_fips_diff;
	self.seg2_fips_diff_m2 := seg2_fips_diff_m2;
	self.seg2_attr_prop_turnover := seg2_attr_prop_turnover;
	self.seg2_attr_prop_turnover_m2 := seg2_attr_prop_turnover_m2;
	self.mod1_phn_prob := mod1_phn_prob;
	self.mod1_phn_prob_m2 := mod1_phn_prob_m2;
	self.seg2_veradd_s_flag := seg2_veradd_s_flag;
	self.seg2_avg_prop_assessed_val := seg2_avg_prop_assessed_val;
	self.seg2_avg_prop_assessed_val_rt := seg2_avg_prop_assessed_val_rt;
	self.seg2_low_issue_dob_diff := seg2_low_issue_dob_diff;
	self.mod1_derog_ratio2_m2 := mod1_derog_ratio2_m2;
	self.SANT_LOG_SEG2 := SANT_LOG_SEG2;
	self.seg3_nap_combox := seg3_nap_combox;
	self.seg3_nap_combox_m3 := seg3_nap_combox_m3;
	self.seg3_attr_addrs_combox := seg3_attr_addrs_combox;
	self.seg3_addr_stability_combox := seg3_addr_stability_combox;
	self.seg3_addr_stability_combox_m3 := seg3_addr_stability_combox_m3;
	self.seg3_ams_college_combox := seg3_ams_college_combox;
	self.seg3_ams_college_combox_m3 := seg3_ams_college_combox_m3;
	self.seg3_adls_per_addr_combox := seg3_adls_per_addr_combox;
	self.seg3_adls_per_addr_combox_m3 := seg3_adls_per_addr_combox_m3;
	self.seg3_curr_prev_owner_combox := seg3_curr_prev_owner_combox;
	self.seg3_curr_prev_owner_combox_m3 := seg3_curr_prev_owner_combox_m3;
	self.seg3_ssns_per_addr_c6X := seg3_ssns_per_addr_c6X;
	self.seg3_ssns_per_addr_c6x_m3 := seg3_ssns_per_addr_c6x_m3;
	self.seg3_nonderog_combox := seg3_nonderog_combox;
	self.seg3_nonderog_combox2 := seg3_nonderog_combox2;
	self.seg3_nonderog_combox2_m3 := seg3_nonderog_combox2_m3;
	self.seg3_low_issue_dob_diffX := seg3_low_issue_dob_diffX;
	self.seg3_prof_license_combo := seg3_prof_license_combo;
	self.seg3_prof_license_combo_m3 := seg3_prof_license_combo_m3;
	self.seg3_gong_first_seen_combo := seg3_gong_first_seen_combo;
	self.seg3_gong_first_seen_combo_lg := seg3_gong_first_seen_combo_lg;
	self.seg3_age_lvl_b1 := seg3_age_lvl_b1;
	self.seg3_age_lvl := seg3_age_lvl;
	self.seg3_age_lvl_m3 := seg3_age_lvl_m3;
	self.seg3_fips_diff := seg3_fips_diff;
	self.seg3_fips_diff_m3 := seg3_fips_diff_m3;
	self.mod1_phn_prob_m3 := mod1_phn_prob_m3;
	self.mod1_addr_prob_lvl_m3 := mod1_addr_prob_lvl_m3;
	self.mod1_best_match_lvl_m3 := mod1_best_match_lvl_m3;
	self.mod1_lien_rel_lvl_m3 := mod1_lien_rel_lvl_m3;
	self.seg3_avg_prop_assessed_val := seg3_avg_prop_assessed_val;
	self.seg3_avg_prop_assessed_val_lg := seg3_avg_prop_assessed_val_lg;
	self.seg3_avg_prop_assessed_val_rt := seg3_avg_prop_assessed_val_rt;
	self.seg3_avg_prop_sold_val := seg3_avg_prop_sold_val;
	self.seg3_rec_vehx_flag := seg3_rec_vehx_flag;
	self.seg3_liens_o_flag := seg3_liens_o_flag;
	self.SANT_LOG_SEG3 := SANT_LOG_SEG3;
	self.base := base;
	self.point := point;
	self.odds := odds;
	self.phat := phat;
	self.SANT_SEG := SANT_SEG;
	self.SANT_SEGMENT_MODEL := SANT_SEGMENT_MODEL;
	self.RVA1007_2_0 := RVA1007_2_0;
	self.var01 := var01;
	self.var02 := var02;
	self.var03 := var03;
	self.var04 := var04;
	self.var05 := var05;
	self.var06 := var06;
	self.var07 := var07;
	self.var08 := var08;
	self.var09 := var09;
	self.var10 := var10;
	self.var11 := var11;
	self.var12 := var12;
	self.var13 := var13;
	self.var14 := var14;
	self.var15 := var15;
	self.var16 := var16;
	self.var17 := var17;
	self.var18 := var18;
	self.var19 := var19;
	self.var20 := var20;
	self.var21 := var21;
	self.var22 := var22;
	self.var23 := var23;
	self.var24 := var24;
	self.var25 := var25;
	self.var26 := var26;
	self.var27 := var27;
	self.var28 := var28;
	self.var29 := var29;
	self.var30 := var30;
	self.var31 := var31;
	self.var32 := var32;
	self.var33 := var33;
	self.var34 := var34;
	self.var35 := var35;
	self.var36 := var36;
	self.var37 := var37;
	self.var38 := var38;
	self.var39 := var39;
	self.var40 := var40;
	self.var41 := var41;
	self.var42 := var42;
	self.var43 := var43;
	self.score := temp_score;
	self := le;
	self := [];
#else
	self.seq := seq;
	self.score := temp_score;
	self.ri := temp_ri;
	self.ivars := temp_ivars;
	self := le;
	self := [];
#end

END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN model;

END;