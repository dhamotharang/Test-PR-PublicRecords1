IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT rva1007_3_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			STRING adl_category;
			STRING out_unit_desig;
			STRING out_sec_range;
			STRING out_addr_type;
			STRING in_dob;
			INTEGER nas_summary;
			INTEGER nap_summary;
			INTEGER did_count;
			STRING rc_hriskphoneflag;
			STRING rc_phonevalflag;
			STRING rc_decsflag;
			STRING rc_dwelltype;
			STRING rc_bansflag;
			STRING rc_sources;
			INTEGER rc_numelever;
			INTEGER rc_disthphoneaddr;
			BOOLEAN rc_fnamessnmatch;
			INTEGER combo_addrcount;
			BOOLEAN lname_eda_sourced;
			INTEGER age;
			INTEGER add1_unit_count;
			INTEGER add1_avm_automated_valuation;
			INTEGER add1_avm_automated_valuation_2;
			INTEGER add1_avm_med_fips;
			INTEGER add1_avm_med_geo11;
			INTEGER add1_avm_med_geo12;
			INTEGER add1_naprop;
			STRING add1_mortgage_type;
			INTEGER property_owned_total;
			INTEGER property_sold_assessed_total;
			INTEGER dist_a1toa2;
			INTEGER dist_a1toa3;
			INTEGER dist_a2toa3;
			BOOLEAN add2_isbestmatch;
			INTEGER add2_avm_automated_valuation;
			INTEGER addrs_10yr;
			INTEGER gong_did_phone_ct;
			INTEGER ssns_per_adl;
			INTEGER addrs_per_adl;
			INTEGER adlperssn_count;
			INTEGER addrs_per_ssn;
			INTEGER adls_per_addr;
			INTEGER ssns_per_adl_c6;
			INTEGER ssns_per_addr_c6;
			INTEGER phones_per_addr_c6;
			INTEGER infutor_nap;
			INTEGER impulse_count;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_num_watercraft60;
			INTEGER attr_num_aircraft;
			INTEGER attr_total_number_derogs;
			INTEGER attr_num_unrel_liens180;
			INTEGER attr_num_unrel_liens24;
			INTEGER attr_bankruptcy_count90;
			INTEGER attr_bankruptcy_count60;
			INTEGER attr_eviction_count;
			INTEGER attr_num_nonderogs;
			INTEGER attr_num_nonderogs90;
			BOOLEAN bankrupt;
			INTEGER date_last_seen;
			STRING disposition;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_recent_released_count;
			INTEGER liens_historical_released_count;
			INTEGER liens_unrel_cj_last_seen;
			INTEGER liens_unrel_ot_total_amount;
			INTEGER watercraft_count;
			STRING ams_college_code;
			STRING ams_income_level_code;
			BOOLEAN prof_license_flag;
			STRING prof_license_category;
			STRING wealth_index;
			STRING addr_stability;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			BOOLEAN source_tot_ba_1;
			BOOLEAN source_tot_ds;
			BOOLEAN source_tot_l2;
			BOOLEAN source_tot_li;
			BOOLEAN lien_rec_unrel_flag;
			BOOLEAN lien_hist_unrel_flag;
			BOOLEAN lien_flag;
			BOOLEAN bk_flag_1;
			BOOLEAN ssn_deceased;
			INTEGER pk_impulse_count_1;
			INTEGER pk_impulse_count;
			INTEGER pk_adl_cat_deceased;
			STRING bs_own_rent;
			INTEGER bs_attr_derog_flag;
			INTEGER bs_attr_eviction_flag;
			INTEGER bs_attr_derog_flag2;
			STRING pk_segment;
			INTEGER unrel_lien_24mo;
			INTEGER unrel_lien_6mo;
			INTEGER tot_un_liens;
			INTEGER tot_rel_liens;
			INTEGER rel_lien_combo;
			INTEGER unrel_lien_combo;
			INTEGER lien_combo;
			REAL lien_combo_m_2;
			INTEGER in_dob2;
			REAL years_in_dob;
			INTEGER years_in_dob1;
			REAL years_in_dob1_m_3;
			BOOLEAN phn_highrisk2;
			REAL phn_highrisk2_l_1;
			INTEGER ssns_per_adl1;
			REAL ssns_per_adl1_m_3;
			INTEGER adlperssn_count1;
			REAL adlperssn_count1_m_3;
			INTEGER addrs_per_ssn1;
			REAL addrs_per_ssn1_m_2;
			INTEGER adls_per_addr1;
			INTEGER ssns_per_addr_c6_cap_1;
			REAL ssns_per_addr_c6_cap_m_3;
			INTEGER phones_per_addr_c6_cap_1;
			REAL phones_per_addr_c6_cap_m_3;
			INTEGER nap_infutor_combo;
			INTEGER nap_infutor_combo1;
			REAL nap_infutor_combo1_m_3;
			INTEGER diff_derog;
			INTEGER diff_derog1;
			REAL diff_derog1_m_3;
			INTEGER ams_4yr_grad;
			INTEGER ams_combo;
			REAL ams_combo_m_3;
			INTEGER addr_stability1;
			REAL addr_stability1_m_3;
			INTEGER pk_wealth_index;
			REAL pk_wealth_index_m;
			INTEGER wealth_index_cm;
			BOOLEAN source_tot_da;
			BOOLEAN source_tot_cg;
			BOOLEAN source_tot_p;
			BOOLEAN source_tot_ba;
			BOOLEAN source_tot_am;
			BOOLEAN source_tot_w;
			BOOLEAN add_apt;
			BOOLEAN bk_flag;
			INTEGER pk_bk_level;
			INTEGER add1_avm_med;
			INTEGER rc_valid_bus_phone;
			INTEGER rc_valid_res_phone;
			INTEGER age_rcd;
			INTEGER add1_mortgage_type_ord;
			REAL prof_license_category_ord;
			INTEGER pk_attr_total_number_derogs_1;
			INTEGER pk_attr_total_number_derogs;
			INTEGER pk_attr_num_nonderogs90_1;
			INTEGER pk_attr_num_nonderogs90;
			INTEGER pk_derog_total;
			INTEGER pk_derog_total_m;
			INTEGER add1_avm_automated_valuation_rcd;
			INTEGER add1_avm_automated_val_2_rcd;
			INTEGER pk_liens_unrel_ot_total_amount;
			INTEGER attr_num_watercraft60_cap;
			INTEGER combo_addrcount_cap;
			INTEGER gong_did_phone_ct_cap;
			INTEGER ams_college_code_mis;
			INTEGER ams_college_code_cm;
			INTEGER ams_income_level_code_cm;
			INTEGER unit5;
			INTEGER pk_dist_a1toa2;
			INTEGER pk_dist_a1toa3;
			INTEGER pk_dist_a2toa3;
			INTEGER pk_rc_disthphoneaddr;
			REAL dist_mod;
			INTEGER date_last_seen2;
			REAL years_date_last_seen;
			INTEGER liens_unrel_cj_last_seen2;
			REAL years_liens_unrel_cj_last_seen;
			INTEGER pk_yr_date_last_seen;
			INTEGER pk_bk_yr_date_last_seen;
			REAL pk_bk_yr_date_last_seen_m1;
			INTEGER adl_category_ord;
			INTEGER pk_yr_liens_unrel_cj_last_seen;
			INTEGER pk2_yr_liens_unrel_cj_last_seen;
			REAL predicted_inc_high;
			REAL predicted_inc_low;
			REAL pred_inc;
			INTEGER estimated_income1_1;
			INTEGER estimated_income1;
			INTEGER estimated_income1_cap;
			INTEGER impulse_flag;
			REAL impulse_flag_200901_l_3;
			INTEGER plane_boat_prof;
			REAL plane_boat_prof_m;
			INTEGER add1_avm_automated_other;
			REAL add1_avm_automated_other_l;
			BOOLEAN verlst_s;
			BOOLEAN veradd_s;
			BOOLEAN verssn_s;
			INTEGER ver_s_other;
			REAL ver_s_other_m;
			INTEGER wealth_index_other;
			REAL wealth_index_other_l;
			REAL logit_3;
			REAL phat_3;
			INTEGER mod1_custom1_3;
			INTEGER mod1_other;
			REAL lien_combo_m_1;
			REAL years_in_dob1_m_2;
			INTEGER ver_s;
			REAL ver_s_m_1;
			INTEGER one_did;
			REAL one_did_m;
			REAL phn_highrisk2_l;
			REAL ssns_per_adl1_m_2;
			REAL adlperssn_count1_m_2;
			INTEGER ssns_per_adl_c6_cap;
			REAL ssns_per_adl_c6_cap_m_2;
			INTEGER ssns_per_addr_c6_cap;
			REAL ssns_per_addr_c6_cap_m_2;
			INTEGER phones_per_addr_c6_cap;
			REAL phones_per_addr_c6_cap_m_2;
			REAL nap_infutor_combo1_m_2;
			REAL diff_derog1_m_2;
			REAL ams_combo_m_2;
			REAL addr_stability1_m_2;
			INTEGER disposition1;
			INTEGER attr_bankruptcy_count601;
			INTEGER attr_bankruptcy_count901;
			INTEGER bankrupt_combo;
			REAL bankrupt_combo_m;
			REAL impulse_flag_200901_l_2;
			INTEGER property_owned_total1;
			INTEGER attr_eviction_count1;
			REAL attr_eviction_count1_l;
			REAL wealth_index_der;
			REAL wealth_index_der_l;
			REAL logit_2;
			REAL phat_2;
			INTEGER mod1_custom1_2;
			INTEGER mod1_derog;
			REAL lien_combo_m;
			REAL years_in_dob1_m_1;
			REAL ver_s_m;
			INTEGER avm_auto_val_current;
			INTEGER avm_auto_val_current1;
			REAL ssns_per_adl1_m_1;
			REAL adlperssn_count1_m_1;
			REAL addrs_per_ssn1_m_1;
			REAL ssns_per_adl_c6_cap_m_1;
			REAL ssns_per_addr_c6_cap_m_1;
			REAL phones_per_addr_c6_cap_m_1;
			REAL nap_infutor_combo1_m_1;
			REAL diff_derog1_m_1;
			REAL ams_combo_m_1;
			REAL wealth_index1;
			REAL wealth_index1_m_1;
			REAL addr_stability1_m_1;
			REAL impulse_flag_200901_l_1;
			INTEGER adls_per_addr_own;
			REAL adls_per_addr_own_m;
			INTEGER watercraft;
			INTEGER aircraft;
			INTEGER plane_boat;
			REAL logit_1;
			REAL phat_1;
			INTEGER mod1_custom1_1;
			INTEGER mod1_owner;
			REAL years_in_dob1_m;
			REAL ssns_per_adl1_m;
			REAL adlperssn_count1_m;
			REAL addrs_per_ssn1_m;
			REAL ssns_per_adl_c6_cap_m;
			REAL ssns_per_addr_c6_cap_m;
			REAL phones_per_addr_c6_cap_m;
			REAL nap_infutor_combo1_m;
			REAL diff_derog1_m;
			REAL ams_combo_m;
			REAL wealth_index1_m;
			REAL addr_stability1_m;
			REAL impulse_flag_200901_l;
			INTEGER rc_numelever_cap;
			INTEGER attr_addrs_last361;
			INTEGER attr_addrs_last241;
			INTEGER attr_addr;
			REAL attr_addr_l;
			INTEGER add1_avm_automated_rent;
			REAL logit;
			REAL phat;
			INTEGER mod1_custom1;
			INTEGER mod1_renter;
			INTEGER rva1007_3_0_float;
			INTEGER rva1007_3_0;
			STRING score;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	adl_category                     := le.adlcategory;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	did_count                        := le.iid.didcount;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_sources                       := le.iid.sources;
	rc_numelever                     := le.iid.numelever;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_fnamessnmatch                 := le.iid.firstssnmatch;
	combo_addrcount                  := le.iid.combo_addrcount;
	lname_eda_sourced                := le.name_verification.lname_eda_sourced;
	age                              := le.name_verification.age;
	add1_unit_count                  := le.address_verification.input_address_information.unit_count;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_watercraft60            := le.watercraft.watercraft_count60;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	bankrupt                         := le.bjl.bankrupt;
	date_last_seen                   := le.bjl.date_last_seen;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.BJL.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.BJL.liens_historical_unreleased_count;
	liens_recent_released_count      := le.BJL.liens_recent_released_count;
	liens_historical_released_count  := le.BJL.liens_historical_released_count;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_college_code                 := le.student.college_code;
	ams_income_level_code            := le.student.income_level_code;
	prof_license_flag                := le.professional_license.professional_license_flag;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	addr_stability                   := le.mobility_indicator;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	sysdate := map(
	    trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
	    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
	                                                           NULL);
	
	source_tot_ba_1 := Models.Common.findw_cpp(rc_sources, 'BA' , ' ,', 'I') > 0;
	
	source_tot_ds := Models.Common.findw_cpp(rc_sources, 'DS' , ' ,', 'I') > 0;
	
	source_tot_l2 := Models.Common.findw_cpp(rc_sources, 'L2' , ' ,', 'I') > 0;
	
	source_tot_li := Models.Common.findw_cpp(rc_sources, 'LI' , ' ,', 'I') > 0;
	
	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;
	
	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;
	
	lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;
	
	bk_flag_1 := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba_1 = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;
	
	ssn_deceased := rc_decsflag = '1' or (integer)source_tot_ds = 1;
	
	pk_impulse_count_1 := impulse_count;
	
	pk_impulse_count := if(pk_impulse_count_1 > 2, 2, pk_impulse_count_1);
	
	pk_adl_cat_deceased := if(trim(adl_category) = '1 DEAD', 1, 0);
	
	bs_own_rent := map(
	    Add1_NaProp = 4 or Property_Owned_Total > 0                         => '1 Owner ',
	    trim(Out_Addr_Type) = 'H' or Add1_NAProp = 1 or Add1_Unit_Count > 3 => '2 Renter',
	                                                                           '3 Other ');
	
	bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);
	
	bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);
	
	bs_attr_derog_flag2 := if(bs_attr_derog_flag > 0 or (integer)lien_flag > 0 or bs_attr_eviction_flag > 0 or pk_impulse_count > 0 or (integer)bk_flag_1 > 0 or pk_adl_cat_deceased > 0 or (integer)ssn_deceased > 0, 1, 0);
	
	pk_segment := if(bs_attr_derog_flag2 = 1, '0 Derog ', bs_own_rent);
	
	unrel_lien_24mo := MAP(attr_num_unrel_liens24 >= 3 => 3,
																												attr_num_unrel_liens24);

	unrel_lien_6mo := MAP(attr_num_unrel_liens180 > 0 => 1,
																												0);

	tot_un_liens := liens_recent_unreleased_count + liens_historical_unreleased_ct;
	
	tot_rel_liens := liens_recent_released_count + liens_historical_released_count;
	
	rel_lien_combo := map(
	    tot_rel_liens > 0 and liens_recent_released_count > 0 => 3,
	    tot_rel_liens > 0                                     => 2,
	                                                             1);
	
	// unrel_lien_combo := MAP(unrel_lien_24mo = 0 												=> 1,
													// unrel_lien_24mo = 1 AND unrel_lien_6mo = 0 	=> 2,
													// unrel_lien_24mo = 1 OR unrel_lien_6mo = 0 	=> 3,
		                                                                     // 4); 
	unrel_lien_combo := MAP((tot_un_liens >= 2 AND liens_recent_unreleased_count >= 2) OR (tot_un_liens = 4 AND liens_recent_unreleased_count >= 1) => 4,
													(tot_un_liens >= 1 AND liens_recent_unreleased_count > 0) OR tot_un_liens >= 3 																					=> 3,
													tot_un_liens > 0																																																				=> 2,
																																																																										1);
	
	lien_combo := map(
	    unrel_lien_combo = 4 and rel_lien_combo = 1                         => 6,
	    unrel_lien_combo = 4                                                => 5,
	    unrel_lien_combo = 3 and rel_lien_combo = 1                         => 4,
	    unrel_lien_combo = 3 or unrel_lien_combo = 2 and rel_lien_combo = 1 => 3,
	    unrel_lien_combo = 1 and rel_lien_combo = 1                         => 1,
	                                                                           2);
	
	lien_combo_m_2 := map(
	    lien_combo = 1 => 0.1208850513,
	    lien_combo = 2 => 0.2820512821,
	                      0.1212235446);
	
	in_dob2 := Common.SAS_Date((STRING)(in_dob));
	
	years_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 365.25);
	
	years_in_dob1 := map(
	    years_in_dob <= 36 => 5,
	    years_in_dob <= 41 => 4,
	    years_in_dob <= 46 => 3,
	    years_in_dob <= 53 => 2,
	                          1);
	
	years_in_dob1_m_3 := map(
	    years_in_dob1 = 1 => 0.0697236181,
	    years_in_dob1 = 2 => 0.0714484292,
	    years_in_dob1 = 3 => 0.0920173024,
	    years_in_dob1 = 4 => 0.1353670162,
	    years_in_dob1 = 5 => 0.1754582342,
	                         0.1212235446);
	
	phn_highrisk2 := not(TRIM(rc_hriskphoneflag) in ['0', '7']);
	
	phn_highrisk2_l_1 := map(
	    (integer)phn_highrisk2 = 0 => 0.0006244456,
	    (integer)phn_highrisk2 = 1 => 0.0014147895,
	                                  0.0004728967);
	
	ssns_per_adl1 := map(
	    ssns_per_adl = 1  => 1,
	    ssns_per_adl <= 2 => 2,
	                         3);
	
	ssns_per_adl1_m_3 := map(
	    ssns_per_adl1 = 1 => 0.1153404873,
	    ssns_per_adl1 = 2 => 0.1366815003,
	    ssns_per_adl1 = 3 => 0.1848184818,
	                         0.1212235446);
	
	adlperssn_count1 := map(
	    adlperssn_count <= 1 => 1,
	    adlperssn_count >= 4 => 4,
	                            adlperssn_count);
	
	adlperssn_count1_m_3 := map(
	    adlperssn_count1 = 1 => 0.1158805288,
	    adlperssn_count1 = 2 => 0.1267754929,
	    adlperssn_count1 = 3 => 0.1326973114,
	    adlperssn_count1 = 4 => 0.1797752809,
	                            0.1212235446);
	
	addrs_per_ssn1 := map(
	    addrs_per_ssn = 0   => 2,
	    addrs_per_ssn <= 3  => 1,
	    addrs_per_ssn <= 6  => 2,
	    addrs_per_ssn <= 8  => 3,
	    addrs_per_ssn <= 12 => 4,
	    addrs_per_ssn <= 15 => 5,
	                           6);
	
	addrs_per_ssn1_m_2 := map(
	    addrs_per_ssn1 = 1 => 0.1014855617,
	    addrs_per_ssn1 = 2 => 0.1253418414,
	    addrs_per_ssn1 = 3 => 0.129389313,
	    addrs_per_ssn1 = 4 => 0.1382045929,
	    addrs_per_ssn1 = 5 => 0.1433333333,
	    addrs_per_ssn1 = 6 => 0.1627296588,
	                          0.1212235446);
	
	adls_per_addr1 := map(
	    adls_per_addr = 0   => 12,
	    adls_per_addr = 1   => 7,
	    adls_per_addr = 2   => 1,
	    adls_per_addr <= 11 => adls_per_addr,
	    adls_per_addr <= 15 => 12,
	                           13);
	
	ssns_per_addr_c6_cap_1 := if(ssns_per_addr_c6 >= 4, 4, ssns_per_addr_c6);
	
	ssns_per_addr_c6_cap_m_3 := map(
	    ssns_per_addr_c6_cap_1 = 0 => 0.1024569124,
	    ssns_per_addr_c6_cap_1 = 1 => 0.1675891759,
	    ssns_per_addr_c6_cap_1 = 2 => 0.1734860884,
	    ssns_per_addr_c6_cap_1 = 3 => 0.1974522293,
	    ssns_per_addr_c6_cap_1 = 4 => 0.2397260274,
	                                  0.1212235446);
	
	phones_per_addr_c6_cap_1 := if(phones_per_addr_c6 >= 2, 2, phones_per_addr_c6);
	
	phones_per_addr_c6_cap_m_3 := map(
	    phones_per_addr_c6_cap_1 = 0 => 0.1196062722,
	    phones_per_addr_c6_cap_1 = 1 => 0.1477597712,
	    phones_per_addr_c6_cap_1 = 2 => 0.1304347826,
	                                    0.1212235446);
	
	nap_infutor_combo := map(
	    nap_summary = 12 and infutor_nap = 0 => 14,
	    nap_summary >= 9 and infutor_nap = 0 => 13,
	                                            nap_summary);
	
	nap_infutor_combo1 := map(
	    nap_infutor_combo = 14                          => 1,
	    nap_infutor_combo = 13                          => 2,
	    nap_infutor_combo = 12 or nap_infutor_combo = 8 => 3,
	    nap_infutor_combo = 9                           => 4,
	    nap_infutor_combo = 1                           => 6,
	                                                       5);
	
	nap_infutor_combo1_m_3 := map(
	    nap_infutor_combo1 = 1 => 0.0366819508,
	    nap_infutor_combo1 = 2 => 0.080306699,
	    nap_infutor_combo1 = 3 => 0.1174923279,
	    nap_infutor_combo1 = 4 => 0.1585760518,
	    nap_infutor_combo1 = 5 => 0.1466765004,
	    nap_infutor_combo1 = 6 => 0.2196078431,
	                              0.1212235446);
	
	diff_derog := attr_num_nonderogs - attr_total_number_derogs;
	
	diff_derog1 := map(
	    diff_derog <= -3 => 0,
	    diff_derog <= -1 => 1,
	    diff_derog = 0   => 2,
	    diff_derog >= 5  => 7,
	                        diff_derog + 2);
	
	diff_derog1_m_3 := map(
	    diff_derog1 = 2 => 0.1714285714,
	    diff_derog1 = 3 => 0.1684108055,
	    diff_derog1 = 4 => 0.1261367464,
	    diff_derog1 = 5 => 0.0967672875,
	    diff_derog1 = 6 => 0.1044591247,
	    diff_derog1 = 7 => 0.0628394104,
	                       0.1212235446);
	
	ams_4yr_grad := if(ams_college_code = '1' or ams_college_code = '4', 1, 0);
	
	ams_combo := map(
	    ams_4yr_grad = 0 and (ams_income_level_code = 'A' or ams_income_level_code = 'B' or ams_income_level_code = 'C')                     => 5,
	    ams_4yr_grad = 0 and (ams_income_level_code = 'D' or ams_income_level_code = 'E')                                                    => 4,
	    ams_4yr_grad = 0 and (ams_income_level_code = 'F' or ams_income_level_code = 'G' or ams_income_level_code = 'H')                     => 3,
	    ams_4yr_grad = 0 or ams_4yr_grad = 1 and (ams_income_level_code = 'B' or ams_income_level_code = 'C' or ams_income_level_code = 'D') => 2,
	                                                                                                                                            1);
	
	ams_combo_m_3 := map(
	    ams_combo = 1 => 0.0546282246,
	    ams_combo = 2 => 0.1189496995,
	    ams_combo = 3 => 0.1321003963,
	    ams_combo = 4 => 0.1721854305,
	    ams_combo = 5 => 0.1821305842,
	                     0.1212235446);
	
	addr_stability1 := map(
	    addr_stability = '0' or addr_stability = '2' or addr_stability = '3' => 3,
	    addr_stability = '1'                                                 => 2,
	                                                                            (INTEGER)addr_stability);
	
	addr_stability1_m_3 := map(
	    addr_stability1 = 2 => 0.2138788193,
	    addr_stability1 = 3 => 0.1420506561,
	    addr_stability1 = 4 => 0.1170072512,
	    addr_stability1 = 5 => 0.0931318681,
	    addr_stability1 = 6 => 0.0624633431,
	                           0.1212235446);
	
	pk_wealth_index := map(
	    wealth_index <= '2' => 0,
	    wealth_index <= '3' => 1,
	    wealth_index <= '4' => 2,
	    wealth_index <= '5' => 3,
	                           4);
	
	pk_wealth_index_m := map(
	    pk_wealth_index = 0 => 39116.676936,
	    pk_wealth_index = 1 => 43449.700792,
	    pk_wealth_index = 2 => 57061.910522,
	    pk_wealth_index = 3 => 82122.972447,
	                           134020.49977);
	
	wealth_index_cm := map(
	    wealth_index = '0' => 35766,
	    wealth_index = '1' => 32220,
	    wealth_index = '2' => 35991,
	    wealth_index = '3' => 39789,
	    wealth_index = '4' => 46630,
	    wealth_index = '5' => 52993,
	    wealth_index = '6' => 55911,
	                          43256);
	
	source_tot_da := Models.Common.findw_cpp(rc_sources, 'DA' , ' ,', 'I') > 0;
	
	source_tot_cg := Models.Common.findw_cpp(rc_sources, 'CG' , ' ,', 'I') > 0;
	
	source_tot_p := Models.Common.findw_cpp(rc_sources, 'P' , ' ,', 'I') > 0;
	
	source_tot_ba := Models.Common.findw_cpp(rc_sources, 'BA' , ' ,', 'I') > 0;
	
	source_tot_am := Models.Common.findw_cpp(rc_sources, 'AM' , ' ,', 'I') > 0;
	
	source_tot_w := Models.Common.findw_cpp(rc_sources, 'W' , ' ,', 'I') > 0;
	
	add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type)) = 'H' or TRIM(out_unit_desig) != ' ' or TRIM(out_sec_range) != '';
	
	bk_flag := (TRIM(rc_bansflag) in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;
	
	pk_bk_level := map(
	    bankrupt             => 2,
	    (integer)bk_flag = 1 => 1,
	                            0);
	
	add1_avm_med := map(
	    ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
	    ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
	                              ADD1_AVM_MED_FIPS);
	
	rc_valid_bus_phone := if(rc_phonevalflag = '1', 1, 0);
	
	rc_valid_res_phone := if(rc_phonevalflag = '2', 1, 0);
	
	age_rcd := map(
	    age < 18 => 35,
	    age > 60 => 35,
	                age);
	
	add1_mortgage_type_ord := map(
	    (TRIM(add1_mortgage_type) in ['FHA'])      					=> 1,
	    (TRIM(add1_mortgage_type) in [''])         					=> 2,
	    (TRIM(add1_mortgage_type) in ['2', 'E', 'N', 'U']) 	=> 4,
																															3);
	
	prof_license_category_ord := map(
	    TRIM(prof_license_category) = '0'   => 1.0,
	    TRIM(prof_license_category) in [''] => 1.5,
	                                           (real)prof_license_category);
	
	pk_attr_total_number_derogs_1 := attr_total_number_derogs;
	
	pk_attr_total_number_derogs := if(pk_attr_total_number_derogs_1 > 3, 3, pk_attr_total_number_derogs_1);
	
	pk_attr_num_nonderogs90_1 := attr_num_nonderogs90;
	
	pk_attr_num_nonderogs90 := if(pk_attr_num_nonderogs90_1 > 4, 4, pk_attr_num_nonderogs90_1);
	
	pk_derog_total := if(pk_attr_total_number_derogs > 0, pk_attr_total_number_derogs, -1 * pk_attr_num_nonderogs90);
	
	pk_derog_total_m := map(
	    pk_derog_total <= -4 => 51961,
	    pk_derog_total <= -3 => 49033,
	    pk_derog_total <= -2 => 45551,
	    pk_derog_total <= -1 => 40287,
	    pk_derog_total <= 0  => 42406,
	    pk_derog_total <= 1  => 40550,
	    pk_derog_total <= 2  => 38539,
	    pk_derog_total <= 3  => 37345,
	                            43256);
	
	add1_avm_automated_valuation_rcd := if(add1_avm_automated_valuation = 0, 150000, add1_avm_automated_valuation);
	
	add1_avm_automated_val_2_rcd := if(add1_avm_automated_valuation_2 = 0, 150000, add1_avm_automated_valuation_2);
	
	pk_liens_unrel_ot_total_amount := map(
	    liens_unrel_ot_total_amount <= 0     => -1,
	    liens_unrel_ot_total_amount <= 10000 => 0,
	                                            1);
	
	attr_num_watercraft60_cap := if(attr_num_watercraft60 > 2, 2, attr_num_watercraft60);
	
	combo_addrcount_cap := if(combo_addrcount > 6, 6, combo_addrcount);
	
	gong_did_phone_ct_cap := if(gong_did_phone_ct > 5, 5, gong_did_phone_ct);
	
	
	// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
	ams_college_code_mis := (integer)(TRIM(ams_college_code) = '');
	
	ams_college_code_cm := map(
	    ams_college_code = '2' => 38463,
	    ams_college_code = '4' => 49756,
	                              43256);
	
	ams_income_level_code_cm := map(
	    TRIM(ams_income_level_code) in ['A', 'B', 'C'] 		=> 38285,
	    TRIM(ams_income_level_code) = 'D'                	=> 39525,
	    TRIM(ams_income_level_code) = 'E'                	=> 42426,
	    TRIM(ams_income_level_code) = 'F'                	=> 44337,
	    TRIM(ams_income_level_code) = 'G'                	=> 46648,
	    TRIM(ams_income_level_code) = 'H'                	=> 48231,
	    TRIM(ams_income_level_code) = 'I'                	=> 49622,
	    TRIM(ams_income_level_code) = 'J'                	=> 52149,
	    TRIM(ams_income_level_code) = 'K'                	=> 53457,
																														43095);
	
	unit5 := if(add1_unit_count = 0, 4, min(if(add1_unit_count = NULL, -NULL, add1_unit_count), 5));
	
	pk_dist_a1toa2 := map(
	    dist_a1toa2 = 9999 => -1,
	    dist_a1toa2 <= 0   => 0,
	    dist_a1toa2 <= 9   => 1,
	                          2);
	
	pk_dist_a1toa3 := map(
	    dist_a1toa3 = 9999 => -1,
	    dist_a1toa3 <= 0   => 0,
	    dist_a1toa3 <= 30  => 1,
	                          2);
	
	pk_dist_a2toa3 := map(
	    dist_a2toa3 = 9999 => -1,
	    dist_a2toa3 <= 0   => 0,
	    dist_a2toa3 <= 9   => 1,
	    dist_a2toa3 <= 35  => 2,
	                          3);
	
	pk_rc_disthphoneaddr := map(
	    rc_disthphoneaddr = 9999 => 0,
	    rc_disthphoneaddr <= 3   => 0,
	    rc_disthphoneaddr <= 6   => 1,
	    rc_disthphoneaddr <= 12  => 2,
	                                3);
	
	dist_mod := 53000 +
	    pk_dist_a1toa2 * 2742.75338 +
	    pk_dist_a1toa3 * 2773.73056 +
	    pk_dist_a2toa3 * 2915.40756 +
	    pk_rc_disthphoneaddr * 4620.15356;
	
	date_last_seen2 := Common.SAS_Date((STRING)(date_last_seen));
	
	years_date_last_seen := if(min(sysdate, date_last_seen2) = NULL, NULL, (sysdate - date_last_seen2) / 365.25);
	
	liens_unrel_cj_last_seen2 := Common.SAS_Date((STRING)(liens_unrel_cj_last_seen));
	
	years_liens_unrel_cj_last_seen := if(min(sysdate, liens_unrel_cj_last_seen2) = NULL, NULL, (sysdate - liens_unrel_cj_last_seen2) / 365.25);
	
	pk_yr_date_last_seen := if (years_date_last_seen >= 0, roundup(years_date_last_seen), truncate(years_date_last_seen));
	
	pk_bk_yr_date_last_seen := map(
	    pk_yr_date_last_seen = NULL => -1,
	    pk_yr_date_last_seen >= 9   => 9,
	                                   pk_yr_date_last_seen);
	
	pk_bk_yr_date_last_seen_m1 := map(
	    pk_bk_yr_date_last_seen = -1 => 65447.971203,
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
	
	adl_category_ord := (integer)(TRIM(adl_category) = '1 DEAD');
	
	pk_yr_liens_unrel_cj_last_seen := if (years_liens_unrel_cj_last_seen >= 0, roundup(years_liens_unrel_cj_last_seen), truncate(years_liens_unrel_cj_last_seen));
	
	pk2_yr_liens_unrel_cj_last_seen := map(
	    pk_yr_liens_unrel_cj_last_seen <= NULL => -1,
	    pk_yr_liens_unrel_cj_last_seen <= 3    => 2,
	    pk_yr_liens_unrel_cj_last_seen <= 5    => 1,
	                                              0);
	
	predicted_inc_high := -28552 +
	    pk_wealth_index_m * 0.51667 +
	    (integer)source_tot_da * 88499 +
	    add1_avm_med * 0.05448 +
	    prof_license_category_ord * 8167.93208 +
	    addrs_per_adl * 855.48025 +
	    pk_derog_total_m * 0.27963 +
	    add1_avm_automated_valuation_rcd * 0.01557 +
	    property_sold_assessed_total * 0.02413 +
	    attr_num_watercraft60_cap * 10490 +
	    age_rcd * 324.98302 +
	    combo_addrcount_cap * -2218.70449 +
	    (integer)add_apt * -6810.8463 +
	    (integer)source_tot_cg * 28047 +
	    (integer)source_tot_w * 6718.13655 +
	    gong_did_phone_ct * 1414.7842 +
	    add1_mortgage_type_ord * 1825.91813 +
	    (integer)source_tot_am * 17169 +
	    rc_valid_bus_phone * 11042 +
	    pk_liens_unrel_ot_total_amount * 7931.02954 +
	    add1_avm_automated_val_2_rcd * 0.00826 +
	    ams_college_code_mis * -5323.07783 +
	    pk_bk_level * -1970.64639;
	
	predicted_inc_low := -45923 +
	    unit5 * -832.87755 +
	    wealth_index_cm * 0.58264 +
	    pk_derog_total_m * 0.09997 +
	    add1_avm_automated_valuation_rcd * 0.045 +
	    addrs_per_adl * 545.9244 +
	    (integer)source_tot_w * 5334.71282 +
	    prof_license_category_ord * 5952.85069 +
	    (integer)source_tot_p * 2443.25461 +
	    dist_mod * 0.14399 +
	    pk_bk_yr_date_last_seen_m1 * 0.09757 +
	    adl_category_ord * -6304.92099 +
	    (integer)rc_fnamessnmatch * 1785.49733 +
	    add1_mortgage_type_ord * 859.15454 +
	    pk2_yr_liens_unrel_cj_last_seen * -803.19148 +
	    ams_college_code_cm * 0.23431 +
	    attr_num_watercraft60_cap * 6294.24356 +
	    rc_valid_res_phone * -2008.73124 +
	    ams_income_level_code_cm * 0.08691 +
	    addrs_10yr * -375.39614 +
	    gong_did_phone_ct_cap * 630.52863 +
	    (integer)source_tot_am * 12757 +
	    (integer)lname_eda_sourced * 1462.6333;
	
	pred_inc := if(predicted_inc_high < 60000, predicted_inc_low - 2000, predicted_inc_high - 2000);
	
	estimated_income1_1 := map(
	    pred_inc < 20000  => 19999,
	    pred_inc > 250000 => 250999,
	                         round(pred_inc/1000)*1000);
	
	estimated_income1 := if(riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 0, estimated_income1_1);
	
	estimated_income1_cap := map(
	    estimated_income1 = 0      => 26000,
	    estimated_income1 >= 43000 => 43000,
	                                  estimated_income1);
	
	impulse_flag := if(impulse_count > 0, 1, 0);
	
	impulse_flag_200901_l_3 := map(
	    impulse_flag = 0 => 0.0004729456,
	    impulse_flag = 1 => 0.1356742648,
	                        0.0004728967);
	
	plane_boat_prof := map(
	    watercraft_count > 1 or attr_num_aircraft > 0 => 1,
	    watercraft_count > 0 or prof_license_flag     => 2,
	                                                     3);
	
	plane_boat_prof_m := map(
	    plane_boat_prof = 1 => 0.0542763158,
	    plane_boat_prof = 2 => 0.0642474717,
	    plane_boat_prof = 3 => 0.1296068796,
	                           0.1212235446);
	
	add1_avm_automated_other := map(
	    add1_avm_automated_valuation = 0       => 2,
	    add1_avm_automated_valuation <= 90000  => 4,
	    add1_avm_automated_valuation <= 175000 => 3,
	    add1_avm_automated_valuation <= 275000 => 2,
	                                              1);
	
	add1_avm_automated_other_l := map(
	    add1_avm_automated_other = 1 => 0.005254438,
	    add1_avm_automated_other = 2 => 0.0005344318,
	    add1_avm_automated_other = 3 => 0.0057753614,
	    add1_avm_automated_other = 4 => 0.0107408307,
	                                    0.0004728967);
	
	verlst_s := (nas_summary in [2, 5, 7, 8, 9, 11, 12]);
	
	veradd_s := (nas_summary in [3, 5, 6, 8, 10, 11, 12]);
	
	verssn_s := (nas_summary in [4, 6, 7, 9, 10, 11, 12]);
	
	ver_s_other := map(
	    verlst_s and verssn_s and veradd_s                                        => 1,
	    verlst_s and verssn_s                                                     => 3,
	    (integer)verlst_s = 0 and (integer)verssn_s = 0 and (integer)veradd_s = 0 => 3,
	                                                                                 2);
	
	ver_s_other_m := map(
	    ver_s_other = 1 => 0.1093008339,
	    ver_s_other = 2 => 0.1145374449,
	    ver_s_other = 3 => 0.1893168605,
	                       0.1212235446);
	
	wealth_index_other := map(
	    wealth_index >= '4' => 1,
	    wealth_index = '0'  => 2,
	    wealth_index = '3'  => 3,
	    wealth_index = '2'  => 4,
	                           5);
	
	wealth_index_other_l := map(
	    wealth_index_other = 1 => 0.004894059,
	    wealth_index_other = 2 => 0.000569236,
	    wealth_index_other = 3 => 0.0037787347,
	    wealth_index_other = 4 => 0.0100425727,
	    wealth_index_other = 5 => 0.0122702754,
	                              0.0004728967);
	
	logit_3 := -10.38867651 +
	    lien_combo_m_2 * 5.108027739 +
	    years_in_dob1_m_3 * 6.4338990094 +
	    phn_highrisk2_l_1 * 187.41144935 +
	    (integer)add2_isbestmatch * 0.1152055525 +
	    ssns_per_adl1_m_3 * 9.4534739434 +
	    adlperssn_count1_m_3 * 5.8692988914 +
	    addrs_per_ssn1_m_2 * 6.8765556398 +
	    adls_per_addr1 * 0.0143242314 +
	    ssns_per_addr_c6_cap_m_3 * 4.1414932373 +
	    phones_per_addr_c6_cap_m_3 * 7.4309042122 +
	    nap_infutor_combo1_m_3 * 6.6683868544 +
	    diff_derog1_m_3 * 4.6515637466 +
	    ams_combo_m_3 * 6.1380975067 +
	    addr_stability1_m_3 * 3.555267084 +
	    estimated_income1_cap * -0.000027699 +
	    impulse_flag_200901_l_3 * 11.461860734 +
	    plane_boat_prof_m * 3.2235002391 +
	    add1_avm_automated_other_l * 23.054150194 +
	    ver_s_other_m * 1.9114579158 +
	    wealth_index_other_l * 21.899275858;
	
	phat_3 := exp(logit_3) / (1 + exp(logit_3));
	
	mod1_custom1_3 := round(-40 * (ln(phat_3 / (1 - phat_3)) - ln(1 / 21)) / ln(2) + 703);
	
	mod1_other := mod1_custom1_3;
	
	lien_combo_m_1 := map(
	    lien_combo = 1 => 0.1750069502,
	    lien_combo = 2 => 0.2171843687,
	    lien_combo = 3 => 0.2631027254,
	    lien_combo = 4 => 0.3257119936,
	    lien_combo = 5 => 0.3498789346,
	    lien_combo = 6 => 0.424,
	                      0.209205304);
	
	years_in_dob1_m_2 := map(
	    years_in_dob1 = 1 => 0.1477103036,
	    years_in_dob1 = 2 => 0.1632962138,
	    years_in_dob1 = 3 => 0.202610733,
	    years_in_dob1 = 4 => 0.250197837,
	    years_in_dob1 = 5 => 0.297962052,
	                         0.209205304);
	
	ver_s := map(
	    verlst_s and verssn_s and veradd_s                                        => 1,
	    verlst_s and verssn_s                                                     => 4,
	    (integer)verlst_s = 0 and (integer)verssn_s = 0 and (integer)veradd_s = 0 => 3,
	                                                                                 2);
	
	ver_s_m_1 := map(
	    ver_s = 1 => 0.1973228827,
	    ver_s = 2 => 0.1684210526,
	    ver_s = 3 => 0.4,
	    ver_s = 4 => 0.3065316246,
	                 0.209205304);
	
	one_did := if(did_count = 1, 1, 0);
	
	one_did_m := map(
	    one_did = 0 => 0.252446184,
	    one_did = 1 => 0.2087012069,
	                   0.209205304);
	
	phn_highrisk2_l := map(
	    (integer)phn_highrisk2 = 0 => 0.000373638,
	    (integer)phn_highrisk2 = 1 => 0.0006776623,
	                                  0.0002600507);
	
	ssns_per_adl1_m_2 := map(
	    ssns_per_adl1 = 1 => 0.1989465154,
	    ssns_per_adl1 = 2 => 0.2206082615,
	    ssns_per_adl1 = 3 => 0.2572044169,
	                         0.209205304);
	
	adlperssn_count1_m_2 := map(
	    adlperssn_count1 = 1 => 0.2067212112,
	    adlperssn_count1 = 2 => 0.2110821981,
	    adlperssn_count1 = 3 => 0.2096646422,
	    adlperssn_count1 = 4 => 0.2382022472,
	                            0.209205304);
	
	ssns_per_adl_c6_cap := if(ssns_per_adl_c6 >= 2, 2, ssns_per_adl_c6);
	
	ssns_per_adl_c6_cap_m_2 := map(
	    ssns_per_adl_c6_cap = 0 => 0.1923780593,
	    ssns_per_adl_c6_cap = 1 => 0.2391275168,
	    ssns_per_adl_c6_cap = 2 => 0.2968421053,
	                               0.209205304);
	
	ssns_per_addr_c6_cap := if(ssns_per_addr_c6 >= 4, 4, ssns_per_addr_c6);
	
	ssns_per_addr_c6_cap_m_2 := map(
	    ssns_per_addr_c6_cap = 0 => 0.1853269974,
	    ssns_per_addr_c6_cap = 1 => 0.239429004,
	    ssns_per_addr_c6_cap = 2 => 0.272475447,
	    ssns_per_addr_c6_cap = 3 => 0.2885066458,
	    ssns_per_addr_c6_cap = 4 => 0.3204697987,
	                                0.209205304);
	
	phones_per_addr_c6_cap := if(phones_per_addr_c6 >= 2, 2, phones_per_addr_c6);
	
	phones_per_addr_c6_cap_m_2 := map(
	    phones_per_addr_c6_cap = 0 => 0.2013426271,
	    phones_per_addr_c6_cap = 1 => 0.2657668141,
	    phones_per_addr_c6_cap = 2 => 0.2628424658,
	                                  0.209205304);
	
	nap_infutor_combo1_m_2 := map(
	    nap_infutor_combo1 = 1 => 0.1199090737,
	    nap_infutor_combo1 = 2 => 0.1575618171,
	    nap_infutor_combo1 = 3 => 0.2030677656,
	    nap_infutor_combo1 = 4 => 0.1944809461,
	    nap_infutor_combo1 = 5 => 0.2349643221,
	    nap_infutor_combo1 = 6 => 0.3099315068,
	                              0.209205304);
	
	diff_derog1_m_2 := map(
	    diff_derog1 = 0 => 0.3548153512,
	    diff_derog1 = 1 => 0.3348092643,
	    diff_derog1 = 2 => 0.2692991115,
	    diff_derog1 = 3 => 0.2270181219,
	    diff_derog1 = 4 => 0.1904400607,
	    diff_derog1 = 5 => 0.1642592814,
	    diff_derog1 = 6 => 0.1558589306,
	    diff_derog1 = 7 => 0.1196379378,
	                       0.209205304);
	
	ams_combo_m_2 := map(
	    ams_combo = 1 => 0.1613832853,
	    ams_combo = 2 => 0.2050953846,
	    ams_combo = 3 => 0.2425608656,
	    ams_combo = 4 => 0.2774239207,
	    ams_combo = 5 => 0.3419483101,
	                     0.209205304);
	
	addr_stability1_m_2 := map(
	    addr_stability1 = 2 => 0.3227457672,
	    addr_stability1 = 3 => 0.225265146,
	    addr_stability1 = 4 => 0.1803139068,
	    addr_stability1 = 5 => 0.170743348,
	    addr_stability1 = 6 => 0.1264349741,
	                           0.209205304);
	
	disposition1 := map(
	    TRIM(disposition) = ''         	 => 1,
	    TRIM(disposition) = 'Discharged' => 2,
																					3);
	
	attr_bankruptcy_count601 := if(attr_bankruptcy_count60 >= 2, 2, attr_bankruptcy_count60);
	
	attr_bankruptcy_count901 := if(attr_bankruptcy_count90 > 0, 1, 0);
	
	bankrupt_combo := map(
	    disposition1 = 3 and attr_bankruptcy_count601 > 0                                  => 5,
	    disposition1 = 1 and attr_bankruptcy_count601 = 0                                  => 1,
	    disposition1 = 2 and attr_bankruptcy_count901 = 0 and attr_bankruptcy_count601 = 0 => 2,
	    disposition1 = 2 and attr_bankruptcy_count601 = 1                                  => 3,
	                                                                                          4);
	
	bankrupt_combo_m := map(
	    bankrupt_combo = 1 => 0.2068199532,
	    bankrupt_combo = 2 => 0.1755141745,
	    bankrupt_combo = 3 => 0.21552436,
	    bankrupt_combo = 4 => 0.297,
	    bankrupt_combo = 5 => 0.4025,
	                          0.209205304);
	
	impulse_flag_200901_l_2 := map(
	    impulse_flag = 0 => 0.0002604231,
	    impulse_flag = 1 => 0.0421604594,
	                        0.0002600507);
	
	property_owned_total1 := if(property_owned_total >= 4, 4, property_owned_total);
	
	attr_eviction_count1 := if(attr_eviction_count >= 2, 2, attr_eviction_count);
	
	attr_eviction_count1_l := map(
	    attr_eviction_count1 = 0 => 0.0002670286,
	    attr_eviction_count1 = 1 => 0.0084985208,
	    attr_eviction_count1 = 2 => 0.0106069522,
	                                0.0002600507);
	
	wealth_index_der := map(
	    wealth_index = '0'  => 2,
	    wealth_index <= '2' => ((REAL)wealth_index - 1),
	    wealth_index >= '5' => 5,
	                           (REAL)wealth_index);
	
	wealth_index_der_l := map(
	    wealth_index_der = 0 => 0.009570163,
	    wealth_index_der = 1 => 0.0027026499,
	    wealth_index_der = 2 => 0.0005379816,
	    wealth_index_der = 3 => 0.0012609234,
	    wealth_index_der = 4 => 0.0011537103,
	    wealth_index_der = 5 => 0.0015123693,
	                            0.0002600507);
	
	logit_2 := -9.79947111 +
	    lien_combo_m_1 * 2.8821003048 +
	    years_in_dob1_m_2 * 3.8114632715 +
	    ver_s_m_1 * 1.3359799049 +
	    one_did_m * 5.5285848735 +
	    phn_highrisk2_l * 446.78910335 +
	    ssns_per_adl1_m_2 * 4.5525335685 +
	    adlperssn_count1_m_2 * 4.6440253389 +
	    adls_per_addr1 * 0.0183313089 +
	    ssns_per_adl_c6_cap_m_2 * 1.2588659613 +
	    ssns_per_addr_c6_cap_m_2 * 2.2688009756 +
	    phones_per_addr_c6_cap_m_2 * 2.602176617 +
	    nap_infutor_combo1_m_2 * 3.0122270283 +
	    diff_derog1_m_2 * 1.1807814586 +
	    ams_combo_m_2 * 1.6602495588 +
	    addr_stability1_m_2 * 3.4434639994 +
	    estimated_income1_cap * -0.000022596 +
	    bankrupt_combo_m * 3.6683669957 +
	    impulse_flag_200901_l_2 * 30.13549449 +
	    property_owned_total1 * -0.090912754 +
	    attr_eviction_count1_l * 22.573646837 +
	    wealth_index_der_l * 30.182002722;
	
	phat_2 := exp(logit_2) / (1 + exp(logit_2));
	
	mod1_custom1_2 := round(-40 * (ln(phat_2 / (1 - phat_2)) - ln(1 / 21)) / ln(2) + 703);
	
	mod1_derog := mod1_custom1_2;
	
	lien_combo_m := map(
	    lien_combo = 1 => 0.0705728749,
	    lien_combo = 2 => 0.2328767123,
	                      0.0708438143);
	
	years_in_dob1_m_1 := map(
	    years_in_dob1 = 1 => 0.0428933515,
	    years_in_dob1 = 2 => 0.0469594595,
	    years_in_dob1 = 3 => 0.0665892373,
	    years_in_dob1 = 4 => 0.0914156364,
	    years_in_dob1 = 5 => 0.1303439803,
	                         0.0708438143);
	
	ver_s_m := map(
	    ver_s = 1 => 0.0657733875,
	    ver_s = 2 => 0.1222222222,
	    ver_s = 3 => 0.1385542169,
	    ver_s = 4 => 0.1460176991,
	                 0.0708438143);
	
	avm_auto_val_current := if(add2_isbestmatch, add2_avm_automated_valuation, add1_avm_automated_valuation);
	
	avm_auto_val_current1 := if(avm_auto_val_current = 0, 120000, avm_auto_val_current);
	
	ssns_per_adl1_m_1 := map(
	    ssns_per_adl1 = 1 => 0.0665979381,
	    ssns_per_adl1 = 2 => 0.0824829932,
	    ssns_per_adl1 = 3 => 0.1020671835,
	                         0.0708438143);
	
	adlperssn_count1_m_1 := map(
	    adlperssn_count1 = 1 => 0.0659540353,
	    adlperssn_count1 = 2 => 0.0750214592,
	    adlperssn_count1 = 3 => 0.0802157061,
	    adlperssn_count1 = 4 => 0.1288167939,
	                            0.0708438143);
	
	addrs_per_ssn1_m_1 := map(
	    addrs_per_ssn1 = 1 => 0.0544879899,
	    addrs_per_ssn1 = 2 => 0.0638325449,
	    addrs_per_ssn1 = 3 => 0.0766793409,
	    addrs_per_ssn1 = 4 => 0.0834397122,
	    addrs_per_ssn1 = 5 => 0.085080148,
	    addrs_per_ssn1 = 6 => 0.1042097999,
	                          0.0708438143);
	
	ssns_per_adl_c6_cap_m_1 := map(
	    ssns_per_adl_c6_cap = 0 => 0.0631772213,
	    ssns_per_adl_c6_cap = 1 => 0.0947480827,
	    ssns_per_adl_c6_cap = 2 => 0.112195122,
	                               0.0708438143);
	
	ssns_per_addr_c6_cap_m_1 := map(
	    ssns_per_addr_c6_cap = 0 => 0.0597422522,
	    ssns_per_addr_c6_cap = 1 => 0.0937801683,
	    ssns_per_addr_c6_cap = 2 => 0.1103351955,
	    ssns_per_addr_c6_cap = 3 => 0.1403026135,
	    ssns_per_addr_c6_cap = 4 => 0.177852349,
	                                0.0708438143);
	
	phones_per_addr_c6_cap_m_1 := map(
	    phones_per_addr_c6_cap = 0 => 0.0682820487,
	    phones_per_addr_c6_cap = 1 => 0.0940851977,
	    phones_per_addr_c6_cap = 2 => 0.1180679785,
	                                  0.0708438143);
	
	nap_infutor_combo1_m_1 := map(
	    nap_infutor_combo1 = 1 => 0.0305834226,
	    nap_infutor_combo1 = 2 => 0.0440473194,
	    nap_infutor_combo1 = 3 => 0.0768272823,
	    nap_infutor_combo1 = 4 => 0.1003289474,
	    nap_infutor_combo1 = 5 => 0.0941449147,
	    nap_infutor_combo1 = 6 => 0.1242236025,
	                              0.0708438143);
	
	diff_derog1_m_1 := map(
	    diff_derog1 = 2 => 0.2075471698,
	    diff_derog1 = 3 => 0.1159257175,
	    diff_derog1 = 4 => 0.086482661,
	    diff_derog1 = 5 => 0.0710054999,
	    diff_derog1 = 6 => 0.0631772108,
	    diff_derog1 = 7 => 0.0586382886,
	                       0.0708438143);
	
	ams_combo_m_1 := map(
	    ams_combo = 1 => 0.0526675787,
	    ams_combo = 2 => 0.0675284437,
	    ams_combo = 3 => 0.1074443592,
	    ams_combo = 4 => 0.1301535974,
	    ams_combo = 5 => 0.1732954545,
	                     0.0708438143);
	
	wealth_index1 := map(
	    wealth_index = '0'  => 2,
	    wealth_index <= '2' => ((real)wealth_index - 1),
	                           (REAL)wealth_index);
	
	wealth_index1_m_1 := map(
	    wealth_index1 = 1 => 0.1144294247,
	    wealth_index1 = 2 => 0.0715725806,
	    wealth_index1 = 3 => 0.089167853,
	    wealth_index1 = 4 => 0.0650513563,
	    wealth_index1 = 5 => 0.0533707865,
	    wealth_index1 = 6 => 0.0426540284,
	                         0.0708438143);
	
	addr_stability1_m_1 := map(
	    addr_stability1 = 2 => 0.152458159,
	    addr_stability1 = 3 => 0.0836193187,
	    addr_stability1 = 4 => 0.0727792137,
	    addr_stability1 = 5 => 0.0541299506,
	    addr_stability1 = 6 => 0.0410465908,
	                           0.0708438143);
	
	impulse_flag_200901_l_1 := map(
	    impulse_flag = 0 => 0.0001980796,
	    impulse_flag = 1 => 0.1373363209,
	                        0.000198144);
	
	adls_per_addr_own := map(
	    adls_per_addr = 0   => 5,
	    adls_per_addr = 1   => 3,
	    adls_per_addr <= 3  => 1,
	    adls_per_addr <= 5  => 2,
	    adls_per_addr = 6   => 3,
	    adls_per_addr <= 8  => 4,
	    adls_per_addr <= 11 => 5,
	    adls_per_addr <= 14 => 6,
	                           7);
	
	adls_per_addr_own_m := map(
	    adls_per_addr_own = 1 => 0.0417869243,
	    adls_per_addr_own = 2 => 0.05420541,
	    adls_per_addr_own = 3 => 0.0654545455,
	    adls_per_addr_own = 4 => 0.0758052434,
	    adls_per_addr_own = 5 => 0.0838913917,
	    adls_per_addr_own = 6 => 0.100132626,
	    adls_per_addr_own = 7 => 0.1303661616,
	                             0.0708438143);
	
	watercraft := if(attr_num_watercraft60 > 0, 1, 0);
	
	aircraft := if(attr_num_aircraft > 0, 1, 0);
	
	plane_boat := if((boolean)(integer)aircraft or (boolean)(integer)watercraft, 1, 0);
	
	logit_1 := -9.245549131 +
	    lien_combo_m * 7.4851070418 +
	    years_in_dob1_m_1 * 9.5248114781 +
	    ver_s_m * 3.0342901172 +
	    avm_auto_val_current1 * -6.694462E-7 +
	    (integer)add2_isbestmatch * 0.1339457179 +
	    ssns_per_adl1_m_1 * 11.901881011 +
	    adlperssn_count1_m_1 * 8.4681522261 +
	    addrs_per_ssn1_m_1 * 8.1117962664 +
	    ssns_per_adl_c6_cap_m_1 * 3.9506002868 +
	    ssns_per_addr_c6_cap_m_1 * 4.4100981971 +
	    phones_per_addr_c6_cap_m_1 * 4.3865845814 +
	    nap_infutor_combo1_m_1 * 10.328985425 +
	    diff_derog1_m_1 * 6.5255402967 +
	    ams_combo_m_1 * 3.5324081881 +
	    wealth_index1_m_1 * 8.0848313767 +
	    addr_stability1_m_1 * 6.2507978053 +
	    estimated_income1_cap * -0.000020502 +
	    impulse_flag_200901_l_1 * 16.106945845 +
	    property_owned_total1 * -0.089808605 +
	    adls_per_addr_own_m * 8.5489869713 +
	    plane_boat * -0.187049208;
	
	phat_1 := exp(logit_1) / (1 + exp(logit_1));
	
	mod1_custom1_1 := round(-40 * (ln(phat_1 / (1 - phat_1)) - ln(1 / 21)) / ln(2) + 703);
	
	mod1_owner := mod1_custom1_1;
	
	years_in_dob1_m := map(
	    years_in_dob1 = 1 => 0.091817614,
	    years_in_dob1 = 2 => 0.0964493906,
	    years_in_dob1 = 3 => 0.1381142098,
	    years_in_dob1 = 4 => 0.1699449253,
	    years_in_dob1 = 5 => 0.1999613974,
	                         0.1562991438);
	
	ssns_per_adl1_m := map(
	    ssns_per_adl1 = 1 => 0.1507119387,
	    ssns_per_adl1 = 2 => 0.1748606183,
	    ssns_per_adl1 = 3 => 0.1982507289,
	                         0.1562991438);
	
	adlperssn_count1_m := map(
	    adlperssn_count1 = 1 => 0.1485736926,
	    adlperssn_count1 = 2 => 0.1635154062,
	    adlperssn_count1 = 3 => 0.1703056769,
	    adlperssn_count1 = 4 => 0.2416918429,
	                            0.1562991438);
	
	addrs_per_ssn1_m := map(
	    addrs_per_ssn1 = 1 => 0.1063548102,
	    addrs_per_ssn1 = 2 => 0.1664529367,
	    addrs_per_ssn1 = 3 => 0.1629955947,
	    addrs_per_ssn1 = 4 => 0.1661312529,
	    addrs_per_ssn1 = 5 => 0.1860816944,
	    addrs_per_ssn1 = 6 => 0.2035175879,
	                          0.1562991438);
	
	ssns_per_adl_c6_cap_m := map(
	    ssns_per_adl_c6_cap = 0 => 0.1399461745,
	    ssns_per_adl_c6_cap = 1 => 0.1910614525,
	    ssns_per_adl_c6_cap = 2 => 0.2063492063,
	                               0.1562991438);
	
	ssns_per_addr_c6_cap_m := map(
	    ssns_per_addr_c6_cap = 0 => 0.1330677291,
	    ssns_per_addr_c6_cap = 1 => 0.181900045,
	    ssns_per_addr_c6_cap = 2 => 0.2061762035,
	    ssns_per_addr_c6_cap = 3 => 0.2794520548,
	    ssns_per_addr_c6_cap = 4 => 0.2358078603,
	                                0.1562991438);
	
	phones_per_addr_c6_cap_m := map(
	    phones_per_addr_c6_cap = 0 => 0.1490405582,
	    phones_per_addr_c6_cap = 1 => 0.1922276197,
	    phones_per_addr_c6_cap = 2 => 0.1740696279,
	                                  0.1562991438);
	
	nap_infutor_combo1_m := map(
	    nap_infutor_combo1 = 1 => 0.0696095076,
	    nap_infutor_combo1 = 2 => 0.0852359209,
	    nap_infutor_combo1 = 3 => 0.1321799308,
	    nap_infutor_combo1 = 4 => 0.1587301587,
	    nap_infutor_combo1 = 5 => 0.1777074098,
	    nap_infutor_combo1 = 6 => 0.2551724138,
	                              0.1562991438);
	
	diff_derog1_m := map(
	    diff_derog1 = 2 => 0.2408759124,
	    diff_derog1 = 3 => 0.1937134503,
	    diff_derog1 = 4 => 0.1614492754,
	    diff_derog1 = 5 => 0.1329581428,
	    diff_derog1 = 6 => 0.1356717406,
	    diff_derog1 = 7 => 0.1118335501,
	                       0.1562991438);
	
	ams_combo_m := map(
	    ams_combo = 1 => 0.0876190476,
	    ams_combo = 2 => 0.1504266301,
	    ams_combo = 3 => 0.2168224299,
	    ams_combo = 4 => 0.2109144543,
	    ams_combo = 5 => 0.2604651163,
	                     0.1562991438);
	
	wealth_index1_m := map(
	    wealth_index1 = 0 => 0.2614555256,
	    wealth_index1 = 1 => 0.216374269,
	    wealth_index1 = 2 => 0.1401466149,
	    wealth_index1 = 3 => 0.1572254335,
	    wealth_index1 = 4 => 0.1618962433,
	    wealth_index1 = 5 => 0.0880829016,
	    wealth_index1 = 6 => 0.0909090909,
	                         0.1562991438);
	
	addr_stability1_m := map(
	    addr_stability1 = 2 => 0.2235636969,
	    addr_stability1 = 3 => 0.1758675079,
	    addr_stability1 = 4 => 0.1341288783,
	    addr_stability1 = 5 => 0.1117445838,
	    addr_stability1 = 6 => 0.0762041697,
	                           0.1562991438);
	
	impulse_flag_200901_l := map(
	    impulse_flag = 0 => 0.0007743217,
	    impulse_flag = 1 => 0.1765585461,
	                        0.0007743041);
	
	rc_numelever_cap := if(rc_numelever <= 4, 4, rc_numelever);
	
	attr_addrs_last361 := if(attr_addrs_last36 >= 4, 4, attr_addrs_last36);
	
	attr_addrs_last241 := if(attr_addrs_last24 >= 3, 3, attr_addrs_last24);
	
	attr_addr := map(
	    attr_addrs_last361 = 0                                                      => 1,
	    attr_addrs_last241 = 0 and attr_addrs_last361 <= 3                          => 2,
	    attr_addrs_last241 = 1 and attr_addrs_last361 = 1 or attr_addrs_last241 = 0 => 3,
	    attr_addrs_last241 = 1 or attr_addrs_last241 = 2 and attr_addrs_last361 = 2 => 4,
	                                                                                   5);
	
	attr_addr_l := map(
	    attr_addr = 1 => 0.0016729664,
	    attr_addr = 2 => 0.0043995223,
	    attr_addr = 3 => 0.0034522189,
	    attr_addr = 4 => 0.0031968557,
	    attr_addr = 5 => 0.0048972264,
	                     0.0007743041);
	
	add1_avm_automated_rent := map(
	    add1_avm_automated_valuation = 0       => 2,
	    add1_avm_automated_valuation <= 75000  => 5,
	    add1_avm_automated_valuation <= 115000 => 4,
	    add1_avm_automated_valuation <= 400000 => 3,
	                                              1);
	
	logit := -9.837921294 +
	    years_in_dob1_m * 4.7641516415 +
	    (integer)add2_isbestmatch * 0.2260729304 +
	    ssns_per_adl1_m * 6.2805252869 +
	    adlperssn_count1_m * 4.8929449096 +
	    addrs_per_ssn1_m * 5.2970878627 +
	    adls_per_addr1 * 0.03010028 +
	    ssns_per_adl_c6_cap_m * 3.2743044706 +
	    ssns_per_addr_c6_cap_m * 2.7045999853 +
	    phones_per_addr_c6_cap_m * 4.585916856 +
	    nap_infutor_combo1_m * 3.1967357414 +
	    diff_derog1_m * 5.0296327495 +
	    ams_combo_m * 5.6062255663 +
	    wealth_index1_m * 5.2939059774 +
	    addr_stability1_m * 1.8983824814 +
	    estimated_income1_cap * -0.000012856 +
	    impulse_flag_200901_l * 9.2476099828 +
	    rc_numelever_cap * -0.133732588 +
	    attr_addr_l * 60.452900175 +
	    add1_avm_automated_rent * 0.1139844373;
	
	phat := exp(logit) / (1 + exp(logit));
	
	mod1_custom1 := round(-40 * (ln(phat / (1 - phat)) - ln(1 / 21)) / ln(2) + 703);
	
	mod1_renter := mod1_custom1;
	
	rva1007_3_0_float := map(
	    riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
	    TRIM(pk_segment) = '1 Owner '                            => mod1_owner,
	    TRIM(pk_segment) = '2 Renter'                            => mod1_renter,
	    TRIM(pk_segment) = '3 Other '                            => mod1_other,
	    TRIM(pk_segment) = '0 Derog '                            => mod1_derog,
	                                                                  -1);
	
	rva1007_3_0 := if(rva1007_3_0_float = 222, 222, min(900, if(max(501, rva1007_3_0_float) = NULL, -NULL, max(501, rva1007_3_0_float))));
	
	/* ***********************************************************
	*                      Reason Codes                        *
	************************************************************ */
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

	boolean PreScreenOptOut := FALSE;
	reasons := map(
		riTemp[1].hri <> '00' => riTemp,
		RiskWise.rv3autoReasonCodes(le, 4, inCalif, PreScreenOptOut)
	);

	temp_score := map
	(
		riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
		reasons[1].hri='35' => '000',
		intformat(rva1007_3_0,3,1)
	);

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.adl_category := adl_category;
		SELF.out_unit_desig := out_unit_desig;
		SELF.out_sec_range := out_sec_range;
		SELF.out_addr_type := out_addr_type;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.did_count := did_count;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_bansflag := rc_bansflag;
		SELF.rc_sources := rc_sources;
		SELF.rc_numelever := rc_numelever;
		SELF.rc_disthphoneaddr := rc_disthphoneaddr;
		SELF.rc_fnamessnmatch := rc_fnamessnmatch;
		SELF.combo_addrcount := combo_addrcount;
		SELF.lname_eda_sourced := lname_eda_sourced;
		SELF.age := age;
		SELF.add1_unit_count := add1_unit_count;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
		SELF.add1_avm_med_fips := add1_avm_med_fips;
		SELF.add1_avm_med_geo11 := add1_avm_med_geo11;
		SELF.add1_avm_med_geo12 := add1_avm_med_geo12;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_mortgage_type := add1_mortgage_type;
		SELF.property_owned_total := property_owned_total;
		SELF.property_sold_assessed_total := property_sold_assessed_total;
		SELF.dist_a1toa2 := dist_a1toa2;
		SELF.dist_a1toa3 := dist_a1toa3;
		SELF.dist_a2toa3 := dist_a2toa3;
		SELF.add2_isbestmatch := add2_isbestmatch;
		SELF.add2_avm_automated_valuation := add2_avm_automated_valuation;
		SELF.addrs_10yr := addrs_10yr;
		SELF.gong_did_phone_ct := gong_did_phone_ct;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.adlperssn_count := adlperssn_count;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.adls_per_addr := adls_per_addr;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.ssns_per_addr_c6 := ssns_per_addr_c6;
		SELF.phones_per_addr_c6 := phones_per_addr_c6;
		SELF.infutor_nap := infutor_nap;
		SELF.impulse_count := impulse_count;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_num_watercraft60 := attr_num_watercraft60;
		SELF.attr_num_aircraft := attr_num_aircraft;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_num_unrel_liens180 := attr_num_unrel_liens180;
		SELF.attr_num_unrel_liens24 := attr_num_unrel_liens24;
		SELF.attr_bankruptcy_count90 := attr_bankruptcy_count90;
		SELF.attr_bankruptcy_count60 := attr_bankruptcy_count60;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.attr_num_nonderogs90 := attr_num_nonderogs90;
		SELF.bankrupt := bankrupt;
		SELF.date_last_seen := date_last_seen;
		SELF.disposition := disposition;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_recent_released_count := liens_recent_released_count;
		SELF.liens_historical_released_count := liens_historical_released_count;
		SELF.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
		SELF.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
		SELF.watercraft_count := watercraft_count;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_income_level_code := ams_income_level_code;
		SELF.prof_license_flag := prof_license_flag;
		SELF.prof_license_category := prof_license_category;
		SELF.wealth_index := wealth_index;
		SELF.addr_stability := addr_stability;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.source_tot_ba_1 := source_tot_ba_1;
		SELF.source_tot_ds := source_tot_ds;
		SELF.source_tot_l2 := source_tot_l2;
		SELF.source_tot_li := source_tot_li;
		SELF.lien_rec_unrel_flag := lien_rec_unrel_flag;
		SELF.lien_hist_unrel_flag := lien_hist_unrel_flag;
		SELF.lien_flag := lien_flag;
		SELF.bk_flag_1 := bk_flag_1;
		SELF.ssn_deceased := ssn_deceased;
		SELF.pk_impulse_count_1 := pk_impulse_count_1;
		SELF.pk_impulse_count := pk_impulse_count;
		SELF.pk_adl_cat_deceased := pk_adl_cat_deceased;
		SELF.bs_own_rent := bs_own_rent;
		SELF.bs_attr_derog_flag := bs_attr_derog_flag;
		SELF.bs_attr_eviction_flag := bs_attr_eviction_flag;
		SELF.bs_attr_derog_flag2 := bs_attr_derog_flag2;
		SELF.pk_segment := pk_segment;
		SELF.unrel_lien_24mo := unrel_lien_24mo;
		SELF.unrel_lien_6mo := unrel_lien_6mo;
		SELF.tot_un_liens := tot_un_liens;
		SELF.tot_rel_liens := tot_rel_liens;
		SELF.rel_lien_combo := rel_lien_combo;
		SELF.unrel_lien_combo := unrel_lien_combo;
		SELF.lien_combo := lien_combo;
		SELF.lien_combo_m_2 := lien_combo_m_2;
		SELF.in_dob2 := in_dob2;
		SELF.years_in_dob := years_in_dob;
		SELF.years_in_dob1 := years_in_dob1;
		SELF.years_in_dob1_m_3 := years_in_dob1_m_3;
		SELF.phn_highrisk2 := phn_highrisk2;
		SELF.phn_highrisk2_l_1 := phn_highrisk2_l_1;
		SELF.ssns_per_adl1 := ssns_per_adl1;
		SELF.ssns_per_adl1_m_3 := ssns_per_adl1_m_3;
		SELF.adlperssn_count1 := adlperssn_count1;
		SELF.adlperssn_count1_m_3 := adlperssn_count1_m_3;
		SELF.addrs_per_ssn1 := addrs_per_ssn1;
		SELF.addrs_per_ssn1_m_2 := addrs_per_ssn1_m_2;
		SELF.adls_per_addr1 := adls_per_addr1;
		SELF.ssns_per_addr_c6_cap_1 := ssns_per_addr_c6_cap_1;
		SELF.ssns_per_addr_c6_cap_m_3 := ssns_per_addr_c6_cap_m_3;
		SELF.phones_per_addr_c6_cap_1 := phones_per_addr_c6_cap_1;
		SELF.phones_per_addr_c6_cap_m_3 := phones_per_addr_c6_cap_m_3;
		SELF.nap_infutor_combo := nap_infutor_combo;
		SELF.nap_infutor_combo1 := nap_infutor_combo1;
		SELF.nap_infutor_combo1_m_3 := nap_infutor_combo1_m_3;
		SELF.diff_derog := diff_derog;
		SELF.diff_derog1 := diff_derog1;
		SELF.diff_derog1_m_3 := diff_derog1_m_3;
		SELF.ams_4yr_grad := ams_4yr_grad;
		SELF.ams_combo := ams_combo;
		SELF.ams_combo_m_3 := ams_combo_m_3;
		SELF.addr_stability1 := addr_stability1;
		SELF.addr_stability1_m_3 := addr_stability1_m_3;
		SELF.pk_wealth_index := pk_wealth_index;
		SELF.pk_wealth_index_m := pk_wealth_index_m;
		SELF.wealth_index_cm := wealth_index_cm;
		SELF.source_tot_da := source_tot_da;
		SELF.source_tot_cg := source_tot_cg;
		SELF.source_tot_p := source_tot_p;
		SELF.source_tot_ba := source_tot_ba;
		SELF.source_tot_am := source_tot_am;
		SELF.source_tot_w := source_tot_w;
		SELF.add_apt := add_apt;
		SELF.bk_flag := bk_flag;
		SELF.pk_bk_level := pk_bk_level;
		SELF.add1_avm_med := add1_avm_med;
		SELF.rc_valid_bus_phone := rc_valid_bus_phone;
		SELF.rc_valid_res_phone := rc_valid_res_phone;
		SELF.age_rcd := age_rcd;
		SELF.add1_mortgage_type_ord := add1_mortgage_type_ord;
		SELF.prof_license_category_ord := prof_license_category_ord;
		SELF.pk_attr_total_number_derogs_1 := pk_attr_total_number_derogs_1;
		SELF.pk_attr_total_number_derogs := pk_attr_total_number_derogs;
		SELF.pk_attr_num_nonderogs90_1 := pk_attr_num_nonderogs90_1;
		SELF.pk_attr_num_nonderogs90 := pk_attr_num_nonderogs90;
		SELF.pk_derog_total := pk_derog_total;
		SELF.pk_derog_total_m := pk_derog_total_m;
		SELF.add1_avm_automated_valuation_rcd := add1_avm_automated_valuation_rcd;
		SELF.add1_avm_automated_val_2_rcd := add1_avm_automated_val_2_rcd;
		SELF.pk_liens_unrel_ot_total_amount := pk_liens_unrel_ot_total_amount;
		SELF.attr_num_watercraft60_cap := attr_num_watercraft60_cap;
		SELF.combo_addrcount_cap := combo_addrcount_cap;
		SELF.gong_did_phone_ct_cap := gong_did_phone_ct_cap;
		SELF.ams_college_code_mis := ams_college_code_mis;
		SELF.ams_college_code_cm := ams_college_code_cm;
		SELF.ams_income_level_code_cm := ams_income_level_code_cm;
		SELF.unit5 := unit5;
		SELF.pk_dist_a1toa2 := pk_dist_a1toa2;
		SELF.pk_dist_a1toa3 := pk_dist_a1toa3;
		SELF.pk_dist_a2toa3 := pk_dist_a2toa3;
		SELF.pk_rc_disthphoneaddr := pk_rc_disthphoneaddr;
		SELF.dist_mod := dist_mod;
		SELF.date_last_seen2 := date_last_seen2;
		SELF.years_date_last_seen := years_date_last_seen;
		SELF.liens_unrel_cj_last_seen2 := liens_unrel_cj_last_seen2;
		SELF.years_liens_unrel_cj_last_seen := years_liens_unrel_cj_last_seen;
		SELF.pk_yr_date_last_seen := pk_yr_date_last_seen;
		SELF.pk_bk_yr_date_last_seen := pk_bk_yr_date_last_seen;
		SELF.pk_bk_yr_date_last_seen_m1 := pk_bk_yr_date_last_seen_m1;
		SELF.adl_category_ord := adl_category_ord;
		SELF.pk_yr_liens_unrel_cj_last_seen := pk_yr_liens_unrel_cj_last_seen;
		SELF.pk2_yr_liens_unrel_cj_last_seen := pk2_yr_liens_unrel_cj_last_seen;
		SELF.predicted_inc_high := predicted_inc_high;
		SELF.predicted_inc_low := predicted_inc_low;
		SELF.pred_inc := pred_inc;
		SELF.estimated_income1_1 := estimated_income1_1;
		SELF.estimated_income1 := estimated_income1;
		SELF.estimated_income1_cap := estimated_income1_cap;
		SELF.impulse_flag := impulse_flag;
		SELF.impulse_flag_200901_l_3 := impulse_flag_200901_l_3;
		SELF.plane_boat_prof := plane_boat_prof;
		SELF.plane_boat_prof_m := plane_boat_prof_m;
		SELF.add1_avm_automated_other := add1_avm_automated_other;
		SELF.add1_avm_automated_other_l := add1_avm_automated_other_l;
		SELF.verlst_s := verlst_s;
		SELF.veradd_s := veradd_s;
		SELF.verssn_s := verssn_s;
		SELF.ver_s_other := ver_s_other;
		SELF.ver_s_other_m := ver_s_other_m;
		SELF.wealth_index_other := wealth_index_other;
		SELF.wealth_index_other_l := wealth_index_other_l;
		SELF.logit_3 := logit_3;
		SELF.phat_3 := phat_3;
		SELF.mod1_custom1_3 := mod1_custom1_3;
		SELF.mod1_other := mod1_other;
		SELF.lien_combo_m_1 := lien_combo_m_1;
		SELF.years_in_dob1_m_2 := years_in_dob1_m_2;
		SELF.ver_s := ver_s;
		SELF.ver_s_m_1 := ver_s_m_1;
		SELF.one_did := one_did;
		SELF.one_did_m := one_did_m;
		SELF.phn_highrisk2_l := phn_highrisk2_l;
		SELF.ssns_per_adl1_m_2 := ssns_per_adl1_m_2;
		SELF.adlperssn_count1_m_2 := adlperssn_count1_m_2;
		SELF.ssns_per_adl_c6_cap := ssns_per_adl_c6_cap;
		SELF.ssns_per_adl_c6_cap_m_2 := ssns_per_adl_c6_cap_m_2;
		SELF.ssns_per_addr_c6_cap := ssns_per_addr_c6_cap;
		SELF.ssns_per_addr_c6_cap_m_2 := ssns_per_addr_c6_cap_m_2;
		SELF.phones_per_addr_c6_cap := phones_per_addr_c6_cap;
		SELF.phones_per_addr_c6_cap_m_2 := phones_per_addr_c6_cap_m_2;
		SELF.nap_infutor_combo1_m_2 := nap_infutor_combo1_m_2;
		SELF.diff_derog1_m_2 := diff_derog1_m_2;
		SELF.ams_combo_m_2 := ams_combo_m_2;
		SELF.addr_stability1_m_2 := addr_stability1_m_2;
		SELF.disposition1 := disposition1;
		SELF.attr_bankruptcy_count601 := attr_bankruptcy_count601;
		SELF.attr_bankruptcy_count901 := attr_bankruptcy_count901;
		SELF.bankrupt_combo := bankrupt_combo;
		SELF.bankrupt_combo_m := bankrupt_combo_m;
		SELF.impulse_flag_200901_l_2 := impulse_flag_200901_l_2;
		SELF.property_owned_total1 := property_owned_total1;
		SELF.attr_eviction_count1 := attr_eviction_count1;
		SELF.attr_eviction_count1_l := attr_eviction_count1_l;
		SELF.wealth_index_der := wealth_index_der;
		SELF.wealth_index_der_l := wealth_index_der_l;
		SELF.logit_2 := logit_2;
		SELF.phat_2 := phat_2;
		SELF.mod1_custom1_2 := mod1_custom1_2;
		SELF.mod1_derog := mod1_derog;
		SELF.lien_combo_m := lien_combo_m;
		SELF.years_in_dob1_m_1 := years_in_dob1_m_1;
		SELF.ver_s_m := ver_s_m;
		SELF.avm_auto_val_current := avm_auto_val_current;
		SELF.avm_auto_val_current1 := avm_auto_val_current1;
		SELF.ssns_per_adl1_m_1 := ssns_per_adl1_m_1;
		SELF.adlperssn_count1_m_1 := adlperssn_count1_m_1;
		SELF.addrs_per_ssn1_m_1 := addrs_per_ssn1_m_1;
		SELF.ssns_per_adl_c6_cap_m_1 := ssns_per_adl_c6_cap_m_1;
		SELF.ssns_per_addr_c6_cap_m_1 := ssns_per_addr_c6_cap_m_1;
		SELF.phones_per_addr_c6_cap_m_1 := phones_per_addr_c6_cap_m_1;
		SELF.nap_infutor_combo1_m_1 := nap_infutor_combo1_m_1;
		SELF.diff_derog1_m_1 := diff_derog1_m_1;
		SELF.ams_combo_m_1 := ams_combo_m_1;
		SELF.wealth_index1 := wealth_index1;
		SELF.wealth_index1_m_1 := wealth_index1_m_1;
		SELF.addr_stability1_m_1 := addr_stability1_m_1;
		SELF.impulse_flag_200901_l_1 := impulse_flag_200901_l_1;
		SELF.adls_per_addr_own := adls_per_addr_own;
		SELF.adls_per_addr_own_m := adls_per_addr_own_m;
		SELF.watercraft := watercraft;
		SELF.aircraft := aircraft;
		SELF.plane_boat := plane_boat;
		SELF.logit_1 := logit_1;
		SELF.phat_1 := phat_1;
		SELF.mod1_custom1_1 := mod1_custom1_1;
		SELF.mod1_owner := mod1_owner;
		SELF.years_in_dob1_m := years_in_dob1_m;
		SELF.ssns_per_adl1_m := ssns_per_adl1_m;
		SELF.adlperssn_count1_m := adlperssn_count1_m;
		SELF.addrs_per_ssn1_m := addrs_per_ssn1_m;
		SELF.ssns_per_adl_c6_cap_m := ssns_per_adl_c6_cap_m;
		SELF.ssns_per_addr_c6_cap_m := ssns_per_addr_c6_cap_m;
		SELF.phones_per_addr_c6_cap_m := phones_per_addr_c6_cap_m;
		SELF.nap_infutor_combo1_m := nap_infutor_combo1_m;
		SELF.diff_derog1_m := diff_derog1_m;
		SELF.ams_combo_m := ams_combo_m;
		SELF.wealth_index1_m := wealth_index1_m;
		SELF.addr_stability1_m := addr_stability1_m;
		SELF.impulse_flag_200901_l := impulse_flag_200901_l;
		SELF.rc_numelever_cap := rc_numelever_cap;
		SELF.attr_addrs_last361 := attr_addrs_last361;
		SELF.attr_addrs_last241 := attr_addrs_last241;
		SELF.attr_addr := attr_addr;
		SELF.attr_addr_l := attr_addr_l;
		SELF.add1_avm_automated_rent := add1_avm_automated_rent;
		SELF.logit := logit;
		SELF.phat := phat;
		SELF.mod1_custom1 := mod1_custom1;
		SELF.mod1_renter := mod1_renter;
		SELF.rva1007_3_0_float := rva1007_3_0_float;
		SELF.rva1007_3_0 := rva1007_3_0;
		SELF.score := temp_score;

		SELF.rc1 := reasons[1].hri;
		SELF.rc2 := reasons[2].hri;
		SELF.rc3 := reasons[3].hri;
		SELF.rc4 := reasons[4].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)temp_score;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
