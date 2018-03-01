/*2016-03-23T18:04:40Z (bhelm)
C:\Users\helmbr01\AppData\Roaming\HPCC Systems\eclide\bhelm\default\Models\FP1512_1_0\2016-03-23T18_04_40Z.ecl
*/
import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, easi, std, Models;

EXPORT FP1512_1_0 (dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons) := FUNCTION
		
blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

	MODEL_DEBUG := FALSE;

	boolean isFCRA := false;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
UNSIGNED4 seq;
INTEGER _bureau_adl_fseen_en;
INTEGER _bureau_adl_fseen_eq;
INTEGER _bureau_adl_fseen_tn;
INTEGER _bureau_adl_fseen_ts;
INTEGER _bureau_adl_fseen_tu;
BOOLEAN _bureauonly;
INTEGER _credit_source_cnt;
INTEGER _criminal_last_date;
BOOLEAN _deceased;
BOOLEAN _derog;
INTEGER _felony_last_date;
INTEGER _hh_strikes;
INTEGER _in_dob;
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
INTEGER add_curr_avm_auto_val;
INTEGER add_curr_avm_auto_val_2;
INTEGER add_curr_lres;
INTEGER add_curr_nhood_bus_ct;
INTEGER add_curr_nhood_mfd_ct;
INTEGER add_curr_nhood_prop_sum;
INTEGER add_curr_nhood_prop_sum_1;
INTEGER add_curr_nhood_prop_sum_2;
INTEGER add_curr_nhood_prop_sum_3;
INTEGER add_curr_nhood_sfd_ct;
INTEGER add_curr_nhood_vac_prop;
INTEGER add_curr_occ_index;
BOOLEAN add_curr_pop;
INTEGER add_input_address_score;
INTEGER add_input_avm_auto_val;
BOOLEAN add_input_house_number_match;
INTEGER add_input_nhood_bus_ct;
INTEGER add_input_nhood_mfd_ct;
INTEGER add_input_nhood_prop_sum;
INTEGER add_input_nhood_sfd_ct;
INTEGER add_input_occ_index;
BOOLEAN add_input_owned_not_occ;
BOOLEAN add_input_pop;
BOOLEAN addrpop;
INTEGER addrs_15yr;
INTEGER addrs_5yr;
INTEGER addrs_per_adl_c6;
INTEGER addrs_per_ssn;
INTEGER addrs_per_ssn_c6;
BOOLEAN addrs_prison_history;
INTEGER adls_per_addr_c6;
INTEGER adls_per_addr_curr;
INTEGER adls_per_ssn;
INTEGER attr_arrests;
INTEGER attr_arrests12;
INTEGER attr_arrests180;
INTEGER attr_arrests24;
INTEGER attr_arrests30;
INTEGER attr_arrests36;
INTEGER attr_arrests60;
INTEGER attr_arrests90;
INTEGER attr_eviction_count;
INTEGER attr_eviction_count12;
INTEGER attr_eviction_count180;
INTEGER attr_eviction_count24;
INTEGER attr_eviction_count36;
INTEGER attr_eviction_count60;
INTEGER attr_eviction_count90;
INTEGER attr_num_nonderogs;
INTEGER attr_num_unrel_liens60;
INTEGER attr_total_number_derogs;
INTEGER base;
INTEGER bureau_adl_en_fseen_pos;
INTEGER bureau_adl_eq_fseen_pos;
STRING bureau_adl_fseen_en;
STRING bureau_adl_fseen_eq;
STRING bureau_adl_fseen_tn;
STRING bureau_adl_fseen_ts;
STRING bureau_adl_fseen_tu;
INTEGER bureau_adl_tn_fseen_pos;
INTEGER bureau_adl_ts_fseen_pos;
INTEGER bureau_adl_tu_fseen_pos;
STRING c_ab_av_edu;
STRING c_amus_indx;
STRING c_asian_lang;
STRING c_bel_edu;
STRING c_blue_col;
STRING c_blue_empl;
STRING c_born_usa;
STRING c_cartheft;
STRING c_civ_emp;
STRING c_construction;
STRING c_easiqlife;
STRING c_families;
STRING c_femdiv_p;
STRING c_food;
STRING c_health;
STRING c_hh1_p;
STRING c_hh2_p;
STRING c_hh4_p;
STRING c_hh5_p;
STRING c_high_ed;
STRING c_highinc;
STRING c_hval_100k_p;
STRING c_hval_150k_p;
STRING c_hval_250k_p;
STRING c_hval_60k_p;
STRING c_hval_80k_p;
STRING C_INC_100K_P;
STRING C_INC_125K_P;
STRING C_INC_15K_P;
STRING C_INC_25K_P;
STRING C_INC_50K_P;
STRING c_larceny;
STRING c_lowrent;
STRING c_many_cars;
STRING c_med_age;
STRING c_med_rent;
STRING c_med_yearblt;
STRING c_medi_indx;
STRING c_mort_indx;
STRING c_no_car;
STRING c_no_labfor;
STRING c_no_move;
STRING c_occunit_p;
STRING c_old_homes;
STRING c_pop_0_5_p;
STRING c_pop_55_64_p;
STRING c_pop_75_84_p;
STRING c_popover18;
STRING c_preschl;
STRING c_professional;
STRING c_relig_indx;
STRING c_rental;
STRING C_RENTOCC_P;
STRING c_retired;
STRING c_rnt750_p;
STRING c_serv_empl;
STRING c_span_lang;
STRING c_totcrime;
STRING c_trailer;
STRING c_trailer_p;
STRING c_unattach;
STRING c_unemp;
STRING c_very_rich;
STRING c_white_col;
STRING c_young;
INTEGER crim_rel_within100miles;
INTEGER crim_rel_within25miles;
INTEGER crim_rel_within500miles;
INTEGER criminal_count;
INTEGER criminal_last_date;
BOOLEAN dobpop;
INTEGER estimated_income;
REAL f_add_curr_nhood_bus_pct_i;
REAL f_add_curr_nhood_mfd_pct_i;
REAL f_add_curr_nhood_sfd_pct_d;
REAL f_add_curr_nhood_vac_pct_i;
REAL f_add_input_nhood_bus_pct_i;
INTEGER f_addrchangecrimediff_i;
INTEGER f_addrchangeincomediff_d;
INTEGER f_addrchangeincomediff_d_1;
INTEGER f_addrchangevaluediff_d;
INTEGER f_addrs_per_ssn_c6_i;
INTEGER f_addrs_per_ssn_i;
INTEGER f_attr_arrest_recency_d;
INTEGER f_attr_arrests_i;
INTEGER f_componentcharrisktype_i;
INTEGER f_corrphonelastnamecount_d;
INTEGER f_corrrisktype_i;
INTEGER f_crim_rel_under25miles_cnt_i;
INTEGER f_crim_rel_under500miles_cnt_i;
INTEGER f_curraddractivephonelist_d;
INTEGER f_curraddrcartheftindex_i;
INTEGER f_curraddrcrimeindex_i;
INTEGER f_curraddrmedianincome_d;
INTEGER f_curraddrmedianvalue_d;
INTEGER f_curraddrmurderindex_i;
INTEGER f_divssnidmsrcurelcount_i;
INTEGER f_fp_prevaddrcrimeindex_i;
INTEGER f_hh_age_18_plus_d;
INTEGER f_hh_collections_ct_i;
INTEGER f_hh_lienholders_i;
INTEGER f_hh_members_ct_d;
INTEGER f_hh_tot_derog_i;
INTEGER f_historical_count_d;
INTEGER f_idverrisktype_i;
INTEGER f_inq_collection_count24_i;
INTEGER f_inq_count24_i;
INTEGER f_inq_highriskcredit_count24_i;
INTEGER f_inq_quizprovider_count24_i;
INTEGER f_m_bureau_adl_fs_notu_d;
INTEGER f_phone_ver_insurance_d;
INTEGER f_phones_per_addr_c6_i;
INTEGER f_phones_per_addr_curr_i;
INTEGER f_prevaddrageoldest_d;
INTEGER f_prevaddrlenofres_d;
INTEGER f_rel_ageover20_count_d;
INTEGER f_rel_count_i;
INTEGER f_rel_educationover12_count_d;
INTEGER f_rel_educationover8_count_d;
INTEGER f_rel_homeover150_count_d;
INTEGER f_rel_homeover200_count_d;
INTEGER f_rel_homeover50_count_d;
INTEGER f_rel_incomeover50_count_d;
INTEGER f_rel_under100miles_cnt_d;
INTEGER f_sourcerisktype_i;
INTEGER f_srchunvrfdphonecount_i;
INTEGER f_util_add_curr_inf_n;
INTEGER f_util_adl_count_n;
INTEGER f_vardobcountnew_i;
INTEGER f_varrisktype_i;
INTEGER felony_count;
INTEGER felony_last_date;
REAL final_score;
REAL final_score_0;
REAL final_score_1;
REAL final_score_1_c106;
REAL final_score_1_c107;
REAL final_score_10;
REAL final_score_10_c133;
REAL final_score_10_c134;
REAL final_score_100;
REAL final_score_100_c403;
REAL final_score_100_c404;
REAL final_score_101;
REAL final_score_101_c406;
REAL final_score_101_c407;
REAL final_score_102;
REAL final_score_102_c409;
REAL final_score_102_c410;
REAL final_score_103;
REAL final_score_103_c412;
REAL final_score_103_c413;
REAL final_score_104;
REAL final_score_104_c415;
REAL final_score_104_c416;
REAL final_score_105;
REAL final_score_105_c418;
REAL final_score_105_c419;
REAL final_score_106;
REAL final_score_106_c421;
REAL final_score_106_c422;
REAL final_score_107;
REAL final_score_107_c424;
REAL final_score_107_c425;
REAL final_score_108;
REAL final_score_108_c427;
REAL final_score_108_c428;
REAL final_score_109;
REAL final_score_109_c430;
REAL final_score_109_c431;
REAL final_score_11;
REAL final_score_11_c136;
REAL final_score_11_c137;
REAL final_score_110;
REAL final_score_110_c433;
REAL final_score_110_c434;
REAL final_score_111;
REAL final_score_111_c436;
REAL final_score_111_c437;
REAL final_score_112;
REAL final_score_112_c439;
REAL final_score_112_c440;
REAL final_score_113;
REAL final_score_113_c442;
REAL final_score_113_c443;
REAL final_score_114;
REAL final_score_114_c445;
REAL final_score_114_c446;
REAL final_score_115;
REAL final_score_115_c448;
REAL final_score_115_c449;
REAL final_score_116;
REAL final_score_116_c451;
REAL final_score_116_c452;
REAL final_score_117;
REAL final_score_117_c454;
REAL final_score_117_c455;
REAL final_score_118;
REAL final_score_118_c457;
REAL final_score_118_c458;
REAL final_score_119;
REAL final_score_119_c460;
REAL final_score_119_c461;
REAL final_score_12;
REAL final_score_12_c139;
REAL final_score_12_c140;
REAL final_score_120;
REAL final_score_120_c463;
REAL final_score_120_c464;
REAL final_score_121;
REAL final_score_121_c466;
REAL final_score_121_c467;
REAL final_score_122;
REAL final_score_122_c469;
REAL final_score_122_c470;
REAL final_score_123;
REAL final_score_123_c472;
REAL final_score_123_c473;
REAL final_score_124;
REAL final_score_124_c475;
REAL final_score_124_c476;
REAL final_score_125;
REAL final_score_125_c478;
REAL final_score_125_c479;
REAL final_score_126;
REAL final_score_126_c481;
REAL final_score_126_c482;
REAL final_score_127;
REAL final_score_127_c484;
REAL final_score_127_c485;
REAL final_score_128;
REAL final_score_128_c487;
REAL final_score_128_c488;
REAL final_score_129;
REAL final_score_129_c490;
REAL final_score_129_c491;
REAL final_score_13;
REAL final_score_13_c142;
REAL final_score_13_c143;
REAL final_score_130;
REAL final_score_130_c493;
REAL final_score_130_c494;
REAL final_score_131;
REAL final_score_131_c496;
REAL final_score_131_c497;
REAL final_score_132;
REAL final_score_132_c499;
REAL final_score_132_c500;
REAL final_score_14;
REAL final_score_14_c145;
REAL final_score_14_c146;
REAL final_score_15;
REAL final_score_15_c148;
REAL final_score_15_c149;
REAL final_score_16;
REAL final_score_16_c151;
REAL final_score_16_c152;
REAL final_score_17;
REAL final_score_17_c154;
REAL final_score_17_c155;
REAL final_score_18;
REAL final_score_18_c157;
REAL final_score_18_c158;
REAL final_score_19;
REAL final_score_19_c160;
REAL final_score_19_c161;
REAL final_score_2;
REAL final_score_2_c109;
REAL final_score_2_c110;
REAL final_score_20;
REAL final_score_20_c163;
REAL final_score_20_c164;
REAL final_score_21;
REAL final_score_21_c166;
REAL final_score_21_c167;
REAL final_score_22;
REAL final_score_22_c169;
REAL final_score_22_c170;
REAL final_score_23;
REAL final_score_23_c172;
REAL final_score_23_c173;
REAL final_score_24;
REAL final_score_24_c175;
REAL final_score_24_c176;
REAL final_score_25;
REAL final_score_25_c178;
REAL final_score_25_c179;
REAL final_score_26;
REAL final_score_26_c181;
REAL final_score_26_c182;
REAL final_score_27;
REAL final_score_27_c184;
REAL final_score_27_c185;
REAL final_score_28;
REAL final_score_28_c187;
REAL final_score_28_c188;
REAL final_score_29;
REAL final_score_29_c190;
REAL final_score_29_c191;
REAL final_score_3;
REAL final_score_3_c112;
REAL final_score_3_c113;
REAL final_score_30;
REAL final_score_30_c193;
REAL final_score_30_c194;
REAL final_score_31;
REAL final_score_31_c196;
REAL final_score_31_c197;
REAL final_score_32;
REAL final_score_32_c199;
REAL final_score_32_c200;
REAL final_score_33;
REAL final_score_33_c202;
REAL final_score_33_c203;
REAL final_score_34;
REAL final_score_34_c205;
REAL final_score_34_c206;
REAL final_score_35;
REAL final_score_35_c208;
REAL final_score_35_c209;
REAL final_score_36;
REAL final_score_36_c211;
REAL final_score_36_c212;
REAL final_score_37;
REAL final_score_37_c214;
REAL final_score_37_c215;
REAL final_score_38;
REAL final_score_38_c217;
REAL final_score_38_c218;
REAL final_score_39;
REAL final_score_39_c220;
REAL final_score_39_c221;
REAL final_score_4;
REAL final_score_4_c115;
REAL final_score_4_c116;
REAL final_score_40;
REAL final_score_40_c223;
REAL final_score_40_c224;
REAL final_score_41;
REAL final_score_41_c226;
REAL final_score_41_c227;
REAL final_score_42;
REAL final_score_42_c229;
REAL final_score_42_c230;
REAL final_score_43;
REAL final_score_43_c232;
REAL final_score_43_c233;
REAL final_score_44;
REAL final_score_44_c235;
REAL final_score_44_c236;
REAL final_score_45;
REAL final_score_45_c238;
REAL final_score_45_c239;
REAL final_score_46;
REAL final_score_46_c241;
REAL final_score_46_c242;
REAL final_score_47;
REAL final_score_47_c244;
REAL final_score_47_c245;
REAL final_score_48;
REAL final_score_48_c247;
REAL final_score_48_c248;
REAL final_score_49;
REAL final_score_49_c250;
REAL final_score_49_c251;
REAL final_score_5;
REAL final_score_5_c118;
REAL final_score_5_c119;
REAL final_score_50;
REAL final_score_50_c253;
REAL final_score_50_c254;
REAL final_score_51;
REAL final_score_51_c256;
REAL final_score_51_c257;
REAL final_score_52;
REAL final_score_52_c259;
REAL final_score_52_c260;
REAL final_score_53;
REAL final_score_53_c262;
REAL final_score_53_c263;
REAL final_score_54;
REAL final_score_54_c265;
REAL final_score_54_c266;
REAL final_score_55;
REAL final_score_55_c268;
REAL final_score_55_c269;
REAL final_score_56;
REAL final_score_56_c271;
REAL final_score_56_c272;
REAL final_score_57;
REAL final_score_57_c274;
REAL final_score_57_c275;
REAL final_score_58;
REAL final_score_58_c277;
REAL final_score_58_c278;
REAL final_score_59;
REAL final_score_59_c280;
REAL final_score_59_c281;
REAL final_score_6;
REAL final_score_6_c121;
REAL final_score_6_c122;
REAL final_score_60;
REAL final_score_60_c283;
REAL final_score_60_c284;
REAL final_score_61;
REAL final_score_61_c286;
REAL final_score_61_c287;
REAL final_score_62;
REAL final_score_62_c289;
REAL final_score_62_c290;
REAL final_score_63;
REAL final_score_63_c292;
REAL final_score_63_c293;
REAL final_score_64;
REAL final_score_64_c295;
REAL final_score_64_c296;
REAL final_score_65;
REAL final_score_65_c298;
REAL final_score_65_c299;
REAL final_score_66;
REAL final_score_66_c301;
REAL final_score_66_c302;
REAL final_score_67;
REAL final_score_67_c304;
REAL final_score_67_c305;
REAL final_score_68;
REAL final_score_68_c307;
REAL final_score_68_c308;
REAL final_score_69;
REAL final_score_69_c310;
REAL final_score_69_c311;
REAL final_score_7;
REAL final_score_7_c124;
REAL final_score_7_c125;
REAL final_score_70;
REAL final_score_70_c313;
REAL final_score_70_c314;
REAL final_score_71;
REAL final_score_71_c316;
REAL final_score_71_c317;
REAL final_score_72;
REAL final_score_72_c319;
REAL final_score_72_c320;
REAL final_score_73;
REAL final_score_73_c322;
REAL final_score_73_c323;
REAL final_score_74;
REAL final_score_74_c325;
REAL final_score_74_c326;
REAL final_score_75;
REAL final_score_75_c328;
REAL final_score_75_c329;
REAL final_score_76;
REAL final_score_76_c331;
REAL final_score_76_c332;
REAL final_score_77;
REAL final_score_77_c334;
REAL final_score_77_c335;
REAL final_score_78;
REAL final_score_78_c337;
REAL final_score_78_c338;
REAL final_score_79;
REAL final_score_79_c340;
REAL final_score_79_c341;
REAL final_score_8;
REAL final_score_8_c127;
REAL final_score_8_c128;
REAL final_score_80;
REAL final_score_80_c343;
REAL final_score_80_c344;
REAL final_score_81;
REAL final_score_81_c346;
REAL final_score_81_c347;
REAL final_score_82;
REAL final_score_82_c349;
REAL final_score_82_c350;
REAL final_score_83;
REAL final_score_83_c352;
REAL final_score_83_c353;
REAL final_score_84;
REAL final_score_84_c355;
REAL final_score_84_c356;
REAL final_score_85;
REAL final_score_85_c358;
REAL final_score_85_c359;
REAL final_score_86;
REAL final_score_86_c361;
REAL final_score_86_c362;
REAL final_score_87;
REAL final_score_87_c364;
REAL final_score_87_c365;
REAL final_score_88;
REAL final_score_88_c367;
REAL final_score_88_c368;
REAL final_score_89;
REAL final_score_89_c370;
REAL final_score_89_c371;
REAL final_score_9;
REAL final_score_9_c130;
REAL final_score_9_c131;
REAL final_score_90;
REAL final_score_90_c373;
REAL final_score_90_c374;
REAL final_score_91;
REAL final_score_91_c376;
REAL final_score_91_c377;
REAL final_score_92;
REAL final_score_92_c379;
REAL final_score_92_c380;
REAL final_score_93;
REAL final_score_93_c382;
REAL final_score_93_c383;
REAL final_score_94;
REAL final_score_94_c385;
REAL final_score_94_c386;
REAL final_score_95;
REAL final_score_95_c388;
REAL final_score_95_c389;
REAL final_score_96;
REAL final_score_96_c391;
REAL final_score_96_c392;
REAL final_score_97;
REAL final_score_97_c394;
REAL final_score_97_c395;
REAL final_score_98;
REAL final_score_98_c397;
REAL final_score_98_c398;
REAL final_score_99;
REAL final_score_99_c400;
REAL final_score_99_c401;
BOOLEAN fnamepop;
STRING fp_addrchangecrimediff;
STRING fp_addrchangeincomediff;
STRING fp_addrchangevaluediff;
STRING fp_componentcharrisktype;
STRING fp_corrphonelastnamecount;
STRING fp_corrrisktype;
STRING fp_curraddractivephonelist;
STRING fp_curraddrcartheftindex;
STRING fp_curraddrcrimeindex;
STRING fp_curraddrmedianincome;
STRING fp_curraddrmedianvalue;
STRING fp_curraddrmurderindex;
STRING fp_divssnidmsrcurelcount;
STRING fp_idverrisktype;
STRING fp_prevaddrageoldest;
STRING fp_prevaddrcrimeindex;
STRING fp_prevaddrlenofres;
STRING fp_sourcerisktype;
STRING fp_srchaddrsrchcountmo;
STRING fp_srchfraudsrchcountyr;
STRING fp_srchphonesrchcountmo;
STRING fp_srchssnsrchcountmo;
STRING fp_srchunvrfdphonecount;
STRING fp_vardobcountnew;
STRING fp_varrisktype;
INTEGER fp1512_1_0;
INTEGER hh_age_18_to_30;
INTEGER hh_age_30_to_65;
INTEGER hh_age_65_plus;
INTEGER hh_collections_ct;
INTEGER hh_criminals;
INTEGER hh_lienholders;
INTEGER hh_members_ct;
INTEGER hh_members_w_derog;
INTEGER hh_payday_loan_users;
INTEGER hh_tot_derog;
INTEGER historical_count;
BOOLEAN hphnpop;
STRING in_dob;
INTEGER inferred_age;
INTEGER infutor_nap;
STRING inputssncharflag;
INTEGER inq_addrsperssn;
INTEGER inq_collection_count;
INTEGER inq_collection_count01;
INTEGER inq_collection_count03;
INTEGER inq_collection_count06;
INTEGER inq_collection_count12;
INTEGER inq_collection_count24;
INTEGER inq_count03;
INTEGER inq_count12;
INTEGER inq_count24;
INTEGER inq_highriskcredit_count;
INTEGER inq_highriskcredit_count01;
INTEGER inq_highriskcredit_count03;
INTEGER inq_highriskcredit_count06;
INTEGER inq_highriskcredit_count12;
INTEGER inq_highriskcredit_count24;
INTEGER inq_perssn;
INTEGER inq_quizprovider_count24;
INTEGER invalid_ssns_per_adl;
INTEGER invalid_ssns_per_adl_c6;
INTEGER k_comb_age_d;
INTEGER k_estimated_income_d;
BOOLEAN k_inf_nothing_found_i;
INTEGER k_inq_addrs_per_ssn_i;
INTEGER k_inq_per_ssn_i;
REAL lgt;
BOOLEAN lnamepop;
INTEGER lnames_per_adl_c6;
INTEGER max_lres;
INTEGER nap_summary;
STRING nap_type;
INTEGER nas_summary;
STRING nf_seg_fraudpoint_3_0;
REAL offset;
STRING pb_average_days_bt_orders;
STRING pb_average_dollars;
STRING pb_number_of_sources;
REAL pbr;
STRING phone_ver_insurance;
INTEGER phones_per_addr_c6;
INTEGER phones_per_addr_curr;
INTEGER pts;
REAL r_a49_curr_avm_chg_1yr_pct_i;
INTEGER r_a50_pb_average_dollars_d;
INTEGER r_c12_num_nonderogs_d;
INTEGER r_c13_curr_addr_lres_d;
INTEGER r_c13_max_lres_d;
INTEGER r_c14_addrs_15yr_i;
INTEGER r_c14_addrs_5yr_i;
INTEGER r_c14_addrs_per_adl_c6_i;
INTEGER r_c23_inp_addr_occ_index_d;
INTEGER r_c23_inp_addr_owned_not_occ_d;
INTEGER r_d30_derog_count_i;
INTEGER r_d32_criminal_count_i;
INTEGER r_d32_felony_count_i;
INTEGER r_d32_mos_since_crim_ls_d;
INTEGER r_d32_mos_since_fel_ls_d;
INTEGER r_d33_eviction_count_i;
INTEGER r_d33_eviction_recency_d;
INTEGER r_f00_addr_not_ver_w_ssn_i;
INTEGER r_f01_inp_addr_address_score_d;
INTEGER r_f03_input_add_not_most_rec_i;
INTEGER r_f04_curr_add_occ_index_d;
INTEGER r_i60_inq_count12_i;
INTEGER r_i60_inq_hiriskcred_count12_i;
INTEGER r_i60_inq_hiriskcred_recency_d;
INTEGER r_i61_inq_collection_count12_i;
INTEGER r_i61_inq_collection_recency_d;
INTEGER r_l79_adls_per_addr_c6_i;
INTEGER r_l79_adls_per_addr_curr_i;
INTEGER r_l80_inp_avm_autoval_d;
INTEGER r_p88_phn_dst_to_inp_add_i;
INTEGER r_pb_order_freq_d;
INTEGER r_s65_ssn_problem_i;
INTEGER r_s66_adlperssn_count_i;
BOOLEAN rc_addrmiskeyflag;
STRING rc_decsflag;
INTEGER rc_disthphoneaddr;
BOOLEAN rc_input_addr_not_most_recent;
STRING rc_pwssndobflag;
STRING rc_pwssnvalflag;
STRING rc_ssndobflag;
INTEGER rc_ssndod;
BOOLEAN rc_ssnmiskeyflag;
STRING rc_ssnvalflag;
INTEGER rel_ageover70_count;
INTEGER rel_ageunder30_count;
INTEGER rel_ageunder40_count;
INTEGER rel_ageunder50_count;
INTEGER rel_ageunder60_count;
INTEGER rel_ageunder70_count;
INTEGER rel_count;
INTEGER rel_educationover12_count;
INTEGER rel_educationunder12_count;
INTEGER rel_felony_count;
INTEGER rel_homeover500_count;
INTEGER rel_homeunder100_count;
INTEGER rel_homeunder150_count;
INTEGER rel_homeunder200_count;
INTEGER rel_homeunder300_count;
INTEGER rel_homeunder500_count;
INTEGER rel_incomeover100_count;
INTEGER rel_incomeunder100_count;
INTEGER rel_incomeunder75_count;
INTEGER rel_within100miles_count;
INTEGER rel_within25miles_count;
REAL sbr;
STRING ssnlength;
INTEGER ssns_per_adl;
INTEGER ssns_per_adl_c6;
INTEGER stl_inq_count;
INTEGER sysdate;
BOOLEAN truedid;
STRING util_add_curr_type_list;
INTEGER util_adl_count;
STRING ver_sources;
STRING ver_sources_first_seen;
REAL yr_in_dob;
REAL yr_in_dob_int;

STRING	StolenIdentityIndex;
STRING	SyntheticIdentityIndex;
STRING	ManipulatedIdentityIndex;
STRING	VulnerableVictimIndex;
STRING	FriendlyFraudIndex;
STRING	SuspiciousActivityIndex;
	
			Risk_Indicators.Layout_Boca_Shell clam;
			models.layout_modelout;
		END;
		
    layout_debug doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_nhood_bus_ct           := le.addr_risk_summary.N_Business_Count;
	add_input_nhood_sfd_ct           := le.addr_risk_summary.N_SFD_Count;
	add_input_nhood_mfd_ct           := le.addr_risk_summary.N_MFD_Count;
	add_input_pop                    := le.addrPop;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_nhood_vac_prop          := le.addr_risk_summary2.N_Vacant_Properties;
	add_curr_nhood_bus_ct            := le.addr_risk_summary2.N_Business_Count;
	add_curr_nhood_sfd_ct            := le.addr_risk_summary2.N_SFD_Count;
	add_curr_nhood_mfd_ct            := le.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.addrPop2;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;																										 
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	addrs_per_ssn_c6                 := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn_created_6months);
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	phones_per_addr_c6               := if(isFCRA, 0, le.velocity_counters.phones_per_addr_created_6months);
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_quizprovider_count24         := le.acc_logs.quizprovider.count24;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests                     := le.bjl.arrests_count;
	attr_arrests30                   := le.bjl.arrests_count30;
	attr_arrests90                   := le.bjl.arrests_count90;
	attr_arrests180                  := le.bjl.arrests_count180;
	attr_arrests12                   := le.bjl.arrests_count12;
	attr_arrests24                   := le.bjl.arrests_count24;
	attr_arrests36                   := le.bjl.arrests_count36;
	attr_arrests60                   := le.bjl.arrests_count60;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_vardobcountnew                := le.fdattributesv2.variationdobcountnew;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
	fp_corrphonelastnamecount        := le.fdattributesv2.correlationphonelastnamecount;
	fp_divssnidmsrcurelcount         := le.fdattributesv2.divssnidentitymsourceurelcount;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
	fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
	fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_age_65_plus                   := le.hhid_summary.hh_age_65_plus;
	hh_age_30_to_65                  := le.hhid_summary.hh_age_31_to_65;
	hh_age_18_to_30                  := le.hhid_summary.hh_age_18_to_30;
	hh_collections_ct                := le.hhid_summary.hh_collections_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_tot_derog                     := le.hhid_summary.hh_tot_derog;
	hh_lienholders                   := le.hhid_summary.hh_lienholders;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_count                        := le.relatives.relative_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.relatives.relative_educationover12_count;
	rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	historical_count                 := le.vehicles.historical_count;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;
	
	C_INC_100K_P                     := (STRING)rt.in100k_p;
	C_INC_125K_P                     := (STRING)rt.in125k_p;
	C_INC_15K_P                      := (STRING)rt.in15k_p;
	C_INC_25K_P                      := (STRING)rt.in25k_p;
	C_INC_50K_P                      := (STRING)rt.in50k_p;
	C_RENTOCC_P                      := (STRING)rt.rentocp;
	c_ab_av_edu                      := (STRING)rt.ab_av_edu;
	c_amus_indx                      := (STRING)rt.amus_indx;
	c_asian_lang                     := (STRING)rt.asian_lang;
	c_bel_edu                        := (STRING)rt.bel_edu;
	c_blue_col                       := (STRING)rt.blue_col;
	c_blue_empl                      := (STRING)rt.blue_empl;
	c_born_usa                       := (STRING)rt.born_usa;
	c_cartheft                       := (STRING)rt.cartheft;
	c_civ_emp                        := (STRING)rt.civ_emp;
	c_construction                   := (STRING)rt.construction;
	c_easiqlife                      := (STRING)rt.easiqlife;
	c_families                       := (STRING)rt.families;
	c_femdiv_p                       := (STRING)rt.femdiv_p;
	c_food                           := (STRING)rt.food;
	c_health                         := (STRING)rt.health;
	c_hh1_p                          := (STRING)rt.hh1_p;
	c_hh2_p                          := (STRING)rt.hh2_p;
	c_hh4_p                          := (STRING)rt.hh4_p;
	c_hh5_p                          := (STRING)rt.hh5_p;
	c_high_ed                        := (STRING)rt.high_ed;
	c_highinc                        := (STRING)rt.highinc;
	c_hval_100k_p                    := (STRING)rt.hval_100k_p;
	c_hval_150k_p                    := (STRING)rt.hval_150k_p;
	c_hval_250k_p                    := (STRING)rt.hval_250k_p;
	c_hval_60k_p                     := (STRING)rt.hval_60k_p;
	c_hval_80k_p                     := (STRING)rt.hval_80k_p;
	c_larceny                        := (STRING)rt.larceny;
	c_lowrent                        := (STRING)rt.lowrent;
	c_many_cars                      := (STRING)rt.many_cars;
	c_med_age                        := (STRING)rt.med_age;
	c_med_rent                       := (STRING)rt.med_rent;
	c_med_yearblt                    := (STRING)rt.med_yearblt;
	c_medi_indx                      := (STRING)rt.medi_indx;
	c_mort_indx                      := (STRING)rt.mort_indx;
	c_no_car                         := (STRING)rt.no_car;
	c_no_labfor                      := (STRING)rt.no_labfor;
	c_no_move                        := (STRING)rt.no_move;
	c_occunit_p                      := (STRING)rt.occunit_p;
	c_old_homes                      := (STRING)rt.old_homes;
	c_pop_0_5_p                      := (STRING)rt.pop_0_5_p;
	c_pop_55_64_p                    := (STRING)rt.pop_55_64_p;
	c_pop_75_84_p                    := (STRING)rt.pop_75_84_p;
	c_popover18                      := (STRING)rt.popover18;
	c_preschl                        := (STRING)rt.preschl;
	c_professional                   := (STRING)rt.professional;
	c_relig_indx                     := (STRING)rt.relig_indx;
	c_rental                         := (STRING)rt.rental;
	c_retired                        := (STRING)rt.retired;
	c_rnt750_p                       := (STRING)rt.rnt750_p;
	c_serv_empl                      := (STRING)rt.serv_empl;
	c_span_lang                      := (STRING)rt.span_lang;
	c_totcrime                       := (STRING)rt.totcrime;
	c_trailer                        := (STRING)rt.trailer;
	c_trailer_p                      := (STRING)rt.trailer_p;
	c_unattach                       := (STRING)rt.unattach;
	c_unemp                          := (STRING)rt.unemp;
	c_very_rich                      := (STRING)rt.very_rich;
	c_white_col                      := (STRING)rt.white_col;
	c_young                          := (STRING)rt.young;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));
	// sysdate := common.sas_date('20150501');
	
	k_inf_nothing_found_i := (infutor_nap in [0]);
	
	r_f00_addr_not_ver_w_ssn_i := if(not(truedid and (integer)ssnlength > 0), NULL, (integer)(nas_summary in [4, 7, 9]));
	
	r_s65_ssn_problem_i := map(
	    not(ssnlength > '0')                                                                                                                                                                                                                                                					=> NULL,
	    dobpop and (rc_ssndobflag = '1' or rc_pwssndobflag = '1') or truedid and (string)invalid_ssns_per_adl >= '2' or truedid and (integer)invalid_ssns_per_adl_c6 >= 1                                                                                                             => 2,
	    rc_decsflag = '1' or contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 or rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) or truedid and invalid_ssns_per_adl >= 1                          				=> 1,
	    rc_decsflag = '0' or dobpop and (rc_ssndobflag = '0' or rc_pwssndobflag = '0') or rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) or truedid and invalid_ssns_per_adl = 0 or truedid and invalid_ssns_per_adl_c6 = 0 		=> 0,
																																																																																																																																										NULL);
	
	r_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);
	
	r_f03_input_add_not_most_rec_i := if(not(truedid and add_input_pop), NULL, (integer)rc_input_addr_not_most_recent);
	
	r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));
	
	r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));
	
	r_d32_felony_count_i := if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999));
	
	_criminal_last_date := Common.SAS_Date((STRING)(criminal_last_date));
	
	r_d32_mos_since_crim_ls_d := map(
	    not(truedid)               => NULL,
	    _criminal_last_date = NULL => 241,
	                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));
	
	_felony_last_date := Common.SAS_Date((STRING)(felony_last_date));
	
	r_d32_mos_since_fel_ls_d := map(
	    not(truedid)             => NULL,
	    _felony_last_date = NULL => 241,
	                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));
	
	r_d33_eviction_recency_d := map(
	    not(truedid)             						=> NULL,
	    (boolean)attr_eviction_count90    	=> 3,
	    (boolean)attr_eviction_count180   	=> 6,
	    (boolean)attr_eviction_count12    	=> 12,
	    (boolean)attr_eviction_count24    	=> 24,
	    (boolean)attr_eviction_count36    	=> 36,
	    (boolean)attr_eviction_count60    	=> 60,
	    (integer)attr_eviction_count >= 1 	=> 99,
																				     999);
	
	r_d33_eviction_count_i := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));
	
	bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');
	
	bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));
	
	_bureau_adl_fseen_eq := Common.SAS_Date((STRING)(bureau_adl_fseen_eq));
	
	bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E');
	
	bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));
	
	_bureau_adl_fseen_en := Common.SAS_Date((STRING)(bureau_adl_fseen_en));
	
	bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E');
	
	bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));
	
	_bureau_adl_fseen_ts := Common.SAS_Date((STRING)(bureau_adl_fseen_ts));
	
	bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E');
	
	bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));
	
	_bureau_adl_fseen_tu := Common.SAS_Date((STRING)(bureau_adl_fseen_tu));
	
	bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E');
	
	bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));
	
	_bureau_adl_fseen_tn := Common.SAS_Date((STRING)(bureau_adl_fseen_tn));
	
	_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);
	
	f_m_bureau_adl_fs_notu_d := map(
	    not(truedid)                        => NULL,
	    _src_bureau_adl_fseen_notu = 999999 => 1000,
	                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999));
	
	r_c12_num_nonderogs_d := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999));
	
	r_s66_adlperssn_count_i := map(
	    not((integer)ssnlength > 0) => NULL,
	    adls_per_ssn = 0   					=> 1,
																		 min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));
	
	_in_dob := Common.SAS_Date((STRING)(in_dob));
	
	yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);
	
	yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));
	
	k_comb_age_d := map(
	    yr_in_dob_int > 0            => yr_in_dob_int,
	    inferred_age > 0 and truedid => inferred_age,
	                                    NULL);
	
	r_l80_inp_avm_autoval_d := map(
	    not(add_input_pop)         => NULL,
	    add_input_avm_auto_val = 0 => NULL,
	                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));
	
	r_a49_curr_avm_chg_1yr_pct_i := map(
	    not(add_curr_pop)                                         => NULL,
	    add_curr_lres < 12                                        => NULL,
	    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
	                                                                 NULL);
	
	    // if not add_curr_pop                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
        // then r_A49_Curr_AVM_Chg_1yr_Pct_i = .;                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    // else if add_curr_lres < 12 * 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
        // then r_A49_Curr_AVM_Chg_1yr_Pct_i = .;                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    // else if add_curr_avm_auto_val   > 0 and                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
        // add_curr_avm_auto_val_2 > 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
        // then r_A49_Curr_AVM_Chg_1yr_Pct_i =                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
        // round(100*(add_curr_avm_auto_val / add_curr_avm_auto_val_2), 0.1);                                                                                                                                                                                                                                                                                                                                                                                                                                          
    // else r_A49_Curr_AVM_Chg_1yr_Pct_i = .;    
	
	
	r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));
	
	r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));
	
	r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));
	
	r_c14_addrs_per_adl_c6_i := if(not(truedid), NULL, min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 999));
	
	r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));
	
	r_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));
	
	r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));
	
	r_a50_pb_average_dollars_d := map(
	    not(truedid)              					=> NULL,
	    pb_average_dollars = '' 						=> 5000,
																						 min(if((integer)pb_average_dollars = NULL, -NULL, (integer)pb_average_dollars), 5000));
	
	r_pb_order_freq_d := map(
	    not(truedid)                     					=> NULL,
	    pb_number_of_sources = ''      						=> NULL,
	    pb_average_days_bt_orders = '' 						=> -1,
																								min(if((integer)pb_average_days_bt_orders = NULL, -NULL, (integer)pb_average_days_bt_orders), 999));
	
	r_i60_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));
	
	r_i61_inq_collection_count12_i := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));
	
	r_i61_inq_collection_recency_d := map(
	    not(truedid)           					=> NULL,
	    (boolean)inq_collection_count01 => 1,
	    (boolean)inq_collection_count03 => 3,
	    (boolean)inq_collection_count06 => 6,
	    (boolean)inq_collection_count12 => 12,
	    (boolean)inq_collection_count24 => 24,
	    (boolean)inq_collection_count   => 99,
																				 999);
	
	r_i60_inq_hiriskcred_count12_i := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));
	
	r_i60_inq_hiriskcred_recency_d := map(
	    not(truedid)               					=> NULL,
	    (boolean)inq_highRiskCredit_count01 => 1,
	    (boolean)inq_highRiskCredit_count03 => 3,
	    (boolean)inq_highRiskCredit_count06 => 6,
	    (boolean)inq_highRiskCredit_count12 => 12,
	    (boolean)inq_highRiskCredit_count24 => 24,
	    (boolean)inq_highRiskCredit_count   => 99,
																						 999);
	
	f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);
	
	f_util_add_curr_inf_n := if(contains_i(util_add_curr_type_list, '1') > 0, 1, 0);
	
	add_input_nhood_prop_sum := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));
	
	f_add_input_nhood_bus_pct_i := map(
	    not(addrpop)               => NULL,
	    add_input_nhood_BUS_ct = 0 => NULL,
	                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum);
	
	add_curr_nhood_prop_sum_3 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	f_add_curr_nhood_bus_pct_i := map(
	    not(add_curr_pop)         => NULL,
	    add_curr_nhood_BUS_ct = 0 => NULL,
	                                 add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum_3);
	
	add_curr_nhood_prop_sum_2 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	f_add_curr_nhood_mfd_pct_i := map(
	    not(add_curr_pop)         => NULL,
	    add_curr_nhood_MFD_ct = 0 => NULL,
	                                 add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_2);
	
	add_curr_nhood_prop_sum_1 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	f_add_curr_nhood_sfd_pct_d := map(
	    not(add_curr_pop)         => NULL,
	    add_curr_nhood_SFD_ct = 0 => -1,
	                                 add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_1);
	
	add_curr_nhood_prop_sum := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	f_add_curr_nhood_vac_pct_i := map(
	    not(add_curr_pop)           => NULL,
	    add_curr_nhood_prop_sum = 0 => -1,
	                                   add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum);
	
	f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));
	
	f_inq_collection_count24_i := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999));
	
	f_inq_highriskcredit_count24_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));
	
	k_inq_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));
	
	k_inq_addrs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999));
	
	f_attr_arrests_i := if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999));
	
	f_attr_arrest_recency_d := map(
	    not(truedid)        => NULL,
	    attr_arrests30 > 0  => 1,
	    attr_arrests90 > 0  => 3,
	    attr_arrests180 > 0 => 6,
	    attr_arrests12 > 0  => 12,
	    attr_arrests24 > 0  => 24,
	    attr_arrests36 > 0  => 36,
	    attr_arrests60 > 0  => 60,
	    attr_arrests > 0    => 99,
	                           100);
	
	k_estimated_income_d := if(not(truedid), NULL, estimated_income);
	
	f_rel_count_i := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));
	
	f_rel_incomeover50_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count))));
	
	f_rel_homeover50_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));
	
	f_rel_homeover150_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));
	
	f_rel_homeover200_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));
	
	f_rel_ageover20_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));
	
	f_rel_educationover8_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_educationunder12_count, rel_educationover12_count) = NULL, NULL, sum(if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count), if(rel_educationover12_count = NULL, 0, rel_educationover12_count))));
	
	f_rel_educationover12_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     rel_educationover12_count);
	
	f_crim_rel_under25miles_cnt_i := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     crim_rel_within25miles);
	
	f_crim_rel_under500miles_cnt_i := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(crim_rel_within25miles, crim_rel_within100miles, crim_rel_within500miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles), if(crim_rel_within500miles = NULL, 0, crim_rel_within500miles))));
	
	f_rel_under100miles_cnt_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count))));
	
	f_historical_count_d := if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999));
	
	f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype);
	
	f_sourcerisktype_i := map(
	    not(truedid)             		=> NULL,
	    fp_sourcerisktype = ''	 		=> NULL,
																		 (integer)fp_sourcerisktype);
	
	f_varrisktype_i := map(
	    not(truedid)          		=> NULL,
	    fp_varrisktype = ''		 		=> NULL,
																	 (integer)fp_varrisktype);
	
	f_vardobcountnew_i := if(not(truedid), NULL, min(if((integer)fp_vardobcountnew = NULL, -NULL, (integer)fp_vardobcountnew), 999));
	
	f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if((integer)fp_srchunvrfdphonecount = NULL, -NULL, (integer)fp_srchunvrfdphonecount), 999));
	
	f_corrrisktype_i := map(
	    not(truedid)           => NULL,
	    fp_corrrisktype = ''	 => NULL,
	                              (integer)fp_corrrisktype);
	
	f_corrphonelastnamecount_d := if(not(truedid), NULL, min(if((integer)fp_corrphonelastnamecount = NULL, -NULL, (integer)fp_corrphonelastnamecount), 999));
	
	f_divssnidmsrcurelcount_i := if(not(truedid), NULL, min(if((integer)fp_divssnidmsrcurelcount = NULL, -NULL, (integer)fp_divssnidmsrcurelcount), 999));
	
	f_componentcharrisktype_i := map(
	    not(truedid)                    => NULL,
	    fp_componentcharrisktype = '' 	=> NULL,
	                                       (integer)fp_componentcharrisktype);
	
	f_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);
	
	f_addrchangeincomediff_d := if((integer)fp_addrchangeincomediff = -1, NULL, (integer)fp_addrchangeincomediff);
	
	f_addrchangevaluediff_d := map(
	    not(truedid)                					=> NULL,
	    (integer)fp_addrchangevaluediff = -1 	=> NULL,
																							 (integer)fp_addrchangevaluediff);
	
	f_addrchangecrimediff_i := map(
	    not(truedid)                						=> NULL,
	    (integer)fp_addrchangecrimediff = -1 		=> NULL,
																								(integer)fp_addrchangecrimediff);
	
	f_curraddractivephonelist_d := map(
	    not(add_curr_pop)               						=> NULL,
	    (integer)fp_curraddractivephonelist = -1 		=> NULL,
																										 (integer)fp_curraddractivephonelist);
	
	f_curraddrmedianincome_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianincome);
	
	f_curraddrmedianvalue_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianvalue);
	
	f_curraddrmurderindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrmurderindex);
	
	f_curraddrcartheftindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrcartheftindex);
	
	f_curraddrcrimeindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrcrimeindex);
	
	f_prevaddrageoldest_d := if(not(truedid), NULL, min(if((integer)fp_prevaddrageoldest = NULL, -NULL, (integer)fp_prevaddrageoldest), 999));
	
	f_prevaddrlenofres_d := if(not(truedid), NULL, min(if((integer)fp_prevaddrlenofres = NULL, -NULL, (integer)fp_prevaddrlenofres), 999));
	
	f_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcrimeindex);
	
	r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, (integer)add_input_occ_index);
	
	r_c23_inp_addr_owned_not_occ_d := if(not(add_input_pop and truedid), NULL, (integer)add_input_owned_not_occ);
	
	r_f04_curr_add_occ_index_d := if(not(truedid and add_curr_pop), NULL, (integer)add_curr_occ_index);
	
	f_phone_ver_insurance_d := if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance);
	
	f_addrs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(addrs_per_ssn = NULL, -NULL, (integer)addrs_per_ssn), 999));
	
	f_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));
	
	f_addrs_per_ssn_c6_i := if(not((integer)ssnlength > 0), NULL, min(if(addrs_per_ssn_c6 = NULL, -NULL, (integer)addrs_per_ssn_c6), 999));
	
	f_phones_per_addr_c6_i := if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999));
	
	f_inq_quizprovider_count24_i := if(not(truedid), NULL, min(if(inq_QuizProvider_count24 = NULL, -NULL, inq_QuizProvider_count24), 999));
	
	f_hh_members_ct_d := if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999));
	
	f_hh_age_18_plus_d := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999));
	
	f_hh_collections_ct_i := if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999));
	
	f_hh_tot_derog_i := if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999));
	
	f_hh_lienholders_i := if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999));
	
	_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ', ', '') > 0;
	
	_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ', ', '') > 0;
	
	_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', '') > 0;
	
	_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ', ', '') > 0;
	
	_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ', ', '') > 0;
	
	_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ', ', '') > 0;
	
	_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));
	
	_ver_src_cnt := Models.Common.countw((string)(ver_sources), ', ');
	
	_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));
	
	_derog := felony_count > 0 OR (integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR
						attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;
	
	_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;
	
	_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';
	
	_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or add_input_house_number_match = false;
	
	_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;
	
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
	
	final_score_0 := -2.1618852109;
	
	final_score_1_c106 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 4.5 => -0.0268198388,
	    f_corrrisktype_i > 4.5                              => 0.0065242601,
	    f_corrrisktype_i = NULL                             => -0.0050862291,
	                                                           -0.0050862291);
	
	final_score_1_c107 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => 0.0030706870,
	    f_addrs_per_ssn_i > 11.5                               => 0.1423989507,
	    f_addrs_per_ssn_i = NULL                               => 0.0902798594,
	                                                              0.0902798594);
	
	final_score_1 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_1_c106,
	    f_varrisktype_i > 4.5                             => final_score_1_c107,
	    f_varrisktype_i = NULL                            => 0.0014012599,
	                                                         0.0014012599);
	
	final_score_2_c109 := map(
	    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => -0.0161524486,
	    f_srchunvrfdphonecount_i > 1.5                                      => 0.0540818342,
	    f_srchunvrfdphonecount_i = NULL                                     => -0.0123989443,
	                                                                           -0.0123989443);
	
	final_score_2_c110 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 32.5 => 0.0989130135,
	    r_d32_mos_since_crim_ls_d > 32.5                                       => 0.0122244651,
	    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0270454105,
	                                                                              0.0270454105);
	
	final_score_2 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 17.5 => final_score_2_c109,
	    f_addrs_per_ssn_i > 17.5                               => final_score_2_c110,
	    f_addrs_per_ssn_i = NULL                               => -0.0032180995,
	                                                              -0.0032180995);
	
	final_score_3_c113 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 18.5 => 0.1085044426,
	    r_d32_mos_since_crim_ls_d > 18.5                                       => 0.0072250984,
	    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0191403153,
	                                                                              0.0191403153);
	
	final_score_3_c112 := map(
	    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0188644909,
	    r_f03_input_add_not_most_rec_i > 0.5                                            => final_score_3_c113,
	    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0095923654,
	                                                                                       -0.0095923654);
	
	final_score_3 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_3_c112,
	    f_varrisktype_i > 3.5                             => 0.0501900161,
	    f_varrisktype_i = NULL                            => -0.0023702315,
	                                                         -0.0023702315);
	
	final_score_4_c116 := map(
	    c_easiqlife = ''                         	 							=> 0.0194642643,
	    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 93.5  => 0.0805963561,
	    (real)c_easiqlife > 93.5                         				=> 0.0069689597,
																																 0.0194642643);
	
	final_score_4_c115 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => -0.0144547805,
	    f_corrrisktype_i > 7.5                              => final_score_4_c116,
	    f_corrrisktype_i = NULL                             => -0.0058466770,
	                                                           -0.0058466770);
	
	final_score_4 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_4_c115,
	    f_varrisktype_i > 4.5                             => 0.0725223900,
	    f_varrisktype_i = NULL                            => -0.0003332753,
	                                                         -0.0003332753);
	
	final_score_5_c118 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 4.5 => -0.0289898328,
	    f_corrrisktype_i > 4.5                              => 0.0010406706,
	    f_corrrisktype_i = NULL                             => -0.0090428020,
	                                                           -0.0090428020);
	
	final_score_5_c119 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => 0.0097460086,
	    f_addrs_per_ssn_i > 11.5                               => 0.1088528948,
	    f_addrs_per_ssn_i = NULL                               => 0.0730353184,
	                                                              0.0730353184);
	
	final_score_5 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_5_c118,
	    f_varrisktype_i > 4.5                             => final_score_5_c119,
	    f_varrisktype_i = NULL                            => -0.0031535109,
	                                                         -0.0031535109);
	
	final_score_6_c121 := map(
	    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 5.5 => 0.0277597937,
	    f_prevaddrageoldest_d > 5.5                                   => -0.0164916184,
	    f_prevaddrageoldest_d = NULL                                  => -0.0085011185,
	                                                                     -0.0085011185);
	
	final_score_6_c122 := map(
	    NULL < r_f04_curr_add_occ_index_d AND r_f04_curr_add_occ_index_d <= 2 => 0.0148740857,
	    r_f04_curr_add_occ_index_d > 2                                        => 0.1048080973,
	    r_f04_curr_add_occ_index_d = NULL                                     => 0.0535707919,
	                                                                             0.0535707919);
	
	final_score_6 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_6_c121,
	    f_varrisktype_i > 4.5                             => final_score_6_c122,
	    f_varrisktype_i = NULL                            => -0.0045737050,
	                                                         -0.0045737050);
	
	final_score_7_c124 := map(
		  c_born_usa = ''                            						=> -0.0125094619,
	    NULL < (real)c_born_usa AND (real)c_born_usa <= 186.5 => -0.0159419945,
	    (real)c_born_usa > 186.5                        			=> 0.0566635326,
																															 -0.0125094619);
	
	final_score_7_c125 := map(
	    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 5.5 => 0.0119758704,
	    r_d30_derog_count_i > 5.5                                 => 0.0926051768,
	    r_d30_derog_count_i = NULL                                => 0.0265436775,
	                                                                 0.0265436775);
	
	final_score_7 := map(
	    NULL < r_c14_addrs_per_adl_c6_i AND r_c14_addrs_per_adl_c6_i <= 0.5 => final_score_7_c124,
	    r_c14_addrs_per_adl_c6_i > 0.5                                      => final_score_7_c125,
	    r_c14_addrs_per_adl_c6_i = NULL                                     => -0.0023306658,
	                                                                           -0.0023306658);
	
	final_score_8_c128 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 35 => 0.0629773766,
	    r_f01_inp_addr_address_score_d > 35                                            => 0.0007262899,
	    r_f01_inp_addr_address_score_d = NULL                                          => 0.0059162056,
	                                                                                      0.0059162056);
	
	final_score_8_c127 := map(
	    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_8_c128,
	    f_corrphonelastnamecount_d > 0.5                                        => -0.0238300742,
	    f_corrphonelastnamecount_d = NULL                                       => -0.0057981088,
	                                                                               -0.0057981088);

	final_score_8 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_8_c127,
	    f_varrisktype_i > 4.5                             => 0.0543808506,
	    f_varrisktype_i = NULL                            => -0.0015451788,
	                                                         -0.0015451788);

	// final_score_9_c130 := map(
	    // (nf_seg_fraudpoint_3_0 in ['4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0219177402,
	    // (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog'])          => 0.0076672677,
	    // nf_seg_fraudpoint_3_0 = ''                                                            => -0.0064938747,
	                                                                                             // -0.0064938747);

	final_score_9_c130 := map(
	    (nf_seg_fraudpoint_3_0 in ['4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) 		=> -0.0219177402,
	    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '3: Derog'])          		=> 0.0076672677,
	    nf_seg_fraudpoint_3_0 = ''                                                            		=> -0.0064938747,
																																																	 -0.0064938747);																																														 

	final_score_9_c131 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 11.5 => 0.0051300305,
	    f_addrs_per_ssn_i > 11.5                               => 0.0608872798,
	    f_addrs_per_ssn_i = NULL                               => 0.0375977292,
	                                                              0.0375977292);
	
	final_score_9 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => final_score_9_c130,
	    f_varrisktype_i > 3.5                             => final_score_9_c131,
	    f_varrisktype_i = NULL                            => -0.0011057632,
	                                                         -0.0011057632);
	
	final_score_10_c134 := map(
	    c_no_move = ''		                     							=> -0.0062067191,
	    NULL < (real)c_no_move AND (real)c_no_move <= 33.5 	=> -0.0254132261,
	    (real)c_no_move > 33.5                       				=> 0.0035319106,
																														 -0.0062067191);
	
	final_score_10_c133 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 19.5 => 0.0396385040,
	    r_d32_mos_since_crim_ls_d > 19.5                                       => final_score_10_c134,
	    r_d32_mos_since_crim_ls_d = NULL                                       => -0.0010772665,
	                                                                              -0.0010772665);
	
	final_score_10 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 8.5 => final_score_10_c133,
	    f_inq_highriskcredit_count24_i > 8.5                                            => 0.1014595402,
	    f_inq_highriskcredit_count24_i = NULL                                           => 0.0015558539,
	                                                                                       0.0015558539);
	
	final_score_11_c137 := map(
	    C_INC_50K_P = ''		                        							=> 0.0793532013,
	    NULL < (real)C_INC_50K_P AND (real)C_INC_50K_P <= 15.15 	=> 0.1308193269,
	    (real)C_INC_50K_P > 15.15                         				=> 0.0283966412,
																																	 0.0793532013);
	
	final_score_11_c136 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_11_c137,
	    k_comb_age_d > 33.5                          => 0.0028020201,
	    k_comb_age_d = NULL                          => 0.0398843668,
	                                                    0.0398843668);
	
	final_score_11 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 1.5 => -0.0065762336,
	    f_inq_highriskcredit_count24_i > 1.5                                            => final_score_11_c136,
	    f_inq_highriskcredit_count24_i = NULL                                           => -0.0016936554,
	                                                                                       -0.0016936554);
	
	final_score_12_c140 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 8.5 => -0.0128581763,
	    f_addrs_per_ssn_i > 8.5                               => 0.0265993654,
	    f_addrs_per_ssn_i = NULL                              => 0.0130615494,
	                                                             0.0130615494);
	
	final_score_12_c139 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 5.5 => -0.0184977919,
	    f_corrrisktype_i > 5.5                              => final_score_12_c140,
	    f_corrrisktype_i = NULL                             => -0.0018501980,
	                                                           -0.0018501980);
	
	final_score_12 := map(
	    NULL < r_c14_addrs_per_adl_c6_i AND r_c14_addrs_per_adl_c6_i <= 1.5 => final_score_12_c139,
	    r_c14_addrs_per_adl_c6_i > 1.5                                      => 0.0858081548,
	    r_c14_addrs_per_adl_c6_i = NULL                                     => 0.0015484390,
	                                                                           0.0015484390);
	
	final_score_13_c143 := map(
	    c_blue_col = ''	                          							=> 0.0322000769,
	    NULL < (real)c_blue_col AND (real)c_blue_col <= 19.35 	=> 0.0107919808,
	    (real)c_blue_col > 19.35                        				=> 0.1104865462,
																																 0.0322000769);
	
	final_score_13_c142 := map(
	    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 2.5 => final_score_13_c143,
	    f_prevaddrageoldest_d > 2.5                                   => -0.0095414353,
	    f_prevaddrageoldest_d = NULL                                  => -0.0043386811,
	                                                                     -0.0043386811);
	
	final_score_13 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => final_score_13_c142,
	    f_varrisktype_i > 5.5                             => 0.0639678405,
	    f_varrisktype_i = NULL                            => -0.0021036325,
	                                                         -0.0021036325);
	
	final_score_14_c146 := map(
	    c_many_cars = ''                            						=> 0.0036310253,
	    NULL < (real)c_many_cars AND (real)c_many_cars <= 35.5 	=> 0.0510344983,
	    (real)c_many_cars > 35.5                         				=> -0.0039499346,
																																 0.0036310253);
	
	final_score_14_c145 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 9.5 => -0.0229502779,
	    f_addrs_per_ssn_i > 9.5                               => final_score_14_c146,
	    f_addrs_per_ssn_i = NULL                              => -0.0078415076,
	                                                             -0.0078415076);
	
	final_score_14 := map(
	    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => final_score_14_c145,
	    r_c14_addrs_5yr_i > 3.5                               => 0.0331434750,
	    r_c14_addrs_5yr_i = NULL                              => -0.0003653525,
	                                                             -0.0003653525);
	
	final_score_15_c149 := map(
	    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.05644487615 => -0.0080302848,
	    f_add_input_nhood_bus_pct_i > 0.05644487615                                         => 0.0444022438,
	    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0144625101,
	                                                                                           0.0144625101);
	
	final_score_15_c148 := map(
	    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 1.5 => final_score_15_c149,
	    f_divssnidmsrcurelcount_i > 1.5                                       => 0.0796537410,
	    f_divssnidmsrcurelcount_i = NULL                                      => 0.0304864051,
	                                                                             0.0304864051);
	
	final_score_15 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 3.5 => -0.0079853572,
	    f_varrisktype_i > 3.5                             => final_score_15_c148,
	    f_varrisktype_i = NULL                            => -0.0033842117,
	                                                         -0.0033842117);
	
	final_score_16_c152 := map(
	    c_med_yearblt = ''	                               						=> 0.0573197485,
	    NULL < (real)c_med_yearblt AND (real)c_med_yearblt <= 1977.5 	=> 0.0830365900,
	    (real)c_med_yearblt > 1977.5                           				=> -0.0018289868,
																																			 0.0573197485);
	
	final_score_16_c151 := map(
	    NULL < f_inq_count24_i AND f_inq_count24_i <= 1.5 => 0.0059487357,
	    f_inq_count24_i > 1.5                             => final_score_16_c152,
	    f_inq_count24_i = NULL                            => 0.0217093942,
	                                                         0.0217093942);
	
	final_score_16 := map(
	    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 130.5 => -0.0090831574,
	    f_fp_prevaddrcrimeindex_i > 130.5                                       => final_score_16_c151,
	    f_fp_prevaddrcrimeindex_i = NULL                                        => 0.0009358423,
	                                                                               0.0009358423);
	
	final_score_17_c155 := map(
	    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 15.5 => 0.0189504838,
	    f_rel_under100miles_cnt_d > 15.5                                       => 0.0716164119,
	    f_rel_under100miles_cnt_d = NULL                                       => 0.0344582332,
	                                                                              0.0344582332);
	
	final_score_17_c154 := map(
	    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 159464.5 => final_score_17_c155,
	    f_curraddrmedianvalue_d > 159464.5                                     => -0.0113287877,
	    f_curraddrmedianvalue_d = NULL                                         => 0.0134571299,
	                                                                              0.0134571299);
	
	final_score_17 := map(
	    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -7 => 0.0566879378,
	    f_addrchangecrimediff_i > -7                                     => -0.0054837600,
	    f_addrchangecrimediff_i = NULL                                   => final_score_17_c154,
	                                                                        0.0015915042);
	
	final_score_18_c158 := map(
	    c_old_homes = ''		                          					=> 0.0281085443,
	    NULL < (real)c_old_homes AND (real)c_old_homes <= 107.5 => 0.0132291952,
	    (real)c_old_homes > 107.5                         			=> 0.0654669101,
																																 0.0281085443);
	
	final_score_18_c157 := map(
	    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 4.5 => final_score_18_c158,
	    f_prevaddrageoldest_d > 4.5                                   => -0.0075312179,
	    f_prevaddrageoldest_d = NULL                                  => -0.0014756941,
	                                                                     -0.0014756941);
	
	final_score_18 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 8.5 => final_score_18_c157,
	    f_inq_highriskcredit_count24_i > 8.5                                            => 0.0739606940,
	    f_inq_highriskcredit_count24_i = NULL                                           => 0.0007094909,
	                                                                                       0.0007094909);
	
	final_score_19_c161 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 35.5 => 0.0050024791,
	    k_comb_age_d > 35.5                          => -0.0212341422,
	    k_comb_age_d = NULL                          => -0.0067154529,
	                                                    -0.0067154529);
	
	final_score_19_c160 := map(
	    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => final_score_19_c161,
	    k_inq_per_ssn_i > 3.5                             => 0.0330335921,
	    k_inq_per_ssn_i = NULL                            => -0.0029008268,
	                                                         -0.0029008268);
	
	final_score_19 := map(
	    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_19_c160,
	    r_d32_felony_count_i > 0.5                                  => 0.0602198606,
	    r_d32_felony_count_i = NULL                                 => 0.0011186884,
	                                                                   0.0011186884);
	
	final_score_20_c164 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 35 => 0.0226478444,
	    r_f01_inp_addr_address_score_d > 35                                            => -0.0103136020,
	    r_f01_inp_addr_address_score_d = NULL                                          => -0.0079265220,
	                                                                                      -0.0079265220);
	
	final_score_20_c163 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => final_score_20_c164,
	    f_varrisktype_i > 5.5                             => 0.0406528660,
	    f_varrisktype_i = NULL                            => -0.0061187984,
	                                                         -0.0061187984);
	
	final_score_20 := map(
	    c_totcrime = ''	                          						=> -0.0031977453,
	    NULL < (real)c_totcrime AND (real)c_totcrime <= 190.5 => final_score_20_c163,
	    (real)c_totcrime > 190.5                        			=> 0.0780873894,
																															 -0.0031977453);
	
	final_score_21_c167 := map(
	    NULL < r_c23_inp_addr_owned_not_occ_d AND r_c23_inp_addr_owned_not_occ_d <= 0.5 => 0.0036370072,
	    r_c23_inp_addr_owned_not_occ_d > 0.5                                            => 0.0645240316,
	    r_c23_inp_addr_owned_not_occ_d = NULL                                           => 0.0062505174,
	                                                                                       0.0062505174);
	
	final_score_21_c166 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => final_score_21_c167,
	    f_varrisktype_i > 5.5                             => 0.0488240655,
	    f_varrisktype_i = NULL                            => 0.0081841092,
	                                                         0.0081841092);
	
	final_score_21 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 9.5 => -0.0193555701,
	    f_addrs_per_ssn_i > 9.5                               => final_score_21_c166,
	    f_addrs_per_ssn_i = NULL                              => -0.0024175395,
	                                                             -0.0024175395);
	
	final_score_22_c169 := map(
	    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 1.5 => -0.0031827938,
	    r_l79_adls_per_addr_c6_i > 1.5                                      => 0.0913411203,
	    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0442911003,
	                                                                           0.0442911003);
	
	final_score_22_c170 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => -0.0257375673,
	    f_addrs_per_ssn_i > 7.5                               => -0.0014073819,
	    f_addrs_per_ssn_i = NULL                              => -0.0082245040,
	                                                             -0.0082245040);
	
	final_score_22 := map(
	    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 240.5 => final_score_22_c169,
	    r_d32_mos_since_fel_ls_d > 240.5                                      => final_score_22_c170,
	    r_d32_mos_since_fel_ls_d = NULL                                       => -0.0052783455,
	                                                                             -0.0052783455);
	
	final_score_23_c172 := map(
	    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -408 => 0.0566459288,
	    f_addrchangeincomediff_d > -408                                      => -0.0133663218,
	    f_addrchangeincomediff_d = NULL                                      => 0.0018937514,
	                                                                            -0.0065829103);
	
	final_score_23_c173 := map(
	    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 18.5 => 0.0124757362,
	    f_rel_ageover20_count_d > 18.5                                     => 0.0421689209,
	    f_rel_ageover20_count_d = NULL                                     => 0.0200231677,
	                                                                          0.0200231677);
	
	final_score_23 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 2.5 => final_score_23_c172,
	    f_varrisktype_i > 2.5                             => final_score_23_c173,
	    f_varrisktype_i = NULL                            => -0.0004677228,
	                                                         -0.0004677228);
	
	final_score_24_c176 := map(
	    c_med_yearblt = ''		                           							=> 0.0089861003,
	    NULL < (real)c_med_yearblt AND (real)c_med_yearblt <= 1948.5 	=> 0.0698666765,
	    (real)c_med_yearblt > 1948.5                           				=> 0.0037444416,
																																			 0.0089861003);
	
	final_score_24_c175 := map(
	    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 24.5 => final_score_24_c176,
	    f_rel_under100miles_cnt_d > 24.5                                       => 0.0638187472,
	    f_rel_under100miles_cnt_d = NULL                                       => 0.0132392292,
	                                                                              0.0132392292);
	
	final_score_24 := map(
	    NULL < f_vardobcountnew_i AND f_vardobcountnew_i <= 0.5 => -0.0144265071,
	    f_vardobcountnew_i > 0.5                                => final_score_24_c175,
	    f_vardobcountnew_i = NULL                               => -0.0025787024,
	                                                               -0.0025787024);
	
	final_score_25_c179 := map(
	    NULL < r_c14_addrs_per_adl_c6_i AND r_c14_addrs_per_adl_c6_i <= 1.5 => -0.0109896964,
	    r_c14_addrs_per_adl_c6_i > 1.5                                      => 0.0392822428,
	    r_c14_addrs_per_adl_c6_i = NULL                                     => -0.0091299594,
	                                                                           -0.0091299594);
	
	final_score_25_c178 := map(
	    c_born_usa = ''                        	  						=> -0.0053491726,
	    NULL < (real)c_born_usa AND (real)c_born_usa <= 173.5 => final_score_25_c179,
	    (real)c_born_usa > 173.5                        			=> 0.0359244162,
																															 -0.0053491726);
	
	final_score_25 := map(
	    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_25_c178,
	    r_d32_felony_count_i > 0.5                                  => 0.0450140557,
	    r_d32_felony_count_i = NULL                                 => -0.0023121940,
	                                                                   -0.0023121940);
	
	final_score_26_c182 := map(
	    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => 0.0493707022,
	    f_attr_arrest_recency_d > 99.5                                     => -0.0092285109,
	    f_attr_arrest_recency_d = NULL                                     => -0.0067297824,
	                                                                          -0.0067297824);
	
	final_score_26_c181 := map(
	    c_born_usa = ''	                          						=> -0.0044330149,
	    NULL < (real)c_born_usa AND (real)c_born_usa <= 188.5 => final_score_26_c182,
	    (real)c_born_usa > 188.5                        			=> 0.0494298881,
																															 -0.0044330149);
	
	final_score_26 := map(
	    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 184 => 0.0585563125,
	    r_d32_mos_since_fel_ls_d > 184                                      => final_score_26_c181,
	    r_d32_mos_since_fel_ls_d = NULL                                     => -0.0018633168,
	                                                                           -0.0018633168);
	
	final_score_27_c185 := map(
	    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 1.5 => 0.0613264341,
	    f_hh_members_ct_d > 1.5                               => 0.0110364875,
	    f_hh_members_ct_d = NULL                              => 0.0254767272,
	                                                             0.0254767272);
	
	final_score_27_c184 := map(
	    c_popover18 = ''	                            					=> 0.0054443745,
	    NULL < (real)c_popover18 AND (real)c_popover18 <= 923.5 => final_score_27_c185,
	    (real)c_popover18 > 923.5                         			=> -0.0025721215,
																																 0.0054443745);
	
	final_score_27 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 3.5 => -0.0292413428,
	    f_corrrisktype_i > 3.5                              => final_score_27_c184,
	    f_corrrisktype_i = NULL                             => -0.0015451247,
	                                                           -0.0015451247);
	
	final_score_28_c188 := map(
	    c_med_rent = ''	                        						=> 0.0312343153,
	    NULL < (real)c_med_rent AND (real)c_med_rent <= 798 => 0.0531339807,
	    (real)c_med_rent > 798                        			=> -0.0149983118,
																														 0.0312343153);
	
	final_score_28_c187 := map(
	    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => -0.0073740259,
	    f_hh_lienholders_i > 0.5                                => final_score_28_c188,
	    f_hh_lienholders_i = NULL                               => 0.0122734995,
	                                                               0.0122734995);
	
	final_score_28 := map(
	    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 32655 => -0.0117135989,
	    f_addrchangevaluediff_d > 32655                                     => 0.0650213823,
	    f_addrchangevaluediff_d = NULL                                      => final_score_28_c187,
	                                                                           -0.0031527095);
	
	final_score_29_c191 := map(
	    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 1.5 => 0.0386585412,
	    f_hh_members_ct_d > 1.5                               => -0.0010760236,
	    f_hh_members_ct_d = NULL                              => 0.0103729188,
	                                                             0.0103729188);
	
	final_score_29_c190 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0174737114,
	    f_varrisktype_i > 1.5                             => final_score_29_c191,
	    f_varrisktype_i = NULL                            => -0.0062942477,
	                                                         -0.0062942477);
	
	final_score_29 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 4.5 => 0.0654098760,
	    r_d32_mos_since_crim_ls_d > 4.5                                       => final_score_29_c190,
	    r_d32_mos_since_crim_ls_d = NULL                                      => -0.0037424352,
	                                                                             -0.0037424352);
	
	final_score_30_c193 := map(
	    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 3.5 => -0.0103655629,
	    f_addrchangecrimediff_i > 3.5                                     => 0.0424944873,
	    f_addrchangecrimediff_i = NULL                                    => -0.0082365043,
	                                                                         -0.0074826311);
	
	final_score_30_c194 := map(
	    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 1.5 => 0.0104192993,
	    f_inq_collection_count24_i > 1.5                                        => 0.0792521940,
	    f_inq_collection_count24_i = NULL                                       => 0.0223096092,
	                                                                               0.0223096092);
	
	final_score_30 := map(
	    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 3.5 => final_score_30_c193,
	    r_l79_adls_per_addr_c6_i > 3.5                                      => final_score_30_c194,
	    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0027513572,
	                                                                           -0.0027513572);
	
	final_score_31_c197 := map(
	    NULL < r_i60_inq_hiriskcred_count12_i AND r_i60_inq_hiriskcred_count12_i <= 1.5 => 0.0027362902,
	    r_i60_inq_hiriskcred_count12_i > 1.5                                            => 0.0481547517,
	    r_i60_inq_hiriskcred_count12_i = NULL                                           => 0.0054481082,
	                                                                                       0.0054481082);
	
	final_score_31_c196 := map(
	    NULL < f_attr_arrest_recency_d AND f_attr_arrest_recency_d <= 99.5 => 0.0654162836,
	    f_attr_arrest_recency_d > 99.5                                     => final_score_31_c197,
	    f_attr_arrest_recency_d = NULL                                     => 0.0087423241,
	                                                                          0.0087423241);
	
	final_score_31 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 4.5 => -0.0230661947,
	    f_corrrisktype_i > 4.5                              => final_score_31_c196,
	    f_corrrisktype_i = NULL                             => -0.0016524598,
	                                                           -0.0016524598);
	
	final_score_32_c200 := map(
	    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 2.5 => -0.0129038440,
	    r_d30_derog_count_i > 2.5                                 => 0.0301176752,
	    r_d30_derog_count_i = NULL                                => 0.0027731075,
	                                                                 0.0027731075);
	
	final_score_32_c199 := map(
	    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 3.5 => -0.0113330955,
	    f_addrchangecrimediff_i > 3.5                                     => 0.0363548467,
	    f_addrchangecrimediff_i = NULL                                    => final_score_32_c200,
	                                                                         -0.0056735644);
	
	final_score_32 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 29.5 => final_score_32_c199,
	    f_addrs_per_ssn_i > 29.5                               => 0.0545109482,
	    f_addrs_per_ssn_i = NULL                               => -0.0033582009,
	                                                              -0.0033582009);
	
	final_score_33_c203 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 35 => 0.0148425153,
	    r_f01_inp_addr_address_score_d > 35                                            => -0.0128653362,
	    r_f01_inp_addr_address_score_d = NULL                                          => -0.0108082500,
	                                                                                      -0.0108082500);
	
	final_score_33_c202 := map(
	    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 213 => 0.0455055030,
	    r_d32_mos_since_fel_ls_d > 213                                      => final_score_33_c203,
	    r_d32_mos_since_fel_ls_d = NULL                                     => -0.0080767826,
	                                                                           -0.0080767826);
	
	final_score_33 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => final_score_33_c202,
	    f_varrisktype_i > 4.5                             => 0.0336019548,
	    f_varrisktype_i = NULL                            => -0.0053478802,
	                                                         -0.0053478802);
	
	final_score_34_c206 := map(
	    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 5.5 => 0.0456121052,
	    f_prevaddrageoldest_d > 5.5                                   => -0.0008317579,
	    f_prevaddrageoldest_d = NULL                                  => 0.0080924513,
	                                                                     0.0080924513);
	
	final_score_34_c205 := map(
	    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 142.5 => -0.0133819808,
	    f_curraddrcartheftindex_i > 142.5                                       => final_score_34_c206,
	    f_curraddrcartheftindex_i = NULL                                        => -0.0065193651,
	                                                                               -0.0065193651);
	
	final_score_34 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => final_score_34_c205,
	    f_varrisktype_i > 5.5                             => 0.0380876094,
	    f_varrisktype_i = NULL                            => -0.0048805583,
	                                                         -0.0048805583);
	
	final_score_35_c209 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 7.5 => -0.0143585157,
	    f_corrrisktype_i > 7.5                              => 0.0136441190,
	    f_corrrisktype_i = NULL                             => -0.0071527832,
	                                                           -0.0071527832);
	
	final_score_35_c208 := map(
	    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_35_c209,
	    r_d32_felony_count_i > 0.5                                  => 0.0385362626,
	    r_d32_felony_count_i = NULL                                 => -0.0043449388,
	                                                                   -0.0043449388);
	
	final_score_35 := map(
	    NULL < f_inq_quizprovider_count24_i AND f_inq_quizprovider_count24_i <= 0.5 => final_score_35_c208,
	    f_inq_quizprovider_count24_i > 0.5                                          => 0.0440950768,
	    f_inq_quizprovider_count24_i = NULL                                         => -0.0011383634,
	                                                                                   -0.0011383634);
	
	final_score_36_c212 := map(
	    C_INC_100K_P = ''                           							=> 0.0250039261,
	    NULL < (real)C_INC_100K_P AND (real)C_INC_100K_P <= 19.25 => 0.0156283133,
	    (real)C_INC_100K_P > 19.25                          			=> 0.0952308723,
																																	 0.0250039261);
	
	final_score_36_c211 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 25.5 => final_score_36_c212,
	    k_comb_age_d > 25.5                          => -0.0075892889,
	    k_comb_age_d = NULL                          => -0.0000292260,
	                                                    -0.0000292260);
	
	final_score_36 := map(
	    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 10.5 => final_score_36_c211,
	    r_c14_addrs_15yr_i > 10.5                                => 0.0543461849,
	    r_c14_addrs_15yr_i = NULL                                => 0.0018849197,
	                                                                0.0018849197);
	
	final_score_37_c214 := map(
	    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 0.5 => 0.0041766205,
	    f_phones_per_addr_c6_i > 0.5                                    => 0.0787384774,
	    f_phones_per_addr_c6_i = NULL                                   => 0.0401207826,
	                                                                       0.0401207826);
	
	final_score_37_c215 := map(
	    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 4.5 => 0.0378766911,
	    r_i60_inq_hiriskcred_recency_d > 4.5                                            => -0.0041678905,
	    r_i60_inq_hiriskcred_recency_d = NULL                                           => -0.0021905184,
	                                                                                       -0.0021905184);
	
	final_score_37 := map(
	    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 48 => final_score_37_c214,
	    r_d33_eviction_recency_d > 48                                      => final_score_37_c215,
	    r_d33_eviction_recency_d = NULL                                    => 0.0004832320,
	                                                                          0.0004832320);
	
	final_score_38_c218 := map(
	    c_trailer_p = ''		                         							=> 0.0411281434,
	    NULL < (real)c_trailer_p AND (real)c_trailer_p <= 0.25 		=> 0.0742858575,
	    (real)c_trailer_p > 0.25                         					=> 0.0035068908,
																																	 0.0411281434);
	
	final_score_38_c217 := map(
	    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => 0.0013534369,
	    f_idverrisktype_i > 2.5                               => final_score_38_c218,
	    f_idverrisktype_i = NULL                              => 0.0176946996,
	                                                             0.0176946996);
	
	final_score_38 := map(
	    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 3.5 => -0.0058394579,
	    r_d30_derog_count_i > 3.5                                 => final_score_38_c217,
	    r_d30_derog_count_i = NULL                                => 0.0005972347,
	                                                                 0.0005972347);
	
	final_score_39_c221 := map(
	    C_INC_50K_P = ''                          								=> 0.0403144647,
	    NULL < (real)C_INC_50K_P AND (real)C_INC_50K_P <= 12.55 	=> 0.0847135602,
	    (real)C_INC_50K_P > 12.55                         				=> 0.0143962110,
																																	 0.0403144647);
	
	final_score_39_c220 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 143.5 => final_score_39_c221,
	    r_d32_mos_since_crim_ls_d > 143.5                                       => 0.0016817667,
	    r_d32_mos_since_crim_ls_d = NULL                                        => 0.0184832448,
	                                                                               0.0184832448);
	
	final_score_39 := map(
	    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 3.5 => -0.0076731115,
	    r_c14_addrs_5yr_i > 3.5                               => final_score_39_c220,
	    r_c14_addrs_5yr_i = NULL                              => -0.0029210004,
	                                                             -0.0029210004);
	
	final_score_40_c223 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 6.5 => 0.0354744912,
	    r_d32_mos_since_crim_ls_d > 6.5                                       => -0.0079219573,
	    r_d32_mos_since_crim_ls_d = NULL                                      => -0.0058734596,
	                                                                             -0.0058734596);
	
	final_score_40_c224 := map(
	    c_preschl = ''		                        						=> 0.0345266199,
	    NULL < (real)c_preschl AND (real)c_preschl <= 131.5 	=> 0.0049577905,
	    (real)c_preschl > 131.5                       				=> 0.0679657149,
																															 0.0345266199);
	
	final_score_40 := map(
	    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 176.5 => final_score_40_c223,
	    f_curraddrmurderindex_i > 176.5                                     => final_score_40_c224,
	    f_curraddrmurderindex_i = NULL                                      => -0.0017001080,
	                                                                           -0.0017001080);
	
	final_score_41_c227 := map(
	    c_easiqlife = ''                         								=> 0.0410339960,
	    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 89.5 	=> 0.0920533997,
	    (real)c_easiqlife > 89.5                         				=> 0.0229646239,
																																 0.0410339960);
	
	final_score_41_c226 := map(
	    c_rental = ''                       								=> 0.0096122989,
	    NULL < (real)c_rental AND (real)c_rental <= 172.5 	=> 0.0031518957,
	    (real)c_rental > 172.5                      				=> final_score_41_c227,
																														 0.0096122989);
	
	final_score_41 := map(
	    c_span_lang = ''		                          						=> 0.0010945062,
	    NULL < (real)c_span_lang AND (real)c_span_lang <= 170.5 	=> final_score_41_c226,
	    (real)c_span_lang > 170.5                         				=> -0.0158395258,
																																	 0.0010945062);
	
	final_score_42_c229 := map(
	    NULL < f_inq_count24_i AND f_inq_count24_i <= 3.5 => 0.0045885506,
	    f_inq_count24_i > 3.5                             => 0.0496548199,
	    f_inq_count24_i = NULL                            => 0.0084226965,
	                                                         0.0084226965);
	
	final_score_42_c230 := map(
	    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 4.5 => 0.0014036594,
	    r_d30_derog_count_i > 4.5                                 => 0.0557196995,
	    r_d30_derog_count_i = NULL                                => 0.0128664600,
	                                                                 0.0128664600);
	
	final_score_42 := map(
	    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_42_c229,
	    f_phone_ver_insurance_d > 3.5                                     => -0.0202174332,
	    f_phone_ver_insurance_d = NULL                                    => final_score_42_c230,
	                                                                         0.0012538987);
	
	final_score_43_c232 := map(
	    NULL < r_f00_addr_not_ver_w_ssn_i AND r_f00_addr_not_ver_w_ssn_i <= 0.5 => -0.0099984849,
	    r_f00_addr_not_ver_w_ssn_i > 0.5                                        => 0.0266439647,
	    r_f00_addr_not_ver_w_ssn_i = NULL                                       => -0.0073011482,
	                                                                               -0.0073011482);
	
	final_score_43_c233 := map(
	    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 10.5 => 0.0358522580,
	    f_rel_homeover200_count_d > 10.5                                       => -0.0268851405,
	    f_rel_homeover200_count_d = NULL                                       => 0.0231993373,
	                                                                              0.0231993373);
	
	final_score_43 := map(
	    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 2.5 => final_score_43_c232,
	    f_hh_collections_ct_i > 2.5                                   => final_score_43_c233,
	    f_hh_collections_ct_i = NULL                                  => -0.0026915030,
	                                                                     -0.0026915030);
	
	final_score_44_c236 := map(
	    NULL < (integer)k_inf_nothing_found_i AND (integer)k_inf_nothing_found_i <= 0.5 			=> -0.0052184091,
	    (integer)k_inf_nothing_found_i > 0.5                                   								=> 0.0314415032,
	    (string)k_inf_nothing_found_i = ''                                    								=> 0.0133340655,
																																															 0.0133340655);
	
	final_score_44_c235 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => 0.0029153822,
	    r_f01_inp_addr_address_score_d > 85                                            => final_score_44_c236,
	    r_f01_inp_addr_address_score_d = NULL                                          => 0.0122250938,
	                                                                                      0.0122250938);
	
	final_score_44 := map(
	    NULL < f_curraddrcartheftindex_i AND f_curraddrcartheftindex_i <= 135.5 => -0.0098554332,
	    f_curraddrcartheftindex_i > 135.5                                       => final_score_44_c235,
	    f_curraddrcartheftindex_i = NULL                                        => -0.0016488558,
	                                                                               -0.0016488558);
	
	final_score_45_c238 := map(
	    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 18.5 => -0.0170661071,
	    f_rel_educationover8_count_d > 18.5                                          => 0.0183931010,
	    f_rel_educationover8_count_d = NULL                                          => -0.0096202837,
	                                                                                    -0.0096202837);
	
	final_score_45_c239 := map(
	    c_no_labfor = ''		                          					=> 0.0112813007,
	    NULL < (real)c_no_labfor AND (real)c_no_labfor <= 166.5 => 0.0066490020,
	    (real)c_no_labfor > 166.5                         			=> 0.0630852511,
																																 0.0112813007);
	
	final_score_45 := map(
	    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 0.5 => final_score_45_c238,
	    k_inq_per_ssn_i > 0.5                             => final_score_45_c239,
	    k_inq_per_ssn_i = NULL                            => -0.0012783260,
	                                                         -0.0012783260);
	
	final_score_46_c242 := map(
	    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 131787.5 => 0.0256520101,
	    f_curraddrmedianvalue_d > 131787.5                                     => -0.0053296336,
	    f_curraddrmedianvalue_d = NULL                                         => 0.0062529817,
	                                                                              0.0062529817);
	
	final_score_46_c241 := map(
	    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 4.5 => -0.0228094012,
	    f_corrrisktype_i > 4.5                              => final_score_46_c242,
	    f_corrrisktype_i = NULL                             => -0.0032788574,
	                                                           -0.0032788574);
	
	final_score_46 := map(
	    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_46_c241,
	    r_d32_felony_count_i > 0.5                                  => 0.0422653129,
	    r_d32_felony_count_i = NULL                                 => -0.0005829179,
	                                                                   -0.0005829179);
	
	final_score_47_c244 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => 0.0044303298,
	    f_addrs_per_ssn_i > 7.5                               => 0.0489092281,
	    f_addrs_per_ssn_i = NULL                              => 0.0255636284,
	                                                             0.0255636284);
	
	final_score_47_c245 := map(
	    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 8.5 => -0.0124359989,
	    r_d30_derog_count_i > 8.5                                 => 0.0287399763,
	    r_d30_derog_count_i = NULL                                => -0.0080110799,
	                                                                 -0.0080110799);
	
	final_score_47 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => final_score_47_c244,
	    k_comb_age_d > 24.5                          => final_score_47_c245,
	    k_comb_age_d = NULL                          => -0.0016460484,
	                                                    -0.0016460484);
	
	final_score_48_c247 := map(
	    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 2.5 => 0.0125218604,
	    r_c14_addrs_5yr_i > 2.5                               => 0.0771756549,
	    r_c14_addrs_5yr_i = NULL                              => 0.0288453431,
	                                                             0.0288453431);
	
	final_score_48_c248 := map(
	    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 48 => 0.0335067137,
	    r_d33_eviction_recency_d > 48                                      => -0.0080525603,
	    r_d33_eviction_recency_d = NULL                                    => -0.0053014535,
	                                                                          -0.0053014535);
	
	final_score_48 := map(
	    c_med_yearblt = ''		                             						=> -0.0018280321,
	    NULL < (real)c_med_yearblt AND (real)c_med_yearblt <= 1950.5 	=> final_score_48_c247,
	    (real)c_med_yearblt > 1950.5                           				=> final_score_48_c248,
																																			 -0.0018280321);
	
	final_score_49_c251 := map(
	    c_professional = ''                            								=> 0.0235927178,
	    NULL < (real)c_professional AND (real)c_professional <= 7.85 	=> 0.0078284615,
	    (real)c_professional > 7.85                            				=> 0.0708854868,
																																			 0.0235927178);
	
	final_score_49_c250 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 1.5 => -0.0063543901,
	    f_inq_highriskcredit_count24_i > 1.5                                            => final_score_49_c251,
	    f_inq_highriskcredit_count24_i = NULL                                           => -0.0032147740,
	                                                                                       -0.0032147740);
	
	final_score_49 := map(
	    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 6.5 => final_score_49_c250,
	    r_l79_adls_per_addr_c6_i > 6.5                                      => 0.0584466023,
	    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0013022003,
	                                                                           -0.0013022003);
	
	final_score_50_c253 := map(
	    NULL < f_vardobcountnew_i AND f_vardobcountnew_i <= 0.5 => -0.0185394177,
	    f_vardobcountnew_i > 0.5                                => 0.0059336344,
	    f_vardobcountnew_i = NULL                               => -0.0080470886,
	                                                               -0.0080470886);
	
	final_score_50_c254 := map(
	    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 2.5 => 0.0675003422,
	    f_phones_per_addr_curr_i > 2.5                                      => 0.0100240356,
	    f_phones_per_addr_curr_i = NULL                                     => 0.0272983354,
	                                                                           0.0272983354);
	
	final_score_50 := map(
	    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => final_score_50_c253,
	    k_inq_per_ssn_i > 3.5                             => final_score_50_c254,
	    k_inq_per_ssn_i = NULL                            => -0.0048274881,
	                                                         -0.0048274881);
	
	final_score_51_c256 := map(
	    c_born_usa = ''	                          						=> -0.0062446349,
	    NULL < (real)c_born_usa AND (real)c_born_usa <= 155.5 => -0.0105969277,
	    (real)c_born_usa > 155.5                        			=> 0.0199018455,
																															 -0.0062446349);
	
	final_score_51_c257 := map(
	    c_ab_av_edu = ''                         								=> 0.0246757003,
	    NULL < (real)c_ab_av_edu AND (real)c_ab_av_edu <= 69.5 	=> 0.0659773587,
	    (real)c_ab_av_edu > 69.5                         				=> -0.0002973955,
																																 0.0246757003);
	
	final_score_51 := map(
	    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 1.5 => final_score_51_c256,
	    k_inq_addrs_per_ssn_i > 1.5                                   => final_score_51_c257,
	    k_inq_addrs_per_ssn_i = NULL                                  => -0.0041111395,
	                                                                     -0.0041111395);
	
	final_score_52_c260 := map(
	    c_food = ''	                      						=> 0.0259954521,
	    NULL < (real)c_food AND (real)c_food <= 12.95 => -0.0082299340,
	    (real)c_food > 12.95                    			=> 0.0509393776,
																											 0.0259954521);
	
	final_score_52_c259 := map(
	    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 2.5 => -0.0132076463,
	    r_p88_phn_dst_to_inp_add_i > 2.5                                        => 0.0579768727,
	    r_p88_phn_dst_to_inp_add_i = NULL                                       => final_score_52_c260,
	                                                                               0.0171372569);
	
	final_score_52 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 19.5 => -0.0059705719,
	    f_addrs_per_ssn_i > 19.5                               => final_score_52_c259,
	    f_addrs_per_ssn_i = NULL                               => -0.0015199203,
	                                                              -0.0015199203);
	
	final_score_53_c263 := map(
	    NULL < f_inq_count24_i AND f_inq_count24_i <= 2.5 => -0.0084182827,
	    f_inq_count24_i > 2.5                             => 0.0567581179,
	    f_inq_count24_i = NULL                            => 0.0099648047,
	                                                         0.0099648047);
	
	final_score_53_c262 := map(
	    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 48.5 => final_score_53_c263,
	    r_pb_order_freq_d > 48.5                               => -0.0258547065,
	    r_pb_order_freq_d = NULL                               => 0.0235947000,
	                                                              0.0145360658);
	
	final_score_53 := map(
	    c_span_lang = ''		                          					=> 0.0032335003,
	    NULL < (real)c_span_lang AND (real)c_span_lang <= 152.5 => final_score_53_c262,
	    (real)c_span_lang > 152.5                         			=> -0.0094661462,
																																 0.0032335003);
	
	final_score_54_c266 := map(
	    c_hh1_p = ''	                      							=> 0.0126354411,
	    NULL < (real)c_hh1_p AND (real)c_hh1_p <= 29.75 	=> 0.0018081175,
	    (real)c_hh1_p > 29.75                     				=> 0.0378132649,
																													 0.0126354411);
	
	final_score_54_c265 := map(
	    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 14.5 => -0.0069823071,
	    f_rel_homeover50_count_d > 14.5                                      => final_score_54_c266,
	    f_rel_homeover50_count_d = NULL                                      => -0.0003608580,
	                                                                            -0.0003608580);
	
	final_score_54 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 5.5 => 0.0477211951,
	    r_d32_mos_since_crim_ls_d > 5.5                                       => final_score_54_c265,
	    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0015677612,
	                                                                             0.0015677612);
	
	final_score_55_c269 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 4.5 => 0.0053076587,
	    f_varrisktype_i > 4.5                             => 0.0360993359,
	    f_varrisktype_i = NULL                            => 0.0075033883,
	                                                         0.0075033883);
	
	final_score_55_c268 := map(
	    c_cartheft = ''		                       							=> -0.0035032209,
	    NULL < (real)c_cartheft AND (real)c_cartheft <= 113 	=> -0.0135371791,
	    (real)c_cartheft > 113                        				=> final_score_55_c269,
																															 -0.0035032209);
	
	final_score_55 := map(
	    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 2.5 => final_score_55_c268,
	    r_i61_inq_collection_count12_i > 2.5                                            => 0.0513109430,
	    r_i61_inq_collection_count12_i = NULL                                           => -0.0009258388,
	                                                                                       -0.0009258388);
	
	final_score_56_c272 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 8.5 => -0.0134660947,
	    f_addrs_per_ssn_i > 8.5                               => 0.0064645740,
	    f_addrs_per_ssn_i = NULL                              => -0.0004259322,
	                                                             -0.0004259322);
	
	final_score_56_c271 := map(
	    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 4.5 => final_score_56_c272,
	    r_c12_num_nonderogs_d > 4.5                                   => -0.0347153822,
	    r_c12_num_nonderogs_d = NULL                                  => -0.0050968855,
	                                                                     -0.0050968855);
	
	final_score_56 := map(
	    NULL < f_curraddrcrimeindex_i AND f_curraddrcrimeindex_i <= 190.5 => final_score_56_c271,
	    f_curraddrcrimeindex_i > 190.5                                    => 0.0414624239,
	    f_curraddrcrimeindex_i = NULL                                     => -0.0033430190,
	                                                                         -0.0033430190);
	
	final_score_57_c274 := map(
	    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 5.5 => 0.0011836144,
	    f_rel_incomeover50_count_d > 5.5                                        => 0.0486650522,
	    f_rel_incomeover50_count_d = NULL                                       => 0.0204633343,
	                                                                               0.0204633343);
	
	final_score_57_c275 := map(
	    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 1.5 => -0.0095300989,
	    r_d32_criminal_count_i > 1.5                                    => 0.0184305895,
	    r_d32_criminal_count_i = NULL                                   => -0.0025036665,
	                                                                       -0.0025036665);
	
	final_score_57 := map(
	    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 2.5 => final_score_57_c274,
	    f_prevaddrageoldest_d > 2.5                                   => final_score_57_c275,
	    f_prevaddrageoldest_d = NULL                                  => 0.0003737218,
	                                                                     0.0003737218);
	
	final_score_58_c277 := map(
	    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 4.5 => 0.0362345839,
	    r_i61_inq_collection_recency_d > 4.5                                            => -0.0171554200,
	    r_i61_inq_collection_recency_d = NULL                                           => -0.0134494777,
	                                                                                       -0.0134494777);
	
	final_score_58_c278 := map(
	    c_easiqlife = ''                          							=> 0.0075508389,
	    NULL < (real)c_easiqlife AND (real)c_easiqlife <= 117.5 => 0.0264881640,
	    (real)c_easiqlife > 117.5                         			=> -0.0080158481,
																																 0.0075508389);
	
	final_score_58 := map(
	    NULL < f_add_curr_nhood_vac_pct_i AND f_add_curr_nhood_vac_pct_i <= 0.03979761915 => final_score_58_c277,
	    f_add_curr_nhood_vac_pct_i > 0.03979761915                                        => final_score_58_c278,
	    f_add_curr_nhood_vac_pct_i = NULL                                                 => -0.0063223861,
	                                                                                         -0.0063223861);
	
	final_score_59_c280 := map(
	    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 0.5 => 0.0138830829,
	    f_inq_collection_count24_i > 0.5                                        => 0.0673771705,
	    f_inq_collection_count24_i = NULL                                       => 0.0237815952,
	                                                                               0.0237815952);
	
	final_score_59_c281 := map(
	    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 7.5 => -0.0059555109,
	    f_util_adl_count_n > 7.5                                => 0.0378586092,
	    f_util_adl_count_n = NULL                               => -0.0036029836,
	                                                               -0.0036029836);
	
	final_score_59 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => final_score_59_c280,
	    k_comb_age_d > 24.5                          => final_score_59_c281,
	    k_comb_age_d = NULL                          => 0.0016564863,
	                                                    0.0016564863);
	
	final_score_60_c283 := map(
	    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 21.5 => -0.0045707334,
	    r_s66_adlperssn_count_i > 21.5                                     => 0.0357423446,
	    r_s66_adlperssn_count_i = NULL                                     => -0.0029204904,
	                                                                          -0.0029204904);
	
	final_score_60_c284 := map(
	    c_bel_edu = ''                        							=> 0.0422518757,
	    NULL < (real)c_bel_edu AND (real)c_bel_edu <= 178.5 => 0.0864986059,
	    (real)c_bel_edu > 178.5                       			=> -0.0078167926,
																														 0.0422518757);
	
	final_score_60 := map(
	    C_INC_15K_P = ''                         								=> -0.0001803793,
	    NULL < (real)C_INC_15K_P AND (real)C_INC_15K_P <= 33.1 	=> final_score_60_c283,
	    (real)C_INC_15K_P > 33.1                         				=> final_score_60_c284,
																																 -0.0001803793);
	
	final_score_61_c287 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 32.5 => 0.0409684049,
	    r_d32_mos_since_crim_ls_d > 32.5                                       => 0.0061667789,
	    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0126310119,
	                                                                              0.0126310119);
	
	final_score_61_c286 := map(
	    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 219.5 => final_score_61_c287,
	    f_m_bureau_adl_fs_notu_d > 219.5                                      => -0.0132721852,
	    f_m_bureau_adl_fs_notu_d = NULL                                       => 0.0033907953,
	                                                                             0.0033907953);
	
	final_score_61 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => -0.0196111601,
	    f_addrs_per_ssn_i > 7.5                               => final_score_61_c286,
	    f_addrs_per_ssn_i = NULL                              => -0.0030776126,
	                                                             -0.0030776126);
	
	final_score_62_c290 := map(
	    c_hval_250k_p = ''                            							=> 0.0418561063,
	    NULL < (real)c_hval_250k_p AND (real)c_hval_250k_p <= 11.05 => 0.0163603550,
	    (real)c_hval_250k_p > 11.05                           			=> 0.0841365606,
																																		 0.0418561063);
	
	final_score_62_c289 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => final_score_62_c290,
	    k_comb_age_d > 24.5                          => 0.0027807592,
	    k_comb_age_d = NULL                          => 0.0073955077,
	                                                    0.0073955077);
	
	final_score_62 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 8.5 => -0.0160569187,
	    f_addrs_per_ssn_i > 8.5                               => final_score_62_c289,
	    f_addrs_per_ssn_i = NULL                              => -0.0001367435,
	                                                             -0.0001367435);
	
	final_score_63_c292 := map(
	    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other'])    => 0.0007153763,
	    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                       																																=> 0.0576873471,
	    nf_seg_fraudpoint_3_0 = ''                             																																				=> 0.0128172655,
																																																																			 0.0128172655);
	
	final_score_63_c293 := map(
	    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 16.5 => -0.0156677754,
	    f_rel_under100miles_cnt_d > 16.5                                       => 0.0108385580,
	    f_rel_under100miles_cnt_d = NULL                                       => -0.0097141530,
	                                                                              -0.0097141530);
	
	final_score_63 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 25.5 => final_score_63_c292,
	    k_comb_age_d > 25.5                          => final_score_63_c293,
	    k_comb_age_d = NULL                          => -0.0045816860,
	                                                    -0.0045816860);
	
	final_score_64_c296 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 5.5 => -0.0102550431,
	    f_inq_highriskcredit_count24_i > 5.5                                            => 0.0439004147,
	    f_inq_highriskcredit_count24_i = NULL                                           => -0.0079102751,
	                                                                                       -0.0079102751);
	
	final_score_64_c295 := map(
	    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 3.5 => 0.0190516014,
	    f_prevaddrlenofres_d > 3.5                                  => final_score_64_c296,
	    f_prevaddrlenofres_d = NULL                                 => -0.0031707435,
	                                                                   -0.0031707435);
	
	final_score_64 := map(
	    c_born_usa = ''                         								=> -0.0010941853,
	    NULL < (real)c_born_usa AND (real)c_born_usa <= 186.5 	=> final_score_64_c295,
	    (real)c_born_usa > 186.5                        				=> 0.0435401496,
																																 -0.0010941853);
	
	final_score_65_c298 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 26.5 => 0.0827895667,
	    k_comb_age_d > 26.5                          => 0.0106334915,
	    k_comb_age_d = NULL                          => 0.0270618837,
	                                                    0.0270618837);
	
	final_score_65_c299 := map(
	    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 2.5 => -0.0062112281,
	    r_i61_inq_collection_count12_i > 2.5                                            => 0.0442147622,
	    r_i61_inq_collection_count12_i = NULL                                           => -0.0037777637,
	                                                                                       -0.0037777637);
	
	final_score_65 := map(
	    c_med_yearblt = ''                            	 							=> -0.0003263118,
	    NULL < (real)c_med_yearblt AND (real)c_med_yearblt <= 1950.5 	=> final_score_65_c298,
	    (real)c_med_yearblt > 1950.5                           				=> final_score_65_c299,
																																			 -0.0003263118);
	
	final_score_66_c302 := map(
	    c_med_age = ''                        							=> 0.0090789435,
	    NULL < (real)c_med_age AND (real)c_med_age <= 26.05 => 0.0771452871,
	    (real)c_med_age > 26.05                       			=> 0.0056585242,
																														 0.0090789435);
	
	final_score_66_c301 := map(
	    c_span_lang = ''                          							=> -0.0010398215,
	    NULL < (real)c_span_lang AND (real)c_span_lang <= 154.5 => final_score_66_c302,
	    (real)c_span_lang > 154.5                         			=> -0.0128478722,
																																 -0.0010398215);
	
	final_score_66 := map(
	    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 7.5 => final_score_66_c301,
	    k_inq_per_ssn_i > 7.5                             => 0.0331902976,
	    k_inq_per_ssn_i = NULL                            => -0.0000033175,
	                                                         -0.0000033175);
	
	final_score_67_c305 := map(
	    C_INC_100K_P = ''                           							=> 0.0039639244,
	    NULL < (real)C_INC_100K_P AND (real)C_INC_100K_P <= 19.75 => -0.0009938601,
	    (real)C_INC_100K_P > 19.75                          			=> 0.0590283847,
																																	 0.0039639244);
	
	final_score_67_c304 := map(
	    c_old_homes = ''                          							=> 0.0071895719,
	    NULL < (real)c_old_homes AND (real)c_old_homes <= 174.5 => final_score_67_c305,
	    (real)c_old_homes > 174.5                         			=> 0.0540517775,
																																 0.0071895719);
	
	final_score_67 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => final_score_67_c304,
	    k_comb_age_d > 33.5                          => -0.0154345718,
	    k_comb_age_d = NULL                          => -0.0044930194,
	                                                    -0.0044930194);
	
	final_score_68_c308 := map(
	    c_no_car = ''                       							=> 0.0080945658,
	    NULL < (real)c_no_car AND (real)c_no_car <= 183.5 => 0.0045171570,
	    (real)c_no_car > 183.5                      			=> 0.0563564599,
																													 0.0080945658);
	
	final_score_68_c307 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => final_score_68_c308,
	    k_comb_age_d > 31.5                          => -0.0170681238,
	    k_comb_age_d = NULL                          => -0.0056772485,
	                                                    -0.0056772485);
	
	final_score_68 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 21.5 => final_score_68_c307,
	    f_addrs_per_ssn_i > 21.5                               => 0.0156019543,
	    f_addrs_per_ssn_i = NULL                               => -0.0027618551,
	                                                              -0.0027618551);
	
	final_score_69_c310 := map(
	    NULL < f_inq_quizprovider_count24_i AND f_inq_quizprovider_count24_i <= 1.5 => -0.0089132979,
	    f_inq_quizprovider_count24_i > 1.5                                          => 0.0414141807,
	    f_inq_quizprovider_count24_i = NULL                                         => -0.0074146454,
	                                                                                   -0.0074146454);
	
	final_score_69_c311 := map(
	    c_occunit_p = ''                          							=> 0.0248785937,
	    NULL < (real)c_occunit_p AND (real)c_occunit_p <= 87.55 => 0.0631149874,
	    (real)c_occunit_p > 87.55                         			=> 0.0040979450,
																																 0.0248785937);
	
	final_score_69 := map(
	    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 6.5 => final_score_69_c310,
	    r_d32_criminal_count_i > 6.5                                    => final_score_69_c311,
	    r_d32_criminal_count_i = NULL                                   => -0.0051016086,
	                                                                       -0.0051016086);
	
	final_score_70_c313 := map(
	    c_born_usa = ''                         							=> -0.0066032229,
	    NULL < (real)c_born_usa AND (real)c_born_usa <= 177.5 => -0.0098145355,
	    (real)c_born_usa > 177.5                        			=> 0.0343631094,
																															 -0.0066032229);
	
	final_score_70_c314 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 38.5 => 0.0441227491,
	    r_d32_mos_since_crim_ls_d > 38.5                                       => 0.0004618075,
	    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0086264035,
	                                                                              0.0086264035);
	
	final_score_70 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 17.5 => final_score_70_c313,
	    f_addrs_per_ssn_i > 17.5                               => final_score_70_c314,
	    f_addrs_per_ssn_i = NULL                               => -0.0027929813,
	                                                              -0.0027929813);
	
	final_score_71_c317 := map(
	    c_preschl = ''                        							=> 0.0060846516,
	    NULL < (real)c_preschl AND (real)c_preschl <= 105.5 => 0.0251079951,
	    (real)c_preschl > 105.5                       			=> -0.0047618072,
																														 0.0060846516);
	
	final_score_71_c316 := map(
	    c_hh2_p = ''                      							=> 0.0113147182,
	    NULL < (real)c_hh2_p AND (real)c_hh2_p <= 17.45 => 0.0519263278,
	    (real)c_hh2_p > 17.45                     			=> final_score_71_c317,
																												 0.0113147182);
	
	final_score_71 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => -0.0124641012,
	    f_varrisktype_i > 1.5                             => final_score_71_c316,
	    f_varrisktype_i = NULL                            => -0.0028198378,
	                                                         -0.0028198378);
	
	final_score_72_c320 := map(
	    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 2.5 => 0.0348347363,
	    f_rel_incomeover50_count_d > 2.5                                        => -0.0066373011,
	    f_rel_incomeover50_count_d = NULL                                       => 0.0044733471,
	                                                                               0.0044733471);
	
	final_score_72_c319 := map(
	    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => -0.0115786214,
	    k_inq_addrs_per_ssn_i > 0.5                                   => final_score_72_c320,
	    k_inq_addrs_per_ssn_i = NULL                                  => -0.0070485926,
	                                                                     -0.0070485926);
	
	final_score_72 := map(
	    c_hval_80k_p = ''                           							=> -0.0048976271,
	    NULL < (real)c_hval_80k_p AND (real)c_hval_80k_p <= 35.25 => final_score_72_c319,
	    (real)c_hval_80k_p > 35.25                          			=> 0.0612360268,
																																	 -0.0048976271);
	
	final_score_73_c323 := map(
	    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.9927983463 => -0.0058079018,
	    f_add_curr_nhood_sfd_pct_d > 0.9927983463                                        => 0.0326326292,
	    f_add_curr_nhood_sfd_pct_d = NULL                                                => -0.0031347806,
	                                                                                        -0.0031347806);
	
	final_score_73_c322 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 8.5 => final_score_73_c323,
	    f_inq_highriskcredit_count24_i > 8.5                                            => 0.0335964553,
	    f_inq_highriskcredit_count24_i = NULL                                           => -0.0021407275,
	                                                                                       -0.0021407275);
	
	final_score_73 := map(
	    c_med_rent = ''                         							=> -0.0000211654,
	    NULL < (real)c_med_rent AND (real)c_med_rent <= 253.5 => 0.0449724291,
	    (real)c_med_rent > 253.5                        			=> final_score_73_c322,
																															 -0.0000211654);
	
	final_score_74_c326 := map(
	    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.028351503 => 0.0680903747,
	    f_add_curr_nhood_bus_pct_i > 0.028351503                                        => 0.0014654576,
	    f_add_curr_nhood_bus_pct_i = NULL                                               => 0.0269447540,
	                                                                                       0.0269447540);
	
	final_score_74_c325 := map(
	    c_food = ''                     							=> 0.0063228354,
	    NULL < (real)c_food AND (real)c_food <= 44.05 => 0.0027083247,
	    (real)c_food > 44.05                    			=> final_score_74_c326,
																											 0.0063228354);
	
	final_score_74 := map(
	    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 220.5 => final_score_74_c325,
	    f_m_bureau_adl_fs_notu_d > 220.5                                      => -0.0181534591,
	    f_m_bureau_adl_fs_notu_d = NULL                                       => -0.0009108994,
	                                                                             -0.0009108994);
	
	final_score_75_c329 := map(
	    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => -0.0141088995,
	    r_c23_inp_addr_occ_index_d > 2                                        => 0.0223238888,
	    r_c23_inp_addr_occ_index_d = NULL                                     => 0.0006426061,
	                                                                             0.0006426061);
	
	final_score_75_c328 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 41.5 => 0.0494422327,
	    r_d32_mos_since_crim_ls_d > 41.5                                       => final_score_75_c329,
	    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0109808974,
	                                                                              0.0109808974);
	
	final_score_75 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 20.5 => -0.0023106495,
	    f_addrs_per_ssn_i > 20.5                               => final_score_75_c328,
	    f_addrs_per_ssn_i = NULL                               => -0.0000607525,
	                                                              -0.0000607525);
	
	final_score_76_c331 := map(
	    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 1.5 => 0.0118462223,
	    f_hh_age_18_plus_d > 1.5                                => -0.0155693101,
	    f_hh_age_18_plus_d = NULL                               => -0.0052031168,
	                                                               -0.0052031168);
	
	final_score_76_c332 := map(
	    c_retired = ''                        							=> 0.0229449181,
	    NULL < (real)c_retired AND (real)c_retired <= 10.45 => 0.0497406767,
	    (real)c_retired > 10.45                       			=> -0.0084941488,
																														 0.0229449181);
	
	final_score_76 := map(
	    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 2.5 => final_score_76_c331,
	    f_hh_collections_ct_i > 2.5                                   => final_score_76_c332,
	    f_hh_collections_ct_i = NULL                                  => -0.0009091089,
	                                                                     -0.0009091089);
	
	final_score_77_c335 := map(
	    c_popover18 = ''                           								=> 0.0061548883,
	    NULL < (real)c_popover18 AND (real)c_popover18 <= 1521.5 	=> 0.0152715791,
	    (real)c_popover18 > 1521.5                         				=> -0.0168699817,
																																	 0.0061548883);
	
	final_score_77_c334 := map(
	    NULL < f_rel_educationover8_count_d AND f_rel_educationover8_count_d <= 30.5 => final_score_77_c335,
	    f_rel_educationover8_count_d > 30.5                                          => 0.0510450316,
	    f_rel_educationover8_count_d = NULL                                          => 0.0084558543,
	                                                                                    0.0084558543);
	
	final_score_77 := map(
	    c_span_lang = ''                          							=> -0.0005262575,
	    NULL < (real)c_span_lang AND (real)c_span_lang <= 152.5 => final_score_77_c334,
	    (real)c_span_lang > 152.5                         			=> -0.0108824444,
																																 -0.0005262575);
	
	final_score_78_c338 := map(
	    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => 0.0162443027,
	    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.0610611995,
	    r_f03_input_add_not_most_rec_i = NULL                                           => 0.0292622213,
	                                                                                       0.0292622213);
	
	final_score_78_c337 := map(
	    c_trailer = ''                        							=> 0.0156104865,
	    NULL < (real)c_trailer AND (real)c_trailer <= 123.5 => final_score_78_c338,
	    (real)c_trailer > 123.5                       			=> -0.0066156136,
																													   0.0156104865);
	
	final_score_78 := map(
	    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 3.5 => -0.0069905883,
	    r_d30_derog_count_i > 3.5                                 => final_score_78_c337,
	    r_d30_derog_count_i = NULL                                => -0.0008654354,
	                                                                 -0.0008654354);
	
	final_score_79_c341 := map(
	    c_hh5_p = ''                      								=> 0.0021867324,
	    NULL < (real)c_hh5_p AND (real)c_hh5_p <= 15.55 	=> 0.0062840189,
	    (real)c_hh5_p > 15.55                     				=> -0.0315572506,
																													 0.0021867324);
	
	final_score_79_c340 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => -0.0155044281,
	    f_addrs_per_ssn_i > 7.5                               => final_score_79_c341,
	    f_addrs_per_ssn_i = NULL                              => -0.0027996679,
	                                                             -0.0027996679);
	
	final_score_79 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 7.5 => final_score_79_c340,
	    f_inq_highriskcredit_count24_i > 7.5                                            => 0.0373449681,
	    f_inq_highriskcredit_count24_i = NULL                                           => -0.0014410502,
	                                                                                       -0.0014410502);
	
	final_score_80_c344 := map(
	    c_hh4_p = ''                     								=> -0.0000361315,
	    NULL < (real)c_hh4_p AND (real)c_hh4_p <= 13.3 	=> 0.0270169681,
	    (real)c_hh4_p > 13.3                     				=> -0.0228316941,
																												 -0.0000361315);
	
	final_score_80_c343 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 50.5 => 0.0583100969,
	    r_d32_mos_since_crim_ls_d > 50.5                                       => final_score_80_c344,
	    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0127774739,
	                                                                              0.0127774739);
	
	final_score_80 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => final_score_80_c343,
	    k_comb_age_d > 24.5                          => -0.0089679972,
	    k_comb_age_d = NULL                          => -0.0049534487,
	                                                    -0.0049534487);
	
	final_score_81_c347 := map(
	    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 18.5 => -0.0001711513,
	    f_rel_homeover50_count_d > 18.5                                      => 0.0336890901,
	    f_rel_homeover50_count_d = NULL                                      => 0.0063353998,
	                                                                            0.0063353998);
	
	final_score_81_c346 := map(
	    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -6243.5 => 0.0550800226,
	    f_addrchangevaluediff_d > -6243.5                                     => final_score_81_c347,
	    f_addrchangevaluediff_d = NULL                                        => 0.0064734044,
	                                                                             0.0085846638);
	
	final_score_81 := map(
	    c_construction = ''                             							=> 0.0016146579,
	    NULL < (real)c_construction AND (real)c_construction <= 11.35 => final_score_81_c346,
	    (real)c_construction > 11.35                            			=> -0.0122576840,
																																			 0.0016146579);
	
	final_score_82_c350 := map(
	    C_INC_100K_P = ''                           								=> 0.0470347909,
	    NULL < (real)C_INC_100K_P AND (real)C_INC_100K_P <= 12.95 	=> 0.0177841020,
	    (real)C_INC_100K_P > 12.95                          				=> 0.0923191907,
																																		 0.0470347909);
	
	final_score_82_c349 := map(
	    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.1425328496 => 0.0021427068,
	    f_add_curr_nhood_mfd_pct_i > 0.1425328496                                        => final_score_82_c350,
	    f_add_curr_nhood_mfd_pct_i = NULL                                                => 0.0056782877,
	                                                                                        0.0232479133);
	
	final_score_82 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => final_score_82_c349,
	    k_comb_age_d > 24.5                          => -0.0024669941,
	    k_comb_age_d = NULL                          => 0.0023569439,
	                                                    0.0023569439);
	
	final_score_83_c352 := map(
	    NULL < f_attr_arrests_i AND f_attr_arrests_i <= 0.5 => -0.0029390605,
	    f_attr_arrests_i > 0.5                              => 0.0368461372,
	    f_attr_arrests_i = NULL                             => -0.0011386754,
	                                                           -0.0011386754);
	
	final_score_83_c353 := map(
	    c_construction = ''                            								=> 0.0125615481,
	    NULL < (real)c_construction AND (real)c_construction <= 6.15 	=> 0.0328888882,
	    (real)c_construction > 6.15                            				=> -0.0098447247,
																																			 0.0125615481);
	
	final_score_83 := map(
	    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => final_score_83_c352,
	    k_inq_per_ssn_i > 3.5                             => final_score_83_c353,
	    k_inq_per_ssn_i = NULL                            => 0.0001228741,
	                                                         0.0001228741);
	
	final_score_84_c356 := map(
	    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 2.5 => -0.0027814228,
	    r_d32_criminal_count_i > 2.5                                    => 0.0287356608,
	    r_d32_criminal_count_i = NULL                                   => 0.0025017877,
	                                                                       0.0025017877);
	
	final_score_84_c355 := map(
	    c_trailer = ''                        							=> -0.0049848094,
	    NULL < (real)c_trailer AND (real)c_trailer <= 115.5 => final_score_84_c356,
	    (real)c_trailer > 115.5                       			=> -0.0138525110,
																														 -0.0049848094);
	
	final_score_84 := map(
	    c_hval_100k_p = ''                           								=> -0.0034733922,
	    NULL < (real)c_hval_100k_p AND (real)c_hval_100k_p <= 37.2 	=> final_score_84_c355,
	    (real)c_hval_100k_p > 37.2                           				=> 0.0450418506,
																																		 -0.0034733922);
	
	final_score_85_c358 := map(
	    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 91.5 => 0.0390255813,
	    r_d32_mos_since_fel_ls_d > 91.5                                      => -0.0058454705,
	    r_d32_mos_since_fel_ls_d = NULL                                      => -0.0045154001,
	                                                                            -0.0045154001);
	
	final_score_85_c359 := map(
	    c_very_rich = ''                         								=> 0.0247364562,
	    NULL < (real)c_very_rich AND (real)c_very_rich <= 96.5 	=> -0.0092598236,
	    (real)c_very_rich > 96.5                         				=> 0.0556421652,
																																 0.0247364562);
	
	final_score_85 := map(
	    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 21.5 => final_score_85_c358,
	    f_rel_educationover12_count_d > 21.5                                           => final_score_85_c359,
	    f_rel_educationover12_count_d = NULL                                           => 0.0371315328,
	                                                                                      -0.0008017343);
	
	final_score_86_c362 := map(
	    c_hval_60k_p = ''                         							=> 0.0357066017,
	    NULL < (real)c_hval_60k_p AND (real)c_hval_60k_p <= 0.2 => 0.0661941474,
	    (real)c_hval_60k_p > 0.2                          			=> 0.0057107906,
																																 0.0357066017);
	
	final_score_86_c361 := map(
	    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 3.5 => -0.0069537874,
	    r_d30_derog_count_i > 3.5                                 => final_score_86_c362,
	    r_d30_derog_count_i = NULL                                => 0.0121698353,
	                                                                 0.0121698353);
	
	final_score_86 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 21.5 => -0.0000721068,
	    f_addrs_per_ssn_i > 21.5                               => final_score_86_c361,
	    f_addrs_per_ssn_i = NULL                               => 0.0016324674,
	                                                              0.0016324674);
	
	final_score_87_c365 := map(
	    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 55188 => 0.0659068670,
	    f_curraddrmedianincome_d > 55188                                      => 0.0004988147,
	    f_curraddrmedianincome_d = NULL                                       => 0.0351507295,
	                                                                             0.0351507295);
	
	final_score_87_c364 := map(
	    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 9 => final_score_87_c365,
	    r_i61_inq_collection_recency_d > 9                                            => 0.0005917060,
	    r_i61_inq_collection_recency_d = NULL                                         => 0.0048107372,
	                                                                                     0.0048107372);
	
	final_score_87 := map(
	    c_trailer_p = ''                         								=> -0.0022315552,
	    NULL < (real)c_trailer_p AND (real)c_trailer_p <= 2.95 	=> final_score_87_c364,
	    (real)c_trailer_p > 2.95                         				=> -0.0160918299,
																																 -0.0022315552);
	
	final_score_88_c368 := map(
	    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 2.5 => 0.0482621942,
	    f_crim_rel_under25miles_cnt_i > 2.5                                           => 0.0013695822,
	    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0256909756,
	                                                                                     0.0256909756);
	
	final_score_88_c367 := map(
	    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => 0.0033886566,
	    r_d32_criminal_count_i > 0.5                                    => final_score_88_c368,
	    r_d32_criminal_count_i = NULL                                   => 0.0114211845,
	                                                                       0.0114211845);
	
	final_score_88 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 35.5 => final_score_88_c367,
	    k_comb_age_d > 35.5                          => -0.0106752646,
	    k_comb_age_d = NULL                          => 0.0014585920,
	                                                    0.0014585920);
	
	final_score_89_c370 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 75 => 0.0007887448,
	    r_f01_inp_addr_address_score_d > 75                                            => -0.0045953673,
	    r_f01_inp_addr_address_score_d = NULL                                          => -0.0041409019,
	                                                                                      -0.0041409019);
	
	final_score_89_c371 := map(
	    c_high_ed = ''                        								=> 0.0276232972,
	    NULL < (real)c_high_ed AND (real)c_high_ed <= 18.25 	=> 0.0045491789,
	    (real)c_high_ed > 18.25                       				=> 0.0552298315,
																															 0.0276232972);
	
	final_score_89 := map(
	    NULL < r_i60_inq_hiriskcred_count12_i AND r_i60_inq_hiriskcred_count12_i <= 1.5 => final_score_89_c370,
	    r_i60_inq_hiriskcred_count12_i > 1.5                                            => final_score_89_c371,
	    r_i60_inq_hiriskcred_count12_i = NULL                                           => -0.0021566396,
	                                                                                       -0.0021566396);
	
	final_score_90_c373 := map(
	    c_highinc = ''                       							 => -0.0000630547,
	    NULL < (real)c_highinc AND (real)c_highinc <= 5.45 => 0.0132186382,
	    (real)c_highinc > 5.45                      			 => -0.0086622495,
																														-0.0000630547);
	
	final_score_90_c374 := map(
	    c_unemp = ''                     								=> 0.0197889293,
	    NULL < (real)c_unemp AND (real)c_unemp <= 4.15 	=> -0.0185295040,
	    (real)c_unemp > 4.15                     				=> 0.0444396412,
																												 0.0197889293);
	
	final_score_90 := map(
	    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 1.5 => final_score_90_c373,
	    k_inq_addrs_per_ssn_i > 1.5                                   => final_score_90_c374,
	    k_inq_addrs_per_ssn_i = NULL                                  => 0.0012131090,
	                                                                     0.0012131090);
	
	final_score_91_c377 := map(
	    c_amus_indx = ''                          							=> 0.0042417136,
	    NULL < (real)c_amus_indx AND (real)c_amus_indx <= 104.5 => 0.0105092661,
	    (real)c_amus_indx > 104.5                         			=> -0.0210802055,
																																 0.0042417136);
	
	final_score_91_c376 := map(
	    c_white_col = ''                          								=> 0.0075197579,
	    NULL < (real)c_white_col AND (real)c_white_col <= 51.15 	=> final_score_91_c377,
	    (real)c_white_col > 51.15                         				=> 0.0508244493,
																																	 0.0075197579);
	
	final_score_91 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 8.5 => -0.0086205900,
	    f_addrs_per_ssn_i > 8.5                               => final_score_91_c376,
	    f_addrs_per_ssn_i = NULL                              => 0.0022598232,
	                                                             0.0022598232);
	
	final_score_92_c380 := map(
	    c_medi_indx = ''                         								=> 0.0296326294,
	    NULL < (real)c_medi_indx AND (real)c_medi_indx <= 95.5 	=> 0.0873205899,
	    (real)c_medi_indx > 95.5                         				=> 0.0169994133,
																																 0.0296326294);
	
	final_score_92_c379 := map(
	    c_health = ''                       							=> 0.0072296992,
	    NULL < (real)c_health AND (real)c_health <= 14.65 => -0.0005685537,
	    (real)c_health > 14.65                      			=> final_score_92_c380,
																													 0.0072296992);
	
	final_score_92 := map(
	    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_92_c379,
	    f_corrphonelastnamecount_d > 0.5                                        => -0.0135732564,
	    f_corrphonelastnamecount_d = NULL                                       => -0.0007621900,
	                                                                               -0.0007621900);
	
	final_score_93_c383 := map(
	    NULL < f_hh_tot_derog_i AND f_hh_tot_derog_i <= 1.5 => 0.0175247008,
	    f_hh_tot_derog_i > 1.5                              => 0.0690440875,
	    f_hh_tot_derog_i = NULL                             => 0.0420312199,
	                                                           0.0420312199);
	
	final_score_93_c382 := map(
	    c_med_rent = ''                       							=> 0.0194089129,
	    NULL < (real)c_med_rent AND (real)c_med_rent <= 798 => final_score_93_c383,
	    (real)c_med_rent > 798                        			=> -0.0017959562,
																														 0.0194089129);
	
	final_score_93 := map(
	    c_blue_empl = ''                         								=> 0.0015090199,
	    NULL < (real)c_blue_empl AND (real)c_blue_empl <= 56.5 	=> final_score_93_c382,
	    (real)c_blue_empl > 56.5                         				=> -0.0027707876,
																																 0.0015090199);
	
	final_score_94_c386 := map(
	    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 1.5 => 0.0118988452,
	    f_hh_age_18_plus_d > 1.5                                => -0.0116447256,
	    f_hh_age_18_plus_d = NULL                               => -0.0041553248,
	                                                               -0.0041553248);
	
	final_score_94_c385 := map(
	    NULL < f_inq_quizprovider_count24_i AND f_inq_quizprovider_count24_i <= 1.5 => final_score_94_c386,
	    f_inq_quizprovider_count24_i > 1.5                                          => 0.0540890322,
	    f_inq_quizprovider_count24_i = NULL                                         => -0.0025480561,
	                                                                                   -0.0025480561);
	
	final_score_94 := map(
	    c_hval_80k_p = ''                           							=> -0.0007577433,
	    NULL < (real)c_hval_80k_p AND (real)c_hval_80k_p <= 33.35 => final_score_94_c385,
	    (real)c_hval_80k_p > 33.35                          			=> 0.0479967606,
																																	 -0.0007577433);
	
	final_score_95_c389 := map(
	    c_born_usa = ''                         							=> -0.0030097456,
	    NULL < (real)c_born_usa AND (real)c_born_usa <= 186.5 => -0.0050189769,
	    (real)c_born_usa > 186.5                        			=> 0.0385184761,
																															 -0.0030097456);
	
	final_score_95_c388 := map(
	    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 2.5 => final_score_95_c389,
	    r_i61_inq_collection_count12_i > 2.5                                            => 0.0411167694,
	    r_i61_inq_collection_count12_i = NULL                                           => -0.0008586820,
	                                                                                       -0.0008586820);
	
	final_score_95 := map(
	    c_femdiv_p = ''                         								=> -0.0033065121,
	    NULL < (real)c_femdiv_p AND (real)c_femdiv_p <= 10.35 	=> final_score_95_c388,
	    (real)c_femdiv_p > 10.35                        				=> -0.0422445695,
																																 -0.0033065121);
	
	final_score_96_c392 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.0498022368,
	    r_f01_inp_addr_address_score_d > 16                                            => -0.0012293404,
	    r_f01_inp_addr_address_score_d = NULL                                          => 0.0018939615,
	                                                                                      0.0018939615);
	
	final_score_96_c391 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 24.5 => 0.0279363612,
	    k_comb_age_d > 24.5                          => final_score_96_c392,
	    k_comb_age_d = NULL                          => 0.0071885320,
	                                                    0.0071885320);
	
	final_score_96 := map(
	    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_96_c391,
	    f_corrphonelastnamecount_d > 0.5                                        => -0.0150256625,
	    f_corrphonelastnamecount_d = NULL                                       => -0.0014913345,
	                                                                               -0.0014913345);
	
	final_score_97_c395 := map(
	    c_civ_emp = ''                        							=> 0.0008342606,
	    NULL < (real)c_civ_emp AND (real)c_civ_emp <= 58.05 => 0.0157287156,
	    (real)c_civ_emp > 58.05                       			=> -0.0075498249,
																														 0.0008342606);
	
	final_score_97_c394 := map(
	    C_INC_25K_P = ''                          							=> -0.0041877406,
	    NULL < (real)C_INC_25K_P AND (real)C_INC_25K_P <= 15.35 => final_score_97_c395,
	    (real)C_INC_25K_P > 15.35                         			=> -0.0205120283,
																																 -0.0041877406);
	
	final_score_97 := map(
	    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 18 => 0.0408527912,
	    r_d33_eviction_recency_d > 18                                      => final_score_97_c394,
	    r_d33_eviction_recency_d = NULL                                    => -0.0028726886,
	                                                                          -0.0028726886);
	
	final_score_98_c397 := map(
	    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 1.5 => -0.0102819100,
	    r_l79_adls_per_addr_curr_i > 1.5                                        => 0.0307874940,
	    r_l79_adls_per_addr_curr_i = NULL                                       => 0.0125782189,
	                                                                               0.0125782189);
	
	final_score_98_c398 := map(
	    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 1.5 => 0.0488431390,
	    f_rel_under100miles_cnt_d > 1.5                                       => 0.0007626917,
	    f_rel_under100miles_cnt_d = NULL                                      => 0.0041086835,
	                                                                             0.0041086835);
	
	final_score_98 := map(
	    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 3.5 => -0.0143730576,
	    r_p88_phn_dst_to_inp_add_i > 3.5                                        => final_score_98_c397,
	    r_p88_phn_dst_to_inp_add_i = NULL                                       => final_score_98_c398,
	                                                                               -0.0013809718);
	
	final_score_99_c401 := map(
	    NULL < f_historical_count_d AND f_historical_count_d <= 2.5 => 0.0206351119,
	    f_historical_count_d > 2.5                                  => -0.0208061445,
	    f_historical_count_d = NULL                                 => 0.0098614874,
	                                                                   0.0098614874);
	
	final_score_99_c400 := map(
	    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => final_score_99_c401,
	    f_phone_ver_insurance_d > 2.5                                     => -0.0118333230,
	    f_phone_ver_insurance_d = NULL                                    => 0.0105856763,
	                                                                         0.0002386346);
	
	final_score_99 := map(
	    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 8.5 => final_score_99_c400,
	    f_inq_highriskcredit_count24_i > 8.5                                            => 0.0315820080,
	    f_inq_highriskcredit_count24_i = NULL                                           => 0.0011764927,
	                                                                                       0.0011764927);
	
	final_score_100_c403 := map(
	    NULL < r_d33_eviction_recency_d AND r_d33_eviction_recency_d <= 30 => 0.0371004011,
	    r_d33_eviction_recency_d > 30                                      => -0.0097277829,
	    r_d33_eviction_recency_d = NULL                                    => -0.0077548685,
	                                                                          -0.0077548685);
	
	final_score_100_c404 := map(
	    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 1.5 => 0.0132379994,
	    r_i61_inq_collection_count12_i > 1.5                                            => 0.0690981237,
	    r_i61_inq_collection_count12_i = NULL                                           => 0.0184140293,
	                                                                                       0.0184140293);
	
	final_score_100 := map(
	    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 2.5 => final_score_100_c403,
	    r_l79_adls_per_addr_c6_i > 2.5                                      => final_score_100_c404,
	    r_l79_adls_per_addr_c6_i = NULL                                     => -0.0005340709,
	                                                                           -0.0005340709);
	
	final_score_101_c407 := map(
	    c_pop_0_5_p = ''                         								=> 0.0247655891,
	    NULL < (real)c_pop_0_5_p AND (real)c_pop_0_5_p <= 9.55 	=> -0.0010553473,
	    (real)c_pop_0_5_p > 9.55                         				=> 0.0612489022,
																																 0.0247655891);
	
	final_score_101_c406 := map(
	    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => -0.0152977643,
	    f_hh_lienholders_i > 0.5                                => final_score_101_c407,
	    f_hh_lienholders_i = NULL                               => 0.0047136988,
	                                                               0.0047136988);
	
	final_score_101 := map(
	    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= 31938.5 => -0.0073225954,
	    f_addrchangevaluediff_d > 31938.5                                     => 0.0411981084,
	    f_addrchangevaluediff_d = NULL                                        => final_score_101_c406,
	                                                                             -0.0028864679);
	
	final_score_102_c410 := map(
	    NULL < f_phones_per_addr_c6_i AND f_phones_per_addr_c6_i <= 3.5 => -0.0058922112,
	    f_phones_per_addr_c6_i > 3.5                                    => 0.0361151642,
	    f_phones_per_addr_c6_i = NULL                                   => -0.0039124486,
	                                                                       -0.0039124486);
	
	final_score_102_c409 := map(
	    NULL < f_inq_quizprovider_count24_i AND f_inq_quizprovider_count24_i <= 1.5 => final_score_102_c410,
	    f_inq_quizprovider_count24_i > 1.5                                          => 0.0370161257,
	    f_inq_quizprovider_count24_i = NULL                                         => -0.0026656748,
	                                                                                   -0.0026656748);
	
	final_score_102 := map(
	    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 21.5 => final_score_102_c409,
	    r_s66_adlperssn_count_i > 21.5                                     => 0.0341789770,
	    r_s66_adlperssn_count_i = NULL                                     => -0.0011476276,
	                                                                          -0.0011476276);
	
	final_score_103_c413 := map(
	    NULL < f_rel_ageover20_count_d AND f_rel_ageover20_count_d <= 19.5 => 0.0146245507,
	    f_rel_ageover20_count_d > 19.5                                     => 0.0705133234,
	    f_rel_ageover20_count_d = NULL                                     => 0.0269561380,
	                                                                          0.0269561380);
	
	final_score_103_c412 := map(
	    NULL < r_a50_pb_average_dollars_d AND r_a50_pb_average_dollars_d <= 201.5 => -0.0205146885,
	    r_a50_pb_average_dollars_d > 201.5                                        => final_score_103_c413,
	    r_a50_pb_average_dollars_d = NULL                                         => 0.0116363790,
	                                                                                 0.0116363790);
	
	final_score_103 := map(
	    c_pop_55_64_p = ''                            							=> -0.0015269720,
	    NULL < (real)c_pop_55_64_p AND (real)c_pop_55_64_p <= 11.65 => -0.0069981206,
	    (real)c_pop_55_64_p > 11.65                           			=> final_score_103_c412,
																																		 -0.0015269720);
	
	final_score_104_c416 := map(
	    c_health = ''                       							=> -0.0008754590,
	    NULL < (real)c_health AND (real)c_health <= 14.05 => -0.0072938823,
	    (real)c_health > 14.05                      			=> 0.0151466756,
																													 -0.0008754590);
	
	final_score_104_c415 := map(
	    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.19373113225 => final_score_104_c416,
	    f_add_curr_nhood_bus_pct_i > 0.19373113225                                        => -0.0313245639,
	    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.0358686277,
	                                                                                         -0.0014799485);
	
	final_score_104 := map(
	    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 26.5 => final_score_104_c415,
	    f_rel_educationover12_count_d > 26.5                                           => 0.0343298475,
	    f_rel_educationover12_count_d = NULL                                           => 0.0314219996,
	                                                                                      0.0009935261);
	
	final_score_105_c419 := map(
	    c_mort_indx = ''                         								=> 0.0035182944,
	    NULL < (real)c_mort_indx AND (real)c_mort_indx <= 50.5 	=> 0.0363641180,
	    (real)c_mort_indx > 50.5                         				=> -0.0013976548,
																																 0.0035182944);
	
	final_score_105_c418 := map(
	    NULL < f_crim_rel_under25miles_cnt_i AND f_crim_rel_under25miles_cnt_i <= 4.5 => final_score_105_c419,
	    f_crim_rel_under25miles_cnt_i > 4.5                                           => -0.0187073905,
	    f_crim_rel_under25miles_cnt_i = NULL                                          => 0.0152112933,
	                                                                                     0.0003357533);
	
	final_score_105 := map(
	    c_totcrime = ''                         							=> 0.0016723029,
	    NULL < (real)c_totcrime AND (real)c_totcrime <= 190.5 => final_score_105_c418,
	    (real)c_totcrime > 190.5                        			=> 0.0353044314,
																															 0.0016723029);
	
	final_score_106_c421 := map(
	    NULL < r_s65_ssn_problem_i AND r_s65_ssn_problem_i <= 0.5 => -0.0022327841,
	    r_s65_ssn_problem_i > 0.5                                 => -0.0206974177,
	    r_s65_ssn_problem_i = NULL                                => -0.0046497756,
	                                                                 -0.0046497756);
	
	final_score_106_c422 := map(
	    c_larceny = ''                        							=> 0.0242560963,
	    NULL < (real)c_larceny AND (real)c_larceny <= 161.5 => -0.0117478793,
	    (real)c_larceny > 161.5                       			=> 0.0623258738,
																														 0.0242560963);
	
	final_score_106 := map(
	    c_no_car = ''                       							=> -0.0028372915,
	    NULL < (real)c_no_car AND (real)c_no_car <= 184.5 => final_score_106_c421,
	    (real)c_no_car > 184.5                      			=> final_score_106_c422,
																													 -0.0028372915);
	
	final_score_107_c425 := map(
	    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 17.5 => 0.0414817743,
	    f_prevaddrageoldest_d > 17.5                                   => -0.0274567334,
	    f_prevaddrageoldest_d = NULL                                   => -0.0000959249,
	                                                                      -0.0000959249);
	
	final_score_107_c424 := map(
	    c_serv_empl = ''                         	 							=> 0.0195231812,
	    NULL < (real)c_serv_empl AND (real)c_serv_empl <= 102.5 => 0.0535914940,
	    (real)c_serv_empl > 102.5                         			=> final_score_107_c425,
																																 0.0195231812);
	
	final_score_107 := map(
	    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 176.5 => -0.0032401472,
	    f_curraddrmurderindex_i > 176.5                                     => final_score_107_c424,
	    f_curraddrmurderindex_i = NULL                                      => -0.0009145530,
	                                                                           -0.0009145530);
	
	final_score_108_c428 := map(
	    c_white_col = ''                          							=> 0.0397559806,
	    NULL < (real)c_white_col AND (real)c_white_col <= 47.65 => 0.0159203649,
	    (real)c_white_col > 47.65                         			=> 0.1051914917,
																															   0.0397559806);
	
	final_score_108_c427 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 7.5 => -0.0277002619,
	    f_addrs_per_ssn_i > 7.5                               => final_score_108_c428,
	    f_addrs_per_ssn_i = NULL                              => 0.0216185747,
	                                                             0.0216185747);
	
	final_score_108 := map(
	    C_INC_125K_P = ''                           							=> -0.0001282793,
	    NULL < (real)C_INC_125K_P AND (real)C_INC_125K_P <= 13.05 => -0.0035494154,
	    (real)C_INC_125K_P > 13.05                          			=> final_score_108_c427,
																																	 -0.0001282793);
	
	final_score_109_c431 := map(
	    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 37.5 => -0.0154897778,
	    r_c13_curr_addr_lres_d > 37.5                                    => 0.0120967534,
	    r_c13_curr_addr_lres_d = NULL                                    => -0.0023983358,
	                                                                        -0.0023983358);
	
	final_score_109_c430 := map(
	    c_no_car = ''                      								=> 0.0061814930,
	    NULL < (real)c_no_car AND (real)c_no_car <= 91.5 	=> 0.0222497519,
	    (real)c_no_car > 91.5                      				=> final_score_109_c431,
																													 0.0061814930);
	
	final_score_109 := map(
	    c_families = ''                         							=> 0.0006934524,
	    NULL < (real)c_families AND (real)c_families <= 571.5 => final_score_109_c430,
	    (real)c_families > 571.5                        			=> -0.0179658857,
																															 0.0006934524);
	
	final_score_110_c433 := map(
	    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 21.5 => -0.0026081422,
	    r_s66_adlperssn_count_i > 21.5                                     => 0.0239224862,
	    r_s66_adlperssn_count_i = NULL                                     => -0.0015830790,
	                                                                          -0.0015830790);
	
	final_score_110_c434 := map(
	    c_lowrent = ''                      							=> 0.0412048694,
	    NULL < (real)c_lowrent AND (real)c_lowrent <= 7.1 => -0.0091481163,
	    (real)c_lowrent > 7.1                       			=> 0.0744444220,
																													 0.0412048694);
	
	final_score_110 := map(
	    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 6.5 => final_score_110_c433,
	    f_hh_age_18_plus_d > 6.5                                => final_score_110_c434,
	    f_hh_age_18_plus_d = NULL                               => 0.0011562951,
	                                                               0.0011562951);
	
	final_score_111_c437 := map(
	    NULL < f_fp_prevaddrcrimeindex_i AND f_fp_prevaddrcrimeindex_i <= 189 => -0.0019117206,
	    f_fp_prevaddrcrimeindex_i > 189                                       => 0.0468048402,
	    f_fp_prevaddrcrimeindex_i = NULL                                      => 0.0001982162,
	                                                                             0.0001982162);
	
	final_score_111_c436 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 9.5 => -0.0162657296,
	    f_addrs_per_ssn_i > 9.5                               => final_score_111_c437,
	    f_addrs_per_ssn_i = NULL                              => -0.0059779692,
	                                                             -0.0059779692);
	
	final_score_111 := map(
	    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 25.5 => final_score_111_c436,
	    f_rel_educationover12_count_d > 25.5                                           => 0.0299258466,
	    f_rel_educationover12_count_d = NULL                                           => 0.0324171140,
	                                                                                      -0.0032565380);
	
	final_score_112_c440 := map(
	    c_old_homes = ''                         								=> 0.0316611434,
	    NULL < (real)c_old_homes AND (real)c_old_homes <= 74.5 	=> -0.0067241548,
	    (real)c_old_homes > 74.5                         				=> 0.0638930732,
																																 0.0316611434);
	
	final_score_112_c439 := map(
	    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 81.5 => -0.0099026017,
	    r_c13_max_lres_d > 81.5                              => final_score_112_c440,
	    r_c13_max_lres_d = NULL                              => 0.0170307051,
	                                                            0.0170307051);
	
	final_score_112 := map(
	    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => 0.0003570526,
	    k_inq_per_ssn_i > 3.5                             => final_score_112_c439,
	    k_inq_per_ssn_i = NULL                            => 0.0019172330,
	                                                         0.0019172330);
	
	final_score_113_c443 := map(
	    NULL < f_rel_count_i AND f_rel_count_i <= 12.5 => -0.0152813936,
	    f_rel_count_i > 12.5                           => 0.0534850683,
	    f_rel_count_i = NULL                           => 0.0173769261,
	                                                      0.0173769261);
	
	final_score_113_c442 := map(
	    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => 0.0205680324,
	    f_phone_ver_insurance_d > 2.5                                     => -0.0081872805,
	    f_phone_ver_insurance_d = NULL                                    => final_score_113_c443,
	                                                                         0.0067601146);
	
	final_score_113 := map(
	    c_construction = ''                            								=> -0.0021717488,
	    NULL < (real)c_construction AND (real)c_construction <= 5.25 	=> final_score_113_c442,
	    (real)c_construction > 5.25                            				=> -0.0099625740,
																																			 -0.0021717488);
	
	final_score_114_c446 := map(
	    NULL < k_estimated_income_d AND k_estimated_income_d <= 31500 => 0.0500495273,
	    k_estimated_income_d > 31500                                  => 0.0065628504,
	    k_estimated_income_d = NULL                                   => 0.0161353894,
	                                                                     0.0161353894);
	
	final_score_114_c445 := map(
	    NULL < f_crim_rel_under500miles_cnt_i AND f_crim_rel_under500miles_cnt_i <= 4.5 => final_score_114_c446,
	    f_crim_rel_under500miles_cnt_i > 4.5                                            => -0.0155458717,
	    f_crim_rel_under500miles_cnt_i = NULL                                           => 0.0068223366,
	                                                                                       0.0068223366);
	
	final_score_114 := map(
	    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 0.5 => -0.0035768038,
	    k_inq_addrs_per_ssn_i > 0.5                                   => final_score_114_c445,
	    k_inq_addrs_per_ssn_i = NULL                                  => -0.0006318002,
	                                                                     -0.0006318002);
	
	final_score_115_c449 := map(
	    NULL < f_util_add_curr_inf_n AND f_util_add_curr_inf_n <= 0.5 => -0.0005114925,
	    f_util_add_curr_inf_n > 0.5                                   => 0.0559484934,
	    f_util_add_curr_inf_n = NULL                                  => 0.0015809428,
	                                                                     0.0015809428);
	
	final_score_115_c448 := map(
	    NULL < f_addrs_per_ssn_c6_i AND f_addrs_per_ssn_c6_i <= 0.5 => final_score_115_c449,
	    f_addrs_per_ssn_c6_i > 0.5                                  => -0.0151684876,
	    f_addrs_per_ssn_c6_i = NULL                                 => -0.0013766379,
	                                                                   -0.0013766379);
	
	final_score_115 := map(
		   c_rnt750_p = ''                         							=> 0.0004233378,
	    NULL < (real)c_rnt750_p AND (real)c_rnt750_p <= 72.65 => final_score_115_c448,
	    (real)c_rnt750_p > 72.65                        			=> 0.0415120693,
																															 0.0004233378);
	
	final_score_116_c452 := map(
	    c_white_col = ''                          							=> 0.0060471808,
	    NULL < (real)c_white_col AND (real)c_white_col <= 50.45 => 0.0028456928,
	    (real)c_white_col > 50.45                         			=> 0.0663377974,
																																 0.0060471808);
	
	final_score_116_c451 := map(
	    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.5391095917 => final_score_116_c452,
	    f_add_curr_nhood_mfd_pct_i > 0.5391095917                                        => -0.0209127821,
	    f_add_curr_nhood_mfd_pct_i = NULL                                                => -0.0072331511,
	                                                                                        -0.0003596866);
	
	final_score_116 := map(
	    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 9.5 => final_score_116_c451,
	    f_divssnidmsrcurelcount_i > 9.5                                       => 0.0425018177,
	    f_divssnidmsrcurelcount_i = NULL                                      => 0.0013154352,
	                                                                             0.0013154352);
	
	final_score_117_c455 := map(
	    r_a49_curr_avm_chg_1yr_pct_i = NULL                                           => -0.0057855409,
	    NULL < r_a49_curr_avm_chg_1yr_pct_i AND (DECIMAL8_1)r_a49_curr_avm_chg_1yr_pct_i <= 122.8 => -0.0279191425,
	    r_a49_curr_avm_chg_1yr_pct_i > 122.8                                          => 0.0392060739,
	                                                                                     -0.0097448404);
	
	final_score_117_c454 := map(
	    c_hval_100k_p = ''                            							=> -0.0034153381,
	    NULL < (real)c_hval_100k_p AND (real)c_hval_100k_p <= 12.05 => final_score_117_c455,
	    (real)c_hval_100k_p > 12.05                           			=> 0.0149785391,
																																		 -0.0034153381);
	
	final_score_117 := map(
	    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 1.5 => final_score_117_c454,
	    k_inq_addrs_per_ssn_i > 1.5                                   => 0.0253916933,
	    k_inq_addrs_per_ssn_i = NULL                                  => -0.0015063092,
	                                                                     -0.0015063092);
	
	final_score_118_c457 := map(
	    c_hval_150k_p = ''                            							=> -0.0222840632,
	    NULL < (real)c_hval_150k_p AND (real)c_hval_150k_p <= 18.75 => -0.0299864632,
	    (real)c_hval_150k_p > 18.75                           			=> 0.0353005463,
																																		 -0.0222840632);
	
	final_score_118_c458 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 10.5 => -0.0026453403,
	    f_addrs_per_ssn_i > 10.5                               => 0.0111905944,
	    f_addrs_per_ssn_i = NULL                               => 0.0044589923,
	                                                              0.0044589923);
	
	final_score_118 := map(
	    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 3.5 => final_score_118_c457,
	    f_sourcerisktype_i > 3.5                                => final_score_118_c458,
	    f_sourcerisktype_i = NULL                               => -0.0015541595,
	                                                               -0.0015541595);
	
	final_score_119_c461 := map(
	    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.10328460755 => -0.0031864880,
	    f_add_curr_nhood_bus_pct_i > 0.10328460755                                        => 0.0265470340,
	    f_add_curr_nhood_bus_pct_i = NULL                                                 => -0.0014066645,
	                                                                                         -0.0014066645);
	
	final_score_119_c460 := map(
	    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.10432422765 => final_score_119_c461,
	    f_add_input_nhood_bus_pct_i > 0.10432422765                                         => -0.0213099866,
	    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0237127881,
	                                                                                           -0.0041791174);
	
	final_score_119 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 5.5 => 0.0306088634,
	    r_d32_mos_since_crim_ls_d > 5.5                                       => final_score_119_c460,
	    r_d32_mos_since_crim_ls_d = NULL                                      => -0.0026723099,
	                                                                             -0.0026723099);
	
	final_score_120_c463 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => -0.0070506469,
	    r_f01_inp_addr_address_score_d > 95                                            => -0.0005233700,
	    r_f01_inp_addr_address_score_d = NULL                                          => -0.0012716531,
	                                                                                      -0.0012716531);
	
	final_score_120_c464 := map(
	    c_relig_indx = ''                           							=> 0.0245033255,
	    NULL < (real)c_relig_indx AND (real)c_relig_indx <= 122.5 => -0.0024291363,
	    (real)c_relig_indx > 122.5                          			=> 0.0640940443,
																																	 0.0245033255);
	
	final_score_120 := map(
	    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_120_c463,
	    r_d32_felony_count_i > 0.5                                  => final_score_120_c464,
	    r_d32_felony_count_i = NULL                                 => 0.0003522745,
	                                                                   0.0003522745);
	
	final_score_121_c467 := map(
	    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.11224595175 => 0.0016747659,
	    f_add_input_nhood_bus_pct_i > 0.11224595175                                         => 0.0402056781,
	    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0087706982,
	                                                                                           0.0087706982);
	
	final_score_121_c466 := map(
	    c_food = ''                     							=> -0.0074746774,
	    NULL < (real)c_food AND (real)c_food <= 43.25 => -0.0103743896,
	    (real)c_food > 43.25                    			=> final_score_121_c467,
																											 -0.0074746774);
	
	final_score_121 := map(
	    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 21.5 => final_score_121_c466,
	    r_s66_adlperssn_count_i > 21.5                                     => 0.0116605563,
	    r_s66_adlperssn_count_i = NULL                                     => -0.0066435367,
	                                                                          -0.0066435367);
	
	final_score_122_c470 := map(
	    c_young = ''                      							=> 0.0274221755,
	    NULL < (real)c_young AND (real)c_young <= 22.65 => 0.0599288912,
	    (real)c_young > 22.65                     			=> 0.0015418288,
																												 0.0274221755);
	
	final_score_122_c469 := map(
	    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 2.5 => -0.0012380207,
	    f_hh_collections_ct_i > 2.5                                   => final_score_122_c470,
	    f_hh_collections_ct_i = NULL                                  => 0.0026789005,
	                                                                     0.0026789005);
	
	final_score_122 := map(
	    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 4.5 => final_score_122_c469,
	    r_c12_num_nonderogs_d > 4.5                                   => -0.0277441117,
	    r_c12_num_nonderogs_d = NULL                                  => -0.0013902731,
	                                                                     -0.0013902731);
	
	final_score_123_c473 := map(
	    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => 0.0151104552,
	    f_varrisktype_i > 1.5                             => 0.0539595003,
	    f_varrisktype_i = NULL                            => 0.0319573160,
	                                                         0.0319573160);
	
	final_score_123_c472 := map(
	    C_RENTOCC_P = ''                         								=> 0.0184723064,
	    NULL < (real)C_RENTOCC_P AND (real)C_RENTOCC_P <= 69.7 	=> final_score_123_c473,
	    (real)C_RENTOCC_P > 69.7                         				=> -0.0250017545,
																																 0.0184723064);
	
	final_score_123 := map(
	    c_cartheft = ''                         							=> -0.0010742207,
	    NULL < (real)c_cartheft AND (real)c_cartheft <= 176.5 => -0.0042828444,
	    (real)c_cartheft > 176.5                        			=> final_score_123_c472,
																															 -0.0010742207);
	
	final_score_124_c476 := map(
	    NULL < f_rel_homeover150_count_d AND f_rel_homeover150_count_d <= 6.5 => 0.0454590289,
	    f_rel_homeover150_count_d > 6.5                                       => 0.0031130936,
	    f_rel_homeover150_count_d = NULL                                      => 0.0297508729,
	                                                                             0.0297508729);
	
	final_score_124_c475 := map(
	    c_many_cars = ''                         								=> 0.0134025566,
	    NULL < (real)c_many_cars AND (real)c_many_cars <= 94.5 	=> final_score_124_c476,
	    (real)c_many_cars > 94.5                         				=> -0.0069677768,
																																 0.0134025566);
	
	final_score_124 := map(
	    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 2.5 => final_score_124_c475,
	    f_phone_ver_insurance_d > 2.5                                     => -0.0095422563,
	    f_phone_ver_insurance_d = NULL                                    => 0.0043099084,
	                                                                         0.0016643767);
	
	final_score_125_c478 := map(
	    c_pop_75_84_p = ''                           								=> 0.0324283893,
	    NULL < (real)c_pop_75_84_p AND (real)c_pop_75_84_p <= 3.15 	=> 0.0578468252,
	    (real)c_pop_75_84_p > 3.15                           				=> -0.0002524568,
																																		 0.0324283893);
	
	final_score_125_c479 := map(
	    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 0.5 => -0.0074803665,
	    r_d33_eviction_count_i > 0.5                                    => 0.0160750134,
	    r_d33_eviction_count_i = NULL                                   => -0.0038470633,
	                                                                       -0.0038470633);
	
	final_score_125 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 21.5 => final_score_125_c478,
	    k_comb_age_d > 21.5                          => final_score_125_c479,
	    k_comb_age_d = NULL                          => -0.0009576290,
	                                                    -0.0009576290);
	
	final_score_126_c482 := map(
	    c_unattach = ''                         								=> 0.0168163868,
	    NULL < (real)c_unattach AND (real)c_unattach <= 131.5 	=> 0.0382049499,
	    (real)c_unattach > 131.5                        				=> -0.0166613643,
																																 0.0168163868);
	
	final_score_126_c481 := map(
	    c_rental = ''                       								=> -0.0037776550,
	    NULL < (real)c_rental AND (real)c_rental <= 172.5 	=> -0.0079400758,
	    (real)c_rental > 172.5                      				=> final_score_126_c482,
																														 -0.0037776550);
	
	final_score_126 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 29.5 => final_score_126_c481,
	    f_addrs_per_ssn_i > 29.5                               => 0.0281319430,
	    f_addrs_per_ssn_i = NULL                               => -0.0026213380,
	                                                              -0.0026213380);
	
	final_score_127_c485 := map(
	    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) 	=> 0.0044596456,
	    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                     																																=> 0.0553717327,
	    nf_seg_fraudpoint_3_0 = ''                           																																				=> 0.0162009990,
																																																																		 0.0162009990);
	
	final_score_127_c484 := map(
	    NULL < k_comb_age_d AND k_comb_age_d <= 25.5 => final_score_127_c485,
	    k_comb_age_d > 25.5                          => -0.0116747530,
	    k_comb_age_d = NULL                          => -0.0052733787,
	                                                    -0.0052733787);
	
	final_score_127 := map(
	    NULL < r_l80_inp_avm_autoval_d AND r_l80_inp_avm_autoval_d <= 68191 => -0.0255128842,
	    r_l80_inp_avm_autoval_d > 68191                                     => 0.0088422965,
	    r_l80_inp_avm_autoval_d = NULL                                      => final_score_127_c484,
	                                                                           -0.0026938449);
	
	final_score_128_c488 := map(
	    c_unattach = ''                         							=> 0.0419370470,
	    NULL < (real)c_unattach AND (real)c_unattach <= 106.5 => 0.0890315585,
	    (real)c_unattach > 106.5                        			=> 0.0011600918,
																															 0.0419370470);
	
	final_score_128_c487 := map(
	    c_asian_lang = ''                           							=> 0.0032162967,
	    NULL < (real)c_asian_lang AND (real)c_asian_lang <= 181.5 => -0.0009454699,
	    (real)c_asian_lang > 181.5                          			=> final_score_128_c488,
																																	 0.0032162967);
	
	final_score_128 := map(
	    c_pop_55_64_p = ''                           								=> -0.0014342033,
	    NULL < (real)c_pop_55_64_p AND (real)c_pop_55_64_p <= 6.15 	=> -0.0185040829,
	    (real)c_pop_55_64_p > 6.15                           				=> final_score_128_c487,
																																		 -0.0014342033);
	
	final_score_129_c491 := map(
	    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 32.5 => 0.0541909222,
	    r_d32_mos_since_crim_ls_d > 32.5                                       => 0.0109469095,
	    r_d32_mos_since_crim_ls_d = NULL                                       => 0.0191876015,
	                                                                              0.0191876015);
	
	final_score_129_c490 := map(
	    NULL < r_c14_addrs_per_adl_c6_i AND r_c14_addrs_per_adl_c6_i <= 0.5 => -0.0015440652,
	    r_c14_addrs_per_adl_c6_i > 0.5                                      => final_score_129_c491,
	    r_c14_addrs_per_adl_c6_i = NULL                                     => 0.0051912817,
	                                                                           0.0051912817);
	
	final_score_129 := map(
	    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 13.5 => -0.0040553278,
	    f_addrs_per_ssn_i > 13.5                               => final_score_129_c490,
	    f_addrs_per_ssn_i = NULL                               => -0.0001377397,
	                                                              -0.0001377397);
	
	final_score_130_c494 := map(
	    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.0294737379,
	    f_curraddractivephonelist_d > 0.5                                         => -0.0037369978,
	    f_curraddractivephonelist_d = NULL                                        => 0.0164519626,
	                                                                                 0.0164519626);
	
	final_score_130_c493 := map(
	    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 6.5 => final_score_130_c494,
	    f_componentcharrisktype_i > 6.5                                       => -0.0162377947,
	    f_componentcharrisktype_i = NULL                                      => 0.0098754202,
	                                                                             0.0098754202);
	
	final_score_130 := map(
	    NULL < (integer)k_inf_nothing_found_i AND (integer)k_inf_nothing_found_i <= 0.5 	=> -0.0095818705,
	    (integer)k_inf_nothing_found_i > 0.5                                   						=> final_score_130_c493,
	    (string)k_inf_nothing_found_i = ''                                   							=> 0.0003592118,
																																													 0.0003592118);
	
	final_score_131_c497 := map(
	    c_health = ''                    								=> -0.0063633704,
	    NULL < (real)c_health AND (real)c_health <= 16 	=> -0.0201513346,
	    (real)c_health > 16                      				=> 0.0344544641,
																												 -0.0063633704);
	
	final_score_131_c496 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 95 => final_score_131_c497,
	    r_f01_inp_addr_address_score_d > 95                                            => 0.0078047901,
	    r_f01_inp_addr_address_score_d = NULL                                          => 0.0060625238,
	                                                                                      0.0060625238);
	
	final_score_131 := map(
	    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 1.5 => final_score_131_c496,
	    f_corrphonelastnamecount_d > 1.5                                        => -0.0280583578,
	    f_corrphonelastnamecount_d = NULL                                       => 0.0004370736,
	                                                                               0.0004370736);
	
	final_score_132_c500 := map(
	    c_trailer = ''                        							=> -0.0102103470,
	    NULL < (real)c_trailer AND (real)c_trailer <= 139.5 => 0.0060556777,
	    (real)c_trailer > 139.5                       			=> -0.0472155530,
																														 -0.0102103470);
	
	final_score_132_c499 := map(
	    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => final_score_132_c500,
	    r_f01_inp_addr_address_score_d > 85                                            => 0.0019107677,
	    r_f01_inp_addr_address_score_d = NULL                                          => 0.0006552317,
	                                                                                      0.0006552317);
	
	final_score_132 := map(
	    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 5.5 => final_score_132_c499,
	    r_i60_inq_count12_i > 5.5                                 => -0.0319034960,
	    r_i60_inq_count12_i = NULL                                => -0.0003040660,
	                                                                 -0.0003040660);
	
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
	    final_score_111 +
	    final_score_112 +
	    final_score_113 +
	    final_score_114 +
	    final_score_115 +
	    final_score_116 +
	    final_score_117 +
	    final_score_118 +
	    final_score_119 +
	    final_score_120 +
	    final_score_121 +
	    final_score_122 +
	    final_score_123 +
	    final_score_124 +
	    final_score_125 +
	    final_score_126 +
	    final_score_127 +
	    final_score_128 +
	    final_score_129 +
	    final_score_130 +
	    final_score_131 +
	    final_score_132;
	

    pbr := 0.0085;
    sbr := 0.1;
    offset := ln(((1 - pbr)*sbr) / (pbr*(1 - sbr)));

    base := 700;
    pts  := -50;
    lgt  := ln(0.0085/0.9915);


    FP1512_1_0 := round(max(300, min(999, (base + pts*((final_score - offset - lgt)/ln(2))))));


	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.nap_type := nap_type;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_pwssndobflag := rc_pwssndobflag;
		SELF.rc_ssnvalflag := rc_ssnvalflag;
		SELF.rc_pwssnvalflag := rc_pwssnvalflag;
		SELF.rc_ssnmiskeyflag := rc_ssnmiskeyflag;
		SELF.rc_addrmiskeyflag := rc_addrmiskeyflag;
		SELF.rc_disthphoneaddr := rc_disthphoneaddr;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_first_seen := ver_sources_first_seen;
		SELF.fnamepop := fnamepop;
		SELF.lnamepop := lnamepop;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.util_adl_count := util_adl_count;
		SELF.util_add_curr_type_list := util_add_curr_type_list;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_house_number_match := add_input_house_number_match;
		SELF.add_input_owned_not_occ := add_input_owned_not_occ;
		SELF.add_input_occ_index := add_input_occ_index;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_nhood_bus_ct := add_input_nhood_bus_ct;
		SELF.add_input_nhood_sfd_ct := add_input_nhood_sfd_ct;
		SELF.add_input_nhood_mfd_ct := add_input_nhood_mfd_ct;
		SELF.add_input_pop := add_input_pop;
		SELF.add_curr_lres := add_curr_lres;
		SELF.add_curr_occ_index := add_curr_occ_index;
		SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
		SELF.add_curr_avm_auto_val_2 := add_curr_avm_auto_val_2;
		SELF.add_curr_nhood_vac_prop := add_curr_nhood_vac_prop;
		SELF.add_curr_nhood_bus_ct := add_curr_nhood_bus_ct;
		SELF.add_curr_nhood_sfd_ct := add_curr_nhood_sfd_ct;
		SELF.add_curr_nhood_mfd_ct := add_curr_nhood_mfd_ct;
		SELF.add_curr_pop := add_curr_pop;
		SELF.max_lres := max_lres;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.addrs_prison_history := addrs_prison_history;
		SELF.phone_ver_insurance := phone_ver_insurance;
		SELF.inputssncharflag := inputssncharflag;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.adls_per_ssn := adls_per_ssn;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.adls_per_addr_curr := adls_per_addr_curr;
		SELF.phones_per_addr_curr := phones_per_addr_curr;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.addrs_per_adl_c6 := addrs_per_adl_c6;
		SELF.lnames_per_adl_c6 := lnames_per_adl_c6;
		SELF.addrs_per_ssn_c6 := addrs_per_ssn_c6;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.phones_per_addr_c6 := phones_per_addr_c6;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.invalid_ssns_per_adl_c6 := invalid_ssns_per_adl_c6;
		SELF.inq_count03 := inq_count03;
		SELF.inq_count12 := inq_count12;
		SELF.inq_count24 := inq_count24;
		SELF.inq_collection_count := inq_collection_count;
		SELF.inq_collection_count01 := inq_collection_count01;
		SELF.inq_collection_count03 := inq_collection_count03;
		SELF.inq_collection_count06 := inq_collection_count06;
		SELF.inq_collection_count12 := inq_collection_count12;
		SELF.inq_collection_count24 := inq_collection_count24;
		SELF.inq_highriskcredit_count := inq_highriskcredit_count;
		SELF.inq_highriskcredit_count01 := inq_highriskcredit_count01;
		SELF.inq_highriskcredit_count03 := inq_highriskcredit_count03;
		SELF.inq_highriskcredit_count06 := inq_highriskcredit_count06;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
		SELF.inq_quizprovider_count24 := inq_quizprovider_count24;
		SELF.inq_perssn := inq_perssn;
		SELF.inq_addrsperssn := inq_addrsperssn;
		SELF.pb_number_of_sources := pb_number_of_sources;
		SELF.pb_average_days_bt_orders := pb_average_days_bt_orders;
		SELF.pb_average_dollars := pb_average_dollars;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count := stl_inq_count;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_arrests := attr_arrests;
		SELF.attr_arrests30 := attr_arrests30;
		SELF.attr_arrests90 := attr_arrests90;
		SELF.attr_arrests180 := attr_arrests180;
		SELF.attr_arrests12 := attr_arrests12;
		SELF.attr_arrests24 := attr_arrests24;
		SELF.attr_arrests36 := attr_arrests36;
		SELF.attr_arrests60 := attr_arrests60;
		SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.fp_idverrisktype := fp_idverrisktype;
		SELF.fp_sourcerisktype := fp_sourcerisktype;
		SELF.fp_varrisktype := fp_varrisktype;
		SELF.fp_vardobcountnew := fp_vardobcountnew;
		SELF.fp_srchunvrfdphonecount := fp_srchunvrfdphonecount;
		SELF.fp_srchfraudsrchcountyr := fp_srchfraudsrchcountyr;
		SELF.fp_corrrisktype := fp_corrrisktype;
		SELF.fp_corrphonelastnamecount := fp_corrphonelastnamecount;
		SELF.fp_divssnidmsrcurelcount := fp_divssnidmsrcurelcount;
		SELF.fp_srchssnsrchcountmo := fp_srchssnsrchcountmo;
		SELF.fp_srchaddrsrchcountmo := fp_srchaddrsrchcountmo;
		SELF.fp_srchphonesrchcountmo := fp_srchphonesrchcountmo;
		SELF.fp_componentcharrisktype := fp_componentcharrisktype;
		SELF.fp_addrchangeincomediff := fp_addrchangeincomediff;
		SELF.fp_addrchangevaluediff := fp_addrchangevaluediff;
		SELF.fp_addrchangecrimediff := fp_addrchangecrimediff;
		SELF.fp_curraddractivephonelist := fp_curraddractivephonelist;
		SELF.fp_curraddrmedianincome := fp_curraddrmedianincome;
		SELF.fp_curraddrmedianvalue := fp_curraddrmedianvalue;
		SELF.fp_curraddrmurderindex := fp_curraddrmurderindex;
		SELF.fp_curraddrcartheftindex := fp_curraddrcartheftindex;
		SELF.fp_curraddrcrimeindex := fp_curraddrcrimeindex;
		SELF.fp_prevaddrageoldest := fp_prevaddrageoldest;
		SELF.fp_prevaddrlenofres := fp_prevaddrlenofres;
		SELF.fp_prevaddrcrimeindex := fp_prevaddrcrimeindex;
		SELF.criminal_count := criminal_count;
		SELF.criminal_last_date := criminal_last_date;
		SELF.felony_count := felony_count;
		SELF.felony_last_date := felony_last_date;
		SELF.hh_members_ct := hh_members_ct;
		SELF.hh_age_65_plus := hh_age_65_plus;
		SELF.hh_age_30_to_65 := hh_age_30_to_65;
		SELF.hh_age_18_to_30 := hh_age_18_to_30;
		SELF.hh_collections_ct := hh_collections_ct;
		SELF.hh_payday_loan_users := hh_payday_loan_users;
		SELF.hh_members_w_derog := hh_members_w_derog;
		SELF.hh_tot_derog := hh_tot_derog;
		SELF.hh_lienholders := hh_lienholders;
		SELF.hh_criminals := hh_criminals;
		SELF.rel_count := rel_count;
		SELF.rel_felony_count := rel_felony_count;
		SELF.crim_rel_within25miles := crim_rel_within25miles;
		SELF.crim_rel_within100miles := crim_rel_within100miles;
		SELF.crim_rel_within500miles := crim_rel_within500miles;
		SELF.rel_within25miles_count := rel_within25miles_count;
		SELF.rel_within100miles_count := rel_within100miles_count;
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
		SELF.historical_count := historical_count;
		SELF.inferred_age := inferred_age;
		SELF.estimated_income := estimated_income;
		SELF.C_INC_100K_P := C_INC_100K_P;
		SELF.C_INC_125K_P := C_INC_125K_P;
		SELF.C_INC_15K_P := C_INC_15K_P;
		SELF.C_INC_25K_P := C_INC_25K_P;
		SELF.C_INC_50K_P := C_INC_50K_P;
		SELF.C_RENTOCC_P := C_RENTOCC_P;
		SELF.c_ab_av_edu := c_ab_av_edu;
		SELF.c_amus_indx := c_amus_indx;
		SELF.c_asian_lang := c_asian_lang;
		SELF.c_bel_edu := c_bel_edu;
		SELF.c_blue_col := c_blue_col;
		SELF.c_blue_empl := c_blue_empl;
		SELF.c_born_usa := c_born_usa;
		SELF.c_cartheft := c_cartheft;
		SELF.c_civ_emp := c_civ_emp;
		SELF.c_construction := c_construction;
		SELF.c_easiqlife := c_easiqlife;
		SELF.c_families := c_families;
		SELF.c_femdiv_p := c_femdiv_p;
		SELF.c_food := c_food;
		SELF.c_health := c_health;
		SELF.c_hh1_p := c_hh1_p;
		SELF.c_hh2_p := c_hh2_p;
		SELF.c_hh4_p := c_hh4_p;
		SELF.c_hh5_p := c_hh5_p;
		SELF.c_high_ed := c_high_ed;
		SELF.c_highinc := c_highinc;
		SELF.c_hval_100k_p := c_hval_100k_p;
		SELF.c_hval_150k_p := c_hval_150k_p;
		SELF.c_hval_250k_p := c_hval_250k_p;
		SELF.c_hval_60k_p := c_hval_60k_p;
		SELF.c_hval_80k_p := c_hval_80k_p;
		SELF.c_larceny := c_larceny;
		SELF.c_lowrent := c_lowrent;
		SELF.c_many_cars := c_many_cars;
		SELF.c_med_age := c_med_age;
		SELF.c_med_rent := c_med_rent;
		SELF.c_med_yearblt := c_med_yearblt;
		SELF.c_medi_indx := c_medi_indx;
		SELF.c_mort_indx := c_mort_indx;
		SELF.c_no_car := c_no_car;
		SELF.c_no_labfor := c_no_labfor;
		SELF.c_no_move := c_no_move;
		SELF.c_occunit_p := c_occunit_p;
		SELF.c_old_homes := c_old_homes;
		SELF.c_pop_0_5_p := c_pop_0_5_p;
		SELF.c_pop_55_64_p := c_pop_55_64_p;
		SELF.c_pop_75_84_p := c_pop_75_84_p;
		SELF.c_popover18 := c_popover18;
		SELF.c_preschl := c_preschl;
		SELF.c_professional := c_professional;
		SELF.c_relig_indx := c_relig_indx;
		SELF.c_rental := c_rental;
		SELF.c_retired := c_retired;
		SELF.c_rnt750_p := c_rnt750_p;
		SELF.c_serv_empl := c_serv_empl;
		SELF.c_span_lang := c_span_lang;
		SELF.c_totcrime := c_totcrime;
		SELF.c_trailer := c_trailer;
		SELF.c_trailer_p := c_trailer_p;
		SELF.c_unattach := c_unattach;
		SELF.c_unemp := c_unemp;
		SELF.c_very_rich := c_very_rich;
		SELF.c_white_col := c_white_col;
		SELF.c_young := c_young;

		/* Model Intermediate Variables */
		// SELF.NULL := NULL;
		// SELF.INTEGER contains_i( string haystack, string needle ) := INTEGER contains_i( string haystack, string needle );
		SELF.sysdate := sysdate;
		SELF.k_inf_nothing_found_i := k_inf_nothing_found_i;
		SELF.r_f00_addr_not_ver_w_ssn_i := r_f00_addr_not_ver_w_ssn_i;
		SELF.r_s65_ssn_problem_i := r_s65_ssn_problem_i;
		SELF.r_p88_phn_dst_to_inp_add_i := r_p88_phn_dst_to_inp_add_i;
		SELF.r_f03_input_add_not_most_rec_i := r_f03_input_add_not_most_rec_i;
		SELF.r_f01_inp_addr_address_score_d := r_f01_inp_addr_address_score_d;
		SELF.r_d30_derog_count_i := r_d30_derog_count_i;
		SELF.r_d32_criminal_count_i := r_d32_criminal_count_i;
		SELF.r_d32_felony_count_i := r_d32_felony_count_i;
		SELF._criminal_last_date := _criminal_last_date;
		SELF.r_d32_mos_since_crim_ls_d := r_d32_mos_since_crim_ls_d;
		SELF._felony_last_date := _felony_last_date;
		SELF.r_d32_mos_since_fel_ls_d := r_d32_mos_since_fel_ls_d;
		SELF.r_d33_eviction_recency_d := r_d33_eviction_recency_d;
		SELF.r_d33_eviction_count_i := r_d33_eviction_count_i;
		SELF.bureau_adl_eq_fseen_pos := bureau_adl_eq_fseen_pos;
		SELF.bureau_adl_fseen_eq := bureau_adl_fseen_eq;
		SELF._bureau_adl_fseen_eq := _bureau_adl_fseen_eq;
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
		SELF._src_bureau_adl_fseen_notu := _src_bureau_adl_fseen_notu;
		SELF.f_m_bureau_adl_fs_notu_d := f_m_bureau_adl_fs_notu_d;
		SELF.r_c12_num_nonderogs_d := r_c12_num_nonderogs_d;
		SELF.r_s66_adlperssn_count_i := r_s66_adlperssn_count_i;
		SELF._in_dob := _in_dob;
		SELF.yr_in_dob := yr_in_dob;
		SELF.yr_in_dob_int := yr_in_dob_int;
		SELF.k_comb_age_d := k_comb_age_d;
		SELF.r_l80_inp_avm_autoval_d := r_l80_inp_avm_autoval_d;
		SELF.r_a49_curr_avm_chg_1yr_pct_i := r_a49_curr_avm_chg_1yr_pct_i;
		SELF.r_c13_curr_addr_lres_d := r_c13_curr_addr_lres_d;
		SELF.r_c13_max_lres_d := r_c13_max_lres_d;
		SELF.r_c14_addrs_5yr_i := r_c14_addrs_5yr_i;
		SELF.r_c14_addrs_per_adl_c6_i := r_c14_addrs_per_adl_c6_i;
		SELF.r_c14_addrs_15yr_i := r_c14_addrs_15yr_i;
		SELF.r_l79_adls_per_addr_curr_i := r_l79_adls_per_addr_curr_i;
		SELF.r_l79_adls_per_addr_c6_i := r_l79_adls_per_addr_c6_i;
		SELF.r_a50_pb_average_dollars_d := r_a50_pb_average_dollars_d;
		SELF.r_pb_order_freq_d := r_pb_order_freq_d;
		SELF.r_i60_inq_count12_i := r_i60_inq_count12_i;
		SELF.r_i61_inq_collection_count12_i := r_i61_inq_collection_count12_i;
		SELF.r_i61_inq_collection_recency_d := r_i61_inq_collection_recency_d;
		SELF.r_i60_inq_hiriskcred_count12_i := r_i60_inq_hiriskcred_count12_i;
		SELF.r_i60_inq_hiriskcred_recency_d := r_i60_inq_hiriskcred_recency_d;
		SELF.f_util_adl_count_n := f_util_adl_count_n;
		SELF.f_util_add_curr_inf_n := f_util_add_curr_inf_n;
		SELF.add_input_nhood_prop_sum := add_input_nhood_prop_sum;
		SELF.f_add_input_nhood_bus_pct_i := f_add_input_nhood_bus_pct_i;
		SELF.add_curr_nhood_prop_sum_3 := add_curr_nhood_prop_sum_3;
		SELF.f_add_curr_nhood_bus_pct_i := f_add_curr_nhood_bus_pct_i;
		SELF.add_curr_nhood_prop_sum_2 := add_curr_nhood_prop_sum_2;
		SELF.f_add_curr_nhood_mfd_pct_i := f_add_curr_nhood_mfd_pct_i;
		SELF.add_curr_nhood_prop_sum_1 := add_curr_nhood_prop_sum_1;
		SELF.f_add_curr_nhood_sfd_pct_d := f_add_curr_nhood_sfd_pct_d;
		SELF.add_curr_nhood_prop_sum := add_curr_nhood_prop_sum;
		SELF.f_add_curr_nhood_vac_pct_i := f_add_curr_nhood_vac_pct_i;
		SELF.f_inq_count24_i := f_inq_count24_i;
		SELF.f_inq_collection_count24_i := f_inq_collection_count24_i;
		SELF.f_inq_highriskcredit_count24_i := f_inq_highriskcredit_count24_i;
		SELF.k_inq_per_ssn_i := k_inq_per_ssn_i;
		SELF.k_inq_addrs_per_ssn_i := k_inq_addrs_per_ssn_i;
		SELF.f_attr_arrests_i := f_attr_arrests_i;
		SELF.f_attr_arrest_recency_d := f_attr_arrest_recency_d;
		SELF.k_estimated_income_d := k_estimated_income_d;
		SELF.f_rel_count_i := f_rel_count_i;
		SELF.f_rel_incomeover50_count_d := f_rel_incomeover50_count_d;
		SELF.f_rel_homeover50_count_d := f_rel_homeover50_count_d;
		SELF.f_rel_homeover150_count_d := f_rel_homeover150_count_d;
		SELF.f_rel_homeover200_count_d := f_rel_homeover200_count_d;
		SELF.f_rel_ageover20_count_d := f_rel_ageover20_count_d;
		SELF.f_rel_educationover8_count_d := f_rel_educationover8_count_d;
		SELF.f_rel_educationover12_count_d := f_rel_educationover12_count_d;
		SELF.f_crim_rel_under25miles_cnt_i := f_crim_rel_under25miles_cnt_i;
		SELF.f_crim_rel_under500miles_cnt_i := f_crim_rel_under500miles_cnt_i;
		SELF.f_rel_under100miles_cnt_d := f_rel_under100miles_cnt_d;
		SELF.f_historical_count_d := f_historical_count_d;
		SELF.f_idverrisktype_i := f_idverrisktype_i;
		SELF.f_sourcerisktype_i := f_sourcerisktype_i;
		SELF.f_varrisktype_i := f_varrisktype_i;
		SELF.f_vardobcountnew_i := f_vardobcountnew_i;
		SELF.f_srchunvrfdphonecount_i := f_srchunvrfdphonecount_i;
		SELF.f_corrrisktype_i := f_corrrisktype_i;
		SELF.f_corrphonelastnamecount_d := f_corrphonelastnamecount_d;
		SELF.f_divssnidmsrcurelcount_i := f_divssnidmsrcurelcount_i;
		SELF.f_componentcharrisktype_i := f_componentcharrisktype_i;
		SELF.f_addrchangeincomediff_d_1 := f_addrchangeincomediff_d_1;
		SELF.f_addrchangeincomediff_d := f_addrchangeincomediff_d;
		SELF.f_addrchangevaluediff_d := f_addrchangevaluediff_d;
		SELF.f_addrchangecrimediff_i := f_addrchangecrimediff_i;
		SELF.f_curraddractivephonelist_d := f_curraddractivephonelist_d;
		SELF.f_curraddrmedianincome_d := f_curraddrmedianincome_d;
		SELF.f_curraddrmedianvalue_d := f_curraddrmedianvalue_d;
		SELF.f_curraddrmurderindex_i := f_curraddrmurderindex_i;
		SELF.f_curraddrcartheftindex_i := f_curraddrcartheftindex_i;
		SELF.f_curraddrcrimeindex_i := f_curraddrcrimeindex_i;
		SELF.f_prevaddrageoldest_d := f_prevaddrageoldest_d;
		SELF.f_prevaddrlenofres_d := f_prevaddrlenofres_d;
		SELF.f_fp_prevaddrcrimeindex_i := f_fp_prevaddrcrimeindex_i;
		SELF.r_c23_inp_addr_occ_index_d := r_c23_inp_addr_occ_index_d;
		SELF.r_c23_inp_addr_owned_not_occ_d := r_c23_inp_addr_owned_not_occ_d;
		SELF.r_f04_curr_add_occ_index_d := r_f04_curr_add_occ_index_d;
		SELF.f_phone_ver_insurance_d := f_phone_ver_insurance_d;
		SELF.f_addrs_per_ssn_i := f_addrs_per_ssn_i;
		SELF.f_phones_per_addr_curr_i := f_phones_per_addr_curr_i;
		SELF.f_addrs_per_ssn_c6_i := f_addrs_per_ssn_c6_i;
		SELF.f_phones_per_addr_c6_i := f_phones_per_addr_c6_i;
		SELF.f_inq_quizprovider_count24_i := f_inq_quizprovider_count24_i;
		SELF.f_hh_members_ct_d := f_hh_members_ct_d;
		SELF.f_hh_age_18_plus_d := f_hh_age_18_plus_d;
		SELF.f_hh_collections_ct_i := f_hh_collections_ct_i;
		SELF.f_hh_tot_derog_i := f_hh_tot_derog_i;
		SELF.f_hh_lienholders_i := f_hh_lienholders_i;
		SELF._ver_src_ds := _ver_src_ds;
		SELF._ver_src_de := _ver_src_de;
		SELF._ver_src_eq := _ver_src_eq;
		SELF._ver_src_en := _ver_src_en;
		SELF._ver_src_tn := _ver_src_tn;
		SELF._ver_src_tu := _ver_src_tu;
		SELF._credit_source_cnt := _credit_source_cnt;
		SELF._ver_src_cnt := _ver_src_cnt;
		SELF._bureauonly := _bureauonly;
		SELF._derog := _derog;
		SELF._deceased := _deceased;
		SELF._ssnpriortodob := _ssnpriortodob;
		SELF._inputmiskeys := _inputmiskeys;
		SELF._multiplessns := _multiplessns;
		SELF._hh_strikes := _hh_strikes;
		SELF.nf_seg_fraudpoint_3_0 := nf_seg_fraudpoint_3_0;
		SELF.final_score_0 := final_score_0;
		SELF.final_score_1_c106 := final_score_1_c106;
		SELF.final_score_1_c107 := final_score_1_c107;
		SELF.final_score_1 := final_score_1;
		SELF.final_score_2_c109 := final_score_2_c109;
		SELF.final_score_2_c110 := final_score_2_c110;
		SELF.final_score_2 := final_score_2;
		SELF.final_score_3_c113 := final_score_3_c113;
		SELF.final_score_3_c112 := final_score_3_c112;
		SELF.final_score_3 := final_score_3;
		SELF.final_score_4_c116 := final_score_4_c116;
		SELF.final_score_4_c115 := final_score_4_c115;
		SELF.final_score_4 := final_score_4;
		SELF.final_score_5_c118 := final_score_5_c118;
		SELF.final_score_5_c119 := final_score_5_c119;
		SELF.final_score_5 := final_score_5;
		SELF.final_score_6_c121 := final_score_6_c121;
		SELF.final_score_6_c122 := final_score_6_c122;
		SELF.final_score_6 := final_score_6;
		SELF.final_score_7_c124 := final_score_7_c124;
		SELF.final_score_7_c125 := final_score_7_c125;
		SELF.final_score_7 := final_score_7;
		SELF.final_score_8_c128 := final_score_8_c128;
		SELF.final_score_8_c127 := final_score_8_c127;
		SELF.final_score_8 := final_score_8;
		SELF.final_score_9_c130 := final_score_9_c130;
		SELF.final_score_9_c131 := final_score_9_c131;
		SELF.final_score_9 := final_score_9;
		SELF.final_score_10_c134 := final_score_10_c134;
		SELF.final_score_10_c133 := final_score_10_c133;
		SELF.final_score_10 := final_score_10;
		SELF.final_score_11_c137 := final_score_11_c137;
		SELF.final_score_11_c136 := final_score_11_c136;
		SELF.final_score_11 := final_score_11;
		SELF.final_score_12_c140 := final_score_12_c140;
		SELF.final_score_12_c139 := final_score_12_c139;
		SELF.final_score_12 := final_score_12;
		SELF.final_score_13_c143 := final_score_13_c143;
		SELF.final_score_13_c142 := final_score_13_c142;
		SELF.final_score_13 := final_score_13;
		SELF.final_score_14_c146 := final_score_14_c146;
		SELF.final_score_14_c145 := final_score_14_c145;
		SELF.final_score_14 := final_score_14;
		SELF.final_score_15_c149 := final_score_15_c149;
		SELF.final_score_15_c148 := final_score_15_c148;
		SELF.final_score_15 := final_score_15;
		SELF.final_score_16_c152 := final_score_16_c152;
		SELF.final_score_16_c151 := final_score_16_c151;
		SELF.final_score_16 := final_score_16;
		SELF.final_score_17_c155 := final_score_17_c155;
		SELF.final_score_17_c154 := final_score_17_c154;
		SELF.final_score_17 := final_score_17;
		SELF.final_score_18_c158 := final_score_18_c158;
		SELF.final_score_18_c157 := final_score_18_c157;
		SELF.final_score_18 := final_score_18;
		SELF.final_score_19_c161 := final_score_19_c161;
		SELF.final_score_19_c160 := final_score_19_c160;
		SELF.final_score_19 := final_score_19;
		SELF.final_score_20_c164 := final_score_20_c164;
		SELF.final_score_20_c163 := final_score_20_c163;
		SELF.final_score_20 := final_score_20;
		SELF.final_score_21_c167 := final_score_21_c167;
		SELF.final_score_21_c166 := final_score_21_c166;
		SELF.final_score_21 := final_score_21;
		SELF.final_score_22_c169 := final_score_22_c169;
		SELF.final_score_22_c170 := final_score_22_c170;
		SELF.final_score_22 := final_score_22;
		SELF.final_score_23_c172 := final_score_23_c172;
		SELF.final_score_23_c173 := final_score_23_c173;
		SELF.final_score_23 := final_score_23;
		SELF.final_score_24_c176 := final_score_24_c176;
		SELF.final_score_24_c175 := final_score_24_c175;
		SELF.final_score_24 := final_score_24;
		SELF.final_score_25_c179 := final_score_25_c179;
		SELF.final_score_25_c178 := final_score_25_c178;
		SELF.final_score_25 := final_score_25;
		SELF.final_score_26_c182 := final_score_26_c182;
		SELF.final_score_26_c181 := final_score_26_c181;
		SELF.final_score_26 := final_score_26;
		SELF.final_score_27_c185 := final_score_27_c185;
		SELF.final_score_27_c184 := final_score_27_c184;
		SELF.final_score_27 := final_score_27;
		SELF.final_score_28_c188 := final_score_28_c188;
		SELF.final_score_28_c187 := final_score_28_c187;
		SELF.final_score_28 := final_score_28;
		SELF.final_score_29_c191 := final_score_29_c191;
		SELF.final_score_29_c190 := final_score_29_c190;
		SELF.final_score_29 := final_score_29;
		SELF.final_score_30_c193 := final_score_30_c193;
		SELF.final_score_30_c194 := final_score_30_c194;
		SELF.final_score_30 := final_score_30;
		SELF.final_score_31_c197 := final_score_31_c197;
		SELF.final_score_31_c196 := final_score_31_c196;
		SELF.final_score_31 := final_score_31;
		SELF.final_score_32_c200 := final_score_32_c200;
		SELF.final_score_32_c199 := final_score_32_c199;
		SELF.final_score_32 := final_score_32;
		SELF.final_score_33_c203 := final_score_33_c203;
		SELF.final_score_33_c202 := final_score_33_c202;
		SELF.final_score_33 := final_score_33;
		SELF.final_score_34_c206 := final_score_34_c206;
		SELF.final_score_34_c205 := final_score_34_c205;
		SELF.final_score_34 := final_score_34;
		SELF.final_score_35_c209 := final_score_35_c209;
		SELF.final_score_35_c208 := final_score_35_c208;
		SELF.final_score_35 := final_score_35;
		SELF.final_score_36_c212 := final_score_36_c212;
		SELF.final_score_36_c211 := final_score_36_c211;
		SELF.final_score_36 := final_score_36;
		SELF.final_score_37_c214 := final_score_37_c214;
		SELF.final_score_37_c215 := final_score_37_c215;
		SELF.final_score_37 := final_score_37;
		SELF.final_score_38_c218 := final_score_38_c218;
		SELF.final_score_38_c217 := final_score_38_c217;
		SELF.final_score_38 := final_score_38;
		SELF.final_score_39_c221 := final_score_39_c221;
		SELF.final_score_39_c220 := final_score_39_c220;
		SELF.final_score_39 := final_score_39;
		SELF.final_score_40_c223 := final_score_40_c223;
		SELF.final_score_40_c224 := final_score_40_c224;
		SELF.final_score_40 := final_score_40;
		SELF.final_score_41_c227 := final_score_41_c227;
		SELF.final_score_41_c226 := final_score_41_c226;
		SELF.final_score_41 := final_score_41;
		SELF.final_score_42_c229 := final_score_42_c229;
		SELF.final_score_42_c230 := final_score_42_c230;
		SELF.final_score_42 := final_score_42;
		SELF.final_score_43_c232 := final_score_43_c232;
		SELF.final_score_43_c233 := final_score_43_c233;
		SELF.final_score_43 := final_score_43;
		SELF.final_score_44_c236 := final_score_44_c236;
		SELF.final_score_44_c235 := final_score_44_c235;
		SELF.final_score_44 := final_score_44;
		SELF.final_score_45_c238 := final_score_45_c238;
		SELF.final_score_45_c239 := final_score_45_c239;
		SELF.final_score_45 := final_score_45;
		SELF.final_score_46_c242 := final_score_46_c242;
		SELF.final_score_46_c241 := final_score_46_c241;
		SELF.final_score_46 := final_score_46;
		SELF.final_score_47_c244 := final_score_47_c244;
		SELF.final_score_47_c245 := final_score_47_c245;
		SELF.final_score_47 := final_score_47;
		SELF.final_score_48_c247 := final_score_48_c247;
		SELF.final_score_48_c248 := final_score_48_c248;
		SELF.final_score_48 := final_score_48;
		SELF.final_score_49_c251 := final_score_49_c251;
		SELF.final_score_49_c250 := final_score_49_c250;
		SELF.final_score_49 := final_score_49;
		SELF.final_score_50_c253 := final_score_50_c253;
		SELF.final_score_50_c254 := final_score_50_c254;
		SELF.final_score_50 := final_score_50;
		SELF.final_score_51_c256 := final_score_51_c256;
		SELF.final_score_51_c257 := final_score_51_c257;
		SELF.final_score_51 := final_score_51;
		SELF.final_score_52_c260 := final_score_52_c260;
		SELF.final_score_52_c259 := final_score_52_c259;
		SELF.final_score_52 := final_score_52;
		SELF.final_score_53_c263 := final_score_53_c263;
		SELF.final_score_53_c262 := final_score_53_c262;
		SELF.final_score_53 := final_score_53;
		SELF.final_score_54_c266 := final_score_54_c266;
		SELF.final_score_54_c265 := final_score_54_c265;
		SELF.final_score_54 := final_score_54;
		SELF.final_score_55_c269 := final_score_55_c269;
		SELF.final_score_55_c268 := final_score_55_c268;
		SELF.final_score_55 := final_score_55;
		SELF.final_score_56_c272 := final_score_56_c272;
		SELF.final_score_56_c271 := final_score_56_c271;
		SELF.final_score_56 := final_score_56;
		SELF.final_score_57_c274 := final_score_57_c274;
		SELF.final_score_57_c275 := final_score_57_c275;
		SELF.final_score_57 := final_score_57;
		SELF.final_score_58_c277 := final_score_58_c277;
		SELF.final_score_58_c278 := final_score_58_c278;
		SELF.final_score_58 := final_score_58;
		SELF.final_score_59_c280 := final_score_59_c280;
		SELF.final_score_59_c281 := final_score_59_c281;
		SELF.final_score_59 := final_score_59;
		SELF.final_score_60_c283 := final_score_60_c283;
		SELF.final_score_60_c284 := final_score_60_c284;
		SELF.final_score_60 := final_score_60;
		SELF.final_score_61_c287 := final_score_61_c287;
		SELF.final_score_61_c286 := final_score_61_c286;
		SELF.final_score_61 := final_score_61;
		SELF.final_score_62_c290 := final_score_62_c290;
		SELF.final_score_62_c289 := final_score_62_c289;
		SELF.final_score_62 := final_score_62;
		SELF.final_score_63_c292 := final_score_63_c292;
		SELF.final_score_63_c293 := final_score_63_c293;
		SELF.final_score_63 := final_score_63;
		SELF.final_score_64_c296 := final_score_64_c296;
		SELF.final_score_64_c295 := final_score_64_c295;
		SELF.final_score_64 := final_score_64;
		SELF.final_score_65_c298 := final_score_65_c298;
		SELF.final_score_65_c299 := final_score_65_c299;
		SELF.final_score_65 := final_score_65;
		SELF.final_score_66_c302 := final_score_66_c302;
		SELF.final_score_66_c301 := final_score_66_c301;
		SELF.final_score_66 := final_score_66;
		SELF.final_score_67_c305 := final_score_67_c305;
		SELF.final_score_67_c304 := final_score_67_c304;
		SELF.final_score_67 := final_score_67;
		SELF.final_score_68_c308 := final_score_68_c308;
		SELF.final_score_68_c307 := final_score_68_c307;
		SELF.final_score_68 := final_score_68;
		SELF.final_score_69_c310 := final_score_69_c310;
		SELF.final_score_69_c311 := final_score_69_c311;
		SELF.final_score_69 := final_score_69;
		SELF.final_score_70_c313 := final_score_70_c313;
		SELF.final_score_70_c314 := final_score_70_c314;
		SELF.final_score_70 := final_score_70;
		SELF.final_score_71_c317 := final_score_71_c317;
		SELF.final_score_71_c316 := final_score_71_c316;
		SELF.final_score_71 := final_score_71;
		SELF.final_score_72_c320 := final_score_72_c320;
		SELF.final_score_72_c319 := final_score_72_c319;
		SELF.final_score_72 := final_score_72;
		SELF.final_score_73_c323 := final_score_73_c323;
		SELF.final_score_73_c322 := final_score_73_c322;
		SELF.final_score_73 := final_score_73;
		SELF.final_score_74_c326 := final_score_74_c326;
		SELF.final_score_74_c325 := final_score_74_c325;
		SELF.final_score_74 := final_score_74;
		SELF.final_score_75_c329 := final_score_75_c329;
		SELF.final_score_75_c328 := final_score_75_c328;
		SELF.final_score_75 := final_score_75;
		SELF.final_score_76_c331 := final_score_76_c331;
		SELF.final_score_76_c332 := final_score_76_c332;
		SELF.final_score_76 := final_score_76;
		SELF.final_score_77_c335 := final_score_77_c335;
		SELF.final_score_77_c334 := final_score_77_c334;
		SELF.final_score_77 := final_score_77;
		SELF.final_score_78_c338 := final_score_78_c338;
		SELF.final_score_78_c337 := final_score_78_c337;
		SELF.final_score_78 := final_score_78;
		SELF.final_score_79_c341 := final_score_79_c341;
		SELF.final_score_79_c340 := final_score_79_c340;
		SELF.final_score_79 := final_score_79;
		SELF.final_score_80_c344 := final_score_80_c344;
		SELF.final_score_80_c343 := final_score_80_c343;
		SELF.final_score_80 := final_score_80;
		SELF.final_score_81_c347 := final_score_81_c347;
		SELF.final_score_81_c346 := final_score_81_c346;
		SELF.final_score_81 := final_score_81;
		SELF.final_score_82_c350 := final_score_82_c350;
		SELF.final_score_82_c349 := final_score_82_c349;
		SELF.final_score_82 := final_score_82;
		SELF.final_score_83_c352 := final_score_83_c352;
		SELF.final_score_83_c353 := final_score_83_c353;
		SELF.final_score_83 := final_score_83;
		SELF.final_score_84_c356 := final_score_84_c356;
		SELF.final_score_84_c355 := final_score_84_c355;
		SELF.final_score_84 := final_score_84;
		SELF.final_score_85_c358 := final_score_85_c358;
		SELF.final_score_85_c359 := final_score_85_c359;
		SELF.final_score_85 := final_score_85;
		SELF.final_score_86_c362 := final_score_86_c362;
		SELF.final_score_86_c361 := final_score_86_c361;
		SELF.final_score_86 := final_score_86;
		SELF.final_score_87_c365 := final_score_87_c365;
		SELF.final_score_87_c364 := final_score_87_c364;
		SELF.final_score_87 := final_score_87;
		SELF.final_score_88_c368 := final_score_88_c368;
		SELF.final_score_88_c367 := final_score_88_c367;
		SELF.final_score_88 := final_score_88;
		SELF.final_score_89_c370 := final_score_89_c370;
		SELF.final_score_89_c371 := final_score_89_c371;
		SELF.final_score_89 := final_score_89;
		SELF.final_score_90_c373 := final_score_90_c373;
		SELF.final_score_90_c374 := final_score_90_c374;
		SELF.final_score_90 := final_score_90;
		SELF.final_score_91_c377 := final_score_91_c377;
		SELF.final_score_91_c376 := final_score_91_c376;
		SELF.final_score_91 := final_score_91;
		SELF.final_score_92_c380 := final_score_92_c380;
		SELF.final_score_92_c379 := final_score_92_c379;
		SELF.final_score_92 := final_score_92;
		SELF.final_score_93_c383 := final_score_93_c383;
		SELF.final_score_93_c382 := final_score_93_c382;
		SELF.final_score_93 := final_score_93;
		SELF.final_score_94_c386 := final_score_94_c386;
		SELF.final_score_94_c385 := final_score_94_c385;
		SELF.final_score_94 := final_score_94;
		SELF.final_score_95_c389 := final_score_95_c389;
		SELF.final_score_95_c388 := final_score_95_c388;
		SELF.final_score_95 := final_score_95;
		SELF.final_score_96_c392 := final_score_96_c392;
		SELF.final_score_96_c391 := final_score_96_c391;
		SELF.final_score_96 := final_score_96;
		SELF.final_score_97_c395 := final_score_97_c395;
		SELF.final_score_97_c394 := final_score_97_c394;
		SELF.final_score_97 := final_score_97;
		SELF.final_score_98_c397 := final_score_98_c397;
		SELF.final_score_98_c398 := final_score_98_c398;
		SELF.final_score_98 := final_score_98;
		SELF.final_score_99_c401 := final_score_99_c401;
		SELF.final_score_99_c400 := final_score_99_c400;
		SELF.final_score_99 := final_score_99;
		SELF.final_score_100_c403 := final_score_100_c403;
		SELF.final_score_100_c404 := final_score_100_c404;
		SELF.final_score_100 := final_score_100;
		SELF.final_score_101_c407 := final_score_101_c407;
		SELF.final_score_101_c406 := final_score_101_c406;
		SELF.final_score_101 := final_score_101;
		SELF.final_score_102_c410 := final_score_102_c410;
		SELF.final_score_102_c409 := final_score_102_c409;
		SELF.final_score_102 := final_score_102;
		SELF.final_score_103_c413 := final_score_103_c413;
		SELF.final_score_103_c412 := final_score_103_c412;
		SELF.final_score_103 := final_score_103;
		SELF.final_score_104_c416 := final_score_104_c416;
		SELF.final_score_104_c415 := final_score_104_c415;
		SELF.final_score_104 := final_score_104;
		SELF.final_score_105_c419 := final_score_105_c419;
		SELF.final_score_105_c418 := final_score_105_c418;
		SELF.final_score_105 := final_score_105;
		SELF.final_score_106_c421 := final_score_106_c421;
		SELF.final_score_106_c422 := final_score_106_c422;
		SELF.final_score_106 := final_score_106;
		SELF.final_score_107_c425 := final_score_107_c425;
		SELF.final_score_107_c424 := final_score_107_c424;
		SELF.final_score_107 := final_score_107;
		SELF.final_score_108_c428 := final_score_108_c428;
		SELF.final_score_108_c427 := final_score_108_c427;
		SELF.final_score_108 := final_score_108;
		SELF.final_score_109_c431 := final_score_109_c431;
		SELF.final_score_109_c430 := final_score_109_c430;
		SELF.final_score_109 := final_score_109;
		SELF.final_score_110_c433 := final_score_110_c433;
		SELF.final_score_110_c434 := final_score_110_c434;
		SELF.final_score_110 := final_score_110;
		SELF.final_score_111_c437 := final_score_111_c437;
		SELF.final_score_111_c436 := final_score_111_c436;
		SELF.final_score_111 := final_score_111;
		SELF.final_score_112_c440 := final_score_112_c440;
		SELF.final_score_112_c439 := final_score_112_c439;
		SELF.final_score_112 := final_score_112;
		SELF.final_score_113_c443 := final_score_113_c443;
		SELF.final_score_113_c442 := final_score_113_c442;
		SELF.final_score_113 := final_score_113;
		SELF.final_score_114_c446 := final_score_114_c446;
		SELF.final_score_114_c445 := final_score_114_c445;
		SELF.final_score_114 := final_score_114;
		SELF.final_score_115_c449 := final_score_115_c449;
		SELF.final_score_115_c448 := final_score_115_c448;
		SELF.final_score_115 := final_score_115;
		SELF.final_score_116_c452 := final_score_116_c452;
		SELF.final_score_116_c451 := final_score_116_c451;
		SELF.final_score_116 := final_score_116;
		SELF.final_score_117_c455 := final_score_117_c455;
		SELF.final_score_117_c454 := final_score_117_c454;
		SELF.final_score_117 := final_score_117;
		SELF.final_score_118_c457 := final_score_118_c457;
		SELF.final_score_118_c458 := final_score_118_c458;
		SELF.final_score_118 := final_score_118;
		SELF.final_score_119_c461 := final_score_119_c461;
		SELF.final_score_119_c460 := final_score_119_c460;
		SELF.final_score_119 := final_score_119;
		SELF.final_score_120_c463 := final_score_120_c463;
		SELF.final_score_120_c464 := final_score_120_c464;
		SELF.final_score_120 := final_score_120;
		SELF.final_score_121_c467 := final_score_121_c467;
		SELF.final_score_121_c466 := final_score_121_c466;
		SELF.final_score_121 := final_score_121;
		SELF.final_score_122_c470 := final_score_122_c470;
		SELF.final_score_122_c469 := final_score_122_c469;
		SELF.final_score_122 := final_score_122;
		SELF.final_score_123_c473 := final_score_123_c473;
		SELF.final_score_123_c472 := final_score_123_c472;
		SELF.final_score_123 := final_score_123;
		SELF.final_score_124_c476 := final_score_124_c476;
		SELF.final_score_124_c475 := final_score_124_c475;
		SELF.final_score_124 := final_score_124;
		SELF.final_score_125_c478 := final_score_125_c478;
		SELF.final_score_125_c479 := final_score_125_c479;
		SELF.final_score_125 := final_score_125;
		SELF.final_score_126_c482 := final_score_126_c482;
		SELF.final_score_126_c481 := final_score_126_c481;
		SELF.final_score_126 := final_score_126;
		SELF.final_score_127_c485 := final_score_127_c485;
		SELF.final_score_127_c484 := final_score_127_c484;
		SELF.final_score_127 := final_score_127;
		SELF.final_score_128_c488 := final_score_128_c488;
		SELF.final_score_128_c487 := final_score_128_c487;
		SELF.final_score_128 := final_score_128;
		SELF.final_score_129_c491 := final_score_129_c491;
		SELF.final_score_129_c490 := final_score_129_c490;
		SELF.final_score_129 := final_score_129;
		SELF.final_score_130_c494 := final_score_130_c494;
		SELF.final_score_130_c493 := final_score_130_c493;
		SELF.final_score_130 := final_score_130;
		SELF.final_score_131_c497 := final_score_131_c497;
		SELF.final_score_131_c496 := final_score_131_c496;
		SELF.final_score_131 := final_score_131;
		SELF.final_score_132_c500 := final_score_132_c500;
		SELF.final_score_132_c499 := final_score_132_c499;
		SELF.final_score_132 := final_score_132;
		SELF.final_score := final_score;
		SELF.pbr := pbr;
		SELF.sbr := sbr;
		SELF.offset := offset;
		SELF.base := base;
		SELF.pts := pts;
		SELF.lgt := lgt;
		SELF.fp1512_1_0 := fp1512_1_0;

		SELF.clam := le;
#end

	self.seq := le.seq;
  ritmp := Models.fraudpoint3_reasons( le, blank_ip, num_reasons, , , nf_seg_fraudpoint_3_0 );
	reasons := Models.Common.checkFraudPoint3RC34(fp1512_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1512_1_0;
	
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
		,keep(1));
	
	return model;
END;
