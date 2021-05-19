import risk_indicators, ut, easi, std, _Control;
onThor := _Control.Environment.OnThor;

export IEN1006_0_1( grouped dataset(risk_indicators.layout_boca_shell) clam, dataset(easi.layout_census) census ) := FUNCTION

	IE_DEBUG := false;

	#if(IE_DEBUG)
		layout_debug := record
			String c_med_hval;
			String c_easiqlife;
			String c_rest_indx;
			String c_pop_35_44_p;
			String c_child;
			String c_highinc;
			String c_hval_400k_p;
			String c_cpiall;
			String util_add2_firstseen_list;
			String adl_category;
			String out_unit_desig;
			String out_sec_range;
			String out_addr_type;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String rc_dwelltype;
			String rc_bansflag;
			String rc_sources;
			Integer rc_disthphoneaddr;
			Boolean rc_fnamessnmatch;
			Integer V_count;
			Integer adl_eq_first_seen;
			Integer adl_en_first_seen;
			Integer adl_TU_first_seen;
			Integer adl_DL_first_seen;
			Integer adl_PR_first_seen;
			Integer adl_V_first_seen;
			Integer adl_EM_first_seen;
			Integer adl_VO_first_seen;
			Integer adl_EM_only_first_seen;
			Integer adl_W_first_seen;
			Integer adl_TU_last_seen;
			Integer age;
			String util_adl_type_list;
			String util_adl_first_seen_list;
			String util_add1_type_list;
			String util_add1_first_seen_list;
			Integer util_add1_nap;
			String util_add2_type_list;
			Integer add1_unit_count;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Integer add1_naprop;
			String add1_mortgage_type;
			Integer property_sold_assessed_total;
			Integer dist_a1toa2;
			Integer dist_a1toa3;
			Integer dist_a2toa3;
			Integer gong_did_phone_ct;
			Integer addrs_per_adl;
			Integer attr_num_watercraft60;
			Boolean Bankrupt;
			Integer date_last_seen;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_unrel_cj_last_seen;
			Integer rel_bankrupt_count;
			Integer rel_felony_total;
			Integer rel_prop_owned_purchase_total;
			Integer rel_prop_owned_assessed_total;
			Integer rel_prop_owned_assessed_count;
			Integer rel_prop_sold_assessed_total;
			Integer rel_incomeunder100_count;
			Integer rel_incomeover100_count;
			Integer rel_homeunder100_count;
			Integer rel_homeunder300_count;
			Integer rel_homeunder500_count;
			Integer rel_educationunder8_count;
			Integer rel_educationunder12_count;
			Integer rel_educationover12_count;
			Integer rel_count_addr;
			Integer historical_count;
			String ams_college_code;
			String prof_license_category;
			String wealth_index;
			Integer archive_date;
			Integer pk_wealth_index;
			Real pk_wealth_index_m;
			Boolean source_tot_DA;
			Boolean source_tot_CG;
			Boolean source_tot_P;
			Boolean source_tot_BA;
			Boolean source_tot_AM;
			Boolean add_apt;
			Integer adl_category_ord;
			Boolean bk_flag;
			Integer pk_bk_level;
			Integer add1_avm_med;
			Integer age_rcd;
			Integer add1_mortgage_type_ord;
			Real prof_license_category_ord;
			Integer add1_avm_automated_valuation_rcd;
			Integer attr_num_watercraft60_cap;
			Integer gong_did_phone_ct_cap;
			Integer ams_college_code_mis;
			Integer ams_college_code_cm;
			Integer unit5;
			Real unit5_low_cm;
			Integer pk_dist_a1toa2;
			Integer pk_dist_a1toa3;
			Integer pk_dist_a2toa3;
			Integer pk_rc_disthphoneaddr;
			Real Dist_mod;
			Integer sysdate;
			Integer date_last_seen2;
			Real years_date_last_seen;
			Real months_date_last_seen;
			Integer liens_unrel_cj_last_seen2;
			Real years_liens_unrel_cj_last_seen;
			Real months_liens_unrel_cj_last_seen;
			Integer adl_tu_last_seen2;
			Real years_adl_tu_last_seen;
			Real months_adl_tu_last_seen;
			Integer adl_tu_first_seen2;
			Real years_adl_tu_first_seen;
			Real months_adl_tu_first_seen;
			Integer adl_eq_first_seen2;
			Real years_adl_eq_first_seen;
			Real months_adl_eq_first_seen;
			Integer adl_en_first_seen2;
			Real years_adl_en_first_seen;
			Real months_adl_en_first_seen;
			Integer adl_dl_first_seen2;
			Real years_adl_dl_first_seen;
			Real months_adl_dl_first_seen;
			Integer adl_pr_first_seen2;
			Real years_adl_pr_first_seen;
			Real months_adl_pr_first_seen;
			Integer adl_v_first_seen2;
			Real years_adl_v_first_seen;
			Real months_adl_v_first_seen;
			Integer adl_em_first_seen2;
			Real years_adl_em_first_seen;
			Real months_adl_em_first_seen;
			Integer adl_vo_first_seen2;
			Real years_adl_vo_first_seen;
			Real months_adl_vo_first_seen;
			Integer adl_em_only_first_seen2;
			Real years_adl_em_only_first_seen;
			Real months_adl_em_only_first_seen;
			Integer adl_w_first_seen2;
			Real years_adl_w_first_seen;
			Real months_adl_w_first_seen;
			Integer pk_yr_date_last_seen;
			Integer pk_bk_yr_date_last_seen;
			Real pk_bk_yr_date_last_seen_m1;
			Integer pk_yr_liens_unrel_cj_last_seen;
			Integer pk2_yr_liens_unrel_cj_last_seen;
			Real wealth_index_low_cm;
			Integer add1_avm_automated_val_cap500k;
			Real months_adl_first_seen_max;
			Real months_adl_first_seen_max_mm;
			Integer c_med_hval_med;
			Integer c_med_hval_med2;
			Integer c_easiqlife_med;
			Integer c_easiqlife_med2;
			Integer c_rest_indx_med;
			Integer c_rest_indx_med2;
			Real c_pop_35_44_p_med;
			Real c_pop_35_44_p_med2;
			Real c_child_med;
			Real c_child_med2;
			Real c_highinc_med;
			Integer c_highinc_mw;
			Real c_highinc_mw_cm;
			Real c_hval_400k_p_med;
			Integer c_hval_400k_p_mw;
			Real c_cpiall_med;
			Integer c_cpiall_mw;
			Real c_cpiall_mw_cm;
			Real census_mod;
			Integer rel_bankrupt_count_mw_b2;
			Integer rel_bankrupt_count_mw;
			Real rel_bankrupt_count_mw_cm;
			Integer rel_felony_total_mw_b2;
			Integer rel_felony_total_mw;
			Real rel_felony_total_mw_cm;
			Integer rel_prop_owned_purch_total_mw_b2;
			Integer rel_prop_owned_purch_total_mw;
			Real rel_prop_owned_purch_total_mw_cm;
			Integer rel_prop_owned_assessed_tot_mw_b2;
			Integer rel_prop_owned_assessed_tot_mw;
			Real rel_prop_owned_assd_tot_mw_cm;
			Integer rel_prop_owned_assd_count_cap6;
			Integer rel_prop_sold_assd_tot_bound;
			Integer rel_prop_sold_assd_tot_mw;
			Integer rel_incomeunder100_count_cap6;
			Real rel_incomeunder100_count_cap6_cm;
			Integer rel_incomeover100_count_cap6;
			Real rel_incomeover100_count_cap6_cm;
			Integer rel_homeunder100_count_mw_b2;
			Integer rel_homeunder100_count_mw;
			Real rel_homeunder100_count_mw_cm;
			Integer rel_homeunder300_count_cap8;
			Integer rel_homeunder500_count_cap6;
			Real rel_educ_med_ord_b1_c2_b1;
			Real rel_educ_med_ord_b1_c2_b2;
			Real rel_educ_med_ord_b1;
			Real rel_educ_med_ord_b2_c2_b1;
			Real rel_educ_med_ord_b2_c2_b2;
			Real rel_educ_med_ord_b2;
			Real rel_educ_med_ord;
			Real rel_count_addr_cap8;
			Real rel_count_addr_cap8_cm;
			Real relative_mod;
			Real hist_vehicle_count_cap16;
			Integer util_add1_nap_mw;
			Real util_add1_nap_mw_cm;
			Integer years_util_adl_Z_firstseen;
			Integer years_util_adl_z_frstsn_mw;
			Real years_util_adl_z_frstsn_mw_cm;
			Integer years_util_add1_F_firstseen;
			Integer util_add1_i;
			Integer years_util_add1_Z_firstseen;
			Integer years_util_add1_f_frstsn_mw;
			Real years_util_add1_f_frstsn_mw_cm;
			Integer years_util_add1_z_frstsn_mw;
			Real years_util_add1_z_frstsn_mw_cm;
			Integer years_util_add2_A_firstseen;
			Integer years_util_add2_C_firstseen;
			Integer years_util_add2_D_firstseen;
			Integer years_util_add2_E_firstseen;
			Integer years_util_add2_F_firstseen;
			Integer years_util_add2_G_firstseen;
			Integer years_util_add2_H_firstseen;
			Integer years_util_add2_I_firstseen;
			Integer years_util_add2_L_firstseen;
			Integer years_util_add2_N_firstseen;
			Integer years_util_add2_O_firstseen;
			Integer years_util_add2_P_firstseen;
			Integer years_util_add2_S_firstseen;
			Integer years_util_add2_T_firstseen;
			Integer years_util_add2_U_firstseen;
			Integer years_util_add2_V_firstseen;
			Integer years_util_add2_W_firstseen;
			Integer years_util_add2_Z_firstseen;
			Integer max_years_util_add2_firstseen;
			Integer max_years_util_add2_frstsn_mw;
			Real max_years_util_add2_frstsn_mw_cm;
			// Real utility_mod;
			Integer v_count_mw;
			Real v_count_mw_cm;
			Integer years_adl_tu_frst_sn_mw;
			Real years_adl_tu_frst_sn_mw_cm;
			Integer years_adl_tu_lst_sn_mw;
			Real years_adl_tu_lst_sn_mw_cm;
			Real predicted_inc_high;
			Real predicted_inc_low;
			Real pred_inc;
			Integer estimated_income;
			Integer estimated_income_2;
			risk_indicators.layout_boca_shell clam;
		end;
		layout_debug doModel(risk_indicators.layout_boca_shell le, easi.layout_census ri) := TRANSFORM
	#else
		risk_indicators.layout_boca_shell doModel(risk_indicators.layout_boca_shell le, easi.layout_census ri) := TRANSFORM
	#end

		c_med_hval                       := ri.med_hval;
		c_easiqlife                      := ri.easiqlife;
		c_rest_indx                      := ri.rest_indx;
		c_pop_35_44_p                    := ri.pop_35_44_p;
		c_child                          := ri.child;
		c_highinc                        := ri.highinc;
		c_hval_400k_p                    := ri.hval_400k_p;
		c_cpiall                         := ri.cpiall;
		util_add2_firstseen_list         := le.utility.utili_addr2_dt_first_seen;
		adl_category                     := le.adlcategory;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		v_count                          := le.source_verification.v_count;
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
		adl_tu_last_seen                 := le.source_verification.adl_tu_last_seen;
		age                              := le.name_verification.age;
		util_adl_type_list               := le.utility.utili_adl_type;
		util_adl_first_seen_list         := le.utility.utili_adl_dt_first_seen;
		util_add1_type_list              := le.utility.utili_addr1_type;
		util_add1_first_seen_list        := le.utility.utili_addr1_dt_first_seen;
		util_add1_nap                    := le.utility.utili_addr1_nap;
		util_add2_type_list              := le.utility.utili_addr2_type;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		attr_num_watercraft60            := le.watercraft.watercraft_count60;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
		rel_felony_total                 := le.relatives.relative_felony_total;
		rel_prop_owned_purchase_total    := le.relatives.owned.relatives_property_owned_purchase_total;
		rel_prop_owned_assessed_total    := le.relatives.owned.relatives_property_owned_assessed_total;
		rel_prop_owned_assessed_count    := le.relatives.owned.relatives_property_owned_assessed_count;
		rel_prop_sold_assessed_total     := le.relatives.sold.relatives_property_owned_assessed_total;
		rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
		rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
		rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
		rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
		rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
		rel_educationunder8_count        := le.relatives.relative_educationunder8_count;
		rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
		rel_educationover12_count        := le.relatives.relative_educationover12_count;
		rel_count_addr                   := le.relatives.relatives_at_input_address;
		historical_count                 := le.vehicles.historical_count;
		ams_college_code                 := le.student.college_code;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		archive_date                     := le.historydate;





		NULL := -999999999;


		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

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

		models.common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool');
		models.common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool');
		models.common.findw(rc_sources, 'P',  ' ,', 'I', source_tot_P,  'bool');
		models.common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool');
		models.common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool');

		add_apt := ((StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A') or ((StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H') or ((out_unit_desig != ' ') or (out_sec_range != ' '))));

		adl_category_ord := (integer)(adl_category = '1 DEAD');

		bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));

		pk_bk_level :=  map(bankrupt             => 2,
							(integer)bk_flag = 1 => 1,
													0);

		add1_avm_med :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
							 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
													   add1_avm_med_fips);

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

		add1_avm_automated_valuation_rcd :=  if(add1_avm_automated_valuation = 0, 150000, add1_avm_automated_valuation);

		attr_num_watercraft60_cap :=  if(attr_num_watercraft60 > 2, 2, attr_num_watercraft60);

		gong_did_phone_ct_cap :=  if(gong_did_phone_ct > 6, 6, gong_did_phone_ct);

		ams_college_code_mis := (integer)(trim(ams_college_code)='');

		ams_college_code_cm :=  map((integer)ams_college_code = 2 => 38463,
									(integer)ams_college_code = 4 => 49756,
																	 43256);

		unit5 :=  if(add1_unit_count = 0, 4, min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5));

		unit5_low_cm :=  map(unit5 = 1 => 43185.658209,
							 unit5 = 2 => 44688.949879,
							 unit5 = 3 => 40885.865365,
							 unit5 = 4 => 38566.974311,
							 unit5 = 5 => 36986.1468,
										  42201.406844);

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

		Dist_mod := 53000 +
			(pk_dist_a1toa2 * 2742.75338) +
			(pk_dist_a1toa3 * 2773.73056) +
			(pk_dist_a2toa3 * 2915.40756) +
			(pk_rc_disthphoneaddr * 4620.15356);

		sysdate :=  map(trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01')),
						length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																			   NULL);


		mk_min_date( string type_list, string FS_list, string picker ) := FUNCTION
			z := models.common.zip2( type_list, fs_list )( (StringLib.StringFind(str1, picker, 1) > 0) );
			as_sas := project( z, transform( {integer8 dt}, self.dt := models.common.sas_date( left.str2 )));
			good_dates := as_sas( dt != models.common.NULL );
			yrs := (sysdate-min(good_dates,dt))/365.25;
			
			// output(z,named('z'),overwrite);
			// output(as_sas,named('as_sas'),overwrite);
			// output(good_dates,named('good_dates'),overwrite);
			// output(yrs,named('yrs'),overwrite);
			// this function only used within this model for getting years, so do the sysdate diff and division here
			return if( exists(good_dates), yrs, models.common.NULL );
		end;

		date_last_seen2 := models.common.sas_date((string)date_last_seen);
		years_date_last_seen := if(NULL=date_last_seen2, NULL, ((sysdate - date_last_seen2) / 365.25));
		months_date_last_seen := if(NULL=date_last_seen2, NULL, ((sysdate - date_last_seen2) / 30.5));

		liens_unrel_cj_last_seen2 := models.common.sas_date((string)liens_unrel_cj_last_seen);
		years_liens_unrel_cj_last_seen := if(NULL=liens_unrel_cj_last_seen2, NULL, ((sysdate - liens_unrel_cj_last_seen2) / 365.25));
		months_liens_unrel_cj_last_seen := if(NULL=liens_unrel_cj_last_seen2, NULL, ((sysdate - liens_unrel_cj_last_seen2) / 30.5));

		adl_tu_last_seen2 := models.common.sas_date((string)adl_tu_last_seen);
		years_adl_tu_last_seen := if(NULL=adl_tu_last_seen2, NULL, ((sysdate - adl_tu_last_seen2) / 365.25));
		months_adl_tu_last_seen := if(NULL=adl_tu_last_seen2, NULL, ((sysdate - adl_tu_last_seen2) / 30.5));

		adl_tu_first_seen2 := models.common.sas_date((string)adl_tu_first_seen);
		years_adl_tu_first_seen := if(NULL=adl_tu_first_seen2, NULL, ((sysdate - adl_tu_first_seen2) / 365.25));
		months_adl_tu_first_seen := if(NULL=adl_tu_first_seen2, NULL, ((sysdate - adl_tu_first_seen2) / 30.5));

		adl_eq_first_seen2 := models.common.sas_date((string)adl_eq_first_seen);
		years_adl_eq_first_seen := if(NULL=adl_eq_first_seen2, NULL, ((sysdate - adl_eq_first_seen2) / 365.25));
		months_adl_eq_first_seen := if(NULL=adl_eq_first_seen2, NULL, ((sysdate - adl_eq_first_seen2) / 30.5));

		adl_en_first_seen2 := models.common.sas_date((string)adl_en_first_seen);
		years_adl_en_first_seen := if(NULL=adl_en_first_seen2, NULL, ((sysdate - adl_en_first_seen2) / 365.25));
		months_adl_en_first_seen := if(NULL=adl_en_first_seen2, NULL, ((sysdate - adl_en_first_seen2) / 30.5));

		adl_dl_first_seen2 := models.common.sas_date((string)adl_dl_first_seen);
		years_adl_dl_first_seen := if(NULL=adl_dl_first_seen2, NULL, ((sysdate - adl_dl_first_seen2) / 365.25));
		months_adl_dl_first_seen := if(NULL=adl_dl_first_seen2, NULL, ((sysdate - adl_dl_first_seen2) / 30.5));

		adl_pr_first_seen2 := models.common.sas_date((string)adl_pr_first_seen);
		years_adl_pr_first_seen := if(NULL=adl_pr_first_seen2, NULL, ((sysdate - adl_pr_first_seen2) / 365.25));
		months_adl_pr_first_seen := if(NULL=adl_pr_first_seen2, NULL, ((sysdate - adl_pr_first_seen2) / 30.5));

		adl_v_first_seen2 := models.common.sas_date((string)adl_v_first_seen);
		years_adl_v_first_seen := if(NULL=adl_v_first_seen2, NULL, ((sysdate - adl_v_first_seen2) / 365.25));
		months_adl_v_first_seen := if(NULL=adl_v_first_seen2, NULL, ((sysdate - adl_v_first_seen2) / 30.5));

		adl_em_first_seen2 := models.common.sas_date((string)adl_em_first_seen);
		years_adl_em_first_seen := if(NULL=adl_em_first_seen2, NULL, ((sysdate - adl_em_first_seen2) / 365.25));
		months_adl_em_first_seen := if(NULL=adl_em_first_seen2, NULL, ((sysdate - adl_em_first_seen2) / 30.5));

		adl_vo_first_seen2 := models.common.sas_date((string)adl_vo_first_seen);
		years_adl_vo_first_seen := if(NULL=adl_vo_first_seen2, NULL, ((sysdate - adl_vo_first_seen2) / 365.25));
		months_adl_vo_first_seen := if(NULL=adl_vo_first_seen2, NULL, ((sysdate - adl_vo_first_seen2) / 30.5));

		adl_em_only_first_seen2 := models.common.sas_date((string)adl_em_only_first_seen);
		years_adl_em_only_first_seen := if(NULL=adl_em_only_first_seen2, NULL, ((sysdate - adl_em_only_first_seen2) / 365.25));
		months_adl_em_only_first_seen := if(NULL=adl_em_only_first_seen2, NULL, ((sysdate - adl_em_only_first_seen2) / 30.5));

		adl_w_first_seen2 := models.common.sas_date((string)adl_w_first_seen);
		years_adl_w_first_seen := if(NULL=adl_w_first_seen2, NULL, ((sysdate - adl_w_first_seen2) / 365.25));
		months_adl_w_first_seen := if(NULL=adl_w_first_seen2, NULL, ((sysdate - adl_w_first_seen2) / 30.5));



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

		pk_yr_liens_unrel_cj_last_seen := if (years_liens_unrel_cj_last_seen >= 0, roundup(years_liens_unrel_cj_last_seen), truncate(years_liens_unrel_cj_last_seen));

		pk2_yr_liens_unrel_cj_last_seen :=  map((real)pk_yr_liens_unrel_cj_last_seen <= NULL => -1,
												pk_yr_liens_unrel_cj_last_seen <= 3          => 2,
												pk_yr_liens_unrel_cj_last_seen <= 5          => 1,
																								0);

		wealth_index_low_cm :=  map((integer)wealth_index = 1 => 33212.031627,
									(integer)wealth_index = 2 => 36393.231899,
									(integer)wealth_index = 3 => 42237.228243,
									(integer)wealth_index = 4 => 48565.74856,
									(integer)wealth_index = 5 => 52891.310851,
									(integer)wealth_index = 6 => 47359.666667,
																 42201.406844);

		add1_avm_automated_val_cap500k := min(if(add1_avm_automated_valuation_rcd = NULL, -NULL, add1_avm_automated_valuation_rcd), 500000);

		months_adl_first_seen_max := max(months_adl_eq_first_seen, months_adl_en_first_seen, months_adl_tu_first_seen, months_adl_dl_first_seen, months_adl_pr_first_seen, months_adl_v_first_seen, months_adl_em_first_seen, months_adl_vo_first_seen, months_adl_em_only_first_seen, months_adl_w_first_seen);

		months_adl_first_seen_max_mm :=  if(NULL=months_adl_first_seen_max, 241.0245157, months_adl_first_seen_max);

		c_med_hval_med :=  if(trim(c_med_hval)='', 102064, (integer)c_med_hval);

		c_med_hval_med2 :=  if((integer)c_med_hval_med <= 0, 60000, (integer)c_med_hval_med);

		c_easiqlife_med :=  if(trim(c_easiqlife)='', 119, (integer)c_easiqlife);

		c_easiqlife_med2 :=  map((integer)c_easiqlife_med < 0   => 25,
								 (integer)c_easiqlife_med > 200 => 200,
																   (integer)c_easiqlife_med);

		c_rest_indx_med :=  if(trim(c_rest_indx)='', 111, (integer)c_rest_indx);

		c_rest_indx_med2 :=  map((integer)c_rest_indx_med < 0   => 50,
								 (integer)c_rest_indx_med > 200 => 200,
																   (integer)c_rest_indx_med);

		c_pop_35_44_p_med :=  if(''=trim(c_pop_35_44_p), 16.7, (real)c_pop_35_44_p);

		c_pop_35_44_p_med2 :=  map((real)c_pop_35_44_p_med < 0   => 25,
								   (real)c_pop_35_44_p_med > 100 => 100,
																	   (real)c_pop_35_44_p_med);

		c_child_med :=  if(''=trim(c_child), 25.7, (real)c_child);

		c_child_med2 :=  map(c_child_med < 0   => 5,
							c_child_med = 0   => 50,
							c_child_med > 100 => 35,
							c_child_med);

		c_highinc_med :=  if(''=trim(c_highinc), 7.1, (real)c_highinc);

		c_highinc_mw :=  map(c_highinc_med < 0  => 10,
							 c_highinc_med < 1  => 1,
							 c_highinc_med < 2  => 2,
							 c_highinc_med < 3  => 3,
							 c_highinc_med < 4  => 4,
							 c_highinc_med < 5  => 5,
							 c_highinc_med < 7  => 6,
							 c_highinc_med < 10 => 7,
							 c_highinc_med < 15 => 8,
							 c_highinc_med < 20 => 9,
							 c_highinc_med < 30 => 10,
							 c_highinc_med < 50 => 11,
												   12);

		c_highinc_mw_cm :=  map(c_highinc_mw = 1  => 40276.678274,
								c_highinc_mw = 2  => 41914.945616,
								c_highinc_mw = 3  => 43201.604882,
								c_highinc_mw = 4  => 45402.289796,
								c_highinc_mw = 5  => 47592.938042,
								c_highinc_mw = 6  => 50433.083326,
								c_highinc_mw = 7  => 55071.859979,
								c_highinc_mw = 8  => 62609.068761,
								c_highinc_mw = 9  => 70619.355659,
								c_highinc_mw = 10 => 78970.338077,
								c_highinc_mw = 11 => 94754.834525,
								c_highinc_mw = 12 => 115438.93194,
													 58781.734387);

		c_hval_400k_p_med :=  if(''=trim(c_hval_400k_p), 0, (real)c_hval_400k_p);

		c_hval_400k_p_mw :=  map(c_hval_400k_p_med <= 0 => 1,
								 c_hval_400k_p_med < 1  => 2,
								 c_hval_400k_p_med < 2  => 3,
								 c_hval_400k_p_med < 3  => 4,
								 c_hval_400k_p_med < 5  => 5,
								 c_hval_400k_p_med < 10 => 6,
								 c_hval_400k_p_med < 20 => 7,
														   8);

		c_cpiall_med :=  if(''=trim(c_cpiall), 188.7, (real)c_cpiall);

		c_cpiall_mw :=  map(c_cpiall_med < 180 => 1,
							c_cpiall_med < 185 => 2,
							c_cpiall_med < 195 => 3,
							c_cpiall_med < 200 => 4,
														   5);

		c_cpiall_mw_cm :=  map(c_cpiall_mw = 1 => 39687.230797,
							   c_cpiall_mw = 2 => 66398.938653,
							   c_cpiall_mw = 3 => 58476.590403,
							   c_cpiall_mw = 4 => 56790.836123,
							   c_cpiall_mw = 5 => 93206.670732,
												  58781.734387);

		census_mod := -18862 +
			((real)c_med_hval_med2 * 0.12308) +
			(c_highinc_mw_cm * 0.38906) +
			((real)c_easiqlife_med2 * 175.01545) +
			(c_hval_400k_p_mw * 1536.03676) +
			(c_cpiall_mw_cm * 0.36053) +
			((real)c_rest_indx_med2 * -65.45577) +
			(c_child_med2 * -371.56552) +
			(c_pop_35_44_p_med2 * 623.53626);

		rel_bankrupt_count_mw_b2 := map(rel_bankrupt_count = 0  => 0,
										rel_bankrupt_count = 1  => 1,
										rel_bankrupt_count = 2  => 2,
										rel_bankrupt_count <= 5 => 3,
																   4);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_bankrupt_count_mw := if((integer)missing(rel_bankrupt_count) = 1, -1, rel_bankrupt_count_mw_b2);
		rel_bankrupt_count_mw := rel_bankrupt_count_mw_b2;

		rel_bankrupt_count_mw_cm :=  map(rel_bankrupt_count_mw = 0 => 63716.374592,
										 rel_bankrupt_count_mw = 1 => 56463.696606,
										 rel_bankrupt_count_mw = 2 => 53057.50042,
										 rel_bankrupt_count_mw = 3 => 51332.690368,
										 rel_bankrupt_count_mw = 4 => 49120.07325,
																	  58777.640647);

		rel_felony_total_mw_b2 := map(rel_felony_total = 0  => 0,
									  rel_felony_total = 1  => 1,
									  rel_felony_total = 2  => 2,
									  rel_felony_total <= 7 => 3,
															   4);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_felony_total_mw := if((integer)missing(rel_felony_total) = 1, -1, rel_felony_total_mw_b2);
		rel_felony_total_mw := rel_felony_total_mw_b2;

		rel_felony_total_mw_cm :=  map(rel_felony_total_mw = 0 => 61650.264042,
									   rel_felony_total_mw = 1 => 49034.094216,
									   rel_felony_total_mw = 2 => 46635.707576,
									   rel_felony_total_mw = 3 => 44785.240734,
									   rel_felony_total_mw = 4 => 43086.76045,
																  58777.640647);

		rel_prop_owned_purch_total_mw_b2 := map(rel_prop_owned_purchase_total = 0       => 1,
												rel_prop_owned_purchase_total < 50000   => 0,
												rel_prop_owned_purchase_total < 100000  => 1,
												rel_prop_owned_purchase_total < 150000  => 2,
												rel_prop_owned_purchase_total < 200000  => 3,
												rel_prop_owned_purchase_total < 300000  => 4,
												rel_prop_owned_purchase_total < 400000  => 5,
												rel_prop_owned_purchase_total < 500000  => 6,
												rel_prop_owned_purchase_total < 1000000 => 7,
																						   8);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_prop_owned_purch_total_mw := if((integer)missing(rel_prop_owned_purchase_total) = 1, -1, rel_prop_owned_purch_total_mw_b2);
		rel_prop_owned_purch_total_mw := rel_prop_owned_purch_total_mw_b2;

		rel_prop_owned_purch_total_mw_cm :=  map(rel_prop_owned_purch_total_mw = 0 => 50478.555616,
												 rel_prop_owned_purch_total_mw = 1 => 52578.920586,
												 rel_prop_owned_purch_total_mw = 2 => 56708.615385,
												 rel_prop_owned_purch_total_mw = 3 => 61344.977857,
												 rel_prop_owned_purch_total_mw = 4 => 65218.385761,
												 rel_prop_owned_purch_total_mw = 5 => 71923.373235,
												 rel_prop_owned_purch_total_mw = 6 => 77967.632287,
												 rel_prop_owned_purch_total_mw = 7 => 86519.89517,
												 rel_prop_owned_purch_total_mw = 8 => 99724.956782,
																					  58777.640647);

		rel_prop_owned_assessed_tot_mw_b2 := map(rel_prop_owned_assessed_total = 0       => 2,
												 rel_prop_owned_assessed_total < 50000   => 0,
												 rel_prop_owned_assessed_total < 100000  => 1,
												 rel_prop_owned_assessed_total < 150000  => 2,
												 rel_prop_owned_assessed_total < 200000  => 3,
												 rel_prop_owned_assessed_total < 300000  => 4,
												 rel_prop_owned_assessed_total < 400000  => 5,
												 rel_prop_owned_assessed_total < 500000  => 6,
												 rel_prop_owned_assessed_total < 1000000 => 7,
																							8);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_prop_owned_assessed_tot_mw := if((integer)missing(rel_prop_owned_assessed_total) = 1, -1, rel_prop_owned_assessed_tot_mw_b2);
		rel_prop_owned_assessed_tot_mw := rel_prop_owned_assessed_tot_mw_b2;

		rel_prop_owned_assd_tot_mw_cm :=  map(rel_prop_owned_assessed_tot_mw = 0 => 42837.542703,
											  rel_prop_owned_assessed_tot_mw = 1 => 43992.553733,
											  rel_prop_owned_assessed_tot_mw = 2 => 49377.386857,
											  rel_prop_owned_assessed_tot_mw = 3 => 53898.932596,
											  rel_prop_owned_assessed_tot_mw = 4 => 59167.034064,
											  rel_prop_owned_assessed_tot_mw = 5 => 66469.973513,
											  rel_prop_owned_assessed_tot_mw = 6 => 72559.955184,
											  rel_prop_owned_assessed_tot_mw = 7 => 80995.777937,
											  rel_prop_owned_assessed_tot_mw = 8 => 97261.280892,
																					58777.640647);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_prop_owned_assd_count_cap6 :=  if((integer)missing(rel_prop_owned_assessed_count) = 1, -1, min(if(rel_prop_owned_assessed_count = NULL, -NULL, rel_prop_owned_assessed_count), 6));
		rel_prop_owned_assd_count_cap6 :=  min(if(rel_prop_owned_assessed_count = NULL, -NULL, rel_prop_owned_assessed_count), 6);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_prop_sold_assd_tot_bound :=  map((integer)missing(rel_prop_sold_assessed_total) = 1 => 58778,
		rel_prop_sold_assd_tot_bound :=  map(rel_prop_sold_assessed_total = 0                   => 50000,
																								  min(if(rel_prop_sold_assessed_total = NULL, -NULL, rel_prop_sold_assessed_total), 3000000));

		rel_prop_sold_assd_tot_mw :=  map(rel_prop_sold_assd_tot_bound < 50000   => 0,
										  rel_prop_sold_assd_tot_bound < 100000  => 1,
										  rel_prop_sold_assd_tot_bound < 150000  => 2,
										  rel_prop_sold_assd_tot_bound < 200000  => 3,
										  rel_prop_sold_assd_tot_bound < 300000  => 4,
										  rel_prop_sold_assd_tot_bound < 400000  => 5,
										  rel_prop_sold_assd_tot_bound < 500000  => 6,
										  rel_prop_sold_assd_tot_bound < 1000000 => 7,
																					8);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_incomeunder100_count_cap6 :=  if((integer)missing(rel_incomeunder100_count) = 1, -1, min(if(rel_incomeunder100_count = NULL, -NULL, rel_incomeunder100_count), 6));
		rel_incomeunder100_count_cap6 :=  min(if(rel_incomeunder100_count = NULL, -NULL, rel_incomeunder100_count), 6);

		rel_incomeunder100_count_cap6_cm :=  map(rel_incomeunder100_count_cap6 = 0 => 52686.036541,
												 rel_incomeunder100_count_cap6 = 1 => 70055.010021,
												 rel_incomeunder100_count_cap6 = 2 => 76394.846703,
												 rel_incomeunder100_count_cap6 = 3 => 81973.405059,
												 rel_incomeunder100_count_cap6 = 4 => 84295.533847,
												 rel_incomeunder100_count_cap6 = 5 => 84890.370605,
												 rel_incomeunder100_count_cap6 = 6 => 90839.794255,
																					  58777.640647);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_incomeover100_count_cap6 :=  if((integer)missing(rel_incomeover100_count) = 1, -1, min(if(rel_incomeover100_count = NULL, -NULL, rel_incomeover100_count), 6));
		rel_incomeover100_count_cap6 :=  min(if(rel_incomeover100_count = NULL, -NULL, rel_incomeover100_count), 6);

		rel_incomeover100_count_cap6_cm :=  map(rel_incomeover100_count_cap6 = 0 => 55218.167566,
												rel_incomeover100_count_cap6 = 1 => 80681.25992,
												rel_incomeover100_count_cap6 = 2 => 91015.384257,
												rel_incomeover100_count_cap6 = 3 => 100849.90784,
												rel_incomeover100_count_cap6 = 4 => 103407.33992,
												rel_incomeover100_count_cap6 = 5 => 107492.79185,
												rel_incomeover100_count_cap6 = 6 => 112848.86725,
																					58777.640647);

		rel_homeunder100_count_mw_b2 := map((12 <= rel_homeunder100_count) AND (rel_homeunder100_count <= 19) => 12,
											rel_homeunder100_count >= 20                                      => 8,
																												 rel_homeunder100_count);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_homeunder100_count_mw := if((integer)missing(rel_homeunder100_count) = 1, -1, rel_homeunder100_count_mw_b2);
		rel_homeunder100_count_mw := rel_homeunder100_count_mw_b2;

		rel_homeunder100_count_mw_cm :=  map(rel_homeunder100_count_mw = 0  => 73633.332871,
											 rel_homeunder100_count_mw = 1  => 65068.890249,
											 rel_homeunder100_count_mw = 2  => 59518.694658,
											 rel_homeunder100_count_mw = 3  => 56145.272309,
											 rel_homeunder100_count_mw = 4  => 53203.505213,
											 rel_homeunder100_count_mw = 5  => 51505.165975,
											 rel_homeunder100_count_mw = 6  => 50283.925141,
											 rel_homeunder100_count_mw = 7  => 49651.991664,
											 rel_homeunder100_count_mw = 8  => 48269.020731,
											 rel_homeunder100_count_mw = 9  => 47684.530235,
											 rel_homeunder100_count_mw = 10 => 46886.054808,
											 rel_homeunder100_count_mw = 11 => 46515.10816,
											 rel_homeunder100_count_mw = 12 => 45679.866168,
																			   58777.640647);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_homeunder300_count_cap8 :=  if((integer)missing(rel_homeunder300_count) = 1, -1, min(if(rel_homeunder300_count = NULL, -NULL, rel_homeunder300_count), 8));
		rel_homeunder300_count_cap8 := min(if(rel_homeunder300_count = NULL, -NULL, rel_homeunder300_count), 8);

		// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
		// rel_homeunder500_count_cap6 :=  if((integer)missing(rel_homeunder500_count) = 1, -1, min(if(rel_homeunder500_count = NULL, -NULL, rel_homeunder500_count), 6));
		rel_homeunder500_count_cap6 :=  min(if(rel_homeunder500_count = NULL, -NULL, rel_homeunder500_count), 6);

		rel_educ_med_ord_b1_c2_b1 := if(rel_educationover12_count <= 0, 12.3, 14.3);

		rel_educ_med_ord_b1_c2_b2 := if(rel_educationover12_count <= 0, 9.3, 11.4);

		rel_educ_med_ord_b1 := if(rel_educationunder12_count <= 0, rel_educ_med_ord_b1_c2_b1, rel_educ_med_ord_b1_c2_b2);

		rel_educ_med_ord_b2_c2_b1 := if(rel_educationover12_count <= 0, 10.4, 14.3);

		rel_educ_med_ord_b2_c2_b2 := if(rel_educationover12_count <= 0, 9.1, 11.3);

		rel_educ_med_ord_b2 := if(rel_educationunder12_count <= 0, rel_educ_med_ord_b2_c2_b1, rel_educ_med_ord_b2_c2_b2);

		rel_educ_med_ord := if(rel_educationunder8_count <= 2, rel_educ_med_ord_b1, rel_educ_med_ord_b2);

		rel_count_addr_cap8 :=  map(rel_count_addr = 0  => 5.1,
									rel_count_addr >= 8 => 8,
														   rel_count_addr);

		rel_count_addr_cap8_cm :=  map((integer)rel_count_addr_cap8 = 1 => 61960.350186,
									   (integer)rel_count_addr_cap8 = 2 => 59543.023052,
									   (integer)rel_count_addr_cap8 = 3 => 59474.728536,
									   (integer)rel_count_addr_cap8 = 4 => 57320.875127,
									   rel_count_addr_cap8          = 5 => 53950.706553,
									   rel_count_addr_cap8          = 5.1 => 53417.087835,
									   (integer)rel_count_addr_cap8 = 6 => 51359.920691,
									   (integer)rel_count_addr_cap8 = 7 => 48429.705998,
									   (integer)rel_count_addr_cap8 = 8 => 44337.464404,
																		   58777.640647);

		relative_mod := -126816 +
			(rel_prop_owned_assd_tot_mw_cm * 0.65694) +
			(rel_incomeover100_count_cap6_cm * 0.27443) +
			(rel_homeunder100_count_mw_cm * 0.31511) +
			(rel_incomeunder100_count_cap6_cm * 0.27531) +
			(rel_homeunder500_count_cap6 * 4491.42393) +
			(rel_educ_med_ord * 1232.99738) +
			(rel_homeunder300_count_cap8 * 1966.04301) +
			(rel_bankrupt_count_mw_cm * 0.36735) +
			(rel_prop_owned_assd_count_cap6 * -2067.55235) +
			(rel_count_addr_cap8_cm * 0.45755) +
			(rel_prop_sold_assd_tot_mw * 1847.71499) +
			(rel_prop_owned_purch_total_mw_cm * 0.21349) +
			(rel_felony_total_mw_cm * 0.27197);

		hist_vehicle_count_cap16 :=  map(historical_count = 0   => 4.5,
										 historical_count >= 16 => 16,
										 historical_count);

		util_add1_nap_mw :=  map(util_add1_nap = 6           => 1,
								 util_add1_nap in [10, 3, 2] => 2,
								 util_add1_nap = 0           => 3,
								 util_add1_nap = 11          => 4,
								 util_add1_nap = 12          => 5,
								 util_add1_nap = 5           => 6,
								 util_add1_nap = 8           => 7,
																99);

		util_add1_nap_mw_cm :=  map(util_add1_nap_mw = 1 => 44577.562031,
									util_add1_nap_mw = 2 => 53739.499409,
									util_add1_nap_mw = 3 => 55100.371304,
									util_add1_nap_mw = 4 => 55508.258578,
									util_add1_nap_mw = 5 => 60097.013221,
									util_add1_nap_mw = 6 => 61246.058806,
									util_add1_nap_mw = 7 => 62494.581516,
															58777.640647);

		years_util_adl_Z_firstseen := mk_min_date(util_adl_type_list, util_adl_first_seen_list, 'Z');

		years_util_adl_z_frstsn_mw :=  map(NULL=years_util_adl_Z_firstseen          => -1,
										   (real)years_util_adl_Z_firstseen < 0.5   => -1,
										   (integer)years_util_adl_Z_firstseen < 1  => 1,
										   (integer)years_util_adl_Z_firstseen < 2  => 2,
										   (integer)years_util_adl_Z_firstseen < 3  => 3,
										   (integer)years_util_adl_Z_firstseen < 10 => 4,
																					   99);

		years_util_adl_z_frstsn_mw_cm :=  map(years_util_adl_z_frstsn_mw = -1 => 56449.593258,
											  years_util_adl_z_frstsn_mw = 1  => 54957.051178,
											  years_util_adl_z_frstsn_mw = 2  => 52966.467441,
											  years_util_adl_z_frstsn_mw = 3  => 58559.559747,
											  years_util_adl_z_frstsn_mw = 4  => 68452.541026,
																				 58777.640647);

		years_util_add1_F_firstseen := mk_min_date(util_add1_type_list, util_add1_first_seen_list, 'F');

		util_add1_i :=  if((integer)contains_i(StringLib.StringToUpperCase(util_add1_type_list), 'I') > 0, 1, 0);

		years_util_add1_Z_firstseen := mk_min_date(util_add1_type_list, util_add1_first_seen_list, 'Z');

		years_util_add1_f_frstsn_mw :=  map(NULL=years_util_add1_F_firstseen          => -1,
											(real)years_util_add1_F_firstseen < 0.5   => 0,
											(integer)years_util_add1_F_firstseen < 1  => 1,
											(integer)years_util_add1_F_firstseen < 2  => 2,
											(integer)years_util_add1_F_firstseen < 3  => 3,
											(integer)years_util_add1_F_firstseen < 5  => 4,
											(integer)years_util_add1_F_firstseen < 10 => 5,
											(integer)years_util_add1_F_firstseen < 20 => 6,
																						 7);

		years_util_add1_f_frstsn_mw_cm :=  map(years_util_add1_f_frstsn_mw = -1 => 59791.174081,
											   years_util_add1_f_frstsn_mw = 0  => 59810.396773,
											   years_util_add1_f_frstsn_mw = 1  => 58041.812706,
											   years_util_add1_f_frstsn_mw = 2  => 54826.888134,
											   years_util_add1_f_frstsn_mw = 3  => 54309.398431,
											   years_util_add1_f_frstsn_mw = 4  => 59090.476712,
											   years_util_add1_f_frstsn_mw = 5  => 53309.299583,
											   years_util_add1_f_frstsn_mw = 6  => 49375.448998,
											   years_util_add1_f_frstsn_mw = 7  => 46926.170047,
																				   58777.640647);

		years_util_add1_z_frstsn_mw :=  map(NULL=years_util_add1_Z_firstseen          => -1,
											(real)years_util_add1_Z_firstseen < 0.5   => 0,
											(integer)years_util_add1_Z_firstseen < 1  => 1,
											(integer)years_util_add1_Z_firstseen < 2  => 2,
											(integer)years_util_add1_Z_firstseen < 3  => 3,
											(integer)years_util_add1_Z_firstseen < 5  => 4,
											(integer)years_util_add1_Z_firstseen < 10 => 5,
																						 -1);

		years_util_add1_z_frstsn_mw_cm :=  map(years_util_add1_z_frstsn_mw = -1 => 56239.474707,
											   years_util_add1_z_frstsn_mw = 0  => 58712.680268,
											   years_util_add1_z_frstsn_mw = 1  => 56022.622631,
											   years_util_add1_z_frstsn_mw = 2  => 53664.651601,
											   years_util_add1_z_frstsn_mw = 3  => 57046.803337,
											   years_util_add1_z_frstsn_mw = 4  => 65401.712438,
											   years_util_add1_z_frstsn_mw = 5  => 69995.871951,
																				   58777.640647);


		years_util_add2_A_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'A');
		years_util_add2_C_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'C');
		years_util_add2_D_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'D');
		years_util_add2_E_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'E');
		years_util_add2_F_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'F');
		years_util_add2_G_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'G');
		years_util_add2_H_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'H');
		years_util_add2_I_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'I');
		years_util_add2_L_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'L');
		years_util_add2_N_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'N');
		years_util_add2_O_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'O');
		years_util_add2_P_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'P');
		years_util_add2_S_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'S');
		years_util_add2_T_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'T');
		years_util_add2_U_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'U');
		years_util_add2_V_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'V');
		years_util_add2_W_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'W');
		years_util_add2_Z_firstseen := mk_min_date(util_add2_type_list, util_add2_firstseen_list, 'Z');


		max_years_util_add2_firstseen := max(years_util_add2_A_firstseen, years_util_add2_C_firstseen, years_util_add2_D_firstseen, years_util_add2_E_firstseen, years_util_add2_F_firstseen, years_util_add2_G_firstseen, years_util_add2_H_firstseen, years_util_add2_I_firstseen, years_util_add2_L_firstseen, years_util_add2_N_firstseen, years_util_add2_O_firstseen, years_util_add2_P_firstseen, years_util_add2_S_firstseen, years_util_add2_T_firstseen, years_util_add2_U_firstseen, years_util_add2_V_firstseen, years_util_add2_W_firstseen, years_util_add2_Z_firstseen);

		max_years_util_add2_frstsn_mw :=  map(NULL=max_years_util_add2_firstseen        => -1,
											  (real)max_years_util_add2_firstseen < 0.5 => 0,
											  max_years_util_add2_firstseen < 1         => 1,
											  max_years_util_add2_firstseen < 2         => 2,
											  max_years_util_add2_firstseen < 3         => 3,
											  max_years_util_add2_firstseen < 5         => 4,
											  max_years_util_add2_firstseen < 10        => 5,
											  max_years_util_add2_firstseen < 30        => 6,
																						   2);

		max_years_util_add2_frstsn_mw_cm :=  map(max_years_util_add2_frstsn_mw = -1 => 57232.565962,
												 max_years_util_add2_frstsn_mw = 0  => 59748.32456,
												 max_years_util_add2_frstsn_mw = 1  => 56197.051575,
												 max_years_util_add2_frstsn_mw = 2  => 54128.707626,
												 max_years_util_add2_frstsn_mw = 3  => 56117.727829,
												 max_years_util_add2_frstsn_mw = 4  => 63895.613092,
												 max_years_util_add2_frstsn_mw = 5  => 59734.86079,
												 max_years_util_add2_frstsn_mw = 6  => 56834.120931,
																					   58777.640647);

		v_count_mw :=  map(v_count = 4  => 3,
						   v_count >= 6 => 3,
										   v_count);

		v_count_mw_cm :=  map(v_count_mw = 0 => 60416.451552,
							  v_count_mw = 1 => 56602.618528,
							  v_count_mw = 2 => 56971.286638,
							  v_count_mw = 3 => 57264.453114,
							  v_count_mw = 5 => 55932.296761,
												58777.640647);

		years_adl_tu_frst_sn_mw :=  map(NULL=years_adl_tu_first_seen          => 3,
										years_adl_tu_first_seen <= 8  => 1,
										years_adl_tu_first_seen <= 10 => 2,
										years_adl_tu_first_seen <= 20 => 3,
										years_adl_tu_first_seen <= 30 => 5,
										years_adl_tu_first_seen <= 50 => 4,
																				  3);

		years_adl_tu_frst_sn_mw_cm :=  map(years_adl_tu_frst_sn_mw = 1 => 44990.463647,
										   years_adl_tu_frst_sn_mw = 2 => 47238.163546,
										   years_adl_tu_frst_sn_mw = 3 => 54199.803541,
										   years_adl_tu_frst_sn_mw = 4 => 63059.728911,
										   years_adl_tu_frst_sn_mw = 5 => 67947.815751,
																		  58777.640647);

		years_adl_tu_lst_sn_mw :=  map(NULL=years_adl_tu_last_seen          => 2,
									   years_adl_tu_last_seen = 0  => 1,
									   years_adl_tu_last_seen < 3  => 3,
									   years_adl_tu_last_seen < 5  => 1,
									   years_adl_tu_last_seen < 10 => 4,
									   years_adl_tu_last_seen < 20 => 5,
									   years_adl_tu_last_seen < 30 => 2,
																			   1);

		years_adl_tu_lst_sn_mw_cm :=  map(years_adl_tu_lst_sn_mw = 1 => 50717.718336,
										  years_adl_tu_lst_sn_mw = 2 => 54201.8345,
										  years_adl_tu_lst_sn_mw = 3 => 59283.862205,
										  years_adl_tu_lst_sn_mw = 4 => 60274.865004,
										  years_adl_tu_lst_sn_mw = 5 => 61386.329192,
																		58777.640647);
			
	predicted_inc_high := -104300 +
                                (pk_wealth_index_m*0.3018) + 
                                (census_mod*0.34664) + 
                                (prof_license_category_ord*5968.10498) + 
                                (relative_mod*0.25832) + 
                                (addrs_per_adl*555.35055) + 
                                (add1_avm_automated_valuation_rcd*0.01408) + 
                                ((integer)source_tot_DA*46545) + 
                                (attr_num_watercraft60_cap*5246.34772) + 
                                (add1_mortgage_type_ord*2388.91416) + 
                                (age_rcd*273.82113) + 
                                (pk_bk_level*-2203.07501) + 
                                ((integer)add_apt*-5731.24364) + 
                                (hist_vehicle_count_cap16*637.25295) + 
                                (v_count_mw_cm*1.08559) + 
                                (gong_did_phone_ct*1042.20255) + 
                                (ADD1_AVM_MED*0.01053) + 
                                ((integer)source_tot_AM*13042) + 
                                (property_sold_assessed_total*0.00417) + 
                                (months_adl_first_seen_max_mm*-22.50492) + 
                                (years_adl_tu_frst_sn_mw_cm*0.18204) + 
                                (ams_college_code_mis*-3387.75886) + 
                                ((integer)source_tot_CG*13424) ;

 
  predicted_inc_low  := -135124 + 
                                (age_rcd*176.78681) + 
                                (census_mod*0.08928) + 
                                (relative_mod*0.16716) + 
                                (hist_vehicle_count_cap16*432.59926) + 
                                (v_count_mw_cm*0.709) + 
                                (years_adl_tu_frst_sn_mw_cm*0.11235) + 
                                (years_adl_tu_lst_sn_mw_cm*0.16549) + 
                                (months_adl_first_seen_max_mm*-18.40731) + 
                                (addrs_per_adl*283.46143) + 
                                (prof_license_category_ord*4518.31168) + 
                                ((integer)source_tot_P*5819.27357) + 
                                (Dist_mod*0.09053) + 
                                (pk_bk_yr_date_last_seen_m1*0.11461) + 
                                (adl_category_ord*-4238.96505) + 
                                ((integer)rc_fnamessnmatch*1335.23383) + 
                                (add1_mortgage_type_ord*931.03845) + 
                                (pk2_yr_liens_unrel_cj_last_seen*-1001.50061) + 
                                (ams_college_code_cm*0.63349) + 
                                (attr_num_watercraft60_cap*4540.16941) + 
                                (add1_avm_automated_val_cap500k*0.03884) + 
                                (unit5_low_cm*0.39555) + 
                                (wealth_index_low_cm*0.46508);		

		pred_inc :=  if((integer)predicted_inc_high < 60000, (predicted_inc_low - 2000), (predicted_inc_high - 2000));

		estimated_income :=  map((integer)pred_inc < 20000  => 19999,
								 (integer)pred_inc > 250000 => 250999,
															   round(pred_inc/1000)*1000);

		estimated_income_2 :=  if((nas_summary <= 4) and ((nap_summary <= 4) and (add1_naprop <= 2)), 0, estimated_income);




		#if(IE_DEBUG)
			self.c_med_hval := c_med_hval;
			self.c_easiqlife := c_easiqlife;
			self.c_rest_indx := c_rest_indx;
			self.c_pop_35_44_p := c_pop_35_44_p;
			self.c_child := c_child;
			self.c_highinc := c_highinc;
			self.c_hval_400k_p := c_hval_400k_p;
			self.c_cpiall := c_cpiall;
			self.util_add2_firstseen_list := util_add2_firstseen_list;
			self.adl_category := adl_category;
			self.out_unit_desig := out_unit_desig;
			self.out_sec_range := out_sec_range;
			self.out_addr_type := out_addr_type;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_bansflag := rc_bansflag;
			self.rc_sources := rc_sources;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.v_count := v_count;
			self.adl_eq_first_seen := adl_eq_first_seen;
			self.adl_en_first_seen := adl_en_first_seen;
			self.adl_tu_first_seen := adl_tu_first_seen;
			self.adl_dl_first_seen := adl_dl_first_seen;
			self.adl_pr_first_seen := adl_pr_first_seen;
			self.adl_v_first_seen := adl_v_first_seen;
			self.adl_em_first_seen := adl_em_first_seen;
			self.adl_vo_first_seen := adl_vo_first_seen;
			self.adl_em_only_first_seen := adl_em_only_first_seen;
			self.adl_w_first_seen := adl_w_first_seen;
			self.adl_tu_last_seen := adl_tu_last_seen;
			self.age := age;
			self.util_adl_type_list := util_adl_type_list;
			self.util_adl_first_seen_list := util_adl_first_seen_list;
			self.util_add1_type_list := util_add1_type_list;
			self.util_add1_first_seen_list := util_add1_first_seen_list;
			self.util_add1_nap := util_add1_nap;
			self.util_add2_type_list := util_add2_type_list;
			self.add1_unit_count := add1_unit_count;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_naprop := add1_naprop;
			self.add1_mortgage_type := add1_mortgage_type;
			self.property_sold_assessed_total := property_sold_assessed_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.addrs_per_adl := addrs_per_adl;
			self.attr_num_watercraft60 := attr_num_watercraft60;
			self.bankrupt := bankrupt;
			self.date_last_seen := date_last_seen;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
			self.rel_bankrupt_count := rel_bankrupt_count;
			self.rel_felony_total := rel_felony_total;
			self.rel_prop_owned_purchase_total := rel_prop_owned_purchase_total;
			self.rel_prop_owned_assessed_total := rel_prop_owned_assessed_total;
			self.rel_prop_owned_assessed_count := rel_prop_owned_assessed_count;
			self.rel_prop_sold_assessed_total := rel_prop_sold_assessed_total;
			self.rel_incomeunder100_count := rel_incomeunder100_count;
			self.rel_incomeover100_count := rel_incomeover100_count;
			self.rel_homeunder100_count := rel_homeunder100_count;
			self.rel_homeunder300_count := rel_homeunder300_count;
			self.rel_homeunder500_count := rel_homeunder500_count;
			self.rel_educationunder8_count := rel_educationunder8_count;
			self.rel_educationunder12_count := rel_educationunder12_count;
			self.rel_educationover12_count := rel_educationover12_count;
			self.rel_count_addr := rel_count_addr;
			self.historical_count := historical_count;
			self.ams_college_code := ams_college_code;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.archive_date := archive_date;
			self.pk_wealth_index := pk_wealth_index;
			self.pk_wealth_index_m := pk_wealth_index_m;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_P := source_tot_P;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_AM := source_tot_AM;
			self.add_apt := add_apt;
			self.adl_category_ord := adl_category_ord;
			self.bk_flag := bk_flag;
			self.pk_bk_level := pk_bk_level;
			self.add1_avm_med := add1_avm_med;
			self.age_rcd := age_rcd;
			self.add1_mortgage_type_ord := add1_mortgage_type_ord;
			self.prof_license_category_ord := prof_license_category_ord;
			self.add1_avm_automated_valuation_rcd := add1_avm_automated_valuation_rcd;
			self.attr_num_watercraft60_cap := attr_num_watercraft60_cap;
			self.gong_did_phone_ct_cap := gong_did_phone_ct_cap;
			self.ams_college_code_mis := ams_college_code_mis;
			self.ams_college_code_cm := ams_college_code_cm;
			self.unit5 := unit5;
			self.unit5_low_cm := unit5_low_cm;
			self.pk_dist_a1toa2 := pk_dist_a1toa2;
			self.pk_dist_a1toa3 := pk_dist_a1toa3;
			self.pk_dist_a2toa3 := pk_dist_a2toa3;
			self.pk_rc_disthphoneaddr := pk_rc_disthphoneaddr;
			self.Dist_mod := Dist_mod;
			self.sysdate := sysdate;
			self.date_last_seen2 := date_last_seen2;
			self.years_date_last_seen := years_date_last_seen;
			self.months_date_last_seen := months_date_last_seen;
			self.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
			self.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
			self.months_liens_unrel_cj_last_seen := months_liens_unrel_cj_last_seen;
			self.adl_tu_last_seen2 := adl_tu_last_seen2;
			self.years_adl_tu_last_seen := years_adl_tu_last_seen;
			self.months_adl_tu_last_seen := months_adl_tu_last_seen;
			self.adl_tu_first_seen2 := adl_tu_first_seen2;
			self.years_adl_tu_first_seen := years_adl_tu_first_seen;
			self.months_adl_tu_first_seen := months_adl_tu_first_seen;
			self.adl_eq_first_seen2 := adl_eq_first_seen2;
			self.years_adl_eq_first_seen := years_adl_eq_first_seen;
			self.months_adl_eq_first_seen := months_adl_eq_first_seen;
			self.adl_en_first_seen2 := adl_en_first_seen2;
			self.years_adl_en_first_seen := years_adl_en_first_seen;
			self.months_adl_en_first_seen := months_adl_en_first_seen;
			self.adl_dl_first_seen2 := adl_dl_first_seen2;
			self.years_adl_dl_first_seen := years_adl_dl_first_seen;
			self.months_adl_dl_first_seen := months_adl_dl_first_seen;
			self.adl_pr_first_seen2 := adl_pr_first_seen2;
			self.years_adl_pr_first_seen := years_adl_pr_first_seen;
			self.months_adl_pr_first_seen := months_adl_pr_first_seen;
			self.adl_v_first_seen2 := adl_v_first_seen2;
			self.years_adl_v_first_seen := years_adl_v_first_seen;
			self.months_adl_v_first_seen := months_adl_v_first_seen;
			self.adl_em_first_seen2 := adl_em_first_seen2;
			self.years_adl_em_first_seen := years_adl_em_first_seen;
			self.months_adl_em_first_seen := months_adl_em_first_seen;
			self.adl_vo_first_seen2 := adl_vo_first_seen2;
			self.years_adl_vo_first_seen := years_adl_vo_first_seen;
			self.months_adl_vo_first_seen := months_adl_vo_first_seen;
			self.adl_em_only_first_seen2 := adl_em_only_first_seen2;
			self.years_adl_em_only_first_seen := years_adl_em_only_first_seen;
			self.months_adl_em_only_first_seen := months_adl_em_only_first_seen;
			self.adl_w_first_seen2 := adl_w_first_seen2;
			self.years_adl_w_first_seen := years_adl_w_first_seen;
			self.months_adl_w_first_seen := months_adl_w_first_seen;
			self.pk_yr_date_last_seen := pk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen := pk_bk_yr_date_last_seen;
			self.pk_bk_yr_date_last_seen_m1 := pk_bk_yr_date_last_seen_m1;
			self.pk_yr_liens_unrel_cj_last_seen := pk_yr_liens_unrel_cj_last_seen;
			self.pk2_yr_liens_unrel_cj_last_seen := pk2_yr_liens_unrel_cj_last_seen;
			self.wealth_index_low_cm := wealth_index_low_cm;
			self.add1_avm_automated_val_cap500k := add1_avm_automated_val_cap500k;
			self.months_adl_first_seen_max := months_adl_first_seen_max;
			self.months_adl_first_seen_max_mm := months_adl_first_seen_max_mm;
			self.c_med_hval_med := c_med_hval_med;
			self.c_med_hval_med2 := c_med_hval_med2;
			self.c_easiqlife_med := c_easiqlife_med;
			self.c_easiqlife_med2 := c_easiqlife_med2;
			self.c_rest_indx_med := c_rest_indx_med;
			self.c_rest_indx_med2 := c_rest_indx_med2;
			self.c_pop_35_44_p_med := c_pop_35_44_p_med;
			self.c_pop_35_44_p_med2 := c_pop_35_44_p_med2;
			self.c_child_med := c_child_med;
			self.c_child_med2 := c_child_med2;
			self.c_highinc_med := c_highinc_med;
			self.c_highinc_mw := c_highinc_mw;
			self.c_highinc_mw_cm := c_highinc_mw_cm;
			self.c_hval_400k_p_med := c_hval_400k_p_med;
			self.c_hval_400k_p_mw := c_hval_400k_p_mw;
			self.c_cpiall_med := c_cpiall_med;
			self.c_cpiall_mw := c_cpiall_mw;
			self.c_cpiall_mw_cm := c_cpiall_mw_cm;
			self.census_mod := census_mod;
			self.rel_bankrupt_count_mw_b2 := rel_bankrupt_count_mw_b2;
			self.rel_bankrupt_count_mw := rel_bankrupt_count_mw;
			self.rel_bankrupt_count_mw_cm := rel_bankrupt_count_mw_cm;
			self.rel_felony_total_mw_b2 := rel_felony_total_mw_b2;
			self.rel_felony_total_mw := rel_felony_total_mw;
			self.rel_felony_total_mw_cm := rel_felony_total_mw_cm;
			self.rel_prop_owned_purch_total_mw_b2 := rel_prop_owned_purch_total_mw_b2;
			self.rel_prop_owned_purch_total_mw := rel_prop_owned_purch_total_mw;
			self.rel_prop_owned_purch_total_mw_cm := rel_prop_owned_purch_total_mw_cm;
			self.rel_prop_owned_assessed_tot_mw_b2 := rel_prop_owned_assessed_tot_mw_b2;
			self.rel_prop_owned_assessed_tot_mw := rel_prop_owned_assessed_tot_mw;
			self.rel_prop_owned_assd_tot_mw_cm := rel_prop_owned_assd_tot_mw_cm;
			self.rel_prop_owned_assd_count_cap6 := rel_prop_owned_assd_count_cap6;
			self.rel_prop_sold_assd_tot_bound := rel_prop_sold_assd_tot_bound;
			self.rel_prop_sold_assd_tot_mw := rel_prop_sold_assd_tot_mw;
			self.rel_incomeunder100_count_cap6 := rel_incomeunder100_count_cap6;
			self.rel_incomeunder100_count_cap6_cm := rel_incomeunder100_count_cap6_cm;
			self.rel_incomeover100_count_cap6 := rel_incomeover100_count_cap6;
			self.rel_incomeover100_count_cap6_cm := rel_incomeover100_count_cap6_cm;
			self.rel_homeunder100_count_mw_b2 := rel_homeunder100_count_mw_b2;
			self.rel_homeunder100_count_mw := rel_homeunder100_count_mw;
			self.rel_homeunder100_count_mw_cm := rel_homeunder100_count_mw_cm;
			self.rel_homeunder300_count_cap8 := rel_homeunder300_count_cap8;
			self.rel_homeunder500_count_cap6 := rel_homeunder500_count_cap6;
			self.rel_educ_med_ord_b1_c2_b1 := rel_educ_med_ord_b1_c2_b1;
			self.rel_educ_med_ord_b1_c2_b2 := rel_educ_med_ord_b1_c2_b2;
			self.rel_educ_med_ord_b1 := rel_educ_med_ord_b1;
			self.rel_educ_med_ord_b2_c2_b1 := rel_educ_med_ord_b2_c2_b1;
			self.rel_educ_med_ord_b2_c2_b2 := rel_educ_med_ord_b2_c2_b2;
			self.rel_educ_med_ord_b2 := rel_educ_med_ord_b2;
			self.rel_educ_med_ord := rel_educ_med_ord;
			self.rel_count_addr_cap8 := rel_count_addr_cap8;
			self.rel_count_addr_cap8_cm := rel_count_addr_cap8_cm;
			self.relative_mod := relative_mod;
			self.hist_vehicle_count_cap16 := hist_vehicle_count_cap16;
			self.util_add1_nap_mw := util_add1_nap_mw;
			self.util_add1_nap_mw_cm := util_add1_nap_mw_cm;
			self.years_util_adl_Z_firstseen := years_util_adl_Z_firstseen;
			self.years_util_adl_z_frstsn_mw := years_util_adl_z_frstsn_mw;
			self.years_util_adl_z_frstsn_mw_cm := years_util_adl_z_frstsn_mw_cm;
			self.years_util_add1_F_firstseen := years_util_add1_F_firstseen;
			self.util_add1_i := util_add1_i;
			self.years_util_add1_Z_firstseen := years_util_add1_Z_firstseen;
			self.years_util_add1_f_frstsn_mw := years_util_add1_f_frstsn_mw;
			self.years_util_add1_f_frstsn_mw_cm := years_util_add1_f_frstsn_mw_cm;
			self.years_util_add1_z_frstsn_mw := years_util_add1_z_frstsn_mw;
			self.years_util_add1_z_frstsn_mw_cm := years_util_add1_z_frstsn_mw_cm;
			self.years_util_add2_A_firstseen := years_util_add2_A_firstseen;
			self.years_util_add2_C_firstseen := years_util_add2_C_firstseen;
			self.years_util_add2_D_firstseen := years_util_add2_D_firstseen;
			self.years_util_add2_E_firstseen := years_util_add2_E_firstseen;
			self.years_util_add2_F_firstseen := years_util_add2_F_firstseen;
			self.years_util_add2_G_firstseen := years_util_add2_G_firstseen;
			self.years_util_add2_H_firstseen := years_util_add2_H_firstseen;
			self.years_util_add2_I_firstseen := years_util_add2_I_firstseen;
			self.years_util_add2_L_firstseen := years_util_add2_L_firstseen;
			self.years_util_add2_N_firstseen := years_util_add2_N_firstseen;
			self.years_util_add2_O_firstseen := years_util_add2_O_firstseen;
			self.years_util_add2_P_firstseen := years_util_add2_P_firstseen;
			self.years_util_add2_S_firstseen := years_util_add2_S_firstseen;
			self.years_util_add2_T_firstseen := years_util_add2_T_firstseen;
			self.years_util_add2_U_firstseen := years_util_add2_U_firstseen;
			self.years_util_add2_V_firstseen := years_util_add2_V_firstseen;
			self.years_util_add2_W_firstseen := years_util_add2_W_firstseen;
			self.years_util_add2_Z_firstseen := years_util_add2_Z_firstseen;
			self.max_years_util_add2_firstseen := max_years_util_add2_firstseen;
			self.max_years_util_add2_frstsn_mw := max_years_util_add2_frstsn_mw;
			self.max_years_util_add2_frstsn_mw_cm := max_years_util_add2_frstsn_mw_cm;
			// self.utility_mod := utility_mod;
			self.v_count_mw := v_count_mw;
			self.v_count_mw_cm := v_count_mw_cm;
			self.years_adl_tu_frst_sn_mw := years_adl_tu_frst_sn_mw;
			self.years_adl_tu_frst_sn_mw_cm := years_adl_tu_frst_sn_mw_cm;
			self.years_adl_tu_lst_sn_mw := years_adl_tu_lst_sn_mw;
			self.years_adl_tu_lst_sn_mw_cm := years_adl_tu_lst_sn_mw_cm;
			self.predicted_inc_high := predicted_inc_high;
			self.predicted_inc_low := predicted_inc_low;
			self.pred_inc := pred_inc;
			self.estimated_income := estimated_income;
			self.estimated_income_2 := estimated_income_2;
			self.clam := le;
		#else
			self.estimated_income := estimated_income_2;
			self := le;
		#end

		end;


	model_roxie := join(clam, census, 
		right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
		doModel(LEFT,RIGHT), left outer, lookup);

	model_thor := join(distribute(clam, hash64(shell_input.st+shell_input.county+shell_input.geo_blk)), distribute(census,hash64(geolink)), 
		right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
		doModel(LEFT,RIGHT), left outer, keep(1), local);
    
  #IF(onThor)
    model := GROUP(model_thor, seq);
  #ELSE
    model := model_roxie;
  #END

	return model;

end;