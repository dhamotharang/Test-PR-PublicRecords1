
IMPORT ut, Std, RiskWise,Risk_Indicators, riskview;

EXPORT RVS1706_0_0(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
Integer seq;
Integer	 sysdate;
Real	 ver_src_ak_pos;
boolean	 ver_src_ak;
String	 _ver_src_fdate_ak;
String	 ver_src_fdate_ak;
Real	 ver_src_am_pos;
Boolean	 ver_src_am;
String	 _ver_src_fdate_am;
String	 ver_src_fdate_am;
Real	 ver_src_ar_pos;
Boolean	 ver_src_ar;
String	 _ver_src_fdate_ar;
String	 ver_src_fdate_ar;
String	 ver_src_ba_pos;
Boolean	 ver_src_ba;
String	 _ver_src_fdate_ba;
String ver_src_fdate_ba;
Real	 ver_src_cg_pos;
Boolean	 ver_src_cg;
String	 _ver_src_fdate_cg;
String	 ver_src_fdate_cg;
Real	 ver_src_co_pos;
String	 _ver_src_fdate_co;
String	 ver_src_fdate_co;
String	 ver_src_cy_pos;
Boolean	 ver_src_cy;
String	 _ver_src_fdate_cy;
String	 ver_src_fdate_cy;
real	 ver_src_da_pos;
Boolean	 ver_src_da;
String	 _ver_src_fdate_da;
String	 ver_src_fdate_da;
String	 ver_src_d_pos;
Boolean	 ver_src_d;
String	 _ver_src_fdate_d;
String	 ver_src_fdate_d;
String	 ver_src_dl_pos;
Boolean	 ver_src_dl;
String	 _ver_src_fdate_dl;
String	 ver_src_fdate_dl;
String	 ver_src_ds_pos;
Boolean	 ver_src_ds;
String _ver_src_fdate_ds;
String	 ver_src_fdate_ds;
String	 ver_src_de_pos;
Boolean	 ver_src_de;
String	 _ver_src_fdate_de;
String	 ver_src_fdate_de;
String	 ver_src_eb_pos;
Boolean	 ver_src_eb;
String	 _ver_src_fdate_eb;
String	 ver_src_fdate_eb;
String	 ver_src_em_pos;
Boolean	 ver_src_em;
String	 _ver_src_fdate_em;
String	 ver_src_fdate_em;
String	 ver_src_e1_pos;
Boolean	 ver_src_e1;
String	 _ver_src_fdate_e1;
String	 ver_src_fdate_e1;
String	 ver_src_e2_pos;
Boolean	 ver_src_e2;
String	 _ver_src_fdate_e2;
String	 ver_src_fdate_e2;
Real	 ver_src_e3_pos;
Boolean	 ver_src_e3;
Real	 _ver_src_fdate_e3;
String	 ver_src_fdate_e3;
String	 ver_src_e4_pos;
Boolean	 ver_src_e4;
String	 _ver_src_fdate_e4;
String	 ver_src_fdate_e4;
String	 ver_src_en_pos;
Boolean	 ver_src_en;
Real	 _ver_src_fdate_en;
String	 ver_src_fdate_en;
String	 ver_src_eq_pos;
Boolean	 ver_src_eq;
String	 _ver_src_fdate_eq;
String	 ver_src_fdate_eq;
String	 ver_src_fe_pos;
Boolean	 ver_src_fe;
String	 _ver_src_fdate_fe;
String	 ver_src_fdate_fe;
String	 ver_src_ff_pos;
Boolean	 ver_src_ff;
String	 _ver_src_fdate_ff;
String	 ver_src_fdate_ff;
String	 ver_src_fr_pos;
Boolean	 ver_src_fr;
Real	 _ver_src_fdate_fr;
String	 ver_src_fdate_fr;
String	 ver_src_l2_pos;
Boolean	 ver_src_l2;
String	 _ver_src_fdate_l2;
String	 ver_src_fdate_l2;
String	 ver_src_li_pos;
Boolean	 ver_src_li;
String	 _ver_src_fdate_li;
String	 ver_src_fdate_li;
Real	 ver_src_mw_pos;
Boolean	 ver_src_mw;
Real	 _ver_src_fdate_mw;
String	 ver_src_fdate_mw;
String	 ver_src_nt_pos;
String	 ver_src_nt;
Real	 _ver_src_fdate_nt;
String	 ver_src_fdate_nt;
Real	 ver_src_p_pos;
Boolean	 ver_src_p;
Real	 _ver_src_fdate_p;
String	 ver_src_fdate_p;
Real	 ver_src_pl_pos;
Boolean	 ver_src_pl;
Real	 _ver_src_fdate_pl;
String	 ver_src_fdate_pl;
Real	 ver_src_tn_pos;
Boolean	 ver_src_tn;
Real	 _ver_src_fdate_tn;
String	 ver_src_fdate_tn;
Real	 ver_src_ts_pos;
Boolean ver_src_ts;
Real	 _ver_src_fdate_ts;
String	 ver_src_fdate_ts;
Real	 ver_src_tu_pos;
Boolean	 ver_src_tu;
Real	 _ver_src_fdate_tu;
String	 ver_src_fdate_tu;
String	 ver_src_sl_pos;
String	 ver_src_sl;
Real	 _ver_src_fdate_sl;
String	 ver_src_fdate_sl;
String	 ver_src_v_pos;
String	 ver_src_v;
Real	 _ver_src_fdate_v;
String	 ver_src_fdate_v;
Real	 ver_src_vo_pos;
Boolean	 ver_src_vo;
Real	 _ver_src_fdate_vo;
String	 ver_src_fdate_vo;
String	 ver_src_w_pos;
String	 ver_src_w;
Real	 _ver_src_fdate_w;
String	 ver_src_fdate_w;
Real	 ver_src_wp_pos;
Boolean	 ver_src_wp;
Real	 _ver_src_fdate_wp;
String	 ver_src_fdate_wp;
Real	 ver_fname_src_en_pos;
Boolean	 ver_fname_src_en;
String	 ver_fname_src_eq_pos;
String	 ver_fname_src_eq;
String	 ver_fname_src_tn_pos;
String	 ver_fname_src_tn;
String	 ver_fname_src_ts_pos;
String	 ver_fname_src_ts;
String	 ver_fname_src_tu_pos;
String	 ver_fname_src_tu;
String	 ver_lname_src_en_pos;
String	 ver_lname_src_en;
String	 ver_lname_src_eq_pos;
String	 ver_lname_src_eq;
String	 ver_lname_src_tn_pos;
String	 ver_lname_src_tn;
String	 ver_lname_src_ts_pos;
String	 ver_lname_src_ts;
String	 ver_lname_src_tu_pos;
String	 ver_lname_src_tu;
Integer	 ver_addr_src_en_pos;
Boolean	 ver_addr_src_en;
Integer	 ver_addr_src_eq_pos;
Boolean	 ver_addr_src_eq;
Integer	 ver_addr_src_tn_pos;
String	 ver_addr_src_tn;
String	 ver_addr_src_ts_pos;
String	 ver_addr_src_ts;
String	 ver_addr_src_tu_pos;
String	 ver_addr_src_tu;
String	 ver_ssn_src_en_pos;
String	 ver_ssn_src_en;
String	 ver_ssn_src_eq_pos;
String	 ver_ssn_src_eq;
String	 ver_ssn_src_tn_pos;
String	 ver_ssn_src_tn;
String	 ver_ssn_src_ts_pos;
String	 ver_ssn_src_ts;
String	 ver_ssn_src_tu_pos;
String	 ver_ssn_src_tu;
String	 ver_dob_src_en_pos;
String	 ver_dob_src_en;
String	 ver_dob_src_eq_pos;
String	 ver_dob_src_eq;
String	 ver_dob_src_tn_pos;
String	 ver_dob_src_tn;
String	 ver_dob_src_ts_pos;
String	 ver_dob_src_ts;
String	 ver_dob_src_tu_pos;
String	 ver_dob_src_tu;
String	 iv_add_apt;
String	 iv_rv5_unscorable;
String	 rv_d30_derog_count;
String	 rv_a44_curr_add_naprop;
String	 rv_c13_inp_addr_lres;
Integer	 iv_f00_nas_summary;
Integer	 iv_college_tier;
String	 iv_c22_addr_ver_sources;
String	 rv_f00_addr_not_ver_w_ssn;
String	 iv_a46_l77_addrs_move_traj_index;
String	 rv_d33_eviction_recency;
String	 iv_num_non_bureau_sources;
String	 iv_input_best_phone_match;
String	 rv_i60_inq_hiriskcred_count12;
String	 rv_email_domain_free_count;
String	 yr_in_dob;
String	 yr_in_dob_int;
String	 rv_comb_age;
String	 iv_unverified_addr_count;
String	 iv_br_source_count;
String	 iv_c13_avg_lres;
String	 rv_s66_adlperssn_count;
String	 _felony_last_date;
String	 rv_d32_criminal_behavior_lvl;
String	 rv_i62_inq_addrs_per_adl;
String	 rv_f01_inp_addr_address_score;
String	 _criminal_last_date;
String	 rv_d32_mos_since_crim_ls;
String	 src_bureau;
String	 src_behavioral;
String	 src_inperson;
String	 iv_source_type;
String	 rv_l79_adls_per_sfd_addr_c6;
String	 _in_dob;
String	 earliest_bureau_date;
String	 earliest_bureau_yrs;
String	 calc_dob;
String	 non_bureau_sources;
String	 iv_bureau_emergence_age_buronly;
String	 earliest_header_date;
String	 earliest_header_yrs;
String	 iv_header_emergence_age;
String	 rv_a49_curr_avm_chg_1yr_pct;
String	 iv_prv_addr_lres;
String	 num_bureau_fname;
String	 num_bureau_lname;
String	 num_bureau_addr;
String	 num_bureau_ssn;
String	 num_bureau_dob;
String	 iv_bureau_verification_index;
String	 iv_college_code;
Integer	 rv_f00_dob_score;
String	 rv_f00_ssn_score;
String	 rv_f00_input_dob_match_level;
String	 rv_d31_bk_filing_count;
String	 rv_d31_mostrec_bk;
String	 rv_l79_adls_per_addr_c6;
String	 iv_d34_liens_unrel_sc_ct;
String	 rv_p85_phn_risk_level;
String	 rv_c14_addrs_10yr;
String	 rv_c20_m_bureau_adl_fs;
String	 rv_l79_adls_per_sfd_addr;
String	 rv_i62_inq_num_names_per_adl;
String	 rv_l79_adls_per_addr_curr;
String	 num_addr_sources;
String	 iv_addr_bureau_only;
String	 rv_c19_add_prison_hist;
String	 rv_c21_stl_inq_count;
String	 iv_prof_license_category;
String	 rv_l72_add_curr_vacant;
String	 rv_i62_inq_phonesperadl_recency;
String	 final_score_0;
String	 final_score_1;
String	 rc006_1_1;
String	 rc001_1_2;
String	 rc005_1_8;
String	 rc001_1_6;
String	 rc002_1_7;
String	 rc002_2_10;
String	 final_score_2;
String	 rc005_2_2;
String	 rc001_2_9;
String	 rc003_2_1;
String	 rc001_2_4;
String	 rc009_3_11;
String	 final_score_3;
String	 rc004_3_1;
String	 rc005_3_2;
String	 rc001_3_6;
String	 rc002_3_7;
String	 final_score_4;
String	 rc005_4_8;
String	 rc002_4_2;
String	 rc001_4_7;
String	 rc002_4_6;
String	 rc003_4_1;
String	 rc001_5_3;
String	 final_score_5;
String	 rc007_5_1;
String	 rc002_5_2;
String	 rc005_5_12;
String	 rc005_5_4;
String	 rc004_6_1;
String	 rc002_6_2;
String	 final_score_6;
String	 rc001_6_7;
String	 rc005_6_8;
String	 rc008_6_6;
String	 rc001_7_9;
String	 rc010_7_10;
String	 rc001_7_4;
String	 rc003_7_1;
String	 rc005_7_2;
String	 final_score_7;
String	 final_score_8;
String	 rc002_8_1;
String	 rc009_8_3;
String	 rc007_8_2;
String	 rc014_8_5;
String	 rc012_8_7;
String	 rc002_9_1;
String	 rc014_9_6;
String	 final_score_9;
String	 rc019_9_8;
String	 rc006_9_2;
String	 rc009_9_4;
String	 final_score_10;
String	 rc001_10_2;
String	 rc003_10_1;
String	 rc002_10_9;
String	 rc005_10_3;
String	 rc001_10_10;
String	 final_score_11;
String	 rc008_11_9;
String	 rc001_11_2;
String	 rc005_11_3;
String	 rc004_11_1;
String	 rc005_11_10;
String	 rc005_12_2;
String	 final_score_12;
String	 rc019_12_4;
String	 rc012_12_9;
String	 rc011_12_10;
String	 rc003_12_1;
String	 rc002_13_1;
String	 rc022_13_6;
String	 rc009_13_4;
String	 rc016_13_8;
String	 rc005_13_2;
String	 final_score_13;
String	 rc023_14_3;
String	 rc007_14_1;
String	 rc020_14_2;
String	 rc009_14_8;
String	 final_score_14;
String	 rc001_14_4;
String	 rc017_15_6;
String	 rc008_15_1;
String	 final_score_15;
String	 rc009_15_4;
String	 rc010_15_12;
String	 rc005_15_2;
String	 final_score_16;
String	 rc002_16_1;
String	 rc016_16_3;
String	 rc029_16_4;
String	 rc011_16_2;
String	 rc022_16_5;
String	 rc015_17_3;
String	 rc010_17_2;
String	 rc020_17_7;
String	 rc001_17_1;
String	 final_score_17;
String	 rc010_17_12;
String	 rc013_18_6;
String	 rc011_18_4;
String	 rc019_18_5;
String	 final_score_18;
String	 rc002_18_1;
String	 rc005_18_2;
String	 rc001_19_6;
String	 rc017_19_1;
String	 final_score_19;
String	 rc025_19_4;
String	 rc005_19_2;
String	 rc012_19_12;
String	 rc001_20_4;
String	 final_score_20;
String	 rc021_20_1;
String	 rc010_20_9;
String	 rc014_20_5;
String	 rc008_21_1;
String	 rc024_21_4;
String	 rc033_21_12;
String	 rc017_21_2;
String	 final_score_21;
String	 rc021_21_5;
String	 rc016_22_2;
String	 rc017_22_5;
String	 rc018_22_4;
String	 rc002_22_1;
String	 final_score_22;
String	 rc029_22_3;
String	 final_score_23;
String	 rc001_23_1;
String	 rc028_23_8;
String	 rc024_23_4;
String	 rc023_23_3;
String	 rc012_23_2;
String	 rc002_24_10;
String	 rc013_24_3;
String	 final_score_24;
String	 rc022_24_4;
String	 rc011_24_1;
String	 rc018_24_2;
String	 rc028_25_8;
String	 rc032_25_3;
String	 rc015_25_9;
String	 final_score_25;
String	 rc009_25_1;
String	 rc015_25_4;
String	 rc016_26_4;
String	 rc011_26_1;
String	 rc013_26_5;
String	 final_score_26;
String	 rc022_26_6;
String	 rc005_26_2;
String	 rc008_27_6;
String	 rc001_27_1;
String	 rc033_27_3;
String	 rc034_27_12;
String	 rc012_27_2;
String	 final_score_27;
String	 rc028_28_4;
String	 rc019_28_9;
String	 rc015_28_5;
String	 final_score_28;
String	 rc013_28_1;
String	 rc032_28_2;
String	 rc013_29_2;
String	 final_score_29;
String	 rc014_29_1;
String	 rc010_29_11;
String	 rc020_29_7;
String	 rc001_29_6;
String	 rc009_30_12;
String	 rc015_30_2;
String	 rc002_30_4;
String	 rc008_30_5;
String	 final_score_30;
String	 rc010_30_1;
String	 rc017_31_11;
String	 final_score_31;
String	 rc027_31_7;
String	 rc030_31_9;
String	 rc026_31_1;
String	 rc019_31_3;
String	 rc012_32_2;
String	 final_score_32;
String	 rc036_32_3;
String	 rc013_32_8;
String	 rc018_32_1;
String	 rc019_32_4;
String	 rc027_33_4;
String	 rc024_33_10;
String	 final_score_33;
String	 rc031_33_2;
String	 rc021_33_1;
String	 rc020_33_9;
String	 rc005_34_3;
String	 final_score_34;
String	 rc025_34_6;
String	 rc016_34_1;
String	 rc024_34_5;
String	 rc011_34_2;
String	 rc016_35_3;
String	 final_score_35;
String	 rc011_35_2;
String	 rc030_35_6;
String	 rc005_35_4;
String	 rc001_35_1;
String	 final_score_36;
String	 rc017_36_9;
String	 rc039_36_2;
String	 rc031_36_11;
String	 rc031_36_4;
String	 rc027_36_1;
String	 final_score_37;
String	 rc037_37_7;
String	 rc026_37_12;
String	 rc013_37_3;
String	 rc018_37_1;
String	 rc014_37_2;
String	 rc015_38_7;
String	 rc026_38_3;
String	 final_score_38;
String	 rc016_38_6;
String	 rc019_38_2;
String	 rc013_38_1;
String	 rc017_39_6;
String	 rc011_39_3;
String	 rc030_39_8;
String	 final_score_39;
String	 rc027_39_4;
String	 rc009_39_1;
String	 rc030_40_7;
String	 rc015_40_4;
String	 rc040_40_3;
String	 rc005_40_1;
String	 rc028_40_6;
String	 final_score_40;
String	 rc009_41_3;
String	 rc018_41_1;
String	 rc010_41_12;
String	 final_score_41;
String	 rc023_41_5;
String	 rc012_41_2;
String	 rc017_42_7;
String	 rc001_42_3;
String	 rc018_42_9;
String	 final_score_42;
String	 rc027_42_2;
String	 rc012_42_1;
String	 final_score_43;
String	 rc022_43_4;
String	 rc024_43_1;
String	 rc014_43_2;
String	 rc031_43_12;
String	 rc013_43_6;
String	 rc008_44_2;
String	 rc015_44_3;
String	 rc012_44_1;
String	 rc033_44_10;
String	 final_score_44;
String	 rc010_44_5;
String	 rc014_45_1;
String	 rc021_45_7;
String	 rc037_45_9;
String	 final_score_45;
String	 rc019_45_6;
String	 rc013_45_2;
String	 rc018_46_1;
String	 final_score_46;
String	 rc025_46_2;
String	 rc010_46_7;
String	 rc016_46_6;
String	 rc026_46_8;
String	 rc015_47_6;
String	 rc028_47_5;
String	 rc038_47_1;
String	 rc008_47_2;
String	 final_score_47;
String	 rc015_47_3;
String	 rc031_48_1;
String	 rc014_48_9;
String	 rc010_48_3;
String	 rc025_48_5;
String	 final_score_48;
String	 rc013_48_4;
String	 final_score_49;
String	 rc011_49_6;
String	 rc035_49_1;
String	 rc001_49_3;
String	 rc034_49_2;
String	 rc049_49_4;
String	 rc015_50_6;
String	 rc029_50_1;
String	 final_score_50;
String	 rc028_50_5;
String	 rc024_50_2;
String	 rc030_50_3;
String	 rc024_51_5;
String	 rc014_51_12;
String	 rc011_51_2;
String	 rc005_51_3;
String	 final_score_51;
String	 rc013_51_1;
String	 rc027_52_2;
String	 rc008_52_3;
String	 rc013_52_9;
String	 final_score_52;
String	 rc014_52_11;
String	 rc036_52_1;
String	 rc014_53_4;
String	 rc018_53_1;
String	 rc032_53_2;
String	 final_score_53;
String	 rc025_53_13;
String	 rc017_53_6;
String	 rc045_54_6;
String	 final_score_54;
String	 rc032_54_7;
String	 rc016_54_1;
String	 rc038_54_2;
String	 rc026_54_3;
String	 rc029_55_2;
String	 rc015_55_7;
String	 final_score_55;
String	 rc016_55_3;
String	 rc026_55_4;
String	 rc013_55_1;
String	 final_score_56;
String	 rc044_56_7;
String	 rc015_56_2;
String	 rc017_56_8;
String	 rc041_56_6;
String	 rc021_56_1;
String	 rc031_57_1;
String	 rc011_57_3;
String	 rc001_57_4;
String	 rc010_57_6;
String	 final_score_57;
String	 rc045_57_5;
String	 rc025_58_2;
String	 rc037_58_1;
String	 rc031_58_7;
String	 rc017_58_3;
String	 rc013_58_9;
String	 final_score_58;
String	 rc025_59_4;
String	 rc013_59_1;
String	 final_score_59;
String	 rc030_59_2;
String	 rc019_59_6;
String	 rc035_59_7;
String	 final_score_60;
String	 rc047_60_4;
String	 rc045_60_6;
String	 rc009_60_1;
String	 rc019_60_5;
String	 rc046_60_3;
String	 rc048_61_1;
String	 rc005_61_4;
String	 rc034_61_6;
String	 rc035_61_8;
String	 rc030_61_2;
String	 final_score_61;
String	 rc009_62_8;
String	 final_score_62;
String	 rc045_62_7;
String	 rc025_62_1;
String	 rc018_62_6;
String	 rc017_62_2;
String	 rc027_63_1;
String	 rc017_63_7;
String	 rc037_63_6;
String	 rc014_63_9;
String	 final_score_63;
String	 rc039_63_2;
String	 rc030_64_2;
String	 rc037_64_7;
String	 rc046_64_1;
String	 rc034_64_8;
String	 rc033_64_4;
String	 final_score_64;
String	 rc015_65_9;
String	 rc026_65_2;
String	 rc023_65_11;
String	 rc036_65_1;
String	 final_score_65;
String	 rc020_65_4;
String	 rc014_66_1;
String	 rc015_66_6;
String	 rc040_66_11;
String	 rc041_66_7;
String	 final_score_66;
String	 rc015_66_2;
String	 rc035_67_2;
String	 final_score_67;
String	 rc031_67_10;
String	 rc015_67_6;
String	 rc036_67_1;
String	 rc010_67_8;
String	 rc008_68_3;
String	 final_score_68;
String	 rc015_68_5;
String	 rc010_68_4;
String	 rc012_68_1;
String	 rc041_68_2;
String	 final_score_69;
String	 rc025_69_11;
String	 rc038_69_1;
String	 rc014_69_7;
String	 rc018_69_2;
String	 rc016_69_3;
String	 rc017_70_4;
String	 rc001_70_3;
String	 rc026_70_1;
String	 rc047_70_10;
String	 rc043_70_11;
String	 final_score_70;
String	 rc013_71_2;
String	 rc038_71_4;
String	 rc001_71_1;
String	 rc048_71_3;
String	 final_score_71;
String	 rc041_71_5;
String	 final_score_72;
String	 rc029_72_2;
String	 rc016_72_1;
String	 rc015_72_4;
String	 rc040_72_3;
String	 rc027_72_6;
String	 rc012_73_3;
String	 rc001_73_4;
String	 rc010_73_10;
String	 rc015_73_11;
String	 final_score_73;
String	 rc026_73_1;
String	 final_score_74;
String	 rc011_74_11;
String	 rc013_74_2;
String	 rc043_74_6;
String	 rc014_74_1;
String	 rc031_74_7;
String	 rc009_75_2;
String	 rc028_75_8;
String	 final_score_75;
String	 rc046_75_1;
String	 rc023_75_6;
String	 rc015_75_4;
String	 rc043_76_3;
String	 rc010_76_4;
String	 rc030_76_1;
String	 final_score_76;
String	 rc015_76_5;
String	 rc028_76_7;
String	 final_score_77;
String	 rc001_77_8;
String	 rc002_77_3;
String	 rc043_77_4;
String	 rc035_77_1;
String	 rc034_77_2;
String	 rc031_78_2;
String	 rc046_78_7;
String	 final_score_78;
String	 rc033_78_4;
String	 rc033_78_11;
String	 rc038_78_1;
String	 rc037_79_4;
String	 rc045_79_2;
String	 final_score_79;
String	 rc040_79_8;
String	 rc018_79_3;
String	 rc019_79_1;
String	 rc016_80_3;
String	 rc022_80_4;
String	 rc027_80_6;
String	 final_score_80;
String	 rc037_80_2;
String	 rc013_80_1;
String	 rc015_81_4;
String	 rc040_81_6;
String	 rc011_81_2;
String	 rc020_81_1;
String	 final_score_81;
String	 rc034_81_3;
String	 rc025_82_1;
String	 rc001_82_11;
String	 rc032_82_3;
String	 rc013_82_2;
String	 rc026_82_9;
String	 final_score_82;
String	 rc018_83_1;
String	 rc039_83_13;
String	 rc034_83_3;
String	 rc041_83_4;
String	 final_score_83;
String	 rc035_83_2;
String	 rc025_84_13;
String	 rc018_84_1;
String	 rc001_84_2;
String	 rc005_84_4;
String	 final_score_84;
String	 rc044_85_7;
String	 rc041_85_6;
String	 final_score_85;
String	 rc014_85_2;
String	 rc018_85_1;
String	 rc028_85_4;
String	 rc015_86_1;
String	 final_score_86;
String	 rc023_86_9;
String	 rc017_86_11;
String	 rc018_86_2;
String	 rc025_86_5;
String	 rc015_87_3;
String	 rc035_87_1;
String	 rc031_87_8;
String	 final_score_87;
String	 rc034_87_7;
String	 rc032_87_2;
String	 rc041_88_7;
String	 rc013_88_1;
String	 final_score_88;
String	 rc021_88_2;
String	 rc014_88_10;
String	 rc048_88_3;
String	 rc023_89_5;
String	 rc001_89_12;
String	 rc015_89_3;
String	 final_score_89;
String	 rc029_89_1;
String	 rc040_89_2;
String	 rc025_90_1;
String	 rc026_90_6;
String	 final_score_90;
String	 rc011_90_10;
String	 rc030_90_2;
String	 rc037_90_9;
String	 rc030_91_2;
String	 final_score_91;
String	 rc009_91_4;
String	 rc029_91_7;
String	 rc047_91_6;
String	 rc035_91_1;
String	 rc047_92_3;
String	 rc035_92_4;
String	 rc031_92_1;
String	 rc034_92_5;
String	 rc009_92_6;
String	 final_score_92;
String	 rc010_93_4;
String	 rc048_93_5;
String	 rc046_93_1;
String	 rc031_93_2;
String	 final_score_93;
String	 rc014_93_12;
String	 final_score_94;
String	 rc039_94_4;
String	 rc017_94_8;
String	 rc035_94_1;
String	 rc045_94_2;
String	 rc027_94_3;
String	 rc022_95_2;
String	 rc045_95_4;
String	 rc013_95_6;
String	 final_score_95;
String	 rc012_95_5;
String	 rc037_95_1;
String	 rc025_96_10;
String	 rc018_96_1;
String	 rc024_96_12;
String	 rc032_96_6;
String	 rc009_96_2;
String	 final_score_96;
String	 rc044_97_7;
String	 rc023_97_12;
String	 rc043_97_2;
String	 rc014_97_3;
String	 final_score_97;
String	 rc015_97_1;
String	 rc011_98_2;
String	 rc033_98_13;
String	 rc018_98_1;
String	 final_score_98;
String	 rc030_98_3;
String	 rc043_98_5;
String	 rc015_99_2;
String	 rc012_99_3;
String	 final_score_99;
String	 rc014_99_9;
String	 rc018_99_1;
String	 rc025_99_13;
String	 rc017_100_7;
String	 rc027_100_1;
String	 rc036_100_12;
String	 rc039_100_2;
String	 final_score_100;
String	 rc025_100_3;
String	 rc043_101_4;
String	 rc016_101_3;
String	 rc007_101_12;
String	 rc038_101_1;
String	 final_score_101;
String	 rc024_101_2;
String	 final_score_102;
String	 rc039_102_2;
String	 rc020_102_6;
String	 rc027_102_1;
String	 rc001_102_10;
String	 rc036_102_13;
String	 rc029_103_3;
String	 final_score_103;
String	 rc047_103_1;
String	 rc016_103_2;
String	 rc043_103_5;
String	 rc010_103_4;
String	 rc015_104_1;
String	 rc040_104_6;
String	 final_score_104;
String	 rc016_104_3;
String	 rc015_104_4;
String	 rc034_104_2;
String	 rc014_105_1;
String	 final_score_105;
String	 rc013_105_8;
String	 rc013_105_2;
String	 rc028_105_6;
String	 rc037_105_9;
String	 final_score_106;
String	 rc043_106_1;
String	 rc015_106_11;
String	 rc044_106_6;
String	 rc014_106_2;
String	 rc041_106_7;
String	 rc017_107_9;
String	 rc046_107_1;
String	 final_score_107;
String	 rc038_107_3;
String	 rc047_107_2;
String	 rc013_107_4;
String	 rc009_108_1;
String	 rc039_108_2;
String	 rc026_108_11;
String	 final_score_108;
String	 rc013_108_7;
String	 rc024_108_6;
String	 rc026_109_1;
String	 final_score_109;
String	 rc034_109_13;
String	 rc012_109_3;
String	 rc019_109_4;
String	 rc018_109_5;
String	 rc026_110_4;
String	 rc028_110_3;
String	 rc044_110_11;
String	 final_score_110;
String	 rc015_110_1;
String	 rc034_110_7;
String	 rc038_111_3;
String	 rc044_111_7;
String	 rc043_111_2;
String	 rc035_111_1;
String	 final_score_111;
String	 rc033_111_9;
String	 aa_rc001;
String	 aa_rc002;
String	 aa_rc003;
String	 aa_rc004;
String	 aa_rc005;
String	 aa_rc006;
String	 aa_rc007;
String	 aa_rc008;
String	 aa_rc009;
String	 aa_rc010;
String	 aa_rc011;
String	 aa_rc012;
String	 aa_rc013;
String	 aa_rc014;
String	 aa_rc015;
String	 aa_rc016;
String	 aa_rc017;
String	 aa_rc018;
String	 aa_rc019;
String	 aa_rc020;
String	 aa_rc021;
String	 aa_rc022;
String	 aa_rc023;
String	 aa_rc024;
String	 aa_rc025;
String	 aa_rc026;
String	 aa_rc027;
String	 aa_rc028;
String	 aa_rc029;
String	 aa_rc030;
String	 aa_rc031;
String	 aa_rc032;
String	 aa_rc033;
String	 aa_rc034;
String	 aa_rc035;
String	 aa_rc036;
String	 aa_rc037;
String	 aa_rc038;
String	 aa_rc039;
String	 aa_rc040;
String	 aa_rc041;
String	 aa_rc043;
String	 aa_rc044;
String	 aa_rc045;
String	 aa_rc046;
String	 aa_rc047;
String	 aa_rc048;
String	 aa_rc049;
String	 final_score;
String	 base;
String	 point;
String	 odds;
String	 score_lnodds;
String	 deceased;
String	 RVS1706_0;
String	 a46_addrs_move_traj_index;
String	 l77_addrs_move_traj_index;
String	 e55_college_tier;
String	 e56_college_code;
String	 e55_college_code;
String	 e56_college_tier;
String	 i60_inq_addrs_per_adl;
String	 i62_inq_addrs_per_adl;
String	 rc_a44;
String	 rc_a46;
String	 rc_a49;
String	 rc_c12;
String	 rc_c13;
String	 rc_c14;
String	 rc_c19;
String	 rc_c20;
String	 rc_c21;
String	 rc_c22;
String	 rc_c23;
String	 rc_c24;
String	 rc_c25;
String	 rc_c26;
String	 rc_c27;
String	 rc_c28;
String	 rc_e55;
String	 rc_e56;
String	 rc_e57;
String	 rc_f00;
String	 rc_f01;
String	 rc_f05;
String	 rc_i60;
String	 rc_i62;
String	 rc_l72;
String	 rc_l77;
String	 rc_l79;
String	 rc_p85;
String	 rc_s66;
String	 other_rcs_gt_d30_count;
String	 rc_d31;
String	 rc_d34;
String	 rc_d30;
String	 rc_d33;
String	 rc_d32;
String	 n_rc_a44;
String	 n_rc_a46;
String	 n_rc_a49;
String	 n_rc_c12;
String	 n_rc_c13;
String	 n_rc_c14;
String	 n_rc_c19;
String	 n_rc_c20;
String	 n_rc_c21;
String	 n_rc_c22;
String	 n_rc_c23;
String	 n_rc_c24;
String	 n_rc_c25;
String	 n_rc_c26;
String	 n_rc_c27;
String	 n_rc_c28;
String	 n_rc_d30;
String	 n_rc_d31;
String	 n_rc_d32;
String	 n_rc_d33;
String	 n_rc_d34;
String	 n_rc_e55;
String	 n_rc_e56;
String	 n_rc_e57;
String	 n_rc_f00;
String	 n_rc_f01;
String	 n_rc_f05;
String	 n_rc_i60;
String	 n_rc_i62;
String	 n_rc_l72;
String	 n_rc_l77;
String	 n_rc_l79;
String	 n_rc_p85;
String	 n_rc_s66;
String	 rc1;
String	 rc4;
String	 rc2;
String	 rc3;

			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end
	
upcase := stringlib.stringtouppercase;

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	seq															 := le.seq;
	input_phone_isbestmatch          := le.best_flags.input_phone_isbestmatch;
	inq_phonesperadl_count01         := le.acc_logs.inq_phonesperadl_count01;
	inq_phonesperadl_count03         := le.acc_logs.inq_phonesperadl_count03;
	inq_phonesperadl_count06         := le.acc_logs.inq_phonesperadl_count06;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_addrcount                     := le.iid.addrcount;
	rc_phoneaddrcount                := le.iid.phoneaddrcount;
	rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_fname_sources                := le.header_summary.ver_fname_sources;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_ssn_sources                  := le.header_summary.ver_ssn_sources;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_lres                   := le.lres;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	add_curr_lres                    := le.lres2;
	add_curr_advo_vacancy            := le.advo_addr_hist1.Address_Vacancy_Indicator;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_lres                    := le.lres3;
	add_prev_pop                     := le.addrPop3;
	avg_lres                         := le.other_address_info.avg_lres;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_move_trajectory_index      := le.economic_trajectory_index;
	addrs_prison_history             := le.other_address_info.isprison;
	unverified_addr_count            := le.address_verification.unverified_addr_count;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	//inq_lnamesperadl                 := if(isFCRA, 0, le.acc_logs.inquirylnamesperadl);
	inq_lnamesperadl                 := 0;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	college_code                     := le.student.college_code;
	college_file_type                := le.student.file_type2;
	college_tier                     := le.student.college_tier;
	college_attendance               := le.attended_college;
	prof_license_category            := le.professional_license.plcategory;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	rc_hrisksic      														  := (INTEGER)le.iid.hrisksic;
	rc_ssndobflag     := le.iid.socsdobflag ;
	rc_pwssndobflag		:= le.iid.pwsocsdobflag; 

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));

ver_src_ak_pos := Models.Common.findw_cpp(ver_sources, 'AK' , '  ,', 'ie');

ver_src_ak := ver_src_ak_pos > 0;

_ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), '0');

ver_src_fdate_ak := common.sas_date((string)(_ver_src_fdate_ak));

ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

ver_src_am := ver_src_am_pos > 0;

_ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am := common.sas_date((string)(_ver_src_fdate_am));

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

ver_src_ar := ver_src_ar_pos > 0;

_ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar := common.sas_date((string)(_ver_src_fdate_ar));

ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

ver_src_ba := ver_src_ba_pos > 0;

_ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');

ver_src_fdate_ba := common.sas_date((string)(_ver_src_fdate_ba));

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

ver_src_cg := ver_src_cg_pos > 0;

_ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg := common.sas_date((string)(_ver_src_fdate_cg));

ver_src_co_pos := Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie');

_ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');

ver_src_fdate_co := common.sas_date((string)(_ver_src_fdate_co));

ver_src_cy_pos := Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie');

ver_src_cy := ver_src_cy_pos > 0;

_ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0');

ver_src_fdate_cy := common.sas_date((string)(_ver_src_fdate_cy));

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

ver_src_da := ver_src_da_pos > 0;

_ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da := common.sas_date((string)(_ver_src_fdate_da));

ver_src_d_pos := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');

ver_src_d := ver_src_d_pos > 0;

_ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');

ver_src_fdate_d := common.sas_date((string)(_ver_src_fdate_d));

ver_src_dl_pos := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');

ver_src_dl := ver_src_dl_pos > 0;

_ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');

ver_src_fdate_dl := common.sas_date((string)(_ver_src_fdate_dl));

ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

ver_src_ds := ver_src_ds_pos > 0;

_ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0');

ver_src_fdate_ds := common.sas_date((string)(_ver_src_fdate_ds));

ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');

ver_src_de := ver_src_de_pos > 0;

_ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0');

ver_src_fdate_de := common.sas_date((string)(_ver_src_fdate_de));

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

ver_src_eb := ver_src_eb_pos > 0;

_ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb := common.sas_date((string)(_ver_src_fdate_eb));

ver_src_em_pos := Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie');

ver_src_em := ver_src_em_pos > 0;

_ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0');

ver_src_fdate_em := common.sas_date((string)(_ver_src_fdate_em));

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

ver_src_e1 := ver_src_e1_pos > 0;

_ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e1 := common.sas_date((string)(_ver_src_fdate_e1));

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

ver_src_e2 := ver_src_e2_pos > 0;

_ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e2 := common.sas_date((string)(_ver_src_fdate_e2));

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

ver_src_e3 := ver_src_e3_pos > 0;

_ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e3 := common.sas_date((string)(_ver_src_fdate_e3));

ver_src_e4_pos := Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie');

ver_src_e4 := ver_src_e4_pos > 0;

_ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0');

ver_src_fdate_e4 := common.sas_date((string)(_ver_src_fdate_e4));

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');

ver_src_en := ver_src_en_pos > 0;

_ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en := common.sas_date((string)(_ver_src_fdate_en));

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

ver_src_eq := ver_src_eq_pos > 0;

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((string)(_ver_src_fdate_eq));

ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');

ver_src_fe := ver_src_fe_pos > 0;

_ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');

ver_src_fdate_fe := common.sas_date((string)(_ver_src_fdate_fe));

ver_src_ff_pos := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');

ver_src_ff := ver_src_ff_pos > 0;

_ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');

ver_src_fdate_ff := common.sas_date((string)(_ver_src_fdate_ff));

ver_src_fr_pos := Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie');

ver_src_fr := ver_src_fr_pos > 0;

_ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');

ver_src_fdate_fr := common.sas_date((string)(_ver_src_fdate_fr));

ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

ver_src_l2 := ver_src_l2_pos > 0;

_ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');

ver_src_fdate_l2 := common.sas_date((string)(_ver_src_fdate_l2));

ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

ver_src_li := ver_src_li_pos > 0;

_ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');

ver_src_fdate_li := common.sas_date((string)(_ver_src_fdate_li));

ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie');

ver_src_mw := ver_src_mw_pos > 0;

_ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');

ver_src_fdate_mw := common.sas_date((string)(_ver_src_fdate_mw));

ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie');

ver_src_nt := ver_src_nt_pos > 0;

_ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0');

ver_src_fdate_nt := common.sas_date((string)(_ver_src_fdate_nt));

ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');

ver_src_p := ver_src_p_pos > 0;

_ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');

ver_src_fdate_p := common.sas_date((string)(_ver_src_fdate_p));

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

ver_src_pl := ver_src_pl_pos > 0;

_ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl := common.sas_date((string)(_ver_src_fdate_pl));

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

ver_src_tn := ver_src_tn_pos > 0;

_ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');

ver_src_fdate_tn := common.sas_date((string)(_ver_src_fdate_tn));

ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie');

ver_src_ts := ver_src_ts_pos > 0;

_ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

ver_src_fdate_ts := common.sas_date((string)(_ver_src_fdate_ts));

ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie');

ver_src_tu := ver_src_tu_pos > 0;

_ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');

ver_src_fdate_tu := common.sas_date((string)(_ver_src_fdate_tu));

ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');

ver_src_sl := ver_src_sl_pos > 0;

_ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');

ver_src_fdate_sl := common.sas_date((string)(_ver_src_fdate_sl));

ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');

ver_src_v := ver_src_v_pos > 0;

_ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');

ver_src_fdate_v := common.sas_date((string)(_ver_src_fdate_v));

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

ver_src_vo := ver_src_vo_pos > 0;

_ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo := common.sas_date((string)(_ver_src_fdate_vo));

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

ver_src_w := ver_src_w_pos > 0;

_ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w := common.sas_date((string)(_ver_src_fdate_w));

ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie');

ver_src_wp := ver_src_wp_pos > 0;

_ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');

ver_src_fdate_wp := common.sas_date((string)(_ver_src_fdate_wp));

ver_fname_src_en_pos := Models.Common.findw_cpp(ver_fname_sources, 'EN' , '  ,', 'ie');

ver_fname_src_en := ver_fname_src_en_pos > 0;

ver_fname_src_eq_pos := Models.Common.findw_cpp(ver_fname_sources, 'EQ' , '  ,', 'ie');

ver_fname_src_eq := ver_fname_src_eq_pos > 0;

ver_fname_src_tn_pos := Models.Common.findw_cpp(ver_fname_sources, 'TN' , '  ,', 'ie');

ver_fname_src_tn := ver_fname_src_tn_pos > 0;

ver_fname_src_ts_pos := Models.Common.findw_cpp(ver_fname_sources, 'TS' , '  ,', 'ie');

ver_fname_src_ts := ver_fname_src_ts_pos > 0;

ver_fname_src_tu_pos := Models.Common.findw_cpp(ver_fname_sources, 'TU' , '  ,', 'ie');

ver_fname_src_tu := ver_fname_src_tu_pos > 0;

ver_lname_src_en_pos := Models.Common.findw_cpp(ver_lname_sources, 'EN' , '  ,', 'ie');

ver_lname_src_en := ver_lname_src_en_pos > 0;

ver_lname_src_eq_pos := Models.Common.findw_cpp(ver_lname_sources, 'EQ' , '  ,', 'ie');

ver_lname_src_eq := ver_lname_src_eq_pos > 0;

ver_lname_src_tn_pos := Models.Common.findw_cpp(ver_lname_sources, 'TN' , '  ,', 'ie');

ver_lname_src_tn := ver_lname_src_tn_pos > 0;

ver_lname_src_ts_pos := Models.Common.findw_cpp(ver_lname_sources, 'TS' , '  ,', 'ie');

ver_lname_src_ts := ver_lname_src_ts_pos > 0;

ver_lname_src_tu_pos := Models.Common.findw_cpp(ver_lname_sources, 'TU' , '  ,', 'ie');

ver_lname_src_tu := ver_lname_src_tu_pos > 0;

ver_addr_src_en_pos := Models.Common.findw_cpp(ver_addr_sources, 'EN' , '  ,', 'ie');

ver_addr_src_en := ver_addr_src_en_pos > 0;

ver_addr_src_eq_pos := Models.Common.findw_cpp(ver_addr_sources, 'EQ' , '  ,', 'ie');

ver_addr_src_eq := ver_addr_src_eq_pos > 0;

ver_addr_src_tn_pos := Models.Common.findw_cpp(ver_addr_sources, 'TN' , '  ,', 'ie');

ver_addr_src_tn := ver_addr_src_tn_pos > 0;

ver_addr_src_ts_pos := Models.Common.findw_cpp(ver_addr_sources, 'TS' , '  ,', 'ie');

ver_addr_src_ts := ver_addr_src_ts_pos > 0;

ver_addr_src_tu_pos := Models.Common.findw_cpp(ver_addr_sources, 'TU' , '  ,', 'ie');

ver_addr_src_tu := ver_addr_src_tu_pos > 0;

ver_ssn_src_en_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EN' , '  ,', 'ie');

ver_ssn_src_en := ver_ssn_src_en_pos > 0;

ver_ssn_src_eq_pos := Models.Common.findw_cpp(ver_ssn_sources, 'EQ' , '  ,', 'ie');

ver_ssn_src_eq := ver_ssn_src_eq_pos > 0;

ver_ssn_src_tn_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TN' , '  ,', 'ie');

ver_ssn_src_tn := ver_ssn_src_tn_pos > 0;

ver_ssn_src_ts_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TS' , '  ,', 'ie');

ver_ssn_src_ts := ver_ssn_src_ts_pos > 0;

ver_ssn_src_tu_pos := Models.Common.findw_cpp(ver_ssn_sources, 'TU' , '  ,', 'ie');

ver_ssn_src_tu := ver_ssn_src_tu_pos > 0;

ver_dob_src_en_pos := Models.Common.findw_cpp(ver_dob_sources, 'EN' , '  ,', 'ie');

ver_dob_src_en := ver_dob_src_en_pos > 0;

ver_dob_src_eq_pos := Models.Common.findw_cpp(ver_dob_sources, 'EQ' , '  ,', 'ie');

ver_dob_src_eq := ver_dob_src_eq_pos > 0;

ver_dob_src_tn_pos := Models.Common.findw_cpp(ver_dob_sources, 'TN' , '  ,', 'ie');

ver_dob_src_tn := ver_dob_src_tn_pos > 0;

ver_dob_src_ts_pos := Models.Common.findw_cpp(ver_dob_sources, 'TS' , '  ,', 'ie');

ver_dob_src_ts := ver_dob_src_ts_pos > 0;

ver_dob_src_tu_pos := Models.Common.findw_cpp(ver_dob_sources, 'TU' , '  ,', 'ie');

ver_dob_src_tu := ver_dob_src_tu_pos > 0;

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), 1, 0);

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid),'1', '0');

rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

rv_a44_curr_add_naprop := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

rv_c13_inp_addr_lres := if(not(add_input_pop and truedid), NULL, min(if(add_input_lres = NULL, -NULL, add_input_lres), 999));

iv_f00_nas_summary := __common__( if(not(truedid and ssnlength > '0'), NULL,(Integer)trim((string)nas_summary,LEFT)));

iv_college_tier := __common__(map(
    not(truedid)  => NULL,
    college_tier = '0' or college_tier = '5' or college_tier = '6' => 5,
    college_tier = '1' or college_tier = '2' or college_tier = '3' or 
		  college_tier = '4' or (string)college_attendance = '1' => 1,
                                                    99));

iv_c22_addr_ver_sources := map(
    not(truedid and add_input_pop)                                             => NULL,
    rc_addrcount > 0 and (rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0) => 3,
    rc_addrcount > 0                                                           => 2,
    rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0                        => 1,
                                                                                  0);

rv_f00_addr_not_ver_w_ssn := if(not(truedid and (integer)ssnlength > 0), NULL, (integer)(nas_summary in [4, 7, 9]));

iv_a46_l77_addrs_move_traj_index := if(not(truedid), NULL, addrs_move_trajectory_index);

rv_d33_eviction_recency := map(
    not(truedid)                                                        => NULL,
   (boolean)attr_eviction_count90                                       => 03,
   (boolean)attr_eviction_count180                                      => 06,
   (boolean)attr_eviction_count12                                       => 12,
   (boolean)attr_eviction_count24 and attr_eviction_count >= 2          => 24,
   (boolean)attr_eviction_count24                                       => 24,
   (boolean)attr_eviction_count36 and attr_eviction_count >= 2          => 36,
   (boolean)attr_eviction_count36                                       => 37,
   (boolean)attr_eviction_count60 and attr_eviction_count >= 2          => 60,
   (boolean)attr_eviction_count60                                       => 61,
    attr_eviction_count >= 2                                            => 98,
    attr_eviction_count >= 1                                            => 99,
                                                                          999);

iv_num_non_bureau_sources := if(not(truedid), NULL, (integer)ver_src_cy +
    (integer)ver_src_pl +
    (integer)ver_src_sl +
    (integer)ver_src_wp +
    (integer)ver_src_ak +
    (integer)ver_src_am +
    (integer)ver_src_ar +
    (integer)ver_src_ba +
    (integer)ver_src_cg +
    (integer)ver_src_da +
    (integer)ver_src_d +
    (integer)ver_src_dl +
    (integer)ver_src_ds +
    (integer)ver_src_de +
    (integer)ver_src_eb +
    (integer)ver_src_em +
    (integer)ver_src_e1 +
    (integer)ver_src_e2 +
    (integer)ver_src_e3 +
    (integer)ver_src_e4 +
    (integer)ver_src_fe +
    (integer)ver_src_ff +
    (integer)ver_src_fr +
    (integer)ver_src_l2 +
    (integer)ver_src_li +
    (integer)ver_src_mw +
    (integer)ver_src_nt +
    (integer)ver_src_p +
    (integer)ver_src_v +
    (integer)ver_src_vo +
    (integer)ver_src_w);

iv_input_best_phone_match := map(
    not(truedid) or input_phone_isbestmatch = '-3' => NULL,
    input_phone_isbestmatch = '1'                 => 1,
    input_phone_isbestmatch = '0'                  => 0,
    input_phone_isbestmatch = '-2'                 => -1,
                                                    NULL);

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_email_domain_free_count := if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999));

_in_dob_1 := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob_1 = NULL, -1, (sysdate - _in_dob_1) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

rv_comb_age := map(
    yr_in_dob_int > 0            => min(62, if(yr_in_dob_int = NULL, -NULL, yr_in_dob_int)),
    inferred_age > 0 and truedid => min(62, if(inferred_age = NULL, -NULL, inferred_age)),
                                    NULL);

iv_unverified_addr_count := if(not(truedid), NULL, min(if(unverified_addr_count = NULL, -NULL, unverified_addr_count), 999));

iv_br_source_count := if(not(truedid), NULL, min(if(br_source_count = NULL, -NULL, br_source_count), 999));

iv_c13_avg_lres := if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999));

rv_s66_adlperssn_count := map(
    not((integer)ssnlength > 0) => NULL,
    (integer)adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

_felony_last_date := common.sas_date((string)(felony_last_date));

_criminal_last_date_1 := common.sas_date((string)(criminal_last_date));

rv_d32_criminal_behavior_lvl := map(
    not(truedid)                                                 => NULL,
    felony_count > 0 and sysdate - _felony_last_date < 365       => 6,
    criminal_count > 0 and sysdate - _criminal_last_date_1 < 365 => 5,
    felony_count > 0                                             => 4,
                                                                    min(if(criminal_count = NULL, -NULL, criminal_count), 3));

rv_i62_inq_addrs_per_adl := if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999));

rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 100));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

rv_d32_mos_since_crim_ls := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 999,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));

src_bureau := (integer)ver_src_en +
    (integer)ver_src_eq +
    (integer)ver_src_tn +
    (integer)ver_src_ts +
    (integer)ver_src_tu;

src_behavioral := (integer)ver_src_cy +
    (integer)ver_src_pl +
    (integer)ver_src_sl +
    (integer)ver_src_wp;

src_inperson := (integer)ver_src_ak +
    (integer)ver_src_am +
    (integer)ver_src_ar +
    (integer)ver_src_ba +
    (integer)ver_src_cg +
    (integer)ver_src_da +
    (integer)ver_src_d +
    (integer)ver_src_dl +
    (integer)ver_src_ds +
    (integer)ver_src_de +
    (integer)ver_src_eb +
    (integer)ver_src_em +
    (integer)ver_src_e1 +
    (integer)ver_src_e2 +
    (integer)ver_src_e3 +
    (integer)ver_src_e4 +
    (integer)ver_src_fe +
    (integer)ver_src_ff +
    (integer)ver_src_fr +
    (integer)ver_src_l2 +
    (integer)ver_src_li +
    (integer)ver_src_mw +
    (integer)ver_src_nt +
    (integer)ver_src_p +
    (integer)ver_src_v +
    (integer)ver_src_vo +
    (integer)ver_src_w;

iv_source_type := map(
    not(truedid)                                                                                         => NULL,
    (boolean)(integer)src_bureau and (boolean)(integer)src_behavioral and (boolean)(integer)src_inperson => 7,
    (boolean)(integer)src_behavioral and (boolean)(integer)src_inperson                                  => 6,
    (boolean)(integer)src_bureau and (boolean)(integer)src_inperson                                      => 5,
    (boolean)(integer)src_bureau and (boolean)(integer)src_behavioral                                    => 4,
    (boolean)(integer)src_inperson                                                                       => 3,
    (boolean)(integer)src_behavioral                                                                     => 2,
                      src_bureau = 1                                                                     => 1,
                                                                                                            0);

rv_l79_adls_per_sfd_addr_c6 := map(
    not(addrpop)   => NULL,
    iv_add_apt = 1 => 0,
                      min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

_in_dob := common.sas_date((string)(in_dob));

earliest_bureau_date := if((integer)ver_src_fdate_tn = NULL 
and (integer)ver_src_fdate_ts = NULL
and (integer)ver_src_fdate_tu = NULL 
and (integer)ver_src_fdate_en = NULL 
and (integer)ver_src_fdate_eq = NULL, NULL, 
if(max((integer)ver_src_fdate_tn, (integer)ver_src_fdate_ts, (integer)ver_src_fdate_tu, (integer)ver_src_fdate_en, (integer)ver_src_fdate_eq) = NULL, NULL, 
min(if((integer)ver_src_fdate_tn = NULL, -NULL, (integer)ver_src_fdate_tn), 
if((integer)ver_src_fdate_ts = NULL, -NULL, (integer)ver_src_fdate_ts), 
if((integer)ver_src_fdate_tu = NULL, -NULL, (integer)ver_src_fdate_tu), 
if((integer)ver_src_fdate_en = NULL, -NULL, (integer)ver_src_fdate_en), 
if((integer)ver_src_fdate_eq = NULL, -NULL, (integer)ver_src_fdate_eq))));

earliest_bureau_yrs := if(earliest_bureau_date = NULL or earliest_bureau_date = 0 or sysdate = NULL, NULL, 
if ((sysdate - earliest_bureau_date) / 365.25 >= 0, 
roundup((sysdate - earliest_bureau_date) / 365.25), 
truncate((sysdate - earliest_bureau_date) / 365.25)));

calc_dob := if(_in_dob = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25)));

non_bureau_sources := (integer)ver_src_cy +
    (integer)ver_src_pl +
    (integer)ver_src_sl +
    (integer)ver_src_wp +
    (integer)ver_src_ak +
    (integer)ver_src_am +
    (integer)ver_src_ar +
    (integer)ver_src_ba +
    (integer)ver_src_cg +
    (integer)ver_src_da +
    (integer)ver_src_d +
    (integer)ver_src_dl +
    (integer)ver_src_ds +
    (integer)ver_src_de +
    (integer)ver_src_eb +
    (integer)ver_src_em +
    (integer)ver_src_e1 +
    (integer)ver_src_e2 +
    (integer)ver_src_e3 +
    (integer)ver_src_e4 +
    (integer)ver_src_fe +
    (integer)ver_src_ff +
    (integer)ver_src_fr +
    (integer)ver_src_l2 +
    (integer)ver_src_li +
    (integer)ver_src_mw +
    (integer)ver_src_nt +
    (integer)ver_src_p +
    (integer)ver_src_v +
    (integer)ver_src_vo +
    (integer)ver_src_w;

iv_bureau_emergence_age_buronly_c181 := map(
    not(calc_dob = NULL) => min(62, if(calc_dob - earliest_bureau_yrs = NULL, -NULL, calc_dob - earliest_bureau_yrs)),
    inferred_age = 0     => NULL,
                            min(62, if(inferred_age - earliest_bureau_yrs = NULL, -NULL, inferred_age - earliest_bureau_yrs)));

iv_bureau_emergence_age_buronly := map(
    not(truedid) or earliest_bureau_yrs = NULL => NULL,
    non_bureau_sources = 0                     => iv_bureau_emergence_age_buronly_c181,
                                                  NULL);

earliest_header_date := if(max(ver_src_fdate_ak, ver_src_fdate_am, ver_src_fdate_ar, ver_src_fdate_ba, ver_src_fdate_cg, ver_src_fdate_co, ver_src_fdate_cy, ver_src_fdate_d, ver_src_fdate_da, ver_src_fdate_de, ver_src_fdate_dl, ver_src_fdate_ds, ver_src_fdate_e1, ver_src_fdate_e2, ver_src_fdate_e3, ver_src_fdate_e4, ver_src_fdate_eb, ver_src_fdate_em, ver_src_fdate_en, ver_src_fdate_eq, ver_src_fdate_fe, ver_src_fdate_ff, ver_src_fdate_fr, ver_src_fdate_l2, ver_src_fdate_li, ver_src_fdate_mw, ver_src_fdate_nt, ver_src_fdate_p, ver_src_fdate_pl, ver_src_fdate_sl, ver_src_fdate_tn, ver_src_fdate_ts, ver_src_fdate_tu, ver_src_fdate_v, ver_src_fdate_vo, ver_src_fdate_w, ver_src_fdate_wp) = NULL, NULL, min(if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p), if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v), if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp)));

earliest_header_yrs := if(min(sysdate, earliest_header_date) = NULL, NULL, if ((sysdate - earliest_header_date) / 365.25 >= 0, roundup((sysdate - earliest_header_date) / 365.25), truncate((sysdate - earliest_header_date) / 365.25)));

iv_header_emergence_age := map(
    not(truedid)        => NULL,
    not(_in_dob = NULL) => max((real)0, min(62, if(calc_dob - earliest_header_yrs = NULL, -NULL, calc_dob - earliest_header_yrs))),
    inferred_age = 0    => NULL,
                           max(0, min(62, if(inferred_age - earliest_header_yrs = NULL, -NULL, inferred_age - earliest_header_yrs))));

rv_a49_curr_avm_chg_1yr_pct := map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(min(100, if(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2 = NULL, -NULL, 100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2))/0.1)*0.1,
                                                                 NULL);

iv_prv_addr_lres := if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999));

num_bureau_fname := (integer)ver_fname_src_eq +
    (integer)ver_fname_src_en +
    (integer)ver_fname_src_tn +
    (integer)ver_fname_src_ts +
    (integer)ver_fname_src_tu;

num_bureau_lname := (integer)ver_lname_src_eq +
    (integer)ver_lname_src_en +
    (integer)ver_lname_src_tn +
    (integer)ver_lname_src_ts +
    (integer)ver_lname_src_tu;

num_bureau_addr := (integer)ver_addr_src_eq +
    (integer)ver_addr_src_en +
    (integer)ver_addr_src_tn +
    (integer)ver_addr_src_ts +
    (integer)ver_addr_src_tu;

num_bureau_ssn := (integer)ver_ssn_src_eq +
    (integer)ver_ssn_src_en +
    (integer)ver_ssn_src_tn +
    (integer)ver_ssn_src_ts +
    (integer)ver_ssn_src_tu;

num_bureau_dob := (integer)ver_dob_src_eq +
    (integer)ver_dob_src_en +
    (integer)ver_dob_src_tn +
    (integer)ver_dob_src_ts +
    (integer)ver_dob_src_tu;

iv_bureau_verification_index := if(not(truedid), NULL, if(max((integer)(max(num_bureau_fname, num_bureau_lname) > 0), 2*(integer)(num_bureau_addr > 0),4*(integer)(num_bureau_dob > 0), 8*(integer)(num_bureau_ssn > 0)) = NULL, NULL, sum(if((integer)(max(num_bureau_fname, num_bureau_lname) > 0) = NULL, 0,(integer)(max(num_bureau_fname, num_bureau_lname) > 0)), if(2*(integer)(num_bureau_addr > 0) = NULL, 0, 2* (integer)(num_bureau_addr > 0)), if(4*(integer)(num_bureau_dob > 0) = NULL, 0, 4* (integer)(num_bureau_dob > 0)), if(8* (integer)(num_bureau_ssn > 0) = NULL, 0,8* (integer)(num_bureau_ssn > 0)))));

iv_college_code :=__common__( map(
    not(truedid)        => NULL,
    college_code = '' => -1,
    college_code = '1'    => 4,
                           (integer)college_code));

rv_f00_dob_score := if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 100));

rv_f00_ssn_score := if(not(truedid and (integer)ssnlength > 0), NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 100));

rv_f00_input_dob_match_level := if(not(truedid and dobpop), NULL, (integer)input_dob_match_level);

rv_d31_bk_filing_count := if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999));

rv_d31_mostrec_bk_1 := __common__(map(
    not(truedid)                                     => '',
    contains_i(UPCASE(disposition), 'DISMISS')  = 1  => '1 - BK DISMISSED',
    contains_i(UPCASE(disposition), 'DISCHARG') = 1  => '2 - BK DISCHARGED',
    bankrupt = true or filing_count > 0                   => '3 - BK OTHER',
                                                              '0 - NO BK'));

rv_d31_mostrec_bk := if(rv_d31_mostrec_bk_1 = '0 - NO BK' or rv_d31_mostrec_bk_1 = '2 - BK DISCHARGED' or rv_d31_mostrec_bk_1 = '3 - BK OTHER', '0, 2, 3 - DISCHARGED, OTHER, OR NO BK', rv_d31_mostrec_bk_1);

rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

iv_d34_liens_unrel_sc_ct := if(not(truedid), NULL, min(if(liens_unrel_SC_ct = NULL, -NULL, liens_unrel_SC_ct), 999));

rv_p85_phn_risk_level := map(
    not(hphnpop)                                                                                    => '',
    (string)rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1' => 'HIGH RISK',
    (string)rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5'                                => 'INVALID',
    (string)rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D'                        => 'DISCONNECTED',
    (string)rc_pwphonezipflag = '4'                                                                           => 'NOT ISSUED',
                                                                                                       'NONE');

rv_c14_addrs_10yr := map(
    not(truedid)     => NULL,
    not(add_curr_pop)   => -1,
                        min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

rv_c20_m_bureau_adl_fs := map(
    not(truedid)            => NULL,
    ver_src_fdate_eq = NULL => -1,
                               min(if(if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - ver_src_fdate_eq) / (365.25 / 12) >= 0, truncate((sysdate - ver_src_fdate_eq) / (365.25 / 12)), roundup((sysdate - ver_src_fdate_eq) / (365.25 / 12)))), 999));

rv_l79_adls_per_sfd_addr := map(
    not(addrpop)                                     => NULL,
    iv_add_apt = 1                                   => NULL,
    adls_per_addr_curr = 1 or adls_per_addr_curr = 2 => 1.5,
                                                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_i62_inq_num_names_per_adl := if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl));

rv_l79_adls_per_addr_curr := map(
    not(addrpop)                                     => NULL,
    adls_per_addr_curr = 1 or adls_per_addr_curr = 2 => 1.5,
                                                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));
num_addr_sources := Models.Common.countw(ver_addr_sources, ',');

iv_addr_bureau_only := if(not(addrpop), -1, (integer)(num_addr_sources = 
    (integer)ver_addr_src_eq +
    (integer)ver_addr_src_en +
    (integer)ver_addr_src_tn +
    (integer)ver_addr_src_ts +
    (integer)ver_addr_src_tu));

rv_c19_add_prison_hist := if(not(truedid), NULL, (integer)addrs_prison_history);

rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));

iv_prof_license_category := map(
    not(truedid)                 => NULL,
    prof_license_category = '' => -1,
                                    (Real)trim(prof_license_category, LEFT));

rv_l72_add_curr_vacant := map(
    not(add_curr_pop)                                          => NULL,
    trim(trim(add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                  0);

rv_i62_inq_phonesperadl_recency := map(
    not(truedid)             => NULL,
    inq_phonesperadl_count01 > 0 => 1,
    inq_phonesperadl_count03  > 0 => 3,
    inq_phonesperadl_count06 >0 => 6,
    Inq_PhonesPerADL       > 0   => 12,
                                99);

rc001_1_2_1 := 0;

rc001_1_6_1 := 0;

rc001_2_4_1 := 0;

rc001_2_9_1 := 0;

rc001_3_6_1 := 0;

rc001_4_7_1 := 0;

rc001_5_3_1 := 0;

rc001_6_7_1 := 0;

rc001_7_4_1 := 0;

rc001_7_9_1 := 0;

rc001_10_2_1 := 0;

rc001_10_10_1 := 0;

rc001_11_2_1 := 0;

rc001_14_4_1 := 0;

rc001_17_1_1 := 0;

rc001_19_6_1 := 0;

rc001_20_4_1 := 0;

rc001_23_1_1 := 0;

rc001_27_1_1 := 0;

rc001_29_6_1 := 0;

rc001_35_1_1 := 0;

rc001_42_3_1 := 0;

rc001_49_3_1 := 0;

rc001_57_4_1 := 0;

rc001_70_3_1 := 0;

rc001_71_1_1 := 0;

rc001_73_4_1 := 0;

rc001_77_8_1 := 0;

rc001_82_11_1 := 0;

rc001_84_2_1 := 0;

rc001_89_12_1 := 0;

rc001_102_10_1 := 0;

rc002_1_7_1 := 0;

rc002_2_10_1 := 0;

rc002_3_7_1 := 0;

rc002_4_2_1 := 0;

rc002_4_6_1 := 0;

rc002_5_2_1 := 0;

rc002_6_2_1 := 0;

rc002_8_1_1 := 0;

rc002_9_1_1 := 0;

rc002_10_9_1 := 0;

rc002_13_1_1 := 0;

rc002_16_1_1 := 0;

rc002_18_1_1 := 0;

rc002_22_1_1 := 0;

rc002_24_10_1 := 0;

rc002_30_4_1 := 0;

rc002_77_3_1 := 0;

rc003_2_1_1 := 0;

rc003_4_1_1 := 0;

rc003_7_1_1 := 0;

rc003_10_1_1 := 0;

rc003_12_1_1 := 0;

rc004_3_1_1 := 0;

rc004_6_1_1 := 0;

rc004_11_1_1 := 0;

rc005_1_8_1 := 0;

rc005_2_2_1 := 0;

rc005_3_2_1 := 0;

rc005_4_8_1 := 0;

rc005_5_4_1 := 0;

rc005_5_12_1 := 0;

rc005_6_8_1 := 0;

rc005_7_2_1 := 0;

rc005_10_3_1 := 0;

rc005_11_3_1 := 0;

rc005_11_10_1 := 0;

rc005_12_2_1 := 0;

rc005_13_2_1 := 0;

rc005_15_2_1 := 0;

rc005_18_2_1 := 0;

rc005_19_2_1 := 0;

rc005_26_2_1 := 0;

rc005_34_3_1 := 0;

rc005_35_4_1 := 0;

rc005_40_1_1 := 0;

rc005_51_3_1 := 0;

rc005_61_4_1 := 0;

rc005_84_4_1 := 0;

rc006_1_1_1 := 0;

rc006_9_2_1 := 0;

rc007_5_1_1 := 0;

rc007_8_2_1 := 0;

rc007_14_1_1 := 0;

rc007_101_12_1 := 0;

rc008_6_6_1 := 0;

rc008_11_9_1 := 0;

rc008_15_1_1 := 0;

rc008_21_1_1 := 0;

rc008_27_6_1 := 0;

rc008_30_5_1 := 0;

rc008_44_2_1 := 0;

rc008_47_2_1 := 0;

rc008_52_3_1 := 0;

rc008_68_3_1 := 0;

rc009_3_11_1 := 0;

rc009_8_3_1 := 0;

rc009_9_4_1 := 0;

rc009_13_4_1 := 0;

rc009_14_8_1 := 0;

rc009_15_4_1 := 0;

rc009_25_1_1 := 0;

rc009_30_12_1 := 0;

rc009_39_1_1 := 0;

rc009_41_3_1 := 0;

rc009_60_1_1 := 0;

rc009_62_8_1 := 0;

rc009_75_2_1 := 0;

rc009_91_4_1 := 0;

rc009_92_6_1 := 0;

rc009_96_2_1 := 0;

rc009_108_1_1 := 0;

rc010_7_10_1 := 0;

rc010_15_12_1 := 0;

rc010_17_2_1 := 0;

rc010_17_12_1 := 0;

rc010_20_9_1 := 0;

rc010_29_11_1 := 0;

rc010_30_1_1 := 0;

rc010_41_12_1 := 0;

rc010_44_5_1 := 0;

rc010_46_7_1 := 0;

rc010_48_3_1 := 0;

rc010_57_6_1 := 0;

rc010_67_8_1 := 0;

rc010_68_4_1 := 0;

rc010_73_10_1 := 0;

rc010_76_4_1 := 0;

rc010_93_4_1 := 0;

rc010_103_4_1 := 0;

rc011_12_10_1 := 0;

rc011_16_2_1 := 0;

rc011_18_4_1 := 0;

rc011_24_1_1 := 0;

rc011_26_1_1 := 0;

rc011_34_2_1 := 0;

rc011_35_2_1 := 0;

rc011_39_3_1 := 0;

rc011_49_6_1 := 0;

rc011_51_2_1 := 0;

rc011_57_3_1 := 0;

rc011_74_11_1 := 0;

rc011_81_2_1 := 0;

rc011_90_10_1 := 0;

rc011_98_2_1 := 0;

rc012_8_7_1 := 0;

rc012_12_9_1 := 0;

rc012_19_12_1 := 0;

rc012_23_2_1 := 0;

rc012_27_2_1 := 0;

rc012_32_2_1 := 0;

rc012_41_2_1 := 0;

rc012_42_1_1 := 0;

rc012_44_1_1 := 0;

rc012_68_1_1 := 0;

rc012_73_3_1 := 0;

rc012_95_5_1 := 0;

rc012_99_3_1 := 0;

rc012_109_3_1 := 0;

rc013_18_6_1 := 0;

rc013_24_3_1 := 0;

rc013_26_5_1 := 0;

rc013_28_1_1 := 0;

rc013_29_2_1 := 0;

rc013_32_8_1 := 0;

rc013_37_3_1 := 0;

rc013_38_1_1 := 0;

rc013_43_6_1 := 0;

rc013_45_2_1 := 0;

rc013_48_4_1 := 0;

rc013_51_1_1 := 0;

rc013_52_9_1 := 0;

rc013_55_1_1 := 0;

rc013_58_9_1 := 0;

rc013_59_1_1 := 0;

rc013_71_2_1 := 0;

rc013_74_2_1 := 0;

rc013_80_1_1 := 0;

rc013_82_2_1 := 0;

rc013_88_1_1 := 0;

rc013_95_6_1 := 0;

rc013_105_2_1 := 0;

rc013_105_8_1 := 0;

rc013_107_4_1 := 0;

rc013_108_7_1 := 0;

rc014_8_5_1 := 0;

rc014_9_6_1 := 0;

rc014_20_5_1 := 0;

rc014_29_1_1 := 0;

rc014_37_2_1 := 0;

rc014_43_2_1 := 0;

rc014_45_1_1 := 0;

rc014_48_9_1 := 0;

rc014_51_12_1 := 0;

rc014_52_11_1 := 0;

rc014_53_4_1 := 0;

rc014_63_9_1 := 0;

rc014_66_1_1 := 0;

rc014_69_7_1 := 0;

rc014_74_1_1 := 0;

rc014_85_2_1 := 0;

rc014_88_10_1 := 0;

rc014_93_12_1 := 0;

rc014_97_3_1 := 0;

rc014_99_9_1 := 0;

rc014_105_1_1 := 0;

rc014_106_2_1 := 0;

rc015_17_3_1 := 0;

rc015_25_4_1 := 0;

rc015_25_9_1 := 0;

rc015_28_5_1 := 0;

rc015_30_2_1 := 0;

rc015_38_7_1 := 0;

rc015_40_4_1 := 0;

rc015_44_3_1 := 0;

rc015_47_3_1 := 0;

rc015_47_6_1 := 0;

rc015_50_6_1 := 0;

rc015_55_7_1 := 0;

rc015_56_2_1 := 0;

rc015_65_9_1 := 0;

rc015_66_2_1 := 0;

rc015_66_6_1 := 0;

rc015_67_6_1 := 0;

rc015_68_5_1 := 0;

rc015_72_4_1 := 0;

rc015_73_11_1 := 0;

rc015_75_4_1 := 0;

rc015_76_5_1 := 0;

rc015_81_4_1 := 0;

rc015_86_1_1 := 0;

rc015_87_3_1 := 0;

rc015_89_3_1 := 0;

rc015_97_1_1 := 0;

rc015_99_2_1 := 0;

rc015_104_1_1 := 0;

rc015_104_4_1 := 0;

rc015_106_11_1 := 0;

rc015_110_1_1 := 0;

rc016_13_8_1 := 0;

rc016_16_3_1 := 0;

rc016_22_2_1 := 0;

rc016_26_4_1 := 0;

rc016_34_1_1 := 0;

rc016_35_3_1 := 0;

rc016_38_6_1 := 0;

rc016_46_6_1 := 0;

rc016_54_1_1 := 0;

rc016_55_3_1 := 0;

rc016_69_3_1 := 0;

rc016_72_1_1 := 0;

rc016_80_3_1 := 0;

rc016_101_3_1 := 0;

rc016_103_2_1 := 0;

rc016_104_3_1 := 0;

rc017_15_6_1 := 0;

rc017_19_1_1 := 0;

rc017_21_2_1 := 0;

rc017_22_5_1 := 0;

rc017_31_11_1 := 0;

rc017_36_9_1 := 0;

rc017_39_6_1 := 0;

rc017_42_7_1 := 0;

rc017_53_6_1 := 0;

rc017_56_8_1 := 0;

rc017_58_3_1 := 0;

rc017_62_2_1 := 0;

rc017_63_7_1 := 0;

rc017_70_4_1 := 0;

rc017_86_11_1 := 0;

rc017_94_8_1 := 0;

rc017_100_7_1 := 0;

rc017_107_9_1 := 0;

rc018_22_4_1 := 0;

rc018_24_2_1 := 0;

rc018_32_1_1 := 0;

rc018_37_1_1 := 0;

rc018_41_1_1 := 0;

rc018_42_9_1 := 0;

rc018_46_1_1 := 0;

rc018_53_1_1 := 0;

rc018_62_6_1 := 0;

rc018_69_2_1 := 0;

rc018_79_3_1 := 0;

rc018_83_1_1 := 0;

rc018_84_1_1 := 0;

rc018_85_1_1 := 0;

rc018_86_2_1 := 0;

rc018_96_1_1 := 0;

rc018_98_1_1 := 0;

rc018_99_1_1 := 0;

rc018_109_5_1 := 0;

rc019_9_8_1 := 0;

rc019_12_4_1 := 0;

rc019_18_5_1 := 0;

rc019_28_9_1 := 0;

rc019_31_3_1 := 0;

rc019_32_4_1 := 0;

rc019_38_2_1 := 0;

rc019_45_6_1 := 0;

rc019_59_6_1 := 0;

rc019_60_5_1 := 0;

rc019_79_1_1 := 0;

rc019_109_4_1 := 0;

rc020_14_2_1 := 0;

rc020_17_7_1 := 0;

rc020_29_7_1 := 0;

rc020_33_9_1 := 0;

rc020_65_4_1 := 0;

rc020_81_1_1 := 0;

rc020_102_6_1 := 0;

rc021_20_1_1 := 0;

rc021_21_5_1 := 0;

rc021_33_1_1 := 0;

rc021_45_7_1 := 0;

rc021_56_1_1 := 0;

rc021_88_2_1 := 0;

rc022_13_6_1 := 0;

rc022_16_5_1 := 0;

rc022_24_4_1 := 0;

rc022_26_6_1 := 0;

rc022_43_4_1 := 0;

rc022_80_4_1 := 0;

rc022_95_2_1 := 0;

rc023_14_3_1 := 0;

rc023_23_3_1 := 0;

rc023_41_5_1 := 0;

rc023_65_11_1 := 0;

rc023_75_6_1 := 0;

rc023_86_9_1 := 0;

rc023_89_5_1 := 0;

rc023_97_12_1 := 0;

rc024_21_4_1 := 0;

rc024_23_4_1 := 0;

rc024_33_10_1 := 0;

rc024_34_5_1 := 0;

rc024_43_1_1 := 0;

rc024_50_2_1 := 0;

rc024_51_5_1 := 0;

rc024_96_12_1 := 0;

rc024_101_2_1 := 0;

rc024_108_6_1 := 0;

rc025_19_4_1 := 0;

rc025_34_6_1 := 0;

rc025_46_2_1 := 0;

rc025_48_5_1 := 0;

rc025_53_13_1 := 0;

rc025_58_2_1 := 0;

rc025_59_4_1 := 0;

rc025_62_1_1 := 0;

rc025_69_11_1 := 0;

rc025_82_1_1 := 0;

rc025_84_13_1 := 0;

rc025_86_5_1 := 0;

rc025_90_1_1 := 0;

rc025_96_10_1 := 0;

rc025_99_13_1 := 0;

rc025_100_3_1 := 0;

rc026_31_1_1 := 0;

rc026_37_12_1 := 0;

rc026_38_3_1 := 0;

rc026_46_8_1 := 0;

rc026_54_3_1 := 0;

rc026_55_4_1 := 0;

rc026_65_2_1 := 0;

rc026_70_1_1 := 0;

rc026_73_1_1 := 0;

rc026_82_9_1 := 0;

rc026_90_6_1 := 0;

rc026_108_11_1 := 0;

rc026_109_1_1 := 0;

rc026_110_4_1 := 0;

rc027_31_7_1 := 0;

rc027_33_4_1 := 0;

rc027_36_1_1 := 0;

rc027_39_4_1 := 0;

rc027_42_2_1 := 0;

rc027_52_2_1 := 0;

rc027_63_1_1 := 0;

rc027_72_6_1 := 0;

rc027_80_6_1 := 0;

rc027_94_3_1 := 0;

rc027_100_1_1 := 0;

rc027_102_1_1 := 0;

rc028_23_8_1 := 0;

rc028_25_8_1 := 0;

rc028_28_4_1 := 0;

rc028_40_6_1 := 0;

rc028_47_5_1 := 0;

rc028_50_5_1 := 0;

rc028_75_8_1 := 0;

rc028_76_7_1 := 0;

rc028_85_4_1 := 0;

rc028_105_6_1 := 0;

rc028_110_3_1 := 0;

rc029_16_4_1 := 0;

rc029_22_3_1 := 0;

rc029_50_1_1 := 0;

rc029_55_2_1 := 0;

rc029_72_2_1 := 0;

rc029_89_1_1 := 0;

rc029_91_7_1 := 0;

rc029_103_3_1 := 0;

rc030_31_9_1 := 0;

rc030_35_6_1 := 0;

rc030_39_8_1 := 0;

rc030_40_7_1 := 0;

rc030_50_3_1 := 0;

rc030_59_2_1 := 0;

rc030_61_2_1 := 0;

rc030_64_2_1 := 0;

rc030_76_1_1 := 0;

rc030_90_2_1 := 0;

rc030_91_2_1 := 0;

rc030_98_3_1 := 0;

rc031_33_2_1 := 0;

rc031_36_4_1 := 0;

rc031_36_11_1 := 0;

rc031_43_12_1 := 0;

rc031_48_1_1 := 0;

rc031_57_1_1 := 0;

rc031_58_7_1 := 0;

rc031_67_10_1 := 0;

rc031_74_7_1 := 0;

rc031_78_2_1 := 0;

rc031_87_8_1 := 0;

rc031_92_1_1 := 0;

rc031_93_2_1 := 0;

rc032_25_3_1 := 0;

rc032_28_2_1 := 0;

rc032_53_2_1 := 0;

rc032_54_7_1 := 0;

rc032_82_3_1 := 0;

rc032_87_2_1 := 0;

rc032_96_6_1 := 0;

rc033_21_12_1 := 0;

rc033_27_3_1 := 0;

rc033_44_10_1 := 0;

rc033_64_4_1 := 0;

rc033_78_4_1 := 0;

rc033_78_11_1 := 0;

rc033_98_13_1 := 0;

rc033_111_9_1 := 0;

rc034_27_12_1 := 0;

rc034_49_2_1 := 0;

rc034_61_6_1 := 0;

rc034_64_8_1 := 0;

rc034_77_2_1 := 0;

rc034_81_3_1 := 0;

rc034_83_3_1 := 0;

rc034_87_7_1 := 0;

rc034_92_5_1 := 0;

rc034_104_2_1 := 0;

rc034_109_13_1 := 0;

rc034_110_7_1 := 0;

rc035_49_1_1 := 0;

rc035_59_7_1 := 0;

rc035_61_8_1 := 0;

rc035_67_2_1 := 0;

rc035_77_1_1 := 0;

rc035_83_2_1 := 0;

rc035_87_1_1 := 0;

rc035_91_1_1 := 0;

rc035_92_4_1 := 0;

rc035_94_1_1 := 0;

rc035_111_1_1 := 0;

rc036_32_3_1 := 0;

rc036_52_1_1 := 0;

rc036_65_1_1 := 0;

rc036_67_1_1 := 0;

rc036_100_12_1 := 0;

rc036_102_13_1 := 0;

rc037_37_7_1 := 0;

rc037_45_9_1 := 0;

rc037_58_1_1 := 0;

rc037_63_6_1 := 0;

rc037_64_7_1 := 0;

rc037_79_4_1 := 0;

rc037_80_2_1 := 0;

rc037_90_9_1 := 0;

rc037_95_1_1 := 0;

rc037_105_9_1 := 0;

rc038_47_1_1 := 0;

rc038_54_2_1 := 0;

rc038_69_1_1 := 0;

rc038_71_4_1 := 0;

rc038_78_1_1 := 0;

rc038_101_1_1 := 0;

rc038_107_3_1 := 0;

rc038_111_3_1 := 0;

rc039_36_2_1 := 0;

rc039_63_2_1 := 0;

rc039_83_13_1 := 0;

rc039_94_4_1 := 0;

rc039_100_2_1 := 0;

rc039_102_2_1 := 0;

rc039_108_2_1 := 0;

rc040_40_3_1 := 0;

rc040_66_11_1 := 0;

rc040_72_3_1 := 0;

rc040_79_8_1 := 0;

rc040_81_6_1 := 0;

rc040_89_2_1 := 0;

rc040_104_6_1 := 0;

rc041_56_6_1 := 0;

rc041_66_7_1 := 0;

rc041_68_2_1 := 0;

rc041_71_5_1 := 0;

rc041_83_4_1 := 0;

rc041_85_6_1 := 0;

rc041_88_7_1 := 0;

rc041_106_7_1 := 0;

rc043_70_11_1 := 0;

rc043_74_6_1 := 0;

rc043_76_3_1 := 0;

rc043_77_4_1 := 0;

rc043_97_2_1 := 0;

rc043_98_5_1 := 0;

rc043_101_4_1 := 0;

rc043_103_5_1 := 0;

rc043_106_1_1 := 0;

rc043_111_2_1 := 0;

rc044_56_7_1 := 0;

rc044_85_7_1 := 0;

rc044_97_7_1 := 0;

rc044_106_6_1 := 0;

rc044_110_11_1 := 0;

rc044_111_7_1 := 0;

rc045_54_6_1 := 0;

rc045_57_5_1 := 0;

rc045_60_6_1 := 0;

rc045_62_7_1 := 0;

rc045_79_2_1 := 0;

rc045_94_2_1 := 0;

rc045_95_4_1 := 0;

rc046_60_3_1 := 0;

rc046_64_1_1 := 0;

rc046_75_1_1 := 0;

rc046_78_7_1 := 0;

rc046_93_1_1 := 0;

rc046_107_1_1 := 0;

rc047_60_4_1 := 0;

rc047_70_10_1 := 0;

rc047_91_6_1 := 0;

rc047_92_3_1 := 0;

rc047_103_1_1 := 0;

rc047_107_2_1 := 0;

rc048_61_1_1 := 0;

rc048_71_3_1 := 0;

rc048_88_3_1 := 0;

rc048_93_5_1 := 0;

rc049_49_4_1 := 0;

final_score_0 := -1.1010382706;

rc001_1_2_c208 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0702388245,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_1_c208 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0784842679,
    rv_d30_derog_count > 0.5                                => 0.1751351286,
    rv_d30_derog_count = NULL                               => 0.1048963041,
                                                               0.1048963041);

rc005_1_8_c211 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0117748824,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_1_c211 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.1080666491,
    iv_college_tier > 3                             => -0.0188572072,
    iv_college_tier = NULL                          => -0.0306320896,
                                                       -0.0306320896);

final_score_1_c210 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_1_c211,
    rv_a44_curr_add_naprop > 3.5                                    => -0.1084883728,
    rv_a44_curr_add_naprop = NULL                                   => -0.0562822960,
                                                                       -0.0562822960);

rc002_1_7_c210 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0256502064,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc005_1_8_c210 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc005_1_8_c211,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc001_1_6_c209 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0917069415,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc005_1_8_c209 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc005_1_8_c210,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc002_1_7_c209 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc002_1_7_c210,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_1_c209 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_1_c210,
    rv_d30_derog_count > 0.5                                => 0.0559567956,
    rv_d30_derog_count = NULL                               => -0.0357501459,
                                                               -0.0357501459);

rc001_1_6 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => rc001_1_6_1,
    iv_c22_addr_ver_sources > 1.5                                     => rc001_1_6_c209,
    iv_c22_addr_ver_sources = NULL                                    => rc001_1_6_1,
                                                                         rc001_1_6_1);

rc001_1_2 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => rc001_1_2_c208,
    iv_c22_addr_ver_sources > 1.5                                     => rc001_1_2_1,
    iv_c22_addr_ver_sources = NULL                                    => rc001_1_2_1,
                                                                         rc001_1_2_1);

final_score_1 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => final_score_1_c208,
    iv_c22_addr_ver_sources > 1.5                                     => final_score_1_c209,
    iv_c22_addr_ver_sources = NULL                                    => 0.0758638614,
                                                                         -0.0003567421);

rc006_1_1 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => 0.1052530462,
    iv_c22_addr_ver_sources > 1.5                                     => 0.0000000000,
    iv_c22_addr_ver_sources = NULL                                    => 0.0762206035,
                                                                         rc006_1_1_1);

rc002_1_7 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => rc002_1_7_1,
    iv_c22_addr_ver_sources > 1.5                                     => rc002_1_7_c209,
    iv_c22_addr_ver_sources = NULL                                    => rc002_1_7_1,
                                                                         rc002_1_7_1);

rc005_1_8 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => rc005_1_8_1,
    iv_c22_addr_ver_sources > 1.5                                     => rc005_1_8_c209,
    iv_c22_addr_ver_sources = NULL                                    => rc005_1_8_1,
                                                                         rc005_1_8_1);

final_score_2_c214 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0808624053,
    rv_d30_derog_count > 0.5                                => 0.1515057212,
    rv_d30_derog_count = NULL                               => 0.1011256668,
                                                               0.1011256668);

rc001_2_4_c214 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0503800544,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_2_4_c213 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc001_2_4_c214,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

rc005_2_2_c213 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => 0.0136806135,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_2_c213 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => -0.0344792177,
    iv_college_tier > 52                             => final_score_2_c214,
    iv_college_tier = NULL                           => 0.0874450533,
                                                        0.0874450533);

rc002_2_10_c216 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => 0.0344522133,
    rv_a44_curr_add_naprop > 2.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_2_c216 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => -0.0203399070,
    rv_a44_curr_add_naprop > 2.5                                    => -0.0892827121,
    rv_a44_curr_add_naprop = NULL                                   => -0.0547921204,
                                                                       -0.0547921204);

rc001_2_9_c215 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0837791297,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_2_c215 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_2_c216,
    rv_d30_derog_count > 0.5                                => 0.0472165768,
    rv_d30_derog_count = NULL                               => -0.0365625528,
                                                               -0.0365625528);

rc002_2_10_c215 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc002_2_10_c216,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_2_4 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 0.5 => rc001_2_4_c213,
    rv_c13_inp_addr_lres > 0.5                                  => rc001_2_4_1,
    rv_c13_inp_addr_lres = NULL                                 => rc001_2_4_1,
                                                                   rc001_2_4_1);

rc001_2_9 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 0.5 => rc001_2_9_1,
    rv_c13_inp_addr_lres > 0.5                                  => rc001_2_9_c215,
    rv_c13_inp_addr_lres = NULL                                 => rc001_2_9_1,
                                                                   rc001_2_9_1);

rc002_2_10 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 0.5 => rc002_2_10_1,
    rv_c13_inp_addr_lres > 0.5                                  => rc002_2_10_c215,
    rv_c13_inp_addr_lres = NULL                                 => rc002_2_10_1,
                                                                   rc002_2_10_1);

rc003_2_1 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 0.5 => 0.0902974479,
    rv_c13_inp_addr_lres > 0.5                                  => 0.0000000000,
    rv_c13_inp_addr_lres = NULL                                 => 0.0655967516,
                                                                   rc003_2_1_1);

rc005_2_2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 0.5 => rc005_2_2_c213,
    rv_c13_inp_addr_lres > 0.5                                  => rc005_2_2_1,
    rv_c13_inp_addr_lres = NULL                                 => rc005_2_2_1,
                                                                   rc005_2_2_1);

final_score_2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 0.5 => final_score_2_c213,
    rv_c13_inp_addr_lres > 0.5                                  => final_score_2_c215,
    rv_c13_inp_addr_lres = NULL                                 => 0.0627443571,
                                                                   -0.0028523945);

rc005_3_2_c218 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => 0.0121096951,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_3_c218 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => -0.0384250143,
    iv_college_tier > 52                             => 0.0840011098,
    iv_college_tier = NULL                           => 0.0718914146,
                                                        0.0718914146);

rc002_3_7_c220 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => 0.0329764188,
    rv_a44_curr_add_naprop > 2.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_3_c220 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => -0.0214630054,
    rv_a44_curr_add_naprop > 2.5                                    => -0.0868906394,
    rv_a44_curr_add_naprop = NULL                                   => -0.0544394242,
                                                                       -0.0544394242);

final_score_3_c221 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.1106665825,
    rv_d33_eviction_recency > 549                                     => 0.0134482047,
    rv_d33_eviction_recency = NULL                                    => 0.0408101327,
                                                                         0.0408101327);

rc009_3_11_c221 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0698564499,
    rv_d33_eviction_recency > 549                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc002_3_7_c219 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc002_3_7_c220,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_3_c219 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_3_c220,
    rv_d30_derog_count > 0.5                                => final_score_3_c221,
    rv_d30_derog_count = NULL                               => -0.0367868353,
                                                               -0.0367868353);

rc009_3_11_c219 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => rc009_3_11_c221,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_3_6_c219 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0775969680,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc005_3_2 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc005_3_2_c218,
    iv_f00_nas_summary > 9.5                                => rc005_3_2_1,
    iv_f00_nas_summary = NULL                               => rc005_3_2_1,
                                                               rc005_3_2_1);

final_score_3 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => final_score_3_c218,
    iv_f00_nas_summary > 9.5                                => final_score_3_c219,
    iv_f00_nas_summary = NULL                               => 0.0751704410,
                                                               -0.0051125986);

rc004_3_1 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => 0.0770040132,
    iv_f00_nas_summary > 9.5                                => 0.0000000000,
    iv_f00_nas_summary = NULL                               => 0.0802830396,
                                                               rc004_3_1_1);

rc002_3_7 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc002_3_7_1,
    iv_f00_nas_summary > 9.5                                => rc002_3_7_c219,
    iv_f00_nas_summary = NULL                               => rc002_3_7_1,
                                                               rc002_3_7_1);

rc001_3_6 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc001_3_6_1,
    iv_f00_nas_summary > 9.5                                => rc001_3_6_c219,
    iv_f00_nas_summary = NULL                               => rc001_3_6_1,
                                                               rc001_3_6_1);

rc009_3_11 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc009_3_11_1,
    iv_f00_nas_summary > 9.5                                => rc009_3_11_c219,
    iv_f00_nas_summary = NULL                               => rc009_3_11_1,
                                                               rc009_3_11_1);

rc002_4_2_c223 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => 0.0168602568,
    rv_a44_curr_add_naprop > 2.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_4_c223 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => 0.0844595044,
    rv_a44_curr_add_naprop > 2.5                                    => 0.0010503775,
    rv_a44_curr_add_naprop = NULL                                   => 0.0675992476,
                                                                       0.0675992476);

final_score_4_c226 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.1006331841,
    iv_college_tier > 3                             => -0.0153561591,
    iv_college_tier = NULL                          => -0.0267455157,
                                                       -0.0267455157);

rc005_4_8_c226 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0113893566,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_4_8_c225 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc005_4_8_c226,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_4_7_c225 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0636141945,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_4_c225 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_4_c226,
    rv_d30_derog_count > 0.5                                => 0.0538025418,
    rv_d30_derog_count = NULL                               => -0.0098116527,
                                                               -0.0098116527);

final_score_4_c224 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_4_c225,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0889501392,
    rv_a44_curr_add_naprop = NULL                                   => -0.0347314651,
                                                                       -0.0347314651);

rc001_4_7_c224 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc001_4_7_c225,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc002_4_6_c224 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0249198123,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc005_4_8_c224 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc005_4_8_c225,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_4 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 1.5 => final_score_4_c223,
    rv_c13_inp_addr_lres > 1.5                                  => final_score_4_c224,
    rv_c13_inp_addr_lres = NULL                                 => 0.0458765545,
                                                                   -0.0051658092);

rc003_4_1 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 1.5 => 0.0727650568,
    rv_c13_inp_addr_lres > 1.5                                  => 0.0000000000,
    rv_c13_inp_addr_lres = NULL                                 => 0.0510423636,
                                                                   rc003_4_1_1);

rc002_4_2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 1.5 => rc002_4_2_c223,
    rv_c13_inp_addr_lres > 1.5                                  => rc002_4_2_1,
    rv_c13_inp_addr_lres = NULL                                 => rc002_4_2_1,
                                                                   rc002_4_2_1);

rc001_4_7 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 1.5 => rc001_4_7_1,
    rv_c13_inp_addr_lres > 1.5                                  => rc001_4_7_c224,
    rv_c13_inp_addr_lres = NULL                                 => rc001_4_7_1,
                                                                   rc001_4_7_1);

rc005_4_8 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 1.5 => rc005_4_8_1,
    rv_c13_inp_addr_lres > 1.5                                  => rc005_4_8_c224,
    rv_c13_inp_addr_lres = NULL                                 => rc005_4_8_1,
                                                                   rc005_4_8_1);

rc002_4_6 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 1.5 => rc002_4_6_1,
    rv_c13_inp_addr_lres > 1.5                                  => rc002_4_6_c224,
    rv_c13_inp_addr_lres = NULL                                 => rc002_4_6_1,
                                                                   rc002_4_6_1);

final_score_5_c230 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0980723913,
    iv_college_tier > 3                             => -0.0112540516,
    iv_college_tier = NULL                          => -0.0228824884,
                                                       -0.0228824884);

rc005_5_4_c230 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0116284368,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_5_4_c229 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc005_5_4_c230,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_5_c229 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_5_c230,
    rv_d30_derog_count > 0.5                                => 0.0479025274,
    rv_d30_derog_count = NULL                               => -0.0081484498,
                                                               -0.0081484498);

rc001_5_3_c229 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0560509772,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc005_5_4_c228 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc005_5_4_c229,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc002_5_2_c228 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0232937405,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_5_c228 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_5_c229,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0854878325,
    rv_a44_curr_add_naprop = NULL                                   => -0.0314421903,
                                                                       -0.0314421903);

rc001_5_3_c228 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc001_5_3_c229,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_5_c231 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0520660331,
    iv_college_tier > 3                             => 0.0694976225,
    iv_college_tier = NULL                          => 0.0605198789,
                                                       0.0605198789);

rc005_5_12_c231 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0089777437,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc001_5_3 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc001_5_3_c228,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc001_5_3_1,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc001_5_3_1,
                                                                             rc001_5_3_1);

final_score_5 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => final_score_5_c228,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => final_score_5_c231,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0599900780,
                                                                             -0.0081348934);

rc002_5_2 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc002_5_2_c228,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc002_5_2_1,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc002_5_2_1,
                                                                             rc002_5_2_1);

rc005_5_4 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc005_5_4_c228,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc005_5_4_1,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc005_5_4_1,
                                                                             rc005_5_4_1);

rc007_5_1 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => 0.0000000000,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0686547722,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0681249713,
                                                                             rc007_5_1_1);

rc005_5_12 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc005_5_12_1,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc005_5_12_c231,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc005_5_12_1,
                                                                             rc005_5_12_1);

rc002_6_2_c233 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => 0.0163826047,
    rv_a44_curr_add_naprop > 1.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_6_c233 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => 0.0673717711,
    rv_a44_curr_add_naprop > 1.5                                    => -0.0040551383,
    rv_a44_curr_add_naprop = NULL                                   => 0.0509891664,
                                                                       0.0509891664);

final_score_6_c236 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0871178909,
    iv_college_tier > 3                             => 0.0035016945,
    iv_college_tier = NULL                          => -0.0090876856,
                                                       -0.0090876856);

rc005_6_8_c236 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0125893801,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_6_8_c235 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => rc005_6_8_c236,
    rv_d30_derog_count > 1.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_6_7_c235 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => 0.0000000000,
    rv_d30_derog_count > 1.5                                => 0.0726788388,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_6_c235 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => final_score_6_c236,
    rv_d30_derog_count > 1.5                                => 0.0731502407,
    rv_d30_derog_count = NULL                               => 0.0004714018,
                                                               0.0004714018);

rc005_6_8_c234 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc005_6_8_c235,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc001_6_7_c234 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc001_6_7_c235,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

final_score_6_c234 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => final_score_6_c235,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => -0.0594734937,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => -0.0303530045,
                                                                                           -0.0303530045);

rc008_6_6_c234 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0308244064,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc001_6_7 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc001_6_7_1,
    iv_f00_nas_summary > 9.5                                => rc001_6_7_c234,
    iv_f00_nas_summary = NULL                               => rc001_6_7_1,
                                                               rc001_6_7_1);

rc004_6_1 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => 0.0573598506,
    iv_f00_nas_summary > 9.5                                => 0.0000000000,
    iv_f00_nas_summary = NULL                               => 0.0639319841,
                                                               rc004_6_1_1);

rc005_6_8 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc005_6_8_1,
    iv_f00_nas_summary > 9.5                                => rc005_6_8_c234,
    iv_f00_nas_summary = NULL                               => rc005_6_8_1,
                                                               rc005_6_8_1);

rc002_6_2 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc002_6_2_c233,
    iv_f00_nas_summary > 9.5                                => rc002_6_2_1,
    iv_f00_nas_summary = NULL                               => rc002_6_2_1,
                                                               rc002_6_2_1);

final_score_6 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => final_score_6_c233,
    iv_f00_nas_summary > 9.5                                => final_score_6_c234,
    iv_f00_nas_summary = NULL                               => 0.0575612999,
                                                               -0.0063706842);

rc008_6_6 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc008_6_6_1,
    iv_f00_nas_summary > 9.5                                => rc008_6_6_c234,
    iv_f00_nas_summary = NULL                               => rc008_6_6_1,
                                                               rc008_6_6_1);

final_score_7_c239 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0392849068,
    rv_d30_derog_count > 0.5                                => 0.0861580630,
    rv_d30_derog_count = NULL                               => 0.0522086142,
                                                               0.0522086142);

rc001_7_4_c239 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0339494487,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_7_4_c238 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc001_7_4_c239,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_7_c238 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => -0.0413844721,
    iv_college_tier > 52                             => final_score_7_c239,
    iv_college_tier = NULL                           => 0.0420363027,
                                                        0.0420363027);

rc005_7_2_c238 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => 0.0101723115,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_7_c241 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => -0.0077847542,
    iv_num_non_bureau_sources > 1.5                                       => -0.0630035649,
    iv_num_non_bureau_sources = NULL                                      => -0.0442905681,
                                                                             -0.0442905681);

rc010_7_10_c241 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => 0.0365058139,
    iv_num_non_bureau_sources > 1.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_7_c240 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_7_c241,
    rv_d30_derog_count > 0.5                                => 0.0273442731,
    rv_d30_derog_count = NULL                               => -0.0315378460,
                                                               -0.0315378460);

rc010_7_10_c240 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc010_7_10_c241,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_7_9_c240 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0588821191,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc010_7_10 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc010_7_10_1,
    rv_c13_inp_addr_lres > 4.5                                  => rc010_7_10_c240,
    rv_c13_inp_addr_lres = NULL                                 => rc010_7_10_1,
                                                                   rc010_7_10_1);

rc001_7_4 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc001_7_4_c238,
    rv_c13_inp_addr_lres > 4.5                                  => rc001_7_4_1,
    rv_c13_inp_addr_lres = NULL                                 => rc001_7_4_1,
                                                                   rc001_7_4_1);

rc003_7_1 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => 0.0495619088,
    rv_c13_inp_addr_lres > 4.5                                  => 0.0000000000,
    rv_c13_inp_addr_lres = NULL                                 => 0.0410281530,
                                                                   rc003_7_1_1);

rc001_7_9 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc001_7_9_1,
    rv_c13_inp_addr_lres > 4.5                                  => rc001_7_9_c240,
    rv_c13_inp_addr_lres = NULL                                 => rc001_7_9_1,
                                                                   rc001_7_9_1);

final_score_7 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => final_score_7_c238,
    rv_c13_inp_addr_lres > 4.5                                  => final_score_7_c240,
    rv_c13_inp_addr_lres = NULL                                 => 0.0335025470,
                                                                   -0.0075256061);

rc005_7_2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc005_7_2_c238,
    rv_c13_inp_addr_lres > 4.5                                  => rc005_7_2_1,
    rv_c13_inp_addr_lres = NULL                                 => rc005_7_2_1,
                                                                   rc005_7_2_1);

rc012_8_7_c246 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.1355035729,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

final_score_8_c246 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => -0.0177266879,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.1216141461,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0138894267,
                                                                                     -0.0138894267);

rc012_8_7_c245 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0000000000,
    rv_comb_age > 22.5                         => rc012_8_7_c246,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc014_8_5_c245 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0528223338,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_8_c245 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0503558826,
    rv_comb_age > 22.5                         => final_score_8_c246,
    rv_comb_age = NULL                         => -0.0024664511,
                                                  -0.0024664511);

final_score_8_c244 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0784400138,
    rv_d33_eviction_recency > 549                                     => final_score_8_c245,
    rv_d33_eviction_recency = NULL                                    => 0.0039587353,
                                                                         0.0039587353);

rc014_8_5_c244 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0000000000,
    rv_d33_eviction_recency > 549                                     => rc014_8_5_c245,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc009_8_3_c244 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0744812785,
    rv_d33_eviction_recency > 549                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc012_8_7_c244 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0000000000,
    rv_d33_eviction_recency > 549                                     => rc012_8_7_c245,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc014_8_5_c243 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc014_8_5_c244,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0000000000,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0000000000,
                                                                             NULL);

rc009_8_3_c243 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc009_8_3_c244,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0000000000,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_8_c243 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => final_score_8_c244,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0578425982,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0623447382,
                                                                             0.0214445819);

rc012_8_7_c243 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc012_8_7_c244,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0000000000,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0000000000,
                                                                             NULL);

rc007_8_2_c243 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => 0.0000000000,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0363980163,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0409001562,
                                                                             NULL);

rc009_8_3 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc009_8_3_c243,
    rv_a44_curr_add_naprop > 2.5                                    => rc009_8_3_1,
    rv_a44_curr_add_naprop = NULL                                   => rc009_8_3_1,
                                                                       rc009_8_3_1);

rc014_8_5 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc014_8_5_c243,
    rv_a44_curr_add_naprop > 2.5                                    => rc014_8_5_1,
    rv_a44_curr_add_naprop = NULL                                   => rc014_8_5_1,
                                                                       rc014_8_5_1);

final_score_8 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => final_score_8_c243,
    rv_a44_curr_add_naprop > 2.5                                    => -0.0489590184,
    rv_a44_curr_add_naprop = NULL                                   => 0.0216824690,
                                                                       -0.0060768722);

rc012_8_7 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc012_8_7_c243,
    rv_a44_curr_add_naprop > 2.5                                    => rc012_8_7_1,
    rv_a44_curr_add_naprop = NULL                                   => rc012_8_7_1,
                                                                       rc012_8_7_1);

rc002_8_1 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => 0.0275214541,
    rv_a44_curr_add_naprop > 2.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0277593412,
                                                                       rc002_8_1_1);

rc007_8_2 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc007_8_2_c243,
    rv_a44_curr_add_naprop > 2.5                                    => rc007_8_2_1,
    rv_a44_curr_add_naprop = NULL                                   => rc007_8_2_1,
                                                                       rc007_8_2_1);

rc019_9_8_c251 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 0.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 0.5                                          => 0.0965338475,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_9_c251 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 0.5 => -0.0162905930,
    rv_d32_criminal_behavior_lvl > 0.5                                          => 0.0845159164,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0120179311,
                                                                                   -0.0120179311);

rc014_9_6_c250 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0523392063,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc019_9_8_c250 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0000000000,
    rv_comb_age > 22.5                         => rc019_9_8_c251,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_9_c250 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0501352940,
    rv_comb_age > 22.5                         => final_score_9_c251,
    rv_comb_age = NULL                         => -0.0022039123,
                                                  -0.0022039123);

final_score_9_c249 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 98.5 => 0.0721203376,
    rv_d33_eviction_recency > 98.5                                     => final_score_9_c250,
    rv_d33_eviction_recency = NULL                                     => 0.0031314462,
                                                                          0.0031314462);

rc019_9_8_c249 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 98.5 => 0.0000000000,
    rv_d33_eviction_recency > 98.5                                     => rc019_9_8_c250,
    rv_d33_eviction_recency = NULL                                     => 0.0000000000,
                                                                          NULL);

rc009_9_4_c249 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 98.5 => 0.0689888914,
    rv_d33_eviction_recency > 98.5                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                     => 0.0000000000,
                                                                          NULL);

rc014_9_6_c249 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 98.5 => 0.0000000000,
    rv_d33_eviction_recency > 98.5                                     => rc014_9_6_c250,
    rv_d33_eviction_recency = NULL                                     => 0.0000000000,
                                                                          NULL);

rc014_9_6_c248 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => 0.0000000000,
    iv_c22_addr_ver_sources > 1.5                                     => rc014_9_6_c249,
    iv_c22_addr_ver_sources = NULL                                    => 0.0000000000,
                                                                         NULL);

rc006_9_2_c248 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => 0.0326055237,
    iv_c22_addr_ver_sources > 1.5                                     => 0.0000000000,
    iv_c22_addr_ver_sources = NULL                                    => 0.0000000000,
                                                                         NULL);

rc019_9_8_c248 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => 0.0000000000,
    iv_c22_addr_ver_sources > 1.5                                     => rc019_9_8_c249,
    iv_c22_addr_ver_sources = NULL                                    => 0.0000000000,
                                                                         NULL);

rc009_9_4_c248 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => 0.0000000000,
    iv_c22_addr_ver_sources > 1.5                                     => rc009_9_4_c249,
    iv_c22_addr_ver_sources = NULL                                    => 0.0000000000,
                                                                         NULL);

final_score_9_c248 := map(
    NULL < iv_c22_addr_ver_sources AND iv_c22_addr_ver_sources <= 1.5 => 0.0511719753,
    iv_c22_addr_ver_sources > 1.5                                     => final_score_9_c249,
    iv_c22_addr_ver_sources = NULL                                    => 0.0185664515,
                                                                         0.0185664515);

rc014_9_6 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc014_9_6_c248,
    rv_a44_curr_add_naprop > 2.5                                    => rc014_9_6_1,
    rv_a44_curr_add_naprop = NULL                                   => rc014_9_6_1,
                                                                       rc014_9_6_1);

rc006_9_2 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc006_9_2_c248,
    rv_a44_curr_add_naprop > 2.5                                    => rc006_9_2_1,
    rv_a44_curr_add_naprop = NULL                                   => rc006_9_2_1,
                                                                       rc006_9_2_1);

rc009_9_4 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc009_9_4_c248,
    rv_a44_curr_add_naprop > 2.5                                    => rc009_9_4_1,
    rv_a44_curr_add_naprop = NULL                                   => rc009_9_4_1,
                                                                       rc009_9_4_1);

rc019_9_8 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => rc019_9_8_c248,
    rv_a44_curr_add_naprop > 2.5                                    => rc019_9_8_1,
    rv_a44_curr_add_naprop = NULL                                   => rc019_9_8_1,
                                                                       rc019_9_8_1);

rc002_9_1 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => 0.0251453043,
    rv_a44_curr_add_naprop > 2.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0239307335,
                                                                       rc002_9_1_1);

final_score_9 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 2.5 => final_score_9_c248,
    rv_a44_curr_add_naprop > 2.5                                    => -0.0456224731,
    rv_a44_curr_add_naprop = NULL                                   => 0.0173518808,
                                                                       -0.0065788528);

rc005_10_3_c254 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0098481139,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_10_c254 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0789054295,
    iv_college_tier > 3                             => 0.0268053838,
    iv_college_tier = NULL                          => 0.0169572699,
                                                       0.0169572699);

rc001_10_2_c253 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0381943806,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc005_10_3_c253 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc005_10_3_c254,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_10_c253 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_10_c254,
    rv_d30_derog_count > 0.5                                => 0.0690948599,
    rv_d30_derog_count = NULL                               => 0.0309004793,
                                                               0.0309004793);

rc001_10_10_c256 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0396068757,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_10_c256 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => -0.0180878351,
    rv_d30_derog_count > 0.5                                => 0.0319749975,
    rv_d30_derog_count = NULL                               => -0.0076318781,
                                                               -0.0076318781);

rc001_10_10_c255 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc001_10_10_c256,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_10_c255 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_10_c256,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0717094870,
    rv_a44_curr_add_naprop = NULL                                   => -0.0286107104,
                                                                       -0.0286107104);

rc002_10_9_c255 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0209788323,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_10 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => final_score_10_c253,
    rv_c13_inp_addr_lres > 4.5                                  => final_score_10_c255,
    rv_c13_inp_addr_lres = NULL                                 => 0.0215540113,
                                                                   -0.0092273452);

rc005_10_3 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc005_10_3_c253,
    rv_c13_inp_addr_lres > 4.5                                  => rc005_10_3_1,
    rv_c13_inp_addr_lres = NULL                                 => rc005_10_3_1,
                                                                   rc005_10_3_1);

rc001_10_10 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc001_10_10_1,
    rv_c13_inp_addr_lres > 4.5                                  => rc001_10_10_c255,
    rv_c13_inp_addr_lres = NULL                                 => rc001_10_10_1,
                                                                   rc001_10_10_1);

rc002_10_9 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc002_10_9_1,
    rv_c13_inp_addr_lres > 4.5                                  => rc002_10_9_c255,
    rv_c13_inp_addr_lres = NULL                                 => rc002_10_9_1,
                                                                   rc002_10_9_1);

rc001_10_2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => rc001_10_2_c253,
    rv_c13_inp_addr_lres > 4.5                                  => rc001_10_2_1,
    rv_c13_inp_addr_lres = NULL                                 => rc001_10_2_1,
                                                                   rc001_10_2_1);

rc003_10_1 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 4.5 => 0.0401278245,
    rv_c13_inp_addr_lres > 4.5                                  => 0.0000000000,
    rv_c13_inp_addr_lres = NULL                                 => 0.0307813565,
                                                                   rc003_10_1_1);

final_score_11_c259 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0732001681,
    iv_college_tier > 3                             => 0.0244507548,
    iv_college_tier = NULL                          => 0.0164623785,
                                                       0.0164623785);

rc005_11_3_c259 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0079883763,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_11_3_c258 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc005_11_3_c259,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_11_2_c258 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0339301515,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_11_c258 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_11_c259,
    rv_d30_derog_count > 0.5                                => 0.0623826229,
    rv_d30_derog_count = NULL                               => 0.0284524714,
                                                               0.0284524714);

final_score_11_c261 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => -0.0568196079,
    iv_college_tier > 52                             => 0.0154405805,
    iv_college_tier = NULL                           => 0.0031287164,
                                                        0.0031287164);

rc005_11_10_c261 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => 0.0123118641,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_11_c260 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => final_score_11_c261,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => -0.0474076653,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => -0.0226838668,
                                                                                           -0.0226838668);

rc008_11_9_c260 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0258125832,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc005_11_10_c260 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc005_11_10_c261,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc008_11_9 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc008_11_9_1,
    iv_f00_nas_summary > 9.5                                => rc008_11_9_c260,
    iv_f00_nas_summary = NULL                               => rc008_11_9_1,
                                                               rc008_11_9_1);

rc004_11_1 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => 0.0356996868,
    iv_f00_nas_summary > 9.5                                => 0.0000000000,
    iv_f00_nas_summary = NULL                               => 0.0488712388,
                                                               rc004_11_1_1);

final_score_11 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => final_score_11_c258,
    iv_f00_nas_summary > 9.5                                => final_score_11_c260,
    iv_f00_nas_summary = NULL                               => 0.0416240234,
                                                               -0.0072472154);

rc005_11_3 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc005_11_3_c258,
    iv_f00_nas_summary > 9.5                                => rc005_11_3_1,
    iv_f00_nas_summary = NULL                               => rc005_11_3_1,
                                                               rc005_11_3_1);

rc005_11_10 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc005_11_10_1,
    iv_f00_nas_summary > 9.5                                => rc005_11_10_c260,
    iv_f00_nas_summary = NULL                               => rc005_11_10_1,
                                                               rc005_11_10_1);

rc001_11_2 := map(
    NULL < iv_f00_nas_summary AND iv_f00_nas_summary <= 9.5 => rc001_11_2_c258,
    iv_f00_nas_summary > 9.5                                => rc001_11_2_1,
    iv_f00_nas_summary = NULL                               => rc001_11_2_1,
                                                               rc001_11_2_1);

rc019_12_4_c264 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 1.5                                          => 0.0746778802,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_12_c264 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => 0.0302847643,
    rv_d32_criminal_behavior_lvl > 1.5                                          => 0.1090979195,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0344200393,
                                                                                   0.0344200393);

rc005_12_2_c263 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => 0.0080832221,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_12_c263 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => -0.0388937458,
    iv_college_tier > 52                             => final_score_12_c264,
    iv_college_tier = NULL                           => 0.0263368172,
                                                        0.0263368172);

rc019_12_4_c263 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc019_12_4_c264,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

rc011_12_10_c266 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0154977751,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_12_c266 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => -0.0092919391,
    iv_input_best_phone_match > -0.5                                       => -0.0620418577,
    iv_input_best_phone_match = NULL                                       => -0.0566441816,
                                                                              -0.0247897142);

final_score_12_c265 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_12_c266,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.1266607603,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0217359419,
                                                                                     -0.0217359419);

rc012_12_9_c265 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.1483967023,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc011_12_10_c265 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc011_12_10_c266,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc003_12_1 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 5.5 => 0.0319093022,
    rv_c13_inp_addr_lres > 5.5                                  => 0.0000000000,
    rv_c13_inp_addr_lres = NULL                                 => 0.0159029616,
                                                                   rc003_12_1_1);

rc011_12_10 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 5.5 => rc011_12_10_1,
    rv_c13_inp_addr_lres > 5.5                                  => rc011_12_10_c265,
    rv_c13_inp_addr_lres = NULL                                 => rc011_12_10_1,
                                                                   rc011_12_10_1);

rc019_12_4 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 5.5 => rc019_12_4_c263,
    rv_c13_inp_addr_lres > 5.5                                  => rc019_12_4_1,
    rv_c13_inp_addr_lres = NULL                                 => rc019_12_4_1,
                                                                   rc019_12_4_1);

final_score_12 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 5.5 => final_score_12_c263,
    rv_c13_inp_addr_lres > 5.5                                  => final_score_12_c265,
    rv_c13_inp_addr_lres = NULL                                 => 0.0103304766,
                                                                   -0.0055724850);

rc005_12_2 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 5.5 => rc005_12_2_c263,
    rv_c13_inp_addr_lres > 5.5                                  => rc005_12_2_1,
    rv_c13_inp_addr_lres = NULL                                 => rc005_12_2_1,
                                                                   rc005_12_2_1);

rc012_12_9 := map(
    NULL < rv_c13_inp_addr_lres AND rv_c13_inp_addr_lres <= 5.5 => rc012_12_9_1,
    rv_c13_inp_addr_lres > 5.5                                  => rc012_12_9_c265,
    rv_c13_inp_addr_lres = NULL                                 => rc012_12_9_1,
                                                                   rc012_12_9_1);

rc016_13_8_c271 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0052506878,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_13_c271 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0150478128,
    iv_br_source_count > 0.5                                => -0.0543550110,
    iv_br_source_count = NULL                               => 0.0097971251,
                                                               0.0097971251);

final_score_13_c270 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 70.5 => 0.0799831324,
    rv_d32_mos_since_crim_ls > 70.5                                      => final_score_13_c271,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0132075250,
                                                                            0.0132075250);

rc022_13_6_c270 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 70.5 => 0.0667756074,
    rv_d32_mos_since_crim_ls > 70.5                                      => 0.0000000000,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

rc016_13_8_c270 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 70.5 => 0.0000000000,
    rv_d32_mos_since_crim_ls > 70.5                                      => rc016_13_8_c271,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

rc009_13_4_c269 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0510092546,
    rv_d33_eviction_recency > 549                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc016_13_8_c269 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0000000000,
    rv_d33_eviction_recency > 549                                     => rc016_13_8_c270,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc022_13_6_c269 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0000000000,
    rv_d33_eviction_recency > 549                                     => rc022_13_6_c270,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

final_score_13_c269 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0691569664,
    rv_d33_eviction_recency > 549                                     => final_score_13_c270,
    rv_d33_eviction_recency = NULL                                    => 0.0181477118,
                                                                         0.0181477118);

rc016_13_8_c268 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc016_13_8_c269,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc022_13_6_c268 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc022_13_6_c269,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_13_c268 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0655856846,
    iv_college_tier > 3                             => final_score_13_c269,
    iv_college_tier = NULL                          => 0.0093926021,
                                                       0.0093926021);

rc009_13_4_c268 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc009_13_4_c269,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_13_2_c268 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0087551098,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc002_13_1 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0163800015,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0166981429,
                                                                       rc002_13_1_1);

rc005_13_2 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc005_13_2_c268,
    rv_a44_curr_add_naprop > 3.5                                    => rc005_13_2_1,
    rv_a44_curr_add_naprop = NULL                                   => rc005_13_2_1,
                                                                       rc005_13_2_1);

rc009_13_4 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc009_13_4_c268,
    rv_a44_curr_add_naprop > 3.5                                    => rc009_13_4_1,
    rv_a44_curr_add_naprop = NULL                                   => rc009_13_4_1,
                                                                       rc009_13_4_1);

final_score_13 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_13_c268,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0573174801,
    rv_a44_curr_add_naprop = NULL                                   => 0.0097107434,
                                                                       -0.0069873994);

rc016_13_8 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc016_13_8_c268,
    rv_a44_curr_add_naprop > 3.5                                    => rc016_13_8_1,
    rv_a44_curr_add_naprop = NULL                                   => rc016_13_8_1,
                                                                       rc016_13_8_1);

rc022_13_6 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc022_13_6_c268,
    rv_a44_curr_add_naprop > 3.5                                    => rc022_13_6_1,
    rv_a44_curr_add_naprop = NULL                                   => rc022_13_6_1,
                                                                       rc022_13_6_1);

final_score_14_c275 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => -0.0044797151,
    rv_d30_derog_count > 0.5                                => 0.0538475809,
    rv_d30_derog_count = NULL                               => 0.0019656659,
                                                               0.0019656659);

rc001_14_4_c275 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0518819150,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_14_c276 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 98.5 => 0.0391747750,
    rv_d33_eviction_recency > 98.5                                     => -0.0487048562,
    rv_d33_eviction_recency = NULL                                     => -0.0439053242,
                                                                          -0.0439053242);

rc009_14_8_c276 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 98.5 => 0.0830800992,
    rv_d33_eviction_recency > 98.5                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                     => 0.0000000000,
                                                                          NULL);

rc009_14_8_c274 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => 0.0000000000,
    iv_source_type > 5.5                            => rc009_14_8_c276,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

rc001_14_4_c274 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => rc001_14_4_c275,
    iv_source_type > 5.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_14_c274 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => final_score_14_c275,
    iv_source_type > 5.5                            => final_score_14_c276,
    iv_source_type = NULL                           => -0.0241246260,
                                                       -0.0241246260);

rc023_14_3_c274 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => 0.0260902919,
    iv_source_type > 5.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

rc023_14_3_c273 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc023_14_3_c274,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0000000000,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

rc020_14_2_c273 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => 0.0000000000,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0798451270,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_14_c273 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => final_score_14_c274,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0609886473,
    rv_i62_inq_addrs_per_adl = NULL                                     => -0.0188564797,
                                                                           -0.0188564797);

rc001_14_4_c273 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc001_14_4_c274,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0000000000,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

rc009_14_8_c273 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc009_14_8_c274,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0000000000,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

rc009_14_8 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc009_14_8_c273,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc009_14_8_1,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc009_14_8_1,
                                                                             rc009_14_8_1);

rc023_14_3 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc023_14_3_c273,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc023_14_3_1,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc023_14_3_1,
                                                                             rc023_14_3_1);

rc001_14_4 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc001_14_4_c273,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc001_14_4_1,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc001_14_4_1,
                                                                             rc001_14_4_1);

rc020_14_2 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => rc020_14_2_c273,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => rc020_14_2_1,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => rc020_14_2_1,
                                                                             rc020_14_2_1);

final_score_14 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => final_score_14_c273,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0282057024,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0354132541,
                                                                             -0.0065712650);

rc007_14_1 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => 0.0000000000,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0347769674,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0419845191,
                                                                             rc007_14_1_1);

rc017_15_6_c280 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 4.5 => 0.0608413681,
    iv_c13_avg_lres > 4.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_15_c280 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 4.5 => 0.0802212293,
    iv_c13_avg_lres > 4.5                             => 0.0165627128,
    iv_c13_avg_lres = NULL                            => 0.0193798612,
                                                         0.0193798612);

rc009_15_4_c279 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0387822659,
    rv_d33_eviction_recency > 549                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc017_15_6_c279 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0000000000,
    rv_d33_eviction_recency > 549                                     => rc017_15_6_c280,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

final_score_15_c279 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 549 => 0.0625857071,
    rv_d33_eviction_recency > 549                                     => final_score_15_c280,
    rv_d33_eviction_recency = NULL                                    => 0.0238034412,
                                                                         0.0238034412);

final_score_15_c278 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0565492300,
    iv_college_tier > 3                             => final_score_15_c279,
    iv_college_tier = NULL                          => 0.0150632985,
                                                       0.0150632985);

rc017_15_6_c278 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc017_15_6_c279,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc009_15_4_c278 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc009_15_4_c279,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_15_2_c278 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0087401427,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc010_15_12_c281 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => 0.0333619145,
    iv_num_non_bureau_sources > 1.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_15_c281 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => 0.0043672695,
    iv_num_non_bureau_sources > 1.5                                       => -0.0436929016,
    iv_num_non_bureau_sources = NULL                                      => -0.0289946449,
                                                                             -0.0289946449);

final_score_15 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => final_score_15_c278,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => final_score_15_c281,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => -0.0010516510,
                                                                                           -0.0059813118);

rc017_15_6 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc017_15_6_c278,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc017_15_6_1,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc017_15_6_1,
                                                                                           rc017_15_6_1);

rc009_15_4 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc009_15_4_c278,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc009_15_4_1,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc009_15_4_1,
                                                                                           rc009_15_4_1);

rc005_15_2 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc005_15_2_c278,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc005_15_2_1,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc005_15_2_1,
                                                                                           rc005_15_2_1);

rc010_15_12 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc010_15_12_1,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc010_15_12_c281,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc010_15_12_1,
                                                                                           rc010_15_12_1);

rc008_15_1 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0210446102,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0049296608,
                                                                                           rc008_15_1_1);

rc022_16_5_c286 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 541 => 0.0466527828,
    rv_d32_mos_since_crim_ls > 541                                      => 0.0000000000,
    rv_d32_mos_since_crim_ls = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_16_c286 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 541 => 0.0776790117,
    rv_d32_mos_since_crim_ls > 541                                      => 0.0278175263,
    rv_d32_mos_since_crim_ls = NULL                                     => 0.0310262289,
                                                                           0.0310262289);

final_score_16_c285 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => final_score_16_c286,
    iv_college_code > 3                             => -0.0516829545,
    iv_college_code = NULL                          => 0.0257767732,
                                                       0.0257767732);

rc022_16_5_c285 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc022_16_5_c286,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

rc029_16_4_c285 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => 0.0052494557,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

rc016_16_3_c284 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0049749498,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc029_16_4_c284 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc029_16_4_c285,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc022_16_5_c284 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc022_16_5_c285,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_16_c284 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_16_c285,
    iv_br_source_count > 0.5                                => -0.0412262133,
    iv_br_source_count = NULL                               => 0.0208018234,
                                                               0.0208018234);

rc016_16_3_c283 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc016_16_3_c284,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc029_16_4_c283 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc029_16_4_c284,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc011_16_2_c283 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0084823742,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc022_16_5_c283 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc022_16_5_c284,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_16_c283 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => final_score_16_c284,
    iv_input_best_phone_match > -0.5                                       => -0.0246091374,
    iv_input_best_phone_match = NULL                                       => -0.0234474078,
                                                                              0.0123194492);

rc002_16_1 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => 0.0183674458,
    rv_a44_curr_add_naprop > 1.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0045472180,
                                                                       rc002_16_1_1);

rc029_16_4 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => rc029_16_4_c283,
    rv_a44_curr_add_naprop > 1.5                                    => rc029_16_4_1,
    rv_a44_curr_add_naprop = NULL                                   => rc029_16_4_1,
                                                                       rc029_16_4_1);

rc016_16_3 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => rc016_16_3_c283,
    rv_a44_curr_add_naprop > 1.5                                    => rc016_16_3_1,
    rv_a44_curr_add_naprop = NULL                                   => rc016_16_3_1,
                                                                       rc016_16_3_1);

final_score_16 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => final_score_16_c283,
    rv_a44_curr_add_naprop > 1.5                                    => -0.0330277427,
    rv_a44_curr_add_naprop = NULL                                   => -0.0015007786,
                                                                       -0.0060479966);

rc022_16_5 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => rc022_16_5_c283,
    rv_a44_curr_add_naprop > 1.5                                    => rc022_16_5_1,
    rv_a44_curr_add_naprop = NULL                                   => rc022_16_5_1,
                                                                       rc022_16_5_1);

rc011_16_2 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 1.5 => rc011_16_2_c283,
    rv_a44_curr_add_naprop > 1.5                                    => rc011_16_2_1,
    rv_a44_curr_add_naprop = NULL                                   => rc011_16_2_1,
                                                                       rc011_16_2_1);

final_score_17_c289 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0053730997,
    iv_unverified_addr_count > 0.5                                      => 0.0306086349,
    iv_unverified_addr_count = NULL                                     => 0.0111124173,
                                                                           0.0111124173);

rc015_17_3_c289 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0194962176,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc020_17_7_c290 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => 0.0000000000,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0921447729,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_17_c290 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => -0.0383562272,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0584258763,
    rv_i62_inq_addrs_per_adl = NULL                                     => -0.0337188966,
                                                                           -0.0337188966);

rc010_17_2_c288 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => 0.0263526568,
    iv_num_non_bureau_sources > 1.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc015_17_3_c288 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => rc015_17_3_c289,
    iv_num_non_bureau_sources > 1.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc020_17_7_c288 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => 0.0000000000,
    iv_num_non_bureau_sources > 1.5                                       => rc020_17_7_c290,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_17_c288 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => final_score_17_c289,
    iv_num_non_bureau_sources > 1.5                                       => final_score_17_c290,
    iv_num_non_bureau_sources = NULL                                      => -0.0152402395,
                                                                             -0.0152402395);

rc010_17_12_c291 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0274243875,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_17_c291 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0562358038,
    iv_num_non_bureau_sources > 2.5                                       => 0.0072354150,
    iv_num_non_bureau_sources = NULL                                      => 0.0288114163,
                                                                             0.0288114163);

rc010_17_12 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc010_17_12_1,
    rv_d30_derog_count > 0.5                                => rc010_17_12_c291,
    rv_d30_derog_count = NULL                               => rc010_17_12_1,
                                                               rc010_17_12_1);

rc010_17_2 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc010_17_2_c288,
    rv_d30_derog_count > 0.5                                => rc010_17_2_1,
    rv_d30_derog_count = NULL                               => rc010_17_2_1,
                                                               rc010_17_2_1);

rc015_17_3 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc015_17_3_c288,
    rv_d30_derog_count > 0.5                                => rc015_17_3_1,
    rv_d30_derog_count = NULL                               => rc015_17_3_1,
                                                               rc015_17_3_1);

rc001_17_1 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0348429304,
    rv_d30_derog_count = NULL                               => 0.0126281569,
                                                               rc001_17_1_1);

final_score_17 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_17_c288,
    rv_d30_derog_count > 0.5                                => final_score_17_c291,
    rv_d30_derog_count = NULL                               => 0.0065966427,
                                                               -0.0060315142);

rc020_17_7 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc020_17_7_c288,
    rv_d30_derog_count > 0.5                                => rc020_17_7_1,
    rv_d30_derog_count = NULL                               => rc020_17_7_1,
                                                               rc020_17_7_1);

rc013_18_6_c296 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0311253013,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_18_c296 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0127208569,
    rv_email_domain_free_count > 1.5                                        => 0.0492433672,
    rv_email_domain_free_count = NULL                                       => 0.0181180659,
                                                                               0.0181180659);

rc019_18_5_c295 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 1.5                                          => 0.0542886267,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_18_c295 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => final_score_18_c296,
    rv_d32_criminal_behavior_lvl > 1.5                                          => 0.0746726545,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0203840278,
                                                                                   0.0203840278);

rc013_18_6_c295 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => rc013_18_6_c296,
    rv_d32_criminal_behavior_lvl > 1.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc011_18_4_c294 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0075829236,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc019_18_5_c294 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc019_18_5_c295,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_18_c294 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => final_score_18_c295,
    iv_input_best_phone_match > -0.5                                       => -0.0165212655,
    iv_input_best_phone_match = NULL                                       => -0.0184949762,
                                                                              0.0128011042);

rc013_18_6_c294 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc013_18_6_c295,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc013_18_6_c293 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc013_18_6_c294,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_18_c293 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0540727764,
    iv_college_tier > 3                             => final_score_18_c294,
    iv_college_tier = NULL                          => 0.0058682983,
                                                       0.0058682983);

rc005_18_2_c293 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0069328059,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc011_18_4_c293 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc011_18_4_c294,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc019_18_5_c293 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc019_18_5_c294,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc011_18_4 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc011_18_4_c293,
    rv_a44_curr_add_naprop > 3.5                                    => rc011_18_4_1,
    rv_a44_curr_add_naprop = NULL                                   => rc011_18_4_1,
                                                                       rc011_18_4_1);

rc019_18_5 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc019_18_5_c293,
    rv_a44_curr_add_naprop > 3.5                                    => rc019_18_5_1,
    rv_a44_curr_add_naprop = NULL                                   => rc019_18_5_1,
                                                                       rc019_18_5_1);

rc005_18_2 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc005_18_2_c293,
    rv_a44_curr_add_naprop > 3.5                                    => rc005_18_2_1,
    rv_a44_curr_add_naprop = NULL                                   => rc005_18_2_1,
                                                                       rc005_18_2_1);

rc002_18_1 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0134605287,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0140232544,
                                                                       rc002_18_1_1);

rc013_18_6 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc013_18_6_c293,
    rv_a44_curr_add_naprop > 3.5                                    => rc013_18_6_1,
    rv_a44_curr_add_naprop = NULL                                   => rc013_18_6_1,
                                                                       rc013_18_6_1);

final_score_18 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_18_c293,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0493840339,
    rv_a44_curr_add_naprop = NULL                                   => 0.0064310240,
                                                                       -0.0075922304);

rc001_19_6_c300 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0216469318,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_19_c300 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0085195949,
    rv_d30_derog_count > 0.5                                => 0.0372876941,
    rv_d30_derog_count = NULL                               => 0.0156407623,
                                                               0.0156407623);

final_score_19_c299 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0755778284,
    iv_header_emergence_age > 15.5                                     => final_score_19_c300,
    iv_header_emergence_age = NULL                                     => 0.0192680367,
                                                                          0.0192680367);

rc025_19_4_c299 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0563097917,
    iv_header_emergence_age > 15.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc001_19_6_c299 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0000000000,
    iv_header_emergence_age > 15.5                                     => rc001_19_6_c300,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc001_19_6_c298 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc001_19_6_c299,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_19_c298 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => -0.0391822929,
    iv_college_tier > 52                             => final_score_19_c299,
    iv_college_tier = NULL                           => 0.0105090515,
                                                        0.0105090515);

rc025_19_4_c298 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc025_19_4_c299,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

rc005_19_2_c298 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => 0.0087589852,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

final_score_19_c301 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => -0.0244683317,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0797453606,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0227363380,
                                                                                     -0.0227363380);

rc012_19_12_c301 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.1024816986,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

final_score_19 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 57.5 => final_score_19_c298,
    iv_c13_avg_lres > 57.5                             => final_score_19_c301,
    iv_c13_avg_lres = NULL                             => 0.0007509593,
                                                          -0.0057372123);

rc005_19_2 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 57.5 => rc005_19_2_c298,
    iv_c13_avg_lres > 57.5                             => rc005_19_2_1,
    iv_c13_avg_lres = NULL                             => rc005_19_2_1,
                                                          rc005_19_2_1);

rc025_19_4 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 57.5 => rc025_19_4_c298,
    iv_c13_avg_lres > 57.5                             => rc025_19_4_1,
    iv_c13_avg_lres = NULL                             => rc025_19_4_1,
                                                          rc025_19_4_1);

rc012_19_12 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 57.5 => rc012_19_12_1,
    iv_c13_avg_lres > 57.5                             => rc012_19_12_c301,
    iv_c13_avg_lres = NULL                             => rc012_19_12_1,
                                                          rc012_19_12_1);

rc017_19_1 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 57.5 => 0.0162462638,
    iv_c13_avg_lres > 57.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                             => 0.0064881715,
                                                          rc017_19_1_1);

rc001_19_6 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 57.5 => rc001_19_6_c298,
    iv_c13_avg_lres > 57.5                             => rc001_19_6_1,
    iv_c13_avg_lres = NULL                             => rc001_19_6_1,
                                                          rc001_19_6_1);

final_score_20_c305 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0155727761,
    rv_comb_age > 22.5                         => -0.0383909656,
    rv_comb_age = NULL                         => -0.0300395485,
                                                  -0.0300395485);

rc014_20_5_c305 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0456123246,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc010_20_9_c306 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0290740260,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_20_c306 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0429959036,
    iv_num_non_bureau_sources > 2.5                                       => -0.0039928972,
    iv_num_non_bureau_sources = NULL                                      => 0.0139218776,
                                                                             0.0139218776);

rc001_20_4_c304 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0367800822,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc014_20_5_c304 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc014_20_5_c305,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_20_c304 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_20_c305,
    rv_d30_derog_count > 0.5                                => final_score_20_c306,
    rv_d30_derog_count = NULL                               => -0.0228582046,
                                                               -0.0228582046);

rc010_20_9_c304 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => rc010_20_9_c306,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_20_c303 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 0.5 => final_score_20_c304,
    rv_i62_inq_num_names_per_adl > 0.5                                          => 0.0462003745,
    rv_i62_inq_num_names_per_adl = NULL                                         => -0.0188084641,
                                                                                   -0.0188084641);

rc010_20_9_c303 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 0.5 => rc010_20_9_c304,
    rv_i62_inq_num_names_per_adl > 0.5                                          => 0.0000000000,
    rv_i62_inq_num_names_per_adl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc001_20_4_c303 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 0.5 => rc001_20_4_c304,
    rv_i62_inq_num_names_per_adl > 0.5                                          => 0.0000000000,
    rv_i62_inq_num_names_per_adl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc014_20_5_c303 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 0.5 => rc014_20_5_c304,
    rv_i62_inq_num_names_per_adl > 0.5                                          => 0.0000000000,
    rv_i62_inq_num_names_per_adl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_20 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0211191276,
    rv_f01_inp_addr_address_score > 95                                           => final_score_20_c303,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0048307146,
                                                                                    -0.0077407850);

rc010_20_9 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc010_20_9_1,
    rv_f01_inp_addr_address_score > 95                                           => rc010_20_9_c303,
    rv_f01_inp_addr_address_score = NULL                                         => rc010_20_9_1,
                                                                                    rc010_20_9_1);

rc021_20_1 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0288599126,
    rv_f01_inp_addr_address_score > 95                                           => 0.0000000000,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0125714996,
                                                                                    rc021_20_1_1);

rc001_20_4 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc001_20_4_1,
    rv_f01_inp_addr_address_score > 95                                           => rc001_20_4_c303,
    rv_f01_inp_addr_address_score = NULL                                         => rc001_20_4_1,
                                                                                    rc001_20_4_1);

rc014_20_5 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc014_20_5_1,
    rv_f01_inp_addr_address_score > 95                                           => rc014_20_5_c303,
    rv_f01_inp_addr_address_score = NULL                                         => rc014_20_5_1,
                                                                                    rc014_20_5_1);

final_score_21_c310 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0177701620,
    rv_f01_inp_addr_address_score > 95                                           => -0.0121470336,
    rv_f01_inp_addr_address_score = NULL                                         => -0.0010485517,
                                                                                    -0.0010485517);

rc021_21_5_c310 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0188187136,
    rv_f01_inp_addr_address_score > 95                                           => 0.0000000000,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0000000000,
                                                                                    NULL);

final_score_21_c309 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => final_score_21_c310,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0337612403,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0093259901,
                                                                                 0.0093259901);

rc024_21_4_c309 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0244352502,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc021_21_5_c309 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc021_21_5_c310,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc017_21_2_c308 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0638621729,
    iv_c13_avg_lres > 3.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_21_c308 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0756407111,
    iv_c13_avg_lres > 3.5                             => final_score_21_c309,
    iv_c13_avg_lres = NULL                            => 0.0117785382,
                                                         0.0117785382);

rc024_21_4_c308 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0000000000,
    iv_c13_avg_lres > 3.5                             => rc024_21_4_c309,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc021_21_5_c308 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0000000000,
    iv_c13_avg_lres > 3.5                             => rc021_21_5_c309,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc033_21_12_c311 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0838142980,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0386513415,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0000000000,
                                                                                          NULL);

final_score_21_c311 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0612294354,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0160664789,
    iv_bureau_emergence_age_buronly = NULL                                             => -0.0274992624,
                                                                                          -0.0225848626);

rc033_21_12 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc033_21_12_1,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc033_21_12_c311,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc033_21_12_1,
                                                                                           rc033_21_12_1);

rc017_21_2 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc017_21_2_c308,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc017_21_2_1,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc017_21_2_1,
                                                                                           rc017_21_2_1);

rc024_21_4 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc024_21_4_c308,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc024_21_4_1,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc024_21_4_1,
                                                                                           rc024_21_4_1);

final_score_21 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => final_score_21_c308,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => final_score_21_c311,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0067598868,
                                                                                           -0.0044704042);

rc021_21_5 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc021_21_5_c308,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc021_21_5_1,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => rc021_21_5_1,
                                                                                           rc021_21_5_1);

rc008_21_1 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0162489423,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0112302909,
                                                                                           rc008_21_1_1);

final_score_22_c316 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 67.5 => 0.0141457031,
    iv_c13_avg_lres > 67.5                             => -0.0164663391,
    iv_c13_avg_lres = NULL                             => 0.0044632293,
                                                          0.0044632293);

rc017_22_5_c316 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 67.5 => 0.0096824737,
    iv_c13_avg_lres > 67.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                             => 0.0000000000,
                                                          NULL);

final_score_22_c315 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_22_c316,
    rv_s66_adlperssn_count > 1.5                                    => 0.0289623044,
    rv_s66_adlperssn_count = NULL                                   => 0.0448665597,
                                                                       0.0148106681);

rc017_22_5_c315 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc017_22_5_c316,
    rv_s66_adlperssn_count > 1.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc018_22_4_c315 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0141516363,
    rv_s66_adlperssn_count = NULL                                   => 0.0300558916,
                                                                       NULL);

rc017_22_5_c314 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc017_22_5_c315,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

final_score_22_c314 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => final_score_22_c315,
    iv_college_code > 3                             => -0.0542320244,
    iv_college_code = NULL                          => 0.0092160485,
                                                       0.0092160485);

rc029_22_3_c314 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => 0.0055946197,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

rc018_22_4_c314 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc018_22_4_c315,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

rc018_22_4_c313 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc018_22_4_c314,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc016_22_2_c313 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0045362925,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc017_22_5_c313 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc017_22_5_c314,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_22_c313 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_22_c314,
    iv_br_source_count > 0.5                                => -0.0485718613,
    iv_br_source_count = NULL                               => 0.0046797560,
                                                               0.0046797560);

rc029_22_3_c313 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc029_22_3_c314,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc018_22_4 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc018_22_4_c313,
    rv_a44_curr_add_naprop > 3.5                                    => rc018_22_4_1,
    rv_a44_curr_add_naprop = NULL                                   => rc018_22_4_1,
                                                                       rc018_22_4_1);

rc002_22_1 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0116981359,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0104524840,
                                                                       rc002_22_1_1);

rc017_22_5 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc017_22_5_c313,
    rv_a44_curr_add_naprop > 3.5                                    => rc017_22_5_1,
    rv_a44_curr_add_naprop = NULL                                   => rc017_22_5_1,
                                                                       rc017_22_5_1);

rc016_22_2 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc016_22_2_c313,
    rv_a44_curr_add_naprop > 3.5                                    => rc016_22_2_1,
    rv_a44_curr_add_naprop = NULL                                   => rc016_22_2_1,
                                                                       rc016_22_2_1);

final_score_22 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_22_c313,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0431059868,
    rv_a44_curr_add_naprop = NULL                                   => 0.0034341041,
                                                                       -0.0070183799);

rc029_22_3 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc029_22_3_c313,
    rv_a44_curr_add_naprop > 3.5                                    => rc029_22_3_1,
    rv_a44_curr_add_naprop = NULL                                   => rc029_22_3_1,
                                                                       rc029_22_3_1);

final_score_23_c320 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => -0.0021698524,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0276703305,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0066225561,
                                                                                 0.0066225561);

rc024_23_4_c320 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0210477744,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_23_c321 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0110213039,
    iv_bureau_verification_index > 9.5                                          => -0.0362261973,
    iv_bureau_verification_index = NULL                                         => -0.0308184294,
                                                                                   -0.0308184294);

rc028_23_8_c321 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0418397333,
    iv_bureau_verification_index > 9.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc024_23_4_c319 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => rc024_23_4_c320,
    iv_source_type > 5.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

rc028_23_8_c319 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => 0.0000000000,
    iv_source_type > 5.5                            => rc028_23_8_c321,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_23_c319 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => final_score_23_c320,
    iv_source_type > 5.5                            => final_score_23_c321,
    iv_source_type = NULL                           => -0.0122371669,
                                                       -0.0122371669);

rc023_23_3_c319 := map(
    NULL < iv_source_type AND iv_source_type <= 5.5 => 0.0188597230,
    iv_source_type > 5.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_23_c318 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_23_c319,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0828345451,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0104417070,
                                                                                     -0.0104417070);

rc023_23_3_c318 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc023_23_3_c319,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc012_23_2_c318 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0932762520,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc024_23_4_c318 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc024_23_4_c319,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc028_23_8_c318 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc028_23_8_c319,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc012_23_2 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => rc012_23_2_c318,
    rv_d30_derog_count > 1.5                                => rc012_23_2_1,
    rv_d30_derog_count = NULL                               => rc012_23_2_1,
                                                               rc012_23_2_1);

rc023_23_3 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => rc023_23_3_c318,
    rv_d30_derog_count > 1.5                                => rc023_23_3_1,
    rv_d30_derog_count = NULL                               => rc023_23_3_1,
                                                               rc023_23_3_1);

final_score_23 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => final_score_23_c318,
    rv_d30_derog_count > 1.5                                => 0.0327364165,
    rv_d30_derog_count = NULL                               => 0.0131080549,
                                                               -0.0056656896);

rc001_23_1 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => 0.0000000000,
    rv_d30_derog_count > 1.5                                => 0.0384021060,
    rv_d30_derog_count = NULL                               => 0.0187737444,
                                                               rc001_23_1_1);

rc028_23_8 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => rc028_23_8_c318,
    rv_d30_derog_count > 1.5                                => rc028_23_8_1,
    rv_d30_derog_count = NULL                               => rc028_23_8_1,
                                                               rc028_23_8_1);

rc024_23_4 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => rc024_23_4_c318,
    rv_d30_derog_count > 1.5                                => rc024_23_4_1,
    rv_d30_derog_count = NULL                               => rc024_23_4_1,
                                                               rc024_23_4_1);

rc022_24_4_c325 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 64.5 => 0.0526226999,
    rv_d32_mos_since_crim_ls > 64.5                                      => 0.0000000000,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

final_score_24_c325 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 64.5 => 0.0448516633,
    rv_d32_mos_since_crim_ls > 64.5                                      => -0.0098668986,
    rv_d32_mos_since_crim_ls = NULL                                      => -0.0077710367,
                                                                            -0.0077710367);

rc013_24_3_c324 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0328497771,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc022_24_4_c324 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc022_24_4_c325,
    rv_email_domain_free_count > 1.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_24_c324 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => final_score_24_c325,
    rv_email_domain_free_count > 1.5                                        => 0.0300978287,
    rv_email_domain_free_count = NULL                                       => -0.0027519484,
                                                                               -0.0027519484);

final_score_24_c326 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0268891440,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0143099065,
    rv_a44_curr_add_naprop = NULL                                   => 0.0177501722,
                                                                       0.0177501722);

rc002_24_10_c326 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0091389719,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc022_24_4_c323 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc022_24_4_c324,
    rv_s66_adlperssn_count > 1.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc018_24_2_c323 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0115482921,
    rv_s66_adlperssn_count = NULL                                   => 0.0388012040,
                                                                       NULL);

rc002_24_10_c323 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => rc002_24_10_c326,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc013_24_3_c323 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc013_24_3_c324,
    rv_s66_adlperssn_count > 1.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_24_c323 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_24_c324,
    rv_s66_adlperssn_count > 1.5                                    => final_score_24_c326,
    rv_s66_adlperssn_count = NULL                                   => 0.0450030840,
                                                                       0.0062018800);

rc013_24_3 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc013_24_3_c323,
    iv_input_best_phone_match > -0.5                                       => rc013_24_3_1,
    iv_input_best_phone_match = NULL                                       => rc013_24_3_1,
                                                                              rc013_24_3_1);

rc018_24_2 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc018_24_2_c323,
    iv_input_best_phone_match > -0.5                                       => rc018_24_2_1,
    iv_input_best_phone_match = NULL                                       => rc018_24_2_1,
                                                                              rc018_24_2_1);

rc002_24_10 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc002_24_10_c323,
    iv_input_best_phone_match > -0.5                                       => rc002_24_10_1,
    iv_input_best_phone_match = NULL                                       => rc002_24_10_1,
                                                                              rc002_24_10_1);

rc022_24_4 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc022_24_4_c323,
    iv_input_best_phone_match > -0.5                                       => rc022_24_4_1,
    iv_input_best_phone_match = NULL                                       => rc022_24_4_1,
                                                                              rc022_24_4_1);

final_score_24 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => final_score_24_c323,
    iv_input_best_phone_match > -0.5                                       => -0.0324815113,
    iv_input_best_phone_match = NULL                                       => -0.0206902876,
                                                                              -0.0033343078);

rc011_24_1 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0095361878,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              rc011_24_1_1);

final_score_25_c329 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0006589941,
    iv_unverified_addr_count > 0.5                                      => 0.0322440386,
    iv_unverified_addr_count = NULL                                     => 0.0128393327,
                                                                           0.0128393327);

rc015_25_4_c329 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0194047059,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_25_c331 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0047388664,
    iv_unverified_addr_count > 1.5                                      => 0.0257655457,
    iv_unverified_addr_count = NULL                                     => 0.0043266812,
                                                                           0.0043266812);

rc015_25_9_c331 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0214388645,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc015_25_9_c330 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => rc015_25_9_c331,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc028_25_8_c330 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0153060795,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

final_score_25_c330 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => final_score_25_c331,
    iv_bureau_verification_index > 13.5                                          => -0.0283239521,
    iv_bureau_verification_index = NULL                                          => -0.0109793983,
                                                                                    -0.0109793983);

rc015_25_4_c328 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => rc015_25_4_c329,
    rv_f00_input_dob_match_level > 7.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc015_25_9_c328 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 7.5                                          => rc015_25_9_c330,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_25_c328 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => final_score_25_c329,
    rv_f00_input_dob_match_level > 7.5                                          => final_score_25_c330,
    rv_f00_input_dob_match_level = NULL                                         => -0.0535555349,
                                                                                   -0.0077072248);

rc032_25_3_c328 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0205465575,
    rv_f00_input_dob_match_level > 7.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc028_25_8_c328 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 7.5                                          => rc028_25_8_c330,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc015_25_4 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 60.5 => rc015_25_4_1,
    rv_d33_eviction_recency > 60.5                                     => rc015_25_4_c328,
    rv_d33_eviction_recency = NULL                                     => rc015_25_4_1,
                                                                          rc015_25_4_1);

rc015_25_9 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 60.5 => rc015_25_9_1,
    rv_d33_eviction_recency > 60.5                                     => rc015_25_9_c328,
    rv_d33_eviction_recency = NULL                                     => rc015_25_9_1,
                                                                          rc015_25_9_1);

rc009_25_1 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 60.5 => 0.0483370417,
    rv_d33_eviction_recency > 60.5                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                     => 0.0038860204,
                                                                          rc009_25_1_1);

final_score_25 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 60.5 => 0.0430876649,
    rv_d33_eviction_recency > 60.5                                     => final_score_25_c328,
    rv_d33_eviction_recency = NULL                                     => -0.0013633564,
                                                                          -0.0052493768);

rc032_25_3 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 60.5 => rc032_25_3_1,
    rv_d33_eviction_recency > 60.5                                     => rc032_25_3_c328,
    rv_d33_eviction_recency = NULL                                     => rc032_25_3_1,
                                                                          rc032_25_3_1);

rc028_25_8 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 60.5 => rc028_25_8_1,
    rv_d33_eviction_recency > 60.5                                     => rc028_25_8_c328,
    rv_d33_eviction_recency = NULL                                     => rc028_25_8_1,
                                                                          rc028_25_8_1);

rc022_26_6_c336 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 79.5 => 0.0437102847,
    rv_d32_mos_since_crim_ls > 79.5                                      => 0.0000000000,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

final_score_26_c336 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 79.5 => 0.0498812299,
    rv_d32_mos_since_crim_ls > 79.5                                      => 0.0038593495,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0061709452,
                                                                            0.0061709452);

rc022_26_6_c335 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => rc022_26_6_c336,
    rv_email_domain_free_count > 0.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_26_c335 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => final_score_26_c336,
    rv_email_domain_free_count > 0.5                                        => 0.0295940583,
    rv_email_domain_free_count = NULL                                       => 0.0144276037,
                                                                               0.0144276037);

rc013_26_5_c335 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0151664545,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc022_26_6_c334 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc022_26_6_c335,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc013_26_5_c334 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc013_26_5_c335,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc016_26_4_c334 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0042026928,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_26_c334 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_26_c335,
    iv_br_source_count > 0.5                                => -0.0310268747,
    iv_br_source_count = NULL                               => 0.0102249109,
                                                               0.0102249109);

final_score_26_c333 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => -0.0359354978,
    iv_college_tier > 52                             => final_score_26_c334,
    iv_college_tier = NULL                           => 0.0040862262,
                                                        0.0040862262);

rc016_26_4_c333 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc016_26_4_c334,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

rc013_26_5_c333 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc013_26_5_c334,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

rc005_26_2_c333 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => 0.0061386847,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

rc022_26_6_c333 := map(
    NULL < iv_college_tier AND iv_college_tier <= 52 => 0.0000000000,
    iv_college_tier > 52                             => rc022_26_6_c334,
    iv_college_tier = NULL                           => 0.0000000000,
                                                        NULL);

rc022_26_6 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc022_26_6_c333,
    iv_input_best_phone_match > -0.5                                       => rc022_26_6_1,
    iv_input_best_phone_match = NULL                                       => rc022_26_6_1,
                                                                              rc022_26_6_1);

rc016_26_4 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc016_26_4_c333,
    iv_input_best_phone_match > -0.5                                       => rc016_26_4_1,
    iv_input_best_phone_match = NULL                                       => rc016_26_4_1,
                                                                              rc016_26_4_1);

final_score_26 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => final_score_26_c333,
    iv_input_best_phone_match > -0.5                                       => -0.0294336473,
    iv_input_best_phone_match = NULL                                       => -0.0212532229,
                                                                              -0.0043089774);

rc013_26_5 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc013_26_5_c333,
    iv_input_best_phone_match > -0.5                                       => rc013_26_5_1,
    iv_input_best_phone_match = NULL                                       => rc013_26_5_1,
                                                                              rc013_26_5_1);

rc011_26_1 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0083952037,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              rc011_26_1_1);

rc005_26_2 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc005_26_2_c333,
    iv_input_best_phone_match > -0.5                                       => rc005_26_2_1,
    iv_input_best_phone_match = NULL                                       => rc005_26_2_1,
                                                                              rc005_26_2_1);

final_score_27_c340 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0001338650,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => -0.0338346836,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => -0.0180727150,
                                                                                           -0.0180727150);

rc008_27_6_c340 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0182065800,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc033_27_3_c339 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 13.5 => 0.0859038283,
    iv_bureau_emergence_age_buronly > 13.5                                             => 0.0229688261,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0000000000,
                                                                                          NULL);

final_score_27_c339 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 13.5 => 0.0730096965,
    iv_bureau_emergence_age_buronly > 13.5                                             => 0.0100746943,
    iv_bureau_emergence_age_buronly = NULL                                             => final_score_27_c340,
                                                                                          -0.0128941318);

rc008_27_6_c339 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 13.5 => 0.0000000000,
    iv_bureau_emergence_age_buronly > 13.5                                             => 0.0000000000,
    iv_bureau_emergence_age_buronly = NULL                                             => rc008_27_6_c340,
                                                                                          NULL);

rc012_27_2_c338 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0977197740,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc008_27_6_c338 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc008_27_6_c339,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc033_27_3_c338 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc033_27_3_c339,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

final_score_27_c338 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_27_c339,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0864302823,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0112894917,
                                                                                     -0.0112894917);

final_score_27_c341 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0275274014,
    rv_d31_bk_filing_count > 0.5                                    => -0.0309814943,
    rv_d31_bk_filing_count = NULL                                   => 0.0202715658,
                                                                       0.0202715658);

rc034_27_12_c341 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0072558356,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc012_27_2 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc012_27_2_c338,
    rv_d30_derog_count > 0.5                                => rc012_27_2_1,
    rv_d30_derog_count = NULL                               => rc012_27_2_1,
                                                               rc012_27_2_1);

rc008_27_6 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc008_27_6_c338,
    rv_d30_derog_count > 0.5                                => rc008_27_6_1,
    rv_d30_derog_count = NULL                               => rc008_27_6_1,
                                                               rc008_27_6_1);

rc034_27_12 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc034_27_12_1,
    rv_d30_derog_count > 0.5                                => rc034_27_12_c341,
    rv_d30_derog_count = NULL                               => rc034_27_12_1,
                                                               rc034_27_12_1);

rc033_27_3 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc033_27_3_c338,
    rv_d30_derog_count > 0.5                                => rc033_27_3_1,
    rv_d30_derog_count = NULL                               => rc033_27_3_1,
                                                               rc033_27_3_1);

rc001_27_1 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0248864309,
    rv_d30_derog_count = NULL                               => 0.0122089568,
                                                               rc001_27_1_1);

final_score_27 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_27_c338,
    rv_d30_derog_count > 0.5                                => final_score_27_c341,
    rv_d30_derog_count = NULL                               => 0.0075940917,
                                                               -0.0046148651);

final_score_28_c345 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0132396173,
    iv_unverified_addr_count > 0.5                                      => 0.0128485939,
    iv_unverified_addr_count = NULL                                     => 0.0006156055,
                                                                           0.0006156055);

rc015_28_5_c345 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0122329884,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc019_28_9_c346 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.1091288656,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_28_c346 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => -0.0323520056,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0780534706,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0310753949,
                                                                                   -0.0310753949);

final_score_28_c344 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => final_score_28_c345,
    iv_bureau_verification_index > 13.5                                          => final_score_28_c346,
    iv_bureau_verification_index = NULL                                          => -0.0143234100,
                                                                                    -0.0143234100);

rc015_28_5_c344 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => rc015_28_5_c345,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc019_28_9_c344 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0000000000,
    iv_bureau_verification_index > 13.5                                          => rc019_28_9_c346,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc028_28_4_c344 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0149390155,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc032_28_2_c343 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0213253740,
    rv_f00_input_dob_match_level > 7.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_28_c343 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0112628367,
    rv_f00_input_dob_match_level > 7.5                                          => final_score_28_c344,
    rv_f00_input_dob_match_level = NULL                                         => -0.0495892062,
                                                                                   -0.0100625372);

rc015_28_5_c343 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 7.5                                          => rc015_28_5_c344,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc019_28_9_c343 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 7.5                                          => rc019_28_9_c344,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc028_28_4_c343 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 7.5                                          => rc028_28_4_c344,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc028_28_4 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc028_28_4_c343,
    rv_email_domain_free_count > 1.5                                        => rc028_28_4_1,
    rv_email_domain_free_count = NULL                                       => rc028_28_4_1,
                                                                               rc028_28_4_1);

rc019_28_9 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc019_28_9_c343,
    rv_email_domain_free_count > 1.5                                        => rc019_28_9_1,
    rv_email_domain_free_count = NULL                                       => rc019_28_9_1,
                                                                               rc019_28_9_1);

rc015_28_5 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc015_28_5_c343,
    rv_email_domain_free_count > 1.5                                        => rc015_28_5_1,
    rv_email_domain_free_count = NULL                                       => rc015_28_5_1,
                                                                               rc015_28_5_1);

rc013_28_1 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0337689381,
    rv_email_domain_free_count = NULL                                       => 0.0088445256,
                                                                               rc013_28_1_1);

final_score_28 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => final_score_28_c343,
    rv_email_domain_free_count > 1.5                                        => 0.0289953249,
    rv_email_domain_free_count = NULL                                       => 0.0040709124,
                                                                               -0.0047736132);

rc032_28_2 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc032_28_2_c343,
    rv_email_domain_free_count > 1.5                                        => rc032_28_2_1,
    rv_email_domain_free_count = NULL                                       => rc032_28_2_1,
                                                                               rc032_28_2_1);

final_score_29_c348 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0135186823,
    rv_email_domain_free_count > 0.5                                        => 0.0701995664,
    rv_email_domain_free_count = NULL                                       => 0.0059854509,
                                                                               0.0268864384);

rc013_29_2_c348 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0433131280,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_29_c350 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => -0.0166597953,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0368872948,
    rv_i62_inq_addrs_per_adl = NULL                                     => -0.0140496829,
                                                                           -0.0140496829);

rc020_29_7_c350 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => 0.0000000000,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0509369777,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_29_c351 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0335621446,
    iv_num_non_bureau_sources > 2.5                                       => 0.0021124873,
    iv_num_non_bureau_sources = NULL                                      => 0.0156063297,
                                                                             0.0156063297);

rc010_29_11_c351 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0179558149,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc020_29_7_c349 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc020_29_7_c350,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_29_6_c349 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0228784156,
    rv_d30_derog_count = NULL                               => 0.0198787431,
                                                               NULL);

rc010_29_11_c349 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => rc010_29_11_c351,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_29_c349 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_29_c350,
    rv_d30_derog_count > 0.5                                => final_score_29_c351,
    rv_d30_derog_count = NULL                               => 0.0126066573,
                                                               -0.0072720858);

rc020_29_7 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc020_29_7_1,
    rv_comb_age > 21.5                         => rc020_29_7_c349,
    rv_comb_age = NULL                         => rc020_29_7_1,
                                                  rc020_29_7_1);

rc001_29_6 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc001_29_6_1,
    rv_comb_age > 21.5                         => rc001_29_6_c349,
    rv_comb_age = NULL                         => rc001_29_6_1,
                                                  rc001_29_6_1);

rc010_29_11 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc010_29_11_1,
    rv_comb_age > 21.5                         => rc010_29_11_c349,
    rv_comb_age = NULL                         => rc010_29_11_1,
                                                  rc010_29_11_1);

rc013_29_2 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc013_29_2_c348,
    rv_comb_age > 21.5                         => rc013_29_2_1,
    rv_comb_age = NULL                         => rc013_29_2_1,
                                                  rc013_29_2_1);

final_score_29 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => final_score_29_c348,
    rv_comb_age > 21.5                         => final_score_29_c349,
    rv_comb_age = NULL                         => -0.1222488662,
                                                  -0.0035511534);

rc014_29_1 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0304375917,
    rv_comb_age > 21.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  rc014_29_1_1);

rc008_30_5_c355 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0091404047,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

final_score_30_c355 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0344943052,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0117917648,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0253539005,
                                                                                           0.0253539005);

final_score_30_c354 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_30_c355,
    rv_a44_curr_add_naprop > 3.5                                    => -0.0307018513,
    rv_a44_curr_add_naprop = NULL                                   => 0.0141503645,
                                                                       0.0141503645);

rc002_30_4_c354 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0112035360,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc008_30_5_c354 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc008_30_5_c355,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_30_c353 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0048410196,
    iv_unverified_addr_count > 0.5                                      => final_score_30_c354,
    iv_unverified_addr_count = NULL                                     => 0.0052793459,
                                                                           0.0052793459);

rc015_30_2_c353 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0088710186,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc002_30_4_c353 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc002_30_4_c354,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc008_30_5_c353 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc008_30_5_c354,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_30_c356 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 30 => 0.0352680140,
    rv_d33_eviction_recency > 30                                     => -0.0226422161,
    rv_d33_eviction_recency = NULL                                   => -0.0202061653,
                                                                        -0.0202061653);

rc009_30_12_c356 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 30 => 0.0554741793,
    rv_d33_eviction_recency > 30                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                   => 0.0000000000,
                                                                        NULL);

rc010_30_1 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0095090767,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0114015288,
                                                                             rc010_30_1_1);

rc015_30_2 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => rc015_30_2_c353,
    iv_num_non_bureau_sources > 2.5                                       => rc015_30_2_1,
    iv_num_non_bureau_sources = NULL                                      => rc015_30_2_1,
                                                                             rc015_30_2_1);

final_score_30 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => final_score_30_c353,
    iv_num_non_bureau_sources > 2.5                                       => final_score_30_c356,
    iv_num_non_bureau_sources = NULL                                      => 0.0071717979,
                                                                             -0.0042297308);

rc002_30_4 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => rc002_30_4_c353,
    iv_num_non_bureau_sources > 2.5                                       => rc002_30_4_1,
    iv_num_non_bureau_sources = NULL                                      => rc002_30_4_1,
                                                                             rc002_30_4_1);

rc008_30_5 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => rc008_30_5_c353,
    iv_num_non_bureau_sources > 2.5                                       => rc008_30_5_1,
    iv_num_non_bureau_sources = NULL                                      => rc008_30_5_1,
                                                                             rc008_30_5_1);

rc009_30_12 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => rc009_30_12_1,
    iv_num_non_bureau_sources > 2.5                                       => rc009_30_12_c356,
    iv_num_non_bureau_sources = NULL                                      => rc009_30_12_1,
                                                                             rc009_30_12_1);

final_score_31_c358 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => -0.0215574525,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0537422731,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0201221396,
                                                                                   -0.0201221396);

rc019_31_3_c358 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0738644127,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc017_31_11_c361 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0667750697,
    iv_c13_avg_lres > 2.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_31_c361 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0640935860,
    iv_c13_avg_lres > 2.5                             => -0.0042594232,
    iv_c13_avg_lres = NULL                            => -0.0026814837,
                                                         -0.0026814837);

rc030_31_9_c360 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0268615342,
    rv_f00_dob_score > 98                              => 0.0012068448,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_31_c360 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0229732058,
    rv_f00_dob_score > 98                              => final_score_31_c361,
    rv_f00_dob_score = NULL                            => -0.0554827847,
                                                          -0.0038883285);

rc017_31_11_c360 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0000000000,
    rv_f00_dob_score > 98                              => rc017_31_11_c361,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_31_c359 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0234545952,
    iv_prv_addr_lres > 7.5                              => final_score_31_c360,
    iv_prv_addr_lres = NULL                             => 0.0068139233,
                                                           0.0045563217);

rc017_31_11_c359 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0000000000,
    iv_prv_addr_lres > 7.5                              => rc017_31_11_c360,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc027_31_7_c359 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0188982735,
    iv_prv_addr_lres > 7.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0022576015,
                                                           NULL);

rc030_31_9_c359 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0000000000,
    iv_prv_addr_lres > 7.5                              => rc030_31_9_c360,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc027_31_7 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 55.25 => rc027_31_7_1,
    rv_a49_curr_avm_chg_1yr_pct > 55.25                                         => rc027_31_7_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc027_31_7_c359,
                                                                                   rc027_31_7_1);

rc030_31_9 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 55.25 => rc030_31_9_1,
    rv_a49_curr_avm_chg_1yr_pct > 55.25                                         => rc030_31_9_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc030_31_9_c359,
                                                                                   rc030_31_9_1);

rc017_31_11 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 55.25 => rc017_31_11_1,
    rv_a49_curr_avm_chg_1yr_pct > 55.25                                         => rc017_31_11_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc017_31_11_c359,
                                                                                   rc017_31_11_1);

final_score_31 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 55.25 => 0.0293554723,
    rv_a49_curr_avm_chg_1yr_pct > 55.25                                         => final_score_31_c358,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_31_c359,
                                                                                   -0.0032781312);

rc019_31_3 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 55.25 => rc019_31_3_1,
    rv_a49_curr_avm_chg_1yr_pct > 55.25                                         => rc019_31_3_c358,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc019_31_3_1,
                                                                                   rc019_31_3_1);

rc026_31_1 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 55.25 => 0.0326336034,
    rv_a49_curr_avm_chg_1yr_pct > 55.25                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0078344529,
                                                                                   rc026_31_1_1);

rc019_32_4_c365 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0549274109,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_32_c365 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => -0.0180575223,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0380153682,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0169120427,
                                                                                   -0.0169120427);

rc013_32_8_c366 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0151195117,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_32_c366 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => -0.0025702250,
    rv_email_domain_free_count > 0.5                                        => 0.0210288980,
    rv_email_domain_free_count = NULL                                       => 0.0059093862,
                                                                               0.0059093862);

final_score_32_c364 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => final_score_32_c365,
    rv_l79_adls_per_addr_c6 > 0.5                                     => final_score_32_c366,
    rv_l79_adls_per_addr_c6 = NULL                                    => -0.0079514395,
                                                                         -0.0079514395);

rc019_32_4_c364 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc019_32_4_c365,
    rv_l79_adls_per_addr_c6 > 0.5                                     => 0.0000000000,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         NULL);

rc013_32_8_c364 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc013_32_8_c366,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         NULL);

rc036_32_3_c364 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_addr_c6 > 0.5                                     => 0.0138608257,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         NULL);

rc036_32_3_c363 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc036_32_3_c364,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc013_32_8_c363 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc013_32_8_c364,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc019_32_4_c363 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc019_32_4_c364,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc012_32_2_c363 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0581597584,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

final_score_32_c363 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_32_c364,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0513690661,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0166540913,
                                                                                     -0.0067906923);

rc036_32_3 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc036_32_3_c363,
    rv_s66_adlperssn_count > 2.5                                    => rc036_32_3_1,
    rv_s66_adlperssn_count = NULL                                   => rc036_32_3_1,
                                                                       rc036_32_3_1);

rc013_32_8 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc013_32_8_c363,
    rv_s66_adlperssn_count > 2.5                                    => rc013_32_8_1,
    rv_s66_adlperssn_count = NULL                                   => rc013_32_8_1,
                                                                       rc013_32_8_1);

rc019_32_4 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc019_32_4_c363,
    rv_s66_adlperssn_count > 2.5                                    => rc019_32_4_1,
    rv_s66_adlperssn_count = NULL                                   => rc019_32_4_1,
                                                                       rc019_32_4_1);

rc018_32_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => 0.0000000000,
    rv_s66_adlperssn_count > 2.5                                    => 0.0248213003,
    rv_s66_adlperssn_count = NULL                                   => 0.0370157142,
                                                                       rc018_32_1_1);

rc012_32_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc012_32_2_c363,
    rv_s66_adlperssn_count > 2.5                                    => rc012_32_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc012_32_2_1,
                                                                       rc012_32_2_1);

final_score_32 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => final_score_32_c363,
    rv_s66_adlperssn_count > 2.5                                    => 0.0224151615,
    rv_s66_adlperssn_count = NULL                                   => 0.0346095754,
                                                                       -0.0024061387);

rc027_33_4_c369 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => 0.0161858011,
    iv_prv_addr_lres > 8.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

final_score_33_c369 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => 0.0272422489,
    iv_prv_addr_lres > 8.5                              => 0.0015712293,
    iv_prv_addr_lres = NULL                             => 0.0100148073,
                                                           0.0110564478);

rc027_33_4_c368 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0000000000,
    rv_f00_ssn_score > 95                              => rc027_33_4_c369,
    rv_f00_ssn_score = NULL                            => 0.0000000000,
                                                          NULL);

rc031_33_2_c368 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0633695506,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0265855892,
                                                          NULL);

final_score_33_c368 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0770634684,
    rv_f00_ssn_score > 95                              => final_score_33_c369,
    rv_f00_ssn_score = NULL                            => 0.0402795070,
                                                          0.0136939178);

rc024_33_10_c371 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0187665031,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_33_c371 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => -0.0224446164,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0049601759,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => -0.0138063272,
                                                                                 -0.0138063272);

final_score_33_c370 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => final_score_33_c371,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0366794411,
    rv_i62_inq_addrs_per_adl = NULL                                     => -0.0107988666,
                                                                           -0.0107988666);

rc020_33_9_c370 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => 0.0000000000,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0474783077,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

rc024_33_10_c370 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc024_33_10_c371,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0000000000,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_33 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => final_score_33_c368,
    rv_f01_inp_addr_address_score > 95                                           => final_score_33_c370,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0098213424,
                                                                                    -0.0038813339);

rc020_33_9 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc020_33_9_1,
    rv_f01_inp_addr_address_score > 95                                           => rc020_33_9_c370,
    rv_f01_inp_addr_address_score = NULL                                         => rc020_33_9_1,
                                                                                    rc020_33_9_1);

rc021_33_1 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0175752516,
    rv_f01_inp_addr_address_score > 95                                           => 0.0000000000,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0137026763,
                                                                                    rc021_33_1_1);

rc024_33_10 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc024_33_10_1,
    rv_f01_inp_addr_address_score > 95                                           => rc024_33_10_c370,
    rv_f01_inp_addr_address_score = NULL                                         => rc024_33_10_1,
                                                                                    rc024_33_10_1);

rc031_33_2 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc031_33_2_c368,
    rv_f01_inp_addr_address_score > 95                                           => rc031_33_2_1,
    rv_f01_inp_addr_address_score = NULL                                         => rc031_33_2_1,
                                                                                    rc031_33_2_1);

rc027_33_4 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc027_33_4_c368,
    rv_f01_inp_addr_address_score > 95                                           => rc027_33_4_1,
    rv_f01_inp_addr_address_score = NULL                                         => rc027_33_4_1,
                                                                                    rc027_33_4_1);

final_score_34_c376 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => 0.0281126010,
    iv_header_emergence_age > 17.5                                     => 0.0002178493,
    iv_header_emergence_age = NULL                                     => 0.0038753280,
                                                                          0.0038753280);

rc025_34_6_c376 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => 0.0242372730,
    iv_header_emergence_age > 17.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc025_34_6_c375 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc025_34_6_c376,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_34_c375 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => final_score_34_c376,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0250938075,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0104086168,
                                                                                 0.0104086168);

rc024_34_5_c375 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0146851906,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_34_c374 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0416094684,
    iv_college_tier > 3                             => final_score_34_c375,
    iv_college_tier = NULL                          => 0.0049877111,
                                                       0.0049877111);

rc024_34_5_c374 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc024_34_5_c375,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc025_34_6_c374 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc025_34_6_c375,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_34_3_c374 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0054209057,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_34_c373 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => final_score_34_c374,
    iv_input_best_phone_match > 0.5                                       => -0.0504053667,
    iv_input_best_phone_match = NULL                                      => -0.0248719354,
                                                                             -0.0000282842);

rc024_34_5_c373 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc024_34_5_c374,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc025_34_6_c373 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc025_34_6_c374,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc005_34_3_c373 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc005_34_3_c374,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc011_34_2_c373 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => 0.0050159953,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc005_34_3 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc005_34_3_c373,
    iv_br_source_count > 0.5                                => rc005_34_3_1,
    iv_br_source_count = NULL                               => rc005_34_3_1,
                                                               rc005_34_3_1);

rc011_34_2 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc011_34_2_c373,
    iv_br_source_count > 0.5                                => rc011_34_2_1,
    iv_br_source_count = NULL                               => rc011_34_2_1,
                                                               rc011_34_2_1);

final_score_34 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_34_c373,
    iv_br_source_count > 0.5                                => -0.0414781869,
    iv_br_source_count = NULL                               => 0.0016817221,
                                                               -0.0045580371);

rc024_34_5 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc024_34_5_c373,
    iv_br_source_count > 0.5                                => rc024_34_5_1,
    iv_br_source_count = NULL                               => rc024_34_5_1,
                                                               rc024_34_5_1);

rc025_34_6 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc025_34_6_c373,
    iv_br_source_count > 0.5                                => rc025_34_6_1,
    iv_br_source_count = NULL                               => rc025_34_6_1,
                                                               rc025_34_6_1);

rc016_34_1 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0045297529,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0062397592,
                                                               rc016_34_1_1);

rc030_35_6_c381 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0220968559,
    rv_f00_dob_score > 98                              => 0.0008637024,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_35_c381 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0298123158,
    rv_f00_dob_score > 98                              => 0.0085791623,
    rv_f00_dob_score = NULL                            => -0.0338533128,
                                                          0.0077154599);

rc030_35_6_c380 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc030_35_6_c381,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_35_c380 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0441658875,
    iv_college_tier > 3                             => final_score_35_c381,
    iv_college_tier = NULL                          => 0.0020508435,
                                                       0.0020508435);

rc005_35_4_c380 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0056646164,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc030_35_6_c379 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc030_35_6_c380,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_35_c379 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_35_c380,
    iv_br_source_count > 0.5                                => -0.0410260914,
    iv_br_source_count = NULL                               => -0.0025214389,
                                                               -0.0025214389);

rc016_35_3_c379 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0045722824,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc005_35_4_c379 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc005_35_4_c380,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc011_35_2_c378 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => 0.0051966455,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_35_c378 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => final_score_35_c379,
    iv_input_best_phone_match > 0.5                                       => -0.0572391914,
    iv_input_best_phone_match = NULL                                      => -0.0294036788,
                                                                             -0.0077180844);

rc016_35_3_c378 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc016_35_3_c379,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc005_35_4_c378 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc005_35_4_c379,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc030_35_6_c378 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc030_35_6_c379,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc030_35_6 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => rc030_35_6_c378,
    rv_d30_derog_count > 2.5                                => rc030_35_6_1,
    rv_d30_derog_count = NULL                               => rc030_35_6_1,
                                                               rc030_35_6_1);

final_score_35 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => final_score_35_c378,
    rv_d30_derog_count > 2.5                                => 0.0318561134,
    rv_d30_derog_count = NULL                               => -0.0013030964,
                                                               -0.0055020289);

rc016_35_3 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => rc016_35_3_c378,
    rv_d30_derog_count > 2.5                                => rc016_35_3_1,
    rv_d30_derog_count = NULL                               => rc016_35_3_1,
                                                               rc016_35_3_1);

rc005_35_4 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => rc005_35_4_c378,
    rv_d30_derog_count > 2.5                                => rc005_35_4_1,
    rv_d30_derog_count = NULL                               => rc005_35_4_1,
                                                               rc005_35_4_1);

rc001_35_1 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => 0.0000000000,
    rv_d30_derog_count > 2.5                                => 0.0373581423,
    rv_d30_derog_count = NULL                               => 0.0041989325,
                                                               rc001_35_1_1);

rc011_35_2 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => rc011_35_2_c378,
    rv_d30_derog_count > 2.5                                => rc011_35_2_1,
    rv_d30_derog_count = NULL                               => rc011_35_2_1,
                                                               rc011_35_2_1);

rc031_36_4_c384 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0754575560,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0311494870,
                                                          NULL);

final_score_36_c384 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0978059451,
    rv_f00_ssn_score > 95                              => 0.0197232375,
    rv_f00_ssn_score = NULL                            => 0.0534978761,
                                                          0.0223483891);

rc039_36_2_c383 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => 0.0000000000,
    rv_c14_addrs_10yr > 1.5                               => 0.0092426963,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

final_score_36_c383 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => -0.0056232846,
    rv_c14_addrs_10yr > 1.5                               => final_score_36_c384,
    rv_c14_addrs_10yr = NULL                              => 0.0131056929,
                                                             0.0131056929);

rc031_36_4_c383 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => 0.0000000000,
    rv_c14_addrs_10yr > 1.5                               => rc031_36_4_c384,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

rc031_36_11_c386 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0546695412,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0310219114,
                                                          NULL);

final_score_36_c386 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0443639853,
    rv_f00_ssn_score > 95                              => -0.0120503042,
    rv_f00_ssn_score = NULL                            => 0.0207163555,
                                                          -0.0103055559);

rc031_36_11_c385 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0000000000,
    iv_c13_avg_lres > 2.5                             => rc031_36_11_c386,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_36_c385 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0571452824,
    iv_c13_avg_lres > 2.5                             => final_score_36_c386,
    iv_c13_avg_lres = NULL                            => -0.0092786682,
                                                         -0.0092786682);

rc017_36_9_c385 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0664239505,
    iv_c13_avg_lres > 2.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc039_36_2 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => rc039_36_2_c383,
    iv_prv_addr_lres > 8.5                              => rc039_36_2_1,
    iv_prv_addr_lres = NULL                             => rc039_36_2_1,
                                                           rc039_36_2_1);

rc027_36_1 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => 0.0151797929,
    iv_prv_addr_lres > 8.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0023997288,
                                                           rc027_36_1_1);

rc031_36_11 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => rc031_36_11_1,
    iv_prv_addr_lres > 8.5                              => rc031_36_11_c385,
    iv_prv_addr_lres = NULL                             => rc031_36_11_1,
                                                           rc031_36_11_1);

final_score_36 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => final_score_36_c383,
    iv_prv_addr_lres > 8.5                              => final_score_36_c385,
    iv_prv_addr_lres = NULL                             => 0.0003256288,
                                                           -0.0020741001);

rc031_36_4 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => rc031_36_4_c383,
    iv_prv_addr_lres > 8.5                              => rc031_36_4_1,
    iv_prv_addr_lres = NULL                             => rc031_36_4_1,
                                                           rc031_36_4_1);

rc017_36_9 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 8.5 => rc017_36_9_1,
    iv_prv_addr_lres > 8.5                              => rc017_36_9_c385,
    iv_prv_addr_lres = NULL                             => rc017_36_9_1,
                                                           rc017_36_9_1);

rc013_37_3_c389 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0270142371,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_37_c389 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => -0.0036694573,
    rv_email_domain_free_count > 0.5                                        => 0.0348399175,
    rv_email_domain_free_count = NULL                                       => -0.0026241259,
                                                                               0.0078256804);

final_score_37_c390 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => -0.0162796437,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0274327381,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0568415410,
                                                                           -0.0147636960);

rc037_37_7_c390 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0421964341,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc037_37_7_c388 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => 0.0000000000,
    rv_comb_age > 24.5                         => rc037_37_7_c390,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_37_c388 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => final_score_37_c389,
    rv_comb_age > 24.5                         => final_score_37_c390,
    rv_comb_age = NULL                         => -0.1362442228,
                                                  -0.0089910734);

rc014_37_2_c388 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => 0.0168167538,
    rv_comb_age > 24.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc013_37_3_c388 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => rc013_37_3_c389,
    rv_comb_age > 24.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_37_c391 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 37.1 => 0.0704085934,
    rv_a49_curr_avm_chg_1yr_pct > 37.1                                         => -0.0064774350,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => 0.0140431380,
                                                                                  0.0068724679);

rc026_37_12_c391 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 37.1 => 0.0635361254,
    rv_a49_curr_avm_chg_1yr_pct > 37.1                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => 0.0071706701,
                                                                                  NULL);

rc018_37_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0088597899,
    rv_s66_adlperssn_count = NULL                                   => 0.0322526204,
                                                                       rc018_37_1_1);

rc037_37_7 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc037_37_7_c388,
    rv_s66_adlperssn_count > 1.5                                    => rc037_37_7_1,
    rv_s66_adlperssn_count = NULL                                   => rc037_37_7_1,
                                                                       rc037_37_7_1);

rc014_37_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc014_37_2_c388,
    rv_s66_adlperssn_count > 1.5                                    => rc014_37_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc014_37_2_1,
                                                                       rc014_37_2_1);

final_score_37 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_37_c388,
    rv_s66_adlperssn_count > 1.5                                    => final_score_37_c391,
    rv_s66_adlperssn_count = NULL                                   => 0.0302652984,
                                                                       -0.0019873220);

rc013_37_3 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc013_37_3_c388,
    rv_s66_adlperssn_count > 1.5                                    => rc013_37_3_1,
    rv_s66_adlperssn_count = NULL                                   => rc013_37_3_1,
                                                                       rc013_37_3_1);

rc026_37_12 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc026_37_12_1,
    rv_s66_adlperssn_count > 1.5                                    => rc026_37_12_c391,
    rv_s66_adlperssn_count = NULL                                   => rc026_37_12_1,
                                                                       rc026_37_12_1);

rc015_38_7_c396 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0130093421,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_38_c396 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0040630698,
    iv_unverified_addr_count > 1.5                                      => 0.0159001138,
    iv_unverified_addr_count = NULL                                     => 0.0028907718,
                                                                           0.0028907718);

rc016_38_6_c395 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0042995828,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc015_38_7_c395 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc015_38_7_c396,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_38_c395 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_38_c396,
    iv_br_source_count > 0.5                                => -0.0431921525,
    iv_br_source_count = NULL                               => -0.0014088110,
                                                               -0.0014088110);

rc016_38_6_c394 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.25 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 58.25                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc016_38_6_c395,
                                                                                   NULL);

rc015_38_7_c394 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.25 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 58.25                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc015_38_7_c395,
                                                                                   NULL);

rc026_38_3_c394 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.25 => 0.0235790868,
    rv_a49_curr_avm_chg_1yr_pct > 58.25                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0071678216,
                                                                                   NULL);

final_score_38_c394 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.25 => 0.0150024542,
    rv_a49_curr_avm_chg_1yr_pct > 58.25                                         => -0.0230105309,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_38_c395,
                                                                                   -0.0085766325);

rc016_38_6_c393 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 0.5 => rc016_38_6_c394,
    rv_d32_criminal_behavior_lvl > 0.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_38_c393 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 0.5 => final_score_38_c394,
    rv_d32_criminal_behavior_lvl > 0.5                                          => 0.0292976685,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0069055569,
                                                                                   -0.0069055569);

rc026_38_3_c393 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 0.5 => rc026_38_3_c394,
    rv_d32_criminal_behavior_lvl > 0.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc019_38_2_c393 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 0.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 0.5                                          => 0.0362032254,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc015_38_7_c393 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 0.5 => rc015_38_7_c394,
    rv_d32_criminal_behavior_lvl > 0.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc013_38_1 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0283556457,
    rv_email_domain_free_count = NULL                                       => 0.0021627725,
                                                                               rc013_38_1_1);

rc019_38_2 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc019_38_2_c393,
    rv_email_domain_free_count > 1.5                                        => rc019_38_2_1,
    rv_email_domain_free_count = NULL                                       => rc019_38_2_1,
                                                                               rc019_38_2_1);

final_score_38 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => final_score_38_c393,
    rv_email_domain_free_count > 1.5                                        => 0.0258048380,
    rv_email_domain_free_count = NULL                                       => -0.0003880352,
                                                                               -0.0025508077);

rc026_38_3 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc026_38_3_c393,
    rv_email_domain_free_count > 1.5                                        => rc026_38_3_1,
    rv_email_domain_free_count = NULL                                       => rc026_38_3_1,
                                                                               rc026_38_3_1);

rc015_38_7 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc015_38_7_c393,
    rv_email_domain_free_count > 1.5                                        => rc015_38_7_1,
    rv_email_domain_free_count = NULL                                       => rc015_38_7_1,
                                                                               rc015_38_7_1);

rc016_38_6 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc016_38_6_c393,
    rv_email_domain_free_count > 1.5                                        => rc016_38_6_1,
    rv_email_domain_free_count = NULL                                       => rc016_38_6_1,
                                                                               rc016_38_6_1);

final_score_39_c401 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 80 => 0.0586115559,
    rv_f00_dob_score > 80                              => -0.0043705392,
    rv_f00_dob_score = NULL                            => -0.0429130196,
                                                          -0.0059604669);

rc030_39_8_c401 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 80 => 0.0645720228,
    rv_f00_dob_score > 80                              => 0.0015899278,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc030_39_8_c400 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 7.5 => 0.0000000000,
    iv_c13_avg_lres > 7.5                             => rc030_39_8_c401,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc017_39_6_c400 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 7.5 => 0.0464567482,
    iv_c13_avg_lres > 7.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_39_c400 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 7.5 => 0.0419846214,
    iv_c13_avg_lres > 7.5                             => final_score_39_c401,
    iv_c13_avg_lres = NULL                            => -0.0044721268,
                                                         -0.0044721268);

final_score_39_c399 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0173596278,
    iv_prv_addr_lres > 7.5                              => final_score_39_c400,
    iv_prv_addr_lres = NULL                             => 0.0019326712,
                                                           0.0020292416);

rc027_39_4_c399 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0153303861,
    iv_prv_addr_lres > 7.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc030_39_8_c399 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0000000000,
    iv_prv_addr_lres > 7.5                              => rc030_39_8_c400,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc017_39_6_c399 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0000000000,
    iv_prv_addr_lres > 7.5                              => rc017_39_6_c400,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

final_score_39_c398 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => final_score_39_c399,
    iv_input_best_phone_match > -0.5                                       => -0.0245724306,
    iv_input_best_phone_match = NULL                                       => -0.0269685497,
                                                                              -0.0049495652);

rc027_39_4_c398 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc027_39_4_c399,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc030_39_8_c398 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc030_39_8_c399,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc017_39_6_c398 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc017_39_6_c399,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc011_39_3_c398 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0069788068,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc017_39_6 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 79.5 => rc017_39_6_1,
    rv_d33_eviction_recency > 79.5                                     => rc017_39_6_c398,
    rv_d33_eviction_recency = NULL                                     => rc017_39_6_1,
                                                                          rc017_39_6_1);

rc011_39_3 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 79.5 => rc011_39_3_1,
    rv_d33_eviction_recency > 79.5                                     => rc011_39_3_c398,
    rv_d33_eviction_recency = NULL                                     => rc011_39_3_1,
                                                                          rc011_39_3_1);

rc030_39_8 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 79.5 => rc030_39_8_1,
    rv_d33_eviction_recency > 79.5                                     => rc030_39_8_c398,
    rv_d33_eviction_recency = NULL                                     => rc030_39_8_1,
                                                                          rc030_39_8_1);

rc027_39_4 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 79.5 => rc027_39_4_1,
    rv_d33_eviction_recency > 79.5                                     => rc027_39_4_c398,
    rv_d33_eviction_recency = NULL                                     => rc027_39_4_1,
                                                                          rc027_39_4_1);

final_score_39 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 79.5 => 0.0287814068,
    rv_d33_eviction_recency > 79.5                                     => final_score_39_c398,
    rv_d33_eviction_recency = NULL                                     => 0.0052645446,
                                                                          -0.0029804598);

rc009_39_1 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 79.5 => 0.0317618666,
    rv_d33_eviction_recency > 79.5                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                     => 0.0082450044,
                                                                          rc009_39_1_1);

final_score_40_c406 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 92 => 0.0536749999,
    rv_f00_dob_score > 92                              => 0.0250965210,
    rv_f00_dob_score = NULL                            => -0.0211097584,
                                                          0.0229902403);

rc030_40_7_c406 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 92 => 0.0306847596,
    rv_f00_dob_score > 92                              => 0.0021062807,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_40_c405 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => final_score_40_c406,
    iv_bureau_verification_index > 13.5                                          => 0.0047308996,
    iv_bureau_verification_index = NULL                                          => 0.0161984750,
                                                                                    0.0161984750);

rc028_40_6_c405 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0067917653,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc030_40_7_c405 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => rc030_40_7_c406,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc028_40_6_c404 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc028_40_6_c405,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc015_40_4_c404 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0094969708,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc030_40_7_c404 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc030_40_7_c405,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_40_c404 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0045420733,
    iv_unverified_addr_count > 0.5                                      => final_score_40_c405,
    iv_unverified_addr_count = NULL                                     => 0.0067015042,
                                                                           0.0067015042);

rc030_40_7_c403 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 267.5 => rc030_40_7_c404,
    rv_c20_m_bureau_adl_fs > 267.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc015_40_4_c403 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 267.5 => rc015_40_4_c404,
    rv_c20_m_bureau_adl_fs > 267.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc040_40_3_c403 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 267.5 => 0.0048086278,
    rv_c20_m_bureau_adl_fs > 267.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc028_40_6_c403 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 267.5 => rc028_40_6_c404,
    rv_c20_m_bureau_adl_fs > 267.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

final_score_40_c403 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 267.5 => final_score_40_c404,
    rv_c20_m_bureau_adl_fs > 267.5                                    => -0.0184975047,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0018928764,
                                                                         0.0018928764);

rc030_40_7 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => rc030_40_7_1,
    iv_college_tier > 3                             => rc030_40_7_c403,
    iv_college_tier = NULL                          => rc030_40_7_1,
                                                       rc030_40_7_1);

rc015_40_4 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => rc015_40_4_1,
    iv_college_tier > 3                             => rc015_40_4_c403,
    iv_college_tier = NULL                          => rc015_40_4_1,
                                                       rc015_40_4_1);

rc028_40_6 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => rc028_40_6_1,
    iv_college_tier > 3                             => rc028_40_6_c403,
    iv_college_tier = NULL                          => rc028_40_6_1,
                                                       rc028_40_6_1);

rc040_40_3 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => rc040_40_3_1,
    iv_college_tier > 3                             => rc040_40_3_c403,
    iv_college_tier = NULL                          => rc040_40_3_1,
                                                       rc040_40_3_1);

final_score_40 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0449127318,
    iv_college_tier > 3                             => final_score_40_c403,
    iv_college_tier = NULL                          => 0.0024490137,
                                                       -0.0033694984);

rc005_40_1 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0052623748,
    iv_college_tier = NULL                          => 0.0058185121,
                                                       rc005_40_1_1);

final_score_41_c410 := map(
    NULL < iv_source_type AND iv_source_type <= 6.5 => -0.0017084266,
    iv_source_type > 6.5                            => -0.0242611935,
    iv_source_type = NULL                           => -0.0129888256,
                                                       -0.0129888256);

rc023_41_5_c410 := map(
    NULL < iv_source_type AND iv_source_type <= 6.5 => 0.0112803990,
    iv_source_type > 6.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_41_c409 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => 0.0323122166,
    rv_d33_eviction_recency > 36.5                                     => final_score_41_c410,
    rv_d33_eviction_recency = NULL                                     => -0.0116571558,
                                                                          -0.0116571558);

rc009_41_3_c409 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => 0.0439693723,
    rv_d33_eviction_recency > 36.5                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                     => 0.0000000000,
                                                                          NULL);

rc023_41_5_c409 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => 0.0000000000,
    rv_d33_eviction_recency > 36.5                                     => rc023_41_5_c410,
    rv_d33_eviction_recency = NULL                                     => 0.0000000000,
                                                                          NULL);

rc023_41_5_c408 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc023_41_5_c409,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc012_41_2_c408 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0550169628,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc009_41_3_c408 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc009_41_3_c409,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

final_score_41_c408 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_41_c409,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0444142645,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0185374764,
                                                                                     -0.0106026983);

rc010_41_12_c411 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => 0.0161766072,
    iv_num_non_bureau_sources > 1.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_41_c411 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 1.5 => 0.0230614973,
    iv_num_non_bureau_sources > 1.5                                       => -0.0011001924,
    iv_num_non_bureau_sources = NULL                                      => -0.0025248259,
                                                                             0.0068848900);

rc010_41_12 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc010_41_12_1,
    rv_s66_adlperssn_count > 1.5                                    => rc010_41_12_c411,
    rv_s66_adlperssn_count = NULL                                   => rc010_41_12_1,
                                                                       rc010_41_12_1);

rc009_41_3 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc009_41_3_c408,
    rv_s66_adlperssn_count > 1.5                                    => rc009_41_3_1,
    rv_s66_adlperssn_count = NULL                                   => rc009_41_3_1,
                                                                       rc009_41_3_1);

final_score_41 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_41_c408,
    rv_s66_adlperssn_count > 1.5                                    => final_score_41_c411,
    rv_s66_adlperssn_count = NULL                                   => 0.0233324278,
                                                                       -0.0031522468);

rc012_41_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc012_41_2_c408,
    rv_s66_adlperssn_count > 1.5                                    => rc012_41_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc012_41_2_1,
                                                                       rc012_41_2_1);

rc023_41_5 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc023_41_5_c408,
    rv_s66_adlperssn_count > 1.5                                    => rc023_41_5_1,
    rv_s66_adlperssn_count = NULL                                   => rc023_41_5_1,
                                                                       rc023_41_5_1);

rc018_41_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0100371369,
    rv_s66_adlperssn_count = NULL                                   => 0.0264846746,
                                                                       rc018_41_1_1);

final_score_42_c414 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => 0.0083346796,
    rv_d30_derog_count > 2.5                                => 0.0438812203,
    rv_d30_derog_count = NULL                               => 0.0104595662,
                                                               0.0104595662);

rc001_42_3_c414 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 2.5 => 0.0000000000,
    rv_d30_derog_count > 2.5                                => 0.0334216541,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc018_42_9_c416 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => 0.0000000000,
    rv_s66_adlperssn_count > 2.5                                    => 0.0211257635,
    rv_s66_adlperssn_count = NULL                                   => 0.0182198406,
                                                                       NULL);

final_score_42_c416 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => -0.0136111726,
    rv_s66_adlperssn_count > 2.5                                    => 0.0107487117,
    rv_s66_adlperssn_count = NULL                                   => 0.0078427888,
                                                                       -0.0103770519);

rc018_42_9_c415 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0000000000,
    iv_c13_avg_lres > 3.5                             => rc018_42_9_c416,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc017_42_7_c415 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0547359946,
    iv_c13_avg_lres > 3.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_42_c415 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0453059451,
    iv_c13_avg_lres > 3.5                             => final_score_42_c416,
    iv_c13_avg_lres = NULL                            => -0.0094300496,
                                                         -0.0094300496);

final_score_42_c413 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => final_score_42_c414,
    iv_prv_addr_lres > 7.5                              => final_score_42_c415,
    iv_prv_addr_lres = NULL                             => -0.0005164138,
                                                           -0.0032763208);

rc001_42_3_c413 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => rc001_42_3_c414,
    iv_prv_addr_lres > 7.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc017_42_7_c413 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0000000000,
    iv_prv_addr_lres > 7.5                              => rc017_42_7_c415,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc018_42_9_c413 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0000000000,
    iv_prv_addr_lres > 7.5                              => rc018_42_9_c415,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc027_42_2_c413 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0137358870,
    iv_prv_addr_lres > 7.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0027599070,
                                                           NULL);

rc027_42_2 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc027_42_2_c413,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc027_42_2_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc027_42_2_1,
                                                                                     rc027_42_2_1);

rc018_42_9 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc018_42_9_c413,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc018_42_9_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc018_42_9_1,
                                                                                     rc018_42_9_1);

rc017_42_7 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc017_42_7_c413,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc017_42_7_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc017_42_7_1,
                                                                                     rc017_42_7_1);

final_score_42 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_42_c413,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0412482037,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0010829918,
                                                                                     -0.0022085910);

rc001_42_3 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc001_42_3_c413,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc001_42_3_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc001_42_3_1,
                                                                                     rc001_42_3_1);

rc012_42_1 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0434567947,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0032915828,
                                                                                     rc012_42_1_1);

rc013_43_6_c420 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0207099914,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_43_c420 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => -0.0151443617,
    rv_email_domain_free_count > 1.5                                        => 0.0087958262,
    rv_email_domain_free_count = NULL                                       => -0.0119141652,
                                                                               -0.0119141652);

rc022_43_4_c419 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 70.5 => 0.0333427314,
    rv_d32_mos_since_crim_ls > 70.5                                      => 0.0000000000,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0086518574,
                                                                            NULL);

final_score_43_c419 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 70.5 => 0.0229295654,
    rv_d32_mos_since_crim_ls > 70.5                                      => final_score_43_c420,
    rv_d32_mos_since_crim_ls = NULL                                      => -0.0017613085,
                                                                            -0.0104131659);

rc013_43_6_c419 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 70.5 => 0.0000000000,
    rv_d32_mos_since_crim_ls > 70.5                                      => rc013_43_6_c420,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

rc013_43_6_c418 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0000000000,
    rv_comb_age > 21.5                         => rc013_43_6_c419,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_43_c418 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0135161683,
    rv_comb_age > 21.5                         => final_score_43_c419,
    rv_comb_age = NULL                         => -0.0964460277,
                                                  -0.0081488394);

rc014_43_2_c418 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0216650077,
    rv_comb_age > 21.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc022_43_4_c418 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0000000000,
    rv_comb_age > 21.5                         => rc022_43_4_c419,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_43_c421 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0796806615,
    rv_f00_ssn_score > 95                              => 0.0106317816,
    rv_f00_ssn_score = NULL                            => 0.0149245246,
                                                          0.0122396965);

rc031_43_12_c421 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0674409649,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0026848281,
                                                          NULL);

rc013_43_6 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc013_43_6_c418,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => rc013_43_6_1,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => rc013_43_6_1,
                                                                                 rc013_43_6_1);

final_score_43 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => final_score_43_c418,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => final_score_43_c421,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => -0.0020932179,
                                                                                 -0.0020932179);

rc014_43_2 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc014_43_2_c418,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => rc014_43_2_1,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => rc014_43_2_1,
                                                                                 rc014_43_2_1);

rc031_43_12 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc031_43_12_1,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => rc031_43_12_c421,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => rc031_43_12_1,
                                                                                 rc031_43_12_1);

rc022_43_4 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc022_43_4_c418,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => rc022_43_4_1,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => rc022_43_4_1,
                                                                                 rc022_43_4_1);

rc024_43_1 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0143329144,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 rc024_43_1_1);

final_score_44_c425 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => 0.0204226380,
    iv_num_non_bureau_sources > 3.5                                       => -0.0093833205,
    iv_num_non_bureau_sources = NULL                                      => 0.0140169296,
                                                                             0.0140169296);

rc010_44_5_c425 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => 0.0064057084,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc015_44_3_c424 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0084008677,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc010_44_5_c424 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc010_44_5_c425,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_44_c424 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0053164675,
    iv_unverified_addr_count > 0.5                                      => final_score_44_c425,
    iv_unverified_addr_count = NULL                                     => 0.0056160619,
                                                                           0.0056160619);

final_score_44_c426 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0501165055,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0088864032,
    iv_bureau_emergence_age_buronly = NULL                                             => -0.0175501614,
                                                                                          -0.0144286997);

rc033_44_10_c426 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0645452052,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0233151029,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0000000000,
                                                                                          NULL);

rc008_44_2_c423 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0096533350,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc010_44_5_c423 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc010_44_5_c424,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc033_44_10_c423 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => rc033_44_10_c426,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

final_score_44_c423 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => final_score_44_c424,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => final_score_44_c426,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => -0.0040372731,
                                                                                           -0.0040372731);

rc015_44_3_c423 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc015_44_3_c424,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc012_44_1 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0452803714,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0036512711,
                                                                                     rc012_44_1_1);

rc015_44_3 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc015_44_3_c423,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc015_44_3_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc015_44_3_1,
                                                                                     rc015_44_3_1);

final_score_44 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_44_c423,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0423618163,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0007327160,
                                                                                     -0.0029185551);

rc010_44_5 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc010_44_5_c423,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc010_44_5_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc010_44_5_1,
                                                                                     rc010_44_5_1);

rc033_44_10 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc033_44_10_c423,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc033_44_10_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc033_44_10_1,
                                                                                     rc033_44_10_1);

rc008_44_2 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc008_44_2_c423,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc008_44_2_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc008_44_2_1,
                                                                                     rc008_44_2_1);

rc013_45_2_c428 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0326042458,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_45_c428 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0038090682,
    rv_email_domain_free_count > 0.5                                        => 0.0474250442,
    rv_email_domain_free_count = NULL                                       => -0.0029279305,
                                                                               0.0148207983);

rc037_45_9_c431 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0437223881,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_45_c431 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => -0.0141555747,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0310904984,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0126318897,
                                                                           -0.0126318897);

rc037_45_9_c430 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0000000000,
    rv_f01_inp_addr_address_score > 95                                           => rc037_45_9_c431,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0000000000,
                                                                                    NULL);

final_score_45_c430 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0068139819,
    rv_f01_inp_addr_address_score > 95                                           => final_score_45_c431,
    rv_f01_inp_addr_address_score = NULL                                         => -0.0076062003,
                                                                                    -0.0076062003);

rc021_45_7_c430 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0144201822,
    rv_f01_inp_addr_address_score > 95                                           => 0.0000000000,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0000000000,
                                                                                    NULL);

rc021_45_7_c429 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 3.5 => rc021_45_7_c430,
    rv_d32_criminal_behavior_lvl > 3.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc019_45_6_c429 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 3.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 3.5                                          => 0.0463102942,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0072654740,
                                                                                   NULL);

final_score_45_c429 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 3.5 => final_score_45_c430,
    rv_d32_criminal_behavior_lvl > 3.5                                          => 0.0397820901,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0007372700,
                                                                                   -0.0065282040);

rc037_45_9_c429 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 3.5 => rc037_45_9_c430,
    rv_d32_criminal_behavior_lvl > 3.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc021_45_7 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc021_45_7_1,
    rv_comb_age > 22.5                         => rc021_45_7_c429,
    rv_comb_age = NULL                         => rc021_45_7_1,
                                                  rc021_45_7_1);

rc013_45_2 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc013_45_2_c428,
    rv_comb_age > 22.5                         => rc013_45_2_1,
    rv_comb_age = NULL                         => rc013_45_2_1,
                                                  rc013_45_2_1);

rc019_45_6 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc019_45_6_1,
    rv_comb_age > 22.5                         => rc019_45_6_c429,
    rv_comb_age = NULL                         => rc019_45_6_1,
                                                  rc019_45_6_1);

rc014_45_1 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0182319556,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  rc014_45_1_1);

final_score_45 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => final_score_45_c428,
    rv_comb_age > 22.5                         => final_score_45_c429,
    rv_comb_age = NULL                         => -0.0944778242,
                                                  -0.0034111573);

rc037_45_9 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc037_45_9_1,
    rv_comb_age > 22.5                         => rc037_45_9_c429,
    rv_comb_age = NULL                         => rc037_45_9_1,
                                                  rc037_45_9_1);

final_score_46_c433 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0235296408,
    iv_header_emergence_age > 15.5                                     => -0.0080452923,
    iv_header_emergence_age = NULL                                     => -0.0221431023,
                                                                          -0.0063795209);

rc025_46_2_c433 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0299091617,
    iv_header_emergence_age > 15.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc026_46_8_c436 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => 0.0346089906,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0035726303,
                                                                                   NULL);

final_score_46_c436 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => 0.0499217531,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => 0.0034138607,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0188853928,
                                                                                   0.0153127625);

rc010_46_7_c435 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => 0.0049694171,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_46_c435 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => final_score_46_c436,
    iv_num_non_bureau_sources > 3.5                                       => -0.0115508253,
    iv_num_non_bureau_sources = NULL                                      => 0.0103433454,
                                                                             0.0103433454);

rc026_46_8_c435 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => rc026_46_8_c436,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc016_46_6_c434 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0050295003,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc010_46_7_c434 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc010_46_7_c435,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_46_c434 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_46_c435,
    iv_br_source_count > 0.5                                => -0.0294977553,
    iv_br_source_count = NULL                               => -0.0138532349,
                                                               0.0053138451);

rc026_46_8_c434 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc026_46_8_c435,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc026_46_8 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc026_46_8_1,
    rv_s66_adlperssn_count > 1.5                                    => rc026_46_8_c434,
    rv_s66_adlperssn_count = NULL                                   => rc026_46_8_1,
                                                                       rc026_46_8_1);

rc025_46_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc025_46_2_c433,
    rv_s66_adlperssn_count > 1.5                                    => rc025_46_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc025_46_2_1,
                                                                       rc025_46_2_1);

rc010_46_7 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc010_46_7_1,
    rv_s66_adlperssn_count > 1.5                                    => rc010_46_7_c434,
    rv_s66_adlperssn_count = NULL                                   => rc010_46_7_1,
                                                                       rc010_46_7_1);

final_score_46 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_46_c433,
    rv_s66_adlperssn_count > 1.5                                    => final_score_46_c434,
    rv_s66_adlperssn_count = NULL                                   => 0.0220898819,
                                                                       -0.0012250087);

rc016_46_6 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc016_46_6_1,
    rv_s66_adlperssn_count > 1.5                                    => rc016_46_6_c434,
    rv_s66_adlperssn_count = NULL                                   => rc016_46_6_1,
                                                                       rc016_46_6_1);

rc018_46_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0065388538,
    rv_s66_adlperssn_count = NULL                                   => 0.0233148906,
                                                                       rc018_46_1_1);

rc015_47_6_c441 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0096745309,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_47_c441 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0101563131,
    iv_unverified_addr_count > 1.5                                      => 0.0310131716,
    iv_unverified_addr_count = NULL                                     => 0.0213386407,
                                                                           0.0213386407);

rc015_47_6_c440 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => rc015_47_6_c441,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc028_47_5_c440 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0074441764,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

final_score_47_c440 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => final_score_47_c441,
    iv_bureau_verification_index > 13.5                                          => 0.0006215654,
    iv_bureau_verification_index = NULL                                          => 0.0138944643,
                                                                                    0.0138944643);

rc015_47_3_c439 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0080772825,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_47_c439 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0049222865,
    iv_unverified_addr_count > 0.5                                      => final_score_47_c440,
    iv_unverified_addr_count = NULL                                     => 0.0058171818,
                                                                           0.0058171818);

rc015_47_6_c439 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc015_47_6_c440,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc028_47_5_c439 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc028_47_5_c440,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc015_47_6_c438 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc015_47_6_c439,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc028_47_5_c438 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc028_47_5_c439,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc015_47_3_c438 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc015_47_3_c439,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc008_47_2_c438 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0079104929,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

final_score_47_c438 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => final_score_47_c439,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => -0.0106862059,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => -0.0032346624,
                                                                                           -0.0020933111);

rc038_47_1 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => 0.0475910758,
    rv_p85_phn_risk_level = ''                                => 0.0000000000,
                                                                    rc038_47_1_1);

rc015_47_3 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc015_47_3_c438,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc015_47_3_1,
    rv_p85_phn_risk_level = ''                                 => rc015_47_3_1,
                                                                    rc015_47_3_1);

rc008_47_2 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc008_47_2_c438,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc008_47_2_1,
    rv_p85_phn_risk_level = ''                                => rc008_47_2_1,
                                                                    rc008_47_2_1);

final_score_47 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => final_score_47_c438,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => 0.0455729525,
    rv_p85_phn_risk_level = ''                                 => -0.0209562224,
                                                                    -0.0020181233);

rc028_47_5 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc028_47_5_c438,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc028_47_5_1,
    rv_p85_phn_risk_level = ''                                 => rc028_47_5_1,
                                                                    rc028_47_5_1);

rc015_47_6 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc015_47_6_c438,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc015_47_6_1,
    rv_p85_phn_risk_level = ''                                 => rc015_47_6_1,
                                                                    rc015_47_6_1);

rc025_48_5_c445 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 13.5 => 0.0400438209,
    iv_header_emergence_age > 13.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

final_score_48_c445 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 13.5 => 0.0381059001,
    iv_header_emergence_age > 13.5                                     => -0.0035291160,
    iv_header_emergence_age = NULL                                     => -0.0019379209,
                                                                          -0.0019379209);

rc014_48_9_c446 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0230343504,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_48_c446 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0375168169,
    rv_comb_age > 22.5                         => 0.0094890790,
    rv_comb_age = NULL                         => 0.0144824665,
                                                  0.0144824665);

rc013_48_4_c444 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0110506005,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc014_48_9_c444 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => rc014_48_9_c446,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_48_c444 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => final_score_48_c445,
    rv_email_domain_free_count > 0.5                                        => final_score_48_c446,
    rv_email_domain_free_count = NULL                                       => 0.0034318660,
                                                                               0.0034318660);

rc025_48_5_c444 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => rc025_48_5_c445,
    rv_email_domain_free_count > 0.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_48_c443 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => final_score_48_c444,
    iv_num_non_bureau_sources > 2.5                                       => -0.0143017709,
    iv_num_non_bureau_sources = NULL                                      => -0.0034295316,
                                                                             -0.0034295316);

rc025_48_5_c443 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => rc025_48_5_c444,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc014_48_9_c443 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => rc014_48_9_c444,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc013_48_4_c443 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => rc013_48_4_c444,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_48_3_c443 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0068613976,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc025_48_5 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc025_48_5_1,
    rv_f00_ssn_score > 95                              => rc025_48_5_c443,
    rv_f00_ssn_score = NULL                            => rc025_48_5_1,
                                                          rc025_48_5_1);

final_score_48 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0440435387,
    rv_f00_ssn_score > 95                              => final_score_48_c443,
    rv_f00_ssn_score = NULL                            => 0.0097562652,
                                                          -0.0019702791);

rc014_48_9 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc014_48_9_1,
    rv_f00_ssn_score > 95                              => rc014_48_9_c443,
    rv_f00_ssn_score = NULL                            => rc014_48_9_1,
                                                          rc014_48_9_1);

rc031_48_1 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0460138178,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0117265442,
                                                          rc031_48_1_1);

rc010_48_3 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc010_48_3_1,
    rv_f00_ssn_score > 95                              => rc010_48_3_c443,
    rv_f00_ssn_score = NULL                            => rc010_48_3_1,
                                                          rc010_48_3_1);

rc013_48_4 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc013_48_4_1,
    rv_f00_ssn_score > 95                              => rc013_48_4_c443,
    rv_f00_ssn_score = NULL                            => rc013_48_4_1,
                                                          rc013_48_4_1);

final_score_49_c451 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => -0.0014471398,
    iv_input_best_phone_match > -0.5                                       => -0.0313420657,
    iv_input_best_phone_match = NULL                                       => -0.0278083772,
                                                                              -0.0094392683);

rc011_49_6_c451 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0079921285,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_49_c450 := map(
    NULL < rv_i62_inq_phonesperadl_recency AND rv_i62_inq_phonesperadl_recency <= 55.5 => 0.0333341124,
    rv_i62_inq_phonesperadl_recency > 55.5                                             => final_score_49_c451,
    rv_i62_inq_phonesperadl_recency = NULL                                             => -0.0073746381,
                                                                                          -0.0073746381);

rc049_49_4_c450 := map(
    NULL < rv_i62_inq_phonesperadl_recency AND rv_i62_inq_phonesperadl_recency <= 55.5 => 0.0407087505,
    rv_i62_inq_phonesperadl_recency > 55.5                                             => 0.0000000000,
    rv_i62_inq_phonesperadl_recency = NULL                                             => 0.0000000000,
                                                                                          NULL);

rc011_49_6_c450 := map(
    NULL < rv_i62_inq_phonesperadl_recency AND rv_i62_inq_phonesperadl_recency <= 55.5 => 0.0000000000,
    rv_i62_inq_phonesperadl_recency > 55.5                                             => rc011_49_6_c451,
    rv_i62_inq_phonesperadl_recency = NULL                                             => 0.0000000000,
                                                                                          NULL);

rc049_49_4_c449 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc049_49_4_c450,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc011_49_6_c449 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc011_49_6_c450,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_49_3_c449 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0172614307,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_49_c449 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_49_c450,
    rv_d30_derog_count > 0.5                                => 0.0137814533,
    rv_d30_derog_count = NULL                               => -0.0034799774,
                                                               -0.0034799774);

final_score_49_c448 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => final_score_49_c449,
    rv_d31_bk_filing_count > 0.5                                    => -0.0500815831,
    rv_d31_bk_filing_count = NULL                                   => -0.0045280517,
                                                                       -0.0045280517);

rc001_49_3_c448 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc001_49_3_c449,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc034_49_2_c448 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0010480744,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc049_49_4_c448 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc049_49_4_c449,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc011_49_6_c448 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc011_49_6_c449,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc035_49_1 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.1190340730,
    rv_d31_mostrec_bk = ''                                        => 0.0051092037,
                                                                        rc035_49_1_1);

rc011_49_6 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc011_49_6_c448,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc011_49_6_1,
    rv_d31_mostrec_bk = ''                                        => rc011_49_6_1,
                                                                        rc011_49_6_1);

rc049_49_4 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc049_49_4_c448,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc049_49_4_1,
    rv_d31_mostrec_bk = ''                                         => rc049_49_4_1,
                                                                        rc049_49_4_1);

rc034_49_2 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc034_49_2_c448,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc034_49_2_1,
    rv_d31_mostrec_bk = ''                                         => rc034_49_2_1,
                                                                        rc034_49_2_1);

final_score_49 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_49_c448,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.1150415942,
    rv_d31_mostrec_bk = ''                                        => 0.0011167249,
                                                                        -0.0039924788);

rc001_49_3 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc001_49_3_c448,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc001_49_3_1,
    rv_d31_mostrec_bk = ''                                         => rc001_49_3_1,
                                                                        rc001_49_3_1);

rc015_50_6_c456 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0161238851,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_50_c456 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0017203903,
    iv_unverified_addr_count > 1.5                                      => 0.0205204102,
    iv_unverified_addr_count = NULL                                     => 0.0043965251,
                                                                           0.0043965251);

rc015_50_6_c455 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => rc015_50_6_c456,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc028_50_5_c455 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0078799345,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

final_score_50_c455 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => final_score_50_c456,
    iv_bureau_verification_index > 13.5                                          => -0.0159415369,
    iv_bureau_verification_index = NULL                                          => -0.0034834093,
                                                                                    -0.0034834093);

final_score_50_c454 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 80 => 0.0351716566,
    rv_f00_dob_score > 80                              => final_score_50_c455,
    rv_f00_dob_score = NULL                            => -0.0400142943,
                                                          -0.0050633415);

rc028_50_5_c454 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 80 => 0.0000000000,
    rv_f00_dob_score > 80                              => rc028_50_5_c455,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc015_50_6_c454 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 80 => 0.0000000000,
    rv_f00_dob_score > 80                              => rc015_50_6_c455,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc030_50_3_c454 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 80 => 0.0402349981,
    rv_f00_dob_score > 80                              => 0.0015799322,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_50_c453 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => final_score_50_c454,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0148129396,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0009080353,
                                                                                 0.0009080353);

rc028_50_5_c453 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc028_50_5_c454,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc015_50_6_c453 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc015_50_6_c454,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc024_50_2_c453 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0139049044,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc030_50_3_c453 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc030_50_3_c454,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_50 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => final_score_50_c453,
    iv_college_code > 3                             => -0.0450893674,
    iv_college_code = NULL                          => 0.0005877757,
                                                       -0.0030654715);

rc028_50_5 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc028_50_5_c453,
    iv_college_code > 3                             => rc028_50_5_1,
    iv_college_code = NULL                          => rc028_50_5_1,
                                                       rc028_50_5_1);

rc024_50_2 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc024_50_2_c453,
    iv_college_code > 3                             => rc024_50_2_1,
    iv_college_code = NULL                          => rc024_50_2_1,
                                                       rc024_50_2_1);

rc015_50_6 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc015_50_6_c453,
    iv_college_code > 3                             => rc015_50_6_1,
    iv_college_code = NULL                          => rc015_50_6_1,
                                                       rc015_50_6_1);

rc030_50_3 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc030_50_3_c453,
    iv_college_code > 3                             => rc030_50_3_1,
    iv_college_code = NULL                          => rc030_50_3_1,
                                                       rc030_50_3_1);

rc029_50_1 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => 0.0039735068,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0036532472,
                                                       rc029_50_1_1);

final_score_51_c460 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => -0.0029033319,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0121669316,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0016731385,
                                                                                 0.0016731385);

rc024_51_5_c460 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0104937930,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_51_c459 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0422289702,
    iv_college_tier > 3                             => final_score_51_c460,
    iv_college_tier = NULL                          => -0.0032124945,
                                                       -0.0032124945);

rc024_51_5_c459 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc024_51_5_c460,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_51_3_c459 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0048856331,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_51_3_c458 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc005_51_3_c459,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_51_c458 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => final_score_51_c459,
    iv_input_best_phone_match > 0.5                                       => -0.0536527574,
    iv_input_best_phone_match = NULL                                      => -0.0175207775,
                                                                             -0.0075477827);

rc011_51_2_c458 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => 0.0043352882,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc024_51_5_c458 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc024_51_5_c459,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc014_51_12_c461 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0378772772,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_51_c461 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0556599554,
    rv_comb_age > 22.5                         => 0.0143678290,
    rv_comb_age = NULL                         => 0.0177826782,
                                                  0.0177826782);

final_score_51 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => final_score_51_c458,
    rv_email_domain_free_count > 1.5                                        => final_score_51_c461,
    rv_email_domain_free_count = NULL                                       => -0.0025625833,
                                                                               -0.0041919854);

rc011_51_2 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc011_51_2_c458,
    rv_email_domain_free_count > 1.5                                        => rc011_51_2_1,
    rv_email_domain_free_count = NULL                                       => rc011_51_2_1,
                                                                               rc011_51_2_1);

rc024_51_5 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc024_51_5_c458,
    rv_email_domain_free_count > 1.5                                        => rc024_51_5_1,
    rv_email_domain_free_count = NULL                                       => rc024_51_5_1,
                                                                               rc024_51_5_1);

rc013_51_1 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0219746636,
    rv_email_domain_free_count = NULL                                       => 0.0016294021,
                                                                               rc013_51_1_1);

rc014_51_12 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc014_51_12_1,
    rv_email_domain_free_count > 1.5                                        => rc014_51_12_c461,
    rv_email_domain_free_count = NULL                                       => rc014_51_12_1,
                                                                               rc014_51_12_1);

rc005_51_3 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc005_51_3_c458,
    rv_email_domain_free_count > 1.5                                        => rc005_51_3_1,
    rv_email_domain_free_count = NULL                                       => rc005_51_3_1,
                                                                               rc005_51_3_1);

rc008_52_3_c464 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0136751188,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

final_score_52_c464 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0185335842,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => -0.0091111352,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0048584654,
                                                                                           0.0048584654);

rc008_52_3_c463 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => rc008_52_3_c464,
    iv_prv_addr_lres > 7.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

final_score_52_c463 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => final_score_52_c464,
    iv_prv_addr_lres > 7.5                              => -0.0121850199,
    iv_prv_addr_lres = NULL                             => -0.0067099506,
                                                           -0.0074590015);

rc027_52_2_c463 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 7.5 => 0.0123174669,
    iv_prv_addr_lres > 7.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0007490509,
                                                           NULL);

final_score_52_c466 := map(
    NULL < rv_comb_age AND rv_comb_age <= 23.5 => 0.0394117596,
    rv_comb_age > 23.5                         => 0.0142543538,
    rv_comb_age = NULL                         => 0.0186176459,
                                                  0.0186176459);

rc014_52_11_c466 := map(
    NULL < rv_comb_age AND rv_comb_age <= 23.5 => 0.0207941137,
    rv_comb_age > 23.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_52_c465 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0020566761,
    rv_email_domain_free_count > 0.5                                        => final_score_52_c466,
    rv_email_domain_free_count = NULL                                       => 0.0280712447,
                                                                               0.0084714176);

rc013_52_9_c465 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0101462283,
    rv_email_domain_free_count = NULL                                       => 0.0195998271,
                                                                               NULL);

rc014_52_11_c465 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => rc014_52_11_c466,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc008_52_3 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc008_52_3_c463,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc008_52_3_1,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc008_52_3_1,
                                                                         rc008_52_3_1);

rc013_52_9 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc013_52_9_1,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc013_52_9_c465,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc013_52_9_1,
                                                                         rc013_52_9_1);

final_score_52 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => final_score_52_c463,
    rv_l79_adls_per_addr_c6 > 0.5                                     => final_score_52_c465,
    rv_l79_adls_per_addr_c6 = NULL                                    => -0.0011176906,
                                                                         -0.0011176906);

rc036_52_1 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_addr_c6 > 0.5                                     => 0.0095891082,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         rc036_52_1_1);

rc014_52_11 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc014_52_11_1,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc014_52_11_c465,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc014_52_11_1,
                                                                         rc014_52_11_1);

rc027_52_2 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc027_52_2_c463,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc027_52_2_1,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc027_52_2_1,
                                                                         rc027_52_2_1);

final_score_53_c470 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0411957458,
    iv_c13_avg_lres > 3.5                             => -0.0087419991,
    iv_c13_avg_lres = NULL                            => -0.0077941262,
                                                         -0.0077941262);

rc017_53_6_c470 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0489898720,
    iv_c13_avg_lres > 3.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc017_53_6_c469 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0000000000,
    rv_comb_age > 22.5                         => rc017_53_6_c470,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc014_53_4_c469 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0208333536,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_53_c469 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0156907313,
    rv_comb_age > 22.5                         => final_score_53_c470,
    rv_comb_age = NULL                         => -0.0051426223,
                                                  -0.0051426223);

final_score_53_c468 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0066926290,
    rv_f00_input_dob_match_level > 7.5                                          => final_score_53_c469,
    rv_f00_input_dob_match_level = NULL                                         => -0.0293393824,
                                                                                   -0.0041028723);

rc014_53_4_c468 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 7.5                                          => rc014_53_4_c469,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc032_53_2_c468 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0107955013,
    rv_f00_input_dob_match_level > 7.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc017_53_6_c468 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 7.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 7.5                                          => rc017_53_6_c469,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc025_53_13_c471 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 21.5 => 0.0289901358,
    iv_header_emergence_age > 21.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0145352698,
                                                                          NULL);

final_score_53_c471 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 21.5 => 0.0430801470,
    iv_header_emergence_age > 21.5                                     => -0.0150292134,
    iv_header_emergence_age = NULL                                     => 0.0286252811,
                                                                          0.0140900113);

rc025_53_13 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc025_53_13_1,
    rv_s66_adlperssn_count > 2.5                                    => rc025_53_13_1,
    rv_s66_adlperssn_count = NULL                                   => rc025_53_13_c471,
                                                                       rc025_53_13_1);

rc017_53_6 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc017_53_6_c468,
    rv_s66_adlperssn_count > 2.5                                    => rc017_53_6_1,
    rv_s66_adlperssn_count = NULL                                   => rc017_53_6_1,
                                                                       rc017_53_6_1);

rc014_53_4 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc014_53_4_c468,
    rv_s66_adlperssn_count > 2.5                                    => rc014_53_4_1,
    rv_s66_adlperssn_count = NULL                                   => rc014_53_4_1,
                                                                       rc014_53_4_1);

final_score_53 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => final_score_53_c468,
    rv_s66_adlperssn_count > 2.5                                    => 0.0196181384,
    rv_s66_adlperssn_count = NULL                                   => final_score_53_c471,
                                                                       -0.0010266582);

rc032_53_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc032_53_2_c468,
    rv_s66_adlperssn_count > 2.5                                    => rc032_53_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc032_53_2_1,
                                                                       rc032_53_2_1);

rc018_53_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => 0.0000000000,
    rv_s66_adlperssn_count > 2.5                                    => 0.0206447966,
    rv_s66_adlperssn_count = NULL                                   => 0.0151166694,
                                                                       rc018_53_1_1);

rc032_54_7_c476 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0071106087,
    rv_f00_input_dob_match_level > 6.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_54_c476 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0109273545,
    rv_f00_input_dob_match_level > 6.5                                          => 0.0031397208,
    rv_f00_input_dob_match_level = NULL                                         => -0.0232718822,
                                                                                   0.0038167458);

rc045_54_6_c475 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0000000000,
    rv_c19_add_prison_hist > 0.5                                    => 0.0981313426,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_54_c475 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => final_score_54_c476,
    rv_c19_add_prison_hist > 0.5                                    => 0.1022423411,
    rv_c19_add_prison_hist = NULL                                   => 0.0041109985,
                                                                       0.0041109985);

rc032_54_7_c475 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc032_54_7_c476,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc032_54_7_c474 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 46.65 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 46.65                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc032_54_7_c475,
                                                                                   NULL);

final_score_54_c474 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 46.65 => 0.0383533175,
    rv_a49_curr_avm_chg_1yr_pct > 46.65                                         => -0.0062738233,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_54_c475,
                                                                                   0.0010552086);

rc026_54_3_c474 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 46.65 => 0.0372981089,
    rv_a49_curr_avm_chg_1yr_pct > 46.65                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0030557899,
                                                                                   NULL);

rc045_54_6_c474 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 46.65 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 46.65                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc045_54_6_c475,
                                                                                   NULL);

final_score_54_c473 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE'])                         => final_score_54_c474,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK', 'NOT ISSUED']) => 0.0451514135,
    rv_p85_phn_risk_level = ''                                           => -0.0153002955,
                                                                              0.0011535077);

rc026_54_3_c473 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE'])                         => rc026_54_3_c474,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK', 'NOT ISSUED']) => 0.0000000000,
    rv_p85_phn_risk_level = ''                                           => 0.0000000000,
                                                                              NULL);

rc045_54_6_c473 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE'])                         => rc045_54_6_c474,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK', 'NOT ISSUED']) => 0.0000000000,
    rv_p85_phn_risk_level = ''                                           => 0.0000000000,
                                                                              NULL);

rc038_54_2_c473 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE'])                         => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK', 'NOT ISSUED']) => 0.0439979058,
    rv_p85_phn_risk_level = ''                                           => 0.0000000000,
                                                                              NULL);

rc032_54_7_c473 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE'])                         => rc032_54_7_c474,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK', 'NOT ISSUED']) => 0.0000000000,
    rv_p85_phn_risk_level = ''                                           => 0.0000000000,
                                                                              NULL);

rc016_54_1 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0034967207,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0015499206,
                                                               rc016_54_1_1);

rc038_54_2 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc038_54_2_c473,
    iv_br_source_count > 0.5                                => rc038_54_2_1,
    iv_br_source_count = NULL                               => rc038_54_2_1,
                                                               rc038_54_2_1);

rc032_54_7 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc032_54_7_c473,
    iv_br_source_count > 0.5                                => rc032_54_7_1,
    iv_br_source_count = NULL                               => rc032_54_7_1,
                                                               rc032_54_7_1);

rc045_54_6 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc045_54_6_c473,
    iv_br_source_count > 0.5                                => rc045_54_6_1,
    iv_br_source_count = NULL                               => rc045_54_6_1,
                                                               rc045_54_6_1);

final_score_54 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_54_c473,
    iv_br_source_count > 0.5                                => -0.0309591348,
    iv_br_source_count = NULL                               => -0.0007932924,
                                                               -0.0023432129);

rc026_54_3 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc026_54_3_c473,
    iv_br_source_count > 0.5                                => rc026_54_3_1,
    iv_br_source_count = NULL                               => rc026_54_3_1,
                                                               rc026_54_3_1);

rc015_55_7_c481 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0103083356,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_55_c481 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0006898993,
    iv_unverified_addr_count > 1.5                                      => 0.0153374216,
    iv_unverified_addr_count = NULL                                     => 0.0050290860,
                                                                           0.0050290860);

rc015_55_7_c480 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 35.85 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 35.85                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc015_55_7_c481,
                                                                                   NULL);

rc026_55_4_c480 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 35.85 => 0.0534019631,
    rv_a49_curr_avm_chg_1yr_pct > 35.85                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0028738551,
                                                                                   NULL);

final_score_55_c480 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 35.85 => 0.0555571940,
    rv_a49_curr_avm_chg_1yr_pct > 35.85                                         => -0.0043014255,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_55_c481,
                                                                                   0.0021552309);

rc015_55_7_c479 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc015_55_7_c480,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc026_55_4_c479 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc026_55_4_c480,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc016_55_3_c479 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0035181077,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_55_c479 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_55_c480,
    iv_br_source_count > 0.5                                => -0.0299123886,
    iv_br_source_count = NULL                               => -0.0013628768,
                                                               -0.0013628768);

rc026_55_4_c478 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc026_55_4_c479,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

rc016_55_3_c478 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc016_55_3_c479,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

final_score_55_c478 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => final_score_55_c479,
    iv_college_code > 3                             => -0.0512768118,
    iv_college_code = NULL                          => -0.0056748335,
                                                       -0.0056748335);

rc029_55_2_c478 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => 0.0043119568,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

rc015_55_7_c478 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc015_55_7_c479,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

rc015_55_7 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc015_55_7_c478,
    rv_email_domain_free_count > 1.5                                        => rc015_55_7_1,
    rv_email_domain_free_count = NULL                                       => rc015_55_7_1,
                                                                               rc015_55_7_1);

rc029_55_2 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc029_55_2_c478,
    rv_email_domain_free_count > 1.5                                        => rc029_55_2_1,
    rv_email_domain_free_count = NULL                                       => rc029_55_2_1,
                                                                               rc029_55_2_1);

rc013_55_1 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0191749231,
    rv_email_domain_free_count = NULL                                       => 0.0006027741,
                                                                               rc013_55_1_1);

rc026_55_4 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc026_55_4_c478,
    rv_email_domain_free_count > 1.5                                        => rc026_55_4_1,
    rv_email_domain_free_count = NULL                                       => rc026_55_4_1,
                                                                               rc026_55_4_1);

rc016_55_3 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc016_55_3_c478,
    rv_email_domain_free_count > 1.5                                        => rc016_55_3_1,
    rv_email_domain_free_count = NULL                                       => rc016_55_3_1,
                                                                               rc016_55_3_1);

final_score_55 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => final_score_55_c478,
    rv_email_domain_free_count > 1.5                                        => 0.0164242665,
    rv_email_domain_free_count = NULL                                       => -0.0021478825,
                                                                               -0.0027506566);

rc015_56_2_c483 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0121328488,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_56_c483 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0001321576,
    iv_unverified_addr_count > 1.5                                      => 0.0199782431,
    iv_unverified_addr_count = NULL                                     => 0.0078453943,
                                                                           0.0078453943);

rc017_56_8_c486 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 37.5 => 0.0286400292,
    iv_c13_avg_lres > 37.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                             => 0.0000000000,
                                                          NULL);

final_score_56_c486 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 37.5 => 0.0103382222,
    iv_c13_avg_lres > 37.5                             => -0.0236994011,
    iv_c13_avg_lres = NULL                             => -0.0183018070,
                                                          -0.0183018070);

rc017_56_8_c485 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => rc017_56_8_c486,
    iv_addr_bureau_only > 0.5                                 => 0.0000000000,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

final_score_56_c485 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => final_score_56_c486,
    iv_addr_bureau_only > 0.5                                 => 0.0111934239,
    iv_addr_bureau_only = NULL                                => -0.0086751820,
                                                                 -0.0086751820);

rc044_56_7_c485 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => 0.0198686060,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

rc044_56_7_c484 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => rc044_56_7_c485,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

rc041_56_6_c484 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0345814427,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_56_c484 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => final_score_56_c485,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0267070780,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.0159605818,
                                                                           -0.0078743646);

rc017_56_8_c484 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => rc017_56_8_c485,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

rc041_56_6 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc041_56_6_1,
    rv_f01_inp_addr_address_score > 95                                           => rc041_56_6_c484,
    rv_f01_inp_addr_address_score = NULL                                         => rc041_56_6_1,
                                                                                    rc041_56_6_1);

final_score_56 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => final_score_56_c483,
    rv_f01_inp_addr_address_score > 95                                           => final_score_56_c484,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0092471100,
                                                                                    -0.0033803563);

rc021_56_1 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0112257505,
    rv_f01_inp_addr_address_score > 95                                           => 0.0000000000,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0126274663,
                                                                                    rc021_56_1_1);

rc017_56_8 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc017_56_8_1,
    rv_f01_inp_addr_address_score > 95                                           => rc017_56_8_c484,
    rv_f01_inp_addr_address_score = NULL                                         => rc017_56_8_1,
                                                                                    rc017_56_8_1);

rc015_56_2 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc015_56_2_c483,
    rv_f01_inp_addr_address_score > 95                                           => rc015_56_2_1,
    rv_f01_inp_addr_address_score = NULL                                         => rc015_56_2_1,
                                                                                    rc015_56_2_1);

rc044_56_7 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc044_56_7_1,
    rv_f01_inp_addr_address_score > 95                                           => rc044_56_7_c484,
    rv_f01_inp_addr_address_score = NULL                                         => rc044_56_7_1,
                                                                                    rc044_56_7_1);

final_score_57_c491 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => 0.0022699350,
    iv_num_non_bureau_sources > 3.5                                       => -0.0181837795,
    iv_num_non_bureau_sources = NULL                                      => -0.0015257742,
                                                                             -0.0015257742);

rc010_57_6_c491 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => 0.0037957092,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_57_6_c490 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc010_57_6_c491,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_57_c490 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => final_score_57_c491,
    rv_c19_add_prison_hist > 0.5                                    => 0.1168542043,
    rv_c19_add_prison_hist = NULL                                   => -0.0012922025,
                                                                       -0.0012922025);

rc045_57_5_c490 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0000000000,
    rv_c19_add_prison_hist > 0.5                                    => 0.1181464068,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc045_57_5_c489 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => rc045_57_5_c490,
    rv_d30_derog_count > 4.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_57_c489 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => final_score_57_c490,
    rv_d30_derog_count > 4.5                                => 0.0336144789,
    rv_d30_derog_count = NULL                               => -0.0005820588,
                                                               -0.0005820588);

rc010_57_6_c489 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => rc010_57_6_c490,
    rv_d30_derog_count > 4.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_57_4_c489 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => 0.0000000000,
    rv_d30_derog_count > 4.5                                => 0.0341965377,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_57_c488 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => final_score_57_c489,
    iv_input_best_phone_match > 0.5                                       => -0.0417367927,
    iv_input_best_phone_match = NULL                                      => -0.0202050482,
                                                                             -0.0043628470);

rc001_57_4_c488 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc001_57_4_c489,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_57_6_c488 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc010_57_6_c489,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc045_57_5_c488 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc045_57_5_c489,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc011_57_3_c488 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => 0.0037807882,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc011_57_3 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc011_57_3_1,
    rv_f00_ssn_score > 95                              => rc011_57_3_c488,
    rv_f00_ssn_score = NULL                            => rc011_57_3_1,
                                                          rc011_57_3_1);

rc045_57_5 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc045_57_5_1,
    rv_f00_ssn_score > 95                              => rc045_57_5_c488,
    rv_f00_ssn_score = NULL                            => rc045_57_5_1,
                                                          rc045_57_5_1);

rc010_57_6 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc010_57_6_1,
    rv_f00_ssn_score > 95                              => rc010_57_6_c488,
    rv_f00_ssn_score = NULL                            => rc010_57_6_1,
                                                          rc010_57_6_1);

rc001_57_4 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc001_57_4_1,
    rv_f00_ssn_score > 95                              => rc001_57_4_c488,
    rv_f00_ssn_score = NULL                            => rc001_57_4_1,
                                                          rc001_57_4_1);

rc031_57_1 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0424370880,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0116977969,
                                                          rc031_57_1_1);

final_score_57 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0394608305,
    rv_f00_ssn_score > 95                              => final_score_57_c488,
    rv_f00_ssn_score = NULL                            => 0.0087215394,
                                                          -0.0029762575);

final_score_58_c494 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 93.5 => 0.0349594490,
    iv_c13_avg_lres > 93.5                             => -0.0228262336,
    iv_c13_avg_lres = NULL                             => 0.0196800911,
                                                          0.0196800911);

rc017_58_3_c494 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 93.5 => 0.0152793578,
    iv_c13_avg_lres > 93.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                             => 0.0000000000,
                                                          NULL);

rc013_58_9_c496 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0088513825,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_58_c496 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => -0.0090459389,
    rv_email_domain_free_count > 0.5                                        => 0.0044939087,
    rv_email_domain_free_count = NULL                                       => -0.0043574738,
                                                                               -0.0043574738);

final_score_58_c495 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0372674775,
    rv_f00_ssn_score > 95                              => final_score_58_c496,
    rv_f00_ssn_score = NULL                            => 0.0051404395,
                                                          -0.0033292089);

rc031_58_7_c495 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0405966864,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0084696485,
                                                          NULL);

rc013_58_9_c495 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0000000000,
    rv_f00_ssn_score > 95                              => rc013_58_9_c496,
    rv_f00_ssn_score = NULL                            => 0.0000000000,
                                                          NULL);

rc025_58_2_c493 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0216840960,
    iv_header_emergence_age > 15.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc013_58_9_c493 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0000000000,
    iv_header_emergence_age > 15.5                                     => rc013_58_9_c495,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc031_58_7_c493 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => 0.0000000000,
    iv_header_emergence_age > 15.5                                     => rc031_58_7_c495,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

final_score_58_c493 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => final_score_58_c494,
    iv_header_emergence_age > 15.5                                     => final_score_58_c495,
    iv_header_emergence_age = NULL                                     => -0.0020040049,
                                                                          -0.0020040049);

rc017_58_3_c493 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 15.5 => rc017_58_3_c494,
    iv_header_emergence_age > 15.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc025_58_2 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc025_58_2_c493,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc025_58_2_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc025_58_2_1,
                                                                           rc025_58_2_1);

rc017_58_3 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc017_58_3_c493,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc017_58_3_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc017_58_3_1,
                                                                           rc017_58_3_1);

final_score_58 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => final_score_58_c493,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0270519071,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0020085098,
                                                                           -0.0010037162);

rc037_58_1 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0280556233,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           rc037_58_1_1);

rc031_58_7 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc031_58_7_c493,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc031_58_7_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc031_58_7_1,
                                                                           rc031_58_7_1);

rc013_58_9 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc013_58_9_c493,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc013_58_9_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc013_58_9_1,
                                                                           rc013_58_9_1);

final_score_59_c501 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => -0.0057596155,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0812792899,
    rv_d31_mostrec_bk = ''                                        => -0.0054492297,
                                                                        -0.0054492297);

rc035_59_7_c501 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0867285196,
    rv_d31_mostrec_bk = ''                                        => 0.0000000000,
                                                                        NULL);

final_score_59_c500 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => final_score_59_c501,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0281969394,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0046728940,
                                                                                   -0.0046728940);

rc035_59_7_c500 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => rc035_59_7_c501,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc019_59_6_c500 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0328698334,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc035_59_7_c499 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => 0.0000000000,
    iv_header_emergence_age > 16.5                                     => rc035_59_7_c500,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc019_59_6_c499 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => 0.0000000000,
    iv_header_emergence_age > 16.5                                     => rc019_59_6_c500,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc025_59_4_c499 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => 0.0229214154,
    iv_header_emergence_age > 16.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

final_score_59_c499 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => 0.0200392570,
    iv_header_emergence_age > 16.5                                     => final_score_59_c500,
    iv_header_emergence_age = NULL                                     => -0.0028821584,
                                                                          -0.0028821584);

final_score_59_c498 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0174137875,
    rv_f00_dob_score > 98                              => final_score_59_c499,
    rv_f00_dob_score = NULL                            => -0.0308424334,
                                                          -0.0032831910);

rc025_59_4_c498 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0000000000,
    rv_f00_dob_score > 98                              => rc025_59_4_c499,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc019_59_6_c498 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0000000000,
    rv_f00_dob_score > 98                              => rc019_59_6_c499,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc035_59_7_c498 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0000000000,
    rv_f00_dob_score > 98                              => rc035_59_7_c499,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc030_59_2_c498 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0206969786,
    rv_f00_dob_score > 98                              => 0.0004010326,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc019_59_6 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc019_59_6_c498,
    rv_email_domain_free_count > 2.5                                        => rc019_59_6_1,
    rv_email_domain_free_count = NULL                                       => rc019_59_6_1,
                                                                               rc019_59_6_1);

rc035_59_7 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc035_59_7_c498,
    rv_email_domain_free_count > 2.5                                        => rc035_59_7_1,
    rv_email_domain_free_count = NULL                                       => rc035_59_7_1,
                                                                               rc035_59_7_1);

final_score_59 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => final_score_59_c498,
    rv_email_domain_free_count > 2.5                                        => 0.0221426178,
    rv_email_domain_free_count = NULL                                       => -0.0028236925,
                                                                               -0.0019023106);

rc025_59_4 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc025_59_4_c498,
    rv_email_domain_free_count > 2.5                                        => rc025_59_4_1,
    rv_email_domain_free_count = NULL                                       => rc025_59_4_1,
                                                                               rc025_59_4_1);

rc030_59_2 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc030_59_2_c498,
    rv_email_domain_free_count > 2.5                                        => rc030_59_2_1,
    rv_email_domain_free_count = NULL                                       => rc030_59_2_1,
                                                                               rc030_59_2_1);

rc013_59_1 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => 0.0000000000,
    rv_email_domain_free_count > 2.5                                        => 0.0240449284,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               rc013_59_1_1);

final_score_60_c506 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => -0.0015956636,
    rv_c19_add_prison_hist > 0.5                                    => 0.1254441669,
    rv_c19_add_prison_hist = NULL                                   => -0.0014207230,
                                                                       -0.0014207230);

rc045_60_6_c506 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0000000000,
    rv_c19_add_prison_hist > 0.5                                    => 0.1268648898,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc019_60_5_c505 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0266739140,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_60_c505 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => final_score_60_c506,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0259244027,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0007495113,
                                                                                   -0.0007495113);

rc045_60_6_c505 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => rc045_60_6_c506,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_60_c504 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => final_score_60_c505,
    iv_prof_license_category > 0.5                                      => -0.0425102222,
    iv_prof_license_category = NULL                                     => -0.0030097396,
                                                                           -0.0030097396);

rc019_60_5_c504 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc019_60_5_c505,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc047_60_4_c504 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => 0.0022602283,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc045_60_6_c504 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc045_60_6_c505,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_60_c503 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => final_score_60_c504,
    rv_c21_stl_inq_count > 0.5                                  => 0.0380518809,
    rv_c21_stl_inq_count = NULL                                 => -0.0018699940,
                                                                   -0.0018699940);

rc019_60_5_c503 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc019_60_5_c504,
    rv_c21_stl_inq_count > 0.5                                  => 0.0000000000,
    rv_c21_stl_inq_count = NULL                                 => 0.0000000000,
                                                                   NULL);

rc046_60_3_c503 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => 0.0000000000,
    rv_c21_stl_inq_count > 0.5                                  => 0.0399218749,
    rv_c21_stl_inq_count = NULL                                 => 0.0000000000,
                                                                   NULL);

rc045_60_6_c503 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc045_60_6_c504,
    rv_c21_stl_inq_count > 0.5                                  => 0.0000000000,
    rv_c21_stl_inq_count = NULL                                 => 0.0000000000,
                                                                   NULL);

rc047_60_4_c503 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc047_60_4_c504,
    rv_c21_stl_inq_count > 0.5                                  => 0.0000000000,
    rv_c21_stl_inq_count = NULL                                 => 0.0000000000,
                                                                   NULL);

final_score_60 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => 0.0242135208,
    rv_d33_eviction_recency > 36.5                                     => final_score_60_c503,
    rv_d33_eviction_recency = NULL                                     => -0.0040042330,
                                                                          -0.0010308409);

rc019_60_5 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => rc019_60_5_1,
    rv_d33_eviction_recency > 36.5                                     => rc019_60_5_c503,
    rv_d33_eviction_recency = NULL                                     => rc019_60_5_1,
                                                                          rc019_60_5_1);

rc009_60_1 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => 0.0252443617,
    rv_d33_eviction_recency > 36.5                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                     => 0.0000000000,
                                                                          rc009_60_1_1);

rc046_60_3 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => rc046_60_3_1,
    rv_d33_eviction_recency > 36.5                                     => rc046_60_3_c503,
    rv_d33_eviction_recency = NULL                                     => rc046_60_3_1,
                                                                          rc046_60_3_1);

rc045_60_6 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => rc045_60_6_1,
    rv_d33_eviction_recency > 36.5                                     => rc045_60_6_c503,
    rv_d33_eviction_recency = NULL                                     => rc045_60_6_1,
                                                                          rc045_60_6_1);

rc047_60_4 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 36.5 => rc047_60_4_1,
    rv_d33_eviction_recency > 36.5                                     => rc047_60_4_c503,
    rv_d33_eviction_recency = NULL                                     => rc047_60_4_1,
                                                                          rc047_60_4_1);

final_score_61_c511 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => -0.0453078196,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0456839740,
    rv_d31_mostrec_bk = ''                                         => -0.0306988465,
                                                                        -0.0306988465);

rc035_61_8_c511 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0763828206,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

rc034_61_6_c510 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0008610563,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc035_61_8_c510 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0000000000,
    rv_d31_bk_filing_count > 0.5                                    => rc035_61_8_c511,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_61_c510 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0024909959,
    rv_d31_bk_filing_count > 0.5                                    => final_score_61_c511,
    rv_d31_bk_filing_count = NULL                                   => 0.0016299396,
                                                                       0.0016299396);

rc034_61_6_c509 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc034_61_6_c510,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc005_61_4_c509 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0041853852,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

rc035_61_8_c509 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => rc035_61_8_c510,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_61_c509 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0352761873,
    iv_college_tier > 3                             => final_score_61_c510,
    iv_college_tier = NULL                          => -0.0025554455,
                                                       -0.0025554455);

final_score_61_c508 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => 0.0598221342,
    rv_f00_dob_score > 55                              => final_score_61_c509,
    rv_f00_dob_score = NULL                            => -0.0298587370,
                                                          -0.0038499483);

rc035_61_8_c508 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => 0.0000000000,
    rv_f00_dob_score > 55                              => rc035_61_8_c509,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc030_61_2_c508 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => 0.0636720825,
    rv_f00_dob_score > 55                              => 0.0012945027,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc005_61_4_c508 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => 0.0000000000,
    rv_f00_dob_score > 55                              => rc005_61_4_c509,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc034_61_6_c508 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => 0.0000000000,
    rv_f00_dob_score > 55                              => rc034_61_6_c509,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc035_61_8 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => rc035_61_8_c508,
    rv_l72_add_curr_vacant > 0.5                                    => rc035_61_8_1,
    rv_l72_add_curr_vacant = NULL                                   => rc035_61_8_1,
                                                                       rc035_61_8_1);

rc048_61_1 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => 0.0000000000,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0462664303,
    rv_l72_add_curr_vacant = NULL                                   => 0.0059451987,
                                                                       rc048_61_1_1);

final_score_61 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => final_score_61_c508,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0432095615,
    rv_l72_add_curr_vacant = NULL                                   => 0.0028883298,
                                                                       -0.0030568689);

rc005_61_4 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => rc005_61_4_c508,
    rv_l72_add_curr_vacant > 0.5                                    => rc005_61_4_1,
    rv_l72_add_curr_vacant = NULL                                   => rc005_61_4_1,
                                                                       rc005_61_4_1);

rc030_61_2 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => rc030_61_2_c508,
    rv_l72_add_curr_vacant > 0.5                                    => rc030_61_2_1,
    rv_l72_add_curr_vacant = NULL                                   => rc030_61_2_1,
                                                                       rc030_61_2_1);

rc034_61_6 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => rc034_61_6_c508,
    rv_l72_add_curr_vacant > 0.5                                    => rc034_61_6_1,
    rv_l72_add_curr_vacant = NULL                                   => rc034_61_6_1,
                                                                       rc034_61_6_1);

final_score_62_c513 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 68.5 => 0.0289896357,
    iv_c13_avg_lres > 68.5                             => -0.0032183594,
    iv_c13_avg_lres = NULL                             => 0.0171281680,
                                                          0.0171281680);

rc017_62_2_c513 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 68.5 => 0.0118614676,
    iv_c13_avg_lres > 68.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                             => 0.0000000000,
                                                          NULL);

rc009_62_8_c516 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => 0.0365944417,
    rv_d33_eviction_recency > 18                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                   => 0.0000000000,
                                                                        NULL);

final_score_62_c516 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => 0.0311485417,
    rv_d33_eviction_recency > 18                                     => -0.0060092804,
    rv_d33_eviction_recency = NULL                                   => -0.0054459000,
                                                                        -0.0054459000);

rc045_62_7_c515 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0000000000,
    rv_c19_add_prison_hist > 0.5                                    => 0.1026543733,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_62_c515 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => final_score_62_c516,
    rv_c19_add_prison_hist > 0.5                                    => 0.0974377861,
    rv_c19_add_prison_hist = NULL                                   => -0.0052165872,
                                                                       -0.0052165872);

rc009_62_8_c515 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc009_62_8_c516,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_62_c514 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => final_score_62_c515,
    rv_s66_adlperssn_count > 2.5                                    => 0.0150796956,
    rv_s66_adlperssn_count = NULL                                   => 0.0050738153,
                                                                       -0.0027097650);

rc045_62_7_c514 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc045_62_7_c515,
    rv_s66_adlperssn_count > 2.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc018_62_6_c514 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => 0.0000000000,
    rv_s66_adlperssn_count > 2.5                                    => 0.0177894606,
    rv_s66_adlperssn_count = NULL                                   => 0.0077835803,
                                                                       NULL);

rc009_62_8_c514 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc009_62_8_c515,
    rv_s66_adlperssn_count > 2.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc009_62_8 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => rc009_62_8_1,
    iv_header_emergence_age > 16.5                                     => rc009_62_8_c514,
    iv_header_emergence_age = NULL                                     => rc009_62_8_1,
                                                                          rc009_62_8_1);

rc025_62_1 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => 0.0181803512,
    iv_header_emergence_age > 16.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0066868806,
                                                                          rc025_62_1_1);

final_score_62 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => final_score_62_c513,
    iv_header_emergence_age > 16.5                                     => final_score_62_c514,
    iv_header_emergence_age = NULL                                     => 0.0056346974,
                                                                          -0.0010521832);

rc017_62_2 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => rc017_62_2_c513,
    iv_header_emergence_age > 16.5                                     => rc017_62_2_1,
    iv_header_emergence_age = NULL                                     => rc017_62_2_1,
                                                                          rc017_62_2_1);

rc045_62_7 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => rc045_62_7_1,
    iv_header_emergence_age > 16.5                                     => rc045_62_7_c514,
    iv_header_emergence_age = NULL                                     => rc045_62_7_1,
                                                                          rc045_62_7_1);

rc018_62_6 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 16.5 => rc018_62_6_1,
    iv_header_emergence_age > 16.5                                     => rc018_62_6_c514,
    iv_header_emergence_age = NULL                                     => rc018_62_6_1,
                                                                          rc018_62_6_1);

rc039_63_2_c518 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => 0.0000000000,
    rv_c14_addrs_10yr > 1.5                               => 0.0113460236,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

final_score_63_c518 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => -0.0072617594,
    rv_c14_addrs_10yr > 1.5                               => 0.0216877822,
    rv_c14_addrs_10yr = NULL                              => 0.0103417586,
                                                             0.0103417586);

rc014_63_9_c521 := map(
    NULL < rv_comb_age AND rv_comb_age <= 20.5 => 0.0326854654,
    rv_comb_age > 20.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_63_c521 := map(
    NULL < rv_comb_age AND rv_comb_age <= 20.5 => 0.0252155922,
    rv_comb_age > 20.5                         => -0.0082834033,
    rv_comb_age = NULL                         => -0.0074698732,
                                                  -0.0074698732);

rc014_63_9_c520 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0000000000,
    iv_c13_avg_lres > 3.5                             => rc014_63_9_c521,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_63_c520 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0274711828,
    iv_c13_avg_lres > 3.5                             => final_score_63_c521,
    iv_c13_avg_lres = NULL                            => -0.0067576713,
                                                         -0.0067576713);

rc017_63_7_c520 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 3.5 => 0.0342288541,
    iv_c13_avg_lres > 3.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc014_63_9_c519 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc014_63_9_c520,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0000000000,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc037_63_6_c519 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0267676015,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc017_63_7_c519 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc017_63_7_c520,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0000000000,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_63_c519 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => final_score_63_c520,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0210870218,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0056805797,
                                                                           -0.0056805797);

final_score_63 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => final_score_63_c518,
    iv_prv_addr_lres > 3.5                              => final_score_63_c519,
    iv_prv_addr_lres = NULL                             => 0.0010619290,
                                                           -0.0018952774);

rc039_63_2 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc039_63_2_c518,
    iv_prv_addr_lres > 3.5                              => rc039_63_2_1,
    iv_prv_addr_lres = NULL                             => rc039_63_2_1,
                                                           rc039_63_2_1);

rc017_63_7 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc017_63_7_1,
    iv_prv_addr_lres > 3.5                              => rc017_63_7_c519,
    iv_prv_addr_lres = NULL                             => rc017_63_7_1,
                                                           rc017_63_7_1);

rc037_63_6 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc037_63_6_1,
    iv_prv_addr_lres > 3.5                              => rc037_63_6_c519,
    iv_prv_addr_lres = NULL                             => rc037_63_6_1,
                                                           rc037_63_6_1);

rc027_63_1 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => 0.0122370360,
    iv_prv_addr_lres > 3.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0029572064,
                                                           rc027_63_1_1);

rc014_63_9 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc014_63_9_1,
    iv_prv_addr_lres > 3.5                              => rc014_63_9_c519,
    iv_prv_addr_lres = NULL                             => rc014_63_9_1,
                                                           rc014_63_9_1);

final_score_64_c526 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => -0.0036907106,
    rv_d31_bk_filing_count > 0.5                                    => -0.0365245690,
    rv_d31_bk_filing_count = NULL                                   => -0.0045783148,
                                                                       -0.0045783148);

rc034_64_8_c526 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0008876042,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc037_64_7_c525 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0230709847,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_64_c525 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => final_score_64_c526,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0194502564,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0036207283,
                                                                           -0.0036207283);

rc034_64_8_c525 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc034_64_8_c526,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0000000000,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_64_c524 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0359380359,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0063714809,
    iv_bureau_emergence_age_buronly = NULL                                             => final_score_64_c525,
                                                                                          -0.0019432137);

rc037_64_7_c524 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0000000000,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0000000000,
    iv_bureau_emergence_age_buronly = NULL                                             => rc037_64_7_c525,
                                                                                          NULL);

rc034_64_8_c524 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0000000000,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0000000000,
    iv_bureau_emergence_age_buronly = NULL                                             => rc034_64_8_c525,
                                                                                          NULL);

rc033_64_4_c524 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 14.5 => 0.0378812496,
    iv_bureau_emergence_age_buronly > 14.5                                             => 0.0083146946,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0000000000,
                                                                                          NULL);

rc034_64_8_c523 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0000000000,
    rv_f00_dob_score > 98                              => rc034_64_8_c524,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc033_64_4_c523 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0000000000,
    rv_f00_dob_score > 98                              => rc033_64_4_c524,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc030_64_2_c523 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0161928027,
    rv_f00_dob_score > 98                              => 0.0005873733,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_64_c523 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0136622157,
    rv_f00_dob_score > 98                              => final_score_64_c524,
    rv_f00_dob_score = NULL                            => -0.0291764456,
                                                          -0.0025305870);

rc037_64_7_c523 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 98 => 0.0000000000,
    rv_f00_dob_score > 98                              => rc037_64_7_c524,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc046_64_1 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => 0.0000000000,
    rv_c21_stl_inq_count > 0.5                                  => 0.0406872800,
    rv_c21_stl_inq_count = NULL                                 => 0.0018106464,
                                                                   rc046_64_1_1);

rc033_64_4 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc033_64_4_c523,
    rv_c21_stl_inq_count > 0.5                                  => rc033_64_4_1,
    rv_c21_stl_inq_count = NULL                                 => rc033_64_4_1,
                                                                   rc033_64_4_1);

rc034_64_8 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc034_64_8_c523,
    rv_c21_stl_inq_count > 0.5                                  => rc034_64_8_1,
    rv_c21_stl_inq_count = NULL                                 => rc034_64_8_1,
                                                                   rc034_64_8_1);

rc037_64_7 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc037_64_7_c523,
    rv_c21_stl_inq_count > 0.5                                  => rc037_64_7_1,
    rv_c21_stl_inq_count = NULL                                 => rc037_64_7_1,
                                                                   rc037_64_7_1);

rc030_64_2 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc030_64_2_c523,
    rv_c21_stl_inq_count > 0.5                                  => rc030_64_2_1,
    rv_c21_stl_inq_count = NULL                                 => rc030_64_2_1,
                                                                   rc030_64_2_1);

final_score_64 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => final_score_64_c523,
    rv_c21_stl_inq_count > 0.5                                  => 0.0393625574,
    rv_c21_stl_inq_count = NULL                                 => 0.0004859238,
                                                                   -0.0013247226);

final_score_65_c529 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => -0.0199389955,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0285105691,
    rv_i62_inq_addrs_per_adl = NULL                                     => -0.0178499838,
                                                                           -0.0178499838);

rc020_65_4_c529 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => 0.0000000000,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0463605529,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

rc026_65_2_c528 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.15 => 0.0289595689,
    rv_a49_curr_avm_chg_1yr_pct > 58.15                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0053682341,
                                                                                   NULL);

final_score_65_c528 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.15 => 0.0219254699,
    rv_a49_curr_avm_chg_1yr_pct > 58.15                                         => final_score_65_c529,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => -0.0016658649,
                                                                                   -0.0070340990);

rc020_65_4_c528 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.15 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 58.15                                         => rc020_65_4_c529,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0000000000,
                                                                                   NULL);

rc023_65_11_c531 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0235614570,
    iv_source_type > 4.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_65_c531 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0401270662,
    iv_source_type > 4.5                            => 0.0114700881,
    iv_source_type = NULL                           => 0.0165656092,
                                                       0.0165656092);

rc023_65_11_c530 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => rc023_65_11_c531,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_65_c530 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0014231976,
    iv_unverified_addr_count > 1.5                                      => final_score_65_c531,
    iv_unverified_addr_count = NULL                                     => 0.0139189239,
                                                                           0.0072742606);

rc015_65_9_c530 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0092913486,
    iv_unverified_addr_count = NULL                                     => 0.0066446633,
                                                                           NULL);

rc015_65_9 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc015_65_9_1,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc015_65_9_c530,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc015_65_9_1,
                                                                         rc015_65_9_1);

rc020_65_4 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc020_65_4_c528,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc020_65_4_1,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc020_65_4_1,
                                                                         rc020_65_4_1);

rc036_65_1 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_addr_c6 > 0.5                                     => 0.0086218163,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         rc036_65_1_1);

rc026_65_2 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc026_65_2_c528,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc026_65_2_1,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc026_65_2_1,
                                                                         rc026_65_2_1);

final_score_65 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => final_score_65_c528,
    rv_l79_adls_per_addr_c6 > 0.5                                     => final_score_65_c530,
    rv_l79_adls_per_addr_c6 = NULL                                    => -0.0013475557,
                                                                         -0.0013475557);

rc023_65_11 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc023_65_11_1,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc023_65_11_c530,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc023_65_11_1,
                                                                         rc023_65_11_1);

final_score_66_c533 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0028138244,
    iv_unverified_addr_count > 0.5                                      => 0.0305439472,
    iv_unverified_addr_count = NULL                                     => 0.0117952275,
                                                                           0.0106304799);

rc015_66_2_c533 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0199134674,
    iv_unverified_addr_count = NULL                                     => 0.0011647477,
                                                                           NULL);

rc041_66_7_c535 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0003195586,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0343979116,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_66_c535 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => -0.0076069828,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0264713702,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.0166580814,
                                                                           -0.0079265414);

rc040_66_11_c536 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 244.5 => 0.0111367973,
    rv_c20_m_bureau_adl_fs > 244.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

final_score_66_c536 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 244.5 => 0.0147478783,
    rv_c20_m_bureau_adl_fs > 244.5                                    => -0.0084939995,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0036110810,
                                                                         0.0036110810);

rc040_66_11_c534 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => rc040_66_11_c536,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc015_66_6_c534 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0065173995,
    iv_unverified_addr_count = NULL                                     => 0.0050843307,
                                                                           NULL);

final_score_66_c534 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => final_score_66_c535,
    iv_unverified_addr_count > 1.5                                      => final_score_66_c536,
    iv_unverified_addr_count = NULL                                     => 0.0021780122,
                                                                           -0.0029063184);

rc041_66_7_c534 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => rc041_66_7_c535,
    iv_unverified_addr_count > 1.5                                      => 0.0000000000,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc041_66_7 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc041_66_7_1,
    rv_comb_age > 21.5                         => rc041_66_7_c534,
    rv_comb_age = NULL                         => rc041_66_7_1,
                                                  rc041_66_7_1);

final_score_66 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => final_score_66_c533,
    rv_comb_age > 21.5                         => final_score_66_c534,
    rv_comb_age = NULL                         => -0.0807310033,
                                                  -0.0014619698);

rc015_66_2 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc015_66_2_c533,
    rv_comb_age > 21.5                         => rc015_66_2_1,
    rv_comb_age = NULL                         => rc015_66_2_1,
                                                  rc015_66_2_1);

rc014_66_1 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0120924497,
    rv_comb_age > 21.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  rc014_66_1_1);

rc015_66_6 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc015_66_6_1,
    rv_comb_age > 21.5                         => rc015_66_6_c534,
    rv_comb_age = NULL                         => rc015_66_6_1,
                                                  rc015_66_6_1);

rc040_66_11 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => rc040_66_11_1,
    rv_comb_age > 21.5                         => rc040_66_11_c534,
    rv_comb_age = NULL                         => rc040_66_11_1,
                                                  rc040_66_11_1);

rc035_67_2_c538 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0961384315,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

final_score_67_c538 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => -0.0067728236,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0895551228,
    rv_d31_mostrec_bk = ''                                         => -0.0147818763,
                                                                        -0.0065833087);

final_score_67_c541 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0557942158,
    rv_f00_ssn_score > 95                              => -0.0016255317,
    rv_f00_ssn_score = NULL                            => 0.0619193048,
                                                          0.0004635603);

rc031_67_10_c541 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0553306556,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0614557446,
                                                          NULL);

final_score_67_c540 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0198090070,
    iv_num_non_bureau_sources > 2.5                                       => final_score_67_c541,
    iv_num_non_bureau_sources = NULL                                      => 0.0110028554,
                                                                             0.0110028554);

rc010_67_8_c540 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0088061516,
    iv_num_non_bureau_sources > 2.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc031_67_10_c540 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 2.5 => 0.0000000000,
    iv_num_non_bureau_sources > 2.5                                       => rc031_67_10_c541,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_67_8_c539 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc010_67_8_c540,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_67_c539 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0029707435,
    iv_unverified_addr_count > 0.5                                      => final_score_67_c540,
    iv_unverified_addr_count = NULL                                     => -0.0006459416,
                                                                           0.0052272837);

rc031_67_10_c539 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc031_67_10_c540,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc015_67_6_c539 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0057755716,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc031_67_10 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc031_67_10_1,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc031_67_10_c539,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc031_67_10_1,
                                                                         rc031_67_10_1);

rc015_67_6 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc015_67_6_1,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc015_67_6_c539,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc015_67_6_1,
                                                                         rc015_67_6_1);

rc035_67_2 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc035_67_2_c538,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc035_67_2_1,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc035_67_2_1,
                                                                         rc035_67_2_1);

rc010_67_8 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => rc010_67_8_1,
    rv_l79_adls_per_addr_c6 > 0.5                                     => rc010_67_8_c539,
    rv_l79_adls_per_addr_c6 = NULL                                    => rc010_67_8_1,
                                                                         rc010_67_8_1);

final_score_67 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => final_score_67_c538,
    rv_l79_adls_per_addr_c6 > 0.5                                     => final_score_67_c539,
    rv_l79_adls_per_addr_c6 = NULL                                    => -0.0019095235,
                                                                         -0.0019095235);

rc036_67_1 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_addr_c6 > 0.5                                     => 0.0071368072,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         rc036_67_1_1);

rc015_68_5_c546 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0074027648,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_68_c546 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000452214,
    iv_unverified_addr_count > 0.5                                      => 0.0163036406,
    iv_unverified_addr_count = NULL                                     => 0.0089008758,
                                                                           0.0089008758);

final_score_68_c545 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => final_score_68_c546,
    iv_num_non_bureau_sources > 4.5                                       => -0.0224286594,
    iv_num_non_bureau_sources = NULL                                      => 0.0065599862,
                                                                             0.0065599862);

rc015_68_5_c545 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => rc015_68_5_c546,
    iv_num_non_bureau_sources > 4.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_68_4_c545 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => 0.0023408896,
    iv_num_non_bureau_sources > 4.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_68_4_c544 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc010_68_4_c545,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc008_68_3_c544 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => 0.0092623948,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

final_score_68_c544 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => final_score_68_c545,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => -0.0105554656,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => -0.0027024086,
                                                                                           -0.0027024086);

rc015_68_5_c544 := map(
    NULL < iv_a46_l77_addrs_move_traj_index AND iv_a46_l77_addrs_move_traj_index <= 2.5 => rc015_68_5_c545,
    iv_a46_l77_addrs_move_traj_index > 2.5                                              => 0.0000000000,
    iv_a46_l77_addrs_move_traj_index = NULL                                             => 0.0000000000,
                                                                                           NULL);

rc010_68_4_c543 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => rc010_68_4_c544,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

rc041_68_2_c543 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0266780900,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_68_c543 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => final_score_68_c544,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0245497937,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.0057924634,
                                                                           -0.0021282962);

rc015_68_5_c543 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => rc015_68_5_c544,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

rc008_68_3_c543 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => rc008_68_3_c544,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

rc041_68_2 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc041_68_2_c543,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc041_68_2_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc041_68_2_1,
                                                                                     rc041_68_2_1);

rc010_68_4 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc010_68_4_c543,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc010_68_4_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc010_68_4_1,
                                                                                     rc010_68_4_1);

rc012_68_1 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0282991703,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0033923247,
                                                                                     rc012_68_1_1);

rc008_68_3 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc008_68_3_c543,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc008_68_3_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc008_68_3_1,
                                                                                     rc008_68_3_1);

rc015_68_5 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc015_68_5_c543,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => rc015_68_5_1,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => rc015_68_5_1,
                                                                                     rc015_68_5_1);

final_score_68 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_68_c543,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0269299319,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0020230862,
                                                                                     -0.0013692384);

final_score_69_c549 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => -0.0032959512,
    iv_br_source_count > 0.5                                => -0.0319218687,
    iv_br_source_count = NULL                               => -0.0239853016,
                                                               -0.0064993854);

rc016_69_3_c549 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0032034343,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc014_69_7_c550 := map(
    NULL < rv_comb_age AND rv_comb_age <= 20.5 => 0.0194172533,
    rv_comb_age > 20.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_69_c550 := map(
    NULL < rv_comb_age AND rv_comb_age <= 20.5 => 0.0251402845,
    rv_comb_age > 20.5                         => 0.0047597089,
    rv_comb_age = NULL                         => -0.0782837213,
                                                  0.0057230312);

rc025_69_11_c551 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 37.5 => 0.0044831732,
    iv_header_emergence_age > 37.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0151637508,
                                                                          NULL);

final_score_69_c551 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 37.5 => 0.0086072663,
    iv_header_emergence_age > 37.5                                     => -0.0758213471,
    iv_header_emergence_age = NULL                                     => 0.0192878439,
                                                                          0.0041240931);

final_score_69_c548 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_69_c549,
    rv_s66_adlperssn_count > 1.5                                    => final_score_69_c550,
    rv_s66_adlperssn_count = NULL                                   => final_score_69_c551,
                                                                       -0.0016499940);

rc016_69_3_c548 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc016_69_3_c549,
    rv_s66_adlperssn_count > 1.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc018_69_2_c548 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0073730252,
    rv_s66_adlperssn_count = NULL                                   => 0.0057740871,
                                                                       NULL);

rc025_69_11_c548 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => rc025_69_11_c551,
                                                                       NULL);

rc014_69_7_c548 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => rc014_69_7_c550,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc014_69_7 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc014_69_7_c548,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc014_69_7_1,
    rv_p85_phn_risk_level = ''                                             => rc014_69_7_1,
                                                                                 rc014_69_7_1);

rc038_69_1 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0414846983,
    rv_p85_phn_risk_level = ''                                              => 0.0000000000,
                                                                                 rc038_69_1_1);

rc025_69_11 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc025_69_11_c548,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc025_69_11_1,
    rv_p85_phn_risk_level = ''                                              => rc025_69_11_1,
                                                                                 rc025_69_11_1);

rc018_69_2 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc018_69_2_c548,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc018_69_2_1,
    rv_p85_phn_risk_level = ''                                              => rc018_69_2_1,
                                                                                 rc018_69_2_1);

final_score_69 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => final_score_69_c548,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0403745391,
    rv_p85_phn_risk_level = ''                                              => -0.0081212275,
                                                                                 -0.0011101592);

rc016_69_3 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc016_69_3_c548,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc016_69_3_1,
    rv_p85_phn_risk_level = ''                                              => rc016_69_3_1,
                                                                                 rc016_69_3_1);

rc017_70_4_c554 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.1000886883,
    iv_c13_avg_lres > 2.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_70_c554 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0874011394,
    iv_c13_avg_lres > 2.5                             => -0.0131242793,
    iv_c13_avg_lres = NULL                            => -0.0126875489,
                                                         -0.0126875489);

final_score_70_c553 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => final_score_70_c554,
    rv_d30_derog_count > 1.5                                => 0.0169337959,
    rv_d30_derog_count = NULL                               => -0.0103040776,
                                                               -0.0103040776);

rc001_70_3_c553 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => 0.0000000000,
    rv_d30_derog_count > 1.5                                => 0.0272378735,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc017_70_4_c553 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => rc017_70_4_c554,
    rv_d30_derog_count > 1.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc043_70_11_c556 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0056931413,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_70_c556 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => -0.0015429039,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0096762209,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0039830796,
                                                                              0.0039830796);

rc047_70_10_c555 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => 0.0016386388,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_70_c555 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => final_score_70_c556,
    iv_prof_license_category > 0.5                                      => -0.0342786094,
    iv_prof_license_category = NULL                                     => 0.0017385185,
                                                                           0.0023444408);

rc043_70_11_c555 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc043_70_11_c556,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc001_70_3 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.15 => rc001_70_3_1,
    rv_a49_curr_avm_chg_1yr_pct > 53.15                                         => rc001_70_3_c553,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc001_70_3_1,
                                                                                   rc001_70_3_1);

rc017_70_4 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.15 => rc017_70_4_1,
    rv_a49_curr_avm_chg_1yr_pct > 53.15                                         => rc017_70_4_c553,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc017_70_4_1,
                                                                                   rc017_70_4_1);

rc047_70_10 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.15 => rc047_70_10_1,
    rv_a49_curr_avm_chg_1yr_pct > 53.15                                         => rc047_70_10_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc047_70_10_c555,
                                                                                   rc047_70_10_1);

rc026_70_1 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.15 => 0.0221931090,
    rv_a49_curr_avm_chg_1yr_pct > 53.15                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0039711099,
                                                                                   rc026_70_1_1);

rc043_70_11 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.15 => rc043_70_11_1,
    rv_a49_curr_avm_chg_1yr_pct > 53.15                                         => rc043_70_11_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc043_70_11_c555,
                                                                                   rc043_70_11_1);

final_score_70 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.15 => 0.0205664399,
    rv_a49_curr_avm_chg_1yr_pct > 53.15                                         => final_score_70_c553,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_70_c555,
                                                                                   -0.0016266691);

final_score_71_c561 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => -0.0025366726,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0145242447,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.0078389345,
                                                                           -0.0029242952);

rc041_71_5_c561 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0003876226,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0174485398,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_71_c560 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE']) => final_score_71_c561,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'NOT ISSUED'])   => 0.0280209637,
    rv_p85_phn_risk_level = ''                                => -0.0117375536,
                                                                   -0.0027531007);

rc041_71_5_c560 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE']) => rc041_71_5_c561,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'NOT ISSUED'])   => 0.0000000000,
    rv_p85_phn_risk_level = ''                               => 0.0000000000,
                                                                   NULL);

rc038_71_4_c560 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'NOT ISSUED'])   => 0.0307740644,
    rv_p85_phn_risk_level = ''                                => 0.0000000000,
                                                                   NULL);

final_score_71_c559 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => final_score_71_c560,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0346320852,
    rv_l72_add_curr_vacant = NULL                                   => -0.0022318768,
                                                                       -0.0022318768);

rc048_71_3_c559 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => 0.0000000000,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0368639620,
    rv_l72_add_curr_vacant = NULL                                   => 0.0000000000,
                                                                       NULL);

rc041_71_5_c559 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => rc041_71_5_c560,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0000000000,
    rv_l72_add_curr_vacant = NULL                                   => 0.0000000000,
                                                                       NULL);

rc038_71_4_c559 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => rc038_71_4_c560,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0000000000,
    rv_l72_add_curr_vacant = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_71_c558 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => final_score_71_c559,
    rv_email_domain_free_count > 2.5                                        => 0.0183241508,
    rv_email_domain_free_count = NULL                                       => -0.0011473122,
                                                                               -0.0011473122);

rc048_71_3_c558 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc048_71_3_c559,
    rv_email_domain_free_count > 2.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc041_71_5_c558 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc041_71_5_c559,
    rv_email_domain_free_count > 2.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc038_71_4_c558 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc038_71_4_c559,
    rv_email_domain_free_count > 2.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc013_71_2_c558 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => 0.0000000000,
    rv_email_domain_free_count > 2.5                                        => 0.0194714630,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc038_71_4 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => rc038_71_4_c558,
    rv_d30_derog_count > 4.5                                => rc038_71_4_1,
    rv_d30_derog_count = NULL                               => rc038_71_4_1,
                                                               rc038_71_4_1);

rc001_71_1 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => 0.0000000000,
    rv_d30_derog_count > 4.5                                => 0.0329094362,
    rv_d30_derog_count = NULL                               => 0.0030722233,
                                                               rc001_71_1_1);

rc041_71_5 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => rc041_71_5_c558,
    rv_d30_derog_count > 4.5                                => rc041_71_5_1,
    rv_d30_derog_count = NULL                               => rc041_71_5_1,
                                                               rc041_71_5_1);

rc013_71_2 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => rc013_71_2_c558,
    rv_d30_derog_count > 4.5                                => rc013_71_2_1,
    rv_d30_derog_count = NULL                               => rc013_71_2_1,
                                                               rc013_71_2_1);

final_score_71 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => final_score_71_c558,
    rv_d30_derog_count > 4.5                                => 0.0324647380,
    rv_d30_derog_count = NULL                               => 0.0026275250,
                                                               -0.0004446983);

rc048_71_3 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => rc048_71_3_c558,
    rv_d30_derog_count > 4.5                                => rc048_71_3_1,
    rv_d30_derog_count = NULL                               => rc048_71_3_1,
                                                               rc048_71_3_1);

final_score_72_c566 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 2.5 => 0.0219310400,
    iv_prv_addr_lres > 2.5                              => 0.0074431866,
    iv_prv_addr_lres = NULL                             => 0.0181138823,
                                                           0.0106515162);

rc027_72_6_c566 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 2.5 => 0.0112795238,
    iv_prv_addr_lres > 2.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0074623662,
                                                           NULL);

final_score_72_c565 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0013681745,
    iv_unverified_addr_count > 0.5                                      => final_score_72_c566,
    iv_unverified_addr_count = NULL                                     => 0.0052627135,
                                                                           0.0052627135);

rc015_72_4_c565 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0053888026,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc027_72_6_c565 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc027_72_6_c566,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_72_c564 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 289.5 => final_score_72_c565,
    rv_c20_m_bureau_adl_fs > 289.5                                    => -0.0144730365,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0027735496,
                                                                         0.0027735496);

rc027_72_6_c564 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 289.5 => rc027_72_6_c565,
    rv_c20_m_bureau_adl_fs > 289.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc015_72_4_c564 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 289.5 => rc015_72_4_c565,
    rv_c20_m_bureau_adl_fs > 289.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc040_72_3_c564 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 289.5 => 0.0024891640,
    rv_c20_m_bureau_adl_fs > 289.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc029_72_2_c563 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => 0.0027546708,
    iv_college_code > 0.5                             => 0.0000000000,
    iv_college_code = NULL                            => 0.0000000000,
                                                         NULL);

final_score_72_c563 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => final_score_72_c564,
    iv_college_code > 0.5                             => -0.0229297205,
    iv_college_code = NULL                            => 0.0000188788,
                                                         0.0000188788);

rc040_72_3_c563 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => rc040_72_3_c564,
    iv_college_code > 0.5                             => 0.0000000000,
    iv_college_code = NULL                            => 0.0000000000,
                                                         NULL);

rc015_72_4_c563 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => rc015_72_4_c564,
    iv_college_code > 0.5                             => 0.0000000000,
    iv_college_code = NULL                            => 0.0000000000,
                                                         NULL);

rc027_72_6_c563 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => rc027_72_6_c564,
    iv_college_code > 0.5                             => 0.0000000000,
    iv_college_code = NULL                            => 0.0000000000,
                                                         NULL);

final_score_72 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_72_c563,
    iv_br_source_count > 0.5                                => -0.0225228405,
    iv_br_source_count = NULL                               => 0.0003777227,
                                                               -0.0024669445);

rc029_72_2 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc029_72_2_c563,
    iv_br_source_count > 0.5                                => rc029_72_2_1,
    iv_br_source_count = NULL                               => rc029_72_2_1,
                                                               rc029_72_2_1);

rc027_72_6 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc027_72_6_c563,
    iv_br_source_count > 0.5                                => rc027_72_6_1,
    iv_br_source_count = NULL                               => rc027_72_6_1,
                                                               rc027_72_6_1);

rc040_72_3 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc040_72_3_c563,
    iv_br_source_count > 0.5                                => rc040_72_3_1,
    iv_br_source_count = NULL                               => rc040_72_3_1,
                                                               rc040_72_3_1);

rc016_72_1 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0024858233,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0028446672,
                                                               rc016_72_1_1);

rc015_72_4 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc015_72_4_c563,
    iv_br_source_count > 0.5                                => rc015_72_4_1,
    iv_br_source_count = NULL                               => rc015_72_4_1,
                                                               rc015_72_4_1);

final_score_73_c569 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 3.5 => -0.0100425271,
    rv_d30_derog_count > 3.5                                => 0.0378003836,
    rv_d30_derog_count = NULL                               => -0.0089590762,
                                                               -0.0089590762);

rc001_73_4_c569 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 3.5 => 0.0000000000,
    rv_d30_derog_count > 3.5                                => 0.0467594598,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc001_73_4_c568 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc001_73_4_c569,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

final_score_73_c568 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_73_c569,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0439110568,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0080061267,
                                                                                     -0.0080061267);

rc012_73_3_c568 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0519171835,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc015_73_11_c571 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0071537175,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_73_c571 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0009631996,
    iv_unverified_addr_count > 1.5                                      => 0.0104901085,
    iv_unverified_addr_count = NULL                                     => 0.0033363911,
                                                                           0.0033363911);

rc015_73_11_c570 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => rc015_73_11_c571,
    iv_num_non_bureau_sources > 4.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_73_10_c570 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => 0.0018636059,
    iv_num_non_bureau_sources > 4.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_73_c570 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => final_score_73_c571,
    iv_num_non_bureau_sources > 4.5                                       => -0.0238562898,
    iv_num_non_bureau_sources = NULL                                      => -0.0013883564,
                                                                             0.0014727852);

rc010_73_10 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => rc010_73_10_1,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => rc010_73_10_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc010_73_10_c570,
                                                                                   rc010_73_10_1);

rc015_73_11 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => rc015_73_11_1,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => rc015_73_11_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc015_73_11_c570,
                                                                                   rc015_73_11_1);

rc026_73_1 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => 0.0235279740,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0024355172,
                                                                                   rc026_73_1_1);

rc001_73_4 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => rc001_73_4_1,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => rc001_73_4_c568,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc001_73_4_1,
                                                                                   rc001_73_4_1);

final_score_73 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => 0.0225652420,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => final_score_73_c568,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_73_c570,
                                                                                   -0.0009627320);

rc012_73_3 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 58.95 => rc012_73_3_1,
    rv_a49_curr_avm_chg_1yr_pct > 58.95                                         => rc012_73_3_c568,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc012_73_3_1,
                                                                                   rc012_73_3_1);

rc013_74_2_c573 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0174278017,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_74_c573 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0018430882,
    rv_email_domain_free_count > 0.5                                        => 0.0258722138,
    rv_email_domain_free_count = NULL                                       => 0.0083056084,
                                                                               0.0084444122);

final_score_74_c575 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0286710085,
    rv_f00_ssn_score > 95                              => -0.0102507817,
    rv_f00_ssn_score = NULL                            => 0.0066040021,
                                                          -0.0088162595);

rc031_74_7_c575 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0374872680,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0154202616,
                                                          NULL);

rc011_74_11_c576 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0066992603,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_74_c576 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0082441044,
    iv_input_best_phone_match > -0.5                                       => -0.0133440906,
    iv_input_best_phone_match = NULL                                       => -0.0106949889,
                                                                              0.0015448441);

rc031_74_7_c574 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => rc031_74_7_c575,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0000000000,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

rc011_74_11_c574 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc011_74_11_c576,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

rc043_74_6_c574 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0046407550,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_74_c574 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => final_score_74_c575,
    rv_l79_adls_per_addr_curr > 0.75                                       => final_score_74_c576,
    rv_l79_adls_per_addr_curr = NULL                                       => -0.0030959109,
                                                                              -0.0030959109);

rc013_74_2 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc013_74_2_c573,
    rv_comb_age > 22.5                         => rc013_74_2_1,
    rv_comb_age = NULL                         => rc013_74_2_1,
                                                  rc013_74_2_1);

rc043_74_6 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc043_74_6_1,
    rv_comb_age > 22.5                         => rc043_74_6_c574,
    rv_comb_age = NULL                         => rc043_74_6_1,
                                                  rc043_74_6_1);

rc014_74_1 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0098660544,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  rc014_74_1_1);

final_score_74 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => final_score_74_c573,
    rv_comb_age > 22.5                         => final_score_74_c574,
    rv_comb_age = NULL                         => -0.0596135525,
                                                  -0.0014216422);

rc011_74_11 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc011_74_11_1,
    rv_comb_age > 22.5                         => rc011_74_11_c574,
    rv_comb_age = NULL                         => rc011_74_11_1,
                                                  rc011_74_11_1);

rc031_74_7 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => rc031_74_7_1,
    rv_comb_age > 22.5                         => rc031_74_7_c574,
    rv_comb_age = NULL                         => rc031_74_7_1,
                                                  rc031_74_7_1);

final_score_75_c581 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0214875174,
    iv_bureau_verification_index > 9.5                                          => -0.0037474564,
    iv_bureau_verification_index = NULL                                         => -0.0016167338,
                                                                                   -0.0016167338);

rc028_75_8_c581 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0231042512,
    iv_bureau_verification_index > 9.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc023_75_6_c580 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0202371655,
    iv_source_type > 4.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_75_c580 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0225678254,
    iv_source_type > 4.5                            => final_score_75_c581,
    iv_source_type = NULL                           => 0.0023306599,
                                                       0.0023306599);

rc028_75_8_c580 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0000000000,
    iv_source_type > 4.5                            => rc028_75_8_c581,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

rc028_75_8_c579 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => rc028_75_8_c580,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc015_75_4_c579 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0046567669,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_75_c579 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0052748341,
    iv_unverified_addr_count > 1.5                                      => final_score_75_c580,
    iv_unverified_addr_count = NULL                                     => -0.0023261070,
                                                                           -0.0023261070);

rc023_75_6_c579 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => rc023_75_6_c580,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_75_c578 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0353980059,
    rv_d33_eviction_recency > 9                                     => final_score_75_c579,
    rv_d33_eviction_recency = NULL                                  => -0.0019926123,
                                                                       -0.0019926123);

rc015_75_4_c578 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0000000000,
    rv_d33_eviction_recency > 9                                     => rc015_75_4_c579,
    rv_d33_eviction_recency = NULL                                  => 0.0000000000,
                                                                       NULL);

rc028_75_8_c578 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0000000000,
    rv_d33_eviction_recency > 9                                     => rc028_75_8_c579,
    rv_d33_eviction_recency = NULL                                  => 0.0000000000,
                                                                       NULL);

rc023_75_6_c578 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0000000000,
    rv_d33_eviction_recency > 9                                     => rc023_75_6_c579,
    rv_d33_eviction_recency = NULL                                  => 0.0000000000,
                                                                       NULL);

rc009_75_2_c578 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0373906182,
    rv_d33_eviction_recency > 9                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                  => 0.0000000000,
                                                                       NULL);

rc028_75_8 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc028_75_8_c578,
    rv_c21_stl_inq_count > 0.5                                  => rc028_75_8_1,
    rv_c21_stl_inq_count = NULL                                 => rc028_75_8_1,
                                                                   rc028_75_8_1);

rc015_75_4 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc015_75_4_c578,
    rv_c21_stl_inq_count > 0.5                                  => rc015_75_4_1,
    rv_c21_stl_inq_count = NULL                                 => rc015_75_4_1,
                                                                   rc015_75_4_1);

final_score_75 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => final_score_75_c578,
    rv_c21_stl_inq_count > 0.5                                  => 0.0292016882,
    rv_c21_stl_inq_count = NULL                                 => -0.0028333033,
                                                                   -0.0011280666);

rc023_75_6 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc023_75_6_c578,
    rv_c21_stl_inq_count > 0.5                                  => rc023_75_6_1,
    rv_c21_stl_inq_count = NULL                                 => rc023_75_6_1,
                                                                   rc023_75_6_1);

rc046_75_1 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => 0.0000000000,
    rv_c21_stl_inq_count > 0.5                                  => 0.0303297548,
    rv_c21_stl_inq_count = NULL                                 => 0.0000000000,
                                                                   rc046_75_1_1);

rc009_75_2 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc009_75_2_c578,
    rv_c21_stl_inq_count > 0.5                                  => rc009_75_2_1,
    rv_c21_stl_inq_count = NULL                                 => rc009_75_2_1,
                                                                   rc009_75_2_1);

rc028_76_7_c586 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0240709120,
    iv_bureau_verification_index > 9.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_76_c586 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0324823478,
    iv_bureau_verification_index > 9.5                                          => 0.0049130429,
    iv_bureau_verification_index = NULL                                         => 0.0084114358,
                                                                                   0.0084114358);

final_score_76_c585 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0024392487,
    iv_unverified_addr_count > 1.5                                      => final_score_76_c586,
    iv_unverified_addr_count = NULL                                     => 0.0014002047,
                                                                           0.0014002047);

rc015_76_5_c585 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0070112311,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc028_76_7_c585 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => rc028_76_7_c586,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc015_76_5_c584 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => rc015_76_5_c585,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_76_c584 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => final_score_76_c585,
    iv_num_non_bureau_sources > 3.5                                       => -0.0137090928,
    iv_num_non_bureau_sources = NULL                                      => -0.0015311536,
                                                                             -0.0015311536);

rc010_76_4_c584 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => 0.0029313583,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc028_76_7_c584 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => rc028_76_7_c585,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc028_76_7_c583 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => rc028_76_7_c584,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0000000000,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_76_4_c583 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => rc010_76_4_c584,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0000000000,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_76_c583 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => final_score_76_c584,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0265172970,
    rv_l79_adls_per_addr_curr = NULL                                      => -0.0000974184,
                                                                             -0.0000974184);

rc043_76_3_c583 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0266147153,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0000000000,
                                                                             NULL);

rc015_76_5_c583 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => rc015_76_5_c584,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0000000000,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0000000000,
                                                                             NULL);

rc030_76_1 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => 0.0203938809,
    rv_f00_dob_score > 95                              => 0.0004437004,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          rc030_76_1_1);

rc028_76_7 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => rc028_76_7_1,
    rv_f00_dob_score > 95                              => rc028_76_7_c583,
    rv_f00_dob_score = NULL                            => rc028_76_7_1,
                                                          rc028_76_7_1);

rc043_76_3 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => rc043_76_3_1,
    rv_f00_dob_score > 95                              => rc043_76_3_c583,
    rv_f00_dob_score = NULL                            => rc043_76_3_1,
                                                          rc043_76_3_1);

rc015_76_5 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => rc015_76_5_1,
    rv_f00_dob_score > 95                              => rc015_76_5_c583,
    rv_f00_dob_score = NULL                            => rc015_76_5_1,
                                                          rc015_76_5_1);

rc010_76_4 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => rc010_76_4_1,
    rv_f00_dob_score > 95                              => rc010_76_4_c583,
    rv_f00_dob_score = NULL                            => rc010_76_4_1,
                                                          rc010_76_4_1);

final_score_76 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => 0.0198527622,
    rv_f00_dob_score > 95                              => final_score_76_c583,
    rv_f00_dob_score = NULL                            => -0.0188396953,
                                                          -0.0005411187);

rc043_77_4_c590 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0055996405,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_77_c590 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => -0.0028645814,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0086980677,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0030984272,
                                                                              0.0030984272);

rc001_77_8_c591 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0505666222,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_77_c591 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => -0.0269284000,
    rv_d30_derog_count > 0.5                                => 0.0290172496,
    rv_d30_derog_count = NULL                               => -0.0215493726,
                                                               -0.0215493726);

rc001_77_8_c589 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0000000000,
    rv_a44_curr_add_naprop > 3.5                                    => rc001_77_8_c591,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_77_c589 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => final_score_77_c590,
    rv_a44_curr_add_naprop > 3.5                                    => final_score_77_c591,
    rv_a44_curr_add_naprop = NULL                                   => -0.0030376504,
                                                                       -0.0030376504);

rc002_77_3_c589 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => 0.0061360776,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc043_77_4_c589 := map(
    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop <= 3.5 => rc043_77_4_c590,
    rv_a44_curr_add_naprop > 3.5                                    => 0.0000000000,
    rv_a44_curr_add_naprop = NULL                                   => 0.0000000000,
                                                                       NULL);

rc034_77_2_c588 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0007355269,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc001_77_8_c588 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc001_77_8_c589,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc043_77_4_c588 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc043_77_4_c589,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_77_c588 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => final_score_77_c589,
    rv_d31_bk_filing_count > 0.5                                    => -0.0365075532,
    rv_d31_bk_filing_count = NULL                                   => -0.0037731773,
                                                                       -0.0037731773);

rc002_77_3_c588 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc002_77_3_c589,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc034_77_2 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc034_77_2_c588,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc034_77_2_1,
    rv_d31_mostrec_bk = ''                                         => rc034_77_2_1,
                                                                        rc034_77_2_1);

rc001_77_8 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc001_77_8_c588,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc001_77_8_1,
    rv_d31_mostrec_bk = ''                                        => rc001_77_8_1,
                                                                        rc001_77_8_1);

rc043_77_4 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc043_77_4_c588,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc043_77_4_1,
    rv_d31_mostrec_bk = ''                                         => rc043_77_4_1,
                                                                        rc043_77_4_1);

rc035_77_1 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0668254643,
    rv_d31_mostrec_bk = ''                                        => 0.0043861167,
                                                                        rc035_77_1_1);

rc002_77_3 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc002_77_3_c588,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc002_77_3_1,
    rv_d31_mostrec_bk = ''                                        => rc002_77_3_1,
                                                                        rc002_77_3_1);

final_score_77 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_77_c588,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0633901998,
    rv_d31_mostrec_bk = ''                                        => 0.0009508522,
                                                                        -0.0034352645);

final_score_78_c595 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => -0.0040894313,
    rv_c21_stl_inq_count > 0.5                                  => 0.0264308836,
    rv_c21_stl_inq_count = NULL                                 => -0.0031098027,
                                                                   -0.0031098027);

rc046_78_7_c595 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => 0.0000000000,
    rv_c21_stl_inq_count > 0.5                                  => 0.0295406864,
    rv_c21_stl_inq_count = NULL                                 => 0.0000000000,
                                                                   NULL);

rc046_78_7_c594 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 10.5 => 0.0000000000,
    iv_bureau_emergence_age_buronly > 10.5                                             => 0.0000000000,
    iv_bureau_emergence_age_buronly = NULL                                             => rc046_78_7_c595,
                                                                                          NULL);

final_score_78_c594 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 10.5 => 0.0468171606,
    iv_bureau_emergence_age_buronly > 10.5                                             => 0.0040714766,
    iv_bureau_emergence_age_buronly = NULL                                             => final_score_78_c595,
                                                                                          -0.0019744668);

rc033_78_4_c594 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 10.5 => 0.0487916273,
    iv_bureau_emergence_age_buronly > 10.5                                             => 0.0060459434,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0000000000,
                                                                                          NULL);

rc033_78_11_c596 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 19.5 => 0.0266497344,
    iv_bureau_emergence_age_buronly > 19.5                                             => 0.0000000000,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0060044998,
                                                                                          NULL);

final_score_78_c596 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 19.5 => 0.0307344064,
    iv_bureau_emergence_age_buronly > 19.5                                             => -0.0272635025,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0100891717,
                                                                                          0.0040846720);

rc046_78_7_c593 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0000000000,
    rv_f00_ssn_score > 95                              => rc046_78_7_c594,
    rv_f00_ssn_score = NULL                            => 0.0000000000,
                                                          NULL);

rc033_78_4_c593 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0000000000,
    rv_f00_ssn_score > 95                              => rc033_78_4_c594,
    rv_f00_ssn_score = NULL                            => 0.0000000000,
                                                          NULL);

rc031_78_2_c593 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0294579928,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0052206447,
                                                          NULL);

final_score_78_c593 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0283220200,
    rv_f00_ssn_score > 95                              => final_score_78_c594,
    rv_f00_ssn_score = NULL                            => final_score_78_c596,
                                                          -0.0011359727);

rc033_78_11_c593 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0000000000,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => rc033_78_11_c596,
                                                          NULL);

rc031_78_2 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc031_78_2_c593,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc031_78_2_1,
    rv_p85_phn_risk_level = ''                                              => rc031_78_2_1,
                                                                                 rc031_78_2_1);

rc033_78_4 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc033_78_4_c593,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc033_78_4_1,
    rv_p85_phn_risk_level = ''                                              => rc033_78_4_1,
                                                                                 rc033_78_4_1);

rc033_78_11 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc033_78_11_c593,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc033_78_11_1,
    rv_p85_phn_risk_level = ''                                              => rc033_78_11_1,
                                                                                 rc033_78_11_1);

final_score_78 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => final_score_78_c593,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0311742540,
    rv_p85_phn_risk_level = ''                                             => -0.0072550174,
                                                                                 -0.0007844349);

rc046_78_7 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc046_78_7_c593,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => rc046_78_7_1,
    rv_p85_phn_risk_level = ''                                              => rc046_78_7_1,
                                                                                 rc046_78_7_1);

rc038_78_1 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0319586889,
    rv_p85_phn_risk_level = ''                                              => 0.0000000000,
                                                                                 rc038_78_1_1);

final_score_79_c600 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => -0.0065843242,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0205712960,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0057769245,
                                                                           -0.0057769245);

rc037_79_4_c600 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0263482205,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc040_79_8_c601 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 262.5 => 0.0049057416,
    rv_c20_m_bureau_adl_fs > 262.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

final_score_79_c601 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 262.5 => 0.0086689704,
    rv_c20_m_bureau_adl_fs > 262.5                                    => -0.0113118238,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0037632288,
                                                                         0.0037632288);

rc040_79_8_c599 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => rc040_79_8_c601,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_79_c599 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_79_c600,
    rv_s66_adlperssn_count > 1.5                                    => final_score_79_c601,
    rv_s66_adlperssn_count = NULL                                   => 0.0020711039,
                                                                       -0.0020320111);

rc018_79_3_c599 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0057952399,
    rv_s66_adlperssn_count = NULL                                   => 0.0041031150,
                                                                       NULL);

rc037_79_4_c599 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc037_79_4_c600,
    rv_s66_adlperssn_count > 1.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_79_c598 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => final_score_79_c599,
    rv_c19_add_prison_hist > 0.5                                    => 0.1010155629,
    rv_c19_add_prison_hist = NULL                                   => -0.0019032057,
                                                                       -0.0019032057);

rc045_79_2_c598 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0000000000,
    rv_c19_add_prison_hist > 0.5                                    => 0.1029187686,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc040_79_8_c598 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc040_79_8_c599,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc037_79_4_c598 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc037_79_4_c599,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc018_79_3_c598 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc018_79_3_c599,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc019_79_1 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 1.5                                          => 0.0241450637,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0033537704,
                                                                                   rc019_79_1_1);

final_score_79 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => final_score_79_c598,
    rv_d32_criminal_behavior_lvl > 1.5                                          => 0.0230148297,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0022235364,
                                                                                   -0.0011302340);

rc045_79_2 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => rc045_79_2_c598,
    rv_d32_criminal_behavior_lvl > 1.5                                          => rc045_79_2_1,
    rv_d32_criminal_behavior_lvl = NULL                                         => rc045_79_2_1,
                                                                                   rc045_79_2_1);

rc040_79_8 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => rc040_79_8_c598,
    rv_d32_criminal_behavior_lvl > 1.5                                          => rc040_79_8_1,
    rv_d32_criminal_behavior_lvl = NULL                                         => rc040_79_8_1,
                                                                                   rc040_79_8_1);

rc037_79_4 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => rc037_79_4_c598,
    rv_d32_criminal_behavior_lvl > 1.5                                          => rc037_79_4_1,
    rv_d32_criminal_behavior_lvl = NULL                                         => rc037_79_4_1,
                                                                                   rc037_79_4_1);

rc018_79_3 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 1.5 => rc018_79_3_c598,
    rv_d32_criminal_behavior_lvl > 1.5                                          => rc018_79_3_1,
    rv_d32_criminal_behavior_lvl = NULL                                         => rc018_79_3_1,
                                                                                   rc018_79_3_1);

rc027_80_6_c606 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => 0.0095796502,
    iv_prv_addr_lres > 3.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0005081683,
                                                           NULL);

final_score_80_c606 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => 0.0080756833,
    iv_prv_addr_lres > 3.5                              => -0.0042107720,
    iv_prv_addr_lres = NULL                             => -0.0009957986,
                                                           -0.0015039668);

rc022_80_4_c605 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 51.5 => 0.0189218624,
    rv_d32_mos_since_crim_ls > 51.5                                      => 0.0000000000,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

final_score_80_c605 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 51.5 => 0.0180727139,
    rv_d32_mos_since_crim_ls > 51.5                                      => final_score_80_c606,
    rv_d32_mos_since_crim_ls = NULL                                      => -0.0008491486,
                                                                            -0.0008491486);

rc027_80_6_c605 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 51.5 => 0.0000000000,
    rv_d32_mos_since_crim_ls > 51.5                                      => rc027_80_6_c606,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

rc027_80_6_c604 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc027_80_6_c605,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_80_c604 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_80_c605,
    iv_br_source_count > 0.5                                => -0.0252037734,
    iv_br_source_count = NULL                               => -0.0035929188,
                                                               -0.0035929188);

rc016_80_3_c604 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0027437702,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc022_80_4_c604 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc022_80_4_c605,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_80_c603 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => final_score_80_c604,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0172939171,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0029071079,
                                                                           -0.0029071079);

rc037_80_2_c603 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0202010249,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc027_80_6_c603 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc027_80_6_c604,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0000000000,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc016_80_3_c603 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc016_80_3_c604,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0000000000,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc022_80_4_c603 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc022_80_4_c604,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0000000000,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc037_80_2 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc037_80_2_c603,
    rv_email_domain_free_count > 2.5                                        => rc037_80_2_1,
    rv_email_domain_free_count = NULL                                       => rc037_80_2_1,
                                                                               rc037_80_2_1);

rc027_80_6 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc027_80_6_c603,
    rv_email_domain_free_count > 2.5                                        => rc027_80_6_1,
    rv_email_domain_free_count = NULL                                       => rc027_80_6_1,
                                                                               rc027_80_6_1);

final_score_80 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => final_score_80_c603,
    rv_email_domain_free_count > 2.5                                        => 0.0162738756,
    rv_email_domain_free_count = NULL                                       => 0.0009555102,
                                                                               -0.0018361122);

rc022_80_4 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc022_80_4_c603,
    rv_email_domain_free_count > 2.5                                        => rc022_80_4_1,
    rv_email_domain_free_count = NULL                                       => rc022_80_4_1,
                                                                               rc022_80_4_1);

rc016_80_3 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => rc016_80_3_c603,
    rv_email_domain_free_count > 2.5                                        => rc016_80_3_1,
    rv_email_domain_free_count = NULL                                       => rc016_80_3_1,
                                                                               rc016_80_3_1);

rc013_80_1 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 2.5 => 0.0000000000,
    rv_email_domain_free_count > 2.5                                        => 0.0181099877,
    rv_email_domain_free_count = NULL                                       => 0.0027916223,
                                                                               rc013_80_1_1);

final_score_81_c611 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 283.5 => 0.0091444907,
    rv_c20_m_bureau_adl_fs > 283.5                                    => -0.0111725769,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0053000784,
                                                                         0.0053000784);

rc040_81_6_c611 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 283.5 => 0.0038444123,
    rv_c20_m_bureau_adl_fs > 283.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc040_81_6_c610 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => rc040_81_6_c611,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_81_c610 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0038386206,
    iv_unverified_addr_count > 0.5                                      => final_score_81_c611,
    iv_unverified_addr_count = NULL                                     => 0.0015634942,
                                                                           0.0015634942);

rc015_81_4_c610 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0037365842,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc034_81_3_c609 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0007147177,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_81_c609 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => final_score_81_c610,
    rv_d31_bk_filing_count > 0.5                                    => -0.0293959303,
    rv_d31_bk_filing_count = NULL                                   => 0.0008487765,
                                                                       0.0008487765);

rc040_81_6_c609 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc040_81_6_c610,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc015_81_4_c609 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc015_81_4_c610,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc015_81_4_c608 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc015_81_4_c609,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc040_81_6_c608 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc040_81_6_c609,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_81_c608 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => final_score_81_c609,
    iv_input_best_phone_match > -0.5                                       => -0.0137431310,
    iv_input_best_phone_match = NULL                                       => -0.0131283868,
                                                                              -0.0028958479);

rc011_81_2_c608 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => 0.0037446244,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

rc034_81_3_c608 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= -0.5 => rc034_81_3_c609,
    iv_input_best_phone_match > -0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_81 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => final_score_81_c608,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0155708840,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0001161613,
                                                                           -0.0016951345);

rc040_81_6 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc040_81_6_c608,
    rv_i62_inq_addrs_per_adl > 0.5                                      => rc040_81_6_1,
    rv_i62_inq_addrs_per_adl = NULL                                     => rc040_81_6_1,
                                                                           rc040_81_6_1);

rc020_81_1 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => 0.0000000000,
    rv_i62_inq_addrs_per_adl > 0.5                                      => 0.0172660184,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0018112958,
                                                                           rc020_81_1_1);

rc034_81_3 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc034_81_3_c608,
    rv_i62_inq_addrs_per_adl > 0.5                                      => rc034_81_3_1,
    rv_i62_inq_addrs_per_adl = NULL                                     => rc034_81_3_1,
                                                                           rc034_81_3_1);

rc011_81_2 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc011_81_2_c608,
    rv_i62_inq_addrs_per_adl > 0.5                                      => rc011_81_2_1,
    rv_i62_inq_addrs_per_adl = NULL                                     => rc011_81_2_1,
                                                                           rc011_81_2_1);

rc015_81_4 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 0.5 => rc015_81_4_c608,
    rv_i62_inq_addrs_per_adl > 0.5                                      => rc015_81_4_1,
    rv_i62_inq_addrs_per_adl = NULL                                     => rc015_81_4_1,
                                                                           rc015_81_4_1);

rc032_82_3_c614 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0192724215,
    rv_f00_input_dob_match_level > 6.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_82_c614 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0199470842,
    rv_f00_input_dob_match_level > 6.5                                          => -0.0017952790,
    rv_f00_input_dob_match_level = NULL                                         => -0.0271675995,
                                                                                   0.0006746627);

final_score_82_c613 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => final_score_82_c614,
    rv_email_domain_free_count > 0.5                                        => 0.0251906242,
    rv_email_domain_free_count = NULL                                       => 0.0103614572,
                                                                               0.0103614572);

rc032_82_3_c613 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => rc032_82_3_c614,
    rv_email_domain_free_count > 0.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc013_82_2_c613 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0148291670,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_82_c616 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => -0.0117823698,
    rv_d30_derog_count > 1.5                                => 0.0141079415,
    rv_d30_derog_count = NULL                               => -0.0097112456,
                                                               -0.0097112456);

rc001_82_11_c616 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 1.5 => 0.0000000000,
    rv_d30_derog_count > 1.5                                => 0.0238191871,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc026_82_9_c615 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.65 => 0.0229904646,
    rv_a49_curr_avm_chg_1yr_pct > 53.65                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0029614254,
                                                                                   NULL);

rc001_82_11_c615 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.65 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 53.65                                         => rc001_82_11_c616,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0000000000,
                                                                                   NULL);

final_score_82_c615 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 53.65 => 0.0200897378,
    rv_a49_curr_avm_chg_1yr_pct > 53.65                                         => final_score_82_c616,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0000606986,
                                                                                   -0.0029007268);

rc032_82_3 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc032_82_3_c613,
    iv_header_emergence_age > 17.5                                     => rc032_82_3_1,
    iv_header_emergence_age = NULL                                     => rc032_82_3_1,
                                                                          rc032_82_3_1);

final_score_82 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => final_score_82_c613,
    iv_header_emergence_age > 17.5                                     => final_score_82_c615,
    iv_header_emergence_age = NULL                                     => 0.0002214993,
                                                                          -0.0011609990);

rc025_82_1 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => 0.0115224562,
    iv_header_emergence_age > 17.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0013824983,
                                                                          rc025_82_1_1);

rc026_82_9 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc026_82_9_1,
    iv_header_emergence_age > 17.5                                     => rc026_82_9_c615,
    iv_header_emergence_age = NULL                                     => rc026_82_9_1,
                                                                          rc026_82_9_1);

rc001_82_11 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc001_82_11_1,
    iv_header_emergence_age > 17.5                                     => rc001_82_11_c615,
    iv_header_emergence_age = NULL                                     => rc001_82_11_1,
                                                                          rc001_82_11_1);

rc013_82_2 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc013_82_2_c613,
    iv_header_emergence_age > 17.5                                     => rc013_82_2_1,
    iv_header_emergence_age = NULL                                     => rc013_82_2_1,
                                                                          rc013_82_2_1);

rc041_83_4_c620 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0006373051,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0160227577,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_83_c620 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => -0.0028691192,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0125163334,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.0087722312,
                                                                           -0.0035064243);

final_score_83_c619 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => final_score_83_c620,
    rv_d31_bk_filing_count > 0.5                                    => -0.0374863710,
    rv_d31_bk_filing_count = NULL                                   => -0.0042278056,
                                                                       -0.0042278056);

rc034_83_3_c619 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0007213813,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc041_83_4_c619 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc041_83_4_c620,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc041_83_4_c618 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc041_83_4_c619,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0000000000,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

rc035_83_2_c618 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0699525580,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

final_score_83_c618 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_83_c619,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0659195448,
    rv_d31_mostrec_bk = ''                                         => -0.0090362858,
                                                                        -0.0040330132);

rc034_83_3_c618 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc034_83_3_c619,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0000000000,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

rc039_83_13_c621 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 0.5 => 0.0000000000,
    rv_c14_addrs_10yr > 0.5                               => 0.0024454498,
    rv_c14_addrs_10yr = NULL                              => 0.0156602169,
                                                             NULL);

final_score_83_c621 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 0.5 => -0.0546435363,
    rv_c14_addrs_10yr > 0.5                               => 0.0119281284,
    rv_c14_addrs_10yr = NULL                              => 0.0251428954,
                                                             0.0094826786);

rc035_83_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc035_83_2_c618,
    rv_s66_adlperssn_count > 2.5                                    => rc035_83_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc035_83_2_1,
                                                                       rc035_83_2_1);

final_score_83 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => final_score_83_c618,
    rv_s66_adlperssn_count > 2.5                                    => 0.0111712458,
    rv_s66_adlperssn_count = NULL                                   => final_score_83_c621,
                                                                       -0.0020019006);

rc018_83_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => 0.0000000000,
    rv_s66_adlperssn_count > 2.5                                    => 0.0131731464,
    rv_s66_adlperssn_count = NULL                                   => 0.0114845792,
                                                                       rc018_83_1_1);

rc034_83_3 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc034_83_3_c618,
    rv_s66_adlperssn_count > 2.5                                    => rc034_83_3_1,
    rv_s66_adlperssn_count = NULL                                   => rc034_83_3_1,
                                                                       rc034_83_3_1);

rc039_83_13 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc039_83_13_1,
    rv_s66_adlperssn_count > 2.5                                    => rc039_83_13_1,
    rv_s66_adlperssn_count = NULL                                   => rc039_83_13_c621,
                                                                       rc039_83_13_1);

rc041_83_4 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 2.5 => rc041_83_4_c618,
    rv_s66_adlperssn_count > 2.5                                    => rc041_83_4_1,
    rv_s66_adlperssn_count = NULL                                   => rc041_83_4_1,
                                                                       rc041_83_4_1);

rc005_84_4_c625 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => 0.0000000000,
    iv_college_tier > 3                             => 0.0064227077,
    iv_college_tier = NULL                          => 0.0000000000,
                                                       NULL);

final_score_84_c625 := map(
    NULL < iv_college_tier AND iv_college_tier <= 3 => -0.0510702473,
    iv_college_tier > 3                             => -0.0035048504,
    iv_college_tier = NULL                          => -0.0099275581,
                                                       -0.0099275581);

rc005_84_4_c624 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 0.5 => rc005_84_4_c625,
    rv_i62_inq_num_names_per_adl > 0.5                                          => 0.0000000000,
    rv_i62_inq_num_names_per_adl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_84_c624 := map(
    NULL < rv_i62_inq_num_names_per_adl AND rv_i62_inq_num_names_per_adl <= 0.5 => final_score_84_c625,
    rv_i62_inq_num_names_per_adl > 0.5                                          => 0.0205725433,
    rv_i62_inq_num_names_per_adl = NULL                                         => -0.0084954447,
                                                                                   -0.0084954447);

rc005_84_4_c623 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => rc005_84_4_c624,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_84_c623 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => final_score_84_c624,
    rv_d30_derog_count > 0.5                                => 0.0061543764,
    rv_d30_derog_count = NULL                               => -0.0164922446,
                                                               -0.0056394243);

rc001_84_2_c623 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0117938007,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

rc025_84_13_c626 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 33.5 => 0.0030622540,
    iv_header_emergence_age > 33.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0238853179,
                                                                          NULL);

final_score_84_c626 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 33.5 => 0.0134544851,
    iv_header_emergence_age > 33.5                                     => -0.0375244183,
    iv_header_emergence_age = NULL                                     => 0.0342775489,
                                                                          0.0103922310);

rc005_84_4 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc005_84_4_c623,
    rv_s66_adlperssn_count > 3.5                                    => rc005_84_4_1,
    rv_s66_adlperssn_count = NULL                                   => rc005_84_4_1,
                                                                       rc005_84_4_1);

rc025_84_13 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc025_84_13_1,
    rv_s66_adlperssn_count > 3.5                                    => rc025_84_13_1,
    rv_s66_adlperssn_count = NULL                                   => rc025_84_13_c626,
                                                                       rc025_84_13_1);

rc018_84_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => 0.0000000000,
    rv_s66_adlperssn_count > 3.5                                    => 0.0287200405,
    rv_s66_adlperssn_count = NULL                                   => 0.0147109404,
                                                                       rc018_84_1_1);

rc001_84_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc001_84_2_c623,
    rv_s66_adlperssn_count > 3.5                                    => rc001_84_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc001_84_2_1,
                                                                       rc001_84_2_1);

final_score_84 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => final_score_84_c623,
    rv_s66_adlperssn_count > 3.5                                    => 0.0244013311,
    rv_s66_adlperssn_count = NULL                                   => final_score_84_c626,
                                                                       -0.0043187094);

rc044_85_7_c631 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => 0.0144149691,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

final_score_85_c631 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => -0.0128267598,
    iv_addr_bureau_only > 0.5                                 => 0.0074361507,
    iv_addr_bureau_only = NULL                                => -0.0069788184,
                                                                 -0.0069788184);

rc044_85_7_c630 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => rc044_85_7_c631,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

rc041_85_6_c630 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0292555329,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_85_c630 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => final_score_85_c631,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0229808800,
    rv_l79_adls_per_sfd_addr = NULL                                     => -0.0107591938,
                                                                           -0.0062746530);

rc028_85_4_c629 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0109429298,
    iv_bureau_verification_index > 9.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc044_85_7_c629 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0000000000,
    iv_bureau_verification_index > 9.5                                          => rc044_85_7_c630,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc041_85_6_c629 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0000000000,
    iv_bureau_verification_index > 9.5                                          => rc041_85_6_c630,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_85_c629 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0066630768,
    iv_bureau_verification_index > 9.5                                          => final_score_85_c630,
    iv_bureau_verification_index = NULL                                         => -0.0269949559,
                                                                                   -0.0042798530);

rc014_85_2_c628 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0096084995,
    rv_comb_age > 21.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_85_c628 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0064727851,
    rv_comb_age > 21.5                         => final_score_85_c629,
    rv_comb_age = NULL                         => -0.1100565926,
                                                  -0.0031357145);

rc028_85_4_c628 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0000000000,
    rv_comb_age > 21.5                         => rc028_85_4_c629,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc044_85_7_c628 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0000000000,
    rv_comb_age > 21.5                         => rc044_85_7_c629,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc041_85_6_c628 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0000000000,
    rv_comb_age > 21.5                         => rc041_85_6_c629,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc041_85_6 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc041_85_6_c628,
    rv_s66_adlperssn_count > 3.5                                    => rc041_85_6_1,
    rv_s66_adlperssn_count = NULL                                   => rc041_85_6_1,
                                                                       rc041_85_6_1);

rc044_85_7 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc044_85_7_c628,
    rv_s66_adlperssn_count > 3.5                                    => rc044_85_7_1,
    rv_s66_adlperssn_count = NULL                                   => rc044_85_7_1,
                                                                       rc044_85_7_1);

rc028_85_4 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc028_85_4_c628,
    rv_s66_adlperssn_count > 3.5                                    => rc028_85_4_1,
    rv_s66_adlperssn_count = NULL                                   => rc028_85_4_1,
                                                                       rc028_85_4_1);

rc018_85_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => 0.0000000000,
    rv_s66_adlperssn_count > 3.5                                    => 0.0242868452,
    rv_s66_adlperssn_count = NULL                                   => 0.0097871104,
                                                                       rc018_85_1_1);

final_score_85 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => final_score_85_c628,
    rv_s66_adlperssn_count > 3.5                                    => 0.0221694191,
    rv_s66_adlperssn_count = NULL                                   => 0.0076696843,
                                                                       -0.0021174261);

rc014_85_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc014_85_2_c628,
    rv_s66_adlperssn_count > 3.5                                    => rc014_85_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc014_85_2_1,
                                                                       rc014_85_2_1);

rc025_86_5_c634 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 30.5 => 0.0122905598,
    iv_header_emergence_age > 30.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

final_score_86_c634 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 30.5 => 0.0184371599,
    iv_header_emergence_age > 30.5                                     => -0.0354405168,
    iv_header_emergence_age = NULL                                     => 0.0061466001,
                                                                          0.0061466001);

final_score_86_c633 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => -0.0073428571,
    rv_s66_adlperssn_count > 1.5                                    => 0.0030787267,
    rv_s66_adlperssn_count = NULL                                   => final_score_86_c634,
                                                                       -0.0035550731);

rc018_86_2_c633 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0066337998,
    rv_s66_adlperssn_count = NULL                                   => 0.0097016732,
                                                                       NULL);

rc025_86_5_c633 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0000000000,
    rv_s66_adlperssn_count = NULL                                   => rc025_86_5_c634,
                                                                       NULL);

rc017_86_11_c636 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 1.5 => 0.0471439083,
    iv_c13_avg_lres > 1.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_86_c636 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 1.5 => 0.0498205064,
    iv_c13_avg_lres > 1.5                             => 0.0018501875,
    iv_c13_avg_lres = NULL                            => 0.0026765981,
                                                         0.0026765981);

rc017_86_11_c635 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0000000000,
    iv_source_type > 4.5                            => rc017_86_11_c636,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_86_c635 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0200476799,
    iv_source_type > 4.5                            => final_score_86_c636,
    iv_source_type = NULL                           => 0.0054961530,
                                                       0.0054961530);

rc023_86_9_c635 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0145515269,
    iv_source_type > 4.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

rc025_86_5 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => rc025_86_5_c633,
    iv_unverified_addr_count > 1.5                                      => rc025_86_5_1,
    iv_unverified_addr_count = NULL                                     => rc025_86_5_1,
                                                                           rc025_86_5_1);

rc018_86_2 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => rc018_86_2_c633,
    iv_unverified_addr_count > 1.5                                      => rc018_86_2_1,
    iv_unverified_addr_count = NULL                                     => rc018_86_2_1,
                                                                           rc018_86_2_1);

rc017_86_11 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => rc017_86_11_1,
    iv_unverified_addr_count > 1.5                                      => rc017_86_11_c635,
    iv_unverified_addr_count = NULL                                     => rc017_86_11_1,
                                                                           rc017_86_11_1);

rc015_86_1 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0055373475,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           rc015_86_1_1);

rc023_86_9 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => rc023_86_9_1,
    iv_unverified_addr_count > 1.5                                      => rc023_86_9_c635,
    iv_unverified_addr_count = NULL                                     => rc023_86_9_1,
                                                                           rc023_86_9_1);

final_score_86 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => final_score_86_c633,
    iv_unverified_addr_count > 1.5                                      => final_score_86_c635,
    iv_unverified_addr_count = NULL                                     => -0.0036934577,
                                                                           -0.0000411945);

rc015_87_3_c639 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => 0.0000000000,
    iv_unverified_addr_count > 2.5                                      => 0.0265146591,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_87_c639 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => 0.0045617820,
    iv_unverified_addr_count > 2.5                                      => 0.0331161438,
    iv_unverified_addr_count = NULL                                     => 0.0066014847,
                                                                           0.0066014847);

final_score_87_c641 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0227780210,
    rv_f00_ssn_score > 95                              => -0.0019659222,
    rv_f00_ssn_score = NULL                            => 0.0184241676,
                                                          -0.0012347300);

rc031_87_8_c641 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0240127510,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0196588976,
                                                          NULL);

rc031_87_8_c640 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc031_87_8_c641,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_87_c640 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => final_score_87_c641,
    rv_d31_bk_filing_count > 0.5                                    => -0.0304136738,
    rv_d31_bk_filing_count = NULL                                   => -0.0019507435,
                                                                       -0.0019507435);

rc034_87_7_c640 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0007160135,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc034_87_7_c638 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 6.5                                          => rc034_87_7_c640,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc032_87_2_c638 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0075567094,
    rv_f00_input_dob_match_level > 6.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_87_c638 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => final_score_87_c639,
    rv_f00_input_dob_match_level > 6.5                                          => final_score_87_c640,
    rv_f00_input_dob_match_level = NULL                                         => -0.0156129265,
                                                                                   -0.0009552247);

rc015_87_3_c638 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => rc015_87_3_c639,
    rv_f00_input_dob_match_level > 6.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc031_87_8_c638 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0000000000,
    rv_f00_input_dob_match_level > 6.5                                          => rc031_87_8_c640,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_87 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_87_c638,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0587378215,
    rv_d31_mostrec_bk = ''                                         => 0.0076229209,
                                                                        -0.0005978033);

rc015_87_3 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc015_87_3_c638,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc015_87_3_1,
    rv_d31_mostrec_bk = ''                                         => rc015_87_3_1,
                                                                        rc015_87_3_1);

rc031_87_8 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc031_87_8_c638,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc031_87_8_1,
    rv_d31_mostrec_bk = ''                                         => rc031_87_8_1,
                                                                        rc031_87_8_1);

rc035_87_1 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0593356248,
    rv_d31_mostrec_bk = ''                                         => 0.0082207241,
                                                                        rc035_87_1_1);

rc032_87_2 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc032_87_2_c638,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc032_87_2_1,
    rv_d31_mostrec_bk = ''                                         => rc032_87_2_1,
                                                                        rc032_87_2_1);

rc034_87_7 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc034_87_7_c638,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc034_87_7_1,
    rv_d31_mostrec_bk = ''                                         => rc034_87_7_1,
                                                                        rc034_87_7_1);

rc048_88_3_c644 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => 0.0000000000,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0382238116,
    rv_l72_add_curr_vacant = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_88_c644 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => 0.0028021755,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0420007575,
    rv_l72_add_curr_vacant = NULL                                   => 0.0037769459,
                                                                       0.0037769459);

final_score_88_c646 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0326432182,
    rv_comb_age > 21.5                         => -0.0193691670,
    rv_comb_age = NULL                         => -0.0144087532,
                                                  -0.0144087532);

rc014_88_10_c646 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0470519714,
    rv_comb_age > 21.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc014_88_10_c645 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => rc014_88_10_c646,
                                                                           NULL);

rc041_88_7_c645 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0002132056,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0201342558,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_88_c645 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => -0.0064377270,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0134833231,
    rv_l79_adls_per_sfd_addr = NULL                                     => final_score_88_c646,
                                                                           -0.0066509327);

rc021_88_2_c643 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0076540700,
    rv_f01_inp_addr_address_score > 95                                           => 0.0000000000,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0000000000,
                                                                                    NULL);

final_score_88_c643 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => final_score_88_c644,
    rv_f01_inp_addr_address_score > 95                                           => final_score_88_c645,
    rv_f01_inp_addr_address_score = NULL                                         => -0.0038771241,
                                                                                    -0.0038771241);

rc014_88_10_c643 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0000000000,
    rv_f01_inp_addr_address_score > 95                                           => rc014_88_10_c645,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0000000000,
                                                                                    NULL);

rc041_88_7_c643 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => 0.0000000000,
    rv_f01_inp_addr_address_score > 95                                           => rc041_88_7_c645,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0000000000,
                                                                                    NULL);

rc048_88_3_c643 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score <= 95 => rc048_88_3_c644,
    rv_f01_inp_addr_address_score > 95                                           => 0.0000000000,
    rv_f01_inp_addr_address_score = NULL                                         => 0.0000000000,
                                                                                    NULL);

rc013_88_1 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => 0.0000000000,
    rv_email_domain_free_count > 1.5                                        => 0.0124818013,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               rc013_88_1_1);

rc048_88_3 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc048_88_3_c643,
    rv_email_domain_free_count > 1.5                                        => rc048_88_3_1,
    rv_email_domain_free_count = NULL                                       => rc048_88_3_1,
                                                                               rc048_88_3_1);

rc041_88_7 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc041_88_7_c643,
    rv_email_domain_free_count > 1.5                                        => rc041_88_7_1,
    rv_email_domain_free_count = NULL                                       => rc041_88_7_1,
                                                                               rc041_88_7_1);

rc014_88_10 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc014_88_10_c643,
    rv_email_domain_free_count > 1.5                                        => rc014_88_10_1,
    rv_email_domain_free_count = NULL                                       => rc014_88_10_1,
                                                                               rc014_88_10_1);

final_score_88 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => final_score_88_c643,
    rv_email_domain_free_count > 1.5                                        => 0.0104506335,
    rv_email_domain_free_count = NULL                                       => -0.0048139224,
                                                                               -0.0020311678);

rc021_88_2 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 1.5 => rc021_88_2_c643,
    rv_email_domain_free_count > 1.5                                        => rc021_88_2_1,
    rv_email_domain_free_count = NULL                                       => rc021_88_2_1,
                                                                               rc021_88_2_1);

rc023_89_5_c650 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0103814147,
    iv_source_type > 4.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

final_score_89_c650 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0203844209,
    iv_source_type > 4.5                            => 0.0073407894,
    iv_source_type = NULL                           => 0.0100030062,
                                                       0.0100030062);

rc015_89_3_c649 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0069633640,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc023_89_5_c649 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => rc023_89_5_c650,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_89_c649 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => -0.0001851570,
    iv_unverified_addr_count > 1.5                                      => final_score_89_c650,
    iv_unverified_addr_count = NULL                                     => 0.0030396422,
                                                                           0.0030396422);

rc040_89_2_c648 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 271.5 => 0.0026936735,
    rv_c20_m_bureau_adl_fs > 271.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc015_89_3_c648 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 271.5 => rc015_89_3_c649,
    rv_c20_m_bureau_adl_fs > 271.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc023_89_5_c648 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 271.5 => rc023_89_5_c649,
    rv_c20_m_bureau_adl_fs > 271.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

final_score_89_c648 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 271.5 => final_score_89_c649,
    rv_c20_m_bureau_adl_fs > 271.5                                    => -0.0121383969,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0003459687,
                                                                         0.0003459687);

rc001_89_12_c651 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => 0.0000000000,
    rv_d30_derog_count > 4.5                                => 0.1404285113,
    rv_d30_derog_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_89_c651 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 4.5 => -0.0351957775,
    rv_d30_derog_count > 4.5                                => 0.1063186074,
    rv_d30_derog_count = NULL                               => -0.0341099039,
                                                               -0.0341099039);

final_score_89 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => final_score_89_c648,
    iv_college_code > 3                             => final_score_89_c651,
    iv_college_code = NULL                          => -0.0060230266,
                                                       -0.0026840111);

rc001_89_12 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc001_89_12_1,
    iv_college_code > 3                             => rc001_89_12_c651,
    iv_college_code = NULL                          => rc001_89_12_1,
                                                       rc001_89_12_1);

rc029_89_1 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => 0.0030299797,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       rc029_89_1_1);

rc015_89_3 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc015_89_3_c648,
    iv_college_code > 3                             => rc015_89_3_1,
    iv_college_code = NULL                          => rc015_89_3_1,
                                                       rc015_89_3_1);

rc023_89_5 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc023_89_5_c648,
    iv_college_code > 3                             => rc023_89_5_1,
    iv_college_code = NULL                          => rc023_89_5_1,
                                                       rc023_89_5_1);

rc040_89_2 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => rc040_89_2_c648,
    iv_college_code > 3                             => rc040_89_2_1,
    iv_college_code = NULL                          => rc040_89_2_1,
                                                       rc040_89_2_1);

rc030_90_2_c653 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 65 => 0.0622013195,
    rv_f00_dob_score > 65                              => 0.0032146137,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_90_c653 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 65 => 0.0733429472,
    rv_f00_dob_score > 65                              => 0.0143562414,
    rv_f00_dob_score = NULL                            => -0.0135505478,
                                                          0.0111416277);

final_score_90_c656 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => 0.0017525581,
    iv_input_best_phone_match > 0.5                                       => -0.0400513614,
    iv_input_best_phone_match = NULL                                      => -0.0055703840,
                                                                             -0.0007368593);

rc011_90_10_c656 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => 0.0024894174,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_90_c655 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => final_score_90_c656,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0205852133,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0001378106,
                                                                           0.0001378106);

rc037_90_9_c655 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0204474027,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc011_90_10_c655 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc011_90_10_c656,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0000000000,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc011_90_10_c654 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 73.55 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 73.55                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc011_90_10_c655,
                                                                                   NULL);

rc037_90_9_c654 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 73.55 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 73.55                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc037_90_9_c655,
                                                                                   NULL);

final_score_90_c654 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 73.55 => 0.0069725514,
    rv_a49_curr_avm_chg_1yr_pct > 73.55                                         => -0.0109181581,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_90_c655,
                                                                                   -0.0025514388);

rc026_90_6_c654 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 73.55 => 0.0095239903,
    rv_a49_curr_avm_chg_1yr_pct > 73.55                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0026892495,
                                                                                   NULL);

rc026_90_6 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc026_90_6_1,
    iv_header_emergence_age > 17.5                                     => rc026_90_6_c654,
    iv_header_emergence_age = NULL                                     => rc026_90_6_1,
                                                                          rc026_90_6_1);

final_score_90 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => final_score_90_c653,
    iv_header_emergence_age > 17.5                                     => final_score_90_c654,
    iv_header_emergence_age = NULL                                     => 0.0046682306,
                                                                          -0.0006697791);

rc025_90_1 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => 0.0118114068,
    iv_header_emergence_age > 17.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0053380097,
                                                                          rc025_90_1_1);

rc037_90_9 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc037_90_9_1,
    iv_header_emergence_age > 17.5                                     => rc037_90_9_c654,
    iv_header_emergence_age = NULL                                     => rc037_90_9_1,
                                                                          rc037_90_9_1);

rc030_90_2 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc030_90_2_c653,
    iv_header_emergence_age > 17.5                                     => rc030_90_2_1,
    iv_header_emergence_age = NULL                                     => rc030_90_2_1,
                                                                          rc030_90_2_1);

rc011_90_10 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 17.5 => rc011_90_10_1,
    iv_header_emergence_age > 17.5                                     => rc011_90_10_c654,
    iv_header_emergence_age = NULL                                     => rc011_90_10_1,
                                                                          rc011_90_10_1);

rc029_91_7_c661 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => 0.0026843686,
    iv_college_code > 3                             => 0.0000000000,
    iv_college_code = NULL                          => 0.0000000000,
                                                       NULL);

final_score_91_c661 := map(
    NULL < iv_college_code AND iv_college_code <= 3 => 0.0013791118,
    iv_college_code > 3                             => -0.0297059592,
    iv_college_code = NULL                          => -0.0013052568,
                                                       -0.0013052568);

rc047_91_6_c660 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => 0.0014636434,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc029_91_7_c660 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc029_91_7_c661,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_91_c660 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => final_score_91_c661,
    iv_prof_license_category > 0.5                                      => -0.0294795109,
    iv_prof_license_category = NULL                                     => -0.0027689003,
                                                                           -0.0027689003);

rc047_91_6_c659 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0000000000,
    rv_d33_eviction_recency > 9                                     => rc047_91_6_c660,
    rv_d33_eviction_recency = NULL                                  => 0.0000000000,
                                                                       NULL);

rc029_91_7_c659 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0000000000,
    rv_d33_eviction_recency > 9                                     => rc029_91_7_c660,
    rv_d33_eviction_recency = NULL                                  => 0.0000000000,
                                                                       NULL);

rc009_91_4_c659 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0315105243,
    rv_d33_eviction_recency > 9                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                  => 0.0000000000,
                                                                       NULL);

final_score_91_c659 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 9 => 0.0290289802,
    rv_d33_eviction_recency > 9                                     => final_score_91_c660,
    rv_d33_eviction_recency = NULL                                  => -0.0024815441,
                                                                       -0.0024815441);

rc047_91_6_c658 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => 0.0000000000,
    rv_f00_dob_score > 95                              => rc047_91_6_c659,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc030_91_2_c658 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => 0.0164407232,
    rv_f00_dob_score > 95                              => 0.0001284199,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc029_91_7_c658 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => 0.0000000000,
    rv_f00_dob_score > 95                              => rc029_91_7_c659,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc009_91_4_c658 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => 0.0000000000,
    rv_f00_dob_score > 95                              => rc009_91_4_c659,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_91_c658 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 95 => 0.0138307592,
    rv_f00_dob_score > 95                              => final_score_91_c659,
    rv_f00_dob_score = NULL                            => -0.0178056546,
                                                          -0.0026099640);

rc030_91_2 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc030_91_2_c658,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc030_91_2_1,
    rv_d31_mostrec_bk = ''                                         => rc030_91_2_1,
                                                                        rc030_91_2_1);

rc029_91_7 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc029_91_7_c658,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc029_91_7_1,
    rv_d31_mostrec_bk = ''                                         => rc029_91_7_1,
                                                                        rc029_91_7_1);

rc047_91_6 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc047_91_6_c658,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc047_91_6_1,
    rv_d31_mostrec_bk = ''                                        => rc047_91_6_1,
                                                                        rc047_91_6_1);

final_score_91 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_91_c658,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0543297977,
    rv_d31_mostrec_bk = ''                                        => -0.0025608152,
                                                                        -0.0023992841);

rc035_91_1 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0567290819,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        rc035_91_1_1);

rc009_91_4 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc009_91_4_c658,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc009_91_4_1,
    rv_d31_mostrec_bk = ''                                        => rc009_91_4_1,
                                                                        rc009_91_4_1);

final_score_92_c666 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 4.5 => 0.0440107370,
    rv_d33_eviction_recency > 4.5                                     => 0.0008132312,
    rv_d33_eviction_recency = NULL                                    => 0.0010298752,
                                                                         0.0010298752);

rc009_92_6_c666 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 4.5 => 0.0429808618,
    rv_d33_eviction_recency > 4.5                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                    => 0.0000000000,
                                                                         NULL);

rc009_92_6_c665 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc009_92_6_c666,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_92_c665 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => final_score_92_c666,
    rv_d31_bk_filing_count > 0.5                                    => -0.0271725361,
    rv_d31_bk_filing_count = NULL                                   => 0.0004202243,
                                                                       0.0004202243);

rc034_92_5_c665 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0006096509,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc034_92_5_c664 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc034_92_5_c665,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0000000000,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

rc035_92_4_c664 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0553336019,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

rc009_92_6_c664 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc009_92_6_c665,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0000000000,
    rv_d31_mostrec_bk = ''                                         => 0.0000000000,
                                                                        NULL);

final_score_92_c664 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_92_c665,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0559452595,
    rv_d31_mostrec_bk = ''                                         => 0.0006116576,
                                                                        0.0006116576);

rc034_92_5_c663 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc034_92_5_c664,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc035_92_4_c663 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc035_92_4_c664,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc047_92_3_c663 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => 0.0016458350,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc009_92_6_c663 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc009_92_6_c664,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_92_c663 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => final_score_92_c664,
    iv_prof_license_category > 0.5                                      => -0.0302727862,
    iv_prof_license_category = NULL                                     => -0.0010341775,
                                                                           -0.0010341775);

rc047_92_3 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc047_92_3_1,
    rv_f00_ssn_score > 95                              => rc047_92_3_c663,
    rv_f00_ssn_score = NULL                            => rc047_92_3_1,
                                                          rc047_92_3_1);

rc035_92_4 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc035_92_4_1,
    rv_f00_ssn_score > 95                              => rc035_92_4_c663,
    rv_f00_ssn_score = NULL                            => rc035_92_4_1,
                                                          rc035_92_4_1);

final_score_92 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0273295933,
    rv_f00_ssn_score > 95                              => final_score_92_c663,
    rv_f00_ssn_score = NULL                            => -0.0036404626,
                                                          -0.0005858598);

rc009_92_6 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc009_92_6_1,
    rv_f00_ssn_score > 95                              => rc009_92_6_c663,
    rv_f00_ssn_score = NULL                            => rc009_92_6_1,
                                                          rc009_92_6_1);

rc034_92_5 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => rc034_92_5_1,
    rv_f00_ssn_score > 95                              => rc034_92_5_c663,
    rv_f00_ssn_score = NULL                            => rc034_92_5_1,
                                                          rc034_92_5_1);

rc031_92_1 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0279154531,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0000000000,
                                                          rc031_92_1_1);

final_score_93_c670 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => 0.0015102337,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0312254162,
    rv_l72_add_curr_vacant = NULL                                   => 0.0019359700,
                                                                       0.0019359700);

rc048_93_5_c670 := map(
    NULL < rv_l72_add_curr_vacant AND rv_l72_add_curr_vacant <= 0.5 => 0.0000000000,
    rv_l72_add_curr_vacant > 0.5                                    => 0.0292894462,
    rv_l72_add_curr_vacant = NULL                                   => 0.0000000000,
                                                                       NULL);

rc048_93_5_c669 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => rc048_93_5_c670,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_93_4_c669 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => 0.0027438269,
    iv_num_non_bureau_sources > 3.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_93_c669 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 3.5 => final_score_93_c670,
    iv_num_non_bureau_sources > 3.5                                       => -0.0124654802,
    iv_num_non_bureau_sources = NULL                                      => -0.0008078569,
                                                                             -0.0008078569);

final_score_93_c668 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0274747583,
    rv_f00_ssn_score > 95                              => final_score_93_c669,
    rv_f00_ssn_score = NULL                            => 0.0057542283,
                                                          -0.0000905878);

rc031_93_2_c668 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0275653461,
    rv_f00_ssn_score > 95                              => 0.0000000000,
    rv_f00_ssn_score = NULL                            => 0.0058448161,
                                                          NULL);

rc048_93_5_c668 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0000000000,
    rv_f00_ssn_score > 95                              => rc048_93_5_c669,
    rv_f00_ssn_score = NULL                            => 0.0000000000,
                                                          NULL);

rc010_93_4_c668 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score <= 95 => 0.0000000000,
    rv_f00_ssn_score > 95                              => rc010_93_4_c669,
    rv_f00_ssn_score = NULL                            => 0.0000000000,
                                                          NULL);

final_score_93_c671 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0974034120,
    rv_comb_age > 21.5                         => 0.0235890272,
    rv_comb_age = NULL                         => 0.0262233921,
                                                  0.0262233921);

rc014_93_12_c671 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0711800199,
    rv_comb_age > 21.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc048_93_5 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc048_93_5_c668,
    rv_c21_stl_inq_count > 0.5                                  => rc048_93_5_1,
    rv_c21_stl_inq_count = NULL                                 => rc048_93_5_1,
                                                                   rc048_93_5_1);

rc046_93_1 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => 0.0000000000,
    rv_c21_stl_inq_count > 0.5                                  => 0.0254696751,
    rv_c21_stl_inq_count = NULL                                 => 0.0054041875,
                                                                   rc046_93_1_1);

rc010_93_4 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc010_93_4_c668,
    rv_c21_stl_inq_count > 0.5                                  => rc010_93_4_1,
    rv_c21_stl_inq_count = NULL                                 => rc010_93_4_1,
                                                                   rc010_93_4_1);

rc014_93_12 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc014_93_12_1,
    rv_c21_stl_inq_count > 0.5                                  => rc014_93_12_c671,
    rv_c21_stl_inq_count = NULL                                 => rc014_93_12_1,
                                                                   rc014_93_12_1);

final_score_93 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => final_score_93_c668,
    rv_c21_stl_inq_count > 0.5                                  => final_score_93_c671,
    rv_c21_stl_inq_count = NULL                                 => 0.0061579045,
                                                                   0.0007537170);

rc031_93_2 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc031_93_2_c668,
    rv_c21_stl_inq_count > 0.5                                  => rc031_93_2_1,
    rv_c21_stl_inq_count = NULL                                 => rc031_93_2_1,
                                                                   rc031_93_2_1);

rc039_94_4_c675 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => 0.0000000000,
    rv_c14_addrs_10yr > 1.5                               => 0.0110939006,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

final_score_94_c675 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => -0.0123953010,
    rv_c14_addrs_10yr > 1.5                               => 0.0149767899,
    rv_c14_addrs_10yr = NULL                              => 0.0038828893,
                                                             0.0038828893);

final_score_94_c676 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0291507883,
    iv_c13_avg_lres > 2.5                             => -0.0050777125,
    iv_c13_avg_lres = NULL                            => -0.0044703589,
                                                         -0.0044703589);

rc017_94_8_c676 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 2.5 => 0.0336211472,
    iv_c13_avg_lres > 2.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc039_94_4_c674 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 2.5 => rc039_94_4_c675,
    iv_prv_addr_lres > 2.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

final_score_94_c674 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 2.5 => final_score_94_c675,
    iv_prv_addr_lres > 2.5                              => final_score_94_c676,
    iv_prv_addr_lres = NULL                             => 0.0025961867,
                                                           -0.0022316153);

rc017_94_8_c674 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 2.5 => 0.0000000000,
    iv_prv_addr_lres > 2.5                              => rc017_94_8_c676,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           NULL);

rc027_94_3_c674 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 2.5 => 0.0061145046,
    iv_prv_addr_lres > 2.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0048278020,
                                                           NULL);

rc039_94_4_c673 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc039_94_4_c674,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_94_c673 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => final_score_94_c674,
    rv_c19_add_prison_hist > 0.5                                    => 0.0702612929,
    rv_c19_add_prison_hist = NULL                                   => -0.0020689703,
                                                                       -0.0020689703);

rc017_94_8_c673 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc017_94_8_c674,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc045_94_2_c673 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0000000000,
    rv_c19_add_prison_hist > 0.5                                    => 0.0723302632,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc027_94_3_c673 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc027_94_3_c674,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc035_94_1 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0544879198,
    rv_d31_mostrec_bk = ''                                         => 0.0068927376,
                                                                        rc035_94_1_1);

rc027_94_3 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc027_94_3_c673,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc027_94_3_1,
    rv_d31_mostrec_bk = ''                                         => rc027_94_3_1,
                                                                        rc027_94_3_1);

rc045_94_2 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc045_94_2_c673,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc045_94_2_1,
    rv_d31_mostrec_bk = ''                                         => rc045_94_2_1,
                                                                        rc045_94_2_1);

rc017_94_8 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc017_94_8_c673,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc017_94_8_1,
    rv_d31_mostrec_bk = ''                                         => rc017_94_8_1,
                                                                        rc017_94_8_1);

final_score_94 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_94_c673,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0527496467,
    rv_d31_mostrec_bk = ''                                         => 0.0051544645,
                                                                        -0.0017382731);

rc039_94_4 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc039_94_4_c673,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc039_94_4_1,
    rv_d31_mostrec_bk = ''                                         => rc039_94_4_1,
                                                                        rc039_94_4_1);

rc013_95_6_c681 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0060028288,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_95_c681 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => -0.0059684142,
    rv_email_domain_free_count > 0.5                                        => 0.0030928767,
    rv_email_domain_free_count = NULL                                       => -0.0029099521,
                                                                               -0.0029099521);

final_score_95_c680 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_95_c681,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0186281452,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0024658603,
                                                                                     -0.0024658603);

rc012_95_5_c680 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0210940055,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc013_95_6_c680 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc013_95_6_c681,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

final_score_95_c679 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => final_score_95_c680,
    rv_c19_add_prison_hist > 0.5                                    => 0.0810141979,
    rv_c19_add_prison_hist = NULL                                   => -0.0023479816,
                                                                       -0.0023479816);

rc012_95_5_c679 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc012_95_5_c680,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc045_95_4_c679 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => 0.0000000000,
    rv_c19_add_prison_hist > 0.5                                    => 0.0833621796,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc013_95_6_c679 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist <= 0.5 => rc013_95_6_c680,
    rv_c19_add_prison_hist > 0.5                                    => 0.0000000000,
    rv_c19_add_prison_hist = NULL                                   => 0.0000000000,
                                                                       NULL);

rc022_95_2_c678 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 55.5 => 0.0179797814,
    rv_d32_mos_since_crim_ls > 55.5                                      => 0.0000000000,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

final_score_95_c678 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 55.5 => 0.0162696612,
    rv_d32_mos_since_crim_ls > 55.5                                      => final_score_95_c679,
    rv_d32_mos_since_crim_ls = NULL                                      => -0.0017101202,
                                                                            -0.0017101202);

rc012_95_5_c678 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 55.5 => 0.0000000000,
    rv_d32_mos_since_crim_ls > 55.5                                      => rc012_95_5_c679,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

rc045_95_4_c678 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 55.5 => 0.0000000000,
    rv_d32_mos_since_crim_ls > 55.5                                      => rc045_95_4_c679,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

rc013_95_6_c678 := map(
    NULL < rv_d32_mos_since_crim_ls AND rv_d32_mos_since_crim_ls <= 55.5 => 0.0000000000,
    rv_d32_mos_since_crim_ls > 55.5                                      => rc013_95_6_c679,
    rv_d32_mos_since_crim_ls = NULL                                      => 0.0000000000,
                                                                            NULL);

rc045_95_4 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc045_95_4_c678,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc045_95_4_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc045_95_4_1,
                                                                           rc045_95_4_1);

rc037_95_1 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0192892400,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0078993550,
                                                                           rc037_95_1_1);

rc013_95_6 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc013_95_6_c678,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc013_95_6_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc013_95_6_1,
                                                                           rc013_95_6_1);

rc022_95_2 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc022_95_2_c678,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc022_95_2_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc022_95_2_1,
                                                                           rc022_95_2_1);

final_score_95 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => final_score_95_c678,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0184020206,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0070121357,
                                                                           -0.0008872193);

rc012_95_5 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => rc012_95_5_c678,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => rc012_95_5_1,
    iv_d34_liens_unrel_sc_ct = NULL                                     => rc012_95_5_1,
                                                                           rc012_95_5_1);

rc009_96_2_c683 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => 0.0257977135,
    rv_d33_eviction_recency > 18                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                   => 0.0000000000,
                                                                        NULL);

final_score_96_c683 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => 0.0223492831,
    rv_d33_eviction_recency > 18                                     => -0.0037696578,
    rv_d33_eviction_recency = NULL                                   => -0.0078141350,
                                                                        -0.0034484304);

final_score_96_c684 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0147015876,
    rv_f00_input_dob_match_level > 6.5                                          => 0.0037231741,
    rv_f00_input_dob_match_level = NULL                                         => -0.0032364126,
                                                                                   0.0050859188);

rc032_96_6_c684 := map(
    NULL < rv_f00_input_dob_match_level AND rv_f00_input_dob_match_level <= 6.5 => 0.0096156688,
    rv_f00_input_dob_match_level > 6.5                                          => 0.0000000000,
    rv_f00_input_dob_match_level = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc024_96_12_c686 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0306107748,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_96_c686 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => -0.0235285594,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0191392861,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => -0.0114714887,
                                                                                 -0.0114714887);

final_score_96_c685 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 20.5 => 0.0220132765,
    iv_header_emergence_age > 20.5                                     => final_score_96_c686,
    iv_header_emergence_age = NULL                                     => 0.0257515305,
                                                                          0.0052982824);

rc025_96_10_c685 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 20.5 => 0.0167149941,
    iv_header_emergence_age > 20.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0204532480,
                                                                          NULL);

rc024_96_12_c685 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 20.5 => 0.0000000000,
    iv_header_emergence_age > 20.5                                     => rc024_96_12_c686,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

rc032_96_6 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc032_96_6_1,
    rv_s66_adlperssn_count > 1.5                                    => rc032_96_6_c684,
    rv_s66_adlperssn_count = NULL                                   => rc032_96_6_1,
                                                                       rc032_96_6_1);

rc009_96_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc009_96_2_c683,
    rv_s66_adlperssn_count > 1.5                                    => rc009_96_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc009_96_2_1,
                                                                       rc009_96_2_1);

rc024_96_12 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc024_96_12_1,
    rv_s66_adlperssn_count > 1.5                                    => rc024_96_12_1,
    rv_s66_adlperssn_count = NULL                                   => rc024_96_12_c685,
                                                                       rc024_96_12_1);

final_score_96 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_96_c683,
    rv_s66_adlperssn_count > 1.5                                    => final_score_96_c684,
    rv_s66_adlperssn_count = NULL                                   => final_score_96_c685,
                                                                       -0.0000388394);

rc025_96_10 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc025_96_10_1,
    rv_s66_adlperssn_count > 1.5                                    => rc025_96_10_1,
    rv_s66_adlperssn_count = NULL                                   => rc025_96_10_c685,
                                                                       rc025_96_10_1);

rc018_96_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0051247583,
    rv_s66_adlperssn_count = NULL                                   => 0.0053371219,
                                                                       rc018_96_1_1);

final_score_97_c689 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0096992212,
    rv_comb_age > 21.5                         => -0.0096739605,
    rv_comb_age = NULL                         => -0.0070590357,
                                                  -0.0070590357);

rc014_97_3_c689 := map(
    NULL < rv_comb_age AND rv_comb_age <= 21.5 => 0.0167582569,
    rv_comb_age > 21.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

rc044_97_7_c690 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => 0.0091110144,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

final_score_97_c690 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => -0.0034058018,
    iv_addr_bureau_only > 0.5                                 => 0.0099248873,
    iv_addr_bureau_only = NULL                                => 0.0008138729,
                                                                 0.0008138729);

rc014_97_3_c688 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => rc014_97_3_c689,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0000000000,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

rc044_97_7_c688 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc044_97_7_c690,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_97_c688 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => final_score_97_c689,
    rv_l79_adls_per_addr_curr > 0.75                                       => final_score_97_c690,
    rv_l79_adls_per_addr_curr = NULL                                       => -0.0025474448,
                                                                              -0.0025474448);

rc043_97_2_c688 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0033613177,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_97_c691 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0278922188,
    iv_source_type > 4.5                            => 0.0040824242,
    iv_source_type = NULL                           => 0.0072208555,
                                                       0.0072208555);

rc023_97_12_c691 := map(
    NULL < iv_source_type AND iv_source_type <= 4.5 => 0.0206713634,
    iv_source_type > 4.5                            => 0.0000000000,
    iv_source_type = NULL                           => 0.0000000000,
                                                       NULL);

rc043_97_2 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => rc043_97_2_c688,
    iv_unverified_addr_count > 2.5                                      => rc043_97_2_1,
    iv_unverified_addr_count = NULL                                     => rc043_97_2_1,
                                                                           rc043_97_2_1);

rc044_97_7 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => rc044_97_7_c688,
    iv_unverified_addr_count > 2.5                                      => rc044_97_7_1,
    iv_unverified_addr_count = NULL                                     => rc044_97_7_1,
                                                                           rc044_97_7_1);

rc023_97_12 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => rc023_97_12_1,
    iv_unverified_addr_count > 2.5                                      => rc023_97_12_c691,
    iv_unverified_addr_count = NULL                                     => rc023_97_12_1,
                                                                           rc023_97_12_1);

final_score_97 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => final_score_97_c688,
    iv_unverified_addr_count > 2.5                                      => final_score_97_c691,
    iv_unverified_addr_count = NULL                                     => 0.0015361212,
                                                                           0.0000799384);

rc014_97_3 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => rc014_97_3_c688,
    iv_unverified_addr_count > 2.5                                      => rc014_97_3_1,
    iv_unverified_addr_count = NULL                                     => rc014_97_3_1,
                                                                           rc014_97_3_1);

rc015_97_1 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => 0.0000000000,
    iv_unverified_addr_count > 2.5                                      => 0.0071409171,
    iv_unverified_addr_count = NULL                                     => 0.0014561828,
                                                                           rc015_97_1_1);

rc043_98_5_c695 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0036595764,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

final_score_98_c695 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => -0.0025299110,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0054144071,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0017548307,
                                                                              0.0017548307);

rc030_98_3_c694 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => 0.0373440445,
    rv_f00_dob_score > 55                              => 0.0009759345,
    rv_f00_dob_score = NULL                            => 0.0000000000,
                                                          NULL);

rc043_98_5_c694 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => NULL,
    rv_f00_dob_score > 55                              => rc043_98_5_c695,
    rv_f00_dob_score = NULL                            => NULL,
                                                          NULL);

final_score_98_c694 := map(
    NULL < rv_f00_dob_score AND rv_f00_dob_score <= 55 => 0.0381229407,
    rv_f00_dob_score > 55                              => final_score_98_c695,
    rv_f00_dob_score = NULL                            => -0.0190103834,
                                                          0.0007788962);

rc043_98_5_c693 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc043_98_5_c694,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc030_98_3_c693 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => rc030_98_3_c694,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

rc011_98_2_c693 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => 0.0026797907,
    iv_input_best_phone_match > 0.5                                       => 0.0000000000,
    iv_input_best_phone_match = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_98_c693 := map(
    NULL < iv_input_best_phone_match AND iv_input_best_phone_match <= 0.5 => final_score_98_c694,
    iv_input_best_phone_match > 0.5                                       => -0.0301692292,
    iv_input_best_phone_match = NULL                                      => -0.0083304026,
                                                                             -0.0019008945);

rc033_98_13_c696 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 18.5 => 0.0266465698,
    iv_bureau_emergence_age_buronly > 18.5                                             => 0.0000000000,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0080194893,
                                                                                          NULL);

final_score_98_c696 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 18.5 => 0.0315586118,
    iv_bureau_emergence_age_buronly > 18.5                                             => -0.0191674200,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0129315312,
                                                                                          0.0049120420);

rc030_98_3 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc030_98_3_c693,
    rv_s66_adlperssn_count > 3.5                                    => rc030_98_3_1,
    rv_s66_adlperssn_count = NULL                                   => rc030_98_3_1,
                                                                       rc030_98_3_1);

rc043_98_5 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc043_98_5_c693,
    rv_s66_adlperssn_count > 3.5                                    => rc043_98_5_1,
    rv_s66_adlperssn_count = NULL                                   => rc043_98_5_1,
                                                                       rc043_98_5_1);

rc018_98_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => 0.0000000000,
    rv_s66_adlperssn_count > 3.5                                    => 0.0234132840,
    rv_s66_adlperssn_count = NULL                                   => 0.0059360734,
                                                                       rc018_98_1_1);

rc033_98_13 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc033_98_13_1,
    rv_s66_adlperssn_count > 3.5                                    => rc033_98_13_1,
    rv_s66_adlperssn_count = NULL                                   => rc033_98_13_c696,
                                                                       rc033_98_13_1);

final_score_98 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => final_score_98_c693,
    rv_s66_adlperssn_count > 3.5                                    => 0.0223892526,
    rv_s66_adlperssn_count = NULL                                   => final_score_98_c696,
                                                                       -0.0010240315);

rc011_98_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 3.5 => rc011_98_2_c693,
    rv_s66_adlperssn_count > 3.5                                    => rc011_98_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc011_98_2_1,
                                                                       rc011_98_2_1);

final_score_99_c699 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => -0.0084963358,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0276061404,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0078619532,
                                                                                     -0.0078619532);

rc012_99_3_c699 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0354680936,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc015_99_2_c698 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => 0.0000000000,
    iv_unverified_addr_count > 1.5                                      => 0.0076912178,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_99_c698 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => final_score_99_c699,
    iv_unverified_addr_count > 1.5                                      => 0.0038218136,
    iv_unverified_addr_count = NULL                                     => -0.0105908985,
                                                                           -0.0038694042);

rc012_99_3_c698 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 1.5 => rc012_99_3_c699,
    iv_unverified_addr_count > 1.5                                      => 0.0000000000,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

rc014_99_9_c700 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0121357393,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_99_c700 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0163113874,
    rv_comb_age > 22.5                         => 0.0026371273,
    rv_comb_age = NULL                         => 0.0041756481,
                                                  0.0041756481);

rc025_99_13_c701 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 30.5 => 0.0092796843,
    iv_header_emergence_age > 30.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0073510781,
                                                                          NULL);

final_score_99_c701 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 30.5 => 0.0201667462,
    iv_header_emergence_age > 30.5                                     => -0.0295904753,
    iv_header_emergence_age = NULL                                     => 0.0182381400,
                                                                          0.0108870620);

rc014_99_9 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc014_99_9_1,
    rv_s66_adlperssn_count > 1.5                                    => rc014_99_9_c700,
    rv_s66_adlperssn_count = NULL                                   => rc014_99_9_1,
                                                                       rc014_99_9_1);

rc018_99_1 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => 0.0000000000,
    rv_s66_adlperssn_count > 1.5                                    => 0.0046327236,
    rv_s66_adlperssn_count = NULL                                   => 0.0113441374,
                                                                       rc018_99_1_1);

rc015_99_2 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc015_99_2_c698,
    rv_s66_adlperssn_count > 1.5                                    => rc015_99_2_1,
    rv_s66_adlperssn_count = NULL                                   => rc015_99_2_1,
                                                                       rc015_99_2_1);

rc012_99_3 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc012_99_3_c698,
    rv_s66_adlperssn_count > 1.5                                    => rc012_99_3_1,
    rv_s66_adlperssn_count = NULL                                   => rc012_99_3_1,
                                                                       rc012_99_3_1);

final_score_99 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => final_score_99_c698,
    rv_s66_adlperssn_count > 1.5                                    => final_score_99_c700,
    rv_s66_adlperssn_count = NULL                                   => final_score_99_c701,
                                                                       -0.0004570754);

rc025_99_13 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 1.5 => rc025_99_13_1,
    rv_s66_adlperssn_count > 1.5                                    => rc025_99_13_1,
    rv_s66_adlperssn_count = NULL                                   => rc025_99_13_c701,
                                                                       rc025_99_13_1);

rc025_100_3_c704 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 10.5 => 0.0748861318,
    iv_header_emergence_age > 10.5                                     => 0.0000000000,
    iv_header_emergence_age = NULL                                     => 0.0000000000,
                                                                          NULL);

final_score_100_c704 := map(
    NULL < iv_header_emergence_age AND iv_header_emergence_age <= 10.5 => 0.0624475461,
    iv_header_emergence_age > 10.5                                     => -0.0145568830,
    iv_header_emergence_age = NULL                                     => -0.0124385857,
                                                                          -0.0124385857);

rc017_100_7_c705 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 0.5 => 0.0435163565,
    iv_c13_avg_lres > 0.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

final_score_100_c705 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 0.5 => 0.0561418916,
    iv_c13_avg_lres > 0.5                             => 0.0110241267,
    iv_c13_avg_lres = NULL                            => 0.0126255351,
                                                         0.0126255351);

rc025_100_3_c703 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => rc025_100_3_c704,
    rv_c14_addrs_10yr > 1.5                               => 0.0000000000,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

final_score_100_c703 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => final_score_100_c704,
    rv_c14_addrs_10yr > 1.5                               => final_score_100_c705,
    rv_c14_addrs_10yr = NULL                              => 0.0028706209,
                                                             0.0028706209);

rc039_100_2_c703 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => 0.0000000000,
    rv_c14_addrs_10yr > 1.5                               => 0.0097549142,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

rc017_100_7_c703 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => 0.0000000000,
    rv_c14_addrs_10yr > 1.5                               => rc017_100_7_c705,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

final_score_100_c706 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => -0.0082975326,
    rv_l79_adls_per_addr_c6 > 0.5                                     => 0.0016919007,
    rv_l79_adls_per_addr_c6 = NULL                                    => -0.0044245567,
                                                                         -0.0044245567);

rc036_100_12_c706 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_addr_c6 > 0.5                                     => 0.0061164574,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         NULL);

rc039_100_2 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc039_100_2_c703,
    iv_prv_addr_lres > 3.5                              => rc039_100_2_1,
    iv_prv_addr_lres = NULL                             => rc039_100_2_1,
                                                           rc039_100_2_1);

final_score_100 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => final_score_100_c703,
    iv_prv_addr_lres > 3.5                              => final_score_100_c706,
    iv_prv_addr_lres = NULL                             => -0.0039966111,
                                                           -0.0030304169);

rc025_100_3 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc025_100_3_c703,
    iv_prv_addr_lres > 3.5                              => rc025_100_3_1,
    iv_prv_addr_lres = NULL                             => rc025_100_3_1,
                                                           rc025_100_3_1);

rc036_100_12 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc036_100_12_1,
    iv_prv_addr_lres > 3.5                              => rc036_100_12_c706,
    iv_prv_addr_lres = NULL                             => rc036_100_12_1,
                                                           rc036_100_12_1);

rc027_100_1 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => 0.0059010378,
    iv_prv_addr_lres > 3.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0000000000,
                                                           rc027_100_1_1);

rc017_100_7 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 3.5 => rc017_100_7_c703,
    iv_prv_addr_lres > 3.5                              => rc017_100_7_1,
    iv_prv_addr_lres = NULL                             => rc017_100_7_1,
                                                           rc017_100_7_1);

final_score_101_c710 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => -0.0032592257,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0204113470,
    rv_l79_adls_per_addr_curr = NULL                                      => -0.0022531663,
                                                                             -0.0022531663);

rc043_101_4_c710 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0226645133,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_101_c709 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_101_c710,
    iv_br_source_count > 0.5                                => -0.0255203430,
    iv_br_source_count = NULL                               => -0.0051688256,
                                                               -0.0048794565);

rc043_101_4_c709 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc043_101_4_c710,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc016_101_3_c709 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0026262902,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc016_101_3_c708 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc016_101_3_c709,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc024_101_2_c708 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0055574379,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc043_101_4_c708 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc043_101_4_c709,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_101_c708 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => final_score_101_c709,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0030185550,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => -0.0025388829,
                                                                                 -0.0025388829);

final_score_101_c711 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => 0.0113842064,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0472553549,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0358639010,
                                                                             0.0213623917);

rc007_101_12_c711 := map(
    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn <= 0.5 => 0.0000000000,
    rv_f00_addr_not_ver_w_ssn > 0.5                                       => 0.0258929632,
    rv_f00_addr_not_ver_w_ssn = NULL                                      => 0.0145015093,
                                                                             NULL);

rc016_101_3 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc016_101_3_c708,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc016_101_3_1,
    rv_p85_phn_risk_level = ''                                 => rc016_101_3_1,
                                                                    rc016_101_3_1);

rc024_101_2 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc024_101_2_c708,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc024_101_2_1,
    rv_p85_phn_risk_level = ''                                 => rc024_101_2_1,
                                                                    rc024_101_2_1);

rc007_101_12 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc007_101_12_1,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc007_101_12_c711,
    rv_p85_phn_risk_level = ''                                 => rc007_101_12_1,
                                                                    rc007_101_12_1);

rc043_101_4 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => rc043_101_4_c708,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => rc043_101_4_1,
    rv_p85_phn_risk_level = ''                                 => rc043_101_4_1,
                                                                    rc043_101_4_1);

rc038_101_1 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => 0.0235412195,
    rv_p85_phn_risk_level = ''                                 => 0.0000000000,
                                                                    rc038_101_1_1);

final_score_101 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => final_score_101_c708,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => final_score_101_c711,
    rv_p85_phn_risk_level = ''                                 => -0.0050184777,
                                                                    -0.0021788277);

final_score_102_c713 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => -0.0063684606,
    rv_c14_addrs_10yr > 1.5                               => 0.0162553837,
    rv_c14_addrs_10yr = NULL                              => 0.0068930765,
                                                             0.0068930765);

rc039_102_2_c713 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 1.5 => 0.0000000000,
    rv_c14_addrs_10yr > 1.5                               => 0.0093623072,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

final_score_102_c714 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 1.5 => -0.0024316783,
    rv_i62_inq_addrs_per_adl > 1.5                                      => 0.0890903497,
    rv_i62_inq_addrs_per_adl = NULL                                     => -0.0022963555,
                                                                           -0.0022963555);

rc020_102_6_c714 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl <= 1.5 => 0.0000000000,
    rv_i62_inq_addrs_per_adl > 1.5                                      => 0.0913867052,
    rv_i62_inq_addrs_per_adl = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_102_c716 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 2.5 => -0.0059366253,
    rv_l79_adls_per_addr_c6 > 2.5                                     => 0.0812523714,
    rv_l79_adls_per_addr_c6 = NULL                                    => -0.0001006817,
                                                                         -0.0001006817);

rc036_102_13_c716 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 <= 2.5 => 0.0000000000,
    rv_l79_adls_per_addr_c6 > 2.5                                     => 0.0813530532,
    rv_l79_adls_per_addr_c6 = NULL                                    => 0.0000000000,
                                                                         NULL);

rc036_102_13_c715 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0000000000,
    rv_d30_derog_count = NULL                               => rc036_102_13_c716,
                                                               NULL);

final_score_102_c715 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => -0.0024127163,
    rv_d30_derog_count > 0.5                                => 0.0357524641,
    rv_d30_derog_count = NULL                               => final_score_102_c716,
                                                               -0.0003670161);

rc001_102_10_c715 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count <= 0.5 => 0.0000000000,
    rv_d30_derog_count > 0.5                                => 0.0361194803,
    rv_d30_derog_count = NULL                               => 0.0002663344,
                                                               NULL);

rc020_102_6 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 1.5 => rc020_102_6_1,
    iv_prv_addr_lres > 1.5                              => rc020_102_6_c714,
    iv_prv_addr_lres = NULL                             => rc020_102_6_1,
                                                           rc020_102_6_1);

rc036_102_13 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 1.5 => rc036_102_13_1,
    iv_prv_addr_lres > 1.5                              => rc036_102_13_1,
    iv_prv_addr_lres = NULL                             => rc036_102_13_c715,
                                                           rc036_102_13_1);

final_score_102 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 1.5 => final_score_102_c713,
    iv_prv_addr_lres > 1.5                              => final_score_102_c714,
    iv_prv_addr_lres = NULL                             => final_score_102_c715,
                                                           -0.0005521798);

rc027_102_1 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 1.5 => 0.0074452563,
    iv_prv_addr_lres > 1.5                              => 0.0000000000,
    iv_prv_addr_lres = NULL                             => 0.0001851637,
                                                           rc027_102_1_1);

rc039_102_2 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 1.5 => rc039_102_2_c713,
    iv_prv_addr_lres > 1.5                              => rc039_102_2_1,
    iv_prv_addr_lres = NULL                             => rc039_102_2_1,
                                                           rc039_102_2_1);

rc001_102_10 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres <= 1.5 => rc001_102_10_1,
    iv_prv_addr_lres > 1.5                              => rc001_102_10_1,
    iv_prv_addr_lres = NULL                             => rc001_102_10_c715,
                                                           rc001_102_10_1);

rc043_103_5_c721 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0128438695,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_103_c721 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 3.5 => 0.0035233972,
    rv_l79_adls_per_addr_curr > 3.5                                       => 0.0171254411,
    rv_l79_adls_per_addr_curr = NULL                                      => 0.0042815715,
                                                                             0.0042815715);

rc043_103_5_c720 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => rc043_103_5_c721,
    iv_num_non_bureau_sources > 4.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

rc010_103_4_c720 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => 0.0010271704,
    iv_num_non_bureau_sources > 4.5                                       => 0.0000000000,
    iv_num_non_bureau_sources = NULL                                      => 0.0000000000,
                                                                             NULL);

final_score_103_c720 := map(
    NULL < iv_num_non_bureau_sources AND iv_num_non_bureau_sources <= 4.5 => final_score_103_c721,
    iv_num_non_bureau_sources > 4.5                                       => -0.0156338111,
    iv_num_non_bureau_sources = NULL                                      => 0.0032544011,
                                                                             0.0032544011);

rc043_103_5_c719 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => rc043_103_5_c720,
    iv_college_code > 0.5                             => 0.0000000000,
    iv_college_code = NULL                            => 0.0000000000,
                                                         NULL);

rc029_103_3_c719 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => 0.0021843446,
    iv_college_code > 0.5                             => 0.0000000000,
    iv_college_code = NULL                            => 0.0000000000,
                                                         NULL);

final_score_103_c719 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => final_score_103_c720,
    iv_college_code > 0.5                             => -0.0178044485,
    iv_college_code = NULL                            => 0.0010700565,
                                                         0.0010700565);

rc010_103_4_c719 := map(
    NULL < iv_college_code AND iv_college_code <= 0.5 => rc010_103_4_c720,
    iv_college_code > 0.5                             => 0.0000000000,
    iv_college_code = NULL                            => 0.0000000000,
                                                         NULL);

rc010_103_4_c718 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc010_103_4_c719,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc029_103_3_c718 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc029_103_3_c719,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc016_103_2_c718 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0018363679,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

final_score_103_c718 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_103_c719,
    iv_br_source_count > 0.5                                => -0.0169408182,
    iv_br_source_count = NULL                               => -0.0007663114,
                                                               -0.0007663114);

rc043_103_5_c718 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc043_103_5_c719,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc043_103_5 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc043_103_5_c718,
    iv_prof_license_category > 0.5                                      => rc043_103_5_1,
    iv_prof_license_category = NULL                                     => rc043_103_5_1,
                                                                           rc043_103_5_1);

rc016_103_2 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc016_103_2_c718,
    iv_prof_license_category > 0.5                                      => rc016_103_2_1,
    iv_prof_license_category = NULL                                     => rc016_103_2_1,
                                                                           rc016_103_2_1);

final_score_103 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => final_score_103_c718,
    iv_prof_license_category > 0.5                                      => -0.0275687023,
    iv_prof_license_category = NULL                                     => -0.0003962058,
                                                                           -0.0021506217);

rc029_103_3 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc029_103_3_c718,
    iv_prof_license_category > 0.5                                      => rc029_103_3_1,
    iv_prof_license_category = NULL                                     => rc029_103_3_1,
                                                                           rc029_103_3_1);

rc047_103_1 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => 0.0013843103,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0017544159,
                                                                           rc047_103_1_1);

rc010_103_4 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc010_103_4_c718,
    iv_prof_license_category > 0.5                                      => rc010_103_4_1,
    iv_prof_license_category = NULL                                     => rc010_103_4_1,
                                                                           rc010_103_4_1);

final_score_104_c726 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 267.5 => 0.0156878506,
    rv_c20_m_bureau_adl_fs > 267.5                                    => -0.0049212159,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0073602272,
                                                                         0.0073602272);

rc040_104_6_c726 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs <= 267.5 => 0.0083276234,
    rv_c20_m_bureau_adl_fs > 267.5                                    => 0.0000000000,
    rv_c20_m_bureau_adl_fs = NULL                                     => 0.0000000000,
                                                                         NULL);

rc040_104_6_c725 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => 0.0000000000,
    iv_unverified_addr_count > 2.5                                      => rc040_104_6_c726,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_104_c725 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => -0.0007998936,
    iv_unverified_addr_count > 2.5                                      => final_score_104_c726,
    iv_unverified_addr_count = NULL                                     => 0.0011269112,
                                                                           0.0011269112);

rc015_104_4_c725 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => 0.0000000000,
    iv_unverified_addr_count > 2.5                                      => 0.0062333161,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_104_c724 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => final_score_104_c725,
    iv_br_source_count > 0.5                                => -0.0159262263,
    iv_br_source_count = NULL                               => -0.0007284091,
                                                               -0.0007284091);

rc015_104_4_c724 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc015_104_4_c725,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc040_104_6_c724 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => rc040_104_6_c725,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc016_104_3_c724 := map(
    NULL < iv_br_source_count AND iv_br_source_count <= 0.5 => 0.0018553203,
    iv_br_source_count > 0.5                                => 0.0000000000,
    iv_br_source_count = NULL                               => 0.0000000000,
                                                               NULL);

rc040_104_6_c723 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc040_104_6_c724,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc034_104_2_c723 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0004868679,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_104_c723 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => final_score_104_c724,
    rv_d31_bk_filing_count > 0.5                                    => -0.0195530056,
    rv_d31_bk_filing_count = NULL                                   => -0.0012152770,
                                                                       -0.0012152770);

rc015_104_4_c723 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc015_104_4_c724,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc016_104_3_c723 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => rc016_104_3_c724,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

rc034_104_2 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 14.5 => rc034_104_2_c723,
    iv_unverified_addr_count > 14.5                                      => rc034_104_2_1,
    iv_unverified_addr_count = NULL                                      => rc034_104_2_1,
                                                                            rc034_104_2_1);

rc015_104_4 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 14.5 => rc015_104_4_c723,
    iv_unverified_addr_count > 14.5                                      => rc015_104_4_1,
    iv_unverified_addr_count = NULL                                      => rc015_104_4_1,
                                                                            rc015_104_4_1);

final_score_104 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 14.5 => final_score_104_c723,
    iv_unverified_addr_count > 14.5                                      => 0.0516272601,
    iv_unverified_addr_count = NULL                                      => -0.0005637534,
                                                                            -0.0010090229);

rc040_104_6 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 14.5 => rc040_104_6_c723,
    iv_unverified_addr_count > 14.5                                      => rc040_104_6_1,
    iv_unverified_addr_count = NULL                                      => rc040_104_6_1,
                                                                            rc040_104_6_1);

rc016_104_3 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 14.5 => rc016_104_3_c723,
    iv_unverified_addr_count > 14.5                                      => rc016_104_3_1,
    iv_unverified_addr_count = NULL                                      => rc016_104_3_1,
                                                                            rc016_104_3_1);

rc015_104_1 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 14.5 => 0.0000000000,
    iv_unverified_addr_count > 14.5                                      => 0.0526362831,
    iv_unverified_addr_count = NULL                                      => 0.0004452695,
                                                                            rc015_104_1_1);

final_score_105_c728 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => -0.0022111081,
    rv_email_domain_free_count > 0.5                                        => 0.0211534369,
    rv_email_domain_free_count = NULL                                       => 0.0072482735,
                                                                               0.0051344420);

rc013_105_2_c728 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 0.5 => 0.0000000000,
    rv_email_domain_free_count > 0.5                                        => 0.0160189949,
    rv_email_domain_free_count = NULL                                       => 0.0021138315,
                                                                               NULL);

final_score_105_c731 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => -0.0055779385,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0144589650,
    iv_d34_liens_unrel_sc_ct = NULL                                     => -0.0047526385,
                                                                           -0.0047526385);

rc037_105_9_c731 := map(
    NULL < iv_d34_liens_unrel_sc_ct AND iv_d34_liens_unrel_sc_ct <= 0.5 => 0.0000000000,
    iv_d34_liens_unrel_sc_ct > 0.5                                      => 0.0192116035,
    iv_d34_liens_unrel_sc_ct = NULL                                     => 0.0000000000,
                                                                           NULL);

rc013_105_8_c730 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 4.5 => 0.0000000000,
    rv_email_domain_free_count > 4.5                                        => 0.0412529734,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_105_c730 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 4.5 => final_score_105_c731,
    rv_email_domain_free_count > 4.5                                        => 0.0370120237,
    rv_email_domain_free_count = NULL                                       => -0.0042409497,
                                                                               -0.0042409497);

rc037_105_9_c730 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 4.5 => rc037_105_9_c731,
    rv_email_domain_free_count > 4.5                                        => 0.0000000000,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

rc037_105_9_c729 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0000000000,
    iv_bureau_verification_index > 9.5                                          => rc037_105_9_c730,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_105_c729 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0083276908,
    iv_bureau_verification_index > 9.5                                          => final_score_105_c730,
    iv_bureau_verification_index = NULL                                         => -0.0004113133,
                                                                                   -0.0023155496);

rc013_105_8_c729 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0000000000,
    iv_bureau_verification_index > 9.5                                          => rc013_105_8_c730,
    iv_bureau_verification_index = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc028_105_6_c729 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 9.5 => 0.0106432404,
    iv_bureau_verification_index > 9.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                         => 0.0019042363,
                                                                                   NULL);

rc013_105_2 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => rc013_105_2_c728,
    rv_comb_age > 24.5                         => rc013_105_2_1,
    rv_comb_age = NULL                         => rc013_105_2_1,
                                                  rc013_105_2_1);

rc028_105_6 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => rc028_105_6_1,
    rv_comb_age > 24.5                         => rc028_105_6_c729,
    rv_comb_age = NULL                         => rc028_105_6_1,
                                                  rc028_105_6_1);

rc013_105_8 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => rc013_105_8_1,
    rv_comb_age > 24.5                         => rc013_105_8_c729,
    rv_comb_age = NULL                         => rc013_105_8_1,
                                                  rc013_105_8_1);

rc014_105_1 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => 0.0058151921,
    rv_comb_age > 24.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  rc014_105_1_1);

rc037_105_9 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => rc037_105_9_1,
    rv_comb_age > 24.5                         => rc037_105_9_c729,
    rv_comb_age = NULL                         => rc037_105_9_1,
                                                  rc037_105_9_1);

final_score_105 := map(
    NULL < rv_comb_age AND rv_comb_age <= 24.5 => final_score_105_c728,
    rv_comb_age > 24.5                         => final_score_105_c729,
    rv_comb_age = NULL                         => -0.0509879369,
                                                  -0.0006807502);

rc014_106_2_c733 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0111783589,
    rv_comb_age > 22.5                         => 0.0000000000,
    rv_comb_age = NULL                         => 0.0000000000,
                                                  NULL);

final_score_106_c733 := map(
    NULL < rv_comb_age AND rv_comb_age <= 22.5 => 0.0074986702,
    rv_comb_age > 22.5                         => -0.0054863070,
    rv_comb_age = NULL                         => -0.0036796887,
                                                  -0.0036796887);

rc041_106_7_c735 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr > 3.5                                      => 0.0000000000,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0149944618,
                                                                           NULL);

final_score_106_c735 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr <= 3.5 => -0.0040049084,
    rv_l79_adls_per_sfd_addr > 3.5                                      => -0.0028790158,
    rv_l79_adls_per_sfd_addr = NULL                                     => 0.0131827477,
                                                                           -0.0018117141);

rc015_106_11_c736 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => 0.0000000000,
    iv_unverified_addr_count > 2.5                                      => 0.0219723352,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_106_c736 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 2.5 => 0.0083090675,
    iv_unverified_addr_count > 2.5                                      => 0.0354398889,
    iv_unverified_addr_count = NULL                                     => 0.0134675537,
                                                                           0.0134675537);

rc041_106_7_c734 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => rc041_106_7_c735,
    iv_addr_bureau_only > 0.5                                 => 0.0000000000,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

rc044_106_6_c734 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => 0.0108769582,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

final_score_106_c734 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => final_score_106_c735,
    iv_addr_bureau_only > 0.5                                 => final_score_106_c736,
    iv_addr_bureau_only = NULL                                => 0.0025905955,
                                                                 0.0025905955);

rc015_106_11_c734 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => rc015_106_11_c736,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

rc015_106_11 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => rc015_106_11_1,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc015_106_11_c734,
    rv_l79_adls_per_addr_curr = NULL                                       => rc015_106_11_1,
                                                                              rc015_106_11_1);

rc041_106_7 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => rc041_106_7_1,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc041_106_7_c734,
    rv_l79_adls_per_addr_curr = NULL                                       => rc041_106_7_1,
                                                                              rc041_106_7_1);

rc044_106_6 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => rc044_106_6_1,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc044_106_6_c734,
    rv_l79_adls_per_addr_curr = NULL                                       => rc044_106_6_1,
                                                                              rc044_106_6_1);

final_score_106 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => final_score_106_c733,
    rv_l79_adls_per_addr_curr > 0.75                                       => final_score_106_c734,
    rv_l79_adls_per_addr_curr = NULL                                       => -0.0001827655,
                                                                              -0.0001827655);

rc043_106_1 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0027733610,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              rc043_106_1_1);

rc014_106_2 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => rc014_106_2_c733,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc014_106_2_1,
    rv_l79_adls_per_addr_curr = NULL                                       => rc014_106_2_1,
                                                                              rc014_106_2_1);

final_score_107_c740 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 5.5 => -0.0006648588,
    rv_email_domain_free_count > 5.5                                        => 0.0359913407,
    rv_email_domain_free_count = NULL                                       => -0.0004838362,
                                                                               -0.0004838362);

rc013_107_4_c740 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 5.5 => 0.0000000000,
    rv_email_domain_free_count > 5.5                                        => 0.0364751770,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_107_c741 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 1.5 => 0.0567324671,
    iv_c13_avg_lres > 1.5                             => -0.0104475937,
    iv_c13_avg_lres = NULL                            => -0.0082183431,
                                                         -0.0082183431);

rc017_107_9_c741 := map(
    NULL < iv_c13_avg_lres AND iv_c13_avg_lres <= 1.5 => 0.0649508102,
    iv_c13_avg_lres > 1.5                             => 0.0000000000,
    iv_c13_avg_lres = NULL                            => 0.0000000000,
                                                         NULL);

rc017_107_9_c739 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0000000000,
    rv_p85_phn_risk_level =''                                              => rc017_107_9_c741,
                                                                                 NULL);

rc038_107_3_c739 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0215664228,
    rv_p85_phn_risk_level = ''                                              => 0.0000000000,
                                                                                 NULL);

final_score_107_c739 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => final_score_107_c740,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0211447360,
    rv_p85_phn_risk_level = ''                                              => final_score_107_c741,
                                                                                 -0.0004216868);

rc013_107_4_c739 := map(
    (rv_p85_phn_risk_level in ['HIGH RISK', 'INVALID', 'NONE', 'NOT ISSUED']) => rc013_107_4_c740,
    (rv_p85_phn_risk_level in ['DISCONNECTED'])                               => 0.0000000000,
    rv_p85_phn_risk_level = ''                                              => 0.0000000000,
                                                                                 NULL);

rc017_107_9_c738 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc017_107_9_c739,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc038_107_3_c738 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc038_107_3_c739,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc047_107_2_c738 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => 0.0013304956,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

rc013_107_4_c738 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => rc013_107_4_c739,
    iv_prof_license_category > 0.5                                      => 0.0000000000,
    iv_prof_license_category = NULL                                     => 0.0000000000,
                                                                           NULL);

final_score_107_c738 := map(
    NULL < iv_prof_license_category AND iv_prof_license_category <= 0.5 => final_score_107_c739,
    iv_prof_license_category > 0.5                                      => -0.0258622377,
    iv_prof_license_category = NULL                                     => -0.0017521824,
                                                                           -0.0017521824);

final_score_107 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => final_score_107_c738,
    rv_c21_stl_inq_count > 0.5                                  => 0.0206824879,
    rv_c21_stl_inq_count = NULL                                 => -0.0016157224,
                                                                   -0.0011100374);

rc013_107_4 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc013_107_4_c738,
    rv_c21_stl_inq_count > 0.5                                  => rc013_107_4_1,
    rv_c21_stl_inq_count = NULL                                 => rc013_107_4_1,
                                                                   rc013_107_4_1);

rc047_107_2 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc047_107_2_c738,
    rv_c21_stl_inq_count > 0.5                                  => rc047_107_2_1,
    rv_c21_stl_inq_count = NULL                                 => rc047_107_2_1,
                                                                   rc047_107_2_1);

rc046_107_1 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => 0.0000000000,
    rv_c21_stl_inq_count > 0.5                                  => 0.0217925254,
    rv_c21_stl_inq_count = NULL                                 => 0.0000000000,
                                                                   rc046_107_1_1);

rc038_107_3 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc038_107_3_c738,
    rv_c21_stl_inq_count > 0.5                                  => rc038_107_3_1,
    rv_c21_stl_inq_count = NULL                                 => rc038_107_3_1,
                                                                   rc038_107_3_1);

rc017_107_9 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count <= 0.5 => rc017_107_9_c738,
    rv_c21_stl_inq_count > 0.5                                  => rc017_107_9_1,
    rv_c21_stl_inq_count = NULL                                 => rc017_107_9_1,
                                                                   rc017_107_9_1);

final_score_108_c743 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 6.5 => 0.0156128565,
    rv_c14_addrs_10yr > 6.5                               => 0.0591231330,
    rv_c14_addrs_10yr = NULL                              => 0.0249538928,
                                                             0.0249538928);

rc039_108_2_c743 := map(
    NULL < rv_c14_addrs_10yr AND rv_c14_addrs_10yr <= 6.5 => 0.0000000000,
    rv_c14_addrs_10yr > 6.5                               => 0.0341692402,
    rv_c14_addrs_10yr = NULL                              => 0.0000000000,
                                                             NULL);

final_score_108_c745 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 4.5 => -0.0047107195,
    rv_email_domain_free_count > 4.5                                        => 0.0267635112,
    rv_email_domain_free_count = NULL                                       => -0.0043769722,
                                                                               -0.0043769722);

rc013_108_7_c745 := map(
    NULL < rv_email_domain_free_count AND rv_email_domain_free_count <= 4.5 => 0.0000000000,
    rv_email_domain_free_count > 4.5                                        => 0.0311404833,
    rv_email_domain_free_count = NULL                                       => 0.0000000000,
                                                                               NULL);

final_score_108_c746 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 70.25 => 0.0242401122,
    rv_a49_curr_avm_chg_1yr_pct > 70.25                                         => 0.0013893871,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0023054505,
                                                                                   0.0037628474);

rc026_108_11_c746 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 70.25 => 0.0204772647,
    rv_a49_curr_avm_chg_1yr_pct > 70.25                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0000000000,
                                                                                   NULL);

rc024_108_6_c744 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0057339919,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc026_108_11_c744 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => rc026_108_11_c746,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

rc013_108_7_c744 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => rc013_108_7_c745,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => 0.0000000000,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => 0.0000000000,
                                                                                 NULL);

final_score_108_c744 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 <= 0.5 => final_score_108_c745,
    rv_l79_adls_per_sfd_addr_c6 > 0.5                                         => final_score_108_c746,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                        => -0.0019711445,
                                                                                 -0.0019711445);

rc026_108_11 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => rc026_108_11_1,
    rv_d33_eviction_recency > 18                                     => rc026_108_11_c744,
    rv_d33_eviction_recency = NULL                                   => rc026_108_11_1,
                                                                        rc026_108_11_1);

rc024_108_6 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => rc024_108_6_1,
    rv_d33_eviction_recency > 18                                     => rc024_108_6_c744,
    rv_d33_eviction_recency = NULL                                   => rc024_108_6_1,
                                                                        rc024_108_6_1);

rc013_108_7 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => rc013_108_7_1,
    rv_d33_eviction_recency > 18                                     => rc013_108_7_c744,
    rv_d33_eviction_recency = NULL                                   => rc013_108_7_1,
                                                                        rc013_108_7_1);

rc039_108_2 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => rc039_108_2_c743,
    rv_d33_eviction_recency > 18                                     => rc039_108_2_1,
    rv_d33_eviction_recency = NULL                                   => rc039_108_2_1,
                                                                        rc039_108_2_1);

rc009_108_1 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => 0.0265346732,
    rv_d33_eviction_recency > 18                                     => 0.0000000000,
    rv_d33_eviction_recency = NULL                                   => 0.0000000000,
                                                                        rc009_108_1_1);

final_score_108 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency <= 18 => final_score_108_c743,
    rv_d33_eviction_recency > 18                                     => final_score_108_c744,
    rv_d33_eviction_recency = NULL                                   => -0.0048379897,
                                                                        -0.0015807803);

rc018_109_5_c750 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 5.5 => 0.0000000000,
    rv_s66_adlperssn_count > 5.5                                    => 0.0826867081,
    rv_s66_adlperssn_count = NULL                                   => 0.0285168333,
                                                                       NULL);

final_score_109_c750 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count <= 5.5 => -0.0058036456,
    rv_s66_adlperssn_count > 5.5                                    => 0.0775045293,
    rv_s66_adlperssn_count = NULL                                   => 0.0233346546,
                                                                       -0.0051821788);

final_score_109_c749 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => final_score_109_c750,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0316339235,
    rv_d32_criminal_behavior_lvl = NULL                                         => -0.0044892708,
                                                                                   -0.0044892708);

rc019_109_4_c749 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => 0.0000000000,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0361231943,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

rc018_109_5_c749 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl <= 2.5 => rc018_109_5_c750,
    rv_d32_criminal_behavior_lvl > 2.5                                          => 0.0000000000,
    rv_d32_criminal_behavior_lvl = NULL                                         => 0.0000000000,
                                                                                   NULL);

final_score_109_c748 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => final_score_109_c749,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0314928110,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => -0.0038255322,
                                                                                     -0.0038255322);

rc019_109_4_c748 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc019_109_4_c749,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc018_109_5_c748 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => rc018_109_5_c749,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc012_109_3_c748 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 <= 0.5 => 0.0000000000,
    rv_i60_inq_hiriskcred_count12 > 0.5                                           => 0.0353183432,
    rv_i60_inq_hiriskcred_count12 = NULL                                          => 0.0000000000,
                                                                                     NULL);

rc034_109_13_c751 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0006829782,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0002049127,
                                                                       NULL);

final_score_109_c751 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0018062194,
    rv_d31_bk_filing_count > 0.5                                    => -0.0269496058,
    rv_d31_bk_filing_count = NULL                                   => 0.0013281540,
                                                                       0.0011232413);

rc019_109_4 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 40.15 => rc019_109_4_1,
    rv_a49_curr_avm_chg_1yr_pct > 40.15                                         => rc019_109_4_c748,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc019_109_4_1,
                                                                                   rc019_109_4_1);

final_score_109 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 40.15 => 0.0297152226,
    rv_a49_curr_avm_chg_1yr_pct > 40.15                                         => final_score_109_c748,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_109_c751,
                                                                                   -0.0003435137);

rc034_109_13 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 40.15 => rc034_109_13_1,
    rv_a49_curr_avm_chg_1yr_pct > 40.15                                         => rc034_109_13_1,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc034_109_13_c751,
                                                                                   rc034_109_13_1);

rc026_109_1 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 40.15 => 0.0300587363,
    rv_a49_curr_avm_chg_1yr_pct > 40.15                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0014667550,
                                                                                   rc026_109_1_1);

rc018_109_5 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 40.15 => rc018_109_5_1,
    rv_a49_curr_avm_chg_1yr_pct > 40.15                                         => rc018_109_5_c748,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc018_109_5_1,
                                                                                   rc018_109_5_1);

rc012_109_3 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 40.15 => rc012_109_3_1,
    rv_a49_curr_avm_chg_1yr_pct > 40.15                                         => rc012_109_3_c748,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc012_109_3_1,
                                                                                   rc012_109_3_1);

rc034_110_7_c755 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0009150829,
    rv_d31_bk_filing_count > 0.5                                    => 0.0000000000,
    rv_d31_bk_filing_count = NULL                                   => 0.0000000000,
                                                                       NULL);

final_score_110_c755 := map(
    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count <= 0.5 => 0.0054522164,
    rv_d31_bk_filing_count > 0.5                                    => -0.0340944967,
    rv_d31_bk_filing_count = NULL                                   => 0.0045371335,
                                                                       0.0045371335);

final_score_110_c754 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 30.45 => 0.0680921640,
    rv_a49_curr_avm_chg_1yr_pct > 30.45                                         => 0.0133796088,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => final_score_110_c755,
                                                                                   0.0075938734);

rc026_110_4_c754 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 30.45 => 0.0604982906,
    rv_a49_curr_avm_chg_1yr_pct > 30.45                                         => 0.0057857354,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => 0.0000000000,
                                                                                   NULL);

rc034_110_7_c754 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct <= 30.45 => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct > 30.45                                         => 0.0000000000,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                          => rc034_110_7_c755,
                                                                                   NULL);

final_score_110_c756 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => -0.0135447664,
    iv_addr_bureau_only > 0.5                                 => 0.0066857906,
    iv_addr_bureau_only = NULL                                => -0.0073054695,
                                                                 -0.0073054695);

rc044_110_11_c756 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => 0.0139912601,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

rc028_110_3_c753 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0069781385,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc026_110_4_c753 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => rc026_110_4_c754,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc044_110_11_c753 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => 0.0000000000,
    iv_bureau_verification_index > 13.5                                          => rc044_110_11_c756,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

rc034_110_7_c753 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => rc034_110_7_c754,
    iv_bureau_verification_index > 13.5                                          => 0.0000000000,
    iv_bureau_verification_index = NULL                                          => 0.0000000000,
                                                                                    NULL);

final_score_110_c753 := map(
    NULL < iv_bureau_verification_index AND iv_bureau_verification_index <= 13.5 => final_score_110_c754,
    iv_bureau_verification_index > 13.5                                          => final_score_110_c756,
    iv_bureau_verification_index = NULL                                          => 0.0006157349,
                                                                                    0.0006157349);

rc034_110_7 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => rc034_110_7_1,
    iv_unverified_addr_count > 0.5                                      => rc034_110_7_c753,
    iv_unverified_addr_count = NULL                                     => rc034_110_7_1,
                                                                           rc034_110_7_1);

rc044_110_11 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => rc044_110_11_1,
    iv_unverified_addr_count > 0.5                                      => rc044_110_11_c753,
    iv_unverified_addr_count = NULL                                     => rc044_110_11_1,
                                                                           rc044_110_11_1);

rc028_110_3 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => rc028_110_3_1,
    iv_unverified_addr_count > 0.5                                      => rc028_110_3_c753,
    iv_unverified_addr_count = NULL                                     => rc028_110_3_1,
                                                                           rc028_110_3_1);

rc026_110_4 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => rc026_110_4_1,
    iv_unverified_addr_count > 0.5                                      => rc026_110_4_c753,
    iv_unverified_addr_count = NULL                                     => rc026_110_4_1,
                                                                           rc026_110_4_1);

final_score_110 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => -0.0049785383,
    iv_unverified_addr_count > 0.5                                      => final_score_110_c753,
    iv_unverified_addr_count = NULL                                     => -0.0042053019,
                                                                           -0.0016079883);

rc015_110_1 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count <= 0.5 => 0.0000000000,
    iv_unverified_addr_count > 0.5                                      => 0.0022237231,
    iv_unverified_addr_count = NULL                                     => 0.0000000000,
                                                                           rc015_110_1_1);

rc038_111_3_c759 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => 0.0000000000,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => 0.0300379946,
    rv_p85_phn_risk_level = ''                                 => 0.0096715437,
                                                                    NULL);

final_score_111_c759 := map(
    (rv_p85_phn_risk_level in ['INVALID', 'NONE', 'NOT ISSUED']) => -0.0055722675,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK'])     => 0.0256193184,
    rv_p85_phn_risk_level = ''                                 => 0.0052528675,
                                                                    -0.0044186762);

rc033_111_9_c761 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 24.5 => 0.0000000000,
    iv_bureau_emergence_age_buronly > 24.5                                             => 0.0000000000,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0057974611,
                                                                                          NULL);

final_score_111_c761 := map(
    NULL < iv_bureau_emergence_age_buronly AND iv_bureau_emergence_age_buronly <= 24.5 => 0.0052251363,
    iv_bureau_emergence_age_buronly > 24.5                                             => -0.0156987752,
    iv_bureau_emergence_age_buronly = NULL                                             => 0.0191847966,
                                                                                          0.0133873355);

rc044_111_7_c760 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => 0.0114410358,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

rc033_111_9_c760 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => 0.0000000000,
    iv_addr_bureau_only > 0.5                                 => rc033_111_9_c761,
    iv_addr_bureau_only = NULL                                => 0.0000000000,
                                                                 NULL);

final_score_111_c760 := map(
    NULL < iv_addr_bureau_only AND iv_addr_bureau_only <= 0.5 => -0.0028205749,
    iv_addr_bureau_only > 0.5                                 => final_score_111_c761,
    iv_addr_bureau_only = NULL                                => 0.0019462997,
                                                                 0.0019462997);

final_score_111_c758 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => final_score_111_c759,
    rv_l79_adls_per_addr_curr > 0.75                                       => final_score_111_c760,
    rv_l79_adls_per_addr_curr = NULL                                       => -0.0008757787,
                                                                              -0.0008757787);

rc043_111_2_c758 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0028220784,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

rc038_111_3_c758 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => rc038_111_3_c759,
    rv_l79_adls_per_addr_curr > 0.75                                       => 0.0000000000,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

rc033_111_9_c758 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc033_111_9_c760,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

rc044_111_7_c758 := map(
    NULL < rv_l79_adls_per_addr_curr AND rv_l79_adls_per_addr_curr <= 0.75 => 0.0000000000,
    rv_l79_adls_per_addr_curr > 0.75                                       => rc044_111_7_c760,
    rv_l79_adls_per_addr_curr = NULL                                       => 0.0000000000,
                                                                              NULL);

rc035_111_1 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => 0.0000000000,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0498896849,
    rv_d31_mostrec_bk = ''                                         => 0.0042760793,
                                                                        rc035_111_1_1);

rc033_111_9 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc033_111_9_c758,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc033_111_9_1,
    rv_d31_mostrec_bk = ''                                         => rc033_111_9_1,
                                                                        rc033_111_9_1);

rc044_111_7 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc044_111_7_c758,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc044_111_7_1,
    rv_d31_mostrec_bk = ''                                         => rc044_111_7_1,
                                                                        rc044_111_7_1);

final_score_111 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => final_score_111_c758,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => 0.0492761873,
    rv_d31_mostrec_bk = ''                                        => 0.0036625817,
                                                                        -0.0006134976);

rc038_111_3 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc038_111_3_c758,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc038_111_3_1,
    rv_d31_mostrec_bk = ''                                         => rc038_111_3_1,
                                                                        rc038_111_3_1);

rc043_111_2 := map(
    (rv_d31_mostrec_bk in ['0, 2, 3 - DISCHARGED, OTHER, OR NO BK']) => rc043_111_2_c758,
    (rv_d31_mostrec_bk in ['1 - BK DISMISSED'])                      => rc043_111_2_1,
    rv_d31_mostrec_bk = ''                                         => rc043_111_2_1,
                                                                        rc043_111_2_1);

aa_rc001 := rc001_1_2 +
    rc001_1_6 +
    rc001_2_4 +
    rc001_2_9 +
    rc001_3_6 +
    rc001_4_7 +
    rc001_5_3 +
    rc001_6_7 +
    rc001_7_4 +
    rc001_7_9 +
    rc001_10_2 +
    rc001_10_10 +
    rc001_11_2 +
    rc001_14_4 +
    rc001_17_1 +
    rc001_19_6 +
    rc001_20_4 +
    rc001_23_1 +
    rc001_27_1 +
    rc001_29_6 +
    rc001_35_1 +
    rc001_42_3 +
    rc001_49_3 +
    rc001_57_4 +
    rc001_70_3 +
    rc001_71_1 +
    rc001_73_4 +
    rc001_77_8 +
    rc001_82_11 +
    rc001_84_2 +
    rc001_89_12 +
    rc001_102_10;

aa_rc002 := rc002_1_7 +
    rc002_2_10 +
    rc002_3_7 +
    rc002_4_2 +
    rc002_4_6 +
    rc002_5_2 +
    rc002_6_2 +
    rc002_8_1 +
    rc002_9_1 +
    rc002_10_9 +
    rc002_13_1 +
    rc002_16_1 +
    rc002_18_1 +
    rc002_22_1 +
    rc002_24_10 +
    rc002_30_4 +
    rc002_77_3;

aa_rc003 := rc003_2_1 +
    rc003_4_1 +
    rc003_7_1 +
    rc003_10_1 +
    rc003_12_1;

aa_rc004 := rc004_3_1 +
    rc004_6_1 +
    rc004_11_1;

aa_rc005 := rc005_1_8 +
    rc005_2_2 +
    rc005_3_2 +
    rc005_4_8 +
    rc005_5_4 +
    rc005_5_12 +
    rc005_6_8 +
    rc005_7_2 +
    rc005_10_3 +
    rc005_11_3 +
    rc005_11_10 +
    rc005_12_2 +
    rc005_13_2 +
    rc005_15_2 +
    rc005_18_2 +
    rc005_19_2 +
    rc005_26_2 +
    rc005_34_3 +
    rc005_35_4 +
    rc005_40_1 +
    rc005_51_3 +
    rc005_61_4 +
    rc005_84_4;

aa_rc006 := rc006_1_1 + rc006_9_2;

aa_rc007 := rc007_5_1 +
    rc007_8_2 +
    rc007_14_1 +
    rc007_101_12;

aa_rc008 := rc008_6_6 +
    rc008_11_9 +
    rc008_15_1 +
    rc008_21_1 +
    rc008_27_6 +
    rc008_30_5 +
    rc008_44_2 +
    rc008_47_2 +
    rc008_52_3 +
    rc008_68_3;

aa_rc009 := rc009_3_11 +
    rc009_8_3 +
    rc009_9_4 +
    rc009_13_4 +
    rc009_14_8 +
    rc009_15_4 +
    rc009_25_1 +
    rc009_30_12 +
    rc009_39_1 +
    rc009_41_3 +
    rc009_60_1 +
    rc009_62_8 +
    rc009_75_2 +
    rc009_91_4 +
    rc009_92_6 +
    rc009_96_2 +
    rc009_108_1;

aa_rc010 := rc010_7_10 +
    rc010_15_12 +
    rc010_17_2 +
    rc010_17_12 +
    rc010_20_9 +
    rc010_29_11 +
    rc010_30_1 +
    rc010_41_12 +
    rc010_44_5 +
    rc010_46_7 +
    rc010_48_3 +
    rc010_57_6 +
    rc010_67_8 +
    rc010_68_4 +
    rc010_73_10 +
    rc010_76_4 +
    rc010_93_4 +
    rc010_103_4;

aa_rc011 := rc011_12_10 +
    rc011_16_2 +
    rc011_18_4 +
    rc011_24_1 +
    rc011_26_1 +
    rc011_34_2 +
    rc011_35_2 +
    rc011_39_3 +
    rc011_49_6 +
    rc011_51_2 +
    rc011_57_3 +
    rc011_74_11 +
    rc011_81_2 +
    rc011_90_10 +
    rc011_98_2;

aa_rc012 := rc012_8_7 +
    rc012_12_9 +
    rc012_19_12 +
    rc012_23_2 +
    rc012_27_2 +
    rc012_32_2 +
    rc012_41_2 +
    rc012_42_1 +
    rc012_44_1 +
    rc012_68_1 +
    rc012_73_3 +
    rc012_95_5 +
    rc012_99_3 +
    rc012_109_3;

aa_rc013 := rc013_18_6 +
    rc013_24_3 +
    rc013_26_5 +
    rc013_28_1 +
    rc013_29_2 +
    rc013_32_8 +
    rc013_37_3 +
    rc013_38_1 +
    rc013_43_6 +
    rc013_45_2 +
    rc013_48_4 +
    rc013_51_1 +
    rc013_52_9 +
    rc013_55_1 +
    rc013_58_9 +
    rc013_59_1 +
    rc013_71_2 +
    rc013_74_2 +
    rc013_80_1 +
    rc013_82_2 +
    rc013_88_1 +
    rc013_95_6 +
    rc013_105_2 +
    rc013_105_8 +
    rc013_107_4 +
    rc013_108_7;

aa_rc014 := rc014_8_5 +
    rc014_9_6 +
    rc014_20_5 +
    rc014_29_1 +
    rc014_37_2 +
    rc014_43_2 +
    rc014_45_1 +
    rc014_48_9 +
    rc014_51_12 +
    rc014_52_11 +
    rc014_53_4 +
    rc014_63_9 +
    rc014_66_1 +
    rc014_69_7 +
    rc014_74_1 +
    rc014_85_2 +
    rc014_88_10 +
    rc014_93_12 +
    rc014_97_3 +
    rc014_99_9 +
    rc014_105_1 +
    rc014_106_2;

aa_rc015 := rc015_17_3 +
    rc015_25_4 +
    rc015_25_9 +
    rc015_28_5 +
    rc015_30_2 +
    rc015_38_7 +
    rc015_40_4 +
    rc015_44_3 +
    rc015_47_3 +
    rc015_47_6 +
    rc015_50_6 +
    rc015_55_7 +
    rc015_56_2 +
    rc015_65_9 +
    rc015_66_2 +
    rc015_66_6 +
    rc015_67_6 +
    rc015_68_5 +
    rc015_72_4 +
    rc015_73_11 +
    rc015_75_4 +
    rc015_76_5 +
    rc015_81_4 +
    rc015_86_1 +
    rc015_87_3 +
    rc015_89_3 +
    rc015_97_1 +
    rc015_99_2 +
    rc015_104_1 +
    rc015_104_4 +
    rc015_106_11 +
    rc015_110_1;

aa_rc016 := rc016_13_8 +
    rc016_16_3 +
    rc016_22_2 +
    rc016_26_4 +
    rc016_34_1 +
    rc016_35_3 +
    rc016_38_6 +
    rc016_46_6 +
    rc016_54_1 +
    rc016_55_3 +
    rc016_69_3 +
    rc016_72_1 +
    rc016_80_3 +
    rc016_101_3 +
    rc016_103_2 +
    rc016_104_3;

aa_rc017 := rc017_15_6 +
    rc017_19_1 +
    rc017_21_2 +
    rc017_22_5 +
    rc017_31_11 +
    rc017_36_9 +
    rc017_39_6 +
    rc017_42_7 +
    rc017_53_6 +
    rc017_56_8 +
    rc017_58_3 +
    rc017_62_2 +
    rc017_63_7 +
    rc017_70_4 +
    rc017_86_11 +
    rc017_94_8 +
    rc017_100_7 +
    rc017_107_9;

aa_rc018 := rc018_22_4 +
    rc018_24_2 +
    rc018_32_1 +
    rc018_37_1 +
    rc018_41_1 +
    rc018_42_9 +
    rc018_46_1 +
    rc018_53_1 +
    rc018_62_6 +
    rc018_69_2 +
    rc018_79_3 +
    rc018_83_1 +
    rc018_84_1 +
    rc018_85_1 +
    rc018_86_2 +
    rc018_96_1 +
    rc018_98_1 +
    rc018_99_1 +
    rc018_109_5;

aa_rc019 := rc019_9_8 +
    rc019_12_4 +
    rc019_18_5 +
    rc019_28_9 +
    rc019_31_3 +
    rc019_32_4 +
    rc019_38_2 +
    rc019_45_6 +
    rc019_59_6 +
    rc019_60_5 +
    rc019_79_1 +
    rc019_109_4;

aa_rc020 := rc020_14_2 +
    rc020_17_7 +
    rc020_29_7 +
    rc020_33_9 +
    rc020_65_4 +
    rc020_81_1 +
    rc020_102_6;

aa_rc021 := rc021_20_1 +
    rc021_21_5 +
    rc021_33_1 +
    rc021_45_7 +
    rc021_56_1 +
    rc021_88_2;

aa_rc022 := rc022_13_6 +
    rc022_16_5 +
    rc022_24_4 +
    rc022_26_6 +
    rc022_43_4 +
    rc022_80_4 +
    rc022_95_2;

aa_rc023 := rc023_14_3 +
    rc023_23_3 +
    rc023_41_5 +
    rc023_65_11 +
    rc023_75_6 +
    rc023_86_9 +
    rc023_89_5 +
    rc023_97_12;

aa_rc024 := max(0,rc024_21_4) +
    max(0,rc024_23_4) +
    max(0,rc024_33_10) +
    max(0,rc024_34_5) +
    max(0,rc024_43_1) +
    max(0,rc024_50_2) +
    max(0,rc024_51_5) +
    max(0,rc024_96_12) +
    max(0,rc024_101_2) +
    max(0,rc024_108_6);

aa_rc025 := rc025_19_4 +
    rc025_34_6 +
    rc025_46_2 +
    rc025_48_5 +
    rc025_53_13 +
    rc025_58_2 +
    rc025_59_4 +
    rc025_62_1 +
    rc025_69_11 +
    rc025_82_1 +
    rc025_84_13 +
    rc025_86_5 +
    rc025_90_1 +
    rc025_96_10 +
    rc025_99_13 +
    rc025_100_3;

aa_rc026 := rc026_31_1 +
    rc026_37_12 +
    rc026_38_3 +
    rc026_46_8 +
    rc026_54_3 +
    rc026_55_4 +
    rc026_65_2 +
    rc026_70_1 +
    rc026_73_1 +
    rc026_82_9 +
    rc026_90_6 +
    rc026_108_11 +
    rc026_109_1 +
    rc026_110_4;

aa_rc027 := rc027_31_7 +
    rc027_33_4 +
    rc027_36_1 +
    rc027_39_4 +
    rc027_42_2 +
    rc027_52_2 +
    rc027_63_1 +
    rc027_72_6 +
    rc027_80_6 +
    rc027_94_3 +
    rc027_100_1 +
    rc027_102_1;

aa_rc028 := rc028_23_8 +
    rc028_25_8 +
    rc028_28_4 +
    rc028_40_6 +
    rc028_47_5 +
    rc028_50_5 +
    rc028_75_8 +
    rc028_76_7 +
    rc028_85_4 +
    rc028_105_6 +
    rc028_110_3;

aa_rc029 := rc029_16_4 +
    rc029_22_3 +
    rc029_50_1 +
    rc029_55_2 +
    rc029_72_2 +
    rc029_89_1 +
    rc029_91_7 +
    rc029_103_3;

aa_rc030 := rc030_31_9 +
    rc030_35_6 +
    rc030_39_8 +
    rc030_40_7 +
    rc030_50_3 +
    rc030_59_2 +
    rc030_61_2 +
    rc030_64_2 +
    rc030_76_1 +
    rc030_90_2 +
    rc030_91_2 +
    rc030_98_3;

aa_rc031 := rc031_33_2 +
    rc031_36_4 +
    rc031_36_11 +
    rc031_43_12 +
    rc031_48_1 +
    rc031_57_1 +
    rc031_58_7 +
    rc031_67_10 +
    rc031_74_7 +
    rc031_78_2 +
    rc031_87_8 +
    rc031_92_1 +
    rc031_93_2;

aa_rc032 := rc032_25_3 +
    rc032_28_2 +
    rc032_53_2 +
    rc032_54_7 +
    rc032_82_3 +
    rc032_87_2 +
    rc032_96_6;

aa_rc033 := rc033_21_12 +
    rc033_27_3 +
    rc033_44_10 +
    rc033_64_4 +
    rc033_78_4 +
    rc033_78_11 +
    rc033_98_13 +
    rc033_111_9;

aa_rc034 := rc034_27_12 +
    rc034_49_2 +
    rc034_61_6 +
    rc034_64_8 +
    rc034_77_2 +
    rc034_81_3 +
    rc034_83_3 +
    rc034_87_7 +
    rc034_92_5 +
    rc034_104_2 +
    rc034_109_13 +
    rc034_110_7;

aa_rc035 := rc035_49_1 +
    rc035_59_7 +
    rc035_61_8 +
    rc035_67_2 +
    rc035_77_1 +
    rc035_83_2 +
    rc035_87_1 +
    rc035_91_1 +
    rc035_92_4 +
    rc035_94_1 +
    rc035_111_1;

aa_rc036 := max(0,rc036_32_3) +
    max(0,rc036_52_1 )+
    max(0,rc036_65_1 )+
    max(0,rc036_67_1) +
    max(0,rc036_100_12) +
    max(0,rc036_102_13);

aa_rc037 := rc037_37_7 +
    rc037_45_9 +
    rc037_58_1 +
    rc037_63_6 +
    rc037_64_7 +
    rc037_79_4 +
    rc037_80_2 +
    rc037_90_9 +
    rc037_95_1 +
    rc037_105_9;

aa_rc038 := rc038_47_1 +
    rc038_54_2 +
    rc038_69_1 +
    rc038_71_4 +
    rc038_78_1 +
    rc038_101_1 +
    rc038_107_3 +
    rc038_111_3;

aa_rc039 := rc039_36_2 +
    rc039_63_2 +
    rc039_83_13 +
    rc039_94_4 +
    rc039_100_2 +
    rc039_102_2 +
    rc039_108_2;

aa_rc040 := rc040_40_3 +
    rc040_66_11 +
    rc040_72_3 +
    rc040_79_8 +
    rc040_81_6 +
    rc040_89_2 +
    rc040_104_6;

aa_rc041 := max(0,rc041_56_6) +
    max(0,rc041_66_7) +
    max(0,rc041_68_2) +
    max(0,rc041_71_5) +
    max(0,rc041_83_4) +
    max(0,rc041_85_6) +
   max(0, rc041_88_7) +
    max(0,rc041_106_7);

aa_rc043 := max(0,rc043_70_11) +
    max(0,rc043_74_6) +
    max(0,rc043_76_3) +
    max(0,rc043_77_4) +
    max(0,rc043_97_2) +
    max(0,rc043_98_5) +
    max(0,rc043_101_4) +
    max(0,rc043_103_5) +
    max(0,rc043_106_1) +
    max(0,rc043_111_2);

aa_rc044 := rc044_56_7 +
    rc044_85_7 +
    rc044_97_7 +
    rc044_106_6 +
    rc044_110_11 +
    rc044_111_7;

aa_rc045 := rc045_54_6 +
    rc045_57_5 +
    rc045_60_6 +
    rc045_62_7 +
    rc045_79_2 +
    rc045_94_2 +
    rc045_95_4;

aa_rc046 := rc046_60_3 +
    rc046_64_1 +
    rc046_75_1 +
    rc046_78_7 +
    rc046_93_1 +
    rc046_107_1;

aa_rc047 := rc047_60_4 +
    rc047_70_10 +
    rc047_91_6 +
    rc047_92_3 +
    rc047_103_1 +
    rc047_107_2;

aa_rc048 := rc048_61_1 +
    rc048_71_3 +
    rc048_88_3 +
    rc048_93_5;

aa_rc049 := rc049_49_4;

final_score := final_score_0 +
    final_score_1 +
    final_score_2 +
    final_score_3 +
    final_score_4 +
    final_score_5 +
    final_score_6 +
    final_score_7 +
    final_score_8 +
    final_score_9 +
    final_score_10 +
    final_score_11 +
    final_score_12 +
    final_score_13 +
    final_score_14 +
    final_score_15 +
    final_score_16 +
    final_score_17 +
    final_score_18 +
    final_score_19 +
    final_score_20 +
    final_score_21 +
    final_score_22 +
    final_score_23 +
    final_score_24 +
    final_score_25 +
    final_score_26 +
    final_score_27 +
    final_score_28 +
    final_score_29 +
    final_score_30 +
    final_score_31 +
    final_score_32 +
    final_score_33 +
    final_score_34 +
    final_score_35 +
    final_score_36 +
    final_score_37 +
    final_score_38 +
    final_score_39 +
    final_score_40 +
    final_score_41 +
    final_score_42 +
    final_score_43 +
    final_score_44 +
    final_score_45 +
    final_score_46 +
    final_score_47 +
    final_score_48 +
    final_score_49 +
    final_score_50 +
    final_score_51 +
    final_score_52 +
    final_score_53 +
    final_score_54 +
    final_score_55 +
    final_score_56 +
    final_score_57 +
    final_score_58 +
    final_score_59 +
    final_score_60 +
    final_score_61 +
    final_score_62 +
    final_score_63 +
    final_score_64 +
    final_score_65 +
    final_score_66 +
    final_score_67 +
    final_score_68 +
    final_score_69 +
    final_score_70 +
    final_score_71 +
    final_score_72 +
    final_score_73 +
    final_score_74 +
    final_score_75 +
    final_score_76 +
    final_score_77 +
    final_score_78 +
    final_score_79 +
    final_score_80 +
    final_score_81 +
    final_score_82 +
    final_score_83 +
    final_score_84 +
    final_score_85 +
    final_score_86 +
    final_score_87 +
    final_score_88 +
    final_score_89 +
    final_score_90 +
    final_score_91 +
    final_score_92 +
    final_score_93 +
    final_score_94 +
    final_score_95 +
    final_score_96 +
    final_score_97 +
    final_score_98 +
    final_score_99 +
    final_score_100 +
    final_score_101 +
    final_score_102 +
    final_score_103 +
    final_score_104 +
    final_score_105 +
    final_score_106 +
    final_score_107 +
    final_score_108 +
    final_score_109 +
    final_score_110 +
    final_score_111;

base := 800;

point := 50;

odds := 1 / 20;

score_lnodds := round(point * (-final_score + ln(odds)) / ln(2) + base);

RVS1706_0_1 := min(900, if(max(501, score_lnodds) = NULL, -NULL, max(501, score_lnodds)));

deceased := map(
    rc_decsflag = '1'                                                       => 1,
    rc_ssndod != 0                                                         => 1,
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 2,
                                                                              0);
ov_ssnprior      := (rc_ssndobflag='1' or rc_pwssndobflag='1');
ov_corrections   := (rc_hrisksic=2225);

RVS1706_0 := map(
    deceased > 0          												=> 200,
    iv_rv5_unscorable = '1' 										=> 222,
				ov_ssnprior or ov_corrections				 => min(590, RVS1706_0_1),
																																									RVS1706_0_1);

l77_addrs_move_traj_index := if(iv_a46_l77_addrs_move_traj_index = 1 and (StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '')), aa_rc008, NULL);

a46_addrs_move_traj_index := if(iv_a46_l77_addrs_move_traj_index = 1 and (StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '')), NULL, aa_rc008);

e55_college_code := if(not((college_file_type in ['H', 'C', 'A']) or college_attendance), aa_rc029, NULL);

e56_college_code := if(not((college_file_type in ['H', 'C', 'A']) or college_attendance), NULL, aa_rc029);

e55_college_tier := if(not((college_file_type in ['H', 'C', 'A']) or college_attendance), aa_rc005, NULL);

e56_college_tier := if(not((college_file_type in ['H', 'C', 'A']) or college_attendance), NULL, aa_rc005);

i60_inq_addrs_per_adl := if(rv_i62_inq_addrs_per_adl < 2, aa_rc020, NULL);

i62_inq_addrs_per_adl := if(rv_i62_inq_addrs_per_adl < 2, NULL, aa_rc020);

rc_a44 := aa_rc002;

rc_a46 := a46_addrs_move_traj_index;

rc_a49 := aa_rc026;

rc_c12 := aa_rc023;

rc_c13 := aa_rc003 + aa_rc017;

rc_c14 := aa_rc015 + aa_rc039;

rc_c19 := aa_rc045;

rc_c20 := aa_rc040;

rc_c21 := aa_rc046;

rc_c22 := aa_rc006;

rc_c23 := aa_rc013;

rc_c24 := aa_rc027;

rc_c25 := aa_rc033;

rc_c26 := aa_rc016 +
    aa_rc010 +
    aa_rc044;

rc_c27 := aa_rc014;

rc_c28 := aa_rc025;

rc_d30_1 := max(0,aa_rc001);

rc_d31_1 := aa_rc034 + aa_rc035;

rc_d32_1 := aa_rc019 + aa_rc022;

rc_d33_1 := aa_rc009;

rc_d34_1 := aa_rc037;

//rc_e55 := e55_college_tier + e55_college_code;
rc_e55 := max(0,e55_college_tier )+ max(0,e55_college_code);

//rc_e56 := e56_college_tier + e56_college_code;
rc_e56 := max(0,e56_college_tier) + max(0,e56_college_code);

rc_e57 := aa_rc047;

rc_f00 := aa_rc004 +
    aa_rc007 +
    aa_rc028 +
    aa_rc030 +
    aa_rc031 +
    aa_rc032;

rc_f01 := aa_rc021;

rc_f05 := max(0,aa_rc011);

rc_i60 := max(0,aa_rc012) +
    max(0,i60_inq_addrs_per_adl) +
    max(0,i60_inq_addrs_per_adl) +
   max(0, aa_rc049);

rc_i62 := max(0,i62_inq_addrs_per_adl) + max(0,i62_inq_addrs_per_adl);

rc_l72 := aa_rc048;

rc_l77 := max(0,l77_addrs_move_traj_index);

rc_l79 := max(0,aa_rc024) +
    max(0,aa_rc036) +
    max(0,aa_rc041) +
    max(0,aa_rc043);



rc_p85 := aa_rc038;

rc_s66 := aa_rc018;

other_rcs_gt_d30_count := (integer)(rc_a44 > rc_d30_1) +
    (integer)(rc_a46 > rc_d30_1) +
    (integer)(rc_a49 > rc_d30_1) +
    (integer)(rc_c12 > rc_d30_1) +
    (integer)(rc_c13 > rc_d30_1) +
    (integer)(rc_c14 > rc_d30_1) +
    (integer)(rc_c19 > rc_d30_1) +
    (integer)(rc_c20 > rc_d30_1) +
    (integer)(rc_c21 > rc_d30_1) +
    (integer)(rc_c22 > rc_d30_1) +
    (integer)(rc_c23 > rc_d30_1) +
    (integer)(rc_c24 > rc_d30_1) +
    (integer)(rc_c25 > rc_d30_1) +
    (integer)(rc_c26 > rc_d30_1) +
    (integer)(rc_c27 > rc_d30_1) +
    (integer)(rc_c28 > rc_d30_1) +
    (integer)(rc_d30_1 > rc_d30_1) +
    (integer)(rc_d31_1 > rc_d30_1) +
    (integer)(rc_d32_1 > rc_d30_1) +
    (integer)(rc_d33_1 > rc_d30_1) +
    (integer)(rc_d34_1 > rc_d30_1) +
    (integer)(rc_e55 > rc_d30_1) +
    (integer)(rc_e56 > rc_d30_1) +
    (integer)(rc_e57 > rc_d30_1) +
    (integer)(rc_f00 > rc_d30_1) +
    (integer)(rc_f01 > rc_d30_1) +
    (integer)(rc_f05 > rc_d30_1) +
    (integer)(rc_i60 > rc_d30_1) +
    (integer)(rc_i62 > rc_d30_1) +
    (integer)(rc_l72 > rc_d30_1) +
    (integer)(rc_l77 > rc_d30_1) +
    (integer)(rc_l79 > rc_d30_1) +
    (integer)(rc_p85 > rc_d30_1) +
    (integer)(rc_s66 > rc_d30_1);

rc_d33 := if(other_rcs_gt_d30_count < 4, 0, rc_d33_1);

rc_d31 := if(other_rcs_gt_d30_count < 4, 0, rc_d31_1);

rc_d32 := if(other_rcs_gt_d30_count < 4, 0, rc_d32_1);

rc_d34 := if(other_rcs_gt_d30_count < 4, 0, rc_d34_1);

rc_d30 := if(other_rcs_gt_d30_count < 4, rc_d31_1 +
    rc_d32_1 +
    rc_d33_1 +
    rc_d34_1, rc_d30_1);

n_rc_a44 := 'A44';

n_rc_a46 := 'A46';

n_rc_a49 := 'A49';

n_rc_c12 := 'C12';

n_rc_c13 := 'C13';

n_rc_c14 := 'C14';

n_rc_c19 := 'C19';

n_rc_c20 := 'C20';

n_rc_c21 := 'C21';

n_rc_c22 := 'C22';

n_rc_c23 := 'C23';

n_rc_c24 := 'C24';

n_rc_c25 := 'C25';

n_rc_c26 := 'C26';

n_rc_c27 := 'C27';

n_rc_c28 := 'C28';

n_rc_d30 := 'D30';

n_rc_d31 := 'D31';

n_rc_d32 := 'D32';

n_rc_d33 := 'D33';

n_rc_d34 := 'D34';

n_rc_e55 := 'E55';

n_rc_e56 := 'E56';

n_rc_e57 := 'E57';

n_rc_f00 := 'F00';

n_rc_f01 := 'F01';

n_rc_f05 := 'F05';

n_rc_i60 := 'I60';

n_rc_i62 := 'I62';

n_rc_l72 := 'L72';

n_rc_l77 := 'L77';

n_rc_l79 := 'L79';

n_rc_p85 := 'P85';

n_rc_s66 := 'S66';

//*************************************************************************************//
// Reason Code Logic
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset := DATASET([
{n_RC_A44, RC_A44},
{n_RC_A46, RC_A46},
{n_RC_A49, RC_A49},
{n_RC_C12, RC_C12},
{n_RC_C13, RC_C13},
{n_RC_C14, RC_C14},
{n_RC_C19, RC_C19},
{n_RC_C20, RC_C20},
{n_RC_C21, RC_C21},
{n_RC_C22, RC_C22},
{n_RC_C23, RC_C23},
{n_RC_C24, RC_C24},
{n_RC_C25, RC_C25},
{n_RC_C26, RC_C26},
{n_RC_C27, RC_C27},
{n_RC_C28, RC_C28},
{n_RC_D30, RC_D30},
{n_RC_D31, RC_D31},
{n_RC_D32, RC_D32},
{n_RC_D33, RC_D33},
{n_RC_D34, RC_D34},
{n_RC_E55, RC_E55},
{n_RC_E56, RC_E56},
{n_RC_E57, RC_E57},
{n_RC_F00, RC_F00},
{n_RC_F01, RC_F01},
{n_RC_F05, RC_F05},
{n_RC_I60, RC_I60},
{n_RC_I62, RC_I62},
{n_RC_L72, RC_L72},
{n_RC_L77, RC_L77},
{n_RC_L79, RC_L79},
{n_RC_P85, RC_P85},
{n_RC_S66, RC_S66}
], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_sorted := sort(rc_dataset, -rc_dataset.value);
// rc_dataset_sorted := sort(rc_dataset, rc_dataset.value);

rc1_1 := rc_dataset_sorted[1].rc;
rc2_1 := rc_dataset_sorted[2].rc;
rc3_1 := rc_dataset_sorted[3].rc;
rc4_1 := rc_dataset_sorted[4].rc;


 rc4 := if((rvs1706_0 in [200, 222, 900]), '', rc4_1);
	
	rc2 := if((rvs1706_0 in [200, 222, 900]), '', rc2_1);
	
	rc3 := if((rvs1706_0 in [200, 222, 900]), '', rc3_1);
		
	rc1 := if((rvs1706_0 in [200, 222, 900]), '', rc1_1);
	

//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVS1706_0 = 200 => DATASET([{'00'}], HRILayout),
													RVS1706_0 = 222 => DATASET([{'00'}], HRILayout),
													RVS1706_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
																				self.seq              																:= le.seq;
                    self.sysdate                          := sysdate;
                    self.ver_src_ak_pos                   := ver_src_ak_pos;
                    self.ver_src_ak                       := ver_src_ak;
                    self._ver_src_fdate_ak                := _ver_src_fdate_ak;
                    self.ver_src_fdate_ak                 := (string)ver_src_fdate_ak;
                    self.ver_src_am_pos                   := ver_src_am_pos;
                    self.ver_src_am                       := ver_src_am;
                    self._ver_src_fdate_am                := _ver_src_fdate_am;
                    self.ver_src_fdate_am                 := (string)ver_src_fdate_am;
                    self.ver_src_ar_pos                   := ver_src_ar_pos;
                    self.ver_src_ar                       := ver_src_ar;
                    self._ver_src_fdate_ar                := _ver_src_fdate_ar;
                    self.ver_src_fdate_ar                 := (string)ver_src_fdate_ar;
                    self.ver_src_ba_pos                   := (string)ver_src_ba_pos;
                    self.ver_src_ba                       := ver_src_ba;
                    self._ver_src_fdate_ba                := _ver_src_fdate_ba;
                    self.ver_src_fdate_ba                 := (string)ver_src_fdate_ba;
                    self.ver_src_cg_pos                   := ver_src_cg_pos;
                    self.ver_src_cg                       := ver_src_cg;
                    self._ver_src_fdate_cg                := _ver_src_fdate_cg;
                    self.ver_src_fdate_cg                 := (string)ver_src_fdate_cg;
                    self.ver_src_co_pos                   := ver_src_co_pos;
                    self._ver_src_fdate_co                := _ver_src_fdate_co;
                    self.ver_src_fdate_co                 := (string)ver_src_fdate_co;
                    self.ver_src_cy_pos                   := (string)ver_src_cy_pos;
                    self.ver_src_cy                       := ver_src_cy;
                    self._ver_src_fdate_cy                := _ver_src_fdate_cy;
                    self.ver_src_fdate_cy                 := (string)ver_src_fdate_cy;
                    self.ver_src_da_pos                   := ver_src_da_pos;
                    self.ver_src_da                       := ver_src_da;
                    self._ver_src_fdate_da                := _ver_src_fdate_da;
                    self.ver_src_fdate_da                 := (string)ver_src_fdate_da;
                    self.ver_src_d_pos                    := (string)ver_src_d_pos;
                    self.ver_src_d                        := ver_src_d;
                    self._ver_src_fdate_d                 := _ver_src_fdate_d;
                    self.ver_src_fdate_d                  := (string)ver_src_fdate_d;
                    self.ver_src_dl_pos                   := (String)ver_src_dl_pos;
                    self.ver_src_dl                       := ver_src_dl;
                    self._ver_src_fdate_dl                := _ver_src_fdate_dl;
                    self.ver_src_fdate_dl                 := (String)ver_src_fdate_dl;
                    self.ver_src_ds_pos                   := (string)ver_src_ds_pos;
                    self.ver_src_ds                       := ver_src_ds;
                    self._ver_src_fdate_ds                := _ver_src_fdate_ds;
                    self.ver_src_fdate_ds                 := (String)ver_src_fdate_ds;
                    self.ver_src_de_pos                   := (String)ver_src_de_pos;
                    self.ver_src_de                       := ver_src_de;
                    self._ver_src_fdate_de                := _ver_src_fdate_de;
                    self.ver_src_fdate_de                 := (String)ver_src_fdate_de;
                    self.ver_src_eb_pos                   := (String)ver_src_eb_pos;
                    self.ver_src_eb                       := ver_src_eb;
                    self._ver_src_fdate_eb                := _ver_src_fdate_eb;
                    self.ver_src_fdate_eb                 := (String)ver_src_fdate_eb;
                    self.ver_src_em_pos                   := (String)ver_src_em_pos;
                    self.ver_src_em                       := ver_src_em;
                    self._ver_src_fdate_em                := _ver_src_fdate_em;
                    self.ver_src_fdate_em                 := (String)ver_src_fdate_em;
                    self.ver_src_e1_pos                   := (String)ver_src_e1_pos;
                    self.ver_src_e1                       := ver_src_e1;
                    self._ver_src_fdate_e1                := _ver_src_fdate_e1;
                    self.ver_src_fdate_e1                 := (String)ver_src_fdate_e1;
                    self.ver_src_e2_pos                   := (String)ver_src_e2_pos;
                    self.ver_src_e2                       := ver_src_e2;
                    self._ver_src_fdate_e2                := _ver_src_fdate_e2;
                    self.ver_src_fdate_e2                 := (String)ver_src_fdate_e2;
                    self.ver_src_e3_pos                   := ver_src_e3_pos;
                    self.ver_src_e3                       := ver_src_e3;
                    self._ver_src_fdate_e3                := (real)_ver_src_fdate_e3;
                    self.ver_src_fdate_e3                 := (string)ver_src_fdate_e3;
                    self.ver_src_e4_pos                   := (string)ver_src_e4_pos;
                    self.ver_src_e4                       := ver_src_e4;
                    self._ver_src_fdate_e4                := _ver_src_fdate_e4;
                    self.ver_src_fdate_e4                 := (string)ver_src_fdate_e4;
                    self.ver_src_en_pos                   := (string)ver_src_en_pos;
                    self.ver_src_en                       := ver_src_en;
                    self._ver_src_fdate_en                := (real)_ver_src_fdate_en;
                    self.ver_src_fdate_en                 := (String)ver_src_fdate_en;
                    self.ver_src_eq_pos                   := (string)ver_src_eq_pos;
                    self.ver_src_eq                       := ver_src_eq;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := (string)ver_src_fdate_eq;
                    self.ver_src_fe_pos                   := (string)ver_src_fe_pos;
                    self.ver_src_fe                       := ver_src_fe;
                    self._ver_src_fdate_fe                := _ver_src_fdate_fe;
                    self.ver_src_fdate_fe                 := (string)ver_src_fdate_fe;
                    self.ver_src_ff_pos                   := (string)ver_src_ff_pos;
                    self.ver_src_ff                       := ver_src_ff;
                    self._ver_src_fdate_ff                := _ver_src_fdate_ff;
                    self.ver_src_fdate_ff                 := (string)ver_src_fdate_ff;
                    self.ver_src_fr_pos                   := (string)ver_src_fr_pos;
                    self.ver_src_fr                       := ver_src_fr;
                    self._ver_src_fdate_fr                := (real)_ver_src_fdate_fr;
                    self.ver_src_fdate_fr                 := (string)ver_src_fdate_fr;
                    self.ver_src_l2_pos                   := (string)ver_src_l2_pos;
                    self.ver_src_l2                       := ver_src_l2;
                    self._ver_src_fdate_l2                := _ver_src_fdate_l2;
                    self.ver_src_fdate_l2                 := (string)ver_src_fdate_l2;
                    self.ver_src_li_pos                   := (String)ver_src_li_pos;
                    self.ver_src_li                       := ver_src_li;
                    self._ver_src_fdate_li                := _ver_src_fdate_li;
                    self.ver_src_fdate_li                 := (String)ver_src_fdate_li;
                    self.ver_src_mw_pos                   := ver_src_mw_pos;
                    self.ver_src_mw                       := ver_src_mw;
                    self._ver_src_fdate_mw                := (real)_ver_src_fdate_mw;
                    self.ver_src_fdate_mw                 := (String)ver_src_fdate_mw;
                    self.ver_src_nt_pos                   := (String)ver_src_nt_pos;
                    self.ver_src_nt                       := (String)ver_src_nt;
                    self._ver_src_fdate_nt                := (real)_ver_src_fdate_nt;
                    self.ver_src_fdate_nt                 := (String)ver_src_fdate_nt;
                    self.ver_src_p_pos                    := ver_src_p_pos;
                    self.ver_src_p                        := ver_src_p;
                    self._ver_src_fdate_p                 := (real)_ver_src_fdate_p;
                    self.ver_src_fdate_p                  := (String)ver_src_fdate_p;
                    self.ver_src_pl_pos                   := ver_src_pl_pos;
                    self.ver_src_pl                       := ver_src_pl;
                    self._ver_src_fdate_pl                := (Real)_ver_src_fdate_pl;
                    self.ver_src_fdate_pl                 := (string)ver_src_fdate_pl;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self.ver_src_tn                       := ver_src_tn;
                    self._ver_src_fdate_tn                := (real)_ver_src_fdate_tn;
                    self.ver_src_fdate_tn                 := (string)ver_src_fdate_tn;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self.ver_src_ts                       := ver_src_ts;
                    self._ver_src_fdate_ts                := (real)_ver_src_fdate_ts;
                    self.ver_src_fdate_ts                 := (String)ver_src_fdate_ts;
                    self.ver_src_tu_pos                   := ver_src_tu_pos;
                    self.ver_src_tu                       := ver_src_tu;
                    self._ver_src_fdate_tu                := (real)_ver_src_fdate_tu;
                    self.ver_src_fdate_tu                 := (String)ver_src_fdate_tu;
                    self.ver_src_sl_pos                   := (String)ver_src_sl_pos;
                    self.ver_src_sl                       := (String)ver_src_sl;
                    self._ver_src_fdate_sl                := (real)_ver_src_fdate_sl;
                    self.ver_src_fdate_sl                 := (String)ver_src_fdate_sl;
                    self.ver_src_v_pos                    := (String)ver_src_v_pos;
                    self.ver_src_v                        := (string)ver_src_v;
                    self._ver_src_fdate_v                 := (real)_ver_src_fdate_v;
                    self.ver_src_fdate_v                  := (String)ver_src_fdate_v;
                    self.ver_src_vo_pos                   := ver_src_vo_pos;
                    self.ver_src_vo                       := ver_src_vo;
                    self._ver_src_fdate_vo                := (real)_ver_src_fdate_vo;
                    self.ver_src_fdate_vo                 := (string)ver_src_fdate_vo;
                    self.ver_src_w_pos                    := (string)ver_src_w_pos;
                    self.ver_src_w                        := (string)ver_src_w;
                    self._ver_src_fdate_w                 := (Real)_ver_src_fdate_w;
                    self.ver_src_fdate_w                  := (String)ver_src_fdate_w;
                    self.ver_src_wp_pos                   := ver_src_wp_pos;
                    self.ver_src_wp                       := ver_src_wp;
                    self._ver_src_fdate_wp                := (real)_ver_src_fdate_wp;
                    self.ver_src_fdate_wp                 := (String)ver_src_fdate_wp;
                    self.ver_fname_src_en_pos             := ver_fname_src_en_pos;
                    self.ver_fname_src_en                 := ver_fname_src_en;
                    self.ver_fname_src_eq_pos             := (string)ver_fname_src_eq_pos;
                    self.ver_fname_src_eq                 := (String)ver_fname_src_eq;
                    self.ver_fname_src_tn_pos             := (string)ver_fname_src_tn_pos;
                    self.ver_fname_src_tn                 := (string)ver_fname_src_tn;
                    self.ver_fname_src_ts_pos             := (String)ver_fname_src_ts_pos;
                    self.ver_fname_src_ts                 := (String)ver_fname_src_ts;
                    self.ver_fname_src_tu_pos             := (string)ver_fname_src_tu_pos;
                    self.ver_fname_src_tu                 := (string)ver_fname_src_tu;
                    self.ver_lname_src_en_pos             := (String)ver_lname_src_en_pos;
                    self.ver_lname_src_en                 := (string)ver_lname_src_en;
                    self.ver_lname_src_eq_pos             := (string)ver_lname_src_eq_pos;
                    self.ver_lname_src_eq                 := (string)ver_lname_src_eq;
                    self.ver_lname_src_tn_pos             := (string)ver_lname_src_tn_pos;
                    self.ver_lname_src_tn                 := (string)ver_lname_src_tn;
                    self.ver_lname_src_ts_pos             := (string)ver_lname_src_ts_pos;
                    self.ver_lname_src_ts                 := (string)ver_lname_src_ts;
                    self.ver_lname_src_tu_pos             := (string)ver_lname_src_tu_pos;
                    self.ver_lname_src_tu                 := (string)ver_lname_src_tu;
                    self.ver_addr_src_en_pos              := (Integer)ver_addr_src_en_pos;
                    self.ver_addr_src_en                  := (Boolean)ver_addr_src_en;
                    self.ver_addr_src_eq_pos              := (Integer)ver_addr_src_eq_pos;
                    self.ver_addr_src_eq                  := (Boolean)ver_addr_src_eq;
                    self.ver_addr_src_tn_pos              := (Integer)ver_addr_src_tn_pos;
                    self.ver_addr_src_tn                  := (string)ver_addr_src_tn;
                    self.ver_addr_src_ts_pos              := (string)ver_addr_src_ts_pos;
                    self.ver_addr_src_ts                  := (string)ver_addr_src_ts;
                    self.ver_addr_src_tu_pos              := (string)ver_addr_src_tu_pos;
                    self.ver_addr_src_tu                  := (string)ver_addr_src_tu;
                    self.ver_ssn_src_en_pos               := (string)ver_ssn_src_en_pos;
                    self.ver_ssn_src_en                   := (string)ver_ssn_src_en;
                    self.ver_ssn_src_eq_pos               := (string)ver_ssn_src_eq_pos;
                    self.ver_ssn_src_eq                   := (string)ver_ssn_src_eq;
                    self.ver_ssn_src_tn_pos               := (string)ver_ssn_src_tn_pos;
                    self.ver_ssn_src_tn                   := (string)ver_ssn_src_tn;
                    self.ver_ssn_src_ts_pos               := (string)ver_ssn_src_ts_pos;
                    self.ver_ssn_src_ts                   := (string)ver_ssn_src_ts;
                    self.ver_ssn_src_tu_pos               := (string)ver_ssn_src_tu_pos;
                    self.ver_ssn_src_tu                   := (string)ver_ssn_src_tu;
                    self.ver_dob_src_en_pos               := (string)ver_dob_src_en_pos;
                    self.ver_dob_src_en                   := (string)ver_dob_src_en;
                    self.ver_dob_src_eq_pos               := (string)ver_dob_src_eq_pos;
                    self.ver_dob_src_eq                   := (string)ver_dob_src_eq;
                    self.ver_dob_src_tn_pos               := (string)ver_dob_src_tn_pos;
                    self.ver_dob_src_tn                   := (string)ver_dob_src_tn;
                    self.ver_dob_src_ts_pos               := (string)ver_dob_src_ts_pos;
                    self.ver_dob_src_ts                   := (string)ver_dob_src_ts;
                    self.ver_dob_src_tu_pos               := (string)ver_dob_src_tu_pos;
                    self.ver_dob_src_tu                   := (string)ver_dob_src_tu;
                    self.iv_add_apt                       := (string)iv_add_apt;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.rv_d30_derog_count               := (string)rv_d30_derog_count;
                    self.rv_a44_curr_add_naprop           := (string)rv_a44_curr_add_naprop;
                    self.rv_c13_inp_addr_lres             := (string)rv_c13_inp_addr_lres;
                    self.iv_f00_nas_summary               := iv_f00_nas_summary;
                    self.iv_college_tier                  := iv_college_tier;
                    self.iv_c22_addr_ver_sources          := (string)iv_c22_addr_ver_sources;
                    self.rv_f00_addr_not_ver_w_ssn        := (string)rv_f00_addr_not_ver_w_ssn;
                    self.iv_a46_l77_addrs_move_traj_index := (string)iv_a46_l77_addrs_move_traj_index;
                    self.rv_d33_eviction_recency          := (string)rv_d33_eviction_recency;
                    self.iv_num_non_bureau_sources        := (string)iv_num_non_bureau_sources;
                    self.iv_input_best_phone_match        := (string)iv_input_best_phone_match;
                    self.rv_i60_inq_hiriskcred_count12    := (string)rv_i60_inq_hiriskcred_count12;
                    self.rv_email_domain_free_count       := (string)rv_email_domain_free_count;
                    self.yr_in_dob                        := (string)yr_in_dob;
                    self.yr_in_dob_int                    := (string)yr_in_dob_int;
                    self.rv_comb_age                      := (string)rv_comb_age;
                    self.iv_unverified_addr_count         := (string)iv_unverified_addr_count;
                    self.iv_br_source_count               := (string)iv_br_source_count;
                    self.iv_c13_avg_lres                  := (string)iv_c13_avg_lres;
                    self.rv_s66_adlperssn_count           := (string)rv_s66_adlperssn_count;
                    self._felony_last_date                := (string)_felony_last_date;
                    self.rv_d32_criminal_behavior_lvl     := (string)rv_d32_criminal_behavior_lvl;
                    self.rv_i62_inq_addrs_per_adl         := (string)rv_i62_inq_addrs_per_adl;
                    self.rv_f01_inp_addr_address_score    := (string)rv_f01_inp_addr_address_score;
                    self._criminal_last_date              := (string)_criminal_last_date;
                    self.rv_d32_mos_since_crim_ls         := (string)rv_d32_mos_since_crim_ls;
                    self.src_bureau                       := (string)src_bureau;
                    self.src_behavioral                   := (string)src_behavioral;
                    self.src_inperson                     := (string)src_inperson;
                    self.iv_source_type                   := (string)iv_source_type;
                    self.rv_l79_adls_per_sfd_addr_c6      := (string)rv_l79_adls_per_sfd_addr_c6;
                    self._in_dob                          := (string)_in_dob;
                    self.earliest_bureau_date             := (string)earliest_bureau_date;
                    self.earliest_bureau_yrs              := (string)earliest_bureau_yrs;
                    self.calc_dob                         := (string)calc_dob;
                    self.non_bureau_sources               := (string)non_bureau_sources;
                    self.iv_bureau_emergence_age_buronly  := (string)iv_bureau_emergence_age_buronly;
                    self.earliest_header_date             := (string)earliest_header_date;
                    self.earliest_header_yrs              := (string)earliest_header_yrs;
                    self.iv_header_emergence_age          := (string)iv_header_emergence_age;
                    self.rv_a49_curr_avm_chg_1yr_pct      := (string)rv_a49_curr_avm_chg_1yr_pct;
                    self.iv_prv_addr_lres                 := (string)iv_prv_addr_lres;
                    self.num_bureau_fname                 := (string)num_bureau_fname;
                    self.num_bureau_lname                 := (string)num_bureau_lname;
                    self.num_bureau_addr                  := (string)num_bureau_addr;
                    self.num_bureau_ssn                   := (string)num_bureau_ssn;
                    self.num_bureau_dob                   := (string)num_bureau_dob;
                    self.iv_bureau_verification_index     := (string)iv_bureau_verification_index;
                    self.iv_college_code                  := (string)iv_college_code;
                    self.rv_f00_dob_score                 := rv_f00_dob_score;
                    self.rv_f00_ssn_score                 := (string)rv_f00_ssn_score;
                    self.rv_f00_input_dob_match_level     := (string)rv_f00_input_dob_match_level;
                    self.rv_d31_bk_filing_count           := (string)rv_d31_bk_filing_count;
                    self.rv_d31_mostrec_bk                := rv_d31_mostrec_bk;
                    self.rv_l79_adls_per_addr_c6          := (string)rv_l79_adls_per_addr_c6;
                    self.iv_d34_liens_unrel_sc_ct         := (string)iv_d34_liens_unrel_sc_ct;
                    self.rv_p85_phn_risk_level            := rv_p85_phn_risk_level;
                    self.rv_c14_addrs_10yr                := (string)rv_c14_addrs_10yr;
                    self.rv_c20_m_bureau_adl_fs           := (string)rv_c20_m_bureau_adl_fs;
                    self.rv_l79_adls_per_sfd_addr         := (string)rv_l79_adls_per_sfd_addr;
                    self.rv_i62_inq_num_names_per_adl     := (string)rv_i62_inq_num_names_per_adl;
                    self.rv_l79_adls_per_addr_curr        := (string)rv_l79_adls_per_addr_curr;
                    self.num_addr_sources                 := (string)num_addr_sources;
                    self.iv_addr_bureau_only              := (string)iv_addr_bureau_only;
                    self.rv_c19_add_prison_hist           := (string)rv_c19_add_prison_hist;
                    self.rv_c21_stl_inq_count             := (string)rv_c21_stl_inq_count;
                    self.iv_prof_license_category         := (string)iv_prof_license_category;
                    self.rv_l72_add_curr_vacant           := (string)rv_l72_add_curr_vacant;
                    self.rv_i62_inq_phonesperadl_recency  := (string)rv_i62_inq_phonesperadl_recency;
                    self.final_score_0                    := (string)final_score_0;
                    self.final_score_1                    := (string)final_score_1;
                    self.rc006_1_1                        := (string)rc006_1_1;
                    self.rc001_1_2                        := (string)rc001_1_2;
                    self.rc005_1_8                        := (string)rc005_1_8;
                    self.rc001_1_6                        := (string)rc001_1_6;
                    self.rc002_1_7                        := (string)rc002_1_7;
                    self.rc002_2_10                       := (string)rc002_2_10;
                    self.final_score_2                    := (string)final_score_2;
                    self.rc005_2_2                        := (string)rc005_2_2;
                    		self.rc001_2_9                        := (string)rc001_2_9;
                    self.rc003_2_1                        := (string)rc003_2_1;
                    self.rc001_2_4                        := (string)rc001_2_4;
                    self.rc009_3_11                       := (string)rc009_3_11;
                    self.final_score_3                    := (string)final_score_3;
                    self.rc004_3_1                        := (string)rc004_3_1;
                    self.rc005_3_2                        := (string)rc005_3_2;
                    self.rc001_3_6                        := (string)rc001_3_6;
                    self.rc002_3_7                        := (string)rc002_3_7;
                    self.final_score_4                    := (string)final_score_4;
                    self.rc005_4_8                        := (string)rc005_4_8;
                    self.rc002_4_2                        := (string)rc002_4_2;
                    self.rc001_4_7                        := (string)rc001_4_7;
                    self.rc002_4_6                        := (string)rc002_4_6;
                    self.rc003_4_1                        := (string)rc003_4_1;
                    self.rc001_5_3                        := (string)rc001_5_3;
                    self.final_score_5                    := (string)final_score_5;
                    self.rc007_5_1                        := (string)rc007_5_1;
                    self.rc002_5_2                        := (string)rc002_5_2;
                    self.rc005_5_12                       := (string)rc005_5_12;
                    self.rc005_5_4                        := (string)rc005_5_4;
                    self.rc004_6_1                        := (string)rc004_6_1;
                    self.rc002_6_2                        := (string)rc002_6_2;
                    self.final_score_6                    := (string)final_score_6;
                    self.rc001_6_7                        := (string)rc001_6_7;
                    self.rc005_6_8                        := (string)rc005_6_8;
                    self.rc008_6_6                        := (string)rc008_6_6;
                    self.rc001_7_9                        := (string)rc001_7_9;
                    self.rc010_7_10                       := (string)rc010_7_10;
                    self.rc001_7_4                        := (string)rc001_7_4;
                    self.rc003_7_1                        := (string)rc003_7_1;
                    self.rc005_7_2                        := (string)rc005_7_2;
                    self.final_score_7                    := (string)final_score_7;
                    self.final_score_8                    := (string)final_score_8;
                    self.rc002_8_1                        := (string)rc002_8_1;
                    self.rc009_8_3                        := (string)rc009_8_3;
                    self.rc007_8_2                        := (string)rc007_8_2;
                    self.rc014_8_5                        := (string)rc014_8_5;
                    self.rc012_8_7                        := (string)rc012_8_7;
                    self.rc002_9_1                        := (string)rc002_9_1;
                    self.rc014_9_6                        := (string)rc014_9_6;
                    self.final_score_9                    := (string)final_score_9;
                    self.rc019_9_8                        := (string)rc019_9_8;
                    self.rc006_9_2                        := (string)rc006_9_2;
                    self.rc009_9_4                        := (string)rc009_9_4;
                    self.final_score_10                   := (string)final_score_10;
                    self.rc001_10_2                       := (string)rc001_10_2;
                    self.rc003_10_1                       := (string)rc003_10_1;
                    self.rc002_10_9                       := (string)rc002_10_9;
                    self.rc005_10_3                       := (string)rc005_10_3;
                    self.rc001_10_10                      := (string)rc001_10_10;
                    self.final_score_11                   := (string)final_score_11;
                    self.rc008_11_9                       := (string)rc008_11_9;
                    self.rc001_11_2                       := (string)rc001_11_2;
                    self.rc005_11_3                       := (string)rc005_11_3;
                    self.rc004_11_1                       := (string)rc004_11_1;
                    self.rc005_11_10                      := (string)rc005_11_10;
                    self.rc005_12_2                       := (string)rc005_12_2;
                    self.final_score_12                   := (string)final_score_12;
                    self.rc019_12_4                       := (string)rc019_12_4;
                    self.rc012_12_9                       := (string)rc012_12_9;
                    self.rc011_12_10                      := (string)rc011_12_10;
                    self.rc003_12_1                       := (string)rc003_12_1;
                    self.rc002_13_1                       := (string)rc002_13_1;
                    self.rc022_13_6                       := (string)rc022_13_6;
                    self.rc009_13_4                       := (string)rc009_13_4;
                    self.rc016_13_8                       := (string)rc016_13_8;
                    self.rc005_13_2                       := (string)rc005_13_2;
                    self.final_score_13                   := (string)final_score_13;
                    self.rc023_14_3                       := (string)rc023_14_3;
                    self.rc007_14_1                       := (string)rc007_14_1;
                    self.rc020_14_2                       := (string)rc020_14_2;
                    self.rc009_14_8                       := (string)rc009_14_8;
                    self.final_score_14                   := (string)final_score_14;
                    self.rc001_14_4                       := (string)rc001_14_4;
                    self.rc017_15_6                       := (string)rc017_15_6;
                    self.rc008_15_1                       := (string)rc008_15_1;
                    self.final_score_15                   := (string)final_score_15;
                    self.rc009_15_4                       := (string)rc009_15_4;
                    self.rc010_15_12                      := (string)rc010_15_12;
                    self.rc005_15_2                       := (string)rc005_15_2;
                    self.final_score_16                   := (string)final_score_16;
                    self.rc002_16_1                       := (string)rc002_16_1;
                    self.rc016_16_3                       := (string)rc016_16_3;
                    self.rc029_16_4                       := (string)rc029_16_4;
                    self.rc011_16_2                       := (string)rc011_16_2;
                    self.rc022_16_5                       := (string)rc022_16_5;
                    self.rc015_17_3                       := (string)rc015_17_3;
                    self.rc010_17_2                       := (string)rc010_17_2;
                    self.rc020_17_7                       := (string)rc020_17_7;
                    self.rc001_17_1                       := (string)rc001_17_1;
                    self.final_score_17                   := (string)final_score_17;
                    self.rc010_17_12                      := (string)rc010_17_12;
                    self.rc013_18_6                       := (string)rc013_18_6;
                    self.rc011_18_4                       := (string)rc011_18_4;
                    self.rc019_18_5                       := (string)rc019_18_5;
                    self.final_score_18                   := (string)final_score_18;
                    self.rc002_18_1                       := (string)rc002_18_1;
                    self.rc005_18_2                       := (string)rc005_18_2;
                    self.rc001_19_6                       := (string)rc001_19_6;
                    self.rc017_19_1                       := (string)rc017_19_1;
                    self.final_score_19                   := (string)final_score_19;
                    self.rc025_19_4                       := (string)rc025_19_4;
                    self.rc005_19_2                       := (string)rc005_19_2;
                    self.rc012_19_12                      := (string)rc012_19_12;
                    self.rc001_20_4                       := (string)rc001_20_4;
                    self.final_score_20                   := (string)final_score_20;
                    self.rc021_20_1                       := (string)rc021_20_1;
                    self.rc010_20_9                       := (string)rc010_20_9;
                    self.rc014_20_5                       := (string)rc014_20_5;
                    self.rc008_21_1                       := (string)rc008_21_1;
                    self.rc024_21_4                       := (string)rc024_21_4;
                    self.rc033_21_12                      := (string)rc033_21_12;
                    self.rc017_21_2                       := (string)rc017_21_2;
                    self.final_score_21                   := (string)final_score_21;
                    self.rc021_21_5                       := (string)rc021_21_5;
                    self.rc016_22_2                       := (string)rc016_22_2;
                    self.rc017_22_5                       := (string)rc017_22_5;
                    self.rc018_22_4                       := (string)rc018_22_4;
                    self.rc002_22_1                       := (string)rc002_22_1;
                    self.final_score_22                   := (string)final_score_22;
                    self.rc029_22_3                       := (string)rc029_22_3;
                    self.final_score_23                   := (string)final_score_23;
                    self.rc001_23_1                       := (string)rc001_23_1;
                    self.rc028_23_8                       := (string)rc028_23_8;
                    self.rc024_23_4                       := (string)rc024_23_4;
                    self.rc023_23_3                       := (string)rc023_23_3;
                    self.rc012_23_2                       := (string)rc012_23_2;
                    self.rc002_24_10                      := (string)rc002_24_10;
                    self.rc013_24_3                       := (string)rc013_24_3;
                    self.final_score_24                   := (string)final_score_24;
                    self.rc022_24_4                       := (string)rc022_24_4;
                    self.rc011_24_1                       := (string)rc011_24_1;
                    self.rc018_24_2                       := (string)rc018_24_2;
                    self.rc028_25_8                       := (string)rc028_25_8;
                    self.rc032_25_3                       := (string)rc032_25_3;
                    self.rc015_25_9                       := (string)rc015_25_9;
                    self.final_score_25                   := (string)final_score_25;
                    self.rc009_25_1                       := (string)rc009_25_1;
                    self.rc015_25_4                       := (string)rc015_25_4;
                    self.rc016_26_4                       := (string)rc016_26_4;
                    self.rc011_26_1                       := (string)rc011_26_1;
                    self.rc013_26_5                       := (string)rc013_26_5;
                    self.final_score_26                   := (string)final_score_26;
                    self.rc022_26_6                       := (string)rc022_26_6;
                    self.rc005_26_2                       := (string)rc005_26_2;
                    self.rc008_27_6                       := (string)rc008_27_6;
                    self.rc001_27_1                       := (string)rc001_27_1;
                    self.rc033_27_3                       := (string)rc033_27_3;
                    self.rc034_27_12                      := (string)rc034_27_12;
                    self.rc012_27_2                       := (string)rc012_27_2;
                    self.final_score_27                   := (string)final_score_27;
                    self.rc028_28_4                       := (string)rc028_28_4;
                    self.rc019_28_9                       := (string)rc019_28_9;
                    self.rc015_28_5                       := (string)rc015_28_5;
                    self.final_score_28                   := (string)final_score_28;
                    self.rc013_28_1                       := (string)rc013_28_1;
                    self.rc032_28_2                       := (string)rc032_28_2;
                    self.rc013_29_2                       := (string)rc013_29_2;
                    self.final_score_29                   := (string)final_score_29;
                    self.rc014_29_1                       := (string)rc014_29_1;
                    self.rc010_29_11                      := (string)rc010_29_11;
                    self.rc020_29_7                       := (string)rc020_29_7;
                    self.rc001_29_6                       := (string)rc001_29_6;
                    self.rc009_30_12                      := (string)rc009_30_12;
                    self.rc015_30_2                       := (string)rc015_30_2;
                    self.rc002_30_4                       := (string)rc002_30_4;
                    self.rc008_30_5                       := (string)rc008_30_5;
                    self.final_score_30                   := (string)final_score_30;
                    self.rc010_30_1                       := (string)rc010_30_1;
                    self.rc017_31_11                      := (string)rc017_31_11;
                    self.final_score_31                   := (string)final_score_31;
                    self.rc027_31_7                       := (string)rc027_31_7;
                    self.rc030_31_9                       := (string)rc030_31_9;
                    self.rc026_31_1                       := (string)rc026_31_1;
                    self.rc019_31_3                       := (string)rc019_31_3;
                    self.rc012_32_2                       := (string)rc012_32_2;
                    self.final_score_32                   := (string)final_score_32;
                    self.rc036_32_3                       := (string)rc036_32_3;
                    self.rc013_32_8                       := (string)rc013_32_8;
                    self.rc018_32_1                       := (string)rc018_32_1;
                    self.rc019_32_4                       := (string)rc019_32_4;
                    self.rc027_33_4                       := (string)rc027_33_4;
                    self.rc024_33_10                      := (string)rc024_33_10;
                    self.final_score_33                   := (string)final_score_33;
                    self.rc031_33_2                       := (string)rc031_33_2;
                    self.rc021_33_1                       := (string)rc021_33_1;
                    self.rc020_33_9                       := (string)rc020_33_9;
                    self.rc005_34_3                       := (string)rc005_34_3;
                    self.final_score_34                   := (string)final_score_34;
                    self.rc025_34_6                       := (string)rc025_34_6;
                    self.rc016_34_1                       := (string)rc016_34_1;
                    self.rc024_34_5                       := (string)rc024_34_5;
                    self.rc011_34_2                       := (string)rc011_34_2;
                    self.rc016_35_3                       := (string)rc016_35_3;
                    self.final_score_35                   := (string)final_score_35;
                    self.rc011_35_2                       := (string)rc011_35_2;
                    self.rc030_35_6                       := (string)rc030_35_6;
                    self.rc005_35_4                       := (string)rc005_35_4;
                    self.rc001_35_1                       := (string)rc001_35_1;
                    self.final_score_36                   := (string)final_score_36;
                    self.rc017_36_9                       := (string)rc017_36_9;
                    self.rc039_36_2                       := (string)rc039_36_2;
                    self.rc031_36_11                      := (string)rc031_36_11;
                    self.rc031_36_4                       := (string)rc031_36_4;
                    self.rc027_36_1                       := (string)rc027_36_1;
                    self.final_score_37                   := (string)final_score_37;
                    self.rc037_37_7                       := (string)rc037_37_7;
                    self.rc026_37_12                      := (string)rc026_37_12;
                    self.rc013_37_3                       := (string)rc013_37_3;
                    self.rc018_37_1                       := (string)rc018_37_1;
                    self.rc014_37_2                       := (string)rc014_37_2;
                    self.rc015_38_7                       := (string)rc015_38_7;
                    self.rc026_38_3                       := (string)rc026_38_3;
                    self.final_score_38                   := (string)final_score_38;
                    self.rc016_38_6                       := (string)rc016_38_6;
                    self.rc019_38_2                       := (string)rc019_38_2;
                    self.rc013_38_1                       := (string)rc013_38_1;
                    self.rc017_39_6                       := (string)rc017_39_6;
                    self.rc011_39_3                       := (string)rc011_39_3;
                    self.rc030_39_8                       := (string)rc030_39_8;
                    self.final_score_39                   := (string)final_score_39;
                    self.rc027_39_4                       := (string)rc027_39_4;
                    self.rc009_39_1                       := (string)rc009_39_1;
                    self.rc030_40_7                       := (string)rc030_40_7;
                    self.rc015_40_4                       := (string)rc015_40_4;
                    self.rc040_40_3                       := (string)rc040_40_3;
                    self.rc005_40_1                       := (string)rc005_40_1;
                    self.rc028_40_6                       := (string)rc028_40_6;
                    self.final_score_40                   := (string)final_score_40;
                    self.rc009_41_3                       := (string)rc009_41_3;
                    self.rc018_41_1                       := (string)rc018_41_1;
                    self.rc010_41_12                      := (string)rc010_41_12;
                    self.final_score_41                   := (string)final_score_41;
                    self.rc023_41_5                       := (string)rc023_41_5;
                    self.rc012_41_2                       := (string)rc012_41_2;
                    self.rc017_42_7                       := (string)rc017_42_7;
                    self.rc001_42_3                       := (string)rc001_42_3;
                    self.rc018_42_9                       := (string)rc018_42_9;
                    self.final_score_42                   := (string)final_score_42;
                    self.rc027_42_2                       := (string)rc027_42_2;
                    self.rc012_42_1                       := (string)rc012_42_1;
                    self.final_score_43                   := (string)final_score_43;
                    self.rc022_43_4                       := (string)rc022_43_4;
                    self.rc024_43_1                       := (string)rc024_43_1;
                    self.rc014_43_2                       := (string)rc014_43_2;
                    self.rc031_43_12                      := (string)rc031_43_12;
                    self.rc013_43_6                       := (string)rc013_43_6;
                    self.rc008_44_2                       := (string)rc008_44_2;
                    self.rc015_44_3                       := (string)rc015_44_3;
                    self.rc012_44_1                       := (string)rc012_44_1;
                    self.rc033_44_10                      := (string)rc033_44_10;
                    self.final_score_44                   := (string)final_score_44;
                    self.rc010_44_5                       := (string)rc010_44_5;
                    self.rc014_45_1                       := (string)rc014_45_1;
                    self.rc021_45_7                       := (string)rc021_45_7;
                    self.rc037_45_9                       := (string)rc037_45_9;
                    self.final_score_45                   := (string)final_score_45;
                    self.rc019_45_6                       := (string)rc019_45_6;
                    self.rc013_45_2                       := (string)rc013_45_2;
                    self.rc018_46_1                       := (string)rc018_46_1;
                    self.final_score_46                   := (string)final_score_46;
                    self.rc025_46_2                       := (string)rc025_46_2;
                    self.rc010_46_7                       := (string)rc010_46_7;
                    self.rc016_46_6                       := (string)rc016_46_6;
                    self.rc026_46_8                       := (string)rc026_46_8;
                    self.rc015_47_6                       := (string)rc015_47_6;
                    self.rc028_47_5                       := (string)rc028_47_5;
                    self.rc038_47_1                       := (string)rc038_47_1;
                    self.rc008_47_2                       := (string)rc008_47_2;
                    self.final_score_47                   := (string)final_score_47;
                    self.rc015_47_3                       := (string)rc015_47_3;
                    self.rc031_48_1                       := (string)rc031_48_1;
                    self.rc014_48_9                       := (string)rc014_48_9;
                    self.rc010_48_3                       := (string)rc010_48_3;
                    self.rc025_48_5                       := (string)rc025_48_5;
                    self.final_score_48                   := (string)final_score_48;
                    self.rc013_48_4                       := (string)rc013_48_4;
                    self.final_score_49                   := (string)final_score_49;
                    self.rc011_49_6                       := (string)rc011_49_6;
                    self.rc035_49_1                       := (string)rc035_49_1;
                    self.rc001_49_3                       := (string)rc001_49_3;
                    self.rc034_49_2                       := (string)rc034_49_2;
                    self.rc049_49_4                       := (string)rc049_49_4;
                    self.rc015_50_6                       := (string)rc015_50_6;
                    self.rc029_50_1                       := (string)rc029_50_1;
                    self.final_score_50                   := (string)final_score_50;
                    self.rc028_50_5                       := (string)rc028_50_5;
                    self.rc024_50_2                       := (string)rc024_50_2;
                    self.rc030_50_3                       := (string)rc030_50_3;
                    self.rc024_51_5                       := (string)rc024_51_5;
                    self.rc014_51_12                      := (string)rc014_51_12;
                    self.rc011_51_2                       := (string)rc011_51_2;
                    self.rc005_51_3                       := (string)rc005_51_3;
                    self.final_score_51                   := (string)final_score_51;
                    self.rc013_51_1                       := (string)rc013_51_1;
                    self.rc027_52_2                       := (string)rc027_52_2;
                    self.rc008_52_3                       := (string)rc008_52_3;
                    self.rc013_52_9                       := (string)rc013_52_9;
                    self.final_score_52                   := (string)final_score_52;
                    self.rc014_52_11                      := (string)rc014_52_11;
                    self.rc036_52_1                       := (string)rc036_52_1;
                    self.rc014_53_4                       := (string)rc014_53_4;
                    self.rc018_53_1                       := (string)rc018_53_1;
                    self.rc032_53_2                       := (string)rc032_53_2;
                    self.final_score_53                   := (string)final_score_53;
                    self.rc025_53_13                      := (string)rc025_53_13;
                    self.rc017_53_6                       := (string)rc017_53_6;
                    self.rc045_54_6                       := (string)rc045_54_6;
                    self.final_score_54                   := (string)final_score_54;
                    self.rc032_54_7                       := (string)rc032_54_7;
                    self.rc016_54_1                       := (string)rc016_54_1;
                    self.rc038_54_2                       := (string)rc038_54_2;
                    self.rc026_54_3                       := (string)rc026_54_3;
                    self.rc029_55_2                       := (string)rc029_55_2;
                    self.rc015_55_7                       := (string)rc015_55_7;
                    self.final_score_55                   := (string)final_score_55;
                    self.rc016_55_3                       := (string)rc016_55_3;
                    self.rc026_55_4                       := (string)rc026_55_4;
                    self.rc013_55_1                       := (string)rc013_55_1;
                    self.final_score_56                   := (string)final_score_56;
                    self.rc044_56_7                       := (string)rc044_56_7;
                    self.rc015_56_2                       := (string)rc015_56_2;
                    self.rc017_56_8                       := (string)rc017_56_8;
                    self.rc041_56_6                       := (string)rc041_56_6;
                    self.rc021_56_1                       := (string)rc021_56_1;
                    self.rc031_57_1                       := (string)rc031_57_1;
                    self.rc011_57_3                       := (string)rc011_57_3;
                    self.rc001_57_4                       := (string)rc001_57_4;
                    self.rc010_57_6                       := (string)rc010_57_6;
                    self.final_score_57                   := (string)final_score_57;
                    self.rc045_57_5                       := (string)rc045_57_5;
                    self.rc025_58_2                       := (string)rc025_58_2;
                    self.rc037_58_1                       := (string)rc037_58_1;
                    self.rc031_58_7                       := (string)rc031_58_7;
                    self.rc017_58_3                       := (string)rc017_58_3;
                    self.rc013_58_9                       := (string)rc013_58_9;
                    self.final_score_58                   := (string)final_score_58;
                    self.rc025_59_4                       := (string)rc025_59_4;
                    self.rc013_59_1                       := (string)rc013_59_1;
                    self.final_score_59                   := (string)final_score_59;
                    self.rc030_59_2                       := (string)rc030_59_2;
                    self.rc019_59_6                       := (string)rc019_59_6;
                    self.rc035_59_7                       := (string)rc035_59_7;
                    self.final_score_60                   := (string)final_score_60;
                    self.rc047_60_4                       := (string)rc047_60_4;
                    self.rc045_60_6                       := (string)rc045_60_6;
                    self.rc009_60_1                       := (string)rc009_60_1;
                    self.rc019_60_5                       := (string)rc019_60_5;
                    self.rc046_60_3                       := (string)rc046_60_3;
                    self.rc048_61_1                       := (string)rc048_61_1;
                    self.rc005_61_4                       := (string)rc005_61_4;
                    self.rc034_61_6                       := (string)rc034_61_6;
                    self.rc035_61_8                       := (string)rc035_61_8;
                    self.rc030_61_2                       := (string)rc030_61_2;
                    self.final_score_61                   := (string)final_score_61;
                    self.rc009_62_8                       := (string)rc009_62_8;
                    self.final_score_62                   := (string)final_score_62;
                    self.rc045_62_7                       := (string)rc045_62_7;
                    self.rc025_62_1                       := (string)rc025_62_1;
                    self.rc018_62_6                       := (string)rc018_62_6;
                    self.rc017_62_2                       := (string)rc017_62_2;
                    self.rc027_63_1                       := (string)rc027_63_1;
                    self.rc017_63_7                       := (string)rc017_63_7;
                    self.rc037_63_6                       := (string)rc037_63_6;
                    self.rc014_63_9                       := (string)rc014_63_9;
                    self.final_score_63                   := (string)final_score_63;
                    self.rc039_63_2                       := (string)rc039_63_2;
                    self.rc030_64_2                       := (string)rc030_64_2;
                    self.rc037_64_7                       := (string)rc037_64_7;
                    self.rc046_64_1                       := (string)rc046_64_1;
                    self.rc034_64_8                       := (string)rc034_64_8;
                    self.rc033_64_4                       := (string)rc033_64_4;
                    self.final_score_64                   := (string)final_score_64;
                    self.rc015_65_9                       := (string)rc015_65_9;
                    self.rc026_65_2                       := (string)rc026_65_2;
                    self.rc023_65_11                      := (string)rc023_65_11;
                    self.rc036_65_1                       := (string)rc036_65_1;
                    self.final_score_65                   := (string)final_score_65;
                    self.rc020_65_4                       := (string)rc020_65_4;
                    self.rc014_66_1                       := (string)rc014_66_1;
                    self.rc015_66_6                       := (string)rc015_66_6;
                    self.rc040_66_11                      := (string)rc040_66_11;
                    self.rc041_66_7                       := (string)rc041_66_7;
                    self.final_score_66                   := (string)final_score_66;
                    self.rc015_66_2                       := (string)rc015_66_2;
                    self.rc035_67_2                       := (string)rc035_67_2;
                    self.final_score_67                   := (string)final_score_67;
                    self.rc031_67_10                      := (string)rc031_67_10;
                    self.rc015_67_6                       := (string)rc015_67_6;
                    self.rc036_67_1                       := (string)rc036_67_1;
                    self.rc010_67_8                       := (string)rc010_67_8;
                    self.rc008_68_3                       := (string)rc008_68_3;
                    self.final_score_68                   := (string)final_score_68;
                    self.rc015_68_5                       := (string)rc015_68_5;
                    self.rc010_68_4                       := (string)rc010_68_4;
                    self.rc012_68_1                       := (string)rc012_68_1;
                    self.rc041_68_2                       := (string)rc041_68_2;
                    self.final_score_69                   := (string)final_score_69;
                    self.rc025_69_11                      := (string)rc025_69_11;
                    self.rc038_69_1                       := (string)rc038_69_1;
                    self.rc014_69_7                       := (string)rc014_69_7;
                    self.rc018_69_2                       := (string)rc018_69_2;
                    self.rc016_69_3                       := (string)rc016_69_3;
                    self.rc017_70_4                       := (string)rc017_70_4;
                    self.rc001_70_3                       := (string)rc001_70_3;
                    self.rc026_70_1                       := (string)rc026_70_1;
                    self.rc047_70_10                      := (string)rc047_70_10;
                    self.rc043_70_11                      := (string)rc043_70_11;
                    self.final_score_70                   := (string)final_score_70;
                    self.rc013_71_2                       := (string)rc013_71_2;
                    self.rc038_71_4                       := (string)rc038_71_4;
                    self.rc001_71_1                       := (string)rc001_71_1;
                    self.rc048_71_3                       := (string)rc048_71_3;
                    self.final_score_71                   := (string)final_score_71;
                    self.rc041_71_5                       := (string)rc041_71_5;
                    self.final_score_72                   := (string)final_score_72;
                    self.rc029_72_2                       := (string)rc029_72_2;
                    self.rc016_72_1                       := (string)rc016_72_1;
                    self.rc015_72_4                       := (string)rc015_72_4;
                    self.rc040_72_3                       := (string)rc040_72_3;
                    self.rc027_72_6                       := (string)rc027_72_6;
                    self.rc012_73_3                       := (string)rc012_73_3;
                    self.rc001_73_4                       := (string)rc001_73_4;
                    self.rc010_73_10                      := (string)rc010_73_10;
                    self.rc015_73_11                      := (string)rc015_73_11;
                    self.final_score_73                   := (string)final_score_73;
                    self.rc026_73_1                       := (string)rc026_73_1;
                    self.final_score_74                   := (string)final_score_74;
                    self.rc011_74_11                      := (string)rc011_74_11;
                    self.rc013_74_2                       := (string)rc013_74_2;
                    self.rc043_74_6                       := (string)rc043_74_6;
                    self.rc014_74_1                       := (string)rc014_74_1;
                    self.rc031_74_7                       := (string)rc031_74_7;
                    self.rc009_75_2                       := (string)rc009_75_2;
                    self.rc028_75_8                       := (string)rc028_75_8;
                    self.final_score_75                   := (string)final_score_75;
                    self.rc046_75_1                       := (string)rc046_75_1;
                    self.rc023_75_6                       := (string)rc023_75_6;
                    self.rc015_75_4                       := (string)rc015_75_4;
                    self.rc043_76_3                       := (string)rc043_76_3;
                    self.rc010_76_4                       := (string)rc010_76_4;
                    self.rc030_76_1                       := (string)rc030_76_1;
                    self.final_score_76                   := (string)final_score_76;
                    self.rc015_76_5                       := (string)rc015_76_5;
                    self.rc028_76_7                       := (string)rc028_76_7;
                    self.final_score_77                   := (string)final_score_77;
                    self.rc001_77_8                       := (string)rc001_77_8;
                    self.rc002_77_3                       := (string)rc002_77_3;
                    self.rc043_77_4                       := (string)rc043_77_4;
                    self.rc035_77_1                       := (string)rc035_77_1;
                    self.rc034_77_2                       := (string)rc034_77_2;
                    self.rc031_78_2                       := (string)rc031_78_2;
                    self.rc046_78_7                       := (string)rc046_78_7;
                    self.final_score_78                   := (string)final_score_78;
                    self.rc033_78_4                       := (string)rc033_78_4;
                    self.rc033_78_11                      := (string)rc033_78_11;
                    self.rc038_78_1                       := (string)rc038_78_1;
                    self.rc037_79_4                       := (string)rc037_79_4;
                    self.rc045_79_2                       := (string)rc045_79_2;
                    self.final_score_79                   := (string)final_score_79;
                    self.rc040_79_8                       := (string)rc040_79_8;
                    self.rc018_79_3                       := (string)rc018_79_3;
                    self.rc019_79_1                       := (string)rc019_79_1;
                    self.rc016_80_3                       := (string)rc016_80_3;
                    self.rc022_80_4                       := (string)rc022_80_4;
                    self.rc027_80_6                       := (string)rc027_80_6;
                    self.final_score_80                   := (string)final_score_80;
                    self.rc037_80_2                       := (string)rc037_80_2;
                    self.rc013_80_1                       := (string)rc013_80_1;
                    self.rc015_81_4                       := (string)rc015_81_4;
                    self.rc040_81_6                       := (string)rc040_81_6;
                    self.rc011_81_2                       := (string)rc011_81_2;
                    self.rc020_81_1                       := (string)rc020_81_1;
                    self.final_score_81                   := (string)final_score_81;
                    self.rc034_81_3                       := (string)rc034_81_3;
                    self.rc025_82_1                       := (string)rc025_82_1;
                    self.rc001_82_11                      := (string)rc001_82_11;
                    self.rc032_82_3                       := (string)rc032_82_3;
                    self.rc013_82_2                       := (string)rc013_82_2;
                    self.rc026_82_9                       := (string)rc026_82_9;
                    self.final_score_82                   := (string)final_score_82;
                    self.rc018_83_1                       := (string)rc018_83_1;
                    self.rc039_83_13                      := (string)rc039_83_13;
                    self.rc034_83_3                       := (string)rc034_83_3;
                    self.rc041_83_4                       := (string)rc041_83_4;
                    self.final_score_83                   := (string)final_score_83;
                    self.rc035_83_2                       := (string)rc035_83_2;
                    self.rc025_84_13                      := (string)rc025_84_13;
                    self.rc018_84_1                       := (string)rc018_84_1;
                    self.rc001_84_2                       := (string)rc001_84_2;
                    self.rc005_84_4                       := (string)rc005_84_4;
                    self.final_score_84                   := (string)final_score_84;
                    self.rc044_85_7                       := (string)rc044_85_7;
                    self.rc041_85_6                       := (string)rc041_85_6;
                    self.final_score_85                   := (string)final_score_85;
                    self.rc014_85_2                       := (string)rc014_85_2;
                    self.rc018_85_1                       := (string)rc018_85_1;
                    self.rc028_85_4                       := (string)rc028_85_4;
                    self.rc015_86_1                       := (string)rc015_86_1;
                    self.final_score_86                   := (string)final_score_86;
                    self.rc023_86_9                       := (string)rc023_86_9;
                    self.rc017_86_11                      := (string)rc017_86_11;
                    self.rc018_86_2                       := (string)rc018_86_2;
                    self.rc025_86_5                       := (string)rc025_86_5;
                    self.rc015_87_3                       := (string)rc015_87_3;
                    self.rc035_87_1                       := (string)rc035_87_1;
                    self.rc031_87_8                       := (string)rc031_87_8;
                    self.final_score_87                   := (string)final_score_87;
                    self.rc034_87_7                       := (string)rc034_87_7;
                    self.rc032_87_2                       := (string)rc032_87_2;
                    self.rc041_88_7                       := (string)rc041_88_7;
                    self.rc013_88_1                       := (string)rc013_88_1;
                    self.final_score_88                   := (string)final_score_88;
                    self.rc021_88_2                       := (string)rc021_88_2;
                    self.rc014_88_10                      := (string)rc014_88_10;
                    self.rc048_88_3                       := (string)rc048_88_3;
                    self.rc023_89_5                       := (string)rc023_89_5;
                    self.rc001_89_12                      := (string)rc001_89_12;
                    self.rc015_89_3                       := (string)rc015_89_3;
                    self.final_score_89                   := (string)final_score_89;
                    self.rc029_89_1                       := (string)rc029_89_1;
                    self.rc040_89_2                       := (string)rc040_89_2;
                    self.rc025_90_1                       := (string)rc025_90_1;
                    self.rc026_90_6                       := (string)rc026_90_6;
                    self.final_score_90                   := (string)final_score_90;
                    self.rc011_90_10                      := (string)rc011_90_10;
                    self.rc030_90_2                       := (string)rc030_90_2;
                    self.rc037_90_9                       := (string)rc037_90_9;
                    self.rc030_91_2                       := (string)rc030_91_2;
                    self.final_score_91                   := (string)final_score_91;
                    self.rc009_91_4                       := (string)rc009_91_4;
                    self.rc029_91_7                       := (string)rc029_91_7;
                    self.rc047_91_6                       := (string)rc047_91_6;
                    self.rc035_91_1                       := (string)rc035_91_1;
                    self.rc047_92_3                       := (string)rc047_92_3;
                    self.rc035_92_4                       := (string)rc035_92_4;
                    self.rc031_92_1                       := (string)rc031_92_1;
                    self.rc034_92_5                       := (string)rc034_92_5;
                    self.rc009_92_6                       := (string)rc009_92_6;
                    self.final_score_92                   := (string)final_score_92;
                    self.rc010_93_4                       := (string)rc010_93_4;
                    self.rc048_93_5                       := (string)rc048_93_5;
                    self.rc046_93_1                       := (string)rc046_93_1;
                    self.rc031_93_2                       := (string)rc031_93_2;
                    self.final_score_93                   := (string)final_score_93;
                    self.rc014_93_12                      := (string)rc014_93_12;
                    self.final_score_94                   := (string)final_score_94;
                    self.rc039_94_4                       := (string)rc039_94_4;
                    self.rc017_94_8                       := (string)rc017_94_8;
                    self.rc035_94_1                       := (string)rc035_94_1;
                    self.rc045_94_2                       := (string)rc045_94_2;
                    self.rc027_94_3                       := (string)rc027_94_3;
                    self.rc022_95_2                       := (string)rc022_95_2;
                    self.rc045_95_4                       := (string)rc045_95_4;
                    self.rc013_95_6                       := (string)rc013_95_6;
                    self.final_score_95                   := (string)final_score_95;
                    self.rc012_95_5                       := (string)rc012_95_5;
                    self.rc037_95_1                       := (string)rc037_95_1;
                    self.rc025_96_10                      := (string)rc025_96_10;
                    self.rc018_96_1                       := (string)rc018_96_1;
                    self.rc024_96_12                      := (string)rc024_96_12;
                    self.rc032_96_6                       := (string)rc032_96_6;
                    self.rc009_96_2                       := (string)rc009_96_2;
                    self.final_score_96                   := (string)final_score_96;
                    self.rc044_97_7                       := (string)rc044_97_7;
                    self.rc023_97_12                      := (string)rc023_97_12;
                    self.rc043_97_2                       := (string)rc043_97_2;
                    self.rc014_97_3                       := (string)rc014_97_3;
                    self.final_score_97                   := (string)final_score_97;
                    self.rc015_97_1                       := (string)rc015_97_1;
                    self.rc011_98_2                       := (string)rc011_98_2;
                    self.rc033_98_13                      := (string)rc033_98_13;
                    self.rc018_98_1                       := (string)rc018_98_1;
                    self.final_score_98                   := (string)final_score_98;
                    self.rc030_98_3                       := (string)rc030_98_3;
                    self.rc043_98_5                       := (string)rc043_98_5;
                    self.rc015_99_2                       := (string)rc015_99_2;
                    self.rc012_99_3                       := (string)rc012_99_3;
                    self.final_score_99                   := (string)final_score_99;
                    self.rc014_99_9                       := (string)rc014_99_9;
                    self.rc018_99_1                       := (string)rc018_99_1;
                    self.rc025_99_13                      := (string)rc025_99_13;
                    self.rc017_100_7                      := (string)rc017_100_7;
                    self.rc027_100_1                      := (string)rc027_100_1;
                    self.rc036_100_12                     := (string)rc036_100_12;
                    self.rc039_100_2                      := (string)rc039_100_2;
                    self.final_score_100                  := (string)final_score_100;
                    self.rc025_100_3                      := (string)rc025_100_3;
                    self.rc043_101_4                      := (string)rc043_101_4;
                    self.rc016_101_3                      := (string)rc016_101_3;
                    self.rc007_101_12                     := (string)rc007_101_12;
                    self.rc038_101_1                      := (string)rc038_101_1;
                    self.final_score_101                  := (string)final_score_101;
                    self.rc024_101_2                      := (string)rc024_101_2;
                    self.final_score_102                  := (string)final_score_102;
                    self.rc039_102_2                      := (string)rc039_102_2;
                    self.rc020_102_6                      := (string)rc020_102_6;
                    self.rc027_102_1                      := (string)rc027_102_1;
                    self.rc001_102_10                     := (string)rc001_102_10;
                    self.rc036_102_13                     := (string)rc036_102_13;
                    self.rc029_103_3                      := (string)rc029_103_3;
                    self.final_score_103                  := (string)final_score_103;
                    self.rc047_103_1                      := (string)rc047_103_1;
                    self.rc016_103_2                      := (string)rc016_103_2;
                    self.rc043_103_5                      := (string)rc043_103_5;
                    self.rc010_103_4                      := (string)rc010_103_4;
                    self.rc015_104_1                      := (string)rc015_104_1;
                    self.rc040_104_6                      := (string)rc040_104_6;
                    self.final_score_104                  := (string)final_score_104;
                    self.rc016_104_3                      := (string)rc016_104_3;
                    self.rc015_104_4                      := (string)rc015_104_4;
                    self.rc034_104_2                      := (string)rc034_104_2;
                    self.rc014_105_1                      := (string)rc014_105_1;
                    self.final_score_105                  := (string)final_score_105;
                    self.rc013_105_8                      := (string)rc013_105_8;
                    self.rc013_105_2                      := (string)rc013_105_2;
                    self.rc028_105_6                      := (string)rc028_105_6;
                    self.rc037_105_9                      := (string)rc037_105_9;
                    self.final_score_106                  := (string)final_score_106;
                    self.rc043_106_1                      := (string)rc043_106_1;
                    self.rc015_106_11                     := (string)rc015_106_11;
                    self.rc044_106_6                      := (string)rc044_106_6;
                    self.rc014_106_2                      := (string)rc014_106_2;
                    self.rc041_106_7                      := (string)rc041_106_7;
                    self.rc017_107_9                      := (string)rc017_107_9;
                    self.rc046_107_1                      := (string)rc046_107_1;
                    self.final_score_107                  := (string)final_score_107;
                    self.rc038_107_3                      := (string)rc038_107_3;
                    self.rc047_107_2                      := (string)rc047_107_2;
                    self.rc013_107_4                      := (string)rc013_107_4;
                    self.rc009_108_1                      := (string)rc009_108_1;
                    self.rc039_108_2                      := (string)rc039_108_2;
                    self.rc026_108_11                     := (string)rc026_108_11;
                    self.final_score_108                  := (string)final_score_108;
                    self.rc013_108_7                      := (string)rc013_108_7;
                    self.rc024_108_6                      := (string)rc024_108_6;
                    self.rc026_109_1                      := (string)rc026_109_1;
                    self.final_score_109                  := (string)final_score_109;
                    self.rc034_109_13                     := (string)rc034_109_13;
                    self.rc012_109_3                      := (string)rc012_109_3;
                    self.rc019_109_4                      := (string)rc019_109_4;
                    self.rc018_109_5                      := (string)rc018_109_5;
                    self.rc026_110_4                      := (string)rc026_110_4;
                    self.rc028_110_3                      := (string)rc028_110_3;
                    self.rc044_110_11                     := (string)rc044_110_11;
                    self.final_score_110                  := (string)final_score_110;
                    self.rc015_110_1                      := (string)rc015_110_1;
                    self.rc034_110_7                      := (string)rc034_110_7;
                    self.rc038_111_3                      := (string)rc038_111_3;
                    self.rc044_111_7                      := (string)rc044_111_7;
                    self.rc043_111_2                      := (string)rc043_111_2;
                    self.rc035_111_1                      := (string)rc035_111_1;
                    self.final_score_111                  := (string)final_score_111;
                    self.rc033_111_9                      := (string)rc033_111_9;
                    self.aa_rc001                         := (string)aa_rc001;
                    self.aa_rc002                         := (string)aa_rc002;
                    self.aa_rc003                         := (string)aa_rc003;
                    self.aa_rc004                         := (string)aa_rc004;
                    self.aa_rc005                         := (string)aa_rc005;
                    self.aa_rc006                         := (string)aa_rc006;
                    self.aa_rc007                         := (string)aa_rc007;
                    self.aa_rc008                         := (string)aa_rc008;
                    self.aa_rc009                         := (string)aa_rc009;
                    self.aa_rc010                         := (string)aa_rc010;
                    self.aa_rc011                         := (string)aa_rc011;
                    self.aa_rc012                         := (string)aa_rc012;
                    self.aa_rc013                         := (string)aa_rc013;
                    self.aa_rc014                         := (string)aa_rc014;
                    self.aa_rc015                         := (string)aa_rc015;
                    self.aa_rc016                         := (string)aa_rc016;
                    self.aa_rc017                         := (string)aa_rc017;
                    self.aa_rc018                         := (string)aa_rc018;
                    self.aa_rc019                         := (string)aa_rc019;
                    self.aa_rc020                         := (string)aa_rc020;
                    self.aa_rc021                         := (string)aa_rc021;
                    self.aa_rc022                         := (string)aa_rc022;
                    self.aa_rc023                         := (string)aa_rc023;
                    self.aa_rc024                         := (string)aa_rc024;
                    self.aa_rc025                         := (string)aa_rc025;
                    self.aa_rc026                         := (string)aa_rc026;
                    self.aa_rc027                         := (string)aa_rc027;
                    self.aa_rc028                         := (string)aa_rc028;
                    self.aa_rc029                         := (string)aa_rc029;
                    self.aa_rc030                         := (string)aa_rc030;
                    self.aa_rc031                         := (string)aa_rc031;
                    self.aa_rc032                         := (string)aa_rc032;
                    self.aa_rc033                         := (string)aa_rc033;
                    self.aa_rc034                         := (string)aa_rc034;
                    self.aa_rc035                         := (string)aa_rc035;
                    self.aa_rc036                         := (string)aa_rc036;
                    self.aa_rc037                         := (string)aa_rc037;
                    self.aa_rc038                         := (string)aa_rc038;
                    self.aa_rc039                         := (string)aa_rc039;
                    self.aa_rc040                         := (string)aa_rc040;
                    self.aa_rc041                         := (string)aa_rc041;
                    self.aa_rc043                         := (string)aa_rc043;
                    self.aa_rc044                         := (string)aa_rc044;
                    self.aa_rc045                         := (string)aa_rc045;
                    self.aa_rc046                         := (string)aa_rc046;
                    self.aa_rc047                         := (string)aa_rc047;
                    self.aa_rc048                         := (string)aa_rc048;
                    self.aa_rc049                         := (string)aa_rc049;
                    self.final_score                      := (string)final_score;
                    self.base                             := (string)base;
                    self.point                            := (string)point;
                    self.odds                             := (string)odds;
                    self.score_lnodds                     := (string)score_lnodds;
                    self.deceased                         := (string)deceased;
                    self.RVS1706_0               									:= (string)RVS1706_0;
                    self.a46_addrs_move_traj_index        := (string)a46_addrs_move_traj_index;
                    self.l77_addrs_move_traj_index        := (string)l77_addrs_move_traj_index;
                    self.e55_college_tier                 := (string)e55_college_tier;
                    self.e56_college_code                 := (string)e56_college_code;
                    self.e55_college_code                 := (string)e55_college_code;
                    self.e56_college_tier                 := (string)e56_college_tier;
                    self.i60_inq_addrs_per_adl            := (string)i60_inq_addrs_per_adl;
                    self.i62_inq_addrs_per_adl            := (string)i62_inq_addrs_per_adl;
                    self.rc_a44                           := (string)rc_a44;
                    self.rc_a46                           := (string)rc_a46;
                    self.rc_a49                           := (string)rc_a49;
                    self.rc_c12                           := (string)rc_c12;
                    self.rc_c13                           := (string)rc_c13;
                    self.rc_c14                           := (string)rc_c14;
                    self.rc_c19                           := (string)rc_c19;
                    self.rc_c20                           := (string)rc_c20;
                    self.rc_c21                           := (string)rc_c21;
                    self.rc_c22                           := (string)rc_c22;
                    self.rc_c23                           := (string)rc_c23;
                    self.rc_c24                           := (string)rc_c24;
                    self.rc_c25                           := (string)rc_c25;
                    self.rc_c26                           := (string)rc_c26;
                    self.rc_c27                           := (string)rc_c27;
                    self.rc_c28                           := (string)rc_c28;
                    self.rc_e55                           := (string)rc_e55;
                    self.rc_e56                           := (string)rc_e56;
                    self.rc_e57                           := (string)rc_e57;
                    self.rc_f00                           := (string)rc_f00;
                    self.rc_f01                           := (string)rc_f01;
                    self.rc_f05                           := (string)rc_f05;
                    self.rc_i60                           := (string)rc_i60;
                    self.rc_i62                           := (string)rc_i62;
                    self.rc_l72                           := (string)rc_l72;
                    self.rc_l77                           := (string)rc_l77;
                    self.rc_l79                           := (string)rc_l79;
                    self.rc_p85                           := (string)rc_p85;
                    self.rc_s66                           := (string)rc_s66;
                    self.other_rcs_gt_d30_count           := (string)other_rcs_gt_d30_count;
                    self.rc_d31                           := (string)rc_d31;
                    self.rc_d34                           := (string)rc_d34;
                    self.rc_d30                           := (string)rc_d30;
                    self.rc_d33                           := (string)rc_d33;
                    self.rc_d32                           := (string)rc_d32;
                    self.n_rc_a44                         := (string)n_rc_a44;
                    self.n_rc_a46                         := (string)n_rc_a46;
                    self.n_rc_a49                         := (string)n_rc_a49;
                    self.n_rc_c12                         := (string)n_rc_c12;
                    self.n_rc_c13                         := (string)n_rc_c13;
                    self.n_rc_c14                         := (string)n_rc_c14;
                    self.n_rc_c19                         := (string)n_rc_c19;
                    self.n_rc_c20                         := (string)n_rc_c20;
                    self.n_rc_c21                         := (string)n_rc_c21;
                    self.n_rc_c22                         := (string)n_rc_c22;
                    self.n_rc_c23                         := (string)n_rc_c23;
                    self.n_rc_c24                         := (string)n_rc_c24;
                    self.n_rc_c25                         := (string)n_rc_c25;
                    self.n_rc_c26                         := (string)n_rc_c26;
                    self.n_rc_c27                         := (string)n_rc_c27;
                    self.n_rc_c28                         := (string)n_rc_c28;
                    self.n_rc_d30                         := (string)n_rc_d30;
                    self.n_rc_d31                         := (string)n_rc_d31;
                    self.n_rc_d32                         := (string)n_rc_d32;
                    self.n_rc_d33                         := (string)n_rc_d33;
                    self.n_rc_d34                         := (string)n_rc_d34;
                    self.n_rc_e55                         := (string)n_rc_e55;
                    self.n_rc_e56                         := (string)n_rc_e56;
                    self.n_rc_e57                         := (string)n_rc_e57;
                    self.n_rc_f00                         := (string)n_rc_f00;
                    self.n_rc_f01                         := (string)n_rc_f01;
                    self.n_rc_f05                         := (string)n_rc_f05;
                    self.n_rc_i60                         := (string)n_rc_i60;
                    self.n_rc_i62                         := (string)n_rc_i62;
                    self.n_rc_l72                         := (string)n_rc_l72;
                    self.n_rc_l77                         := (string)n_rc_l77;
                    self.n_rc_l79                         := (string)n_rc_l79;
                    self.n_rc_p85                         := (string)n_rc_p85;
                    self.n_rc_s66                         := (string)n_rc_s66;
                    self.rc1                              := (string)rc1;
                    self.rc4                              := (string)rc4;
                    self.rc2                              := (string)rc2;
                    self.rc3                              := (string)rc3;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvs1706_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));
	

	RETURN(model);
END;



