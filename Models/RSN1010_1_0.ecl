IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, EASI, std;

EXPORT rsn1010_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, DATASET(Models.Layout_RecoverScore_Batch_Input) recoverScoreBatchIn) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;
			Models.Layout_RecoverScore;

			/* Model Input Variables */
			STRING c_robbery;
			STRING c_easiqlife;
			STRING c_born_usa;
			STRING c_many_cars;
			STRING c_span_lang;
			STRING c_civ_emp;
			BOOLEAN truedid;
			STRING adl_category;
			STRING in_state;
			STRING out_st;
			STRING out_addr_type;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING nap_status;
			UNSIGNED did_count;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_ssnvalflag;
			STRING rc_pwssnvalflag;
			UNSIGNED rc_ssnlowissue;
			UNSIGNED rc_ssnhighissue;
			STRING rc_ssnstate;
			INTEGER rc_areacodesplitdate;
			STRING rc_dwelltype;
			STRING rc_bansflag;
			STRING rc_sources;
			UNSIGNED rc_phoneaddr_addrcount;
			UNSIGNED combo_dobscore;
			UNSIGNED combo_fnamecount;
			UNSIGNED combo_lnamecount;
			UNSIGNED combo_addrcount;
			UNSIGNED pr_count;
			UNSIGNED adl_eq_first_seen;
			UNSIGNED adl_en_first_seen;
			UNSIGNED adl_tu_first_seen;
			UNSIGNED adl_dl_first_seen;
			UNSIGNED adl_pr_first_seen;
			UNSIGNED adl_v_first_seen;
			UNSIGNED adl_em_first_seen;
			UNSIGNED adl_vo_first_seen;
			UNSIGNED adl_em_only_first_seen;
			UNSIGNED adl_w_first_seen;
			STRING ssnlength;
			UNSIGNED source_count;
			INTEGER age;
			STRING util_adl_first_seen;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_unit_count;
			INTEGER add1_lres;
			STRING add1_avm_land_use;
			STRING add1_avm_recording_date;
			STRING add1_avm_assessed_value_year;
			STRING add1_avm_sales_price;
			STRING add1_avm_assessed_total_value;
			STRING add1_avm_market_total_value;
			INTEGER add1_avm_tax_assessed_valuation;
			INTEGER add1_avm_automated_valuation;
			INTEGER add1_avm_automated_valuation_2;
			INTEGER add1_avm_med_fips;
			INTEGER add1_avm_med_geo11;
			INTEGER add1_avm_med_geo12;
			INTEGER add1_source_count;
			BOOLEAN add1_occupant_owned;
			BOOLEAN add1_family_owned;
			BOOLEAN add1_family_sold;
			BOOLEAN add1_applicant_sold;
			INTEGER add1_naprop;
			INTEGER add1_purchase_amount;
			INTEGER add1_mortgage_amount;
			INTEGER add1_mortgage_date;
			STRING add1_mortgage_type;
			INTEGER add1_assessed_amount;
			INTEGER add1_date_first_seen;
			INTEGER add1_date_last_seen;
			STRING add1_land_use_code;
			STRING add1_building_area;
			STRING add1_no_of_buildings;
			STRING add1_no_of_stories;
			STRING add1_no_of_rooms;
			STRING add1_no_of_bedrooms;
			STRING add1_no_of_baths;
			STRING add1_no_of_partial_baths;
			STRING add1_garage_type_code;
			STRING add1_parking_no_of_cars;
			STRING add1_assessed_value_year;
			INTEGER property_owned_total;
			INTEGER property_owned_purchase_total;
			INTEGER property_owned_purchase_count;
			INTEGER property_owned_assessed_total;
			INTEGER property_owned_assessed_count;
			INTEGER property_sold_total;
			INTEGER property_sold_purchase_total;
			INTEGER property_sold_purchase_count;
			INTEGER property_ambig_total;
			INTEGER prop1_sale_price;
			INTEGER prop1_sale_date;
			INTEGER prop2_sale_price;
			STRING add2_addr_type;
			INTEGER add2_lres;
			INTEGER add2_avm_automated_valuation;
			INTEGER add2_naprop;
			INTEGER add2_assessed_amount;
			INTEGER add2_date_first_seen;
			BOOLEAN add2_pop;
			STRING add3_addr_type;
			INTEGER add3_naprop;
			INTEGER add3_purchase_amount;
			INTEGER add3_mortgage_amount;
			INTEGER add3_assessed_amount;
			INTEGER add3_date_first_seen;
			BOOLEAN add3_pop;
			STRING gong_did_first_seen;
			STRING gong_did_last_seen;
			INTEGER credit_first_seen;
			INTEGER credit_last_seen;
			INTEGER header_first_seen;
			INTEGER header_last_seen;
			INTEGER ssns_per_adl;
			INTEGER addrs_per_adl;
			INTEGER phones_per_adl;
			INTEGER addrs_per_ssn;
			INTEGER adls_per_addr;
			INTEGER ssns_per_adl_c6;
			INTEGER phones_per_adl_c6;
			INTEGER pl_addrs_per_adl;
			INTEGER invalid_ssns_per_adl;
			INTEGER invalid_ssns_per_adl_c6;
			INTEGER attr_num_purchase60;
			INTEGER attr_num_sold60;
			INTEGER attr_num_watercraft60;
			INTEGER attr_num_aircraft;
			INTEGER attr_total_number_derogs;
			INTEGER attr_arrests;
			INTEGER attr_num_nonderogs;
			INTEGER attr_num_nonderogs30;
			INTEGER attr_num_proflic60;
			INTEGER attr_num_proflic_exp60;
			BOOLEAN bankrupt;
			INTEGER date_last_seen;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER bk_disposed_recent_count;
			INTEGER bk_disposed_historical_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_recent_released_count;
			INTEGER liens_historical_released_count;
			INTEGER liens_unrel_sc_ct;
			INTEGER liens_rel_sc_ct;
			INTEGER criminal_count;
			INTEGER felony_count;
			INTEGER rel_within25miles_count;
			INTEGER rel_ageunder20_count;
			INTEGER current_count;
			INTEGER watercraft_count;
			INTEGER acc_atfault_count;
			INTEGER acc_atfaultda_count;
			INTEGER ams_date_first_seen;
			INTEGER ams_date_last_seen;
			STRING ams_age;
			INTEGER ams_dob;
			STRING ams_college_code;
			STRING ams_college_type;
			STRING ams_income_level_code;
			STRING ams_college_tier;
			BOOLEAN prof_license_flag;
			STRING prof_license_category;
			STRING wealth_index;
			STRING input_dob_match_level;
			INTEGER inferred_age;
			INTEGER reported_dob;
			STRING addr_stability;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			BOOLEAN source_tot_am;
			BOOLEAN source_tot_ba;
			BOOLEAN source_tot_da;
			BOOLEAN source_tot_ds;
			BOOLEAN source_tot_l2;
			BOOLEAN source_tot_li;
			BOOLEAN source_tot_p;
			BOOLEAN lien_rec_unrel_flag;
			BOOLEAN lien_hist_unrel_flag;
			BOOLEAN lien_flag;
			INTEGER add1_date_first_seen2;
			REAL years_add1_date_first_seen;
			INTEGER add2_date_first_seen2;
			REAL years_add2_date_first_seen;
			INTEGER add3_date_first_seen2;
			REAL years_add3_date_first_seen;
			INTEGER add1_avm_med;
			REAL add1_avm_to_med_ratio;
			INTEGER add1_building_area2;
			INTEGER add1_no_of_bedrooms2;
			INTEGER add1_no_of_baths2;
			INTEGER add1_no_of_partial_baths2;
			INTEGER add1_parking_no_of_cars2;
			BOOLEAN bk_flag;
			REAL add_lres_year_avg;
			INTEGER prop_owner;
			BOOLEAN prop_owned_flag;
			BOOLEAN ssn_priordob;
			BOOLEAN ssn_inval;
			BOOLEAN ssn_deceased;
			BOOLEAN ssn_prob;
			INTEGER out_st_i;
			BOOLEAN out_st2;
			BOOLEAN out_st5;
			BOOLEAN out_st6;
			BOOLEAN _add1_bestmatch_1pop;
			BOOLEAN _add1_bestmatch_12pop;
			REAL _ams_age;
			REAL _ams_age_lg;
			INTEGER _ams_income_i;
			BOOLEAN _ams_college_tier1;
			BOOLEAN _ams_college_tier2;
			BOOLEAN _ams_college_tier3;
			BOOLEAN _ams_college_tier4;
			INTEGER _curadd_avm;
			INTEGER _curadd_assess_amt;
			INTEGER _preadd_assess_amt;
			BOOLEAN _add1_avm_land_used_sf;
			REAL _curadd_assess_amt2;
			REAL _curadd_assess_amt2_log;
			REAL _preadd_assess_amt2;
			REAL _preadd_assess_amt2_log;
			INTEGER _add1_avm_sales_price;
			REAL _add1_avm_sales_price_log;
			INTEGER _add1_avm_ass_value;
			REAL _add1_avm_ass_value_log;
			INTEGER _add1_avm_med;
			REAL _add1_avm_med_log;
			REAL _curadd_avm2;
			REAL _curadd_avm2_log;
			REAL _add1_avm_to_med_ratio;
			BOOLEAN _add1_mortgage_convention;
			REAL _add1_building_area_i;
			BOOLEAN _add1_no_of_bedrooms_47;
			BOOLEAN _add1_no_of_baths_1;
			BOOLEAN _add1_no_of_baths_2;
			BOOLEAN _add1_no_of_baths_4plus;
			BOOLEAN _add1_no_of_partial_baths_1;
			BOOLEAN _add1_parking_no_of_cars_1;
			BOOLEAN _add1_parking_no_of_cars_2;
			BOOLEAN _add1_parking_no_of_cars_3plus;
			INTEGER _prop_owned_pur_tot;
			REAL _prop_owned_pur_tot_log;
			INTEGER _prop_owned_assess_tot;
			REAL _prop_owned_assess_tot_log;
			INTEGER _prop_owned_assess_cnt;
			INTEGER _prop_sold_pur_tot;
			REAL _prop_sold_pur_tot_log;
			INTEGER _attr_num_watercraft60;
			INTEGER _watercraft_count;
			INTEGER _waterccraft_sum;
			BOOLEAN _wealth_index6;
			BOOLEAN _wealth_index5;
			BOOLEAN _wealth_index4;
			BOOLEAN _wealth_index23;
			BOOLEAN _wealth_index1;
			BOOLEAN avm_pop;
			REAL _add1_building_area_i_m_c46;
			REAL mod_avm_logincome02_c45_b1_1;
			REAL mod_avm_logincome02;
			INTEGER _inferred_age3;
			BOOLEAN _prof_license_category5;
			BOOLEAN _prof_license_category4;
			BOOLEAN _prof_license_category1;
			INTEGER _attr_num_nonderogs;
			INTEGER _add1_lres;
			REAL _add_lres_year_avg;
			INTEGER _addrs_per_adl;
			INTEGER _phones_per_adl;
			INTEGER _adls_per_addr;
			BOOLEAN _ssn_issue7yr;
			INTEGER _source_count;
			REAL _ams_income_i_m;
			REAL _prop_owned_assess_cnt_m;
			REAL prop_owner_m;
			REAL _waterccraft_sum_m;
			REAL _add1_lres_m;
			REAL _add_lres_year_avg_m;
			REAL _adls_per_addr_m;
			REAL _inferred_age3_m;
			REAL logincome;
			REAL estincome_raw;
			REAL estincome_raw_c;
			REAL estincome_raw_c_srt;
			INTEGER tot_num_derog;
			REAL tot_num_derog_m;
			INTEGER bk_disposed_lvl;
			REAL bk_disposed_lvl_m;
			BOOLEAN felony_flag;
			BOOLEAN attr_arrests_f;
			REAL verx_lvl2;
			REAL verx_lvl2_m;
			INTEGER prof_lic_lvl;
			REAL prof_lic_lvl_m;
			INTEGER college_lvl;
			REAL college_lvl_m;
			INTEGER ssns_per_adl_5_v2;
			REAL ssns_per_adl_5_v2_m;
			INTEGER liens_sc_lvl;
			REAL liens_sc_lvl_m;
			INTEGER liens_released_lvl;
			INTEGER liens_unreleased_lvl;
			INTEGER liens_lvl;
			REAL liens_lvl_v2;
			REAL liens_lvl_v2_m;
			REAL addr_stability_m;
			INTEGER tot_prop_lvl;
			REAL tot_prop_lvl_m;
			BOOLEAN current_own_vehicle_f;
			BOOLEAN any_atfault_accident;
			INTEGER rel_within25_lvl;
			REAL rel_within25_lvl_m;
			INTEGER rel_ageunder20_lvl;
			REAL rel_ageunder20_lvl_m;
			INTEGER avm_value_increase;
			REAL avm_value_increase_m;
			INTEGER starting_equity_tax;
			INTEGER starting_tax_equity_lvl;
			REAL starting_tax_equity_lvl_m;
			INTEGER avm_index_geo12;
			INTEGER avm_index_geo12_lvl;
			REAL avm_index_geo12_lvl_m;
			INTEGER add1_mortgage_date2;
			REAL years_add1_mortgage_date;
			INTEGER yrs_since_mtg;
			REAL yrs_since_mtg_m;
			INTEGER c_robbery_c;
			REAL c_robbery_srt;
			INTEGER c_easiqlife_lvl;
			REAL c_easiqlife_lvl_m;
			INTEGER c_born_usa_c;
			REAL c_born_usa_srt;
			INTEGER c_many_cars_c;
			INTEGER c_span_lang_c;
			REAL c_civ_emp_c;
			REAL rsn1010_log;
			INTEGER base;
			REAL odds;
			INTEGER point;
			REAL phat;
			INTEGER rsn1010_1_0_2;
			INTEGER rsn1010_1_0_1;
			BOOLEAN scored_222s;
			INTEGER rsn1010_1_0;
		END;
		Layout_Debug doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#else
		Layout_RecoverScore doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	c_robbery                        := ri.robbery;
	c_easiqlife                      := ri.easiqlife;
	c_born_usa                       := ri.born_usa;
	c_many_cars                      := ri.many_cars;
	c_span_lang                      := ri.span_lang;
	c_civ_emp                        := ri.civ_emp;
	truedid                          := le.truedid;
	adl_category                     := le.adlcategory;
	in_state                         := le.shell_input.in_state;
	out_st                           := le.shell_input.st;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	did_count                        := le.iid.didcount;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnlowissue                   := (UNSIGNED)le.iid.socllowissue;
	rc_ssnhighissue                  := (UNSIGNED)le.iid.soclhighissue;
	rc_ssnstate                      := le.iid.soclstate;
	rc_areacodesplitdate             := (UNSIGNED)le.iid.areacodesplitdate;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_sources                       := le.iid.sources;
	rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_fnamecount                 := le.iid.combo_firstcount;
	combo_lnamecount                 := le.iid.combo_lastcount;
	combo_addrcount                  := le.iid.combo_addrcount;
	pr_count                         := le.source_verification.pr_count;
	adl_eq_first_seen                := le.source_verification.adl_eqfs_first_seen;
	adl_en_first_seen                := le.source_verification.adl_en_first_seen;
	adl_tu_first_seen                := le.source_verification.adl_tu_first_seen;
	adl_dl_first_seen                := le.source_verification.adl_dl_first_seen;
	adl_pr_first_seen                := le.source_verification.adl_pr_first_seen;
	adl_v_first_seen                 := le.source_verification.adl_v_first_seen;
	adl_em_first_seen                := le.source_verification.adl_em_first_seen;
	adl_vo_first_seen                := le.source_verification.adl_vo_first_seen;
	adl_em_only_first_seen           := le.source_verification.adl_em_only_first_seen;
	adl_w_first_seen                 := le.source_verification.adl_w_first_seen;
	ssnlength                        := le.input_validation.ssn_length;
	source_count                     := le.name_verification.source_count;
	age                              := le.name_verification.age;
	util_adl_first_seen              := le.utility.utili_adl_earliest_dt_first_seen;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_unit_count                  := le.address_verification.input_address_information.unit_count;
	add1_lres                        := le.lres;
	add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
	add1_avm_recording_date          := le.avm.input_address_information.avm_recording_date;
	add1_avm_assessed_value_year     := le.avm.input_address_information.avm_assessed_value_year;
	add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
	add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
	add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
	add1_avm_tax_assessed_valuation  := le.avm.input_address_information.avm_tax_assessment_valuation;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_family_sold                 := le.address_verification.input_address_information.family_sold;
	add1_applicant_sold              := le.address_verification.input_address_information.applicant_sold;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
	add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	add1_date_last_seen              := le.address_verification.input_address_information.date_last_seen;
	add1_land_use_code               := le.address_verification.input_address_information.standardized_land_use_code;
	add1_building_area               := (STRING)le.address_verification.input_address_information.building_area;
	add1_no_of_buildings             := (STRING)le.address_verification.input_address_information.no_of_buildings;
	add1_no_of_stories               := (STRING)le.address_verification.input_address_information.no_of_stories;
	add1_no_of_rooms                 := (STRING)le.address_verification.input_address_information.no_of_rooms;
	add1_no_of_bedrooms              := (STRING)le.address_verification.input_address_information.no_of_bedrooms;
	add1_no_of_baths                 := (STRING)le.address_verification.input_address_information.no_of_baths;
	add1_no_of_partial_baths         := (STRING)le.address_verification.input_address_information.no_of_partial_baths;
	add1_garage_type_code            := le.address_verification.input_address_information.garage_type_code;
	add1_parking_no_of_cars          := (STRING)le.address_verification.input_address_information.parking_no_of_cars;
	add1_assessed_value_year         := le.address_verification.input_address_information.assessed_value_year;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
	property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
	property_sold_purchase_count     := le.address_verification.sold.property_owned_purchase_count;
	property_ambig_total             := le.address_verification.ambiguous.property_total;
	prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
	prop1_sale_date                  := le.address_verification.recent_property_sales.sale_date1;
	prop2_sale_price                 := le.address_verification.recent_property_sales.sale_price2;
	add2_addr_type                   := le.address_verification.addr_type2;
	add2_lres                        := le.lres2;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
	add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
	add2_pop                         := le.addrpop2;
	add3_addr_type                   := le.address_verification.addr_type3;
	add3_naprop                      := le.address_verification.address_history_2.naprop;
	add3_purchase_amount             := le.address_verification.address_history_2.purchase_amount;
	add3_mortgage_amount             := le.address_verification.address_history_2.mortgage_amount;
	add3_assessed_amount             := le.address_verification.address_history_2.assessed_amount;
	add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
	add3_pop                         := le.addrpop3;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	credit_first_seen                := le.ssn_verification.credit_first_seen;
	credit_last_seen                 := le.ssn_verification.credit_last_seen;
	header_first_seen                := le.ssn_verification.header_first_seen;
	header_last_seen                 := le.ssn_verification.header_last_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	phones_per_adl                   := le.velocity_counters.phones_per_adl;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
	pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	attr_num_sold60                  := le.other_address_info.num_sold60;
	attr_num_watercraft60            := le.watercraft.watercraft_count60;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests                     := le.bjl.arrests_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_nonderogs30             := le.source_verification.num_nonderogs30;
	attr_num_proflic60               := le.professional_license.proflic_count60;
	attr_num_proflic_exp60           := le.professional_license.expire_count60;
	bankrupt                         := le.bjl.bankrupt;
	date_last_seen                   := le.bjl.date_last_seen;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := le.BJL.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.BJL.liens_historical_unreleased_count;
	liens_recent_released_count      := le.BJL.liens_recent_released_count;
	liens_historical_released_count  := le.BJL.liens_historical_released_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_ageunder20_count             := le.relatives.relative_ageunder20_count;
	current_count                    := le.vehicles.current_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	acc_atfault_count                := le.accident_data.atfault.num_accidents;
	acc_atfaultda_count              := le.accident_data.atfaultda.num_accidents;
	ams_date_first_seen              := (UNSIGNED)le.student.date_first_seen;
	ams_date_last_seen               := (UNSIGNED)le.student.date_last_seen;
	ams_age                          := le.student.age;
	ams_dob                          := (UNSIGNED)le.student.dob_formatted;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_college_tier                 := le.student.college_tier;
	prof_license_flag                := le.professional_license.professional_license_flag;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	addr_stability                   := le.mobility_indicator;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
	 NULL := -999999999;

	sysdate := map(
	    trim((string)archive_date, LEFT, RIGHT) = '999999'  => Common.SAS_Date((STRING)if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
	    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
	                                                           NULL);
	
	Common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_am, 'bool');
	
	Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_ba, 'bool');
	
	Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_da, 'bool');
	
	Common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_ds, 'bool');
	
	Common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_l2, 'bool');
	
	Common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_li, 'bool');
	
	Common.findw(rc_sources, 'P', ' ,', 'I', source_tot_p, 'bool');
	
	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;
	
	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;
	
	lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;
	
	add1_date_first_seen2 := Common.SAS_Date((STRING)add1_date_first_seen);
	
	years_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, (sysdate - add1_date_first_seen2) / 365.25);
	
	add2_date_first_seen2 := Common.SAS_Date((STRING)add2_date_first_seen);
	
	years_add2_date_first_seen := if(min(sysdate, add2_date_first_seen2) = NULL, NULL, (sysdate - add2_date_first_seen2) / 365.25);
	
	add3_date_first_seen2 := Common.SAS_Date((STRING)add3_date_first_seen);
	
	years_add3_date_first_seen := if(min(sysdate, add3_date_first_seen2) = NULL, NULL, (sysdate - add3_date_first_seen2) / 365.25);
	
	add1_avm_med := map(
	    ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
	    ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
	                              ADD1_AVM_MED_FIPS);
	
	add1_avm_to_med_ratio := if(add1_avm_automated_valuation > 0 and add1_avm_med > 0, (REAL)add1_avm_automated_valuation / (REAL)add1_avm_med, (REAL)NULL);
	
	add1_building_area2 := if(add1_building_area = (string)0, NULL, (INTEGER)add1_building_area);
	
	add1_no_of_bedrooms2 := if(add1_no_of_bedrooms = (string)0, NULL, (INTEGER)add1_no_of_bedrooms);
	
	add1_no_of_baths2 := if(add1_no_of_baths = (string)0, NULL, (INTEGER)add1_no_of_baths);
	
	add1_no_of_partial_baths2 := if(add1_no_of_partial_baths = (string)0, NULL, (INTEGER)add1_no_of_partial_baths);
	
	add1_parking_no_of_cars2 := if(add1_parking_no_of_cars = (string)0, NULL, (INTEGER)add1_parking_no_of_cars);
	
	bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;
	
	add_lres_year_avg := if(max(years_add1_date_first_seen, years_add2_date_first_seen, years_add3_date_first_seen) = NULL, NULL, (if(max(years_add1_date_first_seen, years_add2_date_first_seen, years_add3_date_first_seen) = NULL, NULL, SUM(if(years_add1_date_first_seen = NULL, 0, years_add1_date_first_seen), if(years_add2_date_first_seen = NULL, 0, years_add2_date_first_seen), if(years_add3_date_first_seen = NULL, 0, years_add3_date_first_seen)))/sum(if(years_add1_date_first_seen = NULL, 0, 1), if(years_add2_date_first_seen = NULL, 0, 1), if(years_add3_date_first_seen = NULL, 0, 1))));
	
	prop_owner := map(
	    add1_naprop = 4 or add2_naprop = 4 or add3_naprop = 4                           => 2,
	    property_owned_total > 0 or property_sold_total > 0 or property_ambig_total > 0 => 1,
	                                                                                       0);
	
	prop_owned_flag := property_owned_total > 0;
	
	ssn_priordob := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;
	
	ssn_inval := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3']);
	
	ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;
	
	ssn_prob := ssn_deceased or ssn_priordob or ssn_inval;
	
	out_st_i := map(
	    out_st = 'VI' => 1,
	    out_st = 'ID' => 1,
	    out_st = 'MT' => 1,
	    out_st = 'ND' => 1,
	    out_st = 'WV' => 1,
	    out_st = 'SD' => 1,
	    out_st = 'ME' => 1,
	    out_st = 'WY' => 1,
	    out_st = 'NE' => 2,
	    out_st = 'MS' => 2,
	    out_st = 'WI' => 2,
	    out_st = 'OR' => 2,
	    out_st = 'KY' => 2,
	    out_st = 'AR' => 2,
	    out_st = 'AL' => 2,
	    out_st = 'TN' => 2,
	    out_st = 'OH' => 3,
	    out_st = 'NY' => 3,
	    out_st = 'IA' => 3,
	    out_st = 'VT' => 3,
	    out_st = 'MI' => 3,
	    out_st = 'IN' => 3,
	    out_st = 'UT' => 3,
	    out_st = 'LA' => 3,
	    out_st = 'PR' => 3,
	    out_st = 'SC' => 3,
	    out_st = 'FL' => 3,
	    out_st = 'PA' => 4,
	    out_st = 'MN' => 4,
	    out_st = 'OK' => 4,
	    out_st = 'NV' => 4,
	    out_st = 'AK' => 4,
	    out_st = 'NM' => 4,
	    out_st = 'KS' => 4,
	    out_st = 'MO' => 4,
	    out_st = 'NC' => 4,
	    out_st = 'GA' => 4,
	    out_st = 'RI' => 4,
	    out_st = 'WA' => 4,
	    out_st = 'DE' => 4,
	    out_st = 'AZ' => 4,
	    out_st = 'CO' => 4,
	    out_st = 'AE' => 4,
	    out_st = 'CA' => 5,
	    out_st = 'IL' => 5,
	    out_st = 'HI' => 5,
	    out_st = 'NH' => 5,
	    out_st = 'TX' => 5,
	    out_st = 'MA' => 6,
	    out_st = 'VA' => 6,
	    out_st = 'AP' => 6,
	    out_st = 'MD' => 6,
	    out_st = 'CT' => 6,
	    out_st = 'NJ' => 6,
	    out_st = 'DC' => 6,
	                     3);
	
	out_st2 := out_st_i = 2;
	
	out_st5 := out_st_i = 5;
	
	out_st6 := out_st_i = 6;
	
	_add1_bestmatch_1pop := (integer)add1_isbestmatch = 1 and (integer)add2_pop = 0;
	
	_add1_bestmatch_12pop := (integer)_add1_bestmatch_1pop = 0 and (integer)add3_pop = 0;
	
	_ams_age := if(TRIM(ams_age) IN [(string)NULL, ''], 31.5, min(55, if(max(22, (integer)ams_age) = NULL, -NULL, max(22, (integer)ams_age))));
	
	_ams_age_lg := ln(_ams_age);
	
	_ams_income_i := map(
	    ams_income_level_code = 'A' => 1,
	    ams_income_level_code = 'B' => 1,
	    ams_income_level_code = 'C' => 1,
	    ams_income_level_code = 'D' => 2,
	    ams_income_level_code = 'E' => 3,
	    ams_income_level_code = 'F' => 4,
	    ams_income_level_code = 'G' => 5,
	    ams_income_level_code = 'H' => 6,
	    ams_income_level_code = 'I' => 7,
	    ams_income_level_code = 'J' => 8,
	    ams_income_level_code = 'K' => 9,
	                                   -1);
	
	_ams_college_tier1 := ams_college_tier = (string)1;
	
	_ams_college_tier2 := ams_college_tier = (string)2;
	
	_ams_college_tier3 := ams_college_tier = (string)3;
	
	_ams_college_tier4 := ams_college_tier = (string)4;
	
	_curadd_avm := if((integer)add1_isbestmatch = 1, add1_avm_automated_valuation, add2_avm_automated_valuation);
	
	_curadd_assess_amt := if((integer)add1_isbestmatch = 1, add1_assessed_amount, add1_assessed_amount);
	
	_preadd_assess_amt := if((integer)add1_isbestmatch = 1, add2_assessed_amount, add3_assessed_amount);
	
	_add1_avm_land_used_sf := add1_avm_land_use = (string)1;
	
	_curadd_assess_amt2 := if(_curadd_assess_amt <= 0, 230000, min(1000000, if(max((real)80000, _curadd_assess_amt) = NULL, -NULL, max((real)80000, _curadd_assess_amt))));
	
	_curadd_assess_amt2_log := ln(_curadd_assess_amt2);
	
	_preadd_assess_amt2 := if(_preadd_assess_amt <= 0, 140000, min(700000, if(max((real)50000, _preadd_assess_amt) = NULL, -NULL, max((real)50000, _preadd_assess_amt))));
	
	_preadd_assess_amt2_log := ln(_preadd_assess_amt2);
	
	_add1_avm_sales_price := if(add1_avm_sales_price <= (string)0, 170000, min(1000000, if(max(80000, (integer)add1_avm_sales_price) = NULL, -NULL, max(80000, (integer)add1_avm_sales_price))));
	
	_add1_avm_sales_price_log := ln(_add1_avm_sales_price);
	
	_add1_avm_ass_value := if(add1_avm_assessed_total_value <= (string)0, 210000, min(1000000, if(max(10000, (integer)add1_avm_assessed_total_value) = NULL, -NULL, max(10000, (integer)add1_avm_assessed_total_value))));
	
	_add1_avm_ass_value_log := ln(_add1_avm_ass_value);
	
	_add1_avm_med := if(add1_avm_med <= 0, 50000, min(1000000, if(max(50000, add1_avm_med) = NULL, -NULL, max(50000, add1_avm_med))));
	
	_add1_avm_med_log := ln(_add1_avm_med);
	
	_curadd_avm2 := if(_curadd_avm <= 0, 220000, min(1000000, if(max((real)10000, _curadd_avm) = NULL, -NULL, max((real)10000, _curadd_avm))));
	
	_curadd_avm2_log := ln(_curadd_avm2);
	
	_add1_avm_to_med_ratio := if(add1_avm_to_med_ratio <= (REAL)0, 0.846, min(2.502, if(max(0.653, add1_avm_to_med_ratio) = NULL, -NULL, max(0.653, add1_avm_to_med_ratio))));
	
	_add1_mortgage_convention := (add1_mortgage_type in ['N', 'E']);
	
	_add1_building_area_i := map(
	    add1_building_area2 <= 0    => 12.5,
	    add1_building_area2 <= 1030 => 1,
	    add1_building_area2 <= 1103 => 2,
	    add1_building_area2 <= 1226 => 3,
	    add1_building_area2 <= 1281 => 4,
	    add1_building_area2 <= 1338 => 5,
	    add1_building_area2 <= 1445 => 6,
	    add1_building_area2 <= 1502 => 7,
	    add1_building_area2 <= 1559 => 8,
	    add1_building_area2 <= 1646 => 9,
	    add1_building_area2 <= 1736 => 10,
	    add1_building_area2 <= 1832 => 11,
	    add1_building_area2 <= 1969 => 12,
	    add1_building_area2 <= 2046 => 13,
	    add1_building_area2 <= 2128 => 14,
	    add1_building_area2 <= 2218 => 15,
	    add1_building_area2 <= 2360 => 16,
	    add1_building_area2 <= 2472 => 17,
	    add1_building_area2 <= 2597 => 18,
	    add1_building_area2 <= 2744 => 19,
	    add1_building_area2 <= 3025 => 20,
	    add1_building_area2 <= 3297 => 21,
	    add1_building_area2 <= 3750 => 22,
	    add1_building_area2 <= 4229 => 23,
	                                   24);
	
	_add1_no_of_bedrooms_47 := 4 <= add1_no_of_bedrooms2 AND add1_no_of_bedrooms2 <= 7;
	
	_add1_no_of_baths_1 := add1_no_of_baths2 = 1;
	
	_add1_no_of_baths_2 := add1_no_of_baths2 = 2;
	
	_add1_no_of_baths_4plus := 4 <= add1_no_of_baths2;
	
	_add1_no_of_partial_baths_1 := add1_no_of_partial_baths2 = 1;
	
	_add1_parking_no_of_cars_1 := add1_parking_no_of_cars2 = 1;
	
	_add1_parking_no_of_cars_2 := add1_parking_no_of_cars2 = 2;
	
	_add1_parking_no_of_cars_3plus := add1_parking_no_of_cars2 >= 3;
	
	_prop_owned_pur_tot := if(property_owned_purchase_total <= 0, 125000, min(1000000, if(max(100000, property_owned_purchase_total) = NULL, -NULL, max(100000, property_owned_purchase_total))));
	
	_prop_owned_pur_tot_log := ln(_prop_owned_pur_tot);
	
	_prop_owned_assess_tot := if(property_owned_assessed_total <= 0, 170000, min(1000000, if(max(90000, property_owned_assessed_total) = NULL, -NULL, max(90000, property_owned_assessed_total))));
	
	_prop_owned_assess_tot_log := ln(_prop_owned_assess_tot);
	
	_prop_owned_assess_cnt := min(7, if(property_owned_assessed_count = NULL, -NULL, property_owned_assessed_count));
	
	_prop_sold_pur_tot := if(property_sold_purchase_total <= 0, 1000, min(1000000, if(max(1000, property_sold_purchase_total) = NULL, -NULL, max(1000, property_sold_purchase_total))));
	
	_prop_sold_pur_tot_log := ln(_prop_sold_pur_tot);
	
	_attr_num_watercraft60 := min(4, if(attr_num_watercraft60 = NULL, -NULL, attr_num_watercraft60));
	
	_watercraft_count := min(3, if(watercraft_count = NULL, -NULL, watercraft_count));
	
	_waterccraft_sum := _attr_num_watercraft60 + _watercraft_count;
	
	_wealth_index6 := wealth_index = (string)6;
	
	_wealth_index5 := wealth_index = (string)5;
	
	_wealth_index4 := wealth_index = (string)4;
	
	_wealth_index23 := (string)2 <= wealth_index AND wealth_index <= (string)3;
	
	_wealth_index1 := wealth_index = (string)1;
	
	avm_pop := add1_avm_automated_valuation > 0;
	
	_add1_building_area_i_m_c46 := map(
	    _add1_building_area_i = 1    => 10.959394632,
	    _add1_building_area_i = 2    => 10.978418582,
	    _add1_building_area_i = 3    => 11.015935805,
	    _add1_building_area_i = 4    => 11.032637049,
	    _add1_building_area_i = 5    => 11.061330999,
	    _add1_building_area_i = 6    => 11.077093112,
	    _add1_building_area_i = 7    => 11.094089838,
	    _add1_building_area_i = 8    => 11.112366079,
	    _add1_building_area_i = 9    => 11.137379038,
	    _add1_building_area_i = 10   => 11.168506984,
	    _add1_building_area_i = 11   => 11.194782109,
	    _add1_building_area_i = 12   => 11.22430809,
	    _add1_building_area_i = 12.5 => 11.243469429,
	    _add1_building_area_i = 13   => 11.268277136,
	    _add1_building_area_i = 14   => 11.284445832,
	    _add1_building_area_i = 15   => 11.302502159,
	    _add1_building_area_i = 16   => 11.340101181,
	    _add1_building_area_i = 17   => 11.380526869,
	    _add1_building_area_i = 18   => 11.414194194,
	    _add1_building_area_i = 19   => 11.430534542,
	    _add1_building_area_i = 20   => 11.461905825,
	    _add1_building_area_i = 21   => 11.53141763,
	    _add1_building_area_i = 22   => 11.56334665,
	    _add1_building_area_i = 23   => 11.597009259,
	    _add1_building_area_i = 24   => 11.609805851,
	                                    11.222764869);
	
	mod_avm_logincome02_c45_b1_1 := 0.7236262911 +
	    _curadd_assess_amt2_log * 0.0227623863 +
	    _preadd_assess_amt2_log * 0.0292577254 +
	    _add1_avm_sales_price_log * 0.1201787109 +
	    _add1_avm_ass_value_log * 0.0303444009 +
	    _add1_avm_med_log * 0.0959779424 +
	    _curadd_avm2_log * 0.0454679154 +
	    _add1_avm_to_med_ratio * 0.0809502341 +
	    _add1_building_area_i_m_c46 * 0.5549689113 +
	    (integer)_add1_avm_land_used_sf * -0.037250945 +
	    (integer)_add1_mortgage_convention * 0.0387786305 +
	    (integer)_add1_no_of_bedrooms_47 * -0.018144602 +
	    (integer)_add1_no_of_baths_1 * -0.053150408 +
	    (integer)_add1_no_of_baths_2 * -0.025025682 +
	    (integer)_add1_no_of_baths_4plus * -0.047029734 +
	    (integer)_add1_no_of_partial_baths_1 * 0.0566027258 +
	    (integer)_add1_parking_no_of_cars_1 * 0.0331884162 +
	    (integer)_add1_parking_no_of_cars_2 * 0.0599822762 +
	    (integer)_add1_parking_no_of_cars_3plus * 0.0633070151;
	
	mod_avm_logincome02 := if(avm_pop, exp(mod_avm_logincome02_c45_b1_1), exp(11.0139570));
	
	_inferred_age3 := map(
	    inferred_age <= 20 => 20,
	    inferred_age <= 21 => 21,
	    inferred_age <= 22 => 22,
	    inferred_age <= 23 => 23,
	    inferred_age <= 24 => 24,
	    inferred_age <= 25 => 25,
	    inferred_age <= 26 => 26,
	    inferred_age <= 27 => 27,
	    inferred_age <= 28 => 28,
	    inferred_age <= 29 => 29,
	    inferred_age <= 30 => 30,
	    inferred_age <= 31 => 31,
	    inferred_age <= 32 => 32,
	    inferred_age <= 34 => 34,
	    inferred_age <= 35 => 35,
	    inferred_age <= 36 => 36,
	    inferred_age <= 37 => 37,
	    inferred_age <= 38 => 38,
	    inferred_age <= 41 => 41,
	    inferred_age <= 43 => 43,
	    inferred_age <= 45 => 45,
	    inferred_age <= 47 => 47,
	    inferred_age <= 51 => 51,
	    inferred_age <= 53 => 53,
	    inferred_age <= 56 => 56,
	    inferred_age <= 59 => 59,
	    inferred_age <= 60 => 60,
	    inferred_age <= 62 => 62,
	    inferred_age <= 63 => 63,
	    inferred_age <= 65 => 65,
	    inferred_age <= 67 => 67,
	    inferred_age <= 68 => 68,
	    inferred_age <= 71 => 71,
	    inferred_age <= 73 => 73,
	    inferred_age <= 77 => 77,
	    inferred_age <= 82 => 82,
	                          83);
	
	_prof_license_category5 := prof_license_category = (string)5;
	
	_prof_license_category4 := prof_license_category = (string)4;
	
	_prof_license_category1 := prof_license_category = (string)1;
	
	_attr_num_nonderogs := if(attr_num_nonderogs30 > 3, 11, min(10, if(max(1, attr_num_nonderogs) = NULL, -NULL, max(1, attr_num_nonderogs))));
	
	_add1_lres := map(
	    add1_lres <= 0   => 0,
	    add1_lres <= 6   => 6,
	    add1_lres <= 12  => 12,
	    add1_lres <= 24  => 24,
	    add1_lres <= 36  => 36,
	    add1_lres <= 48  => 48,
	    add1_lres <= 60  => 60,
	    add1_lres <= 120 => 120,
	                        121);
	
	_add_lres_year_avg := map(
	    add_lres_year_avg = NULL => 0,
	    add_lres_year_avg <= 0.5 => 0.5,
	    add_lres_year_avg <= 1   => 1,
	    add_lres_year_avg <= 2   => 2,
	    add_lres_year_avg <= 3   => 3,
	    add_lres_year_avg <= 4   => 4,
	    add_lres_year_avg <= 5   => 5,
	    add_lres_year_avg <= 10  => 10,
	    add_lres_year_avg <= 20  => 20,
	                                21);
	
	_addrs_per_adl := if(addrs_per_adl = 0, 7, min(20, if(addrs_per_adl = NULL, -NULL, addrs_per_adl)));
	
	_phones_per_adl := min(5, if(phones_per_adl = NULL, -NULL, phones_per_adl));
	
	_adls_per_addr := map(
	    adls_per_addr <= 1  => 1,
	    adls_per_addr <= 2  => 2,
	    adls_per_addr <= 7  => 7,
	    adls_per_addr <= 9  => 9,
	    adls_per_addr <= 12 => 12,
	    adls_per_addr <= 15 => 15,
	    adls_per_addr <= 19 => 19,
	                           20);
	
	_ssn_issue7yr := rc_pwssnvalflag = (string)4;
	
	_source_count := min(10, if(max(1, source_count) = NULL, -NULL, max(1, source_count)));
	
	_ams_income_i_m := map(
	    _ams_income_i = -1 => 11.145993645,
	    _ams_income_i = 1  => 10.995130365,
	    _ams_income_i = 2  => 11.00268857,
	    _ams_income_i = 3  => 11.04840032,
	    _ams_income_i = 4  => 11.070253902,
	    _ams_income_i = 5  => 11.109977282,
	    _ams_income_i = 6  => 11.152270068,
	    _ams_income_i = 7  => 11.19129522,
	    _ams_income_i = 8  => 11.208295426,
	    _ams_income_i = 9  => 11.274986045,
	                          11.14274654);
	
	_prop_owned_assess_cnt_m := map(
	    _prop_owned_assess_cnt = 0 => 11.078866903,
	    _prop_owned_assess_cnt = 1 => 11.239785105,
	    _prop_owned_assess_cnt = 2 => 11.309676903,
	    _prop_owned_assess_cnt = 3 => 11.35854488,
	    _prop_owned_assess_cnt = 4 => 11.389228355,
	    _prop_owned_assess_cnt = 5 => 11.394997013,
	    _prop_owned_assess_cnt = 6 => 11.425650288,
	    _prop_owned_assess_cnt = 7 => 11.526791246,
	                                  11.14274654);
	
	prop_owner_m := map(
	    prop_owner = 0 => 10.883723204,
	    prop_owner = 1 => 11.144768787,
	    prop_owner = 2 => 11.273870032,
	                      11.14274654);
	
	_waterccraft_sum_m := map(
	    _waterccraft_sum = 0 => 11.135214539,
	    _waterccraft_sum = 1 => 11.298318567,
	    _waterccraft_sum = 2 => 11.312272508,
	    _waterccraft_sum = 3 => 11.335459539,
	    _waterccraft_sum = 4 => 11.344466612,
	    _waterccraft_sum = 5 => 11.394149232,
	    _waterccraft_sum = 6 => 11.397915563,
	    _waterccraft_sum = 7 => 11.538286274,
	                            11.14274654);
	
	_add1_lres_m := map(
	    _add1_lres = 0   => 11.005441268,
	    _add1_lres = 6   => 10.882662492,
	    _add1_lres = 12  => 10.996965549,
	    _add1_lres = 24  => 11.054923227,
	    _add1_lres = 36  => 11.098181606,
	    _add1_lres = 48  => 11.111762116,
	    _add1_lres = 60  => 11.173010574,
	    _add1_lres = 120 => 11.185776588,
	    _add1_lres = 121 => 11.217863554,
	                        11.14274654);
	
	_add_lres_year_avg_m := map(
	    _add_lres_year_avg = 0   => 11.148174119,
	    _add_lres_year_avg = 0.5 => 10.593559713,
	    _add_lres_year_avg = 1   => 10.675709338,
	    _add_lres_year_avg = 2   => 10.837669689,
	    _add_lres_year_avg = 3   => 10.946417342,
	    _add_lres_year_avg = 4   => 10.994544135,
	    _add_lres_year_avg = 5   => 11.085786521,
	    _add_lres_year_avg = 10  => 11.185542124,
	    _add_lres_year_avg = 20  => 11.224288479,
	    _add_lres_year_avg = 21  => 11.161661004,
	                                11.14274654);
	
	_adls_per_addr_m := map(
	    _adls_per_addr = 1  => 10.998921525,
	    _adls_per_addr = 2  => 11.255597117,
	    _adls_per_addr = 7  => 11.194926857,
	    _adls_per_addr = 9  => 11.170188989,
	    _adls_per_addr = 12 => 11.13760555,
	    _adls_per_addr = 15 => 11.094552697,
	    _adls_per_addr = 19 => 11.028008166,
	    _adls_per_addr = 20 => 10.970233874,
	                           11.14274654);
	
	_inferred_age3_m := map(
	    _inferred_age3 = 20 => 10.571954198,
	    _inferred_age3 = 21 => 10.674884109,
	    _inferred_age3 = 22 => 10.692599576,
	    _inferred_age3 = 23 => 10.714404739,
	    _inferred_age3 = 24 => 10.752350866,
	    _inferred_age3 = 25 => 10.827185192,
	    _inferred_age3 = 26 => 10.897881059,
	    _inferred_age3 = 27 => 10.960121266,
	    _inferred_age3 = 28 => 11.020416349,
	    _inferred_age3 = 29 => 11.0688614,
	    _inferred_age3 = 30 => 11.117112095,
	    _inferred_age3 = 31 => 11.158730657,
	    _inferred_age3 = 32 => 11.203068249,
	    _inferred_age3 = 34 => 11.242697512,
	    _inferred_age3 = 35 => 11.274763901,
	    _inferred_age3 = 36 => 11.274852834,
	    _inferred_age3 = 37 => 11.278333146,
	    _inferred_age3 = 38 => 11.299701615,
	    _inferred_age3 = 41 => 11.320281623,
	    _inferred_age3 = 43 => 11.309250669,
	    _inferred_age3 = 45 => 11.30409686,
	    _inferred_age3 = 47 => 11.29939935,
	    _inferred_age3 = 51 => 11.293146116,
	    _inferred_age3 = 53 => 11.283595252,
	    _inferred_age3 = 56 => 11.276908852,
	    _inferred_age3 = 59 => 11.224587628,
	    _inferred_age3 = 60 => 11.224839572,
	    _inferred_age3 = 62 => 11.213207161,
	    _inferred_age3 = 63 => 11.198839888,
	    _inferred_age3 = 65 => 11.165238521,
	    _inferred_age3 = 67 => 11.123446003,
	    _inferred_age3 = 68 => 11.09120134,
	    _inferred_age3 = 71 => 11.040898854,
	    _inferred_age3 = 73 => 10.996640942,
	    _inferred_age3 = 77 => 10.969939836,
	    _inferred_age3 = 82 => 10.92051019,
	    _inferred_age3 = 83 => 10.832396513,
	                           11.14274654);
	
	logincome := -5.508387261 +
	    (integer)out_st2 * -0.050864267 +
	    (integer)out_st5 * 0.0595628434 +
	    (integer)out_st6 * 0.0595185023 +
	    (integer)_add1_bestmatch_1pop * -0.11827092 +
	    (integer)_add1_bestmatch_12pop * -0.066545244 +
	    _ams_age_lg * 0.1181750865 +
	    _ams_income_i_m * 0.3201004617 +
	    (integer)_ams_college_tier1 * 0.1812788174 +
	    (integer)_ams_college_tier2 * 0.1176152297 +
	    (integer)_ams_college_tier3 * 0.0782842883 +
	    (integer)_ams_college_tier4 * 0.0481291561 +
	    mod_avm_logincome02 * 7.312824E-6 +
	    (integer)add1_occupant_owned * -0.038836978 +
	    (integer)add1_family_owned * 0.0848366371 +
	    (integer)add1_family_sold * -0.059394272 +
	    (integer)add1_applicant_sold * 0.0454254994 +
	    _prop_owned_pur_tot_log * 0.0219695073 +
	    _prop_owned_assess_tot_log * 0.0940228287 +
	    _prop_owned_assess_cnt_m * -0.500964596 +
	    _prop_sold_pur_tot_log * -0.003935301 +
	    (integer)prop_owned_flag * 0.0434950985 +
	    prop_owner_m * 0.1313571882 +
	    _waterccraft_sum_m * 0.3416502623 +
	    (integer)_wealth_index6 * 0.1316403667 +
	    (integer)_wealth_index5 * 0.0921645383 +
	    (integer)_wealth_index4 * 0.0227595534 +
	    (integer)_wealth_index23 * -0.039783325 +
	    (integer)_wealth_index1 * -0.081560157 +
	    _inferred_age3_m * 0.6001776449 +
	    (integer)_prof_license_category5 * 0.2569903892 +
	    (integer)_prof_license_category4 * 0.1107393459 +
	    (integer)_prof_license_category1 * -0.218915622 +
	    _attr_num_nonderogs * 0.0409807002 +
	    _add1_lres_m * 0.0848279089 +
	    _add_lres_year_avg_m * 0.0692554818 +
	    _addrs_per_adl * 0.0113651653 +
	    _phones_per_adl * 0.0276692259 +
	    _adls_per_addr_m * 0.2171201382 +
	    (integer)_ssn_issue7yr * 0.1978840889 +
	    (integer)ssn_prob * -0.076770752 +
	    (integer)source_tot_am * 0.0930629358 +
	    (integer)source_tot_ba * -0.061016521 +
	    (integer)source_tot_da * 0.1612035118 +
	    (integer)source_tot_p * 0.034675984 +
	    rc_phoneaddr_addrcount * -0.018819504 +
	    _source_count * -0.017155693;
	
	estincome_raw := exp(logincome);
	
	estincome_raw_c := min(if(max(estincome_raw, (real)30000) = NULL, -NULL, max(estincome_raw, (real)30000)), 200000);
	
	estincome_raw_c_srt := sqrt(estincome_raw_c);
	
	tot_num_derog := map(
	    (attr_total_number_derogs in [4, 5]) => 4,
	    attr_total_number_derogs > 5         => 6,
	                                            attr_total_number_derogs);
	
	tot_num_derog_m := map(
	    tot_num_derog = 0 => 0.326481411,
	    tot_num_derog = 1 => 0.340082361,
	    tot_num_derog = 2 => 0.3247687564,
	    tot_num_derog = 3 => 0.3047476476,
	    tot_num_derog = 4 => 0.279218339,
	    tot_num_derog = 6 => 0.2527881041,
	                         0.3103287238);
	
	bk_disposed_lvl := map(
	    bk_disposed_recent_count = 0 and bk_disposed_historical_count = 0 => 0,
	    bk_disposed_recent_count = 0 and bk_disposed_historical_count > 0 => 1,
	                                                                         2);
	
	bk_disposed_lvl_m := map(
	    bk_disposed_lvl = 0 => 0.3105396615,
	    bk_disposed_lvl = 1 => 0.3229219144,
	    bk_disposed_lvl = 2 => 0.1920289855,
	                           0.3103287238);
	
	felony_flag := felony_count > 0;
	
	attr_arrests_f := attr_arrests > 0;
	
	verx_lvl2 := map(
	    did_count > 1                                                    => 0.5,
	    nas_summary < 10                                                 => 0,
	    nap_summary = 0 or nap_summary = 3 and nap_status != 'C'         => 1,
	    nap_summary = 3 or (nap_summary in [5, 8]) and nap_status != 'C' => 2,
	    (nap_summary in [5, 8])                                          => 3,
	                                                                        -1);
	
	verx_lvl2_m := map(
	    verx_lvl2 = 0   => 0.2456035768,
	    verx_lvl2 = 0.5 => 0.2669983416,
	    verx_lvl2 = 1   => 0.286026519,
	    verx_lvl2 = 2   => 0.2895092736,
	    verx_lvl2 = 3   => 0.352264291,
	                       0.3103287238);
	
	prof_lic_lvl := map(
	    (prof_license_category in ['0', ''])       => 0,
	    (prof_license_category in ['3', '4', '5']) => 5,
	                                                  (INTEGER)prof_license_category);
	
	prof_lic_lvl_m := map(
	    prof_lic_lvl = 0 => 0.3086039541,
	    prof_lic_lvl = 1 => 0.2747826087,
	    prof_lic_lvl = 2 => 0.3517915309,
	    prof_lic_lvl = 5 => 0.3647604328,
	                        0.3103287238);
	
	college_lvl := map(
	    ams_college_tier = (string)6         => 0,
	    (ams_college_tier in ['', '0', '5']) => 1,
	                                            2);
	
	college_lvl_m := map(
	    college_lvl = 0 => 0.1967213115,
	    college_lvl = 1 => 0.3088556949,
	    college_lvl = 2 => 0.3977011494,
	                       0.3103287238);
	
	ssns_per_adl_5_v2 := if(invalid_ssns_per_adl > 0 or invalid_ssns_per_adl_c6 > 0 or ssns_per_adl = 0, 0, min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 5));
	
	ssns_per_adl_5_v2_m := map(
	    ssns_per_adl_5_v2 = 0 => 0.2457077451,
	    ssns_per_adl_5_v2 = 1 => 0.3256735951,
	    ssns_per_adl_5_v2 = 2 => 0.2976714101,
	    ssns_per_adl_5_v2 = 3 => 0.2603377985,
	    ssns_per_adl_5_v2 = 4 => 0.2245508982,
	    ssns_per_adl_5_v2 = 5 => 0.2049689441,
	                             0.3103287238);
	
	liens_sc_lvl := map(
	    liens_rel_sc_ct > 0   => 0,
	    liens_unrel_sc_ct > 0 => 1,
	                             2);
	
	liens_sc_lvl_m := map(
	    liens_sc_lvl = 0 => 0.4467005076,
	    liens_sc_lvl = 1 => 0.3184794761,
	    liens_sc_lvl = 2 => 0.3035048232,
	                        0.3103287238);
	
	liens_released_lvl := map(
	    liens_historical_released_count > 0 and liens_recent_released_count > 0 => 2,
	    liens_recent_released_count = 1                                         => 0,
	    liens_recent_released_count > 1                                         => 1,
	    (liens_historical_released_count in [1, 2])                             => 3,
	    liens_historical_released_count = 0 and liens_recent_released_count = 0 => 4,
	    liens_historical_released_count > 2                                     => 4,
	                                                                               -1);
	
	liens_unreleased_lvl := map(
	    liens_recent_unreleased_count > 0 and liens_historical_unreleased_ct = 0 => 0,
	    liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct = 0 => 1,
	    liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct > 0 => 2,
	                                                                                3);
	
	liens_lvl := map(
	    (liens_released_lvl in [0, 1]) and (liens_unreleased_lvl in [0, 1]) => 0,
	    (liens_released_lvl in [0, 1]) and (liens_unreleased_lvl in [2, 3]) => 1,
	    (liens_released_lvl in [2, 3])                                      => 2,
	    liens_released_lvl = 4 and liens_unreleased_lvl = 1                 => 3,
	    liens_released_lvl = 4 and liens_unreleased_lvl = 0                 => 3,
	    liens_released_lvl = 4 and liens_unreleased_lvl = 2                 => 4,
	    liens_released_lvl = 4 and liens_unreleased_lvl = 3                 => 5,
	                                                                           -1);
	
	liens_lvl_v2 := if(liens_lvl = 3 and ((integer)source_tot_l2 > 0 or (integer)source_tot_li > 0), 3.5, liens_lvl);
	
	liens_lvl_v2_m := map(
	    liens_lvl_v2 = 0   => 0.4878980892,
	    liens_lvl_v2 = 1   => 0.4523160763,
	    liens_lvl_v2 = 2   => 0.3315301391,
	    liens_lvl_v2 = 3   => 0.3352694129,
	    liens_lvl_v2 = 3.5 => 0.2981160512,
	    liens_lvl_v2 = 4   => 0.2530482086,
	    liens_lvl_v2 = 5   => 0.2478826376,
	                          0.3103287238);
	
	addr_stability_m := map(
	    addr_stability = (string)0 => 0.2536873156,
	    addr_stability = (string)1 => 0.2619961612,
	    addr_stability = (string)2 => 0.3215311813,
	    addr_stability = (string)3 => 0.2920035939,
	    addr_stability = (string)4 => 0.3156552779,
	    addr_stability = (string)5 => 0.3384547849,
	    addr_stability = (string)6 => 0.3521197007,
	                                  0.3103287238);
	
	tot_prop_lvl := map(
	    property_sold_total = 0 and property_owned_total > 0 => 0,
	    property_sold_total = 0 and property_owned_total = 0 => 2,
	    property_owned_total = 1                             => 3,
	    property_owned_total = 0                             => 5,
	                                                            4);
	
	tot_prop_lvl_m := map(
	    tot_prop_lvl = 0 => 0.3346666039,
	    tot_prop_lvl = 2 => 0.2964569776,
	    tot_prop_lvl = 3 => 0.2891768659,
	    tot_prop_lvl = 4 => 0.28113879,
	    tot_prop_lvl = 5 => 0.2424511545,
	                        0.3103287238);
	
	current_own_vehicle_f := current_count > 0;
	
	any_atfault_accident := acc_atfault_count > 0 or acc_atfaultda_count > 0;
	
	rel_within25_lvl := map(
	    0 < rel_within25miles_count AND rel_within25miles_count <= 7  => 3,
	    7 < rel_within25miles_count AND rel_within25miles_count <= 15 => 2,
	    rel_within25miles_count = 0                                   => 0,
	    rel_within25miles_count > 15                                  => 0,
	                                                                     -1);
	
	rel_within25_lvl_m := map(
	    rel_within25_lvl = 0 => 0.2612137203,
	    rel_within25_lvl = 2 => 0.2928416486,
	    rel_within25_lvl = 3 => 0.3245054244,
	                            0.3103287238);
	
	rel_ageunder20_lvl := map(
	    rel_ageunder20_count = 0                               => 0,
	    0 < rel_ageunder20_count AND rel_ageunder20_count <= 3 => 1,
	    3 < rel_ageunder20_count AND rel_ageunder20_count <= 5 => 2,
	    rel_ageunder20_count > 5                               => 3,
	                                                              -1);
	
	rel_ageunder20_lvl_m := map(
	    rel_ageunder20_lvl = 0 => 0.3298891759,
	    rel_ageunder20_lvl = 1 => 0.3105900707,
	    rel_ageunder20_lvl = 2 => 0.2752580544,
	    rel_ageunder20_lvl = 3 => 0.2275950999,
	                              0.3103287238);
	
	avm_value_increase := if(add1_avm_automated_valuation = 0 or add1_avm_automated_valuation_2 = 0, -1, (integer)(add1_avm_automated_valuation > add1_avm_automated_valuation_2));
	
	avm_value_increase_m := map(
	    avm_value_increase = -1 => 0.3095594846,
	    avm_value_increase = 0  => 0.3015842596,
	    avm_value_increase = 1  => 0.3344616377,
	                               0.3103287238);
	
	starting_equity_tax := if(add1_avm_tax_assessed_valuation = 0 or add1_mortgage_amount = 0, -1, truncate((add1_avm_tax_assessed_valuation - add1_mortgage_amount) / add1_avm_tax_assessed_valuation * 100) + 1);
	
	starting_tax_equity_lvl := map(
	    add1_avm_tax_assessed_valuation = 0 or add1_mortgage_amount = 0 => -1,
	    starting_equity_tax <= 0                                        => 0,
	    starting_equity_tax > 0                                         => 1,
	                                                                       -2);
	
	starting_tax_equity_lvl_m := map(
	    starting_tax_equity_lvl = -1 => 0.3088514189,
	    starting_tax_equity_lvl = 0  => 0.2761659934,
	    starting_tax_equity_lvl = 1  => 0.3302537029,
	                                    0.3103287238);
	
	avm_index_geo12 := if(add1_avm_med_geo12 = 0 or add1_avm_automated_valuation = 0, -1, truncate(add1_avm_automated_valuation / add1_avm_med_geo12 * 100));
	
	avm_index_geo12_lvl := map(
	    avm_index_geo12 = -1                            => -1,
	    0 <= avm_index_geo12 AND avm_index_geo12 <= 50  => 1,
	    50 < avm_index_geo12 AND avm_index_geo12 <= 130 => 2,
	    avm_index_geo12 > 130                           => 3,
	                                                       -2);
	
	avm_index_geo12_lvl_m := map(
	    avm_index_geo12_lvl = -1 => 0.3097481372,
	    avm_index_geo12_lvl = 1  => 0.2651888342,
	    avm_index_geo12_lvl = 2  => 0.3123063302,
	    avm_index_geo12_lvl = 3  => 0.3198407432,
	                                0.3103287238);
	
	add1_mortgage_date2 := Common.SAS_Date((STRING)add1_mortgage_date);
	
	years_add1_mortgage_date := if(min(sysdate, add1_mortgage_date2) = NULL, NULL, (sysdate - add1_mortgage_date2) / 365.25);
	
	yrs_since_mtg := map(
	    years_add1_mortgage_date = NULL => -2,
	    years_add1_mortgage_date < 0    => -1,
	    years_add1_mortgage_date <= 5   => 5,
	    years_add1_mortgage_date > 5    => 6,
	                                       -99);
	
	yrs_since_mtg_m := map(
	    yrs_since_mtg = -2 => 0.3088128845,
	    yrs_since_mtg = -1 => 0.3723849372,
	    yrs_since_mtg = 5  => 0.3038983051,
	    yrs_since_mtg = 6  => 0.3135434754,
	                          0.3103287238);
	
	c_robbery_c := map(
	    TRIM(C_ROBBERY) = '' => 40,
	    (INTEGER)C_ROBBERY = 0    => 1,
	                        min(if((INTEGER)C_ROBBERY = NULL, -NULL, (INTEGER)C_ROBBERY), 200));
	
	c_robbery_srt := sqrt(c_robbery_c);
	
	c_easiqlife_lvl := map(
	    (INTEGER)C_EASIQLIFE <= 100                       					=> 0,
	    100 < (INTEGER)C_EASIQLIFE AND (INTEGER)C_EASIQLIFE <= 120 	=> 1,
	    (INTEGER)C_EASIQLIFE > 120                        					=> 2,
																																		-1);
	
	c_easiqlife_lvl_m := map(
	    c_easiqlife_lvl = 0 => 0.3401789256,
	    c_easiqlife_lvl = 1 => 0.2939755398,
	    c_easiqlife_lvl = 2 => 0.2486726623,
	                           0.3103287238);
	
	c_born_usa_c := map(
	    TRIM(C_BORN_USA) = '' => 100,
	    (INTEGER)C_BORN_USA = 0    => 1,
	                         min(if((INTEGER)C_BORN_USA = NULL, -NULL, (INTEGER)C_BORN_USA), 200));
	
	c_born_usa_srt := sqrt(c_born_usa_c);
	
	c_many_cars_c := map(
	    TRIM(C_MANY_CARS) = '' => 120,
	    (INTEGER)C_MANY_CARS = 0    => 1,
	                          min(if((INTEGER)C_MANY_CARS = NULL, -NULL, (INTEGER)C_MANY_CARS), 200));
	
	c_span_lang_c := map(
	    TRIM(C_SPAN_LANG) = '' => 100,
	    (INTEGER)C_SPAN_LANG = 0    => 1,
	                          min(if((INTEGER)C_SPAN_LANG = NULL, -NULL, (INTEGER)C_SPAN_LANG), 200));
	
	c_civ_emp_c := map(
			TRIM(C_CIV_EMP) = '' => 75.0,
															min(max((REAL)C_CIV_EMP,20.0),100.0));
															
	rsn1010_log := -17.61559931 +
	    tot_num_derog_m * 4.2919134901 +
	    bk_disposed_lvl_m * 4.574465567 +
	    (integer)felony_flag * -0.422499904 +
	    (integer)attr_arrests_f * -0.997809418 +
	    verx_lvl2_m * 2.761250284 +
	    prof_lic_lvl_m * 2.5938355726 +
	    college_lvl_m * 3.6544125351 +
	    ssns_per_adl_5_v2_m * 2.6231332459 +
	    liens_sc_lvl_m * 3.5546761071 +
	    liens_lvl_v2_m * 3.9249478035 +
	    estincome_raw_c_srt * 0.0016024889 +
	    addr_stability_m * 2.2833665641 +
	    tot_prop_lvl_m * 2.4140077799 +
	    (integer)current_own_vehicle_f * 0.0725424387 +
	    (integer)any_atfault_accident * -0.328924656 +
	    rel_within25_lvl_m * 1.2958698048 +
	    rel_ageunder20_lvl_m * 2.5373713759 +
	    avm_value_increase_m * 2.2786567107 +
	    starting_tax_equity_lvl_m * 3.1123566349 +
	    avm_index_geo12_lvl_m * 3.6082740333 +
	    yrs_since_mtg_m * 3.493355681 +
	    c_robbery_srt * -0.014675589 +
	    c_easiqlife_lvl_m * 2.10408025 +
	    c_born_usa_srt * 0.0346253257 +
	    c_many_cars_c * 0.0013739155 +
	    c_span_lang_c * -0.001275207 +
	    c_civ_emp_c * 0.0039440518;
	
	base := 680;
	
	odds := .3103 / .6897;
	
	point := 50;
	
	phat := exp(rsn1010_log) / (1 + exp(rsn1010_log));
	
	rsn1010_1_0_2 := truncate(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);
	
	rsn1010_1_0_1 := max(min(if(rsn1010_1_0_2 = NULL, -NULL, rsn1010_1_0_2), 900), 501);
	
	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);
	
	rsn1010_1_0 := if(nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 AND not(scored_222s), 222, rsn1010_1_0_1);
	

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.c_robbery := c_robbery;
		SELF.c_easiqlife := c_easiqlife;
		SELF.c_born_usa := c_born_usa;
		SELF.c_many_cars := c_many_cars;
		SELF.c_span_lang := c_span_lang;
		SELF.c_civ_emp := c_civ_emp;
		SELF.truedid := truedid;
		SELF.adl_category := adl_category;
		SELF.in_state := in_state;
		SELF.out_st := out_st;
		SELF.out_addr_type := out_addr_type;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.nap_status := nap_status;
		SELF.did_count := did_count;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_pwssndobflag := rc_pwssndobflag;
		SELF.rc_ssnvalflag := rc_ssnvalflag;
		SELF.rc_pwssnvalflag := rc_pwssnvalflag;
		SELF.rc_ssnlowissue := rc_ssnlowissue;
		SELF.rc_ssnhighissue := rc_ssnhighissue;
		SELF.rc_ssnstate := rc_ssnstate;
		SELF.rc_areacodesplitdate := rc_areacodesplitdate;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_bansflag := rc_bansflag;
		SELF.rc_sources := rc_sources;
		SELF.rc_phoneaddr_addrcount := rc_phoneaddr_addrcount;
		SELF.combo_dobscore := combo_dobscore;
		SELF.combo_fnamecount := combo_fnamecount;
		SELF.combo_lnamecount := combo_lnamecount;
		SELF.combo_addrcount := combo_addrcount;
		SELF.pr_count := pr_count;
		SELF.adl_eq_first_seen := adl_eq_first_seen;
		SELF.adl_en_first_seen := adl_en_first_seen;
		SELF.adl_tu_first_seen := adl_tu_first_seen;
		SELF.adl_dl_first_seen := adl_dl_first_seen;
		SELF.adl_pr_first_seen := adl_pr_first_seen;
		SELF.adl_v_first_seen := adl_v_first_seen;
		SELF.adl_em_first_seen := adl_em_first_seen;
		SELF.adl_vo_first_seen := adl_vo_first_seen;
		SELF.adl_em_only_first_seen := adl_em_only_first_seen;
		SELF.adl_w_first_seen := adl_w_first_seen;
		SELF.ssnlength := ssnlength;
		SELF.source_count := source_count;
		SELF.age := age;
		SELF.util_adl_first_seen := util_adl_first_seen;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_unit_count := add1_unit_count;
		SELF.add1_lres := add1_lres;
		SELF.add1_avm_land_use := add1_avm_land_use;
		SELF.add1_avm_recording_date := add1_avm_recording_date;
		SELF.add1_avm_assessed_value_year := add1_avm_assessed_value_year;
		SELF.add1_avm_sales_price := add1_avm_sales_price;
		SELF.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
		SELF.add1_avm_market_total_value := add1_avm_market_total_value;
		SELF.add1_avm_tax_assessed_valuation := add1_avm_tax_assessed_valuation;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
		SELF.add1_avm_med_fips := add1_avm_med_fips;
		SELF.add1_avm_med_geo11 := add1_avm_med_geo11;
		SELF.add1_avm_med_geo12 := add1_avm_med_geo12;
		SELF.add1_source_count := add1_source_count;
		SELF.add1_occupant_owned := add1_occupant_owned;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_family_sold := add1_family_sold;
		SELF.add1_applicant_sold := add1_applicant_sold;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_purchase_amount := add1_purchase_amount;
		SELF.add1_mortgage_amount := add1_mortgage_amount;
		SELF.add1_mortgage_date := add1_mortgage_date;
		SELF.add1_mortgage_type := add1_mortgage_type;
		SELF.add1_assessed_amount := add1_assessed_amount;
		SELF.add1_date_first_seen := add1_date_first_seen;
		SELF.add1_date_last_seen := add1_date_last_seen;
		SELF.add1_land_use_code := add1_land_use_code;
		SELF.add1_building_area := add1_building_area;
		SELF.add1_no_of_buildings := add1_no_of_buildings;
		SELF.add1_no_of_stories := add1_no_of_stories;
		SELF.add1_no_of_rooms := add1_no_of_rooms;
		SELF.add1_no_of_bedrooms := add1_no_of_bedrooms;
		SELF.add1_no_of_baths := add1_no_of_baths;
		SELF.add1_no_of_partial_baths := add1_no_of_partial_baths;
		SELF.add1_garage_type_code := add1_garage_type_code;
		SELF.add1_parking_no_of_cars := add1_parking_no_of_cars;
		SELF.add1_assessed_value_year := add1_assessed_value_year;
		SELF.property_owned_total := property_owned_total;
		SELF.property_owned_purchase_total := property_owned_purchase_total;
		SELF.property_owned_purchase_count := property_owned_purchase_count;
		SELF.property_owned_assessed_total := property_owned_assessed_total;
		SELF.property_owned_assessed_count := property_owned_assessed_count;
		SELF.property_sold_total := property_sold_total;
		SELF.property_sold_purchase_total := property_sold_purchase_total;
		SELF.property_sold_purchase_count := property_sold_purchase_count;
		SELF.property_ambig_total := property_ambig_total;
		SELF.prop1_sale_price := prop1_sale_price;
		SELF.prop1_sale_date := prop1_sale_date;
		SELF.prop2_sale_price := prop2_sale_price;
		SELF.add2_addr_type := add2_addr_type;
		SELF.add2_lres := add2_lres;
		SELF.add2_avm_automated_valuation := add2_avm_automated_valuation;
		SELF.add2_naprop := add2_naprop;
		SELF.add2_assessed_amount := add2_assessed_amount;
		SELF.add2_date_first_seen := add2_date_first_seen;
		SELF.add2_pop := add2_pop;
		SELF.add3_addr_type := add3_addr_type;
		SELF.add3_naprop := add3_naprop;
		SELF.add3_purchase_amount := add3_purchase_amount;
		SELF.add3_mortgage_amount := add3_mortgage_amount;
		SELF.add3_assessed_amount := add3_assessed_amount;
		SELF.add3_date_first_seen := add3_date_first_seen;
		SELF.add3_pop := add3_pop;
		SELF.gong_did_first_seen := gong_did_first_seen;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.credit_first_seen := credit_first_seen;
		SELF.credit_last_seen := credit_last_seen;
		SELF.header_first_seen := header_first_seen;
		SELF.header_last_seen := header_last_seen;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.phones_per_adl := phones_per_adl;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.adls_per_addr := adls_per_addr;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.phones_per_adl_c6 := phones_per_adl_c6;
		SELF.pl_addrs_per_adl := pl_addrs_per_adl;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.invalid_ssns_per_adl_c6 := invalid_ssns_per_adl_c6;
		SELF.attr_num_purchase60 := attr_num_purchase60;
		SELF.attr_num_sold60 := attr_num_sold60;
		SELF.attr_num_watercraft60 := attr_num_watercraft60;
		SELF.attr_num_aircraft := attr_num_aircraft;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_arrests := attr_arrests;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.attr_num_nonderogs30 := attr_num_nonderogs30;
		SELF.attr_num_proflic60 := attr_num_proflic60;
		SELF.attr_num_proflic_exp60 := attr_num_proflic_exp60;
		SELF.bankrupt := bankrupt;
		SELF.date_last_seen := date_last_seen;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.bk_disposed_recent_count := bk_disposed_recent_count;
		SELF.bk_disposed_historical_count := bk_disposed_historical_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_recent_released_count := liens_recent_released_count;
		SELF.liens_historical_released_count := liens_historical_released_count;
		SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
		SELF.liens_rel_sc_ct := liens_rel_sc_ct;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.rel_within25miles_count := rel_within25miles_count;
		SELF.rel_ageunder20_count := rel_ageunder20_count;
		SELF.current_count := current_count;
		SELF.watercraft_count := watercraft_count;
		SELF.acc_atfault_count := acc_atfault_count;
		SELF.acc_atfaultda_count := acc_atfaultda_count;
		SELF.ams_date_first_seen := ams_date_first_seen;
		SELF.ams_date_last_seen := ams_date_last_seen;
		SELF.ams_age := ams_age;
		SELF.ams_dob := ams_dob;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_college_type := ams_college_type;
		SELF.ams_income_level_code := ams_income_level_code;
		SELF.ams_college_tier := ams_college_tier;
		SELF.prof_license_flag := prof_license_flag;
		SELF.prof_license_category := prof_license_category;
		SELF.wealth_index := wealth_index;
		SELF.input_dob_match_level := input_dob_match_level;
		SELF.inferred_age := inferred_age;
		SELF.reported_dob := reported_dob;
		SELF.addr_stability := addr_stability;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.source_tot_am := source_tot_am;
		SELF.source_tot_ba := source_tot_ba;
		SELF.source_tot_da := source_tot_da;
		SELF.source_tot_ds := source_tot_ds;
		SELF.source_tot_l2 := source_tot_l2;
		SELF.source_tot_li := source_tot_li;
		SELF.source_tot_p := source_tot_p;
		SELF.lien_rec_unrel_flag := lien_rec_unrel_flag;
		SELF.lien_hist_unrel_flag := lien_hist_unrel_flag;
		SELF.lien_flag := lien_flag;
		SELF.add1_date_first_seen2 := add1_date_first_seen2;
		SELF.years_add1_date_first_seen := years_add1_date_first_seen;
		SELF.add2_date_first_seen2 := add2_date_first_seen2;
		SELF.years_add2_date_first_seen := years_add2_date_first_seen;
		SELF.add3_date_first_seen2 := add3_date_first_seen2;
		SELF.years_add3_date_first_seen := years_add3_date_first_seen;
		SELF.add1_avm_med := add1_avm_med;
		SELF.add1_avm_to_med_ratio := add1_avm_to_med_ratio;
		SELF.add1_building_area2 := add1_building_area2;
		SELF.add1_no_of_bedrooms2 := add1_no_of_bedrooms2;
		SELF.add1_no_of_baths2 := add1_no_of_baths2;
		SELF.add1_no_of_partial_baths2 := add1_no_of_partial_baths2;
		SELF.add1_parking_no_of_cars2 := add1_parking_no_of_cars2;
		SELF.bk_flag := bk_flag;
		SELF.add_lres_year_avg := add_lres_year_avg;
		SELF.prop_owner := prop_owner;
		SELF.prop_owned_flag := prop_owned_flag;
		SELF.ssn_priordob := ssn_priordob;
		SELF.ssn_inval := ssn_inval;
		SELF.ssn_deceased := ssn_deceased;
		SELF.ssn_prob := ssn_prob;
		SELF.out_st_i := out_st_i;
		SELF.out_st2 := out_st2;
		SELF.out_st5 := out_st5;
		SELF.out_st6 := out_st6;
		SELF._add1_bestmatch_1pop := _add1_bestmatch_1pop;
		SELF._add1_bestmatch_12pop := _add1_bestmatch_12pop;
		SELF._ams_age := _ams_age;
		SELF._ams_age_lg := _ams_age_lg;
		SELF._ams_income_i := _ams_income_i;
		SELF._ams_college_tier1 := _ams_college_tier1;
		SELF._ams_college_tier2 := _ams_college_tier2;
		SELF._ams_college_tier3 := _ams_college_tier3;
		SELF._ams_college_tier4 := _ams_college_tier4;
		SELF._curadd_avm := _curadd_avm;
		SELF._curadd_assess_amt := _curadd_assess_amt;
		SELF._preadd_assess_amt := _preadd_assess_amt;
		SELF._add1_avm_land_used_sf := _add1_avm_land_used_sf;
		SELF._curadd_assess_amt2 := _curadd_assess_amt2;
		SELF._curadd_assess_amt2_log := _curadd_assess_amt2_log;
		SELF._preadd_assess_amt2 := _preadd_assess_amt2;
		SELF._preadd_assess_amt2_log := _preadd_assess_amt2_log;
		SELF._add1_avm_sales_price := _add1_avm_sales_price;
		SELF._add1_avm_sales_price_log := _add1_avm_sales_price_log;
		SELF._add1_avm_ass_value := _add1_avm_ass_value;
		SELF._add1_avm_ass_value_log := _add1_avm_ass_value_log;
		SELF._add1_avm_med := _add1_avm_med;
		SELF._add1_avm_med_log := _add1_avm_med_log;
		SELF._curadd_avm2 := _curadd_avm2;
		SELF._curadd_avm2_log := _curadd_avm2_log;
		SELF._add1_avm_to_med_ratio := _add1_avm_to_med_ratio;
		SELF._add1_mortgage_convention := _add1_mortgage_convention;
		SELF._add1_building_area_i := _add1_building_area_i;
		SELF._add1_no_of_bedrooms_47 := _add1_no_of_bedrooms_47;
		SELF._add1_no_of_baths_1 := _add1_no_of_baths_1;
		SELF._add1_no_of_baths_2 := _add1_no_of_baths_2;
		SELF._add1_no_of_baths_4plus := _add1_no_of_baths_4plus;
		SELF._add1_no_of_partial_baths_1 := _add1_no_of_partial_baths_1;
		SELF._add1_parking_no_of_cars_1 := _add1_parking_no_of_cars_1;
		SELF._add1_parking_no_of_cars_2 := _add1_parking_no_of_cars_2;
		SELF._add1_parking_no_of_cars_3plus := _add1_parking_no_of_cars_3plus;
		SELF._prop_owned_pur_tot := _prop_owned_pur_tot;
		SELF._prop_owned_pur_tot_log := _prop_owned_pur_tot_log;
		SELF._prop_owned_assess_tot := _prop_owned_assess_tot;
		SELF._prop_owned_assess_tot_log := _prop_owned_assess_tot_log;
		SELF._prop_owned_assess_cnt := _prop_owned_assess_cnt;
		SELF._prop_sold_pur_tot := _prop_sold_pur_tot;
		SELF._prop_sold_pur_tot_log := _prop_sold_pur_tot_log;
		SELF._attr_num_watercraft60 := _attr_num_watercraft60;
		SELF._watercraft_count := _watercraft_count;
		SELF._waterccraft_sum := _waterccraft_sum;
		SELF._wealth_index6 := _wealth_index6;
		SELF._wealth_index5 := _wealth_index5;
		SELF._wealth_index4 := _wealth_index4;
		SELF._wealth_index23 := _wealth_index23;
		SELF._wealth_index1 := _wealth_index1;
		SELF.avm_pop := avm_pop;
		SELF._add1_building_area_i_m_c46 := _add1_building_area_i_m_c46;
		SELF.mod_avm_logincome02_c45_b1_1 := mod_avm_logincome02_c45_b1_1;
		SELF.mod_avm_logincome02 := mod_avm_logincome02;
		SELF._inferred_age3 := _inferred_age3;
		SELF._prof_license_category5 := _prof_license_category5;
		SELF._prof_license_category4 := _prof_license_category4;
		SELF._prof_license_category1 := _prof_license_category1;
		SELF._attr_num_nonderogs := _attr_num_nonderogs;
		SELF._add1_lres := _add1_lres;
		SELF._add_lres_year_avg := _add_lres_year_avg;
		SELF._addrs_per_adl := _addrs_per_adl;
		SELF._phones_per_adl := _phones_per_adl;
		SELF._adls_per_addr := _adls_per_addr;
		SELF._ssn_issue7yr := _ssn_issue7yr;
		SELF._source_count := _source_count;
		SELF._ams_income_i_m := _ams_income_i_m;
		SELF._prop_owned_assess_cnt_m := _prop_owned_assess_cnt_m;
		SELF.prop_owner_m := prop_owner_m;
		SELF._waterccraft_sum_m := _waterccraft_sum_m;
		SELF._add1_lres_m := _add1_lres_m;
		SELF._add_lres_year_avg_m := _add_lres_year_avg_m;
		SELF._adls_per_addr_m := _adls_per_addr_m;
		SELF._inferred_age3_m := _inferred_age3_m;
		SELF.logincome := logincome;
		SELF.estincome_raw := estincome_raw;
		SELF.estincome_raw_c := estincome_raw_c;
		SELF.estincome_raw_c_srt := estincome_raw_c_srt;
		SELF.tot_num_derog := tot_num_derog;
		SELF.tot_num_derog_m := tot_num_derog_m;
		SELF.bk_disposed_lvl := bk_disposed_lvl;
		SELF.bk_disposed_lvl_m := bk_disposed_lvl_m;
		SELF.felony_flag := felony_flag;
		SELF.attr_arrests_f := attr_arrests_f;
		SELF.verx_lvl2 := verx_lvl2;
		SELF.verx_lvl2_m := verx_lvl2_m;
		SELF.prof_lic_lvl := prof_lic_lvl;
		SELF.prof_lic_lvl_m := prof_lic_lvl_m;
		SELF.college_lvl := college_lvl;
		SELF.college_lvl_m := college_lvl_m;
		SELF.ssns_per_adl_5_v2 := ssns_per_adl_5_v2;
		SELF.ssns_per_adl_5_v2_m := ssns_per_adl_5_v2_m;
		SELF.liens_sc_lvl := liens_sc_lvl;
		SELF.liens_sc_lvl_m := liens_sc_lvl_m;
		SELF.liens_released_lvl := liens_released_lvl;
		SELF.liens_unreleased_lvl := liens_unreleased_lvl;
		SELF.liens_lvl := liens_lvl;
		SELF.liens_lvl_v2 := liens_lvl_v2;
		SELF.liens_lvl_v2_m := liens_lvl_v2_m;
		SELF.addr_stability_m := addr_stability_m;
		SELF.tot_prop_lvl := tot_prop_lvl;
		SELF.tot_prop_lvl_m := tot_prop_lvl_m;
		SELF.current_own_vehicle_f := current_own_vehicle_f;
		SELF.any_atfault_accident := any_atfault_accident;
		SELF.rel_within25_lvl := rel_within25_lvl;
		SELF.rel_within25_lvl_m := rel_within25_lvl_m;
		SELF.rel_ageunder20_lvl := rel_ageunder20_lvl;
		SELF.rel_ageunder20_lvl_m := rel_ageunder20_lvl_m;
		SELF.avm_value_increase := avm_value_increase;
		SELF.avm_value_increase_m := avm_value_increase_m;
		SELF.starting_equity_tax := starting_equity_tax;
		SELF.starting_tax_equity_lvl := starting_tax_equity_lvl;
		SELF.starting_tax_equity_lvl_m := starting_tax_equity_lvl_m;
		SELF.avm_index_geo12 := avm_index_geo12;
		SELF.avm_index_geo12_lvl := avm_index_geo12_lvl;
		SELF.avm_index_geo12_lvl_m := avm_index_geo12_lvl_m;
		SELF.add1_mortgage_date2 := add1_mortgage_date2;
		SELF.years_add1_mortgage_date := years_add1_mortgage_date;
		SELF.yrs_since_mtg := yrs_since_mtg;
		SELF.yrs_since_mtg_m := yrs_since_mtg_m;
		SELF.c_robbery_c := c_robbery_c;
		SELF.c_robbery_srt := c_robbery_srt;
		SELF.c_easiqlife_lvl := c_easiqlife_lvl;
		SELF.c_easiqlife_lvl_m := c_easiqlife_lvl_m;
		SELF.c_born_usa_c := c_born_usa_c;
		SELF.c_born_usa_srt := c_born_usa_srt;
		SELF.c_many_cars_c := c_many_cars_c;
		SELF.c_span_lang_c := c_span_lang_c;
		SELF.c_civ_emp_c := c_civ_emp_c;
		SELF.rsn1010_log := rsn1010_log;
		SELF.base := base;
		SELF.odds := odds;
		SELF.point := point;
		SELF.phat := phat;
		SELF.rsn1010_1_0_2 := rsn1010_1_0_2;
		SELF.rsn1010_1_0_1 := rsn1010_1_0_1;
		SELF.scored_222s := scored_222s;
		SELF.rsn1010_1_0 := rsn1010_1_0;
		
		SELF.seq := (STRING)le.seq;

		SELF.clam := le;
	#else
		SELF.recover_score := INTFORMAT(rsn1010_1_0, 3, 1);
		SELF.seq := (STRING)le.seq;
	#end
	END;

	model := JOIN(clam, EASI.Key_Easi_Census, 
					KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
					doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(1));
  
	RETURN(UNGROUP(model));
END;
