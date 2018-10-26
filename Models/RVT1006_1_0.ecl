import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

// this model needs to use the original V1 reason code set like 2x69 does, defaulting useRCSetV2 to false
export RVT1006_1_0(grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia=false, boolean useRcSetV2 = false ) := FUNCTION
	RVT_DEBUG := false;

	#if(RVT_DEBUG)
	layout_debug := record
		integer seq;
		Boolean trueDID;
		String adl_category;
		String out_unit_desig;
		String out_sec_range;
		String out_addr_type;
		String in_dob;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String rc_phonevalflag;
		String rc_decsflag;
		Integer rc_ssnlowissue;
		String rc_dwelltype;
		String rc_bansflag;
		String rc_sources;
		Integer rc_disthphoneaddr;
		Boolean rc_fnamessnmatch;
		Integer combo_lnamescore;
		Integer combo_dobscore;
		Integer combo_addrcount;
		Boolean dobpop;
		Boolean lname_eda_sourced;
		Integer Age;
		Boolean add1_isbestmatch;
		Integer add1_unit_count;
		Integer add1_avm_hedonic_valuation;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_automated_valuation_2;
		Integer add1_avm_med_fips;
		Integer add1_avm_med_geo11;
		Integer add1_avm_med_geo12;
		Boolean add1_applicant_owned;
		Boolean add1_occupant_owned;
		Boolean add1_family_owned;
		Integer add1_naprop;
		String add1_mortgage_type;
		Integer PROPERTY_OWNED_TOTAL;
		Integer property_owned_purchase_total;
		Integer property_owned_purchase_count;
		Integer PROPERTY_SOLD_TOTAL;
		Integer property_sold_assessed_total;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer dist_a2toa3;
		Boolean add2_applicant_owned;
		Boolean add2_occupant_owned;
		Boolean add2_family_owned;
		Integer addrs_5yr;
		Integer addrs_10yr;
		Integer gong_did_phone_ct;
		Integer ssns_per_adl;
		Integer addrs_per_adl;
		Integer addrs_per_ssn;
		Integer adls_per_addr;
		Integer ssns_per_adl_c6;
		Integer phones_per_adl_c6;
		Integer impulse_count;
		Integer attr_num_watercraft60;
		Integer attr_total_number_derogs;
		Integer attr_eviction_count60;
		Integer attr_num_nonderogs;
		Integer attr_num_nonderogs90;
		Boolean Bankrupt;
		Integer date_last_seen;
		Integer filing_count;
		Integer bk_recent_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer liens_unrel_cj_ct;
		Integer liens_unrel_cj_last_seen;
		Integer liens_unrel_lt_ct;
		Integer liens_unrel_ot_total_amount;
		Integer liens_unrel_sc_ct;
		Integer criminal_count;
		Integer criminal_last_date;
		Integer felony_count;
		String ams_college_code;
		String ams_income_level_code;
		String ams_college_tier;
		String prof_license_category;
		String wealth_index;
		String input_dob_age;
		String input_dob_match_level;
		Integer inferred_age;
		Integer reported_dob;
		String addr_stability;
		Integer archive_date;
		Integer sysdate;
		Integer dob_score;
		Boolean verlst_s;
		Integer mod1_verx;
		Integer mod1_verx2;
		Real mod1_verx2_m;
		Integer pk_wealth_index;
		Real pk_wealth_index_m;
		Integer wealth_index_cm;
		Boolean source_tot_DA;
		Boolean source_tot_CG;
		Boolean source_tot_P;
		Boolean source_tot_BA;
		Boolean source_tot_AM;
		Boolean source_tot_W;
		Boolean add_apt;
		Boolean bk_flag;
		Integer pk_bk_level;
		Integer add1_avm_med;
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
		Integer date_last_seen2;
		Integer liens_unrel_cj_last_seen2;
		Real years_date_last_seen;
		Real years_liens_unrel_cj_last_seen;
		Integer pk_yr_date_last_seen;
		Integer pk_bk_yr_date_last_seen;
		Real pk_bk_yr_date_last_seen_m1;
		Integer adl_category_ord;
		Integer pk_yr_liens_unrel_cj_last_seen;
		Integer pk2_yr_liens_unrel_cj_last_seen;
		Real predicted_inc_high;
		Real predicted_inc_low;
		Real pred_inc;
		Integer estimated_income;
		Integer mod1_estimated_income;
		Integer mod1_income_lvl;
		Integer mod1_wealth_combo_lvl;
		Real mod1_wealth_combo_lvl_m;
		String curr_owner_lvl;
		String prev_owner_lvl;
		Integer mod1_curr_prev_owner_lvl;
		Real mod1_curr_prev_owner_lvl_m;
		Integer mod1_addr_stability_combo;
		Real mod1_addr_stability_combo_m;
		Integer mod1_add1_hedonic_val;
		Real mod1_add1_hedonic_val_m;
		Integer mod1_ssns_per_adl_lvl;
		Real mod1_ssns_per_adl_lvl_m;
		Integer mod1_adls_per_addr_lvl_b1;
		Integer mod1_adls_per_addr_lvl_b2;
		Integer mod1_adls_per_addr_lvl;
		Real mod1_adls_per_addr_lvl_m;
		Boolean mod1_derog_flag;
		Boolean mod1_prof_lic_or_grad;
		Integer _in_dob;
		Integer _rc_ssnlowissue;
		Integer low_issue_dob_diff;
		Integer _low_issue_dob_diff;
		Integer mod1_low_issue_dob_diff;
		Real VRZN_ISBESTMATCH;
		Integer mod2_derog_diff;
		Real mod2_derog_diff_m;
		Integer _criminal_last_date;
		Integer mos_criminal_last_date;
		Integer mod2_criminal_lvl;
		Real mod2_criminal_lvl_m;
		Integer mod2_unrel_lien_lvl;
		Real mod2_unrel_lien_lvl_m;
		Integer mod2_addr_stability_combo;
		Real mod2_addr_stability_combo_m;
		String curr_owner_lvl_2;
		String prev_owner_lvl_2;
		Integer mod2_curr_prev_owner_lvl;
		Real mod2_curr_prev_owner_lvl_m;
		Integer mod2_add1_hedonic_val;
		Real mod2_add1_hedonic_val_m;
		Real add1_fips_ratio;
		Real add1_fips_ratio_2;
		Integer mod2_add1_fips_ratio_lvl;
		Real mod2_add1_fips_ratio_lvl_m;
		Integer mod2_phones_per_adl_c6_2;
		Real mod2_phones_per_adl_c6_2_m;
		Integer mod2_addrs_per_ssn_3;
		Real mod2_addrs_per_ssn_3_m;
		Integer mod2_adls_per_addr_lvl_b1;
		Integer mod2_adls_per_addr_lvl_b2;
		Integer mod2_adls_per_addr_lvl;
		Real mod2_adls_per_addr_lvl_m;
		Integer _reported_dob;
		Integer reported_age;
		Integer applicant_age;
		Integer mod2_combo_age;
		Real mod2_estimated_income;
		Real mod2_estimated_income_lg;
		Real property_owned_purchase_total_a;
		Real mod2_prop_owned_purch_avg;
		Integer mod2_dist_a1toa2;
		Real mod2_dist_a1toa2_lg;
		Boolean mod2_prof_lic_or_grad;
		Integer _in_dob_2;
		Integer _rc_ssnlowissue_2;
		Integer low_issue_dob_diff_2;
		Integer _low_issue_dob_diff_2;
		Integer mod2_low_issue_dob_diff;
		Real VRZN_NOTBESTMATCH;
		Boolean source_tot_DS;
		Boolean source_tot_BA_2;
		Boolean bk_flag_2;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean lien_flag;
		Boolean ssn_deceased;
		Boolean scored_222s;
		Real phat;
		Integer VRZN_LOG;
		Integer VRZN_CUSTOM_SCORE;
		Integer RVT1006_1_0;
	end;
	layout_debug doModel( clam le ) := TRANSFORM
	#else
	Models.layout_ModelOut doModel( clam le ) := TRANSFORM
	#end

		truedid                          := le.truedid;
		adl_category                     := le.adlcategory;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_lnamescore                 := le.iid.combo_lastscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_addrcount                  := le.iid.combo_addrcount;
		dobpop                           := le.input_validation.dateofbirth;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_avm_hedonic_valuation       := le.avm.input_address_information.avm_hedonic_valuation;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		property_owned_total             := le.address_verification.owned.property_total;
		property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
		property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
		property_sold_total              := le.address_verification.sold.property_total;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		impulse_count                    := le.impulse.count;
		attr_num_watercraft60            := le.watercraft.watercraft_count60;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count60            := le.bjl.eviction_count60;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		ams_college_code                 := le.student.college_code;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_age                    := le.shell_input.age;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		addr_stability                   := le.mobility_indicator;
		archive_date                     := if(le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);

		null := models.common.null;

		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

		sysdate := common.sas_date((string)archive_date);

		dob_score :=  map(combo_dobscore = 255 => 255,
						  combo_dobscore = 100 => 100,
												  0);

		verlst_s := (nas_summary in [2, 5, 7, 8, 9, 11, 12]);

		mod1_verx :=  map(((dobpop and (dob_score = 255)) or not(verlst_s)) and (combo_lnamescore != 100) => 0,
						  (dobpop and (dob_score = 255)) or not(verlst_s)                                 => 1,
						  (dob_score = 100) and (nap_summary > 0)                                         => 4,
						  dob_score = 100                                                                 => 3,
																											 2);

		mod1_verx2 :=  map((mod1_verx = 4) and (nap_summary >= 8) => 5,
						   mod1_verx > 2                          => 4,
						   mod1_verx = 2                          => 3,
						   (mod1_verx = 1) and (nap_summary >= 8) => 2,
						   mod1_verx = 1                          => 1,
																	 0);

		mod1_verx2_m :=  map(mod1_verx2 = 0 => 0.5777777778,
							 mod1_verx2 = 1 => 0.5275035261,
							 mod1_verx2 = 2 => 0.4319526627,
							 mod1_verx2 = 3 => 0.3752913753,
							 mod1_verx2 = 4 => 0.3530701754,
											   0.3038674033);

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

		Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool');
		Common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool');
		Common.findw(rc_sources, 'P', ' ,', 'I', source_tot_P, 'bool');
		Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool');
		Common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool');
		Common.findw(rc_sources, 'W', ' ,', 'I', source_tot_W, 'bool');



		add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

		bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		pk_bk_level :=  map(bankrupt             => 2,
							(integer)bk_flag = 1 => 1,
													0);

		add1_avm_med :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
													   add1_avm_med_fips);

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

		date_last_seen2 :=  map((length(trim((string)date_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[7..8]))) - 1)),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)date_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
								(length(trim((string)date_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)date_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)date_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																							NULL);

		liens_unrel_cj_last_seen2 :=  map((length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 8) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => ((ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + (min(31, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[7..8]))) - 1)),
										  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 6) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)liens_unrel_cj_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
										  (length(trim((string)liens_unrel_cj_last_seen, LEFT, RIGHT)) = 4) and ((trim((string)liens_unrel_cj_last_seen, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim((string)liens_unrel_cj_last_seen, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																														  NULL);

		years_date_last_seen :=  if(((real)sysdate != NULL) and (date_last_seen2 != NULL), ((sysdate - date_last_seen2) / 365.25), NULL);

		years_liens_unrel_cj_last_seen :=  if(((real)sysdate != NULL) and (liens_unrel_cj_last_seen2 != NULL), ((sysdate - liens_unrel_cj_last_seen2) / 365.25), NULL);

		pk_yr_date_last_seen := if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen));

		pk_bk_yr_date_last_seen :=  map((real)pk_yr_date_last_seen = NULL => -1,
										pk_yr_date_last_seen >= 9         => 9,
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

		adl_category_ord := (integer)(adl_category = '1 DEAD');

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

		estimated_income := round(pred_inc/1000)*1000;

		mod1_estimated_income := if ((estimated_income / 1000) >= 0, roundup((estimated_income / 1000)), truncate((estimated_income / 1000)));

		mod1_income_lvl :=  map((integer)estimated_income < 20000 => 0,
								(integer)estimated_income < 25000 => 1,
								(integer)estimated_income < 27500 => 2,
								(integer)estimated_income < 30000 => 3,
								(integer)estimated_income < 32500 => 4,
								(integer)estimated_income < 35000 => 5,
								(integer)estimated_income < 40000 => 6,
								(integer)estimated_income < 55000 => 7,
								(integer)estimated_income < 70000 => 6,
																	 7);

		mod1_wealth_combo_lvl :=  map(wealth_index in ['5', '6']                            => 5,
									  ((integer)wealth_index = 4) or (mod1_income_lvl > 3)  => 4,
									  mod1_income_lvl > 1                                   => 3,
									  (mod1_income_lvl = 0) and ((integer)wealth_index = 0) => 3,
									  (mod1_income_lvl = 1) and ((integer)wealth_index = 0) => 2,
									  (mod1_income_lvl = 1) and ((integer)wealth_index > 1) => 0,
																							   1);

		mod1_wealth_combo_lvl_m :=  map(mod1_wealth_combo_lvl = 0 => 0.6116504854,
										mod1_wealth_combo_lvl = 1 => 0.5610687023,
										mod1_wealth_combo_lvl = 2 => 0.5068493151,
										mod1_wealth_combo_lvl = 3 => 0.4274661509,
										mod1_wealth_combo_lvl = 4 => 0.3396226415,
																	 0.1505376344);

		curr_owner_lvl :=  map(add1_applicant_owned => 'APP',
							   add1_family_owned    => 'FAM',
							   add1_occupant_owned  => 'OCC',
													   'ELS');

		prev_owner_lvl :=  map(add2_applicant_owned => 'APP',
							   add2_family_owned    => 'FAM',
							   add2_occupant_owned  => 'OCC',
													   'ELS');

		mod1_curr_prev_owner_lvl :=  map((curr_owner_lvl = 'APP') and (prev_owner_lvl = 'APP')  => 5,
										 curr_owner_lvl = 'APP'                                 => 4,
										 (curr_owner_lvl = 'FAM') and (prev_owner_lvl != 'APP') => 3,
										 (curr_owner_lvl = 'ELS') and (prev_owner_lvl = 'ELS')  => 1,
										 (curr_owner_lvl = 'OCC') and (prev_owner_lvl = 'ELS')  => 0,
										 (curr_owner_lvl = 'OCC') and (prev_owner_lvl = 'FAM')  => 0,
																								   2);

		mod1_curr_prev_owner_lvl_m :=  map(mod1_curr_prev_owner_lvl = 0 => 0.4855305466,
										   mod1_curr_prev_owner_lvl = 1 => 0.4751984127,
										   mod1_curr_prev_owner_lvl = 2 => 0.4291497976,
										   mod1_curr_prev_owner_lvl = 3 => 0.3043478261,
										   mod1_curr_prev_owner_lvl = 4 => 0.2034883721,
																		   0.1052631579);

		mod1_addr_stability_combo :=  map((addr_stability in ['0', '5', '6']) and (addrs_5yr = 0)       => 4,
										  ((integer)addr_stability = 0) and (addrs_5yr = 1)             => 4,
										  (addr_stability in ['4', '5', '6']) and (addrs_5yr = 1)       => 3,
										  (addr_stability in ['4', '5', '6']) and (addrs_5yr in [2, 3]) => 2,
										  (addr_stability in ['3', '4']) and (addrs_5yr in [0, 1])      => 2,
										  (addr_stability in ['2', '3']) and (addrs_5yr in [2, 3])      => 1,
																										   0);

		mod1_addr_stability_combo_m :=  map(mod1_addr_stability_combo = 0 => 0.5733855186,
											mod1_addr_stability_combo = 1 => 0.4813084112,
											mod1_addr_stability_combo = 2 => 0.3445121951,
											mod1_addr_stability_combo = 3 => 0.2994350282,
																			 0.203030303);

		mod1_add1_hedonic_val :=  map(add1_avm_hedonic_valuation = 0      => 1,
									  add1_avm_hedonic_valuation < 100000 => 0,
									  add1_avm_hedonic_valuation < 200000 => 1,
																			 2);

		mod1_add1_hedonic_val_m :=  map(mod1_add1_hedonic_val = 0 => 0.6422018349,
										mod1_add1_hedonic_val = 1 => 0.4419889503,
																	 0.3191489362);

		mod1_ssns_per_adl_lvl :=  map((ssns_per_adl_c6 > 1) or (ssns_per_adl > 2) => 3,
									  ssns_per_adl_c6 = 1                         => 2,
									  ssns_per_adl = 0                            => 1,
																					 0);

		mod1_ssns_per_adl_lvl_m :=  map(mod1_ssns_per_adl_lvl = 0 => 0.341163311,
										mod1_ssns_per_adl_lvl = 1 => 0.4456521739,
										mod1_ssns_per_adl_lvl = 2 => 0.5264847512,
																	 0.632183908);

		mod1_adls_per_addr_lvl_b1 := map(adls_per_addr = 2   => 7,
										 adls_per_addr < 6   => 6,
										 adls_per_addr <= 10 => 4,
										 adls_per_addr <= 15 => 2,
										 adls_per_addr <= 20 => 1,
																0);

		mod1_adls_per_addr_lvl_b2 := if(adls_per_addr > 0, 3, 5);

		mod1_adls_per_addr_lvl := if(rc_dwelltype = ' ', mod1_adls_per_addr_lvl_b1, mod1_adls_per_addr_lvl_b2);

		mod1_adls_per_addr_lvl_m :=  map(mod1_adls_per_addr_lvl = 0 => 0.6228571429,
										 mod1_adls_per_addr_lvl = 1 => 0.5476190476,
										 mod1_adls_per_addr_lvl = 2 => 0.5121212121,
										 mod1_adls_per_addr_lvl = 3 => 0.4829931973,
										 mod1_adls_per_addr_lvl = 4 => 0.4468085106,
										 mod1_adls_per_addr_lvl = 5 => 0.3341121495,
										 mod1_adls_per_addr_lvl = 6 => 0.2866449511,
																	   0.2469135802);

		mod1_derog_flag := ((attr_eviction_count60 > 0) or ((impulse_count > 0) or ((criminal_count > 0) or (bankrupt or (boolean)liens_unrel_lt_ct))));

		mod1_prof_lic_or_grad := (((integer)prof_license_category >= 1) or ((integer)ams_college_tier >= 1));

		_in_dob := common.sas_date((string)in_dob);

		_rc_ssnlowissue := common.sas_date((string)rc_ssnlowissue);

		low_issue_dob_diff := truncate(((_rc_ssnlowissue - _in_dob) / 365.25));

		// _low_issue_dob_diff :=  map(missing(low_issue_dob_diff) => -2,
		_low_issue_dob_diff :=  map(trim(in_dob)='' or rc_ssnlowissue=0 => -2,
									low_issue_dob_diff < 0      => -1,
																   min(if(low_issue_dob_diff = NULL, -NULL, low_issue_dob_diff), 100));

		mod1_low_issue_dob_diff :=  map(_low_issue_dob_diff = -2 => 30,
										_low_issue_dob_diff = -1 => 5,
																	min(if(max(_low_issue_dob_diff, 1) = NULL, -NULL, max(_low_issue_dob_diff, 1)), 100));

		VRZN_ISBESTMATCH := -6.988643344 +
			(mod1_verx2_m * 3.0654462184) +
			(mod1_wealth_combo_lvl_m * 1.3083023393) +
			(mod1_curr_prev_owner_lvl_m * 2.2008488466) +
			(mod1_addr_stability_combo_m * 2.7976234482) +
			(mod1_add1_hedonic_val_m * 2.6641686045) +
			(mod1_ssns_per_adl_lvl_m * 1.8052741747) +
			(mod1_adls_per_addr_lvl_m * 2.7873174406) +
			((integer)mod1_derog_flag * 0.6224601321) +
			((integer)mod1_prof_lic_or_grad * -1.036356811) +
			(mod1_low_issue_dob_diff * -0.032548813);

		mod2_derog_diff := min(if(max((attr_num_nonderogs - attr_total_number_derogs), -3) = NULL, -NULL, max((attr_num_nonderogs - attr_total_number_derogs), -3)), 5);

		mod2_derog_diff_m :=  map(mod2_derog_diff = -3 => 0.7659574468,
								  mod2_derog_diff = -2 => 0.7586206897,
								  mod2_derog_diff = -1 => 0.6687898089,
								  mod2_derog_diff = 0  => 0.5731292517,
								  mod2_derog_diff = 1  => 0.5819076635,
								  mod2_derog_diff = 2  => 0.4590995561,
								  mod2_derog_diff = 3  => 0.3424170616,
								  mod2_derog_diff = 4  => 0.2714285714,
														  0.1853658537);

		_criminal_last_date := common.sas_date((string)criminal_last_date);

		mos_criminal_last_date := truncate(((sysdate - _criminal_last_date) / (365.25 / 30)));

		mod2_criminal_lvl :=  map(((0 <= mos_criminal_last_date) AND (mos_criminal_last_date <= 6)) or ((criminal_count > 2) or (felony_count > 1)) => 2,
								  criminal_count > 0                                                                                                => 1,
																																					   0);

		mod2_criminal_lvl_m :=  map(mod2_criminal_lvl = 0 => 0.5044466403,
									mod2_criminal_lvl = 1 => 0.7236180905,
															 0.8425925926);

		mod2_unrel_lien_lvl :=  map((liens_unrel_cj_ct > 1) or ((liens_unrel_sc_ct > 0) or (liens_unrel_lt_ct > 0))   => 2,
									(boolean)liens_recent_unreleased_count or (boolean)liens_historical_unreleased_ct => 1,
																														 0);

		mod2_unrel_lien_lvl_m :=  map(mod2_unrel_lien_lvl = 0 => 0.5011939507,
									  mod2_unrel_lien_lvl = 1 => 0.56545961,
																 0.6679841897);

		mod2_addr_stability_combo :=  map(((integer)addr_stability = 6) and (addrs_5yr < 2)              => 4,
										  ((integer)addr_stability = 0) and (addrs_5yr = 1)              => 4,
										  addr_stability in ['5', '6']                                   => 3,
										  ((integer)addr_stability = 0) and (addrs_5yr = 0)              => 3,
										  (addr_stability in ['3', '4']) and (addrs_5yr in [1, 2, 3, 4]) => 2,
										  ((integer)addr_stability < 3) and (addrs_5yr > 5)              => 0,
										  ((integer)addr_stability < 2) and (addrs_5yr = 5)              => 0,
										  ((integer)addr_stability = 2) and (addrs_5yr = 0)              => 0,
																											1);

		mod2_addr_stability_combo_m :=  map(mod2_addr_stability_combo = 0 => 0.6702649657,
											mod2_addr_stability_combo = 1 => 0.5505952381,
											mod2_addr_stability_combo = 2 => 0.4188311688,
											mod2_addr_stability_combo = 3 => 0.3523573201,
																			 0.2854609929);

		curr_owner_lvl_2 :=  map(add1_applicant_owned => 'APP',
								 add1_family_owned    => 'FAM',
								 add1_occupant_owned  => 'OCC',
														 'ELS');

		prev_owner_lvl_2 :=  map(add2_applicant_owned => 'APP',
								 add2_family_owned    => 'FAM',
								 add2_occupant_owned  => 'OCC',
														 'ELS');

		mod2_curr_prev_owner_lvl :=  map(curr_owner_lvl_2 = 'APP'                                  => 5,
										 (curr_owner_lvl_2 = 'OCC') and (prev_owner_lvl_2 = 'APP') => 5,
										 prev_owner_lvl_2 = 'APP'                                  => 4,
										 (curr_owner_lvl_2 = 'FAM') or (prev_owner_lvl_2 = 'FAM')  => 3,
										 prev_owner_lvl_2 = 'OCC'                                  => 2,
										 (curr_owner_lvl_2 = 'ELS') and (prev_owner_lvl_2 = 'ELS') => 1,
																									  0);

		mod2_curr_prev_owner_lvl_m :=  map(mod2_curr_prev_owner_lvl = 0 => 0.5976744186,
										   mod2_curr_prev_owner_lvl = 1 => 0.5495145631,
										   mod2_curr_prev_owner_lvl = 2 => 0.5187457396,
										   mod2_curr_prev_owner_lvl = 3 => 0.4343675418,
										   mod2_curr_prev_owner_lvl = 4 => 0.2780612245,
																		   0.1689189189);

		mod2_add1_hedonic_val :=  map(add1_avm_hedonic_valuation = 0      => 1,
									  add1_avm_hedonic_valuation < 100000 => 0,
									  add1_avm_hedonic_valuation < 200000 => 1,
																			 2);

		mod2_add1_hedonic_val_m :=  map(mod2_add1_hedonic_val = 0 => 0.7183908046,
										mod2_add1_hedonic_val = 1 => 0.5169712794,
																	 0.3946015424);

		add1_fips_ratio :=  if(add1_avm_med_fips > 0, min(if(max(((add1_avm_automated_valuation / add1_avm_med_fips) * 100), (real)1) = NULL, -NULL, max(((add1_avm_automated_valuation / add1_avm_med_fips) * 100), (real)1)), 200), -1);

		add1_fips_ratio_2 :=  if(add1_avm_automated_valuation = 0, -2, add1_fips_ratio);

		mod2_add1_fips_ratio_lvl :=  map(add1_fips_ratio_2 > 140 => 5,
										 add1_fips_ratio_2 > 120 => 4,
										 add1_fips_ratio_2 > 90  => 3,
										 add1_fips_ratio_2 = -2  => 2,
										 add1_fips_ratio_2 > 50  => 1,
																	0);

		mod2_add1_fips_ratio_lvl_m :=  map(mod2_add1_fips_ratio_lvl = 0 => 0.7203389831,
										   mod2_add1_fips_ratio_lvl = 1 => 0.601010101,
										   mod2_add1_fips_ratio_lvl = 2 => 0.5086261981,
										   mod2_add1_fips_ratio_lvl = 3 => 0.4413793103,
										   mod2_add1_fips_ratio_lvl = 4 => 0.3043478261,
																		   0.2777777778);

		mod2_phones_per_adl_c6_2 := min(if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6), 2);

		mod2_phones_per_adl_c6_2_m :=  map(mod2_phones_per_adl_c6_2 = 0 => 0.5447916667,
										   mod2_phones_per_adl_c6_2 = 1 => 0.3998703824,
																		   0.2928571429);

		mod2_addrs_per_ssn_3 := min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 3);

		mod2_addrs_per_ssn_3_m :=  map(mod2_addrs_per_ssn_3 = 0 => 0.4013096352,
									   mod2_addrs_per_ssn_3 = 1 => 0.5322872661,
									   mod2_addrs_per_ssn_3 = 2 => 0.5931271478,
																   0.61756238);

		mod2_adls_per_addr_lvl_b1 := map(adls_per_addr = 2   => 7,
										 adls_per_addr < 6   => 6,
										 adls_per_addr <= 10 => 4,
										 adls_per_addr <= 15 => 2,
										 adls_per_addr <= 20 => 1,
																0);

		mod2_adls_per_addr_lvl_b2 := if(adls_per_addr > 0, 3, 5);

		mod2_adls_per_addr_lvl := if(rc_dwelltype = ' ', mod2_adls_per_addr_lvl_b1, mod2_adls_per_addr_lvl_b2);

		mod2_adls_per_addr_lvl_m :=  map(mod2_adls_per_addr_lvl = 0 => 0.6431095406,
										 mod2_adls_per_addr_lvl = 1 => 0.6715328467,
										 mod2_adls_per_addr_lvl = 2 => 0.60609358,
										 mod2_adls_per_addr_lvl = 3 => 0.5624270712,
										 mod2_adls_per_addr_lvl = 4 => 0.5410138249,
										 mod2_adls_per_addr_lvl = 5 => 0.4844444444,
										 mod2_adls_per_addr_lvl = 6 => 0.4367884961,
																	   0.3526315789);

		_reported_dob := common.sas_date((string)reported_dob);

		reported_age := if(_reported_dob=null, 0, truncate(((sysdate - _reported_dob) / 365.25)));

		applicant_age :=  map((integer)input_dob_age > 0 => (integer)input_dob_age,
							  inferred_age > 0           => inferred_age,
							  reported_age > 0           => reported_age,
															-1);

		mod2_combo_age :=  if(applicant_age = -1, 40, min(if(max(applicant_age, 18) = NULL, -NULL, max(applicant_age, 18)), 75));

		mod2_estimated_income := min(if(max(estimated_income, (real)1) = NULL, -NULL, max(estimated_income, (real)1)), 1000000);

		mod2_estimated_income_lg := ln(mod2_estimated_income);

		property_owned_purchase_total_a :=  if(property_owned_purchase_count > 0, (property_owned_purchase_total / property_owned_purchase_count), -1);

		mod2_prop_owned_purch_avg := max(min(if(property_owned_purchase_total_a = NULL, -NULL, property_owned_purchase_total_a), 1000000), 1);

		mod2_dist_a1toa2 :=  map(dist_a1toa2 = 0    => 200,
								 dist_a1toa2 = 9999 => 1,
													   min(if(max(dist_a1toa2, 1) = NULL, -NULL, max(dist_a1toa2, 1)), 5000));

		mod2_dist_a1toa2_lg := ln(mod2_dist_a1toa2);

		mod2_prof_lic_or_grad := (((integer)prof_license_category >= 1) or ((integer)ams_college_tier >= 1));

		_in_dob_2 := common.sas_date((string)in_dob);

		_rc_ssnlowissue_2 := common.sas_date((string)rc_ssnlowissue);

		low_issue_dob_diff_2 := truncate(((_rc_ssnlowissue_2 - _in_dob_2) / 365.25));

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// _low_issue_dob_diff_2 :=  map(missing(low_issue_dob_diff_2) => -2,
		_low_issue_dob_diff_2 :=  map(trim(in_dob)='' or rc_ssnlowissue=0 => -2,
									  low_issue_dob_diff_2 < 0      => -1,
																	   min(if(low_issue_dob_diff_2 = NULL, -NULL, low_issue_dob_diff_2), 100));

		mod2_low_issue_dob_diff :=  map(_low_issue_dob_diff_2 = -2 => 30,
										_low_issue_dob_diff_2 = -1 => 5,
																	  min(if(max(_low_issue_dob_diff_2, 1) = NULL, -NULL, max(_low_issue_dob_diff_2, 1)), 100));

		VRZN_NOTBESTMATCH := -6.700504805 +
			(mod2_derog_diff_m * 0.5847836561) +
			(mod2_criminal_lvl_m * 3.2737552866) +
			(mod2_unrel_lien_lvl_m * 4.7575957864) +
			(mod2_addr_stability_combo_m * 2.345313258) +
			(mod2_curr_prev_owner_lvl_m * 1.7328613075) +
			(mod2_add1_hedonic_val_m * 1.4190093934) +
			(mod2_add1_fips_ratio_lvl_m * 1.860424277) +
			(mod2_phones_per_adl_c6_2_m * 1.0601082715) +
			(mod2_addrs_per_ssn_3_m * 1.8191544461) +
			(mod2_adls_per_addr_lvl_m * 2.1879961975) +
			(mod2_combo_age * -0.02560919) +
			(mod2_estimated_income_lg * -0.271388676) +
			(mod2_prop_owned_purch_avg * -1.038843E-6) +
			(mod2_dist_a1toa2_lg * -0.035712829) +
			((integer)mod2_prof_lic_or_grad * -0.430214241) +
			(mod2_low_issue_dob_diff * -0.010889287);

		source_tot_DS := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DS', ',') > 0);

		source_tot_BA_2 := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'BA', ',') > 0);

		bk_flag_2 := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA_2 = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);

		lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);

		source_tot_L2 := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'L2', ',') > 0);

		source_tot_LI := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'LI', ',') > 0);

		lien_flag := (((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or (lien_rec_unrel_flag or lien_hist_unrel_flag)));

		ssn_deceased := (((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1));

		scored_222s := ((if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0) or (((90 <= combo_dobscore) AND (combo_dobscore <= 100)) or (((integer)input_dob_match_level >= 7) or (((integer)lien_flag > 0) or ((criminal_count > 0) or (((integer)bk_flag_2 > 0) or (ssn_deceased or truedid)))))));

		base := 690;

		point := -35;

		odds := 1;

		phat :=  map(add1_isbestmatch => (exp(VRZN_ISBESTMATCH) / (1 + exp(VRZN_ISBESTMATCH))),
										 (exp(VRZN_NOTBESTMATCH) / (1 + exp(VRZN_NOTBESTMATCH))));

		VRZN_LOG := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));

		VRZN_CUSTOM_SCORE := max(501, min(900, if(VRZN_LOG = NULL, -NULL, VRZN_LOG)));

		rvt1006_1_0 :=  if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, VRZN_CUSTOM_SCORE);


		self.seq := le.seq;
		
		#if(RVT_DEBUG)
			self.truedid := truedid;
			self.adl_category := adl_category;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_addr_type := out_addr_type;
			self.in_dob := in_dob;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_ssnlowissue := rc_ssnlowissue;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_sources := rc_sources;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_lnamescore := combo_lnamescore;
			self.combo_dobscore := combo_dobscore;
			self.combo_addrcount := combo_addrcount;
			self.dobpop := dobpop;
			self.lname_eda_sourced := lname_eda_sourced;
			self.age := age;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_unit_count := add1_unit_count;
			self.add1_avm_hedonic_valuation := add1_avm_hedonic_valuation;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.add1_mortgage_type := add1_mortgage_type;
			self.property_owned_total := property_owned_total;
			self.property_owned_purchase_total := property_owned_purchase_total;
			self.property_owned_purchase_count := property_owned_purchase_count;
			self.property_sold_total := property_sold_total;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.add2_applicant_owned := add2_applicant_owned;
			self.add2_occupant_owned := add2_occupant_owned;
			self.add2_family_owned := add2_family_owned;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.addrs_per_ssn := addrs_per_ssn;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.phones_per_adl_c6 := phones_per_adl_c6;
			self.impulse_count := impulse_count;
			self.attr_num_watercraft60 := attr_num_watercraft60;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count60 := attr_eviction_count60;
			self.attr_num_nonderogs := attr_num_nonderogs;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.bankrupt := bankrupt;
			self.date_last_seen := date_last_seen;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.criminal_count := criminal_count;
			self.criminal_last_date := criminal_last_date;
			self.felony_count := felony_count;
			self.ams_college_code := ams_college_code;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_age := input_dob_age;
			self.input_dob_match_level := input_dob_match_level;
			self.inferred_age := inferred_age;
			self.reported_dob := reported_dob;
			self.addr_stability := addr_stability;
			self.archive_date := archive_date;

			self.sysdate := sysdate;
			self.dob_score := dob_score;
			self.verlst_s := verlst_s;
			self.mod1_verx := mod1_verx;
			self.mod1_verx2 := mod1_verx2;
			self.mod1_verx2_m := mod1_verx2_m;
			self.pk_wealth_index := pk_wealth_index;
			self.pk_wealth_index_m := pk_wealth_index_m;
			self.wealth_index_cm := wealth_index_cm;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_P := source_tot_P;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_AM := source_tot_AM;
			self.source_tot_W := source_tot_W;
			self.add_apt := add_apt;
			self.bk_flag := bk_flag;
			self.pk_bk_level := pk_bk_level;
			self.add1_avm_med := add1_avm_med;
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
			self.date_last_seen2 := date_last_seen2;
			self.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
			self.years_date_last_seen := years_date_last_seen;
			self.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
			self.pk_yr_date_last_seen := pk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen := pk_bk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen_m1 := pk_bk_yr_date_last_seen_m1;
			self.adl_category_ord := adl_category_ord;
			self.pk_yr_liens_unrel_cj_last_seen := pk_yr_liens_unrel_cj_last_seen;
			self.pk2_yr_liens_unrel_cj_last_seen := pk2_yr_liens_unrel_cj_last_seen;
			self.predicted_inc_high := predicted_inc_high;
			self.predicted_inc_low := predicted_inc_low;
			self.pred_inc := pred_inc;
			self.estimated_income := estimated_income;
			self.mod1_estimated_income := mod1_estimated_income;
			self.mod1_income_lvl := mod1_income_lvl;
			self.mod1_wealth_combo_lvl := mod1_wealth_combo_lvl;
			self.mod1_wealth_combo_lvl_m := mod1_wealth_combo_lvl_m;
			self.curr_owner_lvl := curr_owner_lvl;
			self.prev_owner_lvl := prev_owner_lvl;
			self.mod1_curr_prev_owner_lvl := mod1_curr_prev_owner_lvl;
			self.mod1_curr_prev_owner_lvl_m := mod1_curr_prev_owner_lvl_m;
			self.mod1_addr_stability_combo := mod1_addr_stability_combo;
			self.mod1_addr_stability_combo_m := mod1_addr_stability_combo_m;
			self.mod1_add1_hedonic_val := mod1_add1_hedonic_val;
			self.mod1_add1_hedonic_val_m := mod1_add1_hedonic_val_m;
			self.mod1_ssns_per_adl_lvl := mod1_ssns_per_adl_lvl;
			self.mod1_ssns_per_adl_lvl_m := mod1_ssns_per_adl_lvl_m;
			self.mod1_adls_per_addr_lvl_b1 := mod1_adls_per_addr_lvl_b1;
			self.mod1_adls_per_addr_lvl_b2 := mod1_adls_per_addr_lvl_b2;
			self.mod1_adls_per_addr_lvl := mod1_adls_per_addr_lvl;
			self.mod1_adls_per_addr_lvl_m := mod1_adls_per_addr_lvl_m;
			self.mod1_derog_flag := mod1_derog_flag;
			self.mod1_prof_lic_or_grad := mod1_prof_lic_or_grad;
			self._in_dob := _in_dob;
			self._rc_ssnlowissue := _rc_ssnlowissue;
			self.low_issue_dob_diff := low_issue_dob_diff;
			self._low_issue_dob_diff := _low_issue_dob_diff;
			self.mod1_low_issue_dob_diff := mod1_low_issue_dob_diff;
			self.VRZN_ISBESTMATCH := VRZN_ISBESTMATCH;
			self.mod2_derog_diff := mod2_derog_diff;
			self.mod2_derog_diff_m := mod2_derog_diff_m;
			self._criminal_last_date := _criminal_last_date;
			self.mos_criminal_last_date := mos_criminal_last_date;
			self.mod2_criminal_lvl := mod2_criminal_lvl;
			self.mod2_criminal_lvl_m := mod2_criminal_lvl_m;
			self.mod2_unrel_lien_lvl := mod2_unrel_lien_lvl;
			self.mod2_unrel_lien_lvl_m := mod2_unrel_lien_lvl_m;
			self.mod2_addr_stability_combo := mod2_addr_stability_combo;
			self.mod2_addr_stability_combo_m := mod2_addr_stability_combo_m;
			self.curr_owner_lvl_2 := curr_owner_lvl_2;
			self.prev_owner_lvl_2 := prev_owner_lvl_2;
			self.mod2_curr_prev_owner_lvl := mod2_curr_prev_owner_lvl;
			self.mod2_curr_prev_owner_lvl_m := mod2_curr_prev_owner_lvl_m;
			self.mod2_add1_hedonic_val := mod2_add1_hedonic_val;
			self.mod2_add1_hedonic_val_m := mod2_add1_hedonic_val_m;
			self.add1_fips_ratio := add1_fips_ratio;
			self.add1_fips_ratio_2 := add1_fips_ratio_2;
			self.mod2_add1_fips_ratio_lvl := mod2_add1_fips_ratio_lvl;
			self.mod2_add1_fips_ratio_lvl_m := mod2_add1_fips_ratio_lvl_m;
			self.mod2_phones_per_adl_c6_2 := mod2_phones_per_adl_c6_2;
			self.mod2_phones_per_adl_c6_2_m := mod2_phones_per_adl_c6_2_m;
			self.mod2_addrs_per_ssn_3 := mod2_addrs_per_ssn_3;
			self.mod2_addrs_per_ssn_3_m := mod2_addrs_per_ssn_3_m;
			self.mod2_adls_per_addr_lvl_b1 := mod2_adls_per_addr_lvl_b1;
			self.mod2_adls_per_addr_lvl_b2 := mod2_adls_per_addr_lvl_b2;
			self.mod2_adls_per_addr_lvl := mod2_adls_per_addr_lvl;
			self.mod2_adls_per_addr_lvl_m := mod2_adls_per_addr_lvl_m;
			self._reported_dob := _reported_dob;
			self.reported_age := reported_age;
			self.applicant_age := applicant_age;
			self.mod2_combo_age := mod2_combo_age;
			self.mod2_estimated_income := mod2_estimated_income;
			self.mod2_estimated_income_lg := mod2_estimated_income_lg;
			self.property_owned_purchase_total_a := property_owned_purchase_total_a;
			self.mod2_prop_owned_purch_avg := mod2_prop_owned_purch_avg;
			self.mod2_dist_a1toa2 := mod2_dist_a1toa2;
			self.mod2_dist_a1toa2_lg := mod2_dist_a1toa2_lg;
			self.mod2_prof_lic_or_grad := mod2_prof_lic_or_grad;
			self._in_dob_2 := _in_dob_2;
			self._rc_ssnlowissue_2 := _rc_ssnlowissue_2;
			self.low_issue_dob_diff_2 := low_issue_dob_diff_2;
			self._low_issue_dob_diff_2 := _low_issue_dob_diff_2;
			self.mod2_low_issue_dob_diff := mod2_low_issue_dob_diff;
			self.VRZN_NOTBESTMATCH := VRZN_NOTBESTMATCH;
			self.source_tot_DS := source_tot_DS;
			self.source_tot_BA_2 := source_tot_BA_2;
			self.bk_flag_2 := bk_flag_2;
			self.lien_rec_unrel_flag := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag := lien_hist_unrel_flag;
			self.source_tot_L2 := source_tot_L2;
			self.source_tot_LI := source_tot_LI;
			self.lien_flag := lien_flag;
			self.ssn_deceased := ssn_deceased;
			self.scored_222s := scored_222s;
			self.phat := phat;
			self.VRZN_LOG := VRZN_LOG;
			self.VRZN_CUSTOM_SCORE := VRZN_CUSTOM_SCORE;
			self.rvt1006_1_0 := rvt1006_1_0;
		#else
			inCalif := isCalifornia and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

			riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
			
			self.ri := map(
				riTemp[1].hri <> '00' => riTemp,
				rvt1006_1_0 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
				RiskWise.rvReasonCodes(le, 4, inCalif, useRcSetV2 /*use BS v2 reason codes*/)
			);

			self.score := map(
				riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
				self.ri[1].hri='35' => '000',
				(STRING3)rvt1006_1_0
			);
		#end
	end;
	
	model := project( clam, doModel(left) );

	return model;
	
end;