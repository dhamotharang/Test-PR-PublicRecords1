import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, easi, std;


export FP31604_0_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons = 6,
									boolean isFCRA=false) := FUNCTION

FP_DEBUG := false;

#if(FP_DEBUG)
	Layout_Debug := RECORD
UNSIGNED4 Seq;
INTEGER _acc_last_seen;
INTEGER _br_first_seen;
INTEGER _bureau_adl_fseen_en;
INTEGER _bureau_adl_fseen_en_1;
INTEGER _bureau_adl_fseen_en_2;
INTEGER _bureau_adl_fseen_eq;
INTEGER _bureau_adl_fseen_eq_1;
INTEGER _bureau_adl_fseen_eq_2;
INTEGER _bureau_adl_fseen_eq_3;
INTEGER _bureau_adl_fseen_tn;
INTEGER _bureau_adl_fseen_tn_1;
INTEGER _bureau_adl_fseen_ts;
INTEGER _bureau_adl_fseen_ts_1;
INTEGER _bureau_adl_fseen_tu;
INTEGER _bureau_adl_fseen_tu_1;
INTEGER _felony_last_date;
INTEGER _foreclosure_last_date;
REAL _fp3_lexid_model_lgt;
INTEGER _header_first_seen;
INTEGER _in_dob;
INTEGER _inq_banko_am_first_seen;
INTEGER _inq_banko_am_last_seen;
INTEGER _inq_banko_cm_first_seen;
INTEGER _inq_banko_cm_last_seen;
INTEGER _inq_banko_om_first_seen;
INTEGER _inq_banko_om_last_seen;
INTEGER _liens_rel_cj_first_seen;
INTEGER _liens_rel_cj_last_seen;
INTEGER _liens_rel_ft_first_seen;
INTEGER _liens_rel_ot_last_seen;
INTEGER _liens_unrel_cj_first_seen;
INTEGER _liens_unrel_cj_last_seen;
INTEGER _liens_unrel_ft_first_seen;
INTEGER _liens_unrel_ft_last_seen;
INTEGER _liens_unrel_o_first_seen;
INTEGER _liens_unrel_o_last_seen;
INTEGER _liens_unrel_ot_first_seen;
INTEGER _liens_unrel_ot_last_seen;
INTEGER _liens_unrel_sc_first_seen;
INTEGER _liens_unrel_sc_last_seen;
INTEGER _liens_unrel_st_first_seen;
INTEGER _liens_unrel_st_last_seen;
REAL _src_bureau_adl_fseen;
REAL _src_bureau_adl_fseen_1;
REAL _src_bureau_adl_fseen_all;
INTEGER acc_count;
INTEGER acc_count_12;
INTEGER acc_count_180;
INTEGER acc_count_24;
INTEGER acc_count_30;
INTEGER acc_count_36;
INTEGER acc_count_60;
INTEGER acc_count_90;
UNSIGNED acc_damage_amt_total;
INTEGER acc_last_seen;
INTEGER add_curr_avm_auto_val;
INTEGER add_curr_avm_auto_val_2;
STRING add_curr_financing_type;
INTEGER add_curr_lres;
INTEGER add_curr_naprop;
INTEGER add_curr_nhood_bus_ct;
INTEGER add_curr_nhood_mfd_ct;
REAL add_curr_nhood_prop_sum;
REAL add_curr_nhood_prop_sum_1;
REAL add_curr_nhood_prop_sum_2;
REAL add_curr_nhood_prop_sum_3;
INTEGER add_curr_nhood_sfd_ct;
INTEGER add_curr_nhood_vac_prop;
INTEGER add_curr_occ_index;
BOOLEAN add_curr_pop;
INTEGER add_input_naprop;
INTEGER add_prev_avm_auto_val;
INTEGER add_prev_lres;
INTEGER add_prev_naprop;
BOOLEAN add_prev_pop;
STRING addr_stability_v2;
INTEGER addrs_10yr;
INTEGER addrs_15yr;
INTEGER addrs_5yr;
INTEGER addrs_move_trajectory;
INTEGER addrs_move_trajectory_index;
INTEGER addrs_per_adl;
BOOLEAN addrs_prison_history;
INTEGER attr_addrs_last12;
INTEGER attr_addrs_last24;
INTEGER attr_addrs_last30;
INTEGER attr_addrs_last36;
INTEGER attr_addrs_last90;
INTEGER attr_arrests12;
INTEGER attr_arrests180;
INTEGER attr_arrests24;
INTEGER attr_arrests30;
INTEGER attr_arrests36;
INTEGER attr_arrests60;
INTEGER attr_arrests90;
INTEGER attr_bankruptcy_count12;
INTEGER attr_bankruptcy_count180;
INTEGER attr_bankruptcy_count24;
INTEGER attr_bankruptcy_count30;
INTEGER attr_bankruptcy_count36;
INTEGER attr_bankruptcy_count60;
INTEGER attr_bankruptcy_count90;
INTEGER attr_eviction_count;
INTEGER attr_eviction_count12;
INTEGER attr_eviction_count180;
INTEGER attr_eviction_count24;
INTEGER attr_eviction_count36;
INTEGER attr_eviction_count60;
INTEGER attr_eviction_count90;
INTEGER attr_felonies12;
INTEGER attr_felonies180;
INTEGER attr_felonies24;
INTEGER attr_felonies30;
INTEGER attr_felonies36;
INTEGER attr_felonies60;
INTEGER attr_felonies90;
INTEGER attr_num_aircraft;
INTEGER attr_num_nonderogs;
INTEGER attr_num_proflic12;
INTEGER attr_num_proflic180;
INTEGER attr_num_proflic24;
INTEGER attr_num_proflic30;
INTEGER attr_num_proflic36;
INTEGER attr_num_proflic60;
INTEGER attr_num_proflic90;
INTEGER attr_num_rel_liens12;
INTEGER attr_num_rel_liens180;
INTEGER attr_num_rel_liens24;
INTEGER attr_num_rel_liens30;
INTEGER attr_num_rel_liens36;
INTEGER attr_num_rel_liens60;
INTEGER attr_num_rel_liens90;
INTEGER attr_num_unrel_liens12;
INTEGER attr_num_unrel_liens180;
INTEGER attr_num_unrel_liens24;
INTEGER attr_num_unrel_liens30;
INTEGER attr_num_unrel_liens36;
INTEGER attr_num_unrel_liens60;
INTEGER attr_num_unrel_liens90;
INTEGER attr_total_number_derogs;
INTEGER avg_lres;
BOOLEAN bankrupt;
INTEGER base;
STRING bk_chapter;
INTEGER bk_dismissed_historical_count;
INTEGER bk_dismissed_recent_count;
INTEGER bk_disposed_historical_count;
INTEGER bk_disposed_recent_count;
INTEGER br_active_phone_count;
STRING br_company_title;
STRING br_company_title1;
STRING br_company_title2;
INTEGER br_dead_business_count;
INTEGER br_first_seen;
INTEGER br_first_seen_char;
INTEGER br_source_count;
INTEGER bureau_adl_en_fseen_pos;
INTEGER bureau_adl_en_fseen_pos_1;
INTEGER bureau_adl_en_fseen_pos_2;
INTEGER bureau_adl_eq_fseen_pos;
INTEGER bureau_adl_eq_fseen_pos_1;
INTEGER bureau_adl_eq_fseen_pos_2;
INTEGER bureau_adl_eq_fseen_pos_3;
STRING bureau_adl_fseen_en;
STRING bureau_adl_fseen_en_1;
STRING bureau_adl_fseen_en_2;
STRING bureau_adl_fseen_eq;
STRING bureau_adl_fseen_eq_1;
STRING bureau_adl_fseen_eq_2;
STRING bureau_adl_fseen_eq_3;
STRING bureau_adl_fseen_tn;
STRING bureau_adl_fseen_tn_1;
STRING bureau_adl_fseen_ts;
STRING bureau_adl_fseen_ts_1;
STRING bureau_adl_fseen_tu;
STRING bureau_adl_fseen_tu_1;
INTEGER bureau_adl_tn_fseen_pos;
INTEGER bureau_adl_tn_fseen_pos_1;
INTEGER bureau_adl_ts_fseen_pos;
INTEGER bureau_adl_ts_fseen_pos_1;
INTEGER bureau_adl_tu_fseen_pos;
INTEGER bureau_adl_tu_fseen_pos_1;
STRING c_ab_av_edu;
STRING c_asian_lang;
STRING c_assault;
STRING c_blue_col;
STRING c_born_usa;
STRING c_business;
STRING c_cartheft;
STRING c_child;
STRING c_civ_emp;
STRING c_construction;
STRING c_cpiall;
STRING c_easiqlife;
STRING c_employees;
STRING c_exp_homes;
STRING c_exp_prod;
STRING c_families;
STRING c_fammar_p;
STRING c_fammar18_p;
STRING c_famotf18_p;
STRING c_femdiv_p;
STRING c_finance;
STRING c_for_sale;
STRING c_health;
STRING c_hh1_p;
STRING c_hh2_p;
STRING c_hh3_p;
STRING c_hh4_p;
STRING c_hh5_p;
STRING c_hh6_p;
STRING c_hh7p_p;
STRING c_hhsize;
STRING c_high_ed;
STRING c_high_hval;
STRING c_highinc;
STRING c_housingcpi;
STRING c_hval_1001k_p;
STRING c_hval_100k_p;
STRING c_hval_125k_p;
STRING c_hval_300k_p;
STRING c_hval_400k_p;
STRING c_hval_500k_p;
STRING C_INC_125K_P;
STRING C_INC_150K_P;
STRING C_INC_25K_P;
STRING C_INC_50K_P;
STRING c_incollege;
STRING c_info;
STRING c_lar_fam;
STRING c_larceny;
STRING c_low_ed;
STRING c_low_hval;
STRING c_lowrent;
STRING c_lux_prod;
STRING c_many_cars;
STRING c_med_hhinc;
STRING c_med_rent;
STRING c_med_yearblt;
STRING c_mining;
STRING c_mort_indx;
STRING c_murders;
STRING c_no_labfor;
STRING c_oldhouse;
STRING C_OWNOCC_P;
STRING c_pop_0_5_p;
STRING c_pop_12_17_p;
STRING c_pop_18_24_p;
STRING c_pop_25_34_p;
STRING c_pop_35_44_p;
STRING c_pop_45_54_p;
STRING c_pop_6_11_p;
STRING c_pop_65_74_p;
STRING c_pop_75_84_p;
STRING c_popover25;
STRING c_rape;
STRING c_rental;
STRING c_rest_indx;
STRING c_retail;
STRING c_retired;
STRING c_retired2;
STRING c_rich_blk;
STRING c_rich_hisp;
STRING c_rich_old;
STRING c_rich_wht;
STRING c_rnt1500_p;
STRING c_rnt250_p;
STRING c_robbery;
STRING c_rural_p;
STRING c_serv_empl;
STRING c_sfdu_p;
STRING c_sub_bus;
STRING c_totcrime;
STRING c_totsales;
STRING c_transport;
STRING c_unemp;
STRING c_unempl;
STRING c_urban_p;
STRING c_vacant_p;
STRING c_white_col;
STRING c_young;
REAL census_mod;
STRING college_code;
STRING college_type;
INTEGER criminal_count;
INTEGER current_count;
STRING disposition;
INTEGER dl_addrs_per_adl;
INTEGER email_count;
INTEGER email_domain_isp_count;
INTEGER felony_count;
INTEGER felony_last_date;
INTEGER filing_count;
STRING filing_type;
STRING foreclosure_last_date;
STRING fp_assoccredbureaucount;
STRING fp_assoccredbureaucountnew;
STRING fp_assocrisktype;
STRING fp_assocsuspicousidcount;
STRING fp_curraddrburglaryindex;
STRING fp_curraddrcartheftindex;
STRING fp_curraddrcrimeindex;
STRING fp_curraddrmedianincome;
STRING fp_curraddrmedianvalue;
STRING fp_curraddrmurderindex;
STRING fp_idrisktype;
STRING fp_prevaddrageoldest;
STRING fp_prevaddrburglaryindex;
STRING fp_prevaddrcartheftindex;
STRING fp_prevaddrcrimeindex;
STRING fp_prevaddrlenofres;
STRING fp_prevaddrmedianincome;
STRING fp_prevaddrmedianvalue;
STRING fp_prevaddrmurderindex;
STRING fp_prevaddrstatus;
STRING fp_sourcerisktype;
STRING fp_srchfraudsrchcount;
STRING fp_srchfraudsrchcountmo;
STRING fp_srchfraudsrchcountwk;
STRING fp_srchfraudsrchcountyr;
STRING fp_srchunvrfdaddrcount;
STRING fp_srchunvrfddobcount;
STRING fp_srchunvrfdphonecount;
STRING fp_srchvelocityrisktype;
STRING fp_vardobcount;
STRING fp_vardobcountnew;
STRING fp_varmsrcssncount;
STRING fp_varrisktype;
REAL fp3_lexid_cen_mod_0;
REAL fp3_lexid_cen_mod_1;
REAL fp3_lexid_cen_mod_2;
REAL fp3_lexid_cen_mod_3;
REAL fp3_lexid_cen_mod_4;
REAL fp3_lexid_cen_mod_5;
REAL fp3_lexid_cen_mod_6;
REAL fp3_lexid_cen_mod_7;
REAL fp3_lexid_cen_mod_8;
REAL fp3_lexid_cen_mod_9;
REAL fp3_lexid_cen_mod_10;
REAL fp3_lexid_cen_mod_11;
REAL fp3_lexid_cen_mod_12;
REAL fp3_lexid_cen_mod_13;
REAL fp3_lexid_cen_mod_14;
REAL fp3_lexid_cen_mod_15;
REAL fp3_lexid_cen_mod_16;
REAL fp3_lexid_cen_mod_17;
REAL fp3_lexid_cen_mod_18;
REAL fp3_lexid_cen_mod_19;
REAL fp3_lexid_cen_mod_20;
REAL fp3_lexid_cen_mod_21;
REAL fp3_lexid_cen_mod_22;
REAL fp3_lexid_cen_mod_23;
REAL fp3_lexid_cen_mod_24;
REAL fp3_lexid_cen_mod_25;
REAL fp3_lexid_cen_mod_26;
REAL fp3_lexid_cen_mod_27;
REAL fp3_lexid_cen_mod_28;
REAL fp3_lexid_cen_mod_29;
REAL fp3_lexid_cen_mod_30;
REAL fp3_lexid_cen_mod_31;
REAL fp3_lexid_cen_mod_32;
REAL fp3_lexid_cen_mod_33;
REAL fp3_lexid_cen_mod_34;
REAL fp3_lexid_cen_mod_35;
REAL fp3_lexid_cen_mod_36;
REAL fp3_lexid_cen_mod_37;
REAL fp3_lexid_cen_mod_38;
REAL fp3_lexid_cen_mod_39;
REAL fp3_lexid_cen_mod_40;
REAL fp3_lexid_cen_mod_41;
REAL fp3_lexid_cen_mod_42;
REAL fp3_lexid_cen_mod_43;
REAL fp3_lexid_model_0;
REAL fp3_lexid_model_1;
REAL fp3_lexid_model_2;
REAL fp3_lexid_model_3;
REAL fp3_lexid_model_4;
REAL fp3_lexid_model_5;
REAL fp3_lexid_model_6;
REAL fp3_lexid_model_7;
REAL fp3_lexid_model_8;
REAL fp3_lexid_model_9;
REAL fp3_lexid_model_10;
REAL fp3_lexid_model_11;
REAL fp3_lexid_model_12;
REAL fp3_lexid_model_13;
REAL fp3_lexid_model_14;
REAL fp3_lexid_model_15;
REAL fp3_lexid_model_16;
REAL fp3_lexid_model_17;
REAL fp3_lexid_model_18;
REAL fp3_lexid_model_19;
REAL fp3_lexid_model_20;
REAL fp3_lexid_model_21;
REAL fp3_lexid_model_22;
REAL fp3_lexid_model_23;
REAL fp3_lexid_model_24;
REAL fp3_lexid_model_25;
REAL fp3_lexid_model_26;
REAL fp3_lexid_model_27;
REAL fp3_lexid_model_28;
REAL fp3_lexid_model_29;
REAL fp3_lexid_model_30;
REAL fp3_lexid_model_31;
REAL fp3_lexid_model_32;
REAL fp3_lexid_model_33;
REAL fp3_lexid_model_34;
REAL fp3_lexid_model_35;
REAL fp3_lexid_model_36;
REAL fp3_lexid_model_37;
REAL fp3_lexid_model_38;
REAL fp3_lexid_model_39;
REAL fp3_lexid_model_40;
REAL fp3_lexid_model_41;
REAL fp3_lexid_model_42;
REAL fp3_lexid_model_43;
REAL fp3_lexid_model_44;
REAL fp3_lexid_model_45;
REAL fp3_lexid_model_46;
REAL fp3_lexid_model_47;
REAL fp3_lexid_model_48;
REAL fp3_lexid_model_49;
REAL fp3_lexid_model_50;
REAL fp3_lexid_model_51;
REAL fp3_lexid_model_52;
REAL fp3_lexid_model_53;
REAL fp3_lexid_model_54;
REAL fp3_lexid_model_55;
REAL fp3_lexid_model_56;
REAL fp3_lexid_model_57;
REAL fp3_lexid_model_58;
REAL fp3_lexid_model_59;
REAL fp3_lexid_model_60;
REAL fp3_lexid_model_61;
REAL fp3_lexid_model_62;
REAL fp3_lexid_model_63;
REAL fp3_lexid_model_64;
REAL fp3_lexid_model_65;
REAL fp3_lexid_model_66;
REAL fp3_lexid_model_67;
REAL fp3_lexid_model_68;
REAL fp3_lexid_model_69;
REAL fp3_lexid_model_70;
REAL fp3_lexid_model_71;
REAL fp3_lexid_model_72;
REAL fp3_lexid_model_73;
REAL fp3_lexid_model_74;
REAL fp3_lexid_model_75;
REAL fp3_lexid_model_76;
REAL fp3_lexid_model_77;
REAL fp3_lexid_model_78;
REAL fp3_lexid_model_79;
REAL fp3_lexid_model_80;
REAL fp3_lexid_model_81;
REAL fp3_lexid_model_82;
REAL fp3_lexid_model_83;
REAL fp3_lexid_model_84;
REAL fp3_lexid_model_85;
REAL fp3_lexid_model_86;
REAL fp3_lexid_model_87;
REAL fp3_lexid_model_88;
REAL fp3_lexid_model_89;
REAL fp3_lexid_model_90;
REAL fp3_lexid_model_91;
REAL fp3_lexid_model_92;
REAL fp3_lexid_model_93;
REAL fp3_lexid_model_94;
REAL fp3_lexid_model_95;
REAL fp3_lexid_model_96;
REAL fp3_lexid_model_97;
REAL fp3_lexid_model_98;
REAL fp3_lexid_model_99;
REAL fp3_lexid_model_100;
REAL fp3_lexid_model_101;
REAL fp3_lexid_model_102;
REAL fp3_lexid_model_103;
REAL fp3_lexid_model_104;
REAL fp3_lexid_model_105;
REAL fp3_lexid_model_106;
REAL fp3_lexid_model_107;
REAL fp3_lexid_model_108;
REAL fp3_lexid_model_109;
REAL fp3_lexid_model_110;
REAL fp3_lexid_model_111;
REAL fp3_lexid_model_112;
REAL fp3_lexid_model_113;
REAL fp3_lexid_model_114;
REAL fp3_lexid_model_115;
REAL fp3_lexid_model_116;
REAL fp3_lexid_model_117;
REAL fp3_lexid_model_118;
REAL fp3_lexid_model_119;
REAL fp3_lexid_model_120;
REAL fp3_lexid_model_121;
REAL fp3_lexid_model_122;
REAL fp3_lexid_model_123;
REAL fp3_lexid_model_124;
REAL fp3_lexid_model_125;
REAL fp3_lexid_model_126;
REAL fp3_lexid_model_127;
REAL fp3_lexid_model_128;
REAL fp3_lexid_model_129;
REAL fp3_lexid_model_130;
REAL fp3_lexid_model_131;
REAL fp3_lexid_model_132;
REAL fp3_lexid_model_133;
REAL fp3_lexid_model_134;
REAL fp3_lexid_model_135;
REAL fp3_lexid_model_136;
REAL fp3_lexid_model_137;
REAL fp3_lexid_model_138;
REAL fp3_lexid_model_139;
REAL fp3_lexid_model_140;
REAL fp3_lexid_model_141;
REAL fp3_lexid_model_142;
REAL fp3_lexid_model_143;
REAL fp3_lexid_model_144;
REAL fp3_lexid_model_145;
REAL fp3_lexid_model_146;
REAL fp3_lexid_model_147;
REAL fp3_lexid_model_148;
REAL fp3_lexid_model_149;
REAL fp3_lexid_model_150;
REAL fp3_lexid_model_151;
REAL fp3_lexid_model_152;
REAL fp3_lexid_model_153;
REAL fp3_lexid_model_154;
REAL fp3_lexid_model_155;
REAL fp3_lexid_model_156;
REAL fp3_lexid_model_157;
REAL fp3_lexid_model_158;
REAL fp3_lexid_model_159;
REAL fp3_lexid_model_160;
REAL fp3_lexid_model_161;
REAL fp3_lexid_model_162;
REAL fp3_lexid_model_163;
REAL fp3_lexid_model_164;
REAL fp3_lexid_model_165;
REAL fp3_lexid_model_166;
REAL fp3_lexid_model_167;
REAL fp3_lexid_model_168;
REAL fp3_lexid_model_169;
REAL fp3_lexid_model_170;
REAL fp3_lexid_model_171;
REAL fp3_lexid_model_172;
REAL fp3_lexid_model_173;
REAL fp3_lexid_model_174;
REAL fp3_lexid_model_175;
REAL fp3_lexid_model_176;
REAL fp3_lexid_model_177;
REAL fp3_lexid_model_178;
REAL fp3_lexid_model_179;
REAL fp3_lexid_model_180;
REAL fp3_lexid_model_181;
REAL fp3_lexid_model_182;
REAL fp3_lexid_model_183;
REAL fp3_lexid_model_184;
REAL fp3_lexid_model_185;
REAL fp3_lexid_model_186;
REAL fp3_lexid_model_187;
REAL fp3_lexid_model_188;
REAL fp3_lexid_model_189;
REAL fp3_lexid_model_190;
REAL fp3_lexid_model_191;
REAL fp3_lexid_model_192;
REAL fp3_lexid_model_193;
REAL fp3_lexid_model_194;
REAL fp3_lexid_model_195;
REAL fp3_lexid_model_196;
REAL fp3_lexid_model_197;
REAL fp3_lexid_model_198;
REAL fp3_lexid_model_199;
REAL fp3_lexid_model_200;
REAL fp3_lexid_model_201;
REAL fp3_lexid_model_202;
REAL fp3_lexid_model_203;
REAL fp3_lexid_model_204;
REAL fp3_lexid_model_205;
REAL fp3_lexid_model_206;
REAL fp3_lexid_model_207;
REAL fp3_lexid_model_208;
REAL fp3_lexid_model_209;
REAL fp3_lexid_model_210;
REAL fp3_lexid_model_211;
REAL fp3_lexid_model_212;
REAL fp3_lexid_model_213;
REAL fp3_lexid_model_214;
REAL fp3_lexid_model_215;
REAL fp3_lexid_model_216;
REAL fp3_lexid_model_217;
REAL fp3_lexid_model_218;
REAL fp3_lexid_model_219;
REAL fp3_lexid_model_220;
REAL fp3_lexid_model_221;
REAL fp3_lexid_model_222;
REAL fp3_lexid_model_223;
REAL fp3_lexid_model_224;
REAL fp3_lexid_model_225;
REAL fp3_lexid_model_226;
REAL fp3_lexid_model_227;
REAL fp3_lexid_model_228;
REAL fp3_lexid_model_229;
REAL fp3_lexid_model_230;
REAL fp31604_0_0_1;
REAL fp31604_0_0_2;
STRING fp31604_0_0_score;
DECIMAL4_1 hdr_source_profile;
INTEGER header_first_seen;
INTEGER hh_age_18_to_30;
INTEGER hh_age_30_to_65;
INTEGER hh_age_65_plus;
INTEGER hh_bankruptcies;
INTEGER hh_collections_ct;
INTEGER hh_criminals;
INTEGER hh_lienholders;
INTEGER hh_members_ct;
INTEGER hh_members_w_derog;
INTEGER hh_payday_loan_users;
INTEGER hh_prof_license_holders;
INTEGER hh_property_owners_ct;
INTEGER hh_tot_derog;
INTEGER hh_workers_paw;
INTEGER historical_count;
STRING in_dob;
INTEGER inferred_age;
INTEGER inq_addrsperadl;
INTEGER inq_auto_count;
INTEGER inq_auto_count24;
INTEGER inq_banking_count;
INTEGER inq_banking_count12;
INTEGER inq_banking_count24;
STRING inq_banko_am_first_seen;
STRING inq_banko_am_last_seen;
STRING inq_banko_cm_first_seen;
STRING inq_banko_cm_last_seen;
STRING inq_banko_om_first_seen;
STRING inq_banko_om_last_seen;
INTEGER inq_collection_count;
INTEGER inq_collection_count01;
INTEGER inq_collection_count03;
INTEGER inq_collection_count06;
INTEGER inq_collection_count12;
INTEGER inq_collection_count24;
INTEGER inq_communications_count;
INTEGER inq_communications_count01;
INTEGER inq_communications_count03;
INTEGER inq_communications_count06;
INTEGER inq_communications_count12;
INTEGER inq_communications_count24;
INTEGER inq_count;
INTEGER inq_count_week;
INTEGER inq_count01;
INTEGER inq_count03;
INTEGER inq_count06;
INTEGER inq_count12;
INTEGER inq_count24;
INTEGER inq_dobsperadl;
INTEGER inq_highriskcredit_count;
INTEGER inq_highriskcredit_count01;
INTEGER inq_highriskcredit_count03;
INTEGER inq_highriskcredit_count06;
INTEGER inq_highriskcredit_count12;
INTEGER inq_highriskcredit_count24;
INTEGER inq_mortgage_count;
INTEGER inq_mortgage_count24;
INTEGER inq_other_count;
INTEGER inq_other_count_week;
INTEGER inq_other_count01;
INTEGER inq_other_count03;
INTEGER inq_other_count06;
INTEGER inq_other_count12;
INTEGER inq_other_count24;
INTEGER inq_phonesperadl;
INTEGER inq_prepaidcards_count;
INTEGER inq_prepaidcards_count01;
INTEGER inq_prepaidcards_count03;
INTEGER inq_prepaidcards_count06;
INTEGER inq_prepaidcards_count12;
INTEGER inq_prepaidcards_count24;
INTEGER inq_retail_count;
INTEGER inq_retailpayments_count;
INTEGER inq_retailpayments_count01;
INTEGER inq_retailpayments_count03;
INTEGER inq_retailpayments_count06;
INTEGER inq_retailpayments_count12;
INTEGER inq_retailpayments_count24;
INTEGER inq_ssnsperadl;
INTEGER inq_utilities_count;
INTEGER inq_utilities_count24;
INTEGER invalid_addrs_per_adl;
INTEGER invalid_ssns_per_adl;
REAL iv_a46_l77_addrs_move_traj;
REAL iv_a46_l77_addrs_move_traj_index;
REAL iv_br_source_count;
REAL iv_c13_avg_lres;
REAL iv_c14_addrs_per_adl;
INTEGER iv_college_code;
STRING iv_college_type;
STRING iv_curr_add_financing_type;
STRING iv_d31_bk_filing_type;
REAL iv_d34_liens_rel_ot_ct;
REAL iv_d34_liens_unrel_ot_ct;
REAL iv_d34_liens_unrel_sc_ct;
INTEGER iv_d57_attr_proflic_recency;
STRING iv_pb_profile;
INTEGER iv_prof_license_category_pl;
INTEGER iv_prof_license_category_pm;
INTEGER iv_prop1_purch_sale_diff;
INTEGER iv_prop2_purch_sale_diff;
REAL iv_prv_addr_avm_auto_val;
REAL iv_prv_addr_lres;
BOOLEAN iv_rv5_deceased;
INTEGER iv_unverified_addr_count;
INTEGER iv_wealth_index;
REAL lgt;
INTEGER liens_historical_released_count;
INTEGER liens_historical_unreleased_ct;
INTEGER liens_recent_unreleased_count;
INTEGER liens_rel_cj_first_seen;
INTEGER liens_rel_cj_last_seen;
INTEGER liens_rel_cj_total_amount;
INTEGER liens_rel_ft_first_seen;
INTEGER liens_rel_o_total_amount;
INTEGER liens_rel_ot_ct;
INTEGER liens_rel_ot_last_seen;
INTEGER liens_rel_ot_total_amount;
INTEGER liens_unrel_cj_first_seen;
INTEGER liens_unrel_cj_last_seen;
INTEGER liens_unrel_cj_total_amount;
INTEGER liens_unrel_ft_first_seen;
INTEGER liens_unrel_ft_last_seen;
INTEGER liens_unrel_ft_total_amount;
INTEGER liens_unrel_o_first_seen;
INTEGER liens_unrel_o_last_seen;
INTEGER liens_unrel_ot_ct;
INTEGER liens_unrel_ot_first_seen;
INTEGER liens_unrel_ot_last_seen;
INTEGER liens_unrel_ot_total_amount;
INTEGER liens_unrel_sc_ct;
INTEGER liens_unrel_sc_first_seen;
INTEGER liens_unrel_sc_last_seen;
INTEGER liens_unrel_sc_total_amount;
INTEGER liens_unrel_st_ct;
INTEGER liens_unrel_st_first_seen;
INTEGER liens_unrel_st_last_seen;
INTEGER liens_unrel_st_total_amount;
INTEGER max_lres;
UNSIGNED nf_acc_damage_amt_total;
REAL nf_accident_count;
INTEGER nf_accident_recency;
REAL nf_add_curr_nhood_bus_pct;
REAL nf_add_curr_nhood_mfd_pct;
REAL nf_add_curr_nhood_sfd_pct;
REAL nf_add_curr_nhood_vac_pct;
INTEGER nf_attr_arrest_recency;
REAL nf_average_rel_age;
REAL nf_average_rel_distance;
REAL nf_average_rel_home_val;
REAL nf_average_rel_income;
REAL nf_current_count;
REAL nf_dl_addrs_per_adl;
REAL nf_fp_assoccredbureaucount;
REAL nf_fp_assoccredbureaucountnew;
INTEGER nf_fp_assocrisktype;
REAL nf_fp_assocsuspicousidcount;
REAL nf_fp_curraddrburglaryindex;
REAL nf_fp_curraddrcartheftindex;
REAL nf_fp_curraddrcrimeindex;
REAL nf_fp_curraddrmedianincome;
REAL nf_fp_curraddrmedianvalue;
REAL nf_fp_curraddrmurderindex;
INTEGER nf_fp_idrisktype;
REAL nf_fp_prevaddrageoldest;
REAL nf_fp_prevaddrburglaryindex;
REAL nf_fp_prevaddrcartheftindex;
REAL nf_fp_prevaddrcrimeindex;
REAL nf_fp_prevaddrlenofres;
REAL nf_fp_prevaddrmedianincome;
REAL nf_fp_prevaddrmedianvalue;
REAL nf_fp_prevaddrmurderindex;
STRING nf_fp_prevaddrstatus;
INTEGER nf_fp_sourcerisktype;
REAL nf_fp_srchfraudsrchcount;
REAL nf_fp_srchfraudsrchcountmo;
REAL nf_fp_srchfraudsrchcountwk;
REAL nf_fp_srchfraudsrchcountyr;
INTEGER nf_fp_srchunvrfdaddrcount;
REAL nf_fp_srchunvrfddobcount;
INTEGER nf_fp_srchunvrfdphonecount;
INTEGER nf_fp_srchvelocityrisktype;
REAL nf_fp_vardobcount;
INTEGER nf_fp_vardobcountnew;
REAL nf_fp_varmsrcssncount;
INTEGER nf_fp_varrisktype;
REAL nf_hh_age_18_plus;
REAL nf_hh_age_30_plus;
REAL nf_hh_age_65_plus;
REAL nf_hh_bankruptcies;
REAL nf_hh_bankruptcies_pct;
REAL nf_hh_collections_ct;
REAL nf_hh_collections_ct_avg;
REAL nf_hh_criminals_pct;
REAL nf_hh_lienholders;
REAL nf_hh_lienholders_pct;
REAL nf_hh_members_ct;
REAL nf_hh_members_w_derog;
REAL nf_hh_payday_loan_users;
REAL nf_hh_payday_loan_users_pct;
REAL nf_hh_pct_property_owners;
REAL nf_hh_prof_license_holders_pct;
REAL nf_hh_property_owners_ct;
REAL nf_hh_tot_derog;
REAL nf_hh_tot_derog_avg;
REAL nf_hh_workers_paw_pct;
REAL nf_highest_rel_home_val;
REAL nf_highest_rel_income;
REAL nf_historical_count;
REAL nf_inq_auto_count;
REAL nf_inq_auto_count24;
REAL nf_inq_banking_count;
REAL nf_inq_banking_count24;
REAL nf_inq_collection_count;
REAL nf_inq_collection_count24;
REAL nf_inq_communications_count;
REAL nf_inq_communications_count24;
REAL nf_inq_count;
REAL nf_inq_count_week;
REAL nf_inq_count24;
INTEGER nf_inq_highriskcredit_count;
INTEGER nf_inq_highriskcredit_count24;
REAL nf_inq_mortgage_count;
REAL nf_inq_mortgage_count24;
REAL nf_inq_other_count;
REAL nf_inq_other_count_week;
REAL nf_inq_other_count24;
REAL nf_inq_prepaidcards_count;
REAL nf_inq_prepaidcards_count24;
REAL nf_inq_retailpayments_count;
REAL nf_inq_retailpayments_count24;
REAL nf_inq_utilities_count;
REAL nf_inq_utilities_count24;
REAL nf_liens_rel_cj_total_amt;
REAL nf_liens_rel_o_total_amt;
REAL nf_liens_rel_ot_total_amt;
REAL nf_liens_unrel_cj_total_amt;
REAL nf_liens_unrel_ft_total_amt;
REAL nf_liens_unrel_ot_total_amt;
REAL nf_liens_unrel_sc_total_amt;
REAL nf_liens_unrel_st_ct;
REAL nf_liens_unrel_st_total_amt;
REAL nf_lowest_rel_income;
REAL nf_m_bureau_adl_fs;
REAL nf_m_bureau_adl_fs_all;
INTEGER nf_m_bureau_adl_fs_notu;
REAL nf_mos_acc_lseen;
REAL nf_mos_foreclosure_lseen;
REAL nf_mos_inq_banko_am_lseen;
REAL nf_mos_inq_banko_cm_fseen;
REAL nf_mos_inq_banko_cm_lseen;
REAL nf_mos_inq_banko_om_fseen;
REAL nf_mos_inq_banko_om_lseen;
REAL nf_mos_liens_rel_cj_fseen;
REAL nf_mos_liens_rel_cj_lseen;
REAL nf_mos_liens_rel_ft_fseen;
REAL nf_mos_liens_rel_ot_lseen;
REAL nf_mos_liens_unrel_cj_fseen;
REAL nf_mos_liens_unrel_cj_lseen;
REAL nf_mos_liens_unrel_ft_fseen;
REAL nf_mos_liens_unrel_ft_lseen;
REAL nf_mos_liens_unrel_o_fseen;
REAL nf_mos_liens_unrel_o_lseen;
REAL nf_mos_liens_unrel_ot_fseen;
REAL nf_mos_liens_unrel_ot_lseen;
REAL nf_mos_liens_unrel_sc_lseen;
REAL nf_mos_liens_unrel_st_fseen;
REAL nf_mos_liens_unrel_st_lseen;
REAL nf_oldest_rel_age;
INTEGER nf_pb_retail_combo_cnt;
REAL nf_pb_retail_combo_max;
REAL nf_pct_rel_prop_owned;
REAL nf_pct_rel_prop_sold;
REAL nf_pct_rel_with_bk;
REAL nf_pct_rel_with_criminal;
REAL nf_pct_rel_with_felony;
REAL nf_rel_bankrupt_count;
REAL nf_rel_count;
REAL nf_rel_criminal_count;
REAL nf_rel_derog_summary;
REAL nf_rel_felony_count;
REAL nf_util_adl_count;
REAL nf_youngest_rel_age;
REAL offset;
STRING pb_average_dollars;
STRING pb_number_of_sources;
STRING pb_offline_dollars;
STRING pb_online_dollars;
STRING pb_retail_dollars;
STRING pb_total_dollars;
STRING pb_total_orders;
REAL pct_offline_dols;
REAL pct_online_dols;
REAL pct_retail_dols;
STRING prof_license_category;
BOOLEAN prof_license_flag;
STRING prof_license_source;
INTEGER prop1_prev_purchase_price;
INTEGER prop1_sale_price;
INTEGER prop2_prev_purchase_price;
INTEGER prop2_sale_price;
INTEGER property_owned_total;
INTEGER pts;
INTEGER r_c10_m_hdr_fs_d;  //Added to support reason code logic
STRING rc_decsflag;
INTEGER rc_ssndod;
INTEGER rel_ageover70_count;
INTEGER rel_ageunder20_count;
INTEGER rel_ageunder30_count;
INTEGER rel_ageunder40_count;
INTEGER rel_ageunder50_count;
INTEGER rel_ageunder60_count;
INTEGER rel_ageunder70_count;
INTEGER rel_bankrupt_count;
INTEGER rel_count;
INTEGER rel_criminal_count;
INTEGER rel_felony_count;
INTEGER rel_homeover500_count;
INTEGER rel_homeunder100_count;
INTEGER rel_homeunder150_count;
INTEGER rel_homeunder200_count;
INTEGER rel_homeunder300_count;
INTEGER rel_homeunder50_count;
INTEGER rel_homeunder500_count;
INTEGER rel_incomeover100_count;
INTEGER rel_incomeunder100_count;
INTEGER rel_incomeunder25_count;
INTEGER rel_incomeunder50_count;
INTEGER rel_incomeunder75_count;
INTEGER rel_prop_owned_count;
INTEGER rel_prop_sold_count;
INTEGER rel_within100miles_count;
INTEGER rel_within25miles_count;
INTEGER rel_within500miles_count;
INTEGER rel_withinother_count;
STRING rv_a41_a42_prop_owner_history;
STRING rv_a43_rec_vehx_level;
REAL rv_a46_curr_avm_autoval;
REAL rv_a49_curr_avm_chg_1yr_pct;
REAL rv_a50_pb_average_dollars;
REAL rv_a50_pb_total_dollars;
REAL rv_a50_pb_total_orders;
REAL rv_br_active_phone_count;
INTEGER rv_bus_leadership_title;
REAL rv_c10_m_hdr_fs;
REAL rv_c12_num_nonderogs;
DECIMAL64_32 rv_c12_source_profile;
REAL rv_c13_attr_addrs_recency;
REAL rv_c13_curr_addr_lres;
REAL rv_c13_max_lres;
INTEGER rv_c14_addr_stability_v2;
REAL rv_c14_addrs_10yr;
REAL rv_c14_addrs_15yr;
INTEGER rv_c16_inv_ssn_per_adl;
REAL rv_c18_invalid_addrs_per_adl;
REAL rv_c19_add_prison_hist;
REAL rv_c20_m_bureau_adl_fs;
REAL rv_c21_stl_inq_count180;
REAL rv_comb_age;
REAL rv_d30_derog_count;
STRING rv_d31_all_bk;
REAL rv_d31_attr_bankruptcy_recency;
INTEGER rv_d31_bk_chapter;
REAL rv_d31_bk_disposed_hist_count;
STRING rv_d31_mostrec_bk;
REAL rv_d32_attr_felonies_recency;
REAL rv_d32_criminal_count;
REAL rv_d32_felony_count;
REAL rv_d32_mos_since_fel_ls;
REAL rv_d33_eviction_count;
INTEGER rv_d33_eviction_recency;
REAL rv_d34_attr_liens_recency;
REAL rv_d34_unrel_lien60_count;
REAL rv_d34_unrel_liens_ct;
REAL rv_e58_br_dead_business_count;
REAL rv_email_count;
REAL rv_email_domain_isp_count;
INTEGER rv_ever_asset_owner;
REAL rv_f04_curr_add_occ_index;
REAL rv_i60_inq_banking_count12;
REAL rv_i60_inq_comm_recency;
REAL rv_i60_inq_hiriskcred_count12;
REAL rv_i60_inq_hiriskcred_recency;
REAL rv_i60_inq_other_count12;
REAL rv_i60_inq_other_recency;
REAL rv_i60_inq_prepaidcards_recency;
REAL rv_i60_inq_recency;
REAL rv_i60_inq_retpymt_recency;
REAL rv_i61_inq_collection_recency;
INTEGER rv_i62_inq_addrs_per_adl;
REAL rv_i62_inq_dobs_per_adl;
REAL rv_i62_inq_phones_per_adl;
REAL rv_i62_inq_ssns_per_adl;
REAL rv_mos_since_br_first_seen;
REAL rv_s66_ssns_per_adl_c6;
INTEGER ssns_per_adl_c6;
INTEGER stl_inq_count180;
REAL sum_dols;
INTEGER sysdate;
BOOLEAN truedid;
INTEGER unverified_addr_count;
INTEGER util_adl_count;
STRING ver_sources;
STRING ver_sources_first_seen;
INTEGER watercraft_count;
STRING wealth_index;
REAL yr_in_dob;
REAL yr_in_dob_int;

/* Added to support S1 - S5 */
BOOLEAN fnamepop;
BOOLEAN lnamepop;
BOOLEAN addrpop;
STRING ssnlength;
BOOLEAN dobpop;
BOOLEAN hphnpop;
INTEGER nas_summary;
STRING rc_ssndobflag;
BOOLEAN rc_ssnmiskeyflag;
BOOLEAN rc_addrmiskeyflag;
BOOLEAN add_input_house_number_match;
STRING rc_pwssndobflag;
INTEGER ssns_per_adl;
INTEGER lnames_per_adl_c6;
INTEGER nap_summary;
INTEGER stl_inq_count;
STRING fp_srchssnsrchcountmo;
STRING fp_srchaddrsrchcountmo;
STRING fp_srchphonesrchcountmo;
STRING nap_type;
BOOLEAN _inputmiskeys;
BOOLEAN _multiplessns;
INTEGER _src_bureau_adl_fseen_notu;
BOOLEAN _ssnpriortodob;
INTEGER _ver_src_cnt;
BOOLEAN _ver_src_de;
BOOLEAN _ver_src_ds;
BOOLEAN _ver_src_en;
BOOLEAN _ver_src_eq;
BOOLEAN _ver_src_tn;
BOOLEAN _ver_src_tu;
INTEGER _credit_source_cnt;
BOOLEAN _derog;
BOOLEAN _bureauonly;
BOOLEAN _deceased;
INTEGER _hh_strikes;
/* Added to support S1 - S5 */

models.layout_modelout;
risk_indicators.Layout_Boca_Shell clam;
END;

		layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
#else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri ) := TRANSFORM
#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	util_adl_count                   := le.utility.utili_adl_count;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
	prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
	prop2_sale_price                 := le.address_verification.recent_property_sales.sale_price2;
	prop2_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price2;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_financing_type          := le.address_verification.address_history_1.type_financing;
	add_curr_nhood_vac_prop          := le.addr_risk_summary2.N_Vacant_Properties;
	add_curr_nhood_bus_ct            := le.addr_risk_summary2.N_Business_Count;
	add_curr_nhood_sfd_ct            := le.addr_risk_summary2.N_SFD_Count;
	add_curr_nhood_mfd_ct            := le.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.addrPop2;
	add_prev_lres                    := le.lres3;
	add_prev_avm_auto_val            := le.avm.address_history_2.avm_automated_valuation;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	add_prev_pop                     := le.addrPop3;
	avg_lres                         := le.other_address_info.avg_lres;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_move_trajectory            := le.economic_trajectory;
	addrs_move_trajectory_index      := le.economic_trajectory_index;
	addrs_prison_history             := le.other_address_info.isprison;
	unverified_addr_count            := le.address_verification.unverified_addr_count;
	header_first_seen                := le.ssn_verification.header_first_seen;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count_week                   := if(isFCRA, 0, le.acc_logs.inquiries.countweek);
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_mortgage_count               := le.acc_logs.mortgage.counttotal;
	inq_mortgage_count24             := le.acc_logs.mortgage.count24;
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count_week             := if(isFCRA, 0, le.acc_logs.other.countweek);
	inq_other_count01                := le.acc_logs.other.count01;
	inq_other_count03                := le.acc_logs.other.count03;
	inq_other_count06                := le.acc_logs.other.count06;
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retailpayments_count         := le.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count01       := le.acc_logs.retailpayments.count01;
	inq_retailpayments_count03       := le.acc_logs.retailpayments.count03;
	inq_retailpayments_count06       := le.acc_logs.retailpayments.count06;
	inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
	inq_utilities_count              := le.acc_logs.utilities.counttotal;
	inq_utilities_count24            := le.acc_logs.utilities.count24;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
	inq_banko_am_first_seen          := le.acc_logs.am_first_seen_date;
	inq_banko_am_last_seen           := le.acc_logs.am_last_seen_date;
	inq_banko_cm_first_seen          := le.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.acc_logs.om_last_seen_date;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	pb_offline_dollars               := le.ibehavior.offline_dollars;
	pb_online_dollars                := le.ibehavior.online_dollars;
	pb_retail_dollars                := le.ibehavior.retail_dollars;
	br_company_title                 := le.employment.company_title;
	br_first_seen                    := le.employment.first_seen_date;
	br_dead_business_count           := le.employment.dead_business_ct;
	br_active_phone_count            := le.employment.business_active_phone_ct;
	br_source_count                  := le.employment.source_ct;
	stl_inq_count180                 := le.impulse.count180;
	email_count                      := le.email_summary.email_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_felonies30                  := le.bjl.criminal_count30;
	attr_felonies90                  := le.bjl.criminal_count90;
	attr_felonies180                 := le.bjl.criminal_count180;
	attr_felonies12                  := le.bjl.criminal_count12;
	attr_felonies24                  := le.bjl.criminal_count24;
	attr_felonies36                  := le.bjl.criminal_count36;
	attr_felonies60                  := le.bjl.criminal_count60;
	attr_arrests										 := le.bjl.arrests_count;			//
	attr_arrests30                   := le.bjl.arrests_count30;
	attr_arrests90                   := le.bjl.arrests_count90;
	attr_arrests180                  := le.bjl.arrests_count180;
	attr_arrests12                   := le.bjl.arrests_count12;
	attr_arrests24                   := le.bjl.arrests_count24;
	attr_arrests36                   := le.bjl.arrests_count36;
	attr_arrests60                   := le.bjl.arrests_count60;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_num_rel_liens30             := le.bjl.liens_released_count30;
	attr_num_rel_liens90             := le.bjl.liens_released_count90;
	attr_num_rel_liens180            := le.bjl.liens_released_count180;
	attr_num_rel_liens12             := le.bjl.liens_released_count12;
	attr_num_rel_liens24             := le.bjl.liens_released_count24;
	attr_num_rel_liens36             := le.bjl.liens_released_count36;
	attr_num_rel_liens60             := le.bjl.liens_released_count60;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_proflic30               := le.professional_license.proflic_count30;
	attr_num_proflic90               := le.professional_license.proflic_count90;
	attr_num_proflic180              := le.professional_license.proflic_count180;
	attr_num_proflic12               := le.professional_license.proflic_count12;
	attr_num_proflic24               := le.professional_license.proflic_count24;
	attr_num_proflic36               := le.professional_license.proflic_count36;
	attr_num_proflic60               := le.professional_license.proflic_count60;
	fp_idrisktype                    := le.fdattributesv2.identityrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_varmsrcssncount               := le.fdattributesv2.variationmsourcesssncount;
	fp_vardobcount                   := le.fdattributesv2.variationdobcount;
	fp_vardobcountnew                := le.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_assoccredbureaucount          := le.fdattributesv2.assoccreditbureauonlycount;
	fp_assoccredbureaucountnew       := le.fdattributesv2.assoccreditbureauonlycountnew;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddrstatus                := le.fdattributesv2.prevaddrstatus;
	fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	bankrupt                         := le.bjl.bankrupt;
	filing_type                      := le.bjl.filing_type;
	disposition                      := Std.Str.ToUpperCase(le.bjl.disposition);
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_chapter                       := le.bjl.bk_chapter;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := le.BJL.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.BJL.liens_historical_unreleased_count;
	liens_historical_released_count  := le.BJL.liens_historical_released_count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_first_seen        := le.liens.liens_unreleased_federal_tax.earliest_filing_date;
	liens_unrel_ft_last_seen         := le.liens.liens_unreleased_federal_tax.most_recent_filing_date;
	liens_unrel_ft_total_amount      := le.liens.liens_unreleased_federal_tax.total_amount;
	liens_rel_ft_first_seen          := le.liens.liens_released_federal_tax.earliest_filing_date;
	liens_unrel_o_first_seen         := le.liens.liens_unreleased_other_lj.earliest_filing_date;
	liens_unrel_o_last_seen          := le.liens.liens_unreleased_other_lj.most_recent_filing_date;
	liens_rel_o_total_amount         := le.liens.liens_released_other_lj.total_amount;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	liens_rel_ot_total_amount        := le.liens.liens_released_other_tax.total_amount;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_unrel_sc_last_seen         := le.liens.liens_unreleased_small_claims.most_recent_filing_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_unrel_st_first_seen        := le.liens.liens_unreleased_suits.earliest_filing_date;
	liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
	liens_unrel_st_total_amount      := le.liens.liens_unreleased_suits.total_amount;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	foreclosure_last_date            := le.bjl.last_foreclosure_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_property_owners_ct            := le.hhid_summary.hh_property_owners_ct;
	hh_age_65_plus                   := le.hhid_summary.hh_age_65_plus;
	hh_age_30_to_65                  := le.hhid_summary.hh_age_31_to_65;
	hh_age_18_to_30                  := le.hhid_summary.hh_age_18_to_30;
	hh_collections_ct                := le.hhid_summary.hh_collections_ct;
	hh_workers_paw                   := le.hhid_summary.hh_workers_paw;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_tot_derog                     := le.hhid_summary.hh_tot_derog;
	hh_bankruptcies                  := le.hhid_summary.hh_bankruptcies;
	hh_lienholders                   := le.hhid_summary.hh_lienholders;
	hh_prof_license_holders          := le.hhid_summary.hh_prof_license_holders;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_count                        := le.relatives.relative_count;
	rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.relatives.relative_criminal_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
	rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.relatives.relative_within500miles_count;
	rel_withinother_count            := le.relatives.relative_withinother_count;
	rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
	rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_homeunder50_count            := le.relatives.relative_homeunder50_count;
	rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	rel_ageunder20_count             := le.relatives.relative_ageunder20_count;
	rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	acc_count                        := le.accident_data.acc.num_accidents;
	acc_damage_amt_total             := le.accident_data.acc.dmgamtaccidents;
	acc_last_seen                    := le.accident_data.acc.datelastaccident;
	acc_count_30                     := le.accident_data.acc.numaccidents30;
	acc_count_90                     := le.accident_data.acc.numaccidents90;
	acc_count_180                    := le.accident_data.acc.numaccidents180;
	acc_count_12                     := le.accident_data.acc.numaccidents12;
	acc_count_24                     := le.accident_data.acc.numaccidents24;
	acc_count_36                     := le.accident_data.acc.numaccidents36;
	acc_count_60                     := le.accident_data.acc.numaccidents60;
	college_code                     := le.student.college_code;
	college_type                     := le.student.college_type;
	prof_license_flag                := le.professional_license.professional_license_flag;
	prof_license_category            := le.professional_license.plcategory;
	prof_license_source              := le.professional_license.proflic_source;
	wealth_index                     := le.wealth_indicator;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	
	
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	nas_summary                      := le.iid.nas_summary;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	nap_summary                      := le.iid.nap_summary;
	stl_inq_count                    := le.impulse.count;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	nap_type                         := le.iid.nap_type;
	
	
	C_INC_125K_P                     := (string)ri.in125k_p;
	C_INC_150K_P                     := (string)ri.in150k_p;
	C_INC_25K_P                      := (string)ri.in25k_p;
	C_INC_50K_P                      := (string)ri.in50k_p;
	C_OWNOCC_P                       := (string)ri.ownocp;
	c_ab_av_edu                      := (string)ri.ab_av_edu;
	c_asian_lang                     := (string)ri.asian_lang;
	c_assault                        := (string)ri.assault;
	c_blue_col                       := (string)ri.blue_col;
	c_born_usa                       := (string)ri.born_usa;
	c_business                       := (string)ri.business;
	c_cartheft                       := (string)ri.cartheft;
	c_child                          := (string)ri.child;
	c_civ_emp                        := (string)ri.civ_emp;
	c_construction                   := (string)ri.construction;
	c_cpiall                         := (string)ri.cpiall;
	c_easiqlife                      := (string)ri.easiqlife;
	c_employees                      := (string)ri.employees;
	c_exp_homes                      := (string)ri.exp_homes;
	c_exp_prod                       := (string)ri.exp_prod;
	c_families                       := (string)ri.families;
	c_fammar18_p                     := (string)ri.fammar18_p;
	c_fammar_p                       := (string)ri.fammar_p;
	c_famotf18_p                     := (string)ri.famotf18_p;
	c_femdiv_p                       := (string)ri.femdiv_p;
	c_finance                        := (string)ri.finance;
	c_for_sale                       := (string)ri.for_sale;
	c_health                         := (string)ri.health;
	c_hh1_p                          := (string)ri.hh1_p;
	c_hh2_p                          := (string)ri.hh2_p;
	c_hh3_p                          := (string)ri.hh3_p;
	c_hh4_p                          := (string)ri.hh4_p;
	c_hh5_p                          := (string)ri.hh5_p;
	c_hh6_p                          := (string)ri.hh6_p;
	c_hh7p_p                         := (string)ri.hh7p_p;
	c_hhsize                         := (string)ri.hhsize;
	c_high_ed                        := (string)ri.high_ed;
	c_high_hval                      := (string)ri.high_hval;
	c_highinc                        := (string)ri.highinc;
	c_housingcpi                     := (string)ri.housingcpi;
	c_hval_1001k_p                   := (string)ri.hval_1001k_p;
	c_hval_100k_p                    := (string)ri.hval_100k_p;
	c_hval_125k_p                    := (string)ri.hval_125k_p;
	c_hval_300k_p                    := (string)ri.hval_300k_p;
	c_hval_400k_p                    := (string)ri.hval_400k_p;
	c_hval_500k_p                    := (string)ri.hval_500k_p;
	c_incollege                      := (string)ri.incollege;
	c_info                           := (string)ri.info;
	c_lar_fam                        := (string)ri.lar_fam;
	c_larceny                        := (string)ri.larceny;
	c_low_ed                         := (string)ri.low_ed;
	c_low_hval                       := (string)ri.low_hval;
	c_lowrent                        := (string)ri.lowrent;
	c_lux_prod                       := (string)ri.lux_prod;
	c_many_cars                      := (string)ri.many_cars;
	c_med_hhinc                      := (string)ri.med_hhinc;
	c_med_rent                       := (string)ri.med_rent;
	c_med_yearblt                    := (string)ri.med_yearblt;
	c_mining                         := (string)ri.mining;
	c_mort_indx                      := (string)ri.mort_indx;
	c_murders                        := (string)ri.murders;
	c_no_labfor                      := (string)ri.no_labfor;
	c_oldhouse                       := (string)ri.oldhouse;
	c_pop_0_5_p                      := (string)ri.pop_0_5_p;
	c_pop_12_17_p                    := (string)ri.pop_12_17_p;
	c_pop_18_24_p                    := (string)ri.pop_18_24_p;
	c_pop_25_34_p                    := (string)ri.pop_25_34_p;
	c_pop_35_44_p                    := (string)ri.pop_35_44_p;
	c_pop_45_54_p                    := (string)ri.pop_45_54_p;
	c_pop_65_74_p                    := (string)ri.pop_65_74_p;
	c_pop_6_11_p                     := (string)ri.pop_6_11_p;
	c_pop_75_84_p                    := (string)ri.pop_75_84_p;
	c_popover25                      := (string)ri.popover25;
	c_rape                           := (string)ri.rape;
	c_rental                         := (string)ri.rental;
	c_rest_indx                      := (string)ri.rest_indx;
	c_retail                         := (string)ri.retail;
	c_retired                        := (string)ri.retired;
	c_retired2                       := (string)ri.retired2;
	c_rich_blk                       := (string)ri.rich_blk;
	c_rich_hisp                      := (string)ri.rich_hisp;
	c_rich_old                       := (string)ri.rich_old;
	c_rich_wht                       := (string)ri.rich_wht;
	c_rnt1500_p                      := (string)ri.rnt1500_p;
	c_rnt250_p                       := (string)ri.rnt250_p;
	c_robbery                        := (string)ri.robbery;
	c_rural_p                        := (string)ri.rural_p;
	c_serv_empl                      := (string)ri.serv_empl;
	c_sfdu_p                         := (string)ri.sfdu_p;
	c_sub_bus                        := (string)ri.sub_bus;
	c_totcrime                       := (string)ri.totcrime;
	c_totsales                       := (string)ri.totsales;
	c_transport                      := (string)ri.transport;
	c_unemp                          := (string)ri.unemp;
	c_unempl                         := (string)ri.unempl;
	c_urban_p                        := (string)ri.urban_p;
	c_vacant_p                       := (string)ri.vacant_p;
	c_white_col                      := (string)ri.white_col;
	c_young                          := (string)ri.young;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

/* ADDED TO SUPPORT S1 - S4 */
	_ver_src_cnt := Models.Common.countw((string)(ver_sources), ', ');

	_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ', ', '') > 0;
	
	_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ', ', '') > 0;
	
	_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', '') > 0;
	
	_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', '') > 0;
	
	_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', '') > 0;
	
	_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', '') > 0;

	_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

	_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR
						attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

	_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

	_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

	_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or add_input_house_number_match = false;
	
	_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;
	
	_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';
	
	_hh_strikes := sum((integer)(hh_members_w_derog>0), (integer)(hh_criminals>0), (integer)(hh_payday_loan_users>0)); 
	
	nf_seg_fraudpoint_3_0 := map(
	    (addrpop and (nas_summary in [4, 7, 9])) or (fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9') or _deceased or _ssnpriortodob or 				
	    (_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1))                                                                                                                                 					=> '1: Stolen/Manip ID',
	    fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or add_curr_pop = false                    						=> '2: Synth ID',
	    _derog                                                                                                                                                                                     						=> '3: Derog',
	    Inq_count03 > 0 or Inq_count12 >= 4 or (integer)fp_srchfraudsrchcountyr >= 1 or (integer)fp_srchssnsrchcountmo >= 1 or (integer)fp_srchaddrsrchcountmo >= 1 or (integer)fp_srchphonesrchcountmo >= 1  => '4: Recent Activity',
	    (0 < inferred_age AND inferred_age <= 17) or inferred_age >= 70 or                                                                                                                              						
	    (hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2))                                                                                              					=> '5: Vuln Vic/Friendly',
																																																																																																							 '6: Other');
/* ADDED TO SUPPORT S1 - S4 */

	sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));
	// sysdate := common.sas_date('20160503');
	// sysdate := common.sas_date('20150501');
	
	iv_wealth_index := if(not(truedid), NULL, (INTEGER)wealth_index);
	
	_in_dob := Common.SAS_Date((STRING)(in_dob));
	
	yr_in_dob := if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);
	
	yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));
	
	rv_comb_age := map(
	    yr_in_dob_int > 0            => yr_in_dob_int,
	    inferred_age > 0 and truedid => inferred_age,
	                                    NULL);
	
	nf_fp_varrisktype := map(
	    not(truedid)          => NULL,
	    fp_varrisktype = ''		=> NULL,
	                             (INTEGER)trim(fp_varrisktype, LEFT));
	
	nf_fp_srchvelocityrisktype := map(
	    not(truedid)                   => NULL,
	    fp_srchvelocityrisktype = ''	 => NULL,
	                                      (INTEGER)trim(fp_srchvelocityrisktype, LEFT));
	
	nf_fp_srchfraudsrchcount := if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999));
	
	rv_a49_curr_avm_chg_1yr_pct := map(
	    not(truedid)                                              => NULL,
	    add_curr_lres < 12                                        => NULL,
	    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
	                                                                 NULL);
	
	nf_fp_srchunvrfdaddrcount := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999));
	
	bureau_adl_eq_fseen_pos_3 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');
	
	bureau_adl_fseen_eq_3 := if(bureau_adl_eq_fseen_pos_3 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_3, ','));
	
	_bureau_adl_fseen_eq_3 := Common.SAS_Date((STRING)(bureau_adl_fseen_eq_3));
	
	bureau_adl_en_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');
	
	bureau_adl_fseen_en_2 := if(bureau_adl_en_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_2, ','));
	
	_bureau_adl_fseen_en_2 := Common.SAS_Date((STRING)(bureau_adl_fseen_en_2));
	
	bureau_adl_ts_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');
	
	bureau_adl_fseen_ts_1 := if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ','));
	
	_bureau_adl_fseen_ts_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_ts_1));
	
	bureau_adl_tu_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');
	
	bureau_adl_fseen_tu_1 := if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ','));
	
	_bureau_adl_fseen_tu_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_tu_1));
	
	bureau_adl_tn_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');
	
	bureau_adl_fseen_tn_1 := if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ','));
	
	_bureau_adl_fseen_tn_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_tn_1));
	
	_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en_2 = NULL, -NULL, _bureau_adl_fseen_en_2), if(_bureau_adl_fseen_eq_3 = NULL, -NULL, _bureau_adl_fseen_eq_3), 999999);
	
	nf_m_bureau_adl_fs_notu := map(
	    not(truedid)                        => NULL,
	    _src_bureau_adl_fseen_notu = 999999 => -1,
	                                           if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))));
	
	rv_i60_inq_prepaidcards_recency := map(
	    not(truedid)             => NULL,
	    (boolean)inq_PrepaidCards_count01 => 1,
	    (boolean)inq_PrepaidCards_count03 => 3,
	    (boolean)inq_PrepaidCards_count06 => 6,
	    (boolean)inq_PrepaidCards_count12 => 12,
	    (boolean)inq_PrepaidCards_count24 => 24,
	    (boolean)inq_PrepaidCards_count   => 99,
																					 0);
	
	rv_c12_source_profile := if(not(truedid), NULL, hdr_source_profile);
	
	nf_fp_idrisktype := map(
	    not(truedid)         => NULL,
	    fp_idrisktype = ''   => NULL,
	                            (INTEGER)trim(fp_idrisktype, LEFT));
	
	rv_c13_curr_addr_lres := if(not(truedid and add_curr_pop), Null, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));
	
	nf_fp_curraddrmedianincome := if(not(truedid), NULL, (integer)fp_curraddrmedianincome);
	
	rv_i62_inq_addrs_per_adl := if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999));
	
	bureau_adl_eq_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');
	
	bureau_adl_en_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E');
	
	bureau_adl_fseen_eq_2 := if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ','));
	
	_bureau_adl_fseen_eq_2 := Common.SAS_Date((STRING)(bureau_adl_fseen_eq_2));
	
	bureau_adl_fseen_en_1 := if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ','));
	
	_bureau_adl_fseen_en_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_en_1));
	
	_src_bureau_adl_fseen_1 := min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999);
	
	nf_m_bureau_adl_fs := map(
	    not(truedid)                     => NULL,
	    _src_bureau_adl_fseen_1 = 999999 => -1,
	                                        min(if(if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_1) / (365.25 / 12)))), 999));
	
	rv_a50_pb_average_dollars := map(
	    not(truedid)              => NULL,
	    pb_average_dollars = ''   => -1,
	                                 (integer)pb_average_dollars);
	
	add_curr_nhood_prop_sum_3 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	nf_add_curr_nhood_sfd_pct := map(
	    not(truedid) and add_curr_pop => NULL,
	    add_curr_nhood_SFD_ct = 0     => -1,
	                                     add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_3);
	
	nf_fp_prevaddrageoldest := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (integer)fp_prevaddrageoldest), 999));
	
	nf_inq_communications_count := if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999));
	
	bureau_adl_eq_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');
	
	bureau_adl_fseen_eq_1 := if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ','));
	
	_bureau_adl_fseen_eq_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_eq_1));
	
	bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');
	
	bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));
	
	_bureau_adl_fseen_en := Common.SAS_Date((STRING)(bureau_adl_fseen_en));
	
	bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');
	
	bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));
	
	_bureau_adl_fseen_ts := Common.SAS_Date((STRING)(bureau_adl_fseen_ts));
	
	bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');
	
	bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));
	
	_bureau_adl_fseen_tu := Common.SAS_Date((STRING)(bureau_adl_fseen_tu));
	
	bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');
	
	bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));
	
	_bureau_adl_fseen_tn := Common.SAS_Date((STRING)(bureau_adl_fseen_tn));
	
	_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999);
	
	nf_m_bureau_adl_fs_all := map(
	    not(truedid)                       => NULL,
	    _src_bureau_adl_fseen_all = 999999 => -1,
	                                          if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))));
	
	bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');
	
	bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));
	
	_bureau_adl_fseen_eq := Common.SAS_Date((STRING)(bureau_adl_fseen_eq));
	
	_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);
	
	rv_c20_m_bureau_adl_fs := map(
	    not(truedid)                   => NULL,
	    _src_bureau_adl_fseen = 999999 => -1,
	                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));
	
	nf_inq_highriskcredit_count := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count = NULL, -NULL, inq_HighRiskCredit_count), 999));
	
	iv_prv_addr_lres := if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999));
	
	rv_c13_max_lres := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));
	
	rv_d33_eviction_recency := map(
	    not(truedid)                                                		=> NULL,
	    (boolean)attr_eviction_count90                                  => 3,
	    (boolean)attr_eviction_count180                                 => 6,
	    (boolean)attr_eviction_count12                                  => 12,
	    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 		=> 24,
	    (boolean)attr_eviction_count24                                  => 25,
	    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 		=> 36,
	    (boolean)attr_eviction_count36                                  => 37,
	    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 		=> 60,
	    (boolean)attr_eviction_count60                                  => 61,
	    attr_eviction_count >= 2                                    		=> 98,
	    attr_eviction_count >= 1                                    		=> 99,
																																				 0);
	
	_header_first_seen := Common.SAS_Date((STRING)(header_first_seen));
	
	rv_c10_m_hdr_fs := map(
	    not(truedid)              => NULL,
	    _header_first_seen = NULL => -1,
	                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));
	
	rv_c13_attr_addrs_recency := map(
	    not(truedid)      					=> NULL,
	    (boolean)attr_addrs_last30 	=> 1,
	    (boolean)attr_addrs_last90 	=> 3,
	    (boolean)attr_addrs_last12 	=> 12,
	    (boolean)attr_addrs_last24 	=> 24,
	    (boolean)attr_addrs_last36 	=> 36,
	    (boolean)addrs_5yr         	=> 60,
	    (boolean)addrs_10yr        	=> 120,
	    (boolean)addrs_15yr        	=> 180,
	    addrs_per_adl > 0 					=> 999,
																		 0);
	
	rv_i60_inq_comm_recency := map(
	    not(truedid)               					=> NULL,
	    (boolean)inq_communications_count01 => 1,
	    (boolean)inq_communications_count03 => 3,
	    (boolean)inq_communications_count06 => 6,
	    (boolean)inq_communications_count12 => 12,
	    (boolean)inq_communications_count24 => 24,
	    (boolean)inq_communications_count   => 99,
																						 0);
	
	nf_fp_prevaddrmedianincome := if(not(truedid), NULL, (integer)fp_prevaddrmedianincome);
	
	rv_d32_felony_count := if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, (integer)felony_count), 999));
	
	nf_fp_curraddrmedianvalue := if(not(truedid), NULL, (integer)fp_curraddrmedianvalue);
	
	nf_fp_srchunvrfdphonecount := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999));
	
	add_curr_nhood_prop_sum_2 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL,
							sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct),
							if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct),
							if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	nf_add_curr_nhood_vac_pct := map(
	    not(truedid) and add_curr_pop => 		NULL,
	    add_curr_nhood_prop_sum_2 = 0 => 		-1,
																					add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum_2);
	
	nf_fp_vardobcountnew := if(not(truedid), NULL, min(if(fp_vardobcountnew = '', -NULL, (integer)fp_vardobcountnew), 999));
	
	nf_pct_rel_with_felony := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     rel_felony_count / rel_count);
	
	iv_prv_addr_avm_auto_val := if(not(add_prev_pop), NULL, add_prev_avm_auto_val);
	
	nf_fp_curraddrburglaryindex := if(not(truedid), NULL, (integer)fp_curraddrburglaryindex);
	
	nf_hh_members_ct := if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999));
	
	iv_prop1_purch_sale_diff := map(
	    not(truedid)                                           => NULL,
	    prop1_prev_purchase_price > 0 and prop1_sale_price > 0 => (integer)prop1_sale_price - (integer)prop1_prev_purchase_price,
	                                                              NULL);
	
	nf_util_adl_count := if(not(truedid), NULL, util_adl_count);
	
	nf_hh_tot_derog := if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999));
	
	nf_fp_prevaddrcrimeindex := if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex);
	
	_inq_banko_om_first_seen := Common.SAS_Date((STRING)(Inq_banko_om_first_seen));
	
	nf_mos_inq_banko_om_fseen := map(
	    not(truedid)                    => NULL,
	    _inq_banko_om_first_seen = NULL => -1,
	                                       min(if(if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)))), 999));
	
	add_curr_nhood_prop_sum_1 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	nf_add_curr_nhood_mfd_pct := map(
	    not(truedid) and add_curr_pop => NULL,
	    add_curr_nhood_MFD_ct = 0     => -1,
	                                     add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_1);
	
	rv_c16_inv_ssn_per_adl := if(not(truedid), NULL, min(if(invalid_ssns_per_adl = NULL, -NULL, invalid_ssns_per_adl), 999));
	
	nf_hh_age_18_plus := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999));
	
	nf_fp_prevaddrmedianvalue := if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue);
	
	rv_a46_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	iv_unverified_addr_count := if(not(truedid), NULL, min(unverified_addr_count, 999));
	
	nf_average_rel_home_val := map(
	    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
	    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     => -1,
	    if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) = 0 => 0,
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))) >= 0, truncate(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count)))), roundup(if(max(rel_homeunder50_count * 50, rel_homeunder100_count * 100, rel_homeunder150_count * 150, rel_homeunder200_count * 200, rel_homeunder300_count * 300, rel_homeunder500_count * 500, rel_homeover500_count * 750) = NULL, NULL, sum(if(rel_homeunder50_count * 50 = NULL, 0, rel_homeunder50_count * 50), if(rel_homeunder100_count * 100 = NULL, 0, rel_homeunder100_count * 100), if(rel_homeunder150_count * 150 = NULL, 0, rel_homeunder150_count * 150), if(rel_homeunder200_count * 200 = NULL, 0, rel_homeunder200_count * 200), if(rel_homeunder300_count * 300 = NULL, 0, rel_homeunder300_count * 300), if(rel_homeunder500_count * 500 = NULL, 0, rel_homeunder500_count * 500), if(rel_homeover500_count * 750 = NULL, 0, rel_homeover500_count * 750))) / if(max(rel_homeunder50_count, rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder50_count = NULL, 0, rel_homeunder50_count), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))))) * 1000);
	
	br_first_seen_char := br_first_seen;
	
	_br_first_seen := Common.SAS_Date((STRING)(br_first_seen_char));
	
	rv_mos_since_br_first_seen := map(
	    not(truedid)          => NULL,
	    _br_first_seen = NULL => -1,
	                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999));
	
	nf_current_count := if(not(truedid), NULL, min(current_count, 999));
	
	iv_c13_avg_lres := if(not(truedid), NULL, min(avg_lres, 999));
	
	iv_rv5_deceased := (INTEGER)(rc_decsflag = '1' or rc_ssndod != 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0
																			 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0);
	
	nf_fp_prevaddrcartheftindex := if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex);
	
	nf_hh_lienholders_pct := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         min(if(hh_lienholders / hh_members_ct = NULL, -NULL, hh_lienholders / hh_members_ct), 1.0));
	
	rv_a50_pb_total_dollars := map(
	    not(truedid)            => NULL,
	    pb_total_dollars = ''   => -1,
	                               (integer)pb_total_dollars);
	
	nf_fp_curraddrmurderindex := if(not(truedid), NULL, (integer)fp_curraddrmurderindex);
	
	nf_historical_count := if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999));
	
	nf_average_rel_income := map(
	    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  => NULL,
	    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 => -1,
	    if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) = 0 => 0,
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     if (if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) >= 0, truncate(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count)))), roundup(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))))) * 1000);
	
	nf_pct_rel_prop_owned := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     min(if(rel_prop_owned_count / rel_count = NULL, -NULL, rel_prop_owned_count / rel_count), 1.0));
	
	nf_fp_prevaddrlenofres := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (integer)fp_prevaddrlenofres), 999));
	
	nf_inq_other_count := if(not(truedid), NULL, min(if(inq_Other_count = NULL, -NULL, inq_Other_count), 999));
	
	_liens_unrel_ft_first_seen := Common.SAS_Date((STRING)(liens_unrel_FT_first_seen));
	
	nf_mos_liens_unrel_ft_fseen := map(
	    not(truedid)                      => NULL,
	    _liens_unrel_ft_first_seen = NULL => -1,
	                                         min(if(if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)))), 999));
	
	
	nf_attr_arrest_recency := map(
	    not(truedid)        => NULL,
	    attr_arrests30 > 0  => 1,
	    attr_arrests90 > 0  => 3,
	    attr_arrests180 > 0 => 6,
	    attr_arrests12 > 0  => 12,
	    attr_arrests24 > 0  => 24,
	    attr_arrests36 > 0  => 36,
	    attr_arrests60 > 0  => 60,
	    attr_arrests   > 0  => 99,
														 NULL);
	
	nf_fp_srchfraudsrchcountmo := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (integer)fp_srchfraudsrchcountmo), 999));
	
	iv_prof_license_category_pl := map(
	    not(truedid) or prof_license_source != 'PL' 	=> NULL,
	    prof_license_category = ''		               	=> -1,
																											 (INTEGER)trim(prof_license_category, LEFT));
																											
	nf_pb_retail_combo_cnt := if(not(truedid), NULL, sum((integer)pb_total_orders, inq_Retail_count));
	
	nf_rel_felony_count := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999));
	
	add_curr_nhood_prop_sum := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	nf_add_curr_nhood_bus_pct := map(
	    not(truedid) and add_curr_pop => NULL,
	    add_curr_nhood_BUS_ct = 0     => -1,
	                                     add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum);
	
	rv_i60_inq_other_recency := map(
	    not(truedid)      				 => NULL,
	    (boolean)inq_other_count01 => 1,
	    (boolean)inq_other_count03 => 3,
	    (boolean)inq_other_count06 => 6,
	    (boolean)inq_other_count12 => 12,
	    (boolean)inq_other_count24 => 24,
	    (boolean)inq_other_count   => 99,
																		0);
	
	nf_hh_age_30_plus := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65)))), 999));
	
	nf_fp_prevaddrburglaryindex := if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex);
	
	nf_hh_payday_loan_users_pct := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         min(if(hh_payday_loan_users / hh_members_ct = NULL, -NULL, hh_payday_loan_users / hh_members_ct), 1.0));
	
	
	// *# nf_hh_payday_loan_users_pct;
     // if not truedid       then nf_hh_payday_loan_users_pct = .; else
     // if hh_members_ct = 0 then nf_hh_payday_loan_users_pct =-1; else
     // nf_hh_payday_loan_users_pct = min(hh_payday_loan_users / hh_members_ct, 1.0);
	
	
	nf_hh_collections_ct := if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999));
	
	nf_pct_rel_with_bk := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     rel_bankrupt_count / rel_count);
	
	nf_hh_payday_loan_users := if(not(truedid), NULL, min(if(hh_payday_loan_users = NULL, -NULL, hh_payday_loan_users), 999));
	
	nf_pct_rel_with_criminal := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     rel_criminal_count / rel_count);
	
	iv_c14_addrs_per_adl := if(not(truedid), NULL, min(addrs_per_adl, 999));
	
	nf_fp_assocsuspicousidcount := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, (integer)fp_assocsuspicousidcount), 999));
	
	rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));
	
	sum_dols := if(pb_number_of_sources = ''  , -1, if(max((integer)pb_offline_dollars, (integer)pb_online_dollars, (integer)pb_retail_dollars) = 0,
																										NULL, sum(if(pb_offline_dollars = '', 0, (integer)pb_offline_dollars),
																															if(pb_online_dollars = '', 0, (integer)pb_online_dollars),
																															if(pb_retail_dollars = '', 0, (integer)pb_retail_dollars))));
	
	pct_retail_dols := if((integer)sum_dols > 0, (real)pb_retail_dollars / (real)sum_dols, -1);
	
	pct_offline_dols := if((integer)sum_dols > 0, (real)pb_offline_dollars / (real)sum_dols, -1);
	
	pct_online_dols := if((integer)sum_dols > 0, (real)pb_online_dollars / (real)sum_dols, -1);
	
	iv_pb_profile := map(
	    not(truedid)                => '',
	    pb_number_of_sources = ''   => '0 NO PURCH DATA  ',
	    pct_offline_dols > .50      => '1 OFFLINE SHOPPER',
	    pct_online_dols > .50       => '2 ONLINE SHOPPER ',
	    pct_retail_dols > .50       => '3 RETAIL SHOPPER ',
	                                   '4 OTHER');
	
	nf_rel_criminal_count := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999));
	
	_inq_banko_om_last_seen := Common.SAS_Date((STRING)(Inq_banko_om_last_seen));
	
	nf_mos_inq_banko_om_lseen := map(
	    not(truedid)                   => NULL,
	    _inq_banko_om_last_seen = NULL => -1,
	                                      min(if(if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_last_seen) / (365.25 / 12)))), 999));
	
	rv_d31_mostrec_bk := map(
	    not(truedid)                            => '',
	    contains_i(disposition, 'DISMISS') > 0  => '1 - BK DISMISSED ',
	    contains_i(disposition, 'DISCHARG') > 0 => '2 - BK DISCHARGED',
	    bankrupt = true or filing_count > 0     => '3 - BK OTHER     ',
																								 '0 - NO BK        ');
	
	nf_rel_derog_summary := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     if(max(min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3), min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3), min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3)) = NULL, NULL, sum(if(min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3) = NULL, 0, min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 3)), if(min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3) = NULL, 0, min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 3)), if(min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3) = NULL, 0, min(if(rel_criminal_count - rel_felony_count = NULL, -NULL, rel_criminal_count - rel_felony_count), 3)))));
	
	rv_a50_pb_total_orders := map(
	    not(truedid)           => NULL,
	    pb_total_orders = ''   => -1,
	                              (integer)pb_total_orders);
	
	nf_average_rel_age := map(
	    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               => NULL,
	    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              => -1,
	    if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = 0, 0, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) = 0 => 0,
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  if (if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) >= 0, truncate(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))), roundup(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))))));
	
	nf_pb_retail_combo_max := if(not(truedid), NULL, max((integer)pb_total_orders, inq_Retail_count));
	
	nf_dl_addrs_per_adl := if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999));
	
	nf_fp_curraddrcartheftindex := if(not(truedid), NULL, (integer)fp_curraddrcartheftindex);
	
	nf_inq_auto_count := if(not(truedid), NULL, min(if(inq_Auto_count = NULL, -NULL, inq_Auto_count), 999));
	
	rv_i61_inq_collection_recency := map(
	    not(truedid)          	 				=> NULL,
	    (boolean)inq_collection_count01 => 1,
	    (boolean)inq_collection_count03 => 3,
	    (boolean)inq_collection_count06 => 6,
	    (boolean)inq_collection_count12 => 12,
	    (boolean)inq_collection_count24 => 24,
	    (boolean)inq_collection_count   => 99,
																				 0);
	
	nf_hh_collections_ct_avg := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         hh_collections_ct / hh_members_ct);
	
	nf_hh_prof_license_holders_pct := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         min(if(hh_prof_license_holders / hh_members_ct = NULL, -NULL, hh_prof_license_holders / hh_members_ct), 1.0));
	
	rv_f04_curr_add_occ_index := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);
	
	iv_prop2_purch_sale_diff := map(
	    not(truedid)                                           => NULL,
	    prop2_prev_purchase_price > 0 and prop2_sale_price > 0 => (integer)prop2_sale_price - (integer)prop2_prev_purchase_price,
	                                                              NULL);
	
	rv_d34_attr_liens_recency := map(
	    not(truedid)                                                              => NULL,
	    (boolean)attr_num_rel_liens30 or (boolean)attr_num_unrel_liens30          => 1,
	    (boolean)attr_num_rel_liens90 or (boolean)attr_num_unrel_liens90          => 3,
	    (boolean)attr_num_rel_liens180 or (boolean)attr_num_unrel_liens180        => 6,
	    (boolean)attr_num_rel_liens12 or (boolean)attr_num_unrel_liens12          => 12,
	    (boolean)attr_num_rel_liens24 or (boolean)attr_num_unrel_liens24          => 24,
	    (boolean)attr_num_rel_liens36 or (boolean)attr_num_unrel_liens36          => 36,
	    (boolean)attr_num_rel_liens60 or (boolean)attr_num_unrel_liens60          => 60,
	    liens_historical_released_count > 0 or liens_historical_unreleased_ct > 0 => 99,
	                                                                                 0);
	
	_acc_last_seen := Common.SAS_Date((STRING)(acc_last_seen));
	
	nf_mos_acc_lseen := map(
	    not(truedid)          => NULL,
	    _acc_last_seen = NULL => -1,
	                             min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999));
	
	nf_inq_count_week := if(not(truedid), NULL, min(if(inq_count_week = NULL, -NULL, inq_count_week), 999));
	
	rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));
	
	rv_d31_all_bk := map(
	    not(truedid)                                                                                                                  => '',
	    contains_i(disposition, 'DISMISS') > 0 or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL,
																									sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), 
																									if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0  => '1 - BK DISMISSED',
	    contains_i(disposition, 'DISCHARG') > 0 or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL,
																									sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count),
																									if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0    => '2 - BK DISCHARGED',
	    bankrupt = true or filing_count > 0                                                                                           => '3 - BK OTHER',
																																																																			 '0 - NO BK');
	
	rv_ever_asset_owner := map(
	    not(truedid)                                                                                                                                                                                                 => NULL,
	    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => 1,
	                                                                                                                                                                                                                    0);
	
	nf_fp_assocrisktype := map(
	    not(truedid)            => NULL,
	    fp_assocrisktype = ''   => NULL,
	                               (INTEGER)trim(fp_assocrisktype, LEFT));
	
	nf_liens_unrel_cj_total_amt := if(not(truedid), NULL, liens_unrel_CJ_total_amount);
	
	rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));
	
	nf_inq_collection_count := if(not(truedid), NULL, min(if(inq_Collection_count = NULL, -NULL, inq_Collection_count), 999));
	
	nf_rel_bankrupt_count := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999));
	
	rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));
	
	rv_email_domain_isp_count := if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999));
	
	nf_liens_unrel_sc_total_amt := if(not(truedid), NULL, liens_unrel_SC_total_amount);
	
	nf_rel_count := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));
	
	nf_fp_curraddrcrimeindex := if(not(truedid), NULL, (integer)fp_curraddrcrimeindex);
	
	nf_hh_lienholders := if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999));
	
	nf_liens_unrel_ot_total_amt := if(not(truedid), NULL, liens_unrel_OT_total_amount);
	
	nf_hh_pct_property_owners := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         min(if(hh_property_owners_ct / hh_members_ct = NULL, -NULL, hh_property_owners_ct / hh_members_ct), 1.0));
	
	iv_br_source_count := if(not(truedid), NULL, min(if(br_source_count = NULL, -NULL, br_source_count), 999));
	
	_liens_unrel_cj_first_seen := Common.SAS_Date((STRING)(liens_unrel_CJ_first_seen));
	
	nf_mos_liens_unrel_cj_fseen := map(
	    not(truedid)                      => NULL,
	    _liens_unrel_cj_first_seen = NULL => -1,
	                                         min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999));
	
	rv_i60_inq_recency := map(
	    not(truedid) 					=> NULL,
	    (boolean)inq_count01  => 1,
	    (boolean)inq_count03  => 3,
	    (boolean)inq_count06  => 6,
	    (boolean)inq_count12  => 12,
	    (boolean)inq_count24  => 24,
	    (boolean)inq_count    => 99,
																0);
	
	nf_hh_criminals_pct := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         min(if(hh_criminals / hh_members_ct = NULL, -NULL, hh_criminals / hh_members_ct), 1.0));
	
	nf_inq_collection_count24 := if(not(truedid), NULL, min(inq_Collection_count24, 999));
	
	nf_fp_srchfraudsrchcountwk := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (integer)fp_srchfraudsrchcountwk), 999));
	
	nf_hh_property_owners_ct := if(not(truedid), NULL, min(hh_property_owners_ct, 999));
	
	nf_inq_prepaidcards_count := if(not(truedid), NULL, min(inq_PrepaidCards_count, 999));
	
	nf_fp_prevaddrmurderindex := if(not(truedid), NULL, (integer)fp_prevaddrmurderindex);
	
	nf_average_rel_distance := map(
	    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
	    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                     => -1,
	    if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) = 0 => 0,
	                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) >= 0, truncate(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))), roundup(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))))));
	
	nf_liens_rel_cj_total_amt := if(not(truedid), NULL, liens_rel_CJ_total_amount);
	
	_inq_banko_am_last_seen := Common.SAS_Date((STRING)(Inq_banko_am_last_seen));
	
	nf_mos_inq_banko_am_lseen := map(
	    not(truedid)                   => NULL,
	    _inq_banko_am_last_seen = NULL => -1,
	                                      min(if(if ((sysdate - _inq_banko_am_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_am_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_am_last_seen) / (365.25 / 12)))), 999));
	
	rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));
	
	_liens_unrel_cj_last_seen := Common.SAS_Date((STRING)(liens_unrel_CJ_last_seen));
	
	nf_mos_liens_unrel_cj_lseen := map(
	    not(truedid)                     => NULL,
	    _liens_unrel_cj_last_seen = NULL => -1,
	                                        min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999));
	
	rv_s66_ssns_per_adl_c6 := if(not(truedid), NULL, min(ssns_per_adl_c6, 999));
	
	nf_inq_count24 := if(not(truedid), NULL, min(inq_count24, 999));
	
	rv_c18_invalid_addrs_per_adl := if(not(truedid), NULL, min(invalid_addrs_per_adl, 999));
	
	nf_inq_other_count24 := if(not(truedid), NULL, min(inq_Other_count24, 999));
	
	nf_fp_assoccredbureaucount := if(not(truedid), NULL, min(if(fp_assoccredbureaucount = '', -NULL, (integer)fp_assoccredbureaucount), 999));
	
	nf_fp_prevaddrstatus := if(not(truedid), '', fp_prevaddrstatus);
	
	nf_inq_count := if(not(truedid), NULL, min(inq_count, 999));
	
	nf_fp_sourcerisktype := map(
	    not(truedid)             => NULL,
	    fp_sourcerisktype = ''   => NULL,
	                                (INTEGER)trim(fp_sourcerisktype, LEFT));
	
	nf_hh_bankruptcies_pct := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         min(if(hh_bankruptcies / hh_members_ct = NULL, -NULL, hh_bankruptcies / hh_members_ct), 1.0));
	
	nf_inq_other_count_week := if(not(truedid), NULL, min(inq_Other_count_week, 999));
	
	_inq_banko_cm_last_seen := Common.SAS_Date((STRING)(Inq_banko_cm_last_seen));
	
	nf_mos_inq_banko_cm_lseen := map(
	    not(truedid)                   => NULL,
	    _inq_banko_cm_last_seen = NULL => -1,
	                                      min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999));
	
	rv_c14_addr_stability_v2 := if(not(truedid), NULL, (INTEGER)addr_stability_v2);
	
	rv_a41_a42_prop_owner_history := map(
	    not(truedid)                                                                     => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
	    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
	                                                                                        'NEVER');
	
	nf_inq_prepaidcards_count24 := if(not(truedid), NULL, min(inq_PrepaidCards_count24, 999));
	
	rv_d34_unrel_liens_ct := if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999));
	
	rv_i62_inq_ssns_per_adl := if(not(truedid), NULL, min(inq_ssnsperadl, 999));
	
	rv_c21_stl_inq_count180 := if(not(truedid), NULL, min(STL_Inq_count180, 999));
	
	nf_liens_unrel_ft_total_amt := if(not(truedid), NULL, liens_unrel_FT_total_amount);
	
	rv_email_count := if(not(truedid), NULL, min(email_count, 999));
	
	nf_hh_tot_derog_avg := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         hh_tot_derog / hh_members_ct);
	
	nf_accident_count := if(not(truedid), NULL, min(acc_count, 999));
	
	iv_d57_attr_proflic_recency := map(
	    not(truedid)        				 => NULL,
	    (boolean)attr_num_proflic30  => 1,
	    (boolean)attr_num_proflic90  => 3,
	    (boolean)attr_num_proflic180 => 6,
	    (boolean)attr_num_proflic12  => 12,
	    (boolean)attr_num_proflic24  => 24,
	    (boolean)attr_num_proflic36  => 36,
	    (boolean)attr_num_proflic60  => 60,
	    (boolean)prof_license_flag   => 99,
																			0);
	
	rv_c12_num_nonderogs := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4));
	
	rv_i60_inq_other_count12 := if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999));
	
	nf_liens_unrel_st_total_amt := if(not(truedid), NULL, liens_unrel_ST_total_amount);
	
	nf_inq_communications_count24 := if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999));
	
	_felony_last_date := Common.SAS_Date((STRING)(felony_last_date));
	
	rv_d32_mos_since_fel_ls := map(
	    not(truedid)             => NULL,
	    _felony_last_date = NULL => -1,
	                                min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240));
	
	nf_highest_rel_home_val := map(
	    not(truedid)               => NULL,
	    rel_count = 0              => -1,
	    rel_homeover500_count > 0  => 750,
	    rel_homeunder500_count > 0 => 500,
	    rel_homeunder300_count > 0 => 300,
	    rel_homeunder200_count > 0 => 200,
	    rel_homeunder150_count > 0 => 150,
	    rel_homeunder100_count > 0 => 100,
	    rel_homeunder50_count > 0  => 50,
	                                  0);
	
	nf_hh_age_65_plus := if(not(truedid), NULL, min(if(hh_age_65_plus = NULL, -NULL, hh_age_65_plus), 999));
	
	_liens_unrel_ft_last_seen := Common.SAS_Date((STRING)(liens_unrel_FT_last_seen));
	
	nf_mos_liens_unrel_ft_lseen := map(
	    not(truedid)                     => NULL,
	    _liens_unrel_ft_last_seen = NULL => -1,
	                                        min(if(if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)))), 999));
	
	nf_inq_highriskcredit_count24 := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));
	
	rv_d34_unrel_lien60_count := if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999));
	
	iv_a46_l77_addrs_move_traj := if(not(truedid), NULL, addrs_move_trajectory);
	
	iv_college_code := map(
	    not(truedid)        => NULL,
	    college_code = ''   => -1,
	                           (INTEGER)trim(college_code, LEFT));
	
	rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));
	
	nf_inq_banking_count24 := if(not(truedid), NULL, min(if(inq_Banking_count24 = NULL, -NULL, inq_Banking_count24), 999));
	
	nf_inq_utilities_count := if(not(truedid), NULL, min(if(inq_Utilities_count = NULL, -NULL, inq_Utilities_count), 999));
	
	_liens_unrel_ot_first_seen := Common.SAS_Date((STRING)(liens_unrel_OT_first_seen));
	
	nf_mos_liens_unrel_ot_fseen := map(
	    not(truedid)                      => NULL,
	    _liens_unrel_ot_first_seen = NULL => -1,
	                                         min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999));
	
	_foreclosure_last_date := Common.SAS_Date((STRING)(foreclosure_last_date));
	
	nf_mos_foreclosure_lseen := map(
	    not(truedid)                  => NULL,
	    _foreclosure_last_date = NULL => -1,
	                                     min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999));
	
	_liens_rel_ot_last_seen := Common.SAS_Date((STRING)(liens_rel_OT_last_seen));
	
	nf_mos_liens_rel_ot_lseen := map(
	    not(truedid)                   => NULL,
	    _liens_rel_ot_last_seen = NULL => -1,
	                                      min(if(if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)))), 999));
	
	iv_d34_liens_unrel_sc_ct := if(not(truedid), NULL, min(liens_unrel_SC_ct, 999));
	
	nf_inq_mortgage_count24 := if(not(truedid), NULL, min(inq_Mortgage_count24, 999));
	
	_liens_rel_cj_first_seen := Common.SAS_Date((STRING)(liens_rel_CJ_first_seen));
	
	nf_mos_liens_rel_cj_fseen := map(
	    not(truedid)                    => NULL,
	    _liens_rel_cj_first_seen = NULL => -1,
	                                       min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999));
	
	nf_pct_rel_prop_sold := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     min(if(rel_prop_sold_count / rel_count = NULL, -NULL, rel_prop_sold_count / rel_count), 1.0));
	
	nf_oldest_rel_age := map(
	    not(truedid)             => NULL,
	    rel_count = 0            => -1,
	    rel_ageover70_count > 0  => 80,
	    rel_ageunder70_count > 0 => 70,
	    rel_ageunder60_count > 0 => 60,
	    rel_ageunder50_count > 0 => 50,
	    rel_ageunder40_count > 0 => 40,
	    rel_ageunder30_count > 0 => 30,
	    rel_ageunder20_count > 0 => 20,
	                                0);
	
	nf_youngest_rel_age := map(
	    not(truedid)             => NULL,
	    rel_count = 0            => -1,
	    rel_ageunder20_count > 0 => 20,
	    rel_ageunder30_count > 0 => 30,
	    rel_ageunder40_count > 0 => 40,
	    rel_ageunder50_count > 0 => 50,
	    rel_ageunder60_count > 0 => 60,
	    rel_ageunder70_count > 0 => 70,
	    rel_ageover70_count > 0  => 80,
	                                0);
	
	iv_prof_license_category_pm := map(
	    not(truedid) or prof_license_source != 'PM' => NULL,
	    prof_license_category = ''                  => -1,
	                                                   (INTEGER)trim(prof_license_category, LEFT));
	
	nf_inq_retailpayments_count := if(not(truedid), NULL, min(if(inq_RetailPayments_count = NULL, -NULL, inq_RetailPayments_count), 999));
	
	nf_fp_vardobcount := if(not(truedid), NULL, min(if(fp_vardobcount = '', -NULL, (integer)fp_vardobcount), 999));
	
	nf_acc_damage_amt_total := if(not(truedid), (UNSIGNED)NULL, acc_damage_amt_total);
	
	nf_fp_srchfraudsrchcountyr := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999));
	
	iv_a46_l77_addrs_move_traj_index := if(not(truedid), NULL, addrs_move_trajectory_index);
	
	rv_a43_rec_vehx_level := map(
	    not(truedid)                                   => '',
	    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
	    attr_num_aircraft > 0                          => 'AO',
	    watercraft_count > 0                           => 'W' + (string)min((integer)if(watercraft_count = NULL, -NULL, watercraft_count), 3),
	                                                      'XX');
	
	rv_i60_inq_banking_count12 := if(not(truedid), NULL, min(if(inq_banking_count12 = NULL, -NULL, inq_banking_count12), 999));
	
	rv_i60_inq_retpymt_recency := map(
	    not(truedid)               					=> NULL,
	    (boolean)inq_retailpayments_count01 => 1,
	    (boolean)inq_retailpayments_count03 => 3,
	    (boolean)inq_retailpayments_count06 => 6,
	    (boolean)inq_retailpayments_count12 => 12,
	    (boolean)inq_retailpayments_count24 => 24,
	    (boolean)inq_retailpayments_count   => 99,
																						 0);
	
	nf_hh_bankruptcies := if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999));
	
	nf_liens_unrel_st_ct := if(not(truedid), NULL, min(if(liens_unrel_ST_ct = NULL, -NULL, liens_unrel_ST_ct), 999));
	
	iv_curr_add_financing_type := map(
	    not(truedid and add_curr_pop)  => '',
	    add_curr_financing_type = ''   => 'NONE ',
	                                      add_curr_financing_type);
	
	nf_fp_varmsrcssncount := if(not(truedid), NULL, min(if(fp_varmsrcssncount = '', -NULL, (integer)fp_varmsrcssncount), 999));
	
	_inq_banko_cm_first_seen := Common.SAS_Date((STRING)(Inq_banko_cm_first_seen));
	
	nf_mos_inq_banko_cm_fseen := map(
	    not(truedid)                    => NULL,
	    _inq_banko_cm_first_seen = NULL => -1,
	                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999));
	
	rv_e58_br_dead_business_count := if(not(truedid), NULL, min(if(br_dead_business_count = NULL, -NULL, br_dead_business_count), 999));
	
	rv_d31_bk_chapter := map(
	    not(truedid)    => NULL,
	    bk_chapter = '' => 0,
	                       (INTEGER)trim(bk_chapter, LEFT));
	
	nf_highest_rel_income := map(
	    not(truedid)                 => NULL,
	    rel_count = 0                => -1,
	    rel_incomeover100_count > 0  => 125,
	    rel_incomeunder100_count > 0 => 100,
	    rel_incomeunder75_count > 0  => 75,
	    rel_incomeunder50_count > 0  => 50,
	    rel_incomeunder25_count > 0  => 25,
	                                    0);
	
	iv_d31_bk_filing_type := if(not(truedid), '', filing_type);
	
	nf_lowest_rel_income := map(
	    not(truedid)                 => NULL,
	    rel_count = 0                => -1,
	    rel_incomeunder25_count > 0  => 25,
	    rel_incomeunder50_count > 0  => 50,
	    rel_incomeunder75_count > 0  => 75,
	    rel_incomeunder100_count > 0 => 100,
	    rel_incomeover100_count > 0  => 125,
	                                    0);
																			
	br_company_title1 := stringlib.StringSubstituteOut(br_company_title, '.,/\\-#:()*', ' '); 
	br_company_title2 := br_company_title1;
	
	rv_bus_leadership_title := map(
	    not(truedid)                                                                                    => NULL,
	    br_company_title2 = ''                                                                          => -1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CEO') > 0                                                        => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CFO') > 0                                                        => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CHAIRMAN') > 0                                                   => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'DIRECTOR') > 0                                                   => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'FOUNDER') > 0                                                    => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'PRESIDENT') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'TREASURER') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'VP') > 0                                                         => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'DIRECTORS') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'CHIEF') > 0                                                      => 1,
	    //contains_i(Std.Str.ToUpperCase(br_company_title2), 'VICE') > 0                                                       => 1,
	    //contains_i(Std.Str.ToUpperCase(br_company_title2), 'PRES') > 0                                                       => 1,
	    indexw(Std.Str.ToUpperCase(br_company_title2), 'VICE', ' ')                                                    	 		 => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'OWNER') > 0                                                      => 1,
	    indexw(Std.Str.ToUpperCase(br_company_title2), 'PRES', ' ')                                                		   		 => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'TREAS') > 0                                                      => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'EXECUTIVE') > 0                                                  => 1,
	    contains_i(Std.Str.ToUpperCase(br_company_title2), 'PARTNER') > 0                                                    => 1,
	    (Std.Str.ToUpperCase(br_company_title2) in ['PRIN', 'PRINCIPAL', 'GENERAL MANAGER', 'VICEPRES', 'GEN MGR', 'PRESI']) => 1,
																																																															0);
	
	rv_d31_attr_bankruptcy_recency := map(
	    not(truedid)             					=> NULL,
	    (boolean)attr_bankruptcy_count30  => 1,
	    (boolean)attr_bankruptcy_count90  => 3,
	    (boolean)attr_bankruptcy_count180 => 6,
	    (boolean)attr_bankruptcy_count12  => 12,
	    (boolean)attr_bankruptcy_count24  => 24,
	    (boolean)attr_bankruptcy_count36  => 36,
	    (boolean)attr_bankruptcy_count60  => 60,
	    (boolean)bankrupt                 => 99,
	    filing_count > 0         					=> 99,
																						0);
	
	nf_hh_workers_paw_pct := map(
	    not(truedid)      => NULL,
	    hh_members_ct = 0 => -1,
	                         min(if(hh_workers_paw / hh_members_ct = NULL, -NULL, hh_workers_paw / hh_members_ct), 1.0));
	
	nf_inq_auto_count24 := if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999));
	
	rv_i62_inq_dobs_per_adl := if(not(truedid), NULL, min(if(inq_dobsperadl = NULL, -NULL, inq_dobsperadl), 999));
	
	rv_d32_attr_felonies_recency := map(
	    not(truedid)     					=> NULL,
	    (boolean)attr_felonies30  => 1,
	    (boolean)attr_felonies90  => 3,
	    (boolean)attr_felonies180 => 6,
	    (boolean)attr_felonies12  => 12,
	    (boolean)attr_felonies24  => 24,
	    (boolean)attr_felonies36  => 36,
	    (boolean)attr_felonies60  => 60,
	    felony_count > 0 					=> 99,
																	0);
	
	_liens_unrel_sc_last_seen := Common.SAS_Date((STRING)(liens_unrel_SC_last_seen));
	
	nf_mos_liens_unrel_sc_lseen := map(
	    not(truedid)                     => NULL,
	    _liens_unrel_sc_last_seen = NULL => -1,
	                                        min(if(if ((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)))), 999));
	
	rv_i60_inq_hiriskcred_recency := map(
	    not(truedid)               					=> NULL,
	    (boolean)inq_highRiskCredit_count01 => 1,
	    (boolean)inq_highRiskCredit_count03 => 3,
	    (boolean)inq_highRiskCredit_count06 => 6,
	    (boolean)inq_highRiskCredit_count12 => 12,
	    (boolean)inq_highRiskCredit_count24 => 24,
	    (boolean)inq_highRiskCredit_count   => 99,
																							0);
	
	rv_c14_addrs_10yr := map(
	    not(truedid)      => NULL,
	    not(add_curr_pop) => -1,
	                         min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));
	
	_liens_unrel_sc_first_seen := Common.SAS_Date((STRING)(liens_unrel_SC_first_seen));
	
	nf_liens_rel_ot_total_amt := if(not(truedid), NULL, liens_rel_OT_total_amount);
	
	_liens_unrel_ot_last_seen := Common.SAS_Date((STRING)(liens_unrel_OT_last_seen));
	
	nf_mos_liens_unrel_ot_lseen := map(
	    not(truedid)                     => NULL,
	    _liens_unrel_ot_last_seen = NULL => -1,
	                                        min(if(if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)))), 999));
	
	nf_accident_recency := map(
	    not(truedid)  				 => NULL,
	    (boolean)acc_count_30  => 1,
	    (boolean)acc_count_90  => 3,
	    (boolean)acc_count_180 => 6,
	    (boolean)acc_count_12  => 12,
	    (boolean)acc_count_24  => 24,
	    (boolean)acc_count_36  => 36,
	    (boolean)acc_count_60  => 60,
	    (boolean)acc_count     => 99,
																0);
	
	_liens_unrel_o_first_seen := Common.SAS_Date((STRING)(liens_unrel_O_first_seen));
	
	nf_mos_liens_unrel_o_fseen := map(
	    not(truedid)                     => NULL,
	    _liens_unrel_o_first_seen = NULL => -1,
	                                        min(if(if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)))), 999));
	
	nf_fp_srchunvrfddobcount := if(not(truedid), NULL, min(if(fp_srchunvrfddobcount = '', -NULL, (integer)fp_srchunvrfddobcount), 999));
	
	_liens_unrel_st_first_seen := Common.SAS_Date((STRING)(liens_unrel_ST_first_seen));
	
	nf_mos_liens_unrel_st_fseen := map(
	    not(truedid)                      => NULL,
	    _liens_unrel_st_first_seen = NULL => -1,
	                                         min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999));
	
	rv_c19_add_prison_hist := if(not(truedid), NULL, (integer)addrs_prison_history);
	
	nf_inq_utilities_count24 := if(not(truedid), NULL, min(inq_Utilities_count24, 999));
	
	nf_hh_members_w_derog := if(not(truedid), NULL, min(hh_members_w_derog, 999));
	
	_inq_banko_am_first_seen := Common.SAS_Date((STRING)(Inq_banko_am_first_seen));
	
	nf_fp_assoccredbureaucountnew := if(not(truedid), NULL, min(if(fp_assoccredbureaucountnew = '', -NULL, (integer)fp_assoccredbureaucountnew), 999));
	
	_liens_rel_cj_last_seen := Common.SAS_Date((STRING)(liens_rel_CJ_last_seen));
	
	nf_mos_liens_rel_cj_lseen := map(
	    not(truedid)                   => NULL,
	    _liens_rel_cj_last_seen = NULL => -1,
	                                      min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999));
	
	iv_college_type := map(
	    not(truedid)        => '',
	    college_type = ''   => '-1',
	                           college_type);
	
	_liens_unrel_st_last_seen := Common.SAS_Date((STRING)(liens_unrel_ST_last_seen));
	
	nf_mos_liens_unrel_st_lseen := map(
	    not(truedid)                     => NULL,
	    _liens_unrel_st_last_seen = NULL => -1,
	                                        min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999));
	
	nf_inq_retailpayments_count24 := if(not(truedid), NULL, min(inq_RetailPayments_count24, 999));
	
	iv_d34_liens_rel_ot_ct := if(not(truedid), NULL, min(liens_rel_OT_ct, 999));
	
	rv_d31_bk_disposed_hist_count := if(not(truedid), NULL, min(bk_disposed_historical_count, 999));
	
	_liens_rel_ft_first_seen := Common.SAS_Date((STRING)(liens_rel_FT_first_seen));
	
	nf_mos_liens_rel_ft_fseen := map(
	    not(truedid)                    => NULL,
	    _liens_rel_ft_first_seen = NULL => -1,
	                                       min(if(if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ft_first_seen) / (365.25 / 12)))), 999));
	
	nf_inq_mortgage_count := if(not(truedid), NULL, min(inq_Mortgage_count, 999));
	
	_liens_unrel_o_last_seen := Common.SAS_Date((STRING)(liens_unrel_O_last_seen));
	
	nf_mos_liens_unrel_o_lseen := map(
	    not(truedid)                    => NULL,
	    _liens_unrel_o_last_seen = NULL => -1,
	                                       min(if(if ((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_last_seen) / (365.25 / 12)))), 999));
	
	rv_br_active_phone_count := if(not(truedid), NULL, min(br_active_phone_count, 999));
	
	nf_inq_banking_count := if(not(truedid), NULL, min(inq_Banking_count, 999));
	
	iv_d34_liens_unrel_ot_ct := if(not(truedid), NULL, min(liens_unrel_OT_ct, 999));
	
	nf_liens_rel_o_total_amt := if(not(truedid), NULL, liens_rel_O_total_amount);
	
fp3_lexid_cen_mod_0 :=  -1.1094957627;

fp3_lexid_cen_mod_1_c263 := map(
    c_sfdu_p = ''                         => 0.0809006004,
    NULL < (real)c_sfdu_p AND (real)c_sfdu_p <= 74.65 => 0.0577261210,
    (real)c_sfdu_p > 74.65                      => 0.1608021752,
											 0.0809006004);

fp3_lexid_cen_mod_1_c266 := map(
    c_pop_25_34_p = ''                              => 0.0427858284,
    NULL < (real)c_pop_25_34_p AND (real)c_pop_25_34_p <= 30.15 => 0.0715453044,
    (real)c_pop_25_34_p > 30.15                           => -0.0698836482,
                                                       0.0427858284);

fp3_lexid_cen_mod_1_c265 := map(
    c_many_cars = ''                         => -0.0256182142,
    NULL < (real)c_many_cars AND (real)c_many_cars <= 20.5 => fp3_lexid_cen_mod_1_c266,
    (real)c_many_cars > 20.5                         => -0.0305344607,
                                                  -0.0256182142);

fp3_lexid_cen_mod_1_c264 := map(
    c_easiqlife = ''                          => -0.0074543001,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 134.5 => fp3_lexid_cen_mod_1_c265,
    (real)c_easiqlife > 134.5                         => 0.0242549802,
                                                   -0.0074543001);

fp3_lexid_cen_mod_1 := map(
    c_fammar_p = ''                         => -0.0530046085,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 51.25 => fp3_lexid_cen_mod_1_c263,
    (real)c_fammar_p > 51.25                        => fp3_lexid_cen_mod_1_c264,
                                                 -0.0002182660);

fp3_lexid_cen_mod_2_c270 := map(
    c_asian_lang = ''                           => 0.0260523413,
    NULL < (real)c_asian_lang AND (real)c_asian_lang <= 115.5 => 0.1244049921,
    (real)c_asian_lang > 115.5                          => -0.0047648226,
                                                     0.0260523413);

fp3_lexid_cen_mod_2_c269 := map(
    c_sub_bus = ''                        => -0.0278689423,
    NULL < (real)c_sub_bus AND (real)c_sub_bus <= 184.5 => -0.0349695391,
    (real)c_sub_bus > 184.5                       => fp3_lexid_cen_mod_2_c270,
                                               -0.0278689423);

fp3_lexid_cen_mod_2_c268 := map(
    c_easiqlife = ''                          => -0.0086647770,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 118.5 => fp3_lexid_cen_mod_2_c269,
    (real)c_easiqlife > 118.5                         => 0.0126503357,
                                                   -0.0086647770);

fp3_lexid_cen_mod_2_c271 := map(
    c_civ_emp = ''                        => 0.0584175778,
    NULL < (real)c_civ_emp AND (real)c_civ_emp <= 52.35 => 0.1040514366,
    (real)c_civ_emp > 52.35                       => 0.0354233148,
                                               0.0584175778);

fp3_lexid_cen_mod_2 := map(
    c_famotf18_p = ''                           => -0.0532031793,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 25.95 => fp3_lexid_cen_mod_2_c268,
    (real)c_famotf18_p > 25.95                          => fp3_lexid_cen_mod_2_c271,
                                                     -0.0025872266);

fp3_lexid_cen_mod_3_c274 := map(
    c_fammar_p = ''                        => 0.0675179944,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 41.5 => 0.1611445788,
    (real)c_fammar_p > 41.5                        => 0.0337810408,
                                                0.0675179944);

fp3_lexid_cen_mod_3_c275 := map(
    c_sub_bus = ''                        => -0.0221752428,
    NULL < (real)c_sub_bus AND (real)c_sub_bus <= 162.5 => -0.0310263565,
    (real)c_sub_bus > 162.5                       => 0.0065299744,
                                               -0.0221752428);

fp3_lexid_cen_mod_3_c273 := map(
    c_employees = ''                         => -0.0159010965,
    NULL < (real)c_employees AND (real)c_employees <= 16.5 => fp3_lexid_cen_mod_3_c274,
    (real)c_employees > 16.5                         => fp3_lexid_cen_mod_3_c275,
                                                  -0.0159010965);

fp3_lexid_cen_mod_3_c276 := map(
    c_famotf18_p = ''                           => 0.0255717147,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 21.25 => 0.0162160269,
    (real)c_famotf18_p > 21.25                          => 0.0778009971,
                                                     0.0255717147);

fp3_lexid_cen_mod_3 := map(
    c_easiqlife = ''                          => -0.0409153395,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 134.5 => fp3_lexid_cen_mod_3_c273,
    (real)c_easiqlife > 134.5                         => fp3_lexid_cen_mod_3_c276,
                                                   -0.0019269950);

fp3_lexid_cen_mod_4_c278 := map(
    c_rest_indx = ''                         => 0.0277703686,
    NULL < (real)c_rest_indx AND (real)c_rest_indx <= 92.5 => 0.0531230766,
    (real)c_rest_indx > 92.5                         => 0.0022768122,
                                                  0.0277703686);

fp3_lexid_cen_mod_4_c281 := map(
    c_born_usa = ''                       => 0.0298234345,
    NULL < (real)c_born_usa AND (real)c_born_usa <= 2.5 => 0.1623688458,
    (real)c_born_usa > 2.5                        => 0.0256698011,
                                               0.0298234345);

fp3_lexid_cen_mod_4_c280 := map(
    c_no_labfor = ''                         => 0.0156383000,
    NULL < (real)c_no_labfor AND (real)c_no_labfor <= 52.5 => -0.0224158528,
    (real)c_no_labfor > 52.5                         => fp3_lexid_cen_mod_4_c281,
                                                  0.0156383000);

fp3_lexid_cen_mod_4_c279 := map(
    c_easiqlife = ''                          => -0.0098193032,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 143.5 => -0.0203503261,
    (real)c_easiqlife > 143.5                         => fp3_lexid_cen_mod_4_c280,
                                                   -0.0098193032);

fp3_lexid_cen_mod_4 := map(
    c_fammar_p = ''                         => -0.0476677663,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 63.65 => fp3_lexid_cen_mod_4_c278,
    (real)c_fammar_p > 63.65                        => fp3_lexid_cen_mod_4_c279,
                                                 -0.0032903412);

fp3_lexid_cen_mod_5_c283 := map(
    c_rich_old = ''                         => -0.0161629323,
    NULL < (real)c_rich_old AND (real)c_rich_old <= 199.5 => -0.0170177443,
    (real)c_rich_old > 199.5                        => 0.2404434969,
                                                 -0.0161629323);

fp3_lexid_cen_mod_5_c286 := map(
    c_exp_prod = ''                         => 0.0413230207,
    NULL < (real)c_exp_prod AND (real)c_exp_prod <= 139.5 => 0.0586833381,
    (real)c_exp_prod > 139.5                        => -0.0342150269,
                                                 0.0413230207);

fp3_lexid_cen_mod_5_c285 := map(
    c_rest_indx = ''                         => 0.0080792743,
    NULL < (real)c_rest_indx AND (real)c_rest_indx <= 75.5 => fp3_lexid_cen_mod_5_c286,
    (real)c_rest_indx > 75.5                         => -0.0023122863,
                                                  0.0080792743);

fp3_lexid_cen_mod_5_c284 := map(
    c_ab_av_edu = ''                         => 0.0171682129,
    NULL < (real)c_ab_av_edu AND (real)c_ab_av_edu <= 50.5 => 0.0655613628,
    (real)c_ab_av_edu > 50.5                         => fp3_lexid_cen_mod_5_c285,
                                                  0.0171682129);

fp3_lexid_cen_mod_5 := map(
    c_cartheft = ''                       => -0.0427338141,
    NULL < (real)c_cartheft AND (real)c_cartheft <= 100 => fp3_lexid_cen_mod_5_c283,
    (real)c_cartheft > 100                        => fp3_lexid_cen_mod_5_c284,
                                               -0.0032383803);

fp3_lexid_cen_mod_6_c289 := map(
    c_easiqlife = ''                         => -0.0155237250,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 98.5 => -0.0341990147,
    (real)c_easiqlife > 98.5                         => -0.0032033684,
                                                  -0.0155237250);

fp3_lexid_cen_mod_6_c290 := map(
    c_hh1_p = ''                      => 0.0243204064,
    NULL < (real)c_hh1_p AND (real)c_hh1_p <= 23.15 => 0.0440539518,
    (real)c_hh1_p > 23.15                     => 0.0017510027,
                                           0.0243204064);

fp3_lexid_cen_mod_6_c288 := map(
    c_cpiall = ''                        => -0.0053177653,
    NULL < (real)c_cpiall AND (real)c_cpiall <= 212.75 => fp3_lexid_cen_mod_6_c289,
    (real)c_cpiall > 212.75                      => fp3_lexid_cen_mod_6_c290,
                                              -0.0053177653);

fp3_lexid_cen_mod_6_c291 := map(
    c_pop_12_17_p = ''                           => 0.0496430320,
    NULL < (real)c_pop_12_17_p AND (real)c_pop_12_17_p <= 17.3 => 0.0455610981,
    (real)c_pop_12_17_p > 17.3                           => 0.2655319806,
                                                      0.0496430320);

fp3_lexid_cen_mod_6 := map(
    c_famotf18_p = ''                           => -0.0309085139,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 28.95 => fp3_lexid_cen_mod_6_c288,
    (real)c_famotf18_p > 28.95                          => fp3_lexid_cen_mod_6_c291,
                                                     -0.0010605447);

fp3_lexid_cen_mod_7_c294 := map(
    c_white_col = ''                          => 0.0248889420,
    NULL < (real)c_white_col AND (real)c_white_col <= 31.65 => 0.0448954659,
    (real)c_white_col > 31.65                         => -0.0102391108,
                                                   0.0248889420);

fp3_lexid_cen_mod_7_c295 := map(
    C_OWNOCC_P = ''                        => 0.1324224175,
    NULL < (real)c_OWNOCC_P AND (real)c_OWNOCC_P <= 76.1 => 0.1724480434,
    (real)c_OWNOCC_P > 76.1                        => -0.0548975120,
                                                0.1324224175);

fp3_lexid_cen_mod_7_c293 := map(
    c_rich_blk = ''                         => 0.0319878512,
    NULL < (real)c_rich_blk AND (real)c_rich_blk <= 181.5 => fp3_lexid_cen_mod_7_c294,
    (real)c_rich_blk > 181.5                        => fp3_lexid_cen_mod_7_c295,
                                                 0.0319878512);

fp3_lexid_cen_mod_7_c296 := map(
    c_easiqlife = ''                          => -0.0054250949,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 145.5 => -0.0130926388,
    (real)c_easiqlife > 145.5                         => 0.0141182119,
                                                   -0.0054250949);

fp3_lexid_cen_mod_7 := map(
    c_rich_wht = ''                      => -0.0295365012,
    NULL < (real)c_rich_wht AND (real)c_rich_wht <= 47 => fp3_lexid_cen_mod_7_c293,
    (real)c_rich_wht > 47                        => fp3_lexid_cen_mod_7_c296,
                                              0.0013718141);

fp3_lexid_cen_mod_8_c300 := map(
    c_pop_75_84_p = ''                           => -0.0061473441,
    NULL < (real)c_pop_75_84_p AND (real)c_pop_75_84_p <= 9.45 => -0.0115306197,
    (real)c_pop_75_84_p > 9.45                           => 0.0492132599,
                                                      -0.0061473441);

fp3_lexid_cen_mod_8_c299 := map(
    c_finance = ''                       => 0.0021984001,
    NULL < (real)c_finance AND (real)c_finance <= 0.05 => 0.0210244160,
    (real)c_finance > 0.05                       => fp3_lexid_cen_mod_8_c300,
                                              0.0021984001);

fp3_lexid_cen_mod_8_c298 := map(
    c_born_usa = ''                         => -0.0045776183,
    NULL < (real)c_born_usa AND (real)c_born_usa <= 141.5 => fp3_lexid_cen_mod_8_c299,
    (real)c_born_usa > 141.5                        => -0.0331974313,
                                                 -0.0045776183);

fp3_lexid_cen_mod_8_c301 := map(
    c_child = ''                      => 0.0299997009,
    NULL < (real)c_child AND (real)c_child <= 30.25 => 0.0161430246,
    (real)c_child > 30.25                     => 0.0688106570,
                                           0.0299997009);

fp3_lexid_cen_mod_8 := map(
    c_famotf18_p = ''                           => -0.0173089403,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 21.45 => fp3_lexid_cen_mod_8_c298,
    (real)c_famotf18_p > 21.45                          => fp3_lexid_cen_mod_8_c301,
                                                     0.0005028881);

fp3_lexid_cen_mod_9_c304 := map(
    c_totcrime = ''                      => 0.0300014280,
    NULL < (real)c_totcrime AND (real)c_totcrime <= 22 => -0.0505924348,
    (real)c_totcrime > 22                        => 0.0364625394,
                                              0.0300014280);

fp3_lexid_cen_mod_9_c305 := map(
    c_easiqlife = ''                          => 0.0008214922,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 118.5 => -0.0199187824,
    (real)c_easiqlife > 118.5                         => 0.0182895193,
                                                   0.0008214922);

fp3_lexid_cen_mod_9_c303 := map(
    c_rest_indx = ''                         => 0.0107517861,
    NULL < (real)c_rest_indx AND (real)c_rest_indx <= 84.5 => fp3_lexid_cen_mod_9_c304,
    (real)c_rest_indx > 84.5                         => fp3_lexid_cen_mod_9_c305,
                                                  0.0107517861);

fp3_lexid_cen_mod_9_c306 := map(
    c_easiqlife = ''                          => -0.0174652400,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 105.5 => -0.0361877260,
    (real)c_easiqlife > 105.5                         => -0.0023065893,
                                                   -0.0174652400);

fp3_lexid_cen_mod_9 := map(
    c_fammar_p = ''                         => -0.0160818795,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 81.05 => fp3_lexid_cen_mod_9_c303,
    (real)c_fammar_p > 81.05                        => fp3_lexid_cen_mod_9_c306,
                                                 -0.0020764991);

fp3_lexid_cen_mod_10_c308 := map(
    c_fammar_p = ''                        => 0.0332147803,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 24.6 => 0.1179156218,
    (real)c_fammar_p > 24.6                        => 0.0283807373,
                                                0.0332147803);

fp3_lexid_cen_mod_10_c311 := map(
    c_low_hval = ''                        => -0.0146526837,
    NULL < (real)c_low_hval AND (real)c_low_hval <= 49.4 => -0.0175549050,
    (real)c_low_hval > 49.4                        => 0.2386941657,
                                                -0.0146526837);

fp3_lexid_cen_mod_10_c310 := map(
    c_femdiv_p = ''                        => 0.0107162143,
    NULL < (real)c_femdiv_p AND (real)c_femdiv_p <= 3.45 => fp3_lexid_cen_mod_10_c311,
    (real)c_femdiv_p > 3.45                        => 0.0241006487,
                                                0.0107162143);

fp3_lexid_cen_mod_10_c309 := map(
    c_easiqlife = ''                          => -0.0042842007,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 118.5 => -0.0179713315,
    (real)c_easiqlife > 118.5                         => fp3_lexid_cen_mod_10_c310,
                                                   -0.0042842007);

fp3_lexid_cen_mod_10 := map(
    c_civ_emp = ''                        => -0.0226357110,
    NULL < (real)c_civ_emp AND (real)c_civ_emp <= 52.85 => fp3_lexid_cen_mod_10_c308,
    (real)c_civ_emp > 52.85                       => fp3_lexid_cen_mod_10_c309,
                                               0.0010919612);

fp3_lexid_cen_mod_11_c313 := map(
    c_easiqlife = ''                          => -0.0121656166,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 100.5 => -0.0369201756,
    (real)c_easiqlife > 100.5                         => -0.0004815688,
                                                   -0.0121656166);

fp3_lexid_cen_mod_11_c315 := map(
    c_born_usa = ''                       => 0.0098221350,
    NULL < (real)c_born_usa AND (real)c_born_usa <= 2.5 => 0.0938493946,
    (real)c_born_usa > 2.5                        => 0.0074188593,
                                               0.0098221350);

fp3_lexid_cen_mod_11_c316 := map(
    c_exp_prod = ''                        => 0.0395048756,
    NULL < (real)c_exp_prod AND (real)c_exp_prod <= 17.5 => 0.1355226128,
    (real)c_exp_prod > 17.5                        => 0.0334439553,
                                                0.0395048756);

fp3_lexid_cen_mod_11_c314 := map(
    c_rental = ''                       => 0.0170784200,
    NULL < (real)c_rental AND (real)c_rental <= 161.5 => fp3_lexid_cen_mod_11_c315,
    (real)c_rental > 161.5                      => fp3_lexid_cen_mod_11_c316,
                                             0.0170784200);

fp3_lexid_cen_mod_11 := map(
    c_oldhouse = ''                         => -0.0286929562,
    NULL < (real)c_oldhouse AND (real)c_oldhouse <= 93.25 => fp3_lexid_cen_mod_11_c313,
    (real)c_oldhouse > 93.25                        => fp3_lexid_cen_mod_11_c314,
                                                 0.0013521752);

fp3_lexid_cen_mod_12_c321 := map(
    c_robbery = ''                       => -0.0051025881,
    NULL < (real)c_robbery AND (real)c_robbery <= 71.5 => -0.1360602911,
    (real)c_robbery > 71.5                       => 0.0171032833,
                                              -0.0051025881);

fp3_lexid_cen_mod_12_c320 := map(
    c_low_ed = ''                      => 0.0429749424,
    NULL < (real)c_low_ed AND (real)c_low_ed <= 68.2 => 0.0582620058,
    (real)c_low_ed > 68.2                      => fp3_lexid_cen_mod_12_c321,
                                            0.0429749424);

fp3_lexid_cen_mod_12_c319 := map(
    c_pop_12_17_p = ''                            => 0.0457197737,
    NULL < (real)c_pop_12_17_p AND (real)c_pop_12_17_p <= 16.95 => fp3_lexid_cen_mod_12_c320,
    (real)c_pop_12_17_p > 16.95                           => 0.2257484182,
                                                       0.0457197737);

fp3_lexid_cen_mod_12_c318 := map(
    c_sub_bus = ''                        => 0.0296417209,
    NULL < (real)c_sub_bus AND (real)c_sub_bus <= 107.5 => 0.0001435752,
    (real)c_sub_bus > 107.5                       => fp3_lexid_cen_mod_12_c319,
                                               0.0296417209);

fp3_lexid_cen_mod_12 := map(
    c_famotf18_p = ''                           => -0.0144446459,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 21.45 => -0.0061021130,
    (real)c_famotf18_p > 21.45                          => fp3_lexid_cen_mod_12_c318,
                                                     -0.0006340088);

fp3_lexid_cen_mod_13_c325 := map(
    c_highinc = ''                       => 0.0054208107,
    NULL < (real)c_highinc AND (real)c_highinc <= 2.05 => 0.0644931071,
    (real)c_highinc > 2.05                       => -0.0123877493,
                                              0.0054208107);

fp3_lexid_cen_mod_13_c324 := map(
    c_hval_100k_p = ''                           => 0.0241154506,
    NULL < (real)c_hval_100k_p AND (real)c_hval_100k_p <= 5.05 => 0.0585239561,
    (real)c_hval_100k_p > 5.05                           => fp3_lexid_cen_mod_13_c325,
                                                      0.0241154506);

fp3_lexid_cen_mod_13_c323 := map(
    c_white_col = ''                          => -0.0055683450,
    NULL < (real)c_white_col AND (real)c_white_col <= 28.05 => fp3_lexid_cen_mod_13_c324,
    (real)c_white_col > 28.05                         => -0.0131429583,
                                                   -0.0055683450);

fp3_lexid_cen_mod_13_c326 := map(
    C_INC_125K_P = ''                           => 0.0253015924,
    NULL < (real)c_INC_125K_P AND (real)c_INC_125K_P <= 17.35 => 0.0307043143,
    (real)c_INC_125K_P > 17.35                          => -0.0462774742,
                                                     0.0253015924);

fp3_lexid_cen_mod_13 := map(
    c_cpiall = ''                       => -0.0200644508,
    NULL < (real)c_cpiall AND (real)c_cpiall <= 218.4 => fp3_lexid_cen_mod_13_c323,
    (real)c_cpiall > 218.4                      => fp3_lexid_cen_mod_13_c326,
                                             0.0017901280);

fp3_lexid_cen_mod_14_c331 := map(
    c_civ_emp = ''                        => 0.0190590167,
    NULL < (real)c_civ_emp AND (real)c_civ_emp <= 53.45 => 0.0606323472,
    (real)c_civ_emp > 53.45                       => 0.0113419301,
                                               0.0190590167);

fp3_lexid_cen_mod_14_c330 := map(
    c_rape = ''                     => 0.0084999806,
    NULL < (real)c_rape AND (real)c_rape <= 128.5 => fp3_lexid_cen_mod_14_c331,
    (real)c_rape > 128.5                    => -0.0107975680,
                                         0.0084999806);

fp3_lexid_cen_mod_14_c329 := map(
    c_exp_prod = ''                        => 0.0135612584,
    NULL < (real)c_exp_prod AND (real)c_exp_prod <= 32.5 => 0.0511453903,
    (real)c_exp_prod > 32.5                        => fp3_lexid_cen_mod_14_c330,
                                                0.0135612584);

fp3_lexid_cen_mod_14_c328 := map(
    c_hval_300k_p = ''                            => 0.0165492009,
    NULL < (real)c_hval_300k_p AND (real)c_hval_300k_p <= 25.75 => fp3_lexid_cen_mod_14_c329,
    (real)c_hval_300k_p > 25.75                           => 0.0895451381,
                                                       0.0165492009);

fp3_lexid_cen_mod_14 := map(
    c_cartheft = ''                        => -0.0070755690,
    NULL < (real)c_cartheft AND (real)c_cartheft <= 98.5 => -0.0125095331,
    (real)c_cartheft > 98.5                        => fp3_lexid_cen_mod_14_c328,
                                                -0.0004313821);

fp3_lexid_cen_mod_15_c334 := map(
    c_families = ''                         => 0.0026350795,
    NULL < (real)c_families AND (real)c_families <= 525.5 => -0.0069688968,
    (real)c_families > 525.5                        => 0.0371942695,
                                                 0.0026350795);

fp3_lexid_cen_mod_15_c336 := map(
    c_vacant_p = ''                         => 0.0317896624,
    NULL < (real)c_vacant_p AND (real)c_vacant_p <= 21.95 => 0.0228481582,
    (real)c_vacant_p > 21.95                        => 0.1057672357,
                                                 0.0317896624);

fp3_lexid_cen_mod_15_c335 := map(
    c_murders = ''                        => 0.0347538768,
    NULL < (real)c_murders AND (real)c_murders <= 198.5 => fp3_lexid_cen_mod_15_c336,
    (real)c_murders > 198.5                       => 0.2491653870,
                                               0.0347538768);

fp3_lexid_cen_mod_15_c333 := map(
    c_unempl = ''                       => 0.0103089885,
    NULL < (real)c_unempl AND (real)c_unempl <= 149.5 => fp3_lexid_cen_mod_15_c334,
    (real)c_unempl > 149.5                      => fp3_lexid_cen_mod_15_c335,
                                             0.0103089885);

fp3_lexid_cen_mod_15 := map(
    c_med_hhinc = ''                            => -0.0078817449,
    NULL < (real)c_med_hhinc AND (real)c_med_hhinc <= 60784.5 => fp3_lexid_cen_mod_15_c333,
    (real)c_med_hhinc > 60784.5                         => -0.0115378235,
                                                     -0.0023645272);

fp3_lexid_cen_mod_16_c339 := map(
    c_famotf18_p = ''                           => -0.0145793804,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 68.05 => -0.0151383144,
    (real)c_famotf18_p > 68.05                          => 0.1682803007,
                                                     -0.0145793804);

fp3_lexid_cen_mod_16_c338 := map(
    c_easiqlife = ''                          => -0.0046626941,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 126.5 => fp3_lexid_cen_mod_16_c339,
    (real)c_easiqlife > 126.5                         => 0.0094088897,
                                                   -0.0046626941);

fp3_lexid_cen_mod_16_c341 := map(
    c_child = ''                      => 0.0323375787,
    NULL < (real)c_child AND (real)c_child <= 25.35 => -0.0414001388,
    (real)c_child > 25.35                     => 0.0876408668,
                                           0.0323375787);

fp3_lexid_cen_mod_16_c340 := map(
    c_hval_300k_p = ''                          => 0.0659893764,
    NULL < (real)c_hval_300k_p AND (real)c_hval_300k_p <= 3.8 => fp3_lexid_cen_mod_16_c341,
    (real)c_hval_300k_p > 3.8                           => 0.1644973659,
                                                     0.0659893764);

fp3_lexid_cen_mod_16 := map(
    c_unempl = ''                       => 0.0156710713,
    NULL < (real)c_unempl AND (real)c_unempl <= 186.5 => fp3_lexid_cen_mod_16_c338,
    (real)c_unempl > 186.5                      => fp3_lexid_cen_mod_16_c340,
                                             -0.0028943084);

fp3_lexid_cen_mod_17_c346 := map(
    c_unemp = ''                     => 0.0025798821,
    NULL < (real)c_unemp AND (real)c_unemp <= 4.25 => -0.0338954758,
    (real)c_unemp > 4.25                     => 0.0515545840,
                                          0.0025798821);

fp3_lexid_cen_mod_17_c345 := map(
    c_white_col = ''                          => 0.0157408711,
    NULL < (real)c_white_col AND (real)c_white_col <= 23.65 => 0.1109049449,
    (real)c_white_col > 23.65                         => fp3_lexid_cen_mod_17_c346,
                                                   0.0157408711);

fp3_lexid_cen_mod_17_c344 := map(
    c_larceny = ''                     => -0.0104787831,
    NULL < (real)c_larceny AND (real)c_larceny <= 67 => fp3_lexid_cen_mod_17_c345,
    (real)c_larceny > 67                       => -0.0332414850,
                                            -0.0104787831);

fp3_lexid_cen_mod_17_c343 := map(
    c_rural_p = ''                        => 0.0092724888,
    NULL < (real)c_rural_p AND (real)c_rural_p <= 13.05 => 0.0167064575,
    (real)c_rural_p > 13.05                       => fp3_lexid_cen_mod_17_c344,
                                               0.0092724888);

fp3_lexid_cen_mod_17 := map(
    c_white_col = ''                          => -0.0095986983,
    NULL < (real)c_white_col AND (real)c_white_col <= 43.75 => fp3_lexid_cen_mod_17_c343,
    (real)c_white_col > 43.75                         => -0.0158505640,
                                                   -0.0004134200);

fp3_lexid_cen_mod_18_c349 := map(
    c_born_usa = ''                       => 0.0303812886,
    NULL < (real)c_born_usa AND (real)c_born_usa <= 3.5 => 0.1426389077,
    (real)c_born_usa > 3.5                        => 0.0266750576,
                                               0.0303812886);

fp3_lexid_cen_mod_18_c351 := map(
    c_retired2 = ''                        => 0.0770446118,
    NULL < (real)c_retired2 AND (real)c_retired2 <= 54.5 => 0.1687958789,
    (real)c_retired2 > 54.5                        => 0.0233365531,
                                                0.0770446118);

fp3_lexid_cen_mod_18_c350 := map(
    C_INC_50K_P = ''                          => 0.0010747484,
    NULL < (real)c_INC_50K_P AND (real)c_INC_50K_P <= 24.75 => -0.0010491403,
    (real)c_INC_50K_P > 24.75                         => fp3_lexid_cen_mod_18_c351,
                                                   0.0010747484);

fp3_lexid_cen_mod_18_c348 := map(
    c_construction = ''                            => 0.0077430756,
    NULL < (real)c_construction AND (real)c_construction <= 0.05 => fp3_lexid_cen_mod_18_c349,
    (real)c_construction > 0.05                            => fp3_lexid_cen_mod_18_c350,
                                                        0.0077430756);

fp3_lexid_cen_mod_18 := map(
    c_robbery = ''                       => -0.0148962269,
    NULL < (real)c_robbery AND (real)c_robbery <= 74.5 => -0.0126179704,
    (real)c_robbery > 74.5                       => fp3_lexid_cen_mod_18_c348,
                                              -0.0012710160);

fp3_lexid_cen_mod_19_c355 := map(
    c_fammar_p = ''                         => 0.0443892037,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 79.15 => 0.0849900229,
    (real)c_fammar_p > 79.15                        => -0.0159320134,
                                                 0.0443892037);

fp3_lexid_cen_mod_19_c354 := map(
    c_lar_fam = ''                        => -0.0053415044,
    NULL < (real)c_lar_fam AND (real)c_lar_fam <= 155.5 => -0.0098577587,
    (real)c_lar_fam > 155.5                       => fp3_lexid_cen_mod_19_c355,
                                               -0.0053415044);

fp3_lexid_cen_mod_19_c356 := map(
    c_rest_indx = ''                          => 0.0174689176,
    NULL < (real)c_rest_indx AND (real)c_rest_indx <= 169.5 => 0.0211745856,
    (real)c_rest_indx > 169.5                         => -0.0394567704,
                                                   0.0174689176);

fp3_lexid_cen_mod_19_c353 := map(
    c_easiqlife = ''                          => 0.0058482517,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 118.5 => fp3_lexid_cen_mod_19_c354,
    (real)c_easiqlife > 118.5                         => fp3_lexid_cen_mod_19_c356,
                                                   0.0058482517);

fp3_lexid_cen_mod_19 := map(
    c_exp_prod = ''                         => -0.0435973511,
    NULL < (real)c_exp_prod AND (real)c_exp_prod <= 143.5 => fp3_lexid_cen_mod_19_c353,
    (real)c_exp_prod > 143.5                        => -0.0191352583,
                                                 -0.0011075363);

fp3_lexid_cen_mod_20_c361 := map(
    c_pop_0_5_p = ''                          => 0.0031388968,
    NULL < (real)c_pop_0_5_p AND (real)c_pop_0_5_p <= 10.65 => -0.0054629912,
    (real)c_pop_0_5_p > 10.65                         => 0.0290175466,
                                                   0.0031388968);

fp3_lexid_cen_mod_20_c360 := map(
    c_hh2_p = ''                      => 0.0081185422,
    NULL < (real)c_hh2_p AND (real)c_hh2_p <= 47.75 => fp3_lexid_cen_mod_20_c361,
    (real)c_hh2_p > 47.75                     => 0.0511151147,
                                           0.0081185422);

fp3_lexid_cen_mod_20_c359 := map(
    c_lowrent = ''                        => -0.0002308629,
    NULL < (real)c_lowrent AND (real)c_lowrent <= 54.55 => fp3_lexid_cen_mod_20_c360,
    (real)c_lowrent > 54.55                       => -0.0268825107,
                                               -0.0002308629);

fp3_lexid_cen_mod_20_c358 := map(
    c_white_col = ''                          => -0.0081316422,
    NULL < (real)c_white_col AND (real)c_white_col <= 43.35 => fp3_lexid_cen_mod_20_c359,
    (real)c_white_col > 43.35                         => -0.0215704547,
                                                   -0.0081316422);

fp3_lexid_cen_mod_20 := map(
    c_housingcpi = ''                            => -0.0120536179,
    NULL < (real)c_housingcpi AND (real)c_housingcpi <= 215.95 => fp3_lexid_cen_mod_20_c358,
    (real)c_housingcpi > 215.95                          => 0.0141922546,
                                                      -0.0019078411);

fp3_lexid_cen_mod_21_c366 := map(
    c_young = ''                     => 0.0177320239,
    NULL < (real)c_young AND (real)c_young <= 14.4 => 0.1429015020,
    (real)c_young > 14.4                     => -0.0034981350,
                                          0.0177320239);

fp3_lexid_cen_mod_21_c365 := map(
    c_lowrent = ''                       => 0.0511631810,
    NULL < (real)c_lowrent AND (real)c_lowrent <= 2.25 => fp3_lexid_cen_mod_21_c366,
    (real)c_lowrent > 2.25                       => 0.0876836860,
                                              0.0511631810);

fp3_lexid_cen_mod_21_c364 := map(
    c_easiqlife = ''                          => 0.0225943630,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 144.5 => 0.0143199771,
    (real)c_easiqlife > 144.5                         => fp3_lexid_cen_mod_21_c365,
                                                   0.0225943630);

fp3_lexid_cen_mod_21_c363 := map(
    c_business = ''                        => 0.0112958512,
    NULL < (real)c_business AND (real)c_business <= 25.5 => fp3_lexid_cen_mod_21_c364,
    (real)c_business > 25.5                        => -0.0074003380,
                                                0.0112958512);

fp3_lexid_cen_mod_21 := map(
    c_cartheft = ''                       => -0.0234729685,
    NULL < (real)c_cartheft AND (real)c_cartheft <= 100 => -0.0105530412,
    (real)c_cartheft > 100                        => fp3_lexid_cen_mod_21_c363,
                                               -0.0018809454);

fp3_lexid_cen_mod_22_c371 := map(
    c_unempl = ''                     => -0.0025834939,
    NULL < (real)c_unempl AND (real)c_unempl <= 8.5 => 0.2953243846,
    (real)c_unempl > 8.5                      => -0.0087791517,
                                           -0.0025834939);

fp3_lexid_cen_mod_22_c370 := map(
    c_fammar18_p = ''                          => 0.0051079579,
    NULL < (real)c_fammar18_p AND (real)c_fammar18_p <= 59.2 => fp3_lexid_cen_mod_22_c371,
    (real)c_fammar18_p > 59.2                          => 0.2567893532,
                                                    0.0051079579);

fp3_lexid_cen_mod_22_c369 := map(
    c_business = ''                        => 0.0307429560,
    NULL < (real)c_business AND (real)c_business <= 23.5 => 0.0717995362,
    (real)c_business > 23.5                        => fp3_lexid_cen_mod_22_c370,
                                                0.0307429560);

fp3_lexid_cen_mod_22_c368 := map(
    c_rich_old = ''                         => -0.0024970313,
    NULL < (real)c_rich_old AND (real)c_rich_old <= 185.5 => -0.0059597495,
    (real)c_rich_old > 185.5                        => fp3_lexid_cen_mod_22_c369,
                                                 -0.0024970313);

fp3_lexid_cen_mod_22 := map(
    c_unemp = ''                     => -0.0091289605,
    NULL < (real)c_unemp AND (real)c_unemp <= 9.85 => fp3_lexid_cen_mod_22_c368,
    (real)c_unemp > 9.85                     => 0.0479254524,
                                          -0.0008628290);

fp3_lexid_cen_mod_23_c375 := map(
    C_INC_50K_P = ''                         => 0.0124598405,
    NULL < (real)c_INC_50K_P AND (real)c_INC_50K_P <= 0.75 => 0.3007363163,
    (real)c_INC_50K_P > 0.75                         => 0.0118796906,
                                                  0.0124598405);

fp3_lexid_cen_mod_23_c374 := map(
    C_INC_25K_P = ''                         => 0.0071345475,
    NULL < (real)c_INC_25K_P AND (real)c_INC_25K_P <= 2.45 => -0.0200878692,
    (real)c_INC_25K_P > 2.45                         => fp3_lexid_cen_mod_23_c375,
                                                  0.0071345475);

fp3_lexid_cen_mod_23_c373 := map(
    c_easiqlife = ''                          => -0.0015217804,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 105.5 => -0.0127878756,
    (real)c_easiqlife > 105.5                         => fp3_lexid_cen_mod_23_c374,
                                                   -0.0015217804);

fp3_lexid_cen_mod_23_c376 := map(
    c_pop_75_84_p = ''                           => 0.0610837883,
    NULL < (real)c_pop_75_84_p AND (real)c_pop_75_84_p <= 1.35 => -0.0328781832,
    (real)c_pop_75_84_p > 1.35                           => 0.0881028960,
                                                      0.0610837883);

fp3_lexid_cen_mod_23 := map(
    c_hval_500k_p = ''                            => 0.0120430729,
    NULL < (real)c_hval_500k_p AND (real)c_hval_500k_p <= 38.65 => fp3_lexid_cen_mod_23_c373,
    (real)c_hval_500k_p > 38.65                           => fp3_lexid_cen_mod_23_c376,
                                                       0.0004579611);

fp3_lexid_cen_mod_24_c380 := map(
    c_transport = ''                          => 0.0135404148,
    NULL < (real)c_transport AND (real)c_transport <= 13.65 => 0.0086144811,
    (real)c_transport > 13.65                         => 0.1447367631,
                                                   0.0135404148);

fp3_lexid_cen_mod_24_c379 := map(
    c_totsales = ''                        => -0.0031035940,
    NULL < (real)c_totsales AND (real)c_totsales <= 3838 => fp3_lexid_cen_mod_24_c380,
    (real)c_totsales > 3838                        => -0.0202546157,
                                                -0.0031035940);

fp3_lexid_cen_mod_24_c378 := map(
    c_urban_p = ''                        => -0.0118008632,
    NULL < (real)c_urban_p AND (real)c_urban_p <= 91.85 => -0.0349257893,
    (real)c_urban_p > 91.85                       => fp3_lexid_cen_mod_24_c379,
                                               -0.0118008632);

fp3_lexid_cen_mod_24_c381 := map(
    c_pop_25_34_p = ''                            => 0.0076281273,
    NULL < (real)c_pop_25_34_p AND (real)c_pop_25_34_p <= 21.55 => 0.0127572144,
    (real)c_pop_25_34_p > 21.55                           => -0.0231398781,
                                                       0.0076281273);

fp3_lexid_cen_mod_24 := map(
    c_easiqlife = ''                          => -0.0046543749,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 114.5 => fp3_lexid_cen_mod_24_c378,
    (real)c_easiqlife > 114.5                         => fp3_lexid_cen_mod_24_c381,
                                                   -0.0019741375);

fp3_lexid_cen_mod_25_c385 := map(
    c_young = ''                      => 0.0712493917,
    NULL < (real)c_young AND (real)c_young <= 23.95 => 0.0525864791,
    (real)c_young > 23.95                     => 0.2392156056,
                                           0.0712493917);

fp3_lexid_cen_mod_25_c384 := map(
    c_retired = ''                        => 0.0193203749,
    NULL < (real)c_retired AND (real)c_retired <= 22.05 => 0.0145301514,
    (real)c_retired > 22.05                       => fp3_lexid_cen_mod_25_c385,
                                               0.0193203749);

fp3_lexid_cen_mod_25_c383 := map(
    c_hval_300k_p = ''                           => 0.0094404495,
    NULL < (real)c_hval_300k_p AND (real)c_hval_300k_p <= 1.75 => -0.0039675152,
    (real)c_hval_300k_p > 1.75                           => fp3_lexid_cen_mod_25_c384,
                                                      0.0094404495);

fp3_lexid_cen_mod_25_c386 := map(
    c_pop_45_54_p = ''                           => -0.0122514383,
    NULL < (real)c_pop_45_54_p AND (real)c_pop_45_54_p <= 29.8 => -0.0138230363,
    (real)c_pop_45_54_p > 29.8                           => 0.2159554365,
                                                      -0.0122514383);

fp3_lexid_cen_mod_25 := map(
    c_fammar_p = ''                         => 0.0172336298,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 82.85 => fp3_lexid_cen_mod_25_c383,
    (real)c_fammar_p > 82.85                        => fp3_lexid_cen_mod_25_c386,
                                                 0.0012872108);

fp3_lexid_cen_mod_26_c390 := map(
    c_rnt1500_p = ''                         => -0.0099850976,
    NULL < (real)c_rnt1500_p AND (real)c_rnt1500_p <= 69.8 => -0.0116139799,
    (real)c_rnt1500_p > 69.8                         => 0.1394842482,
                                                  -0.0099850976);

fp3_lexid_cen_mod_26_c391 := map(
    c_mort_indx = ''                          => 0.0119733538,
    NULL < (real)c_mort_indx AND (real)c_mort_indx <= 186.5 => 0.0108331706,
    (real)c_mort_indx > 186.5                         => 0.1476551472,
                                                   0.0119733538);

fp3_lexid_cen_mod_26_c389 := map(
    c_low_ed = ''                       => 0.0018562622,
    NULL < (real)c_low_ed AND (real)c_low_ed <= 37.45 => fp3_lexid_cen_mod_26_c390,
    (real)c_low_ed > 37.45                      => fp3_lexid_cen_mod_26_c391,
                                             0.0018562622);

fp3_lexid_cen_mod_26_c388 := map(
    c_info = ''                     => 0.0030733063,
    NULL < (real)c_info AND (real)c_info <= 17.05 => fp3_lexid_cen_mod_26_c389,
    (real)c_info > 17.05                    => 0.0917916250,
                                         0.0030733063);

fp3_lexid_cen_mod_26 := map(
    c_exp_prod = ''                         => -0.0083151624,
    NULL < (real)c_exp_prod AND (real)c_exp_prod <= 147.5 => fp3_lexid_cen_mod_26_c388,
    (real)c_exp_prod > 147.5                        => -0.0219387272,
                                                 -0.0022591467);

fp3_lexid_cen_mod_27_c395 := map(
    c_mining = ''                      => 0.0046477260,
    NULL < (real)c_mining AND (real)c_mining <= 2.35 => 0.0060726012,
    (real)c_mining > 2.35                      => -0.0501637046,
                                            0.0046477260);

fp3_lexid_cen_mod_27_c394 := map(
    c_fammar_p = ''                         => 0.0019304020,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 92.95 => fp3_lexid_cen_mod_27_c395,
    (real)c_fammar_p > 92.95                        => -0.0310135379,
                                                 0.0019304020);

fp3_lexid_cen_mod_27_c393 := map(
    c_high_ed = ''                        => -0.0007711324,
    NULL < (real)c_high_ed AND (real)c_high_ed <= 63.05 => fp3_lexid_cen_mod_27_c394,
    (real)c_high_ed > 63.05                       => -0.0318450762,
                                               -0.0007711324);

fp3_lexid_cen_mod_27_c396 := map(
    c_incollege = ''                         => 0.0891697638,
    NULL < (real)c_incollege AND (real)c_incollege <= 3.15 => 0.2333727673,
    (real)c_incollege > 3.15                         => 0.0193214340,
                                                  0.0891697638);

fp3_lexid_cen_mod_27 := map(
    c_lux_prod = ''                         => -0.0235259833,
    NULL < (real)c_lux_prod AND (real)c_lux_prod <= 198.5 => fp3_lexid_cen_mod_27_c393,
    (real)c_lux_prod > 198.5                        => fp3_lexid_cen_mod_27_c396,
                                                 -0.0004799105);

fp3_lexid_cen_mod_28_c400 := map(
    c_born_usa = ''                        => -0.0040315490,
    NULL < (real)c_born_usa AND (real)c_born_usa <= 68.5 => 0.0088703767,
    (real)c_born_usa > 68.5                        => -0.0124264934,
                                                -0.0040315490);

fp3_lexid_cen_mod_28_c399 := map(
    c_young = ''                      => -0.0075110678,
    NULL < (real)c_young AND (real)c_young <= 33.25 => fp3_lexid_cen_mod_28_c400,
    (real)c_young > 33.25                     => -0.0325617437,
                                           -0.0075110678);

fp3_lexid_cen_mod_28_c398 := map(
    c_hh6_p = ''                     => -0.0048170661,
    NULL < (real)c_hh6_p AND (real)c_hh6_p <= 7.95 => fp3_lexid_cen_mod_28_c399,
    (real)c_hh6_p > 7.95                     => 0.0332879530,
                                          -0.0048170661);

fp3_lexid_cen_mod_28_c401 := map(
    c_serv_empl = ''                          => 0.0318820270,
    NULL < (real)c_serv_empl AND (real)c_serv_empl <= 193.5 => 0.0384719032,
    (real)c_serv_empl > 193.5                         => -0.0909917059,
                                                   0.0318820270);

fp3_lexid_cen_mod_28 := map(
    c_retail = ''                       => -0.0030822273,
    NULL < (real)c_retail AND (real)c_retail <= 30.15 => fp3_lexid_cen_mod_28_c398,
    (real)c_retail > 30.15                      => fp3_lexid_cen_mod_28_c401,
                                             -0.0016470323);

fp3_lexid_cen_mod_29_c405 := map(
    c_hh2_p = ''                      => 0.1048448086,
    NULL < (real)c_hh2_p AND (real)c_hh2_p <= 43.55 => 0.0708655308,
    (real)c_hh2_p > 43.55                     => 0.3227119423,
                                           0.1048448086);

fp3_lexid_cen_mod_29_c404 := map(
    c_pop_6_11_p = ''                          => 0.0617210507,
    NULL < (real)c_pop_6_11_p AND (real)c_pop_6_11_p <= 6.95 => -0.0029645860,
    (real)c_pop_6_11_p > 6.95                          => fp3_lexid_cen_mod_29_c405,
                                                    0.0617210507);

fp3_lexid_cen_mod_29_c403 := map(
    c_popover25 = ''                          => 0.0098711715,
    NULL < (real)c_popover25 AND (real)c_popover25 <= 444.5 => fp3_lexid_cen_mod_29_c404,
    (real)c_popover25 > 444.5                         => 0.0070727971,
                                                   0.0098711715);

fp3_lexid_cen_mod_29_c406 := map(
    c_incollege = ''                          => -0.0083211791,
    NULL < (real)c_incollege AND (real)c_incollege <= 17.35 => -0.0063921599,
    (real)c_incollege > 17.35                         => -0.0686560990,
                                                   -0.0083211791);

fp3_lexid_cen_mod_29 := map(
    c_med_yearblt = ''                             => -0.0060115689,
    NULL < (real)c_med_yearblt AND (real)c_med_yearblt <= 1969.5 => fp3_lexid_cen_mod_29_c403,
    (real)c_med_yearblt > 1969.5                           => fp3_lexid_cen_mod_29_c406,
                                                        -0.0015294336);

fp3_lexid_cen_mod_30_c411 := map(
    c_murders = ''                        => 0.0653454726,
    NULL < (real)c_murders AND (real)c_murders <= 147.5 => 0.1804353697,
    (real)c_murders > 147.5                       => -0.0122732952,
                                               0.0653454726);

fp3_lexid_cen_mod_30_c410 := map(
    c_lowrent = ''                        => 0.0979043130,
    NULL < (real)c_lowrent AND (real)c_lowrent <= 44.85 => fp3_lexid_cen_mod_30_c411,
    (real)c_lowrent > 44.85                       => 0.2653497776,
                                               0.0979043130);

fp3_lexid_cen_mod_30_c409 := map(
    c_retired2 = ''                        => 0.0196395137,
    NULL < (real)c_retired2 AND (real)c_retired2 <= 27.5 => fp3_lexid_cen_mod_30_c410,
    (real)c_retired2 > 27.5                        => 0.0158238829,
                                                0.0196395137);

fp3_lexid_cen_mod_30_c408 := map(
    c_cartheft = ''                         => 0.0046324101,
    NULL < (real)c_cartheft AND (real)c_cartheft <= 132.5 => -0.0009661262,
    (real)c_cartheft > 132.5                        => fp3_lexid_cen_mod_30_c409,
                                                 0.0046324101);

fp3_lexid_cen_mod_30 := map(
    c_asian_lang = ''                           => 0.0009453359,
    NULL < (real)c_asian_lang AND (real)c_asian_lang <= 149.5 => fp3_lexid_cen_mod_30_c408,
    (real)c_asian_lang > 149.5                          => -0.0103393536,
                                                     -0.0008789121);

fp3_lexid_cen_mod_31_c416 := map(
    c_pop_65_74_p = ''                          => 0.0742746790,
    NULL < (real)c_pop_65_74_p AND (real)c_pop_65_74_p <= 5.1 => -0.0705809083,
    (real)c_pop_65_74_p > 5.1                           => 0.1240687872,
                                                     0.0742746790);

fp3_lexid_cen_mod_31_c415 := map(
    c_born_usa = ''                       => -0.0002857811,
    NULL < (real)c_born_usa AND (real)c_born_usa <= 125 => -0.0315648034,
    (real)c_born_usa > 125                        => fp3_lexid_cen_mod_31_c416,
                                               -0.0002857811);

fp3_lexid_cen_mod_31_c414 := map(
    c_famotf18_p = ''                           => 0.0242488754,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 42.95 => fp3_lexid_cen_mod_31_c415,
    (real)c_famotf18_p > 42.95                          => 0.1102679724,
                                                     0.0242488754);

fp3_lexid_cen_mod_31_c413 := map(
    c_med_hhinc = ''                          => 0.0399829766,
    NULL < (real)c_med_hhinc AND (real)c_med_hhinc <= 76754 => fp3_lexid_cen_mod_31_c414,
    (real)c_med_hhinc > 76754                         => 0.1800914016,
                                                   0.0399829766);

fp3_lexid_cen_mod_31 := map(
    c_fammar18_p = ''                          => -0.0007964599,
    NULL < (real)c_fammar18_p AND (real)c_fammar18_p <= 8.85 => fp3_lexid_cen_mod_31_c413,
    (real)c_fammar18_p > 8.85                          => -0.0012168688,
                                                    0.0003421643);

fp3_lexid_cen_mod_32_c420 := map(
    c_famotf18_p = ''                           => 0.0019691151,
    NULL < (real)c_famotf18_p AND (real)c_famotf18_p <= 20.15 => -0.0045420410,
    (real)c_famotf18_p > 20.15                          => 0.0381761413,
                                                     0.0019691151);

fp3_lexid_cen_mod_32_c419 := map(
    c_hh3_p = ''                      => 0.0087123797,
    NULL < (real)c_hh3_p AND (real)c_hh3_p <= 22.95 => fp3_lexid_cen_mod_32_c420,
    (real)c_hh3_p > 22.95                     => 0.0386532528,
                                           0.0087123797);

fp3_lexid_cen_mod_32_c418 := map(
    c_easiqlife = ''                          => -0.0026388266,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 136.5 => -0.0090060409,
    (real)c_easiqlife > 136.5                         => fp3_lexid_cen_mod_32_c419,
                                                   -0.0026388266);

fp3_lexid_cen_mod_32_c421 := map(
    c_hval_125k_p = ''                            => 0.0441715106,
    NULL < (real)c_hval_125k_p AND (real)c_hval_125k_p <= 31.25 => 0.3391217460,
    (real)c_hval_125k_p > 31.25                           => 0.0348376424,
                                                       0.0441715106);

fp3_lexid_cen_mod_32 := map(
    c_hval_125k_p = ''                            => -0.0041848314,
    NULL < (real)c_hval_125k_p AND (real)c_hval_125k_p <= 31.05 => fp3_lexid_cen_mod_32_c418,
    (real)c_hval_125k_p > 31.05                           => fp3_lexid_cen_mod_32_c421,
                                                       -0.0012919855);

fp3_lexid_cen_mod_33_c426 := map(
    c_hh1_p = ''                      => -0.0105892099,
    NULL < (real)c_hh1_p AND (real)c_hh1_p <= 58.15 => -0.0131450002,
    (real)c_hh1_p > 58.15                     => 0.1425258689,
                                           -0.0105892099);

fp3_lexid_cen_mod_33_c425 := map(
    c_lar_fam = ''                        => -0.0086018064,
    NULL < (real)c_lar_fam AND (real)c_lar_fam <= 179.5 => fp3_lexid_cen_mod_33_c426,
    (real)c_lar_fam > 179.5                       => 0.2133249087,
                                               -0.0086018064);

fp3_lexid_cen_mod_33_c424 := map(
    c_easiqlife = ''                         => 0.0088527676,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 81.5 => fp3_lexid_cen_mod_33_c425,
    (real)c_easiqlife > 81.5                         => 0.0154840670,
                                                  0.0088527676);

fp3_lexid_cen_mod_33_c423 := map(
    c_oldhouse = ''                         => 0.0031629854,
    NULL < (real)c_oldhouse AND (real)c_oldhouse <= 37.95 => -0.0134815482,
    (real)c_oldhouse > 37.95                        => fp3_lexid_cen_mod_33_c424,
                                                 0.0031629854);

fp3_lexid_cen_mod_33 := map(
    c_young = ''                      => 0.0045332157,
    NULL < (real)c_young AND (real)c_young <= 35.75 => fp3_lexid_cen_mod_33_c423,
    (real)c_young > 35.75                     => -0.0263761325,
                                           0.0007054336);

fp3_lexid_cen_mod_34_c428 := map(
    c_hh5_p = ''                      => -0.0014673490,
    NULL < (real)c_hh5_p AND (real)c_hh5_p <= 24.25 => -0.0005806557,
    (real)c_hh5_p > 24.25                     => -0.0746006000,
                                           -0.0014673490);

fp3_lexid_cen_mod_34_c431 := map(
    c_hh5_p = ''                     => 0.0369771006,
    NULL < (real)c_hh5_p AND (real)c_hh5_p <= 4.95 => 0.0644288728,
    (real)c_hh5_p > 4.95                     => 0.0058209928,
                                          0.0369771006);

fp3_lexid_cen_mod_34_c430 := map(
    c_hhsize = ''                      => 0.0422342841,
    NULL < (real)c_hhsize AND (real)c_hhsize <= 3.12 => fp3_lexid_cen_mod_34_c431,
    (real)c_hhsize > 3.12                      => 0.1877925521,
                                            0.0422342841);

fp3_lexid_cen_mod_34_c429 := map(
    c_murders = ''                      => 0.0319879483,
    NULL < (real)c_murders AND (real)c_murders <= 141 => fp3_lexid_cen_mod_34_c430,
    (real)c_murders > 141                       => -0.0484063785,
                                             0.0319879483);

fp3_lexid_cen_mod_34 := map(
    c_rich_old = ''                         => -0.0168480576,
    NULL < (real)c_rich_old AND (real)c_rich_old <= 184.5 => fp3_lexid_cen_mod_34_c428,
    (real)c_rich_old > 184.5                        => fp3_lexid_cen_mod_34_c429,
                                                 0.0013111905);

fp3_lexid_cen_mod_35_c434 := map(
    c_high_hval = ''                          => 0.0109099352,
    NULL < (real)c_high_hval AND (real)c_high_hval <= 10.15 => 0.0781710942,
    (real)c_high_hval > 10.15                         => 0.0016717652,
                                                   0.0109099352);

fp3_lexid_cen_mod_35_c436 := map(
    c_for_sale = ''                       => 0.0666370613,
    NULL < (real)c_for_sale AND (real)c_for_sale <= 116 => -0.0512558069,
    (real)c_for_sale > 116                        => 0.1890642706,
                                               0.0666370613);

fp3_lexid_cen_mod_35_c435 := map(
    c_rich_hisp = ''                        => 0.1273873166,
    NULL < (real)c_rich_hisp AND (real)c_rich_hisp <= 177 => fp3_lexid_cen_mod_35_c436,
    (real)c_rich_hisp > 177                         => 0.2883754932,
                                                 0.1273873166);

fp3_lexid_cen_mod_35_c433 := map(
    c_hh4_p = ''                     => 0.0157576255,
    NULL < (real)c_hh4_p AND (real)c_hh4_p <= 31.7 => fp3_lexid_cen_mod_35_c434,
    (real)c_hh4_p > 31.7                     => fp3_lexid_cen_mod_35_c435,
                                          0.0157576255);

fp3_lexid_cen_mod_35 := map(
    c_exp_homes = ''                          => -0.0023020582,
    NULL < (real)c_exp_homes AND (real)c_exp_homes <= 173.5 => -0.0046053274,
    (real)c_exp_homes > 173.5                         => fp3_lexid_cen_mod_35_c433,
                                                   -0.0013264763);

fp3_lexid_cen_mod_36_c440 := map(
    c_hh7p_p = ''                     => 0.0839933974,
    NULL < (real)c_hh7p_p AND (real)c_hh7p_p <= 1.9 => 0.0683827663,
    (real)c_hh7p_p > 1.9                      => 0.2213669507,
                                           0.0839933974);

fp3_lexid_cen_mod_36_c439 := map(
    c_med_rent = ''                         => 0.0522949415,
    NULL < (real)c_med_rent AND (real)c_med_rent <= 559.5 => -0.0031773564,
    (real)c_med_rent > 559.5                        => fp3_lexid_cen_mod_36_c440,
                                                 0.0522949415);

fp3_lexid_cen_mod_36_c438 := map(
    c_totsales = ''                         => 0.0352769591,
    NULL < (real)c_totsales AND (real)c_totsales <= 21568 => fp3_lexid_cen_mod_36_c439,
    (real)c_totsales > 21568                        => -0.0703992217,
                                                 0.0352769591);

fp3_lexid_cen_mod_36_c441 := map(
    c_pop_18_24_p = ''                           => -0.0023239596,
    NULL < (real)c_pop_18_24_p AND (real)c_pop_18_24_p <= 0.35 => 0.0961802680,
    (real)c_pop_18_24_p > 0.35                           => -0.0031374904,
                                                      -0.0023239596);

fp3_lexid_cen_mod_36 := map(
    c_fammar18_p = ''                          => 0.0076480360,
    NULL < (real)c_fammar18_p AND (real)c_fammar18_p <= 8.75 => fp3_lexid_cen_mod_36_c438,
    (real)c_fammar18_p > 8.75                          => fp3_lexid_cen_mod_36_c441,
                                                    -0.0005944811);

fp3_lexid_cen_mod_37_c445 := map(
    c_pop_35_44_p = ''                           => 0.0669369066,
    NULL < (real)c_pop_35_44_p AND (real)c_pop_35_44_p <= 7.35 => 0.2683670556,
    (real)c_pop_35_44_p > 7.35                           => 0.0555709421,
                                                      0.0669369066);

fp3_lexid_cen_mod_37_c446 := map(
    c_easiqlife = ''                          => 0.0130842555,
    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 115.5 => -0.0128210483,
    (real)c_easiqlife > 115.5                         => 0.0348492688,
                                                   0.0130842555);

fp3_lexid_cen_mod_37_c444 := map(
    c_cpiall = ''                       => 0.0244839687,
    NULL < (real)c_cpiall AND (real)c_cpiall <= 209.3 => fp3_lexid_cen_mod_37_c445,
    (real)c_cpiall > 209.3                      => fp3_lexid_cen_mod_37_c446,
                                             0.0244839687);

fp3_lexid_cen_mod_37_c443 := map(
    c_low_ed = ''                       => 0.0174946422,
    NULL < (real)c_low_ed AND (real)c_low_ed <= 73.35 => fp3_lexid_cen_mod_37_c444,
    (real)c_low_ed > 73.35                      => -0.0413784149,
                                             0.0174946422);

fp3_lexid_cen_mod_37 := map(
    c_unempl = ''                       => 0.0134935479,
    NULL < (real)c_unempl AND (real)c_unempl <= 144.5 => -0.0047437885,
    (real)c_unempl > 144.5                      => fp3_lexid_cen_mod_37_c443,
                                             -0.0007886254);

fp3_lexid_cen_mod_38_c451 := map(
    c_health = ''                   => 0.0884615284,
    NULL < (real)c_health AND (real)c_health <= 5 => 0.0221648220,
    (real)c_health > 5                      => 0.1207852957,
                                         0.0884615284);

fp3_lexid_cen_mod_38_c450 := map(
    c_blue_col = ''                        => 0.0800318776,
    NULL < (real)c_blue_col AND (real)c_blue_col <= 1.15 => -0.1491013575,
    (real)c_blue_col > 1.15                        => fp3_lexid_cen_mod_38_c451,
                                                0.0800318776);

fp3_lexid_cen_mod_38_c449 := map(
    c_fammar18_p = ''                           => 0.0493002734,
    NULL < (real)c_fammar18_p AND (real)c_fammar18_p <= 24.85 => fp3_lexid_cen_mod_38_c450,
    (real)c_fammar18_p > 24.85                          => 0.0155173043,
                                                     0.0493002734);

fp3_lexid_cen_mod_38_c448 := map(
    c_assault = ''                        => 0.0393948423,
    NULL < (real)c_assault AND (real)c_assault <= 193.5 => fp3_lexid_cen_mod_38_c449,
    (real)c_assault > 193.5                       => -0.0733746809,
                                               0.0393948423);

fp3_lexid_cen_mod_38 := map(
    c_retired2 = ''                         => -0.0070440925,
    NULL < (real)c_retired2 AND (real)c_retired2 <= 169.5 => -0.0006905393,
    (real)c_retired2 > 169.5                        => fp3_lexid_cen_mod_38_c448,
                                                 0.0015076192);

fp3_lexid_cen_mod_39_c456 := map(
    c_high_ed = ''                        => 0.0278422082,
    NULL < (real)c_high_ed AND (real)c_high_ed <= 71.15 => 0.0249843686,
    (real)c_high_ed > 71.15                       => 0.1946175604,
                                               0.0278422082);

fp3_lexid_cen_mod_39_c455 := map(
    c_employees = ''                           => 0.0220967689,
    NULL < (real)c_employees AND (real)c_employees <= 2947.5 => fp3_lexid_cen_mod_39_c456,
    (real)c_employees > 2947.5                         => -0.0655080033,
                                                    0.0220967689);

fp3_lexid_cen_mod_39_c454 := map(
    c_rich_wht = ''                         => 0.0022103904,
    NULL < (real)c_rich_wht AND (real)c_rich_wht <= 169.5 => -0.0019669048,
    (real)c_rich_wht > 169.5                        => fp3_lexid_cen_mod_39_c455,
                                                 0.0022103904);

fp3_lexid_cen_mod_39_c453 := map(
    c_low_ed = ''                       => 0.0000287072,
    NULL < (real)c_low_ed AND (real)c_low_ed <= 11.15 => -0.0363993328,
    (real)c_low_ed > 11.15                      => fp3_lexid_cen_mod_39_c454,
                                             0.0000287072);

fp3_lexid_cen_mod_39 := map(
    c_highinc = ''                       => -0.0039544098,
    NULL < (real)c_highinc AND (real)c_highinc <= 80.4 => fp3_lexid_cen_mod_39_c453,
    (real)c_highinc > 80.4                       => 0.2727297466,
                                              0.0001914192);

fp3_lexid_cen_mod_40_c460 := map(
    c_robbery = ''                       => 0.0342196121,
    NULL < (real)c_robbery AND (real)c_robbery <= 77.5 => 0.1032924941,
    (real)c_robbery > 77.5                       => 0.0183761622,
                                              0.0342196121);

fp3_lexid_cen_mod_40_c459 := map(
    c_murders = ''                       => 0.0128109889,
    NULL < (real)c_murders AND (real)c_murders <= 85.5 => -0.0020118962,
    (real)c_murders > 85.5                       => fp3_lexid_cen_mod_40_c460,
                                              0.0128109889);

fp3_lexid_cen_mod_40_c458 := map(
    c_housingcpi = ''                           => -0.0038162862,
    NULL < (real)c_housingcpi AND (real)c_housingcpi <= 236.4 => -0.0082468199,
    (real)c_housingcpi > 236.4                          => fp3_lexid_cen_mod_40_c459,
                                                     -0.0038162862);

fp3_lexid_cen_mod_40_c461 := map(
    c_urban_p = ''                       => 0.0174568685,
    NULL < (real)c_urban_p AND (real)c_urban_p <= 3.35 => -0.0180438576,
    (real)c_urban_p > 3.35                       => 0.0272378945,
                                              0.0174568685);

fp3_lexid_cen_mod_40 := map(
    c_vacant_p = ''                         => -0.0002166624,
    NULL < (real)c_vacant_p AND (real)c_vacant_p <= 11.75 => fp3_lexid_cen_mod_40_c458,
    (real)c_vacant_p > 11.75                        => fp3_lexid_cen_mod_40_c461,
                                                 0.0004214916);

fp3_lexid_cen_mod_41_c465 := map(
    c_rape = ''                   => 0.0808926328,
    NULL < (real)c_rape AND (real)c_rape <= 109 => 0.0215177619,
    (real)c_rape > 109                    => 0.2869583611,
                                       0.0808926328);

fp3_lexid_cen_mod_41_c464 := map(
    c_fammar_p = ''                         => 0.1185342597,
    NULL < (real)c_fammar_p AND (real)c_fammar_p <= 74.75 => 0.3569312299,
    (real)c_fammar_p > 74.75                        => fp3_lexid_cen_mod_41_c465,
                                                 0.1185342597);

fp3_lexid_cen_mod_41_c463 := map(
    C_INC_150K_P = ''                           => 0.0090238138,
    NULL < (real)c_INC_150K_P AND (real)c_INC_150K_P <= 15.05 => 0.0071496561,
    (real)c_INC_150K_P > 15.05                          => fp3_lexid_cen_mod_41_c464,
                                                     0.0090238138);

fp3_lexid_cen_mod_41_c466 := map(
    C_INC_50K_P = ''                          => -0.0066655782,
    NULL < (real)c_INC_50K_P AND (real)c_INC_50K_P <= 25.75 => -0.0076496456,
    (real)c_INC_50K_P > 25.75                         => 0.0858033925,
                                                   -0.0066655782);

fp3_lexid_cen_mod_41 := map(
    c_hval_400k_p = ''                           => -0.0285155894,
    NULL < (real)c_hval_400k_p AND (real)c_hval_400k_p <= 7.05 => fp3_lexid_cen_mod_41_c463,
    (real)c_hval_400k_p > 7.05                           => fp3_lexid_cen_mod_41_c466,
                                                      0.0003155151);

fp3_lexid_cen_mod_42_c468 := map(
    c_rich_old = ''                         => 0.0107667145,
    NULL < (real)c_rich_old AND (real)c_rich_old <= 174.5 => 0.0064197994,
    (real)c_rich_old > 174.5                        => 0.0437001224,
                                                 0.0107667145);

fp3_lexid_cen_mod_42_c471 := map(
    c_civ_emp = ''                        => 0.0181789735,
    NULL < (real)c_civ_emp AND (real)c_civ_emp <= 70.45 => -0.0145925786,
    (real)c_civ_emp > 70.45                       => 0.1524162929,
                                               0.0181789735);

fp3_lexid_cen_mod_42_c470 := map(
    c_hval_1001k_p = ''                            => 0.0415641502,
    NULL < (real)c_hval_1001k_p AND (real)c_hval_1001k_p <= 2.25 => fp3_lexid_cen_mod_42_c471,
    (real)c_hval_1001k_p > 2.25                            => 0.1264555449,
                                                        0.0415641502);

fp3_lexid_cen_mod_42_c469 := map(
    c_hh5_p = ''                      => -0.0055616044,
    NULL < (real)c_hh5_p AND (real)c_hh5_p <= 14.35 => -0.0087925385,
    (real)c_hh5_p > 14.35                     => fp3_lexid_cen_mod_42_c470,
                                           -0.0055616044);

fp3_lexid_cen_mod_42 := map(
    c_rest_indx = ''                          => 0.0256759470,
    NULL < (real)c_rest_indx AND (real)c_rest_indx <= 105.5 => fp3_lexid_cen_mod_42_c468,
    (real)c_rest_indx > 105.5                         => fp3_lexid_cen_mod_42_c469,
                                                   0.0032859136);

fp3_lexid_cen_mod_43_c476 := map(
    c_rnt250_p = ''                       => 0.0909815931,
    NULL < (real)c_rnt250_p AND (real)c_rnt250_p <= 3.4 => 0.0038760219,
    (real)c_rnt250_p > 3.4                        => 0.2164136155,
                                               0.0909815931);

fp3_lexid_cen_mod_43_c475 := map(
    c_transport = ''                          => -0.0095701054,
    NULL < (real)c_transport AND (real)c_transport <= 32.35 => -0.0113656714,
    (real)c_transport > 32.35                         => fp3_lexid_cen_mod_43_c476,
                                                   -0.0095701054);

fp3_lexid_cen_mod_43_c474 := map(
    c_incollege = ''                         => 0.0015772251,
    NULL < (real)c_incollege AND (real)c_incollege <= 4.45 => fp3_lexid_cen_mod_43_c475,
    (real)c_incollege > 4.45                         => 0.0073116929,
                                                  0.0015772251);

fp3_lexid_cen_mod_43_c473 := map(
    c_civ_emp = ''                        => -0.0003390169,
    NULL < (real)c_civ_emp AND (real)c_civ_emp <= 75.55 => fp3_lexid_cen_mod_43_c474,
    (real)c_civ_emp > 75.55                       => -0.0458486517,
                                               -0.0003390169);

fp3_lexid_cen_mod_43 := map(
    c_mining = ''                      => -0.0096227680,
    NULL < (real)c_mining AND (real)c_mining <= 5.85 => fp3_lexid_cen_mod_43_c473,
    (real)c_mining > 5.85                      => -0.0723767509,
                                            -0.0015908510);

// Final Score Sum 

   census_mod := sum(
      fp3_lexid_cen_mod_0, fp3_lexid_cen_mod_1, fp3_lexid_cen_mod_2, fp3_lexid_cen_mod_3, fp3_lexid_cen_mod_4, 
      fp3_lexid_cen_mod_5, fp3_lexid_cen_mod_6, fp3_lexid_cen_mod_7, fp3_lexid_cen_mod_8, fp3_lexid_cen_mod_9, 
      fp3_lexid_cen_mod_10, fp3_lexid_cen_mod_11, fp3_lexid_cen_mod_12, fp3_lexid_cen_mod_13, fp3_lexid_cen_mod_14, 
      fp3_lexid_cen_mod_15, fp3_lexid_cen_mod_16, fp3_lexid_cen_mod_17, fp3_lexid_cen_mod_18, fp3_lexid_cen_mod_19, 
      fp3_lexid_cen_mod_20, fp3_lexid_cen_mod_21, fp3_lexid_cen_mod_22, fp3_lexid_cen_mod_23, fp3_lexid_cen_mod_24, 
      fp3_lexid_cen_mod_25, fp3_lexid_cen_mod_26, fp3_lexid_cen_mod_27, fp3_lexid_cen_mod_28, fp3_lexid_cen_mod_29, 
      fp3_lexid_cen_mod_30, fp3_lexid_cen_mod_31, fp3_lexid_cen_mod_32, fp3_lexid_cen_mod_33, fp3_lexid_cen_mod_34, 
      fp3_lexid_cen_mod_35, fp3_lexid_cen_mod_36, fp3_lexid_cen_mod_37, fp3_lexid_cen_mod_38, fp3_lexid_cen_mod_39, 
      fp3_lexid_cen_mod_40, fp3_lexid_cen_mod_41, fp3_lexid_cen_mod_42, fp3_lexid_cen_mod_43); 
	
    fp3_lexid_model_0 :=  -1.1094957627;
   
   // Tree: 1 
   fp3_lexid_model_1 := map(
   (NULL < census_mod and census_mod <= -0.921902502951339) => 
      map(
      (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 3.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 72.5) => -0.0511142181,
         (rv_comb_age > 72.5) => 0.1024937308,
         (rv_comb_age = NULL) => -0.0434706312, -0.0434706312),
      (nf_fp_srchvelocityrisktype > 3.5) => 
         map(
         (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 2.5) => 0.0167796528,
         (nf_fp_varrisktype > 2.5) => 0.1472458170,
         (nf_fp_varrisktype = NULL) => 0.0603454136, 0.0603454136),
      (nf_fp_srchvelocityrisktype = NULL) => -0.0292203802, -0.0292203802),
   (census_mod > -0.921902502951339) => 
      map(
      (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 3.5) => 0.0523735487,
      (nf_fp_srchvelocityrisktype > 3.5) => 0.1874255594,
      (nf_fp_srchvelocityrisktype = NULL) => 0.0788019535, 0.0788019535),
   (census_mod = NULL) => -0.0015601752, -0.0015601752);
   
   // Tree: 2 
   fp3_lexid_model_2 := map(
   (NULL < census_mod and census_mod <= -1.05580411748561) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 3.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 73.5) => -0.0504699181,
         (rv_comb_age > 73.5) => 0.0963363159,
         (rv_comb_age = NULL) => -0.0439532419, -0.0439532419),
      (nf_fp_varrisktype > 3.5) => 0.1024300265,
      (nf_fp_varrisktype = NULL) => -0.0355174519, -0.0355174519),
   (census_mod > -1.05580411748561) => 
      map(
      (NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.256474457061053) => 0.0390708817,
         (census_mod > -0.256474457061053) => 0.1888850156,
         (census_mod = NULL) => 0.0482832428, 0.0482832428),
      (nf_fp_srchunvrfdaddrcount > 0.5) => 0.2414118268,
      (nf_fp_srchunvrfdaddrcount = NULL) => 0.0575063261, 0.0575063261),
   (census_mod = NULL) => -0.0004568438, -0.0004568438);
   
   // Tree: 3 
   fp3_lexid_model_3 := map(
   (NULL < census_mod and census_mod <= -1.16914448854515) => 
      map(
      (NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 1.5) => -0.0476292264,
      (nf_fp_srchunvrfdphonecount > 1.5) => 0.1409843104,
      (nf_fp_srchunvrfdphonecount = NULL) => -0.0420139377, -0.0420139377),
   (census_mod > -1.16914448854515) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 2.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 66.5) => 
            map(
            (NULL < census_mod and census_mod <= -0.608645531102212) => -0.0062046710,
            (census_mod > -0.608645531102212) => 0.0647391963,
            (census_mod = NULL) => 0.0061592812, 0.0061592812),
         (rv_comb_age > 66.5) => 0.1249506943,
         (rv_comb_age = NULL) => 0.0211491381, 0.0211491381),
      (nf_fp_varrisktype > 2.5) => 0.1281344803,
      (nf_fp_varrisktype = NULL) => 0.0364468759, 0.0364468759),
   (census_mod = NULL) => -0.0035996482, -0.0035996482);
   
   // Tree: 4 
   fp3_lexid_model_4 := map(
   (NULL < census_mod and census_mod <= -1.23434339956445) => 
      map(
      (NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 1.5) => -0.0507283080,
      (rv_I62_inq_addrs_per_adl > 1.5) => 0.0721586250,
      (rv_I62_inq_addrs_per_adl = NULL) => -0.0438310768, -0.0438310768),
   (census_mod > -1.23434339956445) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 2.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 68.5) => 0.0033585539,
         (rv_comb_age > 68.5) => 0.1145664239,
         (rv_comb_age = NULL) => 0.0143806667, 0.0143806667),
      (nf_fp_varrisktype > 2.5) => 
         map(
         (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 2.5) => 0.0521286069,
         (nf_fp_srchfraudsrchcount > 2.5) => 0.1875932704,
         (nf_fp_srchfraudsrchcount = NULL) => 0.1137172445, 0.1137172445),
      (nf_fp_varrisktype = NULL) => 0.0287068237, 0.0287068237),
   (census_mod = NULL) => -0.0032056535, -0.0032056535);
   
   // Tree: 5 
   fp3_lexid_model_5 := map(
   (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 4.5) => 
      map(
      (NULL < census_mod and census_mod <= -1.11389869596819) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 55.5) => -0.0602701213,
         (rv_comb_age > 55.5) => 0.0079976362,
         (rv_comb_age = NULL) => -0.0437852420, -0.0437852420),
      (census_mod > -1.11389869596819) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 77.5) => 0.0160710094,
         (rv_comb_age > 77.5) => 0.1445660751,
         (rv_comb_age = NULL) => 0.0212770156, 0.0212770156),
      (census_mod = NULL) => -0.0162950540, -0.0162950540),
   (nf_fp_srchfraudsrchcount > 4.5) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 3.5) => 0.0733577150,
      (nf_fp_varrisktype > 3.5) => 0.1879606003,
      (nf_fp_varrisktype = NULL) => 0.1050846190, 0.1050846190),
   (nf_fp_srchfraudsrchcount = NULL) => -0.0058653607, -0.0058653607);
   
   // Tree: 6 
   fp3_lexid_model_6 := map(
   (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 2.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 56.5) => 
         map(
         (NULL < nf_inq_HighRiskCredit_count and nf_inq_HighRiskCredit_count <= 2.5) => 
            map(
            (NULL < census_mod and census_mod <= -1.17321004198899) => -0.0622329994,
            (census_mod > -1.17321004198899) => -0.0080697736,
            (census_mod = NULL) => -0.0366295478, -0.0366295478),
         (nf_inq_HighRiskCredit_count > 2.5) => 0.1108060138,
         (nf_inq_HighRiskCredit_count = NULL) => -0.0323850361, -0.0323850361),
      (rv_comb_age > 56.5) => 0.0329296143,
      (rv_comb_age = NULL) => -0.0160936923, -0.0160936923),
   (nf_fp_varrisktype > 2.5) => 
      map(
      (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 2) => 0.0542901511,
      (rv_I60_inq_PrepaidCards_recency > 2) => 0.1918131437,
      (rv_I60_inq_PrepaidCards_recency = NULL) => 0.0680810263, 0.0680810263),
   (nf_fp_varrisktype = NULL) => -0.0052368590, -0.0052368590);
   
   // Tree: 7 
   fp3_lexid_model_7 := map(
   (NULL < census_mod and census_mod <= -0.662229374086763) => 
      map(
      (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 4.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 313.5) => -0.0379583166,
         (nf_M_Bureau_ADL_FS_noTU > 313.5) => 0.0163520002,
         (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0229823607, -0.0229823607),
      (nf_fp_srchvelocityrisktype > 4.5) => 
         map(
         (NULL < nf_inq_Other_count and nf_inq_Other_count <= 2.5) => 0.0309251892,
         (nf_inq_Other_count > 2.5) => 0.1520804681,
         (nf_inq_Other_count = NULL) => 0.0540147391, 0.0540147391),
      (nf_fp_srchvelocityrisktype = NULL) => -0.0120396810, -0.0120396810),
   (census_mod > -0.662229374086763) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 0.0460038146,
      (nf_fp_varrisktype > 1.5) => 0.1330630089,
      (nf_fp_varrisktype = NULL) => 0.0737639250, 0.0737639250),
   (census_mod = NULL) => -0.0027422208, -0.0027422208);
   
   // Tree: 8 
   fp3_lexid_model_8 := map(
   (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 3.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 73.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.6905427857784) => -0.0264746697,
         (census_mod > -0.6905427857784) => 0.0444514579,
         (census_mod = NULL) => -0.0188825325, -0.0188825325),
      (rv_comb_age > 73.5) => 0.0812695891,
      (rv_comb_age = NULL) => -0.0142412062, -0.0142412062),
   (nf_fp_srchvelocityrisktype > 3.5) => 
      map(
      (NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 62.5) => 0.0205497488,
         (rv_comb_age > 62.5) => 0.1444252132,
         (rv_comb_age = NULL) => 0.0330732087, 0.0330732087),
      (rv_I60_inq_comm_recency > 0.5) => 0.1220975367,
      (rv_I60_inq_comm_recency = NULL) => 0.0547220667, 0.0547220667),
   (nf_fp_srchvelocityrisktype = NULL) => -0.0037245566, -0.0037245566);
   
   // Tree: 9 
   fp3_lexid_model_9 := map(
   (NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 1.5) => 
      map(
      (NULL < census_mod and census_mod <= -1.11538515013482) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 71.5) => -0.0400094579,
         (rv_comb_age > 71.5) => 0.0631083506,
         (rv_comb_age = NULL) => -0.0348941373, -0.0348941373),
      (census_mod > -1.11538515013482) => 0.0189286902,
      (census_mod = NULL) => -0.0118957216, -0.0118957216),
   (rv_I62_inq_addrs_per_adl > 1.5) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 5.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 94.5) => -0.0420050985,
         (nf_M_Bureau_ADL_FS_all > 94.5) => 0.0857442764,
         (nf_M_Bureau_ADL_FS_all = NULL) => 0.0567356847, 0.0567356847),
      (nf_fp_varrisktype > 5.5) => 0.1573814135,
      (nf_fp_varrisktype = NULL) => 0.0753605171, 0.0753605171),
   (rv_I62_inq_addrs_per_adl = NULL) => -0.0052425913, -0.0052425913);
   
   // Tree: 10 
   fp3_lexid_model_10 := map(
   (NULL < census_mod and census_mod <= -0.643955836952656) => 
      map(
      (NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => 
         map(
         (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 7.5) => 
            map(
            (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 6.5) => 
               map(
               (NULL < rv_comb_age and rv_comb_age <= 40.5) => -0.0467269698,
               (rv_comb_age > 40.5) => -0.0032489227,
               (rv_comb_age = NULL) => -0.0236776814, -0.0236776814),
            (nf_fp_srchfraudsrchcount > 6.5) => 0.0660506071,
            (nf_fp_srchfraudsrchcount = NULL) => -0.0202544451, -0.0202544451),
         (nf_fp_idrisktype > 7.5) => 0.3520994073,
         (nf_fp_idrisktype = NULL) => -0.0191648947, -0.0191648947),
      (nf_fp_srchunvrfdaddrcount > 0.5) => 0.0934824691,
      (nf_fp_srchunvrfdaddrcount = NULL) => -0.0153876071, -0.0153876071),
   (census_mod > -0.643955836952656) => 0.0629571655,
   (census_mod = NULL) => -0.0072030727, -0.0072030727);
   
   // Tree: 11 
   fp3_lexid_model_11 := map(
   (NULL < census_mod and census_mod <= -0.872004723307457) => 
      map(
      (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => 
         map(
         (NULL < iv_rv5_deceased and iv_rv5_deceased <= 0.5) => 
            map(
            (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 346.5) => 
               map(
               (NULL < nf_inq_HighRiskCredit_count and nf_inq_HighRiskCredit_count <= 2.5) => -0.0315150997,
               (nf_inq_HighRiskCredit_count > 2.5) => 0.0653257402,
               (nf_inq_HighRiskCredit_count = NULL) => -0.0286970496, -0.0286970496),
            (nf_M_Bureau_ADL_FS > 346.5) => 0.0338096168,
            (nf_M_Bureau_ADL_FS = NULL) => -0.0213336204, -0.0213336204),
         (iv_rv5_deceased > 0.5) => 0.2913310708,
         (iv_rv5_deceased = NULL) => -0.0202869189, -0.0202869189),
      (rv_I60_inq_PrepaidCards_recency > 0.5) => 0.1195794045,
      (rv_I60_inq_PrepaidCards_recency = NULL) => -0.0165595375, -0.0165595375),
   (census_mod > -0.872004723307457) => 0.0439931739,
   (census_mod = NULL) => -0.0030699094, -0.0030699094);
   
   // Tree: 12 
   fp3_lexid_model_12 := map(
   (NULL < nf_inq_Communications_count and nf_inq_Communications_count <= 1.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 54.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.331519282181404) => -0.0211394016,
         (census_mod > -0.331519282181404) => 0.0805106116,
         (census_mod = NULL) => -0.0184002509, -0.0184002509),
      (rv_comb_age > 54.5) => 
         map(
         (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 
            map(
            (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 2.5) => 0.0110137984,
            (nf_fp_idrisktype > 2.5) => 0.1985369039,
            (nf_fp_idrisktype = NULL) => 0.0142903094, 0.0142903094),
         (nf_fp_varrisktype > 1.5) => 0.1151846112,
         (nf_fp_varrisktype = NULL) => 0.0271970574, 0.0271970574),
      (rv_comb_age = NULL) => -0.0062357960, -0.0062357960),
   (nf_inq_Communications_count > 1.5) => 0.0977429314,
   (nf_inq_Communications_count = NULL) => -0.0017873573, -0.0017873573);
   
   // Tree: 13 
   fp3_lexid_model_13 := map(
   (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 4.5) => 
      map(
      (NULL < census_mod and census_mod <= -0.65368155716209) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 68.5) => 
            map(
            (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 1.5) => -0.0296215751,
            (rv_I60_inq_PrepaidCards_recency > 1.5) => 0.0764176668,
            (rv_I60_inq_PrepaidCards_recency = NULL) => -0.0274661396, -0.0274661396),
         (rv_comb_age > 68.5) => 0.0435639472,
         (rv_comb_age = NULL) => -0.0213070274, -0.0213070274),
      (census_mod > -0.65368155716209) => 0.0469773266,
      (census_mod = NULL) => -0.0145819983, -0.0145819983),
   (nf_fp_srchvelocityrisktype > 4.5) => 
      map(
      (NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 1.5) => 0.0332546980,
      (nf_fp_srchunvrfdphonecount > 1.5) => 0.1062213225,
      (nf_fp_srchunvrfdphonecount = NULL) => 0.0469161491, 0.0469161491),
   (nf_fp_srchvelocityrisktype = NULL) => -0.0056098102, -0.0056098102);
   
   // Tree: 14 
   fp3_lexid_model_14 := map(
   (NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 77.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.849215347517654) => -0.0218759731,
         (census_mod > -0.849215347517654) => 
            map(
            (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 2) => 0.1350994767,
            (rv_C13_attr_addrs_recency > 2) => 0.0145300825,
            (rv_C13_attr_addrs_recency = NULL) => 0.0205244930, 0.0205244930),
         (census_mod = NULL) => -0.0140330611, -0.0140330611),
      (rv_comb_age > 77.5) => 
         map(
         (NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 2.5) => 0.0548112273,
         (nf_hh_tot_derog > 2.5) => 0.2338157694,
         (nf_hh_tot_derog = NULL) => 0.0827450571, 0.0827450571),
      (rv_comb_age = NULL) => -0.0109582529, -0.0109582529),
   (rv_I60_inq_comm_recency > 0.5) => 0.0544325512,
   (rv_I60_inq_comm_recency = NULL) => -0.0040323637, -0.0040323637);
   
   // Tree: 15 
   fp3_lexid_model_15 := map(
   (NULL < census_mod and census_mod <= -1.05580411748561) => 
      map(
      (NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => -0.0245945583,
      (nf_fp_srchunvrfdaddrcount > 0.5) => 0.0739765856,
      (nf_fp_srchunvrfdaddrcount = NULL) => -0.0216418673, -0.0216418673),
   (census_mod > -1.05580411748561) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 33.5) => -0.0243791667,
         (rv_comb_age > 33.5) => 0.0237800310,
         (rv_comb_age = NULL) => 0.0090752957, 0.0090752957),
      (nf_fp_varrisktype > 1.5) => 
         map(
         (NULL < rv_C12_source_profile and rv_C12_source_profile <= 59.2) => 0.0315161999,
         (rv_C12_source_profile > 59.2) => 0.0907810483,
         (rv_C12_source_profile = NULL) => 0.0547969671, 0.0547969671),
      (nf_fp_varrisktype = NULL) => 0.0215806488, 0.0215806488),
   (census_mod = NULL) => -0.0053044130, -0.0053044130);
   
   // Tree: 16 
   fp3_lexid_model_16 := map(
   (NULL < census_mod and census_mod <= -1.26078453462493) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 63.5) => -0.0357646020,
      (rv_comb_age > 63.5) => 0.0264597727,
      (rv_comb_age = NULL) => -0.0281405420, -0.0281405420),
   (census_mod > -1.26078453462493) => 
      map(
      (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 3.5) => 
         map(
         (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 4.5) => 
            map(
            (NULL < rv_C12_source_profile and rv_C12_source_profile <= 56.85) => -0.0181655100,
            (rv_C12_source_profile > 56.85) => 0.0217504079,
            (rv_C12_source_profile = NULL) => 0.0072801315, 0.0072801315),
         (nf_fp_idrisktype > 4.5) => 0.1863151821,
         (nf_fp_idrisktype = NULL) => 0.0089229289, 0.0089229289),
      (nf_fp_varrisktype > 3.5) => 0.0662538729,
      (nf_fp_varrisktype = NULL) => 0.0134509107, 0.0134509107),
   (census_mod = NULL) => -0.0036581637, -0.0036581637);
   
   // Tree: 17 
   fp3_lexid_model_17 := map(
   (NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => 
      map(
      (NULL < census_mod and census_mod <= -0.3753011375824) => 
         map(
         (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 35.5) => -0.0395191977,
            (rv_comb_age > 35.5) => 
               map(
               (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 5.5) => -0.0015385110,
               (nf_fp_idrisktype > 5.5) => 0.2270714024,
               (nf_fp_idrisktype = NULL) => -0.0002836014, -0.0002836014),
            (rv_comb_age = NULL) => -0.0137218542, -0.0137218542),
         (nf_fp_vardobcountnew > 0.5) => 0.0290652188,
         (nf_fp_vardobcountnew = NULL) => -0.0043874004, -0.0043874004),
      (census_mod > -0.3753011375824) => 0.0687071244,
      (census_mod = NULL) => -0.0017700299, -0.0017700299),
   (nf_fp_srchunvrfdaddrcount > 0.5) => 0.0797453899,
   (nf_fp_srchunvrfdaddrcount = NULL) => 0.0010906777, 0.0010906777);
   
   // Tree: 18 
   fp3_lexid_model_18 := map(
   (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 84.5) => 
         map(
         (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 4.5) => 
            map(
            (NULL < census_mod and census_mod <= -1.48257260878046) => -0.0480565785,
            (census_mod > -1.48257260878046) => 
               map(
               (NULL < rv_comb_age and rv_comb_age <= 33.5) => -0.0302227588,
               (rv_comb_age > 33.5) => 0.0082356150,
               (rv_comb_age = NULL) => -0.0049029995, -0.0049029995),
            (census_mod = NULL) => -0.0138610090, -0.0138610090),
         (nf_fp_srchvelocityrisktype > 4.5) => 0.0294405236,
         (nf_fp_srchvelocityrisktype = NULL) => -0.0079832884, -0.0079832884),
      (rv_comb_age > 84.5) => 0.1148453554,
      (rv_comb_age = NULL) => -0.0066597039, -0.0066597039),
   (rv_I60_inq_PrepaidCards_recency > 0.5) => 0.0867231387,
   (rv_I60_inq_PrepaidCards_recency = NULL) => -0.0034331983, -0.0034331983);
   
   // Tree: 19 
   fp3_lexid_model_19 := map(
   (NULL < nf_inq_Communications_count and nf_inq_Communications_count <= 1.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 43.5) => 
         map(
         (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 
            map(
            (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 2.5) => 0.1114193834,
            (nf_M_Bureau_ADL_FS_noTU > 2.5) => -0.0292887364,
            (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0259813812, -0.0259813812),
         (rv_D33_Eviction_Recency > 1.5) => 0.0757000054,
         (rv_D33_Eviction_Recency = NULL) => -0.0210337359, -0.0210337359),
      (rv_comb_age > 43.5) => 
         map(
         (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 5.5) => 0.0090932198,
         (nf_fp_idrisktype > 5.5) => 0.1851935617,
         (nf_fp_idrisktype = NULL) => 0.0104358789, 0.0104358789),
      (rv_comb_age = NULL) => -0.0062006964, -0.0062006964),
   (nf_inq_Communications_count > 1.5) => 0.0721753713,
   (nf_inq_Communications_count = NULL) => -0.0028263288, -0.0028263288);
   
   // Tree: 20 
   fp3_lexid_model_20 := map(
   (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 344.5) => 
         map(
         (NULL < nf_pb_retail_combo_max and nf_pb_retail_combo_max <= 3.5) => -0.0088461932,
         (nf_pb_retail_combo_max > 3.5) => -0.0451653772,
         (nf_pb_retail_combo_max = NULL) => -0.0200652869, -0.0200652869),
      (nf_M_Bureau_ADL_FS > 344.5) => 0.0256388944,
      (nf_M_Bureau_ADL_FS = NULL) => -0.0135801975, -0.0135801975),
   (nf_fp_varrisktype > 1.5) => 
      map(
      (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 152.5) => 
         map(
         (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 0.5) => 0.0090558556,
         (rv_I60_inq_PrepaidCards_recency > 0.5) => 0.1114325683,
         (rv_I60_inq_PrepaidCards_recency = NULL) => 0.0171276069, 0.0171276069),
      (rv_C13_Curr_Addr_LRes > 152.5) => 0.1017670803,
      (rv_C13_Curr_Addr_LRes = NULL) => 0.0278168631, 0.0278168631),
   (nf_fp_varrisktype = NULL) => -0.0037963228, -0.0037963228);
   
   // Tree: 21 
   fp3_lexid_model_21 := map(
   (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 344.5) => 
      map(
      (NULL < nf_inq_Communications_count and nf_inq_Communications_count <= 1.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.755267272539471) => -0.0178346118,
         (census_mod > -0.755267272539471) => 
            map(
            (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 4.5) => 0.1847212557,
            (nf_M_Bureau_ADL_FS_all > 4.5) => 0.0176048879,
            (nf_M_Bureau_ADL_FS_all = NULL) => 0.0211768408, 0.0211768408),
         (census_mod = NULL) => -0.0122797202, -0.0122797202),
      (nf_inq_Communications_count > 1.5) => 0.0605079408,
      (nf_inq_Communications_count = NULL) => -0.0090368178, -0.0090368178),
   (nf_M_Bureau_ADL_FS_noTU > 344.5) => 
      map(
      (NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 0.5) => 0.0337651800,
      (nf_fp_srchfraudsrchcountmo > 0.5) => 0.1636094470,
      (nf_fp_srchfraudsrchcountmo = NULL) => 0.0401345554, 0.0401345554),
   (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0026902594, -0.0026902594);
   
   // Tree: 22 
   fp3_lexid_model_22 := map(
   (NULL < rv_comb_age and rv_comb_age <= 77.5) => 
      map(
      (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 
         map(
         (NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => 
            map(
            (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 6.5) => 
               map(
               (NULL < census_mod and census_mod <= -0.360273950532598) => -0.0150213919,
               (census_mod > -0.360273950532598) => 0.0420171393,
               (census_mod = NULL) => -0.0132613794, -0.0132613794),
            (nf_fp_srchvelocityrisktype > 6.5) => 0.0455338712,
            (nf_fp_srchvelocityrisktype = NULL) => -0.0109417413, -0.0109417413),
         (rv_D32_felony_count > 0.5) => 0.1121698286,
         (rv_D32_felony_count = NULL) => -0.0093159894, -0.0093159894),
      (rv_D33_Eviction_Recency > 1.5) => 0.0626772595,
      (rv_D33_Eviction_Recency = NULL) => -0.0060295164, -0.0060295164),
   (rv_comb_age > 77.5) => 0.0677367785,
   (rv_comb_age = NULL) => -0.0037666647, -0.0037666647);
   
   // Tree: 23 
   fp3_lexid_model_23 := map(
   (NULL < nf_rel_felony_count and nf_rel_felony_count <= 0.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 82.5) => 
         map(
         (NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 5.5) => 
            map(
            (NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => -0.0150026325,
            (nf_fp_srchunvrfdaddrcount > 0.5) => 
               map(
               (NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 91838) => -0.0772035990,
               (nf_fp_prevaddrmedianvalue > 91838) => 0.0838275238,
               (nf_fp_prevaddrmedianvalue = NULL) => 0.0510461881, 0.0510461881),
            (nf_fp_srchunvrfdaddrcount = NULL) => -0.0129363007, -0.0129363007),
         (nf_hh_tot_derog > 5.5) => 0.0856829351,
         (nf_hh_tot_derog = NULL) => -0.0107490720, -0.0107490720),
      (rv_comb_age > 82.5) => 0.0918220711,
      (rv_comb_age = NULL) => -0.0091169325, -0.0091169325),
   (nf_rel_felony_count > 0.5) => 0.0338896201,
   (nf_rel_felony_count = NULL) => -0.0023135262, -0.0023135262);
   
   // Tree: 24 
   fp3_lexid_model_24 := map(
   (NULL < rv_comb_age and rv_comb_age <= 62.5) => 
      map(
      (NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => 
         map(
         (NULL < rv_D33_eviction_count and rv_D33_eviction_count <= 2.5) => 
            map(
            (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 6.5) => 
               map(
               (NULL < census_mod and census_mod <= -1.25266269877989) => -0.0302196646,
               (census_mod > -1.25266269877989) => 0.0010125432,
               (census_mod = NULL) => -0.0125413153, -0.0125413153),
            (nf_fp_varrisktype > 6.5) => 0.0944298621,
            (nf_fp_varrisktype = NULL) => -0.0112984099, -0.0112984099),
         (rv_D33_eviction_count > 2.5) => 0.1065804159,
         (rv_D33_eviction_count = NULL) => -0.0098819923, -0.0098819923),
      (rv_D32_felony_count > 0.5) => 0.1094292241,
      (rv_D32_felony_count = NULL) => -0.0080543855, -0.0080543855),
   (rv_comb_age > 62.5) => 0.0295383539,
   (rv_comb_age = NULL) => -0.0026567851, -0.0026567851);
   
   // Tree: 25 
   fp3_lexid_model_25 := map(
   (NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => 
      map(
      (NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 0.5) => 
         map(
         (NULL < nf_hh_payday_loan_users and nf_hh_payday_loan_users <= 1.5) => 
            map(
            (NULL < census_mod and census_mod <= -0.0616425775809996) => 
               map(
               (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 314.5) => -0.0212325999,
               (nf_M_Bureau_ADL_FS > 314.5) => 0.0131348725,
               (nf_M_Bureau_ADL_FS = NULL) => -0.0121976558, -0.0121976558),
            (census_mod > -0.0616425775809996) => 0.1008423857,
            (census_mod = NULL) => -0.0111364411, -0.0111364411),
         (nf_hh_payday_loan_users > 1.5) => 0.1797413966,
         (nf_hh_payday_loan_users = NULL) => -0.0102100745, -0.0102100745),
      (rv_I60_inq_other_recency > 0.5) => 0.0233549208,
      (rv_I60_inq_other_recency = NULL) => -0.0020461159, -0.0020461159),
   (rv_D32_felony_count > 0.5) => 0.0991104735,
   (rv_D32_felony_count = NULL) => -0.0005364526, -0.0005364526);
   
   // Tree: 26 
   fp3_lexid_model_26 := map(
   (NULL < nf_rel_felony_count and nf_rel_felony_count <= 0.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 82.5) => 
         map(
         (NULL < nf_fp_srchunvrfdphonecount and nf_fp_srchunvrfdphonecount <= 1.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 36.5) => -0.0320079793,
            (rv_comb_age > 36.5) => 
               map(
               (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 4.5) => 0.0726644612,
               (nf_fp_prevaddrageoldest > 4.5) => -0.0070720741,
               (nf_fp_prevaddrageoldest = NULL) => -0.0034705770, -0.0034705770),
            (rv_comb_age = NULL) => -0.0150349654, -0.0150349654),
         (nf_fp_srchunvrfdphonecount > 1.5) => 0.0454704646,
         (nf_fp_srchunvrfdphonecount = NULL) => -0.0126658367, -0.0126658367),
      (rv_comb_age > 82.5) => 0.0793747409,
      (rv_comb_age = NULL) => -0.0113852894, -0.0113852894),
   (nf_rel_felony_count > 0.5) => 0.0298967547,
   (nf_rel_felony_count = NULL) => -0.0047426739, -0.0047426739);
   
   // Tree: 27 
   fp3_lexid_model_27 := map(
   (NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => 
      map(
      (NULL < iv_rv5_deceased and iv_rv5_deceased <= 0.5) => 
         map(
         (NULL < rv_I60_inq_comm_recency and rv_I60_inq_comm_recency <= 0.5) => 
            map(
            (rv_D31_ALL_Bk in ['2 - BK DISCHARGED','3 - BK OTHER']) => -0.0478746680,
            (rv_D31_ALL_Bk in ['NA','0 - NO BK','1 - BK DISMISSED']) => 
               map(
               (NULL < rv_comb_age and rv_comb_age <= 43.5) => -0.0160248045,
               (rv_comb_age > 43.5) => 0.0141517297,
               (rv_comb_age = NULL) => -0.0021819556, -0.0021819556),
            (rv_D31_ALL_Bk = '') => -0.0060527157, -0.0060527157),
         (rv_I60_inq_comm_recency > 0.5) => 0.0314508325,
         (rv_I60_inq_comm_recency = NULL) => -0.0023344684, -0.0023344684),
      (iv_rv5_deceased > 0.5) => 0.1741061750,
      (iv_rv5_deceased = NULL) => -0.0017516751, -0.0017516751),
   (nf_fp_srchfraudsrchcountmo > 1.5) => 0.0901040616,
   (nf_fp_srchfraudsrchcountmo = NULL) => -0.0004472838, -0.0004472838);
   
   // Tree: 28 
   fp3_lexid_model_28 := map(
   (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 355.5) => -0.0159276530,
      (nf_M_Bureau_ADL_FS > 355.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 368.5) => 0.0692576781,
         (nf_M_Bureau_ADL_FS_noTU > 368.5) => -0.0067720841,
         (nf_M_Bureau_ADL_FS_noTU = NULL) => 0.0240385466, 0.0240385466),
      (nf_M_Bureau_ADL_FS = NULL) => -0.0119725171, -0.0119725171),
   (nf_fp_varrisktype > 1.5) => 
      map(
      (NULL < rv_C12_source_profile and rv_C12_source_profile <= 74.9) => 
         map(
         (NULL < nf_rel_derog_summary and nf_rel_derog_summary <= 3.5) => -0.0060305780,
         (nf_rel_derog_summary > 3.5) => 0.0491948992,
         (nf_rel_derog_summary = NULL) => 0.0134200657, 0.0134200657),
      (rv_C12_source_profile > 74.9) => 0.0798480957,
      (rv_C12_source_profile = NULL) => 0.0243196222, 0.0243196222),
   (nf_fp_varrisktype = NULL) => -0.0035100411, -0.0035100411);
   
   // Tree: 29 
   fp3_lexid_model_29 := map(
   (NULL < census_mod and census_mod <= -1.28108877766087) => -0.0181643396,
   (census_mod > -1.28108877766087) => 
      map(
      (NULL < nf_rel_criminal_count and nf_rel_criminal_count <= 5.5) => 
         map(
         (NULL < rv_C12_source_profile and rv_C12_source_profile <= 79.55) => 
            map(
            (NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 7.5) => 
               map(
               (NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 0.5) => -0.0065858889,
               (nf_inq_Communications_count24 > 0.5) => 0.0401309915,
               (nf_inq_Communications_count24 = NULL) => -0.0029655886, -0.0029655886),
            (nf_hh_age_18_plus > 7.5) => 0.0820811458,
            (nf_hh_age_18_plus = NULL) => -0.0004471581, -0.0004471581),
         (rv_C12_source_profile > 79.55) => 0.0440781678,
         (rv_C12_source_profile = NULL) => 0.0047410769, 0.0047410769),
      (nf_rel_criminal_count > 5.5) => 0.0452782435,
      (nf_rel_criminal_count = NULL) => 0.0102981547, 0.0102981547),
   (census_mod = NULL) => -0.0008309483, -0.0008309483);
   
   // Tree: 30 
   fp3_lexid_model_30 := map(
   (NULL < nf_inq_count_week and nf_inq_count_week <= 0.5) => 
      map(
      (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 9) => 
         map(
         (NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 4.5) => 
            map(
            (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 0.0163588102,
            (nf_hh_members_ct > 1.5) => 
               map(
               (NULL < rv_C12_source_profile and rv_C12_source_profile <= 78.95) => -0.0209295379,
               (rv_C12_source_profile > 78.95) => 0.0176718949,
               (rv_C12_source_profile = NULL) => -0.0157518898, -0.0157518898),
            (nf_hh_members_ct = NULL) => -0.0094232666, -0.0094232666),
         (nf_hh_age_30_plus > 4.5) => 0.0403204925,
         (nf_hh_age_30_plus = NULL) => -0.0064529252, -0.0064529252),
      (rv_I60_inq_PrepaidCards_recency > 9) => 0.0621699230,
      (rv_I60_inq_PrepaidCards_recency = NULL) => -0.0045805852, -0.0045805852),
   (nf_inq_count_week > 0.5) => 0.0813744588,
   (nf_inq_count_week = NULL) => -0.0026836034, -0.0026836034);
   
   // Tree: 31 
   fp3_lexid_model_31 := map(
   (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 5.5) => 
      map(
      (NULL < census_mod and census_mod <= -0.541487980060057) => 
         map(
         (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => 
            map(
            (rv_D31_MostRec_Bk in ['2 - BK DISCHARGED']) => -0.0536518727,
            (rv_D31_MostRec_Bk in ['NA','0 - NO BK','1 - BK DISMISSED','3 - BK OTHER']) => -0.0096239023,
            (rv_D31_MostRec_Bk = '') => -0.0134889110, -0.0134889110),
         (nf_fp_vardobcountnew > 0.5) => 0.0159049528,
         (nf_fp_vardobcountnew = NULL) => -0.0071079750, -0.0071079750),
      (census_mod > -0.541487980060057) => 
         map(
         (NULL < iv_A46_L77_addrs_move_traj_index and iv_A46_L77_addrs_move_traj_index <= 5.5) => 0.0230584283,
         (iv_A46_L77_addrs_move_traj_index > 5.5) => 0.1279533153,
         (iv_A46_L77_addrs_move_traj_index = NULL) => 0.0314290926, 0.0314290926),
      (census_mod = NULL) => -0.0042949480, -0.0042949480),
   (nf_fp_idrisktype > 5.5) => 0.1465937106,
   (nf_fp_idrisktype = NULL) => -0.0033532586, -0.0033532586);
   
   // Tree: 32 
   fp3_lexid_model_32 := map(
   (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.02899159665) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 35.5) => -0.0212845438,
      (rv_comb_age > 35.5) => 
         map(
         (NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 240500) => -0.0190141343,
         (nf_average_rel_home_val > 240500) => 0.0180232483,
         (nf_average_rel_home_val = NULL) => 0.0026406825, 0.0026406825),
      (rv_comb_age = NULL) => -0.0066519102, -0.0066519102),
   (nf_pct_rel_with_felony > 0.02899159665) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 68.5) => 
         map(
         (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 30) => 0.0530987444,
         (rv_C13_attr_addrs_recency > 30) => -0.0055782820,
         (rv_C13_attr_addrs_recency = NULL) => 0.0180788048, 0.0180788048),
      (rv_comb_age > 68.5) => 0.1128432059,
      (rv_comb_age = NULL) => 0.0254580000, 0.0254580000),
   (nf_pct_rel_with_felony = NULL) => -0.0016913705, -0.0016913705);
   
   // Tree: 33 
   fp3_lexid_model_33 := map(
   (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 2) => 0.0709668565,
   (rv_C13_attr_addrs_recency > 2) => 
      map(
      (NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 30) => 0.1485018503,
      (nf_attr_arrest_recency > 30) => 0.0462719365,
      (nf_attr_arrest_recency = NULL) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 59.5) => 
            map(
            (NULL < nf_inq_HighRiskCredit_count and nf_inq_HighRiskCredit_count <= 3.5) => -0.0129732624,
            (nf_inq_HighRiskCredit_count > 3.5) => 
               map(
               (NULL < rv_A50_pb_total_dollars and rv_A50_pb_total_dollars <= 186.5) => 0.0784475640,
               (rv_A50_pb_total_dollars > 186.5) => -0.0668724561,
               (rv_A50_pb_total_dollars = NULL) => 0.0477982507, 0.0477982507),
            (nf_inq_HighRiskCredit_count = NULL) => -0.0109975956, -0.0109975956),
         (rv_comb_age > 59.5) => 0.0172664617,
         (rv_comb_age = NULL) => -0.0055209630, -0.0055209630), -0.0045885839),
   (rv_C13_attr_addrs_recency = NULL) => -0.0015816742, -0.0015816742);
   
   // Tree: 34 
   fp3_lexid_model_34 := map(
   (NULL < census_mod and census_mod <= -1.5296465645989) => -0.0391995133,
   (census_mod > -1.5296465645989) => 
      map(
      (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 7.5) => 0.0477510043,
      (rv_C13_attr_addrs_recency > 7.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 74.5) => 
            map(
            (NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 30) => 0.1521231606,
            (nf_attr_arrest_recency > 30) => 0.0694075354,
            (nf_attr_arrest_recency = NULL) => 
               map(
               (rv_D31_MostRec_Bk in ['2 - BK DISCHARGED','3 - BK OTHER']) => -0.0401872416,
               (rv_D31_MostRec_Bk in ['NA','0 - NO BK','1 - BK DISMISSED']) => 0.0013343668,
               (rv_D31_MostRec_Bk = '') => -0.0026256397, -0.0026256397), -0.0015744037),
         (rv_comb_age > 74.5) => 0.0395904488,
         (rv_comb_age = NULL) => 0.0003991561, 0.0003991561),
      (rv_C13_attr_addrs_recency = NULL) => 0.0043455603, 0.0043455603),
   (census_mod = NULL) => -0.0019128625, -0.0019128625);
   
   // Tree: 35 
   fp3_lexid_model_35 := map(
   (NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 0.5) => 0.2456104183,
   (nf_hh_age_18_plus > 0.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 340.5) => 
         map(
         (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 5.5) => 
            map(
            (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 
               map(
               (NULL < rv_Ever_Asset_Owner and rv_Ever_Asset_Owner <= 0.5) => 0.0430733660,
               (rv_Ever_Asset_Owner > 0.5) => 0.0032274947,
               (rv_Ever_Asset_Owner = NULL) => 0.0167707735, 0.0167707735),
            (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0556233760,
            (rv_C16_Inv_SSN_Per_ADL = NULL) => 0.0105617862, 0.0105617862),
         (rv_A50_pb_average_dollars > 5.5) => -0.0166337779,
         (rv_A50_pb_average_dollars = NULL) => -0.0054524077, -0.0054524077),
      (nf_M_Bureau_ADL_FS > 340.5) => 0.0227664750,
      (nf_M_Bureau_ADL_FS = NULL) => -0.0011096632, -0.0011096632),
   (nf_hh_age_18_plus = NULL) => -0.0004625139, -0.0004625139);
   
   // Tree: 36 
   fp3_lexid_model_36 := map(
   (NULL < rv_A50_pb_total_orders and rv_A50_pb_total_orders <= 2.5) => 
      map(
      (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 
         map(
         (NULL < rv_F04_curr_add_occ_index and rv_F04_curr_add_occ_index <= 2) => 
            map(
            (NULL < census_mod and census_mod <= -0.247566308490199) => 
               map(
               (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 2.5) => 0.1676614100,
               (rv_C10_M_Hdr_FS > 2.5) => 0.0006244695,
               (rv_C10_M_Hdr_FS = NULL) => 0.0016506132, 0.0016506132),
            (census_mod > -0.247566308490199) => 0.0651868587,
            (census_mod = NULL) => 0.0034980790, 0.0034980790),
         (rv_F04_curr_add_occ_index > 2) => 0.0421960078,
         (rv_F04_curr_add_occ_index = NULL) => 0.0118740583, 0.0118740583),
      (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0613208541,
      (rv_C16_Inv_SSN_Per_ADL = NULL) => 0.0079200364, 0.0079200364),
   (rv_A50_pb_total_orders > 2.5) => -0.0185295215,
   (rv_A50_pb_total_orders = NULL) => -0.0012138648, -0.0012138648);
   
   // Tree: 37 
   fp3_lexid_model_37 := map(
   (NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 18) => 0.1694619325,
   (nf_attr_arrest_recency > 18) => 0.0780888845,
   (nf_attr_arrest_recency = NULL) => 
      map(
      (NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.09307359305) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 88.5) => 
            map(
            (NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 0.5) => 
               map(
               (NULL < nf_util_adl_count and nf_util_adl_count <= 3.5) => -0.0156618813,
               (nf_util_adl_count > 3.5) => 0.0170776042,
               (nf_util_adl_count = NULL) => -0.0104627935, -0.0104627935),
            (rv_I60_inq_other_count12 > 0.5) => 0.0219178335,
            (rv_I60_inq_other_count12 = NULL) => -0.0063327115, -0.0063327115),
         (rv_comb_age > 88.5) => 0.1340451726,
         (rv_comb_age = NULL) => -0.0058386717, -0.0058386717),
      (nf_hh_payday_loan_users_pct > 0.09307359305) => 0.0338421289,
      (nf_hh_payday_loan_users_pct = NULL) => -0.0023135891, -0.0023135891), -0.0012015810);
   
   // Tree: 38 
   fp3_lexid_model_38 := map(
   (NULL < nf_fp_assocrisktype and nf_fp_assocrisktype <= 2.5) => 
      map(
      (NULL < rv_D31_bk_chapter and rv_D31_bk_chapter <= 3.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 33.5) => 
            map(
            (NULL < nf_hh_tot_derog_avg and nf_hh_tot_derog_avg <= 0.64583333335) => -0.0346571766,
            (nf_hh_tot_derog_avg > 0.64583333335) => 0.0351782134,
            (nf_hh_tot_derog_avg = NULL) => -0.0220377991, -0.0220377991),
         (rv_comb_age > 33.5) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 115.45) => -0.0038311413,
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 115.45) => 0.0372574398,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0004838453, 0.0041961461),
         (rv_comb_age = NULL) => -0.0054936859, -0.0054936859),
      (rv_D31_bk_chapter > 3.5) => -0.0474695356,
      (rv_D31_bk_chapter = NULL) => -0.0090012228, -0.0090012228),
   (nf_fp_assocrisktype > 2.5) => 0.0230980734,
   (nf_fp_assocrisktype = NULL) => -0.0013625426, -0.0013625426);
   
   // Tree: 39 
   fp3_lexid_model_39 := map(
   (NULL < nf_util_adl_count and nf_util_adl_count <= 3.5) => 
      map(
      (NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 0.5) => 
         map(
         (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 2) => -0.0164859954,
         (nf_fp_idrisktype > 2) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 36.5) => 0.0075088725,
            (rv_comb_age > 36.5) => 0.0996709265,
            (rv_comb_age = NULL) => 0.0298089536, 0.0298089536),
         (nf_fp_idrisktype = NULL) => -0.0132930337, -0.0132930337),
      (nf_inq_Other_count24 > 0.5) => 
         map(
         (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 8.5) => 0.0143265490,
         (nf_fp_srchvelocityrisktype > 8.5) => 0.1320493845,
         (nf_fp_srchvelocityrisktype = NULL) => 0.0181835650, 0.0181835650),
      (nf_inq_Other_count24 = NULL) => -0.0084536618, -0.0084536618),
   (nf_util_adl_count > 3.5) => 0.0243304084,
   (nf_util_adl_count = NULL) => -0.0027484745, -0.0027484745);
   
   // Tree: 40 
   fp3_lexid_model_40 := map(
   (NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 2.5) => 
      map(
      (NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 3.5) => 
         map(
         (NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 4.5) => -0.0021828903,
         (iv_prof_license_category_PL > 4.5) => 0.1087974816,
         (iv_prof_license_category_PL = NULL) => 
            map(
            (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 2.5) => 0.1006573428,
            (rv_C10_M_Hdr_FS > 2.5) => -0.0062762813,
            (rv_C10_M_Hdr_FS = NULL) => -0.0054245777, -0.0054245777), -0.0042330820),
      (nf_hh_collections_ct > 3.5) => 0.0462638676,
      (nf_hh_collections_ct = NULL) => -0.0022330177, -0.0022330177),
   (rv_I62_inq_addrs_per_adl > 2.5) => 
      map(
      (NULL < nf_inq_Auto_count and nf_inq_Auto_count <= 3.5) => 0.0868370106,
      (nf_inq_Auto_count > 3.5) => -0.1050945461,
      (nf_inq_Auto_count = NULL) => 0.0638052238, 0.0638052238),
   (rv_I62_inq_addrs_per_adl = NULL) => -0.0007397507, -0.0007397507);
   
   // Tree: 41 
   fp3_lexid_model_41 := map(
   (NULL < rv_comb_age and rv_comb_age <= 85.5) => 
      map(
      (NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 7.5) => 
         map(
         (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => -0.0088198001,
         (nf_fp_vardobcountnew > 0.5) => 
            map(
            (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 185.5) => 0.0086625018,
            (rv_C13_Curr_Addr_LRes > 185.5) => 0.0815544996,
            (rv_C13_Curr_Addr_LRes = NULL) => 0.0166853935, 0.0166853935),
         (nf_fp_vardobcountnew = NULL) => -0.0030448609, -0.0030448609),
      (rv_D32_criminal_count > 7.5) => 
         map(
         (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 83.5) => 0.1765361889,
         (nf_fp_prevaddrageoldest > 83.5) => 0.0013765546,
         (nf_fp_prevaddrageoldest = NULL) => 0.0946433729, 0.0946433729),
      (rv_D32_criminal_count = NULL) => -0.0016707298, -0.0016707298),
   (rv_comb_age > 85.5) => 0.0910687960,
   (rv_comb_age = NULL) => -0.0008146726, -0.0008146726);
   
   // Tree: 42 
   fp3_lexid_model_42 := map(
   (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => 
      map(
      (NULL < iv_br_source_count and iv_br_source_count <= 4.5) => -0.0058652774,
      (iv_br_source_count > 4.5) => 0.0608113001,
      (iv_br_source_count = NULL) => -0.0041236672, -0.0041236672),
   (nf_fp_vardobcountnew > 0.5) => 
      map(
      (NULL < iv_college_code and iv_college_code <= 3) => 
         map(
         (NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 1.5) => 
            map(
            (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 301) => 0.0182387726,
            (nf_fp_prevaddrageoldest > 301) => 0.1072689264,
            (nf_fp_prevaddrageoldest = NULL) => 0.0223969012, 0.0223969012),
         (rv_I62_inq_phones_per_adl > 1.5) => 0.0787262315,
         (rv_I62_inq_phones_per_adl = NULL) => 0.0280272032, 0.0280272032),
      (iv_college_code > 3) => -0.0454317336,
      (iv_college_code = NULL) => 0.0189726824, 0.0189726824),
   (nf_fp_vardobcountnew = NULL) => 0.0009777515, 0.0009777515);
   
   // Tree: 43 
   fp3_lexid_model_43 := map(
   (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 2) => 
      map(
      (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 
         map(
         (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 10.5) => 0.0445778359,
         (rv_A50_pb_average_dollars > 10.5) => -0.0035199627,
         (rv_A50_pb_average_dollars = NULL) => 0.0185601666, 0.0185601666),
      (nf_hh_members_ct > 1.5) => 
         map(
         (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 454.5) => 
            map(
            (NULL < nf_hh_payday_loan_users and nf_hh_payday_loan_users <= 1.5) => -0.0118391527,
            (nf_hh_payday_loan_users > 1.5) => 0.1094650213,
            (nf_hh_payday_loan_users = NULL) => -0.0110085914, -0.0110085914),
         (nf_fp_prevaddrageoldest > 454.5) => 0.0829511935,
         (nf_fp_prevaddrageoldest = NULL) => -0.0097711458, -0.0097711458),
      (nf_hh_members_ct = NULL) => -0.0046427053, -0.0046427053),
   (rv_I60_inq_PrepaidCards_recency > 2) => 0.0519924664,
   (rv_I60_inq_PrepaidCards_recency = NULL) => -0.0026244113, -0.0026244113);
   
   // Tree: 44 
   fp3_lexid_model_44 := map(
   (NULL < rv_C12_source_profile and rv_C12_source_profile <= 79.55) => 
      map(
      (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 374.5) => -0.0075656107,
         (nf_M_Bureau_ADL_FS_noTU > 374.5) => 0.0533486765,
         (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0060706206, -0.0060706206),
      (rv_D33_Eviction_Recency > 1.5) => 0.0446029997,
      (rv_D33_Eviction_Recency = NULL) => -0.0037890576, -0.0037890576),
   (rv_C12_source_profile > 79.55) => 
      map(
      (NULL < rv_A50_pb_total_dollars and rv_A50_pb_total_dollars <= 2646.5) => 0.0275282978,
      (rv_A50_pb_total_dollars > 2646.5) => 
         map(
         (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 408.5) => 0.2582637789,
         (rv_C10_M_Hdr_FS > 408.5) => -0.0837291743,
         (rv_C10_M_Hdr_FS = NULL) => 0.1768368853, 0.1768368853),
      (rv_A50_pb_total_dollars = NULL) => 0.0322504068, 0.0322504068),
   (rv_C12_source_profile = NULL) => 0.0005398506, 0.0005398506);
   
   // Tree: 45 
   fp3_lexid_model_45 := map(
   (NULL < nf_inq_PrepaidCards_count and nf_inq_PrepaidCards_count <= 2.5) => 
      map(
      (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 1.5) => -0.0183319724,
      (iv_unverified_addr_count > 1.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.870332104526103) => -0.0001395859,
         (census_mod > -0.870332104526103) => 
            map(
            (NULL < nf_mos_liens_unrel_FT_fseen and nf_mos_liens_unrel_FT_fseen <= 60) => 
               map(
               (NULL < nf_hh_members_ct and nf_hh_members_ct <= 14.5) => 0.0228194183,
               (nf_hh_members_ct > 14.5) => 0.1848178429,
               (nf_hh_members_ct = NULL) => 0.0262333892, 0.0262333892),
            (nf_mos_liens_unrel_FT_fseen > 60) => -0.1500915026,
            (nf_mos_liens_unrel_FT_fseen = NULL) => 0.0230553037, 0.0230553037),
         (census_mod = NULL) => 0.0047295207, 0.0047295207),
      (iv_unverified_addr_count = NULL) => -0.0033536513, -0.0033536513),
   (nf_inq_PrepaidCards_count > 2.5) => 0.1117563850,
   (nf_inq_PrepaidCards_count = NULL) => -0.0026352547, -0.0026352547);
   
   // Tree: 46 
   fp3_lexid_model_46 := map(
   (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 
      map(
      (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 7.5) => 
         map(
         (NULL < rv_Ever_Asset_Owner and rv_Ever_Asset_Owner <= 0.5) => 0.1318743825,
         (rv_Ever_Asset_Owner > 0.5) => -0.0046767268,
         (rv_Ever_Asset_Owner = NULL) => 0.0695979352, 0.0695979352),
      (rv_C20_M_Bureau_ADL_FS > 7.5) => 
         map(
         (NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 0.5) => 
            map(
            (iv_pb_profile in ['2 ONLINE SHOPPER','4 OTHER']) => -0.0381698151,
            (iv_pb_profile in ['NA','0 NO PURCH DATA','1 OFFLINE SHOPPER','3 RETAIL SHOPPER']) => -0.0025809372,
            (iv_pb_profile = '') => -0.0097169168, -0.0097169168),
         (rv_I60_inq_other_recency > 0.5) => 0.0159056856,
         (rv_I60_inq_other_recency = NULL) => -0.0033494317, -0.0033494317),
      (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0017116280, -0.0017116280),
   (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0635618505,
   (rv_C16_Inv_SSN_Per_ADL = NULL) => -0.0040108720, -0.0040108720);
   
   // Tree: 47 
   fp3_lexid_model_47 := map(
   (NULL < nf_pb_retail_combo_cnt and nf_pb_retail_combo_cnt <= 1.5) => 
      map(
      (NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => 
         map(
         (NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 229.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 84.5) => 
               map(
               (NULL < nf_hh_lienholders and nf_hh_lienholders <= 3.5) => 0.0023980601,
               (nf_hh_lienholders > 3.5) => 0.1070802569,
               (nf_hh_lienholders = NULL) => 0.0038912747, 0.0038912747),
            (rv_comb_age > 84.5) => 0.1257408812,
            (rv_comb_age = NULL) => 0.0047992449, 0.0047992449),
         (rv_mos_since_br_first_seen > 229.5) => 0.1300745072,
         (rv_mos_since_br_first_seen = NULL) => 0.0064790932, 0.0064790932),
      (rv_D32_felony_count > 0.5) => 0.0979186861,
      (rv_D32_felony_count = NULL) => 0.0083546084, 0.0083546084),
   (nf_pb_retail_combo_cnt > 1.5) => -0.0120719238,
   (nf_pb_retail_combo_cnt = NULL) => -0.0018032311, -0.0018032311);
   
   // Tree: 48 
   fp3_lexid_model_48 := map(
   (NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.005) => 
      map(
      (NULL < iv_br_source_count and iv_br_source_count <= 2.5) => 
         map(
         (NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => -0.0106022486,
         (rv_D32_felony_count > 0.5) => 
            map(
            (NULL < nf_historical_count and nf_historical_count <= 0.5) => 0.1621419165,
            (nf_historical_count > 0.5) => 
               map(
               (NULL < rv_C13_max_lres and rv_C13_max_lres <= 122) => 0.0927441838,
               (rv_C13_max_lres > 122) => -0.1079889612,
               (rv_C13_max_lres = NULL) => -0.0219604705, -0.0219604705),
            (nf_historical_count = NULL) => 0.0612858262, 0.0612858262),
         (rv_D32_felony_count = NULL) => -0.0097131188, -0.0097131188),
      (iv_br_source_count > 2.5) => 0.0315298146,
      (iv_br_source_count = NULL) => -0.0067948701, -0.0067948701),
   (nf_hh_payday_loan_users_pct > 0.005) => 0.0294930708,
   (nf_hh_payday_loan_users_pct = NULL) => -0.0033485660, -0.0033485660);
   
   // Tree: 49 
   fp3_lexid_model_49 := map(
   (NULL < rv_comb_age and rv_comb_age <= 63.5) => 
      map(
      (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= 332000) => -0.0136812603,
      (iv_prop1_purch_sale_diff > 332000) => 
         map(
         (NULL < census_mod and census_mod <= -1.12393823450977) => -0.0332934078,
         (census_mod > -1.12393823450977) => 0.2292819524,
         (census_mod = NULL) => 0.1111230403, 0.1111230403),
      (iv_prop1_purch_sale_diff = NULL) => 
         map(
         (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 115.15) => -0.0061000279,
         (rv_A49_Curr_AVM_Chg_1yr_Pct > 115.15) => 0.0245752327,
         (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => -0.0089623688, -0.0040184116), -0.0037371925),
   (rv_comb_age > 63.5) => 
      map(
      (NULL < nf_rel_derog_summary and nf_rel_derog_summary <= 2.5) => -0.0035045679,
      (nf_rel_derog_summary > 2.5) => 0.0427900934,
      (nf_rel_derog_summary = NULL) => 0.0155876407, 0.0155876407),
   (rv_comb_age = NULL) => -0.0011720884, -0.0011720884);
   
   // Tree: 50 
   fp3_lexid_model_50 := map(
   (NULL < rv_comb_age and rv_comb_age <= 77.5) => 
      map(
      (NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.22996794875) => 
         map(
         (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 0.0300086497,
         (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0342435902,
         (rv_C16_Inv_SSN_Per_ADL = NULL) => 0.0196982477, 0.0196982477),
      (nf_pct_rel_prop_owned > 0.22996794875) => 
         map(
         (NULL < nf_mos_liens_unrel_FT_fseen and nf_mos_liens_unrel_FT_fseen <= 236) => -0.0079051209,
         (nf_mos_liens_unrel_FT_fseen > 236) => 0.1957519457,
         (nf_mos_liens_unrel_FT_fseen = NULL) => -0.0074664039, -0.0074664039),
      (nf_pct_rel_prop_owned = NULL) => -0.0026893646, -0.0026893646),
   (rv_comb_age > 77.5) => 
      map(
      (NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 2.5) => 0.0165255987,
      (nf_hh_tot_derog > 2.5) => 0.1480333109,
      (nf_hh_tot_derog = NULL) => 0.0380039356, 0.0380039356),
   (rv_comb_age = NULL) => -0.0014042355, -0.0014042355);
   
   // Tree: 51 
   fp3_lexid_model_51 := map(
   (NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 
      map(
      (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 2.5) => 0.1139303051,
      (rv_C10_M_Hdr_FS > 2.5) => 
         map(
         (NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.1206060606) => 
            map(
            (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= -89300) => 0.3004784083,
            (iv_prop1_purch_sale_diff > -89300) => -0.0149637416,
            (iv_prop1_purch_sale_diff = NULL) => -0.0162607811, -0.0155100922),
         (nf_pct_rel_with_criminal > 0.1206060606) => 0.0062965477,
         (nf_pct_rel_with_criminal = NULL) => -0.0038512364, -0.0038512364),
      (rv_C10_M_Hdr_FS = NULL) => -0.0031794992, -0.0031794992),
   (nf_fp_srchfraudsrchcountwk > 0.5) => 
      map(
      (NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 90) => 0.0063887278,
      (nf_fp_prevaddrburglaryindex > 90) => 0.1298105084,
      (nf_fp_prevaddrburglaryindex = NULL) => 0.0650974667, 0.0650974667),
   (nf_fp_srchfraudsrchcountwk = NULL) => -0.0020370210, -0.0020370210);
   
   // Tree: 52 
   fp3_lexid_model_52 := map(
   (NULL < rv_A50_pb_total_orders and rv_A50_pb_total_orders <= 9.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 49.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.371319657996583) => -0.0066830648,
         (census_mod > -0.371319657996583) => 0.0463647902,
         (census_mod = NULL) => -0.0045236667, -0.0045236667),
      (rv_comb_age > 49.5) => 
         map(
         (NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 0.5) => 
            map(
            (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 579.5) => 0.0149760219,
            (nf_M_Bureau_ADL_FS_all > 579.5) => -0.1330767790,
            (nf_M_Bureau_ADL_FS_all = NULL) => 0.0133933885, 0.0133933885),
         (nf_fp_srchfraudsrchcountmo > 0.5) => 0.0919639543,
         (nf_fp_srchfraudsrchcountmo = NULL) => 0.0165403725, 0.0165403725),
      (rv_comb_age = NULL) => 0.0021529110, 0.0021529110),
   (rv_A50_pb_total_orders > 9.5) => -0.0278778737,
   (rv_A50_pb_total_orders = NULL) => -0.0019703461, -0.0019703461);
   
   // Tree: 53 
   fp3_lexid_model_53 := map(
   (NULL < census_mod and census_mod <= -1.34658286182144) => -0.0168270479,
   (census_mod > -1.34658286182144) => 
      map(
      (NULL < nf_mos_inq_banko_om_lseen and nf_mos_inq_banko_om_lseen <= 33.5) => 
         map(
         (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 7.5) => 0.0398680848,
         (rv_C13_attr_addrs_recency > 7.5) => 
            map(
            (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 47327.5) => -0.0123904306,
            (nf_fp_curraddrmedianincome > 47327.5) => 
               map(
               (NULL < rv_C12_source_profile and rv_C12_source_profile <= 81.3) => 0.0095882932,
               (rv_C12_source_profile > 81.3) => 0.0487179458,
               (rv_C12_source_profile = NULL) => 0.0132642350, 0.0132642350),
            (nf_fp_curraddrmedianincome = NULL) => 0.0055770004, 0.0055770004),
         (rv_C13_attr_addrs_recency = NULL) => 0.0085127691, 0.0085127691),
      (nf_mos_inq_banko_om_lseen > 33.5) => 0.1000049526,
      (nf_mos_inq_banko_om_lseen = NULL) => 0.0098019101, 0.0098019101),
   (census_mod = NULL) => 0.0011214864, 0.0011214864);
   
   // Tree: 54 
   fp3_lexid_model_54 := map(
   (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 100.5) => 
      map(
      (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 58396) => 0.0329090201,
      (nf_fp_curraddrmedianvalue > 58396) => 
         map(
         (NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 8.5) => -0.0157517813,
         (nf_hh_age_30_plus > 8.5) => 0.1406061901,
         (nf_hh_age_30_plus = NULL) => -0.0149138772, -0.0149138772),
      (nf_fp_curraddrmedianvalue = NULL) => -0.0115562376, -0.0115562376),
   (rv_C13_Curr_Addr_LRes > 100.5) => 
      map(
      (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 223112.5) => 
         map(
         (NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 132.5) => 0.0097948188,
         (nf_fp_curraddrcartheftindex > 132.5) => -0.0392880950,
         (nf_fp_curraddrcartheftindex = NULL) => -0.0032173750, -0.0032173750),
      (nf_fp_curraddrmedianvalue > 223112.5) => 0.0330140286,
      (nf_fp_curraddrmedianvalue = NULL) => 0.0138028827, 0.0138028827),
   (rv_C13_Curr_Addr_LRes = NULL) => -0.0013896504, -0.0013896504);
   
   // Tree: 55 
   fp3_lexid_model_55 := map(
   (NULL < nf_inq_PrepaidCards_count24 and nf_inq_PrepaidCards_count24 <= 0.5) => 
      map(
      (rv_D31_MostRec_Bk in ['2 - BK DISCHARGED']) => -0.0319667472,
      (rv_D31_MostRec_Bk in ['NA','0 - NO BK','1 - BK DISMISSED','3 - BK OTHER']) => 
         map(
         (NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 4.5) => 
            map(
            (NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => -0.0026605500,
            (nf_fp_srchunvrfdaddrcount > 0.5) => 
               map(
               (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 37.5) => -0.1393921974,
               (nf_M_Bureau_ADL_FS > 37.5) => 0.0713750933,
               (nf_M_Bureau_ADL_FS = NULL) => 0.0525705766, 0.0525705766),
            (nf_fp_srchunvrfdaddrcount = NULL) => -0.0010813436, -0.0010813436),
         (nf_hh_tot_derog > 4.5) => 0.0498954745,
         (nf_hh_tot_derog = NULL) => 0.0010026307, 0.0010026307),
      (rv_D31_MostRec_Bk = '') => -0.0021220972, -0.0021220972),
   (nf_inq_PrepaidCards_count24 > 0.5) => 0.0684071655,
   (nf_inq_PrepaidCards_count24 = NULL) => -0.0007186567, -0.0007186567);
   
   // Tree: 56 
   fp3_lexid_model_56 := map(
   (NULL < nf_inq_Other_count24 and nf_inq_Other_count24 <= 2.5) => 
      map(
      (iv_D31_bk_filing_type in ['I']) => -0.0334284063,
      (iv_D31_bk_filing_type in ['NA','B']) => 
         map(
         (NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 62) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 83.5) => -0.0160399484,
            (rv_comb_age > 83.5) => 0.0708441633,
            (rv_comb_age = NULL) => -0.0148643401, -0.0148643401),
         (nf_fp_prevaddrcartheftindex > 62) => 0.0100770126,
         (nf_fp_prevaddrcartheftindex = NULL) => -0.0001411820, -0.0001411820),
      (iv_D31_bk_filing_type = '') => -0.0035058315, -0.0035058315),
   (nf_inq_Other_count24 > 2.5) => 
      map(
      (NULL < nf_rel_criminal_count and nf_rel_criminal_count <= 1.5) => -0.0050605692,
      (nf_rel_criminal_count > 1.5) => 0.0938368476,
      (nf_rel_criminal_count = NULL) => 0.0457445876, 0.0457445876),
   (nf_inq_Other_count24 = NULL) => -0.0017195238, -0.0017195238);
   
   // Tree: 57 
   fp3_lexid_model_57 := map(
   (NULL < rv_I62_inq_phones_per_adl and rv_I62_inq_phones_per_adl <= 2.5) => 
      map(
      (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 42003.5) => 
         map(
         (NULL < rv_email_count and rv_email_count <= 0.5) => 
            map(
            (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.06125) => -0.0106048366,
            (nf_pct_rel_with_felony > 0.06125) => 0.0771072769,
            (nf_pct_rel_with_felony = NULL) => 0.0008680559, 0.0008680559),
         (rv_email_count > 0.5) => -0.0351060038,
         (rv_email_count = NULL) => -0.0182980154, -0.0182980154),
      (nf_fp_curraddrmedianincome > 42003.5) => 
         map(
         (NULL < census_mod and census_mod <= -0.707658612042328) => -0.0012165603,
         (census_mod > -0.707658612042328) => 0.0306377792,
         (census_mod = NULL) => 0.0010807655, 0.0010807655),
      (nf_fp_curraddrmedianincome = NULL) => -0.0025209150, -0.0025209150),
   (rv_I62_inq_phones_per_adl > 2.5) => 0.0776362980,
   (rv_I62_inq_phones_per_adl = NULL) => -0.0015131498, -0.0015131498);
   
   // Tree: 58 
   fp3_lexid_model_58 := map(
   (NULL < nf_fp_srchfraudsrchcountmo and nf_fp_srchfraudsrchcountmo <= 1.5) => 
      map(
      (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 2) => 0.0393833055,
      (rv_C13_attr_addrs_recency > 2) => 
         map(
         (NULL < nf_util_adl_count and nf_util_adl_count <= 3.5) => 
            map(
            (NULL < census_mod and census_mod <= -0.292682599675501) => -0.0101394623,
            (census_mod > -0.292682599675501) => 
               map(
               (NULL < rv_A50_pb_total_dollars and rv_A50_pb_total_dollars <= 477.5) => 0.0581526427,
               (rv_A50_pb_total_dollars > 477.5) => -0.1215488841,
               (rv_A50_pb_total_dollars = NULL) => 0.0418161402, 0.0418161402),
            (census_mod = NULL) => -0.0088833928, -0.0088833928),
         (nf_util_adl_count > 3.5) => 0.0160426987,
         (nf_util_adl_count = NULL) => -0.0045878480, -0.0045878480),
      (rv_C13_attr_addrs_recency = NULL) => -0.0028065437, -0.0028065437),
   (nf_fp_srchfraudsrchcountmo > 1.5) => 0.0776050267,
   (nf_fp_srchfraudsrchcountmo = NULL) => -0.0015701140, -0.0015701140);
   
   // Tree: 59 
   fp3_lexid_model_59 := map(
   (NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 0.5) => 0.1870610431,
   (nf_hh_age_18_plus > 0.5) => 
      map(
      (NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 4.5) => -0.0204530813,
      (iv_prof_license_category_PL > 4.5) => 0.0931348309,
      (iv_prof_license_category_PL = NULL) => 
         map(
         (NULL < rv_C12_source_profile and rv_C12_source_profile <= 79.55) => 
            map(
            (NULL < rv_F04_curr_add_occ_index and rv_F04_curr_add_occ_index <= 2) => -0.0086829883,
            (rv_F04_curr_add_occ_index > 2) => 0.0167739596,
            (rv_F04_curr_add_occ_index = NULL) => -0.0036258655, -0.0036258655),
         (rv_C12_source_profile > 79.55) => 
            map(
            (NULL < rv_A50_pb_total_dollars and rv_A50_pb_total_dollars <= 2339) => 0.0195971429,
            (rv_A50_pb_total_dollars > 2339) => 0.1511941325,
            (rv_A50_pb_total_dollars = NULL) => 0.0258132821, 0.0258132821),
         (rv_C12_source_profile = NULL) => -0.0007563562, -0.0007563562), -0.0013763331),
   (nf_hh_age_18_plus = NULL) => -0.0008991039, -0.0008991039);
   
   // Tree: 60 
   fp3_lexid_model_60 := map(
   (NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 179.5) => 
      map(
      (NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 0.5) => 0.1524104150,
      (nf_hh_age_18_plus > 0.5) => 
         map(
         (NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 3.5) => -0.0046393764,
         (nf_hh_collections_ct > 3.5) => 0.0359173702,
         (nf_hh_collections_ct = NULL) => -0.0030959584, -0.0030959584),
      (nf_hh_age_18_plus = NULL) => -0.0026577477, -0.0026577477),
   (rv_mos_since_br_first_seen > 179.5) => 
      map(
      (NULL < nf_historical_count and nf_historical_count <= 15.5) => 
         map(
         (NULL < nf_pb_retail_combo_max and nf_pb_retail_combo_max <= 1.5) => 0.0845482794,
         (nf_pb_retail_combo_max > 1.5) => -0.0006335338,
         (nf_pb_retail_combo_max = NULL) => 0.0319485097, 0.0319485097),
      (nf_historical_count > 15.5) => 0.4171823917,
      (nf_historical_count = NULL) => 0.0413444581, 0.0413444581),
   (rv_mos_since_br_first_seen = NULL) => -0.0010259727, -0.0010259727);
   
   // Tree: 61 
   fp3_lexid_model_61 := map(
   (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= 313795) => 
      map(
      (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 228356.5) => -0.0214893899,
      (iv_prv_addr_avm_auto_val > 228356.5) => 0.0644663225,
      (iv_prv_addr_avm_auto_val = NULL) => 0.0045338992, 0.0045338992),
   (iv_prop1_purch_sale_diff > 313795) => 0.1067898120,
   (iv_prop1_purch_sale_diff = NULL) => 
      map(
      (NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.09307359305) => 
         map(
         (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 7.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 44.5) => 0.0109655800,
            (rv_comb_age > 44.5) => 0.0776814820,
            (rv_comb_age = NULL) => 0.0261434477, 0.0261434477),
         (rv_C13_attr_addrs_recency > 7.5) => -0.0051476570,
         (rv_C13_attr_addrs_recency = NULL) => -0.0024968208, -0.0024968208),
      (nf_hh_payday_loan_users_pct > 0.09307359305) => 0.0274491265,
      (nf_hh_payday_loan_users_pct = NULL) => 0.0002993196, 0.0002993196), 0.0011726635);
   
   // Tree: 62 
   fp3_lexid_model_62 := map(
   (NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 11.5) => 
      map(
      (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 3.05082831775) => 
         map(
         (iv_pb_profile in ['2 ONLINE SHOPPER','3 RETAIL SHOPPER','4 OTHER']) => -0.0158791979,
         (iv_pb_profile in ['NA','0 NO PURCH DATA','1 OFFLINE SHOPPER']) => 
            map(
            (NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 3.5) => 0.0018136188,
            (nf_hh_collections_ct > 3.5) => 0.0528325526,
            (nf_hh_collections_ct = NULL) => 0.0040558974, 0.0040558974),
         (iv_pb_profile = '') => -0.0027822192, -0.0027822192),
      (nf_add_curr_nhood_VAC_pct > 3.05082831775) => 0.2495613152,
      (nf_add_curr_nhood_VAC_pct = NULL) => -0.0024598237, -0.0024598237),
   (rv_C14_addrs_15yr > 11.5) => 
      map(
      (NULL < rv_C14_addrs_10yr and rv_C14_addrs_10yr <= 9.5) => 0.2133453998,
      (rv_C14_addrs_10yr > 9.5) => 0.0410054740,
      (rv_C14_addrs_10yr = NULL) => 0.0972797355, 0.0972797355),
   (rv_C14_addrs_15yr = NULL) => -0.0015757358, -0.0015757358);
   
   // Tree: 63 
   fp3_lexid_model_63 := map(
   (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => 
      map(
      (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 771814) => 
         map(
         (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 2.55949478425) => -0.0061856653,
         (nf_add_curr_nhood_VAC_pct > 2.55949478425) => 0.3274612965,
         (nf_add_curr_nhood_VAC_pct = NULL) => -0.0056791163, -0.0056791163),
      (iv_prv_addr_avm_auto_val > 771814) => 
         map(
         (NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 115.5) => 0.0212525479,
         (nf_fp_curraddrcartheftindex > 115.5) => 0.1925563410,
         (nf_fp_curraddrcartheftindex = NULL) => 0.0683283995, 0.0683283995),
      (iv_prv_addr_avm_auto_val = NULL) => -0.0260504725, -0.0058502125),
   (nf_fp_vardobcountnew > 0.5) => 
      map(
      (NULL < nf_mos_inq_banko_am_lseen and nf_mos_inq_banko_am_lseen <= 43) => 0.0148331122,
      (nf_mos_inq_banko_am_lseen > 43) => 0.1403225221,
      (nf_mos_inq_banko_am_lseen = NULL) => 0.0174717897, 0.0174717897),
   (nf_fp_vardobcountnew = NULL) => -0.0006335599, -0.0006335599);
   
   // Tree: 64 
   fp3_lexid_model_64 := map(
   (NULL < nf_current_count and nf_current_count <= 5.5) => 
      map(
      (NULL < nf_fp_sourcerisktype and nf_fp_sourcerisktype <= 4.5) => 
         map(
         (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 83527.5) => -0.0220404962,
         (nf_fp_curraddrmedianincome > 83527.5) => 0.0097794399,
         (nf_fp_curraddrmedianincome = NULL) => -0.0116987372, -0.0116987372),
      (nf_fp_sourcerisktype > 4.5) => 
         map(
         (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.02597840755) => 
            map(
            (NULL < nf_inq_count_week and nf_inq_count_week <= 0.5) => -0.0003879588,
            (nf_inq_count_week > 0.5) => 0.0892005200,
            (nf_inq_count_week = NULL) => 0.0018310758, 0.0018310758),
         (nf_pct_rel_with_felony > 0.02597840755) => 0.0544190433,
         (nf_pct_rel_with_felony = NULL) => 0.0080994947, 0.0080994947),
      (nf_fp_sourcerisktype = NULL) => -0.0023938634, -0.0023938634),
   (nf_current_count > 5.5) => 0.0514798134,
   (nf_current_count = NULL) => -0.0007955850, -0.0007955850);
   
   // Tree: 65 
   fp3_lexid_model_65 := map(
   (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 1.5) => 
      map(
      (NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => -0.0147069474,
      (rv_D32_felony_count > 0.5) => 0.1429460487,
      (rv_D32_felony_count = NULL) => -0.0136070428, -0.0136070428),
   (iv_unverified_addr_count > 1.5) => 
      map(
      (NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 241500) => -0.0062109639,
      (nf_average_rel_home_val > 241500) => 
         map(
         (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 185.5) => 0.0169683727,
         (nf_fp_prevaddrcrimeindex > 185.5) => 
            map(
            (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 80005) => 0.0069572595,
            (rv_A46_Curr_AVM_AutoVal > 80005) => 0.2079786701,
            (rv_A46_Curr_AVM_AutoVal = NULL) => 0.1167745116, 0.1167745116),
         (nf_fp_prevaddrcrimeindex = NULL) => 0.0197834844, 0.0197834844),
      (nf_average_rel_home_val = NULL) => 0.0076399605, 0.0076399605),
   (iv_unverified_addr_count = NULL) => 0.0002027406, 0.0002027406);
   
   // Tree: 66 
   fp3_lexid_model_66 := map(
   (NULL < census_mod and census_mod <= -1.15331882669386) => 
      map(
      (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 441.5) => -0.0154118456,
      (rv_C10_M_Hdr_FS > 441.5) => 0.0411472415,
      (rv_C10_M_Hdr_FS = NULL) => -0.0124087082, -0.0124087082),
   (census_mod > -1.15331882669386) => 
      map(
      (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= 359250) => 
         map(
         (NULL < rv_I61_inq_collection_recency and rv_I61_inq_collection_recency <= 0.5) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 121.8) => -0.0402757089,
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 121.8) => 0.1547697241,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0703120358, 0.0450724968),
         (rv_I61_inq_collection_recency > 0.5) => -0.0519925291,
         (rv_I61_inq_collection_recency = NULL) => -0.0053859095, -0.0053859095),
      (iv_prop1_purch_sale_diff > 359250) => 0.1341869711,
      (iv_prop1_purch_sale_diff = NULL) => 0.0085093066, 0.0086582344),
   (census_mod = NULL) => -0.0025383426, -0.0025383426);
   
   // Tree: 67 
   fp3_lexid_model_67 := map(
   (NULL < census_mod and census_mod <= -0.134691760231015) => 
      map(
      (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 4.5) => 
         map(
         (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.93024059335) => 
            map(
            (NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 4.5) => -0.0362353131,
            (iv_prof_license_category_PL > 4.5) => 0.0941764116,
            (iv_prof_license_category_PL = NULL) => -0.0065786759, -0.0076798033),
         (nf_add_curr_nhood_SFD_pct > 0.93024059335) => 
            map(
            (NULL < nf_rel_derog_summary and nf_rel_derog_summary <= 3.5) => 0.0001205563,
            (nf_rel_derog_summary > 3.5) => 0.0334184103,
            (nf_rel_derog_summary = NULL) => 0.0119217602, 0.0119217602),
         (nf_add_curr_nhood_SFD_pct = NULL) => -0.0009509894, -0.0009509894),
      (nf_fp_idrisktype > 4.5) => 0.1096779796,
      (nf_fp_idrisktype = NULL) => -0.0002402021, -0.0002402021),
   (census_mod > -0.134691760231015) => 0.0583152284,
   (census_mod = NULL) => 0.0006124955, 0.0006124955);
   
   // Tree: 68 
   fp3_lexid_model_68 := map(
   (NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.5857142857) => 
      map(
      (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 
         map(
         (NULL < rv_D34_UnRel_Lien60_Count and rv_D34_UnRel_Lien60_Count <= 4.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 42.5) => -0.0064336608,
            (rv_comb_age > 42.5) => 0.0099345919,
            (rv_comb_age = NULL) => 0.0012630854, 0.0012630854),
         (rv_D34_UnRel_Lien60_Count > 4.5) => 0.2422824305,
         (rv_D34_UnRel_Lien60_Count = NULL) => 0.0015940585, 0.0015940585),
      (rv_D33_Eviction_Recency > 1.5) => 0.0429361458,
      (rv_D33_Eviction_Recency = NULL) => 0.0032858560, 0.0032858560),
   (nf_hh_bankruptcies_pct > 0.5857142857) => 
      map(
      (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 280518.5) => -0.0547175831,
      (iv_prv_addr_avm_auto_val > 280518.5) => 0.0542947970,
      (iv_prv_addr_avm_auto_val = NULL) => -0.0461929183, -0.0461929183),
   (nf_hh_bankruptcies_pct = NULL) => 0.0013793837, 0.0013793837);
   
   // Tree: 69 
   fp3_lexid_model_69 := map(
   (NULL < census_mod and census_mod <= -1.47249402025585) => -0.0247039616,
   (census_mod > -1.47249402025585) => 
      map(
      (NULL < rv_C13_max_lres and rv_C13_max_lres <= 291.5) => 0.0009200987,
      (rv_C13_max_lres > 291.5) => 
         map(
         (NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 134.5) => 
            map(
            (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.79967982925) => 
               map(
               (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 152) => -0.0118165416,
               (rv_A50_pb_average_dollars > 152) => 0.2154145915,
               (rv_A50_pb_average_dollars = NULL) => 0.0013389451, 0.0013389451),
            (nf_add_curr_nhood_SFD_pct > 0.79967982925) => 0.0525050540,
            (nf_add_curr_nhood_SFD_pct = NULL) => 0.0348615682, 0.0348615682),
         (nf_fp_curraddrcartheftindex > 134.5) => -0.0131490456,
         (nf_fp_curraddrcartheftindex = NULL) => 0.0226235686, 0.0226235686),
      (rv_C13_max_lres = NULL) => 0.0045467433, 0.0045467433),
   (census_mod = NULL) => -0.0012869944, -0.0012869944);
   
   // Tree: 70 
   fp3_lexid_model_70 := map(
   (rv_D31_ALL_Bk in ['2 - BK DISCHARGED','3 - BK OTHER']) => -0.0314265115,
   (rv_D31_ALL_Bk in ['NA','0 - NO BK','1 - BK DISMISSED']) => 
      map(
      (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 
         map(
         (NULL < nf_pb_retail_combo_cnt and nf_pb_retail_combo_cnt <= 1.5) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 107.05) => 
               map(
               (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 14.5) => 0.0036503817,
               (nf_mos_inq_banko_om_fseen > 14.5) => 0.2595446284,
               (nf_mos_inq_banko_om_fseen = NULL) => 0.0207099982, 0.0207099982),
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 107.05) => 0.1201449352,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0317308799, 0.0404196265),
         (nf_pb_retail_combo_cnt > 1.5) => -0.0072802918,
         (nf_pb_retail_combo_cnt = NULL) => 0.0200207910, 0.0200207910),
      (nf_hh_members_ct > 1.5) => -0.0021819594,
      (nf_hh_members_ct = NULL) => 0.0019127740, 0.0019127740),
   (rv_D31_ALL_Bk = '') => -0.0010303467, -0.0010303467);
   
   // Tree: 71 
   fp3_lexid_model_71 := map(
   (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 
      map(
      (NULL < nf_mos_liens_unrel_FT_fseen and nf_mos_liens_unrel_FT_fseen <= 236.5) => -0.0016604542,
      (nf_mos_liens_unrel_FT_fseen > 236.5) => 0.1932734158,
      (nf_mos_liens_unrel_FT_fseen = NULL) => -0.0014393363, -0.0014393363),
   (rv_D33_Eviction_Recency > 1.5) => 
      map(
      (NULL < rv_I61_inq_collection_recency and rv_I61_inq_collection_recency <= 0.5) => 0.1080881744,
      (rv_I61_inq_collection_recency > 0.5) => 
         map(
         (NULL < nf_mos_inq_banko_cm_lseen and nf_mos_inq_banko_cm_lseen <= 17.5) => 
            map(
            (NULL < rv_I60_inq_hiRiskCred_recency and rv_I60_inq_hiRiskCred_recency <= 9) => -0.0239725441,
            (rv_I60_inq_hiRiskCred_recency > 9) => 0.0743004942,
            (rv_I60_inq_hiRiskCred_recency = NULL) => 0.0014376184, 0.0014376184),
         (nf_mos_inq_banko_cm_lseen > 17.5) => 0.1187085840,
         (nf_mos_inq_banko_cm_lseen = NULL) => 0.0193840987, 0.0193840987),
      (rv_I61_inq_collection_recency = NULL) => 0.0376084161, 0.0376084161),
   (rv_D33_Eviction_Recency = NULL) => 0.0002453398, 0.0002453398);
   
   // Tree: 72 
   fp3_lexid_model_72 := map(
   (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 
      map(
      (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 
         map(
         (NULL < nf_mos_inq_banko_om_lseen and nf_mos_inq_banko_om_lseen <= 31.5) => 
            map(
            (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 69.5) => -0.0020814690,
            (iv_prv_addr_lres > 69.5) => 0.0350745884,
            (iv_prv_addr_lres = NULL) => 0.0744019834, 0.0163089705),
         (nf_mos_inq_banko_om_lseen > 31.5) => 0.1435789025,
         (nf_mos_inq_banko_om_lseen = NULL) => 0.0195440634, 0.0195440634),
      (nf_hh_members_ct > 1.5) => 
         map(
         (NULL < nf_inq_RetailPayments_count and nf_inq_RetailPayments_count <= 2.5) => -0.0052567565,
         (nf_inq_RetailPayments_count > 2.5) => 0.2126243197,
         (nf_inq_RetailPayments_count = NULL) => -0.0047143958, -0.0047143958),
      (nf_hh_members_ct = NULL) => -0.0005173441, -0.0005173441),
   (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0537634830,
   (rv_C16_Inv_SSN_Per_ADL = NULL) => -0.0022944629, -0.0022944629);
   
   // Tree: 73 
   fp3_lexid_model_73 := map(
   (NULL < iv_prop2_purch_sale_diff and iv_prop2_purch_sale_diff <= 276900) => -0.0142784806,
   (iv_prop2_purch_sale_diff > 276900) => 0.1650807068,
   (iv_prop2_purch_sale_diff = NULL) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 72.5) => -0.0027639117,
      (rv_comb_age > 72.5) => 
         map(
         (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.01465359355) => -0.0097383465,
         (nf_add_curr_nhood_VAC_pct > 0.01465359355) => 
            map(
            (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 57629) => 
               map(
               (NULL < nf_average_rel_income and nf_average_rel_income <= 70500) => 0.0614573772,
               (nf_average_rel_income > 70500) => -0.0781742329,
               (nf_average_rel_income = NULL) => 0.0151990524, 0.0151990524),
            (nf_fp_curraddrmedianincome > 57629) => 0.0951322812,
            (nf_fp_curraddrmedianincome = NULL) => 0.0508155591, 0.0508155591),
         (nf_add_curr_nhood_VAC_pct = NULL) => 0.0201322043, 0.0201322043),
      (rv_comb_age = NULL) => -0.0015096759, -0.0015096759), -0.0013664888);
   
   // Tree: 74 
   fp3_lexid_model_74 := map(
   (NULL < nf_hh_property_owners_ct and nf_hh_property_owners_ct <= 4.5) => 
      map(
      (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 368.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 356.5) => -0.0039233729,
         (nf_M_Bureau_ADL_FS_noTU > 356.5) => 0.0533184774,
         (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0015797171, -0.0015797171),
      (rv_C20_M_Bureau_ADL_FS > 368.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 372.5) => -0.1229051115,
         (nf_M_Bureau_ADL_FS > 372.5) => 0.0018214269,
         (nf_M_Bureau_ADL_FS = NULL) => -0.0318525231, -0.0318525231),
      (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0031476646, -0.0031476646),
   (nf_hh_property_owners_ct > 4.5) => 
      map(
      (NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 184.5) => 0.0479361738,
      (nf_fp_prevaddrcartheftindex > 184.5) => 0.2856140546,
      (nf_fp_prevaddrcartheftindex = NULL) => 0.0619923925, 0.0619923925),
   (nf_hh_property_owners_ct = NULL) => -0.0020517845, -0.0020517845);
   
   // Tree: 75 
   fp3_lexid_model_75 := map(
   (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 372.5) => 
      map(
      (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 368.5) => 
         map(
         (NULL < census_mod and census_mod <= 0.384564611014207) => 
            map(
            (NULL < nf_dl_addrs_per_adl and nf_dl_addrs_per_adl <= 0.5) => 
               map(
               (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => -0.0021614821,
               (nf_fp_vardobcountnew > 0.5) => 0.0306256890,
               (nf_fp_vardobcountnew = NULL) => 0.0048123853, 0.0048123853),
            (nf_dl_addrs_per_adl > 0.5) => -0.0125350831,
            (nf_dl_addrs_per_adl = NULL) => -0.0027521778, -0.0027521778),
         (census_mod > 0.384564611014207) => 0.1479562197,
         (census_mod = NULL) => -0.0024648680, -0.0024648680),
      (rv_C20_M_Bureau_ADL_FS > 368.5) => -0.1053375987,
      (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0039911983, -0.0039911983),
   (nf_M_Bureau_ADL_FS > 372.5) => 0.0374260947,
   (nf_M_Bureau_ADL_FS = NULL) => -0.0024665204, -0.0024665204);
   
   // Tree: 76 
   fp3_lexid_model_76 := map(
   (NULL < nf_util_adl_count and nf_util_adl_count <= 3.5) => 
      map(
      (NULL < rv_D31_attr_bankruptcy_recency and rv_D31_attr_bankruptcy_recency <= 18) => 
         map(
         (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 1192) => 0.0003611735,
         (rv_A50_pb_average_dollars > 1192) => 0.2267306027,
         (rv_A50_pb_average_dollars = NULL) => 0.0007694387, 0.0007694387),
      (rv_D31_attr_bankruptcy_recency > 18) => -0.0404888719,
      (rv_D31_attr_bankruptcy_recency = NULL) => -0.0029373979, -0.0029373979),
   (nf_util_adl_count > 3.5) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 165.75) => 0.0333591612,
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 165.75) => 
         map(
         (NULL < nf_inq_count and nf_inq_count <= 3.5) => 0.4061932353,
         (nf_inq_count > 3.5) => -0.0276925595,
         (nf_inq_count = NULL) => 0.2175472376, 0.2175472376),
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0135393595, 0.0238909390),
   (nf_util_adl_count = NULL) => 0.0017167944, 0.0017167944);
   
   // Tree: 77 
   fp3_lexid_model_77 := map(
   (NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 126500) => -0.0233578250,
   (nf_average_rel_home_val > 126500) => 
      map(
      (NULL < census_mod and census_mod <= -0.0739227112300459) => 
         map(
         (NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 79.5) => 
            map(
            (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 52895) => 0.1662597030,
            (nf_fp_prevaddrmedianincome > 52895) => -0.0092833139,
            (nf_fp_prevaddrmedianincome = NULL) => 0.0773483048, 0.0773483048),
         (nf_attr_arrest_recency > 79.5) => 0.0331301333,
         (nf_attr_arrest_recency = NULL) => -0.0000474933, 0.0007297727),
      (census_mod > -0.0739227112300459) => 
         map(
         (NULL < nf_current_count and nf_current_count <= 0.5) => 0.1334578039,
         (nf_current_count > 0.5) => -0.0206672616,
         (nf_current_count = NULL) => 0.0772474859, 0.0772474859),
      (census_mod = NULL) => 0.0014111772, 0.0014111772),
   (nf_average_rel_home_val = NULL) => -0.0019739496, -0.0019739496);
   
   // Tree: 78 
   fp3_lexid_model_78 := map(
   (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 442.5) => 
      map(
      (NULL < rv_A50_pb_total_orders and rv_A50_pb_total_orders <= 3.5) => 
         map(
         (NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.02000762195) => -0.0105232220,
         (nf_pct_rel_with_criminal > 0.02000762195) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 128.85) => 0.0198516757,
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 128.85) => 
               map(
               (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 69.5) => 0.0289542873,
               (rv_A50_pb_average_dollars > 69.5) => 0.1529926117,
               (rv_A50_pb_average_dollars = NULL) => 0.0517136129, 0.0517136129),
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0021118276, 0.0126074904),
         (nf_pct_rel_with_criminal = NULL) => 0.0045948137, 0.0045948137),
      (rv_A50_pb_total_orders > 3.5) => -0.0161661531,
      (rv_A50_pb_total_orders = NULL) => -0.0012434955, -0.0012434955),
   (nf_fp_prevaddrageoldest > 442.5) => 0.0694262075,
   (nf_fp_prevaddrageoldest = NULL) => -0.0003997545, -0.0003997545);
   
   // Tree: 79 
   fp3_lexid_model_79 := map(
   (NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 11.5) => 
      map(
      (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 100.5) => 
         map(
         (NULL < rv_S66_ssns_per_adl_c6 and rv_S66_ssns_per_adl_c6 <= 0.5) => -0.0129509090,
         (rv_S66_ssns_per_adl_c6 > 0.5) => 
            map(
            (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.02942381775) => 0.0187943957,
            (nf_add_curr_nhood_VAC_pct > 0.02942381775) => 0.1620313466,
            (nf_add_curr_nhood_VAC_pct = NULL) => 0.0613034263, 0.0613034263),
         (rv_S66_ssns_per_adl_c6 = NULL) => -0.0111926716, -0.0111926716),
      (rv_C13_Curr_Addr_LRes > 100.5) => 
         map(
         (NULL < nf_hh_bankruptcies and nf_hh_bankruptcies <= 1.5) => 0.0132574588,
         (nf_hh_bankruptcies > 1.5) => -0.0539092447,
         (nf_hh_bankruptcies = NULL) => 0.0086426036, 0.0086426036),
      (rv_C13_Curr_Addr_LRes = NULL) => -0.0032085931, -0.0032085931),
   (rv_C14_addrs_15yr > 11.5) => 0.0832632263,
   (rv_C14_addrs_15yr = NULL) => -0.0024342887, -0.0024342887);
   
   // Tree: 80 
   fp3_lexid_model_80 := map(
   (NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 0.5) => 
      map(
      (NULL < nf_hh_payday_loan_users and nf_hh_payday_loan_users <= 1.5) => -0.0041746665,
      (nf_hh_payday_loan_users > 1.5) => 0.1187847002,
      (nf_hh_payday_loan_users = NULL) => -0.0036130057, -0.0036130057),
   (rv_I60_inq_other_recency > 0.5) => 
      map(
      (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.6010838718) => 
         map(
         (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 483.5) => 0.0235614081,
         (rv_C10_M_Hdr_FS > 483.5) => 0.1237716998,
         (rv_C10_M_Hdr_FS = NULL) => 0.0263033742, 0.0263033742),
      (nf_add_curr_nhood_MFD_pct > 0.6010838718) => 
         map(
         (NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.3693181818) => -0.0511223845,
         (nf_pct_rel_prop_sold > 0.3693181818) => 0.0532515762,
         (nf_pct_rel_prop_sold = NULL) => -0.0285692171, -0.0285692171),
      (nf_add_curr_nhood_MFD_pct = NULL) => 0.0183240934, 0.0183240934),
   (rv_I60_inq_other_recency = NULL) => 0.0018176962, 0.0018176962);
   
   // Tree: 81 
   fp3_lexid_model_81 := map(
   (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 371.5) => 
      map(
      (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 368.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 366.5) => -0.0017940860,
         (nf_M_Bureau_ADL_FS_noTU > 366.5) => 
            map(
            (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 0.5) => 0.1054526367,
            (nf_fp_srchfraudsrchcount > 0.5) => 0.0055832529,
            (nf_fp_srchfraudsrchcount = NULL) => 0.0426038004, 0.0426038004),
         (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0003171274, -0.0003171274),
      (rv_C20_M_Bureau_ADL_FS > 368.5) => -0.1119005697,
      (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0019980756, -0.0019980756),
   (nf_M_Bureau_ADL_FS_noTU > 371.5) => 
      map(
      (NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.9) => 0.0099687140,
      (nf_hh_pct_property_owners > 0.9) => 0.0960596237,
      (nf_hh_pct_property_owners = NULL) => 0.0345095710, 0.0345095710),
   (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0005616767, -0.0005616767);
   
   // Tree: 82 
   fp3_lexid_model_82 := map(
   (NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 0.5) => 0.1578159261,
   (nf_hh_age_18_plus > 0.5) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 105.95) => -0.0059808810,
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 105.95) => 0.0133385570,
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 
         map(
         (NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.2792207792) => 
            map(
            (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= 297000) => -0.0533717041,
            (iv_prop1_purch_sale_diff > 297000) => 0.1647998985,
            (iv_prop1_purch_sale_diff = NULL) => -0.0152213752, -0.0158429866),
         (nf_hh_lienholders_pct > 0.2792207792) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 24.5) => 0.1171102102,
            (rv_comb_age > 24.5) => 0.0071370041,
            (rv_comb_age = NULL) => 0.0179670316, 0.0179670316),
         (nf_hh_lienholders_pct = NULL) => -0.0085983970, -0.0085983970), -0.0030813865),
   (nf_hh_age_18_plus = NULL) => -0.0026884571, -0.0026884571);
   
   // Tree: 83 
   fp3_lexid_model_83 := map(
   (NULL < nf_inq_Communications_count and nf_inq_Communications_count <= 3.5) => 
      map(
      (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 2.5) => 0.0943574377,
      (rv_C10_M_Hdr_FS > 2.5) => 
         map(
         (NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 14.5) => 
            map(
            (iv_curr_add_financing_type in ['ADJ','NONE','OTH']) => -0.0037615470,
            (iv_curr_add_financing_type in ['NA','CNV']) => 
               map(
               (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 452391.5) => 0.0223076659,
               (nf_fp_curraddrmedianvalue > 452391.5) => 0.1606822009,
               (nf_fp_curraddrmedianvalue = NULL) => 0.0426461802, 0.0426461802),
            (iv_curr_add_financing_type = '') => -0.0021274117, -0.0021274117),
         (nf_fp_assocsuspicousidcount > 14.5) => 0.1443214565,
         (nf_fp_assocsuspicousidcount = NULL) => -0.0016955683, -0.0016955683),
      (rv_C10_M_Hdr_FS = NULL) => -0.0011236671, -0.0011236671),
   (nf_inq_Communications_count > 3.5) => 0.0738025566,
   (nf_inq_Communications_count = NULL) => -0.0001816678, -0.0001816678);
   
   // Tree: 84 
   fp3_lexid_model_84 := map(
   (NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => 
      map(
      (NULL < rv_D32_felony_count and rv_D32_felony_count <= 0.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 43.5) => -0.0037452153,
         (rv_comb_age > 43.5) => 
            map(
            (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 133581.5) => 
               map(
               (NULL < iv_A46_L77_addrs_move_traj and iv_A46_L77_addrs_move_traj <= 7.5) => -0.0374699098,
               (iv_A46_L77_addrs_move_traj > 7.5) => 0.0376140333,
               (iv_A46_L77_addrs_move_traj = NULL) => -0.0178869475, -0.0178869475),
            (nf_fp_curraddrmedianvalue > 133581.5) => 0.0272583959,
            (nf_fp_curraddrmedianvalue = NULL) => 0.0138377302, 0.0138377302),
         (rv_comb_age = NULL) => 0.0032530247, 0.0032530247),
      (rv_D32_felony_count > 0.5) => 0.1070945610,
      (rv_D32_felony_count = NULL) => 0.0047769369, 0.0047769369),
   (rv_email_domain_ISP_count > 0.5) => -0.0133550993,
   (rv_email_domain_ISP_count = NULL) => -0.0022915396, -0.0022915396);
   
   // Tree: 85 
   fp3_lexid_model_85 := map(
   (rv_D31_ALL_Bk in ['1 - BK DISMISSED','2 - BK DISCHARGED']) => -0.0287651357,
   (rv_D31_ALL_Bk in ['NA','0 - NO BK','3 - BK OTHER']) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 42.5) => 
         map(
         (NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 4.5) => 
            map(
            (NULL < nf_inq_HighRiskCredit_count and nf_inq_HighRiskCredit_count <= 5.5) => -0.0123272773,
            (nf_inq_HighRiskCredit_count > 5.5) => 0.0748482077,
            (nf_inq_HighRiskCredit_count = NULL) => -0.0106924176, -0.0106924176),
         (rv_D30_Derog_Count > 4.5) => 0.0513599367,
         (rv_D30_Derog_Count = NULL) => -0.0074742922, -0.0074742922),
      (rv_comb_age > 42.5) => 
         map(
         (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 39.5) => 0.0125027889,
         (nf_mos_inq_banko_om_fseen > 39.5) => 0.1399800480,
         (nf_mos_inq_banko_om_fseen = NULL) => 0.0140800594, 0.0140800594),
      (rv_comb_age = NULL) => 0.0023549265, 0.0023549265),
   (rv_D31_ALL_Bk = '') => -0.0008145010, -0.0008145010);
   
   // Tree: 86 
   fp3_lexid_model_86 := map(
   (NULL < nf_inq_PrepaidCards_count24 and nf_inq_PrepaidCards_count24 <= 0.5) => 
      map(
      (NULL < census_mod and census_mod <= -0.756102506872014) => -0.0050543969,
      (census_mod > -0.756102506872014) => 
         map(
         (nf_fp_prevaddrstatus in ['-1','O','R']) => 
            map(
            (NULL < nf_mos_liens_rel_CJ_fseen and nf_mos_liens_rel_CJ_fseen <= 82.5) => -0.0025008553,
            (nf_mos_liens_rel_CJ_fseen > 82.5) => 0.1850882557,
            (nf_mos_liens_rel_CJ_fseen = NULL) => 0.0002066164, 0.0002066164),
         (nf_fp_prevaddrstatus in ['NA','U']) => 
            map(
            (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 30.5) => 0.1585617089,
            (nf_fp_curraddrmurderindex > 30.5) => 0.0323951872,
            (nf_fp_curraddrmurderindex = NULL) => 0.0401993019, 0.0401993019),
         (nf_fp_prevaddrstatus = '') => 0.0152038735, 0.0152038735),
      (census_mod = NULL) => -0.0021574250, -0.0021574250),
   (nf_inq_PrepaidCards_count24 > 0.5) => 0.0549442461,
   (nf_inq_PrepaidCards_count24 = NULL) => -0.0011089772, -0.0011089772);
   
   // Tree: 87 
   fp3_lexid_model_87 := map(
   (NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 133.5) => -0.0006897346,
   (nf_mos_acc_lseen > 133.5) => 
      map(
      (NULL < census_mod and census_mod <= -0.480522462675767) => 
         map(
         (NULL < rv_email_count and rv_email_count <= 2.5) => 
            map(
            (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 82275) => 
               map(
               (NULL < nf_inq_Collection_count and nf_inq_Collection_count <= 1.5) => 0.1554889786,
               (nf_inq_Collection_count > 1.5) => -0.0362702030,
               (nf_inq_Collection_count = NULL) => 0.0863299295, 0.0863299295),
            (nf_fp_curraddrmedianincome > 82275) => 0.2796141417,
            (nf_fp_curraddrmedianincome = NULL) => 0.1409042953, 0.1409042953),
         (rv_email_count > 2.5) => 0.0046683375,
         (rv_email_count = NULL) => 0.0818687136, 0.0818687136),
      (census_mod > -0.480522462675767) => -0.2158616339,
      (census_mod = NULL) => 0.0632605669, 0.0632605669),
   (nf_mos_acc_lseen = NULL) => 0.0002357401, 0.0002357401);
   
   // Tree: 88 
   fp3_lexid_model_88 := map(
   (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 125.5) => 
      map(
      (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 149.5) => 0.0015721287,
      (nf_fp_prevaddrcrimeindex > 149.5) => 
         map(
         (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.97849937745) => 0.0416211631,
         (nf_add_curr_nhood_MFD_pct > 0.97849937745) => -0.1346936030,
         (nf_add_curr_nhood_MFD_pct = NULL) => 0.0373999993, 0.0373999993),
      (nf_fp_prevaddrcrimeindex = NULL) => 0.0062594034, 0.0062594034),
   (nf_fp_curraddrburglaryindex > 125.5) => 
      map(
      (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 1.5) => 
         map(
         (NULL < nf_inq_Collection_count and nf_inq_Collection_count <= 2.5) => -0.0109352372,
         (nf_inq_Collection_count > 2.5) => -0.0579107817,
         (nf_inq_Collection_count = NULL) => -0.0200971988, -0.0200971988),
      (rv_D33_Eviction_Recency > 1.5) => 0.0499083340,
      (rv_D33_Eviction_Recency = NULL) => -0.0156249760, -0.0156249760),
   (nf_fp_curraddrburglaryindex = NULL) => 0.0008061233, 0.0008061233);
   
   // Tree: 89 
   fp3_lexid_model_89 := map(
   (NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.3827838828) => 
      map(
      (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.2128623188) => 0.0112910151,
      (nf_pct_rel_with_felony > 0.2128623188) => 0.1017431779,
      (nf_pct_rel_with_felony = NULL) => 0.0138730810, 0.0138730810),
   (nf_pct_rel_prop_owned > 0.3827838828) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 115.15) => -0.0053231720,
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 115.15) => 
         map(
         (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 704379.5) => 0.0126448166,
         (rv_A46_Curr_AVM_AutoVal > 704379.5) => 
            map(
            (NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 3.5) => -0.0188284032,
            (iv_C14_addrs_per_adl > 3.5) => 0.2414358011,
            (iv_C14_addrs_per_adl = NULL) => 0.1266133580, 0.1266133580),
         (rv_A46_Curr_AVM_AutoVal = NULL) => 0.0195829194, 0.0195829194),
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => -0.0122173569, -0.0049618980),
   (nf_pct_rel_prop_owned = NULL) => 0.0008269279, 0.0008269279);
   
   // Tree: 90 
   fp3_lexid_model_90 := map(
   (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.0736224029) => 
      map(
      (NULL < nf_liens_unrel_SC_total_amt and nf_liens_unrel_SC_total_amt <= 1042.5) => -0.0062874071,
      (nf_liens_unrel_SC_total_amt > 1042.5) => -0.1143299610,
      (nf_liens_unrel_SC_total_amt = NULL) => -0.0074681038, -0.0074681038),
   (nf_pct_rel_with_bk > 0.0736224029) => 
      map(
      (NULL < nf_historical_count and nf_historical_count <= 0.5) => 
         map(
         (NULL < nf_inq_count24 and nf_inq_count24 <= 2.5) => 0.0133741112,
         (nf_inq_count24 > 2.5) => 
            map(
            (NULL < nf_mos_liens_rel_OT_lseen and nf_mos_liens_rel_OT_lseen <= 55) => 0.0766626593,
            (nf_mos_liens_rel_OT_lseen > 55) => -0.1896135741,
            (nf_mos_liens_rel_OT_lseen = NULL) => 0.0700358752, 0.0700358752),
         (nf_inq_count24 = NULL) => 0.0243249200, 0.0243249200),
      (nf_historical_count > 0.5) => -0.0041664683,
      (nf_historical_count = NULL) => 0.0090639490, 0.0090639490),
   (nf_pct_rel_with_bk = NULL) => -0.0001037442, -0.0001037442);
   
   // Tree: 91 
   fp3_lexid_model_91 := map(
   (NULL < rv_comb_age and rv_comb_age <= 16.5) => 0.1307853687,
   (rv_comb_age > 16.5) => 
      map(
      (NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.1380952381) => 
         map(
         (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 92.15) => -0.0151744597,
         (rv_A49_Curr_AVM_Chg_1yr_Pct > 92.15) => 
            map(
            (NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 24.5) => 
               map(
               (NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.0111479639) => -0.0600790196,
               (nf_add_curr_nhood_BUS_pct > 0.0111479639) => 0.2334484916,
               (nf_add_curr_nhood_BUS_pct = NULL) => 0.1487770942, 0.1487770942),
            (iv_C13_avg_lres > 24.5) => 0.0074541426,
            (iv_C13_avg_lres = NULL) => 0.0093394155, 0.0093394155),
         (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => -0.0065643797, -0.0012137767),
      (nf_hh_payday_loan_users_pct > 0.1380952381) => 0.0270291237,
      (nf_hh_payday_loan_users_pct = NULL) => 0.0010292678, 0.0010292678),
   (rv_comb_age = NULL) => 0.0012758407, 0.0012758407);
   
   // Tree: 92 
   fp3_lexid_model_92 := map(
   (NULL < nf_hh_members_w_derog and nf_hh_members_w_derog <= 7.5) => 
      map(
      (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 137.5) => 
         map(
         (NULL < nf_inq_PrepaidCards_count and nf_inq_PrepaidCards_count <= 2.5) => 
            map(
            (NULL < nf_hh_payday_loan_users and nf_hh_payday_loan_users <= 1.5) => -0.0017918177,
            (nf_hh_payday_loan_users > 1.5) => 
               map(
               (NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 131) => 0.0270543552,
               (iv_C13_avg_lres > 131) => 0.2377795688,
               (iv_C13_avg_lres = NULL) => 0.0894914556, 0.0894914556),
            (nf_hh_payday_loan_users = NULL) => -0.0012271142, -0.0012271142),
         (nf_inq_PrepaidCards_count > 2.5) => 0.1119298460,
         (nf_inq_PrepaidCards_count = NULL) => -0.0006339267, -0.0006339267),
      (nf_fp_curraddrburglaryindex > 137.5) => -0.0192231889,
      (nf_fp_curraddrburglaryindex = NULL) => -0.0044383819, -0.0044383819),
   (nf_hh_members_w_derog > 7.5) => 0.1367805646,
   (nf_hh_members_w_derog = NULL) => -0.0041446015, -0.0041446015);
   
   // Tree: 93 
   fp3_lexid_model_93 := map(
   (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 202.5) => 
      map(
      (NULL < nf_pb_retail_combo_cnt and nf_pb_retail_combo_cnt <= 2.5) => 
         map(
         (NULL < nf_util_adl_count and nf_util_adl_count <= 5.5) => 
            map(
            (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.9287848416) => -0.0053138829,
            (nf_add_curr_nhood_SFD_pct > 0.9287848416) => 
               map(
               (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.9378420883) => 0.1108756440,
               (nf_add_curr_nhood_SFD_pct > 0.9378420883) => 0.0137467268,
               (nf_add_curr_nhood_SFD_pct = NULL) => 0.0195331304, 0.0195331304),
            (nf_add_curr_nhood_SFD_pct = NULL) => 0.0024767084, 0.0024767084),
         (nf_util_adl_count > 5.5) => 0.0370983508,
         (nf_util_adl_count = NULL) => 0.0051857654, 0.0051857654),
      (nf_pb_retail_combo_cnt > 2.5) => -0.0132219596,
      (nf_pb_retail_combo_cnt = NULL) => -0.0019764439, -0.0019764439),
   (rv_A50_pb_average_dollars > 202.5) => 0.0437151845,
   (rv_A50_pb_average_dollars = NULL) => -0.0002902840, -0.0002902840);
   
   // Tree: 94 
   fp3_lexid_model_94 := map(
   (NULL < nf_util_adl_count and nf_util_adl_count <= 3.5) => -0.0009804183,
   (nf_util_adl_count > 3.5) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 157.55) => 
         map(
         (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 102.75) => 0.0581861796,
         (rv_A49_Curr_AVM_Chg_1yr_Pct > 102.75) => -0.0178563373,
         (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0093554827, 0.0093554827),
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 157.55) => 0.1394551881,
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 
         map(
         (NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 199056.5) => 
            map(
            (NULL < nf_rel_count and nf_rel_count <= 3.5) => -0.0564436031,
            (nf_rel_count > 3.5) => 0.0659603473,
            (nf_rel_count = NULL) => 0.0512879526, 0.0512879526),
         (nf_fp_prevaddrmedianvalue > 199056.5) => -0.0018403712,
         (nf_fp_prevaddrmedianvalue = NULL) => 0.0250550147, 0.0250550147), 0.0212853989),
   (nf_util_adl_count = NULL) => 0.0029326138, 0.0029326138);
   
   // Tree: 95 
   fp3_lexid_model_95 := map(
   (NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 
      map(
      (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 5.5) => 
         map(
         (NULL < rv_C21_stl_inq_Count180 and rv_C21_stl_inq_Count180 <= 0.5) => 
            map(
            (NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 8.5) => -0.0040868281,
            (rv_D32_criminal_count > 8.5) => 0.0606084499,
            (rv_D32_criminal_count = NULL) => -0.0034377116, -0.0034377116),
         (rv_C21_stl_inq_Count180 > 0.5) => -0.1760913623,
         (rv_C21_stl_inq_Count180 = NULL) => -0.0037419330, -0.0037419330),
      (nf_fp_idrisktype > 5.5) => 0.0979474148,
      (nf_fp_idrisktype = NULL) => -0.0031139896, -0.0031139896),
   (nf_fp_srchfraudsrchcountwk > 0.5) => 
      map(
      (NULL < rv_C13_max_lres and rv_C13_max_lres <= 28) => -0.1184285011,
      (rv_C13_max_lres > 28) => 0.0670552209,
      (rv_C13_max_lres = NULL) => 0.0526487182, 0.0526487182),
   (nf_fp_srchfraudsrchcountwk = NULL) => -0.0020749956, -0.0020749956);
   
   // Tree: 96 
   fp3_lexid_model_96 := map(
   (NULL < nf_dl_addrs_per_adl and nf_dl_addrs_per_adl <= 1.5) => 
      map(
      (NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 229.5) => 
         map(
         (NULL < nf_pb_retail_combo_cnt and nf_pb_retail_combo_cnt <= 10.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 36.5) => 
               map(
               (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.58927025355) => 0.0074115025,
               (nf_add_curr_nhood_MFD_pct > 0.58927025355) => -0.0373738331,
               (nf_add_curr_nhood_MFD_pct = NULL) => -0.0009925253, -0.0009925253),
            (rv_comb_age > 36.5) => 0.0153935637,
            (rv_comb_age = NULL) => 0.0081691657, 0.0081691657),
         (nf_pb_retail_combo_cnt > 10.5) => -0.0207798682,
         (nf_pb_retail_combo_cnt = NULL) => 0.0044860911, 0.0044860911),
      (rv_mos_since_br_first_seen > 229.5) => 0.0580920023,
      (rv_mos_since_br_first_seen = NULL) => 0.0058126990, 0.0058126990),
   (nf_dl_addrs_per_adl > 1.5) => -0.0150592766,
   (nf_dl_addrs_per_adl = NULL) => 0.0015707191, 0.0015707191);
   
   // Tree: 97 
   fp3_lexid_model_97 := map(
   (NULL < nf_current_count and nf_current_count <= 4.5) => -0.0001916319,
   (nf_current_count > 4.5) => 
      map(
      (NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 180.5) => 
         map(
         (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 24.5) => 0.1148720235,
         (nf_fp_curraddrmurderindex > 24.5) => 
            map(
            (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 36.5) => -0.0016054550,
            (rv_D33_Eviction_Recency > 36.5) => 0.1937570015,
            (rv_D33_Eviction_Recency = NULL) => 0.0046965598, 0.0046965598),
         (nf_fp_curraddrmurderindex = NULL) => 0.0248227744, 0.0248227744),
      (rv_mos_since_br_first_seen > 180.5) => 
         map(
         (NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 81) => 0.0132350552,
         (nf_fp_prevaddrburglaryindex > 81) => 0.2540493423,
         (nf_fp_prevaddrburglaryindex = NULL) => 0.1499134344, 0.1499134344),
      (rv_mos_since_br_first_seen = NULL) => 0.0329712857, 0.0329712857),
   (nf_current_count = NULL) => 0.0015121070, 0.0015121070);
   
   // Tree: 98 
   fp3_lexid_model_98 := map(
   (NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 0.5) => 
      map(
      (NULL < nf_average_rel_income and nf_average_rel_income <= 97500) => 0.0015719623,
      (nf_average_rel_income > 97500) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 337.5) => 
            map(
            (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 189) => -0.0163634117,
            (nf_fp_prevaddrcrimeindex > 189) => 0.2496428352,
            (nf_fp_prevaddrcrimeindex = NULL) => -0.0115526604, -0.0115526604),
         (nf_M_Bureau_ADL_FS_noTU > 337.5) => 
            map(
            (NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 156.5) => -0.0811783339,
            (nf_fp_prevaddrcartheftindex > 156.5) => 0.0734636039,
            (nf_fp_prevaddrcartheftindex = NULL) => -0.0673485671, -0.0673485671),
         (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0231258417, -0.0231258417),
      (nf_average_rel_income = NULL) => -0.0010928481, -0.0010928481),
   (nf_inq_Other_count_week > 0.5) => 0.1021208506,
   (nf_inq_Other_count_week = NULL) => -0.0004953737, -0.0004953737);
   
   // Tree: 99 
   fp3_lexid_model_99 := map(
   (NULL < rv_C13_max_lres and rv_C13_max_lres <= 107.5) => 
      map(
      (NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 143.5) => 
         map(
         (NULL < nf_inq_HighRiskCredit_count and nf_inq_HighRiskCredit_count <= 5.5) => -0.0196872484,
         (nf_inq_HighRiskCredit_count > 5.5) => 0.0600989438,
         (nf_inq_HighRiskCredit_count = NULL) => -0.0175184310, -0.0175184310),
      (nf_fp_prevaddrlenofres > 143.5) => 0.2410163193,
      (nf_fp_prevaddrlenofres = NULL) => -0.0163876065, -0.0163876065),
   (rv_C13_max_lres > 107.5) => 
      map(
      (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.88582527795) => 0.0034233629,
      (nf_add_curr_nhood_MFD_pct > 0.88582527795) => 
         map(
         (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 1.5) => 0.2510722454,
         (iv_prv_addr_lres > 1.5) => 0.0373886681,
         (iv_prv_addr_lres = NULL) => 0.0549643736, 0.0549643736),
      (nf_add_curr_nhood_MFD_pct = NULL) => 0.0050745145, 0.0050745145),
   (rv_C13_max_lres = NULL) => -0.0020264658, -0.0020264658);
   
   // Tree: 100 
   fp3_lexid_model_100 := map(
   (NULL < rv_S66_ssns_per_adl_c6 and rv_S66_ssns_per_adl_c6 <= 0.5) => 
      map(
      (NULL < nf_hh_age_65_plus and nf_hh_age_65_plus <= 1.5) => 
         map(
         (NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.5634920635) => -0.0014239863,
         (nf_hh_criminals_pct > 0.5634920635) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 74.45) => -0.0840269553,
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 74.45) => 
               map(
               (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 116) => 0.1907518113,
               (rv_C20_M_Bureau_ADL_FS > 116) => 0.0421534686,
               (rv_C20_M_Bureau_ADL_FS = NULL) => 0.0649256822, 0.0649256822),
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0105124169, 0.0312832606),
         (nf_hh_criminals_pct = NULL) => 0.0016599460, 0.0016599460),
      (nf_hh_age_65_plus > 1.5) => -0.0243940253,
      (nf_hh_age_65_plus = NULL) => -0.0012298894, -0.0012298894),
   (rv_S66_ssns_per_adl_c6 > 0.5) => 0.0828324263,
   (rv_S66_ssns_per_adl_c6 = NULL) => 0.0000246586, 0.0000246586);
   
   // Tree: 101 
   fp3_lexid_model_101 := map(
   (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 390.5) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 1204) => 
         map(
         (NULL < nf_inq_Collection_count24 and nf_inq_Collection_count24 <= 0.5) => 0.0027435151,
         (nf_inq_Collection_count24 > 0.5) => 
            map(
            (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 16.5) => 
               map(
               (NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.2403846154) => -0.0496486045,
               (nf_hh_lienholders_pct > 0.2403846154) => 0.0015984426,
               (nf_hh_lienholders_pct = NULL) => -0.0299081325, -0.0299081325),
            (nf_mos_inq_banko_om_fseen > 16.5) => 0.0427202269,
            (nf_mos_inq_banko_om_fseen = NULL) => -0.0220083789, -0.0220083789),
         (nf_inq_Collection_count24 = NULL) => -0.0005849460, -0.0005849460),
      (rv_A50_pb_average_dollars > 1204) => 0.1937684457,
      (rv_A50_pb_average_dollars = NULL) => -0.0002833754, -0.0002833754),
   (rv_C20_M_Bureau_ADL_FS > 390.5) => -0.0811643883,
   (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0010149331, -0.0010149331);
   
   // Tree: 102 
   fp3_lexid_model_102 := map(
   (NULL < rv_comb_age and rv_comb_age <= 88.5) => 
      map(
      (rv_A43_rec_vehx_level in ['W1','W2','XX']) => 
         map(
         (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 71546) => -0.0066070295,
         (nf_fp_curraddrmedianincome > 71546) => 
            map(
            (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 37.5) => -0.0166397713,
            (rv_C13_Curr_Addr_LRes > 37.5) => 0.0222836723,
            (rv_C13_Curr_Addr_LRes = NULL) => 0.0103473816, 0.0103473816),
         (nf_fp_curraddrmedianincome = NULL) => 0.0003495034, 0.0003495034),
      (rv_A43_rec_vehx_level in ['NA','AO','AW','W3']) => 
         map(
         (NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 246500) => -0.0009366790,
         (nf_average_rel_home_val > 246500) => 0.1488266777,
         (nf_average_rel_home_val = NULL) => 0.0754426329, 0.0754426329),
      (rv_A43_rec_vehx_level = '') => 0.0010319201, 0.0010319201),
   (rv_comb_age > 88.5) => 0.1024448641,
   (rv_comb_age = NULL) => 0.0014723672, 0.0014723672);
   
   // Tree: 103 
   fp3_lexid_model_103 := map(
   (NULL < census_mod and census_mod <= -1.63479941116187) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 75.5) => -0.0341781282,
      (rv_comb_age > 75.5) => -0.1414213713,
      (rv_comb_age = NULL) => -0.0377806144, -0.0377806144),
   (census_mod > -1.63479941116187) => 
      map(
      (NULL < nf_inq_RetailPayments_count24 and nf_inq_RetailPayments_count24 <= 0.5) => -0.0015316407,
      (nf_inq_RetailPayments_count24 > 0.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 363) => 0.0145432833,
         (nf_M_Bureau_ADL_FS_all > 363) => 
            map(
            (NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 45) => 0.1948160947,
            (nf_fp_prevaddrcartheftindex > 45) => 0.0463441622,
            (nf_fp_prevaddrcartheftindex = NULL) => 0.0849234832, 0.0849234832),
         (nf_M_Bureau_ADL_FS_all = NULL) => 0.0262426097, 0.0262426097),
      (nf_inq_RetailPayments_count24 = NULL) => 0.0005321141, 0.0005321141),
   (census_mod = NULL) => -0.0021500541, -0.0021500541);
   
   // Tree: 104 
   fp3_lexid_model_104 := map(
   (NULL < rv_C19_Add_Prison_Hist and rv_C19_Add_Prison_Hist <= 0.5) => 
      map(
      (NULL < nf_mos_inq_banko_om_lseen and nf_mos_inq_banko_om_lseen <= 38.5) => 
         map(
         (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 95.25) => -0.0222349283,
         (rv_A49_Curr_AVM_Chg_1yr_Pct > 95.25) => 
            map(
            (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 73584.5) => -0.0113702313,
            (nf_fp_curraddrmedianincome > 73584.5) => 
               map(
               (NULL < rv_D33_Eviction_Recency and rv_D33_Eviction_Recency <= 18) => 0.0175866459,
               (rv_D33_Eviction_Recency > 18) => 0.1251207798,
               (rv_D33_Eviction_Recency = NULL) => 0.0200598794, 0.0200598794),
            (nf_fp_curraddrmedianincome = NULL) => 0.0049549656, 0.0049549656),
         (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => -0.0019758482, -0.0017407043),
      (nf_mos_inq_banko_om_lseen > 38.5) => -0.1314540682,
      (nf_mos_inq_banko_om_lseen = NULL) => -0.0021406548, -0.0021406548),
   (rv_C19_Add_Prison_Hist > 0.5) => 0.1348005288,
   (rv_C19_Add_Prison_Hist = NULL) => -0.0017814567, -0.0017814567);
   
   // Tree: 105 
   fp3_lexid_model_105 := map(
   (rv_A41_A42_Prop_Owner_History in ['CURRENT','HISTORICAL']) => 
      map(
      (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 97.5) => -0.0118970174,
      (iv_prv_addr_lres > 97.5) => 0.0060191925,
      (iv_prv_addr_lres = NULL) => -0.0314923777, -0.0053519527),
   (rv_A41_A42_Prop_Owner_History in ['NA','NEVER']) => 
      map(
      (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.15932078615) => -0.0178681658,
      (nf_add_curr_nhood_SFD_pct > 0.15932078615) => 
         map(
         (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 
            map(
            (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 23.5) => 0.1108883634,
            (rv_C10_M_Hdr_FS > 23.5) => 0.0330565916,
            (rv_C10_M_Hdr_FS = NULL) => 0.0397115460, 0.0397115460),
         (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0385980957,
         (rv_C16_Inv_SSN_Per_ADL = NULL) => 0.0305638711, 0.0305638711),
      (nf_add_curr_nhood_SFD_pct = NULL) => 0.0155298417, 0.0155298417),
   (rv_A41_A42_Prop_Owner_History = '') => -0.0007094553, -0.0007094553);
   
   // Tree: 106 
   fp3_lexid_model_106 := map(
   (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 0.0172315562,
   (nf_hh_members_ct > 1.5) => 
      map(
      (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => 
         map(
         (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 711173) => -0.0104317969,
         (iv_prv_addr_avm_auto_val > 711173) => 0.0593621053,
         (iv_prv_addr_avm_auto_val = NULL) => -0.0322900034, -0.0106277315),
      (nf_fp_vardobcountnew > 0.5) => 
         map(
         (NULL < nf_current_count and nf_current_count <= 5.5) => 0.0087922293,
         (nf_current_count > 5.5) => 
            map(
            (NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 4.5) => 0.2827154633,
            (rv_I60_inq_recency > 4.5) => 0.0562270492,
            (rv_I60_inq_recency = NULL) => 0.1156338463, 0.1156338463),
         (nf_current_count = NULL) => 0.0123633737, 0.0123633737),
      (nf_fp_vardobcountnew = NULL) => -0.0059734035, -0.0059734035),
   (nf_hh_members_ct = NULL) => -0.0016896370, -0.0016896370);
   
   // Tree: 107 
   fp3_lexid_model_107 := map(
   (NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 2.5) => -0.0025581677,
   (nf_hh_collections_ct > 2.5) => 
      map(
      (NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.775) => 
         map(
         (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 85.5) => -0.0034425925,
         (nf_fp_curraddrmurderindex > 85.5) => 
            map(
            (NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 605000) => 
               map(
               (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 101.25) => 0.0835719930,
               (rv_A49_Curr_AVM_Chg_1yr_Pct > 101.25) => -0.0249004948,
               (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0548273315, 0.0390014631),
            (nf_average_rel_home_val > 605000) => 0.2212601681,
            (nf_average_rel_home_val = NULL) => 0.0466273503, 0.0466273503),
         (nf_fp_curraddrmurderindex = NULL) => 0.0187385314, 0.0187385314),
      (nf_hh_lienholders_pct > 0.775) => 0.2292520512,
      (nf_hh_lienholders_pct = NULL) => 0.0216249142, 0.0216249142),
   (nf_hh_collections_ct = NULL) => -0.0001652325, -0.0001652325);
   
   // Tree: 108 
   fp3_lexid_model_108 := map(
   (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 522.5) => 
      map(
      (NULL < iv_rv5_deceased and iv_rv5_deceased <= 0.5) => 
         map(
         (NULL < nf_mos_liens_unrel_OT_fseen and nf_mos_liens_unrel_OT_fseen <= 128.5) => 0.0003839508,
         (nf_mos_liens_unrel_OT_fseen > 128.5) => 
            map(
            (NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => 
               map(
               (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 122.05) => 0.1058980539,
               (rv_A49_Curr_AVM_Chg_1yr_Pct > 122.05) => 0.0101658143,
               (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => -0.0997371469, -0.0089548253),
            (rv_email_domain_ISP_count > 0.5) => -0.1195182119,
            (rv_email_domain_ISP_count = NULL) => -0.0650043199, -0.0650043199),
         (nf_mos_liens_unrel_OT_fseen = NULL) => -0.0004716522, -0.0004716522),
      (iv_rv5_deceased > 0.5) => 0.1512741164,
      (iv_rv5_deceased = NULL) => -0.0000042768, -0.0000042768),
   (rv_C20_M_Bureau_ADL_FS > 522.5) => -0.1729596361,
   (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0002702176, -0.0002702176);
   
   // Tree: 109 
   fp3_lexid_model_109 := map(
   (NULL < nf_inq_Auto_count and nf_inq_Auto_count <= 2.5) => 
      map(
      (NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 2.5) => 
         map(
         (NULL < nf_liens_unrel_FT_total_amt and nf_liens_unrel_FT_total_amt <= 131663.5) => 0.0000758567,
         (nf_liens_unrel_FT_total_amt > 131663.5) => 0.1638483235,
         (nf_liens_unrel_FT_total_amt = NULL) => 0.0003408103, 0.0003408103),
      (rv_I62_inq_addrs_per_adl > 2.5) => 
         map(
         (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 74.5) => 
            map(
            (NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 7.5) => 0.0392122308,
            (rv_I60_inq_hiRiskCred_count12 > 7.5) => -0.2883331100,
            (rv_I60_inq_hiRiskCred_count12 = NULL) => 0.0121423679, 0.0121423679),
         (rv_C13_Curr_Addr_LRes > 74.5) => 0.1225701294,
         (rv_C13_Curr_Addr_LRes = NULL) => 0.0567486558, 0.0567486558),
      (rv_I62_inq_addrs_per_adl = NULL) => 0.0014098788, 0.0014098788),
   (nf_inq_Auto_count > 2.5) => -0.0456110046,
   (nf_inq_Auto_count = NULL) => -0.0000573974, -0.0000573974);
   
   // Tree: 110 
   fp3_lexid_model_110 := map(
   (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 208.5) => 
      map(
      (NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.00870863455) => -0.0192579481,
      (nf_add_curr_nhood_BUS_pct > 0.00870863455) => 
         map(
         (NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 7.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 74.5) => -0.0020274303,
            (rv_comb_age > 74.5) => 0.0343871128,
            (rv_comb_age = NULL) => -0.0005519626, -0.0005519626),
         (nf_fp_assocsuspicousidcount > 7.5) => 0.0608155790,
         (nf_fp_assocsuspicousidcount = NULL) => 0.0006549974, 0.0006549974),
      (nf_add_curr_nhood_BUS_pct = NULL) => -0.0039936563, -0.0039936563),
   (rv_A50_pb_average_dollars > 208.5) => 
      map(
      (NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.3923076923) => 0.0160792101,
      (nf_pct_rel_with_criminal > 0.3923076923) => 0.1804475651,
      (nf_pct_rel_with_criminal = NULL) => 0.0409306590, 0.0409306590),
   (rv_A50_pb_average_dollars = NULL) => -0.0024617762, -0.0024617762);
   
   // Tree: 111 
   fp3_lexid_model_111 := map(
   (NULL < nf_mos_liens_unrel_FT_fseen and nf_mos_liens_unrel_FT_fseen <= 240.5) => 
      map(
      (NULL < nf_mos_liens_unrel_FT_fseen and nf_mos_liens_unrel_FT_fseen <= 44) => 
         map(
         (NULL < nf_mos_liens_unrel_FT_lseen and nf_mos_liens_unrel_FT_lseen <= 35.5) => 
            map(
            (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 539) => 
               map(
               (NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 5.5) => -0.0004644876,
               (nf_hh_tot_derog > 5.5) => 0.0448811137,
               (nf_hh_tot_derog = NULL) => 0.0008499382, 0.0008499382),
            (nf_M_Bureau_ADL_FS_all > 539) => -0.1012698248,
            (nf_M_Bureau_ADL_FS_all = NULL) => 0.0002706148, 0.0002706148),
         (nf_mos_liens_unrel_FT_lseen > 35.5) => 0.2924072662,
         (nf_mos_liens_unrel_FT_lseen = NULL) => 0.0005376745, 0.0005376745),
      (nf_mos_liens_unrel_FT_fseen > 44) => -0.0898999479,
      (nf_mos_liens_unrel_FT_fseen = NULL) => -0.0002896987, -0.0002896987),
   (nf_mos_liens_unrel_FT_fseen > 240.5) => 0.1526159287,
   (nf_mos_liens_unrel_FT_fseen = NULL) => -0.0000684170, -0.0000684170);
   
   // Tree: 112 
   fp3_lexid_model_112 := map(
   (NULL < nf_accident_count and nf_accident_count <= 1.5) => 
      map(
      (NULL < nf_inq_Banking_count24 and nf_inq_Banking_count24 <= 29) => 
         map(
         (NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 14.5) => 
            map(
            (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 1969260) => -0.0029535539,
            (iv_prv_addr_avm_auto_val > 1969260) => 0.2208319287,
            (iv_prv_addr_avm_auto_val = NULL) => -0.0001793727, -0.0025722044),
         (nf_fp_assocsuspicousidcount > 14.5) => 0.1250616655,
         (nf_fp_assocsuspicousidcount = NULL) => -0.0022187830, -0.0022187830),
      (nf_inq_Banking_count24 > 29) => -0.1847802896,
      (nf_inq_Banking_count24 = NULL) => -0.0024103298, -0.0024103298),
   (nf_accident_count > 1.5) => 
      map(
      (NULL < iv_br_source_count and iv_br_source_count <= 4.5) => 0.0392013041,
      (iv_br_source_count > 4.5) => -0.0859437117,
      (iv_br_source_count = NULL) => 0.0326377543, 0.0326377543),
   (nf_accident_count = NULL) => -0.0005970606, -0.0005970606);
   
   // Tree: 113 
   fp3_lexid_model_113 := map(
   (NULL < nf_inq_Mortgage_count24 and nf_inq_Mortgage_count24 <= 1.5) => 
      map(
      (NULL < nf_inq_Auto_count and nf_inq_Auto_count <= 2.5) => 
         map(
         (NULL < nf_mos_liens_unrel_O_fseen and nf_mos_liens_unrel_O_fseen <= 18.5) => 
            map(
            (NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 14.5) => 0.0032917337,
            (nf_fp_assocsuspicousidcount > 14.5) => 0.1631340485,
            (nf_fp_assocsuspicousidcount = NULL) => 0.0036112662, 0.0036112662),
         (nf_mos_liens_unrel_O_fseen > 18.5) => 0.2100452202,
         (nf_mos_liens_unrel_O_fseen = NULL) => 0.0038468093, 0.0038468093),
      (nf_inq_Auto_count > 2.5) => 
         map(
         (NULL < nf_hh_bankruptcies_pct and nf_hh_bankruptcies_pct <= 0.0871212121) => -0.0104528717,
         (nf_hh_bankruptcies_pct > 0.0871212121) => -0.1153313903,
         (nf_hh_bankruptcies_pct = NULL) => -0.0460203693, -0.0460203693),
      (nf_inq_Auto_count = NULL) => 0.0022629227, 0.0022629227),
   (nf_inq_Mortgage_count24 > 1.5) => -0.0681387249,
   (nf_inq_Mortgage_count24 = NULL) => 0.0010275826, 0.0010275826);
   
   // Tree: 114 
   fp3_lexid_model_114 := map(
   (NULL < iv_D34_liens_unrel_SC_ct and iv_D34_liens_unrel_SC_ct <= 4.5) => 
      map(
      (NULL < nf_fp_srchfraudsrchcountwk and nf_fp_srchfraudsrchcountwk <= 0.5) => 
         map(
         (NULL < iv_prop2_purch_sale_diff and iv_prop2_purch_sale_diff <= 277150) => -0.0255671378,
         (iv_prop2_purch_sale_diff > 277150) => 0.1207790603,
         (iv_prop2_purch_sale_diff = NULL) => 0.0011588122, 0.0011228043),
      (nf_fp_srchfraudsrchcountwk > 0.5) => 
         map(
         (NULL < rv_D34_attr_liens_recency and rv_D34_attr_liens_recency <= 30) => 0.0858940157,
         (rv_D34_attr_liens_recency > 30) => 
            map(
            (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.1627140975) => 0.0658727578,
            (nf_pct_rel_with_bk > 0.1627140975) => -0.1925846858,
            (nf_pct_rel_with_bk = NULL) => -0.0805864602, -0.0805864602),
         (rv_D34_attr_liens_recency = NULL) => 0.0590423261, 0.0590423261),
      (nf_fp_srchfraudsrchcountwk = NULL) => 0.0020982689, 0.0020982689),
   (iv_D34_liens_unrel_SC_ct > 4.5) => 0.2146476379,
   (iv_D34_liens_unrel_SC_ct = NULL) => 0.0023289665, 0.0023289665);
   
   // Tree: 115 
   fp3_lexid_model_115 := map(
   (NULL < rv_comb_age and rv_comb_age <= 56.5) => 
      map(
      (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 14.5) => -0.0059147032,
      (nf_fp_srchfraudsrchcount > 14.5) => 0.0643002723,
      (nf_fp_srchfraudsrchcount = NULL) => -0.0044876366, -0.0044876366),
   (rv_comb_age > 56.5) => 
      map(
      (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 92843.5) => 
         map(
         (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 5.5) => 0.0283666184,
         (iv_unverified_addr_count > 5.5) => 
            map(
            (NULL < nf_average_rel_home_val and nf_average_rel_home_val <= 541500) => -0.0229888606,
            (nf_average_rel_home_val > 541500) => 0.1385094213,
            (nf_average_rel_home_val = NULL) => -0.0133979665, -0.0133979665),
         (iv_unverified_addr_count = NULL) => 0.0179950136, 0.0179950136),
      (nf_fp_prevaddrmedianincome > 92843.5) => -0.0293434546,
      (nf_fp_prevaddrmedianincome = NULL) => 0.0098319234, 0.0098319234),
   (rv_comb_age = NULL) => -0.0011966773, -0.0011966773);
   
   // Tree: 116 
   fp3_lexid_model_116 := map(
   (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 102.5) => -0.0079395617,
   (rv_C13_Curr_Addr_LRes > 102.5) => 
      map(
      (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 9.5) => 
         map(
         (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 
            map(
            (NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 0.5) => 0.0069951251,
            (nf_inq_Other_count_week > 0.5) => 0.2411790626,
            (nf_inq_Other_count_week = NULL) => 0.0076035531, 0.0076035531),
         (nf_fp_varrisktype > 1.5) => 0.0558327211,
         (nf_fp_varrisktype = NULL) => 0.0121849272, 0.0121849272),
      (nf_fp_srchfraudsrchcount > 9.5) => 
         map(
         (NULL < nf_inq_Other_count and nf_inq_Other_count <= 4.5) => -0.1213455331,
         (nf_inq_Other_count > 4.5) => 0.0771219680,
         (nf_inq_Other_count = NULL) => -0.0726307828, -0.0726307828),
      (nf_fp_srchfraudsrchcount = NULL) => 0.0100465526, 0.0100465526),
   (rv_C13_Curr_Addr_LRes = NULL) => -0.0008411070, -0.0008411070);
   
   // Tree: 117 
   fp3_lexid_model_117 := map(
   (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 41667) => -0.0174687352,
   (nf_fp_curraddrmedianincome > 41667) => 
      map(
      (NULL < census_mod and census_mod <= -0.871754890051403) => -0.0030121492,
      (census_mod > -0.871754890051403) => 
         map(
         (NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 137.5) => 0.0058557267,
         (nf_fp_prevaddrlenofres > 137.5) => 
            map(
            (NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 5.5) => 
               map(
               (NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.1547619048) => -0.0852691651,
               (nf_pct_rel_prop_owned > 0.1547619048) => 0.0748179803,
               (nf_pct_rel_prop_owned = NULL) => 0.0642375081, 0.0642375081),
            (nf_hh_age_30_plus > 5.5) => -0.1193461208,
            (nf_hh_age_30_plus = NULL) => 0.0519329753, 0.0519329753),
         (nf_fp_prevaddrlenofres = NULL) => 0.0174371376, 0.0174371376),
      (census_mod = NULL) => 0.0003762766, 0.0003762766),
   (nf_fp_curraddrmedianincome = NULL) => -0.0030132426, -0.0030132426);
   
   // Tree: 118 
   fp3_lexid_model_118 := map(
   (NULL < rv_comb_age and rv_comb_age <= 86.5) => 
      map(
      (NULL < nf_mos_liens_rel_CJ_lseen and nf_mos_liens_rel_CJ_lseen <= 148) => 
         map(
         (NULL < nf_pb_retail_combo_cnt and nf_pb_retail_combo_cnt <= 0.5) => 0.0108156333,
         (nf_pb_retail_combo_cnt > 0.5) => -0.0067501856,
         (nf_pb_retail_combo_cnt = NULL) => -0.0010502007, -0.0010502007),
      (nf_mos_liens_rel_CJ_lseen > 148) => 
         map(
         (NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.03997846045) => 0.0022663167,
         (nf_add_curr_nhood_BUS_pct > 0.03997846045) => 
            map(
            (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 54598) => 0.4423200531,
            (nf_fp_prevaddrmedianincome > 54598) => 0.0869756750,
            (nf_fp_prevaddrmedianincome = NULL) => 0.2185847039, 0.2185847039),
         (nf_add_curr_nhood_BUS_pct = NULL) => 0.0949741970, 0.0949741970),
      (nf_mos_liens_rel_CJ_lseen = NULL) => -0.0004982357, -0.0004982357),
   (rv_comb_age > 86.5) => 0.0583532023,
   (rv_comb_age = NULL) => -0.0000136206, -0.0000136206);
   
   // Tree: 119 
   fp3_lexid_model_119 := map(
   (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.3798076923) => 
      map(
      (NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 227) => 
         map(
         (NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 206.5) => 
            map(
            (NULL < census_mod and census_mod <= 0.360253419816201) => 
               map(
               (NULL < nf_historical_count and nf_historical_count <= 14.5) => -0.0026941084,
               (nf_historical_count > 14.5) => 0.0564816303,
               (nf_historical_count = NULL) => -0.0019071110, -0.0019071110),
            (census_mod > 0.360253419816201) => 0.1350642933,
            (census_mod = NULL) => -0.0016828944, -0.0016828944),
         (rv_D32_Mos_Since_Fel_LS > 206.5) => 0.2044123956,
         (rv_D32_Mos_Since_Fel_LS = NULL) => -0.0014956372, -0.0014956372),
      (rv_D32_Mos_Since_Fel_LS > 227) => -0.1542922687,
      (rv_D32_Mos_Since_Fel_LS = NULL) => -0.0017312847, -0.0017312847),
   (nf_pct_rel_with_felony > 0.3798076923) => 0.1231932627,
   (nf_pct_rel_with_felony = NULL) => -0.0013584094, -0.0013584094);
   
   // Tree: 120 
   fp3_lexid_model_120 := map(
   (NULL < nf_mos_foreclosure_lseen and nf_mos_foreclosure_lseen <= 55) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 29.5) => 
         map(
         (NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.3798076923) => -0.0166234294,
         (nf_hh_lienholders_pct > 0.3798076923) => 
            map(
            (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 20749.5) => -0.0641613531,
            (nf_fp_prevaddrmedianincome > 20749.5) => 0.0793258531,
            (nf_fp_prevaddrmedianincome = NULL) => 0.0596850188, 0.0596850188),
         (nf_hh_lienholders_pct = NULL) => -0.0092721027, -0.0092721027),
      (rv_comb_age > 29.5) => 
         map(
         (NULL < nf_mos_liens_unrel_CJ_fseen and nf_mos_liens_unrel_CJ_fseen <= 234.5) => 0.0040180928,
         (nf_mos_liens_unrel_CJ_fseen > 234.5) => -0.0920985046,
         (nf_mos_liens_unrel_CJ_fseen = NULL) => 0.0033800224, 0.0033800224),
      (rv_comb_age = NULL) => 0.0002442710, 0.0002442710),
   (nf_mos_foreclosure_lseen > 55) => -0.1408957824,
   (nf_mos_foreclosure_lseen = NULL) => -0.0002153022, -0.0002153022);
   
   // Tree: 121 
   fp3_lexid_model_121 := map(
   (NULL < nf_liens_rel_OT_total_amt and nf_liens_rel_OT_total_amt <= 3794) => 
      map(
      (NULL < nf_inq_Utilities_count24 and nf_inq_Utilities_count24 <= 1.5) => 
         map(
         (NULL < rv_C12_source_profile and rv_C12_source_profile <= 91.25) => 
            map(
            (NULL < nf_current_count and nf_current_count <= 6.5) => 0.0005453110,
            (nf_current_count > 6.5) => 
               map(
               (NULL < rv_comb_age and rv_comb_age <= 56.5) => 0.0111836532,
               (rv_comb_age > 56.5) => 0.1393980557,
               (rv_comb_age = NULL) => 0.0546001705, 0.0546001705),
            (nf_current_count = NULL) => 0.0014778869, 0.0014778869),
         (rv_C12_source_profile > 91.25) => -0.1136108367,
         (rv_C12_source_profile = NULL) => 0.0010904885, 0.0010904885),
      (nf_inq_Utilities_count24 > 1.5) => 0.2197291936,
      (nf_inq_Utilities_count24 = NULL) => 0.0013090676, 0.0013090676),
   (nf_liens_rel_OT_total_amt > 3794) => -0.1104148365,
   (nf_liens_rel_OT_total_amt = NULL) => 0.0007734881, 0.0007734881);
   
   // Tree: 122 
   fp3_lexid_model_122 := map(
   (NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 302) => 
      map(
      (NULL < rv_C12_source_profile and rv_C12_source_profile <= 91.25) => 
         map(
         (NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 853520) => 
            map(
            (NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 843296.5) => 
               map(
               (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => -0.0026996266,
               (nf_fp_vardobcountnew > 0.5) => 0.0141787495,
               (nf_fp_vardobcountnew = NULL) => 0.0011069199, 0.0011069199),
            (nf_fp_prevaddrmedianvalue > 843296.5) => 0.2039349975,
            (nf_fp_prevaddrmedianvalue = NULL) => 0.0013301759, 0.0013301759),
         (nf_fp_prevaddrmedianvalue > 853520) => -0.0679390081,
         (nf_fp_prevaddrmedianvalue = NULL) => 0.0006506962, 0.0006506962),
      (rv_C12_source_profile > 91.25) => -0.1247746983,
      (rv_C12_source_profile = NULL) => 0.0003098663, 0.0003098663),
   (nf_mos_acc_lseen > 302) => 0.1642202048,
   (nf_mos_acc_lseen = NULL) => 0.0005470737, 0.0005470737);
   
   // Tree: 123 
   fp3_lexid_model_123 := map(
   (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 39697) => -0.0162288603,
   (nf_fp_curraddrmedianincome > 39697) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 83.5) => 
         map(
         (NULL < census_mod and census_mod <= -1.48119098835089) => -0.0236477287,
         (census_mod > -1.48119098835089) => 
            map(
            (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 183.5) => 
               map(
               (NULL < nf_liens_unrel_SC_total_amt and nf_liens_unrel_SC_total_amt <= 7765) => 0.0046906195,
               (nf_liens_unrel_SC_total_amt > 7765) => 0.2471085963,
               (nf_liens_unrel_SC_total_amt = NULL) => 0.0051064902, 0.0051064902),
            (nf_fp_prevaddrcrimeindex > 183.5) => 0.0583878567,
            (nf_fp_prevaddrcrimeindex = NULL) => 0.0072345272, 0.0072345272),
         (census_mod = NULL) => 0.0010350397, 0.0010350397),
      (rv_comb_age > 83.5) => 0.0592381912,
      (rv_comb_age = NULL) => 0.0017725864, 0.0017725864),
   (nf_fp_curraddrmedianincome = NULL) => -0.0011940051, -0.0011940051);
   
   // Tree: 124 
   fp3_lexid_model_124 := map(
   (NULL < nf_mos_liens_rel_OT_lseen and nf_mos_liens_rel_OT_lseen <= 55.5) => 
      map(
      (NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 10.5) => 
         map(
         (NULL < rv_F04_curr_add_occ_index and rv_F04_curr_add_occ_index <= 2) => -0.0052028960,
         (rv_F04_curr_add_occ_index > 2) => 
            map(
            (NULL < nf_accident_count and nf_accident_count <= 4.5) => 0.0112231479,
            (nf_accident_count > 4.5) => 0.2894449375,
            (nf_accident_count = NULL) => 0.0126640328, 0.0126640328),
         (rv_F04_curr_add_occ_index = NULL) => -0.0016893920, -0.0016893920),
      (rv_D32_criminal_count > 10.5) => 0.0919732038,
      (rv_D32_criminal_count = NULL) => -0.0010606683, -0.0010606683),
   (nf_mos_liens_rel_OT_lseen > 55.5) => 
      map(
      (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 73280) => 0.1246782814,
      (nf_fp_curraddrmedianvalue > 73280) => -0.0720847280,
      (nf_fp_curraddrmedianvalue = NULL) => -0.0557784012, -0.0557784012),
   (nf_mos_liens_rel_OT_lseen = NULL) => -0.0019564634, -0.0019564634);
   
   // Tree: 125 
   fp3_lexid_model_125 := map(
   (NULL < rv_comb_age and rv_comb_age <= 21.5) => 
      map(
      (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 45.5) => 
         map(
         (NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.31666666665) => -0.0583636680,
         (nf_hh_lienholders_pct > 0.31666666665) => 0.1903343654,
         (nf_hh_lienholders_pct = NULL) => -0.0313557368, -0.0313557368),
      (nf_fp_curraddrburglaryindex > 45.5) => 
         map(
         (NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.59166666665) => 
            map(
            (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 65.5) => 0.0672855308,
            (nf_M_Bureau_ADL_FS_noTU > 65.5) => 0.2218249981,
            (nf_M_Bureau_ADL_FS_noTU = NULL) => 0.0805463432, 0.0805463432),
         (nf_pct_rel_prop_owned > 0.59166666665) => -0.0099217736,
         (nf_pct_rel_prop_owned = NULL) => 0.0529494176, 0.0529494176),
      (nf_fp_curraddrburglaryindex = NULL) => 0.0245910628, 0.0245910628),
   (rv_comb_age > 21.5) => 0.0023973459,
   (rv_comb_age = NULL) => 0.0037167986, 0.0037167986);
   
   // Tree: 126 
   fp3_lexid_model_126 := map(
   (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 41995.5) => 
      map(
      (NULL < nf_mos_liens_unrel_CJ_fseen and nf_mos_liens_unrel_CJ_fseen <= 51.5) => 
         map(
         (NULL < nf_average_rel_distance and nf_average_rel_distance <= 596) => 0.0661488453,
         (nf_average_rel_distance > 596) => -0.0172195037,
         (nf_average_rel_distance = NULL) => -0.0129677179, -0.0129677179),
      (nf_mos_liens_unrel_CJ_fseen > 51.5) => -0.0884186944,
      (nf_mos_liens_unrel_CJ_fseen = NULL) => -0.0167653454, -0.0167653454),
   (nf_fp_curraddrmedianincome > 41995.5) => 
      map(
      (NULL < census_mod and census_mod <= -0.894628199721465) => 0.0006860541,
      (census_mod > -0.894628199721465) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 413.5) => 0.0269570853,
         (nf_M_Bureau_ADL_FS_all > 413.5) => -0.0396945818,
         (nf_M_Bureau_ADL_FS_all = NULL) => 0.0214931501, 0.0214931501),
      (census_mod = NULL) => 0.0044011088, 0.0044011088),
   (nf_fp_curraddrmedianincome = NULL) => 0.0003692209, 0.0003692209);
   
   // Tree: 127 
   fp3_lexid_model_127 := map(
   (NULL < rv_comb_age and rv_comb_age <= 16.5) => 0.1789177911,
   (rv_comb_age > 16.5) => 
      map(
      (NULL < census_mod and census_mod <= 0.382219286017205) => 
         map(
         (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 1.5) => 
            map(
            (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.12679444445) => -0.0179363097,
            (nf_add_curr_nhood_VAC_pct > 0.12679444445) => 
               map(
               (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 13.5) => 0.0232191871,
               (nf_mos_inq_banko_om_fseen > 13.5) => 0.2202086138,
               (nf_mos_inq_banko_om_fseen = NULL) => 0.0330686585, 0.0330686585),
            (nf_add_curr_nhood_VAC_pct = NULL) => -0.0134725545, -0.0134725545),
         (iv_unverified_addr_count > 1.5) => 0.0032602962,
         (iv_unverified_addr_count = NULL) => -0.0026381817, -0.0026381817),
      (census_mod > 0.382219286017205) => 0.1584218341,
      (census_mod = NULL) => -0.0024046979, -0.0024046979),
   (rv_comb_age = NULL) => -0.0021749889, -0.0021749889);
   
   // Tree: 128 
   fp3_lexid_model_128 := map(
   (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 500.5) => 
      map(
      (iv_pb_profile in ['2 ONLINE SHOPPER','4 OTHER']) => 
         map(
         (NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 6.5) => 
            map(
            (NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 0.5) => 
               map(
               (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 108.5) => -0.0462712340,
               (nf_fp_prevaddrageoldest > 108.5) => -0.0030720282,
               (nf_fp_prevaddrageoldest = NULL) => -0.0243262743, -0.0243262743),
            (rv_I60_inq_hiRiskCred_count12 > 0.5) => 0.0837158546,
            (rv_I60_inq_hiRiskCred_count12 = NULL) => -0.0218663865, -0.0218663865),
         (rv_I60_inq_hiRiskCred_count12 > 6.5) => -0.2097639308,
         (rv_I60_inq_hiRiskCred_count12 = NULL) => -0.0231162593, -0.0231162593),
      (iv_pb_profile in ['NA','0 NO PURCH DATA','1 OFFLINE SHOPPER','3 RETAIL SHOPPER']) => 0.0014169542,
      (iv_pb_profile = '') => -0.0036105264, -0.0036105264),
   (nf_fp_prevaddrageoldest > 500.5) => 0.1038716937,
   (nf_fp_prevaddrageoldest = NULL) => -0.0031050022, -0.0031050022);
   
   // Tree: 129 
   fp3_lexid_model_129 := map(
   (NULL < nf_pb_retail_combo_cnt and nf_pb_retail_combo_cnt <= 0.5) => 
      map(
      (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.3818181818) => 0.0088527284,
      (nf_pct_rel_with_felony > 0.3818181818) => 0.1718323628,
      (nf_pct_rel_with_felony = NULL) => 0.0096200100, 0.0096200100),
   (nf_pb_retail_combo_cnt > 0.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 370.5) => 
         map(
         (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 368.5) => -0.0111132522,
         (rv_C20_M_Bureau_ADL_FS > 368.5) => -0.1198183414,
         (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0123408745, -0.0123408745),
      (nf_M_Bureau_ADL_FS_all > 370.5) => 
         map(
         (NULL < nf_mos_inq_banko_am_lseen and nf_mos_inq_banko_am_lseen <= 77) => 0.0127392547,
         (nf_mos_inq_banko_am_lseen > 77) => 0.2531630621,
         (nf_mos_inq_banko_am_lseen = NULL) => 0.0152306932, 0.0152306932),
      (nf_M_Bureau_ADL_FS_all = NULL) => -0.0080523754, -0.0080523754),
   (nf_pb_retail_combo_cnt = NULL) => -0.0022803979, -0.0022803979);
   
   // Tree: 130 
   fp3_lexid_model_130 := map(
   (NULL < rv_C21_stl_inq_Count180 and rv_C21_stl_inq_Count180 <= 0.5) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 1204) => 
         map(
         (NULL < rv_D34_attr_liens_recency and rv_D34_attr_liens_recency <= 18) => 0.0035080837,
         (rv_D34_attr_liens_recency > 18) => 
            map(
            (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 21301.5) => -0.1417194647,
            (nf_fp_curraddrmedianincome > 21301.5) => 
               map(
               (NULL < iv_prop2_purch_sale_diff and iv_prop2_purch_sale_diff <= 62796) => -0.0889145798,
               (iv_prop2_purch_sale_diff > 62796) => 0.1937310810,
               (iv_prop2_purch_sale_diff = NULL) => -0.0155197834, -0.0144256406),
            (nf_fp_curraddrmedianincome = NULL) => -0.0172655291, -0.0172655291),
         (rv_D34_attr_liens_recency = NULL) => 0.0006362599, 0.0006362599),
      (rv_A50_pb_average_dollars > 1204) => 0.1554870139,
      (rv_A50_pb_average_dollars = NULL) => 0.0008606813, 0.0008606813),
   (rv_C21_stl_inq_Count180 > 0.5) => -0.2309952402,
   (rv_C21_stl_inq_Count180 = NULL) => 0.0005251445, 0.0005251445);
   
   // Tree: 131 
   fp3_lexid_model_131 := map(
   (NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.23431372545) => 
      map(
      (NULL < rv_D34_unrel_liens_ct and rv_D34_unrel_liens_ct <= 1.5) => 
         map(
         (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 315.5) => 0.0178442448,
         (iv_prv_addr_lres > 315.5) => 0.0889425867,
         (iv_prv_addr_lres = NULL) => 0.0699057169, 0.0262162139),
      (rv_D34_unrel_liens_ct > 1.5) => -0.0710683994,
      (rv_D34_unrel_liens_ct = NULL) => 0.0193531902, 0.0193531902),
   (nf_pct_rel_prop_owned > 0.23431372545) => 
      map(
      (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 735000) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 2.5) => 0.1780178021,
         (nf_M_Bureau_ADL_FS_noTU > 2.5) => -0.0014555307,
         (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0010759161, -0.0010759161),
      (iv_prv_addr_avm_auto_val > 735000) => 0.0600009585,
      (iv_prv_addr_avm_auto_val = NULL) => -0.0259154627, -0.0012326302),
   (nf_pct_rel_prop_owned = NULL) => 0.0023832945, 0.0023832945);
   
   // Tree: 132 
   fp3_lexid_model_132 := map(
   (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 0.5) => 
      map(
      (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 8018.5) => 
         map(
         (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.7742637898) => 
            map(
            (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.83031415165) => -0.0606785204,
            (nf_add_curr_nhood_SFD_pct > 0.83031415165) => 
               map(
               (NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.0459460796) => 0.0014035858,
               (nf_add_curr_nhood_BUS_pct > 0.0459460796) => 0.2994218658,
               (nf_add_curr_nhood_BUS_pct = NULL) => 0.1106769551, 0.1106769551),
            (nf_add_curr_nhood_SFD_pct = NULL) => 0.0052274317, 0.0052274317),
         (nf_add_curr_nhood_MFD_pct > 0.7742637898) => 0.1960693485,
         (nf_add_curr_nhood_MFD_pct = NULL) => 0.0342685930, 0.0342685930),
      (rv_A46_Curr_AVM_AutoVal > 8018.5) => 0.2190312256,
      (rv_A46_Curr_AVM_AutoVal = NULL) => 0.0724953446, 0.0724953446),
   (rv_C13_attr_addrs_recency > 0.5) => 0.0008688706,
   (rv_C13_attr_addrs_recency = NULL) => 0.0016203785, 0.0016203785);
   
   // Tree: 133 
   fp3_lexid_model_133 := map(
   (NULL < rv_comb_age and rv_comb_age <= 92.5) => 
      map(
      (NULL < nf_mos_inq_banko_om_lseen and nf_mos_inq_banko_om_lseen <= 32.5) => -0.0037807509,
      (nf_mos_inq_banko_om_lseen > 32.5) => 
         map(
         (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.00359321145) => -0.0685452104,
         (nf_add_curr_nhood_MFD_pct > 0.00359321145) => 
            map(
            (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 94) => 
               map(
               (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 146.5) => 0.1032846473,
               (iv_prv_addr_lres > 146.5) => 0.3086256577,
               (iv_prv_addr_lres = NULL) => 0.1611271854, 0.1611271854),
            (nf_fp_curraddrmurderindex > 94) => 0.0081866663,
            (nf_fp_curraddrmurderindex = NULL) => 0.0967950623, 0.0967950623),
         (nf_add_curr_nhood_MFD_pct = NULL) => 0.0525761522, 0.0525761522),
      (nf_mos_inq_banko_om_lseen = NULL) => -0.0029026472, -0.0029026472),
   (rv_comb_age > 92.5) => 0.1476533974,
   (rv_comb_age = NULL) => -0.0027391622, -0.0027391622);
   
   // Tree: 134 
   fp3_lexid_model_134 := map(
   (NULL < iv_D57_attr_proflic_recency and iv_D57_attr_proflic_recency <= 79.5) => 0.0012882427,
   (iv_D57_attr_proflic_recency > 79.5) => 
      map(
      (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 180) => 
         map(
         (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 68235.5) => 
            map(
            (NULL < nf_rel_felony_count and nf_rel_felony_count <= 0.5) => 
               map(
               (NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.91883116885) => 0.0429687030,
               (nf_pct_rel_prop_owned > 0.91883116885) => 0.2972056657,
               (nf_pct_rel_prop_owned = NULL) => 0.0882782607, 0.0882782607),
            (nf_rel_felony_count > 0.5) => 0.2715744522,
            (nf_rel_felony_count = NULL) => 0.1246465527, 0.1246465527),
         (rv_A46_Curr_AVM_AutoVal > 68235.5) => 0.0331368427,
         (rv_A46_Curr_AVM_AutoVal = NULL) => 0.0677621383, 0.0677621383),
      (iv_prv_addr_lres > 180) => -0.0202456261,
      (iv_prv_addr_lres = NULL) => 0.0436031442, 0.0436031442),
   (iv_D57_attr_proflic_recency = NULL) => 0.0030641213, 0.0030641213);
   
   // Tree: 135 
   fp3_lexid_model_135 := map(
   (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 63856.5) => -0.0078929961,
   (nf_fp_curraddrmedianincome > 63856.5) => 
      map(
      (NULL < nf_inq_HighRiskCredit_count24 and nf_inq_HighRiskCredit_count24 <= 1.5) => 
         map(
         (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.51470588235) => 0.0059322243,
         (nf_pct_rel_with_bk > 0.51470588235) => 
            map(
            (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 34.5) => 0.2716481165,
            (nf_fp_prevaddrcrimeindex > 34.5) => 0.0125634183,
            (nf_fp_prevaddrcrimeindex = NULL) => 0.1303291902, 0.1303291902),
         (nf_pct_rel_with_bk = NULL) => 0.0071520198, 0.0071520198),
      (nf_inq_HighRiskCredit_count24 > 1.5) => 
         map(
         (NULL < nf_rel_count and nf_rel_count <= 5.5) => -0.0861174288,
         (nf_rel_count > 5.5) => 0.1129905118,
         (nf_rel_count = NULL) => 0.0822192846, 0.0822192846),
      (nf_inq_HighRiskCredit_count24 = NULL) => 0.0085958735, 0.0085958735),
   (nf_fp_curraddrmedianincome = NULL) => 0.0006362953, 0.0006362953);
   
   // Tree: 136 
   fp3_lexid_model_136 := map(
   (NULL < nf_hh_payday_loan_users and nf_hh_payday_loan_users <= 0.5) => -0.0020268157,
   (nf_hh_payday_loan_users > 0.5) => 
      map(
      (NULL < nf_accident_recency and nf_accident_recency <= 9) => 
         map(
         (NULL < census_mod and census_mod <= -0.871569842080652) => 0.0204636597,
         (census_mod > -0.871569842080652) => 
            map(
            (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 101) => 0.1292610789,
            (nf_fp_curraddrburglaryindex > 101) => 
               map(
               (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 2.5) => -0.0531064184,
               (nf_fp_srchvelocityrisktype > 2.5) => 0.0919694587,
               (nf_fp_srchvelocityrisktype = NULL) => 0.0406926400, 0.0406926400),
            (nf_fp_curraddrburglaryindex = NULL) => 0.0778913844, 0.0778913844),
         (census_mod = NULL) => 0.0345563529, 0.0345563529),
      (nf_accident_recency > 9) => -0.0248865275,
      (nf_accident_recency = NULL) => 0.0204748466, 0.0204748466),
   (nf_hh_payday_loan_users = NULL) => 0.0001468253, 0.0001468253);
   
   // Tree: 137 
   fp3_lexid_model_137 := map(
   (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 147.5) => 
      map(
      (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 3.5) => 
         map(
         (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 83) => 0.0770430218,
         (iv_prv_addr_lres > 83) => -0.1200090367,
         (iv_prv_addr_lres = NULL) => 
            map(
            (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 18.5) => 0.0212590224,
            (rv_A50_pb_average_dollars > 18.5) => -0.0887358759,
            (rv_A50_pb_average_dollars = NULL) => -0.0020784287, -0.0020784287), 0.0186632161),
      (nf_fp_prevaddrageoldest > 3.5) => -0.0084834244,
      (nf_fp_prevaddrageoldest = NULL) => -0.0055673401, -0.0055673401),
   (nf_fp_prevaddrcrimeindex > 147.5) => 
      map(
      (NULL < nf_fp_assocrisktype and nf_fp_assocrisktype <= 8.5) => 0.0156324168,
      (nf_fp_assocrisktype > 8.5) => 0.1441878200,
      (nf_fp_assocrisktype = NULL) => 0.0183608879, 0.0183608879),
   (nf_fp_prevaddrcrimeindex = NULL) => -0.0011825183, -0.0011825183);
   
   // Tree: 138 
   fp3_lexid_model_138 := map(
   (NULL < nf_hh_prof_license_holders_pct and nf_hh_prof_license_holders_pct <= 0.70833333335) => 
      map(
      (NULL < nf_mos_liens_unrel_CJ_lseen and nf_mos_liens_unrel_CJ_lseen <= 136.5) => -0.0017976155,
      (nf_mos_liens_unrel_CJ_lseen > 136.5) => 
         map(
         (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 43.5) => 
            map(
            (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.032650102) => -0.0067863742,
            (nf_add_curr_nhood_MFD_pct > 0.032650102) => 0.2284419435,
            (nf_add_curr_nhood_MFD_pct = NULL) => 0.1625780145, 0.1625780145),
         (iv_prv_addr_lres > 43.5) => 
            map(
            (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 42.5) => -0.1006220924,
            (nf_fp_curraddrmurderindex > 42.5) => 0.0636930628,
            (nf_fp_curraddrmurderindex = NULL) => 0.0097771525, 0.0097771525),
         (iv_prv_addr_lres = NULL) => 0.0526987430, 0.0526987430),
      (nf_mos_liens_unrel_CJ_lseen = NULL) => -0.0008889244, -0.0008889244),
   (nf_hh_prof_license_holders_pct > 0.70833333335) => -0.0600384352,
   (nf_hh_prof_license_holders_pct = NULL) => -0.0019642728, -0.0019642728);
   
   // Tree: 139 
   fp3_lexid_model_139 := map(
   (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 2.5) => -0.0057373287,
   (nf_fp_srchfraudsrchcount > 2.5) => 
      map(
      (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 313.5) => 0.0240054995,
      (rv_C20_M_Bureau_ADL_FS > 313.5) => 
         map(
         (NULL < nf_fp_varmsrcssncount and nf_fp_varmsrcssncount <= 1.5) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 103.35) => 
               map(
               (NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 92957) => 0.2217786922,
               (nf_fp_prevaddrmedianvalue > 92957) => 0.0152155305,
               (nf_fp_prevaddrmedianvalue = NULL) => 0.0455924660, 0.0455924660),
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 103.35) => -0.0396937426,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => -0.0360336668, -0.0210267818),
         (nf_fp_varmsrcssncount > 1.5) => 0.1440254713,
         (nf_fp_varmsrcssncount = NULL) => -0.0141626049, -0.0141626049),
      (rv_C20_M_Bureau_ADL_FS = NULL) => 0.0143861916, 0.0143861916),
   (nf_fp_srchfraudsrchcount = NULL) => -0.0019168449, -0.0019168449);
   
   // Tree: 140 
   fp3_lexid_model_140 := map(
   (NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 1.5) => 
      map(
      (NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 9.5) => 
         map(
         (NULL < nf_liens_rel_CJ_total_amt and nf_liens_rel_CJ_total_amt <= 2408) => -0.0064026189,
         (nf_liens_rel_CJ_total_amt > 2408) => -0.0999322117,
         (nf_liens_rel_CJ_total_amt = NULL) => -0.0072694723, -0.0072694723),
      (nf_hh_age_18_plus > 9.5) => 
         map(
         (NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 0.5) => 0.2310711201,
         (rv_I60_inq_recency > 0.5) => 
            map(
            (NULL < nf_average_rel_age and nf_average_rel_age <= 36.5) => -0.1253202016,
            (nf_average_rel_age > 36.5) => 0.1594492566,
            (nf_average_rel_age = NULL) => 0.0170645275, 0.0170645275),
         (rv_I60_inq_recency = NULL) => 0.0953596224, 0.0953596224),
      (nf_hh_age_18_plus = NULL) => -0.0066906837, -0.0066906837),
   (nf_fp_assocsuspicousidcount > 1.5) => 0.0091123840,
   (nf_fp_assocsuspicousidcount = NULL) => -0.0012791050, -0.0012791050);
   
   // Tree: 141 
   fp3_lexid_model_141 := map(
   (NULL < nf_inq_count and nf_inq_count <= 22.5) => 
      map(
      (NULL < nf_dl_addrs_per_adl and nf_dl_addrs_per_adl <= 0.5) => 
         map(
         (NULL < nf_mos_liens_unrel_CJ_fseen and nf_mos_liens_unrel_CJ_fseen <= 168) => 
            map(
            (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 35) => 0.0075798114,
            (nf_fp_srchfraudsrchcount > 35) => -0.2586854515,
            (nf_fp_srchfraudsrchcount = NULL) => 0.0071486126, 0.0071486126),
         (nf_mos_liens_unrel_CJ_fseen > 168) => 0.0831801834,
         (nf_mos_liens_unrel_CJ_fseen = NULL) => 0.0083960245, 0.0083960245),
      (nf_dl_addrs_per_adl > 0.5) => 
         map(
         (NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 5.5) => -0.0061333476,
         (nf_hh_collections_ct > 5.5) => -0.1387502638,
         (nf_hh_collections_ct = NULL) => -0.0068992635, -0.0068992635),
      (nf_dl_addrs_per_adl = NULL) => 0.0018676331, 0.0018676331),
   (nf_inq_count > 22.5) => -0.0810968926,
   (nf_inq_count = NULL) => 0.0010947183, 0.0010947183);
   
   // Tree: 142 
   fp3_lexid_model_142 := map(
   (NULL < rv_I60_inq_other_recency and rv_I60_inq_other_recency <= 0.5) => -0.0027126214,
   (rv_I60_inq_other_recency > 0.5) => 
      map(
      (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 39.5) => 
         map(
         (NULL < nf_average_rel_age and nf_average_rel_age <= 31.5) => -0.1247624576,
         (nf_average_rel_age > 31.5) => 
            map(
            (NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.2249293458) => -0.0089701328,
            (nf_add_curr_nhood_BUS_pct > 0.2249293458) => 0.1158987401,
            (nf_add_curr_nhood_BUS_pct = NULL) => -0.0021865120, -0.0021865120),
         (nf_average_rel_age = NULL) => -0.0107863211, -0.0107863211),
      (rv_C13_Curr_Addr_LRes > 39.5) => 
         map(
         (NULL < nf_rel_criminal_count and nf_rel_criminal_count <= 10.5) => 0.0338566617,
         (nf_rel_criminal_count > 10.5) => -0.0788775430,
         (nf_rel_criminal_count = NULL) => 0.0302616480, 0.0302616480),
      (rv_C13_Curr_Addr_LRes = NULL) => 0.0141941713, 0.0141941713),
   (rv_I60_inq_other_recency = NULL) => 0.0014636133, 0.0014636133);
   
   // Tree: 143 
   fp3_lexid_model_143 := map(
   (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 435.5) => 
      map(
      (NULL < rv_C21_stl_inq_Count180 and rv_C21_stl_inq_Count180 <= 0.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 426.5) => -0.0015290902,
         (nf_M_Bureau_ADL_FS_all > 426.5) => -0.0873271537,
         (nf_M_Bureau_ADL_FS_all = NULL) => -0.0021479241, -0.0021479241),
      (rv_C21_stl_inq_Count180 > 0.5) => -0.1761168242,
      (rv_C21_stl_inq_Count180 = NULL) => -0.0024775043, -0.0024775043),
   (nf_M_Bureau_ADL_FS_all > 435.5) => 
      map(
      (NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 7.5) => 
         map(
         (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 124722) => 0.1114285772,
         (nf_fp_curraddrmedianvalue > 124722) => 0.0283149110,
         (nf_fp_curraddrmedianvalue = NULL) => 0.0434921892, 0.0434921892),
      (iv_C14_addrs_per_adl > 7.5) => -0.0847008502,
      (iv_C14_addrs_per_adl = NULL) => 0.0334730940, 0.0334730940),
   (nf_M_Bureau_ADL_FS_all = NULL) => -0.0008549149, -0.0008549149);
   
   // Tree: 144 
   fp3_lexid_model_144 := map(
   (NULL < iv_prof_license_category_PL and iv_prof_license_category_PL <= 4.5) => -0.0172917466,
   (iv_prof_license_category_PL > 4.5) => 
      map(
      (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.13392857145) => 
         map(
         (NULL < nf_hh_prof_license_holders_pct and nf_hh_prof_license_holders_pct <= 0.29166666665) => 0.2455360306,
         (nf_hh_prof_license_holders_pct > 0.29166666665) => 
            map(
            (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 4.5) => -0.0586962609,
            (iv_unverified_addr_count > 4.5) => 0.1527502411,
            (iv_unverified_addr_count = NULL) => 0.0340434330, 0.0340434330),
         (nf_hh_prof_license_holders_pct = NULL) => 0.0826295703, 0.0826295703),
      (nf_pct_rel_with_bk > 0.13392857145) => -0.1535186352,
      (nf_pct_rel_with_bk = NULL) => 0.0496786579, 0.0496786579),
   (iv_prof_license_category_PL = NULL) => 
      map(
      (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 43.5) => 0.0024071369,
      (nf_mos_inq_banko_om_fseen > 43.5) => -0.1131559773,
      (nf_mos_inq_banko_om_fseen = NULL) => 0.0018864803, 0.0018864803), 0.0009399060);
   
   // Tree: 145 
   fp3_lexid_model_145 := map(
   (NULL < nf_hh_lienholders and nf_hh_lienholders <= 5.5) => 
      map(
      (NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 8.5) => 
         map(
         (rv_D31_MostRec_Bk in ['2 - BK DISCHARGED']) => -0.0365029477,
         (rv_D31_MostRec_Bk in ['NA','0 - NO BK','1 - BK DISMISSED','3 - BK OTHER']) => 0.0017981347,
         (rv_D31_MostRec_Bk = '') => -0.0012030980, -0.0012030980),
      (iv_C14_addrs_per_adl > 8.5) => 
         map(
         (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 306541) => 0.0140451547,
         (iv_prv_addr_avm_auto_val > 306541) => 
            map(
            (NULL < nf_pb_retail_combo_max and nf_pb_retail_combo_max <= 11) => 0.1357379394,
            (nf_pb_retail_combo_max > 11) => -0.0476316171,
            (nf_pb_retail_combo_max = NULL) => 0.0943899022, 0.0943899022),
         (iv_prv_addr_avm_auto_val = NULL) => 0.0220717603, 0.0220717603),
      (iv_C14_addrs_per_adl = NULL) => 0.0009495997, 0.0009495997),
   (nf_hh_lienholders > 5.5) => 0.1590772785,
   (nf_hh_lienholders = NULL) => 0.0011927410, 0.0011927410);
   
   // Tree: 146 
   fp3_lexid_model_146 := map(
   (NULL < iv_prop2_purch_sale_diff and iv_prop2_purch_sale_diff <= 35250) => 0.1144175661,
   (iv_prop2_purch_sale_diff > 35250) => -0.0197762353,
   (iv_prop2_purch_sale_diff = NULL) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 45.5) => 0.0016378579,
      (rv_comb_age > 45.5) => 
         map(
         (NULL < nf_inq_Collection_count and nf_inq_Collection_count <= 4.5) => 
            map(
            (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 555106) => -0.0001387750,
            (rv_A46_Curr_AVM_AutoVal > 555106) => 
               map(
               (NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 0.5) => -0.0770288738,
               (rv_D30_Derog_Count > 0.5) => 0.0291522952,
               (rv_D30_Derog_Count = NULL) => -0.0476947765, -0.0476947765),
            (rv_A46_Curr_AVM_AutoVal = NULL) => -0.0030247000, -0.0030247000),
         (nf_inq_Collection_count > 4.5) => -0.0481155108,
         (nf_inq_Collection_count = NULL) => -0.0067374862, -0.0067374862),
      (rv_comb_age = NULL) => -0.0019147352, -0.0019147352), -0.0016100025);
   
   // Tree: 147 
   fp3_lexid_model_147 := map(
   (NULL < nf_mos_liens_unrel_O_lseen and nf_mos_liens_unrel_O_lseen <= 4) => 
      map(
      (NULL < nf_current_count and nf_current_count <= 0.5) => 
         map(
         (NULL < nf_average_rel_income and nf_average_rel_income <= 112500) => 
            map(
            (NULL < iv_prop2_purch_sale_diff and iv_prop2_purch_sale_diff <= 254530) => -0.0109354310,
            (iv_prop2_purch_sale_diff > 254530) => 0.1683315984,
            (iv_prop2_purch_sale_diff = NULL) => 0.0046621952, 0.0049105590),
         (nf_average_rel_income > 112500) => -0.0584396676,
         (nf_average_rel_income = NULL) => 0.0030664433, 0.0030664433),
      (nf_current_count > 0.5) => 
         map(
         (NULL < census_mod and census_mod <= 0.101621790013395) => -0.0107497192,
         (census_mod > 0.101621790013395) => -0.2263958205,
         (census_mod = NULL) => -0.0113228649, -0.0113228649),
      (nf_current_count = NULL) => -0.0028172487, -0.0028172487),
   (nf_mos_liens_unrel_O_lseen > 4) => 0.1550854891,
   (nf_mos_liens_unrel_O_lseen = NULL) => -0.0026172995, -0.0026172995);
   
   // Tree: 148 
   fp3_lexid_model_148 := map(
   (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 30.5) => -0.0005569386,
   (nf_mos_inq_banko_om_fseen > 30.5) => 
      map(
      (NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 117.5) => 
         map(
         (NULL < rv_A50_pb_total_dollars and rv_A50_pb_total_dollars <= 183.5) => 
            map(
            (NULL < nf_highest_rel_home_val and nf_highest_rel_home_val <= 625) => 0.1175885806,
            (nf_highest_rel_home_val > 625) => 
               map(
               (NULL < rv_I61_inq_collection_recency and rv_I61_inq_collection_recency <= 18) => 0.0559469102,
               (rv_I61_inq_collection_recency > 18) => -0.0639214394,
               (rv_I61_inq_collection_recency = NULL) => -0.0017674804, -0.0017674804),
            (nf_highest_rel_home_val = NULL) => 0.0738030691, 0.0738030691),
         (rv_A50_pb_total_dollars > 183.5) => -0.0076119075,
         (rv_A50_pb_total_dollars = NULL) => 0.0496743476, 0.0496743476),
      (iv_C13_avg_lres > 117.5) => -0.0265504124,
      (iv_C13_avg_lres = NULL) => 0.0287416118, 0.0287416118),
   (nf_mos_inq_banko_om_fseen = NULL) => 0.0013537212, 0.0013537212);
   
   // Tree: 149 
   fp3_lexid_model_149 := map(
   (NULL < rv_D31_bk_disposed_hist_count and rv_D31_bk_disposed_hist_count <= 1.5) => 
      map(
      (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 39.5) => -0.0100726067,
      (rv_C13_Curr_Addr_LRes > 39.5) => 
         map(
         (NULL < rv_C13_attr_addrs_recency and rv_C13_attr_addrs_recency <= 48) => 
            map(
            (NULL < nf_mos_liens_unrel_CJ_lseen and nf_mos_liens_unrel_CJ_lseen <= 52.5) => 0.0232419012,
            (nf_mos_liens_unrel_CJ_lseen > 52.5) => 0.1271866095,
            (nf_mos_liens_unrel_CJ_lseen = NULL) => 0.0287595142, 0.0287595142),
         (rv_C13_attr_addrs_recency > 48) => 
            map(
            (NULL < nf_historical_count and nf_historical_count <= 6.5) => -0.0042340736,
            (nf_historical_count > 6.5) => 0.0335206658,
            (nf_historical_count = NULL) => 0.0002292554, 0.0002292554),
         (rv_C13_attr_addrs_recency = NULL) => 0.0049694179, 0.0049694179),
      (rv_C13_Curr_Addr_LRes = NULL) => -0.0003818596, -0.0003818596),
   (rv_D31_bk_disposed_hist_count > 1.5) => -0.0635159330,
   (rv_D31_bk_disposed_hist_count = NULL) => -0.0012041558, -0.0012041558);
   
   // Tree: 150 
   fp3_lexid_model_150 := map(
   (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.91788873685) => 
      map(
      (NULL < rv_C13_max_lres and rv_C13_max_lres <= 606) => 
         map(
         (NULL < rv_C13_max_lres and rv_C13_max_lres <= 576) => -0.0063594879,
         (rv_C13_max_lres > 576) => -0.2055729593,
         (rv_C13_max_lres = NULL) => -0.0066741108, -0.0066741108),
      (rv_C13_max_lres > 606) => 0.1585771532,
      (rv_C13_max_lres = NULL) => -0.0061537833, -0.0061537833),
   (nf_add_curr_nhood_SFD_pct > 0.91788873685) => 
      map(
      (NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.81666666665) => 
         map(
         (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.9189922984) => 0.1757784360,
         (nf_add_curr_nhood_SFD_pct > 0.9189922984) => 0.0058497947,
         (nf_add_curr_nhood_SFD_pct = NULL) => 0.0072706770, 0.0072706770),
      (nf_hh_criminals_pct > 0.81666666665) => 0.0647846200,
      (nf_hh_criminals_pct = NULL) => 0.0106912654, 0.0106912654),
   (nf_add_curr_nhood_SFD_pct = NULL) => 0.0000457919, 0.0000457919);
   
   // Tree: 151 
   fp3_lexid_model_151 := map(
   (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 3.0612953627) => 
      map(
      (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 
         map(
         (NULL < rv_I60_inq_PrepaidCards_recency and rv_I60_inq_PrepaidCards_recency <= 18) => 
            map(
            (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 20.5) => 0.0385655305,
            (rv_C20_M_Bureau_ADL_FS > 20.5) => 
               map(
               (NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 0.5) => -0.0332483696,
               (nf_hh_age_30_plus > 0.5) => 0.0018553819,
               (nf_hh_age_30_plus = NULL) => -0.0024041284, -0.0024041284),
            (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0006579585, -0.0006579585),
         (rv_I60_inq_PrepaidCards_recency > 18) => 0.0446187553,
         (rv_I60_inq_PrepaidCards_recency = NULL) => 0.0005474328, 0.0005474328),
      (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0478920485,
      (rv_C16_Inv_SSN_Per_ADL = NULL) => -0.0012557215, -0.0012557215),
   (nf_add_curr_nhood_VAC_pct > 3.0612953627) => 0.2315961967,
   (nf_add_curr_nhood_VAC_pct = NULL) => -0.0009398045, -0.0009398045);
   
   // Tree: 152 
   fp3_lexid_model_152 := map(
   (NULL < nf_current_count and nf_current_count <= 10.5) => 
      map(
      (NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 3.5) => 
         map(
         (NULL < nf_fp_srchunvrfddobcount and nf_fp_srchunvrfddobcount <= 1.5) => 
            map(
            (NULL < nf_mos_inq_banko_cm_lseen and nf_mos_inq_banko_cm_lseen <= 18.5) => -0.0060702804,
            (nf_mos_inq_banko_cm_lseen > 18.5) => 
               map(
               (NULL < nf_mos_liens_unrel_ST_fseen and nf_mos_liens_unrel_ST_fseen <= 61.5) => 0.0256597315,
               (nf_mos_liens_unrel_ST_fseen > 61.5) => 0.2269371761,
               (nf_mos_liens_unrel_ST_fseen = NULL) => 0.0321386192, 0.0321386192),
            (nf_mos_inq_banko_cm_lseen = NULL) => -0.0044382596, -0.0044382596),
         (nf_fp_srchunvrfddobcount > 1.5) => -0.1978474580,
         (nf_fp_srchunvrfddobcount = NULL) => -0.0047391616, -0.0047391616),
      (rv_I62_inq_addrs_per_adl > 3.5) => 0.0950968054,
      (rv_I62_inq_addrs_per_adl = NULL) => -0.0039056097, -0.0039056097),
   (nf_current_count > 10.5) => 0.1411940096,
   (nf_current_count = NULL) => -0.0034200194, -0.0034200194);
   
   // Tree: 153 
   fp3_lexid_model_153 := map(
   (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 368.5) => 
      map(
      (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.07380174295) => 
         map(
         (NULL < nf_average_rel_age and nf_average_rel_age <= 57.5) => -0.0111585545,
         (nf_average_rel_age > 57.5) => 0.1454560696,
         (nf_average_rel_age = NULL) => -0.0101112345, -0.0101112345),
      (nf_pct_rel_with_bk > 0.07380174295) => 
         map(
         (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 240.5) => 0.0139171988,
         (nf_fp_prevaddrageoldest > 240.5) => -0.0224986480,
         (nf_fp_prevaddrageoldest = NULL) => 0.0087317201, 0.0087317201),
      (nf_pct_rel_with_bk = NULL) => -0.0017531679, -0.0017531679),
   (rv_C20_M_Bureau_ADL_FS > 368.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 372.5) => -0.1128797821,
      (nf_M_Bureau_ADL_FS > 372.5) => -0.0229816120,
      (nf_M_Bureau_ADL_FS = NULL) => -0.0487784782, -0.0487784782),
   (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0041988583, -0.0041988583);
   
   // Tree: 154 
   fp3_lexid_model_154 := map(
   (NULL < nf_liens_unrel_FT_total_amt and nf_liens_unrel_FT_total_amt <= 21076.5) => 
      map(
      (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 136.5) => 
         map(
         (rv_A41_A42_Prop_Owner_History in ['CURRENT','HISTORICAL']) => -0.0136146905,
         (rv_A41_A42_Prop_Owner_History in ['NA','NEVER']) => 
            map(
            (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 93.5) => 0.0184757323,
            (nf_fp_prevaddrageoldest > 93.5) => -0.0483248601,
            (nf_fp_prevaddrageoldest = NULL) => 0.0121856577, 0.0121856577),
         (rv_A41_A42_Prop_Owner_History = '') => -0.0057972954, -0.0057972954),
      (nf_fp_prevaddrageoldest > 136.5) => 
         map(
         (NULL < rv_C13_max_lres and rv_C13_max_lres <= 57.5) => 0.2328554288,
         (rv_C13_max_lres > 57.5) => 0.0110224076,
         (rv_C13_max_lres = NULL) => 0.0115824506, 0.0115824506),
      (nf_fp_prevaddrageoldest = NULL) => 0.0004775359, 0.0004775359),
   (nf_liens_unrel_FT_total_amt > 21076.5) => -0.0884316385,
   (nf_liens_unrel_FT_total_amt = NULL) => -0.0002060097, -0.0002060097);
   
   // Tree: 155 
   fp3_lexid_model_155 := map(
   (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 78) => 
      map(
      (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 76.5) => 
         map(
         (NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 18) => -0.0132308977,
         (nf_fp_prevaddrburglaryindex > 18) => 0.0150732889,
         (nf_fp_prevaddrburglaryindex = NULL) => 0.0075258332, 0.0075258332),
      (nf_fp_curraddrburglaryindex > 76.5) => 
         map(
         (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.92389235965) => 0.0583440157,
         (nf_add_curr_nhood_SFD_pct > 0.92389235965) => 0.2083180065,
         (nf_add_curr_nhood_SFD_pct = NULL) => 0.1088160318, 0.1088160318),
      (nf_fp_curraddrburglaryindex = NULL) => 0.0093210242, 0.0093210242),
   (nf_fp_curraddrburglaryindex > 78) => 
      map(
      (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 328.5) => -0.0106777062,
      (rv_C13_Curr_Addr_LRes > 328.5) => 0.0342169278,
      (rv_C13_Curr_Addr_LRes = NULL) => -0.0082374042, -0.0082374042),
   (nf_fp_curraddrburglaryindex = NULL) => 0.0010817761, 0.0010817761);
   
   // Tree: 156 
   fp3_lexid_model_156 := map(
   (NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 9034.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 16.5) => 0.1512274516,
      (rv_comb_age > 16.5) => 
         map(
         (NULL < nf_fp_idrisktype and nf_fp_idrisktype <= 4.5) => 
            map(
            (NULL < nf_inq_Banking_count and nf_inq_Banking_count <= 8.5) => -0.0008971054,
            (nf_inq_Banking_count > 8.5) => -0.0628569874,
            (nf_inq_Banking_count = NULL) => -0.0016088921, -0.0016088921),
         (nf_fp_idrisktype > 4.5) => 0.1004856879,
         (nf_fp_idrisktype = NULL) => -0.0009884278, -0.0009884278),
      (rv_comb_age = NULL) => -0.0007644986, -0.0007644986),
   (nf_liens_unrel_CJ_total_amt > 9034.5) => 
      map(
      (NULL < nf_average_rel_income and nf_average_rel_income <= 91500) => -0.0857895537,
      (nf_average_rel_income > 91500) => 0.1498261797,
      (nf_average_rel_income = NULL) => -0.0630312158, -0.0630312158),
   (nf_liens_unrel_CJ_total_amt = NULL) => -0.0017557198, -0.0017557198);
   
   // Tree: 157 
   fp3_lexid_model_157 := map(
   (NULL < rv_comb_age and rv_comb_age <= 16.5) => 0.0914961399,
   (rv_comb_age > 16.5) => 
      map(
      (NULL < nf_lowest_rel_income and nf_lowest_rel_income <= 87.5) => 
         map(
         (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 83210.5) => 
            map(
            (NULL < nf_inq_Collection_count and nf_inq_Collection_count <= 2.5) => 
               map(
               (NULL < nf_hh_prof_license_holders_pct and nf_hh_prof_license_holders_pct <= 0.18333333335) => -0.0167883004,
               (nf_hh_prof_license_holders_pct > 0.18333333335) => 0.1219424192,
               (nf_hh_prof_license_holders_pct = NULL) => -0.0090419150, -0.0090419150),
            (nf_inq_Collection_count > 2.5) => -0.0705133317,
            (nf_inq_Collection_count = NULL) => -0.0200975570, -0.0200975570),
         (nf_fp_curraddrmedianvalue > 83210.5) => 0.0031131727,
         (nf_fp_curraddrmedianvalue = NULL) => 0.0004761387, 0.0004761387),
      (nf_lowest_rel_income > 87.5) => -0.0388820348,
      (nf_lowest_rel_income = NULL) => -0.0011856271, -0.0011856271),
   (rv_comb_age = NULL) => -0.0010682128, -0.0010682128);
   
   // Tree: 158 
   fp3_lexid_model_158 := map(
   (iv_pb_profile in ['4 OTHER']) => -0.0693986400,
   (iv_pb_profile in ['NA','0 NO PURCH DATA','1 OFFLINE SHOPPER','2 ONLINE SHOPPER','3 RETAIL SHOPPER']) => 
      map(
      (NULL < census_mod and census_mod <= -1.67987443919398) => -0.0781623244,
      (census_mod > -1.67987443919398) => 
         map(
         (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 2.5) => 
            map(
            (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 6.5) => -0.0689981160,
            (nf_fp_curraddrburglaryindex > 6.5) => 0.1257747021,
            (nf_fp_curraddrburglaryindex = NULL) => 0.0756059459, 0.0756059459),
         (rv_C10_M_Hdr_FS > 2.5) => 
            map(
            (NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 35) => -0.0103442580,
            (nf_fp_prevaddrburglaryindex > 35) => 0.0074023938,
            (nf_fp_prevaddrburglaryindex = NULL) => 0.0023863425, 0.0023863425),
         (rv_C10_M_Hdr_FS = NULL) => 0.0028404816, 0.0028404816),
      (census_mod = NULL) => 0.0013607735, 0.0013607735),
   (iv_pb_profile = '') => -0.0000280464, -0.0000280464);
   
   // Tree: 159 
   fp3_lexid_model_159 := map(
   (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 318.5) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 201.5) => -0.0050792741,
      (rv_A50_pb_average_dollars > 201.5) => 
         map(
         (NULL < rv_A50_pb_total_dollars and rv_A50_pb_total_dollars <= 213.5) => 0.2821417950,
         (rv_A50_pb_total_dollars > 213.5) => 0.0327046229,
         (rv_A50_pb_total_dollars = NULL) => 0.0404391089, 0.0404391089),
      (rv_A50_pb_average_dollars = NULL) => -0.0033718384, -0.0033718384),
   (rv_C13_Curr_Addr_LRes > 318.5) => 
      map(
      (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.0049733094) => 
         map(
         (NULL < rv_I60_inq_retpymt_recency and rv_I60_inq_retpymt_recency <= 7.5) => -0.0305887205,
         (rv_I60_inq_retpymt_recency > 7.5) => 0.1416767854,
         (rv_I60_inq_retpymt_recency = NULL) => -0.0191043534, -0.0191043534),
      (nf_add_curr_nhood_VAC_pct > 0.0049733094) => 0.0506830958,
      (nf_add_curr_nhood_VAC_pct = NULL) => 0.0266021762, 0.0266021762),
   (rv_C13_Curr_Addr_LRes = NULL) => -0.0013683293, -0.0013683293);
   
   // Tree: 160 
   fp3_lexid_model_160 := map(
   (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 48087.5) => 
      map(
      (NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 239262) => 
         map(
         (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 147.5) => -0.0083416627,
         (rv_A49_Curr_AVM_Chg_1yr_Pct > 147.5) => -0.1088268068,
         (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0011603769, -0.0042446744),
      (nf_fp_prevaddrmedianvalue > 239262) => -0.0391280123,
      (nf_fp_prevaddrmedianvalue = NULL) => -0.0128245775, -0.0128245775),
   (nf_fp_curraddrmedianincome > 48087.5) => 
      map(
      (NULL < nf_average_rel_income and nf_average_rel_income <= 55500) => 
         map(
         (NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 2.5) => 0.0292766715,
         (nf_hh_collections_ct > 2.5) => 0.1510875870,
         (nf_hh_collections_ct = NULL) => 0.0384124901, 0.0384124901),
      (nf_average_rel_income > 55500) => 0.0016750123,
      (nf_average_rel_income = NULL) => 0.0051817296, 0.0051817296),
   (nf_fp_curraddrmedianincome = NULL) => 0.0001426997, 0.0001426997);
   
   // Tree: 161 
   fp3_lexid_model_161 := map(
   (NULL < census_mod and census_mod <= -0.892929933065622) => 
      map(
      (NULL < nf_youngest_rel_age and nf_youngest_rel_age <= 55) => -0.0049871039,
      (nf_youngest_rel_age > 55) => 0.2188111599,
      (nf_youngest_rel_age = NULL) => -0.0045626406, -0.0045626406),
   (census_mod > -0.892929933065622) => 
      map(
      (NULL < nf_attr_arrest_recency and nf_attr_arrest_recency <= 79.5) => 0.1425428743,
      (nf_attr_arrest_recency > 79.5) => -0.0350547795,
      (nf_attr_arrest_recency = NULL) => 
         map(
         (NULL < census_mod and census_mod <= -0.889914682496697) => 0.1753896439,
         (census_mod > -0.889914682496697) => 
            map(
            (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.2886904762) => 0.0123998523,
            (nf_pct_rel_with_bk > 0.2886904762) => -0.0319181544,
            (nf_pct_rel_with_bk = NULL) => 0.0080515392, 0.0080515392),
         (census_mod = NULL) => 0.0090308883, 0.0090308883), 0.0111898993),
   (census_mod = NULL) => -0.0008296762, -0.0008296762);
   
   // Tree: 162 
   fp3_lexid_model_162 := map(
   (NULL < rv_D34_attr_liens_recency and rv_D34_attr_liens_recency <= 18) => 
      map(
      (NULL < rv_F04_curr_add_occ_index and rv_F04_curr_add_occ_index <= 2) => -0.0014482475,
      (rv_F04_curr_add_occ_index > 2) => 
         map(
         (NULL < nf_mos_inq_banko_am_lseen and nf_mos_inq_banko_am_lseen <= 54.5) => 
            map(
            (NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 187.5) => 0.0156192352,
            (nf_fp_prevaddrcartheftindex > 187.5) => 
               map(
               (NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 107.5) => 0.0663870849,
               (iv_C13_avg_lres > 107.5) => 0.2651301988,
               (iv_C13_avg_lres = NULL) => 0.0947789583, 0.0947789583),
            (nf_fp_prevaddrcartheftindex = NULL) => 0.0199434564, 0.0199434564),
         (nf_mos_inq_banko_am_lseen > 54.5) => 0.2799647537,
         (nf_mos_inq_banko_am_lseen = NULL) => 0.0222419872, 0.0222419872),
      (rv_F04_curr_add_occ_index = NULL) => 0.0030535189, 0.0030535189),
   (rv_D34_attr_liens_recency > 18) => -0.0189845266,
   (rv_D34_attr_liens_recency = NULL) => 0.0000037532, 0.0000037532);
   
   // Tree: 163 
   fp3_lexid_model_163 := map(
   (NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.0871212121) => 
      map(
      (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 
         map(
         (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 115.35) => 
            map(
            (NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 232) => -0.0014550579,
            (rv_mos_since_br_first_seen > 232) => 0.2561767795,
            (rv_mos_since_br_first_seen = NULL) => 0.0040973524, 0.0040973524),
         (rv_A49_Curr_AVM_Chg_1yr_Pct > 115.35) => 0.0708085451,
         (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 
            map(
            (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 351.5) => 0.0065445088,
            (nf_M_Bureau_ADL_FS_noTU > 351.5) => 0.0894176415,
            (nf_M_Bureau_ADL_FS_noTU = NULL) => 0.0117077403, 0.0117077403), 0.0153377154),
      (nf_hh_members_ct > 1.5) => -0.0059486008,
      (nf_hh_members_ct = NULL) => -0.0018927492, -0.0018927492),
   (nf_hh_payday_loan_users_pct > 0.0871212121) => 0.0239060838,
   (nf_hh_payday_loan_users_pct = NULL) => 0.0005270582, 0.0005270582);
   
   // Tree: 164 
   fp3_lexid_model_164 := map(
   (NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 4.5) => -0.0080881381,
   (iv_C14_addrs_per_adl > 4.5) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 69.5) => 
         map(
         (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 715649) => 0.0062094601,
         (rv_A46_Curr_AVM_AutoVal > 715649) => 
            map(
            (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 128) => 0.0386706319,
            (nf_fp_prevaddrcrimeindex > 128) => 0.2009158643,
            (nf_fp_prevaddrcrimeindex = NULL) => 0.0830584785, 0.0830584785),
         (rv_A46_Curr_AVM_AutoVal = NULL) => 0.0080833952, 0.0080833952),
      (rv_comb_age > 69.5) => 
         map(
         (NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => 0.1023906882,
         (rv_email_domain_ISP_count > 0.5) => 0.0074577190,
         (rv_email_domain_ISP_count = NULL) => 0.0523772215, 0.0523772215),
      (rv_comb_age = NULL) => 0.0100781743, 0.0100781743),
   (iv_C14_addrs_per_adl = NULL) => -0.0006086650, -0.0006086650);
   
   // Tree: 165 
   fp3_lexid_model_165 := map(
   (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 1.5) => 0.0054104792,
   (nf_mos_inq_banko_om_fseen > 1.5) => 
      map(
      (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 6.5) => -0.0685236056,
      (nf_mos_inq_banko_om_fseen > 6.5) => 
         map(
         (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 273) => 
            map(
            (NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 218.5) => 
               map(
               (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.0851449275) => 0.0131648850,
               (nf_pct_rel_with_felony > 0.0851449275) => -0.0624607528,
               (nf_pct_rel_with_felony = NULL) => 0.0020685725, 0.0020685725),
            (nf_fp_prevaddrlenofres > 218.5) => 0.1910482862,
            (nf_fp_prevaddrlenofres = NULL) => 0.0082578644, 0.0082578644),
         (nf_fp_prevaddrageoldest > 273) => -0.0829036037,
         (nf_fp_prevaddrageoldest = NULL) => -0.0026885174, -0.0026885174),
      (nf_mos_inq_banko_om_fseen = NULL) => -0.0188610500, -0.0188610500),
   (nf_mos_inq_banko_om_fseen = NULL) => 0.0023809287, 0.0023809287);
   
   // Tree: 166 
   fp3_lexid_model_166 := map(
   (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 
      map(
      (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 492455) => 
         map(
         (NULL < rv_email_domain_ISP_count and rv_email_domain_ISP_count <= 0.5) => 
            map(
            (NULL < nf_pct_rel_prop_owned and nf_pct_rel_prop_owned <= 0.34534161495) => 0.0727046638,
            (nf_pct_rel_prop_owned > 0.34534161495) => 0.0176723042,
            (nf_pct_rel_prop_owned = NULL) => 0.0414146937, 0.0414146937),
         (rv_email_domain_ISP_count > 0.5) => 
            map(
            (NULL < nf_inq_HighRiskCredit_count and nf_inq_HighRiskCredit_count <= 1.5) => 0.0076477467,
            (nf_inq_HighRiskCredit_count > 1.5) => -0.0965406075,
            (nf_inq_HighRiskCredit_count = NULL) => -0.0034502179, -0.0034502179),
         (rv_email_domain_ISP_count = NULL) => 0.0251025380, 0.0251025380),
      (nf_fp_curraddrmedianvalue > 492455) => -0.0342388824,
      (nf_fp_curraddrmedianvalue = NULL) => 0.0177675296, 0.0177675296),
   (nf_hh_members_ct > 1.5) => -0.0057807585,
   (nf_hh_members_ct = NULL) => -0.0015763156, -0.0015763156);
   
   // Tree: 167 
   fp3_lexid_model_167 := map(
   (NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 5.5) => 
      map(
      (NULL < rv_D34_UnRel_Lien60_Count and rv_D34_UnRel_Lien60_Count <= 2.5) => 0.0012316262,
      (rv_D34_UnRel_Lien60_Count > 2.5) => 
         map(
         (NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 9) => -0.0044636814,
         (rv_I60_inq_recency > 9) => 0.1797258486,
         (rv_I60_inq_recency = NULL) => 0.0812058675, 0.0812058675),
      (rv_D34_UnRel_Lien60_Count = NULL) => 0.0018578472, 0.0018578472),
   (rv_I60_inq_hiRiskCred_count12 > 5.5) => 
      map(
      (NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.01307129085) => -0.2203577901,
      (nf_add_curr_nhood_BUS_pct > 0.01307129085) => 
         map(
         (NULL < nf_inq_HighRiskCredit_count and nf_inq_HighRiskCredit_count <= 14.5) => -0.1246614058,
         (nf_inq_HighRiskCredit_count > 14.5) => 0.0717741120,
         (nf_inq_HighRiskCredit_count = NULL) => -0.0282294244, -0.0282294244),
      (nf_add_curr_nhood_BUS_pct = NULL) => -0.0756035419, -0.0756035419),
   (rv_I60_inq_hiRiskCred_count12 = NULL) => 0.0013463890, 0.0013463890);
   
   // Tree: 168 
   fp3_lexid_model_168 := map(
   (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 440.5) => 0.0000758525,
   (nf_M_Bureau_ADL_FS_all > 440.5) => 
      map(
      (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 26.5) => -0.0836213385,
      (rv_C13_Curr_Addr_LRes > 26.5) => 
         map(
         (NULL < census_mod and census_mod <= -1.36274530119696) => 
            map(
            (NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.9) => 0.0708207874,
            (nf_hh_pct_property_owners > 0.9) => 0.2168907347,
            (nf_hh_pct_property_owners = NULL) => 0.1113957728, 0.1113957728),
         (census_mod > -1.36274530119696) => 
            map(
            (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 80543) => 0.0446332302,
            (nf_fp_prevaddrmedianincome > 80543) => -0.0389318845,
            (nf_fp_prevaddrmedianincome = NULL) => 0.0168689250, 0.0168689250),
         (census_mod = NULL) => 0.0470504462, 0.0470504462),
      (rv_C13_Curr_Addr_LRes = NULL) => 0.0342446113, 0.0342446113),
   (nf_M_Bureau_ADL_FS_all = NULL) => 0.0016211112, 0.0016211112);
   
   // Tree: 169 
   fp3_lexid_model_169 := map(
   (NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 3.5) => 
      map(
      (NULL < rv_C14_Addr_Stability_v2 and rv_C14_Addr_Stability_v2 <= 4.5) => -0.0119038385,
      (rv_C14_Addr_Stability_v2 > 4.5) => 
         map(
         (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => -0.0015449829,
         (nf_fp_varrisktype > 1.5) => 
            map(
            (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 43951) => 
               map(
               (NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.3209382151) => 0.0122371875,
               (nf_pct_rel_with_criminal > 0.3209382151) => -0.1078212251,
               (nf_pct_rel_with_criminal = NULL) => -0.0225696632, -0.0225696632),
            (nf_fp_curraddrmedianincome > 43951) => 0.0430830533,
            (nf_fp_curraddrmedianincome = NULL) => 0.0268404893, 0.0268404893),
         (nf_fp_varrisktype = NULL) => 0.0022741533, 0.0022741533),
      (rv_C14_Addr_Stability_v2 = NULL) => -0.0026637837, -0.0026637837),
   (rv_I62_inq_addrs_per_adl > 3.5) => 0.0841886220,
   (rv_I62_inq_addrs_per_adl = NULL) => -0.0019960508, -0.0019960508);
   
   // Tree: 170 
   fp3_lexid_model_170 := map(
   (NULL < nf_hh_tot_derog and nf_hh_tot_derog <= 8.5) => 
      map(
      (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 122041.5) => 
         map(
         (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 884943.5) => 0.0028195251,
         (nf_fp_curraddrmedianvalue > 884943.5) => -0.0860047988,
         (nf_fp_curraddrmedianvalue = NULL) => 0.0021560223, 0.0021560223),
      (nf_fp_prevaddrmedianincome > 122041.5) => 
         map(
         (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 22) => -0.0855655624,
         (nf_fp_prevaddrcrimeindex > 22) => -0.0039118064,
         (nf_fp_prevaddrcrimeindex = NULL) => -0.0334710514, -0.0334710514),
      (nf_fp_prevaddrmedianincome = NULL) => 0.0003487580, 0.0003487580),
   (nf_hh_tot_derog > 8.5) => 
      map(
      (NULL < nf_hh_collections_ct and nf_hh_collections_ct <= 3.5) => -0.0611813219,
      (nf_hh_collections_ct > 3.5) => 0.1451337397,
      (nf_hh_collections_ct = NULL) => 0.0972391718, 0.0972391718),
   (nf_hh_tot_derog = NULL) => 0.0008395198, 0.0008395198);
   
   // Tree: 171 
   fp3_lexid_model_171 := map(
   (NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 3824) => 
      map(
      (NULL < nf_inq_Mortgage_count and nf_inq_Mortgage_count <= 3.5) => 0.0029348682,
      (nf_inq_Mortgage_count > 3.5) => -0.0764478128,
      (nf_inq_Mortgage_count = NULL) => 0.0021119808, 0.0021119808),
   (nf_liens_unrel_CJ_total_amt > 3824) => 
      map(
      (NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 6053.5) => -0.0904315006,
      (nf_liens_unrel_CJ_total_amt > 6053.5) => 
         map(
         (NULL < nf_average_rel_income and nf_average_rel_income <= 89500) => -0.0315752178,
         (nf_average_rel_income > 89500) => 
            map(
            (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 48.5) => -0.0099389655,
            (nf_fp_curraddrmurderindex > 48.5) => 0.2382022703,
            (nf_fp_curraddrmurderindex = NULL) => 0.1224030269, 0.1224030269),
         (nf_average_rel_income = NULL) => -0.0117496927, -0.0117496927),
      (nf_liens_unrel_CJ_total_amt = NULL) => -0.0377508648, -0.0377508648),
   (nf_liens_unrel_CJ_total_amt = NULL) => 0.0008572530, 0.0008572530);
   
   // Tree: 172 
   fp3_lexid_model_172 := map(
   (NULL < nf_inq_Other_count_week and nf_inq_Other_count_week <= 0.5) => 
      map(
      (NULL < rv_I60_inq_banking_count12 and rv_I60_inq_banking_count12 <= 23) => -0.0005148049,
      (rv_I60_inq_banking_count12 > 23) => -0.1712915648,
      (rv_I60_inq_banking_count12 = NULL) => -0.0007013612, -0.0007013612),
   (nf_inq_Other_count_week > 0.5) => 
      map(
      (NULL < rv_C13_max_lres and rv_C13_max_lres <= 72) => -0.0591313964,
      (rv_C13_max_lres > 72) => 
         map(
         (NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 7.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 47) => 0.2456008352,
            (rv_comb_age > 47) => 0.1096930721,
            (rv_comb_age = NULL) => 0.1744110545, 0.1744110545),
         (iv_C14_addrs_per_adl > 7.5) => -0.0396685512,
         (iv_C14_addrs_per_adl = NULL) => 0.1268378088, 0.1268378088),
      (rv_C13_max_lres = NULL) => 0.0823099709, 0.0823099709),
   (nf_inq_Other_count_week = NULL) => -0.0001682746, -0.0001682746);
   
   // Tree: 173 
   fp3_lexid_model_173 := map(
   (NULL < rv_D34_attr_liens_recency and rv_D34_attr_liens_recency <= 18) => 0.0007438997,
   (rv_D34_attr_liens_recency > 18) => 
      map(
      (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 677466.5) => 
         map(
         (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 18.5) => 
            map(
            (NULL < nf_fp_assoccredbureaucount and nf_fp_assoccredbureaucount <= 2.5) => -0.0319229510,
            (nf_fp_assoccredbureaucount > 2.5) => 
               map(
               (NULL < nf_average_rel_distance and nf_average_rel_distance <= 935) => -0.0148419459,
               (nf_average_rel_distance > 935) => 0.1603632432,
               (nf_average_rel_distance = NULL) => 0.0623671205, 0.0623671205),
            (nf_fp_assoccredbureaucount = NULL) => -0.0281462272, -0.0281462272),
         (iv_unverified_addr_count > 18.5) => 0.1847719837,
         (iv_unverified_addr_count = NULL) => -0.0261416173, -0.0261416173),
      (iv_prv_addr_avm_auto_val > 677466.5) => 0.1399025496,
      (iv_prv_addr_avm_auto_val = NULL) => -0.0241557070, -0.0241557070),
   (rv_D34_attr_liens_recency = NULL) => -0.0026545723, -0.0026545723);
   
   // Tree: 174 
   fp3_lexid_model_174 := map(
   (NULL < nf_liens_unrel_SC_total_amt and nf_liens_unrel_SC_total_amt <= 2053) => 
      map(
      (NULL < nf_fp_vardobcountnew and nf_fp_vardobcountnew <= 0.5) => -0.0033677130,
      (nf_fp_vardobcountnew > 0.5) => 0.0146021162,
      (nf_fp_vardobcountnew = NULL) => 0.0006297986, 0.0006297986),
   (nf_liens_unrel_SC_total_amt > 2053) => 
      map(
      (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 49259) => -0.1302906669,
      (nf_fp_prevaddrmedianincome > 49259) => 
         map(
         (NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 87.5) => -0.0699485745,
         (nf_fp_prevaddrlenofres > 87.5) => 
            map(
            (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 159) => 0.2819000455,
            (nf_fp_prevaddrageoldest > 159) => 0.0195945786,
            (nf_fp_prevaddrageoldest = NULL) => 0.0997434712, 0.0997434712),
         (nf_fp_prevaddrlenofres = NULL) => -0.0063140573, -0.0063140573),
      (nf_fp_prevaddrmedianincome = NULL) => -0.0577189930, -0.0577189930),
   (nf_liens_unrel_SC_total_amt = NULL) => -0.0002357226, -0.0002357226);
   
   // Tree: 175 
   fp3_lexid_model_175 := map(
   (NULL < nf_fp_prevaddrcrimeindex and nf_fp_prevaddrcrimeindex <= 185.5) => 
      map(
      (NULL < nf_hh_prof_license_holders_pct and nf_hh_prof_license_holders_pct <= 0.55) => 
         map(
         (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 78) => 0.0080166503,
         (nf_fp_curraddrburglaryindex > 78) => 
            map(
            (NULL < iv_D34_liens_rel_OT_ct and iv_D34_liens_rel_OT_ct <= 2.5) => -0.0090829944,
            (iv_D34_liens_rel_OT_ct > 2.5) => 0.1544526722,
            (iv_D34_liens_rel_OT_ct = NULL) => -0.0084091762, -0.0084091762),
         (nf_fp_curraddrburglaryindex = NULL) => 0.0003198686, 0.0003198686),
      (nf_hh_prof_license_holders_pct > 0.55) => -0.0554062201,
      (nf_hh_prof_license_holders_pct = NULL) => -0.0007977107, -0.0007977107),
   (nf_fp_prevaddrcrimeindex > 185.5) => 
      map(
      (NULL < nf_mos_liens_unrel_ST_lseen and nf_mos_liens_unrel_ST_lseen <= 19) => 0.0415462630,
      (nf_mos_liens_unrel_ST_lseen > 19) => -0.1792861652,
      (nf_mos_liens_unrel_ST_lseen = NULL) => 0.0360823679, 0.0360823679),
   (nf_fp_prevaddrcrimeindex = NULL) => 0.0008201292, 0.0008201292);
   
   // Tree: 176 
   fp3_lexid_model_176 := map(
   (NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.12347560975) => -0.0127409623,
   (nf_hh_collections_ct_avg > 0.12347560975) => 
      map(
      (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 75207) => 
         map(
         (NULL < rv_C12_Num_NonDerogs and rv_C12_Num_NonDerogs <= 2.5) => 
            map(
            (NULL < rv_D32_attr_felonies_recency and rv_D32_attr_felonies_recency <= 18) => 0.0343733145,
            (rv_D32_attr_felonies_recency > 18) => 0.1972480401,
            (rv_D32_attr_felonies_recency = NULL) => 0.0378535437, 0.0378535437),
         (rv_C12_Num_NonDerogs > 2.5) => 
            map(
            (NULL < nf_pb_retail_combo_cnt and nf_pb_retail_combo_cnt <= 25.5) => -0.0001956582,
            (nf_pb_retail_combo_cnt > 25.5) => 0.0990556675,
            (nf_pb_retail_combo_cnt = NULL) => 0.0038837579, 0.0038837579),
         (rv_C12_Num_NonDerogs = NULL) => 0.0137490137, 0.0137490137),
      (rv_A46_Curr_AVM_AutoVal > 75207) => -0.0071312353,
      (rv_A46_Curr_AVM_AutoVal = NULL) => 0.0028048407, 0.0028048407),
   (nf_hh_collections_ct_avg = NULL) => -0.0032174707, -0.0032174707);
   
   // Tree: 177 
   fp3_lexid_model_177 := map(
   (NULL < nf_mos_liens_unrel_SC_lseen and nf_mos_liens_unrel_SC_lseen <= 193.5) => 
      map(
      (NULL < nf_liens_unrel_CJ_total_amt and nf_liens_unrel_CJ_total_amt <= 19424.5) => 
         map(
         (NULL < nf_mos_inq_banko_cm_fseen and nf_mos_inq_banko_cm_fseen <= 26.5) => 0.0013363034,
         (nf_mos_inq_banko_cm_fseen > 26.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 32.5) => 
               map(
               (NULL < nf_hh_age_18_plus and nf_hh_age_18_plus <= 4.5) => 0.1483811066,
               (nf_hh_age_18_plus > 4.5) => -0.0744483157,
               (nf_hh_age_18_plus = NULL) => 0.1055292946, 0.1055292946),
            (rv_comb_age > 32.5) => 0.0119877124,
            (rv_comb_age = NULL) => 0.0350406142, 0.0350406142),
         (nf_mos_inq_banko_cm_fseen = NULL) => 0.0026348718, 0.0026348718),
      (nf_liens_unrel_CJ_total_amt > 19424.5) => -0.0805446193,
      (nf_liens_unrel_CJ_total_amt = NULL) => 0.0021291525, 0.0021291525),
   (nf_mos_liens_unrel_SC_lseen > 193.5) => -0.1078268129,
   (nf_mos_liens_unrel_SC_lseen = NULL) => 0.0017711194, 0.0017711194);
   
   // Tree: 178 
   fp3_lexid_model_178 := map(
   (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= -56175) => 
      map(
      (NULL < nf_rel_criminal_count and nf_rel_criminal_count <= 1.5) => 0.2109293294,
      (nf_rel_criminal_count > 1.5) => 0.0163481808,
      (nf_rel_criminal_count = NULL) => 0.0977184793, 0.0977184793),
   (iv_prop1_purch_sale_diff > -56175) => 
      map(
      (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.17977796235) => 0.1604883886,
      (nf_add_curr_nhood_SFD_pct > 0.17977796235) => 
         map(
         (iv_curr_add_financing_type in ['NONE']) => -0.0077834713,
         (iv_curr_add_financing_type in ['NA','ADJ','CNV','OTH']) => 0.1037966531,
         (iv_curr_add_financing_type = '') => 0.0032909605, 0.0032909605),
      (nf_add_curr_nhood_SFD_pct = NULL) => 0.0111228608, 0.0111228608),
   (iv_prop1_purch_sale_diff = NULL) => 
      map(
      (NULL < rv_E58_br_dead_business_count and rv_E58_br_dead_business_count <= 4.5) => 0.0006555281,
      (rv_E58_br_dead_business_count > 4.5) => -0.1703278196,
      (rv_E58_br_dead_business_count = NULL) => 0.0002951838, 0.0002951838), 0.0013302269);
   
   // Tree: 179 
   fp3_lexid_model_179 := map(
   (NULL < rv_comb_age and rv_comb_age <= 19.5) => 
      map(
      (NULL < rv_I60_inq_other_count12 and rv_I60_inq_other_count12 <= 0.5) => 
         map(
         (NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.5357142857) => 0.0216680779,
         (nf_hh_collections_ct_avg > 0.5357142857) => 0.2366457146,
         (nf_hh_collections_ct_avg = NULL) => 0.0343138213, 0.0343138213),
      (rv_I60_inq_other_count12 > 0.5) => 0.2411835606,
      (rv_I60_inq_other_count12 = NULL) => 0.0472431800, 0.0472431800),
   (rv_comb_age > 19.5) => 
      map(
      (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.0863354037) => -0.0059046270,
      (nf_pct_rel_with_felony > 0.0863354037) => 
         map(
         (NULL < nf_inq_Auto_count and nf_inq_Auto_count <= 2.5) => 0.0270584736,
         (nf_inq_Auto_count > 2.5) => -0.0983557013,
         (nf_inq_Auto_count = NULL) => 0.0213068169, 0.0213068169),
      (nf_pct_rel_with_felony = NULL) => -0.0036481544, -0.0036481544),
   (rv_comb_age = NULL) => -0.0023957846, -0.0023957846);
   
   // Tree: 180 
   fp3_lexid_model_180 := map(
   (NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 306) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 1204) => 
         map(
         (NULL < nf_liens_rel_CJ_total_amt and nf_liens_rel_CJ_total_amt <= 1446) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 67.5) => 0.0044313622,
            (rv_comb_age > 67.5) => 
               map(
               (NULL < nf_rel_bankrupt_count and nf_rel_bankrupt_count <= 1.5) => -0.0226332661,
               (nf_rel_bankrupt_count > 1.5) => 0.0285528744,
               (nf_rel_bankrupt_count = NULL) => -0.0092118471, -0.0092118471),
            (rv_comb_age = NULL) => 0.0032479457, 0.0032479457),
         (nf_liens_rel_CJ_total_amt > 1446) => -0.0561922259,
         (nf_liens_rel_CJ_total_amt = NULL) => 0.0023535414, 0.0023535414),
      (rv_A50_pb_average_dollars > 1204) => 0.2092019364,
      (rv_A50_pb_average_dollars = NULL) => 0.0025408701, 0.0025408701),
   (nf_mos_acc_lseen > 306) => 0.1550234517,
   (nf_mos_acc_lseen = NULL) => 0.0027339559, 0.0027339559);
   
   // Tree: 181 
   fp3_lexid_model_181 := map(
   (NULL < rv_C13_max_lres and rv_C13_max_lres <= 608.5) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 52.5) => 0.0752747413,
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 52.5) => -0.0023059919,
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 
         map(
         (NULL < nf_hh_lienholders and nf_hh_lienholders <= 1.5) => -0.0113325194,
         (nf_hh_lienholders > 1.5) => 
            map(
            (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.01915753335) => -0.0869260597,
            (nf_add_curr_nhood_SFD_pct > 0.01915753335) => 
               map(
               (NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 1443) => 0.0282962145,
               (nf_liens_unrel_ST_total_amt > 1443) => 0.2298508131,
               (nf_liens_unrel_ST_total_amt = NULL) => 0.0331697281, 0.0331697281),
            (nf_add_curr_nhood_SFD_pct = NULL) => 0.0248672862, 0.0248672862),
         (nf_hh_lienholders = NULL) => -0.0074139188, -0.0074139188), -0.0045071019),
   (rv_C13_max_lres > 608.5) => 0.0961273740,
   (rv_C13_max_lres = NULL) => -0.0040701939, -0.0040701939);
   
   // Tree: 182 
   fp3_lexid_model_182 := map(
   (NULL < rv_C13_max_lres and rv_C13_max_lres <= 456.5) => 
      map(
      (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 410.5) => 
         map(
         (NULL < nf_fp_assoccredbureaucountnew and nf_fp_assoccredbureaucountnew <= 1.5) => 
            map(
            (iv_college_type in ['-1','R','S','U']) => -0.0003494552,
            (iv_college_type in ['NA','P']) => 
               map(
               (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 123725.5) => 0.0486924633,
               (nf_fp_curraddrmedianincome > 123725.5) => 0.3199905539,
               (nf_fp_curraddrmedianincome = NULL) => 0.0722234201, 0.0722234201),
            (iv_college_type = '') => 0.0009815342, 0.0009815342),
         (nf_fp_assoccredbureaucountnew > 1.5) => 0.2002787149,
         (nf_fp_assoccredbureaucountnew = NULL) => 0.0011864575, 0.0011864575),
      (rv_C13_Curr_Addr_LRes > 410.5) => 0.0830755036,
      (rv_C13_Curr_Addr_LRes = NULL) => 0.0017716507, 0.0017716507),
   (rv_C13_max_lres > 456.5) => -0.0427650291,
   (rv_C13_max_lres = NULL) => 0.0006437319, 0.0006437319);
   
   // Tree: 183 
   fp3_lexid_model_183 := map(
   (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 549) => 
      map(
      (NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 187.5) => -0.0071279268,
      (rv_mos_since_br_first_seen > 187.5) => 
         map(
         (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 117431) => 
            map(
            (NULL < nf_inq_count and nf_inq_count <= 4.5) => 0.0866327978,
            (nf_inq_count > 4.5) => -0.0253443301,
            (nf_inq_count = NULL) => 0.0573303718, 0.0573303718),
         (iv_prv_addr_avm_auto_val > 117431) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 114.4) => -0.0168219610,
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 114.4) => -0.1013597095,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0634194683, -0.0129294069),
         (iv_prv_addr_avm_auto_val = NULL) => 0.0286053794, 0.0286053794),
      (rv_mos_since_br_first_seen = NULL) => -0.0059436303, -0.0059436303),
   (rv_C13_Curr_Addr_LRes > 549) => 0.0944288034,
   (rv_C13_Curr_Addr_LRes = NULL) => -0.0055532527, -0.0055532527);
   
   // Tree: 184 
   fp3_lexid_model_184 := map(
   (NULL < nf_liens_unrel_ST_total_amt and nf_liens_unrel_ST_total_amt <= 8552.5) => 
      map(
      (NULL < rv_C13_max_lres and rv_C13_max_lres <= 524.5) => 0.0001763461,
      (rv_C13_max_lres > 524.5) => 
         map(
         (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 0.5) => 
            map(
            (NULL < nf_fp_curraddrcrimeindex and nf_fp_curraddrcrimeindex <= 38.5) => -0.1216225172,
            (nf_fp_curraddrcrimeindex > 38.5) => 0.1404951989,
            (nf_fp_curraddrcrimeindex = NULL) => 0.0585834126, 0.0585834126),
         (iv_unverified_addr_count > 0.5) => -0.0912982646,
         (iv_unverified_addr_count = NULL) => -0.0560319876, -0.0560319876),
      (rv_C13_max_lres = NULL) => -0.0005170804, -0.0005170804),
   (nf_liens_unrel_ST_total_amt > 8552.5) => 
      map(
      (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.64081830135) => -0.0465439643,
      (nf_add_curr_nhood_SFD_pct > 0.64081830135) => 0.2505824890,
      (nf_add_curr_nhood_SFD_pct = NULL) => 0.1484452707, 0.1484452707),
   (nf_liens_unrel_ST_total_amt = NULL) => -0.0000859303, -0.0000859303);
   
   // Tree: 185 
   fp3_lexid_model_185 := map(
   (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 1764565) => 
      map(
      (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.9901083534) => 
         map(
         (NULL < nf_fp_assocsuspicousidcount and nf_fp_assocsuspicousidcount <= 15.5) => 
            map(
            (NULL < nf_mos_liens_unrel_OT_fseen and nf_mos_liens_unrel_OT_fseen <= 237.5) => -0.0001531160,
            (nf_mos_liens_unrel_OT_fseen > 237.5) => 0.1475754109,
            (nf_mos_liens_unrel_OT_fseen = NULL) => 0.0000479533, 0.0000479533),
         (nf_fp_assocsuspicousidcount > 15.5) => 0.1905510109,
         (nf_fp_assocsuspicousidcount = NULL) => 0.0002699417, 0.0002699417),
      (nf_add_curr_nhood_MFD_pct > 0.9901083534) => -0.1011846284,
      (nf_add_curr_nhood_MFD_pct = NULL) => -0.0002495339, -0.0002495339),
   (iv_prv_addr_avm_auto_val > 1764565) => 0.1758852872,
   (iv_prv_addr_avm_auto_val = NULL) => 
      map(
      (NULL < iv_Wealth_Index and iv_Wealth_Index <= 2.5) => 0.0210834528,
      (iv_Wealth_Index > 2.5) => -0.0641785570,
      (iv_Wealth_Index = NULL) => -0.0103676632, -0.0103676632), -0.0007094198);
   
   // Tree: 186 
   fp3_lexid_model_186 := map(
   (NULL < nf_util_adl_count and nf_util_adl_count <= 20.5) => 
      map(
      (NULL < nf_fp_prevaddrmurderindex and nf_fp_prevaddrmurderindex <= 199.5) => 
         map(
         (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 819857) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 20.5) => 0.0444490618,
            (rv_comb_age > 20.5) => 
               map(
               (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 3.0612953627) => 0.0046406469,
               (nf_add_curr_nhood_VAC_pct > 3.0612953627) => 0.1932451386,
               (nf_add_curr_nhood_VAC_pct = NULL) => 0.0048861028, 0.0048861028),
            (rv_comb_age = NULL) => 0.0057954627, 0.0057954627),
         (iv_prv_addr_avm_auto_val > 819857) => -0.0381368304,
         (iv_prv_addr_avm_auto_val = NULL) => -0.0158769558, 0.0039543290),
      (nf_fp_prevaddrmurderindex > 199.5) => -0.1695000520,
      (nf_fp_prevaddrmurderindex = NULL) => 0.0037343489, 0.0037343489),
   (nf_util_adl_count > 20.5) => -0.1767881663,
   (nf_util_adl_count = NULL) => 0.0034567726, 0.0034567726);
   
   // Tree: 187 
   fp3_lexid_model_187 := map(
   (NULL < nf_acc_damage_amt_total and nf_acc_damage_amt_total <= 1075) => 0.0002457684,
   (nf_acc_damage_amt_total > 1075) => 
      map(
      (NULL < nf_oldest_rel_age and nf_oldest_rel_age <= 45) => 0.2239000642,
      (nf_oldest_rel_age > 45) => 
         map(
         (NULL < rv_C13_max_lres and rv_C13_max_lres <= 73) => -0.1794651502,
         (rv_C13_max_lres > 73) => 
            map(
            (NULL < nf_fp_sourcerisktype and nf_fp_sourcerisktype <= 4.5) => 
               map(
               (NULL < iv_Wealth_Index and iv_Wealth_Index <= 4.5) => 0.0091865122,
               (iv_Wealth_Index > 4.5) => 0.1234180023,
               (iv_Wealth_Index = NULL) => 0.0443821605, 0.0443821605),
            (nf_fp_sourcerisktype > 4.5) => 0.2843037495,
            (nf_fp_sourcerisktype = NULL) => 0.0566858317, 0.0566858317),
         (rv_C13_max_lres = NULL) => 0.0429959197, 0.0429959197),
      (nf_oldest_rel_age = NULL) => 0.0544559108, 0.0544559108),
   (nf_acc_damage_amt_total = NULL) => 0.0013293829, 0.0013293829);
   
   // Tree: 188 
   fp3_lexid_model_188 := map(
   (NULL < rv_comb_age and rv_comb_age <= 91.5) => 
      map(
      (NULL < nf_dl_addrs_per_adl and nf_dl_addrs_per_adl <= 1.5) => 
         map(
         (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.0425724638) => 0.0017140022,
         (nf_pct_rel_with_felony > 0.0425724638) => 
            map(
            (NULL < nf_average_rel_distance and nf_average_rel_distance <= 749.5) => 0.1400072253,
            (nf_average_rel_distance > 749.5) => 
               map(
               (NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.6904761905) => 0.0120311258,
               (nf_hh_collections_ct_avg > 0.6904761905) => 0.0684370211,
               (nf_hh_collections_ct_avg = NULL) => 0.0235425330, 0.0235425330),
            (nf_average_rel_distance = NULL) => 0.0270551345, 0.0270551345),
         (nf_pct_rel_with_felony = NULL) => 0.0047832878, 0.0047832878),
      (nf_dl_addrs_per_adl > 1.5) => -0.0145505407,
      (nf_dl_addrs_per_adl = NULL) => 0.0008126975, 0.0008126975),
   (rv_comb_age > 91.5) => 0.0985236223,
   (rv_comb_age = NULL) => 0.0010514265, 0.0010514265);
   
   // Tree: 189 
   fp3_lexid_model_189 := map(
   (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 477249) => -0.0009006181,
   (iv_prv_addr_avm_auto_val > 477249) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 225) => 
         map(
         (NULL < nf_pct_rel_with_criminal and nf_pct_rel_with_criminal <= 0.05131578945) => -0.0081629315,
         (nf_pct_rel_with_criminal > 0.05131578945) => 
            map(
            (NULL < rv_I60_inq_recency and rv_I60_inq_recency <= 9) => 0.1183614137,
            (rv_I60_inq_recency > 9) => 
               map(
               (NULL < nf_hh_age_30_plus and nf_hh_age_30_plus <= 2.5) => -0.0201713761,
               (nf_hh_age_30_plus > 2.5) => 0.1275923649,
               (nf_hh_age_30_plus = NULL) => 0.0217474157, 0.0217474157),
            (rv_I60_inq_recency = NULL) => 0.0688247820, 0.0688247820),
         (nf_pct_rel_with_criminal = NULL) => 0.0409591595, 0.0409591595),
      (rv_A50_pb_average_dollars > 225) => -0.0911302525,
      (rv_A50_pb_average_dollars = NULL) => 0.0307766780, 0.0307766780),
   (iv_prv_addr_avm_auto_val = NULL) => -0.0098866495, -0.0001103945);
   
   // Tree: 190 
   fp3_lexid_model_190 := map(
   (NULL < rv_C16_Inv_SSN_Per_ADL and rv_C16_Inv_SSN_Per_ADL <= 0.5) => 
      map(
      (NULL < nf_util_adl_count and nf_util_adl_count <= 8.5) => 
         map(
         (NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 18.5) => 0.0502195894,
         (iv_C13_avg_lres > 18.5) => -0.0031399214,
         (iv_C13_avg_lres = NULL) => -0.0019178685, -0.0019178685),
      (nf_util_adl_count > 8.5) => 
         map(
         (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.99596487375) => 
            map(
            (NULL < iv_A46_L77_addrs_move_traj and iv_A46_L77_addrs_move_traj <= 3.5) => 0.0921444464,
            (iv_A46_L77_addrs_move_traj > 3.5) => 0.0144382728,
            (iv_A46_L77_addrs_move_traj = NULL) => 0.0448357291, 0.0448357291),
         (nf_add_curr_nhood_SFD_pct > 0.99596487375) => -0.1204164698,
         (nf_add_curr_nhood_SFD_pct = NULL) => 0.0374428676, 0.0374428676),
      (nf_util_adl_count = NULL) => -0.0005122600, -0.0005122600),
   (rv_C16_Inv_SSN_Per_ADL > 0.5) => -0.0414914140,
   (rv_C16_Inv_SSN_Per_ADL = NULL) => -0.0020504609, -0.0020504609);
   
   // Tree: 191 
   fp3_lexid_model_191 := map(
   (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 11.5) => 
      map(
      (NULL < nf_average_rel_age and nf_average_rel_age <= 33.5) => 
         map(
         (NULL < iv_C14_addrs_per_adl and iv_C14_addrs_per_adl <= 10.5) => -0.0227138126,
         (iv_C14_addrs_per_adl > 10.5) => 0.2100201068,
         (iv_C14_addrs_per_adl = NULL) => -0.0207597075, -0.0207597075),
      (nf_average_rel_age > 33.5) => 
         map(
         (NULL < census_mod and census_mod <= -1.49473212495548) => -0.0199784999,
         (census_mod > -1.49473212495548) => 
            map(
            (NULL < nf_mos_foreclosure_lseen and nf_mos_foreclosure_lseen <= 16.5) => 0.0083714475,
            (nf_mos_foreclosure_lseen > 16.5) => -0.0766506292,
            (nf_mos_foreclosure_lseen = NULL) => 0.0073779214, 0.0073779214),
         (census_mod = NULL) => 0.0026285227, 0.0026285227),
      (nf_average_rel_age = NULL) => 0.0000295880, 0.0000295880),
   (iv_unverified_addr_count > 11.5) => -0.0392406572,
   (iv_unverified_addr_count = NULL) => -0.0011709676, -0.0011709676);
   
   // Tree: 192 
   fp3_lexid_model_192 := map(
   (NULL < rv_comb_age and rv_comb_age <= 35.5) => -0.0087209603,
   (rv_comb_age > 35.5) => 
      map(
      (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 249.5) => 0.0284120375,
      (rv_C20_M_Bureau_ADL_FS > 249.5) => 
         map(
         (NULL < nf_inq_Collection_count24 and nf_inq_Collection_count24 <= 0.5) => 
            map(
            (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 
               map(
               (NULL < nf_average_rel_distance and nf_average_rel_distance <= 146.5) => -0.1237590885,
               (nf_average_rel_distance > 146.5) => 0.0010204531,
               (nf_average_rel_distance = NULL) => -0.0001090742, -0.0001090742),
            (nf_fp_varrisktype > 1.5) => 0.0384760166,
            (nf_fp_varrisktype = NULL) => 0.0046938253, 0.0046938253),
         (nf_inq_Collection_count24 > 0.5) => -0.0372398100,
         (nf_inq_Collection_count24 = NULL) => -0.0002471521, -0.0002471521),
      (rv_C20_M_Bureau_ADL_FS = NULL) => 0.0078863175, 0.0078863175),
   (rv_comb_age = NULL) => 0.0014829503, 0.0014829503);
   
   // Tree: 193 
   fp3_lexid_model_193 := map(
   (NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 74.5) => 
      map(
      (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 28.5) => 
         map(
         (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= -82907.5) => 0.1554840251,
         (iv_prop1_purch_sale_diff > -82907.5) => 0.0110756830,
         (iv_prop1_purch_sale_diff = NULL) => -0.0131056624, -0.0108713857),
      (nf_mos_inq_banko_om_fseen > 28.5) => 
         map(
         (NULL < nf_current_count and nf_current_count <= 2.5) => 0.0670533553,
         (nf_current_count > 2.5) => -0.0640757151,
         (nf_current_count = NULL) => 0.0417017350, 0.0417017350),
      (nf_mos_inq_banko_om_fseen = NULL) => -0.0077308170, -0.0077308170),
   (nf_fp_prevaddrcartheftindex > 74.5) => 
      map(
      (NULL < nf_mos_liens_unrel_FT_fseen and nf_mos_liens_unrel_FT_fseen <= 124.5) => 0.0095752915,
      (nf_mos_liens_unrel_FT_fseen > 124.5) => -0.1108095279,
      (nf_mos_liens_unrel_FT_fseen = NULL) => 0.0086974440, 0.0086974440),
   (nf_fp_prevaddrcartheftindex = NULL) => 0.0012351858, 0.0012351858);
   
   // Tree: 194 
   fp3_lexid_model_194 := map(
   (NULL < rv_C18_invalid_addrs_per_adl and rv_C18_invalid_addrs_per_adl <= 0.5) => 
      map(
      (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 14.5) => -0.0134012866,
      (iv_prv_addr_lres > 14.5) => 0.0236078480,
      (iv_prv_addr_lres = NULL) => 
         map(
         (NULL < rv_Ever_Asset_Owner and rv_Ever_Asset_Owner <= 0.5) => 
            map(
            (NULL < rv_comb_age and rv_comb_age <= 54.5) => 0.0368464527,
            (rv_comb_age > 54.5) => 0.2338796878,
            (rv_comb_age = NULL) => 0.0460464481, 0.0460464481),
         (rv_Ever_Asset_Owner > 0.5) => -0.0257472842,
         (rv_Ever_Asset_Owner = NULL) => 0.0011753654, 0.0011753654), 0.0109633597),
   (rv_C18_invalid_addrs_per_adl > 0.5) => 
      map(
      (NULL < nf_inq_Utilities_count and nf_inq_Utilities_count <= 1.5) => -0.0076803666,
      (nf_inq_Utilities_count > 1.5) => 0.1958950372,
      (nf_inq_Utilities_count = NULL) => -0.0072860589, -0.0072860589),
   (rv_C18_invalid_addrs_per_adl = NULL) => -0.0009674288, -0.0009674288);
   
   // Tree: 195 
   fp3_lexid_model_195 := map(
   (NULL < iv_unverified_addr_count and iv_unverified_addr_count <= 19.5) => 
      map(
      (NULL < rv_D33_eviction_count and rv_D33_eviction_count <= 12.5) => 
         map(
         (NULL < nf_inq_Auto_count24 and nf_inq_Auto_count24 <= 1.5) => 0.0002317375,
         (nf_inq_Auto_count24 > 1.5) => 
            map(
            (NULL < rv_C13_max_lres and rv_C13_max_lres <= 406.5) => 
               map(
               (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.470647653) => -0.0878417538,
               (nf_add_curr_nhood_SFD_pct > 0.470647653) => -0.0201071087,
               (nf_add_curr_nhood_SFD_pct = NULL) => -0.0335604493, -0.0335604493),
            (rv_C13_max_lres > 406.5) => 0.1669257632,
            (rv_C13_max_lres = NULL) => -0.0278418828, -0.0278418828),
         (nf_inq_Auto_count24 = NULL) => -0.0012857555, -0.0012857555),
      (rv_D33_eviction_count > 12.5) => 0.1612117247,
      (rv_D33_eviction_count = NULL) => -0.0010796899, -0.0010796899),
   (iv_unverified_addr_count > 19.5) => 0.1668842970,
   (iv_unverified_addr_count = NULL) => -0.0008366161, -0.0008366161);
   
   // Tree: 196 
   fp3_lexid_model_196 := map(
   (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 
      map(
      (NULL < nf_mos_inq_banko_cm_lseen and nf_mos_inq_banko_cm_lseen <= 23) => 
         map(
         (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= 173500) => -0.0757495627,
         (iv_prop1_purch_sale_diff > 173500) => 0.1207438851,
         (iv_prop1_purch_sale_diff = NULL) => 0.0130143937, 0.0111840250),
      (nf_mos_inq_banko_cm_lseen > 23) => 
         map(
         (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 71.5) => 
            map(
            (NULL < nf_fp_curraddrcrimeindex and nf_fp_curraddrcrimeindex <= 89.5) => 0.1620056213,
            (nf_fp_curraddrcrimeindex > 89.5) => -0.0639956622,
            (nf_fp_curraddrcrimeindex = NULL) => 0.0301715393, 0.0301715393),
         (rv_C13_Curr_Addr_LRes > 71.5) => 0.2069224266,
         (rv_C13_Curr_Addr_LRes = NULL) => 0.0990744276, 0.0990744276),
      (nf_mos_inq_banko_cm_lseen = NULL) => 0.0137422558, 0.0137422558),
   (nf_hh_members_ct > 1.5) => -0.0039631152,
   (nf_hh_members_ct = NULL) => -0.0007170238, -0.0007170238);
   
   // Tree: 197 
   fp3_lexid_model_197 := map(
   (iv_pb_profile in ['2 ONLINE SHOPPER']) => 
      map(
      (NULL < rv_I60_inq_hiRiskCred_count12 and rv_I60_inq_hiRiskCred_count12 <= 6.5) => 
         map(
         (NULL < nf_add_curr_nhood_MFD_pct and nf_add_curr_nhood_MFD_pct <= 0.1996639163) => 
            map(
            (NULL < rv_C13_max_lres and rv_C13_max_lres <= 55) => -0.1148846416,
            (rv_C13_max_lres > 55) => 0.0070447929,
            (rv_C13_max_lres = NULL) => 0.0010616385, 0.0010616385),
         (nf_add_curr_nhood_MFD_pct > 0.1996639163) => -0.0399565435,
         (nf_add_curr_nhood_MFD_pct = NULL) => -0.0120226423, -0.0120226423),
      (rv_I60_inq_hiRiskCred_count12 > 6.5) => -0.1808775347,
      (rv_I60_inq_hiRiskCred_count12 = NULL) => -0.0131268242, -0.0131268242),
   (iv_pb_profile in ['NA','0 NO PURCH DATA','1 OFFLINE SHOPPER','3 RETAIL SHOPPER','4 OTHER']) => 
      map(
      (NULL < nf_dl_addrs_per_adl and nf_dl_addrs_per_adl <= 1.5) => 0.0119047386,
      (nf_dl_addrs_per_adl > 1.5) => -0.0090248499,
      (nf_dl_addrs_per_adl = NULL) => 0.0077732914, 0.0077732914),
   (iv_pb_profile = '') => 0.0040152026, 0.0040152026);
   
   // Tree: 198 
   fp3_lexid_model_198 := map(
   (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 143) => 
      map(
      (NULL < nf_fp_curraddrcartheftindex and nf_fp_curraddrcartheftindex <= 187.5) => 
         map(
         (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= -0.5) => 
            map(
            (NULL < nf_inq_Communications_count24 and nf_inq_Communications_count24 <= 0.5) => 0.0060230141,
            (nf_inq_Communications_count24 > 0.5) => 0.0527188965,
            (nf_inq_Communications_count24 = NULL) => 0.0078245714, 0.0078245714),
         (nf_mos_inq_banko_om_fseen > -0.5) => 
            map(
            (NULL < nf_mos_inq_banko_om_fseen and nf_mos_inq_banko_om_fseen <= 6.5) => -0.0626866068,
            (nf_mos_inq_banko_om_fseen > 6.5) => 0.0010025690,
            (nf_mos_inq_banko_om_fseen = NULL) => -0.0182485673, -0.0182485673),
         (nf_mos_inq_banko_om_fseen = NULL) => 0.0043514579, 0.0043514579),
      (nf_fp_curraddrcartheftindex > 187.5) => 0.1800366649,
      (nf_fp_curraddrcartheftindex = NULL) => 0.0046457051, 0.0046457051),
   (nf_fp_curraddrmurderindex > 143) => -0.0153931580,
   (nf_fp_curraddrmurderindex = NULL) => 0.0008394811, 0.0008394811);
   
   // Tree: 199 
   fp3_lexid_model_199 := map(
   (NULL < iv_prof_license_category_PM and iv_prof_license_category_PM <= 0) => -0.0251892608,
   (iv_prof_license_category_PM > 0) => -0.1062053762,
   (iv_prof_license_category_PM = NULL) => 
      map(
      (NULL < nf_current_count and nf_current_count <= 10.5) => 
         map(
         (NULL < nf_liens_rel_O_total_amt and nf_liens_rel_O_total_amt <= 3861) => -0.0037475244,
         (nf_liens_rel_O_total_amt > 3861) => 0.1520432532,
         (nf_liens_rel_O_total_amt = NULL) => -0.0034773259, -0.0034773259),
      (nf_current_count > 10.5) => 
         map(
         (NULL < rv_I61_inq_collection_recency and rv_I61_inq_collection_recency <= 1.5) => 
            map(
            (NULL < nf_fp_vardobcount and nf_fp_vardobcount <= 1.5) => 0.0854373450,
            (nf_fp_vardobcount > 1.5) => 0.3506903598,
            (nf_fp_vardobcount = NULL) => 0.2117483045, 0.2117483045),
         (rv_I61_inq_collection_recency > 1.5) => -0.0397668636,
         (rv_I61_inq_collection_recency = NULL) => 0.0992283608, 0.0992283608),
      (nf_current_count = NULL) => -0.0031222985, -0.0031222985), -0.0035777927);
   
   // Tree: 200 
   fp3_lexid_model_200 := map(
   (NULL < nf_rel_derog_summary and nf_rel_derog_summary <= 7.5) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 95.85) => -0.0120162706,
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 95.85) => 
         map(
         (NULL < nf_fp_prevaddrmedianvalue and nf_fp_prevaddrmedianvalue <= 185589) => -0.0109142496,
         (nf_fp_prevaddrmedianvalue > 185589) => 
            map(
            (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.5824468085) => 
               map(
               (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.74059264615) => -0.0051109912,
               (nf_add_curr_nhood_SFD_pct > 0.74059264615) => 0.0351804393,
               (nf_add_curr_nhood_SFD_pct = NULL) => 0.0228767413, 0.0228767413),
            (nf_add_curr_nhood_VAC_pct > 0.5824468085) => 0.2055891857,
            (nf_add_curr_nhood_VAC_pct = NULL) => 0.0246720400, 0.0246720400),
         (nf_fp_prevaddrmedianvalue = NULL) => 0.0095002271, 0.0095002271),
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => -0.0043019565, -0.0002127392),
   (nf_rel_derog_summary > 7.5) => -0.0492198724,
   (nf_rel_derog_summary = NULL) => -0.0013873856, -0.0013873856);
   
   // Tree: 201 
   fp3_lexid_model_201 := map(
   (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 521) => 
      map(
      (NULL < nf_mos_liens_unrel_FT_fseen and nf_mos_liens_unrel_FT_fseen <= 241) => 
         map(
         (NULL < nf_hh_age_65_plus and nf_hh_age_65_plus <= 4.5) => 
            map(
            (NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 158.5) => -0.0008183099,
            (nf_mos_acc_lseen > 158.5) => 
               map(
               (NULL < nf_highest_rel_income and nf_highest_rel_income <= 112.5) => -0.0039979066,
               (nf_highest_rel_income > 112.5) => 0.1105907613,
               (nf_highest_rel_income = NULL) => 0.0471135855, 0.0471135855),
            (nf_mos_acc_lseen = NULL) => -0.0002127901, -0.0002127901),
         (nf_hh_age_65_plus > 4.5) => -0.1211703239,
         (nf_hh_age_65_plus = NULL) => -0.0004651050, -0.0004651050),
      (nf_mos_liens_unrel_FT_fseen > 241) => 0.1395339972,
      (nf_mos_liens_unrel_FT_fseen = NULL) => -0.0002875699, -0.0002875699),
   (nf_M_Bureau_ADL_FS_noTU > 521) => -0.1504253738,
   (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0005048460, -0.0005048460);
   
   // Tree: 202 
   fp3_lexid_model_202 := map(
   (NULL < nf_liens_unrel_FT_total_amt and nf_liens_unrel_FT_total_amt <= 127434) => 
      map(
      (NULL < nf_hh_age_65_plus and nf_hh_age_65_plus <= 2.5) => 0.0003745108,
      (nf_hh_age_65_plus > 2.5) => 
         map(
         (NULL < nf_pct_rel_with_felony and nf_pct_rel_with_felony <= 0.13392857145) => 
            map(
            (NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 149.5) => 
               map(
               (NULL < nf_hh_payday_loan_users_pct and nf_hh_payday_loan_users_pct <= 0.0839160839) => -0.0388186169,
               (nf_hh_payday_loan_users_pct > 0.0839160839) => 0.1435895095,
               (nf_hh_payday_loan_users_pct = NULL) => -0.0217459351, -0.0217459351),
            (nf_fp_prevaddrlenofres > 149.5) => -0.1063622608,
            (nf_fp_prevaddrlenofres = NULL) => -0.0485268597, -0.0485268597),
         (nf_pct_rel_with_felony > 0.13392857145) => 0.1036386507,
         (nf_pct_rel_with_felony = NULL) => -0.0393776677, -0.0393776677),
      (nf_hh_age_65_plus = NULL) => -0.0007635294, -0.0007635294),
   (nf_liens_unrel_FT_total_amt > 127434) => 0.1774997208,
   (nf_liens_unrel_FT_total_amt = NULL) => -0.0004733034, -0.0004733034);
   
   // Tree: 203 
   fp3_lexid_model_203 := map(
   (NULL < nf_accident_count and nf_accident_count <= 2.5) => 
      map(
      (NULL < nf_hh_members_ct and nf_hh_members_ct <= 1.5) => 0.0161374952,
      (nf_hh_members_ct > 1.5) => -0.0036375852,
      (nf_hh_members_ct = NULL) => -0.0000582866, -0.0000582866),
   (nf_accident_count > 2.5) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 126.05) => 
         map(
         (NULL < nf_oldest_rel_age and nf_oldest_rel_age <= 45) => 0.2331872624,
         (nf_oldest_rel_age > 45) => -0.0393437118,
         (nf_oldest_rel_age = NULL) => -0.0044038433, -0.0044038433),
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 126.05) => 0.1407147523,
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 
         map(
         (NULL < nf_mos_acc_lseen and nf_mos_acc_lseen <= 39.5) => 0.0181306692,
         (nf_mos_acc_lseen > 39.5) => 0.2238110138,
         (nf_mos_acc_lseen = NULL) => 0.1077011419, 0.1077011419), 0.0576955330),
   (nf_accident_count = NULL) => 0.0007827377, 0.0007827377);
   
   // Tree: 204 
   fp3_lexid_model_204 := map(
   (NULL < rv_C13_Curr_Addr_LRes and rv_C13_Curr_Addr_LRes <= 79.5) => -0.0107069763,
   (rv_C13_Curr_Addr_LRes > 79.5) => 
      map(
      (NULL < nf_fp_srchunvrfdaddrcount and nf_fp_srchunvrfdaddrcount <= 0.5) => 
         map(
         (NULL < nf_historical_count and nf_historical_count <= 9.5) => 0.0039627284,
         (nf_historical_count > 9.5) => 
            map(
            (NULL < nf_hh_pct_property_owners and nf_hh_pct_property_owners <= 0.6904761905) => 0.0804639184,
            (nf_hh_pct_property_owners > 0.6904761905) => -0.0371780703,
            (nf_hh_pct_property_owners = NULL) => 0.0530521929, 0.0530521929),
         (nf_historical_count = NULL) => 0.0070104770, 0.0070104770),
      (nf_fp_srchunvrfdaddrcount > 0.5) => 
         map(
         (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 19215.5) => -0.1368125087,
         (nf_fp_prevaddrmedianincome > 19215.5) => 0.0875441397,
         (nf_fp_prevaddrmedianincome = NULL) => 0.0698981112, 0.0698981112),
      (nf_fp_srchunvrfdaddrcount = NULL) => 0.0091819608, 0.0091819608),
   (rv_C13_Curr_Addr_LRes = NULL) => -0.0014326687, -0.0014326687);
   
   // Tree: 205 
   fp3_lexid_model_205 := map(
   (NULL < nf_current_count and nf_current_count <= 9.5) => 
      map(
      (NULL < nf_liens_unrel_ST_ct and nf_liens_unrel_ST_ct <= 5.5) => 
         map(
         (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 12.5) => 
            map(
            (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 1.5) => 0.0435479960,
            (nf_fp_prevaddrageoldest > 1.5) => -0.0240988149,
            (nf_fp_prevaddrageoldest = NULL) => -0.0179063071, -0.0179063071),
         (iv_prv_addr_lres > 12.5) => 
            map(
            (NULL < nf_fp_prevaddrcartheftindex and nf_fp_prevaddrcartheftindex <= 66) => -0.0089111446,
            (nf_fp_prevaddrcartheftindex > 66) => 0.0097382339,
            (nf_fp_prevaddrcartheftindex = NULL) => 0.0026139251, 0.0026139251),
         (iv_prv_addr_lres = NULL) => -0.0028473823, -0.0011914503),
      (nf_liens_unrel_ST_ct > 5.5) => 0.1962790900,
      (nf_liens_unrel_ST_ct = NULL) => -0.0010119806, -0.0010119806),
   (nf_current_count > 9.5) => -0.0913943621,
   (nf_current_count = NULL) => -0.0014452536, -0.0014452536);
   
   // Tree: 206 
   fp3_lexid_model_206 := map(
   (NULL < nf_rel_bankrupt_count and nf_rel_bankrupt_count <= 8.5) => 0.0013805944,
   (nf_rel_bankrupt_count > 8.5) => 
      map(
      (NULL < rv_C14_Addr_Stability_v2 and rv_C14_Addr_Stability_v2 <= 3.5) => 
         map(
         (NULL < census_mod and census_mod <= -1.1028102925758) => 0.3271516749,
         (census_mod > -1.1028102925758) => 0.0822198545,
         (census_mod = NULL) => 0.2128501587, 0.2128501587),
      (rv_C14_Addr_Stability_v2 > 3.5) => 
         map(
         (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 81170) => 
            map(
            (NULL < nf_fp_srchvelocityrisktype and nf_fp_srchvelocityrisktype <= 4) => -0.0986199710,
            (nf_fp_srchvelocityrisktype > 4) => 0.1069329192,
            (nf_fp_srchvelocityrisktype = NULL) => -0.0323125871, -0.0323125871),
         (nf_fp_curraddrmedianincome > 81170) => 0.1762763921,
         (nf_fp_curraddrmedianincome = NULL) => 0.0104748958, 0.0104748958),
      (rv_C14_Addr_Stability_v2 = NULL) => 0.0666902466, 0.0666902466),
   (nf_rel_bankrupt_count = NULL) => 0.0020185685, 0.0020185685);
   
   // Tree: 207 
   fp3_lexid_model_207 := map(
   (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 1.5) => -0.1072263352,
   (rv_C10_M_Hdr_FS > 1.5) => 
      map(
      (NULL < rv_bus_leadership_title and rv_bus_leadership_title <= 0.5) => 
         map(
         (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 2.5) => 0.1065590386,
         (rv_C10_M_Hdr_FS > 2.5) => 
            map(
            (NULL < rv_D32_Mos_Since_Fel_LS and rv_D32_Mos_Since_Fel_LS <= 217) => 
               map(
               (NULL < rv_comb_age and rv_comb_age <= 86.5) => 0.0027746838,
               (rv_comb_age > 86.5) => 0.0401380781,
               (rv_comb_age = NULL) => 0.0030225154, 0.0030225154),
            (rv_D32_Mos_Since_Fel_LS > 217) => -0.1331456282,
            (rv_D32_Mos_Since_Fel_LS = NULL) => 0.0027132868, 0.0027132868),
         (rv_C10_M_Hdr_FS = NULL) => 0.0030607337, 0.0030607337),
      (rv_bus_leadership_title > 0.5) => -0.0237254055,
      (rv_bus_leadership_title = NULL) => 0.0009707247, 0.0009707247),
   (rv_C10_M_Hdr_FS = NULL) => 0.0006379913, 0.0006379913);
   
   // Tree: 208 
   fp3_lexid_model_208 := map(
   (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 58119) => 
      map(
      (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 56397.5) => 
         map(
         (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 2.5) => 
            map(
            (NULL < nf_hh_workers_paw_pct and nf_hh_workers_paw_pct <= 0.29910714285) => 0.1614358268,
            (nf_hh_workers_paw_pct > 0.29910714285) => -0.0754216567,
            (nf_hh_workers_paw_pct = NULL) => 0.1062772347, 0.1062772347),
         (iv_prv_addr_lres > 2.5) => 0.0115515905,
         (iv_prv_addr_lres = NULL) => 
            map(
            (NULL < nf_pct_rel_prop_sold and nf_pct_rel_prop_sold <= 0.2039473684) => -0.0269277852,
            (nf_pct_rel_prop_sold > 0.2039473684) => 0.1765453776,
            (nf_pct_rel_prop_sold = NULL) => -0.0048111371, -0.0048111371), 0.0196497957),
      (nf_fp_curraddrmedianvalue > 56397.5) => 0.2184016903,
      (nf_fp_curraddrmedianvalue = NULL) => 0.0254274671, 0.0254274671),
   (nf_fp_curraddrmedianvalue > 58119) => -0.0022481872,
   (nf_fp_curraddrmedianvalue = NULL) => -0.0005259685, -0.0005259685);
   
   // Tree: 209 
   fp3_lexid_model_209 := map(
   (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.70714285715) => 
      map(
      (NULL < rv_comb_age and rv_comb_age <= 61.5) => 0.0028331875,
      (rv_comb_age > 61.5) => 
         map(
         (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= 124800) => 
            map(
            (NULL < nf_hh_prof_license_holders_pct and nf_hh_prof_license_holders_pct <= 0.20833333335) => 0.1322939359,
            (nf_hh_prof_license_holders_pct > 0.20833333335) => -0.1765715032,
            (nf_hh_prof_license_holders_pct = NULL) => 0.0823304090, 0.0823304090),
         (iv_prop1_purch_sale_diff > 124800) => -0.0207643551,
         (iv_prop1_purch_sale_diff = NULL) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 90.85) => -0.0629239172,
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 90.85) => -0.0111388023,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0020651696, -0.0097503586), -0.0064329076),
      (rv_comb_age = NULL) => 0.0013625924, 0.0013625924),
   (nf_pct_rel_with_bk > 0.70714285715) => 0.1162397248,
   (nf_pct_rel_with_bk = NULL) => 0.0017574306, 0.0017574306);
   
   // Tree: 210 
   fp3_lexid_model_210 := map(
   (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 368.5) => 0.0059460969,
   (rv_C20_M_Bureau_ADL_FS > 368.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS and nf_M_Bureau_ADL_FS <= 372) => -0.1040991378,
      (nf_M_Bureau_ADL_FS > 372) => 
         map(
         (NULL < rv_D30_Derog_Count and rv_D30_Derog_Count <= 2.5) => 
            map(
            (NULL < rv_C12_source_profile and rv_C12_source_profile <= 84.4) => 
               map(
               (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 756500) => 0.0401488389,
               (rv_A46_Curr_AVM_AutoVal > 756500) => -0.1359885779,
               (rv_A46_Curr_AVM_AutoVal = NULL) => 0.0294413972, 0.0294413972),
            (rv_C12_source_profile > 84.4) => -0.1103490347,
            (rv_C12_source_profile = NULL) => 0.0146266503, 0.0146266503),
         (rv_D30_Derog_Count > 2.5) => -0.1045336125,
         (rv_D30_Derog_Count = NULL) => 0.0026814895, 0.0026814895),
      (nf_M_Bureau_ADL_FS = NULL) => -0.0285398358, -0.0285398358),
   (rv_C20_M_Bureau_ADL_FS = NULL) => 0.0041431963, 0.0041431963);
   
   // Tree: 211 
   fp3_lexid_model_211 := map(
   (NULL < census_mod and census_mod <= 0.0540954693595442) => 
      map(
      (NULL < rv_I62_inq_addrs_per_adl and rv_I62_inq_addrs_per_adl <= 3.5) => 
         map(
         (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 652147) => -0.0017556684,
         (nf_fp_curraddrmedianvalue > 652147) => -0.0312815878,
         (nf_fp_curraddrmedianvalue = NULL) => -0.0031722408, -0.0031722408),
      (rv_I62_inq_addrs_per_adl > 3.5) => 
         map(
         (NULL < nf_fp_assocrisktype and nf_fp_assocrisktype <= 5.5) => 0.1420502874,
         (nf_fp_assocrisktype > 5.5) => 
            map(
            (NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.4722222222) => 0.1523360111,
            (nf_hh_collections_ct_avg > 0.4722222222) => -0.2966865427,
            (nf_hh_collections_ct_avg = NULL) => -0.0272730104, -0.0272730104),
         (nf_fp_assocrisktype = NULL) => 0.0944875633, 0.0944875633),
      (rv_I62_inq_addrs_per_adl = NULL) => -0.0023813652, -0.0023813652),
   (census_mod > 0.0540954693595442) => 0.0740963370,
   (census_mod = NULL) => -0.0019248232, -0.0019248232);
   
   // Tree: 212 
   fp3_lexid_model_212 := map(
   (NULL < nf_average_rel_income and nf_average_rel_income <= 50500) => 
      map(
      (NULL < nf_inq_Mortgage_count24 and nf_inq_Mortgage_count24 <= 0.5) => 
         map(
         (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 120) => 0.0102198653,
         (rv_A50_pb_average_dollars > 120) => 
            map(
            (NULL < rv_C18_invalid_addrs_per_adl and rv_C18_invalid_addrs_per_adl <= 4.5) => 0.0309428275,
            (rv_C18_invalid_addrs_per_adl > 4.5) => 
               map(
               (NULL < nf_fp_curraddrmedianincome and nf_fp_curraddrmedianincome <= 42206.5) => 0.1491507509,
               (nf_fp_curraddrmedianincome > 42206.5) => 0.3766510573,
               (nf_fp_curraddrmedianincome = NULL) => 0.2674509102, 0.2674509102),
            (rv_C18_invalid_addrs_per_adl = NULL) => 0.0889104949, 0.0889104949),
         (rv_A50_pb_average_dollars = NULL) => 0.0153420377, 0.0153420377),
      (nf_inq_Mortgage_count24 > 0.5) => -0.1206118305,
      (nf_inq_Mortgage_count24 = NULL) => 0.0116288346, 0.0116288346),
   (nf_average_rel_income > 50500) => -0.0065309655,
   (nf_average_rel_income = NULL) => -0.0038848514, -0.0038848514);
   
   // Tree: 213 
   fp3_lexid_model_213 := map(
   (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 8.5) => 
      map(
      (NULL < nf_fp_prevaddrageoldest and nf_fp_prevaddrageoldest <= 406.5) => -0.0218985087,
      (nf_fp_prevaddrageoldest > 406.5) => 0.1908439356,
      (nf_fp_prevaddrageoldest = NULL) => -0.0196762687, -0.0196762687),
   (iv_prv_addr_lres > 8.5) => 0.0008177938,
   (iv_prv_addr_lres = NULL) => 
      map(
      (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 15.5) => 
         map(
         (NULL < nf_util_adl_count and nf_util_adl_count <= 0.5) => -0.0349580562,
         (nf_util_adl_count > 0.5) => 
            map(
            (NULL < rv_C12_Num_NonDerogs and rv_C12_Num_NonDerogs <= 1.5) => 0.1793022882,
            (rv_C12_Num_NonDerogs > 1.5) => -0.0283429072,
            (rv_C12_Num_NonDerogs = NULL) => 0.1318405293, 0.1318405293),
         (nf_util_adl_count = NULL) => 0.0602259192, 0.0602259192),
      (rv_C10_M_Hdr_FS > 15.5) => -0.0125248177,
      (rv_C10_M_Hdr_FS = NULL) => 0.0074544892, 0.0074544892), -0.0014418740);
   
   // Tree: 214 
   fp3_lexid_model_214 := map(
   (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 448.5) => -0.0012740714,
   (nf_M_Bureau_ADL_FS_all > 448.5) => 
      map(
      (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 121803.5) => 
         map(
         (NULL < rv_C12_source_profile and rv_C12_source_profile <= 83.2) => 
            map(
            (NULL < nf_inq_Auto_count24 and nf_inq_Auto_count24 <= 0.5) => 0.0464958033,
            (nf_inq_Auto_count24 > 0.5) => 0.1942158074,
            (nf_inq_Auto_count24 = NULL) => 0.0542933402, 0.0542933402),
         (rv_C12_source_profile > 83.2) => 
            map(
            (NULL < nf_hh_criminals_pct and nf_hh_criminals_pct <= 0.29166666665) => -0.0728047515,
            (nf_hh_criminals_pct > 0.29166666665) => 0.1727338052,
            (nf_hh_criminals_pct = NULL) => -0.0311880470, -0.0311880470),
         (rv_C12_source_profile = NULL) => 0.0416848355, 0.0416848355),
      (nf_fp_prevaddrmedianincome > 121803.5) => -0.1253808520,
      (nf_fp_prevaddrmedianincome = NULL) => 0.0318574422, 0.0318574422),
   (nf_M_Bureau_ADL_FS_all = NULL) => -0.0000004740, -0.0000004740);
   
   // Tree: 215 
   fp3_lexid_model_215 := map(
   (NULL < nf_mos_liens_unrel_OT_fseen and nf_mos_liens_unrel_OT_fseen <= 49.5) => 
      map(
      (NULL < nf_mos_liens_unrel_OT_lseen and nf_mos_liens_unrel_OT_lseen <= 24.5) => -0.0000100175,
      (nf_mos_liens_unrel_OT_lseen > 24.5) => 
         map(
         (NULL < nf_liens_unrel_OT_total_amt and nf_liens_unrel_OT_total_amt <= 1939) => 0.1730475548,
         (nf_liens_unrel_OT_total_amt > 1939) => -0.0554126857,
         (nf_liens_unrel_OT_total_amt = NULL) => 0.1148940391, 0.1148940391),
      (nf_mos_liens_unrel_OT_lseen = NULL) => 0.0005755758, 0.0005755758),
   (nf_mos_liens_unrel_OT_fseen > 49.5) => 
      map(
      (NULL < nf_liens_unrel_OT_total_amt and nf_liens_unrel_OT_total_amt <= 226) => 
         map(
         (NULL < nf_fp_varrisktype and nf_fp_varrisktype <= 1.5) => 0.2111160468,
         (nf_fp_varrisktype > 1.5) => -0.0764281098,
         (nf_fp_varrisktype = NULL) => 0.0960983842, 0.0960983842),
      (nf_liens_unrel_OT_total_amt > 226) => -0.0615899300,
      (nf_liens_unrel_OT_total_amt = NULL) => -0.0436708034, -0.0436708034),
   (nf_mos_liens_unrel_OT_fseen = NULL) => -0.0004809585, -0.0004809585);
   
   // Tree: 216 
   fp3_lexid_model_216 := map(
   (NULL < rv_C14_addrs_15yr and rv_C14_addrs_15yr <= 11.5) => 
      map(
      (NULL < rv_br_active_phone_count and rv_br_active_phone_count <= 6.5) => 
         map(
         (NULL < nf_fp_srchfraudsrchcountyr and nf_fp_srchfraudsrchcountyr <= 28.5) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 86.25) => -0.0259773257,
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 86.25) => 0.0046612691,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0002087094, 0.0006192400),
         (nf_fp_srchfraudsrchcountyr > 28.5) => -0.1725331774,
         (nf_fp_srchfraudsrchcountyr = NULL) => 0.0004610955, 0.0004610955),
      (rv_br_active_phone_count > 6.5) => 0.2125822116,
      (rv_br_active_phone_count = NULL) => 0.0006739908, 0.0006739908),
   (rv_C14_addrs_15yr > 11.5) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 27.5) => 0.0111394131,
      (rv_A50_pb_average_dollars > 27.5) => 0.1559953151,
      (rv_A50_pb_average_dollars = NULL) => 0.0850762797, 0.0850762797),
   (rv_C14_addrs_15yr = NULL) => 0.0014068616, 0.0014068616);
   
   // Tree: 217 
   fp3_lexid_model_217 := map(
   (rv_A43_rec_vehx_level in ['AO','W1','W2','XX']) => 
      map(
      (NULL < nf_fp_curraddrburglaryindex and nf_fp_curraddrburglaryindex <= 65) => 0.0061601809,
      (nf_fp_curraddrburglaryindex > 65) => -0.0091643727,
      (nf_fp_curraddrburglaryindex = NULL) => -0.0020905342, -0.0020905342),
   (rv_A43_rec_vehx_level in ['NA','AW','W3']) => 
      map(
      (NULL < nf_add_curr_nhood_VAC_pct and nf_add_curr_nhood_VAC_pct <= 0.00028669725) => 
         map(
         (NULL < nf_average_rel_age and nf_average_rel_age <= 43.5) => 0.2674211505,
         (nf_average_rel_age > 43.5) => 0.0428192989,
         (nf_average_rel_age = NULL) => 0.1642257052, 0.1642257052),
      (nf_add_curr_nhood_VAC_pct > 0.00028669725) => 
         map(
         (NULL < nf_historical_count and nf_historical_count <= 5.5) => 0.1471397431,
         (nf_historical_count > 5.5) => -0.0775823535,
         (nf_historical_count = NULL) => 0.0041347725, 0.0041347725),
      (nf_add_curr_nhood_VAC_pct = NULL) => 0.0685191694, 0.0685191694),
   (rv_A43_rec_vehx_level = '') => -0.0015029715, -0.0015029715);
   
   // Tree: 218 
   fp3_lexid_model_218 := map(
   (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 375.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 372) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 368.5) => 0.0003536009,
         (nf_M_Bureau_ADL_FS_noTU > 368.5) => -0.1002989911,
         (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0010802238, -0.0010802238),
      (nf_M_Bureau_ADL_FS_noTU > 372) => 
         map(
         (NULL < iv_D57_attr_proflic_recency and iv_D57_attr_proflic_recency <= 4.5) => 
            map(
            (nf_fp_prevaddrstatus in ['R','U']) => 0.0265081404,
            (nf_fp_prevaddrstatus in ['NA','-1','O']) => 0.1211370360,
            (nf_fp_prevaddrstatus = '') => 0.0651961972, 0.0651961972),
         (iv_D57_attr_proflic_recency > 4.5) => -0.0842366284,
         (iv_D57_attr_proflic_recency = NULL) => 0.0439498239, 0.0439498239),
      (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0002013652, -0.0002013652),
   (rv_C20_M_Bureau_ADL_FS > 375.5) => -0.0397459580,
   (rv_C20_M_Bureau_ADL_FS = NULL) => -0.0010776700, -0.0010776700);
   
   // Tree: 219 
   fp3_lexid_model_219 := map(
   (NULL < rv_comb_age and rv_comb_age <= 85.5) => 
      map(
      (NULL < nf_inq_count24 and nf_inq_count24 <= 35) => 
         map(
         (NULL < nf_inq_PrepaidCards_count and nf_inq_PrepaidCards_count <= 4.5) => -0.0029738038,
         (nf_inq_PrepaidCards_count > 4.5) => 0.1196770182,
         (nf_inq_PrepaidCards_count = NULL) => -0.0026709623, -0.0026709623),
      (nf_inq_count24 > 35) => -0.1533487539,
      (nf_inq_count24 = NULL) => -0.0029048485, -0.0029048485),
   (rv_comb_age > 85.5) => 
      map(
      (NULL < nf_fp_prevaddrburglaryindex and nf_fp_prevaddrburglaryindex <= 166.5) => 
         map(
         (NULL < nf_fp_curraddrmurderindex and nf_fp_curraddrmurderindex <= 17) => -0.1190002204,
         (nf_fp_curraddrmurderindex > 17) => 0.1017809131,
         (nf_fp_curraddrmurderindex = NULL) => 0.0698903049, 0.0698903049),
      (nf_fp_prevaddrburglaryindex > 166.5) => -0.2385342988,
      (nf_fp_prevaddrburglaryindex = NULL) => 0.0390478445, 0.0390478445),
   (rv_comb_age = NULL) => -0.0025252548, -0.0025252548);
   
   // Tree: 220 
   fp3_lexid_model_220 := map(
   (NULL < nf_mos_liens_rel_FT_fseen and nf_mos_liens_rel_FT_fseen <= 237.5) => 
      map(
      (NULL < iv_prop1_purch_sale_diff and iv_prop1_purch_sale_diff <= 23792.5) => -0.0475302921,
      (iv_prop1_purch_sale_diff > 23792.5) => 
         map(
         (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 107.8) => 0.0035261287,
         (rv_A49_Curr_AVM_Chg_1yr_Pct > 107.8) => 0.0870579860,
         (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 
            map(
            (NULL < nf_lowest_rel_income and nf_lowest_rel_income <= 62.5) => 
               map(
               (NULL < nf_fp_srchfraudsrchcount and nf_fp_srchfraudsrchcount <= 1.5) => -0.0913208173,
               (nf_fp_srchfraudsrchcount > 1.5) => 0.0369842060,
               (nf_fp_srchfraudsrchcount = NULL) => -0.0375930888, -0.0375930888),
            (nf_lowest_rel_income > 62.5) => 0.1506444354,
            (nf_lowest_rel_income = NULL) => -0.0185578335, -0.0185578335), 0.0179042160),
      (iv_prop1_purch_sale_diff = NULL) => 0.0029520664, 0.0027845925),
   (nf_mos_liens_rel_FT_fseen > 237.5) => -0.1336857928,
   (nf_mos_liens_rel_FT_fseen = NULL) => 0.0025130342, 0.0025130342);
   
   // Tree: 221 
   fp3_lexid_model_221 := map(
   (NULL < rv_D34_attr_liens_recency and rv_D34_attr_liens_recency <= 9) => 0.0022052074,
   (rv_D34_attr_liens_recency > 9) => 
      map(
      (NULL < rv_I62_inq_ssns_per_adl and rv_I62_inq_ssns_per_adl <= 0.5) => 0.0028035292,
      (rv_I62_inq_ssns_per_adl > 0.5) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 28.5) => 
            map(
            (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.14835164835) => -0.0472658037,
            (nf_pct_rel_with_bk > 0.14835164835) => 0.1863822053,
            (nf_pct_rel_with_bk = NULL) => 0.0667088349, 0.0667088349),
         (rv_comb_age > 28.5) => 
            map(
            (NULL < rv_C10_M_Hdr_FS and rv_C10_M_Hdr_FS <= 508.5) => -0.0564383806,
            (rv_C10_M_Hdr_FS > 508.5) => 0.1575499501,
            (rv_C10_M_Hdr_FS = NULL) => -0.0525795746, -0.0525795746),
         (rv_comb_age = NULL) => -0.0450667869, -0.0450667869),
      (rv_I62_inq_ssns_per_adl = NULL) => -0.0169577744, -0.0169577744),
   (rv_D34_attr_liens_recency = NULL) => -0.0005281520, -0.0005281520);
   
   // Tree: 222 
   fp3_lexid_model_222 := map(
   (NULL < iv_C13_avg_lres and iv_C13_avg_lres <= 33.5) => 
      map(
      (NULL < nf_add_curr_nhood_SFD_pct and nf_add_curr_nhood_SFD_pct <= 0.0476310484) => 
         map(
         (NULL < nf_fp_prevaddrlenofres and nf_fp_prevaddrlenofres <= 43.5) => -0.0727148143,
         (nf_fp_prevaddrlenofres > 43.5) => 0.1473666430,
         (nf_fp_prevaddrlenofres = NULL) => -0.0497615335, -0.0497615335),
      (nf_add_curr_nhood_SFD_pct > 0.0476310484) => 
         map(
         (NULL < nf_average_rel_income and nf_average_rel_income <= 36000) => 
            map(
            (NULL < rv_I62_inq_dobs_per_adl and rv_I62_inq_dobs_per_adl <= 0.5) => 0.1494745564,
            (rv_I62_inq_dobs_per_adl > 0.5) => -0.0315298412,
            (rv_I62_inq_dobs_per_adl = NULL) => 0.0927189402, 0.0927189402),
         (nf_average_rel_income > 36000) => 0.0167570208,
         (nf_average_rel_income = NULL) => 0.0245176324, 0.0245176324),
      (nf_add_curr_nhood_SFD_pct = NULL) => 0.0153313623, 0.0153313623),
   (iv_C13_avg_lres > 33.5) => -0.0028912220,
   (iv_C13_avg_lres = NULL) => -0.0007188842, -0.0007188842);
   
   // Tree: 223 
   fp3_lexid_model_223 := map(
   (NULL < nf_fp_curraddrmedianvalue and nf_fp_curraddrmedianvalue <= 845819.5) => 
      map(
      (NULL < iv_D34_liens_unrel_OT_ct and iv_D34_liens_unrel_OT_ct <= 3.5) => 
         map(
         (NULL < nf_liens_unrel_OT_total_amt and nf_liens_unrel_OT_total_amt <= 38974.5) => 0.0006451005,
         (nf_liens_unrel_OT_total_amt > 38974.5) => 0.1789347984,
         (nf_liens_unrel_OT_total_amt = NULL) => 0.0008251085, 0.0008251085),
      (iv_D34_liens_unrel_OT_ct > 3.5) => -0.1117263642,
      (iv_D34_liens_unrel_OT_ct = NULL) => 0.0004852294, 0.0004852294),
   (nf_fp_curraddrmedianvalue > 845819.5) => 
      map(
      (NULL < nf_add_curr_nhood_BUS_pct and nf_add_curr_nhood_BUS_pct <= 0.1132190227) => -0.0977295413,
      (nf_add_curr_nhood_BUS_pct > 0.1132190227) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 277) => -0.0797271832,
         (nf_M_Bureau_ADL_FS_all > 277) => 0.1935443622,
         (nf_M_Bureau_ADL_FS_all = NULL) => 0.0569085895, 0.0569085895),
      (nf_add_curr_nhood_BUS_pct = NULL) => -0.0711511125, -0.0711511125),
   (nf_fp_curraddrmedianvalue = NULL) => -0.0003441349, -0.0003441349);
   
   // Tree: 224 
   fp3_lexid_model_224 := map(
   (NULL < nf_hh_collections_ct_avg and nf_hh_collections_ct_avg <= 0.14519906325) => 
      map(
      (NULL < rv_C13_max_lres and rv_C13_max_lres <= 21.5) => -0.0761464776,
      (rv_C13_max_lres > 21.5) => -0.0105625763,
      (rv_C13_max_lres = NULL) => -0.0128371625, -0.0128371625),
   (nf_hh_collections_ct_avg > 0.14519906325) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 374.5) => 0.0046871335,
      (nf_M_Bureau_ADL_FS_noTU > 374.5) => 
         map(
         (NULL < rv_A50_pb_total_dollars and rv_A50_pb_total_dollars <= 110.5) => -0.0152351448,
         (rv_A50_pb_total_dollars > 110.5) => 
            map(
            (NULL < nf_fp_prevaddrmedianincome and nf_fp_prevaddrmedianincome <= 39921.5) => -0.0425134916,
            (nf_fp_prevaddrmedianincome > 39921.5) => 0.1287060239,
            (nf_fp_prevaddrmedianincome = NULL) => 0.0944621208, 0.0944621208),
         (rv_A50_pb_total_dollars = NULL) => 0.0471519257, 0.0471519257),
      (nf_M_Bureau_ADL_FS_noTU = NULL) => 0.0060534145, 0.0060534145),
   (nf_hh_collections_ct_avg = NULL) => -0.0016319885, -0.0016319885);
   
   // Tree: 225 
   fp3_lexid_model_225 := map(
   (NULL < rv_comb_age and rv_comb_age <= 33.5) => 
      map(
      (NULL < nf_M_Bureau_ADL_FS_noTU and nf_M_Bureau_ADL_FS_noTU <= 196.5) => -0.0130959821,
      (nf_M_Bureau_ADL_FS_noTU > 196.5) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 207.5) => 
            map(
            (NULL < rv_C12_source_profile and rv_C12_source_profile <= 60.55) => 0.0884500259,
            (rv_C12_source_profile > 60.55) => 0.5365258734,
            (rv_C12_source_profile = NULL) => 0.2544040435, 0.2544040435),
         (nf_M_Bureau_ADL_FS_all > 207.5) => 0.0165296612,
         (nf_M_Bureau_ADL_FS_all = NULL) => 0.0929892841, 0.0929892841),
      (nf_M_Bureau_ADL_FS_noTU = NULL) => -0.0107459920, -0.0107459920),
   (rv_comb_age > 33.5) => 
      map(
      (NULL < rv_C20_M_Bureau_ADL_FS and rv_C20_M_Bureau_ADL_FS <= 249.5) => 0.0156121111,
      (rv_C20_M_Bureau_ADL_FS > 249.5) => -0.0046439158,
      (rv_C20_M_Bureau_ADL_FS = NULL) => 0.0020150646, 0.0020150646),
   (rv_comb_age = NULL) => -0.0023641143, -0.0023641143);
   
   // Tree: 226 
   fp3_lexid_model_226 := map(
   (NULL < iv_D57_attr_proflic_recency and iv_D57_attr_proflic_recency <= 79.5) => -0.0026794751,
   (iv_D57_attr_proflic_recency > 79.5) => 
      map(
      (NULL < rv_D32_criminal_count and rv_D32_criminal_count <= 3.5) => 
         map(
         (NULL < rv_C13_max_lres and rv_C13_max_lres <= 141) => 
            map(
            (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 101) => 
               map(
               (NULL < nf_highest_rel_home_val and nf_highest_rel_home_val <= 625) => 0.0905759589,
               (nf_highest_rel_home_val > 625) => 0.4362969426,
               (nf_highest_rel_home_val = NULL) => 0.2235455680, 0.2235455680),
            (rv_A49_Curr_AVM_Chg_1yr_Pct > 101) => -0.0297878461,
            (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.1030199529, 0.0872957776),
         (rv_C13_max_lres > 141) => -0.0006353660,
         (rv_C13_max_lres = NULL) => 0.0280251176, 0.0280251176),
      (rv_D32_criminal_count > 3.5) => 0.2825860931,
      (rv_D32_criminal_count = NULL) => 0.0356893190, 0.0356893190),
   (iv_D57_attr_proflic_recency = NULL) => -0.0010657370, -0.0010657370);
   
   // Tree: 227 
   fp3_lexid_model_227 := map(
   (NULL < rv_comb_age and rv_comb_age <= 68.5) => -0.0017899105,
   (rv_comb_age > 68.5) => 
      map(
      (NULL < rv_A46_Curr_AVM_AutoVal and rv_A46_Curr_AVM_AutoVal <= 349551.5) => 
         map(
         (NULL < rv_mos_since_br_first_seen and rv_mos_since_br_first_seen <= 476.5) => 
            map(
            (NULL < nf_hh_lienholders_pct and nf_hh_lienholders_pct <= 0.17424242425) => 0.0110497144,
            (nf_hh_lienholders_pct > 0.17424242425) => 
               map(
               (NULL < nf_pct_rel_with_bk and nf_pct_rel_with_bk <= 0.20294117645) => 0.1020129105,
               (nf_pct_rel_with_bk > 0.20294117645) => -0.0019774912,
               (nf_pct_rel_with_bk = NULL) => 0.0675378316, 0.0675378316),
            (nf_hh_lienholders_pct = NULL) => 0.0250198940, 0.0250198940),
         (rv_mos_since_br_first_seen > 476.5) => -0.2188849554,
         (rv_mos_since_br_first_seen = NULL) => 0.0217850816, 0.0217850816),
      (rv_A46_Curr_AVM_AutoVal > 349551.5) => -0.0523579448,
      (rv_A46_Curr_AVM_AutoVal = NULL) => 0.0120474030, 0.0120474030),
   (rv_comb_age = NULL) => -0.0007031581, -0.0007031581);
   
   // Tree: 228 
   fp3_lexid_model_228 := map(
   (NULL < nf_hh_lienholders and nf_hh_lienholders <= 6.5) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 57.5) => 
         map(
         (NULL < iv_prv_addr_avm_auto_val and iv_prv_addr_avm_auto_val <= 37188) => -0.0134387620,
         (iv_prv_addr_avm_auto_val > 37188) => 0.0058869012,
         (iv_prv_addr_avm_auto_val = NULL) => 0.0042524500, -0.0044771384),
      (rv_A50_pb_average_dollars > 57.5) => 
         map(
         (NULL < rv_I60_inq_retpymt_recency and rv_I60_inq_retpymt_recency <= 0.5) => 
            map(
            (NULL < nf_mos_liens_unrel_CJ_lseen and nf_mos_liens_unrel_CJ_lseen <= 194.5) => 0.0067782949,
            (nf_mos_liens_unrel_CJ_lseen > 194.5) => 0.1414376398,
            (nf_mos_liens_unrel_CJ_lseen = NULL) => 0.0080834045, 0.0080834045),
         (rv_I60_inq_retpymt_recency > 0.5) => 0.0619884212,
         (rv_I60_inq_retpymt_recency = NULL) => 0.0133526956, 0.0133526956),
      (rv_A50_pb_average_dollars = NULL) => 0.0006936911, 0.0006936911),
   (nf_hh_lienholders > 6.5) => 0.1908623349,
   (nf_hh_lienholders = NULL) => 0.0009516985, 0.0009516985);
   
   // Tree: 229 
   fp3_lexid_model_229 := map(
   (NULL < rv_comb_age and rv_comb_age <= 77.5) => 
      map(
      (NULL < iv_prv_addr_lres and iv_prv_addr_lres <= 396.5) => -0.0007554973,
      (iv_prv_addr_lres > 396.5) => -0.0585084788,
      (iv_prv_addr_lres = NULL) => 0.0086141323, -0.0008133701),
   (rv_comb_age > 77.5) => 
      map(
      (NULL < nf_rel_bankrupt_count and nf_rel_bankrupt_count <= 0.5) => 
         map(
         (NULL < rv_A50_pb_total_orders and rv_A50_pb_total_orders <= 49.5) => 
            map(
            (NULL < nf_rel_count and nf_rel_count <= 11.5) => -0.0471918731,
            (nf_rel_count > 11.5) => 0.1186087940,
            (nf_rel_count = NULL) => -0.0252072543, -0.0252072543),
         (rv_A50_pb_total_orders > 49.5) => 0.2025160395,
         (rv_A50_pb_total_orders = NULL) => -0.0132845687, -0.0132845687),
      (nf_rel_bankrupt_count > 0.5) => 0.0722394248,
      (nf_rel_bankrupt_count = NULL) => 0.0236231070, 0.0236231070),
   (rv_comb_age = NULL) => -0.0000702570, -0.0000702570);
   
   // Tree: 230 
   fp3_lexid_model_230 := map(
   (NULL < rv_comb_age and rv_comb_age <= 20.5) => 
      map(
      (NULL < rv_A49_Curr_AVM_Chg_1yr_Pct and rv_A49_Curr_AVM_Chg_1yr_Pct <= 113.3) => 
         map(
         (NULL < nf_M_Bureau_ADL_FS_all and nf_M_Bureau_ADL_FS_all <= 54) => -0.0322694043,
         (nf_M_Bureau_ADL_FS_all > 54) => 0.1782736142,
         (nf_M_Bureau_ADL_FS_all = NULL) => 0.0094419484, 0.0094419484),
      (rv_A49_Curr_AVM_Chg_1yr_Pct > 113.3) => 
         map(
         (NULL < rv_comb_age and rv_comb_age <= 19.5) => 0.0727183192,
         (rv_comb_age > 19.5) => 0.3925832430,
         (rv_comb_age = NULL) => 0.1793399604, 0.1793399604),
      (rv_A49_Curr_AVM_Chg_1yr_Pct = NULL) => 0.0227420523, 0.0331118258),
   (rv_comb_age > 20.5) => 
      map(
      (NULL < rv_A50_pb_average_dollars and rv_A50_pb_average_dollars <= 831.5) => 0.0003106072,
      (rv_A50_pb_average_dollars > 831.5) => -0.1283790176,
      (rv_A50_pb_average_dollars = NULL) => 0.0000192619, 0.0000192619),
   (rv_comb_age = NULL) => 0.0013754164, 0.0013754164);
   
   // Final Score Sum 
   
      _fp3_lexid_model_lgt := sum(
         fp3_lexid_model_0, fp3_lexid_model_1, fp3_lexid_model_2, fp3_lexid_model_3, fp3_lexid_model_4, 
         fp3_lexid_model_5, fp3_lexid_model_6, fp3_lexid_model_7, fp3_lexid_model_8, fp3_lexid_model_9, 
         fp3_lexid_model_10, fp3_lexid_model_11, fp3_lexid_model_12, fp3_lexid_model_13, fp3_lexid_model_14, 
         fp3_lexid_model_15, fp3_lexid_model_16, fp3_lexid_model_17, fp3_lexid_model_18, fp3_lexid_model_19, 
         fp3_lexid_model_20, fp3_lexid_model_21, fp3_lexid_model_22, fp3_lexid_model_23, fp3_lexid_model_24, 
         fp3_lexid_model_25, fp3_lexid_model_26, fp3_lexid_model_27, fp3_lexid_model_28, fp3_lexid_model_29, 
         fp3_lexid_model_30, fp3_lexid_model_31, fp3_lexid_model_32, fp3_lexid_model_33, fp3_lexid_model_34, 
         fp3_lexid_model_35, fp3_lexid_model_36, fp3_lexid_model_37, fp3_lexid_model_38, fp3_lexid_model_39, 
         fp3_lexid_model_40, fp3_lexid_model_41, fp3_lexid_model_42, fp3_lexid_model_43, fp3_lexid_model_44, 
         fp3_lexid_model_45, fp3_lexid_model_46, fp3_lexid_model_47, fp3_lexid_model_48, fp3_lexid_model_49, 
         fp3_lexid_model_50, fp3_lexid_model_51, fp3_lexid_model_52, fp3_lexid_model_53, fp3_lexid_model_54, 
         fp3_lexid_model_55, fp3_lexid_model_56, fp3_lexid_model_57, fp3_lexid_model_58, fp3_lexid_model_59, 
         fp3_lexid_model_60, fp3_lexid_model_61, fp3_lexid_model_62, fp3_lexid_model_63, fp3_lexid_model_64, 
         fp3_lexid_model_65, fp3_lexid_model_66, fp3_lexid_model_67, fp3_lexid_model_68, fp3_lexid_model_69, 
         fp3_lexid_model_70, fp3_lexid_model_71, fp3_lexid_model_72, fp3_lexid_model_73, fp3_lexid_model_74, 
         fp3_lexid_model_75, fp3_lexid_model_76, fp3_lexid_model_77, fp3_lexid_model_78, fp3_lexid_model_79, 
         fp3_lexid_model_80, fp3_lexid_model_81, fp3_lexid_model_82, fp3_lexid_model_83, fp3_lexid_model_84, 
         fp3_lexid_model_85, fp3_lexid_model_86, fp3_lexid_model_87, fp3_lexid_model_88, fp3_lexid_model_89, 
         fp3_lexid_model_90, fp3_lexid_model_91, fp3_lexid_model_92, fp3_lexid_model_93, fp3_lexid_model_94, 
         fp3_lexid_model_95, fp3_lexid_model_96, fp3_lexid_model_97, fp3_lexid_model_98, fp3_lexid_model_99, 
         fp3_lexid_model_100, fp3_lexid_model_101, fp3_lexid_model_102, fp3_lexid_model_103, fp3_lexid_model_104, 
         fp3_lexid_model_105, fp3_lexid_model_106, fp3_lexid_model_107, fp3_lexid_model_108, fp3_lexid_model_109, 
         fp3_lexid_model_110, fp3_lexid_model_111, fp3_lexid_model_112, fp3_lexid_model_113, fp3_lexid_model_114, 
         fp3_lexid_model_115, fp3_lexid_model_116, fp3_lexid_model_117, fp3_lexid_model_118, fp3_lexid_model_119, 
         fp3_lexid_model_120, fp3_lexid_model_121, fp3_lexid_model_122, fp3_lexid_model_123, fp3_lexid_model_124, 
         fp3_lexid_model_125, fp3_lexid_model_126, fp3_lexid_model_127, fp3_lexid_model_128, fp3_lexid_model_129, 
         fp3_lexid_model_130, fp3_lexid_model_131, fp3_lexid_model_132, fp3_lexid_model_133, fp3_lexid_model_134, 
         fp3_lexid_model_135, fp3_lexid_model_136, fp3_lexid_model_137, fp3_lexid_model_138, fp3_lexid_model_139, 
         fp3_lexid_model_140, fp3_lexid_model_141, fp3_lexid_model_142, fp3_lexid_model_143, fp3_lexid_model_144, 
         fp3_lexid_model_145, fp3_lexid_model_146, fp3_lexid_model_147, fp3_lexid_model_148, fp3_lexid_model_149, 
         fp3_lexid_model_150, fp3_lexid_model_151, fp3_lexid_model_152, fp3_lexid_model_153, fp3_lexid_model_154, 
         fp3_lexid_model_155, fp3_lexid_model_156, fp3_lexid_model_157, fp3_lexid_model_158, fp3_lexid_model_159, 
         fp3_lexid_model_160, fp3_lexid_model_161, fp3_lexid_model_162, fp3_lexid_model_163, fp3_lexid_model_164, 
         fp3_lexid_model_165, fp3_lexid_model_166, fp3_lexid_model_167, fp3_lexid_model_168, fp3_lexid_model_169, 
         fp3_lexid_model_170, fp3_lexid_model_171, fp3_lexid_model_172, fp3_lexid_model_173, fp3_lexid_model_174, 
         fp3_lexid_model_175, fp3_lexid_model_176, fp3_lexid_model_177, fp3_lexid_model_178, fp3_lexid_model_179, 
         fp3_lexid_model_180, fp3_lexid_model_181, fp3_lexid_model_182, fp3_lexid_model_183, fp3_lexid_model_184, 
         fp3_lexid_model_185, fp3_lexid_model_186, fp3_lexid_model_187, fp3_lexid_model_188, fp3_lexid_model_189, 
         fp3_lexid_model_190, fp3_lexid_model_191, fp3_lexid_model_192, fp3_lexid_model_193, fp3_lexid_model_194, 
         fp3_lexid_model_195, fp3_lexid_model_196, fp3_lexid_model_197, fp3_lexid_model_198, fp3_lexid_model_199, 
         fp3_lexid_model_200, fp3_lexid_model_201, fp3_lexid_model_202, fp3_lexid_model_203, fp3_lexid_model_204, 
         fp3_lexid_model_205, fp3_lexid_model_206, fp3_lexid_model_207, fp3_lexid_model_208, fp3_lexid_model_209, 
         fp3_lexid_model_210, fp3_lexid_model_211, fp3_lexid_model_212, fp3_lexid_model_213, fp3_lexid_model_214, 
         fp3_lexid_model_215, fp3_lexid_model_216, fp3_lexid_model_217, fp3_lexid_model_218, fp3_lexid_model_219, 
         fp3_lexid_model_220, fp3_lexid_model_221, fp3_lexid_model_222, fp3_lexid_model_223, fp3_lexid_model_224, 
         fp3_lexid_model_225, fp3_lexid_model_226, fp3_lexid_model_227, fp3_lexid_model_228, fp3_lexid_model_229, 
         fp3_lexid_model_230); 

	BASE := 850;
	PTS  := -50;
	LGT  := ln(1/200);
	OFFSET := ln( ((1 - 0.01) * 0.25) / (0.01 * (1 - 0.25)));
	fp31604_0_0_score_raw := (INTEGER)min(max(round(BASE + PTS * (_fp3_lexid_model_lgt - OFFSET - LGT)/ln(2)), 300), 999);

	fp31604_0_0_score := map(
			(boolean)iv_rv5_deceased=true    => '300',
			not(truedid)										 => '',
																					(STRING)fp31604_0_0_score_raw);

	#if(FP_DEBUG)
self.clam	:= le;
SELF.truedid := truedid;
SELF.in_dob := in_dob;
SELF.rc_ssndod := rc_ssndod;
SELF.rc_decsflag := rc_decsflag;
SELF.hdr_source_profile := hdr_source_profile;
SELF.ver_sources := ver_sources;
SELF.ver_sources_first_seen := ver_sources_first_seen;
SELF.util_adl_count := util_adl_count;
SELF.add_input_naprop := add_input_naprop;
SELF.property_owned_total := property_owned_total;
SELF.prop1_sale_price := prop1_sale_price;
SELF.prop1_prev_purchase_price := prop1_prev_purchase_price;
SELF.prop2_sale_price := prop2_sale_price;
SELF.prop2_prev_purchase_price := prop2_prev_purchase_price;
SELF.add_curr_lres := add_curr_lres;
SELF.add_curr_occ_index := add_curr_occ_index;
SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
SELF.add_curr_avm_auto_val_2 := add_curr_avm_auto_val_2;
SELF.add_curr_naprop := add_curr_naprop;
SELF.add_curr_financing_type := add_curr_financing_type;
SELF.add_curr_nhood_vac_prop := add_curr_nhood_vac_prop;
SELF.add_curr_nhood_bus_ct := add_curr_nhood_bus_ct;
SELF.add_curr_nhood_sfd_ct := add_curr_nhood_sfd_ct;
SELF.add_curr_nhood_mfd_ct := add_curr_nhood_mfd_ct;
SELF.add_curr_pop := add_curr_pop;
SELF.add_prev_lres := add_prev_lres;
SELF.add_prev_avm_auto_val := add_prev_avm_auto_val;
SELF.add_prev_naprop := add_prev_naprop;
SELF.add_prev_pop := add_prev_pop;
SELF.avg_lres := avg_lres;
SELF.max_lres := max_lres;
SELF.addrs_5yr := addrs_5yr;
SELF.addrs_10yr := addrs_10yr;
SELF.addrs_15yr := addrs_15yr;
SELF.addrs_move_trajectory := addrs_move_trajectory;
SELF.addrs_move_trajectory_index := addrs_move_trajectory_index;
SELF.addrs_prison_history := addrs_prison_history;
SELF.unverified_addr_count := unverified_addr_count;
SELF.header_first_seen := header_first_seen;
SELF.addrs_per_adl := addrs_per_adl;
SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
SELF.dl_addrs_per_adl := dl_addrs_per_adl;
SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
SELF.invalid_addrs_per_adl := invalid_addrs_per_adl;
SELF.inq_count := inq_count;
SELF.inq_count_week := inq_count_week;
SELF.inq_count01 := inq_count01;
SELF.inq_count03 := inq_count03;
SELF.inq_count06 := inq_count06;
SELF.inq_count12 := inq_count12;
SELF.inq_count24 := inq_count24;
SELF.inq_auto_count := inq_auto_count;
SELF.inq_auto_count24 := inq_auto_count24;
SELF.inq_banking_count := inq_banking_count;
SELF.inq_banking_count12 := inq_banking_count12;
SELF.inq_banking_count24 := inq_banking_count24;
SELF.inq_collection_count := inq_collection_count;
SELF.inq_collection_count01 := inq_collection_count01;
SELF.inq_collection_count03 := inq_collection_count03;
SELF.inq_collection_count06 := inq_collection_count06;
SELF.inq_collection_count12 := inq_collection_count12;
SELF.inq_collection_count24 := inq_collection_count24;
SELF.inq_communications_count := inq_communications_count;
SELF.inq_communications_count01 := inq_communications_count01;
SELF.inq_communications_count03 := inq_communications_count03;
SELF.inq_communications_count06 := inq_communications_count06;
SELF.inq_communications_count12 := inq_communications_count12;
SELF.inq_communications_count24 := inq_communications_count24;
SELF.inq_highriskcredit_count := inq_highriskcredit_count;
SELF.inq_highriskcredit_count01 := inq_highriskcredit_count01;
SELF.inq_highriskcredit_count03 := inq_highriskcredit_count03;
SELF.inq_highriskcredit_count06 := inq_highriskcredit_count06;
SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
SELF.inq_mortgage_count := inq_mortgage_count;
SELF.inq_mortgage_count24 := inq_mortgage_count24;
SELF.inq_other_count := inq_other_count;
SELF.inq_other_count_week := inq_other_count_week;
SELF.inq_other_count01 := inq_other_count01;
SELF.inq_other_count03 := inq_other_count03;
SELF.inq_other_count06 := inq_other_count06;
SELF.inq_other_count12 := inq_other_count12;
SELF.inq_other_count24 := inq_other_count24;
SELF.inq_prepaidcards_count := inq_prepaidcards_count;
SELF.inq_prepaidcards_count01 := inq_prepaidcards_count01;
SELF.inq_prepaidcards_count03 := inq_prepaidcards_count03;
SELF.inq_prepaidcards_count06 := inq_prepaidcards_count06;
SELF.inq_prepaidcards_count12 := inq_prepaidcards_count12;
SELF.inq_prepaidcards_count24 := inq_prepaidcards_count24;
SELF.inq_retail_count := inq_retail_count;
SELF.inq_retailpayments_count := inq_retailpayments_count;
SELF.inq_retailpayments_count01 := inq_retailpayments_count01;
SELF.inq_retailpayments_count03 := inq_retailpayments_count03;
SELF.inq_retailpayments_count06 := inq_retailpayments_count06;
SELF.inq_retailpayments_count12 := inq_retailpayments_count12;
SELF.inq_retailpayments_count24 := inq_retailpayments_count24;
SELF.inq_utilities_count := inq_utilities_count;
SELF.inq_utilities_count24 := inq_utilities_count24;
SELF.inq_ssnsperadl := inq_ssnsperadl;
SELF.inq_addrsperadl := inq_addrsperadl;
SELF.inq_phonesperadl := inq_phonesperadl;
SELF.inq_dobsperadl := inq_dobsperadl;
SELF.inq_banko_am_first_seen := inq_banko_am_first_seen;
SELF.inq_banko_am_last_seen := inq_banko_am_last_seen;
SELF.inq_banko_cm_first_seen := inq_banko_cm_first_seen;
SELF.inq_banko_cm_last_seen := inq_banko_cm_last_seen;
SELF.inq_banko_om_first_seen := inq_banko_om_first_seen;
SELF.inq_banko_om_last_seen := inq_banko_om_last_seen;
SELF.pb_number_of_sources := pb_number_of_sources;
SELF.pb_average_dollars := pb_average_dollars;
SELF.pb_total_dollars := pb_total_dollars;
SELF.pb_total_orders := pb_total_orders;
SELF.pb_offline_dollars := pb_offline_dollars;
SELF.pb_online_dollars := pb_online_dollars;
SELF.pb_retail_dollars := pb_retail_dollars;
SELF.br_company_title := br_company_title;
SELF.br_first_seen := br_first_seen;
SELF.br_dead_business_count := br_dead_business_count;
SELF.br_active_phone_count := br_active_phone_count;
SELF.br_source_count := br_source_count;
SELF.stl_inq_count180 := stl_inq_count180;
SELF.email_count := email_count;
SELF.email_domain_isp_count := email_domain_isp_count;
SELF.attr_addrs_last30 := attr_addrs_last30;
SELF.attr_addrs_last90 := attr_addrs_last90;
SELF.attr_addrs_last12 := attr_addrs_last12;
SELF.attr_addrs_last24 := attr_addrs_last24;
SELF.attr_addrs_last36 := attr_addrs_last36;
SELF.attr_num_aircraft := attr_num_aircraft;
SELF.attr_total_number_derogs := attr_total_number_derogs;
SELF.attr_felonies30 := attr_felonies30;
SELF.attr_felonies90 := attr_felonies90;
SELF.attr_felonies180 := attr_felonies180;
SELF.attr_felonies12 := attr_felonies12;
SELF.attr_felonies24 := attr_felonies24;
SELF.attr_felonies36 := attr_felonies36;
SELF.attr_felonies60 := attr_felonies60;
SELF.attr_arrests30 := attr_arrests30;
SELF.attr_arrests90 := attr_arrests90;
SELF.attr_arrests180 := attr_arrests180;
SELF.attr_arrests12 := attr_arrests12;
SELF.attr_arrests24 := attr_arrests24;
SELF.attr_arrests36 := attr_arrests36;
SELF.attr_arrests60 := attr_arrests60;
SELF.attr_num_unrel_liens30 := attr_num_unrel_liens30;
SELF.attr_num_unrel_liens90 := attr_num_unrel_liens90;
SELF.attr_num_unrel_liens180 := attr_num_unrel_liens180;
SELF.attr_num_unrel_liens12 := attr_num_unrel_liens12;
SELF.attr_num_unrel_liens24 := attr_num_unrel_liens24;
SELF.attr_num_unrel_liens36 := attr_num_unrel_liens36;
SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
SELF.attr_num_rel_liens30 := attr_num_rel_liens30;
SELF.attr_num_rel_liens90 := attr_num_rel_liens90;
SELF.attr_num_rel_liens180 := attr_num_rel_liens180;
SELF.attr_num_rel_liens12 := attr_num_rel_liens12;
SELF.attr_num_rel_liens24 := attr_num_rel_liens24;
SELF.attr_num_rel_liens36 := attr_num_rel_liens36;
SELF.attr_num_rel_liens60 := attr_num_rel_liens60;
SELF.attr_bankruptcy_count30 := attr_bankruptcy_count30;
SELF.attr_bankruptcy_count90 := attr_bankruptcy_count90;
SELF.attr_bankruptcy_count180 := attr_bankruptcy_count180;
SELF.attr_bankruptcy_count12 := attr_bankruptcy_count12;
SELF.attr_bankruptcy_count24 := attr_bankruptcy_count24;
SELF.attr_bankruptcy_count36 := attr_bankruptcy_count36;
SELF.attr_bankruptcy_count60 := attr_bankruptcy_count60;
SELF.attr_eviction_count := attr_eviction_count;
SELF.attr_eviction_count90 := attr_eviction_count90;
SELF.attr_eviction_count180 := attr_eviction_count180;
SELF.attr_eviction_count12 := attr_eviction_count12;
SELF.attr_eviction_count24 := attr_eviction_count24;
SELF.attr_eviction_count36 := attr_eviction_count36;
SELF.attr_eviction_count60 := attr_eviction_count60;
SELF.attr_num_nonderogs := attr_num_nonderogs;
SELF.attr_num_proflic30 := attr_num_proflic30;
SELF.attr_num_proflic90 := attr_num_proflic90;
SELF.attr_num_proflic180 := attr_num_proflic180;
SELF.attr_num_proflic12 := attr_num_proflic12;
SELF.attr_num_proflic24 := attr_num_proflic24;
SELF.attr_num_proflic36 := attr_num_proflic36;
SELF.attr_num_proflic60 := attr_num_proflic60;
SELF.fp_idrisktype := fp_idrisktype;
SELF.fp_sourcerisktype := fp_sourcerisktype;
SELF.fp_varrisktype := fp_varrisktype;
SELF.fp_varmsrcssncount := fp_varmsrcssncount;
SELF.fp_vardobcount := fp_vardobcount;
SELF.fp_vardobcountnew := fp_vardobcountnew;
SELF.fp_srchvelocityrisktype := fp_srchvelocityrisktype;
SELF.fp_srchunvrfdaddrcount := fp_srchunvrfdaddrcount;
SELF.fp_srchunvrfddobcount := fp_srchunvrfddobcount;
SELF.fp_srchunvrfdphonecount := fp_srchunvrfdphonecount;
SELF.fp_srchfraudsrchcount := fp_srchfraudsrchcount;
SELF.fp_srchfraudsrchcountyr := fp_srchfraudsrchcountyr;
SELF.fp_srchfraudsrchcountmo := fp_srchfraudsrchcountmo;
SELF.fp_srchfraudsrchcountwk := fp_srchfraudsrchcountwk;
SELF.fp_assocrisktype := fp_assocrisktype;
SELF.fp_assocsuspicousidcount := fp_assocsuspicousidcount;
SELF.fp_assoccredbureaucount := fp_assoccredbureaucount;
SELF.fp_assoccredbureaucountnew := fp_assoccredbureaucountnew;
SELF.fp_curraddrmedianincome := fp_curraddrmedianincome;
SELF.fp_curraddrmedianvalue := fp_curraddrmedianvalue;
SELF.fp_curraddrmurderindex := fp_curraddrmurderindex;
SELF.fp_curraddrcartheftindex := fp_curraddrcartheftindex;
SELF.fp_curraddrburglaryindex := fp_curraddrburglaryindex;
SELF.fp_curraddrcrimeindex := fp_curraddrcrimeindex;
SELF.fp_prevaddrageoldest := fp_prevaddrageoldest;
SELF.fp_prevaddrlenofres := fp_prevaddrlenofres;
SELF.fp_prevaddrstatus := fp_prevaddrstatus;
SELF.fp_prevaddrmedianincome := fp_prevaddrmedianincome;
SELF.fp_prevaddrmedianvalue := fp_prevaddrmedianvalue;
SELF.fp_prevaddrmurderindex := fp_prevaddrmurderindex;
SELF.fp_prevaddrcartheftindex := fp_prevaddrcartheftindex;
SELF.fp_prevaddrburglaryindex := fp_prevaddrburglaryindex;
SELF.fp_prevaddrcrimeindex := fp_prevaddrcrimeindex;
SELF.bankrupt := bankrupt;
SELF.filing_type := filing_type;
SELF.disposition := disposition;
SELF.filing_count := filing_count;
SELF.bk_dismissed_recent_count := bk_dismissed_recent_count;
SELF.bk_dismissed_historical_count := bk_dismissed_historical_count;
SELF.bk_chapter := bk_chapter;
SELF.bk_disposed_recent_count := bk_disposed_recent_count;
SELF.bk_disposed_historical_count := bk_disposed_historical_count;
SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
SELF.liens_historical_released_count := liens_historical_released_count;
SELF.liens_unrel_cj_first_seen := liens_unrel_cj_first_seen;
SELF.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
SELF.liens_unrel_cj_total_amount := liens_unrel_cj_total_amount;
SELF.liens_rel_cj_first_seen := liens_rel_cj_first_seen;
SELF.liens_rel_cj_last_seen := liens_rel_cj_last_seen;
SELF.liens_rel_cj_total_amount := liens_rel_cj_total_amount;
SELF.liens_unrel_ft_first_seen := liens_unrel_ft_first_seen;
SELF.liens_unrel_ft_last_seen := liens_unrel_ft_last_seen;
SELF.liens_unrel_ft_total_amount := liens_unrel_ft_total_amount;
SELF.liens_rel_ft_first_seen := liens_rel_ft_first_seen;
SELF.liens_unrel_o_first_seen := liens_unrel_o_first_seen;
SELF.liens_unrel_o_last_seen := liens_unrel_o_last_seen;
SELF.liens_rel_o_total_amount := liens_rel_o_total_amount;
SELF.liens_unrel_ot_ct := liens_unrel_ot_ct;
SELF.liens_unrel_ot_first_seen := liens_unrel_ot_first_seen;
SELF.liens_unrel_ot_last_seen := liens_unrel_ot_last_seen;
SELF.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
SELF.liens_rel_ot_ct := liens_rel_ot_ct;
SELF.liens_rel_ot_last_seen := liens_rel_ot_last_seen;
SELF.liens_rel_ot_total_amount := liens_rel_ot_total_amount;
SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
SELF.liens_unrel_sc_first_seen := liens_unrel_sc_first_seen;
SELF.liens_unrel_sc_last_seen := liens_unrel_sc_last_seen;
SELF.liens_unrel_sc_total_amount := liens_unrel_sc_total_amount;
SELF.liens_unrel_st_ct := liens_unrel_st_ct;
SELF.liens_unrel_st_first_seen := liens_unrel_st_first_seen;
SELF.liens_unrel_st_last_seen := liens_unrel_st_last_seen;
SELF.liens_unrel_st_total_amount := liens_unrel_st_total_amount;
SELF.criminal_count := criminal_count;
SELF.felony_count := felony_count;
SELF.felony_last_date := felony_last_date;
SELF.foreclosure_last_date := foreclosure_last_date;
SELF.hh_members_ct := hh_members_ct;
SELF.hh_property_owners_ct := hh_property_owners_ct;
SELF.hh_age_65_plus := hh_age_65_plus;
SELF.hh_age_30_to_65 := hh_age_30_to_65;
SELF.hh_age_18_to_30 := hh_age_18_to_30;
SELF.hh_collections_ct := hh_collections_ct;
SELF.hh_workers_paw := hh_workers_paw;
SELF.hh_payday_loan_users := hh_payday_loan_users;
SELF.hh_members_w_derog := hh_members_w_derog;
SELF.hh_tot_derog := hh_tot_derog;
SELF.hh_bankruptcies := hh_bankruptcies;
SELF.hh_lienholders := hh_lienholders;
SELF.hh_prof_license_holders := hh_prof_license_holders;
SELF.hh_criminals := hh_criminals;
SELF.rel_count := rel_count;
SELF.rel_bankrupt_count := rel_bankrupt_count;
SELF.rel_criminal_count := rel_criminal_count;
SELF.rel_felony_count := rel_felony_count;
SELF.rel_prop_owned_count := rel_prop_owned_count;
SELF.rel_prop_sold_count := rel_prop_sold_count;
SELF.rel_within25miles_count := rel_within25miles_count;
SELF.rel_within100miles_count := rel_within100miles_count;
SELF.rel_within500miles_count := rel_within500miles_count;
SELF.rel_withinother_count := rel_withinother_count;
SELF.rel_incomeunder25_count := rel_incomeunder25_count;
SELF.rel_incomeunder50_count := rel_incomeunder50_count;
SELF.rel_incomeunder75_count := rel_incomeunder75_count;
SELF.rel_incomeunder100_count := rel_incomeunder100_count;
SELF.rel_incomeover100_count := rel_incomeover100_count;
SELF.rel_homeunder50_count := rel_homeunder50_count;
SELF.rel_homeunder100_count := rel_homeunder100_count;
SELF.rel_homeunder150_count := rel_homeunder150_count;
SELF.rel_homeunder200_count := rel_homeunder200_count;
SELF.rel_homeunder300_count := rel_homeunder300_count;
SELF.rel_homeunder500_count := rel_homeunder500_count;
SELF.rel_homeover500_count := rel_homeover500_count;
SELF.rel_ageunder20_count := rel_ageunder20_count;
SELF.rel_ageunder30_count := rel_ageunder30_count;
SELF.rel_ageunder40_count := rel_ageunder40_count;
SELF.rel_ageunder50_count := rel_ageunder50_count;
SELF.rel_ageunder60_count := rel_ageunder60_count;
SELF.rel_ageunder70_count := rel_ageunder70_count;
SELF.rel_ageover70_count := rel_ageover70_count;
SELF.current_count := current_count;
SELF.historical_count := historical_count;
SELF.watercraft_count := watercraft_count;
SELF.acc_count := acc_count;
SELF.acc_damage_amt_total := acc_damage_amt_total;
SELF.acc_last_seen := acc_last_seen;
SELF.acc_count_30 := acc_count_30;
SELF.acc_count_90 := acc_count_90;
SELF.acc_count_180 := acc_count_180;
SELF.acc_count_12 := acc_count_12;
SELF.acc_count_24 := acc_count_24;
SELF.acc_count_36 := acc_count_36;
SELF.acc_count_60 := acc_count_60;
SELF.college_code := college_code;
SELF.college_type := college_type;
SELF.prof_license_flag := prof_license_flag;
SELF.prof_license_category := prof_license_category;
SELF.prof_license_source := prof_license_source;
SELF.wealth_index := wealth_index;
SELF.inferred_age := inferred_age;
SELF.addr_stability_v2 := addr_stability_v2;
SELF.C_INC_125K_P := C_INC_125K_P;
SELF.C_INC_150K_P := C_INC_150K_P;
SELF.C_INC_25K_P := C_INC_25K_P;
SELF.C_INC_50K_P := C_INC_50K_P;
SELF.C_OWNOCC_P := C_OWNOCC_P;
SELF.c_ab_av_edu := c_ab_av_edu;
SELF.c_asian_lang := c_asian_lang;
SELF.c_assault := c_assault;
SELF.c_blue_col := c_blue_col;
SELF.c_born_usa := c_born_usa;
SELF.c_business := c_business;
SELF.c_cartheft := c_cartheft;
SELF.c_child := c_child;
SELF.c_civ_emp := c_civ_emp;
SELF.c_construction := c_construction;
SELF.c_cpiall := c_cpiall;
SELF.c_easiqlife := c_easiqlife;
SELF.c_employees := c_employees;
SELF.c_exp_homes := c_exp_homes;
SELF.c_exp_prod := c_exp_prod;
SELF.c_families := c_families;
SELF.c_fammar18_p := c_fammar18_p;
SELF.c_fammar_p := c_fammar_p;
SELF.c_famotf18_p := c_famotf18_p;
SELF.c_femdiv_p := c_femdiv_p;
SELF.c_finance := c_finance;
SELF.c_for_sale := c_for_sale;
SELF.c_health := c_health;
SELF.c_hh1_p := c_hh1_p;
SELF.c_hh2_p := c_hh2_p;
SELF.c_hh3_p := c_hh3_p;
SELF.c_hh4_p := c_hh4_p;
SELF.c_hh5_p := c_hh5_p;
SELF.c_hh6_p := c_hh6_p;
SELF.c_hh7p_p := c_hh7p_p;
SELF.c_hhsize := c_hhsize;
SELF.c_high_ed := c_high_ed;
SELF.c_high_hval := c_high_hval;
SELF.c_highinc := c_highinc;
SELF.c_housingcpi := c_housingcpi;
SELF.c_hval_1001k_p := c_hval_1001k_p;
SELF.c_hval_100k_p := c_hval_100k_p;
SELF.c_hval_125k_p := c_hval_125k_p;
SELF.c_hval_300k_p := c_hval_300k_p;
SELF.c_hval_400k_p := c_hval_400k_p;
SELF.c_hval_500k_p := c_hval_500k_p;
SELF.c_incollege := c_incollege;
SELF.c_info := c_info;
SELF.c_lar_fam := c_lar_fam;
SELF.c_larceny := c_larceny;
SELF.c_low_ed := c_low_ed;
SELF.c_low_hval := c_low_hval;
SELF.c_lowrent := c_lowrent;
SELF.c_lux_prod := c_lux_prod;
SELF.c_many_cars := c_many_cars;
SELF.c_med_hhinc := c_med_hhinc;
SELF.c_med_rent := c_med_rent;
SELF.c_med_yearblt := c_med_yearblt;
SELF.c_mining := c_mining;
SELF.c_mort_indx := c_mort_indx;
SELF.c_murders := c_murders;
SELF.c_no_labfor := c_no_labfor;
SELF.c_oldhouse := c_oldhouse;
SELF.c_pop_0_5_p := c_pop_0_5_p;
SELF.c_pop_12_17_p := c_pop_12_17_p;
SELF.c_pop_18_24_p := c_pop_18_24_p;
SELF.c_pop_25_34_p := c_pop_25_34_p;
SELF.c_pop_35_44_p := c_pop_35_44_p;
SELF.c_pop_45_54_p := c_pop_45_54_p;
SELF.c_pop_65_74_p := c_pop_65_74_p;
SELF.c_pop_6_11_p := c_pop_6_11_p;
SELF.c_pop_75_84_p := c_pop_75_84_p;
SELF.c_popover25 := c_popover25;
SELF.c_rape := c_rape;
SELF.c_rental := c_rental;
SELF.c_rest_indx := c_rest_indx;
SELF.c_retail := c_retail;
SELF.c_retired := c_retired;
SELF.c_retired2 := c_retired2;
SELF.c_rich_blk := c_rich_blk;
SELF.c_rich_hisp := c_rich_hisp;
SELF.c_rich_old := c_rich_old;
SELF.c_rich_wht := c_rich_wht;
SELF.c_rnt1500_p := c_rnt1500_p;
SELF.c_rnt250_p := c_rnt250_p;
SELF.c_robbery := c_robbery;
SELF.c_rural_p := c_rural_p;
SELF.c_serv_empl := c_serv_empl;
SELF.c_sfdu_p := c_sfdu_p;
SELF.c_sub_bus := c_sub_bus;
SELF.c_totcrime := c_totcrime;
SELF.c_totsales := c_totsales;
SELF.c_transport := c_transport;
SELF.c_unemp := c_unemp;
SELF.c_unempl := c_unempl;
SELF.c_urban_p := c_urban_p;
SELF.c_vacant_p := c_vacant_p;
SELF.c_white_col := c_white_col;
SELF.c_young := c_young;
SELF.sysdate := sysdate;
SELF.iv_wealth_index := iv_wealth_index;
SELF._in_dob := _in_dob;
SELF.yr_in_dob := yr_in_dob;
SELF.yr_in_dob_int := yr_in_dob_int;
SELF.rv_comb_age := rv_comb_age;
SELF.nf_fp_varrisktype := nf_fp_varrisktype;
SELF.nf_fp_srchvelocityrisktype := nf_fp_srchvelocityrisktype;
SELF.nf_fp_srchfraudsrchcount := nf_fp_srchfraudsrchcount;
SELF.rv_a49_curr_avm_chg_1yr_pct := rv_a49_curr_avm_chg_1yr_pct;
SELF.nf_fp_srchunvrfdaddrcount := nf_fp_srchunvrfdaddrcount;
SELF.bureau_adl_eq_fseen_pos_3 := bureau_adl_eq_fseen_pos_3;
SELF.bureau_adl_fseen_eq_3 := bureau_adl_fseen_eq_3;
SELF._bureau_adl_fseen_eq_3 := _bureau_adl_fseen_eq_3;
SELF.bureau_adl_en_fseen_pos_2 := bureau_adl_en_fseen_pos_2;
SELF.bureau_adl_fseen_en_2 := bureau_adl_fseen_en_2;
SELF._bureau_adl_fseen_en_2 := _bureau_adl_fseen_en_2;
SELF.bureau_adl_ts_fseen_pos_1 := bureau_adl_ts_fseen_pos_1;
SELF.bureau_adl_fseen_ts_1 := bureau_adl_fseen_ts_1;
SELF._bureau_adl_fseen_ts_1 := _bureau_adl_fseen_ts_1;
SELF.bureau_adl_tu_fseen_pos_1 := bureau_adl_tu_fseen_pos_1;
SELF.bureau_adl_fseen_tu_1 := bureau_adl_fseen_tu_1;
SELF._bureau_adl_fseen_tu_1 := _bureau_adl_fseen_tu_1;
SELF.bureau_adl_tn_fseen_pos_1 := bureau_adl_tn_fseen_pos_1;
SELF.bureau_adl_fseen_tn_1 := bureau_adl_fseen_tn_1;
SELF._bureau_adl_fseen_tn_1 := _bureau_adl_fseen_tn_1;
SELF.nf_m_bureau_adl_fs_notu := nf_m_bureau_adl_fs_notu;
SELF.rv_i60_inq_prepaidcards_recency := rv_i60_inq_prepaidcards_recency;
SELF.rv_c12_source_profile := rv_c12_source_profile;
SELF.nf_fp_idrisktype := nf_fp_idrisktype;
SELF.rv_c13_curr_addr_lres := rv_c13_curr_addr_lres;
SELF.nf_fp_curraddrmedianincome := nf_fp_curraddrmedianincome;
SELF.rv_i62_inq_addrs_per_adl := rv_i62_inq_addrs_per_adl;
SELF.bureau_adl_eq_fseen_pos_2 := bureau_adl_eq_fseen_pos_2;
SELF.bureau_adl_en_fseen_pos_1 := bureau_adl_en_fseen_pos_1;
SELF.bureau_adl_fseen_eq_2 := bureau_adl_fseen_eq_2;
SELF._bureau_adl_fseen_eq_2 := _bureau_adl_fseen_eq_2;
SELF.bureau_adl_fseen_en_1 := bureau_adl_fseen_en_1;
SELF._bureau_adl_fseen_en_1 := _bureau_adl_fseen_en_1;
SELF._src_bureau_adl_fseen_1 := _src_bureau_adl_fseen_1;
SELF.nf_m_bureau_adl_fs := nf_m_bureau_adl_fs;
SELF.rv_a50_pb_average_dollars := rv_a50_pb_average_dollars;
SELF.add_curr_nhood_prop_sum_3 := add_curr_nhood_prop_sum_3;
SELF.nf_add_curr_nhood_sfd_pct := nf_add_curr_nhood_sfd_pct;
SELF.nf_fp_prevaddrageoldest := nf_fp_prevaddrageoldest;
SELF.nf_inq_communications_count := nf_inq_communications_count;
SELF.bureau_adl_eq_fseen_pos_1 := bureau_adl_eq_fseen_pos_1;
SELF.bureau_adl_fseen_eq_1 := bureau_adl_fseen_eq_1;
SELF._bureau_adl_fseen_eq_1 := _bureau_adl_fseen_eq_1;
SELF.bureau_adl_en_fseen_pos := bureau_adl_en_fseen_pos;
SELF.bureau_adl_fseen_en := bureau_adl_fseen_en;
SELF._bureau_adl_fseen_en := _bureau_adl_fseen_en;
SELF.bureau_adl_ts_fseen_pos := bureau_adl_ts_fseen_pos;
SELF.bureau_adl_fseen_ts := bureau_adl_fseen_ts;
SELF._bureau_adl_fseen_ts := _bureau_adl_fseen_ts;
SELF.bureau_adl_tu_fseen_pos := bureau_adl_tu_fseen_pos;
SELF.bureau_adl_fseen_tu := bureau_adl_fseen_tu;
SELF._bureau_adl_fseen_tu := _bureau_adl_fseen_tu;
SELF.bureau_adl_tn_fseen_pos := bureau_adl_tn_fseen_pos;
SELF.bureau_adl_fseen_tn := bureau_adl_fseen_tn;
SELF._bureau_adl_fseen_tn := _bureau_adl_fseen_tn;
SELF._src_bureau_adl_fseen_all := _src_bureau_adl_fseen_all;
SELF.nf_m_bureau_adl_fs_all := nf_m_bureau_adl_fs_all;
SELF.bureau_adl_eq_fseen_pos := bureau_adl_eq_fseen_pos;
SELF.bureau_adl_fseen_eq := bureau_adl_fseen_eq;
SELF._bureau_adl_fseen_eq := _bureau_adl_fseen_eq;
SELF._src_bureau_adl_fseen := _src_bureau_adl_fseen;
SELF.rv_c20_m_bureau_adl_fs := rv_c20_m_bureau_adl_fs;
SELF.nf_inq_highriskcredit_count := nf_inq_highriskcredit_count;
SELF.iv_prv_addr_lres := iv_prv_addr_lres;
SELF.rv_c13_max_lres := rv_c13_max_lres;
SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
SELF._header_first_seen := _header_first_seen;
SELF.rv_c10_m_hdr_fs := rv_c10_m_hdr_fs;
SELF.rv_c13_attr_addrs_recency := rv_c13_attr_addrs_recency;
SELF.rv_i60_inq_comm_recency := rv_i60_inq_comm_recency;
SELF.nf_fp_prevaddrmedianincome := nf_fp_prevaddrmedianincome;
SELF.rv_d32_felony_count := rv_d32_felony_count;
SELF.nf_fp_curraddrmedianvalue := nf_fp_curraddrmedianvalue;
SELF.nf_fp_srchunvrfdphonecount := nf_fp_srchunvrfdphonecount;
SELF.add_curr_nhood_prop_sum_2 := add_curr_nhood_prop_sum_2;
SELF.nf_add_curr_nhood_vac_pct := nf_add_curr_nhood_vac_pct;
SELF.nf_fp_vardobcountnew := nf_fp_vardobcountnew;
SELF.nf_pct_rel_with_felony := nf_pct_rel_with_felony;
SELF.iv_prv_addr_avm_auto_val := iv_prv_addr_avm_auto_val;
SELF.nf_fp_curraddrburglaryindex := nf_fp_curraddrburglaryindex;
SELF.nf_hh_members_ct := nf_hh_members_ct;
SELF.iv_prop1_purch_sale_diff := iv_prop1_purch_sale_diff;
SELF.nf_util_adl_count := nf_util_adl_count;
SELF.nf_hh_tot_derog := nf_hh_tot_derog;
SELF.nf_fp_prevaddrcrimeindex := nf_fp_prevaddrcrimeindex;
SELF._inq_banko_om_first_seen := _inq_banko_om_first_seen;
SELF.nf_mos_inq_banko_om_fseen := nf_mos_inq_banko_om_fseen;
SELF.add_curr_nhood_prop_sum_1 := add_curr_nhood_prop_sum_1;
SELF.nf_add_curr_nhood_mfd_pct := nf_add_curr_nhood_mfd_pct;
SELF.rv_c16_inv_ssn_per_adl := rv_c16_inv_ssn_per_adl;
SELF.nf_hh_age_18_plus := nf_hh_age_18_plus;
SELF.nf_fp_prevaddrmedianvalue := nf_fp_prevaddrmedianvalue;
SELF.rv_a46_curr_avm_autoval := rv_a46_curr_avm_autoval;
SELF.iv_unverified_addr_count := iv_unverified_addr_count;
SELF.nf_average_rel_home_val := nf_average_rel_home_val;
SELF.br_first_seen_char := br_first_seen_char;
SELF._br_first_seen := _br_first_seen;
SELF.rv_mos_since_br_first_seen := rv_mos_since_br_first_seen;
SELF.nf_current_count := nf_current_count;
SELF.iv_c13_avg_lres := iv_c13_avg_lres;
SELF.iv_rv5_deceased := iv_rv5_deceased;
SELF.nf_fp_prevaddrcartheftindex := nf_fp_prevaddrcartheftindex;
SELF.nf_hh_lienholders_pct := nf_hh_lienholders_pct;
SELF.rv_a50_pb_total_dollars := rv_a50_pb_total_dollars;
SELF.nf_fp_curraddrmurderindex := nf_fp_curraddrmurderindex;
SELF.nf_historical_count := nf_historical_count;
SELF.nf_average_rel_income := nf_average_rel_income;
SELF.nf_pct_rel_prop_owned := nf_pct_rel_prop_owned;
SELF.nf_fp_prevaddrlenofres := nf_fp_prevaddrlenofres;
SELF.nf_inq_other_count := nf_inq_other_count;
SELF._liens_unrel_ft_first_seen := _liens_unrel_ft_first_seen;
SELF.nf_mos_liens_unrel_ft_fseen := nf_mos_liens_unrel_ft_fseen;
SELF.nf_attr_arrest_recency := nf_attr_arrest_recency;
SELF.nf_fp_srchfraudsrchcountmo := nf_fp_srchfraudsrchcountmo;
SELF.iv_prof_license_category_pl := iv_prof_license_category_pl;
SELF.nf_pb_retail_combo_cnt := nf_pb_retail_combo_cnt;
SELF.nf_rel_felony_count := nf_rel_felony_count;
SELF.add_curr_nhood_prop_sum := add_curr_nhood_prop_sum;
SELF.nf_add_curr_nhood_bus_pct := nf_add_curr_nhood_bus_pct;
SELF.rv_i60_inq_other_recency := rv_i60_inq_other_recency;
SELF.nf_hh_age_30_plus := nf_hh_age_30_plus;
SELF.nf_fp_prevaddrburglaryindex := nf_fp_prevaddrburglaryindex;
SELF.nf_hh_payday_loan_users_pct := nf_hh_payday_loan_users_pct;
SELF.nf_hh_collections_ct := nf_hh_collections_ct;
SELF.nf_pct_rel_with_bk := nf_pct_rel_with_bk;
SELF.nf_hh_payday_loan_users := nf_hh_payday_loan_users;
SELF.nf_pct_rel_with_criminal := nf_pct_rel_with_criminal;
SELF.iv_c14_addrs_per_adl := iv_c14_addrs_per_adl;
SELF.nf_fp_assocsuspicousidcount := nf_fp_assocsuspicousidcount;
SELF.rv_d32_criminal_count := rv_d32_criminal_count;
SELF.sum_dols := sum_dols;
SELF.pct_retail_dols := pct_retail_dols;
SELF.pct_offline_dols := pct_offline_dols;
SELF.pct_online_dols := pct_online_dols;
SELF.iv_pb_profile := iv_pb_profile;
SELF.nf_rel_criminal_count := nf_rel_criminal_count;
SELF._inq_banko_om_last_seen := _inq_banko_om_last_seen;
SELF.nf_mos_inq_banko_om_lseen := nf_mos_inq_banko_om_lseen;
SELF.rv_d31_mostrec_bk := rv_d31_mostrec_bk;
SELF.nf_rel_derog_summary := nf_rel_derog_summary;
SELF.rv_a50_pb_total_orders := rv_a50_pb_total_orders;
SELF.nf_average_rel_age := nf_average_rel_age;
SELF.nf_pb_retail_combo_max := nf_pb_retail_combo_max;
SELF.nf_dl_addrs_per_adl := nf_dl_addrs_per_adl;
SELF.nf_fp_curraddrcartheftindex := nf_fp_curraddrcartheftindex;
SELF.nf_inq_auto_count := nf_inq_auto_count;
SELF.rv_i61_inq_collection_recency := rv_i61_inq_collection_recency;
SELF.nf_hh_collections_ct_avg := nf_hh_collections_ct_avg;
SELF.nf_hh_prof_license_holders_pct := nf_hh_prof_license_holders_pct;
SELF.rv_f04_curr_add_occ_index := rv_f04_curr_add_occ_index;
SELF.iv_prop2_purch_sale_diff := iv_prop2_purch_sale_diff;
SELF.rv_d34_attr_liens_recency := rv_d34_attr_liens_recency;
SELF._acc_last_seen := _acc_last_seen;
SELF.nf_mos_acc_lseen := nf_mos_acc_lseen;
SELF.nf_inq_count_week := nf_inq_count_week;
SELF.rv_d33_eviction_count := rv_d33_eviction_count;
SELF.rv_d31_all_bk := rv_d31_all_bk;
SELF.rv_ever_asset_owner := rv_ever_asset_owner;
SELF.nf_fp_assocrisktype := nf_fp_assocrisktype;
SELF.nf_liens_unrel_cj_total_amt := nf_liens_unrel_cj_total_amt;
SELF.rv_c14_addrs_15yr := rv_c14_addrs_15yr;
SELF.nf_inq_collection_count := nf_inq_collection_count;
SELF.nf_rel_bankrupt_count := nf_rel_bankrupt_count;
SELF.rv_i60_inq_hiriskcred_count12 := rv_i60_inq_hiriskcred_count12;
SELF.rv_email_domain_isp_count := rv_email_domain_isp_count;
SELF.nf_liens_unrel_sc_total_amt := nf_liens_unrel_sc_total_amt;
SELF.nf_rel_count := nf_rel_count;
SELF.nf_fp_curraddrcrimeindex := nf_fp_curraddrcrimeindex;
SELF.nf_hh_lienholders := nf_hh_lienholders;
SELF.nf_liens_unrel_ot_total_amt := nf_liens_unrel_ot_total_amt;
SELF.nf_hh_pct_property_owners := nf_hh_pct_property_owners;
SELF.iv_br_source_count := iv_br_source_count;
SELF._liens_unrel_cj_first_seen := _liens_unrel_cj_first_seen;
SELF.nf_mos_liens_unrel_cj_fseen := nf_mos_liens_unrel_cj_fseen;
SELF.rv_i60_inq_recency := rv_i60_inq_recency;
SELF.nf_hh_criminals_pct := nf_hh_criminals_pct;
SELF.nf_inq_collection_count24 := nf_inq_collection_count24;
SELF.nf_fp_srchfraudsrchcountwk := nf_fp_srchfraudsrchcountwk;
SELF.nf_hh_property_owners_ct := nf_hh_property_owners_ct;
SELF.nf_inq_prepaidcards_count := nf_inq_prepaidcards_count;
SELF.nf_fp_prevaddrmurderindex := nf_fp_prevaddrmurderindex;
SELF.nf_average_rel_distance := nf_average_rel_distance;
SELF.nf_liens_rel_cj_total_amt := nf_liens_rel_cj_total_amt;
SELF._inq_banko_am_last_seen := _inq_banko_am_last_seen;
SELF.nf_mos_inq_banko_am_lseen := nf_mos_inq_banko_am_lseen;
SELF.rv_d30_derog_count := rv_d30_derog_count;
SELF._liens_unrel_cj_last_seen := _liens_unrel_cj_last_seen;
SELF.nf_mos_liens_unrel_cj_lseen := nf_mos_liens_unrel_cj_lseen;
SELF.rv_s66_ssns_per_adl_c6 := rv_s66_ssns_per_adl_c6;
SELF.nf_inq_count24 := nf_inq_count24;
SELF.rv_c18_invalid_addrs_per_adl := rv_c18_invalid_addrs_per_adl;
SELF.nf_inq_other_count24 := nf_inq_other_count24;
SELF.nf_fp_assoccredbureaucount := nf_fp_assoccredbureaucount;
SELF.nf_fp_prevaddrstatus := nf_fp_prevaddrstatus;
SELF.nf_inq_count := nf_inq_count;
SELF.nf_fp_sourcerisktype := nf_fp_sourcerisktype;
SELF.nf_hh_bankruptcies_pct := nf_hh_bankruptcies_pct;
SELF.nf_inq_other_count_week := nf_inq_other_count_week;
SELF._inq_banko_cm_last_seen := _inq_banko_cm_last_seen;
SELF.nf_mos_inq_banko_cm_lseen := nf_mos_inq_banko_cm_lseen;
SELF.rv_c14_addr_stability_v2 := rv_c14_addr_stability_v2;
SELF.rv_a41_a42_prop_owner_history := rv_a41_a42_prop_owner_history;
SELF.nf_inq_prepaidcards_count24 := nf_inq_prepaidcards_count24;
SELF.rv_d34_unrel_liens_ct := rv_d34_unrel_liens_ct;
SELF.rv_i62_inq_ssns_per_adl := rv_i62_inq_ssns_per_adl;
SELF.rv_c21_stl_inq_count180 := rv_c21_stl_inq_count180;
SELF.nf_liens_unrel_ft_total_amt := nf_liens_unrel_ft_total_amt;
SELF.rv_email_count := rv_email_count;
SELF.nf_hh_tot_derog_avg := nf_hh_tot_derog_avg;
SELF.nf_accident_count := nf_accident_count;
SELF.iv_d57_attr_proflic_recency := iv_d57_attr_proflic_recency;
SELF.rv_c12_num_nonderogs := rv_c12_num_nonderogs;
SELF.rv_i60_inq_other_count12 := rv_i60_inq_other_count12;
SELF.nf_liens_unrel_st_total_amt := nf_liens_unrel_st_total_amt;
SELF.nf_inq_communications_count24 := nf_inq_communications_count24;
SELF._felony_last_date := _felony_last_date;
SELF.rv_d32_mos_since_fel_ls := rv_d32_mos_since_fel_ls;
SELF.nf_highest_rel_home_val := nf_highest_rel_home_val;
SELF.nf_hh_age_65_plus := nf_hh_age_65_plus;
SELF._liens_unrel_ft_last_seen := _liens_unrel_ft_last_seen;
SELF.nf_mos_liens_unrel_ft_lseen := nf_mos_liens_unrel_ft_lseen;
SELF.nf_inq_highriskcredit_count24 := nf_inq_highriskcredit_count24;
SELF.rv_d34_unrel_lien60_count := rv_d34_unrel_lien60_count;
SELF.iv_a46_l77_addrs_move_traj := iv_a46_l77_addrs_move_traj;
SELF.iv_college_code := iv_college_code;
SELF.rv_i62_inq_phones_per_adl := rv_i62_inq_phones_per_adl;
SELF.nf_inq_banking_count24 := nf_inq_banking_count24;
SELF.nf_inq_utilities_count := nf_inq_utilities_count;
SELF._liens_unrel_ot_first_seen := _liens_unrel_ot_first_seen;
SELF.nf_mos_liens_unrel_ot_fseen := nf_mos_liens_unrel_ot_fseen;
SELF._foreclosure_last_date := _foreclosure_last_date;
SELF.nf_mos_foreclosure_lseen := nf_mos_foreclosure_lseen;
SELF._liens_rel_ot_last_seen := _liens_rel_ot_last_seen;
SELF.nf_mos_liens_rel_ot_lseen := nf_mos_liens_rel_ot_lseen;
SELF.iv_d34_liens_unrel_sc_ct := iv_d34_liens_unrel_sc_ct;
SELF.nf_inq_mortgage_count24 := nf_inq_mortgage_count24;
SELF._liens_rel_cj_first_seen := _liens_rel_cj_first_seen;
SELF.nf_mos_liens_rel_cj_fseen := nf_mos_liens_rel_cj_fseen;
SELF.nf_pct_rel_prop_sold := nf_pct_rel_prop_sold;
SELF.nf_oldest_rel_age := nf_oldest_rel_age;
SELF.nf_youngest_rel_age := nf_youngest_rel_age;
SELF.iv_prof_license_category_pm := iv_prof_license_category_pm;
SELF.nf_inq_retailpayments_count := nf_inq_retailpayments_count;
SELF.nf_fp_vardobcount := nf_fp_vardobcount;
SELF.nf_acc_damage_amt_total := nf_acc_damage_amt_total;
SELF.nf_fp_srchfraudsrchcountyr := nf_fp_srchfraudsrchcountyr;
SELF.iv_a46_l77_addrs_move_traj_index := iv_a46_l77_addrs_move_traj_index;
SELF.rv_a43_rec_vehx_level := rv_a43_rec_vehx_level;
SELF.rv_i60_inq_banking_count12 := rv_i60_inq_banking_count12;
SELF.rv_i60_inq_retpymt_recency := rv_i60_inq_retpymt_recency;
SELF.nf_hh_bankruptcies := nf_hh_bankruptcies;
SELF.nf_liens_unrel_st_ct := nf_liens_unrel_st_ct;
SELF.iv_curr_add_financing_type := iv_curr_add_financing_type;
SELF.nf_fp_varmsrcssncount := nf_fp_varmsrcssncount;
SELF._inq_banko_cm_first_seen := _inq_banko_cm_first_seen;
SELF.nf_mos_inq_banko_cm_fseen := nf_mos_inq_banko_cm_fseen;
SELF.rv_e58_br_dead_business_count := rv_e58_br_dead_business_count;
SELF.rv_d31_bk_chapter := rv_d31_bk_chapter;
SELF.nf_highest_rel_income := nf_highest_rel_income;
SELF.iv_d31_bk_filing_type := iv_d31_bk_filing_type;
SELF.nf_lowest_rel_income := nf_lowest_rel_income;
SELF.br_company_title1 := br_company_title1;
SELF.br_company_title2 := br_company_title2;
SELF.rv_bus_leadership_title := rv_bus_leadership_title;
SELF.rv_d31_attr_bankruptcy_recency := rv_d31_attr_bankruptcy_recency;
SELF.nf_hh_workers_paw_pct := nf_hh_workers_paw_pct;
SELF.nf_inq_auto_count24 := nf_inq_auto_count24;
SELF.rv_i62_inq_dobs_per_adl := rv_i62_inq_dobs_per_adl;
SELF.rv_d32_attr_felonies_recency := rv_d32_attr_felonies_recency;
SELF._liens_unrel_sc_last_seen := _liens_unrel_sc_last_seen;
SELF.nf_mos_liens_unrel_sc_lseen := nf_mos_liens_unrel_sc_lseen;
SELF.rv_i60_inq_hiriskcred_recency := rv_i60_inq_hiriskcred_recency;
SELF.rv_c14_addrs_10yr := rv_c14_addrs_10yr;
SELF._liens_unrel_sc_first_seen := _liens_unrel_sc_first_seen;
SELF.nf_liens_rel_ot_total_amt := nf_liens_rel_ot_total_amt;
SELF._liens_unrel_ot_last_seen := _liens_unrel_ot_last_seen;
SELF.nf_mos_liens_unrel_ot_lseen := nf_mos_liens_unrel_ot_lseen;
SELF.nf_accident_recency := nf_accident_recency;
SELF._liens_unrel_o_first_seen := _liens_unrel_o_first_seen;
SELF.nf_mos_liens_unrel_o_fseen := nf_mos_liens_unrel_o_fseen;
SELF.nf_fp_srchunvrfddobcount := nf_fp_srchunvrfddobcount;
SELF._liens_unrel_st_first_seen := _liens_unrel_st_first_seen;
SELF.nf_mos_liens_unrel_st_fseen := nf_mos_liens_unrel_st_fseen;
SELF.rv_c19_add_prison_hist := rv_c19_add_prison_hist;
SELF.nf_inq_utilities_count24 := nf_inq_utilities_count24;
SELF.nf_hh_members_w_derog := nf_hh_members_w_derog;
SELF._inq_banko_am_first_seen := _inq_banko_am_first_seen;
SELF.nf_fp_assoccredbureaucountnew := nf_fp_assoccredbureaucountnew;
SELF._liens_rel_cj_last_seen := _liens_rel_cj_last_seen;
SELF.nf_mos_liens_rel_cj_lseen := nf_mos_liens_rel_cj_lseen;
SELF.iv_college_type := iv_college_type;
SELF._liens_unrel_st_last_seen := _liens_unrel_st_last_seen;
SELF.nf_mos_liens_unrel_st_lseen := nf_mos_liens_unrel_st_lseen;
SELF.nf_inq_retailpayments_count24 := nf_inq_retailpayments_count24;
SELF.iv_d34_liens_rel_ot_ct := iv_d34_liens_rel_ot_ct;
SELF.rv_d31_bk_disposed_hist_count := rv_d31_bk_disposed_hist_count;
SELF._liens_rel_ft_first_seen := _liens_rel_ft_first_seen;
SELF.nf_mos_liens_rel_ft_fseen := nf_mos_liens_rel_ft_fseen;
SELF.nf_inq_mortgage_count := nf_inq_mortgage_count;
SELF._liens_unrel_o_last_seen := _liens_unrel_o_last_seen;
SELF.nf_mos_liens_unrel_o_lseen := nf_mos_liens_unrel_o_lseen;
SELF.rv_br_active_phone_count := rv_br_active_phone_count;
SELF.nf_inq_banking_count := nf_inq_banking_count;
SELF.iv_d34_liens_unrel_ot_ct := iv_d34_liens_unrel_ot_ct;
SELF.nf_liens_rel_o_total_amt := nf_liens_rel_o_total_amt;
SELF.fp3_lexid_cen_mod_0 := fp3_lexid_cen_mod_0;
SELF.fp3_lexid_cen_mod_1 := fp3_lexid_cen_mod_1;
SELF.fp3_lexid_cen_mod_2 := fp3_lexid_cen_mod_2;
SELF.fp3_lexid_cen_mod_3 := fp3_lexid_cen_mod_3;
SELF.fp3_lexid_cen_mod_4 := fp3_lexid_cen_mod_4;
SELF.fp3_lexid_cen_mod_5 := fp3_lexid_cen_mod_5;
SELF.fp3_lexid_cen_mod_6 := fp3_lexid_cen_mod_6;
SELF.fp3_lexid_cen_mod_7 := fp3_lexid_cen_mod_7;
SELF.fp3_lexid_cen_mod_8 := fp3_lexid_cen_mod_8;
SELF.fp3_lexid_cen_mod_9 := fp3_lexid_cen_mod_9;
SELF.fp3_lexid_cen_mod_10 := fp3_lexid_cen_mod_10;
SELF.fp3_lexid_cen_mod_11 := fp3_lexid_cen_mod_11;
SELF.fp3_lexid_cen_mod_12 := fp3_lexid_cen_mod_12;
SELF.fp3_lexid_cen_mod_13 := fp3_lexid_cen_mod_13;
SELF.fp3_lexid_cen_mod_14 := fp3_lexid_cen_mod_14;
SELF.fp3_lexid_cen_mod_15 := fp3_lexid_cen_mod_15;
SELF.fp3_lexid_cen_mod_16 := fp3_lexid_cen_mod_16;
SELF.fp3_lexid_cen_mod_17 := fp3_lexid_cen_mod_17;
SELF.fp3_lexid_cen_mod_18 := fp3_lexid_cen_mod_18;
SELF.fp3_lexid_cen_mod_19 := fp3_lexid_cen_mod_19;
SELF.fp3_lexid_cen_mod_20 := fp3_lexid_cen_mod_20;
SELF.fp3_lexid_cen_mod_21 := fp3_lexid_cen_mod_21;
SELF.fp3_lexid_cen_mod_22 := fp3_lexid_cen_mod_22;
SELF.fp3_lexid_cen_mod_23 := fp3_lexid_cen_mod_23;
SELF.fp3_lexid_cen_mod_24 := fp3_lexid_cen_mod_24;
SELF.fp3_lexid_cen_mod_25 := fp3_lexid_cen_mod_25;
SELF.fp3_lexid_cen_mod_26 := fp3_lexid_cen_mod_26;
SELF.fp3_lexid_cen_mod_27 := fp3_lexid_cen_mod_27;
SELF.fp3_lexid_cen_mod_28 := fp3_lexid_cen_mod_28;
SELF.fp3_lexid_cen_mod_29 := fp3_lexid_cen_mod_29;
SELF.fp3_lexid_cen_mod_30 := fp3_lexid_cen_mod_30;
SELF.fp3_lexid_cen_mod_31 := fp3_lexid_cen_mod_31;
SELF.fp3_lexid_cen_mod_32 := fp3_lexid_cen_mod_32;
SELF.fp3_lexid_cen_mod_33 := fp3_lexid_cen_mod_33;
SELF.fp3_lexid_cen_mod_34 := fp3_lexid_cen_mod_34;
SELF.fp3_lexid_cen_mod_35 := fp3_lexid_cen_mod_35;
SELF.fp3_lexid_cen_mod_36 := fp3_lexid_cen_mod_36;
SELF.fp3_lexid_cen_mod_37 := fp3_lexid_cen_mod_37;
SELF.fp3_lexid_cen_mod_38 := fp3_lexid_cen_mod_38;
SELF.fp3_lexid_cen_mod_39 := fp3_lexid_cen_mod_39;
SELF.fp3_lexid_cen_mod_40 := fp3_lexid_cen_mod_40;
SELF.fp3_lexid_cen_mod_41 := fp3_lexid_cen_mod_41;
SELF.fp3_lexid_cen_mod_42 := fp3_lexid_cen_mod_42;
SELF.fp3_lexid_cen_mod_43 := fp3_lexid_cen_mod_43;
SELF.census_mod := census_mod;
SELF.fp3_lexid_model_0 := fp3_lexid_model_0;
SELF.fp3_lexid_model_1 := fp3_lexid_model_1;
SELF.fp3_lexid_model_2 := fp3_lexid_model_2;
SELF.fp3_lexid_model_3 := fp3_lexid_model_3;
SELF.fp3_lexid_model_4 := fp3_lexid_model_4;
SELF.fp3_lexid_model_5 := fp3_lexid_model_5;
SELF.fp3_lexid_model_6 := fp3_lexid_model_6;
SELF.fp3_lexid_model_7 := fp3_lexid_model_7;
SELF.fp3_lexid_model_8 := fp3_lexid_model_8;
SELF.fp3_lexid_model_9 := fp3_lexid_model_9;
SELF.fp3_lexid_model_10 := fp3_lexid_model_10;
SELF.fp3_lexid_model_11 := fp3_lexid_model_11;
SELF.fp3_lexid_model_12 := fp3_lexid_model_12;
SELF.fp3_lexid_model_13 := fp3_lexid_model_13;
SELF.fp3_lexid_model_14 := fp3_lexid_model_14;
SELF.fp3_lexid_model_15 := fp3_lexid_model_15;
SELF.fp3_lexid_model_16 := fp3_lexid_model_16;
SELF.fp3_lexid_model_17 := fp3_lexid_model_17;
SELF.fp3_lexid_model_18 := fp3_lexid_model_18;
SELF.fp3_lexid_model_19 := fp3_lexid_model_19;
SELF.fp3_lexid_model_20 := fp3_lexid_model_20;
SELF.fp3_lexid_model_21 := fp3_lexid_model_21;
SELF.fp3_lexid_model_22 := fp3_lexid_model_22;
SELF.fp3_lexid_model_23 := fp3_lexid_model_23;
SELF.fp3_lexid_model_24 := fp3_lexid_model_24;
SELF.fp3_lexid_model_25 := fp3_lexid_model_25;
SELF.fp3_lexid_model_26 := fp3_lexid_model_26;
SELF.fp3_lexid_model_27 := fp3_lexid_model_27;
SELF.fp3_lexid_model_28 := fp3_lexid_model_28;
SELF.fp3_lexid_model_29 := fp3_lexid_model_29;
SELF.fp3_lexid_model_30 := fp3_lexid_model_30;
SELF.fp3_lexid_model_31 := fp3_lexid_model_31;
SELF.fp3_lexid_model_32 := fp3_lexid_model_32;
SELF.fp3_lexid_model_33 := fp3_lexid_model_33;
SELF.fp3_lexid_model_34 := fp3_lexid_model_34;
SELF.fp3_lexid_model_35 := fp3_lexid_model_35;
SELF.fp3_lexid_model_36 := fp3_lexid_model_36;
SELF.fp3_lexid_model_37 := fp3_lexid_model_37;
SELF.fp3_lexid_model_38 := fp3_lexid_model_38;
SELF.fp3_lexid_model_39 := fp3_lexid_model_39;
SELF.fp3_lexid_model_40 := fp3_lexid_model_40;
SELF.fp3_lexid_model_41 := fp3_lexid_model_41;
SELF.fp3_lexid_model_42 := fp3_lexid_model_42;
SELF.fp3_lexid_model_43 := fp3_lexid_model_43;
SELF.fp3_lexid_model_44 := fp3_lexid_model_44;
SELF.fp3_lexid_model_45 := fp3_lexid_model_45;
SELF.fp3_lexid_model_46 := fp3_lexid_model_46;
SELF.fp3_lexid_model_47 := fp3_lexid_model_47;
SELF.fp3_lexid_model_48 := fp3_lexid_model_48;
SELF.fp3_lexid_model_49 := fp3_lexid_model_49;
SELF.fp3_lexid_model_50 := fp3_lexid_model_50;
SELF.fp3_lexid_model_51 := fp3_lexid_model_51;
SELF.fp3_lexid_model_52 := fp3_lexid_model_52;
SELF.fp3_lexid_model_53 := fp3_lexid_model_53;
SELF.fp3_lexid_model_54 := fp3_lexid_model_54;
SELF.fp3_lexid_model_55 := fp3_lexid_model_55;
SELF.fp3_lexid_model_56 := fp3_lexid_model_56;
SELF.fp3_lexid_model_57 := fp3_lexid_model_57;
SELF.fp3_lexid_model_58 := fp3_lexid_model_58;
SELF.fp3_lexid_model_59 := fp3_lexid_model_59;
SELF.fp3_lexid_model_60 := fp3_lexid_model_60;
SELF.fp3_lexid_model_61 := fp3_lexid_model_61;
SELF.fp3_lexid_model_62 := fp3_lexid_model_62;
SELF.fp3_lexid_model_63 := fp3_lexid_model_63;
SELF.fp3_lexid_model_64 := fp3_lexid_model_64;
SELF.fp3_lexid_model_65 := fp3_lexid_model_65;
SELF.fp3_lexid_model_66 := fp3_lexid_model_66;
SELF.fp3_lexid_model_67 := fp3_lexid_model_67;
SELF.fp3_lexid_model_68 := fp3_lexid_model_68;
SELF.fp3_lexid_model_69 := fp3_lexid_model_69;
SELF.fp3_lexid_model_70 := fp3_lexid_model_70;
SELF.fp3_lexid_model_71 := fp3_lexid_model_71;
SELF.fp3_lexid_model_72 := fp3_lexid_model_72;
SELF.fp3_lexid_model_73 := fp3_lexid_model_73;
SELF.fp3_lexid_model_74 := fp3_lexid_model_74;
SELF.fp3_lexid_model_75 := fp3_lexid_model_75;
SELF.fp3_lexid_model_76 := fp3_lexid_model_76;
SELF.fp3_lexid_model_77 := fp3_lexid_model_77;
SELF.fp3_lexid_model_78 := fp3_lexid_model_78;
SELF.fp3_lexid_model_79 := fp3_lexid_model_79;
SELF.fp3_lexid_model_80 := fp3_lexid_model_80;
SELF.fp3_lexid_model_81 := fp3_lexid_model_81;
SELF.fp3_lexid_model_82 := fp3_lexid_model_82;
SELF.fp3_lexid_model_83 := fp3_lexid_model_83;
SELF.fp3_lexid_model_84 := fp3_lexid_model_84;
SELF.fp3_lexid_model_85 := fp3_lexid_model_85;
SELF.fp3_lexid_model_86 := fp3_lexid_model_86;
SELF.fp3_lexid_model_87 := fp3_lexid_model_87;
SELF.fp3_lexid_model_88 := fp3_lexid_model_88;
SELF.fp3_lexid_model_89 := fp3_lexid_model_89;
SELF.fp3_lexid_model_90 := fp3_lexid_model_90;
SELF.fp3_lexid_model_91 := fp3_lexid_model_91;
SELF.fp3_lexid_model_92 := fp3_lexid_model_92;
SELF.fp3_lexid_model_93 := fp3_lexid_model_93;
SELF.fp3_lexid_model_94 := fp3_lexid_model_94;
SELF.fp3_lexid_model_95 := fp3_lexid_model_95;
SELF.fp3_lexid_model_96 := fp3_lexid_model_96;
SELF.fp3_lexid_model_97 := fp3_lexid_model_97;
SELF.fp3_lexid_model_98 := fp3_lexid_model_98;
SELF.fp3_lexid_model_99 := fp3_lexid_model_99;
SELF.fp3_lexid_model_100 := fp3_lexid_model_100;
SELF.fp3_lexid_model_101 := fp3_lexid_model_101;
SELF.fp3_lexid_model_102 := fp3_lexid_model_102;
SELF.fp3_lexid_model_103 := fp3_lexid_model_103;
SELF.fp3_lexid_model_104 := fp3_lexid_model_104;
SELF.fp3_lexid_model_105 := fp3_lexid_model_105;
SELF.fp3_lexid_model_106 := fp3_lexid_model_106;
SELF.fp3_lexid_model_107 := fp3_lexid_model_107;
SELF.fp3_lexid_model_108 := fp3_lexid_model_108;
SELF.fp3_lexid_model_109 := fp3_lexid_model_109;
SELF.fp3_lexid_model_110 := fp3_lexid_model_110;
SELF.fp3_lexid_model_111 := fp3_lexid_model_111;
SELF.fp3_lexid_model_112 := fp3_lexid_model_112;
SELF.fp3_lexid_model_113 := fp3_lexid_model_113;
SELF.fp3_lexid_model_114 := fp3_lexid_model_114;
SELF.fp3_lexid_model_115 := fp3_lexid_model_115;
SELF.fp3_lexid_model_116 := fp3_lexid_model_116;
SELF.fp3_lexid_model_117 := fp3_lexid_model_117;
SELF.fp3_lexid_model_118 := fp3_lexid_model_118;
SELF.fp3_lexid_model_119 := fp3_lexid_model_119;
SELF.fp3_lexid_model_120 := fp3_lexid_model_120;
SELF.fp3_lexid_model_121 := fp3_lexid_model_121;
SELF.fp3_lexid_model_122 := fp3_lexid_model_122;
SELF.fp3_lexid_model_123 := fp3_lexid_model_123;
SELF.fp3_lexid_model_124 := fp3_lexid_model_124;
SELF.fp3_lexid_model_125 := fp3_lexid_model_125;
SELF.fp3_lexid_model_126 := fp3_lexid_model_126;
SELF.fp3_lexid_model_127 := fp3_lexid_model_127;
SELF.fp3_lexid_model_128 := fp3_lexid_model_128;
SELF.fp3_lexid_model_129 := fp3_lexid_model_129;
SELF.fp3_lexid_model_130 := fp3_lexid_model_130;
SELF.fp3_lexid_model_131 := fp3_lexid_model_131;
SELF.fp3_lexid_model_132 := fp3_lexid_model_132;
SELF.fp3_lexid_model_133 := fp3_lexid_model_133;
SELF.fp3_lexid_model_134 := fp3_lexid_model_134;
SELF.fp3_lexid_model_135 := fp3_lexid_model_135;
SELF.fp3_lexid_model_136 := fp3_lexid_model_136;
SELF.fp3_lexid_model_137 := fp3_lexid_model_137;
SELF.fp3_lexid_model_138 := fp3_lexid_model_138;
SELF.fp3_lexid_model_139 := fp3_lexid_model_139;
SELF.fp3_lexid_model_140 := fp3_lexid_model_140;
SELF.fp3_lexid_model_141 := fp3_lexid_model_141;
SELF.fp3_lexid_model_142 := fp3_lexid_model_142;
SELF.fp3_lexid_model_143 := fp3_lexid_model_143;
SELF.fp3_lexid_model_144 := fp3_lexid_model_144;
SELF.fp3_lexid_model_145 := fp3_lexid_model_145;
SELF.fp3_lexid_model_146 := fp3_lexid_model_146;
SELF.fp3_lexid_model_147 := fp3_lexid_model_147;
SELF.fp3_lexid_model_148 := fp3_lexid_model_148;
SELF.fp3_lexid_model_149 := fp3_lexid_model_149;
SELF.fp3_lexid_model_150 := fp3_lexid_model_150;
SELF.fp3_lexid_model_151 := fp3_lexid_model_151;
SELF.fp3_lexid_model_152 := fp3_lexid_model_152;
SELF.fp3_lexid_model_153 := fp3_lexid_model_153;
SELF.fp3_lexid_model_154 := fp3_lexid_model_154;
SELF.fp3_lexid_model_155 := fp3_lexid_model_155;
SELF.fp3_lexid_model_156 := fp3_lexid_model_156;
SELF.fp3_lexid_model_157 := fp3_lexid_model_157;
SELF.fp3_lexid_model_158 := fp3_lexid_model_158;
SELF.fp3_lexid_model_159 := fp3_lexid_model_159;
SELF.fp3_lexid_model_160 := fp3_lexid_model_160;
SELF.fp3_lexid_model_161 := fp3_lexid_model_161;
SELF.fp3_lexid_model_162 := fp3_lexid_model_162;
SELF.fp3_lexid_model_163 := fp3_lexid_model_163;
SELF.fp3_lexid_model_164 := fp3_lexid_model_164;
SELF.fp3_lexid_model_165 := fp3_lexid_model_165;
SELF.fp3_lexid_model_166 := fp3_lexid_model_166;
SELF.fp3_lexid_model_167 := fp3_lexid_model_167;
SELF.fp3_lexid_model_168 := fp3_lexid_model_168;
SELF.fp3_lexid_model_169 := fp3_lexid_model_169;
SELF.fp3_lexid_model_170 := fp3_lexid_model_170;
SELF.fp3_lexid_model_171 := fp3_lexid_model_171;
SELF.fp3_lexid_model_172 := fp3_lexid_model_172;
SELF.fp3_lexid_model_173 := fp3_lexid_model_173;
SELF.fp3_lexid_model_174 := fp3_lexid_model_174;
SELF.fp3_lexid_model_175 := fp3_lexid_model_175;
SELF.fp3_lexid_model_176 := fp3_lexid_model_176;
SELF.fp3_lexid_model_177 := fp3_lexid_model_177;
SELF.fp3_lexid_model_178 := fp3_lexid_model_178;
SELF.fp3_lexid_model_179 := fp3_lexid_model_179;
SELF.fp3_lexid_model_180 := fp3_lexid_model_180;
SELF.fp3_lexid_model_181 := fp3_lexid_model_181;
SELF.fp3_lexid_model_182 := fp3_lexid_model_182;
SELF.fp3_lexid_model_183 := fp3_lexid_model_183;
SELF.fp3_lexid_model_184 := fp3_lexid_model_184;
SELF.fp3_lexid_model_185 := fp3_lexid_model_185;
SELF.fp3_lexid_model_186 := fp3_lexid_model_186;
SELF.fp3_lexid_model_187 := fp3_lexid_model_187;
SELF.fp3_lexid_model_188 := fp3_lexid_model_188;
SELF.fp3_lexid_model_189 := fp3_lexid_model_189;
SELF.fp3_lexid_model_190 := fp3_lexid_model_190;
SELF.fp3_lexid_model_191 := fp3_lexid_model_191;
SELF.fp3_lexid_model_192 := fp3_lexid_model_192;
SELF.fp3_lexid_model_193 := fp3_lexid_model_193;
SELF.fp3_lexid_model_194 := fp3_lexid_model_194;
SELF.fp3_lexid_model_195 := fp3_lexid_model_195;
SELF.fp3_lexid_model_196 := fp3_lexid_model_196;
SELF.fp3_lexid_model_197 := fp3_lexid_model_197;
SELF.fp3_lexid_model_198 := fp3_lexid_model_198;
SELF.fp3_lexid_model_199 := fp3_lexid_model_199;
SELF.fp3_lexid_model_200 := fp3_lexid_model_200;
SELF.fp3_lexid_model_201 := fp3_lexid_model_201;
SELF.fp3_lexid_model_202 := fp3_lexid_model_202;
SELF.fp3_lexid_model_203 := fp3_lexid_model_203;
SELF.fp3_lexid_model_204 := fp3_lexid_model_204;
SELF.fp3_lexid_model_205 := fp3_lexid_model_205;
SELF.fp3_lexid_model_206 := fp3_lexid_model_206;
SELF.fp3_lexid_model_207 := fp3_lexid_model_207;
SELF.fp3_lexid_model_208 := fp3_lexid_model_208;
SELF.fp3_lexid_model_209 := fp3_lexid_model_209;
SELF.fp3_lexid_model_210 := fp3_lexid_model_210;
SELF.fp3_lexid_model_211 := fp3_lexid_model_211;
SELF.fp3_lexid_model_212 := fp3_lexid_model_212;
SELF.fp3_lexid_model_213 := fp3_lexid_model_213;
SELF.fp3_lexid_model_214 := fp3_lexid_model_214;
SELF.fp3_lexid_model_215 := fp3_lexid_model_215;
SELF.fp3_lexid_model_216 := fp3_lexid_model_216;
SELF.fp3_lexid_model_217 := fp3_lexid_model_217;
SELF.fp3_lexid_model_218 := fp3_lexid_model_218;
SELF.fp3_lexid_model_219 := fp3_lexid_model_219;
SELF.fp3_lexid_model_220 := fp3_lexid_model_220;
SELF.fp3_lexid_model_221 := fp3_lexid_model_221;
SELF.fp3_lexid_model_222 := fp3_lexid_model_222;
SELF.fp3_lexid_model_223 := fp3_lexid_model_223;
SELF.fp3_lexid_model_224 := fp3_lexid_model_224;
SELF.fp3_lexid_model_225 := fp3_lexid_model_225;
SELF.fp3_lexid_model_226 := fp3_lexid_model_226;
SELF.fp3_lexid_model_227 := fp3_lexid_model_227;
SELF.fp3_lexid_model_228 := fp3_lexid_model_228;
SELF.fp3_lexid_model_229 := fp3_lexid_model_229;
SELF.fp3_lexid_model_230 := fp3_lexid_model_230;
SELF._fp3_lexid_model_lgt := _fp3_lexid_model_lgt;
SELF.base := base;
SELF.pts := pts;
SELF.lgt := lgt;
SELF.offset := offset;
// SELF.fp31604_0_0_2 := fp31604_0_0_2;
// SELF.fp31604_0_0_1 := fp31604_0_0_1;
SELF.fp31604_0_0_score := fp31604_0_0_score;
SELF.fnamepop := fnamepop;
SELF.lnamepop := lnamepop;
SELF.addrpop := addrpop;
SELF.ssnlength := ssnlength;
SELF.dobpop := dobpop;
SELF.hphnpop := hphnpop;
SELF.nas_summary := nas_summary;
SELF.rc_ssndobflag := rc_ssndobflag;
SELF.rc_ssnmiskeyflag := rc_ssnmiskeyflag;
SELF.rc_addrmiskeyflag := rc_addrmiskeyflag;
SELF.add_input_house_number_match := add_input_house_number_match;
SELF.rc_pwssndobflag := rc_pwssndobflag;
SELF.ssns_per_adl := ssns_per_adl;
SELF.lnames_per_adl_c6 := lnames_per_adl_c6;
SELF.nap_summary := nap_summary;
SELF.stl_inq_count := stl_inq_count;
SELF.fp_srchssnsrchcountmo := fp_srchssnsrchcountmo;
SELF.fp_srchaddrsrchcountmo := fp_srchaddrsrchcountmo;
SELF.fp_srchphonesrchcountmo := fp_srchphonesrchcountmo;
SELF.nap_type := nap_type;
SELF._inputmiskeys := _inputmiskeys;
SELF._multiplessns := _multiplessns;
SELF._src_bureau_adl_fseen_notu := _src_bureau_adl_fseen_notu;
SELF._ssnpriortodob := _ssnpriortodob;
SELF._ver_src_cnt := _ver_src_cnt;
SELF._ver_src_de := _ver_src_de;
SELF._ver_src_ds := _ver_src_ds;
SELF._ver_src_en := _ver_src_en;
SELF._ver_src_eq := _ver_src_eq;
SELF._ver_src_tn := _ver_src_tn;
SELF._ver_src_tu := _ver_src_tu;
SELF._credit_source_cnt := _credit_source_cnt;
SELF._derog := _derog;
SELF._bureauonly := _bureauonly;
SELF._deceased := _deceased;
SELF._hh_strikes := _hh_strikes;


  #end

    self.seq := le.seq;
    self.score := (STRING3)fp31604_0_0_score;
    ritmp := 	fp_avenger_reasons( le, num_reasons, iv_rv5_deceased, iv_unverified_addr_count, nf_fp_srchunvrfdaddrcount,
																	nf_fp_srchunvrfdphonecount, nf_fp_vardobcountnew, nf_M_Bureau_ADL_FS_noTU, nf_seg_fraudpoint_3_0,
																	rv_c10_m_hdr_fs, rv_C16_Inv_SSN_Per_ADL, rv_I62_inq_addrs_per_adl );
    reasons := Models.Common.checkFraudPoint3RC34((integer)fp31604_0_0_score, ritmp, num_reasons);
    self.ri := reasons;
		self := [];

  END;
  
model :=   join(clam, Easi.Key_Easi_Census,
		(left.shell_input.st<>'' and left.shell_input.county <>''	and left.shell_input.geo_blk <> '' and 
		 left.addrpop and 
		 keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk)) or
		 //to match the modeler's code, search by current address as well but only if the input geo link fields are all blank
		// (left.shell_input.st= '' and left.shell_input.county =''	and left.shell_input.geo_blk = '' and
		(left.addrpop2 and ~left.addrpop and
		 left.Address_Verification.Address_History_1.st<>'' and left.Address_Verification.Address_History_1.county <>''	and left.Address_Verification.Address_History_1.geo_blk <> '' and 
		 keyed(right.geolink=left.Address_Verification.Address_History_1.st+left.Address_Verification.Address_History_1.county+left.Address_Verification.Address_History_1.geo_blk)), 
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1)
	);
	
  return model;
end;
