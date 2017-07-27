import risk_indicators, ut, easi;

export CSN1007_0_0( dataset(Risk_Indicators.collection_shell_mod.collection_shell_layout_full) cclam ) := FUNCTION

	CSN_DEBUG := false;

	
	#if(CSN_DEBUG)
	layout_debug := RECORD, maxlength(1024000)
		integer seq;
String es_phone10;
String se1_phone10;
String se2_phone10;
String se3_phone10;
String se4_phone10;
String ap1_phone10;
String ap2_phone10;
String ap3_phone10;
String sx1_phone10;
String sx2_phone10;
String sp_phone10;
String md1_phone10;
String md2_phone10;
String cl1_phone10;
String cl2_phone10;
String cl3_phone10;
String cr_phone10;
String ne1_phone10;
String ne2_phone10;
String ne3_phone10;
String pp1_phone10;
String pp2_phone10;
String pp3_phone10;
String wk_phone10;
Integer es_eda_did;
String se1_phone_first_seen;
String se2_phone_first_seen;
String se3_phone_first_seen;
String se4_phone_first_seen;
String ap1_phone_first_seen;
Integer sp_first_seen;
String md1_phone_first_seen;
Integer cl1_first_seen;
Integer cl2_first_seen;
Integer cl3_first_seen;
String ne1_phone_first_seen;
String ne2_phone_first_seen;
String ne3_phone_first_seen;
String pp1_phone_last_seen;
String pp2_phone_last_seen;
String pp3_phone_last_seen;
String wk_phone_first_seen;
Integer ah_add1_first_seen;
Integer ah_add2_first_seen;
Integer ah_add3_first_seen;
Integer ah_add5_first_seen;
String md1_mo_shared_addr;
String md2_mo_shared_addr;
String md1_mo_since_shared_addr;
String md2_mo_since_shared_addr;
String cl1_mo_since_shared_addr;
String cl2_mo_since_shared_addr;
String cl3_mo_since_shared_addr;
Integer cenmatch;
String adl_addr;
String es_name_match_flag;
string sp_dist;
String wk_source;
String ah_add1_dist;
String ah_add2_dist;
String ah_add3_dist;
String ah_add4_dist;
String ah_add5_dist;
String pp1_active_phone;
String pp2_active_phone;
String pp3_active_phone;
String wf_hphn;
String c_bargains;
String c_bel_edu;
String c_lowrent;
String C_MED_HVAL;
Integer DID;
String out_unit_desig;
String out_sec_range;
String out_st;
String out_addr_type;
String in_phone10;
Integer NAS_Summary;
Integer NAP_Summary;
String nap_type;
String nap_status;
String rc_correct_dob;
Integer rc_dirsaddr_lastscore;
String rc_name_addr_phone;
String rc_hriskphoneflag;
String rc_hphonetypeflag;
String rc_phonevalflag;
String rc_hphonevalflag;
String rc_phonezipflag;
String rc_pwphonezipflag;
String rc_decsflag;
String rc_ssndobflag;
String rc_pwssndobflag;
String rc_ssnvalflag;
String rc_pwssnvalflag;
Integer rc_ssnhighissue;
Integer rc_areacodesplitdate;
String rc_dwelltype;
String rc_bansflag;
Integer rc_phonelnamecount;
Integer rc_phoneaddrcount;
Integer rc_utiliaddr_phonecount;
Integer rc_disthphoneaddr;
String rc_phonetype;
String rc_cityzipflag;
Integer combo_fnamescore;
Integer combo_hphonescore;
Integer combo_dobscore;
Integer combo_lnamecount;
Integer combo_addrcount;
Integer combo_hphonecount;
Integer combo_ssncount;
Integer combo_dobcount;
Integer EQ_count;
Integer EN_count;
Integer DL_count;
Integer EM_count;
Integer VO_count;
Integer EM_only_count;
Integer adl_eq_first_seen;
Integer adl_EN_first_seen;
Integer adl_DL_first_seen;
Integer adl_PR_first_seen;
Integer adl_EM_first_seen;
Integer adl_VO_first_seen;
Integer adl_EM_only_first_seen;
Integer adl_W_first_seen;
Integer adl_PR_last_seen;
Integer adl_W_last_seen;
String em_only_sources;
Boolean dl_avail;
Boolean voter_avail;
Boolean dobpop;
Integer lname_change_date;
String fname_eda_sourced_type;
String lname_eda_sourced_type;
Integer util_adl_count;
Integer util_adl_nap;
Integer util_add2_nap;
Integer add1_address_score;
Boolean add1_isbestmatch;
Integer add1_unit_count;
Integer add1_lres;
String add1_avm_recording_date;
String add1_avm_assessed_value_year;
String add1_avm_sales_price;
Integer add1_avm_tax_assessed_valuation;
Integer add1_avm_price_index_valuation;
Integer add1_avm_automated_valuation;
Integer add1_avm_med_fips;
Integer add1_avm_med_geo11;
Integer add1_avm_med_geo12;
decimal5_2 add1_fc_index_fips;
decimal5_2 add1_fc_index_geo11;
decimal5_2 add1_fc_index_geo12;
Boolean add1_eda_sourced;
Boolean add1_applicant_owned;
Boolean add1_occupant_owned;
Boolean add1_family_owned;
Integer ADD1_NAPROP;
Integer add1_built_date;
Integer ADD1_PURCHASE_AMOUNT;
Integer add1_mortgage_date;
String add1_mortgage_type;
String add1_mortgage_due_date;
Integer ADD1_ASSESSED_AMOUNT;
Integer add1_date_first_seen;
Integer add1_building_area;
Integer add1_no_of_buildings;
Integer add1_no_of_rooms;
Integer add1_no_of_baths;
Integer add1_parking_no_of_cars;
String add1_style_code;
String add1_assessed_value_year;
Boolean add1_pop;
Integer PROPERTY_OWNED_TOTAL;
Integer property_owned_assessed_count;
Integer PROPERTY_SOLD_TOTAL;
Integer prop1_sale_price;
Integer prop1_prev_purchase_price;
Integer prop1_prev_purchase_date;
Integer prop2_sale_date;
Integer prop2_prev_purchase_date;
Integer dist_a1toa3;
Integer Add2_lres;
Integer add2_avm_automated_valuation;
Integer add2_avm_automated_valuation_4;
Integer add2_avm_med_fips;
Integer add2_avm_med_geo11;
Integer add2_avm_med_geo12;
String add2_sources;
Boolean add2_applicant_owned;
Boolean add2_family_owned;
Integer ADD2_NAPROP;
String add2_land_use_code;
Integer add2_no_of_buildings;
Integer add2_no_of_stories;
Integer add2_no_of_baths;
String add2_garage_type_code;
String add2_style_code;
String add2_assessed_value_year;
Integer add2_built_date;
Integer ADD2_PURCHASE_AMOUNT;
Integer add2_mortgage_amount;
String add2_mortgage_type;
String add2_financing_type;
String add2_mortgage_due_date;
Integer ADD2_ASSESSED_AMOUNT;
Integer add2_date_first_seen;
Integer add2_date_last_seen;
Boolean add2_pop;
Integer Add3_lres;
String add3_sources;
Boolean add3_applicant_owned;
Boolean add3_family_owned;
Integer ADD3_NAPROP;
Integer add3_built_date;
Integer ADD3_PURCHASE_AMOUNT;
Integer add3_mortgage_date;
String add3_mortgage_type;
String add3_financing_type;
String add3_mortgage_due_date;
Integer ADD3_ASSESSED_AMOUNT;
Integer add3_date_first_seen;
Integer add3_date_last_seen;
Boolean add3_pop;
Integer avg_lres;
Integer addrs_5yr;
Integer addrs_10yr;
Boolean addrs_prison_history;
String gong_did_first_seen;
Integer gong_did_phone_ct;
Integer gong_did_first_ct;
Integer namePerSSN_count;
Integer credit_first_seen;
Integer header_first_seen;
Boolean utility_sourced;
String inputssncharflag;
Integer ssns_per_adl;
Integer addrs_per_adl;
Integer phones_per_adl;
Integer addrs_per_ssn;
Integer adls_per_addr;
Integer ssns_per_addr;
Integer phones_per_addr;
Integer adls_per_phone;
Integer addrs_per_adl_c6;
Integer phones_per_adl_c6;
Integer addrs_per_ssn_c6;
Integer adls_per_addr_c6;
Integer ssns_per_addr_c6;
Integer phones_per_addr_c6;
Integer adls_per_phone_c6;
Integer invalid_addrs_per_adl_c6;
Integer infutor_first_seen;
Integer infutor_nap;
Integer impulse_count;
Integer attr_addrs_last30;
Integer attr_addrs_last90;
Integer attr_addrs_last12;
Integer attr_addrs_last24;
Integer attr_addrs_last36;
Integer attr_date_last_purchase;
Integer attr_num_purchase180;
Integer attr_date_last_sale;
Integer attr_num_sold60;
Integer attr_num_watercraft90;
Integer attr_num_watercraft180;
Integer attr_num_watercraft24;
Integer attr_total_number_derogs;
Integer attr_felonies12;
Integer attr_felonies24;
Integer attr_felonies36;
Integer attr_felonies60;
Integer attr_arrests24;
Integer attr_eviction_count;
Integer attr_date_last_eviction;
Integer attr_eviction_count30;
Integer attr_eviction_count90;
Integer attr_eviction_count180;
Integer attr_eviction_count12;
Integer attr_eviction_count24;
Integer attr_eviction_count36;
Integer attr_eviction_count60;
Integer attr_num_nonderogs90;
Integer attr_num_proflic90;
Integer attr_num_proflic_exp30;
Boolean Bankrupt;
String filing_type;
String disposition;
Integer filing_count;
Integer bk_recent_count;
Integer bk_disposed_historical_count;
Integer liens_recent_unreleased_count;
Integer liens_historical_unreleased_ct;
Integer liens_unrel_cj_ct;
Integer liens_unrel_cj_first_seen;
Integer liens_unrel_ft_ct;
Integer liens_unrel_lt_ct;
Integer liens_unrel_lt_first_seen;
Integer liens_unrel_o_ct;
Integer liens_unrel_ot_ct;
Integer liens_unrel_ot_first_seen;
Integer liens_unrel_sc_ct;
Integer liens_unrel_sc_first_seen;
Integer criminal_count;
Integer criminal_last_date;
Integer felony_count;
Integer rel_count;
Integer rel_bankrupt_count;
Integer rel_felony_count;
Integer crim_rel_within100miles;
Integer crim_rel_withinother;
Integer rel_prop_owned_count;
Integer rel_prop_owned_purchase_total;
Integer rel_prop_owned_purchase_count;
Integer rel_prop_owned_assessed_total;
Integer rel_prop_owned_assessed_count;
Integer rel_prop_sold_count;
Integer rel_prop_sold_purchase_total;
Integer rel_prop_sold_assessed_total;
Integer rel_within25miles_count;
Integer rel_incomeunder25_count;
Integer rel_incomeunder50_count;
Integer rel_incomeunder75_count;
Integer rel_incomeunder100_count;
Integer rel_incomeover100_count;
Integer rel_homeunder100_count;
Integer rel_homeunder200_count;
Integer rel_homeunder300_count;
Integer rel_homeunder500_count;
Integer rel_homeover500_count;
Integer rel_educationunder12_count;
Integer rel_educationover12_count;
Integer rel_ageunder30_count;
Integer rel_ageunder40_count;
Integer rel_ageunder50_count;
Integer rel_ageunder70_count;
Integer rel_ageover70_count;
Integer rel_vehicle_owned_count;
Integer rel_count_addr;
Integer current_count;
Integer historical_count;
Integer acc_damage_amt_total;
Integer acc_damage_amt_last;
String ams_age;
String ams_class;
String ams_income_level_code;
String ams_college_tier;
Boolean prof_license_flag;
String prof_license_category;
Integer inferred_age;
Integer estimated_income;
Integer archive_date;
String rc_sources;
String fname_sources;
String lname_sources;
String addr_sources;
String util_adl_type_list;
String util_adl_first_seen_list;
String util_add1_type_list;
String util_add1_first_seen_list;
String util_add2_first_seen_list;
Integer util_add1_nap;
String util_add2_type_list;
Integer sysdate;
Real sysyear;
Integer rc_correct_dob2;
Real years_rc_correct_dob;
Real months_rc_correct_dob;
Integer rc_ssnhighissue2;
Real years_rc_ssnhighissue;
Real months_rc_ssnhighissue;
Integer rc_areacodesplitdate2;
Real years_rc_areacodesplitdate;
Real months_rc_areacodesplitdate;
integer adl_eq_first_seen2;
real years_adl_eq_first_seen;
real months_adl_eq_first_seen;
integer adl_en_first_seen2;
real years_adl_en_first_seen;
real months_adl_en_first_seen;
integer adl_dl_first_seen2;
real years_adl_dl_first_seen;
real months_adl_dl_first_seen;
integer adl_pr_first_seen2;
real years_adl_pr_first_seen;
real months_adl_pr_first_seen;
integer adl_em_first_seen2;
real years_adl_em_first_seen;
real months_adl_em_first_seen;
integer adl_vo_first_seen2;
real years_adl_vo_first_seen;
real months_adl_vo_first_seen;
integer adl_em_only_first_seen2;
real years_adl_em_only_first_seen;
real months_adl_em_only_first_seen;
integer adl_w_first_seen2;
real years_adl_w_first_seen;
real months_adl_w_first_seen;
integer adl_pr_last_seen2;
real years_adl_pr_last_seen;
real months_adl_pr_last_seen;
integer adl_w_last_seen2;
real years_adl_w_last_seen;
real months_adl_w_last_seen;
integer lname_change_date2;
real years_lname_change_date;
real months_lname_change_date;
integer add1_avm_recording_date2;
real years_add1_avm_recording_date;
real months_add1_avm_recording_date;
integer add1_avm_assessed_value_year2;
real years_add1_avm_assess_year;
real months_add1_avm_assess_year;
integer add1_built_date2;
real years_add1_built_date;
real months_add1_built_date;
integer add1_mortgage_date2;
real years_add1_mortgage_date;
real months_add1_mortgage_date;
integer add1_mortgage_due_date2;
real years_add1_mortgage_due_date;
real months_add1_mortgage_due_date;
integer add1_date_first_seen2;
real years_add1_date_first_seen;
real months_add1_date_first_seen;
integer add1_assessed_value_year2;
real years_add1_assessed_value_year;
real months_add1_assessed_value_year;
integer prop1_prev_purchase_date2;
real years_prop1_prev_purchase_date;
real months_prop1_prev_purchase_date;
integer prop2_sale_date2;
real years_prop2_sale_date;
real months_prop2_sale_date;
integer prop2_prev_purchase_date2;
real years_prop2_prev_purchase_date;
real months_prop2_prev_purchase_date;
integer add2_assessed_value_year2;
real years_add2_assessed_value_year;
real months_add2_assessed_value_year;
integer add2_built_date2;
real years_add2_built_date;
real months_add2_built_date;
integer add2_mortgage_due_date2;
real years_add2_mortgage_due_date;
real months_add2_mortgage_due_date;
integer add2_date_first_seen2;
real years_add2_date_first_seen;
real months_add2_date_first_seen;
integer add2_date_last_seen2;
real years_add2_date_last_seen;
real months_add2_date_last_seen;
integer add3_built_date2;
real years_add3_built_date;
real months_add3_built_date;
integer add3_mortgage_date2;
real years_add3_mortgage_date;
real months_add3_mortgage_date;
integer add3_mortgage_due_date2;
real years_add3_mortgage_due_date;
real months_add3_mortgage_due_date;
integer add3_date_first_seen2;
real years_add3_date_first_seen;
real months_add3_date_first_seen;
integer add3_date_last_seen2;
real years_add3_date_last_seen;
real months_add3_date_last_seen;
integer gong_did_first_seen2;
real years_gong_did_first_seen;
real months_gong_did_first_seen;
integer credit_first_seen2;
real years_credit_first_seen;
real months_credit_first_seen;
integer header_first_seen2;
real years_header_first_seen;
real months_header_first_seen;
integer infutor_first_seen2;
real years_infutor_first_seen;
real months_infutor_first_seen;
integer attr_date_last_purchase2;
real years_attr_date_last_purchase;
real months_attr_date_last_purchase;
integer attr_date_last_sale2;
real years_attr_date_last_sale;
real months_attr_date_last_sale;
integer attr_date_last_eviction2;
real years_attr_date_last_eviction;
real months_attr_date_last_eviction;
integer liens_unrel_cj_first_seen2;
real years_liens_unrel_cj_first_seen;
real months_liens_unrel_cj_first_seen;
integer liens_unrel_lt_first_seen2;
real years_liens_unrel_lt_first_seen;
real months_liens_unrel_lt_first_seen;
integer liens_unrel_ot_first_seen2;
real years_liens_unrel_ot_first_seen;
real months_liens_unrel_ot_first_seen;
integer liens_unrel_sc_first_seen2;
real years_liens_unrel_sc_first_seen;
real months_liens_unrel_sc_first_seen;
integer criminal_last_date2;
real years_criminal_last_date;
real months_criminal_last_date;
integer source_tot_AK;
integer source_tot_AM;
integer source_tot_AR;
integer source_tot_BA;
integer source_tot_CG;
integer source_tot_CO;
integer source_tot_CY;
integer source_tot_DA;
integer source_tot_D;
integer source_tot_DL;
integer source_tot_DS;
integer source_tot_EB;
integer source_tot_EM;
integer source_tot_VO;
integer source_tot_EQ;
integer source_tot_FF;
integer source_tot_FR;
integer source_tot_L2;
integer source_tot_LI;
integer source_tot_MW;
integer source_tot_NT;
integer source_tot_P;
integer source_tot_PL;
integer source_tot_SL;
integer source_tot_TU;
integer source_tot_V;
integer source_tot_W;
integer source_tot_WP;
boolean source_tot_DrLic;
boolean source_tot_voter;
integer source_tot_count;
integer source_tot_count_pos;
integer source_tot_count_neg;
integer source_tot_count_fcrapos;
integer source_tot_count_fcraneg;
integer source_tot_total;
Boolean source_tot_other;
integer source_fst_AK;
integer source_fst_AM;
integer source_fst_AR;
integer source_fst_BA;
integer source_fst_CG;
integer source_fst_CO;
integer source_fst_CY;
integer source_fst_DA;
integer source_fst_D;
integer source_fst_DL;
integer source_fst_DS;
integer source_fst_EB;
integer source_fst_EM;
integer source_fst_VO;
integer source_fst_EQ;
integer source_fst_FF;
integer source_fst_FR;
integer source_fst_L2;
integer source_fst_LI;
integer source_fst_MW;
integer source_fst_NT;
integer source_fst_P;
integer source_fst_PL;
integer source_fst_SL;
integer source_fst_TU;
integer source_fst_V;
integer source_fst_W;
integer source_fst_WP;
Boolean source_fst_DrLic;
Boolean source_fst_voter;
integer source_fst_count;
integer source_fst_count_pos;
integer source_fst_count_neg;
integer source_fst_count_fcrapos;
integer source_fst_count_fcraneg;
integer source_fst_total;
boolean source_fst_other;
integer source_lst_AK;
integer source_lst_AM;
integer source_lst_AR;
integer source_lst_BA;
integer source_lst_CG;
integer source_lst_CO;
integer source_lst_CY;
integer source_lst_DA;
integer source_lst_D;
integer source_lst_DL;
integer source_lst_DS;
integer source_lst_EB;
integer source_lst_EM;
integer source_lst_VO;
integer source_lst_EQ;
integer source_lst_FF;
integer source_lst_FR;
integer source_lst_L2;
integer source_lst_LI;
integer source_lst_MW;
integer source_lst_NT;
integer source_lst_P;
integer source_lst_PL;
integer source_lst_SL;
integer source_lst_TU;
integer source_lst_V;
integer source_lst_W;
integer source_lst_WP;
Boolean source_lst_DrLic;
Boolean source_lst_voter;
integer source_lst_count;
integer source_lst_count_pos;
integer source_lst_count_neg;
integer source_lst_count_fcrapos;
integer source_lst_count_fcraneg;
integer source_lst_total;
Boolean source_lst_other;
integer source_add_AK;
integer source_add_AM;
integer source_add_AR;
integer source_add_BA;
integer source_add_CG;
integer source_add_CO;
integer source_add_CY;
integer source_add_DA;
integer source_add_D;
integer source_add_DL;
integer source_add_DS;
integer source_add_EB;
integer source_add_EM;
integer source_add_VO;
integer source_add_EQ;
integer source_add_FF;
integer source_add_FR;
integer source_add_L2;
integer source_add_LI;
integer source_add_MW;
integer source_add_NT;
integer source_add_P;
integer source_add_PL;
integer source_add_SL;
integer source_add_TU;
integer source_add_V;
integer source_add_W;
integer source_add_WP;
Boolean source_add_DrLic;
Boolean source_add_voter;
integer source_add_count;
integer source_add_count_pos;
integer source_add_count_neg;
integer source_add_count_fcrapos;
integer source_add_count_fcraneg;
integer source_add_total;
Boolean source_add_other;
integer source_add2_AK;
integer source_add2_AM;
integer source_add2_AR;
integer source_add2_BA;
integer source_add2_CG;
integer source_add2_CO;
integer source_add2_CY;
integer source_add2_DA;
integer source_add2_D;
integer source_add2_DL;
integer source_add2_DS;
integer source_add2_EB;
integer source_add2_EM;
integer source_add2_E1;
integer source_add2_E2;
integer source_add2_E3;
integer source_add2_E4;
integer source_add2_VO;
integer source_add2_EQ;
integer source_add2_FF;
integer source_add2_FR;
integer source_add2_L2;
integer source_add2_LI;
integer source_add2_MW;
integer source_add2_NT;
integer source_add2_P;
integer source_add2_PL;
integer source_add2_SL;
integer source_add2_TU;
integer source_add2_V;
integer source_add2_W;
integer source_add2_WP;
Boolean source_add2_DrLic;
Boolean source_add2_voter;
integer source_add2_count;
integer source_add2_count_pos;
integer source_add2_count_neg;
integer source_add2_count_fcrapos;
integer source_add2_count_fcraneg;
integer source_add2_total;
Boolean source_add2_other;
integer source_add3_AK;
integer source_add3_AM;
integer source_add3_AR;
integer source_add3_BA;
integer source_add3_CG;
integer source_add3_CO;
integer source_add3_CY;
integer source_add3_DA;
integer source_add3_D;
integer source_add3_DL;
integer source_add3_DS;
integer source_add3_EB;
integer source_add3_EM;
integer source_add3_E1;
integer source_add3_E2;
integer source_add3_E3;
integer source_add3_E4;
integer source_add3_VO;
integer source_add3_EQ;
integer source_add3_FF;
integer source_add3_FR;
integer source_add3_L2;
integer source_add3_LI;
integer source_add3_MW;
integer source_add3_NT;
integer source_add3_P;
integer source_add3_PL;
integer source_add3_SL;
integer source_add3_TU;
integer source_add3_V;
integer source_add3_W;
integer source_add3_WP;
Boolean source_add3_DrLic;
Boolean source_add3_voter;
integer source_add3_count;
integer source_add3_count_pos;
integer source_add3_count_neg;
integer source_add3_count_fcrapos;
integer source_add3_count_fcraneg;
integer source_add3_total;
Boolean source_add3_other;
integer em_only_source_EM;
integer em_only_source_E1;
integer em_only_source_E2;
integer em_only_source_E3;
integer em_only_source_E4;
integer util_adl_A;
integer util_adl_C;
integer util_adl_D;
integer util_adl_E;
integer util_adl_F;
integer util_adl_G;
integer util_adl_H;
integer util_adl_I;
integer util_adl_L;
integer util_adl_N;
integer util_adl_O;
integer util_adl_P;
integer util_adl_S;
integer util_adl_T;
integer util_adl_U;
integer util_adl_V;
integer util_adl_W;
integer util_adl_Z;
integer util_adl_A_firstseen;
integer util_adl_C_firstseen;
integer util_adl_D_firstseen;
integer util_adl_E_firstseen;
integer util_adl_F_firstseen;
integer util_adl_G_firstseen;
integer util_adl_H_firstseen;
integer util_adl_I_firstseen;
integer util_adl_L_firstseen;
integer util_adl_N_firstseen;
integer util_adl_O_firstseen;
integer util_adl_P_firstseen;
integer util_adl_S_firstseen;
integer util_adl_T_firstseen;
integer util_adl_U_firstseen;
integer util_adl_V_firstseen;
integer util_adl_W_firstseen;
integer util_adl_Z_firstseen;
real years_util_adl_A_firstseen;
real years_util_adl_C_firstseen;
real years_util_adl_D_firstseen;
real years_util_adl_E_firstseen;
real years_util_adl_F_firstseen;
real years_util_adl_G_firstseen;
real years_util_adl_H_firstseen;
real years_util_adl_I_firstseen;
real years_util_adl_L_firstseen;
real years_util_adl_N_firstseen;
real years_util_adl_O_firstseen;
real years_util_adl_P_firstseen;
real years_util_adl_S_firstseen;
real years_util_adl_T_firstseen;
real years_util_adl_U_firstseen;
real years_util_adl_V_firstseen;
real years_util_adl_W_firstseen;
real years_util_adl_Z_firstseen;
real months_util_adl_A_firstseen;
real months_util_adl_C_firstseen;
real months_util_adl_D_firstseen;
real months_util_adl_E_firstseen;
real months_util_adl_F_firstseen;
real months_util_adl_G_firstseen;
real months_util_adl_H_firstseen;
real months_util_adl_I_firstseen;
real months_util_adl_L_firstseen;
real months_util_adl_N_firstseen;
real months_util_adl_O_firstseen;
real months_util_adl_P_firstseen;
real months_util_adl_S_firstseen;
real months_util_adl_T_firstseen;
real months_util_adl_U_firstseen;
real months_util_adl_V_firstseen;
real months_util_adl_W_firstseen;
real months_util_adl_Z_firstseen;
Integer util_adl_source_count;
Boolean util_adl_sourced;
Real max_years_util_adl_firstseen;
integer util_add1_A;
integer util_add1_C;
integer util_add1_D;
integer util_add1_E;
integer util_add1_F;
integer util_add1_G;
integer util_add1_H;
integer util_add1_I;
integer util_add1_L;
integer util_add1_N;
integer util_add1_O;
integer util_add1_P;
integer util_add1_S;
integer util_add1_T;
integer util_add1_U;
integer util_add1_V;
integer util_add1_W;
integer util_add1_Z;
integer util_add1_A_firstseen;
integer util_add1_C_firstseen;
integer util_add1_D_firstseen;
integer util_add1_E_firstseen;
integer util_add1_F_firstseen;
integer util_add1_G_firstseen;
integer util_add1_H_firstseen;
integer util_add1_I_firstseen;
integer util_add1_L_firstseen;
integer util_add1_N_firstseen;
integer util_add1_O_firstseen;
integer util_add1_P_firstseen;
integer util_add1_S_firstseen;
integer util_add1_T_firstseen;
integer util_add1_U_firstseen;
integer util_add1_V_firstseen;
integer util_add1_W_firstseen;
integer util_add1_Z_firstseen;
real years_util_add1_A_firstseen;
real years_util_add1_C_firstseen;
real years_util_add1_D_firstseen;
real years_util_add1_E_firstseen;
real years_util_add1_F_firstseen;
real years_util_add1_G_firstseen;
real years_util_add1_H_firstseen;
real years_util_add1_I_firstseen;
real years_util_add1_L_firstseen;
real years_util_add1_N_firstseen;
real years_util_add1_O_firstseen;
real years_util_add1_P_firstseen;
real years_util_add1_S_firstseen;
real years_util_add1_T_firstseen;
real years_util_add1_U_firstseen;
real years_util_add1_V_firstseen;
real years_util_add1_W_firstseen;
real years_util_add1_Z_firstseen;
real months_util_add1_A_firstseen;
real months_util_add1_C_firstseen;
real months_util_add1_D_firstseen;
real months_util_add1_E_firstseen;
real months_util_add1_F_firstseen;
real months_util_add1_G_firstseen;
real months_util_add1_H_firstseen;
real months_util_add1_I_firstseen;
real months_util_add1_L_firstseen;
real months_util_add1_N_firstseen;
real months_util_add1_O_firstseen;
real months_util_add1_P_firstseen;
real months_util_add1_S_firstseen;
real months_util_add1_T_firstseen;
real months_util_add1_U_firstseen;
real months_util_add1_V_firstseen;
real months_util_add1_W_firstseen;
real months_util_add1_Z_firstseen;
Integer util_add1_source_count;
Boolean util_add1_sourced;
Real max_years_util_add1_firstseen;
integer util_add2_A;
integer util_add2_C;
integer util_add2_D;
integer util_add2_E;
integer util_add2_F;
integer util_add2_G;
integer util_add2_H;
integer util_add2_I;
integer util_add2_L;
integer util_add2_N;
integer util_add2_O;
integer util_add2_P;
integer util_add2_S;
integer util_add2_T;
integer util_add2_U;
integer util_add2_V;
integer util_add2_W;
integer util_add2_Z;
integer util_add2_A_firstseen;
integer util_add2_C_firstseen;
integer util_add2_D_firstseen;
integer util_add2_E_firstseen;
integer util_add2_F_firstseen;
integer util_add2_G_firstseen;
integer util_add2_H_firstseen;
integer util_add2_I_firstseen;
integer util_add2_L_firstseen;
integer util_add2_N_firstseen;
integer util_add2_O_firstseen;
integer util_add2_P_firstseen;
integer util_add2_S_firstseen;
integer util_add2_T_firstseen;
integer util_add2_U_firstseen;
integer util_add2_V_firstseen;
integer util_add2_W_firstseen;
integer util_add2_Z_firstseen;
real years_util_add2_A_firstseen;
real years_util_add2_C_firstseen;
real years_util_add2_D_firstseen;
real years_util_add2_E_firstseen;
real years_util_add2_F_firstseen;
real years_util_add2_G_firstseen;
real years_util_add2_H_firstseen;
real years_util_add2_I_firstseen;
real years_util_add2_L_firstseen;
real years_util_add2_N_firstseen;
real years_util_add2_O_firstseen;
real years_util_add2_P_firstseen;
real years_util_add2_S_firstseen;
real years_util_add2_T_firstseen;
real years_util_add2_U_firstseen;
real years_util_add2_V_firstseen;
real years_util_add2_W_firstseen;
real years_util_add2_Z_firstseen;
real months_util_add2_A_firstseen;
real months_util_add2_C_firstseen;
real months_util_add2_D_firstseen;
real months_util_add2_E_firstseen;
real months_util_add2_F_firstseen;
real months_util_add2_G_firstseen;
real months_util_add2_H_firstseen;
real months_util_add2_I_firstseen;
real months_util_add2_L_firstseen;
real months_util_add2_N_firstseen;
real months_util_add2_O_firstseen;
real months_util_add2_P_firstseen;
real months_util_add2_S_firstseen;
real months_util_add2_T_firstseen;
real months_util_add2_U_firstseen;
real months_util_add2_V_firstseen;
real months_util_add2_W_firstseen;
real months_util_add2_Z_firstseen;
Integer util_add2_source_count;
Boolean util_add2_sourced;
Real max_years_util_add2_firstseen;
Integer verfst_p;
Integer verlst_p;
Integer veradd_p;
Integer verphn_p;
Integer ver_phncount;
Real years_adl_first_seen_max_fcra;
Real months_adl_first_seen_max_fcra;
Boolean add_apt;
Boolean phn_disconnected;
Boolean phn_inval;
Boolean phn_highrisk2;
Boolean phn_cellpager;
Boolean phn_zipmismatch;
Boolean phn_residential;
Boolean ssn_priordob;
Boolean ssn_inval;
Boolean ssn_issued18;
Boolean ssn_deceased;
Boolean ssn_prob;
Integer add1_avm_med;
Real add1_avm_to_med_ratio;
decimal5_2 add1_fc_index;
Integer add2_avm_med;
Boolean prop_owned_flag;
Boolean prop_sold_flag;
Real add_lres_year_avg;
Real add_lres_year_max;
Boolean bk_flag;
Boolean crime_flag;
Boolean crime_felony_flag;
Boolean crime_drug_flag;
Integer rc82;
Boolean did_populated;
integer pk_es_phone10_pop;
integer pk_se1_phone10_pop;
integer pk_se2_phone10_pop;
integer pk_se3_phone10_pop;
integer pk_se4_phone10_pop;
integer pk_ap1_phone10_pop;
integer pk_ap2_phone10_pop;
integer pk_ap3_phone10_pop;
integer pk_sx1_phone10_pop;
integer pk_sx2_phone10_pop;
integer pk_sp_phone10_pop;
integer pk_md1_phone10_pop;
integer pk_md2_phone10_pop;
integer pk_cl1_phone10_pop;
integer pk_cl2_phone10_pop;
integer pk_cl3_phone10_pop;
integer pk_cr_phone10_pop;
integer pk_ne1_phone10_pop;
integer pk_ne2_phone10_pop;
integer pk_ne3_phone10_pop;
integer pk_pp1_phone10_pop;
integer pk_pp2_phone10_pop;
integer pk_pp3_phone10_pop;
integer pk_wk_phone10_pop;
integer pk_es_eda_did_match;
integer pk_es_phone_count;
integer pk_se_phone_count;
integer pk_ap_phone_count;
integer pk_sx_phone_count;
integer pk_sp_phone_count;
integer pk_md_phone_count;
integer pk_cl_phone_count;
integer pk_cr_phone_count;
integer pk_ne_phone_count;
integer pk_pp_phone_count;
integer pk_wk_phone_count;
integer pk_waterfall_phone_count;
integer se1_phone_first_seen2;
real years_se1_phone_first_seen;
real months_se1_phone_first_seen;
integer se2_phone_first_seen2;
real years_se2_phone_first_seen;
real months_se2_phone_first_seen;
integer se3_phone_first_seen2;
real years_se3_phone_first_seen;
real months_se3_phone_first_seen;
integer se4_phone_first_seen2;
real years_se4_phone_first_seen;
real months_se4_phone_first_seen;
integer ap1_phone_first_seen2;
real years_ap1_phone_first_seen;
real months_ap1_phone_first_seen;
integer sp_first_seen2;
real years_sp_first_seen;
real months_sp_first_seen;
integer md1_phone_first_seen2;
real years_md1_phone_first_seen;
real months_md1_phone_first_seen;
integer cl1_first_seen2;
real years_cl1_first_seen;
real months_cl1_first_seen;
integer cl2_first_seen2;
real years_cl2_first_seen;
real months_cl2_first_seen;
integer cl3_first_seen2;
real years_cl3_first_seen;
real months_cl3_first_seen;
integer ne1_phone_first_seen2;
real years_ne1_phone_first_seen;
real months_ne1_phone_first_seen;
integer ne2_phone_first_seen2;
real years_ne2_phone_first_seen;
real months_ne2_phone_first_seen;
integer ne3_phone_first_seen2;
real years_ne3_phone_first_seen;
real months_ne3_phone_first_seen;
integer pp1_phone_last_seen2;
real years_pp1_phone_last_seen;
real months_pp1_phone_last_seen;
integer pp2_phone_last_seen2;
real years_pp2_phone_last_seen;
real months_pp2_phone_last_seen;
integer pp3_phone_last_seen2;
real years_pp3_phone_last_seen;
real months_pp3_phone_last_seen;
integer wk_phone_first_seen2;
real years_wk_phone_first_seen;
real months_wk_phone_first_seen;
integer ah_add1_first_seen2;
real years_ah_add1_first_seen;
real months_ah_add1_first_seen;
integer ah_add2_first_seen2;
real years_ah_add2_first_seen;
real months_ah_add2_first_seen;
integer ah_add3_first_seen2;
real years_ah_add3_first_seen;
real months_ah_add3_first_seen;
integer ah_add5_first_seen2;
real years_ah_add5_first_seen;
real months_ah_add5_first_seen;
Integer pk_years_se1_phone_first_seen;
Integer pk_years_se2_phone_first_seen;
Integer pk_years_se3_phone_first_seen;
Integer pk_years_se4_phone_first_seen;
Integer pk_years_ap1_phone_first_seen;
Integer pk_years_sp_first_seen;
Integer pk_years_md1_phone_first_seen;
Integer pk_years_cl1_first_seen;
Integer pk_years_cl2_first_seen;
Integer pk_years_cl3_first_seen;
Integer pk_years_ne1_phone_first_seen;
Integer pk_years_ne2_phone_first_seen;
Integer pk_years_ne3_phone_first_seen;
Integer pk_years_pp1_phone_last_seen;
Integer pk_years_pp2_phone_last_seen;
Integer pk_years_pp3_phone_last_seen;
Integer pk_years_wk_phone_first_seen;
Integer pk_years_ah_add1_first_seen;
Integer pk_years_ah_add2_first_seen;
Integer pk_years_ah_add3_first_seen;
Integer pk_years_ah_add5_first_seen;
Integer pk_md1_yr_shared_addr;
Integer pk_md2_yr_shared_addr;
Integer pk_md1_yr_since_shared_addr;
Integer pk_md2_yr_since_shared_addr;
Integer pk_cl1_yr_since_shared_addr;
Integer pk_cl2_yr_since_shared_addr;
Integer pk_cl3_yr_since_shared_addr;
String pk_phone_pop_segment3;
Integer pk_Segment;
Integer pk_segment2;
Real pk_repl_addr_matches_input;
Real pk_es_name_match_level;
Real pk_es_match_level;
Real pk_se_phone_stability_flag;
Real pk_sp_dist_0;
Real pk_moved_out_10yr;
Real pk_close_rel_28yr;
Real pk_stable_neighbor_phone_count;
Real pk_people_at_work_flag;
Real pk_pos_work_source_flag;
Real pk_short_move_count;
Real pk_years_ah_add1_first_seen2;
Real pk_years_ah_add2_first_seen2;
Real pk_years_ah_add3_first_seen2;
Real pk_years_ah_add5_first_seen2;
Real pk_pp_disconnect_count;
Real pk_repl_hphn_matches_input;
Real pk_repl_addr_matches_input_m;
Real pk_es_match_level_m;
Real pk_se_phone_stability_flag_m;
Real pk_sp_dist_0_m;
Real pk_moved_out_10yr_m;
Real pk_close_rel_28yr_m;
Real pk_people_at_work_flag_m;
Real pk_pos_work_source_flag_m;
Real pk_short_move_count_m;
Real pk_years_ah_add1_first_seen2_m;
Real pk_years_ah_add2_first_seen2_m;
Real pk_years_ah_add3_first_seen2_m;
Real pk_years_ah_add5_first_seen2_m;
Real pk_pp_disconnect_count_m;
Real pk_repl_phn_matches_input;
Real pk_close_rel_living_with;
Boolean pk_close_rel_living_with_flag;
Boolean pk_stable_neighbor_phone_flag;
Real pk_wk_recent_phone;
Real pk_repl_phn_matches_input_m;
Real pk_close_rel_living_with_flag_m;
Real pk_stable_neighbor_phone_flag_m;
Real pk_wk_recent_phone_m;
Real pk_waterfall_phone_count2;
Boolean pk_years_ap1_phone_first_seen_3;
Boolean pk_years_sp_first_seen_19yr;
Real pk_lived_with_parents_3yr;
Real pk_pp_recent_lseen_phone_index;
Real pk_waterfall_phone_count2_m;
Real pk_yr_ap1_phn_fseen_3_m;
Real pk_years_sp_first_seen_19yr_m;
Real pk_lived_with_parents_3yr_m;
Real pk_pp_recent_lseen_phone_index_m;
Real pk_parent_phone_recent;
Real pk_parent_phone_recent_m;
Integer pk_ssnchar_invalid_or_recent;
Integer pk_did0;
Boolean pk_ssn_prob_nodob;
Integer pk_yr_adl_eq_first_seen;
Integer pk_yr_adl_en_first_seen;
Integer pk_yr_adl_dl_first_seen;
Integer pk_yr_adl_em_first_seen;
Integer pk_yr_adl_vo_first_seen;
Integer pk_yr_adl_em_only_first_seen;
Integer pk_yr_adl_first_seen_max_fcra;
Integer pk_mo_adl_first_seen_max_fcra;
Integer pk_yr_lname_change_date;
Integer pk_yr_gong_did_first_seen;
Integer pk_yr_credit_first_seen;
Integer pk_yr_header_first_seen;
Integer pk_yr_infutor_first_seen;
Integer pk_nas_summary;
Integer pk_nap_summary;
Integer pk_rc_dirsaddr_lastscore;
Integer pk_combo_fnamescore;
Integer pk_combo_hphonescore;
Integer pk_combo_dobscore;
Integer pk_gong_did_first_ct;
Integer pk_combo_lnamecount_nb;
Integer pk_rc_phonelnamecount;
Integer pk_combo_addrcount;
Integer pk_combo_addrcount_nb;
Integer pk_rc_phoneaddrcount;
Integer pk_combo_hphonecount;
Integer pk_ver_phncount;
Integer pk_gong_did_phone_ct;
Integer pk_gong_did_phone_ct_nb;
Integer pk_combo_ssncount;
Integer pk_combo_dobcount_nb;
Integer pk_eq_count;
Integer pk_em_count;
Integer pk_em_only_count;
Integer pk_pos_secondary_sources;
Integer pk_voter_flag;
Integer pk_fname_eda_sourced_type_lvl;
Integer pk_lname_eda_sourced_type_lvl;
Integer pk_add1_address_score;
Integer pk_add1_unit_count2;
Integer pk_add2_pos_sources;
Integer add2_source_EM;
Integer add2_source_E1;
Integer add2_source_E2;
Integer add2_source_E3;
Integer add2_source_E4;
Integer add3_source_EM;
Integer add3_source_E1;
Integer add3_source_E2;
Integer add3_source_E3;
Integer add3_source_E4;
Integer pk_em_only_ver_lvl;
Integer pk_add2_em_ver_lvl;
Integer pk_infutor_risk_lvl;
Integer pk_infutor_risk_lvl_nb;
Integer pk_yr_adl_eq_first_seen2;
Integer pk_yr_adl_em_first_seen2;
Integer pk_yr_adl_vo_first_seen2;
Integer pk_yr_adl_em_only_first_seen2;
Integer pk_yrmo_adl_first_seen_max_fcra2;
Integer pk_yr_lname_change_date2;
Integer pk_yr_gong_did_first_seen2;
Integer pk_yr_credit_first_seen2;
Integer pk_yr_header_first_seen2;
Integer pk_yr_infutor_first_seen2;
Integer pk_voter_count;
Integer pk_estimated_income;
Integer pk_yr_adl_pr_first_seen;
Integer pk_yr_adl_w_first_seen;
Integer pk_yr_adl_pr_last_seen;
Integer pk_yr_adl_w_last_seen;
Integer pk_yr_add1_built_date;
Integer pk_yr_add1_mortgage_date;
Integer pk_yr_add1_mortgage_due_date;
Integer pk_yr_add1_date_first_seen;
Integer pk_yr_add1_assessed_value_year;
Integer pk_yr_prop1_prev_purchase_date;
Integer pk_yr_prop2_sale_date;
Integer pk_yr_prop2_prev_purchase_date;
Integer pk_yr_add2_assessed_value_year;
Integer pk_yr_add2_built_date;
Integer pk_yr_add2_mortgage_due_date;
Integer pk_yr_add2_date_first_seen;
Integer pk_yr_add2_date_last_seen;
Integer pk_yr_add3_built_date;
Integer pk_yr_add3_mortgage_due_date;
Integer pk_yr_add3_date_first_seen;
Integer pk_yr_add3_date_last_seen;
Integer pk_yr_attr_date_last_purchase;
Integer pk_yr_attr_date_last_sale;
Integer pk_prop1_sale_price;
Integer pk_prop1_prev_purchase_price;
Integer pk_add1_purchase_amount;
Integer pk_add1_assessed_amount;
Integer pk_add2_purchase_amount;
Integer pk_add2_mortgage_amount;
Integer pk_add2_assessed_amount;
Integer pk_add3_purchase_amount;
Integer pk_add3_assessed_amount;
Integer pk_add1_building_area;
Integer pk_yr_adl_pr_first_seen2;
Integer pk_yr_adl_w_first_seen2;
Integer pk_yr_adl_pr_last_seen2;
Integer pk_yr_adl_w_last_seen2;
Integer pk_addrs_sourced_lvl;
Integer pk_add1_own_level;
Integer pk_naprop_level;
Integer pk_naprop_level2;
Integer pk_add2_own_level;
Integer pk_add3_own_level;
Integer pk_prop_owned_sold_level;
Integer pk_yr_add1_built_date2;
Integer pk_add1_purchase_amount2;
Integer pk_yr_add1_mortgage_date2;
Integer pk_add1_mortgage_risk;
Integer pk_add1_assessed_amount2;
Integer pk_yr_add1_mortgage_due_date2;
Integer pk_yr_add1_date_first_seen2;
Integer pk_add1_building_area2;
Integer pk_add1_no_of_buildings;
Integer pk_add1_no_of_rooms;
Integer pk_add1_no_of_baths;
Integer pk_add1_parking_no_of_cars;
Integer pk_add1_style_code_level;
Integer pk_yr_add1_assessed_value_year2;
Integer pk_property_owned_assessed_count;
Integer pk_prop1_sale_price2;
Integer pk_prop1_prev_purchase_price2;
Integer pk_yr_prop1_prev_purchase_date2;
Integer pk_yr_prop2_sale_date2;
Integer pk_yr_prop2_prev_purchase_date2;
String pk_add2_land_use_cat;
Integer pk_add2_land_use_risk_level;
Integer pk_add2_no_of_buildings;
Integer pk_add2_no_of_stories;
Integer pk_add2_no_of_baths;
Integer pk_add2_garage_type_risk_level;
Integer pk_add2_style_code_level;
Integer pk_yr_add2_assessed_value_year2;
Integer pk_yr_add2_built_date2;
Integer pk_add2_purchase_amount2;
Integer pk_add2_mortgage_amount2;
Integer pk_add2_mortgage_risk;
Integer pk_add2_adjustable_financing;
Integer pk_yr_add2_mortgage_due_date2;
Integer pk_add2_assessed_amount2;
Integer pk_yr_add2_date_first_seen2;
Integer pk_yr_add2_date_last_seen2;
Integer pk_yr_add3_built_date2;
Integer pk_add3_purchase_amount2;
Integer pk_add3_mortgage_risk;
Integer pk_add3_adjustable_financing;
Integer pk_yr_add3_mortgage_due_date2;
Integer pk_add3_assessed_amount2;
Integer pk_yr_add3_date_first_seen2;
Integer pk_yr_add3_date_last_seen2;
Integer pk_yr_attr_date_last_purchase2;
Integer pk_attr_num_purchase180;
Integer pk_yr_attr_date_last_sale2;
Integer pk_attr_num_sold60;
Integer pk_attr_num_watercraft90;
Integer pk_attr_num_watercraft180;
Integer pk_attr_num_watercraft24;
Integer pk_yr_liens_unrel_cj_first_seen;
Integer pk_yr_liens_unrel_lt_first_seen;
Integer pk_yr_liens_unrel_ot_first_seen;
Integer pk_yr_liens_unrel_sc_first_seen;
Integer pk_yr_attr_date_last_eviction;
Integer pk_yr_criminal_last_date;
Integer pk_bk_level;
Integer pk_liens_unrel_cj_ct;
Integer pk_liens_unrel_ft_ct;
Integer pk_liens_unrel_lt_ct;
Integer pk_liens_unrel_o_ct;
Integer pk_liens_unrel_ot_ct;
Integer pk_liens_unrel_sc_ct;
Integer pk_liens_unrel_count;
Integer pk_lien_type_level;
Integer pk_yr_liens_unrel_cj_first_sn2;
Integer pk_yr_liens_unrel_lt_first_sn2;
Integer pk_yr_liens_unrel_ot_first_sn2;
Integer pk_yr_liens_unrel_sc_first_sn2;
Integer pk_attr_eviction_count;
Integer pk_yr_attr_date_last_eviction2;
Integer pk_eviction_level;
Integer pk_yr_criminal_last_date2;
Integer pk_crime_level;
Integer pk_felony_recent_level;
Integer pk_yr_rc_ssnhighissue;
Integer pk_yr_rc_areacodesplitdate;
Integer pk_recent_ac_split;
Boolean pk_phn_not_residential;
Integer pk_disconnected;
Integer pk_phn_cell_pager_inval;
Integer pk_yr_rc_ssnhighissue2;
Integer pk_pl_sourced_level;
Integer pk_prof_lic_cat;
Integer pk_attr_num_proflic90;
Integer pk_attr_num_proflic_exp30;
Integer pk_add_lres_year_avg;
Integer pk_add_lres_year_max;
Integer pk_add1_lres;
Integer pk_add2_lres;
Integer pk_add3_lres;
Integer pk_add1_lres_flag;
Integer pk_add2_lres_flag;
Integer pk_add3_lres_flag;
Integer pk_lres_flag_level;
Integer pk_avg_lres;
Integer pk_addrs_5yr;
Integer pk_addrs_10yr;
Integer pk_add_lres_year_avg2;
Integer pk_add_lres_year_max2;
Integer pk_nameperssn_count;
Integer pk_ssns_per_adl;
Integer pk_addrs_per_adl;
Integer pk_phones_per_adl;
Integer pk_addrs_per_ssn;
Integer pk_adls_per_addr;
Integer pk_ssns_per_addr2;
Integer pk_phones_per_addr;
Integer pk_adls_per_phone;
Integer pk_addrs_per_adl_c6;
Integer pk_phones_per_adl_c6;
Integer pk_addrs_per_ssn_c6;
Integer pk_adls_per_addr_c6;
Integer pk_ssns_per_addr_c6;
Integer pk_phones_per_addr_c6;
Integer pk_adls_per_phone_c6;
Integer pk_attr_addrs_last30;
Integer pk_attr_addrs_last36;
Integer pk_attr_addrs_last_level;
Integer pk_ams_college_tier;
Integer ams_class_n;
Real pk_since_ams_class_year;
Integer pk_ams_class_level;
Integer pk_ams_income_level_code;
Integer pk_yr_rc_correct_dob;
Integer pk_yr_rc_correct_dob2;
Integer pk_ams_age;
Integer pk_inferred_age;
Integer pk_yr_add1_avm_recording_date;
Integer pk_yr_add1_avm_assess_year;
Integer pk_add1_avm_sp;
Integer pk_add1_avm_ta;
Integer pk_add1_avm_pi;
Integer pk_add1_avm_med;
Integer pk_add2_avm_auto;
Integer pk_add2_avm_auto4;
Real pk_add1_avm_to_med_ratio;
Integer pk2_add1_avm_sp;
Integer pk2_add1_avm_ta;
Integer pk2_add1_avm_pi;
Integer pk2_add1_avm_med;
Integer pk2_add1_avm_to_med_ratio;
Integer pk_add2_avm_auto_diff4;
Integer pk_add2_avm_auto_diff4_lvl;
Integer pk2_yr_add1_avm_recording_date;
Integer pk2_yr_add1_avm_assess_year;
Integer pk_dist_a1toa3;
Integer pk_rc_disthphoneaddr;
Integer pk_out_st_division_lvl;
Integer pk_impulse_count;
Integer pk_attr_total_number_derogs;
Integer pk_attr_num_nonderogs90;
Integer pk_derog_total;
Integer pk_attr_num_nonderogs90_b;
Integer pk_c_bargains;
Integer pk_c_bel_edu;
Integer pk_c_lowrent;
Integer pk_c_med_hval;
Integer pk_yrmo_adl_f_sn_mx_fcra2;
Integer pk_add2_garage_type_risk_lvl;
Integer pk_yr_attr_dt_last_purch2;
Integer pk_yr_ln_unrel_cj_f_sn2;
Integer pk_yr_ln_unrel_lt_f_sn2;
Integer pk_yr_ln_unrel_ot_f_sn2;
Integer pk_yr_ln_unrel_sc_f_sn2;
Integer pk_yr_attr_dt_l_eviction2;
Integer pk2_yr_add1_avm_rec_dt;
Integer pk_yr_add1_assess_val_yr2;
Integer pk_prop_owned_assess_count;
Integer pk_yr_prop1_prev_purch_dt2;
Integer pk_yr_prop2_prev_purch_dt2;
Integer pk_yr_add2_assess_val_yr2;
Integer pk_rel_count;
Integer pk_rel_bankrupt_count;
Integer pk_rel_felony_count;
Integer pk_crim_rel_within100miles;
Integer pk_crim_rel_withinother;
Integer pk_rel_prop_owned_count;
Integer pk_rel_prop_own_prch_tot2;
Integer pk_rel_prop_owned_prch_cnt;
Integer pk_rel_prop_own_assess_tot2;
Integer pk_rel_prop_owned_as_cnt;
Integer pk_rel_prop_sold_count;
Integer pk_rel_prop_sold_prch_tot2;
Integer pk_rel_prop_sold_as_tot2;
Integer pk_rel_within25miles_count;
Integer pk_rel_incomeunder25_count;
Integer pk_rel_incomeunder50_count;
Integer pk_rel_incomeunder75_count;
Integer pk_rel_incomeunder100_count;
Integer pk_rel_incomeover100_count;
Integer pk_rel_homeunder100_count;
Integer pk_rel_homeunder200_count;
Integer pk_rel_homeunder300_count;
Integer pk_rel_homeunder500_count;
Integer pk_rel_homeover500_count;
Integer pk_rel_educationunder12_count;
Integer pk_rel_educationover12_count;
Integer pk_rel_ageunder30_count;
Integer pk_rel_ageunder40_count;
Integer pk_rel_ageunder50_count;
Integer pk_rel_ageunder70_count;
Integer pk_rel_ageover70_count;
Integer pk_rel_vehicle_owned_count;
Integer pk_rel_count_addr;
Integer pk_acc_damage_amt_total;
Integer pk_acc_damage_amt_last;
Integer pk_attr_arrests24;
Integer pk_acc_damage_amt_total2;
Integer pk_acc_damage_amt_last2;
integer pk_yr_util_adl_D_firstseen;
integer pk_yr_util_adl_E_firstseen;
integer pk_yr_util_adl_F_firstseen;
integer pk_yr_util_adl_G_firstseen;
integer pk_yr_util_adl_I_firstseen;
integer pk_yr_util_adl_U_firstseen;
integer pk_max_years_util_adl_firstseen;
integer pk_yr_util_add1_E_firstseen;
integer pk_yr_util_add1_F_firstseen;
integer pk_yr_util_add1_I_firstseen;
integer pk_yr_util_add1_U_firstseen;
integer pk_yr_util_add1_V_firstseen;
integer pk_yr_util_add1_Z_firstseen;
integer pk_max_years_util_add1_firstseen;
integer pk_yr_util_add2_D_firstseen;
integer pk_yr_util_add2_E_firstseen;
integer pk_yr_util_add2_G_firstseen;
integer pk_yr_util_add2_U_firstseen;
integer pk_yr_util_add2_Z_firstseen;
Integer pk_util_adl_source_count;
Integer pk_util_adl_sourced;
Integer pk_util_adl_count;
Integer pk_util_adl_nap;
Integer pk_util_add1_source_count;
Integer pk_util_add1_nap;
Integer pk_util_add2_source_count;
Integer pk_util_add2_nap;
Integer pk_rc_utiliaddr_phonecount;
Integer pk_utility_sourced;
integer pk_yr_util_adl_D_firstseen2;
integer pk_yr_util_adl_E_firstseen2;
integer pk_yr_util_adl_F_firstseen2;
integer pk_yr_util_adl_G_firstseen2;
integer pk_yr_util_adl_I_firstseen2;
integer pk_yr_util_adl_U_firstseen2;
integer pk_mx_yr_util_adl_firstseen2;
integer pk_yr_util_add1_E_firstseen2;
integer pk_yr_util_add1_F_firstseen2;
integer pk_yr_util_add1_I_firstseen2;
integer pk_yr_util_add1_U_firstseen2;
integer pk_yr_util_add1_V_firstseen2;
integer pk_yr_util_add1_Z_firstseen2;
integer pk_mx_yr_util_add1_firstseen2;
integer pk_yr_util_add2_D_firstseen2;
integer pk_yr_util_add2_E_firstseen2;
integer pk_yr_util_add2_G_firstseen2;
integer pk_yr_util_add2_U_firstseen2;
integer pk_yr_util_add2_Z_firstseen2;
Integer pk_add2_avm_med;
Integer pk_nap_type;
Integer pk_en_count;
Integer pk_dl_avail;
Integer pk_dl_count;
Integer pk_yr_adl_en_first_seen2;
Integer pk_yr_adl_dl_first_seen2;
Integer pk_add1_fc_index_flag;
Integer pk_current_count;
Integer pk_historical_count;
Integer pk_add2_avm_med2;
real pk_nas_summary_mm;
real pk_nap_summary_mm;
real pk_rc_dirsaddr_lastscore_mm;
real pk_combo_hphonescore_mm;
real pk_combo_dobscore_mm;
real pk_gong_did_first_ct_mm;
real pk_rc_phonelnamecount_mm;
real pk_combo_addrcount_mm;
real pk_rc_phoneaddrcount_mm;
real pk_combo_hphonecount_mm;
real pk_ver_phncount_mm;
real pk_gong_did_phone_ct_mm;
real pk_combo_ssncount_mm;
real pk_eq_count_mm;
real pk_em_count_mm;
real pk_em_only_count_mm;
real pk_pos_secondary_sources_mm;
real pk_voter_flag_mm;
real pk_fname_eda_sourced_type_lvl_mm;
real pk_lname_eda_sourced_type_lvl_mm;
real pk_add1_address_score_mm;
real pk_add2_pos_sources_mm;
real pk_ssnchar_invalid_or_recent_mm;
real pk_infutor_risk_lvl_mm;
real pk_yr_adl_eq_first_seen2_mm;
real pk_yr_adl_em_first_seen2_mm;
real pk_yr_adl_vo_first_seen2_mm;
real pk_yr_adl_em_only_first_seen2_mm;
real pk_yr_lname_change_date2_mm;
real pk_yr_gong_did_first_seen2_mm;
real pk_yr_credit_first_seen2_mm;
real pk_yr_header_first_seen2_mm;
real pk_yr_infutor_first_seen2_mm;
real pk_EM_Only_ver_lvl_mm;
real pk_add2_EM_ver_lvl_mm;
real pk_yrmo_adl_f_sn_mx_fcra2_mm;
real pk_util_adl_source_count_mm;
real pk_util_adl_sourced_mm;
real pk_util_adl_count_mm;
real pk_util_adl_nap_mm;
real pk_util_add1_source_count_mm;
real pk_util_add1_nap_mm;
real pk_util_add2_source_count_mm;
real pk_util_add2_nap_mm;
real pk_rc_utiliaddr_phonecount_mm;
real pk_utility_sourced_mm;
real pk_yr_util_adl_D_firstseen2_mm;
real pk_yr_util_adl_E_firstseen2_mm;
real pk_yr_util_adl_F_firstseen2_mm;
real pk_yr_util_adl_G_firstseen2_mm;
real pk_yr_util_adl_I_firstseen2_mm;
real pk_yr_util_adl_U_firstseen2_mm;
real pk_mx_yr_util_adl_firstseen2_mm;
real pk_yr_util_add1_E_firstseen2_mm;
real pk_yr_util_add1_F_firstseen2_mm;
real pk_yr_util_add1_I_firstseen2_mm;
real pk_yr_util_add1_U_firstseen2_mm;
real pk_yr_util_add1_V_firstseen2_mm;
real pk_yr_util_add1_Z_firstseen2_mm;
real pk_mx_yr_util_add1_firstseen2_mm;
real pk_yr_util_add2_D_firstseen2_mm;
real pk_yr_util_add2_E_firstseen2_mm;
real pk_yr_util_add2_G_firstseen2_mm;
real pk_yr_util_add2_U_firstseen2_mm;
real pk_yr_util_add2_Z_firstseen2_mm;
real pk_nap_type_mm;
real pk_EN_count_mm;
real pk_dl_avail_mm;
real pk_DL_count_mm;
real pk_yr_adl_EN_first_seen2_mm;
real pk_yr_adl_DL_first_seen2_mm;
real pk_combo_lnamecount_nb_mm;
real pk_combo_addrcount_nb_mm;
real pk_gong_did_phone_ct_nb_mm;
real pk_combo_dobcount_nb_mm;
real pk_infutor_risk_lvl_nb_mm;
real pk_voter_count_mm;
real pk_estimated_income_mm;
real pk_yr_adl_pr_first_seen2_mm;
real pk_yr_adl_w_first_seen2_mm;
real pk_yr_adl_pr_last_seen2_mm;
real pk_yr_adl_w_last_seen2_mm;
real pk_addrs_sourced_lvl_mm;
real pk_add1_own_level_mm;
real pk_add2_own_level_mm;
real pk_add3_own_level_mm;
real pk_prop_owned_sold_level_mm;
real pk_naprop_level2_mm;
real pk_yr_add1_built_date2_mm;
real pk_add1_purchase_amount2_mm;
real pk_yr_add1_mortgage_date2_mm;
real pk_add1_mortgage_risk_mm;
real pk_add1_assessed_amount2_mm;
real pk_yr_add1_mortgage_due_date2_mm;
real pk_yr_add1_date_first_seen2_mm;
real pk_add1_building_area2_mm;
real pk_add1_no_of_buildings_mm;
real pk_add1_no_of_rooms_mm;
real pk_add1_no_of_baths_mm;
real pk_add1_parking_no_of_cars_mm;
real pk_add1_style_code_level_mm;
real pk_prop1_sale_price2_mm;
real pk_prop1_prev_purchase_price2_mm;
real pk_yr_prop2_sale_date2_mm;
real pk_add2_land_use_risk_level_mm;
real pk_add2_no_of_buildings_mm;
real pk_add2_no_of_stories_mm;
real pk_add2_no_of_baths_mm;
real pk_add2_garage_type_risk_lvl_mm;
real pk_add2_style_code_level_mm;
real pk_yr_add2_built_date2_mm;
real pk_add2_purchase_amount2_mm;
real pk_add2_mortgage_amount2_mm;
real pk_add2_mortgage_risk_mm;
real pk_yr_add2_mortgage_due_date2_mm;
real pk_add2_assessed_amount2_mm;
real pk_yr_add2_date_first_seen2_mm;
real pk_yr_add2_date_last_seen2_mm;
real pk_yr_add3_built_date2_mm;
real pk_add3_purchase_amount2_mm;
real pk_add3_mortgage_risk_mm;
real pk_yr_add3_mortgage_due_date2_mm;
real pk_add3_assessed_amount2_mm;
real pk_yr_add3_date_first_seen2_mm;
real pk_yr_add3_date_last_seen2_mm;
real pk_yr_attr_dt_last_purch2_mm;
real pk_yr_attr_date_last_sale2_mm;
real pk_attr_num_watercraft24_mm;
real pk_bk_level_mm;
real pk_eviction_level_mm;
real pk_lien_type_level_mm;
real pk_yr_ln_unrel_cj_f_sn2_mm;
real pk_yr_ln_unrel_lt_f_sn2_mm;
real pk_yr_ln_unrel_ot_f_sn2_mm;
real pk_yr_ln_unrel_sc_f_sn2_mm;
real pk_yr_attr_dt_l_eviction2_mm;
real pk_yr_criminal_last_date2_mm;
real pk_crime_level_mm;
real pk_felony_recent_level_mm;
real pk_attr_total_number_derogs_mm;
real pk_yr_rc_ssnhighissue2_mm;
real pk_PL_Sourced_Level_mm;
real pk_prof_lic_cat_mm;
real pk_add1_lres_mm;
real pk_add2_lres_mm;
real pk_add3_lres_mm;
real pk_lres_flag_level_mm;
real pk_avg_lres_mm;
real pk_addrs_5yr_mm;
real pk_addrs_10yr_mm;
real pk_add_lres_year_avg2_mm;
real pk_add_lres_year_max2_mm;
real pk_nameperssn_count_mm;
real pk_ssns_per_adl_mm;
real pk_addrs_per_adl_mm;
real pk_phones_per_adl_mm;
real pk_addrs_per_ssn_mm;
real pk_adls_per_addr_mm;
real pk_phones_per_addr_mm;
real pk_adls_per_phone_mm;
real pk_addrs_per_adl_c6_mm;
real pk_phones_per_adl_c6_mm;
real pk_adls_per_addr_c6_mm;
real pk_ssns_per_addr_c6_mm;
real pk_phones_per_addr_c6_mm;
real pk_adls_per_phone_c6_mm;
real pk_attr_addrs_last30_mm;
real pk_attr_addrs_last36_mm;
real pk_attr_addrs_last_level_mm;
real pk_ams_class_level_mm;
real pk_ams_income_level_code_mm;
real pk_ams_college_tier_mm;
real pk_yr_rc_correct_dob2_mm;
real pk_ams_age_mm;
real pk_inferred_age_mm;
real pk_add2_avm_auto_diff4_lvl_mm;
real pk2_add1_avm_sp_mm;
real pk2_add1_avm_ta_mm;
real pk2_add1_avm_pi_mm;
real pk2_ADD1_AVM_MED_mm;
real pk2_add1_avm_to_med_ratio_mm;
real pk2_yr_add1_avm_rec_dt_mm;
real pk2_yr_add1_avm_assess_year_mm;
real pk_dist_a1toa3_mm;
real pk_rc_disthphoneaddr_mm;
real pk_out_st_division_lvl_mm;
real pk_impulse_count_mm;
real pk_derog_total_mm;
real pk_attr_num_nonderogs90_b_mm;
real pk_add1_unit_count2_mm;
real pk_ssns_per_addr2_mm;
real pk_yr_add1_assess_val_yr2_mm;
real pk_prop_owned_assess_count_mm;
real pk_yr_prop1_prev_purch_dt2_mm;
real pk_yr_prop2_prev_purch_dt2_mm;
real pk_yr_add2_assess_val_yr2_mm;
real pk_c_bargains_mm;
real pk_c_bel_edu_mm;
real pk_c_lowrent_mm;
real pk_c_med_hval_mm;
real pk_rel_count_mm;
real pk_rel_bankrupt_count_mm;
real pk_rel_felony_count_mm;
real pk_crim_rel_within100miles_mm;
real pk_crim_rel_withinOther_mm;
real pk_rel_prop_owned_count_mm;
real pk_rel_prop_own_prch_tot2_mm;
real pk_rel_prop_owned_prch_cnt_mm;
real pk_rel_prop_own_assess_tot2_mm;
real pk_rel_prop_owned_as_cnt_mm;
real pk_rel_prop_sold_count_mm;
real pk_rel_prop_sold_prch_tot2_mm;
real pk_rel_prop_sold_as_tot2_mm;
real pk_rel_within25miles_count_mm;
real pk_rel_incomeunder25_count_mm;
real pk_rel_incomeunder50_count_mm;
real pk_rel_incomeunder75_count_mm;
real pk_rel_incomeunder100_count_mm;
real pk_rel_incomeover100_count_mm;
real pk_rel_homeunder100_count_mm;
real pk_rel_homeunder200_count_mm;
real pk_rel_homeunder300_count_mm;
real pk_rel_homeunder500_count_mm;
real pk_rel_homeover500_count_mm;
real pk_rel_educationunder12_count_mm;
real pk_rel_educationover12_count_mm;
real pk_rel_ageunder30_count_mm;
real pk_rel_ageunder40_count_mm;
real pk_rel_ageunder50_count_mm;
real pk_rel_ageunder70_count_mm;
real pk_rel_ageover70_count_mm;
real pk_rel_vehicle_owned_count_mm;
real pk_rel_count_addr_mm;
real pk_attr_arrests24_mm;
real pk_acc_damage_amt_total2_mm;
real pk_acc_damage_amt_last2_mm;
real pk_add1_fc_index_flag_mm;
real pk_current_count_mm;
real pk_historical_count_mm;
real pk_add2_avm_med2_mm;
Real Age_mod3_1M_a;
Real age_mod3_1m;
Real Lien_mod_1M_a;
Real lien_mod_1m;
Real LRes_mod_1M_a;
Real lres_mod_1m;
Real ProfLic_mod_1M_a;
Real proflic_mod_1m;
Real Velocity2_mod_1M_a;
Real velocity2_mod_1m;
Real ver_best_element_cnt_mod_1M_a;
Real ver_best_element_cnt_mod_1m;
Real ver_notbest_element_cnt_mod_1M_a;
Real ver_notbest_element_cnt_mod_1m;
Real ver_element_cnt_mod_1m;
Real Relative_mod_1M_a;
Real relative_mod_1m;
Real Utility_best_mod_1M_a;
Real utility_best_mod_1m;
Real utility_mod_1m;
Real ver_best_src_cnt_mod2_1M_a;
Real ver_best_src_cnt_mod2_1m;
Real ver_src_cnt_mod2_1m;
Real Utility_notbest_mod_1M_a;
Real utility_notbest_mod_1m;
Real ver_notbest_src_cnt_mod2_1M_a;
Real ver_notbest_src_cnt_mod2_1m;
Real AVM_mod2_1M_a;
Real avm_mod2_1m;
Real Property_mod2_1M_a;
Real property_mod2_1m;
Real mod18_1M_a;
Real mod18_1m;
Real pk_contact_mod4;
Real LRes_mod_2M_a;
Real lres_mod_2m;
Real ProfLic_mod_2M_a;
Real proflic_mod_2m;
Real Velocity2_mod_2M_a;
Real velocity2_mod_2m;
Real Census_mod_2M_a;
Real census_mod_2m;
Real Derog_mod4_2M_a;
Real derog_mod4_2m;
Real Utility_best_mod_2M_a;
Real utility_best_mod_2m;
Real utility_mod_2m;
Real ver_best_src_time_mod2_2M_a;
Real ver_best_src_time_mod2_2m;
Real ver_best_src_cnt_mod2_2M_a;
Real ver_best_src_cnt_mod2_2m;
Real ver_src_time_mod2_2m;
Real ver_src_cnt_mod2_2m;
Real Utility_notbest_mod_2M_a;
Real utility_notbest_mod_2m;
Real ver_notbest_src_time_mod2_2M_a;
Real ver_notbest_src_time_mod2_2m;
Real ver_notbest_src_cnt_mod2_2M_a;
Real ver_notbest_src_cnt_mod2_2m;
Real Property_mod2_2M_a;
Real property_mod2_2m;
Real mod18_2M_a;
Real mod18_2m;
Real AddProb3_mod_3M_a;
Real addprob3_mod_3m;
Real PhnProb_mod_3M_a;
Real phnprob_mod_3m;
Real SSNProb2_mod_3M_a;
Real ssnprob2_mod_3m;
Real FP_mod5_3M_a;
Real fp_mod5_3m;
Real Age_mod3_3M_a;
Real age_mod3_3m;
Real AMStudent_mod_3M_a;
Real amstudent_mod_3m;
Real LRes_mod_3M_a;
Real lres_mod_3m;
Real ProfLic_mod_3M_a;
Real proflic_mod_3m;
Real Velocity2_mod_3M_a;
Real velocity2_mod_3m;
Real ver_best_score_mod_3M_a;
Real ver_best_score_mod_3m;
Real ver_notbest_score_mod_3M_a;
Real ver_notbest_score_mod_3m;
Real ver_score_mod_3m;
Real Relative_mod_3M_a;
Real relative_mod_3m;
Real Derog_mod4_3M_a;
Real derog_mod4_3m;
Real Utility_best_mod_3M_a;
Real utility_best_mod_3m;
Real utility_mod_3m;
Real ver_best_src_time_mod2_3M_a;
Real ver_best_src_time_mod2_3m;
Real ver_best_src_cnt_mod2_3M_a;
Real ver_best_src_cnt_mod2_3m;
Real ver_src_time_mod2_3m;
Real ver_src_cnt_mod2_3m;
Real Utility_notbest_mod_3M_a;
Real utility_notbest_mod_3m;
Real ver_notbest_src_time_mod2_3M_a;
Real ver_notbest_src_time_mod2_3m;
Real ver_notbest_src_cnt_mod2_3M_a;
Real ver_notbest_src_cnt_mod2_3m;
Real Property_mod2_3M_a;
Real property_mod2_3m;
Real mod18_3M_a;
Real mod18_3m;
Real AddProb3_mod_4M_a;
Real addprob3_mod_4m;
Real PhnProb_mod_4M_a;
Real phnprob_mod_4m;
Real SSNProb2_mod_4M_a;
Real ssnprob2_mod_4m;
Real FP_mod5_4M_a;
Real fp_mod5_4m;
Real Age_mod3_4M_a;
Real age_mod3_4m;
Real AMStudent_mod_4M_a;
Real amstudent_mod_4m;
Real Distance_mod2_4M_a;
Real distance_mod2_4m;
Real LRes_mod_4M_a;
Real lres_mod_4m;
Real Velocity2_mod_4M_a;
Real velocity2_mod_4m;
Real Relative_mod_4M_a;
Real relative_mod_4m;
Real Utility_best_mod_4M_a;
Real utility_best_mod_4m;
Real utility_mod_4m;
Real ver_best_src_time_mod2_4M_a;
Real ver_best_src_time_mod2_4m;
Real ver_best_src_cnt_mod2_4M_a;
Real ver_best_src_cnt_mod2_4m;
Real ver_src_time_mod2_4m;
Real ver_src_cnt_mod2_4m;
Real Utility_notbest_mod_4M_a;
Real utility_notbest_mod_4m;
Real ver_notbest_src_time_mod2_4M_a;
Real ver_notbest_src_time_mod2_4m;
Real ver_notbest_src_cnt_mod2_4M_a;
Real ver_notbest_src_cnt_mod2_4m;
Real Property_mod2_4M_a;
Real property_mod2_4m;
Real mod18_4M_a;
Real mod18_4m;
real Age_mod3_NoDob_1M_a;
Real age_mod3_nodob_1m;
Real ver_best_e_cnt_mod_1M_NoDob_a;
Real ver_best_e_cnt_mod_1m_nodob;
Real ver_notbest_e_cnt_mod_1M_NoDob_a;
Real ver_notbest_e_cnt_mod_1m_nodob;
Real ver_element_cnt_mod_1m_nodob;
Real mod18_1M_NoDob_a;
Real mod18_1m_nodob;
Real mod18_2M_NoDob_a;
Real mod18_2m_nodob;
Real Age_mod3_NoDob_3M_a;
Real age_mod3_nodob_3m;
Real SSNProb2_mod_3M_NoDob_a;
Real ssnprob2_mod_3m_nodob;
Real FP_mod5_3M_NoDob_a;
Real fp_mod5_3m_nodob;
Real ver_best_score_mod_3M_NoDob_a;
Real ver_best_score_mod_3m_nodob;
Real ver_notbest_score_mod_3M_NoDob_a;
Real ver_notbest_score_mod_3m_nodob;
Real ver_score_mod_3m_nodob;
Real mod18_3M_NoDob_a;
Real mod18_3m_nodob;
Real Age_mod3_NoDob_4M_a;
Real age_mod3_nodob_4m;
Real SSNProb2_mod_4M_NoDob_a;
Real ssnprob2_mod_4m_nodob;
Real FP_mod5_4M_NoDob_a;
Real fp_mod5_4m_nodob;
Real mod18_4M_NoDob_a;
Real mod18_4m_nodob;
Real phat;
Integer PK_Contact_Mod4_Scr;
Integer CSN1007;
Integer csn1007_2;
	END;
	layout_debug doModel( cclam le, easi.key_easi_census ri ) := TRANSFORM
	#else
	models.Layout_ModelOut doModel( cclam le, easi.key_easi_census ri ) := TRANSFORM
	#end
	
	// collapse the majority of code
		es_phone10                       := le.cs.es.phone10;
		se1_phone10                      := le.cs.se1.phone10;
		se2_phone10                      := le.cs.se2.phone10;
		se3_phone10                      := le.cs.se3.phone10;
		se4_phone10                      := le.cs.se4.phone10;
		ap1_phone10                      := le.cs.ap1.phone10;
		ap2_phone10                      := le.cs.ap2.phone10;
		ap3_phone10                      := le.cs.ap3.phone10;
		sx1_phone10                      := le.cs.sx1.phone10;
		sx2_phone10                      := le.cs.sx2.phone10;
		sp_phone10                       := le.cs.sp.phone10;
		md1_phone10                      := le.cs.md1.phone10;
		md2_phone10                      := le.cs.md2.phone10;
		cl1_phone10                      := le.cs.cl1.phone10;
		cl2_phone10                      := le.cs.cl2.phone10;
		cl3_phone10                      := le.cs.cl3.phone10;
		cr_phone10                       := le.cs.cr.phone10;
		ne1_phone10                      := le.cs.ne1.phone10;
		ne2_phone10                      := le.cs.ne2.phone10;
		ne3_phone10                      := le.cs.ne3.phone10;
		pp1_phone10                      := le.cs.pp1.phone10;
		pp2_phone10                      := le.cs.pp2.phone10;
		pp3_phone10                      := le.cs.pp3.phone10;
		wk_phone10                       := le.cs.wk.phone10;
		es_eda_did                       := le.cs.es.p_did;
		se1_phone_first_seen             := le.cs.se1.phone_first_seen;
		se2_phone_first_seen             := le.cs.se2.phone_first_seen;
		se3_phone_first_seen             := le.cs.se3.phone_first_seen;
		se4_phone_first_seen             := le.cs.se4.phone_first_seen;
		ap1_phone_first_seen             := le.cs.ap1.phone_first_seen;
		sp_first_seen                    := le.cs.sp.hdr_dt_first_seen;
		md1_phone_first_seen             := le.cs.md1.phone_first_seen;
		cl1_first_seen                   := le.cs.cl1.hdr_dt_first_seen;
		cl2_first_seen                   := le.cs.cl2.hdr_dt_first_seen;
		cl3_first_seen                   := le.cs.cl3.hdr_dt_first_seen;
		ne1_phone_first_seen             := le.cs.ne1.phone_first_seen;
		ne2_phone_first_seen             := le.cs.ne2.phone_first_seen;
		ne3_phone_first_seen             := le.cs.ne3.phone_first_seen;
		pp1_phone_last_seen              := le.cs.pp1.phone_last_seen;
		pp2_phone_last_seen              := le.cs.pp2.phone_last_seen;
		pp3_phone_last_seen              := le.cs.pp3.phone_last_seen;
		wk_phone_first_seen              := le.cs.wk.phone_first_seen;
		ah_add1_first_seen               := le.cs.addr1.dt_first_seen;
		ah_add2_first_seen               := le.cs.addr2.dt_first_seen;
		ah_add3_first_seen               := le.cs.Addr3.dt_first_seen;
		ah_add5_first_seen               := le.cs.addr5.dt_first_seen;
		md1_mo_shared_addr               := le.cs.md1.lengthsharedaddress;
		md2_mo_shared_addr               := le.cs.md2.lengthsharedaddress;
		md1_mo_since_shared_addr         := le.cs.md1.timesincesharedaddress;
		md2_mo_since_shared_addr         := le.cs.md2.timesincesharedaddress;
		cl1_mo_since_shared_addr         := le.cs.cl1.timesincesharedaddress;
		cl2_mo_since_shared_addr         := le.cs.cl2.timesincesharedaddress;
		cl3_mo_since_shared_addr         := le.cs.cl3.timesincesharedaddress;
		cenmatch                         := (integer)(trim(ri.geolink) != '' and trim(ri.geolink) = (trim(le.shell_input.st) + trim(le.shell_input.county) + trim(le.shell_input.geo_blk)));
		adl_addr                         := le.cs.input_flags.adl_addr;
		es_name_match_flag               := le.cs.es.name_match_flag;
		sp_dist                          := le.cs.sp.distance_to_applicant;
		wk_source                        := le.cs.wk.source;
		ah_add1_dist                     := le.cs.addr1.distance_moved;
		ah_add2_dist                     := le.cs.addr2.distance_moved;
		ah_add3_dist                     := le.cs.Addr3.distance_moved;
		ah_add4_dist                     := le.cs.Addr4.distance_moved;
		ah_add5_dist                     := le.cs.addr5.distance_moved;
		pp1_active_phone                 := le.cs.pp1.active_phone;
		pp2_active_phone                 := le.cs.pp2.active_phone;
		pp3_active_phone                 := le.cs.pp3.active_phone;
		wf_hphn                          := le.cs.input_flags.wf_hphn;
		c_bargains                       := ri.bargains;
		c_bel_edu                        := ri.bel_edu;
		c_lowrent                        := ri.lowrent;
		c_med_hval                       := ri.med_hval;
		did                              := le.did;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_st                           := le.shell_input.st;
		out_addr_type                    := le.shell_input.addr_type;
		in_phone10                       := le.shell_input.phone10;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_type                         := le.iid.nap_type;
		nap_status                       := le.iid.nap_status;
		rc_correct_dob                   := le.iid.correctdob;
		rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
		rc_name_addr_phone               := le.iid.name_addr_phone;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnvalflag                    := le.iid.socsvalflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
		rc_areacodesplitdate             := (unsigned)le.iid.areacodesplitdate;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_phonelnamecount               := le.iid.phonelastcount;
		rc_phoneaddrcount                := le.iid.phoneaddrcount;
		rc_utiliaddr_phonecount          := le.iid.utiliaddr_phonecount;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_phonetype                     := le.iid.phonetype;
		rc_cityzipflag                   := le.iid.cityzipflag;
		combo_fnamescore                 := le.iid.combo_firstscore;
		combo_hphonescore                := le.iid.combo_hphonescore;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_lnamecount                 := le.iid.combo_lastcount;
		combo_addrcount                  := le.iid.combo_addrcount;
		combo_hphonecount                := le.iid.combo_hphonecount;
		combo_ssncount                   := le.iid.combo_ssncount;
		combo_dobcount                   := le.iid.combo_dobcount;
		eq_count                         := le.source_verification.eq_count;
		en_count                         := le.source_verification.en_count;
		dl_count                         := le.source_verification.dl_count;
		em_count                         := le.source_verification.em_count;
		vo_count                         := le.source_verification.vo_count;
		em_only_count                    := le.source_verification.em_only_count;
		adl_eq_first_seen                := le.source_verification.adl_eqfs_first_seen;
		adl_en_first_seen                := le.source_verification.adl_en_first_seen;
		adl_dl_first_seen                := le.source_verification.adl_dl_first_seen;
		adl_pr_first_seen                := le.source_verification.adl_pr_first_seen;
		adl_em_first_seen                := le.source_verification.adl_em_first_seen;
		adl_vo_first_seen                := le.source_verification.adl_vo_first_seen;
		adl_em_only_first_seen           := le.source_verification.adl_em_only_first_seen;
		adl_w_first_seen                 := le.source_verification.adl_w_first_seen;
		adl_pr_last_seen                 := le.source_verification.adl_pr_last_seen;
		adl_w_last_seen                  := le.source_verification.adl_w_last_seen;
		em_only_sources                  := le.source_verification.em_only_sources;
		dl_avail                         := le.available_sources.dl;
		voter_avail                      := le.available_sources.voter;
		dobpop                           := le.input_validation.dateofbirth;
		lname_change_date                := le.name_verification.lname_change_date;
		fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
		lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
		util_adl_count                   := le.utility.utili_adl_count;
		util_adl_nap                     := le.utility.utili_adl_nap;
		// util_add1_nap                    := le.utility.utili_addr1_nap;
		util_add2_nap                    := le.utility.utili_addr2_nap;
		add1_address_score               := le.address_verification.input_address_information.address_score;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_lres                        := le.lres;
		add1_avm_recording_date          := le.avm.input_address_information.avm_recording_date;
		add1_avm_assessed_value_year     := le.avm.input_address_information.avm_assessed_value_year;
		add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
		add1_avm_tax_assessed_valuation  := le.avm.input_address_information.avm_tax_assessment_valuation;
		add1_avm_price_index_valuation   := le.avm.input_address_information.avm_price_index_valuation;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_fc_index_fips               := le.address_verification.input_address_information.fips_fc_index;
		add1_fc_index_geo11              := le.address_verification.input_address_information.geo11_fc_index;
		add1_fc_index_geo12              := le.address_verification.input_address_information.geo12_fc_index;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_built_date                  := le.address_verification.input_address_information.built_date;
		add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
		add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
		add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
		add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
		add1_building_area               := le.address_verification.input_address_information.building_area;
		add1_no_of_buildings             := le.address_verification.input_address_information.no_of_buildings;
		add1_no_of_rooms                 := le.address_verification.input_address_information.no_of_rooms;
		add1_no_of_baths                 := le.address_verification.input_address_information.no_of_baths;
		add1_parking_no_of_cars          := le.address_verification.input_address_information.parking_no_of_cars;
		add1_style_code                  := le.address_verification.input_address_information.style_code;
		add1_assessed_value_year         := le.address_verification.input_address_information.assessed_value_year;
		add1_pop                         := le.addrpop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
		property_sold_total              := le.address_verification.sold.property_total;
		prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
		prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
		prop1_prev_purchase_date         := le.address_verification.recent_property_sales.prev_purch_date1;
		prop2_sale_date                  := le.address_verification.recent_property_sales.sale_date2;
		prop2_prev_purchase_date         := le.address_verification.recent_property_sales.prev_purch_date2;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		add2_lres                        := le.lres2;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
		add2_sources                     := le.address_verification.address_history_1.sources;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add2_naprop                      := le.address_verification.address_history_1.naprop;
		add2_land_use_code               := le.address_verification.address_history_1.standardized_land_use_code;
		add2_no_of_buildings             := le.address_verification.address_history_1.no_of_buildings;
		add2_no_of_stories               := le.address_verification.address_history_1.no_of_stories;
		add2_no_of_baths                 := le.address_verification.address_history_1.no_of_baths;
		add2_garage_type_code            := le.address_verification.address_history_1.garage_type_code;
		add2_style_code                  := le.address_verification.address_history_1.style_code;
		add2_assessed_value_year         := le.address_verification.address_history_1.assessed_value_year;
		add2_built_date                  := le.address_verification.address_history_1.built_date;
		add2_purchase_amount             := le.address_verification.address_history_1.purchase_amount;
		add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
		add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
		add2_financing_type              := le.address_verification.address_history_1.type_financing;
		add2_mortgage_due_date           := le.address_verification.address_history_1.first_td_due_date;
		add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
		add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
		add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
		add2_pop                         := le.addrpop2;
		add3_lres                        := le.lres3;
		add3_sources                     := le.address_verification.address_history_2.sources;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		add3_naprop                      := le.address_verification.address_history_2.naprop;
		add3_built_date                  := le.address_verification.address_history_2.built_date;
		add3_purchase_amount             := le.address_verification.address_history_2.purchase_amount;
		add3_mortgage_date               := le.address_verification.address_history_2.mortgage_date;
		add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
		add3_financing_type              := le.address_verification.address_history_2.type_financing;
		add3_mortgage_due_date           := le.address_verification.address_history_2.first_td_due_date;
		add3_assessed_amount             := le.address_verification.address_history_2.assessed_amount;
		add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
		add3_date_last_seen              := le.address_verification.address_history_2.date_last_seen;
		add3_pop                         := le.addrpop3;
		avg_lres                         := le.other_address_info.avg_lres;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_prison_history             := le.other_address_info.isprison;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		nameperssn_count                 := le.ssn_verification.nameperssn_count;
		credit_first_seen                := le.ssn_verification.credit_first_seen;
		header_first_seen                := le.ssn_verification.header_first_seen;
		utility_sourced                  := le.ssn_verification.utility_sourced;
		inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
		invalid_addrs_per_adl_c6         := le.velocity_counters.invalid_addrs_per_adl_created_6months;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		attr_addrs_last30                := le.other_address_info.addrs_last30;
		attr_addrs_last90                := le.other_address_info.addrs_last90;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_date_last_purchase          := le.other_address_info.date_most_recent_purchase;
		attr_num_purchase180             := le.other_address_info.num_purchase180;
		attr_date_last_sale              := le.other_address_info.date_most_recent_sale;
		attr_num_sold60                  := le.other_address_info.num_sold60;
		attr_num_watercraft90            := le.watercraft.watercraft_count90;
		attr_num_watercraft180           := le.watercraft.watercraft_count180;
		attr_num_watercraft24            := le.watercraft.watercraft_count24;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_felonies12                  := le.bjl.criminal_count12;
		attr_felonies24                  := le.bjl.criminal_count24;
		attr_felonies36                  := le.bjl.criminal_count36;
		attr_felonies60                  := le.bjl.criminal_count60;
		attr_arrests24                   := le.bjl.arrests_count24;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		attr_eviction_count30            := le.bjl.eviction_count30;
		attr_eviction_count90            := le.bjl.eviction_count90;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count24            := le.bjl.eviction_count24;
		attr_eviction_count36            := le.bjl.eviction_count36;
		attr_eviction_count60            := le.bjl.eviction_count60;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		attr_num_proflic90               := le.professional_license.proflic_count90;
		attr_num_proflic_exp30           := le.professional_license.expire_count30;
		bankrupt                         := le.bjl.bankrupt;
		filing_type                      := le.bjl.filing_type;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
		liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_lt_first_seen        := le.liens.liens_unreleased_landlord_tenant.earliest_filing_date;
		liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
		liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
		liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		rel_count                        := le.relatives.relative_count;
		rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
		rel_felony_count                 := le.relatives.relative_felony_count;
		crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
		crim_rel_withinother             := le.relatives.criminal_relative_withinother;
		rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
		rel_prop_owned_purchase_total    := le.relatives.owned.relatives_property_owned_purchase_total;
		rel_prop_owned_purchase_count    := le.relatives.owned.relatives_property_owned_purchase_count;
		rel_prop_owned_assessed_total    := le.relatives.owned.relatives_property_owned_assessed_total;
		rel_prop_owned_assessed_count    := le.relatives.owned.relatives_property_owned_assessed_count;
		rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
		rel_prop_sold_purchase_total     := le.relatives.sold.relatives_property_owned_purchase_total;
		rel_prop_sold_assessed_total     := le.relatives.sold.relatives_property_owned_assessed_total;
		rel_within25miles_count          := le.relatives.relative_within25miles_count;
		rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
		rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
		rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
		rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
		rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
		rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
		rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
		rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
		rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
		rel_homeover500_count            := le.relatives.relative_homeover500_count;
		rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
		rel_educationover12_count        := le.relatives.relative_educationover12_count;
		rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
		rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
		rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
		rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
		rel_ageover70_count              := le.relatives.relative_ageover70_count;
		rel_vehicle_owned_count          := le.relatives.relative_vehicle_owned_count;
		rel_count_addr                   := le.relatives.relatives_at_input_address;
		current_count                    := le.vehicles.current_count;
		historical_count                 := le.vehicles.historical_count;
		acc_damage_amt_total             := le.accident_data.acc.dmgamtaccidents;
		acc_damage_amt_last              := le.accident_data.acc.dmgamtlastaccident;
		ams_age                          := le.student.age;
		ams_class                        := le.student.class;
		ams_income_level_code            := le.student.income_level_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		prof_license_category            := le.professional_license.plcategory;
		inferred_age                     := le.inferred_age;
		estimated_income                 := le.estimated_income;
		archive_date                     := le.historydate;
		rc_sources                       := le.iid.sources;
		fname_sources                    := le.Source_Verification.firstnamesources;
		lname_sources                    := le.Source_Verification.lastnamesources;
		addr_sources                     := le.source_verification.addrsources;
		util_adl_type_list               := le.utility.utili_adl_type;
		util_adl_first_seen_list         := le.utility.utili_adl_dt_first_seen;
		util_add1_type_list              := le.utility.utili_addr1_type;
		util_add1_first_seen_list        := le.utility.utili_addr1_dt_first_seen;
		util_add2_type_list              := le.utility.utili_addr2_type;
		util_add2_first_seen_list        := le.utility.utili_addr2_dt_first_seen;
		util_add1_nap                    := le.utility.utili_addr1_nap;


		NULL := -999999999;
		integer sas_ceil( real v ) := if( v < 0, truncate(v), roundup(v) );
		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate :=  map(trim((string)archive_date) = '999999'  => models.common.sas_date((string)if(le.historydate=999999, ut.getdate, (string6)le.historydate+'01')),
						length(trim((string)archive_date)) = 6 => (ut.DaysSince1900((trim((string)archive_date))[1..4], (trim((string)archive_date))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																			   NULL);

		sysyear :=  map(trim((string)archive_date) = '999999'  => year(models.common.sas_date((string)if(le.historydate=999999, ut.getdate, (string6)le.historydate+'01'))),
						length(trim((string)archive_date)) = 6 => (real)(trim((string)archive_date))[1..4],
																			   NULL);
		rc_correct_dob2 := models.common.sas_date((string)rc_correct_dob);
		years_rc_correct_dob := if(rc_correct_dob2=NULL, NULL, ((sysdate - rc_correct_dob2) / 365.25));
		months_rc_correct_dob := if(rc_correct_dob2=NULL, NULL, ((sysdate - rc_correct_dob2) / 30.5));

		rc_ssnhighissue2 := models.common.sas_date((string)rc_ssnhighissue);
		years_rc_ssnhighissue := if(rc_ssnhighissue2=NULL, NULL, ((sysdate - rc_ssnhighissue2) / 365.25));
		months_rc_ssnhighissue := if(rc_ssnhighissue2=NULL, NULL, ((sysdate - rc_ssnhighissue2) / 30.5));

		rc_areacodesplitdate2 := models.common.sas_date((string)rc_areacodesplitdate);
		years_rc_areacodesplitdate := if(rc_areacodesplitdate2=NULL, NULL, ((sysdate - rc_areacodesplitdate2) / 365.25));
		months_rc_areacodesplitdate := if(rc_areacodesplitdate2=NULL, NULL, ((sysdate - rc_areacodesplitdate2) / 30.5));

		adl_eq_first_seen2 := models.common.sas_date((string)adl_eq_first_seen);
		years_adl_eq_first_seen := if(adl_eq_first_seen2=NULL, NULL, ((sysdate - adl_eq_first_seen2) / 365.25));
		months_adl_eq_first_seen := if(adl_eq_first_seen2=NULL, NULL, ((sysdate - adl_eq_first_seen2) / 30.5));

		adl_en_first_seen2 := models.common.sas_date((string)adl_en_first_seen);
		years_adl_en_first_seen := if(adl_en_first_seen2=NULL, NULL, ((sysdate - adl_en_first_seen2) / 365.25));
		months_adl_en_first_seen := if(adl_en_first_seen2=NULL, NULL, ((sysdate - adl_en_first_seen2) / 30.5));

		adl_dl_first_seen2 := models.common.sas_date((string)adl_dl_first_seen);
		years_adl_dl_first_seen := if(adl_dl_first_seen2=NULL, NULL, ((sysdate - adl_dl_first_seen2) / 365.25));
		months_adl_dl_first_seen := if(adl_dl_first_seen2=NULL, NULL, ((sysdate - adl_dl_first_seen2) / 30.5));

		adl_pr_first_seen2 := models.common.sas_date((string)adl_pr_first_seen);
		years_adl_pr_first_seen := if(adl_pr_first_seen2=NULL, NULL, ((sysdate - adl_pr_first_seen2) / 365.25));
		months_adl_pr_first_seen := if(adl_pr_first_seen2=NULL, NULL, ((sysdate - adl_pr_first_seen2) / 30.5));

		adl_em_first_seen2 := models.common.sas_date((string)adl_em_first_seen);
		years_adl_em_first_seen := if(adl_em_first_seen2=NULL, NULL, ((sysdate - adl_em_first_seen2) / 365.25));
		months_adl_em_first_seen := if(adl_em_first_seen2=NULL, NULL, ((sysdate - adl_em_first_seen2) / 30.5));

		adl_vo_first_seen2 := models.common.sas_date((string)adl_vo_first_seen);
		years_adl_vo_first_seen := if(adl_vo_first_seen2=NULL, NULL, ((sysdate - adl_vo_first_seen2) / 365.25));
		months_adl_vo_first_seen := if(adl_vo_first_seen2=NULL, NULL, ((sysdate - adl_vo_first_seen2) / 30.5));

		adl_em_only_first_seen2 := models.common.sas_date((string)adl_em_only_first_seen);
		years_adl_em_only_first_seen := if(adl_em_only_first_seen2=NULL, NULL, ((sysdate - adl_em_only_first_seen2) / 365.25));
		months_adl_em_only_first_seen := if(adl_em_only_first_seen2=NULL, NULL, ((sysdate - adl_em_only_first_seen2) / 30.5));

		adl_w_first_seen2 := models.common.sas_date((string)adl_w_first_seen);
		years_adl_w_first_seen := if(adl_w_first_seen2=NULL, NULL, ((sysdate - adl_w_first_seen2) / 365.25));
		months_adl_w_first_seen := if(adl_w_first_seen2=NULL, NULL, ((sysdate - adl_w_first_seen2) / 30.5));

		adl_pr_last_seen2 := models.common.sas_date((string)adl_pr_last_seen);
		years_adl_pr_last_seen := if(adl_pr_last_seen2=NULL, NULL, ((sysdate - adl_pr_last_seen2) / 365.25));
		months_adl_pr_last_seen := if(adl_pr_last_seen2=NULL, NULL, ((sysdate - adl_pr_last_seen2) / 30.5));

		adl_w_last_seen2 := models.common.sas_date((string)adl_w_last_seen);
		years_adl_w_last_seen := if(adl_w_last_seen2=NULL, NULL, ((sysdate - adl_w_last_seen2) / 365.25));
		months_adl_w_last_seen := if(adl_w_last_seen2=NULL, NULL, ((sysdate - adl_w_last_seen2) / 30.5));

		lname_change_date2 := models.common.sas_date((string)lname_change_date);
		years_lname_change_date := if(lname_change_date2=NULL, NULL, ((sysdate - lname_change_date2) / 365.25));
		months_lname_change_date := if(lname_change_date2=NULL, NULL, ((sysdate - lname_change_date2) / 30.5));

		add1_avm_recording_date2 := models.common.sas_date((string)add1_avm_recording_date);
		years_add1_avm_recording_date := if(add1_avm_recording_date2=NULL, NULL, ((sysdate - add1_avm_recording_date2) / 365.25));
		months_add1_avm_recording_date := if(add1_avm_recording_date2=NULL, NULL, ((sysdate - add1_avm_recording_date2) / 30.5));

		add1_avm_assessed_value_year2 := models.common.sas_date((string)add1_avm_assessed_value_year);
		years_add1_avm_assess_year := if(add1_avm_assessed_value_year2=NULL, NULL, ((sysdate - add1_avm_assessed_value_year2) / 365.25));
		months_add1_avm_assess_year := if(add1_avm_assessed_value_year2=NULL, NULL, ((sysdate - add1_avm_assessed_value_year2) / 30.5));

		add1_built_date2 := models.common.sas_date((string)add1_built_date);
		years_add1_built_date := if(add1_built_date2=NULL, NULL, ((sysdate - add1_built_date2) / 365.25));
		months_add1_built_date := if(add1_built_date2=NULL, NULL, ((sysdate - add1_built_date2) / 30.5));

		add1_mortgage_date2 := models.common.sas_date((string)add1_mortgage_date);
		years_add1_mortgage_date := if(add1_mortgage_date2=NULL, NULL, ((sysdate - add1_mortgage_date2) / 365.25));
		months_add1_mortgage_date := if(add1_mortgage_date2=NULL, NULL, ((sysdate - add1_mortgage_date2) / 30.5));

		add1_mortgage_due_date2 := models.common.sas_date((string)add1_mortgage_due_date);
		years_add1_mortgage_due_date := if(add1_mortgage_due_date2=NULL, NULL, ((sysdate - add1_mortgage_due_date2) / 365.25));
		months_add1_mortgage_due_date := if(add1_mortgage_due_date2=NULL, NULL, ((sysdate - add1_mortgage_due_date2) / 30.5));

		add1_date_first_seen2 := models.common.sas_date((string)add1_date_first_seen);
		years_add1_date_first_seen := if(add1_date_first_seen2=NULL, NULL, ((sysdate - add1_date_first_seen2) / 365.25));
		months_add1_date_first_seen := if(add1_date_first_seen2=NULL, NULL, ((sysdate - add1_date_first_seen2) / 30.5));

		add1_assessed_value_year2 := models.common.sas_date((string)add1_assessed_value_year);
		years_add1_assessed_value_year := if(add1_assessed_value_year2=NULL, NULL, ((sysdate - add1_assessed_value_year2) / 365.25));
		months_add1_assessed_value_year := if(add1_assessed_value_year2=NULL, NULL, ((sysdate - add1_assessed_value_year2) / 30.5));

		prop1_prev_purchase_date2 := models.common.sas_date((string)prop1_prev_purchase_date);
		years_prop1_prev_purchase_date := if(prop1_prev_purchase_date2=NULL, NULL, ((sysdate - prop1_prev_purchase_date2) / 365.25));
		months_prop1_prev_purchase_date := if(prop1_prev_purchase_date2=NULL, NULL, ((sysdate - prop1_prev_purchase_date2) / 30.5));

		prop2_sale_date2 := models.common.sas_date((string)prop2_sale_date);
		years_prop2_sale_date := if(prop2_sale_date2=NULL, NULL, ((sysdate - prop2_sale_date2) / 365.25));
		months_prop2_sale_date := if(prop2_sale_date2=NULL, NULL, ((sysdate - prop2_sale_date2) / 30.5));

		prop2_prev_purchase_date2 := models.common.sas_date((string)prop2_prev_purchase_date);
		years_prop2_prev_purchase_date := if(prop2_prev_purchase_date2=NULL, NULL, ((sysdate - prop2_prev_purchase_date2) / 365.25));
		months_prop2_prev_purchase_date := if(prop2_prev_purchase_date2=NULL, NULL, ((sysdate - prop2_prev_purchase_date2) / 30.5));

		add2_assessed_value_year2 := models.common.sas_date((string)add2_assessed_value_year);
		years_add2_assessed_value_year := if(add2_assessed_value_year2=NULL, NULL, ((sysdate - add2_assessed_value_year2) / 365.25));
		months_add2_assessed_value_year := if(add2_assessed_value_year2=NULL, NULL, ((sysdate - add2_assessed_value_year2) / 30.5));

		add2_built_date2 := models.common.sas_date((string)add2_built_date);
		years_add2_built_date := if(add2_built_date2=NULL, NULL, ((sysdate - add2_built_date2) / 365.25));
		months_add2_built_date := if(add2_built_date2=NULL, NULL, ((sysdate - add2_built_date2) / 30.5));

		add2_mortgage_due_date2 := models.common.sas_date((string)add2_mortgage_due_date);
		years_add2_mortgage_due_date := if(add2_mortgage_due_date2=NULL, NULL, ((sysdate - add2_mortgage_due_date2) / 365.25));
		months_add2_mortgage_due_date := if(add2_mortgage_due_date2=NULL, NULL, ((sysdate - add2_mortgage_due_date2) / 30.5));

		add2_date_first_seen2 := models.common.sas_date((string)add2_date_first_seen);
		years_add2_date_first_seen := if(add2_date_first_seen2=NULL, NULL, ((sysdate - add2_date_first_seen2) / 365.25));
		months_add2_date_first_seen := if(add2_date_first_seen2=NULL, NULL, ((sysdate - add2_date_first_seen2) / 30.5));

		add2_date_last_seen2 := models.common.sas_date((string)add2_date_last_seen);
		years_add2_date_last_seen := if(add2_date_last_seen2=NULL, NULL, ((sysdate - add2_date_last_seen2) / 365.25));
		months_add2_date_last_seen := if(add2_date_last_seen2=NULL, NULL, ((sysdate - add2_date_last_seen2) / 30.5));

		add3_built_date2 := models.common.sas_date((string)add3_built_date);
		years_add3_built_date := if(add3_built_date2=NULL, NULL, ((sysdate - add3_built_date2) / 365.25));
		months_add3_built_date := if(add3_built_date2=NULL, NULL, ((sysdate - add3_built_date2) / 30.5));

		add3_mortgage_date2 := models.common.sas_date((string)add3_mortgage_date);
		years_add3_mortgage_date := if(add3_mortgage_date2=NULL, NULL, ((sysdate - add3_mortgage_date2) / 365.25));
		months_add3_mortgage_date := if(add3_mortgage_date2=NULL, NULL, ((sysdate - add3_mortgage_date2) / 30.5));

		add3_mortgage_due_date2 := models.common.sas_date((string)add3_mortgage_due_date);
		years_add3_mortgage_due_date := if(add3_mortgage_due_date2=NULL, NULL, ((sysdate - add3_mortgage_due_date2) / 365.25));
		months_add3_mortgage_due_date := if(add3_mortgage_due_date2=NULL, NULL, ((sysdate - add3_mortgage_due_date2) / 30.5));

		add3_date_first_seen2 := models.common.sas_date((string)add3_date_first_seen);
		years_add3_date_first_seen := if(add3_date_first_seen2=NULL, NULL, ((sysdate - add3_date_first_seen2) / 365.25));
		months_add3_date_first_seen := if(add3_date_first_seen2=NULL, NULL, ((sysdate - add3_date_first_seen2) / 30.5));

		add3_date_last_seen2 := models.common.sas_date((string)add3_date_last_seen);
		years_add3_date_last_seen := if(add3_date_last_seen2=NULL, NULL, ((sysdate - add3_date_last_seen2) / 365.25));
		months_add3_date_last_seen := if(add3_date_last_seen2=NULL, NULL, ((sysdate - add3_date_last_seen2) / 30.5));

		gong_did_first_seen2 := models.common.sas_date((string)gong_did_first_seen);
		years_gong_did_first_seen := if(gong_did_first_seen2=NULL, NULL, ((sysdate - gong_did_first_seen2) / 365.25));
		months_gong_did_first_seen := if(gong_did_first_seen2=NULL, NULL, ((sysdate - gong_did_first_seen2) / 30.5));

		credit_first_seen2 := models.common.sas_date((string)credit_first_seen);
		years_credit_first_seen := if(credit_first_seen2=NULL, NULL, ((sysdate - credit_first_seen2) / 365.25));
		months_credit_first_seen := if(credit_first_seen2=NULL, NULL, ((sysdate - credit_first_seen2) / 30.5));

		header_first_seen2 := models.common.sas_date((string)header_first_seen);
		years_header_first_seen := if(header_first_seen2=NULL, NULL, ((sysdate - header_first_seen2) / 365.25));
		months_header_first_seen := if(header_first_seen2=NULL, NULL, ((sysdate - header_first_seen2) / 30.5));

		infutor_first_seen2 := models.common.sas_date((string)infutor_first_seen);
		years_infutor_first_seen := if(infutor_first_seen2=NULL, NULL, ((sysdate - infutor_first_seen2) / 365.25));
		months_infutor_first_seen := if(infutor_first_seen2=NULL, NULL, ((sysdate - infutor_first_seen2) / 30.5));

		attr_date_last_purchase2 := models.common.sas_date((string)attr_date_last_purchase);
		years_attr_date_last_purchase := if(attr_date_last_purchase2=NULL, NULL, ((sysdate - attr_date_last_purchase2) / 365.25));
		months_attr_date_last_purchase := if(attr_date_last_purchase2=NULL, NULL, ((sysdate - attr_date_last_purchase2) / 30.5));

		attr_date_last_sale2 := models.common.sas_date((string)attr_date_last_sale);
		years_attr_date_last_sale := if(attr_date_last_sale2=NULL, NULL, ((sysdate - attr_date_last_sale2) / 365.25));
		months_attr_date_last_sale := if(attr_date_last_sale2=NULL, NULL, ((sysdate - attr_date_last_sale2) / 30.5));

		attr_date_last_eviction2 := models.common.sas_date((string)attr_date_last_eviction);
		years_attr_date_last_eviction := if(attr_date_last_eviction2=NULL, NULL, ((sysdate - attr_date_last_eviction2) / 365.25));
		months_attr_date_last_eviction := if(attr_date_last_eviction2=NULL, NULL, ((sysdate - attr_date_last_eviction2) / 30.5));

		liens_unrel_cj_first_seen2 := models.common.sas_date((string)liens_unrel_cj_first_seen);
		years_liens_unrel_cj_first_seen := if(liens_unrel_cj_first_seen2=NULL, NULL, ((sysdate - liens_unrel_cj_first_seen2) / 365.25));
		months_liens_unrel_cj_first_seen := if(liens_unrel_cj_first_seen2=NULL, NULL, ((sysdate - liens_unrel_cj_first_seen2) / 30.5));

		liens_unrel_lt_first_seen2 := models.common.sas_date((string)liens_unrel_lt_first_seen);
		years_liens_unrel_lt_first_seen := if(liens_unrel_lt_first_seen2=NULL, NULL, ((sysdate - liens_unrel_lt_first_seen2) / 365.25));
		months_liens_unrel_lt_first_seen := if(liens_unrel_lt_first_seen2=NULL, NULL, ((sysdate - liens_unrel_lt_first_seen2) / 30.5));

		liens_unrel_ot_first_seen2 := models.common.sas_date((string)liens_unrel_ot_first_seen);
		years_liens_unrel_ot_first_seen := if(liens_unrel_ot_first_seen2=NULL, NULL, ((sysdate - liens_unrel_ot_first_seen2) / 365.25));
		months_liens_unrel_ot_first_seen := if(liens_unrel_ot_first_seen2=NULL, NULL, ((sysdate - liens_unrel_ot_first_seen2) / 30.5));

		liens_unrel_sc_first_seen2 := models.common.sas_date((string)liens_unrel_sc_first_seen);
		years_liens_unrel_sc_first_seen := if(liens_unrel_sc_first_seen2=NULL, NULL, ((sysdate - liens_unrel_sc_first_seen2) / 365.25));
		months_liens_unrel_sc_first_seen := if(liens_unrel_sc_first_seen2=NULL, NULL, ((sysdate - liens_unrel_sc_first_seen2) / 30.5));

		criminal_last_date2 := models.common.sas_date((string)criminal_last_date);
		years_criminal_last_date := if(criminal_last_date2=NULL, NULL, ((sysdate - criminal_last_date2) / 365.25));
		months_criminal_last_date := if(criminal_last_date2=NULL, NULL, ((sysdate - criminal_last_date2) / 30.5));



		/* RC SOURCES */
		models.common.findw(rc_sources,'AK',' ,','I', source_tot_AK, 'int'); // source_tot_AK:=
		models.common.findw(rc_sources,'AM',' ,','I', source_tot_AM, 'int'); // source_tot_AM:=
		models.common.findw(rc_sources,'AR',' ,','I', source_tot_AR, 'int'); // source_tot_AR:=
		models.common.findw(rc_sources,'BA',' ,','I', source_tot_BA, 'int'); // source_tot_BA:=
		models.common.findw(rc_sources,'CG',' ,','I', source_tot_CG, 'int'); // source_tot_CG:=
		models.common.findw(rc_sources,'CO',' ,','I', source_tot_CO, 'int'); // source_tot_CO:=
		models.common.findw(rc_sources,'CY',' ,','I', source_tot_CY, 'int'); // source_tot_CY:=
		models.common.findw(rc_sources,'DA',' ,','I', source_tot_DA, 'int'); // source_tot_DA:=
		models.common.findw(rc_sources,'D' ,' ,','I', source_tot_D , 'int'); // source_tot_D :=
		models.common.findw(rc_sources,'DL',' ,','I', source_tot_DL, 'int'); // source_tot_DL:=
		models.common.findw(rc_sources,'DS',' ,','I', source_tot_DS, 'int'); // source_tot_DS:=
		models.common.findw(rc_sources,'EB',' ,','I', source_tot_EB, 'int'); // source_tot_EB:=
		models.common.findw(rc_sources,'EM',' ,','I', source_tot_EM, 'int'); // source_tot_EM:=
		models.common.findw(rc_sources,'VO',' ,','I', source_tot_VO, 'int'); // source_tot_VO:=
		models.common.findw(rc_sources,'EQ',' ,','I', source_tot_EQ, 'int'); // source_tot_EQ:=
		models.common.findw(rc_sources,'FF',' ,','I', source_tot_FF, 'int'); // source_tot_FF:=
		models.common.findw(rc_sources,'FR',' ,','I', source_tot_FR, 'int'); // source_tot_FR:=
		models.common.findw(rc_sources,'L2',' ,','I', source_tot_L2, 'int'); // source_tot_L2:=
		models.common.findw(rc_sources,'LI',' ,','I', source_tot_LI, 'int'); // source_tot_LI:=
		models.common.findw(rc_sources,'MW',' ,','I', source_tot_MW, 'int'); // source_tot_MW:=
		models.common.findw(rc_sources,'NT',' ,','I', source_tot_NT, 'int'); // source_tot_NT:=
		models.common.findw(rc_sources,'P' ,' ,','I', source_tot_P , 'int'); // source_tot_P :=
		models.common.findw(rc_sources,'PL',' ,','I', source_tot_PL, 'int'); // source_tot_PL:=
		models.common.findw(rc_sources,'SL',' ,','I', source_tot_SL, 'int'); // source_tot_SL:=
		models.common.findw(rc_sources,'TU',' ,','I', source_tot_TU, 'int'); // source_tot_TU:=
		models.common.findw(rc_sources,'V' ,' ,','I', source_tot_V , 'int'); // source_tot_V :=
		models.common.findw(rc_sources,'W' ,' ,','I', source_tot_W , 'int'); // source_tot_W :=
		models.common.findw(rc_sources,'WP',' ,','I', source_tot_WP, 'int'); // source_tot_WP:=

		source_tot_DrLic := (source_tot_D=1 or source_tot_DL=1);

		source_tot_voter := (1=source_tot_EM or 1=source_tot_VO);


		source_tot_count  := (integer)sum( source_tot_AK,source_tot_AM,source_tot_AR,source_tot_BA
				,source_tot_CG,source_tot_CO,source_tot_CY,source_tot_DA
				,source_tot_D ,source_tot_DL,source_tot_DS,source_tot_EB
				,source_tot_EM,source_tot_VO,source_tot_EQ,source_tot_FF
				,source_tot_FR,source_tot_L2,source_tot_LI,source_tot_MW
				,source_tot_NT,source_tot_P ,source_tot_PL,source_tot_SL
				,source_tot_TU,source_tot_V ,source_tot_W ,source_tot_WP);

		source_tot_count_pos := sum( source_tot_AM,source_tot_AR,source_tot_CY,source_tot_D
				,source_tot_DL,source_tot_EB,source_tot_EM,source_tot_VO
				,source_tot_EQ,source_tot_MW,source_tot_P ,source_tot_PL
				,source_tot_SL,source_tot_TU,source_tot_V ,source_tot_W
				,source_tot_WP);

		source_tot_count_neg := sum( source_tot_AK,source_tot_BA,source_tot_CG,source_tot_CO
				,source_tot_DA,source_tot_DS,source_tot_FF,source_tot_FR
				,source_tot_L2,source_tot_LI,source_tot_NT  );

		source_tot_count_fcrapos := sum( source_tot_AM,source_tot_AR
				,source_tot_EB,source_tot_EM,source_tot_VO
				,source_tot_EQ,source_tot_MW                    ,source_tot_PL
				,source_tot_SL                                        ,source_tot_W
				,source_tot_WP);

		source_tot_count_fcraneg := sum( source_tot_AK,source_tot_BA,source_tot_CG,source_tot_CO
				,source_tot_DA,source_tot_DS,source_tot_FF
				,source_tot_L2                    );


		source_tot_total := models.common.countw(rc_sources,' ,');

		source_tot_other := ( source_tot_total > source_tot_count);
		/* RC SOURCES */


		/* FNAME SOURCES */
		models.common.findw(fname_sources,'AK',' ,','I', source_fst_AK, 'int'); // source_fst_AK:=
		models.common.findw(fname_sources,'AM',' ,','I', source_fst_AM, 'int'); // source_fst_AM:=
		models.common.findw(fname_sources,'AR',' ,','I', source_fst_AR, 'int'); // source_fst_AR:=
		models.common.findw(fname_sources,'BA',' ,','I', source_fst_BA, 'int'); // source_fst_BA:=
		models.common.findw(fname_sources,'CG',' ,','I', source_fst_CG, 'int'); // source_fst_CG:=
		models.common.findw(fname_sources,'CO',' ,','I', source_fst_CO, 'int'); // source_fst_CO:=
		models.common.findw(fname_sources,'CY',' ,','I', source_fst_CY, 'int'); // source_fst_CY:=
		models.common.findw(fname_sources,'DA',' ,','I', source_fst_DA, 'int'); // source_fst_DA:=
		models.common.findw(fname_sources,'D' ,' ,','I', source_fst_D , 'int'); // source_fst_D :=
		models.common.findw(fname_sources,'DL',' ,','I', source_fst_DL, 'int'); // source_fst_DL:=
		models.common.findw(fname_sources,'DS',' ,','I', source_fst_DS, 'int'); // source_fst_DS:=
		models.common.findw(fname_sources,'EB',' ,','I', source_fst_EB, 'int'); // source_fst_EB:=
		models.common.findw(fname_sources,'EM',' ,','I', source_fst_EM, 'int'); // source_fst_EM:=
		models.common.findw(fname_sources,'VO',' ,','I', source_fst_VO, 'int'); // source_fst_VO:=
		models.common.findw(fname_sources,'EQ',' ,','I', source_fst_EQ, 'int'); // source_fst_EQ:=
		models.common.findw(fname_sources,'FF',' ,','I', source_fst_FF, 'int'); // source_fst_FF:=
		models.common.findw(fname_sources,'FR',' ,','I', source_fst_FR, 'int'); // source_fst_FR:=
		models.common.findw(fname_sources,'L2',' ,','I', source_fst_L2, 'int'); // source_fst_L2:=
		models.common.findw(fname_sources,'LI',' ,','I', source_fst_LI, 'int'); // source_fst_LI:=
		models.common.findw(fname_sources,'MW',' ,','I', source_fst_MW, 'int'); // source_fst_MW:=
		models.common.findw(fname_sources,'NT',' ,','I', source_fst_NT, 'int'); // source_fst_NT:=
		models.common.findw(fname_sources,'P' ,' ,','I', source_fst_P , 'int'); // source_fst_P :=
		models.common.findw(fname_sources,'PL',' ,','I', source_fst_PL, 'int'); // source_fst_PL:=
		models.common.findw(fname_sources,'SL',' ,','I', source_fst_SL, 'int'); // source_fst_SL:=
		models.common.findw(fname_sources,'TU',' ,','I', source_fst_TU, 'int'); // source_fst_TU:=
		models.common.findw(fname_sources,'V' ,' ,','I', source_fst_V , 'int'); // source_fst_V :=
		models.common.findw(fname_sources,'W' ,' ,','I', source_fst_W , 'int'); // source_fst_W :=
		models.common.findw(fname_sources,'WP',' ,','I', source_fst_WP, 'int'); // source_fst_WP:=

		source_fst_DrLic := (1=source_fst_D or 1=source_fst_DL);

		source_fst_voter := (1=source_fst_EM or 1=source_fst_VO);


		source_fst_count  := (integer)sum( source_fst_AK,source_fst_AM,source_fst_AR,source_fst_BA
				,source_fst_CG,source_fst_CO,source_fst_CY,source_fst_DA
				,source_fst_D ,source_fst_DL,source_fst_DS,source_fst_EB
				,source_fst_EM,source_fst_VO,source_fst_EQ,source_fst_FF
				,source_fst_FR,source_fst_L2,source_fst_LI,source_fst_MW
				,source_fst_NT,source_fst_P ,source_fst_PL,source_fst_SL
				,source_fst_TU,source_fst_V ,source_fst_W ,source_fst_WP);

		source_fst_count_pos := sum( source_fst_AM,source_fst_AR,source_fst_CY,source_fst_D
				,source_fst_DL,source_fst_EB,source_fst_EM,source_fst_VO
				,source_fst_EQ,source_fst_MW,source_fst_P ,source_fst_PL
				,source_fst_SL,source_fst_TU,source_fst_V ,source_fst_W
				,source_fst_WP);

		source_fst_count_neg := sum( source_fst_AK,source_fst_BA,source_fst_CG,source_fst_CO
				,source_fst_DA,source_fst_DS,source_fst_FF,source_fst_FR
				,source_fst_L2,source_fst_LI,source_fst_NT  );

		source_fst_count_fcrapos := sum( source_fst_AM,source_fst_AR
				,source_fst_EB,source_fst_EM,source_fst_VO
				,source_fst_EQ,source_fst_MW                    ,source_fst_PL
				,source_fst_SL                                        ,source_fst_W
				,source_fst_WP);

		source_fst_count_fcraneg := sum( source_fst_AK,source_fst_BA,source_fst_CG,source_fst_CO
				,source_fst_DA,source_fst_DS,source_fst_FF
				,source_fst_L2                    );


		source_fst_total := models.common.countw(fname_sources,' ,');

		source_fst_other := ( source_fst_total > source_fst_count);
		/* FNAME SOURCES */

		/* LNAME SOURCES */
		models.common.findw(lname_sources,'AK',' ,','I', source_lst_AK, 'int'); // source_lst_AK:=
		models.common.findw(lname_sources,'AM',' ,','I', source_lst_AM, 'int'); // source_lst_AM:=
		models.common.findw(lname_sources,'AR',' ,','I', source_lst_AR, 'int'); // source_lst_AR:=
		models.common.findw(lname_sources,'BA',' ,','I', source_lst_BA, 'int'); // source_lst_BA:=
		models.common.findw(lname_sources,'CG',' ,','I', source_lst_CG, 'int'); // source_lst_CG:=
		models.common.findw(lname_sources,'CO',' ,','I', source_lst_CO, 'int'); // source_lst_CO:=
		models.common.findw(lname_sources,'CY',' ,','I', source_lst_CY, 'int'); // source_lst_CY:=
		models.common.findw(lname_sources,'DA',' ,','I', source_lst_DA, 'int'); // source_lst_DA:=
		models.common.findw(lname_sources,'D' ,' ,','I', source_lst_D , 'int'); // source_lst_D :=
		models.common.findw(lname_sources,'DL',' ,','I', source_lst_DL, 'int'); // source_lst_DL:=
		models.common.findw(lname_sources,'DS',' ,','I', source_lst_DS, 'int'); // source_lst_DS:=
		models.common.findw(lname_sources,'EB',' ,','I', source_lst_EB, 'int'); // source_lst_EB:=
		models.common.findw(lname_sources,'EM',' ,','I', source_lst_EM, 'int'); // source_lst_EM:=
		models.common.findw(lname_sources,'VO',' ,','I', source_lst_VO, 'int'); // source_lst_VO:=
		models.common.findw(lname_sources,'EQ',' ,','I', source_lst_EQ, 'int'); // source_lst_EQ:=
		models.common.findw(lname_sources,'FF',' ,','I', source_lst_FF, 'int'); // source_lst_FF:=
		models.common.findw(lname_sources,'FR',' ,','I', source_lst_FR, 'int'); // source_lst_FR:=
		models.common.findw(lname_sources,'L2',' ,','I', source_lst_L2, 'int'); // source_lst_L2:=
		models.common.findw(lname_sources,'LI',' ,','I', source_lst_LI, 'int'); // source_lst_LI:=
		models.common.findw(lname_sources,'MW',' ,','I', source_lst_MW, 'int'); // source_lst_MW:=
		models.common.findw(lname_sources,'NT',' ,','I', source_lst_NT, 'int'); // source_lst_NT:=
		models.common.findw(lname_sources,'P' ,' ,','I', source_lst_P , 'int'); // source_lst_P :=
		models.common.findw(lname_sources,'PL',' ,','I', source_lst_PL, 'int'); // source_lst_PL:=
		models.common.findw(lname_sources,'SL',' ,','I', source_lst_SL, 'int'); // source_lst_SL:=
		models.common.findw(lname_sources,'TU',' ,','I', source_lst_TU, 'int'); // source_lst_TU:=
		models.common.findw(lname_sources,'V' ,' ,','I', source_lst_V , 'int'); // source_lst_V :=
		models.common.findw(lname_sources,'W' ,' ,','I', source_lst_W , 'int'); // source_lst_W :=
		models.common.findw(lname_sources,'WP',' ,','I', source_lst_WP, 'int'); // source_lst_WP:=

		source_lst_DrLic := (1=source_lst_D or 1=source_lst_DL);

		source_lst_voter := (1=source_lst_EM or 1=source_lst_VO);


		source_lst_count  := (integer)sum( source_lst_AK,source_lst_AM,source_lst_AR,source_lst_BA
				,source_lst_CG,source_lst_CO,source_lst_CY,source_lst_DA
				,source_lst_D ,source_lst_DL,source_lst_DS,source_lst_EB
				,source_lst_EM,source_lst_VO,source_lst_EQ,source_lst_FF
				,source_lst_FR,source_lst_L2,source_lst_LI,source_lst_MW
				,source_lst_NT,source_lst_P ,source_lst_PL,source_lst_SL
				,source_lst_TU,source_lst_V ,source_lst_W ,source_lst_WP);

		source_lst_count_pos := sum( source_lst_AM,source_lst_AR,source_lst_CY,source_lst_D
				,source_lst_DL,source_lst_EB,source_lst_EM,source_lst_VO
				,source_lst_EQ,source_lst_MW,source_lst_P ,source_lst_PL
				,source_lst_SL,source_lst_TU,source_lst_V ,source_lst_W
				,source_lst_WP);

		source_lst_count_neg := sum( source_lst_AK,source_lst_BA,source_lst_CG,source_lst_CO
				,source_lst_DA,source_lst_DS,source_lst_FF,source_lst_FR
				,source_lst_L2,source_lst_LI,source_lst_NT  );

		source_lst_count_fcrapos := sum( source_lst_AM,source_lst_AR
				,source_lst_EB,source_lst_EM,source_lst_VO
				,source_lst_EQ,source_lst_MW                    ,source_lst_PL
				,source_lst_SL                                        ,source_lst_W
				,source_lst_WP);

		source_lst_count_fcraneg := sum( source_lst_AK,source_lst_BA,source_lst_CG,source_lst_CO
				,source_lst_DA,source_lst_DS,source_lst_FF
				,source_lst_L2                    );


		source_lst_total := models.common.countw(lname_sources,' ,');

		source_lst_other := ( source_lst_total > source_lst_count);
		/* LNAME SOURCES */



		/* ADDR SOURCES */
		models.common.findw(addr_sources,'AK',' ,','I', source_add_AK, 'int'); // source_add_AK:=
		models.common.findw(addr_sources,'AM',' ,','I', source_add_AM, 'int'); // source_add_AM:=
		models.common.findw(addr_sources,'AR',' ,','I', source_add_AR, 'int'); // source_add_AR:=
		models.common.findw(addr_sources,'BA',' ,','I', source_add_BA, 'int'); // source_add_BA:=
		models.common.findw(addr_sources,'CG',' ,','I', source_add_CG, 'int'); // source_add_CG:=
		models.common.findw(addr_sources,'CO',' ,','I', source_add_CO, 'int'); // source_add_CO:=
		models.common.findw(addr_sources,'CY',' ,','I', source_add_CY, 'int'); // source_add_CY:=
		models.common.findw(addr_sources,'DA',' ,','I', source_add_DA, 'int'); // source_add_DA:=
		models.common.findw(addr_sources,'D' ,' ,','I', source_add_D , 'int'); // source_add_D :=
		models.common.findw(addr_sources,'DL',' ,','I', source_add_DL, 'int'); // source_add_DL:=
		models.common.findw(addr_sources,'DS',' ,','I', source_add_DS, 'int'); // source_add_DS:=
		models.common.findw(addr_sources,'EB',' ,','I', source_add_EB, 'int'); // source_add_EB:=
		models.common.findw(addr_sources,'EM',' ,','I', source_add_EM, 'int'); // source_add_EM:=
		models.common.findw(addr_sources,'VO',' ,','I', source_add_VO, 'int'); // source_add_VO:=
		models.common.findw(addr_sources,'EQ',' ,','I', source_add_EQ, 'int'); // source_add_EQ:=
		models.common.findw(addr_sources,'FF',' ,','I', source_add_FF, 'int'); // source_add_FF:=
		models.common.findw(addr_sources,'FR',' ,','I', source_add_FR, 'int'); // source_add_FR:=
		models.common.findw(addr_sources,'L2',' ,','I', source_add_L2, 'int'); // source_add_L2:=
		models.common.findw(addr_sources,'LI',' ,','I', source_add_LI, 'int'); // source_add_LI:=
		models.common.findw(addr_sources,'MW',' ,','I', source_add_MW, 'int'); // source_add_MW:=
		models.common.findw(addr_sources,'NT',' ,','I', source_add_NT, 'int'); // source_add_NT:=
		models.common.findw(addr_sources,'P' ,' ,','I', source_add_P , 'int'); // source_add_P :=
		models.common.findw(addr_sources,'PL',' ,','I', source_add_PL, 'int'); // source_add_PL:=
		models.common.findw(addr_sources,'SL',' ,','I', source_add_SL, 'int'); // source_add_SL:=
		models.common.findw(addr_sources,'TU',' ,','I', source_add_TU, 'int'); // source_add_TU:=
		models.common.findw(addr_sources,'V' ,' ,','I', source_add_V , 'int'); // source_add_V :=
		models.common.findw(addr_sources,'W' ,' ,','I', source_add_W , 'int'); // source_add_W :=
		models.common.findw(addr_sources,'WP',' ,','I', source_add_WP, 'int'); // source_add_WP:=

		source_add_DrLic := (1=source_add_D or 1=source_add_DL);

		source_add_voter := (1=source_add_EM or 1=source_add_VO);


		source_add_count  := (integer)sum( source_add_AK,source_add_AM,source_add_AR,source_add_BA
				,source_add_CG,source_add_CO,source_add_CY,source_add_DA
				,source_add_D ,source_add_DL,source_add_DS,source_add_EB
				,source_add_EM,source_add_VO,source_add_EQ,source_add_FF
				,source_add_FR,source_add_L2,source_add_LI,source_add_MW
				,source_add_NT,source_add_P ,source_add_PL,source_add_SL
				,source_add_TU,source_add_V ,source_add_W ,source_add_WP);

		source_add_count_pos := sum( source_add_AM,source_add_AR,source_add_CY,source_add_D
				,source_add_DL,source_add_EB,source_add_EM,source_add_VO
				,source_add_EQ,source_add_MW,source_add_P ,source_add_PL
				,source_add_SL,source_add_TU,source_add_V ,source_add_W
				,source_add_WP);

		source_add_count_neg := sum( source_add_AK,source_add_BA,source_add_CG,source_add_CO
				,source_add_DA,source_add_DS,source_add_FF,source_add_FR
				,source_add_L2,source_add_LI,source_add_NT  );

		source_add_count_fcrapos := sum( source_add_AM,source_add_AR
				,source_add_EB,source_add_EM,source_add_VO
				,source_add_EQ,source_add_MW                    ,source_add_PL
				,source_add_SL                                        ,source_add_W
				,source_add_WP);

		source_add_count_fcraneg := sum( source_add_AK,source_add_BA,source_add_CG,source_add_CO
				,source_add_DA,source_add_DS,source_add_FF
				,source_add_L2                    );


		source_add_total := models.common.countw(addr_sources,' ,');

		source_add_other := ( source_add_total > source_add_count);
		/* ADDR SOURCES */

		/* ADDR2 SOURCES */
		models.common.findw(add2_sources,'AK',' ,','I', source_add2_AK, 'int'); // source_add2_AK:=
		models.common.findw(add2_sources,'AM',' ,','I', source_add2_AM, 'int'); // source_add2_AM:=
		models.common.findw(add2_sources,'AR',' ,','I', source_add2_AR, 'int'); // source_add2_AR:=
		models.common.findw(add2_sources,'BA',' ,','I', source_add2_BA, 'int'); // source_add2_BA:=
		models.common.findw(add2_sources,'CG',' ,','I', source_add2_CG, 'int'); // source_add2_CG:=
		models.common.findw(add2_sources,'CO',' ,','I', source_add2_CO, 'int'); // source_add2_CO:=
		models.common.findw(add2_sources,'CY',' ,','I', source_add2_CY, 'int'); // source_add2_CY:=
		models.common.findw(add2_sources,'DA',' ,','I', source_add2_DA, 'int'); // source_add2_DA:=
		models.common.findw(add2_sources,'D' ,' ,','I', source_add2_D , 'int'); // source_add2_D :=
		models.common.findw(add2_sources,'DL',' ,','I', source_add2_DL, 'int'); // source_add2_DL:=
		models.common.findw(add2_sources,'DS',' ,','I', source_add2_DS, 'int'); // source_add2_DS:=
		models.common.findw(add2_sources,'EB',' ,','I', source_add2_EB, 'int'); // source_add2_EB:=
		models.common.findw(add2_sources,'EM',' ,','I', source_add2_EM, 'int'); // source_add2_EM:=
		models.common.findw(add2_sources,'E1',' ,','I', source_add2_E1, 'int'); // source_add2_E1:=
		models.common.findw(add2_sources,'E2',' ,','I', source_add2_E2, 'int'); // source_add2_E2:=
		models.common.findw(add2_sources,'E3',' ,','I', source_add2_E3, 'int'); // source_add2_E3:=
		models.common.findw(add2_sources,'E4',' ,','I', source_add2_E4, 'int'); // source_add2_E4:=
		models.common.findw(add2_sources,'VO',' ,','I', source_add2_VO, 'int'); // source_add2_VO:=
		models.common.findw(add2_sources,'EQ',' ,','I', source_add2_EQ, 'int'); // source_add2_EQ:=
		models.common.findw(add2_sources,'FF',' ,','I', source_add2_FF, 'int'); // source_add2_FF:=
		models.common.findw(add2_sources,'FR',' ,','I', source_add2_FR, 'int'); // source_add2_FR:=
		models.common.findw(add2_sources,'L2',' ,','I', source_add2_L2, 'int'); // source_add2_L2:=
		models.common.findw(add2_sources,'LI',' ,','I', source_add2_LI, 'int'); // source_add2_LI:=
		models.common.findw(add2_sources,'MW',' ,','I', source_add2_MW, 'int'); // source_add2_MW:=
		models.common.findw(add2_sources,'NT',' ,','I', source_add2_NT, 'int'); // source_add2_NT:=
		models.common.findw(add2_sources,'P' ,' ,','I', source_add2_P , 'int'); // source_add2_P :=
		models.common.findw(add2_sources,'PL',' ,','I', source_add2_PL, 'int'); // source_add2_PL:=
		models.common.findw(add2_sources,'SL',' ,','I', source_add2_SL, 'int'); // source_add2_SL:=
		models.common.findw(add2_sources,'TU',' ,','I', source_add2_TU, 'int'); // source_add2_TU:=
		models.common.findw(add2_sources,'V' ,' ,','I', source_add2_V , 'int'); // source_add2_V :=
		models.common.findw(add2_sources,'W' ,' ,','I', source_add2_W , 'int'); // source_add2_W :=
		models.common.findw(add2_sources,'WP',' ,','I', source_add2_WP, 'int'); // source_add2_WP:=

		source_add2_DrLic := (1=source_add2_D or 1=source_add2_DL);

		source_add2_voter := (1=source_add2_EM or 1=source_add2_VO);


		source_add2_count  := (integer)sum( source_add2_AK,source_add2_AM,source_add2_AR,source_add2_BA
				,source_add2_CG,source_add2_CO,source_add2_CY,source_add2_DA
				,source_add2_D ,source_add2_DL,source_add2_DS,source_add2_EB
				,source_add2_EM,source_add2_VO,source_add2_EQ,source_add2_FF
				,source_add2_FR,source_add2_L2,source_add2_LI,source_add2_MW
				,source_add2_NT,source_add2_P ,source_add2_PL,source_add2_SL
				,source_add2_TU,source_add2_V ,source_add2_W ,source_add2_WP
				,source_add2_E1,source_add2_E2,source_add2_E3,source_add2_E4);

		source_add2_count_pos := sum( source_add2_AM,source_add2_AR,source_add2_CY,source_add2_D
				,source_add2_DL,source_add2_EB,source_add2_EM,source_add2_VO
				,source_add2_EQ,source_add2_MW,source_add2_P ,source_add2_PL
				,source_add2_SL,source_add2_TU,source_add2_V ,source_add2_W
				,source_add2_WP
				,source_add2_E1,source_add2_E2,source_add2_E3,source_add2_E4);

		source_add2_count_neg := sum( source_add2_AK,source_add2_BA,source_add2_CG,source_add2_CO
				,source_add2_DA,source_add2_DS,source_add2_FF,source_add2_FR
				,source_add2_L2,source_add2_LI,source_add2_NT  );

		source_add2_count_fcrapos := sum( source_add2_AM,source_add2_AR
				,source_add2_EB,source_add2_EM,source_add2_VO
				,source_add2_EQ,source_add2_MW                    ,source_add2_PL
				,source_add2_SL                                        ,source_add2_W
				,source_add2_WP
				,source_add2_E1,source_add2_E2,source_add2_E3,source_add2_E4);

		source_add2_count_fcraneg := sum( source_add2_AK,source_add2_BA,source_add2_CG,source_add2_CO
				,source_add2_DA,source_add2_DS,source_add2_FF
				,source_add2_L2                    );


		source_add2_total := models.common.countw(add2_sources,' ,');

		source_add2_other := ( source_add2_total > source_add2_count);
		/* ADDR2 SOURCES */

		/* ADDR2 SOURCES */
		models.common.findw(add3_sources,'AK',' ,','I', source_add3_AK, 'int'); // source_add3_AK:=
		models.common.findw(add3_sources,'AM',' ,','I', source_add3_AM, 'int'); // source_add3_AM:=
		models.common.findw(add3_sources,'AR',' ,','I', source_add3_AR, 'int'); // source_add3_AR:=
		models.common.findw(add3_sources,'BA',' ,','I', source_add3_BA, 'int'); // source_add3_BA:=
		models.common.findw(add3_sources,'CG',' ,','I', source_add3_CG, 'int'); // source_add3_CG:=
		models.common.findw(add3_sources,'CO',' ,','I', source_add3_CO, 'int'); // source_add3_CO:=
		models.common.findw(add3_sources,'CY',' ,','I', source_add3_CY, 'int'); // source_add3_CY:=
		models.common.findw(add3_sources,'DA',' ,','I', source_add3_DA, 'int'); // source_add3_DA:=
		models.common.findw(add3_sources,'D' ,' ,','I', source_add3_D , 'int'); // source_add3_D :=
		models.common.findw(add3_sources,'DL',' ,','I', source_add3_DL, 'int'); // source_add3_DL:=
		models.common.findw(add3_sources,'DS',' ,','I', source_add3_DS, 'int'); // source_add3_DS:=
		models.common.findw(add3_sources,'EB',' ,','I', source_add3_EB, 'int'); // source_add3_EB:=
		models.common.findw(add3_sources,'EM',' ,','I', source_add3_EM, 'int'); // source_add3_EM:=
		models.common.findw(add3_sources,'E1',' ,','I', source_add3_E1, 'int'); // source_add3_E1:=
		models.common.findw(add3_sources,'E2',' ,','I', source_add3_E2, 'int'); // source_add3_E2:=
		models.common.findw(add3_sources,'E3',' ,','I', source_add3_E3, 'int'); // source_add3_E3:=
		models.common.findw(add3_sources,'E4',' ,','I', source_add3_E4, 'int'); // source_add3_E4:=
		models.common.findw(add3_sources,'VO',' ,','I', source_add3_VO, 'int'); // source_add3_VO:=
		models.common.findw(add3_sources,'EQ',' ,','I', source_add3_EQ, 'int'); // source_add3_EQ:=
		models.common.findw(add3_sources,'FF',' ,','I', source_add3_FF, 'int'); // source_add3_FF:=
		models.common.findw(add3_sources,'FR',' ,','I', source_add3_FR, 'int'); // source_add3_FR:=
		models.common.findw(add3_sources,'L2',' ,','I', source_add3_L2, 'int'); // source_add3_L2:=
		models.common.findw(add3_sources,'LI',' ,','I', source_add3_LI, 'int'); // source_add3_LI:=
		models.common.findw(add3_sources,'MW',' ,','I', source_add3_MW, 'int'); // source_add3_MW:=
		models.common.findw(add3_sources,'NT',' ,','I', source_add3_NT, 'int'); // source_add3_NT:=
		models.common.findw(add3_sources,'P' ,' ,','I', source_add3_P , 'int'); // source_add3_P :=
		models.common.findw(add3_sources,'PL',' ,','I', source_add3_PL, 'int'); // source_add3_PL:=
		models.common.findw(add3_sources,'SL',' ,','I', source_add3_SL, 'int'); // source_add3_SL:=
		models.common.findw(add3_sources,'TU',' ,','I', source_add3_TU, 'int'); // source_add3_TU:=
		models.common.findw(add3_sources,'V' ,' ,','I', source_add3_V , 'int'); // source_add3_V :=
		models.common.findw(add3_sources,'W' ,' ,','I', source_add3_W , 'int'); // source_add3_W :=
		models.common.findw(add3_sources,'WP',' ,','I', source_add3_WP, 'int'); // source_add3_WP:=

		source_add3_DrLic := (1=source_add3_D or 1=source_add3_DL);

		source_add3_voter := (1=source_add3_EM or 1=source_add3_VO);


		source_add3_count  := (integer)sum( source_add3_AK,source_add3_AM,source_add3_AR,source_add3_BA
				,source_add3_CG,source_add3_CO,source_add3_CY,source_add3_DA
				,source_add3_D ,source_add3_DL,source_add3_DS,source_add3_EB
				,source_add3_EM,source_add3_VO,source_add3_EQ,source_add3_FF
				,source_add3_FR,source_add3_L2,source_add3_LI,source_add3_MW
				,source_add3_NT,source_add3_P ,source_add3_PL,source_add3_SL
				,source_add3_TU,source_add3_V ,source_add3_W ,source_add3_WP
				,source_add3_E1,source_add3_E2,source_add3_E3,source_add3_E4);

		source_add3_count_pos := sum( source_add3_AM,source_add3_AR,source_add3_CY,source_add3_D
				,source_add3_DL,source_add3_EB,source_add3_EM,source_add3_VO
				,source_add3_EQ,source_add3_MW,source_add3_P ,source_add3_PL
				,source_add3_SL,source_add3_TU,source_add3_V ,source_add3_W
				,source_add3_WP
				,source_add3_E1,source_add3_E2,source_add3_E3,source_add3_E4);

		source_add3_count_neg := sum( source_add3_AK,source_add3_BA,source_add3_CG,source_add3_CO
				,source_add3_DA,source_add3_DS,source_add3_FF,source_add3_FR
				,source_add3_L2,source_add3_LI,source_add3_NT  );

		source_add3_count_fcrapos := sum( source_add3_AM,source_add3_AR
				,source_add3_EB,source_add3_EM,source_add3_VO
				,source_add3_EQ,source_add3_MW                    ,source_add3_PL
				,source_add3_SL                                        ,source_add3_W
				,source_add3_WP
				,source_add3_E1,source_add3_E2,source_add3_E3,source_add3_E4);

		source_add3_count_fcraneg := sum( source_add3_AK,source_add3_BA,source_add3_CG,source_add3_CO
				,source_add3_DA,source_add3_DS,source_add3_FF
				,source_add3_L2                    );


		source_add3_total := models.common.countw(add3_sources,' ,');

		source_add3_other := ( source_add3_total > source_add3_count);
		/* ADDR2 SOURCES */


		models.common.findw(em_only_sources, 'EM', ' ,', 'I', em_only_source_EM, 'int'); // em_only_source_EM := 
		models.common.findw(em_only_sources, 'E1', ' ,', 'I', em_only_source_E1, 'int'); // em_only_source_E1 := 
		models.common.findw(em_only_sources, 'E2', ' ,', 'I', em_only_source_E2, 'int'); // em_only_source_E2 := 
		models.common.findw(em_only_sources, 'E3', ' ,', 'I', em_only_source_E3, 'int'); // em_only_source_E3 := 
		models.common.findw(em_only_sources, 'E4', ' ,', 'I', em_only_source_E4, 'int'); // em_only_source_E4 := 



		// utilSources := ['A','C','D','E','F','G','H','I','L','N','O','P','S','T','U','V','W','Z'];

		util_adl_zipped := models.common.zip2(util_adl_type_list, util_adl_first_seen_list );
		util_add1_zipped := models.common.zip2(util_add1_type_list, util_add1_first_seen_list );
		util_add2_zipped := models.common.zip2(util_add2_type_list, util_add2_first_seen_list );

		getUtilDate( string8 in_date ) := if( length(trim(in_date)) not in [4,6,8], NULL, min((integer)in_date, (integer)models.common.sas_date(in_date)));

		boolean has( string haystack, string needle ) := (StringLib.StringFind(haystack, needle, 1) > 0);
		do_util( in_zipped, in_type, out_exists, out_FS, out_years, out_months ) := MACRO
			#uniquename(util_exists)
			%util_exists% := exists(in_zipped(has(str1,in_type)));
			out_exists := if( %util_exists%, 1, 0 );
			out_FS := if( %util_exists%, getUtilDate( in_zipped(has(str1,in_type))[1].str2 ), NULL );
			
			out_years := if(out_FS=NULL, NULL, (sysdate-out_FS)/365.25);
			out_months:= if(out_FS=NULL, NULL, (sysdate-out_FS)/30.5);
		endmacro;

		do_util( util_adl_zipped, 'A', util_adl_A, util_adl_A_firstseen, years_util_adl_A_firstseen, months_util_adl_A_firstseen );
		do_util( util_adl_zipped, 'C', util_adl_C, util_adl_C_firstseen, years_util_adl_C_firstseen, months_util_adl_C_firstseen );
		do_util( util_adl_zipped, 'D', util_adl_D, util_adl_D_firstseen, years_util_adl_D_firstseen, months_util_adl_D_firstseen );
		do_util( util_adl_zipped, 'E', util_adl_E, util_adl_E_firstseen, years_util_adl_E_firstseen, months_util_adl_E_firstseen );
		do_util( util_adl_zipped, 'F', util_adl_F, util_adl_F_firstseen, years_util_adl_F_firstseen, months_util_adl_F_firstseen );
		do_util( util_adl_zipped, 'G', util_adl_G, util_adl_G_firstseen, years_util_adl_G_firstseen, months_util_adl_G_firstseen );
		do_util( util_adl_zipped, 'H', util_adl_H, util_adl_H_firstseen, years_util_adl_H_firstseen, months_util_adl_H_firstseen );
		do_util( util_adl_zipped, 'I', util_adl_I, util_adl_I_firstseen, years_util_adl_I_firstseen, months_util_adl_I_firstseen );
		do_util( util_adl_zipped, 'L', util_adl_L, util_adl_L_firstseen, years_util_adl_L_firstseen, months_util_adl_L_firstseen );
		do_util( util_adl_zipped, 'N', util_adl_N, util_adl_N_firstseen, years_util_adl_N_firstseen, months_util_adl_N_firstseen );
		do_util( util_adl_zipped, 'O', util_adl_O, util_adl_O_firstseen, years_util_adl_O_firstseen, months_util_adl_O_firstseen );
		do_util( util_adl_zipped, 'P', util_adl_P, util_adl_P_firstseen, years_util_adl_P_firstseen, months_util_adl_P_firstseen );
		do_util( util_adl_zipped, 'S', util_adl_S, util_adl_S_firstseen, years_util_adl_S_firstseen, months_util_adl_S_firstseen );
		do_util( util_adl_zipped, 'T', util_adl_T, util_adl_T_firstseen, years_util_adl_T_firstseen, months_util_adl_T_firstseen );
		do_util( util_adl_zipped, 'U', util_adl_U, util_adl_U_firstseen, years_util_adl_U_firstseen, months_util_adl_U_firstseen );
		do_util( util_adl_zipped, 'V', util_adl_V, util_adl_V_firstseen, years_util_adl_V_firstseen, months_util_adl_V_firstseen );
		do_util( util_adl_zipped, 'W', util_adl_W, util_adl_W_firstseen, years_util_adl_W_firstseen, months_util_adl_W_firstseen );
		do_util( util_adl_zipped, 'Z', util_adl_Z, util_adl_Z_firstseen, years_util_adl_Z_firstseen, months_util_adl_Z_firstseen );

		util_adl_source_count := (integer)sum( util_adl_A ,util_adl_C ,util_adl_D ,util_adl_E ,util_adl_F ,util_adl_G ,util_adl_H ,util_adl_I ,util_adl_L ,util_adl_N ,util_adl_O ,util_adl_P ,util_adl_S ,util_adl_T ,util_adl_U ,util_adl_V ,util_adl_W ,util_adl_Z);
		util_adl_sourced := ( util_adl_source_count > 0);
		max_years_util_adl_firstseen := max( years_util_adl_A_firstseen ,years_util_adl_C_firstseen ,years_util_adl_D_firstseen ,years_util_adl_E_firstseen ,years_util_adl_F_firstseen ,years_util_adl_G_firstseen ,years_util_adl_H_firstseen ,years_util_adl_I_firstseen ,years_util_adl_L_firstseen ,years_util_adl_N_firstseen ,years_util_adl_O_firstseen ,years_util_adl_P_firstseen ,years_util_adl_S_firstseen ,years_util_adl_T_firstseen ,years_util_adl_U_firstseen ,years_util_adl_V_firstseen ,years_util_adl_W_firstseen ,years_util_adl_Z_firstseen); 

		do_util( util_add1_zipped, 'A', util_add1_A, util_add1_A_firstseen, years_util_add1_A_firstseen, months_util_add1_A_firstseen );
		do_util( util_add1_zipped, 'C', util_add1_C, util_add1_C_firstseen, years_util_add1_C_firstseen, months_util_add1_C_firstseen );
		do_util( util_add1_zipped, 'D', util_add1_D, util_add1_D_firstseen, years_util_add1_D_firstseen, months_util_add1_D_firstseen );
		do_util( util_add1_zipped, 'E', util_add1_E, util_add1_E_firstseen, years_util_add1_E_firstseen, months_util_add1_E_firstseen );
		do_util( util_add1_zipped, 'F', util_add1_F, util_add1_F_firstseen, years_util_add1_F_firstseen, months_util_add1_F_firstseen );
		do_util( util_add1_zipped, 'G', util_add1_G, util_add1_G_firstseen, years_util_add1_G_firstseen, months_util_add1_G_firstseen );
		do_util( util_add1_zipped, 'H', util_add1_H, util_add1_H_firstseen, years_util_add1_H_firstseen, months_util_add1_H_firstseen );
		do_util( util_add1_zipped, 'I', util_add1_I, util_add1_I_firstseen, years_util_add1_I_firstseen, months_util_add1_I_firstseen );
		do_util( util_add1_zipped, 'L', util_add1_L, util_add1_L_firstseen, years_util_add1_L_firstseen, months_util_add1_L_firstseen );
		do_util( util_add1_zipped, 'N', util_add1_N, util_add1_N_firstseen, years_util_add1_N_firstseen, months_util_add1_N_firstseen );
		do_util( util_add1_zipped, 'O', util_add1_O, util_add1_O_firstseen, years_util_add1_O_firstseen, months_util_add1_O_firstseen );
		do_util( util_add1_zipped, 'P', util_add1_P, util_add1_P_firstseen, years_util_add1_P_firstseen, months_util_add1_P_firstseen );
		do_util( util_add1_zipped, 'S', util_add1_S, util_add1_S_firstseen, years_util_add1_S_firstseen, months_util_add1_S_firstseen );
		do_util( util_add1_zipped, 'T', util_add1_T, util_add1_T_firstseen, years_util_add1_T_firstseen, months_util_add1_T_firstseen );
		do_util( util_add1_zipped, 'U', util_add1_U, util_add1_U_firstseen, years_util_add1_U_firstseen, months_util_add1_U_firstseen );
		do_util( util_add1_zipped, 'V', util_add1_V, util_add1_V_firstseen, years_util_add1_V_firstseen, months_util_add1_V_firstseen );
		do_util( util_add1_zipped, 'W', util_add1_W, util_add1_W_firstseen, years_util_add1_W_firstseen, months_util_add1_W_firstseen );
		do_util( util_add1_zipped, 'Z', util_add1_Z, util_add1_Z_firstseen, years_util_add1_Z_firstseen, months_util_add1_Z_firstseen );

		util_add1_source_count := (integer)sum( util_add1_A ,util_add1_C ,util_add1_D ,util_add1_E ,util_add1_F ,util_add1_G ,util_add1_H ,util_add1_I ,util_add1_L ,util_add1_N ,util_add1_O ,util_add1_P ,util_add1_S ,util_add1_T ,util_add1_U ,util_add1_V ,util_add1_W ,util_add1_Z);
		util_add1_sourced := ( util_add1_source_count > 0);
		max_years_util_add1_firstseen := max( years_util_add1_A_firstseen ,years_util_add1_C_firstseen ,years_util_add1_D_firstseen ,years_util_add1_E_firstseen ,years_util_add1_F_firstseen ,years_util_add1_G_firstseen ,years_util_add1_H_firstseen ,years_util_add1_I_firstseen ,years_util_add1_L_firstseen ,years_util_add1_N_firstseen ,years_util_add1_O_firstseen ,years_util_add1_P_firstseen ,years_util_add1_S_firstseen ,years_util_add1_T_firstseen ,years_util_add1_U_firstseen ,years_util_add1_V_firstseen ,years_util_add1_W_firstseen ,years_util_add1_Z_firstseen); 



		do_util( util_add2_zipped, 'A', util_add2_A, util_add2_A_firstseen, years_util_add2_A_firstseen, months_util_add2_A_firstseen );
		do_util( util_add2_zipped, 'C', util_add2_C, util_add2_C_firstseen, years_util_add2_C_firstseen, months_util_add2_C_firstseen );
		do_util( util_add2_zipped, 'D', util_add2_D, util_add2_D_firstseen, years_util_add2_D_firstseen, months_util_add2_D_firstseen );
		do_util( util_add2_zipped, 'E', util_add2_E, util_add2_E_firstseen, years_util_add2_E_firstseen, months_util_add2_E_firstseen );
		do_util( util_add2_zipped, 'F', util_add2_F, util_add2_F_firstseen, years_util_add2_F_firstseen, months_util_add2_F_firstseen );
		do_util( util_add2_zipped, 'G', util_add2_G, util_add2_G_firstseen, years_util_add2_G_firstseen, months_util_add2_G_firstseen );
		do_util( util_add2_zipped, 'H', util_add2_H, util_add2_H_firstseen, years_util_add2_H_firstseen, months_util_add2_H_firstseen );
		do_util( util_add2_zipped, 'I', util_add2_I, util_add2_I_firstseen, years_util_add2_I_firstseen, months_util_add2_I_firstseen );
		do_util( util_add2_zipped, 'L', util_add2_L, util_add2_L_firstseen, years_util_add2_L_firstseen, months_util_add2_L_firstseen );
		do_util( util_add2_zipped, 'N', util_add2_N, util_add2_N_firstseen, years_util_add2_N_firstseen, months_util_add2_N_firstseen );
		do_util( util_add2_zipped, 'O', util_add2_O, util_add2_O_firstseen, years_util_add2_O_firstseen, months_util_add2_O_firstseen );
		do_util( util_add2_zipped, 'P', util_add2_P, util_add2_P_firstseen, years_util_add2_P_firstseen, months_util_add2_P_firstseen );
		do_util( util_add2_zipped, 'S', util_add2_S, util_add2_S_firstseen, years_util_add2_S_firstseen, months_util_add2_S_firstseen );
		do_util( util_add2_zipped, 'T', util_add2_T, util_add2_T_firstseen, years_util_add2_T_firstseen, months_util_add2_T_firstseen );
		do_util( util_add2_zipped, 'U', util_add2_U, util_add2_U_firstseen, years_util_add2_U_firstseen, months_util_add2_U_firstseen );
		do_util( util_add2_zipped, 'V', util_add2_V, util_add2_V_firstseen, years_util_add2_V_firstseen, months_util_add2_V_firstseen );
		do_util( util_add2_zipped, 'W', util_add2_W, util_add2_W_firstseen, years_util_add2_W_firstseen, months_util_add2_W_firstseen );
		do_util( util_add2_zipped, 'Z', util_add2_Z, util_add2_Z_firstseen, years_util_add2_Z_firstseen, months_util_add2_Z_firstseen );

		util_add2_source_count := (integer)sum( util_add2_A ,util_add2_C ,util_add2_D ,util_add2_E ,util_add2_F ,util_add2_G ,util_add2_H ,util_add2_I ,util_add2_L ,util_add2_N ,util_add2_O ,util_add2_P ,util_add2_S ,util_add2_T ,util_add2_U ,util_add2_V ,util_add2_W ,util_add2_Z);
		util_add2_sourced := ( util_add2_source_count > 0);
		max_years_util_add2_firstseen := max( years_util_add2_A_firstseen ,years_util_add2_C_firstseen ,years_util_add2_D_firstseen ,years_util_add2_E_firstseen ,years_util_add2_F_firstseen ,years_util_add2_G_firstseen ,years_util_add2_H_firstseen ,years_util_add2_I_firstseen ,years_util_add2_L_firstseen ,years_util_add2_N_firstseen ,years_util_add2_O_firstseen ,years_util_add2_P_firstseen ,years_util_add2_S_firstseen ,years_util_add2_T_firstseen ,years_util_add2_U_firstseen ,years_util_add2_V_firstseen ,years_util_add2_W_firstseen ,years_util_add2_Z_firstseen); 


       verfst_p     := (integer)( nap_summary in [2,3,4,8,9,10,12]  );
       verlst_p     := (integer)( nap_summary in [2,5,7,8,9,11,12]  );
       veradd_p     := (integer)( nap_summary in [3,5,6,8,10,11,12] );
       verphn_p     := (integer)( nap_summary in [4,6,7,9,10,11,12] );

       ver_phncount := sum ( verfst_p, verlst_p, veradd_p, verphn_p );


       years_adl_first_seen_max_fcra := max(years_adl_eq_first_seen
                                          ,years_adl_en_first_seen
                                          ,years_adl_pr_first_seen
                                          ,years_adl_em_first_seen
                                          ,years_adl_vo_first_seen
                                          ,years_adl_em_only_first_seen
                                          ,years_adl_w_first_seen);

       months_adl_first_seen_max_fcra := max(months_adl_eq_first_seen
                                           ,months_adl_en_first_seen
                                           ,months_adl_pr_first_seen
                                           ,months_adl_em_first_seen
                                           ,months_adl_vo_first_seen
                                           ,months_adl_em_only_first_seen
                                           ,months_adl_w_first_seen);

       /**************************** end: Verification ****************************/
pk_Repl_Addr_Matches_Input_m := 0.0;

       /**************************** start: Fraud Point  ****************************/



       /*  Address */
       add_apt := ( StringLib.StringToUpperCase(trim(rc_dwelltype)) = 'A'
                 or StringLib.StringToUpperCase(trim(out_addr_type))='H'
                 or out_unit_desig != ' '
                 or out_sec_range != ' ' );

       /*  Phone */
       phn_disconnected := ( rc_hriskphoneflag='5' ); /* consistent with reason code */
       phn_inval := (rc_phonevalflag='0' or rc_hphonevalflag='0' or rc_phonetype in ['5'] );


       phn_highrisk2 := ( rc_hriskphoneflag not in ['0','7'] );
       phn_cellpager := ( rc_hriskphoneflag in ['1','2','3'] or rc_hphonetypeflag in ['1','2','3'] );
       phn_zipmismatch := (rc_phonezipflag='1' or rc_pwphonezipflag='1');
       phn_residential    := (rc_hphonevalflag = '2' );

       /*  SSN */
       ssn_priordob := ( rc_ssndobflag = '1' or rc_pwssndobflag='1');
       ssn_inval := (rc_ssnvalflag='1' or rc_pwssnvalflag in ['1','2','3'] );
       ssn_issued18 := ( rc_pwssnvalflag = '5' );
       ssn_deceased := (rc_decsflag='1'  or  1=source_tot_ds );
       ssn_prob := ( ssn_deceased or ssn_priordob or ssn_inval );


       /**************************** end: Fraud Point  ****************************/




       /********** start: Address Verification             **********/

		ADD1_AVM_MED := map(
			   ADD1_AVM_MED_GEO12  > 0 => ADD1_AVM_MED_GEO12,
			   ADD1_AVM_MED_GEO11  > 0 => ADD1_AVM_MED_GEO11,
			   ADD1_AVM_MED_FIPS
		);

		add1_avm_to_med_ratio := map(
			   add1_avm_automated_valuation>0 and ADD1_AVM_MED>0   => add1_avm_automated_valuation/ADD1_AVM_MED,
			   NULL
		);

		add1_fc_index := map(
			   add1_fc_index_geo12  > 0 => add1_fc_index_geo12,
			   add1_fc_index_geo11  > 0 => add1_fc_index_geo11,
			   add1_fc_index_fips
		);

		add2_AVM_MED := map(
			   add2_AVM_MED_GEO12  > 0 => add2_AVM_MED_GEO12,
			   add2_AVM_MED_GEO11  > 0 => add2_AVM_MED_GEO11,
			   add2_AVM_MED_FIPS
		);


       prop_owned_flag := ( property_owned_total  > 0 );
       prop_sold_flag  := ( property_sold_total   > 0 );


       // add_lres_year_avg := mean(years_add1_date_first_seen,years_add2_date_first_seen,years_add3_date_first_seen);
       add_lres_year_avg := if( years_add1_date_first_seen=NULL AND years_add2_date_first_seen=NULL AND years_add3_date_first_seen=NULL, NULL,
			(
				if(years_add1_date_first_seen=NULL, 0, years_add1_date_first_seen)
			   +if(years_add2_date_first_seen=NULL, 0, years_add2_date_first_seen)
			   +if(years_add3_date_first_seen=NULL, 0, years_add3_date_first_seen)
			)
			/ ((integer)(years_add1_date_first_seen!=NULL) + (integer)(years_add2_date_first_seen!=NULL) + (integer)(years_add3_date_first_seen!=NULL))
		);
       add_lres_year_max :=  max(years_add1_date_first_seen,years_add2_date_first_seen,years_add3_date_first_seen);


       /********** end: Address Verification             **********/


       bk_flag := (   rc_bansflag in ['1','2']
                  or 1=source_tot_BA
                  or bankrupt
                  /* or bk_sourced=1 */
                  or filing_count > 0
                  or bk_recent_count > 0
                  ) ;


		crime_flag := ( criminal_count > 0 );
		crime_felony_flag := (felony_count>0 );
		crime_drug_flag := ( crime_flag or 1=source_tot_DA);

		rc82 := if( rc_name_addr_phone != in_phone10 AND length(trim(in_phone10))=10 AND length(trim(rc_name_addr_phone))=10, 1, 0 );

      /* PK Code Starts Here */

       did_populated :=     ( did > 0 );


      /* Collections Shell */

		pk_es_phone10_pop   := if((integer)es_phone10   > 0 , 1, 0 );
		pk_se1_phone10_pop  := if((integer)se1_phone10  > 0 , 1, 0 );
		pk_se2_phone10_pop  := if((integer)se2_phone10  > 0 , 1, 0 );
		pk_se3_phone10_pop  := if((integer)se3_phone10  > 0 , 1, 0 );
		pk_se4_phone10_pop  := if((integer)se4_phone10  > 0 , 1, 0 );
		pk_ap1_phone10_pop  := if((integer)ap1_phone10  > 0 , 1, 0 );
		pk_ap2_phone10_pop  := if((integer)ap2_phone10  > 0 , 1, 0 );
		pk_ap3_phone10_pop  := if((integer)ap3_phone10  > 0 , 1, 0 );
		pk_sx1_phone10_pop  := if((integer)sx1_phone10  > 0 , 1, 0 );
		pk_sx2_phone10_pop  := if((integer)sx2_phone10  > 0 , 1, 0 );
		pk_sp_phone10_pop   := if((integer)sp_phone10   > 0 , 1, 0 );
		pk_md1_phone10_pop  := if((integer)md1_phone10  > 0 , 1, 0 );
		pk_md2_phone10_pop  := if((integer)md2_phone10  > 0 , 1, 0 );
		pk_cl1_phone10_pop  := if((integer)cl1_phone10  > 0 , 1, 0 );
		pk_cl2_phone10_pop  := if((integer)cl2_phone10  > 0 , 1, 0 );
		pk_cl3_phone10_pop  := if((integer)cl3_phone10  > 0 , 1, 0 );
		pk_cr_phone10_pop   := if((integer)cr_phone10   > 0 , 1, 0 );
		pk_ne1_phone10_pop  := if((integer)ne1_phone10  > 0 , 1, 0 );
		pk_ne2_phone10_pop  := if((integer)ne2_phone10  > 0 , 1, 0 );
		pk_ne3_phone10_pop  := if((integer)ne3_phone10  > 0 , 1, 0 );
		pk_pp1_phone10_pop  := if((integer)pp1_phone10  > 0 , 1, 0 );
		pk_pp2_phone10_pop  := if((integer)pp2_phone10  > 0 , 1, 0 );
		pk_pp3_phone10_pop  := if((integer)pp3_phone10  > 0 , 1, 0 );
		pk_wk_phone10_pop   := if((integer)wk_phone10   > 0 , 1, 0 );

		pk_es_eda_did_match := map(
			   (( did <= 0 ) and ( es_eda_did  > 0 ))        =>  -2,
			   ( did <= 0 )                                  =>  -3,
			   (( es_eda_did  > 0 ) and ( es_eda_did = did )) =>   1,
			   ( es_eda_did  > 0 )                           =>   0,
			   ( es_eda_did <= 0 )                           =>  -1,
			   -9
		);


		pk_es_phone_count := sum( pk_es_phone10_pop );
		pk_se_phone_count := sum( pk_se1_phone10_pop, pk_se2_phone10_pop, pk_se3_phone10_pop, pk_se4_phone10_pop );
		pk_ap_phone_count := sum( pk_ap1_phone10_pop, pk_ap2_phone10_pop, pk_ap3_phone10_pop );
		pk_sx_phone_count := sum( pk_sx1_phone10_pop, pk_sx2_phone10_pop );
		pk_sp_phone_count := sum( pk_sp_phone10_pop );
		pk_md_phone_count := sum( pk_md1_phone10_pop, pk_md2_phone10_pop );
		pk_cl_phone_count := sum( pk_cl1_phone10_pop, pk_cl2_phone10_pop, pk_cl3_phone10_pop );
		pk_cr_phone_count := sum( pk_cr_phone10_pop );
		pk_ne_phone_count := sum( pk_ne1_phone10_pop, pk_ne2_phone10_pop, pk_ne3_phone10_pop );
		pk_pp_phone_count := sum( pk_pp1_phone10_pop, pk_pp2_phone10_pop, pk_pp3_phone10_pop );
		pk_wk_phone_count := sum( pk_wk_phone10_pop );

		pk_waterfall_phone_count := sum( pk_es_phone_count, pk_se_phone_count, pk_ap_phone_count, pk_sx_phone_count, pk_sp_phone_count,
                                       pk_md_phone_count, pk_cl_phone_count, pk_cr_phone_count,  pk_ne_phone_count, pk_pp_phone_count, pk_wk_phone_count );

		se1_phone_first_seen2 := models.common.sas_date((string)se1_phone_first_seen);
		years_se1_phone_first_seen := if(se1_phone_first_seen2=NULL, NULL, ((sysdate - se1_phone_first_seen2) / 365.25));
		months_se1_phone_first_seen := if(se1_phone_first_seen2=NULL, NULL, ((sysdate - se1_phone_first_seen2) / 30.5));

		se2_phone_first_seen2 := models.common.sas_date((string)se2_phone_first_seen);
		years_se2_phone_first_seen := if(se2_phone_first_seen2=NULL, NULL, ((sysdate - se2_phone_first_seen2) / 365.25));
		months_se2_phone_first_seen := if(se2_phone_first_seen2=NULL, NULL, ((sysdate - se2_phone_first_seen2) / 30.5));

		se3_phone_first_seen2 := models.common.sas_date((string)se3_phone_first_seen);
		years_se3_phone_first_seen := if(se3_phone_first_seen2=NULL, NULL, ((sysdate - se3_phone_first_seen2) / 365.25));
		months_se3_phone_first_seen := if(se3_phone_first_seen2=NULL, NULL, ((sysdate - se3_phone_first_seen2) / 30.5));

		se4_phone_first_seen2 := models.common.sas_date((string)se4_phone_first_seen);
		years_se4_phone_first_seen := if(se4_phone_first_seen2=NULL, NULL, ((sysdate - se4_phone_first_seen2) / 365.25));
		months_se4_phone_first_seen := if(se4_phone_first_seen2=NULL, NULL, ((sysdate - se4_phone_first_seen2) / 30.5));

		ap1_phone_first_seen2 := models.common.sas_date((string)ap1_phone_first_seen);
		years_ap1_phone_first_seen := if(ap1_phone_first_seen2=NULL, NULL, ((sysdate - ap1_phone_first_seen2) / 365.25));
		months_ap1_phone_first_seen := if(ap1_phone_first_seen2=NULL, NULL, ((sysdate - ap1_phone_first_seen2) / 30.5));

		sp_first_seen2 := models.common.sas_date((string)sp_first_seen);
		years_sp_first_seen := if(sp_first_seen2=NULL, NULL, ((sysdate - sp_first_seen2) / 365.25));
		months_sp_first_seen := if(sp_first_seen2=NULL, NULL, ((sysdate - sp_first_seen2) / 30.5));

		md1_phone_first_seen2 := models.common.sas_date((string)md1_phone_first_seen);
		years_md1_phone_first_seen := if(md1_phone_first_seen2=NULL, NULL, ((sysdate - md1_phone_first_seen2) / 365.25));
		months_md1_phone_first_seen := if(md1_phone_first_seen2=NULL, NULL, ((sysdate - md1_phone_first_seen2) / 30.5));

		cl1_first_seen2 := models.common.sas_date((string)cl1_first_seen);
		years_cl1_first_seen := if(cl1_first_seen2=NULL, NULL, ((sysdate - cl1_first_seen2) / 365.25));
		months_cl1_first_seen := if(cl1_first_seen2=NULL, NULL, ((sysdate - cl1_first_seen2) / 30.5));

		cl2_first_seen2 := models.common.sas_date((string)cl2_first_seen);
		years_cl2_first_seen := if(cl2_first_seen2=NULL, NULL, ((sysdate - cl2_first_seen2) / 365.25));
		months_cl2_first_seen := if(cl2_first_seen2=NULL, NULL, ((sysdate - cl2_first_seen2) / 30.5));

		cl3_first_seen2 := models.common.sas_date((string)cl3_first_seen);
		years_cl3_first_seen := if(cl3_first_seen2=NULL, NULL, ((sysdate - cl3_first_seen2) / 365.25));
		months_cl3_first_seen := if(cl3_first_seen2=NULL, NULL, ((sysdate - cl3_first_seen2) / 30.5));

		ne1_phone_first_seen2 := models.common.sas_date((string)ne1_phone_first_seen);
		years_ne1_phone_first_seen := if(ne1_phone_first_seen2=NULL, NULL, ((sysdate - ne1_phone_first_seen2) / 365.25));
		months_ne1_phone_first_seen := if(ne1_phone_first_seen2=NULL, NULL, ((sysdate - ne1_phone_first_seen2) / 30.5));

		ne2_phone_first_seen2 := models.common.sas_date((string)ne2_phone_first_seen);
		years_ne2_phone_first_seen := if(ne2_phone_first_seen2=NULL, NULL, ((sysdate - ne2_phone_first_seen2) / 365.25));
		months_ne2_phone_first_seen := if(ne2_phone_first_seen2=NULL, NULL, ((sysdate - ne2_phone_first_seen2) / 30.5));

		ne3_phone_first_seen2 := models.common.sas_date((string)ne3_phone_first_seen);
		years_ne3_phone_first_seen := if(ne3_phone_first_seen2=NULL, NULL, ((sysdate - ne3_phone_first_seen2) / 365.25));
		months_ne3_phone_first_seen := if(ne3_phone_first_seen2=NULL, NULL, ((sysdate - ne3_phone_first_seen2) / 30.5));

		pp1_phone_last_seen2 := models.common.sas_date((string)pp1_phone_last_seen);
		years_pp1_phone_last_seen := if(pp1_phone_last_seen2=NULL, NULL, ((sysdate - pp1_phone_last_seen2) / 365.25));
		months_pp1_phone_last_seen := if(pp1_phone_last_seen2=NULL, NULL, ((sysdate - pp1_phone_last_seen2) / 30.5));

		pp2_phone_last_seen2 := models.common.sas_date((string)pp2_phone_last_seen);
		years_pp2_phone_last_seen := if(pp2_phone_last_seen2=NULL, NULL, ((sysdate - pp2_phone_last_seen2) / 365.25));
		months_pp2_phone_last_seen := if(pp2_phone_last_seen2=NULL, NULL, ((sysdate - pp2_phone_last_seen2) / 30.5));

		pp3_phone_last_seen2 := models.common.sas_date((string)pp3_phone_last_seen);
		years_pp3_phone_last_seen := if(pp3_phone_last_seen2=NULL, NULL, ((sysdate - pp3_phone_last_seen2) / 365.25));
		months_pp3_phone_last_seen := if(pp3_phone_last_seen2=NULL, NULL, ((sysdate - pp3_phone_last_seen2) / 30.5));

		wk_phone_first_seen2 := models.common.sas_date((string)wk_phone_first_seen);
		years_wk_phone_first_seen := if(wk_phone_first_seen2=NULL, NULL, ((sysdate - wk_phone_first_seen2) / 365.25));
		months_wk_phone_first_seen := if(wk_phone_first_seen2=NULL, NULL, ((sysdate - wk_phone_first_seen2) / 30.5));

		ah_add1_first_seen2 := models.common.sas_date((string)ah_add1_first_seen);
		years_ah_add1_first_seen := if(ah_add1_first_seen2=NULL, NULL, ((sysdate - ah_add1_first_seen2) / 365.25));
		months_ah_add1_first_seen := if(ah_add1_first_seen2=NULL, NULL, ((sysdate - ah_add1_first_seen2) / 30.5));

		ah_add2_first_seen2 := models.common.sas_date((string)ah_add2_first_seen);
		years_ah_add2_first_seen := if(ah_add2_first_seen2=NULL, NULL, ((sysdate - ah_add2_first_seen2) / 365.25));
		months_ah_add2_first_seen := if(ah_add2_first_seen2=NULL, NULL, ((sysdate - ah_add2_first_seen2) / 30.5));

		ah_add3_first_seen2 := models.common.sas_date((string)ah_add3_first_seen);
		years_ah_add3_first_seen := if(ah_add3_first_seen2=NULL, NULL, ((sysdate - ah_add3_first_seen2) / 365.25));
		months_ah_add3_first_seen := if(ah_add3_first_seen2=NULL, NULL, ((sysdate - ah_add3_first_seen2) / 30.5));

		ah_add5_first_seen2 := models.common.sas_date((string)ah_add5_first_seen);
		years_ah_add5_first_seen := if(ah_add5_first_seen2=NULL, NULL, ((sysdate - ah_add5_first_seen2) / 365.25));
		months_ah_add5_first_seen := if(ah_add5_first_seen2=NULL, NULL, ((sysdate - ah_add5_first_seen2) / 30.5));

		pk_years_se1_phone_first_seen := if (years_se1_phone_first_seen >= 0, roundup(years_se1_phone_first_seen), truncate(years_se1_phone_first_seen));
		pk_years_se2_phone_first_seen := if (years_se2_phone_first_seen >= 0, roundup(years_se2_phone_first_seen), truncate(years_se2_phone_first_seen));
		pk_years_se3_phone_first_seen := if (years_se3_phone_first_seen >= 0, roundup(years_se3_phone_first_seen), truncate(years_se3_phone_first_seen));
		pk_years_se4_phone_first_seen := if (years_se4_phone_first_seen >= 0, roundup(years_se4_phone_first_seen), truncate(years_se4_phone_first_seen));
		pk_years_ap1_phone_first_seen := if (years_ap1_phone_first_seen >= 0, roundup(years_ap1_phone_first_seen), truncate(years_ap1_phone_first_seen));
		pk_years_sp_first_seen := if (years_sp_first_seen >= 0, roundup(years_sp_first_seen), truncate(years_sp_first_seen));
		pk_years_md1_phone_first_seen := if (years_md1_phone_first_seen >= 0, roundup(years_md1_phone_first_seen), truncate(years_md1_phone_first_seen));
		pk_years_cl1_first_seen := if (years_cl1_first_seen >= 0, roundup(years_cl1_first_seen), truncate(years_cl1_first_seen));
		pk_years_cl2_first_seen := if (years_cl2_first_seen >= 0, roundup(years_cl2_first_seen), truncate(years_cl2_first_seen));
		pk_years_cl3_first_seen := if (years_cl3_first_seen >= 0, roundup(years_cl3_first_seen), truncate(years_cl3_first_seen));
		pk_years_ne1_phone_first_seen := if (years_ne1_phone_first_seen >= 0, roundup(years_ne1_phone_first_seen), truncate(years_ne1_phone_first_seen));
		pk_years_ne2_phone_first_seen := if (years_ne2_phone_first_seen >= 0, roundup(years_ne2_phone_first_seen), truncate(years_ne2_phone_first_seen));
		pk_years_ne3_phone_first_seen := if (years_ne3_phone_first_seen >= 0, roundup(years_ne3_phone_first_seen), truncate(years_ne3_phone_first_seen));
		pk_years_pp1_phone_last_seen := if (years_pp1_phone_last_seen >= 0, roundup(years_pp1_phone_last_seen), truncate(years_pp1_phone_last_seen));
		pk_years_pp2_phone_last_seen := if (years_pp2_phone_last_seen >= 0, roundup(years_pp2_phone_last_seen), truncate(years_pp2_phone_last_seen));
		pk_years_pp3_phone_last_seen := if (years_pp3_phone_last_seen >= 0, roundup(years_pp3_phone_last_seen), truncate(years_pp3_phone_last_seen));
		pk_years_wk_phone_first_seen := if (years_wk_phone_first_seen >= 0, roundup(years_wk_phone_first_seen), truncate(years_wk_phone_first_seen));
		pk_years_ah_add1_first_seen := if (years_ah_add1_first_seen >= 0, roundup(years_ah_add1_first_seen), truncate(years_ah_add1_first_seen));
		pk_years_ah_add2_first_seen := if (years_ah_add2_first_seen >= 0, roundup(years_ah_add2_first_seen), truncate(years_ah_add2_first_seen));
		pk_years_ah_add3_first_seen := if (years_ah_add3_first_seen >= 0, roundup(years_ah_add3_first_seen), truncate(years_ah_add3_first_seen));
		pk_years_ah_add5_first_seen := if (years_ah_add5_first_seen >= 0, roundup(years_ah_add5_first_seen), truncate(years_ah_add5_first_seen));
		pk_md1_yr_shared_addr := if (((integer)md1_mo_shared_addr / 12) >= 0, roundup(((integer)md1_mo_shared_addr / 12)), truncate(((integer)md1_mo_shared_addr / 12)));
		pk_md2_yr_shared_addr := if (((integer)md2_mo_shared_addr / 12) >= 0, roundup(((integer)md2_mo_shared_addr / 12)), truncate(((integer)md2_mo_shared_addr / 12)));
		pk_md1_yr_since_shared_addr := if (((integer)md1_mo_since_shared_addr / 12) >= 0, roundup(((integer)md1_mo_since_shared_addr / 12)), truncate(((integer)md1_mo_since_shared_addr / 12)));
		pk_md2_yr_since_shared_addr := if (((integer)md2_mo_since_shared_addr / 12) >= 0, roundup(((integer)md2_mo_since_shared_addr / 12)), truncate(((integer)md2_mo_since_shared_addr / 12)));
		pk_cl1_yr_since_shared_addr := map( trim(cl1_mo_since_shared_addr)='' => NULL, ((integer)cl1_mo_since_shared_addr / 12) >= 0 => roundup(((integer)cl1_mo_since_shared_addr / 12)), truncate(((integer)cl1_mo_since_shared_addr / 12)));
		pk_cl2_yr_since_shared_addr := map( trim(cl2_mo_since_shared_addr)='' => NULL, ((integer)cl2_mo_since_shared_addr / 12) >= 0 => roundup(((integer)cl2_mo_since_shared_addr / 12)), truncate(((integer)cl2_mo_since_shared_addr / 12)));
		pk_cl3_yr_since_shared_addr := map( trim(cl3_mo_since_shared_addr)='' => NULL, ((integer)cl3_mo_since_shared_addr / 12) >= 0 => roundup(((integer)cl3_mo_since_shared_addr / 12)), truncate(((integer)cl3_mo_since_shared_addr / 12)));



		pk_phone_pop_segment3 := map(
			   ( pk_es_phone10_pop > 0 ) => '9 - EDA Match                ',   /* Uses Search Order in Documentation */
			   ( pk_se_phone_count > 0 ) => '8 - Skip Trace Match         ',
			   ( pk_ap_phone_count > 0 ) => '7 - Progressive Address Match',
			   ( pk_sp_phone_count > 0 ) => '6 - Spouse Match             ',
			   ( pk_sx_phone_count > 0 ) => '5 - Skip Trace-Extended Match',
			   ( pk_pp_phone_count > 0 ) => '4 - Phones Plus Match        ',
			   '0 - Unassigned               '
		);

		pk_segment := map(
			pk_phone_pop_segment3 = '9 - EDA Match                ' => 1,  /* Fields for EDA Segment */
			pk_phone_pop_segment3 = '8 - Skip Trace Match         ' => 2,  /* Code for Skip Trace Segment */
			pk_phone_pop_segment3 in [
			   '7 - Progressive Address Match',
			   '6 - Spouse Match             ',
			   '5 - Skip Trace-Extended Match',
			   '4 - Phones Plus Match        '
			] => 3,  /* Code for Middle Segment */
			(( pk_phone_pop_segment3 = '0 - Unassigned               ' ) and (did_populated or cenmatch = 1) ) => 4,  /* Code for Unassigned Segment */
			5  /* Code for Xtra Segment */
		);
		pk_segment2 := if( pk_segment=5, 4, pk_segment ); /* Collapse Segment 4 and 5 in to 4, so Seg5 gets Seg4 score */

pk_Repl_Phn_Matches_Input := 0.0;
age_mod3_nodob_1m_a := 0.0;
age_mod3_nodob_1m := 0.0;
ver_best_e_cnt_mod_1M_NoDob_a := 0.0;
ver_notbest_e_cnt_mod_1M_NoDob_a := 0.0;
ver_notbest_e_cnt_mod_1M_NoDob := 0.0;
ver_element_cnt_mod_1M_NoDob := 0.0;
mod18_1M_NoDob_a := 0.0;
mod18_1M_NoDob := 0.0;
mod18_2M_NoDob_a := 0.0;
mod18_2M_NoDob := 0.0;
Age_mod3_NoDob_3M_a := 0.0;
Age_mod3_NoDob_3M := 0.0;
SSNProb2_mod_3M_NoDob_a := 0.0;
SSNProb2_mod_3M_NoDob := 0.0;
FP_mod5_3M_NoDob_a := 0.0;
FP_mod5_3M_NoDob := 0.0;
ver_best_score_mod_3M_NoDob_a := 0.0;
ver_best_score_mod_3M_NoDob := 0.0;
ver_notbest_score_mod_3M_NoDob_a := 0.0;
ver_notbest_score_mod_3M_NoDob := 0.0;
ver_score_mod_3M_NoDob := 0.0;
mod18_3M_NoDob_a := 0.0;
mod18_3M_NoDob := 0.0;
Age_mod3_NoDob_4M_a := 0.0;
Age_mod3_NoDob_4M := 0.0;
SSNProb2_mod_4M_NoDob_a := 0.0;
SSNProb2_mod_4M_NoDob := 0.0;
FP_mod5_4M_NoDob_a := 0.0;
FP_mod5_4M_NoDob := 0.0;
mod18_4M_NoDob_a := 0.0;
mod18_4M_NoDob := 0.0;
ver_best_e_cnt_mod_1m_nodob := 0.0;
pk_Repl_Hphn_Matches_Input := 0.0;
pk_years_ah_add3_first_seen2 := 0.0;
pk_years_ah_add5_first_seen2 := 0.0;
pk_nas_summary_mm := 0.0;
pk_nap_summary_mm := 0.0;
pk_rc_dirsaddr_lastscore_mm := 0.0;
pk_combo_hphonescore_mm := 0.0;
pk_combo_dobscore_mm := 0.0;
pk_gong_did_first_ct_mm := 0.0;
pk_rc_phonelnamecount_mm := 0.0;
pk_combo_addrcount_mm := 0.0;
pk_rc_phoneaddrcount_mm := 0.0;
pk_combo_hphonecount_mm := 0.0;
pk_ver_phncount_mm := 0.0;
pk_gong_did_phone_ct_mm := 0.0;
pk_combo_ssncount_mm := 0.0;
pk_eq_count_mm := 0.0;
pk_em_count_mm := 0.0;
pk_em_only_count_mm := 0.0;
pk_pos_secondary_sources_mm := 0.0;
pk_voter_flag_mm := 0.0;
pk_fname_eda_sourced_type_lvl_mm := 0.0;
pk_lname_eda_sourced_type_lvl_mm := 0.0;
pk_add1_address_score_mm := 0.0;
pk_add2_pos_sources_mm := 0.0;
pk_ssnchar_invalid_or_recent_mm := 0.0;
pk_infutor_risk_lvl_mm := 0.0;
pk_yr_adl_eq_first_seen2_mm := 0.0;
pk_yr_adl_em_first_seen2_mm := 0.0;
pk_yr_adl_vo_first_seen2_mm := 0.0;
pk_yr_adl_em_only_first_seen2_mm := 0.0;
pk_yr_lname_change_date2_mm := 0.0;
pk_yr_gong_did_first_seen2_mm := 0.0;
pk_yr_credit_first_seen2_mm := 0.0;
pk_yr_header_first_seen2_mm := 0.0;
pk_yr_infutor_first_seen2_mm := 0.0;
pk_EM_Only_ver_lvl_mm := 0.0;
pk_add2_EM_ver_lvl_mm := 0.0;
pk_yrmo_adl_f_sn_mx_fcra2_mm := 0.0;
pk_util_adl_source_count_mm := 0.0;
pk_util_adl_sourced_mm := 0.0;
pk_util_adl_count_mm := 0.0;
pk_util_adl_nap_mm := 0.0;
pk_util_add1_source_count_mm := 0.0;
pk_util_add1_nap_mm := 0.0;
pk_util_add2_source_count_mm := 0.0;
pk_util_add2_nap_mm := 0.0;
pk_rc_utiliaddr_phonecount_mm := 0.0;
pk_utility_sourced_mm := 0.0;
pk_yr_util_adl_D_firstseen2_mm := 0.0;
pk_yr_util_adl_E_firstseen2_mm := 0.0;
pk_yr_util_adl_F_firstseen2_mm := 0.0;
pk_yr_util_adl_G_firstseen2_mm := 0.0;
pk_yr_util_adl_I_firstseen2_mm := 0.0;
pk_yr_util_adl_U_firstseen2_mm := 0.0;
pk_mx_yr_util_adl_firstseen2_mm := 0.0;
pk_yr_util_add1_E_firstseen2_mm := 0.0;
pk_yr_util_add1_F_firstseen2_mm := 0.0;
pk_yr_util_add1_I_firstseen2_mm := 0.0;
pk_yr_util_add1_U_firstseen2_mm := 0.0;
pk_yr_util_add1_V_firstseen2_mm := 0.0;
pk_yr_util_add1_Z_firstseen2_mm := 0.0;
pk_mx_yr_util_add1_firstseen2_mm := 0.0;
pk_yr_util_add2_D_firstseen2_mm := 0.0;
pk_yr_util_add2_E_firstseen2_mm := 0.0;
pk_yr_util_add2_G_firstseen2_mm := 0.0;
pk_yr_util_add2_U_firstseen2_mm := 0.0;
pk_yr_util_add2_Z_firstseen2_mm := 0.0;
pk_nap_type_mm := 0.0;
pk_EN_count_mm := 0.0;
pk_dl_avail_mm := 0.0;
pk_DL_count_mm := 0.0;
pk_yr_adl_EN_first_seen2_mm := 0.0;
pk_yr_adl_DL_first_seen2_mm := 0.0;
pk_es_match_level_m := 0.0;
pk_Moved_Out_10yr_m := 0.0;
pk_Close_Rel_28yr_m := 0.0;
pk_infutor_risk_lvl_nb_mm := 0.0;
pk_Repl_Phn_Matches_Input_m := 0.0;
pk_es_name_match_level := 0.0;
pk_es_match_level := 0.0;
pk_se_phone_stability_flag := 0.0;
pk_sp_dist_0 := 0.0;
pk_Moved_Out_10yr := 0.0;
pk_Close_Rel_28Yr := 0.0;
pk_Stable_Neighbor_Phone_Count := 0.0;
pk_Short_Move_Count := 0.0;
pk_PP_Disconnect_Count := 0.0;
pk_se_phone_stability_flag_m := 0.0;
pk_sp_dist_0_m := 0.0;
pk_Short_Move_Count_m := 0.0;
pk_years_ah_add3_first_seen2_m := 0.0;
pk_years_ah_add5_first_seen2_m := 0.0;
pk_PP_Disconnect_Count_m := 0.0;
pk_Close_Rel_Living_With := 0.0;
pk_Close_Rel_Living_With_Flag := false;
pk_Stable_Neighbor_Phone_Flag := false;
pk_WK_Recent_Phone := 0.0;
pk_Close_Rel_Living_With_Flag_m := 0.0;
pk_Stable_Neighbor_Phone_Flag_m := 0.0;
pk_WK_Recent_Phone_m := 0.0;
pk_waterfall_phone_count2 := 0.0;
pk_years_ap1_phone_first_seen_3 := false;
pk_years_sp_first_seen_19yr := false;
pk_Lived_With_Parents_3yr := 0.0;
pk_PP_Recent_LSeen_Phone_Index := 0.0;
pk_waterfall_phone_count2_m := 0.0;
pk_yr_ap1_phn_fseen_3_m := 0.0;
pk_years_sp_first_seen_19yr_m := 0.0;
pk_Lived_With_Parents_3yr_m := 0.0;
pk_PP_Recent_LSeen_Phone_Index_m := 0.0;
pk_Parent_Phone_Recent := 0.0;
pk_Parent_Phone_Recent_m := 0.0;
Age_mod3_1M_a := 0.0;
Age_mod3_1M := 0.0;
Lien_mod_1M_a := 0.0;
Lien_mod_1M := 0.0;
LRes_mod_1M_a := 0.0;
LRes_mod_1M := 0.0;
ProfLic_mod_1M_a := 0.0;
ProfLic_mod_1M := 0.0;
Velocity2_mod_1M_a := 0.0;
Velocity2_mod_1M := 0.0;
ver_best_element_cnt_mod_1M_a := 0.0;
ver_best_element_cnt_mod_1M := 0.0;
ver_notbest_element_cnt_mod_1M_a := 0.0;
ver_notbest_element_cnt_mod_1M := 0.0;
ver_element_cnt_mod_1M := 0.0;
Relative_mod_1M_a := 0.0;
Relative_mod_1M := 0.0;
Utility_best_mod_1M_a := 0.0;
Utility_best_mod_1M := 0.0;
Utility_mod_1M := 0.0;
ver_best_src_cnt_mod2_1M_a := 0.0;
ver_best_src_cnt_mod2_1M := 0.0;
ver_src_cnt_mod2_1M := 0.0;
Utility_notbest_mod_1M_a := 0.0;
Utility_notbest_mod_1M := 0.0;
ver_notbest_src_cnt_mod2_1M_a := 0.0;
ver_notbest_src_cnt_mod2_1M := 0.0;
AVM_mod2_1M_a := 0.0;
AVM_mod2_1M := 0.0;
Property_mod2_1M_a := 0.0;
Property_mod2_1M := 0.0;
mod18_1M_a := 0.0;
mod18_1M := 0.0;
PK_Contact_Mod4 := 0.0;
LRes_mod_2M_a := 0.0;
LRes_mod_2M := 0.0;
ProfLic_mod_2M_a := 0.0;
ProfLic_mod_2M := 0.0;
Velocity2_mod_2M_a := 0.0;
Velocity2_mod_2M := 0.0;
Census_mod_2M_a := 0.0;
Census_mod_2M := 0.0;
Derog_mod4_2M_a := 0.0;
Derog_mod4_2M := 0.0;
Utility_best_mod_2M_a := 0.0;
Utility_best_mod_2M := 0.0;
Utility_mod_2M := 0.0;
ver_best_src_time_mod2_2M_a := 0.0;
ver_best_src_time_mod2_2M := 0.0;
ver_best_src_cnt_mod2_2M_a := 0.0;
ver_best_src_cnt_mod2_2M := 0.0;
ver_src_time_mod2_2M := 0.0;
ver_src_cnt_mod2_2M := 0.0;
Utility_notbest_mod_2M_a := 0.0;
Utility_notbest_mod_2M := 0.0;
ver_notbest_src_time_mod2_2M_a := 0.0;
ver_notbest_src_time_mod2_2M := 0.0;
ver_notbest_src_cnt_mod2_2M_a := 0.0;
ver_notbest_src_cnt_mod2_2M := 0.0;
Property_mod2_2M_a := 0.0;
Property_mod2_2M := 0.0;
mod18_2M_a := 0.0;
mod18_2M := 0.0;
AddProb3_mod_3M_a := 0.0;
AddProb3_mod_3M := 0.0;
PhnProb_mod_3M_a := 0.0;
PhnProb_mod_3M := 0.0;
SSNProb2_mod_3M_a := 0.0;
SSNProb2_mod_3M := 0.0;
FP_mod5_3M_a := 0.0;
FP_mod5_3M := 0.0;
Age_mod3_3M_a := 0.0;
Age_mod3_3M := 0.0;
AMStudent_mod_3M_a := 0.0;
AMStudent_mod_3M := 0.0;
LRes_mod_3M_a := 0.0;
LRes_mod_3M := 0.0;
ProfLic_mod_3M_a := 0.0;
ProfLic_mod_3M := 0.0;
Velocity2_mod_3M_a := 0.0;
Velocity2_mod_3M := 0.0;
ver_best_score_mod_3M_a := 0.0;
ver_best_score_mod_3M := 0.0;
ver_notbest_score_mod_3M_a := 0.0;
ver_notbest_score_mod_3M := 0.0;
ver_score_mod_3M := 0.0;
Relative_mod_3M_a := 0.0;
Relative_mod_3M := 0.0;
Derog_mod4_3M_a := 0.0;
Derog_mod4_3M := 0.0;
Utility_best_mod_3M_a := 0.0;
Utility_best_mod_3M := 0.0;
Utility_mod_3M := 0.0;
ver_best_src_time_mod2_3M_a := 0.0;
ver_best_src_time_mod2_3M := 0.0;
ver_best_src_cnt_mod2_3M_a := 0.0;
ver_best_src_cnt_mod2_3M := 0.0;
ver_src_time_mod2_3M := 0.0;
ver_src_cnt_mod2_3M := 0.0;
Utility_notbest_mod_3M_a := 0.0;
Utility_notbest_mod_3M := 0.0;
ver_notbest_src_time_mod2_3M_a := 0.0;
ver_notbest_src_time_mod2_3M := 0.0;
ver_notbest_src_cnt_mod2_3M_a := 0.0;
ver_notbest_src_cnt_mod2_3M := 0.0;
Property_mod2_3M_a := 0.0;
Property_mod2_3M := 0.0;
mod18_3M_a := 0.0;
mod18_3M := 0.0;
AddProb3_mod_4M_a := 0.0;
AddProb3_mod_4M := 0.0;
PhnProb_mod_4M_a := 0.0;
PhnProb_mod_4M := 0.0;
SSNProb2_mod_4M_a := 0.0;
SSNProb2_mod_4M := 0.0;
FP_mod5_4M_a := 0.0;
FP_mod5_4M := 0.0;
Age_mod3_4M_a := 0.0;
Age_mod3_4M := 0.0;
AMStudent_mod_4M_a := 0.0;
AMStudent_mod_4M := 0.0;
Distance_mod2_4M_a := 0.0;
Distance_mod2_4M := 0.0;
LRes_mod_4M_a := 0.0;
LRes_mod_4M := 0.0;
Velocity2_mod_4M_a := 0.0;
Velocity2_mod_4M := 0.0;
Relative_mod_4M_a := 0.0;
Relative_mod_4M := 0.0;
Utility_best_mod_4M_a := 0.0;
Utility_best_mod_4M := 0.0;
Utility_mod_4M := 0.0;
ver_best_src_time_mod2_4M_a := 0.0;
ver_best_src_time_mod2_4M := 0.0;
ver_best_src_cnt_mod2_4M_a := 0.0;
ver_best_src_cnt_mod2_4M := 0.0;
ver_src_time_mod2_4M := 0.0;
ver_src_cnt_mod2_4M := 0.0;
Utility_notbest_mod_4M_a := 0.0;
Utility_notbest_mod_4M := 0.0;
ver_notbest_src_time_mod2_4M_a := 0.0;
ver_notbest_src_time_mod2_4M := 0.0;
ver_notbest_src_cnt_mod2_4M_a := 0.0;
ver_notbest_src_cnt_mod2_4M := 0.0;
Property_mod2_4M_a := 0.0;
Property_mod2_4M := 0.0;
mod18_4M_a := 0.0;
mod18_4M := 0.0;
pk_combo_lnamecount_nb_mm := 0.0;
pk_combo_addrcount_nb_mm := 0.0;
pk_gong_did_phone_ct_nb_mm := 0.0;
pk_combo_dobcount_nb_mm := 0.0;


      if( pk_segment2 = 1 ) then /* Fields for EDA Segment */
	   



			pk_Repl_Addr_Matches_Input := if( adl_addr = '2', 1, 0 );


			pk_es_name_match_level := map(
				es_name_match_flag in [ '1', '4' ] => 2,  /* FL or F Match */
				es_name_match_flag in [ '3'      ] => 1,  /* L Match       */
				0  /* FL Swap       */
			);

			pk_es_match_level := map(
							 pk_es_eda_did_match = 1        => 3,     /* DID Match */
							 pk_es_name_match_level = 2     => 2,     /* FL or F Match */
							 pk_es_name_match_level = 0     => 1,     /* FL Swap       */
							 0     /* L Match       */
			);

			pk_se_phone_stability_flag := map(
							 
								(( pk_years_se1_phone_first_seen >= 14 ) or
								 ( pk_years_se2_phone_first_seen >= 14 ) or
								 ( pk_years_se3_phone_first_seen >= 14 ) or
								 ( pk_years_se4_phone_first_seen >= 14 ))
							 => 1,
			0
			);


			pk_sp_dist_0 := if( trim(sp_dist) != '' and (integer)sp_dist = 0, 1, 0 );


			pk_Moved_Out_10yr := map(
							 (( pk_md1_yr_since_shared_addr >= 10 ) or ( pk_md2_yr_since_shared_addr >= 10 )) => 1,
			0
			);


			pk_Close_Rel_28Yr := map(
							 (
								   ( pk_years_cl1_first_seen >= 28 ) or
								   ( pk_years_cl2_first_seen >= 28 ) or
								   ( pk_years_cl3_first_seen >= 28 )
								 ) => 1,
			0
			);


			pk_Stable_Neighbor_Phone_Count := 
				(integer)( pk_years_ne1_phone_first_seen >= 4 )
				+ (integer)( pk_years_ne2_phone_first_seen >= 4 )
				+ (integer)( pk_years_ne3_phone_first_seen >= 4 );


			pk_People_At_Work_Flag := map(
							 pk_wk_phone_count >= 1 => 1,
			0
			);


			pk_Pos_Work_Source_Flag := map(
							 trim( wk_source ) in [ 'W', 'II', 'C,', 'C1', 'CN', 'SK', 'JI', 'UF', 'ZM', 'IA' ] =>  1,
							 trim( wk_source ) in [ 'C<', 'PF', 'IC', 'C0', 'BR', 'WF', 'BA', 'QQ' ]            => -1,
			0
			);


			pk_Short_Move_Count :=      (integer)( ah_add1_dist in [ '0', '1', '2' ]) +
				(integer)( ah_add2_dist in [ '0', '1', '2' ]) +
				(integer)( ah_add3_dist in [ '0', '1', '2' ]) +
				(integer)( ah_add4_dist in [ '0', '1', '2' ]) +
				(integer)( ah_add5_dist in [ '0', '1', '2' ]);


			pk_years_ah_add1_first_seen2 := map(
				pk_years_ah_add1_first_seen  =  NULL => -9,
				pk_years_ah_add1_first_seen <=  1 => -3,
				pk_years_ah_add1_first_seen <=  2 => -2,
				pk_years_ah_add1_first_seen <=  9 => -1,
				pk_years_ah_add1_first_seen <= 14 =>  0,
				pk_years_ah_add1_first_seen <= 18 =>  1,
				pk_years_ah_add1_first_seen <= 29 =>  2,
				3
			);


			pk_years_ah_add2_first_seen2 := map(
				pk_years_ah_add2_first_seen  =  NULL => -1,
				pk_years_ah_add2_first_seen <=  1 =>  0,
				pk_years_ah_add2_first_seen <=  2 =>  1,
				pk_years_ah_add2_first_seen <=  6 =>  2,
				pk_years_ah_add2_first_seen <= 11 =>  3,
				pk_years_ah_add2_first_seen <= 17 =>  4,
				5
			);


			pk_years_ah_add3_first_seen2 := map(
			pk_years_ah_add3_first_seen  =  NULL => -1,
			pk_years_ah_add3_first_seen <=  1 =>  0,
			pk_years_ah_add3_first_seen <=  2 =>  1,
			pk_years_ah_add3_first_seen <=  4 =>  2,
			pk_years_ah_add3_first_seen <=  6 =>  3,
			pk_years_ah_add3_first_seen <= 10 =>  4,
			pk_years_ah_add3_first_seen <= 17 =>  5,
			6
			);


			pk_years_ah_add5_first_seen2 := map(
			pk_years_ah_add5_first_seen  =  NULL => -1,
			pk_years_ah_add5_first_seen <=  1 =>  0,
			pk_years_ah_add5_first_seen <=  2 =>  1,
			pk_years_ah_add5_first_seen <=  3 =>  2,
			pk_years_ah_add5_first_seen <=  4 =>  3,
			pk_years_ah_add5_first_seen <=  6 =>  4,
			pk_years_ah_add5_first_seen <= 11 =>  5,
			pk_years_ah_add5_first_seen <= 13 =>  6,
			pk_years_ah_add5_first_seen <= 17 =>  7,
			8
			);


			 pk_PP_Disconnect_Count :=
								 (integer)( pp1_active_phone = '0' ) +
								 (integer)( pp2_active_phone = '0' ) +
								 (integer)( pp3_active_phone = '0' );


			pk_Repl_Hphn_Matches_Input := map(
							 wf_hphn = '2' => 1,
			0
			);


						  /* To Means */

			pk_Repl_Addr_Matches_Input_m := map(
			pk_Repl_Addr_Matches_Input = 0 => 0.2692307692,
			pk_Repl_Addr_Matches_Input = 1 => 0.3577286602,
			0.3356805567
			);


			pk_es_match_level_m := map(
			pk_es_match_level = 0 => 0.2312312312,
			pk_es_match_level = 1 => 0.2887081086,
			pk_es_match_level = 2 => 0.3366976181,
			pk_es_match_level = 3 => 0.3611840319,
			0.3356805567
			);


			pk_se_phone_stability_flag_m := map(
			pk_se_phone_stability_flag = 0 => 0.3352277571,
			pk_se_phone_stability_flag = 1 => 0.3512720157,
			0.3356805567
			);


			pk_sp_dist_0_m := map(
			pk_sp_dist_0 = 0 => 0.3356572585,
			pk_sp_dist_0 = 1 => 0.3369734789,
			0.3356805567
			);


			pk_Moved_Out_10yr_m := map(
			pk_Moved_Out_10yr = 0 => 0.3336108963,
			pk_Moved_Out_10yr = 1 => 0.3625821415,
			0.3356805567
			);


			pk_Close_Rel_28Yr_m := map(
			pk_Close_Rel_28Yr = 0 => 0.3331733077,
			pk_Close_Rel_28Yr = 1 => 0.3431136413,
			0.3356805567
			);


			pk_People_At_Work_Flag_m := map(
			pk_People_At_Work_Flag = 0 => 0.3333886327,
			pk_People_At_Work_Flag = 1 => 0.3470530128,
			0.3356805567
			);


			pk_Pos_Work_Source_Flag_m := map(
			pk_Pos_Work_Source_Flag = -1 => 0.3140870617,
			pk_Pos_Work_Source_Flag = 0 => 0.3338207578,
			pk_Pos_Work_Source_Flag = 1 => 0.3960581886,
			0.3356805567
			);


			pk_Short_Move_Count_m := map(
			pk_Short_Move_Count = 0 => 0.3185812932,
			pk_Short_Move_Count = 1 => 0.3303111281,
			pk_Short_Move_Count = 2 => 0.34175,
			pk_Short_Move_Count = 3 => 0.351094589,
			pk_Short_Move_Count = 4 => 0.3498062016,
			pk_Short_Move_Count = 5 => 0.3886703383,
			0.3356805567
			);


			pk_years_ah_add1_first_seen2_m := map(
			pk_years_ah_add1_first_seen2 = -9 => 0.3098591549,
			pk_years_ah_add1_first_seen2 = -3 => 0.3723348934,
			pk_years_ah_add1_first_seen2 = -2 => 0.3628691983,
			pk_years_ah_add1_first_seen2 = -1 => 0.3184697076,
			pk_years_ah_add1_first_seen2 = 0 => 0.3147786947,
			pk_years_ah_add1_first_seen2 = 1 => 0.3578010804,
			pk_years_ah_add1_first_seen2 = 2 => 0.371524148,
			pk_years_ah_add1_first_seen2 = 3 => 0.3813273341,
			0.3356805567
			);


			pk_years_ah_add2_first_seen2_m := map(
			pk_years_ah_add2_first_seen2 = -1 => 0.3374045802,
			pk_years_ah_add2_first_seen2 = 0 => 0.2619684805,
			pk_years_ah_add2_first_seen2 = 1 => 0.2874327319,
			pk_years_ah_add2_first_seen2 = 2 => 0.3196221816,
			pk_years_ah_add2_first_seen2 = 3 => 0.3484595176,
			pk_years_ah_add2_first_seen2 = 4 => 0.3643811988,
			pk_years_ah_add2_first_seen2 = 5 => 0.4003697617,
			0.3356805567
			);


			pk_years_ah_add3_first_seen2_m := map(
			pk_years_ah_add3_first_seen2 = -1 => 0.3430706522,
			pk_years_ah_add3_first_seen2 = 0 => 0.219466366,
			pk_years_ah_add3_first_seen2 = 1 => 0.2712208319,
			pk_years_ah_add3_first_seen2 = 2 => 0.3131313131,
			pk_years_ah_add3_first_seen2 = 3 => 0.3286559965,
			pk_years_ah_add3_first_seen2 = 4 => 0.3539070518,
			pk_years_ah_add3_first_seen2 = 5 => 0.3682999013,
			pk_years_ah_add3_first_seen2 = 6 => 0.3927821272,
			0.3356805567
			);


			pk_years_ah_add5_first_seen2_m := map(
			pk_years_ah_add5_first_seen2 = -1 => 0.3502611201,
			pk_years_ah_add5_first_seen2 = 0 => 0.2219541616,
			pk_years_ah_add5_first_seen2 = 1 => 0.2294043093,
			pk_years_ah_add5_first_seen2 = 2 => 0.2728723404,
			pk_years_ah_add5_first_seen2 = 3 => 0.2825618945,
			pk_years_ah_add5_first_seen2 = 4 => 0.3058562992,
			pk_years_ah_add5_first_seen2 = 5 => 0.3327980235,
			pk_years_ah_add5_first_seen2 = 6 => 0.341442953,
			pk_years_ah_add5_first_seen2 = 7 => 0.3663973252,
			pk_years_ah_add5_first_seen2 = 8 => 0.4012219959,
			0.3356805567
			);


			pk_PP_Disconnect_Count_m := map(
			pk_PP_Disconnect_Count = 0 => 0.3606044056,
			pk_PP_Disconnect_Count = 1 => 0.2678647234,
			pk_PP_Disconnect_Count = 2 => 0.2162711864,
			pk_PP_Disconnect_Count = 3 => 0.1941747573,
			0.3356805567
			);



       elseif( pk_segment2 = 2 ) then /* Code for Skip Trace Segment */


			pk_Repl_Addr_Matches_Input := map(
				adl_addr in [ '1', '2' ] =>  1,
				adl_addr in [ '3' ]    => -1,
				0
			);


			pk_Repl_Phn_Matches_Input := map(
				wf_hphn in [ '1', '2' ] =>  1,
				wf_hphn in [ '3' ]    => -1,
				0
			);


			pk_se_phone_stability_flag := map(
				(( pk_years_se1_phone_first_seen >= 14 ) or ( pk_years_se2_phone_first_seen >= 14 )) => 1,
				0
			);


		   pk_Close_Rel_Living_With :=
							   (integer)( pk_cl1_yr_since_shared_addr = 0 ) +
							   (integer)( pk_cl2_yr_since_shared_addr = 0 ) +
							   (integer)( pk_cl3_yr_since_shared_addr = 0 );

		   pk_Close_Rel_Living_With_Flag := ( pk_Close_Rel_Living_With > 0 );


			 pk_Stable_Neighbor_Phone_Count := (integer)( pk_years_ne1_phone_first_seen >= 3 ) + (integer)( pk_years_ne2_phone_first_seen >= 3 );
			 pk_Stable_Neighbor_Phone_Flag := ( pk_Stable_Neighbor_Phone_Count > 0 );


			pk_PP_Disconnect_Count := min( 2,
							 (integer)( pp1_active_phone = '0' ) +
							 (integer)( pp2_active_phone = '0' ) +
							 (integer)( pp3_active_phone = '0' ) );


			pk_People_At_Work_Flag := map(
				pk_wk_phone_count >= 1 => 1,
				0
			);


			pk_Pos_Work_Source_Flag := map(
				trim( wk_source ) in [ 'IC', 'IA', 'SK', 'C*', 'ZM', 'CN', 'II', 'PF', 'C)', 'JI', 'C,' ] =>  1,
				trim( wk_source ) in [ 'C<', 'WF', 'BR', 'C0', 'QQ', 'BA'                               ] => -1,
				0
			);


			pk_WK_Recent_Phone := map(
				pk_years_wk_phone_first_seen in [ 1, 2 ] => 1,
				0
			);


			pk_years_ah_add1_first_seen2 := map(
				pk_years_ah_add1_first_seen  =  NULL => -9,
				pk_years_ah_add1_first_seen <=  1 => -1,
				pk_years_ah_add1_first_seen <=  6 => 0,
				pk_years_ah_add1_first_seen <= 10 => 1,
				pk_years_ah_add1_first_seen <= 19 => 2,
				3
			);


			pk_years_ah_add2_first_seen2 := map(
			pk_years_ah_add2_first_seen  =  NULL => -1,
			pk_years_ah_add2_first_seen <=  1 => 0,
			pk_years_ah_add2_first_seen <=  2 => 1,
			pk_years_ah_add2_first_seen <= 11 => 2,
			pk_years_ah_add2_first_seen <= 16 => 3,
			4
			);


			pk_years_ah_add3_first_seen2 := map(
			pk_years_ah_add3_first_seen  =  NULL => -1,
			pk_years_ah_add3_first_seen <=  1 => 0,
			pk_years_ah_add3_first_seen <=  2 => 1,
			pk_years_ah_add3_first_seen <=  5 => 2,
			pk_years_ah_add3_first_seen <= 16 => 3,
			4
			);


			pk_years_ah_add5_first_seen2 := map(
			pk_years_ah_add5_first_seen  =  NULL => -1,
			pk_years_ah_add5_first_seen <=  2 => 0,
			pk_years_ah_add5_first_seen <=  3 => 1,
			pk_years_ah_add5_first_seen <=  5 => 2,
			pk_years_ah_add5_first_seen <= 11 => 3,
			pk_years_ah_add5_first_seen <= 18 => 4,
			pk_years_ah_add5_first_seen <= 24 => 5,
			6
			);


						  /* Code to Means */


			pk_Repl_Addr_Matches_Input_m := map(
			pk_Repl_Addr_Matches_Input = -1 => 0.1541164918,
			pk_Repl_Addr_Matches_Input = 0 => 0.1743243243,
			pk_Repl_Addr_Matches_Input = 1 => 0.2343434343,
			0.1922234826
			);


			pk_Repl_Phn_Matches_Input_m := map(
			pk_Repl_Phn_Matches_Input = -1 => 0.1182911894,
			pk_Repl_Phn_Matches_Input = 0 => 0.1942622951,
			pk_Repl_Phn_Matches_Input = 1 => 0.4218662485,
			0.1922234826
			);


			pk_se_phone_stability_flag_m := map(
			pk_se_phone_stability_flag = 0 => 0.1886746769,
			pk_se_phone_stability_flag = 1 => 0.2163105998,
			0.1922234826
			);


			pk_Close_Rel_Living_With_Flag_m := map(
				(integer)pk_Close_Rel_Living_With_Flag = 0 => 0.192015891,
				(integer)pk_Close_Rel_Living_With_Flag = 1 => 0.1967509025,
				0.1922234826 // pk_close_rel_living_with_flag is a boolean; why does this third condition exist?
			);


			pk_Stable_Neighbor_Phone_Flag_m := map(
			(integer)pk_Stable_Neighbor_Phone_Flag = 0 => 0.1918604651,
			(integer)pk_Stable_Neighbor_Phone_Flag = 1 => 0.1923412879,
			0.1922234826
			);


			pk_PP_Disconnect_Count_m := map(
			pk_PP_Disconnect_Count = 0 => 0.2181287024,
			pk_PP_Disconnect_Count = 1 => 0.1521216203,
			pk_PP_Disconnect_Count = 2 => 0.1149825784,
			0.1922234826
			);


			pk_People_At_Work_Flag_m := map(
			pk_People_At_Work_Flag = 0 => 0.1906850192,
			pk_People_At_Work_Flag = 1 => 0.1994301994,
			0.1922234826
			);


			pk_Pos_Work_Source_Flag_m := map(
			pk_Pos_Work_Source_Flag = -1 => 0.175608326,
			pk_Pos_Work_Source_Flag = 0 => 0.1906328564,
			pk_Pos_Work_Source_Flag = 1 => 0.2395787626,
			0.1922234826
			);


			pk_WK_Recent_Phone_m := map(
			pk_WK_Recent_Phone = 0 => 0.191430807,
			pk_WK_Recent_Phone = 1 => 0.2269503546,
			0.1922234826
			);


			pk_years_ah_add1_first_seen2_m := map(
			pk_years_ah_add1_first_seen2 = -9 => 0.1638418079,
			pk_years_ah_add1_first_seen2 = -1 => 0.1999608687,
			pk_years_ah_add1_first_seen2 = 0 => 0.1802387351,
			pk_years_ah_add1_first_seen2 = 1 => 0.1905717151,
			pk_years_ah_add1_first_seen2 = 2 => 0.2012884978,
			pk_years_ah_add1_first_seen2 = 3 => 0.2336640438,
			0.1922234826
			);


			pk_years_ah_add2_first_seen2_m := map(
			pk_years_ah_add2_first_seen2 = -1 => 0.1909424725,
			pk_years_ah_add2_first_seen2 = 0 => 0.16178172,
			pk_years_ah_add2_first_seen2 = 1 => 0.1758139535,
			pk_years_ah_add2_first_seen2 = 2 => 0.1927559714,
			pk_years_ah_add2_first_seen2 = 3 => 0.2165910237,
			pk_years_ah_add2_first_seen2 = 4 => 0.2194364322,
			0.1922234826
			);


			pk_years_ah_add3_first_seen2_m := map(
			pk_years_ah_add3_first_seen2 = -1 => 0.2088959492,
			pk_years_ah_add3_first_seen2 = 0 => 0.1520879121,
			pk_years_ah_add3_first_seen2 = 1 => 0.1668183887,
			pk_years_ah_add3_first_seen2 = 2 => 0.1869095816,
			pk_years_ah_add3_first_seen2 = 3 => 0.2011337392,
			pk_years_ah_add3_first_seen2 = 4 => 0.2349171271,
			0.1922234826
			);


			pk_years_ah_add5_first_seen2_m := map(
			pk_years_ah_add5_first_seen2 = -1 => 0.2159804606,
			pk_years_ah_add5_first_seen2 = 0 => 0.148868054,
			pk_years_ah_add5_first_seen2 = 1 => 0.1605263158,
			pk_years_ah_add5_first_seen2 = 2 => 0.1741241762,
			pk_years_ah_add5_first_seen2 = 3 => 0.1912384162,
			pk_years_ah_add5_first_seen2 = 4 => 0.2152027027,
			pk_years_ah_add5_first_seen2 = 5 => 0.231078905,
			pk_years_ah_add5_first_seen2 = 6 => 0.2559748428,
			0.1922234826
			);



       elseif( pk_segment2 = 3 ) then /* Code for Middle Segment */



					 /* Fields for Mid Segment */

			pk_waterfall_phone_count2 := map(
							 pk_waterfall_phone_count <=  1 => 0,
							 pk_waterfall_phone_count <=  5 => 1,
							 pk_waterfall_phone_count <=  9 => 2,
			3
			);


			pk_Repl_Addr_Matches_Input := map(
							 adl_addr in [ '1', '2' ] =>  1,
							 adl_addr in [ '3' ]    => -1,
			0
			);


			pk_Repl_Phn_Matches_Input := map(
							 wf_hphn in [ '1', '2' ] =>  1,
							 wf_hphn in [ '3' ]    => -1,
			0
			);


							 pk_years_ap1_phone_first_seen_3 := ( pk_years_ap1_phone_first_seen >= 3 );


			pk_sp_dist_0 := if( trim(sp_dist) != '' and (integer)sp_dist = 0, 1, 0 );


							 pk_years_sp_first_seen_19yr := ( pk_years_sp_first_seen >= 19 );


			pk_Lived_With_Parents_3yr := map(
							 (( pk_md1_yr_shared_addr >= 3 ) or ( pk_md2_yr_shared_addr >= 3 )) => 1,
			0
			);


							 pk_Close_Rel_Living_With :=
												 (integer)( trim(cl1_mo_since_shared_addr) !='' and (integer)cl1_mo_since_shared_addr = 0 ) +
												 (integer)( trim(cl2_mo_since_shared_addr) !='' and (integer)cl2_mo_since_shared_addr = 0 ) +
												 (integer)( trim(cl3_mo_since_shared_addr) !='' and (integer)cl3_mo_since_shared_addr = 0 );

							 pk_Close_Rel_Living_With_Flag := ( pk_Close_Rel_Living_With > 0 );


							 pk_PP_Disconnect_Count :=
												 (integer)( pp1_active_phone = '0' ) +
												 (integer)( pp2_active_phone = '0' ) +
												 (integer)( pp3_active_phone = '0' );


							 pk_PP_Recent_LSeen_Phone_Index :=
								  2 * (integer)( pk_years_pp1_phone_last_seen = 1 ) + (integer)( pk_years_pp2_phone_last_seen = 1 ) + (integer)( pk_years_pp3_phone_last_seen = 1 ) +
									  (integer)( pk_years_pp1_phone_last_seen = 2 ) + (integer)( pk_years_pp2_phone_last_seen = 2 ) + (integer)( pk_years_pp3_phone_last_seen = 2 );


			pk_People_At_Work_Flag := if(pk_wk_phone_count >= 1, 1, 0 );

			pk_Pos_Work_Source_Flag := map(
				trim( wk_source ) in [ 'BR', 'C)', 'BA', 'C(', 'IA', 'W ', 'WF', 'C*', 'JI','C9', 'C{', 'ZM', 'II', 'CR', 'C,', 'CB' ] =>  1,
				trim( wk_source ) in [ 'C5', 'C<', 'SP', 'GF', 'PF', 'MW', 'SK', 'C0', 'UF', 'CN', 'QQ' ] => -1,
				0
			);

			pk_WK_Recent_Phone := if( pk_years_wk_phone_first_seen in [ 1, 2 ], 1, 0 );

			pk_years_ah_add1_first_seen2 := map(
			pk_years_ah_add1_first_seen  =  NULL => -9,
			pk_years_ah_add1_first_seen <=  1 =>  0,
			pk_years_ah_add1_first_seen <=  6 =>  1,
			2
			);


			pk_years_ah_add2_first_seen2 := map(
			pk_years_ah_add2_first_seen  =  NULL => -2,
			pk_years_ah_add2_first_seen <=  3 => -1,
			pk_years_ah_add2_first_seen <= 22 =>  0,
			1
			);


						  /* To Means */


			pk_waterfall_phone_count2_m := map(
			pk_waterfall_phone_count2 = 0 => 0.0956719818,
			pk_waterfall_phone_count2 = 1 => 0.1073355479,
			pk_waterfall_phone_count2 = 2 => 0.1121441854,
			pk_waterfall_phone_count2 = 3 => 0.1192222412,
			0.1099553951
			);


			pk_Repl_Addr_Matches_Input_m := map(
			pk_Repl_Addr_Matches_Input = -1 => 0.1013101537,
			pk_Repl_Addr_Matches_Input = 0 => 0.1080705009,
			pk_Repl_Addr_Matches_Input = 1 => 0.1154794673,
			0.1099553951
			);


			pk_Repl_Phn_Matches_Input_m := map(
			pk_Repl_Phn_Matches_Input = -1 => 0.0932607404,
			pk_Repl_Phn_Matches_Input = 0 => 0.1066189014,
			pk_Repl_Phn_Matches_Input = 1 => 0.156339731,
			0.1099553951
			);


			pk_yr_ap1_phn_fseen_3_m := map(
			(integer)pk_years_ap1_phone_first_seen_3 = 0 => 0.1085892354,
			(integer)pk_years_ap1_phone_first_seen_3 = 1 => 0.115419512,
			0.1099553951
			);


			pk_sp_dist_0_m := map(
			pk_sp_dist_0 = 0 => 0.1089915336,
			pk_sp_dist_0 = 1 => 0.15807393,
			0.1099553951
			);


			pk_years_sp_first_seen_19yr_m := map(
			(integer)pk_years_sp_first_seen_19yr = 0 => 0.1089759433,
			(integer)pk_years_sp_first_seen_19yr = 1 => 0.1224812327,
			0.1099553951
			);


			pk_Lived_With_Parents_3yr_m := map(
			(integer)pk_Lived_With_Parents_3yr = 0 => 0.1086801942,
			(integer)pk_Lived_With_Parents_3yr = 1 => 0.1261096606,
			0.1099553951
			);


			pk_Close_Rel_Living_With_Flag_m := map(
			(integer)pk_Close_Rel_Living_With_Flag = 0 => 0.1094056595,
			(integer)pk_Close_Rel_Living_With_Flag = 1 => 0.1227906977,
			0.1099553951
			);


			pk_PP_Disconnect_Count_m := map(
			pk_PP_Disconnect_Count = 0 => 0.1292190195,
			pk_PP_Disconnect_Count = 1 => 0.0895333509,
			pk_PP_Disconnect_Count = 2 => 0.0801381693,
			pk_PP_Disconnect_Count = 3 => 0.0613057325,
			0.1099553951
			);


			pk_PP_Recent_LSeen_Phone_Index_m := map(
			pk_PP_Recent_LSeen_Phone_Index = 0 => 0.0910586429,
			pk_PP_Recent_LSeen_Phone_Index = 1 => 0.1181333333,
			pk_PP_Recent_LSeen_Phone_Index = 2 => 0.1462551709,
			pk_PP_Recent_LSeen_Phone_Index = 3 => 0.1658536585,
			pk_PP_Recent_LSeen_Phone_Index = 4 => 0.1643913538,
			0.1099553951
			);


			pk_People_At_Work_Flag_m := map(
			pk_People_At_Work_Flag = 0 => 0.1082776629,
			pk_People_At_Work_Flag = 1 => 0.1191004313,
			0.1099553951
			);


			pk_Pos_Work_Source_Flag_m := map(
			pk_Pos_Work_Source_Flag = -1 => 0.0995553837,
			pk_Pos_Work_Source_Flag = 0 => 0.108458307,
			pk_Pos_Work_Source_Flag = 1 => 0.1302525524,
			0.1099553951
			);


			pk_WK_Recent_Phone_m := map(
			pk_WK_Recent_Phone = 0 => 0.1092495909,
			pk_WK_Recent_Phone = 1 => 0.145597639,
			0.1099553951
			);


			pk_years_ah_add1_first_seen2_m := map(
			pk_years_ah_add1_first_seen2 = -9 => 0.101259916,
			pk_years_ah_add1_first_seen2 = 0 => 0.1418133169,
			pk_years_ah_add1_first_seen2 = 1 => 0.1159875343,
			pk_years_ah_add1_first_seen2 = 2 => 0.099023126,
			0.1099553951
			);


			pk_years_ah_add2_first_seen2_m := map(
			pk_years_ah_add2_first_seen2 = -2 => 0.1142623954,
			pk_years_ah_add2_first_seen2 = -1 => 0.1083602057,
			pk_years_ah_add2_first_seen2 = 0 => 0.109977422,
			pk_years_ah_add2_first_seen2 = 1 => 0.1187676388,
			0.1099553951
			);



// elseif( pk_segment2 = 4 ) then /* Code for Unassigned Segment */
else



              /* Fields for Unassigned Segment */


			pk_Repl_Addr_Matches_Input := map(
							 adl_addr in [ '1', '2' ] =>  1,
			0
			);


			pk_Parent_Phone_Recent := map(
							 ( pk_years_md1_phone_first_seen in [ 1, 2, 3 ])             => 1,
			0
			);


			 pk_Close_Rel_Living_With :=
								 (integer)( trim(cl1_mo_since_shared_addr)!='' and (integer)cl1_mo_since_shared_addr = 0 ) +
								 (integer)( trim(cl2_mo_since_shared_addr)!='' and (integer)cl2_mo_since_shared_addr = 0 ) +
								 (integer)( trim(cl3_mo_since_shared_addr)!='' and (integer)cl3_mo_since_shared_addr = 0 );


			 pk_Close_Rel_Living_With_Flag := ( pk_Close_Rel_Living_With > 0 );


		pk_People_At_Work_Flag := map(
						 pk_wk_phone_count >= 1 => 1,
		0
		);


		pk_Pos_Work_Source_Flag := map(
						 trim( wk_source ) in [ 'ZM', 'IA' ]             =>  1,
						 trim( wk_source ) in [ 'UF', 'BR', 'C0', 'IC' ] => -1,
		0
		);


		pk_WK_Recent_Phone := map(
						 pk_years_wk_phone_first_seen in [ 1, 2, 3  ] => 1,
		0
		);


		pk_years_ah_add1_first_seen2 := map(
		pk_years_ah_add1_first_seen  =  NULL => -9,
		pk_years_ah_add1_first_seen <=  4 => -1,
		pk_years_ah_add1_first_seen <= 12 =>  0,
		1
		);

		pk_years_ah_add2_first_seen2 := map(
		pk_years_ah_add2_first_seen  =  NULL => -9,
		pk_years_ah_add2_first_seen <=  3 => -1,
		pk_years_ah_add2_first_seen <=  5 =>  0,
		pk_years_ah_add2_first_seen <= 18 =>  1,
		2
		);

		pk_years_ah_add3_first_seen2 := map(
		pk_years_ah_add3_first_seen  =  NULL => -9,
		pk_years_ah_add3_first_seen <=  3 =>  0,
		pk_years_ah_add3_first_seen <=  6 =>  1,
		2
		);


		pk_years_ah_add5_first_seen2 := map(
		pk_years_ah_add5_first_seen  =  NULL => -9,
		pk_years_ah_add5_first_seen <=  3 =>  0,
		pk_years_ah_add5_first_seen <= 11 =>  1,
		2
		);


					  /* To Means */


		pk_Repl_Addr_Matches_Input_m := map(
		pk_Repl_Addr_Matches_Input = 0 => 0.0682773109,
		pk_Repl_Addr_Matches_Input = 1 => 0.0829867429,
		0.0777258307
		);


		pk_Parent_Phone_Recent_m := map(
		pk_Parent_Phone_Recent = 0 => 0.0756658056,
		pk_Parent_Phone_Recent = 1 => 0.1085219707,
		0.0777258307
		);


		pk_Close_Rel_Living_With_Flag_m := map(
		(integer)pk_Close_Rel_Living_With_Flag = 0 => 0.0761892372,
		(integer)pk_Close_Rel_Living_With_Flag = 1 => 0.1173184358,
		0.0777258307
		);


		pk_People_At_Work_Flag_m := map(
		pk_People_At_Work_Flag = 0 => 0.077578776,
		pk_People_At_Work_Flag = 1 => 0.0787247885,
		0.0777258307
		);


		pk_Pos_Work_Source_Flag_m := map(
		pk_Pos_Work_Source_Flag = -1 => 0.0577716644,
		pk_Pos_Work_Source_Flag = 0 => 0.0774738145,
		pk_Pos_Work_Source_Flag = 1 => 0.1112956811,
		0.0777258307
		);


		pk_WK_Recent_Phone_m := map(
		pk_WK_Recent_Phone = 0 => 0.0774432528,
		pk_WK_Recent_Phone = 1 => 0.0866035183,
		0.0777258307
		);


		pk_years_ah_add1_first_seen2_m := map(
		pk_years_ah_add1_first_seen2 = -9 => 0.0669144981,
		pk_years_ah_add1_first_seen2 = -1 => 0.0858050847,
		pk_years_ah_add1_first_seen2 = 0 => 0.0731304796,
		pk_years_ah_add1_first_seen2 = 1 => 0.0805778969,
		0.0777258307
		);


		pk_years_ah_add2_first_seen2_m := map(
		pk_years_ah_add2_first_seen2 = -9 => 0.0768351899,
		pk_years_ah_add2_first_seen2 = -1 => 0.07852194,
		pk_years_ah_add2_first_seen2 = 0 => 0.0667634253,
		pk_years_ah_add2_first_seen2 = 1 => 0.0779870199,
		pk_years_ah_add2_first_seen2 = 2 => 0.0893655049,
		0.0777258307
		);


		pk_years_ah_add3_first_seen2_m := map(
		pk_years_ah_add3_first_seen2 = -9 => 0.0788650581,
		pk_years_ah_add3_first_seen2 = 0 => 0.0675433353,
		pk_years_ah_add3_first_seen2 = 1 => 0.0738305942,
		pk_years_ah_add3_first_seen2 = 2 => 0.0835712926,
		0.0777258307
		);


		pk_years_ah_add5_first_seen2_m := map(
		pk_years_ah_add5_first_seen2 = -9 => 0.0764885496,
		pk_years_ah_add5_first_seen2 = 0 => 0.0637915544,
		pk_years_ah_add5_first_seen2 = 1 => 0.0783376241,
		pk_years_ah_add5_first_seen2 = 2 => 0.0825857895,
		0.0777258307
		);



		// else

		
       end;


    /* PK Modeling Shell Code */

    /* Misc */

		pk_ssnchar_invalid_or_recent := map(
			   inputssncharflag in [ '1', '2', '3', '4' ] => 1,
		0
		);

		pk_did0 := if(did= 0, 1, 0 );

       pk_ssn_prob_nodob := ( ssn_deceased or ssn_inval );


    /* Verification Section */


		pk_yr_adl_eq_first_seen       := roundup( years_adl_eq_first_seen        );
		pk_yr_adl_en_first_seen       := roundup( years_adl_en_first_seen        );
		pk_yr_adl_dl_first_seen       := roundup( years_adl_dl_first_seen        );
		pk_yr_adl_em_first_seen       := roundup( years_adl_em_first_seen        );
		pk_yr_adl_vo_first_seen       := roundup( years_adl_vo_first_seen        );
		pk_yr_adl_em_only_first_seen  := roundup( years_adl_em_only_first_seen   );
		pk_yr_adl_first_seen_max_fcra := roundup( years_adl_first_seen_max_fcra  );
		pk_mo_adl_first_seen_max_fcra := roundup( months_adl_first_seen_max_fcra );
		pk_yr_lname_change_date       := roundup( years_lname_change_date        );
		pk_yr_gong_did_first_seen     := roundup( years_gong_did_first_seen      );
		pk_yr_credit_first_seen       := roundup( years_credit_first_seen        );
		pk_yr_header_first_seen       := roundup( years_header_first_seen        );
		pk_yr_infutor_first_seen      := roundup( years_infutor_first_seen       );


		pk_nas_summary := map(
			   nas_summary >= 12 => 2,
			   nas_summary >=  9 => 1,
		0
		);


		pk_nap_summary := map(
			   nap_summary >= 12 =>  2,
			   nap_summary >=  9 =>  1,
			   nap_summary  =  1 => -1,
		0
		);


		pk_rc_dirsaddr_lastscore   := map(
		rc_dirsaddr_lastscore     = 255 => -1,
		rc_dirsaddr_lastscore    >=  90 =>  2,
		rc_dirsaddr_lastscore    >=  80 =>  1,
		0
		);


		pk_combo_fnamescore   := map(
		combo_fnamescore     = 255 =>  0,
		combo_fnamescore    >=  90 =>  1,
		0
		);


		pk_combo_hphonescore   := map(
		combo_hphonescore     = 255 =>  0,
		combo_hphonescore     = 100 =>  2,
		combo_hphonescore    >=  90 =>  1,
		0
		);


		pk_combo_dobscore   := map(
		combo_dobscore     = 255 => -1,
		combo_dobscore    >=  95 =>  2,
		combo_dobscore    >=  90 =>  1,
		0
		);


		pk_gong_did_first_ct   := map(
		gong_did_first_ct    <=  0  =>  0,
		1
		);


		pk_combo_lnamecount_nb   := map(
		combo_lnamecount    <=  1  =>  0,
		combo_lnamecount    <=  2  =>  1,
		combo_lnamecount    <=  3  =>  2,
		combo_lnamecount    <=  4  =>  3,
		combo_lnamecount    <=  5  =>  4,
		combo_lnamecount    <=  6  =>  5,
		6
		);


		pk_rc_phonelnamecount   := map(
		rc_phonelnamecount    <=  0  =>  0,
		1
		);


		pk_combo_addrcount   := map(
		combo_addrcount    <=  1  =>  0,
		combo_addrcount    <=  2  =>  1,
		combo_addrcount    <=  3  =>  2,
		combo_addrcount    <=  4  =>  3,
		4
		);


		pk_combo_addrcount_nb   := map(
		combo_addrcount    <=  0  =>  0,
		combo_addrcount    <=  1  =>  1,
		combo_addrcount    <=  2  =>  2,
		combo_addrcount    <=  3  =>  3,
		combo_addrcount    <=  4  =>  4,
		5
		);


		pk_rc_phoneaddrcount   := map(
		rc_phoneaddrcount    <=  0  =>  0,
		1
		);


		pk_combo_hphonecount   := map(
		combo_hphonecount    <=  0  =>  0,
		1
		);


		pk_ver_phncount   := map(
		ver_phncount    <=  0  =>  0,
		ver_phncount    <=  2  =>  1,
		ver_phncount    <=  3  =>  2,
		3
		);


		pk_gong_did_phone_ct   := map(
		gong_did_phone_ct    <=  0  => -1,
			   gong_did_phone_ct    <=  1  =>  0 , /* Optimal */
		gong_did_phone_ct    <=  2  =>  1,
		gong_did_phone_ct    <=  4  =>  2,
		3
		);


		pk_gong_did_phone_ct_nb   := map(
		gong_did_phone_ct    <=  0  => -2,
		gong_did_phone_ct    <=  1  => -1,
			   gong_did_phone_ct    <=  2  =>  0 , /* Optimal */
		gong_did_phone_ct    <=  3  =>  1,
		2
		);


		pk_combo_ssncount   := map(
		combo_ssncount    <=  0  => -1,
			   combo_ssncount    <=  1  =>  0 ,       /* Optimal */
		1
		);


		pk_combo_dobcount_nb   := map(
		combo_dobcount    <=  0  =>  0,
		combo_dobcount    <=  1  =>  1,
		combo_dobcount    <=  2  =>  2,
		combo_dobcount    <=  3  =>  3,
		combo_dobcount    <=  4  =>  4,
		combo_dobcount    <=  5  =>  5,
		combo_dobcount    <=  6  =>  6,
		7
		);


		pk_eq_count   := map(
		eq_count    <=  1  =>  0,
		eq_count    <=  3  =>  1,
		eq_count    <=  5  =>  2,
		eq_count    <=  6  =>  3,
		eq_count    <=  7  =>  4,
		eq_count    <= 17  =>  5,
		6
		);


		pk_em_count   := map(
		em_count    <=  0  =>  0,
		em_count    <=  1  =>  1,
		2
		);


		pk_em_only_count   := map(
		em_only_count    <=  0  =>  0,
		em_only_count    <=  1  =>  1,
		em_only_count    <=  3  =>  2,
		3
		);


		pk_pos_secondary_sources := map(
		1=source_tot_EB                                                         =>  2,
		sum( source_tot_AK, source_tot_AM, source_tot_AR, source_tot_CG ) > 0 =>  1,
		0
		);


		pk_voter_flag := map(
			   source_tot_voter =>  1,
			   voter_avail => -1,
		0
		);


		pk_fname_eda_sourced_type_lvl := map(
			   trim( fname_eda_sourced_type ) = 'AP' => 3,
			   trim( fname_eda_sourced_type ) = 'P'  => 2,
			   trim( fname_eda_sourced_type ) = 'A'  => 1,
		0
		);

		pk_lname_eda_sourced_type_lvl := map(
			   trim( lname_eda_sourced_type ) = 'AP' => 3,
			   trim( lname_eda_sourced_type ) = 'P'  => 2,
			   trim( lname_eda_sourced_type ) = 'A'  => 1,
		0
		);


		pk_add1_address_score := map(
		add1_address_score =  100 =>  1,
		0
		);


		pk_add1_unit_count2 := map(
			   add1_unit_count <= 2 => 0,
			   add1_unit_count <= 3 => 1,
			   add1_unit_count <= 4 => 2,
		3
		);


		pk_add2_pos_sources := map(
		1=source_add2_EQ and 1=source_add2_WP and source_add2_voter => 4,
		1=source_add2_EQ and 1=source_add2_WP                       => 3,
		source_add2_voter => 2,
		1=source_add2_EQ                                          => 1,
		0
		);


		models.common.findw(add2_sources, 'EM', ' ,', 'I', add2_source_EM, 'int'); // add2_source_EM := 
		models.common.findw(add2_sources, 'E1', ' ,', 'I', add2_source_E1, 'int'); // add2_source_E1 := 
		models.common.findw(add2_sources, 'E2', ' ,', 'I', add2_source_E2, 'int'); // add2_source_E2 := 
		models.common.findw(add2_sources, 'E3', ' ,', 'I', add2_source_E3, 'int'); // add2_source_E3 := 
		models.common.findw(add2_sources, 'E4', ' ,', 'I', add2_source_E4, 'int'); // add2_source_E4 := 
		models.common.findw(add3_sources, 'EM', ' ,', 'I', add3_source_EM, 'int'); // add3_source_EM := 
		models.common.findw(add3_sources, 'E1', ' ,', 'I', add3_source_E1, 'int'); // add3_source_E1 := 
		models.common.findw(add3_sources, 'E2', ' ,', 'I', add3_source_E2, 'int'); // add3_source_E2 := 
		models.common.findw(add3_sources, 'E3', ' ,', 'I', add3_source_E3, 'int'); // add3_source_E3 := 
		models.common.findw(add3_sources, 'E4', ' ,', 'I', add3_source_E4, 'int'); // add3_source_E4 := 

		pk_EM_Only_ver_lvl := map(
			   1=em_only_source_EM and 1=em_only_source_E1                       =>  3,
			   1=em_only_source_E1                       =>  2,
			   1=em_only_source_E4 => -1,
			   1=em_only_source_EM                                             =>  1,
		0
		);


		pk_add2_EM_ver_lvl := map(
			   1=add2_source_E1 =>  2,
			   1=add2_source_E4 => -1,
			   1=add2_source_EM =>  1,
		0
		);


		pk_infutor_risk_lvl := map(
		infutor_nap in [ 1, 6 ] =>  2,
		infutor_nap in [ 0 ]    =>  0,
		1
		);

		pk_infutor_risk_lvl_nb := map(
		infutor_nap in [ 1, 6 ] =>  3,
		infutor_nap in [ 12 ]   =>  0,
		infutor_nap in [ 0 ]    =>  1,
		2
		);


		pk_yr_adl_eq_first_seen2     := map(
		pk_yr_adl_eq_first_seen    <=  NULL  => -1,
		pk_yr_adl_eq_first_seen    <=  1  =>  0,
		pk_yr_adl_eq_first_seen    <=  2  =>  1,
		pk_yr_adl_eq_first_seen    <=  3  =>  2,
		pk_yr_adl_eq_first_seen    <=  5  =>  3,
		pk_yr_adl_eq_first_seen    <=  6  =>  4,
		pk_yr_adl_eq_first_seen    <=  8  =>  5,
		pk_yr_adl_eq_first_seen    <= 10  =>  6,
		pk_yr_adl_eq_first_seen    <= 15  =>  7,
		pk_yr_adl_eq_first_seen    <= 19  =>  8,
		pk_yr_adl_eq_first_seen    <= 21  =>  9,
		10
		);


		pk_yr_adl_em_first_seen2     := map(
		pk_yr_adl_em_first_seen    <=  NULL  => -1,
		pk_yr_adl_em_first_seen    <=  1  =>  0,
		pk_yr_adl_em_first_seen    <=  3  =>  1,
		pk_yr_adl_em_first_seen    <=  4  =>  2,
		pk_yr_adl_em_first_seen    <= 18  =>  3,
		4
		);


		pk_yr_adl_vo_first_seen2     := map(
		pk_yr_adl_vo_first_seen    <=  NULL  => -1,
		pk_yr_adl_vo_first_seen    <=  1  =>  0,
		pk_yr_adl_vo_first_seen    <=  3  =>  1,
		pk_yr_adl_vo_first_seen    <=  4  =>  2,
		3
		);


		pk_yr_adl_em_only_first_seen2     := map(
		pk_yr_adl_em_only_first_seen    <=  NULL  => -1,
		pk_yr_adl_em_only_first_seen    <=  1  =>  0,
		pk_yr_adl_em_only_first_seen    <=  2  =>  1,
		pk_yr_adl_em_only_first_seen    <=  3  =>  2,
		pk_yr_adl_em_only_first_seen    <= 19  =>  3,
		4
		);


		pk_yrmo_adl_first_seen_max_fcra2 := map(
		pk_mo_adl_first_seen_max_fcra <=  NULL => -1,
		pk_mo_adl_first_seen_max_fcra <=  3 =>  0,
		pk_mo_adl_first_seen_max_fcra <= 13 =>  1,
		pk_mo_adl_first_seen_max_fcra <= 19 =>  2,
		pk_mo_adl_first_seen_max_fcra <= 25 =>  3,
		pk_mo_adl_first_seen_max_fcra <= 36 =>  4,
		pk_mo_adl_first_seen_max_fcra <= 41 =>  5,
		pk_mo_adl_first_seen_max_fcra <= 54 =>  6,
		pk_mo_adl_first_seen_max_fcra <= 60 =>  7,
		pk_yr_adl_first_seen_max_fcra <=  6 =>  8,
		pk_yr_adl_first_seen_max_fcra <=  8 =>  9,
		pk_yr_adl_first_seen_max_fcra <= 12 => 10,
		pk_yr_adl_first_seen_max_fcra <= 15 => 11,
		pk_yr_adl_first_seen_max_fcra <= 17 => 12,
		pk_yr_adl_first_seen_max_fcra <= 19 => 13,
		pk_yr_adl_first_seen_max_fcra <= 21 => 14,
		pk_yr_adl_first_seen_max_fcra <= 26 => 15,
		16
		);


		pk_yr_lname_change_date2     := map(
		pk_yr_lname_change_date    <=  NULL  => -1,
		pk_yr_lname_change_date    <=  2  =>  0,
		pk_yr_lname_change_date    <=  8  =>  1,
		2
		);


		pk_yr_gong_did_first_seen2     := map(
		pk_yr_gong_did_first_seen    <=  NULL  => -1,
		pk_yr_gong_did_first_seen    <=  1  =>  0,
		pk_yr_gong_did_first_seen    <=  2  =>  1,
		pk_yr_gong_did_first_seen    <=  3  =>  2,
		pk_yr_gong_did_first_seen    <=  4  =>  3,
		4
		);


		pk_yr_credit_first_seen2     := map(
		pk_yr_credit_first_seen    <=  NULL  => -1,
		pk_yr_credit_first_seen    <=  1  =>  0,
		pk_yr_credit_first_seen    <=  2  =>  1,
		pk_yr_credit_first_seen    <=  3  =>  2,
		pk_yr_credit_first_seen    <=  5  =>  3,
		pk_yr_credit_first_seen    <=  6  =>  4,
		pk_yr_credit_first_seen    <=  8  =>  5,
		pk_yr_credit_first_seen    <= 10  =>  6,
		pk_yr_credit_first_seen    <= 15  =>  7,
		pk_yr_credit_first_seen    <= 19  =>  8,
		pk_yr_credit_first_seen    <= 21  =>  9,
		pk_yr_credit_first_seen    <= 28  => 10,
		11
		);


		pk_yr_header_first_seen2     := map(
		pk_yr_header_first_seen    <=  NULL  => -1,
		pk_yr_header_first_seen    <=  1  =>  0,
		pk_yr_header_first_seen    <=  2  =>  1,
		pk_yr_header_first_seen    <=  4  =>  2,
		pk_yr_header_first_seen    <=  5  =>  3,
		pk_yr_header_first_seen    <= 16  =>  4,
		pk_yr_header_first_seen    <= 19  =>  5,
		pk_yr_header_first_seen    <= 24  =>  6,
		7
		);


		pk_yr_infutor_first_seen2     := map(
		pk_yr_infutor_first_seen    <=  NULL  => -1,
		pk_yr_infutor_first_seen    <=  1  =>  0,
		pk_yr_infutor_first_seen    <=  2  =>  1,
		pk_yr_infutor_first_seen    <=  3  =>  2,
		pk_yr_infutor_first_seen    <=  4  =>  3,
		4
		);


		pk_voter_count  := min( 2, em_count + vo_count );



		/* Estimated Income */

		pk_estimated_income := map(
			estimated_income <=        222  => -1,
			estimated_income <=      15000  =>  0,
			estimated_income <=      19000  =>  1,
			estimated_income <=      20000  =>  2,
			estimated_income <=      21000  =>  3,
			estimated_income <=      22000  =>  4,
			estimated_income <=      23000  =>  5,
			estimated_income <=      24000  =>  6,
			estimated_income <=      25000  =>  7,
			estimated_income <=      26000  =>  8,
			estimated_income <=      27000  =>  9,
			estimated_income <=      28000  => 10,
			estimated_income <=      29000  => 11,
			estimated_income <=      31000  => 12,
			estimated_income <=      32000  => 13,
			estimated_income <=      33000  => 14,
			estimated_income <=      34000  => 15,
			estimated_income <=      35000  => 16,
			estimated_income <=      36000  => 17,
			estimated_income <=      37000  => 18,
			estimated_income <=      39000  => 19,
			estimated_income <=     108000  => 20,
			estimated_income <=     150000  => 21,
			22
		);


		/* Property  */


		// note: ECL's roundup() and SAS' ceil() act differently on negative values.
		//       some of these values are negative (years until mortgage due, for example),
		//       so using roundup() will behave incorrectly.
		pk_yr_adl_pr_first_seen            := sas_ceil( years_adl_pr_first_seen         );
		pk_yr_adl_w_first_seen             := sas_ceil( years_adl_w_first_seen          );
		pk_yr_adl_pr_last_seen             := sas_ceil( years_adl_pr_last_seen          );
		pk_yr_adl_w_last_seen              := sas_ceil( years_adl_w_last_seen           );
		pk_yr_add1_built_date              := sas_ceil( years_add1_built_date          );
		pk_yr_add1_mortgage_date           := sas_ceil( years_add1_mortgage_date       );
		pk_yr_add1_mortgage_due_date       := sas_ceil( years_add1_mortgage_due_date    );
		pk_yr_add1_date_first_seen         := sas_ceil( years_add1_date_first_seen      );
		pk_yr_add1_assessed_value_year     := sas_ceil( years_add1_assessed_value_year  );
		pk_yr_prop1_prev_purchase_date     := sas_ceil( years_prop1_prev_purchase_date  );
		pk_yr_prop2_sale_date              := sas_ceil( years_prop2_sale_date           );
		pk_yr_prop2_prev_purchase_date     := sas_ceil( years_prop2_prev_purchase_date  );
		pk_yr_add2_assessed_value_year     := sas_ceil( years_add2_assessed_value_year  );
		pk_yr_add2_built_date              := sas_ceil( years_add2_built_date           );
		pk_yr_add2_mortgage_due_date       := sas_ceil( years_add2_mortgage_due_date    );
		pk_yr_add2_date_first_seen         := sas_ceil( years_add2_date_first_seen      );
		pk_yr_add2_date_last_seen          := sas_ceil( years_add2_date_last_seen       );
		pk_yr_add3_built_date              := sas_ceil( years_add3_built_date           );
		pk_yr_add3_mortgage_due_date       := sas_ceil( years_add3_mortgage_due_date    );
		pk_yr_add3_date_first_seen         := sas_ceil( years_add3_date_first_seen      );
		pk_yr_add3_date_last_seen          := sas_ceil( years_add3_date_last_seen       );
		pk_yr_attr_date_last_purchase      := sas_ceil( years_attr_date_last_purchase   );
		pk_yr_attr_date_last_sale          := sas_ceil( years_attr_date_last_sale       );

		pk_prop1_sale_price                  := min( 1000000, 20000 * roundup ( prop1_sale_price                          / 20000 ));
		pk_prop1_prev_purchase_price         := min( 1000000, 20000 * roundup ( prop1_prev_purchase_price                 / 20000 ));


		pk_add1_purchase_amount              := min( 1000000, 20000 * roundup ( add1_purchase_amount                      / 20000 ));

		pk_add1_assessed_amount              := min( 1000000, 20000 * roundup ( add1_assessed_amount                      / 20000 ));
		pk_add2_purchase_amount              := min( 1000000, 20000 * roundup ( add2_purchase_amount                      / 20000 ));
		pk_add2_mortgage_amount              := min( 1000000, 20000 * roundup ( add2_mortgage_amount                      / 20000 ));
		pk_add2_assessed_amount              := min( 1000000, 20000 * roundup ( add2_assessed_amount                      / 20000 ));
		pk_add3_purchase_amount              := min( 1000000, 20000 * roundup ( add3_purchase_amount                      / 20000 ));

		pk_add3_assessed_amount              := min( 1000000, 20000 * roundup ( add3_assessed_amount                      / 20000 ));



		pk_add1_building_area := map(
			   (integer)add1_building_area <=   1000 =>   100 * roundup( (integer)add1_building_area /   100 ),
			   (integer)add1_building_area <=  10000 =>  1000 * roundup( (integer)add1_building_area /  1000 ),
			   (integer)add1_building_area <= 100000 => 10000 * roundup( (integer)add1_building_area / 10000 ),
		100001
		);


		pk_yr_adl_pr_first_seen2     := map(
		pk_yr_adl_pr_first_seen    <=  NULL  => -1,
		pk_yr_adl_pr_first_seen    <=  1  =>  0,
		pk_yr_adl_pr_first_seen    <=  5  =>  1,
		pk_yr_adl_pr_first_seen    <=  8  =>  2,
		pk_yr_adl_pr_first_seen    <= 12  =>  3,
		pk_yr_adl_pr_first_seen    <= 14  =>  4,
		pk_yr_adl_pr_first_seen    <= 24  =>  5,
		pk_yr_adl_pr_first_seen    <= 37  =>  6,
		7
		);


		pk_yr_adl_w_first_seen2     := map(
			   pk_yr_adl_w_first_seen    <=  NULL  =>  -1,
			   pk_yr_adl_w_first_seen    <=  3  =>   0,
			   pk_yr_adl_w_first_seen    <= 12  =>   1,
		2
		);


		pk_yr_adl_pr_last_seen2     := map(
			   pk_yr_adl_pr_last_seen    <=  NULL  =>  -1,
			   pk_yr_adl_pr_last_seen    <=  1  =>   0,
			   pk_yr_adl_pr_last_seen    <=  2  =>   1,
			   pk_yr_adl_pr_last_seen    <=  3  =>   2,
			   pk_yr_adl_pr_last_seen    <=  5  =>   3,
			   pk_yr_adl_pr_last_seen    <=  14 =>   4,
			   pk_yr_adl_pr_last_seen    <=  22 =>   5,
		6
		);


		pk_yr_adl_w_last_seen2     := map(
		pk_yr_adl_w_last_seen    <=  NULL  => -1,
		pk_yr_adl_w_last_seen    <=  0  =>  0,
		pk_yr_adl_w_last_seen    <=  1  =>  1,
		2
		);


    /* Property Ownership */


		pk_addrs_sourced_lvl := map(
			   1=source_add_P and ( 1=source_add2_P or 1=source_add3_P ) => 3,
			   1=source_add_P                                        => 2,
			   1=source_add2_P or  1=source_add3_P  => 1,
			0
		);


		pk_add1_own_level := map(
			   add1_applicant_owned and add1_family_owned                         =>  3,
			   add1_applicant_owned                                               =>  2,
			   add1_family_owned                         =>  1,
			   add1_occupant_owned => -1,
		0
		);


		pk_naprop_level := map(
			   add1_naprop = 4 and add2_naprop  = 4 => 7,
			   add1_naprop = 4                      => 6,
			   add1_naprop = 3 and add2_naprop  = 4 => 5,
			   add1_naprop = 3 and add2_naprop  = 3 => 4,
			   add1_naprop = 3 and add2_naprop != 1 => 3,
			   add1_naprop = 3                      => 2,
			   add1_naprop = 2                      => 3,
			   add1_naprop = 1 and add2_naprop  = 4 => 4,
			   add1_naprop = 1 and add2_naprop  = 3 => 1,
			   add1_naprop = 1 and add2_naprop != 1 => 0,
			   add1_naprop = 1                      => -1,
			   add1_naprop = 0 and add2_naprop  = 4 => 5,
			   add1_naprop = 0 and add2_naprop != 1 => 2,
		0
		);

		pk_naprop_level2 := map(
			add3_naprop=4 => map(
				pk_naprop_level  = 6 => 7,
				pk_naprop_level >= 2 => 5,
				4
			),
			add3_naprop = 0 and pk_naprop_level  = -1 => -2,
			add3_naprop = 0 and pk_naprop_level  =  0 => -1,
			pk_naprop_level
		);


		pk_add2_own_level := map(
			   add2_applicant_owned and add2_family_owned                         =>  3,
			   add2_applicant_owned                                               =>  2,
			   add2_family_owned                         =>  1,
		0
		);

		pk_add3_own_level := map(
			   add3_applicant_owned and add3_family_owned                         =>  3,
			   add3_applicant_owned                                               =>  2,
			   add3_family_owned                         =>  1,
		0
		);


		pk_prop_owned_sold_level := map(
			   prop_owned_flag => 2,
			   prop_sold_flag  => 1,
		0
		);


			/* Property Value */


		pk_yr_add1_built_date2     := map(
		pk_yr_add1_built_date    <=  NULL  => -4,
		pk_yr_add1_built_date    <=  1  => -3,
		pk_yr_add1_built_date    <=  4  => -2,
		pk_yr_add1_built_date    <=  7  => -1,
		pk_yr_add1_built_date    <= 25  =>  0,
		pk_yr_add1_built_date    <= 35  =>  1,
		pk_yr_add1_built_date    <= 50  =>  2,
		3
		);


		pk_add1_purchase_amount2     := map(
		pk_add1_purchase_amount    <=      0 => -1,
		pk_add1_purchase_amount    <= 120000 =>  0,
		1
		);


		pk_yr_add1_mortgage_date2     := map(
		pk_yr_add1_mortgage_date    <=   NULL => -1,
		pk_yr_add1_mortgage_date    <=   2 =>  0,
		pk_yr_add1_mortgage_date    <=   3 =>  1,
		2
		);


		pk_add1_mortgage_risk := map(
		trim( add1_mortgage_type ) in [  'S', '1', 'H'     ] =>  3,
		trim( add1_mortgage_type ) in [  'FHA', '2'        ] =>  3,
		trim( add1_mortgage_type ) in [  'N', 'R', 'G'     ] =>  2,
		trim( add1_mortgage_type ) in [  'U', '', 'P'      ] =>  1,
		trim( add1_mortgage_type ) in [  'VA'              ] =>  0,
		trim( add1_mortgage_type ) in [  'CNS', 'E', 'C'   ] =>  0,
		-1
		);


		pk_add1_assessed_amount2     := map(
		pk_add1_assessed_amount    <=      0 => -1,
		pk_add1_assessed_amount    <=  40000 =>  0,
		pk_add1_assessed_amount    <=  60000 =>  1,
		pk_add1_assessed_amount    <=  80000 =>  2,
		pk_add1_assessed_amount    <= 100000 =>  3,
		pk_add1_assessed_amount    <= 140000 =>  4,
		pk_add1_assessed_amount    <= 160000 =>  5,
		6
		);


		pk_yr_add1_mortgage_due_date2     := map(
		pk_yr_add1_mortgage_due_date    <=   NULL => -1,
		pk_yr_add1_mortgage_due_date    <= -27 =>  2,
		pk_yr_add1_mortgage_due_date    <= -12 =>  1,
		0
		);


		pk_yr_add1_date_first_seen2     := map(
		pk_yr_add1_date_first_seen    <=   NULL => -1,
		pk_yr_add1_date_first_seen    <=   1 =>  0,
		pk_yr_add1_date_first_seen    <=   2 =>  1,
		pk_yr_add1_date_first_seen    <=   3 =>  2,
		pk_yr_add1_date_first_seen    <=   4 =>  3,
		pk_yr_add1_date_first_seen    <=   5 =>  4,
		pk_yr_add1_date_first_seen    <=   8 =>  5,
		pk_yr_add1_date_first_seen    <=  10 =>  6,
		pk_yr_add1_date_first_seen    <=  14 =>  7,
		pk_yr_add1_date_first_seen    <=  19 =>  8,
		pk_yr_add1_date_first_seen    <=  26 =>  9,
		10
		);


		pk_add1_building_area2     := map(
			pk_add1_building_area    <=     0 => -99,
			pk_add1_building_area    <=   900 =>  -4,
			pk_add1_building_area    <=  1000 =>  -3,
			pk_add1_building_area    <=  2000 =>  -2,
			pk_add1_building_area    <=  3000 =>  -1,
			pk_add1_building_area    <=  5000 =>   0 ,       /* Best Value */
			pk_add1_building_area    <=  7000 =>   1,
			pk_add1_building_area    <= 10000 =>   2,
			pk_add1_building_area    <= 30000 =>   3,
			4
		);


		pk_add1_no_of_buildings   := map(
			   add1_no_of_buildings    <=   0 =>  -1,
			   add1_no_of_buildings    <=   1 =>   0,
			   add1_no_of_buildings    <=   4 =>   1,
		2
		);


		pk_add1_no_of_rooms   := map(
		add1_no_of_rooms    <=  0  => -1,
		add1_no_of_rooms    <=  4  =>  0,
		add1_no_of_rooms    <=  5  =>  1,
		add1_no_of_rooms    <=  6  =>  2,
		add1_no_of_rooms    <=  7  =>  3,
		4
		);


		pk_add1_no_of_baths   := map(
		add1_no_of_baths    <=  0  => -3,
		add1_no_of_baths    <=  1  => -2,
		add1_no_of_baths    <=  2  => -1,
		add1_no_of_baths    <=  3  =>  0 ,   /* Optimal */
		add1_no_of_baths    <=  5  =>  1,
		2
		);


		pk_add1_parking_no_of_cars   := map(
		add1_parking_no_of_cars    <=  0  =>  0,
		add1_parking_no_of_cars    <=  1  =>  1,
		add1_parking_no_of_cars    <=  2  =>  2,
		3
		);


		pk_add1_style_code_level   := map(
		trim( add1_style_code ) in [ 'J' ] =>  4,
		trim( add1_style_code ) in [ 'D' ] =>  3,
		trim( add1_style_code ) in [ 'N' ] =>  2,
		trim( add1_style_code ) in [ 'R' ] =>  1,
		trim( add1_style_code ) in [ 'C' ] =>  1,
		0
		);


		pk_yr_add1_assessed_value_year2     := map(
		pk_yr_add1_assessed_value_year    <=   NULL => -1,
		pk_yr_add1_assessed_value_year    <=   3 =>  0,
		pk_yr_add1_assessed_value_year    <=   6 =>  1,
		2
		);


		pk_property_owned_assessed_count   := map(
		property_owned_assessed_count    <=   0 =>  0,
		property_owned_assessed_count    <=   1 =>  1,
		property_owned_assessed_count    <=   2 =>  2,
		property_owned_assessed_count    <=   3 =>  3,
		4
		);


		pk_prop1_sale_price2     := map(
		pk_prop1_sale_price    <=      0 =>  0,
		pk_prop1_sale_price    <=  40000 =>  1,
		2
		);


		pk_prop1_prev_purchase_price2     := map(
		pk_prop1_prev_purchase_price    <=      0 =>  0,
		pk_prop1_prev_purchase_price    <=  80000 =>  1,
		2
		);


		pk_yr_prop1_prev_purchase_date2     := map(
		pk_yr_prop1_prev_purchase_date    <=  NULL  => -1,
		pk_yr_prop1_prev_purchase_date    <=  2  =>  0,
		pk_yr_prop1_prev_purchase_date    <=  3  =>  1,
		pk_yr_prop1_prev_purchase_date    <=  4  =>  2,
		pk_yr_prop1_prev_purchase_date    <=  5  =>  3,
		pk_yr_prop1_prev_purchase_date    <=  7  =>  4,
		pk_yr_prop1_prev_purchase_date    <=  9  =>  5,
		pk_yr_prop1_prev_purchase_date    <= 12  =>  6,
		7
		);


		pk_yr_prop2_sale_date2     := map(
		pk_yr_prop2_sale_date    <=  1  =>  0,
		pk_yr_prop2_sale_date    <=  4  =>  1,
		pk_yr_prop2_sale_date    <=  9  =>  2,
		3
		);


		pk_yr_prop2_prev_purchase_date2     := map(
		pk_yr_prop2_prev_purchase_date    <=   NULL => -1,
		pk_yr_prop2_prev_purchase_date    <=  10 =>  0,
		1
		);


       pk_add2_land_use_cat := trim(add2_land_use_code)[1..2];

		pk_add2_land_use_risk_level := map(
		trim( pk_add2_land_use_cat ) in [ '11', '92', '91'               ] =>  4,
		trim( pk_add2_land_use_cat ) in [ '', '20'                       ] =>  3,
		trim( pk_add2_land_use_cat ) in [ '30', '05', '10', '80', '00'   ] =>  2,
		trim( pk_add2_land_use_cat ) in [ '19'                           ] =>  2 ,  /* Presumed Residential - Should be a 1, but SFDU for Now */
		trim( pk_add2_land_use_cat ) in [ '70'                           ] =>  0,
		3
		);


		pk_add2_no_of_buildings   := map(
		add2_no_of_buildings    <=   0 => -1,
		add2_no_of_buildings    <=   1 =>  0,
		add2_no_of_buildings    <=   5 =>  1,
		2
		);


		pk_add2_no_of_stories   := map(
		add2_no_of_stories    <=  0  => -1,
		add2_no_of_stories    <=  2  =>  0,
		1
		);


		pk_add2_no_of_baths   := map(
		add2_no_of_baths    <=  0  => -3,
		add2_no_of_baths    <=  1  => -2,
		add2_no_of_baths    <=  2  => -1,
		add2_no_of_baths    <=  3  =>  0,
		add2_no_of_baths    <=  4  =>  1,
		2
		);


		pk_add2_garage_type_risk_level  := map(
		trim( add2_garage_type_code ) in [ 'M', 'A', 'U'         ] =>  0,
		trim( add2_garage_type_code ) in [ 'G', 'B', 'Y'         ] =>  1,
		trim( add2_garage_type_code ) in [ 'C', 'N', 'D'         ] =>  2,
		3
		);


		pk_add2_style_code_level   := map(
		trim( add2_style_code ) in [ 'J' ] =>  4,
		trim( add2_style_code ) in [ 'D' ] =>  3,
		trim( add2_style_code ) in [ 'N' ] =>  2,
		trim( add2_style_code ) in [ 'R' ] =>  1,
		trim( add2_style_code ) in [ 'C' ] =>  1,
		0
		);


		pk_yr_add2_assessed_value_year2     := map(
		pk_yr_add2_assessed_value_year    <=   NULL => -1,
		pk_yr_add2_assessed_value_year    <=   0 =>  0,
		pk_yr_add2_assessed_value_year    <=   1 =>  1,
		2
		);


		pk_yr_add2_built_date2     := map(
		pk_yr_add2_built_date    <=   NULL => -1,
		pk_yr_add2_built_date    <=   5 =>  0,
		pk_yr_add2_built_date    <=   9 =>  1,
		2
		);


		pk_add2_purchase_amount2     := map(
		pk_add2_purchase_amount    <=      0 =>  -1,
		pk_add2_purchase_amount    <=  80000 =>   0,
		1
		);


		pk_add2_mortgage_amount2     := map(
		pk_add2_mortgage_amount    <=      0 => -1,
		pk_add2_mortgage_amount    <=  60000 =>  0,
		pk_add2_mortgage_amount    <= 260000 =>  1,
		2
		);


		pk_add2_mortgage_risk := map(
		trim( add2_mortgage_type ) in [  'S', '1', 'H'     ] =>  3,
		trim( add2_mortgage_type ) in [  'FHA', '2'        ] =>  3,
		trim( add2_mortgage_type ) in [  'N', 'R', 'G'     ] =>  2,
		trim( add2_mortgage_type ) in [  'U', '', 'P'      ] =>  1,
		trim( add2_mortgage_type ) in [  'VA'              ] =>  0,
		trim( add2_mortgage_type ) in [  'CNS', 'E', 'C'   ] =>  0,
		-1
		);


		pk_add2_adjustable_financing   := map(
			   trim( add2_financing_type ) = 'ADJ'  =>  1,
		0
		);


		pk_yr_add2_mortgage_due_date2     := map(
		pk_yr_add2_mortgage_due_date    <=   NULL => -1,
		pk_yr_add2_mortgage_due_date    <= -26 =>  3,
		pk_yr_add2_mortgage_due_date    <= -23 =>  2,
		pk_yr_add2_mortgage_due_date    <= -12 =>  1,
		0
		);


		pk_add2_assessed_amount2     := map(
		pk_add2_assessed_amount    <=      0 =>  -1,
		pk_add2_assessed_amount    <=  60000 =>   0,
		pk_add2_assessed_amount    <= 100000 =>   1,
		pk_add2_assessed_amount    <= 120000 =>   2,
		pk_add2_assessed_amount    <= 260000 =>   3,
		4
		);


		pk_yr_add2_date_first_seen2     := map(
		pk_yr_add2_date_first_seen    <=   NULL  => -1,
		pk_yr_add2_date_first_seen    <=   1  =>  0,
		pk_yr_add2_date_first_seen    <=   2  =>  1,
		pk_yr_add2_date_first_seen    <=   3  =>  2,
		pk_yr_add2_date_first_seen    <=   4  =>  3,
		pk_yr_add2_date_first_seen    <=   6  =>  4,
		pk_yr_add2_date_first_seen    <=   7  =>  5,
		pk_yr_add2_date_first_seen    <=   8  =>  6,
		pk_yr_add2_date_first_seen    <=   9  =>  7,
		pk_yr_add2_date_first_seen    <=  13  =>  8,
		pk_yr_add2_date_first_seen    <=  17  =>  9,
		pk_yr_add2_date_first_seen    <=  21  => 10,
		11
		);


		pk_yr_add2_date_last_seen2     := map(
		pk_yr_add2_date_last_seen    <=  NULL  => -1,
		pk_yr_add2_date_last_seen    <=  1  =>  0,
		pk_yr_add2_date_last_seen    <=  2  =>  1,
		pk_yr_add2_date_last_seen    <=  3  =>  2,
		pk_yr_add2_date_last_seen    <=  5  =>  3,
		pk_yr_add2_date_last_seen    <=  6  =>  4,
		pk_yr_add2_date_last_seen    <= 10  =>  5,
		6
		);


		pk_yr_add3_built_date2     := map(
		pk_yr_add3_built_date    <=   NULL => -1,
		pk_yr_add3_built_date    <=   4 =>  0,
		pk_yr_add3_built_date    <=  10 =>  1,
		pk_yr_add3_built_date    <=  16 =>  2,
		3
		);


		pk_add3_purchase_amount2     := map(
		pk_add3_purchase_amount    <=      0 => -1,
		pk_add3_purchase_amount    <=  20000 =>  0,
		pk_add3_purchase_amount    <=  60000 =>  1,
		pk_add3_purchase_amount    <=  80000 =>  2,
		pk_add3_purchase_amount    <= 260000 =>  3,
		4
		);


		pk_add3_mortgage_risk := map(
		trim( add3_mortgage_type ) in [  'S', '1', 'H'     ] =>  5,
		trim( add3_mortgage_type ) in [  'FHA', '2'        ] =>  4,
		trim( add3_mortgage_type ) in [  'N', 'R', 'G'     ] =>  3,
		trim( add3_mortgage_type ) in [  'U', '', 'P'      ] =>  2,
		trim( add3_mortgage_type ) in [  'VA'              ] =>  1,
		trim( add3_mortgage_type ) in [  'CNS', 'E', 'C'   ] =>  0,
		-1
		);


		pk_add3_adjustable_financing   := map(
			   trim( add3_financing_type ) = 'ADJ'  =>  1,
		0
		);


		pk_yr_add3_mortgage_due_date2     := map(
		pk_yr_add3_mortgage_due_date    <=   NULL =>  -1 ,
		pk_yr_add3_mortgage_due_date    <= -22 =>   0 ,
		1 
		);


		pk_add3_assessed_amount2     := map(
		pk_add3_assessed_amount    <=      0 => -1,
		pk_add3_assessed_amount    <=  60000 =>  0,
		pk_add3_assessed_amount    <=  80000 =>  1,
		pk_add3_assessed_amount    <= 140000 =>  2,
		3
		);


		pk_yr_add3_date_first_seen2     := map(
		pk_yr_add3_date_first_seen    <=   NULL => -1,
		pk_yr_add3_date_first_seen    <=   1 =>  0,
		pk_yr_add3_date_first_seen    <=   2 =>  1,
		pk_yr_add3_date_first_seen    <=   3 =>  2,
		pk_yr_add3_date_first_seen    <=   4 =>  3,
		pk_yr_add3_date_first_seen    <=   5 =>  4,
		pk_yr_add3_date_first_seen    <=   8 =>  5,
		pk_yr_add3_date_first_seen    <=  11 =>  6,
		pk_yr_add3_date_first_seen    <=  14 =>  7,
		pk_yr_add3_date_first_seen    <=  18 =>  8,
		9
		);


		pk_yr_add3_date_last_seen2     := map(
		pk_yr_add3_date_last_seen    <=  NULL  => -1,
		pk_yr_add3_date_last_seen    <=  1  =>  0,
		pk_yr_add3_date_last_seen    <=  2  =>  1,
		pk_yr_add3_date_last_seen    <=  3  =>  2,
		pk_yr_add3_date_last_seen    <=  4  =>  3,
		pk_yr_add3_date_last_seen    <=  7  =>  4,
		pk_yr_add3_date_last_seen    <=  9  =>  5,
		pk_yr_add3_date_last_seen    <= 12  =>  6,
		pk_yr_add3_date_last_seen    <= 14  =>  7,
		8
		);


		pk_yr_attr_date_last_purchase2     := map(
		pk_yr_attr_date_last_purchase    <=  NULL  => -1,
		pk_yr_attr_date_last_purchase    <=  1  =>  0,
		pk_yr_attr_date_last_purchase    <=  2  =>  1,
		pk_yr_attr_date_last_purchase    <=  3  =>  2,
		pk_yr_attr_date_last_purchase    <=  4  =>  3,
		pk_yr_attr_date_last_purchase    <=  5  =>  4,
		pk_yr_attr_date_last_purchase    <= 12  =>  5,
		pk_yr_attr_date_last_purchase    <= 24  =>  6,
		7
		);


		pk_attr_num_purchase180   := map(
		attr_num_purchase180    <= 0  => 0 ,
		1 
		);


		pk_yr_attr_date_last_sale2     := map(
		pk_yr_attr_date_last_sale    <=  NULL  => -1,
		pk_yr_attr_date_last_sale    <=  2  =>  0,
		pk_yr_attr_date_last_sale    <=  3  =>  1,
		pk_yr_attr_date_last_sale    <=  5  =>  2,
		pk_yr_attr_date_last_sale    <=  8  =>  3,
		4
		);


		pk_attr_num_sold60   := map(
		attr_num_sold60    <=  0  =>  0,
		1
		);


		pk_attr_num_watercraft90   := map(
		attr_num_watercraft90    <=   0 =>  0,
		1
		);


		pk_attr_num_watercraft180   := map(
		attr_num_watercraft180    <=  0  => 0 ,
		1 
		);


		pk_attr_num_watercraft24   := map(
		attr_num_watercraft24    <=  0  =>  0,
		attr_num_watercraft24    <=  2  =>  1,
		2
		);


		/* Derog    */


		pk_yr_liens_unrel_cj_first_seen    := roundup( years_liens_unrel_cj_first_seen );
		pk_yr_liens_unrel_lt_first_seen    := roundup( years_liens_unrel_lt_first_seen );
		pk_yr_liens_unrel_ot_first_seen    := roundup( years_liens_unrel_ot_first_seen );
		pk_yr_liens_unrel_sc_first_seen    := roundup( years_liens_unrel_sc_first_seen );
		pk_yr_attr_date_last_eviction      := roundup( years_attr_date_last_eviction   );
		pk_yr_criminal_last_date           := roundup( years_criminal_last_date        );


		pk_bk_level := map(
			   ( filing_count >= 2 ) or
				  (( trim( filing_type ) = '' ) and ( filing_count >= 1 )) or
				  ( StringLib.StringToUpperCase( trim( disposition )) = 'DISMISSED' ) or
				  ( bk_disposed_historical_count >= 2 )
								   => 2,
			   bk_flag => 1,
		0
		);


			/* Liens */


		pk_liens_unrel_cj_ct   := map(
		liens_unrel_cj_ct    <=  0  =>  0,
		liens_unrel_cj_ct    <=  1  =>  1,
		liens_unrel_cj_ct    <=  2  =>  2,
		liens_unrel_cj_ct    <=  3  =>  3,
		4
		);

		pk_liens_unrel_ft_ct   := map(
		liens_unrel_ft_ct    <=  0  =>  0,
		1
		);


		pk_liens_unrel_lt_ct   := map(
		liens_unrel_lt_ct    <=  0  =>  0,
		1
		);

		pk_liens_unrel_o_ct   := map(
		liens_unrel_o_ct    <=   0 =>  0,
		1
		);

		pk_liens_unrel_ot_ct   := map(
		liens_unrel_ot_ct    <=  0  =>  0,
		1
		);

		pk_liens_unrel_sc_ct   := map(
		liens_unrel_sc_ct    <=  0  =>  0,
		liens_unrel_sc_ct    <=  1  =>  1,
		2
		);


       pk_liens_unrel_count := liens_recent_unreleased_count + liens_historical_unreleased_ct;


		pk_lien_type_level := map(
			   (( pk_liens_unrel_cj_ct >= 4 ) or ( pk_liens_unrel_lt_ct >= 1 ) or ( pk_liens_unrel_sc_ct >= 2 )) => 5,
			   (( pk_liens_unrel_cj_ct >= 2 ) or                                  ( pk_liens_unrel_sc_ct >= 1 )) => 4,
			   ( pk_liens_unrel_cj_ct >= 1 )                                                                    => 3,
			   (( pk_liens_unrel_ft_ct >= 1 ) or ( pk_liens_unrel_ot_ct >= 1 ))                                  => 2,
			   (( pk_liens_unrel_o_ct >= 1 )  or ( pk_liens_unrel_count >= 1 ))                                  => 1,
		0
		);


		pk_yr_liens_unrel_cj_first_sn2        := map(
		pk_yr_liens_unrel_cj_first_seen    <=  NULL  => -1,
		pk_yr_liens_unrel_cj_first_seen    <=  1  =>  0,
		pk_yr_liens_unrel_cj_first_seen    <=  2  =>  1,
		pk_yr_liens_unrel_cj_first_seen    <=  4  =>  2,
		3
		);


		pk_yr_liens_unrel_lt_first_sn2        := map(
		pk_yr_liens_unrel_lt_first_seen    <=  NULL  => -1,
		pk_yr_liens_unrel_lt_first_seen    <=  2  =>  0,
		1
		);


		pk_yr_liens_unrel_ot_first_sn2        := map(
		pk_yr_liens_unrel_ot_first_seen    <=  NULL  => -1,
		pk_yr_liens_unrel_ot_first_seen    <=  3  =>  0,
		pk_yr_liens_unrel_ot_first_seen    <=  5  =>  1,
		2
		);


		pk_yr_liens_unrel_sc_first_sn2        := map(
		pk_yr_liens_unrel_sc_first_seen    <=  NULL  => -1,
		pk_yr_liens_unrel_sc_first_seen    <=  2  =>  0,
		1
		);


			/* Evictions */

		pk_attr_eviction_count   := map(
		attr_eviction_count    <=  0  =>  0,
		attr_eviction_count    <=  1  =>  1,
		attr_eviction_count    <=  2  =>  2,
		3
		);

		pk_yr_attr_date_last_eviction2   := map(
		pk_yr_attr_date_last_eviction    <=  NULL  => -1,
		pk_yr_attr_date_last_eviction    <=  1  =>  0,
		pk_yr_attr_date_last_eviction    <=  2  =>  1,
		pk_yr_attr_date_last_eviction    <=  3  =>  2,
		pk_yr_attr_date_last_eviction    <=  4  =>  3,
		pk_yr_attr_date_last_eviction    <=  5  =>  4,
		5
		);


		pk_eviction_level := map(
		attr_eviction_count30    > 0 => 7,
		attr_eviction_count90    > 0 => 6,
		attr_eviction_count180   > 0 => 5,
		attr_eviction_count12    > 0 => 4,
		attr_eviction_count24    > 0 => 3,
		attr_eviction_count36    > 0 => 2,
		pk_attr_eviction_count  >= 3 => 2,
		attr_eviction_count60    > 0 => 1,
		pk_attr_eviction_count  >= 1 => 1,
		0
		);


    /* Criminal Felony */


		pk_yr_criminal_last_date2     := map(
		pk_yr_criminal_last_date    <=  NULL  => -1,
		pk_yr_criminal_last_date    <=  1  =>  0,
		pk_yr_criminal_last_date    <=  2  =>  1,
		pk_yr_criminal_last_date    <=  3  =>  2,
		pk_yr_criminal_last_date    <=  5  =>  3,
		4
		);


		pk_crime_level := map(
			   crime_felony_flag                => 2,
			   crime_drug_flag or 1=source_tot_FF => 1,
		0
		);


		pk_felony_recent_level := map(
		attr_felonies12  > 0 => 4,
		attr_felonies24  > 0 => 3,
		attr_felonies36  > 0 => 2,
		attr_felonies60  > 0 => 1,
		0
		);


		/* FP - Validation        */


		pk_yr_rc_ssnhighissue      := roundup( years_rc_ssnhighissue                   );
		pk_yr_rc_areacodesplitdate := roundup( years_rc_areacodesplitdate              );




		/* Phone Problems */


		pk_recent_AC_Split := map(
			   pk_yr_rc_areacodesplitdate >= 1 and pk_yr_rc_areacodesplitdate <= 5 =>  1,
			   pk_yr_rc_areacodesplitdate >= 6                                => -1,
		0
		);

       pk_phn_not_residential := not( phn_residential );


		pk_disconnected := map(
			   trim( nap_status ) = 'C' => -1,
			   phn_disconnected          =>  1,
		0
		);


		pk_phn_cell_pager_inval := if( phn_cellpager or phn_inval, 1, 0 );


    /* SSN Problems */


		pk_yr_rc_ssnhighissue2 := map(
			   pk_yr_rc_ssnhighissue  =  NULL => -1,
			   pk_yr_rc_ssnhighissue <=  0 =>  0,
			   pk_yr_rc_ssnhighissue <=  3 =>  1,
			   pk_yr_rc_ssnhighissue <= 10 =>  2,
			   pk_yr_rc_ssnhighissue <= 12 =>  3,
			   pk_yr_rc_ssnhighissue <= 18 =>  4,
			   pk_yr_rc_ssnhighissue <= 21 =>  5,
			   pk_yr_rc_ssnhighissue <= 24 =>  6,
			   pk_yr_rc_ssnhighissue <= 26 =>  7,
			   pk_yr_rc_ssnhighissue <= 28 =>  8,
			   pk_yr_rc_ssnhighissue <= 31 =>  9,
			   pk_yr_rc_ssnhighissue <= 34 => 10,
			   pk_yr_rc_ssnhighissue <= 39 => 11,
			   pk_yr_rc_ssnhighissue <= 41 => 12,
			   pk_yr_rc_ssnhighissue <= 45 => 13,
		14
		);


			/* Professional License   */


		pk_PL_Sourced_Level := map(
			   source_add_PL = 1 and source_lst_PL = 1 and source_fst_PL = 1 and prof_license_flag => 3,
			   source_add_PL = 1 and source_lst_PL = 1 and source_fst_PL = 1                           => 2,
			   prof_license_flag => 2,
			   source_add_PL = 0 and source_lst_PL = 0 and source_fst_PL = 0                           => 0,
		1
		);

		pk_prof_lic_cat := map(
			   trim(prof_license_category)='' => -1,
			   (integer)prof_license_category <= 1 =>  0,
			   (integer)prof_license_category <= 3 =>  1,
			   (integer)prof_license_category <= 4 =>  2,
		3
		);


		pk_attr_num_proflic90   := map(
			   attr_num_proflic90  > 0 => 1,
		0
		);


		pk_attr_num_proflic_exp30  := map(
			   attr_num_proflic_exp30  > 0 => 1,
		0
		);


			/* LRes     */


			   pk_add_lres_year_avg  := roundup( add_lres_year_avg               );
			   pk_add_lres_year_max  := roundup( add_lres_year_max               );


		pk_add1_lres   := map(
		not add1_pop      => -2,
		add1_lres    <=   0 => -1,
		add1_lres    <=   1 =>  0,
		add1_lres    <=   2 =>  1,
		add1_lres    <=   3 =>  2,
		add1_lres    <=   4 =>  3,
		add1_lres    <=  12 =>  4,
		add1_lres    <=  15 =>  5,
		add1_lres    <=  27 =>  6,
		add1_lres    <=  61 =>  7,
		add1_lres    <= 102 =>  8,
		add1_lres    <= 123 =>  9,
		add1_lres    <= 234 => 10,
		11
		);


		pk_add2_lres   := map(
		not add2_pop         => -2,
		add2_lres    <=   0  => -1,
		add2_lres    <=   2  =>  0,
		add2_lres    <=   9  =>  1,
		add2_lres    <=  21  =>  2,
		add2_lres    <=  25  =>  3,
		add2_lres    <=  33  =>  4,
		add2_lres    <=  50  =>  5,
		add2_lres    <=  87  =>  6,
		add2_lres    <= 120  =>  7,
		add2_lres    <= 168  =>  8,
		add2_lres    <= 240  =>  9,
		10
		);


		pk_add3_lres   := map(
		not add3_pop        => -2,
		add3_lres    <=   0 => -1,
		add3_lres    <=  35 =>  0,
		add3_lres    <=  59 =>  1,
		add3_lres    <=  94 =>  2,
		add3_lres    <= 119 =>  3,
		add3_lres    <= 142 =>  4,
		add3_lres    <= 197 =>  5,
		6
		);

		pk_add1_lres_flag := if( add1_lres > 0, 1, 0);
		pk_add2_lres_flag := if( add2_lres > 0, 1, 0);
		pk_add3_lres_flag := if( add3_lres > 0, 1, 0);

		pk_lres_flag_level := map(
			   pk_add1_lres_flag=1 and ( pk_add2_lres_flag=1 or pk_add3_lres_flag=1 ) => 2,
			   pk_add1_lres_flag=1                                                    => 1,
		0
		);


		pk_avg_lres   := map(
			avg_lres    <=   0  => -1,
			avg_lres    <=   2  =>  0,
			avg_lres    <=   4  =>  1,
			avg_lres    <=   8  =>  2,
			avg_lres    <=  11  =>  3,
			avg_lres    <=  16  =>  4,
			avg_lres    <=  19  =>  5,
			avg_lres    <=  27  =>  6,
			avg_lres    <=  40  =>  7,
			avg_lres    <=  53  =>  8,
			avg_lres    <=  60  =>  9,
			avg_lres    <=  68  => 10,
			avg_lres    <=  81  => 11,
			avg_lres    <=  97  => 12,
			avg_lres    <= 118  => 13,
			avg_lres    <= 167  => 14,
			15
		);


		pk_addrs_5yr   := map(
		addrs_5yr    <=  0  =>  0,
		addrs_5yr    <=  2  =>  1,
		addrs_5yr    <=  4  =>  2,
		addrs_5yr    <=  6  =>  3,
		4
		);


		pk_addrs_10yr   := map(
		addrs_10yr    <=  0  =>  0,
		addrs_10yr    <=  1  =>  1,
		addrs_10yr    <=  6  =>  2,
		addrs_10yr    <=  8  =>  3,
		4
		);


		pk_add_lres_year_avg2     := map(
		pk_add_lres_year_avg    <=  NULL  => -1,
		pk_add_lres_year_avg    <=  1  =>  0,
		pk_add_lres_year_avg    <=  2  =>  1,
		pk_add_lres_year_avg    <=  3  =>  2,
		pk_add_lres_year_avg    <=  4  =>  3,
		pk_add_lres_year_avg    <=  5  =>  4,
		pk_add_lres_year_avg    <=  6  =>  5,
		pk_add_lres_year_avg    <=  7  =>  6,
		pk_add_lres_year_avg    <=  8  =>  7,
		pk_add_lres_year_avg    <=  9  =>  8,
		pk_add_lres_year_avg    <= 10  =>  9,
		pk_add_lres_year_avg    <= 11  => 10,
		pk_add_lres_year_avg    <= 12  => 11,
		pk_add_lres_year_avg    <= 13  => 12,
		pk_add_lres_year_avg    <= 14  => 13,
		pk_add_lres_year_avg    <= 15  => 14,
		pk_add_lres_year_avg    <= 16  => 15,
		pk_add_lres_year_avg    <= 18  => 16,
		pk_add_lres_year_avg    <= 22  => 17,
		pk_add_lres_year_avg    <= 26  => 18,
		19
		);


		pk_add_lres_year_max2     := map(
		pk_add_lres_year_max    <=  NULL  => -1,
		pk_add_lres_year_max    <=  1  =>  0,
		pk_add_lres_year_max    <=  2  =>  1,
		pk_add_lres_year_max    <=  3  =>  2,
		pk_add_lres_year_max    <=  4  =>  3,
		pk_add_lres_year_max    <=  5  =>  4,
		pk_add_lres_year_max    <=  7  =>  5,
		pk_add_lres_year_max    <=  8  =>  6,
		pk_add_lres_year_max    <=  9  =>  7,
		pk_add_lres_year_max    <= 10  =>  8,
		pk_add_lres_year_max    <= 12  =>  9,
		pk_add_lres_year_max    <= 15  => 10,
		pk_add_lres_year_max    <= 17  => 11,
		pk_add_lres_year_max    <= 18  => 12,
		pk_add_lres_year_max    <= 19  => 13,
		pk_add_lres_year_max    <= 20  => 14,
		pk_add_lres_year_max    <= 21  => 15,
		pk_add_lres_year_max    <= 26  => 16,
		pk_add_lres_year_max    <= 39  => 17,
		18
		);


			/* Velocity */

		pk_nameperssn_count   := map(
		nameperssn_count    <=  0  => 0 ,
		nameperssn_count    <=  1  => 1 ,
		2 
		);


		pk_ssns_per_adl   := map(
		ssns_per_adl    <=  0  => -1,
		ssns_per_adl    <=  1  =>  0,
		ssns_per_adl    <=  2  =>  1,
		ssns_per_adl    <=  3  =>  2,
		ssns_per_adl    <=  4  =>  3,
		4
		);


		pk_addrs_per_adl   := map(
		addrs_per_adl    <=  0  => -6,
		addrs_per_adl    <=  1  => -5,
		addrs_per_adl    <=  2  => -4,
		addrs_per_adl    <=  3  => -3,
		addrs_per_adl    <=  4  => -2,
		addrs_per_adl    <=  5  => -1,
		addrs_per_adl    <= 10  =>  0 ,       /* Optimal Number  */
		addrs_per_adl    <= 12  =>  1,
		addrs_per_adl    <= 18  =>  2,
		3
		);


		pk_phones_per_adl   := map(
		phones_per_adl    <=  0  => -1,
		phones_per_adl    <=  1  =>  0,
		phones_per_adl    <=  2  =>  1,
		2
		);


		pk_addrs_per_ssn   := map(
		addrs_per_ssn    <=  0  => -4,
		addrs_per_ssn    <=  4  => -3,
		addrs_per_ssn    <=  6  => -2,
		addrs_per_ssn    <=  7  => -1,
		addrs_per_ssn    <=  8  =>  0 ,        /* Optimal */
		addrs_per_ssn    <= 11  =>  1,
		addrs_per_ssn    <= 18  =>  2,
		3
		);




	   if( not add_apt ) then /* Not Apartments */


			pk_adls_per_addr   := map(
			adls_per_addr    <=  0  => -2,
			adls_per_addr    <=  1  => -1,
			adls_per_addr    <=  2  =>  0,
			adls_per_addr    <=  3  =>  1,
			adls_per_addr    <=  4  =>  2,
			adls_per_addr    <=  5  =>  3,
			adls_per_addr    <=  6  =>  4,
			adls_per_addr    <=  7  =>  5,
			adls_per_addr    <=  8  =>  6,
			adls_per_addr    <=  9  =>  7,
			adls_per_addr    <= 10  =>  8,
			adls_per_addr    <= 11  =>  9,
			adls_per_addr    <= 13  => 10,
			adls_per_addr    <= 16  => 11,
			adls_per_addr    <= 21  => 12,
			13
			);


			pk_ssns_per_addr2  := map(
					  ssns_per_addr    <=  0 and pk_add1_unit_count2 = 3 => 10,
					  ssns_per_addr    <=  0  => -2 ,
					  ssns_per_addr    <=  1 and pk_add1_unit_count2 = 3 => -2 ,
					  ssns_per_addr    <=  1  => -1 ,
					  ssns_per_addr    <=  2 and pk_add1_unit_count2 in [ 2, 3 ] =>  6 ,
					  ssns_per_addr    <=  2  =>  0 ,
					  ssns_per_addr    <=  3 and pk_add1_unit_count2 in [ 2, 3 ] =>  10 ,
					  ssns_per_addr    <=  3  =>  1 ,
					  ssns_per_addr    <=  4 and pk_add1_unit_count2 in [ 2, 3 ] =>  10 ,
					  ssns_per_addr    <=  4  =>  2 ,
					  ssns_per_addr    <=  5 and pk_add1_unit_count2 = 3 =>  10,
					  ssns_per_addr    <=  5  =>  3 ,
					  ssns_per_addr    <=  6 and pk_add1_unit_count2 = 3 =>  11,
					  ssns_per_addr    <=  6  =>  4 ,
					  ssns_per_addr    <=  7 and pk_add1_unit_count2 = 3 =>  11,
					  ssns_per_addr    <=  7  =>  5 ,
					  ssns_per_addr    <=  8 and pk_add1_unit_count2 = 3 =>  12,
					  ssns_per_addr    <=  8  =>  6 ,
					  ssns_per_addr    <=  9 and pk_add1_unit_count2 = 3 =>  12,
					  ssns_per_addr    <=  9  =>  7 ,
					  ssns_per_addr    <= 11 and pk_add1_unit_count2 = 3 =>  12,
					  ssns_per_addr    <= 11  =>  8 ,
					  ssns_per_addr    <= 13 and pk_add1_unit_count2 = 3 =>  12,
					  ssns_per_addr    <= 13  =>  9 ,
					  ssns_per_addr    <= 16 and pk_add1_unit_count2 = 3 =>  12 ,
					  ssns_per_addr    <= 16  => 10 ,
					  ssns_per_addr    <= 24  => 11 ,
					  12
			);


			pk_phones_per_addr   := map(
			phones_per_addr    <=  0  => -1,
			phones_per_addr    <=  1  =>  0,
			phones_per_addr    <=  2  =>  1,
			phones_per_addr    <=  3  =>  2,
			3
			);



       else  /* Add_Apt = 1         Apartments       */


			pk_adls_per_addr   := map(
			adls_per_addr    <=  0  => -102,
			adls_per_addr    <=  1  => -101,
			adls_per_addr    <=  2  =>  100,
			adls_per_addr    <=  3  =>  101,
			102
			);


			pk_ssns_per_addr2  := map(
			ssns_per_addr    <=  1  => -101,
			ssns_per_addr    <=  2  =>  100,
			ssns_per_addr    <=  3  =>  101,
			ssns_per_addr    <= 13  =>  102,
			103
			);

			pk_phones_per_addr   := map(
			phones_per_addr    <=  0  => 100,
			phones_per_addr    <=  1  => 101,
			phones_per_addr    <=  2  => 102,
			103
			);


       end;

		pk_adls_per_phone   := map(
		adls_per_phone    <=  0  => -2,
		adls_per_phone    <=  1  => -1,
		adls_per_phone    <=  2  =>  0,
		1
		);


		pk_addrs_per_adl_c6   := map(
		addrs_per_adl_c6    <=  0  =>  0,
		addrs_per_adl_c6    <=  1  =>  1,
		addrs_per_adl_c6    <=  2  =>  2,
		3
		);


		pk_phones_per_adl_c6   := map(
		phones_per_adl_c6    <=  0  => -2,
		phones_per_adl_c6    <=  1  => -1,
		phones_per_adl_c6    <=  2  =>  0,
		1
		);


		pk_addrs_per_ssn_c6   := map(
		addrs_per_ssn_c6    <=  0  =>  0,
		1
		);
		




		if( not add_apt ) then /* Not Apartments */


			pk_adls_per_addr_c6   := map(
			adls_per_addr_c6    <=  0  =>  0,
			adls_per_addr_c6    <=  1  =>  1,
			adls_per_addr_c6    <=  2  =>  2,
			adls_per_addr_c6    <=  4  =>  3,
			4
			);

			pk_ssns_per_addr_c6   := map(
			ssns_per_addr_c6    <=  0  =>  0,
			ssns_per_addr_c6    <=  1  =>  1,
			ssns_per_addr_c6    <=  2  =>  2,
			ssns_per_addr_c6    <=  3  =>  3,
			ssns_per_addr_c6    <=  4  =>  4,
			ssns_per_addr_c6    <=  5  =>  5,
			6
			);

			pk_phones_per_addr_c6   := map(
			phones_per_addr_c6    <=  0  => -1,
			phones_per_addr_c6    <=  1  =>  0,
			phones_per_addr_c6    <=  2  =>  1,
			2
			);



		else /* Add_Apt = 1         Apartments       */



			pk_adls_per_addr_c6   := map(
			adls_per_addr_c6    <=  0  => 100,
			adls_per_addr_c6    <=  2  => 101,
			102
			);

			pk_ssns_per_addr_c6   := map(
			ssns_per_addr_c6    <=  0  => 100,
			ssns_per_addr_c6    <=  1  => 101,
			ssns_per_addr_c6    <=  2  => 102,
			ssns_per_addr_c6    <=  3  => 103,
			104
			);

			pk_phones_per_addr_c6   := map(
			phones_per_addr_c6    <=  0  => 100,
			phones_per_addr_c6    <=  2  => 101,
			102
			);


       end;


pk_adls_per_phone_c6   := map(
adls_per_phone_c6    <=  0  =>  0,
adls_per_phone_c6    <=  1  =>  1,
2
);


pk_attr_addrs_last30   := map(
attr_addrs_last30    <=  0  =>  0,
attr_addrs_last30    <=  1  =>  1,
2
);


pk_attr_addrs_last36   := map(
attr_addrs_last36    <=  0  =>  0,
attr_addrs_last36    <=  1  =>  1,
attr_addrs_last36    <=  2  =>  2,
attr_addrs_last36    <=  3  =>  3,
attr_addrs_last36    <=  4  =>  4,
attr_addrs_last36    <=  5  =>  5,
6
);


pk_attr_addrs_last_level := map(
       attr_addrs_last30 > 0 => 5,
       attr_addrs_last90 > 0 => 4,
       attr_addrs_last12 > 0 => 3,
       attr_addrs_last24 > 0 => 2,
       attr_addrs_last36 > 0 => 1,
0
);


    /* AMStudent */


pk_ams_college_tier := map(
	trim(ams_college_tier) = '' => -1,
	(integer)ams_college_tier
);


ams_class_n := if( (integer)ams_class >= 60, 1900, 2000 ) + (integer)ams_class;
pk_since_ams_class_year := sysyear - ams_class_n;

pk_ams_class_level := map(
	trim(ams_class) = 'GR' =>   1000005,
	trim(ams_class) = 'SR' =>   1000004,
	trim(ams_class) = 'JR' =>   1000003,
	trim(ams_class) = 'SO' =>   1000001,
	trim(ams_class) = 'FR' =>   1000000,
	trim(ams_class) = 'UN' =>   1000002,
	trim(ams_class) = ''   =>  -1000001,
	pk_since_ams_class_year <=  1 => 0,
	pk_since_ams_class_year <=  2 => 1,
	pk_since_ams_class_year <=  3 => 2,
	pk_since_ams_class_year <=  4 => 3,
	pk_since_ams_class_year <=  5 => 4,
	pk_since_ams_class_year <= 10 => 5,
	pk_since_ams_class_year <= 13 => 6,
	pk_since_ams_class_year <= 17 => 7,
	8
);


pk_ams_income_level_code   := map(
	trim( ams_income_level_code ) in [ 'A', 'B' ] =>  0,
	trim( ams_income_level_code ) in [ 'C' ]      =>  1,
	trim( ams_income_level_code ) in [ 'D', 'E' ] =>  2,
	trim( ams_income_level_code ) in [ 'F' ]      =>  3,
	trim( ams_income_level_code ) in [ 'G', 'H' ] =>  4,
	trim( ams_income_level_code ) in [ 'I', 'J' ] =>  5,
	trim( ams_income_level_code ) in [ 'K' ]      =>  6,
	-1
);


    /* Age      */


       pk_yr_rc_correct_dob  := if(years_rc_correct_dob=NULL, NULL, roundup( years_rc_correct_dob ));


pk_yr_rc_correct_dob2   := map(
pk_yr_rc_correct_dob    =  NULL  => -1,
pk_yr_rc_correct_dob    <= 21  => 21,
pk_yr_rc_correct_dob    <= 33  => 33,
pk_yr_rc_correct_dob    <= 61  => 61,
99
);


pk_ams_age   := map(
trim(ams_age) = '' => -1,
(integer)ams_age    <= 21  => 21,
(integer)ams_age    <= 22  => 22,
(integer)ams_age    <= 23  => 23,
(integer)ams_age    <= 24  => 24,
(integer)ams_age    <= 25  => 25,
(integer)ams_age    <= 29  => 29,
99
);


pk_inferred_age   := map(
inferred_age    <=  0  => -1,
inferred_age    <= 18  => 18,
inferred_age    <= 19  => 19,
inferred_age    <= 20  => 20,
inferred_age    <= 21  => 21,
inferred_age    <= 22  => 22,
inferred_age    <= 24  => 24,
inferred_age    <= 34  => 34,
inferred_age    <= 37  => 37,
inferred_age    <= 41  => 41,
inferred_age    <= 42  => 42,
inferred_age    <= 43  => 43,
inferred_age    <= 44  => 44,
inferred_age    <= 46  => 46,
inferred_age    <= 48  => 48,
inferred_age    <= 52  => 52,
inferred_age    <= 56  => 56,
inferred_age    <= 61  => 61,
99
);


    /* AVM      */

       pk_yr_add1_avm_recording_date      := roundup( years_add1_avm_recording_date   );
       pk_yr_add1_avm_assess_year         := roundup( years_add1_avm_assess_year      );


       pk_add1_avm_sp         := min( 1000000, 20000 * roundup ( (integer)add1_avm_sales_price / 20000 ));
       pk_add1_avm_ta         := min( 1000000, 20000 * roundup ( (integer)add1_avm_tax_assessed_valuation / 20000 ));
       pk_add1_avm_pi         := min( 1000000, 20000 * roundup ( (integer)add1_avm_price_index_valuation / 20000 ));
       pk_add1_avm_med        := min( 1000000, 20000 * roundup ( (integer)add1_avm_med      / 20000 ));
       pk_add2_avm_auto       := min( 1000000, 20000 * roundup ( (integer)add2_avm_automated_valuation / 20000 ));
       pk_add2_avm_auto4      := min( 1000000, 20000 * roundup ( (integer)add2_avm_automated_valuation_4 / 20000 ));


       // pk_add1_avm_to_med_ratio := min( 10, Models.Common.round ( add1_avm_to_med_ratio, 0.1 ));
       pk_add1_avm_to_med_ratio := min( 10, round( 10*add1_avm_to_med_ratio ) / 10);


pk2_add1_avm_sp     := map(
pk_add1_avm_sp    <=  80000 =>  0,
pk_add1_avm_sp    <= 120000 =>  1,
pk_add1_avm_sp    <= 180000 =>  2,
3
);


pk2_add1_avm_ta     := map(
pk_add1_avm_ta    <=      0 =>  1,
pk_add1_avm_ta    <=  40000 =>  0,
pk_add1_avm_ta    <=  80000 =>  1,
pk_add1_avm_ta    <= 120000 =>  2,
pk_add1_avm_ta    <= 580000 =>  3,
4
);


pk2_add1_avm_pi     := map(
pk_add1_avm_pi    <=      0 =>  2,
pk_add1_avm_pi    <=  20000 =>  0,
pk_add1_avm_pi    <= 120000 =>  1,
pk_add1_avm_pi    <= 180000 =>  2,
3
);


pk2_ADD1_AVM_MED     := map(
pk_ADD1_AVM_MED    <=      0 =>  7,
pk_ADD1_AVM_MED    <=  20000 =>  0,
pk_ADD1_AVM_MED    <=  40000 =>  1,
pk_ADD1_AVM_MED    <=  60000 =>  2,
pk_ADD1_AVM_MED    <=  80000 =>  3,
pk_ADD1_AVM_MED    <= 120000 =>  4,
pk_ADD1_AVM_MED    <= 620000 =>  5,
pk_ADD1_AVM_MED    <= 720000 =>  6,
7
);


pk2_add1_avm_to_med_ratio     := map(
	pk_add1_avm_to_med_ratio    <=   NULL  =>  0,
	pk_add1_avm_to_med_ratio    <=  0.7 =>  0,
	pk_add1_avm_to_med_ratio    <=  1.0 =>  1,
	pk_add1_avm_to_med_ratio    <=  1.1 =>  2,
	pk_add1_avm_to_med_ratio    <=  1.4 =>  3,
	pk_add1_avm_to_med_ratio    <=  1.7 =>  4,
	5
);


pk_add2_avm_auto_diff4 := map(
       pk_add2_avm_auto = 0 or pk_add2_avm_auto4 = 0 => -999999,
       pk_add2_avm_auto - pk_add2_avm_auto4
	   );


pk_add2_avm_auto_diff4_lvl := map(
       pk_add2_avm_auto_diff4 = -999999 => -1,
       pk_add2_avm_auto_diff4  <  80000 =>  0,
1
);


pk2_yr_add1_avm_recording_date     := map(
pk_yr_add1_avm_recording_date    <=   NULL =>  2,
pk_yr_add1_avm_recording_date    <=   2 =>  0,
pk_yr_add1_avm_recording_date    <=   3 =>  1,
pk_yr_add1_avm_recording_date    <=   5 =>  2,
pk_yr_add1_avm_recording_date    <=  13 =>  3,
4
);


pk2_yr_add1_avm_assess_year     := map(
pk_yr_add1_avm_assess_year    <=  NULL  =>  0,
pk_yr_add1_avm_assess_year    <=  1  =>  1,
2
);


    /* Distance */


pk_dist_a1toa3 := map(
       dist_a1toa3  =    0 => 0,
       dist_a1toa3  = 9999 => 6,
       dist_a1toa3 <=    1 => 5,
       dist_a1toa3 <=    2 => 4,
       dist_a1toa3 <=    4 => 3,
       dist_a1toa3 <=   40 => 2,
1
);


pk_rc_disthphoneaddr := map(
       rc_disthphoneaddr <=    0 => 0,
       rc_disthphoneaddr  = 9999 => 4,
       rc_disthphoneaddr <=    6 => 1,
       rc_disthphoneaddr <=   11 => 2,
3
);


    /* Other */


pk_out_st_division_lvl := map(
       trim( out_st ) in [ 'IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD' ] => 0,
       trim( out_st ) in [ 'IL', 'IN', 'MI', 'OH', 'WI' ] => 1,
       trim( out_st ) in [ 'AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY' ] => 2,
       trim( out_st ) in [ 'AL', 'KY', 'MS', 'TN' ] => 3,
       trim( out_st ) in [ 'DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV' ] => 4,
       trim( out_st ) in [ 'NJ', 'NY', 'PA' ] => 5,
       trim( out_st ) in [ 'AK', 'CA', 'HI', 'OR', 'WA' ] => 6,
       trim( out_st ) in [ 'AR', 'LA', 'OK', 'TX' ] => 7,
       trim( out_st ) in [ 'NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT' ] => 8,
       -1
);



    /* Brentos Variables */


       pk_impulse_count := min( 2, 1 * impulse_count );
       pk_attr_total_number_derogs := min( 3, 1 * attr_total_number_derogs );

        pk_attr_num_nonderogs90 := min( 4, 1 * attr_num_nonderogs90 );

pk_derog_total := if( pk_attr_total_number_derogs > 0, pk_attr_total_number_derogs, -1 * pk_attr_num_nonderogs90 );


       pk_attr_num_nonderogs90_b := ( 10 * (integer)add1_isbestmatch ) + pk_attr_num_nonderogs90;


    /* Segmentation Specific Means */


    /* Census */


       if( cenmatch = 1 ) then


pk_c_bargains   := map(
trim(c_bargains    )='' => -1,
(real)c_bargains    <=  73 =>  0,
(real)c_bargains    <= 109 =>  1,
(real)c_bargains    <= 118 =>  2,
3
);


pk_c_bel_edu   := map(
trim(c_bel_edu    )='' => -1,
(real)c_bel_edu    <=  14 =>  0,
(real)c_bel_edu    <=  24 =>  1,
(real)c_bel_edu    <=  34 =>  2,
(real)c_bel_edu    <=  43 =>  3,
(real)c_bel_edu    <=  61 =>  4,
(real)c_bel_edu    <=  80 =>  5,
(real)c_bel_edu    <=  99 =>  6,
(real)c_bel_edu    <= 147 =>  7,
8
);


pk_c_lowrent   := map(
trim(c_lowrent    )='' => -1,
(real)c_lowrent    <=  0  =>  0,
(real)c_lowrent    <=  3  =>  1,
(real)c_lowrent    <= 29  =>  2,
(real)c_lowrent    <= 56  =>  3,
(real)c_lowrent    <= 73  =>  4,
5
);


pk_c_med_hval   := map(
trim(c_med_hval    )=''  => -1,
(real)c_med_hval    <=  63113 =>  0,
(real)c_med_hval    <=  86806 =>  1,
(real)c_med_hval    <=  97419 =>  2,
(real)c_med_hval    <= 105665 =>  3,
(real)c_med_hval    <= 133811 =>  4,
(real)c_med_hval    <= 158671 =>  5,
(real)c_med_hval    <= 175525 =>  6,
(real)c_med_hval    <= 201715 =>  7,
(real)c_med_hval    <= 257692 =>  8,
9
);



     else


          
	pk_c_bargains    := -9;
        pk_c_bel_edu     := -9;
        pk_c_lowrent     := -9;
        pk_c_med_hval    := -9;


       end;


    /* Shorten long variables to make room for suffixes after code to means  */


       pk_yrmo_adl_f_sn_mx_fcra2    := 1 * pk_yrmo_adl_first_seen_max_fcra2                ;


       pk_add2_garage_type_risk_lvl := 1 * pk_add2_garage_type_risk_level                  ;

       pk_yr_attr_dt_last_purch2    := 1 * pk_yr_attr_date_last_purchase2                  ;


       pk_yr_ln_unrel_cj_f_sn2      := 1 * pk_yr_liens_unrel_cj_first_sn2                  ;
       pk_yr_ln_unrel_lt_f_sn2      := 1 * pk_yr_liens_unrel_lt_first_sn2                  ;
       pk_yr_ln_unrel_ot_f_sn2      := 1 * pk_yr_liens_unrel_ot_first_sn2                  ;
       pk_yr_ln_unrel_sc_f_sn2      := 1 * pk_yr_liens_unrel_sc_first_sn2                  ;
       pk_yr_attr_dt_l_eviction2    := 1 * pk_yr_attr_date_last_eviction2                  ;

       pk2_yr_add1_avm_rec_dt       := 1 * pk2_yr_add1_avm_recording_date                  ;


       pk_yr_add1_assess_val_yr2    := 1 * pk_yr_add1_assessed_value_year2                 ;

       pk_prop_owned_assess_count   := 1 * pk_property_owned_assessed_count                ;

       pk_yr_prop1_prev_purch_dt2   := 1 * pk_yr_prop1_prev_purchase_date2                 ;
       pk_yr_prop2_prev_purch_dt2   := 1 * pk_yr_prop2_prev_purchase_date2                 ;
       pk_yr_add2_assess_val_yr2    := 1 * pk_yr_add2_assessed_value_year2                 ;


        /*  Relatives  */


pk_rel_count   := map(
rel_count     =   0 => -9,
rel_count    <=   1 => -3,
rel_count    <=   2 => -2,
rel_count    <=   3 => -1,
rel_count    <=   4 =>  0,
rel_count    <=   5 =>  1,
rel_count    <=   6 =>  2,
rel_count    <=   9 =>  3,
rel_count    <=  12 =>  4,
rel_count    <=  18 =>  5,
6
);


pk_rel_bankrupt_count   := map(
rel_count              =   0 => -9,
rel_bankrupt_count    <=   0 =>  0,
rel_bankrupt_count    <=   1 =>  1,
rel_bankrupt_count    <=   3 =>  2,
rel_bankrupt_count    <=   7 =>  3,
4
);


pk_rel_felony_count   := map(
rel_count            =   0 => -9,
rel_felony_count    <=   0 =>  0,
rel_felony_count    <=   1 =>  1,
rel_felony_count    <=   2 =>  2,
rel_felony_count    <=   3 =>  3,
4
);


pk_crim_rel_within100miles   := map(
rel_count                   =   0 => -9,
crim_rel_within100miles    <=   0 =>  0,
crim_rel_within100miles    <=   2 =>  1,
2
);


pk_crim_rel_withinOther   := map(
rel_count                =   0 => -9,
crim_rel_withinOther    <=   0 =>  0,
crim_rel_withinOther    <=   1 =>  1,
crim_rel_withinOther    <=   2 =>  2,
3
);


pk_rel_prop_owned_count   := map(
rel_count                =   0 => -9,
rel_prop_owned_count    <=   0 => -3,
rel_prop_owned_count    <=   2 => -2,
rel_prop_owned_count    <=   6 => -1,
rel_prop_owned_count    <=  10 =>  0,
1
);


pk_rel_prop_own_prch_tot2          := map(
rel_count                         =      0 => -9,
rel_prop_owned_purchase_total    <=      0 =>  0,
rel_prop_owned_purchase_total    <= 100000 => -1,
1
);


pk_rel_prop_owned_prch_cnt         := map(
rel_count                         =   0 => -9,
rel_prop_owned_purchase_count    <=   0 =>  0,
rel_prop_owned_purchase_count    <=   8 =>  1,
2
);


pk_rel_prop_own_assess_tot2        := map(
rel_count                         =      0 => -9,
rel_prop_owned_assessed_total    <=      0 =>  0,
rel_prop_owned_assessed_total    <=  80000 => -1,
rel_prop_owned_assessed_total    <= 240000 =>  1,
2
);


pk_rel_prop_owned_as_cnt           := map(
rel_count                         =   0 => -9,
rel_prop_owned_assessed_count    <=   0 => -1,
rel_prop_owned_assessed_count    <=   8 =>  0,
1
);


pk_rel_prop_sold_count   := map(
rel_count               =   0 => -9,
rel_prop_sold_count    <=   0 =>  0,
rel_prop_sold_count    <=   2 =>  1,
2
);


pk_rel_prop_sold_prch_tot2        := map(
rel_count                        =      0 => -9,
rel_prop_sold_purchase_total    <=      0 =>  0,
rel_prop_sold_purchase_total    <=  60000 => -1,
rel_prop_sold_purchase_total    <= 260000 =>  1,
2
);


pk_rel_prop_sold_as_tot2          := map(
rel_count                        =     0 => -9,
rel_prop_sold_assessed_total    <=     0 =>  0,
rel_prop_sold_assessed_total    <= 60000 => -1,
1
);


pk_rel_within25miles_count   := map(
rel_count                   =   0 => -9,
rel_within25miles_count    <=   0 => -3,
rel_within25miles_count    <=   1 => -2,
rel_within25miles_count    <=   2 => -1,
rel_within25miles_count    <=   4 =>  0,
rel_within25miles_count    <=   6 =>  1,
rel_within25miles_count    <=   8 =>  2,
rel_within25miles_count    <=  13 =>  3,
rel_within25miles_count    <=  17 =>  4,
5
);


pk_rel_incomeunder25_count   := map(
rel_count                   =   0 => -9,
rel_incomeunder25_count    <=   0 =>  0,
rel_incomeunder25_count    <=   1 =>  1,
rel_incomeunder25_count    <=   2 =>  2,
rel_incomeunder25_count    <=   3 =>  3,
rel_incomeunder25_count    <=   5 =>  4,
rel_incomeunder25_count    <=   9 =>  5,
rel_incomeunder25_count    <=  17 =>  6,
7
);


pk_rel_incomeunder50_count   := map(
rel_count                   =   0 => -9,
rel_incomeunder50_count    <=   0 =>  0,
rel_incomeunder50_count    <=   1 =>  1,
rel_incomeunder50_count    <=   2 =>  2,
rel_incomeunder50_count    <=   3 =>  3,
rel_incomeunder50_count    <=   4 =>  4,
rel_incomeunder50_count    <=  10 =>  5,
rel_incomeunder50_count    <=  15 =>  6,
7
);


pk_rel_incomeunder75_count   := map(
rel_count                   =   0 => -9,
rel_incomeunder75_count    <=   0 => -3,
rel_incomeunder75_count    <=   1 => -2,
rel_incomeunder75_count    <=   3 => -1,
rel_incomeunder75_count    <=   6 =>  0,
rel_incomeunder75_count    <=  12 =>  1,
2
);


pk_rel_incomeunder100_count   := map(
rel_count                    =   0 => -9,
rel_incomeunder100_count    <=   0 => -3,
rel_incomeunder100_count    <=   1 => -2,
rel_incomeunder100_count    <=   2 => -1,
rel_incomeunder100_count    <=   3 =>  0,
rel_incomeunder100_count    <=   6 =>  1,
rel_incomeunder100_count    <=   8 =>  2,
3
);


pk_rel_incomeover100_count   := map(
rel_count                   =   0 => -9,
rel_incomeover100_count    <=   0 =>  0,
rel_incomeover100_count    <=   1 =>  1,
rel_incomeover100_count    <=   2 =>  2,
3
);


pk_rel_homeunder100_count   := map(
rel_count                  =   0 => -9,
rel_homeunder100_count    <=   0 =>  0,
rel_homeunder100_count    <=   1 =>  1,
rel_homeunder100_count    <=   2 =>  2,
rel_homeunder100_count    <=   3 =>  3,
rel_homeunder100_count    <=   4 =>  4,
rel_homeunder100_count    <=   9 =>  5,
rel_homeunder100_count    <=  15 =>  6,
7
);


pk_rel_homeunder200_count   := map(
rel_count                  =   0 => -9,
rel_homeunder200_count    <=   0 =>  0,
rel_homeunder200_count    <=   1 =>  1,
rel_homeunder200_count    <=   2 =>  2,
3
);


pk_rel_homeunder300_count   := map(
rel_count                  =   0 => -9,
rel_homeunder300_count    <=   0 =>  0,
rel_homeunder300_count    <=   1 =>  1,
rel_homeunder300_count    <=   2 =>  2,
3
);


pk_rel_homeunder500_count   := map(
rel_count                  =   0 => -9,
rel_homeunder500_count    <=   0 =>  0,
rel_homeunder500_count    <=   1 =>  1,
rel_homeunder500_count    <=   2 =>  2,
3
);


pk_rel_homeover500_count   := map(
rel_count                 =   0 => -9,
rel_homeover500_count    <=   0 =>  0,
rel_homeover500_count    <=   1 =>  1,
2
);


pk_rel_educationunder12_count   := map(
rel_count                      =   0 => -9,
rel_educationunder12_count    <=   0 =>  0,
rel_educationunder12_count    <=   1 =>  1,
rel_educationunder12_count    <=   2 =>  2,
rel_educationunder12_count    <=   8 =>  1,
rel_educationunder12_count    <=  11 =>  2,
3
);


pk_rel_educationover12_count   := map(
rel_count                     =   0 => -9,
rel_educationover12_count    <=   0 => -2,
rel_educationover12_count    <=   1 => -1,
rel_educationover12_count    <=   7 =>  0,
rel_educationover12_count    <=  10 =>  1,
rel_educationover12_count    <=  14 =>  2,
3
);


pk_rel_ageunder30_count   := map(
rel_count                =   0 => -9,
rel_ageunder30_count    <=   0 =>  0,
rel_ageunder30_count    <=  11 =>  1,
2
);


pk_rel_ageunder40_count   := map(
rel_count                =   0 => -9,
rel_ageunder40_count    <=   4 =>  0,
rel_ageunder40_count    <=   5 =>  1,
rel_ageunder40_count    <=  10 =>  2,
3
);


pk_rel_ageunder50_count   := map(
rel_count                =   0 => -9,
rel_ageunder50_count    <=   0 =>  0,
rel_ageunder50_count    <=   8 =>  1,
2
);


pk_rel_ageunder70_count   := map(
rel_count                =   0 => -9,
rel_ageunder70_count    <=   0 =>  0,
1
);


pk_rel_ageover70_count   := map(
rel_count               =   0 => -9,
rel_ageover70_count    <=   0 =>  0,
1
);


pk_rel_vehicle_owned_count   := map(
rel_count                   =   0 => -9,
rel_vehicle_owned_count    <=   0 =>  0,
rel_vehicle_owned_count    <=   4 =>  1,
rel_vehicle_owned_count    <=  12 =>  2,
3
);


pk_rel_count_addr   := map(
rel_count          =   0 => -9,
rel_count_addr    <=   0 =>  0,
1
);


        /*  Derog  */


pk_acc_damage_amt_total := map(
			acc_damage_amt_total  =      0 =>                                          0 ,
            acc_damage_amt_total <=   1000 =>   100 * roundup( acc_damage_amt_total /   100 ),
            acc_damage_amt_total <=  10000 =>  1000 * roundup( acc_damage_amt_total /  1000 ),
            acc_damage_amt_total <= 100000 => 10000 * roundup( acc_damage_amt_total / 10000 ),
99999 
);

pk_acc_damage_amt_last := map(
			acc_damage_amt_last  =      0 =>                                         0 ,
            acc_damage_amt_last <=   1000 =>   100 * roundup( acc_damage_amt_last /   100 ),
            acc_damage_amt_last <=  10000 =>  1000 * roundup( acc_damage_amt_last /  1000 ),
            acc_damage_amt_last <= 100000 => 10000 * roundup( acc_damage_amt_last / 10000 ),
99999 
);


pk_attr_arrests24   := if( attr_arrests24 <= 0, 0, 1);


pk_acc_damage_amt_total2  := map(
pk_acc_damage_amt_total    <=   0 => -1,
pk_acc_damage_amt_total    <= 300 =>  0,
pk_acc_damage_amt_total    <= 800 =>  1,
2
);


pk_acc_damage_amt_last2   := map(
pk_acc_damage_amt_last    <=   0 => -1,
pk_acc_damage_amt_last    <= 300 =>  0,
1
);


        /*  Utility   */


            pk_yr_util_adl_D_firstseen        := roundup(  years_util_adl_D_firstseen      );
            pk_yr_util_adl_E_firstseen        := roundup(  years_util_adl_E_firstseen      );
            pk_yr_util_adl_F_firstseen        := roundup(  years_util_adl_F_firstseen      );
            pk_yr_util_adl_G_firstseen        := roundup(  years_util_adl_G_firstseen      );
            pk_yr_util_adl_I_firstseen        := roundup(  years_util_adl_I_firstseen      );
            pk_yr_util_adl_U_firstseen        := roundup(  years_util_adl_U_firstseen      );
            pk_max_years_util_adl_firstseen   := roundup(  max_years_util_adl_firstseen    );
            pk_yr_util_add1_E_firstseen       := roundup(  years_util_add1_E_firstseen     );
            pk_yr_util_add1_F_firstseen       := roundup(  years_util_add1_F_firstseen     );
            pk_yr_util_add1_I_firstseen       := roundup(  years_util_add1_I_firstseen     );
            pk_yr_util_add1_U_firstseen       := roundup(  years_util_add1_U_firstseen     );
            pk_yr_util_add1_V_firstseen       := roundup(  years_util_add1_V_firstseen     );
            pk_yr_util_add1_Z_firstseen       := roundup(  years_util_add1_Z_firstseen     );
            pk_max_years_util_add1_firstseen  := roundup(  max_years_util_add1_firstseen   );
            pk_yr_util_add2_D_firstseen       := roundup(  years_util_add2_D_firstseen     );
            pk_yr_util_add2_E_firstseen       := roundup(  years_util_add2_E_firstseen     );
            pk_yr_util_add2_G_firstseen       := roundup(  years_util_add2_G_firstseen     );
            pk_yr_util_add2_U_firstseen       := roundup(  years_util_add2_U_firstseen     );
            pk_yr_util_add2_Z_firstseen       := roundup(  years_util_add2_Z_firstseen     );


pk_util_adl_source_count   := map(
util_adl_source_count    <=   0 =>  0,
util_adl_source_count    <=   1 =>  1,
util_adl_source_count    <=   2 =>  2,
3
);


pk_util_adl_sourced   := map(
(integer)util_adl_sourced    <=   0 =>  0,
1
);


pk_util_adl_count   := map(
util_adl_count    <=   0 =>  0,
util_adl_count    <=   1 =>  1,
util_adl_count    <=   2 =>  2,
util_adl_count    <=   3 =>  3,
util_adl_count    <=   4 =>  4,
5
);


pk_util_adl_nap   := map(
util_adl_nap    <=   0 => -1,
util_adl_nap    <=   9 =>  0,
1
);


pk_util_add1_source_count   := map(
util_add1_source_count    <=   0 =>  0,
util_add1_source_count    <=   1 =>  1,
util_add1_source_count    <=   2 =>  2,
util_add1_source_count    <=   3 =>  3,
util_add1_source_count    <=   4 =>  4,
5
);


pk_util_add1_nap   := map(
util_add1_nap    <=   0 => -1,
util_add1_nap    <=   9 =>  0,
1
);


pk_util_add2_source_count   := map(
util_add2_source_count    <=   1 =>  0,
util_add2_source_count    <=   2 =>  1,
util_add2_source_count    <=   3 =>  2,
3
);


pk_util_add2_nap   := map(
util_add2_nap    <=   0 => -1,
util_add2_nap    <=   9 =>  0,
1
);


pk_rc_utiliaddr_phonecount  := map(
rc_utiliaddr_phonecount    <=   0 =>  0,
1
);


pk_utility_sourced   := map(
(integer)utility_sourced    <=   0 =>  0,
1
);


pk_yr_util_adl_D_firstseen2        := map(
pk_yr_util_adl_D_firstseen       <=  NULL  => -1,
pk_yr_util_adl_D_firstseen       <=  3  =>  0,
1
);


pk_yr_util_adl_E_firstseen2        := map(
pk_yr_util_adl_E_firstseen       <=   NULL => -1,
pk_yr_util_adl_E_firstseen       <=   2 =>  0,
pk_yr_util_adl_E_firstseen       <=   3 =>  1,
pk_yr_util_adl_E_firstseen       <=   4 =>  2,
pk_yr_util_adl_E_firstseen       <=   5 =>  3,
pk_yr_util_adl_E_firstseen       <=   6 =>  4,
pk_yr_util_adl_E_firstseen       <=   7 =>  5,
pk_yr_util_adl_E_firstseen       <=   8 =>  6,
7
);


pk_yr_util_adl_F_firstseen2        := map(
pk_yr_util_adl_F_firstseen       <=   NULL => -1,
pk_yr_util_adl_F_firstseen       <=   1 =>  0,
pk_yr_util_adl_F_firstseen       <=   2 =>  1,
2
);


pk_yr_util_adl_G_firstseen2        := map(
pk_yr_util_adl_G_firstseen       <=   NULL => -1,
pk_yr_util_adl_G_firstseen       <=   2 =>  0,
pk_yr_util_adl_G_firstseen       <=   9 =>  1,
2
);


pk_yr_util_adl_I_firstseen2        := map(
pk_yr_util_adl_I_firstseen       <=   NULL => -1,
pk_yr_util_adl_I_firstseen       <=   1 =>  0,
pk_yr_util_adl_I_firstseen       <=   3 =>  1,
2
);


pk_yr_util_adl_U_firstseen2        := map(
pk_yr_util_adl_U_firstseen       <=   NULL => -1,
pk_yr_util_adl_U_firstseen       <=   1 =>  0,
pk_yr_util_adl_U_firstseen       <=   2 =>  1,
pk_yr_util_adl_U_firstseen       <=   3 =>  2,
3
);


pk_mx_yr_util_adl_firstseen2         := map(
pk_max_years_util_adl_firstseen    <=   NULL => -1,
pk_max_years_util_adl_firstseen    <=   1 =>  0,
pk_max_years_util_adl_firstseen    <=   2 =>  1,
pk_max_years_util_adl_firstseen    <=   3 =>  2,
pk_max_years_util_adl_firstseen    <=   4 =>  3,
pk_max_years_util_adl_firstseen    <=   8 =>  4,
5
);


pk_yr_util_add1_E_firstseen2        := map(
pk_yr_util_add1_E_firstseen       <=   NULL => -1,
pk_yr_util_add1_E_firstseen       <=   7 =>  0,
1
);


pk_yr_util_add1_F_firstseen2        := map(
pk_yr_util_add1_F_firstseen       <=   NULL => -1,
pk_yr_util_add1_F_firstseen       <=   1 =>  0,
1
);


pk_yr_util_add1_I_firstseen2        := map(
pk_yr_util_add1_I_firstseen       <=   NULL => -1,
pk_yr_util_add1_I_firstseen       <=   1 =>  0,
pk_yr_util_add1_I_firstseen       <=   3 =>  1,
pk_yr_util_add1_I_firstseen       <=   8 =>  2,
3
);


pk_yr_util_add1_U_firstseen2        := map(
pk_yr_util_add1_U_firstseen       <=   NULL => -1,
pk_yr_util_add1_U_firstseen       <=   3 =>  0,
1
);


pk_yr_util_add1_V_firstseen2        := map(
pk_yr_util_add1_V_firstseen       <=   NULL => -1,
1
);


pk_yr_util_add1_Z_firstseen2        := map(
pk_yr_util_add1_Z_firstseen       <=   NULL => -1,
pk_yr_util_add1_Z_firstseen       <=   4 =>  0,
1
);


pk_mx_yr_util_add1_firstseen2         := map(
pk_max_years_util_add1_firstseen    <=   NULL => -1,
pk_max_years_util_add1_firstseen    <=   4 =>  0,
pk_max_years_util_add1_firstseen    <=   8 =>  1,
2
);


pk_yr_util_add2_D_firstseen2        := map(
pk_yr_util_add2_D_firstseen       <=   NULL => -1,
1
);


pk_yr_util_add2_E_firstseen2        := map(
pk_yr_util_add2_E_firstseen       <=   NULL => -1,
pk_yr_util_add2_E_firstseen       <=   1 =>  0,
pk_yr_util_add2_E_firstseen       <=   5 =>  1,
pk_yr_util_add2_E_firstseen       <=   9 =>  2,
3
);


pk_yr_util_add2_G_firstseen2        := map(
pk_yr_util_add2_G_firstseen       <=   NULL => -1,
1
);


pk_yr_util_add2_U_firstseen2        := map(
pk_yr_util_add2_U_firstseen       <=   NULL => -1,
pk_yr_util_add2_U_firstseen       <=   1 =>  0,
1
);


pk_yr_util_add2_Z_firstseen2        := map(
pk_yr_util_add2_Z_firstseen       <=   NULL => -1,
pk_yr_util_add2_Z_firstseen       <=   1 =>  0,
1
);


         /* Misc Non-FCRA  */


            pk_add2_avm_med := 20000 * roundup( add2_avm_med / 20000 ) ;


pk_nap_type   := map(
nap_type     =  'P' =>  3,
nap_type     =  'A' =>  2,
nap_type     =  'U' =>  1,
0
);


pk_EN_count   := map(
EN_count    <=   0 => -1,
EN_count    <=   6 =>  0,
EN_count    <=  15 =>  1,
EN_count    <=  25 =>  2,
3
);


pk_dl_avail   := map(
(integer)dl_avail    <=   0 =>  0,
1
);


pk_DL_count   := map(
DL_count    <=   0 => -1,
DL_count    <=   1 =>  0,
DL_count    <=   2 =>  1,
DL_count    <=   3 =>  2,
3
);


pk_yr_adl_EN_first_seen2  := map(
pk_yr_adl_EN_first_seen    <=   NULL => -1,
pk_yr_adl_EN_first_seen    <=  14 =>  14 ,
pk_yr_adl_EN_first_seen    >=  22 =>  22 ,
pk_yr_adl_EN_first_seen  
);


pk_yr_adl_DL_first_seen2     := map(
pk_yr_adl_DL_first_seen    <=   NULL => -9,
pk_yr_adl_DL_first_seen    <=   2 => -1,
pk_yr_adl_DL_first_seen    <=   6 =>  0,
1
);


pk_add1_fc_index_flag := map(
            add1_fc_index > 0 => 1,
0
);


pk_current_count   := map(
current_count    <=   0 =>  0,
current_count    <=   3 =>  1,
current_count    <=   9 =>  2,
3
);


pk_historical_count   := map(
historical_count    <=   0 =>  0,
historical_count    <=   6 =>  1,
historical_count    <=  14 =>  2,
3
);


pk_add2_avm_med2     := map(
pk_add2_avm_med    <=      0 => -1,
pk_add2_avm_med    <=  20000 =>  0,
pk_add2_avm_med    <=  40000 =>  1,
pk_add2_avm_med    <=  60000 =>  2,
pk_add2_avm_med    <=  80000 =>  3,
pk_add2_avm_med    <= 100000 =>  4,
pk_add2_avm_med    <= 120000 =>  5,
pk_add2_avm_med    <= 160000 =>  6,
pk_add2_avm_med    <= 260000 =>  7,
pk_add2_avm_med    <= 300000 =>  8,
9
);





       if(  add1_isbestmatch ) then /* Address 1 is Best Match     */


            if(       pk_segment2 = 1 ) then /* 1 EDA              */



pk_nas_summary_mm := map(
pk_nas_summary = 0 => 0.328125,
pk_nas_summary = 1 => 0.3219895288,
pk_nas_summary = 2 => 0.3583287114,
0.3570136549
);


pk_nap_summary_mm := map(
pk_nap_summary = -1 => 0.2056737589,
pk_nap_summary = 0 => 0.2422874342,
pk_nap_summary = 1 => 0.3110028,
pk_nap_summary = 2 => 0.4058909414,
0.3570136549
);


pk_rc_dirsaddr_lastscore_mm := map(
pk_rc_dirsaddr_lastscore = -1 => 0.2654656696,
pk_rc_dirsaddr_lastscore = 0 => 0.2772277228,
pk_rc_dirsaddr_lastscore = 1 => 0.3275434243,
pk_rc_dirsaddr_lastscore = 2 => 0.3759539488,
0.3570136549
);


pk_combo_hphonescore_mm := map(
pk_combo_hphonescore = 0 => 0.2336065574,
pk_combo_hphonescore = 1 => 0.2857142857,
pk_combo_hphonescore = 2 => 0.3596354261,
0.3570136549
);


pk_combo_dobscore_mm := map(
pk_combo_dobscore = -1 => 0.3505096263,
pk_combo_dobscore = 0 => 0,
pk_combo_dobscore = 1 => 0.3713318284,
pk_combo_dobscore = 2 => 0.3570086139,
0.3570136549
);


pk_gong_did_first_ct_mm := map(
pk_gong_did_first_ct = 0 => 0.346587856,
pk_gong_did_first_ct = 1 => 0.3595878295,
0.3570136549
);


pk_rc_phonelnamecount_mm := map(
pk_rc_phonelnamecount = 0 => 0.2933857236,
pk_rc_phonelnamecount = 1 => 0.3606569672,
0.3570136549
);


pk_combo_addrcount_mm := map(
pk_combo_addrcount = 0 => 0.2719962157,
pk_combo_addrcount = 1 => 0.2844581749,
pk_combo_addrcount = 2 => 0.3492245836,
pk_combo_addrcount = 3 => 0.3854800317,
pk_combo_addrcount = 4 => 0.4011161018,
0.3570136549
);


pk_rc_phoneaddrcount_mm := map(
pk_rc_phoneaddrcount = 0 => 0.2435012185,
pk_rc_phoneaddrcount = 1 => 0.381032186,
0.3570136549
);


pk_combo_hphonecount_mm := map(
pk_combo_hphonecount = 0 => 0.2264752791,
pk_combo_hphonecount = 1 => 0.3599825885,
0.3570136549
);


pk_ver_phncount_mm := map(
pk_ver_phncount = 0 => 0.2027972028,
pk_ver_phncount = 1 => 0.2437163375,
pk_ver_phncount = 2 => 0.3078145169,
pk_ver_phncount = 3 => 0.4058909414,
0.3570136549
);


pk_gong_did_phone_ct_mm := map(
pk_gong_did_phone_ct = -1 => 0.3397081027,
pk_gong_did_phone_ct = 0 => 0.4085487078,
pk_gong_did_phone_ct = 1 => 0.3506269592,
pk_gong_did_phone_ct = 2 => 0.3058015943,
pk_gong_did_phone_ct = 3 => 0.244913928,
0.3570136549
);


pk_combo_ssncount_mm := map(
pk_combo_ssncount = -1 => 0.328125,
pk_combo_ssncount = 0 => 0.3735725938,
pk_combo_ssncount = 1 => 0.3574625196,
0.3570136549
);


pk_eq_count_mm := map(
pk_eq_count = 0 => 0.3286713287,
pk_eq_count = 1 => 0.3597430407,
pk_eq_count = 2 => 0.3759600614,
pk_eq_count = 3 => 0.3677660236,
pk_eq_count = 4 => 0.371609925,
pk_eq_count = 5 => 0.3592155612,
pk_eq_count = 6 => 0.3432412248,
0.3570136549
);


pk_em_count_mm := map(
pk_em_count = 0 => 0.3610062893,
pk_em_count = 1 => 0.3626237624,
pk_em_count = 2 => 0.3426720892,
0.3570136549
);


pk_em_only_count_mm := map(
pk_em_only_count = 0 => 0.3558735385,
pk_em_only_count = 1 => 0.3648648649,
pk_em_only_count = 2 => 0.35626703,
pk_em_only_count = 3 => 0.3839285714,
0.3570136549
);


pk_pos_secondary_sources_mm := map(
pk_pos_secondary_sources = 0 => 0.3559168925,
pk_pos_secondary_sources = 1 => 0.404494382,
pk_pos_secondary_sources = 2 => 0.4210526316,
0.3570136549
);


pk_voter_flag_mm := map(
pk_voter_flag = -1 => 0.3370892019,
pk_voter_flag = 0 => 0.3697594502,
pk_voter_flag = 1 => 0.3518503457,
0.3570136549
);


pk_fname_eda_sourced_type_lvl_mm := map(
pk_fname_eda_sourced_type_lvl = 0 => 0.3075226376,
pk_fname_eda_sourced_type_lvl = 1 => 0.2339449541,
pk_fname_eda_sourced_type_lvl = 2 => 0.2775905644,
pk_fname_eda_sourced_type_lvl = 3 => 0.396875559,
0.3570136549
);


pk_lname_eda_sourced_type_lvl_mm := map(
pk_lname_eda_sourced_type_lvl = 0 => 0.3048869438,
pk_lname_eda_sourced_type_lvl = 1 => 0.1923076923,
pk_lname_eda_sourced_type_lvl = 2 => 0.2564469914,
pk_lname_eda_sourced_type_lvl = 3 => 0.3763482613,
0.3570136549
);


pk_add1_address_score_mm := map(
pk_add1_address_score = 0 => 0.3422904671,
pk_add1_address_score = 1 => 0.3578777411,
0.3570136549
);


pk_add2_pos_sources_mm := map(
pk_add2_pos_sources = 0 => 0.3516059471,
pk_add2_pos_sources = 1 => 0.3594748048,
pk_add2_pos_sources = 2 => 0.3440134907,
pk_add2_pos_sources = 3 => 0.3798008535,
pk_add2_pos_sources = 4 => 0.3517835178,
0.3570136549
);


pk_ssnchar_invalid_or_recent_mm := map(
pk_ssnchar_invalid_or_recent = 0 => 0.3569192458,
pk_ssnchar_invalid_or_recent = 1 => 0.3882352941,
0.3570136549
);


pk_infutor_risk_lvl_mm := map(
pk_infutor_risk_lvl = 0 => 0.3766864063,
pk_infutor_risk_lvl = 1 => 0.2821246819,
pk_infutor_risk_lvl = 2 => 0.2773919753,
0.3570136549
);


pk_yr_adl_eq_first_seen2_mm := map(
pk_yr_adl_eq_first_seen2 = -1 => 0.3328313253,
pk_yr_adl_eq_first_seen2 = 0 => 0.397260274,
pk_yr_adl_eq_first_seen2 = 1 => 0.3793103448,
pk_yr_adl_eq_first_seen2 = 2 => 0.3406593407,
pk_yr_adl_eq_first_seen2 = 3 => 0.3389544688,
pk_yr_adl_eq_first_seen2 = 4 => 0.3115942029,
pk_yr_adl_eq_first_seen2 = 5 => 0.3134920635,
pk_yr_adl_eq_first_seen2 = 6 => 0.3284313725,
pk_yr_adl_eq_first_seen2 = 7 => 0.3139272271,
pk_yr_adl_eq_first_seen2 = 8 => 0.3301886792,
pk_yr_adl_eq_first_seen2 = 9 => 0.382477934,
pk_yr_adl_eq_first_seen2 = 10 => 0.3805436338,
0.3570136549
);


pk_yr_adl_em_first_seen2_mm := map(
pk_yr_adl_em_first_seen2 = -1 => 0.3611493677,
pk_yr_adl_em_first_seen2 = 0 => 0.3269230769,
pk_yr_adl_em_first_seen2 = 1 => 0.3326790972,
pk_yr_adl_em_first_seen2 = 2 => 0.3304130163,
pk_yr_adl_em_first_seen2 = 3 => 0.3525040388,
pk_yr_adl_em_first_seen2 = 4 => 0.3846153846,
0.3570136549
);


pk_yr_adl_vo_first_seen2_mm := map(
pk_yr_adl_vo_first_seen2 = -1 => 0.362963388,
pk_yr_adl_vo_first_seen2 = 0 => 0.2852564103,
pk_yr_adl_vo_first_seen2 = 1 => 0.3281690141,
pk_yr_adl_vo_first_seen2 = 2 => 0.3539253539,
pk_yr_adl_vo_first_seen2 = 3 => 0.3547910822,
0.3570136549
);


pk_yr_adl_em_only_first_seen2_mm := map(
pk_yr_adl_em_only_first_seen2 = -1 => 0.3558577406,
pk_yr_adl_em_only_first_seen2 = 0 => 0.552238806,
pk_yr_adl_em_only_first_seen2 = 1 => 0.3794749403,
pk_yr_adl_em_only_first_seen2 = 2 => 0.36643026,
pk_yr_adl_em_only_first_seen2 = 3 => 0.3524337646,
pk_yr_adl_em_only_first_seen2 = 4 => 0.4714285714,
0.3570136549
);


pk_yr_lname_change_date2_mm := map(
pk_yr_lname_change_date2 = -1 => 0.3586667167,
pk_yr_lname_change_date2 = 0 => 0.3188976378,
pk_yr_lname_change_date2 = 1 => 0.3148148148,
pk_yr_lname_change_date2 = 2 => 0.3565217391,
0.3570136549
);


pk_yr_gong_did_first_seen2_mm := map(
pk_yr_gong_did_first_seen2 = -1 => 0.346587856,
pk_yr_gong_did_first_seen2 = 0 => 0.3859397418,
pk_yr_gong_did_first_seen2 = 1 => 0.3646659117,
pk_yr_gong_did_first_seen2 = 2 => 0.3481624758,
pk_yr_gong_did_first_seen2 = 3 => 0.3061440678,
pk_yr_gong_did_first_seen2 = 4 => 0.3616563451,
0.3570136549
);


pk_yr_credit_first_seen2_mm := map(
pk_yr_credit_first_seen2 = -1 => 0.3328313253,
pk_yr_credit_first_seen2 = 0 => 0.397260274,
pk_yr_credit_first_seen2 = 1 => 0.3793103448,
pk_yr_credit_first_seen2 = 2 => 0.3406593407,
pk_yr_credit_first_seen2 = 3 => 0.3389544688,
pk_yr_credit_first_seen2 = 4 => 0.3115942029,
pk_yr_credit_first_seen2 = 5 => 0.3134920635,
pk_yr_credit_first_seen2 = 6 => 0.3284313725,
pk_yr_credit_first_seen2 = 7 => 0.3139272271,
pk_yr_credit_first_seen2 = 8 => 0.3301886792,
pk_yr_credit_first_seen2 = 9 => 0.382477934,
pk_yr_credit_first_seen2 = 10 => 0.379483557,
pk_yr_credit_first_seen2 = 11 => 0.4055555556,
0.3570136549
);


pk_yr_header_first_seen2_mm := map(
pk_yr_header_first_seen2 = -1 => 0.3617777778,
pk_yr_header_first_seen2 = 0 => 0.4013605442,
pk_yr_header_first_seen2 = 1 => 0.3201438849,
pk_yr_header_first_seen2 = 2 => 0.3018867925,
pk_yr_header_first_seen2 = 3 => 0.3044871795,
pk_yr_header_first_seen2 = 4 => 0.3136520737,
pk_yr_header_first_seen2 = 5 => 0.3533634672,
pk_yr_header_first_seen2 = 6 => 0.361474625,
pk_yr_header_first_seen2 = 7 => 0.393922341,
0.3570136549
);


pk_yr_infutor_first_seen2_mm := map(
pk_yr_infutor_first_seen2 = -1 => 0.3766864063,
pk_yr_infutor_first_seen2 = 0 => 0.2234042553,
pk_yr_infutor_first_seen2 = 1 => 0.2620904836,
pk_yr_infutor_first_seen2 = 2 => 0.2655290102,
pk_yr_infutor_first_seen2 = 3 => 0.3002915452,
pk_yr_infutor_first_seen2 = 4 => 0.2846580407,
0.3570136549
);


pk_EM_Only_ver_lvl_mm := map(
pk_EM_Only_ver_lvl = -1 => 0.383248731,
pk_EM_Only_ver_lvl = 0 => 0.3561989732,
pk_EM_Only_ver_lvl = 1 => 0.3369272237,
pk_EM_Only_ver_lvl = 2 => 0.3916083916,
pk_EM_Only_ver_lvl = 3 => 0.358974359,
0.3570136549
);


pk_add2_EM_ver_lvl_mm := map(
pk_add2_EM_ver_lvl = -1 => 0.3975903614,
pk_add2_EM_ver_lvl = 0 => 0.3558899083,
pk_add2_EM_ver_lvl = 1 => 0.3382352941,
pk_add2_EM_ver_lvl = 2 => 0.4339207048,
0.3570136549
);


pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.3419354839,
pk_yrmo_adl_f_sn_mx_fcra2 = 0 => 0.75,
pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0.3125,
pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.4027777778,
pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0.3506493506,
pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.3673469388,
pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.3,
pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.3141210375,
pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.345323741,
pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.3138888889,
pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.2909738717,
pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.3105022831,
pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.3133270321,
pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.3163434903,
pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.3307828134,
pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.3794056669,
pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.370178282,
pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.3989090909,
0.3570136549
);


pk_util_adl_source_count_mm := map(
pk_util_adl_source_count = 0 => 0.4042417477,
pk_util_adl_source_count = 1 => 0.3782537701,
pk_util_adl_source_count = 2 => 0.3283419123,
pk_util_adl_source_count = 3 => 0.2916503332,
0.3570136549
);


pk_util_adl_sourced_mm := map(
pk_util_adl_sourced = 0 => 0.4042417477,
pk_util_adl_sourced = 1 => 0.3435048349,
0.3570136549
);


pk_util_adl_count_mm := map(
pk_util_adl_count = 0 => 0.4042417477,
pk_util_adl_count = 1 => 0.3880328197,
pk_util_adl_count = 2 => 0.3710598163,
pk_util_adl_count = 3 => 0.3468729852,
pk_util_adl_count = 4 => 0.3322076826,
pk_util_adl_count = 5 => 0.3007943988,
0.3570136549
);


pk_util_adl_nap_mm := map(
pk_util_adl_nap = -1 => 0.403959171,
pk_util_adl_nap = 0 => 0.3227171088,
pk_util_adl_nap = 1 => 0.4079505982,
0.3570136549
);


pk_util_add1_source_count_mm := map(
pk_util_add1_source_count = 0 => 0.4140302613,
pk_util_add1_source_count = 1 => 0.3925277183,
pk_util_add1_source_count = 2 => 0.3440820361,
pk_util_add1_source_count = 3 => 0.2933394161,
pk_util_add1_source_count = 4 => 0.2883165829,
pk_util_add1_source_count = 5 => 0.2458677686,
0.3570136549
);


pk_util_add1_nap_mm := map(
pk_util_add1_nap = -1 => 0.3809766888,
pk_util_add1_nap = 0 => 0.3328323213,
pk_util_add1_nap = 1 => 0.4029903254,
0.3570136549
);


pk_util_add2_source_count_mm := map(
pk_util_add2_source_count = 0 => 0.3679453263,
pk_util_add2_source_count = 1 => 0.3496301642,
pk_util_add2_source_count = 2 => 0.3229939312,
pk_util_add2_source_count = 3 => 0.3203631647,
0.3570136549
);


pk_util_add2_nap_mm := map(
pk_util_add2_nap = -1 => 0.3639531562,
pk_util_add2_nap = 0 => 0.3465144721,
pk_util_add2_nap = 1 => 0.3359908884,
0.3570136549
);


pk_rc_utiliaddr_phonecount_mm := map(
pk_rc_utiliaddr_phonecount = 0 => 0.345015646,
pk_rc_utiliaddr_phonecount = 1 => 0.4030901288,
0.3570136549
);


pk_utility_sourced_mm := map(
pk_utility_sourced = 0 => 0.3614946243,
pk_utility_sourced = 1 => 0.3501879363,
0.3570136549
);


pk_yr_util_adl_D_firstseen2_mm := map(
pk_yr_util_adl_D_firstseen2 = -1 => 0.3650214592,
pk_yr_util_adl_D_firstseen2 = 0 => 0.3487394958,
pk_yr_util_adl_D_firstseen2 = 1 => 0.3173716985,
0.3570136549
);


pk_yr_util_adl_E_firstseen2_mm := map(
pk_yr_util_adl_E_firstseen2 = -1 => 0.3616217076,
pk_yr_util_adl_E_firstseen2 = 0 => 0.3609958506,
pk_yr_util_adl_E_firstseen2 = 1 => 0.3651685393,
pk_yr_util_adl_E_firstseen2 = 2 => 0.3639846743,
pk_yr_util_adl_E_firstseen2 = 3 => 0.3296296296,
pk_yr_util_adl_E_firstseen2 = 4 => 0.3333333333,
pk_yr_util_adl_E_firstseen2 = 5 => 0.3088235294,
pk_yr_util_adl_E_firstseen2 = 6 => 0.3106180666,
pk_yr_util_adl_E_firstseen2 = 7 => 0.2803867403,
0.3570136549
);


pk_yr_util_adl_F_firstseen2_mm := map(
pk_yr_util_adl_F_firstseen2 = -1 => 0.3739022484,
pk_yr_util_adl_F_firstseen2 = 0 => 0.3,
pk_yr_util_adl_F_firstseen2 = 1 => 0.3322091062,
pk_yr_util_adl_F_firstseen2 = 2 => 0.2964889467,
0.3570136549
);


pk_yr_util_adl_G_firstseen2_mm := map(
pk_yr_util_adl_G_firstseen2 = -1 => 0.3570042117,
pk_yr_util_adl_G_firstseen2 = 0 => 0.3771929825,
pk_yr_util_adl_G_firstseen2 = 1 => 0.3455098935,
pk_yr_util_adl_G_firstseen2 = 2 => 0.4033613445,
0.3570136549
);


pk_yr_util_adl_I_firstseen2_mm := map(
pk_yr_util_adl_I_firstseen2 = -1 => 0.3694321385,
pk_yr_util_adl_I_firstseen2 = 0 => 0.3165735568,
pk_yr_util_adl_I_firstseen2 = 1 => 0.2774566474,
pk_yr_util_adl_I_firstseen2 = 2 => 0.2430167598,
0.3570136549
);


pk_yr_util_adl_U_firstseen2_mm := map(
pk_yr_util_adl_U_firstseen2 = -1 => 0.3597065974,
pk_yr_util_adl_U_firstseen2 = 0 => 0.359939759,
pk_yr_util_adl_U_firstseen2 = 1 => 0.3550640279,
pk_yr_util_adl_U_firstseen2 = 2 => 0.3562005277,
pk_yr_util_adl_U_firstseen2 = 3 => 0.3247778875,
0.3570136549
);


pk_mx_yr_util_adl_firstseen2_mm := map(
pk_mx_yr_util_adl_firstseen2 = -1 => 0.4042417477,
pk_mx_yr_util_adl_firstseen2 = 0 => 0.4181818182,
pk_mx_yr_util_adl_firstseen2 = 1 => 0.4040524434,
pk_mx_yr_util_adl_firstseen2 = 2 => 0.3753694581,
pk_mx_yr_util_adl_firstseen2 = 3 => 0.3602047345,
pk_mx_yr_util_adl_firstseen2 = 4 => 0.3417877907,
pk_mx_yr_util_adl_firstseen2 = 5 => 0.3133190374,
0.3570136549
);


pk_yr_util_add1_E_firstseen2_mm := map(
pk_yr_util_add1_E_firstseen2 = -1 => 0.3598355569,
pk_yr_util_add1_E_firstseen2 = 0 => 0.3395311237,
pk_yr_util_add1_E_firstseen2 = 1 => 0.3134582624,
0.3570136549
);


pk_yr_util_add1_F_firstseen2_mm := map(
pk_yr_util_add1_F_firstseen2 = -1 => 0.3775731822,
pk_yr_util_add1_F_firstseen2 = 0 => 0.3002309469,
pk_yr_util_add1_F_firstseen2 = 1 => 0.2945913096,
0.3570136549
);


pk_yr_util_add1_I_firstseen2_mm := map(
pk_yr_util_add1_I_firstseen2 = -1 => 0.3721174463,
pk_yr_util_add1_I_firstseen2 = 0 => 0.3286026201,
pk_yr_util_add1_I_firstseen2 = 1 => 0.2941562705,
pk_yr_util_add1_I_firstseen2 = 2 => 0.2837465565,
pk_yr_util_add1_I_firstseen2 = 3 => 0.2541436464,
0.3570136549
);


pk_yr_util_add1_U_firstseen2_mm := map(
pk_yr_util_add1_U_firstseen2 = -1 => 0.3634978672,
pk_yr_util_add1_U_firstseen2 = 0 => 0.330672748,
pk_yr_util_add1_U_firstseen2 = 1 => 0.3262548263,
0.3570136549
);


pk_yr_util_add1_V_firstseen2_mm := map(
pk_yr_util_add1_V_firstseen2 = -1 => 0.3584020064,
pk_yr_util_add1_V_firstseen2 = 1 => 0.2210526316,
0.3570136549
);


pk_yr_util_add1_Z_firstseen2_mm := map(
pk_yr_util_add1_Z_firstseen2 = -1 => 0.4028862077,
pk_yr_util_add1_Z_firstseen2 = 0 => 0.3730867347,
pk_yr_util_add1_Z_firstseen2 = 1 => 0.3430232558,
0.3570136549
);


pk_mx_yr_util_add1_firstseen2_mm := map(
pk_mx_yr_util_add1_firstseen2 = -1 => 0.4140302613,
pk_mx_yr_util_add1_firstseen2 = 0 => 0.386199794,
pk_mx_yr_util_add1_firstseen2 = 1 => 0.3529411765,
pk_mx_yr_util_add1_firstseen2 = 2 => 0.308650519,
0.3570136549
);


pk_yr_util_add2_D_firstseen2_mm := map(
pk_yr_util_add2_D_firstseen2 = -1 => 0.3582170543,
pk_yr_util_add2_D_firstseen2 = 1 => 0.3440501044,
0.3570136549
);


pk_yr_util_add2_E_firstseen2_mm := map(
pk_yr_util_add2_E_firstseen2 = -1 => 0.3599503356,
pk_yr_util_add2_E_firstseen2 = 0 => 0.4285714286,
pk_yr_util_add2_E_firstseen2 = 1 => 0.332038835,
pk_yr_util_add2_E_firstseen2 = 2 => 0.324881141,
pk_yr_util_add2_E_firstseen2 = 3 => 0.3080985915,
0.3570136549
);


pk_yr_util_add2_G_firstseen2_mm := map(
pk_yr_util_add2_G_firstseen2 = -1 => 0.3565784203,
pk_yr_util_add2_G_firstseen2 = 1 => 0.3732970027,
0.3570136549
);


pk_yr_util_add2_U_firstseen2_mm := map(
pk_yr_util_add2_U_firstseen2 = -1 => 0.3584345918,
pk_yr_util_add2_U_firstseen2 = 0 => 0.3465648855,
pk_yr_util_add2_U_firstseen2 = 1 => 0.3474258438,
0.3570136549
);


pk_yr_util_add2_Z_firstseen2_mm := map(
pk_yr_util_add2_Z_firstseen2 = -1 => 0.373665868,
pk_yr_util_add2_Z_firstseen2 = 0 => 0.3835616438,
pk_yr_util_add2_Z_firstseen2 = 1 => 0.3482947233,
0.3570136549
);


pk_nap_type_mm := map(
pk_nap_type = 0 => 0,
pk_nap_type = 1 => 0.3333333333,
pk_nap_type = 2 => 0.236,
pk_nap_type = 3 => 0.3592299635,
0.3570136549
);


pk_EN_count_mm := map(
pk_EN_count = -1 => 0.3449502134,
pk_EN_count = 0 => 0.3934324659,
pk_EN_count = 1 => 0.3636969562,
pk_EN_count = 2 => 0.3378629667,
pk_EN_count = 3 => 0.2824651504,
0.3570136549
);


pk_dl_avail_mm := map(
pk_dl_avail = 0 => 0.3704896124,
pk_dl_avail = 1 => 0.3381061962,
0.3570136549
);


pk_DL_count_mm := map(
pk_DL_count = -1 => 0.3727357719,
pk_DL_count = 0 => 0.3529307597,
pk_DL_count = 1 => 0.3296738779,
pk_DL_count = 2 => 0.310701107,
pk_DL_count = 3 => 0.2566191446,
0.3570136549
);


pk_yr_adl_EN_first_seen2_mm := map(
pk_yr_adl_EN_first_seen2 = -1 => 0.3449502134,
pk_yr_adl_EN_first_seen2 = 14 => 0.3120818575,
pk_yr_adl_EN_first_seen2 = 15 => 0.3285175879,
pk_yr_adl_EN_first_seen2 = 16 => 0.3602980309,
pk_yr_adl_EN_first_seen2 = 17 => 0.3659359191,
pk_yr_adl_EN_first_seen2 = 18 => 0.3495306461,
pk_yr_adl_EN_first_seen2 = 19 => 0.3673565381,
pk_yr_adl_EN_first_seen2 = 20 => 0.3939774153,
pk_yr_adl_EN_first_seen2 = 21 => 0.3986568987,
pk_yr_adl_EN_first_seen2 = 22 => 0.3920532394,
0.3570136549
);


pk_yr_adl_DL_first_seen2_mm := map(
pk_yr_adl_DL_first_seen2 = -9 => 0.3735853392,
pk_yr_adl_DL_first_seen2 = -1 => 0.3492647059,
pk_yr_adl_DL_first_seen2 = 0 => 0.2865697177,
pk_yr_adl_DL_first_seen2 = 1 => 0.3351877608,
0.3570136549
);



            elseif( pk_segment2 = 2 ) then /* 2 SkipTrace        */



pk_nas_summary_mm := map(
pk_nas_summary = 0 => 0.2222222222,
pk_nas_summary = 1 => 0.1893203883,
pk_nas_summary = 2 => 0.2076259716,
0.2075622878
);


pk_nap_summary_mm := map(
pk_nap_summary = -1 => 0.1182348043,
pk_nap_summary = 0 => 0.1531073446,
pk_nap_summary = 1 => 0.2377182518,
pk_nap_summary = 2 => 0.2524145884,
0.2075622878
);


pk_rc_dirsaddr_lastscore_mm := map(
pk_rc_dirsaddr_lastscore = -1 => 0.174540377,
pk_rc_dirsaddr_lastscore = 0 => 0.1635687732,
pk_rc_dirsaddr_lastscore = 1 => 0.2714025501,
pk_rc_dirsaddr_lastscore = 2 => 0.2387218045,
0.2075622878
);


pk_combo_hphonescore_mm := map(
pk_combo_hphonescore = 0 => 0.1444976077,
pk_combo_hphonescore = 1 => 0.25,
pk_combo_hphonescore = 2 => 0.212848394,
0.2075622878
);


pk_combo_dobscore_mm := map(
pk_combo_dobscore = -1 => 0.1969872538,
pk_combo_dobscore = 1 => 0.1881188119,
pk_combo_dobscore = 2 => 0.2085744559,
0.2075622878
);


pk_gong_did_first_ct_mm := map(
pk_gong_did_first_ct = 0 => 0.2335710156,
pk_gong_did_first_ct = 1 => 0.2011417697,
0.2075622878
);


pk_rc_phonelnamecount_mm := map(
pk_rc_phonelnamecount = 0 => 0.1689158794,
pk_rc_phonelnamecount = 1 => 0.2154574277,
0.2075622878
);


pk_combo_addrcount_mm := map(
pk_combo_addrcount = 0 => 0.1488095238,
pk_combo_addrcount = 1 => 0.1829057365,
pk_combo_addrcount = 2 => 0.2131079967,
pk_combo_addrcount = 3 => 0.2420952381,
pk_combo_addrcount = 4 => 0.2461278513,
0.2075622878
);


pk_rc_phoneaddrcount_mm := map(
pk_rc_phoneaddrcount = 0 => 0.1647897898,
pk_rc_phoneaddrcount = 1 => 0.251765071,
0.2075622878
);


pk_combo_hphonecount_mm := map(
pk_combo_hphonecount = 0 => 0.1355983163,
pk_combo_hphonecount = 1 => 0.2180221125,
0.2075622878
);


pk_ver_phncount_mm := map(
pk_ver_phncount = 0 => 0.1213915618,
pk_ver_phncount = 1 => 0.1566082033,
pk_ver_phncount = 2 => 0.2238764045,
pk_ver_phncount = 3 => 0.2524145884,
0.2075622878
);


pk_gong_did_phone_ct_mm := map(
pk_gong_did_phone_ct = -1 => 0.2280966767,
pk_gong_did_phone_ct = 0 => 0.2323490096,
pk_gong_did_phone_ct = 1 => 0.1916944104,
pk_gong_did_phone_ct = 2 => 0.1738667802,
pk_gong_did_phone_ct = 3 => 0.1596534653,
0.2075622878
);


pk_combo_ssncount_mm := map(
pk_combo_ssncount = -1 => 0.2167832168,
pk_combo_ssncount = 0 => 0.1873015873,
pk_combo_ssncount = 1 => 0.207758922,
0.2075622878
);


pk_eq_count_mm := map(
pk_eq_count = 0 => 0.228668942,
pk_eq_count = 1 => 0.2371794872,
pk_eq_count = 2 => 0.2215980025,
pk_eq_count = 3 => 0.2150537634,
pk_eq_count = 4 => 0.1959361393,
pk_eq_count = 5 => 0.2048324634,
pk_eq_count = 6 => 0.2061969346,
0.2075622878
);


pk_em_count_mm := map(
pk_em_count = 0 => 0.2119500802,
pk_em_count = 1 => 0.2147083686,
pk_em_count = 2 => 0.1940005607,
0.2075622878
);


pk_em_only_count_mm := map(
pk_em_only_count = 0 => 0.2082636955,
pk_em_only_count = 1 => 0.1988540613,
pk_em_only_count = 2 => 0.2051282051,
pk_em_only_count = 3 => 0.255033557,
0.2075622878
);


pk_pos_secondary_sources_mm := map(
pk_pos_secondary_sources = 0 => 0.206822945,
pk_pos_secondary_sources = 1 => 0.3076923077,
pk_pos_secondary_sources = 2 => 0.2107279693,
0.2075622878
);


pk_voter_flag_mm := map(
pk_voter_flag = -1 => 0.1923394875,
pk_voter_flag = 0 => 0.2185924958,
pk_voter_flag = 1 => 0.2022585539,
0.2075622878
);


pk_fname_eda_sourced_type_lvl_mm := map(
pk_fname_eda_sourced_type_lvl = 0 => 0.1887235709,
pk_fname_eda_sourced_type_lvl = 1 => 0.1393323657,
pk_fname_eda_sourced_type_lvl = 2 => 0.2170457055,
pk_fname_eda_sourced_type_lvl = 3 => 0.2462825279,
0.2075622878
);


pk_lname_eda_sourced_type_lvl_mm := map(
pk_lname_eda_sourced_type_lvl = 0 => 0.1676348548,
pk_lname_eda_sourced_type_lvl = 1 => 0.174488568,
pk_lname_eda_sourced_type_lvl = 2 => 0.1726700972,
pk_lname_eda_sourced_type_lvl = 3 => 0.244200338,
0.2075622878
);


pk_add1_address_score_mm := map(
pk_add1_address_score = 0 => 0.2368231047,
pk_add1_address_score = 1 => 0.2059297454,
0.2075622878
);


pk_add2_pos_sources_mm := map(
pk_add2_pos_sources = 0 => 0.2314114682,
pk_add2_pos_sources = 1 => 0.2048316252,
pk_add2_pos_sources = 2 => 0.1935127165,
pk_add2_pos_sources = 3 => 0.1912053396,
pk_add2_pos_sources = 4 => 0.1710945802,
0.2075622878
);


pk_ssnchar_invalid_or_recent_mm := map(
pk_ssnchar_invalid_or_recent = 0 => 0.2075810894,
pk_ssnchar_invalid_or_recent = 1 => 0.2,
0.2075622878
);


pk_infutor_risk_lvl_mm := map(
pk_infutor_risk_lvl = 0 => 0.2184915811,
pk_infutor_risk_lvl = 1 => 0.1821282401,
pk_infutor_risk_lvl = 2 => 0.1623477989,
0.2075622878
);


pk_yr_adl_eq_first_seen2_mm := map(
pk_yr_adl_eq_first_seen2 = -1 => 0.2179487179,
pk_yr_adl_eq_first_seen2 = 0 => 0.2631578947,
pk_yr_adl_eq_first_seen2 = 1 => 0.3095238095,
pk_yr_adl_eq_first_seen2 = 2 => 0.1825396825,
pk_yr_adl_eq_first_seen2 = 3 => 0.1689860835,
pk_yr_adl_eq_first_seen2 = 4 => 0.1916010499,
pk_yr_adl_eq_first_seen2 = 5 => 0.1915103653,
pk_yr_adl_eq_first_seen2 = 6 => 0.1845416417,
pk_yr_adl_eq_first_seen2 = 7 => 0.179743534,
pk_yr_adl_eq_first_seen2 = 8 => 0.185638742,
pk_yr_adl_eq_first_seen2 = 9 => 0.2044413112,
pk_yr_adl_eq_first_seen2 = 10 => 0.2334723578,
0.2075622878
);


pk_yr_adl_em_first_seen2_mm := map(
pk_yr_adl_em_first_seen2 = -1 => 0.2115717351,
pk_yr_adl_em_first_seen2 = 0 => 0.1409395973,
pk_yr_adl_em_first_seen2 = 1 => 0.2139917695,
pk_yr_adl_em_first_seen2 = 2 => 0.2055335968,
pk_yr_adl_em_first_seen2 = 3 => 0.2018042098,
pk_yr_adl_em_first_seen2 = 4 => 0.2064372919,
0.2075622878
);


pk_yr_adl_vo_first_seen2_mm := map(
pk_yr_adl_vo_first_seen2 = -1 => 0.2119238794,
pk_yr_adl_vo_first_seen2 = 0 => 0.1719457014,
pk_yr_adl_vo_first_seen2 = 1 => 0.1824427481,
pk_yr_adl_vo_first_seen2 = 2 => 0.1987746767,
pk_yr_adl_vo_first_seen2 = 3 => 0.2119092305,
0.2075622878
);


pk_yr_adl_em_only_first_seen2_mm := map(
pk_yr_adl_em_only_first_seen2 = -1 => 0.2080296989,
pk_yr_adl_em_only_first_seen2 = 0 => 0.1111111111,
pk_yr_adl_em_only_first_seen2 = 1 => 0.2330623306,
pk_yr_adl_em_only_first_seen2 = 2 => 0.2079646018,
pk_yr_adl_em_only_first_seen2 = 3 => 0.2018403087,
pk_yr_adl_em_only_first_seen2 = 4 => 0.2481751825,
0.2075622878
);


pk_yr_lname_change_date2_mm := map(
pk_yr_lname_change_date2 = -1 => 0.2068427962,
pk_yr_lname_change_date2 = 0 => 0.1951219512,
pk_yr_lname_change_date2 = 1 => 0.213592233,
pk_yr_lname_change_date2 = 2 => 0.24,
0.2075622878
);


pk_yr_gong_did_first_seen2_mm := map(
pk_yr_gong_did_first_seen2 = -1 => 0.2335710156,
pk_yr_gong_did_first_seen2 = 0 => 0.1941391941,
pk_yr_gong_did_first_seen2 = 1 => 0.2016689847,
pk_yr_gong_did_first_seen2 = 2 => 0.1678657074,
pk_yr_gong_did_first_seen2 = 3 => 0.1886195996,
pk_yr_gong_did_first_seen2 = 4 => 0.2035388382,
0.2075622878
);


pk_yr_credit_first_seen2_mm := map(
pk_yr_credit_first_seen2 = -1 => 0.2179487179,
pk_yr_credit_first_seen2 = 0 => 0.2631578947,
pk_yr_credit_first_seen2 = 1 => 0.3095238095,
pk_yr_credit_first_seen2 = 2 => 0.1825396825,
pk_yr_credit_first_seen2 = 3 => 0.1689860835,
pk_yr_credit_first_seen2 = 4 => 0.1916010499,
pk_yr_credit_first_seen2 = 5 => 0.1915103653,
pk_yr_credit_first_seen2 = 6 => 0.1845416417,
pk_yr_credit_first_seen2 = 7 => 0.179743534,
pk_yr_credit_first_seen2 = 8 => 0.185638742,
pk_yr_credit_first_seen2 = 9 => 0.2044413112,
pk_yr_credit_first_seen2 = 10 => 0.2333333333,
pk_yr_credit_first_seen2 = 11 => 0.2374670185,
0.2075622878
);


pk_yr_header_first_seen2_mm := map(
pk_yr_header_first_seen2 = -1 => 0.2395382395,
pk_yr_header_first_seen2 = 0 => 0.2476190476,
pk_yr_header_first_seen2 = 1 => 0.1783783784,
pk_yr_header_first_seen2 = 2 => 0.1798365123,
pk_yr_header_first_seen2 = 3 => 0.1496815287,
pk_yr_header_first_seen2 = 4 => 0.1855091384,
pk_yr_header_first_seen2 = 5 => 0.1952743074,
pk_yr_header_first_seen2 = 6 => 0.2121676892,
pk_yr_header_first_seen2 = 7 => 0.2340831629,
0.2075622878
);


pk_yr_infutor_first_seen2_mm := map(
pk_yr_infutor_first_seen2 = -1 => 0.2184915811,
pk_yr_infutor_first_seen2 = 0 => 0.1603773585,
pk_yr_infutor_first_seen2 = 1 => 0.1486880466,
pk_yr_infutor_first_seen2 = 2 => 0.1632522407,
pk_yr_infutor_first_seen2 = 3 => 0.1845238095,
pk_yr_infutor_first_seen2 = 4 => 0.1767298369,
0.2075622878
);


pk_EM_Only_ver_lvl_mm := map(
pk_EM_Only_ver_lvl = -1 => 0.1992882562,
pk_EM_Only_ver_lvl = 0 => 0.2081079832,
pk_EM_Only_ver_lvl = 1 => 0.1928335691,
pk_EM_Only_ver_lvl = 2 => 0.2097791798,
pk_EM_Only_ver_lvl = 3 => 0.2284768212,
0.2075622878
);


pk_add2_EM_ver_lvl_mm := map(
pk_add2_EM_ver_lvl = -1 => 0.1012658228,
pk_add2_EM_ver_lvl = 0 => 0.2080341471,
pk_add2_EM_ver_lvl = 1 => 0.1855670103,
pk_add2_EM_ver_lvl = 2 => 0.2201039861,
0.2075622878
);


pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.2,
pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0.3333333333,
pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.24,
pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0.24,
pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.2072072072,
pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.1886792453,
pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.2050209205,
pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.1777777778,
pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.1736334405,
pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.1850989523,
pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.1787112852,
pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.1885692068,
pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.1761835041,
pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.1797935904,
pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.2,
pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.2283819297,
pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.2380078035,
0.2075622878
);


pk_util_adl_source_count_mm := map(
pk_util_adl_source_count = 0 => 0.2634711779,
pk_util_adl_source_count = 1 => 0.2265212803,
pk_util_adl_source_count = 2 => 0.1957353745,
pk_util_adl_source_count = 3 => 0.1721974345,
0.2075622878
);


pk_util_adl_sourced_mm := map(
pk_util_adl_sourced = 0 => 0.2634711779,
pk_util_adl_sourced = 1 => 0.1998088369,
0.2075622878
);


pk_util_adl_count_mm := map(
pk_util_adl_count = 0 => 0.2634711779,
pk_util_adl_count = 1 => 0.2452229299,
pk_util_adl_count = 2 => 0.2219639744,
pk_util_adl_count = 3 => 0.1959436232,
pk_util_adl_count = 4 => 0.1913077222,
pk_util_adl_count = 5 => 0.1810061119,
0.2075622878
);


pk_util_adl_nap_mm := map(
pk_util_adl_nap = -1 => 0.2557596967,
pk_util_adl_nap = 0 => 0.1873972884,
pk_util_adl_nap = 1 => 0.2762998791,
0.2075622878
);


pk_util_add1_source_count_mm := map(
pk_util_add1_source_count = 0 => 0.2443306511,
pk_util_add1_source_count = 1 => 0.2155919153,
pk_util_add1_source_count = 2 => 0.2073996873,
pk_util_add1_source_count = 3 => 0.1827471483,
pk_util_add1_source_count = 4 => 0.1739386792,
pk_util_add1_source_count = 5 => 0.1838235294,
0.2075622878
);


pk_util_add1_nap_mm := map(
pk_util_add1_nap = -1 => 0.2139403035,
pk_util_add1_nap = 0 => 0.1919460706,
pk_util_add1_nap = 1 => 0.2759769767,
0.2075622878
);


pk_util_add2_source_count_mm := map(
pk_util_add2_source_count = 0 => 0.2208728146,
pk_util_add2_source_count = 1 => 0.1952249472,
pk_util_add2_source_count = 2 => 0.1878218722,
pk_util_add2_source_count = 3 => 0.1745042493,
0.2075622878
);


pk_util_add2_nap_mm := map(
pk_util_add2_nap = -1 => 0.2307634449,
pk_util_add2_nap = 0 => 0.1820754717,
pk_util_add2_nap = 1 => 0.1985645933,
0.2075622878
);


pk_rc_utiliaddr_phonecount_mm := map(
pk_rc_utiliaddr_phonecount = 0 => 0.1974376974,
pk_rc_utiliaddr_phonecount = 1 => 0.2750951127,
0.2075622878
);


pk_utility_sourced_mm := map(
pk_utility_sourced = 0 => 0.2153528399,
pk_utility_sourced = 1 => 0.1978774392,
0.2075622878
);


pk_yr_util_adl_D_firstseen2_mm := map(
pk_yr_util_adl_D_firstseen2 = -1 => 0.2146016647,
pk_yr_util_adl_D_firstseen2 = 0 => 0.2090909091,
pk_yr_util_adl_D_firstseen2 = 1 => 0.1776792909,
0.2075622878
);


pk_yr_util_adl_E_firstseen2_mm := map(
pk_yr_util_adl_E_firstseen2 = -1 => 0.2111475709,
pk_yr_util_adl_E_firstseen2 = 0 => 0.2146017699,
pk_yr_util_adl_E_firstseen2 = 1 => 0.2229299363,
pk_yr_util_adl_E_firstseen2 = 2 => 0.2005988024,
pk_yr_util_adl_E_firstseen2 = 3 => 0.2032520325,
pk_yr_util_adl_E_firstseen2 = 4 => 0.1982182628,
pk_yr_util_adl_E_firstseen2 = 5 => 0.201980198,
pk_yr_util_adl_E_firstseen2 = 6 => 0.1707650273,
pk_yr_util_adl_E_firstseen2 = 7 => 0.1636690647,
0.2075622878
);


pk_yr_util_adl_F_firstseen2_mm := map(
pk_yr_util_adl_F_firstseen2 = -1 => 0.2266992931,
pk_yr_util_adl_F_firstseen2 = 0 => 0.2017094017,
pk_yr_util_adl_F_firstseen2 = 1 => 0.1538461538,
pk_yr_util_adl_F_firstseen2 = 2 => 0.1600308642,
0.2075622878
);


pk_yr_util_adl_G_firstseen2_mm := map(
pk_yr_util_adl_G_firstseen2 = -1 => 0.2078336056,
pk_yr_util_adl_G_firstseen2 = 0 => 0.2035928144,
pk_yr_util_adl_G_firstseen2 = 1 => 0.2109181141,
pk_yr_util_adl_G_firstseen2 = 2 => 0.1438848921,
0.2075622878
);


pk_yr_util_adl_I_firstseen2_mm := map(
pk_yr_util_adl_I_firstseen2 = -1 => 0.2153615143,
pk_yr_util_adl_I_firstseen2 = 0 => 0.2064516129,
pk_yr_util_adl_I_firstseen2 = 1 => 0.1690340909,
pk_yr_util_adl_I_firstseen2 = 2 => 0.1547186933,
0.2075622878
);


pk_yr_util_adl_U_firstseen2_mm := map(
pk_yr_util_adl_U_firstseen2 = -1 => 0.2026202104,
pk_yr_util_adl_U_firstseen2 = 0 => 0.2607003891,
pk_yr_util_adl_U_firstseen2 = 1 => 0.242506812,
pk_yr_util_adl_U_firstseen2 = 2 => 0.2306238185,
pk_yr_util_adl_U_firstseen2 = 3 => 0.212977707,
0.2075622878
);


pk_mx_yr_util_adl_firstseen2_mm := map(
pk_mx_yr_util_adl_firstseen2 = -1 => 0.2634711779,
pk_mx_yr_util_adl_firstseen2 = 0 => 0.25,
pk_mx_yr_util_adl_firstseen2 = 1 => 0.2203389831,
pk_mx_yr_util_adl_firstseen2 = 2 => 0.210640608,
pk_mx_yr_util_adl_firstseen2 = 3 => 0.2180925666,
pk_mx_yr_util_adl_firstseen2 = 4 => 0.2009412728,
pk_mx_yr_util_adl_firstseen2 = 5 => 0.1819658814,
0.2075622878
);


pk_yr_util_add1_E_firstseen2_mm := map(
pk_yr_util_add1_E_firstseen2 = -1 => 0.2098189204,
pk_yr_util_add1_E_firstseen2 = 0 => 0.2024035421,
pk_yr_util_add1_E_firstseen2 = 1 => 0.1779717931,
0.2075622878
);


pk_yr_util_add1_F_firstseen2_mm := map(
pk_yr_util_add1_F_firstseen2 = -1 => 0.2205867109,
pk_yr_util_add1_F_firstseen2 = 0 => 0.177734375,
pk_yr_util_add1_F_firstseen2 = 1 => 0.1707012338,
0.2075622878
);


pk_yr_util_add1_I_firstseen2_mm := map(
pk_yr_util_add1_I_firstseen2 = -1 => 0.2120365195,
pk_yr_util_add1_I_firstseen2 = 0 => 0.1875,
pk_yr_util_add1_I_firstseen2 = 1 => 0.1971631206,
pk_yr_util_add1_I_firstseen2 = 2 => 0.1775147929,
pk_yr_util_add1_I_firstseen2 = 3 => 0.2132867133,
0.2075622878
);


pk_yr_util_add1_U_firstseen2_mm := map(
pk_yr_util_add1_U_firstseen2 = -1 => 0.2049314804,
pk_yr_util_add1_U_firstseen2 = 0 => 0.2127208481,
pk_yr_util_add1_U_firstseen2 = 1 => 0.2225988701,
0.2075622878
);


pk_yr_util_add1_V_firstseen2_mm := map(
pk_yr_util_add1_V_firstseen2 = -1 => 0.2080124465,
pk_yr_util_add1_V_firstseen2 = 1 => 0.1843687375,
0.2075622878
);


pk_yr_util_add1_Z_firstseen2_mm := map(
pk_yr_util_add1_Z_firstseen2 = -1 => 0.2416208104,
pk_yr_util_add1_Z_firstseen2 = 0 => 0.2029862793,
pk_yr_util_add1_Z_firstseen2 = 1 => 0.2009852217,
0.2075622878
);


pk_mx_yr_util_add1_firstseen2_mm := map(
pk_mx_yr_util_add1_firstseen2 = -1 => 0.2443306511,
pk_mx_yr_util_add1_firstseen2 = 0 => 0.2133492253,
pk_mx_yr_util_add1_firstseen2 = 1 => 0.202132561,
pk_mx_yr_util_add1_firstseen2 = 2 => 0.197210668,
0.2075622878
);


pk_yr_util_add2_D_firstseen2_mm := map(
pk_yr_util_add2_D_firstseen2 = -1 => 0.211183794,
pk_yr_util_add2_D_firstseen2 = 1 => 0.1734287987,
0.2075622878
);


pk_yr_util_add2_E_firstseen2_mm := map(
pk_yr_util_add2_E_firstseen2 = -1 => 0.2091481041,
pk_yr_util_add2_E_firstseen2 = 0 => 0.2359550562,
pk_yr_util_add2_E_firstseen2 = 1 => 0.2269372694,
pk_yr_util_add2_E_firstseen2 = 2 => 0.1832865169,
pk_yr_util_add2_E_firstseen2 = 3 => 0.1825396825,
0.2075622878
);


pk_yr_util_add2_G_firstseen2_mm := map(
pk_yr_util_add2_G_firstseen2 = -1 => 0.2074975466,
pk_yr_util_add2_G_firstseen2 = 1 => 0.2098092643,
0.2075622878
);


pk_yr_util_add2_U_firstseen2_mm := map(
pk_yr_util_add2_U_firstseen2 = -1 => 0.2076822032,
pk_yr_util_add2_U_firstseen2 = 0 => 0.1972789116,
pk_yr_util_add2_U_firstseen2 = 1 => 0.2090079482,
0.2075622878
);


pk_yr_util_add2_Z_firstseen2_mm := map(
pk_yr_util_add2_Z_firstseen2 = -1 => 0.2348045772,
pk_yr_util_add2_Z_firstseen2 = 0 => 0.1876606684,
pk_yr_util_add2_Z_firstseen2 = 1 => 0.1983657221,
0.2075622878
);


pk_nap_type_mm := map(
pk_nap_type = 0 => 0.1327433628,
pk_nap_type = 1 => 0.1350574713,
pk_nap_type = 2 => 0.1551528879,
pk_nap_type = 3 => 0.2128262864,
0.2075622878
);


pk_EN_count_mm := map(
pk_EN_count = -1 => 0.2306501548,
pk_EN_count = 0 => 0.2312305642,
pk_EN_count = 1 => 0.2068212162,
pk_EN_count = 2 => 0.2049861496,
pk_EN_count = 3 => 0.1851851852,
0.2075622878
);


pk_dl_avail_mm := map(
pk_dl_avail = 0 => 0.2209944751,
pk_dl_avail = 1 => 0.187344676,
0.2075622878
);


pk_DL_count_mm := map(
pk_DL_count = -1 => 0.2242420308,
pk_DL_count = 0 => 0.2056689342,
pk_DL_count = 1 => 0.1873005743,
pk_DL_count = 2 => 0.1575618171,
pk_DL_count = 3 => 0.1431385424,
0.2075622878
);


pk_yr_adl_EN_first_seen2_mm := map(
pk_yr_adl_EN_first_seen2 = -1 => 0.2306501548,
pk_yr_adl_EN_first_seen2 = 14 => 0.1809534594,
pk_yr_adl_EN_first_seen2 = 15 => 0.2137856758,
pk_yr_adl_EN_first_seen2 = 16 => 0.1959899749,
pk_yr_adl_EN_first_seen2 = 17 => 0.1823725055,
pk_yr_adl_EN_first_seen2 = 18 => 0.208,
pk_yr_adl_EN_first_seen2 = 19 => 0.2441923285,
pk_yr_adl_EN_first_seen2 = 20 => 0.2421758569,
pk_yr_adl_EN_first_seen2 = 21 => 0.239139429,
pk_yr_adl_EN_first_seen2 = 22 => 0.22988805,
0.2075622878
);


pk_yr_adl_DL_first_seen2_mm := map(
pk_yr_adl_DL_first_seen2 = -9 => 0.223438793,
pk_yr_adl_DL_first_seen2 = -1 => 0.1961852861,
pk_yr_adl_DL_first_seen2 = 0 => 0.1682389937,
pk_yr_adl_DL_first_seen2 = 1 => 0.185532107,
0.2075622878
);




            elseif( pk_segment2 = 3 ) then /* 3 Mid              */



pk_nas_summary_mm := map(
pk_nas_summary = 0 => 0.1093088858,
pk_nas_summary = 1 => 0.1255319149,
pk_nas_summary = 2 => 0.1137843351,
0.1138478602
);


pk_nap_summary_mm := map(
pk_nap_summary = -1 => 0.1053103294,
pk_nap_summary = 0 => 0.1106783651,
pk_nap_summary = 1 => 0.1111664296,
pk_nap_summary = 2 => 0.1396474248,
0.1138478602
);


pk_rc_dirsaddr_lastscore_mm := map(
pk_rc_dirsaddr_lastscore = -1 => 0.1074181118,
pk_rc_dirsaddr_lastscore = 0 => 0.116298431,
pk_rc_dirsaddr_lastscore = 1 => 0.1275088548,
pk_rc_dirsaddr_lastscore = 2 => 0.127460815,
0.1138478602
);


pk_combo_hphonescore_mm := map(
pk_combo_hphonescore = 0 => 0.1060359855,
pk_combo_hphonescore = 1 => 0.1206896552,
pk_combo_hphonescore = 2 => 0.1204422666,
0.1138478602
);


pk_combo_dobscore_mm := map(
pk_combo_dobscore = -1 => 0.1101793618,
pk_combo_dobscore = 0 => 0,
pk_combo_dobscore = 1 => 0.1080050826,
pk_combo_dobscore = 2 => 0.1142954826,
0.1138478602
);


pk_gong_did_first_ct_mm := map(
pk_gong_did_first_ct = 0 => 0.1300691035,
pk_gong_did_first_ct = 1 => 0.1069778189,
0.1138478602
);


pk_rc_phonelnamecount_mm := map(
pk_rc_phonelnamecount = 0 => 0.113707604,
pk_rc_phonelnamecount = 1 => 0.1143123761,
0.1138478602
);


pk_combo_addrcount_mm := map(
pk_combo_addrcount = 0 => 0.099780461,
pk_combo_addrcount = 1 => 0.1027379535,
pk_combo_addrcount = 2 => 0.1202041684,
pk_combo_addrcount = 3 => 0.1224386724,
pk_combo_addrcount = 4 => 0.1229861026,
0.1138478602
);


pk_rc_phoneaddrcount_mm := map(
pk_rc_phoneaddrcount = 0 => 0.1100872141,
pk_rc_phoneaddrcount = 1 => 0.1312110621,
0.1138478602
);


pk_combo_hphonecount_mm := map(
pk_combo_hphonecount = 0 => 0.1062091081,
pk_combo_hphonecount = 1 => 0.1222244279,
0.1138478602
);


pk_ver_phncount_mm := map(
pk_ver_phncount = 0 => 0.0989775754,
pk_ver_phncount = 1 => 0.1174403642,
pk_ver_phncount = 2 => 0.1101532567,
pk_ver_phncount = 3 => 0.1396474248,
0.1138478602
);


pk_gong_did_phone_ct_mm := map(
pk_gong_did_phone_ct = -1 => 0.1313959447,
pk_gong_did_phone_ct = 0 => 0.1098442837,
pk_gong_did_phone_ct = 1 => 0.09584,
pk_gong_did_phone_ct = 2 => 0.0986009327,
pk_gong_did_phone_ct = 3 => 0.1033944596,
0.1138478602
);


pk_combo_ssncount_mm := map(
pk_combo_ssncount = -1 => 0.1093088858,
pk_combo_ssncount = 0 => 0.1260504202,
pk_combo_ssncount = 1 => 0.1136517615,
0.1138478602
);


pk_eq_count_mm := map(
pk_eq_count = 0 => 0.1156289708,
pk_eq_count = 1 => 0.107966457,
pk_eq_count = 2 => 0.1112236287,
pk_eq_count = 3 => 0.103158431,
pk_eq_count = 4 => 0.1078790655,
pk_eq_count = 5 => 0.114180256,
pk_eq_count = 6 => 0.1182816695,
0.1138478602
);


pk_em_count_mm := map(
pk_em_count = 0 => 0.115790921,
pk_em_count = 1 => 0.1081611814,
pk_em_count = 2 => 0.1131420112,
0.1138478602
);


pk_em_only_count_mm := map(
pk_em_only_count = 0 => 0.1136655536,
pk_em_only_count = 1 => 0.1146706998,
pk_em_only_count = 2 => 0.1142778844,
pk_em_only_count = 3 => 0.1191135734,
0.1138478602
);


pk_pos_secondary_sources_mm := map(
pk_pos_secondary_sources = 0 => 0.113720099,
pk_pos_secondary_sources = 1 => 0.1245421245,
pk_pos_secondary_sources = 2 => 0.1191950464,
0.1138478602
);


pk_voter_flag_mm := map(
pk_voter_flag = -1 => 0.1013421201,
pk_voter_flag = 0 => 0.1215540454,
pk_voter_flag = 1 => 0.1110487571,
0.1138478602
);


pk_fname_eda_sourced_type_lvl_mm := map(
pk_fname_eda_sourced_type_lvl = 0 => 0.1120911874,
pk_fname_eda_sourced_type_lvl = 1 => 0.1308743948,
pk_fname_eda_sourced_type_lvl = 2 => 0.1075854448,
pk_fname_eda_sourced_type_lvl = 3 => 0.1241003272,
0.1138478602
);


pk_lname_eda_sourced_type_lvl_mm := map(
pk_lname_eda_sourced_type_lvl = 0 => 0.1106584761,
pk_lname_eda_sourced_type_lvl = 1 => 0.1273217207,
pk_lname_eda_sourced_type_lvl = 2 => 0.1063314711,
pk_lname_eda_sourced_type_lvl = 3 => 0.127692788,
0.1138478602
);


pk_add1_address_score_mm := map(
pk_add1_address_score = 0 => 0.1169962335,
pk_add1_address_score = 1 => 0.1136559325,
0.1138478602
);


pk_add2_pos_sources_mm := map(
pk_add2_pos_sources = 0 => 0.102868272,
pk_add2_pos_sources = 1 => 0.1197044722,
pk_add2_pos_sources = 2 => 0.1158739776,
pk_add2_pos_sources = 3 => 0.1160130719,
pk_add2_pos_sources = 4 => 0.1141661686,
0.1138478602
);


pk_ssnchar_invalid_or_recent_mm := map(
pk_ssnchar_invalid_or_recent = 0 => 0.1139615866,
pk_ssnchar_invalid_or_recent = 1 => 0.09375,
0.1138478602
);


pk_infutor_risk_lvl_mm := map(
pk_infutor_risk_lvl = 0 => 0.1233347927,
pk_infutor_risk_lvl = 1 => 0.1077511576,
pk_infutor_risk_lvl = 2 => 0.1049710848,
0.1138478602
);


pk_yr_adl_eq_first_seen2_mm := map(
pk_yr_adl_eq_first_seen2 = -1 => 0.103820598,
pk_yr_adl_eq_first_seen2 = 0 => 0.1294964029,
pk_yr_adl_eq_first_seen2 = 1 => 0.1508196721,
pk_yr_adl_eq_first_seen2 = 2 => 0.1287128713,
pk_yr_adl_eq_first_seen2 = 3 => 0.1186672752,
pk_yr_adl_eq_first_seen2 = 4 => 0.135935397,
pk_yr_adl_eq_first_seen2 = 5 => 0.1078346343,
pk_yr_adl_eq_first_seen2 = 6 => 0.1223845243,
pk_yr_adl_eq_first_seen2 = 7 => 0.1164933837,
pk_yr_adl_eq_first_seen2 = 8 => 0.1076986927,
pk_yr_adl_eq_first_seen2 = 9 => 0.1057053292,
pk_yr_adl_eq_first_seen2 = 10 => 0.1143415504,
0.1138478602
);


pk_yr_adl_em_first_seen2_mm := map(
pk_yr_adl_em_first_seen2 = -1 => 0.1156538593,
pk_yr_adl_em_first_seen2 = 0 => 0.1005154639,
pk_yr_adl_em_first_seen2 = 1 => 0.1234866828,
pk_yr_adl_em_first_seen2 = 2 => 0.1098687409,
pk_yr_adl_em_first_seen2 = 3 => 0.1105813799,
pk_yr_adl_em_first_seen2 = 4 => 0.1044061303,
0.1138478602
);


pk_yr_adl_vo_first_seen2_mm := map(
pk_yr_adl_vo_first_seen2 = -1 => 0.1156681834,
pk_yr_adl_vo_first_seen2 = 0 => 0.1050096339,
pk_yr_adl_vo_first_seen2 = 1 => 0.1237908102,
pk_yr_adl_vo_first_seen2 = 2 => 0.1062251656,
pk_yr_adl_vo_first_seen2 = 3 => 0.1062470893,
0.1138478602
);


pk_yr_adl_em_only_first_seen2_mm := map(
pk_yr_adl_em_only_first_seen2 = -1 => 0.1135720418,
pk_yr_adl_em_only_first_seen2 = 0 => 0.1567164179,
pk_yr_adl_em_only_first_seen2 = 1 => 0.1245059289,
pk_yr_adl_em_only_first_seen2 = 2 => 0.1341463415,
pk_yr_adl_em_only_first_seen2 = 3 => 0.1107278782,
pk_yr_adl_em_only_first_seen2 = 4 => 0.125,
0.1138478602
);


pk_yr_lname_change_date2_mm := map(
pk_yr_lname_change_date2 = -1 => 0.1138526255,
pk_yr_lname_change_date2 = 0 => 0.133640553,
pk_yr_lname_change_date2 = 1 => 0.1105491329,
pk_yr_lname_change_date2 = 2 => 0.1076696165,
0.1138478602
);


pk_yr_gong_did_first_seen2_mm := map(
pk_yr_gong_did_first_seen2 = -1 => 0.1300691035,
pk_yr_gong_did_first_seen2 = 0 => 0.1704697987,
pk_yr_gong_did_first_seen2 = 1 => 0.1137254902,
pk_yr_gong_did_first_seen2 = 2 => 0.1031929662,
pk_yr_gong_did_first_seen2 = 3 => 0.1094674556,
pk_yr_gong_did_first_seen2 = 4 => 0.1057517614,
0.1138478602
);


pk_yr_credit_first_seen2_mm := map(
pk_yr_credit_first_seen2 = -1 => 0.103820598,
pk_yr_credit_first_seen2 = 0 => 0.1294964029,
pk_yr_credit_first_seen2 = 1 => 0.1508196721,
pk_yr_credit_first_seen2 = 2 => 0.1287128713,
pk_yr_credit_first_seen2 = 3 => 0.1186672752,
pk_yr_credit_first_seen2 = 4 => 0.135935397,
pk_yr_credit_first_seen2 = 5 => 0.1078346343,
pk_yr_credit_first_seen2 = 6 => 0.1223845243,
pk_yr_credit_first_seen2 = 7 => 0.1164933837,
pk_yr_credit_first_seen2 = 8 => 0.1076986927,
pk_yr_credit_first_seen2 = 9 => 0.1057053292,
pk_yr_credit_first_seen2 = 10 => 0.1142715455,
pk_yr_credit_first_seen2 = 11 => 0.1164529915,
0.1138478602
);


pk_yr_header_first_seen2_mm := map(
pk_yr_header_first_seen2 = -1 => 0.133098059,
pk_yr_header_first_seen2 = 0 => 0.193452381,
pk_yr_header_first_seen2 = 1 => 0.1244695898,
pk_yr_header_first_seen2 = 2 => 0.1061818182,
pk_yr_header_first_seen2 = 3 => 0.1044776119,
pk_yr_header_first_seen2 = 4 => 0.1119218183,
pk_yr_header_first_seen2 = 5 => 0.107720476,
pk_yr_header_first_seen2 = 6 => 0.1118437422,
pk_yr_header_first_seen2 = 7 => 0.1164532901,
0.1138478602
);


pk_yr_infutor_first_seen2_mm := map(
pk_yr_infutor_first_seen2 = -1 => 0.1233232232,
pk_yr_infutor_first_seen2 = 0 => 0.1378504673,
pk_yr_infutor_first_seen2 = 1 => 0.1027837259,
pk_yr_infutor_first_seen2 = 2 => 0.1085615326,
pk_yr_infutor_first_seen2 = 3 => 0.12482066,
pk_yr_infutor_first_seen2 = 4 => 0.0908655573,
0.1138478602
);


pk_EM_Only_ver_lvl_mm := map(
pk_EM_Only_ver_lvl = -1 => 0.0998116761,
pk_EM_Only_ver_lvl = 0 => 0.1135759787,
pk_EM_Only_ver_lvl = 1 => 0.1072324012,
pk_EM_Only_ver_lvl = 2 => 0.1283389622,
pk_EM_Only_ver_lvl = 3 => 0.1185006046,
0.1138478602
);


pk_add2_EM_ver_lvl_mm := map(
pk_add2_EM_ver_lvl = -1 => 0.1487603306,
pk_add2_EM_ver_lvl = 0 => 0.1133284819,
pk_add2_EM_ver_lvl = 1 => 0.1158841159,
pk_add2_EM_ver_lvl = 2 => 0.1366322009,
0.1138478602
);


pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.1009389671,
pk_yrmo_adl_f_sn_mx_fcra2 = 0 => 0,
pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0.1637426901,
pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.1310679612,
pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0.1451612903,
pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.1130573248,
pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.1428571429,
pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.1219312602,
pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.104283054,
pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.1328185328,
pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.1141217724,
pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.1189412169,
pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.1184378095,
pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.1065514759,
pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.1102895872,
pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.1078331638,
pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.1104318292,
pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.1181916232,
0.1138478602
);


pk_util_adl_source_count_mm := map(
pk_util_adl_source_count = 0 => 0.1050362738,
pk_util_adl_source_count = 1 => 0.1076585473,
pk_util_adl_source_count = 2 => 0.1227532586,
pk_util_adl_source_count = 3 => 0.1153709979,
0.1138478602
);


pk_util_adl_sourced_mm := map(
pk_util_adl_sourced = 0 => 0.1050362738,
pk_util_adl_sourced = 1 => 0.1151487869,
0.1138478602
);


pk_util_adl_count_mm := map(
pk_util_adl_count = 0 => 0.1050362738,
pk_util_adl_count = 1 => 0.1129903923,
pk_util_adl_count = 2 => 0.1125363263,
pk_util_adl_count = 3 => 0.116435966,
pk_util_adl_count = 4 => 0.1132596685,
pk_util_adl_count = 5 => 0.1169049034,
0.1138478602
);


pk_util_adl_nap_mm := map(
pk_util_adl_nap = -1 => 0.1043147462,
pk_util_adl_nap = 0 => 0.1084826153,
pk_util_adl_nap = 1 => 0.1424038387,
0.1138478602
);


pk_util_add1_source_count_mm := map(
pk_util_add1_source_count = 0 => 0.1130627306,
pk_util_add1_source_count = 1 => 0.109597033,
pk_util_add1_source_count = 2 => 0.1187544611,
pk_util_add1_source_count = 3 => 0.1136989359,
pk_util_add1_source_count = 4 => 0.1152225682,
pk_util_add1_source_count = 5 => 0.1094257855,
0.1138478602
);


pk_util_add1_nap_mm := map(
pk_util_add1_nap = -1 => 0.1040411089,
pk_util_add1_nap = 0 => 0.1099587681,
pk_util_add1_nap = 1 => 0.1457725948,
0.1138478602
);


pk_util_add2_source_count_mm := map(
pk_util_add2_source_count = 0 => 0.1135722639,
pk_util_add2_source_count = 1 => 0.1156744071,
pk_util_add2_source_count = 2 => 0.1156195462,
pk_util_add2_source_count = 3 => 0.107034872,
0.1138478602
);


pk_util_add2_nap_mm := map(
pk_util_add2_nap = -1 => 0.1098128165,
pk_util_add2_nap = 0 => 0.1188721105,
pk_util_add2_nap = 1 => 0.1291150064,
0.1138478602
);


pk_rc_utiliaddr_phonecount_mm := map(
pk_rc_utiliaddr_phonecount = 0 => 0.1080300589,
pk_rc_utiliaddr_phonecount = 1 => 0.1462461128,
0.1138478602
);


pk_utility_sourced_mm := map(
pk_utility_sourced = 0 => 0.1053815582,
pk_utility_sourced = 1 => 0.1238319823,
0.1138478602
);


pk_yr_util_adl_D_firstseen2_mm := map(
pk_yr_util_adl_D_firstseen2 = -1 => 0.1190917748,
pk_yr_util_adl_D_firstseen2 = 0 => 0.1338742394,
pk_yr_util_adl_D_firstseen2 = 1 => 0.0900191373,
0.1138478602
);


pk_yr_util_adl_E_firstseen2_mm := map(
pk_yr_util_adl_E_firstseen2 = -1 => 0.1110358071,
pk_yr_util_adl_E_firstseen2 = 0 => 0.1776691117,
pk_yr_util_adl_E_firstseen2 = 1 => 0.1534772182,
pk_yr_util_adl_E_firstseen2 = 2 => 0.1389793702,
pk_yr_util_adl_E_firstseen2 = 3 => 0.1359126984,
pk_yr_util_adl_E_firstseen2 = 4 => 0.1266766021,
pk_yr_util_adl_E_firstseen2 = 5 => 0.118046133,
pk_yr_util_adl_E_firstseen2 = 6 => 0.1096163428,
pk_yr_util_adl_E_firstseen2 = 7 => 0.1146759848,
0.1138478602
);


pk_yr_util_adl_F_firstseen2_mm := map(
pk_yr_util_adl_F_firstseen2 = -1 => 0.1232853224,
pk_yr_util_adl_F_firstseen2 = 0 => 0.1317460317,
pk_yr_util_adl_F_firstseen2 = 1 => 0.1051597052,
pk_yr_util_adl_F_firstseen2 = 2 => 0.0862857458,
0.1138478602
);


pk_yr_util_adl_G_firstseen2_mm := map(
pk_yr_util_adl_G_firstseen2 = -1 => 0.1122585742,
pk_yr_util_adl_G_firstseen2 = 0 => 0.2103004292,
pk_yr_util_adl_G_firstseen2 = 1 => 0.1441860465,
pk_yr_util_adl_G_firstseen2 = 2 => 0.1195402299,
0.1138478602
);


pk_yr_util_adl_I_firstseen2_mm := map(
pk_yr_util_adl_I_firstseen2 = -1 => 0.1157603223,
pk_yr_util_adl_I_firstseen2 = 0 => 0.1332391714,
pk_yr_util_adl_I_firstseen2 = 1 => 0.108649789,
pk_yr_util_adl_I_firstseen2 = 2 => 0.0964209402,
0.1138478602
);


pk_yr_util_adl_U_firstseen2_mm := map(
pk_yr_util_adl_U_firstseen2 = -1 => 0.0989899673,
pk_yr_util_adl_U_firstseen2 = 0 => 0.2345559846,
pk_yr_util_adl_U_firstseen2 = 1 => 0.2049689441,
pk_yr_util_adl_U_firstseen2 = 2 => 0.1856287425,
pk_yr_util_adl_U_firstseen2 = 3 => 0.1411674933,
0.1138478602
);


pk_mx_yr_util_adl_firstseen2_mm := map(
pk_mx_yr_util_adl_firstseen2 = -1 => 0.1050362738,
pk_mx_yr_util_adl_firstseen2 = 0 => 0.1496478873,
pk_mx_yr_util_adl_firstseen2 = 1 => 0.1468703795,
pk_mx_yr_util_adl_firstseen2 = 2 => 0.1249530957,
pk_mx_yr_util_adl_firstseen2 = 3 => 0.1249100935,
pk_mx_yr_util_adl_firstseen2 = 4 => 0.1159017502,
pk_mx_yr_util_adl_firstseen2 = 5 => 0.1013051585,
0.1138478602
);


pk_yr_util_add1_E_firstseen2_mm := map(
pk_yr_util_add1_E_firstseen2 = -1 => 0.1126549874,
pk_yr_util_add1_E_firstseen2 = 0 => 0.1370806487,
pk_yr_util_add1_E_firstseen2 = 1 => 0.1079136691,
0.1138478602
);


pk_yr_util_add1_F_firstseen2_mm := map(
pk_yr_util_add1_F_firstseen2 = -1 => 0.1208343503,
pk_yr_util_add1_F_firstseen2 = 0 => 0.1267345051,
pk_yr_util_add1_F_firstseen2 = 1 => 0.0941392689,
0.1138478602
);


pk_yr_util_add1_I_firstseen2_mm := map(
pk_yr_util_add1_I_firstseen2 = -1 => 0.1156220735,
pk_yr_util_add1_I_firstseen2 = 0 => 0.1269724771,
pk_yr_util_add1_I_firstseen2 = 1 => 0.1091026469,
pk_yr_util_add1_I_firstseen2 = 2 => 0.1022352045,
pk_yr_util_add1_I_firstseen2 = 3 => 0.08984375,
0.1138478602
);


pk_yr_util_add1_U_firstseen2_mm := map(
pk_yr_util_add1_U_firstseen2 = -1 => 0.1043426027,
pk_yr_util_add1_U_firstseen2 = 0 => 0.1575941252,
pk_yr_util_add1_U_firstseen2 = 1 => 0.1324420066,
0.1138478602
);


pk_yr_util_add1_V_firstseen2_mm := map(
pk_yr_util_add1_V_firstseen2 = -1 => 0.1137310252,
pk_yr_util_add1_V_firstseen2 = 1 => 0.1189189189,
0.1138478602
);


pk_yr_util_add1_Z_firstseen2_mm := map(
pk_yr_util_add1_Z_firstseen2 = -1 => 0.1163950144,
pk_yr_util_add1_Z_firstseen2 = 0 => 0.1236340432,
pk_yr_util_add1_Z_firstseen2 = 1 => 0.1109192583,
0.1138478602
);


pk_mx_yr_util_add1_firstseen2_mm := map(
pk_mx_yr_util_add1_firstseen2 = -1 => 0.1130627306,
pk_mx_yr_util_add1_firstseen2 = 0 => 0.1288670149,
pk_mx_yr_util_add1_firstseen2 = 1 => 0.1127518315,
pk_mx_yr_util_add1_firstseen2 = 2 => 0.1067228755,
0.1138478602
);


pk_yr_util_add2_D_firstseen2_mm := map(
pk_yr_util_add2_D_firstseen2 = -1 => 0.1151473916,
pk_yr_util_add2_D_firstseen2 = 1 => 0.0999525542,
0.1138478602
);


pk_yr_util_add2_E_firstseen2_mm := map(
pk_yr_util_add2_E_firstseen2 = -1 => 0.1129039575,
pk_yr_util_add2_E_firstseen2 = 0 => 0.1615720524,
pk_yr_util_add2_E_firstseen2 = 1 => 0.1468305304,
pk_yr_util_add2_E_firstseen2 = 2 => 0.1132121212,
pk_yr_util_add2_E_firstseen2 = 3 => 0.1154855643,
0.1138478602
);


pk_yr_util_add2_G_firstseen2_mm := map(
pk_yr_util_add2_G_firstseen2 = -1 => 0.1135300668,
pk_yr_util_add2_G_firstseen2 = 1 => 0.1247609943,
0.1138478602
);


pk_yr_util_add2_U_firstseen2_mm := map(
pk_yr_util_add2_U_firstseen2 = -1 => 0.1100400058,
pk_yr_util_add2_U_firstseen2 = 0 => 0.1153254741,
pk_yr_util_add2_U_firstseen2 = 1 => 0.1378850103,
0.1138478602
);


pk_yr_util_add2_Z_firstseen2_mm := map(
pk_yr_util_add2_Z_firstseen2 = -1 => 0.1123191661,
pk_yr_util_add2_Z_firstseen2 = 0 => 0.1290630975,
pk_yr_util_add2_Z_firstseen2 = 1 => 0.1142055779,
0.1138478602
);


pk_nap_type_mm := map(
pk_nap_type = 0 => 0.0930437335,
pk_nap_type = 1 => 0.1078354026,
pk_nap_type = 2 => 0.1313121653,
pk_nap_type = 3 => 0.1170385831,
0.1138478602
);


pk_EN_count_mm := map(
pk_EN_count = -1 => 0.1189251001,
pk_EN_count = 0 => 0.1099546957,
pk_EN_count = 1 => 0.1133327356,
pk_EN_count = 2 => 0.1156169901,
pk_EN_count = 3 => 0.1157249145,
0.1138478602
);


pk_dl_avail_mm := map(
pk_dl_avail = 0 => 0.1242317535,
pk_dl_avail = 1 => 0.0970188933,
0.1138478602
);


pk_DL_count_mm := map(
pk_DL_count = -1 => 0.1234147716,
pk_DL_count = 0 => 0.0990466549,
pk_DL_count = 1 => 0.097996357,
pk_DL_count = 2 => 0.0976352142,
pk_DL_count = 3 => 0.0946573751,
0.1138478602
);


pk_yr_adl_EN_first_seen2_mm := map(
pk_yr_adl_EN_first_seen2 = -1 => 0.1189251001,
pk_yr_adl_EN_first_seen2 = 14 => 0.1139821567,
pk_yr_adl_EN_first_seen2 = 15 => 0.111775254,
pk_yr_adl_EN_first_seen2 = 16 => 0.1075763148,
pk_yr_adl_EN_first_seen2 = 17 => 0.1168243521,
pk_yr_adl_EN_first_seen2 = 18 => 0.1133060854,
pk_yr_adl_EN_first_seen2 = 19 => 0.1109964927,
pk_yr_adl_EN_first_seen2 = 20 => 0.116502193,
pk_yr_adl_EN_first_seen2 = 21 => 0.109497389,
pk_yr_adl_EN_first_seen2 = 22 => 0.1184573003,
0.1138478602
);


pk_yr_adl_DL_first_seen2_mm := map(
pk_yr_adl_DL_first_seen2 = -9 => 0.1229914657,
pk_yr_adl_DL_first_seen2 = -1 => 0.0920245399,
pk_yr_adl_DL_first_seen2 = 0 => 0.0933899333,
pk_yr_adl_DL_first_seen2 = 1 => 0.0987648914,
0.1138478602
);






            // else if( pk_segment2 = 4 ) then /* 4 Unassigned       */
            else

				pk_nas_summary_mm := map(
				pk_nas_summary = 0 => 0.0798548094,
				pk_nas_summary = 1 => 0.0561622465,
				pk_nas_summary = 2 => 0.0825767939,
				0.0814586255
				);


				pk_nap_summary_mm := map(
				pk_nap_summary = -1 => 0.0596610169,
				pk_nap_summary = 0 => 0.06308324,
				pk_nap_summary = 1 => 0.1465844402,
				pk_nap_summary = 2 => 0.1074872377,
				0.0814586255
				);


				pk_rc_dirsaddr_lastscore_mm := map(
				pk_rc_dirsaddr_lastscore = -1 => 0.0627408802,
				pk_rc_dirsaddr_lastscore = 0 => 0.0705765408,
				pk_rc_dirsaddr_lastscore = 1 => 0.119047619,
				pk_rc_dirsaddr_lastscore = 2 => 0.1314616756,
				0.0814586255
				);


				pk_combo_hphonescore_mm := map(
				pk_combo_hphonescore = 0 => 0.0449334105,
				pk_combo_hphonescore = 1 => 0.0762711864,
				pk_combo_hphonescore = 2 => 0.1162918871,
				0.0814586255
				);


				pk_combo_dobscore_mm := map(
				pk_combo_dobscore = -1 => 0.0866290019,
				pk_combo_dobscore = 0 => 0,
				pk_combo_dobscore = 1 => 0.0846153846,
				pk_combo_dobscore = 2 => 0.0806377232,
				0.0814586255
				);


				pk_gong_did_first_ct_mm := map(
				pk_gong_did_first_ct = 0 => 0.0875175316,
				pk_gong_did_first_ct = 1 => 0.0774193548,
				0.0814586255
				);


				pk_rc_phonelnamecount_mm := map(
				pk_rc_phonelnamecount = 0 => 0.0557971549,
				pk_rc_phonelnamecount = 1 => 0.16322217,
				0.0814586255
				);


				pk_combo_addrcount_mm := map(
				pk_combo_addrcount = 0 => 0.0625431928,
				pk_combo_addrcount = 1 => 0.0786916331,
				pk_combo_addrcount = 2 => 0.0845910192,
				pk_combo_addrcount = 3 => 0.092156278,
				pk_combo_addrcount = 4 => 0.0883534137,
				0.0814586255
				);


				pk_rc_phoneaddrcount_mm := map(
				pk_rc_phoneaddrcount = 0 => 0.0571408138,
				pk_rc_phoneaddrcount = 1 => 0.1699635606,
				0.0814586255
				);


				pk_combo_hphonecount_mm := map(
				pk_combo_hphonecount = 0 => 0.0491711678,
				pk_combo_hphonecount = 1 => 0.1303795682,
				0.0814586255
				);


				pk_ver_phncount_mm := map(
				pk_ver_phncount = 0 => 0.051635514,
				pk_ver_phncount = 1 => 0.0869336143,
				pk_ver_phncount = 2 => 0.0838823718,
				pk_ver_phncount = 3 => 0.1074872377,
				0.0814586255
				);


				pk_gong_did_phone_ct_mm := map(
				pk_gong_did_phone_ct = -1 => 0.0867138072,
				pk_gong_did_phone_ct = 0 => 0.0750123376,
				pk_gong_did_phone_ct = 1 => 0.0870479394,
				pk_gong_did_phone_ct = 2 => 0.0694810906,
				pk_gong_did_phone_ct = 3 => 0.0647058824,
				0.0814586255
				);


				pk_combo_ssncount_mm := map(
				pk_combo_ssncount = -1 => 0.0799273388,
				pk_combo_ssncount = 0 => 0.0792682927,
				pk_combo_ssncount = 1 => 0.0816775654,
				0.0814586255
				);


				pk_eq_count_mm := map(
				pk_eq_count = 0 => 0.0799763033,
				pk_eq_count = 1 => 0.0843908629,
				pk_eq_count = 2 => 0.077540107,
				pk_eq_count = 3 => 0.0857933579,
				pk_eq_count = 4 => 0.0875356803,
				pk_eq_count = 5 => 0.0815701559,
				pk_eq_count = 6 => 0.0794780546,
				0.0814586255
				);


				pk_em_count_mm := map(
				pk_em_count = 0 => 0.0819412696,
				pk_em_count = 1 => 0.0906040268,
				pk_em_count = 2 => 0.0720253529,
				0.0814586255
				);


				pk_em_only_count_mm := map(
				pk_em_only_count = 0 => 0.0823228682,
				pk_em_only_count = 1 => 0.0776455855,
				pk_em_only_count = 2 => 0.0751789976,
				pk_em_only_count = 3 => 0.0676691729,
				0.0814586255
				);


				pk_pos_secondary_sources_mm := map(
				pk_pos_secondary_sources = 0 => 0.0810533516,
				pk_pos_secondary_sources = 1 => 0.1016949153,
				pk_pos_secondary_sources = 2 => 0.1104294479,
				0.0814586255
				);


				pk_voter_flag_mm := map(
				pk_voter_flag = -1 => 0.0690208668,
				pk_voter_flag = 0 => 0.0882661079,
				pk_voter_flag = 1 => 0.0806076577,
				0.0814586255
				);


				pk_fname_eda_sourced_type_lvl_mm := map(
				pk_fname_eda_sourced_type_lvl = 0 => 0.0710263269,
				pk_fname_eda_sourced_type_lvl = 1 => 0.0733863837,
				pk_fname_eda_sourced_type_lvl = 2 => 0.1129411765,
				pk_fname_eda_sourced_type_lvl = 3 => 0.1611721612,
				0.0814586255
				);


				pk_lname_eda_sourced_type_lvl_mm := map(
				pk_lname_eda_sourced_type_lvl = 0 => 0.0546974998,
				pk_lname_eda_sourced_type_lvl = 1 => 0.0627705628,
				pk_lname_eda_sourced_type_lvl = 2 => 0.1386206897,
				pk_lname_eda_sourced_type_lvl = 3 => 0.1759259259,
				0.0814586255
				);


				pk_add1_address_score_mm := map(
				pk_add1_address_score = 0 => 0.071468144,
				pk_add1_address_score = 1 => 0.0825842697,
				0.0814586255
				);


				pk_add2_pos_sources_mm := map(
				pk_add2_pos_sources = 0 => 0.0809206717,
				pk_add2_pos_sources = 1 => 0.081896046,
				pk_add2_pos_sources = 2 => 0.0787106447,
				pk_add2_pos_sources = 3 => 0.0913642053,
				pk_add2_pos_sources = 4 => 0.0651340996,
				0.0814586255
				);


				pk_ssnchar_invalid_or_recent_mm := map(
				pk_ssnchar_invalid_or_recent = 0 => 0.081775569,
				pk_ssnchar_invalid_or_recent = 1 => 0.0338983051,
				0.0814586255
				);


				pk_infutor_risk_lvl_mm := map(
				pk_infutor_risk_lvl = 0 => 0.1434159061,
				pk_infutor_risk_lvl = 1 => 0.06377858,
				pk_infutor_risk_lvl = 2 => 0.0533279056,
				0.0814586255
				);


				pk_yr_adl_eq_first_seen2_mm := map(
				pk_yr_adl_eq_first_seen2 = -1 => 0.0816091954,
				pk_yr_adl_eq_first_seen2 = 0 => 0.0491803279,
				pk_yr_adl_eq_first_seen2 = 1 => 0.1308411215,
				pk_yr_adl_eq_first_seen2 = 2 => 0.1213872832,
				pk_yr_adl_eq_first_seen2 = 3 => 0.0808950086,
				pk_yr_adl_eq_first_seen2 = 4 => 0.0724637681,
				pk_yr_adl_eq_first_seen2 = 5 => 0.0815850816,
				pk_yr_adl_eq_first_seen2 = 6 => 0.0813148789,
				pk_yr_adl_eq_first_seen2 = 7 => 0.0758064516,
				pk_yr_adl_eq_first_seen2 = 8 => 0.0776794494,
				pk_yr_adl_eq_first_seen2 = 9 => 0.0753275109,
				pk_yr_adl_eq_first_seen2 = 10 => 0.0850163755,
				0.0814586255
				);


				pk_yr_adl_em_first_seen2_mm := map(
				pk_yr_adl_em_first_seen2 = -1 => 0.0820503849,
				pk_yr_adl_em_first_seen2 = 0 => 0.0963855422,
				pk_yr_adl_em_first_seen2 = 1 => 0.0745033113,
				pk_yr_adl_em_first_seen2 = 2 => 0.0695652174,
				pk_yr_adl_em_first_seen2 = 3 => 0.0817688778,
				pk_yr_adl_em_first_seen2 = 4 => 0.0818584071,
				0.0814586255
				);


				pk_yr_adl_vo_first_seen2_mm := map(
				pk_yr_adl_vo_first_seen2 = -1 => 0.0815370953,
				pk_yr_adl_vo_first_seen2 = 0 => 0.0700636943,
				pk_yr_adl_vo_first_seen2 = 1 => 0.0784313725,
				pk_yr_adl_vo_first_seen2 = 2 => 0.072319202,
				pk_yr_adl_vo_first_seen2 = 3 => 0.0848004695,
				0.0814586255
				);


				pk_yr_adl_em_only_first_seen2_mm := map(
				pk_yr_adl_em_only_first_seen2 = -1 => 0.0824447334,
				pk_yr_adl_em_only_first_seen2 = 0 => 0.119047619,
				pk_yr_adl_em_only_first_seen2 = 1 => 0.0801687764,
				pk_yr_adl_em_only_first_seen2 = 2 => 0.0518518519,
				pk_yr_adl_em_only_first_seen2 = 3 => 0.0765445599,
				pk_yr_adl_em_only_first_seen2 = 4 => 0.0895522388,
				0.0814586255
				);


				pk_yr_lname_change_date2_mm := map(
				pk_yr_lname_change_date2 = -1 => 0.0809804157,
				pk_yr_lname_change_date2 = 0 => 0.0875,
				pk_yr_lname_change_date2 = 1 => 0.095890411,
				pk_yr_lname_change_date2 = 2 => 0.0781609195,
				0.0814586255
				);


				pk_yr_gong_did_first_seen2_mm := map(
				pk_yr_gong_did_first_seen2 = -1 => 0.0875175316,
				pk_yr_gong_did_first_seen2 = 0 => 0.134751773,
				pk_yr_gong_did_first_seen2 = 1 => 0.0828220859,
				pk_yr_gong_did_first_seen2 = 2 => 0.0878661088,
				pk_yr_gong_did_first_seen2 = 3 => 0.0862068966,
				pk_yr_gong_did_first_seen2 = 4 => 0.0753822959,
				0.0814586255
				);


				pk_yr_credit_first_seen2_mm := map(
				pk_yr_credit_first_seen2 = -1 => 0.0816091954,
				pk_yr_credit_first_seen2 = 0 => 0.0491803279,
				pk_yr_credit_first_seen2 = 1 => 0.1308411215,
				pk_yr_credit_first_seen2 = 2 => 0.1213872832,
				pk_yr_credit_first_seen2 = 3 => 0.0808950086,
				pk_yr_credit_first_seen2 = 4 => 0.0724637681,
				pk_yr_credit_first_seen2 = 5 => 0.0815850816,
				pk_yr_credit_first_seen2 = 6 => 0.0813148789,
				pk_yr_credit_first_seen2 = 7 => 0.0758064516,
				pk_yr_credit_first_seen2 = 8 => 0.0776794494,
				pk_yr_credit_first_seen2 = 9 => 0.0753275109,
				pk_yr_credit_first_seen2 = 10 => 0.0855002826,
				pk_yr_credit_first_seen2 = 11 => 0.0714285714,
				0.0814586255
				);


				pk_yr_header_first_seen2_mm := map(
				pk_yr_header_first_seen2 = -1 => 0.0867346939,
				pk_yr_header_first_seen2 = 0 => 0.1058823529,
				pk_yr_header_first_seen2 = 1 => 0.0926829268,
				pk_yr_header_first_seen2 = 2 => 0.0989010989,
				pk_yr_header_first_seen2 = 3 => 0.0769230769,
				pk_yr_header_first_seen2 = 4 => 0.0774368608,
				pk_yr_header_first_seen2 = 5 => 0.0822510823,
				pk_yr_header_first_seen2 = 6 => 0.077303989,
				pk_yr_header_first_seen2 = 7 => 0.0846976643,
				0.0814586255
				);


				pk_yr_infutor_first_seen2_mm := map(
				pk_yr_infutor_first_seen2 = -1 => 0.1434159061,
				pk_yr_infutor_first_seen2 = 0 => 0.1176470588,
				pk_yr_infutor_first_seen2 = 1 => 0.1025641026,
				pk_yr_infutor_first_seen2 = 2 => 0.0888754534,
				pk_yr_infutor_first_seen2 = 3 => 0.0667886551,
				pk_yr_infutor_first_seen2 = 4 => 0.0462412472,
				0.0814586255
				);


				pk_EM_Only_ver_lvl_mm := map(
				pk_EM_Only_ver_lvl = -1 => 0.0973451327,
				pk_EM_Only_ver_lvl = 0 => 0.0822043327,
				pk_EM_Only_ver_lvl = 1 => 0.0795135641,
				pk_EM_Only_ver_lvl = 2 => 0.0812807882,
				pk_EM_Only_ver_lvl = 3 => 0.0615942029,
				0.0814586255
				);


				pk_add2_EM_ver_lvl_mm := map(
				pk_add2_EM_ver_lvl = -1 => 0,
				pk_add2_EM_ver_lvl = 0 => 0.0820183804,
				pk_add2_EM_ver_lvl = 1 => 0.0818181818,
				pk_add2_EM_ver_lvl = 2 => 0.0526315789,
				0.0814586255
				);


				pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
				pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.0909090909,
				pk_yrmo_adl_f_sn_mx_fcra2 = 0 => 0,
				pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0.0808080808,
				pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.1428571429,
				pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0.0779220779,
				pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.1206030151,
				pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.1052631579,
				pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.0757575758,
				pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.0943396226,
				pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.0712166172,
				pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.0769230769,
				pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.0781741868,
				pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.0768688293,
				pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.0735027223,
				pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.0753623188,
				pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.0748603352,
				pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.0835797359,
				pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.0871997368,
				0.0814586255
				);


				pk_util_adl_source_count_mm := map(
				pk_util_adl_source_count = 0 => 0.0831613702,
				pk_util_adl_source_count = 1 => 0.0828277127,
				pk_util_adl_source_count = 2 => 0.0771965465,
				pk_util_adl_source_count = 3 => 0.0808597748,
				0.0814586255
				);


				pk_util_adl_sourced_mm := map(
				pk_util_adl_sourced = 0 => 0.0831613702,
				pk_util_adl_sourced = 1 => 0.0808228677,
				0.0814586255
				);


				pk_util_adl_count_mm := map(
				pk_util_adl_count = 0 => 0.0831613702,
				pk_util_adl_count = 1 => 0.080396155,
				pk_util_adl_count = 2 => 0.0823874039,
				pk_util_adl_count = 3 => 0.0790162219,
				pk_util_adl_count = 4 => 0.0770833333,
				pk_util_adl_count = 5 => 0.0825635104,
				0.0814586255
				);


				pk_util_adl_nap_mm := map(
				pk_util_adl_nap = -1 => 0.0828807081,
				pk_util_adl_nap = 0 => 0.0827227606,
				pk_util_adl_nap = 1 => 0.0774134791,
				0.0814586255
				);


				pk_util_add1_source_count_mm := map(
				pk_util_add1_source_count = 0 => 0.08117195,
				pk_util_add1_source_count = 1 => 0.0851800554,
				pk_util_add1_source_count = 2 => 0.0800715279,
				pk_util_add1_source_count = 3 => 0.0747933884,
				pk_util_add1_source_count = 4 => 0.0861865407,
				pk_util_add1_source_count = 5 => 0.0493273543,
				0.0814586255
				);


				pk_util_add1_nap_mm := map(
				pk_util_add1_nap = -1 => 0.0758967629,
				pk_util_add1_nap = 0 => 0.0807073955,
				pk_util_add1_nap = 1 => 0.0897272496,
				0.0814586255
				);


				pk_util_add2_source_count_mm := map(
				pk_util_add2_source_count = 0 => 0.0841219769,
				pk_util_add2_source_count = 1 => 0.078680203,
				pk_util_add2_source_count = 2 => 0.074795726,
				pk_util_add2_source_count = 3 => 0.0625869263,
				0.0814586255
				);


				pk_util_add2_nap_mm := map(
				pk_util_add2_nap = -1 => 0.0818614404,
				pk_util_add2_nap = 0 => 0.0819047619,
				pk_util_add2_nap = 1 => 0.0713266762,
				0.0814586255
				);


				pk_rc_utiliaddr_phonecount_mm := map(
				pk_rc_utiliaddr_phonecount = 0 => 0.0786811267,
				pk_rc_utiliaddr_phonecount = 1 => 0.0907978463,
				0.0814586255
				);


				pk_utility_sourced_mm := map(
				pk_utility_sourced = 0 => 0.0791490828,
				pk_utility_sourced = 1 => 0.0857740586,
				0.0814586255
				);


				pk_yr_util_adl_D_firstseen2_mm := map(
				pk_yr_util_adl_D_firstseen2 = -1 => 0.083463136,
				pk_yr_util_adl_D_firstseen2 = 0 => 0.0731707317,
				pk_yr_util_adl_D_firstseen2 = 1 => 0.0685224839,
				0.0814586255
				);


				pk_yr_util_adl_E_firstseen2_mm := map(
				pk_yr_util_adl_E_firstseen2 = -1 => 0.0806860732,
				pk_yr_util_adl_E_firstseen2 = 0 => 0.0657894737,
				pk_yr_util_adl_E_firstseen2 = 1 => 0.1333333333,
				pk_yr_util_adl_E_firstseen2 = 2 => 0.0963855422,
				pk_yr_util_adl_E_firstseen2 = 3 => 0.1196581197,
				pk_yr_util_adl_E_firstseen2 = 4 => 0.085106383,
				pk_yr_util_adl_E_firstseen2 = 5 => 0.0810810811,
				pk_yr_util_adl_E_firstseen2 = 6 => 0.1101694915,
				pk_yr_util_adl_E_firstseen2 = 7 => 0.0734463277,
				0.0814586255
				);


				pk_yr_util_adl_F_firstseen2_mm := map(
				pk_yr_util_adl_F_firstseen2 = -1 => 0.0859161827,
				pk_yr_util_adl_F_firstseen2 = 0 => 0.0839694656,
				pk_yr_util_adl_F_firstseen2 = 1 => 0.0750853242,
				pk_yr_util_adl_F_firstseen2 = 2 => 0.0614543115,
				0.0814586255
				);


				pk_yr_util_adl_G_firstseen2_mm := map(
				pk_yr_util_adl_G_firstseen2 = -1 => 0.0817058589,
				pk_yr_util_adl_G_firstseen2 = 0 => 0,
				pk_yr_util_adl_G_firstseen2 = 1 => 0.078125,
				pk_yr_util_adl_G_firstseen2 = 2 => 0.0384615385,
				0.0814586255
				);


				pk_yr_util_adl_I_firstseen2_mm := map(
				pk_yr_util_adl_I_firstseen2 = -1 => 0.0822286143,
				pk_yr_util_adl_I_firstseen2 = 0 => 0.1103896104,
				pk_yr_util_adl_I_firstseen2 = 1 => 0.0881226054,
				pk_yr_util_adl_I_firstseen2 = 2 => 0.0639585134,
				0.0814586255
				);


				pk_yr_util_adl_U_firstseen2_mm := map(
				pk_yr_util_adl_U_firstseen2 = -1 => 0.0775151515,
				pk_yr_util_adl_U_firstseen2 = 0 => 0.1636363636,
				pk_yr_util_adl_U_firstseen2 = 1 => 0.1504424779,
				pk_yr_util_adl_U_firstseen2 = 2 => 0.1640625,
				pk_yr_util_adl_U_firstseen2 = 3 => 0.1161440186,
				0.0814586255
				);


				pk_mx_yr_util_adl_firstseen2_mm := map(
				pk_mx_yr_util_adl_firstseen2 = -1 => 0.0831613702,
				pk_mx_yr_util_adl_firstseen2 = 0 => 0.0983050847,
				pk_mx_yr_util_adl_firstseen2 = 1 => 0.10041841,
				pk_mx_yr_util_adl_firstseen2 = 2 => 0.0879478827,
				pk_mx_yr_util_adl_firstseen2 = 3 => 0.0765503876,
				pk_mx_yr_util_adl_firstseen2 = 4 => 0.0823974609,
				pk_mx_yr_util_adl_firstseen2 = 5 => 0.0692567568,
				0.0814586255
				);


				pk_yr_util_add1_E_firstseen2_mm := map(
				pk_yr_util_add1_E_firstseen2 = -1 => 0.0823830721,
				pk_yr_util_add1_E_firstseen2 = 0 => 0.0736377025,
				pk_yr_util_add1_E_firstseen2 = 1 => 0.0682730924,
				0.0814586255
				);


				pk_yr_util_add1_F_firstseen2_mm := map(
				pk_yr_util_add1_F_firstseen2 = -1 => 0.0861470262,
				pk_yr_util_add1_F_firstseen2 = 0 => 0.0843373494,
				pk_yr_util_add1_F_firstseen2 = 1 => 0.0659553831,
				0.0814586255
				);


				pk_yr_util_add1_I_firstseen2_mm := map(
				pk_yr_util_add1_I_firstseen2 = -1 => 0.0826569264,
				pk_yr_util_add1_I_firstseen2 = 0 => 0.0731132075,
				pk_yr_util_add1_I_firstseen2 = 1 => 0.0854271357,
				pk_yr_util_add1_I_firstseen2 = 2 => 0.0733662145,
				pk_yr_util_add1_I_firstseen2 = 3 => 0.0603015075,
				0.0814586255
				);


				pk_yr_util_add1_U_firstseen2_mm := map(
				pk_yr_util_add1_U_firstseen2 = -1 => 0.0777215864,
				pk_yr_util_add1_U_firstseen2 = 0 => 0.1092436975,
				pk_yr_util_add1_U_firstseen2 = 1 => 0.0947580645,
				0.0814586255
				);


				pk_yr_util_add1_V_firstseen2_mm := map(
				pk_yr_util_add1_V_firstseen2 = -1 => 0.0814840105,
				pk_yr_util_add1_V_firstseen2 = 1 => 0.0796812749,
				0.0814586255
				);


				pk_yr_util_add1_Z_firstseen2_mm := map(
				pk_yr_util_add1_Z_firstseen2 = -1 => 0.0846384538,
				pk_yr_util_add1_Z_firstseen2 = 0 => 0.096079124,
				pk_yr_util_add1_Z_firstseen2 = 1 => 0.0772117068,
				0.0814586255
				);


				pk_mx_yr_util_add1_firstseen2_mm := map(
				pk_mx_yr_util_add1_firstseen2 = -1 => 0.08117195,
				pk_mx_yr_util_add1_firstseen2 = 0 => 0.0964489259,
				pk_mx_yr_util_add1_firstseen2 = 1 => 0.0809939302,
				pk_mx_yr_util_add1_firstseen2 = 2 => 0.0716244003,
				0.0814586255
				);


				pk_yr_util_add2_D_firstseen2_mm := map(
				pk_yr_util_add2_D_firstseen2 = -1 => 0.081245483,
				pk_yr_util_add2_D_firstseen2 = 1 => 0.0843570844,
				0.0814586255
				);


				pk_yr_util_add2_E_firstseen2_mm := map(
				pk_yr_util_add2_E_firstseen2 = -1 => 0.082198385,
				pk_yr_util_add2_E_firstseen2 = 0 => 0.0606060606,
				pk_yr_util_add2_E_firstseen2 = 1 => 0.0549019608,
				pk_yr_util_add2_E_firstseen2 = 2 => 0.0834575261,
				pk_yr_util_add2_E_firstseen2 = 3 => 0.0588235294,
				0.0814586255
				);


				pk_yr_util_add2_G_firstseen2_mm := map(
				pk_yr_util_add2_G_firstseen2 = -1 => 0.0815347722,
				pk_yr_util_add2_G_firstseen2 = 1 => 0.077170418,
				0.0814586255
				);


				pk_yr_util_add2_U_firstseen2_mm := map(
				pk_yr_util_add2_U_firstseen2 = -1 => 0.0812157135,
				pk_yr_util_add2_U_firstseen2 = 0 => 0.0694789082,
				pk_yr_util_add2_U_firstseen2 = 1 => 0.0870121561,
				0.0814586255
				);


				pk_yr_util_add2_Z_firstseen2_mm := map(
				pk_yr_util_add2_Z_firstseen2 = -1 => 0.083309517,
				pk_yr_util_add2_Z_firstseen2 = 0 => 0.0931372549,
				pk_yr_util_add2_Z_firstseen2 = 1 => 0.0800150617,
				0.0814586255
				);


				pk_nap_type_mm := map(
				pk_nap_type = 0 => 0.0372071658,
				pk_nap_type = 1 => 0.0450656018,
				pk_nap_type = 2 => 0.0664819945,
				pk_nap_type = 3 => 0.1368760064,
				0.0814586255
				);


				pk_EN_count_mm := map(
				pk_EN_count = -1 => 0.075443038,
				pk_EN_count = 0 => 0.0846752307,
				pk_EN_count = 1 => 0.081289557,
				pk_EN_count = 2 => 0.0823780325,
				pk_EN_count = 3 => 0.0758575198,
				0.0814586255
				);


				pk_dl_avail_mm := map(
				pk_dl_avail = 0 => 0.084551931,
				pk_dl_avail = 1 => 0.0768478413,
				0.0814586255
				);


				pk_DL_count_mm := map(
				pk_DL_count = -1 => 0.0834262197,
				pk_DL_count = 0 => 0.0799232737,
				pk_DL_count = 1 => 0.0724081185,
				pk_DL_count = 2 => 0.0745428973,
				pk_DL_count = 3 => 0.088,
				0.0814586255
				);


				pk_yr_adl_EN_first_seen2_mm := map(
				pk_yr_adl_EN_first_seen2 = -1 => 0.075443038,
				pk_yr_adl_EN_first_seen2 = 14 => 0.0808172121,
				pk_yr_adl_EN_first_seen2 = 15 => 0.0972364381,
				pk_yr_adl_EN_first_seen2 = 16 => 0.081300813,
				pk_yr_adl_EN_first_seen2 = 17 => 0.081027668,
				pk_yr_adl_EN_first_seen2 = 18 => 0.0717299578,
				pk_yr_adl_EN_first_seen2 = 19 => 0.0673788003,
				pk_yr_adl_EN_first_seen2 = 20 => 0.0820980616,
				pk_yr_adl_EN_first_seen2 = 21 => 0.0765370138,
				pk_yr_adl_EN_first_seen2 = 22 => 0.0947042907,
				0.0814586255
				);


				pk_yr_adl_DL_first_seen2_mm := map(
				pk_yr_adl_DL_first_seen2 = -9 => 0.0832068791,
				pk_yr_adl_DL_first_seen2 = -1 => 0.0802469136,
				pk_yr_adl_DL_first_seen2 = 0 => 0.0811170213,
				pk_yr_adl_DL_first_seen2 = 1 => 0.0774410774,
				0.0814586255
				);

			end;
		end;

if ( not add1_isbestmatch  ) then /* Address 1 is Not Best Match */

   if(       pk_segment2 = 1 ) then /* 1 EDA              */



pk_nas_summary_mm := map(
pk_nas_summary = 0 => 0.3064770932,
pk_nas_summary = 1 => 0.2535211268,
pk_nas_summary = 2 => 0.2570786517,
0.2606635071
);


pk_nap_summary_mm := map(
pk_nap_summary = -1 => 0.2857142857,
pk_nap_summary = 0 => 0.2691481747,
pk_nap_summary = 1 => 0.268772348,
pk_nap_summary = 2 => 0.247637051,
0.2606635071
);


pk_rc_dirsaddr_lastscore_mm := map(
pk_rc_dirsaddr_lastscore = -1 => 0.2727272727,
pk_rc_dirsaddr_lastscore = 0 => 0.2900688299,
pk_rc_dirsaddr_lastscore = 1 => 0.3,
pk_rc_dirsaddr_lastscore = 2 => 0.2497547577,
0.2606635071
);


pk_combo_hphonescore_mm := map(
pk_combo_hphonescore = 0 => 0.243697479,
pk_combo_hphonescore = 1 => 0.1891891892,
pk_combo_hphonescore = 2 => 0.2612566777,
0.2606635071
);


pk_combo_dobscore_mm := map(
pk_combo_dobscore = -1 => 0.3007945516,
pk_combo_dobscore = 0 => 1,
pk_combo_dobscore = 1 => 0.2222222222,
pk_combo_dobscore = 2 => 0.2567371776,
0.2606635071
);


pk_gong_did_first_ct_mm := map(
pk_gong_did_first_ct = 0 => 0.2879858657,
pk_gong_did_first_ct = 1 => 0.2533227848,
0.2606635071
);


pk_combo_lnamecount_nb_mm := map(
pk_combo_lnamecount_nb = 0 => 0.3157894737,
pk_combo_lnamecount_nb = 1 => 0.3571428571,
pk_combo_lnamecount_nb = 2 => 0.2587719298,
pk_combo_lnamecount_nb = 3 => 0.2147651007,
pk_combo_lnamecount_nb = 4 => 0.2381615599,
pk_combo_lnamecount_nb = 5 => 0.2653508772,
pk_combo_lnamecount_nb = 6 => 0.2595510043,
0.2606635071
);


pk_rc_phonelnamecount_mm := map(
pk_rc_phonelnamecount = 0 => 0.3043478261,
pk_rc_phonelnamecount = 1 => 0.2565502183,
0.2606635071
);


pk_combo_addrcount_nb_mm := map(
pk_combo_addrcount_nb = 0 => 0.3022774327,
pk_combo_addrcount_nb = 1 => 0.2684824903,
pk_combo_addrcount_nb = 2 => 0.2130822597,
pk_combo_addrcount_nb = 3 => 0.2316109422,
pk_combo_addrcount_nb = 4 => 0.2957746479,
pk_combo_addrcount_nb = 5 => 0.3541944075,
0.2606635071
);


pk_rc_phoneaddrcount_mm := map(
pk_rc_phoneaddrcount = 0 => 0.2783718524,
pk_rc_phoneaddrcount = 1 => 0.2506348896,
0.2606635071
);


pk_combo_hphonecount_mm := map(
pk_combo_hphonecount = 0 => 0.2619047619,
pk_combo_hphonecount = 1 => 0.260630123,
0.2606635071
);


pk_ver_phncount_mm := map(
pk_ver_phncount = 0 => 0.2934782609,
pk_ver_phncount = 1 => 0.2720930233,
pk_ver_phncount = 2 => 0.2674754477,
pk_ver_phncount = 3 => 0.247637051,
0.2606635071
);


pk_gong_did_phone_ct_nb_mm := map(
pk_gong_did_phone_ct_nb = -2 => 0.2849223947,
pk_gong_did_phone_ct_nb = -1 => 0.2962107209,
pk_gong_did_phone_ct_nb = 0 => 0.2623045744,
pk_gong_did_phone_ct_nb = 1 => 0.2122854562,
pk_gong_did_phone_ct_nb = 2 => 0.203125,
0.2606635071
);


pk_combo_ssncount_mm := map(
pk_combo_ssncount = -1 => 0.3069620253,
pk_combo_ssncount = 0 => 0.3484848485,
pk_combo_ssncount = 1 => 0.2558743169,
0.2606635071
);


pk_combo_dobcount_nb_mm := map(
pk_combo_dobcount_nb = 0 => 0.3015873016,
pk_combo_dobcount_nb = 1 => 0.1994535519,
pk_combo_dobcount_nb = 2 => 0.2009345794,
pk_combo_dobcount_nb = 3 => 0.2586872587,
pk_combo_dobcount_nb = 4 => 0.2693156733,
pk_combo_dobcount_nb = 5 => 0.277486911,
pk_combo_dobcount_nb = 6 => 0.2530345472,
pk_combo_dobcount_nb = 7 => 0.2584185582,
0.2606635071
);


pk_eq_count_mm := map(
pk_eq_count = 0 => 0.3167701863,
pk_eq_count = 1 => 0.2684563758,
pk_eq_count = 2 => 0.2669172932,
pk_eq_count = 3 => 0.2759493671,
pk_eq_count = 4 => 0.2577962578,
pk_eq_count = 5 => 0.2567447376,
pk_eq_count = 6 => 0.2461873638,
0.2606635071
);


pk_em_count_mm := map(
pk_em_count = 0 => 0.2674341377,
pk_em_count = 1 => 0.2698535081,
pk_em_count = 2 => 0.2413793103,
0.2606635071
);


pk_em_only_count_mm := map(
pk_em_only_count = 0 => 0.2592592593,
pk_em_only_count = 1 => 0.2653758542,
pk_em_only_count = 2 => 0.2610722611,
pk_em_only_count = 3 => 0.3333333333,
0.2606635071
);


pk_pos_secondary_sources_mm := map(
pk_pos_secondary_sources = 0 => 0.2596117244,
pk_pos_secondary_sources = 1 => 0.253968254,
pk_pos_secondary_sources = 2 => 0.3783783784,
0.2606635071
);


pk_voter_flag_mm := map(
pk_voter_flag = -1 => 0.2367668097,
pk_voter_flag = 0 => 0.2811798653,
pk_voter_flag = 1 => 0.2519280206,
0.2606635071
);


pk_fname_eda_sourced_type_lvl_mm := map(
pk_fname_eda_sourced_type_lvl = 0 => 0.2528985507,
pk_fname_eda_sourced_type_lvl = 1 => 0.2545454545,
pk_fname_eda_sourced_type_lvl = 2 => 0.2901425914,
pk_fname_eda_sourced_type_lvl = 3 => 0.2534653465,
0.2606635071
);


pk_lname_eda_sourced_type_lvl_mm := map(
pk_lname_eda_sourced_type_lvl = 0 => 0.3087557604,
pk_lname_eda_sourced_type_lvl = 1 => 0.2307692308,
pk_lname_eda_sourced_type_lvl = 2 => 0.2700460829,
pk_lname_eda_sourced_type_lvl = 3 => 0.2508724312,
0.2606635071
);


pk_add1_address_score_mm := map(
pk_add1_address_score = 0 => 0.2698695136,
pk_add1_address_score = 1 => 0.2582122552,
0.2606635071
);


pk_add2_pos_sources_mm := map(
pk_add2_pos_sources = 0 => 0.2767410105,
pk_add2_pos_sources = 1 => 0.2561258705,
pk_add2_pos_sources = 2 => 0.197586727,
pk_add2_pos_sources = 3 => 0.2809224319,
pk_add2_pos_sources = 4 => 0.2752293578,
0.2606635071
);


pk_ssnchar_invalid_or_recent_mm := map(
pk_ssnchar_invalid_or_recent = 0 => 0.2607553777,
pk_ssnchar_invalid_or_recent = 1 => 0.2272727273,
0.2606635071
);


pk_infutor_risk_lvl_nb_mm := map(
pk_infutor_risk_lvl_nb = 0 => 0.2749003984,
pk_infutor_risk_lvl_nb = 1 => 0.2634861241,
pk_infutor_risk_lvl_nb = 2 => 0.2470187394,
pk_infutor_risk_lvl_nb = 3 => 0.2428198433,
0.2606635071
);


pk_yr_adl_eq_first_seen2_mm := map(
pk_yr_adl_eq_first_seen2 = -1 => 0.3198051948,
pk_yr_adl_eq_first_seen2 = 0 => 0.1666666667,
pk_yr_adl_eq_first_seen2 = 1 => 0.2727272727,
pk_yr_adl_eq_first_seen2 = 2 => 0.3559322034,
pk_yr_adl_eq_first_seen2 = 3 => 0.2378640777,
pk_yr_adl_eq_first_seen2 = 4 => 0.1676300578,
pk_yr_adl_eq_first_seen2 = 5 => 0.2055555556,
pk_yr_adl_eq_first_seen2 = 6 => 0.212890625,
pk_yr_adl_eq_first_seen2 = 7 => 0.2119205298,
pk_yr_adl_eq_first_seen2 = 8 => 0.2375851996,
pk_yr_adl_eq_first_seen2 = 9 => 0.2632978723,
pk_yr_adl_eq_first_seen2 = 10 => 0.2987012987,
0.2606635071
);


pk_yr_adl_em_first_seen2_mm := map(
pk_yr_adl_em_first_seen2 = -1 => 0.267562211,
pk_yr_adl_em_first_seen2 = 0 => 0.2142857143,
pk_yr_adl_em_first_seen2 = 1 => 0.2085714286,
pk_yr_adl_em_first_seen2 = 2 => 0.2475247525,
pk_yr_adl_em_first_seen2 = 3 => 0.2555850057,
pk_yr_adl_em_first_seen2 = 4 => 0.2850877193,
0.2606635071
);


pk_yr_adl_vo_first_seen2_mm := map(
pk_yr_adl_vo_first_seen2 = -1 => 0.2692543412,
pk_yr_adl_vo_first_seen2 = 0 => 0.1809045226,
pk_yr_adl_vo_first_seen2 = 1 => 0.2288503254,
pk_yr_adl_vo_first_seen2 = 2 => 0.2362385321,
pk_yr_adl_vo_first_seen2 = 3 => 0.2694763729,
0.2606635071
);


pk_yr_adl_em_only_first_seen2_mm := map(
pk_yr_adl_em_only_first_seen2 = -1 => 0.2589392133,
pk_yr_adl_em_only_first_seen2 = 0 => 0.24,
pk_yr_adl_em_only_first_seen2 = 1 => 0.3119266055,
pk_yr_adl_em_only_first_seen2 = 2 => 0.29,
pk_yr_adl_em_only_first_seen2 = 3 => 0.2634615385,
pk_yr_adl_em_only_first_seen2 = 4 => 0.28125,
0.2606635071
);


pk_yr_lname_change_date2_mm := map(
pk_yr_lname_change_date2 = -1 => 0.2614516341,
pk_yr_lname_change_date2 = 0 => 0.25,
pk_yr_lname_change_date2 = 1 => 0.2407407407,
pk_yr_lname_change_date2 = 2 => 0.2523364486,
0.2606635071
);


pk_yr_gong_did_first_seen2_mm := map(
pk_yr_gong_did_first_seen2 = -1 => 0.2879858657,
pk_yr_gong_did_first_seen2 = 0 => 0.3758389262,
pk_yr_gong_did_first_seen2 = 1 => 0.2476190476,
pk_yr_gong_did_first_seen2 = 2 => 0.2006688963,
pk_yr_gong_did_first_seen2 = 3 => 0.2397476341,
pk_yr_gong_did_first_seen2 = 4 => 0.2538821328,
0.2606635071
);


pk_yr_credit_first_seen2_mm := map(
pk_yr_credit_first_seen2 = -1 => 0.3198051948,
pk_yr_credit_first_seen2 = 0 => 0.1666666667,
pk_yr_credit_first_seen2 = 1 => 0.2727272727,
pk_yr_credit_first_seen2 = 2 => 0.3559322034,
pk_yr_credit_first_seen2 = 3 => 0.2378640777,
pk_yr_credit_first_seen2 = 4 => 0.1676300578,
pk_yr_credit_first_seen2 = 5 => 0.2055555556,
pk_yr_credit_first_seen2 = 6 => 0.212890625,
pk_yr_credit_first_seen2 = 7 => 0.2119205298,
pk_yr_credit_first_seen2 = 8 => 0.2375851996,
pk_yr_credit_first_seen2 = 9 => 0.2632978723,
pk_yr_credit_first_seen2 = 10 => 0.2976529161,
pk_yr_credit_first_seen2 = 11 => 0.3245614035,
0.2606635071
);


pk_yr_header_first_seen2_mm := map(
pk_yr_header_first_seen2 = -1 => 0.2888601036,
pk_yr_header_first_seen2 = 0 => 0.2647058824,
pk_yr_header_first_seen2 = 1 => 0.2424242424,
pk_yr_header_first_seen2 = 2 => 0.2767295597,
pk_yr_header_first_seen2 = 3 => 0.2342342342,
pk_yr_header_first_seen2 = 4 => 0.2141687142,
pk_yr_header_first_seen2 = 5 => 0.264849075,
pk_yr_header_first_seen2 = 6 => 0.2682611506,
pk_yr_header_first_seen2 = 7 => 0.3021505376,
0.2606635071
);


pk_yr_infutor_first_seen2_mm := map(
pk_yr_infutor_first_seen2 = -1 => 0.2634861241,
pk_yr_infutor_first_seen2 = 0 => 0.1666666667,
pk_yr_infutor_first_seen2 = 1 => 0.2234636872,
pk_yr_infutor_first_seen2 = 2 => 0.2393162393,
pk_yr_infutor_first_seen2 = 3 => 0.2791327913,
pk_yr_infutor_first_seen2 = 4 => 0.25,
0.2606635071
);


pk_EM_Only_ver_lvl_mm := map(
pk_EM_Only_ver_lvl = -1 => 0.3361344538,
pk_EM_Only_ver_lvl = 0 => 0.259181532,
pk_EM_Only_ver_lvl = 1 => 0.2492537313,
pk_EM_Only_ver_lvl = 2 => 0.2695924765,
pk_EM_Only_ver_lvl = 3 => 0.2845188285,
0.2606635071
);


pk_add2_EM_ver_lvl_mm := map(
pk_add2_EM_ver_lvl = -1 => 0.3333333333,
pk_add2_EM_ver_lvl = 0 => 0.2596265293,
pk_add2_EM_ver_lvl = 1 => 0.2708333333,
pk_add2_EM_ver_lvl = 2 => 0.2992125984,
0.2606635071
);


pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.3185840708,
pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0.1428571429,
pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.5,
pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0.125,
pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.3018867925,
pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.2962962963,
pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.3076923077,
pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.1967213115,
pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.1733333333,
pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.2103658537,
pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.2028824834,
pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.2096128171,
pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.1978798587,
pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.2548638132,
pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.2587776333,
pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.2962264151,
pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.3045078197,
0.2606635071
);


pk_util_adl_source_count_mm := map(
pk_util_adl_source_count = 0 => 0.3209509658,
pk_util_adl_source_count = 1 => 0.2844461598,
pk_util_adl_source_count = 2 => 0.233772572,
pk_util_adl_source_count = 3 => 0.217519685,
0.2606635071
);


pk_util_adl_sourced_mm := map(
pk_util_adl_sourced = 0 => 0.3209509658,
pk_util_adl_sourced = 1 => 0.248501199,
0.2606635071
);


pk_util_adl_count_mm := map(
pk_util_adl_count = 0 => 0.3209509658,
pk_util_adl_count = 1 => 0.2827586207,
pk_util_adl_count = 2 => 0.2951289398,
pk_util_adl_count = 3 => 0.247446084,
pk_util_adl_count = 4 => 0.2469959947,
pk_util_adl_count = 5 => 0.2211409396,
0.2606635071
);


pk_util_adl_nap_mm := map(
pk_util_adl_nap = -1 => 0.3181818182,
pk_util_adl_nap = 0 => 0.2455413439,
pk_util_adl_nap = 1 => 0.2634560907,
0.2606635071
);


pk_util_add1_source_count_mm := map(
pk_util_add1_source_count = 0 => 0.3125,
pk_util_add1_source_count = 1 => 0.2747289973,
pk_util_add1_source_count = 2 => 0.2627504554,
pk_util_add1_source_count = 3 => 0.2245862884,
pk_util_add1_source_count = 4 => 0.1909090909,
pk_util_add1_source_count = 5 => 0.2245989305,
0.2606635071
);


pk_util_add1_nap_mm := map(
pk_util_add1_nap = -1 => 0.2634836428,
pk_util_add1_nap = 0 => 0.2525361537,
pk_util_add1_nap = 1 => 0.2885129118,
0.2606635071
);


pk_util_add2_source_count_mm := map(
pk_util_add2_source_count = 0 => 0.2821614289,
pk_util_add2_source_count = 1 => 0.2337938363,
pk_util_add2_source_count = 2 => 0.2242817424,
pk_util_add2_source_count = 3 => 0.2523659306,
0.2606635071
);


pk_util_add2_nap_mm := map(
pk_util_add2_nap = -1 => 0.2697640477,
pk_util_add2_nap = 0 => 0.2382608696,
pk_util_add2_nap = 1 => 0.3479212254,
0.2606635071
);


pk_rc_utiliaddr_phonecount_mm := map(
pk_rc_utiliaddr_phonecount = 0 => 0.253112641,
pk_rc_utiliaddr_phonecount = 1 => 0.3039462636,
0.2606635071
);


pk_utility_sourced_mm := map(
pk_utility_sourced = 0 => 0.260341556,
pk_utility_sourced = 1 => 0.2612809316,
0.2606635071
);


pk_yr_util_adl_D_firstseen2_mm := map(
pk_yr_util_adl_D_firstseen2 = -1 => 0.2716201634,
pk_yr_util_adl_D_firstseen2 = 0 => 0.2727272727,
pk_yr_util_adl_D_firstseen2 = 1 => 0.2116040956,
0.2606635071
);


pk_yr_util_adl_E_firstseen2_mm := map(
pk_yr_util_adl_E_firstseen2 = -1 => 0.263375702,
pk_yr_util_adl_E_firstseen2 = 0 => 0.2802547771,
pk_yr_util_adl_E_firstseen2 = 1 => 0.225,
pk_yr_util_adl_E_firstseen2 = 2 => 0.2666666667,
pk_yr_util_adl_E_firstseen2 = 3 => 0.2736842105,
pk_yr_util_adl_E_firstseen2 = 4 => 0.2578125,
pk_yr_util_adl_E_firstseen2 = 5 => 0.2281879195,
pk_yr_util_adl_E_firstseen2 = 6 => 0.2523364486,
pk_yr_util_adl_E_firstseen2 = 7 => 0.2212389381,
0.2606635071
);


pk_yr_util_adl_F_firstseen2_mm := map(
pk_yr_util_adl_F_firstseen2 = -1 => 0.2765957447,
pk_yr_util_adl_F_firstseen2 = 0 => 0.2824858757,
pk_yr_util_adl_F_firstseen2 = 1 => 0.251396648,
pk_yr_util_adl_F_firstseen2 = 2 => 0.2105263158,
0.2606635071
);


pk_yr_util_adl_G_firstseen2_mm := map(
pk_yr_util_adl_G_firstseen2 = -1 => 0.2600104004,
pk_yr_util_adl_G_firstseen2 = 0 => 0.2985074627,
pk_yr_util_adl_G_firstseen2 = 1 => 0.2657657658,
pk_yr_util_adl_G_firstseen2 = 2 => 0.2972972973,
0.2606635071
);


pk_yr_util_adl_I_firstseen2_mm := map(
pk_yr_util_adl_I_firstseen2 = -1 => 0.2742764801,
pk_yr_util_adl_I_firstseen2 = 0 => 0.2054794521,
pk_yr_util_adl_I_firstseen2 = 1 => 0.1734417344,
pk_yr_util_adl_I_firstseen2 = 2 => 0.1829855538,
0.2606635071
);


pk_yr_util_adl_U_firstseen2_mm := map(
pk_yr_util_adl_U_firstseen2 = -1 => 0.2601759356,
pk_yr_util_adl_U_firstseen2 = 0 => 0.3552123552,
pk_yr_util_adl_U_firstseen2 = 1 => 0.2851405622,
pk_yr_util_adl_U_firstseen2 = 2 => 0.2556390977,
pk_yr_util_adl_U_firstseen2 = 3 => 0.2208955224,
0.2606635071
);


pk_mx_yr_util_adl_firstseen2_mm := map(
pk_mx_yr_util_adl_firstseen2 = -1 => 0.3209509658,
pk_mx_yr_util_adl_firstseen2 = 0 => 0.324137931,
pk_mx_yr_util_adl_firstseen2 = 1 => 0.3507109005,
pk_mx_yr_util_adl_firstseen2 = 2 => 0.3118644068,
pk_mx_yr_util_adl_firstseen2 = 3 => 0.2717391304,
pk_mx_yr_util_adl_firstseen2 = 4 => 0.2428167687,
pk_mx_yr_util_adl_firstseen2 = 5 => 0.2197718631,
0.2606635071
);


pk_yr_util_add1_E_firstseen2_mm := map(
pk_yr_util_add1_E_firstseen2 = -1 => 0.2657802659,
pk_yr_util_add1_E_firstseen2 = 0 => 0.226635514,
pk_yr_util_add1_E_firstseen2 = 1 => 0.2112359551,
0.2606635071
);


pk_yr_util_add1_F_firstseen2_mm := map(
pk_yr_util_add1_F_firstseen2 = -1 => 0.2745164003,
pk_yr_util_add1_F_firstseen2 = 0 => 0.2173913043,
pk_yr_util_add1_F_firstseen2 = 1 => 0.2211886305,
0.2606635071
);


pk_yr_util_add1_I_firstseen2_mm := map(
pk_yr_util_add1_I_firstseen2 = -1 => 0.2706280788,
pk_yr_util_add1_I_firstseen2 = 0 => 0.2281879195,
pk_yr_util_add1_I_firstseen2 = 1 => 0.2300884956,
pk_yr_util_add1_I_firstseen2 = 2 => 0.2065527066,
pk_yr_util_add1_I_firstseen2 = 3 => 0.2142857143,
0.2606635071
);


pk_yr_util_add1_U_firstseen2_mm := map(
pk_yr_util_add1_U_firstseen2 = -1 => 0.2630441494,
pk_yr_util_add1_U_firstseen2 = 0 => 0.26953125,
pk_yr_util_add1_U_firstseen2 = 1 => 0.231865285,
0.2606635071
);


pk_yr_util_add1_V_firstseen2_mm := map(
pk_yr_util_add1_V_firstseen2 = -1 => 0.2616301179,
pk_yr_util_add1_V_firstseen2 = 1 => 0.2015503876,
0.2606635071
);


pk_yr_util_add1_Z_firstseen2_mm := map(
pk_yr_util_add1_Z_firstseen2 = -1 => 0.292921074,
pk_yr_util_add1_Z_firstseen2 = 0 => 0.2831086439,
pk_yr_util_add1_Z_firstseen2 = 1 => 0.2483719247,
0.2606635071
);


pk_mx_yr_util_add1_firstseen2_mm := map(
pk_mx_yr_util_add1_firstseen2 = -1 => 0.3125,
pk_mx_yr_util_add1_firstseen2 = 0 => 0.2729805014,
pk_mx_yr_util_add1_firstseen2 = 1 => 0.2515943222,
pk_mx_yr_util_add1_firstseen2 = 2 => 0.2491776316,
0.2606635071
);


pk_yr_util_add2_D_firstseen2_mm := map(
pk_yr_util_add2_D_firstseen2 = -1 => 0.262527533,
pk_yr_util_add2_D_firstseen2 = 1 => 0.2427055703,
0.2606635071
);


pk_yr_util_add2_E_firstseen2_mm := map(
pk_yr_util_add2_E_firstseen2 = -1 => 0.2610706278,
pk_yr_util_add2_E_firstseen2 = 0 => 0.3793103448,
pk_yr_util_add2_E_firstseen2 = 1 => 0.28125,
pk_yr_util_add2_E_firstseen2 = 2 => 0.2522522523,
pk_yr_util_add2_E_firstseen2 = 3 => 0.2304147465,
0.2606635071
);


pk_yr_util_add2_G_firstseen2_mm := map(
pk_yr_util_add2_G_firstseen2 = -1 => 0.259791961,
pk_yr_util_add2_G_firstseen2 = 1 => 0.29004329,
0.2606635071
);


pk_yr_util_add2_U_firstseen2_mm := map(
pk_yr_util_add2_U_firstseen2 = -1 => 0.2664468755,
pk_yr_util_add2_U_firstseen2 = 0 => 0.2319391635,
pk_yr_util_add2_U_firstseen2 = 1 => 0.2319778189,
0.2606635071
);


pk_yr_util_add2_Z_firstseen2_mm := map(
pk_yr_util_add2_Z_firstseen2 = -1 => 0.2888015717,
pk_yr_util_add2_Z_firstseen2 = 0 => 0.2378378378,
pk_yr_util_add2_Z_firstseen2 = 1 => 0.2515094014,
0.2606635071
);


pk_nap_type_mm := map(
pk_nap_type = 0 => 1,
pk_nap_type = 1 => 0.3333333333,
pk_nap_type = 2 => 0.2362204724,
pk_nap_type = 3 => 0.260935717,
0.2606635071
);


pk_EN_count_mm := map(
pk_EN_count = -1 => 0.3119402985,
pk_EN_count = 0 => 0.2804399057,
pk_EN_count = 1 => 0.2779469334,
pk_EN_count = 2 => 0.238959967,
pk_EN_count = 3 => 0.2261640798,
0.2606635071
);


pk_dl_avail_mm := map(
pk_dl_avail = 0 => 0.2845901639,
pk_dl_avail = 1 => 0.2288701714,
0.2606635071
);


pk_DL_count_mm := map(
pk_DL_count = -1 => 0.2917627332,
pk_DL_count = 0 => 0.2415219189,
pk_DL_count = 1 => 0.2306830907,
pk_DL_count = 2 => 0.2218370884,
pk_DL_count = 3 => 0.1267605634,
0.2606635071
);


pk_yr_adl_EN_first_seen2_mm := map(
pk_yr_adl_EN_first_seen2 = -1 => 0.3119402985,
pk_yr_adl_EN_first_seen2 = 14 => 0.2264656616,
pk_yr_adl_EN_first_seen2 = 15 => 0.2458100559,
pk_yr_adl_EN_first_seen2 = 16 => 0.229390681,
pk_yr_adl_EN_first_seen2 = 17 => 0.2306034483,
pk_yr_adl_EN_first_seen2 = 18 => 0.2643171806,
pk_yr_adl_EN_first_seen2 = 19 => 0.2744282744,
pk_yr_adl_EN_first_seen2 = 20 => 0.2840236686,
pk_yr_adl_EN_first_seen2 = 21 => 0.3216666667,
pk_yr_adl_EN_first_seen2 = 22 => 0.3190118153,
0.2606635071
);


pk_yr_adl_DL_first_seen2_mm := map(
pk_yr_adl_DL_first_seen2 = -9 => 0.2915895538,
pk_yr_adl_DL_first_seen2 = -1 => 0.2234042553,
pk_yr_adl_DL_first_seen2 = 0 => 0.1929824561,
pk_yr_adl_DL_first_seen2 = 1 => 0.2156273479,
0.2606635071
);


            elseif (pk_segment2 = 2 ) then /* 2 SkipTrace        */



pk_nas_summary_mm := map(
pk_nas_summary = 0 => 0.1655172414,
pk_nas_summary = 1 => 0.1883308715,
pk_nas_summary = 2 => 0.1531845177,
0.1578632479
);


pk_nap_summary_mm := map(
pk_nap_summary = -1 => 0.1323722149,
pk_nap_summary = 0 => 0.131833432,
pk_nap_summary = 1 => 0.1808136615,
pk_nap_summary = 2 => 0.1896186441,
0.1578632479
);


pk_rc_dirsaddr_lastscore_mm := map(
pk_rc_dirsaddr_lastscore = -1 => 0.141925585,
pk_rc_dirsaddr_lastscore = 0 => 0.1537789428,
pk_rc_dirsaddr_lastscore = 1 => 0.203125,
pk_rc_dirsaddr_lastscore = 2 => 0.1787765293,
0.1578632479
);


pk_combo_hphonescore_mm := map(
pk_combo_hphonescore = 0 => 0.100750268,
pk_combo_hphonescore = 1 => 0.0789473684,
pk_combo_hphonescore = 2 => 0.1631093299,
0.1578632479
);


pk_combo_dobscore_mm := map(
pk_combo_dobscore = -1 => 0.1624309392,
pk_combo_dobscore = 0 => 0,
pk_combo_dobscore = 1 => 0.15,
pk_combo_dobscore = 2 => 0.1577686188,
0.1578632479
);


pk_gong_did_first_ct_mm := map(
pk_gong_did_first_ct = 0 => 0.1585513078,
pk_gong_did_first_ct = 1 => 0.1576776994,
0.1578632479
);


pk_combo_lnamecount_nb_mm := map(
pk_combo_lnamecount_nb = 0 => 0.172541744,
pk_combo_lnamecount_nb = 1 => 0.19,
pk_combo_lnamecount_nb = 2 => 0.1568627451,
pk_combo_lnamecount_nb = 3 => 0.14160401,
pk_combo_lnamecount_nb = 4 => 0.149958575,
pk_combo_lnamecount_nb = 5 => 0.1634746922,
pk_combo_lnamecount_nb = 6 => 0.1583634846,
0.1578632479
);


pk_rc_phonelnamecount_mm := map(
pk_rc_phonelnamecount = 0 => 0.139050791,
pk_rc_phonelnamecount = 1 => 0.1627231663,
0.1578632479
);


pk_combo_addrcount_nb_mm := map(
pk_combo_addrcount_nb = 0 => 0.1804651163,
pk_combo_addrcount_nb = 1 => 0.1404707669,
pk_combo_addrcount_nb = 2 => 0.1485118134,
pk_combo_addrcount_nb = 3 => 0.158993576,
pk_combo_addrcount_nb = 4 => 0.2018828452,
pk_combo_addrcount_nb = 5 => 0.2098138748,
0.1578632479
);


pk_rc_phoneaddrcount_mm := map(
pk_rc_phoneaddrcount = 0 => 0.1380774032,
pk_rc_phoneaddrcount = 1 => 0.2008130081,
0.1578632479
);


pk_combo_hphonecount_mm := map(
pk_combo_hphonecount = 0 => 0.1161849711,
pk_combo_hphonecount = 1 => 0.1650952859,
0.1578632479
);


pk_ver_phncount_mm := map(
pk_ver_phncount = 0 => 0.1158974359,
pk_ver_phncount = 1 => 0.1366659023,
pk_ver_phncount = 2 => 0.1742627346,
pk_ver_phncount = 3 => 0.1896186441,
0.1578632479
);


pk_gong_did_phone_ct_nb_mm := map(
pk_gong_did_phone_ct_nb = -2 => 0.1594151213,
pk_gong_did_phone_ct_nb = -1 => 0.1756373938,
pk_gong_did_phone_ct_nb = 0 => 0.1555915721,
pk_gong_did_phone_ct_nb = 1 => 0.1514131898,
pk_gong_did_phone_ct_nb = 2 => 0.1320113314,
0.1578632479
);


pk_combo_ssncount_mm := map(
pk_combo_ssncount = -1 => 0.1655172414,
pk_combo_ssncount = 0 => 0.12,
pk_combo_ssncount = 1 => 0.1578039927,
0.1578632479
);


pk_combo_dobcount_nb_mm := map(
pk_combo_dobcount_nb = 0 => 0.1620727674,
pk_combo_dobcount_nb = 1 => 0.152173913,
pk_combo_dobcount_nb = 2 => 0.1433121019,
pk_combo_dobcount_nb = 3 => 0.1273148148,
pk_combo_dobcount_nb = 4 => 0.1716129032,
pk_combo_dobcount_nb = 5 => 0.1663879599,
pk_combo_dobcount_nb = 6 => 0.1550435866,
pk_combo_dobcount_nb = 7 => 0.1579925651,
0.1578632479
);


pk_eq_count_mm := map(
pk_eq_count = 0 => 0.17003367,
pk_eq_count = 1 => 0.1428571429,
pk_eq_count = 2 => 0.1489001692,
pk_eq_count = 3 => 0.1408450704,
pk_eq_count = 4 => 0.1407528642,
pk_eq_count = 5 => 0.1550433412,
pk_eq_count = 6 => 0.1665845244,
0.1578632479
);


pk_em_count_mm := map(
pk_em_count = 0 => 0.1637904468,
pk_em_count = 1 => 0.1632337796,
pk_em_count = 2 => 0.1429008568,
0.1578632479
);


pk_em_only_count_mm := map(
pk_em_only_count = 0 => 0.1614096373,
pk_em_only_count = 1 => 0.1385892116,
pk_em_only_count = 2 => 0.1289808917,
pk_em_only_count = 3 => 0.2089552239,
0.1578632479
);


pk_pos_secondary_sources_mm := map(
pk_pos_secondary_sources = 0 => 0.1573913043,
pk_pos_secondary_sources = 1 => 0.2178217822,
pk_pos_secondary_sources = 2 => 0.1515151515,
0.1578632479
);


pk_voter_flag_mm := map(
pk_voter_flag = -1 => 0.1542234332,
pk_voter_flag = 0 => 0.1675617615,
pk_voter_flag = 1 => 0.1504798464,
0.1578632479
);


pk_fname_eda_sourced_type_lvl_mm := map(
pk_fname_eda_sourced_type_lvl = 0 => 0.1458040319,
pk_fname_eda_sourced_type_lvl = 1 => 0.1268498943,
pk_fname_eda_sourced_type_lvl = 2 => 0.1647812971,
pk_fname_eda_sourced_type_lvl = 3 => 0.1916360294,
0.1578632479
);


pk_lname_eda_sourced_type_lvl_mm := map(
pk_lname_eda_sourced_type_lvl = 0 => 0.143812709,
pk_lname_eda_sourced_type_lvl = 1 => 0.1067961165,
pk_lname_eda_sourced_type_lvl = 2 => 0.1462107209,
pk_lname_eda_sourced_type_lvl = 3 => 0.1856995885,
0.1578632479
);


pk_add1_address_score_mm := map(
pk_add1_address_score = 0 => 0.1776235198,
pk_add1_address_score = 1 => 0.1526321479,
0.1578632479
);


pk_add2_pos_sources_mm := map(
pk_add2_pos_sources = 0 => 0.1447902571,
pk_add2_pos_sources = 1 => 0.1632194966,
pk_add2_pos_sources = 2 => 0.1416184971,
pk_add2_pos_sources = 3 => 0.1732979664,
pk_add2_pos_sources = 4 => 0.1715976331,
0.1578632479
);


pk_ssnchar_invalid_or_recent_mm := map(
pk_ssnchar_invalid_or_recent = 0 => 0.1579082726,
pk_ssnchar_invalid_or_recent = 1 => 0.1428571429,
0.1578632479
);


pk_infutor_risk_lvl_nb_mm := map(
pk_infutor_risk_lvl_nb = 0 => 0.1641025641,
pk_infutor_risk_lvl_nb = 1 => 0.1673396675,
pk_infutor_risk_lvl_nb = 2 => 0.152293578,
pk_infutor_risk_lvl_nb = 3 => 0.1203007519,
0.1578632479
);


pk_yr_adl_eq_first_seen2_mm := map(
pk_yr_adl_eq_first_seen2 = -1 => 0.1723518851,
pk_yr_adl_eq_first_seen2 = 0 => 0.125,
pk_yr_adl_eq_first_seen2 = 1 => 0.1034482759,
pk_yr_adl_eq_first_seen2 = 2 => 0.1791044776,
pk_yr_adl_eq_first_seen2 = 3 => 0.156996587,
pk_yr_adl_eq_first_seen2 = 4 => 0.130044843,
pk_yr_adl_eq_first_seen2 = 5 => 0.1554404145,
pk_yr_adl_eq_first_seen2 = 6 => 0.1413551402,
pk_yr_adl_eq_first_seen2 = 7 => 0.1416405199,
pk_yr_adl_eq_first_seen2 = 8 => 0.1462974112,
pk_yr_adl_eq_first_seen2 = 9 => 0.1705298013,
pk_yr_adl_eq_first_seen2 = 10 => 0.1715145436,
0.1578632479
);


pk_yr_adl_em_first_seen2_mm := map(
pk_yr_adl_em_first_seen2 = -1 => 0.1632965686,
pk_yr_adl_em_first_seen2 = 0 => 0.1074380165,
pk_yr_adl_em_first_seen2 = 1 => 0.1374207188,
pk_yr_adl_em_first_seen2 = 2 => 0.1573333333,
pk_yr_adl_em_first_seen2 = 3 => 0.1528136293,
pk_yr_adl_em_first_seen2 = 4 => 0.1580547112,
0.1578632479
);


pk_yr_adl_vo_first_seen2_mm := map(
pk_yr_adl_vo_first_seen2 = -1 => 0.1621583345,
pk_yr_adl_vo_first_seen2 = 0 => 0.125,
pk_yr_adl_vo_first_seen2 = 1 => 0.1393939394,
pk_yr_adl_vo_first_seen2 = 2 => 0.143812709,
pk_yr_adl_vo_first_seen2 = 3 => 0.1644482611,
0.1578632479
);


pk_yr_adl_em_only_first_seen2_mm := map(
pk_yr_adl_em_only_first_seen2 = -1 => 0.1614805776,
pk_yr_adl_em_only_first_seen2 = 0 => 0,
pk_yr_adl_em_only_first_seen2 = 1 => 0.14,
pk_yr_adl_em_only_first_seen2 = 2 => 0.1290322581,
pk_yr_adl_em_only_first_seen2 = 3 => 0.142192691,
pk_yr_adl_em_only_first_seen2 = 4 => 0.1052631579,
0.1578632479
);


pk_yr_lname_change_date2_mm := map(
pk_yr_lname_change_date2 = -1 => 0.1569746043,
pk_yr_lname_change_date2 = 0 => 0.1833333333,
pk_yr_lname_change_date2 = 1 => 0.167816092,
pk_yr_lname_change_date2 = 2 => 0.1612903226,
0.1578632479
);


pk_yr_gong_did_first_seen2_mm := map(
pk_yr_gong_did_first_seen2 = -1 => 0.1585513078,
pk_yr_gong_did_first_seen2 = 0 => 0.1830508475,
pk_yr_gong_did_first_seen2 = 1 => 0.1913580247,
pk_yr_gong_did_first_seen2 = 2 => 0.1779279279,
pk_yr_gong_did_first_seen2 = 3 => 0.1356673961,
pk_yr_gong_did_first_seen2 = 4 => 0.155425601,
0.1578632479
);


pk_yr_credit_first_seen2_mm := map(
pk_yr_credit_first_seen2 = -1 => 0.1723518851,
pk_yr_credit_first_seen2 = 0 => 0.125,
pk_yr_credit_first_seen2 = 1 => 0.1034482759,
pk_yr_credit_first_seen2 = 2 => 0.1791044776,
pk_yr_credit_first_seen2 = 3 => 0.156996587,
pk_yr_credit_first_seen2 = 4 => 0.130044843,
pk_yr_credit_first_seen2 = 5 => 0.1554404145,
pk_yr_credit_first_seen2 = 6 => 0.1413551402,
pk_yr_credit_first_seen2 = 7 => 0.1416405199,
pk_yr_credit_first_seen2 = 8 => 0.1462974112,
pk_yr_credit_first_seen2 = 9 => 0.1705298013,
pk_yr_credit_first_seen2 = 10 => 0.1722351722,
pk_yr_credit_first_seen2 = 11 => 0.1496062992,
0.1578632479
);


pk_yr_header_first_seen2_mm := map(
pk_yr_header_first_seen2 = -1 => 0.1680280047,
pk_yr_header_first_seen2 = 0 => 0.1272727273,
pk_yr_header_first_seen2 = 1 => 0.147826087,
pk_yr_header_first_seen2 = 2 => 0.1681818182,
pk_yr_header_first_seen2 = 3 => 0.1104651163,
pk_yr_header_first_seen2 = 4 => 0.142377261,
pk_yr_header_first_seen2 = 5 => 0.152404747,
pk_yr_header_first_seen2 = 6 => 0.1543903454,
pk_yr_header_first_seen2 = 7 => 0.1898628999,
0.1578632479
);


pk_yr_infutor_first_seen2_mm := map(
pk_yr_infutor_first_seen2 = -1 => 0.1673396675,
pk_yr_infutor_first_seen2 = 0 => 0.1470588235,
pk_yr_infutor_first_seen2 = 1 => 0.106017192,
pk_yr_infutor_first_seen2 = 2 => 0.1476744186,
pk_yr_infutor_first_seen2 = 3 => 0.1270036991,
pk_yr_infutor_first_seen2 = 4 => 0.1350671141,
0.1578632479
);


pk_EM_Only_ver_lvl_mm := map(
pk_EM_Only_ver_lvl = -1 => 0.1965811966,
pk_EM_Only_ver_lvl = 0 => 0.1616699069,
pk_EM_Only_ver_lvl = 1 => 0.1270661157,
pk_EM_Only_ver_lvl = 2 => 0.1349557522,
pk_EM_Only_ver_lvl = 3 => 0.1538461538,
0.1578632479
);


pk_add2_EM_ver_lvl_mm := map(
pk_add2_EM_ver_lvl = -1 => 0.1904761905,
pk_add2_EM_ver_lvl = 0 => 0.1573595161,
pk_add2_EM_ver_lvl = 1 => 0.1531531532,
pk_add2_EM_ver_lvl = 2 => 0.1925465839,
0.1578632479
);


pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.1714285714,
pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0.3333333333,
pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.125,
pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0.125,
pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.1875,
pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.3333333333,
pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.1461538462,
pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.1153846154,
pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.1193181818,
pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.14481409,
pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.1418253447,
pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.1415857605,
pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.1559356137,
pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.1325153374,
pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.1662531017,
pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.1677507703,
pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.1818181818,
0.1578632479
);


pk_util_adl_source_count_mm := map(
pk_util_adl_source_count = 0 => 0.1730205279,
pk_util_adl_source_count = 1 => 0.1648460775,
pk_util_adl_source_count = 2 => 0.1576876513,
pk_util_adl_source_count = 3 => 0.1475941162,
0.1578632479
);


pk_util_adl_sourced_mm := map(
pk_util_adl_sourced = 0 => 0.1730205279,
pk_util_adl_sourced = 1 => 0.1558630031,
0.1578632479
);


pk_util_adl_count_mm := map(
pk_util_adl_count = 0 => 0.1730205279,
pk_util_adl_count = 1 => 0.175470009,
pk_util_adl_count = 2 => 0.1597444089,
pk_util_adl_count = 3 => 0.1651452282,
pk_util_adl_count = 4 => 0.1535125759,
pk_util_adl_count = 5 => 0.1495810305,
0.1578632479
);


pk_util_adl_nap_mm := map(
pk_util_adl_nap = -1 => 0.1736204576,
pk_util_adl_nap = 0 => 0.1520543513,
pk_util_adl_nap = 1 => 0.1902231668,
0.1578632479
);


pk_util_add1_source_count_mm := map(
pk_util_add1_source_count = 0 => 0.1918265221,
pk_util_add1_source_count = 1 => 0.1579074837,
pk_util_add1_source_count = 2 => 0.1529225908,
pk_util_add1_source_count = 3 => 0.1487357462,
pk_util_add1_source_count = 4 => 0.1506090808,
pk_util_add1_source_count = 5 => 0.1567944251,
0.1578632479
);


pk_util_add1_nap_mm := map(
pk_util_add1_nap = -1 => 0.1612193589,
pk_util_add1_nap = 0 => 0.1515552614,
pk_util_add1_nap = 1 => 0.1962616822,
0.1578632479
);


pk_util_add2_source_count_mm := map(
pk_util_add2_source_count = 0 => 0.1633943428,
pk_util_add2_source_count = 1 => 0.1502395619,
pk_util_add2_source_count = 2 => 0.1590649943,
pk_util_add2_source_count = 3 => 0.1449704142,
0.1578632479
);


pk_util_add2_nap_mm := map(
pk_util_add2_nap = -1 => 0.1561053756,
pk_util_add2_nap = 0 => 0.1538745387,
pk_util_add2_nap = 1 => 0.2054380665,
0.1578632479
);


pk_rc_utiliaddr_phonecount_mm := map(
pk_rc_utiliaddr_phonecount = 0 => 0.1537880932,
pk_rc_utiliaddr_phonecount = 1 => 0.1970935513,
0.1578632479
);


pk_utility_sourced_mm := map(
pk_utility_sourced = 0 => 0.1578726968,
pk_utility_sourced = 1 => 0.1578483245,
0.1578632479
);


pk_yr_util_adl_D_firstseen2_mm := map(
pk_yr_util_adl_D_firstseen2 = -1 => 0.1658025491,
pk_yr_util_adl_D_firstseen2 = 0 => 0.175,
pk_yr_util_adl_D_firstseen2 = 1 => 0.1261642676,
0.1578632479
);


pk_yr_util_adl_E_firstseen2_mm := map(
pk_yr_util_adl_E_firstseen2 = -1 => 0.1549280537,
pk_yr_util_adl_E_firstseen2 = 0 => 0.2485380117,
pk_yr_util_adl_E_firstseen2 = 1 => 0.1658031088,
pk_yr_util_adl_E_firstseen2 = 2 => 0.1693989071,
pk_yr_util_adl_E_firstseen2 = 3 => 0.1711229947,
pk_yr_util_adl_E_firstseen2 = 4 => 0.1441860465,
pk_yr_util_adl_E_firstseen2 = 5 => 0.171875,
pk_yr_util_adl_E_firstseen2 = 6 => 0.1284634761,
pk_yr_util_adl_E_firstseen2 = 7 => 0.1593567251,
0.1578632479
);


pk_yr_util_adl_F_firstseen2_mm := map(
pk_yr_util_adl_F_firstseen2 = -1 => 0.1713733075,
pk_yr_util_adl_F_firstseen2 = 0 => 0.1609907121,
pk_yr_util_adl_F_firstseen2 = 1 => 0.1409574468,
pk_yr_util_adl_F_firstseen2 = 2 => 0.1272335182,
0.1578632479
);


pk_yr_util_adl_G_firstseen2_mm := map(
pk_yr_util_adl_G_firstseen2 = -1 => 0.1568272365,
pk_yr_util_adl_G_firstseen2 = 0 => 0.25,
pk_yr_util_adl_G_firstseen2 = 1 => 0.1570438799,
pk_yr_util_adl_G_firstseen2 = 2 => 0.1333333333,
0.1578632479
);


pk_yr_util_adl_I_firstseen2_mm := map(
pk_yr_util_adl_I_firstseen2 = -1 => 0.1626923911,
pk_yr_util_adl_I_firstseen2 = 0 => 0.1563275434,
pk_yr_util_adl_I_firstseen2 = 1 => 0.1301627034,
pk_yr_util_adl_I_firstseen2 = 2 => 0.1407232704,
0.1578632479
);


pk_yr_util_adl_U_firstseen2_mm := map(
pk_yr_util_adl_U_firstseen2 = -1 => 0.147818537,
pk_yr_util_adl_U_firstseen2 = 0 => 0.2314225053,
pk_yr_util_adl_U_firstseen2 = 1 => 0.1962809917,
pk_yr_util_adl_U_firstseen2 = 2 => 0.2013651877,
pk_yr_util_adl_U_firstseen2 = 3 => 0.1793214863,
0.1578632479
);


pk_mx_yr_util_adl_firstseen2_mm := map(
pk_mx_yr_util_adl_firstseen2 = -1 => 0.1730205279,
pk_mx_yr_util_adl_firstseen2 = 0 => 0.24,
pk_mx_yr_util_adl_firstseen2 = 1 => 0.1967871486,
pk_mx_yr_util_adl_firstseen2 = 2 => 0.1886792453,
pk_mx_yr_util_adl_firstseen2 = 3 => 0.1648177496,
pk_mx_yr_util_adl_firstseen2 = 4 => 0.1547403382,
pk_mx_yr_util_adl_firstseen2 = 5 => 0.1404199475,
0.1578632479
);


pk_yr_util_add1_E_firstseen2_mm := map(
pk_yr_util_add1_E_firstseen2 = -1 => 0.156305682,
pk_yr_util_add1_E_firstseen2 = 0 => 0.1994917408,
pk_yr_util_add1_E_firstseen2 = 1 => 0.1368680641,
0.1578632479
);


pk_yr_util_add1_F_firstseen2_mm := map(
pk_yr_util_add1_F_firstseen2 = -1 => 0.1653783087,
pk_yr_util_add1_F_firstseen2 = 0 => 0.1272727273,
pk_yr_util_add1_F_firstseen2 = 1 => 0.1383412644,
0.1578632479
);


pk_yr_util_add1_I_firstseen2_mm := map(
pk_yr_util_add1_I_firstseen2 = -1 => 0.1605800783,
pk_yr_util_add1_I_firstseen2 = 0 => 0.1576470588,
pk_yr_util_add1_I_firstseen2 = 1 => 0.1501547988,
pk_yr_util_add1_I_firstseen2 = 2 => 0.1449541284,
pk_yr_util_add1_I_firstseen2 = 3 => 0.0869565217,
0.1578632479
);


pk_yr_util_add1_U_firstseen2_mm := map(
pk_yr_util_add1_U_firstseen2 = -1 => 0.1541454978,
pk_yr_util_add1_U_firstseen2 = 0 => 0.1747035573,
pk_yr_util_add1_U_firstseen2 = 1 => 0.1689189189,
0.1578632479
);


pk_yr_util_add1_V_firstseen2_mm := map(
pk_yr_util_add1_V_firstseen2 = -1 => 0.1585964912,
pk_yr_util_add1_V_firstseen2 = 1 => 0.13,
0.1578632479
);


pk_yr_util_add1_Z_firstseen2_mm := map(
pk_yr_util_add1_Z_firstseen2 = -1 => 0.1857142857,
pk_yr_util_add1_Z_firstseen2 = 0 => 0.1670157068,
pk_yr_util_add1_Z_firstseen2 = 1 => 0.1493099122,
0.1578632479
);


pk_mx_yr_util_add1_firstseen2_mm := map(
pk_mx_yr_util_add1_firstseen2 = -1 => 0.1918265221,
pk_mx_yr_util_add1_firstseen2 = 0 => 0.1680522565,
pk_mx_yr_util_add1_firstseen2 = 1 => 0.1528836473,
pk_mx_yr_util_add1_firstseen2 = 2 => 0.1453862661,
0.1578632479
);


pk_yr_util_add2_D_firstseen2_mm := map(
pk_yr_util_add2_D_firstseen2 = -1 => 0.1621800948,
pk_yr_util_add2_D_firstseen2 = 1 => 0.1182608696,
0.1578632479
);


pk_yr_util_add2_E_firstseen2_mm := map(
pk_yr_util_add2_E_firstseen2 = -1 => 0.1579565473,
pk_yr_util_add2_E_firstseen2 = 0 => 0.2456140351,
pk_yr_util_add2_E_firstseen2 = 1 => 0.2110817942,
pk_yr_util_add2_E_firstseen2 = 2 => 0.1496402878,
pk_yr_util_add2_E_firstseen2 = 3 => 0.0997150997,
0.1578632479
);


pk_yr_util_add2_G_firstseen2_mm := map(
pk_yr_util_add2_G_firstseen2 = -1 => 0.1556244464,
pk_yr_util_add2_G_firstseen2 = 1 => 0.2195121951,
0.1578632479
);


pk_yr_util_add2_U_firstseen2_mm := map(
pk_yr_util_add2_U_firstseen2 = -1 => 0.153335441,
pk_yr_util_add2_U_firstseen2 = 0 => 0.1787564767,
pk_yr_util_add2_U_firstseen2 = 1 => 0.1769863014,
0.1578632479
);


pk_yr_util_add2_Z_firstseen2_mm := map(
pk_yr_util_add2_Z_firstseen2 = -1 => 0.179389313,
pk_yr_util_add2_Z_firstseen2 = 0 => 0.1174377224,
pk_yr_util_add2_Z_firstseen2 = 1 => 0.1527446301,
0.1578632479
);


pk_nap_type_mm := map(
pk_nap_type = 0 => 0.0340909091,
pk_nap_type = 1 => 0.0746268657,
pk_nap_type = 2 => 0.1291866029,
pk_nap_type = 3 => 0.1637030765,
0.1578632479
);


pk_EN_count_mm := map(
pk_EN_count = -1 => 0.1699846861,
pk_EN_count = 0 => 0.1517719569,
pk_EN_count = 1 => 0.1629941672,
pk_EN_count = 2 => 0.1655709764,
pk_EN_count = 3 => 0.1392801252,
0.1578632479
);


pk_dl_avail_mm := map(
pk_dl_avail = 0 => 0.1680841862,
pk_dl_avail = 1 => 0.1429771153,
0.1578632479
);


pk_DL_count_mm := map(
pk_DL_count = -1 => 0.1694665488,
pk_DL_count = 0 => 0.1556776557,
pk_DL_count = 1 => 0.1588579795,
pk_DL_count = 2 => 0.1157775255,
pk_DL_count = 3 => 0.1195335277,
0.1578632479
);


pk_yr_adl_EN_first_seen2_mm := map(
pk_yr_adl_EN_first_seen2 = -1 => 0.1699846861,
pk_yr_adl_EN_first_seen2 = 14 => 0.1403252711,
pk_yr_adl_EN_first_seen2 = 15 => 0.1734693878,
pk_yr_adl_EN_first_seen2 = 16 => 0.1553398058,
pk_yr_adl_EN_first_seen2 = 17 => 0.1603153745,
pk_yr_adl_EN_first_seen2 = 18 => 0.1784037559,
pk_yr_adl_EN_first_seen2 = 19 => 0.149408284,
pk_yr_adl_EN_first_seen2 = 20 => 0.1663201663,
pk_yr_adl_EN_first_seen2 = 21 => 0.1644171779,
pk_yr_adl_EN_first_seen2 = 22 => 0.1969309463,
0.1578632479
);


pk_yr_adl_DL_first_seen2_mm := map(
pk_yr_adl_DL_first_seen2 = -9 => 0.1698249675,
pk_yr_adl_DL_first_seen2 = -1 => 0.0956937799,
pk_yr_adl_DL_first_seen2 = 0 => 0.150882825,
pk_yr_adl_DL_first_seen2 = 1 => 0.1413400759,
0.1578632479
);


            elseif (pk_segment2 = 3 ) then /* 3 Mid              */



pk_nas_summary_mm := map(
pk_nas_summary = 0 => 0.1033407572,
pk_nas_summary = 1 => 0.1236327478,
pk_nas_summary = 2 => 0.0976355723,
0.1006013327
);


pk_nap_summary_mm := map(
pk_nap_summary = -1 => 0.0954166667,
pk_nap_summary = 0 => 0.0975808201,
pk_nap_summary = 1 => 0.1001187178,
pk_nap_summary = 2 => 0.1341414141,
0.1006013327
);


pk_rc_dirsaddr_lastscore_mm := map(
pk_rc_dirsaddr_lastscore = -1 => 0.0982742863,
pk_rc_dirsaddr_lastscore = 0 => 0.0949222048,
pk_rc_dirsaddr_lastscore = 1 => 0.0777777778,
pk_rc_dirsaddr_lastscore = 2 => 0.1273938385,
0.1006013327
);


pk_combo_hphonescore_mm := map(
pk_combo_hphonescore = 0 => 0.0965207632,
pk_combo_hphonescore = 1 => 0.0888888889,
pk_combo_hphonescore = 2 => 0.103132202,
0.1006013327
);


pk_combo_dobscore_mm := map(
pk_combo_dobscore = -1 => 0.1020596373,
pk_combo_dobscore = 0 => 0.5,
pk_combo_dobscore = 1 => 0.1175213675,
pk_combo_dobscore = 2 => 0.0997967939,
0.1006013327
);


pk_gong_did_first_ct_mm := map(
pk_gong_did_first_ct = 0 => 0.110451801,
pk_gong_did_first_ct = 1 => 0.0961293067,
0.1006013327
);


pk_combo_lnamecount_nb_mm := map(
pk_combo_lnamecount_nb = 0 => 0.1044496487,
pk_combo_lnamecount_nb = 1 => 0.1186440678,
pk_combo_lnamecount_nb = 2 => 0.1071049841,
pk_combo_lnamecount_nb = 3 => 0.1009421265,
pk_combo_lnamecount_nb = 4 => 0.0909575887,
pk_combo_lnamecount_nb = 5 => 0.0954492415,
pk_combo_lnamecount_nb = 6 => 0.1021956088,
0.1006013327
);


pk_rc_phonelnamecount_mm := map(
pk_rc_phonelnamecount = 0 => 0.0998231085,
pk_rc_phonelnamecount = 1 => 0.1038872857,
0.1006013327
);


pk_combo_addrcount_nb_mm := map(
pk_combo_addrcount_nb = 0 => 0.1059714045,
pk_combo_addrcount_nb = 1 => 0.1006175468,
pk_combo_addrcount_nb = 2 => 0.0903691973,
pk_combo_addrcount_nb = 3 => 0.1045048331,
pk_combo_addrcount_nb = 4 => 0.1107126849,
pk_combo_addrcount_nb = 5 => 0.1400679117,
0.1006013327
);


pk_rc_phoneaddrcount_mm := map(
pk_rc_phoneaddrcount = 0 => 0.0999281093,
pk_rc_phoneaddrcount = 1 => 0.1035446132,
0.1006013327
);


pk_combo_hphonecount_mm := map(
pk_combo_hphonecount = 0 => 0.0959531994,
pk_combo_hphonecount = 1 => 0.106034969,
0.1006013327
);


pk_ver_phncount_mm := map(
pk_ver_phncount = 0 => 0.0973828363,
pk_ver_phncount = 1 => 0.0979556139,
pk_ver_phncount = 2 => 0.0976390922,
pk_ver_phncount = 3 => 0.1341414141,
0.1006013327
);


pk_gong_did_phone_ct_nb_mm := map(
pk_gong_did_phone_ct_nb = -2 => 0.1089709763,
pk_gong_did_phone_ct_nb = -1 => 0.1028319406,
pk_gong_did_phone_ct_nb = 0 => 0.0893600909,
pk_gong_did_phone_ct_nb = 1 => 0.088912887,
pk_gong_did_phone_ct_nb = 2 => 0.0923133505,
0.1006013327
);


pk_combo_ssncount_mm := map(
pk_combo_ssncount = -1 => 0.1034329024,
pk_combo_ssncount = 0 => 0.1217712177,
pk_combo_ssncount = 1 => 0.1001734452,
0.1006013327
);


pk_combo_dobcount_nb_mm := map(
pk_combo_dobcount_nb = 0 => 0.1023041475,
pk_combo_dobcount_nb = 1 => 0.1142573274,
pk_combo_dobcount_nb = 2 => 0.0907457323,
pk_combo_dobcount_nb = 3 => 0.1054493984,
pk_combo_dobcount_nb = 4 => 0.0910582445,
pk_combo_dobcount_nb = 5 => 0.0902277313,
pk_combo_dobcount_nb = 6 => 0.0938654841,
pk_combo_dobcount_nb = 7 => 0.1050365244,
0.1006013327
);


pk_eq_count_mm := map(
pk_eq_count = 0 => 0.1035515618,
pk_eq_count = 1 => 0.0894788594,
pk_eq_count = 2 => 0.0914634146,
pk_eq_count = 3 => 0.0890188434,
pk_eq_count = 4 => 0.0981152993,
pk_eq_count = 5 => 0.0975810679,
pk_eq_count = 6 => 0.1106839101,
0.1006013327
);


pk_em_count_mm := map(
pk_em_count = 0 => 0.1042108613,
pk_em_count = 1 => 0.0921668795,
pk_em_count = 2 => 0.0966578838,
0.1006013327
);


pk_em_only_count_mm := map(
pk_em_only_count = 0 => 0.0999846708,
pk_em_only_count = 1 => 0.1011424731,
pk_em_only_count = 2 => 0.1086797958,
pk_em_only_count = 3 => 0.1111111111,
0.1006013327
);


pk_pos_secondary_sources_mm := map(
pk_pos_secondary_sources = 0 => 0.100319573,
pk_pos_secondary_sources = 1 => 0.1187214612,
pk_pos_secondary_sources = 2 => 0.1243523316,
0.1006013327
);


pk_voter_flag_mm := map(
pk_voter_flag = -1 => 0.0950413223,
pk_voter_flag = 0 => 0.1080511663,
pk_voter_flag = 1 => 0.0948862205,
0.1006013327
);


pk_fname_eda_sourced_type_lvl_mm := map(
pk_fname_eda_sourced_type_lvl = 0 => 0.1001082485,
pk_fname_eda_sourced_type_lvl = 1 => 0.1167741935,
pk_fname_eda_sourced_type_lvl = 2 => 0.0927419355,
pk_fname_eda_sourced_type_lvl = 3 => 0.1304824561,
0.1006013327
);


pk_lname_eda_sourced_type_lvl_mm := map(
pk_lname_eda_sourced_type_lvl = 0 => 0.0973831358,
pk_lname_eda_sourced_type_lvl = 1 => 0.1214767765,
pk_lname_eda_sourced_type_lvl = 2 => 0.0965395636,
pk_lname_eda_sourced_type_lvl = 3 => 0.1285081241,
0.1006013327
);


pk_add1_address_score_mm := map(
pk_add1_address_score = 0 => 0.1141713371,
pk_add1_address_score = 1 => 0.0971451876,
0.1006013327
);


pk_add2_pos_sources_mm := map(
pk_add2_pos_sources = 0 => 0.0899149453,
pk_add2_pos_sources = 1 => 0.10608914,
pk_add2_pos_sources = 2 => 0.0989932886,
pk_add2_pos_sources = 3 => 0.1102244389,
pk_add2_pos_sources = 4 => 0.1052631579,
0.1006013327
);


pk_ssnchar_invalid_or_recent_mm := map(
pk_ssnchar_invalid_or_recent = 0 => 0.1004342574,
pk_ssnchar_invalid_or_recent = 1 => 0.1376811594,
0.1006013327
);


pk_infutor_risk_lvl_nb_mm := map(
pk_infutor_risk_lvl_nb = 0 => 0.1015132409,
pk_infutor_risk_lvl_nb = 1 => 0.1068142333,
pk_infutor_risk_lvl_nb = 2 => 0.096353167,
pk_infutor_risk_lvl_nb = 3 => 0.0915994305,
0.1006013327
);


pk_yr_adl_eq_first_seen2_mm := map(
pk_yr_adl_eq_first_seen2 = -1 => 0.1043755697,
pk_yr_adl_eq_first_seen2 = 0 => 0.2068965517,
pk_yr_adl_eq_first_seen2 = 1 => 0.0884955752,
pk_yr_adl_eq_first_seen2 = 2 => 0.1153846154,
pk_yr_adl_eq_first_seen2 = 3 => 0.1160877514,
pk_yr_adl_eq_first_seen2 = 4 => 0.0748387097,
pk_yr_adl_eq_first_seen2 = 5 => 0.1073414905,
pk_yr_adl_eq_first_seen2 = 6 => 0.0915083366,
pk_yr_adl_eq_first_seen2 = 7 => 0.1003374179,
pk_yr_adl_eq_first_seen2 = 8 => 0.0983981693,
pk_yr_adl_eq_first_seen2 = 9 => 0.1015808947,
pk_yr_adl_eq_first_seen2 = 10 => 0.1014276582,
0.1006013327
);


pk_yr_adl_em_first_seen2_mm := map(
pk_yr_adl_em_first_seen2 = -1 => 0.1043161672,
pk_yr_adl_em_first_seen2 = 0 => 0.074829932,
pk_yr_adl_em_first_seen2 = 1 => 0.0967486122,
pk_yr_adl_em_first_seen2 = 2 => 0.0796074155,
pk_yr_adl_em_first_seen2 = 3 => 0.0961317062,
pk_yr_adl_em_first_seen2 = 4 => 0.1007633588,
0.1006013327
);


pk_yr_adl_vo_first_seen2_mm := map(
pk_yr_adl_vo_first_seen2 = -1 => 0.1041238123,
pk_yr_adl_vo_first_seen2 = 0 => 0.0909090909,
pk_yr_adl_vo_first_seen2 = 1 => 0.0954098361,
pk_yr_adl_vo_first_seen2 = 2 => 0.0921526278,
pk_yr_adl_vo_first_seen2 = 3 => 0.0934765314,
0.1006013327
);


pk_yr_adl_em_only_first_seen2_mm := map(
pk_yr_adl_em_only_first_seen2 = -1 => 0.1000720762,
pk_yr_adl_em_only_first_seen2 = 0 => 0.0909090909,
pk_yr_adl_em_only_first_seen2 = 1 => 0.1194379391,
pk_yr_adl_em_only_first_seen2 = 2 => 0.0953545232,
pk_yr_adl_em_only_first_seen2 = 3 => 0.1033372365,
pk_yr_adl_em_only_first_seen2 = 4 => 0.0930232558,
0.1006013327
);


pk_yr_lname_change_date2_mm := map(
pk_yr_lname_change_date2 = -1 => 0.1006951686,
pk_yr_lname_change_date2 = 0 => 0.1154791155,
pk_yr_lname_change_date2 = 1 => 0.10724365,
pk_yr_lname_change_date2 = 2 => 0.0704761905,
0.1006013327
);


pk_yr_gong_did_first_seen2_mm := map(
pk_yr_gong_did_first_seen2 = -1 => 0.110451801,
pk_yr_gong_did_first_seen2 = 0 => 0.1639784946,
pk_yr_gong_did_first_seen2 = 1 => 0.0912698413,
pk_yr_gong_did_first_seen2 = 2 => 0.0935828877,
pk_yr_gong_did_first_seen2 = 3 => 0.0804597701,
pk_yr_gong_did_first_seen2 = 4 => 0.096150585,
0.1006013327
);


pk_yr_credit_first_seen2_mm := map(
pk_yr_credit_first_seen2 = -1 => 0.1043755697,
pk_yr_credit_first_seen2 = 0 => 0.2068965517,
pk_yr_credit_first_seen2 = 1 => 0.0884955752,
pk_yr_credit_first_seen2 = 2 => 0.1153846154,
pk_yr_credit_first_seen2 = 3 => 0.1160877514,
pk_yr_credit_first_seen2 = 4 => 0.0748387097,
pk_yr_credit_first_seen2 = 5 => 0.1073414905,
pk_yr_credit_first_seen2 = 6 => 0.0915083366,
pk_yr_credit_first_seen2 = 7 => 0.1003374179,
pk_yr_credit_first_seen2 = 8 => 0.0983981693,
pk_yr_credit_first_seen2 = 9 => 0.1015808947,
pk_yr_credit_first_seen2 = 10 => 0.101774759,
pk_yr_credit_first_seen2 = 11 => 0.0891472868,
0.1006013327
);


pk_yr_header_first_seen2_mm := map(
pk_yr_header_first_seen2 = -1 => 0.1102407891,
pk_yr_header_first_seen2 = 0 => 0.1232876712,
pk_yr_header_first_seen2 = 1 => 0.0991253644,
pk_yr_header_first_seen2 = 2 => 0.1021276596,
pk_yr_header_first_seen2 = 3 => 0.0841924399,
pk_yr_header_first_seen2 = 4 => 0.0956521739,
pk_yr_header_first_seen2 = 5 => 0.0970496894,
pk_yr_header_first_seen2 = 6 => 0.1011235955,
pk_yr_header_first_seen2 = 7 => 0.107388974,
0.1006013327
);


pk_yr_infutor_first_seen2_mm := map(
pk_yr_infutor_first_seen2 = -1 => 0.1068073607,
pk_yr_infutor_first_seen2 = 0 => 0.0864864865,
pk_yr_infutor_first_seen2 = 1 => 0.0820754717,
pk_yr_infutor_first_seen2 = 2 => 0.0946634486,
pk_yr_infutor_first_seen2 = 3 => 0.1130899377,
pk_yr_infutor_first_seen2 = 4 => 0.0818134445,
0.1006013327
);


pk_EM_Only_ver_lvl_mm := map(
pk_EM_Only_ver_lvl = -1 => 0.1017699115,
pk_EM_Only_ver_lvl = 0 => 0.1000382117,
pk_EM_Only_ver_lvl = 1 => 0.1003163127,
pk_EM_Only_ver_lvl = 2 => 0.1067729084,
pk_EM_Only_ver_lvl = 3 => 0.1087680355,
0.1006013327
);


pk_add2_EM_ver_lvl_mm := map(
pk_add2_EM_ver_lvl = -1 => 0.0967741935,
pk_add2_EM_ver_lvl = 0 => 0.1002788289,
pk_add2_EM_ver_lvl = 1 => 0.132780083,
pk_add2_EM_ver_lvl = 2 => 0.10626703,
0.1006013327
);


pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.1038961039,
pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0.1153846154,
pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.1794871795,
pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0.1111111111,
pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.0852017937,
pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.1407407407,
pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.1107438017,
pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.0922509225,
pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.0829562594,
pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.1036729858,
pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.0973981119,
pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.1036077706,
pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.0968858131,
pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.096933729,
pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.0994957983,
pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.1033221133,
pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.0989551321,
0.1006013327
);


pk_util_adl_source_count_mm := map(
pk_util_adl_source_count = 0 => 0.0909338415,
pk_util_adl_source_count = 1 => 0.0912673192,
pk_util_adl_source_count = 2 => 0.1045984456,
pk_util_adl_source_count = 3 => 0.1078204999,
0.1006013327
);


pk_util_adl_sourced_mm := map(
pk_util_adl_sourced = 0 => 0.0909338415,
pk_util_adl_sourced = 1 => 0.1019120035,
0.1006013327
);


pk_util_adl_count_mm := map(
pk_util_adl_count = 0 => 0.0909338415,
pk_util_adl_count = 1 => 0.0907378336,
pk_util_adl_count = 2 => 0.0973019518,
pk_util_adl_count = 3 => 0.0965475099,
pk_util_adl_count = 4 => 0.1007931262,
pk_util_adl_count = 5 => 0.1070518267,
0.1006013327
);


pk_util_adl_nap_mm := map(
pk_util_adl_nap = -1 => 0.0920610292,
pk_util_adl_nap = 0 => 0.0960204612,
pk_util_adl_nap = 1 => 0.1368146214,
0.1006013327
);


pk_util_add1_source_count_mm := map(
pk_util_add1_source_count = 0 => 0.1051361599,
pk_util_add1_source_count = 1 => 0.0968160495,
pk_util_add1_source_count = 2 => 0.1017936707,
pk_util_add1_source_count = 3 => 0.1012411348,
pk_util_add1_source_count = 4 => 0.1022682053,
pk_util_add1_source_count = 5 => 0.1075612354,
0.1006013327
);


pk_util_add1_nap_mm := map(
pk_util_add1_nap = -1 => 0.0984437206,
pk_util_add1_nap = 0 => 0.0956423316,
pk_util_add1_nap = 1 => 0.1382033564,
0.1006013327
);


pk_util_add2_source_count_mm := map(
pk_util_add2_source_count = 0 => 0.0971690895,
pk_util_add2_source_count = 1 => 0.1033505155,
pk_util_add2_source_count = 2 => 0.1046908316,
pk_util_add2_source_count = 3 => 0.1056632459,
0.1006013327
);


pk_util_add2_nap_mm := map(
pk_util_add2_nap = -1 => 0.0925022052,
pk_util_add2_nap = 0 => 0.1065800162,
pk_util_add2_nap = 1 => 0.1448275862,
0.1006013327
);


pk_rc_utiliaddr_phonecount_mm := map(
pk_rc_utiliaddr_phonecount = 0 => 0.0963233396,
pk_rc_utiliaddr_phonecount = 1 => 0.1324013158,
0.1006013327
);


pk_utility_sourced_mm := map(
pk_utility_sourced = 0 => 0.0929191461,
pk_utility_sourced = 1 => 0.111905527,
0.1006013327
);


pk_yr_util_adl_D_firstseen2_mm := map(
pk_yr_util_adl_D_firstseen2 = -1 => 0.1041976899,
pk_yr_util_adl_D_firstseen2 = 0 => 0.125,
pk_yr_util_adl_D_firstseen2 = 1 => 0.0840056121,
0.1006013327
);


pk_yr_util_adl_E_firstseen2_mm := map(
pk_yr_util_adl_E_firstseen2 = -1 => 0.095157704,
pk_yr_util_adl_E_firstseen2 = 0 => 0.1723044397,
pk_yr_util_adl_E_firstseen2 = 1 => 0.1408163265,
pk_yr_util_adl_E_firstseen2 = 2 => 0.1010309278,
pk_yr_util_adl_E_firstseen2 = 3 => 0.1457489879,
pk_yr_util_adl_E_firstseen2 = 4 => 0.1114599686,
pk_yr_util_adl_E_firstseen2 = 5 => 0.11829653,
pk_yr_util_adl_E_firstseen2 = 6 => 0.106981982,
pk_yr_util_adl_E_firstseen2 = 7 => 0.0997375328,
0.1006013327
);


pk_yr_util_adl_F_firstseen2_mm := map(
pk_yr_util_adl_F_firstseen2 = -1 => 0.1086093982,
pk_yr_util_adl_F_firstseen2 = 0 => 0.1146853147,
pk_yr_util_adl_F_firstseen2 = 1 => 0.0982490272,
pk_yr_util_adl_F_firstseen2 = 2 => 0.0789830927,
0.1006013327
);


pk_yr_util_adl_G_firstseen2_mm := map(
pk_yr_util_adl_G_firstseen2 = -1 => 0.0981103656,
pk_yr_util_adl_G_firstseen2 = 0 => 0.1985111663,
pk_yr_util_adl_G_firstseen2 = 1 => 0.1361746362,
pk_yr_util_adl_G_firstseen2 = 2 => 0.0957446809,
0.1006013327
);


pk_yr_util_adl_I_firstseen2_mm := map(
pk_yr_util_adl_I_firstseen2 = -1 => 0.1011183794,
pk_yr_util_adl_I_firstseen2 = 0 => 0.1344339623,
pk_yr_util_adl_I_firstseen2 = 1 => 0.0978580428,
pk_yr_util_adl_I_firstseen2 = 2 => 0.0863330407,
0.1006013327
);


pk_yr_util_adl_U_firstseen2_mm := map(
pk_yr_util_adl_U_firstseen2 = -1 => 0.0875599083,
pk_yr_util_adl_U_firstseen2 = 0 => 0.2086648983,
pk_yr_util_adl_U_firstseen2 = 1 => 0.1655677656,
pk_yr_util_adl_U_firstseen2 = 2 => 0.1375921376,
pk_yr_util_adl_U_firstseen2 = 3 => 0.1213872832,
0.1006013327
);


pk_mx_yr_util_adl_firstseen2_mm := map(
pk_mx_yr_util_adl_firstseen2 = -1 => 0.0909338415,
pk_mx_yr_util_adl_firstseen2 = 0 => 0.1751313485,
pk_mx_yr_util_adl_firstseen2 = 1 => 0.1257861635,
pk_mx_yr_util_adl_firstseen2 = 2 => 0.1127819549,
pk_mx_yr_util_adl_firstseen2 = 3 => 0.103626943,
pk_mx_yr_util_adl_firstseen2 = 4 => 0.1014466762,
pk_mx_yr_util_adl_firstseen2 = 5 => 0.0910117799,
0.1006013327
);


pk_yr_util_add1_E_firstseen2_mm := map(
pk_yr_util_add1_E_firstseen2 = -1 => 0.0982367758,
pk_yr_util_add1_E_firstseen2 = 0 => 0.125,
pk_yr_util_add1_E_firstseen2 = 1 => 0.1046559539,
0.1006013327
);


pk_yr_util_add1_F_firstseen2_mm := map(
pk_yr_util_add1_F_firstseen2 = -1 => 0.1066288901,
pk_yr_util_add1_F_firstseen2 = 0 => 0.0994263862,
pk_yr_util_add1_F_firstseen2 = 1 => 0.0839370472,
0.1006013327
);


pk_yr_util_add1_I_firstseen2_mm := map(
pk_yr_util_add1_I_firstseen2 = -1 => 0.1011549848,
pk_yr_util_add1_I_firstseen2 = 0 => 0.1168627451,
pk_yr_util_add1_I_firstseen2 = 1 => 0.1036649215,
pk_yr_util_add1_I_firstseen2 = 2 => 0.0888820068,
pk_yr_util_add1_I_firstseen2 = 3 => 0.0951086957,
0.1006013327
);


pk_yr_util_add1_U_firstseen2_mm := map(
pk_yr_util_add1_U_firstseen2 = -1 => 0.0948533434,
pk_yr_util_add1_U_firstseen2 = 0 => 0.1166716913,
pk_yr_util_add1_U_firstseen2 = 1 => 0.123202171,
0.1006013327
);


pk_yr_util_add1_V_firstseen2_mm := map(
pk_yr_util_add1_V_firstseen2 = -1 => 0.0998727735,
pk_yr_util_add1_V_firstseen2 = 1 => 0.1248606466,
0.1006013327
);


pk_yr_util_add1_Z_firstseen2_mm := map(
pk_yr_util_add1_Z_firstseen2 = -1 => 0.1054182725,
pk_yr_util_add1_Z_firstseen2 = 0 => 0.1127335194,
pk_yr_util_add1_Z_firstseen2 = 1 => 0.0970180209,
0.1006013327
);


pk_mx_yr_util_add1_firstseen2_mm := map(
pk_mx_yr_util_add1_firstseen2 = -1 => 0.1051361599,
pk_mx_yr_util_add1_firstseen2 = 0 => 0.1123654502,
pk_mx_yr_util_add1_firstseen2 = 1 => 0.0983214732,
pk_mx_yr_util_add1_firstseen2 = 2 => 0.0977683316,
0.1006013327
);


pk_yr_util_add2_D_firstseen2_mm := map(
pk_yr_util_add2_D_firstseen2 = -1 => 0.1013438452,
pk_yr_util_add2_D_firstseen2 = 1 => 0.0933566434,
0.1006013327
);


pk_yr_util_add2_E_firstseen2_mm := map(
pk_yr_util_add2_E_firstseen2 = -1 => 0.0973009497,
pk_yr_util_add2_E_firstseen2 = 0 => 0.1020408163,
pk_yr_util_add2_E_firstseen2 = 1 => 0.1336787565,
pk_yr_util_add2_E_firstseen2 = 2 => 0.1253210067,
pk_yr_util_add2_E_firstseen2 = 3 => 0.1077788191,
0.1006013327
);


pk_yr_util_add2_G_firstseen2_mm := map(
pk_yr_util_add2_G_firstseen2 = -1 => 0.0990434637,
pk_yr_util_add2_G_firstseen2 = 1 => 0.1484536082,
0.1006013327
);


pk_yr_util_add2_U_firstseen2_mm := map(
pk_yr_util_add2_U_firstseen2 = -1 => 0.0952748548,
pk_yr_util_add2_U_firstseen2 = 0 => 0.1352345906,
pk_yr_util_add2_U_firstseen2 = 1 => 0.1190523198,
0.1006013327
);


pk_yr_util_add2_Z_firstseen2_mm := map(
pk_yr_util_add2_Z_firstseen2 = -1 => 0.0994321767,
pk_yr_util_add2_Z_firstseen2 = 0 => 0.0970588235,
pk_yr_util_add2_Z_firstseen2 = 1 => 0.1011281588,
0.1006013327
);


pk_nap_type_mm := map(
pk_nap_type = 0 => 0.1017423771,
pk_nap_type = 1 => 0.0968858131,
pk_nap_type = 2 => 0.1189273222,
pk_nap_type = 3 => 0.099415557,
0.1006013327
);


pk_EN_count_mm := map(
pk_EN_count = -1 => 0.1070859873,
pk_EN_count = 0 => 0.0990926457,
pk_EN_count = 1 => 0.0973842564,
pk_EN_count = 2 => 0.1008579409,
pk_EN_count = 3 => 0.1029162428,
0.1006013327
);


pk_dl_avail_mm := map(
pk_dl_avail = 0 => 0.1095374967,
pk_dl_avail = 1 => 0.0858985383,
0.1006013327
);


pk_DL_count_mm := map(
pk_DL_count = -1 => 0.106595012,
pk_DL_count = 0 => 0.0929258072,
pk_DL_count = 1 => 0.0919685039,
pk_DL_count = 2 => 0.0898455779,
pk_DL_count = 3 => 0.0856502242,
0.1006013327
);


pk_yr_adl_EN_first_seen2_mm := map(
pk_yr_adl_EN_first_seen2 = -1 => 0.1070859873,
pk_yr_adl_EN_first_seen2 = 14 => 0.0973508047,
pk_yr_adl_EN_first_seen2 = 15 => 0.1109048724,
pk_yr_adl_EN_first_seen2 = 16 => 0.1083576288,
pk_yr_adl_EN_first_seen2 = 17 => 0.0973062122,
pk_yr_adl_EN_first_seen2 = 18 => 0.0997375328,
pk_yr_adl_EN_first_seen2 = 19 => 0.10056926,
pk_yr_adl_EN_first_seen2 = 20 => 0.1052631579,
pk_yr_adl_EN_first_seen2 = 21 => 0.1005385996,
pk_yr_adl_EN_first_seen2 = 22 => 0.0979643766,
0.1006013327
);


pk_yr_adl_DL_first_seen2_mm := map(
pk_yr_adl_DL_first_seen2 = -9 => 0.1069127723,
pk_yr_adl_DL_first_seen2 = -1 => 0.1029082774,
pk_yr_adl_DL_first_seen2 = 0 => 0.0765027322,
pk_yr_adl_DL_first_seen2 = 1 => 0.0912981455,
0.1006013327
);


            // else if (pk_segment2 = 4 ) then /* 4 Unassigned       */
            else /* 4 Unassigned       */



pk_nas_summary_mm := map(
pk_nas_summary = 0 => 0.0686868687,
pk_nas_summary = 1 => 0.0748663102,
pk_nas_summary = 2 => 0.0651310564,
0.066873267
);


pk_nap_summary_mm := map(
pk_nap_summary = -1 => 0.0472854641,
pk_nap_summary = 0 => 0.0610111813,
pk_nap_summary = 1 => 0.0981012658,
pk_nap_summary = 2 => 0.085995086,
0.066873267
);


pk_rc_dirsaddr_lastscore_mm := map(
pk_rc_dirsaddr_lastscore = -1 => 0.0615097856,
pk_rc_dirsaddr_lastscore = 0 => 0.0592441267,
pk_rc_dirsaddr_lastscore = 1 => 0.0877192982,
pk_rc_dirsaddr_lastscore = 2 => 0.103362391,
0.066873267
);


pk_combo_hphonescore_mm := map(
pk_combo_hphonescore = 0 => 0.0499839795,
pk_combo_hphonescore = 1 => 0.0333333333,
pk_combo_hphonescore = 2 => 0.0848993289,
0.066873267
);


pk_combo_dobscore_mm := map(
pk_combo_dobscore = -1 => 0.0665451231,
pk_combo_dobscore = 1 => 0.0625,
pk_combo_dobscore = 2 => 0.0672092413,
0.066873267
);


pk_gong_did_first_ct_mm := map(
pk_gong_did_first_ct = 0 => 0.0699909883,
pk_gong_did_first_ct = 1 => 0.0631691649,
0.066873267
);


pk_combo_lnamecount_nb_mm := map(
pk_combo_lnamecount_nb = 0 => 0.0662809048,
pk_combo_lnamecount_nb = 1 => 0.1104972376,
pk_combo_lnamecount_nb = 2 => 0.0607028754,
pk_combo_lnamecount_nb = 3 => 0.0711111111,
pk_combo_lnamecount_nb = 4 => 0.0613718412,
pk_combo_lnamecount_nb = 5 => 0.0695364238,
pk_combo_lnamecount_nb = 6 => 0.0643796992,
0.066873267
);


pk_rc_phonelnamecount_mm := map(
pk_rc_phonelnamecount = 0 => 0.0545597794,
pk_rc_phonelnamecount = 1 => 0.1261859583,
0.066873267
);


pk_combo_addrcount_nb_mm := map(
pk_combo_addrcount_nb = 0 => 0.0599400599,
pk_combo_addrcount_nb = 1 => 0.0709372313,
pk_combo_addrcount_nb = 2 => 0.0611111111,
pk_combo_addrcount_nb = 3 => 0.0536828964,
pk_combo_addrcount_nb = 4 => 0.0997229917,
pk_combo_addrcount_nb = 5 => 0.0891089109,
0.066873267
);


pk_rc_phoneaddrcount_mm := map(
pk_rc_phoneaddrcount = 0 => 0.0572429907,
pk_rc_phoneaddrcount = 1 => 0.1165829146,
0.066873267
);


pk_combo_hphonecount_mm := map(
pk_combo_hphonecount = 0 => 0.0507099391,
pk_combo_hphonecount = 1 => 0.0960219479,
0.066873267
);


pk_ver_phncount_mm := map(
pk_ver_phncount = 0 => 0.0512941176,
pk_ver_phncount = 1 => 0.0782778865,
pk_ver_phncount = 2 => 0.0669077758,
pk_ver_phncount = 3 => 0.085995086,
0.066873267
);


pk_gong_did_phone_ct_nb_mm := map(
pk_gong_did_phone_ct_nb = -2 => 0.070092153,
pk_gong_did_phone_ct_nb = -1 => 0.066572238,
pk_gong_did_phone_ct_nb = 0 => 0.0514018692,
pk_gong_did_phone_ct_nb = 1 => 0.0641025641,
pk_gong_did_phone_ct_nb = 2 => 0.0652173913,
0.066873267
);


pk_combo_ssncount_mm := map(
pk_combo_ssncount = -1 => 0.0687563195,
pk_combo_ssncount = 0 => 0.1052631579,
pk_combo_ssncount = 1 => 0.0650566782,
0.066873267
);


pk_combo_dobcount_nb_mm := map(
pk_combo_dobcount_nb = 0 => 0.0665451231,
pk_combo_dobcount_nb = 1 => 0.0813559322,
pk_combo_dobcount_nb = 2 => 0.0782122905,
pk_combo_dobcount_nb = 3 => 0.0877192982,
pk_combo_dobcount_nb = 4 => 0.0570071259,
pk_combo_dobcount_nb = 5 => 0.0561122244,
pk_combo_dobcount_nb = 6 => 0.0774299835,
pk_combo_dobcount_nb = 7 => 0.06264637,
0.066873267
);


pk_eq_count_mm := map(
pk_eq_count = 0 => 0.0685685686,
pk_eq_count = 1 => 0.0796460177,
pk_eq_count = 2 => 0.0456852792,
pk_eq_count = 3 => 0.0457746479,
pk_eq_count = 4 => 0.0607028754,
pk_eq_count = 5 => 0.0734609415,
pk_eq_count = 6 => 0.0640895219,
0.066873267
);


pk_em_count_mm := map(
pk_em_count = 0 => 0.0669683258,
pk_em_count = 1 => 0.0646067416,
pk_em_count = 2 => 0.0680680681,
0.066873267
);


pk_em_only_count_mm := map(
pk_em_only_count = 0 => 0.0676051121,
pk_em_only_count = 1 => 0.0563063063,
pk_em_only_count = 2 => 0.0793650794,
pk_em_only_count = 3 => 0,
0.066873267
);


pk_pos_secondary_sources_mm := map(
pk_pos_secondary_sources = 0 => 0.0667437634,
pk_pos_secondary_sources = 1 => 0.0882352941,
pk_pos_secondary_sources = 2 => 0.0681818182,
0.066873267
);


pk_voter_flag_mm := map(
pk_voter_flag = -1 => 0.0637544274,
pk_voter_flag = 0 => 0.0689655172,
pk_voter_flag = 1 => 0.0666277031,
0.066873267
);


pk_fname_eda_sourced_type_lvl_mm := map(
pk_fname_eda_sourced_type_lvl = 0 => 0.0600938967,
pk_fname_eda_sourced_type_lvl = 1 => 0.065,
pk_fname_eda_sourced_type_lvl = 2 => 0.1081871345,
pk_fname_eda_sourced_type_lvl = 3 => 0.1515151515,
0.066873267
);


pk_lname_eda_sourced_type_lvl_mm := map(
pk_lname_eda_sourced_type_lvl = 0 => 0.0550381033,
pk_lname_eda_sourced_type_lvl = 1 => 0.0481586402,
pk_lname_eda_sourced_type_lvl = 2 => 0.113345521,
pk_lname_eda_sourced_type_lvl = 3 => 0.1400394477,
0.066873267
);


pk_add1_address_score_mm := map(
pk_add1_address_score = 0 => 0.0699838188,
pk_add1_address_score = 1 => 0.0647717956,
0.066873267
);


pk_add2_pos_sources_mm := map(
pk_add2_pos_sources = 0 => 0.062197873,
pk_add2_pos_sources = 1 => 0.0739784946,
pk_add2_pos_sources = 2 => 0.0686015831,
pk_add2_pos_sources = 3 => 0.0578512397,
pk_add2_pos_sources = 4 => 0.0609756098,
0.066873267
);


pk_ssnchar_invalid_or_recent_mm := map(
pk_ssnchar_invalid_or_recent = 0 => 0.0670711709,
pk_ssnchar_invalid_or_recent = 1 => 0.0303030303,
0.066873267
);


pk_infutor_risk_lvl_nb_mm := map(
pk_infutor_risk_lvl_nb = 0 => 0.0849358974,
pk_infutor_risk_lvl_nb = 1 => 0.0924130063,
pk_infutor_risk_lvl_nb = 2 => 0.068401937,
pk_infutor_risk_lvl_nb = 3 => 0.0390104662,
0.066873267
);


pk_yr_adl_eq_first_seen2_mm := map(
pk_yr_adl_eq_first_seen2 = -1 => 0.0686070686,
pk_yr_adl_eq_first_seen2 = 0 => 0.0909090909,
pk_yr_adl_eq_first_seen2 = 1 => 0,
pk_yr_adl_eq_first_seen2 = 2 => 0.1111111111,
pk_yr_adl_eq_first_seen2 = 3 => 0.0691823899,
pk_yr_adl_eq_first_seen2 = 4 => 0.0518518519,
pk_yr_adl_eq_first_seen2 = 5 => 0.0620155039,
pk_yr_adl_eq_first_seen2 = 6 => 0.0664652568,
pk_yr_adl_eq_first_seen2 = 7 => 0.0652741514,
pk_yr_adl_eq_first_seen2 = 8 => 0.0661764706,
pk_yr_adl_eq_first_seen2 = 9 => 0.0591016548,
pk_yr_adl_eq_first_seen2 = 10 => 0.069215557,
0.066873267
);


pk_yr_adl_em_first_seen2_mm := map(
pk_yr_adl_em_first_seen2 = -1 => 0.066922037,
pk_yr_adl_em_first_seen2 = 0 => 0.0454545455,
pk_yr_adl_em_first_seen2 = 1 => 0.0346820809,
pk_yr_adl_em_first_seen2 = 2 => 0.1,
pk_yr_adl_em_first_seen2 = 3 => 0.0708534622,
pk_yr_adl_em_first_seen2 = 4 => 0.0319148936,
0.066873267
);


pk_yr_adl_vo_first_seen2_mm := map(
pk_yr_adl_vo_first_seen2 = -1 => 0.0664678313,
pk_yr_adl_vo_first_seen2 = 0 => 0.0984848485,
pk_yr_adl_vo_first_seen2 = 1 => 0.0695652174,
pk_yr_adl_vo_first_seen2 = 2 => 0.0935960591,
pk_yr_adl_vo_first_seen2 = 3 => 0.0554821664,
0.066873267
);


pk_yr_adl_em_only_first_seen2_mm := map(
pk_yr_adl_em_only_first_seen2 = -1 => 0.0674384417,
pk_yr_adl_em_only_first_seen2 = 0 => 0,
pk_yr_adl_em_only_first_seen2 = 1 => 0.0909090909,
pk_yr_adl_em_only_first_seen2 = 2 => 0.0416666667,
pk_yr_adl_em_only_first_seen2 = 3 => 0.0651340996,
pk_yr_adl_em_only_first_seen2 = 4 => 0,
0.066873267
);


pk_yr_lname_change_date2_mm := map(
pk_yr_lname_change_date2 = -1 => 0.0654854959,
pk_yr_lname_change_date2 = 0 => 0.1403508772,
pk_yr_lname_change_date2 = 1 => 0.0703517588,
pk_yr_lname_change_date2 = 2 => 0.093220339,
0.066873267
);


pk_yr_gong_did_first_seen2_mm := map(
pk_yr_gong_did_first_seen2 = -1 => 0.0699909883,
pk_yr_gong_did_first_seen2 = 0 => 0.1230769231,
pk_yr_gong_did_first_seen2 = 1 => 0.1102362205,
pk_yr_gong_did_first_seen2 = 2 => 0.0675675676,
pk_yr_gong_did_first_seen2 = 3 => 0.0268456376,
pk_yr_gong_did_first_seen2 = 4 => 0.0609597925,
0.066873267
);


pk_yr_credit_first_seen2_mm := map(
pk_yr_credit_first_seen2 = -1 => 0.0686070686,
pk_yr_credit_first_seen2 = 0 => 0.0909090909,
pk_yr_credit_first_seen2 = 1 => 0,
pk_yr_credit_first_seen2 = 2 => 0.1111111111,
pk_yr_credit_first_seen2 = 3 => 0.0691823899,
pk_yr_credit_first_seen2 = 4 => 0.0518518519,
pk_yr_credit_first_seen2 = 5 => 0.0620155039,
pk_yr_credit_first_seen2 = 6 => 0.0664652568,
pk_yr_credit_first_seen2 = 7 => 0.0652741514,
pk_yr_credit_first_seen2 = 8 => 0.0661764706,
pk_yr_credit_first_seen2 = 9 => 0.0591016548,
pk_yr_credit_first_seen2 = 10 => 0.0697197539,
pk_yr_credit_first_seen2 = 11 => 0.0555555556,
0.066873267
);


pk_yr_header_first_seen2_mm := map(
pk_yr_header_first_seen2 = -1 => 0.0682242991,
pk_yr_header_first_seen2 = 0 => 0.1290322581,
pk_yr_header_first_seen2 = 1 => 0.0212765957,
pk_yr_header_first_seen2 = 2 => 0.0420168067,
pk_yr_header_first_seen2 = 3 => 0.1066666667,
pk_yr_header_first_seen2 = 4 => 0.0663900415,
pk_yr_header_first_seen2 = 5 => 0.0534069982,
pk_yr_header_first_seen2 = 6 => 0.0687203791,
pk_yr_header_first_seen2 = 7 => 0.0711060948,
0.066873267
);


pk_yr_infutor_first_seen2_mm := map(
pk_yr_infutor_first_seen2 = -1 => 0.0923603193,
pk_yr_infutor_first_seen2 = 0 => 0.1379310345,
pk_yr_infutor_first_seen2 = 1 => 0.0825688073,
pk_yr_infutor_first_seen2 = 2 => 0.078023407,
pk_yr_infutor_first_seen2 = 3 => 0.0621716287,
pk_yr_infutor_first_seen2 = 4 => 0.0415525114,
0.066873267
);


pk_EM_Only_ver_lvl_mm := map(
pk_EM_Only_ver_lvl = -1 => 0.0857142857,
pk_EM_Only_ver_lvl = 0 => 0.0673680325,
pk_EM_Only_ver_lvl = 1 => 0.0566037736,
pk_EM_Only_ver_lvl = 2 => 0.039800995,
pk_EM_Only_ver_lvl = 3 => 0.1006289308,
0.066873267
);


pk_add2_EM_ver_lvl_mm := map(
pk_add2_EM_ver_lvl = -1 => 0.2,
pk_add2_EM_ver_lvl = 0 => 0.067189063,
pk_add2_EM_ver_lvl = 1 => 0.027027027,
pk_add2_EM_ver_lvl = 2 => 0.0465116279,
0.066873267
);


pk_yrmo_adl_f_sn_mx_fcra2_mm := map(
pk_yrmo_adl_f_sn_mx_fcra2 = -1 => 0.068303095,
pk_yrmo_adl_f_sn_mx_fcra2 = 0 => 0,
pk_yrmo_adl_f_sn_mx_fcra2 = 1 => 0,
pk_yrmo_adl_f_sn_mx_fcra2 = 2 => 0.1666666667,
pk_yrmo_adl_f_sn_mx_fcra2 = 3 => 0,
pk_yrmo_adl_f_sn_mx_fcra2 = 4 => 0.0869565217,
pk_yrmo_adl_f_sn_mx_fcra2 = 5 => 0.0714285714,
pk_yrmo_adl_f_sn_mx_fcra2 = 6 => 0.0625,
pk_yrmo_adl_f_sn_mx_fcra2 = 7 => 0.0512820513,
pk_yrmo_adl_f_sn_mx_fcra2 = 8 => 0.0737704918,
pk_yrmo_adl_f_sn_mx_fcra2 = 9 => 0.0637450199,
pk_yrmo_adl_f_sn_mx_fcra2 = 10 => 0.0511945392,
pk_yrmo_adl_f_sn_mx_fcra2 = 11 => 0.0815347722,
pk_yrmo_adl_f_sn_mx_fcra2 = 12 => 0.0455927052,
pk_yrmo_adl_f_sn_mx_fcra2 = 13 => 0.0863309353,
pk_yrmo_adl_f_sn_mx_fcra2 = 14 => 0.0551558753,
pk_yrmo_adl_f_sn_mx_fcra2 = 15 => 0.0654121864,
pk_yrmo_adl_f_sn_mx_fcra2 = 16 => 0.0842911877,
0.066873267
);


pk_util_adl_source_count_mm := map(
pk_util_adl_source_count = 0 => 0.0671708185,
pk_util_adl_source_count = 1 => 0.068,
pk_util_adl_source_count = 2 => 0.0674897119,
pk_util_adl_source_count = 3 => 0.0613772455,
0.066873267
);


pk_util_adl_sourced_mm := map(
pk_util_adl_sourced = 0 => 0.0671708185,
pk_util_adl_sourced = 1 => 0.0667010044,
0.066873267
);


pk_util_adl_count_mm := map(
pk_util_adl_count = 0 => 0.0671708185,
pk_util_adl_count = 1 => 0.060840708,
pk_util_adl_count = 2 => 0.0698576973,
pk_util_adl_count = 3 => 0.0808435852,
pk_util_adl_count = 4 => 0.0588235294,
pk_util_adl_count = 5 => 0.0651815182,
0.066873267
);


pk_util_adl_nap_mm := map(
pk_util_adl_nap = -1 => 0.0665796345,
pk_util_adl_nap = 0 => 0.0659509202,
pk_util_adl_nap = 1 => 0.0693877551,
0.066873267
);


pk_util_add1_source_count_mm := map(
pk_util_add1_source_count = 0 => 0.0744081172,
pk_util_add1_source_count = 1 => 0.0646230323,
pk_util_add1_source_count = 2 => 0.0694883133,
pk_util_add1_source_count = 3 => 0.074941452,
pk_util_add1_source_count = 4 => 0.0397350993,
pk_util_add1_source_count = 5 => 0.021978022,
0.066873267
);


pk_util_add1_nap_mm := map(
pk_util_add1_nap = -1 => 0.0649957519,
pk_util_add1_nap = 0 => 0.0679505814,
pk_util_add1_nap = 1 => 0.0682926829,
0.066873267
);


pk_util_add2_source_count_mm := map(
pk_util_add2_source_count = 0 => 0.0692469107,
pk_util_add2_source_count = 1 => 0.0579710145,
pk_util_add2_source_count = 2 => 0.0576923077,
pk_util_add2_source_count = 3 => 0.0871559633,
0.066873267
);


pk_util_add2_nap_mm := map(
pk_util_add2_nap = -1 => 0.0666513445,
pk_util_add2_nap = 0 => 0.0637720488,
pk_util_add2_nap = 1 => 0.0849673203,
0.066873267
);


pk_rc_utiliaddr_phonecount_mm := map(
pk_rc_utiliaddr_phonecount = 0 => 0.0665449381,
pk_rc_utiliaddr_phonecount = 1 => 0.0682196339,
0.066873267
);


pk_utility_sourced_mm := map(
pk_utility_sourced = 0 => 0.0664599025,
pk_utility_sourced = 1 => 0.0680272109,
0.066873267
);


pk_yr_util_adl_D_firstseen2_mm := map(
pk_yr_util_adl_D_firstseen2 = -1 => 0.0680221811,
pk_yr_util_adl_D_firstseen2 = 0 => 0.0384615385,
pk_yr_util_adl_D_firstseen2 = 1 => 0.0589928058,
0.066873267
);


pk_yr_util_adl_E_firstseen2_mm := map(
pk_yr_util_adl_E_firstseen2 = -1 => 0.067020336,
pk_yr_util_adl_E_firstseen2 = 0 => 0.1355932203,
pk_yr_util_adl_E_firstseen2 = 1 => 0.0416666667,
pk_yr_util_adl_E_firstseen2 = 2 => 0,
pk_yr_util_adl_E_firstseen2 = 3 => 0.0540540541,
pk_yr_util_adl_E_firstseen2 = 4 => 0.023255814,
pk_yr_util_adl_E_firstseen2 = 5 => 0.064516129,
pk_yr_util_adl_E_firstseen2 = 6 => 0.0769230769,
pk_yr_util_adl_E_firstseen2 = 7 => 0.0629370629,
0.066873267
);


pk_yr_util_adl_F_firstseen2_mm := map(
pk_yr_util_adl_F_firstseen2 = -1 => 0.0686916816,
pk_yr_util_adl_F_firstseen2 = 0 => 0.1343283582,
pk_yr_util_adl_F_firstseen2 = 1 => 0.0784313725,
pk_yr_util_adl_F_firstseen2 = 2 => 0.0508108108,
0.066873267
);


pk_yr_util_adl_G_firstseen2_mm := map(
pk_yr_util_adl_G_firstseen2 = -1 => 0.0672171759,
pk_yr_util_adl_G_firstseen2 = 0 => 0.0833333333,
pk_yr_util_adl_G_firstseen2 = 1 => 0.0408163265,
pk_yr_util_adl_G_firstseen2 = 2 => 0,
0.066873267
);


pk_yr_util_adl_I_firstseen2_mm := map(
pk_yr_util_adl_I_firstseen2 = -1 => 0.0657464584,
pk_yr_util_adl_I_firstseen2 = 0 => 0.1333333333,
pk_yr_util_adl_I_firstseen2 = 1 => 0.0756756757,
pk_yr_util_adl_I_firstseen2 = 2 => 0.0657534247,
0.066873267
);


pk_yr_util_adl_U_firstseen2_mm := map(
pk_yr_util_adl_U_firstseen2 = -1 => 0.064826358,
pk_yr_util_adl_U_firstseen2 = 0 => 0.1428571429,
pk_yr_util_adl_U_firstseen2 = 1 => 0.1363636364,
pk_yr_util_adl_U_firstseen2 = 2 => 0.0483870968,
pk_yr_util_adl_U_firstseen2 = 3 => 0.078313253,
0.066873267
);


pk_mx_yr_util_adl_firstseen2_mm := map(
pk_mx_yr_util_adl_firstseen2 = -1 => 0.0671708185,
pk_mx_yr_util_adl_firstseen2 = 0 => 0.1214953271,
pk_mx_yr_util_adl_firstseen2 = 1 => 0.0652173913,
pk_mx_yr_util_adl_firstseen2 = 2 => 0.0922330097,
pk_mx_yr_util_adl_firstseen2 = 3 => 0.0774410774,
pk_mx_yr_util_adl_firstseen2 = 4 => 0.0640554876,
pk_mx_yr_util_adl_firstseen2 = 5 => 0.0555555556,
0.066873267
);


pk_yr_util_add1_E_firstseen2_mm := map(
pk_yr_util_add1_E_firstseen2 = -1 => 0.0677629201,
pk_yr_util_add1_E_firstseen2 = 0 => 0.064516129,
pk_yr_util_add1_E_firstseen2 = 1 => 0.0534591195,
0.066873267
);


pk_yr_util_add1_F_firstseen2_mm := map(
pk_yr_util_add1_F_firstseen2 = -1 => 0.0726079594,
pk_yr_util_add1_F_firstseen2 = 0 => 0.0701754386,
pk_yr_util_add1_F_firstseen2 = 1 => 0.0466666667,
0.066873267
);


pk_yr_util_add1_I_firstseen2_mm := map(
pk_yr_util_add1_I_firstseen2 = -1 => 0.0659858602,
pk_yr_util_add1_I_firstseen2 = 0 => 0.1011904762,
pk_yr_util_add1_I_firstseen2 = 1 => 0.0611510791,
pk_yr_util_add1_I_firstseen2 = 2 => 0.070610687,
pk_yr_util_add1_I_firstseen2 = 3 => 0.0434782609,
0.066873267
);


pk_yr_util_add1_U_firstseen2_mm := map(
pk_yr_util_add1_U_firstseen2 = -1 => 0.064191802,
pk_yr_util_add1_U_firstseen2 = 0 => 0.0951327434,
pk_yr_util_add1_U_firstseen2 = 1 => 0.0690335306,
0.066873267
);


pk_yr_util_add1_V_firstseen2_mm := map(
pk_yr_util_add1_V_firstseen2 = -1 => 0.0665004156,
pk_yr_util_add1_V_firstseen2 = 1 => 0.0862068966,
0.066873267
);


pk_yr_util_add1_Z_firstseen2_mm := map(
pk_yr_util_add1_Z_firstseen2 = -1 => 0.0757575758,
pk_yr_util_add1_Z_firstseen2 = 0 => 0.0852534562,
pk_yr_util_add1_Z_firstseen2 = 1 => 0.0603680982,
0.066873267
);


pk_mx_yr_util_add1_firstseen2_mm := map(
pk_mx_yr_util_add1_firstseen2 = -1 => 0.0744081172,
pk_mx_yr_util_add1_firstseen2 = 0 => 0.0778688525,
pk_mx_yr_util_add1_firstseen2 = 1 => 0.0645250623,
pk_mx_yr_util_add1_firstseen2 = 2 => 0.0599334073,
0.066873267
);


pk_yr_util_add2_D_firstseen2_mm := map(
pk_yr_util_add2_D_firstseen2 = -1 => 0.0665508254,
pk_yr_util_add2_D_firstseen2 = 1 => 0.0718085106,
0.066873267
);


pk_yr_util_add2_E_firstseen2_mm := map(
pk_yr_util_add2_E_firstseen2 = -1 => 0.0678527821,
pk_yr_util_add2_E_firstseen2 = 0 => 0.0625,
pk_yr_util_add2_E_firstseen2 = 1 => 0.0602409639,
pk_yr_util_add2_E_firstseen2 = 2 => 0.0416666667,
pk_yr_util_add2_E_firstseen2 = 3 => 0.0722891566,
0.066873267
);


pk_yr_util_add2_G_firstseen2_mm := map(
pk_yr_util_add2_G_firstseen2 = -1 => 0.0674491652,
pk_yr_util_add2_G_firstseen2 = 1 => 0.0243902439,
0.066873267
);


pk_yr_util_add2_U_firstseen2_mm := map(
pk_yr_util_add2_U_firstseen2 = -1 => 0.0665810712,
pk_yr_util_add2_U_firstseen2 = 0 => 0.0472440945,
pk_yr_util_add2_U_firstseen2 = 1 => 0.0742753623,
0.066873267
);


pk_yr_util_add2_Z_firstseen2_mm := map(
pk_yr_util_add2_Z_firstseen2 = -1 => 0.0687994496,
pk_yr_util_add2_Z_firstseen2 = 0 => 0.0510204082,
pk_yr_util_add2_Z_firstseen2 = 1 => 0.0655790147,
0.066873267
);


pk_nap_type_mm := map(
pk_nap_type = 0 => 0.0499231951,
pk_nap_type = 1 => 0.0492610837,
pk_nap_type = 2 => 0.0530726257,
pk_nap_type = 3 => 0.0965147453,
0.066873267
);


pk_EN_count_mm := map(
pk_EN_count = -1 => 0.0712900097,
pk_EN_count = 0 => 0.0654545455,
pk_EN_count = 1 => 0.0697498105,
pk_EN_count = 2 => 0.051342812,
pk_EN_count = 3 => 0.0789074355,
0.066873267
);


pk_dl_avail_mm := map(
pk_dl_avail = 0 => 0.0709677419,
pk_dl_avail = 1 => 0.060555786,
0.066873267
);


pk_DL_count_mm := map(
pk_DL_count = -1 => 0.069276446,
pk_DL_count = 0 => 0.0566343042,
pk_DL_count = 1 => 0.0719101124,
pk_DL_count = 2 => 0.0447761194,
pk_DL_count = 3 => 0.0632411067,
0.066873267
);


pk_yr_adl_EN_first_seen2_mm := map(
pk_yr_adl_EN_first_seen2 = -1 => 0.0712900097,
pk_yr_adl_EN_first_seen2 = 14 => 0.0614316239,
pk_yr_adl_EN_first_seen2 = 15 => 0.0507246377,
pk_yr_adl_EN_first_seen2 = 16 => 0.0674846626,
pk_yr_adl_EN_first_seen2 = 17 => 0.0847457627,
pk_yr_adl_EN_first_seen2 = 18 => 0.0643564356,
pk_yr_adl_EN_first_seen2 = 19 => 0.079245283,
pk_yr_adl_EN_first_seen2 = 20 => 0.0416666667,
pk_yr_adl_EN_first_seen2 = 21 => 0.0506756757,
pk_yr_adl_EN_first_seen2 = 22 => 0.0841121495,
0.066873267
);


pk_yr_adl_DL_first_seen2_mm := map(
pk_yr_adl_DL_first_seen2 = -9 => 0.0693327537,
pk_yr_adl_DL_first_seen2 = -1 => 0.0789473684,
pk_yr_adl_DL_first_seen2 = 0 => 0.0291262136,
pk_yr_adl_DL_first_seen2 = 1 => 0.0637636081,
0.066873267
);




		end;
end;







       if(      pk_segment2 = 1 ) then /* 1 EDA              */



pk_voter_count_mm := map(
pk_voter_count = 0 => 0.3403379868,
pk_voter_count = 1 => 0.3654342218,
pk_voter_count = 2 => 0.3268192689,
0.3356805567
);


pk_estimated_income_mm := map(
pk_estimated_income = -1 => 0.4166666667,
pk_estimated_income = 2 => 0.2248062016,
pk_estimated_income = 3 => 0.2089552239,
pk_estimated_income = 4 => 0.2535211268,
pk_estimated_income = 5 => 0.2744479495,
pk_estimated_income = 6 => 0.2798913043,
pk_estimated_income = 7 => 0.3196721311,
pk_estimated_income = 8 => 0.3146853147,
pk_estimated_income = 9 => 0.2492795389,
pk_estimated_income = 10 => 0.308056872,
pk_estimated_income = 11 => 0.3077731092,
pk_estimated_income = 12 => 0.2948717949,
pk_estimated_income = 13 => 0.2982608696,
pk_estimated_income = 14 => 0.295221843,
pk_estimated_income = 15 => 0.3156089194,
pk_estimated_income = 16 => 0.2956945573,
pk_estimated_income = 17 => 0.304,
pk_estimated_income = 18 => 0.2885691447,
pk_estimated_income = 19 => 0.3291700242,
pk_estimated_income = 20 => 0.3637992832,
pk_estimated_income = 21 => 0.4217687075,
pk_estimated_income = 22 => 0.4507042254,
0.3356805567
);


pk_yr_adl_pr_first_seen2_mm := map(
pk_yr_adl_pr_first_seen2 = -1 => 0.2951483421,
pk_yr_adl_pr_first_seen2 = 0 => 0.3333333333,
pk_yr_adl_pr_first_seen2 = 1 => 0.3557614827,
pk_yr_adl_pr_first_seen2 = 2 => 0.3447401774,
pk_yr_adl_pr_first_seen2 = 3 => 0.3540562576,
pk_yr_adl_pr_first_seen2 = 4 => 0.3376623377,
pk_yr_adl_pr_first_seen2 = 5 => 0.3854300385,
pk_yr_adl_pr_first_seen2 = 6 => 0.3790613718,
pk_yr_adl_pr_first_seen2 = 7 => 0.39375,
0.3356805567
);


pk_yr_adl_w_first_seen2_mm := map(
pk_yr_adl_w_first_seen2 = -1 => 0.3361595,
pk_yr_adl_w_first_seen2 = 0 => 0.2773722628,
pk_yr_adl_w_first_seen2 = 1 => 0.3346456693,
pk_yr_adl_w_first_seen2 = 2 => 0.3064516129,
0.3356805567
);


pk_yr_adl_pr_last_seen2_mm := map(
pk_yr_adl_pr_last_seen2 = -1 => 0.2951483421,
pk_yr_adl_pr_last_seen2 = 0 => 0.3642347778,
pk_yr_adl_pr_last_seen2 = 1 => 0.3728377978,
pk_yr_adl_pr_last_seen2 = 2 => 0.3700662252,
pk_yr_adl_pr_last_seen2 = 3 => 0.3234714004,
pk_yr_adl_pr_last_seen2 = 4 => 0.3339731286,
pk_yr_adl_pr_last_seen2 = 5 => 0.3438914027,
pk_yr_adl_pr_last_seen2 = 6 => 0.1764705882,
0.3356805567
);


pk_yr_adl_w_last_seen2_mm := map(
pk_yr_adl_w_last_seen2 = -1 => 0.3361595,
pk_yr_adl_w_last_seen2 = 1 => 0.3686868687,
pk_yr_adl_w_last_seen2 = 2 => 0.319835278,
0.3356805567
);


pk_addrs_sourced_lvl_mm := map(
pk_addrs_sourced_lvl = 0 => 0.3044979186,
pk_addrs_sourced_lvl = 1 => 0.3598503335,
pk_addrs_sourced_lvl = 2 => 0.367833587,
pk_addrs_sourced_lvl = 3 => 0.3975308642,
0.3356805567
);


pk_add1_own_level_mm := map(
pk_add1_own_level = -1 => 0.3030857741,
pk_add1_own_level = 0 => 0.3024580652,
pk_add1_own_level = 1 => 0.3089197383,
pk_add1_own_level = 2 => 0.3614223088,
pk_add1_own_level = 3 => 0.3756879636,
0.3356805567
);


pk_add2_own_level_mm := map(
pk_add2_own_level = 0 => 0.3299287894,
pk_add2_own_level = 1 => 0.3137254902,
pk_add2_own_level = 2 => 0.368358209,
pk_add2_own_level = 3 => 0.3778617937,
0.3356805567
);


pk_add3_own_level_mm := map(
pk_add3_own_level = 0 => 0.3324158911,
pk_add3_own_level = 1 => 0.3278312701,
pk_add3_own_level = 2 => 0.3632550336,
pk_add3_own_level = 3 => 0.3657255417,
0.3356805567
);


pk_prop_owned_sold_level_mm := map(
pk_prop_owned_sold_level = 0 => 0.2944717043,
pk_prop_owned_sold_level = 1 => 0.3576642336,
pk_prop_owned_sold_level = 2 => 0.366109619,
0.3356805567
);


pk_naprop_level2_mm := map(
pk_naprop_level2 = -2 => 0.275974026,
pk_naprop_level2 = -1 => 0.2895345847,
pk_naprop_level2 = 0 => 0.2607973422,
pk_naprop_level2 = 1 => 0.2919463087,
pk_naprop_level2 = 2 => 0.3017224312,
pk_naprop_level2 = 3 => 0.3162393162,
pk_naprop_level2 = 4 => 0.3519494204,
pk_naprop_level2 = 5 => 0.3654334934,
pk_naprop_level2 = 6 => 0.3623388582,
pk_naprop_level2 = 7 => 0.3809311651,
0.3356805567
);


pk_yr_add1_built_date2_mm := map(
pk_yr_add1_built_date2 = -4 => 0.3228021016,
pk_yr_add1_built_date2 = -2 => 0.3697478992,
pk_yr_add1_built_date2 = -1 => 0.3379737046,
pk_yr_add1_built_date2 = 0 => 0.3619176232,
pk_yr_add1_built_date2 = 1 => 0.3496456294,
pk_yr_add1_built_date2 = 2 => 0.3420707733,
pk_yr_add1_built_date2 = 3 => 0.3287635117,
0.3356805567
);


pk_add1_purchase_amount2_mm := map(
pk_add1_purchase_amount2 = -1 => 0.3385873347,
pk_add1_purchase_amount2 = 0 => 0.3070925553,
pk_add1_purchase_amount2 = 1 => 0.3442951101,
0.3356805567
);


pk_yr_add1_mortgage_date2_mm := map(
pk_yr_add1_mortgage_date2 = -1 => 0.3185538881,
pk_yr_add1_mortgage_date2 = 0 => 0.3327967807,
pk_yr_add1_mortgage_date2 = 1 => 0.3554216867,
pk_yr_add1_mortgage_date2 = 2 => 0.3442054129,
0.3356805567
);


pk_add1_mortgage_risk_mm := map(
pk_add1_mortgage_risk = -1 => 0.361735909,
pk_add1_mortgage_risk = 0 => 0.3774380601,
pk_add1_mortgage_risk = 1 => 0.3290203327,
pk_add1_mortgage_risk = 2 => 0.3145985401,
pk_add1_mortgage_risk = 3 => 0.3461249059,
0.3356805567
);


pk_add1_assessed_amount2_mm := map(
pk_add1_assessed_amount2 = -1 => 0.3365593192,
pk_add1_assessed_amount2 = 0 => 0.2837684449,
pk_add1_assessed_amount2 = 1 => 0.3035248042,
pk_add1_assessed_amount2 = 2 => 0.3315250151,
pk_add1_assessed_amount2 = 3 => 0.3204545455,
pk_add1_assessed_amount2 = 4 => 0.3325820992,
pk_add1_assessed_amount2 = 5 => 0.347826087,
pk_add1_assessed_amount2 = 6 => 0.3570927459,
0.3356805567
);


pk_yr_add1_mortgage_due_date2_mm := map(
pk_yr_add1_mortgage_due_date2 = -1 => 0.3336685583,
pk_yr_add1_mortgage_due_date2 = 0 => 0.3529411765,
pk_yr_add1_mortgage_due_date2 = 1 => 0.3335343788,
pk_yr_add1_mortgage_due_date2 = 2 => 0.3576900412,
0.3356805567
);


pk_yr_add1_date_first_seen2_mm := map(
pk_yr_add1_date_first_seen2 = -1 => 0.2811824081,
pk_yr_add1_date_first_seen2 = 0 => 0.3133333333,
pk_yr_add1_date_first_seen2 = 1 => 0.3525269263,
pk_yr_add1_date_first_seen2 = 2 => 0.316744186,
pk_yr_add1_date_first_seen2 = 3 => 0.3079281647,
pk_yr_add1_date_first_seen2 = 4 => 0.3294270833,
pk_yr_add1_date_first_seen2 = 5 => 0.3255886481,
pk_yr_add1_date_first_seen2 = 6 => 0.339753235,
pk_yr_add1_date_first_seen2 = 7 => 0.3199492815,
pk_yr_add1_date_first_seen2 = 8 => 0.359676578,
pk_yr_add1_date_first_seen2 = 9 => 0.3790344092,
pk_yr_add1_date_first_seen2 = 10 => 0.376344086,
0.3356805567
);


pk_add1_building_area2_mm := map(
pk_add1_building_area2 = -99 => 0.3253494467,
pk_add1_building_area2 = -4 => 0.2918124563,
pk_add1_building_area2 = -3 => 0.3226643599,
pk_add1_building_area2 = -2 => 0.3413333333,
pk_add1_building_area2 = -1 => 0.3540358744,
pk_add1_building_area2 = 0 => 0.3745318352,
pk_add1_building_area2 = 1 => 0.3055555556,
pk_add1_building_area2 = 2 => 0.3673469388,
pk_add1_building_area2 = 3 => 0.4,
pk_add1_building_area2 = 4 => 0.3116883117,
0.3356805567
);


pk_add1_no_of_buildings_mm := map(
pk_add1_no_of_buildings = -1 => 0.3403837606,
pk_add1_no_of_buildings = 0 => 0.3245336149,
pk_add1_no_of_buildings = 1 => 0.284144427,
pk_add1_no_of_buildings = 2 => 0.350877193,
0.3356805567
);


pk_add1_no_of_rooms_mm := map(
pk_add1_no_of_rooms = -1 => 0.3292874373,
pk_add1_no_of_rooms = 0 => 0.3542713568,
pk_add1_no_of_rooms = 1 => 0.3390142791,
pk_add1_no_of_rooms = 2 => 0.3416239941,
pk_add1_no_of_rooms = 3 => 0.3669936526,
pk_add1_no_of_rooms = 4 => 0.3636363636,
0.3356805567
);


pk_add1_no_of_baths_mm := map(
pk_add1_no_of_baths = -3 => 0.3269320298,
pk_add1_no_of_baths = -2 => 0.3283646889,
pk_add1_no_of_baths = -1 => 0.3462734584,
pk_add1_no_of_baths = 0 => 0.3769878391,
pk_add1_no_of_baths = 1 => 0.3600682594,
pk_add1_no_of_baths = 2 => 0.3285714286,
0.3356805567
);


pk_add1_parking_no_of_cars_mm := map(
pk_add1_parking_no_of_cars = 0 => 0.3286197117,
pk_add1_parking_no_of_cars = 1 => 0.3393561104,
pk_add1_parking_no_of_cars = 2 => 0.3550758642,
pk_add1_parking_no_of_cars = 3 => 0.3806763285,
0.3356805567
);


pk_add1_style_code_level_mm := map(
pk_add1_style_code_level = 0 => 0.3331072122,
pk_add1_style_code_level = 1 => 0.3833333333,
pk_add1_style_code_level = 2 => 0.3506493506,
pk_add1_style_code_level = 3 => 0.3734610123,
pk_add1_style_code_level = 4 => 0.3444662737,
0.3356805567
);


pk_prop1_sale_price2_mm := map(
pk_prop1_sale_price2 = 0 => 0.3295539666,
pk_prop1_sale_price2 = 1 => 0.3307189542,
pk_prop1_sale_price2 = 2 => 0.3659098388,
0.3356805567
);


pk_prop1_prev_purchase_price2_mm := map(
pk_prop1_prev_purchase_price2 = 0 => 0.3346326658,
pk_prop1_prev_purchase_price2 = 1 => 0.3414043584,
pk_prop1_prev_purchase_price2 = 2 => 0.3528089888,
0.3356805567
);


pk_yr_prop2_sale_date2_mm := map(
pk_yr_prop2_sale_date2 = 0 => 0.3318134204,
pk_yr_prop2_sale_date2 = 1 => 0.3155416013,
pk_yr_prop2_sale_date2 = 2 => 0.3644578313,
pk_yr_prop2_sale_date2 = 3 => 0.3978052126,
0.3356805567
);


pk_add2_land_use_risk_level_mm := map(
pk_add2_land_use_risk_level = 0 => 0.3333333333,
pk_add2_land_use_risk_level = 2 => 0.3340743093,
pk_add2_land_use_risk_level = 3 => 0.3371386678,
pk_add2_land_use_risk_level = 4 => 0.3338461538,
0.3356805567
);


pk_add2_no_of_buildings_mm := map(
pk_add2_no_of_buildings = -1 => 0.3404320567,
pk_add2_no_of_buildings = 0 => 0.3150159744,
pk_add2_no_of_buildings = 1 => 0.3162878788,
pk_add2_no_of_buildings = 2 => 0.3376623377,
0.3356805567
);


pk_add2_no_of_stories_mm := map(
pk_add2_no_of_stories = -1 => 0.3379802934,
pk_add2_no_of_stories = 0 => 0.3300071276,
pk_add2_no_of_stories = 1 => 0.3884057971,
0.3356805567
);


pk_add2_no_of_baths_mm := map(
pk_add2_no_of_baths = -3 => 0.3382566379,
pk_add2_no_of_baths = -2 => 0.319047619,
pk_add2_no_of_baths = -1 => 0.3359220093,
pk_add2_no_of_baths = 0 => 0.3425925926,
pk_add2_no_of_baths = 1 => 0.3924528302,
pk_add2_no_of_baths = 2 => 0.3208955224,
0.3356805567
);


pk_add2_garage_type_risk_lvl_mm := map(
pk_add2_garage_type_risk_lvl = 0 => 0.3668639053,
pk_add2_garage_type_risk_lvl = 1 => 0.3256392045,
pk_add2_garage_type_risk_lvl = 2 => 0.3067061144,
pk_add2_garage_type_risk_lvl = 3 => 0.3359575501,
0.3356805567
);


pk_add2_style_code_level_mm := map(
pk_add2_style_code_level = 0 => 0.3358378938,
pk_add2_style_code_level = 1 => 0.3187134503,
pk_add2_style_code_level = 2 => 0.3493975904,
pk_add2_style_code_level = 3 => 0.3441558442,
pk_add2_style_code_level = 4 => 0.3245356794,
0.3356805567
);


pk_yr_add2_built_date2_mm := map(
pk_yr_add2_built_date2 = -1 => 0.3358959757,
pk_yr_add2_built_date2 = 0 => 0.3014705882,
pk_yr_add2_built_date2 = 1 => 0.3147502904,
pk_yr_add2_built_date2 = 2 => 0.3376585928,
0.3356805567
);


pk_add2_purchase_amount2_mm := map(
pk_add2_purchase_amount2 = -1 => 0.3378880705,
pk_add2_purchase_amount2 = 0 => 0.3030540329,
pk_add2_purchase_amount2 = 1 => 0.3398479913,
0.3356805567
);


pk_add2_mortgage_amount2_mm := map(
pk_add2_mortgage_amount2 = -1 => 0.3338043357,
pk_add2_mortgage_amount2 = 0 => 0.3351758794,
pk_add2_mortgage_amount2 = 1 => 0.3347079038,
pk_add2_mortgage_amount2 = 2 => 0.3735099338,
0.3356805567
);


pk_add2_mortgage_risk_mm := map(
pk_add2_mortgage_risk = -1 => 0.3269164661,
pk_add2_mortgage_risk = 0 => 0.3706972639,
pk_add2_mortgage_risk = 1 => 0.3351808043,
pk_add2_mortgage_risk = 2 => 0.3448648649,
pk_add2_mortgage_risk = 3 => 0.3309178744,
0.3356805567
);


pk_yr_add2_mortgage_due_date2_mm := map(
pk_yr_add2_mortgage_due_date2 = -1 => 0.3353270307,
pk_yr_add2_mortgage_due_date2 = 0 => 0.3159366263,
pk_yr_add2_mortgage_due_date2 = 1 => 0.3747126437,
pk_yr_add2_mortgage_due_date2 = 2 => 0.3095499451,
pk_yr_add2_mortgage_due_date2 = 3 => 0.3454223795,
0.3356805567
);


pk_add2_assessed_amount2_mm := map(
pk_add2_assessed_amount2 = -1 => 0.3385187401,
pk_add2_assessed_amount2 = 0 => 0.3079256731,
pk_add2_assessed_amount2 = 1 => 0.3079062376,
pk_add2_assessed_amount2 = 2 => 0.3154545455,
pk_add2_assessed_amount2 = 3 => 0.3418803419,
pk_add2_assessed_amount2 = 4 => 0.3655172414,
0.3356805567
);


pk_yr_add2_date_first_seen2_mm := map(
pk_yr_add2_date_first_seen2 = -1 => 0.3457129757,
pk_yr_add2_date_first_seen2 = 0 => 0.2466327447,
pk_yr_add2_date_first_seen2 = 1 => 0.2870949403,
pk_yr_add2_date_first_seen2 = 2 => 0.3079569892,
pk_yr_add2_date_first_seen2 = 3 => 0.3135509397,
pk_yr_add2_date_first_seen2 = 4 => 0.3171545968,
pk_yr_add2_date_first_seen2 = 5 => 0.3375796178,
pk_yr_add2_date_first_seen2 = 6 => 0.3377483444,
pk_yr_add2_date_first_seen2 = 7 => 0.3407407407,
pk_yr_add2_date_first_seen2 = 8 => 0.3475865109,
pk_yr_add2_date_first_seen2 = 9 => 0.3766375546,
pk_yr_add2_date_first_seen2 = 10 => 0.3944399678,
pk_yr_add2_date_first_seen2 = 11 => 0.4058124174,
0.3356805567
);


pk_yr_add2_date_last_seen2_mm := map(
pk_yr_add2_date_last_seen2 = -1 => 0.3457129757,
pk_yr_add2_date_last_seen2 = 0 => 0.301033382,
pk_yr_add2_date_last_seen2 = 1 => 0.3663003663,
pk_yr_add2_date_last_seen2 = 2 => 0.3711911357,
pk_yr_add2_date_last_seen2 = 3 => 0.3686947478,
pk_yr_add2_date_last_seen2 = 4 => 0.3398058252,
pk_yr_add2_date_last_seen2 = 5 => 0.412042503,
pk_yr_add2_date_last_seen2 = 6 => 0.4121750159,
0.3356805567
);


pk_yr_add3_built_date2_mm := map(
pk_yr_add3_built_date2 = -1 => 0.3332337629,
pk_yr_add3_built_date2 = 0 => 0.2543859649,
pk_yr_add3_built_date2 = 1 => 0.3140407288,
pk_yr_add3_built_date2 = 2 => 0.3609467456,
pk_yr_add3_built_date2 = 3 => 0.3413883187,
0.3356805567
);


pk_add3_purchase_amount2_mm := map(
pk_add3_purchase_amount2 = -1 => 0.3355648254,
pk_add3_purchase_amount2 = 0 => 0.2982708934,
pk_add3_purchase_amount2 = 1 => 0.3121272366,
pk_add3_purchase_amount2 = 2 => 0.3009009009,
pk_add3_purchase_amount2 = 3 => 0.3508832698,
pk_add3_purchase_amount2 = 4 => 0.3568773234,
0.3356805567
);


pk_add3_mortgage_risk_mm := map(
pk_add3_mortgage_risk = -1 => 0.3356269113,
pk_add3_mortgage_risk = 0 => 0.3577981651,
pk_add3_mortgage_risk = 1 => 0.380952381,
pk_add3_mortgage_risk = 2 => 0.3335403727,
pk_add3_mortgage_risk = 3 => 0.3650793651,
pk_add3_mortgage_risk = 4 => 0.3537936914,
pk_add3_mortgage_risk = 5 => 0.3174603175,
0.3356805567
);


pk_yr_add3_mortgage_due_date2_mm := map(
pk_yr_add3_mortgage_due_date2 = -1 => 0.3349279305,
pk_yr_add3_mortgage_due_date2 = 0 => 0.3442041829,
pk_yr_add3_mortgage_due_date2 = 1 => 0.3356990774,
0.3356805567
);


pk_add3_assessed_amount2_mm := map(
pk_add3_assessed_amount2 = -1 => 0.3363754376,
pk_add3_assessed_amount2 = 0 => 0.3193027211,
pk_add3_assessed_amount2 = 1 => 0.2900302115,
pk_add3_assessed_amount2 = 2 => 0.3326094824,
pk_add3_assessed_amount2 = 3 => 0.3516225448,
0.3356805567
);


pk_yr_add3_date_first_seen2_mm := map(
pk_yr_add3_date_first_seen2 = -1 => 0.3570618264,
pk_yr_add3_date_first_seen2 = 0 => 0.2273631841,
pk_yr_add3_date_first_seen2 = 1 => 0.2542955326,
pk_yr_add3_date_first_seen2 = 2 => 0.3111936832,
pk_yr_add3_date_first_seen2 = 3 => 0.2933333333,
pk_yr_add3_date_first_seen2 = 4 => 0.2945932289,
pk_yr_add3_date_first_seen2 = 5 => 0.3426147889,
pk_yr_add3_date_first_seen2 = 6 => 0.3471540726,
pk_yr_add3_date_first_seen2 = 7 => 0.3472180899,
pk_yr_add3_date_first_seen2 = 8 => 0.3845468053,
pk_yr_add3_date_first_seen2 = 9 => 0.3863636364,
0.3356805567
);


pk_yr_add3_date_last_seen2_mm := map(
pk_yr_add3_date_last_seen2 = -1 => 0.3570618264,
pk_yr_add3_date_last_seen2 = 0 => 0.2568454962,
pk_yr_add3_date_last_seen2 = 1 => 0.3377598152,
pk_yr_add3_date_last_seen2 = 2 => 0.3362864526,
pk_yr_add3_date_last_seen2 = 3 => 0.3384080035,
pk_yr_add3_date_last_seen2 = 4 => 0.3639956092,
pk_yr_add3_date_last_seen2 = 5 => 0.3862998316,
pk_yr_add3_date_last_seen2 = 6 => 0.3712035996,
pk_yr_add3_date_last_seen2 = 7 => 0.4019337017,
pk_yr_add3_date_last_seen2 = 8 => 0.4327014218,
0.3356805567
);


pk_yr_attr_dt_last_purch2_mm := map(
pk_yr_attr_dt_last_purch2 = -1 => 0.3044575273,
pk_yr_attr_dt_last_purch2 = 0 => 0.3408805031,
pk_yr_attr_dt_last_purch2 = 1 => 0.3583441138,
pk_yr_attr_dt_last_purch2 = 2 => 0.3786900369,
pk_yr_attr_dt_last_purch2 = 3 => 0.3718464351,
pk_yr_attr_dt_last_purch2 = 4 => 0.3766061143,
pk_yr_attr_dt_last_purch2 = 5 => 0.3529623627,
pk_yr_attr_dt_last_purch2 = 6 => 0.3704532736,
pk_yr_attr_dt_last_purch2 = 7 => 0.3691460055,
0.3356805567
);


pk_yr_attr_date_last_sale2_mm := map(
pk_yr_attr_date_last_sale2 = -1 => 0.3275395464,
pk_yr_attr_date_last_sale2 = 0 => 0.3350568769,
pk_yr_attr_date_last_sale2 = 1 => 0.3547297297,
pk_yr_attr_date_last_sale2 = 2 => 0.3524038462,
pk_yr_attr_date_last_sale2 = 3 => 0.3405032468,
pk_yr_attr_date_last_sale2 = 4 => 0.393568147,
0.3356805567
);


pk_attr_num_watercraft24_mm := map(
pk_attr_num_watercraft24 = 0 => 0.335838053,
pk_attr_num_watercraft24 = 1 => 0.3186180422,
pk_attr_num_watercraft24 = 2 => 0.4615384615,
0.3356805567
);


pk_bk_level_mm := map(
pk_bk_level = 0 => 0.3406608696,
pk_bk_level = 1 => 0.3236423478,
pk_bk_level = 2 => 0.296890672,
0.3356805567
);


pk_eviction_level_mm := map(
pk_eviction_level = 0 => 0.3433551992,
pk_eviction_level = 1 => 0.28,
pk_eviction_level = 2 => 0.2538552788,
pk_eviction_level = 3 => 0.2404255319,
pk_eviction_level = 4 => 0.1914893617,
pk_eviction_level = 5 => 0.1942446043,
pk_eviction_level = 6 => 0.2708333333,
pk_eviction_level = 7 => 0.4444444444,
0.3356805567
);


pk_lien_type_level_mm := map(
pk_lien_type_level = 0 => 0.3533288197,
pk_lien_type_level = 1 => 0.3582089552,
pk_lien_type_level = 2 => 0.358974359,
pk_lien_type_level = 3 => 0.3165150262,
pk_lien_type_level = 4 => 0.3005649718,
pk_lien_type_level = 5 => 0.2846733058,
0.3356805567
);


pk_yr_ln_unrel_cj_f_sn2_mm := map(
pk_yr_ln_unrel_cj_f_sn2 = -1 => 0.3483456569,
pk_yr_ln_unrel_cj_f_sn2 = 0 => 0.3537735849,
pk_yr_ln_unrel_cj_f_sn2 = 1 => 0.3128712871,
pk_yr_ln_unrel_cj_f_sn2 = 2 => 0.2859185132,
pk_yr_ln_unrel_cj_f_sn2 = 3 => 0.2911498491,
0.3356805567
);


pk_yr_ln_unrel_lt_f_sn2_mm := map(
pk_yr_ln_unrel_lt_f_sn2 = -1 => 0.3391560409,
pk_yr_ln_unrel_lt_f_sn2 = 0 => 0.2037735849,
pk_yr_ln_unrel_lt_f_sn2 = 1 => 0.2463917526,
0.3356805567
);


pk_yr_ln_unrel_ot_f_sn2_mm := map(
pk_yr_ln_unrel_ot_f_sn2 = -1 => 0.3355500722,
pk_yr_ln_unrel_ot_f_sn2 = 0 => 0.3293991416,
pk_yr_ln_unrel_ot_f_sn2 = 1 => 0.2935323383,
pk_yr_ln_unrel_ot_f_sn2 = 2 => 0.3521554341,
0.3356805567
);


pk_yr_ln_unrel_sc_f_sn2_mm := map(
pk_yr_ln_unrel_sc_f_sn2 = -1 => 0.3416995005,
pk_yr_ln_unrel_sc_f_sn2 = 0 => 0.3060179257,
pk_yr_ln_unrel_sc_f_sn2 = 1 => 0.2822757112,
0.3356805567
);


pk_yr_attr_dt_l_eviction2_mm := map(
pk_yr_attr_dt_l_eviction2 = -1 => 0.3434091807,
pk_yr_attr_dt_l_eviction2 = 0 => 0.2213114754,
pk_yr_attr_dt_l_eviction2 = 1 => 0.2372881356,
pk_yr_attr_dt_l_eviction2 = 2 => 0.2534059946,
pk_yr_attr_dt_l_eviction2 = 3 => 0.2082018927,
pk_yr_attr_dt_l_eviction2 = 4 => 0.3046594982,
pk_yr_attr_dt_l_eviction2 = 5 => 0.2825928623,
0.3356805567
);


pk_yr_criminal_last_date2_mm := map(
pk_yr_criminal_last_date2 = -1 => 0.3392345477,
pk_yr_criminal_last_date2 = 0 => 0.3098290598,
pk_yr_criminal_last_date2 = 1 => 0.3286445013,
pk_yr_criminal_last_date2 = 2 => 0.311844078,
pk_yr_criminal_last_date2 = 3 => 0.2965641953,
pk_yr_criminal_last_date2 = 4 => 0.3286009293,
0.3356805567
);


pk_crime_level_mm := map(
pk_crime_level = 0 => 0.3390448665,
pk_crime_level = 1 => 0.3310943644,
pk_crime_level = 2 => 0.2688995215,
0.3356805567
);


pk_felony_recent_level_mm := map(
pk_felony_recent_level = 0 => 0.3364772,
pk_felony_recent_level = 1 => 0.2232142857,
pk_felony_recent_level = 2 => 0.2173913043,
pk_felony_recent_level = 3 => 0.298245614,
pk_felony_recent_level = 4 => 0.15625,
0.3356805567
);


pk_attr_total_number_derogs_mm := map(
pk_attr_total_number_derogs = 0 => 0.3589132208,
pk_attr_total_number_derogs = 1 => 0.3284754965,
pk_attr_total_number_derogs = 2 => 0.3270456283,
pk_attr_total_number_derogs = 3 => 0.3051101133,
0.3356805567
);


pk_yr_rc_ssnhighissue2_mm := map(
pk_yr_rc_ssnhighissue2 = -1 => 0.3237518911,
pk_yr_rc_ssnhighissue2 = 1 => 0.4358974359,
pk_yr_rc_ssnhighissue2 = 2 => 0.3181049069,
pk_yr_rc_ssnhighissue2 = 3 => 0.3157894737,
pk_yr_rc_ssnhighissue2 = 4 => 0.2837944664,
pk_yr_rc_ssnhighissue2 = 5 => 0.3115514334,
pk_yr_rc_ssnhighissue2 = 6 => 0.2987957282,
pk_yr_rc_ssnhighissue2 = 7 => 0.2825775656,
pk_yr_rc_ssnhighissue2 = 8 => 0.3246511628,
pk_yr_rc_ssnhighissue2 = 9 => 0.3072946582,
pk_yr_rc_ssnhighissue2 = 10 => 0.30654102,
pk_yr_rc_ssnhighissue2 = 11 => 0.3536908309,
pk_yr_rc_ssnhighissue2 = 12 => 0.3915407855,
pk_yr_rc_ssnhighissue2 = 13 => 0.3785900783,
pk_yr_rc_ssnhighissue2 = 14 => 0.4133922344,
0.3356805567
);


pk_PL_Sourced_Level_mm := map(
pk_PL_Sourced_Level = 0 => 0.3338227803,
pk_PL_Sourced_Level = 1 => 0.385620915,
pk_PL_Sourced_Level = 2 => 0.3483146067,
pk_PL_Sourced_Level = 3 => 0.3922413793,
0.3356805567
);


pk_prof_lic_cat_mm := map(
pk_prof_lic_cat = -1 => 0.3341184889,
pk_prof_lic_cat = 0 => 0.3325330132,
pk_prof_lic_cat = 1 => 0.3407682776,
pk_prof_lic_cat = 2 => 0.3614303959,
pk_prof_lic_cat = 3 => 0.4581673307,
0.3356805567
);


pk_add1_lres_mm := map(
pk_add1_lres = -1 => 0.2912317328,
pk_add1_lres = 0 => 0.3362831858,
pk_add1_lres = 1 => 0.3155080214,
pk_add1_lres = 2 => 0.3027888446,
pk_add1_lres = 3 => 0.3778801843,
pk_add1_lres = 4 => 0.3531998046,
pk_add1_lres = 5 => 0.3445378151,
pk_add1_lres = 6 => 0.3456917267,
pk_add1_lres = 7 => 0.3306613226,
pk_add1_lres = 8 => 0.3311376424,
pk_add1_lres = 9 => 0.3363154407,
pk_add1_lres = 10 => 0.3428347865,
pk_add1_lres = 11 => 0.3568588469,
0.3356805567
);


pk_add2_lres_mm := map(
pk_add2_lres = -2 => 0.3464711274,
pk_add2_lres = -1 => 0.3326626425,
pk_add2_lres = 0 => 0.3156384505,
pk_add2_lres = 1 => 0.2966579046,
pk_add2_lres = 2 => 0.2937516906,
pk_add2_lres = 3 => 0.2982646421,
pk_add2_lres = 4 => 0.33640553,
pk_add2_lres = 5 => 0.3312987453,
pk_add2_lres = 6 => 0.3301247772,
pk_add2_lres = 7 => 0.342603912,
pk_add2_lres = 8 => 0.3753981867,
pk_add2_lres = 9 => 0.3700221239,
pk_add2_lres = 10 => 0.3947368421,
0.3356805567
);


pk_add3_lres_mm := map(
pk_add3_lres = -2 => 0.3557008814,
pk_add3_lres = -1 => 0.3365317758,
pk_add3_lres = 0 => 0.306663744,
pk_add3_lres = 1 => 0.3291910331,
pk_add3_lres = 2 => 0.3458626284,
pk_add3_lres = 3 => 0.3568386181,
pk_add3_lres = 4 => 0.3533105023,
pk_add3_lres = 5 => 0.3702963703,
pk_add3_lres = 6 => 0.3343074226,
0.3356805567
);


pk_lres_flag_level_mm := map(
pk_lres_flag_level = 0 => 0.2912317328,
pk_lres_flag_level = 1 => 0.3473091364,
pk_lres_flag_level = 2 => 0.3372238835,
0.3356805567
);


pk_avg_lres_mm := map(
pk_avg_lres = -1 => 0.3102961918,
pk_avg_lres = 0 => 0.4285714286,
pk_avg_lres = 1 => 0.3979591837,
pk_avg_lres = 2 => 0.3365079365,
pk_avg_lres = 3 => 0.345323741,
pk_avg_lres = 4 => 0.2979351032,
pk_avg_lres = 5 => 0.2866666667,
pk_avg_lres = 6 => 0.2965686275,
pk_avg_lres = 7 => 0.3015873016,
pk_avg_lres = 8 => 0.3164345404,
pk_avg_lres = 9 => 0.3225,
pk_avg_lres = 10 => 0.3272877164,
pk_avg_lres = 11 => 0.3368592352,
pk_avg_lres = 12 => 0.3384404299,
pk_avg_lres = 13 => 0.3445874657,
pk_avg_lres = 14 => 0.3656532457,
pk_avg_lres = 15 => 0.3915431082,
0.3356805567
);


pk_addrs_5yr_mm := map(
pk_addrs_5yr = 0 => 0.3774153074,
pk_addrs_5yr = 1 => 0.3446775665,
pk_addrs_5yr = 2 => 0.2947676308,
pk_addrs_5yr = 3 => 0.2485414236,
pk_addrs_5yr = 4 => 0.2176287051,
0.3356805567
);


pk_addrs_10yr_mm := map(
pk_addrs_10yr = 0 => 0.3900066328,
pk_addrs_10yr = 1 => 0.3779555556,
pk_addrs_10yr = 2 => 0.34069895,
pk_addrs_10yr = 3 => 0.2663719259,
pk_addrs_10yr = 4 => 0.2361489555,
0.3356805567
);


pk_add_lres_year_avg2_mm := map(
pk_add_lres_year_avg2 = -1 => 0.3150684932,
pk_add_lres_year_avg2 = 0 => 0.3097643098,
pk_add_lres_year_avg2 = 1 => 0.2497932175,
pk_add_lres_year_avg2 = 2 => 0.2720326032,
pk_add_lres_year_avg2 = 3 => 0.268115942,
pk_add_lres_year_avg2 = 4 => 0.2909525707,
pk_add_lres_year_avg2 = 5 => 0.2914195334,
pk_add_lres_year_avg2 = 6 => 0.326538769,
pk_add_lres_year_avg2 = 7 => 0.3115797851,
pk_add_lres_year_avg2 = 8 => 0.3347107438,
pk_add_lres_year_avg2 = 9 => 0.3368421053,
pk_add_lres_year_avg2 = 10 => 0.3517073171,
pk_add_lres_year_avg2 = 11 => 0.3795309168,
pk_add_lres_year_avg2 = 12 => 0.3752310536,
pk_add_lres_year_avg2 = 13 => 0.3750865052,
pk_add_lres_year_avg2 = 14 => 0.3573529412,
pk_add_lres_year_avg2 = 15 => 0.390199637,
pk_add_lres_year_avg2 = 16 => 0.3825503356,
pk_add_lres_year_avg2 = 17 => 0.4054919908,
pk_add_lres_year_avg2 = 18 => 0.4263414634,
pk_add_lres_year_avg2 = 19 => 0.4332784185,
0.3356805567
);


pk_add_lres_year_max2_mm := map(
pk_add_lres_year_max2 = -1 => 0.3150684932,
pk_add_lres_year_max2 = 0 => 0.3701298701,
pk_add_lres_year_max2 = 1 => 0.2736625514,
pk_add_lres_year_max2 = 2 => 0.2924137931,
pk_add_lres_year_max2 = 3 => 0.2441860465,
pk_add_lres_year_max2 = 4 => 0.2754342432,
pk_add_lres_year_max2 = 5 => 0.2873862159,
pk_add_lres_year_max2 = 6 => 0.3061818182,
pk_add_lres_year_max2 = 7 => 0.2973760933,
pk_add_lres_year_max2 = 8 => 0.2919109027,
pk_add_lres_year_max2 = 9 => 0.3174502998,
pk_add_lres_year_max2 = 10 => 0.3295258621,
pk_add_lres_year_max2 = 11 => 0.3569892473,
pk_add_lres_year_max2 = 12 => 0.3617021277,
pk_add_lres_year_max2 = 13 => 0.3449275362,
pk_add_lres_year_max2 = 14 => 0.3700209644,
pk_add_lres_year_max2 = 15 => 0.365474339,
pk_add_lres_year_max2 = 16 => 0.3819049367,
pk_add_lres_year_max2 = 17 => 0.3886824807,
pk_add_lres_year_max2 = 18 => 0.4044665012,
0.3356805567
);


pk_nameperssn_count_mm := map(
pk_nameperssn_count = 0 => 0.3370662001,
pk_nameperssn_count = 1 => 0.3082747431,
pk_nameperssn_count = 2 => 0.3783783784,
0.3356805567
);


pk_ssns_per_adl_mm := map(
pk_ssns_per_adl = -1 => 0.3337507827,
pk_ssns_per_adl = 0 => 0.3405067104,
pk_ssns_per_adl = 1 => 0.3068783069,
pk_ssns_per_adl = 2 => 0.3064516129,
pk_ssns_per_adl = 3 => 0.2580645161,
pk_ssns_per_adl = 4 => 0.2380952381,
0.3356805567
);


pk_addrs_per_adl_mm := map(
pk_addrs_per_adl = -6 => 0.3216145833,
pk_addrs_per_adl = -5 => 0.3561565017,
pk_addrs_per_adl = -4 => 0.3655778894,
pk_addrs_per_adl = -3 => 0.3840761142,
pk_addrs_per_adl = -2 => 0.3741734734,
pk_addrs_per_adl = -1 => 0.3705137227,
pk_addrs_per_adl = 0 => 0.3360410147,
pk_addrs_per_adl = 1 => 0.3100921768,
pk_addrs_per_adl = 2 => 0.2914421211,
pk_addrs_per_adl = 3 => 0.2634803922,
0.3356805567
);


pk_phones_per_adl_mm := map(
pk_phones_per_adl = -1 => 0.3008291874,
pk_phones_per_adl = 0 => 0.3724820051,
pk_phones_per_adl = 1 => 0.2793753099,
pk_phones_per_adl = 2 => 0.2574257426,
0.3356805567
);


pk_addrs_per_ssn_mm := map(
pk_addrs_per_ssn = -4 => 0.3296130952,
pk_addrs_per_ssn = -3 => 0.3516618336,
pk_addrs_per_ssn = -2 => 0.3430745814,
pk_addrs_per_ssn = -1 => 0.3410774411,
pk_addrs_per_ssn = 0 => 0.3377986966,
pk_addrs_per_ssn = 1 => 0.3266082355,
pk_addrs_per_ssn = 2 => 0.3229813665,
pk_addrs_per_ssn = 3 => 0.2848189415,
0.3356805567
);


pk_adls_per_addr_mm := map(
pk_adls_per_addr = -102 => 0.2897016362,
pk_adls_per_addr = -101 => 0.3585657371,
pk_adls_per_addr = -2 => 0.3263157895,
pk_adls_per_addr = -1 => 0.3662337662,
pk_adls_per_addr = 0 => 0.413448735,
pk_adls_per_addr = 1 => 0.409268565,
pk_adls_per_addr = 2 => 0.3669767442,
pk_adls_per_addr = 3 => 0.3430944056,
pk_adls_per_addr = 4 => 0.3634435963,
pk_adls_per_addr = 5 => 0.340256297,
pk_adls_per_addr = 6 => 0.3570029383,
pk_adls_per_addr = 7 => 0.3465739821,
pk_adls_per_addr = 8 => 0.3356242841,
pk_adls_per_addr = 9 => 0.3513685551,
pk_adls_per_addr = 10 => 0.318501171,
pk_adls_per_addr = 11 => 0.3125656283,
pk_adls_per_addr = 12 => 0.2981481481,
pk_adls_per_addr = 13 => 0.2850599013,
pk_adls_per_addr = 100 => 0.3422619048,
pk_adls_per_addr = 101 => 0.3242009132,
pk_adls_per_addr = 102 => 0.2990605428,
0.3356805567
);


pk_phones_per_addr_mm := map(
pk_phones_per_addr = -1 => 0.2718668407,
pk_phones_per_addr = 0 => 0.3778247908,
pk_phones_per_addr = 1 => 0.2696086882,
pk_phones_per_addr = 2 => 0.2434094903,
pk_phones_per_addr = 3 => 0.2299168975,
pk_phones_per_addr = 100 => 0.275,
pk_phones_per_addr = 101 => 0.3571428571,
pk_phones_per_addr = 102 => 0.2867435159,
pk_phones_per_addr = 103 => 0.2962734832,
0.3356805567
);


pk_adls_per_phone_mm := map(
pk_adls_per_phone = -2 => 0.293809939,
pk_adls_per_phone = -1 => 0.3334908232,
pk_adls_per_phone = 0 => 0.3518983602,
pk_adls_per_phone = 1 => 0.3337595908,
0.3356805567
);


pk_addrs_per_adl_c6_mm := map(
pk_addrs_per_adl_c6 = 0 => 0.340412092,
pk_addrs_per_adl_c6 = 1 => 0.2825763217,
pk_addrs_per_adl_c6 = 2 => 0.2941176471,
pk_addrs_per_adl_c6 = 3 => 0.2272727273,
0.3356805567
);


pk_phones_per_adl_c6_mm := map(
pk_phones_per_adl_c6 = -2 => 0.3405928429,
pk_phones_per_adl_c6 = -1 => 0.2918391484,
pk_phones_per_adl_c6 = 0 => 0.2862745098,
pk_phones_per_adl_c6 = 1 => 0.380952381,
0.3356805567
);


pk_adls_per_addr_c6_mm := map(
pk_adls_per_addr_c6 = 0 => 0.348388292,
pk_adls_per_addr_c6 = 1 => 0.3007955936,
pk_adls_per_addr_c6 = 2 => 0.2567204301,
pk_adls_per_addr_c6 = 3 => 0.2430555556,
pk_adls_per_addr_c6 = 4 => 0.1875,
pk_adls_per_addr_c6 = 100 => 0.3078287869,
pk_adls_per_addr_c6 = 101 => 0.2873345936,
pk_adls_per_addr_c6 = 102 => 0.0769230769,
0.3356805567
);


pk_ssns_per_addr_c6_mm := map(
pk_ssns_per_addr_c6 = 0 => 0.3483190987,
pk_ssns_per_addr_c6 = 1 => 0.2922194335,
pk_ssns_per_addr_c6 = 2 => 0.254985755,
pk_ssns_per_addr_c6 = 3 => 0.2333333333,
pk_ssns_per_addr_c6 = 4 => 0.3,
pk_ssns_per_addr_c6 = 5 => 0.1428571429,
pk_ssns_per_addr_c6 = 6 => 0.2222222222,
pk_ssns_per_addr_c6 = 100 => 0.3089039597,
pk_ssns_per_addr_c6 = 101 => 0.2832080201,
pk_ssns_per_addr_c6 = 102 => 0.2142857143,
pk_ssns_per_addr_c6 = 103 => 0,
pk_ssns_per_addr_c6 = 104 => 0.25,
0.3356805567
);


pk_phones_per_addr_c6_mm := map(
pk_phones_per_addr_c6 = -1 => 0.3531433974,
pk_phones_per_addr_c6 = 0 => 0.3056646102,
pk_phones_per_addr_c6 = 1 => 0.2758112094,
pk_phones_per_addr_c6 = 2 => 0.3703703704,
pk_phones_per_addr_c6 = 100 => 0.3076923077,
pk_phones_per_addr_c6 = 101 => 0.3050672182,
pk_phones_per_addr_c6 = 102 => 0.293814433,
0.3356805567
);


pk_adls_per_phone_c6_mm := map(
pk_adls_per_phone_c6 = 0 => 0.3408068521,
pk_adls_per_phone_c6 = 1 => 0.3108199379,
pk_adls_per_phone_c6 = 2 => 0.376344086,
0.3356805567
);


pk_attr_addrs_last30_mm := map(
pk_attr_addrs_last30 = 0 => 0.3362217408,
pk_attr_addrs_last30 = 1 => 0.2295918367,
pk_attr_addrs_last30 = 2 => 0.4545454545,
0.3356805567
);


pk_attr_addrs_last36_mm := map(
pk_attr_addrs_last36 = 0 => 0.3668052092,
pk_attr_addrs_last36 = 1 => 0.3397086623,
pk_attr_addrs_last36 = 2 => 0.2891193997,
pk_attr_addrs_last36 = 3 => 0.275,
pk_attr_addrs_last36 = 4 => 0.2453936348,
pk_attr_addrs_last36 = 5 => 0.2173174873,
pk_attr_addrs_last36 = 6 => 0.2035928144,
0.3356805567
);


pk_attr_addrs_last_level_mm := map(
pk_attr_addrs_last_level = 0 => 0.3668052092,
pk_attr_addrs_last_level = 1 => 0.3318886861,
pk_attr_addrs_last_level = 2 => 0.3130601793,
pk_attr_addrs_last_level = 3 => 0.2866415094,
pk_attr_addrs_last_level = 4 => 0.2514204545,
pk_attr_addrs_last_level = 5 => 0.2415458937,
0.3356805567
);


pk_ams_class_level_mm := map(
pk_ams_class_level = -1000001 => 0.340855573,
pk_ams_class_level = 0 => 0.296875,
pk_ams_class_level = 1 => 0.3768115942,
pk_ams_class_level = 2 => 0.3012048193,
pk_ams_class_level = 3 => 0.2016806723,
pk_ams_class_level = 4 => 0.2786885246,
pk_ams_class_level = 5 => 0.2615012107,
pk_ams_class_level = 6 => 0.2907180385,
pk_ams_class_level = 7 => 0.2737276479,
pk_ams_class_level = 8 => 0.3143074581,
pk_ams_class_level = 1000000 => 0.3535714286,
pk_ams_class_level = 1000001 => 0.2857142857,
pk_ams_class_level = 1000002 => 0.3555555556,
pk_ams_class_level = 1000003 => 0.3448275862,
pk_ams_class_level = 1000004 => 0.3619047619,
pk_ams_class_level = 1000005 => 0.3805970149,
0.3356805567
);


pk_ams_income_level_code_mm := map(
pk_ams_income_level_code = -1 => 0.340855573,
pk_ams_income_level_code = 0 => 0.2834008097,
pk_ams_income_level_code = 1 => 0.2470588235,
pk_ams_income_level_code = 2 => 0.2849604222,
pk_ams_income_level_code = 3 => 0.3091397849,
pk_ams_income_level_code = 4 => 0.3423967774,
pk_ams_income_level_code = 5 => 0.3220640569,
pk_ams_income_level_code = 6 => 0.3972868217,
0.3356805567
);


pk_ams_college_tier_mm := map(
pk_ams_college_tier = -1 => 0.3351998114,
pk_ams_college_tier = 0 => 0.2916666667,
pk_ams_college_tier = 1 => 0.3421052632,
pk_ams_college_tier = 2 => 0.3773584906,
pk_ams_college_tier = 3 => 0.3636363636,
pk_ams_college_tier = 4 => 0.3338028169,
pk_ams_college_tier = 5 => 0.3210831721,
pk_ams_college_tier = 6 => 0.3621262458,
0.3356805567
);


pk_yr_rc_correct_dob2_mm := map(
pk_yr_rc_correct_dob2 = -1 => 0.3356054988,
pk_yr_rc_correct_dob2 = 21 => 0.125,
pk_yr_rc_correct_dob2 = 33 => 0.2934782609,
pk_yr_rc_correct_dob2 = 61 => 0.332010582,
pk_yr_rc_correct_dob2 = 99 => 0.4088669951,
0.3356805567
);


pk_ams_age_mm := map(
pk_ams_age = -1 => 0.3412796826,
pk_ams_age = 21 => 0.3164179104,
pk_ams_age = 22 => 0.2700729927,
pk_ams_age = 23 => 0.2836879433,
pk_ams_age = 24 => 0.2298136646,
pk_ams_age = 25 => 0.2447552448,
pk_ams_age = 29 => 0.2686567164,
pk_ams_age = 99 => 0.3016079965,
0.3356805567
);


pk_inferred_age_mm := map(
pk_inferred_age = -1 => 0.322875817,
pk_inferred_age = 18 => 0.3782051282,
pk_inferred_age = 19 => 0.3653846154,
pk_inferred_age = 20 => 0.3191489362,
pk_inferred_age = 21 => 0.2873900293,
pk_inferred_age = 22 => 0.3012658228,
pk_inferred_age = 24 => 0.2826530612,
pk_inferred_age = 34 => 0.2758197977,
pk_inferred_age = 37 => 0.3087192324,
pk_inferred_age = 41 => 0.3210013908,
pk_inferred_age = 42 => 0.3337250294,
pk_inferred_age = 43 => 0.3336853221,
pk_inferred_age = 44 => 0.3247191011,
pk_inferred_age = 46 => 0.3155579989,
pk_inferred_age = 48 => 0.3408360129,
pk_inferred_age = 52 => 0.3461653238,
pk_inferred_age = 56 => 0.3824701195,
pk_inferred_age = 61 => 0.3841421736,
pk_inferred_age = 99 => 0.4000416493,
0.3356805567
);


pk_add2_avm_auto_diff4_lvl_mm := map(
pk_add2_avm_auto_diff4_lvl = -1 => 0.339123208,
pk_add2_avm_auto_diff4_lvl = 0 => 0.3297234255,
pk_add2_avm_auto_diff4_lvl = 1 => 0.2569444444,
0.3356805567
);


pk2_add1_avm_sp_mm := map(
pk2_add1_avm_sp = 0 => 0.332010282,
pk2_add1_avm_sp = 1 => 0.318794964,
pk2_add1_avm_sp = 2 => 0.3406668958,
pk2_add1_avm_sp = 3 => 0.3616515348,
0.3356805567
);


pk2_add1_avm_ta_mm := map(
pk2_add1_avm_ta = 0 => 0.2457813646,
pk2_add1_avm_ta = 1 => 0.3275510204,
pk2_add1_avm_ta = 2 => 0.3321060383,
pk2_add1_avm_ta = 3 => 0.3671638565,
pk2_add1_avm_ta = 4 => 0.4064327485,
0.3356805567
);


pk2_add1_avm_pi_mm := map(
pk2_add1_avm_pi = 0 => 0.1951219512,
pk2_add1_avm_pi = 1 => 0.2967032967,
pk2_add1_avm_pi = 2 => 0.3364056978,
pk2_add1_avm_pi = 3 => 0.3767685988,
0.3356805567
);


pk2_ADD1_AVM_MED_mm := map(
pk2_ADD1_AVM_MED = 0 => 0.225862069,
pk2_ADD1_AVM_MED = 1 => 0.2536066819,
pk2_ADD1_AVM_MED = 2 => 0.2863509749,
pk2_ADD1_AVM_MED = 3 => 0.3251670379,
pk2_ADD1_AVM_MED = 4 => 0.3282219159,
pk2_ADD1_AVM_MED = 5 => 0.3540412228,
pk2_ADD1_AVM_MED = 6 => 0.4120879121,
pk2_ADD1_AVM_MED = 7 => 0.3358197595,
0.3356805567
);


pk2_add1_avm_to_med_ratio_mm := map(
pk2_add1_avm_to_med_ratio = 0 => 0.3258913033,
pk2_add1_avm_to_med_ratio = 1 => 0.3447094801,
pk2_add1_avm_to_med_ratio = 2 => 0.3430493274,
pk2_add1_avm_to_med_ratio = 3 => 0.3593410009,
pk2_add1_avm_to_med_ratio = 4 => 0.3681632653,
pk2_add1_avm_to_med_ratio = 5 => 0.3282868526,
0.3356805567
);


pk2_yr_add1_avm_rec_dt_mm := map(
pk2_yr_add1_avm_rec_dt = 0 => 0.2881355932,
pk2_yr_add1_avm_rec_dt = 1 => 0.3351800554,
pk2_yr_add1_avm_rec_dt = 2 => 0.336236716,
pk2_yr_add1_avm_rec_dt = 3 => 0.333895684,
pk2_yr_add1_avm_rec_dt = 4 => 0.3507979524,
0.3356805567
);


pk2_yr_add1_avm_assess_year_mm := map(
pk2_yr_add1_avm_assess_year = 0 => 0.3275734907,
pk2_yr_add1_avm_assess_year = 1 => 0.3785575049,
pk2_yr_add1_avm_assess_year = 2 => 0.3386744852,
0.3356805567
);


pk_dist_a1toa3_mm := map(
pk_dist_a1toa3 = 0 => 0.3536152171,
pk_dist_a1toa3 = 1 => 0.3245376079,
pk_dist_a1toa3 = 2 => 0.325378614,
pk_dist_a1toa3 = 3 => 0.3220338983,
pk_dist_a1toa3 = 4 => 0.3269503546,
pk_dist_a1toa3 = 5 => 0.363372093,
pk_dist_a1toa3 = 6 => 0.3576457336,
0.3356805567
);


pk_rc_disthphoneaddr_mm := map(
pk_rc_disthphoneaddr = 0 => 0.3566558898,
pk_rc_disthphoneaddr = 1 => 0.2824675325,
pk_rc_disthphoneaddr = 2 => 0.2526652452,
pk_rc_disthphoneaddr = 3 => 0.236888627,
pk_rc_disthphoneaddr = 4 => 0.2432432432,
0.3356805567
);


pk_out_st_division_lvl_mm := map(
pk_out_st_division_lvl = -1 => 0.25,
pk_out_st_division_lvl = 0 => 0.3334784502,
pk_out_st_division_lvl = 1 => 0.3077656027,
pk_out_st_division_lvl = 2 => 0.4021421616,
pk_out_st_division_lvl = 3 => 0.3156713067,
pk_out_st_division_lvl = 4 => 0.3282538955,
pk_out_st_division_lvl = 5 => 0.358649789,
pk_out_st_division_lvl = 6 => 0.3667035398,
pk_out_st_division_lvl = 7 => 0.3284148398,
pk_out_st_division_lvl = 8 => 0.3262886598,
0.3356805567
);


pk_impulse_count_mm := map(
pk_impulse_count = 0 => 0.3398732529,
pk_impulse_count = 1 => 0.239447429,
pk_impulse_count = 2 => 0.2804532578,
0.3356805567
);


pk_derog_total_mm := map(
pk_derog_total = -4 => 0.3838383838,
pk_derog_total = -3 => 0.3941258186,
pk_derog_total = -2 => 0.3443526171,
pk_derog_total = -1 => 0.3306956808,
pk_derog_total = 0 => 0.2727272727,
pk_derog_total = 1 => 0.3284754965,
pk_derog_total = 2 => 0.3270456283,
pk_derog_total = 3 => 0.3051101133,
0.3356805567
);


pk_attr_num_nonderogs90_b_mm := map(
pk_attr_num_nonderogs90_b = 0 => 0.2857142857,
pk_attr_num_nonderogs90_b = 1 => 0.2967625899,
pk_attr_num_nonderogs90_b = 2 => 0.2476889614,
pk_attr_num_nonderogs90_b = 3 => 0.2621145374,
pk_attr_num_nonderogs90_b = 4 => 0.2676056338,
pk_attr_num_nonderogs90_b = 10 => 0.3333333333,
pk_attr_num_nonderogs90_b = 11 => 0.3158317707,
pk_attr_num_nonderogs90_b = 12 => 0.3420793951,
pk_attr_num_nonderogs90_b = 13 => 0.3911564626,
pk_attr_num_nonderogs90_b = 14 => 0.3651821862,
0.3356805567
);


pk_add1_unit_count2_mm := map(
pk_add1_unit_count2 = 0 => 0.3427080599,
pk_add1_unit_count2 = 1 => 0.3526011561,
pk_add1_unit_count2 = 2 => 0.2931506849,
pk_add1_unit_count2 = 3 => 0.2907771136,
0.3356805567
);


pk_ssns_per_addr2_mm := map(
pk_ssns_per_addr2 = -101 => 0.3027210884,
pk_ssns_per_addr2 = -2 => 0.3314917127,
pk_ssns_per_addr2 = -1 => 0.3904494382,
pk_ssns_per_addr2 = 0 => 0.4110054348,
pk_ssns_per_addr2 = 1 => 0.4095711622,
pk_ssns_per_addr2 = 2 => 0.3676826318,
pk_ssns_per_addr2 = 3 => 0.3532736693,
pk_ssns_per_addr2 = 4 => 0.3480613165,
pk_ssns_per_addr2 = 5 => 0.3552570635,
pk_ssns_per_addr2 = 6 => 0.3550472402,
pk_ssns_per_addr2 = 7 => 0.3466528282,
pk_ssns_per_addr2 = 8 => 0.3391171994,
pk_ssns_per_addr2 = 9 => 0.340107362,
pk_ssns_per_addr2 = 10 => 0.3098012337,
pk_ssns_per_addr2 = 11 => 0.299333675,
pk_ssns_per_addr2 = 12 => 0.2785898538,
pk_ssns_per_addr2 = 100 => 0.3693693694,
pk_ssns_per_addr2 = 101 => 0.255,
pk_ssns_per_addr2 = 102 => 0.3156586578,
pk_ssns_per_addr2 = 103 => 0.2781954887,
0.3356805567
);


pk_yr_add1_assess_val_yr2_mm := map(
pk_yr_add1_assess_val_yr2 = -1 => 0.3157803867,
pk_yr_add1_assess_val_yr2 = 0 => 0.3442478655,
pk_yr_add1_assess_val_yr2 = 1 => 0.3718887262,
pk_yr_add1_assess_val_yr2 = 2 => 0.3105360444,
0.3356805567
);


pk_prop_owned_assess_count_mm := map(
pk_prop_owned_assess_count = 0 => 0.3211239117,
pk_prop_owned_assess_count = 1 => 0.3601585941,
pk_prop_owned_assess_count = 2 => 0.3597320725,
pk_prop_owned_assess_count = 3 => 0.3748488513,
pk_prop_owned_assess_count = 4 => 0.3475452196,
0.3356805567
);


pk_yr_prop1_prev_purch_dt2_mm := map(
pk_yr_prop1_prev_purch_dt2 = -1 => 0.3318099358,
pk_yr_prop1_prev_purch_dt2 = 0 => 0.3228699552,
pk_yr_prop1_prev_purch_dt2 = 1 => 0.3863216266,
pk_yr_prop1_prev_purch_dt2 = 2 => 0.3328290469,
pk_yr_prop1_prev_purch_dt2 = 3 => 0.3407510431,
pk_yr_prop1_prev_purch_dt2 = 4 => 0.3487179487,
pk_yr_prop1_prev_purch_dt2 = 5 => 0.3659305994,
pk_yr_prop1_prev_purch_dt2 = 6 => 0.3393810032,
pk_yr_prop1_prev_purch_dt2 = 7 => 0.3722222222,
0.3356805567
);


pk_yr_prop2_prev_purch_dt2_mm := map(
pk_yr_prop2_prev_purch_dt2 = -1 => 0.3347732181,
pk_yr_prop2_prev_purch_dt2 = 0 => 0.3441981747,
pk_yr_prop2_prev_purch_dt2 = 1 => 0.3556818182,
0.3356805567
);


pk_yr_add2_assess_val_yr2_mm := map(
pk_yr_add2_assess_val_yr2 = -1 => 0.3360638846,
pk_yr_add2_assess_val_yr2 = 1 => 0.3571428571,
pk_yr_add2_assess_val_yr2 = 2 => 0.3323919037,
0.3356805567
);


pk_c_bargains_mm := map(
pk_c_bargains = -9 => 0.3719298246,
pk_c_bargains = 0 => 0.3580084082,
pk_c_bargains = 1 => 0.3385276733,
pk_c_bargains = 2 => 0.327457265,
pk_c_bargains = 3 => 0.3158621642,
0.3356805567
);


pk_c_bel_edu_mm := map(
pk_c_bel_edu = -9 => 0.3719298246,
pk_c_bel_edu = 0 => 0.3850025164,
pk_c_bel_edu = 1 => 0.3712308453,
pk_c_bel_edu = 2 => 0.3525214082,
pk_c_bel_edu = 3 => 0.3519313305,
pk_c_bel_edu = 4 => 0.3424200278,
pk_c_bel_edu = 5 => 0.3486682809,
pk_c_bel_edu = 6 => 0.3442668137,
pk_c_bel_edu = 7 => 0.3228355474,
pk_c_bel_edu = 8 => 0.3070048309,
0.3356805567
);


pk_c_lowrent_mm := map(
pk_c_lowrent = -9 => 0.3719298246,
pk_c_lowrent = 0 => 0.3607388627,
pk_c_lowrent = 1 => 0.3651771957,
pk_c_lowrent = 2 => 0.3448519041,
pk_c_lowrent = 3 => 0.3314894206,
pk_c_lowrent = 4 => 0.3181645088,
pk_c_lowrent = 5 => 0.3215833904,
0.3356805567
);


pk_c_med_hval_mm := map(
pk_c_med_hval = -9 => 0.3719298246,
pk_c_med_hval = 0 => 0.2975231274,
pk_c_med_hval = 1 => 0.3179502111,
pk_c_med_hval = 2 => 0.3241537579,
pk_c_med_hval = 3 => 0.3348139922,
pk_c_med_hval = 4 => 0.3410714286,
pk_c_med_hval = 5 => 0.3553921569,
pk_c_med_hval = 6 => 0.3559670782,
pk_c_med_hval = 7 => 0.3684744045,
pk_c_med_hval = 8 => 0.3700707786,
pk_c_med_hval = 9 => 0.4062007357,
0.3356805567
);


pk_rel_count_mm := map(
pk_rel_count = -9 => 0.3431372549,
pk_rel_count = -3 => 0.3767908309,
pk_rel_count = -2 => 0.4206219313,
pk_rel_count = -1 => 0.4013933548,
pk_rel_count = 0 => 0.3684433164,
pk_rel_count = 1 => 0.3672600619,
pk_rel_count = 2 => 0.3484093522,
pk_rel_count = 3 => 0.3490228461,
pk_rel_count = 4 => 0.3283285094,
pk_rel_count = 5 => 0.3040050457,
pk_rel_count = 6 => 0.2713870432,
0.3356805567
);


pk_rel_bankrupt_count_mm := map(
pk_rel_bankrupt_count = -9 => 0.3431372549,
pk_rel_bankrupt_count = 0 => 0.3643895247,
pk_rel_bankrupt_count = 1 => 0.3308957952,
pk_rel_bankrupt_count = 2 => 0.319352552,
pk_rel_bankrupt_count = 3 => 0.2853375527,
pk_rel_bankrupt_count = 4 => 0.255499154,
0.3356805567
);


pk_rel_felony_count_mm := map(
pk_rel_felony_count = -9 => 0.3431372549,
pk_rel_felony_count = 0 => 0.3503403877,
pk_rel_felony_count = 1 => 0.296388305,
pk_rel_felony_count = 2 => 0.2877331826,
pk_rel_felony_count = 3 => 0.2846497765,
pk_rel_felony_count = 4 => 0.2037037037,
0.3356805567
);


pk_crim_rel_within100miles_mm := map(
pk_crim_rel_within100miles = -9 => 0.3431372549,
pk_crim_rel_within100miles = 0 => 0.3391801468,
pk_crim_rel_within100miles = 1 => 0.3139036084,
pk_crim_rel_within100miles = 2 => 0.2838827839,
0.3356805567
);


pk_crim_rel_withinOther_mm := map(
pk_crim_rel_withinOther = -9 => 0.3431372549,
pk_crim_rel_withinOther = 0 => 0.3436556166,
pk_crim_rel_withinOther = 1 => 0.3096849024,
pk_crim_rel_withinOther = 2 => 0.3052560647,
pk_crim_rel_withinOther = 3 => 0.2955920484,
0.3356805567
);


pk_rel_prop_owned_count_mm := map(
pk_rel_prop_owned_count = -9 => 0.3431372549,
pk_rel_prop_owned_count = -3 => 0.3283839779,
pk_rel_prop_owned_count = -2 => 0.3410981697,
pk_rel_prop_owned_count = -1 => 0.3462412661,
pk_rel_prop_owned_count = 0 => 0.3358956024,
pk_rel_prop_owned_count = 1 => 0.3084080528,
0.3356805567
);


pk_rel_prop_own_prch_tot2_mm := map(
pk_rel_prop_own_prch_tot2 = -9 => 0.3431372549,
pk_rel_prop_own_prch_tot2 = -1 => 0.3117302645,
pk_rel_prop_own_prch_tot2 = 0 => 0.3430368519,
pk_rel_prop_own_prch_tot2 = 1 => 0.3368262639,
0.3356805567
);


pk_rel_prop_owned_prch_cnt_mm := map(
pk_rel_prop_owned_prch_cnt = -9 => 0.3431372549,
pk_rel_prop_owned_prch_cnt = 0 => 0.3430368519,
pk_rel_prop_owned_prch_cnt = 1 => 0.332423401,
pk_rel_prop_owned_prch_cnt = 2 => 0.3181542198,
0.3356805567
);


pk_rel_prop_own_assess_tot2_mm := map(
pk_rel_prop_own_assess_tot2 = -9 => 0.3431372549,
pk_rel_prop_own_assess_tot2 = -1 => 0.3004451039,
pk_rel_prop_own_assess_tot2 = 0 => 0.3489333914,
pk_rel_prop_own_assess_tot2 = 1 => 0.3255522482,
pk_rel_prop_own_assess_tot2 = 2 => 0.3375029363,
0.3356805567
);


pk_rel_prop_owned_as_cnt_mm := map(
pk_rel_prop_owned_as_cnt = -9 => 0.3431372549,
pk_rel_prop_owned_as_cnt = -1 => 0.3489333914,
pk_rel_prop_owned_as_cnt = 0 => 0.3349986618,
pk_rel_prop_owned_as_cnt = 1 => 0.304960694,
0.3356805567
);


pk_rel_prop_sold_count_mm := map(
pk_rel_prop_sold_count = -9 => 0.3431372549,
pk_rel_prop_sold_count = 0 => 0.334737155,
pk_rel_prop_sold_count = 1 => 0.3373190098,
pk_rel_prop_sold_count = 2 => 0.334467892,
0.3356805567
);


pk_rel_prop_sold_prch_tot2_mm := map(
pk_rel_prop_sold_prch_tot2 = -9 => 0.3431372549,
pk_rel_prop_sold_prch_tot2 = -1 => 0.3120448179,
pk_rel_prop_sold_prch_tot2 = 0 => 0.3327894876,
pk_rel_prop_sold_prch_tot2 = 1 => 0.3445418327,
pk_rel_prop_sold_prch_tot2 = 2 => 0.3456221198,
0.3356805567
);


pk_rel_prop_sold_as_tot2_mm := map(
pk_rel_prop_sold_as_tot2 = -9 => 0.3431372549,
pk_rel_prop_sold_as_tot2 = -1 => 0.316091954,
pk_rel_prop_sold_as_tot2 = 0 => 0.3348997381,
pk_rel_prop_sold_as_tot2 = 1 => 0.3405620037,
0.3356805567
);


pk_rel_within25miles_count_mm := map(
pk_rel_within25miles_count = -9 => 0.3431372549,
pk_rel_within25miles_count = -3 => 0.3244353183,
pk_rel_within25miles_count = -2 => 0.3507256393,
pk_rel_within25miles_count = -1 => 0.380979021,
pk_rel_within25miles_count = 0 => 0.3616994921,
pk_rel_within25miles_count = 1 => 0.3382650677,
pk_rel_within25miles_count = 2 => 0.3223946785,
pk_rel_within25miles_count = 3 => 0.3101547217,
pk_rel_within25miles_count = 4 => 0.288184438,
pk_rel_within25miles_count = 5 => 0.2402684564,
0.3356805567
);


pk_rel_incomeunder25_count_mm := map(
pk_rel_incomeunder25_count = -9 => 0.3431372549,
pk_rel_incomeunder25_count = 0 => 0.3672722685,
pk_rel_incomeunder25_count = 1 => 0.3577921223,
pk_rel_incomeunder25_count = 2 => 0.3469854104,
pk_rel_incomeunder25_count = 3 => 0.3278769841,
pk_rel_incomeunder25_count = 4 => 0.299831437,
pk_rel_incomeunder25_count = 5 => 0.2941512126,
pk_rel_incomeunder25_count = 6 => 0.2681787859,
pk_rel_incomeunder25_count = 7 => 0.2019543974,
0.3356805567
);


pk_rel_incomeunder50_count_mm := map(
pk_rel_incomeunder50_count = -9 => 0.3431372549,
pk_rel_incomeunder50_count = 0 => 0.3994689838,
pk_rel_incomeunder50_count = 1 => 0.3738317757,
pk_rel_incomeunder50_count = 2 => 0.358040201,
pk_rel_incomeunder50_count = 3 => 0.3502970809,
pk_rel_incomeunder50_count = 4 => 0.3354694901,
pk_rel_incomeunder50_count = 5 => 0.3109709317,
pk_rel_incomeunder50_count = 6 => 0.2714949651,
pk_rel_incomeunder50_count = 7 => 0.2490622656,
0.3356805567
);


pk_rel_incomeunder75_count_mm := map(
pk_rel_incomeunder75_count = -9 => 0.3431372549,
pk_rel_incomeunder75_count = -3 => 0.32928,
pk_rel_incomeunder75_count = -2 => 0.345293725,
pk_rel_incomeunder75_count = -1 => 0.3457128614,
pk_rel_incomeunder75_count = 0 => 0.3425338591,
pk_rel_incomeunder75_count = 1 => 0.3073610023,
pk_rel_incomeunder75_count = 2 => 0.2525510204,
0.3356805567
);


pk_rel_incomeunder100_count_mm := map(
pk_rel_incomeunder100_count = -9 => 0.3431372549,
pk_rel_incomeunder100_count = -3 => 0.3321557426,
pk_rel_incomeunder100_count = -2 => 0.3339906335,
pk_rel_incomeunder100_count = -1 => 0.3522494888,
pk_rel_incomeunder100_count = 0 => 0.3870967742,
pk_rel_incomeunder100_count = 1 => 0.3532740501,
pk_rel_incomeunder100_count = 2 => 0.2828282828,
pk_rel_incomeunder100_count = 3 => 0.2764227642,
0.3356805567
);


pk_rel_incomeover100_count_mm := map(
pk_rel_incomeover100_count = -9 => 0.3431372549,
pk_rel_incomeover100_count = 0 => 0.3317955112,
pk_rel_incomeover100_count = 1 => 0.3556485356,
pk_rel_incomeover100_count = 2 => 0.3926031294,
pk_rel_incomeover100_count = 3 => 0.3885578069,
0.3356805567
);


pk_rel_homeunder100_count_mm := map(
pk_rel_homeunder100_count = -9 => 0.3431372549,
pk_rel_homeunder100_count = 0 => 0.3858762771,
pk_rel_homeunder100_count = 1 => 0.3471471471,
pk_rel_homeunder100_count = 2 => 0.3542600897,
pk_rel_homeunder100_count = 3 => 0.3366164542,
pk_rel_homeunder100_count = 4 => 0.3203017833,
pk_rel_homeunder100_count = 5 => 0.2973565442,
pk_rel_homeunder100_count = 6 => 0.2676809211,
pk_rel_homeunder100_count = 7 => 0.2366504854,
0.3356805567
);


pk_rel_homeunder200_count_mm := map(
pk_rel_homeunder200_count = -9 => 0.3431372549,
pk_rel_homeunder200_count = 0 => 0.3359492322,
pk_rel_homeunder200_count = 1 => 0.3256921178,
pk_rel_homeunder200_count = 2 => 0.3539877301,
pk_rel_homeunder200_count = 3 => 0.3329837441,
0.3356805567
);


pk_rel_homeunder300_count_mm := map(
pk_rel_homeunder300_count = -9 => 0.3431372549,
pk_rel_homeunder300_count = 0 => 0.3310847696,
pk_rel_homeunder300_count = 1 => 0.3309742864,
pk_rel_homeunder300_count = 2 => 0.3612903226,
pk_rel_homeunder300_count = 3 => 0.3590574374,
0.3356805567
);


pk_rel_homeunder500_count_mm := map(
pk_rel_homeunder500_count = -9 => 0.3431372549,
pk_rel_homeunder500_count = 0 => 0.3311648968,
pk_rel_homeunder500_count = 1 => 0.3608652901,
pk_rel_homeunder500_count = 2 => 0.3730964467,
pk_rel_homeunder500_count = 3 => 0.3842010772,
0.3356805567
);


pk_rel_homeover500_count_mm := map(
pk_rel_homeover500_count = -9 => 0.3431372549,
pk_rel_homeover500_count = 0 => 0.3341155764,
pk_rel_homeover500_count = 1 => 0.3684931507,
pk_rel_homeover500_count = 2 => 0.3831578947,
0.3356805567
);


pk_rel_educationunder12_count_mm := map(
pk_rel_educationunder12_count = -9 => 0.3431372549,
pk_rel_educationunder12_count = 0 => 0.3583009243,
pk_rel_educationunder12_count = 1 => 0.3098628925,
pk_rel_educationunder12_count = 2 => 0.3039909425,
pk_rel_educationunder12_count = 3 => 0.2583586626,
0.3356805567
);


pk_rel_educationover12_count_mm := map(
pk_rel_educationover12_count = -9 => 0.3431372549,
pk_rel_educationover12_count = -2 => 0.3373831776,
pk_rel_educationover12_count = -1 => 0.366148532,
pk_rel_educationover12_count = 0 => 0.3534425134,
pk_rel_educationover12_count = 1 => 0.3386302241,
pk_rel_educationover12_count = 2 => 0.3019530393,
pk_rel_educationover12_count = 3 => 0.2691264243,
0.3356805567
);


pk_rel_ageunder30_count_mm := map(
pk_rel_ageunder30_count = -9 => 0.3431372549,
pk_rel_ageunder30_count = 0 => 0.3526271425,
pk_rel_ageunder30_count = 1 => 0.310561732,
pk_rel_ageunder30_count = 2 => 0.2416356877,
0.3356805567
);


pk_rel_ageunder40_count_mm := map(
pk_rel_ageunder40_count = -9 => 0.3431372549,
pk_rel_ageunder40_count = 0 => 0.3664981765,
pk_rel_ageunder40_count = 1 => 0.3477246208,
pk_rel_ageunder40_count = 2 => 0.3165838568,
pk_rel_ageunder40_count = 3 => 0.2771495243,
0.3356805567
);


pk_rel_ageunder50_count_mm := map(
pk_rel_ageunder50_count = -9 => 0.3431372549,
pk_rel_ageunder50_count = 0 => 0.342947638,
pk_rel_ageunder50_count = 1 => 0.3305324965,
pk_rel_ageunder50_count = 2 => 0.3171428571,
0.3356805567
);


pk_rel_ageunder70_count_mm := map(
pk_rel_ageunder70_count = -9 => 0.3431372549,
pk_rel_ageunder70_count = 0 => 0.3356823105,
pk_rel_ageunder70_count = 1 => 0.3253731343,
0.3356805567
);


pk_rel_ageover70_count_mm := map(
pk_rel_ageover70_count = -9 => 0.3431372549,
pk_rel_ageover70_count = 0 => 0.3352946217,
pk_rel_ageover70_count = 1 => 0.3591549296,
0.3356805567
);


pk_rel_vehicle_owned_count_mm := map(
pk_rel_vehicle_owned_count = -9 => 0.3431372549,
pk_rel_vehicle_owned_count = 0 => 0.3761932823,
pk_rel_vehicle_owned_count = 1 => 0.3444221394,
pk_rel_vehicle_owned_count = 2 => 0.3082217973,
pk_rel_vehicle_owned_count = 3 => 0.2585345545,
0.3356805567
);


pk_rel_count_addr_mm := map(
pk_rel_count_addr = -9 => 0.3431372549,
pk_rel_count_addr = 0 => 0.2861523366,
pk_rel_count_addr = 1 => 0.3503057991,
0.3356805567
);


pk_attr_arrests24_mm := map(
pk_attr_arrests24 = 0 => 0.3358002107,
pk_attr_arrests24 = 1 => 0.3037037037,
0.3356805567
);


pk_acc_damage_amt_total2_mm := map(
pk_acc_damage_amt_total2 = -1 => 0.3377757085,
pk_acc_damage_amt_total2 = 0 => 0.2674418605,
pk_acc_damage_amt_total2 = 1 => 0.2926829268,
pk_acc_damage_amt_total2 = 2 => 0.2985347985,
0.3356805567
);


pk_acc_damage_amt_last2_mm := map(
pk_acc_damage_amt_last2 = -1 => 0.3377938096,
pk_acc_damage_amt_last2 = 0 => 0.2916666667,
pk_acc_damage_amt_last2 = 1 => 0.296515062,
0.3356805567
);


pk_add1_fc_index_flag_mm := map(
pk_add1_fc_index_flag = 0 => 0.3357235804,
pk_add1_fc_index_flag = 1 => 0.3191489362,
0.3356805567
);


pk_current_count_mm := map(
pk_current_count = 0 => 0.3559625877,
pk_current_count = 1 => 0.3291910764,
pk_current_count = 2 => 0.3145667288,
pk_current_count = 3 => 0.2913117547,
0.3356805567
);


pk_historical_count_mm := map(
pk_historical_count = 0 => 0.3721166401,
pk_historical_count = 1 => 0.3331900258,
pk_historical_count = 2 => 0.3080934904,
pk_historical_count = 3 => 0.2785956965,
0.3356805567
);


pk_add2_avm_med2_mm := map(
pk_add2_avm_med2 = -1 => 0.3418685986,
pk_add2_avm_med2 = 0 => 0.2476190476,
pk_add2_avm_med2 = 1 => 0.2659003831,
pk_add2_avm_med2 = 2 => 0.3172972973,
pk_add2_avm_med2 = 3 => 0.3217228464,
pk_add2_avm_med2 = 4 => 0.3092152628,
pk_add2_avm_med2 = 5 => 0.301734104,
pk_add2_avm_med2 = 6 => 0.3384,
pk_add2_avm_med2 = 7 => 0.3526682135,
pk_add2_avm_med2 = 8 => 0.3490494297,
pk_add2_avm_med2 = 9 => 0.3843672457,
0.3356805567
);


       elseif (pk_segment2 = 2 ) then /* 2 SkipTrace        */



pk_voter_count_mm := map(
pk_voter_count = 0 => 0.1969566052,
pk_voter_count = 1 => 0.1961569255,
pk_voter_count = 2 => 0.1856835987,
0.1922234826
);


pk_estimated_income_mm := map(
pk_estimated_income = -1 => 0.075,
pk_estimated_income = 2 => 0.1948717949,
pk_estimated_income = 3 => 0.1463414634,
pk_estimated_income = 4 => 0.1173184358,
pk_estimated_income = 5 => 0.1958041958,
pk_estimated_income = 6 => 0.1488833747,
pk_estimated_income = 7 => 0.1646825397,
pk_estimated_income = 8 => 0.1489028213,
pk_estimated_income = 9 => 0.1504975124,
pk_estimated_income = 10 => 0.1828442438,
pk_estimated_income = 11 => 0.1892147588,
pk_estimated_income = 12 => 0.1595227574,
pk_estimated_income = 13 => 0.1912013536,
pk_estimated_income = 14 => 0.1568310428,
pk_estimated_income = 15 => 0.1768292683,
pk_estimated_income = 16 => 0.1751326763,
pk_estimated_income = 17 => 0.1978277735,
pk_estimated_income = 18 => 0.1892109501,
pk_estimated_income = 19 => 0.1969009826,
pk_estimated_income = 20 => 0.2049390306,
pk_estimated_income = 21 => 0.25,
pk_estimated_income = 22 => 0.2407407407,
0.1922234826
);


pk_yr_adl_pr_first_seen2_mm := map(
pk_yr_adl_pr_first_seen2 = -1 => 0.1740137833,
pk_yr_adl_pr_first_seen2 = 0 => 0.2360248447,
pk_yr_adl_pr_first_seen2 = 1 => 0.1876854599,
pk_yr_adl_pr_first_seen2 = 2 => 0.1869575998,
pk_yr_adl_pr_first_seen2 = 3 => 0.2036659878,
pk_yr_adl_pr_first_seen2 = 4 => 0.2231842232,
pk_yr_adl_pr_first_seen2 = 5 => 0.2201577564,
pk_yr_adl_pr_first_seen2 = 6 => 0.2400312744,
pk_yr_adl_pr_first_seen2 = 7 => 0.1542056075,
0.1922234826
);


pk_yr_adl_w_first_seen2_mm := map(
pk_yr_adl_w_first_seen2 = -1 => 0.1923034574,
pk_yr_adl_w_first_seen2 = 0 => 0.19375,
pk_yr_adl_w_first_seen2 = 1 => 0.1979695431,
pk_yr_adl_w_first_seen2 = 2 => 0.1506276151,
0.1922234826
);


pk_yr_adl_pr_last_seen2_mm := map(
pk_yr_adl_pr_last_seen2 = -1 => 0.1740137833,
pk_yr_adl_pr_last_seen2 = 0 => 0.2098490473,
pk_yr_adl_pr_last_seen2 = 1 => 0.2122865275,
pk_yr_adl_pr_last_seen2 = 2 => 0.2246316375,
pk_yr_adl_pr_last_seen2 = 3 => 0.185348632,
pk_yr_adl_pr_last_seen2 = 4 => 0.1754739814,
pk_yr_adl_pr_last_seen2 = 5 => 0.2107438017,
pk_yr_adl_pr_last_seen2 = 6 => 0.3,
0.1922234826
);


pk_yr_adl_w_last_seen2_mm := map(
pk_yr_adl_w_last_seen2 = -1 => 0.1923034574,
pk_yr_adl_w_last_seen2 = 1 => 0.1263736264,
pk_yr_adl_w_last_seen2 = 2 => 0.1987133667,
0.1922234826
);


pk_addrs_sourced_lvl_mm := map(
pk_addrs_sourced_lvl = 0 => 0.1785998409,
pk_addrs_sourced_lvl = 1 => 0.1983184305,
pk_addrs_sourced_lvl = 2 => 0.2309054122,
pk_addrs_sourced_lvl = 3 => 0.2208029197,
0.1922234826
);


pk_add1_own_level_mm := map(
pk_add1_own_level = -1 => 0.1652591171,
pk_add1_own_level = 0 => 0.1811629025,
pk_add1_own_level = 1 => 0.1810359965,
pk_add1_own_level = 2 => 0.2168963451,
pk_add1_own_level = 3 => 0.2233212441,
0.1922234826
);


pk_add2_own_level_mm := map(
pk_add2_own_level = 0 => 0.1954231897,
pk_add2_own_level = 1 => 0.1679308252,
pk_add2_own_level = 2 => 0.2143634385,
pk_add2_own_level = 3 => 0.2001897533,
0.1922234826
);


pk_add3_own_level_mm := map(
pk_add3_own_level = 0 => 0.1961088345,
pk_add3_own_level = 1 => 0.1684931507,
pk_add3_own_level = 2 => 0.2172640819,
pk_add3_own_level = 3 => 0.19197787,
0.1922234826
);


pk_prop_owned_sold_level_mm := map(
pk_prop_owned_sold_level = 0 => 0.1739785757,
pk_prop_owned_sold_level = 1 => 0.1964107677,
pk_prop_owned_sold_level = 2 => 0.2104861149,
0.1922234826
);


pk_naprop_level2_mm := map(
pk_naprop_level2 = -2 => 0.1494423792,
pk_naprop_level2 = -1 => 0.1706842924,
pk_naprop_level2 = 0 => 0.1539768865,
pk_naprop_level2 = 1 => 0.1762589928,
pk_naprop_level2 = 2 => 0.1864570404,
pk_naprop_level2 = 3 => 0.2050359712,
pk_naprop_level2 = 4 => 0.1702702703,
pk_naprop_level2 = 5 => 0.2025572005,
pk_naprop_level2 = 6 => 0.2252858104,
pk_naprop_level2 = 7 => 0.2118827998,
0.1922234826
);


pk_yr_add1_built_date2_mm := map(
pk_yr_add1_built_date2 = -4 => 0.1867851194,
pk_yr_add1_built_date2 = -3 => NULL,
pk_yr_add1_built_date2 = -2 => 0.2162162162,
pk_yr_add1_built_date2 = -1 => 0.2007343941,
pk_yr_add1_built_date2 = 0 => 0.2098856511,
pk_yr_add1_built_date2 = 1 => 0.2059813084,
pk_yr_add1_built_date2 = 2 => 0.198296837,
pk_yr_add1_built_date2 = 3 => 0.1801328596,
0.1922234826
);


pk_add1_purchase_amount2_mm := map(
pk_add1_purchase_amount2 = -1 => 0.1969214259,
pk_add1_purchase_amount2 = 0 => 0.1597379693,
pk_add1_purchase_amount2 = 1 => 0.1895171075,
0.1922234826
);


pk_yr_add1_mortgage_date2_mm := map(
pk_yr_add1_mortgage_date2 = -1 => 0.185982269,
pk_yr_add1_mortgage_date2 = 0 => 0.1634799235,
pk_yr_add1_mortgage_date2 = 1 => 0.187804878,
pk_yr_add1_mortgage_date2 = 2 => 0.2036723987,
0.1922234826
);


pk_add1_mortgage_risk_mm := map(
pk_add1_mortgage_risk = -1 => 0.205749268,
pk_add1_mortgage_risk = 0 => 0.2314199396,
pk_add1_mortgage_risk = 1 => 0.187293758,
pk_add1_mortgage_risk = 2 => 0.1985815603,
pk_add1_mortgage_risk = 3 => 0.1996719967,
0.1922234826
);


pk_add1_assessed_amount2_mm := map(
pk_add1_assessed_amount2 = -1 => 0.1914265636,
pk_add1_assessed_amount2 = 0 => 0.1495601173,
pk_add1_assessed_amount2 = 1 => 0.1549401198,
pk_add1_assessed_amount2 = 2 => 0.179369251,
pk_add1_assessed_amount2 = 3 => 0.1994767822,
pk_add1_assessed_amount2 = 4 => 0.1904269972,
pk_add1_assessed_amount2 = 5 => 0.2043369475,
pk_add1_assessed_amount2 = 6 => 0.2140053384,
0.1922234826
);


pk_yr_add1_mortgage_due_date2_mm := map(
pk_yr_add1_mortgage_due_date2 = -1 => 0.187747618,
pk_yr_add1_mortgage_due_date2 = 0 => 0.2128113879,
pk_yr_add1_mortgage_due_date2 = 1 => 0.2139673105,
pk_yr_add1_mortgage_due_date2 = 2 => 0.2025974026,
0.1922234826
);


pk_yr_add1_date_first_seen2_mm := map(
pk_yr_add1_date_first_seen2 = -1 => 0.1805626598,
pk_yr_add1_date_first_seen2 = 0 => 0.1853107345,
pk_yr_add1_date_first_seen2 = 1 => 0.1776123371,
pk_yr_add1_date_first_seen2 = 2 => 0.1732706514,
pk_yr_add1_date_first_seen2 = 3 => 0.1724726776,
pk_yr_add1_date_first_seen2 = 4 => 0.1768543956,
pk_yr_add1_date_first_seen2 = 5 => 0.1834705608,
pk_yr_add1_date_first_seen2 = 6 => 0.1898370086,
pk_yr_add1_date_first_seen2 = 7 => 0.2124785065,
pk_yr_add1_date_first_seen2 = 8 => 0.2114366396,
pk_yr_add1_date_first_seen2 = 9 => 0.2557651992,
pk_yr_add1_date_first_seen2 = 10 => 0.2295918367,
0.1922234826
);


pk_add1_building_area2_mm := map(
pk_add1_building_area2 = -99 => 0.1884381804,
pk_add1_building_area2 = -4 => 0.1516452074,
pk_add1_building_area2 = -3 => 0.1865530303,
pk_add1_building_area2 = -2 => 0.1901285774,
pk_add1_building_area2 = -1 => 0.2153016184,
pk_add1_building_area2 = 0 => 0.2259414226,
pk_add1_building_area2 = 1 => 0.2196531792,
pk_add1_building_area2 = 2 => 0.2608695652,
pk_add1_building_area2 = 3 => 0.2,
pk_add1_building_area2 = 4 => 0.2058823529,
0.1922234826
);


pk_add1_no_of_buildings_mm := map(
pk_add1_no_of_buildings = -1 => 0.1959164325,
pk_add1_no_of_buildings = 0 => 0.1789350039,
pk_add1_no_of_buildings = 1 => 0.1846405229,
pk_add1_no_of_buildings = 2 => 0.1666666667,
0.1922234826
);


pk_add1_no_of_rooms_mm := map(
pk_add1_no_of_rooms = -1 => 0.1891537586,
pk_add1_no_of_rooms = 0 => 0.1964956195,
pk_add1_no_of_rooms = 1 => 0.181211499,
pk_add1_no_of_rooms = 2 => 0.1994060246,
pk_add1_no_of_rooms = 3 => 0.2306122449,
pk_add1_no_of_rooms = 4 => 0.2065587734,
0.1922234826
);


pk_add1_no_of_baths_mm := map(
pk_add1_no_of_baths = -3 => 0.1888722675,
pk_add1_no_of_baths = -2 => 0.180665878,
pk_add1_no_of_baths = -1 => 0.2023809524,
pk_add1_no_of_baths = 0 => 0.2122266402,
pk_add1_no_of_baths = 1 => 0.2122370937,
pk_add1_no_of_baths = 2 => 0.1829268293,
0.1922234826
);


pk_add1_parking_no_of_cars_mm := map(
pk_add1_parking_no_of_cars = 0 => 0.1862617447,
pk_add1_parking_no_of_cars = 1 => 0.1916515426,
pk_add1_parking_no_of_cars = 2 => 0.2111856034,
pk_add1_parking_no_of_cars = 3 => 0.251637044,
0.1922234826
);


pk_add1_style_code_level_mm := map(
pk_add1_style_code_level = 0 => 0.1922372862,
pk_add1_style_code_level = 1 => 0.1978609626,
pk_add1_style_code_level = 2 => 0.1959026889,
pk_add1_style_code_level = 3 => 0.1672932331,
pk_add1_style_code_level = 4 => 0.1984126984,
0.1922234826
);


pk_prop1_sale_price2_mm := map(
pk_prop1_sale_price2 = 0 => 0.1905787259,
pk_prop1_sale_price2 = 1 => 0.1806930693,
pk_prop1_sale_price2 = 2 => 0.2007520972,
0.1922234826
);


pk_prop1_prev_purchase_price2_mm := map(
pk_prop1_prev_purchase_price2 = 0 => 0.1922040699,
pk_prop1_prev_purchase_price2 = 1 => 0.1880081301,
pk_prop1_prev_purchase_price2 = 2 => 0.1945945946,
0.1922234826
);


pk_yr_prop2_sale_date2_mm := map(
pk_yr_prop2_sale_date2 = 0 => 0.1897411399,
pk_yr_prop2_sale_date2 = 1 => 0.2036613272,
pk_yr_prop2_sale_date2 = 2 => 0.2090997096,
pk_yr_prop2_sale_date2 = 3 => 0.2181571816,
0.1922234826
);


pk_add2_land_use_risk_level_mm := map(
pk_add2_land_use_risk_level = 0 => 0.1875,
pk_add2_land_use_risk_level = 2 => 0.1857836109,
pk_add2_land_use_risk_level = 3 => 0.1991424229,
pk_add2_land_use_risk_level = 4 => 0.1841070024,
0.1922234826
);


pk_add2_no_of_buildings_mm := map(
pk_add2_no_of_buildings = -1 => 0.1976032133,
pk_add2_no_of_buildings = 0 => 0.1689814815,
pk_add2_no_of_buildings = 1 => 0.1871750433,
pk_add2_no_of_buildings = 2 => 0.1956521739,
0.1922234826
);


pk_add2_no_of_stories_mm := map(
pk_add2_no_of_stories = -1 => 0.1991834981,
pk_add2_no_of_stories = 0 => 0.1801272638,
pk_add2_no_of_stories = 1 => 0.224852071,
0.1922234826
);


pk_add2_no_of_baths_mm := map(
pk_add2_no_of_baths = -3 => 0.1983603713,
pk_add2_no_of_baths = -2 => 0.1695947121,
pk_add2_no_of_baths = -1 => 0.1878144215,
pk_add2_no_of_baths = 0 => 0.2029769959,
pk_add2_no_of_baths = 1 => 0.2024169184,
pk_add2_no_of_baths = 2 => 0.1985815603,
0.1922234826
);


pk_add2_garage_type_risk_lvl_mm := map(
pk_add2_garage_type_risk_lvl = 0 => 0.2014225671,
pk_add2_garage_type_risk_lvl = 1 => 0.1831543245,
pk_add2_garage_type_risk_lvl = 2 => 0.1698542805,
pk_add2_garage_type_risk_lvl = 3 => 0.194037549,
0.1922234826
);


pk_add2_style_code_level_mm := map(
pk_add2_style_code_level = 0 => 0.1926320837,
pk_add2_style_code_level = 1 => 0.1981424149,
pk_add2_style_code_level = 2 => 0.2113821138,
pk_add2_style_code_level = 3 => 0.168591224,
pk_add2_style_code_level = 4 => 0.1757129715,
0.1922234826
);


pk_yr_add2_built_date2_mm := map(
pk_yr_add2_built_date2 = -1 => 0.1987098652,
pk_yr_add2_built_date2 = 0 => 0.1830985915,
pk_yr_add2_built_date2 = 1 => 0.1897435897,
pk_yr_add2_built_date2 = 2 => 0.184144538,
0.1922234826
);


pk_add2_purchase_amount2_mm := map(
pk_add2_purchase_amount2 = -1 => 0.1945242577,
pk_add2_purchase_amount2 = 0 => 0.1606275682,
pk_add2_purchase_amount2 = 1 => 0.195235211,
0.1922234826
);


pk_add2_mortgage_amount2_mm := map(
pk_add2_mortgage_amount2 = -1 => 0.1921998377,
pk_add2_mortgage_amount2 = 0 => 0.1795206972,
pk_add2_mortgage_amount2 = 1 => 0.1910809214,
pk_add2_mortgage_amount2 = 2 => 0.2137931034,
0.1922234826
);


pk_add2_mortgage_risk_mm := map(
pk_add2_mortgage_risk = -1 => 0.1885120684,
pk_add2_mortgage_risk = 0 => 0.2068965517,
pk_add2_mortgage_risk = 1 => 0.1913862897,
pk_add2_mortgage_risk = 2 => 0.1979609176,
pk_add2_mortgage_risk = 3 => 0.1979166667,
0.1922234826
);


pk_yr_add2_mortgage_due_date2_mm := map(
pk_yr_add2_mortgage_due_date2 = -1 => 0.1920216789,
pk_yr_add2_mortgage_due_date2 = 0 => 0.197147651,
pk_yr_add2_mortgage_due_date2 = 1 => 0.179584121,
pk_yr_add2_mortgage_due_date2 = 2 => 0.1804651163,
pk_yr_add2_mortgage_due_date2 = 3 => 0.2015449438,
0.1922234826
);


pk_add2_assessed_amount2_mm := map(
pk_add2_assessed_amount2 = -1 => 0.1983495683,
pk_add2_assessed_amount2 = 0 => 0.1484879375,
pk_add2_assessed_amount2 = 1 => 0.1667870036,
pk_add2_assessed_amount2 = 2 => 0.1879460745,
pk_add2_assessed_amount2 = 3 => 0.1918804282,
pk_add2_assessed_amount2 = 4 => 0.2173737374,
0.1922234826
);


pk_yr_add2_date_first_seen2_mm := map(
pk_yr_add2_date_first_seen2 = -1 => 0.2094361335,
pk_yr_add2_date_first_seen2 = 0 => 0.1534688157,
pk_yr_add2_date_first_seen2 = 1 => 0.1695906433,
pk_yr_add2_date_first_seen2 = 2 => 0.1861626248,
pk_yr_add2_date_first_seen2 = 3 => 0.1861724282,
pk_yr_add2_date_first_seen2 = 4 => 0.1944444444,
pk_yr_add2_date_first_seen2 = 5 => 0.1959557053,
pk_yr_add2_date_first_seen2 = 6 => 0.1879194631,
pk_yr_add2_date_first_seen2 = 7 => 0.2117154812,
pk_yr_add2_date_first_seen2 = 8 => 0.2046861185,
pk_yr_add2_date_first_seen2 = 9 => 0.2141756549,
pk_yr_add2_date_first_seen2 = 10 => 0.2353535354,
pk_yr_add2_date_first_seen2 = 11 => 0.2260028653,
0.1922234826
);


pk_yr_add2_date_last_seen2_mm := map(
pk_yr_add2_date_last_seen2 = -1 => 0.2094361335,
pk_yr_add2_date_last_seen2 = 0 => 0.1715572175,
pk_yr_add2_date_last_seen2 = 1 => 0.2227979275,
pk_yr_add2_date_last_seen2 = 2 => 0.2226524685,
pk_yr_add2_date_last_seen2 = 3 => 0.2232070911,
pk_yr_add2_date_last_seen2 = 4 => 0.323699422,
pk_yr_add2_date_last_seen2 = 5 => 0.3434610304,
pk_yr_add2_date_last_seen2 = 6 => 0.3582677165,
0.1922234826
);


pk_yr_add3_built_date2_mm := map(
pk_yr_add3_built_date2 = -1 => 0.1970908138,
pk_yr_add3_built_date2 = 0 => 0.1395348837,
pk_yr_add3_built_date2 = 1 => 0.1961367013,
pk_yr_add3_built_date2 = 2 => 0.2080592105,
pk_yr_add3_built_date2 = 3 => 0.1818922,
0.1922234826
);


pk_add3_purchase_amount2_mm := map(
pk_add3_purchase_amount2 = -1 => 0.1943022915,
pk_add3_purchase_amount2 = 0 => 0.1579651941,
pk_add3_purchase_amount2 = 1 => 0.1684737281,
pk_add3_purchase_amount2 = 2 => 0.1757469244,
pk_add3_purchase_amount2 = 3 => 0.1831501832,
pk_add3_purchase_amount2 = 4 => 0.212647672,
0.1922234826
);


pk_add3_mortgage_risk_mm := map(
pk_add3_mortgage_risk = -1 => 0.1960784314,
pk_add3_mortgage_risk = 0 => 0.2132034632,
pk_add3_mortgage_risk = 1 => 0.1677419355,
pk_add3_mortgage_risk = 2 => 0.1904959204,
pk_add3_mortgage_risk = 3 => 0.2133027523,
pk_add3_mortgage_risk = 4 => 0.1975662133,
pk_add3_mortgage_risk = 5 => 0.1988636364,
0.1922234826
);


pk_yr_add3_mortgage_due_date2_mm := map(
pk_yr_add3_mortgage_due_date2 = -1 => 0.1923358555,
pk_yr_add3_mortgage_due_date2 = 0 => 0.1936441936,
pk_yr_add3_mortgage_due_date2 = 1 => 0.1874292186,
0.1922234826
);


pk_add3_assessed_amount2_mm := map(
pk_add3_assessed_amount2 = -1 => 0.1976854788,
pk_add3_assessed_amount2 = 0 => 0.1617210682,
pk_add3_assessed_amount2 = 1 => 0.1757624398,
pk_add3_assessed_amount2 = 2 => 0.1690225564,
pk_add3_assessed_amount2 = 3 => 0.2,
0.1922234826
);


pk_yr_add3_date_first_seen2_mm := map(
pk_yr_add3_date_first_seen2 = -1 => 0.2173624917,
pk_yr_add3_date_first_seen2 = 0 => 0.1368768934,
pk_yr_add3_date_first_seen2 = 1 => 0.1573141487,
pk_yr_add3_date_first_seen2 = 2 => 0.1823962517,
pk_yr_add3_date_first_seen2 = 3 => 0.1925662317,
pk_yr_add3_date_first_seen2 = 4 => 0.1728446481,
pk_yr_add3_date_first_seen2 = 5 => 0.1986266957,
pk_yr_add3_date_first_seen2 = 6 => 0.2009109312,
pk_yr_add3_date_first_seen2 = 7 => 0.2215770171,
pk_yr_add3_date_first_seen2 = 8 => 0.2168868837,
pk_yr_add3_date_first_seen2 = 9 => 0.2238193018,
0.1922234826
);


pk_yr_add3_date_last_seen2_mm := map(
pk_yr_add3_date_last_seen2 = -1 => 0.2173624917,
pk_yr_add3_date_last_seen2 = 0 => 0.1581978567,
pk_yr_add3_date_last_seen2 = 1 => 0.1887054896,
pk_yr_add3_date_last_seen2 = 2 => 0.1896893589,
pk_yr_add3_date_last_seen2 = 3 => 0.2168344007,
pk_yr_add3_date_last_seen2 = 4 => 0.2167832168,
pk_yr_add3_date_last_seen2 = 5 => 0.2738549618,
pk_yr_add3_date_last_seen2 = 6 => 0.3111332008,
pk_yr_add3_date_last_seen2 = 7 => 0.3101449275,
pk_yr_add3_date_last_seen2 = 8 => 0.2978971963,
0.1922234826
);


pk_yr_attr_dt_last_purch2_mm := map(
pk_yr_attr_dt_last_purch2 = -1 => 0.1743652009,
pk_yr_attr_dt_last_purch2 = 0 => 0.2233187135,
pk_yr_attr_dt_last_purch2 = 1 => 0.1956087824,
pk_yr_attr_dt_last_purch2 = 2 => 0.2090145824,
pk_yr_attr_dt_last_purch2 = 3 => 0.205350118,
pk_yr_attr_dt_last_purch2 = 4 => 0.2259970458,
pk_yr_attr_dt_last_purch2 = 5 => 0.2085344661,
pk_yr_attr_dt_last_purch2 = 6 => 0.1957104558,
pk_yr_attr_dt_last_purch2 = 7 => 0.2614678899,
0.1922234826
);


pk_yr_attr_date_last_sale2_mm := map(
pk_yr_attr_date_last_sale2 = -1 => 0.1875442849,
pk_yr_attr_date_last_sale2 = 0 => 0.1791758646,
pk_yr_attr_date_last_sale2 = 1 => 0.1939338235,
pk_yr_attr_date_last_sale2 = 2 => 0.1925465839,
pk_yr_attr_date_last_sale2 = 3 => 0.2115085537,
pk_yr_attr_date_last_sale2 = 4 => 0.2394611039,
0.1922234826
);


pk_attr_num_watercraft24_mm := map(
pk_attr_num_watercraft24 = 0 => 0.1925000669,
pk_attr_num_watercraft24 = 1 => 0.1763527054,
pk_attr_num_watercraft24 = 2 => 0.0869565217,
0.1922234826
);


pk_bk_level_mm := map(
pk_bk_level = 0 => 0.1908921618,
pk_bk_level = 1 => 0.2032930108,
pk_bk_level = 2 => 0.181255161,
0.1922234826
);


pk_eviction_level_mm := map(
pk_eviction_level = 0 => 0.198792211,
pk_eviction_level = 1 => 0.1558035714,
pk_eviction_level = 2 => 0.1658327377,
pk_eviction_level = 3 => 0.1201456311,
pk_eviction_level = 4 => 0.1303538175,
pk_eviction_level = 5 => 0.1900826446,
pk_eviction_level = 6 => 0.1833333333,
pk_eviction_level = 7 => 0.1935483871,
0.1922234826
);


pk_lien_type_level_mm := map(
pk_lien_type_level = 0 => 0.2036869863,
pk_lien_type_level = 1 => 0.1703703704,
pk_lien_type_level = 2 => 0.2034261242,
pk_lien_type_level = 3 => 0.1816642477,
pk_lien_type_level = 4 => 0.1844414116,
pk_lien_type_level = 5 => 0.1608291637,
0.1922234826
);


pk_yr_ln_unrel_cj_f_sn2_mm := map(
pk_yr_ln_unrel_cj_f_sn2 = -1 => 0.1999162096,
pk_yr_ln_unrel_cj_f_sn2 = 0 => 0.1976470588,
pk_yr_ln_unrel_cj_f_sn2 = 1 => 0.1752316765,
pk_yr_ln_unrel_cj_f_sn2 = 2 => 0.1748483177,
pk_yr_ln_unrel_cj_f_sn2 = 3 => 0.1709135267,
0.1922234826
);


pk_yr_ln_unrel_lt_f_sn2_mm := map(
pk_yr_ln_unrel_lt_f_sn2 = -1 => 0.1952310402,
pk_yr_ln_unrel_lt_f_sn2 = 0 => 0.1405940594,
pk_yr_ln_unrel_lt_f_sn2 = 1 => 0.1422440221,
0.1922234826
);


pk_yr_ln_unrel_ot_f_sn2_mm := map(
pk_yr_ln_unrel_ot_f_sn2 = -1 => 0.1924461476,
pk_yr_ln_unrel_ot_f_sn2 = 0 => 0.1749347258,
pk_yr_ln_unrel_ot_f_sn2 = 1 => 0.1964636542,
pk_yr_ln_unrel_ot_f_sn2 = 2 => 0.1977839335,
0.1922234826
);


pk_yr_ln_unrel_sc_f_sn2_mm := map(
pk_yr_ln_unrel_sc_f_sn2 = -1 => 0.1952851711,
pk_yr_ln_unrel_sc_f_sn2 = 0 => 0.1810344828,
pk_yr_ln_unrel_sc_f_sn2 = 1 => 0.1702386751,
0.1922234826
);


pk_yr_attr_dt_l_eviction2_mm := map(
pk_yr_attr_dt_l_eviction2 = -1 => 0.1989393192,
pk_yr_attr_dt_l_eviction2 = 0 => 0.1558307534,
pk_yr_attr_dt_l_eviction2 = 1 => 0.119760479,
pk_yr_attr_dt_l_eviction2 = 2 => 0.1433333333,
pk_yr_attr_dt_l_eviction2 = 3 => 0.1591320072,
pk_yr_attr_dt_l_eviction2 = 4 => 0.1178947368,
pk_yr_attr_dt_l_eviction2 = 5 => 0.1731051345,
0.1922234826
);


pk_yr_criminal_last_date2_mm := map(
pk_yr_criminal_last_date2 = -1 => 0.1957534247,
pk_yr_criminal_last_date2 = 0 => 0.1523378582,
pk_yr_criminal_last_date2 = 1 => 0.1875,
pk_yr_criminal_last_date2 = 2 => 0.1941238195,
pk_yr_criminal_last_date2 = 3 => 0.1778074866,
pk_yr_criminal_last_date2 = 4 => 0.1808207154,
0.1922234826
);


pk_crime_level_mm := map(
pk_crime_level = 0 => 0.1957296605,
pk_crime_level = 1 => 0.1858770535,
pk_crime_level = 2 => 0.1557377049,
0.1922234826
);


pk_felony_recent_level_mm := map(
pk_felony_recent_level = 0 => 0.1930859584,
pk_felony_recent_level = 1 => 0.0985221675,
pk_felony_recent_level = 2 => 0.1041666667,
pk_felony_recent_level = 3 => 0.18,
pk_felony_recent_level = 4 => 0.12,
0.1922234826
);


pk_attr_total_number_derogs_mm := map(
pk_attr_total_number_derogs = 0 => 0.204713331,
pk_attr_total_number_derogs = 1 => 0.1965200971,
pk_attr_total_number_derogs = 2 => 0.1870362287,
pk_attr_total_number_derogs = 3 => 0.1763549325,
0.1922234826
);


pk_yr_rc_ssnhighissue2_mm := map(
pk_yr_rc_ssnhighissue2 = -1 => 0.1671309192,
pk_yr_rc_ssnhighissue2 = 1 => 0.2285714286,
pk_yr_rc_ssnhighissue2 = 2 => 0.1700680272,
pk_yr_rc_ssnhighissue2 = 3 => 0.181372549,
pk_yr_rc_ssnhighissue2 = 4 => 0.1897233202,
pk_yr_rc_ssnhighissue2 = 5 => 0.1753936287,
pk_yr_rc_ssnhighissue2 = 6 => 0.1799472296,
pk_yr_rc_ssnhighissue2 = 7 => 0.1772056039,
pk_yr_rc_ssnhighissue2 = 8 => 0.1733145076,
pk_yr_rc_ssnhighissue2 = 9 => 0.1859614916,
pk_yr_rc_ssnhighissue2 = 10 => 0.1897969052,
pk_yr_rc_ssnhighissue2 = 11 => 0.1945972986,
pk_yr_rc_ssnhighissue2 = 12 => 0.2076764907,
pk_yr_rc_ssnhighissue2 = 13 => 0.2406733394,
pk_yr_rc_ssnhighissue2 = 14 => 0.2334137515,
0.1922234826
);


pk_PL_Sourced_Level_mm := map(
pk_PL_Sourced_Level = 0 => 0.1919153759,
pk_PL_Sourced_Level = 1 => 0.174863388,
pk_PL_Sourced_Level = 2 => 0.1937172775,
pk_PL_Sourced_Level = 3 => 0.2133333333,
0.1922234826
);


pk_prof_lic_cat_mm := map(
pk_prof_lic_cat = -1 => 0.1918686971,
pk_prof_lic_cat = 0 => 0.182937555,
pk_prof_lic_cat = 1 => 0.2132653061,
pk_prof_lic_cat = 2 => 0.1897491821,
pk_prof_lic_cat = 3 => 0.2089552239,
0.1922234826
);


pk_add1_lres_mm := map(
pk_add1_lres = -2 => 0.7142857143,
pk_add1_lres = -1 => 0.1915979584,
pk_add1_lres = 0 => 0.1846965699,
pk_add1_lres = 1 => 0.1936507937,
pk_add1_lres = 2 => 0.1707920792,
pk_add1_lres = 3 => 0.1865671642,
pk_add1_lres = 4 => 0.1880749574,
pk_add1_lres = 5 => 0.212721585,
pk_add1_lres = 6 => 0.179222839,
pk_add1_lres = 7 => 0.1782533256,
pk_add1_lres = 8 => 0.1881850534,
pk_add1_lres = 9 => 0.1873219373,
pk_add1_lres = 10 => 0.2166858128,
pk_add1_lres = 11 => 0.254076087,
0.1922234826
);


pk_add2_lres_mm := map(
pk_add2_lres = -2 => 0.2066974596,
pk_add2_lres = -1 => 0.2091264031,
pk_add2_lres = 0 => 0.1666666667,
pk_add2_lres = 1 => 0.1605113636,
pk_add2_lres = 2 => 0.1759656652,
pk_add2_lres = 3 => 0.195631529,
pk_add2_lres = 4 => 0.1701086957,
pk_add2_lres = 5 => 0.1952892069,
pk_add2_lres = 6 => 0.1919045315,
pk_add2_lres = 7 => 0.1949740035,
pk_add2_lres = 8 => 0.2086526576,
pk_add2_lres = 9 => 0.2181762546,
pk_add2_lres = 10 => 0.1930894309,
0.1922234826
);


pk_add3_lres_mm := map(
pk_add3_lres = -2 => 0.218206158,
pk_add3_lres = -1 => 0.1955907292,
pk_add3_lres = 0 => 0.1750850797,
pk_add3_lres = 1 => 0.1956158664,
pk_add3_lres = 2 => 0.2005744375,
pk_add3_lres = 3 => 0.1983362522,
pk_add3_lres = 4 => 0.2073170732,
pk_add3_lres = 5 => 0.200311042,
pk_add3_lres = 6 => 0.1972527473,
0.1922234826
);


pk_lres_flag_level_mm := map(
pk_lres_flag_level = 0 => 0.1930305403,
pk_lres_flag_level = 1 => 0.2496644295,
pk_lres_flag_level = 2 => 0.1896353167,
0.1922234826
);


pk_avg_lres_mm := map(
pk_avg_lres = -1 => 0.1717352415,
pk_avg_lres = 0 => 0.1379310345,
pk_avg_lres = 1 => 0.1733333333,
pk_avg_lres = 2 => 0.1775147929,
pk_avg_lres = 3 => 0.2194570136,
pk_avg_lres = 4 => 0.1839572193,
pk_avg_lres = 5 => 0.1789321789,
pk_avg_lres = 6 => 0.1557788945,
pk_avg_lres = 7 => 0.1697312588,
pk_avg_lres = 8 => 0.1753522702,
pk_avg_lres = 9 => 0.1752491694,
pk_avg_lres = 10 => 0.1949472097,
pk_avg_lres = 11 => 0.191375969,
pk_avg_lres = 12 => 0.1903906601,
pk_avg_lres = 13 => 0.214790391,
pk_avg_lres = 14 => 0.2285418821,
pk_avg_lres = 15 => 0.2324814509,
0.1922234826
);


pk_addrs_5yr_mm := map(
pk_addrs_5yr = 0 => 0.2453953746,
pk_addrs_5yr = 1 => 0.1968375523,
pk_addrs_5yr = 2 => 0.1756931012,
pk_addrs_5yr = 3 => 0.1559475156,
pk_addrs_5yr = 4 => 0.1441064639,
0.1922234826
);


pk_addrs_10yr_mm := map(
pk_addrs_10yr = 0 => 0.2630866426,
pk_addrs_10yr = 1 => 0.2433557477,
pk_addrs_10yr = 2 => 0.1961499198,
pk_addrs_10yr = 3 => 0.1680107527,
pk_addrs_10yr = 4 => 0.150322474,
0.1922234826
);


pk_add_lres_year_avg2_mm := map(
pk_add_lres_year_avg2 = -1 => 0.1692015209,
pk_add_lres_year_avg2 = 0 => 0.1666666667,
pk_add_lres_year_avg2 = 1 => 0.1644766652,
pk_add_lres_year_avg2 = 2 => 0.1568385304,
pk_add_lres_year_avg2 = 3 => 0.1635555556,
pk_add_lres_year_avg2 = 4 => 0.1632100992,
pk_add_lres_year_avg2 = 5 => 0.1778255528,
pk_add_lres_year_avg2 = 6 => 0.1846905537,
pk_add_lres_year_avg2 = 7 => 0.1827338129,
pk_add_lres_year_avg2 = 8 => 0.203100159,
pk_add_lres_year_avg2 = 9 => 0.198792583,
pk_add_lres_year_avg2 = 10 => 0.1992696922,
pk_add_lres_year_avg2 = 11 => 0.2142857143,
pk_add_lres_year_avg2 = 12 => 0.2257824143,
pk_add_lres_year_avg2 = 13 => 0.2578334825,
pk_add_lres_year_avg2 = 14 => 0.2299578059,
pk_add_lres_year_avg2 = 15 => 0.2541720154,
pk_add_lres_year_avg2 = 16 => 0.2481203008,
pk_add_lres_year_avg2 = 17 => 0.2460815047,
pk_add_lres_year_avg2 = 18 => 0.2841880342,
pk_add_lres_year_avg2 = 19 => 0.2727272727,
0.1922234826
);


pk_add_lres_year_max2_mm := map(
pk_add_lres_year_max2 = -1 => 0.1692015209,
pk_add_lres_year_max2 = 0 => 0.1732283465,
pk_add_lres_year_max2 = 1 => 0.1599462366,
pk_add_lres_year_max2 = 2 => 0.168358714,
pk_add_lres_year_max2 = 3 => 0.1696658098,
pk_add_lres_year_max2 = 4 => 0.1558510638,
pk_add_lres_year_max2 = 5 => 0.1702755906,
pk_add_lres_year_max2 = 6 => 0.1779859485,
pk_add_lres_year_max2 = 7 => 0.1610017889,
pk_add_lres_year_max2 = 8 => 0.1648675172,
pk_add_lres_year_max2 = 9 => 0.1878437844,
pk_add_lres_year_max2 = 10 => 0.1976395279,
pk_add_lres_year_max2 = 11 => 0.2064561901,
pk_add_lres_year_max2 = 12 => 0.2037037037,
pk_add_lres_year_max2 = 13 => 0.2120218579,
pk_add_lres_year_max2 = 14 => 0.2309442548,
pk_add_lres_year_max2 = 15 => 0.204797048,
pk_add_lres_year_max2 = 16 => 0.2296802538,
pk_add_lres_year_max2 = 17 => 0.2320574163,
pk_add_lres_year_max2 = 18 => 0.2236842105,
0.1922234826
);


pk_nameperssn_count_mm := map(
pk_nameperssn_count = 0 => 0.1914652139,
pk_nameperssn_count = 1 => 0.2008597108,
pk_nameperssn_count = 2 => 0.2358490566,
0.1922234826
);


pk_ssns_per_adl_mm := map(
pk_ssns_per_adl = -1 => 0.1761158022,
pk_ssns_per_adl = 0 => 0.1950727238,
pk_ssns_per_adl = 1 => 0.1804769604,
pk_ssns_per_adl = 2 => 0.1775312067,
pk_ssns_per_adl = 3 => 0.1900826446,
pk_ssns_per_adl = 4 => 0.1052631579,
0.1922234826
);


pk_addrs_per_adl_mm := map(
pk_addrs_per_adl = -6 => 0.1744966443,
pk_addrs_per_adl = -5 => 0.2814498934,
pk_addrs_per_adl = -4 => 0.207253886,
pk_addrs_per_adl = -3 => 0.2330335241,
pk_addrs_per_adl = -2 => 0.2193932828,
pk_addrs_per_adl = -1 => 0.2103370787,
pk_addrs_per_adl = 0 => 0.193909866,
pk_addrs_per_adl = 1 => 0.1821323656,
pk_addrs_per_adl = 2 => 0.1730142999,
pk_addrs_per_adl = 3 => 0.1810344828,
0.1922234826
);


pk_phones_per_adl_mm := map(
pk_phones_per_adl = -1 => 0.1729411765,
pk_phones_per_adl = 0 => 0.2222376747,
pk_phones_per_adl = 1 => 0.1853114348,
pk_phones_per_adl = 2 => 0.1491344874,
0.1922234826
);


pk_addrs_per_ssn_mm := map(
pk_addrs_per_ssn = -4 => 0.1715076072,
pk_addrs_per_ssn = -3 => 0.2035855363,
pk_addrs_per_ssn = -2 => 0.1877867426,
pk_addrs_per_ssn = -1 => 0.1816473536,
pk_addrs_per_ssn = 0 => 0.1908783784,
pk_addrs_per_ssn = 1 => 0.1981981982,
pk_addrs_per_ssn = 2 => 0.1907340554,
pk_addrs_per_ssn = 3 => 0.1804577465,
0.1922234826
);


pk_adls_per_addr_mm := map(
pk_adls_per_addr = -102 => 0.2048480032,
pk_adls_per_addr = -101 => 0.226904376,
pk_adls_per_addr = -2 => 0.2677165354,
pk_adls_per_addr = -1 => 0.2261072261,
pk_adls_per_addr = 0 => 0.2237918216,
pk_adls_per_addr = 1 => 0.2156208278,
pk_adls_per_addr = 2 => 0.2323717949,
pk_adls_per_addr = 3 => 0.211028632,
pk_adls_per_addr = 4 => 0.1951097804,
pk_adls_per_addr = 5 => 0.2032355915,
pk_adls_per_addr = 6 => 0.1814734561,
pk_adls_per_addr = 7 => 0.1821407451,
pk_adls_per_addr = 8 => 0.2104234528,
pk_adls_per_addr = 9 => 0.1763888889,
pk_adls_per_addr = 10 => 0.1812136326,
pk_adls_per_addr = 11 => 0.1740936556,
pk_adls_per_addr = 12 => 0.1657715718,
pk_adls_per_addr = 13 => 0.1592055485,
pk_adls_per_addr = 100 => 0.241025641,
pk_adls_per_addr = 101 => 0.2038461538,
pk_adls_per_addr = 102 => 0.1711466485,
0.1922234826
);


pk_phones_per_addr_mm := map(
pk_phones_per_addr = -1 => 0.1563632488,
pk_phones_per_addr = 0 => 0.2180523879,
pk_phones_per_addr = 1 => 0.1826872013,
pk_phones_per_addr = 2 => 0.1467025572,
pk_phones_per_addr = 3 => 0.1516129032,
pk_phones_per_addr = 100 => 0.1504424779,
pk_phones_per_addr = 101 => 0.2266217355,
pk_phones_per_addr = 102 => 0.1800208117,
pk_phones_per_addr = 103 => 0.1982837879,
0.1922234826
);


pk_adls_per_phone_mm := map(
pk_adls_per_phone = -2 => 0.1401365433,
pk_adls_per_phone = -1 => 0.1977982051,
pk_adls_per_phone = 0 => 0.1959159515,
pk_adls_per_phone = 1 => 0.1526627219,
0.1922234826
);


pk_addrs_per_adl_c6_mm := map(
pk_addrs_per_adl_c6 = 0 => 0.1950699939,
pk_addrs_per_adl_c6 = 1 => 0.1714609287,
pk_addrs_per_adl_c6 = 2 => 0.1864716636,
pk_addrs_per_adl_c6 = 3 => 0.2068965517,
0.1922234826
);


pk_phones_per_adl_c6_mm := map(
pk_phones_per_adl_c6 = -2 => 0.1913700561,
pk_phones_per_adl_c6 = -1 => 0.2008516678,
pk_phones_per_adl_c6 = 0 => 0.1704918033,
pk_phones_per_adl_c6 = 1 => 0.1428571429,
0.1922234826
);


pk_adls_per_addr_c6_mm := map(
pk_adls_per_addr_c6 = 0 => 0.1970752089,
pk_adls_per_addr_c6 = 1 => 0.1629754454,
pk_adls_per_addr_c6 = 2 => 0.1710193766,
pk_adls_per_addr_c6 = 3 => 0.1646706587,
pk_adls_per_addr_c6 = 4 => 0.1578947368,
pk_adls_per_addr_c6 = 100 => 0.1989409074,
pk_adls_per_addr_c6 = 101 => 0.1828442438,
pk_adls_per_addr_c6 = 102 => 0.1363636364,
0.1922234826
);


pk_ssns_per_addr_c6_mm := map(
pk_ssns_per_addr_c6 = 0 => 0.197775505,
pk_ssns_per_addr_c6 = 1 => 0.1523553163,
pk_ssns_per_addr_c6 = 2 => 0.1729257642,
pk_ssns_per_addr_c6 = 3 => 0.186770428,
pk_ssns_per_addr_c6 = 4 => 0.1538461538,
pk_ssns_per_addr_c6 = 5 => 0.1428571429,
pk_ssns_per_addr_c6 = 6 => 0.125,
pk_ssns_per_addr_c6 = 100 => 0.199070211,
pk_ssns_per_addr_c6 = 101 => 0.1896296296,
pk_ssns_per_addr_c6 = 102 => 0.1278195489,
pk_ssns_per_addr_c6 = 103 => 0.16,
pk_ssns_per_addr_c6 = 104 => 0.1176470588,
0.1922234826
);


pk_phones_per_addr_c6_mm := map(
pk_phones_per_addr_c6 = -1 => 0.1915171573,
pk_phones_per_addr_c6 = 0 => 0.1906055901,
pk_phones_per_addr_c6 = 1 => 0.1495901639,
pk_phones_per_addr_c6 = 2 => 0.196969697,
pk_phones_per_addr_c6 = 100 => 0.2008919522,
pk_phones_per_addr_c6 = 101 => 0.1890436985,
pk_phones_per_addr_c6 = 102 => 0.2029616725,
0.1922234826
);


pk_adls_per_phone_c6_mm := map(
pk_adls_per_phone_c6 = 0 => 0.1942911098,
pk_adls_per_phone_c6 = 1 => 0.1836908955,
pk_adls_per_phone_c6 = 2 => 0.2151394422,
0.1922234826
);


pk_attr_addrs_last30_mm := map(
pk_attr_addrs_last30 = 0 => 0.1917884964,
pk_attr_addrs_last30 = 1 => 0.2341463415,
pk_attr_addrs_last30 = 2 => 0.1333333333,
0.1922234826
);


pk_attr_addrs_last36_mm := map(
pk_attr_addrs_last36 = 0 => 0.2283403329,
pk_attr_addrs_last36 = 1 => 0.1863810099,
pk_attr_addrs_last36 = 2 => 0.1742751388,
pk_attr_addrs_last36 = 3 => 0.1674107143,
pk_attr_addrs_last36 = 4 => 0.1571621015,
pk_attr_addrs_last36 = 5 => 0.147229115,
pk_attr_addrs_last36 = 6 => 0.1426101988,
0.1922234826
);


pk_attr_addrs_last_level_mm := map(
pk_attr_addrs_last_level = 0 => 0.2283403329,
pk_attr_addrs_last_level = 1 => 0.184292541,
pk_attr_addrs_last_level = 2 => 0.1775291829,
pk_attr_addrs_last_level = 3 => 0.1636007828,
pk_attr_addrs_last_level = 4 => 0.1709276844,
pk_attr_addrs_last_level = 5 => 0.2305882353,
0.1922234826
);


pk_ams_class_level_mm := map(
pk_ams_class_level = -1000001 => 0.1964800734,
pk_ams_class_level = 0 => 0.1111111111,
pk_ams_class_level = 1 => 0.2058823529,
pk_ams_class_level = 2 => 0.1964285714,
pk_ams_class_level = 3 => 0.1746031746,
pk_ams_class_level = 4 => 0.1862068966,
pk_ams_class_level = 5 => 0.1561733442,
pk_ams_class_level = 6 => 0.1635294118,
pk_ams_class_level = 7 => 0.1590073529,
pk_ams_class_level = 8 => 0.1780072904,
pk_ams_class_level = 1000000 => 0.1586826347,
pk_ams_class_level = 1000001 => 0.235,
pk_ams_class_level = 1000002 => 0.1933014354,
pk_ams_class_level = 1000003 => 0.1954887218,
pk_ams_class_level = 1000004 => 0.2211538462,
pk_ams_class_level = 1000005 => 0.1656804734,
0.1922234826
);


pk_ams_income_level_code_mm := map(
pk_ams_income_level_code = -1 => 0.1964736342,
pk_ams_income_level_code = 0 => 0.1303116147,
pk_ams_income_level_code = 1 => 0.1515748031,
pk_ams_income_level_code = 2 => 0.1662808642,
pk_ams_income_level_code = 3 => 0.1722731906,
pk_ams_income_level_code = 4 => 0.1852459016,
pk_ams_income_level_code = 5 => 0.198757764,
pk_ams_income_level_code = 6 => 0.2338983051,
0.1922234826
);


pk_ams_college_tier_mm := map(
pk_ams_college_tier = -1 => 0.1920947489,
pk_ams_college_tier = 0 => 0.1827956989,
pk_ams_college_tier = 1 => 0.1875,
pk_ams_college_tier = 2 => 0.1923076923,
pk_ams_college_tier = 3 => 0.1758409786,
pk_ams_college_tier = 4 => 0.2094594595,
pk_ams_college_tier = 5 => 0.1957831325,
pk_ams_college_tier = 6 => 0.1885245902,
0.1922234826
);


pk_yr_rc_correct_dob2_mm := map(
pk_yr_rc_correct_dob2 = -1 => 0.1927507421,
pk_yr_rc_correct_dob2 = 21 => 0.5,
pk_yr_rc_correct_dob2 = 33 => 0.1698113208,
pk_yr_rc_correct_dob2 = 61 => 0.175032175,
pk_yr_rc_correct_dob2 = 99 => 0.1830985915,
0.1922234826
);


pk_ams_age_mm := map(
pk_ams_age = -1 => 0.1963761019,
pk_ams_age = 21 => 0.1705426357,
pk_ams_age = 22 => 0.2125,
pk_ams_age = 23 => 0.1604278075,
pk_ams_age = 24 => 0.1711711712,
pk_ams_age = 25 => 0.1474654378,
pk_ams_age = 29 => 0.1592592593,
pk_ams_age = 99 => 0.1673626727,
0.1922234826
);


pk_inferred_age_mm := map(
pk_inferred_age = -1 => 0.1731092437,
pk_inferred_age = 18 => 0.2307692308,
pk_inferred_age = 19 => 0.1343283582,
pk_inferred_age = 20 => 0.1772151899,
pk_inferred_age = 21 => 0.1927710843,
pk_inferred_age = 22 => 0.179144385,
pk_inferred_age = 24 => 0.1655874191,
pk_inferred_age = 34 => 0.167442892,
pk_inferred_age = 37 => 0.1678125,
pk_inferred_age = 41 => 0.1875432526,
pk_inferred_age = 42 => 0.1880597015,
pk_inferred_age = 43 => 0.1962338949,
pk_inferred_age = 44 => 0.1981230448,
pk_inferred_age = 46 => 0.2080954852,
pk_inferred_age = 48 => 0.1964002118,
pk_inferred_age = 52 => 0.199690881,
pk_inferred_age = 56 => 0.2133794694,
pk_inferred_age = 61 => 0.2299376299,
pk_inferred_age = 99 => 0.2341568206,
0.1922234826
);


pk_add2_avm_auto_diff4_lvl_mm := map(
pk_add2_avm_auto_diff4_lvl = -1 => 0.1948057345,
pk_add2_avm_auto_diff4_lvl = 0 => 0.1879199533,
pk_add2_avm_auto_diff4_lvl = 1 => 0.1710526316,
0.1922234826
);


pk2_add1_avm_sp_mm := map(
pk2_add1_avm_sp = 0 => 0.1890554249,
pk2_add1_avm_sp = 1 => 0.1887351779,
pk2_add1_avm_sp = 2 => 0.1912704045,
pk2_add1_avm_sp = 3 => 0.2140672783,
0.1922234826
);


pk2_add1_avm_ta_mm := map(
pk2_add1_avm_ta = 0 => 0.1508333333,
pk2_add1_avm_ta = 1 => 0.1858250106,
pk2_add1_avm_ta = 2 => 0.1925675676,
pk2_add1_avm_ta = 3 => 0.2163663293,
pk2_add1_avm_ta = 4 => 0.2549019608,
0.1922234826
);


pk2_add1_avm_pi_mm := map(
pk2_add1_avm_pi = 0 => 0.118705036,
pk2_add1_avm_pi = 1 => 0.171641791,
pk2_add1_avm_pi = 2 => 0.1918445539,
pk2_add1_avm_pi = 3 => 0.221357334,
0.1922234826
);


pk2_ADD1_AVM_MED_mm := map(
pk2_ADD1_AVM_MED = 0 => 0.119266055,
pk2_ADD1_AVM_MED = 1 => 0.1520376176,
pk2_ADD1_AVM_MED = 2 => 0.165112452,
pk2_ADD1_AVM_MED = 3 => 0.1744386874,
pk2_ADD1_AVM_MED = 4 => 0.1838572106,
pk2_ADD1_AVM_MED = 5 => 0.2088982347,
pk2_ADD1_AVM_MED = 6 => 0.2732240437,
pk2_ADD1_AVM_MED = 7 => 0.181724392,
0.1922234826
);


pk2_add1_avm_to_med_ratio_mm := map(
pk2_add1_avm_to_med_ratio = 0 => 0.1837812906,
pk2_add1_avm_to_med_ratio = 1 => 0.2088983051,
pk2_add1_avm_to_med_ratio = 2 => 0.2052877138,
pk2_add1_avm_to_med_ratio = 3 => 0.1983062809,
pk2_add1_avm_to_med_ratio = 4 => 0.2210626186,
pk2_add1_avm_to_med_ratio = 5 => 0.2012037833,
0.1922234826
);


pk2_yr_add1_avm_rec_dt_mm := map(
pk2_yr_add1_avm_rec_dt = 0 => 0.144324016,
pk2_yr_add1_avm_rec_dt = 1 => 0.1637744035,
pk2_yr_add1_avm_rec_dt = 2 => 0.1899615043,
pk2_yr_add1_avm_rec_dt = 3 => 0.2071827884,
pk2_yr_add1_avm_rec_dt = 4 => 0.2280777538,
0.1922234826
);


pk2_yr_add1_avm_assess_year_mm := map(
pk2_yr_add1_avm_assess_year = 0 => 0.1853508772,
pk2_yr_add1_avm_assess_year = 1 => 0.2369496142,
pk2_yr_add1_avm_assess_year = 2 => 0.196730203,
0.1922234826
);


pk_dist_a1toa3_mm := map(
pk_dist_a1toa3 = 0 => 0.1989113714,
pk_dist_a1toa3 = 1 => 0.1862452793,
pk_dist_a1toa3 = 2 => 0.1907462928,
pk_dist_a1toa3 = 3 => 0.1759873618,
pk_dist_a1toa3 = 4 => 0.202232436,
pk_dist_a1toa3 = 5 => 0.2049763033,
pk_dist_a1toa3 = 6 => 0.2232435982,
0.1922234826
);


pk_rc_disthphoneaddr_mm := map(
pk_rc_disthphoneaddr = 0 => 0.2380462137,
pk_rc_disthphoneaddr = 1 => 0.1705435847,
pk_rc_disthphoneaddr = 2 => 0.1472902098,
pk_rc_disthphoneaddr = 3 => 0.1425446172,
pk_rc_disthphoneaddr = 4 => 0.1222741433,
0.1922234826
);


pk_out_st_division_lvl_mm := map(
pk_out_st_division_lvl = -1 => 0.2692307692,
pk_out_st_division_lvl = 0 => 0.1801720235,
pk_out_st_division_lvl = 1 => 0.1666121648,
pk_out_st_division_lvl = 2 => 0.2588365243,
pk_out_st_division_lvl = 3 => 0.1551939925,
pk_out_st_division_lvl = 4 => 0.1890095981,
pk_out_st_division_lvl = 5 => 0.2045203969,
pk_out_st_division_lvl = 6 => 0.2259143622,
pk_out_st_division_lvl = 7 => 0.1855590062,
pk_out_st_division_lvl = 8 => 0.1644417476,
0.1922234826
);


pk_impulse_count_mm := map(
pk_impulse_count = 0 => 0.1942545619,
pk_impulse_count = 1 => 0.1608391608,
pk_impulse_count = 2 => 0.1742574257,
0.1922234826
);


pk_derog_total_mm := map(
pk_derog_total = -4 => 0.2398190045,
pk_derog_total = -3 => 0.209057072,
pk_derog_total = -2 => 0.2072480181,
pk_derog_total = -1 => 0.2048408785,
pk_derog_total = 0 => 0.0700808625,
pk_derog_total = 1 => 0.1965200971,
pk_derog_total = 2 => 0.1870362287,
pk_derog_total = 3 => 0.1763549325,
0.1922234826
);


pk_attr_num_nonderogs90_b_mm := map(
pk_attr_num_nonderogs90_b = 0 => 0.0702247191,
pk_attr_num_nonderogs90_b = 1 => 0.1987431265,
pk_attr_num_nonderogs90_b = 2 => 0.1479970867,
pk_attr_num_nonderogs90_b = 3 => 0.1737871108,
pk_attr_num_nonderogs90_b = 4 => 0.1644144144,
pk_attr_num_nonderogs90_b = 10 => 0.0833333333,
pk_attr_num_nonderogs90_b = 11 => 0.1743233176,
pk_attr_num_nonderogs90_b = 12 => 0.2095079787,
pk_attr_num_nonderogs90_b = 13 => 0.2204939064,
pk_attr_num_nonderogs90_b = 14 => 0.2402298851,
0.1922234826
);


pk_add1_unit_count2_mm := map(
pk_add1_unit_count2 = 0 => 0.1932176656,
pk_add1_unit_count2 = 1 => 0.1904761905,
pk_add1_unit_count2 = 2 => 0.1795407098,
pk_add1_unit_count2 = 3 => 0.1899092971,
0.1922234826
);


pk_ssns_per_addr2_mm := map(
pk_ssns_per_addr2 = -101 => 0.2081368954,
pk_ssns_per_addr2 = -2 => 0.2884615385,
pk_ssns_per_addr2 = -1 => 0.2300242131,
pk_ssns_per_addr2 = 0 => 0.2155824508,
pk_ssns_per_addr2 = 1 => 0.2187938289,
pk_ssns_per_addr2 = 2 => 0.2232192933,
pk_ssns_per_addr2 = 3 => 0.2231075697,
pk_ssns_per_addr2 = 4 => 0.1933731668,
pk_ssns_per_addr2 = 5 => 0.1944298476,
pk_ssns_per_addr2 = 6 => 0.1862030286,
pk_ssns_per_addr2 = 7 => 0.1901279707,
pk_ssns_per_addr2 = 8 => 0.1884109492,
pk_ssns_per_addr2 = 9 => 0.1851546392,
pk_ssns_per_addr2 = 10 => 0.1776723823,
pk_ssns_per_addr2 = 11 => 0.1710166542,
pk_ssns_per_addr2 = 12 => 0.1570185395,
pk_ssns_per_addr2 = 100 => 0.2245989305,
pk_ssns_per_addr2 = 101 => 0.1975806452,
pk_ssns_per_addr2 = 102 => 0.1820744081,
pk_ssns_per_addr2 = 103 => 0.1550179211,
0.1922234826
);


pk_yr_add1_assess_val_yr2_mm := map(
pk_yr_add1_assess_val_yr2 = -1 => 0.1839477485,
pk_yr_add1_assess_val_yr2 = 0 => 0.1993774163,
pk_yr_add1_assess_val_yr2 = 1 => 0.1887439945,
pk_yr_add1_assess_val_yr2 = 2 => 0.1830065359,
0.1922234826
);


pk_prop_owned_assess_count_mm := map(
pk_prop_owned_assess_count = 0 => 0.1851779276,
pk_prop_owned_assess_count = 1 => 0.2116296481,
pk_prop_owned_assess_count = 2 => 0.1947245927,
pk_prop_owned_assess_count = 3 => 0.1939120631,
pk_prop_owned_assess_count = 4 => 0.2100656455,
0.1922234826
);


pk_yr_prop1_prev_purch_dt2_mm := map(
pk_yr_prop1_prev_purch_dt2 = -1 => 0.1884715917,
pk_yr_prop1_prev_purch_dt2 = 0 => 0.2099737533,
pk_yr_prop1_prev_purch_dt2 = 1 => 0.1893830703,
pk_yr_prop1_prev_purch_dt2 = 2 => 0.1984635083,
pk_yr_prop1_prev_purch_dt2 = 3 => 0.2108433735,
pk_yr_prop1_prev_purch_dt2 = 4 => 0.2158872518,
pk_yr_prop1_prev_purch_dt2 = 5 => 0.1857410882,
pk_yr_prop1_prev_purch_dt2 = 6 => 0.2024048096,
pk_yr_prop1_prev_purch_dt2 = 7 => 0.2093023256,
0.1922234826
);


pk_yr_prop2_prev_purch_dt2_mm := map(
pk_yr_prop2_prev_purch_dt2 = -1 => 0.1904953338,
pk_yr_prop2_prev_purch_dt2 = 0 => 0.2109768379,
pk_yr_prop2_prev_purch_dt2 = 1 => 0.2131147541,
0.1922234826
);


pk_yr_add2_assess_val_yr2_mm := map(
pk_yr_add2_assess_val_yr2 = -1 => 0.1982411528,
pk_yr_add2_assess_val_yr2 = 1 => 0.2133333333,
pk_yr_add2_assess_val_yr2 = 2 => 0.1824874312,
0.1922234826
);


pk_c_bargains_mm := map(
pk_c_bargains = -9 => 0.1994047619,
pk_c_bargains = 0 => 0.2036629392,
pk_c_bargains = 1 => 0.2042682927,
pk_c_bargains = 2 => 0.1859550562,
pk_c_bargains = 3 => 0.1796708501,
0.1922234826
);


pk_c_bel_edu_mm := map(
pk_c_bel_edu = -9 => 0.1994047619,
pk_c_bel_edu = 0 => 0.2313539192,
pk_c_bel_edu = 1 => 0.2070442646,
pk_c_bel_edu = 2 => 0.2078836227,
pk_c_bel_edu = 3 => 0.2221035771,
pk_c_bel_edu = 4 => 0.2082561524,
pk_c_bel_edu = 5 => 0.2006838506,
pk_c_bel_edu = 6 => 0.1769230769,
pk_c_bel_edu = 7 => 0.1802780191,
pk_c_bel_edu = 8 => 0.1774193548,
0.1922234826
);


pk_c_lowrent_mm := map(
pk_c_lowrent = -9 => 0.1994047619,
pk_c_lowrent = 0 => 0.2211557688,
pk_c_lowrent = 1 => 0.2152466368,
pk_c_lowrent = 2 => 0.2082095885,
pk_c_lowrent = 3 => 0.1902597403,
pk_c_lowrent = 4 => 0.1823617339,
pk_c_lowrent = 5 => 0.165,
0.1922234826
);


pk_c_med_hval_mm := map(
pk_c_med_hval = -9 => 0.1994047619,
pk_c_med_hval = 0 => 0.1626700323,
pk_c_med_hval = 1 => 0.1756262695,
pk_c_med_hval = 2 => 0.1790770844,
pk_c_med_hval = 3 => 0.1875,
pk_c_med_hval = 4 => 0.2010467425,
pk_c_med_hval = 5 => 0.2020977232,
pk_c_med_hval = 6 => 0.2164634146,
pk_c_med_hval = 7 => 0.2252488214,
pk_c_med_hval = 8 => 0.2312342569,
pk_c_med_hval = 9 => 0.2463217845,
0.1922234826
);


pk_rel_count_mm := map(
pk_rel_count = -9 => 0.1819620253,
pk_rel_count = -3 => 0.2300242131,
pk_rel_count = -2 => 0.2403846154,
pk_rel_count = -1 => 0.2477732794,
pk_rel_count = 0 => 0.2369526095,
pk_rel_count = 1 => 0.235044748,
pk_rel_count = 2 => 0.2133963074,
pk_rel_count = 3 => 0.194568869,
pk_rel_count = 4 => 0.1924920128,
pk_rel_count = 5 => 0.1782117416,
pk_rel_count = 6 => 0.1601713654,
0.1922234826
);


pk_rel_bankrupt_count_mm := map(
pk_rel_bankrupt_count = -9 => 0.1819620253,
pk_rel_bankrupt_count = 0 => 0.2065563583,
pk_rel_bankrupt_count = 1 => 0.1958539231,
pk_rel_bankrupt_count = 2 => 0.1809353944,
pk_rel_bankrupt_count = 3 => 0.1764705882,
pk_rel_bankrupt_count = 4 => 0.1770833333,
0.1922234826
);


pk_rel_felony_count_mm := map(
pk_rel_felony_count = -9 => 0.1819620253,
pk_rel_felony_count = 0 => 0.201522183,
pk_rel_felony_count = 1 => 0.1710378117,
pk_rel_felony_count = 2 => 0.1730268864,
pk_rel_felony_count = 3 => 0.1651270208,
pk_rel_felony_count = 4 => 0.1455497382,
0.1922234826
);


pk_crim_rel_within100miles_mm := map(
pk_crim_rel_within100miles = -9 => 0.1819620253,
pk_crim_rel_within100miles = 0 => 0.1961919221,
pk_crim_rel_within100miles = 1 => 0.1732120711,
pk_crim_rel_within100miles = 2 => 0.1593673966,
0.1922234826
);


pk_crim_rel_withinOther_mm := map(
pk_crim_rel_withinOther = -9 => 0.1819620253,
pk_crim_rel_withinOther = 0 => 0.1964207451,
pk_crim_rel_withinOther = 1 => 0.1890932559,
pk_crim_rel_withinOther = 2 => 0.1744127936,
pk_crim_rel_withinOther = 3 => 0.1607773852,
0.1922234826
);


pk_rel_prop_owned_count_mm := map(
pk_rel_prop_owned_count = -9 => 0.1819620253,
pk_rel_prop_owned_count = -3 => 0.2006137323,
pk_rel_prop_owned_count = -2 => 0.2052700922,
pk_rel_prop_owned_count = -1 => 0.1956021275,
pk_rel_prop_owned_count = 0 => 0.183186764,
pk_rel_prop_owned_count = 1 => 0.1798302032,
0.1922234826
);


pk_rel_prop_own_prch_tot2_mm := map(
pk_rel_prop_own_prch_tot2 = -9 => 0.1819620253,
pk_rel_prop_own_prch_tot2 = -1 => 0.1747951619,
pk_rel_prop_own_prch_tot2 = 0 => 0.2011118955,
pk_rel_prop_own_prch_tot2 = 1 => 0.1919880878,
0.1922234826
);


pk_rel_prop_owned_prch_cnt_mm := map(
pk_rel_prop_owned_prch_cnt = -9 => 0.1819620253,
pk_rel_prop_owned_prch_cnt = 0 => 0.2011118955,
pk_rel_prop_owned_prch_cnt = 1 => 0.1888206078,
pk_rel_prop_owned_prch_cnt = 2 => 0.1860996799,
0.1922234826
);


pk_rel_prop_own_assess_tot2_mm := map(
pk_rel_prop_own_assess_tot2 = -9 => 0.1819620253,
pk_rel_prop_own_assess_tot2 = -1 => 0.1601848286,
pk_rel_prop_own_assess_tot2 = 0 => 0.2002508838,
pk_rel_prop_own_assess_tot2 = 1 => 0.1956215794,
pk_rel_prop_own_assess_tot2 = 2 => 0.1920987907,
0.1922234826
);


pk_rel_prop_owned_as_cnt_mm := map(
pk_rel_prop_owned_as_cnt = -9 => 0.1819620253,
pk_rel_prop_owned_as_cnt = -1 => 0.2002508838,
pk_rel_prop_owned_as_cnt = 0 => 0.1915380702,
pk_rel_prop_owned_as_cnt = 1 => 0.1825203252,
0.1922234826
);


pk_rel_prop_sold_count_mm := map(
pk_rel_prop_sold_count = -9 => 0.1819620253,
pk_rel_prop_sold_count = 0 => 0.1915118031,
pk_rel_prop_sold_count = 1 => 0.1919459644,
pk_rel_prop_sold_count = 2 => 0.196438018,
0.1922234826
);


pk_rel_prop_sold_prch_tot2_mm := map(
pk_rel_prop_sold_prch_tot2 = -9 => 0.1819620253,
pk_rel_prop_sold_prch_tot2 = -1 => 0.1726069246,
pk_rel_prop_sold_prch_tot2 = 0 => 0.191214128,
pk_rel_prop_sold_prch_tot2 = 1 => 0.1855043798,
pk_rel_prop_sold_prch_tot2 = 2 => 0.2128916741,
0.1922234826
);


pk_rel_prop_sold_as_tot2_mm := map(
pk_rel_prop_sold_as_tot2 = -9 => 0.1819620253,
pk_rel_prop_sold_as_tot2 = -1 => 0.1594349142,
pk_rel_prop_sold_as_tot2 = 0 => 0.1929781659,
pk_rel_prop_sold_as_tot2 = 1 => 0.1944915807,
0.1922234826
);


pk_rel_within25miles_count_mm := map(
pk_rel_within25miles_count = -9 => 0.1819620253,
pk_rel_within25miles_count = -3 => 0.187585266,
pk_rel_within25miles_count = -2 => 0.2187600385,
pk_rel_within25miles_count = -1 => 0.205169113,
pk_rel_within25miles_count = 0 => 0.2092103404,
pk_rel_within25miles_count = 1 => 0.1974330534,
pk_rel_within25miles_count = 2 => 0.1869275604,
pk_rel_within25miles_count = 3 => 0.1772262774,
pk_rel_within25miles_count = 4 => 0.1710697272,
pk_rel_within25miles_count = 5 => 0.1533242877,
0.1922234826
);


pk_rel_incomeunder25_count_mm := map(
pk_rel_incomeunder25_count = -9 => 0.1819620253,
pk_rel_incomeunder25_count = 0 => 0.218037054,
pk_rel_incomeunder25_count = 1 => 0.2038286737,
pk_rel_incomeunder25_count = 2 => 0.202247191,
pk_rel_incomeunder25_count = 3 => 0.1948627104,
pk_rel_incomeunder25_count = 4 => 0.1760950523,
pk_rel_incomeunder25_count = 5 => 0.1682302772,
pk_rel_incomeunder25_count = 6 => 0.1487905066,
pk_rel_incomeunder25_count = 7 => 0.1522633745,
0.1922234826
);


pk_rel_incomeunder50_count_mm := map(
pk_rel_incomeunder50_count = -9 => 0.1819620253,
pk_rel_incomeunder50_count = 0 => 0.2461103253,
pk_rel_incomeunder50_count = 1 => 0.2345053635,
pk_rel_incomeunder50_count = 2 => 0.2098934135,
pk_rel_incomeunder50_count = 3 => 0.2091118505,
pk_rel_incomeunder50_count = 4 => 0.1938914644,
pk_rel_incomeunder50_count = 5 => 0.1758015213,
pk_rel_incomeunder50_count = 6 => 0.1626059322,
pk_rel_incomeunder50_count = 7 => 0.1517104611,
0.1922234826
);


pk_rel_incomeunder75_count_mm := map(
pk_rel_incomeunder75_count = -9 => 0.1819620253,
pk_rel_incomeunder75_count = -3 => 0.1892643099,
pk_rel_incomeunder75_count = -2 => 0.1917435355,
pk_rel_incomeunder75_count = -1 => 0.197123616,
pk_rel_incomeunder75_count = 0 => 0.1945490137,
pk_rel_incomeunder75_count = 1 => 0.1876550868,
pk_rel_incomeunder75_count = 2 => 0.1923809524,
0.1922234826
);


pk_rel_incomeunder100_count_mm := map(
pk_rel_incomeunder100_count = -9 => 0.1819620253,
pk_rel_incomeunder100_count = -3 => 0.1875597031,
pk_rel_incomeunder100_count = -2 => 0.1997028862,
pk_rel_incomeunder100_count = -1 => 0.2114870882,
pk_rel_incomeunder100_count = 0 => 0.226459144,
pk_rel_incomeunder100_count = 1 => 0.2047853624,
pk_rel_incomeunder100_count = 2 => 0.1875,
pk_rel_incomeunder100_count = 3 => 0.1548387097,
0.1922234826
);


pk_rel_incomeover100_count_mm := map(
pk_rel_incomeover100_count = -9 => 0.1819620253,
pk_rel_incomeover100_count = 0 => 0.1886904409,
pk_rel_incomeover100_count = 1 => 0.2231362468,
pk_rel_incomeover100_count = 2 => 0.2162883845,
pk_rel_incomeover100_count = 3 => 0.2462941847,
0.1922234826
);


pk_rel_homeunder100_count_mm := map(
pk_rel_homeunder100_count = -9 => 0.1819620253,
pk_rel_homeunder100_count = 0 => 0.2340933192,
pk_rel_homeunder100_count = 1 => 0.2202898551,
pk_rel_homeunder100_count = 2 => 0.1954979202,
pk_rel_homeunder100_count = 3 => 0.1922313581,
pk_rel_homeunder100_count = 4 => 0.1801495581,
pk_rel_homeunder100_count = 5 => 0.1650124069,
pk_rel_homeunder100_count = 6 => 0.1612525607,
pk_rel_homeunder100_count = 7 => 0.1494435612,
0.1922234826
);


pk_rel_homeunder200_count_mm := map(
pk_rel_homeunder200_count = -9 => 0.1819620253,
pk_rel_homeunder200_count = 0 => 0.1870893888,
pk_rel_homeunder200_count = 1 => 0.1980955354,
pk_rel_homeunder200_count = 2 => 0.1946418808,
pk_rel_homeunder200_count = 3 => 0.2010953518,
0.1922234826
);


pk_rel_homeunder300_count_mm := map(
pk_rel_homeunder300_count = -9 => 0.1819620253,
pk_rel_homeunder300_count = 0 => 0.1855959946,
pk_rel_homeunder300_count = 1 => 0.1978065803,
pk_rel_homeunder300_count = 2 => 0.2184801382,
pk_rel_homeunder300_count = 3 => 0.2147701583,
0.1922234826
);


pk_rel_homeunder500_count_mm := map(
pk_rel_homeunder500_count = -9 => 0.1819620253,
pk_rel_homeunder500_count = 0 => 0.1884665147,
pk_rel_homeunder500_count = 1 => 0.2122400942,
pk_rel_homeunder500_count = 2 => 0.2223393045,
pk_rel_homeunder500_count = 3 => 0.2293090357,
0.1922234826
);


pk_rel_homeover500_count_mm := map(
pk_rel_homeover500_count = -9 => 0.1819620253,
pk_rel_homeover500_count = 0 => 0.1907168989,
pk_rel_homeover500_count = 1 => 0.2303433001,
pk_rel_homeover500_count = 2 => 0.2380952381,
0.1922234826
);


pk_rel_educationunder12_count_mm := map(
pk_rel_educationunder12_count = -9 => 0.1819620253,
pk_rel_educationunder12_count = 0 => 0.2096530105,
pk_rel_educationunder12_count = 1 => 0.1776834897,
pk_rel_educationunder12_count = 2 => 0.169885967,
pk_rel_educationunder12_count = 3 => 0.1685823755,
0.1922234826
);


pk_rel_educationover12_count_mm := map(
pk_rel_educationover12_count = -9 => 0.1819620253,
pk_rel_educationover12_count = -2 => 0.2286821705,
pk_rel_educationover12_count = -1 => 0.2108527132,
pk_rel_educationover12_count = 0 => 0.2060843965,
pk_rel_educationover12_count = 1 => 0.1848638548,
pk_rel_educationover12_count = 2 => 0.1811422778,
pk_rel_educationover12_count = 3 => 0.1647572286,
0.1922234826
);


pk_rel_ageunder30_count_mm := map(
pk_rel_ageunder30_count = -9 => 0.1819620253,
pk_rel_ageunder30_count = 0 => 0.1966558523,
pk_rel_ageunder30_count = 1 => 0.18782453,
pk_rel_ageunder30_count = 2 => 0.1745379877,
0.1922234826
);


pk_rel_ageunder40_count_mm := map(
pk_rel_ageunder40_count = -9 => 0.1819620253,
pk_rel_ageunder40_count = 0 => 0.2190619137,
pk_rel_ageunder40_count = 1 => 0.1905325444,
pk_rel_ageunder40_count = 2 => 0.1838380644,
pk_rel_ageunder40_count = 3 => 0.1620189274,
0.1922234826
);


pk_rel_ageunder50_count_mm := map(
pk_rel_ageunder50_count = -9 => 0.1819620253,
pk_rel_ageunder50_count = 0 => 0.2045769259,
pk_rel_ageunder50_count = 1 => 0.1867606008,
pk_rel_ageunder50_count = 2 => 0.1519756839,
0.1922234826
);


pk_rel_ageunder70_count_mm := map(
pk_rel_ageunder70_count = -9 => 0.1819620253,
pk_rel_ageunder70_count = 0 => 0.1922601215,
pk_rel_ageunder70_count = 1 => 0.1979865772,
0.1922234826
);


pk_rel_ageover70_count_mm := map(
pk_rel_ageover70_count = -9 => 0.1819620253,
pk_rel_ageover70_count = 0 => 0.1924410729,
pk_rel_ageover70_count = 1 => 0.1880108992,
0.1922234826
);


pk_rel_vehicle_owned_count_mm := map(
pk_rel_vehicle_owned_count = -9 => 0.1819620253,
pk_rel_vehicle_owned_count = 0 => 0.2191537877,
pk_rel_vehicle_owned_count = 1 => 0.2045387125,
pk_rel_vehicle_owned_count = 2 => 0.1718421478,
pk_rel_vehicle_owned_count = 3 => 0.1582224738,
0.1922234826
);


pk_rel_count_addr_mm := map(
pk_rel_count_addr = -9 => 0.1819620253,
pk_rel_count_addr = 0 => 0.1697202683,
pk_rel_count_addr = 1 => 0.2034649315,
0.1922234826
);


pk_attr_arrests24_mm := map(
pk_attr_arrests24 = 0 => 0.1923148369,
pk_attr_arrests24 = 1 => 0.1769911504,
0.1922234826
);


pk_acc_damage_amt_total2_mm := map(
pk_acc_damage_amt_total2 = -1 => 0.1931242832,
pk_acc_damage_amt_total2 = 0 => 0.1623931624,
pk_acc_damage_amt_total2 = 1 => 0.1214285714,
pk_acc_damage_amt_total2 = 2 => 0.1823436679,
0.1922234826
);


pk_acc_damage_amt_last2_mm := map(
pk_acc_damage_amt_last2 = -1 => 0.193098241,
pk_acc_damage_amt_last2 = 0 => 0.1573033708,
pk_acc_damage_amt_last2 = 1 => 0.1795131846,
0.1922234826
);


pk_add1_fc_index_flag_mm := map(
pk_add1_fc_index_flag = 0 => 0.1918790863,
pk_add1_fc_index_flag = 1 => 0.2923076923,
0.1922234826
);


pk_current_count_mm := map(
pk_current_count = 0 => 0.2021351754,
pk_current_count = 1 => 0.1879248515,
pk_current_count = 2 => 0.185309408,
pk_current_count = 3 => 0.1832061069,
0.1922234826
);


pk_historical_count_mm := map(
pk_historical_count = 0 => 0.2165114038,
pk_historical_count = 1 => 0.1890724968,
pk_historical_count = 2 => 0.183286385,
pk_historical_count = 3 => 0.1657207719,
0.1922234826
);


pk_add2_avm_med2_mm := map(
pk_add2_avm_med2 = -1 => 0.1812585499,
pk_add2_avm_med2 = 0 => 0.1174438687,
pk_add2_avm_med2 = 1 => 0.1604197901,
pk_add2_avm_med2 = 2 => 0.1627906977,
pk_add2_avm_med2 = 3 => 0.1579128047,
pk_add2_avm_med2 = 4 => 0.1772980046,
pk_add2_avm_med2 = 5 => 0.2047217538,
pk_add2_avm_med2 = 6 => 0.1952801297,
pk_add2_avm_med2 = 7 => 0.2114098945,
pk_add2_avm_med2 = 8 => 0.2058226134,
pk_add2_avm_med2 = 9 => 0.232930737,
0.1922234826
);


       elseif (pk_segment2 = 3 ) then /* 3 Mid              */



pk_voter_count_mm := map(
pk_voter_count = 0 => 0.1123005777,
pk_voter_count = 1 => 0.1136868847,
pk_voter_count = 2 => 0.1059019332,
0.1099553951
);


pk_estimated_income_mm := map(
pk_estimated_income = -1 => 0.0714285714,
pk_estimated_income = 2 => 0.0895104895,
pk_estimated_income = 3 => 0.1169154229,
pk_estimated_income = 4 => 0.0929878049,
pk_estimated_income = 5 => 0.0919786096,
pk_estimated_income = 6 => 0.096196868,
pk_estimated_income = 7 => 0.0777323203,
pk_estimated_income = 8 => 0.1041954818,
pk_estimated_income = 9 => 0.0976902688,
pk_estimated_income = 10 => 0.0990425883,
pk_estimated_income = 11 => 0.0907797382,
pk_estimated_income = 12 => 0.0964900749,
pk_estimated_income = 13 => 0.1040183113,
pk_estimated_income = 14 => 0.0988843813,
pk_estimated_income = 15 => 0.1008858268,
pk_estimated_income = 16 => 0.090054816,
pk_estimated_income = 17 => 0.1044701155,
pk_estimated_income = 18 => 0.1037710618,
pk_estimated_income = 19 => 0.1049262455,
pk_estimated_income = 20 => 0.1219276704,
pk_estimated_income = 21 => 0.1803278689,
pk_estimated_income = 22 => 0.1739130435,
0.1099553951
);


pk_yr_adl_pr_first_seen2_mm := map(
pk_yr_adl_pr_first_seen2 = -1 => 0.1054170024,
pk_yr_adl_pr_first_seen2 = 0 => 0.1647058824,
pk_yr_adl_pr_first_seen2 = 1 => 0.1177396506,
pk_yr_adl_pr_first_seen2 = 2 => 0.1042890717,
pk_yr_adl_pr_first_seen2 = 3 => 0.1167455669,
pk_yr_adl_pr_first_seen2 = 4 => 0.1154973617,
pk_yr_adl_pr_first_seen2 = 5 => 0.119255381,
pk_yr_adl_pr_first_seen2 = 6 => 0.110866373,
pk_yr_adl_pr_first_seen2 = 7 => 0.0951327434,
0.1099553951
);


pk_yr_adl_w_first_seen2_mm := map(
pk_yr_adl_w_first_seen2 = -1 => 0.1097803995,
pk_yr_adl_w_first_seen2 = 0 => 0.1604010025,
pk_yr_adl_w_first_seen2 = 1 => 0.11065852,
pk_yr_adl_w_first_seen2 = 2 => 0.1006160164,
0.1099553951
);


pk_yr_adl_pr_last_seen2_mm := map(
pk_yr_adl_pr_last_seen2 = -1 => 0.1054170024,
pk_yr_adl_pr_last_seen2 = 0 => 0.1218858228,
pk_yr_adl_pr_last_seen2 = 1 => 0.1124839379,
pk_yr_adl_pr_last_seen2 = 2 => 0.1158874363,
pk_yr_adl_pr_last_seen2 = 3 => 0.1085514834,
pk_yr_adl_pr_last_seen2 = 4 => 0.1129543055,
pk_yr_adl_pr_last_seen2 = 5 => 0.1282420749,
pk_yr_adl_pr_last_seen2 = 6 => 0.2096774194,
0.1099553951
);


pk_yr_adl_w_last_seen2_mm := map(
pk_yr_adl_w_last_seen2 = -1 => 0.1097803995,
pk_yr_adl_w_last_seen2 = 1 => 0.1575342466,
pk_yr_adl_w_last_seen2 = 2 => 0.1090159104,
0.1099553951
);


pk_addrs_sourced_lvl_mm := map(
pk_addrs_sourced_lvl = 0 => 0.1066880824,
pk_addrs_sourced_lvl = 1 => 0.12268431,
pk_addrs_sourced_lvl = 2 => 0.1066666667,
pk_addrs_sourced_lvl = 3 => 0.117720414,
0.1099553951
);


pk_add1_own_level_mm := map(
pk_add1_own_level = -1 => 0.1132521134,
pk_add1_own_level = 0 => 0.1062360694,
pk_add1_own_level = 1 => 0.1133157548,
pk_add1_own_level = 2 => 0.1070677324,
pk_add1_own_level = 3 => 0.1133524608,
0.1099553951
);


pk_add2_own_level_mm := map(
pk_add2_own_level = 0 => 0.105875524,
pk_add2_own_level = 1 => 0.1196339558,
pk_add2_own_level = 2 => 0.1143695015,
pk_add2_own_level = 3 => 0.1273991078,
0.1099553951
);


pk_add3_own_level_mm := map(
pk_add3_own_level = 0 => 0.1081326996,
pk_add3_own_level = 1 => 0.1135832395,
pk_add3_own_level = 2 => 0.1180349489,
pk_add3_own_level = 3 => 0.1229881567,
0.1099553951
);


pk_prop_owned_sold_level_mm := map(
pk_prop_owned_sold_level = 0 => 0.1063801004,
pk_prop_owned_sold_level = 1 => 0.1264124294,
pk_prop_owned_sold_level = 2 => 0.1138129564,
0.1099553951
);


pk_naprop_level2_mm := map(
pk_naprop_level2 = -2 => 0.1029349213,
pk_naprop_level2 = -1 => 0.1065560524,
pk_naprop_level2 = 0 => 0.103894691,
pk_naprop_level2 = 1 => 0.1199727335,
pk_naprop_level2 = 2 => 0.108921516,
pk_naprop_level2 = 3 => 0.1063450955,
pk_naprop_level2 = 4 => 0.1226740179,
pk_naprop_level2 = 5 => 0.1193209575,
pk_naprop_level2 = 6 => 0.1066950241,
pk_naprop_level2 = 7 => 0.1237222886,
0.1099553951
);


pk_yr_add1_built_date2_mm := map(
pk_yr_add1_built_date2 = -4 => 0.1076198438,
pk_yr_add1_built_date2 = -2 => 0.1519823789,
pk_yr_add1_built_date2 = -1 => 0.1346314325,
pk_yr_add1_built_date2 = 0 => 0.1169777284,
pk_yr_add1_built_date2 = 1 => 0.1157705171,
pk_yr_add1_built_date2 = 2 => 0.1105285235,
pk_yr_add1_built_date2 = 3 => 0.1015029854,
0.1099553951
);


pk_add1_purchase_amount2_mm := map(
pk_add1_purchase_amount2 = -1 => 0.1115178106,
pk_add1_purchase_amount2 = 0 => 0.0914373611,
pk_add1_purchase_amount2 = 1 => 0.1183257056,
0.1099553951
);


pk_yr_add1_mortgage_date2_mm := map(
pk_yr_add1_mortgage_date2 = -1 => 0.1058665977,
pk_yr_add1_mortgage_date2 = 0 => 0.1110405285,
pk_yr_add1_mortgage_date2 = 1 => 0.1231031866,
pk_yr_add1_mortgage_date2 = 2 => 0.1119185156,
0.1099553951
);


pk_add1_mortgage_risk_mm := map(
pk_add1_mortgage_risk = -1 => 0.1085959009,
pk_add1_mortgage_risk = 0 => 0.1266450917,
pk_add1_mortgage_risk = 1 => 0.1078921956,
pk_add1_mortgage_risk = 2 => 0.1228119706,
pk_add1_mortgage_risk = 3 => 0.1178325688,
0.1099553951
);


pk_add1_assessed_amount2_mm := map(
pk_add1_assessed_amount2 = -1 => 0.1130928046,
pk_add1_assessed_amount2 = 0 => 0.0870214753,
pk_add1_assessed_amount2 = 1 => 0.0869459328,
pk_add1_assessed_amount2 = 2 => 0.0897046047,
pk_add1_assessed_amount2 = 3 => 0.0940721649,
pk_add1_assessed_amount2 = 4 => 0.1091150229,
pk_add1_assessed_amount2 = 5 => 0.1157546603,
pk_add1_assessed_amount2 = 6 => 0.1219652441,
0.1099553951
);


pk_yr_add1_mortgage_due_date2_mm := map(
pk_yr_add1_mortgage_due_date2 = -1 => 0.1072113381,
pk_yr_add1_mortgage_due_date2 = 0 => 0.1240349974,
pk_yr_add1_mortgage_due_date2 = 1 => 0.1182530223,
pk_yr_add1_mortgage_due_date2 = 2 => 0.1252941176,
0.1099553951
);


pk_yr_add1_date_first_seen2_mm := map(
pk_yr_add1_date_first_seen2 = -1 => 0.1139734582,
pk_yr_add1_date_first_seen2 = 0 => 0.142737497,
pk_yr_add1_date_first_seen2 = 1 => 0.1320553781,
pk_yr_add1_date_first_seen2 = 2 => 0.1218660347,
pk_yr_add1_date_first_seen2 = 3 => 0.1061097257,
pk_yr_add1_date_first_seen2 = 4 => 0.105375,
pk_yr_add1_date_first_seen2 = 5 => 0.1034969421,
pk_yr_add1_date_first_seen2 = 6 => 0.0970181044,
pk_yr_add1_date_first_seen2 = 7 => 0.097720402,
pk_yr_add1_date_first_seen2 = 8 => 0.1005104521,
pk_yr_add1_date_first_seen2 = 9 => 0.1011254019,
pk_yr_add1_date_first_seen2 = 10 => 0.1089147287,
0.1099553951
);


pk_add1_building_area2_mm := map(
pk_add1_building_area2 = -99 => 0.1084695707,
pk_add1_building_area2 = -4 => 0.1002397036,
pk_add1_building_area2 = -3 => 0.0951269332,
pk_add1_building_area2 = -2 => 0.1080246039,
pk_add1_building_area2 = -1 => 0.1253122814,
pk_add1_building_area2 = 0 => 0.1327170683,
pk_add1_building_area2 = 1 => 0.1376146789,
pk_add1_building_area2 = 2 => 0.0681818182,
pk_add1_building_area2 = 3 => 0.1310043668,
pk_add1_building_area2 = 4 => 0.1208791209,
0.1099553951
);


pk_add1_no_of_buildings_mm := map(
pk_add1_no_of_buildings = -1 => 0.1133452305,
pk_add1_no_of_buildings = 0 => 0.0969906076,
pk_add1_no_of_buildings = 1 => 0.1066969353,
pk_add1_no_of_buildings = 2 => 0.1058823529,
0.1099553951
);


pk_add1_no_of_rooms_mm := map(
pk_add1_no_of_rooms = -1 => 0.1087841191,
pk_add1_no_of_rooms = 0 => 0.0962962963,
pk_add1_no_of_rooms = 1 => 0.1133424098,
pk_add1_no_of_rooms = 2 => 0.1101991184,
pk_add1_no_of_rooms = 3 => 0.1175072617,
pk_add1_no_of_rooms = 4 => 0.1235611511,
0.1099553951
);


pk_add1_no_of_baths_mm := map(
pk_add1_no_of_baths = -3 => 0.1080590278,
pk_add1_no_of_baths = -2 => 0.0981127911,
pk_add1_no_of_baths = -1 => 0.1166680711,
pk_add1_no_of_baths = 0 => 0.1357560568,
pk_add1_no_of_baths = 1 => 0.1471365639,
pk_add1_no_of_baths = 2 => 0.0954773869,
0.1099553951
);


pk_add1_parking_no_of_cars_mm := map(
pk_add1_parking_no_of_cars = 0 => 0.1066507953,
pk_add1_parking_no_of_cars = 1 => 0.1021303258,
pk_add1_parking_no_of_cars = 2 => 0.1270264991,
pk_add1_parking_no_of_cars = 3 => 0.1355648536,
0.1099553951
);


pk_add1_style_code_level_mm := map(
pk_add1_style_code_level = 0 => 0.1101244617,
pk_add1_style_code_level = 1 => 0.0884422111,
pk_add1_style_code_level = 2 => 0.1155440415,
pk_add1_style_code_level = 3 => 0.0962463908,
pk_add1_style_code_level = 4 => 0.1124053582,
0.1099553951
);


pk_prop1_sale_price2_mm := map(
pk_prop1_sale_price2 = 0 => 0.1082628288,
pk_prop1_sale_price2 = 1 => 0.1090146751,
pk_prop1_sale_price2 = 2 => 0.1193897575,
0.1099553951
);


pk_prop1_prev_purchase_price2_mm := map(
pk_prop1_prev_purchase_price2 = 0 => 0.1096457599,
pk_prop1_prev_purchase_price2 = 1 => 0.1061452514,
pk_prop1_prev_purchase_price2 = 2 => 0.1185510428,
0.1099553951
);


pk_yr_prop2_sale_date2_mm := map(
pk_yr_prop2_sale_date2 = 0 => 0.1084315827,
pk_yr_prop2_sale_date2 = 1 => 0.1246089677,
pk_yr_prop2_sale_date2 = 2 => 0.1228389445,
pk_yr_prop2_sale_date2 = 3 => 0.1286913273,
0.1099553951
);


pk_add2_land_use_risk_level_mm := map(
pk_add2_land_use_risk_level = 0 => 0.1262135922,
pk_add2_land_use_risk_level = 2 => 0.1156973108,
pk_add2_land_use_risk_level = 3 => 0.1061468065,
pk_add2_land_use_risk_level = 4 => 0.1015360583,
0.1099553951
);


pk_add2_no_of_buildings_mm := map(
pk_add2_no_of_buildings = -1 => 0.1121142406,
pk_add2_no_of_buildings = 0 => 0.09967056,
pk_add2_no_of_buildings = 1 => 0.1031286211,
pk_add2_no_of_buildings = 2 => 0.0990566038,
0.1099553951
);


pk_add2_no_of_stories_mm := map(
pk_add2_no_of_stories = -1 => 0.1095503584,
pk_add2_no_of_stories = 0 => 0.1110758672,
pk_add2_no_of_stories = 1 => 0.0986500519,
0.1099553951
);


pk_add2_no_of_baths_mm := map(
pk_add2_no_of_baths = -3 => 0.1070838994,
pk_add2_no_of_baths = -2 => 0.1018672199,
pk_add2_no_of_baths = -1 => 0.1196556506,
pk_add2_no_of_baths = 0 => 0.1459940653,
pk_add2_no_of_baths = 1 => 0.1411764706,
pk_add2_no_of_baths = 2 => 0.110787172,
0.1099553951
);


pk_add2_garage_type_risk_lvl_mm := map(
pk_add2_garage_type_risk_lvl = 0 => 0.1250722961,
pk_add2_garage_type_risk_lvl = 1 => 0.1268923077,
pk_add2_garage_type_risk_lvl = 2 => 0.1000495295,
pk_add2_garage_type_risk_lvl = 3 => 0.1077764088,
0.1099553951
);


pk_add2_style_code_level_mm := map(
pk_add2_style_code_level = 0 => 0.1098854647,
pk_add2_style_code_level = 1 => 0.1067251462,
pk_add2_style_code_level = 2 => 0.1138613861,
pk_add2_style_code_level = 3 => 0.0899470899,
pk_add2_style_code_level = 4 => 0.1175050302,
0.1099553951
);


pk_yr_add2_built_date2_mm := map(
pk_yr_add2_built_date2 = -1 => 0.1073389754,
pk_yr_add2_built_date2 = 0 => 0.1356620634,
pk_yr_add2_built_date2 = 1 => 0.1266766021,
pk_yr_add2_built_date2 = 2 => 0.1121545824,
0.1099553951
);


pk_add2_purchase_amount2_mm := map(
pk_add2_purchase_amount2 = -1 => 0.1101327313,
pk_add2_purchase_amount2 = 0 => 0.0923246521,
pk_add2_purchase_amount2 = 1 => 0.1187563313,
0.1099553951
);


pk_add2_mortgage_amount2_mm := map(
pk_add2_mortgage_amount2 = -1 => 0.10626198,
pk_add2_mortgage_amount2 = 0 => 0.1035458318,
pk_add2_mortgage_amount2 = 1 => 0.124127042,
pk_add2_mortgage_amount2 = 2 => 0.1320163816,
0.1099553951
);


pk_add2_mortgage_risk_mm := map(
pk_add2_mortgage_risk = -1 => 0.1148581384,
pk_add2_mortgage_risk = 0 => 0.1314902225,
pk_add2_mortgage_risk = 1 => 0.1069715029,
pk_add2_mortgage_risk = 2 => 0.1419907242,
pk_add2_mortgage_risk = 3 => 0.1232079784,
0.1099553951
);


pk_yr_add2_mortgage_due_date2_mm := map(
pk_yr_add2_mortgage_due_date2 = -1 => 0.1074262755,
pk_yr_add2_mortgage_due_date2 = 0 => 0.1192828394,
pk_yr_add2_mortgage_due_date2 = 1 => 0.1234354769,
pk_yr_add2_mortgage_due_date2 = 2 => 0.1351565597,
pk_yr_add2_mortgage_due_date2 = 3 => 0.1252669039,
0.1099553951
);


pk_add2_assessed_amount2_mm := map(
pk_add2_assessed_amount2 = -1 => 0.1101561484,
pk_add2_assessed_amount2 = 0 => 0.0944548287,
pk_add2_assessed_amount2 = 1 => 0.0965917126,
pk_add2_assessed_amount2 = 2 => 0.1039726878,
pk_add2_assessed_amount2 = 3 => 0.1200802862,
pk_add2_assessed_amount2 = 4 => 0.1289755755,
0.1099553951
);


pk_yr_add2_date_first_seen2_mm := map(
pk_yr_add2_date_first_seen2 = -1 => 0.1121732345,
pk_yr_add2_date_first_seen2 = 0 => 0.1030496803,
pk_yr_add2_date_first_seen2 = 1 => 0.0985393173,
pk_yr_add2_date_first_seen2 = 2 => 0.1091570649,
pk_yr_add2_date_first_seen2 = 3 => 0.1162004304,
pk_yr_add2_date_first_seen2 = 4 => 0.1172383465,
pk_yr_add2_date_first_seen2 = 5 => 0.1117900791,
pk_yr_add2_date_first_seen2 = 6 => 0.1270921986,
pk_yr_add2_date_first_seen2 = 7 => 0.1097748998,
pk_yr_add2_date_first_seen2 = 8 => 0.1100409137,
pk_yr_add2_date_first_seen2 = 9 => 0.1127298782,
pk_yr_add2_date_first_seen2 = 10 => 0.1127730762,
pk_yr_add2_date_first_seen2 = 11 => 0.114037806,
0.1099553951
);


pk_yr_add2_date_last_seen2_mm := map(
pk_yr_add2_date_last_seen2 = -1 => 0.1121732345,
pk_yr_add2_date_last_seen2 = 0 => 0.1088803943,
pk_yr_add2_date_last_seen2 = 1 => 0.1127939793,
pk_yr_add2_date_last_seen2 = 2 => 0.1072,
pk_yr_add2_date_last_seen2 = 3 => 0.1094722286,
pk_yr_add2_date_last_seen2 = 4 => 0.1160949868,
pk_yr_add2_date_last_seen2 = 5 => 0.1177045973,
pk_yr_add2_date_last_seen2 = 6 => 0.0995280995,
0.1099553951
);


pk_yr_add3_built_date2_mm := map(
pk_yr_add3_built_date2 = -1 => 0.1089780536,
pk_yr_add3_built_date2 = 0 => 0.0948717949,
pk_yr_add3_built_date2 = 1 => 0.1270305393,
pk_yr_add3_built_date2 = 2 => 0.121045392,
pk_yr_add3_built_date2 = 3 => 0.1095381002,
0.1099553951
);


pk_add3_purchase_amount2_mm := map(
pk_add3_purchase_amount2 = -1 => 0.1098962194,
pk_add3_purchase_amount2 = 0 => 0.0997319035,
pk_add3_purchase_amount2 = 1 => 0.0969305331,
pk_add3_purchase_amount2 = 2 => 0.1063561989,
pk_add3_purchase_amount2 = 3 => 0.1112847014,
pk_add3_purchase_amount2 = 4 => 0.126897737,
0.1099553951
);


pk_add3_mortgage_risk_mm := map(
pk_add3_mortgage_risk = -1 => 0.1116504854,
pk_add3_mortgage_risk = 0 => 0.1185495119,
pk_add3_mortgage_risk = 1 => 0.1023622047,
pk_add3_mortgage_risk = 2 => 0.1086051275,
pk_add3_mortgage_risk = 3 => 0.1263616558,
pk_add3_mortgage_risk = 4 => 0.1252591057,
pk_add3_mortgage_risk = 5 => 0.1165501166,
0.1099553951
);


pk_yr_add3_mortgage_due_date2_mm := map(
pk_yr_add3_mortgage_due_date2 = -1 => 0.108125386,
pk_yr_add3_mortgage_due_date2 = 0 => 0.1241586538,
pk_yr_add3_mortgage_due_date2 = 1 => 0.1223690651,
0.1099553951
);


pk_add3_assessed_amount2_mm := map(
pk_add3_assessed_amount2 = -1 => 0.1114200461,
pk_add3_assessed_amount2 = 0 => 0.0893408135,
pk_add3_assessed_amount2 = 1 => 0.0869285254,
pk_add3_assessed_amount2 = 2 => 0.1103194103,
pk_add3_assessed_amount2 = 3 => 0.1184973394,
0.1099553951
);


pk_yr_add3_date_first_seen2_mm := map(
pk_yr_add3_date_first_seen2 = -1 => 0.1130034809,
pk_yr_add3_date_first_seen2 = 0 => 0.1078099399,
pk_yr_add3_date_first_seen2 = 1 => 0.104768658,
pk_yr_add3_date_first_seen2 = 2 => 0.1143064282,
pk_yr_add3_date_first_seen2 = 3 => 0.1025043681,
pk_yr_add3_date_first_seen2 = 4 => 0.1067976549,
pk_yr_add3_date_first_seen2 = 5 => 0.1079957819,
pk_yr_add3_date_first_seen2 = 6 => 0.1117737418,
pk_yr_add3_date_first_seen2 = 7 => 0.1105937136,
pk_yr_add3_date_first_seen2 = 8 => 0.1169640675,
pk_yr_add3_date_first_seen2 = 9 => 0.1134154245,
0.1099553951
);


pk_yr_add3_date_last_seen2_mm := map(
pk_yr_add3_date_last_seen2 = -1 => 0.1130034809,
pk_yr_add3_date_last_seen2 = 0 => 0.1090488771,
pk_yr_add3_date_last_seen2 = 1 => 0.1103222663,
pk_yr_add3_date_last_seen2 = 2 => 0.1123348018,
pk_yr_add3_date_last_seen2 = 3 => 0.1059041159,
pk_yr_add3_date_last_seen2 = 4 => 0.1082738422,
pk_yr_add3_date_last_seen2 = 5 => 0.1118291655,
pk_yr_add3_date_last_seen2 = 6 => 0.1116463587,
pk_yr_add3_date_last_seen2 = 7 => 0.1169635941,
pk_yr_add3_date_last_seen2 = 8 => 0.1083514437,
0.1099553951
);


pk_yr_attr_dt_last_purch2_mm := map(
pk_yr_attr_dt_last_purch2 = -1 => 0.1054628095,
pk_yr_attr_dt_last_purch2 = 0 => 0.1277013752,
pk_yr_attr_dt_last_purch2 = 1 => 0.1176079734,
pk_yr_attr_dt_last_purch2 = 2 => 0.118762089,
pk_yr_attr_dt_last_purch2 = 3 => 0.1187668464,
pk_yr_attr_dt_last_purch2 = 4 => 0.1221864952,
pk_yr_attr_dt_last_purch2 = 5 => 0.1090643948,
pk_yr_attr_dt_last_purch2 = 6 => 0.1020748867,
pk_yr_attr_dt_last_purch2 = 7 => 0.0900735294,
0.1099553951
);


pk_yr_attr_date_last_sale2_mm := map(
pk_yr_attr_date_last_sale2 = -1 => 0.1064534552,
pk_yr_attr_date_last_sale2 = 0 => 0.1190178292,
pk_yr_attr_date_last_sale2 = 1 => 0.1049745398,
pk_yr_attr_date_last_sale2 = 2 => 0.1132869693,
pk_yr_attr_date_last_sale2 = 3 => 0.1275042445,
pk_yr_attr_date_last_sale2 = 4 => 0.1294411712,
0.1099553951
);


pk_attr_num_watercraft24_mm := map(
pk_attr_num_watercraft24 = 0 => 0.1097109614,
pk_attr_num_watercraft24 = 1 => 0.1320272572,
pk_attr_num_watercraft24 = 2 => 0.0952380952,
0.1099553951
);


pk_bk_level_mm := map(
pk_bk_level = 0 => 0.1075297321,
pk_bk_level = 1 => 0.124264225,
pk_bk_level = 2 => 0.1072319202,
0.1099553951
);


pk_eviction_level_mm := map(
pk_eviction_level = 0 => 0.1119670309,
pk_eviction_level = 1 => 0.1004836948,
pk_eviction_level = 2 => 0.0923038229,
pk_eviction_level = 3 => 0.0916558582,
pk_eviction_level = 4 => 0.0987421384,
pk_eviction_level = 5 => 0.1155988858,
pk_eviction_level = 6 => 0.1386138614,
pk_eviction_level = 7 => 0.0601503759,
0.1099553951
);


pk_lien_type_level_mm := map(
pk_lien_type_level = 0 => 0.1143521924,
pk_lien_type_level = 1 => 0.1154855643,
pk_lien_type_level = 2 => 0.1158268869,
pk_lien_type_level = 3 => 0.1064467766,
pk_lien_type_level = 4 => 0.1049833416,
pk_lien_type_level = 5 => 0.0986185725,
0.1099553951
);


pk_yr_ln_unrel_cj_f_sn2_mm := map(
pk_yr_ln_unrel_cj_f_sn2 = -1 => 0.1130976903,
pk_yr_ln_unrel_cj_f_sn2 = 0 => 0.1223990208,
pk_yr_ln_unrel_cj_f_sn2 = 1 => 0.1096518021,
pk_yr_ln_unrel_cj_f_sn2 = 2 => 0.1017836371,
pk_yr_ln_unrel_cj_f_sn2 = 3 => 0.0987360595,
0.1099553951
);


pk_yr_ln_unrel_lt_f_sn2_mm := map(
pk_yr_ln_unrel_lt_f_sn2 = -1 => 0.1109675713,
pk_yr_ln_unrel_lt_f_sn2 = 0 => 0.1019632679,
pk_yr_ln_unrel_lt_f_sn2 = 1 => 0.0918918919,
0.1099553951
);


pk_yr_ln_unrel_ot_f_sn2_mm := map(
pk_yr_ln_unrel_ot_f_sn2 = -1 => 0.109208404,
pk_yr_ln_unrel_ot_f_sn2 = 0 => 0.1236031155,
pk_yr_ln_unrel_ot_f_sn2 = 1 => 0.1005173688,
pk_yr_ln_unrel_ot_f_sn2 = 2 => 0.1188683086,
0.1099553951
);


pk_yr_ln_unrel_sc_f_sn2_mm := map(
pk_yr_ln_unrel_sc_f_sn2 = -1 => 0.1110095884,
pk_yr_ln_unrel_sc_f_sn2 = 0 => 0.1134470448,
pk_yr_ln_unrel_sc_f_sn2 = 1 => 0.1007321161,
0.1099553951
);


pk_yr_attr_dt_l_eviction2_mm := map(
pk_yr_attr_dt_l_eviction2 = -1 => 0.1119986518,
pk_yr_attr_dt_l_eviction2 = 0 => 0.1077720207,
pk_yr_attr_dt_l_eviction2 = 1 => 0.0913358942,
pk_yr_attr_dt_l_eviction2 = 2 => 0.0952112676,
pk_yr_attr_dt_l_eviction2 = 3 => 0.0925081433,
pk_yr_attr_dt_l_eviction2 = 4 => 0.0906902087,
pk_yr_attr_dt_l_eviction2 = 5 => 0.1006278636,
0.1099553951
);


pk_yr_criminal_last_date2_mm := map(
pk_yr_criminal_last_date2 = -1 => 0.1116559313,
pk_yr_criminal_last_date2 = 0 => 0.1044052863,
pk_yr_criminal_last_date2 = 1 => 0.1056291391,
pk_yr_criminal_last_date2 = 2 => 0.1060275962,
pk_yr_criminal_last_date2 = 3 => 0.1020828565,
pk_yr_criminal_last_date2 = 4 => 0.105011196,
0.1099553951
);


pk_crime_level_mm := map(
pk_crime_level = 0 => 0.1117714431,
pk_crime_level = 1 => 0.1089985554,
pk_crime_level = 2 => 0.0837269214,
0.1099553951
);


pk_felony_recent_level_mm := map(
pk_felony_recent_level = 0 => 0.1104116832,
pk_felony_recent_level = 1 => 0.0823723229,
pk_felony_recent_level = 2 => 0.0787878788,
pk_felony_recent_level = 3 => 0.074433657,
pk_felony_recent_level = 4 => 0.0625,
0.1099553951
);


pk_attr_total_number_derogs_mm := map(
pk_attr_total_number_derogs = 0 => 0.1135037792,
pk_attr_total_number_derogs = 1 => 0.1135844182,
pk_attr_total_number_derogs = 2 => 0.1068111455,
pk_attr_total_number_derogs = 3 => 0.1046082234,
0.1099553951
);


pk_yr_rc_ssnhighissue2_mm := map(
pk_yr_rc_ssnhighissue2 = -1 => 0.0999397953,
pk_yr_rc_ssnhighissue2 = 1 => 0.0980392157,
pk_yr_rc_ssnhighissue2 = 2 => 0.1119521912,
pk_yr_rc_ssnhighissue2 = 3 => 0.104665826,
pk_yr_rc_ssnhighissue2 = 4 => 0.1159956474,
pk_yr_rc_ssnhighissue2 = 5 => 0.1217317281,
pk_yr_rc_ssnhighissue2 = 6 => 0.114772958,
pk_yr_rc_ssnhighissue2 = 7 => 0.1032672112,
pk_yr_rc_ssnhighissue2 = 8 => 0.1089351285,
pk_yr_rc_ssnhighissue2 = 9 => 0.1112432531,
pk_yr_rc_ssnhighissue2 = 10 => 0.1066003376,
pk_yr_rc_ssnhighissue2 = 11 => 0.1067275748,
pk_yr_rc_ssnhighissue2 = 12 => 0.1063884596,
pk_yr_rc_ssnhighissue2 = 13 => 0.1102761272,
pk_yr_rc_ssnhighissue2 = 14 => 0.107605178,
0.1099553951
);


pk_PL_Sourced_Level_mm := map(
pk_PL_Sourced_Level = 0 => 0.1085786739,
pk_PL_Sourced_Level = 1 => 0.1725663717,
pk_PL_Sourced_Level = 2 => 0.1206276561,
pk_PL_Sourced_Level = 3 => 0.145665773,
0.1099553951
);


pk_prof_lic_cat_mm := map(
pk_prof_lic_cat = -1 => 0.1088650955,
pk_prof_lic_cat = 0 => 0.1289529164,
pk_prof_lic_cat = 1 => 0.1195856874,
pk_prof_lic_cat = 2 => 0.118336887,
pk_prof_lic_cat = 3 => 0.1565217391,
0.1099553951
);


pk_add1_lres_mm := map(
pk_add1_lres = -2 => 0,
pk_add1_lres = -1 => 0.1195984286,
pk_add1_lres = 0 => 0.1401648999,
pk_add1_lres = 1 => 0.1333333333,
pk_add1_lres = 2 => 0.1209677419,
pk_add1_lres = 3 => 0.1486325803,
pk_add1_lres = 4 => 0.1371705218,
pk_add1_lres = 5 => 0.1348913489,
pk_add1_lres = 6 => 0.1245220626,
pk_add1_lres = 7 => 0.1089204641,
pk_add1_lres = 8 => 0.1020368854,
pk_add1_lres = 9 => 0.0998781973,
pk_add1_lres = 10 => 0.0982116537,
pk_add1_lres = 11 => 0.0856832972,
0.1099553951
);


pk_add2_lres_mm := map(
pk_add2_lres = -2 => 0.1128305583,
pk_add2_lres = -1 => 0.1052370842,
pk_add2_lres = 0 => 0.0977616853,
pk_add2_lres = 1 => 0.1022389538,
pk_add2_lres = 2 => 0.101958031,
pk_add2_lres = 3 => 0.1076377699,
pk_add2_lres = 4 => 0.1114026236,
pk_add2_lres = 5 => 0.1142857143,
pk_add2_lres = 6 => 0.1192394457,
pk_add2_lres = 7 => 0.1113166108,
pk_add2_lres = 8 => 0.1148439837,
pk_add2_lres = 9 => 0.1138878042,
pk_add2_lres = 10 => 0.1076779026,
0.1099553951
);


pk_add3_lres_mm := map(
pk_add3_lres = -2 => 0.1131839239,
pk_add3_lres = -1 => 0.106080388,
pk_add3_lres = 0 => 0.1097644638,
pk_add3_lres = 1 => 0.106605248,
pk_add3_lres = 2 => 0.1080232226,
pk_add3_lres = 3 => 0.1164407369,
pk_add3_lres = 4 => 0.1126760563,
pk_add3_lres = 5 => 0.1142857143,
pk_add3_lres = 6 => 0.1203007519,
0.1099553951
);


pk_lres_flag_level_mm := map(
pk_lres_flag_level = 0 => 0.11958103,
pk_lres_flag_level = 1 => 0.1101029252,
pk_lres_flag_level = 2 => 0.1092117339,
0.1099553951
);


pk_avg_lres_mm := map(
pk_avg_lres = -1 => 0.1055646481,
pk_avg_lres = 0 => 0.0802469136,
pk_avg_lres = 1 => 0.1402214022,
pk_avg_lres = 2 => 0.1276595745,
pk_avg_lres = 3 => 0.1386687797,
pk_avg_lres = 4 => 0.1236797274,
pk_avg_lres = 5 => 0.1268081003,
pk_avg_lres = 6 => 0.118466899,
pk_avg_lres = 7 => 0.1134197018,
pk_avg_lres = 8 => 0.1104518856,
pk_avg_lres = 9 => 0.1015550619,
pk_avg_lres = 10 => 0.1054637865,
pk_avg_lres = 11 => 0.1021143015,
pk_avg_lres = 12 => 0.1065631,
pk_avg_lres = 13 => 0.1140405202,
pk_avg_lres = 14 => 0.1061465721,
pk_avg_lres = 15 => 0.1051614684,
0.1099553951
);


pk_addrs_5yr_mm := map(
pk_addrs_5yr = 0 => 0.1079284963,
pk_addrs_5yr = 1 => 0.1092834668,
pk_addrs_5yr = 2 => 0.1116391564,
pk_addrs_5yr = 3 => 0.1118017711,
pk_addrs_5yr = 4 => 0.1119631902,
0.1099553951
);


pk_addrs_10yr_mm := map(
pk_addrs_10yr = 0 => 0.1079800499,
pk_addrs_10yr = 1 => 0.1107549858,
pk_addrs_10yr = 2 => 0.1094399187,
pk_addrs_10yr = 3 => 0.1133255178,
pk_addrs_10yr = 4 => 0.1088553493,
0.1099553951
);


pk_add_lres_year_avg2_mm := map(
pk_add_lres_year_avg2 = -1 => 0.1030927835,
pk_add_lres_year_avg2 = 0 => 0.1344410876,
pk_add_lres_year_avg2 = 1 => 0.1250193889,
pk_add_lres_year_avg2 = 2 => 0.1157828679,
pk_add_lres_year_avg2 = 3 => 0.1087573485,
pk_add_lres_year_avg2 = 4 => 0.1103558152,
pk_add_lres_year_avg2 = 5 => 0.1017364203,
pk_add_lres_year_avg2 = 6 => 0.1060737797,
pk_add_lres_year_avg2 = 7 => 0.1045178692,
pk_add_lres_year_avg2 = 8 => 0.1053026889,
pk_add_lres_year_avg2 = 9 => 0.1090756303,
pk_add_lres_year_avg2 = 10 => 0.1084718923,
pk_add_lres_year_avg2 = 11 => 0.1168677549,
pk_add_lres_year_avg2 = 12 => 0.1138530566,
pk_add_lres_year_avg2 = 13 => 0.11078238,
pk_add_lres_year_avg2 = 14 => 0.0986209779,
pk_add_lres_year_avg2 = 15 => 0.1101654846,
pk_add_lres_year_avg2 = 16 => 0.1071428571,
pk_add_lres_year_avg2 = 17 => 0.1137231854,
pk_add_lres_year_avg2 = 18 => 0.1042296073,
pk_add_lres_year_avg2 = 19 => 0.1275590551,
0.1099553951
);


pk_add_lres_year_max2_mm := map(
pk_add_lres_year_max2 = -1 => 0.1030927835,
pk_add_lres_year_max2 = 0 => 0.1490280778,
pk_add_lres_year_max2 = 1 => 0.1263206247,
pk_add_lres_year_max2 = 2 => 0.1309100847,
pk_add_lres_year_max2 = 3 => 0.1167683568,
pk_add_lres_year_max2 = 4 => 0.1096237337,
pk_add_lres_year_max2 = 5 => 0.1130807836,
pk_add_lres_year_max2 = 6 => 0.1071787653,
pk_add_lres_year_max2 = 7 => 0.1039823009,
pk_add_lres_year_max2 = 8 => 0.0984874527,
pk_add_lres_year_max2 = 9 => 0.1076645988,
pk_add_lres_year_max2 = 10 => 0.1055391433,
pk_add_lres_year_max2 = 11 => 0.1131417411,
pk_add_lres_year_max2 = 12 => 0.1089909444,
pk_add_lres_year_max2 = 13 => 0.1053465347,
pk_add_lres_year_max2 = 14 => 0.1085892301,
pk_add_lres_year_max2 = 15 => 0.1132674665,
pk_add_lres_year_max2 = 16 => 0.1057377861,
pk_add_lres_year_max2 = 17 => 0.1163230241,
pk_add_lres_year_max2 = 18 => 0.1081081081,
0.1099553951
);


pk_nameperssn_count_mm := map(
pk_nameperssn_count = 0 => 0.1099785078,
pk_nameperssn_count = 1 => 0.1091152019,
pk_nameperssn_count = 2 => 0.1235059761,
0.1099553951
);


pk_ssns_per_adl_mm := map(
pk_ssns_per_adl = -1 => 0.1096072187,
pk_ssns_per_adl = 0 => 0.11064764,
pk_ssns_per_adl = 1 => 0.1059815335,
pk_ssns_per_adl = 2 => 0.1123165284,
pk_ssns_per_adl = 3 => 0.0674603175,
pk_ssns_per_adl = 4 => 0.0909090909,
0.1099553951
);


pk_addrs_per_adl_mm := map(
pk_addrs_per_adl = -6 => 0.1046240075,
pk_addrs_per_adl = -5 => 0.1112656467,
pk_addrs_per_adl = -4 => 0.1105105105,
pk_addrs_per_adl = -3 => 0.1064394778,
pk_addrs_per_adl = -2 => 0.1144904737,
pk_addrs_per_adl = -1 => 0.1057042046,
pk_addrs_per_adl = 0 => 0.1079876274,
pk_addrs_per_adl = 1 => 0.1117524339,
pk_addrs_per_adl = 2 => 0.1144859813,
pk_addrs_per_adl = 3 => 0.1121435437,
0.1099553951
);


pk_phones_per_adl_mm := map(
pk_phones_per_adl = -1 => 0.1085098735,
pk_phones_per_adl = 0 => 0.1138984298,
pk_phones_per_adl = 1 => 0.1353065539,
pk_phones_per_adl = 2 => 0.1576923077,
0.1099553951
);


pk_addrs_per_ssn_mm := map(
pk_addrs_per_ssn = -4 => 0.0995670996,
pk_addrs_per_ssn = -3 => 0.1045978046,
pk_addrs_per_ssn = -2 => 0.1059538135,
pk_addrs_per_ssn = -1 => 0.1042475585,
pk_addrs_per_ssn = 0 => 0.1097592213,
pk_addrs_per_ssn = 1 => 0.1138361139,
pk_addrs_per_ssn = 2 => 0.1154565958,
pk_addrs_per_ssn = 3 => 0.1248891254,
0.1099553951
);


pk_adls_per_addr_mm := map(
pk_adls_per_addr = -102 => 0.119948147,
pk_adls_per_addr = -101 => 0.1138983051,
pk_adls_per_addr = -2 => 0.1095505618,
pk_adls_per_addr = -1 => 0.1138014528,
pk_adls_per_addr = 0 => 0.1303249097,
pk_adls_per_addr = 1 => 0.125,
pk_adls_per_addr = 2 => 0.116179919,
pk_adls_per_addr = 3 => 0.1113984484,
pk_adls_per_addr = 4 => 0.1098796102,
pk_adls_per_addr = 5 => 0.1049072643,
pk_adls_per_addr = 6 => 0.1136182109,
pk_adls_per_addr = 7 => 0.1097791798,
pk_adls_per_addr = 8 => 0.1142149133,
pk_adls_per_addr = 9 => 0.1060948081,
pk_adls_per_addr = 10 => 0.1059593023,
pk_adls_per_addr = 11 => 0.1014315429,
pk_adls_per_addr = 12 => 0.1028590956,
pk_adls_per_addr = 13 => 0.1001812804,
pk_adls_per_addr = 100 => 0.1096311475,
pk_adls_per_addr = 101 => 0.1013888889,
pk_adls_per_addr = 102 => 0.1082240471,
0.1099553951
);


pk_phones_per_addr_mm := map(
pk_phones_per_addr = -1 => 0.1031398,
pk_phones_per_addr = 0 => 0.1187606272,
pk_phones_per_addr = 1 => 0.1028368794,
pk_phones_per_addr = 2 => 0.1184798808,
pk_phones_per_addr = 3 => 0.1009463722,
pk_phones_per_addr = 100 => 0.0943657103,
pk_phones_per_addr = 101 => 0.1124017766,
pk_phones_per_addr = 102 => 0.1155498282,
pk_phones_per_addr = 103 => 0.1186180658,
0.1099553951
);


pk_adls_per_phone_mm := map(
pk_adls_per_phone = -2 => 0.1093180365,
pk_adls_per_phone = -1 => 0.1121250574,
pk_adls_per_phone = 0 => 0.1056482964,
pk_adls_per_phone = 1 => 0.1043478261,
0.1099553951
);


pk_addrs_per_adl_c6_mm := map(
pk_addrs_per_adl_c6 = 0 => 0.107506142,
pk_addrs_per_adl_c6 = 1 => 0.1269329286,
pk_addrs_per_adl_c6 = 2 => 0.1488645921,
pk_addrs_per_adl_c6 = 3 => 0.1226993865,
0.1099553951
);


pk_phones_per_adl_c6_mm := map(
pk_phones_per_adl_c6 = -2 => 0.1094467474,
pk_phones_per_adl_c6 = -1 => 0.1397783251,
pk_phones_per_adl_c6 = 0 => 0.1803278689,
pk_phones_per_adl_c6 = 1 => 0,
0.1099553951
);


pk_adls_per_addr_c6_mm := map(
pk_adls_per_addr_c6 = 0 => 0.1076161486,
pk_adls_per_addr_c6 = 1 => 0.1110229976,
pk_adls_per_addr_c6 = 2 => 0.1134054408,
pk_adls_per_addr_c6 = 3 => 0.1285520974,
pk_adls_per_addr_c6 = 4 => 0.1029411765,
pk_adls_per_addr_c6 = 100 => 0.1138631827,
pk_adls_per_addr_c6 = 101 => 0.1220472441,
pk_adls_per_addr_c6 = 102 => 0.1315789474,
0.1099553951
);


pk_ssns_per_addr_c6_mm := map(
pk_ssns_per_addr_c6 = 0 => 0.1076180419,
pk_ssns_per_addr_c6 = 1 => 0.1114149009,
pk_ssns_per_addr_c6 = 2 => 0.1122903115,
pk_ssns_per_addr_c6 = 3 => 0.1378151261,
pk_ssns_per_addr_c6 = 4 => 0.1102941176,
pk_ssns_per_addr_c6 = 5 => 0.1176470588,
pk_ssns_per_addr_c6 = 6 => 0.1111111111,
pk_ssns_per_addr_c6 = 100 => 0.1139143731,
pk_ssns_per_addr_c6 = 101 => 0.1198371146,
pk_ssns_per_addr_c6 = 102 => 0.1303191489,
pk_ssns_per_addr_c6 = 103 => 0.12,
pk_ssns_per_addr_c6 = 104 => 0.1842105263,
0.1099553951
);


pk_phones_per_addr_c6_mm := map(
pk_phones_per_addr_c6 = -1 => 0.1078824408,
pk_phones_per_addr_c6 = 0 => 0.1135285914,
pk_phones_per_addr_c6 = 1 => 0.1214511041,
pk_phones_per_addr_c6 = 2 => 0.1171171171,
pk_phones_per_addr_c6 = 100 => 0.1126289577,
pk_phones_per_addr_c6 = 101 => 0.1162123386,
pk_phones_per_addr_c6 = 102 => 0.1212343865,
0.1099553951
);


pk_adls_per_phone_c6_mm := map(
pk_adls_per_phone_c6 = 0 => 0.1104690687,
pk_adls_per_phone_c6 = 1 => 0.1061515988,
pk_adls_per_phone_c6 = 2 => 0.1099744246,
0.1099553951
);


pk_attr_addrs_last30_mm := map(
pk_attr_addrs_last30 = 0 => 0.1096749942,
pk_attr_addrs_last30 = 1 => 0.1408602151,
pk_attr_addrs_last30 = 2 => 0.1333333333,
0.1099553951
);


pk_attr_addrs_last36_mm := map(
pk_attr_addrs_last36 = 0 => 0.1073143467,
pk_attr_addrs_last36 = 1 => 0.1095625828,
pk_attr_addrs_last36 = 2 => 0.1102876301,
pk_attr_addrs_last36 = 3 => 0.1165578404,
pk_attr_addrs_last36 = 4 => 0.1123031666,
pk_attr_addrs_last36 = 5 => 0.1158438206,
pk_attr_addrs_last36 = 6 => 0.1132210677,
0.1099553951
);


pk_attr_addrs_last_level_mm := map(
pk_attr_addrs_last_level = 0 => 0.1073143467,
pk_attr_addrs_last_level = 1 => 0.107703114,
pk_attr_addrs_last_level = 2 => 0.1062740657,
pk_attr_addrs_last_level = 3 => 0.1161775771,
pk_attr_addrs_last_level = 4 => 0.1166609648,
pk_attr_addrs_last_level = 5 => 0.1407407407,
0.1099553951
);


pk_ams_class_level_mm := map(
pk_ams_class_level = -1000001 => 0.1096601218,
pk_ams_class_level = 0 => 0.1071428571,
pk_ams_class_level = 1 => 0.1314285714,
pk_ams_class_level = 2 => 0.119047619,
pk_ams_class_level = 3 => 0.0769230769,
pk_ams_class_level = 4 => 0.0913793103,
pk_ams_class_level = 5 => 0.1072749692,
pk_ams_class_level = 6 => 0.1215440793,
pk_ams_class_level = 7 => 0.1118712274,
pk_ams_class_level = 8 => 0.1036150713,
pk_ams_class_level = 1000000 => 0.1073903002,
pk_ams_class_level = 1000001 => 0.13174946,
pk_ams_class_level = 1000002 => 0.1219827586,
pk_ams_class_level = 1000003 => 0.128742515,
pk_ams_class_level = 1000004 => 0.1157024793,
pk_ams_class_level = 1000005 => 0.1262458472,
0.1099553951
);


pk_ams_income_level_code_mm := map(
pk_ams_income_level_code = -1 => 0.1096537857,
pk_ams_income_level_code = 0 => 0.1087398374,
pk_ams_income_level_code = 1 => 0.0807971014,
pk_ams_income_level_code = 2 => 0.1065622229,
pk_ams_income_level_code = 3 => 0.1162400336,
pk_ams_income_level_code = 4 => 0.1135793622,
pk_ams_income_level_code = 5 => 0.137037037,
pk_ams_income_level_code = 6 => 0.1712511091,
0.1099553951
);


pk_ams_college_tier_mm := map(
pk_ams_college_tier = -1 => 0.1092080133,
pk_ams_college_tier = 0 => 0.1153846154,
pk_ams_college_tier = 1 => 0.2112676056,
pk_ams_college_tier = 2 => 0.1226993865,
pk_ams_college_tier = 3 => 0.1174270755,
pk_ams_college_tier = 4 => 0.1298429319,
pk_ams_college_tier = 5 => 0.1069012179,
pk_ams_college_tier = 6 => 0.1288936627,
0.1099553951
);


pk_yr_rc_correct_dob2_mm := map(
pk_yr_rc_correct_dob2 = -1 => 0.1099426858,
pk_yr_rc_correct_dob2 = 21 => 0.1212121212,
pk_yr_rc_correct_dob2 = 33 => 0.1216389245,
pk_yr_rc_correct_dob2 = 61 => 0.1080705009,
pk_yr_rc_correct_dob2 = 99 => 0.0983146067,
0.1099553951
);


pk_ams_age_mm := map(
pk_ams_age = -1 => 0.1101640135,
pk_ams_age = 21 => 0.1078098472,
pk_ams_age = 22 => 0.0789473684,
pk_ams_age = 23 => 0.1089108911,
pk_ams_age = 24 => 0.1026438569,
pk_ams_age = 25 => 0.1109399076,
pk_ams_age = 29 => 0.1121673004,
pk_ams_age = 99 => 0.1096345515,
0.1099553951
);


pk_inferred_age_mm := map(
pk_inferred_age = -1 => 0.105065666,
pk_inferred_age = 18 => 0.1488439306,
pk_inferred_age = 19 => 0.1033057851,
pk_inferred_age = 20 => 0.104516129,
pk_inferred_age = 21 => 0.1154734411,
pk_inferred_age = 22 => 0.1114551084,
pk_inferred_age = 24 => 0.1136885037,
pk_inferred_age = 34 => 0.1154690181,
pk_inferred_age = 37 => 0.1054145304,
pk_inferred_age = 41 => 0.1114290825,
pk_inferred_age = 42 => 0.1132575758,
pk_inferred_age = 43 => 0.1057066258,
pk_inferred_age = 44 => 0.1132872504,
pk_inferred_age = 46 => 0.1120166793,
pk_inferred_age = 48 => 0.1023121387,
pk_inferred_age = 52 => 0.1092268214,
pk_inferred_age = 56 => 0.1022911051,
pk_inferred_age = 61 => 0.1057160418,
pk_inferred_age = 99 => 0.1053706596,
0.1099553951
);


pk_add2_avm_auto_diff4_lvl_mm := map(
pk_add2_avm_auto_diff4_lvl = -1 => 0.1064691164,
pk_add2_avm_auto_diff4_lvl = 0 => 0.1170728768,
pk_add2_avm_auto_diff4_lvl = 1 => 0.1420765027,
0.1099553951
);


pk2_add1_avm_sp_mm := map(
pk2_add1_avm_sp = 0 => 0.1059358999,
pk2_add1_avm_sp = 1 => 0.1061525841,
pk2_add1_avm_sp = 2 => 0.119711173,
pk2_add1_avm_sp = 3 => 0.1326961164,
0.1099553951
);


pk2_add1_avm_ta_mm := map(
pk2_add1_avm_ta = 0 => 0.0827880512,
pk2_add1_avm_ta = 1 => 0.1048998639,
pk2_add1_avm_ta = 2 => 0.1111568547,
pk2_add1_avm_ta = 3 => 0.1295160834,
pk2_add1_avm_ta = 4 => 0.1620839363,
0.1099553951
);


pk2_add1_avm_pi_mm := map(
pk2_add1_avm_pi = 0 => 0.0934371524,
pk2_add1_avm_pi = 1 => 0.1030052943,
pk2_add1_avm_pi = 2 => 0.1082597042,
pk2_add1_avm_pi = 3 => 0.1331726133,
0.1099553951
);


pk2_ADD1_AVM_MED_mm := map(
pk2_ADD1_AVM_MED = 0 => 0.0766550523,
pk2_ADD1_AVM_MED = 1 => 0.0868263473,
pk2_ADD1_AVM_MED = 2 => 0.0874012922,
pk2_ADD1_AVM_MED = 3 => 0.0963941449,
pk2_ADD1_AVM_MED = 4 => 0.105687974,
pk2_ADD1_AVM_MED = 5 => 0.1235869766,
pk2_ADD1_AVM_MED = 6 => 0.159554731,
pk2_ADD1_AVM_MED = 7 => 0.0965250965,
0.1099553951
);


pk2_add1_avm_to_med_ratio_mm := map(
pk2_add1_avm_to_med_ratio = 0 => 0.1054858058,
pk2_add1_avm_to_med_ratio = 1 => 0.1178998779,
pk2_add1_avm_to_med_ratio = 2 => 0.124614792,
pk2_add1_avm_to_med_ratio = 3 => 0.1154211312,
pk2_add1_avm_to_med_ratio = 4 => 0.1176917236,
pk2_add1_avm_to_med_ratio = 5 => 0.1086803105,
0.1099553951
);


pk2_yr_add1_avm_rec_dt_mm := map(
pk2_yr_add1_avm_rec_dt = 0 => 0.1120196239,
pk2_yr_add1_avm_rec_dt = 1 => 0.123407993,
pk2_yr_add1_avm_rec_dt = 2 => 0.1074560506,
pk2_yr_add1_avm_rec_dt = 3 => 0.118293247,
pk2_yr_add1_avm_rec_dt = 4 => 0.1097119699,
0.1099553951
);


pk2_yr_add1_avm_assess_year_mm := map(
pk2_yr_add1_avm_assess_year = 0 => 0.1052153255,
pk2_yr_add1_avm_assess_year = 1 => 0.1310151615,
pk2_yr_add1_avm_assess_year = 2 => 0.1146755778,
0.1099553951
);


pk_dist_a1toa3_mm := map(
pk_dist_a1toa3 = 0 => 0.1061307728,
pk_dist_a1toa3 = 1 => 0.1070015903,
pk_dist_a1toa3 = 2 => 0.1139961037,
pk_dist_a1toa3 = 3 => 0.1102247191,
pk_dist_a1toa3 = 4 => 0.1060775959,
pk_dist_a1toa3 = 5 => 0.1165129925,
pk_dist_a1toa3 = 6 => 0.1135572139,
0.1099553951
);


pk_rc_disthphoneaddr_mm := map(
pk_rc_disthphoneaddr = 0 => 0.1224335749,
pk_rc_disthphoneaddr = 1 => 0.1023933777,
pk_rc_disthphoneaddr = 2 => 0.1072380952,
pk_rc_disthphoneaddr = 3 => 0.1042492038,
pk_rc_disthphoneaddr = 4 => 0.1092722512,
0.1099553951
);


pk_out_st_division_lvl_mm := map(
pk_out_st_division_lvl = -1 => 0.085492228,
pk_out_st_division_lvl = 0 => 0.0865503261,
pk_out_st_division_lvl = 1 => 0.1071798189,
pk_out_st_division_lvl = 2 => 0.1453150685,
pk_out_st_division_lvl = 3 => 0.0833867864,
pk_out_st_division_lvl = 4 => 0.1041096946,
pk_out_st_division_lvl = 5 => 0.1056936821,
pk_out_st_division_lvl = 6 => 0.1377486105,
pk_out_st_division_lvl = 7 => 0.1013028635,
pk_out_st_division_lvl = 8 => 0.0881904181,
0.1099553951
);


pk_impulse_count_mm := map(
pk_impulse_count = 0 => 0.1094291893,
pk_impulse_count = 1 => 0.1184772516,
pk_impulse_count = 2 => 0.1144200627,
0.1099553951
);


pk_derog_total_mm := map(
pk_derog_total = -4 => 0.1337209302,
pk_derog_total = -3 => 0.1262529324,
pk_derog_total = -2 => 0.1142725251,
pk_derog_total = -1 => 0.1144845035,
pk_derog_total = 0 => 0.0747889023,
pk_derog_total = 1 => 0.1135844182,
pk_derog_total = 2 => 0.1068111455,
pk_derog_total = 3 => 0.1046082234,
0.1099553951
);


pk_attr_num_nonderogs90_b_mm := map(
pk_attr_num_nonderogs90_b = 0 => 0.0868974881,
pk_attr_num_nonderogs90_b = 1 => 0.1152012712,
pk_attr_num_nonderogs90_b = 2 => 0.0962692026,
pk_attr_num_nonderogs90_b = 3 => 0.1102575689,
pk_attr_num_nonderogs90_b = 4 => 0.1196581197,
pk_attr_num_nonderogs90_b = 10 => 0.0626486915,
pk_attr_num_nonderogs90_b = 11 => 0.1022549993,
pk_attr_num_nonderogs90_b = 12 => 0.1156314656,
pk_attr_num_nonderogs90_b = 13 => 0.1254741465,
pk_attr_num_nonderogs90_b = 14 => 0.1367088608,
0.1099553951
);


pk_add1_unit_count2_mm := map(
pk_add1_unit_count2 = 0 => 0.1085752385,
pk_add1_unit_count2 = 1 => 0.1158301158,
pk_add1_unit_count2 = 2 => 0.1041009464,
pk_add1_unit_count2 = 3 => 0.1143752116,
0.1099553951
);


pk_ssns_per_addr2_mm := map(
pk_ssns_per_addr2 = -101 => 0.1193293219,
pk_ssns_per_addr2 = -2 => 0.0948905109,
pk_ssns_per_addr2 = -1 => 0.1205357143,
pk_ssns_per_addr2 = 0 => 0.1273463379,
pk_ssns_per_addr2 = 1 => 0.1268377054,
pk_ssns_per_addr2 = 2 => 0.1180380472,
pk_ssns_per_addr2 = 3 => 0.1072853244,
pk_ssns_per_addr2 = 4 => 0.1134462355,
pk_ssns_per_addr2 = 5 => 0.1066451222,
pk_ssns_per_addr2 = 6 => 0.1132272918,
pk_ssns_per_addr2 = 7 => 0.115136697,
pk_ssns_per_addr2 = 8 => 0.1077412254,
pk_ssns_per_addr2 = 9 => 0.1046099291,
pk_ssns_per_addr2 = 10 => 0.102811532,
pk_ssns_per_addr2 = 11 => 0.1029937267,
pk_ssns_per_addr2 = 12 => 0.0998851894,
pk_ssns_per_addr2 = 100 => 0.1019313305,
pk_ssns_per_addr2 = 101 => 0.1127379209,
pk_ssns_per_addr2 = 102 => 0.1114419396,
pk_ssns_per_addr2 = 103 => 0.1028177458,
0.1099553951
);


pk_yr_add1_assess_val_yr2_mm := map(
pk_yr_add1_assess_val_yr2 = -1 => 0.1062901797,
pk_yr_add1_assess_val_yr2 = 0 => 0.1126962519,
pk_yr_add1_assess_val_yr2 = 1 => 0.1168211921,
pk_yr_add1_assess_val_yr2 = 2 => 0.1013289037,
0.1099553951
);


pk_prop_owned_assess_count_mm := map(
pk_prop_owned_assess_count = 0 => 0.1104384903,
pk_prop_owned_assess_count = 1 => 0.1060344402,
pk_prop_owned_assess_count = 2 => 0.1153488372,
pk_prop_owned_assess_count = 3 => 0.1191051995,
pk_prop_owned_assess_count = 4 => 0.1089879689,
0.1099553951
);


pk_yr_prop1_prev_purch_dt2_mm := map(
pk_yr_prop1_prev_purch_dt2 = -1 => 0.1073295624,
pk_yr_prop1_prev_purch_dt2 = 0 => 0.1247896129,
pk_yr_prop1_prev_purch_dt2 = 1 => 0.1109833237,
pk_yr_prop1_prev_purch_dt2 = 2 => 0.1238041643,
pk_yr_prop1_prev_purch_dt2 = 3 => 0.1289414414,
pk_yr_prop1_prev_purch_dt2 = 4 => 0.1178804194,
pk_yr_prop1_prev_purch_dt2 = 5 => 0.1261222745,
pk_yr_prop1_prev_purch_dt2 = 6 => 0.1151992992,
pk_yr_prop1_prev_purch_dt2 = 7 => 0.1166666667,
0.1099553951
);


pk_yr_prop2_prev_purch_dt2_mm := map(
pk_yr_prop2_prev_purch_dt2 = -1 => 0.1088219111,
pk_yr_prop2_prev_purch_dt2 = 0 => 0.1280430712,
pk_yr_prop2_prev_purch_dt2 = 1 => 0.1248357424,
0.1099553951
);


pk_yr_add2_assess_val_yr2_mm := map(
pk_yr_add2_assess_val_yr2 = -1 => 0.1062652619,
pk_yr_add2_assess_val_yr2 = 1 => 0.1279174959,
pk_yr_add2_assess_val_yr2 = 2 => 0.1128321308,
0.1099553951
);


pk_c_bargains_mm := map(
pk_c_bargains = -9 => 0.103515625,
pk_c_bargains = 0 => 0.1163236314,
pk_c_bargains = 1 => 0.1114425428,
pk_c_bargains = 2 => 0.1106090373,
pk_c_bargains = 3 => 0.1053610229,
0.1099553951
);


pk_c_bel_edu_mm := map(
pk_c_bel_edu = -9 => 0.103515625,
pk_c_bel_edu = 0 => 0.1462184874,
pk_c_bel_edu = 1 => 0.1340941512,
pk_c_bel_edu = 2 => 0.1245578105,
pk_c_bel_edu = 3 => 0.1208185754,
pk_c_bel_edu = 4 => 0.1204880016,
pk_c_bel_edu = 5 => 0.1163501002,
pk_c_bel_edu = 6 => 0.1068396917,
pk_c_bel_edu = 7 => 0.1027394629,
pk_c_bel_edu = 8 => 0.0961981995,
0.1099553951
);


pk_c_lowrent_mm := map(
pk_c_lowrent = -9 => 0.103515625,
pk_c_lowrent = 0 => 0.1335647449,
pk_c_lowrent = 1 => 0.1465125877,
pk_c_lowrent = 2 => 0.1225545051,
pk_c_lowrent = 3 => 0.1073065769,
pk_c_lowrent = 4 => 0.0989501312,
pk_c_lowrent = 5 => 0.0904378559,
0.1099553951
);


pk_c_med_hval_mm := map(
pk_c_med_hval = -9 => 0.103515625,
pk_c_med_hval = 0 => 0.0882282996,
pk_c_med_hval = 1 => 0.0960782434,
pk_c_med_hval = 2 => 0.1102672563,
pk_c_med_hval = 3 => 0.1081543433,
pk_c_med_hval = 4 => 0.1157231896,
pk_c_med_hval = 5 => 0.1225485413,
pk_c_med_hval = 6 => 0.1291019847,
pk_c_med_hval = 7 => 0.1277056277,
pk_c_med_hval = 8 => 0.1343873518,
pk_c_med_hval = 9 => 0.1549960661,
0.1099553951
);


pk_rel_count_mm := map(
pk_rel_count = -9 => 0.0968609865,
pk_rel_count = -3 => 0.1155063291,
pk_rel_count = -2 => 0.1104017026,
pk_rel_count = -1 => 0.1056580815,
pk_rel_count = 0 => 0.1238236751,
pk_rel_count = 1 => 0.107472462,
pk_rel_count = 2 => 0.1163088298,
pk_rel_count = 3 => 0.1123791488,
pk_rel_count = 4 => 0.1103209566,
pk_rel_count = 5 => 0.108011593,
pk_rel_count = 6 => 0.1046650718,
0.1099553951
);


pk_rel_bankrupt_count_mm := map(
pk_rel_bankrupt_count = -9 => 0.0968609865,
pk_rel_bankrupt_count = 0 => 0.1117318436,
pk_rel_bankrupt_count = 1 => 0.1073089559,
pk_rel_bankrupt_count = 2 => 0.1115984784,
pk_rel_bankrupt_count = 3 => 0.1100902772,
pk_rel_bankrupt_count = 4 => 0.1071237279,
0.1099553951
);


pk_rel_felony_count_mm := map(
pk_rel_felony_count = -9 => 0.0968609865,
pk_rel_felony_count = 0 => 0.1154444069,
pk_rel_felony_count = 1 => 0.1016648955,
pk_rel_felony_count = 2 => 0.0938697318,
pk_rel_felony_count = 3 => 0.0907190635,
pk_rel_felony_count = 4 => 0.0737527115,
0.1099553951
);


pk_crim_rel_within100miles_mm := map(
pk_crim_rel_within100miles = -9 => 0.0968609865,
pk_crim_rel_within100miles = 0 => 0.1110403741,
pk_crim_rel_within100miles = 1 => 0.1082936725,
pk_crim_rel_within100miles = 2 => 0.0965935604,
0.1099553951
);


pk_crim_rel_withinOther_mm := map(
pk_crim_rel_withinOther = -9 => 0.0968609865,
pk_crim_rel_withinOther = 0 => 0.1116727153,
pk_crim_rel_withinOther = 1 => 0.1078665442,
pk_crim_rel_withinOther = 2 => 0.1056072915,
pk_crim_rel_withinOther = 3 => 0.1027413588,
0.1099553951
);


pk_rel_prop_owned_count_mm := map(
pk_rel_prop_owned_count = -9 => 0.0968609865,
pk_rel_prop_owned_count = -3 => 0.1027296057,
pk_rel_prop_owned_count = -2 => 0.1065905028,
pk_rel_prop_owned_count = -1 => 0.1088568935,
pk_rel_prop_owned_count = 0 => 0.1206053707,
pk_rel_prop_owned_count = 1 => 0.1162790698,
0.1099553951
);


pk_rel_prop_own_prch_tot2_mm := map(
pk_rel_prop_own_prch_tot2 = -9 => 0.0968609865,
pk_rel_prop_own_prch_tot2 = -1 => 0.1008988921,
pk_rel_prop_own_prch_tot2 = 0 => 0.1058205188,
pk_rel_prop_own_prch_tot2 = 1 => 0.1168053039,
0.1099553951
);


pk_rel_prop_owned_prch_cnt_mm := map(
pk_rel_prop_owned_prch_cnt = -9 => 0.0968609865,
pk_rel_prop_owned_prch_cnt = 0 => 0.1058205188,
pk_rel_prop_owned_prch_cnt = 1 => 0.1125430584,
pk_rel_prop_owned_prch_cnt = 2 => 0.1212784588,
0.1099553951
);


pk_rel_prop_own_assess_tot2_mm := map(
pk_rel_prop_own_assess_tot2 = -9 => 0.0968609865,
pk_rel_prop_own_assess_tot2 = -1 => 0.0936900038,
pk_rel_prop_own_assess_tot2 = 0 => 0.1102461808,
pk_rel_prop_own_assess_tot2 = 1 => 0.1069063896,
pk_rel_prop_own_assess_tot2 = 2 => 0.1149078879,
0.1099553951
);


pk_rel_prop_owned_as_cnt_mm := map(
pk_rel_prop_owned_as_cnt = -9 => 0.0968609865,
pk_rel_prop_owned_as_cnt = -1 => 0.1102461808,
pk_rel_prop_owned_as_cnt = 0 => 0.1102677316,
pk_rel_prop_owned_as_cnt = 1 => 0.1115422886,
0.1099553951
);


pk_rel_prop_sold_count_mm := map(
pk_rel_prop_sold_count = -9 => 0.0968609865,
pk_rel_prop_sold_count = 0 => 0.1038403956,
pk_rel_prop_sold_count = 1 => 0.1163648787,
pk_rel_prop_sold_count = 2 => 0.1273446775,
0.1099553951
);


pk_rel_prop_sold_prch_tot2_mm := map(
pk_rel_prop_sold_prch_tot2 = -9 => 0.0968609865,
pk_rel_prop_sold_prch_tot2 = -1 => 0.1028880866,
pk_rel_prop_sold_prch_tot2 = 0 => 0.1052875835,
pk_rel_prop_sold_prch_tot2 = 1 => 0.1156157032,
pk_rel_prop_sold_prch_tot2 = 2 => 0.1336016097,
0.1099553951
);


pk_rel_prop_sold_as_tot2_mm := map(
pk_rel_prop_sold_as_tot2 = -9 => 0.0968609865,
pk_rel_prop_sold_as_tot2 = -1 => 0.1069824418,
pk_rel_prop_sold_as_tot2 = 0 => 0.109233488,
pk_rel_prop_sold_as_tot2 = 1 => 0.1162657174,
0.1099553951
);


pk_rel_within25miles_count_mm := map(
pk_rel_within25miles_count = -9 => 0.0968609865,
pk_rel_within25miles_count = -3 => 0.1102807971,
pk_rel_within25miles_count = -2 => 0.1171826943,
pk_rel_within25miles_count = -1 => 0.1139363354,
pk_rel_within25miles_count = 0 => 0.1157147497,
pk_rel_within25miles_count = 1 => 0.1101557992,
pk_rel_within25miles_count = 2 => 0.106810268,
pk_rel_within25miles_count = 3 => 0.1077807305,
pk_rel_within25miles_count = 4 => 0.0953516091,
pk_rel_within25miles_count = 5 => 0.0988490183,
0.1099553951
);


pk_rel_incomeunder25_count_mm := map(
pk_rel_incomeunder25_count = -9 => 0.0968609865,
pk_rel_incomeunder25_count = 0 => 0.1251487505,
pk_rel_incomeunder25_count = 1 => 0.1164809724,
pk_rel_incomeunder25_count = 2 => 0.1085415666,
pk_rel_incomeunder25_count = 3 => 0.1065157693,
pk_rel_incomeunder25_count = 4 => 0.1013634486,
pk_rel_incomeunder25_count = 5 => 0.0992090784,
pk_rel_incomeunder25_count = 6 => 0.0974768169,
pk_rel_incomeunder25_count = 7 => 0.0844221106,
0.1099553951
);


pk_rel_incomeunder50_count_mm := map(
pk_rel_incomeunder50_count = -9 => 0.0968609865,
pk_rel_incomeunder50_count = 0 => 0.1249587867,
pk_rel_incomeunder50_count = 1 => 0.1190677568,
pk_rel_incomeunder50_count = 2 => 0.1168933743,
pk_rel_incomeunder50_count = 3 => 0.1144411738,
pk_rel_incomeunder50_count = 4 => 0.1069293345,
pk_rel_incomeunder50_count = 5 => 0.1056328253,
pk_rel_incomeunder50_count = 6 => 0.1027014439,
pk_rel_incomeunder50_count = 7 => 0.0932284216,
0.1099553951
);


pk_rel_incomeunder75_count_mm := map(
pk_rel_incomeunder75_count = -9 => 0.0968609865,
pk_rel_incomeunder75_count = -3 => 0.0992479983,
pk_rel_incomeunder75_count = -2 => 0.1061041866,
pk_rel_incomeunder75_count = -1 => 0.1194524178,
pk_rel_incomeunder75_count = 0 => 0.1237810428,
pk_rel_incomeunder75_count = 1 => 0.1213969803,
pk_rel_incomeunder75_count = 2 => 0.1189083821,
0.1099553951
);


pk_rel_incomeunder100_count_mm := map(
pk_rel_incomeunder100_count = -9 => 0.0968609865,
pk_rel_incomeunder100_count = -3 => 0.1050507614,
pk_rel_incomeunder100_count = -2 => 0.1190705831,
pk_rel_incomeunder100_count = -1 => 0.1364630993,
pk_rel_incomeunder100_count = 0 => 0.1507845388,
pk_rel_incomeunder100_count = 1 => 0.1314553991,
pk_rel_incomeunder100_count = 2 => 0.1487414188,
pk_rel_incomeunder100_count = 3 => 0.1428571429,
0.1099553951
);


pk_rel_incomeover100_count_mm := map(
pk_rel_incomeover100_count = -9 => 0.0968609865,
pk_rel_incomeover100_count = 0 => 0.1071088832,
pk_rel_incomeover100_count = 1 => 0.1444058977,
pk_rel_incomeover100_count = 2 => 0.147777082,
pk_rel_incomeover100_count = 3 => 0.1672979798,
0.1099553951
);


pk_rel_homeunder100_count_mm := map(
pk_rel_homeunder100_count = -9 => 0.0968609865,
pk_rel_homeunder100_count = 0 => 0.127675406,
pk_rel_homeunder100_count = 1 => 0.114555446,
pk_rel_homeunder100_count = 2 => 0.1137790599,
pk_rel_homeunder100_count = 3 => 0.110794897,
pk_rel_homeunder100_count = 4 => 0.1000938747,
pk_rel_homeunder100_count = 5 => 0.0995062666,
pk_rel_homeunder100_count = 6 => 0.0952065678,
pk_rel_homeunder100_count = 7 => 0.0955538222,
0.1099553951
);


pk_rel_homeunder200_count_mm := map(
pk_rel_homeunder200_count = -9 => 0.0968609865,
pk_rel_homeunder200_count = 0 => 0.1034183526,
pk_rel_homeunder200_count = 1 => 0.1106730825,
pk_rel_homeunder200_count = 2 => 0.1209782609,
pk_rel_homeunder200_count = 3 => 0.1294321845,
0.1099553951
);


pk_rel_homeunder300_count_mm := map(
pk_rel_homeunder300_count = -9 => 0.0968609865,
pk_rel_homeunder300_count = 0 => 0.1031071347,
pk_rel_homeunder300_count = 1 => 0.120211772,
pk_rel_homeunder300_count = 2 => 0.1354022191,
pk_rel_homeunder300_count = 3 => 0.1410446908,
0.1099553951
);


pk_rel_homeunder500_count_mm := map(
pk_rel_homeunder500_count = -9 => 0.0968609865,
pk_rel_homeunder500_count = 0 => 0.1067213443,
pk_rel_homeunder500_count = 1 => 0.1253296107,
pk_rel_homeunder500_count = 2 => 0.1554720526,
pk_rel_homeunder500_count = 3 => 0.1596277738,
0.1099553951
);


pk_rel_homeover500_count_mm := map(
pk_rel_homeover500_count = -9 => 0.0968609865,
pk_rel_homeover500_count = 0 => 0.1085905807,
pk_rel_homeover500_count = 1 => 0.1486304445,
pk_rel_homeover500_count = 2 => 0.1822503962,
0.1099553951
);


pk_rel_educationunder12_count_mm := map(
pk_rel_educationunder12_count = -9 => 0.0968609865,
pk_rel_educationunder12_count = 0 => 0.1178932121,
pk_rel_educationunder12_count = 1 => 0.1042122684,
pk_rel_educationunder12_count = 2 => 0.1047252011,
pk_rel_educationunder12_count = 3 => 0.0774021352,
0.1099553951
);


pk_rel_educationover12_count_mm := map(
pk_rel_educationover12_count = -9 => 0.0968609865,
pk_rel_educationover12_count = -2 => 0.0962942927,
pk_rel_educationover12_count = -1 => 0.1006076975,
pk_rel_educationover12_count = 0 => 0.1126315578,
pk_rel_educationover12_count = 1 => 0.1111923921,
pk_rel_educationover12_count = 2 => 0.1092830189,
pk_rel_educationover12_count = 3 => 0.1102841064,
0.1099553951
);


pk_rel_ageunder30_count_mm := map(
pk_rel_ageunder30_count = -9 => 0.0968609865,
pk_rel_ageunder30_count = 0 => 0.1094921127,
pk_rel_ageunder30_count = 1 => 0.1118042437,
pk_rel_ageunder30_count = 2 => 0.0948536831,
0.1099553951
);


pk_rel_ageunder40_count_mm := map(
pk_rel_ageunder40_count = -9 => 0.0968609865,
pk_rel_ageunder40_count = 0 => 0.1136937388,
pk_rel_ageunder40_count = 1 => 0.1134966128,
pk_rel_ageunder40_count = 2 => 0.1076784159,
pk_rel_ageunder40_count = 3 => 0.1049526193,
0.1099553951
);


pk_rel_ageunder50_count_mm := map(
pk_rel_ageunder50_count = -9 => 0.0968609865,
pk_rel_ageunder50_count = 0 => 0.1122723341,
pk_rel_ageunder50_count = 1 => 0.109286633,
pk_rel_ageunder50_count = 2 => 0.1004390779,
0.1099553951
);


pk_rel_ageunder70_count_mm := map(
pk_rel_ageunder70_count = -9 => 0.0968609865,
pk_rel_ageunder70_count = 0 => 0.110394786,
pk_rel_ageunder70_count = 1 => 0.1100671141,
0.1099553951
);


pk_rel_ageover70_count_mm := map(
pk_rel_ageover70_count = -9 => 0.0968609865,
pk_rel_ageover70_count = 0 => 0.1100224048,
pk_rel_ageover70_count = 1 => 0.1499460626,
0.1099553951
);


pk_rel_vehicle_owned_count_mm := map(
pk_rel_vehicle_owned_count = -9 => 0.0968609865,
pk_rel_vehicle_owned_count = 0 => 0.1174321503,
pk_rel_vehicle_owned_count = 1 => 0.1133900929,
pk_rel_vehicle_owned_count = 2 => 0.103869923,
pk_rel_vehicle_owned_count = 3 => 0.0976430976,
0.1099553951
);


pk_rel_count_addr_mm := map(
pk_rel_count_addr = -9 => 0.0968609865,
pk_rel_count_addr = 0 => 0.1071408071,
pk_rel_count_addr = 1 => 0.1120884078,
0.1099553951
);


pk_attr_arrests24_mm := map(
pk_attr_arrests24 = 0 => 0.1102899429,
pk_attr_arrests24 = 1 => 0.0653846154,
0.1099553951
);


pk_acc_damage_amt_total2_mm := map(
pk_acc_damage_amt_total2 = -1 => 0.1108009623,
pk_acc_damage_amt_total2 = 0 => 0.0640569395,
pk_acc_damage_amt_total2 = 1 => 0.0826666667,
pk_acc_damage_amt_total2 = 2 => 0.0990583122,
0.1099553951
);


pk_acc_damage_amt_last2_mm := map(
pk_acc_damage_amt_last2 = -1 => 0.1108146495,
pk_acc_damage_amt_last2 = 0 => 0.0668058455,
pk_acc_damage_amt_last2 = 1 => 0.0986189802,
0.1099553951
);


pk_add1_fc_index_flag_mm := map(
pk_add1_fc_index_flag = 0 => 0.109902641,
pk_add1_fc_index_flag = 1 => 0.1260997067,
0.1099553951
);


pk_current_count_mm := map(
pk_current_count = 0 => 0.1121058573,
pk_current_count = 1 => 0.1108674019,
pk_current_count = 2 => 0.1039820247,
pk_current_count = 3 => 0.0868596882,
0.1099553951
);


pk_historical_count_mm := map(
pk_historical_count = 0 => 0.1147525366,
pk_historical_count = 1 => 0.111127645,
pk_historical_count = 2 => 0.0987663024,
pk_historical_count = 3 => 0.1009926629,
0.1099553951
);


pk_add2_avm_med2_mm := map(
pk_add2_avm_med2 = -1 => 0.0987568742,
pk_add2_avm_med2 = 0 => 0.0898954704,
pk_add2_avm_med2 = 1 => 0.0869218501,
pk_add2_avm_med2 = 2 => 0.0894774517,
pk_add2_avm_med2 = 3 => 0.0994434137,
pk_add2_avm_med2 = 4 => 0.1058505242,
pk_add2_avm_med2 = 5 => 0.1076131195,
pk_add2_avm_med2 = 6 => 0.1125924938,
pk_add2_avm_med2 = 7 => 0.1212485682,
pk_add2_avm_med2 = 8 => 0.1276654666,
pk_add2_avm_med2 = 9 => 0.1386465889,
0.1099553951
);


       // elseif (pk_segment2 = 4 ) then /* 4 Unassigned       */
       else



pk_voter_count_mm := map(
pk_voter_count = 0 => 0.0777510447,
pk_voter_count = 1 => 0.0791268759,
pk_voter_count = 2 => 0.0775339884,
0.0777258307
);


pk_estimated_income_mm := map(
pk_estimated_income = -1 => 0.0600393701,
pk_estimated_income = 2 => 0.0909090909,
pk_estimated_income = 3 => 0.1103896104,
pk_estimated_income = 4 => 0.0642201835,
pk_estimated_income = 5 => 0.0451807229,
pk_estimated_income = 6 => 0.0942028986,
pk_estimated_income = 7 => 0.0601659751,
pk_estimated_income = 8 => 0.0830508475,
pk_estimated_income = 9 => 0.0949554896,
pk_estimated_income = 10 => 0.0675496689,
pk_estimated_income = 11 => 0.0751231527,
pk_estimated_income = 12 => 0.0739695088,
pk_estimated_income = 13 => 0.0614035088,
pk_estimated_income = 14 => 0.0588235294,
pk_estimated_income = 15 => 0.0720620843,
pk_estimated_income = 16 => 0.0773420479,
pk_estimated_income = 17 => 0.0840140023,
pk_estimated_income = 18 => 0.067114094,
pk_estimated_income = 19 => 0.0813428018,
pk_estimated_income = 20 => 0.0832712964,
pk_estimated_income = 21 => 0.1363636364,
pk_estimated_income = 22 => 0.3636363636,
0.0777258307
);


pk_yr_adl_pr_first_seen2_mm := map(
pk_yr_adl_pr_first_seen2 = -1 => 0.0776176144,
pk_yr_adl_pr_first_seen2 = 0 => 0.1,
pk_yr_adl_pr_first_seen2 = 1 => 0.0813253012,
pk_yr_adl_pr_first_seen2 = 2 => 0.0757042254,
pk_yr_adl_pr_first_seen2 = 3 => 0.077241899,
pk_yr_adl_pr_first_seen2 = 4 => 0.0773430391,
pk_yr_adl_pr_first_seen2 = 5 => 0.0765374332,
pk_yr_adl_pr_first_seen2 = 6 => 0.074270557,
pk_yr_adl_pr_first_seen2 = 7 => 0.1242236025,
0.0777258307
);


pk_yr_adl_w_first_seen2_mm := map(
pk_yr_adl_w_first_seen2 = -1 => 0.0777768144,
pk_yr_adl_w_first_seen2 = 0 => 0.0895522388,
pk_yr_adl_w_first_seen2 = 1 => 0.0845070423,
pk_yr_adl_w_first_seen2 = 2 => 0.017699115,
0.0777258307
);


pk_yr_adl_pr_last_seen2_mm := map(
pk_yr_adl_pr_last_seen2 = -1 => 0.0776176144,
pk_yr_adl_pr_last_seen2 = 0 => 0.0766129032,
pk_yr_adl_pr_last_seen2 = 1 => 0.0774006623,
pk_yr_adl_pr_last_seen2 = 2 => 0.0849150849,
pk_yr_adl_pr_last_seen2 = 3 => 0.0784155214,
pk_yr_adl_pr_last_seen2 = 4 => 0.0732790526,
pk_yr_adl_pr_last_seen2 = 5 => 0.0559006211,
pk_yr_adl_pr_last_seen2 = 6 => 0,
0.0777258307
);


pk_yr_adl_w_last_seen2_mm := map(
pk_yr_adl_w_last_seen2 = -1 => 0.0777768144,
pk_yr_adl_w_last_seen2 = 1 => 0.1176470588,
pk_yr_adl_w_last_seen2 = 2 => 0.0729927007,
0.0777258307
);


pk_addrs_sourced_lvl_mm := map(
pk_addrs_sourced_lvl = 0 => 0.0765171504,
pk_addrs_sourced_lvl = 1 => 0.0844301766,
pk_addrs_sourced_lvl = 2 => 0.0782860825,
pk_addrs_sourced_lvl = 3 => 0.0758658604,
0.0777258307
);


pk_add1_own_level_mm := map(
pk_add1_own_level = -1 => 0.0738095238,
pk_add1_own_level = 0 => 0.0752946312,
pk_add1_own_level = 1 => 0.0872560276,
pk_add1_own_level = 2 => 0.0663153272,
pk_add1_own_level = 3 => 0.082088327,
0.0777258307
);


pk_add2_own_level_mm := map(
pk_add2_own_level = 0 => 0.0767942971,
pk_add2_own_level = 1 => 0.0838485317,
pk_add2_own_level = 2 => 0.0734939759,
pk_add2_own_level = 3 => 0.0801583375,
0.0777258307
);


pk_add3_own_level_mm := map(
pk_add3_own_level = 0 => 0.0774363827,
pk_add3_own_level = 1 => 0.0742337165,
pk_add3_own_level = 2 => 0.0802139037,
pk_add3_own_level = 3 => 0.0872756933,
0.0777258307
);


pk_prop_owned_sold_level_mm := map(
pk_prop_owned_sold_level = 0 => 0.0773095381,
pk_prop_owned_sold_level = 1 => 0.0929292929,
pk_prop_owned_sold_level = 2 => 0.0775308642,
0.0777258307
);


pk_naprop_level2_mm := map(
pk_naprop_level2 = -2 => 0.0570175439,
pk_naprop_level2 = -1 => 0.0742380828,
pk_naprop_level2 = 0 => 0.0616438356,
pk_naprop_level2 = 1 => 0.0888888889,
pk_naprop_level2 = 2 => 0.0783211542,
pk_naprop_level2 = 3 => 0.0857292211,
pk_naprop_level2 = 4 => 0.0827374872,
pk_naprop_level2 = 5 => 0.0873108265,
pk_naprop_level2 = 6 => 0.0775444265,
pk_naprop_level2 = 7 => 0.0819578828,
0.0777258307
);


pk_yr_add1_built_date2_mm := map(
pk_yr_add1_built_date2 = -4 => 0.0726664379,
pk_yr_add1_built_date2 = -2 => 0.0880503145,
pk_yr_add1_built_date2 = -1 => 0.0658105939,
pk_yr_add1_built_date2 = 0 => 0.0894656489,
pk_yr_add1_built_date2 = 1 => 0.0806916427,
pk_yr_add1_built_date2 = 2 => 0.0886017536,
pk_yr_add1_built_date2 = 3 => 0.0771711587,
0.0777258307
);


pk_add1_purchase_amount2_mm := map(
pk_add1_purchase_amount2 = -1 => 0.0786217698,
pk_add1_purchase_amount2 = 0 => 0.0689530686,
pk_add1_purchase_amount2 = 1 => 0.0812407681,
0.0777258307
);


pk_yr_add1_mortgage_date2_mm := map(
pk_yr_add1_mortgage_date2 = -1 => 0.0754198173,
pk_yr_add1_mortgage_date2 = 0 => 0.0711053652,
pk_yr_add1_mortgage_date2 = 1 => 0.0838206628,
pk_yr_add1_mortgage_date2 = 2 => 0.0801785714,
0.0777258307
);


pk_add1_mortgage_risk_mm := map(
pk_add1_mortgage_risk = -1 => 0.0710831721,
pk_add1_mortgage_risk = 0 => 0.0950888192,
pk_add1_mortgage_risk = 1 => 0.0776054393,
pk_add1_mortgage_risk = 2 => 0.0819672131,
pk_add1_mortgage_risk = 3 => 0.0750182083,
0.0777258307
);


pk_add1_assessed_amount2_mm := map(
pk_add1_assessed_amount2 = -1 => 0.0795471585,
pk_add1_assessed_amount2 = 0 => 0.0641312453,
pk_add1_assessed_amount2 = 1 => 0.0699708455,
pk_add1_assessed_amount2 = 2 => 0.0628717077,
pk_add1_assessed_amount2 = 3 => 0.0712328767,
pk_add1_assessed_amount2 = 4 => 0.0847184987,
pk_add1_assessed_amount2 = 5 => 0.0820793434,
pk_add1_assessed_amount2 = 6 => 0.0807692308,
0.0777258307
);


pk_yr_add1_mortgage_due_date2_mm := map(
pk_yr_add1_mortgage_due_date2 = -1 => 0.0760349914,
pk_yr_add1_mortgage_due_date2 = 0 => 0.0808823529,
pk_yr_add1_mortgage_due_date2 = 1 => 0.0886524823,
pk_yr_add1_mortgage_due_date2 = 2 => 0.0808510638,
0.0777258307
);


pk_yr_add1_date_first_seen2_mm := map(
pk_yr_add1_date_first_seen2 = -1 => 0.0683610868,
pk_yr_add1_date_first_seen2 = 0 => 0.0826521344,
pk_yr_add1_date_first_seen2 = 1 => 0.0803511141,
pk_yr_add1_date_first_seen2 = 2 => 0.0873427091,
pk_yr_add1_date_first_seen2 = 3 => 0.0870870871,
pk_yr_add1_date_first_seen2 = 4 => 0.0753941056,
pk_yr_add1_date_first_seen2 = 5 => 0.080798005,
pk_yr_add1_date_first_seen2 = 6 => 0.0636323464,
pk_yr_add1_date_first_seen2 = 7 => 0.0743955363,
pk_yr_add1_date_first_seen2 = 8 => 0.0782859497,
pk_yr_add1_date_first_seen2 = 9 => 0.0828598485,
pk_yr_add1_date_first_seen2 = 10 => 0.086622807,
0.0777258307
);


pk_add1_building_area2_mm := map(
pk_add1_building_area2 = -99 => 0.0739192315,
pk_add1_building_area2 = -4 => 0.0648994516,
pk_add1_building_area2 = -3 => 0.0862697448,
pk_add1_building_area2 = -2 => 0.0792957043,
pk_add1_building_area2 = -1 => 0.0864257813,
pk_add1_building_area2 = 0 => 0.0983899821,
pk_add1_building_area2 = 1 => 0.1346153846,
pk_add1_building_area2 = 2 => 0.1025641026,
pk_add1_building_area2 = 3 => 0.2173913043,
pk_add1_building_area2 = 4 => 0.0222222222,
0.0777258307
);


pk_add1_no_of_buildings_mm := map(
pk_add1_no_of_buildings = -1 => 0.0794832261,
pk_add1_no_of_buildings = 0 => 0.07317592,
pk_add1_no_of_buildings = 1 => 0.0511508951,
pk_add1_no_of_buildings = 2 => 0.0545454545,
0.0777258307
);


pk_add1_no_of_rooms_mm := map(
pk_add1_no_of_rooms = -1 => 0.0758557883,
pk_add1_no_of_rooms = 0 => 0.0661764706,
pk_add1_no_of_rooms = 1 => 0.0796723753,
pk_add1_no_of_rooms = 2 => 0.0880420499,
pk_add1_no_of_rooms = 3 => 0.1040609137,
pk_add1_no_of_rooms = 4 => 0.0796703297,
0.0777258307
);


pk_add1_no_of_baths_mm := map(
pk_add1_no_of_baths = -3 => 0.074881376,
pk_add1_no_of_baths = -2 => 0.0744306175,
pk_add1_no_of_baths = -1 => 0.0838441764,
pk_add1_no_of_baths = 0 => 0.0989010989,
pk_add1_no_of_baths = 1 => 0.0714285714,
pk_add1_no_of_baths = 2 => 0.1875,
0.0777258307
);


pk_add1_parking_no_of_cars_mm := map(
pk_add1_parking_no_of_cars = 0 => 0.0756202161,
pk_add1_parking_no_of_cars = 1 => 0.0682205799,
pk_add1_parking_no_of_cars = 2 => 0.0920207887,
pk_add1_parking_no_of_cars = 3 => 0.095049505,
0.0777258307
);


pk_add1_style_code_level_mm := map(
pk_add1_style_code_level = 0 => 0.0776992027,
pk_add1_style_code_level = 1 => 0.0557377049,
pk_add1_style_code_level = 2 => 0.0636792453,
pk_add1_style_code_level = 3 => 0.125,
pk_add1_style_code_level = 4 => 0.0801526718,
0.0777258307
);


pk_prop1_sale_price2_mm := map(
pk_prop1_sale_price2 = 0 => 0.0781204819,
pk_prop1_sale_price2 = 1 => 0.0639810427,
pk_prop1_sale_price2 = 2 => 0.0768678161,
0.0777258307
);


pk_prop1_prev_purchase_price2_mm := map(
pk_prop1_prev_purchase_price2 = 0 => 0.0780913919,
pk_prop1_prev_purchase_price2 = 1 => 0.0494117647,
pk_prop1_prev_purchase_price2 = 2 => 0.0826666667,
0.0777258307
);


pk_yr_prop2_sale_date2_mm := map(
pk_yr_prop2_sale_date2 = 0 => 0.0772368657,
pk_yr_prop2_sale_date2 = 1 => 0.0509803922,
pk_yr_prop2_sale_date2 = 2 => 0.0783216783,
pk_yr_prop2_sale_date2 = 3 => 0.1032448378,
0.0777258307
);


pk_add2_land_use_risk_level_mm := map(
pk_add2_land_use_risk_level = 0 => 0.1132075472,
pk_add2_land_use_risk_level = 2 => 0.078920827,
pk_add2_land_use_risk_level = 3 => 0.0775816993,
pk_add2_land_use_risk_level = 4 => 0.0640834575,
0.0777258307
);


pk_add2_no_of_buildings_mm := map(
pk_add2_no_of_buildings = -1 => 0.0786912506,
pk_add2_no_of_buildings = 0 => 0.0745059929,
pk_add2_no_of_buildings = 1 => 0.0514905149,
pk_add2_no_of_buildings = 2 => 0.0754716981,
0.0777258307
);


pk_add2_no_of_stories_mm := map(
pk_add2_no_of_stories = -1 => 0.0773337926,
pk_add2_no_of_stories = 0 => 0.0791457286,
pk_add2_no_of_stories = 1 => 0.0647058824,
0.0777258307
);


pk_add2_no_of_baths_mm := map(
pk_add2_no_of_baths = -3 => 0.077142206,
pk_add2_no_of_baths = -2 => 0.0760255928,
pk_add2_no_of_baths = -1 => 0.0779177719,
pk_add2_no_of_baths = 0 => 0.0958188153,
pk_add2_no_of_baths = 1 => 0.1089108911,
pk_add2_no_of_baths = 2 => 0.0892857143,
0.0777258307
);


pk_add2_garage_type_risk_lvl_mm := map(
pk_add2_garage_type_risk_lvl = 0 => 0.0911371237,
pk_add2_garage_type_risk_lvl = 1 => 0.1037037037,
pk_add2_garage_type_risk_lvl = 2 => 0.0556097561,
pk_add2_garage_type_risk_lvl = 3 => 0.0761481481,
0.0777258307
);


pk_add2_style_code_level_mm := map(
pk_add2_style_code_level = 0 => 0.0779824485,
pk_add2_style_code_level = 1 => 0.1133333333,
pk_add2_style_code_level = 2 => 0.0833333333,
pk_add2_style_code_level = 3 => 0.0526315789,
pk_add2_style_code_level = 4 => 0.0554216867,
0.0777258307
);


pk_yr_add2_built_date2_mm := map(
pk_yr_add2_built_date2 = -1 => 0.07614747,
pk_yr_add2_built_date2 = 0 => 0.0414507772,
pk_yr_add2_built_date2 = 1 => 0.108490566,
pk_yr_add2_built_date2 = 2 => 0.0804405409,
0.0777258307
);


pk_add2_purchase_amount2_mm := map(
pk_add2_purchase_amount2 = -1 => 0.0781079201,
pk_add2_purchase_amount2 = 0 => 0.0783378747,
pk_add2_purchase_amount2 = 1 => 0.0740897544,
0.0777258307
);


pk_add2_mortgage_amount2_mm := map(
pk_add2_mortgage_amount2 = -1 => 0.0771855452,
pk_add2_mortgage_amount2 = 0 => 0.078140455,
pk_add2_mortgage_amount2 = 1 => 0.0770565776,
pk_add2_mortgage_amount2 = 2 => 0.0943134535,
0.0777258307
);


pk_add2_mortgage_risk_mm := map(
pk_add2_mortgage_risk = -1 => 0.0687977762,
pk_add2_mortgage_risk = 0 => 0.0909090909,
pk_add2_mortgage_risk = 1 => 0.0774821922,
pk_add2_mortgage_risk = 2 => 0.0866935484,
pk_add2_mortgage_risk = 3 => 0.0852803738,
0.0777258307
);


pk_yr_add2_mortgage_due_date2_mm := map(
pk_yr_add2_mortgage_due_date2 = -1 => 0.0775049024,
pk_yr_add2_mortgage_due_date2 = 0 => 0.0773809524,
pk_yr_add2_mortgage_due_date2 = 1 => 0.0695067265,
pk_yr_add2_mortgage_due_date2 = 2 => 0.0794392523,
pk_yr_add2_mortgage_due_date2 = 3 => 0.0844827586,
0.0777258307
);


pk_add2_assessed_amount2_mm := map(
pk_add2_assessed_amount2 = -1 => 0.079890926,
pk_add2_assessed_amount2 = 0 => 0.0643028846,
pk_add2_assessed_amount2 = 1 => 0.0723247232,
pk_add2_assessed_amount2 = 2 => 0.0746003552,
pk_add2_assessed_amount2 = 3 => 0.0761326483,
pk_add2_assessed_amount2 = 4 => 0.075225677,
0.0777258307
);


pk_yr_add2_date_first_seen2_mm := map(
pk_yr_add2_date_first_seen2 = -1 => 0.078230375,
pk_yr_add2_date_first_seen2 = 0 => 0.0727124183,
pk_yr_add2_date_first_seen2 = 1 => 0.0626483151,
pk_yr_add2_date_first_seen2 = 2 => 0.0728801682,
pk_yr_add2_date_first_seen2 = 3 => 0.0727424749,
pk_yr_add2_date_first_seen2 = 4 => 0.07976299,
pk_yr_add2_date_first_seen2 = 5 => 0.0818619583,
pk_yr_add2_date_first_seen2 = 6 => 0.0698924731,
pk_yr_add2_date_first_seen2 = 7 => 0.0929577465,
pk_yr_add2_date_first_seen2 = 8 => 0.0856726212,
pk_yr_add2_date_first_seen2 = 9 => 0.0831398049,
pk_yr_add2_date_first_seen2 = 10 => 0.076980568,
pk_yr_add2_date_first_seen2 = 11 => 0.0818322182,
0.0777258307
);


pk_yr_add2_date_last_seen2_mm := map(
pk_yr_add2_date_last_seen2 = -1 => 0.078230375,
pk_yr_add2_date_last_seen2 = 0 => 0.0758265089,
pk_yr_add2_date_last_seen2 = 1 => 0.0753121998,
pk_yr_add2_date_last_seen2 = 2 => 0.0772163966,
pk_yr_add2_date_last_seen2 = 3 => 0.0853932584,
pk_yr_add2_date_last_seen2 = 4 => 0.0888468809,
pk_yr_add2_date_last_seen2 = 5 => 0.0885106383,
pk_yr_add2_date_last_seen2 = 6 => 0.0788732394,
0.0777258307
);


pk_yr_add3_built_date2_mm := map(
pk_yr_add3_built_date2 = -1 => 0.0780137773,
pk_yr_add3_built_date2 = 0 => 0.0909090909,
pk_yr_add3_built_date2 = 1 => 0.0855106888,
pk_yr_add3_built_date2 = 2 => 0.0877192982,
pk_yr_add3_built_date2 = 3 => 0.075206909,
0.0777258307
);


pk_add3_purchase_amount2_mm := map(
pk_add3_purchase_amount2 = -1 => 0.0776506925,
pk_add3_purchase_amount2 = 0 => 0.0742857143,
pk_add3_purchase_amount2 = 1 => 0.0668896321,
pk_add3_purchase_amount2 = 2 => 0.0580645161,
pk_add3_purchase_amount2 = 3 => 0.0820842256,
pk_add3_purchase_amount2 = 4 => 0.09375,
0.0777258307
);


pk_add3_mortgage_risk_mm := map(
pk_add3_mortgage_risk = -1 => 0.0869899923,
pk_add3_mortgage_risk = 0 => 0.0705596107,
pk_add3_mortgage_risk = 1 => 0.1428571429,
pk_add3_mortgage_risk = 2 => 0.0774398032,
pk_add3_mortgage_risk = 3 => 0.0767263427,
pk_add3_mortgage_risk = 4 => 0.0619469027,
pk_add3_mortgage_risk = 5 => 0.1052631579,
0.0777258307
);


pk_yr_add3_mortgage_due_date2_mm := map(
pk_yr_add3_mortgage_due_date2 = -1 => 0.0774799542,
pk_yr_add3_mortgage_due_date2 = 0 => 0.0858983536,
pk_yr_add3_mortgage_due_date2 = 1 => 0.0694822888,
0.0777258307
);


pk_add3_assessed_amount2_mm := map(
pk_add3_assessed_amount2 = -1 => 0.0800587787,
pk_add3_assessed_amount2 = 0 => 0.0579813887,
pk_add3_assessed_amount2 = 1 => 0.0716911765,
pk_add3_assessed_amount2 = 2 => 0.0693000693,
pk_add3_assessed_amount2 = 3 => 0.0777979982,
0.0777258307
);


pk_yr_add3_date_first_seen2_mm := map(
pk_yr_add3_date_first_seen2 = -1 => 0.0783289817,
pk_yr_add3_date_first_seen2 = 0 => 0.0566762728,
pk_yr_add3_date_first_seen2 = 1 => 0.0664977834,
pk_yr_add3_date_first_seen2 = 2 => 0.0766475645,
pk_yr_add3_date_first_seen2 = 3 => 0.0756802721,
pk_yr_add3_date_first_seen2 = 4 => 0.0777202073,
pk_yr_add3_date_first_seen2 = 5 => 0.0853384665,
pk_yr_add3_date_first_seen2 = 6 => 0.0776237624,
pk_yr_add3_date_first_seen2 = 7 => 0.0773993808,
pk_yr_add3_date_first_seen2 = 8 => 0.0837185413,
pk_yr_add3_date_first_seen2 = 9 => 0.0796774194,
0.0777258307
);


pk_yr_add3_date_last_seen2_mm := map(
pk_yr_add3_date_last_seen2 = -1 => 0.0783289817,
pk_yr_add3_date_last_seen2 = 0 => 0.0763316859,
pk_yr_add3_date_last_seen2 = 1 => 0.0710011966,
pk_yr_add3_date_last_seen2 = 2 => 0.0775669643,
pk_yr_add3_date_last_seen2 = 3 => 0.0778078484,
pk_yr_add3_date_last_seen2 = 4 => 0.0804243669,
pk_yr_add3_date_last_seen2 = 5 => 0.0957446809,
pk_yr_add3_date_last_seen2 = 6 => 0.0800990917,
pk_yr_add3_date_last_seen2 = 7 => 0.077092511,
pk_yr_add3_date_last_seen2 = 8 => 0.0815868263,
0.0777258307
);


pk_yr_attr_dt_last_purch2_mm := map(
pk_yr_attr_dt_last_purch2 = -1 => 0.0771932289,
pk_yr_attr_dt_last_purch2 = 0 => 0.082155477,
pk_yr_attr_dt_last_purch2 = 1 => 0.0591872792,
pk_yr_attr_dt_last_purch2 = 2 => 0.0741116751,
pk_yr_attr_dt_last_purch2 = 3 => 0.0856164384,
pk_yr_attr_dt_last_purch2 = 4 => 0.0942100098,
pk_yr_attr_dt_last_purch2 = 5 => 0.0765271105,
pk_yr_attr_dt_last_purch2 = 6 => 0.0829732066,
pk_yr_attr_dt_last_purch2 = 7 => 0.070754717,
0.0777258307
);


pk_yr_attr_date_last_sale2_mm := map(
pk_yr_attr_date_last_sale2 = -1 => 0.0773843667,
pk_yr_attr_date_last_sale2 = 0 => 0.0736318408,
pk_yr_attr_date_last_sale2 = 1 => 0.0714285714,
pk_yr_attr_date_last_sale2 = 2 => 0.073219659,
pk_yr_attr_date_last_sale2 = 3 => 0.0900649954,
pk_yr_attr_date_last_sale2 = 4 => 0.0810397554,
0.0777258307
);


pk_attr_num_watercraft24_mm := map(
pk_attr_num_watercraft24 = 0 => 0.0774288725,
pk_attr_num_watercraft24 = 1 => 0.1126126126,
pk_attr_num_watercraft24 = 2 => 0,
0.0777258307
);


pk_bk_level_mm := map(
pk_bk_level = 0 => 0.077494479,
pk_bk_level = 1 => 0.078263729,
pk_bk_level = 2 => 0.0807265388,
0.0777258307
);


pk_eviction_level_mm := map(
pk_eviction_level = 0 => 0.0786085385,
pk_eviction_level = 1 => 0.0725907384,
pk_eviction_level = 2 => 0.0623700624,
pk_eviction_level = 3 => 0.0436507937,
pk_eviction_level = 4 => 0.0666666667,
pk_eviction_level = 5 => 0.0714285714,
pk_eviction_level = 6 => 0.1176470588,
pk_eviction_level = 7 => 0.1052631579,
0.0777258307
);


pk_lien_type_level_mm := map(
pk_lien_type_level = 0 => 0.080886461,
pk_lien_type_level = 1 => 0.0540540541,
pk_lien_type_level = 2 => 0.0842639594,
pk_lien_type_level = 3 => 0.0707220574,
pk_lien_type_level = 4 => 0.0711430855,
pk_lien_type_level = 5 => 0.0666961131,
0.0777258307
);


pk_yr_ln_unrel_cj_f_sn2_mm := map(
pk_yr_ln_unrel_cj_f_sn2 = -1 => 0.0797858241,
pk_yr_ln_unrel_cj_f_sn2 = 0 => 0.084317032,
pk_yr_ln_unrel_cj_f_sn2 = 1 => 0.0652173913,
pk_yr_ln_unrel_cj_f_sn2 = 2 => 0.067688378,
pk_yr_ln_unrel_cj_f_sn2 = 3 => 0.068878357,
0.0777258307
);


pk_yr_ln_unrel_lt_f_sn2_mm := map(
pk_yr_ln_unrel_lt_f_sn2 = -1 => 0.0782103678,
pk_yr_ln_unrel_lt_f_sn2 = 0 => 0.0561797753,
pk_yr_ln_unrel_lt_f_sn2 = 1 => 0.0637898687,
0.0777258307
);


pk_yr_ln_unrel_ot_f_sn2_mm := map(
pk_yr_ln_unrel_ot_f_sn2 = -1 => 0.0782040378,
pk_yr_ln_unrel_ot_f_sn2 = 0 => 0.0616016427,
pk_yr_ln_unrel_ot_f_sn2 = 1 => 0.0869565217,
pk_yr_ln_unrel_ot_f_sn2 = 2 => 0.0722222222,
0.0777258307
);


pk_yr_ln_unrel_sc_f_sn2_mm := map(
pk_yr_ln_unrel_sc_f_sn2 = -1 => 0.0782287823,
pk_yr_ln_unrel_sc_f_sn2 = 0 => 0.0673076923,
pk_yr_ln_unrel_sc_f_sn2 = 1 => 0.0741935484,
0.0777258307
);


pk_yr_attr_dt_l_eviction2_mm := map(
pk_yr_attr_dt_l_eviction2 = -1 => 0.0786298522,
pk_yr_attr_dt_l_eviction2 = 0 => 0.0807017544,
pk_yr_attr_dt_l_eviction2 = 1 => 0.0438247012,
pk_yr_attr_dt_l_eviction2 = 2 => 0.0643564356,
pk_yr_attr_dt_l_eviction2 = 3 => 0.064516129,
pk_yr_attr_dt_l_eviction2 = 4 => 0.0454545455,
pk_yr_attr_dt_l_eviction2 = 5 => 0.0739299611,
0.0777258307
);


pk_yr_criminal_last_date2_mm := map(
pk_yr_criminal_last_date2 = -1 => 0.0775316456,
pk_yr_criminal_last_date2 = 0 => 0.0779569892,
pk_yr_criminal_last_date2 = 1 => 0.0941176471,
pk_yr_criminal_last_date2 = 2 => 0.0475059382,
pk_yr_criminal_last_date2 = 3 => 0.0754716981,
pk_yr_criminal_last_date2 = 4 => 0.0817875211,
0.0777258307
);


pk_crime_level_mm := map(
pk_crime_level = 0 => 0.077524162,
pk_crime_level = 1 => 0.0822593913,
pk_crime_level = 2 => 0.0630105018,
0.0777258307
);


pk_felony_recent_level_mm := map(
pk_felony_recent_level = 0 => 0.0778293919,
pk_felony_recent_level = 1 => 0.0551181102,
pk_felony_recent_level = 2 => 0.0925925926,
pk_felony_recent_level = 3 => 0.0677966102,
pk_felony_recent_level = 4 => 0.0833333333,
0.0777258307
);


pk_attr_total_number_derogs_mm := map(
pk_attr_total_number_derogs = 0 => 0.0802235739,
pk_attr_total_number_derogs = 1 => 0.0769042371,
pk_attr_total_number_derogs = 2 => 0.0823723229,
pk_attr_total_number_derogs = 3 => 0.0704678916,
0.0777258307
);


pk_yr_rc_ssnhighissue2_mm := map(
pk_yr_rc_ssnhighissue2 = -1 => 0.073460569,
pk_yr_rc_ssnhighissue2 = 1 => 0.0208333333,
pk_yr_rc_ssnhighissue2 = 2 => 0.0566371681,
pk_yr_rc_ssnhighissue2 = 3 => 0.0454545455,
pk_yr_rc_ssnhighissue2 = 4 => 0.0769230769,
pk_yr_rc_ssnhighissue2 = 5 => 0.0843450479,
pk_yr_rc_ssnhighissue2 = 6 => 0.082482028,
pk_yr_rc_ssnhighissue2 = 7 => 0.0766161213,
pk_yr_rc_ssnhighissue2 = 8 => 0.0864600326,
pk_yr_rc_ssnhighissue2 = 9 => 0.0727831881,
pk_yr_rc_ssnhighissue2 = 10 => 0.0660240964,
pk_yr_rc_ssnhighissue2 = 11 => 0.0749642346,
pk_yr_rc_ssnhighissue2 = 12 => 0.0758547009,
pk_yr_rc_ssnhighissue2 = 13 => 0.0898491084,
pk_yr_rc_ssnhighissue2 = 14 => 0.0872878421,
0.0777258307
);


pk_PL_Sourced_Level_mm := map(
pk_PL_Sourced_Level = 0 => 0.0768485915,
pk_PL_Sourced_Level = 1 => 0.0625,
pk_PL_Sourced_Level = 2 => 0.0943193998,
pk_PL_Sourced_Level = 3 => 0.1031390135,
0.0777258307
);


pk_prof_lic_cat_mm := map(
pk_prof_lic_cat = -1 => 0.0768016833,
pk_prof_lic_cat = 0 => 0.0917225951,
pk_prof_lic_cat = 1 => 0.0945121951,
pk_prof_lic_cat = 2 => 0.0955414013,
pk_prof_lic_cat = 3 => 0.1454545455,
0.0777258307
);


pk_add1_lres_mm := map(
pk_add1_lres = -2 => 0,
pk_add1_lres = -1 => 0.0698625046,
pk_add1_lres = 0 => 0.1166666667,
pk_add1_lres = 1 => 0.1,
pk_add1_lres = 2 => 0.0928571429,
pk_add1_lres = 3 => 0.1304347826,
pk_add1_lres = 4 => 0.0782674772,
pk_add1_lres = 5 => 0.0972222222,
pk_add1_lres = 6 => 0.0845464726,
pk_add1_lres = 7 => 0.0799824214,
pk_add1_lres = 8 => 0.078387458,
pk_add1_lres = 9 => 0.0693612774,
pk_add1_lres = 10 => 0.0760150241,
pk_add1_lres = 11 => 0.071547421,
0.0777258307
);


pk_add2_lres_mm := map(
pk_add2_lres = -2 => 0.0791424034,
pk_add2_lres = -1 => 0.0789074355,
pk_add2_lres = 0 => 0.0733452594,
pk_add2_lres = 1 => 0.0715096481,
pk_add2_lres = 2 => 0.0754979157,
pk_add2_lres = 3 => 0.0764818356,
pk_add2_lres = 4 => 0.0793465578,
pk_add2_lres = 5 => 0.0676982592,
pk_add2_lres = 6 => 0.0732623669,
pk_add2_lres = 7 => 0.0814529444,
pk_add2_lres = 8 => 0.0868635002,
pk_add2_lres = 9 => 0.0862998921,
pk_add2_lres = 10 => 0.0555555556,
0.0777258307
);


pk_add3_lres_mm := map(
pk_add3_lres = -2 => 0.0770770771,
pk_add3_lres = -1 => 0.077021549,
pk_add3_lres = 0 => 0.0751024972,
pk_add3_lres = 1 => 0.0877963126,
pk_add3_lres = 2 => 0.0786627335,
pk_add3_lres = 3 => 0.074789916,
pk_add3_lres = 4 => 0.0770042194,
pk_add3_lres = 5 => 0.0808777429,
pk_add3_lres = 6 => 0.0718424102,
0.0777258307
);


pk_lres_flag_level_mm := map(
pk_lres_flag_level = 0 => 0.0698365527,
pk_lres_flag_level = 1 => 0.0890248046,
pk_lres_flag_level = 2 => 0.0770700289,
0.0777258307
);


pk_avg_lres_mm := map(
pk_avg_lres = -1 => 0.0674157303,
pk_avg_lres = 0 => 0.1379310345,
pk_avg_lres = 1 => 0.0813953488,
pk_avg_lres = 2 => 0.0838926174,
pk_avg_lres = 3 => 0.0612244898,
pk_avg_lres = 4 => 0.0709939148,
pk_avg_lres = 5 => 0.0943952802,
pk_avg_lres = 6 => 0.0813397129,
pk_avg_lres = 7 => 0.0729455217,
pk_avg_lres = 8 => 0.0820259973,
pk_avg_lres = 9 => 0.0818330606,
pk_avg_lres = 10 => 0.0821052632,
pk_avg_lres = 11 => 0.0753860127,
pk_avg_lres = 12 => 0.0839107005,
pk_avg_lres = 13 => 0.071213263,
pk_avg_lres = 14 => 0.0806542583,
pk_avg_lres = 15 => 0.0775577558,
0.0777258307
);


pk_addrs_5yr_mm := map(
pk_addrs_5yr = 0 => 0.0784476497,
pk_addrs_5yr = 1 => 0.0803342618,
pk_addrs_5yr = 2 => 0.0753125909,
pk_addrs_5yr = 3 => 0.0666161998,
pk_addrs_5yr = 4 => 0.0650684932,
0.0777258307
);


pk_addrs_10yr_mm := map(
pk_addrs_10yr = 0 => 0.075259699,
pk_addrs_10yr = 1 => 0.0822490706,
pk_addrs_10yr = 2 => 0.0779892973,
pk_addrs_10yr = 3 => 0.080134357,
pk_addrs_10yr = 4 => 0.0668044077,
0.0777258307
);


pk_add_lres_year_avg2_mm := map(
pk_add_lres_year_avg2 = -1 => 0.0666666667,
pk_add_lres_year_avg2 = 0 => 0.0758928571,
pk_add_lres_year_avg2 = 1 => 0.0910179641,
pk_add_lres_year_avg2 = 2 => 0.0699619772,
pk_add_lres_year_avg2 = 3 => 0.0729927007,
pk_add_lres_year_avg2 = 4 => 0.0684848485,
pk_add_lres_year_avg2 = 5 => 0.0832313341,
pk_add_lres_year_avg2 = 6 => 0.0762331839,
pk_add_lres_year_avg2 = 7 => 0.09437751,
pk_add_lres_year_avg2 = 8 => 0.0773405699,
pk_add_lres_year_avg2 = 9 => 0.0678200692,
pk_add_lres_year_avg2 = 10 => 0.0741029641,
pk_add_lres_year_avg2 = 11 => 0.0878136201,
pk_add_lres_year_avg2 = 12 => 0.0696266398,
pk_add_lres_year_avg2 = 13 => 0.0679156909,
pk_add_lres_year_avg2 = 14 => 0.1053333333,
pk_add_lres_year_avg2 = 15 => 0.0726172466,
pk_add_lres_year_avg2 = 16 => 0.0800395257,
pk_add_lres_year_avg2 = 17 => 0.0789877301,
pk_add_lres_year_avg2 = 18 => 0.1,
pk_add_lres_year_avg2 = 19 => 0.0843373494,
0.0777258307
);


pk_add_lres_year_max2_mm := map(
pk_add_lres_year_max2 = -1 => 0.0666666667,
pk_add_lres_year_max2 = 0 => 0.0985915493,
pk_add_lres_year_max2 = 1 => 0.0964187328,
pk_add_lres_year_max2 = 2 => 0.0873440285,
pk_add_lres_year_max2 = 3 => 0.0844444444,
pk_add_lres_year_max2 = 4 => 0.0716723549,
pk_add_lres_year_max2 = 5 => 0.0743761996,
pk_add_lres_year_max2 = 6 => 0.0708571429,
pk_add_lres_year_max2 = 7 => 0.0687361419,
pk_add_lres_year_max2 = 8 => 0.0728476821,
pk_add_lres_year_max2 = 9 => 0.0789074355,
pk_add_lres_year_max2 = 10 => 0.08139926,
pk_add_lres_year_max2 = 11 => 0.0808259587,
pk_add_lres_year_max2 = 12 => 0.0853503185,
pk_add_lres_year_max2 = 13 => 0.0644122383,
pk_add_lres_year_max2 = 14 => 0.0558375635,
pk_add_lres_year_max2 = 15 => 0.0641361257,
pk_add_lres_year_max2 = 16 => 0.0864453665,
pk_add_lres_year_max2 = 17 => 0.0794183445,
pk_add_lres_year_max2 = 18 => 0.1300813008,
0.0777258307
);


pk_nameperssn_count_mm := map(
pk_nameperssn_count = 0 => 0.0769986163,
pk_nameperssn_count = 1 => 0.0882352941,
pk_nameperssn_count = 2 => 0.0877192982,
0.0777258307
);


pk_ssns_per_adl_mm := map(
pk_ssns_per_adl = -1 => 0.0761516766,
pk_ssns_per_adl = 0 => 0.077603997,
pk_ssns_per_adl = 1 => 0.0830134357,
pk_ssns_per_adl = 2 => 0.0550847458,
pk_ssns_per_adl = 3 => 0.1052631579,
pk_ssns_per_adl = 4 => 0.1666666667,
0.0777258307
);


pk_addrs_per_adl_mm := map(
pk_addrs_per_adl = -6 => 0.0621387283,
pk_addrs_per_adl = -5 => 0.0936626281,
pk_addrs_per_adl = -4 => 0.08081571,
pk_addrs_per_adl = -3 => 0.0738125802,
pk_addrs_per_adl = -2 => 0.0792870313,
pk_addrs_per_adl = -1 => 0.0702151755,
pk_addrs_per_adl = 0 => 0.0793884485,
pk_addrs_per_adl = 1 => 0.0817810086,
pk_addrs_per_adl = 2 => 0.0726256983,
pk_addrs_per_adl = 3 => 0.0714285714,
0.0777258307
);


pk_phones_per_adl_mm := map(
pk_phones_per_adl = -1 => 0.0706104031,
pk_phones_per_adl = 0 => 0.1155378486,
pk_phones_per_adl = 1 => 0.1093117409,
pk_phones_per_adl = 2 => 0.1785714286,
0.0777258307
);


pk_addrs_per_ssn_mm := map(
pk_addrs_per_ssn = -4 => 0.0759673411,
pk_addrs_per_ssn = -3 => 0.078700361,
pk_addrs_per_ssn = -2 => 0.0806288032,
pk_addrs_per_ssn = -1 => 0.0773109244,
pk_addrs_per_ssn = 0 => 0.0752757949,
pk_addrs_per_ssn = 1 => 0.0748858447,
pk_addrs_per_ssn = 2 => 0.0762376238,
pk_addrs_per_ssn = 3 => 0.0858505564,
0.0777258307
);


pk_adls_per_addr_mm := map(
pk_adls_per_addr = -102 => 0.0801921656,
pk_adls_per_addr = -101 => 0.0769230769,
pk_adls_per_addr = -2 => 0.1328671329,
pk_adls_per_addr = -1 => 0.078358209,
pk_adls_per_addr = 0 => 0.0699300699,
pk_adls_per_addr = 1 => 0.073664825,
pk_adls_per_addr = 2 => 0.0907079646,
pk_adls_per_addr = 3 => 0.0807498198,
pk_adls_per_addr = 4 => 0.074682599,
pk_adls_per_addr = 5 => 0.0854765507,
pk_adls_per_addr = 6 => 0.0770491803,
pk_adls_per_addr = 7 => 0.0816852966,
pk_adls_per_addr = 8 => 0.0760180995,
pk_adls_per_addr = 9 => 0.0767494357,
pk_adls_per_addr = 10 => 0.0773067332,
pk_adls_per_addr = 11 => 0.0760938491,
pk_adls_per_addr = 12 => 0.0783435926,
pk_adls_per_addr = 13 => 0.0631229236,
pk_adls_per_addr = 100 => 0.0590551181,
pk_adls_per_addr = 101 => 0.0987654321,
pk_adls_per_addr = 102 => 0.0761356366,
0.0777258307
);


pk_phones_per_addr_mm := map(
pk_phones_per_addr = -1 => 0.0580483467,
pk_phones_per_addr = 0 => 0.117040521,
pk_phones_per_addr = 1 => 0.0991325898,
pk_phones_per_addr = 2 => 0.119047619,
pk_phones_per_addr = 3 => 0.0909090909,
pk_phones_per_addr = 100 => 0.0517751479,
pk_phones_per_addr = 101 => 0.0937950938,
pk_phones_per_addr = 102 => 0.0656108597,
pk_phones_per_addr = 103 => 0.082149475,
0.0777258307
);


pk_adls_per_phone_mm := map(
pk_adls_per_phone = -2 => 0.0522393162,
pk_adls_per_phone = -1 => 0.1165535957,
pk_adls_per_phone = 0 => 0.1237054085,
pk_adls_per_phone = 1 => 0.1076233184,
0.0777258307
);


pk_addrs_per_adl_c6_mm := map(
pk_addrs_per_adl_c6 = 0 => 0.0776263814,
pk_addrs_per_adl_c6 = 1 => 0.0803981623,
pk_addrs_per_adl_c6 = 2 => 0.0824742268,
pk_addrs_per_adl_c6 = 3 => 0,
0.0777258307
);


pk_phones_per_adl_c6_mm := map(
pk_phones_per_adl_c6 = -2 => 0.0768095158,
pk_phones_per_adl_c6 = -1 => 0.1666666667,
pk_phones_per_adl_c6 = 0 => 0.1428571429,
pk_phones_per_adl_c6 = 1 => 0,
0.0777258307
);


pk_adls_per_addr_c6_mm := map(
pk_adls_per_addr_c6 = 0 => 0.0787130841,
pk_adls_per_addr_c6 = 1 => 0.0675349735,
pk_adls_per_addr_c6 = 2 => 0.0900692841,
pk_adls_per_addr_c6 = 3 => 0.06,
pk_adls_per_addr_c6 = 4 => 0,
pk_adls_per_addr_c6 = 100 => 0.0795430506,
pk_adls_per_addr_c6 = 101 => 0.0616883117,
pk_adls_per_addr_c6 = 102 => 0,
0.0777258307
);


pk_ssns_per_addr_c6_mm := map(
pk_ssns_per_addr_c6 = 0 => 0.0788028721,
pk_ssns_per_addr_c6 = 1 => 0.065337763,
pk_ssns_per_addr_c6 = 2 => 0.0904761905,
pk_ssns_per_addr_c6 = 3 => 0.0519480519,
pk_ssns_per_addr_c6 = 4 => 0.0588235294,
pk_ssns_per_addr_c6 = 5 => 0,
pk_ssns_per_addr_c6 = 6 => 0,
pk_ssns_per_addr_c6 = 100 => 0.0791684166,
pk_ssns_per_addr_c6 = 101 => 0.0681818182,
pk_ssns_per_addr_c6 = 102 => 0.0576923077,
pk_ssns_per_addr_c6 = 103 => 0,
pk_ssns_per_addr_c6 = 104 => 0,
0.0777258307
);


pk_phones_per_addr_c6_mm := map(
pk_phones_per_addr_c6 = -1 => 0.0742090442,
pk_phones_per_addr_c6 = 0 => 0.1544715447,
pk_phones_per_addr_c6 = 1 => 0.1739130435,
pk_phones_per_addr_c6 = 2 => 0.0833333333,
pk_phones_per_addr_c6 = 100 => 0.0811584978,
pk_phones_per_addr_c6 = 101 => 0.0670903955,
pk_phones_per_addr_c6 = 102 => 0.0916496945,
0.0777258307
);


pk_adls_per_phone_c6_mm := map(
pk_adls_per_phone_c6 = 0 => 0.0734684582,
pk_adls_per_phone_c6 = 1 => 0.1234772979,
pk_adls_per_phone_c6 = 2 => 0.1333333333,
0.0777258307
);


pk_attr_addrs_last30_mm := map(
pk_attr_addrs_last30 = 0 => 0.0776284386,
pk_attr_addrs_last30 = 1 => 0.115942029,
pk_attr_addrs_last30 = 2 => 0,
0.0777258307
);


pk_attr_addrs_last36_mm := map(
pk_attr_addrs_last36 = 0 => 0.0808708012,
pk_attr_addrs_last36 = 1 => 0.0754615522,
pk_attr_addrs_last36 = 2 => 0.0690866511,
pk_attr_addrs_last36 = 3 => 0.0771604938,
pk_attr_addrs_last36 = 4 => 0.0743670886,
pk_attr_addrs_last36 = 5 => 0.0597014925,
pk_attr_addrs_last36 = 6 => 0.0793650794,
0.0777258307
);


pk_attr_addrs_last_level_mm := map(
pk_attr_addrs_last_level = 0 => 0.0808708012,
pk_attr_addrs_last_level = 1 => 0.0738427627,
pk_attr_addrs_last_level = 2 => 0.0683943361,
pk_attr_addrs_last_level = 3 => 0.0742534302,
pk_attr_addrs_last_level = 4 => 0.119760479,
pk_attr_addrs_last_level = 5 => 0.1095890411,
0.0777258307
);


pk_ams_class_level_mm := map(
pk_ams_class_level = -1000001 => 0.0779289457,
pk_ams_class_level = 0 => 0.05,
pk_ams_class_level = 1 => 0.0857142857,
pk_ams_class_level = 2 => 0.0285714286,
pk_ams_class_level = 3 => 0.1358024691,
pk_ams_class_level = 4 => 0.0826446281,
pk_ams_class_level = 5 => 0.074906367,
pk_ams_class_level = 6 => 0.0619195046,
pk_ams_class_level = 7 => 0.068119891,
pk_ams_class_level = 8 => 0.0896551724,
pk_ams_class_level = 1000000 => 0.0445859873,
pk_ams_class_level = 1000001 => 0.0491803279,
pk_ams_class_level = 1000002 => 0.0916030534,
pk_ams_class_level = 1000003 => 0.0952380952,
pk_ams_class_level = 1000004 => 0.0543478261,
pk_ams_class_level = 1000005 => 0.0677966102,
0.0777258307
);


pk_ams_income_level_code_mm := map(
pk_ams_income_level_code = -1 => 0.0779289457,
pk_ams_income_level_code = 0 => 0.0728476821,
pk_ams_income_level_code = 1 => 0.0651685393,
pk_ams_income_level_code = 2 => 0.0655200655,
pk_ams_income_level_code = 3 => 0.0778588808,
pk_ams_income_level_code = 4 => 0.0880149813,
pk_ams_income_level_code = 5 => 0.1066666667,
pk_ams_income_level_code = 6 => 0.1071428571,
0.0777258307
);


pk_ams_college_tier_mm := map(
pk_ams_college_tier = -1 => 0.0777233782,
pk_ams_college_tier = 0 => 0.0344827586,
pk_ams_college_tier = 1 => 0.0833333333,
pk_ams_college_tier = 2 => 0.0377358491,
pk_ams_college_tier = 3 => 0.0585585586,
pk_ams_college_tier = 4 => 0.100286533,
pk_ams_college_tier = 5 => 0.0778210117,
pk_ams_college_tier = 6 => 0.0759493671,
0.0777258307
);


pk_yr_rc_correct_dob2_mm := map(
pk_yr_rc_correct_dob2 = -1 => 0.0775636348,
pk_yr_rc_correct_dob2 = 21 => 0,
pk_yr_rc_correct_dob2 = 33 => 0.0606060606,
pk_yr_rc_correct_dob2 = 61 => 0.074168798,
pk_yr_rc_correct_dob2 = 99 => 0.1374045802,
0.0777258307
);


pk_ams_age_mm := map(
pk_ams_age = -1 => 0.0775718258,
pk_ams_age = 21 => 0.0972222222,
pk_ams_age = 22 => 0.0891089109,
pk_ams_age = 23 => 0.0756302521,
pk_ams_age = 24 => 0.0520833333,
pk_ams_age = 25 => 0.0952380952,
pk_ams_age = 29 => 0.0668257757,
pk_ams_age = 99 => 0.0793269231,
0.0777258307
);


pk_inferred_age_mm := map(
pk_inferred_age = -1 => 0.0627431907,
pk_inferred_age = 18 => 0.1160714286,
pk_inferred_age = 19 => 0.109375,
pk_inferred_age = 20 => 0.1111111111,
pk_inferred_age = 21 => 0.101369863,
pk_inferred_age = 22 => 0.0642857143,
pk_inferred_age = 24 => 0.0785876993,
pk_inferred_age = 34 => 0.0782344699,
pk_inferred_age = 37 => 0.0778625954,
pk_inferred_age = 41 => 0.0814249364,
pk_inferred_age = 42 => 0.0785854617,
pk_inferred_age = 43 => 0.0715746421,
pk_inferred_age = 44 => 0.0803212851,
pk_inferred_age = 46 => 0.07371484,
pk_inferred_age = 48 => 0.0597426471,
pk_inferred_age = 52 => 0.0726495726,
pk_inferred_age = 56 => 0.0765983112,
pk_inferred_age = 61 => 0.082149475,
pk_inferred_age = 99 => 0.0833874108,
0.0777258307
);


pk_add2_avm_auto_diff4_lvl_mm := map(
pk_add2_avm_auto_diff4_lvl = -1 => 0.0772802653,
pk_add2_avm_auto_diff4_lvl = 0 => 0.0793459552,
pk_add2_avm_auto_diff4_lvl = 1 => 0.0535714286,
0.0777258307
);


pk2_add1_avm_sp_mm := map(
pk2_add1_avm_sp = 0 => 0.0770368805,
pk2_add1_avm_sp = 1 => 0.0752279635,
pk2_add1_avm_sp = 2 => 0.0808917197,
pk2_add1_avm_sp = 3 => 0.0830223881,
0.0777258307
);


pk2_add1_avm_ta_mm := map(
pk2_add1_avm_ta = 0 => 0.0580075662,
pk2_add1_avm_ta = 1 => 0.07602167,
pk2_add1_avm_ta = 2 => 0.078343949,
pk2_add1_avm_ta = 3 => 0.0867437722,
pk2_add1_avm_ta = 4 => 0.1043478261,
0.0777258307
);


pk2_add1_avm_pi_mm := map(
pk2_add1_avm_pi = 0 => 0.0404040404,
pk2_add1_avm_pi = 1 => 0.0661125803,
pk2_add1_avm_pi = 2 => 0.0785989784,
pk2_add1_avm_pi = 3 => 0.0888311688,
0.0777258307
);


pk2_ADD1_AVM_MED_mm := map(
pk2_ADD1_AVM_MED = 0 => 0.0526315789,
pk2_ADD1_AVM_MED = 1 => 0.0729442971,
pk2_ADD1_AVM_MED = 2 => 0.0642347343,
pk2_ADD1_AVM_MED = 3 => 0.0753532182,
pk2_ADD1_AVM_MED = 4 => 0.0700828937,
pk2_ADD1_AVM_MED = 5 => 0.0852365026,
pk2_ADD1_AVM_MED = 6 => 0.0833333333,
pk2_ADD1_AVM_MED = 7 => 0.0745113219,
0.0777258307
);


pk2_add1_avm_to_med_ratio_mm := map(
pk2_add1_avm_to_med_ratio = 0 => 0.0756869171,
pk2_add1_avm_to_med_ratio = 1 => 0.0822559073,
pk2_add1_avm_to_med_ratio = 2 => 0.0827338129,
pk2_add1_avm_to_med_ratio = 3 => 0.0762829404,
pk2_add1_avm_to_med_ratio = 4 => 0.0949494949,
pk2_add1_avm_to_med_ratio = 5 => 0.0777576854,
0.0777258307
);


pk2_yr_add1_avm_rec_dt_mm := map(
pk2_yr_add1_avm_rec_dt = 0 => 0.0611551529,
pk2_yr_add1_avm_rec_dt = 1 => 0.0671834625,
pk2_yr_add1_avm_rec_dt = 2 => 0.0776045562,
pk2_yr_add1_avm_rec_dt = 3 => 0.0752890562,
pk2_yr_add1_avm_rec_dt = 4 => 0.0965909091,
0.0777258307
);


pk2_yr_add1_avm_assess_year_mm := map(
pk2_yr_add1_avm_assess_year = 0 => 0.0764305453,
pk2_yr_add1_avm_assess_year = 1 => 0.0748502994,
pk2_yr_add1_avm_assess_year = 2 => 0.0806886805,
0.0777258307
);


pk_dist_a1toa3_mm := map(
pk_dist_a1toa3 = 0 => 0.0731107206,
pk_dist_a1toa3 = 1 => 0.0728221416,
pk_dist_a1toa3 = 2 => 0.0803556726,
pk_dist_a1toa3 = 3 => 0.0876418663,
pk_dist_a1toa3 = 4 => 0.0953608247,
pk_dist_a1toa3 = 5 => 0.0850111857,
pk_dist_a1toa3 = 6 => 0.0775723473,
0.0777258307
);


pk_rc_disthphoneaddr_mm := map(
pk_rc_disthphoneaddr = 0 => 0.155379257,
pk_rc_disthphoneaddr = 1 => 0.0857794243,
pk_rc_disthphoneaddr = 2 => 0.0699404762,
pk_rc_disthphoneaddr = 3 => 0.0706886045,
pk_rc_disthphoneaddr = 4 => 0.0458892488,
0.0777258307
);


pk_out_st_division_lvl_mm := map(
pk_out_st_division_lvl = -1 => 0.1294117647,
pk_out_st_division_lvl = 0 => 0.0683192261,
pk_out_st_division_lvl = 1 => 0.0719339623,
pk_out_st_division_lvl = 2 => 0.0863234529,
pk_out_st_division_lvl = 3 => 0.0625424881,
pk_out_st_division_lvl = 4 => 0.0729808041,
pk_out_st_division_lvl = 5 => 0.082421875,
pk_out_st_division_lvl = 6 => 0.1016843419,
pk_out_st_division_lvl = 7 => 0.0738337967,
pk_out_st_division_lvl = 8 => 0.0629139073,
0.0777258307
);


pk_impulse_count_mm := map(
pk_impulse_count = 0 => 0.0775370092,
pk_impulse_count = 1 => 0.0833333333,
pk_impulse_count = 2 => 0.0900900901,
0.0777258307
);


pk_derog_total_mm := map(
pk_derog_total = -4 => 0.1509433962,
pk_derog_total = -3 => 0.0930470348,
pk_derog_total = -2 => 0.0848495767,
pk_derog_total = -1 => 0.0998043053,
pk_derog_total = 0 => 0.0480510753,
pk_derog_total = 1 => 0.0769042371,
pk_derog_total = 2 => 0.0823723229,
pk_derog_total = 3 => 0.0704678916,
0.0777258307
);


pk_attr_num_nonderogs90_b_mm := map(
pk_attr_num_nonderogs90_b = 0 => 0.0535917902,
pk_attr_num_nonderogs90_b = 1 => 0.0961281709,
pk_attr_num_nonderogs90_b = 2 => 0.063470628,
pk_attr_num_nonderogs90_b = 3 => 0.073253833,
pk_attr_num_nonderogs90_b = 4 => 0.164556962,
pk_attr_num_nonderogs90_b = 10 => 0.0399429387,
pk_attr_num_nonderogs90_b = 11 => 0.0825091098,
pk_attr_num_nonderogs90_b = 12 => 0.0815409617,
pk_attr_num_nonderogs90_b = 13 => 0.1043203372,
pk_attr_num_nonderogs90_b = 14 => 0.1261261261,
0.0777258307
);


pk_add1_unit_count2_mm := map(
pk_add1_unit_count2 = 0 => 0.0776270457,
pk_add1_unit_count2 = 1 => 0.0758928571,
pk_add1_unit_count2 = 2 => 0.09375,
pk_add1_unit_count2 = 3 => 0.0774165954,
0.0777258307
);


pk_ssns_per_addr2_mm := map(
pk_ssns_per_addr2 = -101 => 0.0797684143,
pk_ssns_per_addr2 = -2 => 0.1288343558,
pk_ssns_per_addr2 = -1 => 0.0540540541,
pk_ssns_per_addr2 = 0 => 0.0716889429,
pk_ssns_per_addr2 = 1 => 0.0750721848,
pk_ssns_per_addr2 = 2 => 0.0911196911,
pk_ssns_per_addr2 = 3 => 0.0757097792,
pk_ssns_per_addr2 = 4 => 0.0874904068,
pk_ssns_per_addr2 = 5 => 0.0760425184,
pk_ssns_per_addr2 = 6 => 0.0775716695,
pk_ssns_per_addr2 = 7 => 0.0811287478,
pk_ssns_per_addr2 = 8 => 0.0784412955,
pk_ssns_per_addr2 = 9 => 0.0818598559,
pk_ssns_per_addr2 = 10 => 0.0728744939,
pk_ssns_per_addr2 = 11 => 0.0766145207,
pk_ssns_per_addr2 = 12 => 0.0624580255,
pk_ssns_per_addr2 = 100 => 0.0671936759,
pk_ssns_per_addr2 = 101 => 0.0985915493,
pk_ssns_per_addr2 = 102 => 0.0768442623,
pk_ssns_per_addr2 = 103 => 0.072056239,
0.0777258307
);


pk_yr_add1_assess_val_yr2_mm := map(
pk_yr_add1_assess_val_yr2 = -1 => 0.0750511048,
pk_yr_add1_assess_val_yr2 = 0 => 0.0798137145,
pk_yr_add1_assess_val_yr2 = 1 => 0.0768348624,
pk_yr_add1_assess_val_yr2 = 2 => 0.0840336134,
0.0777258307
);


pk_prop_owned_assess_count_mm := map(
pk_prop_owned_assess_count = 0 => 0.079094727,
pk_prop_owned_assess_count = 1 => 0.0755475186,
pk_prop_owned_assess_count = 2 => 0.0737704918,
pk_prop_owned_assess_count = 3 => 0.0540540541,
pk_prop_owned_assess_count = 4 => 0.0816326531,
0.0777258307
);


pk_yr_prop1_prev_purch_dt2_mm := map(
pk_yr_prop1_prev_purch_dt2 = -1 => 0.0780375209,
pk_yr_prop1_prev_purch_dt2 = 0 => 0.0671875,
pk_yr_prop1_prev_purch_dt2 = 1 => 0.0881057269,
pk_yr_prop1_prev_purch_dt2 = 2 => 0.0629370629,
pk_yr_prop1_prev_purch_dt2 = 3 => 0.0786885246,
pk_yr_prop1_prev_purch_dt2 = 4 => 0.074137931,
pk_yr_prop1_prev_purch_dt2 = 5 => 0.0792838875,
pk_yr_prop1_prev_purch_dt2 = 6 => 0.0777537797,
pk_yr_prop1_prev_purch_dt2 = 7 => 0.0826210826,
0.0777258307
);


pk_yr_prop2_prev_purch_dt2_mm := map(
pk_yr_prop2_prev_purch_dt2 = -1 => 0.0774930265,
pk_yr_prop2_prev_purch_dt2 = 0 => 0.0821917808,
pk_yr_prop2_prev_purch_dt2 = 1 => 0.0841121495,
0.0777258307
);


pk_yr_add2_assess_val_yr2_mm := map(
pk_yr_add2_assess_val_yr2 = -1 => 0.0764801035,
pk_yr_add2_assess_val_yr2 = 1 => 0.0873015873,
pk_yr_add2_assess_val_yr2 = 2 => 0.0790070733,
0.0777258307
);


pk_c_bargains_mm := map(
pk_c_bargains = -9 => 0.093877551,
pk_c_bargains = 0 => 0.0839058617,
pk_c_bargains = 1 => 0.0789146645,
pk_c_bargains = 2 => 0.0737207285,
pk_c_bargains = 3 => 0.0733768023,
0.0777258307
);


pk_c_bel_edu_mm := map(
pk_c_bel_edu = -9 => 0.093877551,
pk_c_bel_edu = 0 => 0.0872410033,
pk_c_bel_edu = 1 => 0.0924690181,
pk_c_bel_edu = 2 => 0.0987654321,
pk_c_bel_edu = 3 => 0.0757575758,
pk_c_bel_edu = 4 => 0.0957722174,
pk_c_bel_edu = 5 => 0.0789695946,
pk_c_bel_edu = 6 => 0.0774327122,
pk_c_bel_edu = 7 => 0.0695708713,
pk_c_bel_edu = 8 => 0.0707711838,
0.0777258307
);


pk_c_lowrent_mm := map(
pk_c_lowrent = -9 => 0.093877551,
pk_c_lowrent = 0 => 0.0905469033,
pk_c_lowrent = 1 => 0.0837104072,
pk_c_lowrent = 2 => 0.0860740462,
pk_c_lowrent = 3 => 0.0808793868,
pk_c_lowrent = 4 => 0.0699631773,
pk_c_lowrent = 5 => 0.0664384627,
0.0777258307
);


pk_c_med_hval_mm := map(
pk_c_med_hval = -9 => 0.093877551,
pk_c_med_hval = 0 => 0.069505442,
pk_c_med_hval = 1 => 0.0653710247,
pk_c_med_hval = 2 => 0.0786655684,
pk_c_med_hval = 3 => 0.0837651123,
pk_c_med_hval = 4 => 0.0829668719,
pk_c_med_hval = 5 => 0.0811170213,
pk_c_med_hval = 6 => 0.0803484995,
pk_c_med_hval = 7 => 0.1016949153,
pk_c_med_hval = 8 => 0.0869149952,
pk_c_med_hval = 9 => 0.1076142132,
0.0777258307
);


pk_rel_count_mm := map(
pk_rel_count = -9 => 0.065560166,
pk_rel_count = -3 => 0.0705550329,
pk_rel_count = -2 => 0.0803858521,
pk_rel_count = -1 => 0.085620915,
pk_rel_count = 0 => 0.0847936687,
pk_rel_count = 1 => 0.0862445415,
pk_rel_count = 2 => 0.074556213,
pk_rel_count = 3 => 0.0723233278,
pk_rel_count = 4 => 0.0834996673,
pk_rel_count = 5 => 0.0765794512,
pk_rel_count = 6 => 0.0815828041,
0.0777258307
);


pk_rel_bankrupt_count_mm := map(
pk_rel_bankrupt_count = -9 => 0.065560166,
pk_rel_bankrupt_count = 0 => 0.0779879531,
pk_rel_bankrupt_count = 1 => 0.079109521,
pk_rel_bankrupt_count = 2 => 0.0793230016,
pk_rel_bankrupt_count = 3 => 0.0848806366,
pk_rel_bankrupt_count = 4 => 0.072243346,
0.0777258307
);


pk_rel_felony_count_mm := map(
pk_rel_felony_count = -9 => 0.065560166,
pk_rel_felony_count = 0 => 0.0801816335,
pk_rel_felony_count = 1 => 0.0736274199,
pk_rel_felony_count = 2 => 0.067357513,
pk_rel_felony_count = 3 => 0.0994623656,
pk_rel_felony_count = 4 => 0.0872274143,
0.0777258307
);


pk_crim_rel_within100miles_mm := map(
pk_crim_rel_within100miles = -9 => 0.065560166,
pk_crim_rel_within100miles = 0 => 0.0790722193,
pk_crim_rel_within100miles = 1 => 0.0792520036,
pk_crim_rel_within100miles = 2 => 0.0787878788,
0.0777258307
);


pk_crim_rel_withinOther_mm := map(
pk_crim_rel_withinOther = -9 => 0.065560166,
pk_crim_rel_withinOther = 0 => 0.0789151356,
pk_crim_rel_withinOther = 1 => 0.0735887097,
pk_crim_rel_withinOther = 2 => 0.0928217822,
pk_crim_rel_withinOther = 3 => 0.0923824959,
0.0777258307
);


pk_rel_prop_owned_count_mm := map(
pk_rel_prop_owned_count = -9 => 0.065560166,
pk_rel_prop_owned_count = -3 => 0.0806882231,
pk_rel_prop_owned_count = -2 => 0.0753263092,
pk_rel_prop_owned_count = -1 => 0.0802886784,
pk_rel_prop_owned_count = 0 => 0.0833970926,
pk_rel_prop_owned_count = 1 => 0.0787926303,
0.0777258307
);


pk_rel_prop_own_prch_tot2_mm := map(
pk_rel_prop_own_prch_tot2 = -9 => 0.065560166,
pk_rel_prop_own_prch_tot2 = -1 => 0.0726792204,
pk_rel_prop_own_prch_tot2 = 0 => 0.0789884483,
pk_rel_prop_own_prch_tot2 = 1 => 0.081369248,
0.0777258307
);


pk_rel_prop_owned_prch_cnt_mm := map(
pk_rel_prop_owned_prch_cnt = -9 => 0.065560166,
pk_rel_prop_owned_prch_cnt = 0 => 0.0789884483,
pk_rel_prop_owned_prch_cnt = 1 => 0.0798013832,
pk_rel_prop_owned_prch_cnt = 2 => 0.0682852807,
0.0777258307
);


pk_rel_prop_own_assess_tot2_mm := map(
pk_rel_prop_own_assess_tot2 = -9 => 0.065560166,
pk_rel_prop_own_assess_tot2 = -1 => 0.0697553358,
pk_rel_prop_own_assess_tot2 = 0 => 0.0809964607,
pk_rel_prop_own_assess_tot2 = 1 => 0.0723781388,
pk_rel_prop_own_assess_tot2 = 2 => 0.0828769624,
0.0777258307
);


pk_rel_prop_owned_as_cnt_mm := map(
pk_rel_prop_owned_as_cnt = -9 => 0.065560166,
pk_rel_prop_owned_as_cnt = -1 => 0.0809964607,
pk_rel_prop_owned_as_cnt = 0 => 0.0788067321,
pk_rel_prop_owned_as_cnt = 1 => 0.0727600722,
0.0777258307
);


pk_rel_prop_sold_count_mm := map(
pk_rel_prop_sold_count = -9 => 0.065560166,
pk_rel_prop_sold_count = 0 => 0.0751119457,
pk_rel_prop_sold_count = 1 => 0.0841973543,
pk_rel_prop_sold_count = 2 => 0.091642925,
0.0777258307
);


pk_rel_prop_sold_prch_tot2_mm := map(
pk_rel_prop_sold_prch_tot2 = -9 => 0.065560166,
pk_rel_prop_sold_prch_tot2 = -1 => 0.0773361976,
pk_rel_prop_sold_prch_tot2 = 0 => 0.0752285132,
pk_rel_prop_sold_prch_tot2 = 1 => 0.0858015267,
pk_rel_prop_sold_prch_tot2 = 2 => 0.0970464135,
0.0777258307
);


pk_rel_prop_sold_as_tot2_mm := map(
pk_rel_prop_sold_as_tot2 = -9 => 0.065560166,
pk_rel_prop_sold_as_tot2 = -1 => 0.076433121,
pk_rel_prop_sold_as_tot2 = 0 => 0.078860469,
pk_rel_prop_sold_as_tot2 = 1 => 0.0807356608,
0.0777258307
);


pk_rel_within25miles_count_mm := map(
pk_rel_within25miles_count = -9 => 0.065560166,
pk_rel_within25miles_count = -3 => 0.0569684639,
pk_rel_within25miles_count = -2 => 0.0790322581,
pk_rel_within25miles_count = -1 => 0.0763582966,
pk_rel_within25miles_count = 0 => 0.0787750385,
pk_rel_within25miles_count = 1 => 0.0807354117,
pk_rel_within25miles_count = 2 => 0.0875576037,
pk_rel_within25miles_count = 3 => 0.0809332847,
pk_rel_within25miles_count = 4 => 0.0791366906,
pk_rel_within25miles_count = 5 => 0.078098472,
0.0777258307
);


pk_rel_incomeunder25_count_mm := map(
pk_rel_incomeunder25_count = -9 => 0.065560166,
pk_rel_incomeunder25_count = 0 => 0.0817433595,
pk_rel_incomeunder25_count = 1 => 0.0816861638,
pk_rel_incomeunder25_count = 2 => 0.0801228364,
pk_rel_incomeunder25_count = 3 => 0.0769899957,
pk_rel_incomeunder25_count = 4 => 0.0805471125,
pk_rel_incomeunder25_count = 5 => 0.0708661417,
pk_rel_incomeunder25_count = 6 => 0.0532374101,
pk_rel_incomeunder25_count = 7 => 0.1085271318,
0.0777258307
);


pk_rel_incomeunder50_count_mm := map(
pk_rel_incomeunder50_count = -9 => 0.065560166,
pk_rel_incomeunder50_count = 0 => 0.0895522388,
pk_rel_incomeunder50_count = 1 => 0.0841186736,
pk_rel_incomeunder50_count = 2 => 0.0807431225,
pk_rel_incomeunder50_count = 3 => 0.0702247191,
pk_rel_incomeunder50_count = 4 => 0.0813197026,
pk_rel_incomeunder50_count = 5 => 0.0747847107,
pk_rel_incomeunder50_count = 6 => 0.0824902724,
pk_rel_incomeunder50_count = 7 => 0.0681431005,
0.0777258307
);


pk_rel_incomeunder75_count_mm := map(
pk_rel_incomeunder75_count = -9 => 0.065560166,
pk_rel_incomeunder75_count = -3 => 0.0750474984,
pk_rel_incomeunder75_count = -2 => 0.0767067246,
pk_rel_incomeunder75_count = -1 => 0.0842658141,
pk_rel_incomeunder75_count = 0 => 0.0847717683,
pk_rel_incomeunder75_count = 1 => 0.0875842156,
pk_rel_incomeunder75_count = 2 => 0.0882352941,
0.0777258307
);


pk_rel_incomeunder100_count_mm := map(
pk_rel_incomeunder100_count = -9 => 0.065560166,
pk_rel_incomeunder100_count = -3 => 0.0760999488,
pk_rel_incomeunder100_count = -2 => 0.0814956855,
pk_rel_incomeunder100_count = -1 => 0.0931315483,
pk_rel_incomeunder100_count = 0 => 0.0942982456,
pk_rel_incomeunder100_count = 1 => 0.1326086957,
pk_rel_incomeunder100_count = 2 => 0.1447368421,
pk_rel_incomeunder100_count = 3 => 0.05,
0.0777258307
);


pk_rel_incomeover100_count_mm := map(
pk_rel_incomeover100_count = -9 => 0.065560166,
pk_rel_incomeover100_count = 0 => 0.0776603588,
pk_rel_incomeover100_count = 1 => 0.1011560694,
pk_rel_incomeover100_count = 2 => 0.1004016064,
pk_rel_incomeover100_count = 3 => 0.1115384615,
0.0777258307
);


pk_rel_homeunder100_count_mm := map(
pk_rel_homeunder100_count = -9 => 0.065560166,
pk_rel_homeunder100_count = 0 => 0.0897260274,
pk_rel_homeunder100_count = 1 => 0.0781918143,
pk_rel_homeunder100_count = 2 => 0.076866495,
pk_rel_homeunder100_count = 3 => 0.0740009867,
pk_rel_homeunder100_count = 4 => 0.0736782902,
pk_rel_homeunder100_count = 5 => 0.0733091239,
pk_rel_homeunder100_count = 6 => 0.0809090909,
pk_rel_homeunder100_count = 7 => 0.0547263682,
0.0777258307
);


pk_rel_homeunder200_count_mm := map(
pk_rel_homeunder200_count = -9 => 0.065560166,
pk_rel_homeunder200_count = 0 => 0.0772763148,
pk_rel_homeunder200_count = 1 => 0.0708710584,
pk_rel_homeunder200_count = 2 => 0.0879440885,
pk_rel_homeunder200_count = 3 => 0.0925994794,
0.0777258307
);


pk_rel_homeunder300_count_mm := map(
pk_rel_homeunder300_count = -9 => 0.065560166,
pk_rel_homeunder300_count = 0 => 0.0762605419,
pk_rel_homeunder300_count = 1 => 0.0845728857,
pk_rel_homeunder300_count = 2 => 0.0780952381,
pk_rel_homeunder300_count = 3 => 0.1039325843,
0.0777258307
);


pk_rel_homeunder500_count_mm := map(
pk_rel_homeunder500_count = -9 => 0.065560166,
pk_rel_homeunder500_count = 0 => 0.0780584297,
pk_rel_homeunder500_count = 1 => 0.0769230769,
pk_rel_homeunder500_count = 2 => 0.1081081081,
pk_rel_homeunder500_count = 3 => 0.1053811659,
0.0777258307
);


pk_rel_homeover500_count_mm := map(
pk_rel_homeover500_count = -9 => 0.065560166,
pk_rel_homeover500_count = 0 => 0.0783715498,
pk_rel_homeover500_count = 1 => 0.1018766756,
pk_rel_homeover500_count = 2 => 0.112244898,
0.0777258307
);


pk_rel_educationunder12_count_mm := map(
pk_rel_educationunder12_count = -9 => 0.065560166,
pk_rel_educationunder12_count = 0 => 0.0842273819,
pk_rel_educationunder12_count = 1 => 0.0721820374,
pk_rel_educationunder12_count = 2 => 0.071969697,
pk_rel_educationunder12_count = 3 => 0.0681818182,
0.0777258307
);


pk_rel_educationover12_count_mm := map(
pk_rel_educationover12_count = -9 => 0.065560166,
pk_rel_educationover12_count = -2 => 0.0820829656,
pk_rel_educationover12_count = -1 => 0.0807248764,
pk_rel_educationover12_count = 0 => 0.0760223995,
pk_rel_educationover12_count = 1 => 0.0811992505,
pk_rel_educationover12_count = 2 => 0.0915627996,
pk_rel_educationover12_count = 3 => 0.0770750988,
0.0777258307
);


pk_rel_ageunder30_count_mm := map(
pk_rel_ageunder30_count = -9 => 0.065560166,
pk_rel_ageunder30_count = 0 => 0.0787996546,
pk_rel_ageunder30_count = 1 => 0.0797822913,
pk_rel_ageunder30_count = 2 => 0.0683760684,
0.0777258307
);


pk_rel_ageunder40_count_mm := map(
pk_rel_ageunder40_count = -9 => 0.065560166,
pk_rel_ageunder40_count = 0 => 0.0799965482,
pk_rel_ageunder40_count = 1 => 0.0779286073,
pk_rel_ageunder40_count = 2 => 0.0778614998,
pk_rel_ageunder40_count = 3 => 0.0784968685,
0.0777258307
);


pk_rel_ageunder50_count_mm := map(
pk_rel_ageunder50_count = -9 => 0.065560166,
pk_rel_ageunder50_count = 0 => 0.0780926054,
pk_rel_ageunder50_count = 1 => 0.0794982855,
pk_rel_ageunder50_count = 2 => 0.0955223881,
0.0777258307
);


pk_rel_ageunder70_count_mm := map(
pk_rel_ageunder70_count = -9 => 0.065560166,
pk_rel_ageunder70_count = 0 => 0.0792913983,
pk_rel_ageunder70_count = 1 => 0.069124424,
0.0777258307
);


pk_rel_ageover70_count_mm := map(
pk_rel_ageover70_count = -9 => 0.065560166,
pk_rel_ageover70_count = 0 => 0.0793784517,
pk_rel_ageover70_count = 1 => 0.0444444444,
0.0777258307
);


pk_rel_vehicle_owned_count_mm := map(
pk_rel_vehicle_owned_count = -9 => 0.065560166,
pk_rel_vehicle_owned_count = 0 => 0.0886739879,
pk_rel_vehicle_owned_count = 1 => 0.0769230769,
pk_rel_vehicle_owned_count = 2 => 0.0749726377,
pk_rel_vehicle_owned_count = 3 => 0.0631578947,
0.0777258307
);


pk_rel_count_addr_mm := map(
pk_rel_count_addr = -9 => 0.065560166,
pk_rel_count_addr = 0 => 0.0617323853,
pk_rel_count_addr = 1 => 0.0860789165,
0.0777258307
);


pk_attr_arrests24_mm := map(
pk_attr_arrests24 = 0 => 0.0778676501,
pk_attr_arrests24 = 1 => 0.0421052632,
0.0777258307
);


pk_acc_damage_amt_total2_mm := map(
pk_acc_damage_amt_total2 = -1 => 0.0782354481,
pk_acc_damage_amt_total2 = 0 => 0.0566037736,
pk_acc_damage_amt_total2 = 1 => 0.0746268657,
pk_acc_damage_amt_total2 = 2 => 0.0664488017,
0.0777258307
);


pk_acc_damage_amt_last2_mm := map(
pk_acc_damage_amt_last2 = -1 => 0.0782252083,
pk_acc_damage_amt_last2 = 0 => 0.1111111111,
pk_acc_damage_amt_last2 = 1 => 0.0624338624,
0.0777258307
);


pk_add1_fc_index_flag_mm := map(
pk_add1_fc_index_flag = 0 => 0.0776772247,
pk_add1_fc_index_flag = 1 => 0.0909090909,
0.0777258307
);


pk_current_count_mm := map(
pk_current_count = 0 => 0.0809720488,
pk_current_count = 1 => 0.0780650374,
pk_current_count = 2 => 0.0687046005,
pk_current_count = 3 => 0.0560471976,
0.0777258307
);


pk_historical_count_mm := map(
pk_historical_count = 0 => 0.0834070144,
pk_historical_count = 1 => 0.0763596809,
pk_historical_count = 2 => 0.0737904629,
pk_historical_count = 3 => 0.0611439842,
0.0777258307
);


pk_add2_avm_med2_mm := map(
pk_add2_avm_med2 = -1 => 0.0755234297,
pk_add2_avm_med2 = 0 => 0.0622222222,
pk_add2_avm_med2 = 1 => 0.0535168196,
pk_add2_avm_med2 = 2 => 0.0702905342,
pk_add2_avm_med2 = 3 => 0.0768721007,
pk_add2_avm_med2 = 4 => 0.0727686185,
pk_add2_avm_med2 = 5 => 0.0767846431,
pk_add2_avm_med2 = 6 => 0.0761543763,
pk_add2_avm_med2 = 7 => 0.0845489729,
pk_add2_avm_med2 = 8 => 0.0941176471,
pk_add2_avm_med2 = 9 => 0.090521327,
0.0777258307
);

       end;

  /* End of Segmentation Specific Means */


    /* Segmentation Specific Submodels and Model   */


       if (     pk_Segment2 = 1 ) then /* 1 EDA              */



                    Age_mod3_1M_a := -2.812369649
                                 + pk_ams_age_mm  * 1.4258572616
                                 + pk_inferred_age_mm  * 2.6399622538
                                 + pk_yr_rc_ssnhighissue2_mm  * 2.2595782762
                    ;
                    Age_mod3_1M := 100 * (exp(Age_mod3_1M_a )) / (1+exp(Age_mod3_1M_a ));


                    Lien_mod_1M_a := -5.780103132
                                 + pk_lien_type_level_mm  * 0.9738963041
                                 + pk_yr_ln_unrel_cj_f_sn2_mm  * 2.8329804604
                                 + pk_yr_ln_unrel_lt_f_sn2_mm  * 3.472820855
                                 + pk_yr_ln_unrel_ot_f_sn2_mm  * 5.2119879691
                                 + pk_yr_ln_unrel_sc_f_sn2_mm  * 2.682643954
                    ;
                    Lien_mod_1M := 100 * (exp(Lien_mod_1M_a )) / (1+exp(Lien_mod_1M_a ));

                    LRes_mod_1M_a := -4.87185994
                                 + pk_add1_lres_mm  * 3.9988743168
                                 + pk_add2_lres_mm  * 2.5241517924
                                 + pk_add3_lres_mm  * 2.4481206672
                                 + pk_avg_lres_mm  * -2.674291702
                                 + pk_addrs_5yr_mm  * 1.130784915
                                 + pk_addrs_10yr_mm  * 2.1835445084
                                 + pk_add_lres_year_avg2_mm  * 2.8346947149
                    ;
                    LRes_mod_1M := 100 * (exp(LRes_mod_1M_a )) / (1+exp(LRes_mod_1M_a ));

                    ProfLic_mod_1M_a := -1.881572413
                                 + pk_attr_num_proflic90  * 0.3340639475
                                 + pk_prof_lic_cat_mm  * 3.5591526779
                    ;
                    ProfLic_mod_1M := 100 * (exp(ProfLic_mod_1M_a )) / (1+exp(ProfLic_mod_1M_a ));


                    Velocity2_mod_1M_a := -9.689975814
                                 + pk_addrs_per_ssn_c6  * -0.140061918
                                 + pk_nameperssn_count_mm  * 3.9269338681
                                 + pk_ssns_per_adl_mm  * 2.0573411844
                                 + pk_addrs_per_adl_mm  * 3.0209964581
                                 + pk_phones_per_adl_mm  * 3.5380763065
                                 + pk_addrs_per_ssn_mm  * -2.261994939
                                 + pk_phones_per_addr_mm  * 3.1460228116
                                 + pk_adls_per_phone_mm  * 3.2112828832
                                 + pk_phones_per_adl_c6_mm  * 2.104225332
                                 + pk_adls_per_phone_c6_mm  * 2.4934552374
                                 + pk_attr_addrs_last36_mm  * 2.7414235997
                                 + pk_ssns_per_addr2_mm  * 2.8231475256
                    ;
                    Velocity2_mod_1M := 100 * (exp(Velocity2_mod_1M_a )) / (1+exp(Velocity2_mod_1M_a ));

                    ver_best_element_cnt_mod_1M_a := 4.3294519368
                                 + pk_gong_did_first_ct_mm  * -30.03593693
                                 + pk_rc_phonelnamecount_mm  * -3.05791055
                                 + pk_combo_addrcount_mm  * 2.2088840951
                                 + pk_combo_hphonecount_mm  * 2.2843071594
                                 + pk_ver_phncount_mm  * 4.6787819539
                                 + pk_gong_did_phone_ct_mm  * 4.571186293
                                 + pk_combo_ssncount_mm  * 5.5187484832
                    ;
                    ver_best_element_cnt_mod_1M := 100 * (exp(ver_best_element_cnt_mod_1M_a)) / (1+exp(ver_best_element_cnt_mod_1M_a ));


                    ver_notbest_element_cnt_mod_1M_a := -7.605050077
                                 + pk_combo_lnamecount_nb_mm  * 2.6946196512
                                 + pk_combo_addrcount_nb_mm  * 5.2459882744
                                 + pk_rc_phoneaddrcount_mm  * 8.35672896
                                 + pk_gong_did_phone_ct_nb_mm  * 5.3601067946
                                 + pk_combo_dobcount_nb_mm  * 3.4161948777
                    ;
                    ver_notbest_element_cnt_mod_1M := 100 * (exp(ver_notbest_element_cnt_mod_1M_a )) / (1+exp(ver_notbest_element_cnt_mod_1M_a ));


					ver_element_cnt_mod_1M            := map(
						add1_isbestmatch  => ver_best_element_cnt_mod_1M,
						ver_notbest_element_cnt_mod_1M
					);


                    Relative_mod_1M_a := -6.52694558
                                 + pk_rel_count_mm  * 3.109695536
                                 + pk_rel_bankrupt_count_mm  * 1.0090344063
                                 + pk_rel_felony_count_mm  * 1.5155782641
                                 + pk_rel_prop_owned_count_mm  * 3.1013152177
                                 + pk_rel_prop_own_prch_tot2_mm  * 3.8892992076
                                 + pk_rel_prop_owned_prch_cnt_mm  * -8.078090966
                                 + pk_rel_prop_own_assess_tot2_mm  * 3.9881684247
                                 + pk_rel_prop_owned_as_cnt_mm  * -4.240493832
                                 + pk_rel_incomeunder75_count_mm  * 2.8174693037
                                 + pk_rel_incomeunder100_count_mm  * 3.0712160915
                                 + pk_rel_incomeover100_count_mm  * 2.4165518638
                                 + pk_rel_homeunder100_count_mm  * 1.7726426487
                                 + pk_rel_homeunder500_count_mm  * 2.0703885684
                                 + pk_rel_ageunder50_count_mm  * -5.811908151
                                 + pk_rel_vehicle_owned_count_mm  * 1.956806305
                                 + pk_rel_count_addr_mm  * 4.7839706351
                    ;
                    Relative_mod_1M := 100 * (exp(Relative_mod_1M_a )) / (1+exp(Relative_mod_1M_a ));



                    if (  add1_isbestmatch ) then      /* Address 1 is Best Match     */


                              Utility_best_mod_1M_a := -4.984599968
                                           + util_adl_G  * 0.1774686409
                                           + util_adl_Z  * 0.1327661156
                                           + util_add1_E  * 0.1548401727
                                           + util_add1_F  * -0.171805845
                                           + util_add1_V  * -0.46319588
                                           + pk_util_adl_sourced_mm  * -4.061613574
                                           + pk_util_adl_count_mm  * 2.6828513244
                                           + pk_util_adl_nap_mm  * 3.967490975
                                           + pk_util_add1_source_count_mm  * 3.2225427869
                                           + pk_rc_utiliaddr_phonecount_mm  * 5.2990145882
                                           + pk_utility_sourced_mm  * -10.72113973
                                           + pk_yr_util_adl_F_firstseen2_mm  * 1.7879347153
                                           + pk_yr_util_adl_I_firstseen2_mm  * 3.2585202149
                                           + pk_mx_yr_util_adl_firstseen2_mm  * 1.600022864
                                           + pk_yr_util_add1_I_firstseen2_mm  * 1.2065016807
                                           + pk_mx_yr_util_add1_firstseen2_mm  * 1.2670792236
                                           + pk_yr_util_add2_E_firstseen2_mm  * 2.5904357347
                              ;
                              Utility_best_mod_1M := 100 * (exp(Utility_best_mod_1M_a )) / (1+exp(Utility_best_mod_1M_a ));
                              Utility_mod_1M := Utility_best_mod_1M;


                              ver_best_src_cnt_mod2_1M_a := -11.32926131
                                           + pk_pos_secondary_sources_mm  * 4.3401797918
                                           + pk_lname_eda_sourced_type_lvl_mm  * 1.1869829177
                                           + pk_add2_EM_ver_lvl_mm  * 3.8088223499
                                           + pk_infutor_risk_lvl_mm  * 4.4835048359
                                           + pk_nap_summary_mm  * 4.0468179077
                                           + pk_add2_pos_sources_mm  * 4.5066960728
                                           + pk_attr_num_nonderogs90_b_mm  * 1.7158530956
                                           + pk_EN_count_mm  * 3.363941527
                                           + pk_DL_count_mm  * 2.5663888493
                                           + source_tot_AK  * 0.5687404453
                                           + source_tot_D  * -0.140890187
                                           + source_tot_NT  * -0.146644665
                                           + source_tot_V  * 0.0806366082
                                           + source_tot_W  * -0.20026212
                                           + source_tot_WP  * -0.221578847
                                           + source_add_AR  * 11.044449139
                                           + source_add_EQ  * 0.1153761959
                                           + source_add_V  * 0.1871669675
                                           + source_add_WP  * 0.1108370551
                                           + source_add2_AM  * -1.414948508
                                           + source_add2_PL  * 0.2326648177
                                           + source_add2_V  * 0.1192915168
                                           + source_add2_WP  * 0.1720155486
                              ;
                              ver_best_src_cnt_mod2_1M := 100 * (exp(ver_best_src_cnt_mod2_1M_a )) / (1+exp(ver_best_src_cnt_mod2_1M_a ));


                              ver_src_cnt_mod2_1M := ver_best_src_cnt_mod2_1M;


                    else                               /* Address 1 is Not Best Match */


                              Utility_notbest_mod_1M_a := -57.2159738
                                           + util_adl_U  * 0.1617056887
                                           + util_add1_G  * 0.3625131731
                                           + util_add2_E  * 0.2104164412
                                           + util_add2_W  * 11.87555341
                                           + pk_util_adl_source_count_mm  * 1.542099872
                                           + pk_util_add1_source_count_mm  * 7.6525943496
                                           + pk_util_add1_nap_mm  * -17.11145864
                                           + pk_util_add2_source_count_mm  * 3.3734444111
                                           + pk_util_add2_nap_mm  * 4.8850674273
                                           + pk_rc_utiliaddr_phonecount_mm  * 18.365874073
                                           + pk_utility_sourced_mm  * 182.87648326
                                           + pk_yr_util_adl_F_firstseen2_mm  * 2.5760136733
                                           + pk_yr_util_adl_I_firstseen2_mm  * 4.0926189738
                                           + pk_yr_util_adl_U_firstseen2_mm  * 4.1882122541
                                           + pk_mx_yr_util_adl_firstseen2_mm  * 2.6689210172
                              ;
                              Utility_notbest_mod_1M := 100 * (exp(Utility_notbest_mod_1M_a )) / (1+exp(Utility_notbest_mod_1M_a ));
                              Utility_mod_1M := Utility_notbest_mod_1M;


                              ver_notbest_src_cnt_mod2_1M_a := -12.4864693
                                           + (integer)add1_eda_sourced  * 0.2572559658
                                           + pk_fname_eda_sourced_type_lvl_mm  * 7.4003904894
                                           + pk_lname_eda_sourced_type_lvl_mm  * 6.8899598608
                                           + pk_EM_Only_ver_lvl_mm  * 6.3955165861
                                           + pk_add2_pos_sources_mm  * 3.14521947
                                           + pk_attr_num_nonderogs90_b_mm  * 6.1142969242
                                           + pk_EN_count_mm  * 5.0436199601
                                           + pk_DL_count_mm  * 6.9250078359
                                           + source_tot_CY  * 0.2028600817
                                           + source_tot_V  * 0.1442413943
                                           + source_add_EQ  * 0.2716986138
                                           + source_add2_V  * 0.2619432493
                              ;
                              ver_notbest_src_cnt_mod2_1M := 100 * (exp(ver_notbest_src_cnt_mod2_1M_a )) / (1+exp(ver_notbest_src_cnt_mod2_1M_a ));


                              ver_src_cnt_mod2_1M := ver_notbest_src_cnt_mod2_1M;


                    end;


                    AVM_mod2_1M_a := -7.836948139
                                 + pk_add2_avm_auto_diff4_lvl_mm  * 5.610680108
                                 + pk2_add1_avm_sp_mm  * -3.430187278
                                 + pk2_add1_avm_ta_mm  * 1.3081127479
                                 + pk2_add1_avm_pi_mm  * 3.1192542755
                                 + pk2_ADD1_AVM_MED_mm  * 2.2011078223
                                 + pk2_add1_avm_to_med_ratio_mm  * 2.4238911533
                                 + pk2_yr_add1_avm_rec_dt_mm  * 3.9884229349
                                 + pk2_yr_add1_avm_assess_year_mm  * 3.1953061352
                                 + pk_add2_avm_med2_mm  * 2.8780935002
                    ;
                    AVM_mod2_1M := 100 * (exp(AVM_mod2_1M_a )) / (1+exp(AVM_mod2_1M_a ));

                    Property_mod2_1M_a := -27.36731163
                                 + pk_add2_adjustable_financing  * -0.154869712
                                 + pk_attr_num_purchase180  * -0.1481079
                                 + pk_addrs_sourced_lvl_mm  * 1.64682211
                                 + pk_add2_own_level_mm  * 1.7929381844
                                 + pk_prop_owned_sold_level_mm  * 1.8276722745
                                 + pk_add1_mortgage_risk_mm  * 2.6288181978
                                 + pk_add1_assessed_amount2_mm  * 2.6526311485
                                 + pk_yr_add1_date_first_seen2_mm  * 1.8768349597
                                 + pk_add1_no_of_buildings_mm  * 4.8386937514
                                 + pk_add1_no_of_rooms_mm  * 1.9683912175
                                 + pk_yr_prop2_sale_date2_mm  * 2.8831467054
                                 + pk_yr_prop2_prev_purch_dt2_mm  * -7.751063281
                                 + pk_add2_land_use_risk_level_mm  * 24.401048228
                                 + pk_add2_no_of_buildings_mm  * 2.6868345893
                                 + pk_add2_no_of_stories_mm  * 4.0343299877
                                 + pk_add2_garage_type_risk_lvl_mm  * 3.5075322622
                                 + pk_add2_mortgage_amount2_mm  * 3.6204029468
                                 + pk_add2_mortgage_risk_mm  * 4.7037403214
                                 + pk_yr_add2_mortgage_due_date2_mm  * 3.6752266188
                                 + pk_add2_assessed_amount2_mm  * 1.8916573385
                                 + pk_yr_add2_date_first_seen2_mm  * 2.4310801925
                                 + pk_yr_add3_built_date2_mm  * 2.9008236654
                                 + pk_add3_purchase_amount2_mm  * 3.1424298108
                                 + pk_yr_add3_date_first_seen2_mm  * 1.9198278692
                                 + pk_yr_add3_date_last_seen2_mm  * 1.9452192545
                                 + pk_historical_count_mm  * 4.2392064122
                    ;
                    Property_mod2_1M := 100 * (exp(Property_mod2_1M_a )) / (1+exp(Property_mod2_1M_a ));
							 
							 /* Insert Version Excluding Utility Model             2/22/2013 PK */
                    mod18_1M_NoUtil_a := -15.78135999
                                 + Lien_mod_1M  * 0.0141869003
                                 + LRes_mod_1M  * -0.012071802
                                 + ProfLic_mod_1M  * 0.0272857777
                                 + Velocity2_mod_1M  * 0.0070659677
                                 + Age_mod3_1M  * 0.0109534576
                                 + ver_element_cnt_mod_1M  * 0.01753861
                                 + Relative_mod_1M  * 0.0159600477
                                 + AVM_mod2_1M  * 0.0094387576
                                 + Property_mod2_1M  * 0.0192071587
                                 + ver_src_cnt_mod2_1M  * 0.0224428867
                                 + pk_estimated_income_mm  * 2.5773599928
                                 + pk_out_st_division_lvl_mm  * 1.4517456199
                                 + pk_Repl_Addr_Matches_Input_m  * 0.8868927333
                                 + pk_es_match_level_m  * -1.346805694
                                 + pk_Moved_Out_10yr_m  * 5.0276453702
                                 + pk_Close_Rel_28Yr_m  * 6.238003279
                                 + pk_Pos_Work_Source_Flag_m  * 3.2418947107
                                 + pk_Short_Move_Count_m  * 3.7720362506
                                 + pk_years_ah_add1_first_seen2_m  * 3.5541960338
                                 + pk_years_ah_add3_first_seen2_m  * 1.2070696255
                                 + pk_years_ah_add5_first_seen2_m  * 0.916246225
                                 + pk_Repl_Hphn_Matches_Input  * 1.9398068375
                    ;
                    mod18_1M_NoUtil := (exp(mod18_1M_NoUtil_a )) / (1+exp(mod18_1M_NoUtil_a ));

// set each of these variables in each branch that was missing them
mod18_1M_NoUtil_NoDob := 0;
mod18_2M_NoUtil_NoDob := 0;
mod18_3M_NoUtil_NoDob := 0;	
mod18_4M_NoUtil_NoDob := 0;	

mod18_1M_NoUtil_NoDob_a := 0;
mod18_2M_NoUtil_NoDob_a := 0;
mod18_3M_NoUtil_NoDob_a := 0;	
mod18_4M_NoUtil_NoDob_a := 0;	

// mod18_1M_NoUtil := 0;
mod18_2M_NoUtil := 0;
mod18_3M_NoUtil := 0;	
mod18_4M_NoUtil := 0;	

// mod18_1M_NoUtil_a := 0;
mod18_2M_NoUtil_a := 0;
mod18_3M_NoUtil_a := 0;	
mod18_4M_NoUtil_a := 0;	
 
         /*    PK_Contact_Mod4 = 100 * mod18_1M;           Point at Model Excluding Utilities     2/22/2013 PK  */
               PK_Contact_Mod4 := 100 * mod18_1M_NoUtil;


       elseif (pk_Segment2 = 2 ) then /* 2 SkipTrace        */



                    LRes_mod_2M_a := -4.644288334
                                 + pk_add1_lres_mm  * 2.3600846457
                                 + pk_add2_lres_mm  * 2.0062146885
                                 + pk_lres_flag_level_mm  * 4.7018791475
                                 + pk_addrs_5yr_mm  * 2.2719259077
                                 + pk_addrs_10yr_mm  * 1.8802268405
                                 + pk_add_lres_year_avg2_mm  * 3.3817560556
                    ;
                    LRes_mod_2M := 100 * (exp(LRes_mod_2M_a )) / (1+exp(LRes_mod_2M_a ));

                    ProfLic_mod_2M_a := -2.659742663
                                 + pk_attr_num_proflic_exp30  * -1.081265304
                                 + pk_prof_lic_cat_mm  * 6.3726813488
                    ;
                    ProfLic_mod_2M := 100 * (exp(ProfLic_mod_2M_a )) / (1+exp(ProfLic_mod_2M_a ));


                    Velocity2_mod_2M_a := -12.66873994
                                 + pk_addrs_per_ssn_c6  * -0.134292178
                                 + pk_nameperssn_count_mm  * 7.78883995
                                 + pk_addrs_per_adl_mm  * 3.5460691663
                                 + pk_phones_per_adl_mm  * 4.8199326251
                                 + pk_adls_per_addr_mm  * 5.0323251402
                                 + pk_phones_per_addr_mm  * 5.1555556768
                                 + pk_adls_per_phone_mm  * 6.1324447044
                                 + pk_adls_per_addr_c6_mm  * -6.367642838
                                 + pk_ssns_per_addr_c6_mm  * 7.6927049291
                                 + pk_adls_per_phone_c6_mm  * 7.2169699797
                                 + pk_attr_addrs_last30_mm  * 12.784494606
                                 + pk_attr_addrs_last36_mm  * 4.5540349475
                    ;
                    Velocity2_mod_2M := 100 * (exp(Velocity2_mod_2M_a )) / (1+exp(Velocity2_mod_2M_a ));


                    Census_mod_2M_a := -3.669506647
                                 + pk_c_bargains_mm  * 3.1485353844
                                 + pk_c_bel_edu_mm  * 1.9928967035
                                 + pk_c_lowrent_mm  * 2.2722673025
                                 + pk_c_med_hval_mm  * 4.1636339195
                    ;
                    Census_mod_2M := 100 * (exp(Census_mod_2M_a )) / (1+exp(Census_mod_2M_a ));


                    Derog_mod4_2M_a := -7.322831623
                                 + pk_bk_level_mm  * 6.3594778641
                                 + pk_yr_attr_dt_l_eviction2_mm  * 6.4851770311
                                 + pk_felony_recent_level_mm  * 7.4102850992
                                 + pk_attr_total_number_derogs_mm  * -6.027427069
                                 + pk_derog_total_mm  * 8.6206767749
                                 + pk_acc_damage_amt_total2_mm  * 7.7182717145
                    ;
                    Derog_mod4_2M := 100 * (exp(Derog_mod4_2M_a )) / (1+exp(Derog_mod4_2M_a ));



                    if (  add1_isbestmatch ) then /* Address 1 is Best Match     */


                              Utility_best_mod_2M_a := -8.896918832
                                           + util_add1_F  * -0.109184326
                                           + util_add1_G  * 0.2079777458
                                           + pk_util_adl_sourced_mm  * -2.581953624
                                           + pk_util_adl_count_mm  * 2.7148143917
                                           + pk_util_adl_nap_mm  * 3.2937207076
                                           + pk_util_add1_source_count_mm  * 4.0078652787
                                           + pk_util_add2_nap_mm  * 3.8460266398
                                           + pk_rc_utiliaddr_phonecount_mm  * 4.1747291468
                                           + pk_yr_util_adl_F_firstseen2_mm  * 4.3637062788
                                           + pk_yr_util_adl_I_firstseen2_mm  * 5.0243207497
                                           + pk_yr_util_adl_U_firstseen2_mm  * 7.3981860818
                                           + pk_yr_util_add2_D_firstseen2_mm  * 4.0971422726
                              ;
                              Utility_best_mod_2M := 100 * (exp(Utility_best_mod_2M_a )) / (1+exp(Utility_best_mod_2M_a ));
                              Utility_mod_2M := Utility_best_mod_2M;


                              ver_best_src_time_mod2_2M_a := -8.38466257
                                           + pk_yr_adl_eq_first_seen2_mm  * 3.9196590769
                                           + pk_yr_adl_vo_first_seen2_mm  * 3.3499146015
                                           + pk_yr_adl_em_only_first_seen2_mm  * 5.7124214223
                                           + pk_yr_gong_did_first_seen2_mm  * 5.4528524314
                                           + pk_yr_infutor_first_seen2_mm  * 5.970420017
                                           + pk_yr_adl_EN_first_seen2_mm  * 3.757209989
                                           + pk_yr_adl_DL_first_seen2_mm  * 5.680604942
                              ;
                              ver_best_src_time_mod2_2M := 100 * (exp(ver_best_src_time_mod2_2M_a )) / (1+exp(ver_best_src_time_mod2_2M_a ));

                              ver_best_src_cnt_mod2_2M_a := -9.354329392
                                           + pk_lname_eda_sourced_type_lvl_mm  * 1.7281249643
                                           + pk_add2_EM_ver_lvl_mm  * 6.5459169827
                                           + pk_infutor_risk_lvl_mm  * 6.8174805302
                                           + pk_nap_summary_mm  * 5.6865216
                                           + pk_add2_pos_sources_mm  * 3.8752550079
                                           + pk_attr_num_nonderogs90_b_mm  * 6.8084184266
                                           + pk_EN_count_mm  * 2.5854002287
                                           + pk_DL_count_mm  * 4.4276583606
                                           + source_tot_AK  * 0.8253919375
                                           + source_tot_WP  * -0.200317709
                                           + source_add_EQ  * 0.1229814725
                                           + source_add_W  * -0.939589406
                                           + source_add2_D  * -0.125605707
                              ;
                              ver_best_src_cnt_mod2_2M := 100 * (exp(ver_best_src_cnt_mod2_2M_a )) / (1+exp(ver_best_src_cnt_mod2_2M_a ));

                              ver_src_time_mod2_2M := ver_best_src_time_mod2_2M;
                              ver_src_cnt_mod2_2M := ver_best_src_cnt_mod2_2M;


                    else                               /* Address 1 is Not Best Match */


                              Utility_notbest_mod_2M_a := -15.05790949
                                           + util_add1_N  * 0.572924624
                                           + util_add1_V  * -0.368294493
                                           + util_add2_D  * -0.317078318
                                           + pk_util_add2_nap_mm  * 7.2499177059
                                           + pk_rc_utiliaddr_phonecount_mm  * 7.0960992624
                                           + pk_yr_util_adl_D_firstseen2_mm  * 4.9098932681
                                           + pk_yr_util_adl_E_firstseen2_mm  * 5.2128917686
                                           + pk_yr_util_adl_F_firstseen2_mm  * 6.3846003318
                                           + pk_yr_util_adl_G_firstseen2_mm  * 4.958076236
                                           + pk_yr_util_adl_I_firstseen2_mm  * 6.9192060018
                                           + pk_yr_util_adl_U_firstseen2_mm  * 6.9246000789
                                           + pk_yr_util_add1_E_firstseen2_mm  * 5.2171587714
                                           + pk_yr_util_add1_F_firstseen2_mm  * 4.9398953963
                                           + pk_yr_util_add1_Z_firstseen2_mm  * 6.1167265917
                                           + pk_yr_util_add2_E_firstseen2_mm  * 5.8392016128
                                           + pk_yr_util_add2_G_firstseen2_mm  * 6.0888439972
                                           + pk_yr_util_add2_Z_firstseen2_mm  * 6.8444662759
                              ;
                              Utility_notbest_mod_2M := 100 * (exp(Utility_notbest_mod_2M_a )) / (1+exp(Utility_notbest_mod_2M_a ));
                              Utility_mod_2M := Utility_notbest_mod_2M;


                              ver_notbest_src_time_mod2_2M_a := -8.989343
                                           + pk_yr_adl_em_only_first_seen2_mm  * 8.6381790599
                                           + pk_yr_gong_did_first_seen2_mm  * 8.8003043357
                                           + pk_yr_header_first_seen2_mm  * 3.8676274724
                                           + pk_yr_infutor_first_seen2_mm  * 9.2643712566
                                           + pk_yrmo_adl_f_sn_mx_fcra2_mm  * 3.659531074
                                           + pk_yr_adl_EN_first_seen2_mm  * 4.3713076441
                                           + pk_yr_adl_DL_first_seen2_mm  * 7.5700720494
                              ;
                              ver_notbest_src_time_mod2_2M := 100 * (exp(ver_notbest_src_time_mod2_2M_a )) / (1+exp(ver_notbest_src_time_mod2_2M_a ));

                              ver_notbest_src_cnt_mod2_2M_a := -13.05649844
                                           + (integer)add1_eda_sourced  * 0.2373167144
                                           + pk_eq_count_mm  * 10.919225245
                                           + pk_EM_Only_ver_lvl_mm  * 7.9604162096
                                           + pk_infutor_risk_lvl_nb_mm  * 7.2167134303
                                           + pk_nas_summary_mm  * 7.2380203226
                                           + pk_nap_summary_mm  * 4.9504272174
                                           + pk_add2_pos_sources_mm  * 5.6988607153
                                           + pk_attr_num_nonderogs90_b_mm  * 5.0931832918
                                           + pk_nap_type_mm  * 9.4320101768
                                           + pk_EN_count_mm  * 6.7169784526
                                           + pk_DL_count_mm  * 8.8535933763
                                           + source_tot_EQ  * -0.416518346
                                           + source_tot_WP  * -0.147108898
                                           + source_add_D  * 0.36222489
                                           + source_add_V  * 0.5016181598
                                           + source_add2_CY  * 0.267136317
                                           + source_add2_EM  * 0.4591429137
                              ;
                              ver_notbest_src_cnt_mod2_2M := 100 * (exp(ver_notbest_src_cnt_mod2_2M_a )) / (1+exp(ver_notbest_src_cnt_mod2_2M_a ));

                              ver_src_time_mod2_2M := ver_notbest_src_time_mod2_2M;
                              ver_src_cnt_mod2_2M := ver_notbest_src_cnt_mod2_2M;


                    end;


                    Property_mod2_2M_a := -21.91547575
                                 + pk_attr_num_purchase180  * 0.1525986091
                                 + pk_attr_num_sold60  * -0.17561851
                                 + pk_attr_num_watercraft90  * 12.041801739
                                 + pk_attr_num_watercraft180  * -0.853467271
                                 + pk_yr_adl_pr_last_seen2_mm  * 2.5583384189
                                 + pk_add2_own_level_mm  * 3.6612118361
                                 + pk_add3_own_level_mm  * 5.058040475
                                 + pk_add1_purchase_amount2_mm  * 4.5003304331
                                 + pk_yr_add1_mortgage_date2_mm  * 4.1431772279
                                 + pk_add1_mortgage_risk_mm  * 2.8619249081
                                 + pk_add1_assessed_amount2_mm  * 2.8184594939
                                 + pk_yr_add1_date_first_seen2_mm  * 1.9532466325
                                 + pk_add1_building_area2_mm  * 2.6106405653
                                 + pk_add1_no_of_buildings_mm  * 7.5482378166
                                 + pk_add1_no_of_rooms_mm  * 3.3888320533
                                 + pk_add1_parking_no_of_cars_mm  * 3.1070213875
                                 + pk_add1_style_code_level_mm  * 9.1954809093
                                 + pk_yr_add1_assess_val_yr2_mm  * -7.062835076
                                 + pk_yr_prop1_prev_purch_dt2_mm  * 4.2896540004
                                 + pk_add2_no_of_buildings_mm  * 2.6702362224
                                 + pk_add2_no_of_stories_mm  * 3.5960105399
                                 + pk_yr_add2_assess_val_yr2_mm  * 4.7267122282
                                 + pk_yr_add2_mortgage_due_date2_mm  * 8.1390774696
                                 + pk_add2_assessed_amount2_mm  * 3.9573725883
                                 + pk_yr_add2_date_first_seen2_mm  * 2.0727940187
                                 + pk_yr_add2_date_last_seen2_mm  * 2.4862847992
                                 + pk_yr_add3_built_date2_mm  * 5.7325062536
                                 + pk_add3_mortgage_risk_mm  * 7.2870968929
                                 + pk_yr_add3_date_first_seen2_mm  * 2.5486431391
                                 + pk_yr_add3_date_last_seen2_mm  * 2.1627594156
                                 + pk_yr_attr_dt_last_purch2_mm  * 2.523397636
                                 + pk_add1_fc_index_flag_mm  * 5.0108076135
                                 + pk_historical_count_mm  * 2.9167068599
                    ;
                    Property_mod2_2M := 100 * (exp(Property_mod2_2M_a )) / (1+exp(Property_mod2_2M_a ));
						 
							      /* Insert Version Excluding Utility Model             2/22/2013 PK */
                    mod18_2M_NoUtil_a := 33.123033338
                                 + LRes_mod_2M  * -0.028300711
                                 + ProfLic_mod_2M  * 0.0727483783
                                 + Velocity2_mod_2M  * 0.0179237539
                                 + Census_mod_2M  * 0.0222296007
                                 + Derog_mod4_2M  * 0.0295486208
                                 + Property_mod2_2M  * 0.0263199786
                                 + ver_src_cnt_mod2_2M  * 0.024296877
                                 + ver_src_time_mod2_2M  * 0.0143999971
                                 + pk_estimated_income_mm  * 2.0826856166
                                 + pk_out_st_division_lvl_mm  * 3.0226518778
                                 + pk_Repl_Addr_Matches_Input_m  * 3.6154496194
                                 + pk_Repl_Phn_Matches_Input_m  * 4.8379788595
                                 + pk_se_phone_stability_flag_m  * 4.6082118421
                                 + pk_Stable_Neighbor_Phone_Flag_m  * -221.3990417
                                 + pk_PP_Disconnect_Count_m  * 2.0314237734
                                 + pk_Pos_Work_Source_Flag_m  * 4.8919837313
                                 + pk_years_ah_add2_first_seen2_m  * -2.456220281
                    ;
                    mod18_2M_NoUtil := (exp(mod18_2M_NoUtil_a )) / (1+exp(mod18_2M_NoUtil_a ));
										
// set each of these variables in each branch that was missing them
mod18_1M_NoUtil_NoDob := 0;
mod18_2M_NoUtil_NoDob := 0;
mod18_3M_NoUtil_NoDob := 0;	
mod18_4M_NoUtil_NoDob := 0;	

mod18_1M_NoUtil_NoDob_a := 0;
mod18_2M_NoUtil_NoDob_a := 0;
mod18_3M_NoUtil_NoDob_a := 0;	
mod18_4M_NoUtil_NoDob_a := 0;	

mod18_1M_NoUtil := 0;
// mod18_2M_NoUtil := 0;
mod18_3M_NoUtil := 0;	
mod18_4M_NoUtil := 0;	

mod18_1M_NoUtil_a := 0;
// mod18_2M_NoUtil_a := 0;
mod18_3M_NoUtil_a := 0;	
mod18_4M_NoUtil_a := 0; 
 
         /*    PK_Contact_Mod4 = 100 * mod18_2M;           Point at Model Excluding Utilities     2/22/2013 PK  */
               PK_Contact_Mod4 := 100 * mod18_2M_NoUtil;


       elseif (pk_Segment2 = 3 ) then /* 3 Mid              */



                    AddProb3_mod_3M_a := -3.076677191
                                 + (integer)addrs_prison_history  * -0.60408626
                                 + invalid_addrs_per_adl_c6  * 0.1222531873
                                 + pk_add1_unit_count2_mm  * 8.8245817421
                    ;
                    AddProb3_mod_3M := 100 * (exp(AddProb3_mod_3M_a )) / (1+exp(AddProb3_mod_3M_a ));

                    PhnProb_mod_3M_a := -2.262457249
                                 + pk_phn_cell_pager_inval  * 0.4756445823
                                 + (integer)phn_highrisk2  * -0.257635446
                                 + (integer)phn_zipmismatch  * -0.10254453
                                 + pk_disconnected  * -0.240821617
                                 + (integer)pk_phn_not_residential  * 0.2409595167
                                 + pk_recent_AC_Split  * 0.1036523807
                    ;
                    PhnProb_mod_3M := 100 * (exp(PhnProb_mod_3M_a )) / (1+exp(PhnProb_mod_3M_a ));

                    SSNProb2_mod_3M_a := -3.254619016
                                 + (integer)ssn_prob  * -0.224070692
                                 + (integer)ssn_issued18  * -0.060142479
                                 + pk_ssnchar_invalid_or_recent_mm  * 10.686811966
                    ;
                    SSNProb2_mod_3M := 100 * (exp(SSNProb2_mod_3M_a )) / (1+exp(SSNProb2_mod_3M_a ));

                    FP_mod5_3M_a := -6.932306713
                                 + AddProb3_mod_3M  * 0.1119943665
                                 + PhnProb_mod_3M  * 0.1055431571
                                 + SSNProb2_mod_3M  * 0.1086639168
                                 + pk_rc_disthphoneaddr_mm  * 11.0163915
                    ;
                    FP_mod5_3M := 100 * (exp(FP_mod5_3M_a )) / (1+exp(FP_mod5_3M_a ));

                    Age_mod3_3M_a := -5.640201514
                                 + pk_ams_age_mm  * 14.716492154
                                 + pk_inferred_age_mm  * 8.5279687405
                                 + pk_yr_rc_ssnhighissue2_mm  * 9.0111896835
                    ;
                    Age_mod3_3M := 100 * (exp(Age_mod3_3M_a )) / (1+exp(Age_mod3_3M_a ));

                    AMStudent_mod_3M_a := -4.067943425
                                 + pk_ams_class_level_mm  * 9.03962859
                                 + pk_ams_income_level_code_mm  * 8.910022758
                    ;
                    AMStudent_mod_3M := 100 * (exp(AMStudent_mod_3M_a )) / (1+exp(AMStudent_mod_3M_a ));


                    LRes_mod_3M_a := -6.51953919
                                 + pk_add1_lres_mm  * 8.1992871834
                                 + pk_add2_lres_mm  * 11.457903992
                                 + pk_add3_lres_mm  * 10.600372994
                                 + pk_add_lres_year_avg2_mm  * 5.0858258531
                                 + pk_add_lres_year_max2_mm  * 4.8419667388
                    ;
                    LRes_mod_3M := 100 * (exp(LRes_mod_3M_a )) / (1+exp(LRes_mod_3M_a ));

                    ProfLic_mod_3M_a := -3.066842985
                                 + pk_PL_Sourced_Level_mm  * 8.8615968532
                    ;
                    ProfLic_mod_3M := 100 * (exp(ProfLic_mod_3M_a )) / (1+exp(ProfLic_mod_3M_a ));


                    Velocity2_mod_3M_a := -10.24626293
                                 + pk_ssns_per_adl_mm  * 13.931619281
                                 + pk_phones_per_adl_mm  * 4.5384408401
                                 + pk_addrs_per_ssn_mm  * 8.9982560202
                                 + pk_phones_per_addr_mm  * 8.5903187386
                                 + pk_addrs_per_adl_c6_mm  * 7.9914442351
                                 + pk_phones_per_adl_c6_mm  * 5.7990499999
                                 + pk_adls_per_phone_c6_mm  * 15.603121634
                                 + pk_ssns_per_addr2_mm  * 8.6396586631
                    ;
                    Velocity2_mod_3M := 100 * (exp(Velocity2_mod_3M_a )) / (1+exp(Velocity2_mod_3M_a ));


                    ver_best_score_mod_3M_a := -3.446483983
                                 + pk_combo_fnamescore  * -1.030021895
                                 + pk_rc_dirsaddr_lastscore_mm  * 10.412107794
                                 + pk_combo_hphonescore_mm  * 10.836968359
                    ;
                    ver_best_score_mod_3M := 100 * (exp(ver_best_score_mod_3M_a )) / (1+exp(ver_best_score_mod_3M_a ));


                    ver_notbest_score_mod_3M_a := -6.973712809
                                 + pk_rc_dirsaddr_lastscore_mm  * 11.886781101
                                 + pk_combo_hphonescore_mm  * 18.201077024
                                 + pk_combo_dobscore_mm  * 6.5071744179
                                 + pk_add1_address_score_mm  * 10.865646033
                    ;
                    ver_notbest_score_mod_3M := 100 * (exp(ver_notbest_score_mod_3M_a )) / (1+exp(ver_notbest_score_mod_3M_a ));


					ver_score_mod_3M := if( add1_isbestmatch, ver_best_score_mod_3M, ver_notbest_score_mod_3M);


                    Relative_mod_3M_a := -3.13642182
                                 + pk_rel_count_mm  * 6.4814737793
                                 + pk_rel_felony_count_mm  * 3.7026148654
                                 + pk_rel_prop_owned_count_mm  * 11.551482079
                                 + pk_rel_prop_sold_count_mm  * 5.6937454468
                                 + pk_rel_prop_sold_as_tot2_mm  * -11.4973011
                                 + pk_rel_within25miles_count_mm  * 4.5468629842
                                 + pk_rel_incomeunder25_count_mm  * 5.1060725778
                                 + pk_rel_incomeunder75_count_mm  * 5.7139260642
                                 + pk_rel_incomeunder100_count_mm  * 2.5604800582
                                 + pk_rel_incomeover100_count_mm  * 2.8859796897
                                 + pk_rel_homeunder100_count_mm  * 1.2634141397
                                 + pk_rel_homeunder200_count_mm  * 3.2633503327
                                 + pk_rel_homeunder300_count_mm  * 3.4724254599
                                 + pk_rel_homeunder500_count_mm  * 2.539697377
                                 + pk_rel_homeover500_count_mm  * 3.4096477315
                                 + pk_rel_educationunder12_count_mm  * 3.3836197488
                                 + pk_rel_ageunder30_count_mm  * 11.440935619
                                 + pk_rel_ageunder40_count_mm  * 11.280104663
                                 + pk_rel_ageunder50_count_mm  * 19.599163107
                                 + pk_rel_ageunder70_count_mm  * -109.3029298
                                 + pk_rel_ageover70_count_mm  * 5.8747408812
                                 + pk_rel_vehicle_owned_count_mm  * 5.5005164839
                                 + pk_rel_count_addr_mm  * 10.838549059
                    ;
                    Relative_mod_3M := 100 * (exp(Relative_mod_3M_a )) / (1+exp(Relative_mod_3M_a ));

                    Derog_mod4_3M_a := -7.823960361
                                 + pk_bk_level_mm  * 10.867649757
                                 + pk_yr_criminal_last_date2_mm  * -9.883377962
                                 + pk_crime_level_mm  * 10.205138407
                                 + pk_derog_total_mm  * 10.33974405
                                 + pk_eviction_level_mm  * 8.2549179954
                                 + pk_attr_arrests24_mm  * 10.466011951
                                 + pk_acc_damage_amt_last2_mm  * 11.814413684
                    ;
                    Derog_mod4_3M := 100 * (exp(Derog_mod4_3M_a )) / (1+exp(Derog_mod4_3M_a ));



                    if (   add1_isbestmatch ) then /* Address 1 is Best Match     */


                              Utility_best_mod_3M_a := -5.975079003
                                           + util_adl_F  * -0.191123449
                                           + util_add2_D  * -0.09425602
                                           + util_add2_I  * -0.130196362
                                           + pk_util_adl_source_count_mm  * 4.6030777106
                                           + pk_rc_utiliaddr_phonecount_mm  * 5.9975803352
                                           + pk_utility_sourced_mm  * 3.9606628845
                                           + pk_yr_util_adl_D_firstseen2_mm  * 7.3707289902
                                           + pk_yr_util_adl_E_firstseen2_mm  * 6.3393641823
                                           + pk_yr_util_adl_F_firstseen2_mm  * 4.4357686232
                                           + pk_yr_util_adl_G_firstseen2_mm  * 6.5764215363
                                           + pk_yr_util_adl_I_firstseen2_mm  * 7.9506386993
                                           + pk_yr_util_adl_U_firstseen2_mm  * 7.0262179424
                                           + pk_yr_util_add1_E_firstseen2_mm  * 4.7700887624
                                           + pk_yr_util_add1_F_firstseen2_mm  * 6.117824816
                                           + pk_yr_util_add1_I_firstseen2_mm  * 5.6533125985
                                           + pk_yr_util_add1_V_firstseen2_mm  * -52.40713186
                                           + pk_yr_util_add1_Z_firstseen2_mm  * 6.2431822589
                                           + pk_yr_util_add2_E_firstseen2_mm  * 6.1730677371
                                           + pk_yr_util_add2_U_firstseen2_mm  * 3.8310339692
                              ;
                              Utility_best_mod_3M := 100 * (exp(Utility_best_mod_3M_a )) / (1+exp(Utility_best_mod_3M_a ));
                              Utility_mod_3M := Utility_best_mod_3M;


                              ver_best_src_time_mod2_3M_a := -8.436227709
                                           + pk_yr_adl_em_only_first_seen2_mm  * 10.529788785
                                           + pk_yr_gong_did_first_seen2_mm  * 7.7366935976
                                           + pk_yr_credit_first_seen2_mm  * 6.4359969367
                                           + pk_yr_header_first_seen2_mm  * 3.2307313924
                                           + pk_yr_infutor_first_seen2_mm  * 9.635272723
                                           + pk_yr_lname_change_date2_mm  * 9.4160074315
                                           + pk_yr_adl_DL_first_seen2_mm  * 8.9370774927
                              ;
                              ver_best_src_time_mod2_3M := 100 * (exp(ver_best_src_time_mod2_3M_a )) / (1+exp(ver_best_src_time_mod2_3M_a ));

                              ver_best_src_cnt_mod2_3M_a := -13.04096957
                                           + pk_eq_count_mm  * 7.056065405
                                           + pk_fname_eda_sourced_type_lvl_mm  * 4.5725586246
                                           + pk_EM_Only_ver_lvl_mm  * 8.2284326446
                                           + pk_add2_EM_ver_lvl_mm  * 6.8338157453
                                           + pk_infutor_risk_lvl_mm  * 9.0594244929
                                           + pk_nap_summary_mm  * 12.172161241
                                           + pk_attr_num_nonderogs90_b_mm  * 13.384109839
                                           + pk_nap_type_mm  * 9.5296174119
                                           + pk_EN_count_mm  * 13.7851759
                                           + pk_dl_avail_mm  * 6.0158013613
                                           + pk_DL_count_mm  * 6.929548426
                                           + source_tot_FR  * 0.1966045509
                                           + source_tot_PL  * 0.1211290466
                                           + source_tot_WP  * -0.359719667
                                           + source_add_EQ  * -0.121679523
                                           + source_add_V  * 0.1746156331
                                           + source_add_WP  * 0.1129859984
                                           + source_add2_EQ  * 0.1183604362
                                           + source_add2_WP  * 0.1322175315
                              ;
                              ver_best_src_cnt_mod2_3M := 100 * (exp(ver_best_src_cnt_mod2_3M_a )) / (1+exp(ver_best_src_cnt_mod2_3M_a ));

                              ver_src_time_mod2_3M := ver_best_src_time_mod2_3M;
                              ver_src_cnt_mod2_3M := ver_best_src_cnt_mod2_3M;


                    else /* Address 1 is Not Best Match */


                              Utility_notbest_mod_3M_a := -10.54322342
                                           + util_adl_W  * 12.065116335
                                           + util_add2_I  * -0.192933515
                                           + pk_util_adl_nap_mm  * 5.9124905311
                                           + pk_util_add2_nap_mm  * 5.9017218907
                                           + pk_yr_util_adl_D_firstseen2_mm  * 6.1022342319
                                           + pk_yr_util_adl_E_firstseen2_mm  * 7.3345452922
                                           + pk_yr_util_adl_F_firstseen2_mm  * 11.228155629
                                           + pk_yr_util_adl_G_firstseen2_mm  * 7.2010784523
                                           + pk_yr_util_adl_I_firstseen2_mm  * 9.524537809
                                           + pk_yr_util_adl_U_firstseen2_mm  * 7.8927949999
                                           + pk_yr_util_add1_F_firstseen2_mm  * 7.4666575721
                                           + pk_yr_util_add1_Z_firstseen2_mm  * 7.3034880895
                                           + pk_yr_util_add2_E_firstseen2_mm  * 6.7967623279
                              ;
                              Utility_notbest_mod_3M := 100 * (exp(Utility_notbest_mod_3M_a )) / (1+exp(Utility_notbest_mod_3M_a ));
                              Utility_mod_3M := Utility_notbest_mod_3M;


                              ver_notbest_src_time_mod2_3M_a := -7.364849865
                                           + pk_yr_gong_did_first_seen2_mm  * 8.4653585902
                                           + pk_yr_credit_first_seen2_mm  * 8.7676402821
                                           + pk_yr_infutor_first_seen2_mm  * 11.183764452
                                           + pk_yr_lname_change_date2_mm  * 12.510478613
                                           + pk_yr_adl_DL_first_seen2_mm  * 10.348298893
                              ;
                              ver_notbest_src_time_mod2_3M := 100 * (exp(ver_notbest_src_time_mod2_3M_a )) / (1+exp(ver_notbest_src_time_mod2_3M_a ));

                              ver_notbest_src_cnt_mod2_3M_a := -13.64174704
                                           + pk_voter_count_mm  * 22.045332397
                                           + pk_eq_count_mm  * 9.8816160402
                                           + pk_em_only_count_mm  * 20.664634214
                                           + pk_lname_eda_sourced_type_lvl_mm  * 10.137954771
                                           + pk_infutor_risk_lvl_nb_mm  * 11.42538378
                                           + pk_nas_summary_mm  * 7.0009248483
                                           + pk_nap_summary_mm  * 9.0456670785
                                           + pk_attr_num_nonderogs90_b_mm  * 9.8619746097
                                           + pk_dl_avail_mm  * 10.701172976
                                           + source_tot_PL  * 0.3088257537
                                           + source_tot_WP  * -0.123495915
                                           + source_add_FR  * 2.5575265736
                                           + source_add_V  * 0.4150282707
                                           + source_add_W  * 0.8273836088
                                           + source_add2_EQ  * 0.1442006691
                              ;
                              ver_notbest_src_cnt_mod2_3M := 100 * (exp(ver_notbest_src_cnt_mod2_3M_a )) / (1+exp(ver_notbest_src_cnt_mod2_3M_a ));

                              ver_src_time_mod2_3M := ver_notbest_src_time_mod2_3M;
                              ver_src_cnt_mod2_3M := ver_notbest_src_cnt_mod2_3M;


                    end;


                    Property_mod2_3M_a := -20.85228059
                                 + pk_add3_adjustable_financing  * -0.13783013
                                 + pk_attr_num_sold60  * -0.114970164
                                 + pk_yr_adl_pr_first_seen2_mm  * 6.6310583325
                                 + pk_yr_adl_w_first_seen2_mm  * 6.6838014275
                                 + pk_yr_adl_w_last_seen2_mm  * 6.6953175129
                                 + pk_add1_own_level_mm  * 10.610112149
                                 + pk_add1_purchase_amount2_mm  * 4.209449838
                                 + pk_add1_assessed_amount2_mm  * 4.2028002129
                                 + pk_yr_add1_mortgage_due_date2_mm  * 3.6532736976
                                 + pk_yr_add1_date_first_seen2_mm  * 10.579947159
                                 + pk_add1_no_of_buildings_mm  * 8.9873046606
                                 + pk_add1_no_of_baths_mm  * 4.5077392281
                                 + pk_add1_parking_no_of_cars_mm  * 4.0415414992
                                 + pk_add1_style_code_level_mm  * 10.825658053
                                 + pk_prop_owned_assess_count_mm  * 11.279631073
                                 + pk_prop1_sale_price2_mm  * -9.634842865
                                 + pk_add2_no_of_buildings_mm  * 11.659417609
                                 + pk_add2_no_of_baths_mm  * 4.9798066865
                                 + pk_add2_mortgage_amount2_mm  * 3.0333009058
                                 + pk_add2_mortgage_risk_mm  * 3.1999163799
                                 + pk_add2_assessed_amount2_mm  * 3.1798225918
                                 + pk_yr_add2_date_first_seen2_mm  * 7.5700381868
                                 + pk_yr_add2_date_last_seen2_mm  * 11.438493184
                                 + pk_yr_add3_mortgage_due_date2_mm  * 5.5629503717
                                 + pk_add3_assessed_amount2_mm  * 6.1505069406
                                 + pk_yr_add3_date_first_seen2_mm  * 10.970514197
                                 + pk_yr_attr_dt_last_purch2_mm  * 4.9571325167
                                 + pk_yr_attr_date_last_sale2_mm  * 5.7652669934
                                 + pk_historical_count_mm  * 8.8011173817
                    ;
                    Property_mod2_3M := 100 * (exp(Property_mod2_3M_a )) / (1+exp(Property_mod2_3M_a ));

							  /* Insert Version Excluding Utility Model             2/22/2013 PK */
                    mod18_3M_NoUtil_a := -22.69390752
                                 + FP_mod5_3M  * 0.051269456
                                 + AMStudent_mod_3M  * 0.0499093732
                                + ProfLic_mod_3M  * 0.0439035322
                                 + Velocity2_mod_3M  * 0.0527918307
                                 + Age_mod3_3M  * 0.0397203224
                                 + ver_score_mod_3M  * 0.0324892525
                                 + Relative_mod_3M  * 0.0443249633
                                 + Derog_mod4_3M  * 0.0675090262
                                 + Property_mod2_3M  * 0.0468911305
                                 + ver_src_cnt_mod2_3M  * 0.0271263438
                                 + ver_src_time_mod2_3M  * 0.0408014281
                                 + pk_did0  * 0.2519127046
                                 + pk_impulse_count_mm  * 14.895433867
                                 + pk_out_st_division_lvl_mm  * 3.064938029
                                 + pk_waterfall_phone_count2_m  * 13.712971538
                                 + pk_Repl_Addr_Matches_Input_m  * 9.604669384
                                 + pk_Repl_Phn_Matches_Input_m  * 10.894739904
                                 + pk_yr_ap1_phn_fseen_3_m  * 27.318436782
                                 + pk_sp_dist_0_m  * 7.6198693976
                                 + pk_years_sp_first_seen_19yr_m  * 8.0023404625
                                 + pk_Lived_With_Parents_3yr_m  * 5.7502809244
                                 + pk_Close_Rel_Living_With_Flag_m  * 8.1646109983
                                 + pk_PP_Disconnect_Count_m  * 10.040549834
                                 + pk_PP_Recent_LSeen_Phone_Index_m  * 9.0436482463
                                 + pk_Pos_Work_Source_Flag_m  * 3.3142197783
                                 + pk_WK_Recent_Phone_m  * 4.8707677218
                    ;
                    mod18_3M_NoUtil := (exp(mod18_3M_NoUtil_a )) / (1+exp(mod18_3M_NoUtil_a ));
// set each of these variables in each branch that was missing them
mod18_1M_NoUtil_NoDob := 0;
mod18_2M_NoUtil_NoDob := 0;
mod18_3M_NoUtil_NoDob := 0;	
mod18_4M_NoUtil_NoDob := 0;	

mod18_1M_NoUtil_NoDob_a := 0;
mod18_2M_NoUtil_NoDob_a := 0;
mod18_3M_NoUtil_NoDob_a := 0;	
mod18_4M_NoUtil_NoDob_a := 0;	

mod18_1M_NoUtil := 0;
mod18_2M_NoUtil := 0;
// mod18_3M_NoUtil := 0;	
mod18_4M_NoUtil := 0;	

mod18_1M_NoUtil_a := 0;
mod18_2M_NoUtil_a := 0;
// mod18_3M_NoUtil_a := 0;	
mod18_4M_NoUtil_a := 0; 
 
         /*    PK_Contact_Mod4 = 100 * mod18_3M;           Point at Model Excluding Utilities     2/22/2013 PK  */
               PK_Contact_Mod4 := 100 * mod18_3M_NoUtil;


       // elseif ( pk_Segment2 = 4 ) then /* 4 Unassigned       */
		else


                    AddProb3_mod_4M_a := -2.475931508
                                 + (integer)rc_cityzipflag  * 1.2257089489
                    ;
                    AddProb3_mod_4M := 100 * (exp(AddProb3_mod_4M_a )) / (1+exp(AddProb3_mod_4M_a ));

                    PhnProb_mod_4M_a := -2.553081917
                                 + pk_phn_cell_pager_inval  * 0.3818643645
                                 + (integer)phn_zipmismatch  * -0.664902813
                                 + pk_disconnected  * -0.692680508
                                 + (integer)pk_phn_not_residential  * 0.2855902379
                                 + pk_recent_AC_Split  * 0.1377880381
                    ;
                    PhnProb_mod_4M := 100 * (exp(PhnProb_mod_4M_a )) / (1+exp(PhnProb_mod_4M_a ));

                    SSNProb2_mod_4M_a := -3.69990115
                                 + (integer)ssn_issued18  * -0.119241859
                                 + pk_ssnchar_invalid_or_recent_mm  * 16.026709571
                    ;
                    SSNProb2_mod_4M := 100 * (exp(SSNProb2_mod_4M_a )) / (1+exp(SSNProb2_mod_4M_a ));

                    FP_mod5_4M_a := -6.096888122
                                 + AddProb3_mod_4M  * 0.0895498231
                                 + PhnProb_mod_4M  * 0.1040433469
                                 + SSNProb2_mod_4M  * 0.1461829677
                                 + pk_rc_disthphoneaddr_mm  * 9.4862197572
                    ;
                    FP_mod5_4M := 100 * (exp(FP_mod5_4M_a )) / (1+exp(FP_mod5_4M_a ));

                    Age_mod3_4M_a := -4.941168978
                                 + pk_yr_rc_correct_dob2_mm  * 8.992392009
                                 + pk_inferred_age_mm  * 11.354544756
                                 + pk_yr_rc_ssnhighissue2_mm  * 11.241669882
                    ;
                    Age_mod3_4M := 100 * (exp(Age_mod3_4M_a )) / (1+exp(Age_mod3_4M_a ));

                    AMStudent_mod_4M_a := -5.836184
                                 + pk_ams_class_level_mm  * 14.358898991
                                 + pk_ams_income_level_code_mm  * 13.142634105
                                 + pk_ams_college_tier_mm  * 15.666032762
                    ;
                    AMStudent_mod_4M := 100 * (exp(AMStudent_mod_4M_a )) / (1+exp(AMStudent_mod_4M_a ));


                    Distance_mod2_4M_a := -3.517115275
                                 + pk_dist_a1toa3_mm  * 13.396267277
                    ;
                    Distance_mod2_4M := 100 * (exp(Distance_mod2_4M_a )) / (1+exp(Distance_mod2_4M_a ));


                    LRes_mod_4M_a := -6.97672497
                                 + pk_add1_lres_mm  * 10.137339662
                                 + pk_add2_lres_mm  * 14.509667711
                                 + pk_add3_lres_mm  * 13.276253404
                                 + pk_add_lres_year_avg2_mm  * 10.487127305
                                 + pk_add_lres_year_max2_mm  * 9.2921534624
                    ;
                    LRes_mod_4M := 100 * (exp(LRes_mod_4M_a )) / (1+exp(LRes_mod_4M_a ));


                    Velocity2_mod_4M_a := -9.850557458
                                 + pk_ssns_per_adl_mm  * 12.677283036
                                 + pk_addrs_per_adl_mm  * 11.682057545
                                 + pk_adls_per_addr_mm  * 7.8742383562
                                 + pk_phones_per_addr_mm  * 7.3143238581
                                 + pk_adls_per_phone_mm  * 11.347959602
                                 + pk_ssns_per_addr_c6_mm  * 16.090542317
                                 + pk_phones_per_addr_c6_mm  * 6.4262166528
                                 + pk_attr_addrs_last_level_mm  * 12.80146951
                                 + pk_ssns_per_addr2_mm  * 7.1950216698
                    ;
                    Velocity2_mod_4M := 100 * (exp(Velocity2_mod_4M_a )) / (1+exp(Velocity2_mod_4M_a ));


                    Relative_mod_4M_a := -3.460346435
                                 + pk_rel_count_mm  * 16.153551773
                                 + pk_rel_felony_count_mm  * 12.081696238
                                 + pk_crim_rel_within100miles_mm  * -139.8902434
                                 + pk_crim_rel_withinOther_mm  * 16.272847016
                                 + pk_rel_prop_sold_prch_tot2_mm  * 10.380718683
                                 + pk_rel_within25miles_count_mm  * 13.253212342
                                 + pk_rel_incomeunder25_count_mm  * 13.07621738
                                 + pk_rel_incomeunder50_count_mm  * 11.761249997
                                 + pk_rel_incomeunder100_count_mm  * 8.2772744829
                                 + pk_rel_educationunder12_count_mm  * 8.8115114804
                                 + pk_rel_educationover12_count_mm  * 14.392289092
                                 + pk_rel_vehicle_owned_count_mm  * 14.481828175
                                 + pk_rel_count_addr_mm  * 13.186954813
                    ;
                    Relative_mod_4M := 100 * (exp(Relative_mod_4M_a )) / (1+exp(Relative_mod_4M_a ));



                    if (   add1_isbestmatch ) then /* Address 1 is Best Match     */


                              Utility_best_mod_4M_a := -18.52641901
                                           + util_add1_N  * 0.9312640507
                                           + util_add2_I  * -0.233811459
                                           + pk_util_adl_nap_mm  * 53.26890085
                                           + pk_util_add1_source_count_mm  * 19.271218145
                                           + pk_rc_utiliaddr_phonecount_mm  * 35.314352097
                                           + pk_yr_util_adl_E_firstseen2_mm  * 14.833412497
                                           + pk_yr_util_adl_F_firstseen2_mm  * 9.2494908432
                                           + pk_yr_util_adl_I_firstseen2_mm  * 12.333731883
                                           + pk_yr_util_adl_U_firstseen2_mm  * 8.9862241118
                                           + pk_yr_util_add1_F_firstseen2_mm  * 10.532625779
                                           + pk_yr_util_add1_U_firstseen2_mm  * 6.4759905194
                                           + pk_yr_util_add1_Z_firstseen2_mm  * 11.642680031
                                           + pk_yr_util_add2_E_firstseen2_mm  * 15.442965967
                              ;
                              Utility_best_mod_4M := 100 * (exp(Utility_best_mod_4M_a )) / (1+exp(Utility_best_mod_4M_a ));
                              Utility_mod_4M := Utility_best_mod_4M;


                              ver_best_src_time_mod2_4M_a := -6.17788878
                                           + pk_yrmo_adl_f_sn_mx_fcra2_mm  * 10.260632136
                                           + pk_yr_gong_did_first_seen2_mm  * 8.1182593672
                                           + pk_yr_infutor_first_seen2_mm  * 12.276026794
                                           + pk_yr_adl_EN_first_seen2_mm  * 14.04320234
                              ;
                              ver_best_src_time_mod2_4M := 100 * (exp(ver_best_src_time_mod2_4M_a )) / (1+exp(ver_best_src_time_mod2_4M_a ));

                              ver_best_src_cnt_mod2_4M_a := -8.768074284
                                           + pk_em_count_mm  * 11.596871116
                                           + pk_voter_flag_mm  * 11.498510468
                                           + pk_lname_eda_sourced_type_lvl_mm  * 6.8218625532
                                           + pk_add2_EM_ver_lvl_mm  * 18.60737405
                                           + pk_infutor_risk_lvl_mm  * 10.98533024
                                           + pk_nap_summary_mm  * 3.1054540874
                                           + pk_attr_num_nonderogs90_b_mm  * 11.298030553
                                           + pk_nap_type_mm  * 4.9611939781
                                           + source_tot_EQ  * -0.362381022
                                           + source_tot_PL  * 0.2591210344
                                           + source_add_NT  * -0.528172989
                                           + source_add2_EB  * 1.1094844615
                                           + source_add2_NT  * 0.4966335864
                              ;
                              ver_best_src_cnt_mod2_4M := 100 * (exp(ver_best_src_cnt_mod2_4M_a )) / (1+exp(ver_best_src_cnt_mod2_4M_a ));

                              ver_src_time_mod2_4M := ver_best_src_time_mod2_4M;
                              ver_src_cnt_mod2_4M := ver_best_src_cnt_mod2_4M;


                    else /* Address 1 is Not Best Match */


                              Utility_notbest_mod_4M_a := -10.15633451
                                           + util_add2_T  * 2.0734639888
                                           + pk_util_add1_source_count_mm  * 18.825809359
                                           + pk_util_add2_source_count_mm  * 16.658635309
                                           + pk_yr_util_adl_E_firstseen2_mm  * 13.329928921
                                           + pk_yr_util_adl_F_firstseen2_mm  * 10.665763535
                                           + pk_yr_util_adl_U_firstseen2_mm  * 9.8726962864
                                           + pk_yr_util_add1_F_firstseen2_mm  * 17.85230623
                                           + pk_yr_util_add1_I_firstseen2_mm  * 15.664680753
                                           + pk_yr_util_add1_U_firstseen2_mm  * 11.70598517
                                           + pk_yr_util_add1_Z_firstseen2_mm  * 26.386875441
                                           + pk_mx_yr_util_add1_firstseen2_mm  * -29.64246869
                              ;
                              Utility_notbest_mod_4M := 100 * (exp(Utility_notbest_mod_4M_a )) / (1+exp(Utility_notbest_mod_4M_a ));
                              Utility_mod_4M := Utility_notbest_mod_4M;


                              ver_notbest_src_time_mod2_4M_a := -11.45579032
                                           + pk_yr_adl_em_first_seen2_mm  * 16.329333555
                                           + pk_yr_adl_vo_first_seen2_mm  * 12.762817227
                                           + pk_yr_gong_did_first_seen2_mm  * 11.457000114
                                           + pk_yr_header_first_seen2_mm  * 15.163642314
                                           + pk_yr_infutor_first_seen2_mm  * 15.537947187
                                           + pk_yrmo_adl_f_sn_mx_fcra2_mm  * 13.392242865
                                           + pk_yr_lname_change_date2_mm  * 11.261695218
                                           + pk_yr_adl_EN_first_seen2_mm  * 13.715546869
                                           + pk_yr_adl_DL_first_seen2_mm  * 20.535595196
                              ;
                              ver_notbest_src_time_mod2_4M := 100 * (exp(ver_notbest_src_time_mod2_4M_a )) / (1+exp(ver_notbest_src_time_mod2_4M_a ));

                              ver_notbest_src_cnt_mod2_4M_a := -9.764842201
                                           + pk_eq_count_mm  * 16.810373044
                                           + pk_lname_eda_sourced_type_lvl_mm  * 10.011257087
                                           + pk_EM_Only_ver_lvl_mm  * 14.212022179
                                           + pk_infutor_risk_lvl_nb_mm  * 13.923917454
                                           + pk_attr_num_nonderogs90_b_mm  * 9.2986939041
                                           + pk_EN_count_mm  * 19.857864947
                                           + pk_DL_count_mm  * 20.358187966
                              ;
                              ver_notbest_src_cnt_mod2_4M := 100 * (exp(ver_notbest_src_cnt_mod2_4M_a )) / (1+exp(ver_notbest_src_cnt_mod2_4M_a ));

                              ver_src_time_mod2_4M := ver_notbest_src_time_mod2_4M;
                              ver_src_cnt_mod2_4M := ver_notbest_src_cnt_mod2_4M;


                    end;


                    Property_mod2_4M_a := -30.11890031
                                 + pk_attr_num_sold60  * -0.19105911
                                 + pk_yr_adl_pr_first_seen2_mm  * 11.191323839
                                 + pk_yr_adl_w_first_seen2_mm  * 21.999972732
                                 + pk_naprop_level2_mm  * 13.115993324
                                 + pk_yr_add1_built_date2_mm  * 11.007908948
                                 + pk_add1_assessed_amount2_mm  * 8.926874674
                                 + pk_yr_add1_date_first_seen2_mm  * 16.703744872
                                 + pk_add1_building_area2_mm  * 9.7216362737
                                 + pk_add1_no_of_buildings_mm  * 23.703712543
                                 + pk_add1_no_of_rooms_mm  * 7.5026987831
                                 + pk_add1_style_code_level_mm  * 12.400347799
                                 + pk_prop_owned_assess_count_mm  * 22.871466277
                                 + pk_prop1_prev_purchase_price2_mm  * 16.059483833
                                 + pk_yr_prop2_sale_date2_mm  * 9.5958862015
                                 + pk_add2_garage_type_risk_lvl_mm  * 11.756485536
                                 + pk_add2_style_code_level_mm  * 15.126808686
                                 + pk_yr_add2_built_date2_mm  * 10.425511365
                                 + pk_add2_purchase_amount2_mm  * 44.3940699
                                 + pk_yr_add2_date_first_seen2_mm  * 9.99720228
                                 + pk_add3_mortgage_risk_mm  * 13.045245577
                                 + pk_add3_assessed_amount2_mm  * 14.65583069
                                 + pk_yr_add3_date_first_seen2_mm  * 12.147882569
                                 + pk_yr_attr_dt_last_purch2_mm  * 12.918220521
                                 + pk_attr_num_watercraft24_mm  * 12.210103861
                                 + pk_current_count_mm  * 13.703196593
                    ;
                    Property_mod2_4M := 100 * (exp(Property_mod2_4M_a )) / (1+exp(Property_mod2_4M_a ));

							 /* Insert Version Excluding Utility Model             2/22/2013 PK */
                    mod18_4M_NoUtil_a := -8.688624189
                                 + FP_mod5_4M  * 0.0561170974
                                 + LRes_mod_4M  * 0.0626461029
                                 + AMStudent_mod_4M  * 0.102766193
                                 + Distance_mod2_4M  * 0.1288752495
                                 + Velocity2_mod_4M  * 0.0282106577
                                 + Age_mod3_4M  * 0.0650020311
                                 + Relative_mod_4M  * 0.058832891
                                 + Property_mod2_4M  * 0.0772251632
                                 + ver_src_cnt_mod2_4M  * 0.051812492
                                 + ver_src_time_mod2_4M  * 0.035302828
                                 + pk_estimated_income_mm  * 6.6770588649
                                 + pk_out_st_division_lvl_mm  * 7.9788293994
                                 + rc82  * -0.30468292
                                 + pk_Repl_Addr_Matches_Input_m  * -14.24406138
                                 + pk_Parent_Phone_Recent_m  * 11.089889342
                                 + pk_Pos_Work_Source_Flag_m  * 9.8837669529
                                 + pk_years_ah_add1_first_seen2_m  * -11.82981766
                    ;
                    mod18_4M_NoUtil := (exp(mod18_4M_NoUtil_a )) / (1+exp(mod18_4M_NoUtil_a ));
 
 // set each of these variables in each branch that was missing them
mod18_1M_NoUtil_NoDob := 0;
mod18_2M_NoUtil_NoDob := 0;
mod18_3M_NoUtil_NoDob := 0;	
mod18_4M_NoUtil_NoDob := 0;	

mod18_1M_NoUtil_NoDob_a := 0;
mod18_2M_NoUtil_NoDob_a := 0;
mod18_3M_NoUtil_NoDob_a := 0;	
mod18_4M_NoUtil_NoDob_a := 0;	

mod18_1M_NoUtil := 0;
mod18_2M_NoUtil := 0;
mod18_3M_NoUtil := 0;	
// mod18_4M_NoUtil := 0;	

mod18_1M_NoUtil_a := 0;
mod18_2M_NoUtil_a := 0;
mod18_3M_NoUtil_a := 0;	
// mod18_4M_NoUtil_a := 0;

         /*    PK_Contact_Mod4 = 100 * mod18_4M;           Point at Model Excluding Utilities     2/22/2013 PK  */
               PK_Contact_Mod4 := 100 * mod18_4M_NoUtil;


       end;


       if ( not dobpop ) then /* NoDob Models */


            if (      pk_Segment2 = 1 ) then /* 1 EDA              */



                      /* NoDob  */

                         Age_mod3_NoDob_1M_a := -2.812369649
                                      + pk_ams_age_mm  * 1.4258572616
                                      + pk_inferred_age_mm  * 2.6399622538
                                      + pk_yr_rc_ssnhighissue2_mm  * 2.2595782762
                         ;
                         Age_mod3_NoDob_1M := 100 * (exp(Age_mod3_NoDob_1M_a )) / (1+exp(Age_mod3_NoDob_1M_a ));


                         ver_best_e_cnt_mod_1M_NoDob_a := 4.3294519368
                                      + pk_gong_did_first_ct_mm  * -30.03593693
                                      + pk_rc_phonelnamecount_mm  * -3.05791055
                                      + pk_combo_addrcount_mm  * 2.2088840951
                                      + pk_combo_hphonecount_mm  * 2.2843071594
                                      + pk_ver_phncount_mm  * 4.6787819539
                                      + pk_gong_did_phone_ct_mm  * 4.571186293
                                      + pk_combo_ssncount_mm  * 5.5187484832
                         ;
                         ver_best_e_cnt_mod_1M_NoDob := 100 * (exp(ver_best_e_cnt_mod_1M_NoDob_a )) / (1+exp(ver_best_e_cnt_mod_1M_NoDob_a ));


                         ver_notbest_e_cnt_mod_1M_NoDob_a := -7.126694691
                                      + pk_combo_lnamecount_nb_mm  * 4.2609451781
                                      + pk_combo_addrcount_nb_mm  * 5.2420680292
                                      + pk_rc_phoneaddrcount_mm  * 8.3014532207
                                      + pk_gong_did_phone_ct_nb_mm  * 5.4382844181
                         ;
                         ver_notbest_e_cnt_mod_1M_NoDob := 100 * (exp(ver_notbest_e_cnt_mod_1M_NoDob_a )) / (1+exp(ver_notbest_e_cnt_mod_1M_NoDob_a ));


ver_element_cnt_mod_1M_NoDob             := map(
                         add1_isbestmatch => ver_best_e_cnt_mod_1M_NoDob,
                         ver_notbest_e_cnt_mod_1M_NoDob
);

                    /* Insert Version Excluding Utility Model             2/22/2013 PK */
                         mod18_1M_NoUtil_NoDob_a := -15.77429969
                                      + Lien_mod_1M  * 0.0142396503
                                      + LRes_mod_1M  * -0.011952925
                                      + ProfLic_mod_1M  * 0.0272095358
                                      + Velocity2_mod_1M  * 0.0071148558
                                      + Age_mod3_NoDob_1M  * 0.0109609833
                                      + ver_element_cnt_mod_1M_NoDob  * 0.017193344
                                      + Relative_mod_1M  * 0.015959749
                                      + AVM_mod2_1M  * 0.0094793308
                                      + Property_mod2_1M  * 0.0192321103
                                      + ver_src_cnt_mod2_1M  * 0.0226196055
                                      + pk_estimated_income_mm  * 2.5709140306
                                      + pk_out_st_division_lvl_mm  * 1.4525601081
                                      + pk_Repl_Addr_Matches_Input_m  * 0.8807189709
                                      + pk_es_match_level_m  * -1.338357246
                                      + pk_Moved_Out_10yr_m  * 5.0261677384
                                      + pk_Close_Rel_28Yr_m  * 6.237629074
                                      + pk_Pos_Work_Source_Flag_m  * 3.2399696768
                                      + pk_Short_Move_Count_m  * 3.7584511499
                                      + pk_years_ah_add1_first_seen2_m  * 3.5432362471
                                      + pk_years_ah_add3_first_seen2_m  * 1.2077261208
                                      + pk_years_ah_add5_first_seen2_m  * 0.922051862
                                      + pk_Repl_Hphn_Matches_Input  * 1.9395342714
                         ;
                         mod18_1M_NoUtil_NoDob := (exp(mod18_1M_NoUtil_NoDob_a )) / (1+exp(mod18_1M_NoUtil_NoDob_a ));
 // set each of these variables in each branch that was missing them
// mod18_1M_NoUtil_NoDob := 0;
mod18_2M_NoUtil_NoDob := 0;
mod18_3M_NoUtil_NoDob := 0;	
mod18_4M_NoUtil_NoDob := 0;	

// mod18_1M_NoUtil_NoDob_a := 0;
mod18_2M_NoUtil_NoDob_a := 0;
mod18_3M_NoUtil_NoDob_a := 0;	
mod18_4M_NoUtil_NoDob_a := 0;	

mod18_1M_NoUtil := 0;
mod18_2M_NoUtil := 0;
mod18_3M_NoUtil := 0;	
mod18_4M_NoUtil := 0;	

mod18_1M_NoUtil_a := 0;
mod18_2M_NoUtil_a := 0;
mod18_3M_NoUtil_a := 0;	
mod18_4M_NoUtil_a := 0;
 
              /*    PK_Contact_Mod4 = 100 * mod18_1M_NoDob;     Point at Model Excluding Utilities     2/22/2013 PK  */
                    PK_Contact_Mod4 := 100 * mod18_1M_NoUtil_NoDob;


            elseif( pk_Segment2 = 2 ) then /* 2 SkipTrace        */
								
										/* Insert Version Excluding Utility Model             2/22/2013 PK */
                         mod18_2M_NoUtil_NoDob_a := 33.123033338
                                      + LRes_mod_2M  * -0.028300711
                                      + ProfLic_mod_2M  * 0.0727483783
                                      + Velocity2_mod_2M  * 0.0179237539
                                      + Census_mod_2M  * 0.0222296007
                                      + Derog_mod4_2M  * 0.0295486208
                                      + Property_mod2_2M  * 0.0263199786
                                      + ver_src_cnt_mod2_2M  * 0.024296877
                                      + ver_src_time_mod2_2M  * 0.0143999971
                                      + pk_estimated_income_mm  * 2.0826856166
                                      + pk_out_st_division_lvl_mm  * 3.0226518778
                                      + pk_Repl_Addr_Matches_Input_m  * 3.6154496194
                                      + pk_Repl_Phn_Matches_Input_m  * 4.8379788595
                                      + pk_se_phone_stability_flag_m  * 4.6082118421
                                      + pk_Stable_Neighbor_Phone_Flag_m  * -221.3990417
                                      + pk_PP_Disconnect_Count_m  * 2.0314237734
                                      + pk_Pos_Work_Source_Flag_m  * 4.8919837313
                                      + pk_years_ah_add2_first_seen2_m  * -2.456220281
                         ;
                         mod18_2M_NoUtil_NoDob := (exp(mod18_2M_NoUtil_NoDob_a )) / (1+exp(mod18_2M_NoUtil_NoDob_a ));
 // set each of these variables in each branch that was missing them
mod18_1M_NoUtil_NoDob := 0;
// mod18_2M_NoUtil_NoDob := 0;
mod18_3M_NoUtil_NoDob := 0;	
mod18_4M_NoUtil_NoDob := 0;	

mod18_1M_NoUtil_NoDob_a := 0;
// mod18_2M_NoUtil_NoDob_a := 0;
mod18_3M_NoUtil_NoDob_a := 0;	
mod18_4M_NoUtil_NoDob_a := 0;	

mod18_1M_NoUtil := 0;
mod18_2M_NoUtil := 0;
mod18_3M_NoUtil := 0;	
mod18_4M_NoUtil := 0;	

mod18_1M_NoUtil_a := 0;
mod18_2M_NoUtil_a := 0;
mod18_3M_NoUtil_a := 0;	
mod18_4M_NoUtil_a := 0;
 
              /*    PK_Contact_Mod4 = 100 * mod18_2M_NoDob;     Point at Model Excluding Utilities     2/22/2013 PK  */
                    PK_Contact_Mod4 := 100 * mod18_2M_NoUtil_NoDob;



            elseif( pk_Segment2 = 3 ) then /* 3 Mid              */



                      /* NoDob  */

                         Age_mod3_NoDob_3M_a := -5.640201514
                                      + pk_ams_age_mm  * 14.716492154
                                      + pk_inferred_age_mm  * 8.5279687405
                                      + pk_yr_rc_ssnhighissue2_mm  * 9.0111896835
                         ;
                         Age_mod3_NoDob_3M := 100 * (exp(Age_mod3_NoDob_3M_a )) / (1+exp(Age_mod3_NoDob_3M_a ));

                         SSNProb2_mod_3M_NoDob_a := -3.241912439
                                      + pk_ssnchar_invalid_or_recent_mm  * 10.472775835
                                      + (integer)pk_ssn_prob_nodob  * -0.224343639
                         ;
                         SSNProb2_mod_3M_NoDob := 100 * (exp(SSNProb2_mod_3M_NoDob_a )) / (1+exp(SSNProb2_mod_3M_NoDob_a ));

                         FP_mod5_3M_NoDob_a := -6.960553757
                                      + AddProb3_mod_3M  * 0.1123082104
                                      + PhnProb_mod_3M  * 0.1056861681
                                      + SSNProb2_mod_3M_NoDob  * 0.1111690329
                                      + pk_rc_disthphoneaddr_mm  * 10.978699273
                         ;
                         FP_mod5_3M_NoDob := 100 * (exp(FP_mod5_3M_NoDob_a )) / (1+exp(FP_mod5_3M_NoDob_a ));


                         ver_best_score_mod_3M_NoDob_a := -3.446483983
                                      + pk_combo_fnamescore  * -1.030021895
                                      + pk_rc_dirsaddr_lastscore_mm  * 10.412107794
                                      + pk_combo_hphonescore_mm  * 10.836968359
                         ;
                         ver_best_score_mod_3M_NoDob := 100 * (exp(ver_best_score_mod_3M_NoDob_a )) / (1+exp(ver_best_score_mod_3M_NoDob_a ));


                         ver_notbest_score_mod_3M_NoDob_a := -6.334358888
                                      + pk_rc_dirsaddr_lastscore_mm  * 11.893857762
                                      + pk_combo_hphonescore_mm  * 18.1566789
                                      + pk_add1_address_score_mm  * 11.058976846
                         ;
                         ver_notbest_score_mod_3M_NoDob := 100 * (exp(ver_notbest_score_mod_3M_NoDob_a )) / (1+exp(ver_notbest_score_mod_3M_NoDob_a ));


ver_score_mod_3M_NoDob                   := map(
                         add1_isbestmatch => ver_best_score_mod_3M_NoDob,
                         ver_notbest_score_mod_3M_NoDob
);
									
										/* Insert Version Excluding Utility Model             2/22/2013 PK */
                         mod18_3M_NoUtil_NoDob_a := -23.0216765
                                      + FP_mod5_3M_NoDob  * 0.0507594543
                                      + LRes_mod_3M  * 0.0211296528
                                      + AMStudent_mod_3M  * 0.0509723344
                                      + ProfLic_mod_3M  * 0.0442618454
                                      + Velocity2_mod_3M  * 0.0505814562
                                      + Age_mod3_NoDob_3M  * 0.0370557739
                                      + ver_score_mod_3M_NoDob  * 0.0294279488
                                      + Relative_mod_3M  * 0.0454718607
                                      + Derog_mod4_3M  * 0.0678611496
                                      + Property_mod2_3M  * 0.0414227721
                                      + ver_src_cnt_mod2_3M  * 0.0275598932
                                      + ver_src_time_mod2_3M  * 0.0397705211
                                      + pk_did0  * 0.2502238889
                                      + pk_impulse_count_mm  * 14.563846889
                                      + pk_out_st_division_lvl_mm  * 3.1725171002
                                      + pk_waterfall_phone_count2_m  * 14.278824824
                                      + pk_Repl_Addr_Matches_Input_m  * 10.453838272
                                      + pk_Repl_Phn_Matches_Input_m  * 10.867538883
                                      + pk_yr_ap1_phn_fseen_3_m  * 27.724022898
                                      + pk_sp_dist_0_m  * 7.6887279889
                                      + pk_years_sp_first_seen_19yr_m  * 8.0310436655
                                      + pk_Lived_With_Parents_3yr_m  * 6.0414239713
                                      + pk_Close_Rel_Living_With_Flag_m  * 8.3078050323
                                      + pk_PP_Disconnect_Count_m  * 10.021374933
                                      + pk_PP_Recent_LSeen_Phone_Index_m  * 8.9604901503
                                      + pk_Pos_Work_Source_Flag_m  * 3.3727438802
                                      + pk_WK_Recent_Phone_m  * 4.8410326899
                         ;
                         mod18_3M_NoUtil_NoDob := (exp(mod18_3M_NoUtil_NoDob_a )) / (1+exp(mod18_3M_NoUtil_NoDob_a ));
 // set each of these variables in each branch that was missing them
mod18_1M_NoUtil_NoDob := 0;
mod18_2M_NoUtil_NoDob := 0;
// mod18_3M_NoUtil_NoDob := 0;	
mod18_4M_NoUtil_NoDob := 0;	

mod18_1M_NoUtil_NoDob_a := 0;
mod18_2M_NoUtil_NoDob_a := 0;
// mod18_3M_NoUtil_NoDob_a := 0;	
mod18_4M_NoUtil_NoDob_a := 0;	

mod18_1M_NoUtil := 0;
mod18_2M_NoUtil := 0;
mod18_3M_NoUtil := 0;	
mod18_4M_NoUtil := 0;	

mod18_1M_NoUtil_a := 0;
mod18_2M_NoUtil_a := 0;
mod18_3M_NoUtil_a := 0;	
mod18_4M_NoUtil_a := 0;
 
              /*    PK_Contact_Mod4 = 100 * mod18_3M_NoDob;     Point at Model Excluding Utilities     2/22/2013 PK  */
                    PK_Contact_Mod4 := 100 * mod18_3M_NoUtil_NoDob;



            // elseif( pk_Segment2 = 4 ) then /* 4 Unassigned       */
			else



                      /* NoDob  */

                         Age_mod3_NoDob_4M_a := -4.281789096
                                      + pk_inferred_age_mm  * 11.414076784
                                      + pk_yr_rc_ssnhighissue2_mm  * 11.702460055
                         ;
                         Age_mod3_NoDob_4M := 100 * (exp(Age_mod3_NoDob_4M_a )) / (1+exp(Age_mod3_NoDob_4M_a ));

                         SSNProb2_mod_4M_NoDob_a := -3.671270906
                                      + pk_ssnchar_invalid_or_recent_mm  * 15.343832989
                         ;
                         SSNProb2_mod_4M_NoDob := 100 * (exp(SSNProb2_mod_4M_NoDob_a )) / (1+exp(SSNProb2_mod_4M_NoDob_a ));

                         FP_mod5_4M_NoDob_a := -6.079445587
                                      + AddProb3_mod_4M  * 0.0903131656
                                      + PhnProb_mod_4M  * 0.1041224873
                                      + SSNProb2_mod_4M_NoDob  * 0.1435983167
                                      + pk_rc_disthphoneaddr_mm  * 9.45496861
                         ;
                         FP_mod5_4M_NoDob := 100 * (exp(FP_mod5_4M_NoDob_a )) / (1+exp(FP_mod5_4M_NoDob_a ));
									
             /* Insert Version Excluding Utility Model             2/22/2013 PK */
                         mod18_4M_NoUtil_NoDob_a := -8.728091357
                                      + FP_mod5_4M_NoDob  * 0.0554996492
                                      + LRes_mod_4M  * 0.0615910607
                                      + AMStudent_mod_4M  * 0.1034429704
                                      + Distance_mod2_4M  * 0.1305619465
                                      + Velocity2_mod_4M  * 0.028570964
                                      + Age_mod3_NoDob_4M  * 0.0680832152
                                      + Relative_mod_4M  * 0.0583537288
                                      + Property_mod2_4M  * 0.0771512848
                                      + ver_src_cnt_mod2_4M  * 0.0519705921
                                      + ver_src_time_mod2_4M  * 0.0354553136
                                      + pk_estimated_income_mm  * 6.6295257407
                                      + pk_out_st_division_lvl_mm  * 7.9079405656
                                      + rc82  * -0.305807197
                                      + pk_Repl_Addr_Matches_Input_m  * -14.27382982
                                      + pk_Parent_Phone_Recent_m  * 11.330183888
                                      + pk_Pos_Work_Source_Flag_m  * 10.114323561
                                      + pk_years_ah_add1_first_seen2_m  * -12.01495753
                         ;
                         mod18_4M_NoUtil_NoDob := (exp(mod18_4M_NoUtil_NoDob_a )) / (1+exp(mod18_4M_NoUtil_NoDob_a ));
												 
 // set each of these variables in each branch that was missing them
mod18_1M_NoUtil_NoDob := 0;
mod18_2M_NoUtil_NoDob := 0;
mod18_3M_NoUtil_NoDob := 0;	
// mod18_4M_NoUtil_NoDob := 0;	

mod18_1M_NoUtil_NoDob_a := 0;
mod18_2M_NoUtil_NoDob_a := 0;
mod18_3M_NoUtil_NoDob_a := 0;	
// mod18_4M_NoUtil_NoDob_a := 0;	

mod18_1M_NoUtil := 0;
mod18_2M_NoUtil := 0;
mod18_3M_NoUtil := 0;	
mod18_4M_NoUtil := 0;	

mod18_1M_NoUtil_a := 0;
mod18_2M_NoUtil_a := 0;
mod18_3M_NoUtil_a := 0;	
mod18_4M_NoUtil_a := 0;
 
              /*    PK_Contact_Mod4 = 100 * mod18_4M_NoDob;     Point at Model Excluding Utilities     2/22/2013 PK  */
                    PK_Contact_Mod4 := 100 * mod18_4M_NoUtil_NoDob;


            end;


       end;


    /* Apply Transformation */


		phat := ( PK_Contact_Mod4     / 100 );

		PK_Contact_Mod4_Scr := round(50*(log(phat/(1-phat)) - log(.126/.874))/log(2) + 700);

		CSN1007 := 1 * PK_Contact_Mod4_Scr;
		CSN1007_2 := map(
			CSN1007 < 300 => 300,
			CSN1007 > 999 => 999,
			CSN1007
		);



		self.seq := le.seq;
		#if(CSN_DEBUG)
			self.es_phone10  := es_phone10;
			self.se1_phone10  := se1_phone10;
			self.se2_phone10  := se2_phone10;
			self.se3_phone10  := se3_phone10;
			self.se4_phone10  := se4_phone10;
			self.ap1_phone10  := ap1_phone10;
			self.ap2_phone10  := ap2_phone10;
			self.ap3_phone10  := ap3_phone10;
			self.sx1_phone10  := sx1_phone10;
			self.sx2_phone10  := sx2_phone10;
			self.sp_phone10  := sp_phone10;
			self.md1_phone10  := md1_phone10;
			self.md2_phone10  := md2_phone10;
			self.cl1_phone10  := cl1_phone10;
			self.cl2_phone10  := cl2_phone10;
			self.cl3_phone10  := cl3_phone10;
			self.cr_phone10  := cr_phone10;
			self.ne1_phone10  := ne1_phone10;
			self.ne2_phone10  := ne2_phone10;
			self.ne3_phone10  := ne3_phone10;
			self.pp1_phone10  := pp1_phone10;
			self.pp2_phone10  := pp2_phone10;
			self.pp3_phone10  := pp3_phone10;
			self.wk_phone10  := wk_phone10;
			self.es_eda_did  := es_eda_did;
			self.se1_phone_first_seen  := se1_phone_first_seen;
			self.se2_phone_first_seen  := se2_phone_first_seen;
			self.se3_phone_first_seen  := se3_phone_first_seen;
			self.se4_phone_first_seen  := se4_phone_first_seen;
			self.ap1_phone_first_seen  := ap1_phone_first_seen;
			self.sp_first_seen  := sp_first_seen;
			self.md1_phone_first_seen  := md1_phone_first_seen;
			self.cl1_first_seen  := cl1_first_seen;
			self.cl2_first_seen  := cl2_first_seen;
			self.cl3_first_seen  := cl3_first_seen;
			self.ne1_phone_first_seen  := ne1_phone_first_seen;
			self.ne2_phone_first_seen  := ne2_phone_first_seen;
			self.ne3_phone_first_seen  := ne3_phone_first_seen;
			self.pp1_phone_last_seen  := pp1_phone_last_seen;
			self.pp2_phone_last_seen  := pp2_phone_last_seen;
			self.pp3_phone_last_seen  := pp3_phone_last_seen;
			self.wk_phone_first_seen  := wk_phone_first_seen;
			self.ah_add1_first_seen  := ah_add1_first_seen;
			self.ah_add2_first_seen  := ah_add2_first_seen;
			self.ah_add3_first_seen  := ah_add3_first_seen;
			self.ah_add5_first_seen  := ah_add5_first_seen;
			self.md1_mo_shared_addr  := md1_mo_shared_addr;
			self.md2_mo_shared_addr  := md2_mo_shared_addr;
			self.md1_mo_since_shared_addr  := md1_mo_since_shared_addr;
			self.md2_mo_since_shared_addr  := md2_mo_since_shared_addr;
			self.cl1_mo_since_shared_addr  := cl1_mo_since_shared_addr;
			self.cl2_mo_since_shared_addr  := cl2_mo_since_shared_addr;
			self.cl3_mo_since_shared_addr  := cl3_mo_since_shared_addr;
			self.cenmatch  := cenmatch;
			self.adl_addr  := adl_addr;
			self.es_name_match_flag  := es_name_match_flag;
			self.sp_dist  := sp_dist;
			self.wk_source  := wk_source;
			self.ah_add1_dist  := ah_add1_dist;
			self.ah_add2_dist  := ah_add2_dist;
			self.ah_add3_dist  := ah_add3_dist;
			self.ah_add4_dist  := ah_add4_dist;
			self.ah_add5_dist  := ah_add5_dist;
			self.pp1_active_phone  := pp1_active_phone;
			self.pp2_active_phone  := pp2_active_phone;
			self.pp3_active_phone  := pp3_active_phone;
			self.wf_hphn  := wf_hphn;
			self.c_bargains  := c_bargains;
			self.c_bel_edu  := c_bel_edu;
			self.c_lowrent  := c_lowrent;
			self.c_med_hval  := c_med_hval;
			self.did  := did;
			self.out_unit_desig  := out_unit_desig;
			self.out_sec_range  := out_sec_range;
			self.out_st  := out_st;
			self.out_addr_type  := out_addr_type;
			self.in_phone10  := in_phone10;
			self.nas_summary  := nas_summary;
			self.nap_summary  := nap_summary;
			self.nap_type  := nap_type;
			self.nap_status  := nap_status;
			self.rc_correct_dob  := rc_correct_dob;
			self.rc_dirsaddr_lastscore  := rc_dirsaddr_lastscore;
			self.rc_name_addr_phone  := rc_name_addr_phone;
			self.rc_hriskphoneflag  := rc_hriskphoneflag;
			self.rc_hphonetypeflag  := rc_hphonetypeflag;
			self.rc_phonevalflag  := rc_phonevalflag;
			self.rc_hphonevalflag  := rc_hphonevalflag;
			self.rc_phonezipflag  := rc_phonezipflag;
			self.rc_pwphonezipflag  := rc_pwphonezipflag;
			self.rc_decsflag  := rc_decsflag;
			self.rc_ssndobflag  := rc_ssndobflag;
			self.rc_pwssndobflag  := rc_pwssndobflag;
			self.rc_ssnvalflag  := rc_ssnvalflag;
			self.rc_pwssnvalflag  := rc_pwssnvalflag;
			self.rc_ssnhighissue  := rc_ssnhighissue;
			self.rc_areacodesplitdate  := rc_areacodesplitdate;
			self.rc_dwelltype  := rc_dwelltype;
			self.rc_bansflag  := rc_bansflag;
			self.rc_phonelnamecount  := rc_phonelnamecount;
			self.rc_phoneaddrcount  := rc_phoneaddrcount;
			self.rc_utiliaddr_phonecount  := rc_utiliaddr_phonecount;
			self.rc_disthphoneaddr  := rc_disthphoneaddr;
			self.rc_phonetype  := rc_phonetype;
			self.rc_cityzipflag  := rc_cityzipflag;
			self.combo_fnamescore  := combo_fnamescore;
			self.combo_hphonescore  := combo_hphonescore;
			self.combo_dobscore  := combo_dobscore;
			self.combo_lnamecount  := combo_lnamecount;
			self.combo_addrcount  := combo_addrcount;
			self.combo_hphonecount  := combo_hphonecount;
			self.combo_ssncount  := combo_ssncount;
			self.combo_dobcount  := combo_dobcount;
			self.eq_count  := eq_count;
			self.en_count  := en_count;
			self.dl_count  := dl_count;
			self.em_count  := em_count;
			self.vo_count  := vo_count;
			self.em_only_count  := em_only_count;
			self.adl_eq_first_seen  := adl_eq_first_seen;
			self.adl_en_first_seen  := adl_en_first_seen;
			self.adl_dl_first_seen  := adl_dl_first_seen;
			self.adl_pr_first_seen  := adl_pr_first_seen;
			self.adl_em_first_seen  := adl_em_first_seen;
			self.adl_vo_first_seen  := adl_vo_first_seen;
			self.adl_em_only_first_seen  := adl_em_only_first_seen;
			self.adl_w_first_seen  := adl_w_first_seen;
			self.adl_pr_last_seen  := adl_pr_last_seen;
			self.adl_w_last_seen  := adl_w_last_seen;
			self.em_only_sources  := em_only_sources;
			self.dl_avail  := dl_avail;
			self.voter_avail  := voter_avail;
			self.dobpop  := dobpop;
			self.lname_change_date  := lname_change_date;
			self.fname_eda_sourced_type  := fname_eda_sourced_type;
			self.lname_eda_sourced_type  := lname_eda_sourced_type;
			self.util_adl_count  := util_adl_count;
			self.util_adl_nap  := util_adl_nap;
			self.util_add2_nap  := util_add2_nap;
			self.add1_address_score  := add1_address_score;
			self.add1_isbestmatch  := add1_isbestmatch;
			self.add1_unit_count  := add1_unit_count;
			self.add1_lres  := add1_lres;
			self.add1_avm_recording_date  := add1_avm_recording_date;
			self.add1_avm_assessed_value_year  := add1_avm_assessed_value_year;
			self.add1_avm_sales_price  := add1_avm_sales_price;
			self.add1_avm_tax_assessed_valuation  := add1_avm_tax_assessed_valuation;
			self.add1_avm_price_index_valuation  := add1_avm_price_index_valuation;
			self.add1_avm_automated_valuation  := add1_avm_automated_valuation;
			self.add1_avm_med_fips  := add1_avm_med_fips;
			self.add1_avm_med_geo11  := add1_avm_med_geo11;
			self.add1_avm_med_geo12  := add1_avm_med_geo12;
			self.add1_fc_index_fips  := add1_fc_index_fips;
			self.add1_fc_index_geo11  := add1_fc_index_geo11;
			self.add1_fc_index_geo12  := add1_fc_index_geo12;
			self.add1_eda_sourced  := add1_eda_sourced;
			self.add1_applicant_owned  := add1_applicant_owned;
			self.add1_occupant_owned  := add1_occupant_owned;
			self.add1_family_owned  := add1_family_owned;
			self.add1_naprop  := add1_naprop;
			self.add1_built_date  := add1_built_date;
			self.add1_purchase_amount  := add1_purchase_amount;
			self.add1_mortgage_date  := add1_mortgage_date;
			self.add1_mortgage_type  := add1_mortgage_type;
			self.add1_mortgage_due_date  := add1_mortgage_due_date;
			self.add1_assessed_amount  := add1_assessed_amount;
			self.add1_date_first_seen  := add1_date_first_seen;
			self.add1_building_area  := add1_building_area;
			self.add1_no_of_buildings  := add1_no_of_buildings;
			self.add1_no_of_rooms  := add1_no_of_rooms;
			self.add1_no_of_baths  := add1_no_of_baths;
			self.add1_parking_no_of_cars  := add1_parking_no_of_cars;
			self.add1_style_code  := add1_style_code;
			self.add1_assessed_value_year  := add1_assessed_value_year;
			self.add1_pop  := add1_pop;
			self.property_owned_total  := property_owned_total;
			self.property_owned_assessed_count  := property_owned_assessed_count;
			self.property_sold_total  := property_sold_total;
			self.prop1_sale_price  := prop1_sale_price;
			self.prop1_prev_purchase_price  := prop1_prev_purchase_price;
			self.prop1_prev_purchase_date  := prop1_prev_purchase_date;
			self.prop2_sale_date  := prop2_sale_date;
			self.prop2_prev_purchase_date  := prop2_prev_purchase_date;
			self.dist_a1toa3  := dist_a1toa3;
			self.add2_lres  := add2_lres;
			self.add2_avm_automated_valuation  := add2_avm_automated_valuation;
			self.add2_avm_automated_valuation_4  := add2_avm_automated_valuation_4;
			self.add2_avm_med_fips  := add2_avm_med_fips;
			self.add2_avm_med_geo11  := add2_avm_med_geo11;
			self.add2_avm_med_geo12  := add2_avm_med_geo12;
			self.add2_sources  := add2_sources;
			self.add2_applicant_owned  := add2_applicant_owned;
			self.add2_family_owned  := add2_family_owned;
			self.add2_naprop  := add2_naprop;
			self.add2_land_use_code  := add2_land_use_code;
			self.add2_no_of_buildings  := add2_no_of_buildings;
			self.add2_no_of_stories  := add2_no_of_stories;
			self.add2_no_of_baths  := add2_no_of_baths;
			self.add2_garage_type_code  := add2_garage_type_code;
			self.add2_style_code  := add2_style_code;
			self.add2_assessed_value_year  := add2_assessed_value_year;
			self.add2_built_date  := add2_built_date;
			self.add2_purchase_amount  := add2_purchase_amount;
			self.add2_mortgage_amount  := add2_mortgage_amount;
			self.add2_mortgage_type  := add2_mortgage_type;
			self.add2_financing_type  := add2_financing_type;
			self.add2_mortgage_due_date  := add2_mortgage_due_date;
			self.add2_assessed_amount  := add2_assessed_amount;
			self.add2_date_first_seen  := add2_date_first_seen;
			self.add2_date_last_seen  := add2_date_last_seen;
			self.add2_pop  := add2_pop;
			self.add3_lres  := add3_lres;
			self.add3_sources  := add3_sources;
			self.add3_applicant_owned  := add3_applicant_owned;
			self.add3_family_owned  := add3_family_owned;
			self.add3_naprop  := add3_naprop;
			self.add3_built_date  := add3_built_date;
			self.add3_purchase_amount  := add3_purchase_amount;
			self.add3_mortgage_date  := add3_mortgage_date;
			self.add3_mortgage_type  := add3_mortgage_type;
			self.add3_financing_type  := add3_financing_type;
			self.add3_mortgage_due_date  := add3_mortgage_due_date;
			self.add3_assessed_amount  := add3_assessed_amount;
			self.add3_date_first_seen  := add3_date_first_seen;
			self.add3_date_last_seen  := add3_date_last_seen;
			self.add3_pop  := add3_pop;
			self.avg_lres  := avg_lres;
			self.addrs_5yr  := addrs_5yr;
			self.addrs_10yr  := addrs_10yr;
			self.addrs_prison_history  := addrs_prison_history;
			self.gong_did_first_seen  := gong_did_first_seen;
			self.gong_did_phone_ct  := gong_did_phone_ct;
			self.gong_did_first_ct  := gong_did_first_ct;
			self.nameperssn_count  := nameperssn_count;
			self.credit_first_seen  := credit_first_seen;
			self.header_first_seen  := header_first_seen;
			self.utility_sourced  := utility_sourced;
			self.inputssncharflag  := inputssncharflag;
			self.ssns_per_adl  := ssns_per_adl;
			self.addrs_per_adl  := addrs_per_adl;
			self.phones_per_adl  := phones_per_adl;
			self.addrs_per_ssn  := addrs_per_ssn;
			self.adls_per_addr  := adls_per_addr;
			self.ssns_per_addr  := ssns_per_addr;
			self.phones_per_addr  := phones_per_addr;
			self.adls_per_phone  := adls_per_phone;
			self.addrs_per_adl_c6  := addrs_per_adl_c6;
			self.phones_per_adl_c6  := phones_per_adl_c6;
			self.addrs_per_ssn_c6  := addrs_per_ssn_c6;
			self.adls_per_addr_c6  := adls_per_addr_c6;
			self.ssns_per_addr_c6  := ssns_per_addr_c6;
			self.phones_per_addr_c6  := phones_per_addr_c6;
			self.adls_per_phone_c6  := adls_per_phone_c6;
			self.invalid_addrs_per_adl_c6  := invalid_addrs_per_adl_c6;
			self.infutor_first_seen  := infutor_first_seen;
			self.infutor_nap  := infutor_nap;
			self.impulse_count  := impulse_count;
			self.attr_addrs_last30  := attr_addrs_last30;
			self.attr_addrs_last90  := attr_addrs_last90;
			self.attr_addrs_last12  := attr_addrs_last12;
			self.attr_addrs_last24  := attr_addrs_last24;
			self.attr_addrs_last36  := attr_addrs_last36;
			self.attr_date_last_purchase  := attr_date_last_purchase;
			self.attr_num_purchase180  := attr_num_purchase180;
			self.attr_date_last_sale  := attr_date_last_sale;
			self.attr_num_sold60  := attr_num_sold60;
			self.attr_num_watercraft90  := attr_num_watercraft90;
			self.attr_num_watercraft180  := attr_num_watercraft180;
			self.attr_num_watercraft24  := attr_num_watercraft24;
			self.attr_total_number_derogs  := attr_total_number_derogs;
			self.attr_felonies12  := attr_felonies12;
			self.attr_felonies24  := attr_felonies24;
			self.attr_felonies36  := attr_felonies36;
			self.attr_felonies60  := attr_felonies60;
			self.attr_arrests24  := attr_arrests24;
			self.attr_eviction_count  := attr_eviction_count;
			self.attr_date_last_eviction  := attr_date_last_eviction;
			self.attr_eviction_count30  := attr_eviction_count30;
			self.attr_eviction_count90  := attr_eviction_count90;
			self.attr_eviction_count180  := attr_eviction_count180;
			self.attr_eviction_count12  := attr_eviction_count12;
			self.attr_eviction_count24  := attr_eviction_count24;
			self.attr_eviction_count36  := attr_eviction_count36;
			self.attr_eviction_count60  := attr_eviction_count60;
			self.attr_num_nonderogs90  := attr_num_nonderogs90;
			self.attr_num_proflic90  := attr_num_proflic90;
			self.attr_num_proflic_exp30  := attr_num_proflic_exp30;
			self.bankrupt  := bankrupt;
			self.filing_type  := filing_type;
			self.disposition  := disposition;
			self.filing_count  := filing_count;
			self.bk_recent_count  := bk_recent_count;
			self.bk_disposed_historical_count  := bk_disposed_historical_count;
			self.liens_recent_unreleased_count  := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct  := liens_historical_unreleased_ct;
			self.liens_unrel_cj_ct  := liens_unrel_cj_ct;
			self.liens_unrel_cj_first_seen  := liens_unrel_cj_first_seen;
			self.liens_unrel_ft_ct  := liens_unrel_ft_ct;
			self.liens_unrel_lt_ct  := liens_unrel_lt_ct;
			self.liens_unrel_lt_first_seen  := liens_unrel_lt_first_seen;
			self.liens_unrel_o_ct  := liens_unrel_o_ct;
			self.liens_unrel_ot_ct  := liens_unrel_ot_ct;
			self.liens_unrel_ot_first_seen  := liens_unrel_ot_first_seen;
			self.liens_unrel_sc_ct  := liens_unrel_sc_ct;
			self.liens_unrel_sc_first_seen  := liens_unrel_sc_first_seen;
			self.criminal_count  := criminal_count;
			self.criminal_last_date  := criminal_last_date;
			self.felony_count  := felony_count;
			self.rel_count  := rel_count;
			self.rel_bankrupt_count  := rel_bankrupt_count;
			self.rel_felony_count  := rel_felony_count;
			self.crim_rel_within100miles  := crim_rel_within100miles;
			self.crim_rel_withinother  := crim_rel_withinother;
			self.rel_prop_owned_count  := rel_prop_owned_count;
			self.rel_prop_owned_purchase_total  := rel_prop_owned_purchase_total;
			self.rel_prop_owned_purchase_count  := rel_prop_owned_purchase_count;
			self.rel_prop_owned_assessed_total  := rel_prop_owned_assessed_total;
			self.rel_prop_owned_assessed_count  := rel_prop_owned_assessed_count;
			self.rel_prop_sold_count  := rel_prop_sold_count;
			self.rel_prop_sold_purchase_total  := rel_prop_sold_purchase_total;
			self.rel_prop_sold_assessed_total  := rel_prop_sold_assessed_total;
			self.rel_within25miles_count  := rel_within25miles_count;
			self.rel_incomeunder25_count  := rel_incomeunder25_count;
			self.rel_incomeunder50_count  := rel_incomeunder50_count;
			self.rel_incomeunder75_count  := rel_incomeunder75_count;
			self.rel_incomeunder100_count  := rel_incomeunder100_count;
			self.rel_incomeover100_count  := rel_incomeover100_count;
			self.rel_homeunder100_count  := rel_homeunder100_count;
			self.rel_homeunder200_count  := rel_homeunder200_count;
			self.rel_homeunder300_count  := rel_homeunder300_count;
			self.rel_homeunder500_count  := rel_homeunder500_count;
			self.rel_homeover500_count  := rel_homeover500_count;
			self.rel_educationunder12_count  := rel_educationunder12_count;
			self.rel_educationover12_count  := rel_educationover12_count;
			self.rel_ageunder30_count  := rel_ageunder30_count;
			self.rel_ageunder40_count  := rel_ageunder40_count;
			self.rel_ageunder50_count  := rel_ageunder50_count;
			self.rel_ageunder70_count  := rel_ageunder70_count;
			self.rel_ageover70_count  := rel_ageover70_count;
			self.rel_vehicle_owned_count  := rel_vehicle_owned_count;
			self.rel_count_addr  := rel_count_addr;
			self.current_count  := current_count;
			self.historical_count  := historical_count;
			self.acc_damage_amt_total  := acc_damage_amt_total;
			self.acc_damage_amt_last  := acc_damage_amt_last;
			self.ams_age  := ams_age;
			self.ams_class  := ams_class;
			self.ams_income_level_code  := ams_income_level_code;
			self.ams_college_tier  := ams_college_tier;
			self.prof_license_flag  := prof_license_flag;
			self.prof_license_category  := prof_license_category;
			self.inferred_age  := inferred_age;
			self.estimated_income  := estimated_income;
			self.archive_date  := archive_date;
			self.rc_sources  := rc_sources;
			self.fname_sources  := fname_sources;
			self.lname_sources  := lname_sources;
			self.addr_sources  := addr_sources;
			self.util_adl_type_list  := util_adl_type_list;
			self.util_adl_first_seen_list  := util_adl_first_seen_list;
			self.util_add1_type_list  := util_add1_type_list;
			self.util_add1_first_seen_list  := util_add1_first_seen_list;
			self.util_add2_first_seen_list  := util_add2_first_seen_list;
			self.util_add1_nap  := util_add1_nap;
			self.util_add2_type_list  := util_add2_type_list;
			self.sysdate  := sysdate;
			self.sysyear  := sysyear;
			self.rc_correct_dob2  := rc_correct_dob2;
			self.years_rc_correct_dob  := years_rc_correct_dob;
			self.months_rc_correct_dob  := months_rc_correct_dob;
			self.rc_ssnhighissue2  := rc_ssnhighissue2;
			self.years_rc_ssnhighissue  := years_rc_ssnhighissue;
			self.months_rc_ssnhighissue  := months_rc_ssnhighissue;
			self.rc_areacodesplitdate2  := rc_areacodesplitdate2;
			self.years_rc_areacodesplitdate  := years_rc_areacodesplitdate;
			self.months_rc_areacodesplitdate  := months_rc_areacodesplitdate;
			self.adl_eq_first_seen2  := adl_eq_first_seen2;
			self.years_adl_eq_first_seen  := years_adl_eq_first_seen;
			self.months_adl_eq_first_seen  := months_adl_eq_first_seen;
			self.adl_en_first_seen2  := adl_en_first_seen2;
			self.years_adl_en_first_seen  := years_adl_en_first_seen;
			self.months_adl_en_first_seen  := months_adl_en_first_seen;
			self.adl_dl_first_seen2  := adl_dl_first_seen2;
			self.years_adl_dl_first_seen  := years_adl_dl_first_seen;
			self.months_adl_dl_first_seen  := months_adl_dl_first_seen;
			self.adl_pr_first_seen2  := adl_pr_first_seen2;
			self.years_adl_pr_first_seen  := years_adl_pr_first_seen;
			self.months_adl_pr_first_seen  := months_adl_pr_first_seen;
			self.adl_em_first_seen2  := adl_em_first_seen2;
			self.years_adl_em_first_seen  := years_adl_em_first_seen;
			self.months_adl_em_first_seen  := months_adl_em_first_seen;
			self.adl_vo_first_seen2  := adl_vo_first_seen2;
			self.years_adl_vo_first_seen  := years_adl_vo_first_seen;
			self.months_adl_vo_first_seen  := months_adl_vo_first_seen;
			self.adl_em_only_first_seen2  := adl_em_only_first_seen2;
			self.years_adl_em_only_first_seen  := years_adl_em_only_first_seen;
			self.months_adl_em_only_first_seen  := months_adl_em_only_first_seen;
			self.adl_w_first_seen2  := adl_w_first_seen2;
			self.years_adl_w_first_seen  := years_adl_w_first_seen;
			self.months_adl_w_first_seen  := months_adl_w_first_seen;
			self.adl_pr_last_seen2  := adl_pr_last_seen2;
			self.years_adl_pr_last_seen  := years_adl_pr_last_seen;
			self.months_adl_pr_last_seen  := months_adl_pr_last_seen;
			self.adl_w_last_seen2  := adl_w_last_seen2;
			self.years_adl_w_last_seen  := years_adl_w_last_seen;
			self.months_adl_w_last_seen  := months_adl_w_last_seen;
			self.lname_change_date2  := lname_change_date2;
			self.years_lname_change_date  := years_lname_change_date;
			self.months_lname_change_date  := months_lname_change_date;
			self.add1_avm_recording_date2  := add1_avm_recording_date2;
			self.years_add1_avm_recording_date  := years_add1_avm_recording_date;
			self.months_add1_avm_recording_date  := months_add1_avm_recording_date;
			self.add1_avm_assessed_value_year2  := add1_avm_assessed_value_year2;
			self.years_add1_avm_assess_year  := years_add1_avm_assess_year;
			self.months_add1_avm_assess_year  := months_add1_avm_assess_year;
			self.add1_built_date2  := add1_built_date2;
			self.years_add1_built_date  := years_add1_built_date;
			self.months_add1_built_date  := months_add1_built_date;
			self.add1_mortgage_date2  := add1_mortgage_date2;
			self.years_add1_mortgage_date  := years_add1_mortgage_date;
			self.months_add1_mortgage_date  := months_add1_mortgage_date;
			self.add1_mortgage_due_date2  := add1_mortgage_due_date2;
			self.years_add1_mortgage_due_date  := years_add1_mortgage_due_date;
			self.months_add1_mortgage_due_date  := months_add1_mortgage_due_date;
			self.add1_date_first_seen2  := add1_date_first_seen2;
			self.years_add1_date_first_seen  := years_add1_date_first_seen;
			self.months_add1_date_first_seen  := months_add1_date_first_seen;
			self.add1_assessed_value_year2  := add1_assessed_value_year2;
			self.years_add1_assessed_value_year  := years_add1_assessed_value_year;
			self.months_add1_assessed_value_year  := months_add1_assessed_value_year;
			self.prop1_prev_purchase_date2  := prop1_prev_purchase_date2;
			self.years_prop1_prev_purchase_date  := years_prop1_prev_purchase_date;
			self.months_prop1_prev_purchase_date  := months_prop1_prev_purchase_date;
			self.prop2_sale_date2  := prop2_sale_date2;
			self.years_prop2_sale_date  := years_prop2_sale_date;
			self.months_prop2_sale_date  := months_prop2_sale_date;
			self.prop2_prev_purchase_date2  := prop2_prev_purchase_date2;
			self.years_prop2_prev_purchase_date  := years_prop2_prev_purchase_date;
			self.months_prop2_prev_purchase_date  := months_prop2_prev_purchase_date;
			self.add2_assessed_value_year2  := add2_assessed_value_year2;
			self.years_add2_assessed_value_year  := years_add2_assessed_value_year;
			self.months_add2_assessed_value_year  := months_add2_assessed_value_year;
			self.add2_built_date2  := add2_built_date2;
			self.years_add2_built_date  := years_add2_built_date;
			self.months_add2_built_date  := months_add2_built_date;
			self.add2_mortgage_due_date2  := add2_mortgage_due_date2;
			self.years_add2_mortgage_due_date  := years_add2_mortgage_due_date;
			self.months_add2_mortgage_due_date  := months_add2_mortgage_due_date;
			self.add2_date_first_seen2  := add2_date_first_seen2;
			self.years_add2_date_first_seen  := years_add2_date_first_seen;
			self.months_add2_date_first_seen  := months_add2_date_first_seen;
			self.add2_date_last_seen2  := add2_date_last_seen2;
			self.years_add2_date_last_seen  := years_add2_date_last_seen;
			self.months_add2_date_last_seen  := months_add2_date_last_seen;
			self.add3_built_date2  := add3_built_date2;
			self.years_add3_built_date  := years_add3_built_date;
			self.months_add3_built_date  := months_add3_built_date;
			self.add3_mortgage_date2  := add3_mortgage_date2;
			self.years_add3_mortgage_date  := years_add3_mortgage_date;
			self.months_add3_mortgage_date  := months_add3_mortgage_date;
			self.add3_mortgage_due_date2  := add3_mortgage_due_date2;
			self.years_add3_mortgage_due_date  := years_add3_mortgage_due_date;
			self.months_add3_mortgage_due_date  := months_add3_mortgage_due_date;
			self.add3_date_first_seen2  := add3_date_first_seen2;
			self.years_add3_date_first_seen  := years_add3_date_first_seen;
			self.months_add3_date_first_seen  := months_add3_date_first_seen;
			self.add3_date_last_seen2  := add3_date_last_seen2;
			self.years_add3_date_last_seen  := years_add3_date_last_seen;
			self.months_add3_date_last_seen  := months_add3_date_last_seen;
			self.gong_did_first_seen2  := gong_did_first_seen2;
			self.years_gong_did_first_seen  := years_gong_did_first_seen;
			self.months_gong_did_first_seen  := months_gong_did_first_seen;
			self.credit_first_seen2  := credit_first_seen2;
			self.years_credit_first_seen  := years_credit_first_seen;
			self.months_credit_first_seen  := months_credit_first_seen;
			self.header_first_seen2  := header_first_seen2;
			self.years_header_first_seen  := years_header_first_seen;
			self.months_header_first_seen  := months_header_first_seen;
			self.infutor_first_seen2  := infutor_first_seen2;
			self.years_infutor_first_seen  := years_infutor_first_seen;
			self.months_infutor_first_seen  := months_infutor_first_seen;
			self.attr_date_last_purchase2  := attr_date_last_purchase2;
			self.years_attr_date_last_purchase  := years_attr_date_last_purchase;
			self.months_attr_date_last_purchase  := months_attr_date_last_purchase;
			self.attr_date_last_sale2  := attr_date_last_sale2;
			self.years_attr_date_last_sale  := years_attr_date_last_sale;
			self.months_attr_date_last_sale  := months_attr_date_last_sale;
			self.attr_date_last_eviction2  := attr_date_last_eviction2;
			self.years_attr_date_last_eviction  := years_attr_date_last_eviction;
			self.months_attr_date_last_eviction  := months_attr_date_last_eviction;
			self.liens_unrel_cj_first_seen2  := liens_unrel_cj_first_seen2;
			self.years_liens_unrel_cj_first_seen  := years_liens_unrel_cj_first_seen;
			self.months_liens_unrel_cj_first_seen  := months_liens_unrel_cj_first_seen;
			self.liens_unrel_lt_first_seen2  := liens_unrel_lt_first_seen2;
			self.years_liens_unrel_lt_first_seen  := years_liens_unrel_lt_first_seen;
			self.months_liens_unrel_lt_first_seen  := months_liens_unrel_lt_first_seen;
			self.liens_unrel_ot_first_seen2  := liens_unrel_ot_first_seen2;
			self.years_liens_unrel_ot_first_seen  := years_liens_unrel_ot_first_seen;
			self.months_liens_unrel_ot_first_seen  := months_liens_unrel_ot_first_seen;
			self.liens_unrel_sc_first_seen2  := liens_unrel_sc_first_seen2;
			self.years_liens_unrel_sc_first_seen  := years_liens_unrel_sc_first_seen;
			self.months_liens_unrel_sc_first_seen  := months_liens_unrel_sc_first_seen;
			self.criminal_last_date2  := criminal_last_date2;
			self.years_criminal_last_date  := years_criminal_last_date;
			self.months_criminal_last_date  := months_criminal_last_date;
			self.source_tot_AK  := source_tot_AK;
			self.source_tot_AM  := source_tot_AM;
			self.source_tot_AR  := source_tot_AR;
			self.source_tot_BA  := source_tot_BA;
			self.source_tot_CG  := source_tot_CG;
			self.source_tot_CO  := source_tot_CO;
			self.source_tot_CY  := source_tot_CY;
			self.source_tot_DA  := source_tot_DA;
			self.source_tot_D  := source_tot_D;
			self.source_tot_DL  := source_tot_DL;
			self.source_tot_DS  := source_tot_DS;
			self.source_tot_EB  := source_tot_EB;
			self.source_tot_EM  := source_tot_EM;
			self.source_tot_VO  := source_tot_VO;
			self.source_tot_EQ  := source_tot_EQ;
			self.source_tot_FF  := source_tot_FF;
			self.source_tot_FR  := source_tot_FR;
			self.source_tot_L2  := source_tot_L2;
			self.source_tot_LI  := source_tot_LI;
			self.source_tot_MW  := source_tot_MW;
			self.source_tot_NT  := source_tot_NT;
			self.source_tot_P  := source_tot_P;
			self.source_tot_PL  := source_tot_PL;
			self.source_tot_SL  := source_tot_SL;
			self.source_tot_TU  := source_tot_TU;
			self.source_tot_V  := source_tot_V;
			self.source_tot_W  := source_tot_W;
			self.source_tot_WP  := source_tot_WP;
			self.source_tot_DrLic  := source_tot_DrLic;
			self.source_tot_voter  := source_tot_voter;
			self.source_tot_count  := source_tot_count;
			self.source_tot_count_pos  := source_tot_count_pos;
			self.source_tot_count_neg  := source_tot_count_neg;
			self.source_tot_count_fcrapos  := source_tot_count_fcrapos;
			self.source_tot_count_fcraneg  := source_tot_count_fcraneg;
			self.source_tot_total  := source_tot_total;
			self.source_tot_other  := source_tot_other;
			self.source_fst_AK  := source_fst_AK;
			self.source_fst_AM  := source_fst_AM;
			self.source_fst_AR  := source_fst_AR;
			self.source_fst_BA  := source_fst_BA;
			self.source_fst_CG  := source_fst_CG;
			self.source_fst_CO  := source_fst_CO;
			self.source_fst_CY  := source_fst_CY;
			self.source_fst_DA  := source_fst_DA;
			self.source_fst_D  := source_fst_D;
			self.source_fst_DL  := source_fst_DL;
			self.source_fst_DS  := source_fst_DS;
			self.source_fst_EB  := source_fst_EB;
			self.source_fst_EM  := source_fst_EM;
			self.source_fst_VO  := source_fst_VO;
			self.source_fst_EQ  := source_fst_EQ;
			self.source_fst_FF  := source_fst_FF;
			self.source_fst_FR  := source_fst_FR;
			self.source_fst_L2  := source_fst_L2;
			self.source_fst_LI  := source_fst_LI;
			self.source_fst_MW  := source_fst_MW;
			self.source_fst_NT  := source_fst_NT;
			self.source_fst_P  := source_fst_P;
			self.source_fst_PL  := source_fst_PL;
			self.source_fst_SL  := source_fst_SL;
			self.source_fst_TU  := source_fst_TU;
			self.source_fst_V  := source_fst_V;
			self.source_fst_W  := source_fst_W;
			self.source_fst_WP  := source_fst_WP;
			self.source_fst_DrLic  := source_fst_DrLic;
			self.source_fst_voter  := source_fst_voter;
			self.source_fst_count  := source_fst_count;
			self.source_fst_count_pos  := source_fst_count_pos;
			self.source_fst_count_neg  := source_fst_count_neg;
			self.source_fst_count_fcrapos  := source_fst_count_fcrapos;
			self.source_fst_count_fcraneg  := source_fst_count_fcraneg;
			self.source_fst_total  := source_fst_total;
			self.source_fst_other  := source_fst_other;
			self.source_lst_AK  := source_lst_AK;
			self.source_lst_AM  := source_lst_AM;
			self.source_lst_AR  := source_lst_AR;
			self.source_lst_BA  := source_lst_BA;
			self.source_lst_CG  := source_lst_CG;
			self.source_lst_CO  := source_lst_CO;
			self.source_lst_CY  := source_lst_CY;
			self.source_lst_DA  := source_lst_DA;
			self.source_lst_D  := source_lst_D;
			self.source_lst_DL  := source_lst_DL;
			self.source_lst_DS  := source_lst_DS;
			self.source_lst_EB  := source_lst_EB;
			self.source_lst_EM  := source_lst_EM;
			self.source_lst_VO  := source_lst_VO;
			self.source_lst_EQ  := source_lst_EQ;
			self.source_lst_FF  := source_lst_FF;
			self.source_lst_FR  := source_lst_FR;
			self.source_lst_L2  := source_lst_L2;
			self.source_lst_LI  := source_lst_LI;
			self.source_lst_MW  := source_lst_MW;
			self.source_lst_NT  := source_lst_NT;
			self.source_lst_P  := source_lst_P;
			self.source_lst_PL  := source_lst_PL;
			self.source_lst_SL  := source_lst_SL;
			self.source_lst_TU  := source_lst_TU;
			self.source_lst_V  := source_lst_V;
			self.source_lst_W  := source_lst_W;
			self.source_lst_WP  := source_lst_WP;
			self.source_lst_DrLic  := source_lst_DrLic;
			self.source_lst_voter  := source_lst_voter;
			self.source_lst_count  := source_lst_count;
			self.source_lst_count_pos  := source_lst_count_pos;
			self.source_lst_count_neg  := source_lst_count_neg;
			self.source_lst_count_fcrapos  := source_lst_count_fcrapos;
			self.source_lst_count_fcraneg  := source_lst_count_fcraneg;
			self.source_lst_total  := source_lst_total;
			self.source_lst_other  := source_lst_other;
			self.source_add_AK  := source_add_AK;
			self.source_add_AM  := source_add_AM;
			self.source_add_AR  := source_add_AR;
			self.source_add_BA  := source_add_BA;
			self.source_add_CG  := source_add_CG;
			self.source_add_CO  := source_add_CO;
			self.source_add_CY  := source_add_CY;
			self.source_add_DA  := source_add_DA;
			self.source_add_D  := source_add_D;
			self.source_add_DL  := source_add_DL;
			self.source_add_DS  := source_add_DS;
			self.source_add_EB  := source_add_EB;
			self.source_add_EM  := source_add_EM;
			self.source_add_VO  := source_add_VO;
			self.source_add_EQ  := source_add_EQ;
			self.source_add_FF  := source_add_FF;
			self.source_add_FR  := source_add_FR;
			self.source_add_L2  := source_add_L2;
			self.source_add_LI  := source_add_LI;
			self.source_add_MW  := source_add_MW;
			self.source_add_NT  := source_add_NT;
			self.source_add_P  := source_add_P;
			self.source_add_PL  := source_add_PL;
			self.source_add_SL  := source_add_SL;
			self.source_add_TU  := source_add_TU;
			self.source_add_V  := source_add_V;
			self.source_add_W  := source_add_W;
			self.source_add_WP  := source_add_WP;
			self.source_add_DrLic  := source_add_DrLic;
			self.source_add_voter  := source_add_voter;
			self.source_add_count  := source_add_count;
			self.source_add_count_pos  := source_add_count_pos;
			self.source_add_count_neg  := source_add_count_neg;
			self.source_add_count_fcrapos  := source_add_count_fcrapos;
			self.source_add_count_fcraneg  := source_add_count_fcraneg;
			self.source_add_total  := source_add_total;
			self.source_add_other  := source_add_other;
			self.source_add2_AK  := source_add2_AK;
			self.source_add2_AM  := source_add2_AM;
			self.source_add2_AR  := source_add2_AR;
			self.source_add2_BA  := source_add2_BA;
			self.source_add2_CG  := source_add2_CG;
			self.source_add2_CO  := source_add2_CO;
			self.source_add2_CY  := source_add2_CY;
			self.source_add2_DA  := source_add2_DA;
			self.source_add2_D  := source_add2_D;
			self.source_add2_DL  := source_add2_DL;
			self.source_add2_DS  := source_add2_DS;
			self.source_add2_EB  := source_add2_EB;
			self.source_add2_EM  := source_add2_EM;
			self.source_add2_E1  := source_add2_E1;
			self.source_add2_E2  := source_add2_E2;
			self.source_add2_E3  := source_add2_E3;
			self.source_add2_E4  := source_add2_E4;
			self.source_add2_VO  := source_add2_VO;
			self.source_add2_EQ  := source_add2_EQ;
			self.source_add2_FF  := source_add2_FF;
			self.source_add2_FR  := source_add2_FR;
			self.source_add2_L2  := source_add2_L2;
			self.source_add2_LI  := source_add2_LI;
			self.source_add2_MW  := source_add2_MW;
			self.source_add2_NT  := source_add2_NT;
			self.source_add2_P  := source_add2_P;
			self.source_add2_PL  := source_add2_PL;
			self.source_add2_SL  := source_add2_SL;
			self.source_add2_TU  := source_add2_TU;
			self.source_add2_V  := source_add2_V;
			self.source_add2_W  := source_add2_W;
			self.source_add2_WP  := source_add2_WP;
			self.source_add2_DrLic  := source_add2_DrLic;
			self.source_add2_voter  := source_add2_voter;
			self.source_add2_count  := source_add2_count;
			self.source_add2_count_pos  := source_add2_count_pos;
			self.source_add2_count_neg  := source_add2_count_neg;
			self.source_add2_count_fcrapos  := source_add2_count_fcrapos;
			self.source_add2_count_fcraneg  := source_add2_count_fcraneg;
			self.source_add2_total  := source_add2_total;
			self.source_add2_other  := source_add2_other;
			self.source_add3_AK  := source_add3_AK;
			self.source_add3_AM  := source_add3_AM;
			self.source_add3_AR  := source_add3_AR;
			self.source_add3_BA  := source_add3_BA;
			self.source_add3_CG  := source_add3_CG;
			self.source_add3_CO  := source_add3_CO;
			self.source_add3_CY  := source_add3_CY;
			self.source_add3_DA  := source_add3_DA;
			self.source_add3_D  := source_add3_D;
			self.source_add3_DL  := source_add3_DL;
			self.source_add3_DS  := source_add3_DS;
			self.source_add3_EB  := source_add3_EB;
			self.source_add3_EM  := source_add3_EM;
			self.source_add3_E1  := source_add3_E1;
			self.source_add3_E2  := source_add3_E2;
			self.source_add3_E3  := source_add3_E3;
			self.source_add3_E4  := source_add3_E4;
			self.source_add3_VO  := source_add3_VO;
			self.source_add3_EQ  := source_add3_EQ;
			self.source_add3_FF  := source_add3_FF;
			self.source_add3_FR  := source_add3_FR;
			self.source_add3_L2  := source_add3_L2;
			self.source_add3_LI  := source_add3_LI;
			self.source_add3_MW  := source_add3_MW;
			self.source_add3_NT  := source_add3_NT;
			self.source_add3_P  := source_add3_P;
			self.source_add3_PL  := source_add3_PL;
			self.source_add3_SL  := source_add3_SL;
			self.source_add3_TU  := source_add3_TU;
			self.source_add3_V  := source_add3_V;
			self.source_add3_W  := source_add3_W;
			self.source_add3_WP  := source_add3_WP;
			self.source_add3_DrLic  := source_add3_DrLic;
			self.source_add3_voter  := source_add3_voter;
			self.source_add3_count  := source_add3_count;
			self.source_add3_count_pos  := source_add3_count_pos;
			self.source_add3_count_neg  := source_add3_count_neg;
			self.source_add3_count_fcrapos  := source_add3_count_fcrapos;
			self.source_add3_count_fcraneg  := source_add3_count_fcraneg;
			self.source_add3_total  := source_add3_total;
			self.source_add3_other  := source_add3_other;
			self.em_only_source_EM  := em_only_source_EM;
			self.em_only_source_E1  := em_only_source_E1;
			self.em_only_source_E2  := em_only_source_E2;
			self.em_only_source_E3  := em_only_source_E3;
			self.em_only_source_E4  := em_only_source_E4;
			self.util_adl_A  := util_adl_A;
			self.util_adl_C  := util_adl_C;
			self.util_adl_D  := util_adl_D;
			self.util_adl_E  := util_adl_E;
			self.util_adl_F  := util_adl_F;
			self.util_adl_G  := util_adl_G;
			self.util_adl_H  := util_adl_H;
			self.util_adl_I  := util_adl_I;
			self.util_adl_L  := util_adl_L;
			self.util_adl_N  := util_adl_N;
			self.util_adl_O  := util_adl_O;
			self.util_adl_P  := util_adl_P;
			self.util_adl_S  := util_adl_S;
			self.util_adl_T  := util_adl_T;
			self.util_adl_U  := util_adl_U;
			self.util_adl_V  := util_adl_V;
			self.util_adl_W  := util_adl_W;
			self.util_adl_Z  := util_adl_Z;
			self.util_adl_A_firstseen  := util_adl_A_firstseen;
			self.util_adl_C_firstseen  := util_adl_C_firstseen;
			self.util_adl_D_firstseen  := util_adl_D_firstseen;
			self.util_adl_E_firstseen  := util_adl_E_firstseen;
			self.util_adl_F_firstseen  := util_adl_F_firstseen;
			self.util_adl_G_firstseen  := util_adl_G_firstseen;
			self.util_adl_H_firstseen  := util_adl_H_firstseen;
			self.util_adl_I_firstseen  := util_adl_I_firstseen;
			self.util_adl_L_firstseen  := util_adl_L_firstseen;
			self.util_adl_N_firstseen  := util_adl_N_firstseen;
			self.util_adl_O_firstseen  := util_adl_O_firstseen;
			self.util_adl_P_firstseen  := util_adl_P_firstseen;
			self.util_adl_S_firstseen  := util_adl_S_firstseen;
			self.util_adl_T_firstseen  := util_adl_T_firstseen;
			self.util_adl_U_firstseen  := util_adl_U_firstseen;
			self.util_adl_V_firstseen  := util_adl_V_firstseen;
			self.util_adl_W_firstseen  := util_adl_W_firstseen;
			self.util_adl_Z_firstseen  := util_adl_Z_firstseen;
			self.years_util_adl_A_firstseen  := years_util_adl_A_firstseen;
			self.years_util_adl_C_firstseen  := years_util_adl_C_firstseen;
			self.years_util_adl_D_firstseen  := years_util_adl_D_firstseen;
			self.years_util_adl_E_firstseen  := years_util_adl_E_firstseen;
			self.years_util_adl_F_firstseen  := years_util_adl_F_firstseen;
			self.years_util_adl_G_firstseen  := years_util_adl_G_firstseen;
			self.years_util_adl_H_firstseen  := years_util_adl_H_firstseen;
			self.years_util_adl_I_firstseen  := years_util_adl_I_firstseen;
			self.years_util_adl_L_firstseen  := years_util_adl_L_firstseen;
			self.years_util_adl_N_firstseen  := years_util_adl_N_firstseen;
			self.years_util_adl_O_firstseen  := years_util_adl_O_firstseen;
			self.years_util_adl_P_firstseen  := years_util_adl_P_firstseen;
			self.years_util_adl_S_firstseen  := years_util_adl_S_firstseen;
			self.years_util_adl_T_firstseen  := years_util_adl_T_firstseen;
			self.years_util_adl_U_firstseen  := years_util_adl_U_firstseen;
			self.years_util_adl_V_firstseen  := years_util_adl_V_firstseen;
			self.years_util_adl_W_firstseen  := years_util_adl_W_firstseen;
			self.years_util_adl_Z_firstseen  := years_util_adl_Z_firstseen;
			self.months_util_adl_A_firstseen  := months_util_adl_A_firstseen;
			self.months_util_adl_C_firstseen  := months_util_adl_C_firstseen;
			self.months_util_adl_D_firstseen  := months_util_adl_D_firstseen;
			self.months_util_adl_E_firstseen  := months_util_adl_E_firstseen;
			self.months_util_adl_F_firstseen  := months_util_adl_F_firstseen;
			self.months_util_adl_G_firstseen  := months_util_adl_G_firstseen;
			self.months_util_adl_H_firstseen  := months_util_adl_H_firstseen;
			self.months_util_adl_I_firstseen  := months_util_adl_I_firstseen;
			self.months_util_adl_L_firstseen  := months_util_adl_L_firstseen;
			self.months_util_adl_N_firstseen  := months_util_adl_N_firstseen;
			self.months_util_adl_O_firstseen  := months_util_adl_O_firstseen;
			self.months_util_adl_P_firstseen  := months_util_adl_P_firstseen;
			self.months_util_adl_S_firstseen  := months_util_adl_S_firstseen;
			self.months_util_adl_T_firstseen  := months_util_adl_T_firstseen;
			self.months_util_adl_U_firstseen  := months_util_adl_U_firstseen;
			self.months_util_adl_V_firstseen  := months_util_adl_V_firstseen;
			self.months_util_adl_W_firstseen  := months_util_adl_W_firstseen;
			self.months_util_adl_Z_firstseen  := months_util_adl_Z_firstseen;
			self.util_adl_source_count  := util_adl_source_count;
			self.util_adl_sourced  := util_adl_sourced;
			self.max_years_util_adl_firstseen  := max_years_util_adl_firstseen;
			self.util_add1_A  := util_add1_A;
			self.util_add1_C  := util_add1_C;
			self.util_add1_D  := util_add1_D;
			self.util_add1_E  := util_add1_E;
			self.util_add1_F  := util_add1_F;
			self.util_add1_G  := util_add1_G;
			self.util_add1_H  := util_add1_H;
			self.util_add1_I  := util_add1_I;
			self.util_add1_L  := util_add1_L;
			self.util_add1_N  := util_add1_N;
			self.util_add1_O  := util_add1_O;
			self.util_add1_P  := util_add1_P;
			self.util_add1_S  := util_add1_S;
			self.util_add1_T  := util_add1_T;
			self.util_add1_U  := util_add1_U;
			self.util_add1_V  := util_add1_V;
			self.util_add1_W  := util_add1_W;
			self.util_add1_Z  := util_add1_Z;
			self.util_add1_A_firstseen  := util_add1_A_firstseen;
			self.util_add1_C_firstseen  := util_add1_C_firstseen;
			self.util_add1_D_firstseen  := util_add1_D_firstseen;
			self.util_add1_E_firstseen  := util_add1_E_firstseen;
			self.util_add1_F_firstseen  := util_add1_F_firstseen;
			self.util_add1_G_firstseen  := util_add1_G_firstseen;
			self.util_add1_H_firstseen  := util_add1_H_firstseen;
			self.util_add1_I_firstseen  := util_add1_I_firstseen;
			self.util_add1_L_firstseen  := util_add1_L_firstseen;
			self.util_add1_N_firstseen  := util_add1_N_firstseen;
			self.util_add1_O_firstseen  := util_add1_O_firstseen;
			self.util_add1_P_firstseen  := util_add1_P_firstseen;
			self.util_add1_S_firstseen  := util_add1_S_firstseen;
			self.util_add1_T_firstseen  := util_add1_T_firstseen;
			self.util_add1_U_firstseen  := util_add1_U_firstseen;
			self.util_add1_V_firstseen  := util_add1_V_firstseen;
			self.util_add1_W_firstseen  := util_add1_W_firstseen;
			self.util_add1_Z_firstseen  := util_add1_Z_firstseen;
			self.years_util_add1_A_firstseen  := years_util_add1_A_firstseen;
			self.years_util_add1_C_firstseen  := years_util_add1_C_firstseen;
			self.years_util_add1_D_firstseen  := years_util_add1_D_firstseen;
			self.years_util_add1_E_firstseen  := years_util_add1_E_firstseen;
			self.years_util_add1_F_firstseen  := years_util_add1_F_firstseen;
			self.years_util_add1_G_firstseen  := years_util_add1_G_firstseen;
			self.years_util_add1_H_firstseen  := years_util_add1_H_firstseen;
			self.years_util_add1_I_firstseen  := years_util_add1_I_firstseen;
			self.years_util_add1_L_firstseen  := years_util_add1_L_firstseen;
			self.years_util_add1_N_firstseen  := years_util_add1_N_firstseen;
			self.years_util_add1_O_firstseen  := years_util_add1_O_firstseen;
			self.years_util_add1_P_firstseen  := years_util_add1_P_firstseen;
			self.years_util_add1_S_firstseen  := years_util_add1_S_firstseen;
			self.years_util_add1_T_firstseen  := years_util_add1_T_firstseen;
			self.years_util_add1_U_firstseen  := years_util_add1_U_firstseen;
			self.years_util_add1_V_firstseen  := years_util_add1_V_firstseen;
			self.years_util_add1_W_firstseen  := years_util_add1_W_firstseen;
			self.years_util_add1_Z_firstseen  := years_util_add1_Z_firstseen;
			self.months_util_add1_A_firstseen  := months_util_add1_A_firstseen;
			self.months_util_add1_C_firstseen  := months_util_add1_C_firstseen;
			self.months_util_add1_D_firstseen  := months_util_add1_D_firstseen;
			self.months_util_add1_E_firstseen  := months_util_add1_E_firstseen;
			self.months_util_add1_F_firstseen  := months_util_add1_F_firstseen;
			self.months_util_add1_G_firstseen  := months_util_add1_G_firstseen;
			self.months_util_add1_H_firstseen  := months_util_add1_H_firstseen;
			self.months_util_add1_I_firstseen  := months_util_add1_I_firstseen;
			self.months_util_add1_L_firstseen  := months_util_add1_L_firstseen;
			self.months_util_add1_N_firstseen  := months_util_add1_N_firstseen;
			self.months_util_add1_O_firstseen  := months_util_add1_O_firstseen;
			self.months_util_add1_P_firstseen  := months_util_add1_P_firstseen;
			self.months_util_add1_S_firstseen  := months_util_add1_S_firstseen;
			self.months_util_add1_T_firstseen  := months_util_add1_T_firstseen;
			self.months_util_add1_U_firstseen  := months_util_add1_U_firstseen;
			self.months_util_add1_V_firstseen  := months_util_add1_V_firstseen;
			self.months_util_add1_W_firstseen  := months_util_add1_W_firstseen;
			self.months_util_add1_Z_firstseen  := months_util_add1_Z_firstseen;
			self.util_add1_source_count  := util_add1_source_count;
			self.util_add1_sourced  := util_add1_sourced;
			self.max_years_util_add1_firstseen  := max_years_util_add1_firstseen;
			self.util_add2_A  := util_add2_A;
			self.util_add2_C  := util_add2_C;
			self.util_add2_D  := util_add2_D;
			self.util_add2_E  := util_add2_E;
			self.util_add2_F  := util_add2_F;
			self.util_add2_G  := util_add2_G;
			self.util_add2_H  := util_add2_H;
			self.util_add2_I  := util_add2_I;
			self.util_add2_L  := util_add2_L;
			self.util_add2_N  := util_add2_N;
			self.util_add2_O  := util_add2_O;
			self.util_add2_P  := util_add2_P;
			self.util_add2_S  := util_add2_S;
			self.util_add2_T  := util_add2_T;
			self.util_add2_U  := util_add2_U;
			self.util_add2_V  := util_add2_V;
			self.util_add2_W  := util_add2_W;
			self.util_add2_Z  := util_add2_Z;
			self.util_add2_A_firstseen  := util_add2_A_firstseen;
			self.util_add2_C_firstseen  := util_add2_C_firstseen;
			self.util_add2_D_firstseen  := util_add2_D_firstseen;
			self.util_add2_E_firstseen  := util_add2_E_firstseen;
			self.util_add2_F_firstseen  := util_add2_F_firstseen;
			self.util_add2_G_firstseen  := util_add2_G_firstseen;
			self.util_add2_H_firstseen  := util_add2_H_firstseen;
			self.util_add2_I_firstseen  := util_add2_I_firstseen;
			self.util_add2_L_firstseen  := util_add2_L_firstseen;
			self.util_add2_N_firstseen  := util_add2_N_firstseen;
			self.util_add2_O_firstseen  := util_add2_O_firstseen;
			self.util_add2_P_firstseen  := util_add2_P_firstseen;
			self.util_add2_S_firstseen  := util_add2_S_firstseen;
			self.util_add2_T_firstseen  := util_add2_T_firstseen;
			self.util_add2_U_firstseen  := util_add2_U_firstseen;
			self.util_add2_V_firstseen  := util_add2_V_firstseen;
			self.util_add2_W_firstseen  := util_add2_W_firstseen;
			self.util_add2_Z_firstseen  := util_add2_Z_firstseen;
			self.years_util_add2_A_firstseen  := years_util_add2_A_firstseen;
			self.years_util_add2_C_firstseen  := years_util_add2_C_firstseen;
			self.years_util_add2_D_firstseen  := years_util_add2_D_firstseen;
			self.years_util_add2_E_firstseen  := years_util_add2_E_firstseen;
			self.years_util_add2_F_firstseen  := years_util_add2_F_firstseen;
			self.years_util_add2_G_firstseen  := years_util_add2_G_firstseen;
			self.years_util_add2_H_firstseen  := years_util_add2_H_firstseen;
			self.years_util_add2_I_firstseen  := years_util_add2_I_firstseen;
			self.years_util_add2_L_firstseen  := years_util_add2_L_firstseen;
			self.years_util_add2_N_firstseen  := years_util_add2_N_firstseen;
			self.years_util_add2_O_firstseen  := years_util_add2_O_firstseen;
			self.years_util_add2_P_firstseen  := years_util_add2_P_firstseen;
			self.years_util_add2_S_firstseen  := years_util_add2_S_firstseen;
			self.years_util_add2_T_firstseen  := years_util_add2_T_firstseen;
			self.years_util_add2_U_firstseen  := years_util_add2_U_firstseen;
			self.years_util_add2_V_firstseen  := years_util_add2_V_firstseen;
			self.years_util_add2_W_firstseen  := years_util_add2_W_firstseen;
			self.years_util_add2_Z_firstseen  := years_util_add2_Z_firstseen;
			self.months_util_add2_A_firstseen  := months_util_add2_A_firstseen;
			self.months_util_add2_C_firstseen  := months_util_add2_C_firstseen;
			self.months_util_add2_D_firstseen  := months_util_add2_D_firstseen;
			self.months_util_add2_E_firstseen  := months_util_add2_E_firstseen;
			self.months_util_add2_F_firstseen  := months_util_add2_F_firstseen;
			self.months_util_add2_G_firstseen  := months_util_add2_G_firstseen;
			self.months_util_add2_H_firstseen  := months_util_add2_H_firstseen;
			self.months_util_add2_I_firstseen  := months_util_add2_I_firstseen;
			self.months_util_add2_L_firstseen  := months_util_add2_L_firstseen;
			self.months_util_add2_N_firstseen  := months_util_add2_N_firstseen;
			self.months_util_add2_O_firstseen  := months_util_add2_O_firstseen;
			self.months_util_add2_P_firstseen  := months_util_add2_P_firstseen;
			self.months_util_add2_S_firstseen  := months_util_add2_S_firstseen;
			self.months_util_add2_T_firstseen  := months_util_add2_T_firstseen;
			self.months_util_add2_U_firstseen  := months_util_add2_U_firstseen;
			self.months_util_add2_V_firstseen  := months_util_add2_V_firstseen;
			self.months_util_add2_W_firstseen  := months_util_add2_W_firstseen;
			self.months_util_add2_Z_firstseen  := months_util_add2_Z_firstseen;
			self.util_add2_source_count  := util_add2_source_count;
			self.util_add2_sourced  := util_add2_sourced;
			self.max_years_util_add2_firstseen  := max_years_util_add2_firstseen;
			self.verfst_p  := verfst_p;
			self.verlst_p  := verlst_p;
			self.veradd_p  := veradd_p;
			self.verphn_p  := verphn_p;
			self.ver_phncount  := ver_phncount;
			self.years_adl_first_seen_max_fcra  := years_adl_first_seen_max_fcra;
			self.months_adl_first_seen_max_fcra  := months_adl_first_seen_max_fcra;
			self.add_apt  := add_apt;
			self.phn_disconnected  := phn_disconnected;
			self.phn_inval  := phn_inval;
			self.phn_highrisk2  := phn_highrisk2;
			self.phn_cellpager  := phn_cellpager;
			self.phn_zipmismatch  := phn_zipmismatch;
			self.phn_residential  := phn_residential;
			self.ssn_priordob  := ssn_priordob;
			self.ssn_inval  := ssn_inval;
			self.ssn_issued18  := ssn_issued18;
			self.ssn_deceased  := ssn_deceased;
			self.ssn_prob  := ssn_prob;
			self.ADD1_AVM_MED  := ADD1_AVM_MED;
			self.add1_avm_to_med_ratio  := add1_avm_to_med_ratio;
			self.add1_fc_index  := add1_fc_index;
			self.add2_AVM_MED  := add2_AVM_MED;
			self.prop_owned_flag  := prop_owned_flag;
			self.prop_sold_flag  := prop_sold_flag;
			self.add_lres_year_avg  := add_lres_year_avg;
			self.add_lres_year_max  := add_lres_year_max;
			self.bk_flag  := bk_flag;
			self.crime_flag  := crime_flag;
			self.crime_felony_flag  := crime_felony_flag;
			self.crime_drug_flag  := crime_drug_flag;
			self.rc82  := rc82;
			self.did_populated  := did_populated;
			self.pk_es_phone10_pop  := pk_es_phone10_pop;
			self.pk_se1_phone10_pop  := pk_se1_phone10_pop;
			self.pk_se2_phone10_pop  := pk_se2_phone10_pop;
			self.pk_se3_phone10_pop  := pk_se3_phone10_pop;
			self.pk_se4_phone10_pop  := pk_se4_phone10_pop;
			self.pk_ap1_phone10_pop  := pk_ap1_phone10_pop;
			self.pk_ap2_phone10_pop  := pk_ap2_phone10_pop;
			self.pk_ap3_phone10_pop  := pk_ap3_phone10_pop;
			self.pk_sx1_phone10_pop  := pk_sx1_phone10_pop;
			self.pk_sx2_phone10_pop  := pk_sx2_phone10_pop;
			self.pk_sp_phone10_pop  := pk_sp_phone10_pop;
			self.pk_md1_phone10_pop  := pk_md1_phone10_pop;
			self.pk_md2_phone10_pop  := pk_md2_phone10_pop;
			self.pk_cl1_phone10_pop  := pk_cl1_phone10_pop;
			self.pk_cl2_phone10_pop  := pk_cl2_phone10_pop;
			self.pk_cl3_phone10_pop  := pk_cl3_phone10_pop;
			self.pk_cr_phone10_pop  := pk_cr_phone10_pop;
			self.pk_ne1_phone10_pop  := pk_ne1_phone10_pop;
			self.pk_ne2_phone10_pop  := pk_ne2_phone10_pop;
			self.pk_ne3_phone10_pop  := pk_ne3_phone10_pop;
			self.pk_pp1_phone10_pop  := pk_pp1_phone10_pop;
			self.pk_pp2_phone10_pop  := pk_pp2_phone10_pop;
			self.pk_pp3_phone10_pop  := pk_pp3_phone10_pop;
			self.pk_wk_phone10_pop  := pk_wk_phone10_pop;
			self.pk_es_eda_did_match  := pk_es_eda_did_match;
			self.pk_es_phone_count  := pk_es_phone_count;
			self.pk_se_phone_count  := pk_se_phone_count;
			self.pk_ap_phone_count  := pk_ap_phone_count;
			self.pk_sx_phone_count  := pk_sx_phone_count;
			self.pk_sp_phone_count  := pk_sp_phone_count;
			self.pk_md_phone_count  := pk_md_phone_count;
			self.pk_cl_phone_count  := pk_cl_phone_count;
			self.pk_cr_phone_count  := pk_cr_phone_count;
			self.pk_ne_phone_count  := pk_ne_phone_count;
			self.pk_pp_phone_count  := pk_pp_phone_count;
			self.pk_wk_phone_count  := pk_wk_phone_count;
			self.pk_waterfall_phone_count  := pk_waterfall_phone_count;
			self.se1_phone_first_seen2  := se1_phone_first_seen2;
			self.years_se1_phone_first_seen  := years_se1_phone_first_seen;
			self.months_se1_phone_first_seen  := months_se1_phone_first_seen;
			self.se2_phone_first_seen2  := se2_phone_first_seen2;
			self.years_se2_phone_first_seen  := years_se2_phone_first_seen;
			self.months_se2_phone_first_seen  := months_se2_phone_first_seen;
			self.se3_phone_first_seen2  := se3_phone_first_seen2;
			self.years_se3_phone_first_seen  := years_se3_phone_first_seen;
			self.months_se3_phone_first_seen  := months_se3_phone_first_seen;
			self.se4_phone_first_seen2  := se4_phone_first_seen2;
			self.years_se4_phone_first_seen  := years_se4_phone_first_seen;
			self.months_se4_phone_first_seen  := months_se4_phone_first_seen;
			self.ap1_phone_first_seen2  := ap1_phone_first_seen2;
			self.years_ap1_phone_first_seen  := years_ap1_phone_first_seen;
			self.months_ap1_phone_first_seen  := months_ap1_phone_first_seen;
			self.sp_first_seen2  := sp_first_seen2;
			self.years_sp_first_seen  := years_sp_first_seen;
			self.months_sp_first_seen  := months_sp_first_seen;
			self.md1_phone_first_seen2  := md1_phone_first_seen2;
			self.years_md1_phone_first_seen  := years_md1_phone_first_seen;
			self.months_md1_phone_first_seen  := months_md1_phone_first_seen;
			self.cl1_first_seen2  := cl1_first_seen2;
			self.years_cl1_first_seen  := years_cl1_first_seen;
			self.months_cl1_first_seen  := months_cl1_first_seen;
			self.cl2_first_seen2  := cl2_first_seen2;
			self.years_cl2_first_seen  := years_cl2_first_seen;
			self.months_cl2_first_seen  := months_cl2_first_seen;
			self.cl3_first_seen2  := cl3_first_seen2;
			self.years_cl3_first_seen  := years_cl3_first_seen;
			self.months_cl3_first_seen  := months_cl3_first_seen;
			self.ne1_phone_first_seen2  := ne1_phone_first_seen2;
			self.years_ne1_phone_first_seen  := years_ne1_phone_first_seen;
			self.months_ne1_phone_first_seen  := months_ne1_phone_first_seen;
			self.ne2_phone_first_seen2  := ne2_phone_first_seen2;
			self.years_ne2_phone_first_seen  := years_ne2_phone_first_seen;
			self.months_ne2_phone_first_seen  := months_ne2_phone_first_seen;
			self.ne3_phone_first_seen2  := ne3_phone_first_seen2;
			self.years_ne3_phone_first_seen  := years_ne3_phone_first_seen;
			self.months_ne3_phone_first_seen  := months_ne3_phone_first_seen;
			self.pp1_phone_last_seen2  := pp1_phone_last_seen2;
			self.years_pp1_phone_last_seen  := years_pp1_phone_last_seen;
			self.months_pp1_phone_last_seen  := months_pp1_phone_last_seen;
			self.pp2_phone_last_seen2  := pp2_phone_last_seen2;
			self.years_pp2_phone_last_seen  := years_pp2_phone_last_seen;
			self.months_pp2_phone_last_seen  := months_pp2_phone_last_seen;
			self.pp3_phone_last_seen2  := pp3_phone_last_seen2;
			self.years_pp3_phone_last_seen  := years_pp3_phone_last_seen;
			self.months_pp3_phone_last_seen  := months_pp3_phone_last_seen;
			self.wk_phone_first_seen2  := wk_phone_first_seen2;
			self.years_wk_phone_first_seen  := years_wk_phone_first_seen;
			self.months_wk_phone_first_seen  := months_wk_phone_first_seen;
			self.ah_add1_first_seen2  := ah_add1_first_seen2;
			self.years_ah_add1_first_seen  := years_ah_add1_first_seen;
			self.months_ah_add1_first_seen  := months_ah_add1_first_seen;
			self.ah_add2_first_seen2  := ah_add2_first_seen2;
			self.years_ah_add2_first_seen  := years_ah_add2_first_seen;
			self.months_ah_add2_first_seen  := months_ah_add2_first_seen;
			self.ah_add3_first_seen2  := ah_add3_first_seen2;
			self.years_ah_add3_first_seen  := years_ah_add3_first_seen;
			self.months_ah_add3_first_seen  := months_ah_add3_first_seen;
			self.ah_add5_first_seen2  := ah_add5_first_seen2;
			self.years_ah_add5_first_seen  := years_ah_add5_first_seen;
			self.months_ah_add5_first_seen  := months_ah_add5_first_seen;
			self.pk_years_se1_phone_first_seen  := pk_years_se1_phone_first_seen;
			self.pk_years_se2_phone_first_seen  := pk_years_se2_phone_first_seen;
			self.pk_years_se3_phone_first_seen  := pk_years_se3_phone_first_seen;
			self.pk_years_se4_phone_first_seen  := pk_years_se4_phone_first_seen;
			self.pk_years_ap1_phone_first_seen  := pk_years_ap1_phone_first_seen;
			self.pk_years_sp_first_seen  := pk_years_sp_first_seen;
			self.pk_years_md1_phone_first_seen  := pk_years_md1_phone_first_seen;
			self.pk_years_cl1_first_seen  := pk_years_cl1_first_seen;
			self.pk_years_cl2_first_seen  := pk_years_cl2_first_seen;
			self.pk_years_cl3_first_seen  := pk_years_cl3_first_seen;
			self.pk_years_ne1_phone_first_seen  := pk_years_ne1_phone_first_seen;
			self.pk_years_ne2_phone_first_seen  := pk_years_ne2_phone_first_seen;
			self.pk_years_ne3_phone_first_seen  := pk_years_ne3_phone_first_seen;
			self.pk_years_pp1_phone_last_seen  := pk_years_pp1_phone_last_seen;
			self.pk_years_pp2_phone_last_seen  := pk_years_pp2_phone_last_seen;
			self.pk_years_pp3_phone_last_seen  := pk_years_pp3_phone_last_seen;
			self.pk_years_wk_phone_first_seen  := pk_years_wk_phone_first_seen;
			self.pk_years_ah_add1_first_seen  := pk_years_ah_add1_first_seen;
			self.pk_years_ah_add2_first_seen  := pk_years_ah_add2_first_seen;
			self.pk_years_ah_add3_first_seen  := pk_years_ah_add3_first_seen;
			self.pk_years_ah_add5_first_seen  := pk_years_ah_add5_first_seen;
			self.pk_md1_yr_shared_addr  := pk_md1_yr_shared_addr;
			self.pk_md2_yr_shared_addr  := pk_md2_yr_shared_addr;
			self.pk_md1_yr_since_shared_addr  := pk_md1_yr_since_shared_addr;
			self.pk_md2_yr_since_shared_addr  := pk_md2_yr_since_shared_addr;
			self.pk_cl1_yr_since_shared_addr  := pk_cl1_yr_since_shared_addr;
			self.pk_cl2_yr_since_shared_addr  := pk_cl2_yr_since_shared_addr;
			self.pk_cl3_yr_since_shared_addr  := pk_cl3_yr_since_shared_addr;
			self.pk_phone_pop_segment3  := pk_phone_pop_segment3;
			self.pk_segment  := pk_segment;
			self.pk_segment2  := pk_segment2;
			self.pk_Repl_Addr_Matches_Input  := pk_Repl_Addr_Matches_Input;
			self.pk_es_name_match_level  := pk_es_name_match_level;
			self.pk_es_match_level  := pk_es_match_level;
			self.pk_se_phone_stability_flag  := pk_se_phone_stability_flag;
			self.pk_sp_dist_0  := pk_sp_dist_0;
			self.pk_Moved_Out_10yr  := pk_Moved_Out_10yr;
			self.pk_Close_Rel_28Yr  := pk_Close_Rel_28Yr;
			self.pk_Stable_Neighbor_Phone_Count  := pk_Stable_Neighbor_Phone_Count;
			self.pk_People_At_Work_Flag  := pk_People_At_Work_Flag;
			self.pk_Pos_Work_Source_Flag  := pk_Pos_Work_Source_Flag;
			self.pk_Short_Move_Count  := pk_Short_Move_Count;
			self.pk_years_ah_add1_first_seen2  := pk_years_ah_add1_first_seen2;
			self.pk_years_ah_add2_first_seen2  := pk_years_ah_add2_first_seen2;
			self.pk_years_ah_add3_first_seen2  := pk_years_ah_add3_first_seen2;
			self.pk_years_ah_add5_first_seen2  := pk_years_ah_add5_first_seen2;
			self.pk_PP_Disconnect_Count  := pk_PP_Disconnect_Count;
			self.pk_Repl_Hphn_Matches_Input  := pk_Repl_Hphn_Matches_Input;
			self.pk_Repl_Addr_Matches_Input_m  := pk_Repl_Addr_Matches_Input_m;
			self.pk_es_match_level_m  := pk_es_match_level_m;
			self.pk_se_phone_stability_flag_m  := pk_se_phone_stability_flag_m;
			self.pk_sp_dist_0_m  := pk_sp_dist_0_m;
			self.pk_Moved_Out_10yr_m  := pk_Moved_Out_10yr_m;
			self.pk_Close_Rel_28Yr_m  := pk_Close_Rel_28Yr_m;
			self.pk_People_At_Work_Flag_m  := pk_People_At_Work_Flag_m;
			self.pk_Pos_Work_Source_Flag_m  := pk_Pos_Work_Source_Flag_m;
			self.pk_Short_Move_Count_m  := pk_Short_Move_Count_m;
			self.pk_years_ah_add1_first_seen2_m  := pk_years_ah_add1_first_seen2_m;
			self.pk_years_ah_add2_first_seen2_m  := pk_years_ah_add2_first_seen2_m;
			self.pk_years_ah_add3_first_seen2_m  := pk_years_ah_add3_first_seen2_m;
			self.pk_years_ah_add5_first_seen2_m  := pk_years_ah_add5_first_seen2_m;
			self.pk_PP_Disconnect_Count_m  := pk_PP_Disconnect_Count_m;
			self.pk_Repl_Phn_Matches_Input  := pk_Repl_Phn_Matches_Input;
			self.pk_Close_Rel_Living_With  := pk_Close_Rel_Living_With;
			self.pk_Close_Rel_Living_With_Flag  := pk_Close_Rel_Living_With_Flag;
			self.pk_Stable_Neighbor_Phone_Flag  := pk_Stable_Neighbor_Phone_Flag;
			self.pk_WK_Recent_Phone  := pk_WK_Recent_Phone;
			self.pk_Repl_Phn_Matches_Input_m  := pk_Repl_Phn_Matches_Input_m;
			self.pk_Close_Rel_Living_With_Flag_m  := pk_Close_Rel_Living_With_Flag_m;
			self.pk_Stable_Neighbor_Phone_Flag_m  := pk_Stable_Neighbor_Phone_Flag_m;
			self.pk_WK_Recent_Phone_m  := pk_WK_Recent_Phone_m;
			self.pk_waterfall_phone_count2  := pk_waterfall_phone_count2;
			self.pk_years_ap1_phone_first_seen_3  := pk_years_ap1_phone_first_seen_3;
			self.pk_years_sp_first_seen_19yr  := pk_years_sp_first_seen_19yr;
			self.pk_Lived_With_Parents_3yr  := pk_Lived_With_Parents_3yr;
			self.pk_PP_Recent_LSeen_Phone_Index  := pk_PP_Recent_LSeen_Phone_Index;
			self.pk_waterfall_phone_count2_m  := pk_waterfall_phone_count2_m;
			self.pk_yr_ap1_phn_fseen_3_m  := pk_yr_ap1_phn_fseen_3_m;
			self.pk_years_sp_first_seen_19yr_m  := pk_years_sp_first_seen_19yr_m;
			self.pk_Lived_With_Parents_3yr_m  := pk_Lived_With_Parents_3yr_m;
			self.pk_PP_Recent_LSeen_Phone_Index_m  := pk_PP_Recent_LSeen_Phone_Index_m;
			self.pk_Parent_Phone_Recent  := pk_Parent_Phone_Recent;
			self.pk_Parent_Phone_Recent_m  := pk_Parent_Phone_Recent_m;
			self.pk_ssnchar_invalid_or_recent  := pk_ssnchar_invalid_or_recent;
			self.pk_did0  := pk_did0;
			self.pk_ssn_prob_nodob  := pk_ssn_prob_nodob;
			self.pk_yr_adl_eq_first_seen  := pk_yr_adl_eq_first_seen;
			self.pk_yr_adl_en_first_seen  := pk_yr_adl_en_first_seen;
			self.pk_yr_adl_dl_first_seen  := pk_yr_adl_dl_first_seen;
			self.pk_yr_adl_em_first_seen  := pk_yr_adl_em_first_seen;
			self.pk_yr_adl_vo_first_seen  := pk_yr_adl_vo_first_seen;
			self.pk_yr_adl_em_only_first_seen  := pk_yr_adl_em_only_first_seen;
			self.pk_yr_adl_first_seen_max_fcra  := pk_yr_adl_first_seen_max_fcra;
			self.pk_mo_adl_first_seen_max_fcra  := pk_mo_adl_first_seen_max_fcra;
			self.pk_yr_lname_change_date  := pk_yr_lname_change_date;
			self.pk_yr_gong_did_first_seen  := pk_yr_gong_did_first_seen;
			self.pk_yr_credit_first_seen  := pk_yr_credit_first_seen;
			self.pk_yr_header_first_seen  := pk_yr_header_first_seen;
			self.pk_yr_infutor_first_seen  := pk_yr_infutor_first_seen;
			self.pk_nas_summary  := pk_nas_summary;
			self.pk_nap_summary  := pk_nap_summary;
			self.pk_rc_dirsaddr_lastscore  := pk_rc_dirsaddr_lastscore;
			self.pk_combo_fnamescore  := pk_combo_fnamescore;
			self.pk_combo_hphonescore  := pk_combo_hphonescore;
			self.pk_combo_dobscore  := pk_combo_dobscore;
			self.pk_gong_did_first_ct  := pk_gong_did_first_ct;
			self.pk_combo_lnamecount_nb  := pk_combo_lnamecount_nb;
			self.pk_rc_phonelnamecount  := pk_rc_phonelnamecount;
			self.pk_combo_addrcount  := pk_combo_addrcount;
			self.pk_combo_addrcount_nb  := pk_combo_addrcount_nb;
			self.pk_rc_phoneaddrcount  := pk_rc_phoneaddrcount;
			self.pk_combo_hphonecount  := pk_combo_hphonecount;
			self.pk_ver_phncount  := pk_ver_phncount;
			self.pk_gong_did_phone_ct  := pk_gong_did_phone_ct;
			self.pk_gong_did_phone_ct_nb  := pk_gong_did_phone_ct_nb;
			self.pk_combo_ssncount  := pk_combo_ssncount;
			self.pk_combo_dobcount_nb  := pk_combo_dobcount_nb;
			self.pk_eq_count  := pk_eq_count;
			self.pk_em_count  := pk_em_count;
			self.pk_em_only_count  := pk_em_only_count;
			self.pk_pos_secondary_sources  := pk_pos_secondary_sources;
			self.pk_voter_flag  := pk_voter_flag;
			self.pk_fname_eda_sourced_type_lvl  := pk_fname_eda_sourced_type_lvl;
			self.pk_lname_eda_sourced_type_lvl  := pk_lname_eda_sourced_type_lvl;
			self.pk_add1_address_score  := pk_add1_address_score;
			self.pk_add1_unit_count2  := pk_add1_unit_count2;
			self.pk_add2_pos_sources  := pk_add2_pos_sources;
			self.add2_source_EM  := add2_source_EM;
			self.add2_source_E1  := add2_source_E1;
			self.add2_source_E2  := add2_source_E2;
			self.add2_source_E3  := add2_source_E3;
			self.add2_source_E4  := add2_source_E4;
			self.add3_source_EM  := add3_source_EM;
			self.add3_source_E1  := add3_source_E1;
			self.add3_source_E2  := add3_source_E2;
			self.add3_source_E3  := add3_source_E3;
			self.add3_source_E4  := add3_source_E4;
			self.pk_EM_Only_ver_lvl  := pk_EM_Only_ver_lvl;
			self.pk_add2_EM_ver_lvl  := pk_add2_EM_ver_lvl;
			self.pk_infutor_risk_lvl  := pk_infutor_risk_lvl;
			self.pk_infutor_risk_lvl_nb  := pk_infutor_risk_lvl_nb;
			self.pk_yr_adl_eq_first_seen2  := pk_yr_adl_eq_first_seen2;
			self.pk_yr_adl_em_first_seen2  := pk_yr_adl_em_first_seen2;
			self.pk_yr_adl_vo_first_seen2  := pk_yr_adl_vo_first_seen2;
			self.pk_yr_adl_em_only_first_seen2  := pk_yr_adl_em_only_first_seen2;
			self.pk_yrmo_adl_first_seen_max_fcra2  := pk_yrmo_adl_first_seen_max_fcra2;
			self.pk_yr_lname_change_date2  := pk_yr_lname_change_date2;
			self.pk_yr_gong_did_first_seen2  := pk_yr_gong_did_first_seen2;
			self.pk_yr_credit_first_seen2  := pk_yr_credit_first_seen2;
			self.pk_yr_header_first_seen2  := pk_yr_header_first_seen2;
			self.pk_yr_infutor_first_seen2  := pk_yr_infutor_first_seen2;
			self.pk_voter_count  := pk_voter_count;
			self.pk_estimated_income  := pk_estimated_income;
			self.pk_yr_adl_pr_first_seen  := pk_yr_adl_pr_first_seen;
			self.pk_yr_adl_w_first_seen  := pk_yr_adl_w_first_seen;
			self.pk_yr_adl_pr_last_seen  := pk_yr_adl_pr_last_seen;
			self.pk_yr_adl_w_last_seen  := pk_yr_adl_w_last_seen;
			self.pk_yr_add1_built_date  := pk_yr_add1_built_date;
			self.pk_yr_add1_mortgage_date  := pk_yr_add1_mortgage_date;
			self.pk_yr_add1_mortgage_due_date  := pk_yr_add1_mortgage_due_date;
			self.pk_yr_add1_date_first_seen  := pk_yr_add1_date_first_seen;
			self.pk_yr_add1_assessed_value_year  := pk_yr_add1_assessed_value_year;
			self.pk_yr_prop1_prev_purchase_date  := pk_yr_prop1_prev_purchase_date;
			self.pk_yr_prop2_sale_date  := pk_yr_prop2_sale_date;
			self.pk_yr_prop2_prev_purchase_date  := pk_yr_prop2_prev_purchase_date;
			self.pk_yr_add2_assessed_value_year  := pk_yr_add2_assessed_value_year;
			self.pk_yr_add2_built_date  := pk_yr_add2_built_date;
			self.pk_yr_add2_mortgage_due_date  := pk_yr_add2_mortgage_due_date;
			self.pk_yr_add2_date_first_seen  := pk_yr_add2_date_first_seen;
			self.pk_yr_add2_date_last_seen  := pk_yr_add2_date_last_seen;
			self.pk_yr_add3_built_date  := pk_yr_add3_built_date;
			self.pk_yr_add3_mortgage_due_date  := pk_yr_add3_mortgage_due_date;
			self.pk_yr_add3_date_first_seen  := pk_yr_add3_date_first_seen;
			self.pk_yr_add3_date_last_seen  := pk_yr_add3_date_last_seen;
			self.pk_yr_attr_date_last_purchase  := pk_yr_attr_date_last_purchase;
			self.pk_yr_attr_date_last_sale  := pk_yr_attr_date_last_sale;
			self.pk_prop1_sale_price  := pk_prop1_sale_price;
			self.pk_prop1_prev_purchase_price  := pk_prop1_prev_purchase_price;
			self.pk_add1_purchase_amount  := pk_add1_purchase_amount;
			self.pk_add1_assessed_amount  := pk_add1_assessed_amount;
			self.pk_add2_purchase_amount  := pk_add2_purchase_amount;
			self.pk_add2_mortgage_amount  := pk_add2_mortgage_amount;
			self.pk_add2_assessed_amount  := pk_add2_assessed_amount;
			self.pk_add3_purchase_amount  := pk_add3_purchase_amount;
			self.pk_add3_assessed_amount  := pk_add3_assessed_amount;
			self.pk_add1_building_area  := pk_add1_building_area;
			self.pk_yr_adl_pr_first_seen2  := pk_yr_adl_pr_first_seen2;
			self.pk_yr_adl_w_first_seen2  := pk_yr_adl_w_first_seen2;
			self.pk_yr_adl_pr_last_seen2  := pk_yr_adl_pr_last_seen2;
			self.pk_yr_adl_w_last_seen2  := pk_yr_adl_w_last_seen2;
			self.pk_addrs_sourced_lvl  := pk_addrs_sourced_lvl;
			self.pk_add1_own_level  := pk_add1_own_level;
			self.pk_naprop_level  := pk_naprop_level;
			self.pk_naprop_level2  := pk_naprop_level2;
			self.pk_add2_own_level  := pk_add2_own_level;
			self.pk_add3_own_level  := pk_add3_own_level;
			self.pk_prop_owned_sold_level  := pk_prop_owned_sold_level;
			self.pk_yr_add1_built_date2  := pk_yr_add1_built_date2;
			self.pk_add1_purchase_amount2  := pk_add1_purchase_amount2;
			self.pk_yr_add1_mortgage_date2  := pk_yr_add1_mortgage_date2;
			self.pk_add1_mortgage_risk  := pk_add1_mortgage_risk;
			self.pk_add1_assessed_amount2  := pk_add1_assessed_amount2;
			self.pk_yr_add1_mortgage_due_date2  := pk_yr_add1_mortgage_due_date2;
			self.pk_yr_add1_date_first_seen2  := pk_yr_add1_date_first_seen2;
			self.pk_add1_building_area2  := pk_add1_building_area2;
			self.pk_add1_no_of_buildings  := pk_add1_no_of_buildings;
			self.pk_add1_no_of_rooms  := pk_add1_no_of_rooms;
			self.pk_add1_no_of_baths  := pk_add1_no_of_baths;
			self.pk_add1_parking_no_of_cars  := pk_add1_parking_no_of_cars;
			self.pk_add1_style_code_level  := pk_add1_style_code_level;
			self.pk_yr_add1_assessed_value_year2  := pk_yr_add1_assessed_value_year2;
			self.pk_property_owned_assessed_count  := pk_property_owned_assessed_count;
			self.pk_prop1_sale_price2  := pk_prop1_sale_price2;
			self.pk_prop1_prev_purchase_price2  := pk_prop1_prev_purchase_price2;
			self.pk_yr_prop1_prev_purchase_date2  := pk_yr_prop1_prev_purchase_date2;
			self.pk_yr_prop2_sale_date2  := pk_yr_prop2_sale_date2;
			self.pk_yr_prop2_prev_purchase_date2  := pk_yr_prop2_prev_purchase_date2;
			self.pk_add2_land_use_cat  := pk_add2_land_use_cat;
			self.pk_add2_land_use_risk_level  := pk_add2_land_use_risk_level;
			self.pk_add2_no_of_buildings  := pk_add2_no_of_buildings;
			self.pk_add2_no_of_stories  := pk_add2_no_of_stories;
			self.pk_add2_no_of_baths  := pk_add2_no_of_baths;
			self.pk_add2_garage_type_risk_level  := pk_add2_garage_type_risk_level;
			self.pk_add2_style_code_level  := pk_add2_style_code_level;
			self.pk_yr_add2_assessed_value_year2  := pk_yr_add2_assessed_value_year2;
			self.pk_yr_add2_built_date2  := pk_yr_add2_built_date2;
			self.pk_add2_purchase_amount2  := pk_add2_purchase_amount2;
			self.pk_add2_mortgage_amount2  := pk_add2_mortgage_amount2;
			self.pk_add2_mortgage_risk  := pk_add2_mortgage_risk;
			self.pk_add2_adjustable_financing  := pk_add2_adjustable_financing;
			self.pk_yr_add2_mortgage_due_date2  := pk_yr_add2_mortgage_due_date2;
			self.pk_add2_assessed_amount2  := pk_add2_assessed_amount2;
			self.pk_yr_add2_date_first_seen2  := pk_yr_add2_date_first_seen2;
			self.pk_yr_add2_date_last_seen2  := pk_yr_add2_date_last_seen2;
			self.pk_yr_add3_built_date2  := pk_yr_add3_built_date2;
			self.pk_add3_purchase_amount2  := pk_add3_purchase_amount2;
			self.pk_add3_mortgage_risk  := pk_add3_mortgage_risk;
			self.pk_add3_adjustable_financing  := pk_add3_adjustable_financing;
			self.pk_yr_add3_mortgage_due_date2  := pk_yr_add3_mortgage_due_date2;
			self.pk_add3_assessed_amount2  := pk_add3_assessed_amount2;
			self.pk_yr_add3_date_first_seen2  := pk_yr_add3_date_first_seen2;
			self.pk_yr_add3_date_last_seen2  := pk_yr_add3_date_last_seen2;
			self.pk_yr_attr_date_last_purchase2  := pk_yr_attr_date_last_purchase2;
			self.pk_attr_num_purchase180  := pk_attr_num_purchase180;
			self.pk_yr_attr_date_last_sale2  := pk_yr_attr_date_last_sale2;
			self.pk_attr_num_sold60  := pk_attr_num_sold60;
			self.pk_attr_num_watercraft90  := pk_attr_num_watercraft90;
			self.pk_attr_num_watercraft180  := pk_attr_num_watercraft180;
			self.pk_attr_num_watercraft24  := pk_attr_num_watercraft24;
			self.pk_yr_liens_unrel_cj_first_seen  := pk_yr_liens_unrel_cj_first_seen;
			self.pk_yr_liens_unrel_lt_first_seen  := pk_yr_liens_unrel_lt_first_seen;
			self.pk_yr_liens_unrel_ot_first_seen  := pk_yr_liens_unrel_ot_first_seen;
			self.pk_yr_liens_unrel_sc_first_seen  := pk_yr_liens_unrel_sc_first_seen;
			self.pk_yr_attr_date_last_eviction  := pk_yr_attr_date_last_eviction;
			self.pk_yr_criminal_last_date  := pk_yr_criminal_last_date;
			self.pk_bk_level  := pk_bk_level;
			self.pk_liens_unrel_cj_ct  := pk_liens_unrel_cj_ct;
			self.pk_liens_unrel_ft_ct  := pk_liens_unrel_ft_ct;
			self.pk_liens_unrel_lt_ct  := pk_liens_unrel_lt_ct;
			self.pk_liens_unrel_o_ct  := pk_liens_unrel_o_ct;
			self.pk_liens_unrel_ot_ct  := pk_liens_unrel_ot_ct;
			self.pk_liens_unrel_sc_ct  := pk_liens_unrel_sc_ct;
			self.pk_liens_unrel_count  := pk_liens_unrel_count;
			self.pk_lien_type_level  := pk_lien_type_level;
			self.pk_yr_liens_unrel_cj_first_sn2  := pk_yr_liens_unrel_cj_first_sn2;
			self.pk_yr_liens_unrel_lt_first_sn2  := pk_yr_liens_unrel_lt_first_sn2;
			self.pk_yr_liens_unrel_ot_first_sn2  := pk_yr_liens_unrel_ot_first_sn2;
			self.pk_yr_liens_unrel_sc_first_sn2  := pk_yr_liens_unrel_sc_first_sn2;
			self.pk_attr_eviction_count  := pk_attr_eviction_count;
			self.pk_yr_attr_date_last_eviction2  := pk_yr_attr_date_last_eviction2;
			self.pk_eviction_level  := pk_eviction_level;
			self.pk_yr_criminal_last_date2  := pk_yr_criminal_last_date2;
			self.pk_crime_level  := pk_crime_level;
			self.pk_felony_recent_level  := pk_felony_recent_level;
			self.pk_yr_rc_ssnhighissue  := pk_yr_rc_ssnhighissue;
			self.pk_yr_rc_areacodesplitdate  := pk_yr_rc_areacodesplitdate;
			self.pk_recent_AC_Split  := pk_recent_AC_Split;
			self.pk_phn_not_residential  := pk_phn_not_residential;
			self.pk_disconnected  := pk_disconnected;
			self.pk_phn_cell_pager_inval  := pk_phn_cell_pager_inval;
			self.pk_yr_rc_ssnhighissue2  := pk_yr_rc_ssnhighissue2;
			self.pk_PL_Sourced_Level  := pk_PL_Sourced_Level;
			self.pk_prof_lic_cat  := pk_prof_lic_cat;
			self.pk_attr_num_proflic90  := pk_attr_num_proflic90;
			self.pk_attr_num_proflic_exp30  := pk_attr_num_proflic_exp30;
			self.pk_add_lres_year_avg  := pk_add_lres_year_avg;
			self.pk_add_lres_year_max  := pk_add_lres_year_max;
			self.pk_add1_lres  := pk_add1_lres;
			self.pk_add2_lres  := pk_add2_lres;
			self.pk_add3_lres  := pk_add3_lres;
			self.pk_add1_lres_flag  := pk_add1_lres_flag;
			self.pk_add2_lres_flag  := pk_add2_lres_flag;
			self.pk_add3_lres_flag  := pk_add3_lres_flag;
			self.pk_lres_flag_level  := pk_lres_flag_level;
			self.pk_avg_lres  := pk_avg_lres;
			self.pk_addrs_5yr  := pk_addrs_5yr;
			self.pk_addrs_10yr  := pk_addrs_10yr;
			self.pk_add_lres_year_avg2  := pk_add_lres_year_avg2;
			self.pk_add_lres_year_max2  := pk_add_lres_year_max2;
			self.pk_nameperssn_count  := pk_nameperssn_count;
			self.pk_ssns_per_adl  := pk_ssns_per_adl;
			self.pk_addrs_per_adl  := pk_addrs_per_adl;
			self.pk_phones_per_adl  := pk_phones_per_adl;
			self.pk_addrs_per_ssn  := pk_addrs_per_ssn;
			self.pk_adls_per_addr  := pk_adls_per_addr;
			self.pk_ssns_per_addr2  := pk_ssns_per_addr2;
			self.pk_phones_per_addr  := pk_phones_per_addr;
			self.pk_adls_per_phone  := pk_adls_per_phone;
			self.pk_addrs_per_adl_c6  := pk_addrs_per_adl_c6;
			self.pk_phones_per_adl_c6  := pk_phones_per_adl_c6;
			self.pk_addrs_per_ssn_c6  := pk_addrs_per_ssn_c6;
			self.pk_adls_per_addr_c6  := pk_adls_per_addr_c6;
			self.pk_ssns_per_addr_c6  := pk_ssns_per_addr_c6;
			self.pk_phones_per_addr_c6  := pk_phones_per_addr_c6;
			self.pk_adls_per_phone_c6  := pk_adls_per_phone_c6;
			self.pk_attr_addrs_last30  := pk_attr_addrs_last30;
			self.pk_attr_addrs_last36  := pk_attr_addrs_last36;
			self.pk_attr_addrs_last_level  := pk_attr_addrs_last_level;
			self.pk_ams_college_tier  := pk_ams_college_tier;
			self.ams_class_n  := ams_class_n;
			self.pk_since_ams_class_year  := pk_since_ams_class_year;
			self.pk_ams_class_level  := pk_ams_class_level;
			self.pk_ams_income_level_code  := pk_ams_income_level_code;
			self.pk_yr_rc_correct_dob  := pk_yr_rc_correct_dob;
			self.pk_yr_rc_correct_dob2  := pk_yr_rc_correct_dob2;
			self.pk_ams_age  := pk_ams_age;
			self.pk_inferred_age  := pk_inferred_age;
			self.pk_yr_add1_avm_recording_date  := pk_yr_add1_avm_recording_date;
			self.pk_yr_add1_avm_assess_year  := pk_yr_add1_avm_assess_year;
			self.pk_add1_avm_sp  := pk_add1_avm_sp;
			self.pk_add1_avm_ta  := pk_add1_avm_ta;
			self.pk_add1_avm_pi  := pk_add1_avm_pi;
			self.pk_add1_avm_med  := pk_add1_avm_med;
			self.pk_add2_avm_auto  := pk_add2_avm_auto;
			self.pk_add2_avm_auto4  := pk_add2_avm_auto4;
			self.pk_add1_avm_to_med_ratio  := pk_add1_avm_to_med_ratio;
			self.pk2_add1_avm_sp  := pk2_add1_avm_sp;
			self.pk2_add1_avm_ta  := pk2_add1_avm_ta;
			self.pk2_add1_avm_pi  := pk2_add1_avm_pi;
			self.pk2_ADD1_AVM_MED  := pk2_ADD1_AVM_MED;
			self.pk2_add1_avm_to_med_ratio  := pk2_add1_avm_to_med_ratio;
			self.pk_add2_avm_auto_diff4  := pk_add2_avm_auto_diff4;
			self.pk_add2_avm_auto_diff4_lvl  := pk_add2_avm_auto_diff4_lvl;
			self.pk2_yr_add1_avm_recording_date  := pk2_yr_add1_avm_recording_date;
			self.pk2_yr_add1_avm_assess_year  := pk2_yr_add1_avm_assess_year;
			self.pk_dist_a1toa3  := pk_dist_a1toa3;
			self.pk_rc_disthphoneaddr  := pk_rc_disthphoneaddr;
			self.pk_out_st_division_lvl  := pk_out_st_division_lvl;
			self.pk_impulse_count  := pk_impulse_count;
			self.pk_attr_total_number_derogs  := pk_attr_total_number_derogs;
			self.pk_attr_num_nonderogs90  := pk_attr_num_nonderogs90;
			self.pk_derog_total  := pk_derog_total;
			self.pk_attr_num_nonderogs90_b  := pk_attr_num_nonderogs90_b;
			self.pk_c_bargains  := pk_c_bargains;
			self.pk_c_bel_edu  := pk_c_bel_edu;
			self.pk_c_lowrent  := pk_c_lowrent;
			self.pk_c_med_hval  := pk_c_med_hval;
			self.pk_yrmo_adl_f_sn_mx_fcra2  := pk_yrmo_adl_f_sn_mx_fcra2;
			self.pk_add2_garage_type_risk_lvl  := pk_add2_garage_type_risk_lvl;
			self.pk_yr_attr_dt_last_purch2  := pk_yr_attr_dt_last_purch2;
			self.pk_yr_ln_unrel_cj_f_sn2  := pk_yr_ln_unrel_cj_f_sn2;
			self.pk_yr_ln_unrel_lt_f_sn2  := pk_yr_ln_unrel_lt_f_sn2;
			self.pk_yr_ln_unrel_ot_f_sn2  := pk_yr_ln_unrel_ot_f_sn2;
			self.pk_yr_ln_unrel_sc_f_sn2  := pk_yr_ln_unrel_sc_f_sn2;
			self.pk_yr_attr_dt_l_eviction2  := pk_yr_attr_dt_l_eviction2;
			self.pk2_yr_add1_avm_rec_dt  := pk2_yr_add1_avm_rec_dt;
			self.pk_yr_add1_assess_val_yr2  := pk_yr_add1_assess_val_yr2;
			self.pk_prop_owned_assess_count  := pk_prop_owned_assess_count;
			self.pk_yr_prop1_prev_purch_dt2  := pk_yr_prop1_prev_purch_dt2;
			self.pk_yr_prop2_prev_purch_dt2  := pk_yr_prop2_prev_purch_dt2;
			self.pk_yr_add2_assess_val_yr2  := pk_yr_add2_assess_val_yr2;
			self.pk_rel_count  := pk_rel_count;
			self.pk_rel_bankrupt_count  := pk_rel_bankrupt_count;
			self.pk_rel_felony_count  := pk_rel_felony_count;
			self.pk_crim_rel_within100miles  := pk_crim_rel_within100miles;
			self.pk_crim_rel_withinOther  := pk_crim_rel_withinOther;
			self.pk_rel_prop_owned_count  := pk_rel_prop_owned_count;
			self.pk_rel_prop_own_prch_tot2  := pk_rel_prop_own_prch_tot2;
			self.pk_rel_prop_owned_prch_cnt  := pk_rel_prop_owned_prch_cnt;
			self.pk_rel_prop_own_assess_tot2  := pk_rel_prop_own_assess_tot2;
			self.pk_rel_prop_owned_as_cnt  := pk_rel_prop_owned_as_cnt;
			self.pk_rel_prop_sold_count  := pk_rel_prop_sold_count;
			self.pk_rel_prop_sold_prch_tot2  := pk_rel_prop_sold_prch_tot2;
			self.pk_rel_prop_sold_as_tot2  := pk_rel_prop_sold_as_tot2;
			self.pk_rel_within25miles_count  := pk_rel_within25miles_count;
			self.pk_rel_incomeunder25_count  := pk_rel_incomeunder25_count;
			self.pk_rel_incomeunder50_count  := pk_rel_incomeunder50_count;
			self.pk_rel_incomeunder75_count  := pk_rel_incomeunder75_count;
			self.pk_rel_incomeunder100_count  := pk_rel_incomeunder100_count;
			self.pk_rel_incomeover100_count  := pk_rel_incomeover100_count;
			self.pk_rel_homeunder100_count  := pk_rel_homeunder100_count;
			self.pk_rel_homeunder200_count  := pk_rel_homeunder200_count;
			self.pk_rel_homeunder300_count  := pk_rel_homeunder300_count;
			self.pk_rel_homeunder500_count  := pk_rel_homeunder500_count;
			self.pk_rel_homeover500_count  := pk_rel_homeover500_count;
			self.pk_rel_educationunder12_count  := pk_rel_educationunder12_count;
			self.pk_rel_educationover12_count  := pk_rel_educationover12_count;
			self.pk_rel_ageunder30_count  := pk_rel_ageunder30_count;
			self.pk_rel_ageunder40_count  := pk_rel_ageunder40_count;
			self.pk_rel_ageunder50_count  := pk_rel_ageunder50_count;
			self.pk_rel_ageunder70_count  := pk_rel_ageunder70_count;
			self.pk_rel_ageover70_count  := pk_rel_ageover70_count;
			self.pk_rel_vehicle_owned_count  := pk_rel_vehicle_owned_count;
			self.pk_rel_count_addr  := pk_rel_count_addr;
			self.pk_acc_damage_amt_total  := pk_acc_damage_amt_total;
			self.pk_acc_damage_amt_last  := pk_acc_damage_amt_last;
			self.pk_attr_arrests24  := pk_attr_arrests24;
			self.pk_acc_damage_amt_total2  := pk_acc_damage_amt_total2;
			self.pk_acc_damage_amt_last2  := pk_acc_damage_amt_last2;
			self.pk_yr_util_adl_D_firstseen  := pk_yr_util_adl_D_firstseen;
			self.pk_yr_util_adl_E_firstseen  := pk_yr_util_adl_E_firstseen;
			self.pk_yr_util_adl_F_firstseen  := pk_yr_util_adl_F_firstseen;
			self.pk_yr_util_adl_G_firstseen  := pk_yr_util_adl_G_firstseen;
			self.pk_yr_util_adl_I_firstseen  := pk_yr_util_adl_I_firstseen;
			self.pk_yr_util_adl_U_firstseen  := pk_yr_util_adl_U_firstseen;
			self.pk_max_years_util_adl_firstseen  := pk_max_years_util_adl_firstseen;
			self.pk_yr_util_add1_E_firstseen  := pk_yr_util_add1_E_firstseen;
			self.pk_yr_util_add1_F_firstseen  := pk_yr_util_add1_F_firstseen;
			self.pk_yr_util_add1_I_firstseen  := pk_yr_util_add1_I_firstseen;
			self.pk_yr_util_add1_U_firstseen  := pk_yr_util_add1_U_firstseen;
			self.pk_yr_util_add1_V_firstseen  := pk_yr_util_add1_V_firstseen;
			self.pk_yr_util_add1_Z_firstseen  := pk_yr_util_add1_Z_firstseen;
			self.pk_max_years_util_add1_firstseen  := pk_max_years_util_add1_firstseen;
			self.pk_yr_util_add2_D_firstseen  := pk_yr_util_add2_D_firstseen;
			self.pk_yr_util_add2_E_firstseen  := pk_yr_util_add2_E_firstseen;
			self.pk_yr_util_add2_G_firstseen  := pk_yr_util_add2_G_firstseen;
			self.pk_yr_util_add2_U_firstseen  := pk_yr_util_add2_U_firstseen;
			self.pk_yr_util_add2_Z_firstseen  := pk_yr_util_add2_Z_firstseen;
			self.pk_util_adl_source_count  := pk_util_adl_source_count;
			self.pk_util_adl_sourced  := pk_util_adl_sourced;
			self.pk_util_adl_count  := pk_util_adl_count;
			self.pk_util_adl_nap  := pk_util_adl_nap;
			self.pk_util_add1_source_count  := pk_util_add1_source_count;
			self.pk_util_add1_nap  := pk_util_add1_nap;
			self.pk_util_add2_source_count  := pk_util_add2_source_count;
			self.pk_util_add2_nap  := pk_util_add2_nap;
			self.pk_rc_utiliaddr_phonecount  := pk_rc_utiliaddr_phonecount;
			self.pk_utility_sourced  := pk_utility_sourced;
			self.pk_yr_util_adl_D_firstseen2  := pk_yr_util_adl_D_firstseen2;
			self.pk_yr_util_adl_E_firstseen2  := pk_yr_util_adl_E_firstseen2;
			self.pk_yr_util_adl_F_firstseen2  := pk_yr_util_adl_F_firstseen2;
			self.pk_yr_util_adl_G_firstseen2  := pk_yr_util_adl_G_firstseen2;
			self.pk_yr_util_adl_I_firstseen2  := pk_yr_util_adl_I_firstseen2;
			self.pk_yr_util_adl_U_firstseen2  := pk_yr_util_adl_U_firstseen2;
			self.pk_mx_yr_util_adl_firstseen2  := pk_mx_yr_util_adl_firstseen2;
			self.pk_yr_util_add1_E_firstseen2  := pk_yr_util_add1_E_firstseen2;
			self.pk_yr_util_add1_F_firstseen2  := pk_yr_util_add1_F_firstseen2;
			self.pk_yr_util_add1_I_firstseen2  := pk_yr_util_add1_I_firstseen2;
			self.pk_yr_util_add1_U_firstseen2  := pk_yr_util_add1_U_firstseen2;
			self.pk_yr_util_add1_V_firstseen2  := pk_yr_util_add1_V_firstseen2;
			self.pk_yr_util_add1_Z_firstseen2  := pk_yr_util_add1_Z_firstseen2;
			self.pk_mx_yr_util_add1_firstseen2  := pk_mx_yr_util_add1_firstseen2;
			self.pk_yr_util_add2_D_firstseen2  := pk_yr_util_add2_D_firstseen2;
			self.pk_yr_util_add2_E_firstseen2  := pk_yr_util_add2_E_firstseen2;
			self.pk_yr_util_add2_G_firstseen2  := pk_yr_util_add2_G_firstseen2;
			self.pk_yr_util_add2_U_firstseen2  := pk_yr_util_add2_U_firstseen2;
			self.pk_yr_util_add2_Z_firstseen2  := pk_yr_util_add2_Z_firstseen2;
			self.pk_add2_avm_med  := pk_add2_avm_med;
			self.pk_nap_type  := pk_nap_type;
			self.pk_EN_count  := pk_EN_count;
			self.pk_dl_avail  := pk_dl_avail;
			self.pk_DL_count  := pk_DL_count;
			self.pk_yr_adl_EN_first_seen2  := pk_yr_adl_EN_first_seen2;
			self.pk_yr_adl_DL_first_seen2  := pk_yr_adl_DL_first_seen2;
			self.pk_add1_fc_index_flag  := pk_add1_fc_index_flag;
			self.pk_current_count  := pk_current_count;
			self.pk_historical_count  := pk_historical_count;
			self.pk_add2_avm_med2  := pk_add2_avm_med2;
			self.pk_nas_summary_mm  := pk_nas_summary_mm;
			self.pk_nap_summary_mm  := pk_nap_summary_mm;
			self.pk_rc_dirsaddr_lastscore_mm  := pk_rc_dirsaddr_lastscore_mm;
			self.pk_combo_hphonescore_mm  := pk_combo_hphonescore_mm;
			self.pk_combo_dobscore_mm  := pk_combo_dobscore_mm;
			self.pk_gong_did_first_ct_mm  := pk_gong_did_first_ct_mm;
			self.pk_rc_phonelnamecount_mm  := pk_rc_phonelnamecount_mm;
			self.pk_combo_addrcount_mm  := pk_combo_addrcount_mm;
			self.pk_rc_phoneaddrcount_mm  := pk_rc_phoneaddrcount_mm;
			self.pk_combo_hphonecount_mm  := pk_combo_hphonecount_mm;
			self.pk_ver_phncount_mm  := pk_ver_phncount_mm;
			self.pk_gong_did_phone_ct_mm  := pk_gong_did_phone_ct_mm;
			self.pk_combo_ssncount_mm  := pk_combo_ssncount_mm;
			self.pk_eq_count_mm  := pk_eq_count_mm;
			self.pk_em_count_mm  := pk_em_count_mm;
			self.pk_em_only_count_mm  := pk_em_only_count_mm;
			self.pk_pos_secondary_sources_mm  := pk_pos_secondary_sources_mm;
			self.pk_voter_flag_mm  := pk_voter_flag_mm;
			self.pk_fname_eda_sourced_type_lvl_mm  := pk_fname_eda_sourced_type_lvl_mm;
			self.pk_lname_eda_sourced_type_lvl_mm  := pk_lname_eda_sourced_type_lvl_mm;
			self.pk_add1_address_score_mm  := pk_add1_address_score_mm;
			self.pk_add2_pos_sources_mm  := pk_add2_pos_sources_mm;
			self.pk_ssnchar_invalid_or_recent_mm  := pk_ssnchar_invalid_or_recent_mm;
			self.pk_infutor_risk_lvl_mm  := pk_infutor_risk_lvl_mm;
			self.pk_yr_adl_eq_first_seen2_mm  := pk_yr_adl_eq_first_seen2_mm;
			self.pk_yr_adl_em_first_seen2_mm  := pk_yr_adl_em_first_seen2_mm;
			self.pk_yr_adl_vo_first_seen2_mm  := pk_yr_adl_vo_first_seen2_mm;
			self.pk_yr_adl_em_only_first_seen2_mm  := pk_yr_adl_em_only_first_seen2_mm;
			self.pk_yr_lname_change_date2_mm  := pk_yr_lname_change_date2_mm;
			self.pk_yr_gong_did_first_seen2_mm  := pk_yr_gong_did_first_seen2_mm;
			self.pk_yr_credit_first_seen2_mm  := pk_yr_credit_first_seen2_mm;
			self.pk_yr_header_first_seen2_mm  := pk_yr_header_first_seen2_mm;
			self.pk_yr_infutor_first_seen2_mm  := pk_yr_infutor_first_seen2_mm;
			self.pk_EM_Only_ver_lvl_mm  := pk_EM_Only_ver_lvl_mm;
			self.pk_add2_EM_ver_lvl_mm  := pk_add2_EM_ver_lvl_mm;
			self.pk_yrmo_adl_f_sn_mx_fcra2_mm  := pk_yrmo_adl_f_sn_mx_fcra2_mm;
			self.pk_util_adl_source_count_mm  := pk_util_adl_source_count_mm;
			self.pk_util_adl_sourced_mm  := pk_util_adl_sourced_mm;
			self.pk_util_adl_count_mm  := pk_util_adl_count_mm;
			self.pk_util_adl_nap_mm  := pk_util_adl_nap_mm;
			self.pk_util_add1_source_count_mm  := pk_util_add1_source_count_mm;
			self.pk_util_add1_nap_mm  := pk_util_add1_nap_mm;
			self.pk_util_add2_source_count_mm  := pk_util_add2_source_count_mm;
			self.pk_util_add2_nap_mm  := pk_util_add2_nap_mm;
			self.pk_rc_utiliaddr_phonecount_mm  := pk_rc_utiliaddr_phonecount_mm;
			self.pk_utility_sourced_mm  := pk_utility_sourced_mm;
			self.pk_yr_util_adl_D_firstseen2_mm  := pk_yr_util_adl_D_firstseen2_mm;
			self.pk_yr_util_adl_E_firstseen2_mm  := pk_yr_util_adl_E_firstseen2_mm;
			self.pk_yr_util_adl_F_firstseen2_mm  := pk_yr_util_adl_F_firstseen2_mm;
			self.pk_yr_util_adl_G_firstseen2_mm  := pk_yr_util_adl_G_firstseen2_mm;
			self.pk_yr_util_adl_I_firstseen2_mm  := pk_yr_util_adl_I_firstseen2_mm;
			self.pk_yr_util_adl_U_firstseen2_mm  := pk_yr_util_adl_U_firstseen2_mm;
			self.pk_mx_yr_util_adl_firstseen2_mm  := pk_mx_yr_util_adl_firstseen2_mm;
			self.pk_yr_util_add1_E_firstseen2_mm  := pk_yr_util_add1_E_firstseen2_mm;
			self.pk_yr_util_add1_F_firstseen2_mm  := pk_yr_util_add1_F_firstseen2_mm;
			self.pk_yr_util_add1_I_firstseen2_mm  := pk_yr_util_add1_I_firstseen2_mm;
			self.pk_yr_util_add1_U_firstseen2_mm  := pk_yr_util_add1_U_firstseen2_mm;
			self.pk_yr_util_add1_V_firstseen2_mm  := pk_yr_util_add1_V_firstseen2_mm;
			self.pk_yr_util_add1_Z_firstseen2_mm  := pk_yr_util_add1_Z_firstseen2_mm;
			self.pk_mx_yr_util_add1_firstseen2_mm  := pk_mx_yr_util_add1_firstseen2_mm;
			self.pk_yr_util_add2_D_firstseen2_mm  := pk_yr_util_add2_D_firstseen2_mm;
			self.pk_yr_util_add2_E_firstseen2_mm  := pk_yr_util_add2_E_firstseen2_mm;
			self.pk_yr_util_add2_G_firstseen2_mm  := pk_yr_util_add2_G_firstseen2_mm;
			self.pk_yr_util_add2_U_firstseen2_mm  := pk_yr_util_add2_U_firstseen2_mm;
			self.pk_yr_util_add2_Z_firstseen2_mm  := pk_yr_util_add2_Z_firstseen2_mm;
			self.pk_nap_type_mm  := pk_nap_type_mm;
			self.pk_EN_count_mm  := pk_EN_count_mm;
			self.pk_dl_avail_mm  := pk_dl_avail_mm;
			self.pk_DL_count_mm  := pk_DL_count_mm;
			self.pk_yr_adl_EN_first_seen2_mm  := pk_yr_adl_EN_first_seen2_mm;
			self.pk_yr_adl_DL_first_seen2_mm  := pk_yr_adl_DL_first_seen2_mm;
			self.pk_combo_lnamecount_nb_mm  := pk_combo_lnamecount_nb_mm;
			self.pk_combo_addrcount_nb_mm  := pk_combo_addrcount_nb_mm;
			self.pk_gong_did_phone_ct_nb_mm  := pk_gong_did_phone_ct_nb_mm;
			self.pk_combo_dobcount_nb_mm  := pk_combo_dobcount_nb_mm;
			self.pk_infutor_risk_lvl_nb_mm  := pk_infutor_risk_lvl_nb_mm;
			self.pk_voter_count_mm  := pk_voter_count_mm;
			self.pk_estimated_income_mm  := pk_estimated_income_mm;
			self.pk_yr_adl_pr_first_seen2_mm  := pk_yr_adl_pr_first_seen2_mm;
			self.pk_yr_adl_w_first_seen2_mm  := pk_yr_adl_w_first_seen2_mm;
			self.pk_yr_adl_pr_last_seen2_mm  := pk_yr_adl_pr_last_seen2_mm;
			self.pk_yr_adl_w_last_seen2_mm  := pk_yr_adl_w_last_seen2_mm;
			self.pk_addrs_sourced_lvl_mm  := pk_addrs_sourced_lvl_mm;
			self.pk_add1_own_level_mm  := pk_add1_own_level_mm;
			self.pk_add2_own_level_mm  := pk_add2_own_level_mm;
			self.pk_add3_own_level_mm  := pk_add3_own_level_mm;
			self.pk_prop_owned_sold_level_mm  := pk_prop_owned_sold_level_mm;
			self.pk_naprop_level2_mm  := pk_naprop_level2_mm;
			self.pk_yr_add1_built_date2_mm  := pk_yr_add1_built_date2_mm;
			self.pk_add1_purchase_amount2_mm  := pk_add1_purchase_amount2_mm;
			self.pk_yr_add1_mortgage_date2_mm  := pk_yr_add1_mortgage_date2_mm;
			self.pk_add1_mortgage_risk_mm  := pk_add1_mortgage_risk_mm;
			self.pk_add1_assessed_amount2_mm  := pk_add1_assessed_amount2_mm;
			self.pk_yr_add1_mortgage_due_date2_mm  := pk_yr_add1_mortgage_due_date2_mm;
			self.pk_yr_add1_date_first_seen2_mm  := pk_yr_add1_date_first_seen2_mm;
			self.pk_add1_building_area2_mm  := pk_add1_building_area2_mm;
			self.pk_add1_no_of_buildings_mm  := pk_add1_no_of_buildings_mm;
			self.pk_add1_no_of_rooms_mm  := pk_add1_no_of_rooms_mm;
			self.pk_add1_no_of_baths_mm  := pk_add1_no_of_baths_mm;
			self.pk_add1_parking_no_of_cars_mm  := pk_add1_parking_no_of_cars_mm;
			self.pk_add1_style_code_level_mm  := pk_add1_style_code_level_mm;
			self.pk_prop1_sale_price2_mm  := pk_prop1_sale_price2_mm;
			self.pk_prop1_prev_purchase_price2_mm  := pk_prop1_prev_purchase_price2_mm;
			self.pk_yr_prop2_sale_date2_mm  := pk_yr_prop2_sale_date2_mm;
			self.pk_add2_land_use_risk_level_mm  := pk_add2_land_use_risk_level_mm;
			self.pk_add2_no_of_buildings_mm  := pk_add2_no_of_buildings_mm;
			self.pk_add2_no_of_stories_mm  := pk_add2_no_of_stories_mm;
			self.pk_add2_no_of_baths_mm  := pk_add2_no_of_baths_mm;
			self.pk_add2_garage_type_risk_lvl_mm  := pk_add2_garage_type_risk_lvl_mm;
			self.pk_add2_style_code_level_mm  := pk_add2_style_code_level_mm;
			self.pk_yr_add2_built_date2_mm  := pk_yr_add2_built_date2_mm;
			self.pk_add2_purchase_amount2_mm  := pk_add2_purchase_amount2_mm;
			self.pk_add2_mortgage_amount2_mm  := pk_add2_mortgage_amount2_mm;
			self.pk_add2_mortgage_risk_mm  := pk_add2_mortgage_risk_mm;
			self.pk_yr_add2_mortgage_due_date2_mm  := pk_yr_add2_mortgage_due_date2_mm;
			self.pk_add2_assessed_amount2_mm  := pk_add2_assessed_amount2_mm;
			self.pk_yr_add2_date_first_seen2_mm  := pk_yr_add2_date_first_seen2_mm;
			self.pk_yr_add2_date_last_seen2_mm  := pk_yr_add2_date_last_seen2_mm;
			self.pk_yr_add3_built_date2_mm  := pk_yr_add3_built_date2_mm;
			self.pk_add3_purchase_amount2_mm  := pk_add3_purchase_amount2_mm;
			self.pk_add3_mortgage_risk_mm  := pk_add3_mortgage_risk_mm;
			self.pk_yr_add3_mortgage_due_date2_mm  := pk_yr_add3_mortgage_due_date2_mm;
			self.pk_add3_assessed_amount2_mm  := pk_add3_assessed_amount2_mm;
			self.pk_yr_add3_date_first_seen2_mm  := pk_yr_add3_date_first_seen2_mm;
			self.pk_yr_add3_date_last_seen2_mm  := pk_yr_add3_date_last_seen2_mm;
			self.pk_yr_attr_dt_last_purch2_mm  := pk_yr_attr_dt_last_purch2_mm;
			self.pk_yr_attr_date_last_sale2_mm  := pk_yr_attr_date_last_sale2_mm;
			self.pk_attr_num_watercraft24_mm  := pk_attr_num_watercraft24_mm;
			self.pk_bk_level_mm  := pk_bk_level_mm;
			self.pk_eviction_level_mm  := pk_eviction_level_mm;
			self.pk_lien_type_level_mm  := pk_lien_type_level_mm;
			self.pk_yr_ln_unrel_cj_f_sn2_mm  := pk_yr_ln_unrel_cj_f_sn2_mm;
			self.pk_yr_ln_unrel_lt_f_sn2_mm  := pk_yr_ln_unrel_lt_f_sn2_mm;
			self.pk_yr_ln_unrel_ot_f_sn2_mm  := pk_yr_ln_unrel_ot_f_sn2_mm;
			self.pk_yr_ln_unrel_sc_f_sn2_mm  := pk_yr_ln_unrel_sc_f_sn2_mm;
			self.pk_yr_attr_dt_l_eviction2_mm  := pk_yr_attr_dt_l_eviction2_mm;
			self.pk_yr_criminal_last_date2_mm  := pk_yr_criminal_last_date2_mm;
			self.pk_crime_level_mm  := pk_crime_level_mm;
			self.pk_felony_recent_level_mm  := pk_felony_recent_level_mm;
			self.pk_attr_total_number_derogs_mm  := pk_attr_total_number_derogs_mm;
			self.pk_yr_rc_ssnhighissue2_mm  := pk_yr_rc_ssnhighissue2_mm;
			self.pk_PL_Sourced_Level_mm  := pk_PL_Sourced_Level_mm;
			self.pk_prof_lic_cat_mm  := pk_prof_lic_cat_mm;
			self.pk_add1_lres_mm  := pk_add1_lres_mm;
			self.pk_add2_lres_mm  := pk_add2_lres_mm;
			self.pk_add3_lres_mm  := pk_add3_lres_mm;
			self.pk_lres_flag_level_mm  := pk_lres_flag_level_mm;
			self.pk_avg_lres_mm  := pk_avg_lres_mm;
			self.pk_addrs_5yr_mm  := pk_addrs_5yr_mm;
			self.pk_addrs_10yr_mm  := pk_addrs_10yr_mm;
			self.pk_add_lres_year_avg2_mm  := pk_add_lres_year_avg2_mm;
			self.pk_add_lres_year_max2_mm  := pk_add_lres_year_max2_mm;
			self.pk_nameperssn_count_mm  := pk_nameperssn_count_mm;
			self.pk_ssns_per_adl_mm  := pk_ssns_per_adl_mm;
			self.pk_addrs_per_adl_mm  := pk_addrs_per_adl_mm;
			self.pk_phones_per_adl_mm  := pk_phones_per_adl_mm;
			self.pk_addrs_per_ssn_mm  := pk_addrs_per_ssn_mm;
			self.pk_adls_per_addr_mm  := pk_adls_per_addr_mm;
			self.pk_phones_per_addr_mm  := pk_phones_per_addr_mm;
			self.pk_adls_per_phone_mm  := pk_adls_per_phone_mm;
			self.pk_addrs_per_adl_c6_mm  := pk_addrs_per_adl_c6_mm;
			self.pk_phones_per_adl_c6_mm  := pk_phones_per_adl_c6_mm;
			self.pk_adls_per_addr_c6_mm  := pk_adls_per_addr_c6_mm;
			self.pk_ssns_per_addr_c6_mm  := pk_ssns_per_addr_c6_mm;
			self.pk_phones_per_addr_c6_mm  := pk_phones_per_addr_c6_mm;
			self.pk_adls_per_phone_c6_mm  := pk_adls_per_phone_c6_mm;
			self.pk_attr_addrs_last30_mm  := pk_attr_addrs_last30_mm;
			self.pk_attr_addrs_last36_mm  := pk_attr_addrs_last36_mm;
			self.pk_attr_addrs_last_level_mm  := pk_attr_addrs_last_level_mm;
			self.pk_ams_class_level_mm  := pk_ams_class_level_mm;
			self.pk_ams_income_level_code_mm  := pk_ams_income_level_code_mm;
			self.pk_ams_college_tier_mm  := pk_ams_college_tier_mm;
			self.pk_yr_rc_correct_dob2_mm  := pk_yr_rc_correct_dob2_mm;
			self.pk_ams_age_mm  := pk_ams_age_mm;
			self.pk_inferred_age_mm  := pk_inferred_age_mm;
			self.pk_add2_avm_auto_diff4_lvl_mm  := pk_add2_avm_auto_diff4_lvl_mm;
			self.pk2_add1_avm_sp_mm  := pk2_add1_avm_sp_mm;
			self.pk2_add1_avm_ta_mm  := pk2_add1_avm_ta_mm;
			self.pk2_add1_avm_pi_mm  := pk2_add1_avm_pi_mm;
			self.pk2_ADD1_AVM_MED_mm  := pk2_ADD1_AVM_MED_mm;
			self.pk2_add1_avm_to_med_ratio_mm  := pk2_add1_avm_to_med_ratio_mm;
			self.pk2_yr_add1_avm_rec_dt_mm  := pk2_yr_add1_avm_rec_dt_mm;
			self.pk2_yr_add1_avm_assess_year_mm  := pk2_yr_add1_avm_assess_year_mm;
			self.pk_dist_a1toa3_mm  := pk_dist_a1toa3_mm;
			self.pk_rc_disthphoneaddr_mm  := pk_rc_disthphoneaddr_mm;
			self.pk_out_st_division_lvl_mm  := pk_out_st_division_lvl_mm;
			self.pk_impulse_count_mm  := pk_impulse_count_mm;
			self.pk_derog_total_mm  := pk_derog_total_mm;
			self.pk_attr_num_nonderogs90_b_mm  := pk_attr_num_nonderogs90_b_mm;
			self.pk_add1_unit_count2_mm  := pk_add1_unit_count2_mm;
			self.pk_ssns_per_addr2_mm  := pk_ssns_per_addr2_mm;
			self.pk_yr_add1_assess_val_yr2_mm  := pk_yr_add1_assess_val_yr2_mm;
			self.pk_prop_owned_assess_count_mm  := pk_prop_owned_assess_count_mm;
			self.pk_yr_prop1_prev_purch_dt2_mm  := pk_yr_prop1_prev_purch_dt2_mm;
			self.pk_yr_prop2_prev_purch_dt2_mm  := pk_yr_prop2_prev_purch_dt2_mm;
			self.pk_yr_add2_assess_val_yr2_mm  := pk_yr_add2_assess_val_yr2_mm;
			self.pk_c_bargains_mm  := pk_c_bargains_mm;
			self.pk_c_bel_edu_mm  := pk_c_bel_edu_mm;
			self.pk_c_lowrent_mm  := pk_c_lowrent_mm;
			self.pk_c_med_hval_mm  := pk_c_med_hval_mm;
			self.pk_rel_count_mm  := pk_rel_count_mm;
			self.pk_rel_bankrupt_count_mm  := pk_rel_bankrupt_count_mm;
			self.pk_rel_felony_count_mm  := pk_rel_felony_count_mm;
			self.pk_crim_rel_within100miles_mm  := pk_crim_rel_within100miles_mm;
			self.pk_crim_rel_withinOther_mm  := pk_crim_rel_withinOther_mm;
			self.pk_rel_prop_owned_count_mm  := pk_rel_prop_owned_count_mm;
			self.pk_rel_prop_own_prch_tot2_mm  := pk_rel_prop_own_prch_tot2_mm;
			self.pk_rel_prop_owned_prch_cnt_mm  := pk_rel_prop_owned_prch_cnt_mm;
			self.pk_rel_prop_own_assess_tot2_mm  := pk_rel_prop_own_assess_tot2_mm;
			self.pk_rel_prop_owned_as_cnt_mm  := pk_rel_prop_owned_as_cnt_mm;
			self.pk_rel_prop_sold_count_mm  := pk_rel_prop_sold_count_mm;
			self.pk_rel_prop_sold_prch_tot2_mm  := pk_rel_prop_sold_prch_tot2_mm;
			self.pk_rel_prop_sold_as_tot2_mm  := pk_rel_prop_sold_as_tot2_mm;
			self.pk_rel_within25miles_count_mm  := pk_rel_within25miles_count_mm;
			self.pk_rel_incomeunder25_count_mm  := pk_rel_incomeunder25_count_mm;
			self.pk_rel_incomeunder50_count_mm  := pk_rel_incomeunder50_count_mm;
			self.pk_rel_incomeunder75_count_mm  := pk_rel_incomeunder75_count_mm;
			self.pk_rel_incomeunder100_count_mm  := pk_rel_incomeunder100_count_mm;
			self.pk_rel_incomeover100_count_mm  := pk_rel_incomeover100_count_mm;
			self.pk_rel_homeunder100_count_mm  := pk_rel_homeunder100_count_mm;
			self.pk_rel_homeunder200_count_mm  := pk_rel_homeunder200_count_mm;
			self.pk_rel_homeunder300_count_mm  := pk_rel_homeunder300_count_mm;
			self.pk_rel_homeunder500_count_mm  := pk_rel_homeunder500_count_mm;
			self.pk_rel_homeover500_count_mm  := pk_rel_homeover500_count_mm;
			self.pk_rel_educationunder12_count_mm  := pk_rel_educationunder12_count_mm;
			self.pk_rel_educationover12_count_mm  := pk_rel_educationover12_count_mm;
			self.pk_rel_ageunder30_count_mm  := pk_rel_ageunder30_count_mm;
			self.pk_rel_ageunder40_count_mm  := pk_rel_ageunder40_count_mm;
			self.pk_rel_ageunder50_count_mm  := pk_rel_ageunder50_count_mm;
			self.pk_rel_ageunder70_count_mm  := pk_rel_ageunder70_count_mm;
			self.pk_rel_ageover70_count_mm  := pk_rel_ageover70_count_mm;
			self.pk_rel_vehicle_owned_count_mm  := pk_rel_vehicle_owned_count_mm;
			self.pk_rel_count_addr_mm  := pk_rel_count_addr_mm;
			self.pk_attr_arrests24_mm  := pk_attr_arrests24_mm;
			self.pk_acc_damage_amt_total2_mm  := pk_acc_damage_amt_total2_mm;
			self.pk_acc_damage_amt_last2_mm  := pk_acc_damage_amt_last2_mm;
			self.pk_add1_fc_index_flag_mm  := pk_add1_fc_index_flag_mm;
			self.pk_current_count_mm  := pk_current_count_mm;
			self.pk_historical_count_mm  := pk_historical_count_mm;
			self.pk_add2_avm_med2_mm  := pk_add2_avm_med2_mm;
			self.Age_mod3_1M_a  := Age_mod3_1M_a;
			self.Age_mod3_1M  := Age_mod3_1M;
			self.Lien_mod_1M_a  := Lien_mod_1M_a;
			self.Lien_mod_1M  := Lien_mod_1M;
			self.LRes_mod_1M_a  := LRes_mod_1M_a;
			self.LRes_mod_1M  := LRes_mod_1M;
			self.ProfLic_mod_1M_a  := ProfLic_mod_1M_a;
			self.ProfLic_mod_1M  := ProfLic_mod_1M;
			self.Velocity2_mod_1M_a  := Velocity2_mod_1M_a;
			self.Velocity2_mod_1M  := Velocity2_mod_1M;
			self.ver_best_element_cnt_mod_1M_a  := ver_best_element_cnt_mod_1M_a;
			self.ver_best_element_cnt_mod_1M  := ver_best_element_cnt_mod_1M;
			self.ver_notbest_element_cnt_mod_1M_a  := ver_notbest_element_cnt_mod_1M_a;
			self.ver_notbest_element_cnt_mod_1M  := ver_notbest_element_cnt_mod_1M;
			self.ver_element_cnt_mod_1M  := ver_element_cnt_mod_1M;
			self.Relative_mod_1M_a  := Relative_mod_1M_a;
			self.Relative_mod_1M  := Relative_mod_1M;
			self.Utility_best_mod_1M_a  := Utility_best_mod_1M_a;
			self.Utility_best_mod_1M  := Utility_best_mod_1M;
			self.Utility_mod_1M  := Utility_mod_1M;
			self.ver_best_src_cnt_mod2_1M_a  := ver_best_src_cnt_mod2_1M_a;
			self.ver_best_src_cnt_mod2_1M  := ver_best_src_cnt_mod2_1M;
			self.ver_src_cnt_mod2_1M  := ver_src_cnt_mod2_1M;
			self.Utility_notbest_mod_1M_a  := Utility_notbest_mod_1M_a;
			self.Utility_notbest_mod_1M  := Utility_notbest_mod_1M;
			self.ver_notbest_src_cnt_mod2_1M_a  := ver_notbest_src_cnt_mod2_1M_a;
			self.ver_notbest_src_cnt_mod2_1M  := ver_notbest_src_cnt_mod2_1M;
			self.AVM_mod2_1M_a  := AVM_mod2_1M_a;
			self.AVM_mod2_1M  := AVM_mod2_1M;
			self.Property_mod2_1M_a  := Property_mod2_1M_a;
			self.Property_mod2_1M  := Property_mod2_1M;
			self.mod18_1M_a  := mod18_1M_a;
			self.mod18_1M  := mod18_1M;
			self.PK_Contact_Mod4  := PK_Contact_Mod4;
			self.LRes_mod_2M_a  := LRes_mod_2M_a;
			self.LRes_mod_2M  := LRes_mod_2M;
			self.ProfLic_mod_2M_a  := ProfLic_mod_2M_a;
			self.ProfLic_mod_2M  := ProfLic_mod_2M;
			self.Velocity2_mod_2M_a  := Velocity2_mod_2M_a;
			self.Velocity2_mod_2M  := Velocity2_mod_2M;
			self.Census_mod_2M_a  := Census_mod_2M_a;
			self.Census_mod_2M  := Census_mod_2M;
			self.Derog_mod4_2M_a  := Derog_mod4_2M_a;
			self.Derog_mod4_2M  := Derog_mod4_2M;
			self.Utility_best_mod_2M_a  := Utility_best_mod_2M_a;
			self.Utility_best_mod_2M  := Utility_best_mod_2M;
			self.Utility_mod_2M  := Utility_mod_2M;
			self.ver_best_src_time_mod2_2M_a  := ver_best_src_time_mod2_2M_a;
			self.ver_best_src_time_mod2_2M  := ver_best_src_time_mod2_2M;
			self.ver_best_src_cnt_mod2_2M_a  := ver_best_src_cnt_mod2_2M_a;
			self.ver_best_src_cnt_mod2_2M  := ver_best_src_cnt_mod2_2M;
			self.ver_src_time_mod2_2M  := ver_src_time_mod2_2M;
			self.ver_src_cnt_mod2_2M  := ver_src_cnt_mod2_2M;
			self.Utility_notbest_mod_2M_a  := Utility_notbest_mod_2M_a;
			self.Utility_notbest_mod_2M  := Utility_notbest_mod_2M;
			self.ver_notbest_src_time_mod2_2M_a  := ver_notbest_src_time_mod2_2M_a;
			self.ver_notbest_src_time_mod2_2M  := ver_notbest_src_time_mod2_2M;
			self.ver_notbest_src_cnt_mod2_2M_a  := ver_notbest_src_cnt_mod2_2M_a;
			self.ver_notbest_src_cnt_mod2_2M  := ver_notbest_src_cnt_mod2_2M;
			self.Property_mod2_2M_a  := Property_mod2_2M_a;
			self.Property_mod2_2M  := Property_mod2_2M;
			self.mod18_2M_a  := mod18_2M_a;
			self.mod18_2M  := mod18_2M;
			self.AddProb3_mod_3M_a  := AddProb3_mod_3M_a;
			self.AddProb3_mod_3M  := AddProb3_mod_3M;
			self.PhnProb_mod_3M_a  := PhnProb_mod_3M_a;
			self.PhnProb_mod_3M  := PhnProb_mod_3M;
			self.SSNProb2_mod_3M_a  := SSNProb2_mod_3M_a;
			self.SSNProb2_mod_3M  := SSNProb2_mod_3M;
			self.FP_mod5_3M_a  := FP_mod5_3M_a;
			self.FP_mod5_3M  := FP_mod5_3M;
			self.Age_mod3_3M_a  := Age_mod3_3M_a;
			self.Age_mod3_3M  := Age_mod3_3M;
			self.AMStudent_mod_3M_a  := AMStudent_mod_3M_a;
			self.AMStudent_mod_3M  := AMStudent_mod_3M;
			self.LRes_mod_3M_a  := LRes_mod_3M_a;
			self.LRes_mod_3M  := LRes_mod_3M;
			self.ProfLic_mod_3M_a  := ProfLic_mod_3M_a;
			self.ProfLic_mod_3M  := ProfLic_mod_3M;
			self.Velocity2_mod_3M_a  := Velocity2_mod_3M_a;
			self.Velocity2_mod_3M  := Velocity2_mod_3M;
			self.ver_best_score_mod_3M_a  := ver_best_score_mod_3M_a;
			self.ver_best_score_mod_3M  := ver_best_score_mod_3M;
			self.ver_notbest_score_mod_3M_a  := ver_notbest_score_mod_3M_a;
			self.ver_notbest_score_mod_3M  := ver_notbest_score_mod_3M;
			self.ver_score_mod_3M  := ver_score_mod_3M;
			self.Relative_mod_3M_a  := Relative_mod_3M_a;
			self.Relative_mod_3M  := Relative_mod_3M;
			self.Derog_mod4_3M_a  := Derog_mod4_3M_a;
			self.Derog_mod4_3M  := Derog_mod4_3M;
			self.Utility_best_mod_3M_a  := Utility_best_mod_3M_a;
			self.Utility_best_mod_3M  := Utility_best_mod_3M;
			self.Utility_mod_3M  := Utility_mod_3M;
			self.ver_best_src_time_mod2_3M_a  := ver_best_src_time_mod2_3M_a;
			self.ver_best_src_time_mod2_3M  := ver_best_src_time_mod2_3M;
			self.ver_best_src_cnt_mod2_3M_a  := ver_best_src_cnt_mod2_3M_a;
			self.ver_best_src_cnt_mod2_3M  := ver_best_src_cnt_mod2_3M;
			self.ver_src_time_mod2_3M  := ver_src_time_mod2_3M;
			self.ver_src_cnt_mod2_3M  := ver_src_cnt_mod2_3M;
			self.Utility_notbest_mod_3M_a  := Utility_notbest_mod_3M_a;
			self.Utility_notbest_mod_3M  := Utility_notbest_mod_3M;
			self.ver_notbest_src_time_mod2_3M_a  := ver_notbest_src_time_mod2_3M_a;
			self.ver_notbest_src_time_mod2_3M  := ver_notbest_src_time_mod2_3M;
			self.ver_notbest_src_cnt_mod2_3M_a  := ver_notbest_src_cnt_mod2_3M_a;
			self.ver_notbest_src_cnt_mod2_3M  := ver_notbest_src_cnt_mod2_3M;
			self.Property_mod2_3M_a  := Property_mod2_3M_a;
			self.Property_mod2_3M  := Property_mod2_3M;
			self.mod18_3M_a  := mod18_3M_a;
			self.mod18_3M  := mod18_3M;
			self.AddProb3_mod_4M_a  := AddProb3_mod_4M_a;
			self.AddProb3_mod_4M  := AddProb3_mod_4M;
			self.PhnProb_mod_4M_a  := PhnProb_mod_4M_a;
			self.PhnProb_mod_4M  := PhnProb_mod_4M;
			self.SSNProb2_mod_4M_a  := SSNProb2_mod_4M_a;
			self.SSNProb2_mod_4M  := SSNProb2_mod_4M;
			self.FP_mod5_4M_a  := FP_mod5_4M_a;
			self.FP_mod5_4M  := FP_mod5_4M;
			self.Age_mod3_4M_a  := Age_mod3_4M_a;
			self.Age_mod3_4M  := Age_mod3_4M;
			self.AMStudent_mod_4M_a  := AMStudent_mod_4M_a;
			self.AMStudent_mod_4M  := AMStudent_mod_4M;
			self.Distance_mod2_4M_a  := Distance_mod2_4M_a;
			self.Distance_mod2_4M  := Distance_mod2_4M;
			self.LRes_mod_4M_a  := LRes_mod_4M_a;
			self.LRes_mod_4M  := LRes_mod_4M;
			self.Velocity2_mod_4M_a  := Velocity2_mod_4M_a;
			self.Velocity2_mod_4M  := Velocity2_mod_4M;
			self.Relative_mod_4M_a  := Relative_mod_4M_a;
			self.Relative_mod_4M  := Relative_mod_4M;
			self.Utility_best_mod_4M_a  := Utility_best_mod_4M_a;
			self.Utility_best_mod_4M  := Utility_best_mod_4M;
			self.Utility_mod_4M  := Utility_mod_4M;
			self.ver_best_src_time_mod2_4M_a  := ver_best_src_time_mod2_4M_a;
			self.ver_best_src_time_mod2_4M  := ver_best_src_time_mod2_4M;
			self.ver_best_src_cnt_mod2_4M_a  := ver_best_src_cnt_mod2_4M_a;
			self.ver_best_src_cnt_mod2_4M  := ver_best_src_cnt_mod2_4M;
			self.ver_src_time_mod2_4M  := ver_src_time_mod2_4M;
			self.ver_src_cnt_mod2_4M  := ver_src_cnt_mod2_4M;
			self.Utility_notbest_mod_4M_a  := Utility_notbest_mod_4M_a;
			self.Utility_notbest_mod_4M  := Utility_notbest_mod_4M;
			self.ver_notbest_src_time_mod2_4M_a  := ver_notbest_src_time_mod2_4M_a;
			self.ver_notbest_src_time_mod2_4M  := ver_notbest_src_time_mod2_4M;
			self.ver_notbest_src_cnt_mod2_4M_a  := ver_notbest_src_cnt_mod2_4M_a;
			self.ver_notbest_src_cnt_mod2_4M  := ver_notbest_src_cnt_mod2_4M;
			self.Property_mod2_4M_a  := Property_mod2_4M_a;
			self.Property_mod2_4M  := Property_mod2_4M;
			self.mod18_4M_a  := mod18_4M_a;
			self.mod18_4M  := mod18_4M;
			self.Age_mod3_NoDob_1M_a  := Age_mod3_NoDob_1M_a;
			self.Age_mod3_NoDob_1M  := Age_mod3_NoDob_1M;
			self.ver_best_e_cnt_mod_1M_NoDob_a  := ver_best_e_cnt_mod_1M_NoDob_a;
			self.ver_best_e_cnt_mod_1M_NoDob  := ver_best_e_cnt_mod_1M_NoDob;
			self.ver_notbest_e_cnt_mod_1M_NoDob_a  := ver_notbest_e_cnt_mod_1M_NoDob_a;
			self.ver_notbest_e_cnt_mod_1M_NoDob  := ver_notbest_e_cnt_mod_1M_NoDob;
			self.ver_element_cnt_mod_1M_NoDob  := ver_element_cnt_mod_1M_NoDob;
			self.mod18_1M_NoDob_a  := mod18_1M_NoDob_a;
			self.mod18_1M_NoDob  := mod18_1M_NoDob;
			self.mod18_2M_NoDob_a  := mod18_2M_NoDob_a;
			self.mod18_2M_NoDob  := mod18_2M_NoDob;
			self.Age_mod3_NoDob_3M_a  := Age_mod3_NoDob_3M_a;
			self.Age_mod3_NoDob_3M  := Age_mod3_NoDob_3M;
			self.SSNProb2_mod_3M_NoDob_a  := SSNProb2_mod_3M_NoDob_a;
			self.SSNProb2_mod_3M_NoDob  := SSNProb2_mod_3M_NoDob;
			self.FP_mod5_3M_NoDob_a  := FP_mod5_3M_NoDob_a;
			self.FP_mod5_3M_NoDob  := FP_mod5_3M_NoDob;
			self.ver_best_score_mod_3M_NoDob_a  := ver_best_score_mod_3M_NoDob_a;
			self.ver_best_score_mod_3M_NoDob  := ver_best_score_mod_3M_NoDob;
			self.ver_notbest_score_mod_3M_NoDob_a  := ver_notbest_score_mod_3M_NoDob_a;
			self.ver_notbest_score_mod_3M_NoDob  := ver_notbest_score_mod_3M_NoDob;
			self.ver_score_mod_3M_NoDob  := ver_score_mod_3M_NoDob;
			self.mod18_3M_NoDob_a  := mod18_3M_NoDob_a;
			self.mod18_3M_NoDob  := mod18_3M_NoDob;
			self.Age_mod3_NoDob_4M_a  := Age_mod3_NoDob_4M_a;
			self.Age_mod3_NoDob_4M  := Age_mod3_NoDob_4M;
			self.SSNProb2_mod_4M_NoDob_a  := SSNProb2_mod_4M_NoDob_a;
			self.SSNProb2_mod_4M_NoDob  := SSNProb2_mod_4M_NoDob;
			self.FP_mod5_4M_NoDob_a  := FP_mod5_4M_NoDob_a;
			self.FP_mod5_4M_NoDob  := FP_mod5_4M_NoDob;
			self.mod18_4M_NoDob_a  := mod18_4M_NoDob_a;
			self.mod18_4M_NoDob  := mod18_4M_NoDob;
			self.phat  := phat;
			self.PK_Contact_Mod4_Scr  := PK_Contact_Mod4_Scr;
			self.CSN1007  := CSN1007;
			self.CSN1007_2  := CSN1007_2;
		#else
			self.score := (string3)csn1007_2;
			self.ri := [];
		#end

	END;

	model := join( cclam, easi.key_easi_census, keyed(left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk=right.geolink),
		doModel(left,right), left outer, keep(1));

	return model;
END;

